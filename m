Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F27CCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 15:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH2DE-0004LV-P7; Thu, 06 Nov 2025 10:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vH2D8-0004Kk-2q
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:47:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vH2D6-00074V-Hd
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:47:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762444059;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aE7TurRqo5OKT7bH4ctkLvDjV6pw4ldeuPuc6pRY5fM=;
 b=HUfLmVuPrLAcTQ+r7+IspEwjbYzE3iJgij+epp3Y85b4Pu/BAwWVOZ4gTJ+35TKHx3oVLu
 5HPbEvCur8irHRGEmBRscapgflTC7IyN9OhfPar2PKU8+qP39E0lXEHjDbwpMc3AfiyfFq
 GSlaHs81I1xZiyi4UWXfNnymCrCRqc8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-1K_FwqJoMzeY8FhLRNtCyA-1; Thu, 06 Nov 2025 10:47:38 -0500
X-MC-Unique: 1K_FwqJoMzeY8FhLRNtCyA-1
X-Mimecast-MFC-AGG-ID: 1K_FwqJoMzeY8FhLRNtCyA_1762444057
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-426ce339084so771432f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 07:47:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762444056; x=1763048856;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aE7TurRqo5OKT7bH4ctkLvDjV6pw4ldeuPuc6pRY5fM=;
 b=EdR7ekgcLtOC8H5EULRg/rwB5dI6XUzVyluTotNFKsQq8Nb9rH8vZ8eiFbSE5XEgjL
 uJa9CmQkNj+WQhbhacdAVjDHN6hVDu6DNBXoJzSqIk4JuHF6QIdMQs5P4kCymgsnD0MU
 TMcr3N0hRVVfedDbMbBR/MP4XLG36tFlRuhMyriJ6mqYKwDBM9Xiv1/AJJrXl7ujvDfx
 fRa4hEzNeCAXLJOVeGh157KXA0pg09Dmh0h3NYkBvmoZW8hxv6YX44+YvzHsWXzlubmY
 So9tJ1XZj0qtcWJxZ6SZgSD7mjMHrC1KbanOXfOb5d7rZN6o1hThiWgiA3gNJmDJbadm
 Fcdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCQ1lNCo/baYz0H3fg2lIPgxQnpelq7LrUksT9TtU/MQOy5UeGcQEEKzELC+Xj9wa++SzF+j4Da1Uz@nongnu.org
X-Gm-Message-State: AOJu0YxEV2XJLq7bO0NixvzMgP97vU4wanrRI9zDnqhKhxDbdgJ+4FI8
 X+ONFilLvxtyMqeabn9REtxPVoYySBJAPJw2dlBa4p5ZX16WZ6MaAgAoBAhUFKGqKtlU4UNRbYP
 E7RHWLLaJhFsEoErhzsp2s8HuAKXDmvTtLlfnqHXPFz/4cZDG00bsD6mBsZo3aszh
X-Gm-Gg: ASbGnctE0fQKk6BhmjTLjIotJ2ZycWxJyn5DPD9mHRQDfSRT0p7HAcok1jgTu/rXMoN
 g0qS338GcL+g2PCIFZPA1rCY6vYcnO9zoUCWlMNk1+uVGYMUZjXhgzO+LJRsCm8T6/KopBVuUuK
 3pw7sR76quAImG3IG13aUbRFT0N+xhFinQIr0PnYB29Xbb/Qom9vt6MrVf82kE7OeFNrtZLLwTP
 nLI74pPh3DR1ihkdvof3Dip1FWyhI0OS4gZAlfgPPw4TfBY8FPqfkA87NFF0Y67Ma7IBN46hmMg
 Lf5xsTUFTyCh3W9u4Qk6AI7wHA3hqr9UXpVKb48Tq6VBmcFS8JvqNWhOOGxngC9RJgGyKFmc2I6
 aGnR1cSJ04+yoqZtU1vuCSDUhh8U80dMHjRKO//yWiHgzoQ==
X-Received: by 2002:a05:6000:400b:b0:429:bca4:6b44 with SMTP id
 ffacd0b85a97d-429e32cb6c8mr8181896f8f.13.1762444056513; 
 Thu, 06 Nov 2025 07:47:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoWf6QnWSV3o454X8thueDAvDOkcfpC3QtvvBuAqDQXeqLewZP2fZlg92aSx7SgOlHg0xmlA==
X-Received: by 2002:a05:6000:400b:b0:429:bca4:6b44 with SMTP id
 ffacd0b85a97d-429e32cb6c8mr8181866f8f.13.1762444056079; 
 Thu, 06 Nov 2025 07:47:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429eb4772basm6531403f8f.26.2025.11.06.07.47.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Nov 2025 07:47:35 -0800 (PST)
Message-ID: <74f7cf15-beaa-4dd6-b7e6-bb510aa52dd3@redhat.com>
Date: Thu, 6 Nov 2025 16:47:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
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
References: <CH3PR12MB754815B9B902E7EF66B0A1B9ABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <85f315a2-e49a-4330-9419-48a8a3a4a3e3@redhat.com>
 <CH3PR12MB754844745DF256D7FF2CB07AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <e4fd6d1e-3fca-457b-ac6a-69e721d799f4@redhat.com>
 <CH3PR12MB75489F2161213432D34688D2ABC5A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <7ac24d9a-0caf-48cb-832c-812fecc5c82c@redhat.com>
 <20251105181049.GU1537560@nvidia.com> <aQuYZM/8SX+RtDtv@Asurada-Nvidia>
 <20251105185816.GW1537560@nvidia.com>
 <f0c5945d-ec24-4bb9-827c-c3e57abdea36@redhat.com>
 <20251106143217.GA1732817@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251106143217.GA1732817@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 11/6/25 3:32 PM, Jason Gunthorpe wrote:
> On Thu, Nov 06, 2025 at 08:42:31AM +0100, Eric Auger wrote:
>>
>> On 11/5/25 7:58 PM, Jason Gunthorpe wrote:
>>> On Wed, Nov 05, 2025 at 10:33:08AM -0800, Nicolin Chen wrote:
>>>> On Wed, Nov 05, 2025 at 02:10:49PM -0400, Jason Gunthorpe wrote:
>>>>> On Wed, Nov 05, 2025 at 06:25:05PM +0100, Eric Auger wrote:
>>>>>> if the guest doorbell address is wrong because not properly translated,
>>>>>> vgic_msi_to_its() will fail to identify the ITS to inject the MSI in.
>>>>>> See kernel kvm/vgic/vgic-its.c vgic_msi_to_its and
>>>>>> vgic_its_inject_msi
>>>>> Which has been exactly my point to Nicolin. There is no way to
>>>>> "properly translate" the vMSI address in a HW accelerated SMMU
>>>>> emulation.
>>>> Hmm, I still can't connect the dots here. QEMU knows where the
>>>> guest CD table is to get the stage-1 translation table to walk
>>>> through. We could choose to not let it walk through. Yet, why?
>>> You cannot walk any tables in guest memory without fully trapping all
>>> invalidation on all command queues. Like real HW qemu needs to fence
>>> its walks with any concurrent invalidate & sync to ensure it doesn't
>>> walk into a UAF situation.
>> But at the moment we do trap IOTLB invalidates so logically we can still
>> do the translate in that config. The problem you describe will show up
>> with vCMDQ which is not part of this series.
> This is why I said:
>
>>> Thus, the general principle of the HW accelerated vSMMU is that it
>>> NEVER walks any of these guest tables for any reason.
> It would make no sense to add table walking then have to figure out
> how to rip it out.

understood. Though strictly speaking you are not adding it as it is
already there ;-)
>
>> But anyway you need to provide KVM a valid info about the guest doorbell
>> for this latter to setup irqfd gsi routing and also program ITS
>> translation tables. At the moment we have a single vITS in qemu so maybe
>> we can cheat.
> qemu should always know what VITS is linked to a pci device to tell
> kvm whatever it needs, even if there are more than one.
Yeah we can work in that direction instead. But this could be worked on
later on along with vcmdq series as well ;-)

Eric
>
> Jason
>


