Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02172CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJXQ-000592-5U; Thu, 15 Oct 2026 07:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJXM-0004sn-Uk
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:22:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJXK-0004BQ-Q3
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792063334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d0V+1Yt9bM+H+erMJRFKkFIUv64UmwFBKlWbudq0rME=;
 b=gDgrkQS1uMU3t1oSNpZhk9GZ45TDEzkW+N9tjYWm9MRPqIZir1vDD/SY9HF/OH7Bsre4NZ
 5DTKndG1GvxEfJFE4ebDP1bqK9/DO/nHSCUPda9BVq1dBv6LPalP6bl4urzUqiOcvA/K2S
 AlGI6IX4EtRQ9TtwLFRJpJiPet9MSms=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-KeOFUiyfMz-5cIQtDWHduQ-1; Thu,
 15 Oct 2026 11:22:10 +0000
X-MC-Unique: KeOFUiyfMz-5cIQtDWHduQ-1
X-Mimecast-MFC-AGG-ID: KeOFUiyfMz-5cIQtDWHduQ_1792063329
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22AE91800BC6; Thu, 15 Oct 2026 11:22:09 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BEE051800257; Thu, 15 Oct 2026 11:22:05 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 20/21] qtest: add 'crash' command to generate 'authentic'
 process crashes
Date: Thu, 15 Oct 2026 12:20:43 +0100
Message-ID: <20261015112044.1999748-21-berrange@redhat.com>
In-Reply-To: <20261015112044.1999748-1-berrange@redhat.com>
References: <20261015112044.1999748-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The 'crash' command provides a mechanism to generate process crashes,
which serve to test the signal catching and handling facilities in
a more authentic manner than simply running 'raise(SIG..)' against
ourself.

Available usage is

  crash null-pointer  -> SIGSEGV on null pointer
  crash invalid-addr -> SIGSEGV on derefence invalid address
  crash mapping-not-backed -> SIGBUS on writing to map with no storage
  crash bad-alignment -> SIGBUS on unaligned data write
  crash fpe-div-zero -> SIGFPE on floating point divide by zero
  crash assert -> SIGABRT on assertion failure
  crash illegal-inst -> SIGILL on illegal instruction

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 system/qtest.c         | 50 ++++++++++++++++++++++++++++++++++++++++++
 tests/qtest/libqtest.c | 26 ++++++++++++++++++++++
 tests/qtest/libqtest.h | 16 ++++++++++++++
 3 files changed, 92 insertions(+)

diff --git a/system/qtest.c b/system/qtest.c
index 47c954838dd..0ff04cf24e8 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -811,6 +811,56 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
         qtest_sendf(chr, err ? "FAIL %s\n" : "OK\n",
                     err ? error_get_pretty(err) : NULL);
         error_free(err);
+    } else if (strcmp(words[0], "crash") == 0) {
+        if (strcmp(words[1], "null-pointer") == 0) {
+            char *c = (void *)0x0;
+            *c = 'a'; /* SIGSEGV */
+        } else if (strcmp(words[1], "invalid-addr") == 0) {
+            /* Hopefully invalid addr on all supported targets */
+            char *c = (void *)0x12345;
+            *c = 'b'; /* SIGSEGV */
+#ifndef WIN32
+        } else if (strcmp(words[1], "mapping-not-backed") == 0) {
+            char *m;
+            g_autofree char *tmpname = NULL;
+            int tmpfd = g_file_open_tmp("qtestcrash-XXXXXX", &tmpname, NULL);
+            m = (char *)mmap(0, 4, PROT_WRITE, MAP_PRIVATE, tmpfd, 0);
+            unlink(tmpname);
+            assert(m != MAP_FAILED);
+            /*
+             * Since no writes have been made to 'tmpfd', the backing
+             * store is still zero-length, and thus writes should
+             * trigger a bus error
+             */
+            m[0] = 0; /* SIGBUS */
+#if defined(__x86_64__) || defined(__aarch64__)
+        } else if (strcmp(words[1], "bad-alignment") == 0) {
+            /*
+             * XXX: can we assume any other arches will generate
+             * bus errors on unaligned writes ?
+             */
+            char *cptr = g_malloc(sizeof(int) + 1) + 1;
+            int *iptr = (int *)cptr;
+#ifdef __x86_64__
+            /* Turn on alignment checks */
+            __asm__("pushf\norl $0x40000,(%rsp)\npopf");
+#endif
+            *iptr = 42; /* SIGBUS */
+#endif
+#endif
+        } else if (strcmp(words[1], "fpe-div-zero") == 0) {
+            volatile int foo = 1729; /* volatile to stop optimizing */
+            volatile int bar = 0; /* volatile to stop optimizing */
+
+            foo = foo / bar; /* SIGFPE */
+            (void)foo;
+        } else if (strcmp(words[1], "assert") == 0) {
+            assert(1 == 2); /* SIGABRT */
+        } else if (strcmp(words[1], "illegal-inst") == 0) {
+            __builtin_trap(); /* SIGILL */
+        } else {
+            qtest_sendf(chr, "FAIL unsupported crash action '%s'", words[1]);
+        }
     } else if (process_command_cb && process_command_cb(chr, words)) {
         /* Command got consumed by the callback handler */
     } else {
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index e65451171e4..d6ca97b1c11 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -828,6 +828,32 @@ static int qtest_query_target_endianness(QTestState *s)
     return big_endian;
 }
 
+static const char *crashtypestr[] = {
+    "null-pointer",
+    "invalid-addr",
+    "mapping-not-backed",
+#if defined(__x86_64__) || defined(__aarch64__)
+    "bad-alignment",
+#endif
+    "fpe-div-zero",
+    "assert",
+    "illegal-inst",
+};
+G_STATIC_ASSERT(G_N_ELEMENTS(crashtypestr) == QTEST_CRASH__MAX);
+
+void qtest_crash(QTestState *s, QTestCrashType type)
+{
+    char buf[1024];
+    ssize_t len;
+    assert(type < QTEST_CRASH__MAX);
+    qtest_sendf(s, "crash %s\n", crashtypestr[type]);
+    len = recv(s->fd, buf, sizeof(buf), 0);
+    if (len != 0) {
+        g_printerr("Expected crash from QEMU but saw qtest reply");
+        abort();
+    }
+}
+
 QDict *qtest_qmp_receive(QTestState *s)
 {
     while (true) {
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index ddcf075e33a..4988e627592 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -1232,4 +1232,20 @@ bool mkimg(const char *file, const char *fmt, unsigned size_mb);
  */
 bool qtest_verbose(const char *domain);
 
+typedef enum {
+    QTEST_CRASH_NULL_POINTER,
+    QTEST_CRASH_INVALID_ADDR,
+    QTEST_CRASH_MAPPING_NOT_BACKED,
+#if defined(__x86_64__) || defined(__aarch64__)
+    QTEST_CRASH_BAD_ALIGNMENT,
+#endif
+    QTEST_CRASH_FPE_DIV_ZERO,
+    QTEST_CRASH_ASSERT,
+    QTEST_CRASH_ILLEGAL_INST,
+
+    QTEST_CRASH__MAX,
+} QTestCrashType;
+
+void qtest_crash(QTestState *s, QTestCrashType type);
+
 #endif
-- 
2.56.0


