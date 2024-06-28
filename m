Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75A5C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 14:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sND2z-0007Hf-Me; Fri, 28 Jun 2024 10:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1sND2t-0007E7-GF
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:57:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1sND2m-0003A5-5K
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719586662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=95ZBOAFeQ4dSgCRsZThJ9ANpiObHEVIWQMUOqGoa0os=;
 b=TM/ResZmtUac+ArjNAFZuxwYJ/mnKr8GgYCLY5hoz2y6mUfQghQlnjEPY4jjL1GlGomW6v
 rWGh4vShUvHT+clAHm2HlioGakSSwz3JHEnRyL9NDsY83LCzd7okz4H0TyYV8WZIdpbwWr
 4l4VPPWWTpWxrB16gjn5C+fl6WOGUjc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-noSeCbp3O_GosPSJKTvTJQ-1; Fri,
 28 Jun 2024 10:57:39 -0400
X-MC-Unique: noSeCbp3O_GosPSJKTvTJQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17ED41944DE4; Fri, 28 Jun 2024 14:57:38 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.245])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 740281944DC5; Fri, 28 Jun 2024 14:57:34 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, david@redhat.com, slp@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 stefanha@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Albert Esteve <aesteve@redhat.com>
Subject: [RFC PATCH v2 5/5] vhost_user: Implement mem_read/mem_write handlers
Date: Fri, 28 Jun 2024 16:57:10 +0200
Message-ID: <20240628145710.1516121-6-aesteve@redhat.com>
In-Reply-To: <20240628145710.1516121-1-aesteve@redhat.com>
References: <20240628145710.1516121-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Implement function handlers for memory read and write
operations.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 hw/virtio/vhost-user.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 18cacb2d68..79becbc87b 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1884,16 +1884,42 @@ static int
 vhost_user_backend_handle_mem_read(struct vhost_dev *dev,
                                    VhostUserMemRWMsg *mem_rw)
 {
-    /* TODO */
-    return -EPERM;
+    ram_addr_t offset;
+    int fd;
+    MemoryRegion *mr;
+    
+    mr = vhost_user_get_mr_data(mem_rw->guest_address, &offset, &fd);
+
+    if (!mr) {
+        error_report("Failed to get memory region with address %" PRIx64,
+                     mem_rw->guest_address);
+        return -EFAULT;
+    }
+
+    memcpy(mem_rw->data, memory_region_get_ram_ptr(mr) + offset, mem_rw->size);
+
+    return 0;
 }
 
 static int
 vhost_user_backend_handle_mem_write(struct vhost_dev *dev,
                                    VhostUserMemRWMsg *mem_rw)
 {
-    /* TODO */
-    return -EPERM;
+    ram_addr_t offset;
+    int fd;
+    MemoryRegion *mr;
+    
+    mr = vhost_user_get_mr_data(mem_rw->guest_address, &offset, &fd);
+
+    if (!mr) {
+        error_report("Failed to get memory region with address %" PRIx64,
+                     mem_rw->guest_address);
+        return -EFAULT;
+    }
+
+    memcpy(memory_region_get_ram_ptr(mr) + offset, mem_rw->data, mem_rw->size);
+
+    return 0;
 }
 
 static void close_backend_channel(struct vhost_user *u)
-- 
2.45.2


