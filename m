Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B73C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 15:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKJcX-00060c-Ua; Thu, 20 Jun 2024 11:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKJcW-0005xF-1M
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:22:40 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKJcS-000808-56
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:22:39 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57d1d45ba34so1111732a12.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 08:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718896954; x=1719501754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bRGnfZngJdWMgOcvZ7TtStbP9AmubDNWr9Hu5lfqXOc=;
 b=TQfrIIcMPQNzMrq1HAoou3OeloPIpZ5lqYyD8XbTptKRd7iLdzYAiDaNqRhMNXt/hD
 GV0OXTr1wtO8GfAuApDxq8hKCmMkif+Ilbs/HsnU1A6+vRoMOONwrHa500sD0B0/WK+y
 FHqal7HmCQ0ckUi1GR+Kms1vsQTp6V5Xxw/qz8xoDvvLr6LPmluwvtgpYGSmSf16bM3Y
 Re5NFwcrX+1Z7QucGMx+BBKxnRWBKqRx2F+C+SsTu0bGd9i0jtdsm0nSWHj+VSyzKIvU
 ZfOh11SY7ws0xImkXRpfl11mgK5iVGz0KnhZ0IiNl+sOfZzSuJCC8+7zqYocX9RJIFED
 WfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718896954; x=1719501754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bRGnfZngJdWMgOcvZ7TtStbP9AmubDNWr9Hu5lfqXOc=;
 b=TdbBRAxrkaXs9Wfc6zOlH3jRDqbLtRiRLlkxnIvqyPmCNQNdgqGt7TynPDcRANMyIS
 jqj8Hc1quvfRTrAiitPFY5yoe23TgPPRd/ETyfoRX819tvCs/wsD5K5EdGZ3wldQQfb+
 YzZyfn+ll7yZnWQqry5gu37j1k/JRhbTsgUlsL2bj7g0wwEwMZIfOHE3ytX2Ivwcq59F
 qXODwVMk/pdyxqglWQ51F661Lab8E+og48Q7WyDQFzLsEJg+A4he9dE995yQQ72RQwht
 ggOfX5n92PVgP/U+9F2vtCH3A58KVTG85Iu4dHP39KYokaWg8Jg00GC2h1Lm6DJctUDT
 SPnw==
X-Gm-Message-State: AOJu0Yy+Edq06lxh2lDFqQrorBHP3VFHmnY0H9zRAzugmOBbp3YpGfmy
 eMcn5R0zUCztktCApo68Za7lSpOAu5GROvvAvr4tO1EtsXODj9c8tdNCAKB71c4=
X-Google-Smtp-Source: AGHT+IEiVE4x6H+fZARaO4Zg3BaGTcyG+2ERR3isx5aQQpt7wxoNKnSQpwaFZQ2FBRWx1WpkNkdG7g==
X-Received: by 2002:a50:9f4a:0:b0:57d:5ac:7426 with SMTP id
 4fb4d7f45d1cf-57d07e66c47mr3246096a12.9.1718896954416; 
 Thu, 20 Jun 2024 08:22:34 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb72e9115sm9869605a12.46.2024.06.20.08.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 08:22:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 81C2E5F9FF;
 Thu, 20 Jun 2024 16:22:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jamie Iles <quic_jiles@quicinc.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-arm@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marco Liebel <mliebel@qti.qualcomm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Nicholas Piggin <npiggin@gmail.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 05/12] qtest: use cpu interface in qtest_clock_warp
Date: Thu, 20 Jun 2024 16:22:13 +0100
Message-Id: <20240620152220.2192768-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240620152220.2192768-1-alex.bennee@linaro.org>
References: <20240620152220.2192768-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240530220610.1245424-3-pierrick.bouvier@linaro.org>
---
 include/sysemu/qtest.h | 1 +
 accel/qtest/qtest.c    | 1 +
 system/qtest.c         | 6 +++---
 3 files changed, 5 insertions(+), 3 deletions(-)

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


