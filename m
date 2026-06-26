Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11A4CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3eO-0008Fx-1u; Fri, 26 Jun 2026 06:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3e1-0007Qf-7j
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3dz-0005Cf-BD
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PUsDLLw3f+BtqliRgCOEc8pOa9czxBjabKlNn2cuJDs=;
 b=cnn5DaqXQXilmmXekeVD+YW/yEdw+xwrjFIG9s9UX0qtLzYpvlitubLNM9Socxs4AwWQeF
 I//wQwyAaBLP4rZdldPuxAYS1dxxGZb6Rddw47VEMsFy9eX+KO49ah4xZr1C0kIe2MJhb7
 K+jj+Ou6GDS6+u+4Blf9Df9EJybZH+M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-WiQRO7l_P-SaTGhnwYSHtQ-1; Fri, 26 Jun 2026 06:18:37 -0400
X-MC-Unique: WiQRO7l_P-SaTGhnwYSHtQ-1
X-Mimecast-MFC-AGG-ID: WiQRO7l_P-SaTGhnwYSHtQ_1782469116
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490b7959b9fso6343145e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469116; x=1783073916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PUsDLLw3f+BtqliRgCOEc8pOa9czxBjabKlNn2cuJDs=;
 b=UKL3mqKtiBrtbPZjicxJ1uQlt8sXGUXzEcutOeuMSlaaQ/h3n194Jcu79NpQPmnVNi
 YSpQBabD3lPS6YI0/h0ugKRg5EdTNakGeehFXnhC+LuahghDWWUb2CgDJvm3HCXsbq/o
 IlR1mWPVoPiVD9tZRp0FSd0hB3lPIRsJOeQYX9iHONi2J/TnrGFT9JgddiZlZ4H/SPEs
 da9rcaI+QntYv9oReIn3SyE7M0gPjpXQlqL3wlAJkAgSLR/r9OpBV7LGnq2wVzLAFqw6
 QHjVjhiiyQBifloRZHa+BN2PNIpSCaq/B9O4pgn5vRmNCrhquLsJgTa36zstdwt1aHEz
 oO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469116; x=1783073916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PUsDLLw3f+BtqliRgCOEc8pOa9czxBjabKlNn2cuJDs=;
 b=KxztAbWArcl7sH3NODvcrnACPKk11racgn+H5MgulLN0BsQWZUjYK+XGCwyS6zK4SY
 qRjf/+/LiYBfx511d+oVhqsoT/e5E3sUu3h8QP0xOERAF1nQWMwPMw+zHBzGGR9leXk8
 sEXLj29gfT5UeQn9Lzrr7z+qx3olUx++d8R5L0MJQwWtlALhhdcv9Fzk0UBrYURRokNq
 frfbcRqe40O5OXQDR1KMIDBoAD+k/fvgaC8FYIuUTalvolO28Pmomup55He8PdDCgkCJ
 rVXumthhzjNHFVN2L2lTlEluCivbg/UQ1M9jKId/6DOoWtHCQGNsKHyUbyLZBpFWNyKX
 H0Mw==
X-Gm-Message-State: AOJu0YwPHn9QsBFL5S/7mFhNVmZ4jvt0f1oVricFEtminUeuOFARMyym
 b+65T/SbTpsJ/ZBk4+pWkEAGmqfjxXV++Qbegghv+56JRBGIl5MOXeRDZHzW+mC2MXzpEWBXe/8
 VOTOKi2bzoH/x9we2c5rdESHW3zijvFOuqYYusBwkQf273OUVzzeQqvDUrUZh6NDfs4Lf5EiWR4
 9WibLu/9L1YfKZpfKwojYDG55s7oJC/7TZglt0HijI
X-Gm-Gg: AfdE7cnDA2yEK2wnkJwnnHgMOaGxWaRyqjn0fhh3+paj0vvfWZ6pPBANuaSUwscrTr5
 Q16dQT4cuP3QUZ4PGcEmzcxZc2Cc2kYdPbWrAZYgaQuLZWFWdXaoDpt79FKWwkNYq0LmXkjE4py
 +XsWA+Lv/K1+EU/Pdl6kNQu8/W4+0BgW/AWWPNzqfM4hDsHuXNjkGIrY47fi1NXBsCf5+PpdsaL
 fpAIS/TfqzTwINucZANrV4splDKCCriLkHLkEQR+z5K4r7oCjeL3F9OcC+Xywmu0ZIYMSX9Lv2C
 qjCLQoInZ2lLCFE4p1R8AWmr20VN2wOIDQ2ifUfrQwbMzqpzgZyr7eKYlGZ6GH6AnSQh7gYMEGY
 t4UgdKdSUpsiFiDWM8NTHNVDWJgQ9Zzss5pkcShFG/8l4PSshLmfqLfQgxJVAqAkzocEKQysiQP
 Nu8rAuw/1ldrpY0Mm7
X-Received: by 2002:a05:600c:3f18:b0:490:c6c2:52 with SMTP id
 5b1f17b1804b1-4926686b4c0mr91158765e9.3.1782469115641; 
 Fri, 26 Jun 2026 03:18:35 -0700 (PDT)
X-Received: by 2002:a05:600c:3f18:b0:490:c6c2:52 with SMTP id
 5b1f17b1804b1-4926686b4c0mr91158325e9.3.1782469115147; 
 Fri, 26 Jun 2026 03:18:35 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492690168d5sm92157205e9.14.2026.06.26.03.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:18:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 16/45] accel/mshv: add irq_routes to state
Date: Fri, 26 Jun 2026 12:17:19 +0200
Message-ID: <20260626101748.1728079-17-pbonzini@redhat.com>
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

This change adds fields related to irq routing to the MSHV state, following
similar fields in the KVM implementation.

So far the fields are only initialized, they will be used in subsequent
commits for bookkeeping purposes and storing uncommitted interrupt routes.

The TYPE_MSHV_ACCEL defines have been moved to the header.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260417105618.3621-8-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv.h     |  7 +++++++
 include/system/mshv_int.h |  5 +++++
 accel/mshv/irq.c          | 10 ++++++++++
 accel/mshv/mshv-all.c     |  6 ++----
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/system/mshv.h b/include/system/mshv.h
index 8dd77a76241..1e9bcc1b0b6 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -45,7 +45,13 @@ extern bool mshv_allowed;
 #define mshv_msi_via_irqfd_enabled() mshv_enabled()
 #endif
 
+#define TYPE_MSHV_ACCEL ACCEL_CLASS_NAME("mshv")
+
 typedef struct MshvState MshvState;
+
+DECLARE_INSTANCE_CHECKER(MshvState, MSHV_STATE,
+                         TYPE_MSHV_ACCEL)
+
 extern MshvState *mshv_state;
 
 /* interrupt */
@@ -60,6 +66,7 @@ void mshv_irqchip_release_virq(int virq);
 int mshv_irqchip_add_irqfd_notifier_gsi(const EventNotifier *n,
                                         const EventNotifier *rn, int virq);
 int mshv_irqchip_remove_irqfd_notifier_gsi(const EventNotifier *n, int virq);
+void mshv_init_irq_routing(MshvState *s);
 
 /* cpuid */
 uint32_t mshv_get_supported_cpuid(uint32_t func, uint32_t idx, int reg);
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 1d9902c9bbe..a0fa9a50f76 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -48,6 +48,11 @@ struct MshvState {
     int nr_as;
     MshvAddressSpace *as;
     int fd;
+    /* irqchip routing */
+    struct mshv_user_irq_table *irq_routes;
+    int nr_allocated_irq_routes;
+    unsigned long *used_gsi_bitmap;
+    unsigned int gsi_count;
 };
 
 typedef struct MshvMsiControl {
diff --git a/accel/mshv/irq.c b/accel/mshv/irq.c
index 3c238c33c33..82f2022c7c3 100644
--- a/accel/mshv/irq.c
+++ b/accel/mshv/irq.c
@@ -396,3 +396,13 @@ int mshv_reserve_ioapic_msi_routes(int vm_fd)
 
     return 0;
 }
+
+void mshv_init_irq_routing(MshvState *s)
+{
+    int gsi_count = MSHV_MAX_MSI_ROUTES;
+
+    s->irq_routes = g_malloc0(sizeof(*s->irq_routes));
+    s->nr_allocated_irq_routes = 0;
+    s->gsi_count = gsi_count;
+    s->used_gsi_bitmap = bitmap_new(gsi_count);
+}
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index a6263effa41..2ed3ef4b841 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -43,10 +43,6 @@
 #include <err.h>
 #include <sys/ioctl.h>
 
-#define TYPE_MSHV_ACCEL ACCEL_CLASS_NAME("mshv")
-
-DECLARE_INSTANCE_CHECKER(MshvState, MSHV_STATE, TYPE_MSHV_ACCEL)
-
 bool mshv_allowed;
 
 MshvState *mshv_state;
@@ -536,6 +532,8 @@ static int mshv_init(AccelState *as, MachineState *ms)
 
     mshv_state = s;
 
+    mshv_init_irq_routing(s);
+
     register_mshv_memory_listener(s, &s->memory_listener, &address_space_memory,
                                   0, "mshv-memory");
     memory_listener_register(&mshv_io_listener, &address_space_io);
-- 
2.54.0


