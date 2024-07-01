Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0236C30659
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 13:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOGvy-0000FS-0K; Mon, 01 Jul 2024 09:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1sOGvq-0000Ax-FV
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:18:58 -0400
Received: from mail.xenproject.org ([104.130.215.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1sOGvc-0007tv-SI
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=xenproject.org; s=20200302mail; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=gkNFjUBtbqufv33xP12o2+yXIA0IJ1f/YGOBjESYaNM=; b=c9QUtvtEGyfJhIOj8KHL2VGsBm
 FFIrc6peHfVTb62irUS6ZhP79fcx7eIE909mMcF+r7O+7c+aLW+nhzBtl0b7xZ4Vx16oZ47GmPbx7
 olM2yyLo8Q2W8jngMupUiQHHxxoPzisLi8Z73K4ryXuZlLsKcP8DkZY1v9YRyD4PkH0I=;
Received: from xenbits.xenproject.org ([104.239.192.120])
 by mail.xenproject.org with esmtp (Exim 4.92)
 (envelope-from <anthony@xenproject.org>)
 id 1sOGva-0006ne-4k; Mon, 01 Jul 2024 13:18:42 +0000
Received: from lfbn-lyo-1-451-148.w2-7.abo.wanadoo.fr ([2.7.43.148]
 helo=l14.home) by xenbits.xenproject.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <anthony@xenproject.org>)
 id 1sOGvZ-0000WF-SM; Mon, 01 Jul 2024 13:18:42 +0000
From: anthony@xenproject.org
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
Subject: [PULL 1/3] hw/xen: detect when running inside stubdomain
Date: Mon,  1 Jul 2024 15:18:31 +0200
Message-Id: <20240701131833.29486-2-anthony@xenproject.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701131833.29486-1-anthony@xenproject.org>
References: <20240701131833.29486-1-anthony@xenproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=104.130.215.37;
 envelope-from=anthony@xenproject.org; helo=mail.xenproject.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>

Introduce global xen_is_stubdomain variable when qemu is running inside
a stubdomain instead of dom0. This will be relevant for subsequent
patches, as few things like accessing PCI config space need to be done
differently.

Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
Message-Id: <e66aa97dca5120f22e015c19710b2ff04f525720.1711506237.git-series.marmarek@invisiblethingslab.com>
Signed-off-by: Anthony PERARD <anthony@xenproject.org>
---
 hw/i386/xen/xen-hvm.c | 22 ++++++++++++++++++++++
 include/hw/xen/xen.h  |  1 +
 system/globals.c      |  1 +
 3 files changed, 24 insertions(+)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 006d219ad5..4f6446600c 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -584,6 +584,26 @@ static void xen_wakeup_notifier(Notifier *notifier, void *data)
     xc_set_hvm_param(xen_xc, xen_domid, HVM_PARAM_ACPI_S_STATE, 0);
 }
 
+static bool xen_check_stubdomain(struct xs_handle *xsh)
+{
+    char *dm_path = g_strdup_printf(
+        "/local/domain/%d/image/device-model-domid", xen_domid);
+    char *val;
+    int32_t dm_domid;
+    bool is_stubdom = false;
+
+    val = xs_read(xsh, 0, dm_path, NULL);
+    if (val) {
+        if (sscanf(val, "%d", &dm_domid) == 1) {
+            is_stubdom = dm_domid != 0;
+        }
+        free(val);
+    }
+
+    g_free(dm_path);
+    return is_stubdom;
+}
+
 void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory)
 {
     MachineState *ms = MACHINE(pcms);
@@ -596,6 +616,8 @@ void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory)
 
     xen_register_ioreq(state, max_cpus, &xen_memory_listener);
 
+    xen_is_stubdomain = xen_check_stubdomain(state->xenstore);
+
     QLIST_INIT(&xen_physmap);
     xen_read_physmap(state);
 
diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index 37ecc91fc3..ecb89ecfc1 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -36,6 +36,7 @@ enum xen_mode {
 extern uint32_t xen_domid;
 extern enum xen_mode xen_mode;
 extern bool xen_domid_restrict;
+extern bool xen_is_stubdomain;
 
 int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num);
 int xen_set_pci_link_route(uint8_t link, uint8_t irq);
diff --git a/system/globals.c b/system/globals.c
index e353584201..d602a04fa2 100644
--- a/system/globals.c
+++ b/system/globals.c
@@ -60,6 +60,7 @@ bool qemu_uuid_set;
 uint32_t xen_domid;
 enum xen_mode xen_mode = XEN_DISABLED;
 bool xen_domid_restrict;
+bool xen_is_stubdomain;
 struct evtchn_backend_ops *xen_evtchn_ops;
 struct gnttab_backend_ops *xen_gnttab_ops;
 struct foreignmem_backend_ops *xen_foreignmem_ops;
-- 
Anthony PERARD


