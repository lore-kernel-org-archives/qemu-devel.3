Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0948EC48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 15:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raH0h-0007gn-I6; Wed, 14 Feb 2024 10:17:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1raH0d-0007gb-SO
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 10:17:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1raH0c-0000Kn-C4
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 10:17:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707923832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h3vrvrrsqxQRRX1DdJMjzsxwaD3Jnd+isNz0iU98YIk=;
 b=izEa6RMoY7yr6qr99wqGDgzXxsJVi4Zj2lZgr8BwZ2FhYuyEbQ4aXg/9BbqUn+mKl45Pah
 XbmkfShuuzA4KyIWpNFtt4Zq8pY13tYV3sKb1yPmCKKPWGnFpNrSnbzA5lIX3lE+d40mA2
 JKTYt10WqzVzofg6Su/EqPRgJhayiNo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-GgdMN97APlyHHNzWgKodqA-1; Wed,
 14 Feb 2024 10:17:09 -0500
X-MC-Unique: GgdMN97APlyHHNzWgKodqA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E67691C05AE3;
 Wed, 14 Feb 2024 15:17:08 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D04DA1C02ECC;
 Wed, 14 Feb 2024 15:17:05 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Raphael Norwitz <raphael@enfabrica.net>
Subject: [PATCH v2 01/14] libvhost-user: Dynamically allocate memory for
 memory slots
Date: Wed, 14 Feb 2024 16:16:48 +0100
Message-ID: <20240214151701.29906-2-david@redhat.com>
In-Reply-To: <20240214151701.29906-1-david@redhat.com>
References: <20240214151701.29906-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
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

Let's prepare for increasing VHOST_USER_MAX_RAM_SLOTS by dynamically
allocating dev->regions. We don't have any ABI guarantees (not
dynamically linked), so we can simply change the layout of VuDev.

Let's zero out the memory, just as we used to do.

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 11 +++++++++++
 subprojects/libvhost-user/libvhost-user.h |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index a3b158c671..360c5366d6 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -2171,6 +2171,8 @@ vu_deinit(VuDev *dev)
 
     free(dev->vq);
     dev->vq = NULL;
+    free(dev->regions);
+    dev->regions = NULL;
 }
 
 bool
@@ -2205,9 +2207,18 @@ vu_init(VuDev *dev,
     dev->backend_fd = -1;
     dev->max_queues = max_queues;
 
+    dev->regions = malloc(VHOST_USER_MAX_RAM_SLOTS * sizeof(dev->regions[0]));
+    if (!dev->regions) {
+        DPRINT("%s: failed to malloc mem regions\n", __func__);
+        return false;
+    }
+    memset(dev->regions, 0, VHOST_USER_MAX_RAM_SLOTS * sizeof(dev->regions[0]));
+
     dev->vq = malloc(max_queues * sizeof(dev->vq[0]));
     if (!dev->vq) {
         DPRINT("%s: failed to malloc virtqueues\n", __func__);
+        free(dev->regions);
+        dev->regions = NULL;
         return false;
     }
 
diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
index c2352904f0..c882b4e3a2 100644
--- a/subprojects/libvhost-user/libvhost-user.h
+++ b/subprojects/libvhost-user/libvhost-user.h
@@ -398,7 +398,7 @@ typedef struct VuDevInflightInfo {
 struct VuDev {
     int sock;
     uint32_t nregions;
-    VuDevRegion regions[VHOST_USER_MAX_RAM_SLOTS];
+    VuDevRegion *regions;
     VuVirtq *vq;
     VuDevInflightInfo inflight_info;
     int log_call_fd;
-- 
2.43.0


