Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01BF606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OhBWXaXQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTeiA-0002Rd-7f; Wed, 18 Nov 2026 07:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTei3-0002Pl-4a
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTehx-0004Xp-7q
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795004652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=64+Yh2kODlH50OrDVk3jm8+eGtaU/88vpKC9do3T0E4=;
 b=OhBWXaXQ4iZH6MEaesKiwyhlsG4S1uIRrP/WDn9blU49XzCDDXbNeAoc1GX5D7N84cEmC3
 wu3OyJTgPzI8lY87IH+mm74FhGepqJE+ZQuiE0cOUl60jvWrSUO0Hzp1Y+/cz4oC4D0ihp
 S6pIJKTapnTlXog++L1x5qcf5JsM8Ek=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-jN1GM58iMGCkQ1wgO7Ne9w-1; Wed,
 18 Nov 2026 07:24:11 -0500
X-MC-Unique: jN1GM58iMGCkQ1wgO7Ne9w-1
X-Mimecast-MFC-AGG-ID: jN1GM58iMGCkQ1wgO7Ne9w_1795004650
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 249AC1800359
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:10 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4291E18004FC
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:09 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 09/26] target/i386/tcg: generate the decoder program and
 rows
Date: Wed, 18 Nov 2026 13:23:40 +0100
Message-ID: <20261118122357.659634-10-pbonzini@redhat.com>
In-Reply-To: <20261118122357.659634-1-pbonzini@redhat.com>
References: <20261118122357.659634-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add maketable_codegen.py, which lowers the trie to bytecode in
tcg/decode-new.h and writes a header, replacing the
C code in tcg/decode-new.c.inc, with an array of X86OpEntry rows
and the program.

Each step has a kind (UD, RET, JMP, FETCH, MATCH, SELECT, SWITCH, SET),
a selector (opcode byte, ModRM.reg/rm/mod, mandatory prefix, encoding,
W, L, 64-bit mode, ND, NF, CPUID feature), an 8-bit argument and a
16-bit target.  MATCH combines a test with jump-if-false, while SELECT
and SWITCH are N-way branches to consecutive rows or steps.  SET
overrides W, L or ModRM.mod, for WIG/LIG and MOV to/from CR/DR.

Each node of the trie then becomes an OP_SELECT if all its children are
leaves, and otherwise an OP_SWITCH whose table has an OP_RET, OP_UD,
OP_SELECT or OP_JMP for each value; values after the last valid one are
left out.

The bytecode is compact (4 byte per instruction, of which every
opcode uses on average 3), and it implements several checks that are
currently encoded in X86OpEntry, thus making it smaller as well.
Overall, both data and text are reduced by ~5k compared to the
current hand-written approach.

The tests run the generated program with a Python copy of the
interpreter, and check that it decodes the same entries as the trie.

AI-used-for: code, tests
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h              | 147 ++++++++++++
 target/i386/tcg/decode.def                |   3 +-
 target/i386/tcg/maketable.py              |  24 +-
 target/i386/tcg/maketable_codegen.py      | 261 ++++++++++++++++++++++
 target/i386/tcg/meson.build               |  13 +-
 target/i386/tcg/test_maketable_codegen.py | 245 ++++++++++++++++++++
 6 files changed, 688 insertions(+), 5 deletions(-)
 create mode 100644 target/i386/tcg/maketable_codegen.py
 create mode 100644 target/i386/tcg/test_maketable_codegen.py

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index a1cfb1995c6..cd4bb360c2d 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -295,6 +295,153 @@ typedef struct X86OpEntry  X86OpEntry;
 typedef struct X86DecodedInsn X86DecodedInsn;
 struct DisasContext;
 
+/*
+ * Bytecode for the opcode decoder.
+ *
+ * Decoding the opcode runs a small program that starts after the legacy,
+ * REX, REX2, VEX and EVEX prefixes have been consumed, and that walks a
+ * trie whose leaves are rows of a table of X86OpEntry structs.  There is
+ * one entry point for each opcode map: 0 for the one-byte opcodes, 1 for
+ * 0F, 2 for 0F38, 3 for 0F3A and 4-7 for the EVEX maps.  The bytecode
+ * interpreter is invoked from X86DecodeFuncs.
+ *
+ * The program can look at:
+ * - b, the last opcode byte that was fetched
+ * - the ModRM byte, which is fetched the first time the program needs it
+ * - the mandatory prefix, the encoding and the W, L, ND and NF bits
+ * - the processor mode and the CPUID features
+ *
+ * Each step has a kind, a selector that tells which of the above it
+ * operates on, an 8-bit argument and a 16-bit target.
+ *
+ * For example, after 0F C7 has been fetched, group 9 could be decoded by:
+ *
+ *        SWITCH  MOD     arg=2         target=mem
+ *   mem: JMP                           target=cmpxchg   (mod != 3)
+ *        SWITCH  REG     arg=8         target=reg       (mod == 3)
+ *   cmpxchg:
+ *        MATCH   REG     arg=1 << 1    target=ud
+ *        MATCH   PREFIX  arg=1 << NP   target=ud
+ *        SELECT  W       arg=2         target=<row of CMPXCHG8B>
+ *   reg: UD                                             (/0)
+ *        ...
+ *        JMP                           target=rdrand    (/6)
+ *        JMP                           target=rdseed    (/7)
+ *   ud:  UD
+ *
+ * where the row after CMPXCHG8B is CMPXCHG16B.
+ */
+typedef enum X86DecoderOpcode {
+    /* Raise #UD.  */
+    OP_UD,
+
+    /*
+     * Return row number target.  With a selector other than X86_SEL_None,
+     * compute its value v; if v <= arg, return row number target + v,
+     * otherwise continue with the next step.
+     */
+    OP_RET,
+
+    /* Continue at step target.  */
+    OP_JMP,
+
+    /*
+     * Continue with the next step if the value of the selector matches
+     * arg, otherwise continue at step target.  For X86_SEL_BYTE, arg is
+     * the value of b; for X86_SEL_CPUID, arg is an X86CPUIDFeature, which
+     * matches if the feature is present; for the other selectors, arg is a
+     * bitmask and value v matches if bit v of arg is set.
+     */
+    OP_MATCH,
+
+    /*
+     * Compute the value v of the selector.  If v <= arg, return row number
+     * target + v, otherwise raise #UD.  For X86_SEL_CPUID, arg is the
+     * feature and v is 0 or 1.
+     */
+    OP_SELECT,
+
+    /*
+     * Same as X86_OP_SELECT, but continue at step target + v.  The steps
+     * at target are usually X86_OP_RET, X86_OP_JMP or X86_OP_UD.
+     */
+    OP_SWITCH,
+
+    /*
+     * Replace the value of the selector with arg; this value is also used
+     * when decoding the operands.  Only valid for X86_SEL_W and X86_SEL_L
+     * (for example in place of WIG and LIG), and for X86_SEL_MOD (MOV to
+     * and from control and debug registers ignore ModRM.mod).
+     */
+    OP_SET,
+} X86DecoderOpcode;
+
+typedef enum X86DecoderSel {
+    /* For X86_OP_UD, X86_OP_RET, X86_OP_JMP.  */
+    X86_SEL_None,
+
+    /* The last opcode byte that was fetched, 0..255.  */
+    X86_SEL_BYTE,
+
+    /* ModRM.reg, 0..7.  */
+    X86_SEL_REG,
+
+    /* 0 if ModRM.mod != 3, 1 if ModRM.mod == 3.  */
+    X86_SEL_MOD,
+
+    /*
+     * X86MandatoryPrefix.  F2 takes precedence over F3, and both over 66.
+     * Note that the operand size is placed in s->dflag before running
+     * the program, so 66 still applies to v and z operands, as in
+     * CRC32 r32, m16 (66 F2 0F 38 F1 modrm)
+     */
+    X86_SEL_PREFIX,
+
+    /* X86DecodeEncoding.  */
+    X86_SEL_ENC,
+
+    /* REX.W, REX2.W, VEX.W or EVEX.W.  */
+    X86_SEL_W,
+
+    /* VEX.L (0..1) or EVEX.L'L (0..3).  */
+    X86_SEL_L,
+
+    /* 1 in 64-bit mode, 0 otherwise.  */
+    X86_SEL_MODE64,
+
+    /* EVEX.ND.  */
+    X86_SEL_ND,
+
+    /* EVEX.NF.  */
+    X86_SEL_NF,
+
+    /* 1 if the CPUID feature in arg is present, 0 otherwise.  */
+    X86_SEL_CPUID,
+} X86DecoderSel;
+
+/* Values of X86_SEL_PREFIX, in the same order as decode_by_prefix().  */
+typedef enum X86MandatoryPrefix {
+    X86_PREFIX_NP,
+    X86_PREFIX_66,
+    X86_PREFIX_F3,
+    X86_PREFIX_F2,
+} X86MandatoryPrefix;
+
+/* Values of X86_SEL_ENC.  */
+typedef enum X86Encoding {
+    X86_ENC_LEGACY,    /* No prefix or REX prefix.  */
+    X86_ENC_REX2,
+    X86_ENC_VEX,
+    X86_ENC_EVEX,
+} X86Encoding;
+
+typedef struct X86DecodeStep {
+    X86DecoderOpcode kind:4;
+    X86DecoderSel    sel:4;
+    uint8_t          arg;
+    uint16_t         target;
+} X86DecodeStep;
+
 /* Decode function for multibyte opcodes.  */
 typedef void (*X86DecodeFunc)(struct DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b);
 
diff --git a/target/i386/tcg/decode.def b/target/i386/tcg/decode.def
index 229d6e05b95..5342de00f55 100644
--- a/target/i386/tcg/decode.def
+++ b/target/i386/tcg/decode.def
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 //
-// Opcode table for the x86 TCG decoder.
+// Opcode table for the x86 TCG decoder, compiled into bytecode and
+// X86OpEntry rows by maketable.py.
 //
 // Each line describes one opcode, or a range of opcodes:
 //
diff --git a/target/i386/tcg/maketable.py b/target/i386/tcg/maketable.py
index 27a1bcfb6fc..f1af327bfca 100644
--- a/target/i386/tcg/maketable.py
+++ b/target/i386/tcg/maketable.py
@@ -930,6 +930,18 @@ class Node(TrieItem):
     def __post_init__(self) -> None:
         self.children = [Leaf.UD] * SEL_VALUES[self.sel]
 
+    @property
+    def max_child(self) -> int:
+        # Values after the last non-UD child raise #UD anyway.
+        n = max((v + 1 for v, child in enumerate(self.children) if child is not Leaf.UD),
+                default=0)
+        if n != 0 and self.sel == Sel.CPUID:
+            val = 2
+        else:
+            val = n
+        self.__dict__['max_child'] = val
+        return val
+
 
 # Order of the selectors; a selector is skipped if no entry in the subtree looks
 # at it.  Other than the opcode byte, which comes first as it is the densest,
@@ -1075,8 +1087,18 @@ def main() -> int:
     if args.output is None:
         for entry in entries:
             print(entry)
-    return 0
+        return 0
 
+    try:
+        import maketable_codegen
+        program = maketable_codegen.lower(build_trie(entries))
+        code = maketable_codegen.c_code(program, ' '.join(args.files))
+    except SemanticError as e:
+        print(e, file=sys.stderr)
+        return 1
+    with open(args.output, 'w', encoding='utf-8') as f:
+        f.write(code)
+    return 0
 
 if __name__ == '__main__':
     import maketable
diff --git a/target/i386/tcg/maketable_codegen.py b/target/i386/tcg/maketable_codegen.py
new file mode 100644
index 00000000000..e4d05295a63
--- /dev/null
+++ b/target/i386/tcg/maketable_codegen.py
@@ -0,0 +1,261 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Lowering of the decoding trie built by maketable.py to the bytecode
+# described in tcg/decode-new.h, and generation of the C code that
+# replaces tcg/decode-table.h.
+
+from dataclasses import dataclass, field, replace
+
+from maketable import (
+    Entry,
+    Leaf,
+    Node,
+    Operand,
+    Sel,
+    Trie,
+    TrieItem,
+)
+
+NUM_ENTRY_POINTS = 8
+
+C_TYPES = {'RAX': '0', 'RCX': '1', 'RDX': '2', 'RBX': '3',
+           'RSP': '4', 'RBP': '5', 'RSI': '6', 'RDI': '7'}
+C_EXT = {'zx': 'X86_EXT_Unsigned', 'sx': 'X86_EXT_Signed'}
+C_SPECIALS = {'nolea': 'NoLoadEA', 'xchg': 'Locked', 'lock': 'HasLock', 'mmx': 'MMX',
+              'op0_Rd': 'Op0_Rd', 'op2_Ry': 'Op2_Ry', 'avx_movx': 'AVXExtMov',
+              'op0_Mw': 'Op0_Mw', 'btEvGv': 'BitTest', 'popESP': 'PopESP'}
+C_VEX_SPECIALS = {'avx2_256': 'AVX2_256', 'unaligned': 'SSEUnaligned',
+                  'rep-scalar': 'REPScalar'}
+C_EVEX_CLASSES = {'APX': 'X86_EVEX_APX', 'APX_cmp': 'X86_EVEX_APX_cmp',
+                  'APX_pp2': 'X86_EVEX_APX_pp2', 'APX_zu': 'X86_EVEX_APX_zu'}
+
+
+def operand_ext(op: Operand) -> str | None:
+    for mod, ext in C_EXT.items():
+        if mod in op.mods:
+            return ext
+    return None
+
+
+def row_fields(entry: Entry) -> dict[str, str]:
+    # Fields of the X86OpEntry for an entry, as C expressions.
+    fields = {'gen': f'gen_{entry.insn.emitter}'}
+
+    def set_operand(slot: int, type: str, size: str | None, ext: str | None) -> None:
+        fields[f'op{slot}'] = f'X86_TYPE_{C_TYPES.get(type, type)}'
+        fields[f's{slot}'] = f'X86_SIZE_{size}'
+        if ext is not None and slot < 3:
+            fields[f'ext{slot}'] = ext
+
+    # op0 is the operand that is written; if it is also read, it is loaded
+    # through a 2op operand, which is always in op1.  The other operands are
+    # loaded into the following slots up to op2, except that an Ib after two
+    # sources goes in op3.  This covers the fourth operand, which is always
+    # Ib, as well as PCMPESTRM (no destination) and SHLD (op0, 2op and G).
+    # The op2 modifier skips op1, for unary operations that have a source
+    # operand in op2 only.
+    dest = entry.operands[0] if entry.operands else None
+    sources = iter(entry.operands)
+    slot = 1
+    if dest and 'w' in dest.mods:
+        if 'r' in dest.mods:
+            set_operand(0, dest.type, dest.size, None)
+            set_operand(1, '2op', dest.size, operand_ext(dest))
+            slot += 1
+        else:
+            set_operand(0, dest.type, dest.size, operand_ext(dest))
+        next(sources)
+    for src in sources:
+        if slot > 2:
+            assert slot == 3 and src.type == 'I' and src.size == 'b'
+        set_operand(slot, src.type, src.size, operand_ext(src))
+        slot += 1
+
+    checks = []
+    for m in entry.insn.modifiers:
+        if m.name in C_SPECIALS:
+            fields['special'] = f'X86_SPECIAL_{C_SPECIALS[m.name]}'
+        elif m.name in C_EVEX_CLASSES:
+            fields['vex_class'] = C_EVEX_CLASSES[m.name]
+        elif m.name.startswith('E') and m.name[1:].isdigit():
+            fields['vex_class'] = m.name[1:]
+            for arg in m.args:
+                if arg == 'mmx':
+                    # For now this is a special, not a vex_special.
+                    fields['special'] = f'X86_SPECIAL_{C_SPECIALS[arg]}'
+                else:
+                    assert arg in C_VEX_SPECIALS
+                    fields['vex_special'] = f'X86_VEX_{C_VEX_SPECIALS[arg]}'
+        elif m.name == 'chk':
+            # The program selects the row based on i64, o64 and no_rex2.
+            checks += [f'X86_CHECK_{arg}' for arg in m.args if arg not in ('i64', 'o64', 'no_rex2')]
+        elif m.name == 'svm':
+            fields['intercept'] = f'SVM_EXIT_{m.args[0]}'
+            fields['has_intercept'] = 'true'
+    if checks:
+        fields['check'] = ' | '.join(checks)
+    return fields
+
+
+@dataclass
+class Step:
+    kind: str                       # OP_ without the prefix
+    sel: Sel | None = None
+    arg: int | str = 0              # str for the X86CPUIDFeature of Sel.CPUID
+    target: int = 0
+    comment: str = ''
+
+
+@dataclass
+class Program:
+    steps: list[Step] = field(default_factory=list)
+    # None is an empty row, which decodes as #UD.
+    rows: list[Entry | None] = field(default_factory=list)
+
+
+class Lowering:
+    def __init__(self, trie: Trie):
+        self.trie = trie
+        self.program = Program()
+        self.leaf_code: dict[int, int] = {}
+        self.ud_pc: int | None = None
+
+    def ud(self) -> int:
+        if self.ud_pc is None:
+            self.ud_pc = len(self.program.steps)
+            self.program.steps.append(Step('UD'))
+        return self.ud_pc
+
+    def row(self, leaf: Leaf) -> int:
+        if leaf.index is None:
+            leaf.index = len(self.program.rows)
+            self.program.rows.append(leaf.entry)
+        return leaf.index
+
+    def leaf(self, leaf: Leaf) -> int:
+        # Code for a leaf that sets some selectors before returning.
+        if leaf is Leaf.UD:
+            return self.ud()
+        if id(leaf) not in self.leaf_code:
+            steps = self.program.steps
+            self.leaf_code[id(leaf)] = len(steps)
+            for sel, value in leaf.sets.items():
+                steps.append(Step('SET', sel, value))
+            steps.append(Step('RET', target=self.row(leaf), comment=self.describe(leaf)))
+        return self.leaf_code[id(leaf)]
+
+    def code(self, item: TrieItem) -> int:
+        # Index of a step that decodes item.
+        assert not isinstance(item, int)
+        if isinstance(item, Node):
+            return self.node(item)
+        assert isinstance(item, Leaf)
+        return self.leaf(item)
+
+    def select(self, node: Node, map: int | None = None) -> Step | None:
+        children = node.children[:node.max_child]
+        if all(isinstance(child, Leaf) and not child.sets for child in children):
+            rows = self.program.rows
+            arg = self.selector(node)
+            base = len(rows)
+            for child in children:
+                assert isinstance(child, Leaf)
+                rows.append(child.entry)
+            return Step('SELECT', node.sel, arg, base)
+        return None
+
+    def step_or_jmp(self, item: TrieItem) -> Step:
+        # Single step that decodes item, for the table of an OP_SWITCH.
+        if isinstance(item, Leaf):
+            if item is Leaf.UD:
+                return Step('UD')
+            if not item.sets:
+                return Step('RET', target=self.row(item), comment=self.describe(item))
+        else:
+            assert isinstance(item, Node)
+            select = self.select(item)
+            if select:
+                return select
+
+        return Step('JMP', target=self.code(item))
+
+    @staticmethod
+    def selector(node: Node) -> str | int:
+        if node.sel == Sel.CPUID:
+            return f'X86_FEAT_{node.feature}'
+        else:
+            return node.max_child - 1
+
+    def node(self, node: Node, map: int | None = None) -> int:
+        if node.index is not None:
+            return node.index
+
+        steps = self.program.steps
+        node.index = len(steps)
+        if node.max_child == 0:
+            steps.append(Step('UD'))
+            return node.index
+
+        select = self.select(node)
+        if select:
+            steps.append(select)
+            return node.index
+
+        arg = self.selector(node)
+        steps.append(Step('SWITCH', node.sel, arg, node.index + 1))
+        base = len(steps)
+        # reserve space, then fill in the individual steps
+        steps.extend(Step('UD') for _ in range(node.max_child))
+        children = node.children[:node.max_child]
+        for v, child in enumerate(children):
+            steps[base + v] = self.step_or_jmp(child)
+        return node.index
+
+    @staticmethod
+    def describe(leaf: Leaf) -> str:
+        assert leaf.entry is not None
+        insn = leaf.entry.insn
+        return f'{insn.emitter}, line {insn.lineno}'
+
+    def lower(self) -> Program:
+        steps = self.program.steps
+        steps.extend(Step('UD') for _ in range(NUM_ENTRY_POINTS))
+        for map, root in sorted(self.trie.maps.items()):
+            steps[map] = replace(self.step_or_jmp(root), comment=f'map {map}')
+
+        return self.program
+
+
+def lower(trie: Trie) -> Program:
+    return Lowering(trie).lower()
+
+
+def c_step(step: Step) -> str:
+    sel = f'X86_SEL_{step.sel.name}' if step.sel is not None else 'X86_SEL_None'
+    return f'{{ OP_{step.kind}, {sel}, {step.arg}, {step.target} }}'
+
+
+def c_code(program: Program, source: str) -> str:
+    out = [f'/* Generated by maketable.py from {source}, do not edit.  */',
+           '',
+           'static const X86OpEntry decode_rows[] = {']
+    for i, entry in enumerate(program.rows):
+        if entry is None:
+            out.append(f'    [{i}] = {{}},')
+            continue
+        out.append(f'    [{i}] = {{  /* {entry.insn.filename}:{entry.insn.lineno} */')
+        for name, value in row_fields(entry).items():
+            out.append(f'        .{name} = {value},')
+        out.append('    },')
+    out.append('};')
+    out.append('')
+    out.append('/* Steps 0-9 are the entry points, see decode-new.h.  */')
+    out.append('static const X86DecodeStep decode_program[] = {')
+    for pc, step in enumerate(program.steps):
+        line = f'    [{pc}] = {c_step(step)},'
+        if step.comment:
+            line = f'{line:<52} /* {step.comment} */'
+        out.append(line + '')
+    out.append('};')
+
+    return '\n'.join(out)
diff --git a/target/i386/tcg/meson.build b/target/i386/tcg/meson.build
index 30ab58a92a2..1e1f8adecd5 100644
--- a/target/i386/tcg/meson.build
+++ b/target/i386/tcg/meson.build
@@ -1,4 +1,11 @@
-i386_ss.add(when: 'CONFIG_TCG', if_true: files(
+i386_decode_table_h = custom_target(
+    'decode-table.h',
+    input: 'decode.def',
+    output: 'decode-table.h',
+    depend_files: files('maketable_codegen.py', 'decode-new.h', '../svm.h'),
+    command: [python, files('maketable.py'), '-o', '@OUTPUT@', '@INPUT@'])
+
+i386_ss.add(when: 'CONFIG_TCG', if_true: [files(
   'access.c',
   'bpt_helper.c',
   'cc_helper.c',
@@ -10,14 +17,14 @@ i386_ss.add(when: 'CONFIG_TCG', if_true: files(
   'mpx_helper.c',
   'seg_helper.c',
   'tcg-cpu.c',
-  'translate.c'), if_false: files('tcg-stub.c'))
+  'translate.c'), i386_decode_table_h], if_false: files('tcg-stub.c'))
 
 subdir('system')
 subdir('user')
 
 # Unit tests for the generator of the decoder tables.
 test('i386-maketable', python,
-     args: ['-m', 'pycotap', 'test_maketable'],
+     args: ['-m', 'pycotap', 'test_maketable', 'test_maketable_codegen'],
      workdir: meson.current_source_dir(),
      protocol: 'tap',
      suite: ['unit'])
diff --git a/target/i386/tcg/test_maketable_codegen.py b/target/i386/tcg/test_maketable_codegen.py
new file mode 100644
index 00000000000..ab1bfb5761b
--- /dev/null
+++ b/target/i386/tcg/test_maketable_codegen.py
@@ -0,0 +1,245 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Tests for maketable_codegen.py.  Run with "python3 -m unittest
+# test_maketable_codegen" from the target/i386 directory.
+
+import unittest
+
+from maketable import (
+    ENC_LEGACY,
+    ENC_REX2,
+    ENC_VEX,
+    Entry,
+    Leaf,
+    Node,
+    SemanticError,
+    Sel,
+    Trie,
+    TrieItem,
+    analyze,
+    build_trie,
+    parse_line,
+)
+from maketable_codegen import Program, c_code, lower, row_fields
+
+
+def build(*lines: str) -> Trie:
+    insns = [parse_line(text, '<test>', i) for i, text in enumerate(lines, start=1)]
+    return build_trie(analyze([insn for insn in insns if insn is not None]))
+
+
+def entry(text: str) -> Entry:
+    insn = parse_line(text)
+    assert insn is not None
+    return analyze([insn])[0]
+
+
+def run(program: Program, entry_point: int, values: dict[Sel, int],
+        next_bytes: list[int] | None = None,
+        features: dict[str, int] | None = None) -> tuple[Entry | None, dict[Sel, int]]:
+    # Same as decode_run() in decode-new.c.inc.  Returns the entry and the
+    # values written by OP_SET.  If features is given, it has the value of
+    # Sel.CPUID for each feature, otherwise values[Sel.CPUID] applies to all.
+    values = dict(values)
+    next_bytes = list(next_bytes or [])
+    sets: dict[Sel, int] = {}
+    pc = entry_point
+    while True:
+        step = program.steps[pc]
+        v = values.get(step.sel, 0) if step.sel is not None else 0
+        if step.sel == Sel.CPUID and features is not None:
+            assert isinstance(step.arg, str)
+            v = features[step.arg.removeprefix('X86_FEAT_')]
+        if step.kind == 'UD':
+            return None, sets
+        elif step.kind == 'RET':
+            if step.sel is None:
+                return program.rows[step.target], sets
+            assert isinstance(step.arg, int)
+            if v <= step.arg:
+                return program.rows[step.target + v], sets
+            pc += 1
+        elif step.kind == 'JMP':
+            pc = step.target
+        elif step.kind == 'SET':
+            assert step.sel is not None and isinstance(step.arg, int)
+            values[step.sel] = sets[step.sel] = step.arg
+            pc += 1
+        elif step.kind == 'MATCH':
+            if step.sel == Sel.CPUID:
+                match = bool(v)
+            elif step.sel == Sel.BYTE:
+                match = v == step.arg
+            else:
+                assert isinstance(step.arg, int)
+                match = bool((step.arg >> v) & 1)
+            pc = pc + 1 if match else step.target
+        elif step.kind in ('SELECT', 'SWITCH'):
+            limit = 1 if step.sel == Sel.CPUID else step.arg
+            assert isinstance(limit, int)
+            if v > limit:
+                return None, sets
+            if step.kind == 'SELECT':
+                return program.rows[step.target + v], sets
+            pc = step.target + v
+        else:
+            raise AssertionError(step.kind)
+
+
+class TestLowering(unittest.TestCase):
+    def check_equivalent(self, trie: Trie) -> Program:
+        # Walk every path of the trie, trying all the values of the selectors
+        # along the path, and check that the program decodes to the same
+        # entry.  The escape bytes of map 1 are tested in test_escapes.
+        program = lower(trie)
+
+        def walk(map: int, item: TrieItem, values: dict[Sel, int],
+                 features: dict[str, int]) -> None:
+            if isinstance(item, Node):
+                for v, child in enumerate(item.children):
+                    if item.sel == Sel.CPUID:
+                        assert item.feature is not None
+                        walk(map, child, values, features | {item.feature: v})
+                    else:
+                        walk(map, child, values | {item.sel: v}, features)
+                return
+            assert isinstance(item, Leaf)
+            got, sets = run(program, map, values, features=features)
+            self.assertIs(got, item.entry, f'map {map}, {values}, {features}')
+            if item.entry is not None:
+                self.assertEqual(sets, item.entry.sets)
+
+        for map, root in trie.maps.items():
+            walk(map, root, {}, {})
+        return program
+
+    def test_simple(self) -> None:
+        self.check_equivalent(build('00   ADD   Eb,Gb   lock',
+                                    '50..57+r   PUSH   Rd64(r)',
+                                    'FE /0   INC   Eb   lock',
+                                    'FE /1   DEC   Eb   lock'))
+
+    def test_prefix_and_encoding(self) -> None:
+        self.check_equivalent(build('NP|66.0F 67      PACKUSWB    Vx,Hx,Wx   E4(mmx)',
+                                    'VEX.66.0F.WIG 67   VPACKUSWB   Vx,Hx,Wx',
+                                    'F3.0F AE /0      RDxxBASE    Ry(w)',
+                                    'NP.0F AE /0      FXSAVE      My(w)',
+                                    'NP.W0.0F C7 /1   CMPXCHG8B   Mq',
+                                    'NP.W1.0F C7 /1   CMPXCHG16B  Mdq'))
+
+    def test_sets(self) -> None:
+        self.check_equivalent(build('NP.0F 20   MOV   Ry_d64(w),Cy_d64   ignore_mod',
+                                    'VEX.66.0F38.WIG.LIG 18   X   Vx,Wx'))
+
+    def test_mode_and_cpuid(self) -> None:
+        self.check_equivalent(build('NP.W0.0F C7 /1   CMPXCHG8B   Mq   cpuid(CX8)',
+                                    'VEX.66.0F38.128 DC  AESENC  Vx(w),Hx,Wx  E4 cpuid(AES, AVX)',
+                                    '63      ARPL     Ew,Gw         chk(i64)',
+                                    'W1 63   MOVSXD   Gv(w),Ed      chk(o64)',
+                                    'W0 63   MOV      Gv(w),Ev      chk(o64)',
+                                    '0F BD      BSR     Gv,Ev',
+                                    'F3.0F BD   LZCNT   Gv(w),Ev   cpuid(BMI1)'))
+
+    def test_modrm(self) -> None:
+        self.check_equivalent(build('NP.0F 01 /1   SIDT      Ms',
+                                    'NP.0F AE /5   LFENCE    Ry(r)'))
+
+    def test_rex2(self) -> None:
+        trie = build('A1              MOV     RAXv(w),Ov',
+                     'REX2.NP.W0 A1   JMP_m   Iq',
+                     'NP.0F AE /4     XSAVE   My(w)         chk(no_rex2)',
+                     'NP.0F 30        WRMSR')
+        program = self.check_equivalent(trie)
+        # Rows 4, 7, A and E of map 0 have separate lines for REX2.
+        got, _ = run(program, 0, {Sel.BYTE: 0xA1, Sel.ENC: ENC_LEGACY, Sel.PREFIX: 0})
+        self.assertIsNotNone(got)
+        assert got is not None
+        self.assertEqual(got.insn.emitter, 'MOV')
+        got, _ = run(program, 0, {Sel.BYTE: 0xA1, Sel.ENC: ENC_REX2, Sel.PREFIX: 0})
+        self.assertIsNotNone(got)
+        assert got is not None
+        self.assertEqual(got.insn.emitter, 'JMP_m')
+        # Elsewhere REX2 is the same as the legacy encoding, except for rows
+        # 3 and 8 of map 1 (0F 38, 0F 3A, WRMSR and others, Jcc) and for
+        # lines with chk(no_rex2).
+        got, _ = run(program, 1, {Sel.BYTE: 0xAE, Sel.MOD: 0, Sel.REG: 4, Sel.ENC: ENC_LEGACY, Sel.PREFIX: 0})
+        self.assertIsNotNone(got)
+        assert got is not None
+        self.assertEqual(got.insn.emitter, 'XSAVE')
+        got, _ = run(program, 1, {Sel.BYTE: 0xAE, Sel.MOD: 0, Sel.REG: 4, Sel.ENC: ENC_REX2, Sel.PREFIX: 0})
+        self.assertIsNone(got)
+        got, _ = run(program, 1, {Sel.BYTE: 0x30, Sel.ENC: ENC_LEGACY, Sel.PREFIX: 0})
+        self.assertIsNotNone(got)
+        assert got is not None
+        self.assertEqual(got.insn.emitter, 'WRMSR')
+        got, _ = run(program, 1, {Sel.BYTE: 0x30, Sel.ENC: ENC_REX2, Sel.PREFIX: 0})
+        self.assertIsNone(got)
+
+    def test_entry_points(self) -> None:
+        program = lower(build('00   ADD   Eb,Gb'))
+        for map in range(1, 8):
+            got, _ = run(program, map, {Sel.BYTE: 0x00})
+            self.assertIsNone(got)
+
+
+class TestRowFields(unittest.TestCase):
+    def test_read_modify_write(self) -> None:
+        fields = row_fields(entry('FE /0   INC   Eb   lock'))
+        self.assertEqual(fields['op0'], 'X86_TYPE_E')
+        self.assertEqual(fields['op1'], 'X86_TYPE_2op')
+        self.assertEqual(fields['s1'], 'X86_SIZE_b')
+        self.assertNotIn('op2', fields)
+        self.assertEqual(fields['special'], 'X86_SPECIAL_HasLock')
+
+    def test_sources_only(self) -> None:
+        fields = row_fields(entry('84   TEST   Eb(r),Gb'))
+        self.assertNotIn('op0', fields)
+        self.assertEqual((fields['op1'], fields['op2']), ('X86_TYPE_E', 'X86_TYPE_G'))
+        fields = row_fields(entry('50..57+r   PUSH   Rd64(r)'))
+        self.assertEqual((fields['op1'], fields['s1']), ('X86_TYPE_LoBits', 'X86_SIZE_d64'))
+
+    def test_write_only(self) -> None:
+        fields = row_fields(entry('8B   MOV   Gv(w),Ev'))
+        self.assertEqual((fields['op0'], fields['op1']), ('X86_TYPE_G', 'X86_TYPE_E'))
+        fields = row_fields(entry('E4   IN   RAXb(w),Ib(zx)'))
+        self.assertEqual((fields['op0'], fields['op1']), ('X86_TYPE_0', 'X86_TYPE_I_unsigned'))
+
+    def test_ext(self) -> None:
+        fields = row_fields(entry('F3.0F AE /2   WRxxBASE   Ry(r,zx)   '
+                                  'cpuid(FSGSBASE) chk(o64)'))
+        self.assertEqual(fields['ext1'], 'X86_EXT_Unsigned')
+        # The program selects the row based on o64 and i64.
+        self.assertNotIn('check', fields)
+        fields = row_fields(entry('63   ARPL   Ew,Gw   chk(prot, i64)'))
+        self.assertEqual(fields['check'], 'X86_CHECK_prot')
+
+    def test_four_operands(self) -> None:
+        fields = row_fields(entry('VEX.66.0F3A.W0 4A   VBLENDVPS   Vx,Hx,Wx,Ib   E6'))
+        self.assertEqual([fields[f'op{i}'] for i in range(4)],
+                         ['X86_TYPE_V', 'X86_TYPE_H', 'X86_TYPE_W', 'X86_TYPE_I'])
+        self.assertEqual(fields['vex_class'], '6')
+
+    def test_vex_and_svm(self) -> None:
+        fields = row_fields(entry('66.0F 10   MOVUPD  Vx(w),Wx   E4(unaligned)'))
+        self.assertEqual((fields['vex_class'], fields['vex_special']), ('4', 'X86_VEX_SSEUnaligned'))
+        fields = row_fields(entry('NP|66.0F 67   PACKUSWB   Vx,Hx,Wx   E4(avx2_256, mmx)'))
+        self.assertEqual((fields['special'], fields['vex_special']),
+                         ('X86_SPECIAL_MMX', 'X86_VEX_AVX2_256'))
+        fields = row_fields(entry('NP|66.0F 67   PACKUSWB   Vx,Hx,Wx   E4(mmx)'))
+        self.assertEqual(fields['special'], 'X86_SPECIAL_MMX')
+        self.assertNotIn('vex_special', fields)
+        fields = row_fields(entry('9D   POPF   chk(vm86_iopl) svm(POPF)'))
+        self.assertEqual((fields['intercept'], fields['has_intercept']), ('SVM_EXIT_POPF', 'true'))
+
+    def test_immediate_in_op3(self) -> None:
+        # Like X86_OP_ENTRY4 with op0 = None.
+        fields = row_fields(entry('SSE|VEX.66.0F3A 60   PCMPESTRM   Vdq(r),Wdq,Ib   '
+                                  'E4(unaligned) cpuid(SSE42)'))
+        self.assertNotIn('op0', fields)
+        self.assertEqual([fields[f'op{i}'] for i in range(1, 4)],
+                         ['X86_TYPE_V', 'X86_TYPE_W', 'X86_TYPE_I'])
+        # Like X86_OP_ENTRY4(SHLD, E,v, 2op,v, G,v).
+        fields = row_fields(entry('0F A4   SHLD   Ev(r,w),Gv,Ib'))
+        self.assertEqual([fields[f'op{i}'] for i in range(4)],
+                         ['X86_TYPE_E', 'X86_TYPE_2op', 'X86_TYPE_G', 'X86_TYPE_I'])
-- 
2.56.0



