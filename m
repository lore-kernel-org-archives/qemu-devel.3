Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42873C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03QC-00085k-Hn; Fri, 28 Aug 2026 16:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03QB-0007yh-5O
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:43:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Q9-0008WF-E9
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rU1JuobZe1INS7my5A1LrdEWPdwzd/Y214ba/NisCV8=;
 b=ieGkDiWB2IE4qnZPrhFqrHo/+bHsax+mnJw2Xtll9qHxM323M5SmI31dO15Db44HmTAxnl
 k+rbiEY3z8b/8a7lxSWQV9nSy2dRrduLHXShwL0IbgIBGam7TBorYwrNXs4ZswfMBxYKBQ
 TR8rRfj9KviabUD2wa336ym09/t94Lg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-dXqQg4BWM5-ASX4FffGbbA-1; Fri,
 28 Aug 2026 16:43:23 -0400
X-MC-Unique: dXqQg4BWM5-ASX4FffGbbA-1
X-Mimecast-MFC-AGG-ID: dXqQg4BWM5-ASX4FffGbbA_1787949802
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58B3B180AE2E; Fri, 28 Aug 2026 20:43:22 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 62F101955F43; Fri, 28 Aug 2026 20:43:21 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:42:02 +0400
Subject: [GIT PULL 23/50] qtest: add qemu-io command to the qtest protocol
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-23-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3305;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=RgvVsUcW+QcFTDrMP/ZKBkf1CzCW2rqeaLm06HOOQYo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKUiGKIosU0zUJ0Th2/REFFXterv74AnftsN
 GWo1P9go0mJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHylAAKCRDa6OEJdZac
 5VXKD/wOx5pBaKTGqvq2ytm95Ws3mDeuttkjXqgWcHftWfHioEBaMAz8CFScWban+xiw+loyZ+j
 fqzbxh1gkymBdXMXIklCeAjHGNImBoJyhD1I8EzCvm6hNYJciz+z7oCYRoe1fRF+XX4HjWg90Vb
 VmOSp1qj+ss/dNsvknGmRxVUl7hg4oll5GFzLcaEevpX0jX9UaBcBTtxRbBFuF/zlgiktchJIqc
 2pKKXQEGKKVWb8vFoNRmDw7R5XhiaR5EokOW1YUToomU4oV475Pwr+p3n2wH6c51BsXn2RoH9QY
 tcFRzYWWfhZ1UpmcX/nsqnVEPmIoN+5mxwJ6kA/LZWxwEQRY37ETPQix7CAdRxigL59Cp+SaGzS
 q2xZG7SqXoe8MNjL2oYsdfvP/EcFtT0DOZsDqU6VC/uHR7QIZ19xMRoxSPGj8Z8Aj63XxAG5kJ4
 izi9KKCS7lDtFAQArHrPpoTGowaUw8nodOgCB/Pu8KiIXtkovMC96mOkDW9rATf4OinxgMauaRW
 fFjip19rC5acTkM4zSA/VWZQl0b8bLmrqnnS5/F/WQFz3BkRhVbmiIZVaQzM7S+q5Vlcc+mRgu1
 8lVFi9j7g0ps2ue2vBWzz4kExWoVsD4ZyjmseNpW+8wLCnRukz4VzDIpvvZSA0ZgqEOjW1l7zlB
 ZzJ+TAwwffiG9fg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Add a "qemu-io" command to the qtest protocol so that tests can issue
block layer I/O commands without going through the HMP monitor's
"human-monitor-command" QMP, or use QMP at all.

Unfortunately, many tests will prefer to use QMP as they also monitor
and log other events. It's easier if it is pipelined in the same stream.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260828-qemu-no-hmp-v5-23-9227de146347@redhat.com>
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


