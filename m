Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4997C2D0A6
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPtI-0003ni-T6; Thu, 15 Oct 2026 14:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPtC-0003lw-Lv
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:15 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPtA-00010h-Ke
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:14 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48af27fe287so678970f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792087750; x=1792692550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Xxm5+YHoURNhPUu0cajg03TE2X7qhBi4NtKKynlLpmc=;
 b=mIGu+IcIMyRFXVMMTeSNfKhU1bTTX72a1/12E510jdaymgL8duGOYeIv9qje9bnSny
 r5wblgJj5QFx3OJATr+q5Cm9yAkLXGTFq9wnOyINeljCFKlUVVNxF2cx/T85Yk6g+6gH
 4hQgw2Z//SOd/ZHFSD3KkDdBPZ7Y+Uai/+0RJSoY7XXYsU8Gaa45vJpCdgqqVyDc+BJW
 xT8H3xx11dFvwBtxK5LPkqTlLsatnoK14UZLhXwz1O9iJVn4jiSMGphr6Ut1cWPXjzWV
 PT0O8YHPl0nUTDGIpkR+K+gQ1nLVKUPre9+gCxRGBzA/rza+dqnGcXgRnLjZCMo9CrKt
 cReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087750; x=1792692550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Xxm5+YHoURNhPUu0cajg03TE2X7qhBi4NtKKynlLpmc=;
 b=fkTWiaFa+0Fa/XBQ/AOEHMNfwSEfWyfqZ1q6OvtZH1CbxCLEYy4kXsQHSphe7rwhCw
 HPtRBYghhYr6CEgTE+8MhVOGyzZX0cA5qRk/bxAVZBouQOSdpVWJBLi56FwXOJWG9JNe
 dMawW1QiJunIE4mZ6lVAmB2KQOoOT/IrCisOh8sKLt+mfvnLkRgER5L9jSo3p+je02oR
 7STTDgKGV2QzeN8a6P4WQ/renuSatwZlHod8X0acmm8TUSN7Kzz8dUZ56LQ3sgEpYwsB
 NVNGCspewZe+IF/q5u7zCFGvYbtllq+e1fyBfhnPVFgkrPG6I7HtHbiyAfIRAMGkcQ30
 Dbaw==
X-Gm-Message-State: AFq9FYLlqS8456J/LCJJE0ep6ryzquRfh/vSJB+JkMZrZ0Ck4cZXtzr3
 KRTAagt2sE2EgtP743pPYt+ioG0Z5CobrSwmqelaBlcCAe3wU22JTDKfrgNA/NoNC7KiybzUZwk
 gL685AkA=
X-Gm-Gg: AYBFou3lz5tJeJnPxbwZuCnhfSROU7UwkUNhFwcryu+5Fqj1iemjSqviz5H0GT0NTGx
 mdOvaMhGBQLgG3nGSvRjhO3rW/mMdkGTMSRQSirWoOLkhUs+SU2pDbzycPTtB/wx0U/QpRJyRvO
 7DYYrayN4XBOfI3RB3UeJwPRQc9czc/IuFC3LlFaV5+rFONdZU5WS6XLDAqKbSuCIzZfuAYxBt4
 FVRszLxyrgYpiEnQ094e/Q3li8zRKtVWVrua5dZzzI9UsEFEmwv+AZui0jxTgLzd8dYbUlNhizM
 qj2ZDTdfIx2797d8wy9BI0BrHOBxDH8mK7DshfTT2OXpwMR08G7wsJErvDJ6JFSVRQ/DqgLb1t0
 5SkZZa4SQtq0kiAyFjyOcyJhXysRTwtgRLiRBPoI5POm7Xfu8sQAx42YqaM00B7PjER6oBekqUm
 23K6fFIyW7Jdu7GOCDBFZC3gVZDZOHUindYZkxM6okoLNFmQ7q5uThEUFwMy1NpWKYGinH7OAtI
 MqzGy5ND0rnhBW5bPyHq8n0qK/j2Nrv6OpuSnvktCmMNT+xGWb9cL7hpnoa3nPtrZLoAvvT3bbJ
 1x4=
X-Received: by 2002:a05:6000:454c:b0:487:c3e:8df8 with SMTP id
 ffacd0b85a97d-48dba77cf87mr28822920f8f.5.1792087750102; 
 Thu, 15 Oct 2026 11:09:10 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de7773d02sm14692701f8f.13.2026.10.15.11.09.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 11:09:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/16] tests/tcg/aarch64: Add a test for a two-entry 52-bit
 TTBR table
Date: Thu, 15 Oct 2026 19:08:48 +0100
Message-ID: <20261015180858.1863407-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015180858.1863407-1-peter.maydell@linaro.org>
References: <20261015180858.1863407-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Fuad Tabba <fuad.tabba@linux.dev>

Add a test checking that, with a 52-bit OA, TTBR[4] of a two-entry
level 0 table is taken only as base address bit 50, not also as bit 4.

Reviewed-by: Gustavo Romero <gromero@redhat.com>
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Message-id: 20261009115728.1299384-3-fuad.tabba@linux.dev
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/aarch64/system/ttbr-baddr.c | 153 ++++++++++++++++++++++++++
 tests/tcg/aarch64/system/meson.build  |   6 +
 2 files changed, 159 insertions(+)
 create mode 100644 tests/tcg/aarch64/system/ttbr-baddr.c

diff --git a/tests/tcg/aarch64/system/ttbr-baddr.c b/tests/tcg/aarch64/system/ttbr-baddr.c
new file mode 100644
index 00000000000..b29c9e1ab0b
--- /dev/null
+++ b/tests/tcg/aarch64/system/ttbr-baddr.c
@@ -0,0 +1,153 @@
+/*
+ * TTBR base address with a 52-bit layout and a small initial lookup table
+ *
+ * With a 52-bit OA, walk a two-entry level 0 table through an IPA with
+ * bit 50 set, which stage 2 maps back onto the table, so the walk
+ * succeeds only if TTBR[4] is cleared from bit 4 of the base address.
+ *
+ * Copyright (c) 2026 Google LLC
+ * Author: Fuad Tabba <fuad.tabba@linux.dev>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdint.h>
+#include <minilib.h>
+
+/* from Linux's include/linux/stringify.h */
+#define __stringify_1(x...) #x
+#define __stringify(x...)   __stringify_1(x)
+
+#define read_sysreg(r) ({                                           \
+            uint64_t __val;                                         \
+            asm volatile("mrs %0, " __stringify(r) : "=r" (__val)); \
+            __val;                                                  \
+})
+
+#define write_sysreg(r, v) do {                     \
+        uint64_t __val = (uint64_t)(v);             \
+        asm volatile("msr " __stringify(r) ", %x0"  \
+                 : : "rZ" (__val));                 \
+} while (0)
+
+/*
+ * kernel.ld links the test at 1GB, so the tables below lie within the
+ * blocks mapped at RAM_BASE.
+ */
+#define RAM_BASE    0x40000000UL
+#define HIGH_IPA    (1UL << 50)
+#define TEST_VA     (0xffff000000000000UL | RAM_BASE)
+
+/*
+ * Stage 1: 16KB granule, 48-bit VA, so level 0 has two entries.
+ * Stage 2: 64KB granule, 52-bit IPA, mapping RAM at its own address and
+ * again at HIGH_IPA.
+ */
+static uint64_t s1_l0[2048] __attribute__((aligned(16384)));
+static uint64_t s1_l1[2048] __attribute__((aligned(16384)));
+static uint64_t s1_l2[2048] __attribute__((aligned(16384)));
+static uint64_t s2_l1[1024] __attribute__((aligned(65536)));
+static uint64_t s2_l2[8192] __attribute__((aligned(65536)));
+static uint64_t s2_l2_high[8192] __attribute__((aligned(65536)));
+
+#define TCR_T0SZ(x)     ((uint64_t)(x) << 0)
+#define TCR_T1SZ(x)     ((uint64_t)(x) << 16)
+#define TCR_TG0_16K     (2UL << 14)
+#define TCR_TG1_16K     (1UL << 30)
+#define TCR_IPS_52      (6UL << 32)
+#define TCR_DS          (1UL << 59)
+
+#define VTCR_T0SZ(x)    ((uint64_t)(x) << 0)
+#define VTCR_SL0_L1     (2UL << 6)
+#define VTCR_TG0_64K    (1UL << 14)
+#define VTCR_PS_52      (6UL << 16)
+#define VTCR_RES1       (1UL << 31)
+
+#define HCR_VM          (1UL << 0)
+#define HCR_RW          (1UL << 31)
+
+#define PAR_F           (1UL << 0)
+#define PAR_PA(par)     ((par) & 0xfffffffff000UL)
+#define S2_BLOCK        ((1 << 10) | (3 << 6) | (0xf << 2) | 1)
+
+static void tlb_flush(void)
+{
+    asm volatile("dsb sy; tlbi alle1; dsb sy; isb" : : : "memory");
+}
+
+static uint64_t at(uint64_t ttbr1)
+{
+    uint64_t par;
+
+    write_sysreg(ttbr1_el1, ttbr1);
+    tlb_flush();
+    asm volatile("at s12e1r, %1; isb; mrs %0, par_el1"
+                 : "=r" (par) : "r" (TEST_VA));
+    return par;
+}
+
+static void setup_tables(void)
+{
+    /* Stage 1: TEST_VA -> RAM_BASE, 32MB block, AF */
+    s1_l0[0] = (uint64_t)s1_l1 | 3;
+    s1_l1[0] = (uint64_t)s1_l2 | 3;
+    s1_l2[(RAM_BASE >> 25) & 0x7ff] = RAM_BASE | (1 << 10) | 1;
+
+    /* Stage 2: 512MB blocks at RAM_BASE and HIGH_IPA | RAM_BASE, AF, RW */
+    s2_l1[0] = (uint64_t)s2_l2 | 3;
+    s2_l1[HIGH_IPA >> 42] = (uint64_t)s2_l2_high | 3;
+    s2_l2[RAM_BASE >> 29] = RAM_BASE | S2_BLOCK;
+    s2_l2_high[RAM_BASE >> 29] = RAM_BASE | S2_BLOCK;
+}
+
+static int check(const char *name, uint64_t par)
+{
+    int ok = !(par & PAR_F) && PAR_PA(par) == RAM_BASE;
+
+    ml_printf("%s: PAR_EL1=%lx %s\n", name, par, ok ? "ok" : "FAIL");
+    return !ok;
+}
+
+int main(void)
+{
+    uint64_t mmfr0 = read_sysreg(id_aa64mmfr0_el1);
+    uint64_t tcr = TCR_T0SZ(16) | TCR_T1SZ(16) | TCR_TG0_16K | TCR_TG1_16K |
+                   TCR_DS;
+    uint64_t base = (uint64_t)s1_l0;
+    int ret = 0;
+
+    ml_printf("TTBR base address test\n");
+
+    /*
+     * PARange 52 bits (FEAT_LPA) and TGran16 with 52-bit addresses
+     * (FEAT_LPA2)
+     */
+    if ((mmfr0 & 0xf) != 6 || ((mmfr0 >> 20) & 0xf) != 2) {
+        ml_printf("SKIP: no 52-bit PA or no FEAT_LPA2 with 16KB\n");
+        return ret;
+    }
+
+    /*
+     * The test runs at EL2 (arg=2) and walks the EL1&0 regime with AT, so
+     * the EL1 MMU settings below only affect those walks.
+     */
+    setup_tables();
+    write_sysreg(mair_el1, 0xff);
+    write_sysreg(sctlr_el1, read_sysreg(sctlr_el1) | 1);
+
+    /*
+     * 52-bit OA: TTBR[4] is base address bit 50, so with it set the
+     * level 0 table is at IPA HIGH_IPA | s1_l0. Stage 2 maps that IPA
+     * onto s1_l0 (through s2_l2_high), so the walk succeeds only if
+     * TTBR[4] does not also offset the two-entry table by 0x10.
+     */
+    write_sysreg(vtcr_el2, VTCR_T0SZ(12) | VTCR_SL0_L1 | VTCR_TG0_64K |
+                 VTCR_PS_52 | VTCR_RES1);
+    write_sysreg(vttbr_el2, (uint64_t)s2_l1);
+    write_sysreg(hcr_el2, HCR_RW | HCR_VM);
+    write_sysreg(tcr_el1, tcr | TCR_IPS_52);
+    ret |= check("ips52", at(base));
+    ret |= check("ips52 ttbr[4]", at(base | (1 << 4)));
+
+    return ret;
+}
diff --git a/tests/tcg/aarch64/system/meson.build b/tests/tcg/aarch64/system/meson.build
index f51feb253f9..270d4d6c311 100644
--- a/tests/tcg/aarch64/system/meson.build
+++ b/tests/tcg/aarch64/system/meson.build
@@ -79,6 +79,12 @@ tests += {
                   '-semihosting-config', 'enable=on,arg=2',
                   qemu_base_args]
   },
+  'ttbr-baddr.c': {
+    'cflags': cflags,
+    'qemu_args': ['-M', 'virt,virtualization=on', '-cpu', 'max',
+                  '-semihosting-config', 'enable=on,arg=2',
+                  qemu_base_args]
+  },
 }
 
 tests += {
-- 
2.43.0


