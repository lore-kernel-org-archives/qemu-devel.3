Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B95C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojdl-0000F1-Af; Tue, 28 Jul 2026 11:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wojdh-0000Cv-KK
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:22:43 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wojdf-0000H9-61
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:22:40 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c15e592da74so438538966b.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:22:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785252157; cv=none;
 d=google.com; s=arc-20260327;
 b=HHe2nKFmEzia1RaV9nYf7PKHZ7aRSjcqBzJUzxWECbGwYlbU26oTFbafl40OMfZ47o
 qmPFiQpsgTlofBxzP963ygYlrVFOA/zIIr9i6ZTTDS+e/wnUOPFX2HyujJ6i8BfK8pve
 K93R5skPphWnceLck6jpo7JnzKSZPvMpIunP8VVrde2116A2a+OC1rjnf1nqwp1FRH3i
 dJJeg4JiqbSxCIeYfunW9I+/XwGCPRe9VvM0GwY40JWUkbpgJj49v30admFxBlxucbWq
 6M0FZ86JTWBSQXJ7zFsBGrL/bN/xLHrGNkU49fQWribtYwQIPa6lB8THxpBxgnTGY4UV
 JazQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bxyqLvNaeiMWMxJHwfTRFEhsh36TUbaxSLyUderGJMo=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=pwyhqQebLKFabQ/ad6A9qUV0hdKyVyFBhmkwgaPH+7OIQmCISMS7dnmXf2RRGKrNPo
 TTw7f4bLjOL0k0O3odx7ucd2D1oRGd+yyosy4teHZcp+QCJIQEroPRkUBgksHuMAiGOB
 3xuPgzrluNSWxMNWDQp6Hh1cgLx4gCF/4j5WuEr0pJETAMaGRsGotAD1EPP7mNId5pr2
 gfNqVjKYexvOw+XnlmansfkecmZoUlScTcYEtSz/pXwSU7yMuTevIICn1LYdP/Ayuih1
 WMO9dAjKmmCHCuebdAkPiHkwhuX9YMTaj1SL8uXwbiMdsOlawLkEodXbqyWOa3mfVq7P
 z00A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785252157; x=1785856957; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bxyqLvNaeiMWMxJHwfTRFEhsh36TUbaxSLyUderGJMo=;
 b=TcHmomokDxqyQLuTo6BciuYVmd2yxsdOQHvviiKodCxi1D8Vra10VOsn+ahPP9//Fy
 t3+lVPheiB7bxc4Q+scJobFZOJuH+SPs226wELkPqTyquR/h+fMWdAMTd9YPYnqtJSze
 NkQltCkNj2Gd15O6N7ivKx6UHj1fBccnMr3pry94Z645HuwF0pFkxZ8xiX6xgDoiKvsw
 PHQ/B96qKldZGLmc1TjX8MMMludwsbKmZIymuz2YujQe+QlioNuWrOcGOvCYrp1s1gME
 0/d96OHRHimgH0vPi5yjK+W4pi+7B5QdnVF0XmOcMH9pgz/O1/tfOh7vo6iptP7+kd3i
 tmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785252157; x=1785856957;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bxyqLvNaeiMWMxJHwfTRFEhsh36TUbaxSLyUderGJMo=;
 b=cY6+fd12d43Xp+psXuJjbqkSTPrKAVvjCZ0SqlegB1uLUnk0bVVMONGMX7gfgwRZDT
 zev0+iq/GsIqq91YZUL+q3kIL4XUta5fVkCr7ebl41XNc6/qMeS8eeBMCBBrbBduwFYh
 6N7xyIH5hPSliclmbLE2nxOD45bOdwOX7QHg9x3osODw5v9k/ig+QpfTdxp68deDJ1fn
 xHVlUz0SODnSnWFLfvW05Ap6+GoT2qNua4vxPCLGAc1G7EzjkUz2EbLaBLhxJ0gSONl+
 vhCdiUbR+cSmVfdp6Ekh8i6werqYvA/E158aDvXi8vqx7orozweCaFspP+mMARKAJkeU
 OMxQ==
X-Gm-Message-State: AOJu0Ywj487d/vVGk4UhJcwjapo17FkAdzXJMM01Av6Vsvnf1jebX+lO
 EB1s7mydKLYpSGKFvVkqiEpJe56IHUy7+Esi7MRoO51MjI14UAFMgZh+d7H4tdWfcRieRjMWEBx
 OJykvU8iHHOkVb3e/4cU7JFMwm+MxTb2+AzplmxdJQg==
X-Gm-Gg: AR+sD13YYevCG6bmhL07eyT5K2q9La+GkwtreM+gN/F4cgIFeggoTRkRRMLdpV91Whh
 ohflLgypkCIuoaa78T72IZL1xxTYQRKv+Nw9vkqXRUQ/UQCTqziDq2MDo56Y+81oPlxPArrU484
 0jo6tTIUUZ7vNMrnDud7buIYYEFQX/dRYdyCHX5FdQo8lPNjq2YNy+FzijUh/KeRiGigoCqnbaA
 Bl4Wfl9rjNozNj8s0h7dRbpGNw30Glei/voGsNd0qww91bwtkv9oWfiiF7JxlrZ9XFIH2J8cfYt
 Yft69eUpUsIGAYNiuzJuPv7B7ipRJf9fKJNF+J3uLgttEA==
X-Received: by 2002:a17:907:fd18:b0:c05:3c55:ee86 with SMTP id
 a640c23a62f3a-c1f7225a27dmr169298866b.46.1785252157150; Tue, 28 Jul 2026
 08:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260721184656.530230-1-richard.henderson@linaro.org>
 <20260721184656.530230-2-richard.henderson@linaro.org>
In-Reply-To: <20260721184656.530230-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 16:22:22 +0100
X-Gm-Features: AUfX_mxhWliZ5mVtnr6G6oPZ7VfIJQgOC--WB17QteV_qNHvUT6iNtqCYExnMnY
Message-ID: <CAFEAcA-ztDb15wC6sc1FnNAEoM06CcrEHZduoCuqtVp11jpp6g@mail.gmail.com>
Subject: Re: [PATCH 01/20] target/arm: Remove DO_ZPZZ_FP from translate-sme.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 21 Jul 2026 at 19:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Expand the macro at each use site.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sve.c | 67 +++++++++++++++++++++++++++-------
>  1 file changed, 54 insertions(+), 13 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

