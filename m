Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5030DC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 17:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTQ4Y-00074I-0q; Fri, 26 Jan 2024 12:32:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+7caeb094913322f6f00d+7460+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rTQ4M-000714-Ii; Fri, 26 Jan 2024 12:32:46 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+7caeb094913322f6f00d+7460+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rTQ4K-0001cX-F3; Fri, 26 Jan 2024 12:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=qZJ5znInl8VUzkg42vOEqkv8s7zoSUtbb4o7syIWshQ=; b=T/KFiNP0VoNy+dRDdUz85cVgqC
 d/xsD7bmL6yqgL5czKhzPlpCBdR4zMQ2tljn2inOKua253TIuXA5aleREh4omvZTb3lt5AE6FlLt4
 FD5YLv2vx2lzct3UExbehtseqGJJrJBDqR6snT8lfXZhph3EQ38ZvTVzWpVFSvIXAjBrno+N4mQCE
 6R/ethD97GGg1zQZEHFRl8VgWn0E79TwsyXQQe/4MlkzaLtMe8t2jP8icT93CfLgznQuh9IE9U1bp
 NolX4B5CEASRxWu1Ajg1aLzK3NEbQVSQQe61d6hOrsipftq5dBATnnjcGmpap6RNwzZrUayjzYQhh
 Y1TBCnVw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1rTQ48-0000000EKUb-3N6A; Fri, 26 Jan 2024 17:32:34 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rTQ49-00000001enH-2xlx;
 Fri, 26 Jan 2024 17:32:33 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rob Herring <robh@kernel.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Helge Deller <deller@gmx.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Song Gao <gaosong@loongson.cn>, Thomas Huth <huth@tuxfamily.org>,
 Laurent Vivier <laurent@vivier.eu>, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jason Wang <jasowang@redhat.com>,
 Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v4 31/47] hw/net/etraxfs-eth: use qemu_configure_nic_device()
Date: Fri, 26 Jan 2024 17:25:08 +0000
Message-ID: <20240126173228.394202-32-dwmw2@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126173228.394202-1-dwmw2@infradead.org>
References: <20240126173228.394202-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+7caeb094913322f6f00d+7460+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
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


