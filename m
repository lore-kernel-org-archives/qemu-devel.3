Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0187C5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 13:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siwSE-0006c0-5l; Tue, 27 Aug 2024 09:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1siwS3-0006as-EA
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 09:41:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1siwS0-0007sb-Qm
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 09:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724766095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D8ucD9Np+fs68lD48TK9xsO6XjNMEO+/tHvmCl6YssM=;
 b=JHq7g6prczBv9pZ6mo3J3+ncSToJDhaRmVXPhkcoZmWVCtw8zuuCZK/nsMstzuvFXVa0Ba
 MB9WP5Z8Sttatkzq8UNjspP/G/+GZbwNxPJf9Zs6vZGuMZaddaa4JUVmEu6KG8YwIpetDO
 S7RrBOWExk5C4eEh/ye8qNsCflx6CkU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-n4P_COPNPr6EGUnHYAPjTQ-1; Tue, 27 Aug 2024 09:41:33 -0400
X-MC-Unique: n4P_COPNPr6EGUnHYAPjTQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7a1df704ef8so691296085a.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 06:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724766093; x=1725370893;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D8ucD9Np+fs68lD48TK9xsO6XjNMEO+/tHvmCl6YssM=;
 b=pgW94xkdDEQQXRJkS2GwNb6FiFMejI1cgEgi/BOxuGqiU/tBojNbxJU2pwpcvKi+Hb
 0qe2Cok9aodrYjOSI2iMDAXkYMYUmw5NnDg5y/MdZmGgxdxVzTzSVmL2d5DMjZMaqGD6
 os4MCnFlF0wdGgE70FU9PVmGvZMuP9VZX7DyQ08S3DLZsq5v1RkyuBH3Rw6Yiav0F86T
 KfosanDC8Y7Fe0SlrmpdaXiZLF5V/DLUx7r9pTUBBx/2jyI0ty3bzYGE+nf80Rwew48D
 znby8r8dRKKl1ZQI+ETpuokhOPYzix8quW4Sj8WSUWR2PfSFHn4u6IcKQRfEjbwdh0gt
 v9CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/uJbvZj+dmrwLw38b1/uo9wMUUSTZWf3NMPTTLgm/sOSdaye1nW5YFLxQgSDcyR9yV1buvigSRCGm@nongnu.org
X-Gm-Message-State: AOJu0YzFYlmsT9+yJj/A8w8YApDZ8ASNGAIrfaWcvntcs4+p68rInc0j
 q5witKh141reyit4hD/Lk2m2uoYurC/30h85ssy6SQnIJK5VOhTRufMomxV7keYLp/YopZsEDbc
 0aDIupn4e3q5mpbdy7LP6kE+ubTdeuLgAk73WPz36nyywi8dSRqVf
X-Received: by 2002:a05:620a:1989:b0:79f:af4:66f1 with SMTP id
 af79cd13be357-7a6897a2cf8mr1524271885a.50.1724766093208; 
 Tue, 27 Aug 2024 06:41:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJNcipyktfXFq+FmmRJMcJ9UH3akgetAr8yqObogGxUvBVxytvZMeh1wSsj/rYbWnTd2AWgw==
X-Received: by 2002:a05:620a:1989:b0:79f:af4:66f1 with SMTP id
 af79cd13be357-7a6897a2cf8mr1524269385a.50.1724766092717; 
 Tue, 27 Aug 2024 06:41:32 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.135.14])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f318e37sm552522485a.22.2024.08.27.06.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 06:41:32 -0700 (PDT)
Date: Tue, 27 Aug 2024 15:41:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Gao Shiyuan <gaoshiyuan@baidu.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, zuoboqun@baidu.com, qemu-devel@nongnu.org
Subject: Re: [PATCH V2 1/1] virtio-pci: Add lookup subregion of
 VirtIOPCIRegion MR
Message-ID: <qrb7lbdypu2ctim57dxn7copcbmclpxnb4k2uadnm5v6ehawwc@xzhkhvs46xhw>
References: <20240820115631.52522-1-gaoshiyuan@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240820115631.52522-1-gaoshiyuan@baidu.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Aug 20, 2024 at 07:56:31PM GMT, Gao Shiyuan wrote:
>When VHOST_USER_PROTOCOL_F_HOST_NOTIFIER feature negotiated and
>virtio_queue_set_host_notifier_mr success on system blk
>device's queue, the VM can't load MBR if the notify region's
>address above 4GB.
>
>Assign the address of notify region in the modern bar above 4G, the vp_notify
>in SeaBIOS will use PCI Cfg Capability to write notify region. This will trap
>into QEMU and be handled by the host bridge when we don't enable mmconfig.
>QEMU will call virtio_write_config and since it writes to the BAR region
>through the PCI Cfg Capability, it will call virtio_address_space_write.
>
>virtio_queue_set_host_notifier_mr add host notifier subregion of notify region
>MR, QEMU need write the mmap address instead of eventfd notify the hardware
>accelerator at the vhost-user backend. So virtio_address_space_lookup in
>virtio_address_space_write need return a host-notifier subregion of notify MR
>instead of notify MR.
>
>Add lookup subregion of VirtIOPCIRegion MR instead of only lookup container MR.
>
>Fixes: a93c8d8 ("virtio-pci: Replace modern_as with direct access to modern_bar")
>
>Co-developed-by: Zuo Boqun <zuoboqun@baidu.com>
>Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
>Signed-off-by: Zuo Boqun <zuoboqun@baidu.com>
>---
> hw/virtio/virtio-pci.c | 14 ++++++++++++--
> 1 file changed, 12 insertions(+), 2 deletions(-)
>
>---
>v1 -> v2:
>* modify commit message
>* replace direct iteration over subregions with memory_region_find.
>
>diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>index 9534730bba..5d2d27a6a3 100644
>--- a/hw/virtio/virtio-pci.c
>+++ b/hw/virtio/virtio-pci.c
>@@ -610,19 +610,29 @@ static MemoryRegion *virtio_address_space_lookup(VirtIOPCIProxy *proxy,
> {
>     int i;
>     VirtIOPCIRegion *reg;
>+    MemoryRegion *mr = NULL;

`mr` looks unused.

>+    MemoryRegionSection mrs;

Please, can you move this declaration in the inner block where it's 
used?

>
>     for (i = 0; i < ARRAY_SIZE(proxy->regs); ++i) {
>         reg = &proxy->regs[i];
>         if (*off >= reg->offset &&
>             *off + len <= reg->offset + reg->size) {
>-            *off -= reg->offset;
>-            return &reg->mr;
>+            mrs = memory_region_find(&reg->mr, *off - reg->offset, 
>len);
>+            if (!mrs.mr) {
>+                error_report("Failed to find memory region for address"
>+                             "0x%" PRIx64 "", *off);
>+                return NULL;
>+            }
>+            *off = mrs.offset_within_region;
>+            memory_region_unref(mrs.mr);
>+            return mrs.mr;
>         }
>     }
>
>     return NULL;
> }
>
>+

Unrelated change.

Thanks,
Stefano

> /* Below are generic functions to do memcpy from/to an address space,
>  * without byteswaps, with input validation.
>  *
>-- 
>2.39.3 (Apple Git-146)
>


