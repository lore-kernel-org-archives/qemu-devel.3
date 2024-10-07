Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35033CFB442
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 11:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxls9-0007Mu-3W; Mon, 07 Oct 2024 07:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>) id 1sxls2-0007MY-PN
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:25:46 -0400
Received: from mail-m16.yeah.net ([220.197.32.17])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chao.liu@yeah.net>) id 1sxls0-0001BJ-Pg
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=QHbPa
 lvgpRBsIV4AzKxJkAd/59RTOeVHtbo41YQVKiY=; b=F1cZIgRuKCtf+GQyG/J7v
 N3Q1kFXcNCq02DmbVD8ZQPNk9SbFOuI3ysjqv+I9WxwG89DGDEiXbVBQTHQDq9eu
 4fpKcjZTQtRUXcPOZW0UjzTbLh6+Okb0L6ugHr0JF6jsltyBQseKfkB+rufrTPfA
 J38dWu90g9DO+amBYeu19M=
Received: from localhost.localdomain (unknown [])
 by gzsmtp3 (Coremail) with SMTP id M88vCgAnSOcMxQNnGGjGAQ--.32547S5;
 Mon, 07 Oct 2024 19:25:01 +0800 (CST)
From: Chao Liu <chao.liu@yeah.net>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, bin.meng@windriver.com, edgar.iglesias@gmail.com,
 alistair@alistair23.me, Chao Liu <chao.liu@yeah.net>
Subject: [PATCH v4 3/3] xilink-zynq-devcfg: Avoid disabling devcfg memory
 region during initialization
Date: Mon,  7 Oct 2024 19:24:55 +0800
Message-ID: <bcdacdcbf7b26192aebe4723c57bd87ef986defa.1728299530.git.chao.liu@yeah.net>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1728299530.git.chao.liu@yeah.net>
References: <cover.1728299530.git.chao.liu@yeah.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: M88vCgAnSOcMxQNnGGjGAQ--.32547S5
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw1xZFW8GrW8tw43GFWkXrb_yoWktrg_Ca
 yFkF93ursxAw1Syas0yr1qyryfuw4vvr10gFn7t3s3tFyUWrsxGrsYy3ZYqw1kX3y5Arsx
 Za4jkFnxAa13ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU87l1PUUUUU==
X-Originating-IP: [112.19.146.115]
X-CM-SenderInfo: pfkd0hxolxq5hhdkh0dhw/1tbiERNxKGcDw+gCUgAAsE
Received-SPF: pass client-ip=220.197.32.17; envelope-from=chao.liu@yeah.net;
 helo=mail-m16.yeah.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

During the initialization phase, we've encountered an issue where the
UNLOCK register is inadvertently cleared. This results in devcfg MR being
disabled, which in turn leads to unexpected memory access exceptions when
attempting subsequent accesses to the devcfg register. This behavior is not
consistent with the hardware specifications.

This bug was not found earlier because the ignore_memory_transaction_failures
flag was enabled, which ignored exceptions from devcfg devices
when access was disabled.

Signed-off-by: Chao Liu <chao.liu@yeah.net>
---
 hw/dma/xlnx-zynq-devcfg.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index e5eff9abc0..af8cc72471 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -144,7 +144,12 @@ static void xlnx_zynq_devcfg_reset(DeviceState *dev)
     int i;
 
     for (i = 0; i < XLNX_ZYNQ_DEVCFG_R_MAX; ++i) {
-        register_reset(&s->regs_info[i]);
+        if (s->regs_info[i].access) {
+            if (s->regs_info[i].access->addr == A_UNLOCK) {
+                continue;
+            }
+            register_reset(&s->regs_info[i]);
+        }
     }
 }
 
-- 
2.46.1


