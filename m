Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54B6C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnI13-00017P-Hc; Wed, 26 Feb 2025 09:04:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI0w-0000wP-61
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:03:54 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI0s-0005fF-TS
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:03:53 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4399d14334aso60065595e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 06:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740578629; x=1741183429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hVUFpp6Y2+qzYjm8DoMOY8I59cSTCLj9YwKdTZJDgXc=;
 b=JexMdG+Q1vUM7Mq8iUHS3Yxy9ymB3nJwY0bVeSbZIYHtroIgd4T/YkRG2hthZDTh7x
 UeXch/IybmctMTDU+80zfny0NlXr1W6/TkygfChF7cRWuR7/4ngDRPk9JlwZlsPyZKRR
 PKdzrFsdFP87i/YlkrZiRpDFPjbdVsa+ZTNeoufo2OC3osBcc09M5YGAYPCoo/9Gzu3H
 jpP0kWAcU4guPUKDnNzSsZnseV2eA47UH/tD4W7q2JDPq3Md3aijK5anPNkjF+faQjHI
 tGM8dx1IrX3Cpj4zWQfAnv136tyKxIkRAl1TbfN1Xo/AppFNV9T7i5Pw/NsIuPyr1z2u
 7w6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740578629; x=1741183429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hVUFpp6Y2+qzYjm8DoMOY8I59cSTCLj9YwKdTZJDgXc=;
 b=NSfTDM5yEYk7mvqHy4qagGfMkskZSVUvHfsUNmWh70zXQGK67fiE1SMe4OE5NmKbu1
 l4DmqGAhCuOyInGKEU6vZfDk9Ezi3QxK0WMgIuuX0m8u3yN0T0MpbZDc/tcA5crQtuEw
 e6/mIWXA6E2ttMg58h9M/K0D8Ve7RfTrFF8xnC+dSya9HXHDeZq6K60M+ppXRxTPzJI8
 JsbfHqj4u+ZRppIhSa3YPEp782snHnMgytdCuzuFmKWYQ5H7O2RbpOn8mO0sENwtelyY
 UW324sj8Qy8gJgjA4BtIHV0CB2NN61Pq2bQyX9fNl0YnYY+2XgLbLCSG35ywaIdZAcZi
 zO3Q==
X-Gm-Message-State: AOJu0YzU9aJ1587DTVBh0EYnzoCxFO2eZqwkVgtMhI01KlJIQw01BQZv
 kWGoslUgxFRds84Ux/x0FdXL08edGiOco1tMlmYTFum1r6HdwS59JDtoXg9V96I=
X-Gm-Gg: ASbGncv2/eFxYXu80hNkkWZiK7CInPMkH/U6c5sx4ivfVBafV/IYVH1vpJJarE/RI+l
 +/8AptGC67aJ5PJ6LxeRWyjIXli0aMR71iH/P5fRYqVR7P/UcGhkaSepNOeS6e5uPy0EraB5QJB
 fI8JovPKDyhLXZ7pbjgfw/+qj0E7vOnhiglpi5bBDStdgl1bUS2viuOt+jBnQrelxzxb6QTUcae
 t3GwMU8muc8QJK9X7PM6mEmRttfBPLqwJ0X+iovVqxAola3NLRnWmI2591bflwP9/BMyenKdSwA
 1mZRucsWeyyRbfy2yH4DKILGpNEO
X-Google-Smtp-Source: AGHT+IFVErBnm9FRGRKA4Z1dBQjzfhU7Mn+MllgMsR80wC2lyGJwjjCr18CWnGyRUj+e62qm+t8Xww==
X-Received: by 2002:a05:600c:3ca3:b0:439:6a7b:7697 with SMTP id
 5b1f17b1804b1-43ab8fe183fmr36056185e9.14.1740578628511; 
 Wed, 26 Feb 2025 06:03:48 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd882bf7sm5792382f8f.52.2025.02.26.06.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:03:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5E6786030F;
 Wed, 26 Feb 2025 14:03:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 05/25] plugins: add explicit dependency in functional tests
Date: Wed, 26 Feb 2025 14:03:23 +0000
Message-Id: <20250226140343.3907080-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226140343.3907080-1-alex.bennee@linaro.org>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

./tests/functional/test_aarch64_tcg_plugins.py needs to have plugin
libinsn built. However, it's not listed as a dependency, so meson can't
know it needs to be built.

Thus, we keep track of all plugins, and add them as an explicit
dependency.

Fixes: 4c134d07b9e ("tests: add a new set of tests to exercise plugins")
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250220080215.49165-2-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 meson.build                   | 1 +
 contrib/plugins/meson.build   | 2 ++
 tests/functional/meson.build  | 2 +-
 tests/tcg/plugins/meson.build | 2 ++
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 0ee79c664d..4588bfd864 100644
--- a/meson.build
+++ b/meson.build
@@ -3657,6 +3657,7 @@ qtest_module_ss = ss.source_set()
 
 modules = {}
 target_modules = {}
+plugin_modules = []
 hw_arch = {}
 target_arch = {}
 target_system_arch = {}
diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 484b9a808c..fa8a426c8b 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -26,3 +26,5 @@ if t.length() > 0
 else
   run_target('contrib-plugins', command: find_program('true'))
 endif
+
+plugin_modules += t
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index c12ee1ce41..ea4b12c054 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -366,7 +366,7 @@ foreach speed : ['quick', 'thorough']
       # 'run_target' logic below & in Makefile.include
       test('func-' + testname,
            python,
-           depends: [test_deps, test_emulator, emulator_modules],
+           depends: [test_deps, test_emulator, emulator_modules, plugin_modules],
            env: test_env,
            args: [testpath],
            protocol: 'tap',
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index 87a17d67bd..c8cb0626a6 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -19,3 +19,5 @@ if t.length() > 0
 else
   run_target('test-plugins', command: find_program('true'))
 endif
+
+plugin_modules += t
-- 
2.39.5


