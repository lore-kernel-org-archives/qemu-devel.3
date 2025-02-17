Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCACC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6pb-0002Dz-1e; Mon, 17 Feb 2025 14:31:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6p8-0001yg-7u
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:38 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6p3-0008Pp-3Q
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:32 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2fc0026eb79so8738611a91.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820624; x=1740425424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c+QFcPwjE+/PZmsE+ZNS1uNg3roQJkJdP7G2ngjxuz4=;
 b=VjIM+hPecrbHQCwfEdxmOZ2/Wu8YMN7MaVK5SmZTpLsQ3bVHtI96FzO6Iw5dk3Lj4Y
 P4wCVdXIYQktFdVIQkhNvtVorgbGLWfuqxR9jP6Imjn9rMjOzgmeONsJsgen+j29ry0I
 WKHhgJY0zoLmYd9LGdnwXP/SDuCuYGPLCSpm8RdeKzjg3sLQtccIFe5ig6TLDob9spiy
 /OyevxUqJbUct/BwHUMSLkUKYYxpG/E/c0UIVLT8f0ZIv4NZyvlXpeG9B4raW+9ZgTMH
 mlb+td8osOfAZSZ3DzRP40Ut7r5ctnulClNpGKzwKJS/XfBIx2yOACHlbwSoxi+b+8lN
 Ky6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820624; x=1740425424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c+QFcPwjE+/PZmsE+ZNS1uNg3roQJkJdP7G2ngjxuz4=;
 b=WC5SDQl6DIh9knSkxw2QepVLfinaEa4GaGO5IVoG5PA9y4TISWfZJij1obI77J3Eq0
 3n5ujHQPq0EUCZ2/qyJflN6uv9F09jFQfKqymB2Aq66HREbIZ70eG9A2zcU8MooVecmz
 Fr1/irc8BZZTdFXMX1NkDq9GGfjwzC172juOJ9ZMQQpnnEtZ4iJoIniWjZdkSD6lRPL9
 pMpxy1S6unN9bqIF2pBFSCuBXoff3ylnf0blRJ5hfgYmYpqtVIaDkYtE2byErmuLiGZF
 MKMbuLM2iiELvctOofEcXNvRI0BX6MDTa2TfDYXFTDUd0ZWkL1pzaeTBqgj7CQCq9E6b
 LK0Q==
X-Gm-Message-State: AOJu0Yx76nyAFqPZ/dZKh064IM477mqHX6skynSdh1foUOuwvlkTfTXZ
 NYtrSXezxe0Rg9Dp3gBXmaAFYca1p0jt25rVr4a0F5VuEkrVWcJmxuDmaEuz99hwcu+eItBda4N
 F
X-Gm-Gg: ASbGncsTsur45dIv2RLQe+MPiTqav8skz9X8GNIpCQMLOm5MpiRlzto4IbJdYZV5FyD
 ko03tNtX9dC7jENCHMMO7EOz6nShClIGqCPKtH51b0a7x2gcrfsAJzH26qQWf8AhTSTG6LtadUX
 OF6JZ/pu6Ac2yMyeniDYl2qfFaPKCehK3Dets9UHWTxgHhLRNZ3rkmokMwiROYKOty5apj4CIJX
 QaDTyx9iJ9QhWT0JE/bikpHMTzNxeIIxvCG2pJbs1LL6gdTYL/a25u/84wG0z+229JPDPZKTc6i
 LeTjLOxH2yNQpcLR7Iovf8gzO3Ye79OuGOpfBTLuHbn+eZk=
X-Google-Smtp-Source: AGHT+IHy2MXNVovfvbk5wp3GyN/Hp409/8duhzppvnokGLQNmI945fUM9unZVrZXCGyp0iJViKkrxA==
X-Received: by 2002:a05:6a00:3c84:b0:730:9a85:c940 with SMTP id
 d2e1a72fcca58-732618fa927mr17586255b3a.20.1739820624659; 
 Mon, 17 Feb 2025 11:30:24 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326a38ff76sm4347164b3a.160.2025.02.17.11.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:30:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 17/27] tcg/loongarch64: Use 'z' constraint
Date: Mon, 17 Feb 2025 11:29:58 -0800
Message-ID: <20250217193009.2873875-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217193009.2873875-1-richard.henderson@linaro.org>
References: <20250217193009.2873875-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


