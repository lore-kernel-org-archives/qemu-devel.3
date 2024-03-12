Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3075CC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0Ra-0007ME-KR; Tue, 12 Mar 2024 07:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rk0RJ-0007Fv-LU
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:37:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rk0RC-00039g-Pb
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710243413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xL106kVA8ePsCXHAMov+fH5LglN3/4U2YkHYgXmAuek=;
 b=f2IV9DSGG68UKsNwZVPvuFUoqeI7wmsvSTzFAkGH7vqrRPOn5tFclD50hrhVwlVIWVthPg
 9CDKRcuWbQrnr88Bm3DMJw0oYEYVOaZSkhD51dqFVNBBCjGcnCkG7HTZB9089tZaP17cwz
 8UqsXQd8tsvQKk53NxSGaCvUp+ItMvk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-kFbq3Iy8Pd6LAaf7oRh0Bg-1; Tue,
 12 Mar 2024 07:36:49 -0400
X-MC-Unique: kFbq3Iy8Pd6LAaf7oRh0Bg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E2E33C0DD07;
 Tue, 12 Mar 2024 11:36:49 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 59388492BC6;
 Tue, 12 Mar 2024 11:36:47 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Laurent Vivier <lvivier@redhat.com>, akihiko.odaki@daynix.com,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 1/8] igb: fix link state on resume
Date: Tue, 12 Mar 2024 19:36:35 +0800
Message-ID: <20240312113642.36862-2-jasowang@redhat.com>
In-Reply-To: <20240312113642.36862-1-jasowang@redhat.com>
References: <20240312113642.36862-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
---
 hw/net/igb_core.c | 51 +++++++----------------------------------------
 hw/net/igb_core.h |  2 --
 2 files changed, 7 insertions(+), 46 deletions(-)

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
2.42.0


