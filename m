Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DB9D2FEE2
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 20:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkq2N-0001HO-Tv; Tue, 27 Jan 2026 15:51:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkq2L-0001GW-Ae
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 15:51:45 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkq2J-0002BB-AM
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 15:51:44 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-790b7b3e594so64349427b3.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 12:51:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769547101; cv=none;
 d=google.com; s=arc-20240605;
 b=f9dTdDXGauKmVf6nw9XSu1tx0YCrNx3sj+dGUnkPPmOKwM/zgXWKBJiansxyxtH10s
 XIJz9oCQZ1fFLCTqkqUX9Z/opL5oU9EHg6DBkT0lHfXvzkKVFf0i+Dm1O34jaDSpPmEb
 KavgS5bCZk6mj3OKSqxRra2nBJci6p3aS20UNoE0bgiPTuSpvCJ8tlhzY9pnZF+F0LqN
 wYYfWIbA1XRez9NxUdIzEcXkqyNf95HBjpZqcVKG7dyfkZYAJzfgpeddHOIkjN56uEo+
 +xsOQMQ2Db7OrYmckM4QkYZF+rsp20AT21wavUx1I6HkYfb2aYaQQxvZnXj6NXp2bC7V
 u0iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=j650I8U36tmy5ppnM3eeepIzkkg2D22/3Dxbno5Zfao=;
 fh=1/QVvN9lGn2hk0aDigKOBn6zF66ELHf7nQB9M04IEpc=;
 b=WgSuPy28yvXH1U3CJLhMepWXjTkqd2RltnJkKombQ107ovHS+rBicutwaHUnYTTAw0
 DUzI6eYQhFXDZLXYznUExsOEYA6X+qOF+f8YTP+CaAeHe4ZhVnxiZzDIgClkJAjn+SI+
 XK7DxZk3PPG1uWCPyTIQGrMDs362cku0XmeCX4GpnT0+ANqfqcOIv29BFI8A8Jlwxp0k
 TEEvV06mxubV0GZMDUkGsd/asADQxRTx9p8ayICSnf6x4P2BKPSheLnvLNansxMKQoBk
 4qhnAAfzRkfM73htOUlX+HJnJOKjM68wUlZZTPD7/JgPAZj23US2GLFovz7qLGo9JfIt
 cqlw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769547101; x=1770151901; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j650I8U36tmy5ppnM3eeepIzkkg2D22/3Dxbno5Zfao=;
 b=Qt54+C8NhRqb1P3aaAWWR+JNN+qJVOlEI2Yxh7gd59uGtWOS336v/rrcD7/yhh1JzV
 X0WSumMsLaoyO9733CctOpC/Vf0/olWZTikDqweCJzT3SEcSHH0r5V9b/WfTBh7G0HSm
 O6+/Dr7VEeXrRjcXasjf0xMM7ZDtuy3FyNbdc8/KtMB3pgxUihgltHLrvnLtSYLffgpz
 xmXlqw6QrYUiEe3rdtoLle7qsxCpfMwbPOSmqNkl2hpcFF8856m3Vj20/D8qnRa5wmD6
 DSlz9fy0N/oJct3hQUJijOiy/b1ujUQYccwxTXoQ8ZT99m14xxzfGyDqaPjjre5M65bk
 Ca/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769547101; x=1770151901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j650I8U36tmy5ppnM3eeepIzkkg2D22/3Dxbno5Zfao=;
 b=iE9y/47VBDZthKYeEDeyBqL6KwBI/MuQfhR+I/NEfUjzYUpX8h5OPdp/YrCONZ/9LP
 RMNzW6uFIdjmx7VxLuh9NpD4hn/DMEV+NwQoA6qYcOR+Py0Lm+iMhRRg8JtAxWe1T0d2
 pmZCPevIAiHMP1WljwCoUhFI52zdF1M4htR1MImnLA2kAbvlRi61/L07Sg8whCAzfaCM
 dpxzs62CLCgXYuCHmfFMvNesV0TXoF++sF63M03QiGL+bFEhjbULasbPDcHTpBSTeNpo
 ghyquPDzs6AW/ZAI4v63pqZxyCAPuNHnbGoI1Bm5wLQ7GzJQj5CxeSNBbEiIXAtkcqzs
 z52g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa+VInNlgatFEgyXGi6UoDeFTNmn+4eH1fvyopggJeu8Jb36CF1Pi/RIQUGhgYvnRTx/GzIZUxej27@nongnu.org
X-Gm-Message-State: AOJu0YxEZVpZj65JNnVBwytYiq3935bjCw/5neccHEfeha51MS+4JPej
 Rat5oCxjylwuYOKvbq/YMUXqURyprLzM9Sx8si98YVa4mSsum9e2b9mALSCmbaVAKciG1MhlfMw
 vZrpYsZ+Y5KIMF1d+vmDCXo/yj+URooLP8fhzSDXjYg==
X-Gm-Gg: AZuq6aKBziLEQfOk3MhUsZ/bba81rcMshOEwZmp0/YDhaqVbj7C3+UD2vOkzGlklqOb
 TN0Of+mUGVmsIySuWRzBYBF4/O7P6g4oOGgRGmAA/oNucz4/RvDpU1uisccod3QPB1lZ+/srmv5
 X5l+vT4CTX6dcNEc/c8wgQyL2PT/M7d2UxhKfhkGVICo/iW1Qpu/BE1i7tTUGlTXq8SKOg1Zg9f
 4hihFYdYVEbCRTiHu/Ra4AYgNyHZVUXegS5rHjHojFvqSfcVH5pUupQWZESAij0eqGuEA==
X-Received: by 2002:a05:690c:e584:b0:794:184a:bc68 with SMTP id
 00721157ae682-7947ab562e7mr16195487b3.23.1769547100872; Tue, 27 Jan 2026
 12:51:40 -0800 (PST)
MIME-Version: 1.0
References: <20260127154813.591744-1-peter.maydell@linaro.org>
 <20260127154813.591744-2-peter.maydell@linaro.org>
In-Reply-To: <20260127154813.591744-2-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jan 2026 20:51:29 +0000
X-Gm-Features: AZwV_QhtdwLkO2ezduCKgEdrwZIPTFkpMIvWyDiwCdmtiryQCR7yh8XUqORLeKQ
Message-ID: <CAFEAcA8kK=br3h+49ruFhpx3aO29ErB8jsEabNJU--vmKj4j6A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] target/arm: Make smcr_write() handle
 SME-without-SVE
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Tue, 27 Jan 2026 at 15:48, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Currently smcr_write() implicitly assumes that SME implies SVE,
> because it will call sve_vqm1_sve_for_el() when SMCR.SM is 0, and
> sve_vqm1_sve_for_el() will assert in that situation.
>
> This is the only place where we call that function without
> it being guarded by a check on whether SVE is implemented.
> Adjust smcr_write() so that it also avoids asking for the
> SVE vector length when SVE is not implemented.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I did think about making sve_vqm1_sve_for_el() return some
> value rather than asserting, but (a) what would be the right
> value? and (b) this was the only place that needed fixing.
> ---
>  target/arm/helper.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index dce648b482..a3dd84a2d6 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -4936,12 +4936,12 @@ static void smcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                         uint64_t value)
>  {
>      int cur_el = arm_current_el(env);
> -    int old_len = sve_vqm1_for_el(env, cur_el);
> +    ARMCPU *cpu = env_archcpu(env);
> +    int old_len = cpu_isar_feature(aa64_sve, cpu) ? sve_vqm1_for_el(env, cur_el) : 0;
>      uint64_t valid_mask = R_SMCR_LEN_MASK | R_SMCR_FA64_MASK;
> -    int new_len;
>
>      QEMU_BUILD_BUG_ON(ARM_MAX_VQ > R_SMCR_LEN_MASK + 1);
> -    if (cpu_isar_feature(aa64_sme2, env_archcpu(env))) {
> +    if (cpu_isar_feature(aa64_sme2, cpu)) {
>          valid_mask |= R_SMCR_EZT0_MASK;
>      }
>      value &= valid_mask;
> @@ -4953,10 +4953,17 @@ static void smcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>       * current values for simplicity.  But for QEMU internals, we must still
>       * apply the narrower SVL to the Zregs and Pregs -- see the comment
>       * above aarch64_sve_narrow_vq.
> +     *
> +     * If the CPU has only SME and not SVE, then turning streaming mode
> +     * on and off can't ever change the SVL; we must avoid calling
> +     * sve_vqm1_for_el() to ask for the SVE vector length when SM is 0
> +     * because it will assert.
>       */
> -    new_len = sve_vqm1_for_el(env, cur_el);
> -    if (new_len < old_len) {
> -        aarch64_sve_narrow_vq(env, new_len + 1);
> +    if (cpu_isar_feature(aa64_sve, cpu)) {
> +        int new_len = sve_vqm1_for_el(env, cur_el);
> +        if (new_len < old_len) {
> +            aarch64_sve_narrow_vq(env, new_len + 1);
> +        }
>      }

This isn't right -- I forgot that SMCR also has the SME vector
length, so old_len / new_len can be different here and we need
to call narrow_vq for that case.

Also aarch64_sve_narrow_vq() does this:

    assert(vq <= env_archcpu(env)->sve_max_vq);

and I think that should be asserting that the new vq is <=
MAX(sve_max_vq, sme_max_vq).

-- PMM

