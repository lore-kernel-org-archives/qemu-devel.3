Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFE1606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fSzjPNB4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUBcm-0001lf-N0; Thu, 19 Nov 2026 18:33:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xUBcZ-0001jO-Dm
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:32:52 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xUBcS-0007x8-Tq
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:32:51 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 54C68418CC;
 Thu, 19 Nov 2026 23:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBEB1F000C6;
 Thu, 19 Nov 2026 23:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795131163;
 bh=zs2wsSzfGjyyU2DpODx/cmb1oEBGjCCwP4cxKTZ6IFs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fSzjPNB4kYkFcZVr4cot15HuF6uHc8zJriIpyydP2fc1ayyfMk7Dk40zvK2DPUik7
 vCI7vDTX1JRT8bX2+XxHAsIqIA7oj8BSdQyoSc6DWUIA23LBt/m9EjWnm3QtW6ENrF
 XQa0MSEZhKaN11lDIiwEo/vVYM2D1MIqh0fiCwZhaSNmyMXaHzRuzTvjTXruccyI1U
 XehIv9AL74y+XbFgxUw0W4zxjLcs/nSkNydTvlmh10NFhwC3Au7ek7TApNB7vUt70s
 ZVUVBX+SbHYdqmnhldJh9KH/0NfrkRmlCBfPPZPyOR2zZ0U3plgZN/x7mwlmTCOUg3
 hx26Pg7QcVC+Q==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Fam Zheng <fam@euphon.net>, BALATON Zoltan <balaton@eik.bme.hu>,
 Keith Monahan <keith@techtravels.org>
Subject: [PATCH v3 2/6] hw/scsi: share NCR/LSI definitions in lsi_scsi.h
Date: Fri, 20 Nov 2026 00:32:31 +0100
Message-ID: <20261119233235.32808-3-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261119233235.32808-1-deller@kernel.org>
References: <20261119233235.32808-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Move common defines and structures of the 53c710 and the lsi53c895a
drivers to lsi_scsi.h, as suggested by BALATON Zoltan.

Signed-off-by: Keith Monahan <keith@techtravels.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 MAINTAINERS          |   1 +
 hw/scsi/lsi53c895a.c |  79 +----
 hw/scsi/lsi_scsi.h   |  98 ++++++
 hw/scsi/ncr53c710.c  | 727 +++++++++++++++++++------------------------
 hw/scsi/ncr53c710.h  |  13 +-
 5 files changed, 426 insertions(+), 492 deletions(-)
 create mode 100644 hw/scsi/lsi_scsi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a9b4d34a0..2dab4b37fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1368,6 +1368,7 @@ F: hw/misc/lasi.c
 F: hw/pci-host/astro.c
 F: hw/pci-host/dino.c
 F: hw/scsi/lasi_ncr710.*
+F: hw/scsi/lsi_scsi.h
 F: hw/scsi/ncr53c710.*
 F: include/hw/input/lasips2.h
 F: include/hw/misc/lasi.h
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
index 0000000000..facf6cc1d6
--- /dev/null
+++ b/hw/scsi/lsi_scsi.h
@@ -0,0 +1,98 @@
+/*
+ * Definitions shared by lsi53c895a.c and ncr53c710.c (NCR/LSI SCRIPTS)
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
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
diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 1dcc111cc9..1559a9fbd1 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -34,90 +34,34 @@
 #include "trace.h"
 
 /* SCNTL0 (0x00) */
-#define NCR710_SCNTL0_TRG       0x01
-#define NCR710_SCNTL0_AAP       0x02
-#define NCR710_SCNTL0_EPG       0x04
-#define NCR710_SCNTL0_EPC       0x08
-#define NCR710_SCNTL0_WATN      0x10
-#define NCR710_SCNTL0_START     0x20
+#define LSI_SCNTL0_EPG       0x04
 /* ARB1|ARB0 = 0xc0 (full arbitration) at reset */
 
 /* SCNTL1 (0x01) */
-#define NCR710_SCNTL1_AESP      0x04
-#define NCR710_SCNTL1_RST       0x08
-#define NCR710_SCNTL1_CON       0x10
-#define NCR710_SCNTL1_ESR       0x20
-#define NCR710_SCNTL1_ADB       0x40
-#define NCR710_SCNTL1_EXC       0x80
+#define LSI_SCNTL1_ESR       0x20
 
 /* SSTAT0 (0x0d) and SIEN (0x03) share this bit layout. */
-#define NCR710_STAT0_PAR        0x01
-#define NCR710_STAT0_RST        0x02
-#define NCR710_STAT0_UDC        0x04
-#define NCR710_STAT0_SGE        0x08
-#define NCR710_STAT0_SEL        0x10
-#define NCR710_STAT0_STO        0x20
-#define NCR710_STAT0_FCMP       0x40
-#define NCR710_STAT0_MA         0x80
+#define LSI_STAT0_PAR        0x01
+#define LSI_STAT0_RST        0x02
+#define LSI_STAT0_UDC        0x04
+#define LSI_STAT0_SGE        0x08
+#define LSI_STAT0_SEL        0x10
+#define LSI_STAT0_STO        0x20
+#define LSI_STAT0_FCMP       0x40
+#define LSI_STAT0_MA         0x80
 
 /* DSTAT (0x0c) and DIEN (0x39) share this bit layout. */
-#define NCR710_DSTAT_IID        0x01
-#define NCR710_DSTAT_WTD        0x02
-#define NCR710_DSTAT_SIR        0x04
-#define NCR710_DSTAT_SSI        0x08
-#define NCR710_DSTAT_ABRT       0x10
-#define NCR710_DSTAT_BF         0x20
-#define NCR710_DSTAT_DFE        0x80   /* pure status; never raises an IRQ */
-
-/* ISTAT (0x21) */
-#define NCR710_ISTAT_DIP        0x01
-#define NCR710_ISTAT_SIP        0x02
-#define NCR710_ISTAT_CON        0x08
-#define NCR710_ISTAT_SIGP       0x20
-#define NCR710_ISTAT_RST        0x40
-#define NCR710_ISTAT_ABRT       0x80
+#define LSI_DSTAT_WTD        0x02
 
 /* SBCL (0x0b): low 3 bits mirror the SCSI phase, upper bits are bus signals. */
-#define NCR710_SBCL_ATN         0x08
-#define NCR710_SBCL_SEL         0x10
-#define NCR710_SBCL_BSY         0x20
-#define NCR710_SBCL_ACK         0x40
-#define NCR710_SBCL_REQ         0x80
-
-/* SOCL (0x07) */
-#define NCR710_SOCL_ATN         0x08
-
-/* CTEST2 (0x16) */
-#define NCR710_CTEST2_DACK      0x01
-#define NCR710_CTEST2_SIGP      0x40
-
-/* DMODE (0x38) */
-#define NCR710_DMODE_MAN        0x01
+#define LSI_SBCL_SEL         0x10
 
 /* DCNTL (0x3b) */
-#define NCR710_DCNTL_COM        0x01
-#define NCR710_DCNTL_FA         0x02
-#define NCR710_DCNTL_STD        0x04
-#define NCR710_DCNTL_LLM        0x08
-#define NCR710_DCNTL_SSM        0x10
-#define NCR710_DCNTL_EA         0x20
-
-/* SCSI phase (MSG,C/D,I/O); matches SSTAT2[2:0]/SBCL[2:0]/DCMD[26:24]. */
-#define PHASE_DO        0
-#define PHASE_DI        1
-#define PHASE_CMD       2
-#define PHASE_ST        3
-#define PHASE_MO        6
-#define PHASE_MI        7
-#define PHASE_MASK      7
-
-/* Flag bit OR'd into select_tag/tag when a queue tag is valid. */
-#define NCR710_TAG_VALID    (1 << 16)
-
-/* Maximum SCRIPTS instructions to process before yielding to the CPU. */
-#define NCR710_MAX_INSN     500
-
-#define NCR710_BUF_SIZE     4096
+#define LSI_DCNTL_FA         0x02
+#define LSI_DCNTL_LLM        0x08
+#define LSI_DCNTL_EA         0x20
+
+#define LSI_BUF_SIZE     4096
 
 /*
  * Safety bound on the synchronous completion drain loop in ncr710_reg_write().
@@ -125,36 +69,9 @@
  * unbounded spin if a drain ever fails to progress (it then falls back to
  * asynchronous completion).
  */
-#define NCR710_DRAIN_MAX_ITERS  100000
-
-/* waiting state machine (mirrors lsi53c895a). */
-enum {
-    NCR710_NOWAIT = 0,        /* SCRIPTS running or stopped */
-    NCR710_WAIT_RESELECT,     /* Wait Reselect instruction issued */
-    NCR710_DMA_SCRIPTS,       /* DMA invoked from within execute_script */
-    NCR710_DMA_IN_PROGRESS,   /* asynchronous DMA in progress */
-    NCR710_WAIT_SCRIPTS,      /* stopped on the instruction count limit */
-};
-
-enum {
-    NCR710_MSG_ACTION_COMMAND = 0,
-    NCR710_MSG_ACTION_DISCONNECT = 1,
-    NCR710_MSG_ACTION_DOUT = 2,
-    NCR710_MSG_ACTION_DIN = 3,
-};
-
-struct NCR710Request {
-    SCSIRequest *req;
-    uint32_t tag;
-    uint32_t dma_len;
-    uint8_t *dma_buf;
-    uint32_t pending;     /* bytes the SCSI layer has ready while queued */
-    int out;              /* nonzero if the queued transfer is DATA OUT */
-    bool orphan;
-    QTAILQ_ENTRY(NCR710Request) next;
-};
+#define LSI_DRAIN_MAX_ITERS  100000
 
-static const char *const ncr710_reg_names[64] = {
+static const char *const lsi_reg_names[64] = {
     "SCNTL0", "SCNTL1", "SDID", "SIEN", "SCID", "SXFER", "SODL", "SOCL",
     "SFBR", "SIDL", "SBDL", "SBCL", "DSTAT", "SSTAT0", "SSTAT1", "SSTAT2",
     "DSA0", "DSA1", "DSA2", "DSA3", "CTEST0", "CTEST1", "CTEST2", "CTEST3",
@@ -166,24 +83,24 @@ static const char *const ncr710_reg_names[64] = {
     "ADDER3",
 };
 
-static const char *ncr710_reg_name(int offset)
+static const char *lsi_reg_name(int offset)
 {
-    return (offset >= 0 && offset < 64) ? ncr710_reg_names[offset] : "???";
+    return (offset >= 0 && offset < 64) ? lsi_reg_names[offset] : "???";
 }
 
 /* Forward declarations. */
-static uint8_t ncr710_reg_readb(NCR710State *s, int offset);
-static void ncr710_reg_writeb(NCR710State *s, int offset, uint8_t val);
-static void ncr710_execute_script(NCR710State *s);
-static void ncr710_issue_bh(void *opaque);
-static void ncr710_set_phase(NCR710State *s, int phase);
+static uint8_t lsi_reg_readb(NCR710State *s, int offset);
+static void lsi_reg_writeb(NCR710State *s, int offset, uint8_t val);
+static void lsi_execute_script(NCR710State *s);
+static void lsi_issue_bh(void *opaque);
+static void lsi_set_phase(NCR710State *s, int phase);
 
 /*
  * On the 53C700 family (including the 53C710), the Select/Reselect destination
  * ID and the SDID register are a one hot BITMASK (one bit per SCSI ID), unlike
  * the 53C8xx which use a binary encoded target number.  Convert to a number.
  */
-static int ncr710_id_from_bits(unsigned bits)
+static int lsi_id_from_bits(unsigned bits)
 {
     int i;
 
@@ -200,7 +117,7 @@ static int ncr710_id_from_bits(unsigned bits)
 
 void ncr710_soft_reset(NCR710State *s)
 {
-    NCR710Request *p, *p_next;
+    lsi_request *p, *p_next;
 
     trace_ncr710_reset();
 
@@ -209,9 +126,9 @@ void ncr710_soft_reset(NCR710State *s)
      * connected request in s->current and disconnected tagged requests on
      * s->queue.  Cancel them so their SCSIRequests are released and no stale
      * pointer survives the reset.  Otherwise s->current dangles into the next
-     * ncr710_do_command (tripping its assert(s->current == NULL)) and the
+     * lsi_do_command (tripping its assert(s->current == NULL)) and the
      * queued requests leak.  scsi_req_cancel drives each through
-     * ncr710_request_cancelled -> ncr710_request_orphan, which clears
+     * ncr710_request_cancelled -> lsi_request_orphan, which clears
      * s->current and empties s->queue, mirroring the SCNTL1.RST bus-reset
      * teardown via bus_cold_reset.  At device init or machine reset both are
      * already empty, so this is a no-op (the queue is QTAILQ_INIT'd before the
@@ -227,9 +144,9 @@ void ncr710_soft_reset(NCR710State *s)
     }
 
     s->carry = 0;
-    s->msg_action = NCR710_MSG_ACTION_COMMAND;
+    s->msg_action = LSI_MSG_ACTION_COMMAND;
     s->msg_len = 0;
-    s->waiting = NCR710_NOWAIT;
+    s->waiting = LSI_NOWAIT;
     s->current_lun = 0;
     s->select_tag = 0;
     s->command_complete = 0;
@@ -286,14 +203,14 @@ void ncr710_soft_reset(NCR710State *s)
     }
 }
 
-static inline void ncr710_mem_read(NCR710State *s, uint32_t addr,
-                                   void *buf, uint32_t len)
+static inline void lsi_mem_read(NCR710State *s, uint32_t addr,
+                                void *buf, uint32_t len)
 {
     address_space_read(s->as, addr, MEMTXATTRS_UNSPECIFIED, buf, len);
 }
 
-static inline void ncr710_mem_write(NCR710State *s, uint32_t addr,
-                                    const void *buf, uint32_t len)
+static inline void lsi_mem_write(NCR710State *s, uint32_t addr,
+                                 const void *buf, uint32_t len)
 {
     address_space_write(s->as, addr, MEMTXATTRS_UNSPECIFIED, buf, len);
 }
@@ -302,7 +219,7 @@ static inline void ncr710_mem_write(NCR710State *s, uint32_t addr,
  * SCRIPTS and the table indirect data structures are built by the big endian
  * PA-RISC CPU and fetched as longwords, so they are interpreted big endian.
  */
-static inline uint32_t ncr710_read_dword(NCR710State *s, uint32_t addr)
+static inline uint32_t lsi_read_dword(NCR710State *s, uint32_t addr)
 {
     uint32_t buf;
 
@@ -310,12 +227,12 @@ static inline uint32_t ncr710_read_dword(NCR710State *s, uint32_t addr)
     return be32_to_cpu(buf);
 }
 
-static void ncr710_stop_script(NCR710State *s)
+static void lsi_stop_script(NCR710State *s)
 {
     s->script_running = false;
 }
 
-static void ncr710_update_irq(NCR710State *s)
+static void lsi_update_irq(NCR710State *s)
 {
     int level = 0;
 
@@ -323,18 +240,18 @@ static void ncr710_update_irq(NCR710State *s)
         if (s->dstat & s->dien) {
             level = 1;
         }
-        s->istat |= NCR710_ISTAT_DIP;
+        s->istat |= LSI_ISTAT0_DIP;
     } else {
-        s->istat &= ~NCR710_ISTAT_DIP;
+        s->istat &= ~LSI_ISTAT0_DIP;
     }
 
     if (s->sstat0) {
         if (s->sstat0 & s->sien) {
             level = 1;
         }
-        s->istat |= NCR710_ISTAT_SIP;
+        s->istat |= LSI_ISTAT0_SIP;
     } else {
-        s->istat &= ~NCR710_ISTAT_SIP;
+        s->istat &= ~LSI_ISTAT0_SIP;
     }
 
     trace_ncr710_update_irq(level, s->istat, s->sstat0, s->dstat);
@@ -342,7 +259,7 @@ static void ncr710_update_irq(NCR710State *s)
 }
 
 /* Raise a SCSI interrupt and stop SCRIPTS on a fatal/unmasked condition. */
-static void ncr710_script_scsi_interrupt(NCR710State *s, int stat0)
+static void lsi_script_scsi_interrupt(NCR710State *s, int stat0)
 {
     uint8_t mask;
 
@@ -352,40 +269,40 @@ static void ncr710_script_scsi_interrupt(NCR710State *s, int stat0)
      * FCMP and SEL are nonfatal (only stop when enabled in SIEN); STO never
      * stops here (execution continues until the next SCSI bus instruction).
      */
-    mask = s->sien | (uint8_t)~(NCR710_STAT0_FCMP | NCR710_STAT0_SEL);
-    mask &= ~NCR710_STAT0_STO;
+    mask = s->sien | (uint8_t)~(LSI_STAT0_FCMP | LSI_STAT0_SEL);
+    mask &= ~LSI_STAT0_STO;
     if (s->sstat0 & mask) {
-        ncr710_stop_script(s);
+        lsi_stop_script(s);
     }
-    ncr710_update_irq(s);
+    lsi_update_irq(s);
 }
 
 /* Raise a DMA interrupt and stop SCRIPTS (all DMA interrupts are fatal). */
-static void ncr710_script_dma_interrupt(NCR710State *s, int stat)
+static void lsi_script_dma_interrupt(NCR710State *s, int stat)
 {
     trace_ncr710_script_dma_interrupt(stat, s->dstat);
     s->dstat |= stat;
-    ncr710_update_irq(s);
-    ncr710_stop_script(s);
+    lsi_update_irq(s);
+    lsi_stop_script(s);
 }
 
-static void ncr710_set_phase(NCR710State *s, int phase)
+static void lsi_set_phase(NCR710State *s, int phase)
 {
     trace_ncr710_set_phase(phase);
-    s->sbcl = (s->sbcl & ~PHASE_MASK) | phase | NCR710_SBCL_REQ;
+    s->sbcl = (s->sbcl & ~PHASE_MASK) | phase | LSI_SBCL_REQ;
     s->sstat2 = (s->sstat2 & ~PHASE_MASK) | phase;
 }
 
 /* 53C710 has no phase mismatch jump feature; a bad phase always interrupts. */
-static int ncr710_bad_phase(NCR710State *s, int new_phase)
+static int lsi_bad_phase(NCR710State *s, int new_phase)
 {
-    ncr710_script_scsi_interrupt(s, NCR710_STAT0_MA);
-    ncr710_stop_script(s);
-    ncr710_set_phase(s, new_phase);
+    lsi_script_scsi_interrupt(s, LSI_STAT0_MA);
+    lsi_stop_script(s);
+    lsi_set_phase(s, new_phase);
     return 1;
 }
 
-static void ncr710_resume_script(NCR710State *s)
+static void lsi_resume_script(NCR710State *s)
 {
     trace_ncr710_resume_script(s->waiting);
     if (s->reentrancy_level > 0) {
@@ -393,46 +310,46 @@ static void ncr710_resume_script(NCR710State *s)
          * A completion fired synchronously while the SCRIPTS interpreter is
          * already on the stack, e.g. inline GOOD status for a no data
          * command (TEST UNIT READY, START STOP UNIT, ...) completing inside
-         * scsi_req_enqueue().  Reentering ncr710_execute_script() here would
+         * scsi_req_enqueue().  Reentering lsi_execute_script() here would
          * advance s->dsp underneath the outer interpreter frame and can
          * double execute SCRIPTS (the reentrancy class behind CVE-2023-0330
          * in lsi53c895a).  Do not recurse: release the wait so the outer
          * loop continues to the next instruction, which the completion has
          * already armed (PHASE_ST, via ncr710_command_complete()).
          */
-        s->waiting = NCR710_NOWAIT;
+        s->waiting = LSI_NOWAIT;
         return;
     }
-    if (s->waiting != NCR710_DMA_SCRIPTS) {
-        s->waiting = NCR710_NOWAIT;
-        ncr710_execute_script(s);
+    if (s->waiting != LSI_DMA_SCRIPTS) {
+        s->waiting = LSI_NOWAIT;
+        lsi_execute_script(s);
     } else {
-        s->waiting = NCR710_NOWAIT;
+        s->waiting = LSI_NOWAIT;
     }
 }
 
-static void ncr710_disconnect(NCR710State *s)
+static void lsi_disconnect(NCR710State *s)
 {
     trace_ncr710_disconnect(s->waiting);
-    s->scntl1 &= ~NCR710_SCNTL1_CON;
+    s->scntl1 &= ~LSI_SCNTL1_CON;
     s->sstat2 &= ~PHASE_MASK;
     s->sbcl = 0;
 }
 
-static void ncr710_bad_selection(NCR710State *s, uint32_t id)
+static void lsi_bad_selection(NCR710State *s, uint32_t id)
 {
     trace_ncr710_bad_selection(id);
-    ncr710_script_scsi_interrupt(s, NCR710_STAT0_STO);
-    ncr710_disconnect(s);
+    lsi_script_scsi_interrupt(s, LSI_STAT0_STO);
+    lsi_disconnect(s);
 }
 
 /*
- * Deferred half of ncr710_do_dma()'s SCSI continue: runs on a clean stack so a
+ * Deferred half of lsi_do_dma()'s SCSI continue: runs on a clean stack so a
  * cached backend's completion arrives asynchronously (reentrancy_level 0)
  * instead of reentrantly inside the SCRIPTS interpreter.  Guarded against an
- * orphaned/cancelled request like ncr710_reselect_bh.
+ * orphaned/cancelled request like lsi_reselect_bh.
  */
-static void ncr710_issue_bh(void *opaque)
+static void lsi_issue_bh(void *opaque)
 {
     NCR710State *s = opaque;
 
@@ -446,12 +363,12 @@ static void ncr710_issue_bh(void *opaque)
     scsi_req_continue(s->current->req);
 }
 
-static void ncr710_do_dma(NCR710State *s, int out)
+static void lsi_do_dma(NCR710State *s, int out)
 {
     uint32_t count;
     uint32_t addr;
     SCSIRequest *req;
-    NCR710Request *p;
+    lsi_request *p;
 
     if (!s->current || !s->current->dma_len) {
         /* Wait until data is available. */
@@ -475,9 +392,9 @@ static void ncr710_do_dma(NCR710State *s, int out)
         p->dma_buf = scsi_req_get_buf(req);
     }
     if (out) {
-        ncr710_mem_read(s, addr, p->dma_buf, count);
+        lsi_mem_read(s, addr, p->dma_buf, count);
     } else {
-        ncr710_mem_write(s, addr, p->dma_buf, count);
+        lsi_mem_write(s, addr, p->dma_buf, count);
     }
     if (p->orphan) {
         scsi_req_unref(req);
@@ -499,9 +416,9 @@ static void ncr710_do_dma(NCR710State *s, int out)
          * autonomous async event, like the disk-backed path;
          * the engine parks at DMA_IN_PROGRESS (set by the caller) meanwhile.
          */
-        if ((p->tag & NCR710_TAG_VALID) && s->dbc == 0) {
+        if ((p->tag & LSI_TAG_VALID) && s->dbc == 0) {
             s->issue_pending = true;
-            aio_bh_schedule_oneshot(qemu_get_aio_context(), ncr710_issue_bh, s);
+            aio_bh_schedule_oneshot(qemu_get_aio_context(), lsi_issue_bh, s);
         } else {
             /*
              * Complete inline for untagged transfers (the connected, polled
@@ -514,13 +431,13 @@ static void ncr710_do_dma(NCR710State *s, int out)
         }
     } else {
         p->dma_buf += count;
-        ncr710_resume_script(s);
+        lsi_resume_script(s);
     }
 }
 
-static void ncr710_add_msg_byte(NCR710State *s, uint8_t data)
+static void lsi_add_msg_byte(NCR710State *s, uint8_t data)
 {
-    if (s->msg_len >= NCR710_MAX_MSGIN_LEN) {
+    if (s->msg_len >= LSI_MAX_MSGIN_LEN) {
         qemu_log_mask(LOG_GUEST_ERROR, "ncr710: MSG IN overflow\n");
     } else {
         s->msg[s->msg_len++] = data;
@@ -532,18 +449,18 @@ static void ncr710_add_msg_byte(NCR710State *s, uint8_t data)
  * interrupt enable for (re)selection (SIEN.SEL).  Linux's 53c700 driver sets it
  * and expects a (re)selection interrupt when a disconnected command reselects;
  * HP-UX leaves it clear and instead parks the SCRIPTS engine on a Wait Reselect
- * instruction (handled in ncr710_wait_reselect()).  Unlike the 53C8xx, the 710
+ * instruction (handled in lsi_wait_reselect()).  Unlike the 53C8xx, the 710
  * gates reselection response on SIEN.SEL alone, with no separate SCID.RRE bit.
  */
-static inline int ncr710_irq_on_rsl(NCR710State *s)
+static inline int lsi_irq_on_rsl(NCR710State *s)
 {
-    return (s->sien & NCR710_STAT0_SEL) != 0;
+    return (s->sien & LSI_STAT0_SEL) != 0;
 }
 
 /* First disconnected request whose data the SCSI layer has made ready. */
-static NCR710Request *ncr710_get_pending_req(NCR710State *s)
+static lsi_request *lsi_get_pending_req(NCR710State *s)
 {
-    NCR710Request *p;
+    lsi_request *p;
 
     QTAILQ_FOREACH(p, &s->queue, next) {
         if (p->pending) {
@@ -554,9 +471,9 @@ static NCR710Request *ncr710_get_pending_req(NCR710State *s)
 }
 
 /* Move the in-flight command to the disconnected queue (target disconnect). */
-static void ncr710_queue_command(NCR710State *s)
+static void lsi_queue_command(NCR710State *s)
 {
-    NCR710Request *p = s->current;
+    lsi_request *p = s->current;
 
     trace_ncr710_queue_command(p->tag);
     assert(s->current != NULL);
@@ -568,7 +485,7 @@ static void ncr710_queue_command(NCR710State *s)
 }
 
 /* Reselect a disconnected command to resume (continue) its data transfer. */
-static void ncr710_reselect(NCR710State *s, NCR710Request *p)
+static void lsi_reselect(NCR710State *s, lsi_request *p)
 {
     int id;
 
@@ -579,21 +496,21 @@ static void ncr710_reselect(NCR710State *s, NCR710Request *p)
     id = (p->tag >> 8) & 0xf;
     s->sdid = 1 << id;                   /* one-hot target id (53C700 family) */
     /* 53C700 compatibility: SFBR holds the reselecting id bitmask. */
-    if (!(s->dcntl & NCR710_DCNTL_COM)) {
+    if (!(s->dcntl & LSI_DCNTL_COM)) {
         s->sfbr = 1 << (id & 0x7);
     }
     trace_ncr710_reselect(id);
-    s->scntl1 |= NCR710_SCNTL1_CON;
-    ncr710_set_phase(s, PHASE_MI);
-    s->msg_action = p->out ? NCR710_MSG_ACTION_DOUT : NCR710_MSG_ACTION_DIN;
+    s->scntl1 |= LSI_SCNTL1_CON;
+    lsi_set_phase(s, PHASE_MI);
+    s->msg_action = p->out ? LSI_MSG_ACTION_DOUT : LSI_MSG_ACTION_DIN;
     s->current->dma_len = p->pending;
-    ncr710_add_msg_byte(s, 0x80);        /* IDENTIFY (reselection) */
-    if (s->current->tag & NCR710_TAG_VALID) {
-        ncr710_add_msg_byte(s, 0x20);    /* SIMPLE QUEUE TAG */
-        ncr710_add_msg_byte(s, p->tag & 0xff);
+    lsi_add_msg_byte(s, 0x80);        /* IDENTIFY (reselection) */
+    if (s->current->tag & LSI_TAG_VALID) {
+        lsi_add_msg_byte(s, 0x20);    /* SIMPLE QUEUE TAG */
+        lsi_add_msg_byte(s, p->tag & 0xff);
     }
-    if (ncr710_irq_on_rsl(s)) {
-        ncr710_script_scsi_interrupt(s, NCR710_STAT0_SEL);
+    if (lsi_irq_on_rsl(s)) {
+        lsi_script_scsi_interrupt(s, LSI_STAT0_SEL);
     }
 }
 
@@ -602,15 +519,15 @@ static void ncr710_reselect(NCR710State *s, NCR710Request *p)
  * the device was reselected (the engine can continue), nonzero if the transfer
  * is deferred until the engine next parks at Wait Reselect.
  */
-static int ncr710_queue_req(NCR710State *s, SCSIRequest *req, uint32_t len)
+static int lsi_queue_req(NCR710State *s, SCSIRequest *req, uint32_t len)
 {
-    NCR710Request *p = req->hba_private;
+    lsi_request *p = req->hba_private;
 
     p->pending = len;
-    if (s->waiting == NCR710_WAIT_RESELECT ||
-        (ncr710_irq_on_rsl(s) && !(s->scntl1 & NCR710_SCNTL1_CON) &&
-         !(s->istat & (NCR710_ISTAT_SIP | NCR710_ISTAT_DIP)))) {
-        ncr710_reselect(s, p);
+    if (s->waiting == LSI_WAIT_RESELECT ||
+        (lsi_irq_on_rsl(s) && !(s->scntl1 & LSI_SCNTL1_CON) &&
+         !(s->istat & (LSI_ISTAT0_SIP | LSI_ISTAT0_DIP)))) {
+        lsi_reselect(s, p);
         return 0;
     }
     trace_ncr710_queue_req(p->tag);
@@ -618,30 +535,30 @@ static int ncr710_queue_req(NCR710State *s, SCSIRequest *req, uint32_t len)
 }
 
 /*
- * Deferred half of ncr710_wait_reselect(): reconnect a disconnected command
+ * Deferred half of lsi_wait_reselect(): reconnect a disconnected command
  * whose data is ready and resume the engine, on a clean (bottom half) stack.
  * Guarded so it does nothing if a guest SIGP wake or an inline transfer_data
  * reselection moved the engine on while this was pending.
  */
-static void ncr710_reselect_bh(void *opaque)
+static void lsi_reselect_bh(void *opaque)
 {
     NCR710State *s = opaque;
-    NCR710Request *p;
+    lsi_request *p;
 
-    if (s->current != NULL || s->waiting != NCR710_WAIT_RESELECT) {
+    if (s->current != NULL || s->waiting != LSI_WAIT_RESELECT) {
         return;
     }
-    p = ncr710_get_pending_req(s);
+    p = lsi_get_pending_req(s);
     if (p == NULL) {
         return;
     }
-    ncr710_reselect(s, p);
-    s->waiting = NCR710_NOWAIT;
-    ncr710_execute_script(s);
+    lsi_reselect(s, p);
+    s->waiting = LSI_NOWAIT;
+    lsi_execute_script(s);
 }
 
 /* SCRIPTS Wait Reselect: reconnect a ready queued command, else park. */
-static void ncr710_wait_reselect(NCR710State *s)
+static void lsi_wait_reselect(NCR710State *s)
 {
     if (s->current) {
         return;
@@ -659,13 +576,13 @@ static void ncr710_wait_reselect(NCR710State *s)
      * data arrives first, transfer_data's own reselection (or a SIGP wake)
      * handles it and the bottom half does nothing.
      */
-    s->waiting = NCR710_WAIT_RESELECT;
-    if (ncr710_get_pending_req(s)) {
-        aio_bh_schedule_oneshot(qemu_get_aio_context(), ncr710_reselect_bh, s);
+    s->waiting = LSI_WAIT_RESELECT;
+    if (lsi_get_pending_req(s)) {
+        aio_bh_schedule_oneshot(qemu_get_aio_context(), lsi_reselect_bh, s);
     }
 }
 
-static void ncr710_request_orphan(NCR710State *s, NCR710Request *p)
+static void lsi_request_orphan(NCR710State *s, lsi_request *p)
 {
     p->orphan = true;
     if (p == s->current) {
@@ -679,9 +596,9 @@ static void ncr710_request_orphan(NCR710State *s, NCR710Request *p)
 void ncr710_request_cancelled(SCSIRequest *req)
 {
     NCR710State *s = ncr710_from_scsi_bus(req->bus);
-    NCR710Request *p = req->hba_private;
+    lsi_request *p = req->hba_private;
 
-    ncr710_request_orphan(s, p);
+    lsi_request_orphan(s, p);
 }
 
 void ncr710_command_complete(SCSIRequest *req, size_t resid)
@@ -694,26 +611,26 @@ void ncr710_command_complete(SCSIRequest *req, size_t resid)
     s->command_complete = 2;
     if (s->waiting && s->dbc != 0) {
         /* Raise phase mismatch for short transfers. */
-        stop = ncr710_bad_phase(s, PHASE_ST);
+        stop = lsi_bad_phase(s, PHASE_ST);
         if (stop) {
-            s->waiting = NCR710_NOWAIT;
+            s->waiting = LSI_NOWAIT;
         }
     } else {
-        ncr710_set_phase(s, PHASE_ST);
+        lsi_set_phase(s, PHASE_ST);
     }
 
     if (req->hba_private == s->current) {
-        ncr710_request_orphan(s, s->current);
+        lsi_request_orphan(s, s->current);
     }
     if (!stop) {
-        ncr710_resume_script(s);
+        lsi_resume_script(s);
     }
 }
 
 void ncr710_transfer_data(SCSIRequest *req, uint32_t len)
 {
     NCR710State *s = ncr710_from_scsi_bus(req->bus);
-    NCR710Request *p = req->hba_private;
+    lsi_request *p = req->hba_private;
     int out;
 
     assert(!p->orphan);
@@ -721,12 +638,12 @@ void ncr710_transfer_data(SCSIRequest *req, uint32_t len)
     /*
      * A disconnected (queued) command, or one whose data arrives while the
      * engine is parked at Wait Reselect, must reselect before its data can be
-     * moved.  ncr710_queue_req() reselects if it can, else defers the transfer
+     * moved.  lsi_queue_req() reselects if it can, else defers the transfer
      * until the engine next parks at Wait Reselect.
      */
-    if (s->waiting == NCR710_WAIT_RESELECT || p != s->current ||
-        (ncr710_irq_on_rsl(s) && !(s->scntl1 & NCR710_SCNTL1_CON))) {
-        if (ncr710_queue_req(s, req, len)) {
+    if (s->waiting == LSI_WAIT_RESELECT || p != s->current ||
+        (lsi_irq_on_rsl(s) && !(s->scntl1 & LSI_SCNTL1_CON))) {
+        if (lsi_queue_req(s, req, len)) {
             return;
         }
     }
@@ -737,15 +654,15 @@ void ncr710_transfer_data(SCSIRequest *req, uint32_t len)
     s->current->dma_len = len;
     s->command_complete = 1;
     if (s->waiting) {
-        if (s->waiting == NCR710_WAIT_RESELECT || s->dbc == 0) {
-            ncr710_resume_script(s);
+        if (s->waiting == LSI_WAIT_RESELECT || s->dbc == 0) {
+            lsi_resume_script(s);
         } else {
-            ncr710_do_dma(s, out);
+            lsi_do_dma(s, out);
         }
     }
 }
 
-static void ncr710_do_command(NCR710State *s)
+static void lsi_do_command(NCR710State *s)
 {
     SCSIDevice *dev;
     uint8_t buf[16] = {0};
@@ -755,7 +672,7 @@ static void ncr710_do_command(NCR710State *s)
     if (s->dbc > 16) {
         s->dbc = 16;
     }
-    ncr710_mem_read(s, s->dnad, buf, s->dbc);
+    lsi_mem_read(s, s->dnad, buf, s->dbc);
     s->sfbr = buf[0];
     s->command_complete = 0;
     trace_ncr710_do_command(s->dbc, buf[0],
@@ -766,12 +683,12 @@ static void ncr710_do_command(NCR710State *s)
     id = (s->select_tag >> 8) & 0xf;
     dev = scsi_device_find(&s->bus, 0, id, s->current_lun);
     if (!dev) {
-        ncr710_bad_selection(s, id);
+        lsi_bad_selection(s, id);
         return;
     }
 
     assert(s->current == NULL);
-    s->current = g_new0(NCR710Request, 1);
+    s->current = g_new0(lsi_request, 1);
     s->current->tag = s->select_tag;
     s->current->req = scsi_req_new(dev, s->current->tag, s->current_lun, buf,
                                    s->dbc, s->current);
@@ -779,23 +696,23 @@ static void ncr710_do_command(NCR710State *s)
     n = scsi_req_enqueue(s->current->req);
     if (n) {
         if (n > 0) {
-            ncr710_set_phase(s, PHASE_DI);
+            lsi_set_phase(s, PHASE_DI);
         } else if (n < 0) {
-            ncr710_set_phase(s, PHASE_DO);
+            lsi_set_phase(s, PHASE_DO);
         }
         scsi_req_continue(s->current->req);
     }
     if (!s->command_complete) {
         if (n) {
-            if ((s->current->tag & NCR710_TAG_VALID) &&
-                !ncr710_irq_on_rsl(s)) {
+            if ((s->current->tag & LSI_TAG_VALID) &&
+                !lsi_irq_on_rsl(s)) {
                 /*
                  * Tagged command whose data is not yet ready (typically a read
                  * whose media access has not completed), issued by a driver
                  * that recovers a disconnected command by parking the SCRIPTS
                  * engine on a Wait Reselect instruction (SIEN.SEL clear, e.g.
                  * HP-UX). Disconnect and queue it so the bus is free for
-                 * further tagged commands; ncr710_wait_reselect() reselects it
+                 * further tagged commands; lsi_wait_reselect() reselects it
                  * once its data is ready.
                  *
                  * Do not disconnect for:
@@ -807,11 +724,11 @@ static void ncr710_do_command(NCR710State *s)
                  *     park.
                  * Both keep the connected behaviour and complete inline.
                  */
-                ncr710_add_msg_byte(s, 2);   /* SAVE DATA POINTER */
-                ncr710_add_msg_byte(s, 4);   /* DISCONNECT */
-                ncr710_set_phase(s, PHASE_MI);
-                s->msg_action = NCR710_MSG_ACTION_DISCONNECT;
-                ncr710_queue_command(s);
+                lsi_add_msg_byte(s, 2);   /* SAVE DATA POINTER */
+                lsi_add_msg_byte(s, 4);   /* DISCONNECT */
+                lsi_set_phase(s, PHASE_MI);
+                s->msg_action = LSI_MSG_ACTION_DISCONNECT;
+                lsi_queue_command(s);
             }
             /*
              * Otherwise stay connected and let the block move wait for
@@ -827,12 +744,12 @@ static void ncr710_do_command(NCR710State *s)
              * completion on its clean PHASE_ST path.
              */
             s->dbc = 0;
-            s->waiting = NCR710_DMA_IN_PROGRESS;
+            s->waiting = LSI_DMA_IN_PROGRESS;
         }
     }
 }
 
-static void ncr710_do_status(NCR710State *s)
+static void lsi_do_status(NCR710State *s)
 {
     uint8_t status;
 
@@ -845,13 +762,13 @@ static void ncr710_do_status(NCR710State *s)
     s->dbc = 1;
     status = s->status;
     s->sfbr = status;
-    ncr710_mem_write(s, s->dnad, &status, 1);
-    ncr710_set_phase(s, PHASE_MI);
-    s->msg_action = NCR710_MSG_ACTION_DISCONNECT;
-    ncr710_add_msg_byte(s, 0);            /* COMMAND COMPLETE */
+    lsi_mem_write(s, s->dnad, &status, 1);
+    lsi_set_phase(s, PHASE_MI);
+    s->msg_action = LSI_MSG_ACTION_DISCONNECT;
+    lsi_add_msg_byte(s, 0);            /* COMMAND COMPLETE */
 }
 
-static void ncr710_do_msgin(NCR710State *s)
+static void lsi_do_msgin(NCR710State *s)
 {
     uint8_t len;
 
@@ -865,20 +782,20 @@ static void ncr710_do_msgin(NCR710State *s)
          * here or it spins.  (HP-UX issues its CDB directly and never
          * reenters here.)
          */
-        if (s->msg_action == NCR710_MSG_ACTION_COMMAND) {
-            ncr710_set_phase(s, PHASE_CMD);
+        if (s->msg_action == LSI_MSG_ACTION_COMMAND) {
+            lsi_set_phase(s, PHASE_CMD);
         }
         return;
     }
     s->sfbr = s->msg[0];
     len = s->msg_len;
-    assert(len <= NCR710_MAX_MSGIN_LEN);
+    assert(len <= LSI_MAX_MSGIN_LEN);
     if (len > s->dbc) {
         len = s->dbc;
     }
 
     if (len) {
-        ncr710_mem_write(s, s->dnad, s->msg, len);
+        lsi_mem_write(s, s->dnad, s->msg, len);
         /* Drivers rely on the last byte being in SIDL. */
         s->sidl = s->msg[len - 1];
         s->msg_len -= len;
@@ -889,17 +806,17 @@ static void ncr710_do_msgin(NCR710State *s)
 
     if (!s->msg_len) {
         switch (s->msg_action) {
-        case NCR710_MSG_ACTION_COMMAND:
+        case LSI_MSG_ACTION_COMMAND:
             /*
              * A MESSAGE REJECT declining negotiation was just consumed.
              * The HP-UX install template reads it with ATN deasserted and
              * requires a trailing SAVE DATA POINTERS (0x02); a conformant
              * initiator (NetBSD, Linux) reads it with ATN still asserted and
-             * wants no second byte.  See ncr710_do_msgout for the
+             * wants no second byte.  See lsi_do_msgout for the
              * discriminator.
              */
-            if (s->sfbr == 7 && !(s->socl & NCR710_SOCL_ATN)) {
-                ncr710_add_msg_byte(s, 2);   /* SAVE DATA POINTERS (HP-UX) */
+            if (s->sfbr == 7 && !(s->socl & LSI_SOCL_ATN)) {
+                lsi_add_msg_byte(s, 2);   /* SAVE DATA POINTERS (HP-UX) */
             }
             /*
              * Stay in MSG IN: SSTAT2 latches the last REQ phase, so the driver
@@ -907,14 +824,14 @@ static void ncr710_do_msgin(NCR710State *s)
              * COMMAND switch happens when its next block move requests COMMAND.
              */
             break;
-        case NCR710_MSG_ACTION_DISCONNECT:
-            ncr710_disconnect(s);
+        case LSI_MSG_ACTION_DISCONNECT:
+            lsi_disconnect(s);
             break;
-        case NCR710_MSG_ACTION_DOUT:
-            ncr710_set_phase(s, PHASE_DO);
+        case LSI_MSG_ACTION_DOUT:
+            lsi_set_phase(s, PHASE_DO);
             break;
-        case NCR710_MSG_ACTION_DIN:
-            ncr710_set_phase(s, PHASE_DI);
+        case LSI_MSG_ACTION_DIN:
+            lsi_set_phase(s, PHASE_DI);
             break;
         default:
             abort();
@@ -922,50 +839,50 @@ static void ncr710_do_msgin(NCR710State *s)
     }
 }
 
-static uint8_t ncr710_get_msgbyte(NCR710State *s)
+static uint8_t lsi_get_msgbyte(NCR710State *s)
 {
     uint8_t data;
 
-    ncr710_mem_read(s, s->dnad, &data, 1);
+    lsi_mem_read(s, s->dnad, &data, 1);
     s->dnad++;
     s->dbc--;
     return data;
 }
 
-static void ncr710_skip_msgbytes(NCR710State *s, unsigned int n)
+static void lsi_skip_msgbytes(NCR710State *s, unsigned int n)
 {
     s->dnad += n;
     s->dbc -= n;
 }
 
-static void ncr710_do_msgout(NCR710State *s)
+static void lsi_do_msgout(NCR710State *s)
 {
     uint8_t msg;
 
     trace_ncr710_do_msgout(s->dbc);
     while (s->dbc) {
-        msg = ncr710_get_msgbyte(s);
+        msg = lsi_get_msgbyte(s);
         s->sfbr = msg;
 
         switch (msg) {
         case 0x04:
-            ncr710_disconnect(s);
+            lsi_disconnect(s);
             break;
         case 0x08:                       /* NOP */
-            ncr710_set_phase(s, PHASE_CMD);
+            lsi_set_phase(s, PHASE_CMD);
             break;
         case 0x01:                       /* Extended message */
-            ncr710_get_msgbyte(s);       /* skip the length byte */
-            msg = ncr710_get_msgbyte(s);
+            lsi_get_msgbyte(s);       /* skip the length byte */
+            msg = lsi_get_msgbyte(s);
             switch (msg) {
             case 1:                      /* SDTR */
-                ncr710_skip_msgbytes(s, 2);
+                lsi_skip_msgbytes(s, 2);
                 goto reject;
             case 3:                      /* WDTR */
-                ncr710_skip_msgbytes(s, 1);
+                lsi_skip_msgbytes(s, 1);
                 goto reject;
             case 4:                      /* PPR */
-                ncr710_skip_msgbytes(s, 5);
+                lsi_skip_msgbytes(s, 5);
                 goto reject;
             default:
                 goto bad;
@@ -973,12 +890,12 @@ static void ncr710_do_msgout(NCR710State *s)
             break;
         case 0x20:                       /* SIMPLE queue tag */
             s->select_tag &= ~0xff;
-            s->select_tag |= ncr710_get_msgbyte(s) | NCR710_TAG_VALID;
+            s->select_tag |= lsi_get_msgbyte(s) | LSI_TAG_VALID;
             break;
         case 0x21:                       /* HEAD of queue tag */
         case 0x22:                       /* ORDERED queue tag */
             s->select_tag &= ~0xff;
-            s->select_tag |= ncr710_get_msgbyte(s) | NCR710_TAG_VALID;
+            s->select_tag |= lsi_get_msgbyte(s) | LSI_TAG_VALID;
             break;
         case 0x0d:                       /* ABORT TAG */
         case 0x06:                       /* ABORT */
@@ -987,14 +904,14 @@ static void ncr710_do_msgout(NCR710State *s)
             if (s->current && s->current->req) {
                 scsi_req_cancel(s->current->req);
             }
-            ncr710_disconnect(s);
+            lsi_disconnect(s);
             break;
         default:
             if ((msg & 0x80) == 0) {
                 goto bad;
             }
             s->current_lun = msg & 7;    /* IDENTIFY */
-            ncr710_set_phase(s, PHASE_CMD);
+            lsi_set_phase(s, PHASE_CMD);
             break;
         }
     }
@@ -1007,38 +924,37 @@ reject:
      * it spins in MSG IN until the I/O times out, while NetBSD osiop rejects a
      * 0x02 there and resets the bus.  The two are told apart by ATN as the
      * reject is read (HP-UX has deasserted it, conformant initiators have not),
-     * so queue only the reject here and append the 0x02 tail in ncr710_do_msgin
+     * so queue only the reject here and append the 0x02 tail in lsi_do_msgin
      * when ATN is deasserted.  Phase stays latched at MSG IN until the CDB
      * block move requests COMMAND.
      */
-    ncr710_set_phase(s, PHASE_MI);
-    ncr710_add_msg_byte(s, 7);           /* MESSAGE REJECT */
-    s->msg_action = NCR710_MSG_ACTION_COMMAND;
+    lsi_set_phase(s, PHASE_MI);
+    lsi_add_msg_byte(s, 7);           /* MESSAGE REJECT */
+    s->msg_action = LSI_MSG_ACTION_COMMAND;
     return;
 bad:
     qemu_log_mask(LOG_UNIMP, "ncr710: unimplemented message 0x%02x\n", msg);
-    ncr710_set_phase(s, PHASE_MI);
-    ncr710_add_msg_byte(s, 7);           /* MESSAGE REJECT */
-    s->msg_action = NCR710_MSG_ACTION_COMMAND;
+    lsi_set_phase(s, PHASE_MI);
+    lsi_add_msg_byte(s, 7);           /* MESSAGE REJECT */
+    s->msg_action = LSI_MSG_ACTION_COMMAND;
 }
 
-static void ncr710_memcpy(NCR710State *s, uint32_t dest, uint32_t src,
-                          int count)
+static void lsi_memcpy(NCR710State *s, uint32_t dest, uint32_t src, int count)
 {
-    QEMU_UNINITIALIZED uint8_t buf[NCR710_BUF_SIZE];
+    QEMU_UNINITIALIZED uint8_t buf[LSI_BUF_SIZE];
     int n;
 
     while (count) {
-        n = (count > NCR710_BUF_SIZE) ? NCR710_BUF_SIZE : count;
-        ncr710_mem_read(s, src, buf, n);
-        ncr710_mem_write(s, dest, buf, n);
+        n = (count > LSI_BUF_SIZE) ? LSI_BUF_SIZE : count;
+        lsi_mem_read(s, src, buf, n);
+        lsi_mem_write(s, dest, buf, n);
         src += n;
         dest += n;
         count -= n;
     }
 }
 
-static void ncr710_scripts_timer_start(NCR710State *s)
+static void lsi_scripts_timer_start(NCR710State *s)
 {
     /* The wrapper allocates this timer on the nanosecond clock. */
     timer_mod(s->scripts_timer,
@@ -1049,45 +965,45 @@ void ncr710_scripts_timer_callback(void *opaque)
 {
     NCR710State *s = opaque;
 
-    s->waiting = NCR710_NOWAIT;
-    ncr710_execute_script(s);
+    s->waiting = LSI_NOWAIT;
+    lsi_execute_script(s);
 }
 
-static void ncr710_execute_script(NCR710State *s)
+static void lsi_execute_script(NCR710State *s)
 {
     uint32_t insn;
     uint32_t addr;
     int opcode;
     int insn_processed = 0;
 
-    if (s->waiting == NCR710_WAIT_SCRIPTS) {
+    if (s->waiting == LSI_WAIT_SCRIPTS) {
         timer_del(s->scripts_timer);
-        s->waiting = NCR710_NOWAIT;
+        s->waiting = LSI_NOWAIT;
     }
 
     s->reentrancy_level++;
     s->script_running = true;
 again:
     /*
-     * Yield to the CPU after NCR710_MAX_INSN instructions (so guests that spin
+     * Yield to the CPU after LSI_MAX_INSN instructions (so guests that spin
      * waiting on a memory change make progress), and guard against a script
      * that retriggers itself (CVE-2023-0330) via the reentrancy counter.
      */
-    if (++insn_processed > NCR710_MAX_INSN || s->reentrancy_level > 8) {
+    if (++insn_processed > LSI_MAX_INSN || s->reentrancy_level > 8) {
         trace_ncr710_script_yield(insn_processed);
-        s->waiting = NCR710_WAIT_SCRIPTS;
-        ncr710_scripts_timer_start(s);
+        s->waiting = LSI_WAIT_SCRIPTS;
+        lsi_scripts_timer_start(s);
         s->reentrancy_level--;
         return;
     }
 
-    insn = ncr710_read_dword(s, s->dsp);
+    insn = lsi_read_dword(s, s->dsp);
     if (!insn) {
         /* Skip an empty (NULL) opcode 4 bytes at a time. */
         s->dsp += 4;
         goto again;
     }
-    addr = ncr710_read_dword(s, s->dsp + 4);
+    addr = lsi_read_dword(s, s->dsp + 4);
     trace_ncr710_execute_script(s->dsp, insn, addr);
     s->dsps = addr;
     s->dcmd = insn >> 24;
@@ -1095,20 +1011,20 @@ again:
 
     switch (insn >> 30) {
     case 0: /* Block move */
-        if (s->sstat0 & NCR710_STAT0_STO) {
-            ncr710_stop_script(s);
+        if (s->sstat0 & LSI_STAT0_STO) {
+            lsi_stop_script(s);
             break;
         }
         s->dbc = insn & 0xffffff;
         if (insn & (1 << 29)) {
             /* Indirect addressing. */
-            addr = ncr710_read_dword(s, addr);
+            addr = lsi_read_dword(s, addr);
         } else if (insn & (1 << 28)) {
             /* Table indirect addressing (32 bit). */
             uint32_t buf[2];
             int32_t offset = sextract32(addr, 0, 24);
 
-            ncr710_mem_read(s, s->dsa + offset, buf, 8);
+            lsi_mem_read(s, s->dsa + offset, buf, 8);
             s->dbc = be32_to_cpu(buf[0]) & 0xffffff;
             addr = be32_to_cpu(buf[1]);
         }
@@ -1123,43 +1039,43 @@ again:
              * M/A.
              */
             if ((s->sstat2 & PHASE_MASK) == PHASE_MI && s->msg_len == 0 &&
-                s->msg_action == NCR710_MSG_ACTION_COMMAND &&
+                s->msg_action == LSI_MSG_ACTION_COMMAND &&
                 ((insn >> 24) & 7) == PHASE_CMD) {
-                ncr710_set_phase(s, PHASE_CMD);
+                lsi_set_phase(s, PHASE_CMD);
             } else {
                 trace_ncr710_block_move_badphase(s->sstat2 & PHASE_MASK,
                                                  (insn >> 24) & 7);
-                ncr710_script_scsi_interrupt(s, NCR710_STAT0_MA);
+                lsi_script_scsi_interrupt(s, LSI_STAT0_MA);
                 break;
             }
         }
         s->dnad = addr;
         switch (s->sstat2 & PHASE_MASK) {
         case PHASE_DO:
-            s->waiting = NCR710_DMA_SCRIPTS;
-            ncr710_do_dma(s, 1);
+            s->waiting = LSI_DMA_SCRIPTS;
+            lsi_do_dma(s, 1);
             if (s->waiting) {
-                s->waiting = NCR710_DMA_IN_PROGRESS;
+                s->waiting = LSI_DMA_IN_PROGRESS;
             }
             break;
         case PHASE_DI:
-            s->waiting = NCR710_DMA_SCRIPTS;
-            ncr710_do_dma(s, 0);
+            s->waiting = LSI_DMA_SCRIPTS;
+            lsi_do_dma(s, 0);
             if (s->waiting) {
-                s->waiting = NCR710_DMA_IN_PROGRESS;
+                s->waiting = LSI_DMA_IN_PROGRESS;
             }
             break;
         case PHASE_CMD:
-            ncr710_do_command(s);
+            lsi_do_command(s);
             break;
         case PHASE_ST:
-            ncr710_do_status(s);
+            lsi_do_status(s);
             break;
         case PHASE_MO:
-            ncr710_do_msgout(s);
+            lsi_do_msgout(s);
             break;
         case PHASE_MI:
-            ncr710_do_msgin(s);
+            lsi_do_msgin(s);
             break;
         default:
             qemu_log_mask(LOG_UNIMP, "ncr710: unimplemented phase %d\n",
@@ -1175,14 +1091,13 @@ again:
             unsigned id_bits;
 
             if (insn & (1 << 25)) {
-                id_bits = ncr710_read_dword(s,
-                                            s->dsa + sextract32(insn, 0, 24));
+                id_bits = lsi_read_dword(s, s->dsa + sextract32(insn, 0, 24));
             } else {
                 id_bits = insn;
             }
             /* Destination ID is a one hot bitmask in bits 23:16. */
             id_bits = (id_bits >> 16) & 0xff;
-            id = ncr710_id_from_bits(id_bits);
+            id = lsi_id_from_bits(id_bits);
             if (insn & (1 << 26)) {
                 addr = s->dsp + sextract32(addr, 0, 24);
             }
@@ -1191,36 +1106,36 @@ again:
             case 0: /* Select */
                 trace_ncr710_select(id, !!(insn & (1 << 24)));
                 s->sdid = id_bits;
-                if (s->scntl1 & NCR710_SCNTL1_CON) {
+                if (s->scntl1 & LSI_SCNTL1_CON) {
                     s->dsp = s->dnad;
                     break;
                 }
                 s->sstat1 |= 0x04;       /* Won arbitration */
                 if (!scsi_device_find(&s->bus, 0, id, 0)) {
-                    ncr710_bad_selection(s, id);
+                    lsi_bad_selection(s, id);
                     break;
                 }
                 s->select_tag = id << 8;
-                s->scntl1 |= NCR710_SCNTL1_CON;
-                s->sbcl |= NCR710_SBCL_BSY;
+                s->scntl1 |= LSI_SCNTL1_CON;
+                s->sbcl |= LSI_SBCL_BSY;
                 if (insn & (1 << 24)) {
                     /*
                      * Select with ATN/: the initiator drives a message
                      * first, so the target's first phase is MESSAGE OUT
                      * (IDENTIFY).
                      */
-                    s->socl |= NCR710_SOCL_ATN;
-                    s->sbcl |= NCR710_SBCL_ATN;
-                    ncr710_set_phase(s, PHASE_MO);
+                    s->socl |= LSI_SOCL_ATN;
+                    s->sbcl |= LSI_SBCL_ATN;
+                    lsi_set_phase(s, PHASE_MO);
                 } else {
                     /* No ATN/: target goes straight to COMMAND phase. */
-                    ncr710_set_phase(s, PHASE_CMD);
+                    lsi_set_phase(s, PHASE_CMD);
                 }
-                s->waiting = NCR710_NOWAIT;
+                s->waiting = LSI_NOWAIT;
                 break;
             case 1: /* Wait Disconnect */
                 trace_ncr710_wait_disconnect();
-                s->scntl1 &= ~NCR710_SCNTL1_CON;
+                s->scntl1 &= ~LSI_SCNTL1_CON;
                 break;
             case 2: /* Wait Reselect */
                 /*
@@ -1231,7 +1146,7 @@ again:
                  * a completion INT is held in sigp_pending_resume and consumed
                  * here.  Otherwise reconnect a ready queued command, or park.
                  */
-                if ((s->istat & NCR710_ISTAT_SIGP) || s->sigp_pending_resume) {
+                if ((s->istat & LSI_ISTAT0_SIGP) || s->sigp_pending_resume) {
                     /*
                      * The SIGP divert is a one-shot: clear the latch as it is
                      * consumed so a subsequent Wait Reselect does not re-fire
@@ -1239,21 +1154,21 @@ again:
                      * real reselection (Jun92 p.53: an active SIGP at
                      * reselection disables target-mode auto-switching).
                      */
-                    s->istat &= ~NCR710_ISTAT_SIGP;
+                    s->istat &= ~LSI_ISTAT0_SIGP;
                     s->sigp_pending_resume = false;
                     s->dsp = s->dnad;
-                } else if (!ncr710_irq_on_rsl(s)) {
-                    ncr710_wait_reselect(s);
+                } else if (!lsi_irq_on_rsl(s)) {
+                    lsi_wait_reselect(s);
                 }
                 break;
             case 3: /* Set */
                 if (insn & (1 << 3)) {
-                    s->socl |= NCR710_SOCL_ATN;
-                    s->sbcl |= NCR710_SBCL_ATN;
-                    ncr710_set_phase(s, PHASE_MO);
+                    s->socl |= LSI_SOCL_ATN;
+                    s->sbcl |= LSI_SBCL_ATN;
+                    lsi_set_phase(s, PHASE_MO);
                 }
                 if (insn & (1 << 6)) {
-                    s->sbcl |= NCR710_SBCL_ACK;
+                    s->sbcl |= LSI_SBCL_ACK;
                 }
                 if (insn & (1 << 10)) {
                     s->carry = 1;
@@ -1261,11 +1176,11 @@ again:
                 break;
             case 4: /* Clear */
                 if (insn & (1 << 3)) {
-                    s->socl &= ~NCR710_SOCL_ATN;
-                    s->sbcl &= ~NCR710_SBCL_ATN;
+                    s->socl &= ~LSI_SOCL_ATN;
+                    s->sbcl &= ~LSI_SBCL_ATN;
                 }
                 if (insn & (1 << 6)) {
-                    s->sbcl &= ~NCR710_SBCL_ACK;
+                    s->sbcl &= ~LSI_SBCL_ACK;
                 }
                 if (insn & (1 << 10)) {
                     s->carry = 0;
@@ -1292,13 +1207,13 @@ again:
                 break;
             case 6: /* To SFBR */
                 if (operator) {
-                    op0 = ncr710_reg_readb(s, reg);
+                    op0 = lsi_reg_readb(s, reg);
                 }
                 op1 = data8;
                 break;
             case 7: /* Read modify write */
                 if (operator) {
-                    op0 = ncr710_reg_readb(s, reg);
+                    op0 = lsi_reg_readb(s, reg);
                 }
                 if (insn & (1 << 23)) {
                     op1 = s->sfbr;
@@ -1348,7 +1263,7 @@ again:
             switch (opcode) {
             case 5: /* From SFBR */
             case 7: /* Read modify write */
-                ncr710_reg_writeb(s, reg, op0);
+                lsi_reg_writeb(s, reg, op0);
                 break;
             case 6: /* To SFBR */
                 s->sfbr = op0;
@@ -1366,8 +1281,8 @@ again:
                 /* NOP */
                 break;
             }
-            if (s->sstat0 & NCR710_STAT0_STO) {
-                ncr710_stop_script(s);
+            if (s->sstat0 & LSI_STAT0_STO) {
+                lsi_stop_script(s);
                 break;
             }
             cond = jmp = (insn & (1 << 19)) != 0;
@@ -1403,11 +1318,11 @@ again:
                     break;
                 case 3: /* Interrupt */
                     trace_ncr710_interrupt_insn(s->dsps);
-                    ncr710_script_dma_interrupt(s, NCR710_DSTAT_SIR);
+                    lsi_script_dma_interrupt(s, LSI_DSTAT_SIR);
                     break;
                 default:
                     trace_ncr710_illegal_insn(insn);
-                    ncr710_script_dma_interrupt(s, NCR710_DSTAT_IID);
+                    lsi_script_dma_interrupt(s, LSI_DSTAT_IID);
                     break;
                 }
             }
@@ -1418,20 +1333,20 @@ again:
         if ((insn & (1 << 29)) == 0) {
             uint32_t dest;
 
-            dest = ncr710_read_dword(s, s->dsp);
+            dest = lsi_read_dword(s, s->dsp);
             s->dsp += 4;
             trace_ncr710_memmove(dest, addr, insn & 0xffffff);
-            ncr710_memcpy(s, dest, addr, insn & 0xffffff);
+            lsi_memcpy(s, dest, addr, insn & 0xffffff);
         } else {
             trace_ncr710_illegal_insn(insn);
-            ncr710_script_dma_interrupt(s, NCR710_DSTAT_IID);
+            lsi_script_dma_interrupt(s, LSI_DSTAT_IID);
         }
         break;
     }
 
-    if (s->script_running && s->waiting == NCR710_NOWAIT) {
-        if (s->dcntl & NCR710_DCNTL_SSM) {
-            ncr710_script_dma_interrupt(s, NCR710_DSTAT_SSI);
+    if (s->script_running && s->waiting == LSI_NOWAIT) {
+        if (s->dcntl & LSI_DCNTL_SSM) {
+            lsi_script_dma_interrupt(s, LSI_DSTAT_SSI);
         } else {
             goto again;
         }
@@ -1451,7 +1366,7 @@ again:
     case addr + 2: ret = (s->name >> 16) & 0xff; break; \
     case addr + 3: ret = (s->name >> 24) & 0xff; break;
 
-static uint8_t ncr710_reg_readb(NCR710State *s, int offset)
+static uint8_t lsi_reg_readb(NCR710State *s, int offset)
 {
     uint8_t ret;
 
@@ -1498,14 +1413,14 @@ static uint8_t ncr710_reg_readb(NCR710State *s, int offset)
         ret = s->sbcl;
         break;
     case NCR710_DSTAT:
-        ret = s->dstat | NCR710_DSTAT_DFE;
+        ret = s->dstat | LSI_DSTAT_DFE;
         s->dstat = 0;
-        ncr710_update_irq(s);
+        lsi_update_irq(s);
         break;
     case NCR710_SSTAT0:
         ret = s->sstat0;
         s->sstat0 = 0;
-        ncr710_update_irq(s);
+        lsi_update_irq(s);
         break;
     case NCR710_SSTAT1:
         ret = s->sstat1;
@@ -1521,10 +1436,10 @@ static uint8_t ncr710_reg_readb(NCR710State *s, int offset)
         ret = 0xf0;              /* DMA FIFO empty */
         break;
     case NCR710_CTEST2:
-        ret = NCR710_CTEST2_DACK;
-        if (s->istat & NCR710_ISTAT_SIGP) {
-            s->istat &= ~NCR710_ISTAT_SIGP;
-            ret |= NCR710_CTEST2_SIGP;
+        ret = LSI_CTEST2_DACK;
+        if (s->istat & LSI_ISTAT0_SIGP) {
+            s->istat &= ~LSI_ISTAT0_SIGP;
+            ret |= LSI_CTEST2_SIGP;
         }
         break;
     case NCR710_CTEST3:
@@ -1547,9 +1462,9 @@ static uint8_t ncr710_reg_readb(NCR710State *s, int offset)
         ret = s->dfifo;
         break;
     case NCR710_ISTAT:
-        ret = s->istat & ~NCR710_ISTAT_CON;
-        if (s->scntl1 & NCR710_SCNTL1_CON) {
-            ret |= NCR710_ISTAT_CON;
+        ret = s->istat & ~LSI_ISTAT0_CON;
+        if (s->scntl1 & LSI_SCNTL1_CON) {
+            ret |= LSI_ISTAT0_CON;
         }
         break;
     case NCR710_CTEST8:
@@ -1582,12 +1497,12 @@ static uint8_t ncr710_reg_readb(NCR710State *s, int offset)
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "ncr710: invalid read from reg %s 0x%x\n",
-                      ncr710_reg_name(offset), offset);
+                      lsi_reg_name(offset), offset);
         ret = 0xff;
         break;
     }
 
-    trace_ncr710_reg_read(ncr710_reg_name(offset), offset, ret);
+    trace_ncr710_reg_read(lsi_reg_name(offset), offset, ret);
     return ret;
 }
 
@@ -1602,27 +1517,27 @@ static uint8_t ncr710_reg_readb(NCR710State *s, int offset)
     case addr + 2: s->name &= 0xff00ffff; s->name |= val << 16; break; \
     case addr + 3: s->name &= 0x00ffffff; s->name |= val << 24; break;
 
-static void ncr710_reg_writeb(NCR710State *s, int offset, uint8_t val)
+static void lsi_reg_writeb(NCR710State *s, int offset, uint8_t val)
 {
-    trace_ncr710_reg_write(ncr710_reg_name(offset), offset, val);
+    trace_ncr710_reg_write(lsi_reg_name(offset), offset, val);
 
     switch (offset) {
     case NCR710_SCNTL0:
         s->scntl0 = val;
-        if (val & NCR710_SCNTL0_START) {
+        if (val & LSI_SCNTL0_START) {
             qemu_log_mask(LOG_UNIMP, "ncr710: START not implemented\n");
         }
         break;
     case NCR710_SCNTL1:
         s->scntl1 = val;
-        if (val & NCR710_SCNTL1_RST) {
-            if (!(s->sstat0 & NCR710_STAT0_RST)) {
+        if (val & LSI_SCNTL1_RST) {
+            if (!(s->sstat0 & LSI_STAT0_RST)) {
                 bus_cold_reset(BUS(&s->bus));
-                s->sstat0 |= NCR710_STAT0_RST;
-                ncr710_script_scsi_interrupt(s, NCR710_STAT0_RST);
+                s->sstat0 |= LSI_STAT0_RST;
+                lsi_script_scsi_interrupt(s, LSI_STAT0_RST);
             }
         } else {
-            s->sstat0 &= ~NCR710_STAT0_RST;
+            s->sstat0 &= ~LSI_STAT0_RST;
         }
         break;
     case NCR710_SDID:
@@ -1630,7 +1545,7 @@ static void ncr710_reg_writeb(NCR710State *s, int offset, uint8_t val)
         break;
     case NCR710_SIEN:
         s->sien = val;
-        ncr710_update_irq(s);
+        lsi_update_irq(s);
         break;
     case NCR710_SCID:
         s->scid = val;
@@ -1688,18 +1603,18 @@ static void ncr710_reg_writeb(NCR710State *s, int offset, uint8_t val)
         s->dfifo = val;
         break;
     case NCR710_ISTAT:
-        s->istat = (s->istat & ~(NCR710_ISTAT_ABRT | NCR710_ISTAT_RST |
-                                 NCR710_ISTAT_SIGP)) |
-                   (val & (NCR710_ISTAT_ABRT | NCR710_ISTAT_RST |
-                           NCR710_ISTAT_SIGP));
-        if (val & NCR710_ISTAT_RST) {
+        s->istat = (s->istat & ~(LSI_ISTAT0_ABRT | LSI_ISTAT0_SRST |
+                                 LSI_ISTAT0_SIGP)) |
+                   (val & (LSI_ISTAT0_ABRT | LSI_ISTAT0_SRST |
+                           LSI_ISTAT0_SIGP));
+        if (val & LSI_ISTAT0_SRST) {
             ncr710_soft_reset(s);
             return;
         }
-        if (val & NCR710_ISTAT_ABRT) {
-            ncr710_script_dma_interrupt(s, NCR710_DSTAT_ABRT);
+        if (val & LSI_ISTAT0_ABRT) {
+            lsi_script_dma_interrupt(s, LSI_DSTAT_ABRT);
         }
-        if (s->waiting == NCR710_WAIT_RESELECT && (val & NCR710_ISTAT_SIGP)) {
+        if (s->waiting == LSI_WAIT_RESELECT && (val & LSI_ISTAT0_SIGP)) {
             /*
              * SIGP "start next command" wake of a parked Wait Reselect.  Run
              * the engine synchronously: the Wait Reselect opcode, on SIGP,
@@ -1708,7 +1623,7 @@ static void ncr710_reg_writeb(NCR710State *s, int offset, uint8_t val)
              * disconnected command pending reselection: on real silicon the
              * SIGP jump wins and the pending target reselects later, when the
              * engine is next parked.  Deferring this to a bottom half let
-             * ncr710_reselect_bh win the race and reconnect a pending command
+             * lsi_reselect_bh win the race and reconnect a pending command
              * instead of selecting the new one, stranding the driver's
              * start-next kick (it polls, sees no progress, and resets the bus).
              * qemu_set_irq only raises the IRQ line here; the guest takes it at
@@ -1716,11 +1631,11 @@ static void ncr710_reg_writeb(NCR710State *s, int offset, uint8_t val)
              * is not a reentrant interrupt delivery.
              */
             trace_ncr710_awoken();
-            s->waiting = NCR710_NOWAIT;
+            s->waiting = LSI_NOWAIT;
             s->dsp = s->dnad;
-            ncr710_execute_script(s);
-        } else if ((val & NCR710_ISTAT_SIGP) && !s->script_running &&
-                   s->waiting == NCR710_NOWAIT) {
+            lsi_execute_script(s);
+        } else if ((val & LSI_ISTAT0_SIGP) && !s->script_running &&
+                   s->waiting == LSI_NOWAIT) {
             /*
              * The driver's "start next command" SIGP kick raced ahead of the
              * prior command's completion ISR: the engine is halted (script
@@ -1742,7 +1657,7 @@ static void ncr710_reg_writeb(NCR710State *s, int offset, uint8_t val)
              * command. Remember the kick so the next command is selected once
              * the engine parks again at Wait Reselect (execute_script, case 2).
              */
-            s->istat &= ~NCR710_ISTAT_SIGP;
+            s->istat &= ~LSI_ISTAT0_SIGP;
             s->sigp_pending_resume = true;
         }
         break;
@@ -1773,8 +1688,8 @@ static void ncr710_reg_writeb(NCR710State *s, int offset, uint8_t val)
     case NCR710_DSP + 3:
         s->dsp = (s->dsp & 0x00ffffff) | (val << 24);
         /* Writing the high byte starts SCRIPTS unless in manual start mode. */
-        if (!(s->dmode & NCR710_DMODE_MAN) && !s->script_running) {
-            ncr710_execute_script(s);
+        if (!(s->dmode & LSI_DMODE_MAN) && !s->script_running) {
+            lsi_execute_script(s);
         }
         break;
     CASE_SET_REG32(dsps, NCR710_DSPS)
@@ -1784,21 +1699,21 @@ static void ncr710_reg_writeb(NCR710State *s, int offset, uint8_t val)
         break;
     case NCR710_DIEN:
         s->dien = val;
-        ncr710_update_irq(s);
+        lsi_update_irq(s);
         break;
     case NCR710_DWT:
         s->dwt = val;
         break;
     case NCR710_DCNTL:
-        s->dcntl = val & ~NCR710_DCNTL_STD;
-        if ((val & NCR710_DCNTL_STD) && !s->script_running) {
-            ncr710_execute_script(s);
+        s->dcntl = val & ~LSI_DCNTL_STD;
+        if ((val & LSI_DCNTL_STD) && !s->script_running) {
+            lsi_execute_script(s);
         }
         break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "ncr710: invalid write to reg %s 0x%x (0x%02x)\n",
-                      ncr710_reg_name(offset), offset, val);
+                      lsi_reg_name(offset), offset, val);
         break;
     }
 }
@@ -1811,14 +1726,14 @@ static void ncr710_reg_writeb(NCR710State *s, int offset, uint8_t val)
 uint64_t ncr710_reg_read(NCR710State *s, hwaddr addr, unsigned size)
 {
     /* The LASI wrapper decomposes multibyte accesses into single bytes. */
-    return ncr710_reg_readb(s, addr & 0xff);
+    return lsi_reg_readb(s, addr & 0xff);
 }
 
 void ncr710_reg_write(NCR710State *s, hwaddr addr, uint64_t val, unsigned size)
 {
     unsigned drained = 0;
 
-    ncr710_reg_writeb(s, addr & 0xff, val & 0xff);
+    lsi_reg_writeb(s, addr & 0xff, val & 0xff);
 
     /*
      * Drive any asynchronous SCSI transfer the register write kicked off to
@@ -1830,20 +1745,20 @@ void ncr710_reg_write(NCR710State *s, hwaddr addr, uint64_t val, unsigned size)
      * the bus.  Real hardware takes the higher priority completion interrupt
      * before that poll.
      *
-     * A deferred continue (ncr710_issue_bh, for a tagged reselect transfer) has
+     * A deferred continue (lsi_issue_bh, for a tagged reselect transfer) has
      * not issued its backing I/O yet, so pump it inline first; otherwise
-     * blk_drain the backend.  The loop is bounded by NCR710_DRAIN_MAX_ITERS and
+     * blk_drain the backend.  The loop is bounded by LSI_DRAIN_MAX_ITERS and
      * falls back to asynchronous completion (trace_ncr710_drain_exhausted) if it
      * cannot make progress.
      */
-    while (s->waiting == NCR710_DMA_IN_PROGRESS && s->current != NULL &&
+    while (s->waiting == LSI_DMA_IN_PROGRESS && s->current != NULL &&
            s->current->req != NULL) {
-        if (drained++ >= NCR710_DRAIN_MAX_ITERS) {
+        if (drained++ >= LSI_DRAIN_MAX_ITERS) {
             trace_ncr710_drain_exhausted(drained);
             break;
         }
         if (s->issue_pending) {
-            ncr710_issue_bh(s);
+            lsi_issue_bh(s);
         } else if (s->current->req->dev->conf.blk != NULL) {
             blk_drain(s->current->req->dev->conf.blk);
         } else {
@@ -1852,7 +1767,7 @@ void ncr710_reg_write(NCR710State *s, hwaddr addr, uint64_t val, unsigned size)
     }
 }
 
-static int ncr710_pre_save(void *opaque)
+static int lsi_pre_save(void *opaque)
 {
     NCR710State *s = opaque;
 
@@ -1863,25 +1778,25 @@ static int ncr710_pre_save(void *opaque)
     return 0;
 }
 
-static int ncr710_post_load(void *opaque, int version_id)
+static int lsi_post_load(void *opaque, int version_id)
 {
     NCR710State *s = opaque;
 
-    if (s->msg_len < 0 || s->msg_len > NCR710_MAX_MSGIN_LEN) {
+    if (s->msg_len < 0 || s->msg_len > LSI_MAX_MSGIN_LEN) {
         return -EINVAL;
     }
-    if (s->msg_action < NCR710_MSG_ACTION_COMMAND ||
-        s->msg_action > NCR710_MSG_ACTION_DIN) {
+    if (s->msg_action < LSI_MSG_ACTION_COMMAND ||
+        s->msg_action > LSI_MSG_ACTION_DIN) {
         return -EINVAL;
     }
-    if (s->waiting < NCR710_NOWAIT || s->waiting > NCR710_WAIT_SCRIPTS) {
+    if (s->waiting < LSI_NOWAIT || s->waiting > LSI_WAIT_SCRIPTS) {
         return -EINVAL;
     }
     if (s->current_lun < 0 || s->current_lun > 7) {
         return -EINVAL;
     }
-    if (s->waiting == NCR710_WAIT_SCRIPTS) {
-        ncr710_scripts_timer_start(s);
+    if (s->waiting == LSI_WAIT_SCRIPTS) {
+        lsi_scripts_timer_start(s);
     }
     return 0;
 }
@@ -1896,8 +1811,8 @@ const VMStateDescription vmstate_ncr710 = {
      */
     .version_id = 3,
     .minimum_version_id = 2,
-    .pre_save = ncr710_pre_save,
-    .post_load = ncr710_post_load,
+    .pre_save = lsi_pre_save,
+    .post_load = lsi_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_INT32(carry, NCR710State),
         VMSTATE_INT32(status, NCR710State),
diff --git a/hw/scsi/ncr53c710.h b/hw/scsi/ncr53c710.h
index 4e15c9d0c1..f96c6e5565 100644
--- a/hw/scsi/ncr53c710.h
+++ b/hw/scsi/ncr53c710.h
@@ -21,6 +21,7 @@
 #include "system/memory.h"
 #include "qemu/timer.h"
 #include "migration/vmstate.h"
+#include "lsi_scsi.h"
 
 /* Register offsets (little endian addressing; the chip is internally LE). */
 #define NCR710_SCNTL0   0x00
@@ -65,13 +66,9 @@
 #define NCR710_DCNTL    0x3b
 #define NCR710_ADDER    0x3c
 
-#define NCR710_MAX_MSGIN_LEN 8
-
 /* The chip revision reported in CTEST8[7:4]. */
 #define NCR710_CHIP_REVISION 0x2
 
-typedef struct NCR710Request NCR710Request;
-
 typedef struct NCR710State {
     /* Wiring filled in by the LASI wrapper before ncr710_soft_reset(). */
     SCSIBus bus;
@@ -89,7 +86,7 @@ typedef struct NCR710State {
     int status;
     int msg_action;
     int msg_len;
-    uint8_t msg[NCR710_MAX_MSGIN_LEN];
+    uint8_t msg[LSI_MAX_MSGIN_LEN];
     int waiting;
     int current_lun;
     uint32_t select_tag;
@@ -105,7 +102,7 @@ typedef struct NCR710State {
      */
     bool sigp_pending_resume;
     /*
-     * A cached-backend SCSI continue was deferred to ncr710_issue_bh so its
+     * A cached-backend SCSI continue was deferred to lsi_issue_bh so its
      * completion arrives asynchronously, not reentrantly inside the engine.
      */
     bool issue_pending;
@@ -114,13 +111,13 @@ typedef struct NCR710State {
      * outside execute_script), so it is not migrated in vmstate.
      */
     int reentrancy_level;
-    NCR710Request *current;
+    lsi_request *current;
     /*
      * Disconnected tagged commands awaiting target-initiated reselection
      * (lsi53c895a-style).  Untagged 53C700-family transfers never disconnect,
      * so for them this stays empty and the engine runs connected as before.
      */
-    QTAILQ_HEAD(, NCR710Request) queue;
+    QTAILQ_HEAD(, lsi_request) queue;
 
     /*
      * Registers (53C710 layout).  Several (e.g. sodl/sidl/sbdl/lcrc/ctest*) are
-- 
2.54.0


