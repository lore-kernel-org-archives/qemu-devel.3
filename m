Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3B3EE6B46
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 18:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQCs-0007zJ-WD; Fri, 06 Feb 2026 13:05:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1voQCq-0007wu-Qx
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:05:24 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1voQCp-0001RC-3C
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:05:24 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b8838339fc6so46286066b.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 10:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770401121; x=1771005921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YLNn3Uva6SjJeQYlOxn8DYVVkX41Y1BiZ46SMJcyHmw=;
 b=p8/bmDXAoVj0j/XVOYGDxYn7yuEQdz0MMZUWFdZN1ze3NAYlfXsjYpNjqNVnGDmdMp
 UPmGPTMygEQCO4ddB5XL6ee8ldiFhlrxGEoQB6bhFTbcE3+TKAS2blzeUyC/+k8erlyI
 oBq+wvoCNEsffdgifWljxlfzGbI7bkcYOMz43/vmXAQ108t5e+KD23ia7of9kZf56Gl/
 tvL0V6euyhW4RlsnROMsOAv/JyFDRLuMB8lV8o6D2J+3VRS+o7YSyj/rsL1sKb8DGWbE
 DQL8Q0oZXD/o17k61TEV0+UH6ERJMOFT23P7kDJwdwRLxMEMEHr9UXlvCwl/x4RHpf7V
 8V+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770401121; x=1771005921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YLNn3Uva6SjJeQYlOxn8DYVVkX41Y1BiZ46SMJcyHmw=;
 b=VNYEOuKgGrQlDsBSI2QnfwQ+U7OqQmZS5sqPutIuQZ6q6Yuol5id8ud2MMQ7pXeu0B
 RWZUOr/zVb3AcSjhJ8SLlsUFaf+sCC8j7loMnryUU3CWAGNaRT/2vVrRGFI+MSC7z3+M
 v3wYrCkKUdQ9hcdYjTs0vbCc1bgtdo4brrU8rwwlu0upVusMXg0ICAqREzpbA79qIZCo
 uOkAG4BMVPo9JbN3PcQV9L+3+OCmWFZPngTTfRYqMgUqc+6o+heb7saEXZdWLvsO9qW6
 lrXTi92DuDxSct0RR7+Dp68U4M6FGfscgnP7uw+f8L+2cjONJIaBuaraOtsxD5WyrEfR
 LOWw==
X-Gm-Message-State: AOJu0YxYQXPf9fkKui90iirxJqu30/C1hSqfaDcwYAcrdKarkrF+NuG+
 occPAoxCLUWUxwRLYdpID841EEEnFDk+TAQmN9cX9WnRUA6ewIIoE0/mzZbGgpI8g14=
X-Gm-Gg: AZuq6aLYeEmApx58b+uF+E+EnTjk3+faSX8KpVTKkX6bhqT6Ma2Omvo1Nx9xWgaq8IE
 +IDQpNZiJQiy9KJkp6AdGc0TUwDc76u9Y4DC6XD2u2abiXZxasuLhnohWxiUDu7x6yRz3Ih3zhz
 cnUuU8QXJEOG9F8REoRYDiF+VvFWsLYUy8eXx27IHcQqIaPLBBFKOkJA106wtL8ev+ByMBjnEc6
 y0zfDPcfkClodI7eFcQsIFTSLD9VQKdGknRPyVA3NbXau6zZ1PacFmWG25iNSxy8kypVr83s65L
 Gf6jKfBTD4E4Y4oYp0Sd4din+4Ubla7LLnHZpit8ok/deohtLFHBqqgaoeJWDp5AWDVCoUoYtyS
 drLo9oXrZ5R6Lk5K8wkH1NpeRhh82wvNwnQx2NMua6Z5/pfkxj06qRVzkByi2FyqoR2bYKhrQ8a
 Qx9pzwyNWDtSU=
X-Received: by 2002:a17:906:f598:b0:b79:eba9:83b4 with SMTP id
 a640c23a62f3a-b8edb7e3aa3mr269242366b.6.1770401121360; 
 Fri, 06 Feb 2026 10:05:21 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8edacaffeesm99446266b.38.2026.02.06.10.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 10:05:18 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0D355607B5;
 Fri, 06 Feb 2026 18:05:18 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/10] gdbstub: remove the need for goto cleanup
Date: Fri,  6 Feb 2026 18:05:10 +0000
Message-ID: <20260206180517.1335861-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206180517.1335861-1-alex.bennee@linaro.org>
References: <20260206180517.1335861-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

We already set a default error reply which we can only overwrite if we
successfully follow the chain of checks. Initialise the variables as
NULL and use that to gate the construction of the filled out
stop/reply packet.

Message-ID: <20260203115201.2387721-4-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 1f8cd118924..aeff467fdd6 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1413,36 +1413,33 @@ static void handle_v_cont(GArray *params, void *user_ctx)
 
 static void handle_v_attach(GArray *params, void *user_ctx)
 {
-    GDBProcess *process;
-    CPUState *cpu;
+    GDBProcess *process = NULL;
+    CPUState *cpu = NULL;
 
+    /* Default error reply */
     g_string_assign(gdbserver_state.str_buf, "E22");
-    if (!params->len) {
-        goto cleanup;
-    }
-
-    process = gdb_get_process(gdb_get_cmd_param(params, 0)->val_ul);
-    if (!process) {
-        goto cleanup;
+    if (params->len) {
+        process = gdb_get_process(gdb_get_cmd_param(params, 0)->val_ul);
     }
 
-    cpu = gdb_get_first_cpu_in_process(process);
-    if (!cpu) {
-        goto cleanup;
+    if (process) {
+        cpu = gdb_get_first_cpu_in_process(process);
     }
 
-    process->attached = true;
-    gdbserver_state.g_cpu = cpu;
-    gdbserver_state.c_cpu = cpu;
+    if (cpu) {
+        process->attached = true;
+        gdbserver_state.g_cpu = cpu;
+        gdbserver_state.c_cpu = cpu;
 
-    if (gdbserver_state.allow_stop_reply) {
-        g_string_printf(gdbserver_state.str_buf, "T%02xthread:", GDB_SIGNAL_TRAP);
-        gdb_append_thread_id(cpu, gdbserver_state.str_buf);
-        g_string_append_c(gdbserver_state.str_buf, ';');
-        gdbserver_state.allow_stop_reply = false;
-cleanup:
-        gdb_put_strbuf();
+        if (gdbserver_state.allow_stop_reply) {
+            g_string_printf(gdbserver_state.str_buf, "T%02xthread:", GDB_SIGNAL_TRAP);
+            gdb_append_thread_id(cpu, gdbserver_state.str_buf);
+            g_string_append_c(gdbserver_state.str_buf, ';');
+            gdbserver_state.allow_stop_reply = false;
+        }
     }
+
+    gdb_put_strbuf();
 }
 
 static void handle_v_kill(GArray *params, void *user_ctx)
-- 
2.47.3


