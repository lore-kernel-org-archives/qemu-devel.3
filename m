Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45414C3065B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJaB-000409-3R; Mon, 01 Jul 2024 12:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZI-0000wk-7x
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:54 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ8-0005T5-EL
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:52 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52ce6c8db7bso4772868e87.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719850061; x=1720454861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eMCn7R56dlpxU36g7EBOXlmw6Q3/lgJjMgb1HwXwFHw=;
 b=eieo9hiKPkts0+XYtDSSLz8F5S0erwB6VsJS/Nvwm29HXGHKc5Qdns3BMw237N34tZ
 TBKV9BR6xBRUuPMMIwmO2pVMUW7EUWLhaaTh3C49805tFYQ3cZ963tvZyKXTRhE97MT9
 L0EOaS+G26R9bXHqYhFlbYiYkc0f8Q7/Z0TZBblM0yYjP0IDmnmWo6GTT4rY7IsqHbAR
 uSMkP5QZlo/k5MiUsdIFBoA97mryjAO1TvPZIroGihQEPVHTTSiGQZVm8kNWJmgO5tz0
 pJbqSM2qJE6c7+2NYm/wzOhav7KS/o2KDU1ANBXASXJP2LF3AGpnDufO2AtmghSJtcbX
 vpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850061; x=1720454861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eMCn7R56dlpxU36g7EBOXlmw6Q3/lgJjMgb1HwXwFHw=;
 b=EFQe7R0n4RXhFkgkc1CvFdQNVuTZ5cawdidhhrlsG3t12W8tIu5A24ijjZ46fakZ3n
 wVFlY8sp5tt+XsbCb14TEVuMofswAvnTO3oOrTrgmhtgejHTfr1rE5ck0G7PiriAUGK+
 +TWt4Kd6cT+vGUcsz4RoL2Bkg8HU+T0DMx0YhOGs57H8q0JI0JKuoIM0VC061M3d4aZj
 RqxM3i9JV/82YL6v8YEbBP7dia4ewVO/fLLj/eDpn3kOb5oLZjVEgnsT3H5nXIcpea3t
 /W4rxSKcYSmtFt5XLfJh7KHptTKo0VR8l8mm9W2Kv8lAulfM19Qe/hqySt4CDY3CnP7K
 TtTQ==
X-Gm-Message-State: AOJu0Ywb0luevCaeZJKpmAul9IwzjYPYrS6ATf2uPvKmxWJjMpGDk3XF
 0fNt45dc+t5ykZYNSRH4YDG3QrAy+ygJ8ySgOFZS+X9AnTp/J+do6/5obkoqFYpWdAFfE8+20pO
 2fHg=
X-Google-Smtp-Source: AGHT+IHTnkMuT26AOTfnpyip9SYuPjo/CXAz360EUNdMV4Ui0cjLnDmd3Z0mYVIQ6QO0sXr+9bw+Zg==
X-Received: by 2002:a05:6512:1251:b0:52c:deba:7e6e with SMTP id
 2adb3069b0e04-52e82691371mr5086850e87.29.1719850060812; 
 Mon, 01 Jul 2024 09:07:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm161952135e9.11.2024.07.01.09.07.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:07:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/29] target/arm: Fix indentation
Date: Mon,  1 Jul 2024 17:07:20 +0100
Message-Id: <20240701160729.1910763-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701160729.1910763-1-peter.maydell@linaro.org>
References: <20240701160729.1910763-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x134.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Fix comment indentation adding a missing space.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240624180915.4528-2-gustavo.romero@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/cpu64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 0899251eef4..71e1bfcd4ee 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1167,7 +1167,7 @@ void aarch64_max_tcg_initfn(Object *obj)
 
     t = cpu->isar.id_aa64isar2;
     t = FIELD_DP64(t, ID_AA64ISAR2, MOPS, 1);     /* FEAT_MOPS */
-    t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);      /* FEAT_HBC */
+    t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* FEAT_HBC */
     t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
     cpu->isar.id_aa64isar2 = t;
 
-- 
2.34.1


