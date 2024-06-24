Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EE8C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 10:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLgmg-0006oP-Tx; Mon, 24 Jun 2024 06:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLgmf-0006nV-Dx
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:18:49 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLgma-0007h1-Q2
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:18:49 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52cd80e55efso4511238e87.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 03:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719224323; x=1719829123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ob6CSHHY9QNLxHtzyLGqMdnNXrmVZ+yffKASjxK2raE=;
 b=Rw2d9G7IRRr8L/W4poDLO1yig4CE+Q11uujTiznMRWF3WiMsdCVGF9+Ru+dEnzHHpx
 Wbb4Xm2FvzCfXgpsHWe+gc4dXKHnnmTKnE8sqs3zzRMuVxyl7dttWLlqQMJL/GwCsQ82
 b6N4cVmU1hDQKt8J98Fus2Eu/DZbSuBeblvcqD6R3E2itMc4qL8lukOGEbex4n5/SOK4
 8GX6gJo8wJ+hfJej3idLBisfxCB9zao2coWpdomI3f2UVKrbsdaX8QZuylU5JDBogGYa
 pgLtJw0mHxL5YBe1SbZxUiwXylaAiG0a/US6Jxf/x2JW6cxWSzfRcTrlKliNeBz0SlF4
 UWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719224323; x=1719829123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ob6CSHHY9QNLxHtzyLGqMdnNXrmVZ+yffKASjxK2raE=;
 b=OHACda3E58oPF4zmfmK3UDuKThXOSm0Lc1T8WEfqeveZlc1CqbXvCiJGLwPcOf6VSZ
 rQbY0J3PpDWQSG3c0yLtHLIXWbf29FZGzj3m48HhsgFQv+KJ3YN5kIeWoPjuja3L/vXr
 eCKQxhR4X9yBmWvSFEvHb/U5fkJRKiplGWQacxCec2etcKllBsfQZlzu7oXmVT59/tdc
 8rtQOfmcTaj3dOggfknbpos5Mo26q5JR6XNaPr2iA9CVeBgGwudV/JRvpD7pPy4tIBRG
 Wx9jrM+FHyuRFOyp8V0ma0sJv9i/MDUInyuajSINt2R2ieTyHp1K8KFo1UEpR3ql1ctc
 ZGqA==
X-Gm-Message-State: AOJu0Yy4IwIAXMrHwmA7hJDAsMxAaGDf0Jfm/vM+FbuI65IC8CpH0niX
 9rDi3qtOK+r1fYjt03D8mNIzEFZ0ylr2tJWhQJUD7EQEZxHGwiWqqnGADUbnb4IsfBZcbhYCKj3
 X
X-Google-Smtp-Source: AGHT+IHYQ9qCLgr2TBPN3m5DwnDKZMFmvjBYLPIZnkcaU9/Fb6Yij+5WgLmObvaoVxK7LvLabgty8g==
X-Received: by 2002:a05:6512:539:b0:52c:ab21:7c05 with SMTP id
 2adb3069b0e04-52ce185d03emr2736074e87.67.1719224322852; 
 Mon, 24 Jun 2024 03:18:42 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fe779bc80sm271867366b.174.2024.06.24.03.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 03:18:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 097D85FA29;
 Mon, 24 Jun 2024 11:18:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 07/12] qtest: move qtest_{get,
 set}_virtual_clock to accel/qtest/qtest.c
Date: Mon, 24 Jun 2024 11:18:31 +0100
Message-Id: <20240624101836.193761-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240624101836.193761-1-alex.bennee@linaro.org>
References: <20240624101836.193761-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12b.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240530220610.1245424-5-pierrick.bouvier@linaro.org>
Message-Id: <20240620152220.2192768-8-alex.bennee@linaro.org>

diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
index 45f3b7e1df..c161d75165 100644
--- a/include/sysemu/qtest.h
+++ b/include/sysemu/qtest.h
@@ -34,9 +34,6 @@ void qtest_server_init(const char *qtest_chrdev, const char *qtest_log, Error **
 void qtest_server_set_send_handler(void (*send)(void *, const char *),
                                  void *opaque);
 void qtest_server_inproc_recv(void *opaque, const char *buf);
-
-int64_t qtest_get_virtual_clock(void);
-void qtest_set_virtual_clock(int64_t count);
 #endif
 
 #endif
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index 53182e6c2a..bf14032d29 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -24,6 +24,18 @@
 #include "qemu/main-loop.h"
 #include "hw/core/cpu.h"
 
+static int64_t qtest_clock_counter;
+
+static int64_t qtest_get_virtual_clock(void)
+{
+    return qatomic_read_i64(&qtest_clock_counter);
+}
+
+static void qtest_set_virtual_clock(int64_t count)
+{
+    qatomic_set_i64(&qtest_clock_counter, count);
+}
+
 static int qtest_init_accel(MachineState *ms)
 {
     return 0;
diff --git a/system/qtest.c b/system/qtest.c
index 8cb98966b4..12703a2045 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -325,18 +325,6 @@ static void qtest_irq_handler(void *opaque, int n, int level)
     }
 }
 
-static int64_t qtest_clock_counter;
-
-int64_t qtest_get_virtual_clock(void)
-{
-    return qatomic_read_i64(&qtest_clock_counter);
-}
-
-void qtest_set_virtual_clock(int64_t count)
-{
-    qatomic_set_i64(&qtest_clock_counter, count);
-}
-
 static bool (*process_command_cb)(CharBackend *chr, gchar **words);
 
 void qtest_set_command_cb(bool (*pc_cb)(CharBackend *chr, gchar **words))
-- 
2.39.2


