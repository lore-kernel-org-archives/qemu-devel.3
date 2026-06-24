Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16FDCDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcFn8-0004uC-K2; Wed, 24 Jun 2026 01:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFn4-0004ro-Cx; Wed, 24 Jun 2026 01:04:46 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFn2-0005JA-S8; Wed, 24 Jun 2026 01:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782277464; bh=HqZCh4j+bouB9gAQwzlePNf2AKvJxno0DAMzcBVR8YU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=n4V47BtJqSIFj8fDt7a5qpGQzETsLXMwVXpDDtzIizQ0eosPVmo9Z5Zhq25i91mbH
 bpXe98Q1jwfX/zT4f8Rv09n4Vp7GCnUIGPOnr/grOQrfULwsEL4E1Igz7u0SMMCg5f
 fTFqgaL4+YmpJTe9AacF7bzb4++BtzTNg0t7yJUqhPf6R/6ocI3wOXmMTF9QANOUBn
 94dugVK1SBzjrPLLFE8a58FSXcT6V8nSNA2gX60UVA0287iTLbVxcEAVsI/BaAxZVW
 pPNceH5aTkeCiwBt3g3ZhByh3uNz6RRiK7Bnh62gV27BRYjUma4lgXo1mrghW/q6EW
 C/rCoSWZl3VCQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CBCD01BA635;
 Wed, 24 Jun 2026 08:04:24 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B4EF13DDAC0;
 Wed, 24 Jun 2026 08:04:29 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.11 66/86] target/riscv/csr.c: do not allow mstatus
 MPV/GVA writes
Date: Wed, 24 Jun 2026 08:02:37 +0300
Message-ID: <20260624050404.394225-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.11-20260624080222@cover.tls.msk.ru>
References: <qemu-stable-10.0.11-20260624080222@cover.tls.msk.ru>
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

The priv spec states the following about mstatus.MPV:

"The MPV bit (Machine Previous Virtualization Mode) is written by the
implementation whenever a trap is taken into M-mode."

And, about mstatus.GVA:

"Field GVA (Guest Virtual Address) is written by the implementation
whenever a trap is taken into M-mode."

Both are written during riscv_cpu_do_interrupt().  They're not supposed
to be written by userspace.  As far as write_mstatus goes these fields
are read only.  The same applies for mstatush.MPV/mstatush.GVA.

Fixes: 03dd405dd5 ("target/riscv: Support MSTATUS.MPV/GVA only when RVH is enabled")
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260514194537.2416243-2-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 18645f19578955ec5ff2c40cd2c8753d6bc460c2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index a62b16feae..5e1b840087 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2014,9 +2014,6 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
     }
 
     if (xl != MXL_RV32 || env->debugger) {
-        if (riscv_has_ext(env, RVH)) {
-            mask |= MSTATUS_MPV | MSTATUS_GVA;
-        }
         if ((val & MSTATUS64_UXL) != 0) {
             mask |= MSTATUS64_UXL;
         }
@@ -2053,7 +2050,7 @@ static RISCVException write_mstatush(CPURISCVState *env, int csrno,
                                      target_ulong val)
 {
     uint64_t valh = (uint64_t)val << 32;
-    uint64_t mask = riscv_has_ext(env, RVH) ? MSTATUS_MPV | MSTATUS_GVA : 0;
+    uint64_t mask = 0;
 
     if (riscv_cpu_cfg(env)->ext_smdbltrp) {
         mask |= MSTATUS_MDT;
-- 
2.47.3


