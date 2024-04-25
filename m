Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147AEC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWe-0002Lb-CC; Thu, 25 Apr 2024 06:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWW-00022g-HH
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:16 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWT-0007DV-Tz
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:15 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-516d2600569so963440e87.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041612; x=1714646412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JV5XMEidgBDiNWN22aPz5h+5c0+tMvdllGUtHuIZpHI=;
 b=irGiofG4r9+aaPM6cQW6bYoyQhKJ1EvmoY+rw+q25K0bQCSXD8apycWfRxmbNTOx2B
 /k30983yTE771pW3NJI4Zdid1ZoRdhRoJEoOFHRPhQzdHaIz12QOLvm15+KeP8V5YOXI
 vDzhQem6SdXi9GZpRbk33iYUiCCMPQ0gtyi501XRCBPNwhiGjEnhsOf9xCjM8FK7a+VA
 5IJVPkEVG3z+xco10LmECME4rfarW6BfTd6sEHqU+DScPbK+LtqeAZlYM6MCMAdAVXjQ
 76CmI+h5hYSD9CUmE8liA2CL1j9kOesJoCeX+sSfaHAWd9NK/KPc5YIDeB811iMX1UZo
 /UOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041612; x=1714646412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JV5XMEidgBDiNWN22aPz5h+5c0+tMvdllGUtHuIZpHI=;
 b=Qz1qNq9V2JtBs2panBd1gL8IONJaQfLmR/cS2RFN0XUSdRjJGPc95GAsPXkVm9Mb48
 6efw+YC1pVaFel6S12ASRHZ/AzcPOr4Cn6Hx0YcpSSWe9J6nMQoeua/PnvQe6VXO8EAI
 IflY1Teq9og/ypbW4noaDW00AgTKASualPfwQWnwcLXBEF5amaInaa76pGRaEiC0e7Kw
 zoHbFXq8n9IKpn0YXoBozn/RaYwdL95iKj2j8LUS01qWmzRh6mmHip69LEv19mw5M09R
 TXLt1M0QloYl758AdffejKRPcX05GHbspPr3tVajjkIia/tY6bGs4NoFgu0jpKa961P0
 SZeA==
X-Gm-Message-State: AOJu0YzHz58hS+8hgCVNhj4EqWceR54CmQj58TG9E/p8fXVLJKI3BPhQ
 pBuClKILYoFb6Oi356JKLbnSmwcLAasItBjtznPp0QFIFmBhKdjNmjl+x9sjqYSd1TwS9tVMtfZ
 4
X-Google-Smtp-Source: AGHT+IFVXlkurRzX9LA2OG+QRP2l+UxVnaULQ9lEaBmu3LH7/fpwgHOnxiqYwUB2K7Zf0QCA0FHzyw==
X-Received: by 2002:a05:6512:406:b0:516:d2b9:d112 with SMTP id
 u6-20020a056512040600b00516d2b9d112mr3657626lfk.40.1714041612022; 
 Thu, 25 Apr 2024 03:40:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/37] target/arm: Add FEAT_NMI to max
Date: Thu, 25 Apr 2024 11:39:44 +0100
Message-Id: <20240425103958.3237225-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

Enable FEAT_NMI on the 'max' CPU.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240407081733.3231820-24-ruanjinjie@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 2a7bbb82dc4..a9ae7ede9fc 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -64,6 +64,7 @@ the following architecture extensions:
 - FEAT_MTE (Memory Tagging Extension)
 - FEAT_MTE2 (Memory Tagging Extension)
 - FEAT_MTE3 (MTE Asymmetric Fault Handling)
+- FEAT_NMI (Non-maskable Interrupt)
 - FEAT_NV (Nested Virtualization)
 - FEAT_NV2 (Enhanced nested virtualization support)
 - FEAT_PACIMP (Pointer authentication - IMPLEMENTATION DEFINED algorithm)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 9f7a9f3d2cc..62c4663512b 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1175,6 +1175,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR1, RAS_FRAC, 0);  /* FEAT_RASv1p1 + FEAT_DoubleFault */
     t = FIELD_DP64(t, ID_AA64PFR1, SME, 1);       /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_2 */
+    t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
     cpu->isar.id_aa64pfr1 = t;
 
     t = cpu->isar.id_aa64mmfr0;
-- 
2.34.1


