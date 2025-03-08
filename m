Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D252EC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr271-0003He-3T; Sat, 08 Mar 2025 16:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr26y-0003FD-CI
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:36 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr26w-0000v7-LK
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:36 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3912c09bea5so2293423f8f.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741470813; x=1742075613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nW7/p5GqVTN8cVjBAVNZ8mhXpq1InHLulArjjxzEZbM=;
 b=XLQUYwQcRnye+bQGAfhXqr3j4X2X54Y1Z1SNSJwj0dVKX0bpPGbKnOXXquXhr0RAC3
 yUd8bQsg02wFYAupuetmWXFhLfVpQcF+J9wyLDPR1zRq6o+jNFEUw1HU/5MmYHrQTH72
 HRYQpwiJLK+Xlum7dVihIilyFiFF0lLJBCfhn/A2y9dMUtUMD9wcxEFph3Kn6IGqhAEA
 f5GN2QBYRCZ0xZqkUYXBrdOuN5Zfq2SIQIyNyKxBR5MsIabSKyF63j14e6SBAr37/f/z
 dOdgsuT4B3T/LZ834nX+U8A76pJvZM/DwNG2SRhEhqtgK+kkS2T7YZHLcvWNCluZXFOR
 0JOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741470813; x=1742075613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nW7/p5GqVTN8cVjBAVNZ8mhXpq1InHLulArjjxzEZbM=;
 b=JN2h/M+yu8GT1TkJUMkAczPk9/GDqesP/FJ6N16FR32NMM3nGYiYk4fwXu3G0bzgp0
 3T3yjJaHXm9rHgM39Ze7VzNdrTdYLKZ1jf/XG2vYiv1WxQ9C2bKWWA/LZOOuVtnJ6aa6
 AGifTaT8eDPBbvsuA4mR8hcHmolqsplI91X1pC8NzhsnSVMxF+lzLx20iG6wvNvud82P
 VZy89dccKMHXr06xxcyvNH/RzBhZVtNyfBdNsM2dpsUVPmOQBxAP33ykR01Ygb8O0Vep
 PuUcTeePTCpTXQ3FuAk37YqoPdixP/tcegK+kjs8QnM4snp9hhamyISBRlrUCOTLcprl
 vz/Q==
X-Gm-Message-State: AOJu0Yxn65BVjWt121oJ/twEyQXsw34GxFAkiGu6Ov7GMq4SpJYUe5or
 3StyIfF2+PZGHiIdlqZ49AEyXEfqHt0fum8TDH3V+OBL0juLWhzVT/W/c/5jRic=
X-Gm-Gg: ASbGnct6SlAZXPdPf9TY8NJlWDGNlFn0DpmXP6WV6lwt8rRDnKIsdjteHBzJi2pGeNZ
 QNNK6q483xozvUnUrJpwa0tWiET093OFg/Z+/kjKn5bJOSKyFebqZv8rFb35A8OPKJ8s8vFfWjI
 +yVcwOnhKshxkt5GbIP2fqdbfszRfh5AGnP/sIl6kprnjCyZiRldvn5TP4QBlTkQIN8RkTtMuV6
 2iwXI/d5mfHQGL+TR+11OA0PWc8nUyATDJcOljqTW7GVer1EWsUgYaxI5mxLxxbzfVNDQja4kVF
 zx2zsw5cYGm2Fabnb2R+9aC1k6GB4R+VjI5Ywjbz5LfR2zA=
X-Google-Smtp-Source: AGHT+IG3ze2BzghgvZv4sVwn3F+qOYJq4eLwFKqrRITHzSKX9Jfe9NBiOvGbF37KIpfCkAfVKqFacg==
X-Received: by 2002:a05:6000:1a8e:b0:391:23e6:f08c with SMTP id
 ffacd0b85a97d-39132da91aemr4126646f8f.47.1741470813139; 
 Sat, 08 Mar 2025 13:53:33 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c104acesm10075480f8f.98.2025.03.08.13.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 13:53:30 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 49F6760341;
 Sat,  8 Mar 2025 21:53:27 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 08/31] plugins: add explicit dependency in functional tests
Date: Sat,  8 Mar 2025 21:53:03 +0000
Message-Id: <20250308215326.2907828-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250304222439.2035603-9-alex.bennee@linaro.org>

diff --git a/meson.build b/meson.build
index 8b9fda4d95..be857cc80c 100644
--- a/meson.build
+++ b/meson.build
@@ -3664,6 +3664,7 @@ qtest_module_ss = ss.source_set()
 
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


