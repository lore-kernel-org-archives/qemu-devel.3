Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C22CD5BB5
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3Hk-00045k-Iq; Thu, 21 May 2026 09:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ3Hh-00041z-3E
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:17:57 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ3HZ-0008Qj-BE
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:17:53 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-44a14580111so4597525f8f.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779369463; x=1779974263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dhi0yYpKFaxwEdsneAb6BI4LLBY0LWLrqFgh9GqtIPc=;
 b=WMOICJicqIBlwMaUpuvPZuM3J380ZxI0ZRLmE2aDU0erD5m2YmVoHG2BxCZZNMR9nA
 ha6lwUMPevGHkKAZ9DWi6I5RDF10g4undG3M3Vjl8PMmBMxEneHXPFbiqC1yAbSBBk/h
 24FqCJtn4yZoc+LANqb9IOzMTMPxHaMLZMMVF6y9LL+t+ipmo5Z8HUGGGlWKhtLmu+HK
 irEzv6WEDo6HUjhxCeGUN0Q+PkBYWYNNJWfPX/PLZSoKurAROUj+Z6TyIuUJ5b8y+Y1+
 q81RePZ5aMCdDGkPYrBsk4AT3N8uGatc5zvPfmI89f/evXzixvnN3b+nY9xk2AEr7iW9
 nTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779369463; x=1779974263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dhi0yYpKFaxwEdsneAb6BI4LLBY0LWLrqFgh9GqtIPc=;
 b=mkaIaaNMd6hXmq90vcb9LntY0V8XxIm/Cv7dRPROdECBxyKQbHv5h6bkYgondKsvEO
 B6o3c/uyPqmTOBme0lz6Eyv0wQKoSbXy8qetZwqwug73SEs0eYmKX/mwqAr4UMn/ELmf
 jtd8tDzig6UhAn/VcGApN6XQ1C+xhXyzBWVPLZhwfV+RbNaL37fZsp64Ox+5o7QxO0dy
 ryeYIiD7zf9ZAI3Ocwb8bT5aaBGh1CG3q04BvyS5PByNrX9CYnWGzAPK8y4ElId7BMkC
 hXGeqfMeytLBROCdVLloruDBTii4PVdMqee6B9oAGQQ3wAWkjhIGH8vsjJ2m6C9RQct8
 B7GQ==
X-Gm-Message-State: AOJu0Yy+V6HkZBq5i0FkCb5OH9bLD4XtmuvTbwSu6JH3+tqwr//egOdb
 u7eFngZbA9j8XHk4qxnkbJbzyBz+5SFlukD86oY786l/Xt5NcNJeX0NfNbRQ2EjdNFc=
X-Gm-Gg: Acq92OGiO9h3cFF2DhpQIILOJ0NL/gORQ3kII8ce3MaOEufYLz2AAfFPS/neO2jOs7H
 BvHGk2IgbvFHXQ5nhWcfDMc1bV+N6EZ5kMznxjwdbZ+hvuvzm4YtveBcmDzf9y/s9nymvV5qFCj
 wheSeOb+cbeFpiqIjkOEI9IvsuiccI9hMldYZ6oHh1VR4J5t27nhbf5zO3ZmjKV/rpB6Z4BzYmu
 WMghHHFuSyLuTwSU5DGwoeGFiIWio+dFEyEEt75jmjxkCe456OT5sMxQCUYE9l5Ys8DbPzwnnGW
 ak0ZdLvwRswD3f/OAOKTW1kFakzTNyHJ3QSQ6nuzZ1XdNue6FPgEXXjris1xb9Br7QyvEgTY1fI
 +Fh0QggzBXIWkk77KrzSCRQOBvIHQGKsqFQiUmsh4eES16ORVAF+yrpI0M+4r+weQPwChaxIL1y
 /lu+uZN6R6z3RAB55KoO2kD9cM3ttpjrc2eA==
X-Received: by 2002:a05:6000:4205:b0:44f:db87:8919 with SMTP id
 ffacd0b85a97d-45ea37be492mr4736360f8f.4.1779369462831; 
 Thu, 21 May 2026 06:17:42 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa92de9asm2805614f8f.17.2026.05.21.06.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 06:17:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 838A25FA16;
 Thu, 21 May 2026 14:17:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Song Gao <gaosong@loongson.cn>,
 John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 03/16] tests/Makefile.include: add binary dependency to
 run-tcg-tests-% rules
Date: Thu, 21 May 2026 14:17:25 +0100
Message-ID: <20260521131739.540157-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521131739.540157-1-alex.bennee@linaro.org>
References: <20260521131739.540157-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

Explicitly set the appropriate QEMU binary as a dependency so we can
ensure they get built. This is especially important for MacOS which
otherwise only builds the unsigned binaries on a normal "make all"
run.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/Makefile.include | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index ce6a0dccaf4..cf6f9e68245 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -57,6 +57,12 @@ RUN_TCG_TARGET_RULES=$(patsubst %,run-tcg-tests-%, $(TCG_TESTS_TARGETS))
 $(foreach TARGET,$(TCG_TESTS_TARGETS), \
         $(eval $(BUILD_DIR)/tests/tcg/config-$(TARGET).mak: config-host.mak))
 
+# $1 = the stem (e.g., arm-softmmu or x86_64-linux-user)
+get-qemu-bin = $(if $(findstring softmmu,$1),qemu-system-$(subst -softmmu,,$1),qemu-$(subst -linux-user,,$1))
+
+$(foreach TARGET,$(TCG_TESTS_TARGETS), \
+        $(eval .ninja-goals.run-tcg-tests-$(TARGET) += $(call get-qemu-bin,$(TARGET))))
+
 .PHONY: $(TCG_TESTS_TARGETS:%=build-tcg-tests-%)
 $(TCG_TESTS_TARGETS:%=build-tcg-tests-%): build-tcg-tests-%: $(BUILD_DIR)/tests/tcg/config-%.mak
 	$(call quiet-command, \
-- 
2.47.3


