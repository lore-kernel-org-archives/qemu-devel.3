Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D56CDE002
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNrV-0000GT-Or; Wed, 24 Jun 2026 09:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNrB-0008F7-Gy; Wed, 24 Jun 2026 09:41:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNrA-0001rh-0t; Wed, 24 Jun 2026 09:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782308001; bh=IKgs5bsnyOSKcYnwzV+SHFl/xquAUuTC6KqQdb72ZbU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IRMFmP8ALpsMJWGUnmvuMcsdl1hl+nqkNzk7BI7je/a4vpFGKhncMApgKivFeML9j
 QBEpmOtA7rb6f8q0nQQ7mc8nGgCL5UTWMtrAjSoa+5RghVLBKrPOQkHxDMCvnZEbB7
 zgScUqoVvefQxcqnyryKfU0pOc6zNKjCT5kgF5clxt7MQxe1u2a6yBHsyTTXw9PJec
 rw2hWhJwQZSV9Zwvhbvslq2FUh5W66ANdqKo+0i5tdWnMUWhRIsUL3moHJeUddYzVK
 ACAiQoBDwJ3CGOajc2S+JvCQQx4CknDC13p+BHeQY18CTC2kmUhBZhFH7vcm0K50jS
 oRnxNEEuUlBHw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 318591BAA07;
 Wed, 24 Jun 2026 16:33:21 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C1C273DEA56;
 Wed, 24 Jun 2026 16:33:26 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 085/107] target/riscv/csr.c: do not allow mstatus
 MPV/GVA writes
Date: Wed, 24 Jun 2026 16:31:30 +0300
Message-ID: <20260624133301.403266-85-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
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
index 0f14ea4689..ec4aa357b4 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2027,9 +2027,6 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
     }
 
     if (xl != MXL_RV32 || env->debugger) {
-        if (riscv_has_ext(env, RVH)) {
-            mask |= MSTATUS_MPV | MSTATUS_GVA;
-        }
         if ((val & MSTATUS64_UXL) != 0) {
             mask |= MSTATUS64_UXL;
         }
@@ -2066,7 +2063,7 @@ static RISCVException write_mstatush(CPURISCVState *env, int csrno,
                                      target_ulong val, uintptr_t ra)
 {
     uint64_t valh = (uint64_t)val << 32;
-    uint64_t mask = riscv_has_ext(env, RVH) ? MSTATUS_MPV | MSTATUS_GVA : 0;
+    uint64_t mask = 0;
 
     if (riscv_cpu_cfg(env)->ext_smdbltrp) {
         mask |= MSTATUS_MDT;
-- 
2.47.3


