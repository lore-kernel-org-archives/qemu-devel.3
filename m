Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B102CCD1BF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 07:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE0RP-0007gI-ER; Wed, 29 Oct 2025 03:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.novikov@syntacore.com>)
 id 1vE0RL-0007ei-0F; Wed, 29 Oct 2025 03:17:51 -0400
Received: from m.syntacore.com ([178.249.69.228])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.novikov@syntacore.com>)
 id 1vE0RG-0005vz-I6; Wed, 29 Oct 2025 03:17:49 -0400
Received: from MRN-SC-KSMG-01.corp.syntacore.com (localhost [127.0.0.1])
 by m.syntacore.com (Postfix) with ESMTP id C530F1A0003;
 Wed, 29 Oct 2025 07:17:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 m.syntacore.com C530F1A0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com; s=m;
 t=1761722259; bh=+5yaTxbtAFKM9CqFwGPsQdLapyaz8S30u4wwoupEkpA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=CXcepInC6mCTUPKmOk4/OJGDImDb+5P78lvYrV4lIk1y3BAPKAjsDL4Mor+n09f3b
 hnIwNBGCCKId0AiHYKJXH571YoffFS9Zoyz5UPOOwptctAnc9RmjHq9+LKXFz/fLfa
 5LMRjInC9QgGcIJevKa5PU56qYjWnynoYr6a0rRmXq3dv5gLbCVfjQspO/OwlzN62/
 YUthp4OzQfyNsqQMC8mtQwC98vKx3s9PkT3+FIpsPd/EiFzAvaCutkSOIX4S5Mz95D
 Ab6FfQUmCXEww1/qP8Rh03wfpZh54lOAzd+BiNiuKAGjMXYh3LAktb9MmS3SrMprFY
 qaQZtj9t4HYKQ==
Received: from S-SC-EXCH-01.corp.syntacore.com (exchange.syntacore.com
 [10.76.202.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by m.syntacore.com (Postfix) with ESMTPS;
 Wed, 29 Oct 2025 07:17:38 +0000 (UTC)
Received: from mail.syntacore.com (172.17.58.29) by
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 29 Oct 2025 10:17:33 +0300
From: Nikita Novikov <n.novikov@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: Nikita Novikov <n.novikov@syntacore.com>, <qemu-riscv@nongnu.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 0/2] hw/intc/riscv_aplic: Expand AIA target[i] source handling
 and refactor related code
Date: Wed, 29 Oct 2025 10:17:11 +0300
Message-ID: <20251029-n-novikov-aplic_aia_ro-v1-0-39fec74c918a@syntacore.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251028-n-novikov-aplic_aia_ro-1baa353cd672
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761722114; l=1208;
 i=n.novikov@syntacore.com; s=20251028; h=from:subject:message-id;
 bh=A1+E2GT+GwvjNBFQcNxf1TR0ARm5m5Yygr8V4/3cLGo=;
 b=0xhhUGVxX0Zmf8W1Ug9mD9Mkyw4UYCp7xUGGwmyTAEPlSWRBIn6ey3+mGgqY7BGmxuyVJltP+
 OYJKh3jKCeyBWjGJ9VfFkRG3tqbunzzH+Fi+ckKHjB5izV5opaNM3K4
X-Developer-Key: i=n.novikov@syntacore.com; a=ed25519;
 pk=b3kqL1EmXxsQV/ZvSbT5Us5pjaKldmMgJuniTm3uLSM=
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.17.58.29]
X-ClientProxiedBy: S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) To
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20)
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310,
 bases: 2025/10/29 02:43:00 #27799423
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
Received-SPF: pass client-ip=178.249.69.228;
 envelope-from=n.novikov@syntacore.com; helo=m.syntacore.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

During the debug of APLIC I faced with the problem with target[i]
registers of source i. According to RISC-V AIA spec v1.0 ratificated on
the 12-th of March, 2025, the section 4.5.2 ("Source configurations")
says, than register target[i] shall be read-only zero when interrupt source i
is inactive in this domain. A source is inactive if it is delegated to a child
domain or its source mode is INACTIVE. Currently we checks the source status
only using sm == INACTIVE, but we do not check whether the source is
delegated.

This series of patches expands current active source checking and reduces
code the associated code dublication.

Signed-off-by: Nikita Novikov <n.novikov@syntacore.com>
---
Nikita Novikov (2):
      hw/intc/riscv_aplic: Expand inactive source handling for AIA target[i]
      hw/intc/riscv_aplic: Factor out source_active() and remove duplicate checks

 hw/intc/riscv_aplic.c | 66 ++++++++++++++++++++++-----------------------------
 1 file changed, 29 insertions(+), 37 deletions(-)
---
base-commit: d1bf06e8cc8197a2b18dbde820d957a51899d374
change-id: 20251028-n-novikov-aplic_aia_ro-1baa353cd672

Best regards,
-- 
Nikita Novikov <n.novikov@syntacore.com>


