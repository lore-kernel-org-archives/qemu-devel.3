Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221FDC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 10:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSag8-0006ww-6V; Wed, 24 Jan 2024 05:40:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1rSag6-0006wi-R3
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:40:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1rSag4-0007tv-UB
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 05:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706092815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=EHwv04HCO+hB/DZ3aI78/sdb3XJeB6fb6/pvNzaOgRM=;
 b=AEK3RuFCzIIVED6sQj7OyKxfLTnFgcOyiDzzq8PdpJJuIiR+VN59oHE8hNd6wfQ4rZNFWT
 Q7hSIRKtTyExAIP3y8rPFy7gsg8k08pzJC1/FGUaYXmoiRi205CyKh90eK0N9WvmNyje0U
 zDD0RneRwlv/6FMzJ0I5ZhWA7WqyVLM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-NRr6GEjIMhWOml4lL1-6lQ-1; Wed,
 24 Jan 2024 05:40:11 -0500
X-MC-Unique: NRr6GEjIMhWOml4lL1-6lQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F301B1C0434C;
 Wed, 24 Jan 2024 10:40:10 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.39.194.219])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD3932028CD2;
 Wed, 24 Jan 2024 10:40:09 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 2/2] e1000e: fix link state on resume
Date: Wed, 24 Jan 2024 11:40:06 +0100
Message-ID: <20240124104006.335166-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
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
---

Notes:
    v2: Add Fixes: and a comment about e1000e_intrmgr_resume() purpose.

 hw/net/e1000e_core.c | 54 ++++++--------------------------------------
 hw/net/e1000e_core.h |  2 --
 2 files changed, 7 insertions(+), 49 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index e324c02dd589..ac8d4bb2433a 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -123,14 +123,6 @@ e1000e_intmgr_timer_resume(E1000IntrDelayTimer *timer)
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
@@ -398,24 +390,6 @@ e1000e_intrmgr_resume(E1000ECore *core)
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
@@ -3351,22 +3325,6 @@ e1000e_autoneg_resume(E1000ECore *core)
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
@@ -3379,9 +3337,6 @@ e1000e_core_pci_realize(E1000ECore     *core,
                                        e1000e_autoneg_timer, core);
     e1000e_intrmgr_pci_realize(core);
 
-    core->vmstate =
-        qemu_add_vm_change_state_handler(e1000e_vm_state_change, core);
-
     for (i = 0; i < E1000E_NUM_QUEUES; i++) {
         net_tx_pkt_init(&core->tx[i].tx_pkt, E1000E_MAX_TX_FRAGS);
     }
@@ -3405,8 +3360,6 @@ e1000e_core_pci_uninit(E1000ECore *core)
 
     e1000e_intrmgr_pci_unint(core);
 
-    qemu_del_vm_change_state_handler(core->vmstate);
-
     for (i = 0; i < E1000E_NUM_QUEUES; i++) {
         net_tx_pkt_uninit(core->tx[i].tx_pkt);
     }
@@ -3576,5 +3529,12 @@ e1000e_core_post_load(E1000ECore *core)
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
index 66b025cc43f1..01510ca78b47 100644
--- a/hw/net/e1000e_core.h
+++ b/hw/net/e1000e_core.h
@@ -98,8 +98,6 @@ struct E1000Core {
 
     E1000IntrDelayTimer eitr[E1000E_MSIX_VEC_NUM];
 
-    VMChangeStateEntry *vmstate;
-
     uint32_t itr_guest_value;
     uint32_t eitr_guest_value[E1000E_MSIX_VEC_NUM];
 
-- 
2.43.0


