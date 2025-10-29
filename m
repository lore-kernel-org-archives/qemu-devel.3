Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3CFCCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 21:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEDzP-000087-1V; Wed, 29 Oct 2025 17:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEDz7-0008R0-AZ
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:45:40 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEDys-0006Fu-5x
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:45:35 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4711b95226dso4287805e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 14:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761774312; x=1762379112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KyYtKOwHSiL8zG4F6RP7X5U6pXWzdyE6rU1IyLJB564=;
 b=EBLl8U0AWwrMQsgQ8hhARODVV7DFfO9YnYCVmSHZG4cxBI7lRWIjtdZ4ZVqnHIlbos
 phZgY+phFe3eEGXnWFSZam5U21ZeVplpGJzGj4h63mXgPIrWmwhCeBsXPwjKp2d0oO7i
 Qtbq30OwIWgdvX2HCXOtU7Yv6uB3d5vHvM4+eS6rJ9+kaTJYhGImbeM9qEO6O/aANtzF
 +nDjYHu+RTJL8VWlE83OvK0q3/OeCqKX8ST3wNJUlPtk0vyEi915eu//vMfzjcWg+fdw
 BVQg6PZz4Xgvx1KykXMx+8i2+qLclQvIjA0l35ztUU+Cwh1S5eqH9DIhQ8+EO/epe5bw
 FTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761774312; x=1762379112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KyYtKOwHSiL8zG4F6RP7X5U6pXWzdyE6rU1IyLJB564=;
 b=bzsMCNLILTEj9u0oc0UL4jMh2HFLqdtuGOfZ2nMbSqczUX6BRLsBKCrsl1a9kdWxGU
 eqsUYA/yVEGif5tCSI/l5u3HlDDIscMcf9E4evmZf2OASOlW4rebsxJoN6PNVhcn6ozt
 IuEfQO8ox1b6Je1Tta7H8K5xixuyUB8ovIZ9jXp+M97d2axgpSmN5cnRb7lQt2hrFKcA
 58cNZ7mTRtBeCFbyh9IHhyQeY1fZpK76jaifjSYgJoravnukbYoifnQDGiyiKX3oyRDR
 uqTVZ9ghikJUQ5LjFgF6gwIIuO15zaOLGONmjHGRzMrCZtgFE75r2u0gA+7CK7CCSiGb
 PQqA==
X-Gm-Message-State: AOJu0Yw6YJ0/feqoagDBKWlbfdvi0/DA8lSY4DaHGT9nvf9N8qI/w66g
 h/1oHw3ks5MGRv8f25BYBujdxi/z56igyw2c5yDRngFDIvgi6/E14rFW6HhF6/94XpzDG/SIrjH
 k95l+EZ4=
X-Gm-Gg: ASbGnctP9rytkvFl1iEhMwcCPCbRIZIlrE5uO50eKnHFSSV1+ZuhIRmXZA2Z9i2TzW+
 J8cflXyN6B6uXni3y7MOWt0BHh/eIT9BxXmdz+ccQOfcnbCL2gG3DkKLV42GwRizROhIjPY0dm2
 6jW7WHU2ygmo0MuHVc7QNxSUHdHJ/Z6Jvelb0GM3qHKkE7ou4YQmlRAKJODXIBLpb3ClyvwI5yq
 kba3SDNrBMleFSdUZdsFdXkX/oRUf2flV3AVC5r5EatZeAtO0k4RrBQ6xB6xy/2qbuoFS+1JiuC
 ouDXQwGghpyX26wHYZKdZuve97RVNSLcaae+BiJppuKUW4GB8xD3BalNpQuSsMbz9+KMihOnUo1
 RZeTjaSJfgHEMs2LcaQeedjC/HNja3/5t8Rredpy9uoPyWVeg074TmvMp593hs6B6URFJsXTC4v
 wwTxpOnYnI59Tr7b8q4HF62gmsRNes3usMbBrilGxiF9Q/3iWkyg==
X-Google-Smtp-Source: AGHT+IEAOZ5VfCCKWi0odXrscMhJ4+9p3lgqTEO9tjC7BoKxs5E3q0lBlme4LomOfKdGsZEe2fDT7Q==
X-Received: by 2002:a05:600c:4709:b0:46e:3f75:da49 with SMTP id
 5b1f17b1804b1-4771e406a5bmr41437155e9.37.1761774312043; 
 Wed, 29 Oct 2025 14:45:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477184251c4sm55622275e9.1.2025.10.29.14.45.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 14:45:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PULL 05/23] meson: Prepare to accept per-binary TargetInfo structure
 implementation
Date: Wed, 29 Oct 2025 22:39:42 +0100
Message-ID: <20251029214001.99824-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029214001.99824-1-philmd@linaro.org>
References: <20251029214001.99824-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20251021205741.57109-6-philmd@linaro.org>
---
 MAINTAINERS                 | 1 +
 meson.build                 | 9 ++++++++-
 configs/targets/meson.build | 4 ++++
 3 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 configs/targets/meson.build

diff --git a/MAINTAINERS b/MAINTAINERS
index 64491c800c2..c7faa5672a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2007,6 +2007,7 @@ M: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Supported
 F: include/qemu/target-info*.h
 F: target-info*.c
+F: configs/targets/*.c
 
 Xtensa Machines
 ---------------
diff --git a/meson.build b/meson.build
index de95da32699..df876c72f06 100644
--- a/meson.build
+++ b/meson.build
@@ -3312,6 +3312,7 @@ config_devices_h = {}
 config_target_h = {}
 config_target_mak = {}
 config_base_arch_mak = {}
+config_target_info = {}
 
 disassemblers = {
   'alpha' : ['CONFIG_ALPHA_DIS'],
@@ -3912,9 +3913,9 @@ specific_ss.add(files('page-vary-target.c'))
 
 common_ss.add(files('target-info.c'))
 system_ss.add(files('target-info-qom.c'))
-specific_ss.add(files('target-info-stub.c'))
 
 subdir('backends')
+subdir('configs/targets')
 subdir('disas')
 subdir('migration')
 subdir('monitor')
@@ -4365,6 +4366,12 @@ foreach target : target_dirs
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
2.51.0


