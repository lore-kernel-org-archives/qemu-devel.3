Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A324109C041
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RLz-0004oj-JJ; Wed, 25 Mar 2026 12:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RLy-0004o6-0a
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RLw-0004bh-6O
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774457107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xdIMymluD0FqXgTYee5QoJgAjn56Il4INcG1bLrCfmE=;
 b=SZXSlNwr+94K0yjf6KoBsI0cnSIB9f+rR/EbC56rwxnXa/bk/oZvTngBbOD2YRPwHhQWf+
 SMaOf42CBgxSSdM5SRSaOj8TlLPPnwqG3fGXMlNWVx0diz/ZCgrJ53uX/zqPmHxKSKNw/8
 hgGkOO4L9ZYUc8lTEUCCiTGu0gdCtyU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-roHaWIXBMouDodFMBpdjaw-1; Wed, 25 Mar 2026 12:45:06 -0400
X-MC-Unique: roHaWIXBMouDodFMBpdjaw-1
X-Mimecast-MFC-AGG-ID: roHaWIXBMouDodFMBpdjaw_1774457105
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43b86de58d9so6301f8f.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 09:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774457104; x=1775061904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xdIMymluD0FqXgTYee5QoJgAjn56Il4INcG1bLrCfmE=;
 b=cZbYqNcoGYnWabsJHFBvOPc8XJzhoyWVtnQh8B2w1BaisjkZ8R67MTa2u4NaFKertZ
 9DBxGd+im5ASxPkBQhHx8gbRhQk8/PPZeE7rl2FXHL+z4Ne+NJjQhVhzL/Y2MF9FYcQh
 B/1UOlI9JVZWa4uxYDo1sB9DXkaPfuyOGJk0wMKL7ZLFgIyXxMVT+WLLeI6XmE+TS8cE
 aNSbcpSBrP1iO7EmzCK2cPVMFCxPg/fAXnuWASpaR+JHqxZvlgU3+JIJIgfCzD4UVJWi
 9vE/vAm0C31M7Rbp/ATdHe7gUEAc8qK6JCC+HVvdNBSa2MVfkEScuXMNTYAoSeiXqehq
 ObgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457104; x=1775061904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xdIMymluD0FqXgTYee5QoJgAjn56Il4INcG1bLrCfmE=;
 b=CP+ozUzGVdpw3iKupNLqGYGYwOJwj80n4zPh7Nh3PaTcGxYqRUMfnT9M5zfPMivsqF
 LoBn5RpBN1zxYlXTcAhWK+PlgdP1yFzzNVNy224t62tKgySQpio3N4ZR52Vnb31bcXJl
 /Mm+5AMTxSDKKgsRIvbcFjBlPIL9VprE7W16cU9NAYqVaYUOJZAJCFWMKm5loJD1wH6m
 fh8P/rDK05HCSOKpoOblnuMRvp8PsuwOKSSzVSp9TEFk5vpUlmTGbozvm8GYVRAvodIc
 l6xW0Fh97gWxaK6qRLDKJkvVN7iHhC1WS4q7M+6ouNluexboi1B36Jv0tAP0eRLMW9rk
 R57g==
X-Gm-Message-State: AOJu0Yy+AjDVzuz907eexdr+kOiV5snfilEBkc+TZdifFee2cUGsCH1a
 6K0WtELs3SsZcPpFtGviUn14qCdAnCLnNIMokC1u/Kp1KD9plmW2mFlVZlzjVZ4BMISwimUjjTt
 Nm2Wn3fhwxsPc/sO7lrSnJ3kP2pTgGCodN0o1cxxP4ChEXJNL/ZyexMdXNa6qiWNgYGOjq/o+yR
 7b7G3fVbVI8OPwpEW2Yxi4xGIw0kZLQ+qPTwkhQl5/
X-Gm-Gg: ATEYQzyeWGrmz5UtNiWD/ktA3Oa4B9ooODT2EyHdehztSHPJiuW4bTR0E0PPTHisX2a
 Lj4eih1QpACzE+i8RI18SzJnCVCPTBpTTgqAk0TFAJtuNu35baCzY/iGmGtKA4sJKmkSpBY5CBb
 wuTLsVj4qauql8z4/biiro2VEgh6/InQxf7EEnT8Dww5dRdI2qFr8em/JFkEfz0eQV2g2uJerIF
 Rrx13Wlwb2RtGk5u0qcNwca4kSy/hIJ/gJshj5wmffMQ6JHGQ5lQhjbItWzrWUz4bn7R/0Z9wnF
 pzV5n1vWaHqtqwv6btCRs6sgbMoiYtpLf/dCDbZn7Melz4T7i1hm0fDvI4d9OXEOxectysJS3jY
 ZOIcppmwOQYcU9sbuYJ3SlVoiHDQN2o6xJRLiPTg1Lo2guZv9U0TTBcUCTzeG7TLU3/M9KscLvn
 Sh3pAToWUMPgVO9foLehSugll9
X-Received: by 2002:a05:600c:3511:b0:487:467:42a2 with SMTP id
 5b1f17b1804b1-487160438e2mr66714425e9.18.1774457103743; 
 Wed, 25 Mar 2026 09:45:03 -0700 (PDT)
X-Received: by 2002:a05:600c:3511:b0:487:467:42a2 with SMTP id
 5b1f17b1804b1-487160438e2mr66713775e9.18.1774457102993; 
 Wed, 25 Mar 2026 09:45:02 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm1028327f8f.18.2026.03.25.09.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:45:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 04/19] whpx: i386: workaround for Windows 10 support
Date: Wed, 25 Mar 2026 17:44:38 +0100
Message-ID: <20260325164453.72127-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325164453.72127-1-pbonzini@redhat.com>
References: <20260325164453.72127-1-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Windows Server 2022 and later support
WHvCapabilityCodeProcessorPerfmonFeatures and
WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks.

Windows 10 supports neither of those.

As the QEMU executable doesn't have a manifest, OS version
queries do not return the actual Windows version but 6.2.9200
which corresponds to Windows 8. Windows Server 2022 and Windows
11 still use the 10.0 number, with distinction being the build
number.

As such, use the absence of perf monitoring feature query as
a cutoff to detect if a legacy OS is present.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260324151323.74473-2-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 43 ++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 4d5d3dbd243..015c0f1dc99 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1948,6 +1948,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     WHV_CAPABILITY_FEATURES features = {0};
     WHV_PROCESSOR_FEATURES_BANKS processor_features;
     WHV_PROCESSOR_PERFMON_FEATURES perfmon_features;
+    bool is_legacy_os = false;
 
     whpx = &whpx_global;
 
@@ -2096,21 +2097,29 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     hr = whp_dispatch.WHvGetCapability(
         WHvCapabilityCodeProcessorPerfmonFeatures, &perfmon_features,
         sizeof(WHV_PROCESSOR_PERFMON_FEATURES), &whpx_cap_size);
+    /*
+     * Relying on this is a crutch to maintain Windows 10 support.
+     *
+     * WHvCapabilityCodeProcessorPerfmonFeatures and
+     * WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks
+     * are implemented starting from Windows Server 2022 (build 20348).
+     */
     if (FAILED(hr)) {
-        error_report("WHPX: Failed to get performance monitoring features, hr=%08lx", hr);
-        ret = -ENOSPC;
-        goto error;
-    }
-
-    hr = whp_dispatch.WHvSetPartitionProperty(
-            whpx->partition,
-            WHvPartitionPropertyCodeProcessorPerfmonFeatures,
-            &perfmon_features,
-            sizeof(WHV_PROCESSOR_PERFMON_FEATURES));
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to set performance monitoring features, hr=%08lx", hr);
-        ret = -EINVAL;
-        goto error;
+        warn_report("WHPX: Failed to get performance "
+                    "monitoring features, hr=%08lx", hr);
+        is_legacy_os = true;
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
     }
 
     /* Enable synthetic processor features */
@@ -2138,7 +2147,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         synthetic_features.Bank0.DirectSyntheticTimers = 1;
     }
 
-    if (whpx->hyperv_enlightenments_allowed) {
+    if (!is_legacy_os && whpx->hyperv_enlightenments_allowed) {
         hr = whp_dispatch.WHvSetPartitionProperty(
                 whpx->partition,
                 WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks,
@@ -2149,6 +2158,10 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
             ret = -EINVAL;
             goto error;
         }
+    } else if (is_legacy_os && whpx->hyperv_enlightenments_required) {
+        error_report("Hyper-V enlightenments not available on legacy Windows");
+        ret = -EINVAL;
+        goto error;
     }
 
     /* Register for MSR and CPUID exits */
-- 
2.53.0


