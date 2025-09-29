Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93237CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3GQH-0000Mv-C9; Mon, 29 Sep 2025 12:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3GQF-0000MR-Ac
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:08:19 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3GQD-0004EE-34
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:08:19 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e37d10ed2so46697265e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 09:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759162094; x=1759766894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=opf5AG1XfLO8GoawGiZhJ2gSkTioavJ7xaDVzcsz0jU=;
 b=BwZzkwD1bBYsRcs4Ke6vhaz3zKyoDnR9M6zChzboBMbsX5AFQM1SfCKXCIJHipZ7QB
 YUDOclJmXh3Ub9ToKjGEyhu0E73vLeRp+OPUbpLjYvhW9n5teX1wbXTM9whk/JoTKDLn
 B3/qF5+ijZbCLViyOlnZ2cxzp2J3Iw9CxFvzmYCIrk7Cwg/RlHYukgiFga6fWNbpZDBB
 /3Lu2rxE+PdGoUz7KbWPO23ZuhCILs4z6QOb1X7wwabuput9ODlBijVw/qKb1caqu1aS
 lwsiwwoW4/aYclArXKNuxCWPlBE2MuxlWW1yl/RMWZPa8T1bzT7Sz/bE+uZXRz26rNvi
 8r2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759162094; x=1759766894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=opf5AG1XfLO8GoawGiZhJ2gSkTioavJ7xaDVzcsz0jU=;
 b=tD0u4FIu+3tlebbC1UJFMM+LfX/GxNu+isEe4t+ZkeeSkRmrCgWWGa0yWjhLHV8DvR
 C5GPDk79ZaxvIQFFaK1HVKjodsZDSx4kbu5MiKVn/ghyzNMIU/SmU0U+QRIuRQB5zGbe
 /nOT+cA6eR1hXgXDb4ivOOLt4zYK00ZR9JSCm+4QySIi+ruZDWlTTKnG37f6OtG6owUw
 ckPk1Pcf9kkaq3MzEVOZxJ67INKXyO4bIu49nN+/PFdZq6dhkObyO5B0j4bkepKng/0g
 0VPyd8GrWNkSHXFSl5Owa8fGi4ju9CEA6umVjJgcGpOJLs+g1F33BSu/GkZFFCx+qPGM
 GvJQ==
X-Gm-Message-State: AOJu0Yy9ayeTWNCGaaUu7VefZs3CdtzRGwx0mEj4HXNAfc1CAg5j9grr
 4HiE4Dio4T1w8gUS6717G3M3Zauo2w7AbV57TJ0Qs+lf1TzCyE4sRO9DUjCzbe818RE0oa8vdRI
 GPpPVAcalTw==
X-Gm-Gg: ASbGncvfSmhbZOa07KkrgfmKwkZglCgAay5J9z0Itk38np4Z0bGihru1A7YAH2i3H5h
 za3n0rPnOTQqdEARS+j05/JyRiC3U7icO/TT8S/ROt8Bh2/efebkrz2PPjIT+KqiPgLhT7IZnm2
 +O04+Ossiztm+oy4M2K03ZabHds0DVZ9VFdvoA3CzTIEZMmEDJsiDTAf60repdTwiQoN8IiJ9xe
 D9MhBbto+sL0EqIRyW03liSHh0zv3vw3PsaiW25G6mDtNJPuY7bXNTudtO6E5Qa6543QQGAzWoB
 ZQcLnjsVl4hY6D9Rj1BuPR9AFI0dIG2Veach2on5eGBsRxGjStCJMq34buEkuNSiCWgOtlk0cM4
 zI4t9SIYL9aXg6T3ChtM+28/TXCB9jMqHS+5WYwf2fG4icnsdhn6FElYjtIKS8nDz85G1dk6JEL
 W9UeSEN9E=
X-Google-Smtp-Source: AGHT+IE55cx0yE+4DTBrDw+WQ62NKL9NeSPaZs9GoaWtbURD5wgxRsvtSqJnuJMa6zvT77LXrZ/3cg==
X-Received: by 2002:a05:600c:4748:b0:46e:43fa:2dd7 with SMTP id
 5b1f17b1804b1-46e43fa2e79mr84438065e9.24.1759162094101; 
 Mon, 29 Sep 2025 09:08:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb9e1bd14sm19662924f8f.28.2025.09.29.09.08.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 09:08:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Levon <john.levon@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] system/iommufd: Use uint64_t type for IOVA mapping size
Date: Mon, 29 Sep 2025 18:08:05 +0200
Message-ID: <20250929160807.73626-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929160807.73626-1-philmd@linaro.org>
References: <20250929160807.73626-1-philmd@linaro.org>
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


