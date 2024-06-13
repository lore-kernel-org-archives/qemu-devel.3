Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B48C27C6E
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 17:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHo8h-0000ct-Uk; Thu, 13 Jun 2024 13:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sHo8g-0000c5-GC
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:21:30 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sHo8e-0005mC-R3
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:21:30 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1f8507aac31so11528445ad.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 10:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718299287; x=1718904087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QpX5S/32Rn+0vixurm/FTGR7gNgdKeFkSlJ8tHRDNqU=;
 b=YAcKRAXv7b/EggkNmDINGmC4Fj881yOdtol02tiT846SvmLCEf2UXDQLWmeO4L4+SW
 K616m8+jlP7SUYFAdqN8p4QTMsGbCcyEZYWLaQ9Fsk8QOvwzKJELPXSSVrRAL9RPLaYT
 An/WNWo0hGhw4vWQkFrC61rX3KbKG1AGQjyoDk276Y5EzI38NNULP22JDumlmW9cEpTk
 aAuhL2DKnKlO+TX87d38qoJRDfWElnxULD8Tsb9JnQYIxaQ+OCWSEbaB6MI/uEu6er0W
 pJy59UayRfPDM0OZ8vEfB10xY/vlbRoodOQ9a1KLSkzZgBNObKoELLAFVVieb7ThmHJl
 ZkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718299287; x=1718904087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QpX5S/32Rn+0vixurm/FTGR7gNgdKeFkSlJ8tHRDNqU=;
 b=D5+Fw5/si4McfKl43uII/Pyn99HenuHQAk4zrftKWwypzBpQ9d+UZ9PPlHEnwBOZit
 wrYs0PxHMESYQN0tZ4j+KK1m7a/rO2Ot4Cy7mDxI/pxP/pevyHeVeplauHOgYDapZSuR
 +5yQeoZc9JHPxeZU6hrwvqdukNob2zfv4VDta6rXrq+cPaeWgzoOkUY8uZfGGP1oDrC/
 KsA9OzaPO/EZ5OLSJ1xWmHXnCDCQuQ/IVWDmovQIfc9xkE0pCcTJoZMfmbz8cn5c25gg
 ief2yy+pVEaPgZyHfdUyHK1hnjgzEm8DNzPJ2D+p53wW5dIPszuO5oibLkZMddlMsBGa
 DsnQ==
X-Gm-Message-State: AOJu0YzGDvqleqr87DoXm5Dc2E/gpmeJhs5922k2OIleT3bPYexnysMC
 88wWHh3jplGFK4UAHN9uPpWI2dIeoQaGnIK5+Y/qi3g1WfldPWyZEGEC+vZOmY9HVmz1osFe5i5
 W
X-Google-Smtp-Source: AGHT+IHXUqVGR5baSY4e/eQRRZrQiDf3GIXwNokVj2pkj8CeHpHEjXJcanbNfcasNjF49Cht8EKpyA==
X-Received: by 2002:a17:902:c20c:b0:1f8:44f8:a366 with SMTP id
 d9443c01a7336-1f8627ce3dfmr3305895ad.16.1718299287162; 
 Thu, 13 Jun 2024 10:21:27 -0700 (PDT)
Received: from amd.. ([2804:7f0:b400:8dcb:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e5b85bsm16443885ad.32.2024.06.13.10.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 10:21:26 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, peter.maydell@linaro.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH v2 1/9] gdbstub: Clean up process_string_cmd
Date: Thu, 13 Jun 2024 17:20:55 +0000
Message-Id: <20240613172103.2987519-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613172103.2987519-1-gustavo.romero@linaro.org>
References: <20240613172103.2987519-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


