Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92EF6C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPl0D-0002wH-07; Fri, 05 Jul 2024 11:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPl04-0002fT-Lp
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:37:28 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPl02-0001Jp-5l
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:37:28 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a77c4309fc8so156207966b.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193844; x=1720798644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SKiCUXhdtxK6IeX+xyMLUyY+4qp63cQ7G8m1vsLFBDw=;
 b=bLITfrtlcd82T2tV+6oHzycNom1eUubqQdXCTf7NfrvtSdupDt4S2qn1R3UOkEeo4I
 JKot0/UshjdUv/AKVG0QmWLEn9J8Oe97YAiK5YCoVHHhiifycoBH3J/jZ+g/XrDYSlXs
 e1OE8iA+rayYt7PXT3BeFdcPZCntsFxxktXRz9aScC9KyU1dYJys/+AyXvkS9ZmbAV1T
 Jl22H0yj8K2U/KrFlIXxUTiOGHxTIawkAVnwZUfq9qjSVKFn2llNSi6Re9u8syi7JyJ0
 Ahlv4HW55MsZVBkEpEEuV7O4g3I0AgpfD2u8bqJ37z5AItGABhPbu1pZ4R7ZiZdKr5pN
 liEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193844; x=1720798644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SKiCUXhdtxK6IeX+xyMLUyY+4qp63cQ7G8m1vsLFBDw=;
 b=w+EWKXAlpd6C35D8e3FU9dzSlBh4akDcP8vExMrF2cZqwsAiaRhf1701EDvwyiFKOS
 0P1QHgT2WFaGgySCiUsMUuN+kmuygJQQp0U1avJN7fT+DZI2d1NFY6LTr2jFlTOhWvlP
 4Lki29bXDHjk/HXlKa5K557Z0VM1Rj4gyacccjh7+HlYP6yhciEX7fYMRDYlmTeqgwsR
 h3qbwpGAY1ItsbS28zCyrNO8P8lj0cAxPFUbStxt7rXr0hNRj4RqcOwhKG1n3t2AbDIY
 DfKQbSujSbgraALCsIpptPMkxiW3ifovZJ2J3cdo5Vb8hFtW+m1Z1A3lNOl6DL/W+Woz
 IOXQ==
X-Gm-Message-State: AOJu0Yyg7/BNVvXMeqjm2LT2kjUxjXT5QNJMFvQJZS0xEZqjyyEG0uLu
 rggEtavIeGmKsLs7DkCcguWETWTfg0e6Wby3Qwe4bUPfqxE4o3IxcfEdDMqvcN3Dnjs9GskWDDS
 h
X-Google-Smtp-Source: AGHT+IFK4UBXJJVnjpWSMD0bLcXKbi7ALqvMaZ9DpMuFJq6VaP+d7VLPXwUMJjwF5mYxJaws6qr8dQ==
X-Received: by 2002:a17:907:6e8d:b0:a6f:4bf2:daa2 with SMTP id
 a640c23a62f3a-a77ba45177amr397396866b.15.1720193844015; 
 Fri, 05 Jul 2024 08:37:24 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77ccee5277sm61679766b.177.2024.07.05.08.37.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:37:21 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A283D6217D;
 Fri,  5 Jul 2024 16:30:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 38/40] gdbstub: Use true to set cmd_startswith
Date: Fri,  5 Jul 2024 16:30:50 +0100
Message-Id: <20240705153052.1219696-39-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-39-alex.bennee@linaro.org>

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


