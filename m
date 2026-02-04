Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C5FE9539B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 13:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vncqR-0003M5-8R; Wed, 04 Feb 2026 08:22:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1vncqH-0003IO-TJ; Wed, 04 Feb 2026 08:22:50 -0500
Received: from mail.avm.de ([2001:bf0:244:244::120])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1vncqE-000314-A8; Wed, 04 Feb 2026 08:22:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1770211359; bh=2C6csFJT3Spdeb7aSSmjM7pVoPsY4btxRJ+YXAtNXoE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=NOQZNzVfJSVHjnZVzHSbWuMU8hkBmcne7v3DQ5O09+SnQmA6Fc4ESgoOer/6HnZOy
 cBZp4hUk/zqTCbHiRMNgFp2htolKGjMvJHR6mgGs2bQoRk4ngaA/ZdEVRlEKKMdrdr
 gB1FTcDt8OxS1QPu+m8kwRdgcBMzSdoHWi4cBWt8=
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.0)
 (envelope-from <c.speich@avm.de>)
 id 6983481f-cb91-7f0000032729-7f000001d920-1
 for <multiple-recipients>; Wed, 04 Feb 2026 14:22:39 +0100
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Wed,  4 Feb 2026 14:22:39 +0100 (CET)
Received: from [127.0.1.1] ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2026020414223967-15152 ;
 Wed, 4 Feb 2026 14:22:39 +0100 
From: Christian Speich <c.speich@avm.de>
Date: Wed, 04 Feb 2026 14:22:29 +0100
Subject: [PATCH v3 5/6] hw/sd/sdcard: Add erase-blocks-as-zero option.
MIME-Version: 1.0
Message-Id: <20260204-sdcard-performance-b4-v3-5-dc1cf172ee57@avm.de>
References: <20260204-sdcard-performance-b4-v3-0-dc1cf172ee57@avm.de>
In-Reply-To: <20260204-sdcard-performance-b4-v3-0-dc1cf172ee57@avm.de>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Bin Meng
 <bmeng.cn@gmail.com>, qemu-block@nongnu.org, Christian Speich
 <c.speich@avm.de>
X-Mailer: b4 0.14.2
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 14.0FP4|March 10,
 2025) at 04.02.2026 14:22:39,
 Serialize by Router on ANIS1/AVM(Release 14.0FP4|March 10, 2025) at
 04.02.2026 14:22:40, Serialize complete at 04.02.2026 14:22:40
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-purgate-ID: 149429::1770211359-AB60865A-D85EFD3D/0/0
X-purgate-type: clean
X-purgate-size: 2785
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
Received-SPF: pass client-ip=2001:bf0:244:244::120;
 envelope-from=c.speich@avm.de; helo=mail.avm.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, erased blocks are filled with 0xFF. However SCR Bit 55
(DATA_STAT_AFTER_ERASE) indicates that an erase produces zeros. One of
them is wrong.

This patch does two things.

First it fixes the reporting of DATA_STAT_AFTER_ERASE in SCR to
correctly reflect the content of erased blocks. We also increase the
Product Revision (REV in CID) to indicate to the guest that
DATA_STAT_AFTER_ERASE is now reliable.

Secondly, we introduce a erase-blocks-as-zero option, which allows the
user to choose if erased blocks should contain 0xFF or 0x00. The default
is still 0xFF to remain compatible with current users.

Signed-off-by: Christian Speich <c.speich@avm.de>
---
 hw/sd/sd.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index c9cfd3620b563fbe7520cfe361e14b57cd8f7472..5ddaa08d77b6b7606005fb59f42f107d254d6e5c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -162,6 +162,7 @@ struct SDState {
     /* Static properties */
 
     uint8_t spec_version;
+    bool erase_blocks_as_zero;
     uint64_t boot_part_size;
     uint64_t rpmb_part_size;
     BlockBackend *blk;
@@ -439,6 +440,9 @@ static void sd_set_scr(SDState *sd)
     sd->scr[0] |= 2;            /* Spec Version 2.00 or Version 3.0X */
     sd->scr[1] = (2 << 4)       /* SDSC Card (Security Version 1.01) */
                  | 0b0101;      /* 1-bit or 4-bit width bus modes */
+    if (!sd->erase_blocks_as_zero) {
+        sd->scr[1] |= (1 << 7); /* DATA_STAT_AFTER_ERASE: Erase produces 0xFF */
+    }
     sd->scr[2] = 0x00;          /* Extended Security is not supported. */
     if (sd->spec_version >= SD_PHY_SPECv3_01_VERS) {
         sd->scr[2] |= 1 << 7;   /* Spec Version 3.0X */
@@ -456,7 +460,7 @@ static void sd_set_scr(SDState *sd)
 #define MID     0xaa
 #define OID     "XY"
 #define PNM     "QEMU!"
-#define PRV     0x01
+#define PRV     0x02
 #define MDT_YR  2006
 #define MDT_MON 2
 
@@ -1363,7 +1367,12 @@ static void sd_erase(SDState *sd)
     sd->erase_end = INVALID_ADDRESS;
     sd->csd[14] |= 0x40;
 
-    memset(sd->data, 0xff, erase_len);
+    if (sd->erase_blocks_as_zero) {
+        memset(sd->data, 0x0, erase_len);
+    } else {
+        memset(sd->data, 0xFF, erase_len);
+    }
+
     for (erase_addr = erase_start; erase_addr <= erase_end;
          erase_addr += erase_len) {
         if (sdsc) {
@@ -3287,6 +3296,8 @@ static void emmc_realize(DeviceState *dev, Error **errp)
 
 static const Property sdmmc_common_properties[] = {
     DEFINE_PROP_DRIVE("drive", SDState, blk),
+    DEFINE_PROP_BOOL("erase-blocks-as-zero", SDState, erase_blocks_as_zero,
+                     false),
 };
 
 static const Property sd_properties[] = {

-- 
2.43.0


