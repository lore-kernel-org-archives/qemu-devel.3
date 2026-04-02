Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB9AD39403
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 09:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Eif-00071H-ET; Thu, 02 Apr 2026 05:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w8Eid-0006yf-8z
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 05:52:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w8Eib-0008Rj-Mk
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 05:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775123525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+FNWndfStrXRe45c1QA3gdzqzvHq7VxWRyMNbGtJxVg=;
 b=S520Cr0OnOoBzHdgnhm6fcuBO7sEoz3twcKwQbLABo0kUy9ulftG0RfBX9pdeEbAZTxoik
 JabrrSPn4TD1TKzxJNTKmXDBSr9CmSJU1NGqBdGC9tl3QmTcuRkGXScNGPYzMRKLbD6uHZ
 7BzSCvvCmmjCdHS4Ea9z9kWdXBdSHr4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-vir7AfNrO3OJaPqoP7-ShQ-1; Thu,
 02 Apr 2026 05:52:00 -0400
X-MC-Unique: vir7AfNrO3OJaPqoP7-ShQ-1
X-Mimecast-MFC-AGG-ID: vir7AfNrO3OJaPqoP7-ShQ_1775123519
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D01461956096; Thu,  2 Apr 2026 09:51:59 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.44])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8574719373D8; Thu,  2 Apr 2026 09:51:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 05/10] target/i386/cpu: Allow to limit the 64-bit binary to
 32-bit mode only
Date: Thu,  2 Apr 2026 11:51:27 +0200
Message-ID: <20260402095132.29245-6-thuth@redhat.com>
In-Reply-To: <20260402095132.29245-1-thuth@redhat.com>
References: <20260402095132.29245-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

From: Thomas Huth <thuth@redhat.com>

qemu-system-x86_64 is pretty much a proper superset of qemu-system-i386,
so in the long run, it does not make too much sense that we continuously
build two binaries here, we should deprecate the latter rather sooner
than later.
However, some people still might want to start QEMU in a mode that limits
the environment to 32-bit. Thus allow qemu-system-x86_64 to run in 32-bit
mode if the binary name ends in "-i386".

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/i386/cpu.h     | 15 +++------------
 target/i386/cpu.c     | 20 ++++++++++----------
 target/i386/gdbstub.c |  2 +-
 3 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0b539155c40..9cb357aa797 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -36,13 +36,8 @@
 
 #define XEN_NR_VIRQS 24
 
-#ifdef TARGET_X86_64
-#define I386_ELF_MACHINE  EM_X86_64
-#define ELF_MACHINE_UNAME "x86_64"
-#else
-#define I386_ELF_MACHINE  EM_386
-#define ELF_MACHINE_UNAME "i686"
-#endif
+#define I386_ELF_MACHINE  (target_x86_64() ? EM_X86_64 : EM_386)
+#define ELF_MACHINE_UNAME (target_x86_64() ? "x86_64" : "i686")
 
 enum {
     R_EAX = 0,
@@ -277,11 +272,7 @@ typedef enum X86Seg {
 #define CR4_PKS_MASK   (1U << 24)
 #define CR4_LAM_SUP_MASK (1U << 28)
 
-#ifdef TARGET_X86_64
-#define CR4_FRED_MASK   (1ULL << 32)
-#else
-#define CR4_FRED_MASK   0
-#endif
+#define CR4_FRED_MASK   (target_x86_64() ? (1ULL << 32) : 0)
 
 #define CR4_RESERVED_MASK \
 (~(target_ulong)(CR4_VME_MASK | CR4_PVI_MASK | CR4_TSD_MASK \
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c6fd1dc00eb..e30d47831d6 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8094,18 +8094,18 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
     }
 
     switch (w) {
-#ifndef TARGET_X86_64
     case FEAT_8000_0001_EDX:
         /*
          * 32-bit TCG can emulate 64-bit compatibility mode.  If there is no
          * way for userspace to get out of its 32-bit jail, we can leave
          * the LM bit set.
          */
-        unavail = tcg_enabled()
-            ? CPUID_EXT2_LM & ~CPUID_EXT2_KERNEL_FEATURES
-            : CPUID_EXT2_LM;
+        if (target_i386()) {
+            unavail = tcg_enabled()
+                ? CPUID_EXT2_LM & ~CPUID_EXT2_KERNEL_FEATURES
+                : CPUID_EXT2_LM;
+        }
         break;
-#endif
 
     case FEAT_8000_0007_EBX:
         if (cpu && !IS_AMD_CPU(&cpu->env)) {
@@ -8351,11 +8351,11 @@ static void x86_cpu_load_model(X86CPU *cpu, const X86CPUModel *model)
 
 static const gchar *x86_gdb_arch_name(CPUState *cs)
 {
-#ifdef TARGET_X86_64
-    return "i386:x86-64";
-#else
-    return "i386";
-#endif
+    if (target_x86_64()) {
+        return "i386:x86-64";
+    } else {
+        return "i386";
+    }
 }
 
 static void x86_cpu_cpudef_class_init(ObjectClass *oc, const void *data)
diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index 5c5fa727216..951c443e6d2 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -498,7 +498,7 @@ void x86_cpu_gdb_init(CPUState *cs)
 #ifdef TARGET_X86_64
     CPUX86State *env = &X86_CPU(cs)->env;
 
-    if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_APXF) {
+    if (target_x86_64() && (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_APXF)) {
         gdb_register_coprocessor(cs, i386_cpu_gdb_get_egprs,
                                  i386_cpu_gdb_set_egprs,
                                  gdb_find_static_feature("i386-64bit-apx.xml"));
-- 
2.53.0


