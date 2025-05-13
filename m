Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487D8C3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 11:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEoFg-0003nn-R0; Tue, 13 May 2025 07:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uEoFe-0003nY-Pf
 for qemu-devel@nongnu.org; Tue, 13 May 2025 07:56:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uEoFc-00038v-QY
 for qemu-devel@nongnu.org; Tue, 13 May 2025 07:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747137407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=N1iB5gvmLzqgimGLRjWOz8X1HYfCPTyJ1LadMmLJHh8=;
 b=EbQzpIASehPM9lzMevjC+FdhJMI9k3xcXA/afjLREUnBb8HDt7m+x4fTTPL3/wsq355Td8
 TY8QgLnnSKExYXPkmOyux5ItIFZJs7aUEeiF1Mb9flYYJATbwcaNhWVkQ32HAw3RCXgARr
 KDLXrbDYIW6DvQ1WbGmkfwV8dZc+d38=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-s0X6PC2vObGEfUJXOzx54Q-1; Tue,
 13 May 2025 07:56:46 -0400
X-MC-Unique: s0X6PC2vObGEfUJXOzx54Q-1
X-Mimecast-MFC-AGG-ID: s0X6PC2vObGEfUJXOzx54Q_1747137404
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9FC361955D82; Tue, 13 May 2025 11:56:44 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.62])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A572E1953B82; Tue, 13 May 2025 11:56:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Brad Smith <brad@comstyle.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2] meson.build: Compile hw_common_arch_libs files with right
 header include paths
Date: Tue, 13 May 2025 13:56:37 +0200
Message-ID: <20250513115637.184940-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

Since commit 6f4e8a92bbd ("hw/arm: make most of the compilation units
common"), compilation of some arm machines (like musicpal) fails on
certain host systems like OpenBSD 7.6/7.7 since headers like <epoxy/gl.h>
don't reside in /usr/include and we currently don't add the right
CFLAGS for the common files to include the additional header search
paths. Add a loop similar to what we already did in commit 727bb5b477e6
to fix it.

With this fix applied, we can now also drop the explicit dependency
on pixman for the arm musicpal machine.

Fixes: 6f4e8a92bbd ("hw/arm: make most of the compilation units common")
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[thuth: Add commit message + changes in hw/arm/meson.build]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Change the subject of the patch according to Paolo's suggestion

 meson.build        | 27 ++++++++++++++++-----------
 hw/arm/meson.build |  2 +-
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/meson.build b/meson.build
index 5ac64075be7..7131aa2b21d 100644
--- a/meson.build
+++ b/meson.build
@@ -3228,6 +3228,7 @@ config_devices_mak_list = []
 config_devices_h = {}
 config_target_h = {}
 config_target_mak = {}
+config_base_arch_mak = {}
 
 disassemblers = {
   'alpha' : ['CONFIG_ALPHA_DIS'],
@@ -3419,6 +3420,11 @@ foreach target : target_dirs
     config_all_devices += config_devices
   endif
   config_target_mak += {target: config_target}
+
+  # build a merged config for all targets with the same TARGET_BASE_ARCH
+  target_base_arch = config_target['TARGET_BASE_ARCH']
+  config_base_arch = config_base_arch_mak.get(target_base_arch, {}) + config_target
+  config_base_arch_mak += {target_base_arch: config_base_arch}
 endforeach
 target_dirs = actual_target_dirs
 
@@ -4099,28 +4105,27 @@ common_all = static_library('common',
 
 # construct common libraries per base architecture
 hw_common_arch_libs = {}
-foreach target : target_dirs
-  config_target = config_target_mak[target]
-  target_base_arch = config_target['TARGET_BASE_ARCH']
+foreach target_base_arch, config_base_arch : config_base_arch_mak
+  if target_base_arch in hw_common_arch
+    base_arch_hw = hw_common_arch[target_base_arch].apply(config_base_arch, strict: false)
+    base_arch_common = common_ss.apply(config_base_arch, strict: false)
 
-  # check if already generated
-  if target_base_arch in hw_common_arch_libs
-    continue
-  endif
+    lib_deps = base_arch_hw.dependencies()
+    foreach dep : base_arch_common.dependencies()
+      lib_deps += dep.partial_dependency(compile_args: true, includes: true)
+    endforeach
 
-  if target_base_arch in hw_common_arch
     target_inc = [include_directories('target' / target_base_arch)]
-    src = hw_common_arch[target_base_arch]
     lib = static_library(
       'hw_' + target_base_arch,
       build_by_default: false,
-      sources: src.all_sources() + genh,
+      sources: base_arch_hw.sources() + genh,
       include_directories: common_user_inc + target_inc,
       implicit_include_directories: false,
       # prevent common code to access cpu compile time
       # definition, but still allow access to cpu.h
       c_args: ['-DCPU_DEFS_H', '-DCOMPILING_SYSTEM_VS_USER', '-DCONFIG_SOFTMMU'],
-      dependencies: src.all_dependencies())
+      dependencies: lib_deps)
     hw_common_arch_libs += {target_base_arch: lib}
   endif
 endforeach
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 5098795f61d..8e3bf495dbf 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -8,7 +8,7 @@ arm_common_ss.add(when: 'CONFIG_HIGHBANK', if_true: files('highbank.c'))
 arm_common_ss.add(when: 'CONFIG_INTEGRATOR', if_true: files('integratorcp.c'))
 arm_common_ss.add(when: 'CONFIG_MICROBIT', if_true: files('microbit.c'))
 arm_common_ss.add(when: 'CONFIG_MPS3R', if_true: files('mps3r.c'))
-arm_common_ss.add(when: 'CONFIG_MUSICPAL', if_true: [pixman, files('musicpal.c')])
+arm_common_ss.add(when: 'CONFIG_MUSICPAL', if_true: files('musicpal.c'))
 arm_common_ss.add(when: 'CONFIG_NETDUINOPLUS2', if_true: files('netduinoplus2.c'))
 arm_common_ss.add(when: 'CONFIG_OLIMEX_STM32_H405', if_true: files('olimex-stm32-h405.c'))
 arm_common_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx.c', 'npcm7xx_boards.c'))
-- 
2.49.0


