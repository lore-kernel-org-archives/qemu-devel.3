Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991A9C5CFDB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 09:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuSA5-0006EM-KX; Thu, 13 Aug 2026 05:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wuS9u-0006Cm-EU
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 05:55:39 -0400
Received: from [115.124.30.112] (helo=out30-112.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wuS9r-0005sx-OL
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 05:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1786614904; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=40y1RV1ifjLY5kLqdvBtOkbrea1HokAB7lurYvj6RQE=;
 b=fxYpCTLknncvUeY2NlODFO4XpocdKITcjKUIhtQi/KHkyS7QBCuO56V9NVUrlINgYXyYcMX0S0D4FCkS7UgEPqLIPB4vUOVHFlX4l/a5UE/6qmiHZKbpAk6gXMFe96oewEBxzKgSaRZj7TFBTYJsmJV28Ot4sUF6Phy+p6Q1Hcc=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0X8u77R7_1786614904; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X8u77R7_1786614904 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 13 Aug 2026 17:55:04 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 2/2] libvhost-user: return the backend mapping address for
 added regions
Date: Thu, 13 Aug 2026 17:55:01 +0800
Message-ID: <20260813095501.20282-3-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260813095501.20282-1-guobin@linux.alibaba.com>
References: <20260813095501.20282-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.112 (deferred)
Received-SPF: pass client-ip=115.124.30.112;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-112.freemail.mail.aliyun.com
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

In postcopy mode the backend must tell QEMU where it mapped a region, so
that QEMU can translate the backend's fault addresses back into a RAMBlock
and offset.  vu_add_mem_reg() works on a copy of the region and lets
_vu_add_mem_reg() fill the mapping address into that copy, but never writes
it back into the reply payload.  QEMU then stores its own address as the
postcopy client base, so fault resolution fails:

  vhost_user_postcopy_fault_handler: Failed to find region for fault ...

The VHOST_USER_SET_MEM_TABLE path is unaffected, it fills the payload
directly.  Put the updated region back into the payload before replying; a
pointer into the payload cannot be used instead, as VhostUserMsg is packed.

Fixes: ec94c8e621 ("Support adding individual regions in libvhost-user")
Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 subprojects/libvhost-user/libvhost-user.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 248550aae1..2fed792e85 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -989,7 +989,13 @@ vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
     close(vmsg->fds[0]);
 
     if (dev->postcopy_listening) {
-        /* Send the message back to qemu with the addresses filled in. */
+        /*
+         * Send the message back to qemu with the addresses filled in.
+         * _vu_add_mem_reg() worked on our copy of the region, so it has to be
+         * put back into the message payload.  A pointer into the payload
+         * cannot be handed out instead, VhostUserMsg is packed.
+         */
+        vmsg->payload.memreg.region = m;
         vmsg->fd_num = 0;
         DPRINT("Successfully added new region in postcopy\n");
         return true;
-- 
2.50.1 (Apple Git-155)


