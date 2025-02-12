Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D3EC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 03:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti3ia-0000RS-5P; Tue, 11 Feb 2025 22:47:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ti3hi-00009m-V7
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 22:46:28 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ti3hh-0001ab-9B
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 22:46:26 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21f62cc4088so76351655ad.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 19:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739331984; x=1739936784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C4eUV2eAbQIR5bmWGbWaT4KdX4syAYZH2YVmFoTAlF0=;
 b=ldLVuwZIylpqrQkh+GiXBLpXA1Xr+PgFMJlwHk3dUDoaRwZsQ1rliYBQ0Ic5IwIzw1
 VDXJTesjkYOcylfapPd0xKkeXrOqE4gmpD7nk8XhrhuG2Oz/TFTXSy7ln+HnTct2ytdX
 mPhbQ4+YxCN+IPf26aHn6rt1i0I1Aq1RYBKQr3+6ikyv33tHj6L6il2PBwHulRmySy5C
 ROUBA2poF53FKQzhDY2gEZxGxIZLVWZnEIrOLU0pJShwUsQzIuPkZtLLF9HBNRsftRLe
 7wEBPt4KJyd42YsJ+5Xet/Tpt520Oyl7ZfX4MlBijYFYUEpKE/bOP5ehzDE/aBnp9DCR
 lsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739331984; x=1739936784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C4eUV2eAbQIR5bmWGbWaT4KdX4syAYZH2YVmFoTAlF0=;
 b=eBFiJsbDn4QLSNjI8QfiYNR+qxU2cK+YkVU6SPeAVzEYUnFiPpUYk/YhtgpB00vOSK
 mu6ME9SD39NcE1hvHDQ0Y9h5lGEvIEs3RirdWP4diGrGp5Hf79Rxz32wJ11FpvzDFryx
 f/4BFpxkt13tGRwAACvspJHkC9YZDbSKdXl5u6iTKXg2NcvNZjl2bqHM9tWPCKW97d/N
 UQrmXrkzlOb+s32pP/q57htrmR7c+jAcyd/Voc0VJ7yaAuWO6s8pnRwssTV7gjawWfVw
 YEKWCoPZ3mFnmB2Jcsw8mVsHncgUdOZXnnc5yPGvKFaTrRQIic04JBSB39iA8XIj+Ixf
 Mm6g==
X-Gm-Message-State: AOJu0YwckBr8xMNpUwtAUFxWbdsfNWHbHGuk6KD4OCMNuRKGOF5iO14l
 HYwQBsVB21AvmQOPyHhFFRr4OOgOV9TVQpY7jHV06Ax+MshIYDlf/v/Jr0C4WVtyhctsdmmsKpH
 j
X-Gm-Gg: ASbGncvzKKD9v4Mgh5dWk8O5N1M4sJVarRqMWkF28w8bthGeJXGovAQad6woYxe9dQN
 7UVIjpwEw7EVB+Kcce8dxHE0KKiPDH3vOnOFkJM5mLm7QZSqIoShUfoIybaLm3nhAbfX16mqRIS
 RPSx67npxhEtV55iyDGlJkG2KKDimjc4AB7gZELbPp1LHdoZeWxvw+IPjq1y5oIwJZaL1qrsJ4N
 P7YN/YoXU/5ce+qR+KiUa/RrosRiYa1fdlYQWQNFnVmfQ8V3620BIuV/Owc4kOpWFpfhf25xUDf
 g1LGMrmcjhYnuj4dzuLc0X3nPll2y0UxvSh/pyaV8VJ9dT8=
X-Google-Smtp-Source: AGHT+IGH0QCgd9QmtbnuI2AmkzbONF//eZ3qoihpmM+DRncw8XbDCR3zVYJuwvSGhkW08oTRPdEaWw==
X-Received: by 2002:a05:6a00:1c9d:b0:730:957d:a812 with SMTP id
 d2e1a72fcca58-7322c377e7emr1938320b3a.1.1739331983652; 
 Tue, 11 Feb 2025 19:46:23 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-730992eba96sm3482569b3a.126.2025.02.11.19.46.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 19:46:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/6] tcg/sparc64: Use 'z' constraint
Date: Tue, 11 Feb 2025 19:46:17 -0800
Message-ID: <20250212034617.1079324-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212034617.1079324-1-richard.henderson@linaro.org>
References: <20250212034617.1079324-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
 tcg/sparc64/tcg-target-con-set.h | 12 ++++++------
 tcg/sparc64/tcg-target-con-str.h |  1 -
 tcg/sparc64/tcg-target.c.inc     | 12 ++++++------
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/tcg/sparc64/tcg-target-con-set.h b/tcg/sparc64/tcg-target-con-set.h
index 434bf25072..61f9fa3d9f 100644
--- a/tcg/sparc64/tcg-target-con-set.h
+++ b/tcg/sparc64/tcg-target-con-set.h
@@ -10,11 +10,11 @@
  * tcg-target-con-str.h; the constraint combination is inclusive or.
  */
 C_O0_I1(r)
-C_O0_I2(rZ, r)
-C_O0_I2(rZ, rJ)
+C_O0_I2(rz, r)
+C_O0_I2(rz, rJ)
 C_O1_I1(r, r)
 C_O1_I2(r, r, r)
-C_O1_I2(r, rZ, rJ)
-C_O1_I4(r, rZ, rJ, rI, 0)
-C_O2_I2(r, r, rZ, rJ)
-C_O2_I4(r, r, rZ, rZ, rJ, rJ)
+C_O1_I2(r, rz, rJ)
+C_O1_I4(r, rz, rJ, rI, 0)
+C_O2_I2(r, r, rz, rJ)
+C_O2_I4(r, r, rz, rz, rJ, rJ)
diff --git a/tcg/sparc64/tcg-target-con-str.h b/tcg/sparc64/tcg-target-con-str.h
index 0577ec4942..2f033b3ac2 100644
--- a/tcg/sparc64/tcg-target-con-str.h
+++ b/tcg/sparc64/tcg-target-con-str.h
@@ -16,4 +16,3 @@ REGS('r', ALL_GENERAL_REGS)
  */
 CONST('I', TCG_CT_CONST_S11)
 CONST('J', TCG_CT_CONST_S13)
-CONST('Z', TCG_CT_CONST_ZERO)
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 527af5665d..68d10593ca 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1579,7 +1579,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
     case INDEX_op_qemu_st_i32:
     case INDEX_op_qemu_st_i64:
-        return C_O0_I2(rZ, r);
+        return C_O0_I2(rz, r);
 
     case INDEX_op_add_i32:
     case INDEX_op_add_i64:
@@ -1611,22 +1611,22 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_setcond_i64:
     case INDEX_op_negsetcond_i32:
     case INDEX_op_negsetcond_i64:
-        return C_O1_I2(r, rZ, rJ);
+        return C_O1_I2(r, rz, rJ);
 
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
-        return C_O0_I2(rZ, rJ);
+        return C_O0_I2(rz, rJ);
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
-        return C_O1_I4(r, rZ, rJ, rI, 0);
+        return C_O1_I4(r, rz, rJ, rI, 0);
     case INDEX_op_add2_i32:
     case INDEX_op_add2_i64:
     case INDEX_op_sub2_i32:
     case INDEX_op_sub2_i64:
-        return C_O2_I4(r, r, rZ, rZ, rJ, rJ);
+        return C_O2_I4(r, r, rz, rz, rJ, rJ);
     case INDEX_op_mulu2_i32:
     case INDEX_op_muls2_i32:
-        return C_O2_I2(r, r, rZ, rJ);
+        return C_O2_I2(r, r, rz, rJ);
     case INDEX_op_muluh_i64:
         return C_O1_I2(r, r, r);
 
-- 
2.43.0


