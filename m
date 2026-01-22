Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59D5C44508
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 01:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vij7a-0001P1-QU; Wed, 21 Jan 2026 20:04:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vij7X-0001Nh-4T
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 20:04:24 -0500
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vij7T-0005Z6-Ln
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 20:04:22 -0500
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-8c6af798a83so43074685a.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 17:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769043858; x=1769648658; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oJgz5/Tirme1OwVZTMI9gK3yyHV/veKxHLSX9HIx9lA=;
 b=lh2MJxZGYNEaWMJDm85WhaaQ7t6/dpYyS2g6GwjXHTBk26/3vU2Ddn0CLIBznc9zxu
 fDIKLMfKJ3icqJ+YM+g6hib/rt9hz2DpCnKwFrGFNGYRdfbLZquqJj2rt2FJUjSRMcdn
 5CSzsu7fKcJauhvOGTs1qzjjT+c8cju6kGRGxMOuQqkUeeKvvkO6w0Mbct3WBSlpBy6R
 r1w6JqT5aHfYxsfuAgMX08SxfhmatpkuwsZ4Rc2rINXgKxZ0/Wxk5hYK2FoYJiWGLnaw
 0ddWbz/+YqoQOlO7KEo+/zPMSa12fYN6rV3kv91LuRAvMDRmGOQinaW1BfHISv25icJZ
 rwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769043858; x=1769648658;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oJgz5/Tirme1OwVZTMI9gK3yyHV/veKxHLSX9HIx9lA=;
 b=dE/Wr4M/UZlkrm6r0tDuCyaRBiP85eindGaBDSYjMj4O7PjhArLzXKIfSmwH4hTumF
 F4Ook6kSaER708JrT03zFIaVgQbutbLq24lk73G+mE6bdoio4i59YhBFzBgt7YLuazb/
 oOvO0iwY+TGORypCi48fv7VLJA3Q4iiONbEr4RIErUgiOVnuVqIfVnq2K+Z/S/aoqD+q
 ZWzQae6Ah4nmqKNAL57RKzOBkIUTSX/75YeW/KotzE2UfSI9IVt4LS2rbG2TiSJ0sX76
 bFZ+ofE3RxeeUF7gBTAzs/C6Hv5v4WJrkT763gHaTUTwY0wUp0nSi/hQBZhktwPvnkXV
 +zaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLwptpmgF11StqsQ1oagrNFk4FVzM9qC3mb6YMJi4b7JpHrFC81hhgYRoOiNaSFcYZWea6wcM6r50X@nongnu.org
X-Gm-Message-State: AOJu0Yz5JNYz11l8vKCZwYYGLS7eFMgL4sdBzQZLh/c8F2nR+LgB0Wqe
 hl78Dt3lnYgTQ90SR0qA+++jjKWRjcaETkoek+Qr/+WeprX947IXKkWnvBn8nVnexg4=
X-Gm-Gg: AZuq6aIDMfyLz7GAJ7YoqIWPd/7aNrQDtYIfPMpcOuBPhkp1XsR7r1LyxHRrdOnofjn
 m56RdgfzUZHmZzVLTWOVoJ7ELdtPngcJueBPMYiXOtvVCCQ2yYiX5eyNFzBbYH6Kh2Mo610hxpU
 ULo7CwiYHoEySUJVqZ2HZwluEnDSzPM9pz6hbj0//7VpBOufgEVLd7wflktalGh8y/LScIm/TNi
 s7AMOnvXfu8vygE5PBxOOhv/wmb18q/j+fghTmdLXg7L7DFESrd6CkiSh6NRUXuwmxlreUb4fbX
 m3wEn+0KmYkWz9P5EaUb16Io+3DkBXXiWi1jpsXZcXk5qfM2pgZbLTwrMN4jTF3EbrCcrFMO07N
 DNn2PbfofQW9H3j08C0CGvKw7wqQuSo+9BYrpEzt/rFU0/hb42i/915gr2G5TCaZtnxMjGE/K5o
 e0e3cizBavN2lvUl2dsixcfhmsGnDJlY1PanDIACRW2/jSreBzZms=
X-Received: by 2002:a05:620a:19a9:b0:8b2:f962:79aa with SMTP id
 af79cd13be357-8c6a678383dmr2506234585a.72.1769043857969; 
 Wed, 21 Jan 2026 17:04:17 -0800 (PST)
Received: from [10.244.221.227] ([172.59.190.48])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6a72508f6sm1353258385a.34.2026.01.21.17.04.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jan 2026 17:04:17 -0800 (PST)
Message-ID: <64d55baf-ab07-4870-8f2d-d9cf3b68c4f6@linaro.org>
Date: Thu, 22 Jan 2026 12:04:07 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/s390x: Implement DIVIDE TO INTEGER
To: Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260121222116.713325-1-iii@linux.ibm.com>
 <20260121222116.713325-3-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260121222116.713325-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/22/26 09:12, Ilya Leoshkevich wrote:
> +static bool float128_is_int(float128 x)
> +{
> +    return extract64(x.high, 0, 48) == 0 && x.low == 0;
> +}

This isn't testing for integer, it's testing for 1.0eNN,
i.e. a power of two.

> +        /* Compute precise quotient */                                         \
> +        a128 = floatN ## _to_float128(a, &env->fpu_status);                    \
> +        b128 = floatN ## _to_float128(b, &env->fpu_status);                    \
> +        q128 = float128_div(a128, b128, &env->fpu_status);                     \
> +                                                                               \
> +        /* Final or partial case? */                                           \
> +        is_q128_smallish = float128_get_exp(q128) < p;                         \
> +        is_final = is_q128_smallish || float128_is_int(q128);                  \

The language from the manual,

# If the precise quotient is not an integer and the two
# integers closest to this precise quotient cannot both
# be represented exactly in the precision of the quotient ...

does not appear to be what you are computing here.
Certainly none of this relates to "precision of the quotient".

I would imagine that all of this would be easier to accomplish if you did this in fpu/ 
with FloatParts instead of continually swapping in and out of float128.


r~


