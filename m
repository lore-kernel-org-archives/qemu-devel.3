Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D561F43688
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDfxF-0002yV-LV; Fri, 17 Apr 2026 05:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1wDfx9-0002jV-GU; Fri, 17 Apr 2026 05:57:35 -0400
Received: from mail.avm.de ([212.42.244.119])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c.speich@avm.de>)
 id 1wDfx5-00030z-Ib; Fri, 17 Apr 2026 05:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1776419845; bh=+0mmvb50jR9kZ68HQ7CQk2Labu3feNtqqLeBytUExT4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Wm5S1lahyJKP7HKLqYguJ7D6Zz6CAGwNNWjCkBRcWjyxGud4t5IXB82DvtUsRS5Kj
 iUxeSLj1w8nS+vZZ0320iuke8swQhf40hnsNudCks79TaBpRvk8TZ8ACEF+AEHzQMq
 zcNT75yN50mxfEf12/qe2cZ3YvKtrIzRX63gs/0U=
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.2)
 (envelope-from <c.speich@avm.de>)
 id 69e20405-1e6c-7f0000032729-7f000001c526-1
 for <multiple-recipients>; Fri, 17 Apr 2026 11:57:25 +0200
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Fri, 17 Apr 2026 11:57:25 +0200 (CEST)
Received: from [127.0.1.1] ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2026041711572445-2978 ;
 Fri, 17 Apr 2026 11:57:24 +0200 
From: Christian Speich <c.speich@avm.de>
Date: Fri, 17 Apr 2026 11:51:38 +0200
Subject: [PATCH v4 5/7] hw/sd/sdcard: Add erase-blocks-as-zero option.
MIME-Version: 1.0
Message-Id: <20260417-sdcard-performance-b4-v4-5-119e66be10c2@avm.de>
References: <20260417-sdcard-performance-b4-v4-0-119e66be10c2@avm.de>
In-Reply-To: <20260417-sdcard-performance-b4-v4-0-119e66be10c2@avm.de>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Bin Meng
 <bmeng.cn@gmail.com>, qemu-block@nongnu.org, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu
 <zhao1.liu@intel.com>, Christian Speich <c.speich@avm.de>
X-Mailer: b4 0.14.2
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 14.0FP4|March 10,
 2025) at 17.04.2026 11:57:24,
 Serialize by Router on ANIS1/AVM(Release 14.0FP4|March 10, 2025) at
 17.04.2026 11:57:25, Serialize complete at 17.04.2026 11:57:25
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-purgate-ID: 149429::1776419845-22F7A373-09464F27/0/0
X-purgate-type: clean
X-purgate-size: 3423
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
Received-SPF: pass client-ip=212.42.244.119; envelope-from=c.speich@avm.de;
 helo=mail.avm.de
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
 hw/core/machine.c |  5 +++++
 hw/sd/sd.c        | 15 +++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0aa77a57e956693208d77fea6af5853ed4904234..54e4c05c96e3cf35ab2e702ee81fba36457cadd7 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -38,6 +38,11 @@
 #include "hw/acpi/generic_event_device.h"
 #include "qemu/audio.h"
 
+GlobalProperty hw_compat_11_0[] = {
+    { "sdmmc-common", "erase-blocks-as-zero", "false" },
+};
+const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
+
 GlobalProperty hw_compat_10_2[] = {
     { "scsi-block", "migrate-pr", "off" },
     { "isa-cirrus-vga", "global-vmstate", "true" },
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b27fed2e563e5971dd32787498eb8abed9ffe9be..0f997ed8cc80e38645101cb8f47c86f1c30d5a25 100644
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
+                     true),
 };
 
 static const Property sd_properties[] = {

-- 
2.43.0


