Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F099C36013
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 13:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyA7S-00020r-Pm; Fri, 28 Mar 2025 09:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tyA7Q-00020d-V5
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 09:51:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tyA7O-0003XQ-QZ
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 09:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743169888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=P+IXxEzmK9dVBiUarQG+xu1HmRO2qo7NM2P7oVcCOJE=;
 b=CcRxvIVWa1rO9zMPuFf4eIDJ7KEBeR/V3529IrlgalmZr+LTLQfOlSK1mAPew7j+kPNE01
 LOZc8f4VVxufw1XxcZ9jbV3AFdntgtmBRgNyQ+JTsk5JdfntaIfip/8Pbsw4I/UGJuZjnu
 WB7005mDf0y+Y3wJihsgGynzegcjejE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-7yqXsqjiOoqODhm4VlMwjA-1; Fri, 28 Mar 2025 09:51:27 -0400
X-MC-Unique: 7yqXsqjiOoqODhm4VlMwjA-1
X-Mimecast-MFC-AGG-ID: 7yqXsqjiOoqODhm4VlMwjA_1743169886
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43bd0586b86so13211135e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 06:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743169884; x=1743774684;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P+IXxEzmK9dVBiUarQG+xu1HmRO2qo7NM2P7oVcCOJE=;
 b=cR8garOF/FKto4kIYwe/NK7eJBJFfs+hHlNoUpzFZpN9SRWok4oTJysidChOmTD8+E
 NvFZy5FpqCrnLvOm3RAlhDodJuHjyFUb62OMpZjBLE72zc9e9ivMI4u9kURG8tvPyzfn
 3AbGML5jg+6xF0dShVPi8i5+pwx1lbrgk+flLvv4j6TGORDRy7ujh7lcVtmB4Y2jVA75
 bkaaiGMsG4yPcKasAblE3oUgs3ClP245jysbuVX4AAT9fi15xeVMqN6z5f+UaYz3578M
 ma1H6XYR+36NCpc1LJryrDnInm1HsOngzE+H2u+eWEjQ15vONOwv/hGDnuPt/qMoM46i
 I6hQ==
X-Gm-Message-State: AOJu0Yx5qvty/NqrcpIgyzd9MzS8ZaRydPKyNSL1vKNvz5RA265TXuTN
 +dsxfApU2zOCA5u6HKvjobxHdyl4m07/C7N3J5a+yrLlCBLWuiqmvna7ilRBtn/mtkwPR6lgvmQ
 XSp1WRVksPs2khbaFE3YL0YE6Iya8ePfIg08sePX2PK9871kwkIiN
X-Gm-Gg: ASbGncuetP9lujK7gAU0z8QFOcbuRDMMloWML3k+g8HkDcZGQq9IaiDJB8CbpUpa0c7
 oFWLQ/WxZRWkCvzjh21H402jHVcPwA96jKvAxTuOLV6h5iQS8Hk15fysOScysUOe0h3IZJUYKZt
 fMbq1bysmiyVtek73HXSk+TLoZdRcCF+Uqd3A7ldaRRzFtBFfyR15TwU+uA+5rP1nGm7PAF2PTb
 abuGTZxX7+mps4ctr0L34H/iuuHRRFXc5ptI0CwcYBBvdaYPGidG3XjjiQG15biLNJFYkzmuk+U
 akwAzDitpq6Df/RrmPox
X-Received: by 2002:a05:600c:c15:b0:43c:eeee:b713 with SMTP id
 5b1f17b1804b1-43d85065ab9mr79999885e9.20.1743169883688; 
 Fri, 28 Mar 2025 06:51:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFByfPqDYZGCFe9s0sJxuYdiQOZrxh8VYkbBAdpQ4PxZQ5DVRFf1W6dq5E71OdhsfYMZnMX8A==
X-Received: by 2002:a05:600c:c15:b0:43c:eeee:b713 with SMTP id
 5b1f17b1804b1-43d85065ab9mr79999615e9.20.1743169883221; 
 Fri, 28 Mar 2025 06:51:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.222.160])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43d82e83482sm73657915e9.14.2025.03.28.06.51.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 06:51:22 -0700 (PDT)
Message-ID: <ca76bcb1-7cea-4153-ae74-02718a6a1cfb@redhat.com>
Date: Fri, 28 Mar 2025 14:51:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci-host/gt64120.c: Fix PCI host bridge endianness
 handling
To: BALATON Zoltan <balaton@eik.bme.hu>, rakeshj <rakeshjb010@gmail.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, philmd@linaro.org,
 thuth@redhat.com
References: <20250327153627.307040-1-rakeshjb010@gmail.com>
 <364c91ef-b086-9aea-4073-e0be49b77d76@eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <364c91ef-b086-9aea-4073-e0be49b77d76@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 3/27/25 21:50, BALATON Zoltan wrote:
> On Thu, 27 Mar 2025, rakeshj wrote:
>> The GT-64120 PCI controller requires special handling where:
>> 1. Host bridge (device 0) must use native endianness
>> 2. Other devices follow MByteSwap bit in GT_PCI0_CMD
>>
>> Previous implementation accidentally swapped all accesses, breaking
>> host bridge detection (lspci -d 11ab:4620). This fix:
>>
>> - Adds device filtering via (phb->config_reg & 0x00FFF800)
>> - Preserves native endianness for host bridge
>> - Maintains swapping for other devices in big-endian mode
>>
>> Fixes: 145e2198 ("hw/mips/gt64xxx_pci: Endian-swap using 
>> PCI_HOST_BRIDGE MemoryRegionOps")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2826
>> Signed-off-by: rakeshj <rakeshjb010@gmail.com>
>> ---
>> hw/pci-host/gt64120.c | 37 ++++++++++++++++++++++++++++++++++++-
>> 1 file changed, 36 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
>> index d5c13a89b6..098f8e5988 100644
>> --- a/hw/pci-host/gt64120.c
>> +++ b/hw/pci-host/gt64120.c
>> @@ -320,11 +320,46 @@ static void gt64120_isd_mapping(GT64120State *s)
>>     memory_region_transaction_commit();
>> }
>>
>> +static uint64_t gt64120_pci_data_read(void *opaque, hwaddr addr, 
>> unsigned size)
>> +{
>> +    GT64120State *s = opaque;
>> +    PCIHostState *phb = PCI_HOST_BRIDGE(s);
>> +    uint32_t val = pci_data_read(phb->bus, phb->config_reg, size);
>> +
>> +    /* Only swap for non-bridge devices in big-endian mode */
>> +    if (!(s->regs[GT_PCI0_CMD] & 1) && (phb->config_reg & 0x00fff800)) {
>> +        val = bswap32(val);
> 
> I don't know if this is the best way to fix this issue as I don't know 
> what the issue is in the first place (isn't PCI usually little endian?) 

Yes but this particular PCI host bridge is the exception, as it is the 
only user of pci_host_data_be_ops.

> but I think you can't just use bswap here because it also needs to take 
> into account the endianness of the host QEMU is running on.

It should be fine.  You should take into account:

- the endianness produced by pci_data_read/pci_data_write (always little 
endian)

- the endianness expected by the guest (big endian under the conditions 
in the patch)

- the endianness expected by memory.c (always little endian, as 
specified in gt64120_pci_data_ops)

Because there is either zero or one mismatch, bswap32 is fine.

*However*, there is some extra complication that is unnecessary after 
this patch:

- right now the !(s->regs[GT_PCI0_CMD] & 1) that you have added is dead 
code: if it was ever 1, gt64120_update_pci_cfgdata_mapping() would pick 
pci_host_data_ops[1] and gt64120_pci_data_read/write would not run at all!

- but alternatively you could keep that conditional, and get rid 
completely of gt64120_update_pci_cfgdata_mapping().  Just keep the 
initialization code

     memory_region_init_io(&phb->data_mem, OBJECT(phb),
                           &gt64120_pci_data_ops,
                           s, "pci-conf-data", 4);
     memory_region_add_subregion_overlap(&s->ISD_mem, GT_PCI0_CFGDATA << 2,
                                         &phb->data_mem, 1);

at the end of gt64120_realize() where the sister region phb->conf_mem is 
already being initialized.  This would actually make me happy.

Either way, pci_host_data_be_ops is dead after this patch and you can 
remove it; and since you are at it, you may also want to remove the 
wrong comment

     /*
      * PCI_CONFIG_ADDR is parent_obj.config_reg, via pci_host_conf_be_ops,
      * so that we can map PCI_CONFIG_DATA to pci_host_data_be_ops.
      */

in include/hw/pci-host/dino.h: DINO emulation has *never* used 
pci_host_data_be_ops.

This has snowballed a bit, but it should not be a problem. :)

Paolo


