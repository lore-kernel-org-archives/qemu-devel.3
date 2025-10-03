Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7814CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 10:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4d6t-0006ME-NZ; Fri, 03 Oct 2025 06:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v4d6r-0006Ji-K2
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 06:33:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v4d6g-0004hj-9g
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 06:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759487620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sK5ebWjUv2fD9bKWHmRsFHQeApusZcoiqbKQ7O7mBKo=;
 b=TE4SXmXEh/ufCFrwyThKnx0olda9wc5+sNwyhTSzzFiw7jTp2aDKJKxe859seXAtCB59Yg
 ATQc8XzdjWDL/8fWVoMmaQMbBeUBT9s8zdsGvktHquwdeySwMou7wDIv5ZVovk5ougWcHn
 F/Pv3oBd1GhMsbg1M8iDuwvYx15q7Kg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-UAI_wxb0NlKRvcejuKlUqQ-1; Fri,
 03 Oct 2025 06:33:38 -0400
X-MC-Unique: UAI_wxb0NlKRvcejuKlUqQ-1
X-Mimecast-MFC-AGG-ID: UAI_wxb0NlKRvcejuKlUqQ_1759487617
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E5E019560BB; Fri,  3 Oct 2025 10:33:37 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.118])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 94E7E300018D; Fri,  3 Oct 2025 10:33:35 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 2/5] system/iommufd: Use uint64_t type for IOVA mapping size
Date: Fri,  3 Oct 2025 12:33:25 +0200
Message-ID: <20251003103328.1864910-3-clg@redhat.com>
In-Reply-To: <20251003103328.1864910-1-clg@redhat.com>
References: <20251003103328.1864910-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The 'ram_addr_t' type is described as:

  a QEMU internal address space that maps guest RAM physical
  addresses into an intermediate address space that can map
  to host virtual address spaces.

This doesn't represent well an IOVA mapping size. Simply use
the uint64_t type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250930123528.42878-2-philmd@linaro.org
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/system/iommufd.h | 6 +++---
 backends/iommufd.c       | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index c9c72ffc4509d7b5d09e8129c5065478aa23aec0..a659f36a20fdcf2f4855ebca43fc801a1b0e6634 100644
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
index 2a33c7ab0bcdc9aabda55258741022debab0bdad..fdfb7c9d67197da11d35290ba2f44e0b005c2690 100644
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


