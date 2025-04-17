Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E55C369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 16:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5SWC-00006J-Ms; Thu, 17 Apr 2025 12:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5SW1-0008TC-Vm
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:55:07 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5SVz-0003g9-VR
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:55:05 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso8157325e9.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 09:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744908901; x=1745513701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uJ8iU5RvZsXIn9yVLIzKm4nuSmrz0M49050hDPScekQ=;
 b=WTbpOeZeFEPiXsKhhvpEqWClLhA2KigLGvdYUIbKsfxNw9ZO6ETDashq9yQZkzrOY7
 mwO56ZbGxN++NrNlj7qBJbMH/7DV3HM+gXbsY5R9sWkMJT4ig3vIRKx8CLn4SSTnUteY
 S+BiKubiezZ05peE3UHBSWeyrHWTFOgRR7B+enJfaKvVnqq6s4ib32w7MvHEXtqJjC2Q
 HJAb70UAiVC8Ie3EQ4ffS0bbaGqn2IU8gLL9mKTSOSiOYoGVP2cSapgrDuB6SZ6aUerM
 x41VkNId52L1/+9cr8ue1UCfpggXccKrU3waOXJAhaCsCp0bt9F9UNBG1kr/y4xCaR6O
 zpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744908901; x=1745513701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uJ8iU5RvZsXIn9yVLIzKm4nuSmrz0M49050hDPScekQ=;
 b=WFevZzlUbYHYTLydkT4QEkmuLbZVduDijNnofGZOPPqzNuyxsiSP+m+9Age5f2N8rr
 5PSUoaYmPLxyxJbzAajFL870peNjBjAmTM5e7VpiENSr/jqHPSOh14lfN20M4sstfm6c
 ngfcLon/WhDvq/qU1kEld97b7yWaU5EfyUdWRIE5X8Gy9TP36UaIJX+35qL90Rj3qXsA
 mr6zAtfHC84YxiK9AGlyq/B/YLozBY3Tz3U8F1F32YQEqBhaVzGhoUvZP09HTNR79G8j
 4OQzBlV5g1+b38pZzOSazpBX1Qwwe8FkdwjMaCN71FZg+qdh3eR2vVql88WgZztadfEx
 /DkA==
X-Gm-Message-State: AOJu0Yy3Loub9HBCFDXHlNmbBfNEsNjs3ZsBG9pvObZpx98f33lQkyNq
 GLg2y1xPjMzEG9nmUg9/fxhPq9fCGvVUyDHrbsS4fvWIukHHypVJA7boPBGvLJWFijbJcwJsJPW
 X
X-Gm-Gg: ASbGnctgycjZadiea+2GDEVag5cHWUmbtBpnfukE5E7Y4DNOsluHGOZz4xfEcNr/2I1
 PdAZvgkoF++ZcR/Fbb0ZqGHrii/2znNZXEjLj37Ff0JABJULR58DIO3GW24of4n0CQ7odVSlYQ+
 semRGraSQoxr6H95iqfM9Q1AvBNSiUTD5cQMt4ntEZPUmR11jTaz6zMiHsZ3fnz4xQL0QE4xhc9
 lItt1PnoXXWywsUK4RK5xJqOG11v2l+E9j1ibMCaKsqCxtXcOaP8XZNRXZf1FvmCqfuf2H4jfJw
 woOo4WkpIBASklNPzKTs2y8TvCmt3Tnmixr4InCQ1lFZD9UmFAEwAXFhMHBGOtF0gZ5IO7xE2aX
 AwowAyWDLpWWmrpglJCiSyzdb6A==
X-Google-Smtp-Source: AGHT+IH99FHNb5CMWzg6EgZQorRgLS5CGQ/qhAThmVSlJDo9p8aGTl36XTecoJSPdSNiY4ODmLbkFg==
X-Received: by 2002:a05:600c:1c04:b0:43c:fb36:d296 with SMTP id
 5b1f17b1804b1-4405d6ab656mr47922255e9.25.1744908901121; 
 Thu, 17 Apr 2025 09:55:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b4f2444sm62438605e9.17.2025.04.17.09.55.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 09:55:00 -0700 (PDT)
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
Subject: [PATCH 6/7] accel: Make AccelCPUClass structure target-agnostic
Date: Thu, 17 Apr 2025 18:54:29 +0200
Message-ID: <20250417165430.58213-7-philmd@linaro.org>
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

Move the target-agnostic parts of "accel/accel-cpu-target.h"
to "accel/accel-cpu.h".

Doing so we need to include missing "hw/core/cpu.h" header
in "accel/accel-cpu.h" otherwise we get:

  include/accel/accel-cpu-target.h:39:28: error: unknown type name 'CPUClass'
     39 |     void (*cpu_class_init)(CPUClass *cc);
        |                            ^

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/accel/accel-cpu-target.h | 12 +-----------
 include/accel/accel-cpu.h        | 23 +++++++++++++++++++++++
 accel/accel-target.c             |  1 -
 3 files changed, 24 insertions(+), 12 deletions(-)
 create mode 100644 include/accel/accel-cpu.h

diff --git a/include/accel/accel-cpu-target.h b/include/accel/accel-cpu-target.h
index 37dde7fae3e..6feb344e29b 100644
--- a/include/accel/accel-cpu-target.h
+++ b/include/accel/accel-cpu-target.h
@@ -21,21 +21,11 @@
  */
 
 #include "qom/object.h"
+#include "accel/accel-cpu.h"
 #include "cpu.h"
 
 #define TYPE_ACCEL_CPU "accel-" CPU_RESOLVING_TYPE
 #define ACCEL_CPU_NAME(name) (name "-" TYPE_ACCEL_CPU)
-typedef struct AccelCPUClass AccelCPUClass;
 DECLARE_CLASS_CHECKERS(AccelCPUClass, ACCEL_CPU, TYPE_ACCEL_CPU)
 
-typedef struct AccelCPUClass {
-    /*< private >*/
-    ObjectClass parent_class;
-    /*< public >*/
-
-    void (*cpu_class_init)(CPUClass *cc);
-    void (*cpu_instance_init)(CPUState *cpu);
-    bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
-} AccelCPUClass;
-
 #endif /* ACCEL_CPU_H */
diff --git a/include/accel/accel-cpu.h b/include/accel/accel-cpu.h
new file mode 100644
index 00000000000..9e7eede7c3c
--- /dev/null
+++ b/include/accel/accel-cpu.h
@@ -0,0 +1,23 @@
+/*
+ * Accelerator interface, specializes CPUClass
+ *
+ * Copyright 2021 SUSE LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef ACCEL_CPU_H
+#define ACCEL_CPU_H
+
+#include "qom/object.h"
+#include "hw/core/cpu.h"
+
+typedef struct AccelCPUClass {
+    ObjectClass parent_class;
+
+    void (*cpu_class_init)(CPUClass *cc);
+    void (*cpu_instance_init)(CPUState *cpu);
+    bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
+} AccelCPUClass;
+
+#endif /* ACCEL_CPU_H */
diff --git a/accel/accel-target.c b/accel/accel-target.c
index 6fa5c3ef04e..769a90230bf 100644
--- a/accel/accel-target.c
+++ b/accel/accel-target.c
@@ -27,7 +27,6 @@
 #include "qemu/accel.h"
 #include "qemu/target_info.h"
 
-#include "cpu.h"
 #include "accel/accel-cpu-target.h"
 #include "accel-internal.h"
 
-- 
2.47.1


