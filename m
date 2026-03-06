Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE2DFCB608
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWfA-0004bQ-Qu; Fri, 06 Mar 2026 10:00:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWf2-0004To-Jo
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:16 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWf0-0002jj-SV
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:16 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-480706554beso101650975e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809213; x=1773414013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SEBQ3zr5qos7anNs6cmfSusx7r3fjVf7mNrIRdPgNsI=;
 b=gvu3L9PnXV7Mx8LxXcFJvxCbAo7zZCdUX26Xk3MrRhueYO6kSrT9mcTAlnSmMAobKM
 53jWeMn4m96Zs3/0qkscUUG39ILBmbJtZgLcXsGCkscGAWvozMzjQsp1FpvO00JElcmG
 FCrnMJo9x5zPz/PynLKsOVX4y0F5mEOBZkWRijET3g4efZv5D/lY5TIbyqnRIYvFiCmP
 NR+404Ap24PFFvd4Q7OdRURqppJXzJNBMn8XQ51a9bCNTL1tMW7f+N2Uhr2bW4440k4g
 DfpqTmPOim+XhNn+Z73Hf7nE+8ADzNEJ7A6lY4pOJYt8I2FEncM7DArMPqNzsqeeWViU
 BQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809213; x=1773414013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SEBQ3zr5qos7anNs6cmfSusx7r3fjVf7mNrIRdPgNsI=;
 b=EQSYQP82UaUV86mhPEp6RJCPVcvvCfthv3PFHqcQw8IU4Uk4ZUR/6WeH7lC442kaE7
 8uYE+E0tQ0tqncDqKvmJ9J3vzW+RvezuL3fgLmzAzQOz+W6b6/BDvN53igZQI8gSXUVZ
 sOE8ocWz8iNhaEZZw7lboPkDGAndBgbZDWiFgA1yli2hmEAlE+5obOEVEPbRv3CXWKOJ
 16g9ZOJQ5cSVMGZWWFQ9AQMKtymCKaxHzpuTvyv/zCPFuEYBvpdF5zASYG3/JTvmlvcu
 VUV4q8QmR8KsE6ZzG57S1hHInsD+qbx0hIAN+ScdQKsb8fL2lDochy9teYq4iuhBfsrW
 Y1lg==
X-Gm-Message-State: AOJu0YwP6/ZXcyUGrMh/mZHws+3c3QBP5PACAkThJKE/6+fYoPaExIyi
 e6JvHzqVqGjtYG3ihHIkwSf0CJhl2J/hfXwhcfJ9vot6DVHkA62QRB6Tkqw9F24D0+vtX049gc1
 gIvsZ
X-Gm-Gg: ATEYQzzvMEwzWUNtQMkga7o8UsmRephPlrr2sbF7tkLsn0aWgPqkSZEuYfwVKWPoG9q
 MER+gO1vNy3Tp/hDDh03FNT9cU7+PQmOAtFOnW5WTefk8Otoy273IeU3jYm5lZyKdQBHtItJUoh
 9uVNwXpHS4HvPDye2mFtpbMCtjp+iQClgOS2gaTh+TGz6hWoKfNnnOpVlLfVOTp92lC7E+A2R4U
 SXJqnsLH5bWRD5pFYufVr2Z4oRMpmIqMI0EPUobLTJHtxv2spwj64Q5MeUk7UzP0GM6qEqs6LqB
 4WlYoGyNBbluUEpr8jYhjRtzESG/Ql0BQcRBO7kb8YrR+oCApeyBTS7c3cbr/SbGZlGsLzUG3IA
 2HDDH0AzxSWsuVS6DS14XcX7ePaDiyAlkUC7f1OsCGPLQ2qT8IHadCo3Jfgd8rfPkrzZzfm+cDH
 QHtGhpIiBaa0xAPJGxXdkugax/cxgNHFRAIU7Lpjdfeo4Qi8H2VlwKugs3C4A4VM7bScue5pIJy
 gpkX6O2GW2Y2CRluDdipm8UNzC/tH4=
X-Received: by 2002:a05:600c:8115:b0:477:a219:cdb7 with SMTP id
 5b1f17b1804b1-485268bd69fmr43876055e9.0.1772809212630; 
 Fri, 06 Mar 2026 07:00:12 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.07.00.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:00:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/49] hw/arm/smmuv3: Correct SMMUEN field name in CR0
Date: Fri,  6 Mar 2026 14:59:21 +0000
Message-ID: <20260306145939.2162189-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Tao Tang <tangtao1634@phytium.com.cn>

The FIELD macro for the SMMU enable bit in the CR0 register was
incorrectly named SMMU_ENABLE.

The ARM SMMUv3 Architecture Specification (both older IHI 0070.E.a and
newer IHI 0070.G.b) consistently refers to the SMMU enable bit as SMMUEN.

This change makes our implementation consistent with the manual.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Message-id: 20260304142344.3341444-3-tangtao1634@phytium.com.cn
Fixes: 10a83cb9887 ("hw/arm/smmuv3: Skeleton")
Link: https://lists.nongnu.org/archive/html/qemu-arm/2025-09/msg01270.html
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-internal.h       | 2 +-
 include/hw/arm/smmuv3-common.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index b666109ad9..eb482c7000 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -41,7 +41,7 @@ typedef enum SMMUTranslationClass {
 
 static inline int smmu_enabled(SMMUv3State *s)
 {
-    return FIELD_EX32(s->cr[0], CR0, SMMU_ENABLE);
+    return FIELD_EX32(s->cr[0], CR0, SMMUEN);
 }
 
 /* Command Queue Entry */
diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
index 2df54ba60f..9f78bbe89e 100644
--- a/include/hw/arm/smmuv3-common.h
+++ b/include/hw/arm/smmuv3-common.h
@@ -351,7 +351,7 @@ REG32(IDR5,                0x14)
 REG32(IIDR,                0x18)
 REG32(AIDR,                0x1c)
 REG32(CR0,                 0x20)
-    FIELD(CR0, SMMU_ENABLE,   0, 1)
+    FIELD(CR0, SMMUEN,   0, 1)
     FIELD(CR0, EVENTQEN,      2, 1)
     FIELD(CR0, CMDQEN,        3, 1)
 
-- 
2.43.0


