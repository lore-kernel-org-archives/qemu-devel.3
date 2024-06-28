Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68057C3065B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 12:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNB5A-0002nx-CU; Fri, 28 Jun 2024 08:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNB56-0002lJ-Qe
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:52:00 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNB54-0007jM-V3
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:52:00 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a725d756d41so100776166b.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 05:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719579117; x=1720183917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JoliEJsSzkKhZQwY3f6Epel/jCgNkpeyE6ZHVJ+pXJo=;
 b=XMQTeEOWPLugiUvX2quflz//TwR2majA2URfNdIlB2CaP96pUj713uOhYRnwxL5Fav
 cb9MHmbTMNOlYEGpGpSY/wswD0VjWkryJLi/SJe9CimulHEyk6e0Uw+H9wHHM7Suv4L0
 WuiYl+d6C/samdXsdObtHzPx3C5o++pvZwQNRBFEQhle+6s0ArwDt6+gIAI+pZIWgkp5
 WZMFCgfWYTW8RoRoXot171SCp4rj5e4h+ac91fFGK8lVhLTOTrFzMwz70JnjwJwo9Bf6
 oqEpmYIy7IWma08NuTJHrt8iHno9NfMlDZkFXi3Si8cEagSUKd3kKWR18pfnUP94EOum
 Vabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719579117; x=1720183917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JoliEJsSzkKhZQwY3f6Epel/jCgNkpeyE6ZHVJ+pXJo=;
 b=JkKr587oFAjjQSLb1fS5Y+1FC5dhc/HcwYr+1vFf2MxgThRQwvHdueez0+UowF6aWc
 GJo8lgZ9GAch/WpNq+e7sm6IffS6wDgkUv3L0YAehs3ZxZx0Ea1eZHjr34PHWQcjk+3m
 HNueMyUrICJkqrmMdltsVOA5mKucw8ywnZamCyJb0TZF3Zh99Q1G9BJZEBal9jErEC1j
 KDYtf4FG/49rZHMuSgfG2vYR4nqxd0HyYfvZlVazX+++YhufoM2O91g1absJYUE+kvLB
 Md4CSWEqow9eDA0sHg0akq3/pxIo/vmaehwL6mCF6ctoyaKZM4xqSk/7jE+ta/Iej5kC
 pbRw==
X-Gm-Message-State: AOJu0Ywa/5laGQwQTnZ0vxqbxKbGL7Y+MqL90pV9McuVFkBMnwj5sdPt
 VJq58n5G2t/yHyQHqeQjCUJYnSoAODxB7hm9yfJxooFV0QhbN9FgDvRcdWO1KWM=
X-Google-Smtp-Source: AGHT+IHML+4LeuY6guOPxLx7IJNY+hNPKhVXQYBOR4qRcH8m2ZvVdkSAAzfpmndTSCeeB3/OIGh4wg==
X-Received: by 2002:a17:906:46d2:b0:a72:7bc0:efed with SMTP id
 a640c23a62f3a-a72aee8c5ecmr120955066b.13.1719579116902; 
 Fri, 28 Jun 2024 05:51:56 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0900e6sm76137866b.181.2024.06.28.05.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 05:51:56 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E3A665FA3F;
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
Subject: [PATCH 20/23] gdbstub: Pass CPU context to command handler
Date: Fri, 28 Jun 2024 13:42:55 +0100
Message-Id: <20240628124258.832466-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240628124258.832466-1-alex.bennee@linaro.org>
References: <20240628124258.832466-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240628050850.536447-9-gustavo.romero@linaro.org>
---
 include/gdbstub/commands.h | 3 +++
 gdbstub/gdbstub.c          | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

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


