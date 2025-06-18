Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AA6C71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 06:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRm2m-000231-Sn; Wed, 18 Jun 2025 02:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uRm2j-00022K-HP
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 02:13:06 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uRm2f-0003xF-CF
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 02:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=nXwCnPGmX9a3zqk6iwrJik3YP0RNhYwsicjQY7T/rpA=; b=UNJNmitT/l2YN29hvkoI4t1YBG
 rJxM8kfDHFS9JWNApBdvgzE3XJcBsGSK9GHWQ9IVF5dZmRdd9gtblHxE7iwQxGwy/mzrNyISpiiTF
 Xa5FbwX7SxaCwbt/FoidjzkL/KV6YzlzpcyqY1uTCZZp35z35fYsViquxsB7iyqlYzYh5YXOo2cBW
 AcBV4bnw67Sz77+86Ik5LWc2iIr5arh3WTdIk6os/t9OgG0rVvwN0OCrLNMEmM0f9T+3k9O+lDeIb
 dKNeXeQHohQ2eajL2ufW/viLk9pNMdB0JNvYMztNMbI+qJ6REYPgOdEbXkF2L1BJCsJXLCZ9fLhtz
 WdV0GHR31SxLnUmXTX2qATBWeMcZYhTDIt0kmd96Oo3FOjqznmUBTC06q25jRSPIW7S7mBEOXqst2
 UtZ7xacnTQgukHKfhUv95lFxscCl89VKstSYEwyWBBS2tWgCHiH0TCkoH5GxHPkozJ00bSmk/hRt8
 3hSy3aHVDK04Z0N6Zd8YcmctUHGpCLaYZdNSRPSUQgwnNa2cvBBrgkPGU2fq4KQ+cwG+vU0MQH7IU
 uQKAN/UTCUjKS5goA6QOxZOaTwB8EgxX5emfIQwvqyoHIZn30024XVLYZpqDjS80G6ybFWTAICkJl
 lgXGucnHM8ik8oY2dudA9kSjKYZcd4kJieFCxiUf4=;
Received: from [2a02:8012:2f01:0:737f:96a4:fe2:308c]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uRm1A-0007ok-12; Wed, 18 Jun 2025 07:11:28 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com,
	fam@euphon.net,
	qemu-devel@nongnu.org
Date: Wed, 18 Jun 2025 07:12:48 +0100
Message-Id: <20250618061249.743897-7-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250618061249.743897-1-mark.cave-ayland@ilande.co.uk>
References: <20250618061249.743897-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:737f:96a4:fe2:308c
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 6/7] esp.c: add asc_mode property to indicate the current
 ESP mode
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a new asc_mode property to ESPState which indicates the current mode of
the ESP and update the ESP state machine accordingly.

Bump the vmstate version and include migration logic to ensure that asc_mode
is set to initiator mode such that any commands in progress will always
continue.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c         | 21 ++++++++++++++++++++-
 include/hw/scsi/esp.h |  7 +++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 1c7bad8fc0..4aa58f9e48 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -275,6 +275,7 @@ static int esp_select(ESPState *s)
     if (!s->current_dev) {
         /* No such drive */
         s->rregs[ESP_RSTAT] = 0;
+        s->asc_mode = ESP_ASC_MODE_DIS;
         s->rregs[ESP_RINTR] = INTR_DC;
         esp_raise_irq(s);
         return -1;
@@ -284,6 +285,7 @@ static int esp_select(ESPState *s)
      * Note that we deliberately don't raise the IRQ here: this will be done
      * either in esp_transfer_data() or esp_command_complete()
      */
+    s->asc_mode = ESP_ASC_MODE_INI;
     return 0;
 }
 
@@ -308,6 +310,7 @@ static void do_command_phase(ESPState *s)
     if (!current_lun) {
         /* No such drive */
         s->rregs[ESP_RSTAT] = 0;
+        s->asc_mode = ESP_ASC_MODE_DIS;
         s->rregs[ESP_RINTR] = INTR_DC;
         s->rregs[ESP_RSEQ] = SEQ_0;
         esp_raise_irq(s);
@@ -1102,6 +1105,7 @@ void esp_hard_reset(ESPState *s)
     fifo8_reset(&s->cmdfifo);
     s->dma = 0;
     s->dma_cb = NULL;
+    s->asc_mode = ESP_ASC_MODE_DIS;
 
     s->rregs[ESP_CFG1] = 7;
 }
@@ -1170,6 +1174,7 @@ static void esp_run_cmd(ESPState *s)
         break;
     case CMD_MSGACC:
         trace_esp_mem_writeb_cmd_msgacc(cmd);
+        s->asc_mode = ESP_ASC_MODE_DIS;
         s->rregs[ESP_RINTR] |= INTR_DC;
         s->rregs[ESP_RSEQ] = 0;
         s->rregs[ESP_RFLAGS] = 0;
@@ -1337,6 +1342,14 @@ static bool esp_is_between_version_5_and_6(void *opaque, int version_id)
     return version_id >= 5 && version_id <= 6;
 }
 
+static bool esp_is_version_8(void *opaque, int version_id)
+{
+    ESPState *s = ESP(opaque);
+
+    version_id = MIN(version_id, s->mig_version_id);
+    return version_id >= 8;
+}
+
 int esp_pre_save(void *opaque)
 {
     ESPState *s = ESP(object_resolve_path_component(
@@ -1368,13 +1381,18 @@ static int esp_post_load(void *opaque, int version_id)
         }
     }
 
+    if (version_id < 8) {
+        /* Assume initiator mode to allow all commands to continue */
+        s->asc_mode = ESP_ASC_MODE_INI;
+    }
+
     s->mig_version_id = vmstate_esp.version_id;
     return 0;
 }
 
 const VMStateDescription vmstate_esp = {
     .name = "esp",
-    .version_id = 7,
+    .version_id = 8,
     .minimum_version_id = 3,
     .post_load = esp_post_load,
     .fields = (const VMStateField[]) {
@@ -1406,6 +1424,7 @@ const VMStateDescription vmstate_esp = {
                            esp_is_between_version_5_and_6),
         VMSTATE_UINT8_TEST(lun, ESPState, esp_is_version_6),
         VMSTATE_BOOL(drq_state, ESPState),
+        VMSTATE_UINT8_TEST(asc_mode, ESPState, esp_is_version_8),
         VMSTATE_END_OF_LIST()
     },
 };
diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index c9afcb7cac..6327060c7c 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -14,6 +14,12 @@ typedef void (*ESPDMAMemoryReadWriteFunc)(void *opaque, uint8_t *buf, int len);
 #define ESP_FIFO_SZ 16
 #define ESP_CMDFIFO_SZ 32
 
+enum ESPASCMode {
+    ESP_ASC_MODE_DIS = 0,    /* Disconnected */
+    ESP_ASC_MODE_INI = 1,    /* Initiator */
+    ESP_ASC_MODE_TGT = 2     /* Target */
+};
+
 #define TYPE_ESP "esp"
 OBJECT_DECLARE_SIMPLE_TYPE(ESPState, ESP)
 
@@ -38,6 +44,7 @@ struct ESPState {
     uint8_t cmdfifo_cdb_offset;
     uint8_t lun;
     uint32_t do_cmd;
+    uint8_t asc_mode;
 
     bool data_ready;
     int dma_enabled;
-- 
2.39.5


