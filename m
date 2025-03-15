Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD738C28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 06:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttKrt-0003ke-OB; Sat, 15 Mar 2025 02:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKrO-0003Ha-Vr; Sat, 15 Mar 2025 02:19:09 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKrM-0003HO-FQ; Sat, 15 Mar 2025 02:19:02 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8FEDFFF9D7;
 Sat, 15 Mar 2025 09:17:07 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 675511CAC40;
 Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 4568D558C5; Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 11/51] hw/i386/pc: Fix crash that occurs when
 introspecting TYPE_PC_MACHINE machines
Date: Sat, 15 Mar 2025 09:17:17 +0300
Message-Id: <20250315061801.622606-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
References: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

QEMU currently crashes when you try to inspect the machines based on
TYPE_PC_MACHINE for their properties:

 $ echo '{ "execute": "qmp_capabilities" }
         { "execute": "qom-list-properties","arguments":
                      { "typename": "pc-q35-10.0-machine"}}' \
   | ./qemu-system-x86_64 -M pc -qmp stdio
 {"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 9},
  "package": "v9.2.0-1070-g87e115c122-dirty"}, "capabilities": ["oob"]}}
 {"return": {}}
 Segmentation fault (core dumped)

This happens because TYPE_PC_MACHINE machines add a machine_init-
done_notifier in their instance_init function - but instance_init
of machines are not only called for machines that are realized,
but also for machines that are introspected, so in this case the
listener is added for a q35 machine that is never realized. But
since there is already a running pc machine, the listener function
is triggered immediately, causing a crash since it was not for the
right machine it was meant for.

Such listener functions must never be installed from an instance_init
function. Let's do it from pc_basic_device_init() instead - this
function is called from the MachineClass->init() function instead,
i.e. guaranteed to be only called once in the lifetime of a QEMU
process.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2779
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250117192106.471029-1-thuth@redhat.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit de538288e4dac21332cc94ba9727ed8ec8fe5ea1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 317aaca25a..9b89b51b8f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1236,6 +1236,9 @@ void pc_basic_device_init(struct PCMachineState *pcms,
     /* Super I/O */
     pc_superio_init(isa_bus, create_fdctrl, pcms->i8042_enabled,
                     pcms->vmport != ON_OFF_AUTO_ON, &error_fatal);
+
+    pcms->machine_done.notify = pc_machine_done;
+    qemu_add_machine_init_done_notifier(&pcms->machine_done);
 }
 
 void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
@@ -1709,9 +1712,6 @@ static void pc_machine_initfn(Object *obj)
     if (pcmc->pci_enabled) {
         cxl_machine_init(obj, &pcms->cxl_devices_state);
     }
-
-    pcms->machine_done.notify = pc_machine_done;
-    qemu_add_machine_init_done_notifier(&pcms->machine_done);
 }
 
 static void pc_machine_reset(MachineState *machine, ResetType type)
-- 
2.39.5


