Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB44CDE00C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3eN-0008DB-P1; Fri, 26 Jun 2026 06:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3e2-0007UN-O6
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3dz-0005Cy-Bx
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mhiC52oMwva++W28QseFLMsKqB/LHrv1Okp1RGXU2gI=;
 b=DrnhxLCEUm15/gzHrokWu84sZL730NiW07MT5fTmh+TdI7MXUehvg1xBAxELLQ8Hlacu6D
 p/LLuhR9PeroMnQT+DJhdT8H82CTOSfadIG2Xb2P0xshGSSUfZjyI3MEPH4h+/XHVdKgt8
 KsKgzpLR1onAX8lWN7rtnK4T2VXV+jQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-U0aWHmHUPFODR76_zNbZPA-1; Fri, 26 Jun 2026 06:18:39 -0400
X-MC-Unique: U0aWHmHUPFODR76_zNbZPA-1
X-Mimecast-MFC-AGG-ID: U0aWHmHUPFODR76_zNbZPA_1782469118
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4924207e640so5998235e9.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469118; x=1783073918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mhiC52oMwva++W28QseFLMsKqB/LHrv1Okp1RGXU2gI=;
 b=e+AjS5deDWKtzn0uVuCQQRc+xH7JqaT/NWYKlqT6fqLn0Q24/O0vJSea34KSYVKHWU
 EXl51Td8g2XyktaiH+pWj9TxFEDg2RrEq4LQRYoYvIWiP82mU7ZJQPLm9HvoUzLB0ejf
 1iQT0d3VK+xGn0gQ91dflSwoAzuSzj3gRHCljqzWIW5FUkDYe5zO/GKfyqJoK9K8rSAU
 43nwEYXAg96TpneZ1ghInEA7CO7LpVV46VAAUvYsZIFxffqyYJLbTGPbEi1tOhCJKhOv
 iAQkSJv/lflGnddp+GHoU96O36Xs4xQhkAmb+A8+sx8W3fidZJQjSsZRjYkD4oeygBJa
 at0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469118; x=1783073918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mhiC52oMwva++W28QseFLMsKqB/LHrv1Okp1RGXU2gI=;
 b=lh44vD9JJ/7Ia2KLiVk+RMvRYl3obKrgC1uMjPQay2jsT/mRsqQ7DrLw81FrTN8ejq
 KG5Uw/KzGHIJkizEu1cy9j8JtHUTMohzz6BZO7RA1zKuC2hoWRhhXRR9rIE0fq7Rwn3Z
 zSiybqMuBkiXubbr/lvFkKqfN0jLADrk4r0b5fNuQYkbvRKeSgg35TCgIQnS1k9rKu9t
 EUKNn5CA8hVKVjib4UvIRSzS8/z1oBZR6Kqekw2j1uVVXDHhyONe43FBheYS/7HPPlgH
 rsJCCHbDT7QyBwVSIN5zz+jlK+5NGZukrZPRK6lfJTr1r3d5NEK2DvkAxs2gJkaj6L4u
 QLBg==
X-Gm-Message-State: AOJu0YzLrLRLd6XUwZcQ/3/HxQVrtUUTKHgBoPlQG11vK5/5WT95CFDF
 1R3qXt209dL+4cdpMaQzlYMYq26U7ww64ef/T4J1WSIYcr/94UKmm5k4BucctYZd6iuTV+r0nEa
 MYMNr3SXRIYgZfurT0HD6jGFVww/yL7ABPY7LpuoIUr7ZZsWE+4wKo9fGeRMR5P4lgXtLKmjJPY
 h9ewUmcxDy7XWZvslXrDROcpaGmLwVsXN4WycZWIXI
X-Gm-Gg: AfdE7cm3ze2z8XDHJoDXLOPe+p0mrdOObYESjzr2IZbbIy1MOJWIZW427+fCgWuO4KU
 aetRf9KyD0fmrB8tHTXqdbWBsyeGOVmGv9kCe9jS8vlCROMMpvYwwruU1H3hNAam2+NuY48b151
 AsJsKLGIE/COXplhfr3VrwthF+8+XrbF2FeXofxvTnwrl1GKLUy4kmBfDBd5Lo2TPThZ2wgqOkw
 KQgCYZGKicy8kTRPT/vTfH3xDADXalWC0cf/yUUeSChpJzvUlaFoLZhPw9YNj5hTW07PoCLUHEf
 DSlM5xoZp6RfdxuKSS0J0SYu3e0zD+lFHd2mHjR6wyrBxE9F3kQvMBpSJvU/aAzcw+JJJHINZZ6
 f4VRzloIlS/WNCkKxCicNUIXcx1JPuVc5AHdSMiTmBBAqx0iyZn3iG76rm/NSXxnTNIcdfuEtNf
 JavlerkRIJ7fSILmDY
X-Received: by 2002:a05:600c:a05:b0:492:2c87:3d4b with SMTP id
 5b1f17b1804b1-4926fc3a645mr2130865e9.12.1782469118265; 
 Fri, 26 Jun 2026 03:18:38 -0700 (PDT)
X-Received: by 2002:a05:600c:a05:b0:492:2c87:3d4b with SMTP id
 5b1f17b1804b1-4926fc3a645mr2130295e9.12.1782469117813; 
 Fri, 26 Jun 2026 03:18:37 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268fe949csm79304185e9.5.2026.06.26.03.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:18:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 17/45] accel/mshv: update s->irq_routes in add_msi_route
Date: Fri, 26 Jun 2026 12:17:20 +0200
Message-ID: <20260626101748.1728079-18-pbonzini@redhat.com>
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

The irq_routes field of the state is populated with native mshv irq
route entries. The allocation logic is modelled after the KVM
implementation: we will always allocate a minumum of 64 entries and use
a bitmask to find/set/clear GSIs.

The old implementation of add_msi_routes will be removed in a subsequent
commit.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260417105618.3621-9-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv.h   |  3 +-
 accel/accel-irq.c       |  2 +-
 accel/mshv/irq.c        | 89 +++++++++++++++++++++++++++++++++++++----
 accel/stubs/mshv-stub.c |  2 +-
 4 files changed, 85 insertions(+), 11 deletions(-)

diff --git a/include/system/mshv.h b/include/system/mshv.h
index 1e9bcc1b0b6..d22f82982d0 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -33,6 +33,7 @@
 #endif
 
 #define MSHV_MAX_MSI_ROUTES 4096
+#define MSHV_MIN_ALLOCATED_MSI_ROUTES 64
 
 #define MSHV_PAGE_SHIFT 12
 
@@ -59,7 +60,7 @@ int mshv_request_interrupt(MshvState *mshv_state, uint32_t interrupt_type, uint3
                            uint32_t vp_index, bool logical_destination_mode,
                            bool level_triggered);
 
-int mshv_irqchip_add_msi_route(int vector, PCIDevice *dev);
+int mshv_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev);
 int mshv_irqchip_update_msi_route(int virq, MSIMessage msg, PCIDevice *dev);
 void mshv_irqchip_commit_routes(void);
 void mshv_irqchip_release_virq(int virq);
diff --git a/accel/accel-irq.c b/accel/accel-irq.c
index 7e71b525557..5a97a345b23 100644
--- a/accel/accel-irq.c
+++ b/accel/accel-irq.c
@@ -21,7 +21,7 @@ int accel_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev)
 {
 #ifdef CONFIG_MSHV_IS_POSSIBLE
     if (mshv_msi_via_irqfd_enabled()) {
-        return mshv_irqchip_add_msi_route(vector, dev);
+        return mshv_irqchip_add_msi_route(c, vector, dev);
     }
 #endif
     if (kvm_enabled()) {
diff --git a/accel/mshv/irq.c b/accel/mshv/irq.c
index 82f2022c7c3..9d6bdde27ac 100644
--- a/accel/mshv/irq.c
+++ b/accel/mshv/irq.c
@@ -278,18 +278,91 @@ static int irqchip_update_irqfd_notifier_gsi(const EventNotifier *event,
     return register_irqfd(vm_fd, fd, virq);
 }
 
-
-int mshv_irqchip_add_msi_route(int vector, PCIDevice *dev)
+static int irqchip_allocate_gsi(MshvState *s, int *gsi)
 {
-    MSIMessage msg = { 0, 0 };
-    int virq = 0;
+    int next_gsi;
 
-    if (pci_available && dev) {
-        msg = pci_get_msi_message(dev, vector);
-        virq = add_msi_routing(msg.address, le32_to_cpu(msg.data));
+    /* Return the lowest unused GSI in the bitmap */
+    next_gsi = find_first_zero_bit(s->used_gsi_bitmap, s->gsi_count);
+    if (next_gsi >= s->gsi_count) {
+        return -ENOSPC;
     }
 
-    return virq;
+    *gsi = next_gsi;
+
+    return 0;
+}
+
+static void irqchip_release_gsi(MshvState *s, int gsi)
+{
+    clear_bit(gsi, s->used_gsi_bitmap);
+}
+
+static void add_routing_entry(MshvState *s, struct mshv_user_irq_entry *entry)
+{
+    struct mshv_user_irq_entry *new;
+    int n, size;
+
+    if (s->irq_routes->nr == s->nr_allocated_irq_routes) {
+        n = s->nr_allocated_irq_routes * 2;
+        if (n < MSHV_MIN_ALLOCATED_MSI_ROUTES) {
+            n = MSHV_MIN_ALLOCATED_MSI_ROUTES;
+        }
+        size = sizeof(struct mshv_user_irq_table);
+        size += n * sizeof(*new);
+        s->irq_routes = g_realloc(s->irq_routes, size);
+        s->nr_allocated_irq_routes = n;
+    }
+
+    n = s->irq_routes->nr;
+    s->irq_routes->nr++;
+    new = &s->irq_routes->entries[n];
+
+    *new = *entry;
+
+    set_bit(entry->gsi, s->used_gsi_bitmap);
+
+    trace_mshv_add_msi_routing(entry->address_lo | entry->address_hi,
+                               entry->data);
+}
+
+int mshv_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev)
+{
+    struct mshv_user_irq_entry entry = { 0 };
+    MSIMessage msg = { 0 };
+    uint32_t data, high_addr, low_addr;
+    int gsi, ret;
+    MshvState *s = MSHV_STATE(c->accel);
+
+    if (!pci_available || !dev) {
+        return 0;
+    }
+
+    msg = pci_get_msi_message(dev, vector);
+
+    ret = irqchip_allocate_gsi(mshv_state, &gsi);
+    if (ret < 0) {
+        error_report("Could not allocate GSI for MSI route");
+        return -1;
+    }
+    high_addr = msg.address >> 32;
+    low_addr = msg.address & 0xFFFFFFFF;
+    data = le32_to_cpu(msg.data);
+
+    entry.gsi = gsi;
+    entry.address_hi = high_addr;
+    entry.address_lo = low_addr;
+    entry.data = data;
+
+    if (s->irq_routes->nr < s->gsi_count) {
+        add_routing_entry(s, &entry);
+        c->changes++;
+    } else {
+        irqchip_release_gsi(s, gsi);
+        return -ENOSPC;
+    }
+
+    return gsi;
 }
 
 void mshv_irqchip_release_virq(int virq)
diff --git a/accel/stubs/mshv-stub.c b/accel/stubs/mshv-stub.c
index e499b199d9d..998c9e2fc6c 100644
--- a/accel/stubs/mshv-stub.c
+++ b/accel/stubs/mshv-stub.c
@@ -14,7 +14,7 @@
 
 bool mshv_allowed;
 
-int mshv_irqchip_add_msi_route(int vector, PCIDevice *dev)
+int mshv_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev)
 {
     return -ENOSYS;
 }
-- 
2.54.0


