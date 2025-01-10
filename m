Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4DBE7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEzg-0000ks-Ee; Fri, 10 Jan 2025 08:24:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEzA-0008Pg-6u
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:23:36 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEz8-0005el-AP
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:23:35 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5d0ac27b412so2530480a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515413; x=1737120213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=41wL9S2WjuFMsg/x9Ao10h4Njo7dU6+cGfdY/1G7SPs=;
 b=wF/YVUi+jWzFRF7Kpg4PjmW2DYfcqm18U1hWyxsojY0C45THYZ9oCftjfRSJQM5err
 Bn5JALdBkWg5scemhuvf1tHan75iCtjBFWEpdfpRWgjheIXQQdwVDQ0sHwNAFY4mHnKV
 8C7wafjtue1oikoNomdpvYb3Zcs/1ykZ6b2rniufr4nYpg5w7lt8Kl1CHFArF3cWGQ1Y
 hZ2kM3zYZXFaBNRpt5b26fFpxqyDbfkTH0xcKMrXNOSXEiE/5wD6oDZx/Yziq8zt9b+S
 IX/CHzk8ybTxkSlGbCysclKFZKYNbJc3M/jcauf2khfvmJxSXHZrDB88ob0OYc2M8S7Q
 /NhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515413; x=1737120213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=41wL9S2WjuFMsg/x9Ao10h4Njo7dU6+cGfdY/1G7SPs=;
 b=FFFl4sOl7ltGLwU/IyGdHd8b3GN4AlTTfg9otryQKR46ARIGYAOdzcIxExgfoCGGWM
 a7LWHyVbN6T4/kv/I1lK1P3FeGlcEC1nwEuZ/14f5ruBMYdQjeAlGNKBhLEZxKsaZkX/
 doFA8St+1XlIkfNGAhg3gqWFmZMP+XrsRWzeHVzbor4mc5sX7srgDb76kuhTrrU4UQU5
 VMTfGij2dxw4eLEqT8r+Zk3WHQKLpCgOPFXyJp2WKm1SZa6fmsFmlgGcnSs/flCd86DU
 /17frNbAnhk0Z2iT6VxgHOiwOAI4r4euM2kGWL1LBSk6t+XTrXija7x4Xv77RJF+4q2l
 H56w==
X-Gm-Message-State: AOJu0Ywiyo+pwUE3BQONqt2bz1bpWHv6C+ebZC62cjVXeORffR7qgfRd
 ynH5YuVCQrwwnC8/Nder4ewhHhh0rLsSiRWB008TbZuPw9XSnk1XQpGLp18tDW4=
X-Gm-Gg: ASbGnctQHmkS/BvKmxfrqbUgfVkGCiGQ/VWChZIkaM9gZqC5/7LbHMOPsjEkjsiSvWc
 RmciYkf5EVOx6OQ7ZgfGCyRLrS/v+GrtQDpJLbXtUez2qDRPJMHqGuV74+uCOCy6MkqXKm/+dek
 a9eXucQM+KS0ktILryS/Roy98RyWBsrTy8AdWp3G079rYk24SQplC5S18wVjAHW2FW/dO/nBHXw
 /fX4ocLOS6dqLeFBIWeg8UtvLumW6NzbdBdN7Kut6NIJnbjkMwAvcY=
X-Google-Smtp-Source: AGHT+IFOm85rCU6Xq+UzQkMsKSDuMqWoQGhGLecuMA6MEnuPrjcMWjAgHk3wSPAkP7lf/KY31FPi9g==
X-Received: by 2002:a05:6402:2690:b0:5d2:7199:ae5 with SMTP id
 4fb4d7f45d1cf-5d972dfbe9amr9522973a12.5.1736515412795; 
 Fri, 10 Jan 2025 05:23:32 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d9903c4598sm1637061a12.53.2025.01.10.05.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:23:31 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A0C40609B6;
 Fri, 10 Jan 2025 13:17:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 17/32] system/qtest: properly feedback results of
 clock_[step|set]
Date: Fri, 10 Jan 2025 13:17:39 +0000
Message-Id: <20250110131754.2769814-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
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

Time will not advance if the system is paused or there are no timer
events set for the future. In absence of pending timer events
advancing time would make no difference the system state. Attempting
to do so would be a bug and the test or device under test would need
fixing.

Tighten up the result reporting to `FAIL` if time was not advanced.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2687
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250108121054.1126164-18-alex.bennee@linaro.org>

diff --git a/system/qtest.c b/system/qtest.c
index 99ef2042f6..e68ed0f2a8 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -78,6 +78,11 @@ static void *qtest_server_send_opaque;
  * let you adjust the value of the clock (monotonically).  All the commands
  * return the current value of the clock in nanoseconds.
  *
+ * If the commands FAIL then time wasn't advanced which is likely
+ * because the machine was in a paused state or no timer events exist
+ * in the future. This will cause qtest to abort and the test will
+ * need to check its assumptions.
+ *
  * .. code-block:: none
  *
  *  > clock_step
@@ -710,7 +715,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
             qtest_sendf(chr, "OK little\n");
         }
     } else if (qtest_enabled() && strcmp(words[0], "clock_step") == 0) {
-        int64_t ns;
+        int64_t old_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        int64_t ns, new_ns;
 
         if (words[1]) {
             int ret = qemu_strtoi64(words[1], NULL, 0, &ns);
@@ -719,11 +725,10 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
             ns = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
                                             QEMU_TIMER_ATTR_ALL);
         }
-        qemu_clock_advance_virtual_time(
-            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + ns);
+        new_ns = qemu_clock_advance_virtual_time(old_ns + ns);
         qtest_send_prefix(chr);
-        qtest_sendf(chr, "OK %"PRIi64"\n",
-                    (int64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+        qtest_sendf(chr, "%s %"PRIi64"\n",
+                    new_ns > old_ns ? "OK" : "FAIL", new_ns);
     } else if (strcmp(words[0], "module_load") == 0) {
         Error *local_err = NULL;
         int rv;
@@ -740,16 +745,16 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
             qtest_sendf(chr, "FAIL\n");
         }
     } else if (qtest_enabled() && strcmp(words[0], "clock_set") == 0) {
-        int64_t ns;
+        int64_t ns, new_ns;
         int ret;
 
         g_assert(words[1]);
         ret = qemu_strtoi64(words[1], NULL, 0, &ns);
         g_assert(ret == 0);
-        qemu_clock_advance_virtual_time(ns);
+        new_ns = qemu_clock_advance_virtual_time(ns);
         qtest_send_prefix(chr);
-        qtest_sendf(chr, "OK %"PRIi64"\n",
-                    (int64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+        qtest_sendf(chr, "%s %"PRIi64"\n",
+                    new_ns == ns ? "OK" : "FAIL", new_ns);
     } else if (process_command_cb && process_command_cb(chr, words)) {
         /* Command got consumed by the callback handler */
     } else {
-- 
2.39.5


