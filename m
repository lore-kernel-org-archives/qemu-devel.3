Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97078CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 00:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1w4l-0002RJ-6X; Thu, 25 Sep 2025 20:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1w4P-0002NA-1q
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 20:12:18 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1w3w-0005Dy-VW
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 20:12:15 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-24457f581aeso16585335ad.0
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 17:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758845496; x=1759450296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4B0sed8fcKcEBs00RcNhGZcUvjaD+FLFaLTVM+s8BDA=;
 b=sJp4uP9lQ1H/KibGWs17LLSqU9pzVTN92WXJ6QjmA3igJLmdxKTpxEtvrtLhkDBEX1
 15cDgduyGLpn7v4u6HrjAf0FYFLWVnA3kY0LYgi6iZLVMHwYee/FroemwuKN/HpfF5co
 WrMTZ29Mw4FJ8YApdd7cAA3l5MTPDtVSRyjgPaqmZYCx//3IEVoLIbcOip4wIc80F0/g
 5ALWReAK8+Fu7412JDVibOL6osKNWcZ+jiK4HVoIU5+1zhL9VHGgC5LD86Wo94G3B6VX
 +fxUbCPE89z+tERPdMf2hgxbg3ap7zusA6NDRWa9EiaIhKmMzqyYNABsl68jXXI8US5t
 ozBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758845496; x=1759450296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4B0sed8fcKcEBs00RcNhGZcUvjaD+FLFaLTVM+s8BDA=;
 b=vdIdxd6z3EBy/GC2HR2sPZNR1dfcoRIYK+43X2sijlCPTZasnCNJgaBOVzbmcUADOM
 FzVGs0MlsHyXSFbV5vO9U8NbQdsbhsJ3pVL09XIThb73XOuoJ7zTeDi4ZWWDTqUzTJqb
 pKQEg1dZZGKMaL5EYzJ8hy9N+3fgBcnzYqPlhYHPHo3em5DDZ+wvvJIkVp1LDhofJB8p
 8QRVIhCIA+/kD6B1ApOGX/fBXWPqQhnqhV0kV7fg3BhF5uib8D25Ar1Iwfqx4wIwbbwK
 rvmsQuksJj9+YXRpajArZTkm6dd2p5whKH+MSUgQCi65Zwe2Dw0cxk+V8rMGi2zIXtjv
 eJ3A==
X-Gm-Message-State: AOJu0YwBGFcveflk0x727miL0QcPEbYTHkmD0nMI5M8jMXErMNdBIxVK
 ihgpgRZtWezuZiS024bowXCvtO8acNCdVQ0KeqdWmqCysGtn1IubZxx9V3cUe3Zdhe+R4JQNEE7
 YuvCC
X-Gm-Gg: ASbGncutxmcYBTMIjToSLWvuTKp2ztBo4+vJAnIE9MvTtbnXzmYrRmx8l1xKckfu2Rc
 0FXOg68j2nin0APP5vOLDs37NDTEM8QdiH5pOSz7UK2Xn+JHmcv77KB7G6nptavclZ4+bcPZl1C
 sPAb1wpk36xpq6xn8C3iSpXJhdL4GnXriKxnSY++B90Zv+TqpwbZVy2XKVa1oIvudGdT8JxvDU9
 RULWjNpDj+lPCS6QaEsLj9/J03o3z2oL5/35Fy1agv2h7FmrTFoSLgcOEbL4RrKCBXScDRaPUTC
 C4W76BO6ZBo5F/bWisyXuBGmhpia9JvoZY6ibjqGYs/VFHJRAymwfpM6dR6qFcr50USo/XqQJhl
 TiNwyRu7ZppNBC7+cX4khShdw6pmL
X-Google-Smtp-Source: AGHT+IHO4ZBpku6huVja5uunEa1NdGZhwig/6rs5Hy3NFPHdHcvALDmDQp+JM5fRjosFkOYSMqIgQg==
X-Received: by 2002:a17:902:f60f:b0:27d:6f37:7b66 with SMTP id
 d9443c01a7336-27ed4ac78b0mr52183065ad.47.1758845496634; 
 Thu, 25 Sep 2025 17:11:36 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed6ac37efsm35829425ad.137.2025.09.25.17.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 17:11:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 01/10] target/arm: Add isar feature test for FEAT_RME_GPC2
Date: Thu, 25 Sep 2025 17:11:25 -0700
Message-ID: <20250926001134.295547-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926001134.295547-1-richard.henderson@linaro.org>
References: <20250926001134.295547-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 512eeaf551..2214b0ee08 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -676,6 +676,11 @@ static inline bool isar_feature_aa64_rme(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR0, RME) != 0;
 }
 
+static inline bool isar_feature_aa64_rme_gpc2(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR0, RME) >= 2;
+}
+
 static inline bool isar_feature_aa64_dit(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64PFR0, DIT) != 0;
-- 
2.43.0


