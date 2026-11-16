Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1179606A883
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=kyrZECzh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3Ks-000881-Rt; Mon, 16 Nov 2026 15:29:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3KG-0007X8-LK; Mon, 16 Nov 2026 15:29:17 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3KD-0001bK-Rs; Mon, 16 Nov 2026 15:29:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860765; bh=xcMHoTGieGG8uenYAt0ktN3aAEz0pF2xYVk9Dznafck=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kyrZECzhE5W6VVclZO41GOsDuXq5zacgjZgQotEd/h9XZkTRLQawnZZl9+Tyx4/Fs
 B/xEVeokeDHPPrkdNMIJSKxkKFLfwJDZPefsnQ2W4ENKwxcjoRwO3U6avli0OViQdR
 lyyW4PbaiBBkPGWLOhPogQjy9Dx33gmnrtvAHPt5j3eo/iQPlm9+xVRooA673ciDQO
 rwq0Qi1TdHZ2ZznmHfeZMG5kkiFaJvEvF7adKILTSuQ2CVnyO8cfc+tFPUq8PR6BSr
 Fg7P8p0jseKOtHfVCzeRyxXAocRaWq6b1X9dwFWPol7/HEef0yutqQ1GX3s9yuOaCF
 FWPbFw6RaeQ+g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3ECB21E71B7;
 Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 38C4945FBE3;
 Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 2B31AB8E8A; Mon, 16 Nov 2026 23:26:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Daniel Paziyski <danielpaziyski@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 34/63] pcie_sriov: register user created virtual
 function before realizing it
Date: Mon, 16 Nov 2026 23:25:13 +0300
Message-ID: <20261116202554.535325-34-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daniel Paziyski <danielpaziyski@gmail.com>

There are two ways of creating virtual functions: by using the sriov-pf device
parameter (this way, creating a user created VF and binding it to a PF), or
by using a device specific parameter, where the device manually creates a given
amount of VFs.

When a PCI device is realized, the device specific realize function is called
first, and then the pcie_sriov_register_device function is called, which checks
whether the device that has been created is a user created VF, and if it is the
case and the device allows this kind of VFs, it inserts it into a hashmap, with
the key being the ID of the PF, and the items being arrays of VFs.

User created VFs are instantiated independently, and later, when the PF calls
pcie_sriov_pf_init_from_user_created_vfs, it discovers its VFs from the hashmap
mentioned previously, and sets up in their PCIDevice.ex.sriov_pf structure
the pointer to the PF. This means that, during realization, VFs have no access
to the PF.

Device created VFs are instantiated during or after PF realization using the
pcie_sriov_pf_init function, which sets up for the VFs the pointer to the PF
before their realization, so when they're realized, they can access the PF
with no issues.

The problem here is that pcie_sriov_register_device is called after the
realization, and not before. This means that when a user created VF is created
for a device which does not support user created VFs, but supports device
created VFs, the realize function will notice that a VF is being created, and
may try to access the PF, causing a null pointer dereference fault.

Fix this by placing the user created VF check and registering before the
realization. This way, incorrectly created user created VFs will be noticed,
and device creation will be aborted.

Additionally, remove from the pcie_sriov_register_device function the top
check. It seems that this check is done to error out if the PF failed for some
reason to initialize its list of user created VFs. However, in such situations,
the pcie_sriov_pf_init_from_user_created_vfs function will error during
realization, and it will be caught before the check is done at all. Moreover,
since now pcie_sriov_register_device is called before realization, the check
will always fail for PFs with user created VFs, because the list will be
populated during realization.

The rest of the function though, correctly errors out if a user created VF
is created for an unsupported device type, if a VF is created for a non-PCIe
device, or if the PF is already instantiated, with now the advantage being
that the check is done before the VF instantiation.

Moreover, move the unregistering of a device's acpi-index and the removal
of a VF from its PF list from pci_qdev_unrealize to do_pci_unregister_device.
We do the former so that the acpi-index is unclaimed on user created VF
creation error, and the latter to not have extra code on the device specific
realization error path.

When instantiating a user created VF for a NVME controller:

Command line:

    qemu-system-x86_64 -device nvme-subsys,id=subsys0 \
    -device nvme,id=vctrl0,sriov-pf=ctrl0,subsys=subsys0 \
    -device nvme,id=ctrl0,subsys=subsys0,serial=s

ASAN splat:

../hw/nvme/ctrl.c:9613:28: runtime error: member access within null pointer of type 'struct NvmeCtrl'
AddressSanitizer:DEADLYSIGNAL
=================================================================
==91050==ERROR: AddressSanitizer: SEGV on unknown address 0x000000001cf0 (pc 0x7f79a8573dcd bp 0x7ffd622c1bc0 sp 0x7ffd622c1b68 T0)
==91050==The signal is caused by a READ memory access.
    #0 0x7f79a8573dcd  (/usr/lib/libc.so.6+0x173dcd) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
    #1 0x5644c6c0266e in nvme_realize ../hw/nvme/ctrl.c:9613
    #2 0x5644c6c67213 in pci_qdev_realize ../hw/pci/pci.c:2316
    #3 0x5644c7a2cfc1 in device_set_realized ../hw/core/qdev.c:514
    #4 0x5644c7a4f767 in property_set_bool ../qom/object.c:2484
    #5 0x5644c7a48d0b in object_property_set ../qom/object.c:1548
    #6 0x5644c7a568a5 in object_property_set_qobject ../qom/qom-qobject.c:28
    #7 0x5644c7a49385 in object_property_set_bool ../qom/object.c:1618
    #8 0x5644c7a2aeb0 in qdev_realize ../hw/core/qdev.c:277
    #9 0x5644c735f29f in qdev_device_add_from_qdict ../system/qdev-monitor.c:740
    #10 0x5644c735f3ab in qdev_device_add ../system/qdev-monitor.c:758
    #11 0x5644c72b1901 in device_init_func ../system/vl.c:1217
    #12 0x5644c829d4a3 in qemu_opts_foreach ../util/qemu-option.c:1148
    #13 0x5644c72bc33e in qemu_create_cli_devices ../system/vl.c:2762
    #14 0x5644c72bcaa1 in qmp_x_exit_preconfig ../system/vl.c:2822
    #15 0x5644c72c3241 in qemu_init ../system/vl.c:3862
    #16 0x5644c801abf8 in main ../system/main.c:71
    #17 0x7f79a8427780  (/usr/lib/libc.so.6+0x27780) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
    #18 0x7f79a84278b8 in __libc_start_main (/usr/lib/libc.so.6+0x278b8) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
    #19 0x5644c5f0a1f4 in _start (BuildId: 8483f952216d9e345c3744300d0aefa38feb50d7)

==91050==Register values:
rax = 0x00007e49988640f0  rbx = 0x00007e49988640f0  rcx = 0x00000fc9b3104828  rdx = 0x0000000000000058
rdi = 0x00007e49988640f0  rsi = 0x0000000000001cf0  rbp = 0x00007ffd622c1bc0  rsp = 0x00007ffd622c1b68
 r8 = 0x00000fc9b3104829   r9 = 0x00000fc9b3104828  r10 = 0x00000fc9b310481e  r11 = 0x00000fc9b310481e
r12 = 0x0000000000001cf0  r13 = 0x00000f6f32e78578  r14 = 0x00000000ffffffff  r15 = 0x00007ffd622c1c10
AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV (/usr/lib/libc.so.6+0x173dcd) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
==91050==ABORTING

Cc: qemu-stable@nongnu.org
Fixes: 19e55471d4e8 ("pcie_sriov: Allow user to create SR-IOV device")
Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
Message-ID: <20260905122924.53813-1-danielpaziyski@gmail.com>
(cherry picked from commit 432ea8cc7d2734ab026889c4075b2f6c47741fe6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index d3191609e28..d4187293b1f 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1214,6 +1214,19 @@ static void pci_config_free(PCIDevice *pci_dev)
     g_free(pci_dev->used);
 }
 
+static void pci_unregister_acpi_index(PCIDevice *pci_dev)
+{
+    if (pci_dev->acpi_index) {
+        GSequence *used_indexes = pci_acpi_index_list();
+
+        g_sequence_remove(g_sequence_lookup(used_indexes,
+                          GINT_TO_POINTER(pci_dev->acpi_index),
+                          g_cmp_uint32, NULL));
+
+        pci_dev->acpi_index = 0;
+    }
+}
+
 static void do_pci_unregister_device(PCIDevice *pci_dev)
 {
     pci_get_bus(pci_dev)->devices[pci_dev->devfn] = NULL;
@@ -1227,6 +1240,9 @@ static void do_pci_unregister_device(PCIDevice *pci_dev)
                                     &pci_dev->bus_master_enable_region);
     }
     address_space_destroy(&pci_dev->bus_master_as);
+
+    pcie_sriov_unregister_device(pci_dev);
+    pci_unregister_acpi_index(pci_dev);
 }
 
 /* Extract PCIReqIDCache into BDF format */
@@ -1478,7 +1494,6 @@ static void pci_qdev_unrealize(DeviceState *dev)
 
     pci_unregister_io_regions(pci_dev);
     pci_del_option_rom(pci_dev);
-    pcie_sriov_unregister_device(pci_dev);
 
     if (pc->exit) {
         pc->exit(pci_dev);
@@ -1488,17 +1503,6 @@ static void pci_qdev_unrealize(DeviceState *dev)
     do_pci_unregister_device(pci_dev);
 
     pci_dev->msi_trigger = NULL;
-
-    /*
-     * clean up acpi-index so it could reused by another device
-     */
-    if (pci_dev->acpi_index) {
-        GSequence *used_indexes = pci_acpi_index_list();
-
-        g_sequence_remove(g_sequence_lookup(used_indexes,
-                          GINT_TO_POINTER(pci_dev->acpi_index),
-                          g_cmp_uint32, NULL));
-    }
 }
 
 void pci_register_bar(PCIDevice *pci_dev, int region_num,
@@ -2309,8 +2313,15 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
     pci_dev = do_pci_register_device(pci_dev,
                                      object_get_typename(OBJECT(qdev)),
                                      pci_dev->devfn, errp);
-    if (pci_dev == NULL)
+    if (pci_dev == NULL) {
+        pci_unregister_acpi_index(pci_dev);
         return;
+    }
+
+    if (!pcie_sriov_register_device(pci_dev, errp)) {
+        do_pci_unregister_device(pci_dev);
+        return;
+    }
 
     if (pc->realize) {
         pc->realize(pci_dev, &local_err);
@@ -2321,11 +2332,6 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         }
     }
 
-    if (!pcie_sriov_register_device(pci_dev, errp)) {
-        pci_qdev_unrealize(DEVICE(pci_dev));
-        return;
-    }
-
     /*
      * A PCIe Downstream Port that do not have ARI Forwarding enabled must
      * associate only Device 0 with the device attached to the bus
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index c41ac95beea..69930c7b8cc 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -357,12 +357,6 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
 
 bool pcie_sriov_register_device(PCIDevice *dev, Error **errp)
 {
-    if (!dev->exp.sriov_pf.vf && dev->qdev.id &&
-        pfs && g_hash_table_contains(pfs, dev->qdev.id)) {
-        error_setg(errp, "attaching user-created SR-IOV VF unsupported");
-        return false;
-    }
-
     if (dev->sriov_pf) {
         PCIDevice *pci_pf;
         GPtrArray *pf;
-- 
2.47.3


