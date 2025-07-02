Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AD4C8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwhM-00016w-Gf; Wed, 02 Jul 2025 08:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwg2-0007ps-2R
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:35:03 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfe-00011f-AL
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:34:55 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2eb6c422828so3963194fac.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459676; x=1752064476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QH0REyU8cDnWZTUTJJuh2X01ovEw+r0Jjx8GCuZi1sE=;
 b=kHdK0VdJmW7EwJAkjarIhAsfIlK4xg7xQbQTpKyZTL3zb5AmP2MNYvG5A57LTFtb/O
 b8RzahLl005NRU0T8tHAbL9cve5mucoWgNxFX44hBjZ9E17+/O1emjSRjmLYxKFRSbws
 7OEAxRYVdK+YG2hiNU/fbWoxZe9gRl8HpK5abO7RmjcJkAMx0vcqdPKKUOpjZQbXP2NK
 GOEDnrjSf7e9z7qLcT8N8lFM1LrxSttJ1bQYJSmkbvZxDFCuw/v2WUDvLIYqWoum4exH
 uP5pMiL2yNPkbqf+qStvvN17ZN7WFSb7KB32RpdJQTcZYFaFSTCAJAQfVIEQBOHMDi5Z
 z7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459676; x=1752064476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QH0REyU8cDnWZTUTJJuh2X01ovEw+r0Jjx8GCuZi1sE=;
 b=LxwYVhcIPQB/j7dFjbBcBWzLnDS9j+gcvUEopLFb9Q8ftSVE7aOGMvcZO6L1kQGJGV
 jYZyLqQLqx+lw2sUssBO75InMdqXJdShlS8Av5OG8XipmL5prXQG6guizWfDNZ0ZPnHF
 l+xu80Kr3onBlDtkeUGCPBld7b5vou9sixEODDrjNT2R1Zc/99BrbPZ5rsQPIbU/J0Cu
 kAGb3g6vaA8M+vB8qk/Y38YKCSu6oRtPxtncTVHmsldq+emVccBTOL4aq5dY/1sUCcCL
 llGYhm3X7d/dVEZd0jDM/FJG0ScA0t7TSLEQXwf4UIyFQDCquxVU93vAKVDh5S+6DauJ
 C73A==
X-Gm-Message-State: AOJu0YxEYzzvEg3VIajILeq0owki4pN8y+W+gPa4f5ZCCF9Mk7yuUKB+
 KlymtJI+akH0mY1FgQzcSte9IrjFPObAOMmiNULzRhLI+4BRFcSDzZnXwj5gu5FTW8WIWzzEV0y
 o5nBTpgk=
X-Gm-Gg: ASbGncs3gQg3hsk3hbVmfNejPx8MqyuyIJjdZUl7K50RUaQy7G/e/NjUfvGfU2rx9NU
 dK9nT/JbO3ea/m03MFUAjBlyQTj1ma7Ian56EZnZi+k4p7OTrQBye9JZggF6hfCwXTStMTydKQE
 nKFG4oYbonWqFAIkZUBp+6IjAyz6TuO1JY1dISaCoja3LDGmNTeWWTAuARLFRvwkd5MVhPGAhug
 iT9kQfRsZ5UTqh1fpgeDQf3Jfb3t+qZ2yT/mp2WodOVUYoW4mQqV2DRUb1WeZpccsAdbwDBbdjw
 E4mvMLGC2bx9Tk5fknjN1EGbTm9fpWPjHsjrPkr+2U5b64r8LtSS4ZTxW+L3moLGrMHHd2tqlfJ
 V/AIe
X-Google-Smtp-Source: AGHT+IFF0LX2dXL9VKDl7TIvU1HZxWfzBh1ydIPGonQUJydqK7dJo10gleCy6+vJBHSO9WRpRPrxjA==
X-Received: by 2002:a05:687c:2010:10b0:2b8:608d:5dd1 with SMTP id
 586e51a60fabf-2f6649e9bcdmr1195419fac.18.1751459675838; 
 Wed, 02 Jul 2025 05:34:35 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3864281fac.32.2025.07.02.05.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:34:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 18/97] target/arm: Implement SME2 SMOPS, UMOPS (2-way)
Date: Wed,  2 Jul 2025 06:32:51 -0600
Message-ID: <20250702123410.761208-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  4 ++++
 target/arm/tcg/sme_helper.c    | 37 +++++++++++++++++++++++++---------
 target/arm/tcg/translate-sme.c |  2 ++
 target/arm/tcg/sme.decode      |  2 ++
 4 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 17d1a7c102..ecd06f2cd1 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -156,3 +156,7 @@ DEF_HELPER_FLAGS_6(sme_usmopa_d, TCG_CALL_NO_RWG,
 
 DEF_HELPER_FLAGS_6(sme2_bmopa_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sme2_smopa2_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sme2_umopa2_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 6122a5b5d9..8ce50653b4 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1261,7 +1261,7 @@ static inline void do_imopa_d(uint64_t *za, uint64_t *zn, uint64_t *zm,
     }
 }
 
-#define DEF_IMOP_32(NAME, NTYPE, MTYPE) \
+#define DEF_IMOP_8x4_32(NAME, NTYPE, MTYPE) \
 static uint32_t NAME(uint32_t n, uint32_t m, uint32_t a, uint8_t p, bool neg) \
 {                                                                           \
     uint32_t sum = 0;                                                       \
@@ -1274,7 +1274,7 @@ static uint32_t NAME(uint32_t n, uint32_t m, uint32_t a, uint8_t p, bool neg) \
     return neg ? a - sum : a + sum;                                         \
 }
 
-#define DEF_IMOP_64(NAME, NTYPE, MTYPE) \
+#define DEF_IMOP_16x4_64(NAME, NTYPE, MTYPE) \
 static uint64_t NAME(uint64_t n, uint64_t m, uint64_t a, uint8_t p, bool neg) \
 {                                                                           \
     uint64_t sum = 0;                                                       \
@@ -1287,15 +1287,15 @@ static uint64_t NAME(uint64_t n, uint64_t m, uint64_t a, uint8_t p, bool neg) \
     return neg ? a - sum : a + sum;                                         \
 }
 
-DEF_IMOP_32(smopa_s, int8_t, int8_t)
-DEF_IMOP_32(umopa_s, uint8_t, uint8_t)
-DEF_IMOP_32(sumopa_s, int8_t, uint8_t)
-DEF_IMOP_32(usmopa_s, uint8_t, int8_t)
+DEF_IMOP_8x4_32(smopa_s, int8_t, int8_t)
+DEF_IMOP_8x4_32(umopa_s, uint8_t, uint8_t)
+DEF_IMOP_8x4_32(sumopa_s, int8_t, uint8_t)
+DEF_IMOP_8x4_32(usmopa_s, uint8_t, int8_t)
 
-DEF_IMOP_64(smopa_d, int16_t, int16_t)
-DEF_IMOP_64(umopa_d, uint16_t, uint16_t)
-DEF_IMOP_64(sumopa_d, int16_t, uint16_t)
-DEF_IMOP_64(usmopa_d, uint16_t, int16_t)
+DEF_IMOP_16x4_64(smopa_d, int16_t, int16_t)
+DEF_IMOP_16x4_64(umopa_d, uint16_t, uint16_t)
+DEF_IMOP_16x4_64(sumopa_d, int16_t, uint16_t)
+DEF_IMOP_16x4_64(usmopa_d, uint16_t, int16_t)
 
 #define DEF_IMOPH(P, NAME, S) \
     void HELPER(P##_##NAME##_##S)(void *vza, void *vzn, void *vzm,          \
@@ -1325,3 +1325,20 @@ static uint32_t bmopa_s(uint32_t n, uint32_t m, uint32_t a, uint8_t p, bool neg)
 }
 
 DEF_IMOPH(sme2, bmopa, s)
+
+#define DEF_IMOP_16x2_32(NAME, NTYPE, MTYPE) \
+static uint32_t NAME(uint32_t n, uint32_t m, uint32_t a, uint8_t p, bool neg) \
+{                                                                           \
+    uint32_t sum = 0;                                                       \
+    /* Apply P to N as a mask, making the inactive elements 0. */           \
+    n &= expand_pred_h(p);                                                  \
+    sum += (NTYPE)(n >> 0) * (MTYPE)(m >> 0);                               \
+    sum += (NTYPE)(n >> 16) * (MTYPE)(m >> 16);                             \
+    return neg ? a - sum : a + sum;                                         \
+}
+
+DEF_IMOP_16x2_32(smopa2_s, int16_t, int16_t)
+DEF_IMOP_16x2_32(umopa2_s, uint16_t, uint16_t)
+
+DEF_IMOPH(sme2, smopa2, s)
+DEF_IMOPH(sme2, umopa2, s)
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index c2615f06ae..0a863a50bf 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -541,3 +541,5 @@ TRANS_FEAT(SUMOPA_d, aa64_sme_i16i64, do_outprod, a, MO_64, gen_helper_sme_sumop
 TRANS_FEAT(USMOPA_d, aa64_sme_i16i64, do_outprod, a, MO_64, gen_helper_sme_usmopa_d)
 
 TRANS_FEAT(BMOPA, aa64_sme2, do_outprod, a, MO_32, gen_helper_sme2_bmopa_s)
+TRANS_FEAT(SMOPA2_s, aa64_sme2, do_outprod, a, MO_32, gen_helper_sme2_smopa2_s)
+TRANS_FEAT(UMOPA2_s, aa64_sme2, do_outprod, a, MO_32, gen_helper_sme2_umopa2_s)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index de8d04cb87..36f369d02a 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -167,3 +167,5 @@ USMOPA_d        1010000 1 11 0 ..... ... ... ..... . 0 ...      @op_64
 UMOPA_d         1010000 1 11 1 ..... ... ... ..... . 0 ...      @op_64
 
 BMOPA           1000000 0 10 0 ..... ... ... ..... . 10 ..      @op_32
+SMOPA2_s        1010000 0 10 0 ..... ... ... ..... . 10 ..      @op_32
+UMOPA2_s        1010000 1 10 0 ..... ... ... ..... . 10 ..      @op_32
-- 
2.43.0


