Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18AAEE49B7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 14:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOKB-0000H5-4X; Wed, 11 Sep 2024 10:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOJP-00076Y-HO
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:27:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOJN-0003NH-0g
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726064832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7SP0llBIv1hTkxB2e1G9eZTNJY30OOtKHAC0GZkH5pk=;
 b=iqhG2mQw+L4d0UJpHk0V0paQYZlaolYPVK4XUrIddbBQptD2AW/zToaE9VeqGzA8w6+1Kk
 VZoiPGg12sA8gHoxF09RgXsSGePUnPvGOQC73MCxHZ2eZdSw2CiRn61ohJhqQudaKcez/g
 be+VcFiLuhmXYueFaK/haQCcUKzVgE8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-4IZLYEVzO3-T-EduSWVDiw-1; Wed, 11 Sep 2024 09:52:13 -0400
X-MC-Unique: 4IZLYEVzO3-T-EduSWVDiw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a8d10954458so367259666b.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 06:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726062732; x=1726667532;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7SP0llBIv1hTkxB2e1G9eZTNJY30OOtKHAC0GZkH5pk=;
 b=kpoVlGJxdX+2VK+jPzgmBpDhLaRiNVHG/8YC6a9GXTKJTiBvo8RBCmOe74OCeq68h8
 22SAOLLaAAq235Hs7oC7Bl0RHxNJRccers7jcVCOhC9SPOhbpaJHAi9ODFtIVMXkHmmC
 uC2efNj1jSWSPZXZsaD8yp4IudCVIsmut4vIEfsE+auoutH52zrVMGT7ZXLSVsqVrAoA
 9IkDQQOrnsbZoT/wv0wS2fwavcFZnI6EMF33MtDHZx42WF09df9hV2ODAh7SzwVsGf6E
 1k/i0Vjgb/TbujynZ8ZkPgwBGpy6RRDZ4HhajhMT3rYMoSpILsSqEGWB/TFo2jgX9sx9
 S19g==
X-Gm-Message-State: AOJu0YxSDTer921HGdwz1AXL1L8iI9v91y/vWPjahtu7nw6UNf0wd1n1
 R1QZHIAIlTcxu4BiYMj+czdyfmej+kuNik6G6p949IrTEPQzuSdF8GOGKuBrqDNmmXByClUqvSa
 GOtv61fDl/mXzXbPV7yy29g0CZ4dA2U683PgeLTmO7+8V1WzZEf+F23u+CHSWq1Cnx/jR3jVvRm
 +h2t24OrwJYOUqSsOFTaNC1taHxt2+aQ==
X-Received: by 2002:a17:907:2d0c:b0:a8d:2e5f:8fdd with SMTP id
 a640c23a62f3a-a8ffae0bea7mr436046766b.59.1726062732015; 
 Wed, 11 Sep 2024 06:52:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9j3Zx7fBOmvGDs7LU/brNk/yeDDdgCfqQPYw6awSNHdmBK8k+8SMZdZd0Drc88ss0oO7qvA==
X-Received: by 2002:a17:907:2d0c:b0:a8d:2e5f:8fdd with SMTP id
 a640c23a62f3a-a8ffae0bea7mr436043766b.59.1726062731403; 
 Wed, 11 Sep 2024 06:52:11 -0700 (PDT)
Received: from redhat.com ([2.55.9.133]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a455besm622550566b.93.2024.09.11.06.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 06:52:10 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:52:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gao Shiyuan <gaoshiyuan@baidu.com>, Zuo Boqun <zuoboqun@baidu.com>
Subject: [PULL 14/18] virtio-pci: Add lookup subregion of VirtIOPCIRegion MR
Message-ID: <ffa8a3e3b2e6ff017113b98d500d6a9e05b1560a.1726062663.git.mst@redhat.com>
References: <cover.1726062663.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726062663.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Gao Shiyuan <gaoshiyuan@baidu.com>

Now virtio_address_space_lookup only lookup common/isr/device/notify
MR and exclude their subregions.

When VHOST_USER_PROTOCOL_F_HOST_NOTIFIER enable, the notify MR has
host-notifier subregions and we need use host-notifier MR to
notify the hardware accelerator directly instead of eventfd notify.

Further more, maybe common/isr/device MR also has subregions in
the future, so need memory_region_find for each MR incluing
their subregions.

Add lookup subregion of VirtIOPCIRegion MR instead of only lookup container MR.

Fixes: a93c8d8 ("virtio-pci: Replace modern_as with direct access to modern_bar")
Co-developed-by: Zuo Boqun <zuoboqun@baidu.com>
Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
Signed-off-by: Zuo Boqun <zuoboqun@baidu.com>
Message-Id: <20240903120304.97833-1-gaoshiyuan@baidu.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 524b63e5c7..4d832fe845 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -615,8 +615,12 @@ static MemoryRegion *virtio_address_space_lookup(VirtIOPCIProxy *proxy,
         reg = &proxy->regs[i];
         if (*off >= reg->offset &&
             *off + len <= reg->offset + reg->size) {
-            *off -= reg->offset;
-            return &reg->mr;
+            MemoryRegionSection mrs = memory_region_find(&reg->mr,
+                                        *off - reg->offset, len);
+            assert(mrs.mr);
+            *off = mrs.offset_within_region;
+            memory_region_unref(mrs.mr);
+            return mrs.mr;
         }
     }
 
-- 
MST


