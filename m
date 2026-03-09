Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9DDFCA16E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzeee-000314-2t; Mon, 09 Mar 2026 13:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzeeI-0002kw-Am
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:44:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzeeD-00027C-30
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773078242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AvStR8y6hpWDqE72q8INHMrameFwTjMrV5Vu65iKqaE=;
 b=U3GuwWV25EINIp+EG9gZjSLgTRlN9FYGly0p7msjgCZdhEPsRfr0azxMQ/fsjbNNFFerXB
 faOqfYWATfPxrMdSp+4Oybxt7tHW0NINhFLgGAjMhgsj3krdUnqbB2noU2SCxOTADFyffq
 xMQpR8f4zDK58Zw6CpxEEpQ98kQO+kQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-7CFWlS42No6cTueZ5j3vfQ-1; Mon, 09 Mar 2026 13:44:01 -0400
X-MC-Unique: 7CFWlS42No6cTueZ5j3vfQ-1
X-Mimecast-MFC-AGG-ID: 7CFWlS42No6cTueZ5j3vfQ_1773078240
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-439db9da59eso2976584f8f.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773078239; x=1773683039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AvStR8y6hpWDqE72q8INHMrameFwTjMrV5Vu65iKqaE=;
 b=e9xLENHqhMEM4Bgxh9UOh7n4UPzLhQrO3OXMQD829c+N4ptxQzkiy7uXfh33Iyags2
 ftT7tWY3A3S6re8mVJBmjGsmW7o1kL2iaOBHro6f5w4pJfOAYwO5mcYJb0eYIoAfYKvf
 BSm/X0KMm5annWgl4Mo1SWGYRsgG8aZk8MHfkdk3LewA0AVs+mKm9/IXmYH/RGaNK5v3
 JR2zuEBKF8mIdPHWv/GhbvrLT6vTHaPrDwqX9ruFaJEbKjzYLKHvKLGw7VsUbVq2zqbD
 RuRrVjUewARubzBjyCJB/FdbB4OGrgmUTBB1XuI5ovtvDEoVMqg3x8F3aLonR738msLc
 jvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773078239; x=1773683039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AvStR8y6hpWDqE72q8INHMrameFwTjMrV5Vu65iKqaE=;
 b=LJh1I+IPkTQNzBfTQiIW8O/1TPHbYeDzwuR3UhfenxLCEbHjJwQ85/ESYzjdEkycV5
 MlNfI8WdzOM7YRXcUWN9TIe/cV+S2hfuIv3Y6BrAlema85aC51zLWeBv0qxN1O9SiDyo
 NuYzVGJSc9fKFBpTg5RSkmqlnEo5hMNCVB7pqgkoXc3IGxLok7/GmkB37qQSNzg7okND
 HSPvYkPlsD61c5KRzHPBXulSdm7NQTaKIfkajwcT0iAWEIX8JnTqn3Ib2diITz3MBls5
 TIxEbeNXlS/EhGKD6kVoVisgVeuFYTJ5TqiuKJRidVBtEOFjAzyx2Qehr2WVB62ZMual
 EhWw==
X-Gm-Message-State: AOJu0YzXbgR0+W+Hh+AVH+HciO6UBfgJml78KsENG6Q949jErEJa2rvX
 ZPUCeKSVIcFgf4tN+h/fg36Xf1oxGndfPaBmnMFztFFGEdljKPbIE0zTPCHd1tyt1+11SAWqx7I
 vdjiOlCCiw2mKMDZaay2olSGSpCB9N6Ju2m6vWrLwOZ/GTU4d26DXvMwmLngVwAY2sAfcWREW/S
 7SSzqLe7OEbOmxNvHBZ2Av/kX3OyAHQXUma0h7QuUF
X-Gm-Gg: ATEYQzz95Wx8JqgmJdsoTRgVFJ80sMDKw2z1jpgWZaNCWLa+BIXArMFS0MM8nG0hgtO
 Nt25+6NRmV/s1B3/F6yuduxJ3m45jl9Q/vdm1pnsGdTkPkMoJrVxkA6W1ZD5V0BCKtRlfjZypXq
 GJPFxhLje8g4F80fyKtr5oa/FCXbOgPEjwe4Ls4Yn6wMRZqDjh8z+PwtmLftEb6SMO2TcEemG6W
 gtKjwYsGr25gn10G1dTJ5SI3NGx96QK+0pAcXnJJfNiyY/L5MA9rHpyIjCvmzVzezKK2ufVmXWh
 JJOZRORL1RVwbRh39zE9j+WnCNiBaUvEK3Tu1sZYoGksKj+mt2ExnOAI+EiXrZCEiFKqNV5uLVf
 PoSDpb+6cZQ77sJ2MYbfDUB+aBhxadHIZHqFsotlWbzSV2boRPyeXcKQOGQEX78lq6QGL/4vXO7
 gCnwV5Pv6lB2o3leVbDUGR33/WNbA=
X-Received: by 2002:a05:6000:1865:b0:439:bcab:405e with SMTP id
 ffacd0b85a97d-439da885f29mr20835406f8f.35.1773078239007; 
 Mon, 09 Mar 2026 10:43:59 -0700 (PDT)
X-Received: by 2002:a05:6000:1865:b0:439:bcab:405e with SMTP id
 ffacd0b85a97d-439da885f29mr20835353f8f.35.1773078238475; 
 Mon, 09 Mar 2026 10:43:58 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad977f8sm28153260f8f.9.2026.03.09.10.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 10:43:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 08/10] whpx: make Hyper-V enlightenments configurable
Date: Mon,  9 Mar 2026 18:43:38 +0100
Message-ID: <20260309174340.52174-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309174340.52174-1-pbonzini@redhat.com>
References: <20260309174340.52174-1-pbonzini@redhat.com>
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


