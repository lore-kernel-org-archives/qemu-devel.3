Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D06C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWS4-0006Q3-Hw; Mon, 10 Feb 2025 11:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWR3-0004AA-Us
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:04 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWR2-0001V4-0r
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:01 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5de5e3729ecso4169367a12.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739204098; x=1739808898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WRjcWYmrZaZWP3MsASwgK8gyMjNh7g5UJb6gwrhevyU=;
 b=c6ZcAJK66VbfCY6B+jVgLqvrh7BMFb3Xiz1anoDDwwAHpBgUUf/Njgh8NZZUK15ks/
 RyQoLESOBFnhK4GVL5y+qhxnG/EcpPUojgHzezgwHIf76kDROGzLCoAjy0fRmHGqIXar
 mWFj2qDkwdoPohp7TeTWOwdkyuomlVV8sPQdtqqxmzA/GLADMwGw+Vggk2gTTGoSxB6d
 QTwosm0VQlL5RkFF36KaE8Cs+YStji/w4U6veZKKcVWX1hKk6UtQ52TPuXmLKrjSHbHR
 LJpqhJrCgSRdxNy55QU216VFLW6wlNgVBKvYsRyCqYQB5f4topumDRHMosM1YH2j+Ygt
 QWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204098; x=1739808898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WRjcWYmrZaZWP3MsASwgK8gyMjNh7g5UJb6gwrhevyU=;
 b=gAnz9Cn6ECbaEHvWLgdcO+dFUbRz6dMNOmzWs69+MLd0o5w6eLZDUanEPFNGfcNcrb
 bNdyUs0xmi8TRZEzANJFP0hWsVkN0GiHz0RJOU/Ih1pySA7/zxlMJZtwJJNKVjgx+B5V
 aAqz7hlGNRHyHan0FOsxBjmB0RsMN9D480V6JyQ5tEx+AmDjXtZtdiuO86uIygJTOTqf
 N1UgCyYBComResU27AoiDcXFArQR5CVAo9iwVJadb2xrpem+klokzPfbAsssK2kPxEn8
 bsHFUCWZ5sqd5A6X5FMuvhx2gqABhLwePFWJl0sQOg7ClrPdXnD3r0Tf3h0HMIUHSA1W
 i6JQ==
X-Gm-Message-State: AOJu0YyxvB0pVkULzVosvqKFXtqzXUOk/rC+P117hZdomoqoonUCnGLi
 yk4iFAgPtJ5BRxCEhUkGFdmdelD62r5V+md3mrMAnOHotp+9a23JH2dZ2UnjwVk=
X-Gm-Gg: ASbGncsc6h1F+acmAq5p5IQm0cbAuHW0pHtGLNQ5xLDn/sWjuSy6qbs5Fke85V+5chc
 RNQlqOBqEFy3XhVA8xjaCBoLScoCg9X6nYUQmVosuqM6YCpsjPnQEM6Xd/ZZFKQGKTrYJ98hIEp
 SvDf6HbfoK+e+lx7JesHw0cFuqgz8XT7B+Lo0P/rBDFJkq9QUwu0R+hZRQkoXrbLhUEebmPS17F
 +vAXPf9jxzJ9MhExeYelTidx/t477TtFq8U4lc/qWPSGCOamAD4i1kzYTYTb3hMCE1CkfusLLyH
 JtpJXBeo+0r2Y6+jIA==
X-Google-Smtp-Source: AGHT+IGG/iTBzn7g9jQIRnszoJrFH5Y7WXqXc8PvmoXMmR0/8NIPg9gbEnuuse2l6YVANgv9SC+a6g==
X-Received: by 2002:a05:6402:2189:b0:5dc:c869:da4f with SMTP id
 4fb4d7f45d1cf-5de9a4645f9mr244118a12.24.1739204098169; 
 Mon, 10 Feb 2025 08:14:58 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcf1b734e5sm8303006a12.5.2025.02.10.08.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 08:14:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4D87C601E0;
 Mon, 10 Feb 2025 16:14:52 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 06/17] tests/qtest: tighten up the checks on clock_step
Date: Mon, 10 Feb 2025 16:14:40 +0000
Message-Id: <20250210161451.3273284-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210161451.3273284-1-alex.bennee@linaro.org>
References: <20250210161451.3273284-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
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

It is invalid to call clock_step with an implied time to step forward
as if no timers are running we won't be able to advance.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250207153112.3939799-7-alex.bennee@linaro.org>

diff --git a/system/qtest.c b/system/qtest.c
index 28b6fac37c..12152efbcd 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -708,10 +708,19 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         } else {
             ns = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
                                             QEMU_TIMER_ATTR_ALL);
+            if (ns < 0) {
+                qtest_send(chr, "FAIL "
+                           "cannot advance clock to the next deadline "
+                           "because there is no pending deadline\n");
+                return;
+            }
         }
         new_ns = qemu_clock_advance_virtual_time(old_ns + ns);
-        qtest_sendf(chr, "%s %"PRIi64"\n",
-                    new_ns > old_ns ? "OK" : "FAIL", new_ns);
+        if (new_ns > old_ns) {
+            qtest_sendf(chr, "OK %"PRIi64"\n", new_ns);
+        } else {
+            qtest_sendf(chr, "FAIL could not advance time\n");
+        }
     } else if (strcmp(words[0], "module_load") == 0) {
         Error *local_err = NULL;
         int rv;
-- 
2.39.5


