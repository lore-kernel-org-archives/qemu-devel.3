Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5DF6CFC287
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 10:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ewY-0006gR-OM; Tue, 15 Oct 2024 06:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewV-0006do-H5
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:19 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewS-0005wS-Py
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:19 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43117ed8adbso58238175e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 03:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728988695; x=1729593495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uQyiSr+GMXfCOC8blY2Vz0JFIbQgxcDhxoPn/qE/+zs=;
 b=u6zOSnTkK5Y83j9DSpDTWHd9Fy+RuO1HiUHXaIock7ueZs1sUNkV8LL9EgHMANyu+K
 ZpaX9rm5PkBOqV3sFiFua6NKI6hW2O7nk2DFUo6nJrTUmAV/yXQIL//pKWOVs2AMb/t+
 M84hG01u7Nly5KDFGcJASGWCAFHkV7bFZ+7cKyDmgLpDbx0hlIIlnRpFKs3fFts5SqRA
 skYQKDHR02qtQBhjhHI0lhkkkdf5Js0Xr7d5ZBZAeLwapFidKWVbblT/kKP6qP2OkQp1
 Lu1Heotr0KifUDX9D9RADytk3jkGoxyt7aZDu7Nx7q7W2nFA0M0QHuQP5ENpkUDckKs+
 94kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728988695; x=1729593495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uQyiSr+GMXfCOC8blY2Vz0JFIbQgxcDhxoPn/qE/+zs=;
 b=cf6ZiyXP1JcmNthSsfNrLqnk8ivu09bqgR0W+scB6jMhv2VChdGjhfE484Rd5ivopy
 cw1pdFXQ0qnsQkHzQ1QyT29VIR50Nhbm1BDVcGjEusY/wMt2r1uPYNkAcsd1XhtKUQKe
 94f2UKDuTGPFxoI8DH36RIPMuaWq2ST9KXMiIV7BGEC+e976cmniHLV8nw93QbEMqTju
 yDpACL7gIfPIDWCi398PuBmpx2FfMiqggL2lhVtr5T3WkiVyaIubrM68D0kjrnsls6T6
 Ln7Jp07GfevWRCdwYDBSRXlmUNZFrlVp3aHs+Ns5vzkl5fscZv8fiJ4v4M9FpEQw3dHM
 Nrrw==
X-Gm-Message-State: AOJu0YyN3bm/Usrni+B3c+jPsnNQUHQ0XclMSCMcNRlGc4vG33+KPxjI
 rJlQUu+LHzvK7fxbAH5tSZz0pN98AkebqZ8yGjHwP3bWfg0lqzM3AeKKlUO7RbDr0mxgMx1y5eW
 U
X-Google-Smtp-Source: AGHT+IGzsZP5PJ8Or73O3MLWC3pRp6kufC+SVeDhjUJAdvhE8dOvcFqr5fVaUqMv9vaVaFYV9KR4XQ==
X-Received: by 2002:a05:6000:11ce:b0:37d:3e6d:6a00 with SMTP id
 ffacd0b85a97d-37d600d329cmr10271665f8f.47.1728988693548; 
 Tue, 15 Oct 2024 03:38:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a06dsm1241635f8f.5.2024.10.15.03.38.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 03:38:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/28] hw/clock: Expose 'qtest-clock-period' QOM property for
 QTests
Date: Tue, 15 Oct 2024 11:37:48 +0100
Message-Id: <20241015103808.133024-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015103808.133024-1-peter.maydell@linaro.org>
References: <20241015103808.133024-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Inès Varhol <ines.varhol@telecom-paris.fr>

Expose the clock period via the QOM 'qtest-clock-period' property so it
can be used in QTests. This property is only accessible in QTests (not
via HMP).

Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Luc Michel <luc@lmichel.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20241003081105.40836-3-ines.varhol@telecom-paris.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/devel/clocks.rst |  6 ++++++
 hw/core/clock.c       | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/docs/devel/clocks.rst b/docs/devel/clocks.rst
index 177ee1c90d7..3f744f2be1e 100644
--- a/docs/devel/clocks.rst
+++ b/docs/devel/clocks.rst
@@ -358,6 +358,12 @@ humans (for instance in debugging), use ``clock_display_freq()``,
 which returns a prettified string-representation, e.g. "33.3 MHz".
 The caller must free the string with g_free() after use.
 
+It's also possible to retrieve the clock period from a QTest by
+accessing QOM property ``qtest-clock-period`` using a QMP command.
+This property is only present when the device is being run under
+the ``qtest`` accelerator; it is not available when QEMU is
+being run normally.
+
 Calculating expiry deadlines
 ----------------------------
 
diff --git a/hw/core/clock.c b/hw/core/clock.c
index e212865307b..cbe7b1bc469 100644
--- a/hw/core/clock.c
+++ b/hw/core/clock.c
@@ -13,6 +13,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qapi/visitor.h"
+#include "sysemu/qtest.h"
 #include "hw/clock.h"
 #include "trace.h"
 
@@ -158,6 +160,15 @@ bool clock_set_mul_div(Clock *clk, uint32_t multiplier, uint32_t divider)
     return true;
 }
 
+static void clock_period_prop_get(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    Clock *clk = CLOCK(obj);
+    uint64_t period = clock_get(clk);
+    visit_type_uint64(v, name, &period, errp);
+}
+
+
 static void clock_initfn(Object *obj)
 {
     Clock *clk = CLOCK(obj);
@@ -166,6 +177,11 @@ static void clock_initfn(Object *obj)
     clk->divider = 1;
 
     QLIST_INIT(&clk->children);
+
+    if (qtest_enabled()) {
+        object_property_add(obj, "qtest-clock-period", "uint64",
+                            clock_period_prop_get, NULL, NULL, NULL);
+    }
 }
 
 static void clock_finalizefn(Object *obj)
-- 
2.34.1


