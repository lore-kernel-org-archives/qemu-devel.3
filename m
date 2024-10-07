Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F39BCFB441
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 11:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxlrf-0007K4-BF; Mon, 07 Oct 2024 07:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>) id 1sxlrd-0007Jb-7F
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:25:21 -0400
Received: from mail-m16.yeah.net ([220.197.32.19])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chao.liu@yeah.net>) id 1sxlra-00017L-BC
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=j8JGe
 VrEPqzdZxC+Tmy1C79Dx7GTnRrE5+UzOdK9WWU=; b=D9D7UQiL1MKUK0zsTV4L5
 MwLjd/UVnv+F47ovKjRKkNjTmgqQ6Atl5/WnrlE+/NU7L6/XMfJBu9nJ2Iv48kx7
 7/83nx8Pu4DKATETrXqVJ8swON6Z+Xeo2XmlflURwgUdu9x+96LAxE1Ww6lJTyMQ
 61w+8pu8KrzW+mrW9HSJac=
Received: from localhost.localdomain (unknown [])
 by gzsmtp3 (Coremail) with SMTP id M88vCgAnSOcMxQNnGGjGAQ--.32547S4;
 Mon, 07 Oct 2024 19:25:00 +0800 (CST)
From: Chao Liu <chao.liu@yeah.net>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, bin.meng@windriver.com, edgar.iglesias@gmail.com,
 alistair@alistair23.me, Chao Liu <chao.liu@yeah.net>
Subject: [PATCH v4 2/3] xilink-zynq-devcfg: Fix up for memory address range
 size not set correctly
Date: Mon,  7 Oct 2024 19:24:54 +0800
Message-ID: <fbaff99d74262f52fe62696fe08d617296f6ea1a.1728299530.git.chao.liu@yeah.net>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1728299530.git.chao.liu@yeah.net>
References: <cover.1728299530.git.chao.liu@yeah.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: M88vCgAnSOcMxQNnGGjGAQ--.32547S4
X-Coremail-Antispam: 1Uf129KBjvJXoWrZw17Zw1fKr1kAFyxAFy7Wrg_yoW8Jry3pF
 n8XFnavrW8tr1kA3ZxK3WxK3W5Za4DKa18G347Jas0yF13JryxZFy8X3ZrKasF9rZ3JF40
 gFZrZFWayrZ3XrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jSAp5UUUUU=
X-Originating-IP: [112.19.146.115]
X-CM-SenderInfo: pfkd0hxolxq5hhdkh0dhw/1tbiEg1xKGcDw+8CSQAAsF
Received-SPF: pass client-ip=220.197.32.19; envelope-from=chao.liu@yeah.net;
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

Signed-off-by: Chao Liu <chao.liu@yeah.net>
---
 hw/dma/xlnx-zynq-devcfg.c         | 2 +-
 include/hw/dma/xlnx-zynq-devcfg.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index b8544d0731..e5eff9abc0 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -365,7 +365,7 @@ static void xlnx_zynq_devcfg_init(Object *obj)
 
     sysbus_init_irq(sbd, &s->irq);
 
-    memory_region_init(&s->iomem, obj, "devcfg", XLNX_ZYNQ_DEVCFG_R_MAX * 4);
+    memory_region_init(&s->iomem, obj, "devcfg", XLNX_ZYNQ_DEVCFG_R_MAX);
     reg_array =
         register_init_block32(DEVICE(obj), xlnx_zynq_devcfg_regs_info,
                               ARRAY_SIZE(xlnx_zynq_devcfg_regs_info),
diff --git a/include/hw/dma/xlnx-zynq-devcfg.h b/include/hw/dma/xlnx-zynq-devcfg.h
index e4cf085d70..fc26132069 100644
--- a/include/hw/dma/xlnx-zynq-devcfg.h
+++ b/include/hw/dma/xlnx-zynq-devcfg.h
@@ -35,7 +35,7 @@
 
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxZynqDevcfg, XLNX_ZYNQ_DEVCFG)
 
-#define XLNX_ZYNQ_DEVCFG_R_MAX (0x100 / 4)
+#define XLNX_ZYNQ_DEVCFG_R_MAX 0x100
 
 #define XLNX_ZYNQ_DEVCFG_DMA_CMD_FIFO_LEN 10
 
-- 
2.46.1


