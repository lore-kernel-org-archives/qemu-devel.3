Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F6BC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u84xP-0004go-VX; Thu, 24 Apr 2025 18:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84xN-0004Z9-5Z
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:22:09 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84xJ-0000zY-7u
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:22:07 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so10904015e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745533324; x=1746138124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T65qmhybJvXmiPIFqF2URs+hqaxECmWRo0st/T0e0I0=;
 b=pOsfZTpeeRAmbqlj1KJPWXyz1+6VP2sZiM8PHDLuN3Vjhn9XevvF/dNf8YIUN/d5Ya
 vpI8kSZR/D3a+bpgHECnMgCZbGj+3bNF3G17leFTk1sJ8+qqruewIuEeAFa1EjjQ6bH3
 mIF4BGvxZoEFpN5tQ5Waz+GJhlGPzEzFphZZ9ShMyIbc4a0pZY2r3MfzfTOpkOTF40wK
 z/7KPYsG/t2bx4UGo2STtBztq7W+LbtymwzZNTuSl8mwkHSeyg7MIYT+9hxs+rAhZnaU
 rz4ODngOQOSXvXWk//Pn7qGXvoyyK4+st+9NseAiKsD/7zVL/17eu7KobVWJlyDdC4Yf
 AZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745533324; x=1746138124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T65qmhybJvXmiPIFqF2URs+hqaxECmWRo0st/T0e0I0=;
 b=b5u17PSvqpFjNPS39bK7qBQFjfXiJJvwpT9m9LQN7frnBhAUg4Dye2SKBOTLRxxuct
 hkeWi8kZCUjgl0ltCfTqORX6ZZA+NNpv+9jW0DPsoopMQQhCinfIcPuF2T+HQiCeVGRH
 jSA7IVR71kDuI8QHmuw3wnej+2VKN24zmY0RqG4qePlfuV176PI4WBg+SHBMx6YWT0+J
 8pij4K4GN2A5U9vhh59G0gu+kdDPUDZwVN4B2zNW3H8oJqB0R05oaRxQ9hpIMEFxoxUV
 7FAVW8ohpds8PmLvb3F505gvrf+M3uXW8hlPbOJapxNE0bkDrdbsBRTaEsD+5/fJTLKS
 SoHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtYXK+tgYukqQq1oOaNFZAqdrMFBk8WHSXvLYg78LuClr7i7zLanHGnLcFbRy+CHOHyLs9jBQsiNwl@nongnu.org
X-Gm-Message-State: AOJu0YxDOKANXdO+CdyYs1sZhjoG8Ge+5og7d95jmF/B7hwcUIs4uA1e
 /yfu2p7A9xzzp/6ARCOpXaKyI83DeRkJG5VaU5/GFM3vePJgfc8vJQEtaAtbXK8=
X-Gm-Gg: ASbGncvG/si81wwmif81a4z5FSbzZ/SuAEM9hJ8sFKR9V3rOVGe0UjLhY3MdlFuYVKK
 muVkisN2OtHiwWo+V6uCYBqiu/I0s3ieWDm1RTXqBYKF+KzDXAZ6TEB2MJW4yuBtKYp9ctsJlY5
 yY5X+kTWawL0Fs1YB7ftFH8kfnL9k9fAOrDMwf8enkAPFKV2kvar1ywh6UQM6rgOQZQazgsSU/m
 HYsH+oKUrXF80zAK82oFuisQo3wiRu52VgIrhp6fh6O92wPGALlBCM65U8xd1OXZgNFi//+ob69
 PVlhwHbprvJnSwmpNR2cDDoNGxucv7mqOKhVi8qR4khF4Q61Y9uqLkdvkHvQ8uUStVQAWUaVVT4
 7px4y0UPmBfLF7Lg=
X-Google-Smtp-Source: AGHT+IHXr/S6dzCMhd6VVJ6xSmJeF4ZT/ic9hACDrPwj4sFgE9FCnVe+262TYxdZXyXkswFfW6gt/A==
X-Received: by 2002:a05:6000:2905:b0:39e:cbd2:9211 with SMTP id
 ffacd0b85a97d-3a072bbbac8mr627441f8f.55.1745533323722; 
 Thu, 24 Apr 2025 15:22:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2ad112sm34996335e9.24.2025.04.24.15.22.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 15:22:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v5 10/21] meson: Prepare to accept per-binary TargetInfo
 structure implementation
Date: Fri, 25 Apr 2025 00:21:01 +0200
Message-ID: <20250424222112.36194-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424222112.36194-1-philmd@linaro.org>
References: <20250424222112.36194-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

If a file defining the binary TargetInfo structure is available,
link with it. Otherwise keep using the stub.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS                 | 1 +
 meson.build                 | 9 ++++++++-
 configs/targets/meson.build | 4 ++++
 3 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 configs/targets/meson.build

diff --git a/MAINTAINERS b/MAINTAINERS
index 451e2778888..63cf1e6ed5b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1932,6 +1932,7 @@ M: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Supported
 F: include/qemu/target-info*.h
 F: target-info*.c
+F: configs/targets/*.c
 
 Xtensa Machines
 ---------------
diff --git a/meson.build b/meson.build
index 32e6aeb295d..70ee7e838ed 100644
--- a/meson.build
+++ b/meson.build
@@ -3204,6 +3204,7 @@ config_devices_mak_list = []
 config_devices_h = {}
 config_target_h = {}
 config_target_mak = {}
+config_target_info = {}
 
 disassemblers = {
   'alpha' : ['CONFIG_ALPHA_DIS'],
@@ -3797,9 +3798,9 @@ specific_ss.add(files('page-target.c', 'page-vary-target.c'))
 
 common_ss.add(files('target-info.c'))
 system_ss.add(files('target-info-qom.c'))
-specific_ss.add(files('target-info-stub.c'))
 
 subdir('backends')
+subdir('configs/targets')
 subdir('disas')
 subdir('migration')
 subdir('monitor')
@@ -4260,6 +4261,12 @@ foreach target : target_dirs
     arch_srcs += gdbstub_xml
   endif
 
+  if target in config_target_info
+    arch_srcs += config_target_info[target]
+  else
+    arch_srcs += files('target-info-stub.c')
+  endif
+
   t = target_arch[target_base_arch].apply(config_target, strict: false)
   arch_srcs += t.sources()
   arch_deps += t.dependencies()
diff --git a/configs/targets/meson.build b/configs/targets/meson.build
new file mode 100644
index 00000000000..a9f6b24ec01
--- /dev/null
+++ b/configs/targets/meson.build
@@ -0,0 +1,4 @@
+foreach target : [
+  ]
+  config_target_info += {target : files(target + '.c')}
+endforeach
-- 
2.47.1


