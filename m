Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451C9D743D8
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 21:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDs2U-0000HU-Ip; Wed, 20 Nov 2024 16:15:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1tDs2T-0000H1-7S
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 16:15:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1tDs2R-0004qO-NH
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 16:15:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732137301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vM0gNuk6NgkYQ1uz3u95XWEGU7nhPszOJ4XF9ZuwBN4=;
 b=L0FugTHPBWdhdcfSrZGZ9EZSLKw3fglHb+9exH4qbRpyBu8lx5hZakxm9ks31pWksUsoko
 ht45R1XFG+H0Pu4e6mfZ3tiNVx/txa1D8QhMY1cgRAF7aXax38yUC92cuNsfgetOsZOfP9
 8U+CZlWpjuWzAFoT/5WqHVhFJrYEOLw=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-thqgvX5cMKCJEjERK2BiyA-1; Wed, 20 Nov 2024 16:13:50 -0500
X-MC-Unique: thqgvX5cMKCJEjERK2BiyA-1
X-Mimecast-MFC-AGG-ID: thqgvX5cMKCJEjERK2BiyA
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-e02fff66a83so259527276.0
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 13:13:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732137230; x=1732742030;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vM0gNuk6NgkYQ1uz3u95XWEGU7nhPszOJ4XF9ZuwBN4=;
 b=fOO/jbAsqCZgcqhAAWHX+wwBC8+/9LHHlbgW8TPnMY6vwxuh1ijUB3Gjh190Pe5XYd
 w+B7P80Vx52Krs6ugmOfBdeHvgBZGcPibqVh67jc+pDyEM2KBiyJ+Wk7qEtqxvZOXdE+
 jio7jr/MYdieP6LNzJVx9B8x2+JWgkPtU3DTDW22GPdf7UcNwxHciAiV/+2gUJMIoi0N
 YA+fXy8xqlgYk3Cjvp5SgOLFMYQBuOnjBtkLhUxqXwK9paovbbqzYM7oKqijqZXQcokY
 AgfXoK7G0S3PsS2bCb28Vw5zHr0FHYcAAWYKOpOR8Lxt74hWdQgTkKOOas8Po5ptsjBl
 WnEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXblF5D3fJfvURGKwupmHNsjna9gd+ciKjkmcpCc8aqVJvE4sXxOcdhxS0jDs6IXFCl/V2013r5G5Lq@nongnu.org
X-Gm-Message-State: AOJu0Yy9vMQgO86CnInpyd+zPS9fYllT/TLRm7owUvQN7vCKU3xgosXK
 6hxEVa71WFC0rEB3CxaN02/psIjJX8Ey6o0zRFbwNy21/D+gz/kdUutb+j2jScqNmCTp0ujGby2
 Yg0S9XcG+5vFVsRjcwpT63M7TUx0eHODToBniK4SlarawEe6NYqIj1WwPWL32140pt12XOBYzB+
 a7t/u7uuer+Qhr5X2qOy1DvFQKSIs=
X-Received: by 2002:a05:6902:18c2:b0:e29:1099:9047 with SMTP id
 3f1490d57ef6-e38cb544269mr3918904276.11.1732137229874; 
 Wed, 20 Nov 2024 13:13:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbcjQg8BzgwyiZb4D0hdawsCtFukb2QzFRMvlTtSkI74W4mXY4BN/SytJtQyWS9AKa1XD7mAOLdHaPZtiHx/A=
X-Received: by 2002:a05:6902:18c2:b0:e29:1099:9047 with SMTP id
 3f1490d57ef6-e38cb544269mr3918879276.11.1732137229613; Wed, 20 Nov 2024
 13:13:49 -0800 (PST)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Nov 2024 21:13:47 +0000
From: Andrea Bolognani <abologna@redhat.com>
References: <ZyRUcGKKS6NbIV5O@Asurada-Nvidia>
 <cf4359b18f0d44f09b8901141b678a09@huawei.com>
MIME-Version: 1.0
In-Reply-To: <cf4359b18f0d44f09b8901141b678a09@huawei.com>
Date: Wed, 20 Nov 2024 21:13:47 +0000
Message-ID: <CABJz62M9-mtwd4dvCc=8LEJHGMnUn4zQDS8-ocTfxZ=Y3i1q-g@mail.gmail.com>
Subject: Re: nested-smmuv3 topic for QEMU/libvirt, Nov 2024
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>, 
 Mostafa Saleh <smostafa@google.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Jason Gunthorpe <jgg@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Moritz Fischer <mdf@kernel.org>, Michael Shavit <mshavit@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Zhangfei Gao <zhangfei.gao@linaro.org>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>, 
 "arighi@nvidia.com" <arighi@nvidia.com>, "ianm@nvidia.com" <ianm@nvidia.com>,
 "jan@nvidia.com" <jan@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Fri, Nov 01, 2024 at 06:35:23PM +0000, Shameerali Kolothum Thodi wrote:
> I have a bare minimum prototype code that works with a pluggable smmuv3.
>
> ...
> -device pxb-pcie,id=pcie.1,bus_nr=2,bus=pcie.0 \
> -device pcie-root-port,id=pcie.port1,bus=pcie.1 \
> -device arm-smmuv3-nested,id=smmuv1,pci-bus=pcie.1 \
> -device vfio-pci-nohotplug,host=0000:75:00.1,bus=pcie.port1,iommufd=iommufd0 \
> -device pxb-pcie,id=pcie.2,bus_nr=8,bus=pcie.0 \
> -device pcie-root-port,id=pcie.port2,bus=pcie.2,chassis=8 \
> -device arm-smmuv3-nested,id=smmuv2,pci-bus=pcie.2 \
> -device vfio-pci-nohotplug,host=0000:7d:02.1,bus=pcie.port2,iommufd=iommufd0 \

Silly bit of feedback on the interface, but why is the
arm-smmuv3-nested property called "pci-bus" instead of just "bus"?

All other devices that need to refer to an existing PCI bus use the
latter. Is there a reason for this specific one to diverge?

-- 
Andrea Bolognani / Red Hat / Virtualization


