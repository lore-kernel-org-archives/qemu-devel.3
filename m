Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D881606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OtZoSXfN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUBcm-0001l8-2I; Thu, 19 Nov 2026 18:33:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xUBca-0001jQ-5a
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:32:54 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xUBcX-0008CJ-PA
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:32:51 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2726E61E8D;
 Thu, 19 Nov 2026 23:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664961F000C6;
 Thu, 19 Nov 2026 23:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795131168;
 bh=PT7UQ3c9bQI0vpNL7tsGf2YqvWr1HGKd+JFa1BiP8l0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OtZoSXfNpwdkC91SI9o6C0MI45Pdd8jnLmdliiT5Wamg2VLvlyQEu/YCNCmuwQUL9
 hOMscUj9u7RBV7AS/99D4ZNItC7d7xMHLyxbFc8vxE5Poz0NA1dcOfjvU9Yp9zHBd4
 7T/d3VI9Vp7vH5ctouTSRCyFhCzh+qfQWotIWVVd3AxmoxltiElnInqKD4IFS5YokD
 8xEcRpK2NVMvf/IbBK2dTl+DSelJMgWmLiGXW2XD4V+Nog73F7zRa0L/+VK1fwHsOx
 qDbmw2igw+qKsGqdvCOkwzXnN4D6qvj3gYQJeoMwHo96KHDKi61+GE4/pnVMx+nqPR
 TTCSXBOWLBuTw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Fam Zheng <fam@euphon.net>, BALATON Zoltan <balaton@eik.bme.hu>,
 Keith Monahan <keith@techtravels.org>
Subject: [PATCH v3 5/6] hw/scsi/scsi-disk: add
 quirk_mode_page_no_flexible_disk, use it on the 715
Date: Fri, 20 Nov 2026 00:32:34 +0100
Message-ID: <20261119233235.32808-6-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261119233235.32808-1-deller@kernel.org>
References: <20261119233235.32808-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

scsi-hd returns MODE SENSE page 5 (flexible disk geometry) for every
disk.  Real SCSI hard disks do not implement it; only floppy drives do.
HP-UX 9 ioscan sends MODE SENSE page 5 to the open root disk and leaves
the disk out of its listing when the page comes back, so SAM's disk
manager shows no hard disk.  Add quirk_mode_page_no_flexible_disk,
which makes page 5 an invalid field in the CDB, and turn it on for
scsi-hd on the HP 715 machine.

Signed-off-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c      | 10 ++++++++++
 hw/scsi/scsi-disk.c    | 13 +++++++++++++
 include/hw/scsi/scsi.h |  1 +
 3 files changed, 24 insertions(+)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 8a3f673daf..004cb4b5df 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -1024,6 +1024,14 @@ static void HP_A400_machine_init_class_init(ObjectClass *oc, const void *data)
     mc->default_ram_size = 1024 * MiB;
 }
 
+/*
+ * HP-UX 9 ioscan sends MODE SENSE page 5 to the open root disk and leaves
+ * the disk out of its listing if the page is returned.
+ */
+static GlobalProperty hw_compat_715[] = {
+    { "scsi-hd", "quirk_mode_page_no_flexible_disk", "on" },
+};
+
 static void HP_715_machine_init_class_init(ObjectClass *oc, const void *data)
 {
     static const char * const valid_cpu_types[] = {
@@ -1045,6 +1053,8 @@ static void HP_715_machine_init_class_init(ObjectClass *oc, const void *data)
     mc->max_cpus = MIN_CONST(HPPA_MAX_CPUS, 8);
     mc->default_ram_size = 256 * MiB;
     mc->default_nic = TYPE_LASI_82596;
+    compat_props_add(mc->compat_props, hw_compat_715,
+                     G_N_ELEMENTS(hw_compat_715));
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


