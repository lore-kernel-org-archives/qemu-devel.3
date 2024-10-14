Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D72CF2594
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 10:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0If5-00042r-6I; Mon, 14 Oct 2024 06:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t0Ier-0003zh-SW
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 06:50:39 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t0Ieq-0006V3-Bs
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 06:50:37 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a9a0ec0a94fso119620166b.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 03:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728903035; x=1729507835; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ME8nUhQFFvx2jCgImr+jNjdB7rn6Qorc/P0rb7qligk=;
 b=E6GDPOtu68gXxR5HessRrSZzcJyBSiNsO4LUNFN+fG6h8JDEqXJSO8CGV2Mw063+TN
 GX7xOSI0kAlOUJdJ7gAVQmxez+is5UotB1Rg1ICH9xukzdNhfa94LOKW2XD89lnF5A6g
 TNd56dBJNKjHM/r0QUsqJOboUE6i5DEdZYJVvEwZzQMUgOyn6l2YdXrbLE5RT0QMp681
 yjNQnG3J/zSY88NVyEUU+ykl/b6hQKrQbF010e1ZeF4QY5o8aoWNY2h3xvv4sglXkkqw
 OTAV4777GYh+CD9L1bg+e2csP7UJOvfQP1hORzsZ4sqWNlQhjNEb15mDlqk+4x9JAfXr
 ODRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728903035; x=1729507835;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ME8nUhQFFvx2jCgImr+jNjdB7rn6Qorc/P0rb7qligk=;
 b=ZWrB470iN+x3bVs1B3hMDJMHK41DxH10H85Fv4HvKeAQxPvUQE309JFazLXRa+TO3X
 ELeRfy/2IjHonoOUGh4lGmLXUjms3efVZYyd3g7GlmEhZtjhesqA2RphjockB7COlrVA
 XErYrZev89ih1PYnicGwQ4vug6kw15UjtMo3Fe/xRTbAkzQseNHkE1a8RtWsPBuNY6vx
 8hZKmOcZVe5cEYGrnbrY4GYn4HPu454HihAU185ujf6gKG+PYxDn7dKUT76GlU1odTiI
 pkiIO5mmVlG1OvC+IODZWvfhJN9f4zTr1pCjdUMZWvPrg2Et0V4jHXELTA9g8Iya0dPJ
 vliQ==
X-Gm-Message-State: AOJu0YzukjAX6HMtCDRgt5tBOlEzvT9HaJvafYmpp4wtRbrFiHP8owOP
 kvbjMZqjAbHdF2gKvFucRCNOC549G4K7dTSNlL+hoIm51cV8o09sJyQn+uVR7X8=
X-Google-Smtp-Source: AGHT+IEuPA2PSLfQ8dUckatJkrgMwb66oocQ8GY4yqQzEfFTPWUKszghnVcr16Il892bYnfgmaMywg==
X-Received: by 2002:a17:906:df46:b0:a9a:1565:1051 with SMTP id
 a640c23a62f3a-a9a15651340mr92319966b.10.1728903034620; 
 Mon, 14 Oct 2024 03:50:34 -0700 (PDT)
Received: from [127.0.1.1] (adsl-161.109.242.225.tellas.gr. [109.242.225.161])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a0b25226esm165504466b.59.2024.10.14.03.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 03:50:34 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 14 Oct 2024 13:48:58 +0300
Subject: [RFC PATCH 4/4] tests/tcg/aarch64: add system test for FEAT_XS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-arm-feat-xs-v1-4-42bb714d6b11@linaro.org>
References: <20241014-arm-feat-xs-v1-0-42bb714d6b11@linaro.org>
In-Reply-To: <20241014-arm-feat-xs-v1-0-42bb714d6b11@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.15-dev-12fc5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1176;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=QB6WISUQTDQIjWCsNTK3m3cj1QzjVAB89NST/LSlIlc=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm5EUGQxWjJzRXNhWGJWWVNoYUh4YWNOWTBZZ3ZOCjVDZ3kvVVMwK0FGcTR3RllL
 VDJKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnd6M2RRQUt
 DUkIzS2Nkd2YzNEowTDEzRC8wVnFYTFhWWEVmc1FuQXcwVll6YXp6bm5HM0s0RmEyZmM5WEhBRQ
 ozVUYwYWJaNmQxbTFGYTNjWlZEUXFXbThBT1Q2UHJuLzk3amRrMnROeDA2czMwS2c5bHd1NkxPe
 DFobzZHSWhNCk12NWt1eWRnYmZiTE5FUEQ0OG41UXhiRTRLb3NvYlAyZjlLa3hraHNxTUNYRDB5
 dXJEb25TMVhpSEtYcEczZjIKb2RYMWhBbEtySXBFSDFFbjQwaU9LOGkxRUx4aTBqV1hOcmdSVFV
 NRGwwa3RNL1gyeWtBVW83SEMyNVdwZy8rdgpBVU9PQmtIbVF0MGM2b1FINExuY0VIVTltYXpMcD
 NDYkx1RkFaeTQ3R0tXM3pRbnIydURQelByRmNoN1VIZ0VUCmhpRzkwTlNXZUE4dnZOTTYxaTdaS
 GVZUFBhUllCWitMNnBJVXFaeDlLZ0x1S3lmVlRZRWNLcWNEYmpCemdJL2wKSTBKd1IrRlBRSFZ2
 VWJSRGZ5NG1jaEtIY2R5QWN3T2psOTNDWFprTE1USWk2YWhCalVtcVVnazhhKzNwek5PQgpsTmp
 iZk05Y0ZmK1FWWDloOE5vN3piRTV2TFJDNnlldG5kTU85Z2VuQ1U5cldCbDBXQTZ2VDBjOEZtTS
 tXWGdxClUyaXJacmduSURUR0gzUmF0VjdXZFhtaStOaHAySjlDOUJ3VEx1WHVIN2NCeDg5VWEze
 TRhYkVaR1kxT3ZXTjgKUWdKYXpPVnBJR1dVMVJUNFRMVWJyN2VSU1ZrTml2aXhkMzdMaXAvQ2cx
 dnE2NFpCai9LUHZ0MW9wc3EzTnJ4awpXNFNNTE9vcjNBTWNSZCtKUGN0NS95K0lERjd2WVc2dmp
 WclFhQlVPRU5lTXh2L2cxRWV1T1h5bkNLTjlLMmdlCldDY0JtUT09Cj13eDJmCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x635.google.com
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

Add system test to make sure FEAT_XS is enabled for max cpu emulation
and that QEMU doesn't crash when encountering an NXS instruction
variant.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 tests/tcg/aarch64/system/feat-xs.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tests/tcg/aarch64/system/feat-xs.c b/tests/tcg/aarch64/system/feat-xs.c
new file mode 100644
index 0000000000000000000000000000000000000000..52a481c577f9420fa2f6d6a794c1f26772cb4bff
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
+    if (((isar1 >> 56) & (0xff)) != 1) {
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
2.45.2


