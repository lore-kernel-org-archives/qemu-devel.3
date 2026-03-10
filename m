Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDA4FCC9C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 05:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzq4s-000761-Dk; Tue, 10 Mar 2026 01:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq4p-00074C-EK
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:56:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq4n-0006Gc-VQ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773122177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YKUDv+C4AC+5FOzoo+6Mo8xYxvLGt2HVce4C3xeF4R4=;
 b=K/tBJzSFva2mTjh5Kp/F7wafHS20xjfM8eEa6t7kfQ/0Krmcym6dHPx5S7ptz32vjaNFgX
 SNzzMT7nlMewEIwqIfbNx/daJnsE0px+N7uTOee6S/synxl7bcpZcBgrmw8KTglsKqbDQH
 RdNgXZC3DaCK4GOUadB+z+35xvf2WF8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-T4BmmDTONhq59xSzFFr_gw-1; Tue,
 10 Mar 2026 01:56:14 -0400
X-MC-Unique: T4BmmDTONhq59xSzFFr_gw-1
X-Mimecast-MFC-AGG-ID: T4BmmDTONhq59xSzFFr_gw_1773122173
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D49E195609F; Tue, 10 Mar 2026 05:56:13 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.69])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 362351956095; Tue, 10 Mar 2026 05:56:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>
Subject: [PULL 10/25] pc-bios/s390-ccw: Remove redundant vring schid attribute
Date: Tue, 10 Mar 2026 06:55:15 +0100
Message-ID: <20260310055530.8893-11-thuth@redhat.com>
In-Reply-To: <20260310055530.8893-1-thuth@redhat.com>
References: <20260310055530.8893-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jared Rossi <jrossi@linux.ibm.com>

The schid is already stored as an attribute of the VDev itself and any other
instances are copies of this same value.  To avoid CCW specific attributes in
the VRing let's just access the existing VDev schid attribute as needed.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Message-ID: <20260309003601.242634-3-jrossi@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/virtio.h        | 3 +--
 pc-bios/s390-ccw/virtio-blkdev.c | 2 +-
 pc-bios/s390-ccw/virtio-net.c    | 2 +-
 pc-bios/s390-ccw/virtio.c        | 9 ++++-----
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 597bd423586..06ba4e45aca 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -103,7 +103,6 @@ struct VRing {
     VRingDesc *desc;
     VRingAvail *avail;
     VRingUsed *used;
-    SubChannelId schid;
     long cookie;
     int id;
 };
@@ -269,7 +268,7 @@ struct VirtioCmd {
 typedef struct VirtioCmd VirtioCmd;
 
 bool vring_notify(VRing *vr);
-int drain_irqs(SubChannelId schid);
+int drain_irqs(void);
 void vring_send_buf(VRing *vr, void *p, int len, int flags);
 int vr_poll(VRing *vr);
 int vring_wait_reply(void);
diff --git a/pc-bios/s390-ccw/virtio-blkdev.c b/pc-bios/s390-ccw/virtio-blkdev.c
index 4b819dd80fb..019c2718b18 100644
--- a/pc-bios/s390-ccw/virtio-blkdev.c
+++ b/pc-bios/s390-ccw/virtio-blkdev.c
@@ -42,7 +42,7 @@ static int virtio_blk_read_many(VDev *vdev, unsigned long sector, void *load_add
     /* Now we can tell the host to read */
     vring_wait_reply();
 
-    if (drain_irqs(vr->schid)) {
+    if (drain_irqs()) {
         /* Well, whatever status is supposed to contain... */
         status = 1;
     }
diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
index 301445bf978..7eb08500695 100644
--- a/pc-bios/s390-ccw/virtio-net.c
+++ b/pc-bios/s390-ccw/virtio-net.c
@@ -88,7 +88,7 @@ int send(int fd, const void *buf, int len, int flags)
     while (!vr_poll(txvq)) {
         yield();
     }
-    if (drain_irqs(txvq->schid)) {
+    if (drain_irqs()) {
         puts("send: drain irqs failed");
         return -1;
     }
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index cd6c99c7e32..f384a990dcc 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -72,14 +72,14 @@ static long virtio_notify(SubChannelId schid, int vq_idx, long cookie)
  *             Virtio functions                *
  ***********************************************/
 
-int drain_irqs(SubChannelId schid)
+int drain_irqs(void)
 {
     Irb irb = {};
     int r = 0;
 
     while (1) {
         /* FIXME: make use of TPI, for that enable subchannel and isc */
-        if (tsch(schid, &irb)) {
+        if (tsch(vdev.schid, &irb)) {
             /* Might want to differentiate error codes later on. */
             if (irb.scsw.cstat) {
                 r = -EIO;
@@ -134,7 +134,7 @@ static void vring_init(VRing *vr, VqInfo *info)
 
 bool vring_notify(VRing *vr)
 {
-    vr->cookie = virtio_notify(vr->schid, vr->id, vr->cookie);
+    vr->cookie = virtio_notify(vdev.schid, vr->id, vr->cookie);
     return vr->cookie >= 0;
 }
 
@@ -211,7 +211,7 @@ int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd)
     } while (cmd[i++].flags & VRING_DESC_F_NEXT);
 
     vring_wait_reply();
-    if (drain_irqs(vr->schid)) {
+    if (drain_irqs()) {
         return -1;
     }
     return 0;
@@ -316,7 +316,6 @@ int virtio_setup_ccw(VDev *vdev)
         }
         info.num = config.num;
         vring_init(&vdev->vrings[i], &info);
-        vdev->vrings[i].schid = vdev->schid;
         if (run_ccw(vdev, CCW_CMD_SET_VQ, &info, sizeof(info), false)) {
             puts("Cannot set VQ info");
             return -EIO;
-- 
2.53.0


