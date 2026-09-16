Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7969C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6lcs-0002aY-VD; Wed, 16 Sep 2026 05:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lcq-0002Sf-Qp; Wed, 16 Sep 2026 05:08:20 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lco-0007N0-U5; Wed, 16 Sep 2026 05:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789549558; bh=0vcwv13N92iv7fe8CuLosOOghUFeYFv8uZD/ZeveCqI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=usq7irQhIgSxj21Z8cYbAmfyr5zKqOnxF+c1+bHROPi3iiYcFkPgdf4adr858fYQL
 /rCe0SyqgOvy0qC2whAmJ7+g7JeuWv7gjyFqot/TPN4w5nEPpqdKUzVOHivWF7omJw
 6nJ5MN6S8Atzq1ukVXduyumJyu2dPUSSRDxpjKetD5MNP4vNT54h+XgiInHAHwSy2i
 c+6EJjhVMr46z4vEmti9iv3uLVOCCH1ykETcbhSFNDbtaWAGTvIu6jSnIMCHRwrC8L
 YovrMaecImrAnqLD6pHUn75F38Js2qo1ASzWdpsPpvHf7Uf35kUdEYS4h7ai7K2aBZ
 IQo9+007RSFjQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D1B611D56CA;
 Wed, 16 Sep 2026 12:05:58 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7B8E9429E15;
 Wed, 16 Sep 2026 12:06:41 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 461125A785; Wed, 16 Sep 2026 12:06:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 22/57] scsi: hide MODE SELECT block size change behind
 a quirk
Date: Wed, 16 Sep 2026 12:03:46 +0300
Message-ID: <20260916090516.677749-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

This is a dangerous operation in that the block size is not
protected by a lock, but it can be written concurrently if
you have a multi-queue virtio-scsi HBA.  Put it behind a quirk
that is only enabled by the Q800 machine, since the MODE
SELECT feature was added for A/UX.

Cc: qemu-stable@nongnu.org
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 0f410adf6b0dead1f09938054da639954bda3bc1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index c0d78eb7d71..8400cebe4c1 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -710,12 +710,14 @@ static void q800_init(Object *obj)
 
 static GlobalProperty hw_compat_q800[] = {
     { "scsi-hd", "quirk_mode_page_vendor_specific_apple", "on" },
+    { "scsi-hd", "quirk_mode_page_set_block_size", "on" },
     { "scsi-hd", "vendor", " SEAGATE" },
     { "scsi-hd", "product", "          ST225N" },
     { "scsi-hd", "ver", "1.0 " },
     { "scsi-cd", "quirk_mode_page_apple_vendor", "on" },
     { "scsi-cd", "quirk_mode_sense_rom_use_dbd", "on" },
     { "scsi-cd", "quirk_mode_page_vendor_specific_apple", "on" },
+    { "scsi-cd", "quirk_mode_page_set_block_size", "on" },
     { "scsi-cd", "quirk_mode_page_truncated", "on" },
     { "scsi-cd", "vendor", "MATSHITA" },
     { "scsi-cd", "product", "CD-ROM CR-8005" },
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 5bb7a974d69..a42f7d8e77d 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1673,8 +1673,12 @@ static void scsi_disk_emulate_mode_select(SCSIDiskReq *r, uint8_t *inbuf)
         goto invalid_param;
     }
 
-    /* Allow changing the block size */
-    if (bd_len) {
+    /*
+     * Allow changing the block size only if the quirk is enabled for it.
+     * Writing s->qdev.blocksize is not thread safe!
+     */
+    if (bd_len && (s->quirks &
+                   (1 << SCSI_DISK_QUIRK_MODE_PAGE_SET_BLOCK_SIZE))) {
         bs = p[5] << 16 | p[6] << 8 | p[7];
 
         /*
@@ -3247,6 +3251,8 @@ static const Property scsi_hd_properties[] = {
     DEFINE_PROP_BIT("quirk_mode_page_vendor_specific_apple", SCSIDiskState,
                     quirks, SCSI_DISK_QUIRK_MODE_PAGE_VENDOR_SPECIFIC_APPLE,
                     0),
+    DEFINE_PROP_BIT("quirk_mode_page_set_block_size", SCSIDiskState,
+                    quirks, SCSI_DISK_QUIRK_MODE_PAGE_SET_BLOCK_SIZE, 0),
     DEFINE_BLOCK_CHS_PROPERTIES(SCSIDiskState, qdev.conf),
 };
 
@@ -3352,6 +3358,8 @@ static const Property scsi_cd_properties[] = {
                     0),
     DEFINE_PROP_BIT("quirk_mode_page_truncated", SCSIDiskState, quirks,
                     SCSI_DISK_QUIRK_MODE_PAGE_TRUNCATED, 0),
+    DEFINE_PROP_BIT("quirk_mode_page_set_block_size", SCSIDiskState,
+                    quirks, SCSI_DISK_QUIRK_MODE_PAGE_SET_BLOCK_SIZE, 0),
 };
 
 static void scsi_cd_class_initfn(ObjectClass *klass, const void *data)
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 332c2f04ebe..b4023079922 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -261,5 +261,6 @@ bool scsi_generic_pr_state_preempt(SCSIDevice *s, Error **errp);
 #define SCSI_DISK_QUIRK_MODE_SENSE_ROM_USE_DBD             1
 #define SCSI_DISK_QUIRK_MODE_PAGE_VENDOR_SPECIFIC_APPLE    2
 #define SCSI_DISK_QUIRK_MODE_PAGE_TRUNCATED                3
+#define SCSI_DISK_QUIRK_MODE_PAGE_SET_BLOCK_SIZE           4
 
 #endif
-- 
2.47.3


