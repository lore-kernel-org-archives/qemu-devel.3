Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92536C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 12:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzEXg-0002Qt-UI; Mon, 31 Mar 2025 08:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzEXU-0002Pr-Uc
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:46:54 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzEXN-0008UQ-MS
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:46:50 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so30282935e9.1
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 05:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743425202; x=1744030002; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i/aglC2YOHntbhaqIo25e9bN1l83NTsJkSapPgjChFE=;
 b=lrP+Z0++dXRwHEvYZA2kTXALIYsI2Z5HbHh2gE0nns9L+ocbwGwQlkp/YimwspsK7s
 Y6xxiO30olf3EArYwAl8Ac1t5ox51VIIUT+xzG8bwTJu2bqLBDu3maAEeNGbH+h+cN/p
 JspL/O3X2+MtIrW0bnfflguSqZ2wdjWrDyRmfMGW+xhIrPu++h8TqX848u7uPLMxG971
 WpfnKIkcmwu43DbBxJMLwfCRoh3CKeMYK/6we1zGWWIQc3+phmn3ZEsjWRHn8IToabTG
 +PEWnsNEg/ESoy3Osr3x0H/fR6Aw61WFo2yQwcEuSYLXLpNCZkX9RXD5W/dyMn8SqMgK
 uGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743425202; x=1744030002;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i/aglC2YOHntbhaqIo25e9bN1l83NTsJkSapPgjChFE=;
 b=OzkHw1OIx/vI6gsKd6uEwp3UQGYo5USES4++r3eqLbNuB0czc17J2awdwallf79tQU
 /bF1hODpPP2sj9QqX7tOCgxyfMV4eH8C60J8O9dbN+Ev4cr+kxszIheaU6UKliT4T121
 LnDSX8fSA3xLjzFgEv3BDMPpa5k9vR/avSNiZPJXOdXRiHSeZGOPDpeNyTxnAQPvpHAj
 WlxQ4GiXkq6Uo4KOnaH+tzRVtBs4Uc/VyLvUsBpoKpIBu1TVZAY/IML5HN6Dc4o6NbxR
 L9Yn9afyQQ9EiES/vvNoRqC+5FmWmKv/a4xhdebfCgkf0T8qnqIZSvl5HzmjEXxErt9e
 zHbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfLYW3M2xj7R6JPf1O/LDAmVSqrcC/zg+SLXM/EgjQK9YaQ6LmTCN4xv0z1bSIXrSo2i4xDS7sCPMy@nongnu.org
X-Gm-Message-State: AOJu0Yy8znEZ/6p6tRCXUEZqcr+NBU7buO+PT8ENq171xT/77AeYaQ0x
 TacgwROyiYQ/9ji+d5TeH2Zr00xGADmNxP3XfNrAsw71dmCqiLsVstBQV7C23AE=
X-Gm-Gg: ASbGncuh7Rm+Ci6Ap5twrKw7Ony3niKtT1MiB/J6JylaaB1mlKuPj33BjblOqIOFAPG
 xSghc2dM1D7JYfZ1XDTqKZfwKICqpKoFk7FLgiYYgHCwuEtioawQ2hgFQb50L1wb1cKlpaS5s2v
 uYXs3APAXhyO293+zshismCmTetPQ+fsJ6Dfp+R4Quc4mAPNQVC77KlF4bdNKZh9Dpz9gszvb17
 LCsaAoHV5N9yZMFyltE3V80jpieGtOGFDzjJCcAP5yy7jmguXyI90V6IdkdftzwSsLTatcIm886
 JPccKdNK/REevkYZBSBUaTyHI5jwZGW0Sa4dt4ihejZi3kWzUrJ3h6ThXK/X6df7X5pNZrKq/38
 afbkSnsiARFsG
X-Google-Smtp-Source: AGHT+IG6hK2a5kdhXYxFQrjxC/j/Y+8rEAZfG//VhpcKLbpRg8uvUiI6mIQDPt4G1X7im42TW8YoYA==
X-Received: by 2002:a7b:cb04:0:b0:43b:cb12:ba6d with SMTP id
 5b1f17b1804b1-43ddcc68c4bmr61646675e9.3.1743425202431; 
 Mon, 31 Mar 2025 05:46:42 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d90000a09sm120059435e9.35.2025.03.31.05.46.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 05:46:41 -0700 (PDT)
Message-ID: <313a1ccc-18e1-4d2e-8eb2-1d36f820ba15@linaro.org>
Date: Mon, 31 Mar 2025 14:46:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/mips: Revert TARGET_PAGE_BITS_VARY
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: chenhuacai@kernel.org, jiaxun.yang@flygoat.com, arikalo@gmail.com
References: <20250328175526.368121-1-richard.henderson@linaro.org>
 <20250328175526.368121-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250328175526.368121-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 28/3/25 18:55, Richard Henderson wrote:
> Revert ee3863b9d41 and a08d60bc6c2b.  The logic behind changing
> the system page size because of what the Loongson kernel "prefers"
> is flawed.
> 
> In the Loongson-2E manual, section 5.5, it is clear that the cpu
> supports a 4k page size (along with many others).  Therefore we
> must continue to support a 4k page size.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/mips/cpu-param.h             | 5 -----
>   hw/mips/fuloong2e.c                 | 1 -
>   hw/mips/loongson3_virt.c            | 1 -
>   target/mips/tcg/system/cp0_helper.c | 7 +------
>   target/mips/tcg/system/tlb_helper.c | 2 +-
>   5 files changed, 2 insertions(+), 14 deletions(-)


> diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
> index 646044e274..2a8507b8b0 100644
> --- a/hw/mips/fuloong2e.c
> +++ b/hw/mips/fuloong2e.c
> @@ -334,7 +334,6 @@ static void mips_fuloong2e_machine_init(MachineClass *mc)
>       mc->default_cpu_type = MIPS_CPU_TYPE_NAME("Loongson-2E");
>       mc->default_ram_size = 256 * MiB;
>       mc->default_ram_id = "fuloong2e.ram";
> -    mc->minimum_page_bits = 14;
>       machine_add_audiodev_property(mc);
>   }

fuloong2e machine uses a Loongson-2E CPU, which as the manual you
pointed out mentions, supports 4K pages.

>   
> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
> index db1cc51314..1da20dccec 100644
> --- a/hw/mips/loongson3_virt.c
> +++ b/hw/mips/loongson3_virt.c
> @@ -677,7 +677,6 @@ static void loongson3v_machine_class_init(ObjectClass *oc, void *data)
>       mc->max_cpus = LOONGSON_MAX_VCPUS;
>       mc->default_ram_id = "loongson3.highram";
>       mc->default_ram_size = 1600 * MiB;
> -    mc->minimum_page_bits = 14;
>       mc->default_nic = "virtio-net-pci";
>   }

loongson3v machine uses Loongson-3 series CPUs with TCG, or
Loongson-3A4000 with KVM.

The Loongson-3A1000 is based on a GS464 core, which does support
4K (chapter 3.5: PageMask register).

The Loongson-3A2000 and 3A3000 are based on a GS464E core, which
also supports 4K (chapter 7.7 PageMask Register).

   Address page Mask. The address mask is used to control the size
   of the page table stored in the page table entry. GS464E supports
   4KB to 1GB page size increments of 4.

The Loongson-3A4000 is based on a GS464V core, for which I couldn't
find the full manual. Being a GS464 with vector capabilities ("The
memory functional unit of GS464V is similar with GS464") I'll assume
4K is also OK there.

(I'll amend that information to the commit description)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


