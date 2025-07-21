Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57646C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 20:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udwkO-0005jF-1X; Mon, 21 Jul 2025 16:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1udwjI-0004rs-F2; Mon, 21 Jul 2025 16:03:26 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1udwjG-0004mL-Tc; Mon, 21 Jul 2025 16:03:20 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 30977139047;
 Mon, 21 Jul 2025 23:02:48 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E442624BED3;
 Mon, 21 Jul 2025 23:03:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zenghui Yu <zenghui.yu@linux.dev>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 70/70] hvf: arm: Emulate ICC_RPR_EL1 accesses properly
Date: Mon, 21 Jul 2025 23:02:57 +0300
Message-ID: <20250721200302.133559-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250721221446@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250721221446@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Zenghui Yu <zenghui.yu@linux.dev>

Commit a2260983c655 ("hvf: arm: Add support for GICv3") added GICv3 support
by implementing emulation for a few system registers. ICC_RPR_EL1 was
defined but not plugged in the sysreg handlers (for no good reason).

Fix it.

Fixes: a2260983c655 ("hvf: arm: Add support for GICv3")
Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250714160139.10404-3-zenghui.yu@linux.dev
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit e6da704b711d5d731e4d933ad56cbbc25ee0a825)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 01e26a9726..8a4a41d15b 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1352,6 +1352,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_ICC_IGRPEN0_EL1:
     case SYSREG_ICC_IGRPEN1_EL1:
     case SYSREG_ICC_PMR_EL1:
+    case SYSREG_ICC_RPR_EL1:
     case SYSREG_ICC_SGI0R_EL1:
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
@@ -1666,6 +1667,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_ICC_IGRPEN0_EL1:
     case SYSREG_ICC_IGRPEN1_EL1:
     case SYSREG_ICC_PMR_EL1:
+    case SYSREG_ICC_RPR_EL1:
     case SYSREG_ICC_SGI0R_EL1:
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
-- 
2.47.2


