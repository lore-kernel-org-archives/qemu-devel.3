Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46151C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpah3-0005PS-BU; Tue, 04 Mar 2025 17:24:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpagx-0005LM-GD
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:24:48 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpagv-0006Tb-9D
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:24:47 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-abf615d5f31so622722966b.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127083; x=1741731883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Onp89pSroQtMObXGq9VTrbTAFH+9BfAPDxoO68vbwOU=;
 b=zsN/zYzm/xTyGUT5QEsRcbhx/5NCsXvuZXhvlrPBpn0pD7lWKdcuWi+BBgC5FYTJEG
 3UabGvVaB5zFh6/PuPYDvqxDXxpqtX23Kqqp6yQ7yehszXUKxE7TkIm3+mcrsIzyR5tE
 E1id52tjeyvT8EaxnEYzrmlPnIzQoZ/49ZnLmLnL5VjQUZRsgCdaQs1Oei87FcqJi64T
 NccJhKCDyvbE/HN1ZE/UqHL+nHrLX2IwJJ4LKqEbX4ljZLnQnYudzdbSdTuZxxx/bKVs
 DR77eV+ihMGP1AMJeMt1vlpOwb4ZaOiQGti7CGzKiZzdhi3rDjs1kAIeq/5wp4T9trSU
 M2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127083; x=1741731883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Onp89pSroQtMObXGq9VTrbTAFH+9BfAPDxoO68vbwOU=;
 b=KrSY4GLjUCLBdy1eEDU2jGwtswqeO6UtsCNQ93cDJyOWJWpINr+/2ES+kSvz8YnmNE
 FB8EMi2HisFxXvfCqtI2D4XIpupidqjbRPjVyAnJb5w+UEG/CF/LzCATz3ZL4nOWZiSI
 RgA6XtXTnucGmPqaTb+Zmf7l7K93Dac2pO1BKDFEwkbag76NNeq2L85fac8bvWOhsgUP
 +WTAyeIUd0I/RFYhtApbjb3hNQoKAqkoH4sx3gOnjHxrvkTArrwoxePBBStjHnGipr97
 ReKR9RzLQfkPTSYBUSy3xsvetj5Zh/WI2fG15L665u1aYUcf8hiplX0FSTPuxIIBPR9Q
 vERA==
X-Gm-Message-State: AOJu0YxGNKGUEq1evja78uoA7OyThBTgXmKca+88R5fO9ST7CONW5ZEq
 x8GINV5z61maxvn+e89ZT3fXDAuZEAmJ7VR86PE8SfxAv4hqK4pvcHnSmogjicY=
X-Gm-Gg: ASbGncv/lWoV9DrL3yFgSUs5aKonLw+pAqvz+Cl1kkGZjknZIFigml5mk9ulXTEqNS+
 Fg7qyaTtnW6ZZ1N9vLZsHJN/wbSWULF3BRNr4uiTG7h/lBSuYVvQc3xHFUEm38K+3L4Smbx/N3I
 ViIgpadCGX9xzu60fu7XRWGmsNO+ffNKUIsZVoATRrKg4NVBIX6G5hsHWhYmBVzCwfhV+BKna1+
 Hsp+sKcUufGxXRTpGvIzNqEq8k5Ms6snDcbMPlGSvX0PnsugY5oMsMsavUcXUuYkaVd5TyFGxnU
 LOZVaABnq8Pli9ZakY1B52V2IrtfWzSxy44MGoyQMD/5McA=
X-Google-Smtp-Source: AGHT+IFgc+Hyu8uqFyojDJgkb9CqycIFloG9vwRl0TkOsweIUpLR0PtM7/YubMdKtiq0mS/UddWPqg==
X-Received: by 2002:a17:907:2d12:b0:abf:5aea:a584 with SMTP id
 a640c23a62f3a-ac20dade8dbmr83852866b.38.1741127083223; 
 Tue, 04 Mar 2025 14:24:43 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac1e7fa6246sm252666366b.167.2025.03.04.14.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:24:41 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 29E675FD17;
 Tue,  4 Mar 2025 22:24:40 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 08/32] plugins: add explicit dependency in functional tests
Date: Tue,  4 Mar 2025 22:24:15 +0000
Message-Id: <20250304222439.2035603-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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
index 0a2c61d2bf..8d0abe7f12 100644
--- a/meson.build
+++ b/meson.build
@@ -3662,6 +3662,7 @@ qtest_module_ss = ss.source_set()
 
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
index 4b492135e0..008d72aed8 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -380,7 +380,7 @@ foreach speed : ['quick', 'thorough']
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


