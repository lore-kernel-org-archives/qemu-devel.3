Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED049FCA179
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzfo5-0003zf-3p; Mon, 09 Mar 2026 14:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzfo3-0003yp-Es
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:58:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzfo1-0007pw-Fq
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773082696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AvStR8y6hpWDqE72q8INHMrameFwTjMrV5Vu65iKqaE=;
 b=ERxDdSblX3/mV6AMpPRwqgDSE8DxvOFctZ2w54Dr1s86sTkmgXByX7stwG2h2tDQ869rxP
 WRMyQIhUwITGpK2T1UU9KxFM9HXCK3bkGg/Rq935qFJMbcDwDcERhk0sFihGA8cwZENeSh
 F8pwfdQ+CM/iP1pCZMOGNT95UWjrnjM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-PI71__xoP-qvVxKwKTJOyQ-1; Mon, 09 Mar 2026 14:58:15 -0400
X-MC-Unique: PI71__xoP-qvVxKwKTJOyQ-1
X-Mimecast-MFC-AGG-ID: PI71__xoP-qvVxKwKTJOyQ_1773082694
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439c794edd9so6108939f8f.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 11:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773082693; x=1773687493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AvStR8y6hpWDqE72q8INHMrameFwTjMrV5Vu65iKqaE=;
 b=EfUXVLsl1FST+4jlRiQw6fgUdbiPHxOVQYIFR0/CRiG+y4M3Xc1wIzT4kEfZ/QeW2m
 UZTIc80sF4CBzU9PTr5/7mizCs0Si18ywcPt2zg+6kX8+FkrO56T/16x8+U4Au0O4v9y
 fS4LEku63VMyYZJj1q2BB4Cab8d1RI3li7Xc06KkH2ZpjNfcbieXzuH0tI4bej/ad0j/
 FdWo6v25y/AcKruzSpZ0liVIob9B79EFd3STjPcwX+qepzwiSMJE5cl5dY25vR28iW5n
 hbBtG3pJlkK6Gv5/fzc8/4yjjfYcOTYmA+QHHCt6yRW59UFX7cw7UlxV9uUdVb7BVzog
 CphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773082693; x=1773687493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AvStR8y6hpWDqE72q8INHMrameFwTjMrV5Vu65iKqaE=;
 b=hdaCxv76zli2AXU2/qnDyYvbeBoBWniuI0sEnEwiZUgRSX0jfqcJ1CAtVbUmMQmSWX
 fZtXm/7em4dKoaJYrGPiowv4x2joB9isSssfoVW59nGahYVVFY0VZFxe/iPuYgDYEput
 JNxryacNZ9rkgn5eAEn6Gk6bunZR2dvFfvzxBtc6jTUJZJ3elvBpg8ZDcUyFYhzICkqw
 dqpYQnvo7Xv4l17yohO33EvksVyzET7BSPHF28nOf3yHzWSmQUXmrlNDf9eDe8ETUlDh
 26N144ccOBB0FcuKgBrrbi+7hHSdLl0Wu+l9aPBd3XvvTMUUMCTYXTS5vQcghKJP+sSa
 aNVA==
X-Gm-Message-State: AOJu0YzgAz2Gp8i9J+V/nTISqpfB6nEIDYtR1l4fx8Crjug7licA+FCK
 21hub7JpHk0TtNJmPGOqZ+1u4vRAZvb92dXTO/BVuYalzoi9Kks66RCwHpAEtXgbnAAARSWuqJd
 7DQEtuZfewly9F4iEDd8XE47rgTlK2a0wa93RdwfL6Z/obh3rS/ObwHuIkkEJdpFlk9hcCPs4pH
 r3AEmSnX9jTg9VAtwa8C0NDCfO8ok/Ghx+GBFFWZJQ
X-Gm-Gg: ATEYQzw+JWvmtSSi+3F4dgtexRguxIf3GPqgENF/yKcnwTI/ule74kz85tTgD1fLL+O
 YQUYCm/slGLYyX5kkhXpYevpuZveuW21RamW0rDKYzggvQeygTVuC/gopzghcQzrDZ5B2rK/q8b
 ouKhSbXXKj/DafT10Zpt0HlA92uF9b8yJZfqvH2tIfdRseDT8XQGOh4FSqLx0Ux9DzebhoGybHF
 +JkvV3gwnx23mArkn1o2tKAneI69hEtgfZqzLQHocqIUo20/9c68LGZSJpcE1KyLyvxtPhvVR0w
 PaORCavL7t2x4KpcX5HBJIHc923IJeseWD4pZ8ts5d5WlocKjl6WrzlLHbRyhp7zK1Pl0rlTDpw
 HYY5XvckOZV1MssxGfwrfD53vU1d3beo05u/gyWF93626Z5ApWOyVtlMVCDNhQvkBWIadK5A9R/
 Vh3hs1pISn17V6BWy8XbEbnGZUQag=
X-Received: by 2002:a05:6000:40dc:b0:439:c9d0:5fc2 with SMTP id
 ffacd0b85a97d-439da891b2cmr20700000f8f.39.1773082693092; 
 Mon, 09 Mar 2026 11:58:13 -0700 (PDT)
X-Received: by 2002:a05:6000:40dc:b0:439:c9d0:5fc2 with SMTP id
 ffacd0b85a97d-439da891b2cmr20699941f8f.39.1773082692510; 
 Mon, 09 Mar 2026 11:58:12 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae49177sm27632397f8f.35.2026.03.09.11.58.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 11:58:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 08/10] whpx: make Hyper-V enlightenments configurable
Date: Mon,  9 Mar 2026 19:57:50 +0100
Message-ID: <20260309185752.76865-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309185752.76865-1-pbonzini@redhat.com>
References: <20260309185752.76865-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Have them be a machine option instead of a CPU one, to have something available, even if not ideal...

The existing Hyper-V enlightenments configuration mechanism is part of per-CPU configuration, which happens too late for this.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260307181856.2209-8-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/whpx-internal.h |  4 ++++
 accel/whpx/whpx-common.c       | 43 ++++++++++++++++++++++++++++++++++
 target/i386/whpx/whpx-all.c    | 20 +++++++++-------
 3 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 7a1c9871f18..8482901f714 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -42,6 +42,10 @@ struct whpx_state {
 
     bool kernel_irqchip_allowed;
     bool kernel_irqchip_required;
+
+    bool hyperv_enlightenments_allowed;
+    bool hyperv_enlightenments_required;
+
 };
 
 extern struct whpx_state whpx_global;
diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 4863fc86631..b813a5d9d25 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -470,6 +470,41 @@ static void whpx_set_kernel_irqchip(Object *obj, Visitor *v,
     }
 }
 
+static void whpx_set_hyperv(Object *obj, Visitor *v,
+                                   const char *name, void *opaque,
+                                   Error **errp)
+{
+    struct whpx_state *whpx = &whpx_global;
+    OnOffAuto mode;
+
+    if (!visit_type_OnOffAuto(v, name, &mode, errp)) {
+        return;
+    }
+
+    switch (mode) {
+    case ON_OFF_AUTO_ON:
+        whpx->hyperv_enlightenments_allowed = true;
+        whpx->hyperv_enlightenments_required = true;
+        break;
+
+    case ON_OFF_AUTO_OFF:
+        whpx->hyperv_enlightenments_allowed = false;
+        whpx->hyperv_enlightenments_required = false;
+        break;
+
+    case ON_OFF_AUTO_AUTO:
+        whpx->hyperv_enlightenments_allowed = true;
+        whpx->hyperv_enlightenments_required = false;
+        break;
+    default:
+        /*
+         * The value was checked in visit_type_OnOffAuto() above. If
+         * we get here, then something is wrong in QEMU.
+         */
+        abort();
+    }
+}
+
 static void whpx_cpu_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
@@ -498,6 +533,11 @@ static void whpx_accel_class_init(ObjectClass *oc, const void *data)
         NULL, NULL);
     object_class_property_set_description(oc, "kernel-irqchip",
         "Configure WHPX in-kernel irqchip");
+    object_class_property_add(oc, "hyperv", "OnOffAuto",
+        NULL, whpx_set_hyperv,
+        NULL, NULL);
+    object_class_property_set_description(oc, "hyperv",
+        "Configure Hyper-V enlightenments");
 }
 
 static void whpx_accel_instance_init(Object *obj)
@@ -507,6 +547,9 @@ static void whpx_accel_instance_init(Object *obj)
     memset(whpx, 0, sizeof(struct whpx_state));
     /* Turn on kernel-irqchip, by default */
     whpx->kernel_irqchip_allowed = true;
+
+    whpx->hyperv_enlightenments_allowed = true;
+    whpx->hyperv_enlightenments_required = false;
 }
 
 static const TypeInfo whpx_accel_type = {
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index bc82995b33e..b095c96962d 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2232,15 +2232,17 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         synthetic_features.Bank0.DirectSyntheticTimers = 1;
     }
 
-    hr = whp_dispatch.WHvSetPartitionProperty(
-            whpx->partition,
-            WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks,
-            &synthetic_features,
-            sizeof(WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS));
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to set synthetic features, hr=%08lx", hr);
-        ret = -EINVAL;
-        goto error;
+    if (whpx->hyperv_enlightenments_allowed) {
+        hr = whp_dispatch.WHvSetPartitionProperty(
+                whpx->partition,
+                WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks,
+                &synthetic_features,
+                sizeof(WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS));
+        if (FAILED(hr)) {
+            error_report("WHPX: Failed to set synthetic features, hr=%08lx", hr);
+            ret = -EINVAL;
+            goto error;
+        }
     }
 
     /* Register for MSR and CPUID exits */
-- 
2.53.0


