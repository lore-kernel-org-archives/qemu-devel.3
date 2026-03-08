Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C24F55126
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 07:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz8Sx-0004fv-I3; Sun, 08 Mar 2026 03:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8RO-00029O-Rh
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:20:47 -0400
Received: from mail-dy1-x1343.google.com ([2607:f8b0:4864:20::1343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8RJ-0002mk-26
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:20:41 -0400
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-2bd9a485bd6so5552185eec.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 23:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772954431; x=1773559231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tf5YP4hwd4+iXp/ZaW6QGtzdeaPjA06pKFhFFtnqSFw=;
 b=kqdMW5iH+GJawH6ZFFltLy0myxGKOwh/CqyGfRuBA5im6YhzbXq1hG77aNmZT+tbp4
 TbGMEIzMVTivGC3MRXs5YcnHom3OG2DqZiYkvHoE3CwHXwKD9KtRNyR0DOYz3iZ/0jCN
 AIQzWe4Js93TBxbsmgveo2zt7lfV8CtXejQt5xFKHqZseQPYjkW9JNa6EWp19nogEAiK
 AulQjbnKKEAwC94StAr4nMepx48kf5QkbWvZKPqARNeKDSXHL8pJXzFhmQptbjB67bVo
 NDFhpQgM3B/FrXVyaFG7mJtGyhBsbQBOBHi2/937IyYXCQqzCPfvgT2n6CEvUR+dnPt8
 Mwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772954431; x=1773559231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tf5YP4hwd4+iXp/ZaW6QGtzdeaPjA06pKFhFFtnqSFw=;
 b=GIiTfYprvNrWPDTu1WDzzADztemq2ChjTAVhlsLKYHMlxBU7copO9YwBz+tWnkvY+2
 wzW+WKxoFhegPJ1K+EYPt+x14lxYUsqeyAr1rTqbT1+wH0F6DvN3cp1B5MyUTTGf1T/V
 o7DG6aKp1xP4fob/LKwqPkrF1KD6nzaVLOv3Y2sk7fI0gcxas9be7JwAGclknvEZkUTw
 SSoO+zuleBArY+q9WM8nrjVDSlUoIfGlB7J9NXkc4ra9w0k/GoRTGNWkLBX7CCBp2Fjq
 kQHf3IDtoLUgfYoZEwkqUmc0E0y74t5qb8tOiv0tPmXUxuCT7IS1sf3oE2v9jJHvEE3x
 lWVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIs3E5Ozpy5c8WG9F+6DBMeS3ITOhIIRnbC6gSl8qfLT/bdcCr8/bNNQZOOGop0NNlXBCr8HDd9NkU@nongnu.org
X-Gm-Message-State: AOJu0YzItayKrarwy2NDqKx70qN5S9KV9IelGvF9om92k3+gwxNaEUs0
 ZNVEgrP+9BJ4CKhn64V6vHXBIacZIV/6CxRwEgdsNeAa4zl1DfexjU0w
X-Gm-Gg: ATEYQzz5/HXadHusrZaysPiuRWoqhcXtaNlacNerW+cuXXe3cT5k1ucBqcYnBlrwN7q
 OlsTLMU6VdqKzfW46rAK7erIBFuo4oH0pM3/kUcQSdTKG1eD4GYrEHVCSmRlGeXTl0AfWSf4axd
 3X0eZOxJoRoIKPmc+a8oflX9VL8sZPS3wDViTtsmoiVSE1YVbpuG2iGObpZMhXu4t3vhWQt7TQ5
 pgjdgal6MVfK/4p7c1wja+o5eRbBqMZsvxOY3gtxPyNds60fo3m7tBsNlG2rUHT/mCReLev7S2M
 cMZ/UEAjHSsJje1aNdQbUXKzIbCQlRkg5FAf33FwDJq4e3iN8jidd7qlniLfBJM/GOY359GLYo4
 Cdg9tKBd40BIou+xtayxPSjMEGiyxTwW1Ulo0ubZqsKolzc26IMBprMBpGlIdVS0zkzRQWlcJ/w
 VFs0mKeMX1FHr20D8IwNNNbTLvfEiNjn62/plW8n5KGXRpa/oGvyyN2p/QfVD+HxR99G3RO14mY
 gVcl+jcGE4ZHNFeyQAGxfBPnRmfPF0sE+rEMg==
X-Received: by 2002:a05:693c:3104:b0:2ba:6b03:909b with SMTP id
 5a478bee46e88-2be4e03b441mr3176842eec.19.1772954431060; 
 Sat, 07 Mar 2026 23:20:31 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f984ceasm6014081eec.32.2026.03.07.23.20.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 23:20:29 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: tangtao1634@phytium.com.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v1 20/28] hw/riscv/dm: add register handlers and update state
 management
Date: Sun,  8 Mar 2026 15:17:23 +0800
Message-ID: <339a2c9cfa0a7efb1ef1c630c5b738c55ab05323.1772936778.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
References: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Wire up pre_write/post_write/post_read callbacks for the newly
declared registers (DATA, PROGBUF, COMMAND, ABSTRACTAUTO,
ABSTRACTCS W1C) and expand the register_info table.

Refactor dm_dmcontrol_pre_write for clarity, fix haltsum0/1 to
use hartsel-based windowing, expand dm_reg_present for all
optional registers, add DATA area remap in ROM read/write, and
add realize-time validation for datacount and progbufsize.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 hw/riscv/dm.c | 772 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 571 insertions(+), 201 deletions(-)

diff --git a/hw/riscv/dm.c b/hw/riscv/dm.c
index 427507e77e..169863c54c 100644
--- a/hw/riscv/dm.c
+++ b/hw/riscv/dm.c
@@ -228,6 +228,7 @@ REG32(HALTSUM0, 0x100)
 #define DM_NOP    0x13u
 #define DM_EBREAK 0x100073u
 
+
 typedef struct DMHartSelection {
     int all[RISCV_DM_HAWINDOW_SIZE + 1];
     int all_count;
@@ -235,19 +236,6 @@ typedef struct DMHartSelection {
     int valid_count;
 } DMHartSelection;
 
-static inline uint32_t dm_get_hartsel(RISCVDMState *s)
-{
-    uint32_t hi = ARRAY_FIELD_EX32(s->regs, DMCONTROL, HARTSELHI);
-    uint32_t lo = ARRAY_FIELD_EX32(s->regs, DMCONTROL, HARTSELLO);
-
-    return (hi << 10) | lo;
-}
-
-static inline bool dm_hart_valid(RISCVDMState *s, uint32_t hartsel)
-{
-    return hartsel < s->num_harts;
-}
-
 static inline uint32_t dm_rom_read32(RISCVDMState *s, uint32_t offset)
 {
     return ldl_le_p(s->rom_ptr + offset);
@@ -294,54 +282,58 @@ static void dm_flush_cmd_space(RISCVDMState *s)
     dm_rom_write32(s, RISCV_DM_ROM_WHERETO, DM_JAL(0x1C));
 }
 
-static void dm_invalidate_dynamic_code(RISCVDMState *s)
+static inline uint32_t dm_get_hartsel(RISCVDMState *s)
 {
-    if (tcg_enabled()) {
-        ram_addr_t base = memory_region_get_ram_addr(&s->rom_mr);
-
-        tb_invalidate_phys_range(NULL, base + RISCV_DM_ROM_WHERETO,
-                                 base + RISCV_DM_ROM_DATA - 1);
-    }
+    uint32_t hi = ARRAY_FIELD_EX32(s->regs, DMCONTROL, HARTSELHI);
+    uint32_t lo = ARRAY_FIELD_EX32(s->regs, DMCONTROL, HARTSELLO);
+    return (hi << 10) | lo;
 }
 
-static void dm_update_impebreak(RISCVDMState *s)
+static inline bool dm_hart_valid(RISCVDMState *s, uint32_t hartsel)
 {
-    hwaddr ebreak_addr = RISCV_DM_ROM_PROGBUF + s->progbuf_size * 4;
+    return hartsel < s->num_harts;
+}
 
-    if (ebreak_addr + 4 > RISCV_DM_ROM_DATA) {
-        return;
+static void dm_selection_add(RISCVDMState *s, DMHartSelection *sel, int hartsel)
+{
+    for (int i = 0; i < sel->all_count; i++) {
+        if (sel->all[i] == hartsel) {
+            return;
+        }
+    }
+    sel->all[sel->all_count++] = hartsel;
+    if (dm_hart_valid(s, hartsel)) {
+        sel->harts[sel->valid_count++] = hartsel;
     }
-
-    dm_rom_write32(s, ebreak_addr, s->impebreak ? DM_EBREAK : DM_NOP);
 }
 
-static void dm_reset_rom_state(RISCVDMState *s)
+static void dm_collect_selected_harts(RISCVDMState *s, DMHartSelection *sel)
 {
-    if (!s->rom_ptr) {
-        return;
-    }
+    uint32_t hartsel = dm_get_hartsel(s);
 
-    memset(s->rom_ptr + RISCV_DM_ROM_WORK_BASE, 0, RISCV_DM_ROM_WORK_SIZE);
+    memset(sel, 0, sizeof(*sel));
+    dm_selection_add(s, sel, hartsel);
 
-    dm_flush_cmd_space(s);
+    if (!ARRAY_FIELD_EX32(s->regs, DMCONTROL, HASEL)) {
+        return;
+    }
 
-    for (uint32_t i = 0; i < s->num_abstract_data; i++) {
-        dm_sync_data_to_rom(s, i);
+    uint32_t wsel = ARRAY_FIELD_EX32(s->regs, HAWINDOWSEL, HAWINDOWSEL);
+    if (wsel >= RISCV_DM_MAX_HARTS / RISCV_DM_HAWINDOW_SIZE) {
+        return;
     }
-    for (uint32_t i = 0; i < s->progbuf_size; i++) {
-        dm_sync_progbuf_to_rom(s, i);
+    uint32_t window = s->hawindow[wsel];
+    uint32_t base = wsel * RISCV_DM_HAWINDOW_SIZE;
+    for (int i = 0; i < RISCV_DM_HAWINDOW_SIZE; i++) {
+        if ((window >> i) & 1) {
+            dm_selection_add(s, sel, base + i);
+        }
     }
-
-    dm_update_impebreak(s);
-    dm_invalidate_dynamic_code(s);
 }
 
-static inline void dm_set_cmderr(RISCVDMState *s, uint32_t err)
+static inline bool dm_ndmreset_active(RISCVDMState *s)
 {
-    uint32_t cur = ARRAY_FIELD_EX32(s->regs, ABSTRACTCS, CMDERR);
-    if (cur == RISCV_DM_CMDERR_NONE) {
-        ARRAY_FIELD_DP32(s->regs, ABSTRACTCS, CMDERR, err);
-    }
+    return ARRAY_FIELD_EX32(s->regs, DMCONTROL, NDMRESET);
 }
 
 static bool dm_abstract_cmd_completed(RISCVDMState *s, uint32_t hartsel)
@@ -361,135 +353,137 @@ static bool dm_abstract_cmd_completed(RISCVDMState *s, uint32_t hartsel)
     return !(flags & RISCV_DM_FLAG_GOING);
 }
 
-static void dm_selection_add(RISCVDMState *s, DMHartSelection *sel, int hartsel)
+static void dm_invalidate_dynamic_code(RISCVDMState *s)
 {
-    for (int i = 0; i < sel->all_count; i++) {
-        if (sel->all[i] == hartsel) {
-            return;
-        }
-    }
+    if (tcg_enabled()) {
+        ram_addr_t base = memory_region_get_ram_addr(&s->rom_mr);
 
-    sel->all[sel->all_count++] = hartsel;
-    if (dm_hart_valid(s, hartsel)) {
-        sel->harts[sel->valid_count++] = hartsel;
+        tb_invalidate_phys_range(NULL, base + RISCV_DM_ROM_WHERETO,
+                                 base + RISCV_DM_ROM_DATA - 1);
     }
 }
 
-static void dm_collect_selected_harts(RISCVDMState *s, DMHartSelection *sel)
+static bool dm_data_reg_present(RISCVDMState *s, hwaddr addr)
 {
-    uint32_t hartsel = dm_get_hartsel(s);
-    uint32_t wsel;
-    uint32_t window;
-    uint32_t base;
+    unsigned int index = (addr - A_DATA0) / 4;
 
-    memset(sel, 0, sizeof(*sel));
-    dm_selection_add(s, sel, hartsel);
+    return index < s->num_abstract_data;
+}
 
-    if (!ARRAY_FIELD_EX32(s->regs, DMCONTROL, HASEL)) {
-        return;
-    }
+static bool dm_progbuf_reg_present(RISCVDMState *s, hwaddr addr)
+{
+    unsigned int index = (addr - A_PROGBUF0) / 4;
 
-    wsel = ARRAY_FIELD_EX32(s->regs, HAWINDOWSEL, HAWINDOWSEL);
-    if (wsel >= RISCV_DM_MAX_HARTS / RISCV_DM_HAWINDOW_SIZE) {
-        return;
-    }
+    return index < s->progbuf_size;
+}
 
-    window = s->hawindow[wsel];
-    base = wsel * RISCV_DM_HAWINDOW_SIZE;
-    for (int i = 0; i < RISCV_DM_HAWINDOW_SIZE; i++) {
-        if ((window >> i) & 1) {
-            dm_selection_add(s, sel, base + i);
-        }
+static bool dm_sba_addr_reg_present(RISCVDMState *s, hwaddr addr)
+{
+    switch (addr) {
+    case A_SBADDRESS0:
+        return s->sba_addr_width > 0;
+    case A_SBADDRESS1:
+        return s->sba_addr_width > 32;
+    case A_SBADDRESS2:
+        return s->sba_addr_width > 64;
+    case A_SBADDRESS3:
+        return s->sba_addr_width > 96;
+    default:
+        return false;
     }
 }
 
-static inline bool dm_ndmreset_active(RISCVDMState *s)
+static bool dm_sba_data_reg_present(RISCVDMState *s, hwaddr addr)
 {
-    return ARRAY_FIELD_EX32(s->regs, DMCONTROL, NDMRESET);
+    bool sbdata0 = ARRAY_FIELD_EX32(s->regs, SBCS, SBACCESS8) ||
+                   ARRAY_FIELD_EX32(s->regs, SBCS, SBACCESS16) ||
+                   ARRAY_FIELD_EX32(s->regs, SBCS, SBACCESS32) ||
+                   ARRAY_FIELD_EX32(s->regs, SBCS, SBACCESS64) ||
+                   ARRAY_FIELD_EX32(s->regs, SBCS, SBACCESS128);
+    bool sbdata1 = ARRAY_FIELD_EX32(s->regs, SBCS, SBACCESS64) ||
+                   ARRAY_FIELD_EX32(s->regs, SBCS, SBACCESS128);
+    bool sbdata23 = ARRAY_FIELD_EX32(s->regs, SBCS, SBACCESS128);
+
+    switch (addr) {
+    case A_SBDATA0:
+        return sbdata0;
+    case A_SBDATA1:
+        return sbdata1;
+    case A_SBDATA2:
+    case A_SBDATA3:
+        return sbdata23;
+    default:
+        return false;
+    }
 }
 
 static bool dm_reg_present(RISCVDMState *s, hwaddr addr)
 {
+    if (addr >= A_DATA0 && addr <= A_DATA11) {
+        return dm_data_reg_present(s, addr);
+    }
+
+    if (addr >= A_PROGBUF0 && addr <= A_PROGBUF15) {
+        return dm_progbuf_reg_present(s, addr);
+    }
+
     switch (addr) {
+    case A_AUTHDATA:
+    case A_DMCS2:
+        return false;
     case A_HALTSUM1:
         return s->num_harts >= 33;
+    case A_HALTSUM2:
+        return s->num_harts >= 1025;
+    case A_HALTSUM3:
+        return s->num_harts >= 32769;
+    case A_SBADDRESS0:
+    case A_SBADDRESS1:
+    case A_SBADDRESS2:
+    case A_SBADDRESS3:
+        return dm_sba_addr_reg_present(s, addr);
+    case A_SBDATA0:
+    case A_SBDATA1:
+    case A_SBDATA2:
+    case A_SBDATA3:
+        return dm_sba_data_reg_present(s, addr);
     default:
         return true;
     }
 }
 
-static void dm_status_refresh(RISCVDMState *s)
+static void dm_update_impebreak(RISCVDMState *s)
 {
-    DMHartSelection sel;
-    bool anyhalted = false;
-    bool allhalted = true;
-    bool anyrunning = false;
-    bool allrunning = true;
-    bool anyunavail = false;
-    bool allunavail = true;
-    bool anyresumeack = false;
-    bool allresumeack = true;
-    bool anyhavereset = false;
-    bool allhavereset = true;
-    bool anynonexistent;
-    bool allnonexistent;
-    bool reset_unavail = dm_ndmreset_active(s) ||
-                         ARRAY_FIELD_EX32(s->regs, DMCONTROL, HARTRESET);
+    hwaddr ebreak_addr = RISCV_DM_ROM_PROGBUF + s->progbuf_size * 4;
 
-    dm_collect_selected_harts(s, &sel);
+    if (ebreak_addr + 4 > RISCV_DM_ROM_DATA) {
+        return;
+    }
 
-    anynonexistent = sel.all_count > sel.valid_count;
-    allnonexistent = sel.valid_count == 0 && sel.all_count > 0;
+    dm_rom_write32(s, ebreak_addr, s->impebreak ? DM_EBREAK : DM_NOP);
+}
 
-    if (sel.valid_count == 0) {
-        allhalted = false;
-        allrunning = false;
-        allunavail = false;
-        allresumeack = false;
-        allhavereset = false;
+static void dm_reset_rom_state(RISCVDMState *s)
+{
+    if (!s->rom_ptr) {
+        return;
     }
 
-    for (int i = 0; i < sel.valid_count; i++) {
-        int h = sel.harts[i];
-        bool halted = s->hart_halted[h];
-        bool resumeack = s->hart_resumeack[h];
-        bool havereset = s->hart_havereset[h];
+    memset(s->rom_ptr + RISCV_DM_ROM_WORK_BASE, 0, RISCV_DM_ROM_WORK_SIZE);
 
-        if (reset_unavail) {
-            anyunavail = true;
-            allhalted = false;
-            allrunning = false;
-        } else {
-            anyhalted |= halted;
-            allhalted &= halted;
-            anyrunning |= !halted;
-            allrunning &= !halted;
-        }
+    dm_flush_cmd_space(s);
 
-        allunavail &= reset_unavail;
-        anyresumeack |= resumeack;
-        allresumeack &= resumeack;
-        anyhavereset |= havereset;
-        allhavereset &= havereset;
+    for (uint32_t i = 0; i < s->num_abstract_data; i++) {
+        dm_sync_data_to_rom(s, i);
+    }
+    for (uint32_t i = 0; i < s->progbuf_size; i++) {
+        dm_sync_progbuf_to_rom(s, i);
     }
 
-    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ANYHALTED, anyhalted);
-    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ALLHALTED, allhalted);
-    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ANYRUNNING, anyrunning);
-    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ALLRUNNING, allrunning);
-    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ANYUNAVAIL, anyunavail);
-    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ALLUNAVAIL, allunavail);
-    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ANYNONEXISTENT, anynonexistent);
-    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ALLNONEXISTENT, allnonexistent);
-    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ANYRESUMEACK, anyresumeack);
-    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ALLRESUMEACK, allresumeack);
-    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ANYHAVERESET, anyhavereset);
-    ARRAY_FIELD_DP32(s->regs, DMSTATUS, ALLHAVERESET, allhavereset);
-    ARRAY_FIELD_DP32(s->regs, DMSTATUS, HASRESETHALTREQ, 1);
+    dm_update_impebreak(s);
+    dm_invalidate_dynamic_code(s);
 }
 
-static void dm_debug_reset(RISCVDMState *s);
-
 static void dm_cpu_reset_on_cpu(CPUState *cpu, run_on_cpu_data data)
 {
     bool request_reset_halt = data.host_int;
@@ -543,20 +537,93 @@ static void dm_reset_all_harts(RISCVDMState *s)
     }
 }
 
+
+static inline void dm_set_cmderr(RISCVDMState *s, uint32_t err)
+{
+    uint32_t cur = ARRAY_FIELD_EX32(s->regs, ABSTRACTCS, CMDERR);
+    if (cur == RISCV_DM_CMDERR_NONE) {
+        ARRAY_FIELD_DP32(s->regs, ABSTRACTCS, CMDERR, err);
+    }
+}
+
+static void dm_status_refresh(RISCVDMState *s)
+{
+    DMHartSelection sel;
+    bool anyhalted = false, allhalted = true;
+    bool anyrunning = false, allrunning = true;
+    bool anyunavail = false, allunavail = true;
+    bool anyresumeack = false, allresumeack = true;
+    bool anyhavereset = false, allhavereset = true;
+    bool anynonexistent = false, allnonexistent = false;
+    bool reset_unavail = dm_ndmreset_active(s) ||
+                         ARRAY_FIELD_EX32(s->regs, DMCONTROL, HARTRESET);
+
+    dm_collect_selected_harts(s, &sel);
+
+    anynonexistent = (sel.all_count > sel.valid_count);
+    allnonexistent = (sel.valid_count == 0 && sel.all_count > 0);
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
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, HASRESETHALTREQ, 1);
+}
+
+
+static void dm_debug_reset(RISCVDMState *s);
 static uint64_t dm_dmcontrol_pre_write(RegisterInfo *reg, uint64_t val64)
 {
     RISCVDMState *s = RISCV_DM(reg->opaque);
-    uint32_t val = val64;
+    uint32_t val = (uint32_t)val64;
     uint32_t cur_ctl = s->regs[R_DMCONTROL];
     bool busy = ARRAY_FIELD_EX32(s->regs, ABSTRACTCS, BUSY);
     bool ndmreset_was = FIELD_EX32(cur_ctl, DMCONTROL, NDMRESET);
     bool hartreset_was = FIELD_EX32(cur_ctl, DMCONTROL, HARTRESET);
-    bool dmactive = FIELD_EX32(val, DMCONTROL, DMACTIVE);
-    DMHartSelection sel;
-    uint32_t stored = 0;
 
     trace_riscv_dm_control_write(s->regs[R_DMCONTROL], val, busy);
 
+    /* If busy, preserve hart selection and suppress run-control */
     if (busy) {
         val = FIELD_DP32(val, DMCONTROL, HARTSELHI,
                          ARRAY_FIELD_EX32(s->regs, DMCONTROL, HARTSELHI));
@@ -569,25 +636,34 @@ static uint64_t dm_dmcontrol_pre_write(RegisterInfo *reg, uint64_t val64)
         val = FIELD_DP32(val, DMCONTROL, ACKHAVERESET, 0);
     }
 
+    bool dmactive = FIELD_EX32(val, DMCONTROL, DMACTIVE);
+
     if (!dmactive) {
+        /* dmactive=0: reset the DM */
         dm_debug_reset(s);
+        /* Return the reset value (only dmactive=0) */
         return 0;
     }
 
+    /* Store first so helpers see updated fields */
     s->regs[R_DMCONTROL] = val;
+
+    DMHartSelection sel;
     dm_collect_selected_harts(s, &sel);
 
-    if (FIELD_EX32(val, DMCONTROL, NDMRESET) && !ndmreset_was) {
+    bool ndmreset = FIELD_EX32(val, DMCONTROL, NDMRESET);
+    bool hartreset = FIELD_EX32(val, DMCONTROL, HARTRESET);
+
+    if (ndmreset && !ndmreset_was) {
         dm_reset_all_harts(s);
     }
-
-    if (FIELD_EX32(val, DMCONTROL, HARTRESET) && !hartreset_was) {
+    if (hartreset && !hartreset_was) {
         dm_reset_selected_harts(s, &sel);
     }
 
-    ARRAY_FIELD_DP32(s->regs, DMSTATUS, NDMRESETPENDING,
-                     FIELD_EX32(val, DMCONTROL, NDMRESET));
+    ARRAY_FIELD_DP32(s->regs, DMSTATUS, NDMRESETPENDING, ndmreset);
 
+    /* ACKHAVERESET: clear havereset for selected harts */
     if (!busy && FIELD_EX32(val, DMCONTROL, ACKHAVERESET)) {
         for (int i = 0; i < sel.valid_count; i++) {
             s->hart_havereset[sel.harts[i]] = false;
@@ -606,22 +682,24 @@ static uint64_t dm_dmcontrol_pre_write(RegisterInfo *reg, uint64_t val64)
         }
     }
 
-    if (!busy && FIELD_EX32(val, DMCONTROL, RESUMEREQ) &&
-        !FIELD_EX32(val, DMCONTROL, HALTREQ)) {
+    /* RESUMEREQ */
+    bool resumereq = FIELD_EX32(val, DMCONTROL, RESUMEREQ);
+    bool haltreq = FIELD_EX32(val, DMCONTROL, HALTREQ);
+
+    if (!busy && resumereq && !haltreq) {
         for (int i = 0; i < sel.valid_count; i++) {
             int h = sel.harts[i];
-
             s->hart_resumeack[h] = false;
             dm_rom_write8(s, RISCV_DM_ROM_FLAGS + h, RISCV_DM_FLAG_RESUME);
             trace_riscv_dm_control_resume(h);
         }
     }
 
+    /* HALTREQ */
     if (!busy) {
-        if (FIELD_EX32(val, DMCONTROL, HALTREQ)) {
+        if (haltreq) {
             for (int i = 0; i < sel.valid_count; i++) {
                 int h = sel.harts[i];
-
                 dm_rom_write8(s, RISCV_DM_ROM_FLAGS + h, RISCV_DM_FLAG_CLEAR);
                 qemu_set_irq(s->halt_irqs[h], 1);
                 trace_riscv_dm_control_halt(h);
@@ -633,6 +711,12 @@ static uint64_t dm_dmcontrol_pre_write(RegisterInfo *reg, uint64_t val64)
         }
     }
 
+    /*
+     * Build the stored value: only keep fields with readable semantics.
+     * WARZ fields (haltreq, resumereq, ackhavereset, setresethaltreq,
+     * clrresethaltreq, setkeepalive, clrkeepalive, ackunavail) read as 0.
+     */
+    uint32_t stored = 0;
     stored = FIELD_DP32(stored, DMCONTROL, DMACTIVE, 1);
     stored = FIELD_DP32(stored, DMCONTROL, NDMRESET,
                         FIELD_EX32(val, DMCONTROL, NDMRESET));
@@ -643,17 +727,17 @@ static uint64_t dm_dmcontrol_pre_write(RegisterInfo *reg, uint64_t val64)
     stored = FIELD_DP32(stored, DMCONTROL, HASEL,
                         FIELD_EX32(val, DMCONTROL, HASEL));
     stored = FIELD_DP32(stored, DMCONTROL, HARTRESET,
-                        FIELD_EX32(val, DMCONTROL, HARTRESET));
+                        hartreset);
 
     s->dm_active = true;
     dm_status_refresh(s);
+
     return stored;
 }
 
 static uint64_t dm_dmstatus_post_read(RegisterInfo *reg, uint64_t val)
 {
     RISCVDMState *s = RISCV_DM(reg->opaque);
-
     dm_status_refresh(s);
     return s->regs[R_DMSTATUS];
 }
@@ -661,8 +745,7 @@ static uint64_t dm_dmstatus_post_read(RegisterInfo *reg, uint64_t val)
 static uint64_t dm_hartinfo_post_read(RegisterInfo *reg, uint64_t val)
 {
     RISCVDMState *s = RISCV_DM(reg->opaque);
-    uint32_t v = val;
-
+    uint32_t v = 0;
     v = FIELD_DP32(v, HARTINFO, DATAADDR, RISCV_DM_ROM_DATA);
     v = FIELD_DP32(v, HARTINFO, DATASIZE, s->num_abstract_data);
     v = FIELD_DP32(v, HARTINFO, DATAACCESS, 1);
@@ -673,9 +756,7 @@ static uint64_t dm_hartinfo_post_read(RegisterInfo *reg, uint64_t val)
 static uint64_t dm_hawindowsel_pre_write(RegisterInfo *reg, uint64_t val64)
 {
     uint32_t max_sel = RISCV_DM_MAX_HARTS / RISCV_DM_HAWINDOW_SIZE;
-    uint32_t val = val64 & R_HAWINDOWSEL_HAWINDOWSEL_MASK;
-
-    (void)reg;
+    uint32_t val = (uint32_t)val64 & R_HAWINDOWSEL_HAWINDOWSEL_MASK;
     if (val >= max_sel) {
         val = max_sel - 1;
     }
@@ -686,9 +767,8 @@ static uint64_t dm_hawindow_pre_write(RegisterInfo *reg, uint64_t val64)
 {
     RISCVDMState *s = RISCV_DM(reg->opaque);
     uint32_t wsel = ARRAY_FIELD_EX32(s->regs, HAWINDOWSEL, HAWINDOWSEL);
-
     if (wsel < RISCV_DM_MAX_HARTS / RISCV_DM_HAWINDOW_SIZE) {
-        s->hawindow[wsel] = val64;
+        s->hawindow[wsel] = (uint32_t)val64;
     }
     return (uint32_t)val64;
 }
@@ -697,69 +777,312 @@ static uint64_t dm_hawindow_post_read(RegisterInfo *reg, uint64_t val)
 {
     RISCVDMState *s = RISCV_DM(reg->opaque);
     uint32_t wsel = ARRAY_FIELD_EX32(s->regs, HAWINDOWSEL, HAWINDOWSEL);
-
-    (void)val;
     if (wsel < RISCV_DM_MAX_HARTS / RISCV_DM_HAWINDOW_SIZE) {
         return s->hawindow[wsel];
     }
     return 0;
 }
 
+static uint64_t dm_abstractcs_pre_write(RegisterInfo *reg, uint64_t val64)
+{
+    RISCVDMState *s = RISCV_DM(reg->opaque);
+
+    if (ARRAY_FIELD_EX32(s->regs, ABSTRACTCS, BUSY)) {
+        dm_set_cmderr(s, RISCV_DM_CMDERR_BUSY);
+        return s->regs[R_ABSTRACTCS];
+    }
+
+    /* W1C on CMDERR */
+    uint32_t w1c_bits = FIELD_EX32((uint32_t)val64, ABSTRACTCS, CMDERR);
+    uint32_t cur = s->regs[R_ABSTRACTCS];
+    uint32_t cmderr = FIELD_EX32(cur, ABSTRACTCS, CMDERR);
+    cmderr &= ~w1c_bits;
+    cur = FIELD_DP32(cur, ABSTRACTCS, CMDERR, cmderr);
+
+    return cur;
+}
+
+static uint64_t dm_command_pre_write(RegisterInfo *reg, uint64_t val64)
+{
+    RISCVDMState *s = RISCV_DM(reg->opaque);
+
+    /* Stub: abstract command execution added in a follow-on patch. */
+    s->last_cmd = (uint32_t)val64;
+    return s->regs[R_COMMAND];
+}
+
+static uint64_t dm_command_post_read(RegisterInfo *reg, uint64_t val)
+{
+    return 0;
+}
+
+static uint64_t dm_abstractauto_pre_write(RegisterInfo *reg, uint64_t val64)
+{
+    RISCVDMState *s = RISCV_DM(reg->opaque);
+
+    if (ARRAY_FIELD_EX32(s->regs, ABSTRACTCS, BUSY)) {
+        dm_set_cmderr(s, RISCV_DM_CMDERR_BUSY);
+        return s->regs[R_ABSTRACTAUTO];
+    }
+
+    /* Stub: autoexec trigger logic added in a follow-on patch. */
+    uint32_t data_count = MIN(s->num_abstract_data, 12);
+    uint32_t pbuf_size = MIN(s->progbuf_size, 16);
+    uint32_t data_mask = data_count ? ((1u << data_count) - 1u) : 0;
+    uint32_t pbuf_mask = pbuf_size ? ((1u << pbuf_size) - 1u) : 0;
+    uint32_t mask = data_mask | (pbuf_mask << 16);
+
+    return (uint32_t)val64 & mask;
+}
+
+static uint64_t dm_data_pre_write(RegisterInfo *reg, uint64_t val64)
+{
+    RISCVDMState *s = RISCV_DM(reg->opaque);
+
+    if (ARRAY_FIELD_EX32(s->regs, ABSTRACTCS, BUSY)) {
+        dm_set_cmderr(s, RISCV_DM_CMDERR_BUSY);
+        return s->regs[reg->access->addr / 4];
+    }
+    return (uint32_t)val64;
+}
+
+static void dm_data_post_write(RegisterInfo *reg, uint64_t val64)
+{
+    RISCVDMState *s = RISCV_DM(reg->opaque);
+    int index = (reg->access->addr - A_DATA0) / 4;
+
+    dm_sync_data_to_rom(s, index);
+}
+
+static uint64_t dm_data_post_read(RegisterInfo *reg, uint64_t val)
+{
+    return val;
+}
+
+static uint64_t dm_progbuf_pre_write(RegisterInfo *reg, uint64_t val64)
+{
+    RISCVDMState *s = RISCV_DM(reg->opaque);
+
+    if (ARRAY_FIELD_EX32(s->regs, ABSTRACTCS, BUSY)) {
+        dm_set_cmderr(s, RISCV_DM_CMDERR_BUSY);
+        return s->regs[reg->access->addr / 4];
+    }
+    return (uint32_t)val64;
+}
+
+static void dm_progbuf_post_write(RegisterInfo *reg, uint64_t val64)
+{
+    RISCVDMState *s = RISCV_DM(reg->opaque);
+    int index = (reg->access->addr - A_PROGBUF0) / 4;
+
+    dm_sync_progbuf_to_rom(s, index);
+}
+
+static uint64_t dm_progbuf_post_read(RegisterInfo *reg, uint64_t val)
+{
+    return val;
+}
+
 static uint64_t dm_haltsum0_post_read(RegisterInfo *reg, uint64_t val)
 {
     RISCVDMState *s = RISCV_DM(reg->opaque);
-    uint32_t sum = 0;
-    uint32_t base = 0;
-    uint32_t limit = MIN(s->num_harts, 32u);
-
-    (void)val;
-    for (uint32_t h = base; h < limit; h++) {
-        if (s->hart_halted[h]) {
-            sum |= 1u << (h - base);
+    uint32_t result = 0;
+    uint32_t base = dm_get_hartsel(s) & ~0x1fu;
+
+    for (uint32_t i = 0; i < 32; i++) {
+        uint32_t h = base + i;
+        if (h < s->num_harts && s->hart_halted[h]) {
+            result |= (1u << i);
         }
     }
-    return sum;
+    return result;
 }
 
 static uint64_t dm_haltsum1_post_read(RegisterInfo *reg, uint64_t val)
 {
     RISCVDMState *s = RISCV_DM(reg->opaque);
-    uint32_t sum = 0;
-
-    (void)reg;
-    (void)val;
-    for (uint32_t h = 0; h < s->num_harts; h++) {
-        if (s->hart_halted[h]) {
-            sum |= 1u << (h / 32);
+    uint32_t result = 0;
+    uint32_t base = dm_get_hartsel(s) & ~0x3ffu;
+
+    for (uint32_t g = 0; g < 32; g++) {
+        for (uint32_t i = 0; i < 32; i++) {
+            uint32_t h = base + g * 32 + i;
+            if (h < s->num_harts && s->hart_halted[h]) {
+                result |= (1u << g);
+                break;
+            }
         }
     }
-    return sum;
+    return result;
 }
 
+
 static RegisterAccessInfo riscv_dm_regs_info[] = {
+    { .name = "DATA0",  .addr = A_DATA0,  .pre_write = dm_data_pre_write,
+      .post_write = dm_data_post_write, .post_read = dm_data_post_read, },
+    { .name = "DATA1",  .addr = A_DATA1,  .pre_write = dm_data_pre_write,
+      .post_write = dm_data_post_write, .post_read = dm_data_post_read, },
+    { .name = "DATA2",  .addr = A_DATA2,  .pre_write = dm_data_pre_write,
+      .post_write = dm_data_post_write, .post_read = dm_data_post_read, },
+    { .name = "DATA3",  .addr = A_DATA3,  .pre_write = dm_data_pre_write,
+      .post_write = dm_data_post_write, .post_read = dm_data_post_read, },
+    { .name = "DATA4",  .addr = A_DATA4,  .pre_write = dm_data_pre_write,
+      .post_write = dm_data_post_write, .post_read = dm_data_post_read, },
+    { .name = "DATA5",  .addr = A_DATA5,  .pre_write = dm_data_pre_write,
+      .post_write = dm_data_post_write, .post_read = dm_data_post_read, },
+    { .name = "DATA6",  .addr = A_DATA6,  .pre_write = dm_data_pre_write,
+      .post_write = dm_data_post_write, .post_read = dm_data_post_read, },
+    { .name = "DATA7",  .addr = A_DATA7,  .pre_write = dm_data_pre_write,
+      .post_write = dm_data_post_write, .post_read = dm_data_post_read, },
+    { .name = "DATA8",  .addr = A_DATA8,  .pre_write = dm_data_pre_write,
+      .post_write = dm_data_post_write, .post_read = dm_data_post_read, },
+    { .name = "DATA9",  .addr = A_DATA9,  .pre_write = dm_data_pre_write,
+      .post_write = dm_data_post_write, .post_read = dm_data_post_read, },
+    { .name = "DATA10", .addr = A_DATA10, .pre_write = dm_data_pre_write,
+      .post_write = dm_data_post_write, .post_read = dm_data_post_read, },
+    { .name = "DATA11", .addr = A_DATA11, .pre_write = dm_data_pre_write,
+      .post_write = dm_data_post_write, .post_read = dm_data_post_read, },
+
     { .name = "DMCONTROL", .addr = A_DMCONTROL,
       .pre_write = dm_dmcontrol_pre_write, },
+
     { .name = "DMSTATUS", .addr = A_DMSTATUS,
-      .ro = 0xffffffff,
+      .ro = 0xFFFFFFFF,
       .post_read = dm_dmstatus_post_read, },
+
     { .name = "HARTINFO", .addr = A_HARTINFO,
-      .ro = 0xffffffff,
+      .ro = 0xFFFFFFFF,
       .post_read = dm_hartinfo_post_read, },
+
     { .name = "HALTSUM1", .addr = A_HALTSUM1,
-      .ro = 0xffffffff,
+      .ro = 0xFFFFFFFF,
       .post_read = dm_haltsum1_post_read, },
+
     { .name = "HAWINDOWSEL", .addr = A_HAWINDOWSEL,
       .pre_write = dm_hawindowsel_pre_write, },
+
     { .name = "HAWINDOW", .addr = A_HAWINDOW,
       .pre_write = dm_hawindow_pre_write,
       .post_read = dm_hawindow_post_read, },
+
     { .name = "ABSTRACTCS", .addr = A_ABSTRACTCS,
-      .ro = 0xffffffff, },
+      .ro = R_ABSTRACTCS_DATACOUNT_MASK | R_ABSTRACTCS_BUSY_MASK |
+            R_ABSTRACTCS_PROGBUFSIZE_MASK,
+      .pre_write = dm_abstractcs_pre_write, },
+
+    { .name = "COMMAND", .addr = A_COMMAND,
+      .pre_write = dm_command_pre_write,
+      .post_read = dm_command_post_read, },
+
+    { .name = "ABSTRACTAUTO", .addr = A_ABSTRACTAUTO,
+      .pre_write = dm_abstractauto_pre_write, },
+
+    { .name = "CONFSTRPTR0", .addr = A_CONFSTRPTR0, .ro = 0xFFFFFFFF, },
+    { .name = "CONFSTRPTR1", .addr = A_CONFSTRPTR1, .ro = 0xFFFFFFFF, },
+    { .name = "CONFSTRPTR2", .addr = A_CONFSTRPTR2, .ro = 0xFFFFFFFF, },
+    { .name = "CONFSTRPTR3", .addr = A_CONFSTRPTR3, .ro = 0xFFFFFFFF, },
+
+    { .name = "NEXTDM", .addr = A_NEXTDM, .ro = 0xFFFFFFFF, },
+
+    { .name = "PROGBUF0", .addr = A_PROGBUF0,
+      .pre_write = dm_progbuf_pre_write,
+      .post_write = dm_progbuf_post_write,
+      .post_read = dm_progbuf_post_read, },
+    { .name = "PROGBUF1", .addr = A_PROGBUF1,
+      .pre_write = dm_progbuf_pre_write,
+      .post_write = dm_progbuf_post_write,
+      .post_read = dm_progbuf_post_read, },
+    { .name = "PROGBUF2", .addr = A_PROGBUF2,
+      .pre_write = dm_progbuf_pre_write,
+      .post_write = dm_progbuf_post_write,
+      .post_read = dm_progbuf_post_read, },
+    { .name = "PROGBUF3", .addr = A_PROGBUF3,
+      .pre_write = dm_progbuf_pre_write,
+      .post_write = dm_progbuf_post_write,
+      .post_read = dm_progbuf_post_read, },
+    { .name = "PROGBUF4", .addr = A_PROGBUF4,
+      .pre_write = dm_progbuf_pre_write,
+      .post_write = dm_progbuf_post_write,
+      .post_read = dm_progbuf_post_read, },
+    { .name = "PROGBUF5", .addr = A_PROGBUF5,
+      .pre_write = dm_progbuf_pre_write,
+      .post_write = dm_progbuf_post_write,
+      .post_read = dm_progbuf_post_read, },
+    { .name = "PROGBUF6", .addr = A_PROGBUF6,
+      .pre_write = dm_progbuf_pre_write,
+      .post_write = dm_progbuf_post_write,
+      .post_read = dm_progbuf_post_read, },
+    { .name = "PROGBUF7", .addr = A_PROGBUF7,
+      .pre_write = dm_progbuf_pre_write,
+      .post_write = dm_progbuf_post_write,
+      .post_read = dm_progbuf_post_read, },
+    { .name = "PROGBUF8", .addr = A_PROGBUF8,
+      .pre_write = dm_progbuf_pre_write,
+      .post_write = dm_progbuf_post_write,
+      .post_read = dm_progbuf_post_read, },
+    { .name = "PROGBUF9", .addr = A_PROGBUF9,
+      .pre_write = dm_progbuf_pre_write,
+      .post_write = dm_progbuf_post_write,
+      .post_read = dm_progbuf_post_read, },
+    { .name = "PROGBUF10", .addr = A_PROGBUF10,
+      .pre_write = dm_progbuf_pre_write,
+      .post_write = dm_progbuf_post_write,
+      .post_read = dm_progbuf_post_read, },
+    { .name = "PROGBUF11", .addr = A_PROGBUF11,
+      .pre_write = dm_progbuf_pre_write,
+      .post_write = dm_progbuf_post_write,
+      .post_read = dm_progbuf_post_read, },
+    { .name = "PROGBUF12", .addr = A_PROGBUF12,
+      .pre_write = dm_progbuf_pre_write,
+      .post_write = dm_progbuf_post_write,
+      .post_read = dm_progbuf_post_read, },
+    { .name = "PROGBUF13", .addr = A_PROGBUF13,
+      .pre_write = dm_progbuf_pre_write,
+      .post_write = dm_progbuf_post_write,
+      .post_read = dm_progbuf_post_read, },
+    { .name = "PROGBUF14", .addr = A_PROGBUF14,
+      .pre_write = dm_progbuf_pre_write,
+      .post_write = dm_progbuf_post_write,
+      .post_read = dm_progbuf_post_read, },
+    { .name = "PROGBUF15", .addr = A_PROGBUF15,
+      .pre_write = dm_progbuf_pre_write,
+      .post_write = dm_progbuf_post_write,
+      .post_read = dm_progbuf_post_read, },
+
+    { .name = "AUTHDATA", .addr = A_AUTHDATA, },
+
+    { .name = "DMCS2", .addr = A_DMCS2, },
+
+    { .name = "HALTSUM2", .addr = A_HALTSUM2, .ro = 0xFFFFFFFF, },
+    { .name = "HALTSUM3", .addr = A_HALTSUM3, .ro = 0xFFFFFFFF, },
+
+    { .name = "SBADDRESS3", .addr = A_SBADDRESS3, },
+
+    { .name = "SBCS", .addr = A_SBCS,
+      .ro = R_SBCS_SBACCESS8_MASK | R_SBCS_SBACCESS16_MASK |
+            R_SBCS_SBACCESS32_MASK | R_SBCS_SBACCESS64_MASK |
+            R_SBCS_SBACCESS128_MASK | R_SBCS_SBASIZE_MASK |
+            R_SBCS_SBBUSY_MASK | R_SBCS_SBVERSION_MASK, },
+
+    { .name = "SBADDRESS0", .addr = A_SBADDRESS0, },
+
+    { .name = "SBADDRESS1", .addr = A_SBADDRESS1, },
+
+    { .name = "SBADDRESS2", .addr = A_SBADDRESS2, },
+
+    { .name = "SBDATA0", .addr = A_SBDATA0, },
+
+    { .name = "SBDATA1", .addr = A_SBDATA1, },
+
+    { .name = "SBDATA2", .addr = A_SBDATA2, },
+    { .name = "SBDATA3", .addr = A_SBDATA3, },
+
     { .name = "HALTSUM0", .addr = A_HALTSUM0,
-      .ro = 0xffffffff,
+      .ro = 0xFFFFFFFF,
       .post_read = dm_haltsum0_post_read, },
 };
 
+
 static uint64_t riscv_dm_read(void *opaque, hwaddr addr, unsigned size)
 {
     RegisterInfoArray *reg_array = opaque;
@@ -829,6 +1152,16 @@ static uint64_t dm_rom_read(void *opaque, hwaddr offset, unsigned size)
     uint64_t ret;
 
     ret = ldn_le_p(s->rom_ptr + offset, size);
+
+    /* DATA area remap: reads from ROM DATA area return register values */
+    if (offset >= RISCV_DM_ROM_DATA &&
+        offset < RISCV_DM_ROM_DATA + s->num_abstract_data * 4) {
+        int idx = (offset - RISCV_DM_ROM_DATA) / 4;
+        if (size == 4) {
+            ret = s->regs[R_DATA0 + idx];
+        }
+    }
+
     trace_riscv_dm_rom_access(offset, ret, size, false);
     return ret;
 }
@@ -837,54 +1170,59 @@ static void dm_rom_write(void *opaque, hwaddr offset,
                          uint64_t value, unsigned size)
 {
     RISCVDMState *s = opaque;
-    uint32_t hartsel;
 
     stn_le_p(s->rom_ptr + offset, size, value);
 
     trace_riscv_dm_rom_access(offset, value, size, true);
 
+    /* CPU wrote to HARTID register → hart has halted */
     if (offset == RISCV_DM_ROM_HARTID && size == 4) {
-        hartsel = value;
+        uint32_t hartsel = (uint32_t)value;
         if (dm_hart_valid(s, hartsel)) {
             riscv_dm_hart_halted(s, hartsel);
         }
-        return;
     }
 
+    /* CPU wrote GOING acknowledgment */
     if (offset == RISCV_DM_ROM_GOING && size == 4) {
-        hartsel = dm_rom_read32(s, RISCV_DM_ROM_HARTID);
+        uint32_t hartsel = dm_rom_read32(s, RISCV_DM_ROM_HARTID);
         if (dm_hart_valid(s, hartsel)) {
             dm_rom_write8(s, RISCV_DM_ROM_FLAGS + hartsel,
                           RISCV_DM_FLAG_CLEAR);
             trace_riscv_dm_going(hartsel);
         }
-        return;
     }
 
+    /* CPU wrote RESUME acknowledgment */
     if (offset == RISCV_DM_ROM_RESUME && size == 4) {
-        hartsel = value;
+        uint32_t hartsel = (uint32_t)value;
         if (dm_hart_valid(s, hartsel)) {
             riscv_dm_hart_resumed(s, hartsel);
         }
-        return;
     }
 
+    /* CPU wrote EXCEPTION */
     if (offset == RISCV_DM_ROM_EXCP && size == 4) {
-        hartsel = dm_rom_read32(s, RISCV_DM_ROM_HARTID);
+        uint32_t hartsel = dm_rom_read32(s, RISCV_DM_ROM_HARTID);
         if (dm_hart_valid(s, hartsel)) {
             riscv_dm_abstracts_exception(s, hartsel);
         }
     }
+
+    /* DATA area remap: writes to ROM DATA area update registers */
+    if (offset >= RISCV_DM_ROM_DATA &&
+        offset < RISCV_DM_ROM_DATA + s->num_abstract_data * 4 && size == 4) {
+        int idx = (offset - RISCV_DM_ROM_DATA) / 4;
+        s->regs[R_DATA0 + idx] = (uint32_t)value;
+    }
 }
 
 static const MemoryRegionOps dm_rom_ops = {
     .read = dm_rom_read,
     .write = dm_rom_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
-    .impl = {
-        .min_access_size = 1,
-        .max_access_size = 4,
-    },
+    .impl.min_access_size = 1,
+    .impl.max_access_size = 4,
 };
 
 static bool dm_rom_realize(RISCVDMState *s, Error **errp)
@@ -967,12 +1305,18 @@ static bool dm_rom_realize(RISCVDMState *s, Error **errp)
                              "riscv-dm.rom-entry", &s->rom_mr,
                              RISCV_DM_ROM_ENTRY, RISCV_DM_ROM_ENTRY_SIZE);
 
+    /*
+     * Expose debug backing store in two non-overlapping physical windows:
+     * - work area at low addresses (mailbox/data/progbuf/flags)
+     * - ROM entry vector at VIRT_DM_ROM base
+     */
     sysbus_init_mmio(sbd, &s->rom_work_alias_mr);
     sysbus_init_mmio(sbd, &s->rom_entry_alias_mr);
 
     return true;
 }
 
+
 void riscv_dm_hart_halted(RISCVDMState *s, uint32_t hartsel)
 {
     if (!dm_hart_valid(s, hartsel)) {
@@ -998,6 +1342,7 @@ void riscv_dm_hart_resumed(RISCVDMState *s, uint32_t hartsel)
     s->hart_halted[hartsel] = false;
     s->hart_resumeack[hartsel] = true;
     dm_rom_write8(s, RISCV_DM_ROM_FLAGS + hartsel, RISCV_DM_FLAG_CLEAR);
+
     dm_status_refresh(s);
     trace_riscv_dm_hart_resumed(hartsel);
 }
@@ -1014,6 +1359,7 @@ void riscv_dm_abstracts_exception(RISCVDMState *s, uint32_t hartsel)
     trace_riscv_dm_abstract_cmd_exception(hartsel);
 }
 
+
 static void dm_debug_reset(RISCVDMState *s)
 {
     s->dm_active = false;
@@ -1048,15 +1394,18 @@ static void dm_debug_reset(RISCVDMState *s)
     dm_status_refresh(s);
 }
 
+
 static void riscv_dm_init(Object *obj)
 {
     RISCVDMState *s = RISCV_DM(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
-    s->reg_array = register_init_block32(DEVICE(obj), riscv_dm_regs_info,
-                                         ARRAY_SIZE(riscv_dm_regs_info),
-                                         s->regs_info, s->regs, &riscv_dm_ops,
-                                         false, RISCV_DM_REG_SIZE);
+    s->reg_array =
+        register_init_block32(DEVICE(obj), riscv_dm_regs_info,
+                              ARRAY_SIZE(riscv_dm_regs_info),
+                              s->regs_info, s->regs,
+                              &riscv_dm_ops, false,
+                              RISCV_DM_REG_SIZE);
 
     sysbus_init_mmio(sbd, &s->reg_array->mem);
 }
@@ -1071,6 +1420,25 @@ static void riscv_dm_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (s->num_abstract_data == 0 || s->num_abstract_data > 12) {
+        error_setg(errp, "riscv-dm: datacount %u must be in range 1..12",
+                   s->num_abstract_data);
+        return;
+    }
+
+    if (s->progbuf_size > 16) {
+        error_setg(errp, "riscv-dm: progbufsize %u exceeds maximum 16",
+                   s->progbuf_size);
+        return;
+    }
+
+    if (s->progbuf_size == 1 && !s->impebreak) {
+        error_setg(errp,
+                   "riscv-dm: progbufsize 1 requires impebreak to be enabled");
+        return;
+    }
+
+    /* Allocate per-hart state */
     if (s->num_harts > 0) {
         s->hart_halted = g_new0(bool, s->num_harts);
         s->hart_resumeack = g_new0(bool, s->num_harts);
@@ -1089,19 +1457,19 @@ static void riscv_dm_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /* Apply initial reset */
     dm_debug_reset(s);
 }
 
 static void riscv_dm_reset_hold(Object *obj, ResetType type)
 {
-    (void)type;
-    dm_debug_reset(RISCV_DM(obj));
+    RISCVDMState *s = RISCV_DM(obj);
+    dm_debug_reset(s);
 }
 
 static void riscv_dm_unrealize(DeviceState *dev)
 {
     RISCVDMState *s = RISCV_DM(dev);
-
     g_free(s->hart_halted);
     g_free(s->hart_resumeack);
     g_free(s->hart_havereset);
@@ -1109,6 +1477,7 @@ static void riscv_dm_unrealize(DeviceState *dev)
     g_free(s->halt_irqs);
 }
 
+
 static const Property riscv_dm_props[] = {
     DEFINE_PROP_UINT32("num-harts", RISCVDMState, num_harts, 1),
     DEFINE_PROP_UINT32("datacount", RISCVDMState, num_abstract_data, 2),
@@ -1183,5 +1552,6 @@ DeviceState *riscv_dm_create(MemoryRegion *sys_mem, hwaddr base,
     /* MMIO region 2: debug ROM entry vector */
     memory_region_add_subregion(sys_mem, base + RISCV_DM_ROM_ENTRY,
                                 sysbus_mmio_get_region(sbd, 2));
+
     return dev;
 }
-- 
2.53.0


