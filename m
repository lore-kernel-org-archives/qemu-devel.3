Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5754C3601B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 19:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Q0d-0005FX-CH; Thu, 03 Apr 2025 15:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dominik.b.czarnota@gmail.com>)
 id 1u0Q0b-0005FD-5L
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 15:13:50 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dominik.b.czarnota@gmail.com>)
 id 1u0Q0Y-0001pz-UX
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 15:13:48 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ac345bd8e13so208451766b.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 12:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743707624; x=1744312424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gYlqM+2ohIBKDbf4n/yezGPD8nTmC4pswZRG7zg8r/k=;
 b=LgRpCbcZDUgceJnYiMRF88Q+qjR4EqgwGVBDqVdDnYatnOYDDz1bs2H50stZiJpCuL
 hbbplNjR9n6KYtxabkurRaf8syxgmo/YzwZzBmcUknUCUrulb0EqxpXcX4ZthQGLR2nR
 LecLif/Qz1hzBf8RTDmgdlVWOjCafHVTRaTy8aX0LCxIHAPJMl9FJIvUnUQQNNYlkLAb
 KMTcIzGhVsov2WOzbIx0r22Id2JvpqJy5/JdW2+ur2LYMtRgAuRc35gqVRAnxphIDHPy
 m80zQK7Q5dQJw5mgYgqieZp6EN8bCqtIZEp4Hyv723foPtNLC5qjl5ktZ6fCmEgKnSFw
 8CoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743707624; x=1744312424;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gYlqM+2ohIBKDbf4n/yezGPD8nTmC4pswZRG7zg8r/k=;
 b=IExn6l9vPxvsILvSJ5ayVjiFJjCCmFiCq03eKy0jfPvd6zfCnTvTb0suo8y5TLGEFP
 oLDu1ozjVyRZsp2CEwlPx+EQJPP3Vn1EfKJLX+p+N14qIPUw+ef3GLT4xA98f4h0Qb3q
 ceZcOleDAMKnPd3c4RGzM6hr02w297BnO3uQvyLeHMgnVpbOW2tZjtQnDbeC6nS1f/cs
 nTa7MGu2VmO7tcrRf2CfJA2Qt26akJe2glibWW3W1AkU9wJNedGmAIvuHkXCgAPmwBzv
 LU6GMSRz+sOJ65Ob4CJlpU0itd12HaePVOlxLmqMHFoAK/UQWGtjYELHrfH1NtFsqAL/
 L80Q==
X-Gm-Message-State: AOJu0Ywm5jx6yWCxhaSJbezKhG4kL269eQF3WD9bRv3B/Pq4tKkHrd9l
 raRytTUjEFmAdekG3VeSmQdEUb3PjC5SmLi2rEOnxs1+/yES1P28Rr5qJFIKH7E=
X-Gm-Gg: ASbGncsm485GZtq7YZtTg9LyAY7ME9KLYovmVu08loMZSwQpSmAKK4y5khlzdn2cGbw
 iVUJ5AEgo8JBaFOz9xkyIfXprnCT2gLC/LXB+bkhsYOkK3O796IXCY9Y3d5yThR0qO9H6D3O8bS
 Z+w2UNEg7BfMtAqSItmA0U2EmdE731GlAAKGfJSpA9naGkT7L3suJ1y7rhlFWic2GVW3iLOl9E2
 HY/L7Ln7tCCMEVZmibHyugdT2zes+C06bQHvieq3QizknUCrrJ+Q6rsvjvWMeuJM9NXLOFlOFsd
 3AwWqzLFarOX926ASH7T3ueX054QEheZKSXbgPEtotww/SHM0xEr3cm0TSi5JoXEBew7C/tlOC0
 9DU8=
X-Google-Smtp-Source: AGHT+IFTzoZCS4098ZwiT9zeQBsVrUthmZE5vle+srStk33ZazxI6RskfsOiI40wFT24+KE65AMbBg==
X-Received: by 2002:a17:907:971d:b0:ac7:3918:752e with SMTP id
 a640c23a62f3a-ac7d19a15fdmr58271066b.59.1743707624245; 
 Thu, 03 Apr 2025 12:13:44 -0700 (PDT)
Received: from localhost.localdomain ([84.40.153.146])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfe99b3bsm135962866b.51.2025.04.03.12.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 12:13:43 -0700 (PDT)
From: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, gustavo.romero@linaro.org,
 richard.henderson@linaro.org, philmd@linaro.org,
 manos.pitsidianakis@linaro.org,
 Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>,
 Patryk 'patryk4815' Sondej <patryk.sondej@gmail.com>
Subject: [PATCH] gdbstub: Implement qGDBServerVersion packet
Date: Thu,  3 Apr 2025 21:13:40 +0200
Message-Id: <20250403191340.53343-1-dominik.b.czarnota@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=dominik.b.czarnota@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This commit adds support for the `qGDBServerVersion` packet to the qemu
gdbstub  which could be used by clients to detect the QEMU version
(and, e.g., use a workaround for known bugs).

This packet is not documented/standarized by GDB but it was implemented
by LLDB gdbstub [0] and is helpful for projects like Pwndbg [1].

This has been implemented by Patryk, who I included in Co-authored-by
and who asked me to send the patch.

[0] https://lldb.llvm.org/resources/lldbgdbremote.html#qgdbserverversion
[1] https://github.com/pwndbg/pwndbg/issues/2648

Co-authored-by: Patryk 'patryk4815' Sondej <patryk.sondej@gmail.com>
Signed-off-by: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
---
 gdbstub/gdbstub.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 282e13e163..8d616a7f52 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1582,6 +1582,16 @@ static void handle_query_threads(GArray *params, void *user_ctx)
     gdbserver_state.query_cpu = gdb_next_attached_cpu(gdbserver_state.query_cpu);
 }
 
+static void handle_query_gdb_server_version(GArray *params, void *user_ctx)
+{
+#if defined(CONFIG_USER_ONLY)
+    g_string_printf(gdbserver_state.str_buf, "name:qemu-%s;version:%s;", target_name(), QEMU_VERSION);
+#else
+    g_string_printf(gdbserver_state.str_buf, "name:qemu-system-%s;version:%s;", target_name(), QEMU_VERSION);
+#endif
+    gdb_put_strbuf();
+}
+
 static void handle_query_first_threads(GArray *params, void *user_ctx)
 {
     gdbserver_state.query_cpu = gdb_first_attached_cpu();
@@ -1827,6 +1837,10 @@ static const GdbCmdParseEntry gdb_gen_query_table[] = {
         .handler = handle_query_threads,
         .cmd = "sThreadInfo",
     },
+    {
+        .handler = handle_query_gdb_server_version,
+        .cmd = "GDBServerVersion",
+    },
     {
         .handler = handle_query_first_threads,
         .cmd = "fThreadInfo",
-- 
2.30.2


