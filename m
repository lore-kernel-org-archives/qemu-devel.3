Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19647ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1d2-0002t8-CI; Tue, 10 Sep 2024 10:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1d1-0002mZ-HG
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:13:59 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1cz-0007Vl-Qu
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:13:59 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c40942358eso746300a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725977636; x=1726582436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cRFhj2SyvQ/EIwHMRij/KsWIl6x9+a8v4XWFbD+c1P0=;
 b=KgandcclTTA7JUISr/s1Py/KBi6AnHZW5BEsTRWNbdoLy7oH9i6AlrQVkZ+7Yv/C5T
 Vx0pTHxifAvl1AGCleEuBvGCyqjN5GGLixvJGHii37LNTcsy4jJEN0ZGSHizTCJe2IHa
 P0SgdOOeXpVF5Z/bpDI2AnqTPNBWfFIkACq+YJ/rDpKZ5D89sV/sRRJ8uGemJozmBaAK
 6U/HQmEbUmqSTpdfaz1ILRngrjkZAIih4K0CgP50MFvVDW8U1IVBiiryAK1fXi+W1QzW
 NXQaD2YNay0LWaIczfuB+gmqj5nKS6vZTurleTkhbvoQSvwd8e1Q0pmSUKVUv7TODPvX
 en+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725977636; x=1726582436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cRFhj2SyvQ/EIwHMRij/KsWIl6x9+a8v4XWFbD+c1P0=;
 b=m70t36B+ciFW0KkxBjVBKmZcJOFF3rvOc7qJzIWEjtH1ObFemWD/0xEIY/Sjb2b3BY
 KlBSeFsRRoGgVdry1hIjmvdzZTL4jqz2Qlq+vIo7Jzw7yZKV4C82DvB2chEFpeRcnnsM
 npAUvajMgb7foL0DMmLmNzJHcTxur45nSravBHGN5vofjoF10/olWV9Kir6m6nnuX3ke
 1DOFgSKALWieS1HSofwRfvmauF7gxk1DWajicKRUq/rhLfYAm7MgvPXQRGxTxgjW8Cvf
 MBXC/j4xBzESpDayriZ0i+tYbuS89i8+LrCvvu/iZBQhL4xiJiOgpkUJ1GuxnrG4fSSB
 REzg==
X-Gm-Message-State: AOJu0Yxx++ifEUspsYiWJw3W4qZfyRM+8Xy/VgyoZKIoOivdjPAYvqWJ
 RbRcMttR4Lr350aVUfEc3LtO9xoKD3jMIk19o0RxeozqvOqlee9U687Qxpcy52I=
X-Google-Smtp-Source: AGHT+IGqyOALW4jSP1JBXx3YmjSCxwI7FGeD6xXprKRUMj5B+BRwN5RJL9njKC53FVAO2Otc50xf4Q==
X-Received: by 2002:a05:6402:3596:b0:5c0:c559:ad6 with SMTP id
 4fb4d7f45d1cf-5c4015df1d1mr3218510a12.6.1725977635809; 
 Tue, 10 Sep 2024 07:13:55 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd46909sm4504892a12.25.2024.09.10.07.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 07:13:53 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D603D6349A;
 Tue, 10 Sep 2024 15:07:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Elisha Hollander <just4now666666@gmail.com>
Subject: [PATCH 22/26] util/timer: avoid deadlock when shutting down
Date: Tue, 10 Sep 2024 15:07:29 +0100
Message-Id: <20240910140733.4007719-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910140733.4007719-1-alex.bennee@linaro.org>
References: <20240910140733.4007719-1-alex.bennee@linaro.org>
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


