Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44ABFCD13DE
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV9w-0003QF-Vw; Thu, 30 Apr 2026 13:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV8P-00021K-Tl
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:25:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV8N-0005GB-H6
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yugXUOUaHOka23f8HtiD3QBvgDV06yZwDFtu+hKNV3U=;
 b=ccSffwSHeAc69QrSLW2+nOQyKOyhgNhmSWTNE9gQlJZcW2+OODb58g4IJunNlONTuyA9bP
 0HH6pC9fmN0vA2ckJ315yii1GBpsnUYRctrf3tHQz1ASeU6gVkLpeDspZD+dG8ko+19sT1
 VvHxZJL+LExS9kZmJle9lbrB+3HgjQE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-WEvvA5KfO6q8N0Oo85kPCw-1; Thu, 30 Apr 2026 13:25:05 -0400
X-MC-Unique: WEvvA5KfO6q8N0Oo85kPCw-1
X-Mimecast-MFC-AGG-ID: WEvvA5KfO6q8N0Oo85kPCw_1777569905
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50fb6d713ddso19772191cf.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569904; x=1778174704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yugXUOUaHOka23f8HtiD3QBvgDV06yZwDFtu+hKNV3U=;
 b=PMJH6Hwm/9YXZSYdDKuucQWe95/aDWokdcyaR/aDKvVqx23TW95CFJHV3Oali3gM4x
 SboQeQqYvORLcqcQC8UQKq3LORc6wHFRxh1uO2tFT25PpEl89CtDUQDaItW745eGAH4K
 UEIm8W9FMZdN0gL4mIo6fXCIza29g3caJ2Dbho5iZLQr1VDapMgvRBZz3UYaIMoTOlPm
 MdDft8aPalDsbXumqxEvbrmZEKsEvxaK1WG/8Wol13ANxThTA4+BNU7cuKQa/JVtIA48
 2mG920+DXbLmf2Pm7UwyXqOxikdduF/G4ayPjDxdlmgtsVolKNl82VtiOpRJ360Pbqxd
 Eeqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569904; x=1778174704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yugXUOUaHOka23f8HtiD3QBvgDV06yZwDFtu+hKNV3U=;
 b=C8mfRpe8a717jtU+2wSXkUwhD83Lc7qVxmZamFkh7LAf352jlKv0+poLZtUmUNp7Ix
 RflOjyYe4sVEI1X1dOHSdYfBNHP6A3qb+07QLDQAdVgPS6mMB5INebW1hLDc1oEIwDN2
 RcGCdjHm02W6tjtUiz27h8fFMSh9NPGuKUnVRz7KwQZ7MXZ4oGlMUfOjJmWH04ekNT1A
 ujoM03q83Vx61YptUpGFdkycCu0/9MkeCXnz4S3+4VK4L8xLdVqmYeXmE9t6crVio7iw
 SgtTbONTSDK2Tb6dFdtMkVMvFpWIs0Gp4RpMUdDM38jQzYa8nciBCqvIWSSbdPHHxjDC
 u1XA==
X-Gm-Message-State: AOJu0Yw6c/aWTUHzCIphTRf2NwYOXBQptx35KW9VC/ylmUEEBXL/8E+n
 cTDbtFHUOnBCfJZi+OUyaFAte7Y1r+MVjAgGMD8+jEGW9K4lC5q4OS2H3SHPRhfvsPTNXprv227
 1aL+pYBJpyBEEjAsZxoAQyZEiCMllJZQCpJL8Yry4fl8ZUrUvmExENrQUW8sQnK0Igb0CD2P8bc
 SLEGQtKF9b4Hc4mGtgiIUXHCtgEMjGinUuOdqbHh4n
X-Gm-Gg: AeBDieuSaUQn0Dtdb4xX+r5ikerERbEV4PjecYHLj6kSY146jDosyfiRPl/MkxJi1q/
 zxiSJNuSwZbN3PTplk/2lkCkG6bV/YW78mvNwDadTNH6CSJxbqdqioTW2jiytqr6q/8ULEDdkmJ
 0m5SmSRIblx3vx1tRMwX32WsIbUs+JQg4fwvGgRzP1tVzGbc7cgg5n/efOnAYMsAC/QVoUPhe32
 ivCPJ+WbwY4qCBbYnpOpYmM9N6L0lkMhCo8EV6H1ZbUgFc1f+pGVSFek81qOSKN15dgD6JvtJ6L
 6qi+9Jfi08YoiP1ub5aOvwYH1ydE6aSk/E6cczLR8JB1qGLMtqpwkwmcdIo487PvS12DwgjJvxj
 VH8W8RKaGedq5/eX+QLy0EpMjC1cGJGdLxDPLogvvlaBZrIJfBj0K/NiSyQ4fYI0xf/Beu0irmH
 pxVguBUirO6v42eSZXAdmkNfRbxxw4m3qHrqE=
X-Received: by 2002:a05:622a:4d92:b0:50b:445a:4139 with SMTP id
 d75a77b69052e-5102ae9301amr58774221cf.54.1777569903758; 
 Thu, 30 Apr 2026 10:25:03 -0700 (PDT)
X-Received: by 2002:a05:622a:4d92:b0:50b:445a:4139 with SMTP id
 d75a77b69052e-5102ae9301amr58773251cf.54.1777569902941; 
 Thu, 30 Apr 2026 10:25:02 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5103d1cb574sm605151cf.6.2026.04.30.10.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:25:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 57/58] whpx: i386: add SeparateSecurityDomain flag and make
 default
Date: Thu, 30 Apr 2026 19:22:03 +0200
Message-ID: <20260430172204.1006673-58-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

For workloads where isolation is less important, -accel whpx,ssd=off
will provide significantly higher MMIO performance.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-37-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/whpx-internal.h |  2 ++
 accel/whpx/whpx-common.c       |  1 +
 target/i386/whpx/whpx-all.c    | 64 ++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 15027a7d524..c295c5a5290 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -47,6 +47,8 @@ struct whpx_state {
     bool hyperv_enlightenments_required;
     bool hyperv_enlightenments_enabled;
 
+    bool separate_security_domain;
+
     bool ignore_unknown_msr;
     bool intercept_msr_gp;
 };
diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index d846e08714b..247e12db812 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -556,6 +556,7 @@ static void whpx_accel_instance_init(Object *obj)
     whpx->hyperv_enlightenments_enabled = false;
     whpx->ignore_unknown_msr = true;
     whpx->intercept_msr_gp = false;
+    whpx->separate_security_domain = true;
 }
 
 static const TypeInfo whpx_accel_type = {
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index d6bc36686c2..9d0c391e36f 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2962,6 +2962,39 @@ static void whpx_set_intercept_msr_gp(Object *obj, Visitor *v,
     }
 }
 
+static void whpx_set_ssd(Object *obj, Visitor *v,
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
+        whpx->separate_security_domain = true;
+        break;
+
+    case ON_OFF_AUTO_OFF:
+        whpx->separate_security_domain = false;
+        break;
+
+    case ON_OFF_AUTO_AUTO:
+        whpx->separate_security_domain = true;
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
+
 void whpx_arch_accel_class_init(ObjectClass *oc)
 {
     object_class_property_add(oc, "ignore-unknown-msr", "OnOffAuto",
@@ -2974,6 +3007,11 @@ void whpx_arch_accel_class_init(ObjectClass *oc)
         NULL, NULL);
     object_class_property_set_description(oc, "intercept-msr-gp",
         "Intercept #GP to log erroring MSR accesses.");
+    object_class_property_add(oc, "ssd", "OnOffAuto",
+        NULL, whpx_set_ssd,
+        NULL, NULL);
+    object_class_property_set_description(oc, "ssd",
+        "Separate security domain");
 }
 
 int whpx_accel_init(AccelState *as, MachineState *ms)
@@ -3169,6 +3207,32 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         }
     }
 
+    /*
+     * The combination of separate security domain off
+     * and disabling specifically these features results
+     * in a significant vmexit performance improvement
+     * by skipping speculative execution mitigations.
+     */
+    if (!whpx->separate_security_domain) {
+        processor_features.Bank0.IbrsSupport = 0;
+        processor_features.Bank0.StibpSupport = 0;
+        processor_features.Bank0.IbpbSupport = 0;
+        processor_features.Bank0.SsbdSupport = 0;
+        processor_features.Bank0.IbrsAllSupport = 0;
+        processor_features.Bank1.PsfdSupport = 0;
+        memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
+        prop.SeparateSecurityDomain = 0;
+        hr = whp_dispatch.WHvSetPartitionProperty(
+            whpx->partition,
+            WHvPartitionPropertyCodeSeparateSecurityDomain,
+            &prop,
+            sizeof(WHV_PARTITION_PROPERTY));
+        if (FAILED(hr)) {
+            error_report("WHPX: failed to unset separate security domain, hr=%08lx", hr);
+            /* Some old Windows 10 releases didn't have this, so not fatal*/
+        }
+    }
+
     hr = whp_dispatch.WHvSetPartitionProperty(
             whpx->partition,
             WHvPartitionPropertyCodeProcessorFeaturesBanks,
-- 
2.54.0


