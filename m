Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D92ECE8D72
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 10:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srEHs-00021k-H7; Thu, 19 Sep 2024 06:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1srEHq-0001yG-6U
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 06:21:22 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1srEHn-0004Bw-8a
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 06:21:20 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-374c4c6cb29so575534f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 03:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726741277; x=1727346077; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U1DumHjfyp4bGLUboS5do861nWw1i2OcupPD1jqOhb8=;
 b=CKHspiYmiNmSsh1iyutyqhJ16dIHVx8kDFH1xfUkbjC4G51QYvUxglLYfhM2olVc8j
 1yTe9hbQTtdYUWRv0akXydKu0BDPYtuFjWmUYozbay65WLq8RPuivJJGYCkRJU5RF4T7
 xWAPuGijsvEZJ4OMIcOIggpX8i41HlSZNVh6jqIOAOO6QXKyIuDAt50HK8hyerCFXMd5
 QynPlw89kB4zf+qcIfnCYbhjG+7FuXArWAJvOHntCnxVL+UfNbeNR+bznSh97NT+vRd4
 dltQWRU94i2yOMORMgvPV6E4Ksl1mbkjnRY9h0r8H5/XwCtIjibQtKmLQe4lgytRcaMp
 7rbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726741277; x=1727346077;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U1DumHjfyp4bGLUboS5do861nWw1i2OcupPD1jqOhb8=;
 b=GNVMO5D6v8Xv7gRj5mHlvRZOBkm1RBfzQi+/8A6QFr8V70siGDsBmctwxvo0DOA1ig
 uflwVxn128XrPRkJ8mzBQHymt9c9pG1Q6n0BrvU5jZr/3/+mBalTzGMZTf5rFeb8nHk2
 QMksmF3fxIEHfyaQmRTZPhwncxdQQL9pMJj3CfmOlYm1NXmcmE9KK4x2t80D6XXeVFMf
 wsKS3pWztA403loX/PJaBBDm5VgNP1xYjUKzdHjKROwwnja4HsJMu3YB1e5vyEE3iPNu
 nYG8nNEQ70XLC7kDTI4ZDvQ2O/CiuV3Zyeedcwr2FXp6mK7wFwS/TRGcwL+7Ue5R9oeP
 xcow==
X-Forwarded-Encrypted: i=1;
 AJvYcCX566404Ax6k8sg0SL8WcYNxFQI7lRReSyOMsIhJ4Xp35mVbbH0pJIxwd1leXxaddTUWDc1RRdj//dk@nongnu.org
X-Gm-Message-State: AOJu0Yy2pt9zWSarDok/sxhENEcSghj/rF0za4MUsJz68JXI8B3u9k94
 XabSm68C8LVIv7kosoeB48OxKKVMzLg5l8t5dTAGZQ4CV82hq9yA6R6yPWS8ueo=
X-Google-Smtp-Source: AGHT+IEssiU2cXNf+xFtpgQ9T1Z6TdhBg4366BbyUkqQnBGQKvgpwpmXuJTK85Rw4yars9cJkD3vMg==
X-Received: by 2002:a5d:6d84:0:b0:378:8b84:4de9 with SMTP id
 ffacd0b85a97d-378d61d4fd3mr23422458f8f.12.1726741276710; 
 Thu, 19 Sep 2024 03:21:16 -0700 (PDT)
Received: from [10.133.7.245] ([83.68.141.146])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610968cfsm700090466b.22.2024.09.19.03.21.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2024 03:21:16 -0700 (PDT)
Message-ID: <6acc2bfd-ceb0-4c36-b035-90e4f80663b5@linaro.org>
Date: Thu, 19 Sep 2024 12:21:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target-i386: Walk NPT in guest real mode
To: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Jan Kiszka <jan.kiszka@siemens.com>,
 Eduard Vlad <evlad@amazon.de>
References: <20240827135837.67077-1-graf@amazon.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240827135837.67077-1-graf@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
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

On 8/27/24 15:58, Alexander Graf wrote:
> When translating virtual to physical address with a guest CPU that
> supports nested paging (NPT), we need to perform every page table walk
> access indirectly through the NPT, which we correctly do.
> 
> However, we treat real mode (no page table walk) special: In that case,
> we currently just skip any walks and translate VA -> PA. With NPT
> enabled, we also need to then perform NPT walk to do GVA -> GPA -> HPA
> which we fail to do so far.
> 
> The net result of that is that TCG VMs with NPT enabled that execute
> real mode code (like SeaBIOS) end up with GPA==HPA mappings which means
> the guest accesses host code and data. This typically shows as failure
> to boot guests.
> 
> This patch changes the page walk logic for NPT enabled guests so that we
> always perform a GVA -> GPA translation, but simply provide a 1 GiB fake
> PTE when in real mode. That way, all remaining logic to walk the NPT
> stays and we successfully walk the NPT in real mode.
> 
> Fixes: fe441054bb3f0 ("target-i386: Add NPT support")
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Reported-by: Eduard Vlad <evlad@amazon.de>
> ---
>   target/i386/tcg/sysemu/excp_helper.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
> index 8fb05b1f53..17f45431f6 100644
> --- a/target/i386/tcg/sysemu/excp_helper.c
> +++ b/target/i386/tcg/sysemu/excp_helper.c
> @@ -298,7 +298,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
>           /* combine pde and pte nx, user and rw protections */
>           ptep &= pte ^ PG_NX_MASK;
>           page_size = 4096;
> -    } else {
> +    } else if (pg_mode) {
>           /*
>            * Page table level 2
>            */
> @@ -343,6 +343,12 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
>           ptep &= pte | PG_NX_MASK;
>           page_size = 4096;
>           rsvd_mask = 0;
> +    } else {
> +        /* No paging (real mode), let's assemble a fake 1:1 1GiB PTE */
> +        page_size = 0x40000000;
> +        pte = (in->addr & ~(page_size - 1)) | PG_DIRTY_MASK | PG_ACCESSED_MASK;
> +        ptep = PG_NX_MASK | PG_USER_MASK | PG_RW_MASK;
> +        rsvd_mask = 0;
>       }

It's better to emulate a 4k page. Large pages incur extra overhead in the softmmu tlb, 
because we expect to be able to flush the large page as well.

That said, the patch looks correct.


r~

