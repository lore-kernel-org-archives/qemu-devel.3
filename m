Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854ADC5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 16:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNDYe-0001lR-4y; Thu, 05 Jun 2025 12:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDYZ-0001iJ-9J
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:35:07 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDYX-0001xm-9X
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:35:07 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ad55d6aeb07so231206266b.0
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 09:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749141302; x=1749746102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fx+h3SENZYZcIW0j7iWtLqNsUxD93YY5SPZuT4qG2WE=;
 b=zZJKRzAAPN5nr3zqJH5Ugp+Z193i38dxDLpXfN/lmlq9kr7dMglkfAKgftVbLnOpBF
 q1W5VzoO1QbLUrPPy8uEb164jpwdTjf9jTBpCXjVMcq5CoOF0Y02WtxLtimk+W7YXHQP
 YdSHGxftvHd2pGwGQnupYnxlzdchHAUbrm4XUeNMLu91z3rJbat9JjzpPM+g7T1gO4HE
 JaSv4Fk3cIE4A3c/JL3XaTc/ywJH0Vc9r1UQYgFd0wA8Sbaab3eK+1UwRFpTMzHZqKSL
 c0iAd7TxvvmAn9iyK2P7/loazOPao8ue007DoJ8jKDXC9raDBZDp2C2j8olaX/Zswm3M
 TSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749141302; x=1749746102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fx+h3SENZYZcIW0j7iWtLqNsUxD93YY5SPZuT4qG2WE=;
 b=qR5/I/ss2H8xGRmLn06Dedk9pFOr/nA7MyF6SiWvuTt1pSUpLYmepg/cT9O/W0QyF/
 BptOGv0E67UqB+BNbr9MO8PQV7PaV6a/3WrVrhQanV+4ZD5w4vmovXVoB/+TTg/tfJa/
 AZlw2N1cw8QHvda447AXjwLwwvAXIdhp8y4P05ZhM7NM/aZxLAEb/6RCTqOkFfczKj3f
 Qp6JfmxV39B7fLXzeASY+Ozl5g7xBCLf3JaLoYSEsDSVfNG6qGIC0W6TxWmu3uVVsL0R
 3Rtrtffjq7fUy745iv92yttmal/z7qZ+1NiRJB+5AtcCtNrz79xECWfA4C46hWyMMi0p
 mVvw==
X-Gm-Message-State: AOJu0YyZV4wom33CXyIfLtqLTYBsq8HJdkoTB8deXn5lOPfXp33gJBQf
 lYb142p0a6KAYkJn9XnDPFat8cIuavZowjH3wF5O4MCF8LrjVFvtaolQh1aIYAac/t0=
X-Gm-Gg: ASbGnctwQdJLVmXpCwFk1NRtAsQtVTaz4SIvxgrKecpVtTG0cKHews5r36K7Ucj1TWO
 K/TgKXs8x4lwWBJEOublUKJV5/qchAkPcLuaPk0Gc8AjdSPEMw+LPMNcCrhjFE3R5cNT8OxsfcW
 joThto8tEd46cramUQz9lX7WcXc3lSEzYSyK9GzuyWatSbsmuYz0m/XFoABp58Cq0/87ALT386p
 FBF7eO0f3As5bz49i+VAoJekD5KCbEV0fhL3987rwvQXW+p8SAtfkxVBn0+i+m6GksCY6XfURac
 tlErvPHiOTshV0UKD8nwp4c53ny6fb7/UcRsUAfYQB7Mq/TKrogV
X-Google-Smtp-Source: AGHT+IFOBwj7p0eclQBemWtGplgkdZCMD0ofYYJrG+mgEOSnew5Hs17S1TSTGJzg5nb9QaVgbAMzMQ==
X-Received: by 2002:a17:907:7f8b:b0:ad5:1c28:3c4b with SMTP id
 a640c23a62f3a-addf8fac686mr721005666b.52.1749141302469; 
 Thu, 05 Jun 2025 09:35:02 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adb35af4456sm1079335766b.182.2025.06.05.09.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 09:35:01 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D99BB5F833;
 Thu, 05 Jun 2025 17:26:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>,
 Patryk 'patryk4815' Sondej <patryk.sondej@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/17] gdbstub: Implement qGDBServerVersion packet
Date: Thu,  5 Jun 2025 17:26:49 +0100
Message-ID: <20250605162651.2614401-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250605162651.2614401-1-alex.bennee@linaro.org>
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>

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
Message-Id: <20250403191340.53343-1-dominik.b.czarnota@gmail.com>
[AJB: fix include, checkpatch linewrap]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250603110204.838117-17-alex.bennee@linaro.org>

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 6023c80d25..def0b7e877 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -28,6 +28,7 @@
 #include "qemu/cutils.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
+#include "qemu/target-info.h"
 #include "trace.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/commands.h"
@@ -1597,6 +1598,18 @@ static void handle_query_threads(GArray *params, void *user_ctx)
     gdbserver_state.query_cpu = gdb_next_attached_cpu(gdbserver_state.query_cpu);
 }
 
+static void handle_query_gdb_server_version(GArray *params, void *user_ctx)
+{
+#if defined(CONFIG_USER_ONLY)
+    g_string_printf(gdbserver_state.str_buf, "name:qemu-%s;version:%s;",
+                    target_name(), QEMU_VERSION);
+#else
+    g_string_printf(gdbserver_state.str_buf, "name:qemu-system-%s;version:%s;",
+                    target_name(), QEMU_VERSION);
+#endif
+    gdb_put_strbuf();
+}
+
 static void handle_query_first_threads(GArray *params, void *user_ctx)
 {
     gdbserver_state.query_cpu = gdb_first_attached_cpu();
@@ -1842,6 +1855,10 @@ static const GdbCmdParseEntry gdb_gen_query_table[] = {
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
2.47.2


