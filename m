Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138BEC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 23:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfQxX-0002Mb-NN; Thu, 02 Jul 2026 19:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfQxT-0002KP-Lq
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 19:36:40 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfQxR-0007QU-RT
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 19:36:39 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-37df72c9984so2006288a91.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 16:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783035396; x=1783640196; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x1eRmHA4Bu/QahHupuBcSI+qLTmSuzVSzvfGrYLu/Mw=;
 b=QrcniwSLPSP3cBReUhhFKJg7eMA4lJJxAafZrOlLheaIGi5b2J0VmjizMgC1a+57e1
 RoFJ0hdzV9vsHcAmtL1I3gGuWSOaTwR2o2HwtwzpInt4ObdFjUZL2CfffOpI7mLiQzLU
 cYv8BP5kbtaKPWA0/+XEHKelYtnSxeJrtc/wj11de5XIu69+Tv9iygtTgmTx73XCtd/7
 eRN0CYoWWjxWv+xVdAPYxWTjB9yJrVXqJmVfkf5AmwhR96nRwP6SGUzjzSSkUMbIJon6
 cxMwk8bIE39pAal4/ZdcMeeo1evMpXdYJbc9fqXxUn17I4wW5sUdztbwsfSibSkdBBDr
 1Aiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783035396; x=1783640196;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x1eRmHA4Bu/QahHupuBcSI+qLTmSuzVSzvfGrYLu/Mw=;
 b=p8B9UHAH8/8OllIK3k2A0T1DXNEGcaE6vnKiYQJ8j0MN3y4IuXjjx0vFYvFs6+3YZE
 iE8+Ix2XyIdyiX/5e5Wdy8vh0qi9Za/nw6hrrBZpErY1VulDienPsYtGiffTNK7Ag00f
 sk7SDcB7aWhfmW9c2Ew2846VF0fK4A1vBZ9BWOXq/q0PaFkwsgoxaNTHPbZzSSjyEpM2
 CFMKmD61z38wUGceTcd5LhGokRiRE7w7ZdbMzKB2bT5U2cAxJ2V8Gc9FFpbs7jD3YVf3
 9KC+XKSuwvHuSSPt6kTKrerKAmbfUJ5hHxPaw3VATKd+HM3c1EXUC87bUqTrve2NnjwB
 VCrA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp05JGLJ0LiCAZTrpPVjpVQxBX68VwdSbQ0hkOI0vFW/0pos9V8qnF/6jojBxWVgReoPc1DHrmyWn2q@nongnu.org
X-Gm-Message-State: AOJu0YwShERSdz96S1SN4+jWiB/oIgKypALEbJ0hd4q5VYJVkjPnk/87
 39FC83nxzFiHMud84ZdyOrB6Ssv8OipVQSFreOP5H1/NbG0z38iqISfvvdw0ciqNWjE=
X-Gm-Gg: AfdE7cnfBxzxNO3zn4ZDZnYX2/a//wxez1Oq8U54dKmvBFW/WlYjQCRwRFRCNzrgOey
 EwZD2GFksPPH3ZacPbXzHC7Sy9Su1lVaPdWPAQrJ2G87Ea062JC165QOQxzHpg2SekWIGhW4Kmz
 g6QiK1ojWnGrasPNWvx+TxkBSHr+p9uvPHQkf62c94U+xxgxs57sbbEx8QZ3ozfpNFv8DzCqvlI
 Aiu2URxmypBKeXQ5WCfNJ7yxx4zj66zcHcrSVM8/+YzZr92kuzykQdOLI0ZWZQdhHea6Fv1Byuc
 dn/ArbZAubbJ5uOB0EOe0YP4X8qaUKl2yEhiqjpjU2WH/BOLDxhdjRAlLndVOQFcPfqvw1BbZLe
 KbAHaBtjBVz7WcXFFjnOAYDdWic6kSrzdbUpg1zKXv82FgEjVFFRQXnOs8oDzb+oTaU/GCq+1RH
 tWSSKHOSLWZyhtbNntqHOl4eFGB19ZIWIyrtyrAaZNrBK9CmhU5j7/IcgGKw==
X-Received: by 2002:a17:90b:3a45:b0:37f:9cdf:f0ac with SMTP id
 98e67ed59e1d1-380aa234f58mr7986894a91.27.1783035396103; 
 Thu, 02 Jul 2026 16:36:36 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38127ae5b06sm65616a91.3.2026.07.02.16.36.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 16:36:35 -0700 (PDT)
Message-ID: <d0222d0f-ee90-4d4a-bc60-71740a858543@linaro.org>
Date: Thu, 2 Jul 2026 16:36:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] target/arm: Implement CPACR.D32DIS
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260702184019.3431139-1-peter.maydell@linaro.org>
 <20260702184019.3431139-12-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260702184019.3431139-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 7/2/26 11:40, Peter Maydell wrote:
> On some v7A CPUs, CPACR.D32DIS is a bit allowing the guest to make
> VFP instructions that touch registers D16..D31 UNDEF.  Whether the
> CPU implements this or not is IMPDEF, and the only two CPUs we
> implement which have this are the Cortex-A7 and Cortex-A9.  In v8A
> the bit is no longer defined at all.
> 
> Since the only kind of trapping that needs to be done is a simple
> UNDEF, this is straightforward enough to implement.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/1499
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h               |  4 ++++
>   target/arm/helper.c            | 19 ++++++++++++++++---
>   target/arm/tcg/cpu32-system.c  |  2 ++
>   target/arm/tcg/hflags.c        | 20 ++++++++++++++++++++
>   target/arm/tcg/translate-vfp.c |  4 ++--
>   target/arm/tcg/translate.c     |  1 +
>   target/arm/tcg/translate.h     |  1 +
>   7 files changed, 46 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> @@ -210,12 +210,12 @@ static void gen_update_fp_context(DisasContext *s)
>   /*
>    * Return true if a VFP insn is OK to access D16..D31, false if
>    * it should UNDEF. This checks whether the D16-D31 regs are
> - * implemented by the CPU. Eventually we will also check CPACR.D32DIS.
> + * implemented by the CPU, and whether CPACR.D32DIS permits access.
>    * Note that Neon insns accessing D16..D31 do not need to check D32DIS.
>    */
>   static bool vfp_d16_d31_ok(DisasContext *s)
>   {
> -    return dc_isar_feature(aa32_simd_r32, s);
> +    return dc_isar_feature(aa32_simd_r32, s) && !s->d32dis;
>   }

Not that it matters much, but if we stored

   s->invalid_dreg_mask = (d16_d31_ok ? 0 : 0x10);

and pass in the mask of regs like so:

static bool vfp_dregs_ok(DisasContext *s, int mask)
{
     return !(mask & s->invalid_dreg_mask);
}

-    if (!dc_isar_feature(aa32_simd_r32, s) && ((vd | vm) & 0x10)) {
+    if (!vfp_dregs_ok(s, vd | vm)) {

then we eliminate a couple of branches and some boilerplate.


r~

