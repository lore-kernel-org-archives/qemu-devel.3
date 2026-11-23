Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2872606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d4bheUG5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVXkQ-0006Ty-I3; Mon, 23 Nov 2026 12:22:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xVXkK-0006KF-0I
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:22:28 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xVXkI-00039i-Fp
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:22:27 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D7D99623A4;
 Mon, 23 Nov 2026 17:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FF71F00AD4;
 Mon, 23 Nov 2026 17:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795454545;
 bh=cSgkPodNx9bkCwIWREnacVz0BiLT27HiP6+hiF1cOs4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=d4bheUG5t2e5uHQsXoTOBi5bTzyH2fF5ITZmFtD5e0usVdI8WhS5VLpsNoce2qecq
 wAQWMDRnwZdtDVI6tjbdOok4Prxr2QaHpa6frLPyMaCGd/Kog9YN2Wq/7hG8s2JHUR
 Ew+uV2JbWaoW7wdrN4MB22bXRQc/k/GN9WohxkxWpOfC74wNpR4DSj3+ghyQEIMWzR
 xWMtO7N6pZwvMB0bo8nc/pgcitkKypVCVWNi2AM2M9aU56o8nVW1Ay0uSkbwC6S3LF
 Qdw6ByyG1Z5pmjUeJMdEw/9bBcsY/7DMq4PNy2MmHjewwBLFGw9ay7UTFxp7R1WiNI
 9PxYTIAjLDQqA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Keith Monahan <keith@techtravels.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH 10/14] hw/scsi/ncr53c710: Append SAVE DATA POINTERS after
 MESSAGE REJECT for HP-UX
Date: Mon, 23 Nov 2026 18:21:47 +0100
Message-ID: <20261123172151.7605-11-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123172151.7605-1-deller@kernel.org>
References: <20261123172151.7605-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
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
index 7558d5b4b0..d6bd1c95fc 100644
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


