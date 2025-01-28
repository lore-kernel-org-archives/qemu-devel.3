Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D417AC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 13:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcm3d-0004nb-IW; Tue, 28 Jan 2025 08:55:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcm3Q-0004aj-1j
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 08:55:06 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcm3N-0006bx-JP
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 08:54:58 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so39833745e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 05:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738072495; x=1738677295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sHTZdSk34mjGYxV+5W6LTI1L6AwP2TGsJTRkRZPId30=;
 b=I6+cN42Ic3NNltT4lzPMeS2CHPf+hkvEmiSho1CRoBjz+jrWPAYgf7laPJD5mUrJvD
 86SxBB/MruLeKGOUhtb0Nhk3ArVEGTfpOIay/sV0H69loTkHB977OvvAOVVzuFvS+ZQI
 9UbG7/pXG4nyVpeSPmh/5LqFvLrbL4Ndek18Fco7pWP3dJJZIcoztOhaAE00b3lYzXhj
 MhB7XhjAEhRs+Ec1ovp2wK1KYXsE7eK5qNWlgBX1N41wtINrFHJss0+Uz4hRGb6CPx3k
 co+dU3uQB7Og2gNGPo3pGxIq3gMb938Md7zUS+w7E3Jaye5qOZOryfVIE4kION/vq2sX
 2UiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738072495; x=1738677295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sHTZdSk34mjGYxV+5W6LTI1L6AwP2TGsJTRkRZPId30=;
 b=qPKzqUIK86ZVtDWT4SgOt712NU8/WCtXxO7wGt/OS6WYrnYJUVoWHgQ+s/V93VCL46
 YVelrh+6kRcCcYTquH1OxZrdHnzizNZpzCU1dwWuIb4OWRkSLndpzcxFIBLJJ2W3At99
 Wt6Ik8o1CbMaUpEG3j8JXqoQJTKQjs7aSiGzJY1GhSdmkvnzG3ASe1pEM59lCe5Idu0o
 6tLhv4tI3UuW0XC7Zmm8/xOxhdei7ARzXWpXA4N+UscwAv46X0vwZvuTw8l/AOyXHWSq
 WShjl200vBk9rohvUVoBy98Xtz8C6zawxlHEshdInF2qPG7M7UjkS8a9dZrULqFiM/t+
 ZesA==
X-Gm-Message-State: AOJu0YzasxNsAf4BmpYeyLv0NjUkdPdxj8jymwgsBvN3BjbFCMDimLpw
 O5fhAw/KACORDtwICGmEa/l0qbEGemtAAAJ69/+ujR6rF/JUEpg4vgz8HnhIrrsQbVHl4SVVXBE
 sgBw=
X-Gm-Gg: ASbGncvp6kkAzeSkcfmDWPnA5NORkdZmy+dKgf0VTWNEN4Sg7F6c1H22D4PCxwjZwVk
 mYNJXR6jh5nEgzUjCGLRZPLwsMnlsyn2ZnMn5V12cKIRy20B90ZYrps7oJAB5IRjvMurt1emZ70
 UmM5Z1BG5/XJ8eTh3b/MOR7a+0p3q9UhvGtAEYnY62ZTzt54Q0UDGP2uffjOPLgFPII9byIzlGI
 k/kW3LQI6crMIyqBap/PT99ym2b0nOxtTvzoua0PSdPgYXEdWOkaYfS5hPu1QpKaoHlw+pma0ju
 xzOc6wECXljsoQktUGZ/rGE7XilszQKfOo9twE53b9pvFRUgqXjQ50uqMH7gqtzf0Q==
X-Google-Smtp-Source: AGHT+IH3P5VJSQPnBVjwzAbJn3gJJoSOcer8OOCQeUNJnIqXYJ5IJypeqppxpzTeV9A3I3UxD+ZHOw==
X-Received: by 2002:a05:600c:1987:b0:436:faf1:9da with SMTP id
 5b1f17b1804b1-438913c68ebmr397739205e9.2.1738072495662; 
 Tue, 28 Jan 2025 05:54:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd507dc9sm172973355e9.19.2025.01.28.05.54.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Jan 2025 05:54:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Peter Xu <peterx@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/7] tests/qtest/migration: Add MigrationTestEnv::has_hvf field
Date: Tue, 28 Jan 2025 14:54:27 +0100
Message-ID: <20250128135429.8500-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250128135429.8500-1-philmd@linaro.org>
References: <20250128135429.8500-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Allow tests to tune their parameters when running on HVF.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/migration/framework.h | 1 +
 tests/qtest/migration/framework.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 7991ee56b6f..76bd4dc1a95 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -19,6 +19,7 @@
 
 typedef struct MigrationTestEnv {
     bool has_kvm;
+    bool has_hvf;
     bool has_tcg;
     bool has_uffd;
     bool uffd_feature_thread_id;
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index e567296b014..5629b8ba4e3 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -945,6 +945,7 @@ MigrationTestEnv *migration_get_env(void)
     env->arch = qtest_get_arch();
 
     env->has_kvm = qtest_has_accel("kvm");
+    env->has_hvf = qtest_has_accel("hvf");
     env->has_tcg = qtest_has_accel("tcg");
 
     if (!env->has_tcg && !env->has_kvm) {
-- 
2.47.1


