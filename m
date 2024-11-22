Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31AC6E69185
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 17:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEXnY-0007uL-7n; Fri, 22 Nov 2024 12:50:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEXnU-0007u1-HI
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 12:50:24 -0500
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEXnS-0006xn-TQ
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 12:50:24 -0500
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-294ec8e1d8aso1967327fac.1
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 09:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732297821; x=1732902621; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tlcmfPlJsvstY+LiKIrRcVYvmNFnpcJ2rR+abaKZhwg=;
 b=zs3Qcv4n2niCWwbWjh8RidvrfOMmGSzCFmu0cMWoyZOLfmJEyhHW/q9UmQ7gDbv45z
 Elm238oTjeqcuUP4h/VMNqGZldtn+l5KuZ3dAUaB8jnz7z6vN3pbo9WoWCBlxc7tlSJj
 /lcQDMO0SFaEOODndK8RdDl2l2PuD2CaB7Phcs2pHQKZuNLkvPAg0Rdw1mhoa/q4ssUa
 uA8FFaX6kr+R88ChoCNJF7tfsLfqNX0E9p+7VGeAjtYlQpphKAJtHPgSzH+IOM2kHf6w
 JY3zrsaMO4U9PaFjRz3lS3cHO8LpjbsGop7EkyuOPjvC7JtVpP73gdG5UuQ03sQhYKyH
 Zcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732297821; x=1732902621;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tlcmfPlJsvstY+LiKIrRcVYvmNFnpcJ2rR+abaKZhwg=;
 b=mxnYX/MbXa/Rl2nTaKbtXeKLvtBdArfWS1MMJttpyN5fQx38WZX9bvUMa62nzy5hqU
 UmCFoqgH29EXnFywLzekFD5GYaPi5UqSaWV/NHm5UlkeKZEgOJMIXMcYF2FbLDnEl+mz
 qY8j9SugNxcOBxt/tYOLmdPmAhBe/6RNi/oFHrS6kepz80aP9W7rHu+8pGrctE/Z5XtU
 pz+pwiIhUHgzuxoQBfXfi5dGdD9AHjuOkQFJXP8i9LNNLTTFPRZhvqa+1LJ4v9HU03Ui
 BueBF8lXw7LLY/5dkLcvYLHiFDQiIHO2HUZtyZKct2/P2MT1BeSAY2SOPH0iokBDdxtZ
 sDtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJU6z2ZfQXdQDDgs/qu91D4VHQhbYJC/1ymPZXsYckW5jSFyfxi8tz5rSxxlWI1CFPuyfPwFCfhUUE@nongnu.org
X-Gm-Message-State: AOJu0YxjNKj3uy9q5f8ReqlUl77HvJZyQkojd6VV0JSnGg6n+2kcGrLS
 BWOm0sT8uUBGA7c0+LqQbAhBWCsavsdT1k30804J6C7rd2qXV3HI0493kyGCX0M=
X-Gm-Gg: ASbGncvspBX1Pwche04k2/sFAZfuQUDY+FceTPwBwKXXPtcxJmH6+jhuopB1oCoGnqm
 FB6cX+u7pETL+QeB0lAGi0+Yhf4jQ9RIxkKxvV16XU270CM4wBdaeX/wc4coiN/IiI2I9k205Ee
 clAfF7EDKop4tmBRJgYBAzkB6bUJAzXpRbKGdzYaOIB7IejbFq9I9mtOyZgWBtSxaFW+das0JPs
 rlaLjwHb5/2y85BGpXG/nEGNZJRm0Ket64TprV0HMeCuEapn5gh7fjTrD71BSJIc6iKhv8=
X-Google-Smtp-Source: AGHT+IGFHW7S5xn44XSKhB8T7ml2iOSQ2Dxicp9X6ELmtdNFXUX8XXE6B1NwJUAUyjJVzEYEoIdxyQ==
X-Received: by 2002:a05:6870:6128:b0:297:28ee:8d24 with SMTP id
 586e51a60fabf-29728eeb040mr3419452fac.42.1732297821065; 
 Fri, 22 Nov 2024 09:50:21 -0800 (PST)
Received: from [192.168.170.227] ([187.210.107.181])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2971d88f849sm690951fac.49.2024.11.22.09.50.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 09:50:20 -0800 (PST)
Message-ID: <b2986b74-2c74-491b-90a1-9ec79367c2e8@linaro.org>
Date: Fri, 22 Nov 2024 11:50:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 03/43] accel/tcg: Add gvec size changing operations
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 philmd@linaro.org, alex.bennee@linaro.org
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-4-anjo@rev.ng>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241121014947.18666-4-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

On 11/20/24 19:49, Anton Johansson wrote:
> Adds new functions to the gvec API for truncating, sign- or zero
> extending vector elements.  Currently implemented as helper functions,
> these may be mapped onto host vector instructions in the future.
> 
> For the time being, allows translation of more complicated vector
> instructions by helper-to-tcg.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   accel/tcg/tcg-runtime-gvec.c     | 41 +++++++++++++++++
>   accel/tcg/tcg-runtime.h          | 22 +++++++++
>   include/tcg/tcg-op-gvec-common.h | 18 ++++++++
>   tcg/tcg-op-gvec.c                | 78 ++++++++++++++++++++++++++++++++
>   4 files changed, 159 insertions(+)
> 
> diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
> index afca89baa1..685c991e6a 100644
> --- a/accel/tcg/tcg-runtime-gvec.c
> +++ b/accel/tcg/tcg-runtime-gvec.c
> @@ -1569,3 +1569,44 @@ void HELPER(gvec_bitsel)(void *d, void *a, void *b, void *c, uint32_t desc)
>       }
>       clear_high(d, oprsz, desc);
>   }
> +
> +#define DO_SZ_OP1(NAME, DSTTY, SRCTY)                                      \
> +void HELPER(NAME)(void *d, void *a, uint32_t desc)                         \
> +{                                                                          \
> +    intptr_t oprsz = simd_oprsz(desc);                                     \
> +    intptr_t elsz = oprsz/sizeof(DSTTY);                                   \
> +    intptr_t i;                                                            \
> +                                                                           \
> +    for (i = 0; i < elsz; ++i) {                                           \
> +        SRCTY aa = *((SRCTY *) a + i);                                     \
> +        *((DSTTY *) d + i) = aa;                                           \
> +    }                                                                      \
> +    clear_high(d, oprsz, desc);                                            \

This formulation is not valid.

(1) Generic forms must *always* operate strictly on columns.  This formulation is either 
expanding a narrow vector to a wider vector or compressing a wider vector to a narrow vector.

(2) This takes no care for byte ordering of the data between columns.  This is where 
sticking strictly to columns helps, in that we can assume that data is host-endian *within 
the column*, but we cannot assume anything about the element indexing of ptr + i.

(3) This takes no care for element overlap if A == D.

The only form of sign/zero-extract that you may add generically is an alias for

   d[i] = a[i] & mask

or

   d[i] = (a[i] << shift) >> shift

where A and D use the same element type.  We could add new tcg opcodes for these 
(particularly the second, for sign-extension), though x86_64 does not support it, afaics.


r~

