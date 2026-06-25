Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD6ACDE012
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrWA-00045g-HB; Thu, 25 Jun 2026 17:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrW5-0003nK-13
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:21:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrW2-0003qF-TP
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BlhHofObbsVrLDShPeZ5nrE9X0iBsYpUrMq1zqJFAxQ=;
 b=WUEovOcSRs9JhYSevSuPiviPvH0vRIVAQ9fr3+1CfsLz1qupR0SxhPSKhQV4k6KCdQTOkq
 DYhtlp2SBIOw/DJHkHd/VmGrSKN2f3KKKgY3Sf/rDxKYcdo1P7o0L09YqZxCpqD4l/CfYU
 0r0M8ojkcSQyMF+rAg4XpXd0KBW3O5g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-yCMG_NqqNyGshK49U0ar-Q-1; Thu,
 25 Jun 2026 17:21:39 -0400
X-MC-Unique: yCMG_NqqNyGshK49U0ar-Q-1
X-Mimecast-MFC-AGG-ID: yCMG_NqqNyGshK49U0ar-Q_1782422498
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F9C71873123; Thu, 25 Jun 2026 21:21:38 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 69C1E195608D; Thu, 25 Jun 2026 21:21:37 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:24 +0400
Subject: [PATCH v2 23/39] RFC: qtest: add qemu-io command to the qtest protocol
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-qemu-no-hmp-v2-23-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3151;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=TSJRJJyhZSVJid/Syo1kRYTzV1+HRdBIZSliK3y36Is=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZtdrwi//1HCvjWTpz2Hys7SWDgf8QvOpR65e
 IrCwXUrasSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXQAKCRDa6OEJdZac
 5UhiD/0e3lThNdsrz/8jNt+7MgA7YghEfdh3/Xgzfa6xCyMJxHBZM8PPgEkaoMcNKVQGEdBx69A
 mx4/RZQPlS87I0KZtT133i8VDilCqlW+8f0qUYdHZ/ZYsUX2m68XQZ6qT9/XZ9lBrToqJFAp9Xa
 73jdZak0qcz/NJhBU6gxC9gxywlXwHJ5WsUdzp1ool+ajMTIvzfefz0e9DRCzOna9gCdZPA8nbU
 EIfa6dql1zY0kAhs8klOnvyQigzG9dEA/pCbTAZDaKSLcCfozkm1lIFUF1epj2eiuseAxrQ4flD
 ZRqlYy7kI69fkZG8cIg/gJkZwZXhhB94y9orp75G5T/A8ZotEfukBnQf7DQpwS82mttKr+hJxCb
 lEiUgD1SPDKe2MKhBLgnycZAhs5eHl4uAnxW5Ar10boPJkZrPaNj8PFRxO5wQd9t1yHZM7o9NLl
 kT/A+w5opXAIDLs2J5tIk5af0iH4BEITUsAaPXQfRBfiXX+/oCuyV283+ny4iigglsWJxToUNzO
 50imkDf6WCXB+lUY+dFtBZNM9Hhmdf7SIMK0jSIoakXXESrOZW87ACAs7DSXKb/kuDndND5M9OU
 7e94qsStE41PDuyeaflX3VLDAn0PEI9R7enhsYnbXjNWpPbFNk2TKk78oOsT5RwBShHsMgaMyWY
 zTn6ke5F7/Ckkkg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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

Add a "qemu-io" command to the qtest protocol so that tests can issue
block layer I/O commands without going through the HMP monitor's
"human-monitor-command" QMP, or use QMP at all.

Unfortunately, many tests will prefer to use QMP as they also monitor
and log other events. It's easier if it is pipelined in the same stream.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/libqtest.h | 11 +++++++++++
 system/qtest.c         | 14 ++++++++++++++
 tests/qtest/libqtest.c | 14 ++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 45217fb8dc0..58491ca53ab 100644
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
diff --git a/system/qtest.c b/system/qtest.c
index fd37bcbfaab..f7f2636854b 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -33,6 +33,7 @@
 #include "qom/object_interfaces.h"
 #include "qom/qom-qobject.h"
 #include "qobject/qobject.h"
+#include "qapi-commands-block.h"
 
 #define MAX_IRQ 256
 
@@ -800,6 +801,19 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
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
index 4e22c66b754..eccffd3a0c2 100644
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

-- 
2.54.0


