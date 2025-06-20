Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3B7C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk4Z-0000wC-6w; Fri, 20 Jun 2025 18:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfXF-00074s-8x
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:28:17 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfXD-0005tF-MI
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:28:17 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-442fda876a6so18873375e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440494; x=1751045294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NJuMvl+/4K8mvxCGrokyEcy519OHQ9uSoH06dTVN0BU=;
 b=tX3Mt4WbSOQyyiy4TeewKeUc5G1JIySriHG7Cym7Br62HmN3wAhL0xNf4z6wdoHukd
 4SbhGB9lQ9EGz+QgtXSAYdSMtgNcnehMTOPy933GV+trL3fTDEOLpXOqLXsbGDwqo96p
 AGSaUDQKaRQZgocXg0r+iymj7eclyBuuoSFhdgScVa4urBlSgRD2yeVwRxiPllyKeKQd
 XS3UGSHUKRyoxfZyEjR2wib20IDbGv8J/9iJU7ROGC4kyAWE2cjecZrYCwF7o64hfp9F
 Fy/1XjXGGa0hVZurXIYyOHaIloOYb+lBPsdgBKZQqTsRt7fHU1zZurugS66BGomSacD9
 A8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440494; x=1751045294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NJuMvl+/4K8mvxCGrokyEcy519OHQ9uSoH06dTVN0BU=;
 b=eRHTrgy5wZdMLNsf3Q+HdTiUc03rl8Jt4h/QzrFmkQg7ZMAL8MXAPQRhO+J/rX5xrd
 12tIfjChZGBOgBaYbPwYj89dLizt8fJ9dWos7itnBLzjE1Oa2L9yEQKjkxQXq9zg3hyI
 4rOdMW27Z9XTilyHnOWWMNiQ1j26ErWKEr3+UTvv9adx2ysS47Rb0GeNzU6wqUVZssZj
 PIyg9K9nqVWLzxqNOgm7KY7TFBUymh1Ii27U26b0F4UPdZrbb3fspq5NW5FzK7AGACAJ
 adkxCPjfL5IMSWIp0agfQ2DGOKg2EBTawtUB3D3Qn0QNGcdEWqFI/fpSIKBwqQyuumXr
 XntA==
X-Gm-Message-State: AOJu0YwpbCti2+L+9ZAfIJBC79Vqp0gL/l0z/w0/5bYWIu8pGUkTVyKF
 o4FBgqrBoxnzRC2L6wMrXm8Zel04a8vg+t/Sq8cFHtU4I5yLW4+wNUT+xolUJ53xiFYj4GIn/X6
 J9uQAEegwHQ==
X-Gm-Gg: ASbGnctuUXP7Ty4rH8DwuLYpcMIFHZ9tUoEobGy3NwR7QIa/aFLjJoqp2NENEYT7NrW
 NzYFiK9pdK7vrYGcYB0SMz/qtPERtLCtgC4/8Bl7doI+X/FfZwhWQzj9sKz5nXBgC9vkom0xfxQ
 pfq5BSFtYgpOrO5xsHFtclJWN7EWCDSXqoEMKZO5fAfvFj5QV8bpECAIO1q9IP8LB2/V3FZYEpw
 4JlduwwjZ9+wHFldv82gIhgFZDpZCrp/93KPru2k6ChBST1uoo9Sv80r8etfVc5F9bU1foWQYxN
 WzXtdlHPvqHtg9Kn6SttDonbeW//sk7GHyAumVeoXHKZpW6Sd7C500/0tuO7Vk3B4nl97X2YQsx
 Tb9nUaMcnixT9Iv8T0SwISA8OnUo20XNxiZkd13SA7aLek6ASMJ4c5Lfy
X-Google-Smtp-Source: AGHT+IHEqGiEb2uv4UDaIfSmOBEm1Nk4INSoDmU4JjtM5pvCpl6nGgUKAuE/I7N0mjKXGHeyDWeijg==
X-Received: by 2002:a05:600c:8694:b0:450:cea0:1781 with SMTP id
 5b1f17b1804b1-45365c36aa4mr27050755e9.16.1750440492450; 
 Fri, 20 Jun 2025 10:28:12 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d128cf7asm2562612f8f.100.2025.06.20.10.28.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:28:11 -0700 (PDT)
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
Subject: [RFC PATCH RESEND 02/42] accel/split: Define SplitAccelState
Date: Fri, 20 Jun 2025 19:27:10 +0200
Message-ID: <20250620172751.94231-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
 accel/split/split-accel.h | 38 ++++++++++++++++++++++++++++++++++++++
 accel/split/split-all.c   |  5 ++++-
 2 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 accel/split/split-accel.h

diff --git a/accel/split/split-accel.h b/accel/split/split-accel.h
new file mode 100644
index 00000000000..cc825a92a6d
--- /dev/null
+++ b/accel/split/split-accel.h
@@ -0,0 +1,38 @@
+/*
+ * QEMU "split" accelerator (HW + SW) state
+ *
+ * Copyright (c) 2025 Linaro Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef SPLIT_ACCEL_H
+#define SPLIT_ACCEL_H
+
+#include "qemu/accel.h"
+#include "qom/object.h"
+
+#define TYPE_SPLIT_ACCEL ACCEL_CLASS_NAME("split")
+
+typedef struct SplitAccelClass SplitAccelClass;
+DECLARE_CLASS_CHECKERS(SplitAccelClass, SPLIT_ACCEL, TYPE_SPLIT_ACCEL)
+
+typedef struct SplitAccelState SplitAccelState;
+DECLARE_INSTANCE_CHECKER(SplitAccelState, SPLIT_ACCEL,
+                         TYPE_SPLIT_ACCEL)
+
+struct SplitAccelClass {
+    AccelClass parent_obj;
+
+    AccelClass *hw;
+    AccelClass *sw;
+};
+
+struct SplitAccelState {
+    AccelState parent_obj;
+
+    AccelState *hw;
+    AccelState *sw;
+};
+
+#endif /* SPLIT_ACCEL_H */
diff --git a/accel/split/split-all.c b/accel/split/split-all.c
index 7e308f3c1e7..6bc95c7a7c8 100644
--- a/accel/split/split-all.c
+++ b/accel/split/split-all.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
+#include "split-accel.h"
 
 bool split_allowed;
 
@@ -64,8 +65,10 @@ static void split_accel_class_init(ObjectClass *oc, const void *data)
 }
 
 static const TypeInfo split_accel_type = {
-    .name = ACCEL_CLASS_NAME("split"),
+    .name = TYPE_SPLIT_ACCEL,
     .parent = TYPE_ACCEL,
+    .instance_size = sizeof(SplitAccelState),
+    .class_size = sizeof(SplitAccelClass),
     .class_init = split_accel_class_init,
 };
 
-- 
2.49.0


