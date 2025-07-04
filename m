Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F77C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjE1-0008JL-8S; Fri, 04 Jul 2025 12:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjDu-0008At-VL
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:14 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjDs-00064e-SW
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:14 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-450cf0120cdso8786255e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646311; x=1752251111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rrdXGVKsIjSwX3vkeNxmtYDX97ChzZEx/IEj9RH0imo=;
 b=XM+dbPqxcKdij96gvlFpvBJZYCQ8L5PVJHt4bjWi5NOI7L06agXx0QvWa3KWnjKpsa
 pslZGuO8ToJtD6NBxTZ2OoUziQPmJt9BqXc3VD9M+LBWCNsglS+NIex4EMzvg+MDGvxm
 CZaWnjjDlGJ0iHnt6pL2ezEtk7eNVln3tvyZHwPONQP1k4ov72eMWbYBvzMmcvAhbmI6
 NVsoKXsYNdDMW62+F62Azj4tSO8sGxWuTSg2gvpUaHCEUdTYkzgHsG2nFytqbCMC3+Kp
 Xhx682v8URSzGmxNbS3HdolXyqchGRIX/5JCplkjJzJbrFlbLdtMBYJ/OlYLhcvlAmnr
 JIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646311; x=1752251111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rrdXGVKsIjSwX3vkeNxmtYDX97ChzZEx/IEj9RH0imo=;
 b=vF7XkgLwR6+Nus7CVClA6ofxRJ8mHuv/sENuPBjqRsA+UbUbkmpe0do+Eqm8j62+EA
 Ff75pXV9A2QHY7rYUVCmPUj64SxxmFegMSdFUIaWiyxsWH5RqM9hr1Mai4hEalJrTCkT
 ZIKt/AKIgOaV1oGHjneakIWDUCa16EtkY+mBfZ/NQ44fC48Kjq0bXIQNoQLtGGWS6KXE
 BoH68+8Z3iP19IqXuV2n4Cceuhf8OQczP2bURA1BSccupjmrUFUpsmaAc3S+Ch3Enn0u
 00gKbikUR2ViWaNTnxeV1U3ly+xqsN62N26G0xfmsBswbwYP7SDdGiv8xfNi1Y4pS5MT
 CmPA==
X-Gm-Message-State: AOJu0YzZKwSnoSgu2AKyter89JAE8UXOzfRlLiWjGfB50JvrlCQz3qIz
 L19y6vuOepG3rWAJobbFZk3PS6pGJEdKYoMasw5Yf/95qtr+1suXTaAdbrOJW59r8JdlkCM7iJI
 I0w5j
X-Gm-Gg: ASbGncuGpf/5UzcVzD7ZaAlJioI84UUKxeBDbgUJjdQycOM8kQ9K/gDlAAAskH0y2/0
 iQwifRhsRvVY4UR8YV0GI5EPoVR0Oj/Q1mE+jjQEsHC//UezFoHdPROWY0oa8g0Lufb1oKxrghI
 WBc4faiRFAH6d3RCdQqCBrEUGITka6EOP3lmiEon9r8HucYChcotrzZKiCKJ5FVHMFiPGUVJLsj
 0GMqMY4/Kse2FlcfGDojCyDyCCd1f43cXvdzV91JZv/V/7h2dZgwTfMxSOu133Gtum8YE6zK3ND
 yBncSMbGA+bzsA/N2ilptrCtwpkrQsSxh+tqQYWxaT5Fz/yXzy2cXiURxJpPhc0r/BUK
X-Google-Smtp-Source: AGHT+IGlPvXHlnaYP7TnD3VuUvesTp8wTkSBUNoWaBOYmXqtnjg2C+DIqm/L71g+VS1sRzobnwAiVA==
X-Received: by 2002:a05:600c:45cf:b0:43d:47b7:b32d with SMTP id
 5b1f17b1804b1-454b4eb7f3bmr27954715e9.25.1751646311045; 
 Fri, 04 Jul 2025 09:25:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 008/119] target/arm: Fix VSTR_SG helper store alignment checks
Date: Fri,  4 Jul 2025 17:23:08 +0100
Message-ID: <20250704162501.249138-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: William Kosasih <kosasihwilliam4@gmail.com>

This patch adds alignment checks in the store operations in the VSTR_SG
instructions.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250703085604.154449-8-kosasihwilliam4@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/mve_helper.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 633f511a7e6..2d21625f244 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -245,7 +245,7 @@ DO_VSTR(vstrh_w, MO_TEUW, 2, stw, 4, int32_t)
     }
 
 /* We know here TYPE is unsigned so always the same as the offset type */
-#define DO_VSTR_SG(OP, STTYPE, ESIZE, TYPE, ADDRFN, WB)                 \
+#define DO_VSTR_SG(OP, MFLAG, STTYPE, ESIZE, TYPE, ADDRFN, WB)          \
     void HELPER(mve_##OP)(CPUARMState *env, void *vd, void *vm,         \
                           uint32_t base)                                \
     {                                                                   \
@@ -255,13 +255,15 @@ DO_VSTR(vstrh_w, MO_TEUW, 2, stw, 4, int32_t)
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
             if (mask & 1) {                                             \
-                cpu_##STTYPE##_data_ra(env, addr, d[H##ESIZE(e)], GETPC()); \
+                cpu_##STTYPE##_mmu(env, addr, d[H##ESIZE(e)], oi, GETPC()); \
             }                                                           \
             if (WB) {                                                   \
                 m[H##ESIZE(e)] = addr;                                  \
@@ -314,6 +316,8 @@ DO_VSTR(vstrh_w, MO_TEUW, 2, stw, 4, int32_t)
         uint16_t eci_mask = mve_eci_mask(env);                          \
         unsigned e;                                                     \
         uint32_t addr;                                                  \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
         for (e = 0; e < 16 / 4; e++, mask >>= 4, eci_mask >>= 4) {      \
             if (!(eci_mask & 1)) {                                      \
                 continue;                                               \
@@ -321,7 +325,7 @@ DO_VSTR(vstrh_w, MO_TEUW, 2, stw, 4, int32_t)
             addr = ADDRFN(base, m[H4(e & ~1)]);                         \
             addr += 4 * (e & 1);                                        \
             if (mask & 1) {                                             \
-                cpu_stl_data_ra(env, addr, d[H4(e)], GETPC());          \
+                cpu_stl_mmu(env, addr, d[H4(e)], oi, GETPC());          \
             }                                                           \
             if (WB && (e & 1)) {                                        \
                 m[H4(e & ~1)] = addr - 4;                               \
@@ -357,22 +361,22 @@ DO_VLDR_SG(vldrw_sg_os_uw, MO_TEUL, uint32_t, ldl, 4,
            uint32_t, uint32_t, ADDR_ADD_OSW, false)
 DO_VLDR64_SG(vldrd_sg_os_ud, ADDR_ADD_OSD, false)
 
-DO_VSTR_SG(vstrb_sg_ub, stb, 1, uint8_t, ADDR_ADD, false)
-DO_VSTR_SG(vstrb_sg_uh, stb, 2, uint16_t, ADDR_ADD, false)
-DO_VSTR_SG(vstrb_sg_uw, stb, 4, uint32_t, ADDR_ADD, false)
-DO_VSTR_SG(vstrh_sg_uh, stw, 2, uint16_t, ADDR_ADD, false)
-DO_VSTR_SG(vstrh_sg_uw, stw, 4, uint32_t, ADDR_ADD, false)
-DO_VSTR_SG(vstrw_sg_uw, stl, 4, uint32_t, ADDR_ADD, false)
+DO_VSTR_SG(vstrb_sg_ub, MO_UB, stb, 1, uint8_t, ADDR_ADD, false)
+DO_VSTR_SG(vstrb_sg_uh, MO_UB, stb, 2, uint16_t, ADDR_ADD, false)
+DO_VSTR_SG(vstrb_sg_uw, MO_UB, stb, 4, uint32_t, ADDR_ADD, false)
+DO_VSTR_SG(vstrh_sg_uh, MO_TEUW, stw, 2, uint16_t, ADDR_ADD, false)
+DO_VSTR_SG(vstrh_sg_uw, MO_TEUW, stw, 4, uint32_t, ADDR_ADD, false)
+DO_VSTR_SG(vstrw_sg_uw, MO_TEUL, stl, 4, uint32_t, ADDR_ADD, false)
 DO_VSTR64_SG(vstrd_sg_ud, ADDR_ADD, false)
 
-DO_VSTR_SG(vstrh_sg_os_uh, stw, 2, uint16_t, ADDR_ADD_OSH, false)
-DO_VSTR_SG(vstrh_sg_os_uw, stw, 4, uint32_t, ADDR_ADD_OSH, false)
-DO_VSTR_SG(vstrw_sg_os_uw, stl, 4, uint32_t, ADDR_ADD_OSW, false)
+DO_VSTR_SG(vstrh_sg_os_uh, MO_TEUW, stw, 2, uint16_t, ADDR_ADD_OSH, false)
+DO_VSTR_SG(vstrh_sg_os_uw, MO_TEUW, stw, 4, uint32_t, ADDR_ADD_OSH, false)
+DO_VSTR_SG(vstrw_sg_os_uw, MO_TEUL, stl, 4, uint32_t, ADDR_ADD_OSW, false)
 DO_VSTR64_SG(vstrd_sg_os_ud, ADDR_ADD_OSD, false)
 
 DO_VLDR_SG(vldrw_sg_wb_uw, MO_TEUL, uint32_t, ldl, 4, uint32_t, uint32_t, ADDR_ADD, true)
 DO_VLDR64_SG(vldrd_sg_wb_ud, ADDR_ADD, true)
-DO_VSTR_SG(vstrw_sg_wb_uw, stl, 4, uint32_t, ADDR_ADD, true)
+DO_VSTR_SG(vstrw_sg_wb_uw, MO_TEUL, stl, 4, uint32_t, ADDR_ADD, true)
 DO_VSTR64_SG(vstrd_sg_wb_ud, ADDR_ADD, true)
 
 /*
-- 
2.43.0


