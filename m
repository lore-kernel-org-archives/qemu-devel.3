Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32E8C54E90
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 22:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHs1R-0001Xw-TL; Wed, 21 May 2025 18:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs1M-0001WT-1d
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:34:44 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs15-00050C-5o
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:34:42 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-74068f95d9fso6467212b3a.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 15:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747866865; x=1748471665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0FmrrYF727TSqjvHbt0O4AI+WunPG75VXnTztBP8v6U=;
 b=OUNje9TIaxKNZduRuMZJfjJl630dw+CnZ+/KhxhhZDESkfn+RsVapJb4V10Dxmaynd
 hxYc+A/aTMQpkQctC8isqAdNlxp3dPjvWJmii2M/LrtmYRlQSXNhaem2exI04tlB/CvH
 jXq3lJhbP50vddQfzkkKbUERGM4vFxtNq7rsNqcjnlWLERsqJZmhSggu2jkDuyJAQakt
 OF5zOA4D9I5nDqc5dW8ZVX9sTSsdbGEF5NaiejpqjQphRYrGOOvd4txv7L8UpQpG4+9f
 tWrC/H/y/otTasD0vPtry4vNRaL73+ALVnbiP6W9loSbtHsngIOz+YVkglCNez0D6V3g
 bgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747866865; x=1748471665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0FmrrYF727TSqjvHbt0O4AI+WunPG75VXnTztBP8v6U=;
 b=mIoGGnQj+R6GJfnRXADi/yzWNSNrykhZHbkNMN7e/b+RIrcsqOHrbEIzmMl+Ql/Qbn
 dhdzZ9uoZ87w12WKfXZYG4TobeYTz4x9PbybbRWuZ26pCOZh2NRs31zv1AC8I0NEb7mK
 UnNF5szCdnTHTPNnbCkAvcMQMqBW/bjLI6hLO3Ddkd1KbdrQqNCzFWiUGJo+N3cRi91Q
 WTeEf4wI4MGpljhii6MsXnndS2yx1J18206v1YWfHMO5rvQV+yakNUqb/VQ/bMoS5kMD
 wP0fBsgV4bIs9tA5a103PPOdmJ2ZOmk5XXNkV4+C2+Uh6QagMT6nJegUNe4FJTSjHPsI
 SbJg==
X-Gm-Message-State: AOJu0YygzPght4IYq3dznKJDDiiFXrclYMjVNqXUyo+FJ+KPjJt3uUhY
 BYKgoOqFdbdIldH5MrdAzDGQoxFwAey3mLxLx0fWJ7EI1BmzPfydVV6Z42d345XvLSm70+uhFkx
 JsWvQ
X-Gm-Gg: ASbGnct+m7ElGIW59Vz0qydhe20Vo8BxlsyXAaSKGI/mZwSSGa0Hqq03Pf4dqInj1Zj
 laMIIXnExOpdngCPC9sdXXNFWUPai4mq8sczo8ssNnpXkl2fEIktJkfaFdyVHfdYxA6Og8Vdz/3
 OMBT9xL8pjGwvKhZPd4CGShQAgLw6UiOrI4CnxY1P9CnAkFm2k1RQkO3eW+2QdS+v4wcH1go+Co
 9qVb5FniMn/oUHJpDKUFuA7Tu5xMNWUC/Ga+zd7rlelfGyeTmyt64HDazPsazOAz2R9OJyUV8os
 ysEx4oqKxaX1NDVAVib43ti2UXaF+DY0mAafAbdKMZy7/Tpt3Co=
X-Google-Smtp-Source: AGHT+IHCjN4wu1Ve5jwAcG6NDtSisMrHkZVICZi5jAhsLz2hHOrNhC2SbNIn+milRCCrUwX/nDA/dQ==
X-Received: by 2002:a05:6a00:3d11:b0:736:5438:ccc with SMTP id
 d2e1a72fcca58-742accc6b24mr26657538b3a.9.1747866865441; 
 Wed, 21 May 2025 15:34:25 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eaf5a31dsm10165224a12.2.2025.05.21.15.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 15:34:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, thuth@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 4/7] meson: apply target config for picking files from
 lib{system, user}
Date: Wed, 21 May 2025 15:34:11 -0700
Message-ID: <20250521223414.248276-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250521223414.248276-1-pierrick.bouvier@linaro.org>
References: <20250521223414.248276-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index d803ec47221..22eb2f04e09 100644
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
     objects += lib.extract_objects(src.sources())
     arch_deps += src.dependencies()
   endif
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
   if target_type == 'system' and target_base_arch in hw_common_arch_libs
     src = hw_common_arch[target_base_arch].apply(config_target, strict: false)
     lib = hw_common_arch_libs[target_base_arch]
-- 
2.47.2


