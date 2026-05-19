Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0528CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPOgj-0008Ny-85; Tue, 19 May 2026 13:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wPOgV-0008M6-Qp
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:56:53 -0400
Received: from inva021.nxp.com ([92.121.34.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wPOgR-0002g6-L8
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:56:51 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 277D2203C10;
 Tue, 19 May 2026 19:56:40 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D2F1C202769;
 Tue, 19 May 2026 19:56:39 +0200 (CEST)
Received: from lsv031015.swis.in-blr01.nxp.com
 (lsv031015.swis.in-blr01.nxp.com [10.12.177.77])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B00BD180217B;
 Wed, 20 May 2026 01:56:38 +0800 (+08)
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, shentey@gmail.com,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCHv1 0/7] hw/arm: Adding Cortex-M7 Asymmetric Multiprocessing
 boot support for i.MX8MP
Date: Tue, 19 May 2026 23:26:28 +0530
Message-Id: <20260519175635.3245229-1-gaurav.sharma_7@nxp.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=92.121.34.21;
 envelope-from=gaurav.sharma_7@nxp.com; helo=inva021.nxp.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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

Changes in v1:

This series adds Asymmetric Multiprocessing (AMP) boot support for
the Cortex-M7 core on the i.MX8MP SoC. The M7 firmware can be loaded
and started from Linux running on the Cortex-A53 cores via the
remoteproc framework.

The series introduces the following peripheral models needed for AMP:
  - GPC (General Power Controller)
  - GPR (General Purpose Registers)
  - SRC (System Reset Controller) authored by Bernhard Beschow <shentey@gmail.com>
  - MU (Messaging Unit)
  - Extends the CCM with M7 clock outputs and wires into the i.MX8MP SoC
  - Enable Cortex-M7 boot in i.MX8MP EVK functional test

Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>

Bernhard Beschow (1):
  hw/misc: Add SRC (System Reset Controller) to i.MX8MP

Gaurav Sharma (6):
  hw/misc: Add i.MX8MP GPC (General Power Controller) IP
  hw/misc: Add GPR (General Purpose Register) IP to iMX8MP
  hw/misc: Add MU (Messaging Unit) IP to i.MX8MP device model
  hw/misc: Extend i.MX8MP CCM with Cortex-M7 clock outputs
  hw/arm: Enable Cortex-M7 AMP boot on i.MX8MP
  tests/functional: Enable Cortex-M7 boot in i.MX8MP EVK functional test

 docs/system/arm/imx8m.rst                   |  90 +++-
 hw/arm/Kconfig                              |   4 +
 hw/arm/fsl-imx8mp.c                         | 212 ++++++++++
 hw/misc/Kconfig                             |  12 +
 hw/misc/imx8mp_ccm.c                        |   9 +
 hw/misc/imx8mp_gpc.c                        | 124 ++++++
 hw/misc/imx8mp_gpr.c                        | 129 ++++++
 hw/misc/imx8mp_mu.c                         | 308 ++++++++++++++
 hw/misc/imx8mp_src.c                        | 431 ++++++++++++++++++++
 hw/misc/meson.build                         |   4 +
 hw/misc/trace-events                        |   5 +
 include/hw/arm/fsl-imx8mp.h                 |  29 +-
 include/hw/misc/imx8mp_ccm.h                |   3 +
 include/hw/misc/imx8mp_gpc.h                |  34 ++
 include/hw/misc/imx8mp_gpr.h                |  56 +++
 include/hw/misc/imx8mp_mu.h                 |  53 +++
 include/hw/misc/imx8mp_src.h                |  32 ++
 tests/functional/aarch64/test_imx8mp_evk.py |   3 +-
 18 files changed, 1535 insertions(+), 3 deletions(-)
 create mode 100644 hw/misc/imx8mp_gpc.c
 create mode 100644 hw/misc/imx8mp_gpr.c
 create mode 100644 hw/misc/imx8mp_mu.c
 create mode 100644 hw/misc/imx8mp_src.c
 create mode 100644 include/hw/misc/imx8mp_gpc.h
 create mode 100644 include/hw/misc/imx8mp_gpr.h
 create mode 100644 include/hw/misc/imx8mp_mu.h
 create mode 100644 include/hw/misc/imx8mp_src.h

-- 
2.34.1


