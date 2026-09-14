Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD5BC88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6CHV-0000pD-Jb; Mon, 14 Sep 2026 15:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x6CHF-0000kF-1k; Mon, 14 Sep 2026 15:23:41 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x6CHC-0002Lq-Nq; Mon, 14 Sep 2026 15:23:40 -0400
Received: from smtp02.univ-lille.fr (smtp02.univ-lille.fr [194.254.129.96])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4hkFS673YRz7ypq;
 Mon, 14 Sep 2026 21:23:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1789413815;
 bh=ZTxuBkdiyM6lBV5+oCGHkHOgg2kg/I1ByhAs3yLdk1E=;
 h=From:To:Cc:Subject:Date:From;
 b=g0r1Ozbpmms21L8oJd031psfoJlN1LDGGOIA8ubeI2KK+z49TyTLpRJ1dZuiT/gZ5
 u/Po91u+gPleMfFYMFAC0bkj0KCVId+w9PQqMsl8rMUvJATgxi8n15Csjtfm39nYfB
 rwQF5zTfvzjx3C5ZODp94AxjfUQbSfnVCGo4jMbGMSlU5Qqu6QQYMq+rPYKE+ag+pD
 5IHX5b06b7GdAac9ytclLhN9SfLVI8IYRW/FqziZVSKwrSDUI7ekbZp4/puvu1uF6c
 abQVlzPiT+ALCp2WGzsQRT41JOpTiCXA89/bJEb6YszTjBQ0GeLqWuceeGxx0Y1Ou0
 rK3F/3RPyN4wA==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp02.univ-lille.fr (Postfix) with ESMTPSA id 4hkFS65VM3z6skd;
 Mon, 14 Sep 2026 21:23:34 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org,
	alex.bennee@linaro.org
Subject: [RFC PATCH v1 0/6] target/arm: improve Armv6-M support
Date: Mon, 14 Sep 2026 21:23:16 +0200
Message-ID: <20260914192323.29250-1-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.106;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-2.univ-lille.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This RFC series refines the Armv6-M support in QEMU by correcting NVIC
limits, modelling the optional Cortex-M0+ privilege extension,
tightening MPU register access, fixing MPU region size checks, masking
TEX bits for Armv6-M, and reusing QEMU's existing PMSAv7 implementation
for the compatible v6-M MPU.

Following review of the RP2040/Pico v3 RFC, these generic Arm changes
have been split into a standalone series.  While they are motivated by
the Pico bring-up effort, the patches address generic Armv6-M behaviour
and improve Arm M-profile emulation independently of the Pico machine.
They incorporate the review comments from Peter Maydell and Alex Bennee
on the RP2040/Pico v3 RFC:
Link: https://lore.kernel.org/qemu-devel/20260906194438.93046-1-gilles.grimaud@univ-lille.fr/

The RP2040/Pico machine series will be posted separately and will depend
on these generic Arm changes. The two new check-tcg tests pass with the
Arm TCG cross compiler.

The series consists of six patches:

- enforce Armv6-M NVIC limits (max 32 external interrupts, respect
  reserved registers, add TCG test)
- model Cortex-M0+ privilege extension (feature bit, CPU type, allow
  privileged writes to CONTROL.nPRIV when Main Extension or privilege
  extension present)
- limit MPU RBAR and RASR/RLAR alias registers to the Main Extension
  (reorder cases, guard with ARM_FEATURE_M_MAIN)
- mask TEX bits in MPU_RASR for Armv6-M (use mask 0x1707, preserve
  Armv7-M behaviour)
- enforce the architectural minimum region sizes for v6-M, v7-M and v7-R
- extend PMSAv7 support to v6-M CPUs (widen conditionals to accept
  ARM_FEATURE_M, keep PMSAv8 path for v8-M)

Together, these patches add two new TCG assembly tests
(test-armv6m-control.S and test-armv6m-nvic.S) that verify the corrected
NVIC behaviour and Cortex-M0 CONTROL.nPRIV handling, and update the
corresponding meson.build file.

The series is ready for review and testing; please send any comments or
suggestions.

Gilles Grimaud (6):
  target/arm: enforce Armv6-M NVIC limits
  target/arm: model Cortex-M0+ privilege extension
  target/arm: MPU - limit regs RBAR/RASR A1-A3 to Main Extension
  target/arm: MPU_RASR: mask TEX bits for Armv6-M
  target/arm: fix MPU SIZE min for v6-M/v7-M/v7-R
  target/arm: extend PMSAv7 support to v6-M CPUs

 hw/intc/armv7m_nvic.c                      | 42 +++++++++++--
 target/arm/cpu.c                           | 12 +++-
 target/arm/cpu.h                           |  1 +
 target/arm/machine.c                       |  3 +-
 target/arm/ptw.c                           | 14 ++++-
 target/arm/tcg/cpu-v7m.c                   | 11 ++++
 target/arm/tcg/m_helper.c                  |  4 +-
 tests/tcg/arm/system/meson.build           | 12 ++++
 tests/tcg/arm/system/test-armv6m-control.S | 66 ++++++++++++++++++++
 tests/tcg/arm/system/test-armv6m-nvic.S    | 70 ++++++++++++++++++++++
 10 files changed, 222 insertions(+), 13 deletions(-)
 create mode 100644 tests/tcg/arm/system/test-armv6m-control.S
 create mode 100644 tests/tcg/arm/system/test-armv6m-nvic.S

-- 
2.55.0

