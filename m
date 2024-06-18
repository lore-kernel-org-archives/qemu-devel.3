Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFE6C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 14:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJa0X-00006P-GZ; Tue, 18 Jun 2024 10:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sJa0V-00005f-IE; Tue, 18 Jun 2024 10:40:23 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sJa0U-0001RN-0s; Tue, 18 Jun 2024 10:40:23 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a6f7b785a01so331729166b.1; 
 Tue, 18 Jun 2024 07:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718721620; x=1719326420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uvBxpZFONpTNQR9KQhhThzpJaQH2JB8uCMKlkJSlgzk=;
 b=is1tdFPbjoURFcZRyUSfPKmJPzAeKieEJqHenx2nFQK8NSrSDtU/Oktil+huNN2UWE
 tsP/uOkGBgFDiksgY9b/XQnnFOPKQJk/Fw+axY0Z+AKLw40srsyf+A6NpJ5jrKlITYKV
 wFIuO6zWBg5EqkydeZ9uBi6tu0Lr+HqmyLl1X5FQYTSCPAjVD3orEqgP3rvBVlmtqBa6
 wrxYet3J7QX6V1Z56kOqaUDb/YbkTiNghgunubN0N5jT8if/n/HKM2MiFEWOMJu3j8Ml
 51uSe9qb4NA+Bi1RelIl7XA9yRVh2bFrT7uh2WuAL1BTJWfw5PonD5Za04PvnChrOmsq
 GBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718721620; x=1719326420;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uvBxpZFONpTNQR9KQhhThzpJaQH2JB8uCMKlkJSlgzk=;
 b=gxOKNrczHfRx+TUqbK0FTgpPk6crMOXhr/IZxPp/l6igslseWFGmoZfn96CNtVbIFo
 BatCf47Mfz8TFw5T+KtxMnCNYRKBHkfNmGp4MePMs04UhKIpT/K5kAffijhyVGz+OKBO
 /815xjEG6zkQudy+xOQu8iAovMd6v08+URp/vQaA5ozS905z/tcILHl4PCRY+DXCcxHb
 k+kFU11MAuwz85bcqfgR/H8OA35hcYGI2aECJDlrpzkuqSHDFfcujPs9tFGBbl0AwK0J
 23qltH00QGwd+RN+ZWF3dSg2IFQ+c0t7TTDH/Xz60D+2mpyO2f5dSJfR6aNdKcE9+0l+
 pP8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi4iIu8LE3M7rdIT2TDWilDaW6irXNP9T2+za6S6Fjn7XnqBJNpgoHWONqr5yFCFV/89k/tMgu0Zo04ipva7bwi35ezIDMfet+u4lOA9TCdOz6uYdi/+dd9Ow=
X-Gm-Message-State: AOJu0Yw/zRzHUiriGOmCHjjImK2+RouUGp87YGf/d+4S/dTQlAjL8plB
 zRNvG/TgjKqy2a2kN3qr7CAG0lBPX0txwcm38XoRKU4Hf5W6Z0c=
X-Google-Smtp-Source: AGHT+IEKiy5Tc5VgwHMztvE6V1NuJuApHM0FcpgLEEuXbCVm4nvJujCZKSFtnrn6yfJJXHaWYjLXqA==
X-Received: by 2002:a17:907:c00f:b0:a6f:6721:b06d with SMTP id
 a640c23a62f3a-a6f6721b860mr943923566b.24.1718721619942; 
 Tue, 18 Jun 2024 07:40:19 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb741e884sm7745066a12.63.2024.06.18.07.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 07:40:19 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Zheyu Ma <zheyuma97@gmail.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH] hw/timer/a9gtimer: Handle QTest mode in
 a9_gtimer_get_current_cpu
Date: Tue, 18 Jun 2024 16:40:09 +0200
Message-Id: <20240618144009.3137806-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=zheyuma97@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This commit updates the a9_gtimer_get_current_cpu() function to handle
cases where QTest is enabled. When QTest is used, it returns 0 instead
of dereferencing the current_cpu, which can be NULL. This prevents the
program from crashing during QTest runs.

Reproducer:
cat << EOF | qemu-system-aarch64 -display \
none -machine accel=qtest, -m 512M -machine npcm750-evb -qtest stdio
writel 0xf03fe20c 0x26d7468c
EOF

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 hw/timer/a9gtimer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
index a2ac5bdfb9..64d80cdf6a 100644
--- a/hw/timer/a9gtimer.c
+++ b/hw/timer/a9gtimer.c
@@ -32,6 +32,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/core/cpu.h"
+#include "sysemu/qtest.h"
 
 #ifndef A9_GTIMER_ERR_DEBUG
 #define A9_GTIMER_ERR_DEBUG 0
@@ -48,6 +49,10 @@
 
 static inline int a9_gtimer_get_current_cpu(A9GTimerState *s)
 {
+    if (qtest_enabled()) {
+        return 0;
+    }
+
     if (current_cpu->cpu_index >= s->num_cpu) {
         hw_error("a9gtimer: num-cpu %d but this cpu is %d!\n",
                  s->num_cpu, current_cpu->cpu_index);
-- 
2.34.1


