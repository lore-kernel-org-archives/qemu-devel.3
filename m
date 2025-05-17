Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C774C2D0CD
	for <qemu-devel@archiver.kernel.org>; Sat, 17 May 2025 14:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGIKp-0002di-Fz; Sat, 17 May 2025 10:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uGIKl-0002dK-95
 for qemu-devel@nongnu.org; Sat, 17 May 2025 10:16:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uGIKi-0001SA-VV
 for qemu-devel@nongnu.org; Sat, 17 May 2025 10:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747491369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=b4pY8IMPGpkqouknI8zLVmxzbczfBZjOwvjiAzOf64I=;
 b=DUHtbd0/uKMxeMXCGZEPv72zKrO38/E4HkGmjcR9uc40CUkrnLl3AUwRh9YuZEN/kNDGnt
 n9KqgxFwTFfPqdPf8O0qEkmscbWvi3hZXYRAtO0YEgVX/iPlf7rRqEkTtzSySWii/wSFfN
 rjLUzu+p58F3HqYGaRHo6GFTH/6plPE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-STuZY1AdOsGzKFt7dK04bg-1; Sat, 17 May 2025 10:16:07 -0400
X-MC-Unique: STuZY1AdOsGzKFt7dK04bg-1
X-Mimecast-MFC-AGG-ID: STuZY1AdOsGzKFt7dK04bg_1747491367
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c544d2c34fso472034385a.1
 for <qemu-devel@nongnu.org>; Sat, 17 May 2025 07:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747491367; x=1748096167;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b4pY8IMPGpkqouknI8zLVmxzbczfBZjOwvjiAzOf64I=;
 b=okN08AQDZmA6n+YjeEM3dScho8vZiNFG9bv8PhdVyvf++0yoJslJ50eyF0ROD1zZio
 HrnmkS2RLQWE0e/ryDWK6kipbmxQiqE5pXezzWu0QbydpmRRxVXfkTQs98YhnVC98zs4
 I9BUG6vo2b20ddwK6KV3pXJ+f295b7zUCB6vFuFrnwFHijjej9PxnTuiMeD/bt5SSWND
 3Iy6XemSQdW0q5MirGG5ERnpei2jMeF0t5KjilHgz1dQyhVzC6cjt2pKx/o88mAQBozg
 3x1Rk/WoZYiUBP9RW7ggvMeMih1gOIz4jbOXI3Qnbh88Mrkvci/iGjJWHi+TMWteuM4f
 l8WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSv5+aOKJp+BSQy3pJGCi66AklaRCA6G9TI9rpmU/DhW5DPNj/k7HXMgqyKn4Ytr9osB5OMoFeUNKf@nongnu.org
X-Gm-Message-State: AOJu0YzmZn1C0q1Q69YoMYOxi9eY9ZITWfzwDryoaJjiiJVBYH0hAX7A
 s6rCZqtaF6ehSvEQTAZ+7+gHUOPdt9gw28K5WjCa6jRNKyIMBg4exI7yv2z/t16Or9aougbs1t6
 0EtZvJ1dFlr7eM9fa/wc9XTMwbYDwhe7NdwLTWhoVed4uKXgdyZVW9UAe
X-Gm-Gg: ASbGnct1cc5Pm54QqDg9XsAz+giNaGo3dznbnTfcFFMuBRJF+ALn9fZMZlQAwXvvVPF
 V0T7Y6ZB3CvWAcXgIesfOa/b5BE0UNEccQKLFLdiHSEDLye0d3n8UQw3vGiyJ/80xAsJYy1iXYs
 IeVsAFZHq8hSzQFG4WAbfOyWoc1G/eyNiutUv2PteU7x7+BtuNB+u2+g1R13r6ojt9fejWE+U72
 o5QSX7LyJe6UqPsF8WS89LMbZCht7oD8O5PdEyaimIb5VBPmNXwASUs81bC7Nsg8WNy7NpQFRYo
 8f3g3vYNFENa1qc6uA==
X-Received: by 2002:a05:620a:85c:b0:7ce:b4d4:3959 with SMTP id
 af79cd13be357-7ceb4d44d97mr131590685a.54.1747491366915; 
 Sat, 17 May 2025 07:16:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOSI8Jhb+D3yd/mz54EYI3JxLSmGXF10BGWGZw9HGy9aJQNjq3DK0YmwY5sFh+3FyXcT+hfw==
X-Received: by 2002:a05:620a:85c:b0:7ce:b4d4:3959 with SMTP id
 af79cd13be357-7ceb4d44d97mr131586585a.54.1747491366389; 
 Sat, 17 May 2025 07:16:06 -0700 (PDT)
Received: from [192.168.21.214] ([69.164.134.123])
 by smtp.googlemail.com with ESMTPSA id
 6a1803df08f44-6f8b097a3dbsm25884776d6.101.2025.05.17.07.16.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 May 2025 07:16:05 -0700 (PDT)
Message-ID: <db898834-1242-4ad3-9c3f-2cc221609b4e@redhat.com>
Date: Sat, 17 May 2025 16:16:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] hw/pci-host/gt64120: Fix endianness handling
To: Rakesh Jeyasingh <rakeshjb010@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 thuth@redhat.com, BALATON Zoltan <balaton@eik.bme.hu>
References: <20250429170354.150581-1-rakeshjb010@gmail.com>
 <20250429170354.150581-2-rakeshjb010@gmail.com>
 <CAD8nu1jtypmu+EyCY_kCdN3+Vo+Di64t9aBTfKSjArGZ+L3vYw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAD8nu1jtypmu+EyCY_kCdN3+Vo+Di64t9aBTfKSjArGZ+L3vYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.616,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/17/25 07:25, Rakesh Jeyasingh wrote:
> 
> 
> On Tue, Apr 29, 2025 at 10:34 PM Rakesh Jeyasingh <rakeshjb010@gmail.com 
> <mailto:rakeshjb010@gmail.com>> wrote:
> 
>     The GT-64120 PCI controller requires special handling where:
>     1. Host bridge(bus 0 ,device 0) must never be byte-swapped
>     2. Other devices follow MByteSwap bit in GT_PCI0_CMD
> 
>     The previous implementation incorrectly  swapped all accesses, breaking
>     host bridge detection (lspci -d 11ab:4620).
> 
>     Changes made:
>     1. Removed gt64120_update_pci_cfgdata_mapping() and moved data_mem
>     initialization
>        to gt64120_realize() for cleaner setup
>     2. Implemented custom read/write handlers that:
>         - Preserve host bridge accesses (extract32(config_reg,11,13)==0)
>         - apply swapping only for non-bridge devices in big-endian mode
> 
>     Fixes: 145e2198 ("hw/mips/gt64xxx_pci: Endian-swap using
>     PCI_HOST_BRIDGE MemoryRegionOps")
>     Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2826
>     <https://gitlab.com/qemu-project/qemu/-/issues/2826>
> 
>     Signed-off-by: Rakesh Jeyasingh <rakeshjb010@gmail.com
>     <mailto:rakeshjb010@gmail.com>>
>     ---
>       hw/pci-host/gt64120.c | 82 +++++++++++++++++++++++++------------------
>       1 file changed, 48 insertions(+), 34 deletions(-)
> 
>     diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
>     index 56a6ef93b7..ecb203a3d0 100644
>     --- a/hw/pci-host/gt64120.c
>     +++ b/hw/pci-host/gt64120.c
>     @@ -320,38 +320,6 @@ static void gt64120_isd_mapping(GT64120State *s)
>           memory_region_transaction_commit();
>       }
> 
>     -static void gt64120_update_pci_cfgdata_mapping(GT64120State *s)
>     -{
>     -    /* Indexed on MByteSwap bit, see Table 158: PCI_0 Command,
>     Offset: 0xc00 */
>     -    static const MemoryRegionOps *pci_host_data_ops[] = {
>     -        &pci_host_data_be_ops, &pci_host_data_le_ops
>     -    };
>     -    PCIHostState *phb = PCI_HOST_BRIDGE(s);
>     -
>     -    memory_region_transaction_begin();
>     -
>     -    /*
>     -     * The setting of the MByteSwap bit and MWordSwap bit in the
>     PCI Internal
>     -     * Command Register determines how data transactions from the
>     CPU to/from
>     -     * PCI are handled along with the setting of the Endianness bit
>     in the CPU
>     -     * Configuration Register. See:
>     -     * - Table 16: 32-bit PCI Transaction Endianness
>     -     * - Table 158: PCI_0 Command, Offset: 0xc00
>     -     */
>     -
>     -    if (memory_region_is_mapped(&phb->data_mem)) {
>     -        memory_region_del_subregion(&s->ISD_mem, &phb->data_mem);
>     -        object_unparent(OBJECT(&phb->data_mem));
>     -    }
>     -    memory_region_init_io(&phb->data_mem, OBJECT(phb),
>     -                          pci_host_data_ops[s->regs[GT_PCI0_CMD] & 1],
>     -                          s, "pci-conf-data", 4);
>     -    memory_region_add_subregion_overlap(&s->ISD_mem,
>     GT_PCI0_CFGDATA << 2,
>     -                                        &phb->data_mem, 1);
>     -
>     -    memory_region_transaction_commit();
>     -}
>     -
>       static void gt64120_pci_mapping(GT64120State *s)
>       {
>           memory_region_transaction_begin();
>     @@ -645,7 +613,6 @@ static void gt64120_writel(void *opaque, hwaddr
>     addr,
>           case GT_PCI0_CMD:
>           case GT_PCI1_CMD:
>               s->regs[saddr] = val & 0x0401fc0f;
>     -        gt64120_update_pci_cfgdata_mapping(s);
>               break;
>           case GT_PCI0_TOR:
>           case GT_PCI0_BS_SCS10:
>     @@ -1024,6 +991,48 @@ static const MemoryRegionOps isd_mem_ops = {
>           },
>       };
> 
>     +static bool bswap(const GT64120State *s)
>     +{
>     +    PCIHostState *phb = PCI_HOST_BRIDGE(s);
>     +    /*check for bus == 0 && device == 0, Bits 11:15 = Device , Bits
>     16:23 = Bus*/
>     +    bool is_phb_dev0 = extract32(phb->config_reg, 11, 13) == 0;
>     +    bool le_mode = FIELD_EX32(s->regs[GT_PCI0_CMD], GT_PCI0_CMD,
>     MByteSwap);
>     +    /* Only swap for non-bridge devices in big-endian mode */
>     +    return !le_mode && !is_phb_dev0;
>     +}
>     +
>     +static uint64_t gt64120_pci_data_read(void *opaque, hwaddr addr,
>     unsigned size)
>     +{
>     +    GT64120State *s = opaque;
>     +    uint64_t val = pci_host_data_le_ops.read(opaque, addr, size);
> 
> Hi , I just noticed that I made a mistake in the declaring data length 
> of read val. In previous commits declared as uint32_t (as I think the 
> PCI controller handles 32-bit values, while MemoryRegionOps uses 
> uint64_t returns)
> Should i consider:
> 1.sending corrected patch(hoping it not yet merged)
> 2.or any suggestion on fixing it?

It works with uint64_t as well, no worries.  But I can also change it (I 
haven't applied the patch yet because I was expecting someone else to do 
it, but I will pick it up now).

Paolo


