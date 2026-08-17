Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96186C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 16:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww0Lp-0002a9-4q; Mon, 17 Aug 2026 12:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ww0Li-0002ZQ-6v
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 12:38:11 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ww0Lg-0007Af-3Q
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 12:38:09 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c15ca7a7ca9so362278966b.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 09:38:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786984686; cv=none;
 d=google.com; s=arc-20260327;
 b=h8wGkhRP9qt0qaxSUSVnRGaDWAlINhPCmdIjnXexHILTHGowxWgOVRPzIF0T8mF48H
 H6H1u7yFAiGO5N/UFewYnOU4wJa41CyKeLCZi/03pimCPMIYtaB4GEoloip0qdgkZVld
 rYqg0hfYaiuYcapgb/INKsmsVPQNINRqhdvp20dXbtjvTUZyVkNDXWlxByLGwhQzF/ig
 z3oVc+CSbhK+wZaGo0FSziRw0N1iebXed06cuptg2DJnyO8SEHZ2TG03c0gXx7jvm10Q
 ti6LlwwEom86gmcoMqamQB8jBFcXa250P3HIUJhPvHbfpbN85C2ys8aSq7yUYHamZexq
 7GTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JisFTHGk3ncXcbu4I3/VkGj9PsX2jCC2hRBgN8jMugg=;
 fh=rRwEAwPkSZ0I452N0nR2YVKCsQWVAiaKmLym9qGnx7I=;
 b=PCZh8nEYy29ykvXQ3vbHD7sfViXIFeah3DTAXdF9h4NdkWEW1DRuw/YmP4jTY4R6mG
 mQagbhz6JXBo53ydbhO/yZoenTZ5HrFbqpvHRj/lIg2fpir5sD4IXelgg48l1GIJEGmx
 b/3aRaQzYGX5MzMuKBnpoLgthQhPW4kXtLazNnaViEmDIXLCJUcUybtrflTSjLTc6Pgp
 4hSTusk4ubcmqPiQlgmXuFjagp23G52J4dHPKQixrd+it22GZ/DJNc2NM1rjG8Rkbgxr
 GyvBKhIyHpvgyAEIxnLxEpb2NHyX1o/z3xEmsV2EnHR4Z3q4+w43obijZLiPpNSaJDRD
 mKQw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786984686; x=1787589486; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JisFTHGk3ncXcbu4I3/VkGj9PsX2jCC2hRBgN8jMugg=;
 b=gLRALKVILAPACshX8rUlZ99bOnySSomYsJd/elh2wfhewoF+AOABS7E6dqIwPIzXUc
 /U1WjlkeP1SZsTkp3DsTUe/QphTa2Y4XbRfRF+9lBsdRDfQUJUxjHSAE0EQlcT9zqSU4
 +vf2MRNVvQieAz3xm1dH7jDjd8UMR4CzmA5yvythKPyq1sVuVqDa5HM9U+jq1E1FNOcI
 mokCeyQ6JXhqgHC/vBf4pzXmG55DYtjd6OLJGleooj7S4sLkXPNIWj8FEp7gFMSC+tUt
 W5EOzmGSiEm3r2ucoGNTfM1IZ/KVpV5Awj6piuEjiy8idUglfk6z7zJli8HfKhVPQDOU
 efIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786984686; x=1787589486;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JisFTHGk3ncXcbu4I3/VkGj9PsX2jCC2hRBgN8jMugg=;
 b=HQtqvasDhZnt8gbZIa+uvP6Eq/2uCbpg16XPbcGKE35pS9YxkTtz4I94tM3hENT2NF
 bOD9kOK9IXbITWi2dwyPuZE6grBocVIbsSlqZKOFKT9RmryaQb8JC7joDjGE44/faq59
 2/f0j5Arb6xAwHD+Hvvu6jkYdvQGcdNJmMxlkADXN05Oky8X3zz/HX9j0FWGgk5EhdRb
 z1ag3nMzB12jdOz9pLQGN9mjhywPqywCtk9h1N85d1hudVJXb7MG5OXCfpgz8HcP/Onf
 /FE0RkWZfBRFZG+0YsM/EJHB0GD3oWMkStlMTt2XLbeA1qbWYBjtUVBEkcpic7ldwOtL
 TWhg==
X-Gm-Message-State: AOJu0YyqMNG5NOTmXL0Mlqyl24YrYubZVjw7yP3wcXhFzTDGSmHAUDhB
 gKZDrR2aUG1c4tLbtUerJVn8xsPXD5rxpYHDcEaXk67+ofdmtREMnVhDzLx/Xh6Hpe4/HJhiZqa
 7IlUzK+L/0U+I8jY+Vwev8juznmahBBw58KvQBSOrZw==
X-Gm-Gg: AR+sD125xQHdma0kTJhbApRN4aK4pt9AAUhe6+1Dt6Ngw7vp75CeKD756KYz/czuS61
 EBqWTZYavx/QZ5lY43s47v0aUpSxA4vxFyisgxFrdqHmsfr7lfRVzc7KCQwN/8ygcXJLl8wbXUO
 ryqo4wJ6AwGwsHIWHrTcw1kFSbioAsIV8SM/E4TFXIGbqOqWiC6dBRJI/TPHkXSJG+jeDaK1wS+
 k/aKQgYQ0eq3p0fC9HVt8phN6hoZs8n3cpbDGN/eq/zGzrINH+t++lgyji/NeptyEXhfkOczu1Y
 i3oyZ0kdGiwl9fl097frV1KSPH/DDEYoOKlkaiDEbYzxQxFBwFElfav7BY5PE3jHVoEsC/TF2wA
 Kd+wSrqIYYJpPI8fbx4UU/GGFULXq
X-Received: by 2002:a17:907:8b90:b0:c20:5797:162c with SMTP id
 a640c23a62f3a-c212a2661b9mr1229457766b.16.1786984686314; Mon, 17 Aug 2026
 09:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260811191540.79882-1-richard.henderson@linaro.org>
 <20260811191540.79882-3-richard.henderson@linaro.org>
In-Reply-To: <20260811191540.79882-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Aug 2026 17:37:53 +0100
X-Gm-Features: AcwNN1XxFMbiFSJmoKnNcQ5umwc2ppAXNnwY_xYV0R7Ey7zHs22CxdTU08eo3ak
Message-ID: <CAFEAcA98oxLs-w1PNuoM9mArit=toTCTucD5xOmN29Rbk6XBTQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] target/arm: Fix SVE2 WHILEWR/WHILERW zero diff
 boundary case
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, yang.yanjun1@sanechips.com.cn, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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

On Tue, 11 Aug 2026 at 20:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The trans_WHILE_ptr function incorrectly handles the case where the
> address difference divided by ESIZE results in zero. This happens when
> the address difference is less than ESIZE but greater than zero.
>
> Fix by dropping direct comparisons of op0 vs op1, and instead
> testing the scaled diff vs 0.  Merge with the bounding to the
> maximum vector length via wrapping arithmetic.
>
> Reported-by: YanjunYang <yang.yanjun1@sanechips.com.cn>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sve.c | 38 +++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 14 deletions(-)


> -    /* Since we're bounded, pass as a 32-bit type.  */
> +    /*
> +     * If diff == 0, the condition is always true.  Also, bound to max.
> +     * Simplify
> +     *    diff = diff ? diff : max;
> +     *    diff = umin(diff, max);
> +     * via
> +     *    diff -= 1;
> +     *    diff = umin(diff, max - 1);
> +     *    diff += 1;
> +     * via 0 - 1 == UINT64_MAX.
> +     */
> +    tcg_gen_addi_i64(diff, diff, -1);
> +    tcg_gen_umin_i64(diff, diff, tcg_constant_i64((vsz >> a->esz) - 1));
> +
> +    /*
> +     * Since we're bounded, pass as a 32-bit type.
> +     * Sink the diff += 1 from above into the 32-bit type.

Is it worth doing that? Hosts are all 64-bits now, and surely there's
not going to be a perf or codesize difference between "add 1"
on a 32-bit type vs a 64-bit type ?

> +     */
>      t2 = tcg_temp_new_i32();
>      tcg_gen_extrl_i64_i32(t2, diff);
> +    tcg_gen_addi_i32(t2, t2, 1);
>
>      desc = FIELD_DP32(desc, PREDDESC, OPRSZ, vsz / 8);
>      desc = FIELD_DP32(desc, PREDDESC, ESZ, a->esz);

-- PMM

