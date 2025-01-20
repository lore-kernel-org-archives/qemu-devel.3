Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A84C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 21:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZyuy-000267-VG; Mon, 20 Jan 2025 16:02:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tZyug-0001g6-0U
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:02:28 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tZyua-0002xo-RG
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:02:24 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5db6890b64eso903120a12.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 13:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737406938; x=1738011738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OdEyfb2ARjEb4j0/bYd/22LdLj+HvII9zUuxIjGCbvU=;
 b=HStwBCVV+8cg0Ohbz26qptk2rHQSjHESSNfrA3pcjKGnsjAETjBZj9ntDVnzS/24HT
 OrOjGNklqe4lvURAgpxyGGAbqatD0W2pYFeHiQG3iZt5PUXlJqlDj4N5RAh4hVeBUCmf
 Ri3R0eyYBi86JiwVM22nVM/wGS3gAB5e0ApT6M0ZJYi60Rb5+RDVRN7B4W2jqwSU7rbq
 bYgK7bHocluasme3K8gQGOhTqIYu34/RLGCgy4LHO6IDD8n1q3bZOkO14flQlxqj5Ctm
 KJcEfPtbK2kQ78UARdxXjd+kYnWiJkH2ABHP5QwqCmnPcktE+MtHOLUsVobuy8BB9Y5S
 3e8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737406938; x=1738011738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OdEyfb2ARjEb4j0/bYd/22LdLj+HvII9zUuxIjGCbvU=;
 b=HDlYhy1TALX7MLT05nxfYEHaFN2oWEFsBDsZh5D9uE93jVb3i1TBGpjd4RzYDuQJZk
 qnZykFk7PGYPu4y6AwDXmH5lhHgaSipY+yFaZsQuTFqvCzbSn7f+3DlVCJfe/nvVG7/k
 4+cCBhk5PkUPOSzdDMbsHXuByOYOG4WezAVwU1uy86rD+/mH77WgIA0kVL+g8bw9Dl+L
 eO+R6nw5rYUnEU288BV+mdAstKidDnE1AW8OK5HvECmooeJICkyXNZfu8q5T5xobRdWj
 C5Khxpclf8bpITIiEDqNALw5AvgalBF2IbiGDMZaa54dj51OX1pahXUpagkS0hHgb+T0
 bm/g==
X-Gm-Message-State: AOJu0Yw23tzV+X8piwrqhOagW3wlfJ3d3pj3QQtfWtFeouGnuQwcxZkN
 OEJOjtO/b4iB0FugGsl0/o/ObSr1mgmJJzjnHV1eniooJ2L63WPhx0ybPggSPZI=
X-Gm-Gg: ASbGncvnJ99/VcfLK06/6/ShSa6Ti9vd26fqf/OxXKc5FtHQv5aVVzx/+yDlg4MC7/B
 Xc4ewkNJKuyztOLUTHfZ5YYrCuqE2dKxo8RG5CPThN2bEuJ9BlSAswS72YelK6xs35Xtyc5w14c
 51QFTUlkc54Hji74E5YegXENVuSbXpaCJSnG/5HXB+ENj83SELGBvJ4Kfz7TPzVMVJOOoG4OzeE
 aGcmPqR7UzBs/epKqFnFq49QQuWjqRUtoO8zmvWXCrqSbJjbzCMG6SzvgawxUQuPj51
X-Google-Smtp-Source: AGHT+IHYOrV2AkrCkjouwR2FubG4ppJNT0S9l5He72NQtHptGiCwyEwuJQMJ9i9Q3BmOYHTfQcWExA==
X-Received: by 2002:a17:907:7e95:b0:aa6:715a:75b5 with SMTP id
 a640c23a62f3a-ab38b44d44fmr1166183966b.46.1737406938130; 
 Mon, 20 Jan 2025 13:02:18 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f86fe9sm664667166b.135.2025.01.20.13.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:02:16 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 73BA35FA4B;
 Mon, 20 Jan 2025 21:02:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 7/7] Revert "util/timer: avoid deadlock when shutting down"
Date: Mon, 20 Jan 2025 21:02:12 +0000
Message-Id: <20250120210212.3890255-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250120210212.3890255-1-alex.bennee@linaro.org>
References: <20250120210212.3890255-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

This reverts commit bc02be4508d8753d1f6071b77d10f4661587df6f.

Now we catch attempts to clock_step to the next timer when none are
enabled we can revert the previous attempt to prevent deadlock. As
long as a new target time is given we will move time forward even if
no timers will fire. This is desirable for tests which are checking
that nothing changes when things are disabled.

Previously most tests got away with it because --enable-slirp always
has a timer running while the test is active.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
---
 util/qemu-timer.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

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


