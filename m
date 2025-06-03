Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B95C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMPSm-0003iE-Vz; Tue, 03 Jun 2025 07:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPR-00085H-JJ
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:21 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPN-0002Dk-1R
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:21 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6055f106811so7817153a12.0
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748948535; x=1749553335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N+3L2/wLcre7jg5dlEKP9ZB3nWCswz5e9AJ/LdiDVCw=;
 b=ZqnuYYJabNaNav2+vUFbs0PkSlIZ45zOhJoomJ9psXCkgtAK6qe8QgnJarqNcFFu91
 rX06Uy9spityhryswdVOVt3hTIbRA4vTxIQUbilKBORagbNkOyFb6/5NcqIq6JnueOkt
 Rag50yeRdWwrMpTZ/pIMKmmGnaLk0jby2qh02Dw+ljNvexa7gFVKgQ61l3KR53XJeEaM
 IMUDYs9ZlGbIqf1iXUwNeQSUodPb+068JAicy3lrTRkmQGYbZc2WbiXhR5paw9CuIS10
 MuBvFvGj1P+AojrQKLFauNC0CD37/Q9VGUdSfPWDWKMKUcHHshP53VycOwiiDpOd0BiT
 V4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748948535; x=1749553335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N+3L2/wLcre7jg5dlEKP9ZB3nWCswz5e9AJ/LdiDVCw=;
 b=MJjxYy+XdxV0Gl2Tdp+0V8X/EjmRWjsGelfDZ0fZF99/1+2KtvoZV004+UjssQr7SB
 i146K0oFPRbe0NiJF79aUFo+rbdsD9AE7oE9IkmBKJFNbJ5tmHV4/GM4mTW0Ww76Ps16
 UO/RWqzvQrH0giOhiILLkCw0ugxAhXk1KkYXX/kH6lV9tSMtzDsm3i9xdWxcEGOHcNUJ
 jw7CyrY+1a267rBk9WYeTohMp0/yN8pM32v6HMmGJkBiYpgVAlRZC7ioa97w5LyQt9Da
 3xjNZHH+5/O7KKDYrN2pZKj5NDKcH6nhH9eA3QHqsxi58jRTMMOqBn3fUDXoi1H5VldL
 3YwQ==
X-Gm-Message-State: AOJu0Yw+63J+t8VPy1ddWISRYB4agShXTeV6ISn/pmAbeA7438IXmHzh
 Ah/gk1qPUiWt+m+hDkHLypA04sL4mB3/d+fLvYXSF/t5he2Hem+LmSHNM+M4yLmhvR8=
X-Gm-Gg: ASbGncsobOem7XWdUulJCTHLqSZIJ6M6kRsFidxwiRbMXSg8/mbEocc8sI36aD3Ct5X
 uMfjB8uqScZE6sYmJBT7gU+DytjdSZuyZn7Li7sCTERmISpZPlM/yFkOzPymP+omdECRooNKPIF
 6/Vhhc7Yuw9hibIPADT9iHH43GxE16V4yhRzDAcjwYl3HXFs0kwFnbseeQVKeGEU1oP6xc25qMb
 E1m7IjrNFMsUCCWeT1bQTq33Qq+OwvKtW4c+9OstPlxO9jOxT7PR8u8tL6P+9ib1lqcuyXlRDxS
 4Udot7VivoZjkUegzVzTgXUPSr0k4ALHBv7MeIHriAALqClZuOfd
X-Google-Smtp-Source: AGHT+IHw6VfrpwpwUTCFuPZaX/Lnd3foP+3hEEMuIAcxlCEX36v2X2wfhQLbB2m71gMoQikJiTnRKg==
X-Received: by 2002:a05:6402:13cb:b0:602:2e1d:5c41 with SMTP id
 4fb4d7f45d1cf-605b7512e33mr10914796a12.7.1748948535192; 
 Tue, 03 Jun 2025 04:02:15 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-605671442d3sm7315460a12.51.2025.06.03.04.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 04:02:13 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 62C705F839;
 Tue, 03 Jun 2025 12:02:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>,
 Patryk 'patryk4815' Sondej <patryk.sondej@gmail.com>
Subject: [PATCH v4 16/17] gdbstub: Implement qGDBServerVersion packet
Date: Tue,  3 Jun 2025 12:02:03 +0100
Message-ID: <20250603110204.838117-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250603110204.838117-1-alex.bennee@linaro.org>
References: <20250603110204.838117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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
---
 gdbstub/gdbstub.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

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


