Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65830C282EC
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 15:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpqro-0001FK-Un; Wed, 05 Mar 2025 10:41:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqrg-0000wH-Kn
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:40:58 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqre-0002dd-M6
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:40:56 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38dcac27bcbso689623f8f.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 07:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741189253; x=1741794053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SAe89AKUiv2OCh4O9g61YeTeEn2jUwLCWPqWxHhFQsc=;
 b=uOrrI5kECw3Wm8T2q5n91gWwkzWdyDjyhQNLEp9ewsm7O+/k4lkmq71+5O2W/gtAsi
 tyY8EQBQo/LJ/bJJ/YCc7cbldn4ED/2wX05dFYQI2Cf9WYVmbX3beowP2JUs2xfvXMBs
 nIcDksmkdofqNvLL12wyeRbxlNkjPbZkaRbHgtFNBs1xVouET4hjtr1DY2B2vA+xFPM4
 6UbJYXvKJc04o4YRbbA4lsp+cLfS1sGfJABulUuGC/H+p7ubvjQwwxSHHzt0mfUn7eOQ
 tTv44ZkjGa5xFGN6yVMooWMkx/dAafDlPrCESMsctL9Gr/h3XAPQbVj4l3npAKD4fgZS
 oreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741189253; x=1741794053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SAe89AKUiv2OCh4O9g61YeTeEn2jUwLCWPqWxHhFQsc=;
 b=SgBlc4KiIR+28ugJrIY5U4K9Hd6by5H9ImraeAgAmZE57d1TN462GKWbBRtgWgpWIl
 aRelrSzEgh3ge9rfA2aWpazkSPQDHfpmwf5gcH8U01EOtJ7g0q07TxjmYF+2QYK3007A
 FnnfJltykTCPseGN1Ve7gq6ONO/2oExZ1xhWaFeOlgsrE1wKYllN+xqpJ+EKFf2e5/C1
 H6Z2N+iBdKMiwMrUbJIEixbKRdO7YaXEofeJxIUIX01LYNIyLcSeCCBrCA/NttcXdg8q
 uONB5ZaM8PaFN5Il9KSQ5uQMlJBUgbSZUpV36H25vM9cdMAWKgVqMNyA0Zv6BXkeKYnu
 zDBg==
X-Gm-Message-State: AOJu0YzW8zhnyMepl2t3pK5tsOXcI9w8c28e+/VemktzgyNRc0HPJHkI
 Qr6b9mosB9nCJRJvdJeMH6fVpFKa9nXpmMbpoFQLd+7R41aWC45k+8e4yv9DGYuvz+wXi0zKtSh
 z+0Y=
X-Gm-Gg: ASbGncsKEpoP+Gsq8GOYgaRE7V3Y6DbHZ1oiuwW+9e+VYNPKeqy7ZTWcipiROBnq3HR
 kPQz7vk4dY9mjdgxVclf9mdY+NkJlZ15gzmq8+mAeePxh1WXtja1ETNPOFEA1J/uQ4RZ3wFPhAF
 zfjYouwOxcOqf/AlGJuUuqd//3e4VEmBghYDXkBhQGPvcmxtTooip8xrIxCKHi0pftVQN7d2iiY
 R0pK6ZcLLHa/q/9j6c7InuyXH5WVaVROybamcd9hOqnzNKqaaPVLzOSd/PV81xcM4s5oQZMf4JQ
 nm7V7W3BAwpZIhuq8ldTd8wXNGM2TbM0XWcCck64Dwx59lRPpBeViGFUNPIthRfI6WlHgYecHXX
 3zNe26RMVnN3S+aB0N9g=
X-Google-Smtp-Source: AGHT+IEet80YioCTjWFChTMU6lbXTUrHxMelJ8el/dbnq/WucmOnc+XsebDWnxUyLyntDPDPTY+U6w==
X-Received: by 2002:a5d:6c62:0:b0:390:e9ee:f27a with SMTP id
 ffacd0b85a97d-3911ea54ab8mr2711232f8f.28.1741189252778; 
 Wed, 05 Mar 2025 07:40:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a7473sm21707201f8f.38.2025.03.05.07.40.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Mar 2025 07:40:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 17/18] meson: Allow symlinking system emulation binaries
Date: Wed,  5 Mar 2025 16:39:27 +0100
Message-ID: <20250305153929.43687-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305153929.43687-1-philmd@linaro.org>
References: <20250305153929.43687-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

The 'legacy binary' API allows checking target specific
features at runtime by comparing the argv[0] binary name.

Add few lines to easily symlink indentical targets (see
next commit).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
This is ugly meson, but the point is to show a prototype.

One problem is we can not run 'make check-$suite-$target'
anymore :(
---
 meson.build | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/meson.build b/meson.build
index e4ede6ba06f..c2b7ec57739 100644
--- a/meson.build
+++ b/meson.build
@@ -3251,6 +3251,9 @@ host_kconfig = \
 
 ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_ARCH' ]
 
+aliased_targets = []
+aliased_target = {}
+
 default_targets = 'CONFIG_DEFAULT_TARGETS' in config_host
 actual_target_dirs = []
 fdt_required = []
@@ -3273,6 +3276,9 @@ foreach target : target_dirs
     endif
     config_target += { 'CONFIG_BSD_USER': 'y' }
   elif target.endswith('softmmu')
+    if config_target['TARGET_NAME'] in aliased_targets
+      continue
+    endif
     config_target += { 'CONFIG_SYSTEM_ONLY': 'y' }
     config_target += { 'CONFIG_SOFTMMU': 'y' }
   endif
@@ -4307,6 +4313,16 @@ foreach target : target_dirs
                link_args: link_args,
                win_subsystem: exe['win_subsystem'])
 
+    if target_name in aliased_target
+      exe_alias = 'qemu-system-' + aliased_target[target_name]
+      emulators += {exe_alias : custom_target(exe_alias,
+                                              input: [emulator],
+                                              output: exe_alias,
+                                              command: ['ln', '-f', '@INPUT@', '@OUTPUT@'],
+                                              install : true,
+                                              install_dir : get_option('bindir'))}
+    endif
+
     if host_os == 'darwin'
       icon = 'pc-bios/qemu.rsrc'
       build_input = [emulator, files(icon)]
-- 
2.47.1


