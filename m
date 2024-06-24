Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA1FC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 10:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLgmj-0006pq-7r; Mon, 24 Jun 2024 06:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLgmf-0006nU-Bk
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:18:49 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLgma-0007gn-9X
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:18:49 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ec50a5e230so26750021fa.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 03:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719224321; x=1719829121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZgJtc3lx/g2nwJr+x/MfCvRRoPneDciPWhATdKfcPaw=;
 b=hbGu1h3w7vCxvSdAXv28enYgsBs5s1JP09QVqCYbcZhNoxeui6JDl42CWbIF34q5/A
 XsLK0puK1qbT52QcV+Ope9bXb3wWBQB9E5Vzn5QzukF6zO4NLRj/ffgS+beQCMTGwCCB
 zldGtRsESLO98t32s+g28okLvjFRSkQYPzkp7iTMje7WOzZ4Ec8h/vpY1YrraIDEuGiH
 2VyBEII4vOe6robLQLwQOGXxc9C2VXTsvc8panlr7tgXv4pIq1fwHXfujRYKm7SBg826
 gpAe0VTHzgUdPETDbby4BYF3sZ0qcyS5rhEPZmioWUz9bOW9WPSjA+SgHF2oi0DTVkRr
 ZTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719224321; x=1719829121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZgJtc3lx/g2nwJr+x/MfCvRRoPneDciPWhATdKfcPaw=;
 b=LWfKiwVb2grFbrLOtYYTFGbWz2g0Txm/Bc3vwueF9SjYSB9OltGos7TwZGhSvIiWEX
 dtQz7UNIlodPQwxDfROziZOR5p7/IbpkhnIDeVJi5lBAUrhP+iiID7ZyiQ2oTG1Zj/CV
 R0/X5lFOK/3J1h7Pg/csOu7kSsnBOFZml78LmbU5ekZrueoStbXu/8g3/kiylb8Ij1ta
 JQQ+/XIQTJyAcyAJEEUck7POhg/2WxX7aB7HataPaz+8M5OnT0CM+s1UKcaU2FSS0SkE
 CjqkJFLegvUKjorm15qRVq4iocy1LdW5DZeKLXu5HdE+rPtUMRnOHrtgAnc8fqJz0E4Y
 lRjQ==
X-Gm-Message-State: AOJu0Yx2HLT0VGfWsxCpQPie1W6/aVh+vOnkq0rC/Tww1ibwTcJDrGyY
 4mGcx2VAVdLdAk4GoOeCWlvb1DkZse7DpKcZ+riAbkflYZs75IiA6XhAyclERg8=
X-Google-Smtp-Source: AGHT+IHybceIGVKtpYJjyJ9oz5M7WZSet3tCE54JANEzeZb/pIt33N/iEI3HyzYK69dPSofw5r8rUw==
X-Received: by 2002:a2e:b0f5:0:b0:2ec:4086:ea6d with SMTP id
 38308e7fff4ca-2ec5b2695d9mr26484241fa.4.1719224321326; 
 Mon, 24 Jun 2024 03:18:41 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d3042d8b1sm4542750a12.45.2024.06.24.03.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 03:18:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E3F485FA28;
 Mon, 24 Jun 2024 11:18:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 06/12] sysemu: generalise qtest_warp_clock as
 qemu_clock_advance_virtual_time
Date: Mon, 24 Jun 2024 11:18:30 +0100
Message-Id: <20240624101836.193761-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240624101836.193761-1-alex.bennee@linaro.org>
References: <20240624101836.193761-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x232.google.com
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

Move the key functionality of moving time forward into the clock
sub-system itself. This will allow us to plumb in time control into
plugins.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240620152220.2192768-7-alex.bennee@linaro.org>

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 9a366e551f..5ce83c7911 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -245,6 +245,21 @@ bool qemu_clock_run_timers(QEMUClockType type);
  */
 bool qemu_clock_run_all_timers(void);
 
+/**
+ * qemu_clock_advance_virtual_time(): advance the virtual time tick
+ * @target_ns: target time in nanoseconds
+ *
+ * This function is used where the control of the flow of time has
+ * been delegated to outside the clock subsystem (be it qtest, icount
+ * or some other external source). You can ask the clock system to
+ * return @early at the first expired timer.
+ *
+ * Time can only move forward, attempts to reverse time would lead to
+ * an error.
+ *
+ * Returns: new virtual time.
+ */
+int64_t qemu_clock_advance_virtual_time(int64_t target_ns);
 
 /*
  * QEMUTimerList
diff --git a/system/qtest.c b/system/qtest.c
index 5be66b0140..8cb98966b4 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -337,26 +337,6 @@ void qtest_set_virtual_clock(int64_t count)
     qatomic_set_i64(&qtest_clock_counter, count);
 }
 
-static void qtest_clock_warp(int64_t dest)
-{
-    int64_t clock = cpus_get_virtual_clock();
-    AioContext *aio_context;
-    assert(qtest_enabled());
-    aio_context = qemu_get_aio_context();
-    while (clock < dest) {
-        int64_t deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
-                                                      QEMU_TIMER_ATTR_ALL);
-        int64_t warp = qemu_soonest_timeout(dest - clock, deadline);
-
-        cpus_set_virtual_clock(cpus_get_virtual_clock() + warp);
-
-        qemu_clock_run_timers(QEMU_CLOCK_VIRTUAL);
-        timerlist_run_timers(aio_context->tlg.tl[QEMU_CLOCK_VIRTUAL]);
-        clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    }
-    qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
-}
-
 static bool (*process_command_cb)(CharBackend *chr, gchar **words);
 
 void qtest_set_command_cb(bool (*pc_cb)(CharBackend *chr, gchar **words))
@@ -751,7 +731,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
             ns = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
                                             QEMU_TIMER_ATTR_ALL);
         }
-        qtest_clock_warp(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + ns);
+        qemu_clock_advance_virtual_time(
+            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + ns);
         qtest_send_prefix(chr);
         qtest_sendf(chr, "OK %"PRIi64"\n",
                     (int64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
@@ -777,7 +758,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         g_assert(words[1]);
         ret = qemu_strtoi64(words[1], NULL, 0, &ns);
         g_assert(ret == 0);
-        qtest_clock_warp(ns);
+        qemu_clock_advance_virtual_time(ns);
         qtest_send_prefix(chr);
         qtest_sendf(chr, "OK %"PRIi64"\n",
                     (int64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 6a0de33dd2..213114be68 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -645,6 +645,11 @@ int64_t qemu_clock_get_ns(QEMUClockType type)
     }
 }
 
+static void qemu_virtual_clock_set_ns(int64_t time)
+{
+    return cpus_set_virtual_clock(time);
+}
+
 void init_clocks(QEMUTimerListNotifyCB *notify_cb)
 {
     QEMUClockType type;
@@ -675,3 +680,24 @@ bool qemu_clock_run_all_timers(void)
 
     return progress;
 }
+
+int64_t qemu_clock_advance_virtual_time(int64_t dest)
+{
+    int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    AioContext *aio_context;
+    aio_context = qemu_get_aio_context();
+    while (clock < dest) {
+        int64_t deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
+                                                      QEMU_TIMER_ATTR_ALL);
+        int64_t warp = qemu_soonest_timeout(dest - clock, deadline);
+
+        qemu_virtual_clock_set_ns(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + warp);
+
+        qemu_clock_run_timers(QEMU_CLOCK_VIRTUAL);
+        timerlist_run_timers(aio_context->tlg.tl[QEMU_CLOCK_VIRTUAL]);
+        clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    }
+    qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
+
+    return clock;
+}
-- 
2.39.2


