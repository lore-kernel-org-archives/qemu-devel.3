Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44844C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 22:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvOSO-0006mm-HR; Thu, 20 Mar 2025 18:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPz-0002kq-HZ
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:31:21 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPQ-0007C1-MP
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:31:13 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2260c91576aso24280405ad.3
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 15:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742509835; x=1743114635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fni5tdTWafvZot1y+akur3pFHYiAMm3JM0mRyhC4D90=;
 b=dRVsf7HzVvSlesHK5fqkieqtxatfG+18XTNCuTX6x5RZ6nDPWQCRwWZOgkojQkz/Ks
 hV3juquDAgvar1bm3m3FSs/PTt7oEGwa2kHAIRmHNgpQFBYJ+nzEFp6BkP421tZI95BN
 1lcy/RWwV8bzqdiJOlrmQV6uR0YDw4W4s4VCMzY5XNS/8yBJhVOQDKtw2RjJqyx1U/I0
 4IHb3ycWQVLnIubRNiADy92p5/jf7XRRw8JM4Hv2v4CFzoaJqsISWIAsZzTtWm0HzCev
 bHpPYotkGu7LdxoFPNk0jnEupaZ+3T7HXKI0WlnCz3zRKLVP9jdCPbTpo7AfJGeC5cTV
 qylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742509835; x=1743114635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fni5tdTWafvZot1y+akur3pFHYiAMm3JM0mRyhC4D90=;
 b=X0xzLpMpKTOxF3RUo93WBN86rbFZAeifKItFfir8b3Nkl+S/tCU+prtrT8xVXWr9mW
 0IY9/nqSoKDsFq/ay6MnoAhL2xRYlwIjnizCndo+RNWlL59l6c+vph5ISpfWSxkS6+8y
 V1LKIJAAhSpLMyXtBubGeNe8vNudKHhx4GqYS0bbsTRvHIKgtmBExhhXTcSJWJ6EX/6h
 t9fqzJyezt/OmO2iO35SxuAKVCOnifXmmG23MXjRYtcs7EW/9RA3lzR42fxqkqBy27UG
 twvQJbh0DklAT8Fbeei9u0kwcotc4jy6TuQl5wBJ07I18JNUqedVoxqkOB8vJU32kAlE
 vkNQ==
X-Gm-Message-State: AOJu0YzuP8OqwM1zQhxHcBROe+4Y2YEPuH2ctLa+m3bBdfMGUmmGDJP1
 k7pW5R70VZaDtVKqikrCrjB5NxaUQ/6yv/YH/mpC/3tcRQyllGHgSR2e7oDvEEnlyhCYwWDUuUM
 e
X-Gm-Gg: ASbGncvm4xt5EyBOCD6WmyB1WtBQqjt0zHtsfV1jxxKNEPJ61zIRBuN2h0YbHcycbgq
 GUbdyB97PReHubAyeGdnVqy85gf0vnRDkblK4Qki/VdmudpRjdkKX/iJka06idqoQTVwcmw2+GF
 4J7hZuCA2my8pQLB9MxCZS82gJVlIsj9R0eiRY7ePQsQLocvRG8/Z38PwMJGArPdIKlLncGS2xq
 da+H2EFsZTavw6Dg8sZTMV+v3qKv2NI+plFeJrcP7YWDIz6M47C0uA6pLyLP2rUI+MhQyxSAOjN
 Ga32Mc2I8EDuEjnCwAQYlNGz3jCQkD3YKM27URaXagiz
X-Google-Smtp-Source: AGHT+IEDnR46Jwg3e0H5vN3WKKFSDOwpObSW/kBf7o+0T2zwRq7UNU9x9J0cLoc6huCy1CQ8GPGUhQ==
X-Received: by 2002:a17:902:ccc2:b0:224:a79:5fe4 with SMTP id
 d9443c01a7336-22780c54d58mr15290515ad.2.1742509835392; 
 Thu, 20 Mar 2025 15:30:35 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4581csm3370145ad.59.2025.03.20.15.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 15:30:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 24/30] meson: add common hw files
Date: Thu, 20 Mar 2025 15:29:56 -0700
Message-Id: <20250320223002.2915728-25-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


