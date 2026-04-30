Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F20CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV7f-0006up-HS; Thu, 30 Apr 2026 13:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7C-0005kW-3h
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV79-0004iB-Hg
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p4g0uz/P7j9K70N0flDT+IgeE2GHWNDfoeHg+Js6mkw=;
 b=GLSqN9VJksa2+QFkFxt5Ix5k6739AASRz7MLU7iI2GXcixhBfhd0OES6g1vvqnh6uVUfvh
 1t0sIdjQD6Bdbd6jNgDWoTfb+uY/LniOgAbfESFeYbxQyYFrw3ngDI2C2VtcZJh8Uo5DGD
 rYqfNxpMtzI5p7KRZJdmwHR7obDB9aw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-ql0aXfpxOQKw00v_3JqoWA-1; Thu, 30 Apr 2026 13:23:49 -0400
X-MC-Unique: ql0aXfpxOQKw00v_3JqoWA-1
X-Mimecast-MFC-AGG-ID: ql0aXfpxOQKw00v_3JqoWA_1777569829
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ac9609d3d6so29718456d6.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569828; x=1778174628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p4g0uz/P7j9K70N0flDT+IgeE2GHWNDfoeHg+Js6mkw=;
 b=sdL9Z313OSJIKfV175x7/cUlA/VrU5Iz84qMqMoPfekF78C+m7Vcf9WI4Utz5y+xRH
 bQtKsnppeG+xEtVt/16qOEQrNcPotfH29gz5rUltQqaizvei317Si7lGuEtJqVm6q1gm
 a3lqQCTU1Fv8/Dv32ULtitS39vBiZmB4GP2JugPWERZ6pd+kUHxvIbapRZ25W2SgJROe
 ryzco6ORZ452137qAa+TO1eL81W/8BvQgq+eEBUIXvmiffcxAAMedtVluu8tW/i6a9bh
 QksjWC+qCLvDU9wHsavyVgIhoej76O9gODrgAy9+ZrHqkd8qoCI9U9in1W4577XxKGDU
 rP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569828; x=1778174628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p4g0uz/P7j9K70N0flDT+IgeE2GHWNDfoeHg+Js6mkw=;
 b=AzlfWBSfXrQlQG1qPx3IR+qLDJSyfGbNTDtmbPhUEXbI/OPkSWze1O0w3mZ2r+RNMI
 aPKGriLXN+0RgqCKgubuxPhA3oRej20xCGJEhsvM/KYmP66vOYSkBgDy6MoWF32z0LnR
 GMjbswPwBxxrhLdC5bw+E7cvljDQ8FARp15jybpfZUbB2kAL81SMCVOXHBQzTooTf3OO
 WRmAU7yc0ePz2+czowXmfFGx52ppJbHTgcJRFZN6PuZ6/WjfAazxEXkq8V1xAOtSU0TP
 P69lruNEXstIlMWSiI0BZcTrk0GLI4YYKkeF+lA2Sm/ZuPwBO0f1ZVVjAh44RFc2wtwn
 UEfQ==
X-Gm-Message-State: AOJu0YwDF2KpgJYwF/GeQg7tzB72QZZqkB7dHNtdWj4MnheFAOsjiGIt
 sOkQqJ/cYCl+VJS0MVBGqnOIDiP/b8b2R/zKVZhzc10Pnr7jVBtdup+MHA+duMUYr2BwA9DldOJ
 GGqbVV5gyWPyJ1JUGHWeIl7lsI1qa/lBBhkQTcGH88UJGMJEOyrHqmxSoJQFIwesxcYg0GJ9zjH
 0t/WDQZLXY3TA7t8ShglrhjfP1JNjN8ytv/HcMJ45N
X-Gm-Gg: AeBDieulKy0gQUvnzdHzNMLizVMAOpLcJXUd1pCLHRcEUQkorYMoxf6uWyZJsXOLzJK
 AvlxCHYElRN2WKT3yvB6NmCQNe3qIXYGhNcv8K6M/4ETqXBoVH8cZismXPjnq4ITwXkdgROEc4n
 rEo5bzwGYSiU9rqbgfh1N9sfMFBJUl0jg/i21en+//XQwe6ugUHh+jC9aUzIWDoaCk0Z6Mhb2t0
 eM9UnHq/9yeE+Xl0DjRWpFxHWdCweDtNG2B1gpB/aDm52ux9KQ0ZPvqzmIo7vhZ6UG1zEpDwnur
 Z4niIS9i6DTFy0NyjVvqOnZ9VdVxDICFhflfKTumC/KDoJ4d7u3ddtYel7+7aJX0a5JeVNqptSO
 HmVpbO40XQ0n6bOxPC3hLBTU2cZQS6IGXlU3wCX1/8M/uCZisxsv2/aMbZeNV5l1BNlaB+WSQ0C
 Zr6JiGFN5MdEIgbvSmSFPhBiAFIjpaZtLOwbs=
X-Received: by 2002:a05:6214:4608:b0:8b1:f2f6:33b with SMTP id
 6a1803df08f44-8b3fe7af5dbmr57264646d6.22.1777569828231; 
 Thu, 30 Apr 2026 10:23:48 -0700 (PDT)
X-Received: by 2002:a05:6214:4608:b0:8b1:f2f6:33b with SMTP id
 6a1803df08f44-8b3fe7af5dbmr57263826d6.22.1777569827351; 
 Thu, 30 Apr 2026 10:23:47 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff43a465sm22165976d6.28.2026.04.30.10.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:23:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 32/58] whpx: i386: disable kernel-irqchip on Windows 10 when
 PIC enabled
Date: Thu, 30 Apr 2026 19:21:38 +0200
Message-ID: <20260430172204.1006673-33-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Move WHvCapabilityCodeProcessorPerfmonFeatures queries
as that's how we distinguish if on a legacy OS.

Now that Windows guests are booting, disable kernel-irqchip=on
by default for Windows 10 when the PIC is enabled.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-11-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 69 +++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 30 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 03c146dfb8c..ab8e97787fe 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2523,6 +2523,13 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         0x80000002, 0x80000003, 0x80000004, 0x80000007, 0x80000008,
         0x8000000A, 0x80000021, 0x80000022, 0xC0000000, 0xC0000001};
 
+    X86MachineState *x86ms = X86_MACHINE(ms);
+    bool pic_enabled = false;
+
+    if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
+        pic_enabled = true;
+    }
+
     whpx = &whpx_global;
 
     if (!init_whp_dispatch()) {
@@ -2594,6 +2601,35 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
+    /* Enable supported performance monitoring capabilities */
+    hr = whp_dispatch.WHvGetCapability(
+        WHvCapabilityCodeProcessorPerfmonFeatures, &perfmon_features,
+        sizeof(WHV_PROCESSOR_PERFMON_FEATURES), &whpx_cap_size);
+    /*
+     * Relying on this is a crutch to maintain Windows 10 support.
+     *
+     * WHvCapabilityCodeProcessorPerfmonFeatures and
+     * WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks
+     * are implemented starting from Windows Server 2022 (build 20348).
+     */
+    if (FAILED(hr)) {
+        warn_report("WHPX: Failed to get performance "
+                    "monitoring features, hr=%08lx", hr);
+        is_modern_os = false;
+    } else {
+        hr = whp_dispatch.WHvSetPartitionProperty(
+                whpx->partition,
+                WHvPartitionPropertyCodeProcessorPerfmonFeatures,
+                &perfmon_features,
+                sizeof(WHV_PROCESSOR_PERFMON_FEATURES));
+        if (FAILED(hr)) {
+            error_report("WHPX: Failed to set performance "
+                         "monitoring features, hr=%08lx", hr);
+            ret = -EINVAL;
+            goto error;
+        }
+    }
+
     /*
      * Error out if WHP doesn't support apic emulation and user is requiring
      * it.
@@ -2606,8 +2642,9 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
-    if (whpx->kernel_irqchip_allowed && features.LocalApicEmulation &&
-        whp_dispatch.WHvSetVirtualProcessorInterruptControllerState2) {
+    if (whpx->kernel_irqchip_allowed && !(whpx_is_legacy_os() && pic_enabled
+        && !whpx->kernel_irqchip_required) && features.LocalApicEmulation
+        && whp_dispatch.WHvSetVirtualProcessorInterruptControllerState2) {
         WHV_X64_LOCAL_APIC_EMULATION_MODE mode =
             WHvX64LocalApicEmulationModeX2Apic;
         hr = whp_dispatch.WHvSetPartitionProperty(
@@ -2669,34 +2706,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
-    /* Enable supported performance monitoring capabilities */
-    hr = whp_dispatch.WHvGetCapability(
-        WHvCapabilityCodeProcessorPerfmonFeatures, &perfmon_features,
-        sizeof(WHV_PROCESSOR_PERFMON_FEATURES), &whpx_cap_size);
-    /*
-     * Relying on this is a crutch to maintain Windows 10 support.
-     *
-     * WHvCapabilityCodeProcessorPerfmonFeatures and
-     * WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks
-     * are implemented starting from Windows Server 2022 (build 20348).
-     */
-    if (FAILED(hr)) {
-        warn_report("WHPX: Failed to get performance "
-                    "monitoring features, hr=%08lx", hr);
-        is_modern_os = false;
-    } else {
-        hr = whp_dispatch.WHvSetPartitionProperty(
-                whpx->partition,
-                WHvPartitionPropertyCodeProcessorPerfmonFeatures,
-                &perfmon_features,
-                sizeof(WHV_PROCESSOR_PERFMON_FEATURES));
-        if (FAILED(hr)) {
-            error_report("WHPX: Failed to set performance "
-                         "monitoring features, hr=%08lx", hr);
-            ret = -EINVAL;
-            goto error;
-        }
-    }
 
     /* Enable synthetic processor features */
     WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS synthetic_features;
-- 
2.54.0


