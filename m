Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46359CFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 03:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNNi2-0006Sd-FD; Sun, 23 Nov 2025 22:57:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNNhx-0006Rn-TW
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 22:57:46 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNNhw-0002ht-86
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 22:57:45 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4775895d69cso15447385e9.0
 for <qemu-devel@nongnu.org>; Sun, 23 Nov 2025 19:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763956663; x=1764561463; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jdNZlBGCi8LiBFSGxRFWbVUK1gTbuCJa3dvSeS0t65Y=;
 b=WeQUlm0hc1udr2MRWDheci97x8izNBg3BnZ8bBS58nMzy9Z8loZ5qHef9tUCXnDlN0
 U3PI7Yl22o+Og1VVCzAi5RfbR8QzqIodY/6CZ7h6eKuO6r4BSYyWAjnzBYzR+hmRboFJ
 gkElYVOtpQTZ3PZdhMT1Y03sXwDZ1ysfYCRUddEbXx5PHe3/Z4dz0QdmYl0R+XOm5rCY
 vfpUXGeLxcMS4hKE0pQ+C1bp7ZFb1nq0hokOg42vWdE3UzRIeoUdL0H2SVayffUEBoud
 Qi7otBCN1OFdkHHDPKIqIxrGad17U8hzfaIHCidC7GpON2FK0jdcp1wQYNcFHYhh5MbN
 VRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763956663; x=1764561463;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jdNZlBGCi8LiBFSGxRFWbVUK1gTbuCJa3dvSeS0t65Y=;
 b=LNG/SGUMoZ4uimmbQkS9FxDDdRcw8vy0JDod8VuAXPM0CVlZXpVnhKR/Fair5a1P+p
 H7ioEH871xBrpaGQgDDi9OU3j/svd9HqRJN4eBsrt4B+w0DLKbzbJZPkrUURIqgW//x7
 zsHFfilrkO3JtisUHu2TQlJhH8YxvPkTqD2m8z5tPBiX/fkfuBE2TXLdF8/yVFIc+5Tq
 ot4mviQE1n5m+FbV3jur8O1sM2jiibs6L/gAc+5fOMv3HJbo6gldydBHJP87UjfrM9t+
 7PAITHmQsC63EoXPtpQxZf7MQfv3GonGb3n7eRleAccRSP1aRv7H8676ANLblaB75awu
 kh0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZCCX56QRcbY7/J60Hmqo8phl7wrDCiF1Ygsb9/Qur1Fcx3Wua1PvZeDqgVVpWTenvS+xcOsC14Eoq@nongnu.org
X-Gm-Message-State: AOJu0YyKHCREZ+wsW3AtRW6deUt0Ki8EfnRlYrd1SHrhyFnD4oSb3srR
 uRAYzgaljBXm8KN+MWRbP2EWTfsNPYHwRMk7YYnIjCLzAG9x64E2L4pKQc+1NdXfLjF+v70FnC7
 LD8n9cq0LWw==
X-Gm-Gg: ASbGnctk4pmI09XKqwXvlpAYkj35GseZpyBFpKrBY3BxEVyNFOysIwq1guz9mQckeGR
 yL3d6O9Ra0xNpCvCFEM5ln/bHBPFWuqKxNJJcpu7ZfTHq7w8+HRlVILiVEPdOmLZA84XXAjfy6k
 /VYBpAvrT9Nbky/0THy+1qzq2A6V+0lxw5vlFTD/CZNGNtMDq6wT8PBWkTG68YXO9y8nT/T4y1R
 y2vd+K7AdpUmheQFG8R6cuySCIvy25mO9M9ve0dGpxfdSxoHCmq3URVFPLkoFPX221tucr0c/DO
 O/GVXiZbTRC76qBF0RVCn8I7onetvTvOvzwtZsxQR63sWAqDHOn8UZexo8q8N9hc5KAk+lm93b4
 0FkMGu9dttoKk4qsInLOttBxqSgbC0n3mbNT6QWBmjE6dFCj1YfE5uFMcbIzVlVwppHFMktgr9T
 MKrYzqakc9NM5UW5kcEIlmVGwD2Ep6VLf1WC5nKGFQOB4Gdua9fksC/g==
X-Google-Smtp-Source: AGHT+IGN6yNictzipvjbSefaZp9DfOIYsNxSw5kwepsfnv4eWZmsjv2/iGiGZjHzoGyK0k9IU3AApA==
X-Received: by 2002:a05:600c:35c1:b0:477:abea:9028 with SMTP id
 5b1f17b1804b1-477c016e7a6mr104288835e9.6.1763956662757; 
 Sun, 23 Nov 2025 19:57:42 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9de4631sm140191875e9.7.2025.11.23.19.57.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Nov 2025 19:57:41 -0800 (PST)
Message-ID: <cc5261eb-e11a-4215-8e01-e05b1afff19f@linaro.org>
Date: Mon, 24 Nov 2025 04:57:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] hw/misc/pvpanic: add PCI interface support
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>,
 Mihai Carabas <mihai.carabas@oracle.com>, qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: peter.maydell@linaro.org, yvugenfi@redhat.com, kraxel@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <1611759570-3645-1-git-send-email-mihai.carabas@oracle.com>
 <1611759570-3645-3-git-send-email-mihai.carabas@oracle.com>
 <77d7afeb-3dbc-4fcf-976b-09fe01cf542e@linaro.org>
 <8fd6caa2-c641-4901-9d1d-83282ae07c12@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8fd6caa2-c641-4901-9d1d-83282ae07c12@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 19/11/25 00:18, Gustavo Romero wrote:
> Hi Phil,
> 
> On 11/18/25 11:16, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> (old patch merged as commit d097b3dcb62)
>>
>> On 27/1/21 15:59, Mihai Carabas wrote:
>>> Add PCI interface support for PVPANIC device. Create a new file 
>>> pvpanic-pci.c
>>> where the PCI specific routines reside and update the build system 
>>> with the new
>>> files and config structure.
>>>
>>> Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
>>> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
>>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>> Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
>>> ---
>>>   docs/specs/pci-ids.txt    |  1 +
>>>   hw/misc/Kconfig           |  6 +++
>>>   hw/misc/meson.build       |  1 +
>>>   hw/misc/pvpanic-pci.c     | 94 ++++++++++++++++++++++++++++++++++++ 
>>> +++++++++++
>>>   include/hw/misc/pvpanic.h |  1 +
>>>   include/hw/pci/pci.h      |  1 +
>>>   6 files changed, 104 insertions(+)
>>>   create mode 100644 hw/misc/pvpanic-pci.c


>>> +static void pvpanic_pci_realizefn(PCIDevice *dev, Error **errp)
>>> +{
>>> +    PVPanicPCIState *s = PVPANIC_PCI_DEVICE(dev);
>>> +    PVPanicState *ps = &s->pvpanic;
>>> +
>>> +    pvpanic_setup_io(&s->pvpanic, DEVICE(s), 2);
>>
>> Why registering 2-bytes of I/O when the underlying device is 1-byte
>> wide? Is this to allow 16-bit I/O instructions?
> 
> TL;DR: I think that 2 should actually be 16 :)
> 
> First, IMO, pvpanic_setup_io() should be called pvpanic_setup_mmio() 
> because
> the registered memory region in question is of type 
> PCI_BASE_ADDRESS_SPACE_MEMORY,
> not of type PCI_BASE_ADDRESS_SPACE_IO, hence the BAR associated to
> this memory region (ps->mr) will map a MMIO region, not an I/O region.
> 
> But I think I see why it looks confusing to me: QEMU puts both a Memory 
> Space
> and an I/O Space (PCI terms here) into pci_dev->io_regions[] (which is ok).
> The former defines a MMIO region and the latter an I/O (x86 old-style) 
> region.
> 
> I'm just saying that in case you were thinking of inb/outb/insw/outsw &
> friends when you said "to allow 16-bit I/O instructions", which are mean
> to work with PCI_BASE_ADDRESS_SPACE_IO, not with 
> PCI_BASE_ADDRESS_SPACE_MEMORY
> regions, where normal CPU load/store instructions (mov, ldr, str, ld, 
> std, etc.)
> should be used instead.
> 
> For such normal a CPU loads/stores the granularity would be, in general, 
> 1 byte,
> so CPU can load/store 1 byte or more on most PCI devices (in MMIO 
> regions), hence:
> 
>        .impl = {
>            .min_access_size = 1,
>            .max_access_size = 1,
>        },
> 
> 
> looks correct to me.
> 
> That said, I understand that pvpanic_setup_io is defining a 2 bytes
> PCI_BASE_ADDRESS_SPACE_MEMORY (Memory Space) and the minimum size of this
> region should actually be 16 bytes, not 2 bytes.
> 
> If you take a look at the PCI spec 3.0, in section 6.2.5.1, "Address Maps",
> it says, about "Base Address Register for Memory":
> 
> "A 32-bit register can be implemented to support a single memory size that
> is a power of 2 from 16 bytes to 2 GB."
> 
> So the minimum size of a Memory Space is 16 bytes, because bits from 0 to 3
> in the BAR are not used for address decoding purposes (they define the type
> of the space, number of bits in the address space, etc.).

Thank you, this is the relevant info I was looking for :)
> Also, in pci_register_bar() the size is used to set the wmask for the
> BAR register:
> 
> wmask = ~(size - 1);
> 
> and with size = 2, if my math is right, gives 0xfffffffe, which is invalid
> (it should be 0xfffffff0 for the minimum size: bits from 0 to 3 should
> be zeroed (falgs) and bit 4 and upwards should be one. The first bit set as
> 1 starting from the least significant bit determines the size of the 
> MMIO region,
> and in 0xfffffff0 bit 4 is the first one that is 1, which kind tells us the
> minimum size should really be 16 bytes for a MMIO region).

Also interesting for PCI_BASE_ADDRESS_SPACE_IO:

   Devices that map control functions into I/O Space must not
   consume more than 256 bytes per I/O Base Address register.

Regards,

Phil.

