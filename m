Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250FFD690E4
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 08:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGZY6-0002QW-7I; Thu, 28 Nov 2024 03:06:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tGZY4-0002QN-Lk
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 03:06:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tGZY1-0007Mt-E6
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 03:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732781202;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CVe9xOy+MPsbZXEGhxNCaDYnl7LRyUwGHDKkf1tEUFk=;
 b=WzTkaIPdtThpA/ysOa2CDf8zGgzGTjnq3OgCbuhWafBvdgOPJXLCL3Qdrss2oLpaupSjkY
 Vj9/UInyLEadtVg+LwYDmYAtv4UWLutfgmzlWLDw/rgIrzgfgeChujcvvQonG1TLJAGuIX
 v/X0vzpyssukZdzvLqB61/RaWDyXTQ8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-M3qEqDJsPea7w2TxOkQgEA-1; Thu, 28 Nov 2024 03:06:40 -0500
X-MC-Unique: M3qEqDJsPea7w2TxOkQgEA-1
X-Mimecast-MFC-AGG-ID: M3qEqDJsPea7w2TxOkQgEA
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b679c38460so76505485a.2
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 00:06:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732781200; x=1733386000;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CVe9xOy+MPsbZXEGhxNCaDYnl7LRyUwGHDKkf1tEUFk=;
 b=nGgsSkZY/hpyxNQKL4gl1n7ZU4tln19C59zQwIbKNXbHZm0+mDKP332hRvNsQXmzaR
 h4MKCWnXj4H6sX3DJPnRtgP8J8u5Cufd4orOdMk1d99KH+q7zoY1/2h8N69Qh2lcTQ/o
 CtyjkrBQMsHR4Rl+b8ptQg0B4UHzcmprqoZ1OgE2jXxLBHkvrsUFrKsgELWwKtTmQzkb
 FriXfXBbM6Xg8r5++N5WjvUe89vUDn+j/M7DrC7C4M9EzQYsHVGhW0z9ciAGq4NDlusf
 XojcR7UFtJo1++hkH9xPW2Xb48M+fhnIGsbOfOFoAxvD7caI7mBwXgf9JIPwvK9fjxdZ
 H6UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7K8aphBk5ILs4BpQE9NQK3CUWGgpbx3eyvzracWjrDYeRfSwYVHBrPUVwwFVo7f9wkX/uOU9Yg7OH@nongnu.org
X-Gm-Message-State: AOJu0YwNe66Ixn9nfBl3ZywqA3euid5IZ0GMHGmhj14GbXTDNoSR3akC
 kt42EeO0Kz9iSVyZgjdA89D39xXtqMtDNu5EKpIFYOSQ9ipvLA/m3p/1757GOIYKAeKZLGTMrZR
 TktR2xKVe7UmEn9JLvxqQheZsshN/28RS6b5gD7NcCqU7tOVLEnPz
X-Gm-Gg: ASbGncvbTAVLTUpzpaHNUD1F3vtBlfyF/G3VpYOaxBQ7F05LwCqnkzYe3kio8jQG7bt
 Npmeer1np+Efi8Va0elVMtC4HzN98Zl4xyU3+Nryxz0JvdPZUQwstdjkB3xlUZEkSpzzLXLak6F
 BlF1XBPmx0CiuEv9fCt2H7u/pNyM4hgauDopKjKh7F9ZS46GLUD+ZClBw+Z1pZAw4prYlIV2+t2
 NIrqAs7Pq6kxuBTMp8bHmXq6PPFbwpB9l/bR0gb8rMwmH+k0rrRIHKWMIut4rt0d2XqyS8W6rm7
 CjPfz3PK92gJQSaT/MFydg==
X-Received: by 2002:a05:620a:4049:b0:7b0:6e8:94ef with SMTP id
 af79cd13be357-7b67c0d672dmr859034985a.0.1732781199983; 
 Thu, 28 Nov 2024 00:06:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+e50gVHuHZ+HUDWP+LufVP/FNm3ISPbGkk9uTYge5NlNyBpKlb5GHhalKNGHKoT67rpGZbQ==
X-Received: by 2002:a05:620a:4049:b0:7b0:6e8:94ef with SMTP id
 af79cd13be357-7b67c0d672dmr859032685a.0.1732781199708; 
 Thu, 28 Nov 2024 00:06:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6849b87d6sm36627585a.98.2024.11.28.00.06.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 00:06:38 -0800 (PST)
Message-ID: <05470fe6-4336-455a-8b30-e05fb273aa25@redhat.com>
Date: Thu, 28 Nov 2024 09:06:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] hw/arm/smmuv3: Add initial support for SMMUv3
 Nested device
Content-Language: en-US
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Donald Dutile <ddutile@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-3-shameerali.kolothum.thodi@huawei.com>
 <00e8a5d6-c926-44bb-8d11-dab4ddc4820d@redhat.com>
 <ZzTqXCFKV9s++C2N@Asurada-Nvidia>
 <cfe8864c-f830-4b39-b4d5-f219f5a42eea@redhat.com>
 <d8fbaa677771425dac985438b4b1db59@huawei.com>
 <20241127160031.GA1253388@nvidia.com>
 <bd4c4665-148c-427b-8717-457c584fb233@redhat.com>
 <CABQgh9ErT6BmvbrUr_aNiLFws2Kx-=NzGJJCo+vV7AV_U6Pk9g@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CABQgh9ErT6BmvbrUr_aNiLFws2Kx-=NzGJJCo+vV7AV_U6Pk9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 11/28/24 04:25, Zhangfei Gao wrote:
> Hi, Eric
>
> On Thu, 28 Nov 2024 at 00:06, Eric Auger <eric.auger@redhat.com> wrote:
>
>>> Yeah, there is no live migration support yet in the SMMU qmeu driver,
>>> AFAIK?
>> the non accelerated SMMU QEMU device does support migration.
> Could you clarify more about this?
> The migration is not supported if using viommu (SMMU QEMU device), isn't it?
No this is not correct. Current QEMU SMMU device *does* support
migration (see VMStateDescription) as well as qemu virtio-iommu device.
so for instance if you run a guest with smmuv3 and protected virtio-pci
devices this is supposed to be migratable. If it does not work this is
bug and this should be fixed ;-)

Thanks

Eric
>
> Thanks
>


