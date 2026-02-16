Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6780DE81A42
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 16:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs1Pb-0008WL-Ra; Mon, 16 Feb 2026 11:25:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vs1PV-0008Rs-Ql
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 11:25:22 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vs1PT-0002jE-At
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 11:25:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=PbZj+MJ7ZvB1UDK3MKfN9VG/9j0a+ZXm8vyyR4l7ieE=; b=d0eSfVsrOx/r6mf
 g2mn4AJ3WBwYsxxCkjqeSTxdQ96oxaeoUQIR1NUHCehetwA5NcNMCuBV02nILikz1C/+1iFiNJK9a
 bmOSpZemv8HV+tWqUA1XJYDnNBAQPcz+3UqkqiDhWgQlZYYJwD0TkTFeENu1SPv1ZVDYR4KMT0cVv
 xg=;
Date: Mon, 16 Feb 2026 17:28:38 +0100
Subject: [PATCH v5 1/7] target/hppa: Define PA[20|1X] physical address
 space size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-phys_addr-v5-1-29d522f1339c@rev.ng>
References: <20260216-phys_addr-v5-0-29d522f1339c@rev.ng>
In-Reply-To: <20260216-phys_addr-v5-0-29d522f1339c@rev.ng>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Anton Johansson <anjo@rev.ng>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771259334; l=3909;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=mJLHJbLS4Uz8+yGhmilwJgwYd61Krwd2i3KjZETkFK4=;
 b=WV8OfSSFxcYKdangHeDgRjXKUfikwbc0Ru/40VTu/Bsys1E+SCc+66aGX+Ufv4ZYrSTK1avK+
 ofa67S7rhK2B0sELkXr2EtDlcfyQzyfx6kSS+sZhyr5QKke8O+cCGFD
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When converting virtual to physical addresses,
TARGET_PHYS_ADDR_SPACE_BITS is used under PA-RISC 2.0, and an explicit
cast to uint32_t is used under PA-RISC 1.X.  Replace the former with a
more specific macro limited to mem_helper.c, and make the latter
conversion explicit by defining the size of the physical address space
for PA-RISC 1.X.

Note: while 44 bits should be used for the 64-bit address space running
a C3700, 40 bits is still chosen as this is expected by the SeaBIOS
functional test.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hppa/cpu.h        |  1 +
 target/hppa/mem_helper.c | 32 +++++++++++++++++++++++++++-----
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 012e54f8f6..092e647ccf 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -336,6 +336,7 @@ static inline vaddr hppa_form_gva(CPUHPPAState *env, uint64_t spc,
     return hppa_form_gva_mask(env->gva_offset_mask, spc, off);
 }
 
+hwaddr hppa_abs_to_phys_pa1x(vaddr addr);
 hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr);
 hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr);
 
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index cce82e6599..9199d1e06a 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -29,6 +29,28 @@
 #include "hw/core/cpu.h"
 #include "trace.h"
 
+/*
+ * 64-bit (PA-RISC 2.0) machines are assumed to run PA-8700, and 32-bit
+ * machines 7300LC.  This should give 44 and 32 bits of physical address
+ * space respectively.
+ *
+ *   CPU model        Physical address space bits
+ *   PA-7000--7300LC  32
+ *   PA-8000--8600    40
+ *   PA-8700--8900    44
+ *
+ * FIXME: However, the SeaBIOS firmware that is that tested against
+ * uses 40-bit physical addresses, despite supposedly running a C3700
+ * with a PA-8700 cpu, so use 40-bits for 64-bit.
+ */
+#define HPPA_PHYS_ADDR_SPACE_BITS_PA20 40
+#define HPPA_PHYS_ADDR_SPACE_BITS_PA1X 32
+
+hwaddr hppa_abs_to_phys_pa1x(vaddr addr)
+{
+    return extract64(addr, 0, HPPA_PHYS_ADDR_SPACE_BITS_PA1X);
+}
+
 hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr)
 {
     /*
@@ -42,8 +64,8 @@ hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr)
      * Since the supported physical address space is below 54 bits, the
      * H-8 algorithm is moot and all that is left is to truncate.
      */
-    QEMU_BUILD_BUG_ON(TARGET_PHYS_ADDR_SPACE_BITS > 54);
-    return sextract64(addr, 0, TARGET_PHYS_ADDR_SPACE_BITS);
+    QEMU_BUILD_BUG_ON(HPPA_PHYS_ADDR_SPACE_BITS_PA20 > 54);
+    return sextract64(addr, 0, HPPA_PHYS_ADDR_SPACE_BITS_PA20);
 }
 
 hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr)
@@ -67,7 +89,7 @@ hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr)
          * is what can be seen on physical machines too.
          */
         addr = (uint32_t)addr;
-        addr |= -1ull << (TARGET_PHYS_ADDR_SPACE_BITS - 4);
+        addr |= -1ull << (HPPA_PHYS_ADDR_SPACE_BITS_PA20 - 4);
     }
     return addr;
 }
@@ -217,7 +239,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
             if (hppa_is_pa20(env)) {
                 phys = hppa_abs_to_phys_pa2_w0(addr);
             } else {
-                phys = (uint32_t)addr;
+                phys = hppa_abs_to_phys_pa1x(addr);
             }
             break;
         default:
@@ -558,7 +580,7 @@ static void itlbt_pa20(CPUHPPAState *env, target_ulong r1,
     /* Align per the page size. */
     ent->pa &= TARGET_PAGE_MASK << mask_shift;
     /* Ignore the bits beyond physical address space. */
-    ent->pa = sextract64(ent->pa, 0, TARGET_PHYS_ADDR_SPACE_BITS);
+    ent->pa = sextract64(ent->pa, 0, HPPA_PHYS_ADDR_SPACE_BITS_PA20);
 
     ent->t = extract64(r2, 61, 1);
     ent->d = extract64(r2, 60, 1);

-- 
2.52.0


