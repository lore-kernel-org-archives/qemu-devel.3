Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4F6C27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 14:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sErOy-0001mb-96; Wed, 05 Jun 2024 10:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sErOx-0001lz-3P
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:14:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sErOu-0004nB-TB
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717596844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tcl0qZl4zU184pZcQrM7oLNyygIhSEBwyRI8ZNXhceI=;
 b=UTzj0cI6+3IHaCyYKKwF7MPeXzhlu+T6wsbTql5HLElXts4bZbYdQ0Q4Wu2qGyRIlxg2/7
 3ZLGPhsIHfTjOknV+FnQWqUR5wtaPP7nqkFMMgdWi6t08uI4H05NWNZX0fyn9HcSqvc0xV
 JjYxRmztKmpV+kq8c4m+fS/PxEgjpRM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507--eul_6I2PdKIl65r-AsyqA-1; Wed, 05 Jun 2024 10:14:02 -0400
X-MC-Unique: -eul_6I2PdKIl65r-AsyqA-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1f6768af0b3so33499955ad.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 07:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717596842; x=1718201642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tcl0qZl4zU184pZcQrM7oLNyygIhSEBwyRI8ZNXhceI=;
 b=iIFW05GnkstiXcS+ah/ktEm40h5M7S3AXeAHvQqgvZGI3xSjzTswNFy2DeEVxHudK1
 inbONLGmjGuPNCuBQxwl6yn3YiiOsmDGkbBOCCcgqvHXrofYQo/wf4SMqJgOXGelRsAM
 zfPz/QEPYv3JO/dW0erFKRPUU2sQZ6NLNRIj8y7ynkqPkjn58n3RJxRexq80yPNMme45
 8Iqdtsp5GfxWn2hZCIL6Y406vCKrJZozEqsK+ilKGCXP6mIr3oRcrbCoThQcXPDod+2v
 Xh65LQ2wEZpUcca2lkSt+qnFnmJXrKU0CwgDI/RJpS/aRVE44hhZV1V5xdB/ZKSl3Zr3
 jJzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ6at41VSA2eED2dpp3beOzo26R2C03NmhTa8rNSIEQAPJESUbm9KtiYl03oPMtdbMyv9WY9LYp5L1x7DaQOGiRlE4/5o=
X-Gm-Message-State: AOJu0YzARbdtm+ePsIHaj3kxbeZlV5GP/li6SZGh4pOmYVJpO9ooAO4k
 XVdgpR7DtuEn78qguSxkiwVH35sj0zq6ZVQNcESP03gqFczRmrqEX7fs8FSiKp3bbKIW/e70VTI
 cz2sZ9ZEMpjg6SI5YK3+kG5nO6vMC/SZH7l+YLO5qEeW5XwhLwEvh
X-Received: by 2002:a17:902:e84e:b0:1f6:77e3:774c with SMTP id
 d9443c01a7336-1f6a5a1931amr33910605ad.38.1717596841573; 
 Wed, 05 Jun 2024 07:14:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGjfLKS6H939LaQ3XHWouVVDyK939lU/Ow5aqQ35/OAVpORyjytjLF7BXWYYyuow42OSjNXw==
X-Received: by 2002:a17:902:e84e:b0:1f6:77e3:774c with SMTP id
 d9443c01a7336-1f6a5a1931amr33910355ad.38.1717596841120; 
 Wed, 05 Jun 2024 07:14:01 -0700 (PDT)
Received: from localhost.localdomain ([203.163.232.78])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-1f6323ddac9sm105225665ad.173.2024.06.05.07.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 07:14:00 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] tests/qtest/x86: check for availability of older cpu
 models before running tests
Date: Wed,  5 Jun 2024 19:43:16 +0530
Message-ID: <20240605141316.91955-4-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240605141316.91955-1-anisinha@redhat.com>
References: <20240605141316.91955-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

It is better to check if some older cpu models like 486, athlon, pentium,
penryn, phenom, core2duo etc are available before running their corresponding
tests. Some downstream distributions may no longer support these older cpu
models.

One minor correction. Replaced 'phenom' with '486' in the test
'x86/cpuid/auto-level/phenom/arat' matching the cpu used.

CC: thuth@redhat.com
CC: imammedo@redhat.com
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/qtest/test-x86-cpuid-compat.c | 159 +++++++++++++++++-----------
 1 file changed, 98 insertions(+), 61 deletions(-)

changelog:
v2: reworked as per suggestion from danpb.

diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
index 6a39454fce..3b384d2e06 100644
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
+    if (!qtest_has_cpu(cpu)) {
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
@@ -169,6 +188,10 @@ static void test_plus_minus_subprocess(void)
 {
     char *path;
 
+    if (!qtest_has_cpu("pentium")) {
+        return;
+    }
+
     /* Rules:
      * 1)"-foo" overrides "+foo"
      * 2) "[+-]foo" overrides "foo=..."
@@ -198,6 +221,10 @@ static void test_plus_minus_subprocess(void)
 
 static void test_plus_minus(void)
 {
+    if (!qtest_has_cpu("pentium")) {
+        return;
+    }
+
     g_test_trap_subprocess("/x86/cpuid/parsing-plus-minus/subprocess", 0, 0);
     g_test_trap_assert_passed();
     g_test_trap_assert_stderr("*Ambiguous CPU model string. "
@@ -217,99 +244,105 @@ int main(int argc, char **argv)
 
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
@@ -319,18 +352,18 @@ int main(int argc, char **argv)
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
 
@@ -341,31 +374,35 @@ int main(int argc, char **argv)
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
-    add_feature_test("x86/cpuid/features/plus",
-                     "-cpu 486,+arat",
-                     6, 0, "EAX", 2, true);
-    add_feature_test("x86/cpuid/features/minus",
-                     "-cpu pentium,-mmx",
-                     1, 0, "EDX", 23, false);
-    add_feature_test("x86/cpuid/features/on",
-                     "-cpu 486,arat=on",
-                     6, 0, "EAX", 2, true);
-    add_feature_test("x86/cpuid/features/off",
-                     "-cpu pentium,mmx=off",
-                     1, 0, "EDX", 23, false);
+    if (qtest_has_cpu("486")) {
+        add_feature_test("x86/cpuid/features/plus",
+                         "-cpu 486,+arat",
+                         6, 0, "EAX", 2, true);
+        add_feature_test("x86/cpuid/features/on",
+                         "-cpu 486,arat=on",
+                         6, 0, "EAX", 2, true);
+    }
+    if (qtest_has_cpu("pentium")) {
+        add_feature_test("x86/cpuid/features/minus",
+                         "-cpu pentium,-mmx",
+                         1, 0, "EDX", 23, false);
+        add_feature_test("x86/cpuid/features/off",
+                         "-cpu pentium,mmx=off",
+                         1, 0, "EDX", 23, false);
+    }
     add_feature_test("x86/cpuid/features/max-plus-invtsc",
                      "-cpu max,+invtsc",
                      0x80000007, 0, "EDX", 8, true);
-- 
2.42.0


