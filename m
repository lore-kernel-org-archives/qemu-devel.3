Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3F8C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjE7-0008Oi-SF; Fri, 04 Jul 2025 12:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjE3-0008KY-4l
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:23 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjE1-000681-GT
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:22 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-453398e90e9so7306345e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646320; x=1752251120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VdKchwbJEZ+nSckIGEWeS64CtMCPrL6GOAZLbL9tqic=;
 b=uP8BdVO5o79VUDTRZSZDq57gHJ0LZv2oI4FRow/H0P++cWro1pN5moD+HRt5/kGmYS
 wqTyvQzoVA9gEaD6bbXZWTt5GFFSwtgUm+wolU/aNpWnYqBx8nx53Jdwk+sXbatuaNWa
 6/eXV9I0+cbwOmZIS1LILqKebR1RZZqiYO37wXBPMyu+A+Vr6AHWCA2TS1icZT2JrdZf
 R46/W8tSQRhj6uHAJlxp/CSsyAaL/Za6J9CxWXiKgsMI5UAYINqj2xe3cLovqyXLM8im
 LkSCShr1RYjB6/TSMox9178pRMyCrHUaN58JVFHLlM4nTvEcf22k7QcTJpTJ/FASRlp1
 RpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646320; x=1752251120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VdKchwbJEZ+nSckIGEWeS64CtMCPrL6GOAZLbL9tqic=;
 b=j4g9yCyAToxzyhBtgzHgRU4px6w4CZdeDhLb5al7NF5brVmR3YnaCj/E0K78Xi6jkh
 tSgGFRRSylvkjF83HMotQvwhXqNoN3tEUEtQbZlHdtINR3QZUmZMCWuglPHHftF/pViM
 FldqtVOKvkgnpzAbFnMdW3h8ZhQ/DOptIZ5k0yI0A9VWajTa9d/8ow0naDKLzMhNwqbS
 kFlnoniFBH/UroByb6zgQ3Zqdvena2RivwBcQU5coHIgpT6/QGoXnE8Hbqd3OThE4DzJ
 t7E6/FXQmiTy6hKWe0HKMMm6B7bYaUGNkb20+pTQ3dP12MVgTmVI1CoOzvCE3PxU+LM8
 41cg==
X-Gm-Message-State: AOJu0YxA2JLff87yTAUZxl+8QGSQ7q0V7UGbYCDWR9ltiVBs3TFRgTYM
 FXPcxilsNXMuh1qzIipeFFgAItsoFWlsrF5EVThBxcmRyLSObTEiXcL8zJKjqs5CfA3XCWhWpck
 a5kcf
X-Gm-Gg: ASbGncszow10Os9aaTSuXWe+FFqTGYKce8LSDl0n3/X7pcYO8Lms6WPsqOOODaMLZoU
 DhKnttKnKtQL9AerzffGrgRzfJNkTwWu1p3caPee04LCEKhmamRxGE/KnvW3MHebio6tH7g/KfV
 vWSdFvSeIGT7ZfEmFlsFAPNeOVGq+dEPG6HbscPbCexbWLVfEZYa1aNhmHsEv1pvdIvHIBoNr0D
 T/Qo5uXBLTHOkPCYcNiFY7OzeP9iqH6vCGx71Capzu25glRN2HbEId6yzrVtPMHpfZTUnCScBny
 SaXU32JTE++oZDtStT1SpRnCfCJihrLHNtNgWmEG+mcTlCXtS6R93IuVnSTy9sUXbSMc
X-Google-Smtp-Source: AGHT+IH4BqLtEhBTNP91QcXX/00HgnAisu9VG+gxVIf93epbZke4Ahz++3FEE+yxVfnHxCedVbq/EA==
X-Received: by 2002:a05:600c:1c03:b0:43c:f513:9591 with SMTP id
 5b1f17b1804b1-454b3124faemr34179895e9.14.1751646319926; 
 Fri, 04 Jul 2025 09:25:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 018/119] target/arm: Disable FEAT_F64MM if maximum SVE vector
 size too small
Date: Fri,  4 Jul 2025 17:23:18 +0100
Message-ID: <20250704162501.249138-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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

From: Richard Henderson <richard.henderson@linaro.org>

All F64MM instructions operate on a 256-bit vector.
If only 128-bit vectors is supported by the cpu,
then the cpu cannot enable F64MM.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu64.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 1f3406708bd..77e7c4a6a52 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -259,6 +259,13 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
     /* From now on sve_max_vq is the actual maximum supported length. */
     cpu->sve_max_vq = max_vq;
     cpu->sve_vq.map = vq_map;
+
+    /* FEAT_F64MM requires the existence of a 256-bit vector size. */
+    if (max_vq < 2) {
+        uint64_t t = GET_IDREG(&cpu->isar, ID_AA64ZFR0);
+        t = FIELD_DP64(t, ID_AA64ZFR0, F64MM, 0);
+        SET_IDREG(&cpu->isar, ID_AA64ZFR0, t);
+    }
 }
 
 /*
-- 
2.43.0


