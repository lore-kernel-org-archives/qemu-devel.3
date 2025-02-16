Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36273C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnu2-0003je-HM; Sun, 16 Feb 2025 18:18:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntG-0002eg-Vj
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:37 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntE-00062u-Cz
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:34 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-220d28c215eso52318325ad.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747850; x=1740352650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WtF4WXTFXXNdmtQwDwH4tY2LLA+QVqKCyOE1XosHViI=;
 b=jZ8QV8vUsIl4ZvV7rt+8U1URPmGdXl5L0RSmDUvKgAucidJSLfLZMlMKc+5iP4yk4L
 mHq5cZitVKAFwFQaLkx0dSdCd928D/85y30gnxq3VS+K3mt/H85tYEkDLkxga+qRVvx8
 Riu612vemnkTGgmdWvM6hEiuovzPbVnHlfzujxs0Kjmgkp1f0qQK99EoWNtRddZwHv8e
 dB8iRHSTLWwArHvErJtOkMu5BB6Tk/y5PgcrjNWCYkqngKe8Jj+yNRi3G3iDQqZZcrb+
 Mi6Dckz4ZquP1S917kgnJQDaslMv1Mt6rwoC65YMyNv7KmIoUDoKi3t7Qy7iLBgPt0b+
 3Cbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747850; x=1740352650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WtF4WXTFXXNdmtQwDwH4tY2LLA+QVqKCyOE1XosHViI=;
 b=D3PPSNSS+0A1TEfk4uPkdoX1vudS9ocG2sFRxdKgpw+h0sbNJfUwVi3EF6pP+opdbd
 StvnZAjFuxwwwqQF/0gFLWd94vCpzC5G5kfG0st6JZW9RTzayt4DXapX+RVUgWw9mDOf
 5JurXeivrCUWlry+ZMqALNKQnYtsD3XFUNun5jZasLZ4lHH+fED0l+tmeQblXf1zTOi9
 6+AI67fvbjXGpstQe65pB/6kxPIxe6/HniOnAPdG3J9VbCcC6yYTekBmJgUQJBHoh/Bo
 OtrCpjLlWbTbVqbXwiArfzZVY3hzS9aYk307ZzzTZt2JwQe9mjj8P3RoaJZztfJkKvns
 vDTg==
X-Gm-Message-State: AOJu0YwmfLIgPJNmxgwgghfnbpCkM/w9AALHj/ok53epJWdkSNTKSjMS
 wT8G+0tWR+fFFvsl+dVOo6znv6dx/1JmXZIoea7b905Dqdvsrd89MXlGh6OQs+hLyI2PaQ68ie/
 H
X-Gm-Gg: ASbGnctWDeR/5nKoKaBtAYwD/BH2JgsYQYAcnGPC57lPZZvFZ3up6+OmTETWF+S7Mg7
 Kyqo0G0vqZakqJH00fNmHWZlxQnZ8l3BPEYD87ps8jrSDCRuSJpbHhrAxqJ/aVY/ViNp0jHPa4o
 bfCUeW2Hauw2fs7Mv5BMoVziIh46wSsbs3k21XX1jbp1lSuuWa+k1JvMKa4pCdYqWgs6C5Vq0VS
 fOBgpBlH+mh0AbE24RHbqqNc5H2bVtvesA9Nk+mIBLXS2hcMHKO3zg/TmfkcdGN/Xg3MBmmZOi5
 Q1fH0KbM9QEQDN7LDVdsrjmgAtQnRCeKTAx50V34DlhLJos=
X-Google-Smtp-Source: AGHT+IHvKGB/M9I4TQdeFjH+tqxOYvlINLnme5mvi0qmdUqP/nSFv7V7yYuUq2tafsv1iLreDbPI0g==
X-Received: by 2002:a17:903:41c3:b0:21f:7821:55b6 with SMTP id
 d9443c01a7336-22104030832mr116841755ad.13.1739747850539; 
 Sun, 16 Feb 2025 15:17:30 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 101/162] tcg/aarch64: Improve deposit
Date: Sun, 16 Feb 2025 15:09:10 -0800
Message-ID: <20250216231012.2808572-102-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Use ANDI for deposit 0 into a register.
Use UBFIZ, aka UBFM, for deposit register into 0.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-con-set.h |  2 +-
 tcg/aarch64/tcg-target.c.inc     | 29 ++++++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/tcg/aarch64/tcg-target-con-set.h b/tcg/aarch64/tcg-target-con-set.h
index 1281e5efc0..2eda499cd3 100644
--- a/tcg/aarch64/tcg-target-con-set.h
+++ b/tcg/aarch64/tcg-target-con-set.h
@@ -18,7 +18,6 @@ C_O1_I1(r, r)
 C_O1_I1(w, r)
 C_O1_I1(w, w)
 C_O1_I1(w, wr)
-C_O1_I2(r, 0, rz)
 C_O1_I2(r, r, r)
 C_O1_I2(r, r, rA)
 C_O1_I2(r, r, rAL)
@@ -26,6 +25,7 @@ C_O1_I2(r, r, rC)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rL)
 C_O1_I2(r, rz, rz)
+C_O1_I2(r, rZ, rZ)
 C_O1_I2(w, 0, w)
 C_O1_I2(w, w, w)
 C_O1_I2(w, w, wN)
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 62b045c222..dee4afcce1 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2572,12 +2572,39 @@ static void tgen_deposit(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
                          TCGReg a2, unsigned ofs, unsigned len)
 {
     unsigned mask = type == TCG_TYPE_I32 ? 31 : 63;
+
+    /*
+     * Since we can't support "0Z" as a constraint, we allow a1 in
+     * any register.  Fix things up as if a matching constraint.
+     */
+    if (a0 != a1) {
+        if (a0 == a2) {
+            tcg_out_mov(s, type, TCG_REG_TMP0, a2);
+            a2 = TCG_REG_TMP0;
+        }
+        tcg_out_mov(s, type, a0, a1);
+    }
     tcg_out_bfm(s, type, a0, a2, -ofs & mask, len - 1);
 }
 
+static void tgen_depositi(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                          tcg_target_long a2, unsigned ofs, unsigned len)
+{
+    tgen_andi(s, type, a0, a1, ~MAKE_64BIT_MASK(ofs, len));
+}
+
+static void tgen_depositz(TCGContext *s, TCGType type, TCGReg a0, TCGReg a2,
+                          unsigned ofs, unsigned len)
+{
+    int max = type == TCG_TYPE_I32 ? 31 : 63;
+    tcg_out_ubfm(s, type, a0, a2, -ofs & max, len - 1);
+}
+
 static const TCGOutOpDeposit outop_deposit = {
-    .base.static_constraint = C_O1_I2(r, 0, rz),
+    .base.static_constraint = C_O1_I2(r, rZ, rZ),
     .out_rrr = tgen_deposit,
+    .out_rri = tgen_depositi,
+    .out_rzr = tgen_depositz,
 };
 
 static void tgen_extract(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
-- 
2.43.0


