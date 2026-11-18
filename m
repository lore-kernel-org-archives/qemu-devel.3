Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E28606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XoE95gsr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTeiA-0002Rg-8P; Wed, 18 Nov 2026 07:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTei1-0002P1-Q0
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTehx-0004Qq-7p
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795004651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=umXOFHWV85W7hsPv0zdE46wvMxhC+IHZ8lHcDaJBmMc=;
 b=XoE95gsr3sZvhzvUDMuOJ11KvfhHfULsdLykBjttuNoqPJbs4Hm7pz4dqwJPFFOUu8jNAd
 mGTYqw0U5L5jeAMUN+/oyc343RDiyJS4fMqs5w74ddczPgrzPgzpJrbZPm4pgJtiipBHUs
 DY+XTZgUinMoYnUi5wwLCIZFg52dXII=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-eIN0XkilMUm6pM7a5Sq8xw-1; Wed,
 18 Nov 2026 07:24:09 -0500
X-MC-Unique: eIN0XkilMUm6pM7a5Sq8xw-1
X-Mimecast-MFC-AGG-ID: eIN0XkilMUm6pM7a5Sq8xw_1795004648
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D46B918004F5
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:08 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B9D2180055C
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:07 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 08/26] target/i386/tcg: add --explain to maketable.py
Date: Wed, 18 Nov 2026 13:23:39 +0100
Message-ID: <20261118122357.659634-9-pbonzini@redhat.com>
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

[DRAFT commit message written by an AI agent; rewrite before posting.]

Add a debugging aid that shows which lines of the opcode table match an
instruction, given the values of the decoder's selectors, for example:

    python maketable.py --explain 'map=0F byte=BD prefix=F3' decode.def

For selectors that are not given, all the possible outcomes are
printed:

    map 0F, byte BD:
      PREFIX=F3, CPUID(ABM)=1 -> decode.def:734: F3.0F BD                      LZCNT         Gv(w),Ev(zx)              cpuid(ABM)
      PREFIX=F3, CPUID(ABM)=0 -> decode.def:735: 0F BD                         BSR           Gv,Ev(zx)

... whereas if nothing matches, the lines for the same opcode
are listed together with the constraint that rules them out:

    python maketable.py --explain 'map=0 byte=62 mode64=1' decode.def
    map 0, byte 62:
      MOD=mem, MODE64=1 -> #UD
      MOD=reg -> #UD
      decode.def:252: 62                          BOUND    Gv(r),Ma                chk(i64): needs MODE64=0

AI-used-for: code
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode.def           |  31 +++++
 target/i386/tcg/maketable.py         |  43 ++++++-
 target/i386/tcg/maketable_explain.py | 181 +++++++++++++++++++++++++++
 3 files changed, 249 insertions(+), 6 deletions(-)
 create mode 100644 target/i386/tcg/maketable_explain.py

diff --git a/target/i386/tcg/decode.def b/target/i386/tcg/decode.def
index 98c736f3d7c..229d6e05b95 100644
--- a/target/i386/tcg/decode.def
+++ b/target/i386/tcg/decode.def
@@ -161,3 +161,34 @@
 //     nolea, xchg, lock, op0_Rd, op2_Ry, avx_movx, op0_Mw, btEvGv
 //                     special handling from X86InsnSpecial in decode-new.h.
 //                     At most one can be given.
+//
+// Debugging
+// ---------
+//
+// As a debugging aid, maketable.py can show which lines of the opcode table
+// match an instruction, given the values of the decoder's selectors.  For
+// example:
+//
+//     python maketable.py --explain 'map=0F byte=BD prefix=F3' decode.def
+//
+// For selectors that are not given, all the possible outcomes are
+// printed:
+//
+//     map 0F, byte BD:
+//       PREFIX=F3, CPUID(ABM)=1 -> decode.def:734: F3.0F BD                      LZCNT         Gv(w),Ev(zx)              cpuid(ABM)
+//       PREFIX=F3, CPUID(ABM)=0 -> decode.def:735: 0F BD                         BSR           Gv,Ev(zx)
+//
+// ... whereas if nothing matches, the lines for the same opcode
+// are listed together with the constraint that rules them out:
+//
+//     python maketable.py --explain 'map=0 byte=62 mode64=1' decode.def
+//     map 0, byte 62:
+//       MOD=mem, MODE64=1 -> #UD
+//       MOD=reg -> #UD
+//       decode.def:252: 62                          BOUND    Gv(r),Ma                chk(i64): needs MODE64=0
+//
+//     python maketable.py --explain 'map=2 enc=VEX byte=10' decode.def 
+//     map 0F38, byte 10:
+//       ENC=VEX -> #UD
+//       decode.def:867: 66.0F38 10                  PBLENDVB      Vx,Wx              E4 cpuid(SSE41): needs ENC=legacy
+//
diff --git a/target/i386/tcg/maketable.py b/target/i386/tcg/maketable.py
index e657d415235..27a1bcfb6fc 100644
--- a/target/i386/tcg/maketable.py
+++ b/target/i386/tcg/maketable.py
@@ -26,7 +26,7 @@
 import sys
 from collections.abc import Callable, Container
 from dataclasses import dataclass, field, replace
-from typing import ClassVar, Generic, TypeVar, cast, overload
+from typing import ClassVar, Generic, Mapping, TypeVar, cast, overload
 
 T = TypeVar('T')
 
@@ -136,6 +136,7 @@ class Insn:
     modifiers: list[Modifier]
     filename: str = field(default='<string>', compare=False)
     lineno: int = field(default=1, compare=False)
+    text: str = field(default='', compare=False)
 
 
 # The grammar comments in LineParser use EBNF: [ x ] is optional, { x } is
@@ -327,7 +328,7 @@ def parse(self) -> Insn:
         if self.pos != len(self.text):
             raise self.error('expected whitespace or end of line')
         return Insn(prefix, opcode, lobits, modrm_reg, emitter, operands, modifiers,
-                    self.filename, self.lineno)
+                    self.filename, self.lineno, self.text)
 
 
 def parse_line(text: str, filename: str = '<string>', lineno: int = 1) -> Insn | None:
@@ -905,6 +906,11 @@ class Leaf(TrieItem):
     # None only for UD.
     entry: Entry | None = None
 
+    @property
+    def sets(self) -> Mapping[Sel, int]:
+        return self.entry.sets if self.entry is not None else {}
+
+
 Leaf.UD = Leaf(entry=None)
 
 
@@ -1034,16 +1040,41 @@ def build_trie(entries: list[Entry]) -> Trie:
 
 
 def main() -> int:
-    entries: list[Entry] = []
-    for filename in sys.argv[1:]:
+    import argparse
+
+    parser = argparse.ArgumentParser(description='Generate the x86 decoder tables.')
+    parser.add_argument('-o', '--output', help='write the C code to this file')
+    parser.add_argument('--explain', metavar='QUERY', action='append',
+                        help='show which lines match QUERY, for example '
+                             '"map=0F byte=BC prefix=F3 enc=legacy"')
+    parser.add_argument('files', nargs='+')
+    args = parser.parse_args()
+
+    entries = []
+    for filename in args.files:
         with open(filename, encoding='utf-8') as f:
             try:
                 entries += analyze(parse_file(f.readlines(), filename))
             except (ParseError, SemanticError) as e:
                 print(e, file=sys.stderr)
                 return 1
-    for entry in entries:
-        print(entry)
+
+    if args.explain:
+        # Imported here because maketable_explain imports this module.
+        import maketable_explain
+
+        try:
+            trie = build_trie(entries)
+            for query in args.explain:
+                print(maketable_explain.explain(trie, entries, query))
+        except (SemanticError, ValueError) as e:
+            print(e, file=sys.stderr)
+            return 1
+        return 0
+
+    if args.output is None:
+        for entry in entries:
+            print(entry)
     return 0
 
 
diff --git a/target/i386/tcg/maketable_explain.py b/target/i386/tcg/maketable_explain.py
new file mode 100644
index 00000000000..3ffa215afc0
--- /dev/null
+++ b/target/i386/tcg/maketable_explain.py
@@ -0,0 +1,181 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Explain which lines of the opcode table match an instruction, given the
+# values of the decoder's selectors.  Used by "maketable.py --explain".
+
+from dataclasses import dataclass
+from typing import Mapping
+
+from maketable import (
+    PREFIX_MAPS,
+    SEL_VALUES,
+    Entry,
+    Leaf,
+    Node,
+    Sel,
+    Trie,
+    TrieItem,
+)
+
+MAP_NAMES = {0: '0', 1: '0F', 2: '0F38', 3: '0F3A'}
+
+# Names of the values of some selectors, used in queries and in the output.
+VALUE_NAMES = {
+    Sel.PREFIX: ['NP', '66', 'F3', 'F2'],
+    Sel.ENC: ['legacy', 'REX2', 'VEX', 'EVEX'],
+    Sel.MOD: ['mem', 'reg'],
+}
+
+
+@dataclass
+class Query:
+    map: int
+    values: dict[Sel, int]
+    # CPUID features that are present, or None to show both outcomes.
+    features: set[str] | None = None
+
+
+def parse_query(text: str) -> Query:
+    # A query is a list of key=value pairs, for example
+    # "map=0F byte=BC prefix=F3 enc=legacy mod=reg reg=1 cpuid=ABM".  The
+    # map is a name or a number, the opcode byte is in hexadecimal, PREFIX,
+    # ENC and MOD use the names in VALUE_NAMES, and the other selectors in
+    # decode-new.h use numbers.
+    map = 0
+    values: dict[Sel, int] = {}
+    features: set[str] | None = None
+    for item in text.split():
+        key, sep, value = item.partition('=')
+        if not sep:
+            raise ValueError(f'expected key=value: {item}')
+        if key == 'map':
+            map = PREFIX_MAPS[value.upper()] if value.upper() in PREFIX_MAPS else int(value)
+        elif key.upper() == 'BYTE':
+            values[Sel.BYTE] = int(value, 16)
+        elif key.upper() == 'CPUID':
+            features = set() if value == 'none' else set(value.split(','))
+        elif key.upper() in Sel.__members__:
+            sel = Sel[key.upper()]
+            if sel in VALUE_NAMES:
+                names = [name.lower() for name in VALUE_NAMES[sel]]
+                if value.lower() not in names:
+                    raise ValueError(f'{key} must be one of {", ".join(VALUE_NAMES[sel])}')
+                values[sel] = names.index(value.lower())
+            else:
+                values[sel] = int(value)
+        else:
+            raise ValueError(f'unknown key {key}')
+    if Sel.BYTE not in values:
+        raise ValueError('the query needs byte=')
+    for sel, v in values.items():
+        if not 0 <= v < SEL_VALUES[sel]:
+            raise ValueError(f'invalid value {v} for {sel.name}')
+    return Query(map, values, features)
+
+
+@dataclass
+class Match:
+    # Values of the selectors along the path, keyed by selector name (or
+    # CPUID(feature)); the entry is None for #UD.
+    conditions: list[tuple[str, frozenset[int]]]
+    entry: Entry | None
+    sets: Mapping[Sel, int]
+
+
+def matches(trie: Trie, query: Query) -> list[Match]:
+    # Walk the trie; selectors that are not in the query branch over all
+    # the subtrees that they lead to.
+    result: list[Match] = []
+
+    def walk(item: TrieItem, conditions: list[tuple[str, frozenset[int]]]) -> None:
+        assert not isinstance(item, int)
+        if isinstance(item, Leaf):
+            result.append(Match(conditions, item.entry, item.sets))
+            return
+        assert isinstance(item, Node)
+        if item.sel == Sel.CPUID:
+            key = f'CPUID({item.feature})'
+            if query.features is not None:
+                choices = [int(item.feature in query.features)]
+            else:
+                choices = [1, 0]
+            for v in choices:
+                walk(item.children[v], conditions + [(key, frozenset([v]))])
+            return
+
+        key = item.sel.name
+        if item.sel in query.values:
+            v = query.values[item.sel]
+            walk(item.children[v], conditions + [(key, frozenset([v]))])
+            return
+
+        # Group the values that lead to the same subtree.
+        groups: dict[int, list[int]] = {}
+        for v, child in enumerate(item.children):
+            groups.setdefault(id(child), []).append(v)
+        for vs in groups.values():
+            walk(item.children[vs[0]], conditions + [(key, frozenset(vs))])
+
+    root = trie.maps.get(query.map)
+    if root is not None:
+        walk(root, [])
+    return result
+
+
+def candidates(entries: list[Entry], query: Query) -> list[tuple[Entry, str | None]]:
+    # Lines for the same opcode, and why they do not match the query (None
+    # if they are compatible with the values in the query).
+    result: list[tuple[Entry, str | None]] = []
+    byte = query.values[Sel.BYTE]
+    for entry in entries:
+        if entry.map != query.map or byte not in entry.constraints[Sel.BYTE]:
+            continue
+        reason = None
+        for sel, allowed in entry.constraints.items():
+            if sel in query.values and query.values[sel] not in allowed:
+                reason = f'needs {format_values(sel.name, allowed)}'
+                break
+        result.append((entry, reason))
+    return result
+
+
+def format_values(key: str, values: frozenset[int]) -> str:
+    sel = Sel.__members__.get(key)
+    if sel in VALUE_NAMES:
+        return f'{key}=' + '|'.join(VALUE_NAMES[sel][v] for v in sorted(values))
+    fmt = '{:02X}' if key == 'BYTE' else '{}'
+    return f'{key}=' + ','.join(fmt.format(v) for v in sorted(values))
+
+
+def describe(entry: Entry) -> str:
+    return f'{entry.insn.filename}:{entry.insn.lineno}: {entry.insn.text}'
+
+
+def explain(trie: Trie, entries: list[Entry], text: str) -> str:
+    query = parse_query(text)
+    map = MAP_NAMES.get(query.map, f'MAP{query.map}')
+    out = [f'map {map}, byte {query.values[Sel.BYTE]:02X}:']
+    found = matches(trie, query)
+    found_any = any(match.entry is not None for match in found)
+    for match in found:
+        if match.entry is None:
+            # If some branches led to an opcode, leave out those that raise #UD.
+            if found_any:
+               continue
+            result = '#UD'
+        else:
+            result = describe(match.entry)
+        if match.sets:
+            result += ' (sets ' + ', '.join(f'{s.name}={v}' for s, v in match.sets.items()) + ')'
+
+        path = ', '.join(format_values(key, values) for key, values in match.conditions
+                         if key != 'BYTE')
+        out.append(f'  {path or "always"} -> {result}')
+
+    if not found_any:
+        lines = candidates(entries, query)
+        if not lines:
+            out.append('  no lines for this opcode')
+        for entry, reason in lines:
+            out.append(f'  {describe(entry)}: {reason}')
+    return '\n'.join(out)
-- 
2.56.0



