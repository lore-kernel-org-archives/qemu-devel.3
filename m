Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9693ACCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 17:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEWWf-0001CI-AV; Thu, 30 Oct 2025 13:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vEWWc-0001Br-Ha
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 13:33:27 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vEWWR-0002wu-QM
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 13:33:26 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-63c4b5a1b70so2870267a12.1
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 10:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761845588; x=1762450388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hkO6OeeX1sOmdPHBsGMONIpye9aGTGkeACzl8aZQVmM=;
 b=X4vUp8M+tYaqMW3/7VJVyGVBbNj+MInrhwbk1saQ4qmo2DaaLMWVmoQ9t1ybtHv0cW
 vOPKpvefQlheYUlOtRetGHIq+DufNuTcYwwICdCwzoQpN7+u368iiVY9XUQxmmSJA3kI
 7N8p1Cs457cE1Kyyrlz8XZ9zbAEKBDiMGWfrXuffT1j14LjzTtB7K89zMiV3uj8bVyug
 7KdVnj+/wF9L7jkq/xELNs64zpHGH60qbTii76EJUuFtis9y1Ft81duoBV/3VEQXE0yz
 g/FPZbaZuRC0TziU3j1TmpDqXHidwf4/x5HU1t6HZ2TZX10bPKz/x+DL3C+q/SfVhE8H
 tC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761845588; x=1762450388;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hkO6OeeX1sOmdPHBsGMONIpye9aGTGkeACzl8aZQVmM=;
 b=STuNY/POHYtcTqV5GVpIrmto8jpDuiR8TDbfuByn8jRkFd/+9riAdtqOUvTdnlKJus
 fNG84SxBpbkfuCHvR/kVXjsdFg2q6xaUni9hAnM/LR5pSZM2XEQxL8890kxH8uCGkGkA
 Yp+ll3UNIe3HNYBXLwiXJIKAcNsgNnXhO/voiufK9L4a65UUK6LHoYFSNO5CaReFIDFt
 CgWqPy1ewmcds9q5flCFufhNFynbQElg2cYxQUsqsKInJ0AI3EfsagM7qB4E2ic6MMQC
 3AhI6PFXtQI4ERmeB/cKkcPySO7nDr/p+ILMcshTw4o0OWalgvCGsL6lrikv0vG8CDDi
 BTlg==
X-Gm-Message-State: AOJu0Yz710RMdEVNMqHTGo1BKBq8OlGD64H4kFzF0uGszZVYtWgmnsQO
 3mjjD6KIIIfD1pGptIIBSXHpJtAdMwZCqMO/fxmgJuzQdMrJlcOvaEmPvlQ0eHAosNk=
X-Gm-Gg: ASbGncvCekZzDQ5WBoeFveaMz/OUBjys2tIh1j2ZGXdlkWkJdLVYB/lva3JbdjwtkXD
 94beZs2ge5B++82dQc9qRhMYh7UtQbcdSNb5fwtzQyQ/WmOEQTotd5iVZeIQwENINP18hT6MLFX
 k11VP2WlWOo7Zs9NaJCF31++ZfJ8vJ6oToatWajNStoujFZjc/QZTYftOrX3mUSt6jYxdAghyj6
 iwyxpMUL+UWe38w4K9aur2H1YG0qYNXo3CEljAGaB706Lg1jLecBaqLtUiejJVSFfB5Vf75uoxp
 bh+XrywUcVY7gYlqX1GtvmufZ/U/W7CDQbWuvS6XlmzEvN3XL4SBljn2ClUBaUfoy5U/TO/ALkP
 NtRtpXlUe9Cm310KxjZ2qFgeVXrIj9xs5jzfDHIzZ3tccrjUgx5ts/KyBuVVhwwdbeJXROB7GAI
 FYczjVKaHLfq0=
X-Google-Smtp-Source: AGHT+IF+vJo0QhtSTAwbgTH46g3Tsj2xxqNyx3o0X+tggGfS4XBtO0+7h6Vx20gxEj4pePHWCG3Jog==
X-Received: by 2002:a05:6402:2549:b0:640:6650:9173 with SMTP id
 4fb4d7f45d1cf-64077043cefmr236470a12.33.1761845587715; 
 Thu, 30 Oct 2025 10:33:07 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e7efd116asm15669705a12.33.2025.10.30.10.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 10:33:07 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2BB785F80C;
 Thu, 30 Oct 2025 17:33:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH] timers: properly prefix init_clocks()
Date: Thu, 30 Oct 2025 17:33:02 +0000
Message-ID: <20251030173302.1379174-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Otherwise we run the risk of name clashing, for example with
stm32l4x5_usart-test.c should we shuffle the includes.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/timer.h              | 5 +++--
 tests/unit/test-aio-multithread.c | 2 +-
 util/main-loop.c                  | 2 +-
 util/qemu-timer.c                 | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 406d7411203..8b561cd6960 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -786,11 +786,12 @@ static inline int64_t qemu_soonest_timeout(int64_t timeout1, int64_t timeout2)
 }
 
 /**
- * initclocks:
+ * qemu_init_clocks:
+ * @notify_cb: optional call-back for timer expiry
  *
  * Initialise the clock & timer infrastructure
  */
-void init_clocks(QEMUTimerListNotifyCB *notify_cb);
+void qemu_init_clocks(QEMUTimerListNotifyCB *notify_cb);
 
 static inline int64_t get_max_clock_jump(void)
 {
diff --git a/tests/unit/test-aio-multithread.c b/tests/unit/test-aio-multithread.c
index 0ead6bf34ad..c24200a7121 100644
--- a/tests/unit/test-aio-multithread.c
+++ b/tests/unit/test-aio-multithread.c
@@ -443,7 +443,7 @@ static void test_multi_mutex_10(void)
 
 int main(int argc, char **argv)
 {
-    init_clocks(NULL);
+    qemu_init_clocks(NULL);
 
     g_test_init(&argc, &argv, NULL);
     g_test_add_func("/aio/multi/lifecycle", test_lifecycle);
diff --git a/util/main-loop.c b/util/main-loop.c
index b8ddda8f5ee..b462598f76e 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -162,7 +162,7 @@ int qemu_init_main_loop(Error **errp)
     int ret;
     GSource *src;
 
-    init_clocks(qemu_timer_notify_cb);
+    qemu_init_clocks(qemu_timer_notify_cb);
 
     ret = qemu_signal_init(errp);
     if (ret) {
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 56f11b6a641..2a6be4c7f95 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -637,7 +637,7 @@ static void qemu_virtual_clock_set_ns(int64_t time)
     return cpus_set_virtual_clock(time);
 }
 
-void init_clocks(QEMUTimerListNotifyCB *notify_cb)
+void qemu_init_clocks(QEMUTimerListNotifyCB *notify_cb)
 {
     QEMUClockType type;
     for (type = 0; type < QEMU_CLOCK_MAX; type++) {
-- 
2.47.3


