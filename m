Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9ADC77B7C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 21:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTSPA-0001bM-Bm; Sun, 22 Jun 2025 17:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTSP8-0001b5-Qw
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 17:39:10 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTSP7-0005Jj-25
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 17:39:10 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3138e64b42aso4279586a91.0
 for <qemu-devel@nongnu.org>; Sun, 22 Jun 2025 14:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750628347; x=1751233147; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ALtxWwvdmKlt2WwldVd2xKjq65joINy6GHm6ur6PrQk=;
 b=HDW2UHM91tf/JaxTTFFDAgh6Ua153M8zEeMHYfxKblZO8OWGjsL4KzAJly+jr2Jx27
 z2pqmeagf128knLNOMI+a7vvZtF94MKo+CMCwhkGIiMaL/XHMKvLJ+QHEL4nwMqBKn8K
 9Wfx+SS7CjDSPpu6B+mS+uaxhcQ9/wpNjMd0LoOhqj4d0diEBlrGbtZLdH6RKJe9oNsC
 5SwsXsrt+me4j9kFQGAduOS4DZ9XlBTZnYrzrWH4it7a1xmdmU8chUwbU1/V5fTaMY7i
 HffgzB+eMxqJ1OFabOP79hJPgV+Qitco4CQCC3noRkwzDXSul8WKBX+EYP7etx/Nf4JT
 L17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750628347; x=1751233147;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ALtxWwvdmKlt2WwldVd2xKjq65joINy6GHm6ur6PrQk=;
 b=bie03n86q9G2D/LkcaqkuYPsoRit4y7HhwnYxxNItvaBU3t1R4XaneqkxSi80YQ79/
 vhnQAzjW05JpADCvbZVoC8ZWZ73LI8fhbK4IpW1sdnBkWoDdmtxgsouNQXKkrffGmm+b
 GGoGDc3aHK30ZMsdxGDMas/WZuILUAcaRItVfgeHDlEGPPzBrAH/VhTbTrC8dZq0+Lhn
 P+zxgyKRKZ0zs7w9LUC9cz4qJbXZfKovkSOz7CsHlFk/Iwg4/T/BEDDM/fBePyHJHbcz
 fF++8fm3v7FQ7/A1TGK/vc/ZDERB+6sgCLyZr7Z5bK3SO5jrrmdHRhle7lZ1kofxaMIG
 UY9g==
X-Gm-Message-State: AOJu0Yz5qgluCyJP9aTmNsGf7s8oTohgtnigqSr88zYeTP8bgx7KoKSz
 meGKkbF8EIlH7eu/EltUQblSfDuLxw/UDx/Dj00K5VdWj8sersMQaHi3LLBEG42UPyEkFMs9Y7h
 f4NgT7ks=
X-Gm-Gg: ASbGncvTl8E3J4auMVBS3WjAC0Pg/V9t17QVFS9IKwiuO1dR3goztjxsn6VFkWkOP+L
 FBQmXqOFjQbd+/Z8ImcjnLE3Rbd+0e5fPgYsuKTQ5oAywIdFAlvbjJaJSToFZ2eaMiUm8A64VqT
 R4oya/Wu4hpBiLFIff9HF+U/q81Q7NmxPUL9V872X2MbJTdat+UHLJs2cpP3M3hYgSVD2rqe3QS
 1ylhWmXq5GWwvfPCUW0vst7e/zzXUHxl844YS7xAvJxjMdzJvVQ5PRWMdarrhBxdn0ppDU1TLrS
 fKmuUPpKcnio5VZJu+Y4tmG3dJJL0496S0N5SWHi6/rLWSmeO6/MD2lj8PS6FwtC1oa8C6luHOv
 d/eld2OlKkOdObjZEP8R6rB+cRnqwFIuA3dYZh/8=
X-Google-Smtp-Source: AGHT+IFTzy0b53LN1tjlxZvUAGbxJVzXXEgleDMa6k/k1d2xXHJGp06h7hMsUgRc61jq7h7eTBWMxA==
X-Received: by 2002:a17:90b:4a86:b0:313:1e60:584d with SMTP id
 98e67ed59e1d1-3159d636181mr16115503a91.11.1750628347032; 
 Sun, 22 Jun 2025 14:39:07 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3158a23e5a0sm8939371a91.17.2025.06.22.14.39.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Jun 2025 14:39:06 -0700 (PDT)
Message-ID: <1a650560-3683-4053-a6e3-c5b5ae20e4f1@linaro.org>
Date: Sun, 22 Jun 2025 14:39:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 085/101] target/arm: Implement CNTP (predicate as
 counter) for SME2/SVE2p1
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-86-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250621235037.74091-86-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 6/21/25 16:50, Richard Henderson wrote:
> +uint64_t HELPER(sve2p1_cntp_c)(uint32_t png, uint32_t desc)
> +{
> +    int pl = FIELD_EX32(desc, PREDDESC, OPRSZ);
> +    int vl = pl * 8;
> +    unsigned v_esz = FIELD_EX32(desc, PREDDESC, ESZ);
> +    int lg2_width = FIELD_EX32(desc, PREDDESC, DATA) + 1;
> +    unsigned p_esz;
> +    int p_count, maxelem;
> +    bool p_invert;
> +
> +    /* C.f. Arm pseudocode CounterToPredicate. */
> +    if ((png & 0xf) == 0) {
> +        /* Canonical false predicate. */
> +        return 0;
> +    }
> +    p_esz = ctz32(png);
> +
> +    /*
> +     * maxbit = log2(pl * 4)
> +     *        = log2(vl / 8 * 4)
> +     *        = log2(vl / 2)
> +     *        = log2(vl) - 1
> +     * maxbit_mask = ones<maxbit:0>
> +     *             = (1 << (maxbit + 1)) - 1
> +     *             = (1 << (log2(vl) - 1 + 1)) - 1
> +     *             = (1 << log2(vl)) - 1
> +     *             = pow2ceil(vl) - 1
> +     * Note that we keep count in bytes, not elements.
> +     */
> +    p_count = (png & (pow2ceil(vl) - 1)) >> 1;

This is too clever for it's own good, and misses masking out the esz bit we located via 
ctz above.  All of the predicate-as-counter insns suffer the same error.

I'll put all of the counter parsing into some helper functions.


r~

