Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE86C8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 11:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWvVw-0007dx-BW; Wed, 02 Jul 2025 07:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWvVu-0007dM-JC; Wed, 02 Jul 2025 07:20:30 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWvVr-0002PO-TC; Wed, 02 Jul 2025 07:20:30 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2363497cc4dso56598475ad.1; 
 Wed, 02 Jul 2025 04:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751455224; x=1752060024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C/hzap+8413Yvyp9pIK0I+0pxInqZ0jCoTiR1Po7l1Q=;
 b=LO16R4iQSL0DqIp7muEWW/rzR74g0B/AiFEj92DXwYvW6AtPeuTQJY4mdSbDLLFr0H
 Yq3HeVOCr//spimgctJhoLBocfVBfZq90fgWubAEBxRxCPiGmDkHMCNLb/TrBjG8cBvr
 nEhAvZODGpvdjvdk6AIIoPHqmuONKFQsWUqW3J8MU60Yh5sfAPViJKIimkPQ2ssViQZB
 V5qgTSU2Gut+OxgkSaFcdCSxZN9cceT2y3Fj4J3l4/cNDdmEzfbKDAaFSRtoWR8JPQOP
 zhA2RGwUvUPvKMOKnLK2onMcE2uIE//Q8z7yFhU8VeH4HYDRIPraQCVxHiQ+TRjSqAzd
 qxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751455224; x=1752060024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C/hzap+8413Yvyp9pIK0I+0pxInqZ0jCoTiR1Po7l1Q=;
 b=rgbHhBWa3w8GbUapkgHW3mj3vI621+/B6jM1Zl2v/avV7czgBHC+iVq2cl/Dsxyy4F
 EC0Wz+NOC67HBFwlYLhHCPrLF4UiJsPTl76MebENb0g/HY2HsGpuzCb4Svphe8Z8ydLb
 Xv1o+uCa6m3dOuH8Z/rgnmUN3dw5YvoDQxdgqD4TVPJRHFacVao4JlrNz6paBW5qPr3f
 IvsrDOmreYwcXIUj/6WBzVtlQA8JQ46FHVityV/LLj0P5m5YC7LJYsw8Vj3khbjYcUxJ
 TL/obbN10t2e1GsCfflX3a/C01rHW3HTHbV4Q2pRDiTOcTuFd1/ZMNEeN8SQ4MDb/FSY
 iBNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpczPSWE2lNTN6qOHkbDh7XkZUGqxHwusyrfWPjQglyMHR6NVAEhmCAozs09DdEOIwD/Ff0DFvVg==@nongnu.org
X-Gm-Message-State: AOJu0YyTUdmBSRRVkFwCUK3EOZIIpd42ndkeRTX/yAShTbs/vRjb6z2v
 jXJ8ka0IoWCfOnr8H3P4Pe+fYu1IefHADygE94YoE3BP073lhojt+fWmxH0EfLyQyS0=
X-Gm-Gg: ASbGncs4aOLHCD1hqhZVSN4PQnk+2MYNEmyyqV3rfoeGSeJ1rLLJYASzS4y5dO2DxEM
 c06wVtxwh8eB/nMKap09hDtb7EIJOMuIhoQv6hcrLpOx3Jd3HQFjqMcESi5wdSr1HrjUe3qhljD
 PtA00QKAMbVatLsz2aAgmsGhpukC9AevUqF2ioa3fAMrvrPGbJAoGopIrwBBmi648Dvyl8t3LPP
 gtptrI9dAGGZjVkGNd5rT8ke+6WZZ7bGiTfPIES+w255xslUANtPnwTV+GQSaYEfHIOTFKvlnXt
 zt0r/MluC/MWmR6nCVhDJcY+gP5/8An6Tq5J2qjXBwbFuPkXEW6IgGdKafn0DSK1LQMQuGc1PwH
 vioQBQug67KXXUasOgfRX69KxgyXwv2vx7nJBpuQkvBI=
X-Google-Smtp-Source: AGHT+IE0u8SX36kgCl8aTK3KNzpHNFzX3llQD2kAgfmjlTr7X7dUHBuVQpSX89+2J9zv2U0AlHFx4g==
X-Received: by 2002:a17:903:1664:b0:231:e331:b7df with SMTP id
 d9443c01a7336-23c6e4ffd13mr29730155ad.29.1751455223905; 
 Wed, 02 Jul 2025 04:20:23 -0700 (PDT)
Received: from localhost (pa49-178-74-199.pa.nsw.optusnet.com.au.
 [49.178.74.199]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23acb2e4c60sm127402455ad.50.2025.07.02.04.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 04:20:23 -0700 (PDT)
From: William Kosasih <kosasihwilliam4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 William Kosasih <kosasihwilliam4@gmail.com>
Subject: [PATCH v3 06/12] target/arm: Fix VLDR_SG helper load alignment checks
Date: Wed,  2 Jul 2025 20:49:48 +0930
Message-ID: <20250702111954.128563-7-kosasihwilliam4@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250702111954.128563-1-kosasihwilliam4@gmail.com>
References: <20250702111954.128563-1-kosasihwilliam4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This patch adds alignment checks in the load operations in the VLDR_SG
instructions.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
---
 target/arm/tcg/mve_helper.c | 42 ++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 9156cb8f9f..0d609668b5 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -218,7 +218,7 @@ DO_VSTR(vstrh_w, MO_TEUW, 2, stw, 4, int32_t)
  * For loads, predicated lanes are zeroed instead of retaining
  * their previous values.
  */
-#define DO_VLDR_SG(OP, LDTYPE, ESIZE, TYPE, OFFTYPE, ADDRFN, WB)        \
+#define DO_VLDR_SG(OP, MFLAG, MTYPE, LDTYPE, ESIZE, TYPE, OFFTYPE, ADDRFN, WB)\
     void HELPER(mve_##OP)(CPUARMState *env, void *vd, void *vm,         \
                           uint32_t base)                                \
     {                                                                   \
@@ -228,13 +228,15 @@ DO_VSTR(vstrh_w, MO_TEUW, 2, stw, 4, int32_t)
         uint16_t eci_mask = mve_eci_mask(env);                          \
         unsigned e;                                                     \
         uint32_t addr;                                                  \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MFLAG | MO_ALIGN, mmu_idx);        \
         for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE, eci_mask >>= ESIZE) { \
             if (!(eci_mask & 1)) {                                      \
                 continue;                                               \
             }                                                           \
             addr = ADDRFN(base, m[H##ESIZE(e)]);                        \
             d[H##ESIZE(e)] = (mask & 1) ?                               \
-                cpu_##LDTYPE##_data_ra(env, addr, GETPC()) : 0;         \
+                (MTYPE)cpu_##LDTYPE##_mmu(env, addr, oi, GETPC()) : 0;  \
             if (WB) {                                                   \
                 m[H##ESIZE(e)] = addr;                                  \
             }                                                           \
@@ -286,13 +288,15 @@ DO_VSTR(vstrh_w, MO_TEUW, 2, stw, 4, int32_t)
         uint16_t eci_mask = mve_eci_mask(env);                          \
         unsigned e;                                                     \
         uint32_t addr;                                                  \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (e = 0; e < 16 / 4; e++, mask >>= 4, eci_mask >>= 4) {      \
             if (!(eci_mask & 1)) {                                      \
                 continue;                                               \
             }                                                           \
             addr = ADDRFN(base, m[H4(e & ~1)]);                         \
             addr += 4 * (e & 1);                                        \
-            d[H4(e)] = (mask & 1) ? cpu_ldl_data_ra(env, addr, GETPC()) : 0; \
+            d[H4(e)] = (mask & 1) ? cpu_ldl_mmu(env, addr, oi, GETPC()) : 0; \
             if (WB && (e & 1)) {                                        \
                 m[H4(e & ~1)] = addr - 4;                               \
             }                                                           \
@@ -331,22 +335,26 @@ DO_VSTR(vstrh_w, MO_TEUW, 2, stw, 4, int32_t)
 #define ADDR_ADD_OSW(BASE, OFFSET) ((BASE) + ((OFFSET) << 2))
 #define ADDR_ADD_OSD(BASE, OFFSET) ((BASE) + ((OFFSET) << 3))
 
-DO_VLDR_SG(vldrb_sg_sh, ldsb, 2, int16_t, uint16_t, ADDR_ADD, false)
-DO_VLDR_SG(vldrb_sg_sw, ldsb, 4, int32_t, uint32_t, ADDR_ADD, false)
-DO_VLDR_SG(vldrh_sg_sw, ldsw, 4, int32_t, uint32_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrb_sg_sh, MO_UB, int8_t, ldb, 2, int16_t, uint16_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrb_sg_sw, MO_UB, int8_t, ldb, 4, int32_t, uint32_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrh_sg_sw, MO_TEUW, int16_t, ldw, 4, int32_t, uint32_t, ADDR_ADD, false)
 
-DO_VLDR_SG(vldrb_sg_ub, ldub, 1, uint8_t, uint8_t, ADDR_ADD, false)
-DO_VLDR_SG(vldrb_sg_uh, ldub, 2, uint16_t, uint16_t, ADDR_ADD, false)
-DO_VLDR_SG(vldrb_sg_uw, ldub, 4, uint32_t, uint32_t, ADDR_ADD, false)
-DO_VLDR_SG(vldrh_sg_uh, lduw, 2, uint16_t, uint16_t, ADDR_ADD, false)
-DO_VLDR_SG(vldrh_sg_uw, lduw, 4, uint32_t, uint32_t, ADDR_ADD, false)
-DO_VLDR_SG(vldrw_sg_uw, ldl, 4, uint32_t, uint32_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrb_sg_ub, MO_UB, uint8_t, ldb, 1, uint8_t, uint8_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrb_sg_uh, MO_UB, uint8_t, ldb, 2, uint16_t, uint16_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrb_sg_uw, MO_UB, uint8_t, ldb, 4, uint32_t, uint32_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrh_sg_uh, MO_TEUW, uint16_t, ldw, 2, uint16_t, uint16_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrh_sg_uw, MO_TEUW, uint16_t, ldw, 4, uint32_t, uint32_t, ADDR_ADD, false)
+DO_VLDR_SG(vldrw_sg_uw, MO_TEUL, uint32_t, ldl, 4, uint32_t, uint32_t, ADDR_ADD, false)
 DO_VLDR64_SG(vldrd_sg_ud, ADDR_ADD, false)
 
-DO_VLDR_SG(vldrh_sg_os_sw, ldsw, 4, int32_t, uint32_t, ADDR_ADD_OSH, false)
-DO_VLDR_SG(vldrh_sg_os_uh, lduw, 2, uint16_t, uint16_t, ADDR_ADD_OSH, false)
-DO_VLDR_SG(vldrh_sg_os_uw, lduw, 4, uint32_t, uint32_t, ADDR_ADD_OSH, false)
-DO_VLDR_SG(vldrw_sg_os_uw, ldl, 4, uint32_t, uint32_t, ADDR_ADD_OSW, false)
+DO_VLDR_SG(vldrh_sg_os_sw, MO_TEUW, int16_t, ldw, 4,
+           int32_t, uint32_t, ADDR_ADD_OSH, false)
+DO_VLDR_SG(vldrh_sg_os_uh, MO_TEUW, uint16_t, ldw, 2,
+           uint16_t, uint16_t, ADDR_ADD_OSH, false)
+DO_VLDR_SG(vldrh_sg_os_uw, MO_TEUW, uint16_t, ldw, 4,
+           uint32_t, uint32_t, ADDR_ADD_OSH, false)
+DO_VLDR_SG(vldrw_sg_os_uw, MO_TEUL, uint32_t, ldl, 4,
+           uint32_t, uint32_t, ADDR_ADD_OSW, false)
 DO_VLDR64_SG(vldrd_sg_os_ud, ADDR_ADD_OSD, false)
 
 DO_VSTR_SG(vstrb_sg_ub, stb, 1, uint8_t, ADDR_ADD, false)
@@ -362,7 +370,7 @@ DO_VSTR_SG(vstrh_sg_os_uw, stw, 4, uint32_t, ADDR_ADD_OSH, false)
 DO_VSTR_SG(vstrw_sg_os_uw, stl, 4, uint32_t, ADDR_ADD_OSW, false)
 DO_VSTR64_SG(vstrd_sg_os_ud, ADDR_ADD_OSD, false)
 
-DO_VLDR_SG(vldrw_sg_wb_uw, ldl, 4, uint32_t, uint32_t, ADDR_ADD, true)
+DO_VLDR_SG(vldrw_sg_wb_uw, MO_TEUL, uint32_t, ldl, 4, uint32_t, uint32_t, ADDR_ADD, true)
 DO_VLDR64_SG(vldrd_sg_wb_ud, ADDR_ADD, true)
 DO_VSTR_SG(vstrw_sg_wb_uw, stl, 4, uint32_t, ADDR_ADD, true)
 DO_VSTR64_SG(vstrd_sg_wb_ud, ADDR_ADD, true)
-- 
2.48.1


