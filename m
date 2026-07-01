Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C80C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 11:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wetZT-0006H7-Pc; Wed, 01 Jul 2026 07:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wetZS-0006Gd-GT
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 07:57:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wetZQ-00039J-6p
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 07:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782907054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=432ulGUAbt4oLutAXtqbHCNZcDQegPBUPaOBFpat778=;
 b=chj0O6WjGvO6WTfM2QS1DJIOofjMT6ei7pnpzHGm+oRampT3s+6ThwvLi3HwjA90GhAbDx
 qVVgdq6nPaH+amvMxfSxjTowe/RzGT7HgabEzUp9Gr3z86mkfHMiphG8iDrjE6iauST6+b
 ZwqqC83xaFDf8QdWAKDkM94s1kw0lJU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-uGiBdKKrNv2q25kTHNz7gg-1; Wed, 01 Jul 2026 07:57:32 -0400
X-MC-Unique: uGiBdKKrNv2q25kTHNz7gg-1
X-Mimecast-MFC-AGG-ID: uGiBdKKrNv2q25kTHNz7gg_1782907052
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4773d2405c5so439760f8f.3
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 04:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782907051; x=1783511851; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=432ulGUAbt4oLutAXtqbHCNZcDQegPBUPaOBFpat778=;
 b=K74Rk5+z9Kj3SKaB69H7hsX/OX6PKr2rN3IAZtMVzuBJ6El14mhL9rjZ3hdGRBtDcy
 /7+ZipbxPLLXyPRvGNqKcXHRP3Xp+sEeHKQVeWsMGzIlhfwrlRAEcef95bi3/wsZbn0j
 6PyB5DDvWDsQJ3wrSqykqDlG399nt5b8TVZq+exA1u13rnQKGoOLSsZTpuwt6YYncckv
 MGUHkFkhGzEKbclLSh2YK0Mr/dwt9NR5uE4cN6JFYtNRN5PSF6S1TbRDu4vQLEFIN9DV
 aAcEwMuzppIHsOgNbM2WnvpDpU6CtJAiNz8e3JGrYX3BK3q9TSn/8JdhRcYtETmjS89Q
 VpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782907051; x=1783511851;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=432ulGUAbt4oLutAXtqbHCNZcDQegPBUPaOBFpat778=;
 b=VlvIuS1XVWrH0VoCooY+Kb0jK/bw3tlBGvVb9/xjMUPEXN79w3OcautYSsjTrueOj+
 /b5lV8WO0CRG67hv7lhThMKmA60XFCF+pG2xLeQpqDUQ4rfIP1J1iF4wkjvJI4Ou4uCZ
 t6D1H8f1IovSIDrUdubs8Tg/E8iJKWPGMRkUd3UJ4oLYeJTZuludQWzfT9+zISf/TMil
 kF2g/51lBr7aGW3deVKUra0JzXiLWXixa+A+mmDmEpV4akKn2yRXFiNUzaU+OpogfHHa
 QVS9A4u8zMdzolzNKmh0/+kYWtQ8opm0W6UVQP2SVLqf8WhFw24N1e1SsdwSG7b4m+jl
 9pEw==
X-Gm-Message-State: AOJu0YwEh60o52kQpLpwZUeuVNZ6hmnREsQ9i8xIhBF+45plfBxn5ERT
 cnWy63aTgibYylQwOy36zSkHmuS+MPXN5oQzG42WNeBRBvRRMdEOCpWM32cQ87NC+Ao4BGMiubS
 p+9uFzwwJPPU03F6Q9QnbkmsokN2hqAXEF48Mabr7UkMQtVWNXx5l+yfg
X-Gm-Gg: AfdE7cngWxSDqyVSeyTMTnDOBwBuf3+6pgL/IO1zr/XXQNuND2sMzMvsXUFwzMVScVE
 15p+eeyaeBFj8aZJMDs+lmx1KnQYN3aawGjtUVKrpXMHjI9aIuj17UTCa5J2/kOeoKD3cXe1gjy
 RKskJevqW7Rd/F8zfQYRFU4D1u/K4WM4WBeWjD82jaOlqF+YhBSzIZdkE5weRJqhnuoOvTE9lY5
 cXPrjpJoZSX2ELDT6vluR3r/ELDsinSixUxjN7BgD/6FZE8C+UVwvomYScrAqO6nhSf09Gs3AGA
 Uw8jAOL7jPfEQJ2qJUFcznzMhJh2nFozrH3f5lbxT2n852eRLcIBnkGRUlPwfgJSl0Btyrn2XPL
 CpglM4mjj0KByne0nq9JE1D9BJDL2oLRwSsQT9nhvcw4/Xnc0/yVaxw==
X-Received: by 2002:adf:e009:0:20b0:475:f0d1:eb6d with SMTP id
 ffacd0b85a97d-4775cf541b2mr1689038f8f.58.1782907051549; 
 Wed, 01 Jul 2026 04:57:31 -0700 (PDT)
X-Received: by 2002:adf:e009:0:20b0:475:f0d1:eb6d with SMTP id
 ffacd0b85a97d-4775cf541b2mr1688995f8f.58.1782907051095; 
 Wed, 01 Jul 2026 04:57:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4756797a8besm17387521f8f.35.2026.07.01.04.57.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 04:57:30 -0700 (PDT)
Message-ID: <ffffe2fc-a2fd-445a-876a-dddd1f1cc798@redhat.com>
Date: Wed, 1 Jul 2026 13:57:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/17] arm: virt: create sbsa-gwdt watchdog
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
References: <20260624102830.1355552-1-imammedo@redhat.com>
 <20260624102830.1355552-5-imammedo@redhat.com>
 <db203d86-7280-4210-8640-e94c9f11f9da@redhat.com>
 <20260629153642.14ce960e@imammedo>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20260629153642.14ce960e@imammedo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/29/26 3:36 PM, Igor Mammedov wrote:
> On Mon, 29 Jun 2026 10:37:59 +0200
> Eric Auger <eauger@redhat.com> wrote:
> 
>> Hi Igor,
>>
>> On 6/24/26 12:28 PM, Igor Mammedov wrote:
>>> Allow to use SBSA generic watchdog with virt machine type.
>>> (includes conditional generation of corresponding FDT and
>>> ACPI GTDT descriptors)
>>>
>>> Use '-device sbsa-gwdt' to command line to enable it.
>>>
>>> Instead of using dynamic sysbus infra to wire up MMIO/IRQ/FDT,
>>> statically assign resources in machine's mem/irq maps and wire
>>> them up at device (pre_)plug handlers. It's similar to dynamic
>>> sysbus wiring, modulo resources are nailed down statically,
>>> and wiring is limited to virt machine only.
>>> (Benefit is that tests don't break anymore on rebase due to
>>> address being stable)
>>>
>>> Tested with Fedora 43:
>>>   FDT: -M virt,acpi=off -device sbsa-gwdt
>>>   ACPI: -M virt -device sbsa-gwdt
>>>
>>> Note:
>>> Windows sees GTDT, initializes watchdog but instead pinging WRR
>>> it sets/advances WOR to way too large value, so it's never going
>>> to trigger watchdog reboot (it's Windows driver issue though).
>>>
>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>> ---
>>> v3:
>>>   - (Eric) assign MMIO/IRQ statically and abandon most of
>>>      dynamic sysbus machinery.
>>>   - (Peter) set watchdog freq to system clock explicitly,
>>>     machine version compat won't work in case host is not runing
>>>     1GHz clock. (Tested on Jetson machine)
>>> ---
>>>  include/hw/arm/virt.h    |  3 +++
>>>  hw/arm/Kconfig           |  1 +
>>>  hw/arm/virt-acpi-build.c | 29 +++++++++++++++++++++++++++--
>>>  hw/arm/virt.c            | 37 +++++++++++++++++++++++++++++++++++++
>>>  hw/core/sysbus-fdt.c     |  2 ++
>>>  hw/watchdog/sbsa_gwdt.c  |  1 +
>>>  6 files changed, 71 insertions(+), 2 deletions(-)
>>>
> [...]
>>> @@ -3820,6 +3824,10 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>>>          qlist_append_str(reserved_regions, resv_prop_str);
>>>          qdev_prop_set_array(dev, "reserved-regions", reserved_regions);
>>>          g_free(resv_prop_str);
>>> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_WDT_SBSA)) {
>>> +        uint64_t cntfrq = object_property_get_int(OBJECT(qemu_get_cpu(0)),
>>> +                                                  "cntfrq", &error_abort);  
>> missing extra line.
>>> +        qdev_prop_set_uint64(dev, "clock-frequency", cntfrq);  
>>
>> Can you explain why you cannot do that in virt_machine_device_plug_cb()?
> 
> sure,
> all prep work, typically is done at pre_plug time. (it's stage we are allowed to fail)
> 
> While at plug time we typically do final (post realize) wiring/exposing model to guest
> (no allowed to fail (I need to do cleanup and remove errp from all plug handlers
> but that is orthogonal to series))
> 
>>>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_ARM_SMMUV3)) {
>>>          if (vms->legacy_smmuv3_present || vms->iommu == VIRT_IOMMU_VIRTIO) {
>>>              error_setg(errp, "virt machine already has %s set. "
OK
> [...]
> 
>>> diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
>>> index acb970e8b3..c4dd8005b7 100644
>>> --- a/hw/watchdog/sbsa_gwdt.c
>>> +++ b/hw/watchdog/sbsa_gwdt.c
>>> @@ -285,6 +285,7 @@ static void wdt_sbsa_gwdt_class_init(ObjectClass *klass, const void *data)
>>>      dc->realize = wdt_sbsa_gwdt_realize;
>>>      device_class_set_legacy_reset(dc, wdt_sbsa_gwdt_reset);
>>>      dc->hotpluggable = false;
>>> +    dc->user_creatable = true;
>>>      set_bit(DEVICE_CATEGORY_WATCHDOG, dc->categories);
>>>      dc->vmsd = &vmstate_sbsa_gwdt;
>>>      dc->desc = "SBSA-compliant generic watchdog device";  
>> You may document somewhere that the device can be dynamically
>> instantiated, in machvirt alone and this required machine specific
>> hardwiring.
> 
> Any suggestion wrt where to put it? 

At least you need to update system/arm/virt.rst with the new support of
the sbsa-gwdt device.

wrt the fact dt bindings are not created by default I would add least
add a comment above dc->user_creatable = true;
saying it requires manual dt bindings in the machine that uses it.

Thanks

Eric

> 
>>
>> Thanks
>>
>> Eric
>>
> 


