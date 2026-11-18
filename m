Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAAC606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZQixPt+H
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTei4-0002QH-Kl; Wed, 18 Nov 2026 07:24:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTehv-0002MP-MV
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTeht-0004PK-Jk
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795004649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eM1zYvj0hiN0WCKibtQfKwk4bUqp+pEx5+LmXGp9N2s=;
 b=ZQixPt+HQVxLkr9vE9mpP813wQbzRc/DvcRDXHMgFbECw9PRpWOhSD04+Pgijj5Dod10Q1
 9B5PcqALZs+qjLvNGBDXXHpA77vjUb7kZMob5CP2WuyKu0VzTIlpemUmpZovhHznSkBI8t
 FT2DapRU0to9IDMEvfEKHDvV6w8v6NU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-ls-s44g5Ode4AD9ORc2nqQ-1; Wed,
 18 Nov 2026 07:24:06 -0500
X-MC-Unique: ls-s44g5Ode4AD9ORc2nqQ-1
X-Mimecast-MFC-AGG-ID: ls-s44g5Ode4AD9ORc2nqQ_1795004645
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82E69195608F
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:05 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D203D18004FF
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:04 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 05/26] target/i386/tcg: add CPUID checks to the trie
Date: Wed, 18 Nov 2026 13:23:36 +0100
Message-ID: <20261118122357.659634-6-pbonzini@redhat.com>
In-Reply-To: <20261118122357.659634-1-pbonzini@redhat.com>
References: <20261118122357.659634-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Make cpuid() an ordinary constraint, instead of covering it in
disas_insn(), so that opcodes can decode differently depending on CPUID
features, instead of just raising #UD when it is absent.  For example,
F3 0F BC is TZCNT with ABM and BSF without.  Allow two entries to overlap
if exactly one of them has cpuid(); the trie then tests the feature and
picks the entry with cpuid() if it is present, and the other one if not.

Implementing cpuid() in maketable.py also allows checking for multiple
CPUID features, which is particularly useful for AES+AVX or AES+AVX+VAES.

AI-used-for: code, tests
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/maketable.py      | 76 +++++++++++++++++++++++++------
 target/i386/tcg/test_maketable.py |  1 +
 2 files changed, 63 insertions(+), 14 deletions(-)

diff --git a/target/i386/tcg/maketable.py b/target/i386/tcg/maketable.py
index 826d82a2780..a1ebc906899 100644
--- a/target/i386/tcg/maketable.py
+++ b/target/i386/tcg/maketable.py
@@ -24,7 +24,7 @@
 import pathlib
 import re
 import sys
-from collections.abc import Callable
+from collections.abc import Callable, Container
 from dataclasses import dataclass, field, replace
 from typing import ClassVar, Generic, TypeVar, cast, overload
 
@@ -360,6 +360,7 @@ class Sel(enum.Enum):
     MODE64 = enum.auto()
     ND = enum.auto()
     NF = enum.auto()
+    CPUID = enum.auto()
 
 
 # Number of values of each selector.
@@ -374,6 +375,7 @@ class Sel(enum.Enum):
     Sel.MODE64: 2,
     Sel.ND: 2,
     Sel.NF: 2,
+    Sel.CPUID: 2,
 }
 
 # Values of the selectors that an entry accepts; a selector that is not
@@ -496,12 +498,21 @@ def accepts(self, sel: Sel, v: int) -> bool:
         allowed = self.constraints.get(sel)
         return allowed is None or v in allowed
 
-    def constrains(self, sel: Sel) -> bool:
+    def constrains(self, sel: Sel, checked: frozenset[str]) -> bool:
+        if sel == Sel.CPUID:
+            return any(f not in checked for f in self.features())
         return sel in self.constraints
 
     def error(self, msg: str) -> SemanticError:
         return SemanticError(self.insn, msg)
 
+    def features(self) -> list[str]:
+        # CPUID features from cpuid() are all required.
+        for m in self.insn.modifiers:
+            if m.name == 'cpuid':
+                return m.args
+        return []
+
     def is_rex2(self) -> bool:
         # Whether the opcodes are in the rows where REX2 differs from the
         # legacy encoding
@@ -763,6 +774,9 @@ def compute_constraints(self) -> None:
         elif prefix.l is not None:
             c[Sel.L] = L_VALUES[prefix.l]
 
+        if self.features():
+            c[Sel.CPUID] = frozenset([1])
+
         if prefix.nd is not None:
             c[Sel.ND] = frozenset([prefix.nd == 'ND1'])
         if prefix.nf is not None:
@@ -829,6 +843,9 @@ class Leaf(TrieItem):
 class Node(TrieItem):
     sel: Sel
 
+    # For Sel.CPUID only, the feature that is tested.
+    feature: str | None = None
+
     # Subtree for each value of the selector, initially UD.  Several values
     # can share the same subtree, for example all opcodes of 50..57+r or
     # all values of L for LIG.  When flattening, subtrees are replaced
@@ -845,9 +862,9 @@ def __post_init__(self) -> None:
 # the same opcode, for example CMOVcc and the mask register instructions.
 # MODE64 is last because chk(i64) and chk(o64) are mostly checks on a single
 # line; checking it earlier would duplicate the subtrees for all the other
-# lines of the same opcode.
+# lines of the same opcode.  The same is true of cpuid().
 SEL_ORDER = [Sel.BYTE, Sel.ENC, Sel.L, Sel.PREFIX, Sel.REG, Sel.MOD,
-             Sel.W, Sel.ND, Sel.NF, Sel.MODE64]
+             Sel.W, Sel.ND, Sel.NF, Sel.MODE64, Sel.CPUID]
 
 
 @dataclass
@@ -857,28 +874,57 @@ class Trie:
     # Sel.BYTE.
     maps: dict[int, Node] = field(default_factory=dict)
 
-    def lookup(self, map: int, values: dict[Sel, int]) -> Entry | None:
-        # Walk the trie; selectors that are not in values are 0.
+    def lookup(self, map: int, values: dict[Sel, int],
+               features: Container[str] = frozenset()) -> Entry | None:
+        # Walk the trie; selectors that are not in values are 0.  If
+        # features is given, it lists the CPUID features that are present.
         item: TrieItem = self.maps[map]
         while isinstance(item, Node):
-            item = item.children[values.get(item.sel, 0)]
+            if item.sel == Sel.CPUID:
+                assert item.feature is not None
+                item = item.children[item.feature in features]
+            else:
+                item = item.children[values.get(item.sel, 0)]
         assert isinstance(item, Leaf)
         return item.entry
 
 
-# Key of the cache of subtrees: the position in SEL_ORDER of the first
-# selector that is left, and the candidate entries.
-CacheKey = tuple[int, tuple[int, ...]]
+# Key of the cache of subtrees: the selectors that are left, the CPUID
+# features that were checked, and the candidate entries.
+CacheKey = tuple[int, frozenset[str], tuple[int, ...]]
 
 
-def build_subtree(entries: list[Entry], start: int, cache: dict[CacheKey, TrieItem]) -> TrieItem:
+def build_cpuid_node(entries: list[Entry], start: int, cache: dict[CacheKey, TrieItem],
+                     checked: frozenset[str]) -> Node:
+    def unchecked(entry: Entry, checked: frozenset[str]) -> list[str]:
+        return [f for f in entry.features() if f not in checked]
+
+    # Each CPUID node checks one feature, so lines with several features
+    # need several nodes.  Lines without cpuid() are only used if the
+    # feature is absent (for example BSF and TZCNT).
+    feature = next(f for e in entries for f in unchecked(e, checked))
+    need = [e for e in entries if feature in unchecked(e, checked)]
+    fallback = [e for e in entries if not unchecked(e, checked)]
+    if len(need) + len(fallback) != len(entries):
+        lines = ', '.join(f'{e.insn.filename}:{e.insn.lineno}' for e in entries)
+        raise entries[0].error(f'different cpuid() for the same opcode: {lines}')
+
+    node = Node(sel=Sel.CPUID, feature=feature)
+    checked = checked | {feature}
+    node.children[0] = build_subtree(fallback, start, cache, checked)
+    node.children[1] = build_subtree(need, start, cache, checked)
+    return node
+
+
+def build_subtree(entries: list[Entry], start: int, cache: dict[CacheKey, TrieItem],
+                  checked: frozenset[str] = frozenset()) -> TrieItem:
     # Entries with the same set of candidates share the subtree.
-    key = (start, tuple(id(e) for e in entries))
+    key = (start, checked, tuple(id(e) for e in entries))
     if key in cache:
         return cache[key]
 
     pos = next((i for i in range(start, len(SEL_ORDER))
-                if any(e.constrains(SEL_ORDER[i]) for e in entries)), None)
+                if any(e.constrains(SEL_ORDER[i], checked) for e in entries)), None)
     sel = None if pos is None else SEL_ORDER[pos]
     item: TrieItem
     if sel is None:
@@ -886,12 +932,14 @@ def build_subtree(entries: list[Entry], start: int, cache: dict[CacheKey, TrieIt
             other = entries[1].insn
             raise entries[0].error(f'overlaps with {other.filename}:{other.lineno}')
         item = Leaf(entry=entries[0]) if entries else Leaf.UD
+    elif sel == Sel.CPUID:
+        item = build_cpuid_node(entries, start, cache, checked)
     else:
         assert pos is not None
         node = Node(sel=sel)
         for v in range(SEL_VALUES[sel]):
             subset = [e for e in entries if e.accepts(sel, v)]
-            node.children[v] = build_subtree(subset, pos + 1, cache)
+            node.children[v] = build_subtree(subset, pos + 1, cache, checked)
 
         # If all values lead to the same subtree, the node is not needed.
         # The opcode byte is kept, because it is the root of each map.
diff --git a/target/i386/tcg/test_maketable.py b/target/i386/tcg/test_maketable.py
index 11e3c6dc1d5..b32d47a58bd 100644
--- a/target/i386/tcg/test_maketable.py
+++ b/target/i386/tcg/test_maketable.py
@@ -27,6 +27,7 @@
     parse_file,
     parse_line,
 )
+import collections.abc
 
 
 class TestParser(unittest.TestCase):
-- 
2.56.0



