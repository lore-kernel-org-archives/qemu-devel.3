Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A39C369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 16:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5SW5-0008V2-6E; Thu, 17 Apr 2025 12:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5SW0-0008SC-7c
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:55:04 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5SVp-0003f6-KM
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:54:55 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so10739105e9.3
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 09:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744908891; x=1745513691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HQaw5EphNOPUEEg94VOsDJb4EqhlPL6RL/fasC54olQ=;
 b=qv1H+JB1jyx2hMI0OzKwQmKFLlP9FoRmQD13Kd3cxE65nSN79CYI8xZfnoh3T5hd3m
 uCEUE9M2cSr7OpXV2/6jnRdudZo8Bpcxzz+PIvPiihqt0xOi3JWD1GorFJpNhgZLLcq9
 9eGALV0dLi5j+MU9o8PNaqUFRCJodhaS0U6SL1kD3q2KWWiEZPUzbGBfl5iQwPHPub6T
 t1oO99uX/AmG7WOOAGhRaAXiDhL6XWA/WSfLUP4zJwFQGnvuhBKHLTZNoKvLdc+EE7sN
 tfjhNe+CaByMBCjYZhkpfRRtT/8UYj2xsxGa3A1FqYXjfZSGXwRjXEXLM9TfcVGRWc+R
 iK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744908891; x=1745513691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HQaw5EphNOPUEEg94VOsDJb4EqhlPL6RL/fasC54olQ=;
 b=vT8KCGYTcqPDrE7tyF7th3mCo97iVqM6LiKCKPdOgmiZT0P898p/U0r+lMVIn0yDsE
 LY7d+Px7630wwqd9z8rSpgAuyD09O4lWknaqPTNsU44Khz9CaQtu0b1i2Pnfq5WZb9nm
 RZR4jrJLBHBly2lgCfOI1keRJAS80Er1+oENdN+1K+RYPNZ6IkIpSFLpz/r7mWG2QLMG
 w05VqFDjdrm0U4evQx1Y7KnbhfWkAPQGkZWFOoDsK+pmO7rngKy9p/4sg+DviuGYxqAj
 nHzoJ7RXY2sF2UstCG3f3llO5OZ6LEKuHumYTPNbJ2qaPk4MWZec4PouEb+nat990IAr
 oJwA==
X-Gm-Message-State: AOJu0YxP+K039CMWsQ/AJtQJYQdzytm2xK4ThZKK1mczhMGsQrqBwaRN
 VKGWGqiWW5m2UEa2DX9hvgSi1gl+Hj7oKYrSyC0qa8CJcfswyHGan4fLemdzWeLqJS++5zJGErq
 w
X-Gm-Gg: ASbGncuVuV9hWfvXeIvaVFc1YkEkRiMEkJNQln5UQnlbehekvpx+ef0X/T+L/9okIJs
 tlMSvru08Ig3TLO4ytipXhGEp6pnpOxFcOAIUuCX+16wI6nqd48NZhWDeqbXaqyzw+sE4M7yCn2
 GtXPFiZKFVHCEQ+3u3zeT//dj3dNyw+w6aCoEE5qCsLAspWt3c8BP+Ir/AyCSiKGOYwP5XXTgpK
 Uf/RAVv3qEhDefifeY4kXhp98bmyaWkCjIxW1RmuemHW/EJVN9TiAlOXr+1V/Qy67Wdy5BCc292
 BdEVcVuypRBv+4tKI6AJgK7z1GKj4WAYA5/2Ji+IDd0eX+VnFR1ToBuEixU63EHXrdqgqW3h7Uh
 PRHmMshxc3blEhw4=
X-Google-Smtp-Source: AGHT+IEySMqUpEaj8M5qbhzzgUAEdGbnOxgEOHFeOTnbawtuSRbb2t0fHsDAA5xp5wsGb5VTPHkfnQ==
X-Received: by 2002:a05:600c:4688:b0:43c:fa52:7d2d with SMTP id
 5b1f17b1804b1-4405d69b7acmr54233875e9.20.1744908891536; 
 Thu, 17 Apr 2025 09:54:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44069953823sm4736265e9.19.2025.04.17.09.54.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 09:54:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 4/7] accel: Implement accel_init_ops_interfaces() for both
 system/user mode
Date: Thu, 17 Apr 2025 18:54:27 +0200
Message-ID: <20250417165430.58213-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250417165430.58213-1-philmd@linaro.org>
References: <20250417165430.58213-1-philmd@linaro.org>
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

We want to build more common code, moving objects from meson's
specific_ss[] set to common_ss[]. Since the CONFIG_USER_ONLY
definitions isn't applied on the common_ss[] set, it is simpler
to add an empty accel_init_ops_interfaces() stub on user emulation,
removing any CONFIG_USER_ONLY use in accel-target.c.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                                |  2 +-
 accel/{accel-system.h => accel-internal.h} |  8 ++++----
 accel/accel-system.c                       |  4 ++--
 accel/accel-target.c                       | 10 ++--------
 accel/accel-user.c                         |  6 ++++++
 5 files changed, 15 insertions(+), 15 deletions(-)
 rename accel/{accel-system.h => accel-internal.h} (56%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 07ca088f7e8..9bd7e63c6cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -499,7 +499,7 @@ F: include/qemu/target_info.h
 F: include/system/accel-*.h
 F: include/system/cpus.h
 F: include/accel/accel-cpu-target.h
-F: accel/accel-*.c
+F: accel/accel-*.?
 F: accel/Makefile.objs
 F: accel/stubs/Makefile.objs
 F: cpu-common.c
diff --git a/accel/accel-system.h b/accel/accel-internal.h
similarity index 56%
rename from accel/accel-system.h
rename to accel/accel-internal.h
index 2d37c73c97b..03426aa21ee 100644
--- a/accel/accel-system.h
+++ b/accel/accel-internal.h
@@ -1,5 +1,5 @@
 /*
- * QEMU System Emulation accel internal functions
+ * QEMU accel internal functions
  *
  * Copyright 2021 SUSE LLC
  *
@@ -7,9 +7,9 @@
  * See the COPYING file in the top-level directory.
  */
 
-#ifndef ACCEL_SYSTEM_H
-#define ACCEL_SYSTEM_H
+#ifndef ACCEL_INTERNAL_H
+#define ACCEL_INTERNAL_H
 
-void accel_system_init_ops_interfaces(AccelClass *ac);
+void accel_init_ops_interfaces(AccelClass *ac);
 
 #endif /* ACCEL_SYSTEM_H */
diff --git a/accel/accel-system.c b/accel/accel-system.c
index 5df49fbe831..a0f562ae9ff 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -29,7 +29,7 @@
 #include "system/accel-ops.h"
 #include "system/cpus.h"
 #include "qemu/error-report.h"
-#include "accel-system.h"
+#include "accel-internal.h"
 
 int accel_init_machine(AccelState *accel, MachineState *ms)
 {
@@ -63,7 +63,7 @@ void accel_setup_post(MachineState *ms)
 }
 
 /* initialize the arch-independent accel operation interfaces */
-void accel_system_init_ops_interfaces(AccelClass *ac)
+void accel_init_ops_interfaces(AccelClass *ac)
 {
     const char *ac_name;
     char *ops_name;
diff --git a/accel/accel-target.c b/accel/accel-target.c
index 9e9e70be876..6fa5c3ef04e 100644
--- a/accel/accel-target.c
+++ b/accel/accel-target.c
@@ -29,10 +29,7 @@
 
 #include "cpu.h"
 #include "accel/accel-cpu-target.h"
-
-#ifndef CONFIG_USER_ONLY
-#include "accel-system.h"
-#endif /* !CONFIG_USER_ONLY */
+#include "accel-internal.h"
 
 static const TypeInfo accel_type = {
     .name = TYPE_ACCEL,
@@ -106,10 +103,7 @@ static void accel_init_cpu_interfaces(AccelClass *ac)
 
 void accel_init_interfaces(AccelClass *ac)
 {
-#ifndef CONFIG_USER_ONLY
-    accel_system_init_ops_interfaces(ac);
-#endif /* !CONFIG_USER_ONLY */
-
+    accel_init_ops_interfaces(ac);
     accel_init_cpu_interfaces(ac);
 }
 
diff --git a/accel/accel-user.c b/accel/accel-user.c
index 22b6a1a1a89..7d192306a65 100644
--- a/accel/accel-user.c
+++ b/accel/accel-user.c
@@ -9,6 +9,12 @@
 
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
+#include "accel-internal.h"
+
+void accel_init_ops_interfaces(AccelClass *ac)
+{
+    /* nothing */
+}
 
 AccelState *current_accel(void)
 {
-- 
2.47.1


