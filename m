Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE023CDD55C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 21:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr1zU-0007vU-UF; Wed, 18 Sep 2024 17:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sr1zS-0007gg-5j
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 17:13:34 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sr1zQ-0002Di-IB
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 17:13:33 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a8d6ac24a3bso26731566b.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 14:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726694011; x=1727298811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=njwup9bdkkn3Pmq6MgNZmWDd6Jmwa84hQ2yWGTmpHoI=;
 b=aBe0ym9ZbcgL0aG11GJLg8PVCM4f10DVuaqrSi70cs5MkMyynY3j0ysWXwDD2ziBPP
 zObRCJPqoTzBwOGAPU0FnN9zia0cyBUmvB6ytRBH5f+XAN7Ke9UPpmKZA/u/RoQpetdc
 ekt9zgmEyEzT+DKiD+TwCWhrVlQRZlGNw/3VGtCloRqvoXxTS5+W/B+ML8TmDbE/CEYD
 vbaCD4G5rth1dw0uqfxRAp6Ex7rJ3vLBNeNPNToWbbJpXuJ5pFWQEkjB+x2Mvh/9BnWM
 9nZu9gS5XnhOMZCHRmnlgZ3vHcg30bPjLtOBl1ltshhcniJmuebbLTEhmaIE49zWBTYg
 8L3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726694011; x=1727298811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=njwup9bdkkn3Pmq6MgNZmWDd6Jmwa84hQ2yWGTmpHoI=;
 b=nMw+JwmDJdxKUugjAqcU2N85N2srzUouWpml32GyGWhK26SIFexCmgjNmuttNKSQwB
 tSdmpQhzJVMH7WdGZ3jIiM1qUH8lpgZHlTA2bOAVzbeZoJSJjZNRwTsUyoLkFF+UcseP
 O+TWaZGOCvXMeFSoFJMDhqAHX0TFcSJIHJDPzxpvvxeKIYHt80Tvg/0y2HbU1Fxw2Lx+
 8C+fwLbV4m6GeD6huCdFU2pW42ZNNzAvLnsiH3WlMtSImiZU6HnR2729uNTmUBl9qmNc
 Z80RoOpaQmUqkLiz7CT7Pl+B3L1FiOhmhu949ijHA6iqIrm72/c72hqR5l/gKhtMrzN6
 EiDA==
X-Gm-Message-State: AOJu0Yx05fgQTeEAjhohrG/u4S2bUhcSB3cMVkdIWBmHq/98CRXeQ8zL
 BnDY1BLUFFKBwrAbulIpcVM2EKmArjH65iEV9MlW+G7uYuAFLIvu7Gm4aRg1DIU=
X-Google-Smtp-Source: AGHT+IFgUaMh83XdHml1ayAdv3b2I/RAdmvJ5owbx0Rw75ng6AYmvaL1/iuXN7j7FHP3K5SiUTCaWw==
X-Received: by 2002:a17:907:7288:b0:a8d:4c83:d85d with SMTP id
 a640c23a62f3a-a90c1c77fc6mr100022766b.12.1726694010605; 
 Wed, 18 Sep 2024 14:13:30 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612e4b87sm644766366b.179.2024.09.18.14.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 14:13:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9A24B5F885;
 Wed, 18 Sep 2024 22:07:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Elisha Hollander <just4now666666@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 14/18] util/timer: avoid deadlock when shutting down
Date: Wed, 18 Sep 2024 22:07:08 +0100
Message-Id: <20240918210712.2336854-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240918210712.2336854-1-alex.bennee@linaro.org>
References: <20240918210712.2336854-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

When we shut down a guest we disable the timers. However this can
cause deadlock if the guest has queued some async work that is trying
to advance system time and spins forever trying to wind time forward.
Pay attention to the return code and bail early if we can't wind time
forward.

Reported-by: Elisha Hollander <just4now666666@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240916085400.1046925-15-alex.bennee@linaro.org>

diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 213114be68..6b1533bc2a 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -685,10 +685,17 @@ int64_t qemu_clock_advance_virtual_time(int64_t dest)
 {
     int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     AioContext *aio_context;
+    int64_t deadline;
+
     aio_context = qemu_get_aio_context();
-    while (clock < dest) {
-        int64_t deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
+
+    deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
                                                       QEMU_TIMER_ATTR_ALL);
+    /*
+     * A deadline of < 0 indicates this timer is not enabled, so we
+     * won't get far trying to run it forward.
+     */
+    while (deadline >= 0 && clock < dest) {
         int64_t warp = qemu_soonest_timeout(dest - clock, deadline);
 
         qemu_virtual_clock_set_ns(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + warp);
@@ -696,6 +703,9 @@ int64_t qemu_clock_advance_virtual_time(int64_t dest)
         qemu_clock_run_timers(QEMU_CLOCK_VIRTUAL);
         timerlist_run_timers(aio_context->tlg.tl[QEMU_CLOCK_VIRTUAL]);
         clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+        deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
+                                              QEMU_TIMER_ATTR_ALL);
     }
     qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
 
-- 
2.39.5


