Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859B7C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWW-00022U-Gf; Thu, 25 Apr 2024 06:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWQ-0001zc-6S
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:10 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWO-0007B1-DY
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:09 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-41b5aed246dso1833265e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041607; x=1714646407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k3HQo9h6O4YNEO0q4im8nAu5Lx/+PmmdfjaGGgAzyoE=;
 b=xIn1VHJMsaCip0KKKhOx+TDsiVCHqx89z6i+FZmiubMWHO6OOOl+ECvPyLm78UJ98B
 xueRJmlD8hpm4aD9Y7Rm/0LfzccFIJJ3iyWhPTK3gVpuFcvaJx1+4fs9VHh52QzuQyT1
 3FyO+DG5bwwwJTOXoIwlZH6hgjlBG05Az1v002ReUjMmq+EDAhRU8LeMp+WlQTuLZlug
 E2fM3I/y/1oRbJPHPWtyfQ1O8kc8XmgxrdiZAGEeAm/BGiKmlB+tdjRpk3M3eGYlzwF6
 9DXHkZ5omMXYSspfC80V8llKdXbcE+8+zu2mHvl77CmDpk3XCbQNuijbu8ADIOjbU5Wt
 Y8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041607; x=1714646407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k3HQo9h6O4YNEO0q4im8nAu5Lx/+PmmdfjaGGgAzyoE=;
 b=StBzr5rps+44RZ2AxwhTPA8n6g3iBgQ5E6r+/J99IKWNTB5LqCIdBCwUdteSK2v1oz
 LSxN152lXVx65QpVpq0OOUAY9JuhJMEDTuXbCoJZB7O2VGqgrVPajLoLLRRnyEyYcFgv
 vDa54YlQFnUBsXNS/X63GAFrKz03cXc1UN8+cl1+F2zHX+UJj4PtYuwaQ9c4uDBEXGd4
 Y7huJm0s3PJFjuhhKj+FSSL+ALhcjleTB2TUMNj7zLv70v9zFLRdILxA4sb+3kEJA4/7
 HxbHC4TX5wb5JGMYizO/IHBdq78ZpDRe2FWGdxVbdrECVw/J0/gIWatapDDRBp7Xl+fZ
 Kn6w==
X-Gm-Message-State: AOJu0YyfyqR+rGOcpWRUeLQiG629KQVSFAjamgG8qAqz2oeAlttGCsIo
 +Vv+qgmWgBWuHuNLcAHAPeIRc2Cadlk2Ag5eZBRtCw8uroMHFfeHfzufOEYRjxBHBQcF7xs1o1u
 r
X-Google-Smtp-Source: AGHT+IEoSaLuZlwAxp/K4AATgBO7poCtRidPGko92k72xJ93hSjRbYlVnf4PCWGFGSTytWLcytgMkA==
X-Received: by 2002:a05:600c:4f03:b0:418:ed13:315e with SMTP id
 l3-20020a05600c4f0300b00418ed13315emr3712939wmq.2.1714041606966; 
 Thu, 25 Apr 2024 03:40:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/37] target/arm: Handle NMI in arm_cpu_do_interrupt_aarch64()
Date: Thu, 25 Apr 2024 11:39:33 +0100
Message-Id: <20240425103958.3237225-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

According to Arm GIC section 4.6.3 Interrupt superpriority, the interrupt
with superpriority is always IRQ, never FIQ, so the NMI exception trap entry
behave like IRQ. And VINMI(vIRQ with Superpriority) can be raised from the
GIC or come from the hcrx_el2.HCRX_VINMI bit, VFNMI(vFIQ with Superpriority)
come from the hcrx_el2.HCRX_VFNMI bit.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240407081733.3231820-13-ruanjinjie@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5ff9e44649a..6b224826fbb 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11653,10 +11653,13 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
         break;
     case EXCP_IRQ:
     case EXCP_VIRQ:
+    case EXCP_NMI:
+    case EXCP_VINMI:
         addr += 0x80;
         break;
     case EXCP_FIQ:
     case EXCP_VFIQ:
+    case EXCP_VFNMI:
         addr += 0x100;
         break;
     case EXCP_VSERR:
-- 
2.34.1


