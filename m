Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA39CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 09:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3WSU-0004z6-75; Tue, 30 Sep 2025 05:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3WSF-0004sz-6T
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:15:27 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3WS0-000158-9L
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:15:26 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e4f2696bdso32327075e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 02:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759223703; x=1759828503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=opf5AG1XfLO8GoawGiZhJ2gSkTioavJ7xaDVzcsz0jU=;
 b=GQoIIdQzqu5DD7+jhB1o3qUYvRgYxDQsgKWWzKDP9La/KpCZwKvKcW+q/8ju79Kn5h
 U3BvmInCeHGu5tgFff3htEhg/VSlfDomMPcfDyqK3qzRLFVJ+HUvF0LqZin+tqLs0HDH
 Mf/CHH4v0YaCaFJX559rT880gWe0ws7Y/miRyH62oa4hnZ3MPSOqbdqeoPcMYHqNVccj
 +DRTUGhzkkjcMqkiXe8ec9n+kjT3Cj2NCE8drZCrbP3EjUBTxKnJWohUvnMFliiN+j3o
 JO3air9NHbZHvLG9PxVIGk49Scp2XMOQ7KuLeBgzdKbi1us4gB54Y0OEFD4EKSuxVyZ0
 RbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759223703; x=1759828503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=opf5AG1XfLO8GoawGiZhJ2gSkTioavJ7xaDVzcsz0jU=;
 b=gHGXeMG+Vh62AdB3+0KOEax9pq5widO3NxdZ17HS/32IsH8o6/7bKr0mvMHE67vy+M
 g5qbjDbw5ecOrETCIvJ37wyFS6o3inmWvX1OREjHQRf12hhM5ugY+uTAYHhXlN735q8R
 yRlNrFkw/eS+Kp/jdVYw1G/0TmZrIes7WxHvCHLbsRwv/uqoKeHrkqR8awBH5vue2Kkt
 JB2EtfpRIuzlPehesmspvQerEDONX4xb5xPCMGWl2ZHSq0tx/4Z3KnT+SHa1YZBXCJUd
 zBeABJdqv8QssopsdyLsLrJoAPWelJChN+4pvRsD0Pc6thlyQPQLj9LervNC7ou5rXWw
 ia+A==
X-Gm-Message-State: AOJu0YyBc128bdvOav0Jez7SVcDbIUDsHBAukLi8M0iMAbEM89/s0A7K
 jwIFBCNYt0VRVywD41Mw0VA+42FKKxECJM/jeL82LePCMFsbfKw9gazOv1wK0ryRgg5qUJ0CuDO
 ixEtDFZ64gg==
X-Gm-Gg: ASbGncvE74t+0KyD5A+ino7/Tv82WF4dPM3k3frGgukCH+7FlYKx+6//+AhZ2njPb16
 whko85c3g7tUayyTNtG+q0IdsWcOAumyHOMBGgEi0WSj6M15ohlu34fhl8Pj6E/ueOPWnCUqlq8
 8UrMPSZnfa7J+gqVtBPVoVJLFizqXIs3yepzUyo3GDHyMEwByv2FTwlBT7XIaxizb/uXZxEd4P4
 NuYSbCLkooNuiXO4U7ED/QcosAPIQ370uF6KyBRSS29C/7XKixsKKedJNbwzIRbYRxEb0AdbRpy
 lMFhVsUp2yMIX4W0BWGasEd6dzn8yGciTbFkAO8prYUax0SFxb2wg3Rkjwi1DmzZoTUQgitzAg8
 MmuR8ndYm3IZz5P1KcMb+lqKphjXyolnv7zWfFHGba95cHdn+WySBMMAAb6mFdqBvAb7cVCK7O9
 mvLiRQsYV6ENSydfFJC9Pf
X-Google-Smtp-Source: AGHT+IEf9rd3VZUVXAYGO08YVjzMyeAzyQnihGQTi1xUWrRMzGiz7w9Xd0jwx+tTmfL+idCDd2uXGg==
X-Received: by 2002:a05:600c:4e50:b0:46e:3d5a:d15d with SMTP id
 5b1f17b1804b1-46e3d5ad285mr148491415e9.26.1759223703003; 
 Tue, 30 Sep 2025 02:15:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f658ffsm46991525e9.14.2025.09.30.02.15.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 02:15:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/3] system/iommufd: Use uint64_t type for IOVA mapping size
Date: Tue, 30 Sep 2025 11:14:54 +0200
Message-ID: <20250930091456.34524-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930091456.34524-1-philmd@linaro.org>
References: <20250930091456.34524-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The 'ram_addr_t' type is described as:

  a QEMU internal address space that maps guest RAM physical
  addresses into an intermediate address space that can map
  to host virtual address spaces.

This doesn't represent well an IOVA mapping size. Simply use
the uint64_t type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/iommufd.h | 6 +++---
 backends/iommufd.c       | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index c9c72ffc450..a659f36a20f 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -45,12 +45,12 @@ bool iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
                                 Error **errp);
 void iommufd_backend_free_id(IOMMUFDBackend *be, uint32_t id);
 int iommufd_backend_map_file_dma(IOMMUFDBackend *be, uint32_t ioas_id,
-                                 hwaddr iova, ram_addr_t size, int fd,
+                                 hwaddr iova, uint64_t size, int fd,
                                  unsigned long start, bool readonly);
 int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
-                            ram_addr_t size, void *vaddr, bool readonly);
+                            uint64_t size, void *vaddr, bool readonly);
 int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
-                              hwaddr iova, ram_addr_t size);
+                              hwaddr iova, uint64_t size);
 bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
                                      uint32_t *type, void *data, uint32_t len,
                                      uint64_t *caps, Error **errp);
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 2a33c7ab0bc..fdfb7c9d671 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -197,7 +197,7 @@ void iommufd_backend_free_id(IOMMUFDBackend *be, uint32_t id)
 }
 
 int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
-                            ram_addr_t size, void *vaddr, bool readonly)
+                            uint64_t size, void *vaddr, bool readonly)
 {
     int ret, fd = be->fd;
     struct iommu_ioas_map map = {
@@ -230,7 +230,7 @@ int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
 }
 
 int iommufd_backend_map_file_dma(IOMMUFDBackend *be, uint32_t ioas_id,
-                                 hwaddr iova, ram_addr_t size,
+                                 hwaddr iova, uint64_t size,
                                  int mfd, unsigned long start, bool readonly)
 {
     int ret, fd = be->fd;
@@ -268,7 +268,7 @@ int iommufd_backend_map_file_dma(IOMMUFDBackend *be, uint32_t ioas_id,
 }
 
 int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
-                              hwaddr iova, ram_addr_t size)
+                              hwaddr iova, uint64_t size)
 {
     int ret, fd = be->fd;
     struct iommu_ioas_unmap unmap = {
-- 
2.51.0


