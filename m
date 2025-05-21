Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10828C54E90
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 22:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHs1O-0001XL-LU; Wed, 21 May 2025 18:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs1M-0001WQ-Hc
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:34:45 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs19-00050b-TL
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:34:42 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-742c96af71dso5322602b3a.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 15:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747866868; x=1748471668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BzbmByqdOkqyRMXARFIXus2CwGPGDwIxO/jwoX/CbXM=;
 b=mmodHKjAx3LGbFp11BFg0pud8tZnZ5QdR+3iU1I5ku7EpQGwd+kON6PA0uEFUzJXmQ
 F922vGiHNAQXMo7UowPM1ZVH2RXpBbvg7/jJv55RLUjbJQ7un6m0P8NTViUo3MXeedaC
 uk0iXPV4YVHnZpOiCNse0Gt0io2eSHiJoptW2x1/BxwvCW9Hp32O21dyi20W6IGlrtSQ
 v/2ZdvjxcmAZY+AyVDK/wnfURArcrodPccZKZO24ocRScwcqA1pXCmj1Jogwai8Q6Ptf
 kFFlUlMj+Hbj/cREKdesILN6mcSmZ9jvwPJ5x1YGTApe9+vhlGd9tsafXwNvqctnDmOO
 dlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747866868; x=1748471668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BzbmByqdOkqyRMXARFIXus2CwGPGDwIxO/jwoX/CbXM=;
 b=cRlvLILobtx3T6uGTuZ09i8avzyKda61+B/NiVZ7MxihL8/bXmZ1u5bMRmxdsjxakQ
 +CAJ5hgHik5IV5NOdJAeM3K9Fduzp6tp3w04Ah37Q3LnkQITwtox/ajIm4/7s8Um0no8
 aYEaIbgNiQh++C67CoRUBJf7kQtpTgnX3+7K1NeC+Q22eXlZ4t5o4sWPH/hQVevp/QaT
 BTBDR41dVZYVggYCWIyDQhs8O4kIxGfwGc1O5034Z5u5kxRx641VR6ggVQnMmi0ioww1
 Rppkhxt6YclUYnlgxbrok12ffigf8wpz3qaYed4HxaQhtfcuQHQkbQDy/fd9FE6i0JAx
 U8TA==
X-Gm-Message-State: AOJu0Yw5aTRAZGUjJjZ/5DDSn8GWwadvjm3v35ZIGB2C/NSLO3mNGlFM
 baLEm9rhHh5B/lBEJy/im90pPynr8e68zuT7U2BSzPMUScuSxBZrJsuBjwl5nAR2rSGcEY5lhkK
 c81hZ
X-Gm-Gg: ASbGnctXSEXjuh0BFAn9pdJrhY818WDaUXNOmRFw0KAdJQJGUFdiZkR4Xhz1IC8/uJ3
 EWbbfkIzgEnKTlICXy9O3a9LV2VTDp6Z5yYZHAtWpliyOG+ZFGbBZI5BehGAro80oCxHJBpizRl
 ZY2rcHh2/hOkvMrovqAeRzz58Ypg+kpL0tNA8nK3hNBB3zgCJc8c4EghXtlJ8kemKvXFJdSagOV
 zNq5iBg32602LvSEjCg2MUF/brzkjmWjrv6OGk9CRRf1S++Gx0c2jc6LNaAimp300aXXjbKy1Rz
 BzeKYAgv6qiGCQvAmk+0KwBMx4ME8f5x8MfI9Ez0mGqLcCclOJY=
X-Google-Smtp-Source: AGHT+IGMV2qNrOkZCutEZzQtXRCnh8SatdbIhZY1/S1cvReL3RJKd8edhUoLhBndd22BKq4rH20x3A==
X-Received: by 2002:a17:90b:4a50:b0:301:98fc:9b5a with SMTP id
 98e67ed59e1d1-30e7d500953mr32636482a91.6.1747866867942; 
 Wed, 21 May 2025 15:34:27 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eaf5a31dsm10165224a12.2.2025.05.21.15.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 15:34:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, thuth@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 7/7] meson: merge hw_common_arch in
 target_common_system_arch
Date: Wed, 21 May 2025 15:34:14 -0700
Message-ID: <20250521223414.248276-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250521223414.248276-1-pierrick.bouvier@linaro.org>
References: <20250521223414.248276-1-pierrick.bouvier@linaro.org>
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

No need to keep two different libraries, as both are compiled with exact
same flags. As well, rename target common libraries to common_{arch} and
system_{arch}, to follow what exists for common and system libraries.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/meson.build b/meson.build
index 087ce7dd20d..f57b051b3d4 100644
--- a/meson.build
+++ b/meson.build
@@ -4121,7 +4121,6 @@ common_all = static_library('common',
                             dependencies: common_ss.all_dependencies())
 
 # construct common libraries per base architecture
-hw_common_arch_libs = {}
 target_common_arch_libs = {}
 target_common_system_arch_libs = {}
 foreach target_base_arch, config_base_arch : config_base_arch_mak
@@ -4150,22 +4149,10 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
   target_c_args = ['-DCPU_DEFS_H']
   target_system_c_args = target_c_args + ['-DCOMPILING_SYSTEM_VS_USER', '-DCONFIG_SOFTMMU']
 
-  if target_base_arch in hw_common_arch
-    src = hw_common_arch[target_base_arch]
-    lib = static_library(
-      'hw_' + target_base_arch,
-      build_by_default: false,
-      sources: src.all_sources() + genh,
-      include_directories: inc,
-      c_args: target_system_c_args,
-      dependencies: src.all_dependencies() + common_deps + system_deps)
-    hw_common_arch_libs += {target_base_arch: lib}
-  endif
-
   if target_base_arch in target_common_arch
     src = target_common_arch[target_base_arch]
     lib = static_library(
-      'target_' + target_base_arch,
+      'common_' + target_base_arch,
       build_by_default: false,
       sources: src.all_sources() + genh,
       include_directories: inc,
@@ -4175,10 +4162,20 @@ foreach target_base_arch, config_base_arch : config_base_arch_mak
     target_common_arch_libs += {target_base_arch: lib}
   endif
 
+  # merge hw_common_arch in target_common_system_arch
+  if target_base_arch in hw_common_arch
+    hw_src = hw_common_arch[target_base_arch]
+    if target_base_arch in target_common_system_arch
+      target_common_system_arch[target_base_arch].add_all(hw_src)
+    else
+      target_common_system_arch += {target_base_arch: hw_src}
+    endif
+  endif
+
   if target_base_arch in target_common_system_arch
     src = target_common_system_arch[target_base_arch]
     lib = static_library(
-      'target_system_' + target_base_arch,
+      'system_' + target_base_arch,
       build_by_default: false,
       sources: src.all_sources() + genh,
       include_directories: inc,
@@ -4373,12 +4370,6 @@ foreach target : target_dirs
     objects += libuser.extract_objects(src.sources())
     arch_deps += src.dependencies()
   endif
-  if target_type == 'system' and target_base_arch in hw_common_arch_libs
-    src = hw_common_arch[target_base_arch].apply(config_target, strict: false)
-    lib = hw_common_arch_libs[target_base_arch]
-    objects += lib.extract_objects(src.sources())
-    arch_deps += src.dependencies()
-  endif
   if target_type == 'system' and target_base_arch in target_common_system_arch_libs
     src = target_common_system_arch[target_base_arch].apply(config_target, strict: false)
     lib = target_common_system_arch_libs[target_base_arch]
-- 
2.47.2


