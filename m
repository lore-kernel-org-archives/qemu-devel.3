Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E77C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 22:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCnul-0007Jr-6V; Thu, 30 May 2024 18:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCnuh-0007JI-RA
 for qemu-devel@nongnu.org; Thu, 30 May 2024 18:06:24 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCnug-0005Do-9I
 for qemu-devel@nongnu.org; Thu, 30 May 2024 18:06:23 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f480624d04so12583455ad.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 15:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717106779; x=1717711579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ChXWvUNOD02yoYequIGCuEzpK9HfTXZtOpXCWQ0j1Uw=;
 b=iQAQLne5GUbCraZ+irpqq4BuCF31pf2NcnWdp5vi5DcF8ciI1/63knMmHtH+bbQ++m
 jwS0KFSJO+v7bz07wTdu6VYy/Zvus4MNYQHKSIm8+mSFGS7FDtGAHKmLxDZyebiJJKl9
 kfA3BDWJ7XmKfC0fiCs7agwQa3GBt8sKUdRgWrcuElwfA0BpzlTcDX5sl+iYLtixUaBa
 LufN81fVRsIwB6u2mNEfOtTEtQS4a23xbi3tlBTtFubSc/8fQ5OXLMiU7Ui8B/uQEyDc
 ZIcJd/c+Xj07AJIvkFboyoQvIVZObCbPeln3wsrm9Cus0tXg0v537w+GC268ZegBUx8L
 Nh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717106779; x=1717711579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ChXWvUNOD02yoYequIGCuEzpK9HfTXZtOpXCWQ0j1Uw=;
 b=wgj2VjEYKVC1vTy4h4TPDl52+qhqjX1gOj5jiJPHd/HykZzSQocJVybVkx5i4VZn8N
 UrdGyYyWrWd2sNcQn9i+zeemqw+exNDrL+VKa7sFqf1WuX6wfr1jEnbibBI2iukHglkI
 lqugz9eKA6xBppfypZ45fbOkbm4ELB+mw7bCbTOoEwheosStnkxMZ4hERnT/hqV7u6Fc
 eVsoQ9ZO0+OjuVAz69yaJu41VctDWhJIvLmgA3t005EvlHs7Mt6ffC89LnAUWtenPkMl
 PvBQQ1L1JYpZiFnCNINhKvZyKNv9UgMWw8ZFewdj37Nb6eeo8KTS+sT24DOJTbvaAX05
 EazA==
X-Gm-Message-State: AOJu0YyyZYgbOKncqkjoasZezp6hvanOz3hP3Pjzgq/BZ2rSpaJgPz6z
 1c6M3+JkR4UAon/jEgMSmYYl2E5Jz4HluyyVdunAf7eBeKRaTwoXl2dMz2LyeIHE8YDtnMxq8Kw
 cBRY=
X-Google-Smtp-Source: AGHT+IF0Rdk9P1U6UuKgC0lg8hFnkqj6WatX1CepD5W4ec+rVHUVakkto5fjdubC2r7ejxLHoJ78gQ==
X-Received: by 2002:a17:903:181:b0:1f4:befa:7a79 with SMTP id
 d9443c01a7336-1f637019aa8mr1075925ad.27.1717106779563; 
 Thu, 30 May 2024 15:06:19 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323dde39sm2732615ad.167.2024.05.30.15.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 15:06:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 4/6] qtest: move qtest_{get,
 set}_virtual_clock to accel/qtest/qtest.c
Date: Thu, 30 May 2024 15:06:08 -0700
Message-Id: <20240530220610.1245424-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240530220610.1245424-1-pierrick.bouvier@linaro.org>
References: <20240530220610.1245424-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/sysemu/qtest.h |  3 ---
 accel/qtest/qtest.c    | 12 ++++++++++++
 system/qtest.c         | 12 ------------
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
index 45f3b7e1df5..c161d751650 100644
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
index 53182e6c2ae..bf14032d294 100644
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
index e6f6b4e62d5..ba210780ec0 100644
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


