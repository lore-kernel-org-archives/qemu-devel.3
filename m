Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D820C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHiI-0002hI-Tx; Thu, 03 Jul 2025 07:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHfl-0006oz-Ew
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:10 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHfa-0003YU-1N
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:03 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-453634d8609so56317125e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540396; x=1752145196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1uXIn8FF+VzmPqfa1+8428fM/RDSExpMjk/8h5CzpzY=;
 b=gqLLTZCne7UPaTuScDbalkPjfuTqt/ISlCuY39TFtvnTSWya4HYXQfnTD6ftoDs62B
 6c/03AjqPyABK6IBdbERTO5GaoQOxTB9PMbApVQvE5QLbyY/GyWn6SWF5lgrxpXi34p4
 vadWM7xl9aWHW+NOOmm2RelCnKNTC+OULU2dG7gsT8djHcvQyz+Nsj9hJaeXK9e9wQmU
 MCYE6QCLgmmY8qRSF0vHaOUbHTQFCmIJqcfljCpLFacMPH0Y05Cq8l6dOseglpadYBCY
 FQmlKKtx6RsistuY7Qm6mW7PI9bFKItpoAzG/LnLkmW+5FL1XBfTJiSHRskMwsIBAlY7
 Z50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540396; x=1752145196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1uXIn8FF+VzmPqfa1+8428fM/RDSExpMjk/8h5CzpzY=;
 b=cKZs3hIztXO02+2jxCqNXoF/jKjR4vM31yXV+tB4uq4NYfoBG0KLh9axcxQu4Is4aW
 ubVGIDTa+3xmZPdSVOu14e8AeT2TFVprkS2Lb6bfq+89wHkfa7rg+pJRtx4oLyDt4Ba+
 3vASF5a4xiXrHjZCUnw38n7QKrnRNI78CQ16VRu+eHWfj0L2w8HTINJtNzudanSmdHD6
 HPwDc5GztfrCIR8c+Lm5jUSKOJQKtq/hPhlVtfkMIjyOn+XfiDpPn9gfBRM8TFmrJvTD
 l00ellpMXQByNLo6D2MnO5nqAle6eCdX4oilhNr0EeefNIADQKCwG7z+rsc1Md0Dk5P1
 YV4g==
X-Gm-Message-State: AOJu0YzwQEo7nCm9I9P/IVo76BDCUX5YEGfj976ZUPSSCQTbe7+L7ydc
 j/0G9UYw4NSewtuM4IHI9bovQDBvZFpzn/rpQbUNvKzdLqrBB7zRVwXsTeFQU5/pdcDnOu0UVpV
 YcJJK1FA=
X-Gm-Gg: ASbGncv16HWH2go3R10wIuU5NxDGmg4DevSYC62EbDD4E9sBiQLkbDlhAxmOGOlSBzd
 NQrkJy3gqHyP/PwWVS2Ht057XMlJZA2oFy/3P4aUkqevHiW9zeC2SGLh+bR0/HGnXUEghzdE7Ht
 y99vbRQp6i8AbEjdasm+DTgnQrAHcSvD5KSi1Dnw38edg/TmvwZOCS9dFxysQePcvMelExOwX9C
 dhaokMshLkstl5//iQ/6sGIjokNk5jgeHFBCAkVibmBrrQuSR/wQs+GxWHZd5i+mJrRcila5BQ9
 tLDHFXaPyDdajl5v4OVl0GnXgQm8Ty+1/j7Q3QYh0HAyVlmchl5fZHQWoxa42clb1gu8I2lV3GK
 /jji2/LVyrko=
X-Google-Smtp-Source: AGHT+IGkl7DBEVSrsarAakeoJRDOUyErzjUrrwRi8jgXThFkNvPPbLQTGnxMgTtTTTxzMt5tQq0f5g==
X-Received: by 2002:a5d:6f02:0:b0:3a5:2575:6b45 with SMTP id
 ffacd0b85a97d-3b32f666124mr2129038f8f.48.1751540396119; 
 Thu, 03 Jul 2025 03:59:56 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fadf3sm18662688f8f.34.2025.07.03.03.59.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:59:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v5 48/69] accel/dummy: Extract 'dummy-cpus.h' header from
 'system/cpus.h'
Date: Thu,  3 Jul 2025 12:55:14 +0200
Message-ID: <20250703105540.67664-49-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

'dummy' helpers are specific to accelerator implementations,
no need to expose them via "system/cpus.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/dummy-cpus.h    | 14 ++++++++++++++
 include/system/cpus.h |  5 -----
 accel/dummy-cpus.c    |  1 +
 accel/qtest/qtest.c   |  1 +
 accel/xen/xen-all.c   |  1 +
 5 files changed, 17 insertions(+), 5 deletions(-)
 create mode 100644 accel/dummy-cpus.h

diff --git a/accel/dummy-cpus.h b/accel/dummy-cpus.h
new file mode 100644
index 00000000000..d18dd0fdc51
--- /dev/null
+++ b/accel/dummy-cpus.h
@@ -0,0 +1,14 @@
+/*
+ * Dummy cpu thread code
+ *
+ * Copyright IBM, Corp. 2011
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef ACCEL_DUMMY_CPUS_H
+#define ACCEL_DUMMY_CPUS_H
+
+void dummy_start_vcpu_thread(CPUState *cpu);
+
+#endif
diff --git a/include/system/cpus.h b/include/system/cpus.h
index 3226c765d01..69be6a77a75 100644
--- a/include/system/cpus.h
+++ b/include/system/cpus.h
@@ -7,11 +7,6 @@ void cpus_register_accel(const AccelOpsClass *i);
 /* return registers ops */
 const AccelOpsClass *cpus_get_accel(void);
 
-/* accel/dummy-cpus.c */
-
-/* Create a dummy vcpu for AccelOpsClass->create_vcpu_thread */
-void dummy_start_vcpu_thread(CPUState *);
-
 /* interface available for cpus accelerator threads */
 
 /* For temporary buffers for forming a name */
diff --git a/accel/dummy-cpus.c b/accel/dummy-cpus.c
index 867276144fa..03cfc0fa01e 100644
--- a/accel/dummy-cpus.c
+++ b/accel/dummy-cpus.c
@@ -17,6 +17,7 @@
 #include "qemu/guest-random.h"
 #include "qemu/main-loop.h"
 #include "hw/core/cpu.h"
+#include "accel/dummy-cpus.h"
 
 static void *dummy_cpu_thread_fn(void *arg)
 {
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index 8b109d4c03b..2606fe97b49 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -24,6 +24,7 @@
 #include "qemu/guest-random.h"
 #include "qemu/main-loop.h"
 #include "hw/core/cpu.h"
+#include "accel/dummy-cpus.h"
 
 static int64_t qtest_clock_counter;
 
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index ba752bbe5de..f412ea346bb 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -18,6 +18,7 @@
 #include "hw/xen/xen_igd.h"
 #include "chardev/char.h"
 #include "qemu/accel.h"
+#include "accel/dummy-cpus.h"
 #include "system/accel-ops.h"
 #include "system/cpus.h"
 #include "system/xen.h"
-- 
2.49.0


