Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9446C27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 12:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKzWM-00081Q-T9; Sat, 22 Jun 2024 08:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzW9-0007lx-SA
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:54 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzW7-0000Jy-JJ
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:53 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-36279cf6414so2235572f8f.3
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2024 05:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719058010; x=1719662810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WZEwtz/pwjMa4zwtaeGl8+Ie8svZn5Th6HSPtyByswE=;
 b=P6t6gJLiVVo5H5kU3Jh9+AZXAZqeS6eV9Z30vu+NbmCSM+8W1t9q8X5m4sccfAQNTE
 1sgB/ssiL2g13yDMndeMOnLbvdCgm6xh0NOzCciGnvb2gXw1w5A3ZVXz3VBll4qc1yz1
 4Un6lwSRut5nnpy9kTuxvbExGg1EiyVIWVIW/eGqeKZq1/yZQIg6lxtfrSpbI5jorKrE
 EbhO/I0t0hDR/3RKEZBi0yOei3pQAW81Kob77s2tifTye1cx+UlYl1T+HJNRRY+lf0SU
 UAEibwFm1YXdv065JEcABRNTJBX8r1J0/69gGxMec+oaFv+sC0/IpWiaMxIQNLntoqeA
 I3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719058010; x=1719662810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WZEwtz/pwjMa4zwtaeGl8+Ie8svZn5Th6HSPtyByswE=;
 b=rf+geEHiU7W/Atc5/Sx/dcQRMfmT4kXEutzmmOlogPLG4bIPTyE19ekTQvc2J6IgJx
 TSnPElCIPok+48ihdFjUOVxNal7dpmj61815dKVoQtsRZOEXY7M0gWEwiwq7qdqbvmIT
 ExUg0h31xYNlG9wG2IJsO5AzpP0/wonr8iyN3YtNhY1Kffgm162vRZ1nk+00Ppkt2j+0
 3Dw1YunY0UA8kgvE8BUEo/6sUHASx/rCjCnjCNaPjGrMEYRHcOybwGECt3OFCx9PujBm
 0hPhRsFPaQ9caBlrqdyGmhs/Wu5PcL9uv2fPwrH97Ghk5RnhxgDN2HYhG0AIGU557IA6
 DHBA==
X-Gm-Message-State: AOJu0YxjPU87o20J09gIyFhG58kf9EQdFKxqj5Dtc84EuZmaxKTDot1P
 k7hsHLOF7bLUBjEw9BoFxyfGELwEtIlMa3RMDAODng9hFkU4w4siK7DBsPQag+K8AEO5NLsRqoh
 DLng=
X-Google-Smtp-Source: AGHT+IEOVruQ/93GjvDrXo+Ij8CnMJJrieNseZnvTV1tQbwup/xuVUq/e7mOlWjsb4n2Kjyw7VZWYw==
X-Received: by 2002:adf:ce87:0:b0:35f:209b:c10f with SMTP id
 ffacd0b85a97d-3631998ffcbmr7275862f8f.68.1719058009927; 
 Sat, 22 Jun 2024 05:06:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a2f698dsm4393006f8f.70.2024.06.22.05.06.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jun 2024 05:06:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/18] hw/timer/a9gtimer: Handle QTest mode in
 a9_gtimer_get_current_cpu
Date: Sat, 22 Jun 2024 13:06:35 +0100
Message-Id: <20240622120643.3797539-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622120643.3797539-1-peter.maydell@linaro.org>
References: <20240622120643.3797539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Zheyu Ma <zheyuma97@gmail.com>

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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240618144009.3137806-1-zheyuma97@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/a9gtimer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
index a2ac5bdfb99..64d80cdf6a3 100644
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


