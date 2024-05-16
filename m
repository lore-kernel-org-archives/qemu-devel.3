Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FE6C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 22:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7jTV-0006m8-Ex; Thu, 16 May 2024 18:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s7jTK-0006bs-90
 for qemu-devel@nongnu.org; Thu, 16 May 2024 18:21:13 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s7jTH-0003Bd-Lp
 for qemu-devel@nongnu.org; Thu, 16 May 2024 18:21:09 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6f4302187c0so539314b3a.1
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 15:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715898065; x=1716502865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K9/6iNsaG2WmKJUo8RO+PQUPavM6bWCYZObihw+51LY=;
 b=bM1XhnVZMu4DzAv3fuvdrU6BxX3bDE3KRJNkpJRkH0CH+xfcEjaXnxzu2RXljndi+v
 bhYbel0LFlrJDaFWejvhEL+eyE2Tmv6os3k3lbb3yOFVUgT/H6Nd7xI0cRK+wb+1SK+c
 VUDKxqh3Fhm5GPvNn7cf5ZMlXBrhU/apv1U1ONn30XlJ1EsLjRiOQomJ3yvrD/uRlFoD
 OV+e0DIQCb9K+r3xlgzU1yuau9szazxm2vJt0R977LiQVPa/0Gn+0b7Do5xeM4wgkwL3
 VyB0ikUvrg6JOzmVCNRhhkakuWaW+oJjOI44RbRV4GW/la7VQei/c0TnBEDHGeS753xQ
 3Xcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715898065; x=1716502865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K9/6iNsaG2WmKJUo8RO+PQUPavM6bWCYZObihw+51LY=;
 b=GcIAToTlQaIVzc/MgjOxQvt4qR9VEYYH3p0S6ocq0IJQeRq6M0AG2LBf0L694LlXxl
 gAfVO/Ohz7H8qrJlE0hrBnumeDcddyoxNbLFl/vM/NeylnGs1ykZr23nCrHd1Z3CCc0Q
 n9K9TCLhM6PKm2abPrct83hMsdHeprLivlz0SADyS0/QjbVnldBfC7Bujxx2U8wpwX4o
 q3DmrRelWVFalk2wVRUs1tmjnwjtFrBYQ3dxM6JNragtVujLDlVqbT6ZKfdSXiBPc8FV
 jAeRfZ9QwxVKv9qa2+paLqgXhZbgUSUFs6gz8Ear523OploQX0oheCAYNoIWd9JTz7PA
 K9xA==
X-Gm-Message-State: AOJu0YwIq60eVXnbM8f/LwlgrEeALqwfZlt37vQzynesccz0qswq70Tb
 8Hvw00naltA2vH5y+lvIFmf8Fv1eqKZieb1JaWznDddpONzrZT+o5JOTim5p2q0VQTmIflEu5+z
 j148=
X-Google-Smtp-Source: AGHT+IHBRkAcW9HEiirf+kabpWS3R2hfmOCv5ngiWkVLWF2yaNM9LyzUJJwuLvdcZnvqaWMYLR9LIw==
X-Received: by 2002:a05:6a20:914f:b0:1a8:2cd1:e493 with SMTP id
 adf61e73a8af0-1afde1c576amr30444273637.29.1715898065079; 
 Thu, 16 May 2024 15:21:05 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a66476sm13589219b3a.28.2024.05.16.15.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 15:21:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/5] qtest: use cpu interface in qtest_clock_warp
Date: Thu, 16 May 2024 15:20:44 -0700
Message-Id: <20240516222047.1853459-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240516222047.1853459-1-pierrick.bouvier@linaro.org>
References: <20240516222047.1853459-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

This generalises the qtest_clock_warp code to use the AccelOps
handlers for updating its own sense of time. This will make the next
patch which moves the warp code closer to pure code motion.

From: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Thomas Huth <thuth@redhat.com>
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


