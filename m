Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F800C35FF3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 20:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tspdw-0001xS-5b; Thu, 13 Mar 2025 16:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspdn-0001mj-Sg
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:58:59 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspdm-00060o-7k
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:58:55 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2239c066347so31060085ad.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 13:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741899532; x=1742504332; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PUFdalzzhX2NquYirZtj/w6IMkAbB6TmNpRKxSrB1v4=;
 b=WJdzbPX7USgWXZKM9ii5k7Y4faFN5KmtodqFJgOrJHiZomnOvl1wb3GJghXofGCIME
 YpxRBRb4Co1iZVXPPGLxza4z0rYR1qCosj+mjGm4kgHd8stbf8ShhLRU2tRggZhDREVd
 7Wu6uiB3clBN1QuuO7JihJZTjC4d3B2D/ZzxTCHWRS6dHBC11OroeN8BoPG5fx9+4jbe
 86r9EAmGA0rvF00cKHXfBGiGQyosLUJvaFqGNtz/yCBdrG9suteLvdzSD7SbIE71xRLw
 dlHujsfWuVTY/5dU3Wdn3XvCzau1o/dLD/xxJrEP0h7tD99/b0RHnal2am6hAnhyYuS2
 FJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741899532; x=1742504332;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PUFdalzzhX2NquYirZtj/w6IMkAbB6TmNpRKxSrB1v4=;
 b=v+49LRe02MBgHWUKDABhJUhqSiP+YOb3IZ+rGV9S9Ij5OWoyNDrwSCMRhvxEQndXot
 VmUsLDIV2tsge1GiPAjrGCwaNuZf8InW+eMIw96g57oFJZg390sfZ5BRSq5SQFqEud9v
 t8b0DQ736iuoIAUNOzmYw1n+66/owm/cHbpiv3fPxQ08XeTjgPuns+qqta2kCjXTXR0K
 dRC/96oBz8m59EjjrkPSYwkGMooGbtCTPCV/gj3qq6BWPZWhd/H5FCNwa5+E/Tdm6lDk
 lfStBc3yzEj8khJX6xDx4+TTHjs1UGSW0/uHYe7XhPxK6OW4bm6c3e1y8dSjHu5sJTez
 EECQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmmTk/Y/5rY1hSILNyXVsUZTliCtK1mFW1Ga7aBTy35eA8y0xZbkoeubmNSdZPr7W/+v5xNn/oLBQv@nongnu.org
X-Gm-Message-State: AOJu0Yx9mq3W05tFzEeKtElNDFAPCDdm5Y8Cdfjt592EkMIeZqMpAYI7
 pgPCy9Ltt7gEzNHhSCEVbbK+SDoEdxQhQUfRh1WGfWjh9gH8tW0hyjKYfYAI4hM=
X-Gm-Gg: ASbGncvYlGHEmthL1n0C+PHDrgIder7SL522TNZUAvp00jkjQGvHs5KvmnVcKLRqvp7
 5YLfVRsjzT2ByaukBknrAoFNg1zM2RVQqKmjW7gHtYpAiqgXFIdez0IcwRrkuzgKz7cIRt53Efi
 9YLNzsnQu3MxFW/Koqc8NkKFD059n4kMhsl0ZkKTGJq8c9ZrfGXBTx4YYazCM8gspGTCR7mcZH0
 cfA1TU1cgjlOW7CnjqnHLqOk9rV5I8RTEsYm16P8qmZzAFQ/syU1MD5yoqkW0cbVKusxqo6sK/m
 wAiYrEnoS4+h1ZKF9YyP7TmN2hesDP0M+tVh0xMzNABn1TxssPsnDg2G8g==
X-Google-Smtp-Source: AGHT+IGx4fqH1sd+yDfuAA+FJQ1k2K0FUSeopO/S8ln7jgCKKXo5GjCRXdeY/P9ScUP/vZVrqDAz+Q==
X-Received: by 2002:a05:6a00:22d1:b0:72d:3b2e:fef9 with SMTP id
 d2e1a72fcca58-7371f19f8fcmr1136741b3a.20.1741899532571; 
 Thu, 13 Mar 2025 13:58:52 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-737116b378bsm1798030b3a.180.2025.03.13.13.58.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 13:58:52 -0700 (PDT)
Message-ID: <cd637c58-4353-4ac5-aac7-2739a0b30284@linaro.org>
Date: Thu, 13 Mar 2025 13:58:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 31/37] include/hw/core: Drop ifndef CONFIG_USER_ONLY from
 cpu.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-32-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-32-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

On 3/12/25 20:45, Richard Henderson wrote:
> We were hiding a number of declarations from user-only,
> although it hurts nothing to allow them.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/cpu.h | 10 ----------
>   1 file changed, 10 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 2fdb115b19..59394212fa 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -614,8 +614,6 @@ extern bool mttcg_enabled;
>    */
>   bool cpu_paging_enabled(const CPUState *cpu);
>   
> -#if !defined(CONFIG_USER_ONLY)
> -
>   /**
>    * cpu_get_memory_mapping:
>    * @cpu: The CPU whose memory mappings are to be obtained.
> @@ -676,8 +674,6 @@ int cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
>    */
>   GuestPanicInformation *cpu_get_crash_info(CPUState *cpu);
>   
> -#endif /* !CONFIG_USER_ONLY */
> -
>   /**
>    * CPUDumpFlags:
>    * @CPU_DUMP_CODE:
> @@ -701,7 +697,6 @@ enum CPUDumpFlags {
>    */
>   void cpu_dump_state(CPUState *cpu, FILE *f, int flags);
>   
> -#ifndef CONFIG_USER_ONLY
>   /**
>    * cpu_get_phys_page_attrs_debug:
>    * @cpu: The CPU to obtain the physical page address for.
> @@ -758,8 +753,6 @@ bool cpu_virtio_is_big_endian(CPUState *cpu);
>    */
>   bool cpu_has_work(CPUState *cpu);
>   
> -#endif /* CONFIG_USER_ONLY */
> -
>   /**
>    * cpu_list_add:
>    * @cpu: The CPU to be added to the list of CPUs.
> @@ -1143,8 +1136,6 @@ const char *target_name(void);
>   
>   #ifdef COMPILING_PER_TARGET
>   
> -#ifndef CONFIG_USER_ONLY
> -
>   extern const VMStateDescription vmstate_cpu_common;
>   
>   #define VMSTATE_CPU() {                                                     \
> @@ -1154,7 +1145,6 @@ extern const VMStateDescription vmstate_cpu_common;
>       .flags = VMS_STRUCT,                                                    \
>       .offset = 0,                                                            \
>   }
> -#endif /* !CONFIG_USER_ONLY */
>   
>   #endif /* COMPILING_PER_TARGET */
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


