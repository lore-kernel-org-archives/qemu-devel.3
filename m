Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8153D5E368
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 12:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kQU-0008VP-7Q; Sat, 09 Nov 2024 07:18:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kPH-0006Hl-N2; Sat, 09 Nov 2024 07:17:36 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kPF-0005Et-P8; Sat, 09 Nov 2024 07:17:35 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 44D69A1643;
 Sat,  9 Nov 2024 15:08:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id F39ED167FC9;
 Sat,  9 Nov 2024 15:09:02 +0300 (MSK)
Received: (nullmailer pid 3296204 invoked by uid 1000);
 Sat, 09 Nov 2024 12:09:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.2 25/58] hw/sd/omap_mmc: Don't use sd_cmd_type_t
Date: Sat,  9 Nov 2024 15:08:26 +0300
Message-Id: <20241109120901.3295995-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
References: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

In commit 1ab08790bb75e4 we did some refactoring of the SD card
implementation, which included a rearrangement of the sd_cmd_type_t
enum values.  Unfortunately we didn't notice that this enum is not
used solely inside the SD card model itself, but is also used by the
OMAP MMC controller device.  In the OMAP MMC controller, it is used
to implement the handling of the Type field of the MMC_CMD register,
so changing the enum values so that they no longer lined up with the
bit definitions for that register field broke the controller model.
The effect is that Linux fails to boot from an SD card on the "sx1"
machine.

Give omap-mmc its own enum which we can document as needing to match
the encoding used in this device's register, so it isn't sharing
sd_cmd_type_t with the SD card model any more.  We can then move
sd_cmd_type_t's definition out of sd.h and into sd.c, which is the
only place that uses it.

Cc: qemu-stable@nongnu.org
Fixes: 1ab08790bb75 ("hw/sd/sdcard: Store command type in SDProto")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241017162755.710698-1-peter.maydell@linaro.org
(cherry picked from commit 77dd098a5e790e3ede0dea5ddd5f690086fe608c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index edd3cf2a1e..b20edac2ce 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -103,6 +103,7 @@ static void omap_mmc_fifolevel_update(struct omap_mmc_s *host)
     }
 }
 
+/* These must match the encoding of the MMC_CMD Response field */
 typedef enum {
     sd_nore = 0,	/* no response */
     sd_r1,		/* normal response command */
@@ -112,8 +113,17 @@ typedef enum {
     sd_r1b = -1,
 } sd_rsp_type_t;
 
+/* These must match the encoding of the MMC_CMD Type field */
+typedef enum {
+    SD_TYPE_BC = 0,     /* broadcast -- no response */
+    SD_TYPE_BCR = 1,    /* broadcast with response */
+    SD_TYPE_AC = 2,     /* addressed -- no data transfer */
+    SD_TYPE_ADTC = 3,   /* addressed with data transfer */
+} MMCCmdType;
+
 static void omap_mmc_command(struct omap_mmc_s *host, int cmd, int dir,
-                sd_cmd_type_t type, int busy, sd_rsp_type_t resptype, int init)
+                             MMCCmdType type, int busy,
+                             sd_rsp_type_t resptype, int init)
 {
     uint32_t rspstatus, mask;
     int rsplen, timeout;
@@ -128,7 +138,7 @@ static void omap_mmc_command(struct omap_mmc_s *host, int cmd, int dir,
     if (resptype == sd_r1 && busy)
         resptype = sd_r1b;
 
-    if (type == sd_adtc) {
+    if (type == SD_TYPE_ADTC) {
         host->fifo_start = 0;
         host->fifo_len = 0;
         host->transfer = 1;
@@ -433,10 +443,10 @@ static void omap_mmc_write(void *opaque, hwaddr offset,
         for (i = 0; i < 8; i ++)
             s->rsp[i] = 0x0000;
         omap_mmc_command(s, value & 63, (value >> 15) & 1,
-                (sd_cmd_type_t) ((value >> 12) & 3),
-                (value >> 11) & 1,
-                (sd_rsp_type_t) ((value >> 8) & 7),
-                (value >> 7) & 1);
+                         (MMCCmdType)((value >> 12) & 3),
+                         (value >> 11) & 1,
+                         (sd_rsp_type_t) ((value >> 8) & 7),
+                         (value >> 7) & 1);
         omap_mmc_update(s);
         break;
 
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 26d6eebe89..e96181385f 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -71,6 +71,14 @@ typedef enum {
     sd_illegal = -2,
 } sd_rsp_type_t;
 
+typedef enum {
+    sd_spi,
+    sd_bc,     /* broadcast -- no response */
+    sd_bcr,    /* broadcast with response */
+    sd_ac,     /* addressed -- no data transfer */
+    sd_adtc,   /* addressed with data transfer */
+} sd_cmd_type_t;
+
 enum SDCardModes {
     sd_inactive,
     sd_card_identification_mode,
diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index d35a839f5e..f2458f37b3 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -75,14 +75,6 @@ typedef enum  {
     UHS_III             = 3,    /* currently not supported */
 } sd_uhs_mode_t;
 
-typedef enum {
-    sd_spi,
-    sd_bc,     /* broadcast -- no response */
-    sd_bcr,    /* broadcast with response */
-    sd_ac,     /* addressed -- no data transfer */
-    sd_adtc,   /* addressed with data transfer */
-} sd_cmd_type_t;
-
 typedef struct {
     uint8_t cmd;
     uint32_t arg;
-- 
2.39.5


