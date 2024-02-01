Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EBCC48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 16:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVaB1-0002tb-P9; Thu, 01 Feb 2024 11:44:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+1220c4869a9b484313cc+7466+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1rVaAq-0002ql-Ug
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:25 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+1220c4869a9b484313cc+7466+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1rVaAm-0002Ss-8i
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
 Cc:Content-Type:Content-ID:Content-Description;
 bh=g6ItrTH6xUERJPwo+cm9fCEJutLCoak9PKJqL8zqcI4=; b=c+inkfXLw6SLtGwj6q+ZPhgFmH
 l/alEf3s8a6oHniM3Q6x0cYlCOjMlDH1xopwZ9tA/rGdtgEHe0dSc5z6aJEw6PDG8S9RVXT6W85y5
 +e+hHQKinAgQCGwJTx9CIFKQtcmuWl36v/+CcJJHmgxgud+K/h5SBYZTddRkNhQKfrY62BWwLdBr/
 KAqqGMUdQyjsmzbnZn+0ubOANxWtOdjTNzsEVVdf5HyeEhHvW2nZIrhOogx0vyACW+U+QbRy3lKFE
 xmeDWEjKRlUTZtHI+TkUnlrxD30BkHMN4w1TIxB+C9e0gBWqwFvUGGXB0M+tmQoNrU1RjSk33XOeI
 W59nvlOw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1rVaAg-00000009cM4-0sa7 for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:14 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rVaAf-00000003IMm-3d5L for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:13 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/47] hw/ppc/prep: use pci_init_nic_devices()
Date: Thu,  1 Feb 2024 16:43:40 +0000
Message-ID: <20240201164412.785520-16-dwmw2@infradead.org>
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

Previously, the first PCI NIC would be placed in PCI slot 3 and the rest
would be dynamically assigned. Even if the user overrode the default NIC
type and made it something other than PCNet.

Now, the first PCNet NIC (that is, anything not explicitly specified
to be anything different) will go to slot 3 even if it isn't the first
NIC specified on the command line. And anything else will be dynamically
assigned.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/ppc/prep.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 137276bcb9..1a6cd05c61 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -241,7 +241,6 @@ static void ibm_40p_init(MachineState *machine)
     ISADevice *isa_dev;
     ISABus *isa_bus;
     void *fw_cfg;
-    int i;
     uint32_t kernel_base = 0, initrd_base = 0;
     long kernel_size = 0, initrd_size = 0;
     char boot_device;
@@ -336,10 +335,9 @@ static void ibm_40p_init(MachineState *machine)
         /* XXX: s3-trio at PCI_DEVFN(2, 0) */
         pci_vga_init(pci_bus);
 
-        for (i = 0; i < nb_nics; i++) {
-            pci_nic_init_nofail(&nd_table[i], pci_bus, mc->default_nic,
-                                i == 0 ? "3" : NULL);
-        }
+        /* First PCNET device at PCI_DEVFN(3, 0) */
+        pci_init_nic_in_slot(pci_bus, mc->default_nic, NULL, "3");
+        pci_init_nic_devices(pci_bus, mc->default_nic);
     }
 
     /* Prepare firmware configuration for OpenBIOS */
-- 
2.43.0


