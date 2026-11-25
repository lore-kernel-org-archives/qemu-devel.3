Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10762606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eKZLP11x
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW35X-0008Rz-DB; Tue, 24 Nov 2026 21:50:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xW35Q-0008ME-4D
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:50:20 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xW35O-0007Nl-HA
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:50:19 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B0D0360D25;
 Wed, 25 Nov 2026 02:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A101F000C0;
 Wed, 25 Nov 2026 02:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795575017;
 bh=FNaR1y39HQbp+eWtsI4R5JLrocBQ2dNz0XRQfkBW6ck=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eKZLP11x5LGKLhf/wB8nOJcUq+JetRK3Weh46RlIuI7NiyT41YIH5qYWUW7+inXgq
 KR/DfDPFHYk8k0F+/GU7p9FDDFfc3ll2yqCDGISRAF6XSa8EBRMg92a6cqto5Aiv3S
 Y0ShuSqMW+oM40APiRBm11sk2Syxl1O91lte3qOuE1WklaRqSbe/n5ulfK3xiedwtN
 pgNWIIodBx1seuWZFUIneaOjjL/gWIIX4T5t8igt4qkalaokW51Q9SRNZxu2lftGPv
 95mWskZtWX53cahStCYYiQBi0XTVgkpQkzeCPs2PG3L9+FF79v7xdFeUD4YpVMng6s
 Po/rJsFZCQ6Lw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Keith Monahan <keith@techtravels.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Helge Deller <deller@gmx.de>, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL for 11.2 10/14] hw/scsi/ncr53c710: Append SAVE DATA POINTERS
 after MESSAGE REJECT for HP-UX
Date: Wed, 25 Nov 2026 03:49:47 +0100
Message-ID: <20261125024951.10428-11-deller@kernel.org>
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

From: Keith Monahan <keith@techtravels.org>

The HP-UX 10.20 install kernel is nonconformant: its self modifying
SCRIPTS reads a second message byte after the MESSAGE REJECT that
declines SDTR/WDTR/PPR negotiation and hangs unless it is SAVE DATA
POINTERS, while NetBSD's osiop resets the bus if it sees that byte.
The two are told apart by ATN state as the reject is consumed (HP-UX
has deasserted ATN, a conformant initiator has not), so the extra byte
is appended only for HP-UX.

Signed-off-by: Keith Monahan <keith@techtravels.org>
AI-used-for: Patch series decomposition (commit splitting and ordering)
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/scsi/ncr53c710.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 25469c7d7d..39a20ba90e 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -700,6 +700,10 @@ static void lsi_do_msgin(NCR710State *s)
     if (!s->msg_len) {
         switch (s->msg_action) {
         case LSI_MSG_ACTION_COMMAND:
+            /* A MESSAGE REJECT declining negotiation was just consumed. */
+            if (s->sfbr == 7 && !(s->socl & LSI_SOCL_ATN)) {
+                lsi_add_msg_byte(s, 2);   /* SAVE DATA POINTERS (HP-UX) */
+            }
             /* Stay in MSG IN until the next block move requests COMMAND. */
             break;
         case LSI_MSG_ACTION_DISCONNECT:
@@ -795,7 +799,12 @@ static void lsi_do_msgout(NCR710State *s)
     }
     return;
 reject:
-    /* Decline SDTR/WDTR/PPR negotiation with a single MESSAGE REJECT. */
+    /*
+     * Decline SDTR/WDTR/PPR negotiation with a single MESSAGE REJECT.  HP-UX
+     * requires a trailing SAVE DATA POINTERS (0x02), which other initiators
+     * reject.  HP-UX reads the reject with ATN deasserted, so lsi_do_msgin
+     * appends the 0x02 only then.
+     */
     lsi_set_phase(s, PHASE_MI);
     lsi_add_msg_byte(s, 7);           /* MESSAGE REJECT */
     s->msg_action = LSI_MSG_ACTION_COMMAND;
-- 
2.54.0


