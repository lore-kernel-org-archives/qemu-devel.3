Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D618CCDE00E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrWp-0007Ax-6E; Thu, 25 Jun 2026 17:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrWn-000799-Lq
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:22:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrWl-00042K-UA
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mcrkkX6WwcNtQ4IJrOAOYrtGoT3tnz6PRliTLLQAtiE=;
 b=gB0bOPtWAm7TSOquZN62MUJN7bH2BPAKaWnDPzePQj5DkwOUzdLS8OPzH2mPvfYhLxVO28
 KsjZgCp3sQgemWFh0R/5F5QNZefIDAxBHvx8voZ/Ey/XKfGJ73Fu+1f2Hnp3ywP24rCwh1
 yqx3i1+ZBlAmflchKQ6eXok1vHO2TMM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-SqBBdP_zPEu4Je4TJNZ7ng-1; Thu,
 25 Jun 2026 17:22:26 -0400
X-MC-Unique: SqBBdP_zPEu4Je4TJNZ7ng-1
X-Mimecast-MFC-AGG-ID: SqBBdP_zPEu4Je4TJNZ7ng_1782422545
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F7281873C06; Thu, 25 Jun 2026 21:22:25 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE86E1956047; Thu, 25 Jun 2026 21:22:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:33 +0400
Subject: [PATCH v2 32/39] qapi: make HMP-specific schema entries
 conditional on CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-qemu-no-hmp-v2-32-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2860;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=c9jaqfUW6JVD++uSYBGlWL79xz3IWpsoXpJJfFxlqpw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZte4sIDzfvo0CRJawdmgvOuwjlqqpbofhFnb
 oB8PH3Z2MOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXgAKCRDa6OEJdZac
 5f++EACxcyePBX6gPl29FYjqMvwtFPsLwl3irWsg4/kbgTHm61fupkra0UF3Iv95fY9o/S23CCR
 Mxc36QM4pw3oNd0yNZgJTUZnnc2CJG+EH28gad2vh3CbRaqJBGI1XGYox82ncUGVocLzVUygusF
 130QwCCGNCOycsDHB9jY6AdD3rZ/aaUbW/TGLRMoQbZ41WQkXhtLXGNxBfdAGjah9GPeF/AaJrA
 Gl34vEJyNlyXyrUUopsdnS5k29jlU2PSISJyNW3KKUgRKXAKOWuf+4YwYX74Y3AEzVyze+jhfGI
 OP63XGNe8JTOjDGIrfSFsZqQh67OCs4nqa75yEBMFhzkACchcyo4u3QEGkFcGCtO90S8hxX7J4C
 hLNEncXyG0QV8gsSCNDIonGVH9EYvinUx4j4BiRcwfw2Yu61Rhalc2wy6Cm5nJte3kif7Mdz1dT
 DMTvsvU5UN1W4AAWm8EcJNPxDjw5ZDg9UVoxEjqhZGlBeNiP00RsG3Oplps6ei0kT73QIccyw40
 2mV+6wx09N+iI9XNzCXHNStNh4jEQys1FO212YW4OGBFjwbY75Zb9h5gENAHkLCG0Z5jk5m1tWl
 oks6+oUy4/k4+sk3+J9IJEqJaz/OU4VoXOKy0qmjbAAzWg0EDlZ+rbCkLauggKhkMcAAxN0CTEl
 XqpzKrK4DUelbqg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Make the 'readline' value of MonitorMode and the
'human-monitor-command' command conditional on CONFIG_HMP, so
they are only available when HMP support is compiled in.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qapi/control.json  | 4 +++-
 qapi/misc.json     | 3 ++-
 monitor/monitor.c  | 8 +++++++-
 monitor/qmp-cmds.c | 2 ++
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/qapi/control.json b/qapi/control.json
index 9a5302193d6..9898552814b 100644
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
index 22b7afed9f6..a21ba61b96e 100644
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
diff --git a/monitor/monitor.c b/monitor/monitor.c
index f443f406b4c..50f1fe77c33 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -733,13 +733,18 @@ int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
     }
 
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
         monitor_init_qmp(chr, opts->pretty, errp);
         break;
+#ifdef CONFIG_HMP
     case MONITOR_MODE_READLINE:
         if (!allow_hmp) {
             error_setg(errp, "Only QMP is supported");
@@ -751,6 +756,7 @@ int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
         }
         monitor_init_hmp(chr, true, errp);
         break;
+#endif /* CONFIG_HMP */
     default:
         g_assert_not_reached();
     }
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 0c409c27dc3..5e642a2b14d 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -162,6 +162,7 @@ void qmp_add_client(const char *protocol, const char *fdname,
     }
 }
 
+#ifdef CONFIG_HMP
 char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
                                 int64_t cpu_index, Error **errp)
 {
@@ -189,6 +190,7 @@ out:
     monitor_data_destroy(&hmp.common);
     return output;
 }
+#endif /* CONFIG_HMP */
 
 static void __attribute__((__constructor__)) monitor_init_qmp_commands(void)
 {

-- 
2.54.0


