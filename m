Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FA2C83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 00:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua1I6-0006PT-CW; Thu, 10 Jul 2025 20:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ua1Hq-0006N8-DG
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 20:06:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ua1Hi-0007Yl-V6
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 20:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752192395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vkKI3kL+Ul9kC1WS2I2rMhKnodsz0CEasxhfyrtwIdg=;
 b=ExPPS1dcQ8/pS3Q7oaML+kuX7rcyF694VrCTqnf1saZKMaPtvKr/LhE07YAid7ysh0ZnI1
 6IryCGR3sefL2uPEw7HNUB3ttdabQJnULvs5QKgnHP/jHtxxAq0MPPCgUrpPeScpCa453h
 u6IahBiaPUSgUpssqDui2lIOv7BfmRE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-DuMD_3WmMMiyFU9J038vCA-1; Thu, 10 Jul 2025 20:06:23 -0400
X-MC-Unique: DuMD_3WmMMiyFU9J038vCA-1
X-Mimecast-MFC-AGG-ID: DuMD_3WmMMiyFU9J038vCA_1752192383
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450df53d461so11769835e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 17:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752192382; x=1752797182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vkKI3kL+Ul9kC1WS2I2rMhKnodsz0CEasxhfyrtwIdg=;
 b=EjutqBpeLzUeX5lK4SwA9rhAGmDiq2gmqzGm7KgMY4ytVd3QAihmOlvai0KxDRovnf
 Bl8bt1Vs1XobuJUSR/H6eWFRsSfwNe4rCFQuFfUUaMGnCwEvs2oyRIhEyMo4GWCUi5ms
 dYy4acFUiKNYGmj5+16fXtIc2yrtQor02Q9kUWR2fGypdYf8+bmYXixPMyKK3xv0P3Wn
 I0/iES/gr96qFz1zztajW8AE4xHlqBw4vlOxb6+6qrxYN+qwnOY16yZ6uh5m5PX8slVv
 mdZ6YxDqWmyw/w79iU5cUHexjLihyIg0c3RIZPEyYfWLncVD/HjGqIY6g3+074/N3Bru
 4d4g==
X-Gm-Message-State: AOJu0YzNYTzebISxRTnag17H73X1AUU/TKffbBb33uIbwxDv+aTzYgWs
 2SLYVnkOFosLPCUN04sGyZmk+sayTsH9q0Vdr3fbxv/qLzumYcup/l7uj+vLqCP4EDkViV5iBw0
 BcOpuggrI/8rk6S/CgXdVcjX/fHRi0NJtHxWOeBWz/ojs6B8b9k1o97ZXfJEkTfbzZK3E/PkGZH
 DFFWmPnxdE4L5vM92e87wra2wjlXOlV10J4x5evdcv
X-Gm-Gg: ASbGncvaqvrzBDOult0u4ctyKSsiiPnqeUoOwy4nw9CsbnshjNo73RlYm2tItgHIXj9
 5LQFqM5KNOhLOHOUIfWgWw4GNSc5bQdJVzflAsGaEhK2v0XoMulw4ycsVd4ZA5QAN5yBqt6cDqX
 OLPKBU6sTiiMzhuFQI0bhfIcQFTcLdoLdZcSqhLS0Oe9qlUePR6n2dvA0xr791VegafyZ/11laT
 xvTyh3Lg4dsUAEyrbPOhqsa3Vq+6BGlC2rdesquqSTjsYz7zn+4F2J1I0SW4t0b6ibYPEKCjAVW
 8N0i9eDNybjslcqyRP9VoWTIF8p9QJccD8CzkoWx2D4h
X-Received: by 2002:a05:6000:2503:b0:3a4:dc42:a0ac with SMTP id
 ffacd0b85a97d-3b5f18f608fmr970420f8f.49.1752192381674; 
 Thu, 10 Jul 2025 17:06:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfcgldzrWafJ/8ZemFSYEOm8yF2CzsmEhWaXdTv7mT3Q6tVs0aNjQJYJID/sKTivFdcWFZ1g==
X-Received: by 2002:a05:6000:2503:b0:3a4:dc42:a0ac with SMTP id
 ffacd0b85a97d-3b5f18f608fmr970404f8f.49.1752192381205; 
 Thu, 10 Jul 2025 17:06:21 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.202.169])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e14d07sm3084398f8f.66.2025.07.10.17.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 17:06:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	zhao1.liu@intel.com
Subject: [PATCH 2/4] target/i386: nvmm,
 whpx: add accel/CPU class that sets host vendor
Date: Fri, 11 Jul 2025 02:06:01 +0200
Message-ID: <20250711000603.438312-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711000603.438312-1-pbonzini@redhat.com>
References: <20250711000603.438312-1-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

NVMM and WHPX are virtualizers, and therefore they need to use
(at least by default) the host vendor for the guest CPUID.
Add a cpu_instance_init implementation to these accelerators.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c           |  8 +++++++-
 target/i386/nvmm/nvmm-all.c | 23 +++++++++++++++++++++++
 target/i386/whpx/whpx-all.c | 23 +++++++++++++++++++++++
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 624cebc3ff7..69bdffbfe46 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -43,6 +43,7 @@
 #include "hw/boards.h"
 #include "hw/i386/sgx-epc.h"
 #endif
+#include "system/qtest.h"
 #include "tcg/tcg-cpu.h"
 
 #include "disas/capstone.h"
@@ -1943,7 +1944,7 @@ uint32_t xsave_area_size(uint64_t mask, bool compacted)
 
 static inline bool accel_uses_host_cpuid(void)
 {
-    return kvm_enabled() || hvf_enabled();
+    return !tcg_enabled() && !qtest_enabled();
 }
 
 static inline uint64_t x86_cpu_xsave_xcr0_components(X86CPU *cpu)
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index b4a4d50e860..69125230abb 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -1207,10 +1207,33 @@ static const TypeInfo nvmm_accel_type = {
     .class_init = nvmm_accel_class_init,
 };
 
+static void nvmm_cpu_instance_init(CPUState *cs)
+{
+    X86CPU *cpu = X86_CPU(cs);
+
+    host_cpu_instance_init(cpu);
+}
+
+static void nvmm_cpu_accel_class_init(ObjectClass *oc, const void *data)
+{
+    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
+
+    acc->cpu_instance_init = nvmm_cpu_instance_init;
+}
+
+static const TypeInfo nvmm_cpu_accel_type = {
+    .name = ACCEL_CPU_NAME("nvmm"),
+
+    .parent = TYPE_ACCEL_CPU,
+    .class_init = nvmm_cpu_accel_class_init,
+    .abstract = true,
+};
+
 static void
 nvmm_type_init(void)
 {
     type_register_static(&nvmm_accel_type);
+    type_register_static(&nvmm_cpu_accel_type);
 }
 
 type_init(nvmm_type_init);
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index faf56e19722..b380459d6fe 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2500,6 +2500,28 @@ static void whpx_set_kernel_irqchip(Object *obj, Visitor *v,
     }
 }
 
+static void whpx_cpu_instance_init(CPUState *cs)
+{
+    X86CPU *cpu = X86_CPU(cs);
+
+    host_cpu_instance_init(cpu);
+}
+
+static void whpx_cpu_accel_class_init(ObjectClass *oc, const void *data)
+{
+    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
+
+    acc->cpu_instance_init = whpx_cpu_instance_init;
+}
+
+static const TypeInfo whpx_cpu_accel_type = {
+    .name = ACCEL_CPU_NAME("whpx"),
+
+    .parent = TYPE_ACCEL_CPU,
+    .class_init = whpx_cpu_accel_class_init,
+    .abstract = true,
+};
+
 /*
  * Partition support
  */
@@ -2726,6 +2748,7 @@ static const TypeInfo whpx_accel_type = {
 static void whpx_type_init(void)
 {
     type_register_static(&whpx_accel_type);
+    type_register_static(&whpx_cpu_accel_type);
 }
 
 bool init_whp_dispatch(void)
-- 
2.50.0


