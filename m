Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AC5C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 17:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tduRE-0004lr-Fh; Fri, 31 Jan 2025 12:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tduR8-0004kS-D0
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 12:04:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tduR6-0004SU-LU
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 12:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738343045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PpkKzZbAOIUKfbPqHFJgPk6203/4JctdwDmWjvwdiYQ=;
 b=Vg7uHfrkfAMTzwoX4T/SeeKSud2fws2+ysUJ7dRukWSVUbMSp85btmZHjpc8eUM8TAXj7E
 HV/7k0POYGCRLI+xR3k1E6r3oZZtF0tccpGiO5DnvdpbfQVr+d70gBq1Co4EEHCe+cWwiH
 n2v9+I7VpYi08nUMPK8DXYQ4g7Iu1zA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-EWcd-n64NuOi_Cun0iHnSQ-1; Fri, 31 Jan 2025 12:04:03 -0500
X-MC-Unique: EWcd-n64NuOi_Cun0iHnSQ-1
X-Mimecast-MFC-AGG-ID: EWcd-n64NuOi_Cun0iHnSQ
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3862b364578so1565154f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 09:04:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738343042; x=1738947842;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PpkKzZbAOIUKfbPqHFJgPk6203/4JctdwDmWjvwdiYQ=;
 b=lF8FD/kDTbnxgfWrNiVf5H2VhEUDXwr1Ia8s1WZtg85GvFea1EJn1cNpAv6iR/TSNJ
 U3/Rez2Y/uEHT4ZL69wu/rNTxSXn98/DY4RLc+TTq80bU4Mvb8XL76fM+ORJZJUorFPt
 oQ3d2SiAwG7gcqdBbKHHxhJkOS1u9oUc3xkYuSLEifXRPcSYY7P+zgWlvSIZ+I18Wslh
 ICVnkt2enjw/tG8wB18qVIGyKFMJ/l3mX5nST0QolV94PgLb1mhfCzJEIMSFy2o7JdgZ
 5Agak9uF/nlIVima35HWvf5TNYakZqot7al5mu+Y/hXWDoyKcF4uVkdEhIsoElxUhs0c
 Z10w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVebp1c7kp0+mudpGdBU3rXk52j8z/RPjH7mB+peTtpz9oEd0s1wEDrHYUDp/b4ev0Cintsl1sUATPw@nongnu.org
X-Gm-Message-State: AOJu0YzdWYuMiQ6uhNGtVSiv12zg0fPfFH2TveZj2IRZMd3vp4cdyWJI
 RkAvIpA8XAlY4FNHYLpZASLA46CG7yA43WjonzGOO8O8HNAmkSaC68DZNGAmSneNFEKg/cCXnLE
 xi0+8exsjbj4G+k2gD5boifapTComRK99urKYTFq/ULqDQTyqUx896zKsnQbD
X-Gm-Gg: ASbGncvM8lh9u/9HbfSk8cGA0Zb1b2h1ixL/zNrJVzktLKzf75Pm1DoogaR2NEwXUZX
 iD9EcqRRYfSMZ3YhpwhVlf4RRXWc44F9yvyzW16GDl+6zh3ztnhKVAo2gT/NR7jq6IV7aeYBxHL
 SBPbr6pgpNTVEbNKOzTujt++9ui7ql9R+H22a8v89vFsJIic+Dh7fznPuS7MZkj5HmnLu99AZoN
 O1FNI/xu2+qgjo+U5tgLPQ9nP8HAAYWBlFkqOZdCO58n+0mV8Z/tLUiAuEeShF5vrIk8kRVsHNt
 hl0BHPOCG4YD2FyyxFuTKlXQmntuj3+uwXC75dNGKDU=
X-Received: by 2002:a05:6000:4020:b0:386:3711:ffa9 with SMTP id
 ffacd0b85a97d-38c60f27a89mr3524100f8f.16.1738343041473; 
 Fri, 31 Jan 2025 09:04:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQYlqpcaUEf9pV7F5rTitzi5cEl7DP+g7kloHKHIY834F+NFWJiRb9oLScDO/bZxoQRuvU1Q==
X-Received: by 2002:a05:6000:4020:b0:386:3711:ffa9 with SMTP id
 ffacd0b85a97d-38c60f27a89mr3523927f8f.16.1738343039576; 
 Fri, 31 Jan 2025 09:03:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e245f5a5sm62158595e9.40.2025.01.31.09.03.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2025 09:03:59 -0800 (PST)
Message-ID: <22bb3017-1db3-4041-81f0-972568de1017@redhat.com>
Date: Fri, 31 Jan 2025 18:03:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] vfio: Check compatibility of CPU and IOMMU address
 space width
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
References: <20250130134346.1754143-1-clg@redhat.com>
 <20250130134346.1754143-9-clg@redhat.com>
 <20250130115800.60b7cbe6.alex.williamson@redhat.com>
 <9cfaf81e-d8cc-4ec0-9c56-956b716891e7@redhat.com>
 <24w7fzx5rf2zdnowtjmuvwuirydryc366xumjf3isgzrhei2ty@ymyjyzdbggr2>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <24w7fzx5rf2zdnowtjmuvwuirydryc366xumjf3isgzrhei2ty@ymyjyzdbggr2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Hello Gerd,

On 1/31/25 14:23, Gerd Hoffmann wrote:
> On Fri, Jan 31, 2025 at 01:42:31PM +0100, Cédric Le Goater wrote:
>> + Gerd for insights regarding vIOMMU support in edk2.
>>
>>>> +static bool vfio_device_check_address_space(VFIODevice *vbasedev, Error **errp)
>>>> +{
>>>> +    uint32_t cpu_aw_bits = cpu_get_phys_bits(first_cpu);
>>>> +    uint32_t iommu_aw_bits = vfio_device_get_aw_bits(vbasedev);
>>>> +
>>>> +    if (cpu_aw_bits && cpu_aw_bits > iommu_aw_bits) {
>>>
>>> Should we be testing the 64-bit MMIO window and maximum RAM GPA rather
>>> than the vCPU physical address width?
> 
> Placing the 64-bit  mmio window is done by the guest firmware,
> so this isn't something qemu can check before boot.
> 
>>> However, we've decided to do exactly that for the 64-bit MMIO window.
>>> It's not that the vCPU width being greater than the IOMMU width is a
>>> fundamental problem, it's that we've chosen a 64-bit MMIO policy that
>>> makes this become a problem and QEMU only has a convenient mechanism to
>>> check the host IOMMU width when a vfio device is present.  Arguably,
>>> when a vIOMMU is present guest firmware should be enlightened to
>>> understand the address width of that vIOMMU when placing the 64-bit
>>> MMIO window.  I'd say the failure to do so is a current firmware bug.
> 
> edk2 has no iommu driver ...
> 
> Is there some simple way to figure what the iommu width is (inside the
> guest)?

When using VFIO, vfio_device_get_aw_bits() will return the IOMMU
address space width. There are checks when using a vIOMMU that
the host and vIOMMU address space are compatible. vIOMMU should
be smaller.

> Note that there is a 'guest-phys-bits' property for x86 CPUs, which is a
> hint for the guest what the usable address width is.  It was added
> because there are cases where the guest simply can't figure that it is
> not possible to use the full physical address space of the cpu.  There
> are some non-obvious limitations around 5-level paging.  Intel has some
> CPUs with phys-bits > 48 but only 4-level EPT for example.
> 
> So one option to handle this is to make sure guest-phys-bits is not
> larger than the iommu width.

Yes. This is what I am trying to do.

Patch [1] returns X86_CPU(cs)->phys_bits. I was not sure which *phys*
property to use. If you think this is incorrect and not returning the
right information, I will change the proposal with guest-phys-bits.

Thanks,

C.

[1] https://lore.kernel.org/qemu-devel/20250130134346.1754143-8-clg@redhat.com/


