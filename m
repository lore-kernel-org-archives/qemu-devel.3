Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D12CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJRr-0002Qa-La; Tue, 21 Oct 2025 16:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJRf-0001uy-Iy
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:59:04 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJRc-0002ZG-J6
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:59:03 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-471066cfc2aso14407415e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761080339; x=1761685139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qx+WMzM5axG2TB0z/BfWBsORVg3KM288eU2VCZR6aOw=;
 b=CLOHhlVJXzhPeJ4x+H6OFUS8F2AEn2pusdtWg0BMkGRUqlmnvfka59L4ZrcsBLVbfm
 ULpuhf8SnU49O/GXsqVfgAxi4lJ0qYb7CsuRPh5Ey+GkSe2Y/4KCWhndl+7QzuToJS8n
 qctIG8r1Vf7pMOkcD6FSG4E+FnluIG5Ng9dFZi3TmnVjzkJW1P/7nkNzWjovxpZ8g+g7
 Jngp2Xt9VVcAtzVdAzKmhyE78yhu7DYbR5WlR9jY32LKSIadtLlNTjmZsA9CbkEDLC69
 DT7qkWRXHQdIL8RdXcg3fUwXYmo0H+pU2d7pno/wbOov4SMrEWzd5Fq+rtZalWbUfuKn
 bEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761080339; x=1761685139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qx+WMzM5axG2TB0z/BfWBsORVg3KM288eU2VCZR6aOw=;
 b=UzaRSGniRxxnMavjpzRUnyzCGYOMRinbpIlKl7ysUxeCMJjzcnfe9OpHvNBJnEAtmG
 hGIswZwSjB5bML5eLEK/QKYfn9KBD5BDx61ojLrajCRIb2zi/1UwcBdGh6y6ZS1mIdZ5
 b6+851A5Yz33aXZVya3kN0vgf3PDe5Nv419+VsVvMxFbu+nFPEgvsoIP/MoNDy9UJN9g
 df+TtEwQp8+xAjPRrhd9hDqzH4BTU9emyFsk0nkRficpyCGzaVByIPSYoDbWm5dom0PY
 JArCB1CQekd2c7P7d5ayD3rWKAeMJzmvRViTgzBwWG7sAB9/BERp7XLBabuVJ+LohcV0
 /eaA==
X-Gm-Message-State: AOJu0YxVJ+pRUmsEWWtCgKxgrqWFmSFO2E3gA71Zenb+F/cQddyL9tEP
 iGglnYV/0Vy/firZYj4RX9cOon1ZuJLb9+M1FXsfd1TLI7gDBstuL6LJF4mBDYOtCW0t2FqPJOo
 eLH2JwvA=
X-Gm-Gg: ASbGncvuk3i0BGRG6xiujdPnH+JMjotlTDjBw4esd+q6KIczjx+AxTXIsPPZr1q8jMF
 7UADsfUAb5eSxuqfh9yynJkMYsPB7RRFhqHjbs5nTHGcy1birtVkkh+6PqDwuXFj4vUoz9igPf4
 VpqeEXF0Mi/ASnql+C3YnvK35Wkc/A698S3VhC1lE84XUskoisDv2UejkAXfiY47r3WVejM4xNa
 mjVZ8v9FuVClLL40ywOuN+9cG55g8NcCd/LN99R3CPOQtrp2so+z0Gq9kyqC3YyQt7DEpUmC7tY
 PBHr5OKVpG/yn5H0R1x39TukUim0u0hNmjCkHv/7xtpeb4OWWNnMPH/gbDpK/C3K3zQqlDAyq9j
 NbeX//a4m5lHsNYLbsHtBcI8Z6RtV/5IJ7Ygzgju0Ay2JUABLBCl9GW0a8k+5+1ulEghGAet4Ji
 3X0D2+mYFL0cJqbg/T0MDm251D9bFP020aOyNZ8KdmJUSEg0f+znahtQI8YvOR
X-Google-Smtp-Source: AGHT+IGz5BomDyl9x+diwqkJ0q9fDprS8MnsbJGxsWzB8W9brzsye+aT2Ny+r881ANNTzUIGHnTOFg==
X-Received: by 2002:a05:600c:45ca:b0:46e:59dd:1b4d with SMTP id
 5b1f17b1804b1-471178a4bb0mr135239795e9.16.1761080338671; 
 Tue, 21 Oct 2025 13:58:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c428ece8sm10485285e9.7.2025.10.21.13.58.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:58:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc.michel@amd.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 06/19] config/target: Implement per-binary TargetInfo
 structure (ARM, AARCH64)
Date: Tue, 21 Oct 2025 22:57:27 +0200
Message-ID: <20251021205741.57109-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021205741.57109-1-philmd@linaro.org>
References: <20251021205741.57109-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Implement the TargetInfo structure for qemu-system-arm
and qemu-system-aarch64 binaries.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 configs/targets/aarch64-softmmu.c | 26 ++++++++++++++++++++++++++
 configs/targets/arm-softmmu.c     | 26 ++++++++++++++++++++++++++
 configs/targets/meson.build       |  1 +
 3 files changed, 53 insertions(+)
 create mode 100644 configs/targets/aarch64-softmmu.c
 create mode 100644 configs/targets/arm-softmmu.c

diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-softmmu.c
new file mode 100644
index 00000000000..4e1e2f64da1
--- /dev/null
+++ b/configs/targets/aarch64-softmmu.c
@@ -0,0 +1,26 @@
+/*
+ * QEMU binary/target API (qemu-system-aarch64)
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target-info-impl.h"
+#include "hw/arm/machines-qom.h"
+#include "target/arm/cpu-qom.h"
+
+static const TargetInfo target_info_aarch64_system = {
+    .target_name = "aarch64",
+    .target_arch = SYS_EMU_TARGET_AARCH64,
+    .long_bits = 64,
+    .cpu_type = TYPE_ARM_CPU,
+    .machine_typename = TYPE_TARGET_AARCH64_MACHINE,
+    .endianness = ENDIAN_MODE_LITTLE,
+};
+
+const TargetInfo *target_info(void)
+{
+    return &target_info_aarch64_system;
+}
diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-softmmu.c
new file mode 100644
index 00000000000..9b3fdd2854a
--- /dev/null
+++ b/configs/targets/arm-softmmu.c
@@ -0,0 +1,26 @@
+/*
+ * QEMU binary/target API (qemu-system-arm)
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target-info-impl.h"
+#include "hw/arm/machines-qom.h"
+#include "target/arm/cpu-qom.h"
+
+static const TargetInfo target_info_arm_system = {
+    .target_name = "arm",
+    .target_arch = SYS_EMU_TARGET_ARM,
+    .long_bits = 32,
+    .cpu_type = TYPE_ARM_CPU,
+    .machine_typename = TYPE_TARGET_ARM_MACHINE,
+    .endianness = ENDIAN_MODE_LITTLE,
+};
+
+const TargetInfo *target_info(void)
+{
+    return &target_info_arm_system;
+}
diff --git a/configs/targets/meson.build b/configs/targets/meson.build
index a9f6b24ec01..cca2514eb51 100644
--- a/configs/targets/meson.build
+++ b/configs/targets/meson.build
@@ -1,4 +1,5 @@
 foreach target : [
+      'arm-softmmu', 'aarch64-softmmu',
   ]
   config_target_info += {target : files(target + '.c')}
 endforeach
-- 
2.51.0


