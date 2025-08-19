Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07661CA0EFB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoQzI-0004yZ-Fc; Tue, 19 Aug 2025 14:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoQzG-0004xr-HP; Tue, 19 Aug 2025 14:23:10 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoQzB-0003nY-UP; Tue, 19 Aug 2025 14:23:10 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2445826fd9dso66414615ad.3; 
 Tue, 19 Aug 2025 11:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627784; x=1756232584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y2PNWscI+Gm3l+OVtOuKl3eCyc13I8ViniKQQPhf/dE=;
 b=dkTTj53T4SoX2hDvYspF+8U4v1GUIIk33ohFtM8xW7N5h7TyOC9arbDDus740hK2sG
 quvzR07aQndLVZbHBzsrlH3GLCkCIan51/J3VzqLMMib6dlTn4hXoDbCVPwq6ov88Hg8
 MYzUNcdkbKvwikKWnh7/0GlRrZ6VCd+QkTgfEWEUNIz8LZSMEkzurDsvVvEMsCBb1YFD
 NvOCtNi7MF0GJvHHzrCJnYFlUbS1QWwr6No2fUr0ukD9lSHPZdY6VOXGJosrKmQKSX8m
 JROD2XOhOL/u67/ylpAh0LWXCxfCHNyYYS0JIYSd15gm4xtVdTzGznmPwzuP1+8pAT56
 53QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627784; x=1756232584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y2PNWscI+Gm3l+OVtOuKl3eCyc13I8ViniKQQPhf/dE=;
 b=m6iOe8skMC5PquaplqLBbfnHk9+ttOFmRdlH95UpmRc1awUPKGivq17IYSKSKrOj8z
 rYb+/e7bxUei5PSq1mt+Kw0oQtf5q/bNJ1UawDtYSyEnqKlhYmOFnzUNZE/Hy++14eYR
 qC7WhNNXhSryQfteeW3W2EspXopDVh7CkWtY33M1alxpGPLgO0G8cFGF4VBF+Qma6ved
 ioC5kOoELAbxbHK9+elfdEShgx7aSmzidrx14DOMGfrcWSorQyvKXm85q4VtWUe72FZc
 aGCPWcflCGIMa+zCc1LFQu88cNd+uBEPhjYWlowIOeoiBPxu+I0K7BRqUI9ELhSV1hkx
 knOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4+cgYb2KnaAVrqyawBwc5EQvitLiNEwc+uk8lWu0PSaz83vYclo9HIBM7Y0293BH2Ei7gvyN7gA==@nongnu.org,
 AJvYcCV6zWqR98GP4B6eftgfiqndbTfJnwPrSPB4/TrworNickHnJBwQbq/VSzGzwl7YG2ylJx4L2Co8GzHD1g==@nongnu.org
X-Gm-Message-State: AOJu0Ywd81ogfVCQZtoUiS7XpVmHYrJY1eDhOe5xj7SZUhGthhPrVDuW
 PvjHJc81F5eU8MemaEqFh0M8PI10XKBd6XTAm2nCwxGkHHSdBSD9Oow0ifnZIqkB
X-Gm-Gg: ASbGnctOL/gLW9AXgjUrL+tDJ4Yb1R4OTTj7ZccRMvFRUK8PEEjdhlZCeqzhGw01Wt5
 k3x0XWfKtuLNOuX7JtHfVzIu6pIPdFWFxT9ngwmyDUM/cAmHYWCxxqaeSoxHyXP+dggJARz9c3B
 fk2gObosOyiSIOrGK+Lbb25PGT4nTR793uQbhjch8lheGLGCzekbUgFzqWM+wAp6f6VfNjbIgDY
 idwZws58Tf+Y/+hWMDziDyJHWIbCioifI0cRGfU6DS9GJRV4Az+0uPnAv3LRQgEt6lCYZxbuIbk
 ShzUhCFifno8Fxbrz7n1Dw4+9CGsxtkTPYABsSlyDSRYTRGBpb4m8Bw6brfqqX9TGs1dgGj5tHo
 jKxmR5JbkLVNSlCe+bmewDg==
X-Google-Smtp-Source: AGHT+IETQlpGxL21Jn7/DVLT/wx15wcwcMxN1bVfpl1qxkYwyknp+TIOG75zMHKXybntmrASmVfWow==
X-Received: by 2002:a17:903:1108:b0:240:150e:57ba with SMTP id
 d9443c01a7336-245e02d7372mr40749305ad.3.1755627783108; 
 Tue, 19 Aug 2025 11:23:03 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:23:02 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH 05/35] tcg: Fork TCI for wasm backend
Date: Wed, 20 Aug 2025 03:21:34 +0900
Message-ID: <630c91852939acf3c7fdd95c37b363fa5d4e60fd.1755623521.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The Wasm backend is implemented based on the forked TCI backend with
utilizing the TCI interpreter to execute TBs.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 MAINTAINERS                    |    6 +
 tcg/wasm.c                     | 1076 ++++++++++++++++++++++++++
 tcg/wasm/tcg-target-con-set.h  |   21 +
 tcg/wasm/tcg-target-con-str.h  |   11 +
 tcg/wasm/tcg-target-has.h      |   22 +
 tcg/wasm/tcg-target-mo.h       |   17 +
 tcg/wasm/tcg-target-opc.h.inc  |   15 +
 tcg/wasm/tcg-target-reg-bits.h |   18 +
 tcg/wasm/tcg-target.c.inc      | 1320 ++++++++++++++++++++++++++++++++
 tcg/wasm/tcg-target.h          |   77 ++
 10 files changed, 2583 insertions(+)
 create mode 100644 tcg/wasm.c
 create mode 100644 tcg/wasm/tcg-target-con-set.h
 create mode 100644 tcg/wasm/tcg-target-con-str.h
 create mode 100644 tcg/wasm/tcg-target-has.h
 create mode 100644 tcg/wasm/tcg-target-mo.h
 create mode 100644 tcg/wasm/tcg-target-opc.h.inc
 create mode 100644 tcg/wasm/tcg-target-reg-bits.h
 create mode 100644 tcg/wasm/tcg-target.c.inc
 create mode 100644 tcg/wasm/tcg-target.h

V1:
- Although checkpatch.pl reports the following error in tcg/wasm.c,
  tcg/wasm/tcg-target.c.inc and tcg/wasm/tcg-target.h, these files were
  copied from TCI codes so they are preserved as-is.
  > New file 'tcg/wasm.c' must not have license boilerplate header
  > text, only the SPDX-License-Identifier, unless this file was copied from
  > existing code already having such text.

diff --git a/MAINTAINERS b/MAINTAINERS
index 433a44118d..217bf2066c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3999,6 +3999,12 @@ F: tcg/tci/
 F: tcg/tci.c
 F: disas/tci.c
 
+WebAssembly TCG target
+M: Kohei Tokunaga <ktokunaga.mail@gmail.com>
+S: Maintained
+F: tcg/wasm/
+F: tcg/wasm.c
+
 Block drivers
 -------------
 VMDK
diff --git a/tcg/wasm.c b/tcg/wasm.c
new file mode 100644
index 0000000000..6de9b26b76
--- /dev/null
+++ b/tcg/wasm.c
@@ -0,0 +1,1076 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * WebAssembly backend with forked TCI, based on tci.c
+ *
+ * Copyright (c) 2009, 2011, 2016 Stefan Weil
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "tcg/tcg.h"
+#include "tcg/helper-info.h"
+#include "tcg/tcg-ldst.h"
+#include "disas/dis-asm.h"
+#include "tcg-has.h"
+#include <ffi.h>
+
+
+#define ctpop_tr    glue(ctpop, TCG_TARGET_REG_BITS)
+#define deposit_tr  glue(deposit, TCG_TARGET_REG_BITS)
+#define extract_tr  glue(extract, TCG_TARGET_REG_BITS)
+#define sextract_tr glue(sextract, TCG_TARGET_REG_BITS)
+
+/*
+ * Enable TCI assertions only when debugging TCG (and without NDEBUG defined).
+ * Without assertions, the interpreter runs much faster.
+ */
+#if defined(CONFIG_DEBUG_TCG)
+# define tci_assert(cond) assert(cond)
+#else
+# define tci_assert(cond) ((void)(cond))
+#endif
+
+__thread uintptr_t tci_tb_ptr;
+
+static void tci_write_reg64(tcg_target_ulong *regs, uint32_t high_index,
+                            uint32_t low_index, uint64_t value)
+{
+    regs[low_index] = (uint32_t)value;
+    regs[high_index] = value >> 32;
+}
+
+/* Create a 64 bit value from two 32 bit values. */
+static uint64_t tci_uint64(uint32_t high, uint32_t low)
+{
+    return ((uint64_t)high << 32) + low;
+}
+
+/*
+ * Load sets of arguments all at once.  The naming convention is:
+ *   tci_args_<arguments>
+ * where arguments is a sequence of
+ *
+ *   b = immediate (bit position)
+ *   c = condition (TCGCond)
+ *   i = immediate (uint32_t)
+ *   I = immediate (tcg_target_ulong)
+ *   l = label or pointer
+ *   m = immediate (MemOpIdx)
+ *   n = immediate (call return length)
+ *   r = register
+ *   s = signed ldst offset
+ */
+
+static void tci_args_l(uint32_t insn, const void *tb_ptr, void **l0)
+{
+    int diff = sextract32(insn, 12, 20);
+    *l0 = diff ? (void *)tb_ptr + diff : NULL;
+}
+
+static void tci_args_r(uint32_t insn, TCGReg *r0)
+{
+    *r0 = extract32(insn, 8, 4);
+}
+
+static void tci_args_nl(uint32_t insn, const void *tb_ptr,
+                        uint8_t *n0, void **l1)
+{
+    *n0 = extract32(insn, 8, 4);
+    *l1 = sextract32(insn, 12, 20) + (void *)tb_ptr;
+}
+
+static void tci_args_rl(uint32_t insn, const void *tb_ptr,
+                        TCGReg *r0, void **l1)
+{
+    *r0 = extract32(insn, 8, 4);
+    *l1 = sextract32(insn, 12, 20) + (void *)tb_ptr;
+}
+
+static void tci_args_rr(uint32_t insn, TCGReg *r0, TCGReg *r1)
+{
+    *r0 = extract32(insn, 8, 4);
+    *r1 = extract32(insn, 12, 4);
+}
+
+static void tci_args_ri(uint32_t insn, TCGReg *r0, tcg_target_ulong *i1)
+{
+    *r0 = extract32(insn, 8, 4);
+    *i1 = sextract32(insn, 12, 20);
+}
+
+static void tci_args_rrm(uint32_t insn, TCGReg *r0,
+                         TCGReg *r1, MemOpIdx *m2)
+{
+    *r0 = extract32(insn, 8, 4);
+    *r1 = extract32(insn, 12, 4);
+    *m2 = extract32(insn, 16, 16);
+}
+
+static void tci_args_rrr(uint32_t insn, TCGReg *r0, TCGReg *r1, TCGReg *r2)
+{
+    *r0 = extract32(insn, 8, 4);
+    *r1 = extract32(insn, 12, 4);
+    *r2 = extract32(insn, 16, 4);
+}
+
+static void tci_args_rrs(uint32_t insn, TCGReg *r0, TCGReg *r1, int32_t *i2)
+{
+    *r0 = extract32(insn, 8, 4);
+    *r1 = extract32(insn, 12, 4);
+    *i2 = sextract32(insn, 16, 16);
+}
+
+static void tci_args_rrbb(uint32_t insn, TCGReg *r0, TCGReg *r1,
+                          uint8_t *i2, uint8_t *i3)
+{
+    *r0 = extract32(insn, 8, 4);
+    *r1 = extract32(insn, 12, 4);
+    *i2 = extract32(insn, 16, 6);
+    *i3 = extract32(insn, 22, 6);
+}
+
+static void tci_args_rrrc(uint32_t insn,
+                          TCGReg *r0, TCGReg *r1, TCGReg *r2, TCGCond *c3)
+{
+    *r0 = extract32(insn, 8, 4);
+    *r1 = extract32(insn, 12, 4);
+    *r2 = extract32(insn, 16, 4);
+    *c3 = extract32(insn, 20, 4);
+}
+
+static void tci_args_rrrbb(uint32_t insn, TCGReg *r0, TCGReg *r1,
+                           TCGReg *r2, uint8_t *i3, uint8_t *i4)
+{
+    *r0 = extract32(insn, 8, 4);
+    *r1 = extract32(insn, 12, 4);
+    *r2 = extract32(insn, 16, 4);
+    *i3 = extract32(insn, 20, 6);
+    *i4 = extract32(insn, 26, 6);
+}
+
+static void tci_args_rrrr(uint32_t insn,
+                          TCGReg *r0, TCGReg *r1, TCGReg *r2, TCGReg *r3)
+{
+    *r0 = extract32(insn, 8, 4);
+    *r1 = extract32(insn, 12, 4);
+    *r2 = extract32(insn, 16, 4);
+    *r3 = extract32(insn, 20, 4);
+}
+
+static void tci_args_rrrrrc(uint32_t insn, TCGReg *r0, TCGReg *r1,
+                            TCGReg *r2, TCGReg *r3, TCGReg *r4, TCGCond *c5)
+{
+    *r0 = extract32(insn, 8, 4);
+    *r1 = extract32(insn, 12, 4);
+    *r2 = extract32(insn, 16, 4);
+    *r3 = extract32(insn, 20, 4);
+    *r4 = extract32(insn, 24, 4);
+    *c5 = extract32(insn, 28, 4);
+}
+
+static bool tci_compare32(uint32_t u0, uint32_t u1, TCGCond condition)
+{
+    bool result = false;
+    int32_t i0 = u0;
+    int32_t i1 = u1;
+    switch (condition) {
+    case TCG_COND_EQ:
+        result = (u0 == u1);
+        break;
+    case TCG_COND_NE:
+        result = (u0 != u1);
+        break;
+    case TCG_COND_LT:
+        result = (i0 < i1);
+        break;
+    case TCG_COND_GE:
+        result = (i0 >= i1);
+        break;
+    case TCG_COND_LE:
+        result = (i0 <= i1);
+        break;
+    case TCG_COND_GT:
+        result = (i0 > i1);
+        break;
+    case TCG_COND_LTU:
+        result = (u0 < u1);
+        break;
+    case TCG_COND_GEU:
+        result = (u0 >= u1);
+        break;
+    case TCG_COND_LEU:
+        result = (u0 <= u1);
+        break;
+    case TCG_COND_GTU:
+        result = (u0 > u1);
+        break;
+    case TCG_COND_TSTEQ:
+        result = (u0 & u1) == 0;
+        break;
+    case TCG_COND_TSTNE:
+        result = (u0 & u1) != 0;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return result;
+}
+
+static bool tci_compare64(uint64_t u0, uint64_t u1, TCGCond condition)
+{
+    bool result = false;
+    int64_t i0 = u0;
+    int64_t i1 = u1;
+    switch (condition) {
+    case TCG_COND_EQ:
+        result = (u0 == u1);
+        break;
+    case TCG_COND_NE:
+        result = (u0 != u1);
+        break;
+    case TCG_COND_LT:
+        result = (i0 < i1);
+        break;
+    case TCG_COND_GE:
+        result = (i0 >= i1);
+        break;
+    case TCG_COND_LE:
+        result = (i0 <= i1);
+        break;
+    case TCG_COND_GT:
+        result = (i0 > i1);
+        break;
+    case TCG_COND_LTU:
+        result = (u0 < u1);
+        break;
+    case TCG_COND_GEU:
+        result = (u0 >= u1);
+        break;
+    case TCG_COND_LEU:
+        result = (u0 <= u1);
+        break;
+    case TCG_COND_GTU:
+        result = (u0 > u1);
+        break;
+    case TCG_COND_TSTEQ:
+        result = (u0 & u1) == 0;
+        break;
+    case TCG_COND_TSTNE:
+        result = (u0 & u1) != 0;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return result;
+}
+
+static uint64_t tci_qemu_ld(CPUArchState *env, uint64_t taddr,
+                            MemOpIdx oi, const void *tb_ptr)
+{
+    MemOp mop = get_memop(oi);
+    uintptr_t ra = (uintptr_t)tb_ptr;
+
+    switch (mop & MO_SSIZE) {
+    case MO_UB:
+        return helper_ldub_mmu(env, taddr, oi, ra);
+    case MO_SB:
+        return helper_ldsb_mmu(env, taddr, oi, ra);
+    case MO_UW:
+        return helper_lduw_mmu(env, taddr, oi, ra);
+    case MO_SW:
+        return helper_ldsw_mmu(env, taddr, oi, ra);
+    case MO_UL:
+        return helper_ldul_mmu(env, taddr, oi, ra);
+    case MO_SL:
+        return helper_ldsl_mmu(env, taddr, oi, ra);
+    case MO_UQ:
+        return helper_ldq_mmu(env, taddr, oi, ra);
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tci_qemu_st(CPUArchState *env, uint64_t taddr, uint64_t val,
+                        MemOpIdx oi, const void *tb_ptr)
+{
+    MemOp mop = get_memop(oi);
+    uintptr_t ra = (uintptr_t)tb_ptr;
+
+    switch (mop & MO_SIZE) {
+    case MO_UB:
+        helper_stb_mmu(env, taddr, val, oi, ra);
+        break;
+    case MO_UW:
+        helper_stw_mmu(env, taddr, val, oi, ra);
+        break;
+    case MO_UL:
+        helper_stl_mmu(env, taddr, val, oi, ra);
+        break;
+    case MO_UQ:
+        helper_stq_mmu(env, taddr, val, oi, ra);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+/* Interpret pseudo code in tb. */
+/*
+ * Disable CFI checks.
+ * One possible operation in the pseudo code is a call to binary code.
+ * Therefore, disable CFI checks in the interpreter function
+ */
+uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
+                                            const void *v_tb_ptr)
+{
+    const uint32_t *tb_ptr = v_tb_ptr;
+    tcg_target_ulong regs[TCG_TARGET_NB_REGS];
+    uint64_t stack[(TCG_STATIC_CALL_ARGS_SIZE + TCG_STATIC_FRAME_SIZE)
+                   / sizeof(uint64_t)];
+    bool carry = false;
+
+    regs[TCG_AREG0] = (tcg_target_ulong)env;
+    regs[TCG_REG_CALL_STACK] = (uintptr_t)stack;
+    tci_assert(tb_ptr);
+
+    for (;;) {
+        uint32_t insn;
+        TCGOpcode opc;
+        TCGReg r0, r1, r2, r3, r4;
+        tcg_target_ulong t1;
+        TCGCond condition;
+        uint8_t pos, len;
+        uint32_t tmp32;
+        uint64_t tmp64, taddr;
+        MemOpIdx oi;
+        int32_t ofs;
+        void *ptr;
+
+        insn = *tb_ptr++;
+        opc = extract32(insn, 0, 8);
+
+        switch (opc) {
+        case INDEX_op_call:
+            {
+                void *call_slots[MAX_CALL_IARGS];
+                ffi_cif *cif;
+                void *func;
+                unsigned i, s, n;
+
+                tci_args_nl(insn, tb_ptr, &len, &ptr);
+                func = ((void **)ptr)[0];
+                cif = ((void **)ptr)[1];
+
+                n = cif->nargs;
+                for (i = s = 0; i < n; ++i) {
+                    ffi_type *t = cif->arg_types[i];
+                    call_slots[i] = &stack[s];
+                    s += DIV_ROUND_UP(t->size, 8);
+                }
+
+                /* Helper functions may need to access the "return address" */
+                tci_tb_ptr = (uintptr_t)tb_ptr;
+                ffi_call(cif, func, stack, call_slots);
+            }
+
+            switch (len) {
+            case 0: /* void */
+                break;
+            case 1: /* uint32_t */
+                /*
+                 * The result winds up "left-aligned" in the stack[0] slot.
+                 * Note that libffi has an odd special case in that it will
+                 * always widen an integral result to ffi_arg.
+                 */
+                if (sizeof(ffi_arg) == 8) {
+                    regs[TCG_REG_R0] = (uint32_t)stack[0];
+                } else {
+                    regs[TCG_REG_R0] = *(uint32_t *)stack;
+                }
+                break;
+            case 2: /* uint64_t */
+                /*
+                 * For TCG_TARGET_REG_BITS == 32, the register pair
+                 * must stay in host memory order.
+                 */
+                memcpy(&regs[TCG_REG_R0], stack, 8);
+                break;
+            case 3: /* Int128 */
+                memcpy(&regs[TCG_REG_R0], stack, 16);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+            break;
+
+        case INDEX_op_br:
+            tci_args_l(insn, tb_ptr, &ptr);
+            tb_ptr = ptr;
+            continue;
+#if TCG_TARGET_REG_BITS == 32
+        case INDEX_op_setcond2_i32:
+            tci_args_rrrrrc(insn, &r0, &r1, &r2, &r3, &r4, &condition);
+            regs[r0] = tci_compare64(tci_uint64(regs[r2], regs[r1]),
+                                     tci_uint64(regs[r4], regs[r3]),
+                                     condition);
+            break;
+#elif TCG_TARGET_REG_BITS == 64
+        case INDEX_op_setcond:
+            tci_args_rrrc(insn, &r0, &r1, &r2, &condition);
+            regs[r0] = tci_compare64(regs[r1], regs[r2], condition);
+            break;
+        case INDEX_op_movcond:
+            tci_args_rrrrrc(insn, &r0, &r1, &r2, &r3, &r4, &condition);
+            tmp32 = tci_compare64(regs[r1], regs[r2], condition);
+            regs[r0] = regs[tmp32 ? r3 : r4];
+            break;
+#endif
+        case INDEX_op_mov:
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = regs[r1];
+            break;
+        case INDEX_op_tci_movi:
+            tci_args_ri(insn, &r0, &t1);
+            regs[r0] = t1;
+            break;
+        case INDEX_op_tci_movl:
+            tci_args_rl(insn, tb_ptr, &r0, &ptr);
+            regs[r0] = *(tcg_target_ulong *)ptr;
+            break;
+        case INDEX_op_tci_setcarry:
+            carry = true;
+            break;
+
+            /* Load/store operations (32 bit). */
+
+        case INDEX_op_ld8u:
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            regs[r0] = *(uint8_t *)ptr;
+            break;
+        case INDEX_op_ld8s:
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            regs[r0] = *(int8_t *)ptr;
+            break;
+        case INDEX_op_ld16u:
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            regs[r0] = *(uint16_t *)ptr;
+            break;
+        case INDEX_op_ld16s:
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            regs[r0] = *(int16_t *)ptr;
+            break;
+        case INDEX_op_ld:
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            regs[r0] = *(tcg_target_ulong *)ptr;
+            break;
+        case INDEX_op_st8:
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            *(uint8_t *)ptr = regs[r0];
+            break;
+        case INDEX_op_st16:
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            *(uint16_t *)ptr = regs[r0];
+            break;
+        case INDEX_op_st:
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            *(tcg_target_ulong *)ptr = regs[r0];
+            break;
+
+            /* Arithmetic operations (mixed 32/64 bit). */
+
+        case INDEX_op_add:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] + regs[r2];
+            break;
+        case INDEX_op_sub:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] - regs[r2];
+            break;
+        case INDEX_op_mul:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] * regs[r2];
+            break;
+        case INDEX_op_and:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] & regs[r2];
+            break;
+        case INDEX_op_or:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] | regs[r2];
+            break;
+        case INDEX_op_xor:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] ^ regs[r2];
+            break;
+        case INDEX_op_andc:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] & ~regs[r2];
+            break;
+        case INDEX_op_orc:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] | ~regs[r2];
+            break;
+        case INDEX_op_eqv:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = ~(regs[r1] ^ regs[r2]);
+            break;
+        case INDEX_op_nand:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = ~(regs[r1] & regs[r2]);
+            break;
+        case INDEX_op_nor:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = ~(regs[r1] | regs[r2]);
+            break;
+        case INDEX_op_neg:
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = -regs[r1];
+            break;
+        case INDEX_op_not:
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = ~regs[r1];
+            break;
+        case INDEX_op_ctpop:
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = ctpop_tr(regs[r1]);
+            break;
+        case INDEX_op_addco:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            t1 = regs[r1] + regs[r2];
+            carry = t1 < regs[r1];
+            regs[r0] = t1;
+            break;
+        case INDEX_op_addci:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] + regs[r2] + carry;
+            break;
+        case INDEX_op_addcio:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            if (carry) {
+                t1 = regs[r1] + regs[r2] + 1;
+                carry = t1 <= regs[r1];
+            } else {
+                t1 = regs[r1] + regs[r2];
+                carry = t1 < regs[r1];
+            }
+            regs[r0] = t1;
+            break;
+        case INDEX_op_subbo:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            carry = regs[r1] < regs[r2];
+            regs[r0] = regs[r1] - regs[r2];
+            break;
+        case INDEX_op_subbi:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] - regs[r2] - carry;
+            break;
+        case INDEX_op_subbio:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            if (carry) {
+                carry = regs[r1] <= regs[r2];
+                regs[r0] = regs[r1] - regs[r2] - 1;
+            } else {
+                carry = regs[r1] < regs[r2];
+                regs[r0] = regs[r1] - regs[r2];
+            }
+            break;
+        case INDEX_op_muls2:
+            tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
+#if TCG_TARGET_REG_BITS == 32
+            tmp64 = (int64_t)(int32_t)regs[r2] * (int32_t)regs[r3];
+            tci_write_reg64(regs, r1, r0, tmp64);
+#else
+            muls64(&regs[r0], &regs[r1], regs[r2], regs[r3]);
+#endif
+            break;
+        case INDEX_op_mulu2:
+            tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
+#if TCG_TARGET_REG_BITS == 32
+            tmp64 = (uint64_t)(uint32_t)regs[r2] * (uint32_t)regs[r3];
+            tci_write_reg64(regs, r1, r0, tmp64);
+#else
+            mulu64(&regs[r0], &regs[r1], regs[r2], regs[r3]);
+#endif
+            break;
+
+            /* Arithmetic operations (32 bit). */
+
+        case INDEX_op_tci_divs32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (int32_t)regs[r1] / (int32_t)regs[r2];
+            break;
+        case INDEX_op_tci_divu32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (uint32_t)regs[r1] / (uint32_t)regs[r2];
+            break;
+        case INDEX_op_tci_rems32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (int32_t)regs[r1] % (int32_t)regs[r2];
+            break;
+        case INDEX_op_tci_remu32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (uint32_t)regs[r1] % (uint32_t)regs[r2];
+            break;
+        case INDEX_op_tci_clz32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            tmp32 = regs[r1];
+            regs[r0] = tmp32 ? clz32(tmp32) : regs[r2];
+            break;
+        case INDEX_op_tci_ctz32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            tmp32 = regs[r1];
+            regs[r0] = tmp32 ? ctz32(tmp32) : regs[r2];
+            break;
+        case INDEX_op_tci_setcond32:
+            tci_args_rrrc(insn, &r0, &r1, &r2, &condition);
+            regs[r0] = tci_compare32(regs[r1], regs[r2], condition);
+            break;
+        case INDEX_op_tci_movcond32:
+            tci_args_rrrrrc(insn, &r0, &r1, &r2, &r3, &r4, &condition);
+            tmp32 = tci_compare32(regs[r1], regs[r2], condition);
+            regs[r0] = regs[tmp32 ? r3 : r4];
+            break;
+
+            /* Shift/rotate operations. */
+
+        case INDEX_op_shl:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] << (regs[r2] % TCG_TARGET_REG_BITS);
+            break;
+        case INDEX_op_shr:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] >> (regs[r2] % TCG_TARGET_REG_BITS);
+            break;
+        case INDEX_op_sar:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = ((tcg_target_long)regs[r1]
+                        >> (regs[r2] % TCG_TARGET_REG_BITS));
+            break;
+        case INDEX_op_tci_rotl32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = rol32(regs[r1], regs[r2] & 31);
+            break;
+        case INDEX_op_tci_rotr32:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = ror32(regs[r1], regs[r2] & 31);
+            break;
+        case INDEX_op_deposit:
+            tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
+            regs[r0] = deposit_tr(regs[r1], pos, len, regs[r2]);
+            break;
+        case INDEX_op_extract:
+            tci_args_rrbb(insn, &r0, &r1, &pos, &len);
+            regs[r0] = extract_tr(regs[r1], pos, len);
+            break;
+        case INDEX_op_sextract:
+            tci_args_rrbb(insn, &r0, &r1, &pos, &len);
+            regs[r0] = sextract_tr(regs[r1], pos, len);
+            break;
+        case INDEX_op_brcond:
+            tci_args_rl(insn, tb_ptr, &r0, &ptr);
+            if (regs[r0]) {
+                tb_ptr = ptr;
+            }
+            break;
+        case INDEX_op_bswap16:
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = bswap16(regs[r1]);
+            break;
+        case INDEX_op_bswap32:
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = bswap32(regs[r1]);
+            break;
+#if TCG_TARGET_REG_BITS == 64
+            /* Load/store operations (64 bit). */
+
+        case INDEX_op_ld32u:
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            regs[r0] = *(uint32_t *)ptr;
+            break;
+        case INDEX_op_ld32s:
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            regs[r0] = *(int32_t *)ptr;
+            break;
+        case INDEX_op_st32:
+            tci_args_rrs(insn, &r0, &r1, &ofs);
+            ptr = (void *)(regs[r1] + ofs);
+            *(uint32_t *)ptr = regs[r0];
+            break;
+
+            /* Arithmetic operations (64 bit). */
+
+        case INDEX_op_divs:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (int64_t)regs[r1] / (int64_t)regs[r2];
+            break;
+        case INDEX_op_divu:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (uint64_t)regs[r1] / (uint64_t)regs[r2];
+            break;
+        case INDEX_op_rems:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (int64_t)regs[r1] % (int64_t)regs[r2];
+            break;
+        case INDEX_op_remu:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = (uint64_t)regs[r1] % (uint64_t)regs[r2];
+            break;
+        case INDEX_op_clz:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] ? clz64(regs[r1]) : regs[r2];
+            break;
+        case INDEX_op_ctz:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = regs[r1] ? ctz64(regs[r1]) : regs[r2];
+            break;
+
+            /* Shift/rotate operations (64 bit). */
+
+        case INDEX_op_rotl:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = rol64(regs[r1], regs[r2] & 63);
+            break;
+        case INDEX_op_rotr:
+            tci_args_rrr(insn, &r0, &r1, &r2);
+            regs[r0] = ror64(regs[r1], regs[r2] & 63);
+            break;
+        case INDEX_op_ext_i32_i64:
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = (int32_t)regs[r1];
+            break;
+        case INDEX_op_extu_i32_i64:
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = (uint32_t)regs[r1];
+            break;
+        case INDEX_op_bswap64:
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = bswap64(regs[r1]);
+            break;
+#endif /* TCG_TARGET_REG_BITS == 64 */
+
+            /* QEMU specific operations. */
+
+        case INDEX_op_exit_tb:
+            tci_args_l(insn, tb_ptr, &ptr);
+            return (uintptr_t)ptr;
+
+        case INDEX_op_goto_tb:
+            tci_args_l(insn, tb_ptr, &ptr);
+            tb_ptr = *(void **)ptr;
+            break;
+
+        case INDEX_op_goto_ptr:
+            tci_args_r(insn, &r0);
+            ptr = (void *)regs[r0];
+            if (!ptr) {
+                return 0;
+            }
+            tb_ptr = ptr;
+            break;
+
+        case INDEX_op_qemu_ld:
+            tci_args_rrm(insn, &r0, &r1, &oi);
+            taddr = regs[r1];
+            regs[r0] = tci_qemu_ld(env, taddr, oi, tb_ptr);
+            break;
+
+        case INDEX_op_qemu_st:
+            tci_args_rrm(insn, &r0, &r1, &oi);
+            taddr = regs[r1];
+            tci_qemu_st(env, taddr, regs[r0], oi, tb_ptr);
+            break;
+
+        case INDEX_op_qemu_ld2:
+            tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
+            tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
+            taddr = regs[r2];
+            oi = regs[r3];
+            tmp64 = tci_qemu_ld(env, taddr, oi, tb_ptr);
+            tci_write_reg64(regs, r1, r0, tmp64);
+            break;
+
+        case INDEX_op_qemu_st2:
+            tcg_debug_assert(TCG_TARGET_REG_BITS == 32);
+            tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
+            tmp64 = tci_uint64(regs[r1], regs[r0]);
+            taddr = regs[r2];
+            oi = regs[r3];
+            tci_qemu_st(env, taddr, tmp64, oi, tb_ptr);
+            break;
+
+        case INDEX_op_mb:
+            /* Ensure ordering for all kinds */
+            smp_mb();
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+}
+
+/*
+ * Disassembler that matches the interpreter
+ */
+
+static const char *str_r(TCGReg r)
+{
+    static const char regs[TCG_TARGET_NB_REGS][4] = {
+        "r0", "r1", "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
+        "r8", "r9", "r10", "r11", "r12", "r13", "env", "sp"
+    };
+
+    QEMU_BUILD_BUG_ON(TCG_AREG0 != TCG_REG_R14);
+    QEMU_BUILD_BUG_ON(TCG_REG_CALL_STACK != TCG_REG_R15);
+
+    assert((unsigned)r < TCG_TARGET_NB_REGS);
+    return regs[r];
+}
+
+static const char *str_c(TCGCond c)
+{
+    static const char cond[16][8] = {
+        [TCG_COND_NEVER] = "never",
+        [TCG_COND_ALWAYS] = "always",
+        [TCG_COND_EQ] = "eq",
+        [TCG_COND_NE] = "ne",
+        [TCG_COND_LT] = "lt",
+        [TCG_COND_GE] = "ge",
+        [TCG_COND_LE] = "le",
+        [TCG_COND_GT] = "gt",
+        [TCG_COND_LTU] = "ltu",
+        [TCG_COND_GEU] = "geu",
+        [TCG_COND_LEU] = "leu",
+        [TCG_COND_GTU] = "gtu",
+        [TCG_COND_TSTEQ] = "tsteq",
+        [TCG_COND_TSTNE] = "tstne",
+    };
+
+    assert((unsigned)c < ARRAY_SIZE(cond));
+    assert(cond[c][0] != 0);
+    return cond[c];
+}
+
+/* Disassemble TCI bytecode. */
+int print_insn_tci(bfd_vma addr, disassemble_info *info)
+{
+    const uint32_t *tb_ptr = (const void *)(uintptr_t)addr;
+    const TCGOpDef *def;
+    const char *op_name;
+    uint32_t insn;
+    TCGOpcode op;
+    TCGReg r0, r1, r2, r3, r4;
+    tcg_target_ulong i1;
+    int32_t s2;
+    TCGCond c;
+    MemOpIdx oi;
+    uint8_t pos, len;
+    void *ptr;
+
+    /* TCI is always the host, so we don't need to load indirect. */
+    insn = *tb_ptr++;
+
+    info->fprintf_func(info->stream, "%08x  ", insn);
+
+    op = extract32(insn, 0, 8);
+    def = &tcg_op_defs[op];
+    op_name = def->name;
+
+    switch (op) {
+    case INDEX_op_br:
+    case INDEX_op_exit_tb:
+    case INDEX_op_goto_tb:
+        tci_args_l(insn, tb_ptr, &ptr);
+        info->fprintf_func(info->stream, "%-12s  %p", op_name, ptr);
+        break;
+
+    case INDEX_op_goto_ptr:
+        tci_args_r(insn, &r0);
+        info->fprintf_func(info->stream, "%-12s  %s", op_name, str_r(r0));
+        break;
+
+    case INDEX_op_call:
+        tci_args_nl(insn, tb_ptr, &len, &ptr);
+        info->fprintf_func(info->stream, "%-12s  %d, %p", op_name, len, ptr);
+        break;
+
+    case INDEX_op_brcond:
+        tci_args_rl(insn, tb_ptr, &r0, &ptr);
+        info->fprintf_func(info->stream, "%-12s  %s, 0, ne, %p",
+                           op_name, str_r(r0), ptr);
+        break;
+
+    case INDEX_op_setcond:
+    case INDEX_op_tci_setcond32:
+        tci_args_rrrc(insn, &r0, &r1, &r2, &c);
+        info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %s",
+                           op_name, str_r(r0), str_r(r1), str_r(r2), str_c(c));
+        break;
+
+    case INDEX_op_tci_movi:
+        tci_args_ri(insn, &r0, &i1);
+        info->fprintf_func(info->stream, "%-12s  %s, 0x%" TCG_PRIlx,
+                           op_name, str_r(r0), i1);
+        break;
+
+    case INDEX_op_tci_movl:
+        tci_args_rl(insn, tb_ptr, &r0, &ptr);
+        info->fprintf_func(info->stream, "%-12s  %s, %p",
+                           op_name, str_r(r0), ptr);
+        break;
+
+    case INDEX_op_tci_setcarry:
+        info->fprintf_func(info->stream, "%-12s", op_name);
+        break;
+
+    case INDEX_op_ld8u:
+    case INDEX_op_ld8s:
+    case INDEX_op_ld16u:
+    case INDEX_op_ld16s:
+    case INDEX_op_ld32u:
+    case INDEX_op_ld:
+    case INDEX_op_st8:
+    case INDEX_op_st16:
+    case INDEX_op_st32:
+    case INDEX_op_st:
+        tci_args_rrs(insn, &r0, &r1, &s2);
+        info->fprintf_func(info->stream, "%-12s  %s, %s, %d",
+                           op_name, str_r(r0), str_r(r1), s2);
+        break;
+
+    case INDEX_op_bswap16:
+    case INDEX_op_bswap32:
+    case INDEX_op_ctpop:
+    case INDEX_op_mov:
+    case INDEX_op_neg:
+    case INDEX_op_not:
+    case INDEX_op_ext_i32_i64:
+    case INDEX_op_extu_i32_i64:
+    case INDEX_op_bswap64:
+        tci_args_rr(insn, &r0, &r1);
+        info->fprintf_func(info->stream, "%-12s  %s, %s",
+                           op_name, str_r(r0), str_r(r1));
+        break;
+
+    case INDEX_op_add:
+    case INDEX_op_addci:
+    case INDEX_op_addcio:
+    case INDEX_op_addco:
+    case INDEX_op_and:
+    case INDEX_op_andc:
+    case INDEX_op_clz:
+    case INDEX_op_ctz:
+    case INDEX_op_divs:
+    case INDEX_op_divu:
+    case INDEX_op_eqv:
+    case INDEX_op_mul:
+    case INDEX_op_nand:
+    case INDEX_op_nor:
+    case INDEX_op_or:
+    case INDEX_op_orc:
+    case INDEX_op_rems:
+    case INDEX_op_remu:
+    case INDEX_op_rotl:
+    case INDEX_op_rotr:
+    case INDEX_op_sar:
+    case INDEX_op_shl:
+    case INDEX_op_shr:
+    case INDEX_op_sub:
+    case INDEX_op_subbi:
+    case INDEX_op_subbio:
+    case INDEX_op_subbo:
+    case INDEX_op_xor:
+    case INDEX_op_tci_ctz32:
+    case INDEX_op_tci_clz32:
+    case INDEX_op_tci_divs32:
+    case INDEX_op_tci_divu32:
+    case INDEX_op_tci_rems32:
+    case INDEX_op_tci_remu32:
+    case INDEX_op_tci_rotl32:
+    case INDEX_op_tci_rotr32:
+        tci_args_rrr(insn, &r0, &r1, &r2);
+        info->fprintf_func(info->stream, "%-12s  %s, %s, %s",
+                           op_name, str_r(r0), str_r(r1), str_r(r2));
+        break;
+
+    case INDEX_op_deposit:
+        tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
+        info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %d, %d",
+                           op_name, str_r(r0), str_r(r1), str_r(r2), pos, len);
+        break;
+
+    case INDEX_op_extract:
+    case INDEX_op_sextract:
+        tci_args_rrbb(insn, &r0, &r1, &pos, &len);
+        info->fprintf_func(info->stream, "%-12s  %s,%s,%d,%d",
+                           op_name, str_r(r0), str_r(r1), pos, len);
+        break;
+
+    case INDEX_op_tci_movcond32:
+    case INDEX_op_movcond:
+    case INDEX_op_setcond2_i32:
+        tci_args_rrrrrc(insn, &r0, &r1, &r2, &r3, &r4, &c);
+        info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %s, %s, %s",
+                           op_name, str_r(r0), str_r(r1), str_r(r2),
+                           str_r(r3), str_r(r4), str_c(c));
+        break;
+
+    case INDEX_op_muls2:
+    case INDEX_op_mulu2:
+        tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
+        info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %s",
+                           op_name, str_r(r0), str_r(r1),
+                           str_r(r2), str_r(r3));
+        break;
+
+    case INDEX_op_qemu_ld:
+    case INDEX_op_qemu_st:
+        tci_args_rrm(insn, &r0, &r1, &oi);
+        info->fprintf_func(info->stream, "%-12s  %s, %s, %x",
+                           op_name, str_r(r0), str_r(r1), oi);
+        break;
+
+    case INDEX_op_qemu_ld2:
+    case INDEX_op_qemu_st2:
+        tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
+        info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %s",
+                           op_name, str_r(r0), str_r(r1),
+                           str_r(r2), str_r(r3));
+        break;
+
+    case 0:
+        /* tcg_out_nop_fill uses zeros */
+        if (insn == 0) {
+            info->fprintf_func(info->stream, "align");
+            break;
+        }
+        /* fall through */
+
+    default:
+        info->fprintf_func(info->stream, "illegal opcode %d", op);
+        break;
+    }
+
+    return sizeof(insn);
+}
diff --git a/tcg/wasm/tcg-target-con-set.h b/tcg/wasm/tcg-target-con-set.h
new file mode 100644
index 0000000000..ae2dc3b844
--- /dev/null
+++ b/tcg/wasm/tcg-target-con-set.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * TCI target-specific constraint sets.
+ * Copyright (c) 2021 Linaro
+ */
+
+/*
+ * C_On_Im(...) defines a constraint set with <n> outputs and <m> inputs.
+ * Each operand should be a sequence of constraint letters as defined by
+ * tcg-target-con-str.h; the constraint combination is inclusive or.
+ */
+C_O0_I1(r)
+C_O0_I2(r, r)
+C_O0_I3(r, r, r)
+C_O0_I4(r, r, r, r)
+C_O1_I1(r, r)
+C_O1_I2(r, r, r)
+C_O1_I4(r, r, r, r, r)
+C_O2_I1(r, r, r)
+C_O2_I2(r, r, r, r)
+C_O2_I4(r, r, r, r, r, r)
diff --git a/tcg/wasm/tcg-target-con-str.h b/tcg/wasm/tcg-target-con-str.h
new file mode 100644
index 0000000000..87c0f19e9c
--- /dev/null
+++ b/tcg/wasm/tcg-target-con-str.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define TCI target-specific operand constraints.
+ * Copyright (c) 2021 Linaro
+ */
+
+/*
+ * Define constraint letters for register sets:
+ * REGS(letter, register_mask)
+ */
+REGS('r', MAKE_64BIT_MASK(0, TCG_TARGET_NB_REGS))
diff --git a/tcg/wasm/tcg-target-has.h b/tcg/wasm/tcg-target-has.h
new file mode 100644
index 0000000000..ab07ce1fcb
--- /dev/null
+++ b/tcg/wasm/tcg-target-has.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific opcode support
+ * Copyright (c) 2009, 2011 Stefan Weil
+ */
+
+#ifndef TCG_TARGET_HAS_H
+#define TCG_TARGET_HAS_H
+
+#if TCG_TARGET_REG_BITS == 64
+#define TCG_TARGET_HAS_extr_i64_i32     0
+#endif /* TCG_TARGET_REG_BITS == 64 */
+
+#define TCG_TARGET_HAS_qemu_ldst_i128   0
+
+#define TCG_TARGET_HAS_tst              1
+
+#define TCG_TARGET_extract_valid(type, ofs, len)   1
+#define TCG_TARGET_sextract_valid(type, ofs, len)  1
+#define TCG_TARGET_deposit_valid(type, ofs, len)   1
+
+#endif
diff --git a/tcg/wasm/tcg-target-mo.h b/tcg/wasm/tcg-target-mo.h
new file mode 100644
index 0000000000..779872e39a
--- /dev/null
+++ b/tcg/wasm/tcg-target-mo.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific memory model
+ * Copyright (c) 2009, 2011 Stefan Weil
+ */
+
+#ifndef TCG_TARGET_MO_H
+#define TCG_TARGET_MO_H
+
+/*
+ * We could notice __i386__ or __s390x__ and reduce the barriers depending
+ * on the host.  But if you want performance, you use the normal backend.
+ * We prefer consistency across hosts on this.
+ */
+#define TCG_TARGET_DEFAULT_MO  0
+
+#endif
diff --git a/tcg/wasm/tcg-target-opc.h.inc b/tcg/wasm/tcg-target-opc.h.inc
new file mode 100644
index 0000000000..4eb32ed736
--- /dev/null
+++ b/tcg/wasm/tcg-target-opc.h.inc
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: MIT */
+/* These opcodes for use between the tci generator and interpreter. */
+DEF(tci_movi, 1, 0, 1, TCG_OPF_NOT_PRESENT)
+DEF(tci_movl, 1, 0, 1, TCG_OPF_NOT_PRESENT)
+DEF(tci_setcarry, 0, 0, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_clz32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_ctz32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_divs32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_divu32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_rems32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_remu32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_rotl32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_rotr32, 1, 2, 0, TCG_OPF_NOT_PRESENT)
+DEF(tci_setcond32, 1, 2, 1, TCG_OPF_NOT_PRESENT)
+DEF(tci_movcond32, 1, 2, 1, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/wasm/tcg-target-reg-bits.h b/tcg/wasm/tcg-target-reg-bits.h
new file mode 100644
index 0000000000..dcb1a203f8
--- /dev/null
+++ b/tcg/wasm/tcg-target-reg-bits.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific register size
+ * Copyright (c) 2009, 2011 Stefan Weil
+ */
+
+#ifndef TCG_TARGET_REG_BITS_H
+#define TCG_TARGET_REG_BITS_H
+
+#if UINTPTR_MAX == UINT32_MAX
+# define TCG_TARGET_REG_BITS 32
+#elif UINTPTR_MAX == UINT64_MAX
+# define TCG_TARGET_REG_BITS 64
+#else
+# error Unknown pointer size for tci target
+#endif
+
+#endif
diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
new file mode 100644
index 0000000000..33b81f1fe2
--- /dev/null
+++ b/tcg/wasm/tcg-target.c.inc
@@ -0,0 +1,1320 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Tiny Code Generator for QEMU
+ *
+ * Copyright (c) 2009, 2011 Stefan Weil
+ *
+ * Based on tci/tcg-target.c.inc
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+/* Used for function call generation. */
+#define TCG_TARGET_CALL_STACK_OFFSET    0
+#define TCG_TARGET_STACK_ALIGN          8
+#if TCG_TARGET_REG_BITS == 32
+# define TCG_TARGET_CALL_ARG_I32        TCG_CALL_ARG_EVEN
+# define TCG_TARGET_CALL_ARG_I64        TCG_CALL_ARG_EVEN
+# define TCG_TARGET_CALL_ARG_I128       TCG_CALL_ARG_EVEN
+#else
+# define TCG_TARGET_CALL_ARG_I32        TCG_CALL_ARG_NORMAL
+# define TCG_TARGET_CALL_ARG_I64        TCG_CALL_ARG_NORMAL
+# define TCG_TARGET_CALL_ARG_I128       TCG_CALL_ARG_NORMAL
+#endif
+#define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
+
+static TCGConstraintSetIndex
+tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
+{
+    return C_NotImplemented;
+}
+
+static const int tcg_target_reg_alloc_order[] = {
+    TCG_REG_R4,
+    TCG_REG_R5,
+    TCG_REG_R6,
+    TCG_REG_R7,
+    TCG_REG_R8,
+    TCG_REG_R9,
+    TCG_REG_R10,
+    TCG_REG_R11,
+    TCG_REG_R12,
+    TCG_REG_R13,
+    TCG_REG_R14,
+    TCG_REG_R15,
+    /* Either 2 or 4 of these are call clobbered, so use them last. */
+    TCG_REG_R3,
+    TCG_REG_R2,
+    TCG_REG_R1,
+    TCG_REG_R0,
+};
+
+/* No call arguments via registers.  All will be stored on the "stack". */
+static const int tcg_target_call_iarg_regs[] = { };
+
+static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
+{
+    tcg_debug_assert(kind == TCG_CALL_RET_NORMAL);
+    tcg_debug_assert(slot >= 0 && slot < 128 / TCG_TARGET_REG_BITS);
+    return TCG_REG_R0 + slot;
+}
+
+#ifdef CONFIG_DEBUG_TCG
+static const char *const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
+    "r00",
+    "r01",
+    "r02",
+    "r03",
+    "r04",
+    "r05",
+    "r06",
+    "r07",
+    "r08",
+    "r09",
+    "r10",
+    "r11",
+    "r12",
+    "r13",
+    "r14",
+    "r15",
+};
+#endif
+
+static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
+                        intptr_t value, intptr_t addend)
+{
+    intptr_t diff = value - (intptr_t)(code_ptr + 1);
+
+    tcg_debug_assert(addend == 0);
+    tcg_debug_assert(type == 20);
+
+    if (diff == sextract32(diff, 0, type)) {
+        tcg_patch32(code_ptr, deposit32(*code_ptr, 32 - type, type, diff));
+        return true;
+    }
+    return false;
+}
+
+static void stack_bounds_check(TCGReg base, intptr_t offset)
+{
+    if (base == TCG_REG_CALL_STACK) {
+        tcg_debug_assert(offset >= 0);
+        tcg_debug_assert(offset < (TCG_STATIC_CALL_ARGS_SIZE +
+                                   TCG_STATIC_FRAME_SIZE));
+    }
+}
+
+static void tcg_out_op_l(TCGContext *s, TCGOpcode op, TCGLabel *l0)
+{
+    tcg_insn_unit insn = 0;
+
+    tcg_out_reloc(s, s->code_ptr, 20, l0, 0);
+    insn = deposit32(insn, 0, 8, op);
+    tcg_out32(s, insn);
+}
+
+static void tcg_out_op_p(TCGContext *s, TCGOpcode op, void *p0)
+{
+    tcg_insn_unit insn = 0;
+    intptr_t diff;
+
+    /* Special case for exit_tb: map null -> 0. */
+    if (p0 == NULL) {
+        diff = 0;
+    } else {
+        diff = p0 - (void *)(s->code_ptr + 1);
+        tcg_debug_assert(diff != 0);
+        if (diff != sextract32(diff, 0, 20)) {
+            tcg_raise_tb_overflow(s);
+        }
+    }
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 12, 20, diff);
+    tcg_out32(s, insn);
+}
+
+static void tcg_out_op_r(TCGContext *s, TCGOpcode op, TCGReg r0)
+{
+    tcg_insn_unit insn = 0;
+
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    tcg_out32(s, insn);
+}
+
+static void tcg_out_op_v(TCGContext *s, TCGOpcode op)
+{
+    tcg_out32(s, (uint8_t)op);
+}
+
+static void tcg_out_op_ri(TCGContext *s, TCGOpcode op, TCGReg r0, int32_t i1)
+{
+    tcg_insn_unit insn = 0;
+
+    tcg_debug_assert(i1 == sextract32(i1, 0, 20));
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 20, i1);
+    tcg_out32(s, insn);
+}
+
+static void tcg_out_op_rl(TCGContext *s, TCGOpcode op, TCGReg r0, TCGLabel *l1)
+{
+    tcg_insn_unit insn = 0;
+
+    tcg_out_reloc(s, s->code_ptr, 20, l1, 0);
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    tcg_out32(s, insn);
+}
+
+static void tcg_out_op_rr(TCGContext *s, TCGOpcode op, TCGReg r0, TCGReg r1)
+{
+    tcg_insn_unit insn = 0;
+
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 4, r1);
+    tcg_out32(s, insn);
+}
+
+static void tcg_out_op_rrm(TCGContext *s, TCGOpcode op,
+                           TCGReg r0, TCGReg r1, TCGArg m2)
+{
+    tcg_insn_unit insn = 0;
+
+    tcg_debug_assert(m2 == extract32(m2, 0, 16));
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 4, r1);
+    insn = deposit32(insn, 16, 16, m2);
+    tcg_out32(s, insn);
+}
+
+static void tcg_out_op_rrr(TCGContext *s, TCGOpcode op,
+                           TCGReg r0, TCGReg r1, TCGReg r2)
+{
+    tcg_insn_unit insn = 0;
+
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 4, r1);
+    insn = deposit32(insn, 16, 4, r2);
+    tcg_out32(s, insn);
+}
+
+static void tcg_out_op_rrs(TCGContext *s, TCGOpcode op,
+                           TCGReg r0, TCGReg r1, intptr_t i2)
+{
+    tcg_insn_unit insn = 0;
+
+    tcg_debug_assert(i2 == sextract32(i2, 0, 16));
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 4, r1);
+    insn = deposit32(insn, 16, 16, i2);
+    tcg_out32(s, insn);
+}
+
+static void tcg_out_op_rrbb(TCGContext *s, TCGOpcode op, TCGReg r0,
+                            TCGReg r1, uint8_t b2, uint8_t b3)
+{
+    tcg_insn_unit insn = 0;
+
+    tcg_debug_assert(b2 == extract32(b2, 0, 6));
+    tcg_debug_assert(b3 == extract32(b3, 0, 6));
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 4, r1);
+    insn = deposit32(insn, 16, 6, b2);
+    insn = deposit32(insn, 22, 6, b3);
+    tcg_out32(s, insn);
+}
+
+static void tcg_out_op_rrrc(TCGContext *s, TCGOpcode op,
+                            TCGReg r0, TCGReg r1, TCGReg r2, TCGCond c3)
+{
+    tcg_insn_unit insn = 0;
+
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 4, r1);
+    insn = deposit32(insn, 16, 4, r2);
+    insn = deposit32(insn, 20, 4, c3);
+    tcg_out32(s, insn);
+}
+
+static void tcg_out_op_rrrbb(TCGContext *s, TCGOpcode op, TCGReg r0,
+                             TCGReg r1, TCGReg r2, uint8_t b3, uint8_t b4)
+{
+    tcg_insn_unit insn = 0;
+
+    tcg_debug_assert(b3 == extract32(b3, 0, 6));
+    tcg_debug_assert(b4 == extract32(b4, 0, 6));
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 4, r1);
+    insn = deposit32(insn, 16, 4, r2);
+    insn = deposit32(insn, 20, 6, b3);
+    insn = deposit32(insn, 26, 6, b4);
+    tcg_out32(s, insn);
+}
+
+static void tcg_out_op_rrrr(TCGContext *s, TCGOpcode op,
+                            TCGReg r0, TCGReg r1, TCGReg r2, TCGReg r3)
+{
+    tcg_insn_unit insn = 0;
+
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 4, r1);
+    insn = deposit32(insn, 16, 4, r2);
+    insn = deposit32(insn, 20, 4, r3);
+    tcg_out32(s, insn);
+}
+
+static void tcg_out_op_rrrrrc(TCGContext *s, TCGOpcode op,
+                              TCGReg r0, TCGReg r1, TCGReg r2,
+                              TCGReg r3, TCGReg r4, TCGCond c5)
+{
+    tcg_insn_unit insn = 0;
+
+    insn = deposit32(insn, 0, 8, op);
+    insn = deposit32(insn, 8, 4, r0);
+    insn = deposit32(insn, 12, 4, r1);
+    insn = deposit32(insn, 16, 4, r2);
+    insn = deposit32(insn, 20, 4, r3);
+    insn = deposit32(insn, 24, 4, r4);
+    insn = deposit32(insn, 28, 4, c5);
+    tcg_out32(s, insn);
+}
+
+static void tcg_out_ldst(TCGContext *s, TCGOpcode op, TCGReg val,
+                         TCGReg base, intptr_t offset)
+{
+    stack_bounds_check(base, offset);
+    if (offset != sextract32(offset, 0, 16)) {
+        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP, offset);
+        tcg_out_op_rrr(s, INDEX_op_add, TCG_REG_TMP, TCG_REG_TMP, base);
+        base = TCG_REG_TMP;
+        offset = 0;
+    }
+    tcg_out_op_rrs(s, op, val, base, offset);
+}
+
+static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg val, TCGReg base,
+                       intptr_t offset)
+{
+    TCGOpcode op = INDEX_op_ld;
+
+    if (TCG_TARGET_REG_BITS == 64 && type == TCG_TYPE_I32) {
+        op = INDEX_op_ld32u;
+    }
+    tcg_out_ldst(s, op, val, base, offset);
+}
+
+static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
+{
+    tcg_out_op_rr(s, INDEX_op_mov, ret, arg);
+    return true;
+}
+
+static void tcg_out_movi(TCGContext *s, TCGType type,
+                         TCGReg ret, tcg_target_long arg)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+#if TCG_TARGET_REG_BITS == 64
+        arg = (int32_t)arg;
+        /* fall through */
+    case TCG_TYPE_I64:
+#endif
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (arg == sextract32(arg, 0, 20)) {
+        tcg_out_op_ri(s, INDEX_op_tci_movi, ret, arg);
+    } else {
+        tcg_insn_unit insn = 0;
+
+        new_pool_label(s, arg, 20, s->code_ptr, 0);
+        insn = deposit32(insn, 0, 8, INDEX_op_tci_movl);
+        insn = deposit32(insn, 8, 4, ret);
+        tcg_out32(s, insn);
+    }
+}
+
+static void tcg_out_extract(TCGContext *s, TCGType type, TCGReg rd,
+                            TCGReg rs, unsigned pos, unsigned len)
+{
+    tcg_out_op_rrbb(s, INDEX_op_extract, rd, rs, pos, len);
+}
+
+static const TCGOutOpExtract outop_extract = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tcg_out_extract,
+};
+
+static void tcg_out_sextract(TCGContext *s, TCGType type, TCGReg rd,
+                             TCGReg rs, unsigned pos, unsigned len)
+{
+    tcg_out_op_rrbb(s, INDEX_op_sextract, rd, rs, pos, len);
+}
+
+static const TCGOutOpExtract outop_sextract = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tcg_out_sextract,
+};
+
+static const TCGOutOpExtract2 outop_extract2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
+{
+    tcg_out_sextract(s, type, rd, rs, 0, 8);
+}
+
+static void tcg_out_ext8u(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_out_extract(s, TCG_TYPE_REG, rd, rs, 0, 8);
+}
+
+static void tcg_out_ext16s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
+{
+    tcg_out_sextract(s, type, rd, rs, 0, 16);
+}
+
+static void tcg_out_ext16u(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_out_extract(s, TCG_TYPE_REG, rd, rs, 0, 16);
+}
+
+static void tcg_out_ext32s(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
+    tcg_out_sextract(s, TCG_TYPE_I64, rd, rs, 0, 32);
+}
+
+static void tcg_out_ext32u(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
+    tcg_out_extract(s, TCG_TYPE_I64, rd, rs, 0, 32);
+}
+
+static void tcg_out_exts_i32_i64(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_out_ext32s(s, rd, rs);
+}
+
+static void tcg_out_extu_i32_i64(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_out_ext32u(s, rd, rs);
+}
+
+static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
+    tcg_out_mov(s, TCG_TYPE_I32, rd, rs);
+}
+
+static bool tcg_out_xchg(TCGContext *s, TCGType type, TCGReg r1, TCGReg r2)
+{
+    return false;
+}
+
+static void tcg_out_addi_ptr(TCGContext *s, TCGReg rd, TCGReg rs,
+                             tcg_target_long imm)
+{
+    /* This function is only used for passing structs by reference. */
+    g_assert_not_reached();
+}
+
+static void tcg_out_call(TCGContext *s, const tcg_insn_unit *func,
+                         const TCGHelperInfo *info)
+{
+    ffi_cif *cif = info->cif;
+    tcg_insn_unit insn = 0;
+    uint8_t which;
+
+    if (cif->rtype == &ffi_type_void) {
+        which = 0;
+    } else {
+        tcg_debug_assert(cif->rtype->size == 4 ||
+                         cif->rtype->size == 8 ||
+                         cif->rtype->size == 16);
+        which = ctz32(cif->rtype->size) - 1;
+    }
+    new_pool_l2(s, 20, s->code_ptr, 0, (uintptr_t)func, (uintptr_t)cif);
+    insn = deposit32(insn, 0, 8, INDEX_op_call);
+    insn = deposit32(insn, 8, 4, which);
+    tcg_out32(s, insn);
+}
+
+static void tcg_out_exit_tb(TCGContext *s, uintptr_t arg)
+{
+    tcg_out_op_p(s, INDEX_op_exit_tb, (void *)arg);
+}
+
+static void tcg_out_goto_tb(TCGContext *s, int which)
+{
+    /* indirect jump method. */
+    tcg_out_op_p(s, INDEX_op_goto_tb, (void *)get_jmp_target_addr(s, which));
+    set_jmp_reset_offset(s, which);
+}
+
+static void tcg_out_goto_ptr(TCGContext *s, TCGReg a0)
+{
+    tcg_out_op_r(s, INDEX_op_goto_ptr, a0);
+}
+
+void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
+                              uintptr_t jmp_rx, uintptr_t jmp_rw)
+{
+    /* Always indirect, nothing to do */
+}
+
+static void tgen_add(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_add, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_add = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_add,
+};
+
+static TCGConstraintSetIndex cset_addsubcarry(TCGType type, unsigned flags)
+{
+    return type == TCG_TYPE_REG ? C_O1_I2(r, r, r) : C_NotImplemented;
+}
+
+static void tgen_addco(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_addco, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_addco = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addsubcarry,
+    .out_rrr = tgen_addco,
+};
+
+static void tgen_addci(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_addci, a0, a1, a2);
+}
+
+static const TCGOutOpAddSubCarry outop_addci = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addsubcarry,
+    .out_rrr = tgen_addci,
+};
+
+static void tgen_addcio(TCGContext *s, TCGType type,
+                        TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_addcio, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addsubcarry,
+    .out_rrr = tgen_addcio,
+};
+
+static void tcg_out_set_carry(TCGContext *s)
+{
+    tcg_out_op_v(s, INDEX_op_tci_setcarry);
+}
+
+static void tgen_and(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_and, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_and = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_and,
+};
+
+static void tgen_andc(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_andc, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_andc = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_andc,
+};
+
+static void tgen_clz(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_clz32
+                     : INDEX_op_clz);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_clz = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_clz,
+};
+
+static void tgen_ctz(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_ctz32
+                     : INDEX_op_ctz);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_ctz = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_ctz,
+};
+
+static void tgen_deposit(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                         TCGReg a2, unsigned ofs, unsigned len)
+{
+    tcg_out_op_rrrbb(s, INDEX_op_deposit, a0, a1, a2, ofs, len);
+}
+
+static const TCGOutOpDeposit outop_deposit = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_deposit,
+};
+
+static void tgen_divs(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_divs32
+                     : INDEX_op_divs);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_divs = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_divs,
+};
+
+static const TCGOutOpDivRem outop_divs2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tgen_divu(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_divu32
+                     : INDEX_op_divu);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_divu = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_divu,
+};
+
+static const TCGOutOpDivRem outop_divu2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tgen_eqv(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_eqv, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_eqv = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_eqv,
+};
+
+#if TCG_TARGET_REG_BITS == 64
+static void tgen_extrh_i64_i32(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
+{
+    tcg_out_extract(s, TCG_TYPE_I64, a0, a1, 32, 32);
+}
+
+static const TCGOutOpUnary outop_extrh_i64_i32 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extrh_i64_i32,
+};
+#endif
+
+static void tgen_mul(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_mul, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_mul = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_mul,
+};
+
+static TCGConstraintSetIndex cset_mul2(TCGType type, unsigned flags)
+{
+    return type == TCG_TYPE_REG ? C_O2_I2(r, r, r, r) : C_NotImplemented;
+}
+
+static void tgen_muls2(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2, TCGReg a3)
+{
+    tcg_out_op_rrrr(s, INDEX_op_muls2, a0, a1, a2, a3);
+}
+
+static const TCGOutOpMul2 outop_muls2 = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_mul2,
+    .out_rrrr = tgen_muls2,
+};
+
+static const TCGOutOpBinary outop_mulsh = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tgen_mulu2(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2, TCGReg a3)
+{
+    tcg_out_op_rrrr(s, INDEX_op_mulu2, a0, a1, a2, a3);
+}
+
+static const TCGOutOpMul2 outop_mulu2 = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_mul2,
+    .out_rrrr = tgen_mulu2,
+};
+
+static const TCGOutOpBinary outop_muluh = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static void tgen_nand(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_nand, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_nand = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_nand,
+};
+
+static void tgen_nor(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_nor, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_nor = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_nor,
+};
+
+static void tgen_or(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_or, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_or = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_or,
+};
+
+static void tgen_orc(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_orc, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_orc = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_orc,
+};
+
+static void tgen_rems(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_rems32
+                     : INDEX_op_rems);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_rems = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_rems,
+};
+
+static void tgen_remu(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_remu32
+                     : INDEX_op_remu);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_remu = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_remu,
+};
+
+static void tgen_rotl(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_rotl32
+                     : INDEX_op_rotl);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_rotl = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_rotl,
+};
+
+static void tgen_rotr(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_rotr32
+                     : INDEX_op_rotr);
+    tcg_out_op_rrr(s, opc, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_rotr = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_rotr,
+};
+
+static void tgen_sar(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type < TCG_TYPE_REG) {
+        tcg_out_ext32s(s, TCG_REG_TMP, a1);
+        a1 = TCG_REG_TMP;
+    }
+    tcg_out_op_rrr(s, INDEX_op_sar, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_sar = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_sar,
+};
+
+static void tgen_shl(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_shl, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_shl = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_shl,
+};
+
+static void tgen_shr(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type < TCG_TYPE_REG) {
+        tcg_out_ext32u(s, TCG_REG_TMP, a1);
+        a1 = TCG_REG_TMP;
+    }
+    tcg_out_op_rrr(s, INDEX_op_shr, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_shr = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_shr,
+};
+
+static void tgen_sub(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_sub, a0, a1, a2);
+}
+
+static const TCGOutOpSubtract outop_sub = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_sub,
+};
+
+static void tgen_subbo(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_subbo, a0, a1, a2);
+}
+
+static const TCGOutOpAddSubCarry outop_subbo = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addsubcarry,
+    .out_rrr = tgen_subbo,
+};
+
+static void tgen_subbi(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_subbi, a0, a1, a2);
+}
+
+static const TCGOutOpAddSubCarry outop_subbi = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addsubcarry,
+    .out_rrr = tgen_subbi,
+};
+
+static void tgen_subbio(TCGContext *s, TCGType type,
+                        TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_subbio, a0, a1, a2);
+}
+
+static const TCGOutOpAddSubCarry outop_subbio = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addsubcarry,
+    .out_rrr = tgen_subbio,
+};
+
+static void tcg_out_set_borrow(TCGContext *s)
+{
+    tcg_out_op_v(s, INDEX_op_tci_setcarry);  /* borrow == carry */
+}
+
+static void tgen_xor(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, INDEX_op_xor, a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_xor = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_xor,
+};
+
+static void tgen_ctpop(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_op_rr(s, INDEX_op_ctpop, a0, a1);
+}
+
+static TCGConstraintSetIndex cset_ctpop(TCGType type, unsigned flags)
+{
+    return type == TCG_TYPE_REG ? C_O1_I1(r, r) : C_NotImplemented;
+}
+
+static const TCGOutOpUnary outop_ctpop = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_ctpop,
+    .out_rr = tgen_ctpop,
+};
+
+static void tgen_bswap16(TCGContext *s, TCGType type,
+                         TCGReg a0, TCGReg a1, unsigned flags)
+{
+    tcg_out_op_rr(s, INDEX_op_bswap16, a0, a1);
+    if (flags & TCG_BSWAP_OS) {
+        tcg_out_sextract(s, TCG_TYPE_REG, a0, a0, 0, 16);
+    }
+}
+
+static const TCGOutOpBswap outop_bswap16 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_bswap16,
+};
+
+static void tgen_bswap32(TCGContext *s, TCGType type,
+                         TCGReg a0, TCGReg a1, unsigned flags)
+{
+    tcg_out_op_rr(s, INDEX_op_bswap32, a0, a1);
+    if (flags & TCG_BSWAP_OS) {
+        tcg_out_sextract(s, TCG_TYPE_REG, a0, a0, 0, 32);
+    }
+}
+
+static const TCGOutOpBswap outop_bswap32 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_bswap32,
+};
+
+#if TCG_TARGET_REG_BITS == 64
+static void tgen_bswap64(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_op_rr(s, INDEX_op_bswap64, a0, a1);
+}
+
+static const TCGOutOpUnary outop_bswap64 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_bswap64,
+};
+#endif
+
+static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_op_rr(s, INDEX_op_neg, a0, a1);
+}
+
+static const TCGOutOpUnary outop_neg = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_neg,
+};
+
+static void tgen_not(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_op_rr(s, INDEX_op_not, a0, a1);
+}
+
+static const TCGOutOpUnary outop_not = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_not,
+};
+
+static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
+                         TCGReg dest, TCGReg arg1, TCGReg arg2)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_setcond32
+                     : INDEX_op_setcond);
+    tcg_out_op_rrrc(s, opc, dest, arg1, arg2, cond);
+}
+
+static const TCGOutOpSetcond outop_setcond = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_setcond,
+};
+
+static void tgen_negsetcond(TCGContext *s, TCGType type, TCGCond cond,
+                            TCGReg dest, TCGReg arg1, TCGReg arg2)
+{
+    tgen_setcond(s, type, cond, dest, arg1, arg2);
+    tgen_neg(s, type, dest, dest);
+}
+
+static const TCGOutOpSetcond outop_negsetcond = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_negsetcond,
+};
+
+static void tgen_brcond(TCGContext *s, TCGType type, TCGCond cond,
+                        TCGReg arg0, TCGReg arg1, TCGLabel *l)
+{
+    tgen_setcond(s, type, cond, TCG_REG_TMP, arg0, arg1);
+    tcg_out_op_rl(s, INDEX_op_brcond, TCG_REG_TMP, l);
+}
+
+static const TCGOutOpBrcond outop_brcond = {
+    .base.static_constraint = C_O0_I2(r, r),
+    .out_rr = tgen_brcond,
+};
+
+static void tgen_movcond(TCGContext *s, TCGType type, TCGCond cond,
+                         TCGReg ret, TCGReg c1, TCGArg c2, bool const_c2,
+                         TCGArg vt, bool const_vt, TCGArg vf, bool consf_vf)
+{
+    TCGOpcode opc = (type == TCG_TYPE_I32
+                     ? INDEX_op_tci_movcond32
+                     : INDEX_op_movcond);
+    tcg_out_op_rrrrrc(s, opc, ret, c1, c2, vt, vf, cond);
+}
+
+static const TCGOutOpMovcond outop_movcond = {
+    .base.static_constraint = C_O1_I4(r, r, r, r, r),
+    .out = tgen_movcond,
+};
+
+static void tgen_brcond2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
+                         TCGArg bl, bool const_bl,
+                         TCGArg bh, bool const_bh, TCGLabel *l)
+{
+    tcg_out_op_rrrrrc(s, INDEX_op_setcond2_i32, TCG_REG_TMP,
+                      al, ah, bl, bh, cond);
+    tcg_out_op_rl(s, INDEX_op_brcond, TCG_REG_TMP, l);
+}
+
+#if TCG_TARGET_REG_BITS != 32
+__attribute__((unused))
+#endif
+static const TCGOutOpBrcond2 outop_brcond2 = {
+    .base.static_constraint = C_O0_I4(r, r, r, r),
+    .out = tgen_brcond2,
+};
+
+static void tgen_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
+                          TCGReg al, TCGReg ah,
+                          TCGArg bl, bool const_bl,
+                          TCGArg bh, bool const_bh)
+{
+    tcg_out_op_rrrrrc(s, INDEX_op_setcond2_i32, ret, al, ah, bl, bh, cond);
+}
+
+#if TCG_TARGET_REG_BITS != 32
+__attribute__((unused))
+#endif
+static const TCGOutOpSetcond2 outop_setcond2 = {
+    .base.static_constraint = C_O1_I4(r, r, r, r, r),
+    .out = tgen_setcond2,
+};
+
+static void tcg_out_mb(TCGContext *s, unsigned a0)
+{
+    tcg_out_op_v(s, INDEX_op_mb);
+}
+
+static void tcg_out_br(TCGContext *s, TCGLabel *l)
+{
+    tcg_out_op_l(s, INDEX_op_br, l);
+}
+
+static void tgen_ld8u(TCGContext *s, TCGType type, TCGReg dest,
+                      TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, INDEX_op_ld8u, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld8u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld8u,
+};
+
+static void tgen_ld8s(TCGContext *s, TCGType type, TCGReg dest,
+                      TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, INDEX_op_ld8s, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld8s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld8s,
+};
+
+static void tgen_ld16u(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, INDEX_op_ld16u, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld16u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld16u,
+};
+
+static void tgen_ld16s(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, INDEX_op_ld16s, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld16s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld16s,
+};
+
+#if TCG_TARGET_REG_BITS == 64
+static void tgen_ld32u(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, INDEX_op_ld32u, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld32u = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld32u,
+};
+
+static void tgen_ld32s(TCGContext *s, TCGType type, TCGReg dest,
+                       TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, INDEX_op_ld32s, dest, base, offset);
+}
+
+static const TCGOutOpLoad outop_ld32s = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_ld32s,
+};
+#endif
+
+static void tgen_st8(TCGContext *s, TCGType type, TCGReg data,
+                     TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, INDEX_op_st8, data, base, offset);
+}
+
+static const TCGOutOpStore outop_st8 = {
+    .base.static_constraint = C_O0_I2(r, r),
+    .out_r = tgen_st8,
+};
+
+static void tgen_st16(TCGContext *s, TCGType type, TCGReg data,
+                      TCGReg base, ptrdiff_t offset)
+{
+    tcg_out_ldst(s, INDEX_op_st16, data, base, offset);
+}
+
+static const TCGOutOpStore outop_st16 = {
+    .base.static_constraint = C_O0_I2(r, r),
+    .out_r = tgen_st16,
+};
+
+static const TCGOutOpStore outop_st = {
+    .base.static_constraint = C_O0_I2(r, r),
+    .out_r = tcg_out_st,
+};
+
+static void tgen_qemu_ld(TCGContext *s, TCGType type, TCGReg data,
+                         TCGReg addr, MemOpIdx oi)
+{
+    tcg_out_op_rrm(s, INDEX_op_qemu_ld, data, addr, oi);
+}
+
+static const TCGOutOpQemuLdSt outop_qemu_ld = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out = tgen_qemu_ld,
+};
+
+static void tgen_qemu_ld2(TCGContext *s, TCGType type, TCGReg datalo,
+                          TCGReg datahi, TCGReg addr, MemOpIdx oi)
+{
+    tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, oi);
+    tcg_out_op_rrrr(s, INDEX_op_qemu_ld2, datalo, datahi, addr, TCG_REG_TMP);
+}
+
+static const TCGOutOpQemuLdSt2 outop_qemu_ld2 = {
+    .base.static_constraint =
+        TCG_TARGET_REG_BITS == 64 ? C_NotImplemented : C_O2_I1(r, r, r),
+    .out =
+        TCG_TARGET_REG_BITS == 64 ? NULL : tgen_qemu_ld2,
+};
+
+static void tgen_qemu_st(TCGContext *s, TCGType type, TCGReg data,
+                         TCGReg addr, MemOpIdx oi)
+{
+    tcg_out_op_rrm(s, INDEX_op_qemu_st, data, addr, oi);
+}
+
+static const TCGOutOpQemuLdSt outop_qemu_st = {
+    .base.static_constraint = C_O0_I2(r, r),
+    .out = tgen_qemu_st,
+};
+
+static void tgen_qemu_st2(TCGContext *s, TCGType type, TCGReg datalo,
+                          TCGReg datahi, TCGReg addr, MemOpIdx oi)
+{
+    tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, oi);
+    tcg_out_op_rrrr(s, INDEX_op_qemu_st2, datalo, datahi, addr, TCG_REG_TMP);
+}
+
+static const TCGOutOpQemuLdSt2 outop_qemu_st2 = {
+    .base.static_constraint =
+        TCG_TARGET_REG_BITS == 64 ? C_NotImplemented : C_O0_I3(r, r, r),
+    .out =
+        TCG_TARGET_REG_BITS == 64 ? NULL : tgen_qemu_st2,
+};
+
+static void tcg_out_st(TCGContext *s, TCGType type, TCGReg val, TCGReg base,
+                       intptr_t offset)
+{
+    TCGOpcode op = INDEX_op_st;
+
+    if (TCG_TARGET_REG_BITS == 64 && type == TCG_TYPE_I32) {
+        op = INDEX_op_st32;
+    }
+    tcg_out_ldst(s, op, val, base, offset);
+}
+
+static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
+                               TCGReg base, intptr_t ofs)
+{
+    return false;
+}
+
+/* Test if a constant matches the constraint. */
+static bool tcg_target_const_match(int64_t val, int ct,
+                                   TCGType type, TCGCond cond, int vece)
+{
+    return ct & TCG_CT_CONST;
+}
+
+static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
+{
+    memset(p, 0, sizeof(*p) * count);
+}
+
+static void tcg_target_init(TCGContext *s)
+{
+    /* The current code uses uint8_t for tcg operations. */
+    tcg_debug_assert(tcg_op_defs_max <= UINT8_MAX);
+
+    /* Registers available for 32 bit operations. */
+    tcg_target_available_regs[TCG_TYPE_I32] = BIT(TCG_TARGET_NB_REGS) - 1;
+    /* Registers available for 64 bit operations. */
+    tcg_target_available_regs[TCG_TYPE_I64] = BIT(TCG_TARGET_NB_REGS) - 1;
+    /*
+     * The interpreter "registers" are in the local stack frame and
+     * cannot be clobbered by the called helper functions.  However,
+     * the interpreter assumes a 128-bit return value and assigns to
+     * the return value registers.
+     */
+    tcg_target_call_clobber_regs =
+        MAKE_64BIT_MASK(TCG_REG_R0, 128 / TCG_TARGET_REG_BITS);
+
+    s->reserved_regs = 0;
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP);
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_CALL_STACK);
+
+    /* The call arguments come first, followed by the temp storage. */
+    tcg_set_frame(s, TCG_REG_CALL_STACK, TCG_STATIC_CALL_ARGS_SIZE,
+                  TCG_STATIC_FRAME_SIZE);
+}
+
+/* Generate global QEMU prologue and epilogue code. */
+static inline void tcg_target_qemu_prologue(TCGContext *s)
+{
+}
+
+static void tcg_out_tb_start(TCGContext *s)
+{
+    /* nothing to do */
+}
+
+bool tcg_target_has_memory_bswap(MemOp memop)
+{
+    return true;
+}
+
+static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
+{
+    g_assert_not_reached();
+}
+
+static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
+{
+    g_assert_not_reached();
+}
diff --git a/tcg/wasm/tcg-target.h b/tcg/wasm/tcg-target.h
new file mode 100644
index 0000000000..00befa2fcc
--- /dev/null
+++ b/tcg/wasm/tcg-target.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Tiny Code Generator for QEMU
+ *
+ * Copyright (c) 2009, 2011 Stefan Weil
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+/*
+ * This code implements a TCG which does not generate machine code for some
+ * real target machine but which generates virtual machine code for an
+ * interpreter. Interpreted pseudo code is slow, but it works on any host.
+ *
+ * Some remarks might help in understanding the code:
+ *
+ * "target" or "TCG target" is the machine which runs the generated code.
+ * This is different to the usual meaning in QEMU where "target" is the
+ * emulated machine. So normally QEMU host is identical to TCG target.
+ * Here the TCG target is a virtual machine, but this virtual machine must
+ * use the same word size like the real machine.
+ * Therefore, we need both 32 and 64 bit virtual machines (interpreter).
+ */
+
+#ifndef TCG_TARGET_H
+#define TCG_TARGET_H
+
+#define TCG_TARGET_INTERPRETER 1
+#define TCG_TARGET_INSN_UNIT_SIZE 4
+#define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
+
+/* Number of registers available. */
+#define TCG_TARGET_NB_REGS 16
+
+/* List of registers which are used by TCG. */
+typedef enum {
+    TCG_REG_R0 = 0,
+    TCG_REG_R1,
+    TCG_REG_R2,
+    TCG_REG_R3,
+    TCG_REG_R4,
+    TCG_REG_R5,
+    TCG_REG_R6,
+    TCG_REG_R7,
+    TCG_REG_R8,
+    TCG_REG_R9,
+    TCG_REG_R10,
+    TCG_REG_R11,
+    TCG_REG_R12,
+    TCG_REG_R13,
+    TCG_REG_R14,
+    TCG_REG_R15,
+
+    TCG_REG_TMP = TCG_REG_R13,
+    TCG_AREG0 = TCG_REG_R14,
+    TCG_REG_CALL_STACK = TCG_REG_R15,
+} TCGReg;
+
+#define HAVE_TCG_QEMU_TB_EXEC
+
+#endif /* TCG_TARGET_H */
-- 
2.43.0


