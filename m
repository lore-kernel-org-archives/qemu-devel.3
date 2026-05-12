Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB5CCD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuGq-0004CE-V9; Tue, 12 May 2026 17:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuFm-0001RX-8T; Tue, 12 May 2026 17:03:00 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuFk-0007iG-HI; Tue, 12 May 2026 17:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619278; bh=47PV4KDwdEjUMJ/Zc8drwI4urMG+7UCxJfkg0P8+Zfs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kJKlItkY1tm64jGTjwjufwGUYTfeqwZ6bErFb4STlUeZeWX2fHZ8ouMJ/rIEkWCCL
 hRxRhmzvfr5ltjPRU8nOI40JhI/yHZquc2SC59NFPNVdebfRmsT1XG019BvreQPSe/
 3qccLDSaCeV95k3sQpIpVn6rGRrTEbOT/yfeYnW8KDLBsT+QNKU+DBI3fe8aID3Mvy
 /DER0bUo8c+vAjQIGGkgqH/TcHoNapyoynU52jksm1l/deEbbsoVhBFm3EaYh4bje+
 7N4HGRzHgFK3+OKdKrWeHla9RZ/KBWJVHhmqmj5wQW7PgLV3URoODeNO8U5ZETygTm
 Edz7KsjfJZtgg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D0EA81AA31F;
 Tue, 12 May 2026 23:54:38 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id DD8A63ABC90;
 Tue, 12 May 2026 23:54:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Sebasti=C3=A1n=20Alba=20Vives?= <sebasjosue84@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 083/107] target/riscv: fix stale ptshift and base on
 page walk restart
Date: Tue, 12 May 2026 23:54:10 +0300
Message-ID: <20260512205437.360850-83-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Sebastián Alba Vives <sebasjosue84@gmail.com>

When the atomic compare-and-swap for updating A/D bits in the page
table entry fails due to a concurrent PTE modification by another
vCPU, get_physical_address() jumps to the 'restart' label to re-walk
the page table from the root.

However, neither 'ptshift' nor 'base' are re-initialized before the
restart. After the walk completes, ptshift has been decremented to
its final value and base has been overwritten with an inner PTE PPN.
On goto restart, the for loop resets i=0 but ptshift and base remain
stale, causing the restarted walk to compute incorrect PTE addresses.

In an SMP guest with MTTCG and Svadu active, this can result in
incorrect physical address mappings or guest crashes.

Fix by saving the root base address and re-initializing both ptshift
and base on each restart.

Fixes: 0c3e702aca ("RISC-V CPU Helpers")
Signed-off-by: Sebastián Alba Vives <sebasjosue84@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260401053853.10473-1-sebasjosue84@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit b2e874bfec59f6150b49a70df0529458efa0726b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 25619c556c..59f6d00774 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1410,12 +1410,15 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
         adue = adue && (env->henvcfg & HENVCFG_ADUE);
     }
 
-    int ptshift = (levels - 1) * ptidxbits;
+    int ptshift;
     target_ulong pte;
     hwaddr pte_addr;
+    const hwaddr base_root = base;
     int i;
 
  restart:
+    ptshift = (levels - 1) * ptidxbits;
+    base = base_root;
     for (i = 0; i < levels; i++, ptshift -= ptidxbits) {
         target_ulong idx;
         if (i == 0) {
-- 
2.47.3


