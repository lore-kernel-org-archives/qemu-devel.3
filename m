Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73A9CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjuU-0005zQ-58; Wed, 20 May 2026 12:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPjuS-0005yP-1o
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:36:40 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wPjuQ-000589-A3
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:36:39 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-65dead17c24so4862836d50.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 09:36:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779294997; cv=none;
 d=google.com; s=arc-20240605;
 b=JnRo1do25zreLbijwbeO0H9c0TDTMwxhVPY2iwK2VdrJwYJWrwbHalTxbP6TlR7bUg
 /Ew98Z6fwQF0yFFI0AxMq3QPo4Q75kE/PcSMbkf56s6XEZeHkuBIYF//rjGvuD+6/c6v
 aSYkUoTnyI9oIATF7UvPSXsMoUiYeUOtHWAVZB/8GW+O8o6m0/5WO4oLZ+QARFzTe5Ke
 BUuluu7afK3kzfV+VQ7B7VtaPgSf3VPaRjC1pUiQlBJRSsTJByeyCpHZZ53mJccwDc5e
 hwT0PZmDjr8zGGNAxyrceQFJ7OYeJX524saX98QidJ3B9NmGCNga6eFlWzulhoahoapk
 fvdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Da1TtY+MCb2y6fKCYJH5+UfmZOEaNa/rUnc2JG0Qetc=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=d2tUSS1nsmyD9StWnnXe06qCMlCr38fuomssHLWPbOa2IBlibPo8RQnIdEX1bUs6iE
 dGjIgohQCHhzCk2wSw2AWZ4PnE3WxzKLMaKnxcM5yzvyimeZ3FGSaOb5XAQGLxJocAMz
 6aTExhCMbaOUchm4EACSbACShNojK2k2hMtXD9zQPT0W9HKfUK9MDziNxtjaH9WEgw6o
 fyMQ3JI1CKzZIh4NC5707uwlCtBTRgK3qpRriSIGuJYKnYyly21/tix7BtAD5C5dHytg
 sRvs1j0wFZbEJkAcGX54SiqqD7xvWyA6kUYzgpQMd5gATVHPJZKAgKNIsyBHXOOeIuM1
 Dv3w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779294997; x=1779899797; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Da1TtY+MCb2y6fKCYJH5+UfmZOEaNa/rUnc2JG0Qetc=;
 b=X7WQNwGRNVo/3FviGb8uO/7gXCho50xn7qZ6yoZ6IqSWDWlEHxm25+YajcL3Kr1Ai9
 W8cNh9Bn5DGRmI+AfD5wthT/Z89NTj/dQ9KBHizvZx6KJACymeVozrzeNqoCmAbKmqte
 MIRtntCmgNcJgYGlwRGG3Fj4hKTavcEWhVpcRD8Tlc1PTKPqNTh9AUkeLaSmGNIVzW+a
 UatAhQgbOVo0ESBpa8g9s0GkAJU04iVyhbhP6wiC8WZWuWHF4tD9eWucCBltViGorEFo
 Dn2nzSRAvbq16BDd2c+mFzk56mjVvrpYvfBbrouoGxkCbsnQGOkrjlxuWyImasp+OZN+
 1WhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779294997; x=1779899797;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Da1TtY+MCb2y6fKCYJH5+UfmZOEaNa/rUnc2JG0Qetc=;
 b=LqaqdtaC2u2AO0FERFCplm4FgnBaDkibV/O1105Lw4uWt5k18xvDSiK6MY/pzNYuXI
 A6eBHle6AXY0m5UphP0PX3UGlyu8M15V1WQp4Yr1TfaUqab+pze5GOrV3LXWfF5iDs35
 +tlAy2V4rq/ubUI/rakKKS+tVm2EL4cHSZOD8UzJ10IpHMMMPsEVwLHw9zROTsiTSTuS
 2zAlX56qX5P2ZmyfZi2zXHs1A+N6cE23mD0t46sLv1+hNCshS2SUr2+nPpAXNmn/ZrzQ
 XwNMy0jvYsAKxqaTs1jKeaUWp7MrrmTbgghTZE8ALkB78waNXLk3WJRmNBWfhg3qvBs3
 nqXQ==
X-Gm-Message-State: AOJu0Yz7Dgja3rcTtCm6ETjBaL9hnvMYfxEDFGjZz9KOvNEx4rI1CEBc
 uUIWS50YFSO/oBknVyJGZw5j2iRjfdpVdfEN+LOXkVcr3OhUMDZb4DCjMjuwy9nNIKyOnnwkrba
 CjFqVJJzV7drlBkg2dKYJJxtJqaLv/jwgL2U4JE1S2d3nk9D3KPSL
X-Gm-Gg: Acq92OHSEk7QdlyDHpzvBoXGj1F9o2g34t0ZS0pUjGONf9wkwV2yozvpzVEad0+oRM3
 m2XeAblKXFQzYdkgMyX8iQCnxksALZgoqY/E9dmGKSlRftQRjnntns4ak2PMf40a0HZ+3/bbdSF
 k6FxBoCGN4bPZQEuchbtHvCDQOGtReXfu6eAcwAeBUPclTu9mHYhCi/d7cz9II6Mr+w6aNnRWAa
 g0ssIh8tv0hmJ7pUaBXpD1EO8CZRUcyitIR3G7k7fWTZrhvdZ+Y19W2FJkigpZ5NT2NMZtsT/2i
 UpIX6SvcpfYRvYjk6WBqwsaDb3M/YhC5xcjAbyQfff/OArT42TZ00fPZE7SQV3V0o/WWkE0khQr
 vdQ==
X-Received: by 2002:a05:690e:4409:10b0:650:18fc:f557 with SMTP id
 956f58d0204a3-65e2285bec6mr21425948d50.56.1779294996907; Wed, 20 May 2026
 09:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260517003002.321430-1-richard.henderson@linaro.org>
 <20260517003002.321430-60-richard.henderson@linaro.org>
In-Reply-To: <20260517003002.321430-60-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 May 2026 17:36:24 +0100
X-Gm-Features: AVHnY4IXCK4RSvN9X5XqOy5otafM2VpYY22wT_2nQrobFH-jWEoOv2HjD3g8WKw
Message-ID: <CAFEAcA971nFuXNkQbswiDzRXQ7WsrW9GTVzH5A2rPGym20yMKg@mail.gmail.com>
Subject: Re: [PATCH v5 59/63] target/arm: Implement FMMLA (FP8 to FP16) for
 AdvSIMD
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

On Sun, 17 May 2026 at 01:35, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h        |  5 +++++
>  target/arm/tcg/helper-fp8-defs.h |  1 +
>  target/arm/tcg/fp8_helper.c      | 26 ++++++++++++++++++++++++++
>  target/arm/tcg/translate-a64.c   |  1 +
>  target/arm/tcg/a64.decode        |  1 +
>  5 files changed, 34 insertions(+)
>
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index 8f6cc2974f..fce38dfbb0 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -1625,6 +1625,11 @@ static inline bool isar_feature_aa64_f8mm8(const ARMISARegisters *id)
>      return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8MM8);
>  }
>
> +static inline bool isar_feature_aa64_f8mm4(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8MM4);
> +}
> +
>  /*
>   * Combinations of feature tests, for ease of use with TRANS_FEAT.
>   */
> diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
> index 3c74f02022..e942308af4 100644
> --- a/target/arm/tcg/helper-fp8-defs.h
> +++ b/target/arm/tcg/helper-fp8-defs.h
> @@ -37,3 +37,4 @@ DEF_HELPER_FLAGS_5(gvec_fdot_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
>  DEF_HELPER_FLAGS_5(gvec_fdot_idx_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
>
>  DEF_HELPER_FLAGS_5(gvec_fmmla_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
> +DEF_HELPER_FLAGS_5(gvec_fmmla_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
> diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
> index bb1d48c3e0..d5d1fe71c5 100644
> --- a/target/arm/tcg/fp8_helper.c
> +++ b/target/arm/tcg/fp8_helper.c
> @@ -849,3 +849,29 @@ void HELPER(gvec_fmmla_sb)(void *vd, void *vn, void *vm,
>      fp8_mul_finish(env, &ctx);
>      clear_tail(vd, oprsz, simd_maxsz(desc));
>  }
> +
> +void HELPER(gvec_fmmla_hb)(void *vd, void *vn, void *vm,
> +                           CPUARMState *env, uint32_t desc)
> +{
> +    FP8MulContext ctx = fp8_mul_start(env, -1);

The scale_mask here should be 0xf as this is a halfprec
output, right?

> +    size_t oprsz = simd_oprsz(desc);
> +    size_t nseg = oprsz / 16;
> +    uint32_t *n = vn;
> +    uint32_t *m = vm;
> +    float16 *d = vd;
> +
> +    for (size_t seg = 0; seg < nseg; seg++, d += 4, n += 2, m += 2) {
> +        float16 d0 = f8dotadd_h(n[0], m[0], 4, d[H4(0)], &ctx);
> +        float16 d1 = f8dotadd_h(n[0], m[1], 4, d[H4(1)], &ctx);
> +        float16 d2 = f8dotadd_h(n[1], m[0], 4, d[H4(2)], &ctx);
> +        float16 d3 = f8dotadd_h(n[1], m[1], 4, d[H4(3)], &ctx);
> +
> +        d[H4(0)] = d0;
> +        d[H4(1)] = d1;
> +        d[H4(2)] = d2;
> +        d[H4(3)] = d3;
> +    }
> +
> +    fp8_mul_finish(env, &ctx);
> +    clear_tail(vd, oprsz, simd_maxsz(desc));
> +}

thanks
-- PMM

