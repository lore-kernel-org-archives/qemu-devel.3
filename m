Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDCFCCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 18:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9bv-0002n5-8U; Sat, 17 Oct 2026 14:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9bc-0002UJ-Pv; Sat, 17 Oct 2026 14:58:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9bb-0003o5-05; Sat, 17 Oct 2026 14:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263389; bh=ckQ2TnRzgwn5Uso3kT+FWmC8W2ouGiGbkoqTHfgPbpU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BNMjisxutYG5nt8yiyO8+rFhj3zo09CmLDRsbnNBIGKacQ1MhsnwLc7oSGwuS1Xu3
 NfB3hAMOTM1ls9ISPrpmu5Iq58IpXo3VRbjl6EDC4hqDyuNHQ0TnFkP6MgtxxaQ+Zd
 QEtwg3Ph2B+uvqb8I0jSqLqVRX3nZ4lJFMGLddLu2DbIxo1ghjy7X4++DW0dRBRSPd
 8VcoQ94wMPJYaMF/tr17L93DftEgxht6rOZwpUXhV5T9qQxG3TFZVvl4LopeM0aDOs
 jzVLyXM4YAVYBH8NyrIV5k2FemWS+Hkx3mXMzgwEd7h/46FPnFT/BllsVTB2cZJsyD
 elsH5L2PpfXcw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2721D1DE6BB;
 Sat, 17 Oct 2026 21:56:29 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1CCC9443386;
 Sat, 17 Oct 2026 21:56:28 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Daniel Paziyski <danielpaziyski@gmail.com>,
 Klaus Jensen <k.jensen@samsung.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 27/63] hw/nvme: fix memory leak on sr-iov capable
 nvme controller removal
Date: Sat, 17 Oct 2026 21:54:43 +0300
Message-ID: <20261017185528.722197-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel Paziyski <danielpaziyski@gmail.com>

If a nvme controller is SR-IOV capable, its list of secondary controllers
(virtual functions) is stored in the sec_ctrl_list dynamically allocated
array, located in the NvmeCtrl struct.

Free the secondary controller list after destroying the virtual functions and
freeing their controller IDs.

QEMU command line (boot with a hotunplug-aware OS, such as Linux):

    qemu-system-x86_64 -M q35 -device pcie-root-port,id=rp -monitor stdio \
    -device nvme-subsys,id=subsys0 \
    -device nvme,subsys=subsys0,serial=ctrl0,sriov_max_vfs=1,\
sriov_vq_flexible=2,sriov_vi_flexible=1,max_ioqpairs=4,msix_qsize=2,bus=rp,id=ctrl0

In the QEMU monitor:

    device_del ctrl0
    quit

ASAN splat:

==78982==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x7fcbab32bea9 in calloc (/usr/lib/libasan.so.8+0x12bea9) (BuildId: 7f2845989b820f536270e19ec47df085ae89a675)
    #1 0x7fcbaa2a34b2 in g_malloc0 (/usr/lib/libglib-2.0.so.0+0x694b2) (BuildId: cb17d184459352a7985a010f1cd3acef4a4f90d8)
    #2 0x559c531fff4b in nvme_subsys_register_ctrl ../hw/nvme/subsys.c:65
    #3 0x559c531d715e in nvme_init_subsys ../hw/nvme/ctrl.c:9582
    #4 0x559c531d7a7d in nvme_realize ../hw/nvme/ctrl.c:9637
    #5 0x559c5323c0da in pci_qdev_realize ../hw/pci/pci.c:2316
    #6 0x559c54001e88 in device_set_realized ../hw/core/qdev.c:514
    #7 0x559c5402462e in property_set_bool ../qom/object.c:2484
    #8 0x559c5401dbd2 in object_property_set ../qom/object.c:1548
    #9 0x559c5402b76c in object_property_set_qobject ../qom/qom-qobject.c:28
    #10 0x559c5401e24c in object_property_set_bool ../qom/object.c:1618
    #11 0x559c53fffd77 in qdev_realize ../hw/core/qdev.c:277
    #12 0x559c53934166 in qdev_device_add_from_qdict ../system/qdev-monitor.c:740
    #13 0x559c53934272 in qdev_device_add ../system/qdev-monitor.c:758
    #14 0x559c538867c8 in device_init_func ../system/vl.c:1217
    #15 0x559c5487236a in qemu_opts_foreach ../util/qemu-option.c:1148
    #16 0x559c53891205 in qemu_create_cli_devices ../system/vl.c:2762
    #17 0x559c53891968 in qmp_x_exit_preconfig ../system/vl.c:2822
    #18 0x559c53898108 in qemu_init ../system/vl.c:3862
    #19 0x559c545efabf in main ../system/main.c:71
    #20 0x7fcba7627780  (/usr/lib/libc.so.6+0x27780) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
    #21 0x7fcba76278b8 in __libc_start_main (/usr/lib/libc.so.6+0x278b8) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
    #22 0x559c524df1f4 in _start (BuildId: 35402cb4fc46114b7a4102258726bbdec82cd9bc)

Cc: qemu-stable@nongnu.org
Fixes: c6159d0e384f ("hw/nvme: Allocate sec-ctrl-list as a dynamic array")
Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit 6ee626e34979eae2d3e2318b00f0c340a474dd23)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f5719372f9..60f67741f9 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -9088,6 +9088,10 @@ static void nvme_exit(PCIDevice *pci_dev)
 
     nvme_subsys_unregister_ctrl(n->subsys, n);
 
+    if (!pci_is_vf(pci_dev) && n->params.sriov_max_vfs) {
+        g_free(n->sec_ctrl_list);
+    }
+
     g_free(n->cq);
     g_free(n->sq);
     g_free(n->aer_reqs);
-- 
2.47.3


