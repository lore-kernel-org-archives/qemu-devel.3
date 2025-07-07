Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E498C71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 19:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYrii-00059G-Aa; Mon, 07 Jul 2025 15:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYriX-0004uJ-0G
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 15:41:33 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYriV-0006cE-72
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 15:41:32 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4a9b08740e3so21183511cf.3
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 12:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751917290; x=1752522090; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yBVWDazkAqSpFZc3h4CUWkWuKD4FAAJ7y7dz4UisrEY=;
 b=Li28Tkx4Poex6NEFvjcUzCDBnRogM9t9Y7uBqQuwJhK9fYNe/7JE+2VppZhGico4KK
 R59EIkxCKdRwLwRKwKnWty+1hsBMxrkLhEhmiTnlF0FN+b2TbL8TKfUWZXbAHRK6DjbV
 yUspxPpMLOw3g3lr/kb0dQVCGB5ZtOzA4ZGPJxo1xKDwVWhdCMha26IUMWMxI/Ecq/tz
 gNxP0y+wQ1Gu7vXymhCACgXl1hWhr9BJYRrUrnDLDKnimUX06LbsT/qn4YvnX8KZjoGC
 itAPz+L85jbr8p+jXhsvG+MP8MdoYx58OSRTGAbX26i/5LAFJoKSPZVT0jS9WbiPazIA
 nApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751917290; x=1752522090;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yBVWDazkAqSpFZc3h4CUWkWuKD4FAAJ7y7dz4UisrEY=;
 b=IlPsNtyaeoMhwEsjyyBmwRIzFOT7QxO/FnhDGg9wV5GKAtCsmwZ+U2aiTW0o8XyYP5
 fN3FnElYxD8H24Tg9HXm+DuIPr/ev4CDXEl1zOpNvHQUAyySdoUZ7/rVdVDJZ6r5L8ze
 Y43GYSP9Skp7hy/uhmM2otA0w09FwfYi3nT0/ZRE7oRciT5Gm7wZD/M8+hUz1e0Ca8Oi
 x980wyrqRi6sNqfTeVIQfiBW/OLiLziePp+MlxSR/5SMKn5/e5h53zfY4tjvtxHR3uPy
 XTpXGe2N01GD6/e2IG1eeK1AAuz1U500rriZ58aExjwjxhDcyWMbysQUzipCvaoK0Y8M
 sOCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4VYddo4gOKRsvFDG9JwVH/GhAC9YjkdJ9/d5mo5YAitkCEoNbugwA9oYkzKogYHndpwYch4rBvPCo@nongnu.org
X-Gm-Message-State: AOJu0YwjSsr8/VqdW5WyFc6JWC3Z4VnUNqsE228p1uPwlxVU3wiZyuQD
 s9uqxDc8PUuPTlcBqjy1Yy0qOApqL7lEH4eM7hCqL//ZolkUGNlobZGhSwqxm1RWZsU=
X-Gm-Gg: ASbGncvDJKTuNPHVFTvDm2OR7eJQ9lReziPq9hZAGazYMWaDz1VOXsAOLlAQI12kxFj
 Q3/XpN+A8pwS5sUDTzbtHpwqbmDILqDT7p7Xk5fWyZOO4ql1Lq7VCckiqgj2OVeNGlZ4TJf9REO
 /VS/v8Lzq3rf+a8u3wvOyBtWn3aLa3jdjlFbWepH1hF9W5IPhlvd2S00n5mbV+GNwugMPco2f6F
 4opz2SWqeM3XR/SaB7YSdT8vrSpPO2Z+SMj4T6+ERJISI2yOtBoBhd9nElHjeZvTvZOtbJMg8uD
 e9MAiDOA8DWAE3CwVjW8QkQ/LZWHH5Ddxw8FCsJ7MKk6ooXxBLgMqPNYHT5Ynw6bztybSB3+abB
 PyOyN5F6dXrqQ/YuzCX9WMVzTD5I=
X-Google-Smtp-Source: AGHT+IGhhqIMfq4jkdNeyJocLPBdHaBkjPFyWiwJHiMr/CW0BF068M7sSLQPNbB1i+VWNlZvmJF1wA==
X-Received: by 2002:ac8:59c8:0:b0:4a3:96b7:2a73 with SMTP id
 d75a77b69052e-4a9cccb1011mr7214541cf.16.1751917289714; 
 Mon, 07 Jul 2025 12:41:29 -0700 (PDT)
Received: from [10.225.72.227] ([172.58.142.143])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a9949f99d1sm69053781cf.24.2025.07.07.12.41.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 12:41:29 -0700 (PDT)
Message-ID: <a5915062-d5d3-44a6-bfbf-f9c4e234a7ad@linaro.org>
Date: Mon, 7 Jul 2025 13:41:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/s390x/tcg: Use vaddr in s390_probe_access()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>
References: <20250707171059.3064-1-philmd@linaro.org>
 <20250707171059.3064-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250707171059.3064-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82f.google.com
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

On 7/7/25 11:10, Philippe Mathieu-Daudé wrote:
> Commit 70ebd9ce1cb ("s390x/tcg: Fault-safe memset") passed
> vaddr type to access_prepare(), and commit b6c636f2cd6
> ("s390x/tcg: Fault-safe memmove") to do_access_get_byte(),
> but declared S390Access::vaddr[1,2] as target_ulong.
> Directly declare these as vaddr type, and have
> s390_probe_access() use that type as argument.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/tcg/mem_helper.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
> index a03609a1406..f1acb1618f7 100644
> --- a/target/s390x/tcg/mem_helper.c
> +++ b/target/s390x/tcg/mem_helper.c
> @@ -126,8 +126,8 @@ static inline void cpu_stsize_data_ra(CPUS390XState *env, uint64_t addr,
>   
>   /* An access covers at most 4096 bytes and therefore at most two pages. */
>   typedef struct S390Access {
> -    target_ulong vaddr1;
> -    target_ulong vaddr2;
> +    vaddr vaddr1;
> +    vaddr vaddr2;
>       void *haddr1;
>       void *haddr2;
>       uint16_t size1;
> @@ -148,7 +148,7 @@ typedef struct S390Access {
>    * For !CONFIG_USER_ONLY, the TEC is stored stored to env->tlb_fill_tec.
>    * For CONFIG_USER_ONLY, the faulting address is stored to env->__excp_addr.
>    */
> -static inline int s390_probe_access(CPUArchState *env, target_ulong addr,
> +static inline int s390_probe_access(CPUArchState *env, vaddr addr,
>                                       int size, MMUAccessType access_type,
>                                       int mmu_idx, bool nonfault,
>                                       void **phost, uintptr_t ra)
> @@ -258,7 +258,7 @@ static void access_memset(CPUS390XState *env, S390Access *desta,
>   static uint8_t access_get_byte(CPUS390XState *env, S390Access *access,
>                                  int offset, uintptr_t ra)
>   {
> -    target_ulong vaddr = access->vaddr1;
> +    vaddr vaddr = access->vaddr1;
>       void *haddr = access->haddr1;
>   
>       if (unlikely(offset >= access->size1)) {
> @@ -278,7 +278,7 @@ static uint8_t access_get_byte(CPUS390XState *env, S390Access *access,
>   static void access_set_byte(CPUS390XState *env, S390Access *access,
>                               int offset, uint8_t byte, uintptr_t ra)
>   {
> -    target_ulong vaddr = access->vaddr1;
> +    vaddr vaddr = access->vaddr1;
>       void *haddr = access->haddr1;
>   
>       if (unlikely(offset >= access->size1)) {

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

