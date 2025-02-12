Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D08C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 03:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti3iW-0000NL-Bb; Tue, 11 Feb 2025 22:47:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ti3hh-00009I-4X
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 22:46:26 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ti3hf-0001a1-5a
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 22:46:24 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21f48ab13d5so106303415ad.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 19:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739331981; x=1739936781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4/sTV3gzpwg9VtQiTqRa4NvbHKKQFG36vUEv1sgUWBQ=;
 b=LjSrkJTh2MXC5eMhyXtk5kca1B6TAFaL+UKwMuki2wYmuw4T0PNVQc7uZo+CnS9uy3
 M06rNfmDe66zf+u2r9HGBeyOrXURxOc6EsAocA7xUKu3gX4pZQRhJAj1VqaNJPAODnqz
 19qqO7nvhHSW+O+qkZ4hskJvpg/NBKfxOfFSw/ILuVfZB7xzZI1PdxSmiCNUL0Kyrg+u
 opZJrFkxfcUIdjUoLcn501T+6s14kze4NB5NZ+U3dGTZFlZy1J4yOkoEVY82wGlACFvN
 Yf5s3YK+VIP64MR/uftEWEO1dH+KqBZiVZfVJV7U4ncsEQ6euDj/ZITGdIQdMQVRhuyk
 U1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739331981; x=1739936781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4/sTV3gzpwg9VtQiTqRa4NvbHKKQFG36vUEv1sgUWBQ=;
 b=lhiSneMCxg0PaHr+baHxVbAW3Bf8uEVMQ3oNGa+vf5JGORLh1wXWpjh+mPlTGreBNT
 Go33ImG7HWFviIMOhGHTVhtU0BZXEmxoRiIX0UM4dqCGWG63YahDF09SdgMYbUet76vK
 1B8efdo3CPs5TrqQUFbP/f+NLBdg764/yi2lg0nV9A39foamrE1nhx3cNmBzM2wa4Ltx
 asGHigReT6ZsoB+8X/F/FcTh94UBIOTCW3znlwLkbksdGkQ5RacQr8g8tj0Dcsk/GsgS
 QTO8i36iKKGyxOZf2hHjWHhq+Kusk7Ne8fW5up1f1A5SqlnyNuEwr1IQNnfh+/fIttAC
 OAJw==
X-Gm-Message-State: AOJu0YyBnbMtW2c9n+SW1rqgb+jrrW0W5ZT9RDd2NK6DS6ADA4fx5lAt
 StyVFOWl747sin9s8Dpj/x4IOOK2ioybG+28k4Y806arOvQsXFtSscf+6XdULl7b54qkyvi/er+
 L
X-Gm-Gg: ASbGnctz261RZ8bS1qISURKg9Fc0Y7/X4ESHCGeaCqbYHTH5/cYBU6zned+0FklCVqu
 KEgcmeg7wa5Ihi9bKlJo+g0hbYkqbrCoNOKpJ2866W1scQxN3ktUzuRcIwZexJnJPD840NlY41T
 d4ftmiwFsOKen6e+kNjSC5leQSHN4jRom1aZANQAnGLOE34Z/KJv2/ZhZd/JcdOd3Dvk8r5NWqw
 W4muGZgjR83cStuaNl6Wh/V6E75ZEJaS/Z1bbFDKdaqe59PyDVuPDHb4KnB0U1/lSPx63yDgqDL
 MOZSg4Ff26gTaVv5VW0XeoZBFJZCSXm4IETxbCDyQ6Z2dQk=
X-Google-Smtp-Source: AGHT+IGlXN0ygcfBXG6tokeVW/G6/n+YWWjB3x4eVfgPPnj+C5Q0M8Ae7BIClZcqleT73S61IxX8qA==
X-Received: by 2002:a05:6a21:9f17:b0:1e1:a716:316a with SMTP id
 adf61e73a8af0-1ee5c738df0mr2756180637.10.1739331981427; 
 Tue, 11 Feb 2025 19:46:21 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-730992eba96sm3482569b3a.126.2025.02.11.19.46.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 19:46:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] tcg/loongarch64: Use 'z' constraint
Date: Tue, 11 Feb 2025 19:46:14 -0800
Message-ID: <20250212034617.1079324-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212034617.1079324-1-richard.henderson@linaro.org>
References: <20250212034617.1079324-1-richard.henderson@linaro.org>
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

Replace target-specific 'Z' with generic 'z'.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target-con-set.h | 15 ++++++-------
 tcg/loongarch64/tcg-target-con-str.h |  1 -
 tcg/loongarch64/tcg-target.c.inc     | 32 ++++++++++++----------------
 3 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/tcg/loongarch64/tcg-target-con-set.h b/tcg/loongarch64/tcg-target-con-set.h
index cae6c2aad6..8afaee9476 100644
--- a/tcg/loongarch64/tcg-target-con-set.h
+++ b/tcg/loongarch64/tcg-target-con-set.h
@@ -15,8 +15,8 @@
  * tcg-target-con-str.h; the constraint combination is inclusive or.
  */
 C_O0_I1(r)
-C_O0_I2(rZ, r)
-C_O0_I2(rZ, rZ)
+C_O0_I2(rz, r)
+C_O0_I2(rz, rz)
 C_O0_I2(w, r)
 C_O0_I3(r, r, r)
 C_O1_I1(r, r)
@@ -28,14 +28,13 @@ C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rJ)
 C_O1_I2(r, r, rU)
 C_O1_I2(r, r, rW)
-C_O1_I2(r, r, rZ)
-C_O1_I2(r, 0, rZ)
-C_O1_I2(r, rZ, ri)
-C_O1_I2(r, rZ, rJ)
-C_O1_I2(r, rZ, rZ)
+C_O1_I2(r, 0, rz)
+C_O1_I2(r, rz, ri)
+C_O1_I2(r, rz, rJ)
+C_O1_I2(r, rz, rz)
 C_O1_I2(w, w, w)
 C_O1_I2(w, w, wM)
 C_O1_I2(w, w, wA)
 C_O1_I3(w, w, w, w)
-C_O1_I4(r, rZ, rJ, rZ, rZ)
+C_O1_I4(r, rz, rJ, rz, rz)
 C_N2_I1(r, r, r)
diff --git a/tcg/loongarch64/tcg-target-con-str.h b/tcg/loongarch64/tcg-target-con-str.h
index 2ba9c135ac..99759120b4 100644
--- a/tcg/loongarch64/tcg-target-con-str.h
+++ b/tcg/loongarch64/tcg-target-con-str.h
@@ -23,7 +23,6 @@ REGS('w', ALL_VECTOR_REGS)
 CONST('I', TCG_CT_CONST_S12)
 CONST('J', TCG_CT_CONST_S32)
 CONST('U', TCG_CT_CONST_U12)
-CONST('Z', TCG_CT_CONST_ZERO)
 CONST('C', TCG_CT_CONST_C12)
 CONST('W', TCG_CT_CONST_WSZ)
 CONST('M', TCG_CT_CONST_VCMP)
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index dd67e8f6bc..cbd7642b58 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -173,14 +173,13 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 
 #define TCG_GUEST_BASE_REG TCG_REG_S1
 
-#define TCG_CT_CONST_ZERO  0x100
-#define TCG_CT_CONST_S12   0x200
-#define TCG_CT_CONST_S32   0x400
-#define TCG_CT_CONST_U12   0x800
-#define TCG_CT_CONST_C12   0x1000
-#define TCG_CT_CONST_WSZ   0x2000
-#define TCG_CT_CONST_VCMP  0x4000
-#define TCG_CT_CONST_VADD  0x8000
+#define TCG_CT_CONST_S12   0x100
+#define TCG_CT_CONST_S32   0x200
+#define TCG_CT_CONST_U12   0x400
+#define TCG_CT_CONST_C12   0x800
+#define TCG_CT_CONST_WSZ   0x1000
+#define TCG_CT_CONST_VCMP  0x2000
+#define TCG_CT_CONST_VADD  0x4000
 
 #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
 #define ALL_VECTOR_REGS    MAKE_64BIT_MASK(32, 32)
@@ -197,9 +196,6 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if (ct & TCG_CT_CONST) {
         return true;
     }
-    if ((ct & TCG_CT_CONST_ZERO) && val == 0) {
-        return true;
-    }
     if ((ct & TCG_CT_CONST_S12) && val == sextreg(val, 0, 12)) {
         return true;
     }
@@ -2229,7 +2225,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
     case INDEX_op_qemu_st_i32:
     case INDEX_op_qemu_st_i64:
-        return C_O0_I2(rZ, r);
+        return C_O0_I2(rz, r);
 
     case INDEX_op_qemu_ld_i128:
         return C_N2_I1(r, r, r);
@@ -2239,7 +2235,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
-        return C_O0_I2(rZ, rZ);
+        return C_O0_I2(rz, rz);
 
     case INDEX_op_ext8s_i32:
     case INDEX_op_ext8s_i64:
@@ -2332,14 +2328,14 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
         /* Must deposit into the same register as input */
-        return C_O1_I2(r, 0, rZ);
+        return C_O1_I2(r, 0, rz);
 
     case INDEX_op_sub_i32:
     case INDEX_op_setcond_i32:
-        return C_O1_I2(r, rZ, ri);
+        return C_O1_I2(r, rz, ri);
     case INDEX_op_sub_i64:
     case INDEX_op_setcond_i64:
-        return C_O1_I2(r, rZ, rJ);
+        return C_O1_I2(r, rz, rJ);
 
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
@@ -2355,11 +2351,11 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i32:
     case INDEX_op_remu_i64:
-        return C_O1_I2(r, rZ, rZ);
+        return C_O1_I2(r, rz, rz);
 
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
-        return C_O1_I4(r, rZ, rJ, rZ, rZ);
+        return C_O1_I4(r, rz, rJ, rz, rz);
 
     case INDEX_op_ld_vec:
     case INDEX_op_dupm_vec:
-- 
2.43.0


