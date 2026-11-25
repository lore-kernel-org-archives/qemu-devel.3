Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A5E606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i2f0Yezn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW35a-00005a-5D; Tue, 24 Nov 2026 21:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xW35U-0008PG-Qk
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:50:24 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xW35T-0007UZ-0k
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:50:24 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2AC45409B3;
 Wed, 25 Nov 2026 02:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE83A1F000E0;
 Wed, 25 Nov 2026 02:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795575021;
 bh=AHmtgRI0UAJjDWGvdDM2Yh1xcVX0XVGWD9vGb/r6eAo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=i2f0YeznHEjMNYLM5wDcsD++H1qdGLYDl6/9Uo1XynvxqtLM0YYztLZ9XSM08KRo7
 DNgSuDh/nN6//SqGwE1ZEXPzZ3KQvirP2+l4WnwVmM/UKRx8Zpf41qi8dOAJ/YZv9V
 X6aAlip3mJCMXlBf+u0xhRQlOIruxRFLnhWYs2biL1l63EkM3YoVtIIuAUkZka9mQt
 UTUmkNJkDBysnhJTinAkFRW1pCRK+C2HU+NQwJu2LUGQ4Ymq+UDFCwRWdnr96mKeYB
 Oa9z3mI9KGIvs144m5nWWTAdEyTDsMrRo9pnm4cVXkwEPKlu3s8sLahNqKGhKEAL2W
 4YZ2kBD559f2Q==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Keith Monahan <keith@techtravels.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Helge Deller <deller@gmx.de>, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL for 11.2 12/14] hw/scsi/lasi_ncr710: Map the full LASI SCSI
 module page
Date: Wed, 25 Nov 2026 03:49:49 +0100
Message-ID: <20261125024951.10428-13-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261125024951.10428-1-deller@kernel.org>
References: <20261125024951.10428-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
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

0x100..0x1ff goes to the chip core as before.  The rest of the module
page reads as 0: HP-UX reads a board strap at 0xd85 (bit 0x20:
differential bus, 25 MHz clock); 0 is single ended, 50 MHz.

0x10..0xff and 0x200..0xfff are unmapped module space.  Writes to all
of them are ignored.

Signed-off-by: Keith Monahan <keith@techtravels.org>
AI-used-for: Patch series decomposition (commit splitting and ordering)
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/scsi/lasi_ncr710.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/lasi_ncr710.c b/hw/scsi/lasi_ncr710.c
index cbb04017ce..c8a28cd987 100644
--- a/hw/scsi/lasi_ncr710.c
+++ b/hw/scsi/lasi_ncr710.c
@@ -45,7 +45,8 @@ static uint64_t lasi_ncr710_reg_read(void *opaque, hwaddr addr,
         return val;
     }
 
-    if (addr >= 0x100) {
+    /* 0x100..0x1ff goes to the chip core. */
+    if (addr >= 0x100 && addr + size <= 0x200) {
         hwaddr ncr_addr = addr - 0x100;
         if (size == 1) {
             /*
@@ -68,6 +69,11 @@ static uint64_t lasi_ncr710_reg_read(void *opaque, hwaddr addr,
 
         trace_lasi_ncr710_reg_forward_read(addr, val);
     } else {
+        /*
+         * The rest of the module page reads as 0.  HP-UX reads a board strap
+         * at 0xd85 (bit 0x20: differential bus, 25 MHz clock); 0 is single
+         * ended, 50 MHz.
+         */
         val = 0;
         trace_lasi_ncr710_reg_read(addr, val, size);
     }
@@ -83,13 +89,14 @@ static void lasi_ncr710_reg_write(void *opaque, hwaddr addr,
 
     /*
      * 0x00..0x0f is the read only LASI module header (ID/SVERSION/HVERSION);
-     * writes to it are ignored.
+     * 0x10..0xff and 0x200..0xfff are unmapped module space.  Writes to all
+     * of them are ignored.
      */
     if (addr <= 0x0f) {
         return;
     }
 
-    if (addr >= 0x100) {
+    if (addr >= 0x100 && addr + size <= 0x200) {
         hwaddr ncr_addr = addr - 0x100;
 
         if (size == 1) {
@@ -191,7 +198,7 @@ static void lasi_ncr710_realize(DeviceState *dev, Error **errp)
         (uint64_t)s->ncr710.scripts_timer);
 
     memory_region_init_io(&s->mmio, OBJECT(dev), &lasi_ncr710_mmio_ops, s,
-                          "lasi-ncr710", 0x200);
+                          "lasi-ncr710", 0x1000);
     sysbus_init_mmio(sbd, &s->mmio);
 }
 
-- 
2.54.0


