Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42414606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AQLdnSWe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTei3-0002PO-Dg; Wed, 18 Nov 2026 07:24:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTehu-0002Lx-5g
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTehq-000496-7g
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795004645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ctvfEBYo/Gr0Q1sIS0TxLL5uMKPFyGSpwPWoeu12/CI=;
 b=AQLdnSWe1Yyco/hqVgdkV5ZVFM7HB7CX5ZM6MOgV2BEKjKl6orIhb1fLFWZ9ZmOimMGnaB
 G5Ae3UsI3/QbBB90AJkMmHQpg64n4EYFtQCszTgzqyhg+ACsSpZ+GIL2EMwyKTli+4bkk/
 rXjxUoqAPmGba1ChBR+wQgsOIdiLrXI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-DjEzE5yRN86tdN5Bso7ing-1; Wed,
 18 Nov 2026 07:24:02 -0500
X-MC-Unique: DjEzE5yRN86tdN5Bso7ing-1
X-Mimecast-MFC-AGG-ID: DjEzE5yRN86tdN5Bso7ing_1795004641
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 168CC180057D
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:01 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3213B18004FF
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:23:59 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 01/26] target/i386/tcg: add parser for a textual
 description of the decoder tables
Date: Wed, 18 Nov 2026 13:23:32 +0100
Message-ID: <20261118122357.659634-2-pbonzini@redhat.com>
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

Introduce a parser for a line-oriented description of the tables in
decode-new.c.inc.  Instruction bytes are written close to the Intel SDM
notation, while opcodes and modifiers resemble QEMU's current notation
(which is itself a descendent of a notation that Intel has since mostly
abandoned).

  VEX.NP|66.0F.WIG 67   PACKUSWB     Vx,Hx,Wx     mmx avx2_256 E4
  80 /3                 SBB          Bb,Eb,Ib     lock
  F3.0F AE /2..3        WRxxBASE     Ry(r,zx)     cpuid(FSGSBASE) chk(o64)
  50..57+r              PUSH         Rd64(r)

The first field, which is optional, if followed by another opcode byte,
is a dotted list of prefix items (encoding, mandatory prefixes, map,
W, L, ND, NF).

The second is the opcode, which can be a range; with an optional
suffix which can take two forms.  "+r" after it means that bits 0-2
of the opcode select the register for the R operand (LoBits) and
that there is no ModRM byte, while "/digit" gives the value of
ModRM.reg to match on.

The second field is the name of the emitter function (sans gen_).

Then comes the operands, which are made of a type, a size and optional
modifiers in parentheses: r/w/nop override the default access, zx and
sx to zero- and sign-extend the operand, m to require a memory operand.

Finally the instruction modifiers provide extra constraints to the
decoder and fill in the remaining rows of X86DecodedInsn.

The parser is a recursive descent parser with no tokenizer, because the
meaning of a token depends on the column (E4 is an opcode byte in the
first column and an exception class in the last).

AI-used-for: code, tests, docs
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode.def        | 157 +++++++++++++
 target/i386/tcg/maketable.py      | 365 ++++++++++++++++++++++++++++++
 target/i386/tcg/meson.build       |   7 +
 target/i386/tcg/test_maketable.py | 170 ++++++++++++++
 4 files changed, 699 insertions(+)
 create mode 100644 target/i386/tcg/decode.def
 create mode 100644 target/i386/tcg/maketable.py
 create mode 100644 target/i386/tcg/test_maketable.py

diff --git a/target/i386/tcg/decode.def b/target/i386/tcg/decode.def
new file mode 100644
index 00000000000..ace24019edb
--- /dev/null
+++ b/target/i386/tcg/decode.def
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// Opcode table for the x86 TCG decoder.
+//
+// Each line describes one opcode, or a range of opcodes:
+//
+//     [prefix] opcode[..opcode][+r] [/digit[..digit]] emitter [operands] [modifiers...]
+//
+// for example:
+//
+//     80 /3               SBB        Bb,Eb,Ib          lock
+//     50..57+r            PUSH       Rd64(r)
+//     NP.W0.0F C7 /1      CMPXCHG8B  Mq                lock cpuid(CX8)
+//     F3.0F AE /2         WRxxBASE   Ry(r,zx)          cpuid(FSGSBASE) chk(o64)
+//     VEX.NP|66.0F.WIG 67 PACKUSWB   Vx,Hx,Wx          E4(avx2_256, mmx)
+//
+// Fields are separated by spaces or tabs, and "//" starts a comment that
+// extends to the end of the line.  No two lines may describe the same
+// opcode, except as described under "cpuid" below.
+//
+//
+// Prefix
+// ------
+//
+// The prefix field is parsed if the second field is a valid opcode byte.
+// Otherwise, the first field is considered to be the opcode byte and
+// there is no prefix.
+//
+// The prefix consists of items separated by ".", in any order.  Each item
+// can appear at most once:
+//
+// - The encoding, which is one of SSE, REX2, VEX or EVEX.  The default is the
+//   legacy encoding (no prefix or REX), plus REX2, except in the rows where
+//   REX2 is encoded separately (4, 7, A and E of map 0, 3 and 8 of map 1).
+//   The REX2 encoding can only be specified for those rows.
+//
+// - The allowed mandatory prefixes, which are one or more of NP, 66, F3 or F2,
+//   separated by "|". If none are specified, all are allowed for legacy and REX2
+//   encodings, whereas for VEX and EVEX, NP is implied.  F2 takes precedence over
+//   F3, and both over 66.  Note that the legacy encoding lets the 66 prefix modify
+//   operand size of v and z operands even if the F2 and/or F3 prefixes are there.
+//   z operands even if another mandatory prefix is specified (which is needed
+//   for 66 F2 0F 38 F1, CRC32 r32, r/m16).
+//
+// - The opcode map, which is 0F, 0F38 or 0F3A, or MAP3-MAP7.  Note that
+//   the encoding limits which map can be specified: VEX and EVEX require a map
+//   and allow MAP3 to MAP7, REX2 can only use the default map (one-byte opcodes)
+//   or map 0F.
+//
+// - W0, W1 or WIG specifies REX.W (or equivalently REX2.W, VEX.W EVEX.W).
+//   WIG accepts both values and decodes the instruction as if W were 0.
+//
+// - For VEX and EVEX, the vector length can be L0 or 128, L1 or 256, LZ
+//   (must be zero), or LIG (ignored and decoded as 0).  EVEX also allows
+//   512, LLZ and LLIG.
+//
+// - ND0, ND1, NF0 and NF1 specify EVEX.ND and EVEX.NF for EVEX only.
+//
+//
+// Opcode
+// ------
+//
+// The opcode is a byte in uppercase hexadecimal, or a range such as 70..7F.
+//
+// +r directly after the opcode means that bits 0-2 of the opcode select
+// the register for the R operand, and that there is no ModRM byte.  The
+// range must not cross a multiple of 8.  The register is associated
+// with an operand of type R, which is normally used for ModRM.reg, and no
+// other operand can use ModRM.
+//
+// /digit, separated by a space, is the value of ModRM.reg.  Operands cannot
+// use ModRM.reg in that case, so the C, D, G, P, S and V types are excluded.
+//
+//
+// Emitter
+// -------
+//
+// The name of the gen_* function in emit.c.inc, without the gen_ prefix.
+//
+//
+// Operands
+// --------
+//
+// There are up to four operands, separated by commas.  Each operand consists
+// of a type, a size, and an optional list of modifiers (also separated by
+// commas and enclosed in parentheses).  Examples: Gv, Ep(m), Ry(r,zx).
+//
+// Types are the uppercase letters from X86OpType in decode-new.h (except
+// L), the hard-coded registers RAX, RCX, RDX, RBX, RSP, RBP, RSI, RDI, the
+// segment registers ES, CS, SS, DS, FS, GS, and ZERO.  An immediate whose
+// high bits select a register (the SDM's /is4) is written as Ib, and the
+// emitter extracts the register from decode->immediate.
+//
+// Sizes are the lowercase names from X86OpSize in decode-new.h, such as
+// b, w, d, q, v, z, y, x, dq, qq, d64 or y_d64.  The size is required.
+//
+// The modifiers are:
+//
+//     r, w    the operand is read or written.  Without them, the access
+//             depends on the number of operands: rw / rw,r / w,r,r /
+//             w,r,r,r.  Only the first operand can be written.  I and J
+//             are always read.
+//
+//     m       the operand is in memory (ModRM.mod != 3).  M operands are
+//             always in memory, while R, U and N operands are always
+//             registers (ModRM.mod == 3); the decoder uses this to choose
+//             between lines for the same opcode.
+//
+//     zx, sx  zero or sign extend an integer operand after it is loaded.
+//             Immediates are sign extended unless overridden by I(zx).
+//
+//     nop     decode the ModRM byte of an E or R operand without reading or
+//             writing the operand.  R(nop) can be used to require
+//             ModRM.mod == 3 and any ModRM.rm for instructions that have
+//             no operands.
+//
+// The fourth operand, if present, must be Ib.
+//
+//
+// Modifiers
+// ---------
+//
+//     chk(a, ...)     checks from X86InsnCheck in decode-new.h, without the
+//                     X86_CHECK_ prefix.  i64 and o64 also choose between
+//                     lines for the same opcode.
+//
+//     cpuid(feature, ...)
+//                     one or more X86CPUIDFeatures that the instruction needs.
+//                     All must be present; for example, 256-bit
+//                     VAESENC needs cpuid(AES, AVX, VAES).  Two lines can
+//                     describe the same opcode if only one has cpuid().
+//                     That line is used if the features are present;
+//                     otherwise the other line is used (for example,
+//                     TZCNT and BSF).
+//
+//     svm(exit)       the SVM intercept, without the SVM_EXIT_ prefix.
+//
+//     E1 ... E13      the exception class for SSE, VEX and EVEX
+//                     instructions.  Without one, VEX and EVEX encodings
+//                     raise #UD.  These modifiers take zero or more of the
+//                     arguments "unaligned", "rep-scalar", "avx2_256" and "mmx",
+//                     "unaligned" means that the legacy SSE encoding does
+//                     not require aligned memory operands; "rep-scalar"
+//                     that F3 and F2 encodings change "x" operands to ss and
+//                     sd respectively; "avx2_256" that 256-bit VEX operands
+//                     need AVX2, and "mmx" that with no mandatory prefix the
+//                     instruction operates on MMX registers.
+//
+//     APX, APX_cmp, APX_pp2, APX_zu
+//                     the decoding specifics for MAP4 AVX instructions.
+//
+//     ignore_mod      ModRM.mod is ignored and treated as 3 (MOV to and
+//                     from control and debug registers).
+//
+//     nolea, xchg, lock, op0_Rd, op2_Ry, avx_movx, op0_Mw, btEvGv
+//                     special handling from X86InsnSpecial in decode-new.h.
+//                     At most one can be given.
diff --git a/target/i386/tcg/maketable.py b/target/i386/tcg/maketable.py
new file mode 100644
index 00000000000..8334428cbaf
--- /dev/null
+++ b/target/i386/tcg/maketable.py
@@ -0,0 +1,365 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Parser for the x86 opcode table description.
+#
+# Each line describes one opcode, or a range of opcodes:
+#
+#   [prefix] opcode[..opcode][+r] /digit emitter [operands] [modifiers...]
+#
+# for example:
+#
+#   VEX.NP|66.0F.WIG 67   PACKUSWB     Vx,Hx,Wx     E4(avx2_256, mmx)
+#   80 /3                 SBB          Bb,Eb,Ib     lock
+#   F3.0F AE /2           WRxxBASE     Ry(r,zx)     cpuid(FSGSBASE) chk(o64)
+#   50..57+r              PUSH         Rd64(r)
+#
+# For more details see decode.def.
+#
+# '//' starts a comment that extends to the end of the line.
+
+from __future__ import annotations
+
+import re
+import sys
+from collections.abc import Callable
+from dataclasses import dataclass, field
+from typing import Generic, TypeVar, cast, overload
+
+T = TypeVar('T')
+
+
+# T is the type of the value that conv extracts from the match; the default
+# is the text of the match.
+class Token(Generic[T]):
+    @overload
+    def __init__(self: Token[str], pattern: str, desc: str) -> None: ...
+
+    @overload
+    def __init__(self, pattern: str, desc: str,
+                 conv: Callable[[re.Match[str]], T]) -> None: ...
+
+    def __init__(self, pattern: str, desc: str,
+                 conv: Callable[[re.Match[str]], T] | None = None):
+        self.r = re.compile(pattern)
+        self.name = desc
+        self.conv = conv
+
+    def __call__(self, text: str, pos: int) -> tuple[T, int] | None:
+        m = self.r.match(text, pos)
+        if m is None:
+            return None
+        if self.conv is None:
+            return cast(T, m[0]), m.end()
+        return self.conv(m), m.end()
+
+
+HEX_BYTE = Token(r'[0-9A-F]{2}\b', 'opcode byte', lambda m: int(m[0], 16))
+MODRM_REG = Token(r'[0-7]\b', 'ModRM.reg value', lambda m: int(m[0]))
+WORD = Token(r'\S+', 'field')
+MANDATORY_PREFIX = Token(r'(NP|66|F3|F2)\b', 'mandatory prefix')
+PREFIX_ENCODING = Token(r'(REX2|VEX|EVEX)\b', 'encoding')
+PREFIX_MAP = Token(r'(0F38|0F3A|0F|MAP[3-7])\b', 'opcode map')
+PREFIX_W = Token(r'(W0|W1|WIG)\b', 'W')
+PREFIX_L = Token(r'(L0|L1|LIG|LZ|LLIG|LLZ|128|256|512)\b', 'vector length')
+PREFIX_ND = Token(r'(ND0|ND1)\b', 'ND')
+PREFIX_NF = Token(r'(NF0|NF1)\b', 'NF')
+
+# Prefix items other than the mandatory prefixes, and the corresponding
+# field of Prefix.
+PREFIX_FIELDS = [
+    (PREFIX_ENCODING, 'encoding'),
+    (PREFIX_MAP, 'map'),
+    (PREFIX_W, 'w'),
+    (PREFIX_L, 'l'),
+    (PREFIX_ND, 'nd'),
+    (PREFIX_NF, 'nf'),
+]
+IDENT = Token(r'[A-Za-z_][A-Za-z0-9_]*', 'identifier')
+# gen_3dnow starts with a digit.
+EMITTER = Token(r'3dnow|[A-Za-z_][A-Za-z0-9_]*', 'emitter')
+ARG = Token(r'[A-Za-z0-9_-]+', 'argument')
+# Multi-letter types must come before single letters.
+OPERAND_TYPES = r'ZERO|RAX|RCX|RDX|RBX|RSP|RBP|RSI|RDI|ES|CS|SS|DS|FS|GS|[A-Z]'
+OPERAND_TYPE = Token(OPERAND_TYPES, 'operand type')
+OPERAND_SIZE = Token(r'[a-z]+[0-9]*(_[a-z]+[0-9]+)?', 'operand size')
+OPERAND_MOD = Token(r'[a-z]+[0-9]*', 'operand modifier')
+
+# Distinguishes an operand list from a modifier such as E4.
+OPERAND_HEAD = Token(rf'({OPERAND_TYPES})([a-z(,\s]|$)', 'operand')
+
+
+class ParseError(Exception):
+    def __init__(self, filename: str, lineno: int, col: int, msg: str):
+        super().__init__(msg)
+        self.filename = filename
+        self.lineno = lineno
+        self.col = col
+        self.msg = msg
+
+    def __str__(self) -> str:
+        return f'{self.filename}:{self.lineno}:{self.col + 1}: {self.msg}'
+
+
+@dataclass
+class Operand:
+    type: str
+    size: str | None = None
+    mods: list[str] = field(default_factory=list)
+
+
+@dataclass
+class Modifier:
+    name: str
+    args: list[str] = field(default_factory=list)
+
+
+@dataclass
+class Prefix:
+    encoding: str | None = None
+    mandatory: list[str] | None = None
+    map: str | None = None
+    w: str | None = None
+    l: str | None = None
+    nd: str | None = None
+    nf: str | None = None
+
+
+@dataclass
+class Insn:
+    prefix: Prefix
+    opcode: tuple[int, int]
+    lobits: bool
+    modrm_reg: int | None
+    emitter: str
+    operands: list[Operand]
+    modifiers: list[Modifier]
+    filename: str = field(default='<string>', compare=False)
+    lineno: int = field(default=1, compare=False)
+
+
+# The grammar comments in LineParser use EBNF: [ x ] is optional, { x } is
+# repeated zero or more times, quoted strings are literals, uppercase names
+# are tokens.  ' ' stands for a run of one or more spaces or tabs.
+class LineParser:
+    def __init__(self, text: str, filename: str = '<string>', lineno: int = 1):
+        self.text = text
+        self.pos = 0
+        self.filename = filename
+        self.lineno = lineno
+
+    def error(self, msg: str, pos: int | None = None) -> ParseError:
+        return ParseError(self.filename, self.lineno,
+                          self.pos if pos is None else pos, msg)
+
+    @overload
+    def match(self, tok: str) -> tuple[str, int] | None: ...
+    @overload
+    def match(self, tok: Token[T]) -> tuple[T, int] | None: ...
+
+    def match(self, tok: str | Token[T]) -> tuple[str, int] | tuple[T, int] | None:
+        if isinstance(tok, Token):
+            return tok(self.text, self.pos)
+        if tok == ' ':
+            end = self.pos
+            while end < len(self.text) and self.text[end] in ' \t':
+                end += 1
+            return (tok, end) if end > self.pos else None
+        if self.text.startswith(tok, self.pos):
+            return tok, self.pos + len(tok)
+        return None
+
+    @overload
+    def peek(self, tok: str) -> str | None: ...
+    @overload
+    def peek(self, tok: Token[T]) -> T | None: ...
+
+    def peek(self, tok: str | Token[T]) -> str | T | None:
+        result = self.match(tok)
+        return None if result is None else result[0]
+
+    @overload
+    def accept(self, tok: str) -> str | None: ...
+    @overload
+    def accept(self, tok: Token[T]) -> T | None: ...
+
+    def accept(self, tok: str | Token[T]) -> str | T | None:
+        result = self.match(tok)
+        if result is None:
+            return None
+        value, self.pos = result
+        return value
+
+    @overload
+    def expect(self, tok: str) -> str: ...
+    @overload
+    def expect(self, tok: Token[T]) -> T: ...
+
+    def expect(self, tok: str | Token[T]) -> str | T:
+        value = self.accept(tok)
+        if value is None:
+            if isinstance(tok, Token):
+                what = tok.name
+            elif tok == ' ':
+                what = 'whitespace'
+            else:
+                what = repr(tok)
+            raise self.error(f'expected {what}')
+        return value
+
+    def has_prefix(self) -> bool:
+        # Lookahead, does not consume anything:
+        #   WORD ' ' HEX_BYTE
+        save = self.pos
+        self.expect(WORD)
+        found = self.accept(' ') is not None and self.accept(HEX_BYTE) is not None
+        self.pos = save
+        return found
+
+    def parse_prefix_item(self, prefix: Prefix) -> None:
+        # prefix_item ::= MANDATORY_PREFIX { '|' MANDATORY_PREFIX }
+        #               | PREFIX_ENCODING | PREFIX_MAP | PREFIX_W | PREFIX_L
+        #               | PREFIX_ND | PREFIX_NF
+        start = self.pos
+        if (mandatory := self.accept(MANDATORY_PREFIX)) is not None:
+            if prefix.mandatory is not None:
+                raise self.error('mandatory prefixes listed more than once', start)
+            prefix.mandatory = [mandatory]
+            while self.accept('|') is not None:
+                prefix.mandatory.append(self.expect(MANDATORY_PREFIX))
+            return
+
+        for tok, name in PREFIX_FIELDS:
+            if (value := self.accept(tok)) is not None:
+                if getattr(prefix, name) is not None:
+                    raise self.error(f'{value} conflicts with {getattr(prefix, name)}', start)
+                setattr(prefix, name, value)
+                return
+        raise self.error('expected prefix item')
+
+    def parse_prefix(self) -> Prefix:
+        # prefix ::= prefix_item { '.' prefix_item } ' '
+        prefix = Prefix()
+        self.parse_prefix_item(prefix)
+        while self.accept('.') is not None:
+            self.parse_prefix_item(prefix)
+        self.expect(' ')
+        return prefix
+
+    def parse_range(self, tok: Token[int]) -> tuple[int, int]:
+        # range(tok) ::= tok [ '..' tok ]
+        start = self.pos
+        lo = self.expect(tok)
+        hi = self.expect(tok) if self.accept('..') is not None else lo
+        if lo > hi:
+            raise self.error('empty range', start)
+        return lo, hi
+
+    def parse_digit(self) -> int | None:
+        # digit ::= ' ' '/' range(MODRM_REG)
+        save = self.pos
+        if self.accept(' ') is not None and self.accept('/') is not None:
+            return self.expect(MODRM_REG)
+        self.pos = save
+        return None
+
+    def parse_list(self, tok: Token[T]) -> list[T]:
+        # list(tok) ::= tok { ',' [ ' ' ] tok } ')'
+        #
+        # The opening parenthesis has already been consumed.
+        items = [self.expect(tok)]
+        while self.accept(',') is not None:
+            self.accept(' ')
+            items.append(self.expect(tok))
+        self.expect(')')
+        return items
+
+    def parse_operand(self) -> Operand:
+        # operand ::= OPERAND_TYPE [ OPERAND_SIZE ] [ '(' list(OPERAND_MOD) ]
+        type = self.expect(OPERAND_TYPE)
+        size = self.accept(OPERAND_SIZE)
+        mods = []
+        if self.accept('(') is not None:
+            mods = self.parse_list(OPERAND_MOD)
+            if self.peek(OPERAND_SIZE) is not None:
+                raise self.error('operand size must come before modifiers')
+        return Operand(type, size, mods)
+
+    def parse_operands(self) -> list[Operand]:
+        # operands ::= operand { ',' [ ' ' ] operand }
+        operands = [self.parse_operand()]
+        while self.accept(',') is not None:
+            self.accept(' ')
+            operands.append(self.parse_operand())
+        return operands
+
+    def parse_modifier(self) -> Modifier:
+        # modifier ::= IDENT [ '(' list(ARG) ]
+        name = self.expect(IDENT)
+        args = self.parse_list(ARG) if self.accept('(') is not None else []
+        return Modifier(name, args)
+
+    def parse(self) -> Insn:
+        # line ::= [ prefix ] range(HEX_BYTE) [ '+r' ] [ digit ] ' ' IDENT
+        #          [ ' ' operands ] { ' ' modifier }
+        #
+        # The prefix is only parsed if has_prefix() succeeds, and the operands
+        # only if OPERAND_HEAD matches, so that a modifier such as E4 is not
+        # taken for an operand.
+        prefix = self.parse_prefix() if self.has_prefix() else Prefix()
+        opcode = self.parse_range(HEX_BYTE)
+        lobits = self.accept('+r') is not None
+        modrm_reg = self.parse_digit()
+        self.expect(' ')
+        emitter = self.expect(EMITTER)
+
+        operands: list[Operand] = []
+        modifiers: list[Modifier] = []
+        while self.accept(' ') is not None:
+            if not operands and not modifiers and self.peek(OPERAND_HEAD) is not None:
+                operands = self.parse_operands()
+            else:
+                modifiers.append(self.parse_modifier())
+
+        if self.pos != len(self.text):
+            raise self.error('expected whitespace or end of line')
+        return Insn(prefix, opcode, lobits, modrm_reg, emitter, operands, modifiers,
+                    self.filename, self.lineno)
+
+
+def parse_line(text: str, filename: str = '<string>', lineno: int = 1) -> Insn | None:
+    comment = text.find('//')
+    if comment != -1:
+        text = text[:comment]
+    text = text.rstrip()
+    if not text:
+        return None
+    return LineParser(text, filename, lineno).parse()
+
+
+def parse_file(lines: list[str], filename: str = '<string>') -> list[Insn]:
+    insns: list[Insn] = []
+    for lineno, text in enumerate(lines, start=1):
+        insn = parse_line(text, filename, lineno)
+        if insn is not None:
+            insns.append(insn)
+    return insns
+
+
+def main() -> int:
+    insns: list[Insn] = []
+    for filename in sys.argv[1:]:
+        with open(filename, encoding='utf-8') as f:
+            try:
+                insns += parse_file(f.readlines(), filename)
+            except ParseError as e:
+                print(e, file=sys.stderr)
+                return 1
+    for insn in insns:
+        print(insn)
+    return 0
+
+
+if __name__ == '__main__':
+    import maketable
+    sys.exit(maketable.main())
diff --git a/target/i386/tcg/meson.build b/target/i386/tcg/meson.build
index c57e661752e..30ab58a92a2 100644
--- a/target/i386/tcg/meson.build
+++ b/target/i386/tcg/meson.build
@@ -14,3 +14,10 @@ i386_ss.add(when: 'CONFIG_TCG', if_true: files(
 
 subdir('system')
 subdir('user')
+
+# Unit tests for the generator of the decoder tables.
+test('i386-maketable', python,
+     args: ['-m', 'pycotap', 'test_maketable'],
+     workdir: meson.current_source_dir(),
+     protocol: 'tap',
+     suite: ['unit'])
diff --git a/target/i386/tcg/test_maketable.py b/target/i386/tcg/test_maketable.py
new file mode 100644
index 00000000000..1f4a1cb0876
--- /dev/null
+++ b/target/i386/tcg/test_maketable.py
@@ -0,0 +1,170 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Tests for maketable.py.  Run with "python3 -m unittest test_maketable"
+# from the target/i386/tcg directory.
+
+import unittest
+
+from maketable import (
+    Insn,
+    Modifier,
+    Operand,
+    ParseError,
+    Prefix,
+    parse_file,
+    parse_line,
+)
+
+
+class TestParser(unittest.TestCase):
+    def parse(self, text: str) -> Insn:
+        insn = parse_line(text)
+        assert insn is not None
+        return insn
+
+    def test_vex(self) -> None:
+        insn = self.parse('VEX.NP|66.0F.WIG 67   PACKUSWB     Vx,Hx,Wx     E4(avx2_256, mmx)')
+        self.assertEqual(insn, Insn(
+            prefix=Prefix(encoding='VEX', mandatory=['NP', '66'], map='0F', w='WIG'),
+            opcode=(0x67, 0x67), lobits=False, modrm_reg=None, emitter='PACKUSWB',
+            operands=[Operand('V', 'x'), Operand('H', 'x'), Operand('W', 'x')],
+            modifiers=[Modifier('E4', ['avx2_256', 'mmx'])]))
+
+    def test_emitter_digit(self) -> None:
+        insn = self.parse('0F 0F   3dnow   Pq,Qq,Ib')
+        self.assertEqual((insn.prefix.map, insn.opcode, insn.emitter), ('0F', (0x0F, 0x0F), '3dnow'))
+
+    def test_modrm_reg(self) -> None:
+        insn = self.parse('80 /3                 SBB          Bb,Eb,Ib     lock')
+        self.assertEqual(insn, Insn(
+            prefix=Prefix(), opcode=(0x80, 0x80), lobits=False, modrm_reg=3, emitter='SBB',
+            operands=[Operand('B', 'b'), Operand('E', 'b'), Operand('I', 'b')],
+            modifiers=[Modifier('lock')]))
+
+    def test_zero(self) -> None:
+        insn = self.parse('FE /0   INC   Eb   lock')
+        self.assertEqual(insn.opcode, (0xFE, 0xFE))
+        self.assertEqual(insn.modrm_reg, 0)
+        insn = self.parse('00      ADD   Eb,Gb   lock')
+        self.assertEqual(insn.opcode, (0, 0))
+        self.assertIsNone(insn.modrm_reg)
+
+    def test_operand_mods(self) -> None:
+        insn = self.parse('84                    TEST        Eb(r),Gb')
+        self.assertEqual(insn.operands, [Operand('E', 'b', ['r']), Operand('G', 'b')])
+        self.assertEqual(insn.modifiers, [])
+
+    def test_opcode_range(self) -> None:
+        insn = self.parse('70..7F                Jcc         Jb')
+        self.assertEqual(insn.opcode, (0x70, 0x7F))
+        self.assertFalse(insn.lobits)
+
+    def test_lobits(self) -> None:
+        insn = self.parse('50..57+r              PUSH        Rd64(r)')
+        self.assertEqual(insn.opcode, (0x50, 0x57))
+        self.assertTrue(insn.lobits)
+        self.assertEqual(insn.operands, [Operand('R', 'd64', ['r'])])
+        insn = self.parse('91..97+r   XCHG   RAXv,Rv')
+        self.assertEqual(insn.opcode, (0x91, 0x97))
+        self.assertTrue(insn.lobits)
+
+    def test_space_after_comma(self) -> None:
+        insn = self.parse('C4                    LES         Gz(w), Ep(m)      chk(i64)')
+        self.assertEqual(insn.operands, [Operand('G', 'z', ['w']), Operand('E', 'p', ['m'])])
+        self.assertEqual(insn.modifiers, [Modifier('chk', ['i64'])])
+
+    def test_legacy_prefix(self) -> None:
+        insn = self.parse('NP.W0.0F C7 /1        CMPXCHG8B   Mq             lock cpuid(CX8)')
+        self.assertEqual(insn, Insn(
+            prefix=Prefix(mandatory=['NP'], map='0F', w='W0'),
+            opcode=(0xC7, 0xC7), lobits=False, modrm_reg=1, emitter='CMPXCHG8B',
+            operands=[Operand('M', 'q')],
+            modifiers=[Modifier('lock'), Modifier('cpuid', ['CX8'])]))
+
+    def test_evex_prefix(self) -> None:
+        insn = self.parse('EVEX.512.66.0F38.W1 00   VPSHUFB   Vx,Hx,Wx')
+        self.assertEqual(insn.prefix, Prefix(encoding='EVEX', mandatory=['66'],
+                                             map='0F38', w='W1', l='512'))
+        insn = self.parse('EVEX.LLZ.NP.MAP4.W0 00   ADD   Bb,Eb,Gb')
+        self.assertEqual(insn.prefix, Prefix(encoding='EVEX', mandatory=['NP'],
+                                             map='MAP4', w='W0', l='LLZ'))
+
+    def test_apx_prefix(self) -> None:
+        insn = self.parse('EVEX.LLZ.NP|66.MAP4.ND0.NF1 40..4F   CFCMOVcc   Gv,Ev')
+        self.assertEqual(insn.prefix, Prefix(encoding='EVEX', mandatory=['NP', '66'],
+                                             map='MAP4', l='LLZ', nd='ND0', nf='NF1'))
+
+    def test_rex2_prefix(self) -> None:
+        insn = self.parse('REX2.NP.W0 A1   JMP_m   Iq   chk(no_adr)')
+        self.assertEqual(insn.prefix, Prefix(encoding='REX2', mandatory=['NP'], w='W0'))
+        self.assertEqual(insn.opcode, (0xA1, 0xA1))
+
+    def test_modrm(self) -> None:
+        insn = self.parse('0F 01 /1   SIDT   Ms')
+        self.assertEqual(insn.modrm_reg, 1)
+
+    def test_reg(self) -> None:
+        insn = self.parse('F3.0F AE /0   RDxxBASE   Ry(w)      cpuid(FSGSBASE) chk(o64)')
+        self.assertEqual(insn.prefix, Prefix(mandatory=['F3'], map='0F'))
+        self.assertEqual(insn.modrm_reg, 0)
+        self.assertEqual(insn.operands, [Operand('R', 'y', ['w'])])
+        insn = self.parse('F3.0F AE /2   WRxxBASE   Ry(r,zx)   cpuid(FSGSBASE) chk(o64)')
+        self.assertEqual(insn.modrm_reg, 2)
+        self.assertEqual(insn.operands, [Operand('R', 'y', ['r', 'zx'])])
+
+    def test_no_operands(self) -> None:
+        insn = self.parse('0F 05   SYSCALL   chk(o64)')
+        self.assertEqual(insn.prefix, Prefix(map='0F'))
+        self.assertEqual(insn.operands, [])
+        self.assertEqual(insn.modifiers, [Modifier('chk', ['o64'])])
+
+    def test_hex_lookalikes(self) -> None:
+        # E4 is an opcode in the first column and a modifier at the end.
+        insn = self.parse('E4   IN   RAXb,Ib   E4(unaligned, avx2_256)')
+        self.assertEqual(insn.opcode, (0xE4, 0xE4))
+        self.assertEqual(insn.operands, [Operand('RAX', 'b'), Operand('I', 'b')])
+        self.assertEqual(insn.modifiers, [Modifier('E4', ['unaligned', 'avx2_256'])])
+
+    def test_segment_operands(self) -> None:
+        insn = self.parse('8C   MOV   Ev,Sw')
+        self.assertEqual(insn.operands, [Operand('E', 'v'), Operand('S', 'w')])
+        insn = self.parse('0F A0   PUSH   FSw(r)')
+        self.assertEqual(insn.operands, [Operand('FS', 'w', ['r'])])
+        insn = self.parse('FF /6   PUSH   Ed64(r)')
+        self.assertEqual(insn.operands, [Operand('E', 'd64', ['r'])])
+
+    def test_comments(self) -> None:
+        insns = parse_file(['// header', '', '   ', '84  TEST  Eb(r),Gb  // comment'])
+        self.assertEqual(len(insns), 1)
+        self.assertEqual(insns[0].lineno, 4)
+
+    def test_errors(self) -> None:
+        bad = [
+            'C4   LES   Gz,E(m)p',      # modifier before size
+            '80 /3',                    # no emitter
+            '80 /8   SBB   Bb,Eb,Ib',   # invalid ModRM.reg
+            '57..50  PUSH  Rv(r)',      # empty range
+            '50..57 +r  PUSH  Rv(r)',   # space before +r
+            'NP.66.0F 67  X  Vx',       # two mandatory prefix items
+            'W0|W1.0F 67  X  Vx',       # alternatives for other items
+            'NP|0F38 67  X  Vx',        # alternatives for other items
+            'VEX.L0.256.0F 67  X  Vx',  # two vector lengths
+            'W0.0F.0F38 67  X  Vx',     # two opcode maps
+            'NDS.0F 67  X  Vx',         # unknown item
+            'ND0.ND1.MAP4 67  X  Vx',   # two ND items
+            'VEX.0F3 67  X  Vx',        # partial match
+            '84   TEST   Eb(r,),Gb',    # empty modifier
+            '84   TEST   Eb(r)X',       # junk after operand
+            'F3.0F AE/0  RDxxBASE',     # missing whitespace
+            '0F AE /0..1  X  Ry(w)',    # /digit with a range
+        ]
+        for text in bad:
+            with self.subTest(text=text):
+                self.assertRaises(ParseError, parse_line, text)
+
+    def test_error_position(self) -> None:
+        with self.assertRaises(ParseError) as cm:
+            parse_line('84   TEST   Eb(r)X', 'foo.def', 7)
+        self.assertEqual(str(cm.exception),
+                         'foo.def:7:18: expected whitespace or end of line')
-- 
2.56.0



