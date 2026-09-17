Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB00EC982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x78UX-000423-UZ; Thu, 17 Sep 2026 05:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x78UV-00041G-T3
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:33:15 -0400
Received: from mail-pj2-x16.google.com ([2607:f8b0:4864:39::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x78UT-00017I-4Z
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:33:15 -0400
Received: by mail-pj2-x16.google.com with SMTP id
 d9443c01a7336-2db22383fe8so3897505ad.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 02:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789637590; x=1790242390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WeBu3OqJ3NOxWaPPmPmE9NB47uU9V4jx9/8Q8TikDDE=;
 b=Q9S74W7XLD2bnrMrjjcIhYuEas3HNte75jYn6lcaQAhGcqJPXkW1U9D4ZMyfYuV6BP
 g6WB7bswuJJ/K7qNmkCiN9i1Bo6KvEq4553ePzr83XM3UUUBlpY32MJT4XWNBF+fMFzk
 6BEYmF4JOknDsXwpv3XXjJpeOv8zlyEzvjhyn2otIWz9llvPHk00292ujoeq0yo/o0Bd
 Ea+3UBUJqL+qw3NKxZnTWdtbNnbUZ5N6rK5UI75ToXh5C0W52cS6GHdsJqCT34O++qJA
 zA8zEQwm9LetqoPpW0KHSmo28pDEM3/vvtNOQL27UFAbh+/0d+6IvRP41XoFXYKYus2D
 gyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789637590; x=1790242390;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WeBu3OqJ3NOxWaPPmPmE9NB47uU9V4jx9/8Q8TikDDE=;
 b=JDZrtcXnqhZXnKNM2twE8q5wz85bJJ/THtOR3O63EzOQl/sjhosIz6CeRRaY2HHSzJ
 ceYSRpDyLgZMNj9pJ/0CSKe0b+nBNgeFeT9tyHWgIJZPZ3K3BUhhd43yqgIrWs8ZKVhi
 Qh1ihzq+969TF2PJLNsztLvtA/MqOJl2dhRwO8qXdFjrneck5DtqG4icc3NNGXnYUG6h
 Oqf357rI99956SSL/3BM43yToiTfuENC87J4Q8vB3z/7kUjek9BFSBAyJ6Kd6KC2qbxK
 0OB9Zs098rB9alLrZOd5wdJG/VT1j+1V0/9vofAnNUGh/2ATSrBkbOweuC+d4nPvjeM5
 L/eA==
X-Gm-Message-State: AFuF++ljzmRLp3JQoXt/A1m8gihlzNhieCTKZDRgtSLGU6voeM0MlBSJ
 Au+hGO4HnBHo268119crzGSBE6Tn1gRhueSY1YvqVQihcQbqq7m3BgTVIHqbZ5lfQdmffcS5Zep
 c4Nr5Ufs=
X-Gm-Gg: AYBFou3D9ZqM/RCTy+gUfKvgJEta+F1WOgxcJdKxwlWBtL1EZ63+IQWMhBwvts2ILJ4
 WacdU02Uu03Qf0j9GXryGghgv0BqA+4yzemyJqH0LD4teqoGwzOqSYC2JGGzGDaR5jsholZubkt
 nMhEPE5X6hkmqxt7rA9kvh40x4EA1aec+LYWiBYOnA0KEi30aFPzDprE4aGJ2FelXqCM4nYVqV2
 1UknJufIi/GLW+5BIa4KYzZsBYWMfv26JcgqxSqIfjbuu29ACZiQ8SoLZXu+mJgFHNS/JdST+iV
 1c/AgW4FgkWeQO0lwY+wJHoad+sqRbIq4Bj81JXFPKaeunWOGXbCSK7pjnau5ZNHpPunMpirLKu
 Ej5XS0da6V223SqcUhgc1A79IpJSLdT2LE4PxSNIq+FqztuhtCIS+riSzUktFztK+a4ejp1KshR
 6sEqaSg2BCeYCQf3f5mWfWy2zh8OK03ON/O1xqUcLo9d/9yYueUWN28bRx0PEHp8SNNs6SnCpAH
 JBpJ/c=
X-Received: by 2002:a17:90a:e7d2:b0:398:a145:5d3d with SMTP id
 98e67ed59e1d1-39e1e2daa81mr16572239a91.6.1789637590129; 
 Thu, 17 Sep 2026 02:33:10 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm12494696c88.15.2026.09.17.02.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 02:33:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 00/13] accel/tcg: cut per-block dispatch overhead (parts
 4-6)
Date: Wed, 16 Sep 2026 23:32:54 -1000
Message-ID: <20260917093307.1092084-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::16;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x16.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Splitting Matt's larger patch set:

> 4  tcg: add tcg_gen_goto_jc_{i32,i64,tl}()
>
>    Preparation. A second dispatch interface alongside
>    tcg_gen_lookup_and_goto_ptr(), which is unchanged. The caller passes
>    the destination PC and thereby states that the CPU state is already
>    the destination's, which is what an inline lookup needs and what the
>    existing interface cannot promise. --enable-debug-tcg checks that
>    claim at runtime. Five targets are migrated; every other target and
>    every unmigrated call site is untouched.
>
> 5  accel/tcg: add CF_NO_GOTO_JC, set while a breakpoint is present
>
>    Preparation. The one thing an inline jump cache probe cannot check is
>    breakpoints, and it does not have to: the probe compares cflags, so a
>    cflag set while cpu->breakpoints is non-empty keeps such blocks both
>    from dispatching inline and from being reached by a block that does.
>    Nothing reads it yet.
>
> 6  RFC: tcg: probe the TB jump cache inline instead of calling a helper
>
>    95.8% of those 8.4 billion helper_lookup_tb_ptr() calls hit the jump
>    cache. Emit the probe inline (hash, four guarded loads, goto_ptr) and
>    call the helper only on a miss.                   -34.67%, -25.94% wall

Changes for v6:
  * Split target patches from infrastructure patches.

  * Use tcg-op.c rewrite infrastructure.

  * Add tcg_gen_goto_jc3_*, for the guest to pass all 3 values.

  * Fix bugs in target/

    - alpha: Missed several system-mode points at which
      we cannot use goto_jc (mtpr ps, mtpr fen, halt), and one
      where we cannot use goto_jc, but can use goto_jc3 (call_pal).

    - loongarch: Only use goto_jc for branches.  There are several
      other corner cases lurking in the priviledged insns, and
      they can't be as important as branches.

    - mips: Droped everything.  I expect that this could be made
      to work using goto_jc3, but all of the tb->flags frobbing
      related to delayed branches needs some thought.

    - s390x: Only use jc for branches.  There are several other
      corner cases with SACF and SAM insns.  EX emulation requires
      special treatment: always use goto_jc3 so that we only look
      for TBs with ex_value == 0.

  * Use gen_lea in gen_jc_probe.

  * Add goto_jc opcode.

    - Implement for x86_64.  Code sample before:

	00:  4d 8b 6c 24 18           movq     0x18(%r12), %r13
        05:  4c 3b eb                 cmpq     %rbx, %r13
	08:  0f 85 32 00 00 00        jne      40f
	0c:  49 8b 5c 24 10           movq     0x10(%r12), %rbx
	11:  48 85 db                 testq    %rbx, %rbx
	14:  0f 84 24 00 00 00        je       40f
	1a:  4c 8b 63 10              movq     0x10(%rbx), %r12
	20:  49 81 fc 02 08 00 01     cmpq     $0x1000802, %r12
	27:  0f 85 13 00 00 00        jne      40f
	2d:  4c 8b 63 08              movq     8(%rbx), %r12
	31:  4d 85 e4                 testq    %r12, %r12
	34:  0f 85 06 00 00 00        jne      40f
	3a:  48 8b 5b 18              movq     0x18(%rbx), %rbx
	3c:  ff e3                    jmpq     *%rbx
	40:

      Code sample after:

	00:  49 3b 5c 24 18              cmpq     0x18(%r12), %rbx
	05:  75 22                       jne      29f
	07:  4d 8b 64 24 10              movq     0x10(%r12), %r12
	0c:  4d 85 e4                    testq    %r12, %r12
	0f:  74 18                       je       29f
	11:  49 83 7c 24 08 00           cmpq     $0, 8(%r12)
	17:  75 10                       jne      29f
	19:  49 81 7c 24 10 02 08 00 01  cmpq     $0x1000802, 0x10(%r12)
	22:  75 05                       jne      29f
	24:  41 ff 64 24 18              jmpq     *0x18(%r12)
	29:

    - Implement for aarch64.  Code sample before:

	00:  f9400eb6  ldr      x22, [x21, #0x18]
	04:  eb1402df  cmp      x22, x20
	08:  54000181  b.ne     38f
	0c:  f9400ab4  ldr      x20, [x21, #0x10]
	10:  b4000154  cbz      x20, 38f
	14:  f9400a95  ldr      x21, [x20, #0x10]
	18:  52810056  movz     w22, #0x802
	1c:  72a02016  movk     w22, #0x100, lsl #16
	20:  eb1602bf  cmp      x21, x22
	24:  540000a1  b.ne     38f
	28:  f9400695  ldr      x21, [x20, #8]
	2c:  b5000075  cbnz     x21, 38f
	30:  f9400e94  ldr      x20, [x20, #0x18]
	34:  d61f0280  br       x20
	38:

      Code sample after:

	00:  52810056  movz     w22, #0x802
	04:  72a02016  movk     w22, #0x100, lsl #16
	08:  a94142b5  ldp      x21, x16, [x21, #0x10]
	0c:  f10002bf  cmp      x21, #0
	10:  fa501280  ccmp     x20, x16, #0, ne
	14:  540000e1  b.ne     34f
	18:  a940c6b0  ldp      x16, x17, [x21, #8]
	1c:  f9400eb5  ldr      x21, [x21, #0x18]
	20:  eb1003ff  cmp      xzr, x16
	24:  fa5102c0  ccmp     x22, x17, #0, eq
	2c:  54000041  b.ne     34f
	30:  d61f02a0  br       x21
	34:

    - Implement for s390x.  Code sample before:

	00:  e3b0 c018 0004  lg       %r11, 0x18(%r12)
	06:  ecbd 001c 6064  cgrjlh   %r11, %r13, 0x3e
	0c:  e3d0 c010 0004  lg       %r13, 0x10(%r12)
	12:  ecd8 0016 007c  cgije    %r13, 0, 0x3e
	18:  e3c0 d010 0004  lg       %r12, 0x10(%r13)
	1e:  c0be 0100 0802  llihf    %r11, 0x1000802
	24:  eccb 000d 6064  cgrjlh   %r12, %r11, 0x3e
	2a:  e3c0 d008 0004  lg       %r12, 8(%r13)
	30:  ecc6 0007 007c  cgijlh   %r12, 0, 0x3e
	36:  e3d0 d018 0004  lg       %r13, 0x18(%r13)
	3c:  07fd            br       %r13
	3e:

      Code sample after:

	00:  c0be 0100 0802  llihf    %r11, 0x1000802
	06:  eb12 c010 0004  lmg      %r1, %r2, 0x10(%r12)
	0c:  ec2d 0010 6064  cgrjlh   %r2, %r13, 0x2c
	12:  ec18 000d 007c  cgije    %r1, 0, 0x2c
	18:  eb02 1008 0004  lmg      %r0, %r2, 8(%r1)
	1e:  ec06 0007 007c  cgijlh   %r0, 0, 0x2c
	24:  ec1b 0004 6064  cgrjlh   %r1, %r11, 0x2c
	2a:  07f2            br       %r2
	2c:

Lots of prerequisites.  Full tree at

https://gitlab.com/rth7680/qemu/-/tree/tcg-matt


r~


Matt Turner (5):
  tcg: add tcg_gen_goto_jc{3}_{i32,i64,tl}
  target/loongarch: Use tcg_gen_goto_jc_tl for JIRL
  target/ppc: Use tcg_gen_goto_jc_tl
  accel/tcg: add CF_NO_GOTO_JC, set while a breakpoint is present
  tcg: Probe the TB jump cache inline instead of calling a helper

Richard Henderson (8):
  target/alpha: Use tcg_gen_goto_jc{3}_i64
  target/s390x/tcg: Remove DISAS_PC_UPDATED
  target/s390x/tcg: Use tcg_gen_goto_jc3_i64 for branches
  include/exec: Move tc within TranslationBlock
  tcg: Add INDEX_op_goto_jc
  tcg/x86_64: Implement INDEX_op_goto_jc
  tcg/aarch64: Implement INDEX_op_goto_jc
  tcg/s390x: Implement INDEX_op_goto_jc

 docs/devel/tcg-ops.rst                        |  11 ++
 accel/tcg/tcg-runtime.h                       |   4 +
 include/exec/translation-block.h              |   9 +-
 include/tcg/tcg-op-common.h                   |  29 +++
 include/tcg/tcg-op.h                          |   4 +
 include/tcg/tcg-opc.h                         |   1 +
 tcg/aarch64/tcg-target-con-set.h              |   1 +
 tcg/s390x/tcg-target-con-set.h                |   1 +
 tcg/s390x/tcg-target-con-str.h                |   1 +
 tcg/x86_64/tcg-target-con-set.h               |   1 +
 include/tcg/tcg-op-def.h.inc                  |   2 +
 accel/tcg/cpu-exec-common.c                   |  16 +-
 accel/tcg/cpu-exec.c                          |  27 +++
 cpu-common.c                                  |  25 ++-
 target/alpha/translate.c                      |  60 +++---
 target/loongarch/tcg/translate.c              |   2 +-
 target/ppc/translate.c                        |   4 +-
 target/s390x/tcg/translate.c                  |  32 ++--
 tcg/tcg-op.c                                  | 178 +++++++++++++++++-
 tcg/tcg.c                                     |  23 +++
 .../tcg/insn_trans/trans_branch.c.inc         |   2 +-
 tcg/aarch64/tcg-target.c.inc                  |  60 ++++++
 tcg/loongarch64/tcg-target.c.inc              |   4 +
 tcg/ppc64/tcg-target.c.inc                    |   4 +
 tcg/riscv64/tcg-target.c.inc                  |   4 +
 tcg/s390x/tcg-target.c.inc                    |  42 +++++
 tcg/sparc64/tcg-target.c.inc                  |   4 +
 tcg/tci/tcg-target.c.inc                      |   4 +
 tcg/x86_64/tcg-target.c.inc                   |  65 +++++++
 29 files changed, 561 insertions(+), 59 deletions(-)

-- 
2.53.0


