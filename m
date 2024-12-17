Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C84E77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 17:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNbF7-00084n-97; Tue, 17 Dec 2024 12:20:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEz-00080j-Io
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:20:13 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEn-0006Fk-9j
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:20:13 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-385ef8b64b3so4893963f8f.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 09:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734455997; x=1735060797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zJbnqmRHNrJNWStxjTRA7dO/k15ETO+R8z1PbejIlpc=;
 b=PLa0BL+Q3yHWuhJ031wBUrkKvRfDczf7jTRDw1oj4X59R+7Rhnzomhq0OE7nK3H2IF
 96l60IVrGOxn3R0Z2WDh0Ki0VOALiEN0kFgg7AoyupGDlClZJ1szHnDrWhwVQ12yYCEi
 bNyUBD2qZNP4T3Ee8WlaSFJyMkIZOESpuoKmWOu+fcAA1oknTb125G1w0GeeCgeZOHak
 zw9VVvIbKImi6Axd5DANuxLQ8lafdxUwrx9nezyGD/8BcDeLaY7jla2FCIkY9FMDdbk3
 2HSBcPSnGeztraOXzopCon/0QVo1RNJeDrsYD2ta4WzE7gpmxzOkZ67E2Qn0/uNxw4rG
 +XkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734455997; x=1735060797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zJbnqmRHNrJNWStxjTRA7dO/k15ETO+R8z1PbejIlpc=;
 b=lpEaJ3TtrkUYXxNW7lq/F0Alvyg+zHflQWB33g5qu9505sOMBlVgjJFIvNnitiKw1M
 4BuEH5dNvkaASGIwqDgAQxrRfq9/4BSznnywsX+glz4tLPfAur0xsA+gnQrMekXXFV6X
 IESFTtFPvuMw33/Y+ZVzdye97q8pUXGj0gyERE6EDDOLuwRIZPtmQdgFugvwNT5Kb/+l
 U5JOw3d00lsQXxstRqKGWSo08qlNivTglqWVTgQBG3v1gbD9owsR3m9tNgXdUeKLl/+4
 1ocB6WKqQia34Uw3qBWQ9iQrhz2YEFnY6hZ/cwDxDFQEaMNSHdcu7LjBmdy2nzSx9xkd
 iUJg==
X-Gm-Message-State: AOJu0YxuBgw5mGTKb+zi8vojFIge3Ns0DSIxpPv9hbYEokivZyCrGul1
 k4zBKDtVX1tnVOcAFIHNAUpxuzOjZqpitnpHc/Cz8KyHj6KoBL1OH6BBZ0h3rfE4fzH0mXGFqKq
 X
X-Gm-Gg: ASbGncu3G41QIjRc2ssHWHVmFgT8A8KY3guLeXJeRyzfvqfFzvXpT7HVqX4xfUmbjhi
 g7WenFVnd2DZyUj/ByQAar0t/uJQW972nCM7bT/ow35vG+7A0aXSIXUCsdT3YtU3rKduwu1Xs+l
 u+KladK6G6xIfvTaahTeHtyJaecaxSVFJfHBxG9tcJFnoTY8F3cr1aq3LPEZLCe2yj7EpIgMOZm
 Z4gRteEDKpTiMBvO0mjztK0RJgNcU7vvTa2cSlIzd4MIz7BUjFsrB7cjK0debw=
X-Google-Smtp-Source: AGHT+IEZDRALqr/t8Qy0U7nNaSxr/TCAD+kdafIs9Laaiks643hoN2W7XG3VBrhgSVoTj1Vtrt/YlA==
X-Received: by 2002:a05:6000:4012:b0:385:fc70:80e with SMTP id
 ffacd0b85a97d-38880af13b2mr13931161f8f.3.1734455997081; 
 Tue, 17 Dec 2024 09:19:57 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8016389sm11569728f8f.32.2024.12.17.09.19.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 09:19:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/19] tests/tcg/aarch64: add system test for FEAT_XS
Date: Tue, 17 Dec 2024 17:19:35 +0000
Message-Id: <20241217171937.3899947-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217171937.3899947-1-peter.maydell@linaro.org>
References: <20241217171937.3899947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Add system test to make sure FEAT_XS is enabled for max cpu emulation
and that QEMU doesn't crash when encountering an NXS instruction
variant.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20241211144440.2700268-7-peter.maydell@linaro.org
[PMM: In ISAR field test, mask with 0xf, not 0xff; use < rather
 than an equality test to follow the standard ID register field
 check guidelines]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/aarch64/system/feat-xs.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 tests/tcg/aarch64/system/feat-xs.c

diff --git a/tests/tcg/aarch64/system/feat-xs.c b/tests/tcg/aarch64/system/feat-xs.c
new file mode 100644
index 00000000000..f310fc837e0
--- /dev/null
+++ b/tests/tcg/aarch64/system/feat-xs.c
@@ -0,0 +1,27 @@
+/*
+ * FEAT_XS Test
+ *
+ * Copyright (c) 2024 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <minilib.h>
+#include <stdint.h>
+
+int main(void)
+{
+    uint64_t isar1;
+
+    asm volatile ("mrs %0, id_aa64isar1_el1" : "=r"(isar1));
+    if (((isar1 >> 56) & 0xf) < 1) {
+        ml_printf("FEAT_XS not supported by CPU");
+        return 1;
+    }
+    /* VMALLE1NXS */
+    asm volatile (".inst 0xd508971f");
+    /* VMALLE1OSNXS */
+    asm volatile (".inst 0xd508911f");
+
+    return 0;
+}
-- 
2.34.1


