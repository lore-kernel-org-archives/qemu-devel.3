Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE23CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3H8G-0003YG-Dd; Mon, 29 Sep 2025 12:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7Z-0002sx-JJ
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7T-0002mi-Na
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759164778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5zhzEQI/mJiQWtOxY/9yuoeVS95YKqcZUoYAPg8e8tI=;
 b=GDIzHnRTqqFbdyxxpvD3mnCnIIBbafX5mW1umk/RSB6uH21fT7sq0r7yelHRUKYnYO+daL
 CfirNyjsyA+ZOjLkE/GmhA0jtktQ/jCPcw+NUI/ZRCq8fhrfVYfA3owEFuCZNy4F/2W0HW
 JEbbT9nK2/V55LqRXfU+puKoZoMbpZs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-Ld5Nznm_N1uv0K_vw2tQOw-1; Mon,
 29 Sep 2025 12:52:56 -0400
X-MC-Unique: Ld5Nznm_N1uv0K_vw2tQOw-1
X-Mimecast-MFC-AGG-ID: Ld5Nznm_N1uv0K_vw2tQOw_1759164775
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72D7A19560A2; Mon, 29 Sep 2025 16:52:55 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CE4FA1800452; Mon, 29 Sep 2025 16:52:53 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane-Chen-AS <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 08/32] hw/misc/aspeed_sbc: Handle OTP write command for voltage
 mode registers
Date: Mon, 29 Sep 2025 18:52:06 +0200
Message-ID: <20250929165230.797471-9-clg@redhat.com>
In-Reply-To: <20250929165230.797471-1-clg@redhat.com>
References: <20250929165230.797471-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Extend OTP command handling to recognize specific voltage mode register
addresses and emulate the expected hardware behavior. Without this
change, legitimate voltage mode change requests would be incorrectly
reported as "Unknown command" and logged as an error.

This implementation does not perform actual mode changes, but ensures
that valid requests are accepted and ignored as per hardware behavior.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250812094011.2617526-9-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_sbc.c | 41 +++++++++++++++++++++++++++++++++++++++++
 hw/misc/trace-events |  1 +
 2 files changed, 42 insertions(+)

diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
index 787e2d048997..2fc5db749d23 100644
--- a/hw/misc/aspeed_sbc.c
+++ b/hw/misc/aspeed_sbc.c
@@ -49,10 +49,17 @@
 #define OTP_MEMORY_SIZE 0x4000
 /* OTP command */
 #define SBC_OTP_CMD_READ 0x23b1e361
+#define SBC_OTP_CMD_WRITE 0x23b1e362
 #define SBC_OTP_CMD_PROG 0x23b1e364
 
 #define OTP_DATA_DWORD_COUNT        (0x800)
 #define OTP_TOTAL_DWORD_COUNT       (0x1000)
+
+/* Voltage mode */
+#define MODE_REGISTER               (0x1000)
+#define MODE_REGISTER_A             (0x3000)
+#define MODE_REGISTER_B             (0x5000)
+
 static uint64_t aspeed_sbc_read(void *opaque, hwaddr addr, unsigned int size)
 {
     AspeedSBCState *s = ASPEED_SBC(opaque);
@@ -115,6 +122,37 @@ static bool aspeed_sbc_otp_read(AspeedSBCState *s,
     return true;
 }
 
+static bool mode_handler(uint32_t otp_addr)
+{
+    switch (otp_addr) {
+    case MODE_REGISTER:
+    case MODE_REGISTER_A:
+    case MODE_REGISTER_B:
+        /* HW behavior, do nothing here */
+        return true;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Unsupported address 0x%x\n",
+                      otp_addr);
+        return false;
+    }
+}
+
+static bool aspeed_sbc_otp_write(AspeedSBCState *s,
+                                    uint32_t otp_addr)
+{
+    if (otp_addr == 0) {
+        trace_aspeed_sbc_ignore_cmd(otp_addr);
+        return true;
+    } else {
+        if (mode_handler(otp_addr) == false) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
 static bool aspeed_sbc_otp_prog(AspeedSBCState *s,
                                    uint32_t otp_addr)
 {
@@ -157,6 +195,9 @@ static void aspeed_sbc_handle_command(void *opaque, uint32_t cmd)
     case SBC_OTP_CMD_READ:
         ret = aspeed_sbc_otp_read(s, otp_addr);
         break;
+    case SBC_OTP_CMD_WRITE:
+        ret = aspeed_sbc_otp_write(s, otp_addr);
+        break;
     case SBC_OTP_CMD_PROG:
         ret = aspeed_sbc_otp_prog(s, otp_addr);
         break;
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 9e05b82f371e..eeb9243898e9 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -91,6 +91,7 @@ slavio_led_mem_writew(uint32_t val) "Write diagnostic LED 0x%04x"
 slavio_led_mem_readw(uint32_t ret) "Read diagnostic LED 0x%04x"
 
 # aspeed_sbc.c
+aspeed_sbc_ignore_cmd(uint32_t cmd) "Ignoring command 0x%" PRIx32
 aspeed_sbc_handle_cmd(uint32_t cmd, uint32_t addr, bool ret) "Handling command 0x%" PRIx32 " for OTP addr 0x%" PRIx32 " Result: %d"
 aspeed_sbc_otp_read(uint32_t addr, uint32_t value) "OTP Memory read: addr 0x%" PRIx32 " value 0x%" PRIx32
 aspeed_sbc_otp_prog(uint32_t addr, uint32_t value) "OTP Memory write: addr 0x%" PRIx32 " value 0x%" PRIx32
-- 
2.51.0


