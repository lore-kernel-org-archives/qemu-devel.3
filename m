Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A180EC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u84xI-0004Yh-He; Thu, 24 Apr 2025 18:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84xF-0004YP-HD
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:22:01 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84x9-0000ye-U4
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:22:00 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39ee57c0b8cso1667633f8f.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745533314; x=1746138114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yIUYggzBbwK532QnEX63ouNuUzspZ2vfdklTznzqOpk=;
 b=GdYRwBUecHV1m5gBPRvKqaRp8FuPD3P+CBajcCt2Z4Z2Es3iG+a9wswZInXWmTH6ey
 M1g6m3zu2OnlxYi54K0c6tWiHkuDNa12ELPo1mocEb1owIVB10f2mvVz4x17CStimB84
 4EV8+f79Ag5atWsAh7AV01iH4wx9D7kK9nUneGCuH/KTFktKkHrGiUXWDHcUdIDM63ER
 LAhGB0LsR+AbH1A372q/DdB72T85ZeGZkzJoFm3x9bePY3JtlHQdrmLDpEU5LEicXKvX
 qvpdTMHb22MfuGJUaHgu7xkc4fvO99ghnHzVrEHgIjmeFjrrjjUVJgBHGejAOJUxwZpj
 Ze/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745533314; x=1746138114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yIUYggzBbwK532QnEX63ouNuUzspZ2vfdklTznzqOpk=;
 b=dPkLUzWAyVExhgXfhorVCPYn9YibB8zdf82NJ8OmSWodHBL8fFddqEMu4rdAWKD4fK
 5tee5upLbbexj5o/Vu/ZjbkQDXuh7pXHGaRU1P+jGfKQ2ryW02nyv1kM6TIMiWAcdTWP
 sdr0/ppNCdQm9Ld5XhX5Y1OLjFVpUh4tZEmHxtLjxJjV4j6j2xSxKm8/qwl9ee+h5Roj
 PJ6QNPyzsA8pKpalRN0AXbAMOHcl2wHqa08KgiRP/95ZWHYullC36Vl1C+E+Gp4cNbil
 mH82IVICvl7zaN69GBVxCYvye6P+pTnRsh0RVlWifPf0ljLa+lUhkLiivvSjsT9oPfbs
 M9jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJCsJVMlefdSqQKq3mN/e4MCwDeRhrNq05FvFLcUYQnD+3rkcgsJohuT5HIrdQO6l0PyV8tSChILS3@nongnu.org
X-Gm-Message-State: AOJu0Yz/TfEtzkdLNQKGiJpZl8amw3dxOGp3Lh5dsIw6ud5iiXEiq/+p
 UrLL/NUOwYBvGe5cX3vzdCD+d9WxUPvqCyK5VGsnCS/Cz14t0B2Xt0V7Lp68kSI=
X-Gm-Gg: ASbGncvmAooNkLiHZTC3AqrOZPJTQgak6H+bECfgltLk7qm9F3MDsSR8aoq/gdJfLC9
 0XRD9AyiyfAPYFjLt7m/RJ5iJid2eSTDEPmFga28gJpGP/7W8cVadLChPKY6Y4/y2B3o/3U0WHX
 /Nam4bUisqTg00DoRpmmPJKbSx1bMwBGiZyI4rpuXdpVzm9Qrz5TQFQmfM86OUI6O7n0f6x4kud
 /0NX2cwrwS5mgSUofH5yLiazvnqcNssI5VgG3F27wZZg9ibPc++mZD2zDOIgaOpzqu5fjA8mQKy
 LmIb1PY6UggSmHJ1s3OxSB3wZ0Xs3Y176obqdefDrDv3z1sUEVE3LB+ZYw5RShN7X9GVUyLfvDf
 FzotPu31vXJKArcg=
X-Google-Smtp-Source: AGHT+IHkoFqCFcgAlLWpCjkwv0YkFOcKW0MLBT99LVCGgXkYSCfCfJpXQi8UTS0Md3V2exH9PZ2cBA==
X-Received: by 2002:a05:6000:22c4:b0:391:4914:3c6a with SMTP id
 ffacd0b85a97d-3a072acc1aemr777112f8f.29.1745533314304; 
 Thu, 24 Apr 2025 15:21:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca497esm512937f8f.24.2025.04.24.15.21.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 15:21:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v5 08/21] hw/arm: Add DEFINE_MACHINE_[ARM_]AARCH64() macros
Date: Fri, 25 Apr 2025 00:20:59 +0200
Message-ID: <20250424222112.36194-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424222112.36194-1-philmd@linaro.org>
References: <20250424222112.36194-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

A machine defined with the DEFINE_MACHINE_ARM_AARCH64() macro
will be available on qemu-system-arm and qemu-system-aarch64
binaries.

One defined with DEFINE_MACHINE_AARCH64() will only be available
in the qemu-system-aarch64 binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/machines-qom.h | 13 +++++++++++++
 target/arm/machine.c          | 12 ++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/hw/arm/machines-qom.h b/include/hw/arm/machines-qom.h
index a17225f5f92..6277ee986d9 100644
--- a/include/hw/arm/machines-qom.h
+++ b/include/hw/arm/machines-qom.h
@@ -9,10 +9,23 @@
 #ifndef HW_ARM_MACHINES_QOM_H
 #define HW_ARM_MACHINES_QOM_H
 
+#include "hw/boards.h"
+
 #define TYPE_TARGET_ARM_MACHINE \
         "target-info-arm-machine"
 
 #define TYPE_TARGET_AARCH64_MACHINE \
         "target-info-aarch64-machine"
 
+extern InterfaceInfo arm_aarch64_machine_interfaces[];
+extern InterfaceInfo aarch64_machine_interfaces[];
+
+#define DEFINE_MACHINE_ARM_AARCH64(namestr, machine_initfn) \
+        DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, \
+                                       arm_aarch64_machine_interfaces)
+
+#define DEFINE_MACHINE_AARCH64(namestr, machine_initfn) \
+        DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, \
+                                       aarch64_machine_interfaces)
+
 #endif
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 978249fb71b..193c7a9cff0 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -8,6 +8,7 @@
 #include "cpu-features.h"
 #include "migration/cpu.h"
 #include "target/arm/gtimer.h"
+#include "hw/arm/machines-qom.h"
 
 static bool vfp_needed(void *opaque)
 {
@@ -1111,3 +1112,14 @@ const VMStateDescription vmstate_arm_cpu = {
         NULL
     }
 };
+
+InterfaceInfo arm_aarch64_machine_interfaces[] = {
+    { TYPE_TARGET_ARM_MACHINE },
+    { TYPE_TARGET_AARCH64_MACHINE },
+    { }
+};
+
+InterfaceInfo aarch64_machine_interfaces[] = {
+    { TYPE_TARGET_AARCH64_MACHINE },
+    { }
+};
-- 
2.47.1


