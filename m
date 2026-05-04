Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046A5CD3427
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 17:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJxQU-0004dv-Mk; Mon, 04 May 2026 13:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1wJxQR-0004da-Kw
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:49:47 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1wJxQL-0000cn-Ot
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=jAtRdMdn+1DXmNxbMaB6LO2kTltRACebDia2do/rLS8=; b=S00RuLSoAT4eMCV4
 INMpiVFSJl+1kCdHnmLSHJ2g2DmU5S33SBy0hix7rGGtYQNpRH9G3eHrn8GhPgf14u6Jc+S7VUOc9
 WHoxXdc2F0lvfCGO5YmFS/GPoPhA+GbLnmL0GinIbqz0f+tlpIFez/zcInkGPNw84NZr/+I3dXbdz
 kwNMJreIzD0McTNQZnC7RWBsbNTBvOhHcyUbqUoUdUsvcUo5khnirX5ke+XXoYLQ+HZVdVUF8sYzp
 hkf+t4TvSFO7Ls6e68JkzjpvqMJ1Jvpa64csq9+wKkD3/7GfCpXeo+0qmytKj//X+0SeDw8IPn1SH
 rZyFy5cif9o3645hpQ==;
Received: from localhost ([127.0.0.1] helo=dalek)
 by mx.treblig.org with esmtp (Exim 4.98.2)
 (envelope-from <dave@treblig.org>) id 1wJxQC-00000000ZQZ-05be;
 Mon, 04 May 2026 17:49:32 +0000
From: dave@treblig.org
To: qemu-devel@nongnu.org,
	armbru@redhat.com
Cc: AlanoSong@163.com,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 4/4] monitor: Add `clear` command
Date: Mon,  4 May 2026 18:49:14 +0100
Message-ID: <20260504174914.122607-5-dave@treblig.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504174914.122607-1-dave@treblig.org>
References: <20260504174914.122607-1-dave@treblig.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: "AlanoSong@163.com" <AlanoSong@163.com>

The monitor screen can be cluttered after executing commands
like `info qtree`. It is useful to have a command to clear
current screen, just like linux `clear` command do.

This patch has been tested under monitors using stdio, vc,
tcp socket, unix socket and serial interfaces.

Signed-off-by: Alano Song <AlanoSong@163.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 hmp-commands.hx       | 14 ++++++++++++++
 include/monitor/hmp.h |  1 +
 monitor/hmp-cmds.c    | 11 +++++++++++
 3 files changed, 26 insertions(+)

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
-- 
2.54.0


