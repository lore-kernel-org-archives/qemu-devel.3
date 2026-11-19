Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D004606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=krJq32Y0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUBci-0001ke-58; Thu, 19 Nov 2026 18:33:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xUBcX-0001jH-KK
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:32:52 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xUBcW-00083a-4L
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 18:32:49 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 44EBB61D46;
 Thu, 19 Nov 2026 23:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848481F000C6;
 Thu, 19 Nov 2026 23:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795131167;
 bh=X38ZKIVYRy80YeLcK7urG/XD1952+83aHZZKfQ8zio0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=krJq32Y0afe0f215HOwMAFfoj+q8a1KSg9dsm1F0a6ZoFQtKPwUS9xrhpoOfgJNcB
 gD0TT1Ur5YOASmTNv/PwGfB8vVo1uFzJj8l/qVMCEQmUG85WXV0X74MryMCedfWa1H
 biefNPfsYC2yQGkNO4D2DdZq0qtZcsLfYBfX8/iE8+SzOEhv4hqgcPCtSAzJNJ+Ovu
 sd5skYNMbAKGPujGbXRWbu3DubYRCBbWDyjRlXSlO7SGIM4+rbnItdLMGoEbsZNtOm
 jODTs6Dv+/Ggy79dXSpZzZs6lzIe0ncWi3Ce5W0JCnobldjCHkoJR/0vp8Exx3GoPj
 vil29gedrkmQw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Fam Zheng <fam@euphon.net>, BALATON Zoltan <balaton@eik.bme.hu>,
 Keith Monahan <keith@techtravels.org>
Subject: [PATCH v3 4/6] hw/scsi/ncr53c710: move to COMMAND on CLEAR ACK after
 MESSAGE REJECT
Date: Fri, 20 Nov 2026 00:32:33 +0100
Message-ID: <20261119233235.32808-5-deller@kernel.org>
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

Releasing ACK on the last byte of a declined negotiation MESSAGE REJECT
lets the target move on to COMMAND.  HP-UX 9 tests the phase with JUMP
WHEN COMMAND after CLEAR ACK instead of issuing the CDB block move
directly.

Signed-off-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/scsi/ncr53c710.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 1559a9fbd1..231e9ffc18 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -1181,6 +1181,16 @@ again:
                 }
                 if (insn & (1 << 6)) {
                     s->sbcl &= ~LSI_SBCL_ACK;
+                    /*
+                     * Releasing ACK on the last byte of a declined negotiation
+                     * MESSAGE REJECT lets the target move on to COMMAND.  HP-UX
+                     * 9 tests the phase with JUMP WHEN COMMAND after CLEAR ACK
+                     * instead of issuing the CDB block move directly.
+                     */
+                    if ((s->sstat2 & PHASE_MASK) == PHASE_MI && s->msg_len == 0 &&
+                        s->msg_action == LSI_MSG_ACTION_COMMAND) {
+                        lsi_set_phase(s, PHASE_CMD);
+                    }
                 }
                 if (insn & (1 << 10)) {
                     s->carry = 0;
-- 
2.54.0


