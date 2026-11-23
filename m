Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E5F606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EGAaoLEC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVXk9-000688-Uy; Mon, 23 Nov 2026 12:22:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xVXk8-00067Z-Re
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:22:16 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xVXk6-0002mS-Rs
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:22:16 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C828F623AE;
 Mon, 23 Nov 2026 17:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7D31F000D8;
 Mon, 23 Nov 2026 17:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795454533;
 bh=ELkkaD50Y0CIfwZrzVxvX6bokC7pjpTlzdCkATvQa5I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EGAaoLECku7UUj4t6CcKqVrP8hii0ktGgKjitJ42AhgygeqO6oVUD3CcPcCL3PfXo
 PWcdTEGoIQE/4DQbNI5MHY97xJj3MR6Qjf1VdNVsdtF7cYioZwle2c6LsesndywG1X
 UuQ5bJKwOzm56U5wGcy791g1Ibi5Y+pLMzTE2YlF7aTmWLIQs6iM2CMNK4/KvarH7B
 prH2WrEwXAG/S+t8SzTt5h0ZZKIJHpHvLC5sQY3Z/CTOJZFE71yRrhc03ilVGEKZji
 PNjH5L1Gcqh1rQ/Yh62ZEDxGfHGAiIAcStDMG6uUJDiB6q91rnMS/+EjIH94rEA3NL
 xfQifQQaL6VCw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Keith Monahan <keith@techtravels.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH 06/14] hw/scsi: Move shared LSI/NCR definitions to lsi_scsi.h
Date: Mon, 23 Nov 2026 18:21:43 +0100
Message-ID: <20261123172151.7605-7-deller@kernel.org>
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

Move common defines and structures of the lsi53c895a driver to
lsi_scsi.h so that the 53c710 driver can share them.

Pure code movement, no functional change: nothing is renamed and the
lsi53c895a device is unchanged.

Licence: the moved code comes from lsi53c895a.c, which is licensed under
the LGPL (Copyright (c) 2006 CodeSourcery, written by Paul Brook), so
the new header keeps that licence (SPDX LGPL-2.1-or-later) rather than
the preferred GPL-2.0-or-later; it is not relicensed.

Suggested-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Keith Monahan <keith@techtravels.org>
AI-used-for: Patch series decomposition (commit splitting and ordering)
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 MAINTAINERS          |   1 +
 hw/scsi/lsi53c895a.c |  79 +-------------------------------
 hw/scsi/lsi_scsi.h   | 104 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+), 78 deletions(-)
 create mode 100644 hw/scsi/lsi_scsi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 40bf63651c..9e001a85ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2432,6 +2432,7 @@ R: Fam Zheng <fam@euphon.net>
 S: Supported
 F: include/hw/scsi/*
 F: hw/scsi/*
+F: hw/scsi/lsi_scsi.h
 F: tests/qtest/virtio-scsi-test.c
 F: tests/qtest/fuzz-virtio-scsi-test.c
 F: tests/qtest/am53c974-test.c
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 1b7f02fc7c..2a7c6e9c8d 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -18,6 +18,7 @@
 #include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/scsi/scsi.h"
+#include "lsi_scsi.h"
 #include "migration/vmstate.h"
 #include "system/dma.h"
 #include "qemu/log.h"
@@ -42,20 +43,9 @@ static const char *names[] = {
 
 #define LSI_MAX_DEVS 7
 
-#define LSI_SCNTL0_TRG    0x01
-#define LSI_SCNTL0_AAP    0x02
-#define LSI_SCNTL0_EPC    0x08
-#define LSI_SCNTL0_WATN   0x10
-#define LSI_SCNTL0_START  0x20
-
 #define LSI_SCNTL1_SST    0x01
 #define LSI_SCNTL1_IARB   0x02
-#define LSI_SCNTL1_AESP   0x04
-#define LSI_SCNTL1_RST    0x08
-#define LSI_SCNTL1_CON    0x10
 #define LSI_SCNTL1_DHP    0x20
-#define LSI_SCNTL1_ADB    0x40
-#define LSI_SCNTL1_EXC    0x80
 
 #define LSI_SCNTL2_WSR    0x01
 #define LSI_SCNTL2_VUE0   0x02
@@ -66,14 +56,8 @@ static const char *names[] = {
 #define LSI_SCNTL2_CHM    0x40
 #define LSI_SCNTL2_SDU    0x80
 
-#define LSI_ISTAT0_DIP    0x01
-#define LSI_ISTAT0_SIP    0x02
 #define LSI_ISTAT0_INTF   0x04
-#define LSI_ISTAT0_CON    0x08
 #define LSI_ISTAT0_SEM    0x10
-#define LSI_ISTAT0_SIGP   0x20
-#define LSI_ISTAT0_SRST   0x40
-#define LSI_ISTAT0_ABRT   0x80
 
 #define LSI_ISTAT1_SI     0x01
 #define LSI_ISTAT1_SRUN   0x02
@@ -105,43 +89,30 @@ static const char *names[] = {
 #define LSI_SOCL_IO       0x01
 #define LSI_SOCL_CD       0x02
 #define LSI_SOCL_MSG      0x04
-#define LSI_SOCL_ATN      0x08
 #define LSI_SOCL_SEL      0x10
 #define LSI_SOCL_BSY      0x20
 #define LSI_SOCL_ACK      0x40
 #define LSI_SOCL_REQ      0x80
 
-#define LSI_DSTAT_IID     0x01
-#define LSI_DSTAT_SIR     0x04
-#define LSI_DSTAT_SSI     0x08
-#define LSI_DSTAT_ABRT    0x10
-#define LSI_DSTAT_BF      0x20
 #define LSI_DSTAT_MDPE    0x40
-#define LSI_DSTAT_DFE     0x80
 
-#define LSI_DCNTL_COM     0x01
 #define LSI_DCNTL_IRQD    0x02
-#define LSI_DCNTL_STD     0x04
 #define LSI_DCNTL_IRQM    0x08
-#define LSI_DCNTL_SSM     0x10
 #define LSI_DCNTL_PFEN    0x20
 #define LSI_DCNTL_PFF     0x40
 #define LSI_DCNTL_CLSE    0x80
 
-#define LSI_DMODE_MAN     0x01
 #define LSI_DMODE_BOF     0x02
 #define LSI_DMODE_ERMP    0x04
 #define LSI_DMODE_ERL     0x08
 #define LSI_DMODE_DIOM    0x10
 #define LSI_DMODE_SIOM    0x20
 
-#define LSI_CTEST2_DACK   0x01
 #define LSI_CTEST2_DREQ   0x02
 #define LSI_CTEST2_TEOP   0x04
 #define LSI_CTEST2_PCICIE 0x08
 #define LSI_CTEST2_CM     0x10
 #define LSI_CTEST2_CIO    0x20
-#define LSI_CTEST2_SIGP   0x40
 #define LSI_CTEST2_DDIR   0x80
 
 #define LSI_CTEST5_BL2    0x04
@@ -163,59 +134,11 @@ static const char *names[] = {
 #define LSI_CCNTL1_DDAC      0x08
 #define LSI_CCNTL1_ZMOD      0x80
 
-#define LSI_SBCL_ATN         0x08
-#define LSI_SBCL_BSY         0x20
-#define LSI_SBCL_ACK         0x40
-#define LSI_SBCL_REQ         0x80
-
 /* Enable Response to Reselection */
 #define LSI_SCID_RRE      0x60
 
 #define LSI_CCNTL1_40BIT (LSI_CCNTL1_EN64TIBMV|LSI_CCNTL1_64TIMOD)
 
-#define PHASE_DO          0
-#define PHASE_DI          1
-#define PHASE_CMD         2
-#define PHASE_ST          3
-#define PHASE_MO          6
-#define PHASE_MI          7
-#define PHASE_MASK        7
-
-/* Maximum length of MSG IN data.  */
-#define LSI_MAX_MSGIN_LEN 8
-
-/* Flag set if this is a tagged command.  */
-#define LSI_TAG_VALID     (1 << 16)
-
-/* Maximum instructions to process. */
-#define LSI_MAX_INSN    500
-
-typedef struct lsi_request {
-    SCSIRequest *req;
-    uint32_t tag;
-    uint32_t dma_len;
-    uint8_t *dma_buf;
-    uint32_t pending;
-    int out;
-    bool orphan;
-    QTAILQ_ENTRY(lsi_request) next;
-} lsi_request;
-
-enum {
-    LSI_NOWAIT, /* SCRIPTS are running or stopped */
-    LSI_WAIT_RESELECT, /* Wait Reselect instruction has been issued */
-    LSI_DMA_SCRIPTS, /* processing DMA from lsi_execute_script */
-    LSI_DMA_IN_PROGRESS, /* DMA operation is in progress */
-    LSI_WAIT_SCRIPTS, /* SCRIPTS stopped because of instruction count limit */
-};
-
-enum {
-    LSI_MSG_ACTION_COMMAND = 0,
-    LSI_MSG_ACTION_DISCONNECT = 1,
-    LSI_MSG_ACTION_DOUT = 2,
-    LSI_MSG_ACTION_DIN = 3,
-};
-
 struct LSIState {
     /*< private >*/
     PCIDevice parent_obj;
diff --git a/hw/scsi/lsi_scsi.h b/hw/scsi/lsi_scsi.h
new file mode 100644
index 0000000000..de0941dd23
--- /dev/null
+++ b/hw/scsi/lsi_scsi.h
@@ -0,0 +1,104 @@
+/*
+ * QEMU LSI53C895A SCSI Host Bus Adapter emulation
+ * Definitions shared with other NCR/LSI SCRIPTS based controllers
+ *
+ * Copyright (c) 2006 CodeSourcery.
+ * Written by Paul Brook
+ *
+ * This code is licensed under the LGPL.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef HW_SCSI_LSI_SCSI_H
+#define HW_SCSI_LSI_SCSI_H
+
+#include "qemu/queue.h"
+#include "hw/scsi/scsi.h"
+
+#define LSI_SCNTL0_TRG    0x01
+#define LSI_SCNTL0_AAP    0x02
+#define LSI_SCNTL0_EPC    0x08
+#define LSI_SCNTL0_WATN   0x10
+#define LSI_SCNTL0_START  0x20
+
+#define LSI_SCNTL1_AESP   0x04
+#define LSI_SCNTL1_RST    0x08
+#define LSI_SCNTL1_CON    0x10
+#define LSI_SCNTL1_ADB    0x40
+#define LSI_SCNTL1_EXC    0x80
+
+#define LSI_ISTAT0_DIP    0x01
+#define LSI_ISTAT0_SIP    0x02
+#define LSI_ISTAT0_CON    0x08
+#define LSI_ISTAT0_SIGP   0x20
+#define LSI_ISTAT0_SRST   0x40
+#define LSI_ISTAT0_ABRT   0x80
+
+#define LSI_SOCL_ATN      0x08
+
+#define LSI_DSTAT_IID     0x01
+#define LSI_DSTAT_SIR     0x04
+#define LSI_DSTAT_SSI     0x08
+#define LSI_DSTAT_ABRT    0x10
+#define LSI_DSTAT_BF      0x20
+#define LSI_DSTAT_DFE     0x80
+
+#define LSI_DCNTL_COM     0x01
+#define LSI_DCNTL_STD     0x04
+#define LSI_DCNTL_SSM     0x10
+
+#define LSI_DMODE_MAN     0x01
+
+#define LSI_CTEST2_DACK   0x01
+#define LSI_CTEST2_SIGP   0x40
+
+#define LSI_SBCL_ATN         0x08
+#define LSI_SBCL_BSY         0x20
+#define LSI_SBCL_ACK         0x40
+#define LSI_SBCL_REQ         0x80
+
+#define PHASE_DO          0
+#define PHASE_DI          1
+#define PHASE_CMD         2
+#define PHASE_ST          3
+#define PHASE_MO          6
+#define PHASE_MI          7
+#define PHASE_MASK        7
+
+/* Maximum length of MSG IN data.  */
+#define LSI_MAX_MSGIN_LEN 8
+
+/* Flag set if this is a tagged command.  */
+#define LSI_TAG_VALID     (1 << 16)
+
+/* Maximum instructions to process. */
+#define LSI_MAX_INSN    500
+
+typedef struct lsi_request {
+    SCSIRequest *req;
+    uint32_t tag;
+    uint32_t dma_len;
+    uint8_t *dma_buf;
+    uint32_t pending;
+    int out;
+    bool orphan;
+    QTAILQ_ENTRY(lsi_request) next;
+} lsi_request;
+
+enum {
+    LSI_NOWAIT, /* SCRIPTS are running or stopped */
+    LSI_WAIT_RESELECT, /* Wait Reselect instruction has been issued */
+    LSI_DMA_SCRIPTS, /* processing DMA from lsi_execute_script */
+    LSI_DMA_IN_PROGRESS, /* DMA operation is in progress */
+    LSI_WAIT_SCRIPTS, /* SCRIPTS stopped because of instruction count limit */
+};
+
+enum {
+    LSI_MSG_ACTION_COMMAND = 0,
+    LSI_MSG_ACTION_DISCONNECT = 1,
+    LSI_MSG_ACTION_DOUT = 2,
+    LSI_MSG_ACTION_DIN = 3,
+};
+
+#endif
-- 
2.54.0


