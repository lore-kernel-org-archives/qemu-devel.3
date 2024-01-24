Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E0AC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 10:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSaVc-0003M7-Ht; Wed, 24 Jan 2024 05:29:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1rSaVZ-0003Ld-88
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:29:25 -0500
Received: from mout.kundenserver.de ([212.227.17.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1rSaVT-0005eJ-HP
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:29:21 -0500
Received: from lenovo-t14s.redhat.com ([82.142.8.70]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MHWzP-1rFeC33q1x-00DUAo; Wed, 24 Jan 2024 11:29:07 +0100
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 1/2] igb: fix link state on resume
Date: Wed, 24 Jan 2024 11:29:03 +0100
Message-ID: <20240124102904.334595-1-lvivier@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jK76SMmvb9C2rEQNFzDRWItWbJXGGIxAztE1/nWSqfWFY3mj55B
 Y3HBD93T6btV7d9K6njwWaWT2n5sQo77y0iI1WJnGNK/nmANigq02sh3ET9qvBPHXl3aWFh
 /qo97w94RiZfyv8U0i4k4kjtriNFVjEOQIL0i5mcXO/AYO6ozl8WIWj0FUlcwUso5nDgdLJ
 KsTmNGRbL6MhyhrOxA4Pw==
UI-OutboundReport: notjunk:1;M01:P0:bkaYNvMMhnw=;HVxGknXO+4muCFeSUbNMYa+NGYw
 +wHxP1DlXbWOw0fRA68yoDUpb6HVvC+aXtI9WFMtZYP5vT3JfPU0sAAz3tljwwUtJgUWZuG7m
 Yeazn3MOValgdyoeI4gzZNw0lUGPBjLCPuNvdMiDAujgRXp9+O2cI4uvvEx4NExCQJLWm+EIv
 mH9kPWOIThCIxZ1VfmU11jJ7V/eCqkcCf09ot6tTrTGx+ifzm5LHdJ7pGXVDOX2AUX26YRG2g
 LLpwgB0XbRuIPPNq/B4VueaVIJC+Yt/+CPc+PVzEEnkB8DC4frdoRvaW6swex740EqXSHZDbT
 GGifHKhD6fgge5oos0ij6vDX6TJBu0plAkHxm+OARdQULY/+k39NMyyMSzp0kWSllHVBHYMaM
 bLreUaDTCc+mBNc5pfB2vRkVLoreaV2ZdvlKOu0Z3mtZFDgkKbcnny4HmXbOSs6g4AiMdbZdG
 xiyyTE5UKEOVZZMCxWHorc/U59BhI77deIZz+n8MdutjTW/fTdyw30SJafqY8FR/GhTwUrkWi
 yRrI3n3fNDxBNERcQNaed2hE/XrqHdYuO9lwFwUx7gIv0j8qkpfGtdXNDtb8svdCWmXVaJsN+
 gBnVcmmo5m8MsvmsXroKBU6hXB1KDl1ZB+sPOeZHJdutTLbyndxOuZNUzkw33v7lvKszMQiwR
 yU9z26E2t1aT0EXM/tbpftmhqKVVMITtbdTzFWL2dmHpoMTTcfwhF8/W+GATMD1qh3REgT9/4
 FHPxgkVv2hm7s0uBVQpBH0KEXPPXTYMhYmoJVXZRDptLPaZ4C5+57rXODIq13Elu5RTZccYSr
 BUO756i0HD5cJe8eoepn9GLjFoEoOJ65/vbK+u3nSoIsSgxIdvAU085XMpi6A6x9t7kHAQYt1
 kG4S8QdXqXkyYSg==
Received-SPF: permerror client-ip=212.227.17.13;
 envelope-from=lvivier@redhat.com; helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_FAIL=0.001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
---

Notes:
    v2: Add Fixes: and a comment about igb_intrmgr_resume() purpose.

 hw/net/igb_core.c | 51 +++++++----------------------------------------
 hw/net/igb_core.h |  2 --
 2 files changed, 7 insertions(+), 46 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 2a7a11aa9ed5..bcd5f6cd9cdd 100644
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
index bf8c46f26b51..d70b54e318f1 100644
--- a/hw/net/igb_core.h
+++ b/hw/net/igb_core.h
@@ -90,8 +90,6 @@ struct IGBCore {
 
     IGBIntrDelayTimer eitr[IGB_INTR_NUM];
 
-    VMChangeStateEntry *vmstate;
-
     uint32_t eitr_guest_value[IGB_INTR_NUM];
 
     uint8_t permanent_mac[ETH_ALEN];
-- 
2.43.0


