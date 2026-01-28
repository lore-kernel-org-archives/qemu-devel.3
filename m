Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78861D35677
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 05:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkyRY-0004ky-L8; Wed, 28 Jan 2026 00:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vkyRQ-0004Wl-Ez
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 00:50:14 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vkyRO-00029s-RH
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 00:50:12 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-29f30233d8aso43271945ad.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 21:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769579409; x=1770184209; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mUrVo0AcbFsFAWEg7s2J+Pflj8KapV5/MPTPJ4i/QTM=;
 b=aVUzwUbklZ/Bxw4PozUTVRr3GSFueO2qslR6vJiqTHRyGtb2V8Q2ei4J+9mTvhdBFd
 kETuwZ0uBqbdxJMowVrVPoXSKqhX9YbscMRirjwzCqTvhMLZYjzzZUH9uMmVMwfF6zio
 0PTOCM+FoDAoIMlzIeIkgJItfRU4BfraPy4iUw6FSSjdLQkNxnhMwcx5nfIzo+ReincC
 CtY3VV1oXl3lWNmNFM0x9q29TyOzScDT8NWKMtBW5H/HsyvBSTMu18P19UVdtOM43Sbk
 I7iiPwrWbhBdx2eFvu1AMPtZE6WE9lByKHnrFJok4hui5w5Pjm8GcByb31+1sbYdqSUj
 gk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769579409; x=1770184209;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mUrVo0AcbFsFAWEg7s2J+Pflj8KapV5/MPTPJ4i/QTM=;
 b=cKBcF9S7NjcRl+omRv//wJRwZ9qg7ekbPPg6ZoazUWksTN+fUTBEYzsIdVE3ZZEKZr
 AfLoT4XNxN8GSzwlfxz+oCAWuXWNbz5ujdt5PbFcBpemJJDNwnSvLe5gz02jOMKlzgnZ
 u+B1wmii61b0WFDvUz2+CzcpL0nQTFS+esgVcFVPxXuoguY2V+sp9JmvG/GGGyh8bViU
 GXtR3oIscn1pWm46LN3UaRmvJdMrQRd/Hzfqu/fP/MeKU2vph2pJKGfkx9EvkNvB80Sw
 wlt/PTNVqntrzxF2j3LToRjf3gPlF6An1Z8KO6tX4lT5gOJNhEjjZV2WlJgjqdLLR2kE
 4niw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3WEBIm4NaOajFGI0EOjMFgnJlof18Nc4fIFvucAlbjHsQ6vg5O1hEG0TidKbN3fBobJieVvZy7e2G@nongnu.org
X-Gm-Message-State: AOJu0YwPHwvk9Cn1hxdknd9ujDCSI957ByLgo3RXFBmF5AZlZ+EXTWZP
 ttRbSuHLgGOeMNdSaLuh8kIIgj357JkePlTPesmGFXWj1NfunVOaMPn+/3dGM56U/eNb18oz7Rh
 Wjw7k5UA=
X-Gm-Gg: AZuq6aJWiXpWUNiGsg5G6B3Man2knonNqyStHN0qkjoiEvyQIV4NyNkdzmCr9VaHbnu
 J8ZWrv7QiSaK0S4O9Kj8odAYQuUAdOSJ9Lr7gg3c0Kqb8zEiEvAuNfi8ox41TybldWlFisBWDAI
 lRydoOyFgAlUxt8RaW64xI4K3i7Aokb4/6RbAdmv/MLlkAtuD1hE84n+RPSjKML9G393Pk82kKc
 Nf3XbNovm3ofQ2ZbMLUPDabwbMxwrHy81sOW6nxder8MIyyU1d5D6kygBZKVtW4KzYJJ970XWOK
 L9LUNm8yfuG7FENLfpFEcc5JVgvH/vopPXnVcT8EliJvzFGV1T2Vz8vlhclLS+WdO1foCpI80ka
 cr6ottghEYJKI59TjGIUaytE5cBlDQVmEuVKyMx1gksTbA9YWYr/puLq1spPsbd92xONGW9laOa
 RJsFF/0TMcqUh2+Nl0tz5isGeUWtuuYuJnDe05TWck
X-Received: by 2002:a17:903:4b07:b0:2a0:993b:d72a with SMTP id
 d9443c01a7336-2a870da13fcmr30490465ad.4.1769579409252; 
 Tue, 27 Jan 2026 21:50:09 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b5d9a7bsm10564055ad.79.2026.01.27.21.50.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jan 2026 21:50:08 -0800 (PST)
Message-ID: <66027136-d91b-478c-becc-0aa41b40c445@linaro.org>
Date: Wed, 28 Jan 2026 16:50:03 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] target/s390x: Implement DIVIDE TO INTEGER
To: Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260127153736.62730-1-iii@linux.ibm.com>
 <20260127153736.62730-4-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260127153736.62730-4-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 1/28/26 02:31, Ilya Leoshkevich wrote:
> +        FloatParts128 a128, b128, *m128, m128_buf, n128, *q128, q128_buf,
> +                      r128, *r128_precise;
> +        int float_exception_flags = 0;
> +        bool is_q128_smallish;
> +        uint32_t r_flags;
> +        int saved_flags;
> +
> +        /* Compute precise quotient */
> +        parts_float_to_float_widen(&a128, a, status);
> +        parts_float_to_float_widen(&b128, b, status);
> +        q128_buf = a128;
> +        q128 = parts_div(&q128_buf, &b128, status);

Why do you need FloatParts128?
You can see an inexact result from float64 with just FloatParts64.
C.f. soft_f64_div.

> +
> +        /* Final or partial case? */
> +        is_q128_smallish = q128->exp < (fmt->frac_size + 1);
> +
> +        /*
> +         * Final quotient is rounded using final-quotient-rounding method, and
> +         * partial quotient is rounded toward zero.
> +         *
> +         * Rounding of partial quotient may be inexact. This is the whole point
> +         * of distinguishing partial quotients, so ignore the exception.
> +         */
> +        n128 = *q128;
> +        saved_flags = status->float_exception_flags;
> +        parts_round_to_int(&n128,
> +                           is_q128_smallish ? final_quotient_rounding_mode :
> +                                              float_round_to_zero,
> +                           0, status, &float128_params);

float128_params is definitely wrong.  The rounding is supposed to be to the target format.

> +        float_exception_flags = saved_flags;
> +        parts_s390_precision_round_normal(&n128, fmt);

parts_round_to_int_normal already takes a rounding mode and frac_size.
It also returns whether or not the rounding was exact.
This appears to be trying to reinvent the wheel.

There's still "... the two integers closest to this precise quotient cannot be both be 
represented exactly in the precision of the quotent ..." to contend with.  Is that your 
"smallish" test?  If so, the comment could use some improvement.

> +
> +        /* Compute precise remainder */
> +        m128_buf = b128;
> +        m128 = parts_mul(&m128_buf, &n128, status);
> +        m128->sign = !m128->sign;
> +        status->float_exception_flags = 0;
> +        r128_precise = parts_addsub(m128, &a128, status, false);

Surely parts_muladd_scalbn (with scale 0).


r~

