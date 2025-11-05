Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046B0CCFA0D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 17:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGhG0-0006pm-PX; Wed, 05 Nov 2025 12:25:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vGhFz-0006pQ-6b
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 12:25:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vGhFx-0005LV-HO
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 12:25:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762363511;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F7kvwDLXFkP0drhhbVeUYkZax+HxH2jYez81iitq5qY=;
 b=Mrdm9AAQmluhlJh4I98ls3rC4SCVH7LFqCn27AufcDr0m9HuHmxdH7wo/cF/ivIsWn9wb4
 +oE2Y42aMlYqX6eCKU1B25ZIwkeTH+A+xV0d/iRQ/Sf0Xpg4Tdqk/d4rTMi5CEjV6ECuPw
 818HKymdERXsbtLSkAHY6MmKmz2y+QQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-5jXpE2j5M4aGK4Zyn4DFeA-1; Wed, 05 Nov 2025 12:25:09 -0500
X-MC-Unique: 5jXpE2j5M4aGK4Zyn4DFeA-1
X-Mimecast-MFC-AGG-ID: 5jXpE2j5M4aGK4Zyn4DFeA_1762363508
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-471201dc0e9so373515e9.2
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 09:25:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762363508; x=1762968308;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F7kvwDLXFkP0drhhbVeUYkZax+HxH2jYez81iitq5qY=;
 b=XMGdRhO/2W1fP4dIQBOQzEnFsYO8aFwhRE9Ge9/kk8VR38xYpjUUeedmemTIIuNgPV
 baKS0i02mxRAxbQqrlMmC0lsMM2XOLxfPfXIjVY4sPhos2E3RUVIUaib9SFAVcDbPuu0
 P3MATZraWoDiElzH7hsdxGO3soCliOnU5knstTD8wMB8pHry7BQ2+oJh1fg9Z2BtSMbj
 o638VkXmWbyO7aMElyuKe581icObG2grWtw+/YeFQ/q3oZrtHPh2Yu4kU+ljdIJ/Nauw
 bOKv3nQjOtfPCEEYtiWTj2LAW+JniiZur7SBp5f1M3EqfODh9Bpg7eGIHjR6wuKz8MXl
 qEXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ4y9LFy2vp+WASHKPkonbAFvnOPHDmW1rIptNG6mDZLE7GVMuN5AR58PId62TvUbTqaCPOCPvtppA@nongnu.org
X-Gm-Message-State: AOJu0YyMLJ5eSBYzGNzu365Fl43ODFi+UpMUFLBeW1gziJ4D8p30tOHT
 vRUXwOMlzkvmBbcxgOUdYwOC4IMogl3dLvuuBQmr3z+ZMvU32P0uaAExlOGXG1o+EMuXcCh6J9P
 PjA+yd30DNG+JAjr2bmaRGkp2cWUumRwEniMLolW+Y5S/k/ejZAA5F1hU
X-Gm-Gg: ASbGnctB4iiFOV12m3suXUfBLkDOn9/Baog3Oksw6lcCP6RiAf7YAN4jbio0byC4UCQ
 M92b4zCVDDR9gJATlK84Nk1HSg42p9yrNDk2JAPGd+EWZtdXErQsZbYM4avysqD+DSIvdsBH2uR
 TTrBvDPZ2UuR+93xvd95yjbqn7vJ6HYMxaU9jre5b0UN3P4QM4NWAkpGXj2W+K+3xYEb5EHbgBM
 z+w0GtrA4hJiTJtR25nccOsRZXhx4J5W6FV/tZclN97Q5M6eTltL61eXcgHfOmM+a+r5JbFpnbp
 Mv4PqWYPpj9hT8yDWdsaWi3QsNTc+SBjFYxASvPC8FAWb4PAGIWU3ARRK4RGdaL+DypzsB47CkO
 uvxnw7CiWrDVitFFbthSdNRYkR8NPaUyp5Lsr5eUI/dfM2w==
X-Received: by 2002:a05:600c:4e88:b0:477:fcb:2267 with SMTP id
 5b1f17b1804b1-4775cdad1edmr31847155e9.8.1762363507924; 
 Wed, 05 Nov 2025 09:25:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFU++5s7kTrEHO9Vp8w9FCtiSLdXLMaNfAfBPgzQ9szxug3ri0KZkJvmJv8mLgUlL75KIxZcg==
X-Received: by 2002:a05:600c:4e88:b0:477:fcb:2267 with SMTP id
 5b1f17b1804b1-4775cdad1edmr31846895e9.8.1762363507526; 
 Wed, 05 Nov 2025 09:25:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429dc20198csm11976889f8f.47.2025.11.05.09.25.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 09:25:07 -0800 (PST)
Message-ID: <7ac24d9a-0caf-48cb-832c-812fecc5c82c@redhat.com>
Date: Wed, 5 Nov 2025 18:25:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-16-skolothumtho@nvidia.com>
 <318947de-4467-4ced-a5d2-929e3df210ef@redhat.com>
 <CH3PR12MB754815B9B902E7EF66B0A1B9ABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <85f315a2-e49a-4330-9419-48a8a3a4a3e3@redhat.com>
 <CH3PR12MB754844745DF256D7FF2CB07AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <e4fd6d1e-3fca-457b-ac6a-69e721d799f4@redhat.com>
 <CH3PR12MB75489F2161213432D34688D2ABC5A@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB75489F2161213432D34688D2ABC5A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 11/5/25 12:41 PM, Shameer Kolothum wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 05 November 2025 08:57
>> To: Shameer Kolothum <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; Jason Gunthorpe <jgg@nvidia.com>; Nicolin
>> Chen <nicolinc@nvidia.com>; ddutile@redhat.com; berrange@redhat.com;
>> Nathan Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
>> smostafa@google.com; wangzhou1@hisilicon.com;
>> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
>> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
>> Krishnakant Jaju <kjaju@nvidia.com>
>> Subject: Re: [PATCH v5 15/32] hw/pci/pci: Introduce optional
>> get_msi_address_space() callback
> [...]
>>> IIUC, the prereg_listener mechanism just enables us to setup the s2
>>> mappings. For MSI, In your version, I see that smmu_find_add_as()
>>> always returns IOMMU as. How is that supposed to work if the Guest
>>> has s1 bypass mode STE for the device?
>> in kvm_arch_fixup_msi_route(), as we have as != &address_space_memory in
>> my case, we proceed with the actual translation for the doorbell gIOVA
>> using address_space_translate(). I  guess if the S1 is in bypass mode
>> you get the flat translation, no?
> Yes, I noted that and replied as well.
>
> Again, coming back to kvm_arch_fixup_msi_route(), I see that this was introduced
> as part of your " ARM SMMUv3 Emulation Support" here,
> https://lore.kernel.org/qemu-devel/1523518688-26674-12-git-send-email-eric.auger@redhat.com/
>
> The VFIO support was not there at that time. I am trying to understand why
> we need this MSI translation for vfio-pci in this accelerated case. My understanding
> was that this is to setup the KVM MSI routings via KVM_SET_GSI_ROUTING ioctl.

yes that's correct. This was first needed for vhost integration. And
obviously this is also needed for VFIO.

allows vhost irqfd to trigger a gsi that will be routed by KVM to the
actual guest doorbell. On top of that it registers the guest PCI BDF for
GiCv2m or GICv3 MSI translation setup.
if the guest doorbell address is wrong because not properly translated,
vgic_msi_to_its() will fail to identify the ITS to inject the MSI in.
See kernel kvm/vgic/vgic-its.c vgic_msi_to_its and vgic_its_inject_msi

Eric
>
> Is that right?
>
> Thanks,
> Shameer
>
>
>


