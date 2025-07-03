Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D83FC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 08:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFkc-0002ze-Nu; Thu, 03 Jul 2025 04:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uXFkR-0002oE-Lr; Thu, 03 Jul 2025 04:56:52 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uXFkP-0008AB-FD; Thu, 03 Jul 2025 04:56:51 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-74931666cbcso7524212b3a.0; 
 Thu, 03 Jul 2025 01:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751533006; x=1752137806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=phAr9vGsIdCZhTB64UYGMtairPbr9vOxRvodihkDwSA=;
 b=nETRPWbArckspZO47tvswNUzse2fyp/oi0Ofq4Rs0ooOP/lMQlFB9c+24UFsFFA+mF
 09n8MmToK6UQSF32rgmNkYnJIZiM1xtkPyBiecXtMF08FuHXWlo1OS7xGbbFsBOpStko
 msqeFxzYAaGKKut6cZb4dxMB2MCCzU5DOciV9ObSxT6sC6Svv4U/9WlZXEI5rOzivIRh
 LLN2xJnHQBgOnAfqyHp6Ad9NWC3WUgQFUDIIlXjXGJLrp/Xl7GqLp7obnI2ufHMGd7Vb
 laHRG2sUSa/jQR71h/bHpfWqChKoC/uAzMAWNi5FsZ4GQQmSgrJH+zi0t4aMk2M9tMrJ
 qy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751533006; x=1752137806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=phAr9vGsIdCZhTB64UYGMtairPbr9vOxRvodihkDwSA=;
 b=KCIQM+j+him01uglXpemv27SKLOeWcl3A/YoShDv3ZJJwjqVevHXaXrFer94h0EZ3j
 xhPaWMo9onmFs2K/htAugJ8vC/KHh9OlHYuIXCBHg42pGE13cgMLbAuyPFi7EHnNYECq
 PymXbeHx3NBySw4aYWYJpkZLUrC7HDD/7TKJPWfm5ONAfAk4M1wCKr2/Ip59KTDXNNaq
 xqI4dmacN5/aBQJMxdPW3a2bHcHDB6byYAKWPoEfDVvhb3CMn87jiTmKF65mSjaGMX+T
 mZf2IYP5Jcy38gTacHNt2PWkw5Zr9eGLo4TvAZ9MQC/CWt9eE8+vi0zDIK5uedyVpH0a
 AhEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTWlO5jKJrpyWI/GpsKKT46kmq257Q/sb7BedYQedswW75UHjcXyuJqgturvp4RUkWst87kbR/5g==@nongnu.org
X-Gm-Message-State: AOJu0YxQ64FigODtMTt/SMcZ6gTze7BQ6iXc5IbrLQgXdf3ZGsR56TfD
 qNDvpjOAZWl/ZbBxwAUKOdXX7wPgo5PFx4WtAQNEE+UuacXbdwAoe/IQU0nnZNkbn3o=
X-Gm-Gg: ASbGncszKfUNtC03xsmxunI6qYWGMg8PDEWU5PlZ82IiCtKySl8wZG392GRRFL3Z2II
 KoLrzpMY4nHanrMFl0n3jBZwyU19nvcoDO4zP6HwEvcQzpWDCSbn6IqC5O9/Z0edsBBs4gj0coZ
 Hsgm+ABHHCxCZ8xMqyGcj67AoWLl1+GV8HCCQ/fTNSWvBqNPawzEhCfEPEp7sdtDBU437eGTIfJ
 Ds53IqW50oMeIrTAGPwZqANLcM2Ik5aZESSjL247tD8wJsV55R8CZTBd9R6+ZtuDDsmjzppc0Wd
 HuaW3rKwmN3NnGnmLIRSKAA4kQDb0a+Rw+oWB0LH8ZYf4HFrj47JBudgUt+y18ZUxJotekHctxM
 Nopj7Y00+B/bbTMegolQcV1NVD3BOzV0pXDk6djC6bVg=
X-Google-Smtp-Source: AGHT+IGjPgOh3f/gngELKnDsb05uyXf8B/kk9F66M1qVXp/8JVWfjAobkNJzLfxyxt58dsoyQiyRQg==
X-Received: by 2002:a05:6a00:2341:b0:748:34a4:ab13 with SMTP id
 d2e1a72fcca58-74b50e8db4fmr7835945b3a.6.1751533006192; 
 Thu, 03 Jul 2025 01:56:46 -0700 (PDT)
Received: from localhost (pa49-178-74-199.pa.nsw.optusnet.com.au.
 [49.178.74.199]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-74af541d233sm17150026b3a.61.2025.07.03.01.56.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 01:56:45 -0700 (PDT)
From: William Kosasih <kosasihwilliam4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 William Kosasih <kosasihwilliam4@gmail.com>
Subject: [PATCH v4 07/11] target/arm: Fix VSTR_SG helper store alignment checks
Date: Thu,  3 Jul 2025 18:26:00 +0930
Message-ID: <20250703085604.154449-8-kosasihwilliam4@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250703085604.154449-1-kosasihwilliam4@gmail.com>
References: <20250703085604.154449-1-kosasihwilliam4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-pf1-x42c.google.com
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

This patch adds alignment checks in the store operations in the VSTR_SG
instructions.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/mve_helper.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 633f511a7e..2d21625f24 100644
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
2.48.1


