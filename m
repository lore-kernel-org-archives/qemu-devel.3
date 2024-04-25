Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BEBC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWX-00023H-RS; Thu, 25 Apr 2024 06:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWO-0001yv-Lt
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:08 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWM-0007AJ-Td
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:08 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-34af8b880e8so514390f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041605; x=1714646405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gARoGDMIdUZMnXzrWbmOnf1y6D1PI72py8fT6x9T7So=;
 b=N9QbpVIxHKWlzqsaqCJ3MppvdyMHvEbnbbT1E0eMm9osg1KeZIZqLEOZUBYILjk3WI
 W+lBAZY2cyZPtnztqwc71SnISeJeLrd+k1cbGqAW4RUEnhMgG/GyR1y/egS1NHQOqcgl
 m1hR5anGpQ5GiZFzhxgNrJ6+gPw1lBBbUwAvdz6Iy/3X+hTWiarMy0dtd0YD5UC/CMUI
 OOwugGAZsPSGbNzSqpVETjmFL7Bqlk2jBOARN860BABDw8rrjTEAwGtisclRcVoAkwFP
 IrL8ZXw5g+yxEM8xyhXoHCs6aXs1BfJk3i02IDVti0D+hj67tv4UtfdMR+yu8xCoaW6M
 o3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041605; x=1714646405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gARoGDMIdUZMnXzrWbmOnf1y6D1PI72py8fT6x9T7So=;
 b=fYhXq1lSyrst5G6MfjIm/SyrZGr4mFeNATwAsKiEsW7Rs6V03bwJEIT1ij3kg0YIHR
 QNH5kJGhzFVhC5xHVcfdRD9li/1GLjqZM2fxiP5vP1iGScMa28+POddvAGgDIwag8Iin
 wrymCvoAGaWxWrdB2bWNXCdH8q0mVOH2zJ/jFoz717lxdPR+5dAE87y2RysYV5DGGgW3
 d5c53Sj5h473UKvsMZ/WjIrbBHz7fkEDD8Ssgrx+ioSFBxaC6JkygVoIPrWfp+uxMown
 38AKMuZxvM4iFu1MPWMQ8xXXzGMZSYBTpGY7z1ai9eOGelZkSbpCDPGa1+8Lt084iiQ4
 bdIw==
X-Gm-Message-State: AOJu0YzMl+yUsYTPP1vngE/McDk0wKgwoTBXfA4u1kupYyLc5Z6WzZuI
 m3hHPJCrrYEBskRSIh0ky5XhSYziCHdkxc0Gstwwc50RYnqHKZI4HvZIwtJb3Mb1FrP+seXO70x
 r
X-Google-Smtp-Source: AGHT+IErkZXY+qwYkYiUygEITthTgLNfIPVDMdXrCNnDPmEDaW/2nXIJ7XZrxRsUPLd4Noc432qiCQ==
X-Received: by 2002:a05:6000:1967:b0:34b:7f51:7bc4 with SMTP id
 da7-20020a056000196700b0034b7f517bc4mr1485361wrb.17.1714041605499; 
 Thu, 25 Apr 2024 03:40:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/37] target/arm: Handle PSTATE.ALLINT on taking an exception
Date: Thu, 25 Apr 2024 11:39:30 +0100
Message-Id: <20240425103958.3237225-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

Set or clear PSTATE.ALLINT on taking an exception to ELx according to the
SCTLR_ELx.SPINTMASK bit.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240407081733.3231820-10-ruanjinjie@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6b6d8a349a2..5ff9e44649a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11733,6 +11733,14 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
         }
     }
 
+    if (cpu_isar_feature(aa64_nmi, cpu)) {
+        if (!(env->cp15.sctlr_el[new_el] & SCTLR_SPINTMASK)) {
+            new_mode |= PSTATE_ALLINT;
+        } else {
+            new_mode &= ~PSTATE_ALLINT;
+        }
+    }
+
     pstate_write(env, PSTATE_DAIF | new_mode);
     env->aarch64 = true;
     aarch64_restore_sp(env, new_el);
-- 
2.34.1


