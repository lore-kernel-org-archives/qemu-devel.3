Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75D1C0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx2y-0000sP-5y; Tue, 28 Jan 2025 20:39:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2w-0000rI-F7
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:14 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx2v-0003Xr-1m
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:14 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21634338cfdso44093235ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114752; x=1738719552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p8BKUORijGQS50f4GtdAn/sy3ElbIpcuj5zDOx8ZwZA=;
 b=dv6u0OPtj/0rjrO2EYIrO8srFfQSW//iKjFWdGh9DETUgwY6zzalhe1gq8KUO29Fbq
 5CfGGCngN+G7X7DEP132pkLOafMxBVU/Vz7/muLE3V3ujkVh/gnSFx5vV8ttJnpfojtQ
 X9xHexV+5bKMQHYe5HWa0TUFJRp9Q7FG4pjXcsPBjbdIV8ngX0GXcPs+sVxKU6V/nAgc
 qh4CVy40b+pQ0KWTYyG7d+oGZiYZO8RN7jyr59RD9WYfPev3T/Fw8zmrHy/Z4IWywCan
 YyMDfis2EISAEx8EjMSQTdMyKuFdIBK0/dvcfKg/I3Y0eZsT0qHoxaAKBaNkUEohFfsN
 oMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114752; x=1738719552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p8BKUORijGQS50f4GtdAn/sy3ElbIpcuj5zDOx8ZwZA=;
 b=RrZ/voKUDibyZL6KtOGZt/7lEMnsTwTU+pf35AuBsrj5EjUX8FF3QgzRmcamzYDXK4
 p7VN+Z7NMtDlEPbewagczWxXZ4YJTMEMv8saP5cI2vM9gmsX8efQM+0IaTGRT7/mng/D
 dY/7rVCILu1wiZcLovRa4BHvJYp6hB/NL6GgpKSwnQYX8fMJ7BUVrFvJBXmpdJ5Msy4v
 lx31wV3HjEwSYe1DdYFua7yc7rFbSs4wASqWrRQgFZD/AHKwCLdKaEryWS/H8uG+ZPM0
 kviaoPrWT8mXiALW9riWKtHHq0lXrPiKjf/zFeCWYaw1jvgP3tLEkhZnUvZcFNOOxvBZ
 STEg==
X-Gm-Message-State: AOJu0Yyvvd3aznfXTvZOo94NsgtRTOE5CUWoA3tQra381iMnAXcFe5Rr
 l0PKZn4rN8A6FL1dVjcuhlnDovDdPPl4Unqc5ITxgB4ra4iSRburgS1r8VaDgGcqpMuS+lbExVf
 i
X-Gm-Gg: ASbGnctiOVzzCiU2Ff0JxeX3CWY08YNV+heveYjqWc4vwgFPXaIGcSrZ5lrrHzQ26SG
 Q065dPsfWncuxSWYWPi6K3Df3hGihaiM7aBIbSzQ8aiftrZmrOe4qKZO0SvXbdkxcD4T74K+Huy
 fxeYI3xRGOpy3Y94xqbjgNOB18eT145bd6n4zBAwKHhtPPIIAfur6CaHLA3dRhuyzDwq6UZlfxs
 1fhxeUkO2ck/1PSYNkC+Zpk4M3ulxxXt11/Sa0T6e3tdFMNLDSBVqZfrGmonoBBtkP0DSFICJw3
 lgy4UBLTdEj21DHXJ904SN90EcnpEpxILELoSuU2PTkqobmfHg==
X-Google-Smtp-Source: AGHT+IFhI6QJx8L2/9mRhT/68GFI0z6KdrPHIG/poTElaYeh47xRRx5RUUhCcQzrjO3cl7u8hQkjlA==
X-Received: by 2002:a17:903:1252:b0:216:643a:535a with SMTP id
 d9443c01a7336-21dd7c653c2mr19282195ad.20.1738114751887; 
 Tue, 28 Jan 2025 17:39:11 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.39.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:39:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 19/34] target/arm: Use float*_maybe_ah_chs in sve_ftssel_*
Date: Tue, 28 Jan 2025 17:38:42 -0800
Message-ID: <20250129013857.135256-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 target/arm/tcg/sve_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 3f38e07829..a2ff3b7f11 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -2563,8 +2563,8 @@ void HELPER(sve_ftssel_h)(void *vd, void *vn, void *vm, uint32_t desc)
         if (mm & 1) {
             nn = float16_one;
         }
-        if ((mm & 2) && !(fpcr_ah && float16_is_any_nan(nn))) {
-            nn ^= (1 << 15);
+        if (mm & 2) {
+            nn = float16_maybe_ah_chs(nn, fpcr_ah);
         }
         d[i] = nn;
     }
@@ -2581,8 +2581,8 @@ void HELPER(sve_ftssel_s)(void *vd, void *vn, void *vm, uint32_t desc)
         if (mm & 1) {
             nn = float32_one;
         }
-        if ((mm & 2) && !(fpcr_ah && float32_is_any_nan(nn))) {
-            nn ^= (1U << 31);
+        if (mm & 2) {
+            nn = float32_maybe_ah_chs(nn, fpcr_ah);
         }
         d[i] = nn;
     }
@@ -2599,8 +2599,8 @@ void HELPER(sve_ftssel_d)(void *vd, void *vn, void *vm, uint32_t desc)
         if (mm & 1) {
             nn = float64_one;
         }
-        if ((mm & 2) && !(fpcr_ah && float64_is_any_nan(nn))) {
-            nn ^= (1ULL << 63);
+        if (mm & 2) {
+            nn = float64_maybe_ah_chs(nn, fpcr_ah);
         }
         d[i] = nn;
     }
-- 
2.43.0


