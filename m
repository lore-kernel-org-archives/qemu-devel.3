Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01BCC5CFEB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuSA6-0006EY-ME; Thu, 13 Aug 2026 05:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wuS9s-0006Cb-K5
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 05:55:39 -0400
Received: from [115.124.30.110] (helo=out30-110.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wuS9p-0005sq-HU
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 05:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1786614904; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=pHGjh55usKOPqSNHUu914m1Rda0mEK2+CbO6sTSHggY=;
 b=aJkHkGxwsERDTcMcxy+ZHf71fms/xErlVayiVPVVQx8TD9Lwjukk5e6YvTqBnllHv9jAmg/t8V/cS+RVp0tZlnAfUV9HrqftUF1lQqH6ydoXeiXcB6nRR4zW0/U3cEithKKj4rb/PCKVKgaO3xHnv/qwPHZVh+ar/PPMJ0qJlMg=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam011083073210;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0X8u77Qj_1786614903; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X8u77Qj_1786614903 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 13 Aug 2026 17:55:03 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 1/2] libvhost-user: accept the postcopy client base ack in
 vu_add_mem_reg()
Date: Thu, 13 Aug 2026 17:55:00 +0800
Message-ID: <20260813095501.20282-2-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260813095501.20282-1-guobin@linux.alibaba.com>
References: <20260813095501.20282-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.110 (deferred)
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

In postcopy mode QEMU signals that it has collected all the postcopy client
bases by sending a VHOST_USER_ADD_MEM_REG message with a u64 payload of 0
and no file descriptor (see vhost_user_add_remove_regions()).
vu_add_mem_reg() has a case for that message, but only reaches it after
validating the fd count of a regular region, so the ack is rejected first:

  VHOST_USER_ADD_MEM_REG received 0 fds - only 1 fd should be sent for
  this message type

This kills the backend during memory table setup, making postcopy unusable
for any libvhost-user backend that negotiates
VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS.

Recognise the ack before validating the fd count.

Fixes: 9f4e63491b ("libvhost-user: Add vu_add_mem_reg input validation")
Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 subprojects/libvhost-user/libvhost-user.c | 26 ++++++++++++-----------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index a74d814bb4..248550aae1 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -948,6 +948,20 @@ static bool
 vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
     VhostUserMemoryRegion m = vmsg->payload.memreg.region, *msg_region = &m;
 
+    /*
+     * If we are in postcopy mode and we receive a u64 payload with a 0 value
+     * we know all the postcopy client bases have been received, and we
+     * should start generating faults.  This message carries no file
+     * descriptor, so it has to be recognised before the fd count of a real
+     * region is validated below.
+     */
+    if (dev->postcopy_listening &&
+        vmsg->size == sizeof(vmsg->payload.u64) &&
+        vmsg->payload.u64 == 0) {
+        (void)generate_faults(dev);
+        return false;
+    }
+
     if (vmsg->fd_num != 1) {
         vmsg_close_fds(vmsg);
         vu_panic(dev, "VHOST_USER_ADD_MEM_REG received %d fds - only 1 fd "
@@ -971,18 +985,6 @@ vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
         return false;
     }
 
-    /*
-     * If we are in postcopy mode and we receive a u64 payload with a 0 value
-     * we know all the postcopy client bases have been received, and we
-     * should start generating faults.
-     */
-    if (dev->postcopy_listening &&
-        vmsg->size == sizeof(vmsg->payload.u64) &&
-        vmsg->payload.u64 == 0) {
-        (void)generate_faults(dev);
-        return false;
-    }
-
     _vu_add_mem_reg(dev, msg_region, vmsg->fds[0]);
     close(vmsg->fds[0]);
 
-- 
2.50.1 (Apple Git-155)


