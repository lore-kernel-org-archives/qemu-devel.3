Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3550CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 19:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVy6-0002OS-Tr; Mon, 11 May 2026 15:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wMVxk-0002Jj-SM
 for qemu-devel@nongnu.org; Mon, 11 May 2026 15:06:45 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wMVxj-00086e-60
 for qemu-devel@nongnu.org; Mon, 11 May 2026 15:06:44 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7df05fc49e5so4561959a34.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 12:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778526402; x=1779131202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4HYcto3bMmCQk+FYvg5UJK0RuShy2ZzvXpICY4IIjUw=;
 b=Os7Rsqw6rf/r27wV6Jk5QYTCD37l/9bSjazZ6s6HA4lkQ/MNH2cpEtkGdeEq86d2Cu
 w/UxmSRVRnTThhwuZQQVAyTkhXqzz4nO+4cPnYvD7Zt7Kg+ZK4EkihQsM5kVhxJE3T5F
 zobjSXglS/Rhkex9ZDKpBKzl9wqZSxZmElVF9+wLmhhVSP77Wcj38iDqykebmOiPZ8r4
 dpxuiCJ88Kva4chg920tMStCfJ2u4MdfcQO8ps16cgiV149gdujaY/KX4zonFDTca2IA
 Q7Jz2KukT+612+MYaOrmKPB2eGPhpLEz+lJ5Svz476bE2nOsc+54mWy+X3t9/Op0yLiS
 ZiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778526402; x=1779131202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4HYcto3bMmCQk+FYvg5UJK0RuShy2ZzvXpICY4IIjUw=;
 b=HcJyOIU/kAr1EXOy9Zt16wj+4mH+ZN/cxpUzgM+tYyOLAhPNjyWVpFK0WIQCzuJgDJ
 e9hPYoqTs7LpsBdTrHtUbSBaIAWIqvz7lMapqWcqBVWZxSi2Pm/ixwD+lgwzzauDjg8s
 ZtQBKOSDnhV8PN1uyvSI2eNEh5iP8yC6Cs5FnZeiMjtwGW7agRwp+/peNkCgoUFsIf2P
 2ujj4vJ8H+bQo1cqhG31D74p7gIUsh7YaLFiJ2SGiI6PZKBsTj74vr2mttPyrKs31PQz
 MqzvZVZm2C0NTGEpm1WJ8r72CFafbGD6XjLUoEavCIFyNgrkWWFDz0eDCmnzWNJGMZD+
 fyMQ==
X-Gm-Message-State: AOJu0YwzbfYbTlto7OxiNWjaSiuj70FX6aua2KNK7PZSDTWM9r0zCKIf
 +0R17qJPQDcds+00ann2k0D+eQTVB1STmlBwjpHGUYsUjks5y54MjklBKp9T7LGNqZnyn232/9v
 HmMLZ
X-Gm-Gg: Acq92OH0OBjSWONKSqDtgiMQous5sRMh3ONAd166Ow6Um8Kw+HMIUsVb4P0Ws66Ye9D
 uycAGuvQd9A/Kkyf3ZtlBY+CyQu/BmS4XTQSbjuEOB3qONoe/7or15WhBAMMALppI3BaRlFKxfc
 9eCIqSCXUTQU4n2u4ZYBGfkl+Q3Y1IXJlAkRP1DdvU29fo46fDsuh5uAEZAlqni/20XhXnJi2sH
 ZZikaDLU/e5DWiw3aGcynFoILKYaY7VUBgRsY7diTcS4ypgJXD3+mfTHL4iDQVbXCtNHDhcbBHP
 wNJd6S0MotOZw22v2txY0CJWoHR9O6Xrt/O3KcG9OAKG36F1wTqRITCCgV6ZoM4TX1w7A7IYPbx
 5Fe2GEa1oyYZL9zYwxiQbByPW95Ys9LOu31NFPdrx03mRUb8vPxPTq0T82vaULT1yuc6X65OSxG
 JLWseEBZzaWe0WK8+ReyQGahTU9Kyt8osu9s1fPew5R0iN1w==
X-Received: by 2002:a05:6830:6118:b0:7d9:7201:1acf with SMTP id
 46e09a7af769-7e381f0fae0mr6974352a34.5.1778526401619; 
 Mon, 11 May 2026 12:06:41 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:e3e5:757d:3cef:3491])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm7157011a34.23.2026.05.11.12.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 12:06:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com,
	philmd@linaro.org
Subject: [PATCH 4/5] target-info: Merge target-info-qapi.h into target-info.h
Date: Mon, 11 May 2026 14:06:33 -0500
Message-ID: <20260511190634.472174-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511190634.472174-1-richard.henderson@linaro.org>
References: <20260511190634.472174-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/target-info-qapi.h | 29 -----------------------------
 include/qemu/target-info.h      | 14 ++++++++++++++
 hw/core/machine-qmp-cmds.c      |  1 -
 hw/uefi/ovmf-log.c              |  2 +-
 hw/virtio/virtio-mem.c          |  2 +-
 system/arch_init.c              |  2 +-
 target-info.c                   |  1 -
 7 files changed, 17 insertions(+), 34 deletions(-)
 delete mode 100644 include/qemu/target-info-qapi.h

diff --git a/include/qemu/target-info-qapi.h b/include/qemu/target-info-qapi.h
deleted file mode 100644
index d5ce052323..0000000000
--- a/include/qemu/target-info-qapi.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * QEMU target info API (returning QAPI types)
- *
- *  Copyright (c) Linaro
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#ifndef QEMU_TARGET_INFO_EXTRA_H
-#define QEMU_TARGET_INFO_EXTRA_H
-
-#include "qapi/qapi-types-common.h"
-#include "qapi/qapi-types-machine.h"
-
-/**
- * target_arch:
- *
- * Returns: QAPI SysEmuTarget enum (e.g. SYS_EMU_TARGET_X86_64).
- */
-SysEmuTarget target_arch(void);
-
-/**
- * target_endian_mode:
- *
- * Returns: QAPI EndianMode enum (e.g. ENDIAN_MODE_LITTLE).
- */
-EndianMode target_endian_mode(void);
-
-#endif
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index c9f7f2aa26..d8d2194d9b 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -69,6 +69,13 @@ const char *target_machine_typename(void);
  */
 const char *target_cpu_type(void);
 
+/**
+ * target_endian_mode:
+ *
+ * Returns: QAPI EndianMode enum (e.g. ENDIAN_MODE_LITTLE).
+ */
+EndianMode target_endian_mode(void);
+
 /**
  * target_big_endian:
  *
@@ -81,6 +88,13 @@ const char *target_cpu_type(void);
  */
 bool target_big_endian(void);
 
+/**
+ * target_arch:
+ *
+ * Returns: QAPI SysEmuTarget enum (e.g. SYS_EMU_TARGET_X86_64).
+ */
+SysEmuTarget target_arch(void);
+
 /**
  * target_base_arm:
  *
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index e62cb4ec88..3583a60ee8 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -21,7 +21,6 @@
 #include "qapi/type-helpers.h"
 #include "qemu/uuid.h"
 #include "qemu/target-info.h"
-#include "qemu/target-info-qapi.h"
 #include "qom/qom-qobject.h"
 #include "system/hostmem.h"
 #include "system/hw_accel.h"
diff --git a/hw/uefi/ovmf-log.c b/hw/uefi/ovmf-log.c
index 3a24afd941..ed351149f1 100644
--- a/hw/uefi/ovmf-log.c
+++ b/hw/uefi/ovmf-log.c
@@ -8,7 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "qemu/target-info-qapi.h"
+#include "qemu/target-info.h"
 #include "hw/core/boards.h"
 #include "hw/i386/x86.h"
 #include "hw/arm/virt.h"
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index a4b71974a1..3d285eaf60 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -15,7 +15,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
-#include "qemu/target-info-qapi.h"
+#include "qemu/target-info.h"
 #include "system/numa.h"
 #include "system/system.h"
 #include "system/ramblock.h"
diff --git a/system/arch_init.c b/system/arch_init.c
index 1ad2f3d6f7..6fa5ae2160 100644
--- a/system/arch_init.c
+++ b/system/arch_init.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "qemu/base-arch-defs.h"
 #include "qemu/bitops.h"
-#include "qemu/target-info-qapi.h"
+#include "qemu/target-info.h"
 
 bool qemu_arch_available(uint32_t arch_bitmask)
 {
diff --git a/target-info.c b/target-info.c
index 3679e3ddd6..f02a033584 100644
--- a/target-info.c
+++ b/target-info.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qemu/target-info.h"
-#include "qemu/target-info-qapi.h"
 #include "qapi/error.h"
 
 const char *target_name(void)
-- 
2.43.0


