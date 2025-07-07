Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD0AC83030
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 21:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYt0H-0002qo-SH; Mon, 07 Jul 2025 17:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYsLO-0005Os-6e
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:21:51 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYsLK-0004LK-GS
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:21:40 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4a44b0ed780so39862231cf.3
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 13:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751919697; x=1752524497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eSuF9K3X4zPNfJxzAcnALHIJ2U7+0NqG2hBWUtM7d8s=;
 b=iVSVvsCeVnvBp6YadeAp8Xq9hMchxQ1crXlccmw+ZcmY8+Ny4YJlUbwGvVgILRZKkx
 eBQRd0IsutPo+5EMAMktnEec4wnvsqoSCo4VH/miL4nOD2Ljgjf7+1d90535Cmok2o/S
 tcCfxuQu/49J/V4ZZ67P6Mx7eOlr5SE3GZ7kbaZpt4NaN/xXObMK7sfhcgcMCBkCIHmA
 KYVLLb+HzI0Fs0n/jGwdYT1mXwCneT4lrdA6LoEmbQIBjpykavmepeGGAtj9Y2RwD+IF
 uSrCQQ2miZ3wWNUSUURKCLvRVjVOvKxkm3YDQz7DkC0EHrepVouvqvap5HS9RlzRGivD
 qf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751919697; x=1752524497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eSuF9K3X4zPNfJxzAcnALHIJ2U7+0NqG2hBWUtM7d8s=;
 b=M9hla8XWX3wY3uOHVWU+Tgr4fWaJz8o8pCBowMngx0HZPYaD8BI970pSrwCCn4Q4tH
 mqSuCvLTN/dfDeeduFbrPFFD+mbyR0XySmrWmJtuTHxEYNhtof+jvyOwRI9Yv25G6ojc
 brPjVvX6zGnNB8jPhTOzAKrgMvd8PU2v8bRMDN17HZb3kcXb+6z5pL6hDZaVyOOTGo4j
 co3QT/LWxoNw8+cZdhJhz/DJWvXxMuLLDYxnyyDRPY81Rn9XqDpm7usNTDflWpfnccVI
 cbO9JrsD8ytvj5wumvoRacnbXFSi2gqp8jyt5nTL43sKwvJd4nB1MEuKROvjPm+DRPtS
 Jx+g==
X-Gm-Message-State: AOJu0YykynsPQjDDWkvRWNwLPBhXPdOPhpobdonEQTOR1rNC+QbLt5dZ
 eyw4qdZQuUKm2oMUj0zemZmhIptlWJKsC1lsrOPpSLV072DRUFt5b5aeokyIj3MC6OIPl4HJ4Yz
 1lvb7d6Y=
X-Gm-Gg: ASbGncsZCmiCo1bS9U+d05o76PrPUiWvx4rqJgHjSpD0ccPHPZtxL4jS6KU3nBVsP5p
 wxqUtXzWCKeAEwqfRWVHY10dwUF8K2pRGqiEQXHAloG/qvKFmOlCk8PiYHLQaoE6B4A7iUDFcBR
 UFaNhXNKwMyCTyx3+atacva7UzX649KkUxoKrZ4vEodRy+Kf7FSgctmonFfpVJgmOeFmmlg9WGV
 66M/Tsp+Y/9z0b7+dbAlBfVDRcL154wR1UhcrWh/bMDDPahJKf1HXmae82zdGSXpdZxFvbvMCBB
 QrjMZTgT3H1k8ehLOi1CZaDKJM6MtxcWV5uumx4YkUvtq61uoJKnKjoZXFLjTMMAvH/gJ0iQR5i
 KGap+6kE/KAPCMM+2
X-Google-Smtp-Source: AGHT+IEN/5e3/o3rySNa2FlylcSkaoQIltypqmb1Ky7W/et+6+3BCJdZ3NhwYqcYcdzUUq6EQG9Rxg==
X-Received: by 2002:a05:622a:15d3:b0:4a4:3d27:77a8 with SMTP id
 d75a77b69052e-4a996441c88mr220820201cf.6.1751919697124; 
 Mon, 07 Jul 2025 13:21:37 -0700 (PDT)
Received: from stoup.. ([172.58.142.143]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a78dd4sm69050351cf.51.2025.07.07.13.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 13:21:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 12/20] target/arm: Convert get_phys_addr_gpc to access_perm
Date: Mon,  7 Jul 2025 14:21:03 -0600
Message-ID: <20250707202111.293787-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707202111.293787-1-richard.henderson@linaro.org>
References: <20250707202111.293787-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x831.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index fef9e9a7cb..adc681da41 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -80,7 +80,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
 
 static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
                               vaddr address,
-                              MMUAccessType access_type, MemOp memop,
+                              unsigned access_perm, MemOp memop,
                               GetPhysAddrResult *result,
                               ARMMMUFaultInfo *fi);
 
@@ -584,7 +584,7 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
         };
         GetPhysAddrResult s2 = { };
 
-        if (get_phys_addr_gpc(env, &s2ptw, addr, MMU_DATA_LOAD, 0, &s2, fi)) {
+        if (get_phys_addr_gpc(env, &s2ptw, addr, PAGE_READ, 0, &s2, fi)) {
             goto fail;
         }
 
@@ -3522,11 +3522,11 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
 
 static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
                               vaddr address,
-                              MMUAccessType access_type, MemOp memop,
+                              unsigned access_perm, MemOp memop,
                               GetPhysAddrResult *result,
                               ARMMMUFaultInfo *fi)
 {
-    if (get_phys_addr_nogpc(env, ptw, address, 1 << access_type,
+    if (get_phys_addr_nogpc(env, ptw, address, access_perm,
                             memop, result, fi)) {
         return true;
     }
@@ -3627,7 +3627,7 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
         .in_space = arm_mmu_idx_to_security_space(env, mmu_idx),
     };
 
-    return get_phys_addr_gpc(env, &ptw, address, access_type,
+    return get_phys_addr_gpc(env, &ptw, address, 1 << access_type,
                              memop, result, fi);
 }
 
@@ -3641,7 +3641,7 @@ static hwaddr arm_cpu_get_phys_page(CPUARMState *env, vaddr addr,
     };
     GetPhysAddrResult res = {};
     ARMMMUFaultInfo fi = {};
-    bool ret = get_phys_addr_gpc(env, &ptw, addr, MMU_DATA_LOAD, 0, &res, &fi);
+    bool ret = get_phys_addr_gpc(env, &ptw, addr, PAGE_READ, 0, &res, &fi);
     *attrs = res.f.attrs;
 
     if (ret) {
-- 
2.43.0


