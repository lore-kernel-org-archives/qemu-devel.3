Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D99FE77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4bF-0002qK-AB; Tue, 07 Jan 2025 03:06:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aN-0000Ko-BM
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:17 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aE-0003M6-Ek
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:08 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so27038995ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237101; x=1736841901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PRchjdNlcVUaaImOOnglawrlit+iKBoMSmzAv9MY+JY=;
 b=hVFcU79MwtN0EV5Q0T4L1w+g6ap5UpxK57c5LBKXa1hUEu93HHtiMqTZ7XFR3B5OXL
 TnRo835TXyVYQSkuoUaQn4XiUt7iqzyllQX9XRDx4fxPQriXOq9i19tUP4KqAr2RE+vB
 qO5OQpL2kMKxaQ1Cnn4Z49FDgUsIZFf1DqxQhGN9/YNyGbvLabe4o04wwIycDiA56Ng7
 +Vw97aRilmDxX5Bz10NtDmeS8K1ITZDVa8o3INCo0tnn37vKgPrFuwumS/udpEN4DlSU
 WLTUyvmu5FxQ1VIFj/DuphCRnDrYd5/f8eWcsJcJTQOV1xnlsqJxuNQG48M3cD/bsHsa
 KxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237101; x=1736841901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PRchjdNlcVUaaImOOnglawrlit+iKBoMSmzAv9MY+JY=;
 b=MYc6rQ9JlUpgOqC3Y0lFZ6dVqPF89HDVblFUFl2iSfacJYvUlFSY/Cb3KNTxr7ihlg
 XmLFHFrY9IPbj9fI65wJtEbU7b4h5MtuksXFmHrp+Xo3dCmgBGYAUnvDI/c6KS08MFOF
 887MYwd+SUZ82NFwDZMdRCqWJUhBVmSU0NWvBhwafQ682jjZJnoh40T4cQgdoFpM+V+t
 XhUwkmFu+QGSBilcYstbDjJdDS9vUtzeCO/v4SuzL3NAY2WgHtjaFUioe2z+nWgiMCBN
 1TSCTfeIMjjI6Ut1468lfWS2jwYfDgGMTmFGwCbBhMXzO03ZxPR2yv3X8OXrehnXz5c5
 tC5g==
X-Gm-Message-State: AOJu0YyrX9mztoabIyWpfPeJIBIl28yZnWQepD+cm+25lQh1hv+yWmje
 rRsWDCMHVxvqFCi6riDbv4jVuIV7A2h0z1TZndq+BYt2grOqMDRiWwWr/kAQ+MnvfFis2cvMGhV
 M
X-Gm-Gg: ASbGncvP/WYutX1fSUngU2U+YgoX2mEcGYqlctjOjAPBDdoPzSELxsrxlPOuY43hSpD
 ii30yAZ8gqILngnuVo14SlsW6JS5qeWV3FQDF6sc6VY2OwJITUCiR6YU56Ugtz4SjhG2cR+xWFb
 OyeNoXN9V1kmcxG8ykORTJ60sI/KVi4ol9Bs9tuJ/X852/Y8Ogf0Y2z/BvJAkmdVZXp93YMbPUX
 yoW8lHsLz2Oy+ct2tzMoW51TG46A6XXVshRnMS4VogiklzSFh5ixqiY8zslmPyG4vQCZvnFBZLv
 +/VAr11ye6rAKJYQ5Q==
X-Google-Smtp-Source: AGHT+IFNGawA3vjhLYUMEf3wJfRjqaifji+ddN96TfjNmm7E3DfAK79j9hu3AmcWVXnEXsTzkjU/sw==
X-Received: by 2002:a05:6a00:1909:b0:72a:bc54:84f7 with SMTP id
 d2e1a72fcca58-72abddbe0demr84962115b3a.12.1736237101208; 
 Tue, 07 Jan 2025 00:05:01 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 43/81] tcg/s390x: Fold the ext{8, 16,
 32}[us] cases into {s}extract
Date: Tue,  7 Jan 2025 00:00:34 -0800
Message-ID: <20250107080112.1175095-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Accept byte and word extensions with the extract opcodes.
This is preparatory to removing the specialized extracts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390x/tcg-target-has.h | 22 ++++++++++++++++++++--
 tcg/s390x/tcg-target.c.inc | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 4992d74f12..72b57407d4 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -48,7 +48,7 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_ctpop_i32      1
 #define TCG_TARGET_HAS_deposit_i32    1
 #define TCG_TARGET_HAS_extract_i32    1
-#define TCG_TARGET_HAS_sextract_i32   0
+#define TCG_TARGET_HAS_sextract_i32   1
 #define TCG_TARGET_HAS_extract2_i32   0
 #define TCG_TARGET_HAS_negsetcond_i32 1
 #define TCG_TARGET_HAS_add2_i32       1
@@ -82,7 +82,7 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_ctpop_i64      1
 #define TCG_TARGET_HAS_deposit_i64    1
 #define TCG_TARGET_HAS_extract_i64    1
-#define TCG_TARGET_HAS_sextract_i64   0
+#define TCG_TARGET_HAS_sextract_i64   1
 #define TCG_TARGET_HAS_extract2_i64   0
 #define TCG_TARGET_HAS_negsetcond_i64 1
 #define TCG_TARGET_HAS_add2_i64       1
@@ -121,4 +121,22 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_cmpsel_vec     1
 #define TCG_TARGET_HAS_tst_vec        0
 
+#define TCG_TARGET_extract_valid(type, ofs, len)   1
+
+static inline bool
+tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
+{
+    if (ofs == 0) {
+        switch (len) {
+        case 8:
+        case 16:
+            return true;
+        case 32:
+            return type == TCG_TYPE_I64;
+        }
+    }
+    return false;
+}
+#define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
+
 #endif
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index fc7d986e68..dc7722dc31 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -1572,9 +1572,41 @@ static void tgen_deposit(TCGContext *s, TCGReg dest, TCGReg src,
 static void tgen_extract(TCGContext *s, TCGReg dest, TCGReg src,
                          int ofs, int len)
 {
+    if (ofs == 0) {
+        switch (len) {
+        case 8:
+            tcg_out_ext8u(s, dest, src);
+            return;
+        case 16:
+            tcg_out_ext16u(s, dest, src);
+            return;
+        case 32:
+            tcg_out_ext32u(s, dest, src);
+            return;
+        }
+    }
     tcg_out_risbg(s, dest, src, 64 - len, 63, 64 - ofs, 1);
 }
 
+static void tgen_sextract(TCGContext *s, TCGReg dest, TCGReg src,
+                          int ofs, int len)
+{
+    if (ofs == 0) {
+        switch (len) {
+        case 8:
+            tcg_out_ext8s(s, TCG_TYPE_REG, dest, src);
+            return;
+        case 16:
+            tcg_out_ext16s(s, TCG_TYPE_REG, dest, src);
+            return;
+        case 32:
+            tcg_out_ext32s(s, dest, src);
+            return;
+        }
+    }
+    g_assert_not_reached();
+}
+
 static void tgen_gotoi(TCGContext *s, int cc, const tcg_insn_unit *dest)
 {
     ptrdiff_t off = tcg_pcrel_diff(s, dest) >> 1;
@@ -2726,6 +2758,9 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     OP_32_64(extract):
         tgen_extract(s, args[0], args[1], args[2], args[3]);
         break;
+    OP_32_64(sextract):
+        tgen_sextract(s, args[0], args[1], args[2], args[3]);
+        break;
 
     case INDEX_op_clz_i64:
         tgen_clz(s, args[0], args[1], args[2], const_args[2]);
@@ -3325,6 +3360,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extract_i32:
     case INDEX_op_extract_i64:
+    case INDEX_op_sextract_i32:
+    case INDEX_op_sextract_i64:
     case INDEX_op_ctpop_i32:
     case INDEX_op_ctpop_i64:
         return C_O1_I1(r, r);
-- 
2.43.0


