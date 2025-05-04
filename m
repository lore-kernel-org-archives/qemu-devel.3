Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CA1C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRv0-00026X-D2; Sun, 04 May 2025 01:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRup-0001ym-PM
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:27 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRun-0004Gu-Lz
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:27 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-73712952e1cso3370828b3a.1
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336564; x=1746941364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hPUzfDhhl74FQ921XpGJdIiei13N9+1r4RBflBlQkuA=;
 b=FyKpp8xVXiQC1nlo02tDrw1l3MpZFHk733FsAABH0YISQMx7E4aZ9PwR6fxJubNj+r
 qH/+bL5iZZ/z5WU5UmEdKLrxvkdgh/GUxsubl4Ksl6jazjJxE2rsnO3hZpXTr2sgqxvS
 UYdoWUgLTFbwdfRCG6kRAKbVvOJrH1AKWSSnpYkLd3w2uSZ4zFQ0ZZFajwHMfRFSBNsu
 oQkv58wm7+bAD3FohY5NLDf7r2pWHm/7ZA3RJC537Mri6S+FGgEIschIVN6Hr1rXh5iH
 XqtLrE1kVhJOxxf/nEBL/vUu+9K40xL2ymGi022KH8n85RX/anILS36BlU1X6LZXm02Y
 fL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336564; x=1746941364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hPUzfDhhl74FQ921XpGJdIiei13N9+1r4RBflBlQkuA=;
 b=QqCOy1OPEE4+rvTtqBJ3n4oAY0x44Tr2t5Pc+UX7MHrvkax+8hx518B58iy3MZrcOo
 Q7Aijawg21TQZbEsKJebJ/HXvIRzUw21pxfGGOsJ9nbvcqRSnytlHsJZ5tCss/O+NjSG
 iPSQyV6g8t94JNWYLAWFrp958cpeHLV3GwmuHQKGeGTwzUh/FrHpWvIgOGB79vmAVsXE
 46Qa6SzdDszfASpR87UCrLHBNnVMzj7gxfCIuz6A5wy+3nF1Y2oBOuTshMpZzXgZYlLa
 eWVjNobTkfVkHxOJ/CVVQ0wNDqrMztZcxT+oea+8S6IKke0+UH+0j7nlb8AWWOnZGOSk
 1xag==
X-Gm-Message-State: AOJu0Yxm0KW66s+6WDx/wD1YkavEEczX99u0VyBA03z8Hr8DguLHAxXg
 Jh4HekL1L6MLy98tv8qJTcV+rXY4CbvuCMAsobEG7plNzseWGQ7S64xr64bQzbijpSuDhjeT8K2
 q0EM=
X-Gm-Gg: ASbGncuKPYmD8KZX5ENzfQpUIBcq/EAVNTdVOcBhpCJ7hzSJ9SDIb2ggHzkePaUsuLN
 JJJiAkkv69FTaSirYlkZdetiPd3HdKGhnG4bGFDBG33Qyzcwf2sZQIbrYq/0fmQmHKsfalzjUTR
 0+fh1wJPFSRT6hmFPlz0K7y0I+XdpGDMOgK5BBNmGwRiEWkt+Nzf1HjtUFGL1spiX9S77CEByW4
 WGF2d4vSDCOSLTGsk7lwFFoVTLB3GcTwv5HhSlGHWZZy1QDbXqiZEJAz4/MSDuqX9xWsRFMv/HO
 aRRrwt3TCFJtynodInynXkRSP7QyS719ScZ2Rhi5
X-Google-Smtp-Source: AGHT+IF6fi7TCVQkX+/SReePQP66TObCTTPRskSVKzeExfBKNEWQDe0rnw6/GqhpugwJflD0L6wMsg==
X-Received: by 2002:a05:6a00:ac0b:b0:736:50d1:fc84 with SMTP id
 d2e1a72fcca58-7406f1a4357mr4097937b3a.21.1746336564105; 
 Sat, 03 May 2025 22:29:24 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 04/40] meson: apply target config for picking files from
 libsystem and libuser
Date: Sat,  3 May 2025 22:28:38 -0700
Message-ID: <20250504052914.3525365-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

semihosting code needs to be included only if CONFIG_SEMIHOSTING is set.
However, this is a target configuration, so we need to apply it to the
libsystem libuser source sets.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/meson.build b/meson.build
index 6f4129826af..59c520de359 100644
--- a/meson.build
+++ b/meson.build
@@ -4056,27 +4056,19 @@ common_ss.add(qom, qemuutil)
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
@@ -4315,6 +4307,16 @@ foreach target : target_dirs
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


