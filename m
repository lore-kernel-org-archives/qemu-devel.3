Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0DCC61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywZq-0003RY-Hy; Tue, 25 Aug 2026 15:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywZm-000360-Sw
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:12:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywZg-0004T0-6b
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787685163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TTn5AAb/qW3hra4wCQGpwQBFN1XcyzK6Ftmm43uRe+Y=;
 b=T+D0DEbTKr4rdEA0ggPwZi6MgLGjmY3rTVsenLLrT5o9sMPQ88EOubYp11eK7iM4tPxbLP
 LzyRgQxj5SrjMUlzrS9CR12V9rht0rnc8bQIU/9gDLubyb5U3TTOoOofnxoD4cP0DJXCdl
 jPMek5PSfZxm71bI7lNpN+ne1keO9rU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-5IsedT4WPF61GbN4-jyU4w-1; Tue,
 25 Aug 2026 15:12:38 -0400
X-MC-Unique: 5IsedT4WPF61GbN4-jyU4w-1
X-Mimecast-MFC-AGG-ID: 5IsedT4WPF61GbN4-jyU4w_1787685156
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DADC190A349; Tue, 25 Aug 2026 19:12:36 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 50EE918005B4; Tue, 25 Aug 2026 19:12:34 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 23:09:46 +0400
Subject: [PATCH v4 39/49] qapi: make HMP-specific schema entries
 conditional on CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-qemu-no-hmp-v4-39-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2974;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Wa0NXaHs68Z5F8WoCU+QPlrnfaG01+49mRJLDSgZc1w=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjeiI7EJtUqGtkg6burSEt240/fFC3Y4m5pDBw
 nHzce+U6FaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao3oiAAKCRDa6OEJdZac
 5aUwEACFzLSfLgcDaCZkimYGPYqo0WThOLsRNIuN5IGqI1P39tkyWAERx9tTM4WcnwvLo6gBWeb
 bE9SoU8Zu7PS95HhVcBXXe/5LhphYMJd5TBnoc3LlYMyb9aDfvuWolrSRHavZ/H1d/6dbzM8wjy
 TTYTcrwLxN15plC7Ty/LwUlcxEa12kTJlipQDW6ZxupKjS7GW6SUFLB+JiA28ukaSxmpj6oo3U3
 MfNbgPHh+lqLeFQXwFWFZrQ0N+LYVnWrecdNWpu999LGLfWAWEw0t9KoyS7dNUkSBkYlzlYrR8z
 3lshB4Guuv+FpTRrz13hJoXxxmO/k417YwpYE0XsCDuIshbZ+o2+u0JatTKge/MoRYjCw80hMwI
 CsJu9h5MvoVNgoe4sY3RJMoAAiUxe6d2topjzjkREa7fUtyVvHym2EzUZTRI1qsSO5RQS0x9LUq
 AmPjiJLFYWDLqxQlSOfhZHjFC8Ys4YZUoQ9teO78Z8Jq3lL0hjzKSIEOUJfaXO4VvnAoGk0ybmg
 L+7WzmG8oM/8S0y2SkbqBTR53FdYU/zgNQ82qaejt+tUvPDtTjZRVE1D3+WodTM7xn4wx/hK+M3
 EjDzWYoSfEbn623aonJYzgBpKr4raiDspDifzO3+UVTXUUXiHl18NoDaK8VFJwE2eWENxw6/MqQ
 yw+NRVosj1lXywg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Make the 'readline' value of MonitorMode and the
'human-monitor-command' command conditional on CONFIG_HMP, so
they are only available when HMP support is compiled in.

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 monitor/monitor.c  | 8 +++++++-
 monitor/qmp-cmds.c | 2 ++
 qapi/control.json  | 4 +++-
 qapi/misc.json     | 3 ++-
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index da76e6e4ac19..da0c8eda86b0 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -740,13 +740,18 @@ int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
     ERRP_GUARD();
 
     if (!opts->has_mode) {
-        opts->mode = allow_hmp ? MONITOR_MODE_READLINE : MONITOR_MODE_CONTROL;
+        opts->mode =
+#ifdef CONFIG_HMP
+            allow_hmp ? MONITOR_MODE_READLINE :
+#endif
+            MONITOR_MODE_CONTROL;
     }
 
     switch (opts->mode) {
     case MONITOR_MODE_CONTROL:
         monitor_new_qmp(opts->id, opts->chardev, opts->pretty, errp);
         break;
+#ifdef CONFIG_HMP
     case MONITOR_MODE_READLINE:
         if (!allow_hmp) {
             error_setg(errp, "Only QMP is supported");
@@ -758,6 +763,7 @@ int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
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


