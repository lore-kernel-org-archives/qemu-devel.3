Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD01DC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNuh-0008QV-Lm; Wed, 12 Jun 2024 09:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sHNuf-0008My-31
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:21:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sHNuc-0003ui-Sy
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718198474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=76NiWBKyQcEFElyQMaFGltfiHdnMty6s8Qu7s1R1agU=;
 b=Ez93P1K9ugnMJ8Vm8t5R1+W+ZqtEqgWMpFu3PPZLY1katEmuJNmTejj3c5fTBtZ43hmr83
 kZh19StO9H+ycSN912mc/BftvOoGpFIstApoxvJzthn1/AzvGK7QTgtacUbe4cwtenfDg7
 vD1aNnc3bBBT1kp8npblsJ0TScIWIMk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-JPNK3KxlPbOJpOT2enaKMw-1; Wed,
 12 Jun 2024 09:21:12 -0400
X-MC-Unique: JPNK3KxlPbOJpOT2enaKMw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 658AD1955E7D; Wed, 12 Jun 2024 13:21:11 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.236])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EA8221956087; Wed, 12 Jun 2024 13:21:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 04/15] tests/qtest/x86: check for availability of older cpu
 models before running tests
Date: Wed, 12 Jun 2024 15:20:44 +0200
Message-ID: <20240612132055.326889-5-thuth@redhat.com>
In-Reply-To: <20240612132055.326889-1-thuth@redhat.com>
References: <20240612132055.326889-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Ani Sinha <anisinha@redhat.com>

It is better to check if some older cpu models like 486, athlon, pentium,
penryn, phenom, core2duo etc are available before running their corresponding
tests. Some downstream distributions may no longer support these older cpu
models.

Signature of add_feature_test() has been modified to return void as
FeatureTestArgs* was not used by the caller.

One minor correction. Replaced 'phenom' with '486' in the test
'x86/cpuid/auto-level/phenom/arat' matching the cpu used.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20240610155303.7933-4-anisinha@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/test-x86-cpuid-compat.c | 170 ++++++++++++++++++----------
 1 file changed, 108 insertions(+), 62 deletions(-)

diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
index 6a39454fce..b9e7e5ef7b 100644
--- a/tests/qtest/test-x86-cpuid-compat.c
+++ b/tests/qtest/test-x86-cpuid-compat.c
@@ -67,10 +67,29 @@ static void test_cpuid_prop(const void *data)
     g_free(path);
 }
 
-static void add_cpuid_test(const char *name, const char *cmdline,
+static void add_cpuid_test(const char *name, const char *cpu,
+                           const char *cpufeat, const char *machine,
                            const char *property, int64_t expected_value)
 {
     CpuidTestArgs *args = g_new0(CpuidTestArgs, 1);
+    char *cmdline;
+    char *save;
+
+    if (!qtest_has_cpu_model(cpu)) {
+        return;
+    }
+    cmdline = g_strdup_printf("-cpu %s", cpu);
+
+    if (cpufeat) {
+        save = cmdline;
+        cmdline = g_strdup_printf("%s,%s", cmdline, cpufeat);
+        g_free(save);
+    }
+    if (machine) {
+        save = cmdline;
+        cmdline = g_strdup_printf("-machine %s %s", machine, cmdline);
+        g_free(save);
+    }
     args->cmdline = cmdline;
     args->property = property;
     args->expected_value = expected_value;
@@ -149,12 +168,24 @@ static void test_feature_flag(const void *data)
  * either "feature-words" or "filtered-features", when running QEMU
  * using cmdline
  */
-static FeatureTestArgs *add_feature_test(const char *name, const char *cmdline,
-                                         uint32_t eax, uint32_t ecx,
-                                         const char *reg, int bitnr,
-                                         bool expected_value)
+static void add_feature_test(const char *name, const char *cpu,
+                             const char *cpufeat, uint32_t eax,
+                             uint32_t ecx, const char *reg,
+                             int bitnr, bool expected_value)
 {
     FeatureTestArgs *args = g_new0(FeatureTestArgs, 1);
+    char *cmdline;
+
+    if (!qtest_has_cpu_model(cpu)) {
+        return;
+    }
+
+    if (cpufeat) {
+        cmdline = g_strdup_printf("-cpu %s,%s", cpu, cpufeat);
+    } else {
+        cmdline = g_strdup_printf("-cpu %s", cpu);
+    }
+
     args->cmdline = cmdline;
     args->in_eax = eax;
     args->in_ecx = ecx;
@@ -162,13 +193,17 @@ static FeatureTestArgs *add_feature_test(const char *name, const char *cmdline,
     args->bitnr = bitnr;
     args->expected_value = expected_value;
     qtest_add_data_func(name, args, test_feature_flag);
-    return args;
+    return;
 }
 
 static void test_plus_minus_subprocess(void)
 {
     char *path;
 
+    if (!qtest_has_cpu_model("pentium")) {
+        return;
+    }
+
     /* Rules:
      * 1)"-foo" overrides "+foo"
      * 2) "[+-]foo" overrides "foo=..."
@@ -198,6 +233,10 @@ static void test_plus_minus_subprocess(void)
 
 static void test_plus_minus(void)
 {
+    if (!qtest_has_cpu_model("pentium")) {
+        return;
+    }
+
     g_test_trap_subprocess("/x86/cpuid/parsing-plus-minus/subprocess", 0, 0);
     g_test_trap_assert_passed();
     g_test_trap_assert_stderr("*Ambiguous CPU model string. "
@@ -217,99 +256,105 @@ int main(int argc, char **argv)
 
     /* Original level values for CPU models: */
     add_cpuid_test("x86/cpuid/phenom/level",
-                   "-cpu phenom", "level", 5);
+                   "phenom", NULL, NULL, "level", 5);
     add_cpuid_test("x86/cpuid/Conroe/level",
-                   "-cpu Conroe", "level", 10);
+                   "Conroe", NULL, NULL, "level", 10);
     add_cpuid_test("x86/cpuid/SandyBridge/level",
-                   "-cpu SandyBridge", "level", 0xd);
+                   "SandyBridge", NULL, NULL, "level", 0xd);
     add_cpuid_test("x86/cpuid/486/xlevel",
-                   "-cpu 486", "xlevel", 0);
+                   "486", NULL, NULL, "xlevel", 0);
     add_cpuid_test("x86/cpuid/core2duo/xlevel",
-                   "-cpu core2duo", "xlevel", 0x80000008);
+                   "core2duo", NULL, NULL, "xlevel", 0x80000008);
     add_cpuid_test("x86/cpuid/phenom/xlevel",
-                   "-cpu phenom", "xlevel", 0x8000001A);
+                   "phenom", NULL, NULL, "xlevel", 0x8000001A);
     add_cpuid_test("x86/cpuid/athlon/xlevel",
-                   "-cpu athlon", "xlevel", 0x80000008);
+                   "athlon", NULL, NULL, "xlevel", 0x80000008);
 
     /* If level is not large enough, it should increase automatically: */
     /* CPUID[6].EAX: */
-    add_cpuid_test("x86/cpuid/auto-level/phenom/arat",
-                   "-cpu 486,arat=on", "level", 6);
+    add_cpuid_test("x86/cpuid/auto-level/486/arat",
+                   "486", "arat=on", NULL, "level", 6);
     /* CPUID[EAX=7,ECX=0].EBX: */
     add_cpuid_test("x86/cpuid/auto-level/phenom/fsgsbase",
-                   "-cpu phenom,fsgsbase=on", "level", 7);
+                   "phenom", "fsgsbase=on", NULL, "level", 7);
     /* CPUID[EAX=7,ECX=0].ECX: */
     add_cpuid_test("x86/cpuid/auto-level/phenom/avx512vbmi",
-                   "-cpu phenom,avx512vbmi=on", "level", 7);
+                   "phenom", "avx512vbmi=on", NULL, "level", 7);
     /* CPUID[EAX=0xd,ECX=1].EAX: */
     add_cpuid_test("x86/cpuid/auto-level/phenom/xsaveopt",
-                   "-cpu phenom,xsaveopt=on", "level", 0xd);
+                   "phenom", "xsaveopt=on", NULL, "level", 0xd);
     /* CPUID[8000_0001].EDX: */
     add_cpuid_test("x86/cpuid/auto-xlevel/486/3dnow",
-                   "-cpu 486,3dnow=on", "xlevel", 0x80000001);
+                   "486", "3dnow=on", NULL, "xlevel", 0x80000001);
     /* CPUID[8000_0001].ECX: */
     add_cpuid_test("x86/cpuid/auto-xlevel/486/sse4a",
-                   "-cpu 486,sse4a=on", "xlevel", 0x80000001);
+                   "486", "sse4a=on", NULL, "xlevel", 0x80000001);
     /* CPUID[8000_0007].EDX: */
     add_cpuid_test("x86/cpuid/auto-xlevel/486/invtsc",
-                   "-cpu 486,invtsc=on", "xlevel", 0x80000007);
+                   "486", "invtsc=on", NULL, "xlevel", 0x80000007);
     /* CPUID[8000_000A].EDX: */
     add_cpuid_test("x86/cpuid/auto-xlevel/486/npt",
-                   "-cpu 486,svm=on,npt=on", "xlevel", 0x8000000A);
+                   "486", "svm=on,npt=on", NULL, "xlevel", 0x8000000A);
     /* CPUID[C000_0001].EDX: */
     add_cpuid_test("x86/cpuid/auto-xlevel2/phenom/xstore",
-                   "-cpu phenom,xstore=on", "xlevel2", 0xC0000001);
+                   "phenom", "xstore=on", NULL, "xlevel2", 0xC0000001);
     /* SVM needs CPUID[0x8000000A] */
     add_cpuid_test("x86/cpuid/auto-xlevel/athlon/svm",
-                   "-cpu athlon,svm=on", "xlevel", 0x8000000A);
+                   "athlon", "svm=on", NULL, "xlevel", 0x8000000A);
 
 
     /* If level is already large enough, it shouldn't change: */
     add_cpuid_test("x86/cpuid/auto-level/SandyBridge/multiple",
-                   "-cpu SandyBridge,arat=on,fsgsbase=on,avx512vbmi=on",
-                   "level", 0xd);
+                   "SandyBridge", "arat=on,fsgsbase=on,avx512vbmi=on",
+                   NULL, "level", 0xd);
     /* If level is explicitly set, it shouldn't change: */
     add_cpuid_test("x86/cpuid/auto-level/486/fixed/0xF",
-                   "-cpu 486,level=0xF,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
-                   "level", 0xF);
+                   "486",
+                   "level=0xF,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
+                   NULL, "level", 0xF);
     add_cpuid_test("x86/cpuid/auto-level/486/fixed/2",
-                   "-cpu 486,level=2,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
-                   "level", 2);
+                   "486",
+                   "level=2,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
+                   NULL, "level", 2);
     add_cpuid_test("x86/cpuid/auto-level/486/fixed/0",
-                   "-cpu 486,level=0,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
-                   "level", 0);
+                   "486",
+                   "level=0,arat=on,fsgsbase=on,avx512vbmi=on,xsaveopt=on",
+                   NULL, "level", 0);
 
     /* if xlevel is already large enough, it shouldn't change: */
     add_cpuid_test("x86/cpuid/auto-xlevel/phenom/3dnow",
-                   "-cpu phenom,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
-                   "xlevel", 0x8000001A);
+                   "phenom", "3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
+                   NULL, "xlevel", 0x8000001A);
     /* If xlevel is explicitly set, it shouldn't change: */
     add_cpuid_test("x86/cpuid/auto-xlevel/486/fixed/80000002",
-                   "-cpu 486,xlevel=0x80000002,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
-                   "xlevel", 0x80000002);
+                   "486",
+                   "xlevel=0x80000002,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
+                   NULL, "xlevel", 0x80000002);
     add_cpuid_test("x86/cpuid/auto-xlevel/486/fixed/8000001A",
-                   "-cpu 486,xlevel=0x8000001A,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
-                   "xlevel", 0x8000001A);
+                   "486",
+                   "xlevel=0x8000001A,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
+                   NULL, "xlevel", 0x8000001A);
     add_cpuid_test("x86/cpuid/auto-xlevel/phenom/fixed/0",
-                   "-cpu 486,xlevel=0,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
-                   "xlevel", 0);
+                   "486",
+                   "xlevel=0,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
+                   NULL, "xlevel", 0);
 
     /* if xlevel2 is already large enough, it shouldn't change: */
     add_cpuid_test("x86/cpuid/auto-xlevel2/486/fixed",
-                   "-cpu 486,xlevel2=0xC0000002,xstore=on",
-                   "xlevel2", 0xC0000002);
+                   "486", "xlevel2=0xC0000002,xstore=on",
+                   NULL, "xlevel2", 0xC0000002);
 
     /* Check compatibility of old machine-types that didn't
      * auto-increase level/xlevel/xlevel2: */
     if (qtest_has_machine("pc-i440fx-2.7")) {
         add_cpuid_test("x86/cpuid/auto-level/pc-2.7",
-                       "-machine pc-i440fx-2.7 -cpu 486,arat=on,avx512vbmi=on,xsaveopt=on",
-                       "level", 1);
+                       "486", "arat=on,avx512vbmi=on,xsaveopt=on",
+                       "pc-i440fx-2.7", "level", 1);
         add_cpuid_test("x86/cpuid/auto-xlevel/pc-2.7",
-                       "-machine pc-i440fx-2.7 -cpu 486,3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
-                       "xlevel", 0);
+                       "486", "3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
+                       "pc-i440fx-2.7", "xlevel", 0);
         add_cpuid_test("x86/cpuid/auto-xlevel2/pc-2.7",
-                       "-machine pc-i440fx-2.7 -cpu 486,xstore=on",
+                       "486", "xstore=on", "pc-i440fx-2.7",
                        "xlevel2", 0);
     }
     /*
@@ -319,18 +364,18 @@ int main(int argc, char **argv)
      */
     if (qtest_has_machine("pc-i440fx-2.3")) {
         add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.3/off",
-                       "-machine pc-i440fx-2.3 -cpu Penryn",
+                       "Penryn", NULL, "pc-i440fx-2.3",
                        "level", 4);
         add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.3/on",
-                       "-machine pc-i440fx-2.3 -cpu Penryn,erms=on",
+                       "Penryn", "erms=on", "pc-i440fx-2.3",
                        "level", 7);
     }
     if (qtest_has_machine("pc-i440fx-2.9")) {
         add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.9/off",
-                       "-machine pc-i440fx-2.9 -cpu Conroe",
+                       "Conroe", NULL, "pc-i440fx-2.9",
                        "level", 10);
         add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.9/on",
-                       "-machine pc-i440fx-2.9 -cpu Conroe,erms=on",
+                       "Conroe", "erms=on", "pc-i440fx-2.9",
                        "level", 10);
     }
 
@@ -341,42 +386,43 @@ int main(int argc, char **argv)
      */
     if (qtest_has_machine("pc-i440fx-2.3")) {
         add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.3",
-                       "-machine pc-i440fx-2.3 -cpu SandyBridge",
+                       "SandyBridge", NULL, "pc-i440fx-2.3",
                        "xlevel", 0x8000000a);
     }
     if (qtest_has_machine("pc-i440fx-2.4")) {
         add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.4/npt-off",
-                       "-machine pc-i440fx-2.4 -cpu SandyBridge,",
+                       "SandyBridge", NULL, "pc-i440fx-2.4",
                        "xlevel", 0x80000008);
         add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.4/npt-on",
-                       "-machine pc-i440fx-2.4 -cpu SandyBridge,svm=on,npt=on",
+                       "SandyBridge", "svm=on,npt=on", "pc-i440fx-2.4",
                        "xlevel", 0x80000008);
     }
 
     /* Test feature parsing */
     add_feature_test("x86/cpuid/features/plus",
-                     "-cpu 486,+arat",
+                     "486", "+arat",
                      6, 0, "EAX", 2, true);
     add_feature_test("x86/cpuid/features/minus",
-                     "-cpu pentium,-mmx",
+                     "pentium", "-mmx",
                      1, 0, "EDX", 23, false);
     add_feature_test("x86/cpuid/features/on",
-                     "-cpu 486,arat=on",
+                     "486", "arat=on",
                      6, 0, "EAX", 2, true);
     add_feature_test("x86/cpuid/features/off",
-                     "-cpu pentium,mmx=off",
+                     "pentium", "mmx=off",
                      1, 0, "EDX", 23, false);
+
     add_feature_test("x86/cpuid/features/max-plus-invtsc",
-                     "-cpu max,+invtsc",
+                     "max" , "+invtsc",
                      0x80000007, 0, "EDX", 8, true);
     add_feature_test("x86/cpuid/features/max-invtsc-on",
-                     "-cpu max,invtsc=on",
+                     "max", "invtsc=on",
                      0x80000007, 0, "EDX", 8, true);
     add_feature_test("x86/cpuid/features/max-minus-mmx",
-                     "-cpu max,-mmx",
+                     "max", "-mmx",
                      1, 0, "EDX", 23, false);
     add_feature_test("x86/cpuid/features/max-invtsc-on,mmx=off",
-                     "-cpu max,mmx=off",
+                     "max", "mmx=off",
                      1, 0, "EDX", 23, false);
 
     return g_test_run();
-- 
2.45.2


