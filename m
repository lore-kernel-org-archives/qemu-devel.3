Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9169C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAND-0003oU-0H; Wed, 12 Aug 2026 10:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuALu-00014n-Ri; Wed, 12 Aug 2026 10:54:47 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuALp-0007Un-U2; Wed, 12 Aug 2026 10:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546232; bh=OnUQe6/rj299sZ5vaOOpySJvKJclMx9JJNtqpm/Qbm8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fvqV1zxzoik0lNmCo1KktJDpyjy61X4SXUstoXHZV/ah5V2LJE2YTl0IFwFQroUwT
 HoC92EibJ8cTPAkD5xxhiyylzsGIAnGTahaXD0RhS16jX8EKBoBKqfX7oh49pe4roq
 YJFODMI9jou1Y2cc1fQzXcHNu1Mn2GhouxQ5g0ZCkitPotLdJl97m8iVUn8n6rB0LM
 lZcC6BrCFuXFJQbf49rzdTk33dhxf91vTHGosB1w0fTAllftJarw5FBuf6vIKprbGX
 1wK4miN6NYp4BhPkTKe8b/EaA4UWIpF7ZltlW1ZM7q6PlBDhPQF7MHCFjjr6SpIwiR
 r0rDRtfSnSZQg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0E6C61CA634;
 Wed, 12 Aug 2026 17:50:32 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 697C3409D76;
 Wed, 12 Aug 2026 17:50:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C78782F9C3; Wed, 12 Aug 2026 17:50:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael S. Tsirkin <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, xlabai <xlabai@tencent.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 048/120] libvhost-user: protect against OOB writes in
 vu_set_inflight_fd
Date: Wed, 12 Aug 2026 17:48:31 +0300
Message-ID: <20260812144955.649205-48-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
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

vu_set_inflight_fd() trusts the num_queues value from the
VHOST_USER_SET_INFLIGHT_FD message without checking it against
dev->max_queues, so an oversized value causes out-of-bounds writes to
dev->vq.

Front end is generally trusted so not a security problem, but OOB isn't
a nice way to handle frontend bugs.  Let's harden this a bit:
check num_queues and panic if it's invalid.

Fixes: 5f9ff1eff3 ("libvhost-user: Support tracking inflight I/O in shared memory")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3740
Cc: Stefano Garzarella <sgarzare@redhat.com>
Reported-by: xlabai <xlabai@tencent.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <23b3f12388c1035f208550df9de9944c22d8d534.1784899127.git.mst@redhat.com>
(cherry picked from commit fbdfdbb9920cb69408d53cb86a8e079a2054581e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 014d2107489..bdaa6917f19 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1919,6 +1919,8 @@ vu_get_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
 
     if (vmsg->size != sizeof(vmsg->payload.inflight)) {
         vu_panic(dev, "Invalid get_inflight_fd message:%d", vmsg->size);
+        vmsg_close_fds(vmsg);
+        vmsg->fd_num = 0;
         vmsg->payload.inflight.mmap_size = 0;
         return true;
     }
@@ -1926,6 +1928,15 @@ vu_get_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
     num_queues = vmsg->payload.inflight.num_queues;
     queue_size = vmsg->payload.inflight.queue_size;
 
+    if (num_queues > dev->max_queues) {
+        vu_panic(dev, "Invalid get_inflight_fd num_queues: %"PRId16,
+                 num_queues);
+        vmsg_close_fds(vmsg);
+        vmsg->fd_num = 0;
+        vmsg->payload.inflight.mmap_size = 0;
+        return true;
+    }
+
     DPRINT("set_inflight_fd num_queues: %"PRId16"\n", num_queues);
     DPRINT("set_inflight_fd queue_size: %"PRId16"\n", queue_size);
 
@@ -1973,6 +1984,7 @@ vu_set_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
         vmsg->size != sizeof(vmsg->payload.inflight)) {
         vu_panic(dev, "Invalid set_inflight_fd message size:%d fds:%d",
                  vmsg->size, vmsg->fd_num);
+        vmsg_close_fds(vmsg);
         return false;
     }
 
@@ -1982,6 +1994,13 @@ vu_set_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
     num_queues = vmsg->payload.inflight.num_queues;
     queue_size = vmsg->payload.inflight.queue_size;
 
+    if (num_queues > dev->max_queues) {
+        vu_panic(dev, "Invalid set_inflight_fd num_queues: %"PRId16,
+                 num_queues);
+        close(fd);
+        return false;
+    }
+
     DPRINT("set_inflight_fd mmap_size: %"PRId64"\n", mmap_size);
     DPRINT("set_inflight_fd mmap_offset: %"PRId64"\n", mmap_offset);
     DPRINT("set_inflight_fd num_queues: %"PRId16"\n", num_queues);
@@ -1992,6 +2011,7 @@ vu_set_inflight_fd(VuDev *dev, VhostUserMsg *vmsg)
 
     if (rc == MAP_FAILED) {
         vu_panic(dev, "set_inflight_fd mmap error: %s", strerror(errno));
+        close(fd);
         return false;
     }
 
-- 
2.47.3


