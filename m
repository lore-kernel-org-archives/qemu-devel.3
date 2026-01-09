Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAD0D277C1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 22:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veLAF-0005hg-3I; Fri, 09 Jan 2026 17:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veLA5-0005h5-8w
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 17:40:56 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veLA3-0004p6-Ps
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 17:40:53 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-81e8b1bdf0cso497939b3a.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 14:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767998450; x=1768603250; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CpDxcGuXWMMxPRHPw34vykmVYt94TKwH/xZdodNZMRU=;
 b=yl4KPs8lqB5FRHhVt2IYssHTeItjQBobVDAla3/+6BJEh9TYj2Fuc1+btfEWns+f1z
 X+NOAic7vy8OxeSnX05fMynNcWwI2u2FPWzuDAasZ9rPXVs3xhiCn/3nZ429ZLtvVL5p
 V8B77tF8VgqLLQlLsvDpMf8rWoEVxmd7Vg7G16CwkuUfeKZt119JOvymvY8wWt+tK3Yk
 n2zYJmONImjQYUFGeHBy2HP0Fg2RzAFa4E3MmcnENggXZRup3kfwYZ1PXR4rQTrqtz1i
 F5Bai/JcApBdOYtsOOPmfyTMbisNyrRuwEgmrkCoc1Avunp3yywM8bD9e7lx54nggwO+
 yhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767998450; x=1768603250;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CpDxcGuXWMMxPRHPw34vykmVYt94TKwH/xZdodNZMRU=;
 b=I1JbTLFROvBNW4ed5Cg0/3DsAfiOwOy7MWbXHO2l+jUXuZiAqRsgF9w5drFxYJlyKX
 kpYtBHQj7c86nzEvaIBYJn017uOXhMQUoe7aGsAK4wQIxDzBPp/LqCKvVofScdZzP/ZN
 AvUV6cYIUqkrECA06/NVx1ApcdhdgEFWmmctWcVzBe5D6dj8RxafoYOaYOtORNOF4rn7
 sEZfgrIgDlL2Lz2sPO+0btvWGRanmItPFjB+je5Dt8SPfENaqzzCUjkA9jp3awooPYaF
 URlvrGgnT513ROfDNDw7lGtwOsCiSRlqhF+MMmvMBRIDH9JneZz6645xPYe1iX3VB4dy
 3Dxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc13SVniGXv7xgTJI1UkAc0hFPKwl/jlN38cFu4MimB+R70QbrLEJeViKg1fgeLoZPffBNFpMMQwvT@nongnu.org
X-Gm-Message-State: AOJu0Yz+lAbvBHR5DZ1ZGZk/ywkVb/zqRIA9Q4AEALpe5Rlj8pxxNXAX
 rUnwULoX2RGJJcjuUhVQ6LbN8VmHYwh3FVIePPVSQHzpFGzh/86Q8Kqs6BHA3th/FF8NGBZNVwH
 3VQ0oD1g=
X-Gm-Gg: AY/fxX5R3cuzqo4D93AQPJoaKJZNNUAr4dfaDv6yHGkk40tu0kRCIcWnW7OIoFqxQd+
 edH0+XQsgaGhesqcZVjBaqGGTrYkHct/95GWi3fm3g2rkaqt95YCVHVDi3qXVMUgczwZfavfQVj
 PX/GCcCwphkUsv6SHAlAQ6JSzs4x24onATBJ5ZD4KVuKxYgPcO33le+ARTj4EhJexz8WMYbKstm
 gz9q76tjhdYjN4JOe4yDEI+ThdVGnUnk8wJtF6SlrzM88bSEe2ep0zFCHg69aGpLvTCy645idMV
 E4fdxEqQ6JNlhiit+HfaVA/iauSoEDW3N11Qi3JdgJrDjbNUcYeILoaMzg+6D43Sk7XEKsDED3w
 89Rqtpib2YdFSihWat/aKbPVjL0GKsiL3XsTlLNYrM12C45ih3TBVJW08GRAW1QB2sgRti96uzM
 w0PhmIFa2c5gDWbduluW69zojrfA==
X-Google-Smtp-Source: AGHT+IGluWKzp/zC5xmbbWZgdaUzjjIIdUxjaJHVIrqijw8Zg0q/A1+BOpSoZDl398nuUrr9TfoDtA==
X-Received: by 2002:a05:6a00:4b49:b0:81b:c285:be1f with SMTP id
 d2e1a72fcca58-81bc285be60mr8198064b3a.49.1767998449864; 
 Fri, 09 Jan 2026 14:40:49 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81dab89f2a5sm3740673b3a.56.2026.01.09.14.40.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 14:40:49 -0800 (PST)
Message-ID: <e0724f2e-dc05-4326-9b8d-056a28178aeb@linaro.org>
Date: Sat, 10 Jan 2026 09:40:42 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/29] target/arm/tcg/arm_ldst.h: replace target_ulong
 with uint64_t
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-25-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109053158.2800705-25-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 1/9/26 16:31, Pierrick Bouvier wrote:
> Allows to include this header without target specifics.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/arm_ldst.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/tcg/arm_ldst.h b/target/arm/tcg/arm_ldst.h
> index cee0548a1c7..0252e3b0ea9 100644
> --- a/target/arm/tcg/arm_ldst.h
> +++ b/target/arm/tcg/arm_ldst.h
> @@ -25,14 +25,14 @@
>   
>   /* Load an instruction and return it in the standard little-endian order */
>   static inline uint32_t arm_ldl_code(CPUARMState *env, DisasContextBase *s,
> -                                    target_ulong addr, bool sctlr_b)
> +                                    uint64_t addr, bool sctlr_b)
>   {
>       return translator_ldl_swap(env, s, addr, bswap_code(sctlr_b));
>   }
>   
>   /* Ditto, for a halfword (Thumb) instruction */
>   static inline uint16_t arm_lduw_code(CPUARMState *env, DisasContextBase* s,
> -                                     target_ulong addr, bool sctlr_b)
> +                                     uint64_t addr, bool sctlr_b)
>   {
>   #ifndef CONFIG_USER_ONLY
>       /* In big-endian (BE32) mode, adjacent Thumb instructions have been swapped

Oof.

So, aarch64 should do

-    insn = arm_ldl_code(env, &s->base, pc, s->sctlr_b);
+    insn = translator_ldl_end(env, &s->base, pc, MO_LE);

At which point this file is only used by aarch32.  At which point it might be clearer to 
use uint32_t for the address.

Also a reminder that at some point we should stop using translator_ldl_swap with its 
boolean "swap needed from TARGET_BIG_ENDIAN" entirely.


r~

