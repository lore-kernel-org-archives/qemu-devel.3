Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 656F4CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKTL-00050D-68; Thu, 15 Oct 2026 08:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKTI-0004rs-AM
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKTG-0005Xj-Cc
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792066925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ftEMjTCPBHxRYxwUjhjRcVDB9wdmRD/+znyo8qNYU4s=;
 b=S3chiDHMix7I0KP0tj4E0QgNXEY0dC0T70mLqzgj9U4AEK5CM+ji4rInV+fLqwYFA49Idd
 EigzA6A41hMYXhX3wg+YVNv3lxKENNM1ZGpdIFNnGRrDw6lKCmCIH0onYB3afBLFMyvgr3
 ClaGPsD2oNoEQLEajtvVi7N5EgiLsZQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-ROh4FiA3PQGgt55f96Wj3Q-1; Thu,
 15 Oct 2026 12:22:02 +0000
X-MC-Unique: ROh4FiA3PQGgt55f96Wj3Q-1
X-Mimecast-MFC-AGG-ID: ROh4FiA3PQGgt55f96Wj3Q_1792066921
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 591BE1955F7F; Thu, 15 Oct 2026 12:22:01 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B9F2D7D5; Thu, 15 Oct 2026 12:21:59 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 03/21] hw/nvram/aspeed_otp,
 hw/misc/aspeed_sbc: Consolidate OTP layout definitions
Date: Thu, 15 Oct 2026 14:21:33 +0200
Message-ID: <20261015122151.889017-4-clg@redhat.com>
In-Reply-To: <20261015122151.889017-1-clg@redhat.com>
References: <20261015122151.889017-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kane Chen <kane_chen@aspeedtech.com>

Move the OTP address-space layout definitions from aspeed_sbc.c to
aspeed_otp.h, as they describe the OTP device layout.

Add an aspeed_otp_read() helper to reduce duplicated OTP read code.

Remove the redundant OTP address bounds checks, as invalid accesses
are already handled by the OTP address space.

No functional change.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260918065347.3713868-2-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/nvram/aspeed_otp.h | 13 +++++++++
 hw/misc/aspeed_sbc.c          | 52 +++++++++++------------------------
 2 files changed, 29 insertions(+), 36 deletions(-)

diff --git a/include/hw/nvram/aspeed_otp.h b/include/hw/nvram/aspeed_otp.h
index 375235386079..2b6c2eaaa353 100644
--- a/include/hw/nvram/aspeed_otp.h
+++ b/include/hw/nvram/aspeed_otp.h
@@ -16,6 +16,19 @@
 #define TYPE_ASPEED_OTP "aspeed-otp"
 OBJECT_DECLARE_SIMPLE_TYPE(AspeedOTPState, ASPEED_OTP)
 
+#define OTP_MEMORY_SIZE                 0x4000
+
+/*
+ * The OTP address space is indexed by dword address and is split into
+ * two regions:
+ *
+ *  - [0, OTP_DATA_DWORD_COUNT]: the data region. Each address contains
+ *    64 bits of data.
+ *  - [OTP_DATA_DWORD_COUNT, OTP_MEMORY_SIZE / 4]: the configuration
+ *    region. Each address contains 32 bits of data.
+ */
+#define OTP_DATA_DWORD_COUNT            (0x800)
+
 typedef struct AspeedOTPState {
     DeviceState parent_obj;
 
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
index 5c193d9086ed..3402cef5c3ec 100644
--- a/hw/misc/aspeed_sbc.c
+++ b/hw/misc/aspeed_sbc.c
@@ -66,15 +66,11 @@
 #define QSR_RSA_MASK           (0x3 << 12)
 #define QSR_HASH_MASK          (0x3 << 10)
 
-#define OTP_MEMORY_SIZE 0x4000
 /* OTP command */
 #define SBC_OTP_CMD_READ 0x23b1e361
 #define SBC_OTP_CMD_WRITE 0x23b1e362
 #define SBC_OTP_CMD_PROG 0x23b1e364
 
-#define OTP_DATA_DWORD_COUNT        (0x800)
-#define OTP_TOTAL_DWORD_COUNT       (0x1000)
-
 /* Voltage mode */
 #define MODE_REGISTER               (0x1000)
 #define MODE_REGISTER_A             (0x3000)
@@ -96,43 +92,34 @@ static uint64_t aspeed_sbc_read(void *opaque, hwaddr addr, unsigned int size)
     return s->regs[addr];
 }
 
-static bool aspeed_sbc_otp_read(AspeedSBCState *s,
-                                   uint32_t otp_addr)
+static bool aspeed_otp_read(AspeedSBCState *s, uint32_t otp_addr,
+                             uint32_t *value)
 {
-    MemTxResult ret;
-    AspeedOTPState *otp = &s->otp;
-    uint32_t value, otp_offset;
-    bool is_data = false;
-
-    if (otp_addr < OTP_DATA_DWORD_COUNT) {
-        is_data = true;
-    } else if (otp_addr >= OTP_TOTAL_DWORD_COUNT) {
+    if (address_space_read(&s->otp.as, otp_addr << 2, MEMTXATTRS_UNSPECIFIED,
+                            value, sizeof(*value)) != MEMTX_OK) {
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "Invalid OTP addr 0x%x\n",
+                      "Failed to read OTP memory, addr = %x\n",
                       otp_addr);
         return false;
     }
 
-    otp_offset = otp_addr << 2;
-    ret = address_space_read(&otp->as, otp_offset, MEMTXATTRS_UNSPECIFIED,
-                             &value, sizeof(value));
-    if (ret != MEMTX_OK) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "Failed to read OTP memory, addr = %x\n",
-                      otp_addr);
+    return true;
+}
+
+static bool aspeed_sbc_otp_read(AspeedSBCState *s,
+                                   uint32_t otp_addr)
+{
+    uint32_t value;
+    bool is_data = otp_addr < OTP_DATA_DWORD_COUNT;
+
+    if (!aspeed_otp_read(s, otp_addr, &value)) {
         return false;
     }
     s->regs[R_CAMP1] = value;
     trace_aspeed_sbc_otp_read(otp_addr, value);
 
     if (is_data) {
-        ret = address_space_read(&otp->as, otp_offset + 4,
-                                 MEMTXATTRS_UNSPECIFIED,
-                                 &value, sizeof(value));
-        if (ret != MEMTX_OK) {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "Failed to read OTP memory, addr = %x\n",
-                          otp_addr);
+        if (!aspeed_otp_read(s, otp_addr + 1, &value)) {
             return false;
         }
         s->regs[R_CAMP2] = value;
@@ -181,13 +168,6 @@ static bool aspeed_sbc_otp_prog(AspeedSBCState *s,
     uint32_t value = s->regs[R_CAMP1];
     uint32_t otp_offset = otp_addr << 2;
 
-    if (otp_addr >= OTP_TOTAL_DWORD_COUNT) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "Invalid OTP addr 0x%x\n",
-                      otp_addr);
-        return false;
-    }
-
     ret = address_space_write(&otp->as, otp_offset, MEMTXATTRS_UNSPECIFIED,
                               &value, sizeof(value));
     if (ret != MEMTX_OK) {
-- 
2.56.0


