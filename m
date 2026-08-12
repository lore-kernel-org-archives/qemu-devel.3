Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D65C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8fF-0002Gk-Fy; Wed, 12 Aug 2026 09:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8fB-0002Ek-L8; Wed, 12 Aug 2026 09:06:33 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8f9-00054k-J0; Wed, 12 Aug 2026 09:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539783; bh=AUKTEGb1amDyo2ifw4gohcGjTJjkUIHPy80FyWqS34M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=wmPR/LZqvOSxs7IgUf4hvoUN/lVUFVt25znhomJLXEvCtMlkACQZY9zE+vwom4HLb
 X4nrAb8Tv6Tzsqa9SnyC/Hcqb2Nbc4ygu1WFp4BZPjO7GwdBWi1sgU+xOScYCZhPpx
 5yqsotynv3ErNjDbGn+bgxHQmaFVnrB9AxpgSgnBk1VXE0izlGZ6w0KqSJwIo5HiBn
 Hr5xlBf7oDJSuqX0ZekHnCFqKr7jjIYMYS4sObx9zwaV+mom8J5DVs5bg12lxSw2Tp
 Z7mv19zpZ+YkeKuR9ZrTvD3AOdOPBJf3h/ttwx57NymIsX+pPGnXI7HyOyRWQb+AR0
 fH2xGCyAV5dEg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C578B1CA4A6;
 Wed, 12 Aug 2026 16:03:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 077C5409B89;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 30C572F8E2; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, xlabai <xlabai@tencent.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 039/102] libvhost-user: protect against OOB vring
 queue access
Date: Wed, 12 Aug 2026 16:01:14 +0300
Message-ID: <20260812130233.621965-39-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: "Michael S. Tsirkin" <mst@redhat.com>

SET_VRING_NUM, SET_VRING_ADDR, SET_VRING_BASE, and GET_VRING_BASE
handlers all use the queue index from the message to access dev->vq[]
without checking that it is below dev->max_queues, so a malformed
message causes an out-of-bounds heap access.

Frontend is trusted so not a security problem, but
an OOB access is not a nice way to handle errors.
Check, and panic.

Fixes: 7b2e5c65f4 ("contrib: add libvhost-user")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3741
Cc: Stefano Garzarella <sgarzare@redhat.com>
Reported-by: xlabai <xlabai@tencent.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <dbba777b25f86587c8d131891a2b4b2be97e5c5b.1784899069.git.mst@redhat.com>
(cherry picked from commit 758ef96a2dba157e930af7709f327435a153f7a3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index bdaa6917f19..82e16c2c969 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1200,6 +1200,12 @@ vu_set_vring_num_exec(VuDev *dev, VhostUserMsg *vmsg)
 
     DPRINT("State.index: %u\n", index);
     DPRINT("State.num:   %u\n", num);
+
+    if (index >= dev->max_queues) {
+        vu_panic(dev, "Invalid vring_num index: %u", index);
+        return false;
+    }
+
     dev->vq[index].vring.num = num;
 
     return false;
@@ -1210,7 +1216,7 @@ vu_set_vring_addr_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
     struct vhost_vring_addr addr = vmsg->payload.addr, *vra = &addr;
     unsigned int index = vra->index;
-    VuVirtq *vq = &dev->vq[index];
+    VuVirtq *vq;
 
     DPRINT("vhost_vring_addr:\n");
     DPRINT("    index:  %d\n", vra->index);
@@ -1220,6 +1226,12 @@ vu_set_vring_addr_exec(VuDev *dev, VhostUserMsg *vmsg)
     DPRINT("    avail_user_addr:  0x%016" PRIx64 "\n", (uint64_t)vra->avail_user_addr);
     DPRINT("    log_guest_addr:   0x%016" PRIx64 "\n", (uint64_t)vra->log_guest_addr);
 
+    if (index >= dev->max_queues) {
+        vu_panic(dev, "Invalid vring_addr index: %u", index);
+        return false;
+    }
+
+    vq = &dev->vq[index];
     vq->vra = *vra;
     vq->vring.flags = vra->flags;
     vq->vring.log_guest_addr = vra->log_guest_addr;
@@ -1256,6 +1268,12 @@ vu_set_vring_base_exec(VuDev *dev, VhostUserMsg *vmsg)
 
     DPRINT("State.index: %u\n", index);
     DPRINT("State.num:   %u\n", num);
+
+    if (index >= dev->max_queues) {
+        vu_panic(dev, "Invalid vring_base index: %u", index);
+        return false;
+    }
+
     dev->vq[index].shadow_avail_idx = dev->vq[index].last_avail_idx = num;
 
     return false;
@@ -1267,6 +1285,14 @@ vu_get_vring_base_exec(VuDev *dev, VhostUserMsg *vmsg)
     unsigned int index = vmsg->payload.state.index;
 
     DPRINT("State.index: %u\n", index);
+
+    if (index >= dev->max_queues) {
+        vu_panic(dev, "Invalid vring_base index: %u", index);
+        vmsg->payload.state.num = 0;
+        vmsg->size = sizeof(vmsg->payload.state);
+        return true;
+    }
+
     vmsg->payload.state.num = dev->vq[index].last_avail_idx;
     vmsg->size = sizeof(vmsg->payload.state);
 
-- 
2.47.3


