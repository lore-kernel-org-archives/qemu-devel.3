Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29F5C36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 05:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twwQW-0006gT-4I; Tue, 25 Mar 2025 01:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwOA-00041f-Tn
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:48 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwO9-0005yR-56
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:46 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ff69365e1dso7102779a91.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 21:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742878784; x=1743483584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kI6HALsdQGcYyIHmM8Ppnw0EYvYwjf9AgyEFGP9MumA=;
 b=jwo/0ENXfDGGU13ghgCw2kF2ba88BoXTFYY/6RZQvA/KZ1tKvcCd/hJdZ9EiqtLD55
 zLOH8Yo4gP9m+1RqnBWloTNxFy1H/5l3s/RPlYRzoE/iLxW4g1+vgAqze2xMifgqqthZ
 PM7IcB2mREORcSVIH8PR5HVkJS4FsGvJBFS3vs1upw4kth6pn4dCTfjXdvu6V012SqRR
 oZgm/mpco6133EFSrJtlgpjheCXXHH5pnX0iMZ4VoqLBoJBgZcjal52Kl7wtkfpzUOIP
 HEfyv3V1aprjidHad6l99JfkxclfgzVvbR3A0NLb/9KBwSU2nlZWdKUVOzrRG5OP2Kku
 D9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742878784; x=1743483584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kI6HALsdQGcYyIHmM8Ppnw0EYvYwjf9AgyEFGP9MumA=;
 b=A5wgpQrdoLh42EDKDxKyxIDfadQ7bH8VCJrlv7LARoBdWait4H8Q8yOaI/9l+MF2tW
 5mFhZjWd2fr1DFJYamk6BoP2vdGlUHzbajkq96NKqy3iDrMMWk2Ky6GvsJZyJ/8Ico26
 fkcHUJFW4B+QGHKBD3hXQTxRo2cl75eVF8eacSnRDX+7tcNk+LVOK8CZhGTFy/pL2EaY
 KLP6HnJ2brBDEr3vfbTNr8We+LcB3EjGqXHFe2jGkuYnSJlIbgNN1+tJFkcDEF3TU5gf
 9GFCh+WcUbXrliHVq8+ptHdqmcbytFj5ElFL9Tl6v2psCZo9JbZaRtmHfvsaAj47N1tE
 vXQg==
X-Gm-Message-State: AOJu0Ywxf7LsfxDSS0kcaSGmgfCdKC9ZZ2Lhery8k6hjmoB2wpknUzCK
 +jqVvmZsrW9DZgwVjEVI1tOhLxNaWATbQhGjNL9CvVJ1DWP1uOOWFQvJDggOapKYUcffe7viYJ4
 R
X-Gm-Gg: ASbGncuAtqWdK6uPHkOsgeO4zC34NmbCSj6mdBDSXowwvrmi5iEc2BokU0zL8oSMVP2
 gKxSBda+vhyk4MeHimE0KeX6OrcnKAzUFIkBKrQepgmLj0YRgcwPVt/SvlSXpFNeBHvEhXmfObc
 tw/LGkZUJgiLdtkbUGLpoAbf1UNvRrAre+oOfspuuOT3HDBKJppnpJvFkqos0Mrt+ensBNXfFet
 4k9HugM+67BJNsV5gCk7NapsKYIpadXp+EJwCCF7tYq752wiGJFjhemXNx2HdVnCIX3MZkYJ579
 j6TNfpS0xdOx3SKjefoI3evF3F8za/qUUVaYYhuotxPW
X-Google-Smtp-Source: AGHT+IEViWj0HXthzkisCL6XXxnNrY9f+XJAj3XYkE+svRDw8yixLHab1+2GgLUvE4lRjRG8yLIalg==
X-Received: by 2002:a17:90b:3847:b0:2ff:79ca:24b7 with SMTP id
 98e67ed59e1d1-3030fe9804emr16981073a91.21.1742878783768; 
 Mon, 24 Mar 2025 21:59:43 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58b413sm14595120a91.13.2025.03.24.21.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 21:59:43 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 23/29] meson: add common hw files
Date: Mon, 24 Mar 2025 21:59:08 -0700
Message-Id: <20250325045915.994760-24-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
References: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
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

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index c21974020dd..994d3e5d536 100644
--- a/meson.build
+++ b/meson.build
@@ -3691,6 +3691,7 @@ hw_arch = {}
 target_arch = {}
 target_system_arch = {}
 target_user_arch = {}
+hw_common_arch = {}
 
 # NOTE: the trace/ subdirectory needs the qapi_trace_events variable
 # that is filled in by qapi/.
@@ -4089,6 +4090,34 @@ common_all = static_library('common',
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
+    target_inc = [include_directories('target' / target_base_arch)]
+    src = hw_common_arch[target_base_arch]
+    lib = static_library(
+      'hw_' + target_base_arch,
+      build_by_default: false,
+      sources: src.all_sources() + genh,
+      include_directories: common_user_inc + target_inc,
+      implicit_include_directories: false,
+      # prevent common code to access cpu compile time
+      # definition, but still allow access to cpu.h
+      c_args: ['-DCPU_DEFS_H', '-DCOMPILING_SYSTEM_VS_USER', '-DCONFIG_SOFTMMU'],
+      dependencies: src.all_dependencies())
+    hw_common_arch_libs += {target_base_arch: lib}
+  endif
+endforeach
+
 if have_rust
   # We would like to use --generate-cstr, but it is only available
   # starting with bindgen 0.66.0.  The oldest supported versions
@@ -4254,8 +4283,14 @@ foreach target : target_dirs
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


