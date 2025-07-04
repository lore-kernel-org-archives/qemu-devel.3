Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A696C83F0B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjGO-0007kr-5H; Fri, 04 Jul 2025 12:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFQ-0004Vk-V1
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:48 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFN-0006wC-W5
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:48 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a4f379662cso967796f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646404; x=1752251204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6K0F34FigkpyX4WwzbDoJLuWwa3uYnwM9W8KEMx00Wk=;
 b=RfSAtarnOuarGW6nRY4HJI3QK9zL3ZxkabyA9NzHtCpWGm0InItmOV6kCEmN1wKHBm
 rarVyWSk482J8ifSGffqoKeTsoU2nt9qcvemDUbep848xxQf4Yj4FoT1icPonpspeifx
 Gjxzm+D/MrKBJpq8CQe06rtmXiWfJLaWAVNDcKIJO8iZ8rCnrD5ZCK9UOmuTJp7IqWu0
 KKzYbv0SwVort0PHECQx6Mw5e/oa/TUGXb1owj4m2IMQDGHy/6oz8SldKgfZsDxh6+lN
 sqnbUKl1/eL5eZwDGrkfvPNz9HgYpNWdYmThaC0TVuRfUASbUUzQ0Crkx0ZyBRoiiZYd
 UHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646404; x=1752251204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6K0F34FigkpyX4WwzbDoJLuWwa3uYnwM9W8KEMx00Wk=;
 b=d7f9G+MEVZIQYs7NX0OSULtM7YOlA8BVp1DR3k02aLHPFMMZx7bGOb32el685A76Hs
 zn+UjeFRozxzLrjBVOy5eC4hEjfrYtzLXz68JYMEfQ3RzQbxvbkkMPhyC7heHlJYXEgo
 7hSocJvovm+rBCqI46TjdAcPbWlUwawOm9XIxmsj3jGCFyNZCSCEGYMfKhGiFEiMn+1j
 o6N9LtGaP+9remkLboft7x9zJlK175VwG9ylYombs/kwKiECMjMCPdQyUXcsM7SlFntG
 IDlBzO2NL5jYec4EyulziHTqh4a5+gYLbztHdghGN3VN5z2C3smYzsz0MmMD2/74uE/u
 I4lA==
X-Gm-Message-State: AOJu0YwYOJgrY3fxhJHt1PXpegV/tvCemTwOCk9BJfOqDRDBjjda4Tfl
 HIRrqJRVmfvosmOSzg8UGsFkdTTpdNG6yo/Dmk1/LIB5yV29pD66KqHJyYwaLFxWeoCDiFmW9PE
 G8UQ9
X-Gm-Gg: ASbGnctn5PUC8EAULfLHi+nALumvF8zlrLD1z0eodZRyyZZ3XPB89k65GlhZW4uYeMB
 /gogyMmPDfEBw+feXPEYce/2nKvG+QLasHjeNFuyrgx8bXfwq4v2W6XbavnZxiQ1l8XBzQF5GKI
 JloCuJ/4FhhPuaapNdXGu2pJhuQBMf8Nb0KVRWuhdhw5w578LD32j0gx9eQWif7wlPJhqzmYr9n
 rVcLRLE6swVb40ypN9IJRC5dJnNsIRcUNZ5tACy5wC5bA5+xJ4CpbGROqpF4u5yDgCsPQnrsWrF
 ltco1cl4ccvzJp1K83o4FizGvFUEWTFCpUpajIsUUR3buclFiegukt6AAnGQTKmueJym
X-Google-Smtp-Source: AGHT+IE1bXdfA58D0kPDSP3LuA1+2ci3zoNH9aoP/aNS6rOfW4abdVJkMUOGsEwz2og1NXtQySNSqA==
X-Received: by 2002:a05:6000:4386:b0:3a8:6262:6ef5 with SMTP id
 ffacd0b85a97d-3b496fef6bcmr2977691f8f.10.1751646403957; 
 Fri, 04 Jul 2025 09:26:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 107/119] target/arm: Implement {LD1, ST1}{W,
 D} (128-bit element) for SVE2p1
Date: Fri,  4 Jul 2025 17:24:47 +0100
Message-ID: <20250704162501.249138-108-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-96-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sve.h        |  22 +++++
 target/arm/tcg/sve_ldst_internal.h |  26 ++++++
 target/arm/tcg/sve.decode          |  20 +++++
 target/arm/tcg/sve_helper.c        |   6 ++
 target/arm/tcg/translate-sve.c     | 136 +++++++++++++++++++++++------
 5 files changed, 183 insertions(+), 27 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index c4736d75105..1999c4bb1fa 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -1678,9 +1678,15 @@ DEF_HELPER_FLAGS_4(sve_ld1hds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld1sdu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld1sds_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
+DEF_HELPER_FLAGS_4(sve_ld1squ_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1dqu_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
 DEF_HELPER_FLAGS_4(sve_ld1sdu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld1sds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
+DEF_HELPER_FLAGS_4(sve_ld1squ_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1dqu_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
 DEF_HELPER_FLAGS_4(sve_ld1bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld2bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld3bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
@@ -1736,9 +1742,15 @@ DEF_HELPER_FLAGS_4(sve_ld1hds_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld1sdu_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld1sds_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
+DEF_HELPER_FLAGS_4(sve_ld1squ_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1dqu_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
 DEF_HELPER_FLAGS_4(sve_ld1sdu_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld1sds_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
+DEF_HELPER_FLAGS_4(sve_ld1squ_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ld1dqu_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
 DEF_HELPER_FLAGS_4(sve_ldff1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ldff1bhu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ldff1bsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
@@ -1946,6 +1958,11 @@ DEF_HELPER_FLAGS_4(sve_st1hd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st1sd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st1sd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
+DEF_HELPER_FLAGS_4(sve_st1sq_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1sq_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1dq_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1dq_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
 DEF_HELPER_FLAGS_4(sve_st1bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st2bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st3bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
@@ -1993,6 +2010,11 @@ DEF_HELPER_FLAGS_4(sve_st1hd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st1sd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st1sd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
+DEF_HELPER_FLAGS_4(sve_st1sq_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1sq_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1dq_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1dq_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
 DEF_HELPER_FLAGS_6(sve_ldbsu_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_6(sve_ldhsu_le_zsu, TCG_CALL_NO_WG,
diff --git a/target/arm/tcg/sve_ldst_internal.h b/target/arm/tcg/sve_ldst_internal.h
index f2243daf370..e87beba4357 100644
--- a/target/arm/tcg/sve_ldst_internal.h
+++ b/target/arm/tcg/sve_ldst_internal.h
@@ -116,6 +116,31 @@ DO_ST_PRIM_2(sd, H1_8, uint64_t, uint32_t, stl)
 DO_LD_PRIM_2(dd, H1_8, uint64_t, uint64_t, ldq)
 DO_ST_PRIM_2(dd, H1_8, uint64_t, uint64_t, stq)
 
+#define DO_LD_PRIM_3(NAME, FUNC) \
+    static inline void sve_##NAME##_host(void *vd,                      \
+        intptr_t reg_off, void *host)                                   \
+    { sve_##FUNC##_host(vd, reg_off, host);                             \
+      *(uint64_t *)(vd + reg_off + 8) = 0; }                            \
+    static inline void sve_##NAME##_tlb(CPUARMState *env, void *vd,     \
+        intptr_t reg_off, target_ulong addr, uintptr_t ra)              \
+    { sve_##FUNC##_tlb(env, vd, reg_off, addr, ra);                     \
+      *(uint64_t *)(vd + reg_off + 8) = 0; }
+
+DO_LD_PRIM_3(ld1squ_be, ld1sdu_be)
+DO_LD_PRIM_3(ld1squ_le, ld1sdu_le)
+DO_LD_PRIM_3(ld1dqu_be, ld1dd_be)
+DO_LD_PRIM_3(ld1dqu_le, ld1dd_le)
+
+#define sve_st1sq_be_host  sve_st1sd_be_host
+#define sve_st1sq_le_host  sve_st1sd_le_host
+#define sve_st1sq_be_tlb   sve_st1sd_be_tlb
+#define sve_st1sq_le_tlb   sve_st1sd_le_tlb
+
+#define sve_st1dq_be_host  sve_st1dd_be_host
+#define sve_st1dq_le_host  sve_st1dd_le_host
+#define sve_st1dq_be_tlb   sve_st1dd_be_tlb
+#define sve_st1dq_le_tlb   sve_st1dd_le_tlb
+
 #undef DO_LD_TLB
 #undef DO_ST_TLB
 #undef DO_LD_HOST
@@ -123,6 +148,7 @@ DO_ST_PRIM_2(dd, H1_8, uint64_t, uint64_t, stq)
 #undef DO_ST_PRIM_1
 #undef DO_LD_PRIM_2
 #undef DO_ST_PRIM_2
+#undef DO_LD_PRIM_3
 
 /*
  * Resolve the guest virtual address to info->host and info->flags.
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 70207718984..bf33bc305fc 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1240,12 +1240,24 @@ LD1_zpiz        1000010 .. 01 ..... 1.. ... ..... ..... \
 
 # SVE contiguous load (scalar plus scalar)
 LD_zprr         1010010 .... ..... 010 ... ..... .....    @rprr_load_dt nreg=0
+# LD1W (128-bit element)
+LD_zprr         1010010 1000 rm:5  100 pg:3 rn:5 rd:5     \
+                &rprr_load dtype=16 nreg=0
+# LD1D (128-bit element)
+LD_zprr         1010010 1100 rm:5  100 pg:3 rn:5 rd:5     \
+                &rprr_load dtype=17 nreg=0
 
 # SVE contiguous first-fault load (scalar plus scalar)
 LDFF1_zprr      1010010 .... ..... 011 ... ..... .....    @rprr_load_dt nreg=0
 
 # SVE contiguous load (scalar plus immediate)
 LD_zpri         1010010 .... 0.... 101 ... ..... .....    @rpri_load_dt nreg=0
+# LD1W (128-bit element)
+LD_zpri         1010010 1000 1 imm:s4 001 pg:3 rn:5 rd:5  \
+                &rpri_load dtype=16 nreg=0
+# LD1D (128-bit element)
+LD_zpri         1010010 1100 1 imm:s4 001 pg:3 rn:5 rd:5  \
+                &rpri_load dtype=17 nreg=0
 
 # SVE contiguous non-fault load (scalar plus immediate)
 LDNF1_zpri      1010010 .... 1.... 101 ... ..... .....    @rpri_load_dt nreg=0
@@ -1344,6 +1356,10 @@ ST_zpri         1110010 10 11     0.... 111 ... ..... ..... \
                 @rpri_store msz=2 esz=3 nreg=0
 ST_zpri         1110010 11 11     0.... 111 ... ..... ..... \
                 @rpri_store msz=3 esz=3 nreg=0
+ST_zpri         1110010 10 00     0.... 111 ... ..... ..... \
+                @rpri_store msz=2 esz=4 nreg=0
+ST_zpri         1110010 11 10     0.... 111 ... ..... ..... \
+                @rpri_store msz=3 esz=4 nreg=0
 
 # SVE contiguous store (scalar plus scalar)
 # ST1B, ST1H, ST1W, ST1D; require msz <= esz
@@ -1358,6 +1374,10 @@ ST_zprr         1110010 10 11     ..... 010 ... ..... ..... \
                 @rprr_store msz=2 esz=3 nreg=0
 ST_zprr         1110010 11 11     ..... 010 ... ..... ..... \
                 @rprr_store msz=3 esz=3 nreg=0
+ST_zprr         1110010 10 00     ..... 010 ... ..... ..... \
+                @rprr_store msz=2 esz=4 nreg=0
+ST_zprr         1110010 11 10     ..... 010 ... ..... ..... \
+                @rprr_store msz=3 esz=4 nreg=0
 
 # SVE contiguous non-temporal store (scalar plus immediate)  (nreg == 0)
 # SVE store multiple structures (scalar plus immediate)      (nreg != 0)
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index e6342990fa8..91cd5970ee7 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -6359,6 +6359,9 @@ DO_LD1_2(ld1sds, MO_64, MO_32)
 
 DO_LD1_2(ld1dd,  MO_64, MO_64)
 
+DO_LD1_2(ld1squ, MO_32, MO_128)
+DO_LD1_2(ld1dqu, MO_64, MO_128)
+
 #undef DO_LD1_1
 #undef DO_LD1_2
 
@@ -6981,6 +6984,9 @@ DO_STN_2(2, dd, MO_64, MO_64)
 DO_STN_2(3, dd, MO_64, MO_64)
 DO_STN_2(4, dd, MO_64, MO_64)
 
+DO_STN_2(1, sq, MO_128, MO_32)
+DO_STN_2(1, dq, MO_128, MO_64)
+
 #undef DO_STN_1
 #undef DO_STN_2
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index dfb53e4bf40..8e945c5d2d5 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4817,21 +4817,25 @@ static bool trans_STR_pri(DisasContext *s, arg_rri *a)
  */
 
 /* The memory mode of the dtype.  */
-static const MemOp dtype_mop[16] = {
+static const MemOp dtype_mop[19] = {
     MO_UB, MO_UB, MO_UB, MO_UB,
     MO_SL, MO_UW, MO_UW, MO_UW,
     MO_SW, MO_SW, MO_UL, MO_UL,
-    MO_SB, MO_SB, MO_SB, MO_UQ
+    MO_SB, MO_SB, MO_SB, MO_UQ,
+    /* Artificial values used by decode */
+    MO_UL, MO_UQ, MO_128,
 };
 
 #define dtype_msz(x)  (dtype_mop[x] & MO_SIZE)
 
 /* The vector element size of dtype.  */
-static const uint8_t dtype_esz[16] = {
+static const uint8_t dtype_esz[19] = {
     0, 1, 2, 3,
     3, 1, 2, 3,
     3, 2, 2, 3,
-    3, 2, 1, 3
+    3, 2, 1, 3,
+    /* Artificial values used by decode */
+    4, 4, 4,
 };
 
 uint32_t make_svemte_desc(DisasContext *s, unsigned vsz, uint32_t nregs,
@@ -4882,7 +4886,7 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
 }
 
 /* Indexed by [mte][be][dtype][nreg] */
-static gen_helper_gvec_mem * const ldr_fns[2][2][16][4] = {
+static gen_helper_gvec_mem * const ldr_fns[2][2][18][4] = {
     { /* mte inactive, little-endian */
       { { gen_helper_sve_ld1bb_r, gen_helper_sve_ld2bb_r,
           gen_helper_sve_ld3bb_r, gen_helper_sve_ld4bb_r },
@@ -4906,7 +4910,11 @@ static gen_helper_gvec_mem * const ldr_fns[2][2][16][4] = {
         { gen_helper_sve_ld1bss_r, NULL, NULL, NULL },
         { gen_helper_sve_ld1bhs_r, NULL, NULL, NULL },
         { gen_helper_sve_ld1dd_le_r, gen_helper_sve_ld2dd_le_r,
-          gen_helper_sve_ld3dd_le_r, gen_helper_sve_ld4dd_le_r } },
+          gen_helper_sve_ld3dd_le_r, gen_helper_sve_ld4dd_le_r },
+
+        { gen_helper_sve_ld1squ_le_r, NULL, NULL, NULL },
+        { gen_helper_sve_ld1dqu_le_r, NULL, NULL, NULL },
+      },
 
       /* mte inactive, big-endian */
       { { gen_helper_sve_ld1bb_r, gen_helper_sve_ld2bb_r,
@@ -4931,7 +4939,12 @@ static gen_helper_gvec_mem * const ldr_fns[2][2][16][4] = {
         { gen_helper_sve_ld1bss_r, NULL, NULL, NULL },
         { gen_helper_sve_ld1bhs_r, NULL, NULL, NULL },
         { gen_helper_sve_ld1dd_be_r, gen_helper_sve_ld2dd_be_r,
-          gen_helper_sve_ld3dd_be_r, gen_helper_sve_ld4dd_be_r } } },
+          gen_helper_sve_ld3dd_be_r, gen_helper_sve_ld4dd_be_r },
+
+        { gen_helper_sve_ld1squ_be_r, NULL, NULL, NULL },
+        { gen_helper_sve_ld1dqu_be_r, NULL, NULL, NULL },
+      },
+    },
 
     { /* mte active, little-endian */
       { { gen_helper_sve_ld1bb_r_mte,
@@ -4964,7 +4977,11 @@ static gen_helper_gvec_mem * const ldr_fns[2][2][16][4] = {
         { gen_helper_sve_ld1dd_le_r_mte,
           gen_helper_sve_ld2dd_le_r_mte,
           gen_helper_sve_ld3dd_le_r_mte,
-          gen_helper_sve_ld4dd_le_r_mte } },
+          gen_helper_sve_ld4dd_le_r_mte },
+
+        { gen_helper_sve_ld1squ_le_r_mte, NULL, NULL, NULL },
+        { gen_helper_sve_ld1dqu_le_r_mte, NULL, NULL, NULL },
+      },
 
       /* mte active, big-endian */
       { { gen_helper_sve_ld1bb_r_mte,
@@ -4997,7 +5014,12 @@ static gen_helper_gvec_mem * const ldr_fns[2][2][16][4] = {
         { gen_helper_sve_ld1dd_be_r_mte,
           gen_helper_sve_ld2dd_be_r_mte,
           gen_helper_sve_ld3dd_be_r_mte,
-          gen_helper_sve_ld4dd_be_r_mte } } },
+          gen_helper_sve_ld4dd_be_r_mte },
+
+        { gen_helper_sve_ld1squ_be_r_mte, NULL, NULL, NULL },
+        { gen_helper_sve_ld1dqu_be_r_mte, NULL, NULL, NULL },
+      },
+    },
 };
 
 static void do_ld_zpa(DisasContext *s, int zt, int pg,
@@ -5016,9 +5038,22 @@ static void do_ld_zpa(DisasContext *s, int zt, int pg,
 
 static bool trans_LD_zprr(DisasContext *s, arg_rprr_load *a)
 {
-    if (a->rm == 31 || !dc_isar_feature(aa64_sve, s)) {
+    if (a->rm == 31) {
         return false;
     }
+
+    /* dtypes 16 and 17 are artificial, representing 128-bit element */
+    if (a->dtype < 16) {
+        if (!dc_isar_feature(aa64_sve, s)) {
+            return false;
+        }
+    } else {
+        if (!dc_isar_feature(aa64_sve2p1, s)) {
+            return false;
+        }
+        s->is_nonstreaming = true;
+    }
+
     if (sve_access_check(s)) {
         TCGv_i64 addr = tcg_temp_new_i64();
         tcg_gen_shli_i64(addr, cpu_reg(s, a->rm), dtype_msz(a->dtype));
@@ -5030,9 +5065,18 @@ static bool trans_LD_zprr(DisasContext *s, arg_rprr_load *a)
 
 static bool trans_LD_zpri(DisasContext *s, arg_rpri_load *a)
 {
-    if (!dc_isar_feature(aa64_sve, s)) {
-        return false;
+    /* dtypes 16 and 17 are artificial, representing 128-bit element */
+    if (a->dtype < 16) {
+        if (!dc_isar_feature(aa64_sve, s)) {
+            return false;
+        }
+    } else {
+        if (!dc_isar_feature(aa64_sve2p1, s)) {
+            return false;
+        }
+        s->is_nonstreaming = true;
     }
+
     if (sve_access_check(s)) {
         int vsz = vec_full_reg_size(s);
         int elements = vsz >> dtype_esz[a->dtype];
@@ -5479,7 +5523,7 @@ static bool trans_LD1R_zpri(DisasContext *s, arg_rpri_load *a)
 static void do_st_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
                       int msz, int esz, int nreg)
 {
-    static gen_helper_gvec_mem * const fn_single[2][2][4][4] = {
+    static gen_helper_gvec_mem * const fn_single[2][2][4][5] = {
         { { { gen_helper_sve_st1bb_r,
               gen_helper_sve_st1bh_r,
               gen_helper_sve_st1bs_r,
@@ -5490,9 +5534,11 @@ static void do_st_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
               gen_helper_sve_st1hd_le_r },
             { NULL, NULL,
               gen_helper_sve_st1ss_le_r,
-              gen_helper_sve_st1sd_le_r },
+              gen_helper_sve_st1sd_le_r,
+              gen_helper_sve_st1sq_le_r, },
             { NULL, NULL, NULL,
-              gen_helper_sve_st1dd_le_r } },
+              gen_helper_sve_st1dd_le_r,
+              gen_helper_sve_st1dq_le_r, } },
           { { gen_helper_sve_st1bb_r,
               gen_helper_sve_st1bh_r,
               gen_helper_sve_st1bs_r,
@@ -5503,9 +5549,11 @@ static void do_st_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
               gen_helper_sve_st1hd_be_r },
             { NULL, NULL,
               gen_helper_sve_st1ss_be_r,
-              gen_helper_sve_st1sd_be_r },
+              gen_helper_sve_st1sd_be_r,
+              gen_helper_sve_st1sq_be_r },
             { NULL, NULL, NULL,
-              gen_helper_sve_st1dd_be_r } } },
+              gen_helper_sve_st1dd_be_r,
+              gen_helper_sve_st1dq_be_r } } },
 
         { { { gen_helper_sve_st1bb_r_mte,
               gen_helper_sve_st1bh_r_mte,
@@ -5517,9 +5565,11 @@ static void do_st_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
               gen_helper_sve_st1hd_le_r_mte },
             { NULL, NULL,
               gen_helper_sve_st1ss_le_r_mte,
-              gen_helper_sve_st1sd_le_r_mte },
+              gen_helper_sve_st1sd_le_r_mte,
+              gen_helper_sve_st1sq_le_r_mte },
             { NULL, NULL, NULL,
-              gen_helper_sve_st1dd_le_r_mte } },
+              gen_helper_sve_st1dd_le_r_mte,
+              gen_helper_sve_st1dq_le_r_mte } },
           { { gen_helper_sve_st1bb_r_mte,
               gen_helper_sve_st1bh_r_mte,
               gen_helper_sve_st1bs_r_mte,
@@ -5530,9 +5580,11 @@ static void do_st_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
               gen_helper_sve_st1hd_be_r_mte },
             { NULL, NULL,
               gen_helper_sve_st1ss_be_r_mte,
-              gen_helper_sve_st1sd_be_r_mte },
+              gen_helper_sve_st1sd_be_r_mte,
+              gen_helper_sve_st1sq_be_r_mte },
             { NULL, NULL, NULL,
-              gen_helper_sve_st1dd_be_r_mte } } },
+              gen_helper_sve_st1dd_be_r_mte,
+              gen_helper_sve_st1dq_be_r_mte } } },
     };
     static gen_helper_gvec_mem * const fn_multiple[2][2][3][4] = {
         { { { gen_helper_sve_st2bb_r,
@@ -5601,12 +5653,27 @@ static void do_st_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
 
 static bool trans_ST_zprr(DisasContext *s, arg_rprr_store *a)
 {
-    if (!dc_isar_feature(aa64_sve, s)) {
-        return false;
-    }
     if (a->rm == 31 || a->msz > a->esz) {
         return false;
     }
+    switch (a->esz) {
+    case MO_8 ... MO_64:
+        if (!dc_isar_feature(aa64_sve, s)) {
+            return false;
+        }
+        break;
+    case MO_128:
+        assert(a->msz < a->esz);
+        assert(a->nreg == 0);
+        if (!dc_isar_feature(aa64_sve2p1, s)) {
+            return false;
+        }
+        s->is_nonstreaming = true;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
     if (sve_access_check(s)) {
         TCGv_i64 addr = tcg_temp_new_i64();
         tcg_gen_shli_i64(addr, cpu_reg(s, a->rm), a->msz);
@@ -5618,12 +5685,27 @@ static bool trans_ST_zprr(DisasContext *s, arg_rprr_store *a)
 
 static bool trans_ST_zpri(DisasContext *s, arg_rpri_store *a)
 {
-    if (!dc_isar_feature(aa64_sve, s)) {
-        return false;
-    }
     if (a->msz > a->esz) {
         return false;
     }
+    switch (a->esz) {
+    case MO_8 ... MO_64:
+        if (!dc_isar_feature(aa64_sve, s)) {
+            return false;
+        }
+        break;
+    case MO_128:
+        assert(a->msz < a->esz);
+        assert(a->nreg == 0);
+        if (!dc_isar_feature(aa64_sve2p1, s)) {
+            return false;
+        }
+        s->is_nonstreaming = true;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
     if (sve_access_check(s)) {
         int vsz = vec_full_reg_size(s);
         int elements = vsz >> a->esz;
-- 
2.43.0


