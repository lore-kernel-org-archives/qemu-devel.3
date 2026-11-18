Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BB4606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dfzDmvJw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTei4-0002QJ-Mx; Wed, 18 Nov 2026 07:24:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTehv-0002M2-Aj
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTehs-0004MW-JA
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795004647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y52It5H6paWaZS38DrvCgIt5ZL/PfJ9391msH5ehZmA=;
 b=dfzDmvJwI8UJaEz4t5N59WVnyGM/NF5PXjizeicL8ghhP87GWPnN6BNjsKvUfz49DUqVBH
 Zn9iowpboSAVcEYQEGcnk0hNF2cWaEigIA23T5VJNWBvZgbTH0x1ZylfS8Sgrop97c1+he
 FiyzCHJSIJ9cMpVA/ZySrzX6AyRj/IE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-5Hghnb1aMNqYtE7MArqrwA-1; Wed,
 18 Nov 2026 07:24:05 -0500
X-MC-Unique: 5Hghnb1aMNqYtE7MArqrwA-1
X-Mimecast-MFC-AGG-ID: 5Hghnb1aMNqYtE7MArqrwA_1795004644
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7047C1956056
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:04 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C0D5F180055C
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:03 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 04/26] target/i386/tcg: build a decoding trie from the
 table description
Date: Wed, 18 Nov 2026 13:23:35 +0100
Message-ID: <20261118122357.659634-5-pbonzini@redhat.com>
In-Reply-To: <20261118122357.659634-1-pbonzini@redhat.com>
References: <20261118122357.659634-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Compute, for each entry, the values of the decoder selectors that lead
to it (opcode map and byte, mandatory prefix, encoding, W, L, ND, NF,
ModRM.reg, ModRM.mod, 64-bit mode).  Then build a trie for each opcode
map out of them.

Constraints are built from the opcode column of decode.def, the
operand types (R, U and N operands require mod == 3, memory operands
need mod != 3), and the modifiers (for example chk(i64) and chk(o64)).

The trie looks at the selectors in a fixed order, skipping those that
no entry in a subtree cares about, and shares subtrees with the same
set of candidate entries.  In order to support WIG/LIG/LLIG and
ignore_mod, leaves also have a list of fields to set.

AI-used-for: code, tests
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/maketable.py      | 246 +++++++++++++++++++++++++++++-
 target/i386/tcg/test_maketable.py | 132 ++++++++++++++++
 2 files changed, 377 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/maketable.py b/target/i386/tcg/maketable.py
index 2a52307d97e..826d82a2780 100644
--- a/target/i386/tcg/maketable.py
+++ b/target/i386/tcg/maketable.py
@@ -20,12 +20,13 @@
 
 from __future__ import annotations
 
+import enum
 import pathlib
 import re
 import sys
 from collections.abc import Callable
 from dataclasses import dataclass, field, replace
-from typing import Generic, TypeVar, cast, overload
+from typing import ClassVar, Generic, TypeVar, cast, overload
 
 T = TypeVar('T')
 
@@ -347,9 +348,65 @@ def parse_file(lines: list[str], filename: str = '<string>') -> list[Insn]:
     return insns
 
 
+class Sel(enum.Enum):
+    # Same as X86DecodeSel in decode-new.h.
+    BYTE = enum.auto()
+    REG = enum.auto()
+    MOD = enum.auto()
+    PREFIX = enum.auto()
+    ENC = enum.auto()
+    W = enum.auto()
+    L = enum.auto()
+    MODE64 = enum.auto()
+    ND = enum.auto()
+    NF = enum.auto()
+
+
+# Number of values of each selector.
+SEL_VALUES = {
+    Sel.BYTE: 256,
+    Sel.REG: 8,
+    Sel.MOD: 2,
+    Sel.PREFIX: 4,
+    Sel.ENC: 4,
+    Sel.W: 2,
+    Sel.L: 4,
+    Sel.MODE64: 2,
+    Sel.ND: 2,
+    Sel.NF: 2,
+}
+
+# Values of the selectors that an entry accepts; a selector that is not
+# present accepts all values.  For example, "NP|66.0F 67" accepts
+# {Sel.PREFIX: {0, 1}, Sel.BYTE: {0x67}} in map 1.
+Constraints = dict[Sel, frozenset[int]]
+
+PREFIX_MAPS = {
+    None: 0, '0F': 1, '0F38': 2, '0F3A': 3,
+    'MAP3': 3, 'MAP4': 4, 'MAP5': 5, 'MAP6': 6, 'MAP7': 7,
+}
+
+# Values of Sel.PREFIX and Sel.ENC, same as X86DecodePrefix and
+# X86DecodeEncoding.
+MANDATORY_PREFIXES = {'NP': 0, '66': 1, 'F3': 2, 'F2': 3}
+ENC_LEGACY, ENC_REX2, ENC_VEX, ENC_EVEX = range(4)
+ENCODINGS = {
+    'LEGACY': ENC_LEGACY,
+    'REX2': ENC_REX2,
+    'VEX': ENC_VEX,
+    'EVEX': ENC_EVEX,
+}
+
 # Rows of map 0 and 1 where REX2 differs from the legacy encoding.
 REX2_ROWS = {None: {0x4, 0x7, 0xA, 0xE}, '0F': {0x3, 0x8}}
 
+W_VALUES = {'W0': frozenset([0]), 'W1': frozenset([1])}
+L_VALUES = {
+    'L0': frozenset([0]), '128': frozenset([0]), 'LZ': frozenset([0]), 'LLZ': frozenset([0]),
+    'L1': frozenset([1]), '256': frozenset([1]),
+    '512': frozenset([2]),
+}
+
 
 class SemanticError(Exception):
     def __init__(self, insn: Insn, msg: str):
@@ -428,6 +485,20 @@ class Entry:
     insn: Insn
     operands: list[Operand] = field(init=False, default_factory=list)
 
+    # Opcode map, and values of the selectors that lead to this entry.
+    map: int = field(init=False, default=0)
+    constraints: Constraints = field(init=False, default_factory=dict)
+
+    # Selectors whose value is replaced when decoding (X86_OP_SET).
+    sets: dict[Sel, int] = field(init=False, default_factory=dict)
+
+    def accepts(self, sel: Sel, v: int) -> bool:
+        allowed = self.constraints.get(sel)
+        return allowed is None or v in allowed
+
+    def constrains(self, sel: Sel) -> bool:
+        return sel in self.constraints
+
     def error(self, msg: str) -> SemanticError:
         return SemanticError(self.insn, msg)
 
@@ -659,6 +730,63 @@ def check_modifiers(self) -> None:
         if len(classes) > 1:
             raise self.error('more than one exception class')
 
+    def compute_constraints(self) -> None:
+        prefix = self.insn.prefix
+        c = self.constraints
+
+        self.map = PREFIX_MAPS[prefix.map]
+        lo, hi = self.insn.opcode
+        c[Sel.BYTE] = frozenset(range(lo, hi + 1))
+
+        if prefix.mandatory is not None:
+            c[Sel.PREFIX] = frozenset(MANDATORY_PREFIXES[p] for p in prefix.mandatory)
+        elif prefix.encoding in ('VEX', 'EVEX'):
+            # VEX.pp and EVEX.pp are part of the opcode; like in the SDM,
+            # no mandatory prefix means NP.
+            c[Sel.PREFIX] = frozenset([MANDATORY_PREFIXES['NP']])
+
+        # Lines without an encoding also accept REX2, except in the rows
+        # where REX2 has its own lines.
+        checks = {arg for m in self.insn.modifiers if m.name == 'chk' for arg in m.args}
+        encs = set(ENCODINGS[e] for e in [prefix.encoding or 'LEGACY'])
+        if ENC_LEGACY in encs and not self.is_rex2() and 'no_rex2' not in checks:
+            encs.add(ENC_REX2)
+        c[Sel.ENC] = frozenset(encs)
+
+        # WIG, LIG and LLIG accept all values, and decode as 0.
+        if prefix.w == 'WIG':
+            self.sets[Sel.W] = 0
+        elif prefix.w is not None:
+            c[Sel.W] = W_VALUES[prefix.w]
+        if prefix.l in ('LIG', 'LLIG'):
+            self.sets[Sel.L] = 0
+        elif prefix.l is not None:
+            c[Sel.L] = L_VALUES[prefix.l]
+
+        if prefix.nd is not None:
+            c[Sel.ND] = frozenset([prefix.nd == 'ND1'])
+        if prefix.nf is not None:
+            c[Sel.NF] = frozenset([prefix.nf == 'NF1'])
+
+        # i64 and o64 select the row based on the mode; the other checks
+        # (including i64_amd and o64_intel) stay in the row.
+        if 'i64' in checks:
+            c[Sel.MODE64] = frozenset([0])
+        elif 'o64' in checks:
+            c[Sel.MODE64] = frozenset([1])
+
+        if self.insn.modrm_reg is not None:
+            c[Sel.REG] = frozenset([self.insn.modrm_reg])
+
+        # R, U, N and ignore_mod are register operands (mod == 3), M and
+        # other operands with the m modifier are memory operands (mod != 3).
+        if any(m.name == 'ignore_mod' for m in self.insn.modifiers):
+            self.sets[Sel.MOD] = 1
+        elif any(op.type in REGISTER_TYPES for op in self.insn.operands) and not self.insn.lobits:
+            c[Sel.MOD] = frozenset([1])
+        elif any('m' in op.mods for op in self.operands):
+            c[Sel.MOD] = frozenset([0])
+
     def __post_init__(self) -> None:
         self.check_prefix()
         self.check_opcode()
@@ -666,12 +794,128 @@ def __post_init__(self) -> None:
         self.fixup_operands()
         self.check_modrm()
         self.check_modifiers()
+        self.compute_constraints()
 
 
 def analyze(insns: list[Insn]) -> list[Entry]:
     return [Entry(insn) for insn in insns]
 
 
+# The trie has the same contents as the list of entries, but organized as
+# the decoder walks it: each node looks at one property of the instruction
+# (the selector) and has a subtree for each of its values, and the leaves
+# are the entries.  It is then lowered to the X86DecodeStep bytecode in
+# decode-new.h.
+
+
+@dataclass(kw_only=True)
+class TrieItem:
+    # Position in the flattened output, None until then: the row number
+    # for a Leaf, the index of the first step for a Node.
+    index: int | None = None
+
+
+@dataclass(kw_only=True)
+class Leaf(TrieItem):
+    UD: ClassVar[Leaf]
+
+    # None only for UD.
+    entry: Entry | None = None
+
+Leaf.UD = Leaf(entry=None)
+
+
+@dataclass(kw_only=True)
+class Node(TrieItem):
+    sel: Sel
+
+    # Subtree for each value of the selector, initially UD.  Several values
+    # can share the same subtree, for example all opcodes of 50..57+r or
+    # all values of L for LIG.  When flattening, subtrees are replaced
+    # by their index.
+    children: list[TrieItem] = field(init=False)
+
+    def __post_init__(self) -> None:
+        self.children = [Leaf.UD] * SEL_VALUES[self.sel]
+
+
+# Order of the selectors; a selector is skipped if no entry in the subtree looks
+# at it.  Other than the opcode byte, which comes first as it is the densest,
+# the encoding and L are used to separate legacy instructions from VEX ones with
+# the same opcode, for example CMOVcc and the mask register instructions.
+# MODE64 is last because chk(i64) and chk(o64) are mostly checks on a single
+# line; checking it earlier would duplicate the subtrees for all the other
+# lines of the same opcode.
+SEL_ORDER = [Sel.BYTE, Sel.ENC, Sel.L, Sel.PREFIX, Sel.REG, Sel.MOD,
+             Sel.W, Sel.ND, Sel.NF, Sel.MODE64]
+
+
+@dataclass
+class Trie:
+    # Root for each opcode map (0 for one-byte opcodes, 1 for 0F, 2 for
+    # 0F38, 3 for 0F3A, 4-7 for the EVEX maps).  Each root looks at
+    # Sel.BYTE.
+    maps: dict[int, Node] = field(default_factory=dict)
+
+    def lookup(self, map: int, values: dict[Sel, int]) -> Entry | None:
+        # Walk the trie; selectors that are not in values are 0.
+        item: TrieItem = self.maps[map]
+        while isinstance(item, Node):
+            item = item.children[values.get(item.sel, 0)]
+        assert isinstance(item, Leaf)
+        return item.entry
+
+
+# Key of the cache of subtrees: the position in SEL_ORDER of the first
+# selector that is left, and the candidate entries.
+CacheKey = tuple[int, tuple[int, ...]]
+
+
+def build_subtree(entries: list[Entry], start: int, cache: dict[CacheKey, TrieItem]) -> TrieItem:
+    # Entries with the same set of candidates share the subtree.
+    key = (start, tuple(id(e) for e in entries))
+    if key in cache:
+        return cache[key]
+
+    pos = next((i for i in range(start, len(SEL_ORDER))
+                if any(e.constrains(SEL_ORDER[i]) for e in entries)), None)
+    sel = None if pos is None else SEL_ORDER[pos]
+    item: TrieItem
+    if sel is None:
+        if len(entries) > 1:
+            other = entries[1].insn
+            raise entries[0].error(f'overlaps with {other.filename}:{other.lineno}')
+        item = Leaf(entry=entries[0]) if entries else Leaf.UD
+    else:
+        assert pos is not None
+        node = Node(sel=sel)
+        for v in range(SEL_VALUES[sel]):
+            subset = [e for e in entries if e.accepts(sel, v)]
+            node.children[v] = build_subtree(subset, pos + 1, cache)
+
+        # If all values lead to the same subtree, the node is not needed.
+        # The opcode byte is kept, because it is the root of each map.
+        first = node.children[0]
+        if sel != Sel.BYTE and all(child is first for child in node.children):
+            assert isinstance(first, TrieItem)
+            item = first
+        else:
+            item = node
+    cache[key] = item
+    return item
+
+
+def build_trie(entries: list[Entry]) -> Trie:
+    trie = Trie()
+    cache: dict[CacheKey, TrieItem] = {}
+    for map in sorted({e.map for e in entries}):
+        in_map = [e for e in entries if e.map == map]
+        root = build_subtree(in_map, 0, cache)
+        assert isinstance(root, Node) and root.sel == Sel.BYTE
+        trie.maps[map] = root
+    return trie
+
+
 def main() -> int:
     entries: list[Entry] = []
     for filename in sys.argv[1:]:
diff --git a/target/i386/tcg/test_maketable.py b/target/i386/tcg/test_maketable.py
index b682d289184..11e3c6dc1d5 100644
--- a/target/i386/tcg/test_maketable.py
+++ b/target/i386/tcg/test_maketable.py
@@ -7,7 +7,16 @@
 import unittest
 
 from maketable import (
+    ENC_EVEX,
+    ENC_LEGACY,
+    ENC_REX2,
+    ENC_VEX,
     Entry,
+    Leaf,
+    Node,
+    Sel,
+    Trie,
+    build_trie,
     Insn,
     Modifier,
     Operand,
@@ -358,3 +367,126 @@ def test_modrm(self) -> None:
 
     def test_mode64(self) -> None:
         self.assertRaises(SemanticError, self.analyze, '63   X   Ew,Gw   chk(i64, o64)')
+
+
+class TestTrie(unittest.TestCase):
+    def build(self, *lines: str) -> Trie:
+        insns = [parse_line(text, '<test>', i) for i, text in enumerate(lines, start=1)]
+        return build_trie(analyze([insn for insn in insns if insn is not None]))
+
+    def emitter(self, trie: Trie, map: int, **values: int) -> str | None:
+        entry = trie.lookup(map, {Sel[k.upper()]: v for k, v in values.items()})
+        return None if entry is None else entry.insn.emitter
+
+    def test_prefix_and_encoding(self) -> None:
+        trie = self.build('NP|66.0F 67   PACKUSWB    Vx,Hx,Wx   E4(mmx)',
+                          'VEX.66.0F.WIG 67   VPACKUSWB   Vx,Hx,Wx')
+        self.assertEqual(self.emitter(trie, 1, byte=0x67, prefix=0), 'PACKUSWB')
+        self.assertEqual(self.emitter(trie, 1, byte=0x67, prefix=1, enc=ENC_REX2), 'PACKUSWB')
+        self.assertIsNone(self.emitter(trie, 1, byte=0x67, prefix=2))
+        self.assertEqual(self.emitter(trie, 1, byte=0x67, prefix=1, enc=ENC_VEX), 'VPACKUSWB')
+        self.assertIsNone(self.emitter(trie, 1, byte=0x67, prefix=1, enc=ENC_EVEX))
+        self.assertIsNone(self.emitter(trie, 1, byte=0x68, prefix=1, enc=ENC_LEGACY))
+
+    def test_ignored_fields(self) -> None:
+        trie = self.build('VEX.66.0F.WIG.LIG 67   X   Vx,Hx,Wx')
+        for w in (0, 1):
+            for l in (0, 1):
+                entry = trie.lookup(1, {Sel.BYTE: 0x67, Sel.PREFIX: 1, Sel.ENC: ENC_VEX,
+                                        Sel.W: w, Sel.L: l})
+                assert entry is not None
+                self.assertEqual(entry.sets, {Sel.W: 0, Sel.L: 0})
+
+    def test_w_and_l(self) -> None:
+        trie = self.build('NP.W0.0F C7 /1   CMPXCHG8B    Mq',
+                          'NP.W1.0F C7 /1   CMPXCHG16B   Mdq',
+                          'VEX.66.0F38.W0.L0 18   X128   Vx,Wx',
+                          'VEX.66.0F38.W0.256 18  X256   Vx,Wx')
+        self.assertEqual(self.emitter(trie, 1, byte=0xC7, reg=1, w=0), 'CMPXCHG8B')
+        self.assertEqual(self.emitter(trie, 1, byte=0xC7, reg=1, w=1), 'CMPXCHG16B')
+        self.assertIsNone(self.emitter(trie, 1, byte=0xC7, reg=1, w=0, mod=1))
+        self.assertIsNone(self.emitter(trie, 1, byte=0xC7, reg=0, w=0))
+        vex = dict(byte=0x18, prefix=1, enc=ENC_VEX)
+        self.assertEqual(self.emitter(trie, 2, l=0, **vex), 'X128')
+        self.assertEqual(self.emitter(trie, 2, l=1, **vex), 'X256')
+        self.assertIsNone(self.emitter(trie, 2, l=0, w=1, **vex))
+
+    def test_reg_and_mod(self) -> None:
+        trie = self.build('NP.0F AE /0    FXSAVE     My(w)',
+                          'F3.0F AE /0    RDxxBASE   Ry(w)',
+                          'F3.0F AE /1    RDxxBASE   Ry(w)',
+                          'F3.0F AE /2    WRxxBASE   Ry(r)',
+                          'F3.0F AE /3    WRxxBASE   Ry(r)')
+        self.assertEqual(self.emitter(trie, 1, byte=0xAE, reg=0, mod=0, prefix=0), 'FXSAVE')
+        self.assertEqual(self.emitter(trie, 1, byte=0xAE, reg=0, mod=1, prefix=2), 'RDxxBASE')
+        self.assertEqual(self.emitter(trie, 1, byte=0xAE, reg=1, mod=1, prefix=2), 'RDxxBASE')
+        self.assertEqual(self.emitter(trie, 1, byte=0xAE, reg=3, mod=1, prefix=2), 'WRxxBASE')
+        self.assertIsNone(self.emitter(trie, 1, byte=0xAE, reg=0, mod=1, prefix=0))
+        self.assertIsNone(self.emitter(trie, 1, byte=0xAE, reg=0, mod=0, prefix=2))
+
+    def test_shared_subtrees(self) -> None:
+        trie = self.build('50..57+r   PUSH   Rd64(r)')
+        root = trie.maps[0]
+        self.assertTrue(all(root.children[b] is root.children[0x50] for b in range(0x50, 0x58)))
+        self.assertIs(root.children[0x00], Leaf.UD)
+        self.assertIs(root.children[0x00], root.children[0xFF])
+        self.assertEqual(self.emitter(trie, 0, byte=0x53, mod=0), 'PUSH')
+
+    def test_ignore_mod(self) -> None:
+        trie = self.build('NP.0F 20   MOV   Ry_d64(w),Cy_d64   ignore_mod')
+        for mod in (0, 1):
+            entry = trie.lookup(1, {Sel.BYTE: 0x20, Sel.MOD: mod})
+            assert entry is not None
+            self.assertEqual(entry.sets, {Sel.MOD: 1})
+
+    def test_mode64(self) -> None:
+        trie = self.build('63      ARPL     Ew,Gw         chk(i64)',
+                          'W1 63   MOVSXD   Gv(w),Ed      chk(o64)',
+                          'W0 63   MOV      Gv(w),Ev      chk(o64)')
+        for w in (0, 1):
+            self.assertEqual(self.emitter(trie, 0, byte=0x63, mode64=0, w=w), 'ARPL')
+        self.assertEqual(self.emitter(trie, 0, byte=0x63, mode64=1, w=1), 'MOVSXD')
+        self.assertEqual(self.emitter(trie, 0, byte=0x63, mode64=1, w=0), 'MOV')
+
+    def test_vex_implies_np(self) -> None:
+        trie = self.build('VEX.128.0F.WIG 77   VZEROUPPER')
+        self.assertEqual(self.emitter(trie, 1, byte=0x77, prefix=0, enc=ENC_VEX), 'VZEROUPPER')
+        for prefix in (1, 2, 3):
+            self.assertIsNone(self.emitter(trie, 1, byte=0x77, prefix=prefix, enc=ENC_VEX))
+
+    def test_crc32(self) -> None:
+        # With 66 F2, the prefix selector is F2 and 66 is the operand size.
+        trie = self.build('NP|66.0F38 F1   MOVBE   Mv(w),Gv',
+                          'F2.0F38 F1      CRC32   Gd,Ev')
+        self.assertEqual(self.emitter(trie, 2, byte=0xF1, prefix=1, mod=0), 'MOVBE')
+        self.assertEqual(self.emitter(trie, 2, byte=0xF1, prefix=3, mod=1), 'CRC32')
+
+    def test_rex2(self) -> None:
+        trie = self.build('A1           MOV     RAXv(w),Ov',
+                          'REX2.NP.W0 A1   JMP_m   Iq',
+                          '70..7F       Jcc     Jb',
+                          '00           ADD     Eb,Gb')
+        self.assertEqual(self.emitter(trie, 0, byte=0xA1, enc=ENC_LEGACY), 'MOV')
+        self.assertEqual(self.emitter(trie, 0, byte=0xA1, enc=ENC_REX2), 'JMP_m')
+        self.assertEqual(self.emitter(trie, 0, byte=0x75, enc=ENC_LEGACY), 'Jcc')
+        self.assertIsNone(self.emitter(trie, 0, byte=0x75, enc=ENC_REX2))
+        self.assertEqual(self.emitter(trie, 0, byte=0x00, enc=ENC_REX2), 'ADD')
+
+    def test_modrm(self) -> None:
+        trie = self.build('NP.0F 01 /1   SIDT      Ms',
+                          'NP.0F AE /5   LFENCE    Ry(r)')
+        self.assertEqual(self.emitter(trie, 1, byte=0x01, reg=1, mod=0), 'SIDT')
+        self.assertIsNone(self.emitter(trie, 1, byte=0xAE, reg=5, mod=0))
+        self.assertEqual(self.emitter(trie, 1, byte=0xAE, reg=5, mod=1), 'LFENCE')
+
+    def test_memory_modifier(self) -> None:
+        trie = self.build('C4   LES   Gz(w),Ep(m)')
+        self.assertEqual(self.emitter(trie, 0, byte=0xC4, mod=0), 'LES')
+        self.assertIsNone(self.emitter(trie, 0, byte=0xC4, mod=1))
+
+    def test_overlap(self) -> None:
+        self.assertRaises(SemanticError, self.build, '00   ADD   Eb,Gb', '00   ADC   Eb,Gb')
+        self.assertRaises(SemanticError, self.build,
+                          'NP|66.0F 67   X   Vx', '66.0F 67   Y   Vx')
+        self.assertRaises(SemanticError, self.build,
+                          '0F AE /0   X   Ey', 'F3.0F AE /0   Y   Ry(w)')
-- 
2.56.0



