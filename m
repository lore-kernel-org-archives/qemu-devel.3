Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43D9E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1Mk-0007MX-EB; Thu, 19 Feb 2026 05:34:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MZ-0007Ak-8u
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:27 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1MX-00066H-2M
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:26 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso17278835e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497263; x=1772102063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R1Bz8pTqu3aQ8EDK7E+Xm7p1VL1CM0k1hv/xt9PS8jg=;
 b=tOR8wWcxnkaFU/ZZFBFu9vHLVdN/PrXIFMd68r8qn4lncWr88wOOIXIFdZhZdr6gs1
 WHI9s22M/jHZkw9JgjLIS6ygxhbZiGkpA0tO4ofghz2JTKAqBh0cA6QmRg8/jZUtoxCi
 w1N5M2dwQMiHc5e9GIf8Gdb1OjXqY4YjffsCEUEiJ3CwaqTrQ9jcdKdduEH+hi8BCIM0
 rnjlvFDpCza8luvNpCp+33TGR1T2qSWCmiRXFCCftNsZ2Ni4KIL6IiaN+uZ9tcFr78WP
 +3jpHdPwOqQi9Ap8z8o1X8ysWgb6EkmDFngyJGNYfu8HtAlVRId3knEXJ4hZNNt7R1fn
 wKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497263; x=1772102063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=R1Bz8pTqu3aQ8EDK7E+Xm7p1VL1CM0k1hv/xt9PS8jg=;
 b=IWFM3FyRu8vVpltKmpKt3N2b7k9mvOTAGAOAQNLcUooqBz+FdeZ4WVho+7Pa9+Y6JL
 6SgobtG/ogsVk+iM8g+Sx9KNYvbp1BGzJW1lmbRXneSgm9aHS3RyZ79KqcvoqxECUeJt
 nu2wHXD/NsWQOMh8vh9yvaDD6MCXRCJt7L8FI9p3m+bPxRW0msydcETz8Gs0ITB3EnOG
 /zfACw/oV+2DGRiJZrsGOJMFhpcidpazS8l216MmzV+glpyWDLM0qZvUo/ndR675vhEb
 LiYkOhaLPf2Q2Kwm2yPsMhjjJW3ELpU1EkwslqtZtYB45zJQ1WkgLYPjVXd9OEeAGCa+
 OToQ==
X-Gm-Message-State: AOJu0YxShWhTDhuSUEOTAH9liRcOsBXkc7et1DrlL4pCLkvCoB9gnbkc
 eQ87TTxeR7sZe7FkGgiOU+0lXRr8JNS+UpY2pGxJnmHsdchOdsvEH4X+xzN2uwSVYjRvIimHr6p
 /+s4m
X-Gm-Gg: AZuq6aLB+dFVVnSQ1/CAvyb1ZKy+teQJ3sXO8UUG7HE+eCxKDwMgsdA/512e6lYLpIK
 Z5lFsbaLXAC0TKtk0R56A6bkF0tia9KNuU7JgVnA5DY4TsUPe8paR+VS0E3OyCBURC8916J7N3D
 Vtzf+oI9ul/gj5mzZTdOQIKh506YrN1uBWU34Cnbcf8jN6hs5r6WPbFNfFFYpBcuKyqyhKoiJNf
 Ue08CnJ5uN5HwOR0BpWR1NK8rbTJeXbgj//e0m04uJw7atFGwCUaj3OOH1MmO1nzNAl1rXxlWjV
 5jD45FSMxJnQbRNW8jfvHeApfk8+sxmd+H+3SH/dnofMIZzxEhWIE+38h2W8uGLQkFLXOEs0tnR
 Am5zmKPs6lQP5q4KOtoc6rErJdInUaMwT+dADXndTAK8WdT4UmGphWs4v+7VVp6VEA7ZyKg2yEv
 WzTlR7F9C1vURQzjURi206TBXq/Mrci6frOBzaKQ8K8p5GFTKUI8NMeAaIT288LMintDLLpqnVT
 3q0Sa8B0s60BTyLYsk0QuG07bSJAhE=
X-Received: by 2002:a05:600c:8106:b0:480:1c1c:47d6 with SMTP id
 5b1f17b1804b1-4839ff90b06mr25541845e9.6.1771497263246; 
 Thu, 19 Feb 2026 02:34:23 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/32] whpx: fix FP register loop
Date: Thu, 19 Feb 2026 10:33:51 +0000
Message-ID: <20260219103405.3793357-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Osama Abdelkader <osama.abdelkader@gmail.com>

In whpx_get_registers and whpx_set_registers the loops over FP registers
were using whpx_reg_match[i].reg instead of whpx_fpreg_match[i].reg

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr <mailto:mohamed@unpredictable.fr>>
Message-id: 20260217210805.104427-1-osama.abdelkader@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/whpx/whpx-all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index b0602266af..40ada2d5b6 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -554,7 +554,7 @@ void whpx_get_registers(CPUState *cpu)
     }
 
     for (i = 0; i < ARRAY_SIZE(whpx_fpreg_match); i++) {
-        whpx_get_reg(cpu, whpx_reg_match[i].reg, &val);
+        whpx_get_reg(cpu, whpx_fpreg_match[i].reg, &val);
         memcpy((char *)env + whpx_fpreg_match[i].offset, &val, sizeof(val.Reg128));
     }
 
@@ -605,7 +605,7 @@ void whpx_set_registers(CPUState *cpu, int level)
 
     for (i = 0; i < ARRAY_SIZE(whpx_fpreg_match); i++) {
         memcpy(&val.Reg128, (char *)env + whpx_fpreg_match[i].offset, sizeof(val.Reg128));
-        whpx_set_reg(cpu, whpx_reg_match[i].reg, val);
+        whpx_set_reg(cpu, whpx_fpreg_match[i].reg, val);
     }
 
     clean_whv_register_value(&val);
-- 
2.43.0


