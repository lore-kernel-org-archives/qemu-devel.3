Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24D0C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 10:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLgmf-0006oK-VK; Mon, 24 Jun 2024 06:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLgme-0006mc-4E
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:18:48 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLgmY-0007gi-Mr
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:18:47 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a6fe61793e2so92326166b.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 03:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719224321; x=1719829121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DnPYMS9aYu3Dj6IJQtGryC0W7EDGLSoROmhQZYsJ9o8=;
 b=SkgGU456E/eRQZtALQKNApf6IQXAJEzetyKxLSdL0OxPh9ITqvCih2DW+mCjwLOPRh
 tRsFof4yWrj214CYktrFMHrE+eBxqpa/CF6yqecSvYsKi7U+yWbNCvN810pkZ/IcgvRh
 osshWM7tVa8jxn1IWZSNouZTMJJH5acRoeIUKCGcvDyO9K3rRVWu7/m8SMO5kPSaXcSf
 /+59GeuhAacrZKyYdyGnM+g7nFJfsP87NEbk3Yl9UpsTp9S+kJRg4LqQ/71qMskB9tS4
 zeddr9vM2P2Y8dKB4vd9LUFT/FTHaXpo1tPY5UD8dx7xNegJwSLPdhcRTHqy0/MvYhih
 oKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719224321; x=1719829121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DnPYMS9aYu3Dj6IJQtGryC0W7EDGLSoROmhQZYsJ9o8=;
 b=HB9UPveOPwVyvhSL9ricmCRow5jqQBCXuqmVOEKv/J8FB+m/SVe4LJzfmA31JS7V/z
 TFDp0nM0jihcxZwQXctwq0VD9QubHz1U754Q+Vo+mVxwm02fN6IC2353UDV5RJP551wr
 oQ6VLbSVz7RCAo7l+MUotmMQGrJMVet+zqn7EiBp+CY9N6vPJ65vVXgxxlmWaG+f+Cc0
 qg1OjHFKFDi+lNt/zMeYcG3apKI7zWsRPM7yMSIqFToyzYlInL+IgH0N/EStvXQG6clr
 foHqmm2iTpHbBYOqmOUy4i6NymDlbiLQw6XIUmhEVUpT3+fSzA2HFPU82UP8eEjNvweE
 2NCw==
X-Gm-Message-State: AOJu0YyjRtNIqcxIawOrEuOnHy1k5eGqYYJ2VODGajrUPBDwJUMGjro5
 6947F6B+f7SHKmm4F42HBfnDMkXFEFdbTJbWnllwrj/ekopJFfyhWRduEaYSW0o=
X-Google-Smtp-Source: AGHT+IGwR4NEtHCek9W3waMcRLouJdItHMJoas8iVZ3gRebQxMeepupzKLm8cZoLyvO41bsz0ny7lQ==
X-Received: by 2002:a50:ab5b:0:b0:57d:2659:9143 with SMTP id
 4fb4d7f45d1cf-57d4bde078cmr2805979a12.37.1719224321011; 
 Mon, 24 Jun 2024 03:18:41 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d303da378sm4442631a12.18.2024.06.24.03.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 03:18:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CBC6C5FA1B;
 Mon, 24 Jun 2024 11:18:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 05/12] qtest: use cpu interface in qtest_clock_warp
Date: Mon, 24 Jun 2024 11:18:29 +0100
Message-Id: <20240624101836.193761-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240624101836.193761-1-alex.bennee@linaro.org>
References: <20240624101836.193761-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

This generalises the qtest_clock_warp code to use the AccelOps
handlers for updating its own sense of time. This will make the next
patch which moves the warp code closer to pure code motion.

From: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240530220610.1245424-3-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240620152220.2192768-6-alex.bennee@linaro.org>

diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
index b5d5fd3463..45f3b7e1df 100644
--- a/include/sysemu/qtest.h
+++ b/include/sysemu/qtest.h
@@ -36,6 +36,7 @@ void qtest_server_set_send_handler(void (*send)(void *, const char *),
 void qtest_server_inproc_recv(void *opaque, const char *buf);
 
 int64_t qtest_get_virtual_clock(void);
+void qtest_set_virtual_clock(int64_t count);
 #endif
 
 #endif
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index f6056ac836..53182e6c2a 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -52,6 +52,7 @@ static void qtest_accel_ops_class_init(ObjectClass *oc, void *data)
 
     ops->create_vcpu_thread = dummy_start_vcpu_thread;
     ops->get_virtual_clock = qtest_get_virtual_clock;
+    ops->set_virtual_clock = qtest_set_virtual_clock;
 };
 
 static const TypeInfo qtest_accel_ops_type = {
diff --git a/system/qtest.c b/system/qtest.c
index 507a358f3b..5be66b0140 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -332,14 +332,14 @@ int64_t qtest_get_virtual_clock(void)
     return qatomic_read_i64(&qtest_clock_counter);
 }
 
-static void qtest_set_virtual_clock(int64_t count)
+void qtest_set_virtual_clock(int64_t count)
 {
     qatomic_set_i64(&qtest_clock_counter, count);
 }
 
 static void qtest_clock_warp(int64_t dest)
 {
-    int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    int64_t clock = cpus_get_virtual_clock();
     AioContext *aio_context;
     assert(qtest_enabled());
     aio_context = qemu_get_aio_context();
@@ -348,7 +348,7 @@ static void qtest_clock_warp(int64_t dest)
                                                       QEMU_TIMER_ATTR_ALL);
         int64_t warp = qemu_soonest_timeout(dest - clock, deadline);
 
-        qtest_set_virtual_clock(qtest_get_virtual_clock() + warp);
+        cpus_set_virtual_clock(cpus_get_virtual_clock() + warp);
 
         qemu_clock_run_timers(QEMU_CLOCK_VIRTUAL);
         timerlist_run_timers(aio_context->tlg.tl[QEMU_CLOCK_VIRTUAL]);
-- 
2.39.2


