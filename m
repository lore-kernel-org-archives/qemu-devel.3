Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23598C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wohnI-0004nu-Pv; Tue, 28 Jul 2026 09:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wohnF-0004nP-Pf
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:24:26 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wohnE-0004e2-EX
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:24:25 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-668296d0ff3so4830516d50.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 06:24:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785245063; cv=none;
 d=google.com; s=arc-20260327;
 b=gmTQ7FD0jXDC2LHeZ4jsjDklWe7O3AiPUAjPki/TorhXDpyXU6w7ynA4AO2lbGCb/U
 n/myqzUFAcqTlPHMCjdNeArzNYyAAfRkgCui/RH7A96wKkUXAtI4dXt5dxPH1fN9UA+x
 7KIMPg1s7iPdYhJ7bdwlQLLQENlUvskbX8FS5W+zzJty7VGRUbnIrdBUtT9iMOLEnm94
 zwo5YzGAxLRLJCBBfrwGePFMvaN8XAe1FjpNdaJQe/gRMOQngPwhlmz1Gex7WepJm4p3
 FpjTPWBRiIL49Jhw4vHGFFkQuzzsxEPpWt/tWPDYg88Ode6q657Y23DW9AO3Sk1UV1KP
 F3ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xvyndu7eTw/bUjKhq9s6smtSUffhS0AnwTzNAk8PaRg=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=FHYZLq9dVZd6IZlZbvMi7Y4zMYrgxFrYbtEO4luL6Wol7lPWyqKJjx9aC38ggCokFl
 9Mb0lsGEsxDife5znYKEEBvtU9WmW9ljsozT7QXVk3bdqww7xNA6rGT/brX2R1Nsmfes
 ots0kDGz/t5TgN0SMuGbuuumyQAdrjn3UJCSitHNwMnwY+w1KDMlRIGAdVG0eaUowHZB
 8ZRZGDmlIMKWDTBxE2RUmMXfNbURgSgBb08iqVvkhSmNYboVXXzw6qqgpdCZAZeGxkfb
 HcvurmpVj/p7FBkbi1CwISvRqWFkTkhIaRVpezG3MFk63EnoTSByYXI4w+GE3nzGTwIi
 S2Eg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785245063; x=1785849863; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xvyndu7eTw/bUjKhq9s6smtSUffhS0AnwTzNAk8PaRg=;
 b=ZdfZwhcw1wKo6ETcUyxrV37hXD89XplEYssy47RlEQi5x6+Tr4JTHqJi0tV9bdCICi
 tqe7g+YoNYomwodQVlTgaR1BJKnkPfyWkO0U9v5DTWgpPzJWyaiai7aXraHqm+DXXcpf
 c5IOYrnioh5HBq8HJ8Jtum02zHkpgupPAIului5d4gYJiIJxRyK1cjsS6HbA2yHtDm2m
 GRhNjAJ7q7tP1BaguQWiws82dG4+Vl9zfs1b8btr6mF3SQinzOO3BJARHRKMaHwmSxmN
 snmughWSIQXFlod/hchPa9i6YEDF8/fNqrMFMF08QevvEmWTmUgG9q//AnWtXsqj1kdh
 aTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785245063; x=1785849863;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xvyndu7eTw/bUjKhq9s6smtSUffhS0AnwTzNAk8PaRg=;
 b=Mie9GWHclejW2LqPHLhKfSxXJzwyNAJw6cjb3iKS5WFZgXgG8FwtgAPC3toaAmyl3H
 0gMNMiUYTf/BV/SpcHQ3+01xLQ1RuhM1ZtxgmlWNgXQruJcv8oIwQwaiOCMTjzGupRN7
 hz34j8i4cQfFUxXSbuHHA11A6Hs8v16GTRJUs/xmGdc8/UAfU6W/cJRrXSMu6Cz98srA
 6UUb9EnyJpUlks7DjLGG5iKLDVr4w2msIhfFfpBu0Zm49NgiADre+A9BUpTi5LmsrQOR
 ie48Yu9suta3D+d8Oab0blzsGMGPVRDJ2QQqTSjmzqrTH39mQ/7J7O8xMc4kzN5Si/UK
 2jaQ==
X-Gm-Message-State: AOJu0YylHOWfPrkLANycrg08RpFXUyrYV8eoT5HKUfM2ogIQjEk9veJV
 dpq0+CFAfXdiqONiymmNRZ/SUnfXzkhgOUcz1GoJ5SbAOoppV0g67wFH8zKp7hL6MBm3L5aI2WL
 yiN+2nONVBemvJK8k3PhuBOmoEOCSeJY0PRp04xMR0g==
X-Gm-Gg: AR+sD12jvfYBYk0ndWhpnwU+6LMz6C/sexXUFicd2Oepps5a2eC8DhwVWGlHxzA1MR1
 SqEeKnilKdJ2kIAwNBHpWJFybbnywOAGCd1HIIQvBouvs0/GMgebv+RosR6pNhsV6gL79WvxQP6
 xtC5W4PdUEndOzcN8PcLaCkI29DoX2Z+Y8tVtO9hSNTrkFMiHjvLKflrPshOt2oZru/tj9Vnbj0
 jmKZfR1ksXQ+8lRejyl93kBI7ggbv2Aq+4gKDBXwW5bpSyfNeCPUpjOCO79vQv+h+QLjKd9y9Qx
 7uCy235+gcN9OZDwzAEAuYfJhfzkxCmIvWyEV1xcnw0hnew9IGMJ9AZNbsWIQXcQXielwXgd3pz
 XstWI/J3QRyEg2fFv0HigHt7Hfw9gHqqit4Lfsu4=
X-Received: by 2002:a05:690e:1a53:b0:667:8b90:356b with SMTP id
 956f58d0204a3-669058544d8mr620580d50.93.1785245063242; Tue, 28 Jul 2026
 06:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260713230244.70174-1-richard.henderson@linaro.org>
 <20260713230244.70174-10-richard.henderson@linaro.org>
In-Reply-To: <20260713230244.70174-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 14:24:11 +0100
X-Gm-Features: AUfX_mxhiP5F9T4G9BdBkN9MbjdFGDkoFBSFVv8-gtMQp5LdrhpGBPPVtTDUGlw
Message-ID: <CAFEAcA9DgwOfiCj2hsb3QZNCimfrzrzs2cxmC3bx+yYBxKmWLQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] target/arm: Implement {S,SU,US,U}TMOPA (4-way)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Tue, 14 Jul 2026 at 00:04, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sme-defs.h |  5 +++++
>  target/arm/tcg/sme_helper.c      | 14 ++++++++++++++
>  target/arm/tcg/translate-sme.c   |  9 +++++++++
>  target/arm/tcg/sme.decode        |  5 +++++
>  4 files changed, 33 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

