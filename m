Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D120F606A32E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYd8HDRo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOZJy-0003a7-7c; Wed, 04 Nov 2026 06:38:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kaloz@kernel.org>) id 1xOZJw-0003Zp-2b
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 06:38:24 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kaloz@kernel.org>) id 1xOZJu-0005EB-8X
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 06:38:23 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C6C0A40505;
 Wed,  4 Nov 2026 11:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9948E1F000C1;
 Wed,  4 Nov 2026 11:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793792300;
 bh=4Qeo19hFH4X1yLraKKXMji/nOejQ/RP/9d9wqpmz9/c=;
 h=From:To:Cc:Subject:Date;
 b=AYd8HDRobSWNQT6Rk5ZDnWVYe1Xf8eBZtQLXvlBTYBXTkpkWl2sM59jHmKIBtSgfm
 2prPXiAiUlb9VSNd4Gv5Gt73P/PGZKAusg1KDxpRJk1gAY4/URjjsLAPC2/KA6Ut/5
 gXBPyD2OOvZyw5B5ZHZSQ1Kb0G4G6d1jzY4t9UHWK9Yo/fnVpIpajWpS8FHqTdEPnv
 ZtyfSjzOO0JxBP7WH4f0+2XTc53PRxGwOgEhquzDxGuFfyOdOmI3lMetmkgspBgSYm
 64Q8wNje+3QGxeEYiFxoGO9XDvnYFUp+VtuPknkryCy9ST9KHLrTIjy5KaU3+035KE
 JOs2tNAXvMfow==
From: Imre Kaloz <kaloz@kernel.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH] target/sparc: fix TI-SuperSparc-61 PSR version
Date: Wed,  4 Nov 2026 12:37:02 +0100
Message-ID: <20261104113702.12701-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=kaloz@kernel.org;
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

Real SuperSPARC modules report PSR version 0, as the TI-SuperSparc-51
model already does. 0x44 makes Linux treat the CPU as an unknown
implementation and halt early in boot.

Fixes: 406f82e83386 (" More CPU definitions")
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 target/sparc/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 28ae629d50..71ae9f05c5 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -490,7 +490,7 @@ static const sparc_def_t sparc_defs[] = {
     },
     {
         .name = "TI-SuperSparc-61",
-        .iu_version = 0x44000000, /* SuperSPARC 3.x */
+        .iu_version = 0x40000000, /* SuperSPARC 3.x */
         .fpu_version = 0 << FSR_VER_SHIFT,
         .mmu_version = 0x01000000, /* SuperSPARC 3.x, MXCC */
         .mmu_bm = 0x00002000,

base-commit: 33eb51c859834f2024090bf843c69814267b6c26
-- 
2.47.3


