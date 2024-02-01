Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D24C4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 16:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVaCb-0004Jb-Bp; Thu, 01 Feb 2024 11:46:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+1220c4869a9b484313cc+7466+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1rVaB7-0002yX-OC
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:42 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+1220c4869a9b484313cc+7466+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1rVaAv-0002V0-Fr
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
 Cc:Content-Type:Content-ID:Content-Description;
 bh=qZJ5znInl8VUzkg42vOEqkv8s7zoSUtbb4o7syIWshQ=; b=K1kMAqPPnWYvrh6WYsADaHmQEG
 B/Z59qM5EltBywto1ODQXc7mb/fvPxTJPwd2ocufkPYo+/59g1mnFMoHg0QpVfqAwIwaGXrDUkEJ5
 KVZ3BxLDKWkk39nDkeJKj/pEs5CCNWGC7qFCUY4UkTbOGYuihIbQZlk4rJRYnRDkMVHyAoE4nBMWB
 OlpUulzreDLY+1Ll53jq5V9kkKcgo/snEsqARONQdO8XQMHemllbTchLt6OsOvUdGDmf4ifo7jt+0
 1/ITatLUVJqia09c5JphlFjlXZJZolxFxhgghzPsoZ4NLmO3I8OlhJaffGMcP3FBGSw52rJHv48bX
 TrTaqkVQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1rVaAh-00000009cMA-1xzF for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:15 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rVaAg-00000003INw-20d9 for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:14 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/47] hw/net/etraxfs-eth: use qemu_configure_nic_device()
Date: Thu,  1 Feb 2024 16:43:56 +0000
Message-ID: <20240201164412.785520-32-dwmw2@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201164412.785520-1-dwmw2@infradead.org>
References: <20240201164412.785520-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+1220c4869a9b484313cc+7466+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/cris/axis_dev88.c      | 9 ++++-----
 hw/net/etraxfs_eth.c      | 5 ++---
 include/hw/cris/etraxfs.h | 2 +-
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/cris/axis_dev88.c b/hw/cris/axis_dev88.c
index d82050d927..5556634921 100644
--- a/hw/cris/axis_dev88.c
+++ b/hw/cris/axis_dev88.c
@@ -308,15 +308,14 @@ void axisdev88_init(MachineState *machine)
 
     /* Add the two ethernet blocks.  */
     dma_eth = g_malloc0(sizeof dma_eth[0] * 4); /* Allocate 4 channels.  */
-    etraxfs_eth_init(&nd_table[0], 0x30034000, 1, &dma_eth[0], &dma_eth[1]);
-    if (nb_nics > 1) {
-        etraxfs_eth_init(&nd_table[1], 0x30036000, 2, &dma_eth[2], &dma_eth[3]);
-    }
 
+    etraxfs_eth_init(0x30034000, 1, &dma_eth[0], &dma_eth[1]);
     /* The DMA Connector block is missing, hardwire things for now.  */
     etraxfs_dmac_connect_client(etraxfs_dmac, 0, &dma_eth[0]);
     etraxfs_dmac_connect_client(etraxfs_dmac, 1, &dma_eth[1]);
-    if (nb_nics > 1) {
+
+    if (qemu_find_nic_info("etraxfs-eth", true, "fseth")) {
+        etraxfs_eth_init(0x30036000, 2, &dma_eth[2], &dma_eth[3]);
         etraxfs_dmac_connect_client(etraxfs_dmac, 6, &dma_eth[2]);
         etraxfs_dmac_connect_client(etraxfs_dmac, 7, &dma_eth[3]);
     }
diff --git a/hw/net/etraxfs_eth.c b/hw/net/etraxfs_eth.c
index ba57a978d1..5faf20c782 100644
--- a/hw/net/etraxfs_eth.c
+++ b/hw/net/etraxfs_eth.c
@@ -647,15 +647,14 @@ static void etraxfs_eth_class_init(ObjectClass *klass, void *data)
 
 /* Instantiate an ETRAXFS Ethernet MAC.  */
 DeviceState *
-etraxfs_eth_init(NICInfo *nd, hwaddr base, int phyaddr,
+etraxfs_eth_init(hwaddr base, int phyaddr,
                  struct etraxfs_dma_client *dma_out,
                  struct etraxfs_dma_client *dma_in)
 {
     DeviceState *dev;
-    qemu_check_nic_model(nd, "fseth");
 
     dev = qdev_new("etraxfs-eth");
-    qdev_set_nic_properties(dev, nd);
+    qemu_configure_nic_device(dev, true, "fseth");
     qdev_prop_set_uint32(dev, "phyaddr", phyaddr);
 
     /*
diff --git a/include/hw/cris/etraxfs.h b/include/hw/cris/etraxfs.h
index 467b529dc0..012c4e9974 100644
--- a/include/hw/cris/etraxfs.h
+++ b/include/hw/cris/etraxfs.h
@@ -31,7 +31,7 @@
 #include "hw/sysbus.h"
 #include "qapi/error.h"
 
-DeviceState *etraxfs_eth_init(NICInfo *nd, hwaddr base, int phyaddr,
+DeviceState *etraxfs_eth_init(hwaddr base, int phyaddr,
                               struct etraxfs_dma_client *dma_out,
                               struct etraxfs_dma_client *dma_in);
 
-- 
2.43.0


