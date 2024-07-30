Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7A1C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYjBj-000467-4T; Tue, 30 Jul 2024 05:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjBg-000422-Oj
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:30:32 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjBd-0007GB-Vv
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:30:32 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2f136e23229so25255971fa.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 02:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722331827; x=1722936627; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uNsh7c3255rTpF65wyORY+h4ndviNnkJbAViEsxA+Y8=;
 b=oivESpYB5HHXJu2Zq/Y6rkDvFFWl7UjLayoXy4A1bTfj/5q+mn9qiUw+szSJK0w4fS
 +GIxUDsz+G1uovQh0ULoRDOdR00hDdF8oXpyy4LAv4mc4d9GdHJt/HpfdfcjDClyvCDh
 QsTBw4nHK8W/TCJrPCrSUIZL5/3eT9xQ4CBees5zZMDcaUCgbOTYnkSzy2Pb0BXvZ8JH
 Q2vij/gk7P2edjwhrx8dNOeTozhe9YU0RdleUAGpGYsApG+87pHaad2icb8YWWC38GhM
 HhHlKG9mJ3vh4j2Z7harXcu9a1y3AUwyuSdi+7/Jc8X02W8GGIlfabwN8n2Nx9TnM5GP
 HCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722331827; x=1722936627;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uNsh7c3255rTpF65wyORY+h4ndviNnkJbAViEsxA+Y8=;
 b=PBgI2fyggdtT0SLDdnU1LuekA6R3+kpeeldbiYezPFpCPElxYdZmfPFGWq5RNYNYDg
 z3NGHZPyl1aRCIxFN0oUw9n0mqzv6W7KoarDT+nwgCc5jSNEsVyTsgwIifCjN/sM+6te
 5k4LBm9dUW7J55lvjiXaACOLIMxIfl7VxUZYaIuJBiLLbiXw2HtqlZ7w3/6kFcfqKI9W
 j/7/qYJMuIT5kQS5wVBx0fhZ1y1lK8fpBzzTy+8HgoYhsuzgc2rP6vKuCrTtYqfgE5bk
 1H90HB9N0X9PpZNgjuKHSJbp2tIFsI1ot+3h6mHiR4GeWtfcg+tgGT+WiGLJLPl5d3Xk
 ybjw==
X-Gm-Message-State: AOJu0YwscRutu5MCWH+8Ew5xUOsBh/6MkgszF3Lvp2hPLpxRl1puEJsJ
 GXF7hqRAVwNzeSUxzRPxdH9sfo70l+7hejZzxr/joyD5YS6owTJlBoHS95xCdLKBX7pu2B2WQXX
 3TlXSX9l7wI6SDlqo8VYX+VCBOrP0DIS7g2bbOpU/pKtvAnD9
X-Google-Smtp-Source: AGHT+IFghVn26lHfIjlhSmjwASFU7ALEIyolQ0JNVT4TPkIFWd6YzYMqrhy97QMFJQDTJPNyIxB5gQX/jrE55GavXrg=
X-Received: by 2002:a2e:a176:0:b0:2f0:1d51:a8fa with SMTP id
 38308e7fff4ca-2f12ee5bb0fmr70569201fa.30.1722331826805; Tue, 30 Jul 2024
 02:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240730013922.540523-1-richard.henderson@linaro.org>
In-Reply-To: <20240730013922.540523-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jul 2024 10:30:15 +0100
Message-ID: <CAFEAcA-yuy54nnuoa_B32UpKPtfhRmo9sd1N7eYKSz4O0PC7qg@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Fix BTI versus CF_PCREL
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 30 Jul 2024 at 03:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> With pcrel, we cannot check the guarded page bit at translation
> time, as different mappings of the same physical page may or may
> not have the GP bit set.
>
> Instead, add a couple of helpers to check the page at runtime,
> after all other filters that might obviate the need for the check.
>
> The set_btype_for_br call must be moved after the gen_a64_set_pc
> call to ensure the current pc can still be computed.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-a64.h    |  3 ++
>  target/arm/tcg/translate.h     |  2 --
>  target/arm/tcg/helper-a64.c    | 38 ++++++++++++++++++++
>  target/arm/tcg/translate-a64.c | 64 ++++++++--------------------------
>  4 files changed, 55 insertions(+), 52 deletions(-)
>
> diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
> index 371388f61b..481007bf39 100644
> --- a/target/arm/tcg/helper-a64.h
> +++ b/target/arm/tcg/helper-a64.h
> @@ -133,6 +133,9 @@ DEF_HELPER_4(cpyfp, void, env, i32, i32, i32)
>  DEF_HELPER_4(cpyfm, void, env, i32, i32, i32)
>  DEF_HELPER_4(cpyfe, void, env, i32, i32, i32)
>
> +DEF_HELPER_FLAGS_1(guarded_page_check, TCG_CALL_NO_WG, void, env)
> +DEF_HELPER_FLAGS_2(guarded_page_br, TCG_CALL_NO_RWG, void, env, tl)
> +
>  DEF_HELPER_FLAGS_5(gvec_fdiv_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_5(gvec_fdiv_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_5(gvec_fdiv_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
> diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
> index a8672c857c..01c217f4a4 100644
> --- a/target/arm/tcg/translate.h
> +++ b/target/arm/tcg/translate.h
> @@ -163,8 +163,6 @@ typedef struct DisasContext {
>      uint8_t dcz_blocksize;
>      /* A copy of cpu->gm_blocksize. */
>      uint8_t gm_blocksize;
> -    /* True if this page is guarded.  */
> -    bool guarded_page;
>      /* True if the current insn_start has been updated. */
>      bool insn_start_updated;
>      /* Bottom two bits of XScale c15_cpar coprocessor access control reg */
> diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
> index c60d2a7ec9..424fe927b4 100644
> --- a/target/arm/tcg/helper-a64.c
> +++ b/target/arm/tcg/helper-a64.c
> @@ -1877,3 +1877,41 @@ void HELPER(cpyfe)(CPUARMState *env, uint32_t syndrome, uint32_t wdesc,
>  {
>      do_cpye(env, syndrome, wdesc, rdesc, false, GETPC());
>  }
> +
> +static bool is_guarded_page(CPUARMState *env, target_ulong addr)
> +{
> +#ifdef CONFIG_USER_ONLY
> +    return page_get_flags(addr) & PAGE_BTI;
> +#else
> +    CPUTLBEntryFull *full;
> +    void *host;
> +    int mmu_idx = cpu_mmu_index(env_cpu(env), true);
> +    int flags = probe_access_full(env, addr, 0, MMU_INST_FETCH, mmu_idx,
> +                                  false, &host, &full, 0);
> +
> +    assert(!(flags & TLB_INVALID_MASK));

Is there a race condition here where some other vCPU
knocks this entry out of the TLB between the point when
we started executing the TB and when we made this helper
function call ?

> +    return full->extra.arm.guarded;
> +#endif
> +}

thanks
-- PMM

