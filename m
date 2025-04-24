Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247A3C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kxV-0006T8-2I; Wed, 23 Apr 2025 21:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwg-0004Z6-Te
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:10 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwe-0005Hh-1R
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:06 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-af5085f7861so266867a12.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456402; x=1746061202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=34NdhhU3f0ctFhHISwM+Va89Ek8XPnoY2t73ZYMcmeo=;
 b=HqV/aSIXIZsvT5XMscle6kjuWfCJyEit/9LOL+aKZq2/l2r9s3VnXqDyVcc9Hm8Sxf
 k04yGlPdBuKoGVgo7rEvKrjPKp3E7oLlL6Q4eHzlIN6wprtCtu8N9mStq7h6dJjmg4a5
 QDj9u8/tRKHLxXr0sKzxiiwozVP8OFDXYNhhZV5h1EKtuGTqrSTmcfQOoH5E47ilgJt5
 KraPxZ3ox/hAG3pdPG2pB0WTJL5dPFIFlxO12zrit9yCTqOT3eQJhg71fuFGBIbIR7sk
 TtpZt/2ye39ak+iecLWeXXgV/tlzqHQYLEewxlndu6YUqs8osjw4YdintDuAHZjz9udJ
 DFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456402; x=1746061202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=34NdhhU3f0ctFhHISwM+Va89Ek8XPnoY2t73ZYMcmeo=;
 b=kHuO7rN4Oyn8MyMIKSDai/JSKO0tEUDiTI2VsGs8NmE7+7hfrwtM7oxqViUZWNvfor
 eK86coSe+RgEIZZ3hVTX8iWQiPweMAB3QubCgHEnOmAbbJ5oQUjJc8vtUHLCpzj8kITY
 ifu2Jfiz7dHEPlX6YqgMIDSbI3/LlOFwCs1lHUq5wiKaHsJjD2oS2s3HrCMsTnpreRp8
 ty24eTeqv4RfU89Smqe7LckrBgnywPiiOTupDaPFsrnLtThLaTRFyzxYaCIzmu6xrL9W
 1DUnkdhG9kPUPvqxpbg48BTtakxIrNYzOeDrVZUEAl0taVYrdsK+6nuO9oxND2UGY9RA
 3I6Q==
X-Gm-Message-State: AOJu0YxpQDlfRUzs9v+jphsZLFuCUGOhZFJ8Id0ap+jQIvdGkJjEyFRG
 wdv3QG8KoyfpEKrnrE6H8cSYsUg4+fGz2w8xkZDUuVmrIOHgU3KSrVS3NTcElDB7fGTzm+u0iNO
 p
X-Gm-Gg: ASbGncswJawoLxeHOD9wR2lM8HrKCJBGX6ZOVbgyA+VklfFT9XGQPv2d3SvqyXgCR8R
 a4+mnveMMYgzaNX4qtx3qMOAn7ZysZJjR4Sxls+hsB16JG1rimm3nNOLkgsnBwCj83lKQB/E6uv
 1cyV5lrwuR5tcBFJOLbXG5WmNhANVAWTOQAQjUplMV1AeKbV3bLxI/YG0uCyqAdeFdmdXNHRmMa
 ph2ooxk4+aqw2Ku7VBoTcOP6WMRShrBS7RbPViDlP7+Ktr69aFpWvoXQi74oe/vBqXdtXhjTXsZ
 5IhAivtx2uMUSqjQQa3z6GJCTVEk9xmB36vxlC6Tnb+PS13wtVvgCHlTWnGhdTfA2agt8FwhhJe
 wPyjwQ12bDw==
X-Google-Smtp-Source: AGHT+IGfB1sF15Zv9DYD4J75P19rWeN113Qgtk9lwPRE38BcVnfwTebj9jRA4nSKzBHuZTocEUiAnA==
X-Received: by 2002:a05:6a20:9f4e:b0:1fd:f4df:9a89 with SMTP id
 adf61e73a8af0-20444f0e60emr1002446637.25.1745456401851; 
 Wed, 23 Apr 2025 18:00:01 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f45c7sm129259a12.16.2025.04.23.18.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:00:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 120/148] meson: add common hw files
Date: Wed, 23 Apr 2025 17:49:05 -0700
Message-ID: <20250424004934.598783-121-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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


