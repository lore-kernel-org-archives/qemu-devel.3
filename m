Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15115EE57D6
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 07:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaqio-0007Uf-4z; Wed, 31 Dec 2025 02:34:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaqil-0007T2-MA
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 02:34:15 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaqij-00019k-Qs
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 02:34:15 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7b9387df58cso17030793b3a.3
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 23:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767166452; x=1767771252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FAxt9eRCBAnOw0tS+03oIZgAiM6wZWJgVfag7QKOmwk=;
 b=ukzljoJBDBSvOqXofB3Ew+yJrMwZaAZ4uZSIykJecCCpYvxV1MlcIlXlxdNNPetSlc
 uS0O+ciakIYTukwfjSrclueSouznQsBQmP6phBgdJR2SeDzK7HpW6BjVoZA1lZKSi7Ik
 IpJsTNdUXNBIzF+QSCcH0cb5rJI+oNsrCVp3hjg3XLnlt+L2uAIx9fFjWJ4WTecbQqjL
 mRPdxLVCS3A9ULQ8iGYFGu8771xS9IkseHsWCGojLUL3yTKYD59wjKuAudsvAEFbBKKG
 DXrEnKd/g4A3odjeOaYclSrfxhfunFsyCbs1Kmir0LsEQ6za3vQovBzkN3A28f7yvrxt
 fryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767166452; x=1767771252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FAxt9eRCBAnOw0tS+03oIZgAiM6wZWJgVfag7QKOmwk=;
 b=MGPHgr6+2dPKS9VYI5tvLDqOg8A52j7HlHmAZ9lsPkLU4Z8vMfqkvqooT1fSXU+Xit
 rVFD+24A6HXuMLff+6WJMFNIEUUbaJ+TWvEnjDODymwyc7e2sIifZgXBRrtVLyDbFV5c
 Ms0yTYmVCcdmjR5kLJRieGFwvAs3zMPs830OWUTH5QJ+D63XUsA1mp/Djp3YX0zMJf13
 tZi77USK+Kr2jEVD2rsJLjtaOZIHAOV9FaiA2b9dzzs20tBNdSgKyzlfG1/LS6iDwa6U
 L36O4QyZ88UvGI1nevi4pdRZS0E9WhmmFQcPxoEFgkZwNUGJ8jCzXdSn0mvpiUyUH5AN
 oRTg==
X-Gm-Message-State: AOJu0YwyYszacmHf7ECJYsDkOXrr2M+aatsD8u5AjnttAdQadLXgQMZ1
 syjKNWgMspzCr5TQ0IgSpv3mrm+mz4iUeCxq1hrgbYUgJCgY1nqJVuXAjiU4J9ztx8X1hw3wu0S
 pnLIs
X-Gm-Gg: AY/fxX693doKw07mLuRcDge7HWL10zf/kW/KvRGTDpfUigM5eSqs9+gViS6QOVoBerE
 G/il7XwOSWymOvHyYAL7u8M5w6D9Vl+KygU+FfxLjpzXKAwlMevVC8IwgZOgvsc5b/VdTBm0oQq
 zF/8OpGirrCVl93G/o8mRWQTZQaXE6FDpWdK0MggNqbX+M+10I9+YylEMg4yIPhLB9YK+7BZXnV
 9N9LdrPkcEAfyNk7+aVDQQsIt1q7X32J6E2+VYgG3mQXaf9Rel6EVD2bbVjKEC40EQSw1ePMXm9
 hE21kN8QCqd43SkkRM3pvSzN4wCZvBLUsb40eYB31hqh6cqMSztolYBCETi/ZaAfEIO6wUUR9g9
 f/4w/pk6quVbYOIHmAMTHqwjs177/7M1O+T5iy6+mDQ8Z2peMRbD6ZujQKCnQjrMNiBP1a3/MSD
 hSFmBB5jHHmwRW8ecfI646m07k7stXbHxPTzc+QBDoymEYsicW0CgVKy1WqUNY8dUg
X-Google-Smtp-Source: AGHT+IFwRKP6Bw9nsdpRclJzyuLuRPqN4r6Z8Kc0Faz4N+KleHtSDJbpKHp7FOx7Cb2PWg/AAjC02Q==
X-Received: by 2002:a05:6a00:2e19:b0:7ff:dcb5:de20 with SMTP id
 d2e1a72fcca58-7ffdcb5decdmr31362074b3a.66.1767166452263; 
 Tue, 30 Dec 2025 23:34:12 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48f3d7sm34597984b3a.51.2025.12.30.23.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 23:34:11 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 02/11] plugins: factorize plugin dependencies and library
 details
Date: Tue, 30 Dec 2025 23:33:52 -0800
Message-ID: <20251231073401.2097765-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
References: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build                   |  2 +-
 contrib/plugins/meson.build   | 13 ++-----------
 plugins/meson.build           | 15 ++++++++++++++-
 tests/tcg/plugins/meson.build | 13 ++-----------
 4 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/meson.build b/meson.build
index db87358d62d..3d6c6c702d0 100644
--- a/meson.build
+++ b/meson.build
@@ -4499,7 +4499,7 @@ if get_option('plugins')
   if host_os == 'windows'
     # On windows, we want to deliver the qemu_plugin_api.lib file in the qemu installer,
     # so that plugin authors can compile against it.
-    install_data(win32_qemu_plugin_api_lib, install_dir: 'lib')
+    install_data(win32_qemu_plugin_api, install_dir: 'lib')
   endif
 endif
 
diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 6f72b2ce0c9..8f9f0257ee5 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -9,17 +9,8 @@ endif
 t = []
 if get_option('plugins')
   foreach i : contrib_plugins
-    if host_os == 'windows'
-      t += shared_module(i, files(i + '.c') + '../../plugins/win32_linker.c',
-                        include_directories: '../../include/qemu',
-                        link_depends: [win32_qemu_plugin_api_lib],
-                        link_args: win32_qemu_plugin_api_link_flags,
-                        dependencies: glib)
-    else
-      t += shared_module(i, files(i + '.c'),
-                        include_directories: '../../include/qemu',
-                        dependencies: glib)
-    endif
+    t += shared_module(i, files(i + '.c'),
+                      dependencies: plugins_deps)
   endforeach
 endif
 if t.length() > 0
diff --git a/plugins/meson.build b/plugins/meson.build
index 62c991d87fc..4318e3a1671 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -51,11 +51,24 @@ if host_os == 'windows'
     dlltool_cmd = [dlltool, '--input-def', '@INPUT@',
                    '--output-delaylib', '@OUTPUT@', '--dllname', 'qemu.exe']
   endif
-  win32_qemu_plugin_api_lib = configure_file(
+  win32_qemu_plugin_api = configure_file(
     input: win32_plugin_def,
     output: 'libqemu_plugin_api.a',
     command: dlltool_cmd
   )
+  win32_qemu_plugin_api_lib = static_library('win32_qemu_plugin_api',
+                                             link_depends: win32_qemu_plugin_api)
+endif
+
+if host_os == 'windows'
+  plugins_deps = declare_dependency(sources: [files('win32_linker.c')],
+                                    include_directories: '../include/qemu',
+                                    link_with: win32_qemu_plugin_api_lib,
+                                    link_args: win32_qemu_plugin_api_link_flags,
+                                    dependencies: glib)
+else
+  plugins_deps = declare_dependency(include_directories: '../include/qemu',
+                                    dependencies: glib)
 endif
 
 user_ss.add(files('user.c', 'api-user.c'))
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index a6e78438510..c58f2e382ae 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,17 +1,8 @@
 t = []
 if get_option('plugins')
   foreach i : ['bb', 'discons', 'empty', 'inline', 'insn', 'mem', 'reset', 'syscall', 'patch']
-    if host_os == 'windows'
-      t += shared_module(i, files(i + '.c') + '../../../plugins/win32_linker.c',
-                        include_directories: '../../../include/qemu',
-                        link_depends: [win32_qemu_plugin_api_lib],
-                        link_args: win32_qemu_plugin_api_link_flags,
-                        dependencies: glib)
-    else
-      t += shared_module(i, files(i + '.c'),
-                        include_directories: '../../../include/qemu',
-                        dependencies: glib)
-    endif
+    t += shared_module(i, files(i + '.c'),
+                      dependencies: plugins_deps)
   endforeach
 endif
 if t.length() > 0
-- 
2.47.3


