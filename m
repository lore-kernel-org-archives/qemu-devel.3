Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0B6CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 12:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUktn-0000eD-7g; Wed, 03 Jun 2026 08:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wUktk-0000dw-J2
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 08:40:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wUkti-0005UB-RN
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 08:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780490435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6CTQsTfB/y5Z0JExycOEDqIy/qa7iPzuMopFTHJSM1U=;
 b=PhVxSiHZiBgrj1rFOHSOF4yjd4JUpNUK3dfTHo25HwYBD48qP5wFSVkiU2tld8rEWmd71T
 ycichqiZGuUv66UwSyVRba5uGip0ijyQ++CDP4u92r3GtxN8TNv2QTHzj5s2d3gbi2oz3Q
 D3qXfmfJVqPTSoiugWcrfwTRLb2JfWg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-QzsQDKs8P46CV2gM-5kUsg-1; Wed, 03 Jun 2026 08:40:33 -0400
X-MC-Unique: QzsQDKs8P46CV2gM-5kUsg-1
X-Mimecast-MFC-AGG-ID: QzsQDKs8P46CV2gM-5kUsg_1780490432
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490b7959b9fso7200915e9.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 05:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780490432; x=1781095232; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6CTQsTfB/y5Z0JExycOEDqIy/qa7iPzuMopFTHJSM1U=;
 b=Wu6RN1WLZvpCO8bdD9JdDKoaNnlq8kYGF+ZUlzhwa6Aa8d2G6ENxbvt7u751EPyZT4
 SZH5eVtQr89Yn4Q6Z/20e7Pl43IFeyLZhzMVoMr0omB65qmLfnm0SkUaiWEFS7ZTggAf
 NY/S5NollJxDbL+d6h7Gh/Kt0BrqFZ90QZx4FpTAzI0cXcBMAlBUaJpjZWVKaE2kT0OT
 9VXT7IYF8UrH1jAdIw2zk21QLhUAh+M9ZNDpS6oNTfILeRVFz1KgQmAASNVeVp/vwJWn
 ldF2Udl5COsUUfcaC7+8yxqMrQsXHWWddzUpDYMP0BsDXstRKoCMH+l63JNqBuMONnqQ
 cuqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780490432; x=1781095232;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6CTQsTfB/y5Z0JExycOEDqIy/qa7iPzuMopFTHJSM1U=;
 b=hL0zRx7Q2LeWzxvB4ysP03A2QSAuEdOmUI7E8bg8b6G52bqeLWDfOW7goENYrfza0S
 czqIAcca+e9JQW5C17QXhQIR/7WPYJeoy6+KV6NvBihfrQO2rNoLn+EKYQhYBXSkZh6B
 4gGeCAUG400p0nMTjbwgzRZOl7zKAPPB5ejpLm0uuQ4w361gC1lGHHO6Hs599BI4P38d
 1f6w79YQmlZyZXtSMKPacU/0ulSwy+PFjpUJ3/CbV8g4WBgQA2tacUiz6sfcag/apw1Y
 Ji+qEEnncJu8jiH4EHatB6HEnqo0KS8K/bw1C6t+JPWqHgMnqtg56ZtsIXz5D84UjRDd
 GDhg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9JVwiXEm0IqYCT3aJZqprcLBoSuLAMhaDSrjSDxHPdf+zH7X/u0H/hCgtOoDtqd3/zaVKOVtpKYswt@nongnu.org
X-Gm-Message-State: AOJu0YyNEDksNr7lw4ymxquCAs4I/aYR+VM8ebQLzugtXAdJK6O6kL8S
 qhzBQyUahF5/B7O7uF6g6nI4I5XLeYa9/6HG4BT9Hp9Wm0Y8k7lSrkDE3R4kvkhmwrp6u4yb6x+
 avRFJw2+g/va95Kzx/Q3PsGy2lm1f/FnvGX0JSCwdnB+pmtH3exc7qi9u
X-Gm-Gg: Acq92OFwgJhGhrHFdonvaBSOaByzvFeD2AY3n/7UK+TYCH/ZWBElglUpPKcJ04LaDtj
 Si2wC7p2/+X5lgsE0Jf38z0cWQpHeHDCHtHbCRevEIVVywMuiRPawqGS36FjPsIz/41EFgS8M17
 BWa2XDur3iEbuKRNTTIR8AT+2UNBaE5AV89lISeWcAz0xQqWUg6SnpmsLOJfv6orHIx2vdML7qp
 hkKVM8wcH7Qg5SB8b/6zY+uSpLK/qEXSA5imTC1SRrXqvvYp56Als3sgnI6n7f1O5bi43vKUgh7
 mTprvV2mB3FH5dDO2ik8I3eQ8j/jh+vznSXADaeeQfqQOgnmKgjIy0tC2wNzvQKDcmz6Q0oJdUO
 /nKBKoq6IKVu27/+TmnkdfINxuDGt0ASkwq4IYMS9MCpEqSWd8+ycjHJCMBQVZnSe3FUoYmifyA
 8=
X-Received: by 2002:a05:600c:859b:b0:490:acb8:1490 with SMTP id
 5b1f17b1804b1-490b5e94e91mr46296505e9.4.1780490431853; 
 Wed, 03 Jun 2026 05:40:31 -0700 (PDT)
X-Received: by 2002:a05:600c:859b:b0:490:acb8:1490 with SMTP id
 5b1f17b1804b1-490b5e94e91mr46296005e9.4.1780490431488; 
 Wed, 03 Jun 2026 05:40:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f345209sm7136048f8f.17.2026.06.03.05.40.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 05:40:30 -0700 (PDT)
Message-ID: <a745b87b-85c3-43c5-8059-36797588c190@redhat.com>
Date: Wed, 3 Jun 2026 14:40:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci/pci: Enforce pci_setup_iommu_per_bus() is called
 only once per bus
Content-Language: en-US
To: eric.auger@redhat.com, Nicolin Chen <nicolinc@nvidia.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, mst@redhat.com, skolothumtho@nvidia.com,
 nathanc@nvidia.com
References: <20260323183024.4069032-1-eric.auger@redhat.com>
 <aco9ECUbZ1+QvbOR@nvidia.com>
 <5ccbdd38-e63f-4a4a-8d28-9621bf8883fe@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <5ccbdd38-e63f-4a4a-8d28-9621bf8883fe@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Nicolin,

On 3/31/26 5:06 PM, Eric Auger wrote:
> 
> 
> On 3/30/26 11:06 AM, Nicolin Chen wrote:
>> On Mon, Mar 23, 2026 at 07:30:20PM +0100, Eric Auger wrote:
>>> @@ -3307,11 +3307,16 @@ void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
>>>   * IOMMU ops are returned, avoiding the use of the parent’s IOMMU when
>>>   * it's not appropriate.
>>>   */
>>> -void pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops,
>>> -                             void *opaque)
>>> +bool pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops,
>>> +                             void *opaque, Error **errp)
>>>  {
>>> +    if (bus->iommu_per_bus) {
>>> +        error_setg(errp, "An iommu is already attached to this bus");
>>> +        return false;
>>> +    }
>>>      pci_setup_iommu(bus, ops, opaque);
>>>      bus->iommu_per_bus = true;
>>> +    return true;
>> Do we need the same check in pci_setup_iommu()?
I further looked at it. pci_setup_iommu registers a machine wide iommu.
Only ARM uses pci_setup_iommu_per_bus for now and usage of both
pci_setup_iommu and pci_setup_iommu_per_bus are exclusive and check is
done at machine level.

So I think it is reasonable for now to keep that change limited to
pci_setup_iommu_per_bus.

Needs a rebase though, including Philippe's suggestion.

Thanks

Eric


> 
> For machine wide IOMMU the check is handled in machine code (at least in
> arm virt).
> 
> Nevertheless a more generic solution could be to check in
> pci_setup_iommu() that bus->iommu_ops is not already set. If set, return
> an error, cascaded up through pci_setup_iommu() and
> pci_setup_iommu_per_bus().
> However the change is much more invasive and impacts several archs. What
> do you think?
> 
> I don't think this can be a valid use case to call pci_setup_iommu()
> several times on the same bus?
>>
>> Apart from this question,
>>
>> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> Thanks
> 
> Eric
>>
> 


