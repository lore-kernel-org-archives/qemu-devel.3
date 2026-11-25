Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5B8606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mKoAilGf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW35G-0008CI-1n; Tue, 24 Nov 2026 21:50:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xW35C-00085g-Tf
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:50:06 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xW35B-0006yW-Ha
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:50:06 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A4A9D41327;
 Wed, 25 Nov 2026 02:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64CF1F000C0;
 Wed, 25 Nov 2026 02:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795575004;
 bh=5WUw9ZKTcRTmn77VYcxkNv4wMwY5Py6cY/+/QIFs+1A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mKoAilGfM0/HS0Lwqx53jlgNBoDxa7dxYoGwSg2oFsqNqcb2+iaN/2OHKnWSi7vmo
 oDHafEBq15O9Iz9f7K0gnP6jgDmo3Ea/jxjxbps6sJy58zfdHZHWkF/+eh9/oqWO2a
 PmsmWAdtnpvFDuSkWKN0UDVIpmL88LYOv0B/g7fiXCLZi7aR/o152IxHMnKDNag+89
 A6Ur4CduGLQFYGvUI/r98WJ37fs8JZZ51DUjSjt+KAXqK9s9yMMdHpQWnqImPRDV9n
 BUvZmIpCS38n20YYNMTrpdWDi00YJGaBcfpdZpxu0oZzpa5MeNu5J56u4HPxrLWeeS
 iPlITlP2EFF8Q==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Keith Monahan <keith@techtravels.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Helge Deller <deller@gmx.de>, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL for 11.2 04/14] hw/scsi/lasi_ncr710: Limit max_target and
 max_lun to 7
Date: Wed, 25 Nov 2026 03:49:41 +0100
Message-ID: <20261125024951.10428-5-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261125024951.10428-1-deller@kernel.org>
References: <20261125024951.10428-1-deller@kernel.org>
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

SCSI target IDs and LUNs on this bus are 3-bit values, so the highest
valid one is 7. scsi-bus.c treats max_target and max_lun as inclusive
limits (id > max_target is rejected), so 8 wrongly allowed an ID and a
LUN that the chip cannot address. This matches esp.c and esp-pci.c.

AI-used-for: Patch series decomposition (commit splitting and ordering)
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/scsi/lasi_ncr710.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/lasi_ncr710.c b/hw/scsi/lasi_ncr710.c
index 4fde2265b5..27234aadd3 100644
--- a/hw/scsi/lasi_ncr710.c
+++ b/hw/scsi/lasi_ncr710.c
@@ -137,8 +137,8 @@ static void lasi_ncr710_command_complete(SCSIRequest *req, size_t resid)
 
 static const struct SCSIBusInfo lasi_ncr710_scsi_info = {
     .tcq = true,
-    .max_target = 8,
-    .max_lun = 8,  /* full LUN support */
+    .max_target = 7,
+    .max_lun = 7,
 
     .transfer_data = lasi_ncr710_transfer_data,
     .complete = lasi_ncr710_command_complete,
-- 
2.54.0


