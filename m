Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F158C4453C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWSi-00051h-QL; Wed, 22 Jul 2026 08:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWRQ-0002iW-8M; Wed, 22 Jul 2026 08:52:58 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWRO-0002UU-DN; Wed, 22 Jul 2026 08:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724574; bh=Z9NovRRrrRmFzzj+x4ZTSGZ4L134vAH+bgIVVCzD93s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iUa19B6wfo+Jt/+gysYeN0ALBEihxdzVz+A99AZqLnwHMdl91KXYYkaYlj/23WvFR
 fHBC/QBs3Keq436uZqbtZAYcE4dQh1AhBn4nG7vhYYHg1WCqDTzAZi2UoOAvSmAGZk
 h3le8Jedd9VAgPqDdCJlYOZMF8RgAyqI/Eww+aoJXiTw3dGkH7DohX96xpP6ix7GFg
 h1nCfDU0rc7dGOaSqeNLgrRDdQTUAkJLUrBrkal+6S1nn4ni7gMkfi9vlREDBFvI4e
 ClyGwJjnZ8K7wWsAwqyLWJ40ZGn/ja40g1l0qQg9Fc+qplRgsg4roVRuKDnZx4WjBM
 4qvBe8hD4JLQQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D5D1F1C3B3F;
 Wed, 22 Jul 2026 15:49:34 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2966B3F378F;
 Wed, 22 Jul 2026 15:49:52 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id BA3D117F53; Wed, 22 Jul 2026 15:49:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Miao Wang <shankerwangmiao@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 v2 098/127] hw/scsi/vmw_pvscsi: translate data
 endianness
Date: Wed, 22 Jul 2026 15:48:23 +0300
Message-ID: <20260722124859.32371-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Miao Wang <shankerwangmiao@gmail.com>

This patch improves the implementation of the pvscsi device by
translating the endianness of the data sent or received from the guest.
This ensures pvscsi can work on big-endian hosts with little-endian
guests.

This patch assumes, although not having found any specifications, that
the pvscsi device is little-endian, since pvscsi seems to be used only
on x86 platforms, which are little-endian.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
Message-ID: <20260710-pvscsi-endianness-v3-1-27fe1c4d1f6e@gmail.com>
[PMD: Rebased on top of commit cb30b8758d4 physmem API conversion]
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 5a811329bde78fc223abc384c85b0f62e3b34f7c)
(Mjt: re-rebased to before commit cb30b8758d4 physmem API conversion)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 11ae6b9b747..687119394d3 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -392,9 +392,18 @@ static void
 pvscsi_cmp_ring_put(PVSCSIState *s, struct PVSCSIRingCmpDesc *cmp_desc)
 {
     hwaddr cmp_descr_pa;
+    PVSCSIRingCmpDesc cmp_desc_conv;
 
     cmp_descr_pa = pvscsi_ring_pop_cmp_descr(&s->rings);
     trace_pvscsi_cmp_ring_put(cmp_descr_pa);
+    cmp_desc_conv = (struct PVSCSIRingCmpDesc) {
+        .context = cpu_to_le64(cmp_desc->context),
+        .dataLen = cpu_to_le64(cmp_desc->dataLen),
+        .senseLen = cpu_to_le32(cmp_desc->senseLen),
+        .hostStatus = cpu_to_le16(cmp_desc->hostStatus),
+        .scsiStatus = cpu_to_le16(cmp_desc->scsiStatus),
+    };
+    cmp_desc = &cmp_desc_conv;
     cpu_physical_memory_write(cmp_descr_pa, cmp_desc, sizeof(*cmp_desc));
 }
 
@@ -402,9 +411,18 @@ static void
 pvscsi_msg_ring_put(PVSCSIState *s, struct PVSCSIRingMsgDesc *msg_desc)
 {
     hwaddr msg_descr_pa;
+    PVSCSIRingMsgDesc msg_desc_conv;
+    int i;
 
     msg_descr_pa = pvscsi_ring_pop_msg_descr(&s->rings);
     trace_pvscsi_msg_ring_put(msg_descr_pa);
+    msg_desc_conv = (PVSCSIRingMsgDesc) {
+        .type = cpu_to_le32(msg_desc->type),
+    };
+    for (i = 0; i < ARRAY_SIZE(msg_desc->args); i++) {
+        msg_desc_conv.args[i] = cpu_to_le32(msg_desc->args[i]);
+    }
+    msg_desc = &msg_desc_conv;
     cpu_physical_memory_write(msg_descr_pa, msg_desc, sizeof(*msg_desc));
 }
 
@@ -481,6 +499,9 @@ pvscsi_get_next_sg_elem(PVSCSISGState *sg)
     struct PVSCSISGElement elem;
 
     cpu_physical_memory_read(sg->elemAddr, &elem, sizeof(elem));
+    elem.addr = le64_to_cpu(elem.addr);
+    elem.length = le32_to_cpu(elem.length);
+    elem.flags = le32_to_cpu(elem.flags);
     if ((elem.flags & ~PVSCSI_KNOWN_FLAGS) != 0) {
         /*
             * There is PVSCSI_SGE_FLAG_CHAIN_ELEMENT flag described in
@@ -759,6 +780,12 @@ pvscsi_process_io(PVSCSIState *s)
 
         trace_pvscsi_process_io(next_descr_pa);
         cpu_physical_memory_read(next_descr_pa, &descr, sizeof(descr));
+        descr.context = le64_to_cpu(descr.context);
+        descr.dataAddr = le64_to_cpu(descr.dataAddr);
+        descr.dataLen = le64_to_cpu(descr.dataLen);
+        descr.senseAddr = le64_to_cpu(descr.senseAddr);
+        descr.senseLen = le32_to_cpu(descr.senseLen);
+        descr.flags = le32_to_cpu(descr.flags);
         pvscsi_process_request_descriptor(s, &descr);
     }
 
@@ -808,6 +835,17 @@ pvscsi_on_cmd_setup_rings(PVSCSIState *s)
 {
     PVSCSICmdDescSetupRings *rc =
         (PVSCSICmdDescSetupRings *) s->curr_cmd_data;
+    PVSCSICmdDescSetupRings translated;
+    int i;
+
+    translated.reqRingNumPages = le32_to_cpu(rc->reqRingNumPages);
+    translated.cmpRingNumPages = le32_to_cpu(rc->cmpRingNumPages);
+    translated.ringsStatePPN = le64_to_cpu(rc->ringsStatePPN);
+    for (i = 0; i < PVSCSI_SETUP_RINGS_MAX_NUM_PAGES; i++) {
+        translated.reqRingPPNs[i] = le64_to_cpu(rc->reqRingPPNs[i]);
+        translated.cmpRingPPNs[i] = le64_to_cpu(rc->cmpRingPPNs[i]);
+    }
+    rc = &translated;
 
     trace_pvscsi_on_cmd_arrived("PVSCSI_CMD_SETUP_RINGS");
 
@@ -831,6 +869,11 @@ pvscsi_on_cmd_abort(PVSCSIState *s)
     PVSCSICmdDescAbortCmd *cmd = (PVSCSICmdDescAbortCmd *) s->curr_cmd_data;
     PVSCSIRequest *r, *next;
 
+    PVSCSICmdDescAbortCmd translated = *cmd;
+    translated.context = le32_to_cpu(cmd->context);
+    translated.target = le32_to_cpu(cmd->target);
+    cmd = &translated;
+
     trace_pvscsi_on_cmd_abort(cmd->context, cmd->target);
 
     QTAILQ_FOREACH_SAFE(r, &s->pending_queue, next, next) {
@@ -862,6 +905,10 @@ pvscsi_on_cmd_reset_device(PVSCSIState *s)
         (struct PVSCSICmdDescResetDevice *) s->curr_cmd_data;
     SCSIDevice *sdev;
 
+    PVSCSICmdDescResetDevice translated = *cmd;
+    translated.target = le32_to_cpu(cmd->target);
+    cmd = &translated;
+
     sdev = pvscsi_device_find(s, 0, cmd->target, cmd->lun, &target_lun);
 
     trace_pvscsi_on_cmd_reset_dev(cmd->target, (int) target_lun, sdev);
@@ -892,6 +939,14 @@ pvscsi_on_cmd_setup_msg_ring(PVSCSIState *s)
 {
     PVSCSICmdDescSetupMsgRing *rc =
         (PVSCSICmdDescSetupMsgRing *) s->curr_cmd_data;
+    PVSCSICmdDescSetupMsgRing translated = *rc;
+    int i;
+
+    translated.numPages = le32_to_cpu(rc->numPages);
+    for (i = 0; i < PVSCSI_SETUP_MSG_RING_MAX_NUM_PAGES; i++) {
+        translated.ringPPNs[i] = le64_to_cpu(rc->ringPPNs[i]);
+    }
+    rc = &translated;
 
     trace_pvscsi_on_cmd_arrived("PVSCSI_CMD_SETUP_MSG_RING");
 
@@ -994,7 +1049,7 @@ pvscsi_on_command_data(PVSCSIState *s, uint32_t value)
     size_t bytes_arrived = s->curr_cmd_data_cntr * sizeof(uint32_t);
 
     assert(bytes_arrived < sizeof(s->curr_cmd_data));
-    s->curr_cmd_data[s->curr_cmd_data_cntr++] = value;
+    s->curr_cmd_data[s->curr_cmd_data_cntr++] = cpu_to_le32(value);
 
     pvscsi_do_command_processing(s);
 }
-- 
2.47.3


