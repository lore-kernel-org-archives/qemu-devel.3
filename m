Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1760C3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 08:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sq7Ve-0002Cc-9f; Mon, 16 Sep 2024 04:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sq7VG-00010N-Gk
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 04:54:42 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sq7Uv-0005F1-IX
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 04:54:36 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42cacabd2e0so35331715e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 01:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726476855; x=1727081655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2OJksstmsifZmCUPWtvTuS/7OYa4HHWDbSpalmz/esw=;
 b=MYMZz8dfTHhx+zBGnP1Eo9BsA2oXgrI8uqfrr/7s5fod+WjeLcjn4FL1iwmnu+HekP
 O1zpQCNMKM/cPQz3x8+Xmul/R4OXY3kBQ4eu4lqZOSKnSPek/lAfEF/z6liTTuL9Jws6
 vK72ctw78hL3rgT6vRs7JP60v+7sNel6wkEDWFhugZlXJPv1ZogM+j4poVWDy31dBEOp
 73L8xgYURYbB5oFwfxd1OOY5ynDxzpxyLyv8TfY5wcYH15geHtgqV3FQCSXh79BLwn4h
 Pz5/Rm/kd+Wla+7IaGtKgbobk0k8HkB0Qhh5WZlWkgCjRK0rP1AAhABI4BoqjBYhcWrU
 mfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726476855; x=1727081655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2OJksstmsifZmCUPWtvTuS/7OYa4HHWDbSpalmz/esw=;
 b=RsXjyzpz1axHdW1LeLcH9ARt6nbXHUsL4+9+s6xSSHFZrRfgbBq9I92q7Am+0w6wRx
 Qti4ptuhgiME68QI57HISsqw/6/YmN9gkLeVuE86JKZ+VImtmGY40YjVqSLK9ZA5fXgX
 Wzp4wgn8nX0xupa31LHACkOdTn2erwcogRb5+eoicKj5uBxDOWgst7vaZ249DcDW4oaW
 KqdoF2F884S1pbFqpV5iKbsemKFIdFi89ZWJDOaVfxpH+WazosWD5bTB0Y27zBrDLPK5
 WYAFG4IsdpNbqQ2rMKibt2Yqh6jNHnBZ9o9tHBrMYtDEru1MRK95hNq+8KU0EnIGPOeC
 8UPA==
X-Gm-Message-State: AOJu0YzTiQaQoaFp19eQ+1GS3Jv2GEWHEM+VV+QYwNpzSyKXlb675YnZ
 eITflD04829bnrw1ScehUKxpGqJMTUR22MD2jqhWXaDaFpc27zvvo/xnUGn9ELk=
X-Google-Smtp-Source: AGHT+IEZ0sRjKV1N/Qm8U1b1Oin7ohk5uU1ZcqfXzDhun3HFbuHzhZ7NKbnAWCDoH71o9CvSs4Nwkw==
X-Received: by 2002:a05:600c:468a:b0:42c:b309:8d18 with SMTP id
 5b1f17b1804b1-42cdb53be54mr96726175e9.19.1726476854713; 
 Mon, 16 Sep 2024 01:54:14 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b15d5bcsm104745815e9.26.2024.09.16.01.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 01:54:09 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A39BF5FCAE;
 Mon, 16 Sep 2024 09:54:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Hildenbrand <david@redhat.com>, devel@lists.libvirt.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Elisha Hollander <just4now666666@gmail.com>
Subject: [PATCH v2 14/18] util/timer: avoid deadlock when shutting down
Date: Mon, 16 Sep 2024 09:53:56 +0100
Message-Id: <20240916085400.1046925-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240916085400.1046925-1-alex.bennee@linaro.org>
References: <20240916085400.1046925-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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
2.39.5


