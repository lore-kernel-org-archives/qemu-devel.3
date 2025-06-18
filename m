Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF749C7115B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 06:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRm2r-00023f-CM; Wed, 18 Jun 2025 02:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uRm2m-000233-BZ
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 02:13:08 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uRm2g-0003xO-8Q
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 02:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=6FGpWyYgGDQDVT6MYWvX20DRvG0NRanL7OzhHiswAbE=; b=0OnWTZJMKp+lkn/PhH4PiB08zk
 siwDtvcbC2c7j3hHURrZX8D03ioJCTt+DsWUINu+cde2jiLntq1qRYPnmCXRSB8SMmyquuKYGhsKF
 v+N6L825RcGFAO5+q1AwnMr5AOdiAlMls+qMy55z9Hy52687I03+YvVgrnUMZNdDNLh+GGwbK82Oy
 C8OyAWV+2daBUUYoik0C/p/bYrhibg3mQDeO6D+S/07Xc/AZ+z1rLZfmrjKQYqlhwJRjMu6NEZNtz
 kumVn/mmuB+YKXe3gotE0rOto5NBeEmst7K6efmQrB5UE4nQqokmK/ovGfkXpXjBxBOVSXEHbCXTO
 xpYCkcZT5Vr4WVm+uzF/+JA0FD26ifZPdeGzSr6Ux38fhMCioJxL28UsxmJgH+jEQ2PxmsZHX/bGX
 2Utw5ufdZmAazRWL82xJFxmSQAmPI+yaprSahjPBMcvHZVl7fsmwAwy4Ux9zlJddmiTYV0NZlbhSS
 s1OFzgPf2A21ePxWKxulGxU+HojoIcDQpPlI2iHKQD48aPykTUqLSporNyYMrdJNHGn2L5w6EsOLM
 2j0kh9suNl1fHIqIy2lbGKoSg5cH7ZASzRkwbcohQ8zsr66eSjoafhyu8qdFvMTHz11XyVyLocksC
 hAYsXhVaNXlI56DbRh7vdVc/Gb5S3veUXP6pgSzfM=;
Received: from [2a02:8012:2f01:0:737f:96a4:fe2:308c]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uRm1A-0007ok-FK; Wed, 18 Jun 2025 07:11:28 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com,
	fam@euphon.net,
	qemu-devel@nongnu.org
Date: Wed, 18 Jun 2025 07:12:49 +0100
Message-Id: <20250618061249.743897-8-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250618061249.743897-1-mark.cave-ayland@ilande.co.uk>
References: <20250618061249.743897-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:737f:96a4:fe2:308c
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 7/7] esp.c: only allow ESP commands permitted in the
 current asc_mode
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

If an ESP command is issued in an incorrect mode then an illegal command
interrupt should be generated. Add a new esp_cmd_is_valid() function to
indicate whether the ESP command is valid for the current mode, and if not
then raise the illegal command interrupt.

This fixes WinNT MIPS which issues ICCS after a Chip Reset which is not
permitted, but will fail with an INACCESSIBLE_BOOT_DEVICE error unless an
interrupt is generated.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Fixes: 83428f7a97 ("esp.c: move write_response() non-DMA logic to esp_do_nodma()")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2464
---
 hw/scsi/esp.c         | 37 +++++++++++++++++++++++++++++++++++++
 hw/scsi/trace-events  |  1 +
 include/hw/scsi/esp.h |  8 ++++++++
 3 files changed, 46 insertions(+)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 4aa58f9e48..1d264c40e5 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1129,6 +1129,38 @@ static void parent_esp_reset(ESPState *s, int irq, int level)
     }
 }
 
+static bool esp_cmd_is_valid(ESPState *s, uint8_t cmd)
+{
+    uint8_t cmd_group = (cmd & CMD_GRP_MASK) >> 4;
+
+    /* Always allow misc commands */
+    if (cmd_group == CMD_GRP_MISC) {
+        return true;
+    }
+
+    switch (s->asc_mode) {
+    case ESP_ASC_MODE_DIS:
+        /* Disconnected mode: only allow disconnected commands */
+        if (cmd_group == CMD_GRP_DISC) {
+            return true;
+        }
+        break;
+
+    case ESP_ASC_MODE_INI:
+        /* Initiator mode: allow initiator commands */
+        if (cmd_group == CMD_GRP_INIT) {
+            return true;
+        }
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    trace_esp_invalid_cmd(cmd, s->asc_mode);
+    return false;
+}
+
 static void esp_run_cmd(ESPState *s)
 {
     uint8_t cmd = s->rregs[ESP_CMD];
@@ -1285,6 +1317,11 @@ void esp_reg_write(ESPState *s, uint32_t saddr, uint64_t val)
         break;
     case ESP_CMD:
         s->rregs[saddr] = val;
+        if (!esp_cmd_is_valid(s, s->rregs[saddr])) {
+            s->rregs[ESP_RSTAT] |= INTR_IL;
+            esp_raise_irq(s);
+            break;
+        }
         esp_run_cmd(s);
         break;
     case ESP_WBUSID ... ESP_WSYNO:
diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
index f0f2a98c2e..6c2788e202 100644
--- a/hw/scsi/trace-events
+++ b/hw/scsi/trace-events
@@ -198,6 +198,7 @@ esp_mem_writeb_cmd_ensel(uint32_t val) "Enable selection (0x%2.2x)"
 esp_mem_writeb_cmd_dissel(uint32_t val) "Disable selection (0x%2.2x)"
 esp_mem_writeb_cmd_ti(uint32_t val) "Transfer Information (0x%2.2x)"
 esp_set_phase(const char *phase) "setting bus phase to %s"
+esp_invalid_cmd(uint8_t cmd, uint8_t asc_mode) "command 0x%x asc_mode 0x%x"
 
 # esp-pci.c
 esp_pci_error_invalid_dma_direction(void) "invalid DMA transfer direction"
diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index 6327060c7c..3526bad746 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -111,6 +111,13 @@ struct SysBusESPState {
 #define CMD_DMA 0x80
 #define CMD_CMD 0x7f
 
+#define CMD_GRP_MASK 0x70
+
+#define CMD_GRP_MISC 0x00
+#define CMD_GRP_INIT 0x01
+#define CMD_GRP_TRGT 0x02
+#define CMD_GRP_DISC 0x04
+
 #define CMD_NOP      0x00
 #define CMD_FLUSH    0x01
 #define CMD_RESET    0x02
@@ -145,6 +152,7 @@ struct SysBusESPState {
 #define INTR_FC 0x08
 #define INTR_BS 0x10
 #define INTR_DC 0x20
+#define INTR_IL 0x40
 #define INTR_RST 0x80
 
 #define SEQ_0 0x0
-- 
2.39.5


