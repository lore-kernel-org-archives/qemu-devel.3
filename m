Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831CD1076387
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 17:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7z0O-0000vL-Pu; Wed, 01 Apr 2026 13:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w7z09-0000pk-O0
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 13:05:11 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w7z07-0007ss-A9
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 13:05:08 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 ff02f649880f4c1d5d70100ea9aa6e7e10e475320cb5153f37db282a819a7e15 with SMTP id
 69cd503a909492175f9ecf6f; Wed, 01 Apr 2026 17:04:58 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1775063098;
 bh=sbl1/SbOW5RNXGHHar18gl/ANw6AoNz11ZBRCd42A2E=;
 h=X-Mailgun-Dkim:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:From:Reply-to:
 Subject:Date:Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=DhaU0sya4y8ECW/vFKKDG5ogOzFK5AalKAx6xq+fISybhtbjKZKPdQKU9ZrgEoWoM
 X1ryqziLXsm0RFuOC4uvZ+p5hxE+SKt5yvp6QndFcc3LvrcUrqoAgSTCVkt2k+cw+S
 zq1POc88TbK9ejvPTMf/qH0ktHRzF1pXjO4blrJUJVVBORkYxU5DSHSDaHWdni608w
 4SfTz6Jh9LxdMLOFZVlJLFbiaMNr/zVTKiqXYhf++DTX2z1k7mFH97e39SNQ4i8U70
 8+Kz4gBbpvKP+93GQqZ4CBPGzlQL9nFkbXU4IAs8eWt23f1b0nJhFYZInBsEBNXsoq
 M+PfgLgo1Hq8w==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: "Yodel Eldar" <yodel.eldar@yodel.dev>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yodel Eldar <yodel.eldar@yodel.dev>
Subject: [RFC PATCH 2/4] alpha: Propagate CPU index via MemTxAttrs
Date: Wed,  1 Apr 2026 12:04:52 -0500
Message-ID: <20260401170454.32045-3-yodel.eldar@yodel.dev>
In-Reply-To: <20260401170454.32045-1-yodel.eldar@yodel.dev>
References: <20260401170454.32045-1-yodel.eldar@yodel.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HELO_STATIC_HOST=-0.001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Yodel Eldar <yodel.eldar@yodel.dev>

Currently, a read of the Typhoon Cchip's MISC register
dereferences current_cpu for the CPU index. To decouple
Typhoon from the CPU, let's instead pass the CPU index
through the requester_id attribute of the memory transaction.

Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
 hw/alpha/typhoon.c    |  7 ++++---
 target/alpha/helper.c | 15 ++++++++++++---
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 26580664d8..5dadfa7691 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -74,7 +74,6 @@ static MemTxResult cchip_read(void *opaque, hwaddr addr,
                               uint64_t *data, unsigned size,
                               MemTxAttrs attrs)
 {
-    CPUState *cpu = current_cpu;
     TyphoonState *s = opaque;
     uint64_t ret = 0;
 
@@ -90,10 +89,12 @@ static MemTxResult cchip_read(void *opaque, hwaddr addr,
         /* All sorts of stuff related to real DRAM.  */
         break;
 
-    case 0x0080:
+    case 0x0080: {
         /* MISC: Miscellaneous Register.  */
-        ret = s->cchip.misc | (cpu->cpu_index & 3);
+        uint64_t cpu_index = attrs.requester_id & 3;
+        ret = s->cchip.misc | cpu_index;
         break;
+    }
 
     case 0x00c0:
         /* MPD: Memory Presence Detect Register.  */
diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 179dc2dc7a..bebb0e4804 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -164,13 +164,19 @@ void alpha_cpu_record_sigsegv(CPUState *cs, vaddr address,
     env->trap_arg2 = cause;
 }
 #else
+static inline QEMU_ALWAYS_INLINE
+MemTxAttrs alpha_cpu_get_mem_attrs(const CPUState *cs)
+{
+    return (MemTxAttrs){ .requester_id = cs->cpu_index };
+}
+
 /* Returns the OSF/1 entMM failure indication, or -1 on success.  */
 static int get_physical_address(CPUAlphaState *env, vaddr addr,
                                 int prot_need, int mmu_idx,
                                 hwaddr *pphys, int *pprot)
 {
-    const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     CPUState *cs = env_cpu(env);
+    const MemTxAttrs attrs = alpha_cpu_get_mem_attrs(cs);
     target_long saddr = addr;
     hwaddr phys = 0;
     uint64_t L1pte, L2pte, L3pte;
@@ -327,8 +333,11 @@ bool alpha_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
         cpu_loop_exit_restore(cs, retaddr);
     }
 
-    tlb_set_page(cs, addr & TARGET_PAGE_MASK, phys & TARGET_PAGE_MASK,
-                 prot, mmu_idx, TARGET_PAGE_SIZE);
+    tlb_set_page_with_attrs(cs, addr & TARGET_PAGE_MASK,
+                            phys & TARGET_PAGE_MASK,
+                            alpha_cpu_get_mem_attrs(cs),
+                            prot, mmu_idx, TARGET_PAGE_SIZE);
+
     return true;
 }
 
-- 
2.53.0


