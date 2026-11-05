Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12620606A32C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 22:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HgkiY9Ni
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP5zx-0004AA-Gs; Thu, 05 Nov 2026 17:31:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xP5zX-00046j-3v
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 17:31:32 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xP5zV-0002Jk-Kz
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 17:31:30 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0774C601BF;
 Thu,  5 Nov 2026 22:31:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3261F0089F;
 Thu,  5 Nov 2026 22:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793917888;
 bh=Lwvle8kftyMyVUaATfFKVfk9F/eF+2p2rQi5EtyLBX4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HgkiY9NiyLB/MgAJ86rY4SjgZJMY3Q3Cg3x6zTfS38XpnwgW6XiPCi4S1ROBBNEWb
 /jYKiPChab4Cns3oo55hXQLC4TbhlBFriZQo6sf9g/fkGHl/w2jNFQ2V1u84DIAnBC
 FsmtnjiXlcBg74E3RyloxAno9qc9vZwuv+TCwyXxo6QQNnPhxF37C1ID8M0//vjqM+
 2EIYAAeAxoB8BzYTJ4qwpaYgx7XbYD5wR6OjWp19RHulJXZxykahGUAV4NsAth3e4f
 xD+wxpvBgx7iv7Qph0wS7jMYdUvgrEyg/pUD6a6UPIKlZwlvhJtxvbooBP6bEMZm9/
 d02Vbi3sgIBNg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL v2 2/8] target/hppa: Add special blr instruction for HP-UX 9.05
Date: Thu,  5 Nov 2026 23:31:16 +0100
Message-ID: <20261105223122.8729-3-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105223122.8729-1-deller@kernel.org>
References: <20261105223122.8729-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

From: Helge Deller <deller@gmx.de>

The HP-UX 9.05 installer's update executable use a branch instruction with
reserved bits set.  Real hardware ignores those bits, but QEMU treated the
instruction as illegal and killed the program.  Add an entry to handle this
specific blr instruction (code 0xe81a4018) to avoid this crash.

Noticed-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/insns.decode | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index f700fe472e..135f563c88 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -451,6 +451,7 @@ bl              111010 ..... ..... 101 ........... n:1 .        &BL l=2 \
                 disp=%assemble_22
 b_gate          111010 ..... ..... 001 ........... .   .        @bl
 blr             111010 l:5   x:5   010 00000000000 n:1 0
+blr             111010 l:5   x:5   010 00000000110 n:1 0    # invalid BLR used in HP-UX 9.05 installer (0xe81a4018)
 nopbts          111010 00000 00000 010 0---------1   0 1    # clrbts/popbts
 nopbts          111010 00000 ----- 010 00000000000   0 1    # pushbts/pushnom
 bv              111010 b:5   x:5   110 00000000000 n:1 0
-- 
2.54.0


