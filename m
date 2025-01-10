Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29181E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK32-0001Sp-NE; Fri, 10 Jan 2025 13:47:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2t-0000h7-3y
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2r-0001E2-74
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BIu31oS8+7nxNH6NjsiGP5t1yaCBDHTs3K4alVxgO68=;
 b=Q9B+IIw0q9ugwH1Kl4QmAUmNJF+tNwdN2rAAW5k9J8mbKGpljmrxaK+gANkfO/T7bN/eTC
 iFsT0+za644vZqKON9QbtWsNAwKM/xZk05RqQQXryrfs+MsWxHke435ie08p5IRwfnVtfl
 +I+z0orJkEjYZVUtWB1NrTzjLtjpgQ4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-JByqUyVmP3mjQZWgOh294A-1; Fri, 10 Jan 2025 13:47:42 -0500
X-MC-Unique: JByqUyVmP3mjQZWgOh294A-1
X-Mimecast-MFC-AGG-ID: JByqUyVmP3mjQZWgOh294A
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aa69e84128aso194055966b.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:47:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534861; x=1737139661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BIu31oS8+7nxNH6NjsiGP5t1yaCBDHTs3K4alVxgO68=;
 b=hjAcwYt/ePwz5d7EQAoUT7sv+XI/DB5N2WCNfVAHDzgXUXN6tp25G0E6pmog7rz3RN
 MQ4e+o/tCSvYa9XbXTaXo8OyqT3wX2cnQeOR9Q7Ufrn6OvgpE72LvRfwaB2RqQDI0ofo
 w8cByjxPE+8AiKB9myvBB7nncBZDpmSIHuLnqsvR47FdAEHEkUMypXCK+IfXnQWveZr0
 hHZXO7sBW/nikh3iMUCH+uhj1raRMAvoBAfgLKRK1EqhonGlFe4eaR8YQTlGbEwgO4yD
 uYbifgXGA2ENMss8J7k3GnK2Tz531yI88Voou11g7hlSxMqsVISLNkXwAWW9qxDZ5IBW
 1fpA==
X-Gm-Message-State: AOJu0Yx2kb10DU18oluvEH1DX1Khj7tjXKGngBifxNg9QfjlqsW2gkoX
 NkZ5j9GXX8PTbwFFdYyJ7kX5L+q9lWbAHNzgs+dxkQ+xU479GmW7xYfRV1wFr4YK391HaI6qPeD
 uIBzFLbCCgyfEEKbK+9zsFCwNPhIZtrLUq8fbIqs5mzHU/zPo728wc4s0GpRaogsfZ20Dl1tmzz
 msSGxaIkCfMCPb1mD9czFVm/WWp3xzIF9VehEPJWY=
X-Gm-Gg: ASbGncsxlXzBV3CHFaFnET7I2/yOBPb3uJ4wkRVGUP7worfdTOmVtB3cgksQE7E4erz
 +y93t6tWqjr8k0Mw34ruUR4uWHl+0G5Qjo9mdpupD11u7ryIVRdKSBpYZGPYAPtkkmYi5BM0p67
 CK1l4gYhS/iRsImvfYBVrAL8k9vHoxQ/aFyV/Y6K0zcWz2kE+wMGq2JhBfjGBtAMYlRFgdO2H67
 oW99dzfq1TvYq076LVXfMqLkmMSb/wDGnwVOeRqG8b1faVrG/KiB5fyqik=
X-Received: by 2002:a17:907:d87:b0:aa6:80ed:e9a3 with SMTP id
 a640c23a62f3a-ab2ab70a87amr1250821766b.35.1736534861032; 
 Fri, 10 Jan 2025 10:47:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxCDexzyCKkD1qSpaJ7j5lqbnxMrj4YGUapHDkO+PUoAWfFzkKpnnQ1JlQK3U/LdJYnhdHyA==
X-Received: by 2002:a17:907:d87:b0:aa6:80ed:e9a3 with SMTP id
 a640c23a62f3a-ab2ab70a87amr1250819866b.35.1736534860551; 
 Fri, 10 Jan 2025 10:47:40 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c9562ea8sm194331766b.93.2025.01.10.10.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:47:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 33/38] i386/topology: Introduce helpers for various topology
 info of different level
Date: Fri, 10 Jan 2025 19:46:14 +0100
Message-ID: <20250110184620.408302-34-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Introduce various helpers for getting the topology info of different
semantics. Using the helper is more self-explanatory.

Besides, the semantic of the helper will stay unchanged even when new
topology is added in the future. At that time, updating the
implementation of the helper without affecting the callers.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20241219110125.1266461-6-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/topology.h | 25 +++++++++++++++++++++++++
 target/i386/cpu.c          | 11 ++++-------
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index 21b65219a5c..f6380f1ed75 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -203,4 +203,29 @@ static inline bool x86_has_extended_topo(unsigned long *topo_bitmap)
            test_bit(CPU_TOPOLOGY_LEVEL_DIE, topo_bitmap);
 }
 
+static inline unsigned x86_module_per_pkg(X86CPUTopoInfo *topo_info)
+{
+    return topo_info->modules_per_die * topo_info->dies_per_pkg;
+}
+
+static inline unsigned x86_cores_per_pkg(X86CPUTopoInfo *topo_info)
+{
+    return topo_info->cores_per_module * x86_module_per_pkg(topo_info);
+}
+
+static inline unsigned x86_threads_per_pkg(X86CPUTopoInfo *topo_info)
+{
+    return topo_info->threads_per_core * x86_cores_per_pkg(topo_info);
+}
+
+static inline unsigned x86_threads_per_module(X86CPUTopoInfo *topo_info)
+{
+    return topo_info->threads_per_core * topo_info->cores_per_module;
+}
+
+static inline unsigned x86_threads_per_die(X86CPUTopoInfo *topo_info)
+{
+    return x86_threads_per_module(topo_info) * topo_info->modules_per_die;
+}
+
 #endif /* HW_I386_TOPOLOGY_H */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6d9c85576f6..a58c719e90c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -312,13 +312,11 @@ static uint32_t num_threads_by_topo_level(X86CPUTopoInfo *topo_info,
     case CPU_TOPOLOGY_LEVEL_CORE:
         return topo_info->threads_per_core;
     case CPU_TOPOLOGY_LEVEL_MODULE:
-        return topo_info->threads_per_core * topo_info->cores_per_module;
+        return x86_threads_per_module(topo_info);
     case CPU_TOPOLOGY_LEVEL_DIE:
-        return topo_info->threads_per_core * topo_info->cores_per_module *
-               topo_info->modules_per_die;
+        return x86_threads_per_die(topo_info);
     case CPU_TOPOLOGY_LEVEL_SOCKET:
-        return topo_info->threads_per_core * topo_info->cores_per_module *
-               topo_info->modules_per_die * topo_info->dies_per_pkg;
+        return x86_threads_per_pkg(topo_info);
     default:
         g_assert_not_reached();
     }
@@ -6506,8 +6504,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     topo_info.cores_per_module = cs->nr_cores / env->nr_dies / env->nr_modules;
     topo_info.threads_per_core = cs->nr_threads;
 
-    threads_per_pkg = topo_info.threads_per_core * topo_info.cores_per_module *
-                      topo_info.modules_per_die * topo_info.dies_per_pkg;
+    threads_per_pkg = x86_threads_per_pkg(&topo_info);
 
     /* Calculate & apply limits for different index ranges */
     if (index >= 0xC0000000) {
-- 
2.47.1


