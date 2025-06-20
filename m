Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53F1C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk4m-0001KH-Lf; Fri, 20 Jun 2025 18:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfYc-0007Bm-MK
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:29:42 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfYb-0005y2-5A
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:29:42 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a57c8e247cso1811377f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440579; x=1751045379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DFcL1BSkq/LruxlCw9QnVfF9MfhGfPAcj7I1IjOkVu0=;
 b=t2PXHHnC4O1uXvrkHTuEC/HT5SXeQeb4671DH3GWBiF1cUw48cRKistdMTWiIJZJI1
 6ZgRYcbW8ScAjcEWNaaT5cLo1vILkQoRud0DNxBg1psX8FsvLgMX2e+GBdOtes6QL5vn
 wykvLyj7baact8B4+GAmOdxccGmRMgdsn4IKcfgNf7HIEKeiHo1kDP7uafmR8l4ap//S
 frABgHbfjI0sfNxfAkQi/Q2GLg29BxO4+yeRwrsURxJs2rNX2IUz+XTIcubRs65P6oU1
 cgBY0HYp0M2qkO9TiW63mxdcCBXLM2Ggkf3C9Xh3F333oi+HvgTO1NlgWXsYpVRRGQw9
 UczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440579; x=1751045379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DFcL1BSkq/LruxlCw9QnVfF9MfhGfPAcj7I1IjOkVu0=;
 b=Sq3U8MDn82sOla2KftVvRNJumAIeiIrva4EOhVK22qG+FovHv7Vckp3PJIgze3byJM
 hp8QeFd/F5TJ4xeoxkULLFciQcAzS3HCK/iiA/9Rgam0a/IbBAO6/d3qmRUMf6hPvGsZ
 4GgkxmKGjL1GTXTDOOAVQ8TXTuFZl0e4PaUgMLafFw+SVsO1TlpJcbZsVLHdfCEgOUh2
 00AsiMz9sTOvmrr+VCkIZ/17A9r1FqpFu7QO4uAVjHSad+cXC/KjnECK9T/hFk2FqfSZ
 3H3neOFqryJozi2T3jTIQIk5NiRNHxzMywWTXGVGnIsXy4eGXARD+QD47gSBS9FquOn4
 TX7A==
X-Gm-Message-State: AOJu0YxQsn6PHoEy6bGKeu7tepYERWJMV+sl6+Qxp5X1TCD4jrKSnlpi
 kt8RsFr0fqM4WfNmjsB99p1gYtQOQ15xL0LjrEguxFf+1ppAHJi3Xmw+Z4oqk22hcUy+GVdR3Ns
 /DdQgNtLr8A==
X-Gm-Gg: ASbGnctm2u2yh0Mc4SkpaBO/tzv3wYPCvsFov54MX/a67IpKUPxsOgLOPrjbpz0QPYq
 hp8qC/qJkddkVGruil2qOr/0upem5gQeR/uvGs9D34m5I/t5ewNIe0K6vSWTpVg4qFvGipV0fmG
 S8SqHMHr+9DfcajGDnWtS0r5WEm66Xaz+ustMp1rlFPRDDLvjnHo/g67AqyFJhAdH82aDlv7dX3
 5LQ7DXfonK/PUYclq62hUfjvclmjaCNl8wKNxjJMPleuiUgQcWiBi6ls8Mb6PUHVNHG1CkIowhY
 um8MBDucvMjm9SpIKhtA9LPcvq8h/W0wFZzIPtKlnNER8ajL3gal/4Psd/dPhevStmMaKlpFydm
 3PRFw80zSvjwKDwETXGsaZlttOFY8RgYAvz+mV2H6q72A+/MLDLcgI+ds
X-Google-Smtp-Source: AGHT+IFR/l+AcAYO6Q6MA5ygDIntgsuTkjeqxTSfD1UnJaBzzXMuKQtepHRc/A2HpVxe6vcC0tHGZg==
X-Received: by 2002:adf:b605:0:b0:3a4:f70d:a65e with SMTP id
 ffacd0b85a97d-3a6d1317fecmr2498737f8f.37.1750440579266; 
 Fri, 20 Jun 2025 10:29:39 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535e97a795sm66706165e9.5.2025.06.20.10.29.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:29:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 13/42] accel/split: Implement cpu_reset_hold()
Date: Fri, 20 Jun 2025 19:27:21 +0200
Message-ID: <20250620172751.94231-14-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/split/split-accel-ops.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
index 39495fdff14..d4fa07c2dec 100644
--- a/accel/split/split-accel-ops.c
+++ b/accel/split/split-accel-ops.c
@@ -10,6 +10,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/guest-random.h"
 #include "exec/cpu-common.h"
+#include "hw/core/cpu.h"
 #include "system/accel-ops.h"
 #include "system/cpus.h"
 #include "split-accel.h"
@@ -121,7 +122,16 @@ static void split_cpu_common_unrealize(CPUState *cpu)
 
 static void split_cpu_reset_hold(CPUState *cpu)
 {
-    g_assert_not_reached();
+    SplitAccelState *sas = SPLIT_ACCEL(cpu->accel->accel);
+    AccelClass *hwc = ACCEL_GET_CLASS(sas->hw);
+    AccelClass *swc = ACCEL_GET_CLASS(sas->sw);
+
+    if (hwc->ops->cpu_reset_hold) {
+        hwc->ops->cpu_reset_hold(cpu);
+    }
+    if (swc->ops->cpu_reset_hold) {
+        swc->ops->cpu_reset_hold(cpu);
+    }
 }
 
 static void split_kick_vcpu_thread(CPUState *cpu)
-- 
2.49.0


