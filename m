Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195F3C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywYo-0006YO-5Y; Tue, 25 Aug 2026 15:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywYX-0005md-M4
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:11:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywYV-00047v-6S
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787685090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O8ztPa+PkYAyQ0jCSv+qksyiWwozekukERdSihks8GE=;
 b=A/bWcb1wU0t27+mpPmq7/4QkdUc0VzhTj7xZKkT+p49iExSrtXjlUlvuiX1pmgGTBwZVK1
 5qOX9S3GPvmsBIMwkDqO+mK3XmDTiqN6qJOhwoI/48AIe0FT1vuvU8voRMOpMYTcs42QML
 4JjgbCgMKOWDSG77rAFU2RwHeYP2IJQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-rC3Qroc4O3uoAF8X_sRudg-1; Tue,
 25 Aug 2026 15:11:27 -0400
X-MC-Unique: rC3Qroc4O3uoAF8X_sRudg-1
X-Mimecast-MFC-AGG-ID: rC3Qroc4O3uoAF8X_sRudg_1787685086
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E984188FECE; Tue, 25 Aug 2026 19:11:26 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E72C30002F7; Tue, 25 Aug 2026 19:11:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 23:09:29 +0400
Subject: [PATCH v4 22/49] qtest: add qemu-io command to the qtest protocol
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-qemu-no-hmp-v4-22-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3175;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=A3jHZBymfOBXqq7imKzSxgBHpql06Irvffs0d0YLLNQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjeiHQ6+WcNdZ/Jfw1K+2h9oiXg0CjEsKkk1Dn
 kh9EzNOGriJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao3ohwAKCRDa6OEJdZac
 5Sa4EAC0Drfwf1OmatHzWW2aE/hK1f3sRIyE/vr0hmG5DaDrUDEBCU5GAtYxPyuFl/dd+0GsTB5
 fBcMAwUcyDeZsBkqMFJ4LUxRDN5FxSOKHm1mBgwz34Sf78MmgMj3xRZm0ExShpaOMtZgZKDlIIl
 U1vb28uLAPUuJ5r4Yvo/jWYTzVsRjSXP9GHQKR29SNZKw/wVHyI5kSM+zk22d7OE/HKUltIIKX1
 /CkAKVLNh9KqlOuTlLaikMzY8eH9lTOSlaku22rv9bKeC2M1nn3SklgTApvXUEpCmaw50o9R0nX
 kStvLwAWpjJQZ0qsYQL2lQoi+vgfeRshDkaeYNHcE3Iphh4pHvofWVXUpprNuu9fBBXo+WREvkd
 g7AEUYlbGUw3mkej7H/6oQRCqTvjmfMC5zJjaZRghNXwC6IwRfoPMuhpiSpk5eTAwfP7UZ5ZJlg
 pYSAlPhOjFD0MqkUy7RJ7sy/W+1U3j0sHSasky5kJgs1riafLz/whZWM9MbapYUsuGKpNSc8NLT
 pg3UfpCim5kCvCbI+ZsT4BgsayMHRymq4T0Lt00itxspSs/lTlNNrxVb78YLZyFAIRNp3V3p0wa
 uSR8M+xbp+UxVT6n8A6YgBDfxdJPEu+kPI+5TmiqHOXJbidfDxaEv/p/mpgkZXVql1PGydZjVvq
 +cU9guc8/GZr3pQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a "qemu-io" command to the qtest protocol so that tests can issue
block layer I/O commands without going through the HMP monitor's
"human-monitor-command" QMP, or use QMP at all.

Unfortunately, many tests will prefer to use QMP as they also monitor
and log other events. It's easier if it is pipelined in the same stream.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/qtest.c         | 14 ++++++++++++++
 tests/qtest/libqtest.c | 14 ++++++++++++++
 tests/qtest/libqtest.h | 11 +++++++++++
 3 files changed, 39 insertions(+)

diff --git a/system/qtest.c b/system/qtest.c
index cf3012391774..47c954838dd0 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -33,6 +33,7 @@
 #include "qom/object_interfaces.h"
 #include "qom/qom-qobject.h"
 #include "qobject/qobject.h"
+#include "qapi-commands-block.h"
 
 #define MAX_IRQ 256
 
@@ -797,6 +798,19 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
         }
         g_slist_free(list);
         qtest_send(chr, "OK\n");
+    } else if (strcmp(words[0], "qemu-io") == 0) {
+        const char *io_dev;
+        g_autofree char *io_cmd = NULL;
+        Error *err = NULL;
+
+        g_assert(words[1] && words[2]);
+        io_dev = words[1];
+        io_cmd = g_strjoinv(" ", &words[2]);
+
+        qmp_x_qemu_io(io_dev, NULL, io_cmd, &err);
+        qtest_sendf(chr, err ? "FAIL %s\n" : "OK\n",
+                    err ? error_get_pretty(err) : NULL);
+        error_free(err);
     } else if (process_command_cb && process_command_cb(chr, words)) {
         /* Command got consumed by the callback handler */
     } else {
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index bec37c71b8c1..28bb72bfaecf 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1012,6 +1012,20 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...)
     return ret;
 }
 
+void qtest_qemu_io(QTestState *s, const char *device,
+                   const char *fmt, ...)
+{
+    va_list ap;
+    g_autofree char *cmd = NULL;
+
+    va_start(ap, fmt);
+    cmd = g_strdup_vprintf(fmt, ap);
+    va_end(ap);
+
+    qtest_sendf(s, "qemu-io %s %s\n", device, cmd);
+    qtest_rsp(s);
+}
+
 const char *qtest_get_arch(void)
 {
     /*
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 45217fb8dc09..58491ca53ab7 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -424,6 +424,17 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
 char *qtest_vhmp(QTestState *s, const char *fmt, va_list ap)
     G_GNUC_PRINTF(2, 0);
 
+/**
+ * qtest_qemu_io:
+ * @s: #QTestState instance to operate on.
+ * @device: block device node-name or BlockBackend name.
+ * @fmt: qemu-io command to send, formats arguments like sprintf().
+ *
+ * Send a qemu-io command via the qtest protocol.
+ */
+void qtest_qemu_io(QTestState *s, const char *device,
+                   const char *fmt, ...) G_GNUC_PRINTF(3, 4);
+
 void qtest_module_load(QTestState *s, const char *prefix, const char *libname);
 
 /**

-- 
2.55.0.543.g5ebe2ebe4ea8


