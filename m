Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846F3C25B7D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9wp-0007Y2-9L; Thu, 23 May 2024 11:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9wX-0006qE-RM
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:01:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9wT-0004sA-P7
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:01:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yShvUnEFBwEY8j4FPXWBnw3WpDlGcdHPUpfwzzGz26M=;
 b=Lzj0PgD1gwXSHQmv+y7TsvntRZAutHtxUDkJEpY8TZT3EMmCR4629KzZur05csq5hFdbO+
 F6rG29A+SCLSGVfiMIJGAktFipCoK5xFqVhyTGmf5nU6PZ9g2mWxVM8CLRcmjoezVjCm/d
 gYqTLmv5Tx6Qaq31q6YL9wN8byFf150=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-6tvtcunUNQaYFb8TLfOhGA-1; Thu, 23 May 2024 11:01:15 -0400
X-MC-Unique: 6tvtcunUNQaYFb8TLfOhGA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59a5b06802so98418366b.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476473; x=1717081273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yShvUnEFBwEY8j4FPXWBnw3WpDlGcdHPUpfwzzGz26M=;
 b=GTzb5Kyd3a1mF0G5GqHAMRONQf8htBNM3y3c9d/fdwAZgUIMZlSFtl7qeCOBefu8mx
 s9UHgqPkKN8Y7EezQUqquWoqeVS3oGR7zCM8I3dj0Pi4qjxohn38mOacvHvwoxMFZcCu
 r9otir62nZHHtwa/1xYr3z2zm+DuzH23yNgfi2GlrwWrBCsP9E/Pqy5XFvTZYnRATvEW
 obxwcmBASZ9S8K1U6dPX1srJSKkcs7VcaeCUk6uUBfSccNi/PiP3Euy1zHyLmbguOSrA
 kO5n/obEkwi+XTSLXBfZIJdTqbiaGDcVni3CXRLeLthQZHwf/m3UyaJvjKVD/ebj9k5h
 b0Sg==
X-Gm-Message-State: AOJu0YzkpgNnqQTwClQhUgSM/iH2RulFgaqr0zJdvyXhVD35Iph3hIaW
 BbCNit7a7CG8HYCbndcnJoplJAaTLe6Tv0vyRVBP/m4jTBOCTiAeXsNJtPp5HSHw5puTAF+N999
 BEUb1Ri/jVoPbWT5VzqOaeM3p5jK1swdD9bTCFVb2xbkhutf4XY2aX4fwcWTqywnm0YZjoFCzp6
 XtzYgmpITSqs/bo3eCS5/A6Xb9i+idSYg4hmcf
X-Received: by 2002:a17:906:6d85:b0:a5a:84f9:df73 with SMTP id
 a640c23a62f3a-a62280a12e6mr334618366b.38.1716476473377; 
 Thu, 23 May 2024 08:01:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8GxDGdlbBtjruH7ye7KRQ9Ge4f62Jgq8hZrQEPHXpEWKDAtawk404Vw1hWm86OarHBrHTwg==
X-Received: by 2002:a17:906:6d85:b0:a5a:84f9:df73 with SMTP id
 a640c23a62f3a-a62280a12e6mr334616966b.38.1716476473008; 
 Thu, 23 May 2024 08:01:13 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5cdd7f8ea1sm1106720866b.109.2024.05.23.08.01.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:01:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Babu Moger <babu.moger@amd.com>
Subject: [PULL 14/23] i386: Support modules_per_die in X86CPUTopoInfo
Date: Thu, 23 May 2024 17:00:27 +0200
Message-ID: <20240523150036.1050011-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523150036.1050011-1-pbonzini@redhat.com>
References: <20240523150036.1050011-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Support module level in i386 cpu topology structure "X86CPUTopoInfo".

Since x86 does not yet support the "modules" parameter in "-smp",
X86CPUTopoInfo.modules_per_die is currently always 1.

Therefore, the module level width in APIC ID, which can be calculated by
"apicid_bitwidth_for_count(topo_info->modules_per_die)", is always 0 for
now, so we can directly add APIC ID related helpers to support module
level parsing.

In addition, update topology structure in test-x86-topo.c.

Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Co-developed-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Message-ID: <20240424154929.1487382-14-zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/topology.h | 22 +++++++++++++++----
 hw/i386/x86.c              |  9 +++++++-
 target/i386/cpu.c          | 13 ++++++-----
 tests/unit/test-x86-topo.c | 45 ++++++++++++++++++++------------------
 4 files changed, 58 insertions(+), 31 deletions(-)

diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index befeb92b0b1..7622d806932 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -56,7 +56,8 @@ typedef struct X86CPUTopoIDs {
 
 typedef struct X86CPUTopoInfo {
     unsigned dies_per_pkg;
-    unsigned cores_per_die;
+    unsigned modules_per_die;
+    unsigned cores_per_module;
     unsigned threads_per_core;
 } X86CPUTopoInfo;
 
@@ -92,7 +93,13 @@ static inline unsigned apicid_smt_width(X86CPUTopoInfo *topo_info)
 /* Bit width of the Core_ID field */
 static inline unsigned apicid_core_width(X86CPUTopoInfo *topo_info)
 {
-    return apicid_bitwidth_for_count(topo_info->cores_per_die);
+    return apicid_bitwidth_for_count(topo_info->cores_per_module);
+}
+
+/* Bit width of the Module_ID field */
+static inline unsigned apicid_module_width(X86CPUTopoInfo *topo_info)
+{
+    return apicid_bitwidth_for_count(topo_info->modules_per_die);
 }
 
 /* Bit width of the Die_ID field */
@@ -107,10 +114,16 @@ static inline unsigned apicid_core_offset(X86CPUTopoInfo *topo_info)
     return apicid_smt_width(topo_info);
 }
 
+/* Bit offset of the Module_ID field */
+static inline unsigned apicid_module_offset(X86CPUTopoInfo *topo_info)
+{
+    return apicid_core_offset(topo_info) + apicid_core_width(topo_info);
+}
+
 /* Bit offset of the Die_ID field */
 static inline unsigned apicid_die_offset(X86CPUTopoInfo *topo_info)
 {
-    return apicid_core_offset(topo_info) + apicid_core_width(topo_info);
+    return apicid_module_offset(topo_info) + apicid_module_width(topo_info);
 }
 
 /* Bit offset of the Pkg_ID (socket ID) field */
@@ -142,7 +155,8 @@ static inline void x86_topo_ids_from_idx(X86CPUTopoInfo *topo_info,
                                          X86CPUTopoIDs *topo_ids)
 {
     unsigned nr_dies = topo_info->dies_per_pkg;
-    unsigned nr_cores = topo_info->cores_per_die;
+    unsigned nr_cores = topo_info->cores_per_module *
+                        topo_info->modules_per_die;
     unsigned nr_threads = topo_info->threads_per_core;
 
     topo_ids->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 0b5cc599566..d5d668e814d 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -45,7 +45,14 @@ void init_topo_info(X86CPUTopoInfo *topo_info,
     MachineState *ms = MACHINE(x86ms);
 
     topo_info->dies_per_pkg = ms->smp.dies;
-    topo_info->cores_per_die = ms->smp.cores;
+    /*
+     * Though smp.modules means the number of modules in one cluster,
+     * i386 doesn't support cluster level so that the smp.clusters
+     * always defaults to 1, therefore using smp.modules directly is
+     * fine here.
+     */
+    topo_info->modules_per_die = ms->smp.modules;
+    topo_info->cores_per_module = ms->smp.cores;
     topo_info->threads_per_core = ms->smp.threads;
 }
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index eb1642c253c..92aa4498551 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -278,10 +278,11 @@ static uint32_t num_threads_by_topo_level(X86CPUTopoInfo *topo_info,
     case CPU_TOPO_LEVEL_CORE:
         return topo_info->threads_per_core;
     case CPU_TOPO_LEVEL_DIE:
-        return topo_info->threads_per_core * topo_info->cores_per_die;
+        return topo_info->threads_per_core * topo_info->cores_per_module *
+               topo_info->modules_per_die;
     case CPU_TOPO_LEVEL_PACKAGE:
-        return topo_info->threads_per_core * topo_info->cores_per_die *
-               topo_info->dies_per_pkg;
+        return topo_info->threads_per_core * topo_info->cores_per_module *
+               topo_info->modules_per_die * topo_info->dies_per_pkg;
     default:
         g_assert_not_reached();
     }
@@ -6278,10 +6279,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     uint32_t threads_per_pkg;
 
     topo_info.dies_per_pkg = env->nr_dies;
-    topo_info.cores_per_die = cs->nr_cores / env->nr_dies;
+    topo_info.modules_per_die = env->nr_modules;
+    topo_info.cores_per_module = cs->nr_cores / env->nr_dies / env->nr_modules;
     topo_info.threads_per_core = cs->nr_threads;
 
-    cores_per_pkg = topo_info.cores_per_die * topo_info.dies_per_pkg;
+    cores_per_pkg = topo_info.cores_per_module * topo_info.modules_per_die *
+                    topo_info.dies_per_pkg;
     threads_per_pkg = cores_per_pkg * topo_info.threads_per_core;
 
     /* Calculate & apply limits for different index ranges */
diff --git a/tests/unit/test-x86-topo.c b/tests/unit/test-x86-topo.c
index 2b104f86d7c..f21b8a5d95c 100644
--- a/tests/unit/test-x86-topo.c
+++ b/tests/unit/test-x86-topo.c
@@ -30,13 +30,16 @@ static void test_topo_bits(void)
 {
     X86CPUTopoInfo topo_info = {0};
 
-    /* simple tests for 1 thread per core, 1 core per die, 1 die per package */
-    topo_info = (X86CPUTopoInfo) {1, 1, 1};
+    /*
+     * simple tests for 1 thread per core, 1 core per module,
+     *                  1 module per die, 1 die per package
+     */
+    topo_info = (X86CPUTopoInfo) {1, 1, 1, 1};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 0);
     g_assert_cmpuint(apicid_core_width(&topo_info), ==, 0);
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
 
-    topo_info = (X86CPUTopoInfo) {1, 1, 1};
+    topo_info = (X86CPUTopoInfo) {1, 1, 1, 1};
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), ==, 0);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), ==, 1);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), ==, 2);
@@ -45,39 +48,39 @@ static void test_topo_bits(void)
 
     /* Test field width calculation for multiple values
      */
-    topo_info = (X86CPUTopoInfo) {1, 1, 2};
+    topo_info = (X86CPUTopoInfo) {1, 1, 1, 2};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 1);
-    topo_info = (X86CPUTopoInfo) {1, 1, 3};
+    topo_info = (X86CPUTopoInfo) {1, 1, 1, 3};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
-    topo_info = (X86CPUTopoInfo) {1, 1, 4};
+    topo_info = (X86CPUTopoInfo) {1, 1, 1, 4};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
 
-    topo_info = (X86CPUTopoInfo) {1, 1, 14};
+    topo_info = (X86CPUTopoInfo) {1, 1, 1, 14};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
-    topo_info = (X86CPUTopoInfo) {1, 1, 15};
+    topo_info = (X86CPUTopoInfo) {1, 1, 1, 15};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
-    topo_info = (X86CPUTopoInfo) {1, 1, 16};
+    topo_info = (X86CPUTopoInfo) {1, 1, 1, 16};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 4);
-    topo_info = (X86CPUTopoInfo) {1, 1, 17};
+    topo_info = (X86CPUTopoInfo) {1, 1, 1, 17};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 5);
 
 
-    topo_info = (X86CPUTopoInfo) {1, 30, 2};
+    topo_info = (X86CPUTopoInfo) {1, 1, 30, 2};
     g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
-    topo_info = (X86CPUTopoInfo) {1, 31, 2};
+    topo_info = (X86CPUTopoInfo) {1, 1, 31, 2};
     g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
-    topo_info = (X86CPUTopoInfo) {1, 32, 2};
+    topo_info = (X86CPUTopoInfo) {1, 1, 32, 2};
     g_assert_cmpuint(apicid_core_width(&topo_info), ==, 5);
-    topo_info = (X86CPUTopoInfo) {1, 33, 2};
+    topo_info = (X86CPUTopoInfo) {1, 1, 33, 2};
     g_assert_cmpuint(apicid_core_width(&topo_info), ==, 6);
 
-    topo_info = (X86CPUTopoInfo) {1, 30, 2};
+    topo_info = (X86CPUTopoInfo) {1, 1, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 0);
-    topo_info = (X86CPUTopoInfo) {2, 30, 2};
+    topo_info = (X86CPUTopoInfo) {2, 1, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 1);
-    topo_info = (X86CPUTopoInfo) {3, 30, 2};
+    topo_info = (X86CPUTopoInfo) {3, 1, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 2);
-    topo_info = (X86CPUTopoInfo) {4, 30, 2};
+    topo_info = (X86CPUTopoInfo) {4, 1, 30, 2};
     g_assert_cmpuint(apicid_die_width(&topo_info), ==, 2);
 
     /* build a weird topology and see if IDs are calculated correctly
@@ -85,18 +88,18 @@ static void test_topo_bits(void)
 
     /* This will use 2 bits for thread ID and 3 bits for core ID
      */
-    topo_info = (X86CPUTopoInfo) {1, 6, 3};
+    topo_info = (X86CPUTopoInfo) {1, 1, 6, 3};
     g_assert_cmpuint(apicid_smt_width(&topo_info), ==, 2);
     g_assert_cmpuint(apicid_core_offset(&topo_info), ==, 2);
     g_assert_cmpuint(apicid_die_offset(&topo_info), ==, 5);
     g_assert_cmpuint(apicid_pkg_offset(&topo_info), ==, 5);
 
-    topo_info = (X86CPUTopoInfo) {1, 6, 3};
+    topo_info = (X86CPUTopoInfo) {1, 1, 6, 3};
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 0), ==, 0);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1), ==, 1);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 2), ==, 2);
 
-    topo_info = (X86CPUTopoInfo) {1, 6, 3};
+    topo_info = (X86CPUTopoInfo) {1, 1, 6, 3};
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 0), ==,
                      (1 << 2) | 0);
     g_assert_cmpuint(x86_apicid_from_cpu_idx(&topo_info, 1 * 3 + 1), ==,
-- 
2.45.1


