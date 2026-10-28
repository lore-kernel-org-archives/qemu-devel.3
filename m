Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FB7606AB02
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FVYrz07P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM8za-00009e-7H; Wed, 28 Oct 2026 15:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xM8zT-0008UE-Ew
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:07:15 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xM8zR-0004Kj-Tx
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:07:15 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0513341941;
 Wed, 28 Oct 2026 19:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30A41F01825;
 Wed, 28 Oct 2026 19:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793214432;
 bh=bTBTtjYW8t5JMYhZRolyj7KJl2yanea6gt+IEaYH3eM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FVYrz07P2LHlrpMVJay5/8yfgj6sUDxbTRw+rvk1bcx5BULyE9INukrYA5eWsQYN7
 kiFHJ/+2TgXg2A4Q3fs7Cx7wHfoWrpj9+1M8aEXP3IY+pK0DptY9tN6zJddVQBeXF4
 11Wsy6dC0aEwUFdyKD5ap7nPWBYm7BN7v8AJO+KfE48VlSSRI4BrGwshHkjJ2pje9w
 Y6qbMUL5zk5qY/UJFSLHBMcGR7GXMbk7MtL6tzTB37JZfKlrGXcAedDkM6d477mS2U
 QfNVtbny5ejgGaoa5MJm7kDYZSR3Dy7DADkmJ+fxnivpJ6QMJy2FEe5RZnRGLmWxDU
 VFYLSs8l8/hdg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, "Kirill A . Korinsky" <kirill@korins.ky>
Subject: [PULL v2 5/9] target/hppa: Preload I/O-space BTLB entries for LASI
 and the central bus
Date: Wed, 28 Oct 2026 20:06:57 +0100
Message-ID: <20261028190701.17272-6-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028190701.17272-1-deller@kernel.org>
References: <20261028190701.17272-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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


