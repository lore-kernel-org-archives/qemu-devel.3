Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B228F606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=grjJc6lM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVXkg-0006jy-HO; Mon, 23 Nov 2026 12:22:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xVXkU-0006e1-0g
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:22:38 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xVXkS-0003sm-67
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:22:37 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1E24161192;
 Mon, 23 Nov 2026 17:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC891F000CF;
 Mon, 23 Nov 2026 17:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795454554;
 bh=RHNTg7ttLCw26zTHEE3mnTGVZ9EgNdMH1BxJKPoTfME=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=grjJc6lMAzT3EF8ngcErc90/n/yi6B5r/Tjan90+ji8kAE+iC+pEmaOIBXq4140jL
 4NEs1q+5wnkWpYfWak6oMGoIGWnmC7VG60Sst7cm4xwn3iaFMB9Qdh6TxWPHs5kkmp
 AVl61wjPc/6Kffu0D4JZ/8e/73BMA0GF0Z0ZAVeSvV0uswoUJsflL1ifa5Gzr2GCk2
 idDvjUTMW821jiTkb4i3qasyy5F2UjKEOoj4H8lrFtsqi8/5+vkPwXdd/UHWzDy886
 lvuWZI2bAu5nur+Imy3vJF8p5eR6s1KHcOmW00HVUPXkfxXNpqKY09u1hI+ZF3CktR
 G07wKx2eACkaQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Keith Monahan <keith@techtravels.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH 13/14] hw/scsi/ncr53c710: Document the SIGP latch deviation
Date: Mon, 23 Nov 2026 18:21:50 +0100
Message-ID: <20261123172151.7605-14-deller@kernel.org>
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Comment only, no functional change.  The data manual describes SIGP
(ISTAT bit 5) as a read/write flag that stays set until reset by the
CPU, either through ISTAT or by reading CTEST2.  The emulation drops
the bit at once when it is set while the engine is halted and
remembers the kick in sigp_pending_resume instead.  Note the
deviation at the code.  The reason is not documented in the history.

AI-used-for: Patch series decomposition (commit splitting and ordering)
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/scsi/ncr53c710.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index b7fc97b93b..a77705eeda 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -1525,6 +1525,14 @@ static void lsi_reg_writeb(NCR710State *s, int offset, uint8_t val)
              * Reselect consumption would, without disturbing the pending
              * completion.  Remember the kick so the next command is selected
              * once the engine parks again at Wait Reselect.
+             *
+             * This deviates from the data manual, which describes SIGP as a
+             * read/write flag that stays set until the CPU resets it, either
+             * via ISTAT or by reading CTEST2: here a halted engine drops the
+             * bit at once, so a read of ISTAT or CTEST2 no longer sees it.
+             * The reason is not documented beyond the commit that added
+             * sigp_pending_resume (6bf09c62fa), which only says that a kick
+             * on a stopped engine is held and replayed once the engine parks.
              */
             s->istat &= ~LSI_ISTAT0_SIGP;
             s->sigp_pending_resume = true;
-- 
2.54.0


