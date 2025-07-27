Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F6FC87FCE
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwP3-0007ZY-J5; Sun, 27 Jul 2025 04:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwM1-0006JO-Ed
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:35 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLz-0004AP-PW
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:33 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-23dea2e01e4so45472345ad.1
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603410; x=1754208210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TMPqhlIvVePcBqPr/zfm9nD1xzcakWTsu9w+PFYmzes=;
 b=gm4/dkNneI8Kprt38MaFBzB0bzpa0i5B366pQqhav+FMI7T1eT1R0hxyhpXe9xQGdW
 sEx/wYM8YKnMdu/JAEE3B39JhSwkHKY4BuTli9Ujca2W++EQmq41vaTR8yv/4DE/U01U
 Xr4TMEYPGLwmueNoTYS2FjeT2iiAbbsKV+HLtwktNAZ5vP3j6eTeOKVx8axQXbBvYzcM
 4ATUff53WDyTM+Hx1JNP3Y89Wjh++G4HVTaJuYOtzuJsSTpRV6Hz134Smsmfdk+XrOsJ
 G0+ZRLDoMXPKCSSyopeyWlM/nPPQ0c4pDbm4Pk3zcSDHbv9+WNeYzDr8Aox3P58duzil
 a+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603410; x=1754208210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TMPqhlIvVePcBqPr/zfm9nD1xzcakWTsu9w+PFYmzes=;
 b=HTbPKIuVpvbpdiUzc3gFhRzgKf4bh/JqJZslCx0gY8bX+LyEQAe9plZcodSZu/9Duv
 AR1w5Bqxcj4JFZqMx+GCVbb/1/qg2VL40Ur81ByFCogOMSsu8JG01V7C1R8HI2GXcTga
 My5xlOuhlC/CAWYcIOqUnS6maMz1mRrCcv5qlj+0B75GF5i4SI2wypEl8z7QisgodGR6
 JZ+SQcG57LTknQ/QIucBji5F4EuOXS+7bZjIwNBazVtytFdh4ibK8cblxMNORC2UJyUI
 Afb1EulkiEVFz0rradRRolXFfgdNw6r9+Ie/voLBZyhxlbLmQd3x9VzWxsJcP+1oUvkN
 vpGA==
X-Gm-Message-State: AOJu0Yxp+OP66JO/K1XDR0UEUgBLWTWUHir+T1jN677lRor2eb7zX9o0
 tVfrPJlkCKidd8/ZlzvIHmDo7YgNxv7p+MPRGSB04vtx/W7GKgXP1CryUgSGHnIMruVQhfUruVp
 mGHHw
X-Gm-Gg: ASbGncvC0lpgvJqIHJlexnRP0yUuJjISB8GtdPcp49FRMVxIZ38UqxdINgcSw0KKmFD
 4Bcn0/RCLC6h2vJK8IUA6JXm9Me8pAqupUv6CJtpl9q2sHI0KKSVWGT1LuWPE16FgDIox2v5gR5
 3FU4pZH5le6tuxicUgDuo2XvuZhQXdoM8US/K4mvOdebIRnIQ6SuDyyC83NOsqWGn3bdwf8BLRw
 O5XRwRQHY2sQfybPqoXdLLY8czM42AQZHVcbDwITuQ2dYMG3v6DGWZLXRAgCqjkQqW/l6AQ7/eV
 2y0wetfgvlSPtaT+cV/DgWad4teO9r/ESAPEMMfgTvGq0LlTg7Kjit3d4TlS/u5GFpgH4aUyBYA
 y1BXNyvqerZRXd6ChBhR8MMaOld0LDbqzPrnPh4oYpNgGsIKvakblPTzfHVmO57J/qjsegNdPVs
 coTudYMTBEtw==
X-Google-Smtp-Source: AGHT+IEj3kNZcHnsQJUHZjOnzE4zvkn1AY6MPkHP+bxMldIPOTC9x6UwjNYtBvSg/cfDcMNZndzfow==
X-Received: by 2002:a17:902:ce0c:b0:234:a779:47cd with SMTP id
 d9443c01a7336-23fb2fffa92mr116055315ad.15.1753603410479; 
 Sun, 27 Jul 2025 01:03:30 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe333efesm30016415ad.65.2025.07.27.01.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:03:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 28/82] include/hw/core/cpu: Widen MMUIdxMap
Date: Sat, 26 Jul 2025 22:02:00 -1000
Message-ID: <20250727080254.83840-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Widen MMUIdxMap to 32 bits.  Do not yet expand NB_MMU_MODES,
but widen the map type in preparation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 2 +-
 accel/tcg/cputlb.c    | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 85b1ab4022..a95559c538 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -201,7 +201,7 @@ struct CPUClass {
  * Fix the number of mmu modes to 16.
  */
 #define NB_MMU_MODES 16
-typedef uint16_t MMUIdxMap;
+typedef uint32_t MMUIdxMap;
 
 /* Use a fully associative victim tlb of 8 entries. */
 #define CPU_VTLB_SIZE 8
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 2a6aa01c57..416aaa1040 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -89,9 +89,6 @@
  */
 QEMU_BUILD_BUG_ON(sizeof(vaddr) > sizeof(run_on_cpu_data));
 
-/* We currently can't handle more than 16 bits in the MMUIDX bitmask.
- */
-QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
 #define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
 
 static inline size_t tlb_n_entries(CPUTLBDescFast *fast)
-- 
2.43.0


