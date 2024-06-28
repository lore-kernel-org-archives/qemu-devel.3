Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391D8C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 12:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNB56-0002lG-H6; Fri, 28 Jun 2024 08:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNB53-0002jp-VJ
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:51:58 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNB51-0007iM-Qb
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:51:57 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57d1782679fso814095a12.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 05:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719579114; x=1720183914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9azc3vjA5E2RhLQ0R25KrHb4QGzLClmA9Y96NqdoYUc=;
 b=FTqEIPHlafYIuQY414CCPCLcgs86bhTjKFFvVE76Mm1CSVkOFTuudVtXXb9WwFpC1i
 4jM4GbrYhcakC49fGBzo3QntdI6etua3xKfslSfXWQGPiS3bPVVdfkmFdPYvLU0Pyv1W
 ilI6nuzcr/JSmqeTuzR51rAUyDgYhR32i32RCEY9Icb9GjAK6hQUwZnysnR2a97DBdog
 PTIWT2p394tSflga+4u7T71TjRbH63Exsx8SyA+sznaibfTVls2sISsuVl+aRhrwIrMb
 mWWSuvgVlsGeTwu/GlMMq1l+QpyFZaxiyBhO6rG8dlgPnWyX/EzKR9CmHl21LuGSrtQg
 NYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719579114; x=1720183914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9azc3vjA5E2RhLQ0R25KrHb4QGzLClmA9Y96NqdoYUc=;
 b=UD1xSYgmuf2bq/4wnIxc2busoETSLxrvt0Vk9OkHJZ8uh6thV5nwy0IaRVopz1PSGW
 e6YBk6hw0ZLXrr+fJQ5Cvn/FTSwKg0HKatc0ThUkxpf4GtkbMSsH1LlWviliiDFcgEOr
 86y5rPccvLLKmuViLzSmi2EEQuXX3yPWTI1hr3rlRMHE00Ov4qrsO2DhpT+3qvdZUM8l
 UXQNNfB2r+I2PErlM/nBBEe1yrY64VXMhgZ+a4xeh+a3AXEuT1IuoG+wREEM6kaTBkKN
 q1ARhHER88s4hCCoih0VQqbIxyTHboqp0Yd+fZhYLnA4roCDQ34rUhzZ/76Gx3SmPkQI
 9grA==
X-Gm-Message-State: AOJu0Yw2GbTlG5E9BY0bP3YRs6zl5/KPU0YHflwEGRZwZd8Uv6YdCEQ9
 RDpJlK9RWke8jgrCfuO54MEpEW1uR4Jd8XUnArRlzdEygH1e/Gj4LeQVBO1rQno=
X-Google-Smtp-Source: AGHT+IHLnPZWZfb+XHUloRLMZKYXASEFcf5wl7CWg29cmxBUm/k5pFum6T7jjps7Q4ZaQHiOvYfIPw==
X-Received: by 2002:a50:aada:0:b0:57d:72e:5b3a with SMTP id
 4fb4d7f45d1cf-57d4bdd0061mr11341015a12.33.1719579113984; 
 Fri, 28 Jun 2024 05:51:53 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58614d50da0sm986943a12.59.2024.06.28.05.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 05:51:53 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 06D5D5FA40;
 Fri, 28 Jun 2024 13:43:01 +0100 (BST)
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
Subject: [PATCH 21/23] gdbstub: Use true to set cmd_startswith
Date: Fri, 28 Jun 2024 13:42:56 +0100
Message-Id: <20240628124258.832466-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240628124258.832466-1-alex.bennee@linaro.org>
References: <20240628124258.832466-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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

cmd_startswith is a boolean so use 'true' to set it instead of 1.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-Id: <20240628050850.536447-10-gustavo.romero@linaro.org>
---
 gdbstub/gdbstub.c | 80 +++++++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 5c1612ed2a..b9ad0a063e 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1433,26 +1433,26 @@ static const GdbCmdParseEntry gdb_v_commands_table[] = {
     {
         .handler = handle_v_cont_query,
         .cmd = "Cont?",
-        .cmd_startswith = 1
+        .cmd_startswith = true
     },
     {
         .handler = handle_v_cont,
         .cmd = "Cont",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .allow_stop_reply = true,
         .schema = "s0"
     },
     {
         .handler = handle_v_attach,
         .cmd = "Attach;",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .allow_stop_reply = true,
         .schema = "l0"
     },
     {
         .handler = handle_v_kill,
         .cmd = "Kill;",
-        .cmd_startswith = 1
+        .cmd_startswith = true
     },
 #ifdef CONFIG_USER_ONLY
     /*
@@ -1462,25 +1462,25 @@ static const GdbCmdParseEntry gdb_v_commands_table[] = {
     {
         .handler = gdb_handle_v_file_open,
         .cmd = "File:open:",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .schema = "s,L,L0"
     },
     {
         .handler = gdb_handle_v_file_close,
         .cmd = "File:close:",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .schema = "l0"
     },
     {
         .handler = gdb_handle_v_file_pread,
         .cmd = "File:pread:",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .schema = "l,L,L0"
     },
     {
         .handler = gdb_handle_v_file_readlink,
         .cmd = "File:readlink:",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .schema = "s0"
     },
 #endif
@@ -1748,7 +1748,7 @@ static const GdbCmdParseEntry gdb_gen_query_set_common_table[] = {
     {
         .handler = handle_set_qemu_sstep,
         .cmd = "qemu.sstep=",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .schema = "l0"
     },
 };
@@ -1804,7 +1804,7 @@ static const GdbCmdParseEntry gdb_gen_query_table[] = {
     {
         .handler = handle_query_thread_extra,
         .cmd = "ThreadExtraInfo,",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .schema = "t0"
     },
 #ifdef CONFIG_USER_ONLY
@@ -1816,14 +1816,14 @@ static const GdbCmdParseEntry gdb_gen_query_table[] = {
     {
         .handler = gdb_handle_query_rcmd,
         .cmd = "Rcmd,",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .schema = "s0"
     },
 #endif
     {
         .handler = handle_query_supported,
         .cmd = "Supported:",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .schema = "s0"
     },
     {
@@ -1834,7 +1834,7 @@ static const GdbCmdParseEntry gdb_gen_query_table[] = {
     {
         .handler = handle_query_xfer_features,
         .cmd = "Xfer:features:read:",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .schema = "s:l,l0"
     },
 #if defined(CONFIG_USER_ONLY)
@@ -1842,27 +1842,27 @@ static const GdbCmdParseEntry gdb_gen_query_table[] = {
     {
         .handler = gdb_handle_query_xfer_auxv,
         .cmd = "Xfer:auxv:read::",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .schema = "l,l0"
     },
     {
         .handler = gdb_handle_query_xfer_siginfo,
         .cmd = "Xfer:siginfo:read::",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .schema = "l,l0"
      },
 #endif
     {
         .handler = gdb_handle_query_xfer_exec_file,
         .cmd = "Xfer:exec-file:read:",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .schema = "l:l,l0"
     },
 #endif
     {
         .handler = gdb_handle_query_attached,
         .cmd = "Attached:",
-        .cmd_startswith = 1
+        .cmd_startswith = true
     },
     {
         .handler = gdb_handle_query_attached,
@@ -1901,14 +1901,14 @@ static const GdbCmdParseEntry gdb_gen_set_table[] = {
     {
         .handler = handle_set_qemu_sstep,
         .cmd = "qemu.sstep:",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .schema = "l0"
     },
 #ifndef CONFIG_USER_ONLY
     {
         .handler = gdb_handle_set_qemu_phy_mem_mode,
         .cmd = "qemu.PhyMemMode:",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .schema = "l0"
     },
 #endif
@@ -1916,7 +1916,7 @@ static const GdbCmdParseEntry gdb_gen_set_table[] = {
     {
         .handler = gdb_handle_set_catch_syscalls,
         .cmd = "CatchSyscalls:",
-        .cmd_startswith = 1,
+        .cmd_startswith = true,
         .schema = "s0",
     },
 #endif
@@ -2012,7 +2012,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry target_halted_cmd_desc = {
                 .handler = handle_target_halt,
                 .cmd = "?",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .allow_stop_reply = true,
             };
             cmd_parser = &target_halted_cmd_desc;
@@ -2023,7 +2023,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry continue_cmd_desc = {
                 .handler = handle_continue,
                 .cmd = "c",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .allow_stop_reply = true,
                 .schema = "L0"
             };
@@ -2035,7 +2035,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry cont_with_sig_cmd_desc = {
                 .handler = handle_cont_with_sig,
                 .cmd = "C",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .allow_stop_reply = true,
                 .schema = "l0"
             };
@@ -2047,7 +2047,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry v_cmd_desc = {
                 .handler = handle_v_commands,
                 .cmd = "v",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .schema = "s0"
             };
             cmd_parser = &v_cmd_desc;
@@ -2064,7 +2064,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry detach_cmd_desc = {
                 .handler = handle_detach,
                 .cmd = "D",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .schema = "?.l0"
             };
             cmd_parser = &detach_cmd_desc;
@@ -2075,7 +2075,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry step_cmd_desc = {
                 .handler = handle_step,
                 .cmd = "s",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .allow_stop_reply = true,
                 .schema = "L0"
             };
@@ -2087,7 +2087,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry backward_cmd_desc = {
                 .handler = handle_backward,
                 .cmd = "b",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .allow_stop_reply = true,
                 .schema = "o0"
             };
@@ -2099,7 +2099,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry file_io_cmd_desc = {
                 .handler = gdb_handle_file_io,
                 .cmd = "F",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .schema = "L,L,o0"
             };
             cmd_parser = &file_io_cmd_desc;
@@ -2110,7 +2110,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry read_all_regs_cmd_desc = {
                 .handler = handle_read_all_regs,
                 .cmd = "g",
-                .cmd_startswith = 1
+                .cmd_startswith = true
             };
             cmd_parser = &read_all_regs_cmd_desc;
         }
@@ -2120,7 +2120,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry write_all_regs_cmd_desc = {
                 .handler = handle_write_all_regs,
                 .cmd = "G",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .schema = "s0"
             };
             cmd_parser = &write_all_regs_cmd_desc;
@@ -2131,7 +2131,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry read_mem_cmd_desc = {
                 .handler = handle_read_mem,
                 .cmd = "m",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .schema = "L,L0"
             };
             cmd_parser = &read_mem_cmd_desc;
@@ -2142,7 +2142,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry write_mem_cmd_desc = {
                 .handler = handle_write_mem,
                 .cmd = "M",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .schema = "L,L:s0"
             };
             cmd_parser = &write_mem_cmd_desc;
@@ -2153,7 +2153,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry get_reg_cmd_desc = {
                 .handler = handle_get_reg,
                 .cmd = "p",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .schema = "L0"
             };
             cmd_parser = &get_reg_cmd_desc;
@@ -2164,7 +2164,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry set_reg_cmd_desc = {
                 .handler = handle_set_reg,
                 .cmd = "P",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .schema = "L?s0"
             };
             cmd_parser = &set_reg_cmd_desc;
@@ -2175,7 +2175,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry insert_bp_cmd_desc = {
                 .handler = handle_insert_bp,
                 .cmd = "Z",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .schema = "l?L?L0"
             };
             cmd_parser = &insert_bp_cmd_desc;
@@ -2186,7 +2186,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry remove_bp_cmd_desc = {
                 .handler = handle_remove_bp,
                 .cmd = "z",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .schema = "l?L?L0"
             };
             cmd_parser = &remove_bp_cmd_desc;
@@ -2197,7 +2197,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry set_thread_cmd_desc = {
                 .handler = handle_set_thread,
                 .cmd = "H",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .schema = "o.t0"
             };
             cmd_parser = &set_thread_cmd_desc;
@@ -2208,7 +2208,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry thread_alive_cmd_desc = {
                 .handler = handle_thread_alive,
                 .cmd = "T",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .schema = "t0"
             };
             cmd_parser = &thread_alive_cmd_desc;
@@ -2219,7 +2219,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry gen_query_cmd_desc = {
                 .handler = handle_gen_query,
                 .cmd = "q",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .schema = "s0"
             };
             cmd_parser = &gen_query_cmd_desc;
@@ -2230,7 +2230,7 @@ static int gdb_handle_packet(const char *line_buf)
             static const GdbCmdParseEntry gen_set_cmd_desc = {
                 .handler = handle_gen_set,
                 .cmd = "Q",
-                .cmd_startswith = 1,
+                .cmd_startswith = true,
                 .schema = "s0"
             };
             cmd_parser = &gen_set_cmd_desc;
-- 
2.39.2


