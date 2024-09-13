Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3C0FC6169
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 17:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spA4r-00070a-Nq; Fri, 13 Sep 2024 13:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1spA4l-0006ZL-SV
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:27:20 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1spA4b-0005wk-0T
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:27:16 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a8d56155f51so287872766b.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 10:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726248427; x=1726853227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRFhj2SyvQ/EIwHMRij/KsWIl6x9+a8v4XWFbD+c1P0=;
 b=DX6jTn7seE8vwRwsLwL+3+FTsU1smTjiFVjGrTqcKNA6gC0gvJOJGUepSEV1pODg69
 HZSdq8ffQ7r6kfDUHuhHoYjULl7hHR0C1Gfo6yWO7rxfeGUPmdg6lryZSUdoSYJTEnMT
 SVg7tcsZidJ3esPbBpju/CPg/gn0crSRgCFgF8mhkkZv7nZ202Xx20XA89FtHNQqCVbd
 FF/pGEA3LXXTiXNv2pnBqC2VWgyo0zA87JLYVFg2RbSFi5pR+DCdLTxyXjyys/Nh+au+
 c0c+PBSqPiF7ASuJmWjk6o7NDhQlzAh61A2VZCCXQIR+ITYDwRHWoz3eJjwtTZPBcIhA
 tDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726248427; x=1726853227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cRFhj2SyvQ/EIwHMRij/KsWIl6x9+a8v4XWFbD+c1P0=;
 b=RnmyMZ0PYthmvWUdkDYmArtXeMui5l6U4tvqS9R0cubyeFpJWcJyqz/CpBMe8F0Egg
 a9QVtv21o4d7sM0nc91hu1OITLKmlZSkIIJZcjFTzmy7NmBX2DF+3vsDF16IdfHWEFdi
 E3SVMA2zPCx1l4flQaHPQuzwbUbZ8lm9SlPbqhS4WYrqv+16VMB0tUw0PSXsOer7qWUZ
 PGgK0T6a8fR4TB4E66sPf6RxXbIrIFK4FRz0ltu4nRqkA4E8FQNt1hlvSEBqzhOG3MsN
 MCWaTcTDBfeD1s5WnKauZNcLY4/nUWBbl6ien8YnJ6Wmub4XLY6amX2sKRDZxS15d1+o
 gTPA==
X-Gm-Message-State: AOJu0YzzCOf2offFyWFKeB+S1Afv9SQfKmih8RwZ+KYW6B7fsGhv33Vf
 PExEK12dk7RzlUa4hKgmkS9AsKo7bZgg/+pwZP+mOX1014sG5XSgd7cVT8st4yM=
X-Google-Smtp-Source: AGHT+IFEssuOh4nHWOQg2vaid2IvdMu0VoHunUT5e4k77Lywp4vfGgoqhcpLcKANPhvfCdiXA7/Uhg==
X-Received: by 2002:a17:907:60d5:b0:a8a:cc5a:7f3c with SMTP id
 a640c23a62f3a-a90296715f7mr632864466b.58.1726248427294; 
 Fri, 13 Sep 2024 10:27:07 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25d657fesm896408366b.221.2024.09.13.10.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 10:27:06 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 832615FB3A;
 Fri, 13 Sep 2024 18:26:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, devel@lists.libvirt.org,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-s390x@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elisha Hollander <just4now666666@gmail.com>
Subject: [PATCH 14/17] util/timer: avoid deadlock when shutting down
Date: Fri, 13 Sep 2024 18:26:52 +0100
Message-Id: <20240913172655.173873-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240913172655.173873-1-alex.bennee@linaro.org>
References: <20240913172655.173873-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

When we shut down a guest we disable the timers. However this can
cause deadlock if the guest has queued some async work that is trying
to advance system time and spins forever trying to wind time forward.
Pay attention to the return code and bail early if we can't wind time
forward.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reported-by: Elisha Hollander <just4now666666@gmail.com>
---
 util/qemu-timer.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

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
2.39.2


