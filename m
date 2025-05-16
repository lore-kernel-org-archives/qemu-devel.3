Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F40C3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 05:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFnbS-0006Hj-3n; Fri, 16 May 2025 01:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFnbQ-0006Gs-9S
 for qemu-devel@nongnu.org; Fri, 16 May 2025 01:27:24 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFnbO-0001N5-7d
 for qemu-devel@nongnu.org; Fri, 16 May 2025 01:27:23 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22e16234307so18470005ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 22:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747373241; x=1747978041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RZ2uL7bC3soA9y6EO90cuXo0NZXixq/mNNsFQ78SaEM=;
 b=rdBWn2GnTsFFoPiozSjitPKmd/j6s6FaWNvGDCbJjqxt1ps/3diE2lQAlE0pmPUCV0
 YtAPHXTJvEvH0xQP/s2rUogF3A5tg7Z2R4qxk6kNiZ6d2sFC5mcyfQ9t/Jhganoq7UQd
 SlLfx8KVYmfpDG/7nc4OZFyqtQK3zTLOn2+9CKf0KXaYbdBwP4hcsMeL3vjOR9FZfwxd
 QybL1Top15PJFsDEVJ56ficEGqZGxisDoNz107U3y0i4tHDtJ3lqxcOcdFuaekZQHmOk
 n4KZmcixNFxXyXpzh57y5iIXZdJiPqq3xkoTCVNT0nOPtO2MBNlPy+NOo836FNt+jxr7
 nYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747373241; x=1747978041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RZ2uL7bC3soA9y6EO90cuXo0NZXixq/mNNsFQ78SaEM=;
 b=q+DnRszRVFX/GxoIvvOd+sUEqmPCcMrFPZxTofYiYmFTO4diaY5vJ+Rci9L39YrM1Y
 77uKhp3W08oNbTLslCP77T9ofDK9TQEBOXnVW7AYKtp0LEkK6g06MxmJQqEtZg5OHxkM
 TKHcX/rzEBkUoWBfLlz+U4w/btaZ2hxd4yUCEYgCXh6qX0NuOptNW+fmWRZ6o/enRuOc
 U2TbCM4fUS7oZiOVeORcrf0eGETfNfyYkNWynm2bM5UqxWFL+hLyaP0f2Olh5lRcsicB
 tkthVDQ1OhAXLhsCZQwHV4qKKz+kDcCwAXOxyWjYGBmAZnTTFDF0SAGyEWnDMEie49Ts
 csEg==
X-Gm-Message-State: AOJu0YyC53dF/wjLQAVr8U4Zb7lem6BVGcyPzWzoRnAa3Msev0NnZdJi
 p4aVIO+rQ+9NYf8uKMjG/ODi5GDaeL47dupJC5gL5STmNnzWusEYJKykX/5K9Nsl+fUOCFJhEdz
 zy+r1
X-Gm-Gg: ASbGncsu0W4CGl9xMbWB+eNcusSFaJTLwijy71iNwziwl28mPTaw6CgJsHKEsO3n/ZA
 7deSRFf6bvfi+afZz60pDN9a83XC2MYo23PqtYsFoEE91PYDnhPYbGzSex7wtZqvpe8KJICNCxU
 CQMJsPjDvAQ++wCQ+HBVtQIN1FFhxoGeXCfp+8n70ug+KuoGKgGjF3+uoRsJ7oCd/5suM32v1L8
 ErV2zqDKdTTKmhvlFIG2lNnr9yJ3FiFfP09UhLxeou+KcSHAdF2dB6rVIrFwg8q+i7M1jeAC0le
 Jclf3Kh0l2KrBjDZXnkXOgMVbhYYT9XDXRJtXnp5mmux6jhER9Y=
X-Google-Smtp-Source: AGHT+IEKXoDYhZw/QppgRZMTMgKXoLnbtyUY1tcDGzJrJaHFKiGzORTiAC5WdVlwJz+9fRNVbyRCiQ==
X-Received: by 2002:a17:902:e803:b0:21f:2e:4e4e with SMTP id
 d9443c01a7336-231d4ae1dbemr24621885ad.5.1747373240683; 
 Thu, 15 May 2025 22:27:20 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4ebabfesm6539135ad.174.2025.05.15.22.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 22:27:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 thuth@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 4/6] meson: apply target config for picking files from
 lib{system, user}
Date: Thu, 15 May 2025 22:27:06 -0700
Message-ID: <20250516052708.930928-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250516052708.930928-1-pierrick.bouvier@linaro.org>
References: <20250516052708.930928-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

semihosting code needs to be included only if CONFIG_SEMIHOSTING is set.
However, this is a target configuration, so we need to apply it to the
lib{system, user}_ss.

As well, this prepares merging lib{system, user}_ss with
{system, user}_ss.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/meson.build b/meson.build
index 197fdc1c210..fadee0f29fa 100644
--- a/meson.build
+++ b/meson.build
@@ -4101,27 +4101,19 @@ common_ss.add(qom, qemuutil)
 common_ss.add_all(when: 'CONFIG_SYSTEM_ONLY', if_true: [system_ss])
 common_ss.add_all(when: 'CONFIG_USER_ONLY', if_true: user_ss)
 
-libuser_ss = libuser_ss.apply({})
 libuser = static_library('user',
-                         libuser_ss.sources() + genh,
+                         libuser_ss.all_sources() + genh,
                          c_args: ['-DCONFIG_USER_ONLY',
                                   '-DCOMPILING_SYSTEM_VS_USER'],
-                         dependencies: libuser_ss.dependencies(),
+                         dependencies: libuser_ss.all_dependencies(),
                          build_by_default: false)
-libuser = declare_dependency(objects: libuser.extract_all_objects(recursive: false),
-                             dependencies: libuser_ss.dependencies())
-common_ss.add(when: 'CONFIG_USER_ONLY', if_true: libuser)
 
-libsystem_ss = libsystem_ss.apply({})
 libsystem = static_library('system',
-                           libsystem_ss.sources() + genh,
+                           libsystem_ss.all_sources() + genh,
                            c_args: ['-DCONFIG_SOFTMMU',
                                     '-DCOMPILING_SYSTEM_VS_USER'],
-                           dependencies: libsystem_ss.dependencies(),
+                           dependencies: libsystem_ss.all_dependencies(),
                            build_by_default: false)
-libsystem = declare_dependency(objects: libsystem.extract_all_objects(recursive: false),
-                               dependencies: libsystem_ss.dependencies())
-common_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: libsystem)
 
 # Note that this library is never used directly (only through extract_objects)
 # and is not built by default; therefore, source files not used by the build
@@ -4365,6 +4357,16 @@ foreach target : target_dirs
   target_common = common_ss.apply(config_target, strict: false)
   objects = [common_all.extract_objects(target_common.sources())]
   arch_deps += target_common.dependencies()
+  if target_type == 'system'
+    src = libsystem_ss.apply(config_target, strict: false)
+    objects += libsystem.extract_objects(src.sources())
+    arch_deps += src.dependencies()
+  endif
+  if target_type == 'user'
+    src = libuser_ss.apply(config_target, strict: false)
+    objects += libuser.extract_objects(src.sources())
+    arch_deps += src.dependencies()
+  endif
   if target_base_arch in target_common_arch_libs
     src = target_common_arch[target_base_arch].apply(config_target, strict: false)
     lib = target_common_arch_libs[target_base_arch]
-- 
2.47.2


