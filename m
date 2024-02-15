Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFF5C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 10:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raZ6X-0004hz-48; Thu, 15 Feb 2024 05:36:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1raZ6U-0004hg-3r
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 05:36:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1raZ6S-00043g-Lq
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 05:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707993387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yFDdE8GidXq283G46e8bcMbdU6Bcjix9irzZSdDTL5E=;
 b=GkV0Bfwvt7IywR/bCkVIY9nTWsc+A0B1grHF2ffxZMg2LXsMc7k2eimyYOoRazKVQNDub1
 WkrFsTQ9+mEmz/wlojkZWf78oK7cuM6qjOId0ZE/Aiz4Aq2cnUg7S7IvoV/3stW4+PFjeJ
 VwuA3dfbIZZVGH6DSiRJnHV2QFMRBWk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-I1Xs_dtZN3K7I4_rthjjoA-1; Thu,
 15 Feb 2024 05:36:24 -0500
X-MC-Unique: I1Xs_dtZN3K7I4_rthjjoA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5A6629AC039;
 Thu, 15 Feb 2024 10:36:23 +0000 (UTC)
Received: from eperezma-thinkpadt480s.rmtes.csb (unknown [10.39.192.139])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A42E2022AAA;
 Thu, 15 Feb 2024 10:36:22 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
 Lei Yang <leiyang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH 2/2] vdpa: trace skipped memory sections
Date: Thu, 15 Feb 2024 11:36:16 +0100
Message-ID: <20240215103616.330518-3-eperezma@redhat.com>
In-Reply-To: <20240215103616.330518-1-eperezma@redhat.com>
References: <20240215103616.330518-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Sometimes, certain parts are not being skipped in
vhost_vdpa_listener_region_del, but they are skipped in
vhost_vdpa_listener_region_add, or vice versa.  The vhost-vdpa code
expects all parts to maintain their properties, so we're adding a trace
to help with debugging when any part is skipped.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/trace-events | 1 +
 hw/virtio/vhost-vdpa.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 77905d1994..fa2fb6b6d1 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -30,6 +30,7 @@ vhost_user_write(uint32_t req, uint32_t flags) "req:%d flags:0x%"PRIx32""
 vhost_user_create_notifier(int idx, void *n) "idx:%d n:%p"
 
 # vhost-vdpa.c
+vhost_vdpa_skipped_memory_section(int is_ram, int is_iommu, int is_protected, int is_ram_device, uint64_t first, uint64_t last, int page_mask) "is_ram=%d, is_iommu=%d, is_protected=%d, is_ram_device=%d iova_min=0x%"PRIx64" iova_last=0x%"PRIx64" page_mask=0x%x"
 vhost_vdpa_dma_map(void *vdpa, int fd, uint32_t msg_type, uint32_t asid, uint64_t iova, uint64_t size, uint64_t uaddr, uint8_t perm, uint8_t type) "vdpa_shared:%p fd: %d msg_type: %"PRIu32" asid: %"PRIu32" iova: 0x%"PRIx64" size: 0x%"PRIx64" uaddr: 0x%"PRIx64" perm: 0x%"PRIx8" type: %"PRIu8
 vhost_vdpa_dma_unmap(void *vdpa, int fd, uint32_t msg_type, uint32_t asid, uint64_t iova, uint64_t size, uint8_t type) "vdpa_shared:%p fd: %d msg_type: %"PRIu32" asid: %"PRIu32" iova: 0x%"PRIx64" size: 0x%"PRIx64" type: %"PRIu8
 vhost_vdpa_listener_begin_batch(void *v, int fd, uint32_t msg_type, uint8_t type)  "vdpa_shared:%p fd: %d msg_type: %"PRIu32" type: %"PRIu8
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 2b9e5c3d4d..76d300be29 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -55,6 +55,9 @@ static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection *section,
     bool is_ram_device = memory_region_is_ram_device(section->mr);
 
     if ((!is_ram && !is_iommu) || is_protected || is_ram_device) {
+        trace_vhost_vdpa_skipped_memory_section(is_ram, is_iommu, is_protected,
+                                                is_ram_device, iova_min,
+                                                iova_max, page_mask);
         return true;
     }
 
-- 
2.43.0


