Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71716C47DDB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 17:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTQ5M-0008SB-O7; Fri, 26 Jan 2024 12:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+7caeb094913322f6f00d+7460+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rTQ5C-0008Dq-JL; Fri, 26 Jan 2024 12:33:38 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+7caeb094913322f6f00d+7460+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rTQ58-0001ci-EM; Fri, 26 Jan 2024 12:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=aYJS/1ZmHvWqcX4ZFiiuaV9MoKjFfmvD/b97zwR6RTs=; b=D64f2o9ExjTpXRh6lNheHhod11
 XLpJhKTr1/lZ/clcWVHv+r0qH+hO9IuX+5OCKW5QJDKRgIlMeO3iBkxLep82231pjtiQUg/SOyZ+3
 kjhYLEKlDpIMgbFMrc8eYUxT4T8BGApCoyxV8aAB2/qvZUVpaASy7tZZMOxv7/BwJeSYZ/WieflzD
 /vCQ5+IuDJHnHL+ksoy+2BpeR5ZcOp5mCPGHs8j+26cZsHFYatY5+TeRVWxRD3Ho5bnXnogPiHuc8
 WSVGXMZp17QLskVWHPyiskERlqsA36ZvCQf/XY5SJw5rEWhvHK2BKKZ4JwepyYFw8DtXSoYj/1ob7
 vYN8tDSQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1rTQ48-0000000EKUE-0fRh; Fri, 26 Jan 2024 17:32:33 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rTQ47-00000001elS-1KpR;
 Fri, 26 Jan 2024 17:32:31 +0000
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
 xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v4 05/47] hw/i386/pc: use qemu_get_nic_info() and
 pci_init_nic_devices()
Date: Fri, 26 Jan 2024 17:24:42 +0000
Message-ID: <20240126173228.394202-6-dwmw2@infradead.org>
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

Eliminate direct access to nd_table[] and nb_nics by processing the the
Xen and ISA NICs first and then calling pci_init_nic_devices() for the
rest.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 hw/i386/pc.c                | 31 +++++++++++++++++++------------
 include/hw/net/ne2000-isa.h |  2 --
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 803244e5cc..ebb0b1c667 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -654,15 +654,19 @@ static const int ne2000_io[NE2000_NB_MAX] = { 0x300, 0x320, 0x340, 0x360,
                                               0x280, 0x380 };
 static const int ne2000_irq[NE2000_NB_MAX] = { 9, 10, 11, 3, 4, 5 };
 
-static void pc_init_ne2k_isa(ISABus *bus, NICInfo *nd)
+static gboolean pc_init_ne2k_isa(ISABus *bus, NICInfo *nd, Error **errp)
 {
     static int nb_ne2k = 0;
 
-    if (nb_ne2k == NE2000_NB_MAX)
-        return;
+    if (nb_ne2k == NE2000_NB_MAX) {
+        error_setg(errp,
+                   "maximum number of ISA NE2000 devices exceeded");
+        return false;
+    }
     isa_ne2000_init(bus, ne2000_io[nb_ne2k],
                     ne2000_irq[nb_ne2k], nd);
     nb_ne2k++;
+    return true;
 }
 
 void pc_acpi_smi_interrupt(void *opaque, int irq, int level)
@@ -1297,23 +1301,26 @@ void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus,
                  BusState *xen_bus)
 {
     MachineClass *mc = MACHINE_CLASS(pcmc);
-    int i;
+    bool default_is_ne2k = g_str_equal(mc->default_nic, TYPE_ISA_NE2000);
+    NICInfo *nd;
 
     rom_set_order_override(FW_CFG_ORDER_OVERRIDE_NIC);
-    for (i = 0; i < nb_nics; i++) {
-        NICInfo *nd = &nd_table[i];
-        const char *model = nd->model ? nd->model : mc->default_nic;
 
-        if (xen_bus && (!nd->model || g_str_equal(model, "xen-net-device"))) {
+    if (xen_bus) {
+        while ((nd = qemu_find_nic_info("xen-net-device", true, NULL))) {
             DeviceState *dev = qdev_new("xen-net-device");
             qdev_set_nic_properties(dev, nd);
             qdev_realize_and_unref(dev, xen_bus, &error_fatal);
-        } else if (g_str_equal(model, "ne2k_isa")) {
-            pc_init_ne2k_isa(isa_bus, nd);
-        } else {
-            pci_nic_init_nofail(nd, pci_bus, model, NULL);
         }
     }
+
+    while ((nd = qemu_find_nic_info(TYPE_ISA_NE2000, default_is_ne2k, NULL))) {
+        pc_init_ne2k_isa(isa_bus, nd, &error_fatal);
+    }
+
+    /* Anything remaining should be a PCI NIC */
+    pci_init_nic_devices(pci_bus, mc->default_nic);
+
     rom_reset_order_override();
 }
 
diff --git a/include/hw/net/ne2000-isa.h b/include/hw/net/ne2000-isa.h
index af59ee0b02..73bae10ad1 100644
--- a/include/hw/net/ne2000-isa.h
+++ b/include/hw/net/ne2000-isa.h
@@ -22,8 +22,6 @@ static inline ISADevice *isa_ne2000_init(ISABus *bus, int base, int irq,
 {
     ISADevice *d;
 
-    qemu_check_nic_model(nd, "ne2k_isa");
-
     d = isa_try_new(TYPE_ISA_NE2000);
     if (d) {
         DeviceState *dev = DEVICE(d);
-- 
2.43.0


