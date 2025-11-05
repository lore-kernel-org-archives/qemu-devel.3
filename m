Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3886CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 17:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGhNR-0000Mv-Cn; Wed, 05 Nov 2025 12:32:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vGhNJ-0000Lp-TC
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 12:32:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vGhNI-0006Gx-25
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 12:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762363966;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ETut4KkNWT/BCT5wy0gh0ieCKE10jSt3ObhCH+eQVFo=;
 b=Rwbnk65V/0nJgaGQ2lDArceXmsYYOObocBxeUX2KnXC9D4QcrPiHChOO6SAAG0hatBesXP
 R5CjDOQHKbwtpDPuDbCgLjAEYJVuuUWXa5C06HBK2hkFNda1LQiWQ8G5aD2fpFoYu6I/dT
 mWJh8rOuE2WxCsJkHtB4KRyYYT6RxZk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-nDoZe5z5OoaI6kyFwL73Aw-1; Wed, 05 Nov 2025 12:32:44 -0500
X-MC-Unique: nDoZe5z5OoaI6kyFwL73Aw-1
X-Mimecast-MFC-AGG-ID: nDoZe5z5OoaI6kyFwL73Aw_1762363964
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4773e108333so508825e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 09:32:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762363963; x=1762968763;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ETut4KkNWT/BCT5wy0gh0ieCKE10jSt3ObhCH+eQVFo=;
 b=AqwEcKYuAzrMqwkJOGeqT3OY2XHNvyUabg+S/NGctx/PTsxs7Bulb8aaL11oJn0Zeg
 hHKL+eZSAt+ppH9UguNUdIPhOR8nUkRPz1IkXVTKHHLI2P7FvBqc/ofhF58TknnPv5Fh
 bffTOJ80Vd8HXridoxYBuSdrPHXSTVGbmgX7jX/OuH0ANsa8p0LeEbmexK1lAaCQ3hbX
 X02PQhr9YzRBe9zptvKQnYec537V8HuXsThVbnbWWG74FsbRkifRsJ6DHRTJ0s45v5Ri
 9/Gl3OPGZGKZ90jjYi6m5CurGDzAOP68G6MR4xOxiKvHDhpZ8zGWX4i8cnZDUIh9xQsC
 HtXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr6jMl+q2lC/PEdDyfd5E81zjSp3aMzMuUHqQ52X6QfwCBLTH3SuDe0RUmnJdJer6HD5Ea56B0q7La@nongnu.org
X-Gm-Message-State: AOJu0YzfBtHBKOVCvr1sRaPJx/fmdPVsmlyW1frmq3wSaSPBPxb/bcpL
 DFqnqY2Pm7zi/LgOGfcb5HXT4SqNPwsBKHpZrW7pwHAdA+BGtQq/mz0SF7kFviYTIckNIG66rIT
 hVciXPUbNo2G/z57b9N57LpL+d35afvMa7vldvW9fmW0FgGJZ8GG5BBZA
X-Gm-Gg: ASbGnctpVfEynPS/Kven934xdXj7o5y9EgscIT2SGXv0Tc4yknaJevY7qRWxnuLxS1N
 UWTR4x/2hG7Z+omG30Cfu2AcsHPA7phiL4LyYJkkmx8TcnYqPjkgbpOy91rWh6FjRBsL/ksg4ol
 mK6UZRzTs0nyycGic8vNnbO+wQgO+wxqn8hFYqZF07zKK+vsUAkTj6PBaj567lTyqVlSFPoXlbk
 uH4bAJPtu3Rw5+pfViVDGvA3angNE7rB5byndoqYiWuHefmN9zxBJC7BLuJGE+rTcIPDhu7h2GA
 3DLylUFyp6kUl+ElVYa8AHUI/i5/vM/hoYvuUk2sKwwGjJs9x4qnV4yrYpIx4mlAl4/Sjl9D+Mn
 eC+0ljjOCDKrQP65Vd4FVRDW2RozChojElBkT4Q16ccLKeg==
X-Received: by 2002:a05:600c:348f:b0:477:54f9:6ac2 with SMTP id
 5b1f17b1804b1-4775cd3bd61mr43957785e9.0.1762363963564; 
 Wed, 05 Nov 2025 09:32:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2gTPfMaLwxZaRw0Z4Nl7Bp9jmdrjyUSPZTDYdLSX9khLuz+6HeMLAlGkR+PPci8tJzlc8IA==
X-Received: by 2002:a05:600c:348f:b0:477:54f9:6ac2 with SMTP id
 5b1f17b1804b1-4775cd3bd61mr43957475e9.0.1762363963190; 
 Wed, 05 Nov 2025 09:32:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4775592eeaasm49683145e9.3.2025.11.05.09.32.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 09:32:42 -0800 (PST)
Message-ID: <e9d5300a-6aab-4b17-828f-3d3a4d3071df@redhat.com>
Date: Wed, 5 Nov 2025 18:32:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: Shameer Kolothum <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
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
References: <20251031105005.24618-16-skolothumtho@nvidia.com>
 <318947de-4467-4ced-a5d2-929e3df210ef@redhat.com>
 <20251104142052.GD1537560@nvidia.com>
 <CH3PR12MB7548E5E1A2DFE297C4C65E0AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104145157.GF1537560@nvidia.com>
 <CH3PR12MB7548379E64E7A12904B5BF7AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104151234.GG1537560@nvidia.com>
 <CH3PR12MB754877D400D19E57AFB16D0BABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104153535.GH1537560@nvidia.com> <aQoz2+bLMJWNoVwx@Asurada-Nvidia>
 <20251104174152.GI1537560@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251104174152.GI1537560@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
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



On 11/4/25 6:41 PM, Jason Gunthorpe wrote:
> On Tue, Nov 04, 2025 at 09:11:55AM -0800, Nicolin Chen wrote:
>> On Tue, Nov 04, 2025 at 11:35:35AM -0400, Jason Gunthorpe wrote:
>>> On Tue, Nov 04, 2025 at 03:20:59PM +0000, Shameer Kolothum wrote:
>>>>> On Tue, Nov 04, 2025 at 02:58:44PM +0000, Shameer Kolothum wrote:
>>>>>>> Sure it is trapped, but nothing should be looking at the MSI address
>>>>>>> from the guest, it is meaningless and wrong information. Just ignore
>>>>>>> it.
>>>>>> Hmm.. we need to setup the doorbell address correctly.
>>>>>> If we don't do the translation here, it will use the Guest IOVA
>>>>>> address. Remember, we are using the IORT RMR identity mapping to get
>>>>>> MSI working.
>>>>> Either you use the RMR value, which is forced by the kernel into the
>>>>> physical MSI through iommufd and kernel ignores anything qemu
>>>>> does. So fully ignore the guest's vMSI address.
>>>> Well, we are sort of trying to do the same through this patch here. 
>>>> But to avoid a "translation" completely it will involve some changes to
>>>> Qemu pci subsystem. I think this is the least intrusive path I can think
>>>> of now. And this is a one time setup mostly.
>>> Should be explained in the commit message that the translation is
>>> pointless. I'm not sure about this, any translation seems risky
>>> because it could fail. The guest can use any IOVA for MSI and none may
>>> fail.
in general the translation is not pointless (I mean when RMR are not
applied). In case a vhost device (virtio-net) for instance is protected
by SMMU, vhost triggers irqfds upon which a gsi is injected in vgic.
This latter does irq_routing mapping and this gsi is associated to an
MSI address/data. If the MSI address is wrong, ie. not corresponding to
the vITS gpa doorbell, kernel kvm/vgic/vgic-its.c vgic_its_trigger_msi
will fail to inject the MSI on guest since
vgic_msi_to_its/__vgic_doorbell_to_its will fail to find the ITS
instance to inject in.

Thanks

Eric
>> In the current design of KVM in QEMU, it does a generic translation
>> from gIOVA->gPA for the doorbell location to inject IRQ, whether VM
>> has an accelerated IOMMU or an emulated IOMMU.
> And what happens if the translation fails because there is no mapping?
> It should be ignored for this case and not ignored for others.
>
> Jason
>


