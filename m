Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D783E6F08E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 22:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6zhm-0004Ml-HE; Fri, 01 Nov 2024 18:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t6zhi-0004Ly-CG
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 18:01:14 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t6zhg-0002ou-P4
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 18:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=/uYBu+gUI1nuecU2A3hb7azcbIn5ZKJLuhQ4Mw9pBDM=; b=S9IfIu9AuM0VAAv7y4jFE2J2dc
 fPXG5LOcPdskjw3R/Ws87A1RQeE4g0xZSb0JJdD6ES/R+xomUo2ZLlCS5bGlZyX9MzDk0oyzFl+9F
 5X3xmbbM0ptCsjZ6ZQxnuHf+kXmrfe2Id4RgQUufcE4RT5Ii2tcogyU+Y5BAK1nhVKat6yPyoYe+V
 YCIztvlNOJqoDZScZwVaFnEdhqMxESh1dipX2GJENfCO4idUruHRB4nFFS072u4woN7ZA5XD7McpY
 MBL3CHnPk3mq38BqI9EsBabg+MxhHGPeamwEIMvG+WSIRq9DxuAoNA9cdCMI5XlZbSscqZZfKfBrv
 li6fW6SHz/8e/htUa1smDMUu36rXXDdA35Ks6TYlehj210G3YnKdiiKQgmf7xTVuRI96fOOdAtfNx
 uC7OS7rnfKn8QyNZ47GC4M42HVNDr47upygJvmJI/LsA3jTnrPv3L53ncO+FANT4+3XmJIVCboNxO
 TWpr6Di3m4+ZBhJogNGw9u8i0UqAxSJ93J2aaq5eYcB6br7xJvFdLl0psRuEvErSMs31EwMi+i7C0
 PDedLhMCLY2i1NsesN7RmAe074xNupVeeQfXNggY6MhFUdgfeGFBrFMUQlFEBUI/K5GiBzBhLM+oh
 aXbchEmHUsvaJxXgmAW7kXl1sJ28Of7jbK43WGBjo=;
Received: from [2a00:23c4:8bb8:f600:91a1:336d:3931:745]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t6zhL-0002pk-4t; Fri, 01 Nov 2024 22:00:51 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com,
	fam@euphon.net,
	qemu-devel@nongnu.org
Date: Fri,  1 Nov 2024 22:00:51 +0000
Message-Id: <20241101220052.1463805-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241101220052.1463805-1-mark.cave-ayland@ilande.co.uk>
References: <20241101220052.1463805-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:f600:91a1:336d:3931:745
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 4/5] esp.c: add asc_mode property to indicate the current ESP
 mode
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
 include/hw/scsi/esp.h |  8 ++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 36e92dcd7b..3370546287 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -278,6 +278,7 @@ static int esp_select(ESPState *s)
     if (!s->current_dev) {
         /* No such drive */
         s->rregs[ESP_RSTAT] = 0;
+        s->asc_mode = ESP_ASC_MODE_DIS;
         s->rregs[ESP_RINTR] = INTR_DC;
         esp_raise_irq(s);
         return -1;
@@ -287,6 +288,7 @@ static int esp_select(ESPState *s)
      * Note that we deliberately don't raise the IRQ here: this will be done
      * either in esp_transfer_data() or esp_command_complete()
      */
+    s->asc_mode = ESP_ASC_MODE_INI;
     return 0;
 }
 
@@ -311,6 +313,7 @@ static void do_command_phase(ESPState *s)
     if (!current_lun) {
         /* No such drive */
         s->rregs[ESP_RSTAT] = 0;
+        s->asc_mode = ESP_ASC_MODE_DIS;
         s->rregs[ESP_RINTR] = INTR_DC;
         s->rregs[ESP_RSEQ] = SEQ_0;
         esp_raise_irq(s);
@@ -1095,6 +1098,7 @@ void esp_hard_reset(ESPState *s)
     fifo8_reset(&s->cmdfifo);
     s->dma = 0;
     s->dma_cb = NULL;
+    s->asc_mode = ESP_ASC_MODE_DIS;
 
     s->rregs[ESP_CFG1] = 7;
 }
@@ -1163,6 +1167,7 @@ static void esp_run_cmd(ESPState *s)
         break;
     case CMD_MSGACC:
         trace_esp_mem_writeb_cmd_msgacc(cmd);
+        s->asc_mode = ESP_ASC_MODE_DIS;
         s->rregs[ESP_RINTR] |= INTR_DC;
         s->rregs[ESP_RSEQ] = 0;
         s->rregs[ESP_RFLAGS] = 0;
@@ -1330,6 +1335,14 @@ static bool esp_is_between_version_5_and_6(void *opaque, int version_id)
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
@@ -1361,13 +1374,18 @@ static int esp_post_load(void *opaque, int version_id)
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
@@ -1399,6 +1417,7 @@ const VMStateDescription vmstate_esp = {
                            esp_is_between_version_5_and_6),
         VMSTATE_UINT8_TEST(lun, ESPState, esp_is_version_6),
         VMSTATE_BOOL(drq_state, ESPState),
+        VMSTATE_UINT8_TEST(asc_mode, ESPState, esp_is_version_8),
         VMSTATE_END_OF_LIST()
     },
 };
diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index c9afcb7cac..64cbd11765 100644
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
@@ -138,6 +145,7 @@ struct SysBusESPState {
 #define INTR_FC 0x08
 #define INTR_BS 0x10
 #define INTR_DC 0x20
+#define INTR_IL 0x40
 #define INTR_RST 0x80
 
 #define SEQ_0 0x0
-- 
2.39.5


