Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D584BD5C0F0
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 15:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9R96-0002lA-Dl; Fri, 08 Nov 2024 10:43:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9R8w-0002fK-Rh
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:43:28 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9R8s-0005MW-1t
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:43:25 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37d3ecad390so1998723f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 07:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731080600; x=1731685400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OGYYu9uDLFU2RYpWoNuF1bsweDbG4J7PO3OV7GstpRk=;
 b=pCOsmtL+3JT6YiiGrRaQuqjRP/lgpYpWHnDMN1i3K2/p+M1mseYn3j01IeseoYLJJb
 OWhij6TLI4zPLcivqv4SAlFWnLyqO45XOfagpwWzLOkPmOexCAPRxgx/9FSDRIe+kChk
 2fKP3HQTWmdiptCAZBLBo57UTb4FLtopPlvXajtaOUsKRhU7tXbc5WxoU0D7rv2RQph0
 7J0MG1WAzdrHQJxpHkhMNKfAhQ6X6+45Gk9kgFERNLJ98nXyBVsMJSGijU6UXpQj5Nq0
 ZTme9ZTGJNfvFQ5vCSxuh+kBw2+NBMMoy9zQE+VtzxViaRQSpzElhmZyzdTQnXf6SBG+
 2anQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731080600; x=1731685400;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OGYYu9uDLFU2RYpWoNuF1bsweDbG4J7PO3OV7GstpRk=;
 b=ChuaUeUDQvifyl88AdE3wQFwTsX2loku+AOzviIx40fSSZLrc6jY194QBBiwFEMod2
 USuQYApzt0RKxdMzyvaS9v3XrrF4no4Tc2Ravw3MCVy2Ahe5b/AAWikBKBHccefIpY9v
 KU57jito2VRarldF/JVdekf/LjrxMXdH4nEdnOtr2QXIABxEfcrrSepdRE4dOxIaUmI/
 KhYskSpWB234+TObZ/npLkG5qjwRoUB2tM4M8sKK9FIEajVWcRRrzIKz/AZAq4RwpaPk
 EVmylBchrTYqFzPhheHIZTwcQw6JW5wVckYfFytdc505dpd0WriAdHSgZDNFatvioX1y
 UJ+g==
X-Gm-Message-State: AOJu0Yz0uZQw4bs9U1r5v759KTakeVsicPaGI5SnYisAyLyVlV5oIMe9
 o4BZVcqfV1seSi2MY1mUhHE9ZTZDhACw+Yp8ioIRCVWoUvclCMbNZGJEzQ7OafGFLOGyEWyEh5N
 4
X-Google-Smtp-Source: AGHT+IGig41p4mOhXnnD7LpETtXZpc4o+31r9+lZ7XyqpufHHUdZqZ4eB1q4asbKjOQc/j5duWi3cg==
X-Received: by 2002:a05:6000:1548:b0:37e:c4e3:f14b with SMTP id
 ffacd0b85a97d-381f1c83bf0mr2695037f8f.23.1731080600315; 
 Fri, 08 Nov 2024 07:43:20 -0800 (PST)
Received: from localhost.localdomain ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9ea7c3sm5381722f8f.80.2024.11.08.07.43.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 08 Nov 2024 07:43:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Anton Johansson <anjo@rev.ng>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 00/17] hw/microblaze: Allow running cross-endian vCPUs
Date: Fri,  8 Nov 2024 15:43:00 +0000
Message-ID: <20241108154317.12129-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Missing review: 4 (new) & 10

Since v2:
- Addressed Richard's review comments

Since v1:
- Make device endianness configurable (Edgar)
- Convert more Xilinx devices
- Avoid preprocessor #if (Richard)
- Add R-b tags

Make machines endianness-agnostic, allowing to run a big-endian vCPU
on the little-endian 'qemu-system-microblazeel' binary, and a little
endian one on the big-endian 'qemu-system-microblaze' binary.

Tests added, following combinations covered:
- little-endian vCPU using little-endian binary (in-tree)
- little-endian vCPU using big-endian binary (new)
- big-endian vCPU using little-endian binary (new)
- big-endian vCPU using big-endian binary (in-tree)

To make a target endian-agnostic we need to remove the MO_TE uses.
In order to do that, we propagate the MemOp from earlier in the
call stack, or we extract it from the vCPU env (on MicroBlaze the
CPU endianness is exposed by the 'ENDI' bit).

Next step: Look at unifying binaries.

Please review,

Phil.

Philippe Mathieu-Daudé (17):
  hw/microblaze: Restrict MemoryRegionOps are implemented as 32-bit
  hw/microblaze: Propagate CPU endianness to microblaze_load_kernel()
  hw/intc/xilinx_intc: Make device endianness configurable
  RFC hw/net/xilinx_ethlite: Simplify by having configurable endianness
  RFC hw/timer/xilinx_timer: Allow down to 8-bit memory access
  hw/timer/xilinx_timer: Make device endianness configurable
  hw/char/xilinx_uartlite: Make device endianness configurable
  hw/ssi/xilinx_spi: Make device endianness configurable
  hw/ssi/xilinx_spips: Make device endianness configurable
  hw/arm/xlnx-zynqmp: Use &error_abort for programming errors
  target/microblaze: Explode MO_TExx -> MO_TE | MO_xx
  target/microblaze: Set MO_TE once in do_load() / do_store()
  target/microblaze: Introduce mo_endian() helper
  target/microblaze: Consider endianness while translating code
  hw/microblaze: Support various endianness for s3adsp1800 machines
  tests/functional: Explicit endianness of microblaze assets
  tests/functional: Add microblaze cross-endianness tests

 hw/microblaze/boot.h                          |  4 +-
 include/hw/ssi/xilinx_spips.h                 |  1 +
 target/microblaze/cpu.h                       |  7 +++
 hw/arm/xilinx_zynq.c                          |  1 +
 hw/arm/xlnx-zynqmp.c                          | 40 +++++--------
 hw/char/xilinx_uartlite.c                     | 31 ++++++----
 hw/intc/xilinx_intc.c                         | 50 ++++++++++++----
 hw/microblaze/boot.c                          |  8 +--
 hw/microblaze/petalogix_ml605_mmu.c           |  4 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c      | 58 ++++++++++++++++---
 hw/microblaze/xlnx-zynqmp-pmu.c               |  2 +-
 hw/net/xilinx_ethlite.c                       | 42 +++++++++-----
 hw/ppc/virtex_ml507.c                         |  1 +
 hw/ssi/xilinx_spi.c                           | 24 +++++---
 hw/ssi/xilinx_spips.c                         | 36 +++++++-----
 hw/timer/xilinx_timer.c                       | 33 +++++++----
 target/microblaze/translate.c                 | 49 ++++++++++------
 .../functional/test_microblaze_s3adsp1800.py  | 27 ++++++++-
 .../test_microblazeel_s3adsp1800.py           | 25 +++++++-
 19 files changed, 309 insertions(+), 134 deletions(-)

-- 
2.45.2


