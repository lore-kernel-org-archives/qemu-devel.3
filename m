Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38E4C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk4a-0000zA-Lt; Fri, 20 Jun 2025 18:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfXU-00075w-6y
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:28:32 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfXS-0005u1-LC
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:28:31 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a536ecbf6fso1272125f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440508; x=1751045308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=STDApn3eyG2Een3rx47c8ZSsM7JmhhtYi1atqcuJuGI=;
 b=hlv5Zoghj/aVYys0l1TfmNqpAuttmx7m7qc0iXW2gRLtRsKJ7/vamo3ihnZAv51kht
 EuhZVNQO+Pns+o0V75gUJT+bBuJ1UpdrY6/yRuoGPDy3Gzcg1hBEQW0+U5LHvOU92UYS
 2qLAOXN2YwtH7iFsXaIuSnV717I0Boj9QpLxSc+LSewQbkbaaTmcXYrinhub9FZWTbpP
 RobMRLxQ/MPIl+9NxPl2QO/9uEEsjjKqDKFA3TI6LNEwfjrecz0d4Jj2p3fn/mqvcSBY
 zouMd5t7ZF+ho7HS+txizGph9GiDqgyXTxA/Gw+womN5Cn+H5IgzMF6rQMuLZ1fROL9Z
 AyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440508; x=1751045308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=STDApn3eyG2Een3rx47c8ZSsM7JmhhtYi1atqcuJuGI=;
 b=QlWDiSj+INIkKiPjVcia24EMLFvEPw1n7gHTLMyVThe8+B5RalYVOPZzrs1yd3s9LB
 z20n80ezfe8KCuxtIhZUB1wiFV1+1qY4cpFkTQauN8GBM6ESRI6h9zie6Ffl/hfC6XXs
 FULm9DdZ+CC5gf/cfOBVLCBAADoAFIa/p/ohXAd75BZPEPEWJd/RANCHM3M2v3lD/3C2
 ta3YPusvZBXYJztWS6lK1K++S0e0UR4+KmZf9SZlK96Zy7RGNnkHkfW8BO1ZuOpqYIEt
 bgZbldU5Fb2BVkIcv7K77fD66a1OqNBVhLUaEeXC4W2HEunlVZ/IrTVyWAo+LuEH/ky/
 0aog==
X-Gm-Message-State: AOJu0YxUgyL98ZQZ/ozo6trQ9mnHup9VVnlhv6xqkrJKnjTV6mCvkR3Y
 +1FeHTWpu8A9TGIMaiqRKtQ21wXR5YPZI1Rb6Ut+rfgbM9kGzv/gjQKNFXUrJVr88GNaxRjcV++
 YZAKsfaTD5w==
X-Gm-Gg: ASbGncvDEumSMnCtQB6n5jMRwcK1deIYpEj1KgDauWF1+7t9m4Fn5KDhljnh1GlN/sJ
 3NbZeraPzZf/VjzddCC6ADAwC7nTPFIqJTdXS5DR/nj0A4aUsGeZI4mW1zib8dhkOnGrh7jAWi4
 q1nyU12RI4HYBxylsM7p+bQrOviEQJ4LteRVGIyn379aI6AhXmiwX5X1Ep6ryjOAuYzsIvXaaH5
 2HmQLWHWB+/WA986Dl0EFsXu9seG0oO0+HsJpMdn5o7JcLIhzk5a4y4aG+ezL+LHSBgaPf0aZ3J
 HD4gvUFpbfA6z6dMma9dBD1RXplwqCHYyWh2xVaYRb2wB/z1KYTj0ToF+sNvJ7PtPYU9TndSQwq
 EdNr3fLKi7MGhtP+l16+9rka2wwwd0uMljfrMxUhG6pD7vDVqJpA61zKC
X-Google-Smtp-Source: AGHT+IHB3mVE6Ruqg0QMkCjhr801J+dk5vYQSO5tAz8i2qrqsLLTbK+g3FGhVhv341WIcSlzQ2syfg==
X-Received: by 2002:a05:6000:4021:b0:3a6:d145:e2cc with SMTP id
 ffacd0b85a97d-3a6d145e448mr3121916f8f.15.1750440508210; 
 Fri, 20 Jun 2025 10:28:28 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535e98b66asm64194555e9.17.2025.06.20.10.28.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:28:27 -0700 (PDT)
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
Subject: [RFC PATCH RESEND 04/42] accel/split: Implement accel_init_machine()
Date: Fri, 20 Jun 2025 19:27:12 +0200
Message-ID: <20250620172751.94231-5-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
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

Force to TCG + HVF for now.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/split/split-accel.h |  3 +++
 accel/split/split-all.c   | 30 +++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/accel/split/split-accel.h b/accel/split/split-accel.h
index cc825a92a6d..19fb530f207 100644
--- a/accel/split/split-accel.h
+++ b/accel/split/split-accel.h
@@ -33,6 +33,9 @@ struct SplitAccelState {
 
     AccelState *hw;
     AccelState *sw;
+
+    char *hw_name;
+    char *sw_name;
 };
 
 #endif /* SPLIT_ACCEL_H */
diff --git a/accel/split/split-all.c b/accel/split/split-all.c
index c86d0e8583a..7cbe32ea768 100644
--- a/accel/split/split-all.c
+++ b/accel/split/split-all.c
@@ -8,13 +8,32 @@
 
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
+#include "hw/boards.h"
+#include "accel/accel-internal.h"
 #include "split-accel.h"
 
 bool split_allowed;
 
 static int split_accel_init_machine(MachineState *ms, AccelState *as)
 {
-    g_assert_not_reached();
+    SplitAccelState *sas = SPLIT_ACCEL(as);
+    AccelClass *hwc;
+    AccelClass *swc;
+
+    swc = accel_find(sas->sw_name);
+    accel_init_ops_interfaces(swc);
+    hwc = accel_find(sas->hw_name);
+    accel_init_ops_interfaces(hwc);
+
+    sas->sw = ACCEL(object_new_with_class(OBJECT_CLASS(swc)));
+    sas->hw = ACCEL(object_new_with_class(OBJECT_CLASS(hwc)));
+
+    accel_init_machine(sas->sw, ms);
+    accel_init_machine(sas->hw, ms);
+
+    ms->accelerator = as;
+
+    return 0;
 }
 
 static void split_setup_post(MachineState *ms, AccelState *accel)
@@ -59,6 +78,14 @@ static void split_get_stats(AccelState *as, GString *buf)
     g_assert_not_reached();
 }
 
+static void split_accel_instance_init(Object *obj)
+{
+    SplitAccelState *sas = SPLIT_ACCEL(obj);
+
+    sas->sw_name = g_strdup("tcg");
+    sas->hw_name = g_strdup("hvf");
+}
+
 static void split_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
@@ -79,6 +106,7 @@ static const TypeInfo split_accel_type = {
     .name = TYPE_SPLIT_ACCEL,
     .parent = TYPE_ACCEL,
     .instance_size = sizeof(SplitAccelState),
+    .instance_init  = split_accel_instance_init,
     .class_size = sizeof(SplitAccelClass),
     .class_init = split_accel_class_init,
 };
-- 
2.49.0


