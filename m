Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9172CCD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMt0-0002bh-FL; Fri, 08 May 2026 11:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMsv-0002bI-Q6
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:02 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMst-0001aU-Pu
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:01 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-662efd1bdd4so1203267eaf.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778253176; x=1778857976; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PfEa1u1ADi/eDcpMRY+tA8ABFKIbuDPSGqDvCkk+dLE=;
 b=nCWTlp9MkeWl3O063vsvEdzFVuJjL9xhhydcq5ppRm37VZhHwdT1f9sJ9nJnVOOlVX
 irqPUOtII5f32lmsX9vi6h/pQVlozyK+JcTEAapJimqF1TL+sn76+yfJII0nr04LaeHO
 Q3k36vPRj+3wOEPA4/0mH1rpj/DtSCJDxG81lgfEIxG4wco2KnkDRrEv0j2FACIjhRPY
 i0z2+n3sT+5eWf76PvNJpk+cLtD93LLT07eana/yYyLlCwtCN6qWZ6e35shMqrv6AFdR
 lhpwwKg1P9hKY/HatffNQY+QPNOktKF+p6w5RXWxFBl2FuXentak+I+JaBX+aohZrNHY
 W7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253176; x=1778857976;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PfEa1u1ADi/eDcpMRY+tA8ABFKIbuDPSGqDvCkk+dLE=;
 b=f/5UoV3R2LP++ECX/VVxmoSD34///5XuCxHaWLUBuybLswTfg5EYrRl8asSXulqTEs
 /Rzc9CE/chn3TiD52x84wTMvg3gyE4LG6UnVuiPFE8qJ960dtp9G0PN4MUgZu8SQIkXa
 eLZOddqN1RBYiCKbnD7tJTO2FCoB4is707Qykx8Inu71dIe6slQi8v6MzdKvDgGbh9Ec
 NEc0rB59TY7HV0gAFHZ/fO3krbLkcQ8NWzZvIERlq+BbBFNiG+NpJQaU28YbtSdBCTbQ
 T6s/XSRKChTdfffRuEX8TnXn0D1z8sJi5lXg7T0b2wgIuNDDmdCfzMctqeQGg9EZXW7z
 vPvA==
X-Gm-Message-State: AOJu0YwsIFPASwJ+u9Jy7cjgSlB0pLtt0/ifKWpBBlTYFmnF0y0nKq9m
 usi5uLJpF4auQyPvH2cdWzzvvcTIIZPl5WrA4XkcI8/sp/8ri7LwopbrOQGmAg==
X-Gm-Gg: AeBDietCaNl0YeELRT4Vhlj3Tavjxhvqd1YXiR/zUL940gPXCyVnXgHZ3MKAvssF2oK
 UKVMhjmaNRuFxHvUsSn9xa6pAKPv2qzjMEeoY/AJPd8Nu0BvP+P8I9khgKZhJcEv/p1ZsqOSpGh
 YqNN5QA+WpqAGpC1OB5VD+hsNLRMOgGpQBqaP8UUVfBDMWlzoRMpugw3sEWNipfu46QSsnRqO9j
 Pye66OJpcoPjBV84ci85+K5MGQtohQQWxY0Xkt6AkI3dTfNpvF6T3hcsMxnmKLF1d23+CkRgPiI
 plECJu+v7P0xRlzaqlmHLHcmE0JeqH6OuCuHiPRFnRGP7kd6zkJ6trqaDVtD0dKriVpv9gN+4rD
 Xs2v7ltLDoOxKALy9Rro5DPhr9JvFyemAAAa9WRmX735S58olCBXvWcI3kb4R9Dx3HlFZCh6jmG
 MqK4Hj0nckmwZm6EAE4+4KupOVWxQ21VEBoZaOfug3c5zl/dIyBGyFh/TF2sItIyXkSgxI7eKTv
 vQGfU7m6Mhh0pgnXMrgvPgwRf5ia4cbiEtbZFpckAcMU6W+b5fErOgHyo/JPan/D3cspEx6Q5rv
 rCRzAvTzfz4Tp/dX3vRi9RgGfKGxAKjIXbAcHXpFhWqD6ngrYOGJQCFoTJDUtF9S8oFMs4Q=
X-Received: by 2002:a4a:da5a:0:b0:696:7f40:b760 with SMTP id
 006d021491bc7-699ab57108emr2867238eaf.6.1778253176041; 
 Fri, 08 May 2026 08:12:56 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (71-218-113-237.hlrn.qwest.net. [71.218.113.237])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b7dsm1897904fac.5.2026.05.08.08.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:12:55 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v3 00/32] target/mips: add missing Octeon user-mode support
Date: Fri, 08 May 2026 09:12:00 -0600
Message-Id: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NzQ6CQAwGX4Xs2ZplUf5OvofhgKVAjeySLRIN4
 d1dMF5NeugkX2YWJeSZRJXRojzNLOxsgOQQKexr2xFwE1gZbVJ9MhoGHgUcTuRs+EXYdsBWrMB
 s4ExpkWSZxtagCorRU8uvXX+tvizP251w2pzbomeZnH/v/dlsu18q/p8Kp6HWWRE3bZznWFy6o
 ebHEd2gqnVdP5dnhDPaAAAA
X-Change-ID: 20260420-mips-octeon-missing-insns-v2-5e693770cf2c
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oo1-xc36.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series updates MIPS linux-user unaligned-access behavior and fills
in missing Octeon user-mode instruction support used by existing Octeon
binaries.

The first patches model the Linux/MIPS sysmips ABI pieces needed by
linux-user, including MIPS_FLUSH_CACHE, MIPS_ATOMIC_SET, and the
MIPS_FIXADE policy used to control unaligned scalar access fixups.
User-mode unaligned scalar accesses default to software fixups and
sysmips(MIPS_FIXADE) can toggle SIGBUS/BUS_ADRALN behavior.

The Octeon patches add integer, indexed memory, atomic, multiplier, COP2
crypto, CHORD, and LLM support. The series also adds a small
mips64/mips64el TCG guest test covering representative Octeon integer,
multiplier, and COP2 selector paths. The final patch corrects the
Octeon68XX CP1 feature bits and FCR defaults.

Changes since v1:
- Split BADDU/DMUL destination fixes into a preliminary patch.
- Split the SEQ/SNE decode refactoring into a preliminary patch.
- Moved Octeon multiplier state to uint64_t arrays and updated VMState.
- Switched Octeon helper ABIs to i64/uint64_t where applicable.
- Moved COP2 selector decode/support logic into octeon_translate.c.
- Added in-tree TCG tests for mips64 and mips64el linux-user.
- Used switch ranges and g_assert_not_reached() for SHA3/ZUC shared
  selector handling.
- Dropped Octeon prefixes from generic Camellia helper routines.
- Replaced the reflected GFM 64-bit carryless multiply loop with
  crypto/clmul.h.
- Moved the Octeon68XX CP1 CPU-model correction to the end of the
  series.
- Added migration coverage for Octeon COP2 crypto and LLM sparse state.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v3:
- Rebased on current qemu.git master.
- Split sysmips support into separate MIPS_FLUSH_CACHE, MIPS_ATOMIC_SET,
  and MIPS_FIXADE patches.
- Made MIPS_ATOMIC_SET always use the MIPS separate error-result register
  path for successful returns.
- Removed redundant Octeon MIPS64 checks and target-long guards from the
  translator paths.
- Removed zero-register fast paths where gen_store_gpr() already handles
  discarded writes.
- Reworked SEQ/SNE decode and LA* translator helpers as requested.
- Split the Octeon arithmetic/memory patch into narrower state, indexed
  load, SAA/SAAD, ZCB, multiplier, and test patches.
- Switched Octeon multiplier limb accumulation to uadd64_overflow().
- Link to v2: https://lore.kernel.org/qemu-devel/20260421-mips-octeon-missing-insns-v2-v2-0-a0791df188c9@gmail.com

To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Helge Deller <deller@gmx.de>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Aleksandar Rikalo <arikalo@gmail.com>
Cc: Huacai Chen <chenhuacai@kernel.org>

---
James Hilliard (32):
      linux-user/mips: implement sysmips(MIPS_FLUSH_CACHE)
      linux-user/mips: implement sysmips(MIPS_ATOMIC_SET)
      linux-user/mips, target/mips: honor MIPS_FIXADE for unaligned accesses
      target/mips: fix Octeon arithmetic destination handling
      target/mips: split Octeon SEQ/SNE decode
      target/mips: drop Octeon zero-register fast paths
      target/mips: add Octeon multiplier state
      target/mips: add Octeon LBX instruction
      target/mips: add Octeon LHUX instruction
      target/mips: add Octeon LWUX instruction
      target/mips: add Octeon SAA instruction
      target/mips: add Octeon SAAD instruction
      target/mips: add Octeon ZCB instruction
      target/mips: add Octeon ZCBT instruction
      target/mips: add Octeon MTM0 instruction
      target/mips: add Octeon MTP0 instruction
      target/mips: add Octeon MTP1 instruction
      target/mips: add Octeon MTP2 instruction
      target/mips: add Octeon MTM1 instruction
      target/mips: add Octeon MTM2 instruction
      target/mips: add Octeon VMULU instruction
      target/mips: add Octeon VMM0 instruction
      target/mips: add Octeon V3MULU instruction
      tests/tcg/mips: add Octeon instruction smoke test
      target/mips: add Octeon LA* atomic instructions
      target/mips: add Octeon COP2 crypto core support
      target/mips: add Octeon SMS4 crypto support
      target/mips: add Octeon SHA3 crypto support
      target/mips: add Octeon ZUC crypto support
      target/mips: add Octeon Camellia crypto support
      target/mips: add Octeon CHORD and LLM COP2 support
      target/mips: expose Octeon68XX floating-point support

 MAINTAINERS                                   |    2 +
 linux-user/mips/cpu_loop.c                    |    5 +
 linux-user/mips/target_syscall.h              |    3 +
 linux-user/mips64/target_syscall.h            |    3 +
 linux-user/syscall.c                          |   56 +
 target/mips/cpu-defs.c.inc                    |   10 +-
 target/mips/cpu.c                             |   75 +-
 target/mips/cpu.h                             |  249 +++
 target/mips/helper.h                          |    6 +
 target/mips/internal.h                        |    3 +
 target/mips/system/machine.c                  |  142 ++
 target/mips/tcg/meson.build                   |    1 +
 target/mips/tcg/octeon.decode                 |   46 +-
 target/mips/tcg/octeon_crypto.c               | 2479 +++++++++++++++++++++++++
 target/mips/tcg/octeon_translate.c            |  595 +++++-
 target/mips/tcg/op_helper.c                   |  100 +
 target/mips/tcg/translate.c                   |   23 +-
 target/mips/tcg/translate.h                   |    1 +
 tests/tcg/mips/Makefile.target                |   11 +
 tests/tcg/mips/user/isa/octeon/octeon-insns.c |  216 +++
 tests/tcg/mips64/Makefile.target              |   20 +
 tests/tcg/mips64el/Makefile.target            |    8 +
 22 files changed, 3997 insertions(+), 57 deletions(-)
---
base-commit: ee7eb612be8f8886d48c1d0c1f1c65e495138f83
change-id: 20260420-mips-octeon-missing-insns-v2-5e693770cf2c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>


