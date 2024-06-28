Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A041C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 12:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNAy1-0007Om-Js; Fri, 28 Jun 2024 08:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAwk-0004vX-H6
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:43:25 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAwg-0005kB-8z
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:43:22 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a725282b926so64571666b.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 05:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719578593; x=1720183393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sM0rceWGonmSHrbbpeQx+UK29i4a0M/kbqzgulSSnTo=;
 b=r2R2omkUpyJrhyTeOkaGAXij3ywxn2iH1NImZgByvol2DzvAudrYBnharnOHlicALx
 2VmCjkQUNYYpY6NCevceHYu5USJ3P5wO2S5FfK2TejJr7ySTlpbP1zHPGFa/w9bs3YiV
 oCpLECW4H2kL258esVsO0aIlreUtlRMpwCPd6+jqKUurOHYWC3tSPtLaaH1U6LUP8ziI
 zRyuXYaOBl9ku4gF7qV1vSFEhAVt3/eWFAPaaIbb1Se1oKfpj7Zvyl7sk77Ihmk7F5SU
 UgjPaA95T5KtwcTpKIMS1ym5HL7eUz7XivySlR0e5DLMht9gf/JfUe5ecLEjEI4ffpI6
 kqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719578593; x=1720183393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sM0rceWGonmSHrbbpeQx+UK29i4a0M/kbqzgulSSnTo=;
 b=cU6CXXOjmrVPXmQuR/f8UPRAbcXudIQLACIGcZivFg8IAvClYhLrY51I6RLNvOTa+w
 iQ6lzMcRAVS4PD4sxjWU0b83Q7qxDzzDB+uDB4b52W364q8xBOkfNwppMpKV8jXBno/h
 LJStK9lIZP+oZG+dKFyFNpjNy+8gDJnVDwKsj6xmTYAcD09LF1EmMKmfxxvR2znb6w5m
 K42MqxETXlIM16uKS5cM9Z5N/zyFdiwGWB0XF1pJ+/AHuX1mzKEmkVLwRiQVxi4EyxBv
 GFax5Ap/IuPQM98hpJj1lMkaib7+vjSFaQQGbCAEMrraY91khoAuQBwfAJzsTwMvTtbi
 H3nA==
X-Gm-Message-State: AOJu0YwZE2/gnu/FuVtlMbCn+ozl1FuEZJbcMzfRYOqTrtC/Vwf2d6+F
 waIlV9i2GqqlCoyLJOaMejaaxv1BYQv3sAxMoBjKR+xAByIKVkfn+5NlLuu4O+U=
X-Google-Smtp-Source: AGHT+IEdpvoJ4zCiXxDyCRR3gEF0EAepFP6DrAARsfqXCB9IqXshwa7Sv9IwdoPeC1Qish7Kq+g0rg==
X-Received: by 2002:a17:907:8688:b0:a72:b34f:beab with SMTP id
 a640c23a62f3a-a72b34fbffamr84907166b.73.1719578592548; 
 Fri, 28 Jun 2024 05:43:12 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72b0091016sm51207466b.150.2024.06.28.05.43.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 05:43:09 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3A0BF5FA3A;
 Fri, 28 Jun 2024 13:43:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 13/23] gdbstub: Clean up process_string_cmd
Date: Fri, 28 Jun 2024 13:42:48 +0100
Message-Id: <20240628124258.832466-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240628124258.832466-1-alex.bennee@linaro.org>
References: <20240628124258.832466-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Change 'process_string_cmd' to return true on success and false on
failure, instead of 0 and -1.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240628050850.536447-2-gustavo.romero@linaro.org>
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
2.39.2


