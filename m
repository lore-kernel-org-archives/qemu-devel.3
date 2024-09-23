Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F109DCF9C71
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 09:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssfPv-0003nb-JW; Mon, 23 Sep 2024 05:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPm-00038k-2v; Mon, 23 Sep 2024 05:31:30 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPk-00070l-Gd; Mon, 23 Sep 2024 05:31:29 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a8d4979b843so515733366b.3; 
 Mon, 23 Sep 2024 02:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727083886; x=1727688686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zl1UfkNK4uOLHCCNuOFOWU9ZrQRdFQX35RLscGjdLrg=;
 b=ZI6DeI83QKfJ4XJyOPtFx6yd82FRXvckX31wtc9R1JN5ZWc22mNR1PQS+Ds14Ltn63
 jRYyDbfxxPRaHLXIGoudNMa8vtxWVpmj9ccUKc8zxV03mwu2Jab55LF9ExIO2I07LOr7
 24q25ryAOmaQb44s/PhkMGLU/yYyxbbMEbnSGJj9gxozLKT0zS8QIqoiULW+TFqJWPXe
 Yt0UsjqoO2jQD49/Usd1MUTHiRjOFdkEJe+D6v5tN7IkJaLTc5/J3Sbs+QNIpVFBJdJc
 I35ElocJkkNnmlQu0QdRPYXfsarurLqdrtlnyagUIVUYGsSOnfip40EKMeLEqBRDNkHR
 0S1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727083886; x=1727688686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zl1UfkNK4uOLHCCNuOFOWU9ZrQRdFQX35RLscGjdLrg=;
 b=pFS+sXWsfEV8jODDdpazqEZriP+xK3E5leOLGxn6vkm+RpUARlncutOXaKtugk6Z+M
 JaUQApxo6CoX3JWrlvN0u0ZI2eWFtdjOP53lQ0hZSrHCzumqpVd6HUsogqnWf4Qy0QAq
 f8Xd4w8qHm4bPbZFX+gh5W2AkQ4f5wAUF7kK7xymDapXHFZ5fYFBovEKRziaPUHPCFee
 PCWwNUl2zUXK0WJTZ5Kx+0w4AlHzcG+1eGb7YdiU2IWoNS4OhsGcL03tEr19nUc5w3uD
 GzcsPeOEJKd+rU4tljKM7q9RrihsE8Z5O4Fw9ZkSXeN3YtcsXUGd5Eu8/BxIxSyrlpdV
 DC+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpfj2jCN4ygkE0Bed0+qvecp6kefa7Xol3obw3BHfLeAoIiFkAlKdhs8br8Ez4fMgjn3Rn8LP9+ME=@nongnu.org,
 AJvYcCXg51gwYCMSFyabTyvUY77WtL2tjqOEEc5wHlkm1LXJDIu1U7omlUq11pWUpGoRJWGl3NmOeWXYr8gj@nongnu.org
X-Gm-Message-State: AOJu0YyknBVhsY/iNMz3K4XviiXWBNrTO7zV0HHDmVzHPTGmCpP1NCun
 Fs/f7C6NVjYEqTFtaCaxKF1dYpq8yGRZbtjaJCIOqWpYr4eAtOtwbu6nZQ==
X-Google-Smtp-Source: AGHT+IEKW+H3JsoS1O6yo6rqI9yZQ5idQ/Pyi1NG+Wti/sIMHZ50/3bbzras5gWuWJo45UTyamhbSQ==
X-Received: by 2002:a17:907:e603:b0:a90:344a:7db6 with SMTP id
 a640c23a62f3a-a90d583ba97mr1079142466b.62.1727083885793; 
 Mon, 23 Sep 2024 02:31:25 -0700 (PDT)
Received: from archlinux.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612b3f6fsm1188747166b.107.2024.09.23.02.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 02:31:25 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 15/23] hw/ppc/mpc8544_guts: Prefer DEFINE_TYPES() macro
Date: Mon, 23 Sep 2024 11:30:08 +0200
Message-ID: <20240923093016.66437-16-shentey@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923093016.66437-1-shentey@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ppc/mpc8544_guts.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/mpc8544_guts.c b/hw/ppc/mpc8544_guts.c
index 6688fd44c3..cbb1e3adda 100644
--- a/hw/ppc/mpc8544_guts.c
+++ b/hw/ppc/mpc8544_guts.c
@@ -18,7 +18,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/module.h"
 #include "qemu/log.h"
 #include "sysemu/runstate.h"
 #include "cpu.h"
@@ -141,16 +140,13 @@ static void mpc8544_guts_initfn(Object *obj)
     sysbus_init_mmio(d, &s->iomem);
 }
 
-static const TypeInfo mpc8544_guts_info = {
-    .name          = TYPE_MPC8544_GUTS,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(GutsState),
-    .instance_init = mpc8544_guts_initfn,
+static const TypeInfo types[] = {
+    {
+        .name          = TYPE_MPC8544_GUTS,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(GutsState),
+        .instance_init = mpc8544_guts_initfn,
+    },
 };
 
-static void mpc8544_guts_register_types(void)
-{
-    type_register_static(&mpc8544_guts_info);
-}
-
-type_init(mpc8544_guts_register_types)
+DEFINE_TYPES(types)
-- 
2.46.1


