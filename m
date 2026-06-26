Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2EDCDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3eU-0000VB-Kj; Fri, 26 Jun 2026 06:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3e6-0007bp-5L
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3e4-0005EQ-KL
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=snBBnAie5esZAHoCWC4JMDNV1oLlXJBK6vDWPhbHwtI=;
 b=ePZEp6m8fInDn+NN1ewdoYDrLiaJpbqXe74nRjiLcYzNPboSBinStDPzqcOBJLEu8A0gUQ
 JIC+FiQQo3tl/XxPtyDs+Rc+2V6MBM5Kjh7eZPe4mI71mbMlIAVgIsW1Hv5jCfYLbNn49z
 4/s7uSEIU4yaCunaTo99/1xj0PubmVs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-NaUPYyEDN_eV9VnyZYKpZA-1; Fri, 26 Jun 2026 06:18:46 -0400
X-MC-Unique: NaUPYyEDN_eV9VnyZYKpZA-1
X-Mimecast-MFC-AGG-ID: NaUPYyEDN_eV9VnyZYKpZA_1782469126
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-46e18156b61so730532f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469125; x=1783073925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=snBBnAie5esZAHoCWC4JMDNV1oLlXJBK6vDWPhbHwtI=;
 b=TFwLHtkbrJx1csiH14Bs/6dTgIiJGRQimrqOyX4m3sPVF1gIQ7EY6HN5OLKvSSuLwe
 Qt6DWtE61zKTmZZ3K3xJhb9ErjLwZcz8FFwLfqsGi8jQqZggUchfB4NIIXgJDciZz7Pp
 1sZ7iksVzduINHrfZiujCyAOOtSL+xG9Pt6NPthAT8vb4cwD8NW71gOb16n6UZKJkEZ6
 gJWWqJkY8wtN56JRnj5rXfpQ6DV4jGQ9jAkR5xV74JdjoSt6DsAqyCa/fxEkV7+fbrEZ
 Bln1mHuMmdozeTfq9zysNU5egtdS42EahIQ5hww3cF9pE4IWvJGvGmlm1s05tVROri9I
 Jg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469125; x=1783073925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=snBBnAie5esZAHoCWC4JMDNV1oLlXJBK6vDWPhbHwtI=;
 b=WlnE7X2Op+vxHc/56OhG+evbdET+JT+6DEtGKWu86+9uXSzr+bGHrD7VVx7ivpxo1l
 cvXt5e1I6hDj2S9aq1CnEBhJVR/bKKXpeNzimba54Zrlm/bQlZwLLvvsxThZii5L3SaW
 ul5hd7JEspMUVQqGKUmldaG778PzS+MXBbXL6YFDIc9vH+xyaLUDt3F1qFCri4TpwxiM
 DPwnOYe/tgYpoR73OeB3mpQN3lybfEM3dMskTtrZJgTKZZUaLLPRWG+UzD7nf4XWlTB5
 JgPlao79zDQAHzTlkgjnRfBmeRjKt55dc7//LgoVtacR7322O8jIUhjBPgrkoJ4njYm4
 /RCA==
X-Gm-Message-State: AOJu0YwY1cWrHffzqlwHxj/s5UAC0EcI3l/mm55+12x1uaDiPj9II8Nx
 OZpG5GQpX3nhARcHgMRGLzEXvivQbJIu8SBZPut3llbVPhc2W7DgwDFks5Lw8tTXUHDKvd4f4Xu
 IVMOl1+goQCusl3eWj8NoilhaPe4UOdq/Zm4mboWzGcHJXZQydsWZfcoJw2v0CYxuBhIdiDvyVW
 dgWCz9tfM0l0pDqShDtTXPzywbgjDqmKrKDXQ21Oo9
X-Gm-Gg: AfdE7cmQGLapC2s2IPWkQouv8CxGB2cyhbhu4QysHuetI0X44qSZeKCXIVnDNsMHSGe
 0JVesL+nXi7dnScPufqNTH2QevtgN8f5uVxFJTO9aIA43vWVPsFJAZa3j3ntHpoICcbnw8rPLyG
 7juemLO/HjKmRSoQKCm7gDnnX+BgUxW2W4C7coyiklBtfhTAEzhqzvhQOxBEHddyQvHdV6NQMbg
 c/XfYrChwQx24BQ58iTaeapA8BwRtXO8LXLDyqXReBFXOjJ4ehTGxJxt6uD4sPJWYetCcEI9cxe
 DR9hlHvrkwnQCsbABH0fcCk/LFkKA8SuipmftojW6qwjny8KMWk85oqLBqAjRezLCYdssiSAtem
 Su605/iysnFQpXViCvePehEgxhxERzDyn1SufSWA6HwC952LSMrhOw1tdvWkIVRrctbkBO6ZzG+
 j6F/mwTuSMoeKA4eO7
X-Received: by 2002:a05:600c:8b78:b0:492:38c8:c426 with SMTP id
 5b1f17b1804b1-49267198492mr82561615e9.13.1782469125521; 
 Fri, 26 Jun 2026 03:18:45 -0700 (PDT)
X-Received: by 2002:a05:600c:8b78:b0:492:38c8:c426 with SMTP id
 5b1f17b1804b1-49267198492mr82561235e9.13.1782469125034; 
 Fri, 26 Jun 2026 03:18:45 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268ffe204sm69088185e9.7.2026.06.26.03.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:18:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 20/45] accel/mshv: use s->irq_routes in commit_routes
Date: Fri, 26 Jun 2026 12:17:23 +0200
Message-ID: <20260626101748.1728079-21-pbonzini@redhat.com>
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

In mshv_irqchip_commit_routes() the entries that have been accumulated
in s->irq_routes are committed directly to MSHV's irqchip.

The old commit_msi_routing_table() fn will be removed in a subsquent commit.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260417105618.3621-12-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv.h   | 2 +-
 accel/accel-irq.c       | 2 +-
 accel/mshv/irq.c        | 7 ++++---
 accel/stubs/mshv-stub.c | 2 +-
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/system/mshv.h b/include/system/mshv.h
index fa716c1ee97..46fe3fcebc2 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -62,8 +62,8 @@ int mshv_request_interrupt(MshvState *mshv_state, uint32_t interrupt_type, uint3
 
 int mshv_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev);
 int mshv_irqchip_update_msi_route(int virq, MSIMessage msg, PCIDevice *dev);
-void mshv_irqchip_commit_routes(void);
 void mshv_irqchip_release_virq(MshvState *s, int virq);
+void mshv_irqchip_commit_routes(MshvState *s);
 int mshv_irqchip_add_irqfd_notifier_gsi(const EventNotifier *n,
                                         const EventNotifier *rn, int virq);
 int mshv_irqchip_remove_irqfd_notifier_gsi(const EventNotifier *n, int virq);
diff --git a/accel/accel-irq.c b/accel/accel-irq.c
index 0cb3ef78d3a..4303e10e408 100644
--- a/accel/accel-irq.c
+++ b/accel/accel-irq.c
@@ -55,7 +55,7 @@ void accel_irqchip_commit_routes(void)
 {
 #ifdef CONFIG_MSHV_IS_POSSIBLE
     if (mshv_msi_via_irqfd_enabled()) {
-        mshv_irqchip_commit_routes();
+        mshv_irqchip_commit_routes(mshv_state);
     }
 #endif
     if (kvm_enabled()) {
diff --git a/accel/mshv/irq.c b/accel/mshv/irq.c
index 990ce346204..9ba837f0e2e 100644
--- a/accel/mshv/irq.c
+++ b/accel/mshv/irq.c
@@ -394,16 +394,17 @@ int mshv_request_interrupt(MshvState *mshv_state, uint32_t interrupt_type, uint3
     return 0;
 }
 
-void mshv_irqchip_commit_routes(void)
+void mshv_irqchip_commit_routes(MshvState *s)
 {
     int ret;
-    int vm_fd = mshv_state->vm;
+    int vm_fd = s->vm;
 
-    ret = commit_msi_routing_table(vm_fd);
+    ret = ioctl(vm_fd, MSHV_SET_MSI_ROUTING, s->irq_routes);
     if (ret < 0) {
         error_report("Failed to commit msi routing table");
         abort();
     }
+    trace_mshv_commit_msi_routing_table(vm_fd, s->irq_routes->nr);
 }
 
 int mshv_irqchip_add_irqfd_notifier_gsi(const EventNotifier *event,
diff --git a/accel/stubs/mshv-stub.c b/accel/stubs/mshv-stub.c
index dadf05511a6..8b69539a85a 100644
--- a/accel/stubs/mshv-stub.c
+++ b/accel/stubs/mshv-stub.c
@@ -28,7 +28,7 @@ int mshv_irqchip_update_msi_route(int virq, MSIMessage msg, PCIDevice *dev)
     return -ENOSYS;
 }
 
-void mshv_irqchip_commit_routes(void)
+void mshv_irqchip_commit_routes(MshvState *s)
 {
 }
 
-- 
2.54.0


