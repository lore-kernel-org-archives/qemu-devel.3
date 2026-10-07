Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74793CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 11:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEQD0-0008OQ-IV; Wed, 07 Oct 2026 07:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEQCz-0008OF-9M
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 07:53:17 -0400
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEQCw-0007wl-EH
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 07:53:17 -0400
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-14129667240so1599745c88.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 04:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791373993; x=1791978793; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R+x4hTf6qxUwy8f4H8bB7cchxBiFqNNUr3In9D68Z5A=;
 b=gxRaeipLTLexfzwYmC66NxwT7h2Az33kXbEezjI3hnELjVJV8BzTm7qzAZJ7aoOUXr
 FdlzX2Kj9oIB+Q5328IVMsjDd5AkbtV1qZRtqKoY23JjpvKfOJfHKd5OI00jQxNtYwgl
 pD6QiLrRP2MCzFxj4K6epvAX7ldOJeS6hfj97L9NZ5sIfK4Y1Cc7YHnjjZK6JY8M7At9
 boXln+7pDf484wUSHGqLP1Wjn5c6l5mxce4dhoRhRM6Zyf5b+M7LAdrGrftCuOgFAQ3h
 U5NLTmgBnyKNde1xk6hWfwBG8o11vp7D072QFM09zb5K65fV8Dbrf1DgaDZYybYtD5e1
 TW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791373993; x=1791978793;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R+x4hTf6qxUwy8f4H8bB7cchxBiFqNNUr3In9D68Z5A=;
 b=dhXUEaE0JqgL2agBPphVmOmwteDhTc5PI2UN2w0+JJfZb23+/9Xzq7pk6UVJlZhDG6
 5PU1Dh99qGniaj3WlFakql6UC03WQBjcY2kUuslisYya0NFrCMiJ1hdYGNvUmr2FBQsH
 gfZ4HM4bxE5f2GckFmvGojlm23dzRRO7b42+Wos7Jvo0u5T54S38ffEMmsBkqStnNDcC
 kBhNuM5WncvGbFAIghUYF4ohle2cjPl3RkjzmlAGm7aZqASX6BHbqaBLCB0jtvkSVdlQ
 FXvmiibMh243Vbn0hZlZJCFz7TsMdH1IuyWxEi38BpZD0wtEt6p1fAQ0QAtQPD3IfPup
 X+dw==
X-Gm-Message-State: AFuF++kttwIkeDd/ibGwtnVjIzZ3Ltdc3g6cE54c7cnruaBh01MMJ8hT
 ltomTPVYY4+b8UsI3U/cXGKclxM8AwA6eD1afaQ3Miwsm1dEnA7Sa5KwSr8x7s2X
X-Gm-Gg: AYBFou2DRVmYmgPohauhGloZ/6AErksiZAzi0DjMmBj5uFrAVc466bwzh8cLlF6HyC3
 0ghIWmy8NQXh4NpBK1ZFxK0jIUOSFTCEhPrNrFYA7J90ocApmcVUZR9Cg9YEK3h5bFZvBKmjPWY
 kNXX3nEwymRTI76X5L22jEsAn7tpYVbE5N7Dk1P5ZXlZUYEP6OUZYPh/qjm8OBm9RU4cARsT5Hv
 +NdEo4LshpDDEIxuQpw2AssY6G6rTMSzMn78ynuAOG6iBb+iw8QMCAuHz1/rZRKHH8WFyr/kbP8
 FOM4Zn+AL57XZG+vj1PssQQGM+yJxu6990hRT72cjV8PwNc/+LjAbHK+2yWBIQA4UzEXZjSVmGH
 Rfz0pKlHJlui/hhtpQljz/MZDAG1mta6WTyIXKVhyPBSfgabbAMOz6rqcva51qzQ0aIcXcugwuC
 MmGWHLMrooUSUTR8kXlC2vOAKaesVePwK48NH6pfz2wh5kLootma9whFereFFzhG231rvXz1i33
 kTEbohnXK9JCtUi+g==
X-Received: by 2002:a05:7022:699d:b0:14d:3c0c:79e9 with SMTP id
 a92af1059eb24-162041de5bemr3275764c88.11.1791373992777; 
 Wed, 07 Oct 2026 04:53:12 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1616980c3b7sm6429520c88.16.2026.10.07.04.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 04:53:12 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Stafford Horne <shorne@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Alexander Bulekov <alxndr@bu.edu>,
 Darren Kenny <darren.kenny@oracle.com>
Subject: [PATCH 1/8] configs/targets: remove target info definitions
Date: Wed,  7 Oct 2026 19:47:58 +0800
Message-ID: <20261007115253.328-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261007115253.328-1-luoyonggang@gmail.com>
References: <20261007115253.328-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1234;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Now that we remove machine_typename, we don't need to keep duplicated
file per target anymore. So we can just rely on target-info-stub.c.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 MAINTAINERS                       |  1 -
 configs/targets/aarch64-softmmu.c | 25 -------------------------
 configs/targets/arm-softmmu.c     | 25 -------------------------
 configs/targets/meson.build       |  6 ------
 configs/targets/riscv32-softmmu.c | 24 ------------------------
 configs/targets/riscv64-softmmu.c | 24 ------------------------
 meson.build                       |  7 +------
 7 files changed, 1 insertion(+), 111 deletions(-)
 delete mode 100644 configs/targets/aarch64-softmmu.c
 delete mode 100644 configs/targets/arm-softmmu.c
 delete mode 100644 configs/targets/meson.build
 delete mode 100644 configs/targets/riscv32-softmmu.c
 delete mode 100644 configs/targets/riscv64-softmmu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1312bbd1bd8..cfe39dc2883 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2148,7 +2148,6 @@ M: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
 S: Supported
 F: include/qemu/target-info*.h
 F: target-info*.c
-F: configs/targets/*.c
 F: tests/unit/test-multi-targets.c
 
 Xtensa Machines
diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-softmmu.c
deleted file mode 100644
index fdebdcc3582..00000000000
--- a/configs/targets/aarch64-softmmu.c
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * QEMU binary/target API (qemu-system-aarch64)
- *
- *  Copyright (c) Linaro
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#include "qemu/osdep.h"
-#include "qemu/target-info-impl.h"
-#include "qemu/target-info-init.h"
-#include "target/arm/cpu-qom.h"
-#include "target/arm/cpu-param.h"
-
-static const TargetInfo target_info_aarch64_system = {
-    .target_name = "aarch64",
-    .target_arch = SYS_EMU_TARGET_AARCH64,
-    .long_bits = 64,
-    .cpu_type = TYPE_ARM_CPU,
-    .endianness = ENDIAN_MODE_LITTLE,
-    .page_bits_vary = true,
-    .page_bits_init = TARGET_PAGE_BITS_LEGACY,
-};
-
-target_info_init(target_info_aarch64_system)
diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-softmmu.c
deleted file mode 100644
index 2b98f65a0f8..00000000000
--- a/configs/targets/arm-softmmu.c
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * QEMU binary/target API (qemu-system-arm)
- *
- *  Copyright (c) Linaro
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#include "qemu/osdep.h"
-#include "qemu/target-info-impl.h"
-#include "qemu/target-info-init.h"
-#include "target/arm/cpu-qom.h"
-#include "target/arm/cpu-param.h"
-
-static const TargetInfo target_info_arm_system = {
-    .target_name = "arm",
-    .target_arch = SYS_EMU_TARGET_ARM,
-    .long_bits = 32,
-    .cpu_type = TYPE_ARM_CPU,
-    .endianness = ENDIAN_MODE_LITTLE,
-    .page_bits_vary = true,
-    .page_bits_init = TARGET_PAGE_BITS_LEGACY,
-};
-
-target_info_init(target_info_arm_system)
diff --git a/configs/targets/meson.build b/configs/targets/meson.build
deleted file mode 100644
index 2ab4d27eaf5..00000000000
--- a/configs/targets/meson.build
+++ /dev/null
@@ -1,6 +0,0 @@
-foreach target : [
-      'arm-softmmu', 'aarch64-softmmu',
-      'riscv32-softmmu', 'riscv64-softmmu'
-  ]
-  config_target_info += {target : files(target + '.c')}
-endforeach
diff --git a/configs/targets/riscv32-softmmu.c b/configs/targets/riscv32-softmmu.c
deleted file mode 100644
index 0829ab84de5..00000000000
--- a/configs/targets/riscv32-softmmu.c
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * QEMU binary/target API (qemu-system-riscv32)
- *
- *  Copyright (c) rev.ng Labs Srl.
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#include "qemu/osdep.h"
-#include "qemu/target-info-impl.h"
-#include "qemu/target-info-init.h"
-#include "target/riscv/cpu-qom.h"
-#include "target/riscv/cpu-param.h"
-
-static const TargetInfo target_info_riscv32_system = {
-    .target_name = "riscv32",
-    .target_arch = SYS_EMU_TARGET_RISCV32,
-    .long_bits = 32,
-    .cpu_type = TYPE_RISCV_CPU,
-    .endianness = ENDIAN_MODE_LITTLE,
-    .page_bits_init = TARGET_PAGE_BITS,
-};
-
-target_info_init(target_info_riscv32_system)
diff --git a/configs/targets/riscv64-softmmu.c b/configs/targets/riscv64-softmmu.c
deleted file mode 100644
index 553bd1f75fe..00000000000
--- a/configs/targets/riscv64-softmmu.c
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * QEMU binary/target API (qemu-system-riscv64)
- *
- *  Copyright (c) rev.ng Labs Srl.
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#include "qemu/osdep.h"
-#include "qemu/target-info-impl.h"
-#include "qemu/target-info-init.h"
-#include "target/riscv/cpu-qom.h"
-#include "target/riscv/cpu-param.h"
-
-static const TargetInfo target_info_riscv64_system = {
-    .target_name = "riscv64",
-    .target_arch = SYS_EMU_TARGET_RISCV64,
-    .long_bits = 64,
-    .cpu_type = TYPE_RISCV_CPU,
-    .endianness = ENDIAN_MODE_LITTLE,
-    .page_bits_init = TARGET_PAGE_BITS,
-};
-
-target_info_init(target_info_riscv64_system)
diff --git a/meson.build b/meson.build
index 828100de816..64d3f7675f7 100644
--- a/meson.build
+++ b/meson.build
@@ -3754,7 +3754,6 @@ subdir('dump')
 subdir('accel')
 
 subdir('backends')
-subdir('configs/targets')
 subdir('disas')
 subdir('migration')
 subdir('monitor')
@@ -4346,11 +4345,7 @@ foreach target : target_dirs
     endif
   endif
 
-  if target in config_target_info
-    arch_srcs += config_target_info[target]
-  else
-    arch_srcs += files('target-info-stub.c')
-  endif
+  arch_srcs += files('target-info-stub.c')
 
   if target_base_arch in target_arch
     t = target_arch[target_base_arch].apply(config_target, strict: false)
-- 
2.55.0.windows.3


