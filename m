Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F06CD5BC0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 13:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smC73-0001Qj-JO; Thu, 05 Sep 2024 09:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6s-0000xd-FN
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:15 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6n-0001ig-9S
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:12 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42c828c8863so6187165e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 06:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725541264; x=1726146064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=KEdEspmLetW5RV32ZQxz6P9sm+8S2xOtbLJmONA0ZAs=;
 b=rGzydF5xsPhcnrHFE4J+hUW8otTuHBDqg0k5Zb5av1l2Hklihp8yrCF9psDIW4gTDd
 wBilFIgM6tmOSAH+tAXPxxT9evJkHySwM4lezP9DOD8Qkl+VY1PJbCn6fmCmXY78nOci
 HHwxQOtnuMY1kdwaMhip2sNzXc5t/LN77yli2hpTr8Ee7d+PqFoOFqSovuedjzoiM5zu
 69WoI8llCXGly3ty3wOIHyyLI7bMgHM1zyV4F43vh+YGwAhwYOeD8LRZ6JueQ5FRWYYb
 PlT5GJ4VLzDDi9oZ4bNv82/HGXGrN2A93g5hmkC2q6sH4Jw9KSLVsyLt1LRSvmeB1D9b
 dyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725541264; x=1726146064;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KEdEspmLetW5RV32ZQxz6P9sm+8S2xOtbLJmONA0ZAs=;
 b=NtG/gnSX1GTQ1j5O09T5FQQdC7GYaVWaRCBx1TUuwtYuYPkB9KQCeu4X/CoEpOp/Yv
 oh4nCsfxqKHVCD64YPhXUGOIHs7LL3v6PtEjTo72LumqPryqHV0nGMzzUvnqfX5yPQVq
 1/KzeAe8vWQrQYhawFQxJZpo9WGnVzklrx+H90SBH1/CLfxSx4C1kbYVZt5Vj8Q8M1Bq
 C29Fg1HwRVrEnbtbN2IXEKStLDhT39LDeILxAkIXXHq89ZbJKZECqyJVvZWHeeZSkZEX
 02rZ4ZQ6IbsqpQgV9gVSUZR0tZF+Wc7sWiDwMw9UFTZ5mnrpZhm7+4H6CXzP/OU5nYW9
 70qg==
X-Gm-Message-State: AOJu0YwFeI9a202tCO9ATn5ByO7Y4H+HZy694vtDRcR2zpWstztunHsP
 EKNeqoOlD8dkLsiEVWy7ZYTH9vX/sDkBsVYi/4AGEt/jORoqqQPGiF4s5O72HgrqDYDaVHp2FTy
 J
X-Google-Smtp-Source: AGHT+IH5/4LM2Q3cB35I1qx4CFIOI2lf6qhLq2bptW2nOUVuQU72drb0jw9V0U3N+auaKNfTOn0MUw==
X-Received: by 2002:a05:600c:34c6:b0:426:6921:e3e5 with SMTP id
 5b1f17b1804b1-42bdc64e47fmr124495535e9.24.1725541263414; 
 Thu, 05 Sep 2024 06:01:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e355dfsm232251365e9.46.2024.09.05.06.01.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 06:01:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/25] target-arm queue
Date: Thu,  5 Sep 2024 14:00:35 +0100
Message-Id: <20240905130100.298768-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

First target-arm queue for 9.2. I know I have more stuff in
my to-review queue after this...

-- PMM

The following changes since commit cab1afb393ea0943b3086188e91d71d594ede6bf:

  Merge tag 'hppa-v9.1-fixes-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2024-09-04 13:20:17 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240905

for you to fetch changes up to 99ec7b440a1d6a6ef07450b68687d24d13a25fb5:

  platform-bus: fix refcount leak (2024-09-05 13:12:37 +0100)

----------------------------------------------------------------
target-arm queue:
 * Implement FEAT_EBF16 emulation
 * accel/tcg: Remove dead code from rr_cpu_thread_fn()
 * hw: add compat machines for 9.2
 * virt: default to two-stage SMMU from virt-9.2
 * sbsa-ref: use two-stage SMMU
 * hw: Various minor memory leak fixes
 * target/arm: Correct names of VFP VFNMA and VFNMS insns
 * hw/arm/xilinx_zynq: Enable Security Extensions
 * hw/arm/boot: Report error msg if loading elf/dtb failed

----------------------------------------------------------------
Changbin Du (1):
      hw/arm/boot: Report error msg if loading elf/dtb failed

Cornelia Huck (1):
      hw: add compat machines for 9.2

Gao Shiyuan (1):
      platform-bus: fix refcount leak

Peter Maydell (20):
      target/arm: Allow setting the FPCR.EBF bit for FEAT_EBF16
      target/arm: Pass env pointer through to sme_bfmopa helper
      target/arm: Pass env pointer through to gvec_bfdot helper
      target/arm: Pass env pointer through to gvec_bfdot_idx helper
      target/arm: Pass env pointer through to gvec_bfmmla helper
      target/arm: Prepare bfdotadd() callers for FEAT_EBF support
      target/arm: Implement FPCR.EBF=1 semantics for bfdotadd()
      target/arm: Enable FEAT_EBF16 in the "max" CPU
      accel/tcg: Remove dead code from rr_cpu_thread_fn()
      hw/arm/smmuv3: Update comment documenting "stage" property
      hw/arm/virt: Default to two-stage SMMU from virt-9.2
      hw/arm/sbsa-ref: Use two-stage SMMU
      hw/misc/xlnx-versal-cfu: destroy fifo in finalize
      hw/misc/xlnx-versal-trng: Free s->prng in finalize, not unrealize
      hw/nvram/xlnx-bbram: Call register_finalize_block
      hw/nvram/xlnx-zynqmp-efuse: Call register_finalize_block
      hw/misc/xlnx-versal-trng: Call register_finalize_block
      hm/nvram/xlnx-versal-efuse-ctrl: Call register_finalize_block
      hw/arm/sbsa-ref: Don't leak string in sbsa_fdt_add_gic_node()
      target/arm: Correct names of VFP VFNMA and VFNMS insns

Philippe Mathieu-Daudé (1):
      hw/arm/boot: Explain why load_elf_hdr() error is ignored

Sebastian Huber (1):
      hw/arm/xilinx_zynq: Enable Security Extensions

 docs/system/arm/emulation.rst        |   1 +
 include/hw/arm/virt.h                |   1 +
 include/hw/boards.h                  |   3 +
 include/hw/i386/pc.h                 |   3 +
 include/hw/misc/xlnx-versal-trng.h   |   1 +
 include/hw/nvram/xlnx-bbram.h        |   1 +
 include/hw/nvram/xlnx-versal-efuse.h |   1 +
 include/hw/nvram/xlnx-zynqmp-efuse.h |   1 +
 target/arm/cpu-features.h            |   5 +
 target/arm/cpu.h                     |   1 +
 target/arm/helper.h                  |  12 +--
 target/arm/tcg/helper-sme.h          |   4 +-
 target/arm/tcg/vec_internal.h        |  37 ++++++-
 target/arm/tcg/vfp.decode            |  12 +--
 accel/tcg/tcg-accel-ops-rr.c         |   4 +-
 hw/arm/boot.c                        |  10 +-
 hw/arm/sbsa-ref.c                    |  16 ++-
 hw/arm/smmuv3.c                      |   1 +
 hw/arm/virt.c                        |  19 +++-
 hw/arm/xilinx_zynq.c                 |   8 --
 hw/core/machine.c                    |   3 +
 hw/core/platform-bus.c               |   5 +-
 hw/i386/pc.c                         |   3 +
 hw/i386/pc_piix.c                    |  15 ++-
 hw/i386/pc_q35.c                     |  13 ++-
 hw/m68k/virt.c                       |  11 +-
 hw/misc/xlnx-versal-cfu.c            |   8 ++
 hw/misc/xlnx-versal-trng.c           |  12 +--
 hw/nvram/xlnx-bbram.c                |  13 ++-
 hw/nvram/xlnx-versal-efuse-ctrl.c    |   6 +-
 hw/nvram/xlnx-zynqmp-efuse.c         |  13 ++-
 hw/ppc/spapr.c                       |  17 ++-
 hw/s390x/s390-virtio-ccw.c           |  14 ++-
 target/arm/tcg/cpu64.c               |   4 +-
 target/arm/tcg/sme_helper.c          |  78 +++++++++-----
 target/arm/tcg/translate-a64.c       |  40 ++++++-
 target/arm/tcg/translate-neon.c      |  43 ++++++--
 target/arm/tcg/translate-sme.c       |   3 +-
 target/arm/tcg/translate-sve.c       |  25 ++++-
 target/arm/tcg/translate-vfp.c       |   8 +-
 target/arm/tcg/vec_helper.c          | 200 ++++++++++++++++++++++++++++-------
 target/arm/vfp_helper.c              |   8 +-
 42 files changed, 529 insertions(+), 154 deletions(-)

