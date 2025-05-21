Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C563DC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHmXP-0000gP-Ct; Wed, 21 May 2025 12:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmXM-0000eO-U8
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:43:25 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmX6-0006Da-HE
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:43:24 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ace94273f0dso1211128366b.3
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 09:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747845786; x=1748450586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IR1BW0V6NZfur5cS1FGWmpSotNouca/s3x/m5RfYwqA=;
 b=XZxqylnm1gMGHum887YEEz4yYhNNd3zePMrBbjccnv1MKdrPqHWdBnn45lwXS2vwCq
 h5IHqgybflSSdJblLdWnezfDgbfZW0etwfkysGpSgJP4G2q/aThL//Kg41cyScBtbX5s
 T7f8RU/MGUYqRsQ8iCMT3p1ZfOzmd9eDYp8uCHjzL5hOM5I32vx9hqtAt05cebp1VFrK
 i1TrBKM42Quv74P3hlu19iPBWD9vOGwIvgTdzc26QwsIsSoDBNr30naktV3mjCRkz/hj
 bUdQx9RV0nARaB31eqN7FPknsHZ6ZXiev6wNin4zpLWE36QugpFj0aOG3LELvToyhIlm
 gIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747845786; x=1748450586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IR1BW0V6NZfur5cS1FGWmpSotNouca/s3x/m5RfYwqA=;
 b=mL0zEWyfu60UAZSfAt9wkm2ccBEsueNBeYF/38XVRhVIHzA9rS9LrETvgI3u7Nx5pJ
 aDD1ModTov4RbGqgVp02XhvbPLp130DKoppW2Z2eZgxsTggRHLu015IGjkn4VxbH3/jF
 RevbSM4f5ZTuhsgwnXft/WX74BwpvMxZTY6Ma4MOExab8NCfXd8YADGv62eZ902sktXk
 VxFdUWQ8J6+smctoQCB+4ny8BP9e3/GxUCJPCTYNIAJlmokziZjUfzw/rtKfuKQ9tiEA
 qv3weZwBpIleR1tM8x89AgkIuIN1NPZ91yhDwZTHdJJ1QjyXF/n2bUitDcB6YMncGfKO
 C7ow==
X-Gm-Message-State: AOJu0YwLRMbPg3IJhXlLcSIH6ZnYUu4/EkMot0lMLCj17lgnvSp8h71D
 bwWnJuGXWmdezBRErWQML+uj3OkNqXrgqVvsNLycFnXWCbdDW5SzF/L375CRdmFyjV4=
X-Gm-Gg: ASbGncvYibWSc6pOSnmjHDMHq8hqI1i5jHdUIJj7BhoAez62yCmT1dfXANjgwBXbH4Y
 KztiqfiBEkL749B2dvJ3PLcG6xSVJLL6Wx1r8e4k9HsXqt7GOZpnw5zKNpRN/1ZOzz/K5ZByiRu
 3CdqhnxPCTNqDS4qmqGilBWapRlnt/vDsdRlHFmIc2sfDt97m+XK/px/pEr0JNxfE4BnuuIebrB
 tIL6AefnStq/TytOoC+WzbOMUeOtKK5q1vqMyhXiAu4LOM2y6smCPxl2AzfHP6adzcV1w8sogG/
 rDVIhDtosoHMNQuPFv0BTT1gSNKkkQi8VIFgCNFWQd1myHykZU3F
X-Google-Smtp-Source: AGHT+IFCsPcX/oo9BM5upLFxqdU2MK67yeRr0Y1cxMS1ngbRQntV/2OcImjg5sXgDvrohU3pjysSjw==
X-Received: by 2002:a17:907:6d11:b0:ad2:1cd7:cefc with SMTP id
 a640c23a62f3a-ad52d496b58mr1813848966b.13.1747845786411; 
 Wed, 21 May 2025 09:43:06 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad5572f6436sm674593966b.182.2025.05.21.09.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 09:43:03 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A7BC15FAFD;
 Wed, 21 May 2025 17:42:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>,
 Patryk 'patryk4815' Sondej <patryk.sondej@gmail.com>
Subject: [PATCH v3 19/20] gdbstub: Implement qGDBServerVersion packet
Date: Wed, 21 May 2025 17:42:49 +0100
Message-Id: <20250521164250.135776-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250521164250.135776-1-alex.bennee@linaro.org>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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
2.39.5


