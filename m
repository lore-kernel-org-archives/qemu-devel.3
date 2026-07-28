Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DC8C54F55
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 16:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wokoN-0000Iq-CT; Tue, 28 Jul 2026 12:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wokoI-0000Gx-Hq
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 12:37:42 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wokoH-0004fO-1C
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 12:37:42 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-81e9d8f3289so1181437b3.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:37:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785256660; cv=none;
 d=google.com; s=arc-20260327;
 b=CK496IjztiMzFQDanpcAmXAtO66mXWC0JE5oWK2oLI4D7X4Vv+AgqSMNDIBeHfsRH8
 4OO2YB7x0kA+NtxK8cL6bF2V/fIBAaMNgCSkJg8kozDYARCvgQqrOn9qu8ENQlXUEZGd
 dqMLgxSSkdlwyvHq/gnidCPMAD276b21B01FEHypwtQLhf6hefzkbF03nj0FsaukcpBn
 hWjYAIgwSWHkKiaOKl8u9MKibVBhR+XoPrggjrFe5u24NuhjgFYzbgY+Mz3qTc2F+8sx
 0MTM61wjbApRbmcs2RB4ojVGwKIYKy6I0yIFM6wQZgSA6ibOM8Dv8ZS6OzwWlasgA9v5
 +M9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HjVbGqXGHao/ljNfW8VTiFOvgtcWBnLzj9V9m6yRolE=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Njuk8/iYD26pQSDnjERnrcOnAvTo4END7iDu8xBeSs8b+IKLcL6d0kFBThEcPokpWc
 uW4gr+NH8TEReYDuPXOCHuZJM3EJDkwKrrtPj7uHsi/VtHGF+QQE/vdgEzrwWt2muved
 uMdWmPjhd88GIwo5xEkWXEFzeXQ52ZEuWcWhbQOmiIUcPJx8RJuN/kz1YMb/yoYu1e/X
 hX3Oeu9ASRTFlmwPceZeEXULCIFTTeLbE+AEh19c0R6WewxG+fRARyXCt3jqkbQVG4jV
 7WhSYvHNVYR6gJizO2PBeu98akvTlUVE9UxTpBKPJHV76q2Fh7j6fu2UNue7CeIgjY7o
 eM4g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785256660; x=1785861460; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HjVbGqXGHao/ljNfW8VTiFOvgtcWBnLzj9V9m6yRolE=;
 b=HkM5njLMw+Czu1DcaxGlyy9ENDIJUi7hT5np6cZSygQTUkw9Whyp0N84sHxBk7/MKq
 vVXPOW0jSZR2fGG4N55DMmRPQhHgYuq8gvcrgm+7cBkxdLLCqUJ/QZGffRr7fNSH8mMS
 Q2x0ZlXV7GkNBA91imF2yW+UAlpvIRxN7XZMUseGXecNrTarl3cnoclXkZ/lr8nuOI6c
 SP+BiuuuOJLLZ9i/fxFHejG50IiQGXis9iPlNpyr5Fx2K23ct5xGQQvIc7B/9ce4Ic6R
 K1ex4Y1jT2xj+GPTJjH+FbusA86I6XvM/SP8L1NSZt3PCjYP6iqixspegRlcfSK3LEsr
 8R3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785256660; x=1785861460;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HjVbGqXGHao/ljNfW8VTiFOvgtcWBnLzj9V9m6yRolE=;
 b=l7CQF9EzivLfcO3oJ6dQmm4xIqbkj+sRkUyme6lnXax79FDnTTPLk1lWPjUew8JheO
 PvbhGvtTh9x8I1EVrBvxiJBuxbjsEBpTvTjic4PDjemtJztOTHHHDL94GBnu5XKD31zC
 nw4JPySx3anNKM57mtaQP3JaVr72Tq9mzhyMqcw3PMpfxezKO/fhWvMjoYUFjZhW1gkc
 5/azmn1ToKAu7Iabtc/xpRAcgCwLA3ui7fzetZJKri3CpihmbVyCz1LHfUFmD+QDMagB
 vW8lEcChfDsetDdv9SOMx9x4YpH5nzJuqtFMkNo9/Qw6Asw1XQGWte3m5ETnSauOg3fK
 Z53Q==
X-Gm-Message-State: AOJu0YzeycEjTKVOWsMpvtsLTYYbOs7f7G3kq87TLpoTF0oYMuSewLEs
 lCbCpOhEDN6cY/YtydnQLhJyVJE87OkZqQgM7b03SbNCffQs+x6Fh705iu6tLetEGn+iipGEuMK
 R4Fly44ACD61AlgcpcpIWc2Eo2mXpOuuFNgwbT9oKjg==
X-Gm-Gg: AR+sD11gtK+d+p7hj83BrMB9F8ULR+yo1Hr4ZJXpjm7C943/mRjngskWUuEDkgXeRCF
 BVl5Z1EsSIK/GUkdMG9z7iaX3Ih3Ez1SqkD8+ZFi0nkSNi25k2zbqsqz55jaqNGol/4+AVBs3W9
 moMEtzdPaeDh7AJW/4Hurw9KpXwnBxDDcwsSIjz7IIgXDI4tk2otdY82C/GN7n3a68GH8fOr0eh
 NGr+X/l0qsT7UmdWw/Hg+crG2XYZ04rHP4XtHoFYQdvDR0kcjXyGw4ZF/4CO3MeBeH04M06Rcdq
 jmRyg//gP67LSOpVZGPyF10SSHt51eU87TBnI1ty96gLmw==
X-Received: by 2002:a05:690c:6b88:b0:81f:69e:1c70 with SMTP id
 00721157ae682-81f992042b8mr14821037b3.38.1785256659584; Tue, 28 Jul 2026
 09:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260721184656.530230-1-richard.henderson@linaro.org>
 <20260721184656.530230-20-richard.henderson@linaro.org>
In-Reply-To: <20260721184656.530230-20-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 17:37:28 +0100
X-Gm-Features: AUfX_mypG0BHWhwRLCWmj-v9L__GS1Lpd07uo9fqWHxjdBrJMKKE_aPWFXF2qLY
Message-ID: <CAFEAcA8SinMnnYyWxzbNsE-B9tB3TQ8KiXQem1KZ9Vt9sH5EEQ@mail.gmail.com>
Subject: Re: [PATCH 19/20] target/arm: Implement PMULL, PMLAL
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Tue, 21 Jul 2026 at 19:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---


> +void HELPER(sve_pmull_q)(void *vd, void *vn, void *vm, uint32_t desc)
> +{
> +    intptr_t opr_sz = simd_oprsz(desc);
> +    uint64_t *n = vn, *m = vm;
> +    Int128 *d0 = vd;
> +    Int128 *d1 = vd + sizeof(ARMVectorReg);
> +
> +    for (intptr_t i = 0; i < opr_sz / 16; ++i) {
> +        Int128 rl = clmul_64(n[2 * i + 0], m[2 * i + 0]);
> +        Int128 rh = clmul_64(n[2 * i + 1], m[2 * i + 1]);
> +        d0[i] = rl;
> +        d1[i] = rh;

Doesn't this put the two 64-bit halves of the results in the
wrong order on big-endian hosts? Compare how we handle
writing back the Int128 result in sve2_adcl_d.

> +    }
> +}
> +
> +void HELPER(sve_pmlal_q)(void *vd, void *vn, void *vm, uint32_t desc)
> +{
> +    intptr_t opr_sz = simd_oprsz(desc);
> +    uint64_t *n = vn, *m = vm;
> +    Int128 *d0 = vd;
> +    Int128 *d1 = vd + sizeof(ARMVectorReg);
> +
> +    for (intptr_t i = 0; i < opr_sz / 16; ++i) {
> +        Int128 rl = clmul_64(n[2 * i + 0], m[2 * i + 0]);
> +        Int128 rh = clmul_64(n[2 * i + 1], m[2 * i + 1]);
> +        d0[i] = int128_xor(d0[i], rl);
> +        d1[i] = int128_xor(d1[i], rh);
> +    }
> +}

Similarly here.

(The other places where we use Int128 in helpers -- ZIP, UZP,
TRN, and some moves -- don't need endianness handling as they
are just copying 128 bits of data from one vector to another
without interpreting it.)

thanks
-- PMM

