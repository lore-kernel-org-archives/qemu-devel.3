Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F41CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJXM-0004po-5z; Thu, 15 Oct 2026 07:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJXJ-0004gr-2q
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:22:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJXH-0004B4-8S
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792063329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1CsPZct2byPKvJCqqrPOQ9z+NngHcWHt2CGXzjTTRak=;
 b=Ortkahk+lV4eo8mHQoYeeWJesR0j3Zm1XmC+ymR5l9K+Zc6xfLP6CTduAM8I+W2QpfmmzR
 6NYOwbOZOGHWXTBmJ/SupncX16dQx7Nb4qTLMrobXxhzLOioozCu6Z/GtnDBIkOQFO/3yL
 IcMIzM1NKN4w5nB3f6Dq+57ZXCf4ASA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-qH5gjgKzMQCzzrzuC_n6Ag-1; Thu,
 15 Oct 2026 11:22:06 +0000
X-MC-Unique: qH5gjgKzMQCzzrzuC_n6Ag-1
X-Mimecast-MFC-AGG-ID: qH5gjgKzMQCzzrzuC_n6Ag_1792063325
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 592F61800667; Thu, 15 Oct 2026 11:22:05 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 099D11800677; Thu, 15 Oct 2026 11:22:01 +0000 (UTC)
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
Subject: [PATCH 19/21] tests/qtest: add API to declare an expected crash signal
Date: Thu, 15 Oct 2026 12:20:42 +0100
Message-ID: <20261015112044.1999748-20-berrange@redhat.com>
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

Most qtests are validating positive behaviour, but some might
wish to validate that QEMU crashes. Add an API for libqtest
that allows declaring an expected crash signal.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qtest/libqtest.c | 36 +++++++++++++++++++++++++++---------
 tests/qtest/libqtest.h | 11 +++++++++++
 2 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 05d88476154..e65451171e4 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -86,6 +86,9 @@ struct QTestState
     DWORD exit_code;
 #endif
     int expected_status;
+#ifndef _WIN32
+    int expected_signal;
+#endif
     bool big_endian;
     bool irq_level[MAX_IRQ];
     GString *rx;
@@ -185,6 +188,13 @@ void qtest_set_expected_status(QTestState *s, int status)
     s->expected_status = status;
 }
 
+#ifndef _WIN32
+void qtest_set_expected_signal(QTestState *s, int signal)
+{
+    s->expected_signal = signal;
+}
+#endif
+
 static void qtest_check_status(QTestState *s)
 {
     assert(s->qemu_pid == -1);
@@ -195,20 +205,28 @@ static void qtest_check_status(QTestState *s)
      */
 #ifndef _WIN32
     int wstatus = s->wstatus;
-    if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) != s->expected_status) {
-        fprintf(stderr, "%s:%d: kill_qemu() tried to terminate QEMU "
-                "process but encountered exit status %d (expected %d)\n",
-                __FILE__, __LINE__, WEXITSTATUS(wstatus), s->expected_status);
-        abort();
+    if (WIFEXITED(wstatus)) {
+        if (s->expected_signal) {
+            fprintf(stderr, "%s:%d: encountered exit status %d but expected signal %d\n",
+                    __FILE__, __LINE__, WEXITSTATUS(wstatus), s->expected_signal);
+            abort();
+        } else if (WEXITSTATUS(wstatus) != s->expected_status) {
+            fprintf(stderr, "%s:%d: kill_qemu() tried to terminate QEMU "
+                    "process but encountered exit status %d (expected %d)\n",
+                    __FILE__, __LINE__, WEXITSTATUS(wstatus), s->expected_status);
+            abort();
+        }
     } else if (WIFSIGNALED(wstatus)) {
         int sig = WTERMSIG(wstatus);
         const char *signame = strsignal(sig) ?: "unknown ???";
         const char *dump = WCOREDUMP(wstatus) ? " (core dumped)" : "";
 
-        fprintf(stderr, "%s:%d: kill_qemu() detected QEMU death "
-                "from signal %d (%s)%s\n",
-                __FILE__, __LINE__, sig, signame, dump);
-        abort();
+        if (sig != s->expected_signal) {
+            fprintf(stderr, "%s:%d: kill_qemu() detected QEMU death "
+                    "from signal %d (%s)%s\n",
+                    __FILE__, __LINE__, sig, signame, dump);
+            abort();
+        }
     }
 #else
     if (s->exit_code != s->expected_status) {
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 20982d3fe8d..ddcf075e33a 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -1155,6 +1155,17 @@ bool qtest_probe_child(QTestState *s);
  */
 void qtest_set_expected_status(QTestState *s, int status);
 
+#ifndef _WIN32
+/**
+ * qtest_set_expected_signal:
+ * @s: QTestState instance to operate on.
+ * @signal: an expected crash signal.
+ *
+ * Set expected crash signal of the child.
+ */
+void qtest_set_expected_signal(QTestState *s, int signal);
+#endif
+
 QTestState *qtest_inproc_init(QTestState **s, bool log, const char* arch,
                     void (*send)(void*, const char*));
 
-- 
2.56.0


