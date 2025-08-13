Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E438CA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 16:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umEfs-0002u1-FP; Wed, 13 Aug 2025 12:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEfZ-0002im-2k; Wed, 13 Aug 2025 12:49:45 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEfK-0007sF-6X; Wed, 13 Aug 2025 12:49:44 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 46343812B6;
 Wed, 13 Aug 2025 19:49:19 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:167::1:21])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id wmOQI00FoSw0-z0Bhqwlx; Wed, 13 Aug 2025 19:49:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755103758;
 bh=beNcQYTX6DnX17DPcwxxbCJUIdHSyei20zNuVbTjZac=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=nDCtV4xGsjY2U/lbyq1xaV62UJwSbftdJgfL1vbVCBPuHYYugUOq2lRMu1DrCyXMT
 9X3H291Pu/oPqFgGkPBsgY60TvfXbUA0CEE+QpQ7ow2TQp6CMG/6XAfhrAW9v1mQJg
 lq7Uo3Dx3S1yu/7b/RNRq8toK0SOaOOsar3i7hzI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net
Cc: sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru, vsementsov@yandex-team.ru
Subject: [PATCH 21/33] vhost-user: make trace events more readable
Date: Wed, 13 Aug 2025 19:48:42 +0300
Message-ID: <20250813164856.950363-22-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250813164856.950363-1-vsementsov@yandex-team.ru>
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/trace-events |  4 +-
 hw/virtio/vhost-user.c | 94 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 94 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 76f0d458b2..e5142c27f9 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -25,8 +25,8 @@ vhost_user_set_mem_table_withfd(int index, const char *name, uint64_t memory_siz
 vhost_user_postcopy_waker(const char *rb, uint64_t rb_offset) "%s + 0x%"PRIx64
 vhost_user_postcopy_waker_found(uint64_t client_addr) "0x%"PRIx64
 vhost_user_postcopy_waker_nomatch(const char *rb, uint64_t rb_offset) "%s + 0x%"PRIx64
-vhost_user_read(uint32_t req, uint32_t flags) "req:%d flags:0x%"PRIx32""
-vhost_user_write(uint32_t req, uint32_t flags) "req:%d flags:0x%"PRIx32""
+vhost_user_read(uint32_t req, const char *req_name, uint32_t flags) "req:%d (%s) flags:0x%"PRIx32""
+vhost_user_write(uint32_t req, const char *req_name, uint32_t flags) "req:%d (%s) flags:0x%"PRIx32""
 vhost_user_create_notifier(int idx, void *n) "idx:%d n:%p"
 
 # vhost-vdpa.c
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index fe9d91348d..3979582975 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -119,6 +119,94 @@ typedef enum VhostUserBackendRequest {
     VHOST_USER_BACKEND_MAX
 }  VhostUserBackendRequest;
 
+static const char *vhost_req_name(VhostUserRequest req)
+{
+    switch (req) {
+    case VHOST_USER_NONE:
+        return "NONE";
+    case VHOST_USER_GET_FEATURES:
+        return "GET_FEATURES";
+    case VHOST_USER_SET_FEATURES:
+        return "SET_FEATURES";
+    case VHOST_USER_SET_OWNER:
+        return "SET_OWNER";
+    case VHOST_USER_RESET_OWNER:
+        return "RESET_OWNER";
+    case VHOST_USER_SET_MEM_TABLE:
+        return "SET_MEM_TABLE";
+    case VHOST_USER_SET_LOG_BASE:
+        return "SET_LOG_BASE";
+    case VHOST_USER_SET_LOG_FD:
+        return "SET_LOG_FD";
+    case VHOST_USER_SET_VRING_NUM:
+        return "SET_VRING_NUM";
+    case VHOST_USER_SET_VRING_ADDR:
+        return "SET_VRING_ADDR";
+    case VHOST_USER_SET_VRING_BASE:
+        return "SET_VRING_BASE";
+    case VHOST_USER_GET_VRING_BASE:
+        return "GET_VRING_BASE";
+    case VHOST_USER_SET_VRING_KICK:
+        return "SET_VRING_KICK";
+    case VHOST_USER_SET_VRING_CALL:
+        return "SET_VRING_CALL";
+    case VHOST_USER_SET_VRING_ERR:
+        return "SET_VRING_ERR";
+    case VHOST_USER_GET_PROTOCOL_FEATURES:
+        return "GET_PROTOCOL_FEATURES";
+    case VHOST_USER_SET_PROTOCOL_FEATURES:
+        return "SET_PROTOCOL_FEATURES";
+    case VHOST_USER_GET_QUEUE_NUM:
+        return "GET_QUEUE_NUM";
+    case VHOST_USER_SET_VRING_ENABLE:
+        return "SET_VRING_ENABLE";
+    case VHOST_USER_SEND_RARP:
+        return "SEND_RARP";
+    case VHOST_USER_NET_SET_MTU:
+        return "NET_SET_MTU";
+    case VHOST_USER_SET_BACKEND_REQ_FD:
+        return "SET_BACKEND_REQ_FD";
+    case VHOST_USER_IOTLB_MSG:
+        return "IOTLB_MSG";
+    case VHOST_USER_SET_VRING_ENDIAN:
+        return "SET_VRING_ENDIAN";
+    case VHOST_USER_GET_CONFIG:
+        return "GET_CONFIG";
+    case VHOST_USER_SET_CONFIG:
+        return "SET_CONFIG";
+    case VHOST_USER_CREATE_CRYPTO_SESSION:
+        return "CREATE_CRYPTO_SESSION";
+    case VHOST_USER_CLOSE_CRYPTO_SESSION:
+        return "CLOSE_CRYPTO_SESSION";
+    case VHOST_USER_POSTCOPY_ADVISE:
+        return "POSTCOPY_ADVISE";
+    case VHOST_USER_POSTCOPY_LISTEN:
+        return "POSTCOPY_LISTEN";
+    case VHOST_USER_POSTCOPY_END:
+        return "POSTCOPY_END";
+    case VHOST_USER_GET_INFLIGHT_FD:
+        return "GET_INFLIGHT_FD";
+    case VHOST_USER_SET_INFLIGHT_FD:
+        return "SET_INFLIGHT_FD";
+    case VHOST_USER_GPU_SET_SOCKET:
+        return "GPU_SET_SOCKET";
+    case VHOST_USER_RESET_DEVICE:
+        return "RESET_DEVICE";
+    case VHOST_USER_GET_MAX_MEM_SLOTS:
+        return "GET_MAX_MEM_SLOTS";
+    case VHOST_USER_ADD_MEM_REG:
+        return "ADD_MEM_REG";
+    case VHOST_USER_REM_MEM_REG:
+        return "REM_MEM_REG";
+    case VHOST_USER_SET_STATUS:
+        return "SET_STATUS";
+    case VHOST_USER_GET_STATUS:
+        return "GET_STATUS";
+    default:
+        return "<unknown>";
+    }
+}
+
 typedef struct VhostUserMemoryRegion {
     uint64_t guest_phys_addr;
     uint64_t memory_size;
@@ -310,7 +398,8 @@ static int vhost_user_read_header(struct vhost_dev *dev, VhostUserMsg *msg)
         return -EPROTO;
     }
 
-    trace_vhost_user_read(msg->hdr.request, msg->hdr.flags);
+    trace_vhost_user_read(msg->hdr.request,
+                          vhost_req_name(msg->hdr.request), msg->hdr.flags);
 
     return 0;
 }
@@ -430,7 +519,8 @@ static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
         return ret < 0 ? -saved_errno : -EIO;
     }
 
-    trace_vhost_user_write(msg->hdr.request, msg->hdr.flags);
+    trace_vhost_user_write(msg->hdr.request,
+                          vhost_req_name(msg->hdr.request), msg->hdr.flags);
 
     return 0;
 }
-- 
2.48.1


