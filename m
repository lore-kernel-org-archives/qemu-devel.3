Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B53CD1297
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 05:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruQmj-000601-B7; Wed, 10 Apr 2024 01:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQls-000522-F2; Wed, 10 Apr 2024 01:45:22 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQlo-0001R7-Qt; Wed, 10 Apr 2024 01:45:18 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6C1C25D4E4;
 Wed, 10 Apr 2024 08:46:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 24841B014B;
 Wed, 10 Apr 2024 08:44:17 +0300 (MSK)
Received: (nullmailer pid 4182037 invoked by uid 1000);
 Wed, 10 Apr 2024 05:44:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.11 12/41] e1000e: fix link state on resume
Date: Wed, 10 Apr 2024 08:43:33 +0300
Message-Id: <20240410054416.4181891-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.11-20240410084037@cover.tls.msk.ru>
References: <qemu-stable-7.2.11-20240410084037@cover.tls.msk.ru>
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

On resume e1000e_vm_state_change() always calls e1000e_autoneg_resume()
that sets link_down to false, and thus activates the link even
if we have disabled it.

The problem can be reproduced starting qemu in paused state (-S) and
then set the link to down. When we resume the machine the link appears
to be up.

Reproducer:

   # qemu-system-x86_64 ... -device e1000e,netdev=netdev0,id=net0 -S

   {"execute": "qmp_capabilities" }
   {"execute": "set_link", "arguments": {"name": "net0", "up": false}}
   {"execute": "cont" }

To fix the problem, merge the content of e1000e_vm_state_change()
into e1000e_core_post_load() as e1000 does.

Buglink: https://issues.redhat.com/browse/RHEL-21867
Fixes: 6f3fbe4ed06a ("net: Introduce e1000e device emulation")
Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 4cadf10234989861398e19f3bb441d3861f3bb7c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index c71d82ce1d..742f5ec800 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -108,14 +108,6 @@ e1000e_intmgr_timer_resume(E1000IntrDelayTimer *timer)
     }
 }
 
-static void
-e1000e_intmgr_timer_pause(E1000IntrDelayTimer *timer)
-{
-    if (timer->running) {
-        timer_del(timer->timer);
-    }
-}
-
 static inline void
 e1000e_intrmgr_stop_timer(E1000IntrDelayTimer *timer)
 {
@@ -397,24 +389,6 @@ e1000e_intrmgr_resume(E1000ECore *core)
     }
 }
 
-static void
-e1000e_intrmgr_pause(E1000ECore *core)
-{
-    int i;
-
-    e1000e_intmgr_timer_pause(&core->radv);
-    e1000e_intmgr_timer_pause(&core->rdtr);
-    e1000e_intmgr_timer_pause(&core->raid);
-    e1000e_intmgr_timer_pause(&core->tidv);
-    e1000e_intmgr_timer_pause(&core->tadv);
-
-    e1000e_intmgr_timer_pause(&core->itr);
-
-    for (i = 0; i < E1000E_MSIX_VEC_NUM; i++) {
-        e1000e_intmgr_timer_pause(&core->eitr[i]);
-    }
-}
-
 static void
 e1000e_intrmgr_reset(E1000ECore *core)
 {
@@ -3336,12 +3310,6 @@ e1000e_core_read(E1000ECore *core, hwaddr addr, unsigned size)
     return 0;
 }
 
-static inline void
-e1000e_autoneg_pause(E1000ECore *core)
-{
-    timer_del(core->autoneg_timer);
-}
-
 static void
 e1000e_autoneg_resume(E1000ECore *core)
 {
@@ -3353,22 +3321,6 @@ e1000e_autoneg_resume(E1000ECore *core)
     }
 }
 
-static void
-e1000e_vm_state_change(void *opaque, bool running, RunState state)
-{
-    E1000ECore *core = opaque;
-
-    if (running) {
-        trace_e1000e_vm_state_running();
-        e1000e_intrmgr_resume(core);
-        e1000e_autoneg_resume(core);
-    } else {
-        trace_e1000e_vm_state_stopped();
-        e1000e_autoneg_pause(core);
-        e1000e_intrmgr_pause(core);
-    }
-}
-
 void
 e1000e_core_pci_realize(E1000ECore     *core,
                         const uint16_t *eeprom_templ,
@@ -3381,9 +3333,6 @@ e1000e_core_pci_realize(E1000ECore     *core,
                                        e1000e_autoneg_timer, core);
     e1000e_intrmgr_pci_realize(core);
 
-    core->vmstate =
-        qemu_add_vm_change_state_handler(e1000e_vm_state_change, core);
-
     for (i = 0; i < E1000E_NUM_QUEUES; i++) {
         net_tx_pkt_init(&core->tx[i].tx_pkt, core->owner,
                         E1000E_MAX_TX_FRAGS, core->has_vnet);
@@ -3408,8 +3357,6 @@ e1000e_core_pci_uninit(E1000ECore *core)
 
     e1000e_intrmgr_pci_unint(core);
 
-    qemu_del_vm_change_state_handler(core->vmstate);
-
     for (i = 0; i < E1000E_NUM_QUEUES; i++) {
         net_tx_pkt_reset(core->tx[i].tx_pkt);
         net_tx_pkt_uninit(core->tx[i].tx_pkt);
@@ -3561,5 +3508,12 @@ e1000e_core_post_load(E1000ECore *core)
      */
     nc->link_down = (core->mac[STATUS] & E1000_STATUS_LU) == 0;
 
+    /*
+     * we need to restart intrmgr timers, as an older version of
+     * QEMU can have stopped them before migration
+     */
+    e1000e_intrmgr_resume(core);
+    e1000e_autoneg_resume(core);
+
     return 0;
 }
diff --git a/hw/net/e1000e_core.h b/hw/net/e1000e_core.h
index 4ddb4d2c39..f2a8ff4a33 100644
--- a/hw/net/e1000e_core.h
+++ b/hw/net/e1000e_core.h
@@ -100,8 +100,6 @@ struct E1000Core {
     E1000IntrDelayTimer eitr[E1000E_MSIX_VEC_NUM];
     bool eitr_intr_pending[E1000E_MSIX_VEC_NUM];
 
-    VMChangeStateEntry *vmstate;
-
     uint32_t itr_guest_value;
     uint32_t eitr_guest_value[E1000E_MSIX_VEC_NUM];
 
-- 
2.39.2


