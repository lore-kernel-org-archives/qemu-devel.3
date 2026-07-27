Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC36C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 05:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woE4c-0003mw-U2; Mon, 27 Jul 2026 01:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woE4Y-0003lI-EV
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 01:40:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woE4W-0003l8-IX
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 01:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785130815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sEWKxZjddL/Yv5HQH67qrxFGud3IuDmuA7QtqmGJdwc=;
 b=Jv6sqv689iaKMYKr+lYi2QWIZ72aGVTvx8DEFsI07Le9ny/6JxtXMYJml5lG/rlRRF6myG
 fmotmC7+q1CNI0NDqQ0CGwLjz4ZUQbXGNJ0QSalOGWGGdE9BLZ2zNCCe4C/dYZUtc/9uRq
 DLECecR/zldUZdfgmkpJM5VuKsxbiVU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-m661FR3HNtCMy01qbYKGUw-1; Mon,
 27 Jul 2026 01:40:13 -0400
X-MC-Unique: m661FR3HNtCMy01qbYKGUw-1
X-Mimecast-MFC-AGG-ID: m661FR3HNtCMy01qbYKGUw_1785130812
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E0E81955F04; Mon, 27 Jul 2026 05:40:12 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9FFB21956088; Mon, 27 Jul 2026 05:40:09 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC PATCH 09/11] igb: Send RARP after VF migration to update bridge
 FDB
Date: Mon, 27 Jul 2026 07:39:33 +0200
Message-ID: <20260727053935.1392269-10-clg@redhat.com>
In-Reply-To: <20260727053935.1392269-1-clg@redhat.com>
References: <20260727053935.1392269-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

After VF migration the L0 bridge FDB (Forwarding Database) still maps
the VF's MAC to the old tap port, causing a ~30 s connectivity stall
while peer ARP caches expire.

Add igb_core_vf_get_mac() to look up a VF's MAC address from the PF's
Receive Address registers, and use it to send a RARP broadcast from
the PF's network backend during VF unquiesce so the bridge relearns
the correct port immediately.

Assisted-by: Claude
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/net/igb_core.h      |  1 +
 hw/net/igb_core.c      | 28 ++++++++++++++++++++++++++++
 hw/net/igb_migration.c | 33 +++++++++++++++++++++++++++++++++
 hw/net/trace-events    |  2 ++
 4 files changed, 64 insertions(+)

diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
index 3db520048732..07b4270708c4 100644
--- a/hw/net/igb_core.h
+++ b/hw/net/igb_core.h
@@ -149,4 +149,5 @@ IGBCore *igb_pf_get_core(void *pf);
 void igb_core_vf_propagate_irqs(IGBCore *core, uint16_t vfn);
 void igb_core_vf_rearm_irqs(IGBCore *core, uint16_t vfn);
 void igb_core_vf_propagate_ivar(IGBCore *core, uint16_t vfn);
+bool igb_core_vf_get_mac(IGBCore *core, uint16_t vfn, uint8_t *mac);
 #endif
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 1621ee6602d5..281f3a474392 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -4634,3 +4634,31 @@ void igb_core_vf_propagate_ivar(IGBCore *core, uint16_t vfn)
             ((uint32_t)ent << (8 * (n % 4)));
     }
 }
+
+bool igb_core_vf_get_mac(IGBCore *core, uint16_t vfn, uint8_t *mac)
+{
+    uint32_t vf_pool_bit = E1000_RAH_POOL_1 << vfn;
+    static const struct {
+        uint32_t base;
+        int count;
+    } ra_banks[] = {
+        { RA,  16 },
+        { RA2,  8 },
+    };
+    int i, j;
+
+    for (i = 0; i < ARRAY_SIZE(ra_banks); i++) {
+        for (j = 0; j < ra_banks[i].count; j++) {
+            uint32_t ral_off = ra_banks[i].base + j * 2;
+            uint32_t rah_off = ra_banks[i].base + j * 2 + 1;
+            uint32_t rah_val = core->mac[rah_off];
+
+            if ((rah_val & E1000_RAH_AV) && (rah_val & vf_pool_bit)) {
+                stl_le_p(mac, core->mac[ral_off]);
+                stw_le_p(mac + 4, rah_val & 0xffff);
+                return true;
+            }
+        }
+    }
+    return false;
+}
diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
index a0b4a52c865f..fce661f68e3d 100644
--- a/hw/net/igb_migration.c
+++ b/hw/net/igb_migration.c
@@ -609,6 +609,36 @@ static void igb_core_vf_quiesce(IgbVfState *s)
     trace_igbvf_mig_quiesce(s->vfn, core->mac[VFRE], core->mac[VFTE]);
 }
 
+/*
+ * Send a RARP broadcast so the network bridge relearns which port
+ * carries this VF's MAC after migration.
+ */
+static void igb_core_vf_send_rarp(IGBCore *core, uint16_t vfn)
+{
+    uint8_t mac[ETH_ALEN];
+    uint8_t buf[60];
+
+    if (!igb_core_vf_get_mac(core, vfn, mac)) {
+        trace_igbvf_mig_no_mac(vfn);
+        return;
+    }
+
+    trace_igbvf_mig_send_rarp(vfn, mac[0], mac[1], mac[2],
+                              mac[3], mac[4], mac[5]);
+
+    memset(buf, 0xff, ETH_ALEN);
+    memcpy(buf + 6, mac, ETH_ALEN);
+    stw_be_p(buf + 12, 0x8035);     /* ETH_P_RARP */
+    stw_be_p(buf + 14, 1);          /* hw addr space: ethernet */
+    stw_be_p(buf + 16, ETH_P_IP);   /* protocol addr space */
+    buf[18] = 6; buf[19] = 4;       /* hw/proto addr lengths */
+    stw_be_p(buf + 20, 3);          /* opcode: RARP request */
+    memcpy(buf + 22, mac, ETH_ALEN);
+    memset(buf + 28, 0, 32);
+
+    qemu_send_packet_raw(qemu_get_queue(core->owner_nic), buf, sizeof(buf));
+}
+
 static void igb_core_vf_unquiesce(IgbVfState *s)
 {
     IgbVfMigState *ms = &s->mig;
@@ -632,6 +662,9 @@ static void igb_core_vf_unquiesce(IgbVfState *s)
     if (re) {
         igb_core_vf_rearm_irqs(core, s->vfn);
     }
+
+    /* TODO : RARP should be sent only if resumed */
+    igb_core_vf_send_rarp(core, s->vfn);
 }
 
 /* ================================================================
diff --git a/hw/net/trace-events b/hw/net/trace-events
index f4940e3e176d..1e38d9ab3697 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -312,6 +312,8 @@ igb_core_dirty_track_dma(int vfn, uint64_t addr, uint64_t len) "VF%d: dirty DMA
 igb_core_dirty_track_dma_drop(int vfn, uint64_t addr, uint64_t len) "VF%d: dirty DMA dropped addr=0x%"PRIx64" len=%"PRIu64" no matching range"
 igbvf_mig_quiesce(uint16_t vfn, uint32_t vfre, uint32_t vfte) "VF%u: quiesce VFRE=0x%x VFTE=0x%x"
 igbvf_mig_unquiesce(uint16_t vfn, uint32_t vfre, uint32_t vfte) "VF%u: unquiesce VFRE=0x%x VFTE=0x%x"
+igbvf_mig_no_mac(uint16_t vfn) "VF%u: no MAC address found, skipping RARP"
+igbvf_mig_send_rarp(uint16_t vfn, uint8_t b0, uint8_t b1, uint8_t b2, uint8_t b3, uint8_t b4, uint8_t b5) "VF%u: RARP %02x:%02x:%02x:%02x:%02x:%02x"
 
 # spapr_llan.c
 spapr_vlan_get_rx_bd_from_pool_found(int pool, int32_t count, uint32_t rx_bufs) "pool=%d count=%"PRId32" rxbufs=%"PRIu32
-- 
2.55.0


