Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920C8CF884F
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 22:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swrFS-0004Js-6d; Fri, 04 Oct 2024 18:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gkm@rivosinc.com>) id 1swrFK-0004JX-Ct
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 18:58:03 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gkm@rivosinc.com>) id 1swrFE-0007Vz-9j
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 18:58:02 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71de9e1f374so762823b3a.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 15:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728082672; x=1728687472;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=pBwtQY6c83+U0OLwhewnaWvDmNaKpES76ITFNi45PEo=;
 b=iU2dV1hDpV0hh4A8OMAyTjqF/oU4+TSZDnNYQSdGF2sWWjOtpWddmdRezycUvOLnDQ
 +w8Kx3Nrn5JMFlUPZsUtqjXNNHo3LI+9gN/c+cMGjREN6qaNoY0SIKWwyM0AS1WsussW
 3cM5O9YGJV4fLoCeor16aKTsws+rqDUr+c+5CD9ECd+5b3VfKGE8sei1/xcgUobz8xbA
 YZJfK8VKsqsctBe5jkUD7KuMuCelcmre5v5fw7DvaB432ZDAk4gukin6llbKkpXabGkc
 JKZY2KCxS9xF/hz03rO8O3tr2IWwmTkK2WXMHhVE3O9tmJQX4pBVXbK2yinXxnvBma66
 7vbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728082672; x=1728687472;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pBwtQY6c83+U0OLwhewnaWvDmNaKpES76ITFNi45PEo=;
 b=HCa7CsHrDNqqIUd4Ck18o/155uPTeFoCmjklORndCD4u130N0Sc974RFq0eVkeaTRA
 uq+Sj5bi10TPg7QhNxF1MVeZeCmMSKZse/S+MM1kvtd3IRVl1BIotcW5NPpcpfcSKatM
 wRK/rd9bOO38R0egftx3h+bYqqJcC/tQH08XMAns0yUGTik2oRlPaqSZtw9jn84gmHi4
 zk0fwDp9nPEIplChsW9w3ihL/InAaQx/GRs2x8Eig6biVBmvFclhSF6U518FjbPRyE/v
 gNtrQ3b+1UlfU9517A9bHoxucl5EM36T187VeZacThnTW2kFd/2sPjcJ4vbhxT1ubKfD
 oUjg==
X-Gm-Message-State: AOJu0YzB58Z8QX7YJ55uXkWlGnhI/9NI88p0mgTHSxyXv+jYpdHNKMbf
 VNTMi0UWqkGtzmyTMVkZ33zYGzBNmu4q8OyT9QW6BU8r3RCuOl2+is7WmH1aDqPoZ/3BUsxH+6B
 K
X-Google-Smtp-Source: AGHT+IHzQnGmdkbVmU+SCup/BripT3VDShD/gPX8Afif3muWQ0YPKvS5RMWDBmTlberkJ7GPRKjqyw==
X-Received: by 2002:a05:6a00:23d5:b0:717:85a0:1ddb with SMTP id
 d2e1a72fcca58-71de23b5307mr7203529b3a.10.1728082670517; 
 Fri, 04 Oct 2024 15:57:50 -0700 (PDT)
Received: from gkm.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0ccd04csm399762b3a.46.2024.10.04.15.57.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 15:57:50 -0700 (PDT)
From: Greg McGary <gkm@rivosinc.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] Add plugin bbvgen: basic block icounts for topblocks +
 simpoints
Date: Fri,  4 Oct 2024 15:57:48 -0700
Message-Id: <20241004225748.1402134-1-gkm@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=gkm@rivosinc.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Tally icounts for basic blocks. The data is useful for producing
human-readable topblocks reports, and for creating simpoints to guide
accurate & efficient machine simulation runs.

QEMU's The Tiny Code Generator creates TCG blocks in a way that is
expedient for JIT translation but does not conform to the model of CFG
basic blocks. TCG greedily translates straight-line code until it must
end the block for one of four reasons: (1) page boundary, or (2)
maximum TCG block length, or (3) CSR-hacking insn, or (4) jump/branch
insn. A single TCG block can span multiple CFG blocks when there are
internal branch targets. Multiple TCG blocks can constitute a single
CFG block when the component TCG blocks terminate at page boundary,
max block length, or CSR-hacking insn.

The bbvgen plugin normalizes TCG blocks into CFG blocks.
---
 contrib/plugins/Makefile |    1 +
 contrib/plugins/bbvgen.c | 2007 ++++++++++++++++++++++++++++++++++++++
 docs/about/emulation.rst |   69 ++
 scripts/process_bbvi.py  |  385 ++++++++
 4 files changed, 2462 insertions(+)
 create mode 100644 contrib/plugins/bbvgen.c
 create mode 100755 scripts/process_bbvi.py

diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index bbddd4800f..f70fbbc2ee 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -31,6 +31,7 @@ NAMES += drcov
 NAMES += ips
 NAMES += stoptrigger
 NAMES += cflow
+NAMES += bbvgen
 
 ifeq ($(CONFIG_WIN32),y)
 SO_SUFFIX := .dll
diff --git a/contrib/plugins/bbvgen.c b/contrib/plugins/bbvgen.c
new file mode 100644
index 0000000000..b9cbe7e5f8
--- /dev/null
+++ b/contrib/plugins/bbvgen.c
@@ -0,0 +1,2007 @@
+/*
+ * Copyright (c) 2021-2024 by Rivos Inc.
+ *
+ * Generate Basic Block Vectors for simpoints.  Generate human-readable
+ * reports for identifying hot blocks whose analysis might be interesting for
+ * compiler optimization work.
+ *
+ * Authors:
+ * Kip Walker <kip@rivosinc.com> OG: infra & TCG block handlers
+ * Greg McGary <gkm@rivosinc.com> CFG block derivation
+ * Sergei Lewis <slewis@rivosinc.com> proc_map & so_save_path handlers
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+
+#include <sys/syscall.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <inttypes.h>
+#include <assert.h>
+#include <stdlib.h>
+#include <stddef.h>
+#include <inttypes.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <glib.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <zlib.h>
+
+#ifdef __linux__
+#include <linux/sched.h>
+#endif
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+static bool hex_addrs; /* print addrs as hex (needs slower pyjson5 parser) */
+static bool print_next_pc;      /* also print NEXT_PC in addition to PC */
+
+static GMutex lock;
+static _Thread_local bool enabled;
+
+#ifdef CONFIG_M5
+#include <gem5/m5ops.h>
+static bool m5ops;
+#endif
+
+/****************************************************************/
+/*
+ * TCG = Tiny Code Generator
+ * CFG = Control-Flow Graph
+ *
+ * The core problem for BBVGEN is converting TCG blocks into CFG basic
+ * blocks.
+ *
+ * The Tiny Code Generator creates TCG blocks in a way that is expedient for
+ * JIT translation but does not conform to the model of CFG basic blocks. TCG
+ * greedily translates straight-line code until it must end the block for one
+ * of four reasons: (1) page boundary, or (2) maximum TCG block length, or (3)
+ * CSR-hacking insn, or (4) jump/branch insn.
+ *
+ * QEMU's plugin API does not convey the reason why TCG terminated the block,
+ * though such information is important when recognizing control-flow graph
+ * topology. The BBVGEN plugin must infer relationships between adjacent
+ * blocks by observing runtime behavior. In this discussion, "current" and
+ * "previous" pertain to dynamic execution sequence, NOT to static address
+ * sequence.
+ *
+ * * The TCG block's JUMP_IN flag asserts that the block that statically
+ *   precedes it does not dominate it. I.e., control can flow to the JUMP_IN
+ *   block from some other textually discontiguous block. Similarly, the
+ *   JUMP_OUT flag asserts that this block does not dominate its textually
+ *   contiguous successor.
+ *
+ *   Note: In comments below, "dominator" means a block that immediately
+ *         preceeds in address sequence, such that control falls through to
+ *         its successor, and the successor is not a branch target. I.e., the
+ *         successor only and always executes immediately after the textual
+ *         predecessor executes.
+ *
+ * * When control enters a TCG block with JUMP_IN==FALSE, and the previous
+ *   block is its textual predecessor with JUMP_OUT==FALSE, then the two
+ *   blocks are tentatively SPLICED and considered part of the same CFG block,
+ *   until proven otherwise.
+ *
+ * * When BBVBEN's EXEC callback sees that the previous block is discontiguous
+ *   with the current block, then the previous block's JUMP_OUT flag and the
+ *   current block'sJUMP_IN flag both become TRUE. If the previous block was
+ *   spliced to textual successor(s), then that splice sequence is broken
+ *   after it. If the current block was spliced to textual predecessor(s),
+ *   then that splice is broken prior to it.
+ *
+ * Because splice sequences are made & broken based on runtime behavior,
+ * errors are possible. For example: a sequence of code might contain an inner
+ * loop that is only executed a single time, such that internal conditional
+ * branches are never taken, and always fall-through. At runtime, the BBVGEN
+ * EXEC callback will always see contiguous blocks execute in sequence, will
+ * never see discontiguous block entry or exit, will never set JUMP_IN or
+ * JUMP_OUT to TRUE, and will thus recognize the sequence of three TCG blocks
+ * as a single CFG block, when in fact, each TCG block corresponse to a
+ * separate CFG block.
+ *
+ * Notable differences between TCG and CFG blocks:
+ *
+ * * TCG blocks can overlap, while CFG blocks do not. I.e., a text address can
+ *   fall within multiple TCG blocks, whereas each text address falls within
+ *   only one CFG block.
+ *
+ * * A single CFG block can be split into multiple TCG blocks, where the
+ *   initial TCG block(s) terminate for reasons 1, 2, or 3, and the final TCG
+ *   block terminates for reason 4.
+ *
+ * * A single TCG block can have multiple entrypoints (jump_in targets),
+ *   vs. each CFG basic block has a single entrypoint. [caveat: The plugin API
+ *   does not convey static information about the nature of block
+ *   termination. The plugin cannot tell why TCG terminated the block ]
+ *
+ * Consider branch target addresses A, B, C which are entrypoints into
+ * straight-line code, and block termination address X.  The ascii-art diagram
+ * below illustrates TCG's way of representing blocks and their execution
+ * counts.  (Addresses increase vertically down the Y axis, and execution
+ * counts increase rightward across the X axis.)
+ *
+ * A +-------+
+ *   |       |
+ *   |       |
+ * B |       +-------+
+ *   |       |       |
+ * C |       |       +-------+
+ *   |       |       |       |
+ *   |       |       |       |
+ *   |       |       |       |
+ * X +-------+-------+-------+
+ *
+ * When control jumps to A, TCG translates [A..X), when control jumps to B,
+ * TCG translates [B..X), and similarly for a jump to C. TCG block [A..X)
+ * comprises multiple CFG blocks [A..B) + [B..C) + [C..X), and similarly for
+ * TCG block B.
+ *
+ * This diagram shows the CFG view of these same blocks:
+ *
+ * A +-------+
+ *   |       |
+ *   |       |
+ * B +-------+-------+
+ *   |               |
+ * C |---------------+-------+
+ *   |                       |
+ *   |                       |
+ *   |                       |
+ * x +-------+-------+-------+
+ *
+ */
+
+typedef struct {
+    uint64_t execs;             /* unweighted exec count */
+    uint64_t icount;            /* weighted insn-exec count */
+} BlockCounts;
+
+typedef struct {
+    BlockCounts intv;           /* current interval counts */
+    BlockCounts total;          /* total counts across all intervals */
+    uint64_t next_pc;           /* PC beyond this block */
+    uint32_t insns;             /* insn count for this block */
+    uint32_t rank;              /* weighted icount rank among blocks */
+} BlockTrack;
+
+typedef struct {
+    uint64_t intv_icount;       /* current interval counts */
+    uint64_t total_icount;      /* total counts across all intervals */
+    char *bbv_path;
+    char *bbvi_path;
+    gzFile bbv_file;
+    gzFile bbvi_file;
+} GlobalTrack;
+
+/*
+ * tcg() data tally TCG's native block counts. TCG blocks might overlap,
+ *       and/or be artifically broken at page boundaries, at maximum TCG block
+ *       sizes, or at CSR-hacking insns.
+ *
+ * cfg() data reinterpret TCG block boundaries and counters, eliminating (a)
+ *       overlaps, and (b) coaliescing adjacent dominators to form proper CFG
+ *       blocks.
+ */
+
+enum {
+    BBV_TCG = 0,                /* TCG (tiny-code generator) blocks */
+    BBV_CFG = 1,                /* CFG (control-flow graph) blocks */
+    BBV_MAX = 2,
+};
+
+static GlobalTrack t[BBV_MAX];
+
+#define tcg(m) t[BBV_TCG].m
+#define cfg(m) t[BBV_CFG].m
+
+/*
+ * BlockInfo records details about a particular TCG translation block
+ * and its execution stats. The '*_count' members track the number of
+ * instructions executed as part of this block (block executions * block
+ * instruction count).
+ */
+typedef struct _BlockInfo {
+    /* The splice and tile chains are rings: the tail points back to the head */
+    struct _BlockInfo *splice_prev; /* spliced predecessor block */
+    struct _BlockInfo *tile_next;  /* tiled successor block */
+    uint64_t pc;                /* starting PC of this TB */
+    uint32_t id;                /* ID assigned for BB */
+    bool jump_in : 1;           /* can enter from a non-adjacent predecessor */
+    bool jump_out : 1;          /* can exit to a non-adjacent successor */
+    bool tile_member : 1;       /* this TCG belongs to a set of tiles */
+    bool tile_successor : 1;    /* dominated by a predecessor set of tiles */
+    bool executed : 1;          /* tcg_gen_code() was happy with this block */
+    bool retranslated : 1;      /* tcg_gen_code() returned -2 at least once */
+    BlockTrack t[BBV_MAX];
+    char const *so_path_original;
+    char const *so_path_saved;
+    uint64_t so_pc;
+} BlockInfo;
+
+static uint64_t tcg_intv_icount_drift;  /* track drift of interval start */
+
+static GHashTable *blocks_pc_table;      /* all TCG blocks, by unique PC */
+static GHashTable *blocks_next_pc_table; /* CFG-block heads of tile groups */
+static GTree *blocks_pc_tree;            /* all TCG blocks, by PC */
+static GPtrArray *blocks_id_array;       /* all TCG by ID */
+
+static uint32_t qemu_bbv_blocks = 200; /* nblocks or $QEMU_BBV_BLOCKS */
+static uint64_t qemu_bbv_interval = 200000000; /* ilen or $QEMU_BBV_INTERVAL */
+static char *qemu_bbv_trace_path;
+static gzFile trace_file;
+static bool trace_exec;
+
+static uint64_t next_bi_id = 1; /* uniq block ID */
+static uint32_t interval;       /* current interval number */
+static uint64_t intv_start_pc;  /* first PC executed in current interval */
+
+static void reset_block_counters(gpointer key, gpointer value,
+                                 gpointer user_data)
+{
+    BlockInfo* bi = (BlockInfo *)value;
+    bi->tcg(intv.execs) = 0;
+    bi->tcg(intv.icount) = 0;
+    bi->tcg(total.execs) = 0;
+    bi->tcg(total.icount) = 0;
+    bi->cfg(intv.execs) = 0;
+    bi->cfg(intv.icount) = 0;
+    bi->cfg(total.execs) = 0;
+    bi->cfg(total.icount) = 0;
+};
+
+static void reset_all_counters()
+{
+    tcg(intv_icount) = 0;
+    tcg(total_icount) = 0;
+    cfg(intv_icount) = 0;
+    cfg(total_icount) = 0;
+    tcg_intv_icount_drift = 0;
+    interval = 0;
+
+    g_mutex_lock(&lock);
+    g_hash_table_foreach(blocks_pc_table, reset_block_counters, NULL);
+    g_mutex_unlock(&lock);
+}
+
+static gboolean keep_all(gpointer key, gpointer value, gpointer data)
+{
+    GPtrArray *blocks = (GPtrArray *) data;
+    g_ptr_array_add(blocks, value);
+    return false;
+}
+
+/*
+ * Blocks are adjacent in memory, and control cannot exit from the middle via
+ * a call, jump, or (un)conditional branch from the end of the first block.
+ */
+
+static bool dominates(BlockInfo *bi0, BlockInfo *bi1)
+{
+    return (bi0->tcg(next_pc) == bi1->pc && !bi0->jump_out && !bi1->jump_in);
+}
+
+static bool is_splice_head(BlockInfo *bi)
+{
+    return (bi->splice_prev && bi->pc < bi->splice_prev->pc);
+}
+
+static bool is_splice_non_head(BlockInfo *bi)
+{
+    return bi->splice_prev && !is_splice_head(bi);
+}
+
+static BlockInfo *get_splice_head(BlockInfo *bi)
+{
+    if (bi->splice_prev) {
+        while (!is_splice_head(bi)) {
+            bi = bi->splice_prev;
+        }
+    }
+    return bi;
+}
+
+static BlockInfo *get_splice_tail(BlockInfo *bi)
+{
+    return bi->splice_prev ? get_splice_head(bi)->splice_prev : bi;
+}
+
+static bool is_splice_tail(BlockInfo *bi)
+{
+    return (bi->splice_prev && bi == get_splice_tail(bi));
+}
+
+static bool is_splice_non_tail(BlockInfo *bi)
+{
+    return bi->splice_prev && !is_splice_tail(bi);
+}
+
+static bool is_tile_tail(BlockInfo *bi)
+{
+    return (bi->tile_next && bi->pc > bi->tile_next->pc);
+}
+
+static bool is_tile_non_tail(BlockInfo *bi)
+{
+    return bi->tile_next && !is_tile_tail(bi);
+}
+
+static BlockInfo *get_tile_tail(BlockInfo *bi)
+{
+    if (bi->tile_next) {
+        while (!is_tile_tail(bi)) {
+            bi = bi->tile_next;
+        }
+        return bi;
+    }
+    return bi;
+}
+
+static BlockInfo *get_tile_head(BlockInfo *bi)
+{
+    return bi->tile_next ? get_tile_tail(bi)->tile_next : bi;
+}
+
+static bool is_tile_head(BlockInfo *bi)
+{
+    return (bi->tile_next && bi == get_tile_head(bi));
+}
+
+static bool is_tile_non_head(BlockInfo *bi)
+{
+    return (bi->tile_next && bi != get_tile_head(bi));
+}
+
+static BlockInfo *get_tile_predecessor(BlockInfo *bi0)
+{
+    BlockInfo *bi = bi0->tile_next;
+    while (bi->tile_next != bi0) {
+        bi = bi->tile_next;
+    }
+    return bi;
+}
+
+/*
+ * All tiles within a sequence have a common NEXT_PC address.  Tiles are
+ * sequenced by ascending PC address, where the longest tile has the lowest
+ * PC, and comes first. This longest tile is entered into a hash table. (see
+ * below)
+ */
+
+static BlockInfo *insert_tile(BlockInfo *bi0, BlockInfo *bi1)
+{
+    assert(bi1->tile_next == NULL);
+    uint64_t next_pc = bi1->cfg(next_pc);
+    assert(bi0->cfg(next_pc) == next_pc);
+    assert(!is_splice_non_head(bi0));
+    assert(!is_splice_non_head(bi1));
+    BlockInfo *bi0N = get_splice_tail(bi0);
+    BlockInfo *bi1N = get_splice_tail(bi1);
+    assert(bi0N->tcg(next_pc) == next_pc);
+    assert(bi1N->tcg(next_pc) == next_pc);
+    if (bi0->tile_next == NULL) {
+        bi0->tile_next = bi1;
+        bi1->tile_next = bi0;
+        bi0N->tile_member = true;
+        bi1N->tile_member = true;
+        return (bi0->pc < bi1->pc ? bi0 : bi1);
+    } else if (bi1->pc < bi0->pc) {
+        bi1->tile_next = bi0;
+        get_tile_tail(bi0)->tile_next = bi1;
+        bi1N->tile_member = true;
+        return bi1;
+    } else {
+        BlockInfo **bip = &bi0->tile_next;
+        while (*bip != bi0 && bi1->pc > (*bip)->pc) {
+            bip = &(*bip)->tile_next;
+        }
+        bi1->tile_next = *bip;
+        *bip = bi1;
+        bi1N->tile_member = true;
+        return bi0;
+    }
+}
+
+/*
+ * B0 was part of a tile sequence.  B0 used to be spliced to B1, but they are
+ * now being split apart. That means B0 is no longer part of the tile
+ * sequence, and B1 will assume its role. Since the tile sequence is linked by
+ * ascending PC address, and this newly split tile is now shorter, and its
+ * position within the sequence might need to shift.
+ */
+
+static void relocate_tile(BlockInfo *bi0, BlockInfo *bi1)
+{
+    BlockInfo *biT = bi0->tile_next;
+    uint64_t next_pc = bi1->cfg(next_pc);
+    assert(biT->cfg(next_pc) == next_pc);
+    BlockInfo *biN = get_tile_predecessor(bi0);
+    if (bi1->pc < biT->pc) {
+        biN->tile_next = bi1;
+        bi1->tile_next = biT;
+    } else {
+        assert(biN->cfg(next_pc) == next_pc);
+        biN->tile_next = biT;
+        BlockInfo **bip = &biT->tile_next;
+        while (*bip != biN && bi1->pc > (*bip)->pc) {
+            bip = &(*bip)->tile_next;
+        }
+        bi1->tile_next = *bip;
+        *bip = bi1;
+    }
+    bi0->tile_next = NULL;
+    if (bi1->pc < biN->pc) {
+        gpointer gp_next_pc = GUINT_TO_POINTER(next_pc);
+        g_hash_table_replace(blocks_next_pc_table, gp_next_pc, bi1);
+    }
+}
+
+/*
+ * Bifurcate a splice chain. This happens when bi1->jump_in becomes true.  bi1
+ * is a new head. bi1->splice_prev is a new tail
+ */
+
+static void split_splice_at(BlockInfo *bi1)
+{
+    BlockInfo *bi0 = get_splice_head(bi1);
+    BlockInfo *bi0N = bi1->splice_prev;
+    BlockInfo *bi1N = bi0->splice_prev;
+    if (trace_file) {
+        gzprintf(trace_file, "bbvgen: intv %"PRIu32
+                 ": morph: split splice %"PRIu32" %"PRIu32"\n",
+                 interval, bi0->id, bi1->id);
+    }
+    bi0->splice_prev = (bi0 == bi0N ? NULL : bi0N);
+    bi1->splice_prev = (bi1 == bi1N ? NULL : bi1N);
+    bi0->cfg(next_pc) = bi0N->tcg(next_pc);
+    bi1->cfg(next_pc) = bi1N->tcg(next_pc);
+    if (bi0->tile_next) {
+        relocate_tile(bi0, bi1);
+    }
+}
+
+static BlockInfo *split_splice_after(BlockInfo *bi0)
+{
+    BlockInfo *bi = get_splice_tail(bi0);
+    assert(bi != bi0);
+    while (bi->splice_prev != bi0) {
+        bi = bi->splice_prev;
+    }
+    split_splice_at(bi);
+    return bi;
+}
+
+/* biN is a newly-created TCG block, possibly at the end of a splice chain */
+
+static void maybe_insert_tile(BlockInfo *biN)
+{
+    uint64_t next_pc = biN->tcg(next_pc);
+    gpointer gp_next_pc = GUINT_TO_POINTER(next_pc);
+    BlockInfo *bi0 = get_splice_head(biN);
+    assert(bi0->cfg(next_pc) == next_pc);
+    BlockInfo *bit = g_hash_table_lookup(blocks_next_pc_table, gp_next_pc);
+    if (bit == NULL) {
+        /*
+         * initially, insert the block at TCG(NEXT_PC), i.e., not some other
+         * block further up a splice sequence. Once we have a second block at
+         * this NEXT_PC, we begin storing the splice head of the longest tile.
+         */
+        g_hash_table_insert(blocks_next_pc_table, gp_next_pc, biN);
+    } else {
+        BlockInfo *bit0 = get_splice_head(bit);
+        if (bit0->cfg(next_pc) > next_pc) {
+            assert(bit->tcg(next_pc) == next_pc);
+            assert(!bit->tile_member);
+            BlockInfo *bitN = bit0->splice_prev;
+            while (bitN->splice_prev != bit) {
+                bitN = bitN->splice_prev;
+            }
+            bitN->tile_successor = true;
+            split_splice_at(bitN);
+            assert(bit0->cfg(next_pc) == next_pc);
+            assert(bitN->pc == next_pc);
+        }
+        BlockInfo *bi = insert_tile(bit0, bi0);
+        if (bi != bit) {
+            assert(bi->cfg(next_pc) == next_pc);
+            g_hash_table_replace(blocks_next_pc_table, gp_next_pc, bi);
+        }
+        if (trace_file) {
+            gzprintf(trace_file, "bbvgen: intv %"PRIu32
+                     ": insert tile ..%"PRIx64"):", interval, next_pc);
+            for (;;) {
+                assert(bi->cfg(next_pc) == next_pc);
+                assert(!is_splice_non_head(bi));
+                gzprintf(trace_file, " %"PRIu32",%"PRIu32,
+                         bi->id, bi->tcg(insns));
+                if (is_tile_tail(bi)) {
+                    break;
+                }
+                bi = bi->tile_next;
+            }
+            gzprintf(trace_file, "\n");
+        }
+    }
+}
+
+/*
+ * bi1 and biN are sequential blocks, and bi1 dominates biN.  bi1 has executed
+ * at least once, biN is newly created. Caveats:
+ *
+ * * All splices are provisional: we might later discover that bi1 is a jump
+ *   target, and therefore, bi1 does not dominate biN. If/when the splice is
+ *   invalidated, we must undo it in split_splice_at()
+ *
+ * * bi1 might later become a member of a tile chain. If/when shorter tiles
+ *   are added, biN's splice link will need to migrate to the shortest tile.
+ */
+
+static void append_to_splice_ring(BlockInfo *bi1, BlockInfo *biN)
+{
+    BlockInfo *bi0 = get_splice_head(bi1);
+    bi0->splice_prev = biN;
+    biN->splice_prev = bi1;
+    bi1->cfg(next_pc) = biN->tcg(next_pc);
+    bi0->cfg(next_pc) = biN->tcg(next_pc);
+    if (trace_file) {
+        gzprintf(trace_file, "bbvgen: intv %"PRIu32": morph: append %"PRIu32
+                 "+%"PRIu32" [%"PRIx64"..%"PRIx64"..%"PRIx64")\n", interval,
+                 bi0->id, biN->id, bi0->pc, biN->pc, biN->tcg(next_pc));
+    }
+}
+
+/*
+ * Principles / abstractions:
+ *
+ * * blocks are only created, never destroyed
+ *
+ * * splices: aggregate TCG blocks into a CFG block:
+ *   * spliced chains are created all at once, never built incrementally
+ *   * all cfg(next_pc) == final tcg(next_pc)
+ *   * first cfg(insns) == sum of all tcg(insns)
+ *   * spliced chains can bifurcate incrementally
+ *
+ * * tiles: resolve overlapped TCG blocks into non-overlapping CFG blocks
+ *   * tiles can be added incrementally
+ *   * tiled blocks are identified by common NEXT_PC
+ *   * shortest TCG tile (largest PC) can splice to successor blocks
+ *   * longest TCG tile (smallest PC) can splice to predecessor blocks
+ */
+
+static void derive_cfg_from_splices(BlockInfo *bi0)
+{
+    BlockInfo *biN = get_splice_tail(bi0);
+    bi0->cfg(next_pc) = biN->tcg(next_pc);
+    biN->cfg(next_pc) = biN->tcg(next_pc);
+    uint32_t insns = bi0->tcg(insns);
+    for (BlockInfo *bi = biN; bi != bi0; bi = bi->splice_prev) {
+        insns += bi->tcg(insns);
+    }
+    bi0->cfg(insns) = insns;
+}
+
+static void derive_cfg_from_tiles(BlockInfo *biN)
+{
+    uint64_t next_pc = biN->cfg(next_pc);
+    BlockInfo *bi0 = biN->tile_next;
+    for (BlockInfo *bi = bi0; bi != biN; bi = bi->tile_next) {
+        assert(bi->cfg(next_pc) == next_pc);
+        assert(bi->pc < bi->tile_next->pc);
+    }
+    for (; bi0 != biN; bi0 = bi0->tile_next) {
+        BlockInfo *bi1 = bi0->tile_next;
+        bi0->cfg(next_pc) = bi1->pc;
+        bi0->cfg(insns) -= bi1->cfg(insns);
+        bi1->cfg(intv.execs) += bi0->cfg(intv.execs);
+        bi1->cfg(total.execs) += bi0->cfg(total.execs);
+        if (trace_file && bi0->cfg(intv.execs)) {
+            gzprintf(trace_file, "bbvgen: intv %"PRIu32": tile spill %"PRIu64
+                     ": %"PRIu32" > %"PRIu32"\n",
+                     interval, bi0->cfg(intv.execs), bi0->id, bi1->id);
+        }
+    }
+}
+
+/*
+ * When printing an audit trail for TCG vs. CFG icount mismatches in the trace
+ * log, annotate TCG blocks with symbols that indicate how it is related with
+ * its neighbors, as a member of a splice or tile chain.
+ */
+
+static const char *block_join_prefix(BlockInfo *bi)
+{
+    unsigned tile_head = (is_tile_head(bi) ? 8 : 0);
+    unsigned tile_non_head = (is_tile_non_head(bi) ? 4 : 0);
+    unsigned splice_head = (is_splice_head(bi) ? 2 : 0);
+    unsigned splice_non_head = (is_splice_non_head(bi) ? 1 : 0);
+    switch (tile_head | tile_non_head | splice_head | splice_non_head) {
+    case 0b0000: return "";
+    case 0b0001: return "+";
+    case 0b0010: return "(";
+    case 0b0011: return "! (+";
+    case 0b0100: return "|";
+    case 0b0101: return "|+";
+    case 0b0110: return "|(";
+    case 0b0111: return "! |(+";
+    case 0b1000: return "[";
+    case 0b1001: return "! [+";
+    case 0b1010: return "[(";
+    case 0b1011: return "! [(+";
+    case 0b1100: return "! [|";
+    case 0b1101: return "! [|+";
+    case 0b1110: return "! [|(";
+    case 0b1111: return "! [|(+";
+    default: return "<wut?>";
+    }
+}
+
+static const char *block_join_suffix(BlockInfo *bi)
+{
+    unsigned tile_tail = (is_tile_tail(bi) ? 8 : 0);
+    unsigned tile_non_tail = (is_tile_non_tail(bi) ? 4 : 0);
+    unsigned splice_tail = (is_splice_tail(bi) ? 2 : 0);
+    unsigned splice_non_tail = (is_splice_non_tail(bi) ? 1 : 0);
+    switch (tile_tail | tile_non_tail | splice_tail | splice_non_tail) {
+    case 0b0000: return "";
+    case 0b0001: return "+";
+    case 0b0010: return ")";
+    case 0b0011: return "+) !";
+    case 0b0100: return "|";
+    case 0b0101: return "|+";
+    case 0b0110: return "|)";
+    case 0b0111: return "|+) !";
+    case 0b1000: return "]";
+    case 0b1001: return "+] !";
+    case 0b1010: return "])";
+    case 0b1011: return "+)] !";
+    case 0b1100: return "|] !";
+    case 0b1101: return "+|] !";
+    case 0b1110: return ")|] !";
+    case 0b1111: return "+)|] !";
+    default: return "<wut?>";
+    }
+}
+
+static void derive_cfg_from_tcg(void)
+{
+    /*
+     * Dump GTree into a PC-sequenced GPtrArray for easy iteration.  We could
+     * traverse the GTree directly, but since we make multiple passes, overall
+     * performance is better if we traverse once, and save the result in an
+     * array.
+     */
+    assert(blocks_id_array->len == g_tree_nnodes(blocks_pc_tree));
+    GPtrArray *blocks = g_ptr_array_sized_new(g_tree_nnodes(blocks_pc_tree));
+    g_tree_foreach(blocks_pc_tree, keep_all, blocks);
+
+    for (int i = 0; i < blocks->len; i++) {
+        BlockInfo *bi = g_ptr_array_index(blocks, i);
+        if (bi->splice_prev == NULL) {
+            bi->cfg(insns) = bi->tcg(insns);
+            bi->cfg(next_pc) = bi->tcg(next_pc);
+        } else if (is_splice_head(bi)) {
+            derive_cfg_from_splices(bi);
+        }
+        if (bi->cfg(insns)) {
+            bi->cfg(intv.execs) += bi->tcg(intv.execs);
+            bi->cfg(total.execs) += bi->tcg(total.execs);
+        }
+    }
+    for (int i = blocks->len - 1; i >= 0; i--) {
+        BlockInfo *bi = g_ptr_array_index(blocks, i);
+        if (is_tile_tail(bi)) {
+            derive_cfg_from_tiles(bi);
+        }
+    }
+    /* Finalize TCG & CFG block icounts */
+    for (int i = 0; i < blocks->len; i++) {
+        BlockInfo *bi = g_ptr_array_index(blocks, i);
+        /* Accumulate TCG totals */
+        bi->tcg(total.execs) += bi->tcg(intv.execs);
+        bi->tcg(total.icount) += bi->tcg(intv.icount);
+        if (is_tile_tail(bi)) {
+            uint64_t next_pc = bi->cfg(next_pc);
+            BlockInfo *biN = get_splice_tail(bi);
+            assert(biN->tile_member);
+            assert(next_pc == biN->tcg(next_pc));
+            if (!biN->jump_out) {
+                gpointer gp_pc = GUINT_TO_POINTER(next_pc);
+                BlockInfo *biX = g_hash_table_lookup(blocks_pc_table, gp_pc);
+                if (biX && biX->tile_successor) {
+                    bi->cfg(insns) += biX->cfg(insns);
+                    biX->cfg(insns) = 0;
+                }
+            }
+        }
+        /* Derive CFG icounts */
+        bi->cfg(intv.icount) += bi->cfg(intv.execs) * bi->cfg(insns);
+        bi->cfg(total.execs) += bi->cfg(intv.execs);
+        bi->cfg(total.icount) += bi->cfg(total.execs) * bi->cfg(insns);
+        cfg(intv_icount) += bi->cfg(intv.icount);
+    }
+
+    /* Sanity checks ... */
+    if (trace_file && cfg(intv_icount) != tcg(intv_icount)) {
+        gzprintf(trace_file, "bbvgen: intv %"PRIu32": error: intv cfg %"PRIu64
+                " - tcg %"PRIu64" = %"PRIi64" = %.4f%%\n",
+                interval, cfg(intv_icount), tcg(intv_icount),
+                 cfg(intv_icount) - tcg(intv_icount),
+                 100.0 * (int64_t) (cfg(intv_icount) -
+                                    tcg(intv_icount)) / tcg(intv_icount));
+        if (trace_file) {
+            for (int i = 0; i < blocks->len; i++) {
+                BlockInfo *bi = g_ptr_array_index(blocks, i);
+                if (bi->tcg(intv.execs) || bi->cfg(intv.execs) ||
+                    bi->cfg(insns) > (1 << 31u)) {
+                    gzprintf(trace_file, "bbvgen: intv %"PRIu32
+                             ": audit: %s%"PRIu32"%s tcg %"PRIu32"*%"PRIu64
+                             "=%"PRIu64" cfg %"PRIu32"*%"PRIu64"=%"PRIu64"\n",
+                             interval, block_join_prefix(bi), bi->id,
+                             block_join_suffix(bi), bi->tcg(insns),
+                             bi->tcg(intv.execs), bi->tcg(intv.icount),
+                             bi->cfg(insns), bi->cfg(intv.execs),
+                             bi->cfg(intv.icount));
+                }
+            }
+        }
+    }
+    g_ptr_array_free(blocks, true);
+    tcg(total_icount) += tcg(intv_icount);
+    cfg(total_icount) += cfg(intv_icount);
+    if (trace_file && cfg(total_icount) != tcg(total_icount)) {
+        gzprintf(trace_file, "bbvgen: intv %"PRIu32": error: total cfg %"PRIu64
+                 " - tcg %"PRIu64" = %"PRIi64" = %.4f%%\n",
+                 interval, cfg(total_icount), tcg(total_icount),
+                 cfg(total_icount) - tcg(total_icount),
+                 100.0 * (int64_t) (cfg(total_icount) -
+                                    tcg(total_icount)) / tcg(total_icount));
+    }
+}
+
+/****************************************************************/
+
+/*
+ * The output functions are generic, and can print either the
+ * TCG or CFG representation. This is mostly done for debugging.
+ * Now that the CFG code is clean, there isn't much use for the
+ * TCG representation, but it is retained for now ...
+ */
+
+static char const * const anonymous_block_name = "anonymous";
+static char *anonymous_save_filename;
+static char const *so_save_path;
+
+static gint cmp_tcg_intv_icount(gconstpointer a, gconstpointer b)
+{
+    BlockInfo *ea = *(BlockInfo **) a;
+    BlockInfo *eb = *(BlockInfo **) b;
+    return ea->tcg(intv.icount) > eb->tcg(intv.icount) ? -1 : 1;
+}
+
+static gint cmp_cfg_intv_icount(gconstpointer a, gconstpointer b)
+{
+    BlockInfo *ea = *(BlockInfo **) a;
+    BlockInfo *eb = *(BlockInfo **) b;
+    return ea->cfg(intv.icount) > eb->cfg(intv.icount) ? -1 : 1;
+}
+
+static GCompareFunc cmp_intv_icount[BBV_MAX] = {
+    [BBV_TCG] = cmp_tcg_intv_icount,
+    [BBV_CFG] = cmp_cfg_intv_icount,
+};
+
+static void print_hot_blocks(GPtrArray *blocks, unsigned o, unsigned indent)
+{
+    unsigned n = qemu_bbv_blocks < blocks->len ? qemu_bbv_blocks : blocks->len;
+    g_ptr_array_sort(blocks, cmp_intv_icount[o]);
+    for (int i = 0; i < n; i++) {
+        BlockInfo *bi = g_ptr_array_index(blocks, i);
+        bi->t[o].rank = i;
+        if (i) {
+            gzprintf(t[o].bbvi_file, ",\n");
+        }
+        gzprintf(t[o].bbvi_file, "%*s{ \"pc\": ", indent, " ");
+        gzprintf(t[o].bbvi_file, hex_addrs ? "0x%"PRIx64", " : "%"PRIu64", ",
+                 bi->pc);
+        if (print_next_pc) {
+            gzprintf(t[o].bbvi_file, "\"next_pc\": ");
+            gzprintf(t[o].bbvi_file,
+                     hex_addrs ? "0x%"PRIx64", " : "%"PRIu64", ",
+                     bi->t[o].next_pc);
+        }
+        gzprintf(t[o].bbvi_file, "\"len\": %2"PRIu32", \"icount\": %"PRIu64
+                 ", \"pct\": %.2f",
+                 bi->t[o].insns, bi->t[o].intv.icount,
+                 100.0 * bi->t[o].intv.icount / t[o].intv_icount);
+        if (bi->so_path_original) {
+            gzprintf(t[o].bbvi_file, ", \"so_src\": \"%s\", \"so_cpy\":"
+                     " \"%s\", \"%s\": ",
+                     bi->so_path_original, bi->so_path_saved,
+                     (bi->so_path_original == anonymous_block_name) ?
+                     "file_ofs" : "so_pc");
+            gzprintf(t[o].bbvi_file, hex_addrs ? "0x%"PRIx64 : "%"PRIu64,
+                     bi->so_pc);
+        }
+        gzprintf(t[o].bbvi_file, " }");
+    }
+    for (int i = n; i < blocks->len; i++) {
+        BlockInfo *bi = g_ptr_array_index(blocks, i);
+        bi->t[o].rank = i;
+    }
+    gzprintf(t[o].bbvi_file, "\n");
+}
+
+static void keep_tcg_intv_icount(gpointer data, gpointer user_data)
+{
+    BlockInfo *bi = (BlockInfo *) data;
+    if (bi->tcg(intv.icount)) {
+        GPtrArray *blocks = (GPtrArray *) user_data;
+        g_ptr_array_add(blocks, data);
+    }
+}
+
+static void keep_cfg_intv_icount(gpointer data, gpointer user_data)
+{
+    BlockInfo *bi = (BlockInfo *) data;
+    if (bi->cfg(intv.icount)) {
+        GPtrArray *blocks = (GPtrArray *) user_data;
+        g_ptr_array_add(blocks, data);
+    }
+}
+
+static GFunc keep_intv_icount[BBV_MAX] = {
+    [BBV_TCG] = keep_tcg_intv_icount,
+    [BBV_CFG] = keep_cfg_intv_icount,
+};
+
+static void print_interval(unsigned o)
+{
+    if (t[o].bbv_file == Z_NULL && t[o].bbvi_file == Z_NULL) {
+        return;
+    }
+    GPtrArray *blocks = g_ptr_array_sized_new(blocks_id_array->len);
+    g_ptr_array_foreach(blocks_id_array, keep_intv_icount[o], blocks);
+
+    /* Generate the BBV and BBVI vectors for this interval */
+    if (t[o].bbv_file) {
+        gzprintf(t[o].bbv_file, "T");
+        for (int i = 0; i < blocks->len; i++) {
+            BlockInfo *bi = g_ptr_array_index(blocks, i);
+            gzprintf(t[o].bbv_file, ":%"PRIu32":%"PRIu64" ",
+                     bi->id, bi->t[o].intv.icount);
+        }
+        gzprintf(t[o].bbv_file, "\n");
+    }
+    if (t[o].bbvi_file) {
+        if (interval > 0) {
+            gzprintf(t[o].bbvi_file, ",\n");
+        }
+        gzprintf(t[o].bbvi_file, "%*s{\n", 8, " ");
+        gzprintf(t[o].bbvi_file, "%*s\"index\": %"PRIu32", \"pc\": ", 12, " ",
+                 interval);
+        gzprintf(t[o].bbvi_file, hex_addrs ? "0x%"PRIx64 : "%"PRIu64,
+                 intv_start_pc);
+        gzprintf(t[o].bbvi_file, ", \"len\": %2"PRIu64", \"icount\": %"PRIu64
+                 ", \"blocks\": [\n", t[o].intv_icount, t[o].total_icount);
+        print_hot_blocks(blocks, o, 16);
+        gzprintf(t[o].bbvi_file, "%*s]\n%*s}", 12, " ", 8, " ");
+    }
+    g_ptr_array_free(blocks, true);
+}
+
+static void end_output_files(unsigned o);
+
+static void keep_tcg_total_icount(gpointer data, gpointer user_data)
+{
+    BlockInfo *bi = (BlockInfo *) data;
+    if (bi->tcg(total.icount)) {
+        GPtrArray *blocks = (GPtrArray *) user_data;
+        /*
+         * Copy tcg(total.icount) into tcg(intv.count), so print_hot_blocks()
+         * is usable for both the interval & summary reports
+         */
+        bi->tcg(intv.icount) = bi->tcg(total.icount);
+        g_ptr_array_add(blocks, data);
+    }
+}
+
+static void keep_cfg_total_icount(gpointer data, gpointer user_data)
+{
+    BlockInfo *bi = (BlockInfo *) data;
+    if (bi->cfg(total.icount)) {
+        GPtrArray *blocks = (GPtrArray *) user_data;
+        /*
+         * Copy cfg(total.icount) into cfg(intv.count), so print_hot_blocks()
+         * is usable for both the interval & summary reports
+         */
+        bi->cfg(intv.icount) = bi->cfg(total.icount);
+        g_ptr_array_add(blocks, data);
+    }
+}
+
+static GFunc keep_total_icount[BBV_MAX] = {
+    [BBV_TCG] = keep_tcg_total_icount,
+    [BBV_CFG] = keep_cfg_total_icount,
+};
+
+static void end_output_files(unsigned o)
+{
+    if (t[o].bbvi_file) {
+        gzclose_w(t[o].bbv_file);
+        t[o].bbv_file = Z_NULL;
+        free(t[o].bbv_path);
+        t[o].bbv_path = NULL;
+    }
+    if (t[o].bbvi_file) {
+        GPtrArray *blocks = g_ptr_array_sized_new(blocks_id_array->len);
+        g_ptr_array_foreach(blocks_id_array, keep_total_icount[o], blocks);
+        t[o].intv_icount = t[o].total_icount; /* for print_hot_blocks */
+
+        /* Write out some details covering the entire execution */
+        gzprintf(t[o].bbvi_file, "\n    ],\n");
+        gzprintf(t[o].bbvi_file, "    \"instructions\": %"PRIu64",\n",
+                 t[o].total_icount);
+        gzprintf(t[o].bbvi_file, "    \"blocks\": [\n");
+        print_hot_blocks(blocks, o, 8);
+        gzprintf(t[o].bbvi_file, "    ],\n");
+        g_ptr_array_free(blocks, true);
+
+        /* Dump a sorted list of block IDs with block info */
+        gzprintf(t[o].bbvi_file, "    \"ids\": [\n");
+        for (int i = 0; i < blocks_id_array->len; i++) {
+            BlockInfo *bi = g_ptr_array_index(blocks_id_array, i);
+            if (i) {
+                gzprintf(t[o].bbvi_file, ",\n");
+            }
+            gzprintf(t[o].bbvi_file, "%*s{ \"id\": %"PRIu64", \"pc\": ",
+                     8, " ", bi->id);
+            gzprintf(t[o].bbvi_file, hex_addrs ? "0x%"PRIx64
+                     ", " : "%"PRIu64", ", bi->pc);
+            if (print_next_pc) {
+                gzprintf(t[o].bbvi_file, "\"next_pc\": ");
+                gzprintf(t[o].bbvi_file, hex_addrs ? "0x%"PRIx64
+                         ", " : "%"PRIu64", ", bi->t[o].next_pc);
+            }
+            gzprintf(t[o].bbvi_file, "\"len\": %2"PRIu32, bi->t[o].insns);
+
+            if (bi->so_path_original) {
+                gzprintf(t[o].bbvi_file, ", \"so_src\": \"%s\", \"so_cpy\":"
+                         " \"%s\", \"%s\": ",
+                         bi->so_path_original, bi->so_path_saved,
+                         (bi->so_path_original == anonymous_block_name) ?
+                         "file_ofs" : "so_pc");
+                gzprintf(t[o].bbvi_file, hex_addrs ? "0x%"PRIx64 : "%"PRIu64,
+                         bi->so_pc);
+            }
+            gzprintf(t[o].bbvi_file, " }");
+        }
+        gzprintf(t[o].bbvi_file, "\n    ]\n}\n");
+        gzclose_w(t[o].bbvi_file);
+        t[o].bbvi_file = Z_NULL;
+        free(t[o].bbvi_path);
+        t[o].bbvi_path = NULL;
+    }
+}
+
+static void end_interval(void)
+{
+    derive_cfg_from_tcg();
+    print_interval(BBV_TCG);
+    print_interval(BBV_CFG);
+    interval++;
+    if (enabled) {
+        for (int i = 0; i < blocks_id_array->len; i++) {
+            BlockInfo *bi = g_ptr_array_index(blocks_id_array, i);
+            bi->tcg(intv.execs) = 0;
+            bi->tcg(intv.icount) = 0;
+            bi->cfg(insns) = 0;
+            bi->cfg(intv.execs) = 0;
+            bi->cfg(intv.icount) = 0;
+            bi->cfg(total.execs) = 0;
+            bi->cfg(total.icount) = 0;
+            if (is_tile_tail(bi)) {
+                uint64_t next_pc = get_splice_tail(bi)->tcg(next_pc);
+                BlockInfo *biN = bi;
+                BlockInfo *bi0 = bi->tile_next;
+                biN->cfg(next_pc) = next_pc;
+                for (bi = bi0; bi != biN; bi = bi->tile_next) {
+                    bi->cfg(next_pc) = next_pc;
+                }
+            }
+        }
+        tcg(intv_icount) = 0;
+        cfg(intv_icount) = 0;
+    } else {
+        end_output_files(BBV_TCG);
+        end_output_files(BBV_CFG);
+        if (trace_file) {
+            gzclose_w(trace_file);
+            free(qemu_bbv_trace_path);
+            qemu_bbv_trace_path = NULL;
+        }
+    }
+}
+
+static void begin_output_files(unsigned o)
+{
+    if (t[o].bbv_path) {
+        t[o].bbv_file = gzopen(t[o].bbv_path, "wb9");
+        if (t[o].bbv_file == Z_NULL) {
+            fprintf(stderr, "bbvgen: cannot open `%s' for compressed writing (%s)\n",
+                    t[o].bbv_path, strerror(errno));
+            free(t[o].bbv_path);
+            t[o].bbv_path = NULL;
+        }
+    }
+    if (t[o].bbvi_path) {
+        t[o].bbvi_file = gzopen(t[o].bbvi_path, "wb9");
+        if (t[o].bbvi_file == Z_NULL) {
+            fprintf(stderr, "bbvgen: cannot open `%s' for compressed writing (%s)\n",
+                    t[o].bbvi_path, strerror(errno));
+            free(t[o].bbv_path);
+            t[o].bbv_path = NULL;
+        }
+    }
+    if (t[o].bbvi_file) {
+        static const char *block_type[BBV_MAX] = {
+            [BBV_TCG] = "TCG",
+            [BBV_CFG] = "CFG",
+        };
+        gzprintf(t[o].bbvi_file, "{\n    \"source\": \"qemu-bbvgen\",\n");
+        gzprintf(t[o].bbvi_file, "    \"version\": 2,\n");
+        gzprintf(t[o].bbvi_file, "    \"block_type\": \"%s\",\n", block_type[o]);
+        gzprintf(t[o].bbvi_file, "    \"intervals\": [\n");
+    }
+}
+
+static char *pidify_path(char *path, pid_t pid)
+{
+    int length = strlen(path);
+    char *new_path = malloc(length + 11);
+    path[length - 3] = '\0';
+    sprintf(new_path, "%s.%"PRIu32".gz", path, pid);
+    free(path);
+    return new_path;
+}
+
+static void fork_output_files_1(unsigned o, pid_t pid)
+{
+    if (t[o].bbv_file == NULL && t[o].bbvi_file == NULL) {
+        return;
+    }
+    if (t[o].bbv_file) {
+        t[o].bbv_path = pidify_path(t[o].bbv_path, pid);
+    }
+    if (t[o].bbvi_file) {
+        t[o].bbvi_path = pidify_path(t[o].bbvi_path, pid);
+    }
+    /*
+     * Zlib doesn't seem to have a way to tear down local state +
+     * close the underlying file descriptor, which we would prefer
+     * (since the parent process will continue writing to this
+     * file). Instead, we leak.
+     */
+    /* FIXME: Don't leak memory for reopened FILE and gzFile structs. */
+    begin_output_files(o);
+}
+
+static void fork_output_files(void)
+{
+    pid_t pid = getpid();
+    fork_output_files_1(BBV_TCG, pid);
+    fork_output_files_1(BBV_CFG, pid);
+    if (so_save_path) {
+        char save_target_path_buf[PATH_MAX];
+        snprintf(save_target_path_buf, sizeof(save_target_path_buf),
+                 "anonymous-%d.dump", (int)pid);
+        anonymous_save_filename = strdup(save_target_path_buf);
+    }
+}
+
+/****************************************************************/
+
+static BlockInfo *exec_bi;
+
+static const char *block_in_out_signature(BlockInfo *bi, bool jump_in)
+{
+    static char signature[3] = "..";
+    signature[0] = (jump_in ? 'J' : bi->jump_in ? 'j' : 'f');
+    signature[1] = (bi->jump_out ? 'j' : 'f');
+    return signature;
+}
+
+static void maybe_end_interval()
+{
+    /* Don't end an interval inside a TCG chain that forms a long CFG block */
+    if (exec_bi && exec_bi->jump_out &&
+        tcg(intv_icount) + tcg_intv_icount_drift >= qemu_bbv_interval) {
+        /*
+         * Track drift due to ending intervals on block boundaries. We
+         * want interval starts to stay close to (intv_num * qemu_bbv_interval).
+         */
+        tcg_intv_icount_drift += tcg(intv_icount) - qemu_bbv_interval;
+        end_interval();
+    }
+}
+
+static void maybe_save_proc_map_entry(BlockInfo *bi);
+
+static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
+{
+#ifdef CONFIG_M5
+    if (m5ops && !enabled) {
+        return;
+    }
+#endif
+    BlockInfo *bi = (BlockInfo *) udata;
+    /*
+     * The callback has to run for every TB execution so we can detect
+     * the end of an interval. Most of the time we just bail
+     * immediately. Note that inline operations (counter increment)
+     * run after callbacks, which means we're evaluating the number of
+     * instructions executed up through the *previous* TB.
+     * Use the lock to make sure there is no race between updating
+     * tcg(intv_icount) and bi and dumping them
+     */
+    g_mutex_lock(&lock);
+
+    maybe_end_interval();
+
+    if (!bi->executed) {
+        /*
+         * Initialize size-sensitive pieces of BlockInfo that should only
+         * happen on a block that is stable and won't be retranslated due
+         * to excessive size.
+         */
+        bi->executed = true;
+        if (!bi->jump_in && !exec_bi->tile_member) {
+            append_to_splice_ring(exec_bi, bi);
+        }
+        assert(!bi->tile_member);
+        maybe_insert_tile(bi);
+        maybe_save_proc_map_entry(bi);
+    }
+    if (tcg(intv_icount) == 0) {
+        intv_start_pc = bi->pc;
+    }
+    if (exec_bi && !dominates(exec_bi, bi)) {
+        if (!bi->jump_in) {
+            if (is_splice_non_head(bi)) {
+                split_splice_at(bi);
+            }
+            bi->jump_in = true;
+            bi->tile_successor = false;
+        }
+        if (!exec_bi->jump_out) {
+            BlockInfo *bi1 =
+                (is_splice_non_tail(exec_bi) ? split_splice_after(exec_bi) :
+                 g_hash_table_lookup(blocks_pc_table,
+                                     GUINT_TO_POINTER(exec_bi->tcg(next_pc))));
+            if (bi1 && exec_bi->tile_member) {
+                bi1->tile_successor = false;
+            }
+            exec_bi->jump_out = true;
+        }
+    }
+    bi->tcg(intv.execs)++;
+    bi->tcg(intv.icount) += bi->tcg(insns);
+    if (trace_file && trace_exec) {
+        gzprintf(trace_file, "bbvgen: intv %"PRIu32
+                 ": exec %"PRIu32" tcg %"PRIu32"*%"PRIu64"=%"PRIu64" <%s>\n",
+                 interval, bi->id, bi->tcg(insns), bi->tcg(intv.execs),
+                 bi->tcg(intv.icount),
+                 block_in_out_signature(bi, bi->jump_in));
+    }
+    tcg(intv_icount) += bi->tcg(insns);
+    exec_bi = bi;
+
+    g_mutex_unlock(&lock);
+}
+
+static BlockInfo *fetch_block(uint64_t pc, uint64_t size, uint32_t tcg_insns)
+{
+    const uint64_t next_pc = pc + size;
+    gpointer gp_pc = GUINT_TO_POINTER(pc);
+    BlockInfo *bi = g_hash_table_lookup(blocks_pc_table, gp_pc);
+    /*
+     * TCG sometimes translate a block, calls the translation plugin
+     * (vcpu_tb_trans), later determines the block is too big, retranslates
+     * with a smaller limit on guest-insn count, and calls the translation
+     * plugin again. All retranslations occur before a block can execute,
+     * so by the time the execution plugin (vcpu_tb_exec) runs, the block
+     * has a stable size. Therefore, any size-sensitive BlockInfo-member
+     * initialization occurs in the execution plugin.
+     */
+    bool retranslated = (bi && !bi->executed);
+    if (bi) {
+        bi->retranslated |= retranslated;
+        /*
+         * When TCG must regenerate a block dropped from its translation
+         * cache, it follows the same sequence of tossing too-large blocks
+         * and retranslating. That is why the assertion on stable NEXT_PC
+         * is relaxed for blocks subject to size-induced retranslation.
+         */
+        assert(bi->retranslated || bi->tcg(next_pc) == next_pc);
+    } else {
+        bi = g_new0(BlockInfo, 1);
+        bi->id = next_bi_id++;
+        bi->pc = pc;
+        g_hash_table_insert(blocks_pc_table, gp_pc, bi);
+        g_ptr_array_insert(blocks_id_array, bi->id - 1, bi);
+        g_tree_insert(blocks_pc_tree, gp_pc, bi);
+        assert(blocks_id_array->len == g_tree_nnodes(blocks_pc_tree));
+        bi->jump_out = false;
+        bi->jump_in = !(exec_bi && dominates(exec_bi, bi));
+    }
+    if (!bi->executed) {
+        bi->tcg(next_pc) = next_pc;
+        bi->cfg(next_pc) = next_pc;
+        bi->tcg(insns) = tcg_insns;
+        if (trace_file) {
+            const char *re = (retranslated ? "re" : "");
+            gzprintf(trace_file, "bbvgen: intv %"PRIu32
+                     ": %strans %"PRIu32" [%"PRIx64"..%"PRIx64"),%"PRIu32" <%s>\n",
+                     interval, re, bi->id, bi->pc, bi->tcg(next_pc), bi->tcg(insns),
+                     block_in_out_signature(bi, bi->jump_in));
+        }
+    }
+    return bi;
+}
+
+/*
+ * Blocks are only added, never removed. Isolated blocks are identical between
+ * TCG and CFG. Blocks only need icount adjustment for splice sequences and
+ * tilings.
+ *
+ * At block translation time, the CFG can change in these ways:
+ * * extend a splice sequence
+ * * augment a tiling group
+ *
+ * Later, at block execution time, we can bifurcate a splice sequence when we
+ * see mid-sequence block entered non-sequentially as a jump target.
+ */
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    const uint64_t pc = qemu_plugin_tb_vaddr(tb);
+    const uint32_t tcg_insns = qemu_plugin_tb_n_insns(tb);
+    /*
+     * plugin api won't tell us the size of the basic block directly :(
+     * but we can query the size of each instruction
+     */
+    uint64_t size = 0;
+    for (int i = 0; i < tcg_insns; i++) {
+        size += qemu_plugin_insn_size(qemu_plugin_tb_get_insn(tb, i));
+    }
+
+    g_mutex_lock(&lock);
+    BlockInfo *bi = fetch_block(pc, size, tcg_insns);
+    g_mutex_unlock(&lock);
+
+    /* Run the callback for this block's execution */
+    qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
+                                         QEMU_PLUGIN_CB_NO_REGS, bi);
+}
+
+/****************************************************************/
+/* process map */
+
+typedef struct {
+    uint64_t    start;
+    uint64_t    size;
+    char const *original_path;
+    char const *saved_path;
+} proc_map_entry;
+
+typedef struct {
+    uint64_t    fd;
+    char const *path;
+} fd_entry;
+
+static int so_save_fd = -1;
+
+static proc_map_entry *proc_map;
+static size_t proc_map_size;
+static int proc_map_sequence;
+
+static fd_entry *fd_map;
+static size_t fd_map_size;
+
+static size_t lower_bound_uint64(char const *haystack, size_t stride,
+                                 size_t element_count, uint64_t needle)
+{
+    size_t l = 0;
+    size_t h = element_count;
+    while (l < h) {
+        int mid =  l + (h - l) / 2;
+        if (memcmp(&needle, &haystack[mid * stride], sizeof(needle)) <= 0) {
+            h = mid;
+        } else {
+            l = mid + 1;
+        }
+    }
+    return l;
+}
+
+static void handle_fopen(uint64_t fd, char const *path)
+{
+    if (so_save_path == NULL) {
+        return;
+    }
+    size_t pos = lower_bound_uint64((char const *) fd_map, sizeof(fd_entry),
+                                    fd_map_size, fd);
+    if ((pos < fd_map_size) && fd_map[pos].fd == fd) {
+        /* don't bother handling close(), just update the entry instead */
+        free((void *) fd_map[pos].path);
+    } else {
+        fd_map = realloc(fd_map, (fd_map_size + 1) * sizeof(fd_entry));
+        memmove(&fd_map[pos + 1], &fd_map[pos],
+                (fd_map_size - pos) * sizeof(fd_entry));
+        ++fd_map_size;
+    }
+    fd_map[pos].fd = fd;
+    fd_map[pos].path = strdup(path);
+}
+
+static size_t add_entry_to_proc_map(uint64_t start, uint64_t size,
+                                    char const *original, char const *saved)
+{
+    /* find pos of target region in map */
+    size_t proc_map_pos = lower_bound_uint64((char const *) proc_map,
+                                             sizeof(proc_map_entry),
+                                             proc_map_size, start);
+    if ((proc_map_pos < proc_map_size) &&
+        (proc_map[proc_map_pos].start < (start + size)) &&
+        ((proc_map[proc_map_pos].start +
+          proc_map[proc_map_pos].size) > start)) {
+        fprintf(stderr, "bbvgen: mmap() call overlaps an existing memory map"
+                " entry for %s while attempting shared object tracking\n",
+                original);
+        exit(EXIT_FAILURE);
+    }
+    /* insert an entry into the map */
+    proc_map = realloc(proc_map, (proc_map_size + 1) * sizeof(proc_map_entry));
+    memmove(&proc_map[proc_map_pos + 1], &proc_map[proc_map_pos],
+            (proc_map_size - proc_map_pos) * sizeof(proc_map_entry));
+    ++proc_map_size;
+
+    proc_map[proc_map_pos].start = start;
+    proc_map[proc_map_pos].size = size;
+    proc_map[proc_map_pos].original_path = original;
+    proc_map[proc_map_pos].saved_path = saved;
+
+    return proc_map_pos;
+}
+
+static void handle_mmap_fd(uint64_t fd, uint64_t start, uint64_t size)
+{
+    if (so_save_path == NULL) {
+        return;
+    }
+    /* find file mapping in question */
+    size_t fd_pos = lower_bound_uint64((char const *) fd_map, sizeof(fd_entry),
+                                       fd_map_size, fd);
+    if ((fd_pos >= fd_map_size) || (fd_map[fd_pos].fd != fd)) {
+        return;
+    }
+    /* generate filename for the copy of the .so */
+    char save_target_path_buf[PATH_MAX];
+    pid_t me = getpid();
+    snprintf(save_target_path_buf, sizeof(save_target_path_buf),
+             "%d-%d.so", (int) me, proc_map_sequence);
+    ++proc_map_sequence;
+
+    size_t proc_map_pos = add_entry_to_proc_map(start, size,
+                                                strdup(fd_map[fd_pos].path),
+                                                strdup(save_target_path_buf));
+    /* copy the .so */
+    int srcfd = open(fd_map[fd_pos].path, O_RDONLY);
+    if (srcfd == -1) {
+        fprintf(stderr, "bbvgen: failed to open %s for reading (%s)\n",
+                fd_map[fd_pos].path, strerror(errno));
+        exit(EXIT_FAILURE);
+    }
+
+    int dstfd = openat(so_save_fd, save_target_path_buf,
+                       O_CREAT | O_TRUNC | O_WRONLY, 0700);
+    if (dstfd == -1) {
+        fprintf(stderr, "bbvgen: failed to open %s for writing"
+                " while trying to copy %s (%s)\n",
+                proc_map[proc_map_pos].saved_path, fd_map[fd_pos].path,
+                strerror(errno));
+        exit(EXIT_FAILURE);
+    }
+
+    char buf[65536];
+    for (;;) {
+        ssize_t r = read(srcfd, buf, sizeof(buf));
+        if (r == 0) {
+            break;
+        }
+        if (r == -1) {
+            fprintf(stderr, "bbvgen: read failure while trying to copy %s (%s)\n",
+                    fd_map[fd_pos].path, strerror(errno));
+            exit(EXIT_FAILURE);
+        }
+        ssize_t w = write(dstfd, buf, r);
+        if (w == -1) {
+            fprintf(stderr, "bbvgen: write failure while"
+                    " trying to copy %s to %s (%s)\n",
+                    fd_map[fd_pos].path, proc_map[proc_map_pos].saved_path,
+                    strerror(errno));
+            exit(EXIT_FAILURE);
+        }
+    }
+    close(dstfd);
+    close(srcfd);
+}
+
+static uint64_t write_memory_to_file(char const *dst, uint64_t start,
+                                     uint64_t size, off_t offset)
+{
+    int dstfd = openat(so_save_fd, dst, O_CREAT | O_WRONLY, 0600);
+    if (dstfd == -1) {
+        fprintf(stderr, "bbvgen: failed to open %s for writing anonymous"
+                " memory dump (%s)\n", dst, strerror(errno));
+        exit(EXIT_FAILURE);
+    }
+    off_t new_offset = -1;
+    if (offset == (off_t) -1) {
+        new_offset = lseek(dstfd, 0, SEEK_END);
+        if (new_offset == (off_t) -1) {
+            fprintf(stderr, "bbvgen: failed to seek to end of %s for writing"
+                    " anonymous memory dump (%s)\n", dst, strerror(errno));
+            exit(EXIT_FAILURE);
+        }
+    } else {
+        new_offset = lseek(dstfd, offset, SEEK_SET);
+        if (new_offset != offset) {
+            fprintf(stderr, "bbvgen: failed to seek within %s for updating"
+                    " anonymous memory dump (%s)\n", dst, strerror(errno));
+            exit(EXIT_FAILURE);
+        }
+    }
+    if (new_offset < 0) {
+        fprintf(stderr, "bbvgen: lseek within %s for updating anonymous memory"
+                " dump returned negative offset (%s)\n", dst, strerror(errno));
+        exit(EXIT_FAILURE);
+    }
+    if (write(dstfd, (void *) start, size) < 0) {
+        fprintf(stderr, "bbvgen: failed to write to %s while writing anonymous"
+                " memory dump (%s)\n", dst, strerror(errno));
+        exit(EXIT_FAILURE);
+    }
+    if (close(dstfd) < 0) {
+        fprintf(stderr, "bbvgen: failed to close %s after writing anonymous"
+                " memory dump (%s)\n", dst, strerror(errno));
+        exit(EXIT_FAILURE);
+    }
+    return (uint64_t) new_offset;
+}
+
+static void maybe_save_proc_map_entry(BlockInfo *bi)
+{
+    if (so_save_path == NULL) {
+        return;
+    }
+    uint64_t pc = bi->pc;
+    size_t proc_map_pos = lower_bound_uint64((char const *) proc_map,
+                                             sizeof(proc_map_entry),
+                                             proc_map_size, pc);
+    if ((proc_map_pos < proc_map_size) &&
+        (proc_map[proc_map_pos].start <= pc) &&
+        ((proc_map[proc_map_pos].start +
+          proc_map[proc_map_pos].size) > pc)) {
+        proc_map_entry const *pentry = &proc_map[proc_map_pos];
+        bi->so_path_original = pentry->original_path;
+        bi->so_path_saved = pentry->saved_path;
+        bi->so_pc = pentry->start;
+        if (pentry->original_path == anonymous_block_name) {
+            uint64_t size = bi->tcg(next_pc) - pc;
+            uint64_t bb_file_offset = write_memory_to_file(pentry->saved_path,
+                                                           pc, size, (off_t)-1);
+            /*
+             * record the file offset so we can later locate
+             * the basic block in the file for disassembly
+             */
+            bi->so_pc = bb_file_offset;
+        }
+    }
+}
+
+static void handle_mmap_anonymous(uint64_t start, uint64_t size)
+{
+    if (so_save_path == NULL) {
+        return;
+    }
+    add_entry_to_proc_map(start, size, anonymous_block_name,
+                          anonymous_save_filename);
+}
+
+static void handle_munmap(uint64_t start, uint64_t size)
+{
+    if (so_save_path == NULL) {
+        return;
+    }
+    size_t proc_map_pos = lower_bound_uint64((char const *) proc_map,
+                                             sizeof(proc_map_entry),
+                                             proc_map_size, start);
+    if (proc_map_pos >= proc_map_size) {
+        return;
+    }
+
+    if ((proc_map[proc_map_pos].start != start) ||
+        (proc_map[proc_map_pos].size != size)) {
+        if ((proc_map[proc_map_pos].start < (start + size)) &&
+            ((proc_map[proc_map_pos].start +
+              proc_map[proc_map_pos].size) > start)) {
+            fprintf(stderr, "bbvgen: munmap() call overlaps"
+                    " but does not exactly match entry for %s"
+                    " while attempting shared object tracking\n",
+                    proc_map[proc_map_pos].original_path);
+            exit(EXIT_FAILURE);
+        }
+        return;
+    }
+
+    --proc_map_size;
+    /*
+     * leak the paths: they're small, there's not many of them over the
+     * process lifetime and it's the easiest way to deal with BlockInfo
+     * wanting to refer to them
+     * free(proc_map[proc_map_pos].original_path);
+     * free(proc_map[proc_map_pos].saved_path);
+     */
+    memmove(&proc_map[proc_map_pos], &proc_map[proc_map_pos + 1],
+            (proc_map_size - proc_map_pos) * sizeof(proc_map_entry));
+}
+
+/*
+ * Called on the child process after a fork. Resets counts and opens new
+ * output files with the child pid appended to the filename.
+ */
+
+static void reset_all_counters();
+static void fork_output_files();
+
+static void handle_fork_child(void)
+{
+    fork_output_files();
+    reset_all_counters();
+}
+
+typedef struct {
+    int64_t num;
+    uint64_t a1;
+    uint64_t a2;
+    uint64_t a3;
+    uint64_t a4;
+    uint64_t a5;
+    uint64_t a6;
+    uint64_t a7;
+    uint64_t a8;
+} syscall_params;
+
+static _Thread_local syscall_params last_syscall_params = {0};
+
+static int64_t clone_syscall_num = -1;
+static int64_t openat_syscall_num = -1;
+static int64_t mmap_syscall_num = -1;
+static int64_t munmap_syscall_num = -1;
+
+#ifdef __linux__
+static void vcpu_syscall(qemu_plugin_id_t id, unsigned int vcpu_idx,
+                         int64_t num, uint64_t a1, uint64_t a2,
+                         uint64_t a3, uint64_t a4, uint64_t a5,
+                         uint64_t a6, uint64_t a7, uint64_t a8)
+{
+    last_syscall_params.num = num;
+    last_syscall_params.a1 = a1;
+    last_syscall_params.a2 = a2;
+    last_syscall_params.a3 = a3;
+    last_syscall_params.a4 = a4;
+    last_syscall_params.a5 = a5;
+    last_syscall_params.a6 = a6;
+    last_syscall_params.a7 = a7;
+    last_syscall_params.a8 = a8;
+}
+#endif
+
+static void vcpu_syscall_ret(qemu_plugin_id_t id, unsigned int vcpu_idx,
+                             int64_t num, int64_t ret)
+{
+    if (num == clone_syscall_num) {
+        if (ret != 0) {
+            return;
+        }
+#ifdef CONFIG_M5
+        if (m5ops) {
+            return;
+        }
+#endif
+#ifdef __linux__
+        if ((last_syscall_params.num == clone_syscall_num)
+            && (last_syscall_params.a1 & CLONE_VM)) {
+            /*
+             * We're sharing memory with the parent - it's a new thread, not a
+             * new process.  leave counters alone so they can contribute to
+             * parent.
+             */
+            return;
+        }
+#endif
+        /* We are officialy the child process in a fork that's returning. */
+        handle_fork_child();
+        return;
+    }
+
+    if (so_save_path == NULL || (last_syscall_params.num != num)) {
+        return;
+    }
+
+    if (num == openat_syscall_num) {
+        /*
+         * catch opening a file with an absolute path (as the dynamic library
+         * loader does) so we can update our map of file descriptor ->
+         * filename.
+         */
+        if ((ret < 0)
+            || (last_syscall_params.a1 != AT_FDCWD)
+            || (last_syscall_params.a2 == 0)
+            || ((*(char const *) last_syscall_params.a2) != '/')
+            ) {
+            return;
+        }
+
+        g_mutex_lock(&lock);
+        /*
+         * FIXME: this only works in user mode, we need access to qemu's
+         * address mapping functions for system!
+         */
+        handle_fopen(ret, (char const *) last_syscall_params.a2);
+        g_mutex_unlock(&lock);
+        return;
+    }
+
+    if (num == mmap_syscall_num) {
+        /*
+         * we handle executable memory mappings of files by taking a copy of
+         * the file, recording the original and copy filenames and where the
+         * file is mapped.
+         */
+        if ((ret != -1)
+            && (last_syscall_params.a1 == 0)
+            && (last_syscall_params.a2 != 0)
+            && ((last_syscall_params.a3 & (PROT_EXEC | PROT_READ | PROT_WRITE))
+                == (PROT_EXEC | PROT_READ))
+            && !(last_syscall_params.a4 & MAP_FIXED)
+            && (last_syscall_params.a5 != -1)
+            && (last_syscall_params.a6 == 0))
+        {
+            g_mutex_lock(&lock);
+            handle_mmap_fd(last_syscall_params.a5, ret,
+                           last_syscall_params.a2);
+            g_mutex_unlock(&lock);
+        }
+        /*
+         * we also handle anonymous fixed address blocks as used by the
+         * openjdk jit compiler by appending them to a file and recording the
+         * offset
+         */
+        if ((last_syscall_params.a1 == ret)
+            && (last_syscall_params.a2 > 0)
+            && ((last_syscall_params.a3 & (PROT_EXEC | PROT_READ)) ==
+                (PROT_EXEC | PROT_READ))
+            && (last_syscall_params.a4 & MAP_FIXED)
+            && (last_syscall_params.a5 == -1)
+            && (last_syscall_params.a6 == 0))
+        {
+            g_mutex_lock(&lock);
+            handle_mmap_anonymous(ret, last_syscall_params.a2);
+            g_mutex_unlock(&lock);
+        }
+        return;
+    }
+
+    if (num == munmap_syscall_num) {
+        if (ret == 0) {
+            g_mutex_lock(&lock);
+            handle_munmap(last_syscall_params.a1, last_syscall_params.a2);
+            g_mutex_unlock(&lock);
+        }
+        return;
+    }
+}
+
+/****************************************************************/
+
+static gint cmp_pc(gconstpointer a, gconstpointer b)
+{
+    uint64_t pca = GPOINTER_TO_UINT(a);
+    uint64_t pcb = GPOINTER_TO_UINT(b);
+    return pca < pcb ? -1 : 1;
+}
+
+static void plugin_init(const char *target)
+{
+    if (g_strcmp0(target, "riscv64") == 0 ||
+        g_strcmp0(target, "aarch64") == 0) {
+        clone_syscall_num = 220;
+        openat_syscall_num = 56;
+        mmap_syscall_num = 222;
+        munmap_syscall_num = 215;
+    } else if (g_strcmp0(target, "x86_64") == 0) {
+        clone_syscall_num = 56;
+        /*
+         * Don't support dynamic libs on x86 for now
+         * (need to hook open instead of openat)
+         */
+        free((void *) so_save_path);
+        so_save_path = NULL;
+        /* open_syscall_num = 2; */
+        /* mmap_syscall_num = 9; */
+        /* munmap_syscall_num = 11; */
+    } else {
+        printf("%s:%d: Unhandled target! Please fix!\n", __FILE__, __LINE__);
+    }
+
+    if (so_save_path) {
+        so_save_fd = open(so_save_path, O_DIRECTORY);
+        if (so_save_fd == -1 && errno == ENOENT) {
+            /* Make a simple attempt to create a non-existent directory. There
+               are plenty of ways this might fail, and we could work harder,
+               similar to the shell command `mkdir -p', but it's not worth the
+               effort. Let the user intervene and fix it if we fail here. */
+            mkdir(so_save_path, 0777);
+            so_save_fd = open(so_save_path, O_DIRECTORY);
+        }
+        if (so_save_fd == -1) {
+            fprintf(stderr, "bbvgen: failed to open dir %s (%s)\n",
+                    so_save_path, strerror(errno));
+            exit(EXIT_FAILURE);
+        }
+        char save_target_path_buf[PATH_MAX];
+        pid_t me = getpid();
+        snprintf(save_target_path_buf, sizeof(save_target_path_buf),
+                 "anonymous-%d.dump", (int)me);
+        anonymous_save_filename = strdup(save_target_path_buf);
+    }
+
+    blocks_pc_table = g_hash_table_new(NULL, NULL);
+    blocks_next_pc_table = g_hash_table_new(NULL, NULL);
+    blocks_id_array = g_ptr_array_sized_new(4096);
+    blocks_pc_tree = g_tree_new(cmp_pc);
+}
+
+static void roi_begin(void)
+{
+    begin_output_files(BBV_TCG);
+    begin_output_files(BBV_CFG);
+    enabled = true;
+}
+
+static void roi_end(void)
+{
+    enabled = false;
+    /*
+     * Flush the partial interval that was in progress when the
+     * program exited.
+     */
+    end_interval();
+}
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    roi_end();
+    qemu_plugin_register_vcpu_tb_trans_cb(id, NULL);
+}
+
+#ifdef CONFIG_M5
+static void handle_m5op(qemu_plugin_id_t id, unsigned int vcpu_index,
+                        uint32_t m5op_num)
+{
+    switch (m5op_num) {
+    case M5OP_WORK_BEGIN:
+        roi_begin();
+        break;
+    case M5OP_WORK_END:
+        roi_end();
+        break;
+    default:
+        return;
+    }
+}
+#endif
+
+/*
+ * These are simplified versions of the qemu/cutils functions, for sake of
+ * nicer error-case control flow, and for stifling scripts/checkpatch.pl
+ */
+
+static int qemu_strtou64(const char *nptr, char **endptr, int base,
+                         uint64_t *result)
+{
+    char *ep;
+    errno = 0;
+    *result = strtoull(nptr, &ep, base);
+    if (*ep) {
+        errno = EINVAL;
+    }
+    if (endptr) {
+        *endptr = ep;
+    }
+    /* Windows returns 1 for negative out-of-range values.  */
+    if (errno == ERANGE) {
+        *result = ~0;
+    }
+    return errno;
+}
+
+static int qemu_strtoui(const char *nptr, char **endptr, int base,
+                        unsigned int *result)
+{
+    char *ep;
+    errno = 0;
+    long lresult = strtoull(nptr, &ep, base);
+    *result = (unsigned int) lresult;
+    if (*ep) {
+        errno = EINVAL;
+    }
+    if (endptr) {
+        *endptr = ep;
+    }
+    /* Windows returns 1 for negative out-of-range values.  */
+    if (errno == ERANGE) {
+        *result = ~0;
+    }
+    return errno;
+}
+
+char *strdup_gz(const char *path, const char *opt_name)
+{
+    int length = strlen(path);
+    if (strcmp(path + length - 3, ".gz")) {
+        fprintf(stderr, "bbvgen: invalid gzip path name: %s=%s\n", opt_name, path);
+        return NULL;
+    }
+    return strdup(path);
+}
+
+QEMU_PLUGIN_EXPORT
+int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
+                        int argc, char **argv)
+{
+    if (info->system_emulation) {
+        fprintf(stderr, "bbvgen: only user mode is supported\n");
+        return -1;
+    }
+    int opt_errors = 0;
+    for (int i = 0; i < argc; i++) {
+        char *opt = argv[i];
+        g_autofree char **tokens = g_strsplit(opt, "=", 2);
+        if (g_strcmp0(tokens[0], "bbv") == 0) {
+            cfg(bbv_path) = strdup_gz(tokens[1], tokens[0]);
+            if (cfg(bbv_path) == NULL) {
+                opt_errors++;
+            }
+        } else if (g_strcmp0(tokens[0], "bbv_tcg") == 0) {
+            tcg(bbv_path) = strdup_gz(tokens[1], tokens[0]);
+            if (cfg(bbv_path) == NULL) {
+                opt_errors++;
+            }
+        } else if (g_strcmp0(tokens[0], "bbvi") == 0) {
+            cfg(bbvi_path) = strdup_gz(tokens[1], tokens[0]);
+            if (cfg(bbv_path) == NULL) {
+                opt_errors++;
+            }
+        } else if (g_strcmp0(tokens[0], "bbvi_tcg") == 0) {
+            tcg(bbvi_path) = strdup_gz(tokens[1], tokens[0]);
+            if (cfg(bbv_path) == NULL) {
+                opt_errors++;
+            }
+        } else if (g_strcmp0(tokens[0], "trace") == 0) {
+            qemu_bbv_trace_path = strdup_gz(tokens[1], tokens[0]);
+            if (qemu_bbv_trace_path == NULL) {
+                opt_errors++;
+            }
+        } else if (g_strcmp0(tokens[0], "so_save_path") == 0) {
+            so_save_path = strdup(tokens[1]);
+        } else if (g_strcmp0(tokens[0], "ilen") == 0) {
+            if (qemu_strtou64(tokens[1], NULL, 0, &qemu_bbv_interval)) {
+                fprintf(stderr, "bbvgen: invalid integer value: %s\n", opt);
+                opt_errors++;
+            }
+        } else if (g_strcmp0(tokens[0], "nblocks") == 0) {
+            if (qemu_strtoui(tokens[1], NULL, 0, &qemu_bbv_blocks)) {
+                fprintf(stderr, "bbvgen: invalid integer value: %s\n", opt);
+                opt_errors++;
+            }
+        } else if (g_strcmp0(tokens[0], "trace_exec") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &trace_exec)) {
+                fprintf(stderr, "bbvgen: invalid boolean value: %s\n", opt);
+                opt_errors++;
+            }
+        } else if (g_strcmp0(tokens[0], "nextpc") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &print_next_pc)) {
+                fprintf(stderr, "bbvgen: invalid boolean value: %s\n", opt);
+                opt_errors++;
+            }
+#ifdef CONFIG_M5
+        } else if (g_strcmp0(tokens[0], "m5ops") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &m5ops)) {
+                fprintf(stderr, "bbvgen: invalid boolean value: %s\n", opt);
+                opt_errors++;
+            }
+#endif
+        } else if (g_strcmp0(tokens[0], "hexaddrs") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &hex_addrs)) {
+                fprintf(stderr, "bbvgen: invalid boolean value: %s\n", opt);
+                opt_errors++;
+            }
+        } else {
+            fprintf(stderr, "bbvgen: unknown option: %s\n", opt);
+            opt_errors++;
+        }
+    }
+
+    if (t[BBV_CFG].bbv_path == NULL && t[BBV_CFG].bbvi_path == NULL) {
+        fprintf(stderr, "bbvgen: warning: neither output argument"
+                " \"bbv=<path>\" nor \"bbvi=<path>\" was specified\n");
+    }
+    const char *qemu_bbv_interval_str = "QEMU_BBV_INTERVAL";
+    char *opt = getenv(qemu_bbv_interval_str);
+    if (opt && qemu_strtou64(opt, NULL, 0, &qemu_bbv_interval)) {
+        fprintf(stderr, "bbvgen: invalid integer value: %s=%s\n",
+                qemu_bbv_interval_str, opt);
+        opt_errors++;
+    }
+    const char *qemu_bbv_blocks_str = "QEMU_BBV_BLOCKS";
+    opt = getenv(qemu_bbv_blocks_str);
+    if (opt && qemu_strtoui(opt, NULL, 0, &qemu_bbv_blocks)) {
+        fprintf(stderr, "bbvgen: invalid integer value: %s=%s\n",
+                qemu_bbv_blocks_str, opt);
+        opt_errors++;
+    }
+    const char *qemu_bbv_trace_str = "QEMU_BBV_TRACE";
+    opt = getenv(qemu_bbv_trace_str);
+    if (opt != NULL) {
+        qemu_bbv_trace_path = strdup_gz(opt, qemu_bbv_trace_str);
+        if (qemu_bbv_trace_path == NULL) {
+            opt_errors++;
+        }
+    }
+    if (opt_errors) {
+        return -1;
+    }
+    if (qemu_bbv_trace_path) {
+        trace_file = gzopen(qemu_bbv_trace_path, "wb9");
+        if (trace_file == Z_NULL) {
+            fprintf(stderr, "bbvgen: cannot open `%s' for compressed"
+                    " writing (%s)\n", qemu_bbv_trace_path, strerror(errno));
+            free(qemu_bbv_trace_path);
+            qemu_bbv_trace_path = NULL;
+        }
+    }
+    plugin_init(info->target_name);
+
+#ifdef __linux__
+    qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall);
+#endif
+    qemu_plugin_register_vcpu_syscall_ret_cb(id, vcpu_syscall_ret);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+#ifdef CONFIG_M5
+    if (m5ops) {
+        qemu_plugin_register_vcpu_m5op_cb(id, handle_m5op);
+    } else
+#endif
+    {
+       roi_begin();
+    }
+    return 0;
+}
diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 3028d5fff7..ea8d33b267 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -496,6 +496,75 @@ The hotpages plugin can be configured using the following arguments:
   * - pagesize=N
     - The page size used. (Default: N = 4096)
 
+Basic Block Vectors
+...................
+
+``contrib/plugins/bbvgen.c``
+
+The bbvgen.c plugin is a much more accurate basic-block analyzer than
+bb.c, and a more sophisticated hot path analyzer than hotblocks.c
+
+  $ qemu-riscv64 $(QEMU_ARGS) \
+    -plugin contrib/plugins/libbbvgen.so,ilen=200000000,nblocks=200,bbv=bbv.gz,bbvi=bbvi.gz
+
+  * ilen=N (default = 200,000,000)
+
+  Divide counts into intervals of N instructions. Since interval
+  divisions occur at block boundaries, an interval might cover a few
+  more or fewer instructions than N.
+
+  * nblocks=N (default = 200)
+
+  The topblocks report contains the N most executed blocks. Block
+  counts are weighted as EXECS * INSNS, where EXECS is the number of
+  times the block executed, and INSNS is the number of instructions in
+  the block.
+
+  * bbv=PATH.gz
+
+  Output simple CFG block-count data into gzip stream in PATH.gz.
+
+  * bbv_tcg=PATH.gz
+
+  Output simple TCG block-count data into gzip stream in PATH.gz.
+
+  * bbvi=PATH.gz
+
+  Output richer CFG block-count data as JSON into gzip stream in PATH.gz.
+
+  * bbvi_tcg=PATH.gz
+
+  Output richer TCG block-count data as JSON into gzip stream in PATH.gz.
+
+  * trace=PATH.gz
+
+  Output debug traces whenever as TCG blocks are translated and
+  transformed to CFG blocks.
+
+  * trace_exec=BOOL
+
+  Augment the debug trace with a line for every time a TCG block is
+  executed. This greatly expands the trace file size.
+
+  * hexaddrs=BOOL
+
+  Print addresses as hex numbers in the JSON outputs. These are nicer
+  for correlating with disassembled code listings, but require
+  JSON5 parsers, which are typically much slower than standard JSON.
+
+  * nextpc=BOOL
+
+  Whenever a block's PC appears in the JSON output, also print its
+  NEXT_PC to fully explicate the block's range as [PC..NEXT_PC).
+
+  * so_save_path=DIR
+
+  Save all dynamically-linked objects in directory DIR. For each block
+  that resides in a shared object, print its filename and location in
+  the BBVI file. This info is used to produce a report annotated with
+  disassembled listings of hot blocks. Statically linked guest
+  programs do not need this option.
+
 Instruction Distribution
 ........................
 
diff --git a/scripts/process_bbvi.py b/scripts/process_bbvi.py
new file mode 100755
index 0000000000..09c5e88130
--- /dev/null
+++ b/scripts/process_bbvi.py
@@ -0,0 +1,385 @@
+#!/usr/bin/env python3
+#
+# Copyright (c) 2022 by Rivos Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, see <http://www.gnu.org/licenses/>.
+
+"""Processes BBV info files from QEMU"""
+
+import argparse
+import gzip
+import json
+import pathlib
+import sys
+import os
+import shutil
+import subprocess
+
+
+if sys.stdout.isatty():
+    # ANSI Escape sequence for colors
+    RED = "\033[31;1m"
+    BOLD = "\033[1m"
+    BBLUE = "\033[94m"
+    GREEN = "\033[32m"
+    NORM = "\033[0m"
+else:
+    # No color for logging to files
+    RED = ""
+    BOLD = ""
+    BBLUE = ""
+    GREEN = ""
+    NORM = ""
+
+
+def find_tool(arch, tool):
+    patterns = (f"{arch}-unknown-linux-gnu-{tool}", f"{arch}-linux-gnu-{tool}")
+    return next(filter(lambda p: shutil.which(p) is not None, patterns), None)
+
+
+def find_objdump(arch):
+    return find_tool(arch, "objdump")
+
+
+def find_addr2line(arch):
+    return find_tool(arch, "addr2line")
+
+
+def find_sources(arch, dump_lines, binary):
+    a2ltool = find_addr2line(arch)
+    if a2ltool is None:
+        raise Exception(f'Can\'t find addr2line for "{arch}" in $PATH')
+
+    addrs = {
+        int(a.split(":")[0].strip(), 16): a.strip()
+        for a in dump_lines
+        if a.strip() != "..."
+    }
+    if len(addrs) == 0:
+        return {}
+    # Get function names and file/line numbers
+    ret = subprocess.run(
+        [a2ltool, "-C", "-f", "-e", binary] + [hex(a) for a in addrs.keys()],
+        capture_output=True,
+        check=True,
+    )
+    lines = [l.strip() for l in ret.stdout.decode("utf-8", "strict").split("\n")]
+    functions = {}
+    for ad, func, file_line in zip(addrs.keys(), lines[0::2], lines[1::2]):
+        path, line = file_line.split(":")
+        if line == "?":
+            continue
+        if "discriminator" in line:
+            line = line.split(" ")[0]
+        line_num = int(line) - 1
+        key = (path, func)
+        if key in functions:
+            functions[key][0] = min(functions[key][0], line_num)
+            functions[key][1] = max(functions[key][1], line_num)
+            functions[key][2].setdefault(line_num, []).append(addrs[ad])
+        else:
+            functions[key] = [line_num, line_num, {line_num: [addrs[ad]]}]
+    return functions
+
+
+# Example nix build path: /build/build/benchspec/CPU/999.specrand_ir/build/build_base_rivos-m64.0000/specrand-common/specrand.c
+# Want: /nix/store/dbklj8316vq409839k5dfs4gqv1554qp-cpu2017-1.1.7/benchspec/CPU/999.specrand_ir/src/specrand-common/specrand.c
+def guess_correct_source_path(src_path, src_paths):
+    src_path = pathlib.Path(src_path)
+
+    if src_path.exists():
+        return src_path
+
+    src_paths = src_paths.split(":")
+    src_paths = [pathlib.Path(p) for p in src_paths]
+
+    for candidate_src in src_paths:
+        # Keep on stripping off parts of the build dir until we find the right
+        # subtree in the src path.
+        src_path_relative = src_path.parts[1:]
+        while len(src_path_relative) >= 1:
+            combined_path = candidate_src.joinpath(*src_path_relative)
+            if combined_path.exists():
+                return combined_path
+
+            src_path_relative = src_path_relative[1:]
+
+    # Not found, fallback on original (missing) path
+    return src_path
+
+
+# number of lines of context around the dumped sources
+CONTEXT = 3
+
+
+def dump_sources(arch, disassembly, binary, src_paths):
+    functions = find_sources(arch, disassembly, binary)
+
+    lines = []
+    for (fpath, func), (l_min, l_max, asm) in functions.items():
+        fname = os.path.basename(fpath)
+        lines.append("")
+        lines.append(f"{BBLUE}/* ... {func} in {fname} ... */{NORM}")
+        fpath = guess_correct_source_path(fpath, src_paths)
+        try:
+            with open(fpath, "r") as f:
+                contents = f.readlines()
+        except Exception as e:
+            lines.append(str(fpath))
+            lines.append(f"/* --- NOT FOUND --- */ /* at {fpath} */")
+            continue
+        for lnum in range(
+            max(0, l_min - CONTEXT), min(l_max + CONTEXT, len(contents) - 1) + 1
+        ):
+            disasm = asm.setdefault(lnum, [""])
+            code = contents[lnum][:-1].replace("\t", "  ")
+            color = BOLD if lnum >= l_min and lnum <= l_max else NORM
+            lines.append(
+                "{:4}:{}{:<82}{} > {}{}{}".format(
+                    lnum + 1, color, code, NORM, GREEN, disasm[0], NORM
+                )
+            )
+            if len(disasm) > 1:
+                lines.extend([" " * 88 + f"| {GREEN}" + d + NORM for d in disasm[1:]])
+
+    return lines
+
+
+def disass_range(binary, start_addr, count, arch, pfxlines=6):
+    distool = find_objdump(arch)
+    if distool is None:
+        raise Exception(f'Can\'t find objdump for "{arch}" in $PATH')
+
+    try:
+        # Reduce unneeded output by constructing a pessimistic end
+        # address, considering the "fanciest" architectures we might
+        # be dealing with.
+        end_addr = start_addr + 15 * count
+        ret = subprocess.run(
+            [
+                distool,
+                "-d",
+                "-C",
+                "--start-address",
+                hex(start_addr),
+                "--stop-address",
+                hex(end_addr),
+                binary,
+            ],
+            capture_output=True,
+            check=True,
+        )
+    except:
+        raise Exception("Failure during disassembly")
+
+    # Trim down to just the label and the basic block;
+    # hopefully safe assumption about objdump output format.
+    lines = ret.stdout.decode("utf-8", "strict").splitlines()[pfxlines:]
+    # It's not safe (in some awesome architectures) to assume each
+    # line after the prefix represents an instruction.
+    # GNU objdump goes to a new line after 7 bytes of opcodes.
+    # We need to compensate for multi-line instructions.
+    # Keep only the line with the disassembly which has 3 columns.
+    inst_lines = [x for x in lines[1:] if len(x.split("\t")) > 2]
+    return lines[0:1] + inst_lines[:count]
+
+
+def process_weights(weights, bbvinfo):
+    weighted_blocks = {}
+    for interval, weight in weights:
+        blocks = bbvinfo["intervals"][interval]["blocks"]
+        for block in blocks:
+            index = block["pc"]
+            if index not in weighted_blocks:
+                weighted_blocks[index] = 0.0
+            weighted_blocks[index] += weight * block["icount"]
+    return sorted(weighted_blocks.items(), key=lambda item: item[1], reverse=True)
+
+
+def load_simpoint_info(simpoints_path, weights_path):
+    regions = []
+    weights = []
+
+    # Like gem5, we ignore the 'index' column in both files. The only
+    # error is if the files have different lengths; the lines are
+    # assumed to correspond, and the "region" indexing starts at 0 and
+    # increments for each line.
+    if simpoints_path and simpoints_path.exists():
+        with open(simpoints_path) as fs:
+            for line in fs:
+                (interval, index) = line.split(" ")
+                regions.append(int(interval))
+
+        if weights_path and weights_path.exists():
+            with open(weights_path) as fw:
+                for line in fw:
+                    (weight, index) = line.split(" ")
+                    weights.append((int(interval), float(weight)))
+
+            if len(regions) > 0 and len(regions) != len(weights):
+                raise Exception("Mismatched length of simpoints and weights files")
+
+    return (regions, weights)
+
+
+def print_one_stats_line(label, misses, accesses):
+    percent = 0 if accesses == 0 else (misses * 100 / accesses)
+    print(f"%-10s miss rate: %10.6f%% {misses}/{accesses}" % (label, percent))
+
+
+def print_cache_stats(stats):
+    print_one_stats_line(
+        "l1-inst", stats["l1-inst"]["misses"], stats["l1-inst"]["accesses"]
+    )
+    print_one_stats_line(
+        "l1-data", stats["l1-data"]["misses"], stats["l1-data"]["accesses"]
+    )
+    if "l2-inst" in stats and "l2-data" in stats:
+        print_one_stats_line(
+            "l2-inst", stats["l2-inst"]["misses"], stats["l2-inst"]["accesses"]
+        )
+        print_one_stats_line(
+            "l2-data", stats["l2-data"]["misses"], stats["l2-data"]["accesses"]
+        )
+        print_one_stats_line(
+            "l2-total",
+            stats["l2-data"]["misses"] + stats["l2-inst"]["misses"],
+            stats["l2-data"]["accesses"] + stats["l2-inst"]["accesses"],
+        )
+
+
+def main():
+    parser = argparse.ArgumentParser(description=__doc__)
+    parser.add_argument("--simpoints", help="simpoints file", type=pathlib.Path)
+    parser.add_argument("--cache", help="cache stats", action="store_true")
+    parser.add_argument("--weights", help="simpoints weights file", type=pathlib.Path)
+    parser.add_argument(
+        "--bin", help="binary file to use for disassembly", type=pathlib.Path
+    )
+    parser.add_argument(
+        "--arch", help="architecture of the binary", type=str, default="riscv64"
+    )
+    parser.add_argument(
+        "--region", help="process the blocks for a single region", type=int, default=-1
+    )
+    parser.add_argument(
+        "--simpoint",
+        help="process the blocks for a single simpoint",
+        type=int,
+        default=-1,
+    )
+    parser.add_argument(
+        "--srcs_path",
+        help="paths to use for source code lookup, separated by colons",
+        type=str,
+        default="",
+    )
+    parser.add_argument("bbvi", help="BBV Info gzip file", type=pathlib.Path)
+    args = parser.parse_args()
+
+    # Try to open the BBV info file; nothing else works without that.
+    try:
+        with gzip.open(args.bbvi) as fin:
+            bbvinfo = json.load(fin)
+    except:
+        print("Can't open the BBV info file")
+        sys.exit(1)
+
+    # The simpoints file is needed for (1) simpoint index to region
+    # number mapping and (2) projecting overall top blocks from a
+    # weighted sum of the top simpoint regions. The weights file is
+    # only required for the latter computation.
+    (regions, weights) = load_simpoint_info(args.simpoints, args.weights)
+
+    do_global = args.region == -1 and args.simpoint == -1
+    do_weights = len(weights) > 0 and do_global
+    do_disasm = args.bin is not None
+    do_cache = args.cache
+
+    if args.simpoint != -1:
+        if len(regions) == 0:
+            print("Selecting a simpoint requires providing the simpoint/weights files")
+            sys.exit(1)
+        elif len(regions) <= args.simpoint:
+            print("Illegal simpoint index was provided")
+            sys.exit(1)
+        args.region = regions[args.simpoint]
+        print(f"Simpoint {args.simpoint} corresponds to interval/region {args.region}")
+    elif args.region != -1:
+        if len(bbvinfo["intervals"]) <= args.region:
+            print("Illegal region number was provided")
+            sys.exit(1)
+
+    if do_cache:
+        if not "cache-stats" in bbvinfo:
+            print("BBVI has no cache stats!")
+            sys.exit(1)
+        if do_global:
+            print("\nCache statistics for entire run:")
+            print_cache_stats(bbvinfo["cache-stats"])
+        else:
+            print(f"\nCache statistics for region {args.region}:")
+            print_cache_stats(bbvinfo["intervals"][args.region]["cache-stats"])
+
+    if do_weights:
+        print("\nComputing top blocks according to simpoint weights")
+        weighted_blocks = process_weights(weights, bbvinfo)
+        print("\nTop blocks by simpoint weights, and directly from full execution:")
+        for index, block in enumerate(bbvinfo["blocks"]):
+            if index == len(weighted_blocks):
+                break
+            print(index, hex(block["pc"]), hex(weighted_blocks[index][0]))
+
+    if do_disasm:
+        if not args.bin.exists():
+            print(f"Bad path to binary: {args.bin}")
+            sys.exit(1)
+
+        if do_global:
+            print(f"\nDisassembling the top blocks in {args.bin.name}:")
+            blocks = bbvinfo["blocks"]
+        else:
+            print(
+                f"\nDisassembling the top blocks for region {args.region} in {args.bin.name}:"
+            )
+            blocks = bbvinfo["intervals"][args.region]["blocks"]
+
+        coverage = sum(float(b["pct"]) for b in blocks)
+        print(
+            "\nTop blocks account for %2.f%% of the %s"
+            % (coverage, "run" if do_global else "region")
+        )
+
+        # For the overall top blocks, get the disassembly
+        for ind, block in enumerate(blocks):
+            try:
+                lines = disass_range(
+                    args.bin, block["pc"], block["len"], args.arch
+                )
+                lines.extend(
+                    dump_sources(args.arch, lines[1:], args.bin, args.srcs_path)
+                )
+            except Exception as e:
+                print(e)
+                sys.exit(1)
+            # emit the unweighted instruction count too
+            invoke = int(block["icount"] / block["len"])
+            print(
+                f'\nBlock {ind} @ {hex(block["pc"])}, {block["len"]} insns, {invoke} times, {block["pct"]}%:\n'
+            )
+            print("\n".join(lines))
+
+
+if __name__ == "__main__":
+    main()
-- 
2.34.1


