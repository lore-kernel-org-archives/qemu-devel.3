Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04248606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 21:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PnnGZGan
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLp5o-0002yZ-0K; Tue, 27 Oct 2026 17:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xLp5j-0002xo-T6
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 17:52:24 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xLp5i-00007r-7O
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 17:52:23 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6CF4160136;
 Tue, 27 Oct 2026 21:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72131F01825;
 Tue, 27 Oct 2026 21:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793137941;
 bh=bTBTtjYW8t5JMYhZRolyj7KJl2yanea6gt+IEaYH3eM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PnnGZGanaQwzBu2QDp2ZtwarBF8H22ys/q/4B+pvYFX9W8lxQ4s4L3CSMCW7HXL+S
 F8OCzFnuBtL6n3denmHikmsUw8m9/u5J+S+xinZKNQFOc7s6YC3DEs0+ib0QEdUitt
 SK/2oiumLRVp5edUH4IA++ixFl9XbGLOC5UK66lRWFf8TV04l9A/bxV0aeYp3qEKKS
 KpV8yBdvPqGP24WRhQ8wsqyKrbNHigIsR8nRILI5hgFzLyxjYjtU07JyfDjaw61g41
 vlnv0W0FOWa7mnj3X4YfXrK/fqVbXqp04HarSgTjNvwTu0l2R1Y/xTLDT7rNmChk9T
 uU4BowYBU2apw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Keith Monahan <keith@techtravels.org>,
 "Kirill A . Korinsky" <kirill@korins.ky>, Helge Deller <deller@gmx.de>
Subject: [PATCH 5/8] target/hppa: Preload I/O-space BTLB entries for LASI and
 the central bus
Date: Tue, 27 Oct 2026 22:52:06 +0100
Message-ID: <20261027215209.21150-6-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027215209.21150-1-deller@kernel.org>
References: <20261027215209.21150-1-deller@kernel.org>
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keith Monahan <keith@techtravels.org>

Set up the BTLB to allow operating systems to access LASI and central
bus addresses.

Signed-off-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 8d378385b2..e403ae5fc9 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -896,6 +896,38 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
         cpu[i]->env.gr[5] = CPU_HPA + i * 0x1000;
     }
 
+    /*
+     * BTLB equivalence maps for the I/O ranges HP-UX 9 uses
+     * without creating page directory entries: the LASI block and the
+     * central bus (CPU HPA, broadcast).  Must not cover other I/O space, as
+     * HP-UX probes with LPA and skips pdir setup for already mapped pages.
+     */
+    if (!hppa_is_pa20(&cpu[0]->env)) {
+        static const struct { uint32_t start, last; } io_btlb[] = {
+            { 0xf0100000, 0xf01fffff },     /* LASI */
+            { 0xfff80000, 0xffffffff },     /* central bus */
+        };
+        CPUHPPAState *env = &cpu[0]->env;
+
+        for (i = 0; i < ARRAY_SIZE(io_btlb); i++) {
+            HPPATLBEntry *ent = &env->tlb[HPPA_BTLB_ENTRIES(env) - 1 - i];
+
+            ent->itree.start = io_btlb[i].start;
+            ent->itree.last = io_btlb[i].last;
+            ent->pa = io_btlb[i].start;
+            ent->access_id = 0;
+            ent->u = 1;
+            ent->ar_pl2 = 0;
+            ent->ar_pl1 = 0;
+            ent->ar_type = 1;
+            ent->b = 0;
+            ent->d = 1;
+            ent->t = 0;
+            ent->entry_valid = 1;
+            interval_tree_insert(&ent->itree, &env->tlb_root);
+        }
+    }
+
     cpu[0]->env.gr[26] = ms->ram_size;
     cpu[0]->env.gr[25] = cpu[0]->env.kernel_entry;
     cpu[0]->env.gr[24] = cpu[0]->env.cmdline_or_bootorder;
-- 
2.54.0


