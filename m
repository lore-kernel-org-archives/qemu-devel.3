Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4688AD39403
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 09:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Eio-00077c-PY; Thu, 02 Apr 2026 05:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w8Eik-00076Q-N4
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 05:52:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w8Eij-0008So-5q
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 05:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775123532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pyTPQJzVYC5in5/dSMWzlphXYjyzR9HnC+1W6LLvFtY=;
 b=ZHJG/iOhB21yb6RmD8tL7wgilgLLoa7B4orLxhQhTCaxBYPx2inVEzuwYTlInEN78fdwPh
 upn2oWp1PoUcJufj7OYj6DRJ0Sb1ZOkkOoDSClt1HefhVzcsnuXIUqJZa0KwxoFz3+5T6s
 fQHZG7V09nuN6lgubmTqGLAeRXKhec8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-7i9MxwZBPai4bpNIaxBBiw-1; Thu,
 02 Apr 2026 05:52:09 -0400
X-MC-Unique: 7i9MxwZBPai4bpNIaxBBiw-1
X-Mimecast-MFC-AGG-ID: 7i9MxwZBPai4bpNIaxBBiw_1775123528
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4FD21956063; Thu,  2 Apr 2026 09:52:07 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.44])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB16C196B088; Thu,  2 Apr 2026 09:52:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 07/10] target/i386: Adjust the suffix of the CPU devices to
 32-bit/64-bit mode
Date: Thu,  2 Apr 2026 11:51:29 +0200
Message-ID: <20260402095132.29245-8-thuth@redhat.com>
In-Reply-To: <20260402095132.29245-1-thuth@redhat.com>
References: <20260402095132.29245-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

qemu-system-i386 uses the suffix "-i386-cpu" for the CPU devices, while
qemu-system-x86_64 uses the suffix "-x86_64-cpu" instead. For supporting
both targets in one binary, we have to adjust the suffix during runtime.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/i386/cpu.h      |  3 ++-
 target/i386/cpu.c      | 29 ++++++++++++++++++++++++-----
 target/i386/host-cpu.c |  6 +++++-
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9d71d1dcca7..38309773ea8 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2775,10 +2775,11 @@ void cpu_x86_update_dr7(CPUX86State *env, uint32_t new_dr7);
 uint64_t cpu_get_tsc(CPUX86State *env);
 
 #define CPU_RESOLVING_TYPE TYPE_X86_CPU
+#define I386_CPU_TYPE_SUFFIX "-i386-cpu"
 
 #ifdef TARGET_X86_64
 #define TARGET_DEFAULT_CPU_TYPE \
-            (target_i386() ? X86_CPU_TYPE_NAME("qemu32") \
+            (target_i386() ? "qemu32" I386_CPU_TYPE_SUFFIX \
                            : X86_CPU_TYPE_NAME("qemu64"))
 #else
 #define TARGET_DEFAULT_CPU_TYPE X86_CPU_TYPE_NAME("qemu32")
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e30d47831d6..98e03cb9a88 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2276,7 +2276,11 @@ void host_cpuid(uint32_t function, uint32_t count,
  */
 static char *x86_cpu_type_name(const char *model_name)
 {
-    return g_strdup_printf(X86_CPU_TYPE_NAME("%s"), model_name);
+    if (target_i386()) {
+        return g_strdup_printf("%s" I386_CPU_TYPE_SUFFIX, model_name);
+    } else {
+        return g_strdup_printf(X86_CPU_TYPE_NAME("%s"), model_name);
+    }
 }
 
 static ObjectClass *x86_cpu_class_by_name(const char *cpu_model)
@@ -2288,7 +2292,16 @@ static ObjectClass *x86_cpu_class_by_name(const char *cpu_model)
 static char *x86_cpu_class_get_model_name(X86CPUClass *cc)
 {
     const char *class_name = object_class_get_name(OBJECT_CLASS(cc));
-    assert(g_str_has_suffix(class_name, X86_CPU_TYPE_SUFFIX));
+    const char *type_suffix;
+
+    if (target_i386()) {
+        type_suffix = I386_CPU_TYPE_SUFFIX;
+    } else {
+        type_suffix = X86_CPU_TYPE_SUFFIX;
+    }
+
+    assert(g_str_has_suffix(class_name, type_suffix));
+
     return cpu_model_from_type(class_name);
 }
 
@@ -7266,7 +7279,7 @@ static void max_x86_cpu_initfn(Object *obj)
     }
 }
 
-static const TypeInfo max_x86_cpu_type_info = {
+static TypeInfo max_x86_cpu_type_info = {
     .name = X86_CPU_TYPE_NAME("max"),
     .parent = TYPE_X86_CPU,
     .instance_init = max_x86_cpu_initfn,
@@ -7884,7 +7897,8 @@ static gint x86_cpu_list_compare(gconstpointer a, gconstpointer b, gpointer d)
 
 static GSList *get_sorted_cpu_model_list(void)
 {
-    GSList *list = object_class_get_list(TYPE_X86_CPU, false);
+    GSList *list = object_class_get_list(target_i386() ?
+                                         "i386-cpu" : TYPE_X86_CPU, false);
     list = g_slist_sort_with_data(list, x86_cpu_list_compare, NULL);
     return list;
 }
@@ -10818,7 +10832,7 @@ static void x86_cpu_base_class_init(ObjectClass *oc, const void *data)
     xcc->ordering = 8;
 }
 
-static const TypeInfo x86_base_cpu_type_info = {
+static TypeInfo x86_base_cpu_type_info = {
         .name = X86_CPU_TYPE_NAME("base"),
         .parent = TYPE_X86_CPU,
         .class_init = x86_cpu_base_class_init,
@@ -10832,6 +10846,11 @@ static void x86_cpu_register_types(void)
     for (i = 0; i < ARRAY_SIZE(builtin_x86_defs); i++) {
         x86_register_cpudef_types(&builtin_x86_defs[i]);
     }
+
+    if (target_i386()) {
+        x86_base_cpu_type_info.name = "base" I386_CPU_TYPE_SUFFIX;
+        max_x86_cpu_type_info.name = "max" I386_CPU_TYPE_SUFFIX;
+    }
     type_register_static(&max_x86_cpu_type_info);
     type_register_static(&x86_base_cpu_type_info);
 }
diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
index d5e2bb5e187..a6b8bb484b3 100644
--- a/target/i386/host-cpu.c
+++ b/target/i386/host-cpu.c
@@ -179,7 +179,7 @@ static void host_cpu_class_init(ObjectClass *oc, const void *data)
         g_strdup_printf("processor with all supported host features ");
 }
 
-static const TypeInfo host_cpu_type_info = {
+static TypeInfo host_cpu_type_info = {
     .name = X86_CPU_TYPE_NAME("host"),
     .parent = X86_CPU_TYPE_NAME("max"),
     .class_init = host_cpu_class_init,
@@ -187,6 +187,10 @@ static const TypeInfo host_cpu_type_info = {
 
 static void host_cpu_type_init(void)
 {
+    if (target_i386()) {
+        host_cpu_type_info.name = "host" I386_CPU_TYPE_SUFFIX;
+        host_cpu_type_info.parent = "max" I386_CPU_TYPE_SUFFIX;
+    }
     type_register_static(&host_cpu_type_info);
 }
 
-- 
2.53.0


