Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CECC61DD7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvNw-00079u-Ry; Fri, 28 Aug 2026 08:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvNh-0006TI-Ta
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:08:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvNe-0003mD-0C
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787918898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hKFI2tIxxsYgplKqjcXLDnd1UZLTiNWfe1wnBcLmaLk=;
 b=AKmTAtvnnN1tIcqCMNItlDPYMu6CEErNv6G2saa/JdkLRtGAsOSaYYwjXyUuVSbD6Ypr3s
 jsU5HHMkavDcGnJzGMKCzzaSz7tHZsAQ5FxH28XbcFzz6j656P9vgle048g9vnHv4GhZ1+
 iyjQSiXZ97Fd+Y7Kf80BUDJdr2wwAXk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-tshgoV4mNPu379tK3bveaA-1; Fri,
 28 Aug 2026 08:08:15 -0400
X-MC-Unique: tshgoV4mNPu379tK3bveaA-1
X-Mimecast-MFC-AGG-ID: tshgoV4mNPu379tK3bveaA_1787918894
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B2B618052FB; Fri, 28 Aug 2026 12:08:14 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AF2551955F05; Fri, 28 Aug 2026 12:08:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Aug 2026 16:04:37 +0400
Subject: [PATCH v5 40/50] qapi: make HMP-specific schema entries
 conditional on CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-qemu-no-hmp-v5-40-9227de146347@redhat.com>
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3061;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=914xIWJbf4+U2665ios2T80rsbx95+88cdXXMS2L0PU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkXk5m9A+nYFBJFQQSn099DDqpqVqTdXjWaxXL
 Rx6keSUvhuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapF5OQAKCRDa6OEJdZac
 5ecHD/9q5KEbbs1Yg2QdJY6zMYAXBuWtwG9CIYXnXfPqxAPAFg5YCveR+4w9NSs1vg5Zizt6erX
 mYEPsMsyq4Ej+cEdzXTJzUas5WuMHORyMJ4GebrMjj/QZavbPhuXNhCdj6tlTgyOR+aojGSRpbP
 jif7Mz8KAV1tn44qfXLSOsUPmHuZeBwa+oix3OY+wECW+CQMxh8ZHgrM9JlV2EeGV2BwKwvNGMG
 eOUbJhPwLNNRJkV/pY2LrBCdLRtsRqMzdJ1G25/DK8CIMy/7Z9dw2MqCLPU3BFZ5jqC5cv7dvxC
 etqTXLpMAe8iN5hTjLHv9XaCjS8oXdlgZIU4smNx/cQxNO0ggFk0dYhBDuDpqLh714r6IN49OO2
 eSYzIZFqJWURVm5jlbVociiQdUjJtU81TviQPqO8j7ANzoZD+h7d8CVo2K+qag9JDjaebo1R2DC
 K3YPtYnMn+23AdG7Q5NyY4KRAgDMsI2OSwsdFCCODrzfbpGLmGhPi8gptaaYC/eDkOOSPGk/oE9
 pRHEdS9FcjuaCWXSj6ZZRETiW6933inbCGs8Yj20QD90TE9o48GWKdupBHKAuaPvlLinf1C5zUx
 774/Wl/chARcZwApSmM51v13Bh1GA7awxCKdJyA8C/2T/kztCiePE1B858AcWsFLxrbHLmgILv9
 nRYmU+8ND7sRUcw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Make the 'readline' value of MonitorMode and the
'human-monitor-command' command conditional on CONFIG_HMP, so
they are only available when HMP support is compiled in.

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 monitor/monitor.c  | 10 ++++++++++
 monitor/qmp-cmds.c |  2 ++
 qapi/control.json  |  4 +++-
 qapi/misc.json     |  3 ++-
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index da76e6e4ac19..7b22553a8731 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -740,13 +740,22 @@ int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
     ERRP_GUARD();
 
     if (!opts->has_mode) {
+#ifdef CONFIG_HMP
         opts->mode = allow_hmp ? MONITOR_MODE_READLINE : MONITOR_MODE_CONTROL;
+#else
+        if (allow_hmp) {
+            error_setg(errp, "HMP support is not built in this QEMU");
+            return -1;
+        }
+        opts->mode = MONITOR_MODE_CONTROL;
+#endif
     }
 
     switch (opts->mode) {
     case MONITOR_MODE_CONTROL:
         monitor_new_qmp(opts->id, opts->chardev, opts->pretty, errp);
         break;
+#ifdef CONFIG_HMP
     case MONITOR_MODE_READLINE:
         if (!allow_hmp) {
             error_setg(errp, "Only QMP is supported");
@@ -758,6 +767,7 @@ int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
         }
         monitor_new_hmp(opts->id, opts->chardev, true, errp);
         break;
+#endif /* CONFIG_HMP */
     default:
         g_assert_not_reached();
     }
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index b16119f4858c..c9f24febdc96 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -162,6 +162,7 @@ void qmp_add_client(const char *protocol, const char *fdname,
     }
 }
 
+#ifdef CONFIG_HMP
 char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
                                 int64_t cpu_index, Error **errp)
 {
@@ -187,6 +188,7 @@ out:
     object_unref(hmp);
     return output;
 }
+#endif /* CONFIG_HMP */
 
 static void __attribute__((__constructor__)) monitor_init_qmp_commands(void)
 {
diff --git a/qapi/control.json b/qapi/control.json
index 9a5302193d67..9898552814b1 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -186,7 +186,9 @@
 #
 # Since: 5.0
 ##
-{ 'enum': 'MonitorMode', 'data': [ 'readline', 'control' ] }
+{ 'enum': 'MonitorMode', 'data': [
+    { 'name': 'readline', 'if': 'CONFIG_HMP' },
+    'control' ] }
 
 ##
 # @MonitorOptions:
diff --git a/qapi/misc.json b/qapi/misc.json
index 22b7afed9f65..a21ba61b96e0 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -247,7 +247,8 @@
 { 'command': 'human-monitor-command',
   'data': {'command-line': 'str', '*cpu-index': 'int'},
   'returns': 'str',
-  'features': [ 'savevm-monitor-nodes' ] }
+  'features': [ 'savevm-monitor-nodes' ],
+  'if': 'CONFIG_HMP' }
 
 ##
 # @getfd:

-- 
2.55.0.543.g5ebe2ebe4ea8


