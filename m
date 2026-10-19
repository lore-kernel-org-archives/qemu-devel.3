Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D442CCF2D5
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 10:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIkwJ-0002Es-8r; Mon, 19 Oct 2026 06:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xIkw0-0002E3-LM
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 06:49:42 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xIkvx-0002OP-Mg
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 06:49:39 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48df4e9d2d4so1168490f8f.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 03:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792406975; x=1793011775; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=c62Dje73RFz7aUgR1RqmuqQuyL1lqbFRk9ChisqZagg=;
 b=crX0jA6MoYWIJyXFaVqdO/LdaNftzPDbqWmQzNM2hBVJEQJWoV+IUpRle7kk7h8RQ4
 j3Z3I0yjpktpded+oWiTCuA96jIywTC00yt8H18e87yrhM9eQecroowt/UZqZLmRhyHX
 fqc5erQk9Ye5ZQEhCHHtXkAkDzxIfBqljCqaf42MB9AGR94pqhownDsrgX2Oakc5nBde
 S4PG44l7Iws03xI3tfCAtRE+m7kG0skzk1RN+pRlIbkkpI3eP9GEu/zYD0DWrwQyCpiX
 R4cFL6tpiBNzjlf3lD0qnRtIX5r9URzx9VxHPuL6BJAQg2PJKnQIkEBT9lfMS3Nm50iF
 yN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792406975; x=1793011775;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c62Dje73RFz7aUgR1RqmuqQuyL1lqbFRk9ChisqZagg=;
 b=VuDykC/2xofAo96HZn1ITtY8BicfILNVf60GqtCxZCzw2HNimQYmivOuY7wIIz1gMn
 q4jCe2ebFs91t5z4HLyVBnmc97bDyZrYUEnmvENNROwpClm4FrQan5jE7j9LwV1cYHpu
 wkl9rflmX0vGQgPYoOJwWplLtHpJPsV1XZ24Gr1XiiTt0eCq27I29fNZwMyY7tyQVDI7
 rQGvnhbY6pi6NsakkjQys7XcrQTt+03ADo0Y8pSMvsHBGCzOOKiVYjiRUSStBO9HbahD
 /QxTByQIAfi/C8l21Q6TIFUrQTNwRe9WDvwz4BPdzIeVlMUcD0OuJZDyJ83adL8Dm18M
 ya4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwqUUBhA+2YT8VpBd2iCC+clz0EFlAuVNnr0X57ErlpDe/FdVwa+W1IvEFSN2cJDu7Jm7ROUcYPQ0DZ@nongnu.org
X-Gm-Message-State: AFq9FYKpUfKKG0mEF67j1xgFxY05BUyeu9ipEqk2RF5ZsEgYFVwHzt19
 C9j8zgX95iO8Hw1/2CkRgjA3bya7bMA5aVnh2vBnDFtEyuwUzPasjTJ4Ya6GCYvoYoE=
X-Gm-Gg: AYBFou2AuuJXKQbU/xDaaegKSa44nvNB4wDEr1Ap1n0njrp/fVLGmgwqBMSqmxfR9zW
 V+5QfMI1hH+QqAnD7+kts2lwuTImYaGKKVaQGCZRC9RJvQ38dK1N9iOF6NQxmuBth+9AGIwpwRS
 0ojrDsDkkM4Dnh5hHkcNDwcHV8boqJeObMxJO/9XrgJZ4ZgLyAQSFzp7zGHMf1t0hQJPSHXFjyn
 uixY8gcKNMgE+DOEmjtUyH7cri4EoYe6xxbcmRVDffHGaRLrbnDI/25rBMxdKB9Bn2m6MrZK8Dg
 7tNqcq3aSDUPqfBGRbTBltfJ0iTIIApJRNJpDbYPxbl/7vgt2OAIPXKObfe3ShxX1/jiePNc3fd
 MYQZD0YUKXUWhFQfdNcSvhi4xgPnR4kUnLpe7GfqzzyzGyXZWfi9cl9ES5e9FB7vivnYql2upQm
 l/3lUURK78XyWyfiQ5/DiIlQC9MUAoOgMjuvmiEHlT3JlaavvJPp47pKcHvfS/DvJNSciiEHdNk
 kpi9RGqQNrxhRk1d+ZoQnROOnwpYVuE7HX8Iec/QbA/kJm4xVBGvft41Q8ZLA==
X-Received: by 2002:a05:6000:260a:b0:486:f9ea:796f with SMTP id
 ffacd0b85a97d-48e07fa67d5mr14426185f8f.41.1792406974550; 
 Mon, 19 Oct 2026 03:49:34 -0700 (PDT)
Received: from [10.89.180.227] (cust-east-par-46-193-64-64.cust.wifirst.net.
 [46.193.64.64]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4c575esm19727608f8f.10.2026.10.19.03.49.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 03:49:32 -0700 (PDT)
Message-ID: <89dbc7bf-fefd-4e74-a5ca-1e36c1614e50@linaro.org>
Date: Mon, 19 Oct 2026 12:49:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] target/alpha: Determine tininess from the
 delivered result
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20261016-alpha-fpcr-status-s-v2-0-4719bec02b3b@gmail.com>
 <20261016-alpha-fpcr-status-s-v2-2-4719bec02b3b@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261016-alpha-fpcr-status-s-v2-2-4719bec02b3b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
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

On 10/17/26 02:58, Matt Turner wrote:
> Alpha raises underflow only if the result it delivers is tiny.
> softfloat implements IEEE 754 tininess after rounding, which rounds as
> if the exponent range were unbounded.  The two disagree about a result
> that rounds up to the smallest normal:
> 
>    0x4p-1024 / 0x1.0000000000001p+0 in FE_UPWARD = 0x4p-1024
> 
> The binade below DBL_MIN has a finer spacing than the denormals, so
> with an unbounded exponent the quotient rounds to a value below
> DBL_MIN and softfloat raises underflow.  Alpha does not.  glibc marks
> math/test-float32x-float64-div as XFAIL on Alpha because of this
> (glibc commit a32db99a38), and under qemu that test unexpectedly
> passes.
> 
> Every result that is tiny by Alpha's rule is also tiny by the IEEE
> one, so there is no need for another tininess mode in softfloat.  Pass
> soft_to_fpcr_exc whether the delivered result is normal, and drop
> underflow when it is.  Only the S and T format add, sub, mul, div and
> cvtts helpers can underflow; the rest pass false.
> 
> An insn with a denormal operand is different.  Unless DNZ is set it
> traps for software completion and the kernel computes the result, and
> the kernel's emulation raises underflow in the same situation:
> 
>    0x3.ffffffffffffcp-1024 / 0x1.fffffffffffffp-1 in FE_UPWARD
>      = 0x4p-1024, FPCR_UNF set
> 
> That result is tiny whether tininess is detected before rounding, as
> math-emu does, or after rounding, as softfloat does.  linux-user
> computes these results in the helper instead of trapping, so keep
> softfloat's underflow when float_flag_input_denormal_used is set.  That
> check is for CONFIG_USER_ONLY only: in system mode gen_ieee_input raises
> the trap before the helper runs, and with DNZ set the operand is flushed
> rather than used.
> 
> Signed-off-by: Matt Turner<mattst88@gmail.com>
> ---
>   target/alpha/fpu_helper.c | 60 +++++++++++++++++++++++++++++++----------------
>   1 file changed, 40 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

