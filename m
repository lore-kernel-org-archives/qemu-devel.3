Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06656C0219E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 03:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti3iO-0000Hx-FU; Tue, 11 Feb 2025 22:47:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ti3hi-00009l-Ld
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 22:46:28 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ti3hg-0001aZ-Tu
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 22:46:26 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-220bfdfb3f4so4308855ad.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 19:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739331983; x=1739936783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PEplZL1SkMVKTtR2qlizhEbXB0POhGhFKgHRRiKa6Uo=;
 b=MyA8mg0MO/ayECrgkCWG0WS90NMdw8FKMHVpQXUalVmumbJ8DzqTUyFKYPBPImvmsO
 Q8dO7YEWHKyfxX+vpfb2wQpgOJeqtnKDosLZ2LyL5t7xSiqsHff0jWuXUJ1OCF2uAGAe
 V1Qb/W3qp72A/+MDreCEzIIAPbeekBFQsU0XI/X8RGcC6Iax4jw15HSuTjqyOjb7q57v
 nDs4umMk5cOQY38IFPciKSDKQLp0QceFFNb7y2n1MSxwbm7J4dDBLfkWH7s52zvcc3ol
 QTiicq0NAOce4vw/+Bmc9Ql68EI8FbMYjRBAm5zkB4XR8qLXMqykWd/pnaztRRnMCt+J
 etmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739331983; x=1739936783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PEplZL1SkMVKTtR2qlizhEbXB0POhGhFKgHRRiKa6Uo=;
 b=g32DW2vDYAPtLccMtVSCtuKUNd/nVUiqCbFpVwqQd90ELxo4+jMm/CgSsWUmb4tId7
 uzGKFXeUK/eybkMUZfTpVhqAnjMPwUBrGrY1SL/i+M8ODPCH3dbVzGbdpzzqB8zFMHw/
 0xICj4tnLt9o7yMrR7GVFcNMGmkFX94B4MDXKj8BojhPVChK06Mu6ADJAtcF2fES9pqO
 aAfcju67+3794CJYIJb3zp53ibFz3vmtL7oqvOo+L6WbaMYI2aoF2qH/VhKzMewmlxF3
 lKCQNlMqZqopTS9gxQX8OOh20RxMKxKXxqAcuFaXjwoW/QElCEWu5IhKTsbYlur33f8p
 JhPA==
X-Gm-Message-State: AOJu0YzrFsUC/lzEGlhzqSkTtDQbs9z2jRpl7N8IP+yfeiBR330cYrFT
 QX07APUAJE4gNDRixVRhsuqQGAg0XDok7RqV2vPZzFvag7xMzzP0bXoiFi4DRCuwCk53B0wNjUC
 K
X-Gm-Gg: ASbGncssqqoxFPyC6FNd1AOawCCNgQ8S50tbBV39SzG1LSpIDpOie27P1Js3kT7GR90
 RA/OClXM7ZUj0wLXkNnmLestHt7cGELTltmiqZm2HuZn5LnUoWbz0kaGu54X9ZfrLFFNA8a0Khp
 kXaGUUhVLtLi6BQF5A5BUzePMaUsh0qhU3e3BfcplFLG/h1N1iammmcfJDgjZ78QcyjgnbyGgXL
 ZqxjC6vVPFPfVuZxGpKAn/svLXvX3f29HvIftO75qEQ0eKXlTsY0L9zQXcGiacJ/qUfbstYpziu
 7byiYLVP44IqEZ0aKCDozWgrT/BWfvL8kFsf2KqyB08Drh4=
X-Google-Smtp-Source: AGHT+IHUFnFk2GJwrREQt8pkmN2b3Oen8qHh/evwnSmzJwQj213Sb4K+nAPGV2MeqbeERndbobtB9w==
X-Received: by 2002:a05:6a00:1494:b0:728:e906:e446 with SMTP id
 d2e1a72fcca58-7322c4116c9mr2599176b3a.24.1739331983047; 
 Tue, 11 Feb 2025 19:46:23 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-730992eba96sm3482569b3a.126.2025.02.11.19.46.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 19:46:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/6] tcg/riscv: Use 'z' constraint
Date: Tue, 11 Feb 2025 19:46:16 -0800
Message-ID: <20250212034617.1079324-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212034617.1079324-1-richard.henderson@linaro.org>
References: <20250212034617.1079324-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
 tcg/riscv/tcg-target-con-set.h | 10 +++++-----
 tcg/riscv/tcg-target-con-str.h |  1 -
 tcg/riscv/tcg-target.c.inc     | 12 ++++++------
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index 3c4ef44eb0..e92e815491 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -10,17 +10,17 @@
  * tcg-target-con-str.h; the constraint combination is inclusive or.
  */
 C_O0_I1(r)
-C_O0_I2(rZ, r)
-C_O0_I2(rZ, rZ)
+C_O0_I2(rz, r)
+C_O0_I2(rz, rz)
 C_O1_I1(r, r)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rJ)
-C_O1_I2(r, rZ, rN)
-C_O1_I2(r, rZ, rZ)
+C_O1_I2(r, rz, rN)
+C_O1_I2(r, rz, rz)
 C_N1_I2(r, r, rM)
 C_O1_I4(r, r, rI, rM, rM)
-C_O2_I4(r, r, rZ, rZ, rM, rM)
+C_O2_I4(r, r, rz, rz, rM, rM)
 C_O0_I2(v, r)
 C_O1_I1(v, r)
 C_O1_I1(v, v)
diff --git a/tcg/riscv/tcg-target-con-str.h b/tcg/riscv/tcg-target-con-str.h
index 089efe96ca..2f9700638c 100644
--- a/tcg/riscv/tcg-target-con-str.h
+++ b/tcg/riscv/tcg-target-con-str.h
@@ -21,4 +21,3 @@ CONST('K', TCG_CT_CONST_S5)
 CONST('L', TCG_CT_CONST_CMP_VI)
 CONST('N', TCG_CT_CONST_N12)
 CONST('M', TCG_CT_CONST_M12)
-CONST('Z', TCG_CT_CONST_ZERO)
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index dae892437e..361114a780 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2680,7 +2680,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st16_i64:
     case INDEX_op_st32_i64:
     case INDEX_op_st_i64:
-        return C_O0_I2(rZ, r);
+        return C_O0_I2(rz, r);
 
     case INDEX_op_add_i32:
     case INDEX_op_and_i32:
@@ -2706,7 +2706,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
-        return C_O1_I2(r, rZ, rN);
+        return C_O1_I2(r, rz, rN);
 
     case INDEX_op_mul_i32:
     case INDEX_op_mulsh_i32:
@@ -2722,7 +2722,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_divu_i64:
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i64:
-        return C_O1_I2(r, rZ, rZ);
+        return C_O1_I2(r, rz, rz);
 
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
@@ -2744,7 +2744,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
-        return C_O0_I2(rZ, rZ);
+        return C_O0_I2(rz, rz);
 
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
@@ -2754,14 +2754,14 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_add2_i64:
     case INDEX_op_sub2_i32:
     case INDEX_op_sub2_i64:
-        return C_O2_I4(r, r, rZ, rZ, rM, rM);
+        return C_O2_I4(r, r, rz, rz, rM, rM);
 
     case INDEX_op_qemu_ld_i32:
     case INDEX_op_qemu_ld_i64:
         return C_O1_I1(r, r);
     case INDEX_op_qemu_st_i32:
     case INDEX_op_qemu_st_i64:
-        return C_O0_I2(rZ, r);
+        return C_O0_I2(rz, r);
 
     case INDEX_op_st_vec:
         return C_O0_I2(v, r);
-- 
2.43.0


