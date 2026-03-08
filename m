Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E2FF55132
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 07:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz8Rg-0002NV-Re; Sun, 08 Mar 2026 03:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8Qz-0001cW-Er
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:20:19 -0400
Received: from mail-dy1-x1343.google.com ([2607:f8b0:4864:20::1343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8Qv-0002WX-Dy
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:20:17 -0400
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-2be3bdfda8eso3687281eec.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 23:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772954412; x=1773559212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hqQ72NnIYBXINuVoG3HiOpoWjjk2RG4TM4kQcZaprKY=;
 b=ayAdthtSQHM2SDQE+QuwvQ8xL2rBvnljem8OXuzr1KZdmxxhwDDKKIhpC4N6qAHQiW
 GTMMF0Y9+oe2P+7yzO8e6A0S7bT2ki5ns3GG4wTzk7ZtP+mcl5uI/ae1qrBDXCC2C5ux
 3V/sfCP6TJ/x4te35l4ZduWmW4+gmUMySajqxuIIT/mwOse7dfOgG12R+Rqr0ZEcikpi
 jeGjoC1GKCetaUirGcQYy4ZzuV/vicB6MKHPqszKr8igQNzK8Y1ym2F7n8Q4+1zHOsIs
 ldfwiC+ugTCFzm8IgZzVlh7exgitY+kaFbfV62TTRTvjAHUx/R4Na5kJunk6nMtzTw2L
 0M/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772954412; x=1773559212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hqQ72NnIYBXINuVoG3HiOpoWjjk2RG4TM4kQcZaprKY=;
 b=FOgEx0TY6gCXROITlxU7jBR0JrHUFDzcWaiI/koO/3xT2lAgGWBXv8M0hxWQtLeBy5
 1T6WDT4DKL5P3vm7ETYxZVeNs9gnrA4+8SymBFTsm142mJCcxJVRltMGaJNYTsdOMVSF
 eSpmD/7z3G7wgbZSIHwoO+9RyXUMWptUXPBUgBoMcShZA0/Jni6aW/M4WtrxjJLiEouq
 dNwhexf9ICl46Pj6/GrPVf73qHF+I3swrdJoHbi/NwDh/Z1fuNHd1GOqzpyb/Y+iBqAA
 6vvq1U0hZwg7K/y7U16GwslmM1+/mpg6gqfFoKdJWpZfO50yjjSDose297mHjC8PfYYU
 +ESQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh+y8tEyMK3Yj+Kc8WFHOuhZg7YfQkOjX+yaccfS4VLYlcDzbezLoNFMUuWkTBpocgYnwSyjA7oVKP@nongnu.org
X-Gm-Message-State: AOJu0YzBiDHOcmmpfDdmuMS/hVD2SQocnOx/XIggJsN/Bxxfw7Ail7rT
 wC5n/qCI0mdNfQX5zamNpAskkkg6kM4mjKcmi0L90IP/FJzEEjYBdvyQKDp4w6xu
X-Gm-Gg: ATEYQzw3fGPG3OhnhiW9W7FfOsNQGh7Pb1r8TErI4sGNlvF2FbmPv6qmZAMuD5ZN1sf
 7lzMgkaSfd8lZdorOHbHprZ/lIpopST3IZfzEU0UaP59XIrWadZGgqLuiVOHO/uoybjhDKD1J/0
 OyByDd9psGsK3LIcxVIaSYxagWDNjmKKlVBzzDVEv1YKzaQmhUHVOCxq6LJMklG69prb8JKrvsH
 wodqXfWHhokjySkt005KZdEodCXNUM8nFyrUysSsWRDayhRVNtZ2q5e8ZvtbMS8yZH0Dz1LmX+z
 6Dn4rTwFtR5uhuRwq8xMS+aod5mVr3+f23kG01QsNK9sCCvdJ/rSbO6/T8xQp9fUPMtP5l8RdDg
 VCw8n8C6Q9pvJX5ixGnfhptEh3uEv+Xe5xf+PAPi9A+mDU//8q3VQJZ0DWv/o644rWv0CWJFUlO
 GucH6JOIG3nOdETJzLJBREBoggtclWkvuBMw+JthOSyGCI7u+xhZzx1VNE1k829fqoebI7/6DD8
 BfkvaWFYDU5/jxo7iepNP63p10=
X-Received: by 2002:a05:693c:3101:b0:2be:aa:9a4a with SMTP id
 5a478bee46e88-2be4dd62c65mr2585378eec.0.1772954411647; 
 Sat, 07 Mar 2026 23:20:11 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f984ceasm6014081eec.32.2026.03.07.23.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 23:20:09 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: tangtao1634@phytium.com.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v1 17/28] hw/riscv/dm: add hart run-control operations
Date: Sun,  8 Mar 2026 15:17:20 +0800
Message-ID: <c123323a4ec484face040c43333ee77c5399c36e.1772936778.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
References: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1343;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1343.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Implement the dmcontrol operations that act on the selected hart
set and expose the matching summary registers.

This adds haltreq, resumereq, hartreset, ndmreset, and
reset-haltreq handling, collects selected harts from hartsel,
hasel, and hawindow, and computes haltsum0 and haltsum1 from the
tracked hart state. It also feeds GOING, RESUME, halt, and
resume acknowledgements from the ROM mailbox back into the state
machine and adds tracepoints for the new transitions.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 hw/riscv/dm.c         | 506 +++++++++++++++++++++++++++++++++++++++---
 hw/riscv/trace-events |  14 ++
 2 files changed, 485 insertions(+), 35 deletions(-)

diff --git a/hw/riscv/dm.c b/hw/riscv/dm.c
index fad8e2b2ce..d55b5b827d 100644
--- a/hw/riscv/dm.c
+++ b/hw/riscv/dm.c
@@ -10,15 +10,28 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "hw/core/cpu.h"
+#include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/riscv/dm.h"
+#include "exec/cpu-common.h"
 #include "migration/vmstate.h"
+#include "system/tcg.h"
+#include "target/riscv/cpu.h"
+#include "trace.h"
 
 REG32(DMCONTROL, 0x40)
     FIELD(DMCONTROL, DMACTIVE, 0, 1)
+    FIELD(DMCONTROL, NDMRESET, 1, 1)
+    FIELD(DMCONTROL, CLRRESETHALTREQ, 2, 1)
+    FIELD(DMCONTROL, SETRESETHALTREQ, 3, 1)
     FIELD(DMCONTROL, HARTSELLO, 6, 10)
     FIELD(DMCONTROL, HARTSELHI, 16, 10)
     FIELD(DMCONTROL, HASEL, 26, 1)
+    FIELD(DMCONTROL, ACKHAVERESET, 28, 1)
+    FIELD(DMCONTROL, HARTRESET, 29, 1)
+    FIELD(DMCONTROL, RESUMEREQ, 30, 1)
+    FIELD(DMCONTROL, HALTREQ, 31, 1)
 
 REG32(DMSTATUS, 0x44)
     FIELD(DMSTATUS, VERSION, 0, 4)
@@ -28,6 +41,8 @@ REG32(DMSTATUS, 0x44)
     FIELD(DMSTATUS, ALLHALTED, 9, 1)
     FIELD(DMSTATUS, ANYRUNNING, 10, 1)
     FIELD(DMSTATUS, ALLRUNNING, 11, 1)
+    FIELD(DMSTATUS, ANYUNAVAIL, 12, 1)
+    FIELD(DMSTATUS, ALLUNAVAIL, 13, 1)
     FIELD(DMSTATUS, ANYNONEXISTENT, 14, 1)
     FIELD(DMSTATUS, ALLNONEXISTENT, 15, 1)
     FIELD(DMSTATUS, ANYRESUMEACK, 16, 1)
@@ -35,6 +50,7 @@ REG32(DMSTATUS, 0x44)
     FIELD(DMSTATUS, ANYHAVERESET, 18, 1)
     FIELD(DMSTATUS, ALLHAVERESET, 19, 1)
     FIELD(DMSTATUS, IMPEBREAK, 22, 1)
+    FIELD(DMSTATUS, NDMRESETPENDING, 24, 1)
 
 REG32(HARTINFO, 0x48)
     FIELD(HARTINFO, DATAADDR, 0, 12)
@@ -42,12 +58,28 @@ REG32(HARTINFO, 0x48)
     FIELD(HARTINFO, DATAACCESS, 16, 1)
     FIELD(HARTINFO, NSCRATCH, 20, 4)
 
+REG32(HALTSUM1, 0x4c)
+
+REG32(HAWINDOWSEL, 0x50)
+    FIELD(HAWINDOWSEL, HAWINDOWSEL, 0, 15)
+
+REG32(HAWINDOW, 0x54)
+
 REG32(ABSTRACTCS, 0x58)
     FIELD(ABSTRACTCS, DATACOUNT, 0, 4)
     FIELD(ABSTRACTCS, CMDERR, 8, 3)
     FIELD(ABSTRACTCS, BUSY, 12, 1)
     FIELD(ABSTRACTCS, PROGBUFSIZE, 24, 5)
 
+REG32(HALTSUM0, 0x100)
+
+typedef struct DMHartSelection {
+    int all[RISCV_DM_HAWINDOW_SIZE + 1];
+    int all_count;
+    int harts[RISCV_DM_HAWINDOW_SIZE + 1];
+    int valid_count;
+} DMHartSelection;
+
 static inline uint32_t dm_get_hartsel(RISCVDMState *s)
 {
     uint32_t hi = ARRAY_FIELD_EX32(s->regs, DMCONTROL, HARTSELHI);
@@ -61,46 +93,306 @@ static inline bool dm_hart_valid(RISCVDMState *s, uint32_t hartsel)
     return hartsel < s->num_harts;
 }
 
-static void dm_status_refresh(RISCVDMState *s)
+static inline uint32_t dm_rom_read32(RISCVDMState *s, uint32_t offset)
+{
+    return ldl_le_p(s->rom_ptr + offset);
+}
+
+static inline void dm_rom_write32(RISCVDMState *s, uint32_t offset,
+                                  uint32_t val)
+{
+    stl_le_p(s->rom_ptr + offset, val);
+}
+
+static inline void dm_rom_write8(RISCVDMState *s, uint32_t offset, uint8_t val)
+{
+    s->rom_ptr[offset] = val;
+}
+
+static void dm_selection_add(RISCVDMState *s, DMHartSelection *sel, int hartsel)
+{
+    for (int i = 0; i < sel->all_count; i++) {
+        if (sel->all[i] == hartsel) {
+            return;
+        }
+    }
+
+    sel->all[sel->all_count++] = hartsel;
+    if (dm_hart_valid(s, hartsel)) {
+        sel->harts[sel->valid_count++] = hartsel;
+    }
+}
+
+static void dm_collect_selected_harts(RISCVDMState *s, DMHartSelection *sel)
 {
     uint32_t hartsel = dm_get_hartsel(s);
-    bool valid = dm_hart_valid(s, hartsel);
-    bool halted = valid && s->hart_halted[hartsel];
-    bool running = valid && !s->hart_halted[hartsel];
-    bool resumeack = valid && s->hart_resumeack[hartsel];
-    bool havereset = valid && s->hart_havereset[hartsel];
-
-    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ANYNONEXISTENT, !valid);
-    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ALLNONEXISTENT, !valid);
-    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ANYHALTED, halted);
-    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ALLHALTED, halted);
-    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ANYRUNNING, running);
-    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ALLRUNNING, running);
-    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ANYRESUMEACK, resumeack);
-    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ALLRESUMEACK, resumeack);
-    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ANYHAVERESET, havereset);
-    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ALLHAVERESET, havereset);
+    uint32_t wsel;
+    uint32_t window;
+    uint32_t base;
+
+    memset(sel, 0, sizeof(*sel));
+    dm_selection_add(s, sel, hartsel);
+
+    if (!ARRAY_FIELD_EX32(s->regs, DMCONTROL, HASEL)) {
+        return;
+    }
+
+    wsel = ARRAY_FIELD_EX32(s->regs, HAWINDOWSEL, HAWINDOWSEL);
+    if (wsel >= RISCV_DM_MAX_HARTS / RISCV_DM_HAWINDOW_SIZE) {
+        return;
+    }
+
+    window = s->hawindow[wsel];
+    base = wsel * RISCV_DM_HAWINDOW_SIZE;
+    for (int i = 0; i < RISCV_DM_HAWINDOW_SIZE; i++) {
+        if ((window >> i) & 1) {
+            dm_selection_add(s, sel, base + i);
+        }
+    }
+}
+
+static inline bool dm_ndmreset_active(RISCVDMState *s)
+{
+    return ARRAY_FIELD_EX32(s->regs, DMCONTROL, NDMRESET);
+}
+
+static bool dm_reg_present(RISCVDMState *s, hwaddr addr)
+{
+    switch (addr) {
+    case A_HALTSUM1:
+        return s->num_harts >= 33;
+    default:
+        return true;
+    }
+}
+
+static void dm_status_refresh(RISCVDMState *s)
+{
+    DMHartSelection sel;
+    bool anyhalted = false;
+    bool allhalted = true;
+    bool anyrunning = false;
+    bool allrunning = true;
+    bool anyunavail = false;
+    bool allunavail = true;
+    bool anyresumeack = false;
+    bool allresumeack = true;
+    bool anyhavereset = false;
+    bool allhavereset = true;
+    bool anynonexistent;
+    bool allnonexistent;
+    bool reset_unavail = dm_ndmreset_active(s) ||
+                         ARRAY_FIELD_EX32(s->regs, DMCONTROL, HARTRESET);
+
+    dm_collect_selected_harts(s, &sel);
+
+    anynonexistent = sel.all_count > sel.valid_count;
+    allnonexistent = sel.valid_count == 0 && sel.all_count > 0;
+
+    if (sel.valid_count == 0) {
+        allhalted = false;
+        allrunning = false;
+        allunavail = false;
+        allresumeack = false;
+        allhavereset = false;
+    }
+
+    for (int i = 0; i < sel.valid_count; i++) {
+        int h = sel.harts[i];
+        bool halted = s->hart_halted[h];
+        bool resumeack = s->hart_resumeack[h];
+        bool havereset = s->hart_havereset[h];
+
+        if (reset_unavail) {
+            anyunavail = true;
+            allhalted = false;
+            allrunning = false;
+        } else {
+            anyhalted |= halted;
+            allhalted &= halted;
+            anyrunning |= !halted;
+            allrunning &= !halted;
+        }
+
+        allunavail &= reset_unavail;
+        anyresumeack |= resumeack;
+        allresumeack &= resumeack;
+        anyhavereset |= havereset;
+        allhavereset &= havereset;
+    }
+
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ANYHALTED, anyhalted);
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ALLHALTED, allhalted);
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ANYRUNNING, anyrunning);
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ALLRUNNING, allrunning);
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ANYUNAVAIL, anyunavail);
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ALLUNAVAIL, allunavail);
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ANYNONEXISTENT, anynonexistent);
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ALLNONEXISTENT, allnonexistent);
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ANYRESUMEACK, anyresumeack);
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ALLRESUMEACK, allresumeack);
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ANYHAVERESET, anyhavereset);
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ALLHAVERESET, allhavereset);
     ARRAY_FIELD_DP32(s->regs, DMSTATUS, HASRESETHALTREQ, 1);
 }
 
 static void dm_debug_reset(RISCVDMState *s);
 
+static void dm_cpu_reset_on_cpu(CPUState *cpu, run_on_cpu_data data)
+{
+    (void)data;
+    cpu_reset(cpu);
+}
+
+static void dm_note_hart_reset(RISCVDMState *s, uint32_t hartsel)
+{
+    CPUState *cs = qemu_get_cpu(hartsel);
+
+    s->hart_halted[hartsel] = false;
+    s->hart_resumeack[hartsel] = false;
+    s->hart_havereset[hartsel] = true;
+    dm_rom_write8(s, RISCV_DM_ROM_FLAGS + hartsel, RISCV_DM_FLAG_CLEAR);
+
+    if (cs && s->hart_resethaltreq[hartsel]) {
+        riscv_cpu_request_dm_halt(RISCV_CPU(cs), DCSR_CAUSE_RESET);
+    }
+}
+
+static void dm_reset_hart(RISCVDMState *s, uint32_t hartsel)
+{
+    CPUState *cs;
+
+    if (!dm_hart_valid(s, hartsel)) {
+        return;
+    }
+
+    cs = qemu_get_cpu(hartsel);
+    if (cs && tcg_enabled()) {
+        run_on_cpu(cs, dm_cpu_reset_on_cpu, RUN_ON_CPU_NULL);
+    }
+
+    dm_note_hart_reset(s, hartsel);
+}
+
+static void dm_reset_selected_harts(RISCVDMState *s, DMHartSelection *sel)
+{
+    for (int i = 0; i < sel->valid_count; i++) {
+        dm_reset_hart(s, sel->harts[i]);
+    }
+}
+
+static void dm_reset_all_harts(RISCVDMState *s)
+{
+    for (uint32_t hartsel = 0; hartsel < s->num_harts; hartsel++) {
+        dm_reset_hart(s, hartsel);
+    }
+}
+
 static uint64_t dm_dmcontrol_pre_write(RegisterInfo *reg, uint64_t val64)
 {
     RISCVDMState *s = RISCV_DM(reg->opaque);
     uint32_t val = val64;
+    uint32_t cur_ctl = s->regs[R_DMCONTROL];
+    bool busy = ARRAY_FIELD_EX32(s->regs, ABSTRACTCS, BUSY);
+    bool ndmreset_was = FIELD_EX32(cur_ctl, DMCONTROL, NDMRESET);
+    bool hartreset_was = FIELD_EX32(cur_ctl, DMCONTROL, HARTRESET);
+    bool dmactive = FIELD_EX32(val, DMCONTROL, DMACTIVE);
+    DMHartSelection sel;
+    uint32_t stored = 0;
+
+    trace_riscv_dm_control_write(s->regs[R_DMCONTROL], val, busy);
+
+    if (busy) {
+        val = FIELD_DP32(val, DMCONTROL, HARTSELHI,
+                         ARRAY_FIELD_EX32(s->regs, DMCONTROL, HARTSELHI));
+        val = FIELD_DP32(val, DMCONTROL, HARTSELLO,
+                         ARRAY_FIELD_EX32(s->regs, DMCONTROL, HARTSELLO));
+        val = FIELD_DP32(val, DMCONTROL, HASEL,
+                         ARRAY_FIELD_EX32(s->regs, DMCONTROL, HASEL));
+        val = FIELD_DP32(val, DMCONTROL, HALTREQ, 0);
+        val = FIELD_DP32(val, DMCONTROL, RESUMEREQ, 0);
+        val = FIELD_DP32(val, DMCONTROL, ACKHAVERESET, 0);
+    }
 
-    if (!FIELD_EX32(val, DMCONTROL, DMACTIVE)) {
+    if (!dmactive) {
         dm_debug_reset(s);
         return 0;
     }
 
-    s->dm_active = true;
-
-    val = FIELD_DP32(val, DMCONTROL, DMACTIVE, 1);
     s->regs[R_DMCONTROL] = val;
+    dm_collect_selected_harts(s, &sel);
+
+    if (FIELD_EX32(val, DMCONTROL, NDMRESET) && !ndmreset_was) {
+        dm_reset_all_harts(s);
+    }
+
+    if (FIELD_EX32(val, DMCONTROL, HARTRESET) && !hartreset_was) {
+        dm_reset_selected_harts(s, &sel);
+    }
+
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, NDMRESETPENDING,
+                     FIELD_EX32(val, DMCONTROL, NDMRESET));
+
+    if (!busy && FIELD_EX32(val, DMCONTROL, ACKHAVERESET)) {
+        for (int i = 0; i < sel.valid_count; i++) {
+            s->hart_havereset[sel.harts[i]] = false;
+        }
+    }
+
+    if (!busy && FIELD_EX32(val, DMCONTROL, SETRESETHALTREQ)) {
+        for (int i = 0; i < sel.valid_count; i++) {
+            s->hart_resethaltreq[sel.harts[i]] = true;
+        }
+    }
+
+    if (!busy && FIELD_EX32(val, DMCONTROL, CLRRESETHALTREQ)) {
+        for (int i = 0; i < sel.valid_count; i++) {
+            s->hart_resethaltreq[sel.harts[i]] = false;
+        }
+    }
+
+    if (!busy && FIELD_EX32(val, DMCONTROL, RESUMEREQ) &&
+        !FIELD_EX32(val, DMCONTROL, HALTREQ)) {
+        for (int i = 0; i < sel.valid_count; i++) {
+            int h = sel.harts[i];
+
+            s->hart_resumeack[h] = false;
+            dm_rom_write8(s, RISCV_DM_ROM_FLAGS + h, RISCV_DM_FLAG_RESUME);
+            trace_riscv_dm_control_resume(h);
+        }
+    }
+
+    if (!busy) {
+        if (FIELD_EX32(val, DMCONTROL, HALTREQ)) {
+            for (int i = 0; i < sel.valid_count; i++) {
+                int h = sel.harts[i];
+
+                dm_rom_write8(s, RISCV_DM_ROM_FLAGS + h, RISCV_DM_FLAG_CLEAR);
+                qemu_set_irq(s->halt_irqs[h], 1);
+                trace_riscv_dm_control_halt(h);
+            }
+        } else {
+            for (int i = 0; i < sel.valid_count; i++) {
+                qemu_set_irq(s->halt_irqs[sel.harts[i]], 0);
+            }
+        }
+    }
+
+    stored = FIELD_DP32(stored, DMCONTROL, DMACTIVE, 1);
+    stored = FIELD_DP32(stored, DMCONTROL, NDMRESET,
+                        FIELD_EX32(val, DMCONTROL, NDMRESET));
+    stored = FIELD_DP32(stored, DMCONTROL, HARTSELLO,
+                        FIELD_EX32(val, DMCONTROL, HARTSELLO));
+    stored = FIELD_DP32(stored, DMCONTROL, HARTSELHI,
+                        FIELD_EX32(val, DMCONTROL, HARTSELHI));
+    stored = FIELD_DP32(stored, DMCONTROL, HASEL,
+                        FIELD_EX32(val, DMCONTROL, HASEL));
+    stored = FIELD_DP32(stored, DMCONTROL, HARTRESET,
+                        FIELD_EX32(val, DMCONTROL, HARTRESET));
+
+    s->dm_active = true;
     dm_status_refresh(s);
-    return val;
+    return stored;
 }
 
 static uint64_t dm_dmstatus_post_read(RegisterInfo *reg, uint64_t val)
@@ -108,7 +400,7 @@ static uint64_t dm_dmstatus_post_read(RegisterInfo *reg, uint64_t val)
     RISCVDMState *s = RISCV_DM(reg->opaque);
 
     dm_status_refresh(s);
-    return val;
+    return s->regs[R_DMSTATUS];
 }
 
 static uint64_t dm_hartinfo_post_read(RegisterInfo *reg, uint64_t val)
@@ -123,6 +415,72 @@ static uint64_t dm_hartinfo_post_read(RegisterInfo *reg, uint64_t val)
     return v;
 }
 
+static uint64_t dm_hawindowsel_pre_write(RegisterInfo *reg, uint64_t val64)
+{
+    uint32_t max_sel = RISCV_DM_MAX_HARTS / RISCV_DM_HAWINDOW_SIZE;
+    uint32_t val = val64 & R_HAWINDOWSEL_HAWINDOWSEL_MASK;
+
+    (void)reg;
+    if (val >= max_sel) {
+        val = max_sel - 1;
+    }
+    return val;
+}
+
+static uint64_t dm_hawindow_pre_write(RegisterInfo *reg, uint64_t val64)
+{
+    RISCVDMState *s = RISCV_DM(reg->opaque);
+    uint32_t wsel = ARRAY_FIELD_EX32(s->regs, HAWINDOWSEL, HAWINDOWSEL);
+
+    if (wsel < RISCV_DM_MAX_HARTS / RISCV_DM_HAWINDOW_SIZE) {
+        s->hawindow[wsel] = val64;
+    }
+    return (uint32_t)val64;
+}
+
+static uint64_t dm_hawindow_post_read(RegisterInfo *reg, uint64_t val)
+{
+    RISCVDMState *s = RISCV_DM(reg->opaque);
+    uint32_t wsel = ARRAY_FIELD_EX32(s->regs, HAWINDOWSEL, HAWINDOWSEL);
+
+    (void)val;
+    if (wsel < RISCV_DM_MAX_HARTS / RISCV_DM_HAWINDOW_SIZE) {
+        return s->hawindow[wsel];
+    }
+    return 0;
+}
+
+static uint64_t dm_haltsum0_post_read(RegisterInfo *reg, uint64_t val)
+{
+    RISCVDMState *s = RISCV_DM(reg->opaque);
+    uint32_t sum = 0;
+    uint32_t base = 0;
+    uint32_t limit = MIN(s->num_harts, 32u);
+
+    (void)val;
+    for (uint32_t h = base; h < limit; h++) {
+        if (s->hart_halted[h]) {
+            sum |= 1u << (h - base);
+        }
+    }
+    return sum;
+}
+
+static uint64_t dm_haltsum1_post_read(RegisterInfo *reg, uint64_t val)
+{
+    RISCVDMState *s = RISCV_DM(reg->opaque);
+    uint32_t sum = 0;
+
+    (void)reg;
+    (void)val;
+    for (uint32_t h = 0; h < s->num_harts; h++) {
+        if (s->hart_halted[h]) {
+            sum |= 1u << (h / 32);
+        }
+    }
+    return sum;
+}
+
 static RegisterAccessInfo riscv_dm_regs_info[] = {
     { .name = "DMCONTROL", .addr = A_DMCONTROL,
       .pre_write = dm_dmcontrol_pre_write, },
@@ -132,8 +490,19 @@ static RegisterAccessInfo riscv_dm_regs_info[] = {
     { .name = "HARTINFO", .addr = A_HARTINFO,
       .ro = 0xffffffff,
       .post_read = dm_hartinfo_post_read, },
+    { .name = "HALTSUM1", .addr = A_HALTSUM1,
+      .ro = 0xffffffff,
+      .post_read = dm_haltsum1_post_read, },
+    { .name = "HAWINDOWSEL", .addr = A_HAWINDOWSEL,
+      .pre_write = dm_hawindowsel_pre_write, },
+    { .name = "HAWINDOW", .addr = A_HAWINDOW,
+      .pre_write = dm_hawindow_pre_write,
+      .post_read = dm_hawindow_post_read, },
     { .name = "ABSTRACTCS", .addr = A_ABSTRACTCS,
       .ro = 0xffffffff, },
+    { .name = "HALTSUM0", .addr = A_HALTSUM0,
+      .ro = 0xffffffff,
+      .post_read = dm_haltsum0_post_read, },
 };
 
 static uint64_t riscv_dm_read(void *opaque, hwaddr addr, unsigned size)
@@ -145,6 +514,19 @@ static uint64_t riscv_dm_read(void *opaque, hwaddr addr, unsigned size)
         return 0;
     }
 
+    if (dm_ndmreset_active(s)) {
+        if (addr == A_DMSTATUS) {
+            return s->regs[R_DMSTATUS] & R_DMSTATUS_NDMRESETPENDING_MASK;
+        }
+        if (addr != A_DMCONTROL) {
+            return 0;
+        }
+    }
+
+    if (!dm_reg_present(s, addr)) {
+        return 0;
+    }
+
     return register_read_memory(opaque, addr, size);
 }
 
@@ -158,6 +540,14 @@ static void riscv_dm_write(void *opaque, hwaddr addr,
         return;
     }
 
+    if (dm_ndmreset_active(s) && addr != A_DMCONTROL) {
+        return;
+    }
+
+    if (!dm_reg_present(s, addr)) {
+        return;
+    }
+
     register_write_memory(opaque, addr, value, size);
 }
 
@@ -181,29 +571,54 @@ static const MemoryRegionOps riscv_dm_ops = {
 static uint64_t dm_rom_read(void *opaque, hwaddr offset, unsigned size)
 {
     RISCVDMState *s = opaque;
+    uint64_t ret;
 
-    return ldn_le_p(s->rom_ptr + offset, size);
+    ret = ldn_le_p(s->rom_ptr + offset, size);
+    trace_riscv_dm_rom_access(offset, ret, size, false);
+    return ret;
 }
 
 static void dm_rom_write(void *opaque, hwaddr offset,
                          uint64_t value, unsigned size)
 {
     RISCVDMState *s = opaque;
+    uint32_t hartsel;
 
     stn_le_p(s->rom_ptr + offset, size, value);
 
+    trace_riscv_dm_rom_access(offset, value, size, true);
+
     if (offset == RISCV_DM_ROM_HARTID && size == 4) {
-        riscv_dm_hart_halted(s, value);
+        hartsel = value;
+        if (dm_hart_valid(s, hartsel)) {
+            riscv_dm_hart_halted(s, hartsel);
+        }
+        return;
+    }
+
+    if (offset == RISCV_DM_ROM_GOING && size == 4) {
+        hartsel = dm_rom_read32(s, RISCV_DM_ROM_HARTID);
+        if (dm_hart_valid(s, hartsel)) {
+            dm_rom_write8(s, RISCV_DM_ROM_FLAGS + hartsel,
+                          RISCV_DM_FLAG_CLEAR);
+            trace_riscv_dm_going(hartsel);
+        }
         return;
     }
 
     if (offset == RISCV_DM_ROM_RESUME && size == 4) {
-        riscv_dm_hart_resumed(s, value);
+        hartsel = value;
+        if (dm_hart_valid(s, hartsel)) {
+            riscv_dm_hart_resumed(s, hartsel);
+        }
         return;
     }
 
     if (offset == RISCV_DM_ROM_EXCP && size == 4) {
-        riscv_dm_abstracts_exception(s, dm_get_hartsel(s));
+        hartsel = dm_rom_read32(s, RISCV_DM_ROM_HARTID);
+        if (dm_hart_valid(s, hartsel)) {
+            riscv_dm_abstracts_exception(s, hartsel);
+        }
     }
 }
 
@@ -250,6 +665,7 @@ void riscv_dm_hart_halted(RISCVDMState *s, uint32_t hartsel)
     s->hart_halted[hartsel] = true;
     riscv_dm_abstracts_done(s, hartsel);
     dm_status_refresh(s);
+    trace_riscv_dm_hart_halted(hartsel);
 }
 
 void riscv_dm_hart_resumed(RISCVDMState *s, uint32_t hartsel)
@@ -260,21 +676,23 @@ void riscv_dm_hart_resumed(RISCVDMState *s, uint32_t hartsel)
 
     s->hart_halted[hartsel] = false;
     s->hart_resumeack[hartsel] = true;
+    dm_rom_write8(s, RISCV_DM_ROM_FLAGS + hartsel, RISCV_DM_FLAG_CLEAR);
     dm_status_refresh(s);
+    trace_riscv_dm_hart_resumed(hartsel);
 }
 
 void riscv_dm_abstracts_done(RISCVDMState *s, uint32_t hartsel)
 {
-    (void)hartsel;
     ARRAY_FIELD_DP32(s->regs, ABSTRACTCS, BUSY, 0);
+    trace_riscv_dm_abstract_cmd_complete(hartsel);
 }
 
 void riscv_dm_abstracts_exception(RISCVDMState *s, uint32_t hartsel)
 {
-    (void)hartsel;
     ARRAY_FIELD_DP32(s->regs, ABSTRACTCS, BUSY, 0);
     ARRAY_FIELD_DP32(s->regs, ABSTRACTCS, CMDERR,
                      RISCV_DM_CMDERR_EXCEPTION);
+    trace_riscv_dm_abstract_cmd_exception(hartsel);
 }
 
 static void dm_debug_reset(RISCVDMState *s)
@@ -287,11 +705,15 @@ static void dm_debug_reset(RISCVDMState *s)
     ARRAY_FIELD_DP32(s->regs, ABSTRACTCS, PROGBUFSIZE, s->progbuf_size);
 
     if (s->hart_halted) {
-        memset(s->hart_halted, 0, s->num_harts * sizeof(bool));
-        memset(s->hart_resumeack, 0, s->num_harts * sizeof(bool));
-        memset(s->hart_havereset, 1, s->num_harts * sizeof(bool));
+        for (uint32_t i = 0; i < s->num_harts; i++) {
+            s->hart_halted[i] = false;
+            s->hart_resumeack[i] = false;
+            s->hart_havereset[i] = true;
+            s->hart_resethaltreq[i] = false;
+        }
     }
 
+    memset(s->hawindow, 0, sizeof(s->hawindow));
     s->dm_active = false;
 
     if (s->rom_ptr) {
@@ -324,11 +746,21 @@ static void riscv_dm_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    s->hart_halted = g_new0(bool, s->num_harts);
-    s->hart_resumeack = g_new0(bool, s->num_harts);
-    s->hart_havereset = g_new0(bool, s->num_harts);
+    if (s->num_harts > 0) {
+        s->hart_halted = g_new0(bool, s->num_harts);
+        s->hart_resumeack = g_new0(bool, s->num_harts);
+        s->hart_havereset = g_new0(bool, s->num_harts);
+        s->hart_resethaltreq = g_new0(bool, s->num_harts);
+        s->halt_irqs = g_new(qemu_irq, s->num_harts);
+        qdev_init_gpio_out(dev, s->halt_irqs, s->num_harts);
+    }
 
     if (!dm_rom_realize(s, errp)) {
+        g_free(s->hart_halted);
+        g_free(s->hart_resumeack);
+        g_free(s->hart_havereset);
+        g_free(s->hart_resethaltreq);
+        g_free(s->halt_irqs);
         return;
     }
 
@@ -348,6 +780,8 @@ static void riscv_dm_unrealize(DeviceState *dev)
     g_free(s->hart_halted);
     g_free(s->hart_resumeack);
     g_free(s->hart_havereset);
+    g_free(s->hart_resethaltreq);
+    g_free(s->halt_irqs);
 }
 
 static const Property riscv_dm_props[] = {
@@ -372,6 +806,8 @@ static const VMStateDescription vmstate_riscv_dm = {
                               0, vmstate_info_bool, bool),
         VMSTATE_VARRAY_UINT32(hart_havereset, RISCVDMState, num_harts,
                               0, vmstate_info_bool, bool),
+        VMSTATE_VARRAY_UINT32(hart_resethaltreq, RISCVDMState, num_harts,
+                              0, vmstate_info_bool, bool),
         VMSTATE_END_OF_LIST(),
     }
 };
diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
index b50b14a654..020e26607f 100644
--- a/hw/riscv/trace-events
+++ b/hw/riscv/trace-events
@@ -1,5 +1,19 @@
 # See documentation at docs/devel/tracing.rst
 
+# dm.c
+riscv_dm_control_write(uint32_t old_val, uint32_t new_val, bool busy) "old=0x%08x new=0x%08x busy=%d"
+riscv_dm_control_halt(uint32_t hartsel) "hartsel=%u"
+riscv_dm_control_resume(uint32_t hartsel) "hartsel=%u"
+riscv_dm_hart_halted(uint32_t hartsel) "hartsel=%u"
+riscv_dm_hart_resumed(uint32_t hartsel) "hartsel=%u"
+riscv_dm_abstract_cmd_submit(uint32_t cmdtype, uint32_t regno, bool transfer, bool write, bool aarpostinc, bool postexec) "cmdtype=%u regno=0x%04x transfer=%d write=%d aarpostinc=%d postexec=%d"
+riscv_dm_abstract_cmd_complete(uint32_t hartsel) "hartsel=%u"
+riscv_dm_abstract_cmd_exception(uint32_t hartsel) "hartsel=%u"
+riscv_dm_abstract_cmd_rejected(const char *reason, uint32_t cmderr) "reason=%s cmderr=%u"
+riscv_dm_sba_access(uint64_t addr, uint32_t data, int bytes, bool is_write) "addr=0x%"PRIx64" data=0x%08x bytes=%d write=%d"
+riscv_dm_rom_access(uint64_t offset, uint64_t value, unsigned size, bool is_write) "offset=0x%"PRIx64" value=0x%"PRIx64" size=%u write=%d"
+riscv_dm_going(uint32_t hartsel) "hartsel=%u"
+
 # riscv-iommu.c
 riscv_iommu_new(const char *id, unsigned b, unsigned d, unsigned f) "%s: device attached %04x:%02x.%d"
 riscv_iommu_flt(const char *id, unsigned b, unsigned d, unsigned f, uint64_t reason, uint64_t iova) "%s: fault %04x:%02x.%u reason: 0x%"PRIx64" iova: 0x%"PRIx64
-- 
2.53.0


