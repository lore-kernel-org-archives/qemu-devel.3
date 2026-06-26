Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42ABACDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3eP-0008OD-Ev; Fri, 26 Jun 2026 06:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3e5-0007Zd-6X
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3e3-0005E5-Cl
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OWP9XDpj+EGYpU1Ify8+MzQOA8NeeXt9VeHs8FaCu1A=;
 b=Qw4vCGd9DsAwgfmLzb72PGasNc/4pdcxrmXXxa5h10LMcjEwO8lqZgJ5de6PANUBm/j+Gr
 V7l8ZPaGLPgZ7mdM80XKCy1vrkvUXeordWTcTu2UbGHjljQN7KOYksdDdunRg68j/ckAZq
 HmchBfxX72lVEBfgmMN4vOLvRVRIyV0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-zQeLGFxNOJiKtKWCoQ4n7w-1; Fri, 26 Jun 2026 06:18:45 -0400
X-MC-Unique: zQeLGFxNOJiKtKWCoQ4n7w-1
X-Mimecast-MFC-AGG-ID: zQeLGFxNOJiKtKWCoQ4n7w_1782469124
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-46f48f2d9cbso238383f8f.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469124; x=1783073924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OWP9XDpj+EGYpU1Ify8+MzQOA8NeeXt9VeHs8FaCu1A=;
 b=GGFA1H049JyFpKJ4bxYhvlAKUWpmgtlce/+q4cEOQQijXnzYQ0svCyfyka6yUr1kmM
 BcCnh28LMMWvhydtsP1kXcOCgZx7pwFM3lpuw9CZwG6nFoiFQhnZxksGfMS6YqWekJ/Z
 Mc5bGh4uyU9JfErotXb1SecaVN8v8of9RPf8/OZp7itHZ2d9HtqUMo7sbCsx0+Raui8h
 sbAiqOqqqqGjO8/JgshYbj565mAvyIePjcSqD/c4LIslBrhRBqykNO3ufe/ZUslZlOHo
 Oi4kz2VKJaRng8tAZfPy1VaQB8OCvcKP2LAs3LjRFlCPQ+bInWTU3alRHeHf8JpvPqJZ
 opFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469124; x=1783073924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OWP9XDpj+EGYpU1Ify8+MzQOA8NeeXt9VeHs8FaCu1A=;
 b=GtY8+IO2NstJMt0rkMq7vg647XNunT9H5rHfswDnIQ3CF82HNh8YfSZ+zuKUHZDesR
 DYkBHZhzxf3KK2GIQ7Q2EDo/Osquvw5eq2TB73pIsgfPV6wGX4wU03N3iWsfb/3g6v1B
 atMSYoJh3ewegKNl0gzt8VsLSefslXR1v+rDzZVuqw1OkpfePg+hektdhdcDHAzMJ5P0
 7PnW+ksWXWu3CEc0QUPJ3IMpsFxPFPyzgWh+17Be2pLkkcAv67CLX5i/XxqIubMwQ95R
 C4fELaBMA2B8dbRUP/0nkcUozdI3bM5BVcH02xqATkVR7H3TP/uHTuixKx2etWKXP3YB
 JL1g==
X-Gm-Message-State: AOJu0YxiLwcfQZNHkYxeMiDW1evSnx2pvxvCZXM7kunftGnHe2U6Y/Th
 mQ+I7Exbz+qbw5Dp9CIrD1Nf+3xQrd+0zEHNfTkaxxTvipp/LNHSkleNM8uKCkkwxfOytjlOerx
 tEvIiKCY38cRwqsPsGIuAEMne8eb5AuAwcMbJNjqjo/EwuO4Xa5sE24APy2HwVW2OYMOE9i0pAI
 Q1EP0bvV2MJIhxEerOqo5Q15RAr6RbVaxs2G9fBT9v
X-Gm-Gg: AfdE7cnjzgp3GntLjXrEcoU/ZFg8gMokPnceQMPumX4HzWZE8+IkCeD+O6gNGopqo0d
 NNRfWytBF/xUU7pmtoXdiU06Sl/2TX2XgirioL082u1ndsJ7DSRk/dIwiqEcI08uyZf27bP18Wh
 fqFaugcJQ+ZX6gWheCWtXfivARp+zFydpgs72cJiAea9bAUGxffwkrK1aejVKqKvC4i8ImPJpbi
 s0cZ1JrImQsCtOfdx26VE0TUiV+Kj1afVndXFNMHz9EbtdUmKA7Pob8YI4/VEJmSvoE079SCO2U
 evT1JeEZjgAv8OvJ0cDuoYjxKSf0ft+Q5QEW9XQjr6yi7susHHRd+0hRRY8qL410xrpXU6j193N
 NCMRLwtj2A+W9F0J3KsG0cOZnEeG++QN05O4y10dYB3oKOsHxBdgV4kkLqmXTxWlkaaBLRtHh/j
 46eneVlhLQ7GPF5GgX
X-Received: by 2002:a05:600d:6447:20b0:492:259d:567 with SMTP id
 5b1f17b1804b1-4926689869amr70885165e9.23.1782469123854; 
 Fri, 26 Jun 2026 03:18:43 -0700 (PDT)
X-Received: by 2002:a05:600d:6447:20b0:492:259d:567 with SMTP id
 5b1f17b1804b1-4926689869amr70884695e9.23.1782469123325; 
 Fri, 26 Jun 2026 03:18:43 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c9f240c3dsm22417257f8f.35.2026.06.26.03.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:18:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 19/45] accel/mshv: update s->irq_routes in release_virq
Date: Fri, 26 Jun 2026 12:17:22 +0200
Message-ID: <20260626101748.1728079-20-pbonzini@redhat.com>
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
is requested to be released.

The old remove_msi_routing() fn is redundant and can be removed.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260417105618.3621-11-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv.h   |  2 +-
 accel/accel-irq.c       |  2 +-
 accel/mshv/irq.c        | 43 ++++++++++++++---------------------------
 accel/stubs/mshv-stub.c |  2 +-
 4 files changed, 17 insertions(+), 32 deletions(-)

diff --git a/include/system/mshv.h b/include/system/mshv.h
index d22f82982d0..fa716c1ee97 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -63,7 +63,7 @@ int mshv_request_interrupt(MshvState *mshv_state, uint32_t interrupt_type, uint3
 int mshv_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev);
 int mshv_irqchip_update_msi_route(int virq, MSIMessage msg, PCIDevice *dev);
 void mshv_irqchip_commit_routes(void);
-void mshv_irqchip_release_virq(int virq);
+void mshv_irqchip_release_virq(MshvState *s, int virq);
 int mshv_irqchip_add_irqfd_notifier_gsi(const EventNotifier *n,
                                         const EventNotifier *rn, int virq);
 int mshv_irqchip_remove_irqfd_notifier_gsi(const EventNotifier *n, int virq);
diff --git a/accel/accel-irq.c b/accel/accel-irq.c
index 5a97a345b23..0cb3ef78d3a 100644
--- a/accel/accel-irq.c
+++ b/accel/accel-irq.c
@@ -67,7 +67,7 @@ void accel_irqchip_release_virq(int virq)
 {
 #ifdef CONFIG_MSHV_IS_POSSIBLE
     if (mshv_msi_via_irqfd_enabled()) {
-        mshv_irqchip_release_virq(virq);
+        mshv_irqchip_release_virq(mshv_state, virq);
     }
 #endif
     if (kvm_enabled()) {
diff --git a/accel/mshv/irq.c b/accel/mshv/irq.c
index b5a047b3672..990ce346204 100644
--- a/accel/mshv/irq.c
+++ b/accel/mshv/irq.c
@@ -123,33 +123,6 @@ static int commit_msi_routing_table(int vm_fd)
     return 0;
 }
 
-static int remove_msi_routing(uint32_t gsi)
-{
-    struct mshv_user_irq_entry *route_entry;
-    GHashTable *gsi_routes;
-
-    trace_mshv_remove_msi_routing(gsi);
-
-    if (gsi >= MSHV_MAX_MSI_ROUTES) {
-        error_report("Invalid GSI: %u", gsi);
-        return -1;
-    }
-
-    assert(msi_control);
-
-    WITH_QEMU_LOCK_GUARD(&msi_control_mutex) {
-        gsi_routes = msi_control->gsi_routes;
-        route_entry = g_hash_table_lookup(gsi_routes, GINT_TO_POINTER(gsi));
-        if (route_entry) {
-            g_hash_table_remove(gsi_routes, GINT_TO_POINTER(gsi));
-            g_free(route_entry);
-            msi_control->updated = true;
-        }
-    }
-
-    return 0;
-}
-
 /* Pass an eventfd which is to be used for injecting interrupts from userland */
 static int irqfd(int vm_fd, int fd, int resample_fd, uint32_t gsi,
                  uint32_t flags)
@@ -319,9 +292,21 @@ int mshv_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev)
     return gsi;
 }
 
-void mshv_irqchip_release_virq(int virq)
+void mshv_irqchip_release_virq(MshvState *s, int virq)
 {
-    remove_msi_routing(virq);
+    struct mshv_user_irq_entry *e;
+    int i;
+
+    for (i = 0; i < s->irq_routes->nr; i++) {
+        e = &s->irq_routes->entries[i];
+        if (e->gsi == virq) {
+            s->irq_routes->nr--;
+            *e = s->irq_routes->entries[s->irq_routes->nr];
+        }
+    }
+    irqchip_release_gsi(s, virq);
+
+    trace_mshv_remove_msi_routing(virq);
 }
 
 static int update_routing_entry(MshvState *s,
diff --git a/accel/stubs/mshv-stub.c b/accel/stubs/mshv-stub.c
index 998c9e2fc6c..dadf05511a6 100644
--- a/accel/stubs/mshv-stub.c
+++ b/accel/stubs/mshv-stub.c
@@ -19,7 +19,7 @@ int mshv_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev)
     return -ENOSYS;
 }
 
-void mshv_irqchip_release_virq(int virq)
+void mshv_irqchip_release_virq(MshvState *s, int virq)
 {
 }
 
-- 
2.54.0


