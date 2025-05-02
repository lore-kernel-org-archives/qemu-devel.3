Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF092C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 10:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAntR-0000Sr-7q; Fri, 02 May 2025 06:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAntQ-0000SZ-86
 for qemu-devel@nongnu.org; Fri, 02 May 2025 06:45:20 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAntO-00038h-9h
 for qemu-devel@nongnu.org; Fri, 02 May 2025 06:45:19 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ace3b03c043so276954166b.2
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 03:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746182716; x=1746787516; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cfSywACQVYyhIQOb8o4JA0/IZccYhkqNj9z4SI0aUMk=;
 b=ysPjXFN3DPkNaMhRHaG4eMawmShlgrYOFsnVAT/ffZXZ2fdfZLadNhnbfmUB8anIXV
 R1gNRWjjV4fY/A9TA1rAcgLL8QrufsUl4yEzlesYOtyhzGOmPuRoynGXXnvvtH7rJNtF
 zsiaMfylWYny0tqs83vvckF+ffZixSvqq3a273kB+HjU6BgfpgcJulqwR3lWLSfNjwX8
 IFVRu2wgTuYySXBnMvP9WvjR44Ce4ZwlDTRAjQThbkPXqwjFysEhAbt00YX/5ShvDfKV
 EsHbhcwIzUPqEe6j/wKa+fKAJmWwE3bRurU2zaOw0QbhXYYVlaqjhhUB64FQUC53b1tl
 KbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746182716; x=1746787516;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cfSywACQVYyhIQOb8o4JA0/IZccYhkqNj9z4SI0aUMk=;
 b=uVaoFWw/ojsZMf7JnK5gcuSTsP3qs96GbLOKebRbNBMhvT9bTCmPlih0yRb7mQZRO5
 DuM92aj/2QSfEaVE4YHcQPtPkTuvYKM1iLakYSVFrYkYREdW8+F9F1MHFXkdoz81+tv2
 Y5OhM+MEP/reue5FhXzfOW42IVgaKdwkHKBrA0WPzvTpBuCB9axOPX14jmRCoKjQ+UQn
 JFemswxED6897xyM3H0agYIPzmFzcaLhRhQFy/L2LRQegXYOeQtT3qjVc92P1iZUNQpb
 97/JHS8dcxoi1SCnCRVjvVVB7cNRR1ZHbFTa5b8orjJBELeMMiSh+2jNzTMN1qaSOl2q
 J1XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHyomsZP266GGI6KtK2+UFmproNYQ2mbQKD34q8+Jj/VMRnXEtc9uMhmNyb2SwsBxPrzVyv388a9Nx@nongnu.org
X-Gm-Message-State: AOJu0YzJIlRW514lJC+ICPFOWIN6+YueHif2FCbOI3ccYHyOPh6EZPum
 peNp23DD40LT1PaYLpdXMNqmHCo5X+Np+4z4atj3kmw1v5x8JN0p9lPbe1eKcmE=
X-Gm-Gg: ASbGncu8x1X/2nNGEieIXHgfsatFvesiOC5k1i26khVd+aEK4Px6WAp8X1RbVYyrzNO
 7oZ3spFxh+pDPSsm9Zw6WNcx18O8LyciF38Wjl2RFCcrdIc0RJ9AQnDvmhDXGuu4mP7vTkh6gwN
 GYCXpJVKYWtMexmavQa6LNl4Lk6Q87B4Rou2SZOaYG4CbEkIhw8XoQtYVoWLhRH0zsiB7UTDliv
 6Lbak+I++U0zH4lCqec4APQP5EHCsYOsp9d96FUZy28+M4hhos6KU333Kvel/SfmIz9bnZNSSj4
 uowGo73N9x8s1QJuykNqCh7TGNQvrQsq/dtCiYzmR/p+aRmLOmVkq6NfbpHnPkO3UU69qDFruYn
 3LYedTlgQ80vRLAvGB8A=
X-Google-Smtp-Source: AGHT+IE9tTB4R7byrj1Eo4pBxqYrj7FUDmSoT53dhD0lQQwGRMi/o7WF4KYeZQ70X5q7N10XXkto9g==
X-Received: by 2002:a17:907:1c0e:b0:acb:88ac:e30f with SMTP id
 a640c23a62f3a-ad17ad81da8mr268663966b.20.1746182716472; 
 Fri, 02 May 2025 03:45:16 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad189146f74sm32077566b.17.2025.05.02.03.45.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 03:45:15 -0700 (PDT)
Message-ID: <54d72848-9108-4b04-a46c-1f82492e06cb@linaro.org>
Date: Fri, 2 May 2025 12:45:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] hw/i386/x86: Remove
 X86MachineClass::fwcfg_dma_enabled field
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org,
 Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20250501183628.87479-1-philmd@linaro.org>
 <20250501183628.87479-4-philmd@linaro.org>
 <2acc8c0c-f563-4d27-b73d-ce4c0f8ef424@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2acc8c0c-f563-4d27-b73d-ce4c0f8ef424@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

On 2/5/25 11:08, Mark Cave-Ayland wrote:
> On 01/05/2025 19:36, Philippe Mathieu-Daudé wrote:
> 
>> The X86MachineClass::fwcfg_dma_enabled boolean was only used
>> by the pc-q35-2.6 and pc-i440fx-2.6 machines, which got
>> removed. Remove it and simplify.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/i386/x86.h | 2 --
>>   hw/i386/microvm.c     | 3 ---
>>   hw/i386/multiboot.c   | 7 +------
>>   hw/i386/x86-common.c  | 3 +--
>>   hw/i386/x86.c         | 2 --
>>   5 files changed, 2 insertions(+), 15 deletions(-)
>>
>> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
>> index fc460b82f82..29d37af11e6 100644
>> --- a/include/hw/i386/x86.h
>> +++ b/include/hw/i386/x86.h
>> @@ -29,8 +29,6 @@
>>   struct X86MachineClass {
>>       MachineClass parent;
>> -    /* use DMA capable linuxboot option rom */
>> -    bool fwcfg_dma_enabled;
>>       /* CPU and apic information: */
>>       bool apic_xrupt_override;
>>   };


>> diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
>> index 6e6b96bc345..bfa7e8f1e83 100644
>> --- a/hw/i386/multiboot.c
>> +++ b/hw/i386/multiboot.c
>> @@ -153,7 +153,6 @@ int load_multiboot(X86MachineState *x86ms,
>>                      int kernel_file_size,
>>                      uint8_t *header)
>>   {
>> -    bool multiboot_dma_enabled = X86_MACHINE_GET_CLASS(x86ms)- 
>> >fwcfg_dma_enabled;
>>       int i, is_multiboot = 0;
>>       uint32_t flags = 0;
>>       uint32_t mh_entry_addr;
>> @@ -402,11 +401,7 @@ int load_multiboot(X86MachineState *x86ms,
>>       fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, mb_bootinfo_data,
>>                        sizeof(bootinfo));
>> -    if (multiboot_dma_enabled) {
>> -        option_rom[nb_option_roms].name = "multiboot_dma.bin";
>> -    } else {
>> -        option_rom[nb_option_roms].name = "multiboot.bin";
>> -    }
>> +    option_rom[nb_option_roms].name = "multiboot_dma.bin";
> 
> Question: now that all machines support DMA-capable fw_cfg, does that 
> mean that the non-DMA options roms above can also be removed?

All x86 machines, but there are still 2 not supporting it: HPPA and
MIPS Loongson-3:

hw/hppa/machine.c:204:    fw_cfg = fw_cfg_init_mem(addr, addr + 4);

hw/mips/loongson3_virt.c:289:    fw_cfg = fw_cfg_init_mem_wide(cfg_addr, 
cfg_addr + 8, 8, 0, NULL);


