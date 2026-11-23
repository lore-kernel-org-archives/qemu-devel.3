Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4B9606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dnKMzgXJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVXk2-00066Q-Gl; Mon, 23 Nov 2026 12:22:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xVXk0-00065u-8j
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:22:08 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xVXjy-0002lb-Fg
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:22:08 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4B34E61D1E;
 Mon, 23 Nov 2026 17:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E051F000C6;
 Mon, 23 Nov 2026 17:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795454524;
 bh=7IU8YoBie5x5o1YgHstYGphVVsfWjlAuy/s7lk8EbPE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dnKMzgXJ7MIa5gu441s8cO2TRvZguaTiJau6uZ3bMxzmQbrigeV1vX4UkB4rn5zSH
 sFbmFiHtqoaIJIOpiUwiRk/++tcgT8rrINZ020pVT176cgIFcR0BgZauXYek2WN5SX
 jlfkljjJ6v5kPRI0u7aNOMG4CMszlrhvfb2yrpWCeoWl8vXusry6xEa1qGgcd7/04p
 Ndx3hamgaUTw5HJD2qofBEVRmhuxrhBIaWzyh0w6zsdQ4ajSNd7W80PXEpPRjGaHVt
 gfVjpMV4xdP+uSVtY+fldfEH9noO9UouX8iMid97eFmSQwDJeqtX/7FKJrGwPKDBRZ
 K85Q8ew4bxFnA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Keith Monahan <keith@techtravels.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH 03/14] hw/scsi/scsi-disk: Add quirk_mode_page_no_flexible_disk,
 use it on the 715
Date: Mon, 23 Nov 2026 18:21:40 +0100
Message-ID: <20261123172151.7605-4-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123172151.7605-1-deller@kernel.org>
References: <20261123172151.7605-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keith Monahan <keith@techtravels.org>

scsi-disk answers MODE SENSE for page 05h (flexible disk geometry)
for every disk. Per the commit author, real SCSI hard disks of that era
reject this page with CHECK CONDITION, ILLEGAL REQUEST, INVALID FIELD IN
CDB, as only floppy drives implement it. This has not been verified
against real hardware or a datasheet here.

Per the commit author, HP-UX 9 on the HP 715 probes page 05h on the open
root disk and, when the page is returned, treats the disk as a floppy
and leaves it out of the ioscan listing, so SAM shows no hard disk.
This guest behaviour has not been reproduced here.

Add the quirk_mode_page_no_flexible_disk property, which makes page 05h
an invalid field in the CDB, and enable it for scsi-hd on the HP 715
machine through its compat properties. The property is also defined for
scsi-cd, like the other mode page quirks, as both device types share
mode_sense_page() and the same quirks bitmap; the 715 does not enable
it there.

The array name hw_compat_715 suggested a versioned machine compat
table, which it is not; call it hp_715_scsi_quirks.

AI-used-for: Patch series decomposition (commit splitting and ordering)
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c      | 10 ++++++++++
 hw/scsi/scsi-disk.c    | 13 +++++++++++++
 include/hw/scsi/scsi.h |  1 +
 3 files changed, 24 insertions(+)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 3b83968f33..04c4b2a8d8 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -1020,6 +1020,14 @@ static void HP_A400_machine_init_class_init(ObjectClass *oc, const void *data)
     mc->default_ram_size = 1024 * MiB;
 }
 
+/*
+ * HP-UX 9 ioscan sends MODE SENSE page 5 to the open root disk and leaves
+ * the disk out of its listing if the page is returned.
+ */
+static GlobalProperty hp_715_scsi_quirks[] = {
+    { "scsi-hd", "quirk_mode_page_no_flexible_disk", "on" },
+};
+
 static void HP_715_machine_init_class_init(ObjectClass *oc, const void *data)
 {
     static const char * const valid_cpu_types[] = {
@@ -1041,6 +1049,8 @@ static void HP_715_machine_init_class_init(ObjectClass *oc, const void *data)
     mc->max_cpus = MIN_CONST(HPPA_MAX_CPUS, 8);
     mc->default_ram_size = 256 * MiB;
     mc->default_nic = TYPE_LASI_82596;
+    compat_props_add(mc->compat_props, hp_715_scsi_quirks,
+                     G_N_ELEMENTS(hp_715_scsi_quirks));
 }
 
 
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index a2df3a4ec4..ce43ddf6c0 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1156,6 +1156,15 @@ static int mode_sense_page(SCSIDiskState *s, int page, uint8_t **p_outbuf,
         return -1;
     }
 
+    /*
+     * The flexible disk page is only implemented by floppy drives.  Some
+     * guests (HP-UX 9 ioscan) take a disk that returns it for a floppy.
+     */
+    if (page == MODE_PAGE_FLEXIBLE_DISK_GEOMETRY &&
+        (s->quirks & (1 << SCSI_DISK_QUIRK_MODE_PAGE_NO_FLEXIBLE_DISK))) {
+        return -1;
+    }
+
     /*
      * If Changeable Values are requested, a mask denoting those mode parameters
      * that are changeable shall be returned. As we currently don't support
@@ -3293,6 +3302,8 @@ static const Property scsi_hd_properties[] = {
                     0),
     DEFINE_PROP_BIT("quirk_mode_page_set_block_size", SCSIDiskState,
                     quirks, SCSI_DISK_QUIRK_MODE_PAGE_SET_BLOCK_SIZE, 0),
+    DEFINE_PROP_BIT("quirk_mode_page_no_flexible_disk", SCSIDiskState,
+                    quirks, SCSI_DISK_QUIRK_MODE_PAGE_NO_FLEXIBLE_DISK, 0),
     DEFINE_BLOCK_CHS_PROPERTIES(SCSIDiskState, qdev.conf),
 };
 
@@ -3401,6 +3412,8 @@ static const Property scsi_cd_properties[] = {
                     SCSI_DISK_QUIRK_MODE_PAGE_TRUNCATED, 0),
     DEFINE_PROP_BIT("quirk_mode_page_set_block_size", SCSIDiskState,
                     quirks, SCSI_DISK_QUIRK_MODE_PAGE_SET_BLOCK_SIZE, 0),
+    DEFINE_PROP_BIT("quirk_mode_page_no_flexible_disk", SCSIDiskState,
+                    quirks, SCSI_DISK_QUIRK_MODE_PAGE_NO_FLEXIBLE_DISK, 0),
 };
 
 static void scsi_cd_class_initfn(ObjectClass *klass, const void *data)
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index a2f6f0be7f..0efa62554d 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -264,5 +264,6 @@ bool scsi_generic_pr_state_cleanup(SCSIDevice *s, Error **errp);
 #define SCSI_DISK_QUIRK_MODE_PAGE_VENDOR_SPECIFIC_APPLE    2
 #define SCSI_DISK_QUIRK_MODE_PAGE_TRUNCATED                3
 #define SCSI_DISK_QUIRK_MODE_PAGE_SET_BLOCK_SIZE           4
+#define SCSI_DISK_QUIRK_MODE_PAGE_NO_FLEXIBLE_DISK         5
 
 #endif
-- 
2.54.0


