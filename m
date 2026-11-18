Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CAF606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ak5lBqqo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTei1-0002OV-E8; Wed, 18 Nov 2026 07:24:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTehu-0002Ly-91
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTehq-0004BC-GS
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795004645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y/Oi6/1euWnPAp1HWDcANIizaUdw9SZNiaLThClhgdE=;
 b=ak5lBqqoaegHyGC0DeBImWrhLjNwfYUD93jJ7ELoXkwAxHlRZoAeBEX41wJ+Ozkj8+gNOn
 pFzY9fva6CO/b150pO2dr9oo4vPBNhqNPuf0PUkHiLMigrL5/LYRAdlFCXnFpu1sZvWXEZ
 57265p892ZTefNRdIYbZ7CK2NiO4DK8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-PDb-H2F8OPOaU_bt80zLsA-1; Wed,
 18 Nov 2026 07:24:03 -0500
X-MC-Unique: PDb-H2F8OPOaU_bt80zLsA-1
X-Mimecast-MFC-AGG-ID: PDb-H2F8OPOaU_bt80zLsA_1795004642
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4ECA5195605F
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:02 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9F0A118004FF
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:01 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 02/26] target/i386/tcg: add semantic checks for the
 decoder table description
Date: Wed, 18 Nov 2026 13:23:33 +0100
Message-ID: <20261118122357.659634-3-pbonzini@redhat.com>
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

The parser only checks the syntax of decode.def; most mistakes in a
line, such as a misspelled operand size or two modifiers that set the
same field of X86OpEntry, would only show up when compiling the
generated C code, or not at all.

Add a semantic pass that checks each line and reports errors for
combinations that are forbidden by X86OpEntry (only the first operand
can be written, a fourth operand must be Ib, modifiers that set the
same field are mutually exclusive) not encodable (such as a vector
length without VEX or EVEX) or conflicting (/digit together with an
operand in ModRM.reg, or +r with operands that need a ModRM byte).

The pass also normalizes the operands, so that later stages need not
know about the shortcuts that the format allows:

- the access of each operand is made explicit.  Unless r or w are
  given, it depends on the number of operands, in the same way as the
  X86_OP_ENTRY1..X86_OP_ENTRY4 macros: rw, rw/r, w/r/r and w/r/r/r.
  M operands are always in memory, I and J operands are always read.

- with +r, the R operand becomes LoBits.

- I(zx) becomes I_unsigned, because the immediate is zero extended when
  it is fetched, while zx on other operands extends the loaded value.

- E(nop) becomes the nop operand type.

The names of operand sizes, checks, CPUID features and SVM intercepts
are taken from decode-new.h and svm.h, so that the two cannot get out
of sync.  Operand types, modifiers and exception classes are listed in
maketable.py, because they do not map one-to-one to C names.

AI-used-for: code, tests
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc  |   1 +
 target/i386/tcg/decode.def        |   4 +-
 target/i386/tcg/maketable.py      | 318 +++++++++++++++++++++++++++++-
 target/i386/tcg/test_maketable.py | 188 ++++++++++++++++++
 4 files changed, 503 insertions(+), 8 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index ed9e967e32f..2dc5f2ecf9e 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2472,6 +2472,7 @@ static bool decode_op_size(DisasContext *s, X86OpEntry *e, X86OpSize size, MemOp
             *ot = MO_64;
             return true;
         }
+        /* TODO: this should be checked statically by maketable.py.  */
         if (s->vex_l && e->s0 != X86_SIZE_qq && e->s1 != X86_SIZE_qq) {
             return false;
         }
diff --git a/target/i386/tcg/decode.def b/target/i386/tcg/decode.def
index ace24019edb..e18cc054ee5 100644
--- a/target/i386/tcg/decode.def
+++ b/target/i386/tcg/decode.def
@@ -44,8 +44,8 @@
 //
 // - The opcode map, which is 0F, 0F38 or 0F3A, or MAP3-MAP7.  Note that
 //   the encoding limits which map can be specified: VEX and EVEX require a map
-//   and allow MAP3 to MAP7, REX2 can only use the default map (one-byte opcodes)
-//   or map 0F.
+//   and allow MAP3 to MAP7, whereas REX2 can only use the default map (one-byte
+//   opcodes) or map 0F.
 //
 // - W0, W1 or WIG specifies REX.W (or equivalently REX2.W, VEX.W EVEX.W).
 //   WIG accepts both values and decodes the instruction as if W were 0.
diff --git a/target/i386/tcg/maketable.py b/target/i386/tcg/maketable.py
index 8334428cbaf..841c376c6b0 100644
--- a/target/i386/tcg/maketable.py
+++ b/target/i386/tcg/maketable.py
@@ -20,10 +20,11 @@
 
 from __future__ import annotations
 
+import pathlib
 import re
 import sys
 from collections.abc import Callable
-from dataclasses import dataclass, field
+from dataclasses import dataclass, field, replace
 from typing import Generic, TypeVar, cast, overload
 
 T = TypeVar('T')
@@ -346,17 +347,322 @@ def parse_file(lines: list[str], filename: str = '<string>') -> list[Insn]:
     return insns
 
 
+class SemanticError(Exception):
+    def __init__(self, insn: Insn, msg: str):
+        super().__init__(msg)
+        self.filename = insn.filename
+        self.lineno = insn.lineno
+        self.msg = msg
+
+    def __str__(self) -> str:
+        return f'{self.filename}:{self.lineno}: {self.msg}'
+
+
+def c_names(path: str, prefix: str) -> frozenset[str]:
+    # Identifiers in a C source file that start with prefix, without it.
+    text = (pathlib.Path(__file__).parent / path).read_text(encoding='utf-8')
+    return frozenset(re.findall(rf'\b{prefix}(\w+)', text))
+
+
+OPERAND_SIZES = c_names('decode-new.h', 'X86_SIZE_') - {'None'}
+CHECK_NAMES = c_names('decode-new.h', 'X86_CHECK_')
+CPUID_FEATURES = c_names('decode-new.h', 'X86_FEAT_') - {'None', 'NR'}
+SVM_EXITS = c_names('../svm.h', 'SVM_EXIT_')
+
+
+# Operand types; LoBits and I_unsigned are only produced by the semantic
+# pass.
+OPERAND_TYPE_NAMES = (set('BCDEGHIJMNOPQRSUVW') |
+                      {'RAX', 'RCX', 'RDX', 'RBX', 'RSP', 'RBP', 'RSI', 'RDI',
+                       'ES', 'CS', 'SS', 'DS', 'FS', 'GS', 'ZERO', 'LoBits'})
+
+# Operand types that can be zero- or sign-extended (X86OpExt).
+INTEGER_TYPES = {'B', 'E', 'G', 'I', 'M', 'O', 'R',
+                 'RAX', 'RCX', 'RDX', 'RBX', 'RSP', 'RBP', 'RSI', 'RDI'}
+
+OPERAND_MODS = {'r', 'w', 'm', 'zx', 'sx', 'nop'}
+
+# Modifiers without arguments, grouped by the X86OpEntry field they set.
+SPECIAL_MODIFIERS = {'nolea', 'xchg', 'lock', 'op0_Rd', 'op2_Ry', 'avx_movx',
+                     'op0_Mw', 'btEvGv', 'popESP'}
+OTHER_MODIFIERS = {'ignore_mod'}
+
+# Exception classes, and their arguments (which set vex_special, except for
+# mmx which still sets special).
+EXCEPTION_CLASSES = ({f'E{n}' for n in range(1, 14)} |
+                     {'APX', 'APX_cmp', 'APX_pp2', 'APX_zu'})
+EXCEPTION_ARGS = {'unaligned', 'rep-scalar', 'avx2_256', 'mmx'}
+
+# Modifiers that are implied by the operand type.
+IMPLIED_MODS = {'M': 'm', 'I': 'r', 'J': 'r'}
+
+# Operand types that cannot be written or used as memory operands.
+READ_ONLY_TYPES = {'I', 'J'}
+
+# Operand types that are registers encoded in ModRM.reg.
+MODRM_REG_TYPES = {'C', 'D', 'G', 'P', 'S', 'V'}
+
+# Operand types that are registers encoded in ModRM.rm.
+REGISTER_TYPES = {'R', 'U', 'N'}
+
+# Operand types that are encoded in the ModRM byte.
+MODRM_TYPES = {'C', 'D', 'E', 'G', 'M', 'N', 'P', 'Q', 'R', 'S', 'U', 'V', 'W'}
+
+# Access to each operand if neither r nor w is given, indexed by the number
+# of operands.  These match the X86_OP_ENTRY0..X86_OP_ENTRY4 macros.
+DEFAULT_ACCESS = [
+    [],
+    [['r', 'w']],
+    [['r', 'w'], ['r']],
+    [['w'], ['r'], ['r']],
+    [['w'], ['r'], ['r'], ['r']],
+]
+
+
+@dataclass
+class Entry:
+    insn: Insn
+    operands: list[Operand] = field(init=False, default_factory=list)
+
+    def error(self, msg: str) -> SemanticError:
+        return SemanticError(self.insn, msg)
+
+    def check_prefix(self) -> None:
+        prefix = self.insn.prefix
+        enc = prefix.encoding
+
+        if prefix.mandatory is not None and len(set(prefix.mandatory)) != len(prefix.mandatory):
+            raise self.error('mandatory prefix listed more than once')
+
+        # VEX.L and EVEX.L'L do not exist in other encodings, and 512-bit
+        # vectors, L'L and ND/NF only exist in EVEX.
+        if prefix.l is not None and enc not in ('VEX', 'EVEX'):
+            raise self.error(f'{prefix.l} needs VEX or EVEX')
+        if prefix.l in ('512', 'LLIG', 'LLZ') and enc != 'EVEX':
+            raise self.error(f'{prefix.l} needs EVEX')
+        for item in (prefix.nd, prefix.nf):
+            if item is not None and enc != 'EVEX':
+                raise self.error(f'{item} needs EVEX')
+
+        # VEX can encode maps 1-3 and 7, and EVEX maps 1-7, while REX2 can
+        # only encode maps 0 and 1.
+        if prefix.map is not None and prefix.map.startswith('MAP'):
+            allowed = {'VEX', 'EVEX'} if prefix.map == 'MAP7' else {'EVEX'}
+            if enc not in allowed:
+                raise self.error(f'{prefix.map} needs ' + ' or '.join(sorted(allowed)))
+        if enc in ('VEX', 'EVEX') and prefix.map is None:
+            raise self.error(f'{enc} needs an opcode map')
+        if enc == 'REX2' and prefix.map not in (None, '0F'):
+            raise self.error(f'REX2 cannot encode map {prefix.map}')
+
+    def check_opcode(self) -> None:
+        lo, hi = self.insn.opcode
+        # With +r, bits 0-2 of the opcode are the register number, so the
+        # range must lie within a single group of 8 opcodes.  90..97 is split
+        # between NOP and XCHG, so allow any range that does not cross a
+        # multiple of 8 rather than requiring exactly 8 opcodes.
+        if self.insn.lobits and lo // 8 != hi // 8:
+            raise self.error('+r range must not cross a multiple of 8')
+
+    def check_modrm(self) -> None:
+        if self.insn.modrm_reg is not None:
+            # /digit is stored in a ModRM byte, which +r says is absent.
+            if self.insn.lobits:
+                raise self.error('+r cannot be used together with a modrm byte')
+
+            # /digit is stored in ModRM.reg, so no operand can use it.
+            for op in self.insn.operands:
+                if op.type in MODRM_REG_TYPES:
+                    raise self.error(f'/digit cannot be used with {op.type} operands')
+
+        # R, U and N are register operands (mod == 3), M and other operands
+        # with the m modifier are memory operands (mod != 3).
+        ignore_mod = any(m.name == 'ignore_mod' for m in self.insn.modifiers)
+        register = any(op.type in REGISTER_TYPES for op in self.insn.operands) or ignore_mod
+        memory = any('m' in op.mods for op in self.operands)
+        if register and memory:
+            raise self.error('register and memory operands both use ModRM.rm')
+
+    def check_operands(self) -> None:
+        if self.insn.lobits:
+            # With +r, R is the only operand that uses the register number,
+            # There must be only one and no other operand may need a ModRM byte.
+            if sum(op.type == 'R' for op in self.insn.operands) != 1:
+                raise self.error('+r needs exactly one R operand')
+            if any(op.type in MODRM_TYPES and op.type != 'R' for op in self.insn.operands):
+                raise self.error('+r cannot be used with operands that need ModRM')
+
+        if len(self.insn.operands) >= len(DEFAULT_ACCESS):
+            raise self.error(f'at most {len(DEFAULT_ACCESS) - 1} operands are supported')
+
+        if self.insn.operands:
+            # X86OpEntry has a single destination (op0), so only the first
+            # operand can be written.
+            if any('w' in op.mods for op in self.insn.operands[1:]):
+                raise self.error('only the first operand can be written')
+
+            # The fourth operand is always an 8-bit immediate (see X86_OP_ENTRY4).
+            # A r/w operand counts as two.
+            slots = len(self.insn.operands)
+            mods = self.insn.operands[0].mods
+            if 'r' not in mods and 'w' not in mods and 'nop' not in mods:
+                mods = DEFAULT_ACCESS[slots][0]
+            if 'r' in mods and 'w' in mods:
+                slots += 1
+            if slots == 4:
+                op = self.insn.operands[-1]
+                if op.type != 'I' or op.size != 'b' or op.mods:
+                    raise self.error('the fourth operand must be Ib')
+
+        for op in self.insn.operands:
+            # The register in the upper 4 bits of an immediate (the SDM's
+            # /is4) is extracted by the emitter, see gen_ternary_sse().
+            if op.type == 'L':
+                raise self.error('L operands are not supported, use Ib and decode->immediate')
+            if op.type not in OPERAND_TYPE_NAMES:
+                raise self.error(f'unknown operand type {op.type}')
+            if op.size is None:
+                raise self.error(f'missing size for {op.type} operand')
+            if op.size not in OPERAND_SIZES:
+                raise self.error(f'unknown operand size {op.size}')
+
+            for mod in op.mods:
+                if mod not in OPERAND_MODS:
+                    raise self.error(f'unknown operand modifier {mod}')
+            if len(set(op.mods)) != len(op.mods):
+                raise self.error('operand modifier listed more than once')
+
+            # zx and sx set the X86OpExt of the operand.
+            if 'zx' in op.mods and 'sx' in op.mods:
+                raise self.error('zx and sx are mutually exclusive')
+            if ('zx' in op.mods or 'sx' in op.mods) and op.type not in INTEGER_TYPES:
+                raise self.error(f'{op.type} operands cannot be extended')
+            if op.type == 'I' and 'sx' in op.mods:
+                raise self.error('immediates are sign extended by default')
+
+            # Immediates and jump offsets are only read, and are not in memory.
+            if op.type in READ_ONLY_TYPES and ('w' in op.mods or 'm' in op.mods):
+                raise self.error(f'{op.type} operands can only be read')
+
+            # nop is an E or R operand whose ModRM byte is decoded, but that is
+            # not loaded or stored; it has no access.
+            if 'nop' in op.mods:
+                if op.type not in ('E', 'R'):
+                    raise self.error('nop is only valid for E and R operands')
+                if 'r' in op.mods or 'w' in op.mods:
+                    raise self.error('nop operands are neither read nor written')
+
+    def fixup_operands(self) -> None:
+        num_operands = len(self.insn.operands)
+        for op, default_access in zip(self.insn.operands, DEFAULT_ACCESS[num_operands]):
+            type = op.type
+            mods = list(op.mods)
+
+            # M is always a memory operand, I and J are always read.
+            implied = IMPLIED_MODS.get(type)
+            if implied is not None and implied not in mods:
+                mods.append(implied)
+
+            # Unless given explicitly (including through IMPLIED_MODS), the
+            # access depends on the position and number of operands.
+            if 'r' not in mods and 'w' not in mods and 'nop' not in mods:
+                mods += default_access
+
+            # With +r, R does not come from a ModRM byte and becomes LoBits.
+            if type == 'R' and self.insn.lobits:
+                type = 'LoBits'
+
+            # For immediates, zero extension is done by the decoder when it
+            # fetches the operand, and is selected by the I_unsigned type.
+            # For other operands, zx is kept and selects zero extension of
+            # the loaded value (X86_EXT_Unsigned); remove it here so that it
+            # does not end up in the ext fields as well.
+            if type == 'I' and 'zx' in mods:
+                type = 'I_unsigned'
+                mods.remove('zx')
+            elif 'nop' in mods:
+                type = 'nop'
+                mods.remove('nop')
+            self.operands.append(replace(op, type=type, mods=mods))
+
+    def check_modifiers(self) -> None:
+        names = [m.name for m in self.insn.modifiers]
+        for name in set(names):
+            if names.count(name) > 1:
+                raise self.error(f'modifier {name} listed more than once')
+
+        specials = []
+        vex_specials = []
+        classes = []
+        for m in self.insn.modifiers:
+            if m.name == 'chk':
+                if not m.args:
+                    raise self.error('chk needs at least one argument')
+                for arg in m.args:
+                    if arg not in CHECK_NAMES:
+                        raise self.error(f'unknown check {arg}')
+                if 'i64' in m.args and 'o64' in m.args:
+                    raise self.error('chk(i64) and chk(o64) are mutually exclusive')
+            elif m.name == 'cpuid':
+                if not m.args or any(arg not in CPUID_FEATURES for arg in m.args):
+                    raise self.error('cpuid needs one or more CPUID features (X86_FEAT_*)')
+                if len(set(m.args)) != len(m.args):
+                    raise self.error('CPUID feature listed more than once')
+            elif m.name == 'svm':
+                if len(m.args) != 1 or m.args[0] not in SVM_EXITS:
+                    raise self.error('svm needs one intercept (SVM_EXIT_*)')
+            elif m.name in EXCEPTION_CLASSES:
+                classes.append(m.name)
+                if len(set(m.args)) != len(m.args):
+                    raise self.error(f'argument listed more than once for {m.name}')
+                for arg in m.args:
+                    if arg not in EXCEPTION_ARGS:
+                        raise self.error(f'unknown argument {arg} for {m.name}')
+                    # For now mmx still sets the special field of X86OpEntry.
+                    if arg == 'mmx':
+                        specials.append(arg)
+                    else:
+                        vex_specials.append(arg)
+            elif m.name in SPECIAL_MODIFIERS or m.name in OTHER_MODIFIERS:
+                if m.args:
+                    raise self.error(f'{m.name} does not take arguments')
+                if m.name in SPECIAL_MODIFIERS:
+                    specials.append(m.name)
+            else:
+                raise self.error(f'unknown modifier {m.name}')
+
+        # Each of these sets a single field of X86OpEntry.
+        if len(specials) > 1:
+            raise self.error(f'{" and ".join(specials)} are mutually exclusive')
+        if len(vex_specials) > 1:
+            raise self.error(f'{" and ".join(vex_specials)} are mutually exclusive')
+        if len(classes) > 1:
+            raise self.error('more than one exception class')
+
+    def __post_init__(self) -> None:
+        self.check_prefix()
+        self.check_opcode()
+        self.check_operands()
+        self.fixup_operands()
+        self.check_modrm()
+        self.check_modifiers()
+
+
+def analyze(insns: list[Insn]) -> list[Entry]:
+    return [Entry(insn) for insn in insns]
+
+
 def main() -> int:
-    insns: list[Insn] = []
+    entries: list[Entry] = []
     for filename in sys.argv[1:]:
         with open(filename, encoding='utf-8') as f:
             try:
-                insns += parse_file(f.readlines(), filename)
-            except ParseError as e:
+                entries += analyze(parse_file(f.readlines(), filename))
+            except (ParseError, SemanticError) as e:
                 print(e, file=sys.stderr)
                 return 1
-    for insn in insns:
-        print(insn)
+    for entry in entries:
+        print(entry)
     return 0
 
 
diff --git a/target/i386/tcg/test_maketable.py b/target/i386/tcg/test_maketable.py
index 1f4a1cb0876..0015bed9a23 100644
--- a/target/i386/tcg/test_maketable.py
+++ b/target/i386/tcg/test_maketable.py
@@ -7,11 +7,14 @@
 import unittest
 
 from maketable import (
+    Entry,
     Insn,
     Modifier,
     Operand,
     ParseError,
     Prefix,
+    SemanticError,
+    analyze,
     parse_file,
     parse_line,
 )
@@ -168,3 +171,188 @@ def test_error_position(self) -> None:
             parse_line('84   TEST   Eb(r)X', 'foo.def', 7)
         self.assertEqual(str(cm.exception),
                          'foo.def:7:18: expected whitespace or end of line')
+
+
+class TestSemantic(unittest.TestCase):
+    def analyze(self, text: str) -> Entry:
+        insn = parse_line(text)
+        assert insn is not None
+        return analyze([insn])[0]
+
+    def mods(self, text: str) -> list[set[str]]:
+        return [set(op.mods) for op in self.analyze(text).operands]
+
+    def test_lobits(self) -> None:
+        entry = self.analyze('91..97+r   XCHG   RAXv,Rv')
+        self.assertEqual([op.type for op in entry.operands], ['RAX', 'LoBits'])
+        entry = self.analyze('50..57+r   PUSH   Rd64(r)')
+        self.assertEqual(entry.operands, [Operand('LoBits', 'd64', ['r'])])
+        self.assertEqual(self.mods('91..97+r   XCHG   RAXv,Rv'), [{'r', 'w'}, {'r'}])
+
+    def test_lobits_no_modrm(self) -> None:
+        self.assertRaises(SemanticError, self.analyze, '50..57+r /0   PUSH   Rd64(r)')
+        self.assertRaises(SemanticError, self.analyze, '50..57+r   PUSH   Rd64(r),Ev')
+
+    def test_lobits_one_register(self) -> None:
+        self.assertRaises(SemanticError, self.analyze, '50..57+r   PUSH   Ib')
+        self.assertRaises(SemanticError, self.analyze, '50..57+r   PUSH   Rv,Rv')
+
+    def test_lobits_range(self) -> None:
+        self.assertRaises(SemanticError, self.analyze, '54..5B+r   PUSH   Rd64(r)')
+        self.assertRaises(SemanticError, self.analyze, '50..5F+r   PUSH   Rd64(r)')
+
+    def test_default_access(self) -> None:
+        self.assertEqual(self.mods('FE /0   INC   Eb   lock'), [{'r', 'w'}])
+        self.assertEqual(self.mods('00   ADD   Eb,Gb   lock'), [{'r', 'w'}, {'r'}])
+        self.assertEqual(self.mods('EVEX.LLZ.NP.MAP4.W0 00   ADD   Bb,Eb,Gb'),
+                         [{'w'}, {'r'}, {'r'}])
+        self.assertEqual(self.mods('VEX.66.0F3A.WIG 0F   PALIGNR   Vx,Hx,Wx,Ib'),
+                         [{'w'}, {'r'}, {'r'}, {'r'}])
+
+    def test_explicit_access(self) -> None:
+        self.assertEqual(self.mods('84   TEST   Eb(r),Gb'), [{'r'}, {'r'}])
+        self.assertEqual(self.mods('58..5F+r   POP   Rd64(w)'), [{'w'}])
+        self.assertEqual(self.mods('8B   MOV   Gv(w),Ev'), [{'w'}, {'r'}])
+        self.assertEqual(self.mods('F3.0F AE /2   WRxxBASE   Ry(r,zx)'), [{'r', 'zx'}])
+        self.assertEqual(self.mods('87   XCHG   Ev(r,w),Gv'), [{'r', 'w'}, {'r'}])
+
+    def test_only_first_written(self) -> None:
+        self.assertRaises(SemanticError, self.analyze, '87   XCHG   Ev,Gv(w)')
+        self.assertRaises(SemanticError, self.analyze, '8B   MOV   Gv(r),Ev(w)')
+
+    def test_fourth_operand(self) -> None:
+        self.analyze('VEX.66.0F3A.W0 4A   VBLENDVPS   Vx,Hx,Wx,Ib')
+        self.analyze('0F A4               SHLD        Ev(w,r),Gv,Ib')
+        # not a fourth operand
+        self.analyze('69                  IMUL3       Gv,Ev,Iz')
+        self.assertRaises(SemanticError, self.analyze, '00   X   Vx(w,r),Wx,Iw')
+        self.assertRaises(SemanticError, self.analyze, '00   X   Vx,Hx,Wx,Iw')
+        self.assertRaises(SemanticError, self.analyze, '00   X   Vx,Hx,Wx,Ib(zx)')
+        self.assertRaises(SemanticError, self.analyze, '00   X   Vx,Hx,Wx,Wx')
+
+    def test_no_l_operand(self) -> None:
+        self.assertRaises(SemanticError, self.analyze,
+                          'VEX.66.0F3A.W0 4A   VBLENDVPS   Vx,Hx,Wx,Lx')
+
+    def test_too_many_operands(self) -> None:
+        self.assertRaises(SemanticError, self.analyze, '00   X   Vx,Hx,Wx,Ib,Ib')
+
+    def test_implied_mods(self) -> None:
+        self.assertEqual(self.mods('NP.W0.0F C7 /1   CMPXCHG8B   Mq   lock cpuid(CX8)'),
+                         [{'m', 'r', 'w'}])
+        self.assertEqual(self.mods('C4   LES   Gz(w),Mp(m)   chk(i64)'), [{'w'}, {'m', 'r'}])
+        self.assertEqual(self.mods('68   PUSH   Iz'), [{'r'}])
+
+    def test_read_only(self) -> None:
+        self.assertEqual(self.mods('EB   JMP   Jb'), [{'r'}])
+        self.assertRaises(SemanticError, self.analyze, '68   PUSH   Iz(w)')
+        self.assertRaises(SemanticError, self.analyze, '68   PUSH   Iz(m)')
+        self.assertRaises(SemanticError, self.analyze, 'EB   JMP   Jb(w)')
+
+    def test_unsigned_immediate(self) -> None:
+        entry = self.analyze('E4   IN   RAXb(w),Ib(zx)')
+        self.assertEqual(entry.operands[1], Operand('I_unsigned', 'b', ['r']))
+        entry = self.analyze('68   PUSH   Iz')
+        self.assertEqual(entry.operands[0].type, 'I')
+
+    def test_nop(self) -> None:
+        entry = self.analyze('0F 1F   NOP   Ev(nop)')
+        self.assertEqual(entry.operands, [Operand('nop', 'v')])
+        self.assertRaises(SemanticError, self.analyze, '0F 1F   NOP   Ev(nop,r)')
+        self.assertRaises(SemanticError, self.analyze, '0F 1F   NOP   Gv(nop)')
+        entry = self.analyze('NP.0F AE /5   LFENCE   Rd(nop)')
+        self.assertEqual(entry.operands, [Operand('nop', 'd')])
+        self.assertRaises(SemanticError, self.analyze, '50..57+r   PUSH   Rv,Ev(nop)')
+
+    def test_valid(self) -> None:
+        lines = [
+            'VEX.NP|66.0F.WIG 67   PACKUSWB   Vx,Hx,Wx   E4(avx2_256, mmx)',
+            'NP|66.0F 6F   MOVDQ   Vx(w),Wx   E4(unaligned, mmx)',
+            'F3.0F 6F   MOVDQU   Vx(w),Wx   E4(unaligned)',
+            'F3.0F AE /2   WRxxBASE   Ry(r,zx)   cpuid(FSGSBASE) chk(o64)',
+            '9D   POPF   chk(vm86_iopl) svm(POPF)',
+            'EVEX.LLZ.NP|66.MAP4.ND0.NF1 40..4F   CFCMOVcc   Gv(w),ZEROv,Mv   APX',
+            'NP.0F 20   MOV   Ry_d64(w),Cy_d64   ignore_mod chk(cpl0)',
+        ]
+        for text in lines:
+            with self.subTest(text=text):
+                self.analyze(text)
+
+    def test_operand_errors(self) -> None:
+        bad = [
+            '00   X   Ab',              # unknown type
+            '00   X   E(r)',            # missing size
+            '00   X   Eqq64',           # unknown size
+            '00   X   Eb(q)',           # unknown operand modifier
+            '00   X   Eb(r,r)',         # repeated operand modifier
+            '00   X   Eb(zx,sx)',       # zx and sx
+            '00   X   Vx(zx)',          # zx on a vector operand
+            '00   X   Ib(sx)',          # immediates are signed already
+        ]
+        for text in bad:
+            with self.subTest(text=text):
+                self.assertRaises(SemanticError, self.analyze, text)
+
+    def test_modifier_errors(self) -> None:
+        bad = [
+            '00   X   Eb   locked',               # unknown modifier
+            '00   X   Eb   lock lock',            # repeated
+            '00   X   Eb   chk(i64) chk(prot)',   # repeated
+            '00   X   Eb   lock(1)',              # arguments for a flag
+            '00   X   Eb   chk(foo)',             # unknown check
+            '00   X   Eb   cpuid(FOO)',           # unknown feature
+            '00   X   Eb   cpuid(SSE, SSE)',      # more than one feature
+            '00   X   Eb   svm(FOO)',             # unknown intercept
+            '00   X   Eb   lock nolea',           # both set special
+            '00   X   Eb   mmx',                  # mmx is an argument of E1..E13
+            '00   X   Vx   E4(mmx) lock',         # both set special
+            '00   X   Vx   E4(mmx, mmx)',         # repeated argument
+            '00   X   Vx   E4(unaligned, avx2_256)',  # both set vex_special
+            '00   X   Vx   E4 E5',                # two exception classes
+            '00   X   Vx   E4(aligned)',          # unknown argument
+        ]
+        for text in bad:
+            with self.subTest(text=text):
+                self.assertRaises(SemanticError, self.analyze, text)
+
+    def test_prefix(self) -> None:
+        good = [
+            'VEX.LZ.NP.0F38.W0 F3 /1   BLSR   Bd(w),Ed',
+            'EVEX.512.66.0F38.W1 00   VPSHUFB   Vx,Hx,Wx',
+            'EVEX.LLZ.NP.MAP4.ND1.NF0 00   ADD   Bb,Eb,Gb',
+            'REX2.NP.W0 A1   JMP_m   Iq(r)',
+            'REX2.0F 05   SYSCALL',
+        ]
+        for text in good:
+            with self.subTest(text=text):
+                self.analyze(text)
+
+        bad = [
+            'NP|NP.0F 67   X   Vx',            # repeated mandatory prefix
+            'L0.0F 67   X   Vx',               # L without VEX or EVEX
+            'VEX.512.66.0F 67   X   Vx',       # 512 without EVEX
+            'VEX.LLZ.66.0F 67   X   Vx',       # LLZ without EVEX
+            'VEX.ND1.66.0F 67   X   Vx',       # ND without EVEX
+            'NF0.0F 67   X   Vx',              # NF without EVEX
+            'VEX.66.MAP4 67   X   Vx',         # MAP4 without EVEX
+            'VEX.66 67   X   Vx',              # VEX without a map
+            'EVEX.66 67   X   Vx',             # EVEX without a map
+            'REX2.0F38 00   X   Vx',           # REX2 only has maps 0 and 1
+        ]
+        for text in bad:
+            with self.subTest(text=text):
+                self.assertRaises(SemanticError, self.analyze, text)
+
+    def test_modrm(self) -> None:
+        self.analyze('80 /3   SBB   Eb,Ib   lock')
+        self.analyze('NP.0F AE /5   LFENCE')
+        for text in ['80 /3   X   Gb,Ib',
+                     '0F 71 /2   X   Vx,Ib',
+                     '0F 20 /0   X   Ry,Cy',
+                     'NP.0F 20   X   Mq   ignore_mod',
+                     'NP.0F 20   X   Ry,Mq']:
+            with self.subTest(text=text):
+                self.assertRaises(SemanticError, self.analyze, text)
+
+    def test_mode64(self) -> None:
+        self.assertRaises(SemanticError, self.analyze, '63   X   Ew,Gw   chk(i64, o64)')
-- 
2.56.0



