Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F11106FD87
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vwY-0000vg-HZ; Fri, 13 Mar 2026 02:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vwM-0000Rm-6X
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:24:08 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vwK-0007Fx-Fj
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:24:05 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso29079895e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773383042; x=1773987842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h/fre0Wn6clxYvKewq4mOsMNfDyy6T99RZwrwr3XZhA=;
 b=LTt6iOfeOwUGoRGYeI5q1+Jf5naLOVuDa4GH+XPe2kONRqbU53be87fmdaTOG5JPD3
 gPfGZSkHwJY/hhMkHy/1VLt0Wuk4QJRnilmvRSG0xdOqOWdZalPr5v1Ak1KiRbZM51i3
 y9bIM2oSgmSd2axict8Yd7nfybZkdMFqh7twSgsj2Bc46USj7yRCJ8faBBSTiRJn0j+M
 Wizw30SvGSs2Rfns91Df5YyMiDWnw9k4KLss5ZlZBWIugwjtDaXK2VdlNccco7pF0CeN
 b7Nzvl1SZvc65/STcRk6XChePuChQurAVmYlI1WYqo+Ow12/srbTm+Sn4fN+VR6Cp1TH
 /2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773383042; x=1773987842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h/fre0Wn6clxYvKewq4mOsMNfDyy6T99RZwrwr3XZhA=;
 b=cYnlnH3IHLUBmTsBTgAT4PhKGxwjRN4kM4QrvimQi2xmRriwWC0xxbKDT9soWdgM3x
 H8+oLKcB6yfrdOa8rBlQzcNJcFV/JnSJZJxylUEou5oGUUmgKKp+EFTkTnfoKPV1YIuI
 hu6t5dmZoXXoeOeaJBS5g06xhghQbFFUVVcSYdnZqSpb8eTUDsZy+ONnYKjyRJFQkmsJ
 8LyU065Qc9FqQ3R9LPfRxbjOKs/hoqGONhPsO9WURUqaeF5Rdn3m6djoFFKo45sUKDvm
 rMkHyrs4HURTSyhVknJiR9SbeGPGQsQYZCFGqxp/xhaCv8fqz+qgyguLX9uWEWzSgKEV
 4bEw==
X-Gm-Message-State: AOJu0YzVAyn2bTwpU1K2wD4V3y/TGLhd5f479dODJWoFJvUBisJsGixx
 wC5BBpQIP5MtmIto+Wz+VXFv0P1acjq63P+uMMGnbCO7rgkiCVu0B03zEX5dvAeuB9MPqnzObVA
 TEwFHzLo=
X-Gm-Gg: ATEYQzznC6gXmxzf4ycMDG/mnq2AqD0xhGUp5AmyZv7sl7zhUi477xre09tebR2x++C
 /i2CiOxLm8G5kgeaNWsTUjMk4W9vycaRIWqZIlXo7D6hPH6hCfTVvDhOIKKPbSdFlrmSuYayQUa
 7MxpGQkEsgpzJSHvjDArO1olJd+40CyZYGekv0JX3IlVQUKOOfO7q9U8jrfEM5zk+NuYbvA/2nR
 5Zc6b+cZy/GE1NJPOebUFD3+EnK3vnmPrXcW/ma68impRdAW59wLIU0hE3LNG6WsFcNXewH8Ih3
 riOGGyEAh3+7Uuvfk8TcbFjA7TFPANiOYCVUkWvbSTSeen/Nsi9qBKZO6xFo70TMkpduTX/OMo5
 If6m6HD8SedPGaoOKw3Kf3fhOaaKL/Wxofxu2vDtu0GPqJi6k4biqiQj88oM5Sr5yQiaqHC0RTG
 QVR4xEK+IZCnyLUiZT+4VJqmRI8MqCWn/hnNheY1CGPiX+Xb4J6rZkO41D5S6FlmmDsJXnpbGeS
 Mnylw==
X-Received: by 2002:a05:600c:6290:b0:485:33b7:573d with SMTP id
 5b1f17b1804b1-48555ab0a59mr35050335e9.1.1773383042499; 
 Thu, 12 Mar 2026 23:24:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4855778206asm17064315e9.6.2026.03.12.23.24.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:24:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 27/38] hw/mips: Include full path to target 'cpu.h' header
Date: Fri, 13 Mar 2026 07:20:43 +0100
Message-ID: <20260313062055.2188-28-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/intc/mips_gic.h | 2 +-
 hw/mips/bootloader.c       | 2 +-
 hw/mips/fuloong2e.c        | 2 +-
 hw/mips/jazz.c             | 2 +-
 hw/mips/malta.c            | 2 +-
 hw/misc/mips_cpc.c         | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/intc/mips_gic.h b/include/hw/intc/mips_gic.h
index e2e6f0a168c..b3b64fec855 100644
--- a/include/hw/intc/mips_gic.h
+++ b/include/hw/intc/mips_gic.h
@@ -14,7 +14,7 @@
 #include "qemu/units.h"
 #include "hw/timer/mips_gictimer.h"
 #include "hw/core/sysbus.h"
-#include "cpu.h"
+#include "target/mips/cpu.h"
 #include "qom/object.h"
 /*
  * GIC Specific definitions
diff --git a/hw/mips/bootloader.c b/hw/mips/bootloader.c
index 1dd6ef20968..aa4abcf4c36 100644
--- a/hw/mips/bootloader.c
+++ b/hw/mips/bootloader.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
-#include "cpu.h"
+#include "target/mips/cpu.h"
 #include "hw/mips/bootloader.h"
 
 typedef enum bl_reg {
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index d0efe36f7ce..1297dc967e4 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -22,7 +22,7 @@
 #include "qemu/datadir.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "cpu.h"
+#include "target/mips/cpu.h"
 #include "hw/core/clock.h"
 #include "net/net.h"
 #include "hw/core/boards.h"
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index e0adb96c548..bec534d38b0 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -52,7 +52,7 @@
 #ifdef CONFIG_TCG
 #include "accel/tcg/cpu-ops.h"
 #endif /* CONFIG_TCG */
-#include "cpu.h"
+#include "target/mips/cpu.h"
 
 enum jazz_model_e {
     JAZZ_MAGNUM,
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 812ff64d831..0cbe9956e74 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -61,7 +61,7 @@
 #include "hw/core/qdev-clock.h"
 #include "target/mips/internal.h"
 #include "trace.h"
-#include "cpu.h"
+#include "target/mips/cpu.h"
 
 #define ENVP_PADDR          0x2000
 #define ENVP_VADDR          cpu_mips_phys_to_kseg0(NULL, ENVP_PADDR)
diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
index d092f76f44d..9d9c8bf6ec8 100644
--- a/hw/misc/mips_cpc.c
+++ b/hw/misc/mips_cpc.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "cpu.h"
+#include "target/mips/cpu.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/core/cpu.h"
-- 
2.53.0


