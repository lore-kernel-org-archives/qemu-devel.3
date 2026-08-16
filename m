Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA6EC5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvgJO-0000w3-N9; Sun, 16 Aug 2026 15:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgJK-0000il-0X
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:14:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgJI-0007bw-Gr
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786907660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nGXAhfBpLxpleHXUaMGGydOdXD4tMcWImZiPu50J+gk=;
 b=byjqug0Q/lP8fVP6UWNhOi3IyVHlJYfPvo055an8SyH4LbZMw8KmPsp8KUzomS1o7+8pMj
 x0c2tv3w8XC6uFD6tU/1HiMlpe3d3IdrN/BCW1eg7ZbhQXRyQayUyBbqUhepvSIrN/NmEi
 9RJSkiB0cH3lfE2IkwCNRHOZGuy0xdw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-tLa2HLPdOqy0-q9g_u7_fg-1; Sun,
 16 Aug 2026 15:14:18 -0400
X-MC-Unique: tLa2HLPdOqy0-q9g_u7_fg-1
X-Mimecast-MFC-AGG-ID: tLa2HLPdOqy0-q9g_u7_fg_1786907657
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD49A19560A5; Sun, 16 Aug 2026 19:14:17 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DF0323000239; Sun, 16 Aug 2026 19:14:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Aug 2026 23:12:49 +0400
Subject: [PATCH v3 22/49] qtest: add qemu-io command to the qtest protocol
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260816-qemu-no-hmp-v3-22-e53fc35bc550@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3175;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=/t/rxFqOTqXN7lUQMFkDya5LC8FusiHAJKcEHDbrgag=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqgguyCFsBOXS0P433WoNUg1EGfxUnAFw0aANQU
 K+Yta4xjGaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoILsgAKCRDa6OEJdZac
 5fU8D/4/ONrtNJGe70f2IL1dmyGIlawG7ksQihSc1dV89lD0crnFxvOXCF6Iib3k2L5U6mh49iV
 avD45cHZUCG6/A06igncXD+gLKNFtIWbsEUyEVyspvVFJpgj/Lm1m9isqKUZkET6xplE67rWP5H
 6NgkARQxlbv3W+G7WMXEggm11Qqrr1O4GtCXjfEiV74lqnGLB0NDc9VEFPjhb44NhWEvYPcas4b
 BivNvv8/otbN7KjbT6Keo+MCLTm/zVi2tkbNJBmJGM9KzdOERJj6Bmpaa+WyQVLvw1xaRNW60vn
 g9ybohlwbUlFjC4DlAe67LiCh1BFYl3Ram+yc/wCzLa74y4NWEIjLwemmthdaL+OQryo71teXDp
 EJUNvJWpGpJ+foLWVZtQyIGSfCBMiumMUlprxcLU3T1otwFkDkYey5DWLcZzuOIavbi0+kezWgT
 XgbqxpXgMVha8Fwys3RsXLaESY0dK/x8Clqv2s/LzGmgc7kWJdkG98VyGHZD5DmmGizSUGgSTMA
 ah9YJPgyAGRT8hIkXopVCw6OOhmTc5cv7rdrgXpkLQ7BUzR6fM7I1/kI8xX9XaESlJELXdbwOmr
 HZy3jQDKS7G2qN65/HqUN+O/XAEek8yFJkXaJbZrdJaAgQVw+bd5mTKyE/Wsd4+t6JPKvTevk0B
 J8QTVovzZ7+WnBw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
index c33c799c92d1..5e7b26e49ef9 100644
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


