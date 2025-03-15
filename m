Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC61DC28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 13:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttRS8-0006x5-KX; Sat, 15 Mar 2025 09:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1ttRS5-0006wW-Cq
 for qemu-devel@nongnu.org; Sat, 15 Mar 2025 09:21:21 -0400
Received: from out-172.mta1.migadu.com ([2001:41d0:203:375::ac])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1ttRS2-00059o-VC
 for qemu-devel@nongnu.org; Sat, 15 Mar 2025 09:21:20 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1742044867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZLm0hqAE+F8lyklA6QyeVI14fxlR7O+KswpiOB5myNs=;
 b=dok4cOlSbMnYCd5b6YGllLQ82LC5+sopN4nrVdH79KwVPXp8SydbUwULMCCPMmQf2tqpvg
 kB3JJiadrWjpSbTRprNYv52BQXzztz+h6cjAAez83Yu2P25i3duFpvvt/acAdflRt/b3LZ
 XzVFbydnPrInhfrbf/knfd/RkiZeBbs=
From: Zenghui Yu <zenghui.yu@linux.dev>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org,
 Zenghui Yu <zenghui.yu@linux.dev>
Subject: [PATCH] hvf: arm: Emulate ICC_RPR_EL1 accesses properly
Date: Sat, 15 Mar 2025 21:20:30 +0800
Message-Id: <20250315132030.95209-1-zenghui.yu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::ac;
 envelope-from=zenghui.yu@linux.dev; helo=out-172.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Commit a2260983c655 ("hvf: arm: Add support for GICv3") added GICv3 support
by implementing emulation for a few system registers. ICC_RPR_EL1 was
defined but not plugged in the sysreg handlers (for no good reason).

Fix it.

Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
---
 target/arm/hvf/hvf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 87e35c1b71..650b7f4256 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1359,6 +1359,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_ICC_IGRPEN0_EL1:
     case SYSREG_ICC_IGRPEN1_EL1:
     case SYSREG_ICC_PMR_EL1:
+    case SYSREG_ICC_RPR_EL1:
     case SYSREG_ICC_SGI0R_EL1:
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
@@ -1673,6 +1674,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_ICC_IGRPEN0_EL1:
     case SYSREG_ICC_IGRPEN1_EL1:
     case SYSREG_ICC_PMR_EL1:
+    case SYSREG_ICC_RPR_EL1:
     case SYSREG_ICC_SGI0R_EL1:
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
-- 
2.34.1


