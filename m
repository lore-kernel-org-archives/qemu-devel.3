Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E36FC83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEQ-0000Xi-Px; Fri, 04 Jul 2025 12:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEN-0000R4-6v
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:43 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEL-0006FS-7r
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:42 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a5257748e1so869159f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646340; x=1752251140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fdhHmwhlsfgW93GbUQo1WTT/SpEUkG5ImXRWraW9Y58=;
 b=Pl06ukHgzUXu2qzJHXkJCvokLEe2EiOsXDtcMJy0qFCWTEh3bVJ3bCrPHD43ZK3aXn
 knaVyI67euOB1+sqN5s5DchDuzqSHGQa80s5m/VvLgNIWWZt6XhOxwl7rJvYinOjH6en
 O3L5zeRmLQ6j9gVjdcoWX/9NYGMyz5v4MKzjUVaEaI+Sk2pVJeD5q+n8OMY9Czhaq/GV
 F9wKypkD178GwgzZkcz+AV8hfpclemtUsFyEe2ZRtsFVyT0F3rJ6rsboSJgDqqzC7iNs
 XYjWhEEdSnr0JcnadEFhpp7GLlr6/3JG02y1VeM/AILuWwoE+Xj8Hjqf98P6QciSGtqi
 +8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646340; x=1752251140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fdhHmwhlsfgW93GbUQo1WTT/SpEUkG5ImXRWraW9Y58=;
 b=Skd22ethvo9AXZVkrY5Skk7jakZVfavzJCnxzsqnS0uFpiPntqN+2e0T3wTHa9Cloe
 8vplIEU8oaw2vsWDy5lqfPW8vIdW+SF3v80RflCbPsja77KXqb4xtDiQyjWj8FLyyxNm
 SUXwLr48bMXjDfQpta5J02THpKRfFjaLdn1hbCbFAoBM4RTvaa0TEBA5rcD7I5j2Vi+Z
 OoUS9eHrHFKQANWA4S0I8maICssSLRkYZ6m/hxC4Gm7hY1DQ97h/VQr7eS6VyfMITvIN
 Xj61F+6ayZHBkh4qDzQUzvRlix8rG6p/BEWN4/XWgDLhtrCSkFSWdG+XJq4lK9l9C7uq
 RleA==
X-Gm-Message-State: AOJu0Yzc1L1CfvXWJEWFkau/2Pif8J20yN2IdESfKYpy+w0ZrPn1jbqm
 w/pE/NR0IHHXPaaVWE7iTZ/cubJNoSJ1b3XxJwSbTUhAZ4iOSjO2M7/rLOvZgWrq7FKSZlfYzmM
 y+Y0r
X-Gm-Gg: ASbGnctqUl33n3t28t0O3YEoHG01MiNuygenw1ecP1AjRPbhz/buiioqGufSEUT3JqU
 DWWcf7lnI8Cn/o7DmApT11JNG1sceWe19Ju4/x1b5oCtZLKYFEy9rywdoHRUL0+Ihm8W+EEMRrY
 0mlDWDPZ2JGjlcVxvIcdF3FS+JfWePBmz5QcqnViPpcEU3eUVy0bqd10fX2uUuzeXejGedeWBBh
 v5ZI75Tc5X6JDgpT+VAhBOCpUuZKhnKBJY/xh0YdXGXkduWtHo6c8XYr/csxnWVaGAMIzoH8dpJ
 91TMQuwnzKajxIUww+PZm7BDNSYUOu4xPZOHgqhPUuBIMLfZdGUMvzADNRfguOlgb6Y7
X-Google-Smtp-Source: AGHT+IFCDVZW++JV90ixrd/d3GfugVfkFy+gsDQvWdLcvs9nSqGMriHV1pflaAEudlOwu0FdORF9EA==
X-Received: by 2002:a05:6000:1a8b:b0:3a4:d994:be7d with SMTP id
 ffacd0b85a97d-3b49702067dmr2520087f8f.23.1751646339565; 
 Fri, 04 Jul 2025 09:25:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 040/119] target/arm: Implement SME2 SMOPS, UMOPS (2-way)
Date: Fri,  4 Jul 2025 17:23:40 +0100
Message-ID: <20250704162501.249138-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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
Message-id: 20250704142112.1018902-29-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  4 ++++
 target/arm/tcg/sme.decode      |  2 ++
 target/arm/tcg/sme_helper.c    | 37 +++++++++++++++++++++++++---------
 target/arm/tcg/translate-sme.c |  2 ++
 4 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 17d1a7c1029..ecd06f2cd16 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -156,3 +156,7 @@ DEF_HELPER_FLAGS_6(sme_usmopa_d, TCG_CALL_NO_RWG,
 
 DEF_HELPER_FLAGS_6(sme2_bmopa_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sme2_smopa2_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sme2_umopa2_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index de8d04cb878..36f369d02aa 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -167,3 +167,5 @@ USMOPA_d        1010000 1 11 0 ..... ... ... ..... . 0 ...      @op_64
 UMOPA_d         1010000 1 11 1 ..... ... ... ..... . 0 ...      @op_64
 
 BMOPA           1000000 0 10 0 ..... ... ... ..... . 10 ..      @op_32
+SMOPA2_s        1010000 0 10 0 ..... ... ... ..... . 10 ..      @op_32
+UMOPA2_s        1010000 1 10 0 ..... ... ... ..... . 10 ..      @op_32
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 6122a5b5d9e..8ce50653b4d 100644
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
index c2615f06aee..0a863a50bf2 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -541,3 +541,5 @@ TRANS_FEAT(SUMOPA_d, aa64_sme_i16i64, do_outprod, a, MO_64, gen_helper_sme_sumop
 TRANS_FEAT(USMOPA_d, aa64_sme_i16i64, do_outprod, a, MO_64, gen_helper_sme_usmopa_d)
 
 TRANS_FEAT(BMOPA, aa64_sme2, do_outprod, a, MO_32, gen_helper_sme2_bmopa_s)
+TRANS_FEAT(SMOPA2_s, aa64_sme2, do_outprod, a, MO_32, gen_helper_sme2_smopa2_s)
+TRANS_FEAT(UMOPA2_s, aa64_sme2, do_outprod, a, MO_32, gen_helper_sme2_umopa2_s)
-- 
2.43.0


