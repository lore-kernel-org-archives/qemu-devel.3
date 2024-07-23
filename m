Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB5CC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 08:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWBMX-0006AJ-SL; Tue, 23 Jul 2024 04:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWBMV-00069c-Hb
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:59:12 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWBMR-0007to-Tx
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:59:10 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4279c924ca7so38215835e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 01:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721725145; x=1722329945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DKprz6Otg/hA/vCqqYOw7BbZN7ncWT8hNx6EMDpSDTk=;
 b=FuyO6kqyOLu/fznHqxpzXOqnyLZKjZde267miHEuOyNqx6WYsxLcrJJCjxqqnsAHo8
 CYRzyDIfg3cmhZLLV1AGVEg4cOIKBhrjj0117JSjsmxayMp5sb93dcT7z9TUp38gCmqn
 IUGCtASvkruESpbm5sdHJqvK8bBMMZkkNm5FRyoL2jVC41VrMxev/Mofgm/PZLHEpq0d
 cIbRBybgZ6HNYuK7pD7kS8ldnxdIg2G5EMYXJXYvSPxm2tBypmwOhvGuTRUiQhX6aVMd
 /PpN1FbFgq2sz4qhXqj75zbgHG2CGg3fdOcn/dISba240rcBaPhPeWts9T6/h9cqjV3L
 Nhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721725145; x=1722329945;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DKprz6Otg/hA/vCqqYOw7BbZN7ncWT8hNx6EMDpSDTk=;
 b=fvyYVNuWWKnUid1vPWV6XIUlM/3WHUHuBwbvqexX84+GCXB06BF6ZxLY7YioS4pe95
 vOvrU7q/T4ST88O5pQAsGa7KmJF9K3nlQCm6Cv2MUsH/znbwdC+W7Un+ZewF+6QOgS/v
 vH/RTA7ydRwGyfnwcoTJRVVVO4g6PEe78nD+Ofsz1kFZf30sh+rqzK7SIvWnZXIVLAv7
 r7hW+L5KHM4l4QJ75lAApHIL35KBBHlDpGox08MsP/42Zyeu3adJumKLSE1a6QLlboiE
 poLHo21tDFpBBV3dNYf64W7gz2n07OgjNinuw95R+Kw6Ybx7WTQFXfQYU0iU3SVtBC6z
 DovA==
X-Gm-Message-State: AOJu0YzcSLC4WSrx3/7kop4MNIMJbCN2amecalrjp37GQaXpCGFCJt6i
 zVeumzUxJRB1ieRsoXV1JvfwTuYGSc5G5TH2UCxQPcGGtay1zlfoXGMyFaS1ahUFZJzQixv8TwS
 yJa4=
X-Google-Smtp-Source: AGHT+IHuX/osNQb2Oc61q6w3Vssqp7LY2c+GZJRwqL07az8cY+wfOgNbEjWzfBnopv0N28zcTDCT8Q==
X-Received: by 2002:a5d:58d6:0:b0:368:6336:6051 with SMTP id
 ffacd0b85a97d-369bae4e0b1mr5296850f8f.22.1721725144628; 
 Tue, 23 Jul 2024 01:59:04 -0700 (PDT)
Received: from localhost.localdomain ([178.239.250.121])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684230sm10846581f8f.17.2024.07.23.01.59.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 01:59:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <roman@roolebo.dev>,
 Francesco Cagnin <fcagnin@quarkslab.com>
Subject: [RFC PATCH] macos: Allow coredump generation
Date: Tue, 23 Jul 2024 10:59:02 +0200
Message-ID: <20240723085902.98572-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

QEMU is allowed to generate coredump on other POSIX OSes,
bring that functionality to macOS. Admin users still need
to enable the kern.coredump sysctl manually running:

  % sudo sysctl kern.coredump=1

the normal users have to enable their shell running:

  % ulimit -c unlimited

Reference used:
https://nasa.github.io/trick/howto_guides/How-to-dump-core-file-on-MacOS.html

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Cc: Alexander Graf <agraf@csgraf.de>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: Roman Bolshakov <roman@roolebo.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Francesco Cagnin <fcagnin@quarkslab.com>
---
 MAINTAINERS                  | 2 ++
 meson.build                  | 6 ++++--
 accel/hvf/entitlements.plist | 2 ++
 accel/tcg/entitlements.plist | 8 ++++++++
 4 files changed, 16 insertions(+), 2 deletions(-)
 create mode 100644 accel/tcg/entitlements.plist

diff --git a/MAINTAINERS b/MAINTAINERS
index d5ff6c2498e..c6f57d77b19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -611,6 +611,8 @@ M: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Odd Fixes
 F: .gitlab-ci.d/cirrus/macos-*
 F: */*.m
+F: accel/tcg/entitlements.plist
+F: accel/hvf/entitlements.plist
 F: scripts/entitlement.sh
 
 Alpha Machines
diff --git a/meson.build b/meson.build
index a1e51277b09..aae35e93420 100644
--- a/meson.build
+++ b/meson.build
@@ -3983,9 +3983,11 @@ foreach target : target_dirs
       ]
       if 'CONFIG_HVF' in config_target
         entitlements = 'accel/hvf/entitlements.plist'
-        build_input += files(entitlements)
-        install_input += meson.current_source_dir() / entitlements
+      else
+        entitlements = 'accel/tcg/entitlements.plist'
       endif
+      build_input += files(entitlements)
+      install_input += meson.current_source_dir() / entitlements
 
       emulators += {exe['name'] : custom_target(exe['name'],
                    input: build_input,
diff --git a/accel/hvf/entitlements.plist b/accel/hvf/entitlements.plist
index 154f3308ef2..af4bb45dbea 100644
--- a/accel/hvf/entitlements.plist
+++ b/accel/hvf/entitlements.plist
@@ -4,5 +4,7 @@
 <dict>
     <key>com.apple.security.hypervisor</key>
     <true/>
+    <key>com.apple.security.get-task-allow</key>
+    <true/>
 </dict>
 </plist>
diff --git a/accel/tcg/entitlements.plist b/accel/tcg/entitlements.plist
new file mode 100644
index 00000000000..9acd12816c9
--- /dev/null
+++ b/accel/tcg/entitlements.plist
@@ -0,0 +1,8 @@
+<?xml version="1.0" encoding="UTF-8"?>
+<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
+<plist version="1.0">
+<dict>
+    <key>com.apple.security.get-task-allow</key>
+    <true/>
+</dict>
+</plist>
-- 
2.41.0


