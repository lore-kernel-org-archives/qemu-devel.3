Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D61CD98C7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 10:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ4uL-0000T7-HE; Mon, 15 Jun 2026 06:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZ4to-0000QT-RZ
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:50:44 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZ4tl-0001SM-Pc
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:50:35 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-45f3cf907ceso1617056f8f.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 03:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781520632; x=1782125432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2fxx0HT57BvR4zKgzbdI8CQgvLW39zgONazI3L1iFlw=;
 b=EDemrtzmZ38UvEtKfvtWE56HXO78QCU6WYpPmXtWG3GCbBQPTBRXZhKYr2OWGQcRW1
 JT7HW2uigVL2b7pwMOyU1ntukNkfExlB2EzrMxrDRyOjfmUYOnLmvHxqRdLQx78SvMCb
 ORfWsY1i9fDovJlntQHJIoNyKDEV4IYURsIqqwMPgBgcRnr68Sb7l26q0J1mlFQnHPM4
 /xs/aN8FGPN6l5rO7GcIl4AcKQpZ8bMvADsqYUlnjRiEkWxgsoTNwory8z2j3WfxroHS
 tj48hJxchLklaYeOIgRsfd/yxAN5CJF+pRhBJ3PawPVKnBG3anBxXCVp3gwfbyhxxtqP
 WCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781520632; x=1782125432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2fxx0HT57BvR4zKgzbdI8CQgvLW39zgONazI3L1iFlw=;
 b=PeF3Rly0vOJcurzcC8h+FxXdtPhXHdtBVx4trp8+Iir0lC8LGSiJsIn/Bk8GQPq+E8
 fgtpcPGiSb5izfg7bCeikGTrIqiY1nKvPUjbBpLbp93Ks0kdzsIRHxHpaw//3fVZ+Ken
 YxcG2OEZuzQbPBG8rG4rLv1GUMZvODDFM6/n3s9gb3qHOv96XOcWhomHYLZX+mk2e5Y7
 O0p7RdpClQQsElULYTCoFC+eO1tnR1CYzGk50vfoPxlA4FyTNyYAR5jnw7lKoV2Kf+uT
 5ho+CthmCbwCdzUAkMt8WJixXob1SKzxz0ekNOd/7wh6AmKeQETvPAGAsqU/wsD4Cyqp
 hucA==
X-Forwarded-Encrypted: i=1;
 AFNElJ92pPOAjqvx6a2TRLfp8RYOj3GLTwxTTNbBUpNxiANaDz7W0Kg7/dAP817KC1zLaJzEdij+t+bQXvhB@nongnu.org
X-Gm-Message-State: AOJu0Yy6HPpH3bcVfxpoju2XcoDP9FdLh7g6985H8eyKdmLVC0eZkBMt
 FiayjuUiIhvciblBT8iBW+tglcRqgGdSnHH1X5zCA7cYWw8jR7ZgdKxmZ7DbjAUS8gk=
X-Gm-Gg: Acq92OEMnE6ePwoewJwPkVXk7Vzddb6VQIczb9qaltvxq1YizahV8nH7rvzAxQhkY5L
 6p7PgZVHjsCdzkycosPe3pXp3r1+N5qL9C9/7B7hVp909Xk2X0vUVsD+NA+a2oyV4ni4C7Rl06q
 w7LDriEcxGXVXSoIHx3/tTavqeqHBwweXhzyS9nWw+q8gsLmb0bqHufheDvcG36AEIfN4x7aoTQ
 CzzahZm+EEZXT1AMeSwtHkuTsUfdvjzFmlfVXhEtKI7DJLgrzs76XZYZTZ8m/vOqz5Agme9jnws
 tkyi7Lpr0PXxWuTlsqqFjWUnEP/ujaSnsxqHOhkIYg2xuz6Ehj5TXmwi1RPsh/8iTWgc8GbGWcB
 cMB9Kr3TysKvpVxfOmEXaAJxVzt/W3Yg71da75QiOA/jq6U8QlR4ihyX6fBBiWLH3ulY5IKa39F
 sx7n9w9G+VEUFVd1ZrUtepVLkwbYecXmel5+WDbiLhBc0tVD7Q1c7uOI0nIyMEjslNxqwuMqn0R
 ImjfuW/KQrixMb6Yc5QXj4oe2WLfGFbY2OstIlsnSE=
X-Received: by 2002:a05:6000:400b:b0:460:660a:3647 with SMTP id
 ffacd0b85a97d-46074a89e32mr14757375f8f.25.1781520631912; 
 Mon, 15 Jun 2026 03:50:31 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f263945sm33863674f8f.8.2026.06.15.03.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 03:50:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/5] arm/gicv5: Add URL to GICv5 specification
Date: Mon, 15 Jun 2026 11:50:25 +0100
Message-ID: <20260615105029.2898872-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615105029.2898872-1-peter.maydell@linaro.org>
References: <20260615105029.2898872-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The GICv5 specification has now been assigned its final document ID
for a rev A.a spec version.  This seems like a good point to add a
pointer to the spec to the main source files.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c          | 5 +++++
 target/arm/tcg/gicv5-cpuif.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 6b1dd04991..0fa3d6b601 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -4,6 +4,11 @@
  * Copyright (c) 2025 Linaro Limited
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * The IRS is defined in IHI 111701
+ * (ARM Generic Interrupt Controller Architecture Specification,
+ * GIC architecture version 5):
+ * https://developer.arm.com/documentation/111701/latest
  */
 
 #include "qemu/osdep.h"
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index dd2f696511..891cb2d3b7 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -4,6 +4,11 @@
  * Copyright (c) 2025 Linaro Limited
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * The cpu interface is defined in IHI 111701
+ * (ARM Generic Interrupt Controller Architecture Specification,
+ * GIC architecture version 5):
+ * https://developer.arm.com/documentation/111701/latest
  */
 
 #include "qemu/osdep.h"
-- 
2.43.0


