Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAE0C3DA41
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPku5-0005lT-MW; Fri, 05 Jul 2024 11:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPku4-0005kK-7l
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:16 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPkty-0000Rs-9X
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:15 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a77b550128dso227621066b.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193467; x=1720798267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QehyRM+GTwCmdsI3rONPQxQARmvRAp8NK6kIeDY+sDQ=;
 b=Ool1+wKjSguZSqZldgEQlGRknT9iUHGJIr9DzxKRCyOvQu2YyaU9P6civf5AAgRhbO
 9O3X7zMVp3/vxrAaFPr32hGOdtcoHmUBcjV9986AeEmZvLXXQH6h+suRoH+iQb8Sl4/Y
 vb5glPgzN1dUL5X/ZBerrEx44FLaWwLfskiescsa2i3i8m1s5Xk4ZUImTrbjhlpEZhaA
 nifeFyG7U0vEPX0IWxwEfTIgWPogYJSwmGXgrSxW66ADhwHdwte4nrfd5KQY+z+r53zK
 PXmcXX5hUOWV/xReLhCm3LYckpjvmIVMDlVgBoCApZnAQa6AR7UHmXMWU/I/FG8XDFE0
 HJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193467; x=1720798267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QehyRM+GTwCmdsI3rONPQxQARmvRAp8NK6kIeDY+sDQ=;
 b=Xs/IC3wp9NzzlmnG+dnGe0N8dsP0vFCVIlv+9MbITDNdvG3rwZcF8unnQ5DJarYDUM
 Shh0jUfk31FUMRz3XRIXVnoxZ+v5Xam0hm8jo/Z6Z6Yh2a+QTI5QbXWvxLKkiSGY8V5Z
 zmBYIOxain8I37heGCpwcGtCimLM8Z9uXStPtbllHUmcJDaUsaZdR0STDiuTq3/Nx/EB
 Use4UWuwJSWkJQW65E+uv/y8fe2nNlL26vkenzgJLB57uH0Jf9FBjZbeE4f4DuROkFE/
 3MkV89vrzdP3b1G8jnzPjC7N1mqJQs66POriArWwp6S0RHXmdUBKYdKYE/UIfZPPYRsV
 3ztA==
X-Gm-Message-State: AOJu0YyNfD60jm3vtGCiTjA99Qma9u8XP1wAo9nunsh9DXu5dESPzsT9
 B/8U8EzC/RtWsPrhXDsQWG4qmDcOcS7FAJ5sHB0B2I8yLK/huHPMO/G+0Gs+TRQ=
X-Google-Smtp-Source: AGHT+IGcck61umbUMgfe961N6IIg4yjJj2DtEGXEMLtQ9OLREDmuWyEpzZEwcIQC+YSes7UQ3S+c2A==
X-Received: by 2002:a17:906:4794:b0:a75:3cd2:aaab with SMTP id
 a640c23a62f3a-a77ba455290mr397533666b.3.1720193467111; 
 Fri, 05 Jul 2024 08:31:07 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77da27c044sm33109966b.157.2024.07.05.08.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:31:04 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8C6CB62177;
 Fri,  5 Jul 2024 16:30:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 37/40] gdbstub: Pass CPU context to command handler
Date: Fri,  5 Jul 2024 16:30:49 +0100
Message-Id: <20240705153052.1219696-38-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
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

Allow passing the current CPU context to command handlers via user_ctx
when the handler requires it.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-Id: <20240628050850.536447-9-gustavo.romero@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-38-alex.bennee@linaro.org>

diff --git a/include/gdbstub/commands.h b/include/gdbstub/commands.h
index e51f276b40..f3058f9dda 100644
--- a/include/gdbstub/commands.h
+++ b/include/gdbstub/commands.h
@@ -54,6 +54,8 @@ typedef union GdbCmdVariant {
  * "stop reply" packet. The list of commands that accept such response is
  * defined at the GDB Remote Serial Protocol documentation. See:
  * https://sourceware.org/gdb/onlinedocs/gdb/Stop-Reply-Packets.html#Stop-Reply-Packets.
+ *
+ * @need_cpu_context: Pass current CPU context to command handler via user_ctx.
  */
 typedef struct GdbCmdParseEntry {
     GdbCmdHandler handler;
@@ -61,6 +63,7 @@ typedef struct GdbCmdParseEntry {
     bool cmd_startswith;
     const char *schema;
     bool allow_stop_reply;
+    bool need_cpu_context;
 } GdbCmdParseEntry;
 
 /**
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index b1ca253f97..5c1612ed2a 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -938,6 +938,7 @@ static bool process_string_cmd(const char *data,
 
     for (i = 0; i < num_cmds; i++) {
         const GdbCmdParseEntry *cmd = &cmds[i];
+        void *user_ctx = NULL;
         g_assert(cmd->handler && cmd->cmd);
 
         if ((cmd->cmd_startswith && !startswith(data, cmd->cmd)) ||
@@ -952,8 +953,12 @@ static bool process_string_cmd(const char *data,
             }
         }
 
+        if (cmd->need_cpu_context) {
+            user_ctx = (void *)gdbserver_state.g_cpu;
+        }
+
         gdbserver_state.allow_stop_reply = cmd->allow_stop_reply;
-        cmd->handler(params, NULL);
+        cmd->handler(params, user_ctx);
         return true;
     }
 
-- 
2.39.2


