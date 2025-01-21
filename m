Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1256C02185
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 08:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta9tU-0002rZ-L4; Tue, 21 Jan 2025 03:45:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1ta9tA-0002n8-Ik
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 03:45:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1ta9t7-0004Z3-EB
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 03:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737449131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M0yM/iyV2dTCVPhnXXI5h8JH5ZH080qjdmtvRJtHf28=;
 b=FgN4bPjv4mIRUYpwZ6wmhJdLIo9Kyr4KcG+XfzMd8+ZFYBPZd20riCqpsSIa9ozYIp4nCP
 eIvnrVQ005rsBoCFzrHr8mc6xpIEohRKpF3keHNGNqbKUpSu+DTsrQHMOAwo/ZU/vlQ6QA
 nUjYCvX8/2Nb3inlN/1Eu0nRjoHZ3Zo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-U8sVgSZPNJek6KVLNMsqXA-1; Tue, 21 Jan 2025 03:45:29 -0500
X-MC-Unique: U8sVgSZPNJek6KVLNMsqXA-1
X-Mimecast-MFC-AGG-ID: U8sVgSZPNJek6KVLNMsqXA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43673af80a6so41648905e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 00:45:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737449128; x=1738053928;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M0yM/iyV2dTCVPhnXXI5h8JH5ZH080qjdmtvRJtHf28=;
 b=v0FgYi8NEeB2CZKkgf8WLCZMOEXiROV1rjxw9saPyZWCEXJX5HJgRsMm8iZ9FrFPNK
 DV9j/MEa1fKN8mwKwqizX8w0Eyl1p1D9LVuWzihtvnizmlkda807ObAs7EwnnciVnTeq
 7hq1ytBh4CxlEgB4xT8o/mvUiKZT/c+Dz21xdTwJizWAGZOBShwDgZ/YV3z8gndrOHf5
 PZlE+mBhQinf/2LjYhfLDYe7pKUaEXU8Oihi+8j2SILUfMy3cbtX8CJZxfLFZ/G5w4D/
 6F4FsYVeh8N7o/hrSQAPLfylQv0avc8d3Mx7UknF5aPY3PoPrbLOI/jy1YlG34xrRbdo
 dDMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF2wo3w3gP1SwcH/APKYXuVd4DaVQ7AA3p9AEQ/0ZuN7JVw/yngrXf68BCcL5ltaIaEDoPey9HVqOH@nongnu.org
X-Gm-Message-State: AOJu0YzlBLvEzRl8u76ghWvd+b52MxVbv1V36dg7VCcKyhWI8iCTRKvT
 I3YQC6D5rshe3YmH2XYUnz0wMQda9lkhs3hom0kTlEnR/xT7TUaLvdRUxLPHNXNLfkMAuR8xboc
 2HLftcZjakmuUknJ4N70WirbEOLgE4csaMNdp+0kAGk8Ln8RGzUWj+ZQj2S9T
X-Gm-Gg: ASbGncsXtwMWNPGIhL5Knt/AvQD+uFSWTtMrcfg04NQJecvz+W9CxXxgKgUYI3QBTNH
 Ojb2Ozptx+g46sMNFqbLn1Ceu2Y/gW4UGz4VpW3K/3GP5jqwvmoQgwGdV4PNYsZsbYbfZQ3CA3n
 cZsYTD9jZd0vLcxCXTqrCf27UxnI8GzYkTEZnjdnlMJxWPRK12jldDyvNxoXJzPtE4zFYCdv7Hk
 OxvhM1oarYfXz0C+dPmfK37m03LPCspScl8VE0lbZ0fqW4wU7vFOuvrXkok5li+fMlqTtxi/q1z
 7IbXSSmu2niTWDaPjKxIps8r+IAAJeTfmSk5x/pBn6pLlQ==
X-Received: by 2002:a7b:c3da:0:b0:438:a20b:6a62 with SMTP id
 5b1f17b1804b1-438a20b6d62mr87913125e9.28.1737449128275; 
 Tue, 21 Jan 2025 00:45:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIfveKR9uqmIVjlD2bnXjWFi/WuhGeZT6eEJaKMn18vm2O9s8GHf7XCAnW07M1nAqG9rD/Sw==
X-Received: by 2002:a7b:c3da:0:b0:438:a20b:6a62 with SMTP id
 5b1f17b1804b1-438a20b6d62mr87912685e9.28.1737449127521; 
 Tue, 21 Jan 2025 00:45:27 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-100.retail.telecomitalia.it.
 [82.53.134.100]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438904087cbsm174656915e9.3.2025.01.21.00.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 00:45:27 -0800 (PST)
Date: Tue, 21 Jan 2025 09:45:21 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, 
 qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 zhenzhong.duan@intel.com
Subject: Re: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
Message-ID: <tuzwgcjnxyz5sw2xjo4nyyl3xw3b7j5xqk67hsi5xk4xj3tv3a@hmmydeoupl35>
References: <20250120173339.865681-1-eric.auger@redhat.com>
 <3aaaf5c8-b1f0-4237-b50e-bb28fd297bb1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3aaaf5c8-b1f0-4237-b50e-bb28fd297bb1@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.036,
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

On Tue, Jan 21, 2025 at 09:31:53AM +0100, Laurent Vivier wrote:
>On 20/01/2025 18:33, Eric Auger wrote:
>>When a guest exposed with a vhost device and protected by an
>>intel IOMMU gets rebooted, we sometimes observe a spurious warning:
>>
>>Fail to lookup the translated address ffffe000
>>
>>We observe that the IOMMU gets disabled through a write to the global
>>command register (CMAR_GCMD.TE) before the vhost device gets stopped.
>>When this warning happens it can be observed an inflight IOTLB
>>miss occurs after the IOMMU disable and before the vhost stop. In
>>that case a flat translation occurs and the check in
>>vhost_memory_region_lookup() fails.
>>
>>Let's disable the IOTLB callbacks when all IOMMU MRs have been
>>unregistered.
>>
>>Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>---
>>  hw/virtio/vhost.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>index 6aa72fd434..128c2ab094 100644
>>--- a/hw/virtio/vhost.c
>>+++ b/hw/virtio/vhost.c
>>@@ -931,6 +931,10 @@ static void vhost_iommu_region_del(MemoryListener *listener,
>>              break;
>>          }
>>      }
>>+    if (QLIST_EMPTY(&dev->iommu_list) &&
>>+        dev->vhost_ops->vhost_set_iotlb_callback) {
>>+        dev->vhost_ops->vhost_set_iotlb_callback(dev, false);
>>+    }
>>  }
>>  void vhost_toggle_device_iotlb(VirtIODevice *vdev)
>
>I think you need the counterpart in vhost_iommu_region_del() (for 

I guess you meant vhost_iommu_region_add(). I was going to comment 
exactly on that, I agree here.

>instance if we have an add after a del that results in an empty list).
>But you cannot unconditionally enable it (for instance if vhost is not 
>started)

Good point.

>
>Perhaps you should move the vhost_set_iotlb_callback() call from 
>vhost_start()/vhost_stop() to 
>vhost_iommu_region_add()/vhost_iommu_region_del()?

I also like this idea.

Stefano


