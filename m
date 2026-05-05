Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBA1CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 12:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKEzf-0002mz-S5; Tue, 05 May 2026 08:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKEza-0002gE-JU
 for qemu-devel@nongnu.org; Tue, 05 May 2026 08:35:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKEzX-0006xL-KV
 for qemu-devel@nongnu.org; Tue, 05 May 2026 08:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777984508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZJPaQGKTFYtCjJTMw017bT/rDK8tm7G0cZL44q3ASsY=;
 b=dnNf+0/LtUdRzWHQezirMG+wDR/YqwfThJxcKQ+bLI/2Sqt9sFxxOPc2SyD8z5UHkdm2mz
 XScmy8ZAKVMhqbAbSBJ+h7dLzrmgsaGbK40obCKS//6YqckiBRRsygSzXXTIRQP098drbz
 FkzIqu9IOE+BrkPvyzick9hJNK/7qT0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-OMQO-5D2ON6t_Rad8LFEEQ-1; Tue,
 05 May 2026 08:35:06 -0400
X-MC-Unique: OMQO-5D2ON6t_Rad8LFEEQ-1
X-Mimecast-MFC-AGG-ID: OMQO-5D2ON6t_Rad8LFEEQ_1777984505
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 551E319560A1; Tue,  5 May 2026 12:35:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D37AA1800480; Tue,  5 May 2026 12:35:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7830221E6A07; Tue, 05 May 2026 14:35:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, "AlanoSong@163.com" <AlanoSong@163.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PULL 4/4] monitor: Add `clear` command
Date: Tue,  5 May 2026 14:35:02 +0200
Message-ID: <20260505123502.1316554-5-armbru@redhat.com>
In-Reply-To: <20260505123502.1316554-1-armbru@redhat.com>
References: <20260505123502.1316554-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: "AlanoSong@163.com" <AlanoSong@163.com>

The monitor screen can be cluttered after executing commands
like `info qtree`. It is useful to have a command to clear
current screen, just like linux `clear` command do.

This patch has been tested under monitors using stdio, vc,
tcp socket, unix socket and serial interfaces.

Signed-off-by: Alano Song <AlanoSong@163.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
Message-ID: <20260504174914.122607-5-dave@treblig.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/monitor/hmp.h |  1 +
 monitor/hmp-cmds.c    | 11 +++++++++++
 hmp-commands.hx       | 14 ++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index e222bea60c..9b66458d21 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -165,6 +165,7 @@ void hmp_trace_event(Monitor *mon, const QDict *qdict);
 void hmp_trace_file(Monitor *mon, const QDict *qdict);
 void hmp_info_trace_events(Monitor *mon, const QDict *qdict);
 void hmp_help(Monitor *mon, const QDict *qdict);
+void hmp_clear(Monitor *mon, const QDict *qdict);
 void hmp_info_help(Monitor *mon, const QDict *qdict);
 void hmp_info_sync_profile(Monitor *mon, const QDict *qdict);
 void hmp_info_history(Monitor *mon, const QDict *qdict);
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index afa7b709a6..1b44d07c18 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -219,6 +219,17 @@ void hmp_help(Monitor *mon, const QDict *qdict)
     hmp_help_cmd(mon, qdict_get_try_str(qdict, "name"));
 }
 
+void hmp_clear(Monitor *mon, const QDict *qdict)
+{
+    /*
+     * Send an ANSI escape sequence:
+     * "\x1b[H" - move cursor to top-left
+     * "\x1b[2J" - clear visible screen
+     * "\x1b[3J" - clear scrollback
+     */
+    monitor_printf(mon, "\x1b[H\x1b[2J\x1b[3J");
+}
+
 void hmp_info_help(Monitor *mon, const QDict *qdict)
 {
     hmp_help_cmd(mon, "info");
diff --git a/hmp-commands.hx b/hmp-commands.hx
index f4a6eeda93..b806ec5635 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -20,6 +20,20 @@ SRST
   Show the help for all commands or just for command *cmd*.
 ERST
 
+    {
+        .name       = "clear",
+        .args_type  = "",
+        .params     = "",
+        .help       = "clear the monitor screen",
+        .cmd        = hmp_clear,
+        .flags      = "p",
+    },
+
+SRST
+``clear``
+  Clear the monitor screen.
+ERST
+
     {
         .name       = "commit",
         .args_type  = "device:B",
-- 
2.54.0


