Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8A9D7831A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6FX-0001k2-16; Mon, 02 Dec 2024 08:14:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6FP-0001jK-QK
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:13:56 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6FM-00035Z-AR
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:13:55 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-434ab938e37so26669725e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145230; x=1733750030; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=trg+V3VWcwq8s0j7XDrYNrEYigU3XoxkcN81p0HkxKU=;
 b=erB9HsgNSGFIF+pjTbdSRZIzFrXVbkjSxmxnE8apvMjww8cKiOMsnUAxNicPRzvhBZ
 TG4cjVwS+NcTEFp4GKbifvwk/zE/4vg47ZinFdaYVn1r63bL4w0y4ClMOXuhv4TdbPnT
 8M0EKximLjx7eNbOLM+y/rUFccMlfrYGHdO1LrqcuLLVdLNYG21YzEwQXjUCJRXrajv+
 v85M0dUZ71GnsOMjkL5zZkrwZLMKTRagnqJD9mmhddgpNxAFfauTXsldMbmKQgSpl5Yv
 OOXBbr1uBcIMoN7cPHjUh9tmja06c3St6i0uBToCDH/WL20/HHa/ZjcBe7Dz9DFP9GN9
 4AlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145230; x=1733750030;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=trg+V3VWcwq8s0j7XDrYNrEYigU3XoxkcN81p0HkxKU=;
 b=SyeeacS/wi6ueSP1ulMmj5ZIsC2R5foBzlbMzIheIOb4VSrJSwMETCCPoChEVNlG8Y
 dDpsJIgsVT5iWUou/Qz1V8+HulxLf4i3/vLVN+guEdxAtQWGa3+Bdj0Ty2xCq01J+o6r
 QKxMjYgL8pKdURbxI5ISrKLphsuUxuogYs2yOn0ihlXsR370jlgRU+jcN8SpOq2Ejnzi
 +hj1ipk/HDgQTBxMW6uZlK5M9/D3gfhmIFXCIN7DN5GO95/ic8FMML665xi8x3wYV0Ss
 jlm+7opqMyyUlEeEniuv5VTsr+kOhMNswJnL/anMlN5dTI+LGq2wUZm/bq+iSH0RwCs3
 xGJg==
X-Gm-Message-State: AOJu0Yz2aHbFVpXImGUIliKm4DldxNCYdNz2VORoy3+YrfbR2uZJSI32
 sXEod5Q1WduzT1OdUmMaHGT0yz2C5ZyNpAcZGATvhp/5fnDABGeYgo1PIwNzcNHTr938WtJqyvu
 d
X-Gm-Gg: ASbGncs6TpIETMOtqBOgd5rsaItnrmM7qSP3nCUtLbeE9zWtgf4AzcCEgeafL888/wX
 Zl1gdPcIU/DfTTK56EsfHUTzugv0Lv1rvGS7pAkWEuSavaRw9EOjFdA182tefcy+/3H3EmKTwes
 7FAc8vAWp0cHGOGAP9w7tKQGCtwkxRqzbVYd2ITwrOQJbIykzTUgMSUGeFfurlyHLyEZH8vDKaD
 g7LatE0mJwqXwqAcjEQ4Ta+A965YjaeaiDDJFt4B7R6dsZ6tx8/uNs=
X-Google-Smtp-Source: AGHT+IEqP7xdq0N/i2H5UWnaEncid9vIzc7y7AmXLhiBnG6Jptxn2sm6stGTHvfu42++SJ7xqME78Q==
X-Received: by 2002:a05:600c:1d20:b0:434:9934:575 with SMTP id
 5b1f17b1804b1-434a9dd035cmr231441105e9.16.1733145229761; 
 Mon, 02 Dec 2024 05:13:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:13:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 for-10.0 00/54] fpu: Remove pickNaNMulAdd,
 default-NaN ifdefs
Date: Mon,  2 Dec 2024 13:12:53 +0000
Message-Id: <20241202131347.498124-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

(Apologies for this patchset being both big and having a wide CC list;
the good news is that this is the last lot of fpu ifdef cleanup that
needs to touch all the targets.)

This patchset does the same thing we already did for pickNaN() to
pickNaNMulAdd() -- it replaces the compile-time ifdef ladder that
selected target-specific NaN propagation behaviour with checking some
runtime selectable settings in the float_status.  The motivation is:
 * this will let us have multiple targets in one QEMU binary
 * the Arm FEAT_AFP architectural feature includes letting
   the guest select a NaN propagation rule at runtime
This is patches 1-26 (which were in the v1 of this series).

It then does a similar thing for making targets select the default
NaN value at runtime rather than relying on a compile-time ifdef.
This is patches 34-54, which are new in v2.

In between those two, patches 27-33 do some minor cleanup:
 * prefer to initialize scratch float_status structs from the target's
   env->fp_status rather than as all-zeroes, so that when we add
   new config fields to float_status we don't need to also remember
   to update half a dozen scratch float_status structs too.
   (Some still remain in target/riscv where plumbing in the env
   pointer through the macro magic seemed more effort than it was worth.)
 * remove an ifdef in floatx80_default_nan() by creating the NaN value
   from parts64_default_nan() in the same way we already do for
   the 128-bit NaN

This is intended to be a no-behaviour-change refactor, except for:
 * the arm linux-user nwfpe handling will change its floatx80
   default NaN value
 * hppa, i386, sh4, tricore now correctly raise Invalid for
   (0 * inf) + NaN

Changes v1->v2:
 * update comments on x86 to include the spec references rather
   than TODO notes to check the spec
 * fixed clash of float_infzeronan_none and float_infzeronan_dnan_never
   values
 * patches 14 and 27-54 are new
 * patch 15 is a rework of the old patch 14 to follow RTH's suggestion
   to make it data driven rather than a big switch statement

(The remaining ifdefs in fpu/ fall into two categories:
 * ones done purely for performance to skip a runtime check,
   which can be removed without any behaviour change, like the
   one in snan_bit_is_one()
 * various ones related to floatx80 behaviour, where currently we
   use ifdefs to select essentially i386 vs m68k handling
I'll probably come back and look at these when this series has
gone upstream.)

thanks
-- PMM

Peter Maydell (54):
  fpu: handle raising Invalid for infzero in pick_nan_muladd
  fpu: Check for default_nan_mode before calling pickNaNMulAdd
  softfloat: Allow runtime choice of inf * 0 + NaN result
  tests/fp: Explicitly set inf-zero-nan rule
  target/arm: Set FloatInfZeroNaNRule explicitly
  target/s390: Set FloatInfZeroNaNRule explicitly
  target/ppc: Set FloatInfZeroNaNRule explicitly
  target/mips: Set FloatInfZeroNaNRule explicitly
  target/sparc: Set FloatInfZeroNaNRule explicitly
  target/xtensa: Set FloatInfZeroNaNRule explicitly
  target/x86: Set FloatInfZeroNaNRule explicitly
  target/loongarch: Set FloatInfZeroNaNRule explicitly
  target/hppa: Set FloatInfZeroNaNRule explicitly
  softfloat: Pass have_snan to pickNaNMulAdd
  softfloat: Allow runtime choice of NaN propagation for muladd
  tests/fp: Explicitly set 3-NaN propagation rule
  target/arm: Set Float3NaNPropRule explicitly
  target/loongarch: Set Float3NaNPropRule explicitly
  target/ppc: Set Float3NaNPropRule explicitly
  target/s390x: Set Float3NaNPropRule explicitly
  target/sparc: Set Float3NaNPropRule explicitly
  target/mips: Set Float3NaNPropRule explicitly
  target/xtensa: Set Float3NaNPropRule explicitly
  target/i386: Set Float3NaNPropRule explicitly
  target/hppa: Set Float3NaNPropRule explicitly
  fpu: Remove use_first_nan field from float_status
  target/m68k: Don't pass NULL float_status to floatx80_default_nan()
  softfloat: Create floatx80 default NaN from parts64_default_nan
  target/loongarch: Use normal float_status in fclass_s and fclass_d
    helpers
  target/m68k: In frem helper, initialize local float_status from
    env->fp_status
  target/m68k: Init local float_status from env fp_status in gdb get/set
    reg
  target/sparc: Initialize local scratch float_status from
    env->fp_status
  target/ppc: Use env->fp_status in helper_compute_fprf functions
  fpu: Allow runtime choice of default NaN value
  tests/fp: Set default NaN pattern explicitly
  target/microblaze: Set default NaN pattern explicitly
  target/i386: Set default NaN pattern explicitly
  target/hppa: Set default NaN pattern explicitly
  target/alpha: Set default NaN pattern explicitly
  target/arm: Set default NaN pattern explicitly
  target/loongarch: Set default NaN pattern explicitly
  target/m68k: Set default NaN pattern explicitly
  target/mips: Set default NaN pattern explicitly
  target/openrisc: Set default NaN pattern explicitly
  target/ppc: Set default NaN pattern explicitly
  target/sh4: Set default NaN pattern explicitly
  target/rx: Set default NaN pattern explicitly
  target/s390x: Set default NaN pattern explicitly
  target/sparc: Set default NaN pattern explicitly
  target/xtensa: Set default NaN pattern explicitly
  target/hexagon: Set default NaN pattern explicitly
  target/riscv: Set default NaN pattern explicitly
  target/tricore: Set default NaN pattern explicitly
  fpu: Remove default handling for dnan_pattern

 include/fpu/softfloat-helpers.h   |  38 +++-
 include/fpu/softfloat-types.h     |  89 +++++++++-
 target/mips/fpu_helper.h          |  20 +++
 target/sparc/helper.h             |   4 +-
 linux-user/arm/nwfpe/fpa11.c      |   5 +
 target/alpha/cpu.c                |   2 +
 target/arm/cpu.c                  |  10 ++
 target/hexagon/cpu.c              |   2 +
 target/hppa/fpu_helper.c          |  12 ++
 target/i386/tcg/fpu_helper.c      |  12 ++
 target/loongarch/tcg/fpu_helper.c |  14 +-
 target/m68k/cpu.c                 |  14 +-
 target/m68k/fpu_helper.c          |   6 +-
 target/m68k/helper.c              |   6 +-
 target/microblaze/cpu.c           |   2 +
 target/mips/msa.c                 |  10 ++
 target/openrisc/cpu.c             |   2 +
 target/ppc/cpu_init.c             |  19 ++
 target/ppc/fpu_helper.c           |   3 +-
 target/riscv/cpu.c                |   2 +
 target/rx/cpu.c                   |   2 +
 target/s390x/cpu.c                |   5 +
 target/sh4/cpu.c                  |   2 +
 target/sparc/cpu.c                |   6 +
 target/sparc/fop_helper.c         |   8 +-
 target/sparc/translate.c          |   4 +-
 target/tricore/helper.c           |   2 +
 target/xtensa/cpu.c               |   4 +
 target/xtensa/fpu_helper.c        |   3 +-
 tests/fp/fp-bench.c               |   7 +
 tests/fp/fp-test-log2.c           |   1 +
 tests/fp/fp-test.c                |   7 +
 fpu/softfloat-parts.c.inc         |  22 ++-
 fpu/softfloat-specialize.c.inc    | 278 ++++++------------------------
 34 files changed, 357 insertions(+), 266 deletions(-)

-- 
2.34.1


