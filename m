Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E191606A32A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nx9zqcnQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUBcl-0001l0-UT; Thu, 19 Nov 2026 18:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xUBcW-0001iy-GV
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:32:48 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xUBcU-00080F-LX
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:32:48 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 382154671E;
 Thu, 19 Nov 2026 23:32:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAA11F000C6;
 Thu, 19 Nov 2026 23:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795131165;
 bh=Oh0gc0HHsZewmKxECNVbUNyUFw1mbBi10BfWy8czPNE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nx9zqcnQEsG33QPucimCMl2lG/I99nxWC5MdtPvyRiaPS9TPSl3wyuF51ARvwaDdr
 I1v424U0/kw/2+aJyd82d56VQc/p5eHcq9CqtrrIZFCvUsVFHxOnUSnLajVrmr8QXb
 pxzI42E5VOyIAT4F3vvla9eD+5KacoddjyC3PHFpTXhP31CNGRE3TTxlgyQ4XoZoe5
 xlwlChz+Fj49DtaiNE+xuZiCGpIlJ9kTRqMX+qTe0FJ/MaiKbvpvS421YmfZXcXLlQ
 RXWW+5aNh/TCBun9PDaBWICKmCbHAkGwyrkkVBq9WVulZwxWomQFNu4NU5rsnstJDn
 oSS0xONi7Op8w==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Fam Zheng <fam@euphon.net>, BALATON Zoltan <balaton@eik.bme.hu>,
 Keith Monahan <keith@techtravels.org>
Subject: [PATCH v3 3/6] hw/scsi/lasi_ncr710: map the full LASI SCSI module page
Date: Fri, 20 Nov 2026 00:32:32 +0100
Message-ID: <20261119233235.32808-4-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261119233235.32808-1-deller@kernel.org>
References: <20261119233235.32808-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/scsi/lasi_ncr710.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/scsi/lasi_ncr710.c b/hw/scsi/lasi_ncr710.c
index bca2695104..5e0294e7a7 100644
--- a/hw/scsi/lasi_ncr710.c
+++ b/hw/scsi/lasi_ncr710.c
@@ -45,7 +45,13 @@ static uint64_t lasi_ncr710_reg_read(void *opaque, hwaddr addr,
         return val;
     }
 
-    if (addr >= 0x100) {
+    /*
+     * 0x100..0x1ff goes to the chip core as before.  The rest of the
+     * module page reads as 0: HP-UX reads a board strap at 0xd85
+     * (bit 0x20: differential bus, 25 MHz clock); 0 is single ended,
+     * 50 MHz.
+     */
+    if (addr >= 0x100 && addr + size <= 0x200) {
         hwaddr ncr_addr = addr - 0x100;
         if (size == 1) {
             /*
@@ -82,16 +88,17 @@ static void lasi_ncr710_reg_write(void *opaque, hwaddr addr,
     trace_lasi_ncr710_reg_write(addr, val, size);
 
     /*
-     * 0x00..0x0f is the read only LASI module header (ID/SVERSION/HVERSION) and
-     * 0x10..0xff is unmapped module space; writes to both are ignored.  The
-     * SCSI bus reset is driven through the chip's SCNTL1.RST at forwarded
-     * offset 0x101 (see ncr53c710.c), not through this window.
+     * 0x00..0x0f is the read only LASI module header (ID/SVERSION/HVERSION);
+     * 0x10..0xff and 0x200..0xfff are unmapped module space.  Writes to all
+     * of them are ignored.  The SCSI bus reset is driven through the chip's
+     * SCNTL1.RST at forwarded offset 0x101 (see ncr53c710.c), not through
+     * this window.
      */
     if (addr <= 0x0f) {
         return;
     }
 
-    if (addr >= 0x100) {
+    if (addr >= 0x100 && addr + size <= 0x200) {
         hwaddr ncr_addr = addr - 0x100;
 
         if (size == 1) {
@@ -190,7 +197,7 @@ static void lasi_ncr710_realize(DeviceState *dev, Error **errp)
         (uint64_t)s->ncr710.scripts_timer);
 
     memory_region_init_io(&s->mmio, OBJECT(dev), &lasi_ncr710_mmio_ops, s,
-                          "lasi-ncr710", 0x200);
+                          "lasi-ncr710", 0x1000);
     sysbus_init_mmio(sbd, &s->mmio);
 }
 
-- 
2.54.0


