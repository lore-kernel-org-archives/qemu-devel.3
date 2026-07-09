Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46059C44501
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 19:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whuJg-0007y1-2x; Thu, 09 Jul 2026 15:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1whuJe-0007xa-Pg
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 15:21:46 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1whuJd-0000Jg-2V
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 15:21:46 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 75CE66137F;
 Thu,  9 Jul 2026 19:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C826C2BCB9;
 Thu,  9 Jul 2026 19:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1783624903;
 bh=OQ4jDpWxpVpXagJKOm774h/ds1V54ud4Jr55qb8XJvE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=ko6cjZ1imK1md/uJBOky6Norb9+7/a2NHx4pN4Otz1/rlKqrkporWwXxDqb9Ty84V
 Gi5F6P0tKU8qjPrk1qW1BbYmZThpWhF5qlmZA3PKtbi7XF4KOObp1BrGLjNPmId9C8
 lrCvhhJsLkZufowlnHn2FmuqFiuFTH0LDZLb1YeEGFSGxzIO471RGYzWxlz1K3g0EW
 KFrW64lX0Q75+zERKNSProMeUINf3aIQi6QwwxXhwdVRkE6xIYxgzol4vcEVg1zjgH
 5OSoygiBKH+1FEQ7qB3km4S0Gl4XLaSkuz++bmV0dchxlKc+eCh5lYtPo6QWoYuaGb
 7j7eutv7EjrwQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8BBC44501;
 Thu,  9 Jul 2026 19:21:43 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Fri, 10 Jul 2026 03:21:39 +0800
Subject: [PATCH v3 1/2] pvscsi: translate data endianness
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260710-pvscsi-endianness-v3-1-27fe1c4d1f6e@gmail.com>
References: <20260710-pvscsi-endianness-v3-0-27fe1c4d1f6e@gmail.com>
In-Reply-To: <20260710-pvscsi-endianness-v3-0-27fe1c4d1f6e@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Arvind Kumar <arvindkumar@vmware.com>,
 Miao Wang <shankerwangmiao@gmail.com>, b4-sent@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5837;
 i=shankerwangmiao@gmail.com; s=20250715; h=from:subject:message-id;
 bh=Vtzl53Dchej3yHb9Ld8X3NJHlagwl+ff+BQxJZP/l80=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBqT/TFiYM04DlsC4snzelijrh7wWRbXUMSXMTj/
 A3K8iM+r2OJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCak/0xQAKCRCwMePKe/7Z
 bjaPEADRbsuI+SPKF4UDPYFD4R093DotTG5Q6atYpjdHH8KQCcboV4wMogAR81nZhOkg1l5Ikvu
 0x7/tEMVKohzkruQ5Fitwhf1xt82a/rLiEf8jQBjPSK7XULaFUzY5Rdbnvs9bY5wl1pxMJa2knh
 Ye6uu4B63tdVGJMA+JMCaCqNLBFOir8A3I0YJe86WQXGNe179hGKeXBqr9K2wGFzHF9rkSoRXXJ
 ALA6TgEsQCbKE62gifR9JuNwS/AYfZVdSnFWe0QYGWTNDRGs/yOGVTPKepCUX04EGO0//cM/dpS
 FFIWgML6og4MEJJhbnHkpYQlkG08MF5rBlET/xWcUKyLvRdd0Svi1AIFpWXr9Mw20Bbg1Ey6Sy+
 cn1IcoFpcyvnUz5ynChDFX84Ah5mUNCHyNjNE0i8lODEDcfsX8zRimF+04kLloQVD8agdIvYwgo
 G2RWwX08B58VdnPrLmXGxy4jwSFrotcZDJherO0BJjxePYPNjPJ8w/Uw7uCFyUI6xNGDGu2cvZR
 YbPiYIuX3Q2aE5tAxK3fjbs0KMWEwM/Pmd2uyu4QmzEzVdYXniYmJds+lI+wTDaFYr3yey369kH
 YVc+ghXNQuvrShTOZ3fQoOlNJ/LmboPtz2B97HBL4TcgeaeV7emSG2O0b/nnpmgEgMy8/BGJyVF
 QcphNz5F4HdTdIQ==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/20250715
 with auth_id=462
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Received-SPF: pass client-ip=172.105.4.254;
 envelope-from=devnull+shankerwangmiao.gmail.com@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FORGED_REPLYTO=2.095, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: shankerwangmiao@gmail.com
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
---
 hw/scsi/vmw_pvscsi.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 11ae6b9b7474b9bc87621137eb7911361b5fd721..687119394d3d3346935054180a94a67e2b490459 100644
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
2.49.0



