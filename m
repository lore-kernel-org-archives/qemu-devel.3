Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80894CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSJU-0000X7-53; Wed, 10 Apr 2024 03:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSJG-00005c-Di; Wed, 10 Apr 2024 03:23:59 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSJD-0003xN-K8; Wed, 10 Apr 2024 03:23:54 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 623255D67D;
 Wed, 10 Apr 2024 10:25:03 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id EE521B02BE;
 Wed, 10 Apr 2024 10:23:04 +0300 (MSK)
Received: (nullmailer pid 4191687 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 akihiko.odaki@daynix.com, Jason Wang <jasowang@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 14/87] igb: fix link state on resume
Date: Wed, 10 Apr 2024 10:21:47 +0300
Message-Id: <20240410072303.4191455-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Laurent Vivier <lvivier@redhat.com>

On resume igb_vm_state_change() always calls igb_autoneg_resume()
that sets link_down to false, and thus activates the link even
if we have disabled it.

The problem can be reproduced starting qemu in paused state (-S) and
then set the link to down. When we resume the machine the link appears
to be up.

Reproducer:

   # qemu-system-x86_64 ... -device igb,netdev=netdev0,id=net0 -S

   {"execute": "qmp_capabilities" }
   {"execute": "set_link", "arguments": {"name": "net0", "up": false}}
   {"execute": "cont" }

To fix the problem, merge the content of igb_vm_state_change()
into igb_core_post_load() as e1000 does.

Buglink: https://issues.redhat.com/browse/RHEL-21867
Fixes: 3a977deebe6b ("Intrdocue igb device emulation")
Cc: akihiko.odaki@daynix.com
Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 65c2ab808571dcd9322020690a63df63281a67f0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 2a7a11aa9e..bcd5f6cd9c 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -160,14 +160,6 @@ igb_intmgr_timer_resume(IGBIntrDelayTimer *timer)
     }
 }
 
-static void
-igb_intmgr_timer_pause(IGBIntrDelayTimer *timer)
-{
-    if (timer->running) {
-        timer_del(timer->timer);
-    }
-}
-
 static void
 igb_intrmgr_on_msix_throttling_timer(void *opaque)
 {
@@ -212,16 +204,6 @@ igb_intrmgr_resume(IGBCore *core)
     }
 }
 
-static void
-igb_intrmgr_pause(IGBCore *core)
-{
-    int i;
-
-    for (i = 0; i < IGB_INTR_NUM; i++) {
-        igb_intmgr_timer_pause(&core->eitr[i]);
-    }
-}
-
 static void
 igb_intrmgr_reset(IGBCore *core)
 {
@@ -4290,12 +4272,6 @@ igb_core_read(IGBCore *core, hwaddr addr, unsigned size)
     return 0;
 }
 
-static inline void
-igb_autoneg_pause(IGBCore *core)
-{
-    timer_del(core->autoneg_timer);
-}
-
 static void
 igb_autoneg_resume(IGBCore *core)
 {
@@ -4307,22 +4283,6 @@ igb_autoneg_resume(IGBCore *core)
     }
 }
 
-static void
-igb_vm_state_change(void *opaque, bool running, RunState state)
-{
-    IGBCore *core = opaque;
-
-    if (running) {
-        trace_e1000e_vm_state_running();
-        igb_intrmgr_resume(core);
-        igb_autoneg_resume(core);
-    } else {
-        trace_e1000e_vm_state_stopped();
-        igb_autoneg_pause(core);
-        igb_intrmgr_pause(core);
-    }
-}
-
 void
 igb_core_pci_realize(IGBCore        *core,
                      const uint16_t *eeprom_templ,
@@ -4335,8 +4295,6 @@ igb_core_pci_realize(IGBCore        *core,
                                        igb_autoneg_timer, core);
     igb_intrmgr_pci_realize(core);
 
-    core->vmstate = qemu_add_vm_change_state_handler(igb_vm_state_change, core);
-
     for (i = 0; i < IGB_NUM_QUEUES; i++) {
         net_tx_pkt_init(&core->tx[i].tx_pkt, E1000E_MAX_TX_FRAGS);
     }
@@ -4360,8 +4318,6 @@ igb_core_pci_uninit(IGBCore *core)
 
     igb_intrmgr_pci_unint(core);
 
-    qemu_del_vm_change_state_handler(core->vmstate);
-
     for (i = 0; i < IGB_NUM_QUEUES; i++) {
         net_tx_pkt_uninit(core->tx[i].tx_pkt);
     }
@@ -4586,5 +4542,12 @@ igb_core_post_load(IGBCore *core)
      */
     nc->link_down = (core->mac[STATUS] & E1000_STATUS_LU) == 0;
 
+    /*
+     * we need to restart intrmgr timers, as an older version of
+     * QEMU can have stopped them before migration
+     */
+    igb_intrmgr_resume(core);
+    igb_autoneg_resume(core);
+
     return 0;
 }
diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
index bf8c46f26b..d70b54e318 100644
--- a/hw/net/igb_core.h
+++ b/hw/net/igb_core.h
@@ -90,8 +90,6 @@ struct IGBCore {
 
     IGBIntrDelayTimer eitr[IGB_INTR_NUM];
 
-    VMChangeStateEntry *vmstate;
-
     uint32_t eitr_guest_value[IGB_INTR_NUM];
 
     uint8_t permanent_mac[ETH_ALEN];
-- 
2.39.2


