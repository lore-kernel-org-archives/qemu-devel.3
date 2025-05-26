Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD40C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 08:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJTcM-0004Rz-AX; Mon, 26 May 2025 04:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uJTcJ-0004RG-Id
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:55:31 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uJTcH-00082W-RH
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:55:31 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-441d437cfaaso11773835e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 01:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1748249726; x=1748854526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h/Kh0vlsUmDeZGS0m/0HStbc4MTMQHVDFXchMhdkFP4=;
 b=Wabx1IH+vgxVqzHDXiaMdOlXdKWVC8jk0ZfLPXlsI5l5RVVBaYxjnCDXdoxQvy2HeT
 KYBu4D+C9oys0UvyfuG+6qSFJ700PYtNYB0DGdN+GpZR8c9iw2m7BNlXgViv2P5OmikI
 ZSi9lNvDmlW0EeOtCSUChAXqD0N6chNopFsYxF7C+kHl2PK/0mHLWemfHjp7jklVYHiI
 Jnd8GONxcSDRyTH1qXwMQYneJCmUcJgSAAfx/cBthyuIgraGTfauFCJMUVWoyxcyURJ1
 m1zY2yFowI240MozfVBJTnQPexo4/+OIe8/kzme8hAaKhAGV3kkcGtuey/z8Dl6Si+5u
 6AdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748249726; x=1748854526;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h/Kh0vlsUmDeZGS0m/0HStbc4MTMQHVDFXchMhdkFP4=;
 b=H3/eJv43EoLR2piF7UB9x9J8bgvB0ZkxrsURvJT3bNly3mYC9tDFAaeQDkBm0ZB/r8
 U0rvvf1X0zsyxE3oXHATz/mQtptxqIEAELFY3YW5o2cvEEHwzoS8mUCfU/pwKYPwwqEH
 9zRMYaOk6mKzRIkaYLBke3EG7FLibaFXO4MD+3D8h2s5voQilZq2OzZ4pb8lWcY09p8x
 ArQGc7Ne+3UVFWWJ2tZvw9e4MCGGMtGNA/JQhm6mbKWfWgxHoBhKXGN8QmeDDDsTItVi
 0BpG7/JtP0PnbhnQBPTVZTq58T0Rknf1qV+QyUOm/+1de9oyrQSXpCtMoyYnGPn2zlH9
 yC9w==
X-Gm-Message-State: AOJu0Yxj34q77rPXND/NG00qBS67bwBra23G0Xlyp2XVygPb9O/MMzNu
 j5rUAZvPdBfenpvhZ/pM8FdRar5U7h2GV62dDXb2jxvig0i8EZIkWjDajbMoSLEWl0svXpu0JhS
 ABdk=
X-Gm-Gg: ASbGncuSNfBQ3nMT/uIiXMR2Vj6bCd/lf99RYasRxCuWuHs1mcYAm9DNoVLT6XKwgUI
 Fy89RhHBqAPVEBzPUma6zWUfb2Qu2/3HVrReI3Rlb7Kz3Se/vjTxnJQ16XCFdgSfCH0bROQnrbR
 Gymi+8eH7ODkw0c0qIOepX0aRGWypxpedQkBs21rm32FpWzLm9FHhq1A6aDT3KXsZqZDU4eR1h3
 6iksgTRLMpHGE+KxCvhV4jfHT1HgLJsI2U6BCpYZvFHHTy3n9mkJpOgDmYnNEnfSIHut1hZ+15b
 BnG0dJMHCo43gcuZ3057t7+OMO2nJvXkC3chlE+X6yOJnWLRailM87Pxu3D4UKwAhq8+MKAnsjW
 FgmEZsYdtj1jOLOegF5wrnkOXUaKVOHs4VY74F8QTVK1Te9zy
X-Google-Smtp-Source: AGHT+IFMgj8Au5H1+qwlgxg8IoWt4Q4zTJSIZZH5ij8kvo6epBREsJFiAEWcBYXDuHe7AAuG1BXk0A==
X-Received: by 2002:a05:600c:3c84:b0:442:d9f2:c6ef with SMTP id
 5b1f17b1804b1-44c9301660cmr84939245e9.2.1748249726089; 
 Mon, 26 May 2025 01:55:26 -0700 (PDT)
Received: from chigot-Dell.telnowedge.local
 (lmontsouris-659-1-24-67.w81-250.abo.wanadoo.fr. [81.250.175.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f23bfd54sm238911675e9.17.2025.05.26.01.55.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 01:55:25 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, edgar.iglesias@gmail.com,
 alistair@alistair23.me,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH v2 0/4] xlnx-zynqmp: add support to boot on RPUs
Date: Mon, 26 May 2025 10:55:19 +0200
Message-Id: <20250526085523.809003-1-chigot@adacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x329.google.com
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

This series enhances Xilinx ZynqMP support to allow booting on RPUs and
ease gdb connections to them.

It was validated with home-made binaries. FreeRTOS was tested but without
success: outputs/IRQ seems broken. AFAICT, FreeRTOS is expecting Xilinx's
QEMU thus I didn't investigate further, but I'd still like advice
on the 3rd patch ("wire a second GIC") since it could be related to it.

Changes since v1:
 - add doc for "first-cpu-index" new property in arm_gic.h.

Clément Chigot (2):
  hw/arm: make cpu targeted by arm_load_kernel the primary CPU.
  hw/arm/xlnx-zynqmp: adapt cluster-id based on the boot cpu

Frederic Konrad (2):
  hw/intc/arm_gic: introduce a first-cpu-index property
  hw/arm/xlnx-zynqmp: wire a second GIC for the Cortex-R5

 hw/arm/boot.c                    |  15 +++--
 hw/arm/xlnx-zynqmp.c             | 104 ++++++++++++++++++++++++++++---
 hw/intc/arm_gic.c                |   2 +-
 hw/intc/arm_gic_common.c         |   1 +
 include/hw/arm/boot.h            |   3 +
 include/hw/arm/xlnx-zynqmp.h     |   6 ++
 include/hw/intc/arm_gic.h        |   2 +
 include/hw/intc/arm_gic_common.h |   2 +
 8 files changed, 117 insertions(+), 18 deletions(-)

-- 
2.34.1


