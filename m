Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E9AC47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 15:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roPUE-0002vy-Ah; Sun, 24 Mar 2024 11:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <irina.ryapolova@syntacore.com>)
 id 1roPUD-0002vi-3Z; Sun, 24 Mar 2024 11:10:13 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <irina.ryapolova@syntacore.com>)
 id 1roPUB-0003jI-3J; Sun, 24 Mar 2024 11:10:12 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 9CF9DC0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1711293000;
 bh=NgBhcHvA1hJNLG9Q2UzD2GpmFdYNx5LDk1FdSzGkDj8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=pRSkowahCH8kS2suGlfiff68Wvg1t9GXzxuNLRyJYJpKjT+zuHO5KFICOtfhKLAhE
 HjP+ghRkbDSBLeoO38I4Tm9weMyVrWhM1RfFQzObzws6fiwcdPFp3uLmo/H+/l/kh+
 n0ICUvRPR5rGYPy8hRDGrfIOZoS503lpzYGRia8ur9Oay19tiyvAmeJ4nI0U0RLXxg
 cWw8B4Iup5nLtNzhW6JMqbRLTvfW3sBxXwDVa/Q86WEPUSDnYs1eOTl8BBiqp7wwCj
 d0Mm/BKcw2JADgKaSP1kCoGedxTQBkBvLH4tWNDVQZDL2rjL45QitQRhDXUk6angu+
 cQr5uQl40EX1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1711293000;
 bh=NgBhcHvA1hJNLG9Q2UzD2GpmFdYNx5LDk1FdSzGkDj8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=xGNeG6bgKiSKZ1fQeXTiZT4dMq5TPsXrRKp5jFKZy+yBE3WilIvJUl60oknpyOcZ7
 lVkknAWEstWJvN3kBAUsZJBx+HVqHNPg4jaE7aODkBPj1q0g9vCvUfL83ImqMQexLO
 vGiPSoaJ7bwjWyhD3DfDIcb6dszHshb61Tnl4NBfioMhfvcT4YiIGtkznFUcsHaiWA
 hVjVyWoiNFkgmeG5RTDYjthlFqqdhwDEqqJkEqt/hWSiRtCpXHaLgAxF/lidwkpJCl
 623QGcULwLyBZPe4dODtz1xlxFT9cBFcONvVr4xQQAZtl8M2k/tFDriAUsBKFAZIvy
 YTM9iqMbUZQtg==
From: Irina Ryapolova <irina.ryapolova@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>, 
 <bin.meng@windriver.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>, Irina Ryapolova
 <irina.ryapolova@syntacore.com>
Subject: [PATCH] target/riscv: Fix mode in riscv_tlb_fill
Date: Sun, 24 Mar 2024 18:09:47 +0300
Message-ID: <20240324150949.20822-1-irina.ryapolova@syntacore.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-08.corp.yadro.com (172.17.11.58) To
 S-Exch-01.corp.yadro.com (10.78.5.241)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=irina.ryapolova@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Need to convert mmu_idx to privilege mode for PMP function.

Signed-off-by: Irina Ryapolova <irina.ryapolova@syntacore.com>
---
 target/riscv/cpu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index ce7322011d..fc090d729a 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1315,7 +1315,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     bool two_stage_lookup = mmuidx_2stage(mmu_idx);
     bool two_stage_indirect_error = false;
     int ret = TRANSLATE_FAIL;
-    int mode = mmu_idx;
+    int mode = mmuidx_priv(mmu_idx);
     /* default TLB page size */
     target_ulong tlb_size = TARGET_PAGE_SIZE;
 
-- 
2.25.1


