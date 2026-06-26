Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F49CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3dc-0006xa-9j; Fri, 26 Jun 2026 06:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3dV-0006hV-P9
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3dS-00059T-Or
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Aa+Xsjx5K5pDGJk98eX7HipvLYuuQX+T+6KcqPv4wgc=;
 b=a1uYjv73uA2aSm7UZoIQZFTMZg/EU9OcAdixJkm/uvZjofRCfT/7DQVmZGj6j91WpqNLcu
 bb7f7GbJxLWvcG0gKfK1sSYL50a7YLpRyelM3fSZGErFCh+o1wAA/A3j5Gfkj9QUa/WKio
 3X9tk3nmrnULp5hvaIv44FnB6O6b2tk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-ljq7ZIpnPjCcfZf6zhAt-w-1; Fri, 26 Jun 2026 06:18:08 -0400
X-MC-Unique: ljq7ZIpnPjCcfZf6zhAt-w-1
X-Mimecast-MFC-AGG-ID: ljq7ZIpnPjCcfZf6zhAt-w_1782469087
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49243626f15so6939245e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469087; x=1783073887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aa+Xsjx5K5pDGJk98eX7HipvLYuuQX+T+6KcqPv4wgc=;
 b=k40nWJPWrT1yCUph588MIChVlI+5jTVuNJrH3zoIxJCkRfcOGaZ7vkuWvGT+l/qldC
 dwJinJln+G3y17rB5mcsEwhHvrxPyV8POrktOb6tKVKerJE69iIIr7jHweWU9a9y99rl
 ZTgLEBdvayT9P0B81yQT09Klt59NASXW6KY39Zd4HlP2pxsKgb24lQIVBwOtDAdshWCn
 nNgkSVFa32xd9MlWx44ZTNpvO6bHntyi3GVcSUUj+1WJFmEyRqwVq8ltWMLhLdlDgJ0y
 l7pwt/zQZfo4gF+nYPGXIgy+M9F13GQU+BcoRRHAyxIgTHCWb2nQstIkopQgeYjwwyfx
 E6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469087; x=1783073887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Aa+Xsjx5K5pDGJk98eX7HipvLYuuQX+T+6KcqPv4wgc=;
 b=O6rX6rikNmOhcJPVeKsPlz8DlZt5b8NY8Jdu5QjixjqRBycEsL6cCbdCE/PlyTYqyk
 EsvCmRal0yfRs6forCr9oOZ4PLK+9zIgLQTer73nDtKeuKaMmyQIlFF1LCl1oZ9YJekV
 Zlr5leW6tUqI4O2s8MP9uQ+5l0Xvktpi3azMGKtJPpXrRpCo+GOy+ckKj9H3ufWhMHVa
 208Yq9BsbnWVz4zmENjwHc0AkCXCPHTYpiUHnZ8bevKWVBczrOYnBT47A9GY0lBGRreS
 QSZN144v3xnY1P+ulYoLzHFI9lbZ/eJ/WIAaVowS5XB/aeco9oXM7Csw9oAYkpjwToTU
 y9yg==
X-Gm-Message-State: AOJu0YyGcaFT+gP4e5whztt/ea28Us/hoBuw8Ek7QN8zV8E9A0/FDxKg
 mKpxYNKNm7UwX0rbOknP1s8gWWWXt+xA528DUq4B/EeTvFkTl2RDcI/ZKGhpFdTyAeUl4AS3Oh4
 +E4vp2h9TK7SaXLvE25Puw3FJ0bpFIUNSVlELEEfcyyycOTNL2swmB7zSUMdAL5GGWOED3rIrY6
 +Q2f+sVW6XfJTgq71Oygr/XZ1WBwbMd7RhFcfQcO/u
X-Gm-Gg: AfdE7cmythwUU/0EgLFWrR7KclfmKyiLE1k3qt+SXtqRFl9WtrHOm9B/QzSudIUP385
 NpVmnI34gLlm2W/H5vP4Ns4WxRi9vMFvomEdX5iQNN8rtGlNyrqsHPMlPI9Q+733z71DuvE65to
 fXbTaTsp7wZLJgTU3BPJiurxHOsr1kLNc7g4geZo6+PXqOFWzjXKdag3V2zZ2/OGL+bKOVw0+MM
 V9hCA6+WqutCilQD7Frr/f7axFoauHqIF/BubAX6OYAcjQnyTbLCJpEROzLmOEQfQapaVSnpKY6
 V0vuY2A0jwR01JDIN1c61Pu3zZTg25MK2EtbM/puKne95AMJ0xR0DaScEroTca0bTHf1/4WItd0
 Wz/FEZoEbI8WoepP8gv088PesECRbKfZ7KI/Qx8DbrhHr1ucYdiQtCM9PeJnzv9Xs8y50dNG+nf
 rn4F/t4RiAsBDTqZgd
X-Received: by 2002:a05:600c:a403:b0:490:9782:3eb8 with SMTP id
 5b1f17b1804b1-4926689fab5mr73583595e9.25.1782469087152; 
 Fri, 26 Jun 2026 03:18:07 -0700 (PDT)
X-Received: by 2002:a05:600c:a403:b0:490:9782:3eb8 with SMTP id
 5b1f17b1804b1-4926689fab5mr73583075e9.25.1782469086606; 
 Fri, 26 Jun 2026 03:18:06 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268ffe204sm69041655e9.7.2026.06.26.03.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:18:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
Subject: [PULL 06/45] target/i386: query mshv accel for supported cpuids
Date: Fri, 26 Jun 2026 12:17:09 +0200
Message-ID: <20260626101748.1728079-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

We implement mshv_get_supported_cpuid() and invoke it in
x86_cpu_get_supported_feature_word() retrieve the cpu features that the
host is supporting. Initially we mask the virtualization capabilitities
potentially we might need to mask more in the future.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260416121116.527927-7-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv.h       |  3 +++
 target/i386/cpu.c           |  8 ++++++++
 target/i386/mshv/mshv-cpu.c | 27 +++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/include/system/mshv.h b/include/system/mshv.h
index 75286baf165..51b04207358 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -60,4 +60,7 @@ int mshv_irqchip_add_irqfd_notifier_gsi(const EventNotifier *n,
                                         const EventNotifier *rn, int virq);
 int mshv_irqchip_remove_irqfd_notifier_gsi(const EventNotifier *n, int virq);
 
+/* cpuid */
+uint32_t mshv_get_supported_cpuid(uint32_t func, uint32_t idx, int reg);
+
 #endif
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8929a75c7c9..5805d33ab92 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -26,6 +26,7 @@
 #include "tcg/helper-tcg.h"
 #include "exec/translation-block.h"
 #include "system/hvf.h"
+#include "system/mshv.h"
 #include "system/whpx.h"
 #include "whpx/whpx-i386.h"
 #include "hvf/hvf-i386.h"
@@ -8233,6 +8234,13 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
         r = hvf_get_supported_cpuid(wi->cpuid.eax,
                                     wi->cpuid.ecx,
                                     wi->cpuid.reg);
+    } else if (mshv_enabled()) {
+        if (wi->type != CPUID_FEATURE_WORD) {
+            return 0;
+        }
+        r = mshv_get_supported_cpuid(wi->cpuid.eax,
+                                     wi->cpuid.ecx,
+                                     wi->cpuid.reg);
     } else if (whpx_enabled()) {
         switch (wi->type) {
         case CPUID_FEATURE_WORD:
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index d65cba5de15..00b8ac18e46 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1664,6 +1664,33 @@ void mshv_arch_destroy_vcpu(CPUState *cpu)
     g_clear_pointer(&env->emu_mmio_buf, g_free);
 }
 
+uint32_t mshv_get_supported_cpuid(uint32_t func, uint32_t idx, int reg)
+{
+    uint32_t eax, ebx, ecx, edx;
+    uint32_t ret = 0;
+
+    host_cpuid(func, idx, &eax, &ebx, &ecx, &edx);
+    switch (reg) {
+    case R_EAX:
+        ret = eax; break;
+    case R_EBX:
+        ret = ebx; break;
+    case R_ECX:
+        ret = ecx; break;
+    case R_EDX:
+        ret = edx; break;
+    }
+
+    /* Disable nested virtualization features not yet supported by MSHV */
+    if (func == 0x80000001 && reg == R_ECX) {
+        ret &= ~CPUID_EXT3_SVM;
+    }
+    if (func == 0x01       && reg == R_ECX) {
+        ret &= ~CPUID_EXT_VMX;
+    }
+    return ret;
+}
+
 /*
  * Default Microsoft Hypervisor behavior for unimplemented MSR is to send a
  * fault to the guest if it tries to access it. It is possible to override
-- 
2.54.0


