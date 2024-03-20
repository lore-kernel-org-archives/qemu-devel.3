Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0B7C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 17:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmzkP-00027q-8I; Wed, 20 Mar 2024 13:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <irina.ryapolova@syntacore.com>)
 id 1rmzkO-00027e-EB; Wed, 20 Mar 2024 13:29:04 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <irina.ryapolova@syntacore.com>)
 id 1rmzkM-0000HR-Ng; Wed, 20 Mar 2024 13:29:04 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 8A579C0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1710955737;
 bh=NgBhcHvA1hJNLG9Q2UzD2GpmFdYNx5LDk1FdSzGkDj8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=IIEAsAa4Q+/PjUgHLPiC44jqV6GLKrorQlGi2oWHOVzeNcAfYxBbYUBxlzqYKNnlg
 v3UBbmYO6ItdIrSmTHciY7Lv99p9ohSNoLKb6Q9PVeLkx59lnMtJYnSIiIXNsr5AtR
 tcXP4/4y8fr7ELcAk7oFRJXA55fVfajqHCC0jvtSs9RUjFTHFnx+K54MHR6nQ7kR84
 kFyygKd9Umirj1OSh7apNXqwK9LKbAY/vMTmZhNLvIBJplKfpugD84Md+u7CpT14PI
 gl5Ssw/f4XRpip7tVnx/UT1w8zJGHgTbyMbCJ4ZPyGBSAHApqS9CRrstEmezQ8Vbnt
 GvdZUDocL1QIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1710955737;
 bh=NgBhcHvA1hJNLG9Q2UzD2GpmFdYNx5LDk1FdSzGkDj8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=WZaWUS2vrZBoyO28W5GGQSZ8BUCPjS74hf0Myxv24jK1nKBBfQO3Ecmdgy8CVTRgb
 Y9mV9Baai3B1k96MfVGrq15WhYAYF83kybh65JI2CbkjQhIQJksWrO3AnMYMGa9TvM
 Vbr08g7eqyoIygAYdFYzGzkLgA1Uzcn+zfYgkCPB8wXwm0hSPRF4WMVCyjT1pI18pZ
 la0X8TUv4AFmg9EkVRDN3s+gWLSBZDeb1Bz5Usun0jsnCKiDZ1QpYRE3QkqeT3IkrG
 6s8vV1QLnqTOOf1QQnwc9gKuWO1KNEW0EB2WPXagdB2wk8kTTrZfJQqoR9VP8BvVeR
 4Z/EOod3pAV0g==
From: Irina Ryapolova <irina.ryapolova@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>, 
 <bin.meng@windriver.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>, Irina Ryapolova
 <irina.ryapolova@syntacore.com>
Subject: [PATCH] target/riscv: Fix mode in riscv_tlb_fill
Date: Wed, 20 Mar 2024 20:28:28 +0300
Message-ID: <20240320172828.23965-1-irina.ryapolova@syntacore.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 S-Exch-01.corp.yadro.com (10.78.5.241)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=irina.ryapolova@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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


