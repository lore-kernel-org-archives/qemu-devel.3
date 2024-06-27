Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2C5C3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 04:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMgWZ-0006Dp-Fl; Thu, 27 Jun 2024 00:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sMgWV-0006Cq-Cy
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 00:14:15 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sMgWS-00007s-Rk
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 00:14:14 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e034356faefso468588276.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 21:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719461651; x=1720066451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PsonJ1zRH/+YC/a6OR7EHJ04b9L1NQ9IXkQt5iZNFyk=;
 b=lwZGvDGvnMT5dcSe5ZVkpY35l9Ag1vu3Im3x+v9pu261/auvAOj3F888B1Ct8r2ave
 zGNtw8kKgPrv/g1KEJlyPaALltS2HSGrIHPUHzEEiyUGuLOqqADrL+sb0JI7mgCZcwjH
 P8TuxFwXN6aX3QqvncE6NQtbXDH2AWsZ9h6sHifHd8YGUxK+LA321sGSZVh4X9vJvfYO
 FtMUBDzKToEvw5ibTlPI3xedbozeO3P5hZwUronmYEBWrsx/9YFYGf3XuvK1ch+81OKD
 7FftdN2GYtujErUqe7DjYCS91/GMd8EOf4rxe9Jv4bdWZZP9vGGknvtEF3JijaPmDOUi
 PHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719461651; x=1720066451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PsonJ1zRH/+YC/a6OR7EHJ04b9L1NQ9IXkQt5iZNFyk=;
 b=CJ/lvFlaXNdW0MVUS7QeOF1TPzB2mtPeL4JXKqHIiQaudnbL6YOFzbd49uxwKN2Nrp
 B64X4jrtqp1iO8wZGyQSdg7fRzSSiCEvp6FDId4BS0QuIbJ3DSMWQyAfeWHYyKS8EbDr
 hKuSDTINB9Rijekz1w3X0kBNSl1Ul46yGztO+AKDX9gYbTOpr1Wyc/xTkVnBSrsoNGBX
 +oR2CItg+oTo2zXcREcf+Lg1N7xQ4+X0G/BXVOPFmBAdAQa4ewRCLwm4JpWaCnVxldUD
 zpzjgo52qmLZgjdBGf9rVw+GpEkejvDolGchf8ilomhDUESPwHepOQ38fm2dg0noHDMJ
 A57Q==
X-Gm-Message-State: AOJu0YwLv/DS1eZPVSK83mDBBN7MUHs+zdWIuTTpSNFqFxGHu27n9aAa
 kVBmHq8r6+33yEZnEszW8cBo60jQJ3AddZwqY5LXCGtejj6yJsd1qfuxVPgXZguszka0BanOZwH
 HbpQ=
X-Google-Smtp-Source: AGHT+IHbUkNbJilfkggE9rzWsoJ7grNBtCuhr1PyYK+vckwfJ4YyUO2Ht6d+UmhDc/X0LGVl8+zj2A==
X-Received: by 2002:a25:8045:0:b0:e02:b9ac:1486 with SMTP id
 3f1490d57ef6-e02fc3769b8mr11695462276.57.1719461651228; 
 Wed, 26 Jun 2024 21:14:11 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:391e:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-72748e8539fsm273045a12.66.2024.06.26.21.14.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 21:14:10 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Cc: peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v5 1/9] gdbstub: Clean up process_string_cmd
Date: Thu, 27 Jun 2024 04:13:41 +0000
Message-Id: <20240627041349.356704-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627041349.356704-1-gustavo.romero@linaro.org>
References: <20240627041349.356704-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=gustavo.romero@linaro.org; helo=mail-yb1-xb33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Change 'process_string_cmd' to return true on success and false on
failure, instead of 0 and -1.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 gdbstub/gdbstub.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index b3574997ea..37314b92e5 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -962,14 +962,14 @@ static inline int startswith(const char *string, const char *pattern)
   return !strncmp(string, pattern, strlen(pattern));
 }
 
-static int process_string_cmd(const char *data,
-                              const GdbCmdParseEntry *cmds, int num_cmds)
+static bool process_string_cmd(const char *data,
+                               const GdbCmdParseEntry *cmds, int num_cmds)
 {
     int i;
     g_autoptr(GArray) params = g_array_new(false, true, sizeof(GdbCmdVariant));
 
     if (!cmds) {
-        return -1;
+        return false;
     }
 
     for (i = 0; i < num_cmds; i++) {
@@ -984,16 +984,16 @@ static int process_string_cmd(const char *data,
         if (cmd->schema) {
             if (cmd_parse_params(&data[strlen(cmd->cmd)],
                                  cmd->schema, params)) {
-                return -1;
+                return false;
             }
         }
 
         gdbserver_state.allow_stop_reply = cmd->allow_stop_reply;
         cmd->handler(params, NULL);
-        return 0;
+        return true;
     }
 
-    return -1;
+    return false;
 }
 
 static void run_cmd_parser(const char *data, const GdbCmdParseEntry *cmd)
@@ -1007,7 +1007,7 @@ static void run_cmd_parser(const char *data, const GdbCmdParseEntry *cmd)
 
     /* In case there was an error during the command parsing we must
     * send a NULL packet to indicate the command is not supported */
-    if (process_string_cmd(data, cmd, 1)) {
+    if (!process_string_cmd(data, cmd, 1)) {
         gdb_put_packet("");
     }
 }
@@ -1523,9 +1523,9 @@ static void handle_v_commands(GArray *params, void *user_ctx)
         return;
     }
 
-    if (process_string_cmd(get_param(params, 0)->data,
-                           gdb_v_commands_table,
-                           ARRAY_SIZE(gdb_v_commands_table))) {
+    if (!process_string_cmd(get_param(params, 0)->data,
+                            gdb_v_commands_table,
+                            ARRAY_SIZE(gdb_v_commands_table))) {
         gdb_put_packet("");
     }
 }
@@ -1889,15 +1889,15 @@ static void handle_gen_query(GArray *params, void *user_ctx)
         return;
     }
 
-    if (!process_string_cmd(get_param(params, 0)->data,
-                            gdb_gen_query_set_common_table,
-                            ARRAY_SIZE(gdb_gen_query_set_common_table))) {
+    if (process_string_cmd(get_param(params, 0)->data,
+                           gdb_gen_query_set_common_table,
+                           ARRAY_SIZE(gdb_gen_query_set_common_table))) {
         return;
     }
 
-    if (process_string_cmd(get_param(params, 0)->data,
-                           gdb_gen_query_table,
-                           ARRAY_SIZE(gdb_gen_query_table))) {
+    if (!process_string_cmd(get_param(params, 0)->data,
+                            gdb_gen_query_table,
+                            ARRAY_SIZE(gdb_gen_query_table))) {
         gdb_put_packet("");
     }
 }
@@ -1908,13 +1908,13 @@ static void handle_gen_set(GArray *params, void *user_ctx)
         return;
     }
 
-    if (!process_string_cmd(get_param(params, 0)->data,
-                            gdb_gen_query_set_common_table,
-                            ARRAY_SIZE(gdb_gen_query_set_common_table))) {
+    if (process_string_cmd(get_param(params, 0)->data,
+                           gdb_gen_query_set_common_table,
+                           ARRAY_SIZE(gdb_gen_query_set_common_table))) {
         return;
     }
 
-    if (process_string_cmd(get_param(params, 0)->data,
+    if (!process_string_cmd(get_param(params, 0)->data,
                            gdb_gen_set_table,
                            ARRAY_SIZE(gdb_gen_set_table))) {
         gdb_put_packet("");
-- 
2.34.1


