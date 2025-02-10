Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8792C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWRx-0005o0-RA; Mon, 10 Feb 2025 11:15:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWR5-0004AV-4P
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:04 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWR2-0001VL-Cf
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:02 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ab7a342ef4eso446512166b.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739204099; x=1739808899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5De79NWbhkU5BW07foJEsOJqUNxurUAkpHc9PcGIKnc=;
 b=upjZqEADPBeOw6gl4+8dckuQGvoAhVOo+Glup/H6aaXWGgkzNkOWgNsuL6jP9yr71J
 YOvTzjxWejXZ1T++uOdHPKKpY4p/tBjRLhqGpG1rNubu5sfQpdhr0N7P1pbG3DFQeR2t
 1SXugAQQeRLLD9dZU53xcYNlhO+fAPAijf3SCJcBA4dczfYorvZ6vgPOhzjEdJgyABcb
 XrNh/5lrxUg/CmnncrUtvMLJzs8gaHcP5aOmBELDoL39nWsznNZjc5zm6DZa1e0FyqMo
 u2y8CzSKze603aovms96i8L5QUOP35iD7vHV/IpA5OxWfpVcqx1G+oP4uo5jr1W+5pXw
 Z7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204099; x=1739808899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5De79NWbhkU5BW07foJEsOJqUNxurUAkpHc9PcGIKnc=;
 b=e6hhx4VzXxcNgRFR3wf+mdtOCzcArnKPOAtq9+n0jaO2886GGeVYx8pYufGJbPHF9F
 BZaKq09EWF3YLpLot4N4+wUbM1RzKocTGP073950qoc6hWCQDN5tIPocSXSYy2w//e/8
 ixxrCpaL1Rv9ZfwnImJOtPd8rkAt7Eecn0M5JZpn9KkZtHV94FA7mNuysUhnvtnBe1we
 ze8IDMAYGJXkbsRkF9G8EuR9cUkmQ2An08jvIclKgMMVJ8eN+u/WSO79RhhW/IitX29u
 xEyeqz+RUcdPf9gbzDRh2EGWNotrtDGxVuMmbNcYWM0Pd8ODV47iBC4xJtD9VbtX95v0
 tohQ==
X-Gm-Message-State: AOJu0YxVZbBxAXFmgsDNdMNumJGMS5nNaTFxBUuSmfXVxXqKtcVDLGga
 iphj3jMU/JKV91/7OD+WUF8E9otbHHSS0mAXE3gJDl7JFfmdMHQAusspn+zBjvM=
X-Gm-Gg: ASbGnctOR6NW2r0+KrzjiNK862reM2EZnbOILV5DH01uPc7uJuQeKSu04kRBOD94lpG
 2i6hYDh7evBZnwu42Frb6tjRURr0yKr2vlByFJC4tefOm4ARma0+I+J2fD4lSymSKJNz5l0UXZI
 NHREreaD75/PzMfHVl611j1TtXiGJXUgQSe6dpxUStv6K31fI5JlPvBf0SxGE1R4NMHA5bKJI4m
 aZ3ZvOM71oJPQw233TD2fv4eYMIpoQcbybmY218SS4x/Okj9xDrr57gSULbQqGnm2l0XtnygP4F
 p6pGnzWmD/dM9L5Ubw==
X-Google-Smtp-Source: AGHT+IGsLT8DOAIv7Tr2e6mhHhqjUvXua6nW6MZkTLnr8ts3Va56wgaujNw0fPOHkao88QsD/lGijw==
X-Received: by 2002:a17:907:948a:b0:aac:29a:2817 with SMTP id
 a640c23a62f3a-ab789b22c1dmr1355930766b.26.1739204098809; 
 Mon, 10 Feb 2025 08:14:58 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7845d8810sm792990466b.72.2025.02.10.08.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 08:14:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 601866022C;
 Mon, 10 Feb 2025 16:14:52 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 07/17] Revert "util/timer: avoid deadlock when shutting down"
Date: Mon, 10 Feb 2025 16:14:41 +0000
Message-Id: <20250210161451.3273284-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210161451.3273284-1-alex.bennee@linaro.org>
References: <20250210161451.3273284-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This reverts commit bc02be4508d8753d1f6071b77d10f4661587df6f.

Now we catch attempts to clock_step to the next timer when none are
enabled we can revert the previous attempt to prevent deadlock. As
long as a new target time is given we will move time forward even if
no timers will fire. This is desirable for tests which are checking
that nothing changes when things are disabled.

Previously most tests got away with it because --enable-slirp always
has a timer running while the test is active.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250207153112.3939799-8-alex.bennee@linaro.org>

diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 0e8a453eaa..3243d2c515 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -675,17 +675,10 @@ int64_t qemu_clock_advance_virtual_time(int64_t dest)
 {
     int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     AioContext *aio_context;
-    int64_t deadline;
-
     aio_context = qemu_get_aio_context();
-
-    deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
-                                          QEMU_TIMER_ATTR_ALL);
-    /*
-     * A deadline of < 0 indicates this timer is not enabled, so we
-     * won't get far trying to run it forward.
-     */
-    while (deadline >= 0 && clock < dest) {
+    while (clock < dest) {
+        int64_t deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
+                                                      QEMU_TIMER_ATTR_ALL);
         int64_t warp = qemu_soonest_timeout(dest - clock, deadline);
 
         qemu_virtual_clock_set_ns(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + warp);
@@ -693,9 +686,6 @@ int64_t qemu_clock_advance_virtual_time(int64_t dest)
         qemu_clock_run_timers(QEMU_CLOCK_VIRTUAL);
         timerlist_run_timers(aio_context->tlg.tl[QEMU_CLOCK_VIRTUAL]);
         clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-
-        deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
-                                              QEMU_TIMER_ATTR_ALL);
     }
     qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
 
-- 
2.39.5


