Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF9BC71155
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 14:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRAUM-00016p-Ut; Mon, 16 Jun 2025 10:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uRATv-000159-PM
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 10:06:39 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uRATr-0003ya-Da
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 10:06:39 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a5096158dcso3953201f8f.1
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 07:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750082793; x=1750687593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=b6YSSNbRC0wLG9hUE3eevWNkke174Uam4NGL4nA5BL4=;
 b=No9UuDRQ4N1UiarjnarDgGLcHtOa22DRjs6nIrXTHMyuqr3wUh+DWe1PsuqRONh69Y
 tFFizX4cI4qgpv41R4im4iIengj+t3CD2jWjw+EFZNi0Sa+qpjWsb3W0/9QHYe78H4HD
 8AwCsB1PjzTITKhj97fiQKvE2dgPnOo1YWgv+wZGbwBhsOkUyT/8cczs0tnC0rDyPuPS
 smc/Dlg7RFjQ7KTVw6s7JbknlLV9Kear8cgc7l8O/5ceAu60vWRZBy87srXWTGRZpToB
 VRoDY0nz9V+O80dQf6hHkBN6n+E8YT21bz3Ahr7VTZDy0a1yQ4iaU9foDJbF+nioioRN
 e9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750082793; x=1750687593;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b6YSSNbRC0wLG9hUE3eevWNkke174Uam4NGL4nA5BL4=;
 b=PysOD2aOb/OWHwejITeK/tARXcF02PV7IVBTgo3YdeutzF5Uua3wGKIcLiQuHZwfGS
 KiGpy1hykdc9TGgoAFYGpbkVp0EYEkEzltEu8nspbb4rDrF9XFiMfFpKOfE0l2rX5ZCf
 PL0xZ1HfDnVzOIyL1gWu5aNQ7APEgZFWzu7N9+g4yCY9j8w0Noq+66fxWsriJR/wIVe5
 NkjDgAP2P+5B/04EHMaWn3CWKXA8NI5n9DxSMRa7MafoJZBMDdneBVDdrAUPsvh/Shhi
 QMCK0/GzMMeWvAou6jzj/fB4Mx4OP5HYU1kju+mFToPPKx7Sevyo26pWcfcYxO1GIZWR
 bvLg==
X-Gm-Message-State: AOJu0YxzcCojBWXiWsKxKLgmHy02QHxpQUS9QFUXpx9pX0Mg2oI2iG7H
 AkfJzSlvpo+Pce7rs02mPmFifAnmR2ZlPobgyC1k/bl2vBZopOAQjoGoxuL1+u0CwLfvyE1+1aO
 iZb8c
X-Gm-Gg: ASbGnctTQr5qSTkQ+OeGSfeuPesWn5Xvju+gGpRm2w1dx4SpBNEa258lMiDdl0kk9uY
 +KR8HMWwul3HvWrjROvF33BjfJsV22JeSiENRsPuVZcq6NgwjgMHk1K0EDExhE0Ht0Za3TxBiIf
 7Zag6ejN0+2oZvtPlIQ+bZOqJ30M/0YovFYOXZCWT6LG0Sd74xshW38l2LYLNMbmIyQgRsmC0PT
 Nbp9r+R+a+Rmi5J0vLAtQ6U8d/mt24SImSx27rc3GRMUmKxmuONnHoWFAbZ6LtHDWVohxp/CBzQ
 nD7TnuUmMsMUimSSs4z4q1eI/K+7vaH+dR5dYZRvwUumU/YjwRfQgK5lm4iNS/tQHyvT
X-Google-Smtp-Source: AGHT+IEXxdoPOeDZbj0tfHUCnSepSmw5ppeWym7P2ZKd5Y5iN/FJF4udbuHK67eUcktfPTDAquhKEw==
X-Received: by 2002:a05:6000:1448:b0:3a4:dfaa:df8c with SMTP id
 ffacd0b85a97d-3a5723678a8mr6403556f8f.11.1750082792775; 
 Mon, 16 Jun 2025 07:06:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e13c192sm146561975e9.26.2025.06.16.07.06.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 07:06:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] target-arm queue
Date: Mon, 16 Jun 2025 15:06:21 +0100
Message-ID: <20250616140630.2273870-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

Hi; small pullreq with mostly just minor bug fixes in it this week.

thanks
-- PMM

The following changes since commit d9ce74873a6a5a7c504379857461e4ae64fcf0cd:

  Merge tag 'pull-vfio-20250611' of https://github.com/legoater/qemu into staging (2025-06-11 11:39:53 -0400)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20250616

for you to fetch changes up to 5ad2b1f443a96444cf3e7a2fbe17aae696201012:

  linux-user/arm: Fix return value of SYS_cacheflush (2025-06-16 11:26:25 +0100)

----------------------------------------------------------------
target-arm queue:
 * hw/arm/virt: Check bypass iommu is not set for iommu-map DT property
 * tests/functional: Add a test for the realview-eb-mpcore machine
 * qemu-options.hx: Fix reversed description of icount sleep behavior
 * target/arm: Define raw write for PMU CLR registers
 * docs/interop: convert qed_spec.txt to reStructuredText format
 * hw/arm: make cpu targeted by arm_load_kernel the primary CPU.
 * hw/intc/arm_gic: introduce a first-cpu-index property
 * hw/arm/mps2: Configure the AN500 CPU with 16 MPU regions
 * linux-user/arm: Fix return value of SYS_cacheflush

----------------------------------------------------------------
Akihiko Odaki (1):
      target/arm: Define raw write for PMU CLR registers

Clément Chigot (1):
      hw/arm: make cpu targeted by arm_load_kernel the primary CPU.

Ethan Chen (1):
      qemu-options.hx: Fix reversed description of icount sleep behavior

Frederic Konrad (1):
      hw/intc/arm_gic: introduce a first-cpu-index property

J. Neuschäfer (1):
      linux-user/arm: Fix return value of SYS_cacheflush

Peter Maydell (1):
      hw/arm/mps2: Configure the AN500 CPU with 16 MPU regions

Shameer Kolothum (1):
      hw/arm/virt: Check bypass iommu is not set for iommu-map DT property

Souleymane Conte (1):
      docs/interop: convert qed_spec.txt to reStructuredText format

Thomas Huth (1):
      tests/functional: Add a test for the realview-eb-mpcore machine

 MAINTAINERS                           |   2 +
 docs/interop/index.rst                |   1 +
 docs/interop/qed_spec.rst             | 219 ++++++++++++++++++++++++++++++++++
 docs/interop/qed_spec.txt             | 138 ---------------------
 include/hw/arm/boot.h                 |   3 +
 include/hw/intc/arm_gic.h             |   3 +
 include/hw/intc/arm_gic_common.h      |   2 +
 hw/arm/boot.c                         |  15 ++-
 hw/arm/mps2.c                         |   4 +
 hw/arm/virt.c                         |  15 ++-
 hw/intc/arm_gic.c                     |   2 +-
 hw/intc/arm_gic_common.c              |   1 +
 linux-user/arm/cpu_loop.c             |   1 +
 target/arm/helper.c                   |  12 +-
 qemu-options.hx                       |   8 +-
 tests/functional/meson.build          |   1 +
 tests/functional/test_arm_realview.py |  47 ++++++++
 17 files changed, 312 insertions(+), 162 deletions(-)
 create mode 100644 docs/interop/qed_spec.rst
 delete mode 100644 docs/interop/qed_spec.txt
 create mode 100755 tests/functional/test_arm_realview.py

