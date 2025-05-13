Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB9EC3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 17:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEtg0-0003c6-8V; Tue, 13 May 2025 13:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtbM-00082k-Ow
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:39:37 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtbK-00036v-1l
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:39:36 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so43055965e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 10:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747157970; x=1747762770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YAlhkkHQNtCeNGg6GfhmpRyuZYVVpeda25JByShss/U=;
 b=QKaxxoM1SFYcJ3yCuOeIxP0f77U6FugpRCqbwP4L7m0tE9wJ780EZRCUM1DOhMnyuk
 q7+wZtdioGoSp0yhQWYzCreeGDYSPf26XnxwgDj0BXsZUOYaDFaEnLSm2PoyYhJtK8cd
 d1/C5PQKX3kX9umMvWQh8sAn5zzj0bFZEn3btwFnwTz5KkNmzzzTaMxYQLUgGtEk1Yrg
 6TzaqOnbnrJ5Tv5+5nRDxh5DcZfEMu1q4Y3/31bxBcohzzC/dfMQ/6O//NQn+9TE24/h
 i/pN8FIf9Vy+FY3Ry0Ljtn5ZYZckyks6TR6TNx1TVHHeglJYL8fIeQq4c34O1v5K1jqH
 rJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747157970; x=1747762770;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YAlhkkHQNtCeNGg6GfhmpRyuZYVVpeda25JByShss/U=;
 b=Ersqf76Sjf3McDYXMp2Eb1pBPsP1sAQOD4LRzH8kWMic2qR7odoOnnuwliOBEuxX+E
 EQIK+a2RyBSWN5dRwX6yPU9vrOX5ET7w7eZ+IkrquJjOTLlS3NAzfEJV9VwCIuCupNxm
 xLLnVgCXG154aQewV7YZNxt071Ye1cN4tKtmJnrFncE9GcK/vZxeRBIw9U+H7zdTNe/S
 aW6cM2AUSTKGMww44qcyjLx1WutChud/tW298M9SH6bc/S12XG/euQqSsKmKvsZPyCWb
 dNjoYVs+XqzW8n4EbL3/xy+VNnpuKyo+3UCfH+GEVShLJKOjfhzXUQe/QA5FGy0Hgg3P
 r9PA==
X-Gm-Message-State: AOJu0YyY4ELouldmNoED6j+mE4BDBb+me7QuPtHn1qbwI/6VrIEerNga
 2XZaDIZ0/1C69BzMoZis/zHmrlZXW/53jSZI0G/A3rKPRGgY0b9L1ETXg9y0ril3VfYE1i/Knvs
 pxN0=
X-Gm-Gg: ASbGncvtFTZYL2b3MJGxId+MYChOqzk1HNbUJcv1Kj4oDY0IiXUqU38FukK0kzHWfvt
 5dMEM08cxsnO5Cbln5w51IyjXT9/OtSv3B+I9lGASQlASidJTrNjqPDQNgpJvaIcXWn2oNZMPDU
 D6jueEldddrbWBQckqIZAkCGbgdkRfDxaonoOVZwgSjQURYBH50p4g4C4k09tIRq3VVbS58HwyJ
 6LYHh26cqL9qJhNYcyRf5vDLbaJP9biwWqJtwD3+xZW2GpRnQPp4vChc865uFagytPJ4I6UZRV+
 9yLGtTwcwms9fZHlpv+34F5RvvkJARmUUkBrX5/ml2QF+uIsTdyrDhds38CNmHAslu++M3xO5E2
 +ENJ4N49FtH5hSNrq5F9gO8EBr1Zr
X-Google-Smtp-Source: AGHT+IGUJrsFtOhbxggBaV9B4u7LWtXsSgYyL+73sabyU/zUKtSl/+6m2dXvPk5U32KPuSTO7V5/uA==
X-Received: by 2002:a05:600c:524c:b0:43b:c95f:fd9 with SMTP id
 5b1f17b1804b1-442f20baa38mr1870945e9.5.1747157970443; 
 Tue, 13 May 2025 10:39:30 -0700 (PDT)
Received: from localhost.localdomain (110.8.30.213.rev.vodafone.pt.
 [213.30.8.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d67d5c09sm178235065e9.7.2025.05.13.10.39.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 May 2025 10:39:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/19] target/arm: More header rework around arm_feature() &
 multiprocessing.h
Date: Tue, 13 May 2025 18:39:09 +0100
Message-ID: <20250513173928.77376-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Before I respin my "single-binary: Make hw/arm/ common" [1] I'm
extracting these random cleanup patches. Some aren't necessary
anymore because now units in arm_common_ss[] can access "cpu.h",
but the patches are reviewed and simplify a bit IMO.

Based-on: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
          "single-binary: compile target/arm twice"

[1] https://lore.kernel.org/qemu-devel/20250403235821.9909-1-philmd@linaro.org/

Philippe Mathieu-Daudé (19):
  target/arm/tcg-stubs: compile file once (system)
  target/arm/hvf_arm: Avoid using poisoned CONFIG_HVF definition
  target/arm: Only link with zlib when TCG is enabled
  target/arm/cpregs: Include missing 'target/arm/cpu.h' header
  hw/arm/boot: Include missing 'system/memory.h' header
  target/arm/cpu-features: Include missing 'cpu.h' header
  target/arm/qmp: Include missing 'cpu.h' header
  target/arm/kvm: Include missing 'cpu-qom.h' header
  target/arm/hvf: Include missing 'cpu-qom.h' header
  hw/arm: Remove unnecessary 'cpu.h' header
  target/arm: Restrict inclusion of 'multiprocessing.h'
  target/arm: Move some definitions from 'cpu.h' to 'multiprocessing.h'
  hw/arm: Include missing 'target/arm/gtimer.h' header
  target/arm: Extract PSCI definitions to 'psci.h'
  target/arm: Extract feature definitions to 'cpu_has_feature.h' header
  target/arm: Add arm_cpu_has_feature() helper
  hw/arm/realview: Replace arm_feature() -> arm_cpu_has_feature()
  hw/arm/virt-acpi: Replace arm_feature() -> arm_cpu_has_feature()
  target/arm: Always include full path to 'cpu.h'

 MAINTAINERS                    |  1 +
 include/hw/arm/boot.h          |  3 +-
 target/arm/cpregs.h            |  1 +
 target/arm/cpu-features.h      |  1 +
 target/arm/cpu.h               | 79 ++--------------------------------
 target/arm/cpu_has_feature.h   | 67 ++++++++++++++++++++++++++++
 target/arm/hvf_arm.h           | 18 +-------
 target/arm/kvm_arm.h           |  1 +
 target/arm/multiprocessing.h   | 18 ++++++++
 target/arm/psci.h              | 18 ++++++++
 target/arm/tcg/translate.h     |  2 +-
 hw/arm/aspeed_ast2600.c        |  1 +
 hw/arm/aspeed_ast27x0.c        |  2 +
 hw/arm/bananapi_m2u.c          |  1 +
 hw/arm/bcm2838.c               |  1 +
 hw/arm/boot.c                  |  2 +
 hw/arm/exynos4210.c            |  3 +-
 hw/arm/fsl-imx8mp.c            |  1 +
 hw/arm/highbank.c              |  2 +-
 hw/arm/imx8mp-evk.c            |  1 +
 hw/arm/mcimx6ul-evk.c          |  1 +
 hw/arm/mcimx7d-sabre.c         |  1 +
 hw/arm/mps3r.c                 |  2 +-
 hw/arm/npcm8xx.c               |  2 +
 hw/arm/orangepi.c              |  1 +
 hw/arm/realview.c              | 10 ++---
 hw/arm/sbsa-ref.c              |  2 +
 hw/arm/smmuv3.c                |  1 -
 hw/arm/virt-acpi-build.c       |  4 +-
 hw/arm/virt.c                  |  1 +
 hw/arm/xlnx-versal-virt.c      |  1 +
 hw/arm/xlnx-zcu102.c           |  1 +
 hw/vmapple/vmapple.c           |  3 ++
 target/arm/arch_dump.c         |  2 +-
 target/arm/arm-powerctl.c      |  2 +-
 target/arm/arm-qmp-cmds.c      |  1 +
 target/arm/cortex-regs.c       |  2 +-
 target/arm/cpu.c               | 10 ++++-
 target/arm/cpu64.c             |  2 +-
 target/arm/debug_helper.c      |  2 +-
 target/arm/gdbstub.c           |  2 +-
 target/arm/gdbstub64.c         |  2 +-
 target/arm/helper.c            |  3 +-
 target/arm/hvf-stub.c          | 20 +++++++++
 target/arm/hvf/hvf.c           |  1 +
 target/arm/hyp_gdbstub.c       |  2 +-
 target/arm/kvm-stub.c          |  2 +-
 target/arm/kvm.c               |  3 +-
 target/arm/machine.c           |  2 +-
 target/arm/ptw.c               |  2 +-
 target/arm/tcg-stubs.c         |  2 +-
 target/arm/tcg/cpu-v7m.c       |  2 +-
 target/arm/tcg/cpu32.c         |  2 +-
 target/arm/tcg/cpu64.c         |  2 +-
 target/arm/tcg/helper-a64.c    |  2 +-
 target/arm/tcg/hflags.c        |  2 +-
 target/arm/tcg/iwmmxt_helper.c |  2 +-
 target/arm/tcg/m_helper.c      |  2 +-
 target/arm/tcg/mte_helper.c    |  2 +-
 target/arm/tcg/mve_helper.c    |  2 +-
 target/arm/tcg/neon_helper.c   |  2 +-
 target/arm/tcg/op_helper.c     |  4 +-
 target/arm/tcg/pauth_helper.c  |  2 +-
 target/arm/tcg/psci.c          |  3 +-
 target/arm/tcg/sme_helper.c    |  2 +-
 target/arm/tcg/sve_helper.c    |  2 +-
 target/arm/tcg/tlb-insns.c     |  2 +-
 target/arm/tcg/tlb_helper.c    |  2 +-
 target/arm/tcg/vec_helper.c    |  2 +-
 target/arm/tcg/vfp_helper.c    |  2 +-
 target/arm/vfp_fpscr.c         |  2 +-
 target/arm/meson.build         |  4 +-
 target/arm/tcg/meson.build     |  2 +
 73 files changed, 221 insertions(+), 143 deletions(-)
 create mode 100644 target/arm/cpu_has_feature.h
 create mode 100644 target/arm/psci.h
 create mode 100644 target/arm/hvf-stub.c

-- 
2.47.1


