Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7614FC3ABC0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC56v-0006Bg-KF; Mon, 05 May 2025 19:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC56r-00067l-FW
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:29 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC56o-0003Up-4u
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:29 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso45716745ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487224; x=1747092024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oMNeg3Y4FuUndpYOZQCJwSPCGo/Nsl7SC/sGcqIL57A=;
 b=nPxqq+FaLGh9bTUB9lu7gYlyU1XF9ZKeayU8n3qV2OvgzmDhkgQaQJn4H/osNC8ryi
 Q+eBYbbxhAYN1BcZJSgDgPMMq8lfEs7/FguxjaA8ygzL02DvaExbyrEJ22ROOUjBd4Nx
 rfQ0vfMTA101tfzOyFIBPo/k7JZL6L4ouxvnxlcOMIFJNK5y2+nxWq2xUJ+tozBVW+Dx
 3Vq8GoHlyRekOZ6PCVYZrDBJbTqbIsSU1rPLJXJuIxYeOWdInfUPFhd084xffKijnNhA
 9FJ1i5RKcVaCbM5NeX8rxuaazKqAllaL7JLP9NvcAySrVtFN9tlxeiYblpxHK/F8YjI9
 KY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487224; x=1747092024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oMNeg3Y4FuUndpYOZQCJwSPCGo/Nsl7SC/sGcqIL57A=;
 b=DgCTrnQu14Ii+6wkQw7mnxjvOZAP67AHrLyqvcMnd72gUf166IRklkpy9aVjYWc/e4
 xA5e0cyDl5e1IVBRHlLyjk1m4p245yUsHT/TKExmZCbglqD47KmP92AW7qX70D+sFXOV
 1YSH3jnigRmuM5lU1wReaQwtH6nPR+Or/VYEBLStpu7HBJ7ISDoIPmG3J+J1O2/DB11k
 H/sVxa3Rqx83/9mQSR19DpCNUZFm7kZUp6Dz8WtRybqYqphvnXF6xj6mfkUlNQ6J5X+k
 VGwrZHr4DQnQzvV2zwFRnQLJHaKrqKLFNuP+dS0ElwKCwXYCoJX9mtdynjb8p2vjFpfx
 66GA==
X-Gm-Message-State: AOJu0YwEGUfrALxBXzIE/ZBkgtgOO9jqSS1QNKQc/cXeYWYeKdzJN9VF
 ftGh+NNg4XJ/O2MJaN8Hey1SN6ZuuDLERgYEGsdM+0LjncGl2n+XSEuFcbBKXYRzIIkpvEZV5Nv
 /uYE=
X-Gm-Gg: ASbGnctl0T5w3JoxTg5cs2hokZrTyoY3L1xssR7KzMIPIb1KZH1IWheOh4KqzgWzl0D
 coOCqYyayStqVult5zvKc5ovCOubw/K2UnX+BLlx0JmXP8qx1qrp9Ai0y1EdNv8eXUXXv95wrq+
 poPjCbmFjWSh8d4sVIy3nUUv5jSu+sIuviXzNqXrX31gv32pTCUcIPtvckrXQjbpESSKYjcFOBh
 OGM7uNR9Ys2F4zW/iugziPd9GkbKSbYrfgSM4sX19CkTWZI8ZrquczRP848kbpyPIXIIsZFB3U5
 90ZD/e02eLsl4NtZtANaKGfe/kmxZG2CgqRK1X13
X-Google-Smtp-Source: AGHT+IHoFN+rr8Lwq19Sx2mB1Yb2Gf6GH5Yb4OTaXFvREpHxBgl5rUjVxpoL1Lsyqn6N2c59nXy8cg==
X-Received: by 2002:a17:902:daca:b0:224:3d:2ffd with SMTP id
 d9443c01a7336-22e3285f134mr16144225ad.17.1746487224186; 
 Mon, 05 May 2025 16:20:24 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 04/50] meson: apply target config for picking files from
 libsystem and libuser
Date: Mon,  5 May 2025 16:19:29 -0700
Message-ID: <20250505232015.130990-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

semihosting code needs to be included only if CONFIG_SEMIHOSTING is set.
However, this is a target configuration, so we need to apply it to the
libsystem libuser source sets.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/meson.build b/meson.build
index b2c79a7a928..1b365dcae17 100644
--- a/meson.build
+++ b/meson.build
@@ -4049,27 +4049,19 @@ common_ss.add(qom, qemuutil)
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
@@ -4308,6 +4300,16 @@ foreach target : target_dirs
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


