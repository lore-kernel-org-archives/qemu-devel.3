Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF2DE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPen-0007Vs-Q6; Thu, 02 Jan 2025 13:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeP-0007Cy-Lc
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:32 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeO-0006CG-0a
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:29 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-216426b0865so154999845ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841427; x=1736446227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sJBllHRTariSKVJFq4nQzWD9/YyYxC7DfXmWwXeSyE8=;
 b=ptArcnv/EzTjQPWciyasHGuguqg3CTeVfN+T9sqTItTJEfQajX3ugz1SbAzhz8dbUp
 17LvBIHBOCL8Y16J12vPgpyj8Qp5O+MWfawKFaaV0GmmtfMbjN3OlCztwcd1t30X4QBv
 e7KWd9AUgaXFzVZ7npuMSX6w4TQOHeFyTNvbW4K8zlqyE1DOtOElEuzWVt4bXK8c05I3
 Vb+OCRD1gWIjiu13DaE401Xc+r/hllCLCJShgqUdRXmysfCJqGXxMQz3VIMNiMlZ99BB
 S5hjps2e3pOz2V3aNcUbfwFNiWqTivz/OIhE11ODgV3HgrETbZZRVYxqREAUSENATQMz
 WqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841427; x=1736446227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sJBllHRTariSKVJFq4nQzWD9/YyYxC7DfXmWwXeSyE8=;
 b=Pftl7X3AEwdM2Jf4DUyhVEZSTQxmmH2fm1+ZGOfkx3iaRYEpy6CKGSM5BIbMDEC1vQ
 SPesYn0gyudWuETo52QAlBvYbg4Bpcs2TKbvUvt+rPEnB/JgWYeGiEKrzriT/LeXGhr5
 lZ6bhofGycIuiMWo0xK/OOTR8D4m3rKyhS0bBbdBnJH0eKW6XQGOgWLJR7N9bsnom8Z0
 FFjlGZUq+gwtzkSRCBJWrfd+uyksouUj4/sNo80pXLID1rI9gbLhGt9RNqztntbBXULL
 5R/SHkoOJmHg9kaWtM5x5+cCaxF1ZIKWE0XgUaN5o29VX8NeGEFE6Eo4AUfjQ5O28drk
 iNBw==
X-Gm-Message-State: AOJu0YwNQgS5bcSND4x2R+c19+1s1AhGvGrWva7nifh7JGoxCAgrB2B7
 80DHIWDmFiiNPhIJnSUB6j/1PtG8z3Hjz8yu6dIeQd9m1F7vXGUxCyU/M2vONSo0BESEUxaEzQx
 9
X-Gm-Gg: ASbGnctohGgiI3l4URAjAe4Mr0TrEMJF1yXRImr1Q785GI2zwEvPBPsBgXhR8s4/T4c
 ShQn8fIUp3uEPyk+AP0vbuXAvhNsn+8j3HGm97eI+Giv8QXKLGGmAZm/lAQEzHRHxu0YLlEdls1
 +bk70Bdc1hnEjLSsaw/NBdw1uVa0uTEsqnVJzmE3kkeN4hngA3wYIxJVdNXEUs6bhOnO+SRYhNr
 B8lYZP5fkU9nBRzmyUnk/MLAMoPPWvNwaap+90wrJJ3mWfk1GUIcA2HVQMpRQ==
X-Google-Smtp-Source: AGHT+IE/xTmQ98ywuqlj2QuO5tbt3kD0v/cvpJnM5x8hZgp5fAnpnLu9IMl62Bzp9Pf4k4krl/5pLQ==
X-Received: by 2002:a05:6a20:258c:b0:1e1:bdae:e058 with SMTP id
 adf61e73a8af0-1e5e0819174mr76976242637.37.1735841426718; 
 Thu, 02 Jan 2025 10:10:26 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 40/73] tcg/s390x: Fold the ext{8, 16,
 32}[us] cases into {s}extract
Date: Thu,  2 Jan 2025 10:06:20 -0800
Message-ID: <20250102180654.1420056-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
index 93f1a67bd1..075ce5c15c 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -57,7 +57,7 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_ext16u_i32     1
 #define TCG_TARGET_HAS_deposit_i32    1
 #define TCG_TARGET_HAS_extract_i32    1
-#define TCG_TARGET_HAS_sextract_i32   0
+#define TCG_TARGET_HAS_sextract_i32   1
 #define TCG_TARGET_HAS_extract2_i32   0
 #define TCG_TARGET_HAS_extr_i64_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32   0
@@ -70,7 +70,7 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_ext32u_i64     1
 #define TCG_TARGET_HAS_deposit_i64    1
 #define TCG_TARGET_HAS_extract_i64    1
-#define TCG_TARGET_HAS_sextract_i64   0
+#define TCG_TARGET_HAS_sextract_i64   1
 #define TCG_TARGET_HAS_extract2_i64   0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128 1
@@ -96,4 +96,22 @@ extern uint64_t s390_facilities[3];
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
index db8dec845b..633b4efb66 100644
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
@@ -2727,6 +2759,9 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     OP_32_64(extract):
         tgen_extract(s, args[0], args[1], args[2], args[3]);
         break;
+    OP_32_64(sextract):
+        tgen_sextract(s, args[0], args[1], args[2], args[3]);
+        break;
 
     case INDEX_op_clz_i64:
         tgen_clz(s, args[0], args[1], args[2], const_args[2]);
@@ -3325,6 +3360,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
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


