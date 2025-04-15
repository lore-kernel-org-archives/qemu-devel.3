Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B585C369BD
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mBB-0000OF-2l; Tue, 15 Apr 2025 15:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m2e-0004UO-FO
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:34:03 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m1V-0002tM-6t
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:33:48 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2264aefc45dso88974455ad.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745563; x=1745350363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WtF4WXTFXXNdmtQwDwH4tY2LLA+QVqKCyOE1XosHViI=;
 b=MZS6eMcTTgnbkfWQ1dyhSfxY75PkTfoFRqcK9mJ166DDwBAk+tDCitwzBeElMMdWeD
 8ix6vEqyaJN5DWFxw+zpyjmX1PKSsnw3hsmnwXFUtgZkkFzEKNp+0UkusqHuVzJngBEP
 fSrFQ5ybdj2dkbZYg8KZMOn5CE8RJj8O3OWJsz9Hfsce5MvI5xH/DqfwPveXbrzT+MsO
 Vxle7EurzDLF4qQgWNSkVmDsg9OMjd6fjaIEjcKHWSH6uNrmurXgXgo1TIki+KurUEZQ
 PAmUV3t/kSn2V+Q3S6uDSXt34WICUThO6OGhiFXrnqsTfBBDAN5ch6JfjLW+Nlru9pBC
 TGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745563; x=1745350363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WtF4WXTFXXNdmtQwDwH4tY2LLA+QVqKCyOE1XosHViI=;
 b=xVnU0YP36dEvmT2ckUnjSlUKUk+M34qdJCqEr94jpZguJZEG6lytTrZrJDM9xwQDj6
 AZSCCjQeRciym9Rjv8GKNZqQSK3F3ZQccNOyYUa82NWMXqhxRAZTkW+h3Pgq+uW2NAzi
 981eV1ExIsU2tKvV2mebuwFopusFTkTHDL5OpNpEPZZNGG1CV6IhvKwgYXPB0WU0KiPa
 ZNOVDfUbnA75wKhPjauOpY4NN2DZjKqNmQ7NhcSfB5V58gpAVVTJmxIfIwtOMXc6eJgZ
 40LrhNo6yGOe+H5zlCxFaNhFOSIMclQXCUU+7UoSmzJY6/iIEzfRk99+yNZ/HBTwfy1A
 tTew==
X-Gm-Message-State: AOJu0Yx3bhtEm7icG0+/n1guiV+o4DR7QPNP8XsU5JcQc69wWFhDEmct
 2e6k9k2tMKtvDns1ScqljibHWbJYQjBnxKeMKxalTNDSb6X6EpSDLyJWbMJYifkJSNZpw/wY3mE
 x
X-Gm-Gg: ASbGncvdZryyvNmrtFFyk1FtVqLYRV/W6oeUOJv8LM1fTbNaOMPi3PpAgFJ6Cn6dnNn
 2Y1yZiNI8zPtuxTZ28J3iw0wPnzvUnx9Dmvlyk3O2nfWPY/OGFRq1z1R63U/5oQAo5bDaBfW61s
 3sM5dWYV+4GDulyUOcCn3CekXHXsy9uH49Z8yNu1+Xk2mAkBdB6bpvkFncQq+aMV1n80ppBya4+
 OvhyR961qzAVEJRL7BnIA4qZ/lDgjVPX3f4GWJnzdeJe2HkNyKZHtwPj3kpaT8zV7dRkT+WD12e
 wis3QIL95bo09Jk2hEpyK7od3GOAlLevgwDVjxU8sycarlyvpew8kxgQq/GjlmoSaMP3XCEmgeJ
 QO5Zfm80TXQ==
X-Google-Smtp-Source: AGHT+IFdyhc5RleODRfvLEd2Q/lII83mENr8GzQdjZS3nhE6czyYmcgycxhDKV1hYbuMRE07IadiAQ==
X-Received: by 2002:a17:902:dad0:b0:220:e5be:29c8 with SMTP id
 d9443c01a7336-22c31a86b9dmr5994675ad.32.1744745563047; 
 Tue, 15 Apr 2025 12:32:43 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccbd5esm122062355ad.248.2025.04.15.12.32.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:32:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 102/163] tcg/aarch64: Improve deposit
Date: Tue, 15 Apr 2025 12:24:13 -0700
Message-ID: <20250415192515.232910-103-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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


