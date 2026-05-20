Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E050CD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoq0-0005iF-ME; Wed, 20 May 2026 17:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPopy-0005Z6-Gt
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:52:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPops-0004l8-TO
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779313936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZP/vlaSsKakh9nwYd/UnexPrmYFT0jPzQuj7CDSztJo=;
 b=BUfYEyGdzHd3soYoJaO/DBydP37DKPnpWrjEotxMkMGBF7DqYWRMoCKuLqRulIgEkz3A3t
 fSM3xj7zRhe131UmyRMHYWv19MRQCymYuuPi3LCg0hLlv/uWLKCw7qOzEkBvlMDTBv3OSg
 1tMLWLpNiFR4SeeEejnsdrTgK+fCR1k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-0COpcffgPla6CBI2mSuDqQ-1; Wed,
 20 May 2026 17:52:14 -0400
X-MC-Unique: 0COpcffgPla6CBI2mSuDqQ-1
X-Mimecast-MFC-AGG-ID: 0COpcffgPla6CBI2mSuDqQ_1779313933
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B83681956096
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:52:13 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4BC701956053; Wed, 20 May 2026 21:52:11 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:22 +0400
Subject: [PATCH 21/40] RFC: qtest: add qemu-io command to the qtest
 protocol
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-21-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3233;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=TH0GcsZ6il8ZtxeGOOCNWywd3aQP6tbV17VNL87VHmU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyDPx4MQ0JYMxfPegsc7obhdCAitiH1IvjrU
 Txl3C1HVQiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4sgwAKCRDa6OEJdZac
 5XjMEACoorUxYQ886N2UeqmM7GhvNNCfR8nZSiIfPCwUPSEC/BqBvzmvikcrNVKTcabU4yvuG8W
 HKDMdAPRlRTWOcYZ/lTh36N4naCVosrLQW6qvK9J/wrJL9ja1y6zlubSBmqOaIFAUR1ogPkPaQl
 l6keAPq+fyXbVKQp1edicHKPBUBHO3YCRMSYfzwTmBoU9M7FMaXvx4fR9POkBy8eVapVcTeydOV
 Ci4sPQOlD6rXPB+2H7QxTSOTYx9Xh4MZA0I//vXzHvZa0xcP+uTZereuGT5dyaSz5OS7WXt/xv2
 FrOhJbJ1mLbkDK59p+aWyT7vj/LJzptxm/3eQYeDFZ+Yq64IxySa6JJdESZW1cDbrW2e+RkCcfo
 JX3n0eMiOeVtTjZJa7jLxu1ZwK+00aE9TXZqlTXn7Cs1kSw7BrahltNivVFTXKZJ8F5mnAFXPxM
 LLOPap+qx+GjdlQiRDLvfy2su8FknnVD1Rbyc6xm+6/crLP3nx3zviQ3g76FcRtHenZDjRc3ZeV
 WrYJJAX1Q684QtEYaf0hOrpCU1ist4RUROUsMhL634Hy+9JC1e1uYWf50lgg7vYtktPbFXOW4Gg
 miesFALG5HCHEV6tslmLfWoNzK5N2PxJtnY+by5GXzDIvAYpr9JzSEotJPOzR5r86/JApJ6aLIj
 fv4Vg89EG3bPDXQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
index 950ea2baafa..647a8a095a1 100644
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
index 1fb35ae36bc..1b7a7b6b8b8 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -31,6 +31,7 @@
 #include "qemu/cutils.h"
 #include "qemu/target-info.h"
 #include "qom/object_interfaces.h"
+#include "qapi-commands-block.h"
 
 #define MAX_IRQ 256
 
@@ -763,6 +764,19 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
         new_ns = qemu_clock_advance_virtual_time(ns);
         qtest_sendf(chr, "%s %"PRIi64"\n",
                     new_ns == ns ? "OK" : "FAIL", new_ns);
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
index b1e06ea364e..363fc3028d3 100644
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


