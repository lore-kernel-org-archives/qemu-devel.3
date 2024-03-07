Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F191C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 18:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riISd-0001DQ-TT; Thu, 07 Mar 2024 13:27:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1riISc-0001DF-AW
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 13:27:18 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1riISa-0000c4-QB
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 13:27:18 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1dc96f64c10so9846065ad.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 10:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709836034; x=1710440834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1J82rSzajf0utMtQj7GKwdIJ1FdozcoqFW6lAvgBRhQ=;
 b=QUexHbdV1wdtv7uCUBTYyxayRa4ROypRl26nyLk8hVVasWw785NWfg0tYA4T7QXFOb
 R6Uxx2XDX4PxAF/n6plSal+gBHYyJjLYtlgoRkN4/LcqPu2xvqvoG1dBTazoqDupmakS
 J9gZFBKZSraZO+1ST8A4/ts85aiK5yjwoCCUyfDdINZojJX1Bt6fTXuSlm8vYCLwofoM
 ssp2qFkyOIxOnBKmW1FkwGRbUWnGCZsYxtF0fp/wPWe2PVRzE0QCVcni27LpnFw7BnE4
 tZ9T3FxaQwxy5AglP/uG+N8gOGwiI1q3xkl1GzPtiL9+wAJftahKjyultxrP34cqlSnT
 zViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709836034; x=1710440834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1J82rSzajf0utMtQj7GKwdIJ1FdozcoqFW6lAvgBRhQ=;
 b=c+YPxJ3SkYMLjpZ4BRt/U9zm8qc7v8o8fwoA3ls49+2+MKLzRjqrgviT8WIe8PQ7pB
 UEVY8kN1S7qKCP9ubKFO9zqDGeaabQ0oDi2z7/O9dHoSG0r89c2gq6RzaTzhygw6ykWq
 AUC5xZOu2CKMvZfCSvAjUnu25aE5DDPK9LMLvaFmUsIrkKsugiyi5zSda+8lNFP/vSB7
 g+g8QajQUtp9u1GReyux/zKlsSxmZs6l5tOzVo/yllSOT6SIibHUUUqJjJYqEeyHFK7Q
 12s+UmwG8d1iZUCd1eS9mobrSfXkW12N7a5EjmRc5C3U2a3oULrKcgnryiqjxNfYYB/l
 dI3Q==
X-Gm-Message-State: AOJu0Yyo2FkZCZQs21vrmE8v3ki/Xq7wMiXHawNooCB8s0qUy1Mi1enP
 o4fSEkUUV/TRAWVsAwnuPOiB3TYFC1t727pB0CgoIc0KQfCoTvr98Hwiusf+4D9N4Pw05cAu2bG
 yIDE=
X-Google-Smtp-Source: AGHT+IEKUWSrEuDQvP16mlKP3XOvHW+v4L1nSFtpagMohqv5SJDiyPdFU5AvTs5PN8biqMJMcEE1Mw==
X-Received: by 2002:a17:902:9009:b0:1db:f965:470d with SMTP id
 a9-20020a170902900900b001dbf965470dmr8035885plp.24.1709836033942; 
 Thu, 07 Mar 2024 10:27:13 -0800 (PST)
Received: from amd.. ([2804:7f0:b401:120f:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 mm12-20020a1709030a0c00b001dc96d1a662sm14939068plb.197.2024.03.07.10.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 10:27:13 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu,
 philmd@linaro.org, gustavo.romero@linaro.org
Subject: [PATCH v2 4/5] gdbstub: Add Xfer:siginfo:read stub
Date: Thu,  7 Mar 2024 18:26:22 +0000
Message-Id: <20240307182623.1450717-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307182623.1450717-1-gustavo.romero@linaro.org>
References: <20240307182623.1450717-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x636.google.com
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

Add stub to handle Xfer:siginfo:read packet query that requests the
machine's siginfo data.

This is used when GDB user executes 'print $_siginfo' and when the
machine stops due to a signal, for instance, on SIGSEGV. The information
in siginfo allows GDB to determiner further details on the signal, like
the fault address/insn when the SIGSEGV is caught.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 gdbstub/gdbstub.c     |  8 ++++++++
 gdbstub/internals.h   |  1 +
 gdbstub/user-target.c | 23 +++++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 2909bc8c69..ab38cea46b 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1651,6 +1651,8 @@ static void handle_query_supported(GArray *params, void *user_ctx)
         g_string_append(gdbserver_state.str_buf, ";qXfer:auxv:read+");
     }
     g_string_append(gdbserver_state.str_buf, ";QCatchSyscalls+");
+
+    g_string_append(gdbserver_state.str_buf, ";qXfer:siginfo:read+");
 #endif
     g_string_append(gdbserver_state.str_buf, ";qXfer:exec-file:read+");
 #endif
@@ -1799,6 +1801,12 @@ static const GdbCmdParseEntry gdb_gen_query_table[] = {
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
diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index a7cc69dab3..15c01c525a 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -193,6 +193,7 @@ typedef union GdbCmdVariant {
 void gdb_handle_query_rcmd(GArray *params, void *user_ctx); /* softmmu */
 void gdb_handle_query_offsets(GArray *params, void *user_ctx); /* user */
 void gdb_handle_query_xfer_auxv(GArray *params, void *user_ctx); /*user */
+void gdb_handle_query_xfer_siginfo(GArray *params, void *user_ctx); /*user */
 void gdb_handle_v_file_open(GArray *params, void *user_ctx); /* user */
 void gdb_handle_v_file_close(GArray *params, void *user_ctx); /* user */
 void gdb_handle_v_file_pread(GArray *params, void *user_ctx); /* user */
diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c
index 215bf33ab3..93739852b0 100644
--- a/gdbstub/user-target.c
+++ b/gdbstub/user-target.c
@@ -285,6 +285,29 @@ void gdb_handle_query_xfer_auxv(GArray *params, void *user_ctx)
     gdb_put_packet_binary(gdbserver_state.str_buf->str,
                       gdbserver_state.str_buf->len, true);
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
+    if (offset + len > sizeof(target_siginfo_t)) {
+        /* Invalid offset and/or requested length. */
+        gdb_put_packet("E01");
+        return;
+    }
+
+    siginfo_offset = (uint8_t *)gdbserver_state.siginfo + offset;
+
+    /* Reply */
+    g_string_assign(gdbserver_state.str_buf, "l");
+    gdb_memtox(gdbserver_state.str_buf, (const char *)siginfo_offset, len);
+    gdb_put_packet_binary(gdbserver_state.str_buf->str,
+                          gdbserver_state.str_buf->len, true);
+}
 #endif
 
 static const char *get_filename_param(GArray *params, int i)
-- 
2.34.1


