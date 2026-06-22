Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB62CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbgmU-0004h1-Ng; Mon, 22 Jun 2026 11:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wbgmK-0004fq-A9
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 11:41:41 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wbgmI-00067g-15
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 11:41:40 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-45ef6565cfdso2016658f8f.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 08:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782142896; x=1782747696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NpbhSBkeCzIyJRSoZI/dnYPX9/ao03hxlbtgFWqxmIE=;
 b=LyRa2IYtPdhxYjtHFH3cTeQKiF5QX5wwbN0ifeQndZZVlqo5XvQEQz1mvIGdYBLY3k
 QKIRvdZW95FvGIJjwTWfluDh8mdM7jUdR1SvemjUW5qwRzUSbPJJ7MUEn5nJqq7G/1h4
 q9Ik7ZVBkON9NU562odHRvmTGn4QP1XY4IPacAmdcYU72BJ9JxnDB26yZl8zQ5L24NZl
 IXYlgyu0r8qmvZD7r8iIA/gzXL0aDsQFi1fkDi3xsTj4sXV7+bRTVk8UabMJxu01GjvM
 VDWk6V25u8TUUU0Ntm2zxi9LN7Bz3clVv19CC9HxRu+aIHAK6MRgOzTFBBRTCmgFX86G
 7X4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782142896; x=1782747696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NpbhSBkeCzIyJRSoZI/dnYPX9/ao03hxlbtgFWqxmIE=;
 b=LxeKNKidGmNdK8nvEEeuP3V50uVHpqQGDYFlvbZUQGTWFOeOl4P5ESTlKE2zYEagVP
 gHKHpMoXbNDzQ25PQG4Jp+SmUgRW+Q/5+ADOuV3DjZtbLJtQrZvK8TUmbX3b1HSkt+aw
 gZ85GQ1fj7NW4gXOdvqHJY6Q1re/Iq6ttlbO9fkGCvtj4dWWn1oJtrV/dKNGlc/BEFR5
 udIC2If2SSt/ws/Ilxb+iaaOTw8rvD6cS/iexAoGhAIOGkr0PmZjBEXAui77Q0mnn0eA
 GG4DFQ4cNAMN393GXmHA25fEn8mZKNCj/ka9THQgaveIugHZs/mcwe7DZ1ux+REXfofi
 RLuw==
X-Gm-Message-State: AOJu0YyqIn40v5lHE1FS0gRM83YDQwy9OocRUUTEPdwIfL6X7lsD2sRY
 r/eGXiqJEsLkjEnrHt0FFTu+X7t0grrvFcahovMk05/xD4B0SZ0R1bdVjpIo9ZD3Et8=
X-Gm-Gg: AfdE7ckaYEKbQKJKr/H3ETXjbLhSwNbGdgdPtXJ9upfv8rduyeZx55ZInM4UKpuJmBz
 cPzoDlQD4iJicHQPXMgi0T6ccCfL6WNtrD6GWFuKwUavTXMQqWiUOPkOcldL3SVKOoj5ix/Fgx8
 4+VaFL1Nc/im6phJ8wrTZYYVU7LmeeoM7Nmnk/2i19AXSEd0BQXlMEx4wjOco1DYRlkhxEcVFE/
 vBEhZJ7DG2UjMtbIcWOzw99M4OhNSRGTmmKauiGkZ7Uz39JW4RC6Gl6gM6lmYl8m54D7iR8z1H3
 A+TniMCtRU1GQc/BR8fOWy14Cn3k0MmefON+yH3qgfRwAPFMCqNbYHZc2P6AM/MgQJxwkXklTns
 M0BfOFOCnY6ND8mEvJKPui14UaG5ymMdZxAN19BaVR1to20APu0pJIixXARbwftI2VL9K6W+jCP
 UFiCcj0D9v6TmXvz33rz38MX8=
X-Received: by 2002:a05:6000:25c3:b0:462:ce05:c5e4 with SMTP id
 ffacd0b85a97d-46662ec50b1mr15426388f8f.37.1782142896315; 
 Mon, 22 Jun 2026 08:41:36 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f4b8fsm26606447f8f.2.2026.06.22.08.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:41:35 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AF7A65FA05;
 Mon, 22 Jun 2026 16:41:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 5/7] gitlab: ensure "check-XXX' jobs capture functional test
 logs
Date: Mon, 22 Jun 2026 16:41:29 +0100
Message-ID: <20260622154132.3166748-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622154132.3166748-1-alex.bennee@linaro.org>
References: <20260622154132.3166748-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel P. Berrangé <berrange@redhat.com>

A small subset of functional tests are run by default with
'make check', and so run in the context of 'check-XXX' CI
jobs, rather than 'functional-XXX' CI jobs.  Thus we need
to capture the functional test logs unconditionally for all
test jobs.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260610121254.2870259-1-berrange@redhat.com>
Message-ID: <20260619155657.944220-6-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 005058625eb..3b003abc999 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -78,6 +78,15 @@
   extends: .meson_job_template
   stage: test
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
+  artifacts:
+    name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
+    when: always
+    expire_in: 7 days
+    paths:
+      - build/meson-logs
+      - build/tests/functional/*/*/*.log
+    reports:
+      junit: build/meson-logs/*.junit.xml
   script:
     - source scripts/ci/gitlab-ci-section
     - section_start buildenv "Setting up to run tests"
@@ -111,15 +120,6 @@
     paths:
       - ${CI_PROJECT_DIR}/functional-cache
     policy: pull-push
-  artifacts:
-    name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
-    when: always
-    expire_in: 7 days
-    paths:
-      - build/meson-logs
-      - build/tests/functional/*/*/*.log
-    reports:
-      junit: build/meson-logs/*.junit.xml
   before_script:
     - export QEMU_TEST_ALLOW_UNTRUSTED_CODE=1
     - export QEMU_TEST_CACHE_DIR=${CI_PROJECT_DIR}/functional-cache
-- 
2.47.3


