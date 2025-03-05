Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030F6C021B8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 00:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpd0O-00021z-LI; Tue, 04 Mar 2025 19:53:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpd0N-00021a-Oe
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:52:59 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpd0J-0007U3-8Y
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:52:59 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43bcc85ba13so10279135e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 16:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741135973; x=1741740773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TUuRn4CzCPoO/VAnx0IGvC9GeVl9hidcvGsy50QPlH8=;
 b=tc6373CcIS6dpBTOy9WZ7ZHQigFCE0fEXIH1V4nODo0Z1rD7z1n36TSMcbpTk9grhq
 e6WoGFXSOzMHg0jr7kfVfgkuhy6MTEmUDfMtwZLS2rY9zCpMOlshEPuHdnhH5rLVfX/I
 Heg2OMFBUMIJ1f0BiY+fkkyDc5OVX6T0V0PWrYmP9NusI80n9KJCgO2zsm9ytvNblppa
 9lsUu50YH782MtVQ0FJf62N57eFVvbd/j6BEslcgau6N7FtEDXRW8E8mXdInYi1Y943s
 TESbbEmCZIuTHAlGiEaBfiw4BuMbQp7rGokQju78JQju9AbMfNsf5a3G5X/NHTNDffRi
 UlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741135973; x=1741740773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TUuRn4CzCPoO/VAnx0IGvC9GeVl9hidcvGsy50QPlH8=;
 b=NC4S8/7AFFjFJuU3OvO4Ozu/GaTtq+chfD0fuqTQa/O9qfu5FSzPFtQfVkiZHdFtBS
 UdVHpZjrGbsJe4xXoZXHPrzx4lNvX/4UA7htJi6oPHKAR1NPRphLAOGi3R+3CWkoqVef
 sx0/KrZfGl4/bJz+BywREszXXppJgCw2EFjSv/BUaC4trLt0R5I8GL9X+b8A3HNKnjx4
 TvLGUqpuIt0V1UwIElFqNyjqVHC2jSNIsaSthDXFz0rkz7HSzKyGkcXdc71hWpJuhkdE
 Y9cGKKXET62W+7kGhaPderEHGUVmsD74d+lA8R2tbb87m626ywHltzZ9/IYG4uvBhVP9
 Z7UQ==
X-Gm-Message-State: AOJu0YyfmKyPFqKKz/hGsxnW2wGhXo2R1MzJVbghDn4J2XGoC1uKRi+u
 1ZhOX1pC+w5/K5F6LQIsTfaCUj+hVf0fxoHKYxHO9LfYUAql168WEJfld9hDpxwGMUR9VIYO3OO
 UuJU=
X-Gm-Gg: ASbGncvrDxOhF7nHgiddxNHHWmhbelcdM5lSzO/Ynmza14e497jJa38WoCCuofvhWZv
 19y1ap8wsEdPfbbxstJpN/hmuQ+8QSSn8xr+1Rja4SwfFLtPWf76gJuzn0Ee3ZsexCw9dhpFqEO
 YeYLMrK248rfBMRJ7Ncn9rqe50V36Nr5WOcOrcjX/jOzRnjeyYvJZFYc9x21My6LjPbuRXHMq3o
 m9XvOi3RDzGZ9F6PSLAOZEpi2evZhMsAYL713X2Ku7qknyQv/cwNTnVKS92crGmRUbK+6UxL5qR
 fHovZ9XH9dUizENtrevhIGV2brVCnNDyoG3uyB/fhYp89NzWOb4Mtsz0Qq0h64u2cUZ/bIJ/Ko4
 m+Ie7nOj281mz4TewZEQ=
X-Google-Smtp-Source: AGHT+IHnxvc6C4PFeofnXej0/DW0dO6R02VRDzhyURZuK4Dhj8oTHGkRfi7M6bv/MN6+HzSs/PDJ5Q==
X-Received: by 2002:a05:600c:45c9:b0:439:8185:4ad4 with SMTP id
 5b1f17b1804b1-43bd2ae6055mr5100495e9.27.1741135973366; 
 Tue, 04 Mar 2025 16:52:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4352ed7sm1356915e9.26.2025.03.04.16.52.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 16:52:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 05/11] include: Expose QemuArchBit enum to user emulation
Date: Wed,  5 Mar 2025 01:52:19 +0100
Message-ID: <20250305005225.95051-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305005225.95051-1-philmd@linaro.org>
References: <20250305005225.95051-1-philmd@linaro.org>
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

QemuArchBit isn't really specific to system emulation,
move the "system/arch_init.h" header to "qemu/arch_info.h",
a more generic include path.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build                                      | 2 +-
 include/{system/arch_init.h => qemu/arch_info.h} | 4 ++--
 system/arch_init.c => arch_info-target.c         | 2 +-
 hw/scsi/scsi-disk.c                              | 2 +-
 system/qdev-monitor.c                            | 2 +-
 system/vl.c                                      | 2 +-
 system/meson.build                               | 1 -
 7 files changed, 7 insertions(+), 8 deletions(-)
 rename include/{system/arch_init.h => qemu/arch_info.h} (97%)
 rename system/arch_init.c => arch_info-target.c (97%)

diff --git a/meson.build b/meson.build
index 1ab02a5d48d..04d8c477644 100644
--- a/meson.build
+++ b/meson.build
@@ -3766,7 +3766,7 @@ if have_block
 endif
 
 common_ss.add(files('cpu-common.c'))
-specific_ss.add(files('cpu-target.c'))
+specific_ss.add(files('cpu-target.c', 'arch_info-target.c'))
 
 subdir('system')
 
diff --git a/include/system/arch_init.h b/include/qemu/arch_info.h
similarity index 97%
rename from include/system/arch_init.h
rename to include/qemu/arch_info.h
index 023d27d5bd7..3cb95926e27 100644
--- a/include/system/arch_init.h
+++ b/include/qemu/arch_info.h
@@ -1,5 +1,5 @@
-#ifndef QEMU_ARCH_INIT_H
-#define QEMU_ARCH_INIT_H
+#ifndef QEMU_ARCH_INFO_H
+#define QEMU_ARCH_INFO_H
 
 #include "qemu/bitops.h"
 
diff --git a/system/arch_init.c b/arch_info-target.c
similarity index 97%
rename from system/arch_init.c
rename to arch_info-target.c
index 0fec0cd416b..6c11c73feb9 100644
--- a/system/arch_init.c
+++ b/arch_info-target.c
@@ -22,7 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "system/arch_init.h"
+#include "qemu/arch_info.h"
 
 bool qemu_arch_available(unsigned qemu_arch_mask)
 {
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 7c87b20e694..bafa9f39497 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -27,12 +27,12 @@
 #include "qemu/module.h"
 #include "qemu/hw-version.h"
 #include "qemu/memalign.h"
+#include "qemu/arch_info.h"
 #include "hw/scsi/scsi.h"
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "hw/scsi/emulation.h"
 #include "scsi/constants.h"
-#include "system/arch_init.h"
 #include "system/block-backend.h"
 #include "system/blockdev.h"
 #include "hw/block/block.h"
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 5588ed2047d..b88e6e83512 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -22,7 +22,6 @@
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
 #include "monitor/qdev.h"
-#include "system/arch_init.h"
 #include "system/runstate.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-qdev.h"
@@ -37,6 +36,7 @@
 #include "qemu/option.h"
 #include "qemu/qemu-print.h"
 #include "qemu/option_int.h"
+#include "qemu/arch_info.h"
 #include "system/block-backend.h"
 #include "migration/misc.h"
 #include "qemu/cutils.h"
diff --git a/system/vl.c b/system/vl.c
index ec93988a03a..e96c72e5400 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -27,6 +27,7 @@
 #include "qemu/datadir.h"
 #include "qemu/units.h"
 #include "qemu/module.h"
+#include "qemu/arch_info.h"
 #include "exec/cpu-common.h"
 #include "exec/page-vary.h"
 #include "hw/qdev-properties.h"
@@ -110,7 +111,6 @@
 #include "trace/control.h"
 #include "qemu/plugin.h"
 #include "qemu/queue.h"
-#include "system/arch_init.h"
 #include "system/confidential-guest-support.h"
 
 #include "ui/qemu-spice.h"
diff --git a/system/meson.build b/system/meson.build
index 181195410fb..900c5d52ee4 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -1,5 +1,4 @@
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
-  'arch_init.c',
   'ioport.c',
   'globals-target.c',
   'memory.c',
-- 
2.47.1


