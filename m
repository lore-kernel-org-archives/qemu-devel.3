Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A9CC02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 11:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgMFM-0005sf-8p; Fri, 07 Feb 2025 06:10:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tgMFK-0005qJ-Hs
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 06:10:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tgMFI-0003K8-TD
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 06:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738926603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vb2bbZYfMJmk7CtnqEzHJQalG3GcWGX7WKXDfRplJsQ=;
 b=IFfraZHkAPqe9UX/QyDdpz4rpSCdGRtykU/CbJyZZBGrT0CNcwId1+KkUKGNxW3vDSVE1K
 ZF/XnlKvq+F//7U9SwvOyleK8jq4ouOgxeTjeXtIiLNpTenssJTczJthLcFX0/wETEv8Mz
 8HocNtxd9WaLwL8Z8aXre0DgA3npNVg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-T9FsCAE5MQq377Be9sRNMw-1; Fri, 07 Feb 2025 06:10:02 -0500
X-MC-Unique: T9FsCAE5MQq377Be9sRNMw-1
X-Mimecast-MFC-AGG-ID: T9FsCAE5MQq377Be9sRNMw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4361fc2b2d6so11946935e9.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 03:10:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738926601; x=1739531401;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vb2bbZYfMJmk7CtnqEzHJQalG3GcWGX7WKXDfRplJsQ=;
 b=HbZZX+WkAaH/+iIv7rILs75HQKyACxO97VYIl7JVI6n7du4UI7KQomV+pdgoeWCVZW
 Ut+CEEv4vVUG55lSfHyvbhIMHAUcW90WOpI2iGvW4gNPnuGAir4YAWKy5S3lB/7JzP0P
 2c5GFp7Zw4ZqNIMNSYC2NYwaFPqAvYfWHFLl9ouxnM4xxXgwc3hVBWQYiYWYaPbzLJqX
 aZek695TgrtNbMN4OpdL5faUMyLwivLL8W8IOR4oOSpIqzcViXVzL8/zPQiQ14Rnf5yB
 DgRq3cFCXD6+mzFZKH5DYEGJ/9M9pUqDSbJat/xXbcOdQaVHs2qAhv7qZav0KQfLnRdZ
 UkQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqbD6Pnd1bkTArH7Tz4mRqZspZ+GMQ5U0CHOPmrKR7zxbXOPW+MDmJMmLoKsI0sz+n0bOX0qL0GRV2@nongnu.org
X-Gm-Message-State: AOJu0Yy8OgGonSrJX1e9AZudnQu94Tt5LR9b4wEDlPnR9XylY+YA6tv8
 rFb6DtOPPDpa4Pph+mx9x9HHlPf3BswZCdX6t04pWbYCoeFvQjKGD/IwY7/Buy5XqoMMz5HnIxZ
 17BnekNDnMgrhZ5p5EolUfT3TxpwNRtGSTD7M2hP7WA/bGi0mxil1
X-Gm-Gg: ASbGnctVfnR927ncTJDku9V5BxCRYjy6rCrN4PaA8Q2ronVG+AvM3SAshuFktKyK+9J
 ZEk1MIn9ka614tqiLrSZUoAssrIvGTImDJscDtw8NxBEeJkKb4f3QzRnUoxRhO+nvYrMnDxyD8W
 PMnPhLGbEXfDgIR0dn5VdgUyJnOc/O0fPyqIDvpWOt4Wr1HYySWmDIgUkDhZp3RgB7+NL+4XMhm
 yVbcafcVGb00Q0m/OkR5fVck/xnYyRe7DjBKUv2rKaKQi0NDoLwzSlaXJZm9OdDsZzzGRa2MQ==
X-Received: by 2002:a05:600c:1c07:b0:434:ff9d:a3a1 with SMTP id
 5b1f17b1804b1-4392497d81bmr23565515e9.2.1738926601085; 
 Fri, 07 Feb 2025 03:10:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTqk4El86IuGz5jnQONTuXlUM1nyXKtItvC28d8R//wR3DoX7EE5ekdiE7DNjFjO/OKVNI+Q==
X-Received: by 2002:a05:600c:1c07:b0:434:ff9d:a3a1 with SMTP id
 5b1f17b1804b1-4392497d81bmr23565295e9.2.1738926600706; 
 Fri, 07 Feb 2025 03:10:00 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:610a:fb15:126:1857:dec9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde0fe37sm4248023f8f.69.2025.02.07.03.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 03:09:59 -0800 (PST)
Date: Fri, 7 Feb 2025 06:09:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, jasowang@redhat.com, imammedo@redhat.com,
 peterx@redhat.com, alex.williamson@redhat.com, clg@redhat.com,
 philmd@linaro.org, zhenzhong.duan@intel.com, ddutile@redhat.com
Subject: Re: [PATCH 0/5] Fix vIOMMU reset order
Message-ID: <20250207060822-mutt-send-email-mst@kernel.org>
References: <20250206142307.921070-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206142307.921070-1-eric.auger@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Feb 06, 2025 at 03:21:51PM +0100, Eric Auger wrote:
> This is a follow-up of Peter's attempt to fix the fact that
> vIOMMUs are likely to be reset before the device they protect:
> 
> [PATCH 0/4] intel_iommu: Reset vIOMMU after all the rest of devices
> https://lore.kernel.org/all/20240117091559.144730-1-peterx@redhat.com/
> 
> This is especially observed with virtio devices when a qmp system_reset
> command is sent but also with VFIO devices.
> 
> This series puts the vIOMMU reset in the 3-phase exit callback.
> 
> This scheme was tested successful with virtio-devices and some
> VFIO devices. Nevertheless not all the topologies have been
> tested yet.
> 
> Best Regards
> 
> Eric



Looks good.


Acked-by: Michael S. Tsirkin <mst@redhat.com>

How should this be merged?
I supposed I can merge the 1st three and the other
two by the respective maintainers?
I don't think there's a dependency here, right?

> This series can be found at:
> https://github.com/eauger/qemu/tree/viommu-3phase-reset-v1
> 
> Eric Auger (4):
>   hw/virtio/virtio-iommu: Migrate to 3-phase reset
>   hw/i386/intel-iommu: Migrate to 3-phase reset
>   hw/arm/smmuv3: Move reset to exit phase
>   hw/vfio/common: Add a trace point in vfio_reset_handler
> 
> Peter Xu (1):
>   hw/i386/intel_iommu: Tear down address spaces before IOMMU reset
> 
>  hw/arm/smmuv3.c          |  9 +++++----
>  hw/i386/intel_iommu.c    | 10 ++++++----
>  hw/vfio/common.c         |  1 +
>  hw/virtio/virtio-iommu.c |  9 +++++----
>  hw/arm/trace-events      |  1 +
>  hw/i386/trace-events     |  1 +
>  hw/vfio/trace-events     |  1 +
>  hw/virtio/trace-events   |  2 +-
>  8 files changed, 21 insertions(+), 13 deletions(-)
> 
> -- 
> 2.47.1


