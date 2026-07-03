Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F86C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 19:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfjcp-0003xa-MI; Fri, 03 Jul 2026 15:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wfjcl-0003wW-CH
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 15:32:31 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wfjck-0000vK-1Y
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 15:32:31 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 70016600AF;
 Fri,  3 Jul 2026 19:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED891F000E9;
 Fri,  3 Jul 2026 19:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783107149;
 bh=JxLmEtpifa7F3Gz8AbUWjkhW2lzFna7h9PEJJmElfgY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aBC8DtFxa1Q/8qWzDUz1zreBAr71K2IM6aG7A1/lhVbA+Se0BBh+8TrMYdTEWrMwc
 oFfodv2Is+VWICNEcEx79Y7Py0aZtgY5UkY2Nc/2taSmVbYmLfmgd1qlkGYh1U/8JI
 Q+f1IdLHR7/lPjQ5+soA0EHw9KP44wn6G3hDndE3c72iV5vjl3A4DS5xVWUHRj38iz
 ew7a+ZU7rmhPJvIPRdsyMFu/c+tOnMz4JoXOtkJZWmiCRGP1dZswnd2Jggyrvx1yEM
 n0UKcNMiJxn93CM59rRozsEdt+KN2RSxpnAOQ7M0Yq4kWJbLoKtKYnVYXs1LrUnzzr
 22PGQWAfDFm7A==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 1/4] target/hppa: Work-around for Fast TLB insert instruction
 on HP-UX 9
Date: Fri,  3 Jul 2026 21:32:21 +0200
Message-ID: <20260703193224.33135-2-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703193224.33135-1-deller@kernel.org>
References: <20260703193224.33135-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Helge Deller <deller@gmx.de>

The HP-UX 9 kernel uses two TLB insert instructions (0x05315440 and
0x05385400), which seem to be wrongly encoded fast TLB instructions, but
similiar to the non-fast instructions idtlba r17,(r9) and
idtlbp r24,(r9).

It's not clear, if those undocumented instructions were used by mistake,
or intentionally. Either way, this patch allows qemu to handle those
instructions, so that a HP-UX 9 boot-CD can now boot somewhat further (but
still crashes due to other reasons afterwards).

Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/insns.decode | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 13c6a55bf2..f700fe472e 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -164,6 +164,8 @@ ixtlbx          000001 b:5 r:5 ... 000000 addr:1 0 00000        \
 
 # pcxl and pcxl2 Fast TLB Insert instructions
 ixtlbxf         000001 00000 r:5 00 0 data:1 01000 addr:1 0 00000
+# workaround for non-standard encoding as used in HP-UX 9
+ixtlbxf         000001 01001 r:5 01 0 data:1 01000 addr:1 0 00000
 
 # pa2.0 tlb insert idtlbt and iitlbt instructions
 ixtlbt          000001 r2:5 r1:5 000 data:1 100000 0 00000    # idtlbt
-- 
2.54.0


