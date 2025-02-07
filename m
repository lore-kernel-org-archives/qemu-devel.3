Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B54C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 15:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgQLZ-0001J3-Iw; Fri, 07 Feb 2025 10:32:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tgQKM-00089p-Gm
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:31:37 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tgQKA-00040G-BR
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:31:33 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4361f796586so26526735e9.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 07:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738942280; x=1739547080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ShDl4eTjpRUeb9COlaeWxryj/oOTu67dB6IU90OsGA=;
 b=qN+TLRrM+CQ6pbf/o4nNo7t+48evrOK0IR5AIgeH1HehlFaIRMS+lx+9bfIn+hQQUk
 ONgvmBFV2hsCwsQJKfMZrIJQ9NqR4oaox4muXtl0UJ8XOXDys7n54IS/ddq//tOIC36l
 0mVvpq8mVkT4Ki8aOBFGI9UnbIOxUhYB8B530Y2+U6mmmNhiwhIOaxFuWjLQoA+a19Ya
 /UXRCvk+OvODgGb935bzBhw8js61ETWMuT5acIJLDLjVgx1sPSyxso28kz0kcCssQAgi
 nM/9mnr7ei7bUfFF/XZI0V5EDkLOn1Kuw0/LZnZxLWIzArberku0eexc5WOvcZUmd5+A
 JIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738942280; x=1739547080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ShDl4eTjpRUeb9COlaeWxryj/oOTu67dB6IU90OsGA=;
 b=kxcLHhesNPxs+f8O7PLz5Z0sxII/rVTDT2kf8hcEDGpaOgimah8xS2b1bPqsyO56Gh
 R1OsN87uzJgH84ebZaynNvE52U5/qjrMXXv6PlqL7i7Reg+gUhco82uj5q2Ua8cxc+Jp
 C4YmVutN2ogv/tkhzUBjwqcb5RTS8aCuPX8uCj5O3wynSLQYMGhu/UaZrhIM6mgypcnO
 Vatwb5VQ9xkHnZkUjirx/9/eAB/23+nKYlaW/qLpXV4zURJefR5w8VAwRPqAaPiMgGg6
 FD2gYFZyUz86gUBSDYcOCkuVJO9V/WiWEclCoAAeWBO2LIk5rXfHalFEsIN0aPob5A4X
 4tYQ==
X-Gm-Message-State: AOJu0Yy8HhO56gjfpvvh3tD11OxmchvzE1eslvSXpMD6LelANPQTb8s9
 tcxG3yXjNfWhTixksD6SR4NQk7Oj00U2C4qs9VTmR3u+zhops08oOYv10aphpn8=
X-Gm-Gg: ASbGncvMEgP3A7a8Su7SeWKBKY5TU9lLZvAnbsagoxoWod3wnLDkVm6CIRccKXCrFeb
 mmOey5nevkIzdgZWyNjqQRR2395sBPcPEVZYoEAPQEV/d+/gCzgubKng4ArbhbhXorkZ8r5EqQk
 dh2Q077ItuG6NCUuVyzmVCCCs/E+SHXlZFIvET3hx14v5xKC0w+5Da4WBjj5IxF8urKsBplWl35
 Gm1FbOkWUpJ1oTEiSPtYf7jpdaiyVs+vPg92OXWLekLOkpYZz/paIdT5nGErNuP0/miGrVAVyf8
 hcGiU1gxShCfjnWT5Q==
X-Google-Smtp-Source: AGHT+IEzLNMgRx2nqn4ZMEmZweBd8Ch2Ufmp9Mqen9yErmCMZCQJmwz/+Lyueiyw7BmY3j+3tWQTSQ==
X-Received: by 2002:a05:600c:1e23:b0:434:a04d:1670 with SMTP id
 5b1f17b1804b1-439248c2c07mr44057015e9.0.1738942278829; 
 Fri, 07 Feb 2025 07:31:18 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab79378ee30sm54936666b.160.2025.02.07.07.31.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 07:31:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 016CE5FB89;
 Fri,  7 Feb 2025 15:31:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Kyle Evans <kevans@freebsd.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
 qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 07/17] Revert "util/timer: avoid deadlock when shutting
 down"
Date: Fri,  7 Feb 2025 15:31:02 +0000
Message-Id: <20250207153112.3939799-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207153112.3939799-1-alex.bennee@linaro.org>
References: <20250207153112.3939799-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


