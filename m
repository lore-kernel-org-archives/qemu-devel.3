Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2736A606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f7ihsrhx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW35L-0008Jc-8e; Tue, 24 Nov 2026 21:50:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xW35H-0008Dx-7b
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:50:11 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xW35D-0006zL-Ij
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:50:09 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E0C0661897;
 Wed, 25 Nov 2026 02:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FFF1F000C0;
 Wed, 25 Nov 2026 02:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795575006;
 bh=JHR4k4W41LfOazmxhXxQKde1p++XwOQnB+oq1SROjsU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=f7ihsrhx9ybgVA9CSXqzyNVDSWj52bxgRfYRyyAHonCfzgxzk8reX9BF2hXFTvFs1
 su7KGiUUFb0kLRPiEVWbZelUHAcsRiC8ovSEljSGxAsRkP65+ELo6JfkVf360PAmKl
 sePw80aAJtd4qwdu5/YOn0QoI4dXtIez5UnKdvpRCnVNwnumM0e64bkxXHSLvq6cmC
 KMGzM2GYZMN4U4rkXnzF2Rcyu5c+Hnr+RusHDis4ZlVC40lHtVuKViWbR4UXlX47BP
 0bwKV6IHpMQohqdL8cQn4eX37vKKmwzIVMMYX7fq86RZx82Vscro3bmNrKjg+iwmVQ
 Dp9yYB213a7mw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Keith Monahan <keith@techtravels.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Helge Deller <deller@gmx.de>, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL for 11.2 05/14] hw/scsi/ncr53c710: Keep DCNTL.EA and DMODE.FC1
 across an ISTAT.RST reset
Date: Wed, 25 Nov 2026 03:49:42 +0100
Message-ID: <20261125024951.10428-6-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261125024951.10428-1-deller@kernel.org>
References: <20261125024951.10428-1-deller@kernel.org>
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

The NCR 53C710 data manual, ISTAT bit 6 (RST) description, says the
software reset clears all registers except that "This reset will not
clear the Enable Acknowledge (EA) or Function Control One (FC1) bits".
EA is DCNTL bit 5 and FC1 is DMODE bit 4.  ncr710_soft_reset() cleared
both registers entirely.

Add named defines for the two bits and preserve them in the soft reset.
ncr710_soft_reset() is also used for device reset and realize, which
must still clear both bits, so those callers (the LASI reset and
realize handlers and the sysbus reset handler) now zero DCNTL and
DMODE after calling it.

The effect on real guest drivers has not been tested.

AI-used-for: Patch series decomposition (commit splitting and ordering)
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/scsi/lasi_ncr710.c | 6 ++++++
 hw/scsi/ncr53c710.c   | 7 +++++--
 hw/scsi/ncr53c710.h   | 5 +++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/lasi_ncr710.c b/hw/scsi/lasi_ncr710.c
index 27234aadd3..27d8b5c749 100644
--- a/hw/scsi/lasi_ncr710.c
+++ b/hw/scsi/lasi_ncr710.c
@@ -186,6 +186,9 @@ static void lasi_ncr710_realize(DeviceState *dev, Error **errp)
                      &s->ncr710);
 
     ncr710_soft_reset(&s->ncr710);
+    /* A device reset clears EA and FC1; only ISTAT.RST keeps them. */
+    s->ncr710.dcntl = 0;
+    s->ncr710.dmode = 0;
 
     trace_lasi_ncr710_timers_initialized(
         (uint64_t)s->ncr710.reselection_retry_timer);
@@ -246,6 +249,9 @@ static void lasi_ncr710_reset(DeviceState *dev)
     LasiNCR710State *s = LASI_NCR710(dev);
     trace_lasi_ncr710_device_reset();
     ncr710_soft_reset(&s->ncr710);
+    /* A device reset clears EA and FC1; only ISTAT.RST keeps them. */
+    s->ncr710.dcntl = 0;
+    s->ncr710.dmode = 0;
 }
 
 static void lasi_ncr710_instance_init(Object *obj)
diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 9ea2c47744..55153418e4 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -349,8 +349,8 @@ void ncr710_soft_reset(NCR710State *s)
     s->ctest5 = 0;
     s->dsp = 0;
     s->dsps = 0;
-    s->dmode = 0;
-    s->dcntl = 0;
+    s->dmode &= NCR710_DMODE_FC1;
+    s->dcntl &= NCR710_DCNTL_EA;
     s->scntl0 = 0xc0;
     s->scntl1 = 0;
     s->sstat0 = 0;
@@ -2266,6 +2266,9 @@ static void ncr710_device_reset(DeviceState *dev)
     NCR710State *s = &sysbus_dev->ncr710;
 
     ncr710_soft_reset(s);
+    /* A device reset clears EA and FC1; only ISTAT.RST keeps them. */
+    s->dcntl = 0;
+    s->dmode = 0;
 }
 
 static const struct SCSIBusInfo ncr710_scsi_info = {
diff --git a/hw/scsi/ncr53c710.h b/hw/scsi/ncr53c710.h
index 00b6a01577..7dd0fe5f75 100644
--- a/hw/scsi/ncr53c710.h
+++ b/hw/scsi/ncr53c710.h
@@ -85,6 +85,11 @@
 #define NCR710_DCNTL_REG        0x3B    /* DMA Control */
 #define NCR710_ADDER_REG        0x3C    /* Adder Sum Output (32-bit, LE) */
 
+/* DMODE bit 4: Function Code 1 (FC1), kept by an ISTAT.RST soft reset. */
+#define NCR710_DMODE_FC1  0x10
+/* DCNTL bit 5: Enable Acknowledge (EA), kept by an ISTAT.RST soft reset. */
+#define NCR710_DCNTL_EA   0x20
+
 #define NCR710_REG_SIZE         0x100
 
 #define NCR710_BUF_SIZE         4096
-- 
2.54.0


