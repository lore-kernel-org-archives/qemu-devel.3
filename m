Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393C5C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woiDL-0006rr-33; Tue, 28 Jul 2026 09:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woiDF-0006qr-Og
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:51:19 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woiDD-0000yL-EP
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:51:17 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-66899fe9077so6103448d50.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 06:51:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785246674; cv=none;
 d=google.com; s=arc-20260327;
 b=NnqlGDdfize62d4hzuWrR8j5Y1zMNvTN4e+PXF1xMdzvnPbYq0kuuJIczidvMczB94
 T+tWOqrvuNI2fgpgoU+JlIbnaGmC2UiPve+EJqVjMMcKaV5D745CZSGrKFnh/h4EXV82
 ImBV2Vr7Ca4h5DeNThfTnj/GPnRvqeU5qfoAaxicrMZ//zWejFmk7jjfjs6tOWiXzLrt
 itBM8gxXEmEiBoMZ8oua5ylSJybV0SP1EEIxImW89fEw1pUxdxkCdi6v0CTSMTix7mM4
 jdrK01oPbLb481y75tCONML7Vy4AKDwQpnjd1Apt/GgfD2rHs/hTmQT747DmtwUXuQaV
 fOVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VUF6gdhJPTyY3KgZ1fqwT3T8avqTRIo/g3y1DdJllsg=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=mCfxmuRneFTGAyURPVrjoNib1OQTwPCwktfz79+vhfvXtVUxn/InjR3gGmipkTi6N1
 +tAMq6JeFQu6gH13KxlhXle2sdvcU2J8Zu8nYMJxcvK81YkGz7rOgYL6GanVY6JuLKMf
 ipmrRdmO+Ilnj+pBr1V880ODlNps6WBKqxgcSZs5xq64M96+drk1lU/bj6YWQ4nJcOqH
 mmqnHmknXtMDFItBypjJ/ebXf1xS4/O1IpvDkTb75wZvUVUH7k0A1b0z2dW/Lv0E6rOa
 Ajs3fuU0vn5zvpK2MhFn25yx/IDoww8R4IFxgrGFlyh9MKPwYeDTYaiQC23sN723NYqL
 m1HQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785246674; x=1785851474; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VUF6gdhJPTyY3KgZ1fqwT3T8avqTRIo/g3y1DdJllsg=;
 b=pFBJsq0XxzZqosCdnoZh4KCBPTFk+UQuARlv1f3hYwnQDDPheTZtiNjjw5QbjCdRHF
 KIqOY9LAcywEj5wv/9VFJnhLfufLWgFfWQSXQPvFQlArYgsjvFN0rFXsdboCXrgU2zWL
 o5oSLK/hgtVbK+Ya0tsbdxQsrAnDOFX+2EhAPBhcI1/qH426P0/jUdrkIkc3hEk0h21A
 xLTu2sH+94FI+/dJGSSUR6PRJ5CJhUMW/nIgEr0y8Scm1/RHqx242hGzdgflmkBnmzAv
 kR5HaOCANF121BjyTHxrGr5NMpYwXjSr/LtHcmAo6zTumIHhaxTLZo/Ii7aoDMxF8sj0
 F+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785246674; x=1785851474;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VUF6gdhJPTyY3KgZ1fqwT3T8avqTRIo/g3y1DdJllsg=;
 b=kesaP0/w85uZkLIGr2NzoyMvMfZ2DddKQQpw2ChlpcZhkzOeLykkWI9JFNsAbe3G01
 NKVIUkUtN/VbOuw8JBOArDS7YJLOBnWA2ceXqyCjgOulpX3/J5gDmZqA+P54cLHDB6P5
 ghCrpN4x5zYVA3DOEe7khIVXiCV2ACU1H18yh/UD2ESgrlFeQSglIADcr2mujhlZ9DKD
 e00WhHvryQl0y+Ibz0YpB/MnuKUqup2zpCZbr4fK883LuWh95aXiAIRZ2bxuIpLjIDe1
 Wg8siaa8MUgeeHXwCtMf+okDRhCXU/raVbZpjEx+Vfcu+SpIYhMS9PJiYSD4YerG4l4e
 QeFg==
X-Gm-Message-State: AOJu0YwzH/BPWPuOGF3jiyVw5bqj5lNaRnds1v4tkZ5FVizv67me/ebb
 yF5l1ezZOaz++/zc87Aex26iKFsNIOAXxxvhI7Biy+KKlVtvatUFpQBxStJkFGGJeVxQailxCa6
 cIp1s1TxhXvRnX8tLfqib6K7Mq+0NE3q4Arq77Om82A==
X-Gm-Gg: AR+sD11d0qrNlUy+wWiLYR9dRkfy66peJzcR0zF4hJXWgfocr+ahtVDrrwmGrNO2m90
 0IDBAJnM0GHYlOdRRmObrChfsP2gvmulYSXIVIqIUHOb44sPkumG+MYD96geoLsVawrGg4M+PfU
 05riLNai2i3+rPAmXBxas4J2kNeb51xsIkHVEJBX9kKkABt5TYNratrrUpKCnFsm73VbLFttT2q
 taeaTCqeq+mGgvxNBQun0rJGxPWfc1bOzWXBrxb0Cs8U/8WvQiuTJpwSC2eKvvdk623BioBZ+7Q
 KSSBC23H+G0k85Elng0dfEQReQkI4WCQOotps6MStkzONQ==
X-Received: by 2002:a05:690e:4504:10b0:668:434d:a2f5 with SMTP id
 956f58d0204a3-669054c1f61mr688018d50.1.1785246673854; Tue, 28 Jul 2026
 06:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260717232306.378988-1-richard.henderson@linaro.org>
 <20260717232306.378988-5-richard.henderson@linaro.org>
In-Reply-To: <20260717232306.378988-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 14:51:02 +0100
X-Gm-Features: AUfX_mwjuassID0lfgcRUMuDaM1vYr8AKSAUTOYmTAfK7ifcHMjrmmzONJo1PKo
Message-ID: <CAFEAcA-BLQ00aC9tDpVGWoPhngC2UgXtVeBx9fepcGiQ8bRX+w@mail.gmail.com>
Subject: Re: [PATCH 03/17] target/arm: Move helper_dc_zva to mte_helper.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, 18 Jul 2026 at 00:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Slightly odd, perhaps, but there are 3 MTE variations of DC_ZVA
> and this is the easiest way to share code.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-a64.c | 50 ------------------------------------
>  target/arm/tcg/mte_helper.c | 51 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+), 50 deletions(-)

Both files are in the same arm_ss sourceset, so no danger of
accidentally breaking in some obscure build config.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

