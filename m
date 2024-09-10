Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B13EDE9A4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 16:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so3sq-00066L-9v; Tue, 10 Sep 2024 12:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1so3so-00065B-Gq
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:38:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1so3sa-0006jd-Fe
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725986290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=h2D3RoVVPEx/TiiFNZyXGbaa4fIb2+mDNITST/NtVo8=;
 b=JDyk4CJo62eVpeDBVEga0LqEBkzMl7uTXT7ya6Rl+JyzAROrypiQU7On7zpRrjCfbbhVzA
 lxflW3UimnN2BYkyR5v69YkuZYiUvblHtoNRqjorX8yCalS+C9e3jGCb+8gbqh9DusW1/l
 Ra/WbkkQp3KB5uMZjq4vCA9GB9Xhru8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-7eg70OXMMP2zaccpkuDbVA-1; Tue,
 10 Sep 2024 12:34:38 -0400
X-MC-Unique: 7eg70OXMMP2zaccpkuDbVA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9D071955F09
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 16:34:37 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.16.63])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 19003300147D; Tue, 10 Sep 2024 16:34:34 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gavin Shan <gshan@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v1] virtio-mem: don't warn about THP sizes on a kernel without
 THP support
Date: Tue, 10 Sep 2024 18:34:33 +0200
Message-ID: <20240910163433.2100295-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

If the config directory in sysfs does not exist at all, we are dealing
with a system that does not support THPs. Simply use 1 MiB block size
then, instead of warning "Could not detect THP size, falling back to
..." and falling back to the default THP size.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>
Cc: Juraj Marcin <jmarcin@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-mem.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index ef64bf1b4a..4075f3d4ce 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -88,6 +88,7 @@ static uint32_t virtio_mem_default_thp_size(void)
 static uint32_t thp_size;
 
 #define HPAGE_PMD_SIZE_PATH "/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"
+#define HPAGE_PATH "/sys/kernel/mm/transparent_hugepage/"
 static uint32_t virtio_mem_thp_size(void)
 {
     gchar *content = NULL;
@@ -98,6 +99,12 @@ static uint32_t virtio_mem_thp_size(void)
         return thp_size;
     }
 
+    /* No THP -> no restrictions. */
+    if (!g_file_test(HPAGE_PATH, G_FILE_TEST_EXISTS)) {
+        thp_size = VIRTIO_MEM_MIN_BLOCK_SIZE;
+        return thp_size;
+    }
+
     /*
      * Try to probe the actual THP size, fallback to (sane but eventually
      * incorrect) default sizes.
-- 
2.46.0


