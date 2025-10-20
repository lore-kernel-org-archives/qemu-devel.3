Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281E2CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 14:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vArBX-0006TU-RL; Mon, 20 Oct 2025 10:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vArBU-0006T1-3N
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:48:28 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vArBQ-00047a-Js
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:48:26 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-71d60157747so45452517b3.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 07:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760971699; x=1761576499; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ob5mulAoB3Fjd++6E2t/iYBsMh6K9ZzwzPeOPLwhTT8=;
 b=YNctILIzo5grSdgGgyGvjh6oCTJWVvZmIvh3nIA19oHeuCQlmbi5HSRtPdC+uK/dGM
 LKIFbYAZMRN5Dbe0u+kPAuqTDKe/WOl3QfS0LvNkd1P4yny5NuPaBka6Fw/oj5qwTODZ
 KtxZWeNpJGvYZj/B1wevh7fF4r35z2iA63j0zunpCP2U00KuRhcLsih0O25Ij9//x5nC
 tvOfLxG/jf9xRO0ecpvRASNZcplFjmdBoyYOxoD+YV7SRrbVVG7/e90xXuWwPSk/0ipx
 19K4ZfFHBQrZpEw1pi1wEZ/LcOJHxuBf4l1CZBcmkGVIuskzVfCVCzU4IaCfzxl5Z751
 YTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760971699; x=1761576499;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ob5mulAoB3Fjd++6E2t/iYBsMh6K9ZzwzPeOPLwhTT8=;
 b=wR8LJbCXGK9mc9cu19GSrecBL+WVMQddLsSfC6KLdGrPfekrHmYV+qAeLEiqVaC+pc
 b87d2RP0Q9Dxmg5DOtzq0kmQC11CWD4fnArE2mzQAm+SPSgxZwNSAF6x0hFyCIIdvnan
 MsV1dbGAbDHPbutVGGC67mWPzYzFuQv4JfkTGBe8MkEjiLFZdEWbY2BtG0JuR0T+eQOn
 gx1SxDTDH3DwLcZE3nHoYjA6Ry5QliyEnMGiEOtH/vM5MVvjm3NexOMmAImQR0ot391P
 vfliGixgpChI5KKeBSb6r2FlBthzg8bnUmEGeJA2FxdlnxSaKxiOoJks6xCnRovKFBE2
 YNEg==
X-Gm-Message-State: AOJu0YzdPr89PE5tubitIJrEvNAllC3ZJ74NSmdTasS5bF6y/M2tN8Gn
 U8dRNrBWD53THn9Rdu+pdr8zzHGd6kj0qORWI9kZP5vo6WFGh/yOs3VkK2A2GRuc/4u5mITukgH
 qFEqGwkyJbvoPJpa4Om+ZjJkbTYmFN7Sx7HPUoYwCKg==
X-Gm-Gg: ASbGncvpgUeoEPXN+dHZYdnc8rGcF9N1zqucXT4Zoo+nZCCsFGH15bq+gs8qnwRMKo8
 YxDKuMpuonzYLpkjHHhUQy9E34F5lENOLm6fZpcDeqHtzpc3FYiPy4M3HtT1G4bx+xzRBEQSdA9
 Yf+zKvLAw5osRUYyymZGxWiqKJ61ncbOooNmOjUMMSsrd5VxiWikQ/3iMJwbIkWwuhYGrcV1J9j
 Z+40mFLDjMVslipXvbbjKfNrv5YBI03mr446ZZqzsAFDbz59VGLKHQT4YEPB+8N90Pq8+Gnj0ds
 Ul5mhfs=
X-Google-Smtp-Source: AGHT+IEmsms7z81gw0bm66n6iroTbyHy2VdMmXaoCCh6pJr4mkf1L+Y2nA9dDASzLgeYUjU7BXHTh+AUMymRVBTqHcU=
X-Received: by 2002:a05:690e:1914:b0:63e:24d2:caf4 with SMTP id
 956f58d0204a3-63e24d2cbccmr7554031d50.48.1760971698452; Mon, 20 Oct 2025
 07:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-29-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-29-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Oct 2025 15:48:06 +0100
X-Gm-Features: AS18NWBOUNbRI924y2gvCtQD3lTNu84WlcX1spT-nZ1W4l4l-gCirw7NNXrodOg
Message-ID: <CAFEAcA_KXK6UwvbELnhjbXXgoXWnHDhDS_4vP5POoMDWAjZ3Vw@mail.gmail.com>
Subject: Re: [PATCH v2 28/37] target/arm: Implement TLBIP RVAE1, RVAAE1,
 RVALE1, RVAALE1
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Tue, 14 Oct 2025 at 21:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/tlb-insns.c | 93 ++++++++++++++++++++++++++++++--------
>  1 file changed, 74 insertions(+), 19 deletions(-)
>
> diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
> index f7510a1208..daadba7bfc 100644
> --- a/target/arm/tcg/tlb-insns.c
> +++ b/target/arm/tcg/tlb-insns.c
> @@ -918,16 +918,43 @@ static TLBIRange tlbi_aa64_get_range(CPUARMState *env, ARMMMUIdx mmuidx,
>      return ret;
>  }
>
> -static void do_rvae_write(CPUARMState *env, uint64_t value,
> -                          int idxmap, bool synced)
> +static TLBIRange tlbi_aa64_get_range128(CPUARMState *env, ARMMMUIdx mmuidx,
> +                                        uint64_t vallo, uint64_t valhi)
>  {
> -    ARMMMUIdx one_idx = ARM_MMU_IDX_A | ctz32(idxmap);
> -    TLBIRange range;
> -    int bits;
> +    uint64_t uaddr = extract64(valhi << 12, 0, 56);
> +    ARMVAParameters param = aa64_va_parameters(env, uaddr, mmuidx, true, false);
> +    TLBIRange ret = { };
> +    unsigned page_size_granule = extract64(vallo, 46, 2);
> +    ARMGranuleSize gran = tlbi_range_tg_to_gran_size(page_size_granule);
>
> -    range = tlbi_aa64_get_range(env, one_idx, value);
> -    bits = tlbbits_for_regime(env, one_idx, range.base);
> +    /* The granule encoded in value must match the granule in use. */
> +    if (gran != param.gran) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid tlbi page size granule %d\n",
> +                      page_size_granule);

Having an early-return here would make this code more obviously
parallel with tlbi_aa64_get_range().

> +    } else {
> +        unsigned page_shift = arm_granule_bits(gran);
> +        unsigned num = extract64(vallo, 39, 5);
> +        unsigned scale = extract64(vallo, 44, 2);
> +        unsigned exponent = (5 * scale) + 1;
> +        uint64_t max = 1ull << 56;
>
> +        ret.length = (num + 1) << (exponent + page_shift);
> +        ret.length = MIN(ret.length, max - uaddr);
> +        /*
> +         * Note that TLBIPRange ignores the high bits, because the HW TLB
> +         * does not use it.  But the qemu softmmu tlb does, so sign-extend
> +         * if and only if the regime has two ranges.
> +         */
> +        ret.base = uaddr | (-(uint64_t)param.select << 56);

I think it would be clearer if we wrote this "sign extend
based on param.select" the same way that tlbi_aa64_get_range()
does".

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

