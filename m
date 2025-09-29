Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C0ECAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3H8F-0003ZB-Lx; Mon, 29 Sep 2025 12:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7N-0002mb-4R
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7H-0002jo-IC
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759164763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FFc29fyNGAE+jFwfQYhEzS33d1HiUil4QpbEu8+1qL4=;
 b=GwVQneHwArtdFPxDUChZkoxRpYYPfn0aRRyQ3nUCJsd+VN7h1Ymj3qtSTm6TjvBQMpgcJU
 Dyp2CW/YCBPgP/XBjJRVBShCEAv97uLHdKt6n6CMpuhM307b+txtSDd/pUIAEMACz3+wM3
 hOOHuet3vKhFQ6tJMye7VyBJBB6fm4s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-K0ej7S4tOVCHGYA_fRt3Qg-1; Mon,
 29 Sep 2025 12:52:40 -0400
X-MC-Unique: K0ej7S4tOVCHGYA_fRt3Qg-1
X-Mimecast-MFC-AGG-ID: K0ej7S4tOVCHGYA_fRt3Qg_1759164759
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16AF8180057A; Mon, 29 Sep 2025 16:52:39 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E2092180047F; Mon, 29 Sep 2025 16:52:36 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane-Chen-AS <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 02/32] hw/misc/aspeed_sbc: Connect ASPEED OTP memory device to
 SBC
Date: Mon, 29 Sep 2025 18:52:00 +0200
Message-ID: <20250929165230.797471-3-clg@redhat.com>
In-Reply-To: <20250929165230.797471-1-clg@redhat.com>
References: <20250929165230.797471-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

This patch connects the aspeed.otp device to the ASPEED Secure Boot
Controller (SBC) model. It implements OTP memory access via the SBC's
command interface and enables emulation of secure fuse programming
flows.

The following OTP commands are supported:
  - READ: reads a 32-bit word from OTP memory into internal registers
  - PROG: programs a 32-bit word value to the specified OTP address

Trace events are added to observe read/program operations and command
handling flow.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250812094011.2617526-3-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/misc/aspeed_sbc.h |   5 ++
 hw/misc/aspeed_sbc.c         | 111 +++++++++++++++++++++++++++++++++++
 hw/misc/trace-events         |   5 ++
 3 files changed, 121 insertions(+)

diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h
index 405e6782b97a..0c2746d392a4 100644
--- a/include/hw/misc/aspeed_sbc.h
+++ b/include/hw/misc/aspeed_sbc.h
@@ -10,6 +10,7 @@
 #define ASPEED_SBC_H
 
 #include "hw/sysbus.h"
+#include "hw/nvram/aspeed_otp.h"
 
 #define TYPE_ASPEED_SBC "aspeed.sbc"
 #define TYPE_ASPEED_AST2600_SBC TYPE_ASPEED_SBC "-ast2600"
@@ -36,10 +37,14 @@ struct AspeedSBCState {
     MemoryRegion iomem;
 
     uint32_t regs[ASPEED_SBC_NR_REGS];
+
+    AspeedOTPState otp;
 };
 
 struct AspeedSBCClass {
     SysBusDeviceClass parent_class;
+
+    bool has_otp;
 };
 
 #endif /* ASPEED_SBC_H */
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
index a7d101ba71f4..46a038337c31 100644
--- a/hw/misc/aspeed_sbc.c
+++ b/hw/misc/aspeed_sbc.c
@@ -15,9 +15,13 @@
 #include "hw/misc/aspeed_sbc.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
+#include "trace.h"
 
 #define R_PROT          (0x000 / 4)
+#define R_CMD           (0x004 / 4)
+#define R_ADDR          (0x010 / 4)
 #define R_STATUS        (0x014 / 4)
+#define R_CAMP1         (0x020 / 4)
 #define R_QSR           (0x040 / 4)
 
 /* R_STATUS */
@@ -41,6 +45,11 @@
 #define QSR_RSA_MASK           (0x3 << 12)
 #define QSR_HASH_MASK          (0x3 << 10)
 
+#define OTP_MEMORY_SIZE 0x4000
+/* OTP command */
+#define SBC_OTP_CMD_READ 0x23b1e361
+#define SBC_OTP_CMD_PROG 0x23b1e364
+
 static uint64_t aspeed_sbc_read(void *opaque, hwaddr addr, unsigned int size)
 {
     AspeedSBCState *s = ASPEED_SBC(opaque);
@@ -57,6 +66,84 @@ static uint64_t aspeed_sbc_read(void *opaque, hwaddr addr, unsigned int size)
     return s->regs[addr];
 }
 
+static bool aspeed_sbc_otp_read(AspeedSBCState *s,
+                                   uint32_t otp_addr)
+{
+    MemTxResult ret;
+    AspeedOTPState *otp = &s->otp;
+    uint32_t value, otp_offset;
+
+    otp_offset = otp_addr << 2;
+    ret = address_space_read(&otp->as, otp_offset, MEMTXATTRS_UNSPECIFIED,
+                             &value, sizeof(value));
+    if (ret != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Failed to read OTP memory, addr = %x\n",
+                      otp_addr);
+        return false;
+    }
+    s->regs[R_CAMP1] = value;
+    trace_aspeed_sbc_otp_read(otp_addr, value);
+
+    return true;
+}
+
+static bool aspeed_sbc_otp_prog(AspeedSBCState *s,
+                                   uint32_t otp_addr)
+{
+    MemTxResult ret;
+    AspeedOTPState *otp = &s->otp;
+    uint32_t value = s->regs[R_CAMP1];
+
+    ret = address_space_write(&otp->as, otp_addr, MEMTXATTRS_UNSPECIFIED,
+                        &value, sizeof(value));
+    if (ret != MEMTX_OK) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Failed to write OTP memory, addr = %x\n",
+                      otp_addr);
+        return false;
+    }
+
+    trace_aspeed_sbc_otp_prog(otp_addr, value);
+
+    return true;
+}
+
+static void aspeed_sbc_handle_command(void *opaque, uint32_t cmd)
+{
+    AspeedSBCState *s = ASPEED_SBC(opaque);
+    AspeedSBCClass *sc = ASPEED_SBC_GET_CLASS(opaque);
+    bool ret = false;
+    uint32_t otp_addr;
+
+    if (!sc->has_otp) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: OTP memory is not supported\n",
+                      __func__);
+        return;
+    }
+
+    s->regs[R_STATUS] &= ~(OTP_MEM_IDLE | OTP_IDLE);
+    otp_addr = s->regs[R_ADDR];
+
+    switch (cmd) {
+    case SBC_OTP_CMD_READ:
+        ret = aspeed_sbc_otp_read(s, otp_addr);
+        break;
+    case SBC_OTP_CMD_PROG:
+        ret = aspeed_sbc_otp_prog(s, otp_addr);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Unknown command 0x%x\n",
+                      __func__, cmd);
+        break;
+    }
+
+    trace_aspeed_sbc_handle_cmd(cmd, otp_addr, ret);
+    s->regs[R_STATUS] |= (OTP_MEM_IDLE | OTP_IDLE);
+}
+
 static void aspeed_sbc_write(void *opaque, hwaddr addr, uint64_t data,
                               unsigned int size)
 {
@@ -78,6 +165,9 @@ static void aspeed_sbc_write(void *opaque, hwaddr addr, uint64_t data,
                       "%s: write to read only register 0x%" HWADDR_PRIx "\n",
                       __func__, addr << 2);
         return;
+    case R_CMD:
+        aspeed_sbc_handle_command(opaque, data);
+        return;
     default:
         break;
     }
@@ -115,10 +205,30 @@ static void aspeed_sbc_reset(DeviceState *dev)
     s->regs[R_QSR] = s->signing_settings;
 }
 
+static void aspeed_sbc_instance_init(Object *obj)
+{
+    AspeedSBCClass *sc = ASPEED_SBC_GET_CLASS(obj);
+    AspeedSBCState *s = ASPEED_SBC(obj);
+
+    if (sc->has_otp) {
+        object_initialize_child(OBJECT(s), "otp", &s->otp,
+                                TYPE_ASPEED_OTP);
+    }
+}
+
 static void aspeed_sbc_realize(DeviceState *dev, Error **errp)
 {
     AspeedSBCState *s = ASPEED_SBC(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    AspeedSBCClass *sc = ASPEED_SBC_GET_CLASS(dev);
+
+    if (sc->has_otp) {
+        object_property_set_int(OBJECT(&s->otp), "size",
+                                OTP_MEMORY_SIZE, &error_abort);
+        if (!qdev_realize(DEVICE(&s->otp), NULL, errp)) {
+            return;
+        }
+    }
 
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sbc_ops, s,
             TYPE_ASPEED_SBC, 0x1000);
@@ -155,6 +265,7 @@ static const TypeInfo aspeed_sbc_info = {
     .name = TYPE_ASPEED_SBC,
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(AspeedSBCState),
+    .instance_init = aspeed_sbc_instance_init,
     .class_init = aspeed_sbc_class_init,
     .class_size = sizeof(AspeedSBCClass)
 };
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index e3f64c0ff6b0..9e05b82f371e 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -90,6 +90,11 @@ slavio_sysctrl_mem_readl(uint32_t ret) "Read system control 0x%08x"
 slavio_led_mem_writew(uint32_t val) "Write diagnostic LED 0x%04x"
 slavio_led_mem_readw(uint32_t ret) "Read diagnostic LED 0x%04x"
 
+# aspeed_sbc.c
+aspeed_sbc_handle_cmd(uint32_t cmd, uint32_t addr, bool ret) "Handling command 0x%" PRIx32 " for OTP addr 0x%" PRIx32 " Result: %d"
+aspeed_sbc_otp_read(uint32_t addr, uint32_t value) "OTP Memory read: addr 0x%" PRIx32 " value 0x%" PRIx32
+aspeed_sbc_otp_prog(uint32_t addr, uint32_t value) "OTP Memory write: addr 0x%" PRIx32 " value 0x%" PRIx32
+
 # aspeed_scu.c
 aspeed_scu_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
 aspeed_scu_read(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
-- 
2.51.0


