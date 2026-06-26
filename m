Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C070CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3eM-00083W-Dx; Fri, 26 Jun 2026 06:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3e2-0007UM-Nd
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3dz-0005D9-D6
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vGBTAmxVNFMohgUHn4BgV598/C/xE9KDsqsNliQz3JU=;
 b=a1WIBnBzwyBqmmJoZrCZRBT88+hOqd7DslaPujhRDW2ZowY+HOOcUA84YHMKHkMb/xM7jY
 aH1XabkeXHrvMsFZXQq05s1ACq7zMN1qMoUjeMFV8RCfLbHRu8QOkfqqf2bRkqdmFmoSMq
 VRT7yTky/t4CRZ8BRhppe634pxWzoyg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-UgqN0ma4O-e8-rbYqJ4MmA-1; Fri, 26 Jun 2026 06:18:41 -0400
X-MC-Unique: UgqN0ma4O-e8-rbYqJ4MmA-1
X-Mimecast-MFC-AGG-ID: UgqN0ma4O-e8-rbYqJ4MmA_1782469120
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4926fa2cb17so464855e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469120; x=1783073920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vGBTAmxVNFMohgUHn4BgV598/C/xE9KDsqsNliQz3JU=;
 b=SOZOxtOW7RQjlWomW5cf/vMyLGYfoHTpQaAwvpCvz440DERC8TmlMksaKMAgnFnhru
 5iUB2JiTirRHSRh8rnTkPo0+AmwrUAXoDTFdWAvJcSlAFHR/dvlAFT+xhOOW2e+R9wA8
 GRBj883tqaglXClk6DvlWH1mj3e/1ql7b68gjZl7JZFPiUVwuHApNp3w0JP9LJA9sU32
 L67vwdVWYYRS2ZHprJr65mz6dY4MJUBg8Y+ajpiL5smI5lY6esJYJ7CRJNyPlMB7Ys01
 U7N6wHgGLTFtJz554ACMS6tcjeQ8Ejd4j3CgfOni6hs4BGMaBy1uSTWsG+k8pnFesozh
 xJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469120; x=1783073920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vGBTAmxVNFMohgUHn4BgV598/C/xE9KDsqsNliQz3JU=;
 b=tGR7+SxBTUK7Se8GNf+tHtNIBvQogLpZF/i9ZREqBDCwHFq6nmXr2hslTYy76kYR4p
 VIB88ENKA8Vrf3GiVX4JC0oUOgfqJ8WFqDMV34BoccJN69yw6gp/Mrc3RMFt1IyR2ppa
 EAgUhlmuWbVfd9Gw1pIrUBxW/g2g6itjfK+pmbjIeQwS7leclVgXCMV7USpXIizmudEH
 JA5K0+jrrtRkpbIJPMURG8QeD2X0oyrXgGw9F5my06DlBWB1SDsKc8IDT9hCT7yuVkLN
 v4viupwLzHyu4CuL5/PXqp7fFskNAYjBorn+zf3+Nws9siiOrzuzTNjprdhjnTLuRaEy
 Oy0A==
X-Gm-Message-State: AOJu0YzQLgYnpl+8UZy+tZP5FBFItFY47uUe0I7iEl9Oi3J3CXxT28iD
 O9BEUvbMP/JFPcTfJhTkoIOTiRDCMHWm8eLfHfMvnOI91Hw76PIfKXUB/8S6Vsub9KEfyhw9J5M
 08HBhcG4UaKSBgJQpF/H56HDdMv/MQmpCTVuWm+0cDwGpUJvAo7oEDmaURD8UdqFfYSzesTCkXx
 LxvPBjyNXYxGpe51IQBLBZLItmLfPNmulRN94Cv0zB
X-Gm-Gg: AfdE7ckCktHwonXwiUqWjp4+kVlxODv5Dgia88WaUN+q0SLyq51qEFqZCdyeiqroX2Z
 qvLmVhmzaUNTEh3yTXU4J1Z477zSy5BX+wPDRQjHCi18FpUISk0U67eBCWZnpBx4ZCGe9CG4CXX
 c8BxXAhqb5IN+uLY9URlWiOCeGmtU/3UIF/yn+D/pwg4oMHwT3JUazoS2Sxi+gQKtAxnW4iSfuo
 L9s47pVLGIQ2njKX2M3fYWaqEQ1eNQX9g2nVjd0grPj9zjRjJjo/mLxL09f+buVk2WecLaWDvcU
 OLdNWGUaNNN1fZhbAP1bv2k4DvjOdUqM/X5sVFexxj4plv/UQNCUYPcir5RnNjMm7ny3NJjAQ7V
 JicGbZirBUpxkbzt3qqDy2qH7INEfDSz3O4gytj99eo+YpABGLDGT9mjJwB4mcI8xjugZK1FHic
 UWW07rlaNi//W7034y
X-Received: by 2002:a05:600c:1551:b0:490:3cf0:8d81 with SMTP id
 5b1f17b1804b1-492664241a4mr79272165e9.13.1782469120062; 
 Fri, 26 Jun 2026 03:18:40 -0700 (PDT)
X-Received: by 2002:a05:600c:1551:b0:490:3cf0:8d81 with SMTP id
 5b1f17b1804b1-492664241a4mr79271685e9.13.1782469119488; 
 Fri, 26 Jun 2026 03:18:39 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268fcee16sm74119075e9.2.2026.06.26.03.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:18:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 18/45] accel/mshv: update s->irq_routes in update_msi_route
Date: Fri, 26 Jun 2026 12:17:21 +0200
Message-ID: <20260626101748.1728079-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

The state's irq_routes field will be updated when an irqchip's gsi
is requested to be updated with a new dest/vector.

The old set_msi_routing() fn is redundant and can be removed.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260417105618.3621-10-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/mshv/irq.c | 87 +++++++++++++++++++++---------------------------
 1 file changed, 38 insertions(+), 49 deletions(-)

diff --git a/accel/mshv/irq.c b/accel/mshv/irq.c
index 9d6bdde27ac..b5a047b3672 100644
--- a/accel/mshv/irq.c
+++ b/accel/mshv/irq.c
@@ -36,52 +36,6 @@ void mshv_init_msicontrol(void)
     msi_control->updated = false;
 }
 
-static int set_msi_routing(uint32_t gsi, uint64_t addr, uint32_t data)
-{
-    struct mshv_user_irq_entry *entry;
-    uint32_t high_addr = addr >> 32;
-    uint32_t low_addr = addr & 0xFFFFFFFF;
-    GHashTable *gsi_routes;
-
-    trace_mshv_set_msi_routing(gsi, addr, data);
-
-    if (gsi >= MSHV_MAX_MSI_ROUTES) {
-        error_report("gsi >= MSHV_MAX_MSI_ROUTES");
-        return -1;
-    }
-
-    assert(msi_control);
-
-    WITH_QEMU_LOCK_GUARD(&msi_control_mutex) {
-        gsi_routes = msi_control->gsi_routes;
-        entry = g_hash_table_lookup(gsi_routes, GINT_TO_POINTER(gsi));
-
-        if (entry
-            && entry->address_hi == high_addr
-            && entry->address_lo == low_addr
-            && entry->data == data)
-        {
-            /* nothing to update */
-            return 0;
-        }
-
-        /* free old entry */
-        g_free(entry);
-
-        /* create new entry */
-        entry = g_new0(struct mshv_user_irq_entry, 1);
-        entry->gsi = gsi;
-        entry->address_hi = high_addr;
-        entry->address_lo = low_addr;
-        entry->data = data;
-
-        g_hash_table_insert(gsi_routes, GINT_TO_POINTER(gsi), entry);
-        msi_control->updated = true;
-    }
-
-    return 0;
-}
-
 static int add_msi_routing(uint64_t addr, uint32_t data)
 {
     struct mshv_user_irq_entry *route_entry;
@@ -370,16 +324,51 @@ void mshv_irqchip_release_virq(int virq)
     remove_msi_routing(virq);
 }
 
+static int update_routing_entry(MshvState *s,
+                                struct mshv_user_irq_entry *new_entry)
+{
+    struct mshv_user_irq_entry *entry;
+    int n;
+
+    for (n = 0; n < s->irq_routes->nr; n++) {
+        entry = &s->irq_routes->entries[n];
+        if (entry->gsi != new_entry->gsi) {
+            continue;
+        }
+
+        if (!memcmp(entry, new_entry, sizeof *entry)) {
+            return 0;
+        }
+
+        *entry = *new_entry;
+
+        return 0;
+    }
+
+    return -ESRCH;
+}
+
 int mshv_irqchip_update_msi_route(int virq, MSIMessage msg, PCIDevice *dev)
 {
+    uint32_t addr_hi = msg.address >> 32;
+    uint32_t addr_lo = msg.address & 0xFFFFFFFF;
+    uint32_t data = le32_to_cpu(msg.data);
+    struct mshv_user_irq_entry entry = {
+        .gsi = virq,
+        .address_hi = addr_hi,
+        .address_lo = addr_lo,
+        .data = data,
+    };
     int ret;
 
-    ret = set_msi_routing(virq, msg.address, le32_to_cpu(msg.data));
+    ret = update_routing_entry(mshv_state, &entry);
     if (ret < 0) {
-        error_report("Failed to set msi routing");
-        return -1;
+        error_report("Failed to set msi routing for gsi %d", virq);
+        abort();
     }
 
+    trace_mshv_set_msi_routing(virq, msg.address, data);
+
     return 0;
 }
 
-- 
2.54.0


