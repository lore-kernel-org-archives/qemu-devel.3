Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB712C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 04:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuOx6-000284-Nh; Tue, 18 Mar 2025 00:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuOvd-0001FC-0A
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 00:51:50 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuOvZ-0008Vo-Sz
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 00:51:48 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22423adf751so86810155ad.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 21:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742273504; x=1742878304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ek8XPpj4hrtyNGDcqo+uXNBksQzSJC0Hy5Yo4DqMKUU=;
 b=TkMeUbTbWVSTVfGDQStjx7cusWg7+O7d4xjQH6x4Sq/6Lj3Ap9SWyUXOlshSXGOpTB
 Szs2Ld1Eb2nfh5YnYBcFQ6agheZyX7MtPM7cdSpx4VmXWcpsaUqQvPXQz+CC1AnmxHEN
 SSlUnS0RTcfQWIMdTfKaFzYm6GLxoLYNzOpFKdqgS+NA4rtsPSF80q4IXQn8CVSTh5eH
 6EA1z00ggWuZtG2PC/2OCW0ZpPYneMu8/LOIfLN7gTUp8mhwUuZqtk/Z7qJzQEUebV9V
 RI8gK2HGBDLWm409+AjHYQYNXZcixJV1Z1ePd125Gn9xqWHtC3KaxdJc5+Uegp5jlWyE
 J7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742273504; x=1742878304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ek8XPpj4hrtyNGDcqo+uXNBksQzSJC0Hy5Yo4DqMKUU=;
 b=dUCd+n36sMloXXruuhE2ZzbYJ4D5Y6BqP1Rolo8MV3W/VH7iih2kFh9DwwEA4eE7Tm
 NDC/2ApXyFh7R8sWeqRkd6Y1vwjdJdbyRJfAI8xkLG5QxKdvuwIYlNLxaz/t3VZvxwJY
 HdT/0KAJnIR3yBYLmxg6FYx2d6dA0ioX0zlfYWJjUm7lceCztYZ1yzQyWP7yG258q4L9
 zELK/evb5VYbKEIQbHZE1GsBN2N7GIQuzi07MDNaNl99LKqRKLP3mAgJ80bg2MoAZRxp
 iQwIbAVdXVdrX3dB+NUUeoQyHi9HKick0JLyXouULQuOVJZ9x7PmuWE+b6ejk+Tk6dij
 9Evg==
X-Gm-Message-State: AOJu0YxEQph7TwNFBlhodaoWt/UC+MB8n6d7to+fZn0N86MLsD4LUUcZ
 9F9yx3+gECK9oHlNtzbE7k6QzIB1PBW/ioexNHFtnQD/kBh1NQE+msgRMG45KATRBsehUwWs/vv
 w
X-Gm-Gg: ASbGncuX2rN05Ad7qwspxs0Ly7xl/6R8e+FJTryUi3YVxB4KwEAWzCLZC4c+r/Q94c2
 3XSEsHkZ0nLCjgQvtfXvKjIWpQxXtUHHJfU5YZ8tT/97cXja1ePdglaT5LHmqCvOnxtMUG3ixa2
 xw/3ylBbTIV6w5ySrX8BTUXRVEfZvyTPlum21PTxWtXlNimOGoaWu4oHPbm9gdnfpAxB9AKahP4
 2YSvK8NOr3Qv1B9koGu+Yy9DT2TXxrC+IAjC4uwLXj6G7ebhZIF05zVOVZ0G5vS/sGdNFnc79Z+
 CIGxGG0zep3LGuXmK46t3hot3Nup9AhvRWcuK9/3G6F1
X-Google-Smtp-Source: AGHT+IGT3hRB7cgRAOTfF6ymEpowIUFgQzMXE5GAC2ISpsBZy5NX8Js4RVALQRBZLAuQQLxc3QHe/w==
X-Received: by 2002:a05:6a21:68e:b0:1f5:82ae:69d1 with SMTP id
 adf61e73a8af0-1f5c12098fcmr21810295637.20.1742273504481; 
 Mon, 17 Mar 2025 21:51:44 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711694b2csm8519195b3a.129.2025.03.17.21.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 21:51:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 12/13] meson: add common hw files
Date: Mon, 17 Mar 2025 21:51:24 -0700
Message-Id: <20250318045125.759259-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

Those files will be compiled once per base architecture ("arm" in this
case), instead of being compiled for every variant/bitness of
architecture.

We make sure to not include target cpu definitions (exec/cpu-defs.h) by
defining header guard directly. This way, a given compilation unit can
access a specific cpu definition, but not access to compile time defines
associated.

Previous commits took care to clean up some headers to not rely on
cpu-defs.h content.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 672a0f79d11..0dec7d9750e 100644
--- a/meson.build
+++ b/meson.build
@@ -3689,6 +3689,7 @@ hw_arch = {}
 target_arch = {}
 target_system_arch = {}
 target_user_arch = {}
+hw_common_arch = {}
 
 # NOTE: the trace/ subdirectory needs the qapi_trace_events variable
 # that is filled in by qapi/.
@@ -4065,6 +4066,33 @@ common_all = static_library('common',
                             implicit_include_directories: false,
                             dependencies: common_ss.all_dependencies())
 
+# construct common libraries per base architecture
+hw_common_arch_libs = {}
+foreach target : target_dirs
+  config_target = config_target_mak[target]
+  target_base_arch = config_target['TARGET_BASE_ARCH']
+
+  # check if already generated
+  if target_base_arch in hw_common_arch_libs
+    continue
+  endif
+
+  if target_base_arch in hw_common_arch
+    src = hw_common_arch[target_base_arch]
+    lib = static_library(
+      'hw_' + target_base_arch,
+      build_by_default: false,
+      sources: src.all_sources() + genh,
+      include_directories: common_user_inc,
+      implicit_include_directories: false,
+      # prevent common code to access cpu compile time
+      # definition, but still allow access to cpu.h
+      c_args: ['-DCPU_DEFS_H', '-DCONFIG_SOFTMMU'],
+      dependencies: src.all_dependencies())
+    hw_common_arch_libs += {target_base_arch: lib}
+  endif
+endforeach
+
 if have_rust
   # We would like to use --generate-cstr, but it is only available
   # starting with bindgen 0.66.0.  The oldest supported versions
@@ -4230,8 +4258,14 @@ foreach target : target_dirs
   arch_deps += t.dependencies()
 
   target_common = common_ss.apply(config_target, strict: false)
-  objects = common_all.extract_objects(target_common.sources())
+  objects = [common_all.extract_objects(target_common.sources())]
   arch_deps += target_common.dependencies()
+  if target_type == 'system' and target_base_arch in hw_common_arch_libs
+    src = hw_common_arch[target_base_arch].apply(config_target, strict: false)
+    lib = hw_common_arch_libs[target_base_arch]
+    objects += lib.extract_objects(src.sources())
+    arch_deps += src.dependencies()
+  endif
 
   target_specific = specific_ss.apply(config_target, strict: false)
   arch_srcs += target_specific.sources()
-- 
2.39.5


