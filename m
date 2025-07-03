Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D8EC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 06:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXDCb-00059V-M6; Thu, 03 Jul 2025 02:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXDCZ-00058a-TB
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 02:13:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXDCY-0007jr-Ck
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 02:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751523221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PT72OHOwbvj4w+FCM5nlePBTAKoc1DrxxSmkZ1u22Uc=;
 b=d2fu+junDWBNuKxXVjfs5BtOYm51ALpgJal7EfFYrlAjd+dVDdt/s6ksGgHLgKk7Tobvc6
 mg7sA8hkXlxeumjHOL3Nsi5Ig9loIAwTSqrmpusC7siNX0KSuNJpJlo7Jvcq10dLVsW9tA
 hJYv+vJIDsyUqNySujQtE8i4um5nJAY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-A8k_5ZiPM_aSoK9i5eOkJA-1; Thu, 03 Jul 2025 02:13:39 -0400
X-MC-Unique: A8k_5ZiPM_aSoK9i5eOkJA-1
X-Mimecast-MFC-AGG-ID: A8k_5ZiPM_aSoK9i5eOkJA_1751523219
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3b20f50da27so289023f8f.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 23:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751523219; x=1752128019;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PT72OHOwbvj4w+FCM5nlePBTAKoc1DrxxSmkZ1u22Uc=;
 b=eXvN4FGxchiqMC2ktaHWLSZ2nmzPiiirg3kQ/LaurjxPYJM4Sie4ZlKlxSRnNdd0Z/
 33HDVfQx2dpMj4ybVppPlDkD2Cq5ekdoAFWN+kDqomJf7gzCsly/cqqsjen053GGWY/Z
 WwWR18Or80f2sh2zTZTWFNqsP/tELqKikB+ZHxkz3Zdq/sNVgl6fnIyq47EVY/ktlFQi
 ODlG+mnQou8lRXouMPoSTQvx7jEb7fPFnx1EsNqaKJkf+B1WATdW6Sj93wOBtBYU573b
 Bt6o8B4cOeW/e6txa8oRqYbRDEnoOQJ8wCZAVZ/Okgzcf17S/8o6EoGixaDzZkISrFt9
 XR7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiwAGSBtlZKKoGfCZWNKg80bZaNh+OOxQLvYs5/OTbu53YplPS+q/uEOipSYS/AEx/72TsRYSRXaB/@nongnu.org
X-Gm-Message-State: AOJu0YxTj5LkpO/7d6Ndg7qXoHq0hV8TbHucZSCCupfK1/F3mrt3maxI
 A2rdAEk4j+6PZAqDGGqiZuQWooqAQhAPaMjMBaBcjKGBWW6SBDMQ6BiqO9HNLQn/zNwsNZGz8Bv
 1Qqk/vmtefwoBje4Va18Wqfc/ddFP8ptDy61GrcOF+okAU6cmJVeegku0
X-Gm-Gg: ASbGncuuf3dI3QqPb4K+EGAQswWjcuO4sw/qKI/8jxWH7RM9z1JDp53zJqQhGT5lM6s
 zp3s1p1ynNGkE69b6GYRokWLpFVZtVdMFQlN80zWljUlX5PfB5BhgIRFY677DRLqQYqyapdLNRZ
 Gjbz7IVQeJvncmrABtYFsymUcolc+gL8AriNbQFKRwc8EKLpgdwgQUrTPhUeKxq9E7lrXpHEh4u
 Y07F5PCV9aMXUV1X3AnGQ9Z/BlJuNloLjPWEFKrruDbbaepKpvbKbVKeNGoP5AS2/krkfj6wPdQ
 jVSWxBDp0FZ4IPxrOtDd8gFXruobPyd2FZUF34jty4YFGh1ydGh+T+yldoIC
X-Received: by 2002:a05:6000:188b:b0:3a4:f70d:aff0 with SMTP id
 ffacd0b85a97d-3b344322dd8mr1230916f8f.14.1751523218684; 
 Wed, 02 Jul 2025 23:13:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv3pq31bodQlb9Ed+ZC4A5hbG/CGdZguA+QnFSvF6niJhMTmDZe7GAQSAyIj3VFDPSBkZNXQ==
X-Received: by 2002:a05:6000:188b:b0:3a4:f70d:aff0 with SMTP id
 ffacd0b85a97d-3b344322dd8mr1230888f8f.14.1751523218259; 
 Wed, 02 Jul 2025 23:13:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bcf35csm16482185e9.20.2025.07.02.23.13.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 23:13:37 -0700 (PDT)
Message-ID: <719375c6-3c40-4862-bd5a-504ee00f5503@redhat.com>
Date: Thu, 3 Jul 2025 08:13:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 02/21] vfio-pci: preserve INTx
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
 <1751493538-202042-3-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1751493538-202042-3-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/2/25 23:58, Steve Sistare wrote:
> Preserve vfio INTx state across cpr-transfer.  Preserve VFIOINTx fields as
> follows:
>    pin : Recover this from the vfio config in kernel space
>    interrupt : Preserve its eventfd descriptor across exec.
>    unmask : Ditto
>    route.irq : This could perhaps be recovered in vfio_pci_post_load by
>      calling pci_device_route_intx_to_irq(pin), whose implementation reads
>      config space for a bridge device such as ich9.  However, there is no
>      guarantee that the bridge vmstate is read before vfio vmstate.  Rather
>      than fiddling with MigrationPriority for vmstate handlers, explicitly
>      save route.irq in vfio vmstate.
>    pending : save in vfio vmstate.
>    mmap_timeout, mmap_timer : Re-initialize
>    bool kvm_accel : Re-initialize
> 
> In vfio_realize, defer calling vfio_intx_enable until the vmstate
> is available, in vfio_pci_post_load.  Modify vfio_intx_enable and
> vfio_intx_kvm_enable to skip vfio initialization, but still perform
> kvm initialization.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/cpr.c | 27 ++++++++++++++++++++++++++-
>   hw/vfio/pci.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>   2 files changed, 79 insertions(+), 3 deletions(-)


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



