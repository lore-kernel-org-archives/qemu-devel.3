Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88884D715EE
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 18:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjiOC-0004OQ-In; Sat, 24 Jan 2026 13:29:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vjiOA-0004My-Du
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 13:29:38 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vjiO8-0003i0-NQ
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 13:29:38 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-81f4ba336b4so3409124b3a.1
 for <qemu-devel@nongnu.org>; Sat, 24 Jan 2026 10:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769279375; x=1769884175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3H6hIAF7SZwgrqiWVBpeeffVKbo02h7eCzEGhVevvNQ=;
 b=w4gLSr22vpU/K5M6GJ+ie1oUdIlUs0WQdNfJnccjU/zxT8OmcJWPFIOxJ5EGyuOo5y
 vH8Mnj7pPU5qL0LPUS2+Dje7Igaw6b1D/XE6OhKWR2V5y2u+OZE6yeFuQ79iAFkqaEFQ
 BopRmV3ibg6z17vEzMiL0Wti8xDiVlA0PR9oiumqNRNeynJhaJhkL07pDa7dbbSM5sLe
 0gPUFcere0dfHyu4zUXxyVDb9ACNjKTOrxZBxJMO2mRI8q6gk6qW35QDT2KaZJ4+Z0ZY
 UNz2sf42GjoMHVZoNm4RRJeFztJhCRfP2dn0dSfS3flxlpkn0SJdele30wJdF1IFoPxu
 Q7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769279375; x=1769884175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3H6hIAF7SZwgrqiWVBpeeffVKbo02h7eCzEGhVevvNQ=;
 b=iS+8Tv1caBoeME3JzXsu800Y9l21SEfgTwoqQSiGcgrtr0sqX0B/lFK7evYJ15xsJ0
 PBxVbadeptrt8LfBcIOpmDgxLqMUcCvCVamc/ZMttJa00aAiaTCTypdx20Ma/YSxstDu
 EWdZyhZq4uoMmo9Mka0/dumyRqjoEH+52wVogYun7ONAE+D4UPfPOXh6dTBJrHNH3PjO
 Yu+YMzRH6j1iexVMb0jcbrI/MwGq8OSUSzTO1Y0SHw2YhZNoqXIuW3VUGL21nFpPc0Nd
 j3t49lKLv/TQR7pwPesWKLz0MBZ0sXP2alBwXjAcJmyloDLTAM/p26j0MRdDMyPPYof9
 9ynA==
X-Gm-Message-State: AOJu0YzYCc6Lwf7wnOIQNm37bfiu/+MligUBd33vN1lLNEOIn4Tlasft
 CdvWxxf5JMqoFev4IaYZ42SCq4NbDkQRddXDPyyUHdXvFNn/TSGkabaP/93ZbVz405aMdI7SmMP
 GpQbLYdo=
X-Gm-Gg: AZuq6aIA+ydjRJMPVS9qpRa4UnzWvebD4NKFuvosHNNbvra0FbNd9UqEiuuI6uufz1F
 txE0YGB5mlCuZREHB5jXTlWy1pZjgNhEbgWb/PRNpnUcXqt99ocnctd1R3DD7WQMq8Fg7L0CYap
 e5yxOw44uvELU/J4Y6OnW6fpjkWutSl2jhxuggpg7LQrEhSmzTaBEOJ7fhgNVZdSNBfvOIvrmKg
 WRrGffWVavxVwh7gS+lyBUkCJMYzPh66LHj3RDgSXJi1ftMMjL+GhQzNp90STE5YRgrVzEFxWvj
 CdS54RI9Jt0fncDSYD0F1WIzc0F4yBXC71HlApjNva3eJ0Hrx+8/t+bfp7KyxjxMs/GWv6zwPIC
 9JvikwsZ2xmaAnHMo/2fN7PM7db0XmF37TImmXlKlrsutinsdOJJGQyO76eWp2m/OoiRauDZU97
 QmXMH+f74tOb7iub3NdzpzS2QzoBhUU3YoOUEboPMRY4mtKzih6EjV3c/GpvlHSVB/
X-Received: by 2002:a05:6a00:1a0f:b0:81f:22ca:257 with SMTP id
 d2e1a72fcca58-82317dd6c5fmr4910802b3a.20.1769279375196; 
 Sat, 24 Jan 2026 10:29:35 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8231871d432sm5296485b3a.42.2026.01.24.10.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Jan 2026 10:29:34 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v4 06/11] plugins: move qemu-plugin.h to include/plugins/
Date: Sat, 24 Jan 2026 10:29:16 -0800
Message-ID: <20260124182921.531562-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260124182921.531562-1-pierrick.bouvier@linaro.org>
References: <20260124182921.531562-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

This change has two benefits:
- ensure plugins can't include anything else from QEMU than plugins API
- when compiling a C++ module, solves the header conflict with iostream
  header that includes transitively the wrong ctype.h, which already
  exists in include/qemu.

By Hyrum's law, there was already one usage of other headers with mem
plugin, which has been eliminated in previous commit.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/devel/tcg-plugins.rst              | 4 ++--
 meson.build                             | 2 +-
 include/{qemu => plugins}/qemu-plugin.h | 3 ---
 include/qemu/plugin.h                   | 2 +-
 plugins/core.c                          | 2 +-
 plugins/meson.build                     | 6 +++---
 6 files changed, 8 insertions(+), 11 deletions(-)
 rename include/{qemu => plugins}/qemu-plugin.h (99%)

diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index 9463692c411..f48c32bd844 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -166,7 +166,7 @@ Plugin API
 ==========
 
 The following API is generated from the inline documentation in
-``include/qemu/qemu-plugin.h``. Please ensure any updates to the API
+``include/plugins/qemu-plugin.h``. Please ensure any updates to the API
 include the full kernel-doc annotations.
 
-.. kernel-doc:: include/qemu/qemu-plugin.h
+.. kernel-doc:: include/plugins/qemu-plugin.h
diff --git a/meson.build b/meson.build
index e54fe9863eb..514d48eee72 100644
--- a/meson.build
+++ b/meson.build
@@ -4446,7 +4446,7 @@ endforeach
 # Other build targets
 
 if get_option('plugins')
-  install_headers('include/qemu/qemu-plugin.h')
+  install_headers('include/plugins/qemu-plugin.h')
   if host_os == 'windows'
     # On windows, we want to deliver the qemu_plugin_api.lib file in the qemu installer,
     # so that plugin authors can compile against it.
diff --git a/include/qemu/qemu-plugin.h b/include/plugins/qemu-plugin.h
similarity index 99%
rename from include/qemu/qemu-plugin.h
rename to include/plugins/qemu-plugin.h
index e44f863d839..78872716246 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -2,9 +2,6 @@
  * Copyright (C) 2017, Emilio G. Cota <cota@braap.org>
  * Copyright (C) 2019, Linaro
  *
- * License: GNU GPL, version 2 or later.
- *   See the COPYING file in the top-level directory.
- *
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index cea0a68858b..cdd4f68c0c1 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -8,7 +8,7 @@
 #define QEMU_PLUGIN_H
 
 #include "qemu/config-file.h"
-#include "qemu/qemu-plugin.h"
+#include "plugins/qemu-plugin.h"
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
 #include "qemu/option.h"
diff --git a/plugins/core.c b/plugins/core.c
index b4b783008f7..3f66533d749 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -15,7 +15,7 @@
 #include "qemu/lockable.h"
 #include "qemu/option.h"
 #include "qemu/plugin.h"
-#include "qemu/qemu-plugin.h"
+#include "plugins/qemu-plugin.h"
 #include "qemu/queue.h"
 #include "qemu/rcu_queue.h"
 #include "qemu/rcu.h"
diff --git a/plugins/meson.build b/plugins/meson.build
index 4318e3a1671..34643e2cea3 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -3,7 +3,7 @@ if not get_option('plugins')
 endif
 
 qemu_plugin_symbols = configure_file(
-  input: files('../include/qemu/qemu-plugin.h'),
+  input: files('../include/plugins/qemu-plugin.h'),
   output: 'qemu-plugin.symbols',
   capture: true,
   command: [files('../scripts/qemu-plugin-symbols.py'), '@INPUT@'])
@@ -62,12 +62,12 @@ endif
 
 if host_os == 'windows'
   plugins_deps = declare_dependency(sources: [files('win32_linker.c')],
-                                    include_directories: '../include/qemu',
+                                    include_directories: '../include/plugins',
                                     link_with: win32_qemu_plugin_api_lib,
                                     link_args: win32_qemu_plugin_api_link_flags,
                                     dependencies: glib)
 else
-  plugins_deps = declare_dependency(include_directories: '../include/qemu',
+  plugins_deps = declare_dependency(include_directories: '../include/plugins',
                                     dependencies: glib)
 endif
 
-- 
2.47.3


