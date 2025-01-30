Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79D1C02193
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdZCG-0003st-Jb; Thu, 30 Jan 2025 13:23:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZCA-0003qX-SU
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:23:18 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZC7-0000Th-Vy
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:23:18 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-385e3621518so668839f8f.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 10:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738261392; x=1738866192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LMfouiukZplViqTOnGPtuKQ5CD0lpwbbbWd2NrRj/nk=;
 b=fqZl/FX6ehva1Z+xejzq5yPYEpzJVB7DigA9UvCPTK8EJHMhg73HkHyqGB+QZz9kXc
 tIlXZ70osZG3hCQRDnHmnIPEAbM5ZbKYwJatMpANgJFOy27ifw01lfum8AZ6ksxc6M/A
 C7Jxfrl61EkCAlzhlGFlLIemrfccVr0KooQti4VgOZ8CH6LwVt+f3yQ665wIb1ltTCQR
 aN7ncq60yxu9hG9El/D+YiHznfO0ZkmOn29X1L7/WlhrRPrp4TUlYBMog7owVjeq81xG
 4GjI2pMqMt5pQDC9yr0fCZGPiOnSaL/EqmLA0cgf5NoZANbS/XHNVQZ4bKyjJaGtPD69
 iCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738261392; x=1738866192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LMfouiukZplViqTOnGPtuKQ5CD0lpwbbbWd2NrRj/nk=;
 b=jCgOg8n3ENS8RN6IR+1IXvTV/ygMpXjhn/g/LbNfH2cMJEnAfRcjJ/8SL+R8C7ddj1
 X8y+02HrlgIckfoXdEoBKad+RCkSqJWFKOFiDB4y7HelRuRWWDYjbEKHLxjsFa5EBUqR
 yW6VcBoiSXNwwBWbIaTgDnXCh8qqfPqushaGze/BQ7nfuptiG4Ih1v73wMOlY2YFon+f
 0U7mHfEU0vldkbYWnZ5oN+RArVpxXx+XBD2dzcfdkbexKs4nknYuibXCn8x/lvll5IDA
 xgGjB830tDfJn473x6WFijtr66iMKYvWJ1JQrRQHEcrRKYT0dQfJTbwS5xYOwAt62HQG
 65pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBYhJ9MXpVe9iuOw5063ZPtfgMtSasyo6MsLAK+yz0PsYXr3x/YXADctQOC85F6+1CG+MnLs+XEyMK@nongnu.org
X-Gm-Message-State: AOJu0Yw/9+/QSCFzI/uLSFD30x99doz3OMM6MQhzB+LUSszwYoHPvcpv
 cTpmqJp0weB9hnkZIsVJlq4v6Hq242J6w5nuos057NcZEVPwswgNKxnZytlG2DY=
X-Gm-Gg: ASbGncvACTUBq9Ud7RI2HUeL0oO+MhIsu4sR6wAGpEy59Aq15UVzudE1iYrW+DYCC9Q
 plhCUThGbGxGHmleQ0ko03mjiqgTJq5FmCQVa6DmX8mWM79ateZEbvm7A9y2wsirF6lQYFe7R21
 LiBvN87bKFixOD6C6BdWcnizYdnNNTxG+NRk4HaMQzqbItfKrco529sC18espp30PfWEoD5rJjg
 95WUbgfolQZ4+XAZIiDyu8m4ngzOqtBY05chNuJ6cAB+FX1MFQ0Vjg2e/weUUM3tL4iQtsd0Uvp
 LY7M3j4Soe0mse/APJZOMg==
X-Google-Smtp-Source: AGHT+IE0Ntzqkcvpi0/rtd9RUCq1vjf0A6C7yblnPNWB4Ert1+7WzMmsG13LS2EqDenr5fnRIuTw3g==
X-Received: by 2002:a5d:6c6f:0:b0:38a:418e:1177 with SMTP id
 ffacd0b85a97d-38c51949ebemr6862874f8f.11.1738261392535; 
 Thu, 30 Jan 2025 10:23:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c101599sm2634426f8f.23.2025.01.30.10.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 10:23:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 01/14] target/arm: Report correct syndrome for UNDEFINED
 CNTPS_*_EL1 from EL2 and NS EL1
Date: Thu, 30 Jan 2025 18:22:56 +0000
Message-Id: <20250130182309.717346-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250130182309.717346-1-peter.maydell@linaro.org>
References: <20250130182309.717346-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The access pseudocode for the CNTPS_TVAL_EL1, CNTPS_CTL_EL1 and
CNTPS_CVAL_EL1 secure timer registers says that they are UNDEFINED
from EL2 or NS EL1.  We incorrectly return CP_ACCESS_TRAP from the
access function in these cases, which means that we report the wrong
syndrome value to the target EL.

Use CP_ACCESS_TRAP_UNCATEGORIZED, which reports the correct syndrome
value for an UNDEFINED instruction.

Cc: qemu-stable@nongnu.org
Fixes: b4d3978c2fd ("target-arm: Add the AArch64 view of the Secure physical timer")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 40bdfc851a5..c5245a20aaf 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2385,7 +2385,7 @@ static CPAccessResult gt_stimer_access(CPUARMState *env,
     switch (arm_current_el(env)) {
     case 1:
         if (!arm_is_secure(env)) {
-            return CP_ACCESS_TRAP;
+            return CP_ACCESS_TRAP_UNCATEGORIZED;
         }
         if (!(env->cp15.scr_el3 & SCR_ST)) {
             return CP_ACCESS_TRAP_EL3;
@@ -2393,7 +2393,7 @@ static CPAccessResult gt_stimer_access(CPUARMState *env,
         return CP_ACCESS_OK;
     case 0:
     case 2:
-        return CP_ACCESS_TRAP;
+        return CP_ACCESS_TRAP_UNCATEGORIZED;
     case 3:
         return CP_ACCESS_OK;
     default:
-- 
2.34.1


