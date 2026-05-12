Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E3BCD4F3E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuLQ-0003AO-QF; Tue, 12 May 2026 17:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuKK-0000i0-Qn; Tue, 12 May 2026 17:07:46 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuKH-0002Xs-2H; Tue, 12 May 2026 17:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619300; bh=11vdCVxz4OPM4+qs63moEE216t2sf25/9l8vEgzPS5I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=vx9ikyFcnSnJoOIeLc8YGSKa0D2zrDcS08Ce04Mw433ydmp6wQr8bQZHpVrtH4TjI
 HwndSXRDzdUU7lpClGq+qnx/Sn8H8AsFMIi4iI2kmeuvwqjAdKDaqLjSLUSiVbEZfl
 6u4s7LsJed7DbTFzFtRkJTUrzKi6ic7/Py9E0dEfhre5uaGdh6MtgmMtYmlFO5U40Q
 s1c8tvp9ZZGwCT+SoQKZUdh+IMN06yYMrotN/xDX9INnyLPniaMfKXPBEOfD5TlcV8
 OzSfJ7s+lYu/ejpqso15GIpmc5qmq0+eVR7ER29ci9rWteI198hZdL/xKjHsfsrW0W
 TGveQAIvQXFmg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DA1971AA34D;
 Tue, 12 May 2026 23:55:00 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E6EFC3ABCBE;
 Tue, 12 May 2026 23:55:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 017/117] target/riscv: rvv: Fix page probe issues in
 vext_ldff
Date: Tue, 12 May 2026 23:53:19 +0300
Message-ID: <20260512205503.361097-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Max Chou <max.chou@sifive.com>

Commit 17288e38bebf ("optimize the memory probing for vector
fault-only-first loads") introduced an optimization that moved from
per-element probing to a fast-path broad probe. Unfortunately it
introduced following bugs in cross-page handling:

- Wrong condition for second page probing: checked "env->vl > elems"
  instead of "env->vl > elems + env->vstart", failing to account for
  the vstart offset.

- Incorrect second page address calculation: used
  "addr + (elems << log2_esz)" instead of "addr + page_split".
  For segment loads (nf > 1), this would probe the wrong address,not
  at the page boundary.

- Wrong second page probe size: used "elems * msize" (the first page
  size) instead of calculating the remaining size as
  "(env->vl - env->vstart) * msize - page_split". This would probe
  too little memory and could miss faults.

This commit fixes these bugs by leveraging the probe_pages helper
which automatically handles cross-page memory accesses correctly.

Fixes: 17288e38bebf ("optimize the memory probing for vector fault-only-first loads.")

Signed-off-by: Max Chou <max.chou@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260318013805.1920377-3-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 0e8ad6a8460fe070ecdde4625e4ed6d791550e3d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 2d0e4e4d33..6c0de3f82d 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -658,9 +658,9 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
     uint32_t esz = 1 << log2_esz;
     uint32_t msize = nf * esz;
     uint32_t vma = vext_vma(desc);
-    target_ulong addr, addr_probe, addr_i, offset, remain, page_split, elems;
+    target_ulong addr, addr_i, offset, remain, page_split, elems;
     int mmu_index = riscv_env_mmu_index(env, false);
-    int flags, probe_flags;
+    int flags;
     void *host;
 
     VSTART_CHECK_EARLY_EXIT(env, env->vl);
@@ -674,16 +674,8 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
     }
 
     /* Check page permission/pmp/watchpoint/etc. */
-    probe_pages(env, addr, elems * msize, ra, MMU_DATA_LOAD, mmu_index, &host,
-                &flags, true);
-
-    /* If we are crossing a page check also the second page. */
-    if (env->vl > elems) {
-        addr_probe = addr + (elems << log2_esz);
-        probe_pages(env, addr_probe, elems * msize, ra, MMU_DATA_LOAD,
-                    mmu_index, &host, &probe_flags, true);
-        flags |= probe_flags;
-    }
+    probe_pages(env, addr, (env->vl - env->vstart) * msize, ra, MMU_DATA_LOAD,
+                mmu_index, &host, &flags, true);
 
     if (flags & ~TLB_WATCHPOINT) {
         /* probe every access */
-- 
2.47.3


