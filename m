Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4871109E544
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 03:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5awd-0003nR-5h; Wed, 25 Mar 2026 22:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5awb-0003mv-NQ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:59:37 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5awZ-0006xa-2K
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 22:59:37 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2b0afa0210bso2405915ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 19:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774493973; x=1775098773; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m1i7pRLeFLeE1svmsj8MHRCyvRzAt2KXbp3Nf8GJ1hU=;
 b=KwQ2PqCXfRKsvlHyi4GH6+eF7RfzdmLHjp6TYAUQ6X7f+sVPTCBXQZjrTwOelSCAdx
 snTzANMA0eiaRJeDSMiQsZ4XaKEjW3DsahxcWOUBrprGenYQQHs+ynqz+F8Hy4LEp4ed
 3zSG/sq2ev4j9DkYfkDFnA4OXqTzFOXrJnEwbkaCTFzePSSWW37ytRLPgR2cRGFvmuWx
 gGJ0EyxhvRETbWXeq1CV9JvSbzYFH6b9O4beeLVJSjg3hCwlvr1NU8c49c8huzi/riWG
 DF/i9v74gfhdODqM2hExOIj+ykVIwZPIamkE42Mf0IpiihCxyZAP2NdDrMGvcVz0n+ef
 hfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774493973; x=1775098773;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m1i7pRLeFLeE1svmsj8MHRCyvRzAt2KXbp3Nf8GJ1hU=;
 b=BzJbL7M/CspHikX9f4N/U1567GLx4c2p76GSsvvOBqxUgP/uEch5aFWnJVfVn00jBJ
 DqRgQavHjYrsv6nsKBgBFk73ljQ36CJNHKxW/5R30WYuFKbu4B/IF6BjqFm2C2dYPorT
 6qsMrPf1XncJOOqT4R7s+6duFBbcgMfo87Kr6Dovw5vc8KX0IQFMvkjNavTLPH1l5GWs
 Sw0qUhcZTDgFP2qhzCPuCHEPuYmGbrPjPNtoTUDFo60hP0g+8DsSWxmUpNe+xyRmsvxN
 Jxt4M29/dla76YU7DikETnstCrzIZShHj6Rm5WIixuBws0GyKE/44oo29GnpuoIzCUco
 0oKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlNDACHZjiubQraJjsjKeij5L+vYoaIfjP7bK9W993hBzwXbcL41n0OJ2H3gB6qXgt4t2BW8SP1NEn@nongnu.org
X-Gm-Message-State: AOJu0YwJVx3qMcF2j5szMst3q+of53b/t35SfH0KeZ3kh0Ty+2eJSAHR
 Mr5nF8JGReeRpA8kEXwc4M+0XWwM4xUkfuvXMchaun8QdYjHEh1on5DUiVXlpPvuEhQ=
X-Gm-Gg: ATEYQzx3HnRsJJ3jn2C6+QYV1UoIYEzFz9pH6YEYbaSP25fTfmtcpyKuWDh+59dkGGT
 0rg+whtixm4eH5qimBhV1p6KHnsuZFIU1PUbb8vQp26sb+wn6ZsqNbTJlKYUBlfZ/1V8G6rTa0K
 errj6s9nZQFcWCTKDLJT5TIvs+3j4FjjBQ8UXtpvpZHtkxx9RXRyJF5hKA34Gti/XuLW9zrcS5k
 yDc7DGiusHN6GIY4TmgYbknvJEkL9tTZAL30xo9DkHPTxZT6Si0JAd7tn37G14GUfNux1zdr6Av
 lph9LuyKoJI1pBneHE7Q7JmLF4q1mV1jCrkF5ei4kPhbELUh3ZrrsT7gdfeI3OdwKqmi4q/+Tqr
 7IWyJLST0EJc7xK6luxtI0KVnXX9lDTsHb8QvcRN9nVwF+1HyIojfDQr3uSuIA0TTKeWgNI6k+U
 3BKNkIdFW/ScWHmJ5VL8GkLjYkbQmMuzhE9B1WKjmzRg==
X-Received: by 2002:a17:902:d48c:b0:2aa:d60c:d48a with SMTP id
 d9443c01a7336-2b0b09a08d7mr64319245ad.7.1774493973212; 
 Wed, 25 Mar 2026 19:59:33 -0700 (PDT)
Received: from [172.16.11.156] ([103.100.225.140])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc7c26b8sm12546915ad.35.2026.03.25.19.59.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 19:59:32 -0700 (PDT)
Message-ID: <8019fdfe-3c32-4b81-84b9-eb961dbabf6f@linaro.org>
Date: Thu, 26 Mar 2026 12:59:24 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] target/arm/emulate: add load/store pair
To: Lucas Amaral <lucaaamaral@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 mohamed@unpredictable.fr, alex.bennee@linaro.org
References: <20260317174740.31674-1-lucaaamaral@gmail.com>
 <20260317174740.31674-4-lucaaamaral@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260317174740.31674-4-lucaaamaral@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 3/18/26 03:47, Lucas Amaral wrote:
> +/*
> + * Load/store pair: STP, LDP, STNP, LDNP, STGP, LDPSW
> + * (DDI 0487 C3.3.14 -- C3.3.16)
> + */
> +
> +static bool trans_STP(DisasContext *ctx, arg_ldstpair *a)
> +{
> +    int esize = 1 << a->sz;                   /* 4 or 8 bytes */
> +    int64_t offset = (int64_t)a->imm << a->sz;
> +    uint64_t base = base_read(ctx, a->rn);
> +    uint64_t va = a->p ? base : base + offset; /* post-index: unmodified base */
> +    uint8_t buf[16];                           /* max 2 x 8 bytes */
> +
> +    uint64_t v1 = gpr_read(ctx, a->rt);
> +    uint64_t v2 = gpr_read(ctx, a->rt2);
> +    memcpy(buf, &v1, esize);
> +    memcpy(buf + esize, &v2, esize);
> +
> +    if (mem_write(ctx, va, buf, 2 * esize) != 0) {
> +        return true;
> +    }
> +
> +    if (a->w) {
> +        base_write(ctx, a->rn, base + offset);
> +    }
> +    return true;
> +}
> +
> +static bool trans_LDP(DisasContext *ctx, arg_ldstpair *a)
> +{
> +    int esize = 1 << a->sz;
> +    int64_t offset = (int64_t)a->imm << a->sz;
> +    uint64_t base = base_read(ctx, a->rn);
> +    uint64_t va = a->p ? base : base + offset;
> +    uint8_t buf[16];
> +    uint64_t v1 = 0, v2 = 0;
> +
> +    if (mem_read(ctx, va, buf, 2 * esize) != 0) {
> +        return true;
> +    }
> +    memcpy(&v1, buf, esize);
> +    memcpy(&v2, buf + esize, esize);
> +
> +    /* LDPSW: sign-extend 32-bit values to 64-bit (sign=1, sz=2) */
> +    if (a->sign) {
> +        v1 = sign_extend(v1, 8 * esize);
> +        v2 = sign_extend(v2, 8 * esize);
> +    }
> +
> +    gpr_write(ctx, a->rt, v1);
> +    gpr_write(ctx, a->rt2, v2);
> +
> +    if (a->w) {
> +        base_write(ctx, a->rn, base + offset);
> +    }
> +    return true;
> +}

The copy into v1 and v2 is dodgy.  While I expect that we'll never support big-endian 
aarch64 as a host, this can be written in a non-dodgy way.

The assignment into rt and rt2 must take the *guest* endianness into consideration, and 
that is something that we support.


r~


