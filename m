Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0226E7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQB9s-0002kg-PE; Tue, 24 Dec 2024 15:05:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9i-0002jM-TE
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:27 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9g-0002UZ-SG
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:26 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21675fd60feso73522345ad.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070723; x=1735675523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=2jxIuXphk2p1Sj9EERk4+AzkFM+txRkx+yf5xQplj+4=;
 b=k41fhPK2hg70pFb3WhU4n/huqZCTZ4HCV711wOsOfhKr/I0/Vyc3k/zWxQQNvyTmTu
 p1xChcWUcYokgHMqsmXmVcYbofbUtJOCd5VERsSpi9tkuZrj9eHxfnkUqRCJ87iJNHJR
 upcBIhIfOQKvkjfmbwnoxmLJ275BF1sweiCKdWZkG5sydeFYpdtbllRk8AQfVR738B8f
 hPhOAEQAVzQUtaVSI2VLzytRTBID9o10QXUtVY7iOE+i3wiuSYWjHGMaGqWoEpZE6ybM
 G/KyKDv2KeLhJAFX8nCT9DvuQ0gzB6i+JyA7W942xSoXpRikRtvhaovtc6b8dRojNUl6
 dlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070723; x=1735675523;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2jxIuXphk2p1Sj9EERk4+AzkFM+txRkx+yf5xQplj+4=;
 b=gyJSnMDAr2CxYJQjjNW12vBJaJCATlyqQfMK0K5t1Itxe5orFzYW4yaI++asA7s75/
 RsIuoZmbHZTUvLMqwkcUJHCayQwokMCOo6dG6b/Im4a8PgNviqX8qkNST6VU7SZpB6xo
 0hy7cD6TTwzibo3sJkYLpEakY6NiMSAjnQS5924+L2Dp6EKw2kHUzT10tJ5Kv1Jp9qhJ
 Scf5TbvKqKyUJZpnFVEFHa2M/HY4IeHBujuHwP7rCmsZ0cQ4LDTBz/VuHDQ9KOWCAVfi
 O5Bq2c1idTW+LRuaoSiJdymn1wQeEFmEmdqWiKnW2RU15Oqrk8uwMIZCgIJ2+cidejNM
 tPRQ==
X-Gm-Message-State: AOJu0Yykc9Ix57eLjImuDaz/47zNENAdOfaRD5yKaJ3/gvtfoabh/4XD
 LjS5DyZaCRsJib6W1SXIHxfSxwL36DMlIlKH8CUg5AECs/WQIEeERhlYn5aae0Fk/paW3kBTQhM
 oxZw=
X-Gm-Gg: ASbGncs+la6l3gunO9Pl1QEDQRQjjYRNERZ1nVAIdHNOw2zwzq0S5NrBNmyCQG3Z97g
 m464PJQhcTIEqWrooeI9VGcCRYJWACP5F3fwnmGukl1phrosSN9cbELXm1VR+t/qbiDp4qtDobx
 gyxGsUhRj8BKNKr14dRdwWX8xxn81a4BzOOkwQYp7CFgw8CiFuM3xzTulMuQdf2dE/UuP63rSFW
 uQx0mwkIp7igB8+ThUHz9BebbyLvkquK2IhNu/zmoTGUhvqKPIe3QvRzu0tMyOjikoSkeShjTCm
 5kHj0jzmyuoHuhNREtQZ9CPrtA==
X-Google-Smtp-Source: AGHT+IEXRR/sJwuzGpFFIHrMezuIbkKNhzVKO/0QEu7JKmadhik9wlYgzvTvIGAyTih+WSG+3fJKEA==
X-Received: by 2002:a05:6a21:7899:b0:1e1:bf3d:a18a with SMTP id
 adf61e73a8af0-1e5e0801d78mr30940171637.32.1735070722712; 
 Tue, 24 Dec 2024 12:05:22 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/72] tcg patch queue
Date: Tue, 24 Dec 2024 12:04:09 -0800
Message-ID: <20241224200521.310066-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit aa3a285b5bc56a4208b3b57d4a55291e9c260107:

  Merge tag 'mem-2024-12-21' of https://github.com/davidhildenbrand/qemu into staging (2024-12-22 14:33:27 -0500)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20241224

for you to fetch changes up to e4a8e093dc74be049f4829831dce76e5edab0003:

  accel/tcg: Move gen_intermediate_code to TCGCPUOps.translate_core (2024-12-24 08:32:15 -0800)

----------------------------------------------------------------
tcg/optimize: Remove in-flight mask data from OptContext
fpu: Add float*_muladd_scalbn
fpu: Remove float_muladd_halve_result
fpu: Add float_round_nearest_even_max
fpu: Add float_muladd_suppress_add_product_zero
target/hexagon: Use float32_muladd
accel/tcg: Move gen_intermediate_code to TCGCPUOps.translate_core

----------------------------------------------------------------
Ilya Leoshkevich (1):
      tests/tcg: Do not use inttypes.h in multiarch/system/memory.c

Pierrick Bouvier (1):
      plugins: optimize cpu_index code generation

Richard Henderson (70):
      tcg/optimize: Split out finish_bb, finish_ebb
      tcg/optimize: Split out fold_affected_mask
      tcg/optimize: Copy mask writeback to fold_masks
      tcg/optimize: Split out fold_masks_zs
      tcg/optimize: Augment s_mask from z_mask in fold_masks_zs
      tcg/optimize: Change representation of s_mask
      tcg/optimize: Use finish_folding in fold_add, fold_add_vec, fold_addsub2
      tcg/optimize: Introduce const value accessors for TempOptInfo
      tcg/optimize: Use fold_masks_zs in fold_and
      tcg/optimize: Use fold_masks_zs in fold_andc
      tcg/optimize: Use fold_masks_zs in fold_bswap
      tcg/optimize: Use fold_masks_zs in fold_count_zeros
      tcg/optimize: Use fold_masks_z in fold_ctpop
      tcg/optimize: Use fold_and and fold_masks_z in fold_deposit
      tcg/optimize: Compute sign mask in fold_deposit
      tcg/optimize: Use finish_folding in fold_divide
      tcg/optimize: Use finish_folding in fold_dup, fold_dup2
      tcg/optimize: Use fold_masks_s in fold_eqv
      tcg/optimize: Use fold_masks_z in fold_extract
      tcg/optimize: Use finish_folding in fold_extract2
      tcg/optimize: Use fold_masks_zs in fold_exts
      tcg/optimize: Use fold_masks_z in fold_extu
      tcg/optimize: Use fold_masks_zs in fold_movcond
      tcg/optimize: Use finish_folding in fold_mul*
      tcg/optimize: Use fold_masks_s in fold_nand
      tcg/optimize: Use fold_masks_z in fold_neg_no_const
      tcg/optimize: Use fold_masks_s in fold_nor
      tcg/optimize: Use fold_masks_s in fold_not
      tcg/optimize: Use fold_masks_zs in fold_or
      tcg/optimize: Use fold_masks_zs in fold_orc
      tcg/optimize: Use fold_masks_zs in fold_qemu_ld
      tcg/optimize: Return true from fold_qemu_st, fold_tcg_st
      tcg/optimize: Use finish_folding in fold_remainder
      tcg/optimize: Distinguish simplification in fold_setcond_zmask
      tcg/optimize: Use fold_masks_z in fold_setcond
      tcg/optimize: Use fold_masks_s in fold_negsetcond
      tcg/optimize: Use fold_masks_z in fold_setcond2
      tcg/optimize: Use finish_folding in fold_cmp_vec
      tcg/optimize: Use finish_folding in fold_cmpsel_vec
      tcg/optimize: Use fold_masks_zs in fold_sextract
      tcg/optimize: Use fold_masks_zs, fold_masks_s in fold_shift
      tcg/optimize: Simplify sign bit test in fold_shift
      tcg/optimize: Use finish_folding in fold_sub, fold_sub_vec
      tcg/optimize: Use fold_masks_zs in fold_tcg_ld
      tcg/optimize: Use finish_folding in fold_tcg_ld_memcopy
      tcg/optimize: Use fold_masks_zs in fold_xor
      tcg/optimize: Use finish_folding in fold_bitsel_vec
      tcg/optimize: Use finish_folding as default in tcg_optimize
      tcg/optimize: Remove z_mask, s_mask from OptContext
      tcg/optimize: Re-enable sign-mask optimizations
      tcg/optimize: Move fold_bitsel_vec into alphabetic sort
      tcg/optimize: Move fold_cmp_vec, fold_cmpsel_vec into alphabetic sort
      softfloat: Add float{16,32,64}_muladd_scalbn
      target/arm: Use float*_muladd_scalbn
      target/sparc: Use float*_muladd_scalbn
      softfloat: Remove float_muladd_halve_result
      softfloat: Add float_round_nearest_even_max
      softfloat: Add float_muladd_suppress_add_product_zero
      target/hexagon: Use float32_mul in helper_sfmpy
      target/hexagon: Use float32_muladd for helper_sffma
      target/hexagon: Use float32_muladd for helper_sffms
      target/hexagon: Use float32_muladd_scalbn for helper_sffma_sc
      target/hexagon: Use float32_muladd for helper_sffm[as]_lib
      target/hexagon: Remove internal_fmafx
      target/hexagon: Expand GEN_XF_ROUND
      target/hexagon: Remove Float
      target/hexagon: Remove Double
      target/hexagon: Use mulu64 for int128_mul_6464
      target/hexagon: Simplify internal_mpyhh setup
      accel/tcg: Move gen_intermediate_code to TCGCPUOps.translate_core

 include/exec/translator.h           |  14 -
 include/fpu/softfloat-types.h       |   2 +
 include/fpu/softfloat.h             |  14 +-
 include/hw/core/tcg-cpu-ops.h       |  13 +
 target/alpha/cpu.h                  |   2 +
 target/arm/internals.h              |   2 +
 target/avr/cpu.h                    |   2 +
 target/hexagon/cpu.h                |   2 +
 target/hexagon/fma_emu.h            |   3 -
 target/hppa/cpu.h                   |   2 +
 target/i386/tcg/helper-tcg.h        |   2 +
 target/loongarch/internals.h        |   2 +
 target/m68k/cpu.h                   |   2 +
 target/microblaze/cpu.h             |   2 +
 target/mips/tcg/tcg-internal.h      |   2 +
 target/openrisc/cpu.h               |   2 +
 target/ppc/cpu.h                    |   2 +
 target/riscv/cpu.h                  |   3 +
 target/rx/cpu.h                     |   2 +
 target/s390x/s390x-internal.h       |   2 +
 target/sh4/cpu.h                    |   2 +
 target/sparc/cpu.h                  |   2 +
 target/sparc/helper.h               |   4 +-
 target/tricore/cpu.h                |   2 +
 target/xtensa/cpu.h                 |   2 +
 accel/tcg/cpu-exec.c                |   8 +-
 accel/tcg/plugin-gen.c              |   9 +
 accel/tcg/translate-all.c           |   8 +-
 fpu/softfloat.c                     |  63 +--
 target/alpha/cpu.c                  |   1 +
 target/alpha/translate.c            |   4 +-
 target/arm/cpu.c                    |   1 +
 target/arm/tcg/cpu-v7m.c            |   1 +
 target/arm/tcg/helper-a64.c         |   6 +-
 target/arm/tcg/translate.c          |   5 +-
 target/avr/cpu.c                    |   1 +
 target/avr/translate.c              |   6 +-
 target/hexagon/cpu.c                |   1 +
 target/hexagon/fma_emu.c            | 496 ++++++---------------
 target/hexagon/op_helper.c          | 125 ++----
 target/hexagon/translate.c          |   4 +-
 target/hppa/cpu.c                   |   1 +
 target/hppa/translate.c             |   4 +-
 target/i386/tcg/tcg-cpu.c           |   1 +
 target/i386/tcg/translate.c         |   5 +-
 target/loongarch/cpu.c              |   1 +
 target/loongarch/tcg/translate.c    |   4 +-
 target/m68k/cpu.c                   |   1 +
 target/m68k/translate.c             |   4 +-
 target/microblaze/cpu.c             |   1 +
 target/microblaze/translate.c       |   4 +-
 target/mips/cpu.c                   |   1 +
 target/mips/tcg/translate.c         |   4 +-
 target/openrisc/cpu.c               |   1 +
 target/openrisc/translate.c         |   4 +-
 target/ppc/cpu_init.c               |   1 +
 target/ppc/translate.c              |   4 +-
 target/riscv/tcg/tcg-cpu.c          |   1 +
 target/riscv/translate.c            |   4 +-
 target/rx/cpu.c                     |   1 +
 target/rx/translate.c               |   4 +-
 target/s390x/cpu.c                  |   1 +
 target/s390x/tcg/translate.c        |   4 +-
 target/sh4/cpu.c                    |   1 +
 target/sh4/translate.c              |   4 +-
 target/sparc/cpu.c                  |   1 +
 target/sparc/fop_helper.c           |   8 +-
 target/sparc/translate.c            |  84 ++--
 target/tricore/cpu.c                |   1 +
 target/tricore/translate.c          |   5 +-
 target/xtensa/cpu.c                 |   1 +
 target/xtensa/translate.c           |   4 +-
 tcg/optimize.c                      | 857 +++++++++++++++++++-----------------
 tests/tcg/multiarch/system/memory.c |   9 +-
 fpu/softfloat-parts.c.inc           |  16 +-
 75 files changed, 866 insertions(+), 1009 deletions(-)

