Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4865C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 10:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raZ6T-0004hT-Of; Thu, 15 Feb 2024 05:36:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1raZ6R-0004gt-En
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 05:36:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1raZ6P-000435-J1
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 05:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707993384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S5e3yocz6I9TbhKFUdV4GsuQy2TLtcMXKaXFr6dGpX8=;
 b=DFllSrdjuC44FtMJJbIAsIi3PHI3I9waQmPcLaaRBiMAYdlfn9yH1pjMPxgExTD8olwef6
 8DuTxiq3ee+/+fXytZjFkyWtTMucJpeVYR5tJpg4p/x8PWh1zC+EhbcgGsMdXDL80JJ7z5
 LkqLmtL39iZnfQnLQXdH/IeW7w5cuaA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-ujwWPsZAN6SUnBRGcmVQsQ-1; Thu, 15 Feb 2024 05:36:22 -0500
X-MC-Unique: ujwWPsZAN6SUnBRGcmVQsQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A5E683F26C;
 Thu, 15 Feb 2024 10:36:22 +0000 (UTC)
Received: from eperezma-thinkpadt480s.rmtes.csb (unknown [10.39.192.139])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F6E820110C4;
 Thu, 15 Feb 2024 10:36:20 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 Lei Yang <leiyang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH 1/2] vdpa: stash memory region properties in vars
Date: Thu, 15 Feb 2024 11:36:15 +0100
Message-ID: <20240215103616.330518-2-eperezma@redhat.com>
In-Reply-To: <20240215103616.330518-1-eperezma@redhat.com>
References: <20240215103616.330518-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Next changes uses this variables, so avoid call repeatedly to memory
region functions. No functional change intended.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index ddae494ca8..2b9e5c3d4d 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -47,12 +47,14 @@ static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection *section,
                                                 int page_mask)
 {
     Int128 llend;
+    bool is_ram = memory_region_is_ram(section->mr);
+    bool is_iommu = memory_region_is_iommu(section->mr);
+    bool is_protected = memory_region_is_protected(section->mr);
 
-    if ((!memory_region_is_ram(section->mr) &&
-         !memory_region_is_iommu(section->mr)) ||
-        memory_region_is_protected(section->mr) ||
-        /* vhost-vDPA doesn't allow MMIO to be mapped  */
-        memory_region_is_ram_device(section->mr)) {
+    /* vhost-vDPA doesn't allow MMIO to be mapped  */
+    bool is_ram_device = memory_region_is_ram_device(section->mr);
+
+    if ((!is_ram && !is_iommu) || is_protected || is_ram_device) {
         return true;
     }
 
@@ -69,7 +71,7 @@ static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection *section,
      * size that maps to the kernel
      */
 
-    if (!memory_region_is_iommu(section->mr)) {
+    if (!is_iommu) {
         llend = vhost_vdpa_section_end(section, page_mask);
         if (int128_gt(llend, int128_make64(iova_max))) {
             error_report("RAM section out of device range (max=0x%" PRIx64
-- 
2.43.0


