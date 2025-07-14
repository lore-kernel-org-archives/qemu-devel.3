Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50FDC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHLU-0005yP-3X; Mon, 14 Jul 2025 07:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0F-0001Kj-A7
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:06:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubH0B-0001wy-Q2
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mul+E8ln+qvRVQpsZttbXU0+kmRd+V4PH2/0PTsKNQo=;
 b=YewAcKef0uNU5w8S6yc4QM9j5wRNkEKAx2ZVSUHpVRJZvF3+BfrVHmVpKClt8n5r0m9omL
 8nAB9GyY20Szkt+cqnUYLPZdalrCmN7H2wToKqdGxWZBKDS/T8Q9vLcW1Sh7SOKHlmda4H
 bESjsAUfxGcNFpcyhwqqsA6oEBoJhDs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-M3FmRST5Pty5xp_fMrguNg-1; Mon, 14 Jul 2025 07:05:41 -0400
X-MC-Unique: M3FmRST5Pty5xp_fMrguNg-1
X-Mimecast-MFC-AGG-ID: M3FmRST5Pty5xp_fMrguNg_1752491141
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a503f28b09so2705428f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491140; x=1753095940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mul+E8ln+qvRVQpsZttbXU0+kmRd+V4PH2/0PTsKNQo=;
 b=InO5iOSmUuSiqPagKafmGYXwULYYqeG7uZTcOeqiyifD189yowWE0slX8QJqIAc5mF
 /ZJJXT8/KNg9iItpYon1vwHWC8EPBsOI/2MDw/mUddOY+Gw1OuP+T2PAjQb7aeqybG5z
 57VRO1J76bzv3SbNqyQqo8x2V7xGgPg/ekfyyTNJIigQLiUARXfSGpr8igYQdLuu0nv7
 4yjYHx9ZkN3fzdTTDUn4Xf5sAG3qKdWY8sFV/HGF9f/Fh+G4mq9DCHrKMiXAyg1oYo/m
 4RqUKdCZqrZ9Se+cEXioeuAwbuAsV8LQ9HHXlNcG0ORU6selgESoG2HBk/TLXdvDKJBj
 0Gxg==
X-Gm-Message-State: AOJu0YyZmFn2UY9cMw/dp1CwyGbKHXxcFi2byEUvPqwvRQrlJ0iFWDGG
 n+tV5AzMnodS7f0rQCMfz9x1YnIPwNiBqMpd/1pd/k6NdwwYGIruVILzx9NRZppKPVcJpsf610F
 T4j5oLdvI9UZnz/aCm+WkERd6L0XyrPdeJFiwj4O7vUwSewpO9++vqH8FrxfUafgnx/3yfgMyEW
 pBpqd1/FapOELlMPhWH7gp0POHu7tiz1GYkyreXGVE
X-Gm-Gg: ASbGncsF44bFgwCuzE7zNuWLsFEiMKQamVCG+i+YBGUCDviPu22O1x/aRLezW19lb14
 553FWertcLe1e/McyGQKbxJof05XOkUAWqbmZ2Kx1sS2WvkGSCkwExY+l12X5Iw0tv6HBSNaGgf
 2wSbPzWpPWiP+k2GPmeIDJEH1JttVoym/93CD8/iFFrtT07N/a8zEuJXhdkixfCda2MWfl0o00y
 ohmxAs0pe/JyASOBaESwVgdpmPDlduB9t5XfAG8Rd2WtYhF/gXal/AXvaevuSOdD2jJjz0KDGFL
 5SV/seo9WaGWaIeCh+0dm8geh3QlNMVL19MH7dC35ew=
X-Received: by 2002:a05:6000:4408:b0:3a5:271e:c684 with SMTP id
 ffacd0b85a97d-3b5e7f35328mr9939396f8f.24.1752491139577; 
 Mon, 14 Jul 2025 04:05:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRNuDcObfokj8qx8khdsmZUz2nCbzqZmv5zSfYs0sgl3oy46tPS1e8hGKoK9VB1GMFucOdiQ==
X-Received: by 2002:a05:6000:4408:b0:3a5:271e:c684 with SMTP id
 ffacd0b85a97d-3b5e7f35328mr9939370f8f.24.1752491139052; 
 Mon, 14 Jul 2025 04:05:39 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e8b1sm12005359f8f.82.2025.07.14.04.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:05:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 34/77] i386/cpu: Use CPUID_MODEL_ID_SZ instead of hardcoded 48
Date: Mon, 14 Jul 2025 13:03:23 +0200
Message-ID: <20250714110406.117772-35-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Xiaoyao Li <xiaoyao.li@intel.com>

There is already the MACRO CPUID_MODEL_ID_SZ defined in QEMU. Use it to
replace all the hardcoded 48.

Opportunistically fix the indentation of CPUID_VENDOR_SZ.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20250630080610.3151956-2-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h      | 3 ++-
 target/i386/cpu.c      | 8 ++++----
 target/i386/host-cpu.c | 1 -
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9829824ac89..b3bb9888579 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1159,7 +1159,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 /* PMM enabled */
 #define CPUID_C000_0001_EDX_PMM_EN             (1U << 13)
 
-#define CPUID_VENDOR_SZ      12
+#define CPUID_VENDOR_SZ     12
+#define CPUID_MODEL_ID_SZ   48
 
 #define CPUID_VENDOR_INTEL_1 0x756e6547 /* "Genu" */
 #define CPUID_VENDOR_INTEL_2 0x49656e69 /* "ineI" */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 44178bc523d..70b742fcdeb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6469,11 +6469,11 @@ static char *x86_cpuid_get_model_id(Object *obj, Error **errp)
     char *value;
     int i;
 
-    value = g_malloc(48 + 1);
-    for (i = 0; i < 48; i++) {
+    value = g_malloc(CPUID_MODEL_ID_SZ + 1);
+    for (i = 0; i < CPUID_MODEL_ID_SZ; i++) {
         value[i] = env->cpuid_model[i >> 2] >> (8 * (i & 3));
     }
-    value[48] = '\0';
+    value[CPUID_MODEL_ID_SZ] = '\0';
     return value;
 }
 
@@ -6488,7 +6488,7 @@ static void x86_cpuid_set_model_id(Object *obj, const char *model_id,
         model_id = "";
     }
     len = strlen(model_id);
-    memset(env->cpuid_model, 0, 48);
+    memset(env->cpuid_model, 0, CPUID_MODEL_ID_SZ);
     for (i = 0; i < 48; i++) {
         if (i >= len) {
             c = '\0';
diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
index e9a49e628f8..b1fb6d68161 100644
--- a/target/i386/host-cpu.c
+++ b/target/i386/host-cpu.c
@@ -80,7 +80,6 @@ bool host_cpu_realizefn(CPUState *cs, Error **errp)
     return true;
 }
 
-#define CPUID_MODEL_ID_SZ 48
 /**
  * cpu_x86_fill_model_id:
  * Get CPUID model ID string from host CPU.
-- 
2.50.0


