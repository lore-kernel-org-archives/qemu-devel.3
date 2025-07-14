Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E06C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 17:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubMXw-0003h3-Op; Mon, 14 Jul 2025 13:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1ubLd0-0005am-NS
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 12:02:19 -0400
Received: from out-188.mta0.migadu.com ([2001:41d0:1004:224b::bc])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1ubLcx-0008Ps-85
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 12:02:06 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1752508921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yzqv4D1JaiwZdiQ5ubH+STSsZry9b6p+Rg5sjIeFz3c=;
 b=NaY+nQktSuFT8oZnsNgMU+ScMd/Wqw+MP++/csE3JVEVsedMolGziwTBbchNIhW0Y8S+u7
 KcgR5XACHCkH3ec/poRbAGbAHd2n8qaZDve5BHq9YepgLpjIdcA7i8EfPHID2hUUu0uPId
 n4SsvWzVIc43En7XalW7p4ncpd0jqhs=
From: Zenghui Yu <zenghui.yu@linux.dev>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: agraf@csgraf.de, mads@ynddal.dk, peter.maydell@linaro.org,
 Zenghui Yu <zenghui.yu@linux.dev>
Subject: [PATCH v2 2/2] hvf: arm: Emulate ICC_RPR_EL1 accesses properly
Date: Tue, 15 Jul 2025 00:01:39 +0800
Message-Id: <20250714160139.10404-3-zenghui.yu@linux.dev>
In-Reply-To: <20250714160139.10404-1-zenghui.yu@linux.dev>
References: <20250714160139.10404-1-zenghui.yu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::bc;
 envelope-from=zenghui.yu@linux.dev; helo=out-188.mta0.migadu.com
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

Fixes: a2260983c655 ("hvf: arm: Add support for GICv3")
Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
---
 target/arm/hvf/hvf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 1db0b77fb6..df556626ce 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1368,6 +1368,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_ICC_IGRPEN0_EL1:
     case SYSREG_ICC_IGRPEN1_EL1:
     case SYSREG_ICC_PMR_EL1:
+    case SYSREG_ICC_RPR_EL1:
     case SYSREG_ICC_SGI0R_EL1:
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
@@ -1685,6 +1686,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_ICC_IGRPEN0_EL1:
     case SYSREG_ICC_IGRPEN1_EL1:
     case SYSREG_ICC_PMR_EL1:
+    case SYSREG_ICC_RPR_EL1:
     case SYSREG_ICC_SGI0R_EL1:
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
-- 
2.34.1


