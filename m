Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BFBC61DCD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 07:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzrGy-0007Eb-Fp; Fri, 28 Aug 2026 03:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wzrGw-0007ET-Td
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 03:45:10 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wzrGl-0007gm-UK
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 03:45:03 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c25366c9b42so76066666b.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 00:44:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787903097; cv=none;
 d=google.com; s=arc-20260327;
 b=WFHwEt3bXKIRrvDU17y8vmF/HieZWZyARPN8uHlMdLJTFUcpnrMiZSIH+H0O/twlzr
 IFXATx8XQzr0x5gZvhc0tzyJSui35fcKSzlohaSf8oN7j/8X1PFSCXk8xNV/Pp2aIC8r
 wgrrmLdI//dLAwMIKEVrP9/S4+FcyX1sTRfNQLNaHJsH4zoneu2WyXJ+8ATSTSih8U2m
 +BLOsiUA1gPMhK/ZH0EkbgcIpM7cdlcg0oty7EwG+ssYVmmUQTqU3PEOTbHi5hUTRngd
 RN563JaLRi9WJl9nOOhzyesKUzhgfQDxdjl06elc1DccMDSlo64nRhRhI797pYD68Siw
 KeYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:mime-version
 :dkim-signature;
 bh=TPf/VbdMrWgk23bqS55jo6BrYJKzovkb15JGCnme4+I=;
 fh=X0/VN3zinbGFfksFgcpSYCUkjqi/Dd2JSdxzjnDsFmg=;
 b=NLHSSpxLBM5Si55V6vHdcKUv+X1BeOP1U9ty1EsRzml6RIXgTRW22XWuylipbLSFCu
 0F5Poh71ek664ANeARXl1ghlhHeNMTv/EvribT0lokVRggGPNpIOJxg2XJPbYbJ0pWTC
 l7VMOVsU7ghsy92THWaDgX6dwz8cfX9dCyDOy6dSZoqPybGVn/cufrumreYNwKj+XOZq
 Qz8IpigyoDKoSsZJGcohLBmH5fJpImcrkLGhFxRasBmmOP1wQYvWuD8/MqdgxLNT61XF
 KsxskwUSZs94gMw/iOQPmbYSI88K8/9WFpZw3rpGwXWtLjbgj/E/lidBfcYbDEghaBqM
 7PBg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787903097; x=1788507897; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TPf/VbdMrWgk23bqS55jo6BrYJKzovkb15JGCnme4+I=;
 b=CFDi7LNANfR1zq0TVOgjitJK7tVG94tNNNYIa/+bu4IiYwvxVr6+uAZiJ+HMIcg5N/
 9KwLd1b82a/t3v9m0P4MrnSeFTQ6NqwlA4yw/xwGXRBGVmY95XjpMNQkpItOwJ6iiNwJ
 XNF6qq0LGKKRbVBtr/IbuxPtqVyXorDRfw/M6G4Wnsljucot0r2z+kEYlkAZOZY1yCnm
 q7QOX9lEPbivcESW19tgukcdEqDkFRFH7CBFjwSS2Poz8g1qeKgIFhrRJPq/kMRt3TPQ
 fa08J/21afcSE/Yd6OyEN/0k5XB2ELSnY+nv6coesbHtcGli9TOz0k6IJN/0zhZnytoy
 0v6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787903097; x=1788507897;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TPf/VbdMrWgk23bqS55jo6BrYJKzovkb15JGCnme4+I=;
 b=tW2qbmwTDQpaDIYKs33+44Kw1BWg+6uZTqgTjfaNojOPfB6RMBdVEqAl9LBeAFHqO5
 cLc01DOpjW8YS44wUlQLUarW/n6O5//AqppTcHkCYd8+f5F98vdnsPx2R3cR5diaEhXq
 h0WTW2Yv7vAaCR7V2LsOOzrDeWst5MFySz18j2GCQyg79ELqjoalwy1u0vkgbzv2jSUn
 K4+x/CV2Aaxg8PsshbUe6YJEGnoHrOvB3dipB62gpyvX3G2tixXU1Gh2V7s4LoQJCDOv
 UFS3+3HGie61SH6NYjMfxAcLYAcSl4vVGvU1QyLzhX/6ODpwVMzG2XMEucBF9BE3B92j
 mRwg==
X-Gm-Message-State: AFuF++lrDdm4hpQjK/frvu4s+yLWfOCj69unwSwaYc5e21UowsATsMvS
 z3oxFs+1iEfXriMtdGlgXWt2B+v5Y8CerG2oqcAxBTQulgRav1893PJjxlUJoQUN0yqBkY1uSyA
 7Tfz2aMhPOFLztraKwTC1jx9a49n3UQPyQA2pQtsXNA==
X-Gm-Gg: AR+sD12gzzuanZEVmlJ2nUP9hx/UumRou8ph6RCkQ+SZySTh363DG1Z0cJN/bduznbK
 Ok+rU6DnvsR77U88defgA0bJznVK26ALZipwoehKDQ5UWkaJxYvQmUdjNEYmNH7Pbu4BbLiBhWz
 9rJq7O6lbhgJPI05pSC9x/OYveXiTZArrAgb1vDRzi/BEFlmyV7WNok3fc/t2M4A+bJduEAkJ9O
 dyp+eNR/PetmdKZSaXOB0CC55RTUXb1E46Vez47ZI5CVYJoNJuzdSK2wb6cgpcFVrG6fWeFxaCh
 dfLi2Nlr9j5tmClavN+PPyFHH0sbbfhDSHAYL9T0kpuUdSRnCkgIHjo=
X-Received: by 2002:a17:907:9444:b0:c25:437:3dcf with SMTP id
 a640c23a62f3a-c2557488af4mr277086466b.21.1787903096363; Fri, 28 Aug 2026
 00:44:56 -0700 (PDT)
MIME-Version: 1.0
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 28 Aug 2026 15:44:43 +0800
X-Gm-Features: AcwNN1VwIgzsT4Z0vIzKX_ENy-adaqkjiftnDAw42ZwrOF8_474-fZHiv2LLrEU
Message-ID: <CAE2XoE_-ewv3iC_MZ2sM1eKG=CUKM7MZa-ppJV0Vk1rE1h+19w@mail.gmail.com>
Subject: [RFC] single-binary: merge experimental qemu-system before filtering
To: qemu-level <qemu-devel@nongnu.org>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Type: multipart/alternative; boundary="000000000000f3a250065a16a0e5"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=luoyonggang@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, BOMB_FREEM=1, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000f3a250065a16a0e5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This is a design RFC, not a patch series. It follows review of

  [PATCH 00/12] single-binary: link ARM and RISC-V into qemu-system
  https://patchew.org/QEMU/20260823150731.896-1-luoyonggang@gmail.com/

  [PATCH v2 00/13] single-binary: link ARM and RISC-V into qemu-system
  https://patchew.org/QEMU/20260826184229.1145-1-luoyonggang@gmail.com/

and Daniel P. Berrange's measurements of that v1.

What v2 already did
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

v2 of that series already takes the v1 review that got maintainer
support:

- Keep real qemu-system-$TARGET (and $TARGETw on Windows). v1
  installed per-arch names as symlinks to qemu-system; v2 does
  not. qemu-system is an extra binary from the ARM+RISC-V union,
  behind a meson option.
- argv[0] still selects the target for qemu-system-aarch64.
- Drop v1 little- and big-endian TargetInfo variants
  (target-info-<name>-le/be, -target aarch64-le). One TargetInfo
  per target_name. Endian variants are later work.
- -target ? lists target_name only. Unknown names point at
  -target ? rather than printing the list and exit(1).
- Do not build qemu-systemw for the combined binary, so Windows
  data exports (qdev_prop_array / qdev_prop_*) do not block
  enabling modules later.
- TargetCpuOps (b444b4fb) for QMP CPU queries, dump, and ARM/RISC-V
  semihosting, still as one process-wide table filtered at
  register time. This RFC revises that into a map.

v2 still required -target on bare qemu-system, still used
TYPE_TARGET_SPECIFIC on the combined binary, and did not mark
qemu-system experimental. Those are what this RFC asks to freeze
before posting the next series: extra binary stays, filtering is
not a gate, proposal A vs B. Heterogeneous (no target: on -M)
stays an error until later.

Why this RFC now
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

We are very close to a linked qemu-system that contains more than
one target (ARM + RISC-V; see v2 above). v2 already dropped the
symlink. The remaining delay is not "can it link", it is unresolved
product questions: -target vs -M only, complete filtering before
the first binary exists, experimental union vs looking like
$TARGET.

This RFC is to freeze those questions so the next series can land
an experimental qemu-system quickly, instead of another patch bomb
that still debates the end result. Filtering, heterogeneous
machines, modules for RSS, and CLI polish can follow against a
real binary. Please comment on the split and on proposal A vs B;
that is what unblocks the merge.

Thesis
=3D=3D=3D=3D=3D=3D

Land an extra, experimental qemu-system first, without completing
target/device filtering. Use that binary as the test vehicle for
filtering. Keep today's qemu-system-$TARGET as real binaries, not
symlinks.

qemu.git has no combined qemu-system today. Filtering, uniquify,
and CPU-op dispatch are therefore untested assumptions. Completing
TYPE_TARGET_SPECIFIC against qemu-system-riscv64 (a single-target
link) does not prove the union case. We need a real qemu-system in
the tree before filtering can be designed against measured
behavior.

Berrange compared a v1 qemu-system-riscv64 *symlink* to today's
standalone binary:

- qom-list-types went from about 770 classes to about 1530 (ARM
  types leak into RISC-V)
- -device help grew
- RSS for -nodefaults -display none -M none went from 17.3 MB to
  20.7 MB
- A full-union guess was much worse for RISC-V

That is a packaging blocker if $TARGET becomes a symlink. Extra RAM
on a *new* experimental qemu-system is acceptable if we document
that this binary exposes the union. It is also not the last word
on RSS.

Once modules are always enabled for qemu-system, unused machines
and devices can live in .so / .dll / .dylib and stay out of the
startup working set. One simple shape is one module per target, so
qemu-system -M arm:virt (or -target aarch64) loads the ARM module
and does not map RISC-V boards. That is later work, not a blocker
for the first extra binary (Mark Cave-Ayland already suggested
mandatory modules for qemu-system; Berrange did not want to block
on that). The first merge still links the union into one
executable so we have something to test.

This split is meant to take both review positions at the layer they
apply to:

- Berrange / Paolo: do not replace qemu-system-$TARGET with a
  symlink. A new qemu-system can be its own thing.
- Pierrick: select TargetInfo when the user wants a single-target
  view; TYPE_TARGET_SPECIFIC as the filtering mechanism. Matching
  $TARGET introspection is the *goal* of a later filtering series,
  not a gate on the first link.

Two CLI proposals for how to select one TargetInfo are below.
They share argv[0] and -M target:machine. They differ on whether
-target exists. A run with no selected TargetInfo (heterogeneous /
SYS_EMU_TARGET_HETEROGENEOUS) is deferred: the first series only
prints an error.

experimental-qemu-system
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Keep building real qemu-system-$TARGET as today (and $TARGETw on
Windows). Add qemu-system alongside them, from the union of ARM and
RISC-V for the first pair, behind a meson option, marked
experimental.

Do not install per-arch names as symlinks to qemu-system. Distro
packaging of qemu-system-riscv64 stays on the old RSS and QOM list.

The combined binary is documented as exposing everything that was
linked. Incomplete device filtering is an accepted experimental
defect, not a release blocker for this first binary. -M help /
-device help with no selected TargetInfo may still list the union.
Starting a machine that way is not supported yet (error; see
below).

Binding TargetInfo
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

A combined process has more than one TargetInfo (target_name, page
bits, long width, CPU_RESOLVING_TYPE, endianness).

In this mail, single-target means the process has one selected
TargetInfo / SysEmuTarget, like qemu-system-$TARGET today.
Heterogeneous would mean it does not (SYS_EMU_TARGET_HETEROGENEOUS).
That mode is not implemented yet.

Single-target runs still pick one TargetInfo before the chosen
machine and accelerators initialize.

Shared in both proposals:

- argv[0]: qemu-system-aarch64 infers aarch64. Existing $TARGET
  command lines stay valid. Single-target. -M virt works as today.
- -M arm:virt on bare qemu-system: single-target. The target:
  prefix selects TargetInfo arm and machine virt together. The
  token is target_name (arm, aarch64, riscv32, riscv64).
  Properties stay after the machine name:
  -M aarch64:virt,gic-version=3D3.
- Bare qemu-system and -M has no target: prefix: not supported
  yet. Fail with an error that this would be a heterogeneous
  machine (SYS_EMU_TARGET_HETEROGENEOUS), which is deferred, and
  point at -M arm:virt and (proposal A) -target. Do not start
  the VM. -M help / -device help with no selected TargetInfo may
  still list the union so users can pick a qualified name.

If argv[0] and a target: prefix are both given, they must match.
Unknown prefix names fail. -M help may also print qualified names
(arm:virt, riscv64:virt) so users can opt into a single-target run.

Proposal A: -target plus -M target:machine
------------------------------------------

Pierrick suggested -target. Keep it as an optional way to select
TargetInfo on the combined binary. It is not mandatory on
qemu-system.

- -target aarch64: single-target. Later filtering can make this
  look like qemu-system-aarch64. -M virt works as today.
- If both -target and a target: prefix are given, they must match.
  Unknown -target names fail and point at -target ?.

  qemu-system -M help
  qemu-system -M virt              # error: heterogeneous not supported
  qemu-system -M arm:virt ...
  qemu-system -target aarch64 -M virt ...
  qemu-system-riscv64 -M virt ...

Proposal B: target only in -M or argv[0] (alternative)
-----------------------------------------------------

Do not add -target. The target is always embedded in the machine
argument, or inferred from argv[0].

- qemu-system-aarch64 -M virt: single-target from argv[0].
- qemu-system -M arm:virt: single-target from -M.
- qemu-system -M virt: error (heterogeneous not supported yet).

There is no global option that selects TargetInfo before -M.
Early option parsing still has to read -M (and argv[0]) before
machines initialize, the same as proposal A reads -target.

  qemu-system -M help
  qemu-system -M virt              # error: heterogeneous not supported
  qemu-system -M arm:virt ...
  qemu-system -M aarch64:virt,gic-version=3D3 ...
  qemu-system-riscv64 -M virt ...

Compared with A: one place to write the target on the combined
binary (-M), no new flag, no -target vs -M mismatch cases. The
cost is that qemu-system -M virt is never a hidden alias for
aarch64; colliding names must be qualified, and a single-target
view of the union binary is qemu-system -M aarch64:virt, not
qemu-system -target aarch64 -M virt.

Please pick A or B; the rest of this RFC is the same either way.

SYS_EMU_TARGET_HETEROGENEOUS (deferred)
--------------------------------------

QAPI SysEmuTarget today is the configure list (aarch64, arm,
riscv64, ...). A later process with no selected TargetInfo and no
target: on -M would need a value that is not a single linked
target: add heterogeneous (C name SYS_EMU_TARGET_HETEROGENEOUS).
It would be a process mode, not a ./configure target and not
qemu-system-heterogeneous.

The first series does not add that enum and does not run that
mode. qemu-system -M virt with no argv[0] target and no -target
fails with an error: heterogeneous machines are not supported
yet; use -M arm:virt (and -target in proposal A). How such a
machine would name per-CPU / per-device targets is later work.

target-info-def.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The minimum compile unit for several targets in one process is
target-info-def.c built once per target (COMPILING_PER_TARGET).
Each translation unit registers one TargetInfo and a
TYPE_TARGET_INFO QOM class. meson already does that for
qemu-system-$TARGET. Combined qemu-system extracts those objects
from every participating target, plus arch objects from a primary
per base architecture (aarch64 and riscv64 for the first pair).

That is enough to have several TargetInfo values. Selecting one
TargetInfo (-M arm:virt, argv[0], and -target in proposal A) picks
one value for the run. With none of those, the first series errors
out; it does not invent SYS_EMU_TARGET_HETEROGENEOUS. That is not
enough to look like a single-target binary. That is the point of
the first merge.

TYPE_TARGET_SPECIFIC
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Pierrick's series "single-binary: implement dynamic filtering for
machine types" is a prerequisite and is already upstream. For a
usable combined binary we need it at least for machines: without
is_available(), -M virt in a union link is ambiguous or can start
the wrong board against the selected TargetInfo.

Help and introspection depend on whether TargetInfo is already
selected:

- No selected TargetInfo and no target: on -M: -M help /
  -device help may list the union (qualified names). Starting a
  machine is an error (heterogeneous not supported yet).
- Selected TargetInfo (argv[0], -M arm:virt, or -target in
  proposal A): filter with is_available() as today. -M virt is
  unambiguous once TargetInfo is selected.

We do not need to finish filtering every QOM class before the first
qemu-system exists. Machine-level TYPE_TARGET_SPECIFIC (already
wired for ARM and RISC-V boards) is enough to select a board after
TargetInfo is selected. Device and class leakage with -target is what
Berrange measured; on experimental qemu-system that is accepted
until filtering-against-qemu-system. Without a selected TargetInfo
and without a target: prefix on -M, do not run; error.

New TYPE_TARGET_SPECIFIC annotations in the first series should be
limited to what the combined link needs. Not a campaign to tag
every class.

TargetCpuOps must be a map
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

A combined link cannot keep one global C symbol per architecture
for query-cpu-definitions, dump notes, or Angel semihosting.
Commit b444b4fb6ecb ("target-info: dispatch CPU QMP, dump, and
arm/riscv semihosting") moved those handlers onto TargetCpuOps and
TARGET_INFO_CPU_OP (one member at a time, type_init). That
direction is required.

The implementation is not complete. It uses a single process-wide

  static TargetCpuOps target_cpu_ops;

and target_info_register_cpu_op() stores a member only when
cpu_type matches the already selected TargetInfo. Other
architectures are dropped. That depends on MODULE_INIT_QOM running
after target_info_qom_set_target(). It is the same class of
assumption we cannot test until a combined binary exists, and it
is the wrong shape even for qemu-system-*: one global filled or
ignored by init order, instead of a table keyed by the selected
target.

Proposal: keep TARGET_INFO_CPU_OP. Replace the single global with
a map from the selected target to its TargetCpuOps. Lookup uses
target_arch() (SysEmuTarget):

  target_info_cpu_ops() -> &map[target_arch()]

Registration always fills that architecture's slot. It does not
compare against the currently selected TargetInfo and drop the
rest.

qemu-system-aarch64 has one occupied slot. qemu-system has one
slot per linked target. Same API, same callers in hw/core and
semihosting. Help paths with no selected TargetInfo
(qemu-system -M help) list the union and must not dispatch CPU
QMP / dump / semihosting through a single-arch ops table. A VM
start still needs argv[0], -M arm:virt, or -target (proposal A).
There is no map[SYS_EMU_TARGET_HETEROGENEOUS] until that mode
exists.

CPU_RESOLVING_TYPE is not a unique map key. TYPE_ARM_CPU is shared
by arm and aarch64, TYPE_RISCV_CPU by riscv32 and riscv64,
TYPE_X86_CPU by i386 and x86_64. Those siblings share one object
file in the combined link (the primary softmmu target).
Registration fills the compiling TARGET_ARCH, then aliases the
same TargetCpuOps to other SysEmuTarget values whose
TargetInfo.cpu_type matches. Lookup is still map[target_arch()].

What the first series is not
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

- Completing Kconfig / target / device filtering
- Implementing a heterogeneous machine. First series: error only.
  SYS_EMU_TARGET_HETEROGENEOUS and how it names per-CPU /
  per-device targets come later.
- Mandatory modules / splitting machines and devices (or a whole
  target) into .so / .dll / .dylib. That is the RSS follow-up
  once qemu-system exists, not a gate on linking it.
- A new experimental CLI (-nodefaults default, no default machine,
  dropping -hda / -drive, ordered args)
- Replacing qemu-system-$TARGET with a symlink

Symbol uniquify (QOM names, helpers, TYPE_ACCEL_CPU) remains
necessary to *link*. That is engineering, not a change in user
semantics.

filtering-against-qemu-system
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

Once qemu-system exists in the tree, filtering can be implemented
and tested for real:

  qemu-system -M riscv64:virt ...
  qemu-system -target riscv64 ...   # proposal A only
  qemu-system-riscv64 ...

That is the series that should drive qom-list-types, -device help,
and RSS toward the single-target numbers Berrange measured, for
the single-target path. Modules (always on for qemu-system, unused
targets not mapped) are the other RSS tool, after the binary
exists. Distros keep shipping qemu-system-$TARGET until they opt
into the combined binary.

The no-selected-TargetInfo path is an error until heterogeneous
support exists. Filtering must not make qemu-system -M help hide
other arches.

Please comment on this split, and on proposal A vs B. We are
close enough that a decision here is what lets the next series
land experimental qemu-system instead of waiting on filtering.

--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000f3a250065a16a0e5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>This is a design RFC, not a patch series. It fo=
llows review of<br><br>=C2=A0 [PATCH 00/12] single-binary: link ARM and RIS=
C-V into qemu-system<br>=C2=A0 <a href=3D"https://patchew.org/QEMU/20260823=
150731.896-1-luoyonggang@gmail.com/">https://patchew.org/QEMU/2026082315073=
1.896-1-luoyonggang@gmail.com/</a><br><br>=C2=A0 [PATCH v2 00/13] single-bi=
nary: link ARM and RISC-V into qemu-system<br>=C2=A0 <a href=3D"https://pat=
chew.org/QEMU/20260826184229.1145-1-luoyonggang@gmail.com/">https://patchew=
.org/QEMU/20260826184229.1145-1-luoyonggang@gmail.com/</a><br><br>and Danie=
l P. Berrange&#39;s measurements of that v1.<br><br>What v2 already did<br>=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><br>v2 of that=
 series already takes the v1 review that got maintainer<br>support:<br><br>=
- Keep real qemu-system-$TARGET (and $TARGETw on Windows). v1<br>=C2=A0 ins=
talled per-arch names as symlinks to qemu-system; v2 does<br>=C2=A0 not. qe=
mu-system is an extra binary from the ARM+RISC-V union,<br>=C2=A0 behind a =
meson option.<br>- argv[0] still selects the target for qemu-system-aarch64=
.<br>- Drop v1 little- and big-endian TargetInfo variants<br>=C2=A0 (target=
-info-&lt;name&gt;-le/be, -target aarch64-le). One TargetInfo<br>=C2=A0 per=
 target_name. Endian variants are later work.<br>- -target ? lists target_n=
ame only. Unknown names point at<br>=C2=A0 -target ? rather than printing t=
he list and exit(1).<br>- Do not build qemu-systemw for the combined binary=
, so Windows<br>=C2=A0 data exports (qdev_prop_array / qdev_prop_*) do not =
block<br>=C2=A0 enabling modules later.<br>- TargetCpuOps (b444b4fb) for QM=
P CPU queries, dump, and ARM/RISC-V<br>=C2=A0 semihosting, still as one pro=
cess-wide table filtered at<br>=C2=A0 register time. This RFC revises that =
into a map.<br><br>v2 still required -target on bare qemu-system, still use=
d<br>TYPE_TARGET_SPECIFIC on the combined binary, and did not mark<br>qemu-=
system experimental. Those are what this RFC asks to freeze<br>before posti=
ng the next series: extra binary stays, filtering is<br>not a gate, proposa=
l A vs B. Heterogeneous (no target: on -M)<br>stays an error until later.<b=
r><br>Why this RFC now<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<=
br><br>We are very close to a linked qemu-system that contains more than<br=
>one target (ARM + RISC-V; see v2 above). v2 already dropped the<br>symlink=
. The remaining delay is not &quot;can it link&quot;, it is unresolved<br>p=
roduct questions: -target vs -M only, complete filtering before<br>the firs=
t binary exists, experimental union vs looking like<br>$TARGET.<br><br>This=
 RFC is to freeze those questions so the next series can land<br>an experim=
ental qemu-system quickly, instead of another patch bomb<br>that still deba=
tes the end result. Filtering, heterogeneous<br>machines, modules for RSS, =
and CLI polish can follow against a<br>real binary. Please comment on the s=
plit and on proposal A vs B;<br>that is what unblocks the merge.<br><br>The=
sis<br>=3D=3D=3D=3D=3D=3D<br><br>Land an extra, experimental qemu-system fi=
rst, without completing<br>target/device filtering. Use that binary as the =
test vehicle for<br>filtering. Keep today&#39;s qemu-system-$TARGET as real=
 binaries, not<br>symlinks.<br><br>qemu.git has no combined qemu-system tod=
ay. Filtering, uniquify,<br>and CPU-op dispatch are therefore untested assu=
mptions. Completing<br>TYPE_TARGET_SPECIFIC against qemu-system-riscv64 (a =
single-target<br>link) does not prove the union case. We need a real qemu-s=
ystem in<br>the tree before filtering can be designed against measured<br>b=
ehavior.<br><br>Berrange compared a v1 qemu-system-riscv64 *symlink* to tod=
ay&#39;s<br>standalone binary:<br><br>- qom-list-types went from about 770 =
classes to about 1530 (ARM<br>=C2=A0 types leak into RISC-V)<br>- -device h=
elp grew<br>- RSS for -nodefaults -display none -M none went from 17.3 MB t=
o<br>=C2=A0 20.7 MB<br>- A full-union guess was much worse for RISC-V<br><b=
r>That is a packaging blocker if $TARGET becomes a symlink. Extra RAM<br>on=
 a *new* experimental qemu-system is acceptable if we document<br>that this=
 binary exposes the union. It is also not the last word<br>on RSS.<br><br>O=
nce modules are always enabled for qemu-system, unused machines<br>and devi=
ces can live in .so / .dll / .dylib and stay out of the<br>startup working =
set. One simple shape is one module per target, so<br>qemu-system -M arm:vi=
rt (or -target aarch64) loads the ARM module<br>and does not map RISC-V boa=
rds. That is later work, not a blocker<br>for the first extra binary (Mark =
Cave-Ayland already suggested<br>mandatory modules for qemu-system; Berrang=
e did not want to block<br>on that). The first merge still links the union =
into one<br>executable so we have something to test.<br><br>This split is m=
eant to take both review positions at the layer they<br>apply to:<br><br>- =
Berrange / Paolo: do not replace qemu-system-$TARGET with a<br>=C2=A0 symli=
nk. A new qemu-system can be its own thing.<br>- Pierrick: select TargetInf=
o when the user wants a single-target<br>=C2=A0 view; TYPE_TARGET_SPECIFIC =
as the filtering mechanism. Matching<br>=C2=A0 $TARGET introspection is the=
 *goal* of a later filtering series,<br>=C2=A0 not a gate on the first link=
.<br><br>Two CLI proposals for how to select one TargetInfo are below.<br>T=
hey share argv[0] and -M target:machine. They differ on whether<br>-target =
exists. A run with no selected TargetInfo (heterogeneous /<br>SYS_EMU_TARGE=
T_HETEROGENEOUS) is deferred: the first series only<br>prints an error.<br>=
<br>experimental-qemu-system<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><br>Keep building real qemu-system-$TARGE=
T as today (and $TARGETw on<br>Windows). Add qemu-system alongside them, fr=
om the union of ARM and<br>RISC-V for the first pair, behind a meson option=
, marked<br>experimental.<br><br>Do not install per-arch names as symlinks =
to qemu-system. Distro<br>packaging of qemu-system-riscv64 stays on the old=
 RSS and QOM list.<br><br>The combined binary is documented as exposing eve=
rything that was<br>linked. Incomplete device filtering is an accepted expe=
rimental<br>defect, not a release blocker for this first binary. -M help /<=
br>-device help with no selected TargetInfo may still list the union.<br>St=
arting a machine that way is not supported yet (error; see<br>below).<br><b=
r>Binding TargetInfo<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D<br><br>A combined process has more than one TargetInfo (target_name, pa=
ge<br>bits, long width, CPU_RESOLVING_TYPE, endianness).<br><br>In this mai=
l, single-target means the process has one selected<br>TargetInfo / SysEmuT=
arget, like qemu-system-$TARGET today.<br>Heterogeneous would mean it does =
not (SYS_EMU_TARGET_HETEROGENEOUS).<br>That mode is not implemented yet.<br=
><br>Single-target runs still pick one TargetInfo before the chosen<br>mach=
ine and accelerators initialize.<br><br>Shared in both proposals:<br><br>- =
argv[0]: qemu-system-aarch64 infers aarch64. Existing $TARGET<br>=C2=A0 com=
mand lines stay valid. Single-target. -M virt works as today.<br>- -M arm:v=
irt on bare qemu-system: single-target. The target:<br>=C2=A0 prefix select=
s TargetInfo arm and machine virt together. The<br>=C2=A0 token is target_n=
ame (arm, aarch64, riscv32, riscv64).<br>=C2=A0 Properties stay after the m=
achine name:<br>=C2=A0 -M aarch64:virt,gic-version=3D3.<br>- Bare qemu-syst=
em and -M has no target: prefix: not supported<br>=C2=A0 yet. Fail with an =
error that this would be a heterogeneous<br>=C2=A0 machine (SYS_EMU_TARGET_=
HETEROGENEOUS), which is deferred, and<br>=C2=A0 point at -M arm:virt and (=
proposal A) -target. Do not start<br>=C2=A0 the VM. -M help / -device help =
with no selected TargetInfo may<br>=C2=A0 still list the union so users can=
 pick a qualified name.<br><br>If argv[0] and a target: prefix are both giv=
en, they must match.<br>Unknown prefix names fail. -M help may also print q=
ualified names<br>(arm:virt, riscv64:virt) so users can opt into a single-t=
arget run.<br><br>Proposal A: -target plus -M target:machine<br>-----------=
-------------------------------<br><br>Pierrick suggested -target. Keep it =
as an optional way to select<br>TargetInfo on the combined binary. It is no=
t mandatory on<br>qemu-system.<br><br>- -target aarch64: single-target. Lat=
er filtering can make this<br>=C2=A0 look like qemu-system-aarch64. -M virt=
 works as today.<br>- If both -target and a target: prefix are given, they =
must match.<br>=C2=A0 Unknown -target names fail and point at -target ?.<br=
><br>=C2=A0 qemu-system -M help<br>=C2=A0 qemu-system -M virt =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# error: heterogeneous not supported<br>=
=C2=A0 qemu-system -M arm:virt ...<br>=C2=A0 qemu-system -target aarch64 -M=
 virt ...<br>=C2=A0 qemu-system-riscv64 -M virt ...<br><br>Proposal B: targ=
et only in -M or argv[0] (alternative)<br>---------------------------------=
--------------------<br><br>Do not add -target. The target is always embedd=
ed in the machine<br>argument, or inferred from argv[0].<br><br>- qemu-syst=
em-aarch64 -M virt: single-target from argv[0].<br>- qemu-system -M arm:vir=
t: single-target from -M.<br>- qemu-system -M virt: error (heterogeneous no=
t supported yet).<br><br>There is no global option that selects TargetInfo =
before -M.<br>Early option parsing still has to read -M (and argv[0]) befor=
e<br>machines initialize, the same as proposal A reads -target.<br><br>=C2=
=A0 qemu-system -M help<br>=C2=A0 qemu-system -M virt =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0# error: heterogeneous not supported<br>=C2=A0 q=
emu-system -M arm:virt ...<br>=C2=A0 qemu-system -M aarch64:virt,gic-versio=
n=3D3 ...<br>=C2=A0 qemu-system-riscv64 -M virt ...<br><br>Compared with A:=
 one place to write the target on the combined<br>binary (-M), no new flag,=
 no -target vs -M mismatch cases. The<br>cost is that qemu-system -M virt i=
s never a hidden alias for<br>aarch64; colliding names must be qualified, a=
nd a single-target<br>view of the union binary is qemu-system -M aarch64:vi=
rt, not<br>qemu-system -target aarch64 -M virt.<br><br>Please pick A or B; =
the rest of this RFC is the same either way.<br><br>SYS_EMU_TARGET_HETEROGE=
NEOUS (deferred)<br>--------------------------------------<br><br>QAPI SysE=
muTarget today is the configure list (aarch64, arm,<br>riscv64, ...). A lat=
er process with no selected TargetInfo and no<br>target: on -M would need a=
 value that is not a single linked<br>target: add heterogeneous (C name SYS=
_EMU_TARGET_HETEROGENEOUS).<br>It would be a process mode, not a ./configur=
e target and not<br>qemu-system-heterogeneous.<br><br>The first series does=
 not add that enum and does not run that<br>mode. qemu-system -M virt with =
no argv[0] target and no -target<br>fails with an error: heterogeneous mach=
ines are not supported<br>yet; use -M arm:virt (and -target in proposal A).=
 How such a<br>machine would name per-CPU / per-device targets is later wor=
k.<br><br>target-info-def.c<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br><br>The minimum compile unit for several targets in one proces=
s is<br>target-info-def.c built once per target (COMPILING_PER_TARGET).<br>=
Each translation unit registers one TargetInfo and a<br>TYPE_TARGET_INFO QO=
M class. meson already does that for<br>qemu-system-$TARGET. Combined qemu-=
system extracts those objects<br>from every participating target, plus arch=
 objects from a primary<br>per base architecture (aarch64 and riscv64 for t=
he first pair).<br><br>That is enough to have several TargetInfo values. Se=
lecting one<br>TargetInfo (-M arm:virt, argv[0], and -target in proposal A)=
 picks<br>one value for the run. With none of those, the first series error=
s<br>out; it does not invent SYS_EMU_TARGET_HETEROGENEOUS. That is not<br>e=
nough to look like a single-target binary. That is the point of<br>the firs=
t merge.<br><br>TYPE_TARGET_SPECIFIC<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><br>Pierrick&#39;s series &quot;single-binar=
y: implement dynamic filtering for<br>machine types&quot; is a prerequisite=
 and is already upstream. For a<br>usable combined binary we need it at lea=
st for machines: without<br>is_available(), -M virt in a union link is ambi=
guous or can start<br>the wrong board against the selected TargetInfo.<br><=
br>Help and introspection depend on whether TargetInfo is already<br>select=
ed:<br><br>- No selected TargetInfo and no target: on -M: -M help /<br>=C2=
=A0 -device help may list the union (qualified names). Starting a<br>=C2=A0=
 machine is an error (heterogeneous not supported yet).<br>- Selected Targe=
tInfo (argv[0], -M arm:virt, or -target in<br>=C2=A0 proposal A): filter wi=
th is_available() as today. -M virt is<br>=C2=A0 unambiguous once TargetInf=
o is selected.<br><br>We do not need to finish filtering every QOM class be=
fore the first<br>qemu-system exists. Machine-level TYPE_TARGET_SPECIFIC (a=
lready<br>wired for ARM and RISC-V boards) is enough to select a board afte=
r<br>TargetInfo is selected. Device and class leakage with -target is what<=
br>Berrange measured; on experimental qemu-system that is accepted<br>until=
 filtering-against-qemu-system. Without a selected TargetInfo<br>and withou=
t a target: prefix on -M, do not run; error.<br><br>New TYPE_TARGET_SPECIFI=
C annotations in the first series should be<br>limited to what the combined=
 link needs. Not a campaign to tag<br>every class.<br><br>TargetCpuOps must=
 be a map<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br><br>A combined link cannot keep one global C symbol p=
er architecture<br>for query-cpu-definitions, dump notes, or Angel semihost=
ing.<br>Commit b444b4fb6ecb (&quot;target-info: dispatch CPU QMP, dump, and=
<br>arm/riscv semihosting&quot;) moved those handlers onto TargetCpuOps and=
<br>TARGET_INFO_CPU_OP (one member at a time, type_init). That<br>direction=
 is required.<br><br>The implementation is not complete. It uses a single p=
rocess-wide<br><br>=C2=A0 static TargetCpuOps target_cpu_ops;<br><br>and ta=
rget_info_register_cpu_op() stores a member only when<br>cpu_type matches t=
he already selected TargetInfo. Other<br>architectures are dropped. That de=
pends on MODULE_INIT_QOM running<br>after target_info_qom_set_target(). It =
is the same class of<br>assumption we cannot test until a combined binary e=
xists, and it<br>is the wrong shape even for qemu-system-*: one global fill=
ed or<br>ignored by init order, instead of a table keyed by the selected<br=
>target.<br><br>Proposal: keep TARGET_INFO_CPU_OP. Replace the single globa=
l with<br>a map from the selected target to its TargetCpuOps. Lookup uses<b=
r>target_arch() (SysEmuTarget):<br><br>=C2=A0 target_info_cpu_ops() -&gt; &=
amp;map[target_arch()]<br><br>Registration always fills that architecture&#=
39;s slot. It does not<br>compare against the currently selected TargetInfo=
 and drop the<br>rest.<br><br>qemu-system-aarch64 has one occupied slot. qe=
mu-system has one<br>slot per linked target. Same API, same callers in hw/c=
ore and<br>semihosting. Help paths with no selected TargetInfo<br>(qemu-sys=
tem -M help) list the union and must not dispatch CPU<br>QMP / dump / semih=
osting through a single-arch ops table. A VM<br>start still needs argv[0], =
-M arm:virt, or -target (proposal A).<br>There is no map[SYS_EMU_TARGET_HET=
EROGENEOUS] until that mode<br>exists.<br><br>CPU_RESOLVING_TYPE is not a u=
nique map key. TYPE_ARM_CPU is shared<br>by arm and aarch64, TYPE_RISCV_CPU=
 by riscv32 and riscv64,<br>TYPE_X86_CPU by i386 and x86_64. Those siblings=
 share one object<br>file in the combined link (the primary softmmu target)=
.<br>Registration fills the compiling TARGET_ARCH, then aliases the<br>same=
 TargetCpuOps to other SysEmuTarget values whose<br>TargetInfo.cpu_type mat=
ches. Lookup is still map[target_arch()].<br><br>What the first series is n=
ot<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<br><br>- Completing Kconfig / target / device filtering<br>=
- Implementing a heterogeneous machine. First series: error only.<br>=C2=A0=
 SYS_EMU_TARGET_HETEROGENEOUS and how it names per-CPU /<br>=C2=A0 per-devi=
ce targets come later.<br>- Mandatory modules / splitting machines and devi=
ces (or a whole<br>=C2=A0 target) into .so / .dll / .dylib. That is the RSS=
 follow-up<br>=C2=A0 once qemu-system exists, not a gate on linking it.<br>=
- A new experimental CLI (-nodefaults default, no default machine,<br>=C2=
=A0 dropping -hda / -drive, ordered args)<br>- Replacing qemu-system-$TARGE=
T with a symlink<br><br>Symbol uniquify (QOM names, helpers, TYPE_ACCEL_CPU=
) remains<br>necessary to *link*. That is engineering, not a change in user=
<br>semantics.<br><br>filtering-against-qemu-system<br>=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><b=
r>Once qemu-system exists in the tree, filtering can be implemented<br>and =
tested for real:<br><br>=C2=A0 qemu-system -M riscv64:virt ...<br>=C2=A0 qe=
mu-system -target riscv64 ... =C2=A0 # proposal A only<br>=C2=A0 qemu-syste=
m-riscv64 ...<br><br>That is the series that should drive qom-list-types, -=
device help,<br>and RSS toward the single-target numbers Berrange measured,=
 for<br>the single-target path. Modules (always on for qemu-system, unused<=
br>targets not mapped) are the other RSS tool, after the binary<br>exists. =
Distros keep shipping qemu-system-$TARGET until they opt<br>into the combin=
ed binary.<br><br>The no-selected-TargetInfo path is an error until heterog=
eneous<br>support exists. Filtering must not make qemu-system -M help hide<=
br>other arches.<br><br>Please comment on this split, and on proposal A vs =
B. We are<br>close enough that a decision here is what lets the next series=
<br>land experimental qemu-system instead of waiting on filtering.<div><br>=
--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=
=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggan=
g Luo</div></div>

--000000000000f3a250065a16a0e5--

