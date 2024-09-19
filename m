Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C67CDD578
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGwG-0004UU-O9; Thu, 19 Sep 2024 09:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwD-0004SY-M3
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:14 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwA-0000zf-8I
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:13 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42cbbb1727eso6873695e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751468; x=1727356268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=r6qZbo86lth5ph2IZAKT1oQepksceXIwdiF3RrFlxPk=;
 b=SRuAVKvDdcMgvTtqHShSpfRDRDGVi/VQLJW3+B7n1Gb5BG+OpP5g1BHIbjoh9NWoXK
 jAqPWJEv/OxZgv4C7a21uDDB+wRuEbZY0GFMOVbTmkzyeSDOgLtgTC7cCP4QpA4OO0mY
 vvkN54eUxTbP9XMPK/aOA19rH8IsUzdqJVC8dAy5pVJQVWOcDGAgPfFmdkXI7YgCKddJ
 IoFn45mJsUKkeOyvNNJJ/3JNopAapJ6wPUCGeSN8R3KPth6HC5hHAUkcKgyVWwzW9OVt
 fNC8yXTr/vKWeyqCRMN17wGQOUBSRenAjYw1Z7YofWLlznzO6nNXVAYNOM8F1P5qVYoO
 6eFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751468; x=1727356268;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r6qZbo86lth5ph2IZAKT1oQepksceXIwdiF3RrFlxPk=;
 b=eMR0bQnTPm4aMmPQfyudWvgtnZW7jD/MH+ADDg8gJpGX857SbNB6v5uvtKgJiYg/6f
 sJ7//ETBpWFa7DLckoygeiyhHNSqmQ2j6jAp1P3pgPu0oLhV86Bmoe/FZsDA73X2gbuv
 +CI4SzzPHEcmY2K/ZzV0/KBvWiSPlupw+MPUQTxkaLDY4nM3abZdjrE/o+5K9Y59UQAJ
 rN3sdWfz6j8KbbRvXWwjqnIrRa9575eqMWGG9V/j3f96swko3ahA0t0/VDclreG04XY/
 MqA+8EGPgGh8MxaYqgtu8v01dBIiK+70x3W/9KKH9rKVlDVlIkIr4qlciFwxWD+jCBsR
 GzHA==
X-Gm-Message-State: AOJu0YyhjfS3VbNwrs+fffCLsn+Lx0I55f8EgoN7zkumlENTr+SWd8tG
 7DWY5KpSkcrNU/58hmP7MhKuJOxuVAlGnr9xpFLj6MjgiJw2jHqQv9/zu+SqMiZAVLReNb7YPlJ
 v
X-Google-Smtp-Source: AGHT+IGd/gA2UT2gAh3x8CxUtTMlm2fWBJsL6nIjQovQULI+LTm+JYJp0PpZ/xXSJGLqz7AbMVbxFQ==
X-Received: by 2002:a5d:428f:0:b0:374:bce8:16bc with SMTP id
 ffacd0b85a97d-378c2d5b135mr12718009f8f.48.1726751467719; 
 Thu, 19 Sep 2024 06:11:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/38] target-arm queue
Date: Thu, 19 Sep 2024 14:10:28 +0100
Message-Id: <20240919131106.3362543-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

The following changes since commit 14556211bc6d7125a44d5b5df90caba019b0ec0e:

  Merge tag 'qemu-macppc-20240918' of https://github.com/mcayland/qemu into staging (2024-09-18 20:59:10 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240919

for you to fetch changes up to 89b30b4921e51bb47313d2d8fdc3d7bce987e4c5:

  docs/devel: Remove nested-papr.txt (2024-09-19 13:33:15 +0100)

----------------------------------------------------------------
target-arm queue:
 * target/arm: Correct ID_AA64ISAR1_EL1 value for neoverse-v1
 * target/arm: More conversions to decodetree of A64 SIMD insns
 * hw/char/stm32l4x5_usart.c: Enable USART ACK bit response
 * tests: update aarch64/sbsa-ref tests
 * kvm: minor Coverity nit fixes
 * docs/devel: Remove nested-papr.txt

----------------------------------------------------------------
Jacob Abrams (1):
      hw/char/stm32l4x5_usart.c: Enable USART ACK bit response

Marcin Juszkiewicz (4):
      tests: use default cpu for aarch64/sbsa-ref
      tests: add FreeBSD tests for aarch64/sbsa-ref
      tests: expand timeout information for aarch64/sbsa-ref
      tests: drop OpenBSD tests for aarch64/sbsa-ref

Peter Maydell (4):
      kvm: Make 'mmap_size' be 'int' in kvm_init_vcpu(), do_kvm_destroy_vcpu()
      kvm: Remove unreachable code in kvm_dirty_ring_reaper_thread()
      target/arm: Correct ID_AA64ISAR1_EL1 value for neoverse-v1
      docs/devel: Remove nested-papr.txt

Richard Henderson (29):
      target/arm: Replace tcg_gen_dupi_vec with constants in gengvec.c
      target/arm: Replace tcg_gen_dupi_vec with constants in translate-sve.c
      target/arm: Use cmpsel in gen_ushl_vec
      target/arm: Use cmpsel in gen_sshl_vec
      target/arm: Use tcg_gen_extract2_i64 for EXT
      target/arm: Convert EXT to decodetree
      target/arm: Convert TBL, TBX to decodetree
      target/arm: Convert UZP, TRN, ZIP to decodetree
      target/arm: Simplify do_reduction_op
      target/arm: Convert ADDV, *ADDLV, *MAXV, *MINV to decodetree
      target/arm: Convert FMAXNMV, FMINNMV, FMAXV, FMINV to decodetree
      target/arm: Convert FMOVI (scalar, immediate) to decodetree
      target/arm: Convert MOVI, FMOV, ORR, BIC (vector immediate) to decodetree
      target/arm: Introduce gen_gvec_sshr, gen_gvec_ushr
      target/arm: Fix whitespace near gen_srshr64_i64
      target/arm: Convert handle_vec_simd_shri to decodetree
      target/arm: Convert handle_vec_simd_shli to decodetree
      target/arm: Use {, s}extract in handle_vec_simd_wshli
      target/arm: Convert SSHLL, USHLL to decodetree
      target/arm: Push tcg_rnd into handle_shri_with_rndacc
      target/arm: Split out subroutines of handle_shri_with_rndacc
      target/arm: Convert SHRN, RSHRN to decodetree
      target/arm: Convert handle_scalar_simd_shri to decodetree
      target/arm: Convert handle_scalar_simd_shli to decodetree
      target/arm: Convert VQSHL, VQSHLU to gvec
      target/arm: Widen NeonGenNarrowEnvFn return to 64 bits
      target/arm: Convert SQSHL, UQSHL, SQSHLU (immediate) to decodetree
      target/arm: Convert vector [US]QSHRN, [US]QRSHRN, SQSHRUN to decodetree
      target/arm: Convert scalar [US]QSHRN, [US]QRSHRN, SQSHRUN to decodetree

 docs/devel/nested-papr.txt               |  119 --
 target/arm/helper.h                      |   34 +-
 target/arm/tcg/translate.h               |   14 +-
 target/arm/tcg/a64.decode                |  257 ++++
 target/arm/tcg/neon-dp.decode            |    6 +-
 accel/kvm/kvm-all.c                      |   10 +-
 hw/char/stm32l4x5_usart.c                |   16 +
 target/arm/tcg/cpu64.c                   |    2 +-
 target/arm/tcg/gengvec.c                 |  121 +-
 target/arm/tcg/neon_helper.c             |   76 +-
 target/arm/tcg/translate-a64.c           | 2081 +++++++++++++-----------------
 target/arm/tcg/translate-neon.c          |  179 +--
 target/arm/tcg/translate-sve.c           |  128 +-
 tests/qtest/stm32l4x5_usart-test.c       |   36 +-
 tests/functional/test_aarch64_sbsaref.py |   58 +-
 15 files changed, 1479 insertions(+), 1658 deletions(-)
 delete mode 100644 docs/devel/nested-papr.txt

