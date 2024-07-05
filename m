Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E8BC3271F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPecI-00035q-Kz; Fri, 05 Jul 2024 04:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPebR-00011A-4S
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:47:37 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPebA-0004CP-RN
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:47:36 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52ea2f58448so1290408e87.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720169238; x=1720774038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=77YvatHWOR33cTX9z3lD3BFIb9bFvCKghDfoEWx4ifM=;
 b=YxgaobAkELsg/R7aYC8kgWRAOGKUmEcWuLAQS1qvktdmE2YnzYMY2Pg2F9pdBGgfov
 /AjjTPx1eobbI5gdgvtN4ql+u97iHPMw4qwqaQossAU3fLrFAraYHQhYQqvU0n35ejEt
 vwBLgBBe6EYeGLueE7CVZOXqrQeJjl9IvNEJLm0iVF45ByVBz6xcti0BUy5qIQuz9g04
 vmWUX9xq04qLbV0/PBQ6A4BgkvCXevDsu4JDz9Jx5Ysg5ib+kd38q07cgFzTbApUt2Kj
 s75TcjD8T3Tni+BWVQRkacRZJVu6G1dr5vBNkHPs046uTBolRW07mJYSSAZ909J4oB3/
 WL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720169238; x=1720774038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=77YvatHWOR33cTX9z3lD3BFIb9bFvCKghDfoEWx4ifM=;
 b=r0aKpilZA6Y5S3UHBHHZiTtQ8yRbQgd4dRsUb/6O+yd2x0Zp8m10iRiNr6czNiw3GJ
 ovxAO0gmfxHrsx5v0mLGE/WSE7N0Lj2qwCiuWR4ye0BYSMS2gEYY1bvta0qYkYFuhvgP
 orBCYT9Es+kqVDwX3VAX4YGvtMoRt3z6VvZ/6tvIKDONZciR4GdpNTOhlDAjMw49OCmg
 e451P2ml0sZ6Un+bDGCbqgY5B3/tXV1bWokAvkzfd0rtNJVw14WsylxPZjhqrl1jSGkJ
 ERQzO2rapPHSNvie4Ey4cXBQKC6OmS1NiA4RIP/X4ZiGoc5npMW/GtRl7parIdidFDeB
 rFhA==
X-Gm-Message-State: AOJu0YzfN6NtqGMqygCHR33QE/AI9G11x73CaM1Oqi+UH0qXoCXd62Kz
 5zx0IePTFE4j7LNpx79FzefoQhp20gIxJiwm+cAr4tsoq9O9jymT4ChOeT/9isc=
X-Google-Smtp-Source: AGHT+IFg1/+kF3iTierx2fmPEuZ+gpoRIneMJUDTMazG/hSFaQyo9o15Q648oMk5deFvwrCi4aiyxg==
X-Received: by 2002:a05:6512:15a9:b0:52e:a60e:3a0e with SMTP id
 2adb3069b0e04-52ea60e3b9cmr1232186e87.0.1720169238294; 
 Fri, 05 Jul 2024 01:47:18 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58c9061becfsm3499904a12.83.2024.07.05.01.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:47:16 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6D9E9621AC;
 Fri,  5 Jul 2024 09:40:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH v2 38/40] gdbstub: Use true to set cmd_startswith
Date: Fri,  5 Jul 2024 09:40:45 +0100
Message-Id: <20240705084047.857176-39-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12c.google.com
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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


