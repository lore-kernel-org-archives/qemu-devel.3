Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB50C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 22:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCnul-0007Jq-3N; Thu, 30 May 2024 18:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCnug-0007Ie-Fp
 for qemu-devel@nongnu.org; Thu, 30 May 2024 18:06:22 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCnud-0005Ct-Ao
 for qemu-devel@nongnu.org; Thu, 30 May 2024 18:06:22 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f3469382f2so10771695ad.0
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 15:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717106777; x=1717711577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N8fpp15niTkZ3IPMy6ehe10O59rmldsghTOZNCkMcuE=;
 b=uXfmLAvbTG40rlfp+Eh/ZyZwWXGLjQUitwuIdTbO+qU5NsQtjxGol0+tTVzyCjgus9
 cqP36pTPTuDTqHyKxNVM1HvmkM4J8Woq2BYWxxt0zI4t2AhfW36vkWusFGICZ7+4bpyJ
 3Q1MQBoaNzxQud6ruEzgdPkhFCGRuKT7xvs+We7MbiIolProzftjngoLwSXACQHYIhvg
 Rj0XJ+wdn8XaDCb5tLqsQmaYdzAVSD6+Jp+TsDZZwl/YRrGL0o2XKU0Es7UzVNuXbies
 qOKPh6W+Htog3oDVdQdnrgMlhJLM47w1zpqkgXsAYX2ybci8O+wjvxSBDS/ct4s7aZnc
 XkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717106777; x=1717711577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N8fpp15niTkZ3IPMy6ehe10O59rmldsghTOZNCkMcuE=;
 b=t6vBFCSu8+Tk+9eW0+LyNGoUseHmqLcktmJszhqYVGPMMndaAd7SSAQM1naG2zHpzE
 SUou6ZQ6KImq6kcCK3r2ZVDO/RkjdKx1+AtoH1isDcG2a0zVHINwTGMp/8RKN7XZcXLb
 2yxkhFzbD4k6jmZr3mA8bfs4apLwQ1xl6bx+WhEzul4At/6OM+fZntyuBLv4TOQZGLgo
 JIQ6OX6toK+2M5YP9nYFhwfUX2pDXMyln7MnzWEwy2AjXEwiwuQTPnFtgdnmPB2aJYh7
 QK4tRcsfSFhMhWCE0eC6UqX4zndBbE7r1DXbOSpIx2t7j8ZgpioxjyGV0hm8eOs9JnV8
 oFxw==
X-Gm-Message-State: AOJu0YzFpmtsAroPagB1tgJReiGDgNP6W6ItschZKgftifQN13jxkZtx
 uc3xVxPtNntpRMzIbfSvaaQe/94a2fc6koQPEfnMeBGnFDSHhgeFG7suSLms8/zde0JX06py+7x
 qsiI=
X-Google-Smtp-Source: AGHT+IHvXyuRMaWfcMFit2oU/D04NDtEBg7V53ewxmsrrRo11HAQLdnFXBVQBUELxvJuTTM0jDd4YQ==
X-Received: by 2002:a17:902:d490:b0:1f4:8738:64f9 with SMTP id
 d9443c01a7336-1f63702772amr1916035ad.39.1717106776896; 
 Thu, 30 May 2024 15:06:16 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323dde39sm2732615ad.167.2024.05.30.15.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 15:06:15 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 2/6] qtest: use cpu interface in qtest_clock_warp
Date: Thu, 30 May 2024 15:06:06 -0700
Message-Id: <20240530220610.1245424-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240530220610.1245424-1-pierrick.bouvier@linaro.org>
References: <20240530220610.1245424-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

This generalises the qtest_clock_warp code to use the AccelOps
handlers for updating its own sense of time. This will make the next
patch which moves the warp code closer to pure code motion.

From: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/sysemu/qtest.h | 1 +
 accel/qtest/qtest.c    | 1 +
 system/qtest.c         | 6 +++---
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
index b5d5fd34637..45f3b7e1df5 100644
--- a/include/sysemu/qtest.h
+++ b/include/sysemu/qtest.h
@@ -36,6 +36,7 @@ void qtest_server_set_send_handler(void (*send)(void *, const char *),
 void qtest_server_inproc_recv(void *opaque, const char *buf);
 
 int64_t qtest_get_virtual_clock(void);
+void qtest_set_virtual_clock(int64_t count);
 #endif
 
 #endif
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index f6056ac8361..53182e6c2ae 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -52,6 +52,7 @@ static void qtest_accel_ops_class_init(ObjectClass *oc, void *data)
 
     ops->create_vcpu_thread = dummy_start_vcpu_thread;
     ops->get_virtual_clock = qtest_get_virtual_clock;
+    ops->set_virtual_clock = qtest_set_virtual_clock;
 };
 
 static const TypeInfo qtest_accel_ops_type = {
diff --git a/system/qtest.c b/system/qtest.c
index 6da58b3874e..ee8b139e982 100644
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


