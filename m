Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D953AC282C5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 21:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to83x-0008OD-Cw; Fri, 28 Feb 2025 16:38:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1to83w-0008Ny-61
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 16:38:28 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1to83u-0002a6-IG
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 16:38:27 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2f9b91dff71so4376378a91.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 13:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740778704; x=1741383504; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oVSXeoLPuIyXVeQOZf/09OMqiO8Nk2xKcYDdXHBsyQQ=;
 b=i5reTAemQ9ao4syMtbf66/Pb0RBAuFaJXDnLb+eRguFhEz29MDcjYxyQerBIfTdxsH
 YAIhpK1yjsbVM/RVeL3SAUBRB77tGWMux87HzWQc7gEz2L4lAxGAUWnge7muKCyqETF2
 PVM+AqqYCZ1BAXfcGfLNiBR0hPYr7gOlQe/gDPDh7RLLRAHJXNBK+/OA+AXtKZaH43Sw
 FoySgQAodUZweQmHkxUvWVK0kHfV/TnTaa97xswYAcd2Kk5O73WHNKLwF92REW9pb4Hs
 aXAlq0lxgr9E9oiAszcyW59zpQv/0KLRBWiZITY/qkDXZ5DaAvvm5RiNRr6z2FhfAtTb
 FXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740778704; x=1741383504;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oVSXeoLPuIyXVeQOZf/09OMqiO8Nk2xKcYDdXHBsyQQ=;
 b=DwPS2Sj0D4NpGY/B2OrovutYAEYMiRqd77smNI5TwYUUna4BuSqdG/ErpLNemzxU3I
 FsIz8oLUtaX+bFFh7hHFtYUrYVCQwcb/vIA12Hgy/lEh5CfFLhoFA6sb+307n5a3xlq3
 Ul8iH9i0cimyyNSy/3677FrXoilbtoN3sLF8IZ/LW9e7jKqNYOKZmffCi57xqDELRKtQ
 SB1+ECVR+NCc0T5KFYKf0p0GkXP+svYGLzlP/AiLVs5RfSgUtYYQMwpRCCf11Qx5mndb
 DLxofra7K1pWt5+cTY/jY3Ys75xlOZnk/b5zozsezPjgkEdELJhN+KUoruzWD4AI80YU
 Q+Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdyhBkhGymcpEUuEDtBDazFC15Z7p51rs553dvwKfajP4t47PorH74iU1IRLcd7aJ25QOJIx2Z4PMz@nongnu.org
X-Gm-Message-State: AOJu0YwT3CzDrGY+hbHfHh7j/tLKx6bzVgtZth7g6uUuCYge76wyyErS
 AAtDQWrJ1HUMPHjShAUjqRndb/meSTjhdVTg5XxjhpEwRiZKrvnrUEmtNKQ27iI=
X-Gm-Gg: ASbGnctbuKE/z5QVH4dkJWk0hlyQCvy9LRllpcpiSWkiAfBAwPx2jSigyS9dmQ4YiDR
 1HCpBeYh1AqCY7dv2RRI4ZKDMV3rrq23N6hfWPV/dtZGKUYb/wx3CYLpsYGvlWC5O+6DsBB2fyf
 Yi+AMRZ6ZxpxJ1NqSej9prJsa8mEqhVnnbJMiR7wpVJZzZoe38aSiJQBsP/S0UvDNMrW2Ewem9o
 JbLw63LD/yeeq4i6qUfAvEMytEUEm7qPjLpce3U/jtBqxaBW49BzALzoUxzV/mJWFD55hctPdfB
 H9/2lW1gIjFQb9sro6OswoAXcbVlRvfSMRIoQ5Gs69YvqIalP4rCX+eErgEDONtJuJhm2R0FhXY
 d/HJAmhI=
X-Google-Smtp-Source: AGHT+IEKPnk/tpY9OOaLsUXnNqnLGuqzuLEelDjYG8ZZM/VNsw5oMRtruUcerWHoCxVUzCGcmr75zQ==
X-Received: by 2002:a17:90b:4a01:b0:2fe:9fd4:58f4 with SMTP id
 98e67ed59e1d1-2febab78d41mr8633077a91.16.1740778704032; 
 Fri, 28 Feb 2025 13:38:24 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe6ded68ebsm6395110a91.1.2025.02.28.13.38.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 13:38:23 -0800 (PST)
Message-ID: <7771abbe-ab3f-43d8-9ac6-9ea0bc63b243@linaro.org>
Date: Fri, 28 Feb 2025 13:38:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: fix msan findings in translate-all
To: Patrick Venture <venture@google.com>, peter.maydell@linaro.org
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org,
 Peter Foley <pefoley@google.com>
References: <20250228212329.1775669-1-venture@google.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250228212329.1775669-1-venture@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 2/28/25 13:23, Patrick Venture wrote:
> From: Peter Foley <pefoley@google.com>
> 
> e.g.
>    Uninitialized value was created by an allocation of 'host_pc' in the stack frame
>    #0 0xaaaac07df87c in tb_gen_code third_party/qemu/accel/tcg/translate-all.c:297:5
> 
> Signed-off-by: Peter Foley <pefoley@google.com>
> Signed-off-by: Patrick Venture <venture@google.com>
> ---
>   accel/tcg/translate-all.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index d4189c7386..f584055a15 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -298,7 +298,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>       tcg_insn_unit *gen_code_buf;
>       int gen_code_size, search_size, max_insns;
>       int64_t ti;
> -    void *host_pc;
> +    void *host_pc = NULL;
>   
>       assert_memory_lock();
>       qemu_thread_jit_write();

False positive, because the error return exits without using the uninitialized value.
But if we do want to "fix" this, do it at the beginning of get_page_addr_code_hostp.

r~

