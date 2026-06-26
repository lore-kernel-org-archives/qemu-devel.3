Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF835CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 09:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd2qX-0002QM-OB; Fri, 26 Jun 2026 05:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd2qW-0002Pn-Gk
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 05:27:36 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd2qV-0007yQ-1b
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 05:27:36 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-6647a6c1f0cso928755d50.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 02:27:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782466053; cv=none;
 d=google.com; s=arc-20260327;
 b=iYk7zxkHD1WwwvJuUNVgOOSb1Co4ykuMX/x6YyIFyHK2GccADtSlwTPvUXfzwDoOBE
 zJ/E46jxkEHYjSCBzEG4mCH9MHfAIazgtKkNmdiaAnycHz2sRcNnxuDzqgbGq4hagwBR
 7GEn/R+T2NTLWKRqFpafz8WhVrD7m0hHeAl05VNFRxmYdLEfo5+m9y/5n/DZyd6uDvKA
 U+b8NJzzQwZL+0x82AaRnl7LbtfgGj3vg3UAATNZroDzzgSYSGtxGBywRrB4Ay6AD7x1
 RBI/PcSolk4jrRaeDZn/i3aq4iKPKykH7vpzsdFdV/aJDcdkRYJHdnLV76l0HtoHAqRI
 RsWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OUgQ6nAi7TmyblBMSHspSxW6cQX1avDCKZhMweBV8Lw=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=foryhUsVLCY0GQ+5EiiQnE45vevXVvvsEYNB4h3GuTlvGsnbDO+kApC/YVbNfmuRAB
 Yr6LmqjH31X4QwfhrfTq7dL4VXKoIseWap8vtWDQUVvkPZ/AuexDNovtvoeAy5QI2f4L
 AJQmt76O9f8Y7Y/xphAP3G/M8UIaowYFnM/IdFv+Rv0+iPa3BH97Yc4wLXx45LKkjfPX
 3sqN29dogz9zRVfTB57M5b7FpGh/oTOa7Dv/MWo2VQ/BuAdd029RsgbcBfvWJGdgkS3s
 LFpH4AL/r713aDS2utvAYbbURQabpswF2/Gk7eWV5bezJYPQeduNiUcUJ2w8XXoSp1Zv
 nBsQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782466053; x=1783070853; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OUgQ6nAi7TmyblBMSHspSxW6cQX1avDCKZhMweBV8Lw=;
 b=Y4Aqu8vxQGlUDWGmXYRtO/IZtjRdGvZpsQ+NI+V+ayIJn+Wx55Z1hREDNyEX7hapGR
 u/66BM5nDE1txdZ3Pp81yIy+5i7UA/skOfJ8U46u6sr2fXIEm/XayPjW+yWM23rK0Tyf
 TjEL8nS/3yd7h1fpJu0Y02EZS+JIsOwx3H8rSFrmT+gtKII2paK1f6t+VoXX30EwI8Lv
 YheeqB6qc7sv7n2GT67iPwDrrM+SUk7SnBXgqgMGB0jVuG8Q4FFtzyPnu58ncJw+14Hk
 iI6AbN54SBw1OuImwwh8T+xwRcanEVCSlE1jMozQ0doCN7N18mGOEkyoN2CJr/MHWFJP
 H2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782466053; x=1783070853;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OUgQ6nAi7TmyblBMSHspSxW6cQX1avDCKZhMweBV8Lw=;
 b=KXGMp4D3Y8LRieuA8T/i4LAVVI0T7NBcCVZHlikGw1BvkkC9RCF2pIzkrZhk098m3i
 BW5HP3rJyF3Uq7TpGFksqbB/VQtRW4Z2pazB2eplqukUUkfzvm6xvxZ5TmtccxQwuBla
 d6ywk3QhbjuLUTQRiDGLOWRBnvcw7oVW8g/KWrWDDOCNZXdOlGDP9Ebd8hIz+HGmZfKP
 ABKRQ+VypI1mzOBsgqwe2btm8f7nj4jpaKc+gA6MNpGvBOuOJtZkPKqpE8Jmqcy10c3J
 Zo6dTkyFJ9+/DFLlcBFBX4X0LZ0izPPsRNBGFSaTHZkk2c0gBHKrxppvXYNeL1TWLa7E
 jWWw==
X-Gm-Message-State: AOJu0YzakEWKUgzD5IuCsYXMrtBJQLkaaaunFe0H5JrQnD5ZSt0zw2TE
 8NJPFE9N+hA/P/tIA9Rl3j0ePYl0LpXcRvXWCVL3nC3I2Uo9/4cdnOtXk3Utf35dv074dwSP6OZ
 VaAyCOQOG1aeMHd300XoiXbHvF8aClEhdJvzWdEpqbH/uBrhu8rXVATOgjUSO
X-Gm-Gg: AfdE7cnBXAQyP96FkVgSCZYp8WrtN3Rq1TG+zfhj2jHmMrXlMkeC+RZjsPxYCAtVdFX
 PfiCdifa4YLE8UMBO3lf8dIM4Z2XBfR5r4ZZ3X9XOSNBdiTGN8OXxd0PGaCYRmLbSCUpXs9lOch
 Xvo5tz72+o6X5k3Q+h+Rsd6nrGcCpzYJL8Lp1h1mGpI0fBVFKRe6Aw6ssCTfOx+fjt17/yx7uvv
 xSaJzOQCpgW9eCcSYCw4uyNIWmtOBON+QW/KCzS6Wle+F1SNh3F94NYrKZKRHErPBYbTFVrApGN
 6ljyTN5epn8sK9J8EAiHPia44wLD2ck9D/hM8yOOAu60Xp1WHn6WbHh1dcOM1jUaLLg=
X-Received: by 2002:a05:690e:124a:b0:660:a41d:d175 with SMTP id
 956f58d0204a3-66488421e8dmr4682356d50.55.1782466053525; Fri, 26 Jun 2026
 02:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260625015159.719300-1-richard.henderson@linaro.org>
 <20260625015159.719300-10-richard.henderson@linaro.org>
In-Reply-To: <20260625015159.719300-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2026 10:27:21 +0100
X-Gm-Features: AVVi8CdIy8r5rigL9uFH2h9P7Yadb6IFq6Fyr1EikIj61wYl_7wcHOQnDQOmcYU
Message-ID: <CAFEAcA9fCEyLoDvYA2JR30+7ZGaN_t_taRK01gb9y4k4NNe8HA@mail.gmail.com>
Subject: Re: [PATCH 09/10] target/arm: Implement FVDOT (FP8 to FP16)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Thu, 25 Jun 2026 at 02:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---


> +void HELPER(sme_fvdot_idx_hb)(void *vd, void *vn, void *vm,
> +                              CPUARMState *env, uint32_t desc)
> +{
> +    FP8MulContext ctx = fp8_mul_start(env, 0xf);
> +    intptr_t oprsz = simd_maxsz(desc);
> +    intptr_t elements = oprsz / sizeof(float32);

Shouldn't this be sizeof(float16) since the output elements
are halfprec ?

> +    int idx_n = extract32(desc, SIMD_DATA_SHIFT, 1);
> +    int idx_m = extract32(desc, SIMD_DATA_SHIFT + 1, 3);
> +    float16 *d = vd;
> +    uint8_t *n0 = vn;
> +    uint8_t *n1 = vn + sizeof(ARMVectorReg);
> +    uint16_t *m = vm;
> +    intptr_t i = 0;
> +
> +    do {
> +        uint16_t mm = m[H2(2 * i + idx_m)];
> +        do {
> +            uint16_t nn = n0[H1(4 * i + idx_n)] | (n1[H1(4 * i + idx_n)] << 8);
> +            d[H2(i)] = f8dotadd_h(nn, mm, 2, d[H2(i)], &ctx);
> +        } while (++i & 7);
> +    } while (i < elements);
> +}

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

