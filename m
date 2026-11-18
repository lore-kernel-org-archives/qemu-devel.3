Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E723606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PRsDDT1i
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTeht-0002Lj-Pf; Wed, 18 Nov 2026 07:24:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTehp-0002LE-Vs
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTehn-0003wV-Po
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795004642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=t6Zn2/KNs3+J7alumu2QmLaBdvh4dcStNjn1YNGgBy8=;
 b=PRsDDT1i+t5qLHmIASsr3eRuVIV7O7Gzi7tKG7auGv98W3XIgoohumfGYJeX3KvBr/zY36
 gb2VzbCkbq7YEqvglG5Hq7/g2janASnohb/ooi7teItyoekfhmhf0JjdqLTuNKT30pR+vY
 m9n6lhq9HHrR0EGM/kwj/KKW57UxVrk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-P24o248mNRiihiJmDl5gWA-1; Wed,
 18 Nov 2026 07:24:00 -0500
X-MC-Unique: P24o248mNRiihiJmDl5gWA-1
X-Mimecast-MFC-AGG-ID: P24o248mNRiihiJmDl5gWA_1795004639
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A3B41956057
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:23:59 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DC94518011D3
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:23:58 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 00/26] target/i386/tcg: write decoder tables in textual
 form
Date: Wed, 18 Nov 2026 13:23:31 +0100
Message-ID: <20261118122357.659634-1-pbonzini@redhat.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is an example of a large AI-assisted contribution.  Most of the code
(though not all patches, and not all code in patches marked AI-used-for)
was written by AI, but it was all reviewed by me.  Patches were reordered
and curated by hand; some of the changes compared to the initial version
were informed by more work that is not even included here.  Overall,
preparing the series for inclusion followed my usual process, other than
the submission being larger than usual.

Comments on the code of course are welcome, but I'm not asking you to
read anything beyond the cover letter; let alone expecting anyone
to review the patches.  Nevertheless, this example does provide useful
context for the policy discussion and there's no point in publishing
only the cover letter.

Of course, sending this to a maintainer that isn't me might not have been
appreciated.  Or maybe it would be, it depends and I cannot know for
everyone; maybe Richard can chime in just based on a cursory check.
An interesting aspect to discuss is whether _I_ would be allowed to
commit this, being both maintainer of the sole affected subsystem
and author.  I am leaving this question open for discussion.

The Python code looked foreign to me in the beginning, but less so as
I got more accustomed to it.  It certainly has better unit test coverage
than what I would have come up with.  In my experience LLMs are very
good at concocting simple test harnesses.

On the other hand end-to-end testing has been very limited, since I
didn't plan to post this and I am only doing it for the sake of the AI
policy discussion.  With my maintainer hat on I would ask for differential
testing as well, given the LLM-assisted nature of the work, with no shame
about not having any idea how to do that. :)  Figuring it out is a job
for the contributor and their "friend".

--- end of policy-related introduction, beginning of "regular" cover letter ---

Introduce a parser for a line-oriented description of the tables in
decode-new.c.inc.  The parser builds on the preprocessor-aided syntax
used by decode-new.c.inc, and adds in front the prefix and instruction bytes,
in a syntax close to the Intel SDM notation.

  SSE|VEX.NP|66.0F 67   PACKUSWB     Vx,Hx,Wx     E4(avx2_256, mmx)
  80 /3                 SBB          Eb,Ib        lock
  F3.0F AE /2..3        WRxxBASE     Ry(r,zx)     cpuid(FSGSBASE) chk(o64)
  50..57+r              PUSH         Rd64(r)

Compared to the SDM, the prefix and opcode notation make it clear that
multiple rows are being merged; and at the same time, the SDM notation
is not entirely unambiguous without extra columns (see PUSH):

  NP 0F 67 /r            PACKUSWB  mm, mm/m64
  66 0F 67 /r            PACKUSWB  xmm, xmm2/m128
  VEX.128.66.0F.WIG /r   VPACKUSWB xmm1, xmm2, xmm3/m128
  VEX.256.66.0F.WIG /r   VPACKUSWB ymm1, ymm2, ymm3/m256
  80 /3 ib               SBB       r/m8, imm8
  REX + 80 /3 ib         SBB       r/m8, imm8     (with footnote about not allowing AH/BH/CH/DH)
  50+rw                  PUSH      r16
  50+rd                  PUSH      r32
  50+rd                  PUSH      r64
  F3 0F AE /2            WRFSBASE  r32
  F3 0F AE /3            WRGSBASE  r32
  F3 REX.W 0F AE /2      WRFSBASE  r64
  F3 REX.W 0F AE /3      WRGSBASE  r64

(As a reminder, QEMU's operand notation is different because it descends
from tables that Intel has since stopped updating).

The rows are checked to detect many possible errors and compiled into
a decoding trie, and then the trie is turned into a bytecode-based decoder.
The decoder produces an X86DecodedInsn or #UD, and modifies VEX.W/VEX.L
if needed for WIG and LIG modifiers.  There is still a limited amount of
checking that is done in C code:

* for chk(), only i64/o64 are moved to the decoder

* for VEX/EVEX, class 0 is checked in C code to have no VEX prefix.

At +2000 SLOC (plus generated files) this is *a lot* of new material,
though the sheer number of lines does not give a full picture because the
series improves documentation, tests, and includes a new debugging tool.
Also, more cleanups are possible to simplify the special/vex_special
fields, and finishing the conversion of the 0F map from switch statements
to decode tables becomes much simpler.

More long term, AVX512 is complex enough that it is almost impossible
to implement without an automatic code generation tool and comprehensive
static checks (almost, because Fabrice did it :)).  Some ideas from AVX512,
for example tuple types, can be applied even to AVX and that is a bit
easier without having to think about more preprocessor hacks.

While this answers "what problem does it", a maintainer might also ask,
given the use of AI, "could you make a more radical change".  And indeed
this may not be the last rewrite of the x86 TCG decoder.  For example,
https://x86-64.net/data/insn.json provides a machine-readable description
of instructions like the following:

  { "iform": "PUSH_GPRv_50",
    "encodings": ["50+r", "REX2.W0 50+r"],
    "operands": ["r16/32/64", "r"],
    "implicit": [["stack", "w"], ["rSP", "rw"]],
    "space": "legacy",
    "isa_set": "I86",
  }

It may be possible to limit decode.def to the association between insn.json
instructions and QEMU emitters, though it's not easy; on one hand the
"iform" above is a lot more detailed---for example there are separate
SBB_GPR8_GPR8_18 and SBB_MEMb_GPR8 entries corresponding to just "SBB
Eb,Gb" because only the latter supports LOCK---on the other hand I cannot
see in insn.json the difference between SBB_GPR8_GPR8_18 and SBB_GPR8_GPR8_1A
(i.e. which operand is encoded in ModRM.reg)!

Even if insn.json was more mature, this conversion would still be a
good first step, as it provides the tools for processing instruction
descriptions for the current TCG decoder.

Patches 1 to 8 implement the parser, trie and decoding tool.

Patches 9 to 14 implement C code generation.

Patches 15 to 21 convert the existing table to the new format.

Patches 22 to 26 move away from the intermediate state where some
decoding was done in C code and some via the generated program.
This part is the only one written almost entirely by me.

Paolo

Paolo Bonzini (26):
  target/i386/tcg: add parser for a textual description of the decoder
    tables
  target/i386/tcg: add semantic checks for the decoder table description
  target/i386/tcg: restrict REX2 to opcodes where REX2 differs, no_rex2
    where it is the same
  target/i386/tcg: build a decoding trie from the table description
  target/i386/tcg: add CPUID checks to the trie
  target/i386/tcg: only check the encoding when it matters
  target/i386/tcg: allow alternatives for the encoding and vector length
  target/i386/tcg: add --explain to maketable.py
  target/i386/tcg: generate the decoder program and rows
  target/i386/tcg: add bytecode based opcode decoder
  target/i386/tcg: lower single-outcome nodes to OP_MATCH
  target/i386/tcg: do not reference emitters for instructions that are
    64-bit only or privileged
  target/i386/tcg: defer the encoding check for rows with vex_class == 0
  target/i386/tcg: defer (and actually omit) the CODE64 check for EVEX
    map4
  target/i386/tcg: convert the 0F3A map to decode.def
  target/i386/tcg: convert the 0F38 map to decode.def
  target/i386/tcg: fetch the opcode byte in disas_insn() for REX2 map 0
  target/i386/tcg: convert REX2 map 0 to decode.def
  target/i386/tcg: convert EVEX map 4 to decode.def
  target/i386/tcg: convert the legacy map to decode.def
  target/i386/tcg: convert the 0F map to decode.def
  target/i386/tcg: update decoder docs for new tables
  target/i386/tcg: rename X86_TYPE_0..7
  target/i386/tcg: send opcodes directly to the bytecode interpreter
  target/i386/tcg: remove checks obsoleted by the generated decoder
  target/i386/tcg: precompute CPUID features used by the decoder

 target/i386/cpu.h                         |    2 +
 target/i386/tcg/decode-new.h              |  211 +-
 target/i386/tcg/helper-tcg.h              |    1 +
 target/i386/tcg/tcg-cpu.c                 |   16 +-
 target/i386/tcg/translate.c               |    6 +-
 target/i386/tcg/decode-new.c.inc          | 2415 ++-------------------
 target/i386/tcg/emit.c.inc                |   30 +-
 target/i386/tcg/decode.def                | 1301 +++++++++++
 target/i386/tcg/maketable.py              | 1131 ++++++++++
 target/i386/tcg/maketable_codegen.py      |  323 +++
 target/i386/tcg/maketable_explain.py      |  181 ++
 target/i386/tcg/meson.build               |   18 +-
 target/i386/tcg/test_maketable.py         |  570 +++++
 target/i386/tcg/test_maketable_codegen.py |  323 +++
 14 files changed, 4281 insertions(+), 2247 deletions(-)
 create mode 100644 target/i386/tcg/decode.def
 create mode 100644 target/i386/tcg/maketable.py
 create mode 100644 target/i386/tcg/maketable_codegen.py
 create mode 100644 target/i386/tcg/maketable_explain.py
 create mode 100644 target/i386/tcg/test_maketable.py
 create mode 100644 target/i386/tcg/test_maketable_codegen.py

-- 
2.56.0


