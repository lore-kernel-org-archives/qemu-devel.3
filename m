Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9C2FB5177
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 22:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9sgV-0000DA-7y; Mon, 06 Apr 2026 18:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9sgP-0000CP-PI
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 18:44:38 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w9sgN-0002ff-2x
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 18:44:36 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2b0afa0210bso21577035ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 15:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775515473; x=1776120273; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zvXhDjYnYtVNwbnXjtKNimWnxYsLtxLlAw52HESpNFc=;
 b=UPtFBFEB3KqXf8XQuYZ2HZTj7uEDDEFhisW7xvvIJcU3lhGlN86AEe6esHqNMYVY72
 DM2pKW61PZ8rgYUDHkDDKKOu6Be0yI3XiAuZLYPiDg8ESMJkACGy0CN8d0psUnPMlDB0
 hCYUqIDGSAsiJ8veYKgT0kudwH79jPm4KK1GtIIdgOqOXx05nBDtJHtyPJY9Bdi6Vi8c
 beEqc6ZEW7fhskSYJKIGDkRI5bNeRxMICcLhshn+L6RBiv3Hy50r0kL9oOtlPQ7O6yzu
 kFyGmOdhKVMziKGm/4KJLuaa0/dIQjnrdEh/X16IzBh4W6BqBBz1LOO0uHytmbt0su7F
 9G3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775515473; x=1776120273;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zvXhDjYnYtVNwbnXjtKNimWnxYsLtxLlAw52HESpNFc=;
 b=Cp8ZzjvVNj5FPw5N3cEE+ZmgWQMVQSPDW+bEMmGtZnq+gqWU5phZzjE+/JJLUZBuuO
 ioeoIl5aapS474+wics7P/xvISgYCmJ1KZ4WGN8lduSNqBVV5Zj7H+rTIgXZHmd/DN4R
 EYutQr7sUlCggCuNw0pArQgqs4ornON9IhXwXxSrBHCWVsb+5zHRFBfq2leVB2Tb+UYV
 B+fln9t9XqbJRkLVdD0etUfwgoH2L9On62aGZbfYX2/j9yWUGL3lb0QkN3zF+KNf0But
 enFPASnVZGgVB/xTDEuuS+Lc0cZnyMuO4ntKYUaPad24iB3ROhfJdgV12OniFssrqTVy
 OfHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGj/HeYxMhQoBRlpy+8vdYp1O+ADMGGgpV7YXz8wAeeG9fLflSMm4WSSO+qfUtlPNl/WdyoJOcA1P2@nongnu.org
X-Gm-Message-State: AOJu0YyAjiznbXfRpY0XnHyVIj9w4nRyQfspDMoCWZnuD5w9r6Mac+y7
 lk2oFlkkrChr7vSmYudjlJFPdqJx5Nf8IF3Gwoy6EEAF+5fIpJl5uXg/QmngVIDTHcw=
X-Gm-Gg: AeBDiesbpo4q7YiXDbcLtXXIVHBFERRHSSOuUdulmwN/Sd6zAaRSmrzh6kTVLeTIWsC
 gbYc2x1O69OTU+t8B4gBx3pDmiy8gtqBSzfMZA5GxdrK+B2VnHs5Kc8gRVtI+bOlcJdmFHKSSmC
 h7zP5k4iy1OwAY7PX2JIqTqsI4KWrQNeG1g1CjEBKpD9uP9uvlNYPFnnVHyZdl9o/FOqo4vDa01
 gTUBqfuddgysUs/rQ2CWT31QqyZm+tG8qDtrmFSG2LGxIOe9tZ9ehgXcOukUVJT94i8E+/nMvdA
 zHrt3bBsuTnVA72UnH8x37aMMQx3OWJwJc8zGYTzZtQ4PjmV5OtnAB6TZ17FfAVwrNsyLhBeI1Q
 gaOjQYKrDHKGQLpfBWRspUEyDbLEOj8smmKVPkAQhqSe75qsrf5+/rWwmnDBk4BI1G1CVoTsq++
 foSstVu/wb+TfPslF8T0l8ishS2IteOad917S9hmD7JqlE/V7qPIRuwvUee7d1ZODiQto=
X-Received: by 2002:a17:903:1ac3:b0:2b0:673a:7c85 with SMTP id
 d9443c01a7336-2b2818ee1f6mr145864265ad.37.1775515473404; 
 Mon, 06 Apr 2026 15:44:33 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274735633sm152962945ad.6.2026.04.06.15.44.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2026 15:44:33 -0700 (PDT)
Message-ID: <8e3bcc46-abe2-431b-8fb5-e6d5d8bd0e10@linaro.org>
Date: Tue, 7 Apr 2026 08:44:26 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 18/20] target/arm/tcg/translate.c: remove target_ulong
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-arm@nongnu.org
References: <20260406182609.193886-1-pierrick.bouvier@linaro.org>
 <20260406182609.193886-19-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260406182609.193886-19-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 4/7/26 04:26, Pierrick Bouvier wrote:
> We can replace it with uint32_t, because we know it's limited to 32-bit
> target.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index 68f050746d4..aea38507ef4 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -6288,7 +6288,7 @@ static MemOp arm_memop_endian_swap(bool sctlr_b)
>   
>   /* Ditto, for a halfword (Thumb) instruction */
>   static inline uint16_t arm_lduw_code(CPUARMState *env, DisasContextBase* s,
> -                                     target_ulong addr, bool sctlr_b)
> +                                     uint32_t addr, bool sctlr_b)
>   {
>   #ifndef CONFIG_USER_ONLY
>       /* In big-endian (BE32) mode, adjacent Thumb instructions have been swapped
> @@ -6536,7 +6536,7 @@ static void arm_post_translate_insn(DisasContext *dc)
>   
>   /* Load an instruction and return it in the standard little-endian order */
>   static inline uint32_t arm_ldl_code(CPUARMState *env, DisasContextBase *s,
> -                                    target_ulong addr, bool sctlr_b)
> +                                    uint32_t addr, bool sctlr_b)
>   {
>       return translator_ldl_end(env, s, addr, arm_memop_endian_swap(sctlr_b));
>   }


