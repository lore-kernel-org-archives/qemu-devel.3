Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6634DC8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaBC6-0001F3-BM; Fri, 11 Jul 2025 06:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uaBBu-0001Dt-PT
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:41:20 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uaBBm-0007UT-Sf
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:41:14 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a4fb9c2436so1301291f8f.1
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 03:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752230467; x=1752835267; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kmJNh9Jgp8+8BgYCKh3Q9I2sf1GOqYwi9BQV8NsKg2g=;
 b=tgEHg0axhub0gu7eAKUWrr8dfzOJlJRY9Vgr/uWPEIHf5czWG7lgBKmCno82ef3xhC
 rB56lGRQ7QcMOis9RfdM9mKZnRwe8ri8YgJvRHIKZY2IiEMkBeZbLdzZe1xBksUBUOED
 jSPYwwaqFu69aCW5ivy5PWGIlXE0hNaqt6xTHTNiz/1utvqg/uQnaOXNmGbMs5FhuDw5
 KMUxhpco6UuiauJ8dbilQ3W4bD/MROHHQ3ai9WWKFcR11nJ2oLyysz8CENff80cbm43S
 QBm0wPlTKi33I8JC9W5RSFY6B1op8DZGL4mDNnFB0k6FpYbA2Dg+iY5Yq9N8dnzULp1V
 l+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752230467; x=1752835267;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kmJNh9Jgp8+8BgYCKh3Q9I2sf1GOqYwi9BQV8NsKg2g=;
 b=ZHJ8G9PjNGLepIyT++QndM7iHPxRKyHkr1Rw83s/lmXwsmVSSVErsb6/IXIs8ZfUQB
 QgTGplCWYwhE2P5Y7f3fAXv4NrH4REwzmxUSMk8seW1hp6T8OyAgb1UZA48dMLYX9qM4
 hrMDPzmUa6Xa5BdNOKCgqZTkYGssawKK1rGjyThjG4GA+PEGRPv9S8yEN8YhsUb5NmUA
 hWXvmuTe0FoHEYNauEbF682fLvt0neimb8DQuEq6aVuwWvhQTwuGiKbeBqj1ysSnxgwi
 j9RRmZyjbdn46K3hC2zlK+Ga1WYMvBd0kCfE8sU0Bx9ix2GTBCvRV3w4kOalTutWtJz1
 4s0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1S8z7/etM0SsUwnF2NccLqogDviylhYWMwP+jK2iJAdiwWK6enTkHxfRM3FjbDmu+7r0xU9Zhvfo/@nongnu.org
X-Gm-Message-State: AOJu0YyUfitEHWBBc3pOxa4irwJCLR/4bWOfgnO0VSwJRhLEWjS1TBpk
 RAaphnUKQgw3LtRbJxZBtcKK7wBG58jIG2RJX2PEBG0DcJ8aNy7x2BCdvq+C8SYVZ3A=
X-Gm-Gg: ASbGncvBiUxODxG99wFS56ii5KBSfkNUSk9A70xeyrzPcqJ1+rKX5M+K42cpG9i0/y0
 Bb/CTgmT0ydD0xiZtIbYoqqvGrXFpg7vn8Tg9AGZlaguXEVl7aI8evKZNtXe1QdfO8h0I/8W3TO
 jYgXB4S/jSt1ORlz5Z9K6bzutU1Nxf6zHOcpTNaYaktU/k4p3QZmKO2IixEL9P/3M6mdqIN7wDs
 +KDxlUBaoLHbzBEt2UGwqW57DmLYoTx9S/XcoDErDIW8y6jlxqILv6nfOF3jFIrwa3a0TIvLmX1
 lhg+cePZJWNoqgQfmSpeEMr1a1TebfJXZSOs6PC2B4KdjEFAlKj4yOdBZB+frUV7oX19IcHAbcx
 5LnhRTnwhpbGtscclL/DvWm1BSbOZBgHZdJ0pOQy5Wl/f7bRCeGKnR6Op2zsqx9vOtvP1G45mJG
 cK/aF6
X-Google-Smtp-Source: AGHT+IHAfq8PmhFyFg2zRj63ZvT1kfy5e//PKaCHzUh/F1Kp1OidzlgedmkYwpzapCHWjX/xMh7/Dg==
X-Received: by 2002:a05:6000:24c6:b0:3a3:6991:dcbb with SMTP id
 ffacd0b85a97d-3b5f187a48cmr2400271f8f.12.1752230467358; 
 Fri, 11 Jul 2025 03:41:07 -0700 (PDT)
Received: from [192.168.1.47] (lfbn-mon-1-587-20.w2-4.abo.wanadoo.fr.
 [2.4.165.20]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1932sm4191113f8f.17.2025.07.11.03.41.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jul 2025 03:41:06 -0700 (PDT)
Message-ID: <dc737fa6-7878-40c0-9922-0b2865a95b60@linaro.org>
Date: Fri, 11 Jul 2025 12:41:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/19] hw/i386/pc_piix.c: simplify RAM size logic in
 pc_init_isa()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250711095812.543857-1-mark.caveayland@nutanix.com>
 <20250711095812.543857-10-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250711095812.543857-10-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 11/7/25 11:57, Mark Cave-Ayland wrote:
> All isapc machines must have 32-bit CPUs and so the RAM split logic can be hardcoded
> accordingly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/i386/pc_piix.c | 58 ++++-------------------------------------------
>   1 file changed, 4 insertions(+), 54 deletions(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 78f50a7893..fbd9500061 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -426,69 +426,19 @@ static void pc_init_isa(MachineState *machine)
>       GSIState *gsi_state;
>       MemoryRegion *ram_memory;
>       MemoryRegion *rom_memory = system_memory;
> -    ram_addr_t lowmem;
>       uint64_t hole64_size = 0;
>   
>       /*
> -     * Calculate ram split, for memory below and above 4G.  It's a bit
> -     * complicated for backward compatibility reasons ...
> -     *
> -     *  - Traditional split is 3.5G (lowmem = 0xe0000000).  This is the
> -     *    default value for max_ram_below_4g now.
> -     *
> -     *  - Then, to gigabyte align the memory, we move the split to 3G
> -     *    (lowmem = 0xc0000000).  But only in case we have to split in
> -     *    the first place, i.e. ram_size is larger than (traditional)
> -     *    lowmem.  And for new machine types (gigabyte_align = true)
> -     *    only, for live migration compatibility reasons.
> -     *
> -     *  - Next the max-ram-below-4g option was added, which allowed to
> -     *    reduce lowmem to a smaller value, to allow a larger PCI I/O
> -     *    window below 4G.  qemu doesn't enforce gigabyte alignment here,
> -     *    but prints a warning.
> -     *
> -     *  - Finally max-ram-below-4g got updated to also allow raising lowmem,
> -     *    so legacy non-PAE guests can get as much memory as possible in
> -     *    the 32bit address space below 4G.
> -     *
> -     *  - Note that Xen has its own ram setup code in xen_ram_init(),
> -     *    called via xen_hvm_init_pc().
> -     *
> -     * Examples:
> -     *    qemu -M pc-1.7 -m 4G    (old default)    -> 3584M low,  512M high
> -     *    qemu -M pc -m 4G        (new default)    -> 3072M low, 1024M high
> -     *    qemu -M pc,max-ram-below-4g=2G -m 4G     -> 2048M low, 2048M high
> -     *    qemu -M pc,max-ram-below-4g=4G -m 3968M  -> 3968M low (=4G-128M)
> +     * There is no RAM split for the isapc machine
>        */
>       if (xen_enabled()) {
>           xen_hvm_init_pc(pcms, &ram_memory);
>       } else {
>           ram_memory = machine->ram;
> -        if (!pcms->max_ram_below_4g) {
> -            pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
> -        }
> -        lowmem = pcms->max_ram_below_4g;
> -        if (machine->ram_size >= pcms->max_ram_below_4g) {
> -            if (pcmc->gigabyte_align) {
> -                if (lowmem > 0xc0000000) {
> -                    lowmem = 0xc0000000;
> -                }
> -                if (lowmem & (1 * GiB - 1)) {
> -                    warn_report("Large machine and max_ram_below_4g "
> -                                "(%" PRIu64 ") not a multiple of 1G; "
> -                                "possible bad performance.",
> -                                pcms->max_ram_below_4g);
> -                }
> -            }
> -        }
>   
> -        if (machine->ram_size >= lowmem) {
> -            x86ms->above_4g_mem_size = machine->ram_size - lowmem;
> -            x86ms->below_4g_mem_size = lowmem;
> -        } else {
> -            x86ms->above_4g_mem_size = 0;
> -            x86ms->below_4g_mem_size = machine->ram_size;
> -        }
> +        pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */

Since nothing to split, I'd expect the whole 4*GiB space here.

> +        x86ms->above_4g_mem_size = 0;
> +        x86ms->below_4g_mem_size = machine->ram_size;
>       }
>   
>       /*


