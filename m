Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1147C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riW2E-0007x7-Un; Fri, 08 Mar 2024 03:56:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1riW29-0007pB-Qi
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:56:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1riW28-0000BN-2i
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709888210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XWFb3+LYPuoMQX8v795JVbBqObfPygJr22lgK8KwDo4=;
 b=SuP76UDd5zLLWql2FVepe1kHib8qMG0rQC2l/FUhLA0/vd0rZiQnC9+OpQq0/EeDL8hDDj
 dCSDFEhGfeSX7ZIlQoJXydVX+IzSciOu2tSm/MIrav3NbT+CfDq47fMOA5/hqlCq80KfvU
 KBKJWhbFhbN7w798t49HxYQ5U+oX3/A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-X5M980GeMa24bgSLG7w1lQ-1; Fri, 08 Mar 2024 03:56:46 -0500
X-MC-Unique: X5M980GeMa24bgSLG7w1lQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06F4080026E;
 Fri,  8 Mar 2024 08:56:46 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.39.194.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B1BF7492B79;
 Fri,  8 Mar 2024 08:56:44 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v3 1/2] igb: fix link state on resume
Date: Fri,  8 Mar 2024 09:56:42 +0100
Message-ID: <20240308085643.1264964-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/net/igb_core.c | 47 +++--------------------------------------------
 hw/net/igb_core.h |  2 --
 2 files changed, 3 insertions(+), 46 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 2a7a11aa9ed5..31ab959ab8ff 100644
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
@@ -4586,5 +4542,8 @@ igb_core_post_load(IGBCore *core)
      */
     nc->link_down = (core->mac[STATUS] & E1000_STATUS_LU) == 0;
 
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


