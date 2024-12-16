Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA6FE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 14:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNBwU-0004Qi-Jw; Mon, 16 Dec 2024 09:19:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tNBwH-0004EV-Ss
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:19:15 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tNBwE-0000EU-Uo
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:19:13 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-725d9f57d90so2995596b3a.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 06:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734358749; x=1734963549; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oTXeIKSE6vctrvuU18gwO4YmTcatQ3MxyH1mPVyZvCY=;
 b=aIbnF1ZGtdSbxKgrlNAbFNHXL8KONWxKFNusK3QJFRAcJ8iXGNZCEeiadelr35YSTp
 bxpxyEK++kVCw10KUAIJiCAaf98Z96b3KYQmOEeoNnamifh+dbx/GX8i7ZeNEBjvMR1i
 BfIASi4f8zUW9IY3cgbyYtC5wXaopqH15m6OAr5CFuyE6DzEYToDLV6kQKaw6vGrwRJr
 fJmsHkUcNoFRGucWyUPkq75s609Gfr85L35tsEA3O847XAREb4DLmlHPdoYa3eGdpoOr
 q+EqLRgoLq2IW9aE/9oUJbGNJe3oUu9Z8qewQcnBj8KKL0qSAkEI7pLKuowylMQvGzQ2
 myPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734358749; x=1734963549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oTXeIKSE6vctrvuU18gwO4YmTcatQ3MxyH1mPVyZvCY=;
 b=u3dpu8X0LabPsdBTU42Q2NOPzxLYKIPx/avhsxRIY26L5TQiiDpmYRyp7EUrmE4lpQ
 FPC3MNKvazZyduF690md2DbudbMJT8/UMzRA9E/HSXVkHvm8WXmqFslyyYOs/pFgGN6s
 e5X57HHrr1H3LegCdHLyo8UZ4sDqjpT0SLoKHojH2goWqb+DH2JhNI5GDpJUEVKHsxQY
 UvZJVbavB8yVXz/M/UC4ci53PkiXIjkMgjryihqVOFnPAbD4nFwB2LZJQ7OkNrgfxcrn
 1CT3M3elQco0fEX6mKkUWmqclCWByr1/k3+4NwgzWoCOTy4Yv6oJynpl2BfwtllShTsZ
 YltA==
X-Gm-Message-State: AOJu0YwOjm3unr1rrSZMNyjXS/NpGIboz2vXjCE2C42kA+szQ+eWtQBw
 sDc8PNkICg9qf9msrhzDwmmBbHeo81vbwfnHKuk5R9k2UJhRzkT+b9/BjT5V4qxB7XwQeBOXZkX
 R
X-Gm-Gg: ASbGncszBCk8DUK9iCeNnpnofw9M51ygKFbVLWDCi3jCX5Esh1ezx4QpZlVyCMC8ki0
 Juz/GFEhRHpWwyo4pX2wyZG+KmGNQgrJ+kNAwpKM4296HU+yXlxTEpSZjQy5OIWuW6SwnO/YzrU
 odH/fMMcNbVSnjyTg33PfHnUqQHSJpE08Gh1g82dhWXpXzvswWYuz1yRlXthyAKHdQyb/P+jU19
 fdAC0R5h0XrUjpY8qyc9DrKEnGVgnENCI6/bkQ5xd65lOzPbg/7JSGFE4s+55k=
X-Google-Smtp-Source: AGHT+IFQ0OCKWhpsklZ+GIj/kxhOlJJx0UulXpkNuuBcmhP8O7lp0Y8LO9PCT4XCTDZ3I05BvDOQGA==
X-Received: by 2002:a05:6a20:6a11:b0:1e1:aef4:9ce8 with SMTP id
 adf61e73a8af0-1e1dfe6a00bmr20051541637.28.1734358749223; 
 Mon, 16 Dec 2024 06:19:09 -0800 (PST)
Received: from gromero0.. ([177.189.100.90]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918bad8acsm4948815b3a.146.2024.12.16.06.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 06:19:08 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, philmd@linaro.org,
 alex.bennee@linaro.org, thuth@redhat.com, armbru@redhat.com
Cc: gustavo.romero@linaro.org
Subject: [PATCH v3 6/7] tests/qtest: Add API functions to capture IRQ toggling
Date: Mon, 16 Dec 2024 14:18:17 +0000
Message-Id: <20241216141818.111255-7-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216141818.111255-1-gustavo.romero@linaro.org>
References: <20241216141818.111255-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Currently, the QTest API does not provide a function to capture when an
IRQ line is raised or lowered, although the QTest Protocol already
reports such IRQ transitions. As a consequence, it is also not possible
to capture when an IRQ line is toggled. Functions like qtest_get_irq()
only read the current state of the intercepted IRQ lines, which is
already high (or low) when the function is called if the IRQ line is
toggled. Therefore, these functions miss the IRQ line state transitions.

This commit introduces two new API functions:
qtest_get_irq_raised_counter() and qtest_get_irq_lowered_counter().
These functions allow capturing the number of times an observed IRQ line
transitioned from low to high state or from high to low state,
respectively.

When used together, these new API functions then allow checking if one
or more pulses were generated (indicating if the IRQ line was toggled).

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/libqtest.c | 24 ++++++++++++++++++++++++
 tests/qtest/libqtest.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 8de5f1fde3..dfe3139a88 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -83,6 +83,8 @@ struct QTestState
     int expected_status;
     bool big_endian;
     bool irq_level[MAX_IRQ];
+    uint64_t irq_raised_counter[MAX_IRQ];
+    uint64_t irq_lowered_counter[MAX_IRQ];
     GString *rx;
     QTestTransportOps ops;
     GList *pending_events;
@@ -515,6 +517,8 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
     s->rx = g_string_new("");
     for (i = 0; i < MAX_IRQ; i++) {
         s->irq_level[i] = false;
+        s->irq_raised_counter[i] = 0;
+        s->irq_lowered_counter[i] = 0;
     }
 
     /*
@@ -706,8 +710,10 @@ redo:
         g_assert_cmpint(irq, <, MAX_IRQ);
 
         if (strcmp(words[1], "raise") == 0) {
+            s->irq_raised_counter[irq]++;
             s->irq_level[irq] = true;
         } else {
+            s->irq_lowered_counter[irq]++;
             s->irq_level[irq] = false;
         }
 
@@ -999,6 +1005,22 @@ bool qtest_get_irq(QTestState *s, int num)
     return s->irq_level[num];
 }
 
+uint64_t qtest_get_irq_raised_counter(QTestState *s, int num)
+{
+    /* dummy operation in order to make sure irq is up to date */
+    qtest_inb(s, 0);
+
+    return s->irq_raised_counter[num];
+}
+
+uint64_t qtest_get_irq_lowered_counter(QTestState *s, int num)
+{
+    /* dummy operation in order to make sure irq is up to date */
+    qtest_inb(s, 0);
+
+    return s->irq_lowered_counter[num];
+}
+
 void qtest_module_load(QTestState *s, const char *prefix, const char *libname)
 {
     qtest_sendf(s, "module_load %s %s\n", prefix, libname);
@@ -1902,6 +1924,8 @@ QTestState *qtest_inproc_init(QTestState **s, bool log, const char* arch,
     qts->wstatus = 0;
     for (int i = 0; i < MAX_IRQ; i++) {
         qts->irq_level[i] = false;
+        qts->irq_raised_counter[i] = 0;
+        qts->irq_lowered_counter[i] = 0;
     }
 
     qtest_client_set_rx_handler(qts, qtest_client_inproc_recv_line);
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index f23d80e9e5..b73c04139e 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -389,6 +389,34 @@ void qtest_module_load(QTestState *s, const char *prefix, const char *libname);
  */
 bool qtest_get_irq(QTestState *s, int num);
 
+/**
+ * qtest_get_irq_raised_counter:
+ * @s: #QTestState instance to operate on.
+ * @num: Interrupt to observe.
+ *
+ * This function can be used in conjunction with the
+ * qtest_get_irq_lowered_counter() to check if one or more pulses where
+ * generated on the observed interrupt.
+ *
+ * Returns: The number of times IRQ @num was raised, i.e., transitioned from
+ * a low state (false) to a high state (true).
+ */
+uint64_t qtest_get_irq_raised_counter(QTestState *s, int num);
+
+/**
+ * qtest_get_irq_lowered_counter:
+ * @s: #QTestState instance to operate on.
+ * @num: Interrupt to observe.
+ *
+ * This function can be used in conjunction with the
+ * qtest_get_irq_raised_counter() to check if one or more pulses where
+ * generated on the observed interrupt.
+ *
+ * Returns: The number of times IRQ @num was lowered, i.e., transitioned from
+ * a high state (true) to a low state (false).
+ */
+uint64_t qtest_get_irq_lowered_counter(QTestState *s, int num);
+
 /**
  * qtest_irq_intercept_in:
  * @s: #QTestState instance to operate on.
-- 
2.34.1


