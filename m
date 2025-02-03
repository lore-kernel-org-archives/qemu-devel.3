Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1EDC0218F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 03:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1temyl-0007zY-BO; Sun, 02 Feb 2025 22:18:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1temyj-0007xy-0u
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 22:18:29 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1temyh-0002eL-5Q
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 22:18:28 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2167141dfa1so66258925ad.1
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2025 19:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738552706; x=1739157506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vbrezDzCPzYJZE+sgCbEQwq19lroZqcdNTLKZBRXWvg=;
 b=PzL1PtNh92j7JX+VXgbVPu9Z4eexPxuY/UH0ntvlTCIp1R4yjpwvgQ0sSs/0FQpkXQ
 6y28Dfjf4bJqBDmO7GoEC0Rut1AEo88fhbpG3PMRpwP0JQRMLiAiw+TQTrjGuGKC9/yQ
 obgt1PaMqdDki1hcCaipACpdZIY2LNi1Jm7IN+lbu/khqHiJDfFMMs4qP4fPYw8ruasE
 QrDycvo9E9oOxezFQd+Qmy6XBmbjvK9mZ6bxzVRxsYE/kyvDhP1o7xjywadJeeGyokbB
 3MZSOMx4GrReXaUssy17SQ2qh31WEB3eTJNMDG3MITJVrrjtRu3loKeB2yBMip8kE4qy
 XyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738552706; x=1739157506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vbrezDzCPzYJZE+sgCbEQwq19lroZqcdNTLKZBRXWvg=;
 b=DsSa6ntEbzVrtIvSGQI2P4C7Y7+CFScUx+SLPnap9CVDFqkaE9QgmdXu16s2bZIorC
 RTCrdBWkdM4sZuz4U8O845KJ4FQ4vJFRte5Yt7u5XMUg54FVxgdbKUliWPkPDOn5LK/i
 Ky3deA077Gz+HUjev7Z0JlX6rYxgTgSlgaH3OAt7LYUIpCtbuMR3TY/uIqPss/7umcAp
 1dQkTKNGCHLD1oC5+OlHI/oxuQBhNhlru0dw2rgjNiSFRRyMRHJgNj/JPK42OqsKCJ8M
 Q4x0mvGGliuOQAYPQTpwjg8v7cRwAhTimWAjgnXwpB8NGGcGBWSv4+KHVXzOS0wuJRJK
 IfEA==
X-Gm-Message-State: AOJu0YzsHY252Q1EfkGSjXzqNTbmFVxECV76eE+3Xv4CUq46L7UcvD2L
 YkLAFgWxyguQrQt9T7NWoy2P9T7iOKjXlPQBgBkxBXR83dihtvWM3Q4O+ZqEAE6MVrc5xQNxgnB
 9
X-Gm-Gg: ASbGncu/6STU765orTttAy0F1RQWVQiFllTpaSFNNjDqedeWu4FlITTQuw8DLGtz4g2
 iKh0wJTwMzOSTPJEYO6kqA0WWhXh6lXB1BwRKmXjSnpyT6/540nHPPm9r36Kjg+0Bf8CbFeV5CP
 LuRfWcK65kdkyXbhOTpaKiDSB4lBl+1WPEINxZFcdZtcYy40TnVvmDNyUdHF7uX67Epkci+4jxN
 mFwE0EfUG/oUNl+4PuYifa8iGg676n7k/LEu5RgURKHIKBx3a7fYZime8FrywvzTHnwNUy8DXQQ
 9AzVa/6E4KXX4qScdlx8DzGfZ38rBwoNxtKB+DJxWFpbFmw=
X-Google-Smtp-Source: AGHT+IGwkdtTqgEsDzgje+XlKKCLoJa7DaQ84kNH6t0cH3ugPQfcZwBtsIs8gwWYrn+keU871rNmcw==
X-Received: by 2002:a17:903:1c9:b0:21d:90d0:6c10 with SMTP id
 d9443c01a7336-21de19c6828mr276602095ad.23.1738552705581; 
 Sun, 02 Feb 2025 19:18:25 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de32eb419sm65698135ad.145.2025.02.02.19.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2025 19:18:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com
Subject: [PATCH v2 03/14] plugins: Uninline qemu_plugin_add_opts
Date: Sun,  2 Feb 2025 19:18:10 -0800
Message-ID: <20250203031821.741477-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203031821.741477-1-richard.henderson@linaro.org>
References: <20250203031821.741477-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

No need to expand this function inline.
Unexport qemu_plugin_opts to match.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/plugin.h | 9 +--------
 plugins/loader.c      | 7 ++++++-
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 9726a9ebf3..3efded6a3e 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -11,7 +11,6 @@
 #include "qemu/qemu-plugin.h"
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
-#include "qemu/option.h"
 #include "qemu/plugin-event.h"
 #include "qemu/bitmap.h"
 #include "exec/memopidx.h"
@@ -44,13 +43,7 @@ get_plugin_meminfo_rw(qemu_plugin_meminfo_t i)
 }
 
 #ifdef CONFIG_PLUGIN
-extern QemuOptsList qemu_plugin_opts;
-
-static inline void qemu_plugin_add_opts(void)
-{
-    qemu_add_opts(&qemu_plugin_opts);
-}
-
+void qemu_plugin_add_opts(void);
 void qemu_plugin_opt_parse(const char *optstr, QemuPluginList *head);
 int qemu_plugin_load_list(QemuPluginList *head, Error **errp);
 
diff --git a/plugins/loader.c b/plugins/loader.c
index ebc01da9c6..35680bfc13 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -55,7 +55,7 @@ struct qemu_plugin_parse_arg {
     struct qemu_plugin_desc *curr;
 };
 
-QemuOptsList qemu_plugin_opts = {
+static QemuOptsList qemu_plugin_opts = {
     .name = "plugin",
     .implied_opt_name = "file",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_plugin_opts.head),
@@ -65,6 +65,11 @@ QemuOptsList qemu_plugin_opts = {
     },
 };
 
+void qemu_plugin_add_opts(void)
+{
+    qemu_add_opts(&qemu_plugin_opts);
+}
+
 typedef int (*qemu_plugin_install_func_t)(qemu_plugin_id_t, const qemu_info_t *, int, char **);
 
 extern struct qemu_plugin_state plugin;
-- 
2.43.0


