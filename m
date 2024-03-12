Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD364C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0GX-0002yU-3C; Tue, 12 Mar 2024 07:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk0GS-0002vy-Pt
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:25:48 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk0GL-0000lC-Qo
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:25:45 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41329a665d8so15408825e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 04:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710242738; x=1710847538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JghslLQsXVIk5PSECh3p0uuw1fQ6K0uFHf3q1DuTSXA=;
 b=or6ziAC3VtY9LPM0xv/0n/RHsLCBK9ix7GVtYswtwLwYxje4QZeJ6w0VZ/Ui0XWBfJ
 r2huwQ8klCcAtwsuMv2utpWnOsb16EBIQ4ewvcNhJ1gOCkaYrskJg1blwE+SCN04HS64
 wuE8OiT5uWuvRUIRzkIlGH3vbIPHtGNREqWxE8JQSnoFWgomjEjDywNzNXWE5g5qslmh
 Nxt9OS6y17AQRgc8dJt2sVUsR4wKCf9JFZ+IKJfcPWdFFMrGmioIrvX8qtS0an/r3bbu
 I+bvrsuoK9SFqws7Mj7rXmteiEgPdSPXgyfVoFBcgQHzhb5qlXIJ0IuWRasYhHisvrSE
 L3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710242738; x=1710847538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JghslLQsXVIk5PSECh3p0uuw1fQ6K0uFHf3q1DuTSXA=;
 b=wDjKcAIjb6r9KDqBpOifT1DjFDmSIzs9MYkyoq3ixrTImXG2+5dXzOD+fi5SJZCqAY
 d503inOCSq9S1yNvAhIFPFahuM9neQfO06xGpftei9CfhOVsnQf4n3AkCut7VQ48q+g4
 PC0rilCs80tNHzQfV7StFrDiE63BQSUAlMdML+F2mCEdc3icEGqKBYX9Oid5OgcUljvY
 j/fGxjdsjmL6i0usQUjPS8QDprHLoml/nNv1YvdXKxh09WsqZANPaHPB7K0YjxOhcU3v
 OMoAadmHKXnhgd/H+uUh/H4JbYup3pyPGAJQeKsknmNK4K3fCg2ggZCTdNysa3k31iaf
 oT5w==
X-Gm-Message-State: AOJu0YzMd+LCsqNAN3DwdvyqYpQK6ZUNq2IiUmdIYXc5LGMYe9/wzWE2
 m3KwhqbKNFIwRn4VL+0qDn5qo+Okk5wmPjWhrnriFPVvuRdRrYmXOU3sly2xOcE=
X-Google-Smtp-Source: AGHT+IHUO8aCL1zgoaFD111TltxI0L6mWf0P3hu/YoxwiS6z+MbuhMkDMJUt+Kan4sWx4EHVftKoNw==
X-Received: by 2002:a05:600c:1f81:b0:413:1dcd:b39 with SMTP id
 je1-20020a05600c1f8100b004131dcd0b39mr6894975wmb.38.1710242738307; 
 Tue, 12 Mar 2024 04:25:38 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h12-20020a05600c350c00b0041312d21a35sm16982948wmq.7.2024.03.12.04.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 04:25:36 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3F7C65F8E1;
 Tue, 12 Mar 2024 11:25:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 6/8] gdbstub: Add Xfer:siginfo:read stub
Date: Tue, 12 Mar 2024 11:25:30 +0000
Message-Id: <20240312112532.1558319-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240312112532.1558319-1-alex.bennee@linaro.org>
References: <20240312112532.1558319-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Add stub to handle Xfer:siginfo:read packet query that requests the
machine's siginfo data.

This is used when GDB user executes 'print $_siginfo' and when the
machine stops due to a signal, for instance, on SIGSEGV. The information
in siginfo allows GDB to determiner further details on the signal, like
the fault address/insn when the SIGSEGV is caught.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-Id: <20240309030901.1726211-5-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index b472459838..e83b179920 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -190,6 +190,7 @@ typedef union GdbCmdVariant {
 void gdb_handle_query_rcmd(GArray *params, void *user_ctx); /* softmmu */
 void gdb_handle_query_offsets(GArray *params, void *user_ctx); /* user */
 void gdb_handle_query_xfer_auxv(GArray *params, void *user_ctx); /*user */
+void gdb_handle_query_xfer_siginfo(GArray *params, void *user_ctx); /*user */
 void gdb_handle_v_file_open(GArray *params, void *user_ctx); /* user */
 void gdb_handle_v_file_close(GArray *params, void *user_ctx); /* user */
 void gdb_handle_v_file_pread(GArray *params, void *user_ctx); /* user */
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 17efcae0d0..9c23d44baf 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1664,6 +1664,8 @@ static void handle_query_supported(GArray *params, void *user_ctx)
         g_string_append(gdbserver_state.str_buf, ";qXfer:auxv:read+");
     }
     g_string_append(gdbserver_state.str_buf, ";QCatchSyscalls+");
+
+    g_string_append(gdbserver_state.str_buf, ";qXfer:siginfo:read+");
 #endif
     g_string_append(gdbserver_state.str_buf, ";qXfer:exec-file:read+");
 #endif
@@ -1818,6 +1820,12 @@ static const GdbCmdParseEntry gdb_gen_query_table[] = {
         .cmd_startswith = 1,
         .schema = "l,l0"
     },
+    {
+        .handler = gdb_handle_query_xfer_siginfo,
+        .cmd = "Xfer:siginfo:read::",
+        .cmd_startswith = 1,
+        .schema = "l,l0"
+     },
 #endif
     {
         .handler = gdb_handle_query_xfer_exec_file,
diff --git a/gdbstub/user.c b/gdbstub/user.c
index cf693bfbc4..2005f3312b 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -852,3 +852,26 @@ void gdb_handle_set_catch_syscalls(GArray *params, void *user_ctx)
 err:
     gdb_put_packet("E00");
 }
+
+void gdb_handle_query_xfer_siginfo(GArray *params, void *user_ctx)
+{
+    unsigned long offset, len;
+    uint8_t *siginfo_offset;
+
+    offset = get_param(params, 0)->val_ul;
+    len = get_param(params, 1)->val_ul;
+
+    if (offset + len > gdbserver_user_state.siginfo_len) {
+        /* Invalid offset and/or requested length. */
+        gdb_put_packet("E01");
+        return;
+    }
+
+    siginfo_offset = (uint8_t *)gdbserver_user_state.siginfo + offset;
+
+    /* Reply */
+    g_string_assign(gdbserver_state.str_buf, "l");
+    gdb_memtox(gdbserver_state.str_buf, (const char *)siginfo_offset, len);
+    gdb_put_packet_binary(gdbserver_state.str_buf->str,
+                          gdbserver_state.str_buf->len, true);
+}
-- 
2.39.2


