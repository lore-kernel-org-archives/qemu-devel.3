Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACF5C369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JRI-0001eW-No; Tue, 22 Apr 2025 15:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JPD-0005kG-7k
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:45 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JPB-00078U-6B
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:42 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22d95f0dda4so23679335ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350538; x=1745955338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=34NdhhU3f0ctFhHISwM+Va89Ek8XPnoY2t73ZYMcmeo=;
 b=rxrtKf9j2yaXah8abqhxm0F/aNnUFq/AOmUTiePySU+VBsySWGfyZqH0e9GnKoVr06
 PLbsqQRFTNN3j8V1/9YJ6scIeqkOH2b9YdGv7q/Vdf7ZiOM/DKVc0va+EOe9zgqsbAcV
 MzvcjFpeUJ/BX7xqSnaULK+nRBZL2oEXFEKFtq9zxb2/PDn3Ggvj/8gJv0B7a5+/Jv9Z
 pyyTy+DDPj6cMyvNHoJMG9LM3BOB8zNBRmwWP5BT+Y7KCID6SSdrXrHsSM1J4jdbqTzv
 t1oen8GWh+P5gx32H4DeC7a9HYxUtEAyboGI9xC4uFDh/8ZgaSTZbxU5BkL4qFpbwtZu
 eNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350538; x=1745955338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=34NdhhU3f0ctFhHISwM+Va89Ek8XPnoY2t73ZYMcmeo=;
 b=SO+yAB6NZsgG9E820Gb3SLFD7k8N40YOQlGmbXqRoDgVtZ5n3Zu+e0CKsi5jSHx8by
 AMYG+DDawVyjZ6OubzDX8mMVe79/yaH9wzqrGhZShtkJLWN0svWoNR8brPA/uKYq8mBY
 r8Stmjr0rUpAuBiq1mVlIS/Orz7VJVR5q18FovXrexIUk/UARJxIKRLtB6lYHTSBo/oV
 NCbY6LcrRTzkrNn9nN1tK227U8DUTENVFHJy5LIXvhJteAUcLFrwswiHBJmreF757FsI
 619ZmqC7QuXdd3EOuRC2bWEzSAJJeJD7bi36bX4foDNsv0z2Us/LQwRwSB9qzHGJzxG6
 pEjQ==
X-Gm-Message-State: AOJu0YzO/1NZiAnkACzv9ZEoIxgA8bogRQn0GdcAtn6cbRlUxx44IOeD
 7GxKv3v4pAi7ItZlLBwGZnErA/abn9NawPs4YkkH+FeIsO3TJsZS/8DWTHjdnhsNTdcIWEmy+dt
 R
X-Gm-Gg: ASbGncu9GVg1CgZxcmTUn+hok7p9aVzYN3XA9YT/cHmC2qabvPBXVoqCK4lHq0dQ6yj
 WiZf43KZucxtbuUxglndZJKrZhqag3jAxIqGrG6IaDVLc7f1LephYnIIMWot1piI9j75ejrwt/p
 /+ni/NFEPVaW6jBSc4+UKOltiV/aHpvekPZnbfCd07eSEDXUhfYzWN3TvOplek+wMyNRRoSREI6
 40YRDNU8JIGUqefYta4Z47k+8EfFnWWaMM6gafy4GB5ro+BUXDPv6rwyZbTR0WStaKmdPMI+0Wm
 j72gQMQwQ51kJhmPWKRPMZClYt+fFzt9giy7jqkbjEArraqFhTFToOLq0yfywFVaAFxgdLsWujL
 8PK5+HfKXtQ==
X-Google-Smtp-Source: AGHT+IF2f5rPLkTHWt89GTslgR1eP7b98JgYrmBPjn//sv1hKsMuYH7fPwWMTQDtuxDXwrmvbp3irw==
X-Received: by 2002:a17:903:41c7:b0:220:faa2:c911 with SMTP id
 d9443c01a7336-22c535a4b39mr226659575ad.14.1745350538534; 
 Tue, 22 Apr 2025 12:35:38 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 119/147] meson: add common hw files
Date: Tue, 22 Apr 2025 12:27:48 -0700
Message-ID: <20250422192819.302784-120-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Those files will be compiled once per base architecture ("arm" in this
case), instead of being compiled for every variant/bitness of
architecture.

We make sure to not include target cpu definitions (exec/cpu-defs.h) by
defining header guard directly. This way, a given compilation unit can
access a specific cpu definition, but not access to compile time defines
associated.

Previous commits took care to clean up some headers to not rely on
cpu-defs.h content.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-24-pierrick.bouvier@linaro.org>
---
 meson.build | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 657949326b..bcb9d39a38 100644
--- a/meson.build
+++ b/meson.build
@@ -3682,6 +3682,7 @@ hw_arch = {}
 target_arch = {}
 target_system_arch = {}
 target_user_arch = {}
+hw_common_arch = {}
 
 # NOTE: the trace/ subdirectory needs the qapi_trace_events variable
 # that is filled in by qapi/.
@@ -4079,6 +4080,34 @@ common_all = static_library('common',
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
@@ -4244,8 +4273,14 @@ foreach target : target_dirs
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
2.43.0


