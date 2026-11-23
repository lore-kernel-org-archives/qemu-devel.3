Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F45606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GOO+BqPc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVXkU-0006eO-7Y; Mon, 23 Nov 2026 12:22:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xVXkS-0006YY-Dg
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:22:36 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xVXkQ-0003cp-Fa
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:22:35 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 136F440F9A;
 Mon, 23 Nov 2026 17:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38CA1F000F0;
 Mon, 23 Nov 2026 17:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795454551;
 bh=AHmtgRI0UAJjDWGvdDM2Yh1xcVX0XVGWD9vGb/r6eAo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GOO+BqPc8dEqIdtHAExdwJum8w48rOJDwbpRg00YAisjK/eUP3Pz6oeko8FnQQ5w5
 82TDhkuNOT0pPDTYq8WkS6QDFhgDSKjKDpFOPD9C90AEUwX8JehLaxZ4i+Rl1n2ISY
 F2qffHI3Z8+c9eSNkWpdJbYTwHLJD59RF9T25bNCosSPYRQXDW9a/z5jDABT032NgB
 ujdYn373bkk4v7OtTUnHE4IdLTeuKYRgQPbw7LqglKGG7SjL6TcMZY15BOjEIzm2sF
 0b7hQk8aq25ATF9H3Danra34/2EYzA+bwwUlZOCM9WWiNaf2eS/Vzz/cTPEm3BOQyk
 bChPdujQ1PXsg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Keith Monahan <keith@techtravels.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH 12/14] hw/scsi/lasi_ncr710: Map the full LASI SCSI module page
Date: Mon, 23 Nov 2026 18:21:49 +0100
Message-ID: <20261123172151.7605-13-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123172151.7605-1-deller@kernel.org>
References: <20261123172151.7605-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
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


