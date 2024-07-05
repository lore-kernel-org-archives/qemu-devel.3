Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EAFC3271F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPebK-0000vV-Rg; Fri, 05 Jul 2024 04:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPebG-0000tl-Td
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:47:27 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeb3-0004Ax-OI
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:47:26 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-58b966b4166so1702972a12.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720169232; x=1720774032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JoliEJsSzkKhZQwY3f6Epel/jCgNkpeyE6ZHVJ+pXJo=;
 b=Qvi2a9XjpxLe5AkyUofn6/LikWpfyagKI2mRbm40T+GS1gFCTMTdMgOyqo1AA9ydVP
 TbCfsDJ41dylcx+WGxPCbh7pUA72WPa5bpwoq7mxiuT551yZ/+oo2w9FwzQV2ZLb8jEJ
 S05s7reCIgFIgRKICG0DFYhfr/B3jZyFBjV+NqklnBc+Q0qIGaD1uQe88EMk3PL3/r4N
 XuLYnfESkOYhJzlNErEBwEToWjdhsLLYZ35mm+VOFofFMiPglrQx4+mfpvbHdHbF4Boy
 +0NvRmrEbHGQLVcA6IJcaGBWHA41sWRU6x2+FbDNPqyhKb3WClXFTxppRlxeGBVDe8bJ
 xseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720169232; x=1720774032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JoliEJsSzkKhZQwY3f6Epel/jCgNkpeyE6ZHVJ+pXJo=;
 b=sq+BzcHXwCL9S5d4t8addtNZzcW8Pkt3CkAFqErmz00w75rBSoBnGcX14sUG096/en
 tsWsIvaLxwi0CZc+ED9wgZ61xfarFQsgvFzmubBt7pgS+FYmxHkSkHeyzTkOophxtoWS
 kzEZShoNZHnIqO7QdKMdMPvUtcSODH4nDMposODDrp1bHDDApIQlfROtpvhOwfkqPzh+
 R7inbuHMpLyzRsWscbZvOqEQQ7QEFJ9+dpX475CcuIkDYBCNR4bb48wNca6n00RzWFdM
 wMO/Drotl1qfQSl+wDJYBpQ9UrjNrOa5N++GgDGActZ2ctyC3XTekKSlX/s9528uYafW
 oSog==
X-Gm-Message-State: AOJu0YzTOJ/GBSG/D2Tm8w/ndSXPt+UHnKQHRs8uq875nzpsQtHmFWni
 M5xL09EavA6uhbnNSz3I33tsTGDykYzOMsbNuE+wCYowxlU3XCE1lX9yE80g5dA=
X-Google-Smtp-Source: AGHT+IF5VPLchM8xkt4tOfpWY9w6IdBRhKtzuufLUL6EXMGsg8G6JvkrPJpaKA75LaO44V8otM3+gA==
X-Received: by 2002:a05:6402:17c4:b0:585:3a33:9de0 with SMTP id
 4fb4d7f45d1cf-58e5aecb62cmr2266271a12.26.1720169231829; 
 Fri, 05 Jul 2024 01:47:11 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58f9d3f11ffsm573363a12.67.2024.07.05.01.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:47:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5527F6217D;
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
Subject: [PATCH v2 37/40] gdbstub: Pass CPU context to command handler
Date: Fri,  5 Jul 2024 09:40:44 +0100
Message-Id: <20240705084047.857176-38-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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


