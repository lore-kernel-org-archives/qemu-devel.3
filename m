Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616B1C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnx0-0004gi-Rp; Sun, 16 Feb 2025 18:21:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwS-000410-Ln
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:20:54 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwM-0006Q2-JG
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:20:51 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2fa7465baceso7723717a91.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748044; x=1740352844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9L+VCsm6q14T7WiV7P5yZL5eDQKyDiz96yYz7K4dJKU=;
 b=kLsn8V325fp6m7rWdf9Kce2fnCkpuH1MA/LZBGnnT7+1/wb6oTzXCDgotx9fWXd1j+
 3bc4vCsh6STTHgihZOst1KiTisa80eLqJymVkVrx9SXPB5tvGiIRXAqAtzSIxcZDljzO
 6041PMDaYAHfTRJbOsa7xlFai8kmG3xSgxTba9hqkRJV4WPvEY/WIo4RdH2F8+puZvJv
 DU9esay/DU49wqbG+92vjOoXhD4wGu93I1ALg+yn+t6Q4xUkOHzqDmBRhNsgLXRb2AQn
 r8ixZHcg8d/reGUjMqy5cPWiVBg3aupfJc993WiOKcWOWnSbFTWPNu59veExchqjqu+J
 t3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748044; x=1740352844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9L+VCsm6q14T7WiV7P5yZL5eDQKyDiz96yYz7K4dJKU=;
 b=L8tOxgEWfFaa4esJ1uD/jY1M9I4RtFyYHSPru/rTdHDOWoJ+eo5/5CZALABqGkZF4E
 3D9B81XypoU300gDu1qGNHKMPDBdvNyX6XmmJPGpevJGLSFhWRvO9CzD2wNy4hwU9SVN
 mGBlFH5Dy/aX6KayGwWQY5xvltSqiJ5LVQSctxRwXVSP/DgGzyGn9jR4s2RFxqDi4BgK
 TgXN326B4XZkfxfj/oaWLi0gvektXTopr51EgNCkh6omxqDtyidMO3TQClpN1VUvbJc5
 SR4EfH6lhk4FGOf2Yh9Zx84pE47n4X8Hi8cGfzVrjgfeoJPyRVv9js8gC99MFFfVJajN
 hd5w==
X-Gm-Message-State: AOJu0YyWbOfgVWihUgtgNrWKW8LNEG962WbPNF5WmAlbIq/v0aGWIJ9S
 ZiQVzjIrnuSoMXtGFxvW7qOhPLOQ3H/325mMZvvhWDq3aHmG3geQDg5x74A8omP3NoL7d1rdmrI
 F
X-Gm-Gg: ASbGncv/khwR8ic6kke/wdkjiQ1H6FiwPMw4IRSBTHlJaYMAFsN4RJlDnBzPUEihZP2
 xY8IH0li/7Q/aChj+UYE7DwDL28uwI0MVXnppXW8iL5zG+mIXG/8yH9oVluYBFXLxjFbKdxbtN7
 8+G5Q84Me2amEEk354ESbry1Snaju0oha6vIwfQxPpIxn/VU/4+BX8PxwpoWQYOQ+UXNxC6uoLW
 KysYGXzlIoRKcf66+7uL7kFVP2FtG+8VrsIBNLmXW6vknNxq8XY4a0OogbB8gz1E2N+8U56LFSI
 M/36zPfHhaSnJfyQbBoCT/xXEoZFZ+cCq/kDNYBRydip154=
X-Google-Smtp-Source: AGHT+IHys5pNkUqLh0lgPCc9pEDhCR6OijbRMPTPngzJfaXi9iI6UC6KBsVyAbl671ofb0A+o/mywA==
X-Received: by 2002:a17:90b:4b91:b0:2f9:9e64:37b1 with SMTP id
 98e67ed59e1d1-2fc41040fd9mr11332875a91.28.1739748044622; 
 Sun, 16 Feb 2025 15:20:44 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.20.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:20:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 120/162] tcg/i386: Remove support for add2/sub2
Date: Sun, 16 Feb 2025 15:09:29 -0800
Message-ID: <20250216231012.2808572-121-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target-con-set.h |  1 -
 tcg/i386/tcg-target-has.h     |  8 ++++----
 tcg/i386/tcg-target.c.inc     | 31 -------------------------------
 3 files changed, 4 insertions(+), 36 deletions(-)

diff --git a/tcg/i386/tcg-target-con-set.h b/tcg/i386/tcg-target-con-set.h
index 0ae9775944..85c93836bb 100644
--- a/tcg/i386/tcg-target-con-set.h
+++ b/tcg/i386/tcg-target-con-set.h
@@ -57,4 +57,3 @@ C_O2_I1(r, r, L)
 C_O2_I2(a, d, a, r)
 C_O2_I2(r, r, L, L)
 C_O2_I3(a, d, 0, 1, r)
-C_N1_O1_I4(r, r, 0, 1, re, re)
diff --git a/tcg/i386/tcg-target-has.h b/tcg/i386/tcg-target-has.h
index 0328102c2a..a984a6af2e 100644
--- a/tcg/i386/tcg-target-has.h
+++ b/tcg/i386/tcg-target-has.h
@@ -26,14 +26,14 @@
 #define have_avx512vbmi2  ((cpuinfo & CPUINFO_AVX512VBMI2) && have_avx512vl)
 
 /* optional instructions */
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
+#define TCG_TARGET_HAS_add2_i32         0
+#define TCG_TARGET_HAS_sub2_i32         0
 
 #if TCG_TARGET_REG_BITS == 64
 /* Keep 32-bit values zero-extended in a register.  */
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_add2_i64         1
-#define TCG_TARGET_HAS_sub2_i64         1
+#define TCG_TARGET_HAS_add2_i64         0
+#define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 #else
 #define TCG_TARGET_HAS_qemu_st8_i32     1
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 524e288f26..ef5f9e3f48 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3479,31 +3479,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_st(s, a0, a1, a2, args[3], TCG_TYPE_I128);
         break;
 
-    OP_32_64(add2):
-        if (const_args[4]) {
-            tgen_arithi(s, ARITH_ADD + rexw, a0, args[4], 1);
-        } else {
-            tgen_arithr(s, ARITH_ADD + rexw, a0, args[4]);
-        }
-        if (const_args[5]) {
-            tgen_arithi(s, ARITH_ADC + rexw, a1, args[5], 1);
-        } else {
-            tgen_arithr(s, ARITH_ADC + rexw, a1, args[5]);
-        }
-        break;
-    OP_32_64(sub2):
-        if (const_args[4]) {
-            tgen_arithi(s, ARITH_SUB + rexw, a0, args[4], 1);
-        } else {
-            tgen_arithr(s, ARITH_SUB + rexw, a0, args[4]);
-        }
-        if (const_args[5]) {
-            tgen_arithi(s, ARITH_SBB + rexw, a1, args[5], 1);
-        } else {
-            tgen_arithr(s, ARITH_SBB + rexw, a1, args[5]);
-        }
-        break;
-
 #if TCG_TARGET_REG_BITS == 64
     case INDEX_op_ld32s_i64:
         tcg_out_modrm_offset(s, OPC_MOVSLQ, a0, a1, a2);
@@ -4109,12 +4084,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(re, r);
 
-    case INDEX_op_add2_i32:
-    case INDEX_op_add2_i64:
-    case INDEX_op_sub2_i32:
-    case INDEX_op_sub2_i64:
-        return C_N1_O1_I4(r, r, 0, 1, re, re);
-
     case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, L);
 
-- 
2.43.0


