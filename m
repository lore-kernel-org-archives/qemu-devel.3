Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB2FCDE00C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3eU-0000Uu-IQ; Fri, 26 Jun 2026 06:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3eC-0007iR-Kz
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3eA-0005ID-OR
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6CzWwZ3dSbLJuGwdtwknO1r7WLWkHJidTJ1w1I1/ImI=;
 b=FKOEe/fYs0zo7xDbU7yYFP5ZZWPTwIiTNfpOdQa4NVPuCAUz9fl0fDrrdfq4xuYgPn07qq
 hyq+VJ7Gg0Tc/k4O8KTe6OYXkxR9ONgNEu+vsO3rZvbVzs39PMxnzUr9BLarZ6Vmrt7Q3L
 v9/vV11GKm11hbyJfjxmAfzBaOT4ld8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-l3zoOEJiMpe3s2R2Ct8EYw-1; Fri, 26 Jun 2026 06:18:50 -0400
X-MC-Unique: l3zoOEJiMpe3s2R2Ct8EYw-1
X-Mimecast-MFC-AGG-ID: l3zoOEJiMpe3s2R2Ct8EYw_1782469130
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490ab3f6e55so3791655e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469129; x=1783073929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6CzWwZ3dSbLJuGwdtwknO1r7WLWkHJidTJ1w1I1/ImI=;
 b=RLG23Zmj32wKpb88xyH0DsFtvyV2ewg73AKCjhLvfDNOkwkJOG9XT1TepUBSyctJfo
 Wn6YNNmdsIfrJsyyuosFKTIa4n7IbMTcleOyjUkn4Hjb9FQqWTqcZ9eIVU8pwr7gtthN
 FgWcoCV9tF39WvLKDcnjUIiApNO+Wg0fsT/nnI7E7zxnS0QntIkvlF0tkUNjVS47tpF3
 WC4r2+2SeMJrLD37d2MlB+1wZ4yNxuDa3CJVMQCOGdh/vNmHxWzbhWU18vm8JGl5eg1v
 ipsN3XFLyY1XnGD8SxeahPq8AUvrimWKYgDqR0CwL7zenabPdUzoY+9gf5L0jzl9IjF3
 GBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469129; x=1783073929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6CzWwZ3dSbLJuGwdtwknO1r7WLWkHJidTJ1w1I1/ImI=;
 b=nn/qxjeHCMyi9YvtZM1hMmRcXs6O+aszL1QOKqXTcAfvsoRlPbU43+O16/ux3/wNha
 7vB/yjAKWr2f5kITlqPElzSUsj+SMKMeZUPzkB6rxva1sbM5zQbHpmFsR/uWmE4TsqLN
 xCqYhHn0drCP6NZWVbfiv354mjbchV5ZpdruFkQNCM7x1DphfilhsiY6ZkKH/b35ojtV
 gSprSDSVHnk1dDegbLonWNKOOTtsmvd0PBHeGZg1EC+/ChFFr4WqkfEtcLqj9UiLI4Ja
 7f9kJRIlvzjHRCiuNmkqlHMjebhRYmyoGePrGfdZuuGwoJxP60sQ5acP5jlgmznDftb0
 tIfA==
X-Gm-Message-State: AOJu0YwAYo+lWIyRcBN9Q1cRJsA4pS0F9hDpbOJF52pnWKXHODSvFGXP
 Gk/uPzJRY88F+4GESmRMwbDW76x2xgOE7NPHhdVz3YT9I6O1UhQhjkR64y1SwKuZNtc8RtZFL9h
 7gjY0T1au26OqiojOkbydGgAr6QV58qRHHLkazAYplNVSZlzPxqU4OkShxtKByxODfAw84A4I2m
 94Ame3FV5QVkfPiuNmrydKoptU0tnQ0zN1Cl8Jw0hn
X-Gm-Gg: AfdE7cnbENh5/29YdHqjYeq+MiuC64ytgS4HVQ7j4LHVIUjHHoFw4N/bmACKQu38E58
 AFdK/WAE4i+mIGPmpdNcvKGCBwXhJczCPxTYIzzyQ2/gAEGDJnCyJk8rh7wNnpt5CdkSVtRBnVW
 QEcW1DMDxr6fIElllKa4D7NafauD3KS4XBUF5dmL+fTdlh49Jg6C9tE7F3g0kxU0W6pSPXL8tm2
 l5bYyWrNMG6y2k05Qa3Bc/hOUbTRzVxywfc7r0cMV2HWQ9vZcfHS6dv/9Nb+ZvoCdG00sfULlzk
 K6+nI5GVMqkG7FI1V29V6dqHwGQ9T0/KMe6JfYgAlf04tPH7KuoW/HfOPp0FT5H9nj8cQ8ktIVz
 CRjPdaptnf8bczpsv1pxhsxepDVfvvLBgKfHNGHoEs3Spy9MLa008RHezgJp6nnch7tT8rpbJId
 VD3q/D8iNq1mn1nTw1
X-Received: by 2002:a05:600c:4e45:b0:492:6f6f:fa42 with SMTP id
 5b1f17b1804b1-4926f6ffa8emr7319445e9.37.1782469129567; 
 Fri, 26 Jun 2026 03:18:49 -0700 (PDT)
X-Received: by 2002:a05:600c:4e45:b0:492:6f6f:fa42 with SMTP id
 5b1f17b1804b1-4926f6ffa8emr7318835e9.37.1782469129127; 
 Fri, 26 Jun 2026 03:18:49 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926c02081bsm33033005e9.0.2026.06.26.03.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:18:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 21/45] accel/mshv: reserve ioapic routes on s->irq_routes
Date: Fri, 26 Jun 2026 12:17:24 +0200
Message-ID: <20260626101748.1728079-22-pbonzini@redhat.com>
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

We reserve 24 ioapic routes using the new functions that operate on the
mshv apic state.

commit/add_msi_routing() fn's can be removed now.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260417105618.3621-13-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv_int.h |   1 -
 accel/mshv/irq.c          | 115 ++++++--------------------------------
 accel/mshv/mshv-all.c     |   5 --
 3 files changed, 18 insertions(+), 103 deletions(-)

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index a0fa9a50f76..68b84ce2c8d 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -122,6 +122,5 @@ int mshv_configure_msr(const CPUState *cpu, const MshvMsrEntry *msrs,
 
 /* interrupt */
 void mshv_init_msicontrol(void);
-int mshv_reserve_ioapic_msi_routes(int vm_fd);
 
 #endif
diff --git a/accel/mshv/irq.c b/accel/mshv/irq.c
index 9ba837f0e2e..52b8ac94790 100644
--- a/accel/mshv/irq.c
+++ b/accel/mshv/irq.c
@@ -36,93 +36,6 @@ void mshv_init_msicontrol(void)
     msi_control->updated = false;
 }
 
-static int add_msi_routing(uint64_t addr, uint32_t data)
-{
-    struct mshv_user_irq_entry *route_entry;
-    uint32_t high_addr = addr >> 32;
-    uint32_t low_addr = addr & 0xFFFFFFFF;
-    int gsi;
-    GHashTable *gsi_routes;
-
-    trace_mshv_add_msi_routing(addr, data);
-
-    assert(msi_control);
-
-    WITH_QEMU_LOCK_GUARD(&msi_control_mutex) {
-        /* find an empty slot */
-        gsi = 0;
-        gsi_routes = msi_control->gsi_routes;
-        while (gsi < MSHV_MAX_MSI_ROUTES) {
-            route_entry = g_hash_table_lookup(gsi_routes, GINT_TO_POINTER(gsi));
-            if (!route_entry) {
-                break;
-            }
-            gsi++;
-        }
-        if (gsi >= MSHV_MAX_MSI_ROUTES) {
-            error_report("No empty gsi slot available");
-            return -1;
-        }
-
-        /* create new entry */
-        route_entry = g_new0(struct mshv_user_irq_entry, 1);
-        route_entry->gsi = gsi;
-        route_entry->address_hi = high_addr;
-        route_entry->address_lo = low_addr;
-        route_entry->data = data;
-
-        g_hash_table_insert(gsi_routes, GINT_TO_POINTER(gsi), route_entry);
-        msi_control->updated = true;
-    }
-
-    return gsi;
-}
-
-static int commit_msi_routing_table(int vm_fd)
-{
-    guint len;
-    int i, ret;
-    size_t table_size;
-    struct mshv_user_irq_table *table;
-    GHashTableIter iter;
-    gpointer key, value;
-
-    assert(msi_control);
-
-    WITH_QEMU_LOCK_GUARD(&msi_control_mutex) {
-        if (!msi_control->updated) {
-            /* nothing to update */
-            return 0;
-        }
-
-        /* Calculate the size of the table */
-        len = g_hash_table_size(msi_control->gsi_routes);
-        table_size = sizeof(struct mshv_user_irq_table)
-                     + len * sizeof(struct mshv_user_irq_entry);
-        table = g_malloc0(table_size);
-
-        g_hash_table_iter_init(&iter, msi_control->gsi_routes);
-        i = 0;
-        while (g_hash_table_iter_next(&iter, &key, &value)) {
-            struct mshv_user_irq_entry *entry = value;
-            table->entries[i] = *entry;
-            i++;
-        }
-        table->nr = i;
-
-        trace_mshv_commit_msi_routing_table(vm_fd, len);
-
-        ret = ioctl(vm_fd, MSHV_SET_MSI_ROUTING, table);
-        g_free(table);
-        if (ret < 0) {
-            error_report("Failed to commit msi routing table");
-            return -1;
-        }
-        msi_control->updated = false;
-    }
-    return 0;
-}
-
 /* Pass an eventfd which is to be used for injecting interrupts from userland */
 static int irqfd(int vm_fd, int fd, int resample_fd, uint32_t gsi,
                  uint32_t flags)
@@ -420,37 +333,45 @@ int mshv_irqchip_remove_irqfd_notifier_gsi(const EventNotifier *event,
     return irqchip_update_irqfd_notifier_gsi(event, NULL, virq, false);
 }
 
-int mshv_reserve_ioapic_msi_routes(int vm_fd)
+static int mshv_reserve_ioapic_msi_routes(MshvState *s)
 {
-    int ret, gsi;
+    int ret, i;
+    int gsi = 0;
+    struct mshv_user_irq_entry blank_entry = { 0 };
 
     /*
      * Reserve GSI 0-23 for IOAPIC pins, to avoid conflicts of legacy
      * peripherals with MSI-X devices
      */
-    for (gsi = 0; gsi < IOAPIC_NUM_PINS; gsi++) {
-        ret = add_msi_routing(0, 0);
+    for (i = 0; i < IOAPIC_NUM_PINS; i++) {
+        /* ret = add_msi_routing(0, 0); */
+        ret = irqchip_allocate_gsi(s, &gsi);
         if (ret < 0) {
-            error_report("Failed to reserve GSI %d", gsi);
+            error_report("Failed to reserve GSI %d: %s", gsi, strerror(-ret));
             return -1;
         }
+        blank_entry.gsi = gsi;
+        add_routing_entry(s, &blank_entry);
     }
 
-    ret = commit_msi_routing_table(vm_fd);
-    if (ret < 0) {
-        error_report("Failed to commit reserved IOAPIC MSI routes");
-        return -1;
-    }
+    mshv_irqchip_commit_routes(s);
 
     return 0;
 }
 
 void mshv_init_irq_routing(MshvState *s)
 {
+    int ret;
     int gsi_count = MSHV_MAX_MSI_ROUTES;
 
     s->irq_routes = g_malloc0(sizeof(*s->irq_routes));
     s->nr_allocated_irq_routes = 0;
     s->gsi_count = gsi_count;
     s->used_gsi_bitmap = bitmap_new(gsi_count);
+
+    ret = mshv_reserve_ioapic_msi_routes(s);
+    if (ret < 0) {
+        error_report("Failed to reserve IOAPIC MSI routes");
+        abort();
+    }
 }
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 2ed3ef4b841..19a44bb13de 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -264,11 +264,6 @@ static int create_vm(int mshv_fd, int *vm_fd)
         return -1;
     }
 
-    ret = mshv_reserve_ioapic_msi_routes(*vm_fd);
-    if (ret < 0) {
-        return -1;
-    }
-
     ret = mshv_arch_post_init_vm(*vm_fd);
     if (ret < 0) {
         return -1;
-- 
2.54.0


