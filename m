Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAC4606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QDjx/dxa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTei6-0002Qw-Qv; Wed, 18 Nov 2026 07:24:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTei0-0002OY-5E
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTehv-0004QW-Dz
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795004650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ETkRm3TbaRCKvUVBMSQX2lMxpvYOQj5Ttq+J/J0ZLQ=;
 b=QDjx/dxajj77sdwJQE2qzYrAg5ZxffNHSHst3QJqcspnX8vkOlZy0TzczKtkNgJiDN7VGG
 VGv/tehCtB3ht+1CTGCgQoYWPgDdWiZ2HlDfzHX/6++b0gsMHWzi163V+Zt6J7cLsLNMzy
 9EhgyCfbVG4PHFCyJJwwyMaOP+/Eu2g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479--hlUEoEkOO2EV3taKgYQJQ-1; Wed,
 18 Nov 2026 07:24:08 -0500
X-MC-Unique: -hlUEoEkOO2EV3taKgYQJQ-1
X-Mimecast-MFC-AGG-ID: -hlUEoEkOO2EV3taKgYQJQ_1795004647
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD5601956072
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:07 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1CFE018004FF
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:06 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 07/26] target/i386/tcg: allow alternatives for the
 encoding and vector length
Date: Wed, 18 Nov 2026 13:23:38 +0100
Message-ID: <20261118122357.659634-8-pbonzini@redhat.com>
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

Allow lines such as "SSE|VEX.66.0F38.128|256 00 PSHUFB Vx,Hx,Wx E4".
These describe an SSE instruction and its AVX version together, which
the hand-written X86OpEntry rows already do.

These lines also enable an extra check that the 66 prefix cannot have an
effect on the operand size when F2 and F3 are allowed.  While this is
expressed in QEMU's code as "F3 and F2 disable 66", changing s->prefix
is not required; instead, making the tables use operand size "y" instead
of "v" has the same effect.

SSE, being the default encoding, can only be written explicitly together
with VEX or EVEX alternatives.  In that case the mandatory prefixes must
be listed because legacy encoding ignores prefixes whereas VEX and EVEX
reject unknown prefixes; in addition, either LIG (alone) or vector length
128 (and possibly more) must be specified, so that the SSE instruction
is actually reachable.

Unlike SSE, VEX and EVEX, REX2 cannot be combined with other encodings.

AI-used-for: code, tests, docs
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h      |   2 +-
 target/i386/tcg/decode.def        |  19 +++--
 target/i386/tcg/maketable.py      | 120 +++++++++++++++++++++---------
 target/i386/tcg/test_maketable.py |  44 +++++++++--
 4 files changed, 134 insertions(+), 51 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 72ab6473e4a..a1cfb1995c6 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -81,7 +81,7 @@ typedef enum X86OpSize {
     X86_SIZE_v,  /* 16/32/64-bit, based on operand size */
     X86_SIZE_w,  /* 16-bit */
     X86_SIZE_x,  /* 128/256-bit, based on operand size */
-    X86_SIZE_y,  /* 32/64-bit, based on operand size */
+    X86_SIZE_y,  /* 32/64-bit, based on REX.W - data prefix ignored */
     X86_SIZE_y_d64,  /* 32/64-bit, based on 64-bit mode */
     X86_SIZE_z,  /* 16-bit for 16-bit operand size, else 32-bit */
     X86_SIZE_z_f64,  /* 32-bit for 32-bit operand size or 64-bit mode, else 16-bit */
diff --git a/target/i386/tcg/decode.def b/target/i386/tcg/decode.def
index 59010401d4e..98c736f3d7c 100644
--- a/target/i386/tcg/decode.def
+++ b/target/i386/tcg/decode.def
@@ -29,10 +29,13 @@
 // The prefix consists of items separated by ".", in any order.  Each item
 // can appear at most once:
 //
-// - The encoding, which is one of SSE, REX2, VEX or EVEX.  The default is the
-//   legacy encoding (no prefix or REX), plus REX2, except in the rows where
-//   REX2 is encoded separately (4, 7, A and E of map 0, 3 and 8 of map 1).
-//   The REX2 encoding can only be specified for those rows.
+// - The encoding, which is one or more of SSE, REX2, VEX or EVEX, separated
+//   by "|".  SSE only needs to be specified if combined with other prefixes
+//   (for example, "SSE|VEX" for an SSE instruction and its AVX version),
+//   since the legacy encoding (no prefix or REX) is the default.  REX2 is
+//   also added automatically except in the rows where REX2 is encoded
+//   separately (4, 7, A and E of map 0, 3 and 8 of map 1); the REX2
+//   encoding can only be specified for those rows.
 //
 // - The allowed mandatory prefixes, which are one or more of NP, 66, F3 or F2,
 //   separated by "|". If none are specified, all are allowed for legacy and REX2
@@ -50,9 +53,11 @@
 // - W0, W1 or WIG specifies REX.W (or equivalently REX2.W, VEX.W EVEX.W).
 //   WIG accepts both values and decodes the instruction as if W were 0.
 //
-// - For VEX and EVEX, the vector length can be L0 or 128, L1 or 256, LZ
-//   (must be zero), or LIG (ignored and decoded as 0).  EVEX also allows
-//   512, LLZ and LLIG.
+// - For VEX and EVEX, one or more vector lengths can be separated by "|".
+//   Valid lengths have multiple spellings due to how the SDM writes them:
+//   VEX allows L0 or 128, L1 or 256, LIG (ignored and decoded as 0), whereas
+//   EVEX allows also LLZ, 512 and LLIG.  The legacy encoding behaves as if L
+//   was 0, so if "SSE" is specified at least one of the lengths must allow L=0.
 //
 // - ND0, ND1, NF0 and NF1 specify EVEX.ND and EVEX.NF for EVEX only.
 //
diff --git a/target/i386/tcg/maketable.py b/target/i386/tcg/maketable.py
index 17a46021be6..e657d415235 100644
--- a/target/i386/tcg/maketable.py
+++ b/target/i386/tcg/maketable.py
@@ -60,7 +60,7 @@ def __call__(self, text: str, pos: int) -> tuple[T, int] | None:
 MODRM_REG = Token(r'[0-7]\b', 'ModRM.reg value', lambda m: int(m[0]))
 WORD = Token(r'\S+', 'field')
 MANDATORY_PREFIX = Token(r'(NP|66|F3|F2)\b', 'mandatory prefix')
-PREFIX_ENCODING = Token(r'(REX2|VEX|EVEX)\b', 'encoding')
+PREFIX_ENCODING = Token(r'(SSE|REX2|VEX|EVEX)\b', 'encoding')
 PREFIX_MAP = Token(r'(0F38|0F3A|0F|MAP[3-7])\b', 'opcode map')
 PREFIX_W = Token(r'(W0|W1|WIG)\b', 'W')
 PREFIX_L = Token(r'(L0|L1|LIG|LZ|LLIG|LLZ|128|256|512)\b', 'vector length')
@@ -70,10 +70,8 @@ def __call__(self, text: str, pos: int) -> tuple[T, int] | None:
 # Prefix items other than the mandatory prefixes, and the corresponding
 # field of Prefix.
 PREFIX_FIELDS = [
-    (PREFIX_ENCODING, 'encoding'),
     (PREFIX_MAP, 'map'),
     (PREFIX_W, 'w'),
-    (PREFIX_L, 'l'),
     (PREFIX_ND, 'nd'),
     (PREFIX_NF, 'nf'),
 ]
@@ -118,11 +116,11 @@ class Modifier:
 
 @dataclass
 class Prefix:
-    encoding: str | None = None
+    encoding: list[str] | None = None
     mandatory: list[str] | None = None
     map: str | None = None
     w: str | None = None
-    l: str | None = None
+    l: list[str] | None = None
     nd: str | None = None
     nf: str | None = None
 
@@ -220,16 +218,19 @@ def has_prefix(self) -> bool:
 
     def parse_prefix_item(self, prefix: Prefix) -> None:
         # prefix_item ::= MANDATORY_PREFIX { '|' MANDATORY_PREFIX }
-        #               | PREFIX_ENCODING | PREFIX_MAP | PREFIX_W | PREFIX_L
-        #               | PREFIX_ND | PREFIX_NF
+        #               | PREFIX_ENCODING { '|' PREFIX_ENCODING }
+        #               | PREFIX_L { '|' PREFIX_L }
+        #               | PREFIX_MAP | PREFIX_W | PREFIX_ND | PREFIX_NF
         start = self.pos
-        if (mandatory := self.accept(MANDATORY_PREFIX)) is not None:
-            if prefix.mandatory is not None:
-                raise self.error('mandatory prefixes listed more than once', start)
-            prefix.mandatory = [mandatory]
-            while self.accept('|') is not None:
-                prefix.mandatory.append(self.expect(MANDATORY_PREFIX))
-            return
+        for tok, name in ((MANDATORY_PREFIX, 'mandatory'), (PREFIX_ENCODING, 'encoding'),
+                          (PREFIX_L, 'l')):
+            if (value := self.accept(tok)) is not None:
+                if getattr(prefix, name):
+                    raise self.error(f'{tok.name}s listed more than once', start)
+                setattr(prefix, name, [value])
+                while self.accept('|') is not None:
+                    getattr(prefix, name).append(self.expect(tok))
+                return
 
         for tok, name in PREFIX_FIELDS:
             if (value := self.accept(tok)) is not None:
@@ -418,10 +419,17 @@ class Sel(enum.Enum):
 W_VALUES = {'W0': frozenset([0]), 'W1': frozenset([1])}
 L_VALUES = {
     'L0': frozenset([0]), '128': frozenset([0]), 'LZ': frozenset([0]), 'LLZ': frozenset([0]),
-    'L1': frozenset([1]), '256': frozenset([1]),
+    'L1': frozenset([1]), '256': frozenset([1]), 'LIG': frozenset([0]), 'LLIG': frozenset([0]),
     '512': frozenset([2]),
 }
 
+L_FOR_ENC = {
+    ENC_LEGACY: {0},
+    ENC_REX2:   {0},
+    ENC_VEX:    {0, 1},
+    ENC_EVEX:   {0, 1, 2},
+}
+
 
 class SemanticError(Exception):
     def __init__(self, insn: Insn, msg: str):
@@ -484,6 +492,11 @@ def c_names(path: str, prefix: str) -> frozenset[str]:
 # Operand types that are encoded in the ModRM byte.
 MODRM_TYPES = {'C', 'D', 'E', 'G', 'M', 'N', 'P', 'Q', 'R', 'S', 'U', 'V', 'W'}
 
+# Operand sizes that depend on PREFIX_DATA
+# Note that 'y' effectively *disables* PREFIX_DATA by upgrading MO_16 to MO_32,
+# so it is not included here.
+OPERAND_DFLAG_SIZES = {'p', 's', 'v', 'z', 'z_f64', 'd64'}
+
 # Access to each operand if neither r nor w is given, indexed by the number
 # of operands.  These match the X86_OP_ENTRY0..X86_OP_ENTRY4 macros.
 DEFAULT_ACCESS = [
@@ -519,6 +532,12 @@ def constrains(self, sel: Sel, checked: frozenset[str]) -> bool:
     def error(self, msg: str) -> SemanticError:
         return SemanticError(self.insn, msg)
 
+    def encodings(self) -> set[str]:
+        if not self.insn.prefix.encoding:
+            return {'LEGACY'}
+
+        return set('LEGACY' if x == 'SSE' else x for x in self.insn.prefix.encoding)
+
     def features(self) -> list[str]:
         # CPUID features from cpuid() are all required.
         for m in self.insn.modifiers:
@@ -536,38 +555,58 @@ def is_rex2(self) -> bool:
 
     def check_prefix(self) -> None:
         prefix = self.insn.prefix
-        enc = prefix.encoding
+        for items in (prefix.mandatory, prefix.encoding, prefix.l):
+            if items is not None and len(set(items)) != len(items):
+                raise self.error(f'{items[0]} listed more than once')
 
-        if prefix.mandatory is not None and len(set(prefix.mandatory)) != len(prefix.mandatory):
-            raise self.error('mandatory prefix listed more than once')
+        if prefix.encoding and 'SSE' in prefix.encoding and 'VEX' not in prefix.encoding:
+            raise self.error('SSE only allowed together with VEX')
+        enc = self.encodings()
+        if 'REX2' in enc and len(enc) > 1:
+            raise self.error('REX2 cannot be combined with other encodings')
 
         # VEX.L and EVEX.L'L do not exist in other encodings, and 512-bit
-        # vectors, L'L and ND/NF only exist in EVEX.
-        if prefix.l is not None and enc not in ('VEX', 'EVEX'):
-            raise self.error(f'{prefix.l} needs VEX or EVEX')
-        if prefix.l in ('512', 'LLIG', 'LLZ') and enc != 'EVEX':
-            raise self.error(f'{prefix.l} needs EVEX')
-        for item in (prefix.nd, prefix.nf):
-            if item is not None and enc != 'EVEX':
+        # vectors, L'L and ND/NF only exist in EVEX.  The legacy encoding
+        # behaves as if L was 0.
+        lengths = prefix.l or []
+        if lengths and not enc & {'VEX', 'EVEX'}:
+            raise self.error(f'{lengths[0]} needs VEX or EVEX')
+        for item in lengths:
+            if item in ('512', 'LLIG', 'LLZ') and 'EVEX' not in enc:
                 raise self.error(f'{item} needs EVEX')
+        if len(lengths) > 1 and ('LIG' in lengths or 'LLIG' in lengths):
+            raise self.error('LIG and LLIG cannot be combined with other vector lengths')
+        if (lengths and 'LEGACY' in enc
+                and not any(0 in L_VALUES[item] for item in lengths)):
+            raise self.error('the vector length excludes the legacy encoding, '
+                             'which behaves as if L was 0')
+        for flag in (prefix.nd, prefix.nf):
+            if flag is not None and 'EVEX' not in enc:
+                raise self.error(f'{flag} needs EVEX')
 
         # VEX can encode maps 1-3 and 7, and EVEX maps 1-7, while REX2 can
         # only encode maps 0 and 1.
         if prefix.map is not None and prefix.map.startswith('MAP'):
             allowed = {'VEX', 'EVEX'} if prefix.map == 'MAP7' else {'EVEX'}
-            if enc not in allowed:
+            if not enc <= allowed:
                 raise self.error(f'{prefix.map} needs ' + ' or '.join(sorted(allowed)))
-        if enc in ('VEX', 'EVEX') and prefix.map is None:
-            raise self.error(f'{enc} needs an opcode map')
-        if enc == 'REX2' and prefix.map not in (None, '0F'):
+        if enc & {'VEX', 'EVEX'} and prefix.map is None:
+            raise self.error('VEX and EVEX need an opcode map')
+        if 'REX2' in enc and prefix.map not in (None, '0F'):
             raise self.error(f'REX2 cannot encode map {prefix.map}')
 
+        # The default mandatory prefixes differ between the legacy encoding
+        # and VEX/EVEX.
+        if 'LEGACY' in enc and enc & {'VEX', 'EVEX'} and prefix.mandatory is None:
+            raise self.error('list the mandatory prefixes when combining LEGACY '
+                             'with VEX or EVEX, or split in two entries')
+
         # Elsewhere, REX2 is the same as the legacy encoding.
-        if enc == 'REX2' and not self.is_rex2():
+        if 'REX2' in enc and not self.is_rex2():
             raise self.error('REX2 lines are only needed for rows 4, 7, A, E of map 0 '
                              'and 3, 8 of map 1')
         checks = {arg for m in self.insn.modifiers if m.name == 'chk' for arg in m.args}
-        if enc == 'REX2' and 'no_rex2' in checks:
+        if 'REX2' in enc and 'no_rex2' in checks:
             raise self.error('REX2 is incompatible with chk(no_rex2)')
 
     def check_opcode(self) -> None:
@@ -640,6 +679,13 @@ def check_operands(self) -> None:
                 raise self.error(f'missing size for {op.type} operand')
             if op.size not in OPERAND_SIZES:
                 raise self.error(f'unknown operand size {op.size}')
+            if op.size in OPERAND_DFLAG_SIZES and self.insn.prefix.encoding and \
+                    self.insn.prefix.mandatory and \
+                    ('F3' in self.insn.prefix.mandatory or 'F2' in self.insn.prefix.mandatory):
+                # forbid sizes that would be affected by the 66 prefix, because
+                # F3 and F2 disable the prefix.  Note that F2 0F 38 F1 (CRC32 Gd, Ev)
+                # *is* affected by the 66 prefix and valid.
+                raise self.error(f'cannot use scalable operand size {op.size} for SSE instruction')
 
             for mod in op.mods:
                 if mod not in OPERAND_MODS:
@@ -764,7 +810,7 @@ def compute_constraints(self) -> None:
 
         if prefix.mandatory is not None:
             c[Sel.PREFIX] = frozenset(MANDATORY_PREFIXES[p] for p in prefix.mandatory)
-        elif prefix.encoding in ('VEX', 'EVEX'):
+        elif self.encodings() <= {'VEX', 'EVEX'}:
             # VEX.pp and EVEX.pp are part of the opcode; like in the SDM,
             # no mandatory prefix means NP.
             c[Sel.PREFIX] = frozenset([MANDATORY_PREFIXES['NP']])
@@ -772,7 +818,7 @@ def compute_constraints(self) -> None:
         # Lines without an encoding also accept REX2, except in the rows
         # where REX2 has its own lines.
         checks = {arg for m in self.insn.modifiers if m.name == 'chk' for arg in m.args}
-        encs = set(ENCODINGS[e] for e in [prefix.encoding or 'LEGACY'])
+        encs = set(ENCODINGS[e] for e in self.encodings())
         if ENC_LEGACY in encs and not self.is_rex2() and 'no_rex2' not in checks:
             encs.add(ENC_REX2)
 
@@ -788,10 +834,14 @@ def compute_constraints(self) -> None:
             self.sets[Sel.W] = 0
         elif prefix.w is not None:
             c[Sel.W] = W_VALUES[prefix.w]
-        if prefix.l in ('LIG', 'LLIG'):
+
+        if prefix.l in (['LIG'], ['LLIG']):
             self.sets[Sel.L] = 0
         elif prefix.l is not None:
-            c[Sel.L] = L_VALUES[prefix.l]
+            l_all = frozenset().union(*(L_FOR_ENC[e] for e in encs))
+            l_constraint = l_all & frozenset().union(*(L_VALUES[item] for item in prefix.l))
+            if l_constraint != l_all:
+                c[Sel.L] = frozenset(l_constraint)
 
         if self.features():
             c[Sel.CPUID] = frozenset([1])
diff --git a/target/i386/tcg/test_maketable.py b/target/i386/tcg/test_maketable.py
index b32d47a58bd..a0759d3ad7f 100644
--- a/target/i386/tcg/test_maketable.py
+++ b/target/i386/tcg/test_maketable.py
@@ -39,7 +39,7 @@ def parse(self, text: str) -> Insn:
     def test_vex(self) -> None:
         insn = self.parse('VEX.NP|66.0F.WIG 67   PACKUSWB     Vx,Hx,Wx     E4(avx2_256, mmx)')
         self.assertEqual(insn, Insn(
-            prefix=Prefix(encoding='VEX', mandatory=['NP', '66'], map='0F', w='WIG'),
+            prefix=Prefix(encoding=['VEX'], mandatory=['NP', '66'], map='0F', w='WIG'),
             opcode=(0x67, 0x67), lobits=False, modrm_reg=None, emitter='PACKUSWB',
             operands=[Operand('V', 'x'), Operand('H', 'x'), Operand('W', 'x')],
             modifiers=[Modifier('E4', ['avx2_256', 'mmx'])]))
@@ -97,22 +97,27 @@ def test_legacy_prefix(self) -> None:
 
     def test_evex_prefix(self) -> None:
         insn = self.parse('EVEX.512.66.0F38.W1 00   VPSHUFB   Vx,Hx,Wx')
-        self.assertEqual(insn.prefix, Prefix(encoding='EVEX', mandatory=['66'],
-                                             map='0F38', w='W1', l='512'))
+        self.assertEqual(insn.prefix, Prefix(encoding=['EVEX'], mandatory=['66'],
+                                             map='0F38', w='W1', l=['512']))
         insn = self.parse('EVEX.LLZ.NP.MAP4.W0 00   ADD   Bb,Eb,Gb')
-        self.assertEqual(insn.prefix, Prefix(encoding='EVEX', mandatory=['NP'],
-                                             map='MAP4', w='W0', l='LLZ'))
+        self.assertEqual(insn.prefix, Prefix(encoding=['EVEX'], mandatory=['NP'],
+                                             map='MAP4', w='W0', l=['LLZ']))
 
     def test_apx_prefix(self) -> None:
         insn = self.parse('EVEX.LLZ.NP|66.MAP4.ND0.NF1 40..4F   CFCMOVcc   Gv,Ev')
-        self.assertEqual(insn.prefix, Prefix(encoding='EVEX', mandatory=['NP', '66'],
-                                             map='MAP4', l='LLZ', nd='ND0', nf='NF1'))
+        self.assertEqual(insn.prefix, Prefix(encoding=['EVEX'], mandatory=['NP', '66'],
+                                             map='MAP4', l=['LLZ'], nd='ND0', nf='NF1'))
 
     def test_rex2_prefix(self) -> None:
         insn = self.parse('REX2.NP.W0 A1   JMP_m   Iq   chk(no_adr)')
-        self.assertEqual(insn.prefix, Prefix(encoding='REX2', mandatory=['NP'], w='W0'))
+        self.assertEqual(insn.prefix, Prefix(encoding=['REX2'], mandatory=['NP'], w='W0'))
         self.assertEqual(insn.opcode, (0xA1, 0xA1))
 
+    def test_alternatives(self) -> None:
+        insn = self.parse('SSE|VEX.66.0F38.128|256 00   PSHUFB   Vx,Hx,Wx')
+        self.assertEqual(insn.prefix, Prefix(encoding=['SSE', 'VEX'], mandatory=['66'],
+                                             map='0F38', l=['128', '256']))
+
     def test_modrm(self) -> None:
         insn = self.parse('0F 01 /1   SIDT   Ms')
         self.assertEqual(insn.modrm_reg, 1)
@@ -288,6 +293,12 @@ def test_valid(self) -> None:
             with self.subTest(text=text):
                 self.analyze(text)
 
+    def test_operand_scalable(self) -> None:
+        self.analyze('SSE|VEX.NP|66.0F 50   MOVMSK Gy, Ux')
+        self.analyze('F2.0F38 F1            CRC32  Gd, Ev')
+        self.assertRaises(SemanticError, self.analyze, 'SSE|VEX.F2.0F 50   MOVMSK Gv, Ux')
+        self.assertRaises(SemanticError, self.analyze, 'SSE|VEX.F3.0F 50   MOVMSK Gv, Ux')
+
     def test_operand_errors(self) -> None:
         bad = [
             '00   X   Ab',              # unknown type
@@ -344,10 +355,18 @@ def test_prefix(self) -> None:
             'VEX.ND1.66.0F 67   X   Vx',       # ND without EVEX
             'NF0.0F 67   X   Vx',              # NF without EVEX
             'VEX.66.MAP4 67   X   Vx',         # MAP4 without EVEX
+            'SSE|VEX.66.MAP7 67   X   Vx',     # MAP7 with the legacy encoding
             'VEX.66 67   X   Vx',              # VEX without a map
             'EVEX.66 67   X   Vx',             # EVEX without a map
             'REX2.0F38 00   X   Vx',           # REX2 only has maps 0 and 1
             'REX2.0F 05   SYSCALL',            # same as legacy
+            'REX2|VEX.0F 05   X',              # REX2 combined with others
+            'VEX|VEX.0F 05   X',               # repeated encoding
+            'SSE.0F 05   X',                   # SSE only makes sense with VEX
+            'SSE|VEX.0F 05   X',               # mandatory prefixes needed
+            'SSE|VEX.66.0F.256 05   X',        # legacy has L=0
+            'VEX.66.0F.LIG|128 05   X',        # LIG combined with others
+            'VEX.66.0F.128|512 05   X',        # 512 needs EVEX
             'REX2 A1..B0   X   Iq',            # partly same as legacy
             'REX2 A1       X   Iq  chk(no_rex2)', # REX2 + no_rex2
         ]
@@ -473,6 +492,15 @@ def test_rex2(self) -> None:
         self.assertIsNone(self.emitter(trie, 0, byte=0x75, enc=ENC_REX2))
         self.assertEqual(self.emitter(trie, 0, byte=0x00, enc=ENC_REX2), 'ADD')
 
+    def test_sse_and_vex(self) -> None:
+        trie = self.build('SSE|VEX.66.0F38.128|256 00   PSHUFB   Vx,Hx,Wx   E4',
+                          'VEX.66.0F38.256 01   X256   Vx,Hx,Wx   E4')
+        for enc, l in ((ENC_LEGACY, 0), (ENC_VEX, 0), (ENC_VEX, 1)):
+            self.assertEqual(self.emitter(trie, 2, byte=0x00, prefix=1, enc=enc, l=l), 'PSHUFB')
+        self.assertIsNone(self.emitter(trie, 2, byte=0x00, prefix=1, enc=ENC_EVEX))
+        self.assertIsNone(self.emitter(trie, 2, byte=0x00, prefix=0, enc=ENC_LEGACY))
+        self.assertIsNone(self.emitter(trie, 2, byte=0x01, prefix=1, enc=ENC_VEX, l=0))
+
     def test_modrm(self) -> None:
         trie = self.build('NP.0F 01 /1   SIDT      Ms',
                           'NP.0F AE /5   LFENCE    Ry(r)')
-- 
2.56.0



