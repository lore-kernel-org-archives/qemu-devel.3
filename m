Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEE6CCD1B9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 16:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBF7U-0004SE-79; Tue, 21 Oct 2025 12:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vBF7A-0004Ld-6L
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:21:38 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vBF6w-0002Y7-Cw
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:21:26 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-781ea2cee3fso5200030b3a.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 09:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1761063680; x=1761668480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V7OWg3xhf8hcd2KugK7381OPAfVuAeutnPeAuNj80lI=;
 b=fAsNY/nxWapNdbE12fowqC6AX87uCmLnqRBOBp1IW+HLpHxg2ZE4Ke7dmppCXnzsye
 99jOVzGp+heGqdoiHiJJwxjnGj2I4bQjaYwrZEpqbTmvIqGQoWMI4LPnoZLNfJTqAZSz
 VLhF7YaFefAdVrw9We8u4gjHNA8yESi7suj9A2Exxxo10SKzvggP1HrpjdcwYpRY/Ssa
 Dzs349d6PQivscj3fOyGQm961m6IX7xWy/QiOUdhmrJtHMkNiN2rKlx+N6w3h8+nAco2
 +jovlx80DFI42NMHOZjNGydOthEAjge5qBjtYyqwWhCHRCqp8G52E5pB51+5T/gwgDsQ
 ryxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761063680; x=1761668480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V7OWg3xhf8hcd2KugK7381OPAfVuAeutnPeAuNj80lI=;
 b=rtE3MF8Y2FeDoaMAYnhSVZPZPGEXl5ZGAh1QlpotNkywohov03TB6IzQQl7OI4cIoo
 W6fsbgev2GVl2khE1muwW9Har0aTnYD2Tj059JoBEG0bydNVhb2AfmnIAftBOb5HiCS5
 NOQpAiCpBRUAloS7HYaj2UFK8nlaecn+gSbi9ALnd3RgTdTAwcLM7ESsJ/9JfibI1Acj
 H4DQ0h/6UMDee5LCuFBkT6H6x1mMz+N5j8sP82d+BYqqSRwnwtJKnnmCl5vkLsKcDL4N
 FXD3iOiY72ImU4gnvklW+Ux9+zyk+M0XjgIkFUJL7OzpY/nHPLZ65nr6CSqpkT/ps/BK
 TBZA==
X-Gm-Message-State: AOJu0YyfPzwWmVc67tyYqLyEUtr7M+6XKVTgBoqRJZB6EHy1SgR9gYy+
 OC7s2XMkgS2MzNf3mDfSeqqLeq+GR/7wV2l4Ttg9Gh7tGVV1grL/+l4GkmL6G+PtUyXIIu+Zum+
 uZUhu/41zNJ0k9WczB6gLGN9rW/J5fhnLDc9HfT5tj6smatcK6Pj1cXhWSfSjhC48WAqEz7oNC8
 Riz2+JQuGIP52PExIW1SMzu4p1cJnkvQLXKmuzcg==
X-Gm-Gg: ASbGncvAw3rtXRV5N4GlznXwNfkBgEtg9yz5uzckPPMUys6RpTdJxVPl7rRaJNzn0Fn
 DX17shra96kpaokmdlW0+1CX1Ti+vGV5TkyHo9hdt9jGyvYy5b2xq9vMy6hS5Ccf2P605s81b6J
 2PCUSvJD+dJ3slrPctYYx/5N2UIkP4fkld319u1eCjCA2JWhp4cWOluwrGx6hkDqKC6AJgr8ogz
 6jWtvrDJ1i0ye+A1uy6M6lyklVAN2IleAB5EUZXjSqy70svhgH3Yo+xHS3AbLRMkVMU1UIGYimQ
 mTxBpLpNMdeXob8g0GrO6QVltRUIqnY3BkTVscrYBM4prn0uB6LKRpIickhwakCVlZzKWA39Orw
 M/tcHssOa2ahabdxrkZcGSHT7tMj1onkxzhg/A1XOnfr63EPB66nii4gFZEJc75ruv9dc2ikoQO
 hwfTQWfNs479/YVXcSMdDl6Q==
X-Google-Smtp-Source: AGHT+IGggbcFtpUPpmjce8nnOZM0nUwued5cfZ0Tf3WDatbH77nY5U36b5TuuRnHiqw5qbHZaZL59Q==
X-Received: by 2002:a05:6a00:1705:b0:77f:3149:372f with SMTP id
 d2e1a72fcca58-7a220a3bf85mr21621616b3a.8.1761063679839; 
 Tue, 21 Oct 2025 09:21:19 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a23011088fsm11720280b3a.65.2025.10.21.09.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 09:21:19 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jim Shu <jim.shu@sifive.com>, "Fea . Wang" <fea.wang@sifive.com>
Subject: [PATCH v3 16/18] hw/misc: riscv_wgchecker: Implement correct
 block-access behavior
Date: Wed, 22 Oct 2025 00:21:06 +0800
Message-ID: <20251021162108.585468-2-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251021155548.584543-1-jim.shu@sifive.com>
References: <20251021155548.584543-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The wgChecker is configurable for whether blocked accesses:
* should cause a bus error or just read return zero and write ignore
* should generate the interrupt or not

Also, when updating error-cause register in world-guard checker, it
should also update the interrupt status.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Signed-off-by: Fea.Wang <fea.wang@sifive.com>
---
 hw/misc/riscv_wgchecker.c | 179 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 177 insertions(+), 2 deletions(-)

diff --git a/hw/misc/riscv_wgchecker.c b/hw/misc/riscv_wgchecker.c
index 99439a1c68..b4acdaa294 100644
--- a/hw/misc/riscv_wgchecker.c
+++ b/hw/misc/riscv_wgchecker.c
@@ -99,6 +99,176 @@ REG32(SLOT_CFG,             0x010)
 #define P_READ                  (1 << 0)
 #define P_WRITE                 (1 << 1)
 
+static void decode_napot(hwaddr a, hwaddr *sa, hwaddr *ea)
+{
+    /*
+     * aaaa...aaa0   8-byte NAPOT range
+     * aaaa...aa01   16-byte NAPOT range
+     * aaaa...a011   32-byte NAPOT range
+     * ...
+     * aa01...1111   2^XLEN-byte NAPOT range
+     * a011...1111   2^(XLEN+1)-byte NAPOT range
+     * 0111...1111   2^(XLEN+2)-byte NAPOT range
+     * 1111...1111   Reserved
+     */
+
+    a = FROM_SLOT_ADDR(a) | 0x3;
+
+    if (sa) {
+        *sa = a & (a + 1);
+    }
+    if (ea) {
+        *ea = a | (a + 1);
+    }
+}
+
+typedef struct WgAccessResult WgAccessResult;
+struct WgAccessResult {
+    bool is_success;
+    bool has_bus_error;
+    bool has_interrupt;
+    uint8_t perm:2;
+};
+
+static WgAccessResult wgc_check_access(
+    RISCVWgCheckerState *s, hwaddr phys_addr, uint32_t wid, bool is_write)
+{
+    WgCheckerSlot *slot, *prev_slot;
+    uint32_t cfg_a, prev_cfg_a;
+    uint64_t start, end;
+    int slot_id, wgc_perm = 0;
+    WgAccessResult result = { 0 };
+
+    bool is_matching = false;
+    bool slot0_be, slot0_ip;
+    bool matched_slot_be = false, matched_slot_ip = false;
+
+    for (slot_id = 0; slot_id < s->slot_count; slot_id++) {
+        slot = &s->slots[slot_id + 1];
+        cfg_a = FIELD_EX32(slot->cfg, SLOT_CFG, A);
+
+        if (cfg_a == A_TOR) {
+            prev_slot = &s->slots[slot_id];
+
+            prev_cfg_a = FIELD_EX32(prev_slot->cfg, SLOT_CFG, A);
+            if (prev_cfg_a == A_NA4) {
+                start = FROM_SLOT_ADDR(prev_slot->addr) + 4;
+            } else if (prev_cfg_a == A_NAPOT) {
+                decode_napot(prev_slot->addr, NULL, &start);
+                start += 1;
+            } else { /* A_TOR or A_OFF */
+                start = FROM_SLOT_ADDR(prev_slot->addr);
+            }
+            end = FROM_SLOT_ADDR(slot->addr);
+        } else if (cfg_a == A_NA4) {
+            start = FROM_SLOT_ADDR(slot->addr);
+            end = start + 4;
+        } else if (cfg_a == A_NAPOT) {
+            decode_napot(slot->addr, &start, &end);
+            end += 1;
+        } else {
+            /* A_OFF: not in slot range. */
+            continue;
+        }
+
+        /* wgChecker slot range is between start to (end - 1). */
+        if ((start <= phys_addr) && (phys_addr < end)) {
+            /* Match the wgC slot */
+            int perm = ((slot->perm >> (wid * 2)) & 0x3);
+
+            /* If any matching rule permits access, the access is permitted. */
+            wgc_perm |= perm;
+
+            /*
+             * If any matching rule wants to report error (IRQ or Bus Error),
+             * the denied access should report error.
+             */
+            is_matching = true;
+            if (is_write) {
+                matched_slot_be |= FIELD_EX64(slot->cfg, SLOT_CFG, EW);
+                matched_slot_ip |= FIELD_EX64(slot->cfg, SLOT_CFG, IW);
+            } else {
+                matched_slot_be |= FIELD_EX64(slot->cfg, SLOT_CFG, ER);
+                matched_slot_ip |= FIELD_EX64(slot->cfg, SLOT_CFG, IR);
+            }
+        }
+    }
+
+    /* If no matching rule, error reporting depends on the slot0's config. */
+    if (is_write) {
+        slot0_be = FIELD_EX64(s->slots[0].cfg, SLOT_CFG, EW);
+        slot0_ip = FIELD_EX64(s->slots[0].cfg, SLOT_CFG, IW);
+    } else {
+        slot0_be = FIELD_EX64(s->slots[0].cfg, SLOT_CFG, ER);
+        slot0_ip = FIELD_EX64(s->slots[0].cfg, SLOT_CFG, IR);
+    }
+
+    result.is_success = is_write ? (wgc_perm & P_WRITE) : (wgc_perm & P_READ);
+    result.perm = wgc_perm;
+    if (!result.is_success) {
+        if (is_matching) {
+            result.has_bus_error = matched_slot_be;
+            result.has_interrupt = matched_slot_ip;
+        } else {
+            result.has_bus_error = slot0_be;
+            result.has_interrupt = slot0_ip;
+        }
+    }
+
+    return result;
+}
+
+static bool riscv_wgc_irq_update(RISCVWgCheckerState *s)
+{
+    bool ip = FIELD_EX64(s->errcause, ERRCAUSE, IP);
+    qemu_set_irq(s->irq, ip);
+    return ip;
+}
+
+static MemTxResult riscv_wgc_handle_blocked_access(
+    WgCheckerRegion *region, hwaddr addr, uint32_t wid, bool is_write)
+{
+    RISCVWgCheckerState *s = RISCV_WGCHECKER(region->wgchecker);
+    bool be, ip;
+    WgAccessResult result;
+    hwaddr phys_addr;
+
+    be = FIELD_EX64(s->errcause, ERRCAUSE, BE);
+    ip = FIELD_EX64(s->errcause, ERRCAUSE, IP);
+    phys_addr = addr + region->region_offset;
+
+    /*
+     * Check if this blocked access trigger IRQ (Bus Error) or not.
+     * It depends on wgChecker slot config (cfg.IR/IW/ER/EW bits).
+     */
+    result = wgc_check_access(s, phys_addr, wid, is_write);
+
+    if (!be && !ip) {
+        /*
+         * With either of the be or ip bits is set, further violations do not
+         * update the errcause or erraddr registers. Also, new interrupts
+         * cannot be generated until the be and ip fields are cleared.
+         */
+        if (result.has_interrupt || result.has_bus_error) {
+            s->errcause = FIELD_DP64(s->errcause, ERRCAUSE, WID, wid);
+            s->errcause = FIELD_DP64(s->errcause, ERRCAUSE, R, !is_write);
+            s->errcause = FIELD_DP64(s->errcause, ERRCAUSE, W, is_write);
+            s->erraddr = TO_SLOT_ADDR(phys_addr);
+        }
+
+        if (result.has_interrupt) {
+            s->errcause = FIELD_DP64(s->errcause, ERRCAUSE, IP, 1);
+            riscv_wgc_irq_update(s);
+        }
+
+        if (result.has_bus_error) {
+            s->errcause = FIELD_DP64(s->errcause, ERRCAUSE, BE, 1);
+        }
+    }
+
+    return result.has_bus_error ? MEMTX_ERROR : MEMTX_OK;
+}
+
 /*
  * Accesses only reach these read and write functions if the wgChecker
  * is blocking them; non-blocked accesses go directly to the downstream
@@ -108,25 +278,27 @@ static MemTxResult riscv_wgc_mem_blocked_read(void *opaque, hwaddr addr,
                                                uint64_t *pdata,
                                                unsigned size, MemTxAttrs attrs)
 {
+    WgCheckerRegion *region = opaque;
     uint32_t wid = mem_attrs_to_wid(attrs);
 
     hwaddr phys_addr = addr + region->region_offset;
     trace_riscv_wgchecker_mem_blocked_read(phys_addr, size, wid);
 
     *pdata = 0;
-    return MEMTX_OK;
+    return riscv_wgc_handle_blocked_access(region, addr, wid, false);
 }
 
 static MemTxResult riscv_wgc_mem_blocked_write(void *opaque, hwaddr addr,
                                                uint64_t value,
                                                unsigned size, MemTxAttrs attrs)
 {
+    WgCheckerRegion *region = opaque;
     uint32_t wid = mem_attrs_to_wid(attrs);
 
     hwaddr phys_addr = addr + region->region_offset;
     trace_riscv_wgchecker_mem_blocked_write(phys_addr, value, size, wid);
 
-    return MEMTX_OK;
+    return riscv_wgc_handle_blocked_access(region, addr, wid, true);
 }
 
 static const MemoryRegionOps riscv_wgc_mem_blocked_ops = {
@@ -446,6 +618,7 @@ static void riscv_wgchecker_writeq(void *opaque, hwaddr addr,
     switch (addr) {
     case A_ERRCAUSE:
         s->errcause = value & ERRCAUSE_MASK;
+        riscv_wgc_irq_update(s);
         break;
     case A_ERRADDR:
         s->erraddr = value;
@@ -546,6 +719,7 @@ static void riscv_wgchecker_writel(void *opaque, hwaddr addr,
     case A_ERRCAUSE + 4:
         value &= extract64(ERRCAUSE_MASK, 32, 32);
         s->errcause = deposit64(s->errcause, 32, 32, value);
+        riscv_wgc_irq_update(s);
         break;
     case A_ERRADDR:
         s->erraddr = deposit64(s->erraddr, 0, 32, value);
@@ -824,6 +998,7 @@ static void riscv_wgchecker_reset_enter(Object *obj, ResetType type)
 
     s->errcause = 0;
     s->erraddr = 0;
+    riscv_wgc_irq_update(s);
 
     for (int i = 0; i < nslots; i++) {
         s->slots[i].addr = TO_SLOT_ADDR(start);
-- 
2.43.0


