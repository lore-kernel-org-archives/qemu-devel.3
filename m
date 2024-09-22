Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C16CF9C6C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 14:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssNpW-0006Jq-5M; Sun, 22 Sep 2024 10:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>) id 1ssMaG-0002wW-Bi
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 09:25:04 -0400
Received: from mail-m16.yeah.net ([220.197.32.18])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chao.liu@yeah.net>) id 1ssMaA-00030E-3C
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 09:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=Blphx
 XN4un5YW9VRPae4/DTWRYrwXOalOhZwPQUcgHY=; b=MxCCIprcFCdJdWZ9ud5jh
 mLX+cuZ94DPwlVA63YONsc4nqmUZ4Hgn6C8QW3/PDmiH07R7Sg9/hyDk1XFyGkOm
 snBGQ5TLzzxUfTtuI2SbxFpPWmJg17vNhrQ2DClwhf8XyodzgugLK70B83FA9wSD
 Q88IzlKDivwQkoINXAZ0BU=
Received: from localhost.localdomain (unknown [])
 by gzsmtp1 (Coremail) with SMTP id Mc8vCgAH56yXGvBmHbLdAA--.24843S4;
 Sun, 22 Sep 2024 21:24:40 +0800 (CST)
From: Chao Liu <chao.liu@yeah.net>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, bin.meng@windriver.com, edgar.iglesias@gmail.com,
 alistair@alistair23.me, Chao Liu <chao.liu@yeah.net>
Subject: [PATCH v1 2/2] xilink-zynq-devcfg: Fix up for memory address range
 size not set correctly
Date: Sun, 22 Sep 2024 21:24:33 +0800
Message-ID: <6b113649cdde1e8938393b859601dfeaba79d9af.1727008203.git.chao.liu@yeah.net>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1727008203.git.chao.liu@yeah.net>
References: <cover.1727008203.git.chao.liu@yeah.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Mc8vCgAH56yXGvBmHbLdAA--.24843S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrWr4kCw47CF1ftFy5Jr4Utwb_yoWxXrg_C3
 45Aay3Wr4DJr4UZwnYyrW8tr1SvwnYkr1SgF1jk34DXF4UGF4fZr45t3Wvq3Z7X3yUCrsx
 uF129F9rXay5XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnPEfUUUUUU==
X-Originating-IP: [117.173.244.102]
X-CM-SenderInfo: pfkd0hxolxq5hhdkh0dhw/1tbiCRBiKGbv+gM4wQAAsa
Received-SPF: pass client-ip=220.197.32.18; envelope-from=chao.liu@yeah.net;
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
X-Mailman-Approved-At: Sun, 22 Sep 2024 10:44:51 -0400
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
 hw/dma/xlnx-zynq-devcfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index b8544d0731..7170353a62 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -372,7 +372,7 @@ static void xlnx_zynq_devcfg_init(Object *obj)
                               s->regs_info, s->regs,
                               &xlnx_zynq_devcfg_reg_ops,
                               XLNX_ZYNQ_DEVCFG_ERR_DEBUG,
-                              XLNX_ZYNQ_DEVCFG_R_MAX);
+                              XLNX_ZYNQ_DEVCFG_R_MAX * 4);
     memory_region_add_subregion(&s->iomem,
                                 A_CTRL,
                                 &reg_array->mem);
-- 
2.46.1


