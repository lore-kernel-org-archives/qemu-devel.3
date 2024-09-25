Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7590CCF9F4
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 20:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stYwW-0005cS-EU; Wed, 25 Sep 2024 16:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1stYwU-0005b3-Bu
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 16:48:58 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1stYwS-0006bO-Lx
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 16:48:58 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20b0b2528d8so2195225ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 13:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727297335; x=1727902135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W0oYs/D0tpaNOcC705VbLE/UauOtsZZGp/Aj1Bwa1e8=;
 b=DmPaRb777pqCpRhKXr/QbFpZXfMz5usaCplbFPLUcwfsmYXfpxPKZHW7Y681P6Mc+t
 fVClkVfLYRubqnD0/055UNhVHTkZiblDrxBJF0Of0XEUBnRU+GfchBA8OlUlUhEP+Piv
 ej/Ut1wd6TROXXj1bUI/qICcopBRRVD//bKBHemuovjz8a/D18u2aUee/Y1zdIVs2/ww
 Zf8Gh9Ci7F0GL+DyM6hGjtlunTzJSviJDkSiL7bitX1b0vpeEEutuKCOKKZNV6EHECNv
 RYucLWG5pPZOj8ohpTwvxyhMBL2y3Xq/EEK+NMN+mVWxdGhpVpuo4bpXzfDtJye4ODiK
 /wIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727297335; x=1727902135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W0oYs/D0tpaNOcC705VbLE/UauOtsZZGp/Aj1Bwa1e8=;
 b=jqaJTyMa4+D50Ac/p4xBzngfzBgqbnXv2WkfKMWKPwr9xa5HAiLS7MtJ8lTxQMN8Zg
 fYyl7AGKNUu7v+MfhhBJh/tHDwRK4iP+Ie5tH1irjP2JX+8xvohl/evodIVtu2zDllls
 JDh85VEg21D8ec1hygy8cwwlA/h5w9EKUSajMfx5qog+OrBbR1HpMbPrbn+1dTIT/mli
 nkqPB+dMrLyFrNbCgB9kiNlx7szfjnB3838n8W6Ipr5/jwdMpVI0L6mm48EdBECuu7Nr
 7jXoV7eynu8bEGReekQzrSGtSeMWqlDy8e4qJXu+754JSA9juOLmpAngym3sDJP+qHLZ
 W5bA==
X-Gm-Message-State: AOJu0Yz3Bd+AKbQRQvw7XSrrLnYWT/n0aqo+f0wr3SiYd7jac8cPgi3y
 taL/yVr9JIzARoAA0vzV8gNnMjtMZilI7WryYnpg75+eYixkBuqi9ZmMzrP52WvH4Qm6y3M1Kko
 EmjkxXNcM
X-Google-Smtp-Source: AGHT+IGiWsx0IYd/XEGsURtSWTQqxYzIDFHlDVbJWyrGk2x3kX1YCokOhqDel7fZGy41kJvprg4kvw==
X-Received: by 2002:a17:902:d501:b0:20b:f6e:a823 with SMTP id
 d9443c01a7336-20b0f6eabb2mr28611755ad.22.1727297334809; 
 Wed, 25 Sep 2024 13:48:54 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20af16e6ce6sm27991435ad.19.2024.09.25.13.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 13:48:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v2 1/2] meson: build contrib/plugins with meson
Date: Wed, 25 Sep 2024 13:48:44 -0700
Message-Id: <20240925204845.390689-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240925204845.390689-1-pierrick.bouvier@linaro.org>
References: <20240925204845.390689-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Tried to unify this meson.build with tests/tcg/plugins/meson.build but
the resulting modules are not output in the right directory.

Originally proposed by Anton Kochkov, thank you!

Solves: https://gitlab.com/qemu-project/qemu/-/issues/1710
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build                 |  4 ++++
 contrib/plugins/meson.build | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 contrib/plugins/meson.build

diff --git a/meson.build b/meson.build
index ceee6b22c8d..b18c2a54ab5 100644
--- a/meson.build
+++ b/meson.build
@@ -3655,6 +3655,10 @@ subdir('accel')
 subdir('plugins')
 subdir('ebpf')
 
+if 'CONFIG_TCG' in config_all_accel
+  subdir('contrib/plugins')
+endif
+
 common_user_inc = []
 
 subdir('common-user')
diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
new file mode 100644
index 00000000000..a0e026d25e2
--- /dev/null
+++ b/contrib/plugins/meson.build
@@ -0,0 +1,23 @@
+t = []
+if get_option('plugins')
+  foreach i : ['cache', 'drcov', 'execlog', 'hotblocks', 'hotpages', 'howvec',
+               'hwprofile', 'ips', 'lockstep', 'stoptrigger']
+    if host_os == 'windows'
+      t += shared_module(i, files(i + '.c') + 'win32_linker.c',
+                        include_directories: '../../include/qemu',
+                        link_depends: [win32_qemu_plugin_api_lib],
+                        link_args: ['-Lplugins', '-lqemu_plugin_api'],
+                        dependencies: glib)
+
+    else
+      t += shared_module(i, files(i + '.c'),
+                        include_directories: '../../include/qemu',
+                        dependencies: glib)
+    endif
+  endforeach
+endif
+if t.length() > 0
+  alias_target('contrib-plugins', t)
+else
+  run_target('contrib-plugins', command: find_program('true'))
+endif
-- 
2.39.5


