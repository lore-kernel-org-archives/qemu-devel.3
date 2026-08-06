Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2909C56205
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws1sN-0001Z2-AM; Thu, 06 Aug 2026 13:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws1sF-0001UW-Ig
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:27:19 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws1sC-0000d1-5I
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 13:27:17 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-84f3ab8750cso2197566b3a.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 10:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786037235; x=1786642035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0wHYbbkdOoFYbdpgMj/qbIRNrnm0zPtM0VP+Mji/HqQ=;
 b=oyBCmCleHs9Ol2U/jeeP/iWTVZ0JjqrQdu6bCxQKfuO3fPzYvROFGJAytkFwinRV/0
 sSY6mAKGhpfNi6qUlsNhT7Ks9ZuM/b4yZDFVvlVY5eq3hk8o8LBcYcRek/pifUyUzDOR
 nB5H4mBq2V7mz5CZWEEUbUanEBFnJ6so/RvYYObABl29Ew62i28/ydIIElL+IOene0Gl
 TNywN2PwSb4IF3BFisCM/mchmNMJ2ZiMBrXVWbAoBfCQIERmrmoxxs/esoE3T1FUIo0v
 7Wt8Zr43W47Tyau7xYcrpoVuFqo2M2sx/tLXYgLVp68gfk3DLrReeDgYkwiAc5QF9LlM
 7HyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786037235; x=1786642035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0wHYbbkdOoFYbdpgMj/qbIRNrnm0zPtM0VP+Mji/HqQ=;
 b=eJP74zTyMxj6yHpz9Xk/Pjn4UqsnnjmQcRAkvZzpGKn5UASHECZc8ONXEs0cTZBu8M
 E6SW/Jfn1csHbZyxGafqQbvAW8XpYrX/8qHnLKhyrHL3SuhRPt5kXqDo37bRKjGjABwt
 TP/8PmFNfTvfWBXNSe/8GT/g2p0HV3k1Yl6bSquutV9vZJ2oLRlNRFgZpiUgl+/x6obu
 2iqYVCO+tpgw8neAqu/KehxV6sgepDlf7O+G6MsS9uuXLEf5zleSP+hUsmO4/x61hm2Y
 T8ulrcxZNUZ0+3gvMav8XCqnLhit32LxfLQHWfr8cTSeWcci+/jJ1FnrzTmenRrfoPbz
 yImw==
X-Gm-Message-State: AOJu0YyHvsLjkeX7ir2Ot491ExlAXBCCFF4OgP25vMwBDlFB4nGPh1xw
 k1L5c5GImXgdhDEGYVHED8/6Iw6YrPYlLOgEjQU6VeOpi+tkDOdg26Rk42Z6JCxX/qoe8MI2a8x
 UDI7y
X-Gm-Gg: AR+sD10bfDYwiYjryFu/g9BPbXg3LlAX7x/xYQWuSg6P2Is/N1fvz9f9m0WW3OtHOAZ
 LWzyOMWxj4+RuomhZh859EqoN7F6AbN8LnjbBmk26jdrUVsj8LDGftDvun6vBK/ZzURInNOpixv
 +Th2suw1ueaq5h3bEad5NUFJhGP3Ft2NqjGwD2hjcnAT0O+AxU5dOy6ReSEyLpPNzqcGsYK/mYi
 TRVx1wovXPCpox1TpzWyBubtc9CoAd/D1qlzhlpIrGa+FuYO3p7jemXU7Xbt3t7d8iJe7ssHZty
 izDQJdw7b/dJwB5EOJKC8hKQt1nt6w0DEd6J9WzfmG8XcwRJco2Q4ZwLCh8F6VpYtG+a6+3U/ri
 IzW/4u1EDUFAinUjWiI3dMiJp0+FMa/t5y8/dmRcSl2aSsz/4RXaIqOCzTMAEzKjATDcuikboQK
 tbg2wYIyHVQ0r0JV4LEPw417fpgHxsp5ObFueEP/5alNI5xPd7DUXC3UH9arw3qy5/Yn1nm6dyU
 IZ73cKjkb9o/3U9vmS6
X-Received: by 2002:a05:6a00:4288:b0:847:83bc:d2a4 with SMTP id
 d2e1a72fcca58-84f2dfc8c42mr19799997b3a.2.1786037234552; 
 Thu, 06 Aug 2026 10:27:14 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f45389e68sm1803272b3a.4.2026.08.06.10.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:27:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 3/6] target/arm: Add FGWTE3 FGT bit definitions
Date: Thu,  6 Aug 2026 10:27:06 -0700
Message-ID: <20260806172709.333300-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806172709.333300-1-richard.henderson@linaro.org>
References: <20260806172709.333300-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 2c9927b1d9..9f2532fe66 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -728,6 +728,9 @@ FIELD(FGT, BITPOS, 0, 6) /* Bit position within the uint64_t */
 #define DO_BIT(REG, BITNAME)                                    \
     FGT_##BITNAME = FGT_##REG | R_##REG##_EL2_##BITNAME##_SHIFT
 
+#define DO_EL3_BIT(REG, BITNAME)                                \
+    FGT_##BITNAME = FGT_##REG | R_##REG##_EL3_##BITNAME##_SHIFT
+
 /* Some bits have reversed sense, so 0 means trap and 1 means not */
 #define DO_REV_BIT(REG, BITNAME)                                        \
     FGT_##BITNAME = FGT_##REG | FGT_REV | R_##REG##_EL2_##BITNAME##_SHIFT
@@ -787,6 +790,7 @@ typedef enum FGTBit {
     FGT_HDFGRTR = FGT_RW | (FGTREG_HDFGRTR << R_FGT_IDX_SHIFT),
     FGT_HDFGWTR = FGT_W | (FGTREG_HDFGWTR << R_FGT_IDX_SHIFT),
     FGT_HFGITR = FGT_EXEC | (FGTREG_HFGITR << R_FGT_IDX_SHIFT),
+    FGT_FGWTE3 = FGT_W | (FGTREG_FGWTE3 << R_FGT_IDX_SHIFT),
 
     /* Trap bits in HFGRTR_EL2 / HFGWTR_EL2, starting from bit 0. */
     DO_BIT(HFGRTR, AFSR0_EL1),
@@ -919,10 +923,37 @@ typedef enum FGTBit {
     DO_REV_BIT(HFGITR, NGCSPUSHM_EL1),
     DO_REV_BIT(HFGITR, NGCSEPP),
     DO_BIT(HFGITR, ATS1E1A),
+
+    /* Trap bits in FGWTE3_EL3, starting from bit 0 */
+    DO_EL3_BIT(FGWTE3, ACTLR_EL3),
+    DO_EL3_BIT(FGWTE3, AFSR0_EL3),
+    DO_EL3_BIT(FGWTE3, AFSR1_EL3),
+    DO_EL3_BIT(FGWTE3, AMAIR_EL3),
+    DO_EL3_BIT(FGWTE3, AMAIR2_EL3),
+    DO_EL3_BIT(FGWTE3, GCSCR_EL3),
+    DO_EL3_BIT(FGWTE3, GCSPR_EL3),
+    DO_EL3_BIT(FGWTE3, GPCCR_EL3),
+    DO_EL3_BIT(FGWTE3, GPTBR_EL3),
+    DO_EL3_BIT(FGWTE3, MAIR_EL3),
+    DO_EL3_BIT(FGWTE3, MAIR2_EL3),
+    DO_EL3_BIT(FGWTE3, MDCR_EL3),
+    DO_EL3_BIT(FGWTE3, MECID_RL_A_EL3),
+    DO_EL3_BIT(FGWTE3, MPAM3_EL3),
+    DO_EL3_BIT(FGWTE3, PIR_EL3),
+    DO_EL3_BIT(FGWTE3, SCTLR_EL3),
+    DO_EL3_BIT(FGWTE3, SCTLR2_EL3),
+    DO_EL3_BIT(FGWTE3, SPMROOTCR_EL3),
+    DO_EL3_BIT(FGWTE3, TCR_EL3),
+    DO_EL3_BIT(FGWTE3, TPIDR_EL3),
+    DO_EL3_BIT(FGWTE3, TTBR0_EL3),
+    DO_EL3_BIT(FGWTE3, VBAR_EL3),
+    DO_EL3_BIT(FGWTE3, GPCBW_EL3),
 } FGTBit;
 
 #undef DO_BIT
+#undef DO_EL3_BIT
 #undef DO_REV_BIT
+#undef DO_TLBINXS_BIT
 
 typedef struct ARMCPRegInfo ARMCPRegInfo;
 
-- 
2.43.0


