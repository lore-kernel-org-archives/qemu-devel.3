Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7105CD61015
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 13:46:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlSA7-0001NH-D4; Thu, 29 Jan 2026 08:34:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlS90-000097-Jy
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:33:13 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlS8w-0002bi-4H
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:33:08 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4806bf03573so5458665e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 05:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769693584; x=1770298384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2/5ri0x0HKOQ4AevWnY2CiNFX91P9a3QRDv363s7aV8=;
 b=ig1kMa0vzvBtkCk9tj/n4tW6fT3uJScxO81s0BrtzZ36OYvYol2YYYPHuKQYeRm3FI
 SnaeKECkAlM2UvZG99rB9FyrjyBdfLQINnAXRnSMa6QVKx5aAByf5Z/BRvL1F0awciQB
 SgBjL5y5bfv8i9Ti3HdXahl6aWBmAVhctd8MTjWnHhWWNRHtcoNPYL/ZCp5HbRkWoxd8
 Qfp7Yacn9lH8lGH0SQmn0GIPrXQKkvwY5xs5JbJDY/pk+/fg3OcvWit/COMzSqjv6oGf
 rfNy+UdAyCv5IzzIXffWzcX6AIh7unvVdl5C+TINU6rxB1CSrxEUa2UCyD22/aP/BcEl
 mLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769693584; x=1770298384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2/5ri0x0HKOQ4AevWnY2CiNFX91P9a3QRDv363s7aV8=;
 b=C7alOEee73FMnmmEStSBidoi/EJ0EUAu5idRIQng5dFpHSXadztbAoh7hSQfebzjSJ
 GksznMUmjan6UC/ZUltCmDlWBiX93kbXaR7Tk7IIogJGNZP5kLVRNszpfrntRLAl7f/1
 ef7ZpWN9B5MecPN3S5VmGz6O34NaRy5Op8uuS1sWa2gBWUr12jUQnk9ToWRSyGt5/j64
 lNWpgDLhRUnAmkXorW85uZg40KOjzY7++01GxgaIz/we3etNwtw3z2jrCqiaR3ZUL+GI
 adGDtmrtPjdS8VpmsFXG5qa2hvB37etHAiQQ6lyf8xYBTFP35l5c5s7pE9Bo74FATaNz
 VBqQ==
X-Gm-Message-State: AOJu0YwzOMI7cdJ38cYs9uAAUPyU6TWgg6WhscJk3OjGJ42SRBRDrHgF
 NwTV1+Xp7gBnuGacPRykilCIb+vcj4Jya/dmjYYL0lZCPv0qRGf14jMGbAbmRzNaZ1CySnkE3fQ
 Y2rJZTg0=
X-Gm-Gg: AZuq6aIRdbjG62m9auhUExebQu1gfW0peLSXscQmO1w/Z+bqQwdTczNyXsTU8uzEKDK
 INCSvnIAxRDq1ZGAbMHWTCEh/GepacOrbuxy/gflyVJkIrOMGtS9vUAVabIm33guiU99Bd5+KzS
 y0au+vstCFvtDPzaDBaPBLtTtLe70n+iWV/vsRbooRt6SrMG6ol56TYvHcMLhrHqukATrgOVXYx
 K2+P7WfU93jq5h86nENPRvDbvKIXZpICsR2jzWgEjJV6aLgF8GrYlxXoqPW6MosPXCA1bzMf8ER
 EqAqmtd73EomO3CcJcy6sOoZKjjIN4GoW3nvkDacCNYTYKr6/ivMUs5D9ElX7wq4BSm8T59wxZ4
 YZ+y+L4vKol7S3/YU3Kg85zk23V8gh9kyCW+wHzzRJZF+hVUIlS2MhqU5w8Xi8Qbx2OCnSmL9mn
 NvY/Wa8Jz2BX9eMvXh3YJP38cE4OE2YM68NY928+UMjQz2FhMMRCCrsjDLu69Sua45uGeCxfI=
X-Received: by 2002:a05:600c:6986:b0:480:1c10:5633 with SMTP id
 5b1f17b1804b1-48069c86cf8mr97839845e9.26.1769693584271; 
 Thu, 29 Jan 2026 05:33:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5d30f09sm4270945e9.1.2026.01.29.05.33.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Jan 2026 05:33:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v4 3/9] monitor: Add hmp_cmds_for_target() helper
Date: Thu, 29 Jan 2026 14:32:35 +0100
Message-ID: <20260129133241.35990-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129133241.35990-1-philmd@linaro.org>
References: <20260129133241.35990-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

HMPCommand arrays are filled with target-specific
commands, so defined in a target-specific unit.
Introduce the hmp_cmds_for_target() to allow
target-agnostic code to access the arrays.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 monitor/monitor-internal.h |  9 +++++++--
 monitor/hmp-target.c       | 13 ++++++++-----
 monitor/hmp.c              |  8 +++++---
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 7735c731083..feca111ae31 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -169,8 +169,6 @@ extern QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
 extern QemuMutex monitor_lock;
 extern MonitorList mon_list;
 
-extern HMPCommand hmp_cmds[];
-
 void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
                        bool use_io_thread);
 void monitor_data_destroy(Monitor *mon);
@@ -187,4 +185,11 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name);
 void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
 int hmp_compare_cmd(const char *name, const char *list);
 
+/*
+ * hmp_cmds_for_target: Return array of HMPCommand entries
+ *
+ * If @info_command is true, return the particular 'info foo' commands array.
+ */
+HMPCommand *hmp_cmds_for_target(bool info_command);
+
 #endif
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index 37dfd7fd4c6..59c60d13b52 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -44,8 +44,6 @@
 /* Make devices configuration available for use in hmp-commands*.hx templates */
 #include CONFIG_DEVICES
 
-static HMPCommand hmp_info_cmds[];
-
 /**
  * Is @name in the '|' separated list of names @list?
  */
@@ -76,11 +74,16 @@ static HMPCommand hmp_info_cmds[] = {
 };
 
 /* hmp_cmds and hmp_info_cmds would be sorted at runtime */
-HMPCommand hmp_cmds[] = {
+static HMPCommand hmp_cmds[] = {
 #include "hmp-commands.h"
     { NULL, NULL, },
 };
 
+HMPCommand *hmp_cmds_for_target(bool info_command)
+{
+    return info_command ? hmp_info_cmds : hmp_cmds;
+}
+
 /*
  * Set @pval to the value in the register identified by @name.
  * return 0 if OK, -1 if not found
@@ -148,7 +151,7 @@ static void __attribute__((__constructor__)) sortcmdlist(void)
 void monitor_register_hmp(const char *name, bool info,
                           void (*cmd)(Monitor *mon, const QDict *qdict))
 {
-    HMPCommand *table = info ? hmp_info_cmds : hmp_cmds;
+    HMPCommand *table = hmp_cmds_for_target(info);
 
     while (table->name != NULL) {
         if (strcmp(table->name, name) == 0) {
@@ -164,7 +167,7 @@ void monitor_register_hmp(const char *name, bool info,
 void monitor_register_hmp_info_hrt(const char *name,
                                    HumanReadableText *(*handler)(Error **errp))
 {
-    HMPCommand *table = hmp_info_cmds;
+    HMPCommand *table = hmp_cmds_for_target(true);
 
     while (table->name != NULL) {
         if (strcmp(table->name, name) == 0) {
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 4caafbc7146..17e5756986f 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -301,7 +301,7 @@ void hmp_help_cmd(Monitor *mon, const char *name)
     }
 
     /* 2. dump the contents according to parsed args */
-    help_cmd_dump(mon, hmp_cmds, args, nb_args, 0);
+    help_cmd_dump(mon, hmp_cmds_for_target(false), args, nb_args, 0);
 
     free_cmdline_args(args, nb_args);
 }
@@ -1131,7 +1131,8 @@ void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
 
     trace_handle_hmp_command(mon, cmdline);
 
-    cmd = monitor_parse_command(mon, cmdline, &cmdline, hmp_cmds);
+    cmd = monitor_parse_command(mon, cmdline, &cmdline,
+                                hmp_cmds_for_target(false));
     if (!cmd) {
         return;
     }
@@ -1375,7 +1376,8 @@ static void monitor_find_completion(void *opaque,
     }
 
     /* 2. auto complete according to args */
-    monitor_find_completion_by_table(mon, hmp_cmds, args, nb_args);
+    monitor_find_completion_by_table(mon, hmp_cmds_for_target(false),
+                                     args, nb_args);
 
 cleanup:
     free_cmdline_args(args, nb_args);
-- 
2.52.0


