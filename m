Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057B1CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 17:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Sub-0000wK-Uz; Wed, 24 Sep 2025 13:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1v1SuT-0000qL-E8
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:04:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1v1SuL-0006pA-5E
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758733431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7Whxs7qpUU9p1iapMAzZNN9FpxKDeUQd3C6vOEafzYs=;
 b=eZhcbtcB50eDqqhIj83kfNyyC2UO9JlMKuTm4YCwxYebB2D18wxHOVIMIKVIZinpF/8RIQ
 jKO4a50pHWMtZXGTHmZDhaCUODvmmFLVBeGBrgDKELVJrkrZ4wclHHxpodbD6K5iVrL4Dd
 CnUgh8fbdQh/2EttleP5F5ggSJTGlcM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-d6hZN3edPYiVOld_slJnag-1; Wed, 24 Sep 2025 13:03:50 -0400
X-MC-Unique: d6hZN3edPYiVOld_slJnag-1
X-Mimecast-MFC-AGG-ID: d6hZN3edPYiVOld_slJnag_1758733429
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3fba0d9eb87so54977f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 10:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758733429; x=1759338229;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Whxs7qpUU9p1iapMAzZNN9FpxKDeUQd3C6vOEafzYs=;
 b=cDhUQ9o/Y3NfrxIebR9fekzlaXm+QhUjyjdqSg7twUqaI/D3BVumtpj2tZNB93BCp2
 6cWe5daKwuqtt+WA2K4bROeOP3AlQWPH2y3KEQaws59M/hjEThcWBGkbnFOn5TFAk6cL
 Sqsi4UUdpxQWmii4E1dne93qUIaUDenkRfElQrCqq1Iln3RXZ1v8HfulnLbGYrSMFfAB
 sdcCMucWoxCD7WOGgdjKml3Rv2RoXvcW+jw/lA1Mvr68Ft3hpTRu1E3Zhcnc/FZqTB4v
 2YHvQyivlcghHwdfxOmgBv8qWXkVoP8geAUoiY12iYZV88IZuST0feodixJVWPfmMZOi
 jBGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjt9Yq6zYoP7/WoUZYV5a9DJJbABa4chBY+DLYyCgh+ndA0M7VaI1Vy3VpVvkFQrTCqn2G90mD03RM@nongnu.org
X-Gm-Message-State: AOJu0Yx10PHh7XroC0y7sAmxK4Xc/s/6MAOs/yfL52mFMAUC/XMNnjvT
 MeQj38ROOnZrpNeZ4fk+yCRrfhXLTsmON8W2UbM9/Se22MGWbMWJAJdPb1puX5ytyWCYsH6QmYk
 8lFQgLZXg5zQsJfUx9nmroQsfn0HcTchCJ2UW45imzQWsuR30moE8f9td
X-Gm-Gg: ASbGncsVV5V7NqZ//evgenChOhQ+n+7jDEE9tzK9kB5jMzhpxphuYKT2O+lLdWHK3+r
 ubk89OEexb1I/Rxl7OvoKWWV6BmoGTmdzOqiOsbs53mNhBl1L8FGQQf6TsLH/WuFc42tDWM+jMD
 i/GYYXZv33PC1/14ioso85UrTP4VNMaj8h32TsesH1TePZIPqtOwL9EtZfKUwv7TELIE0KP425e
 eisA6AwHl7x859Gr5jXmTcvsZCNYTeCarV8jKC0XRCfFNB2TyG8LinSFLocUlUSXnnxPoxtavG9
 sImN/xpTgmwY3QNiaenVXMtubXLH7gdikDXDukC9AdK9mACfVLR9ASlEL/E+r4TYJp4iNqq+4vE
 G05DHCgMenYLAp0I7iFAGGdTm0Bfwt0SoSzsT9B0Wj1ag4KEgW/b7jd2i5o4bqBgnLA==
X-Received: by 2002:a05:6000:288d:b0:3f4:a9f5:c10e with SMTP id
 ffacd0b85a97d-40e4adc0ffdmr590553f8f.36.1758733428673; 
 Wed, 24 Sep 2025 10:03:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2uIdLYsY+mfwR7lbL4Qo+AqhZGREw/X7jTOMXPoqU9J7PWWDonCJClb3Dg5NhSS2zVauhUA==
X-Received: by 2002:a05:6000:288d:b0:3f4:a9f5:c10e with SMTP id
 ffacd0b85a97d-40e4adc0ffdmr590523f8f.36.1758733428171; 
 Wed, 24 Sep 2025 10:03:48 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f14:2400:afc:9797:137c:a25b?
 (p200300d82f1424000afc9797137ca25b.dip0.t-ipconnect.de.
 [2003:d8:2f14:2400:afc:9797:137c:a25b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3fe9dbf13f3sm12624412f8f.50.2025.09.24.10.03.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 10:03:47 -0700 (PDT)
Message-ID: <fa625f3d-6493-4213-b317-23ab1e16ac37@redhat.com>
Date: Wed, 24 Sep 2025 19:03:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] numa: add 'spm' option for special purpose memory
To: fanhuang <FangSheng.Huang@amd.com>, qemu-devel@nongnu.org
Cc: Zhigang.Luo@amd.com, Lianjie.Shi@amd.com,
 Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250924103324.2074819-1-FangSheng.Huang@amd.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250924103324.2074819-1-FangSheng.Huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 24.09.25 12:33, fanhuang wrote:
> Hi David,

Hi!

CCing Igor and Jonathan.

> 
> I hope this email finds you well. It's been several months since Zhigang last discussion about the Special Purpose Memory (SPM) implementation in QEMU with you, and I wanted to provide some background context before presenting the new patch based on your valuable suggestions.
> 
> Previous Discussion Summary
> ===========================
> Back in December 2024, we had an extensive discussion regarding my original patch that added the `hmem` option to `memory-backend-file`. During that conversation, you raised several important concerns about the design approach:
> 
> Original Approach (December 2024)
> ----------------------------------
> - Zhigang's patch: Added `hmem=on` option to `memory-backend-file`
> - QEMU cmdline example:
>    -object memory-backend-file,size=16G,id=m1,mem-path=/dev/dax0.0,prealloc=on,align=1G,hmem=on
>    -numa node,nodeid=1,memdev=m1
> 
> Your Concerns and Suggestions
> -----------------------------
> You correctly identified some issues with the original approach:
> - Configuration Safety: Users could create problematic configurations like:
>     -object memory-backend-file,size=16G,id=unused,mem-path=whatever,hmem=on
> 
> - Your Recommendation: You proposed a cleaner approach using NUMA node configuration:
>     -numa node,nodeid=1,memdev=m1,spm=on

Oh my, I don't remember all the details from that discussion :)

I assume that any memory devices (DIMM/NVDIMM/virtio-mem) we would
cold/hotplug to such a NUMA node would not be indicated as spm, correct?

> 
> Project Context
> ===============
> To refresh your memory on the use case:
> - Objective: Pass `EFI_MEMORY_SP` (Special Purpose Memory) type memory from host to QEMU virtual machine
> - Application: Memory reserved for specific PCI devices (e.g., VFIO-PCI devices)
> - Guest Behavior: The SPM memory should be recognized by the guest OS and claimed by hmem-dax driver
> 
> Complete QEMU Configuration Example:
> -object memory-backend-ram,size=8G,id=m0
> -object memory-backend-file,size=16G,id=m1,mem-path=/dev/dax0.0,prealloc=on,align=1G
> -numa node,nodeid=0,memdev=m0
> -numa node,nodeid=1,memdev=m1,spm=on  # <-- New approach based on your suggestion

The only alternative I could think of is gluing it to a memory device. For example,
have something like:

-numa node,nodeid=0,memdev=m0 \
-numa node,nodeid=1 \
-device pc-dimm,id=sp0,memdev=m1,sp=true

But we would not want (and cannot easily) use DIMMs for that purpose.

> 
> New Patch Implementation
> ========================
> Following your recommendations, I have completely redesigned the implementation:
> 
> Key Changes:
> 1. Removed `hmem` option from `memory-backend-file`
> 2. Added `spm` (special-purpose) option to NUMA node configuration

That definitely sounds better to me: essentially "spm" would say: the boot memory assigned to this
node (through memdev=) will be indicated as EFI_MEMORY_SP.

> 
> I would appreciate your review of the new patch implementation. The design now follows your suggested approach of using NUMA node configuration rather than memory backend options, which should resolve the safety and scope issues we discussed.
> Thank you for your time and valuable guidance on this implementation.
> 
> Please note that I'm located in UTC+8 timezone, so there might be some delay in my responses to your emails due to the time difference. I appreciate your patience and understanding.

No worries :)

-- 
Cheers

David / dhildenb


