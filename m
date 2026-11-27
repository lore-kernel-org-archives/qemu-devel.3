Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7473A606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F3ooy7zV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX1PF-0002oN-AD; Fri, 27 Nov 2026 14:14:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xX1Nw-0001t8-Ss; Fri, 27 Nov 2026 14:13:29 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xX1Nu-0007NY-1T; Fri, 27 Nov 2026 14:13:27 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CB35742B9B;
 Fri, 27 Nov 2026 19:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4641F00898;
 Fri, 27 Nov 2026 19:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795806804;
 bh=71ol14pMDqXmxoUQL+BUY6CQ2OI0HWn3mjoVb/ADuBs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=F3ooy7zVQD0QtR43CPUs1gBtNFGvVKOwR128YLOHSHTJceewtvdyxAffaML/h337O
 vZpUAH/ZY+akcfTqOidspyFrjknHPqEX5TYsCQZAOPEL27EnAnR+Mfq3IRCKD0km5B
 sthzHucJdwurqyIVnCBLqGajRdkKsZY1nc3WuxH8mLPaBkAwJtO86Z0BKPFLTbHnlm
 2hy2W/blP3u2ceHWXK4b+iRu5NipxuMZgb4rnIxEWYMDvOtN+uoPHm4FEFo0gDyUEC
 sZxSsKrA1XBAtIh8x/MWfmIcFfsV+QCnU3Y5hB0a/Jdt8jjOS66pRAPnjGVlBmaoPp
 4VeLMEY3uUhRA==
From: Niklas Cassel <cassel@kernel.org>
To: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 10/13] tests/qtest/libqos: skip some checks for commands
 expected to fail
Date: Fri, 27 Nov 2026 20:12:45 +0100
Message-ID: <20261127191250.3298004-11-cassel@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127191250.3298004-1-cassel@kernel.org>
References: <20261127191250.3298004-1-cassel@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=cassel@kernel.org;
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

A command that fails with an error may transfer fewer bytes than
requested, or none at all. In this case  the device sends no PIO Setup
FIS. For example, a READ SECTORS EXT or READ DMA EXT of a sector past
the end of the disk is aborted before any data is transferred.
Thus PRDBC stays 0, and the PIO read gets no PIO Setup FIS, so
ahci_command_verify() fails although the command failed as expected.

Skip the PRDBC and PIO Setup FIS checks for commands that are expected
to fail.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 tests/qtest/libqos/ahci.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index a4790c2f0c..cd6f75331e 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -586,8 +586,12 @@ void ahci_port_check_cmd_sanity(AHCIQState *ahci, AHCICommand *cmd)
     AHCICommandHeader cmdh;
 
     ahci_get_command_header(ahci, cmd->port, cmd->slot, &cmdh);
-    /* Physical Region Descriptor Byte Count is not required to work for NCQ. */
-    if (!cmd->props->ncq) {
+    /*
+     * Physical Region Descriptor Byte Count is not required to work for NCQ.
+     * A command that failed with an error may also have transferred fewer
+     * bytes than requested, so skip the check when an error is expected.
+     */
+    if (!cmd->props->ncq && !cmd->errors) {
         g_assert_cmphex(cmd->xbytes, ==, cmdh.prdbc);
     }
 }
@@ -1347,7 +1351,8 @@ void ahci_command_verify(AHCIQState *ahci, AHCICommand *cmd)
     if (cmd->interrupts & AHCI_PX_IS_DHRS) {
         ahci_port_check_d2h_sanity(ahci, port, slot);
     }
-    if (cmd->props->pio) {
+    /* A command aborted before any data transfer gets no PIO Setup FIS */
+    if (cmd->props->pio && !cmd->errors) {
         ahci_port_check_pio_sanity(ahci, cmd);
     }
 }
-- 
2.56.1


