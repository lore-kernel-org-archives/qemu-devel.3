Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95684C61DDA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Jw-0001Dn-BC; Fri, 28 Aug 2026 18:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Jt-00018j-EC
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:45:09 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Jr-0004Ze-Lq
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:45:09 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cc1bcdb3c4cso1158661a12.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787957106; x=1788561906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=isEEnlsK2w3OoY1XfX10hJI4M7LH9f9XoAugk3bYT1k=;
 b=js1XT9qw0E7jjnmVKFRp9UpCOwv4hCdOeCEx+tzgkHRiOv+nOIKy/lrz9T3QndUnI1
 UUiH89JgziimlgscAsijMXe9rHW2LqYCqczAiVyMmAOA8okIcQ+bazJMZilNfTVB006V
 IY+PuWnyKGYVL7JJt9BC1f8oDmpDGgfyVz1hm4wIWezUoEG8E0guTs0hfREe3N4XLAb5
 3F5hujbQ5l60eA4+z6Dg1WWUkKdpJ/a2fzOi6RCQY7fWH35Bbxzwb/8Fll8ZWLc0UWmL
 Pp4zP+0tkajOXYV52dKn/l0dF+O/4yl7t3gPNS4e9rowAFpEHSGJJsnPA4IUkcdkjMyb
 tCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957106; x=1788561906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=isEEnlsK2w3OoY1XfX10hJI4M7LH9f9XoAugk3bYT1k=;
 b=chlTN2pwj5n2rYjPo9Y7ik2bxcDs+9A0IYrobAuj5nN142eYlpBR+Y8wgBdJlIqXux
 fPEFCPElIKuOnAsjUvl8GcWDD0aWCAkXemO0qVgBdTIQ8P/Ye1MP7UCn6n+KTe1kTKd5
 49ZeLG0ArPfJZKAup3K5y/2MdOFnfqEqy4sssO4xc7fpmynwNyxAXgh54d2SNWCeIQq2
 Ub5yy7bJog4ADs1DaqPVIui5j9eH6urUZltIY2O/xshI+mB1NebVxnSJ34Vo2G1+Yaqv
 OKA7toZ8d++L7wNfgqxKmS4brukM4BWG8Y3rMsBs40HyPK6yI6Cmb6fTYJm6hUw+qWlg
 RaIQ==
X-Gm-Message-State: AFuF++mAOMzupbbb+pNJ7xe+9ztAJHb25ytdpZv6Xodqb5EFgT6fW8We
 wh44qcHRbNMOyG2l3THEiVeHwekYemkPPdUpHHmE+YF8h4hgxuodtvlOCLDMDkF5tHkDSaDSjEr
 SUbgJxSc=
X-Gm-Gg: AYBFou3b05II/FwX0pbXhRF+YWPQMLa97cDdWkqgy+WFs2BxPztahXxgrmLl+5xDMto
 rIjhJL/ns/KTvDzubA+72B6+TZ4s2QNh8O3Mur4x9CU6Oi7oM3n74w6XnkdvCSDKbfu6vqDz3H0
 bOCFtceO3jtRCTzvDcp00kPOsd6dCUuA0eGPuvevk+oMz2R6d+UnrS55EtySDCExO55He8f9/CA
 D1Zi3rF8GRNWoELurbTWHq9QMQVfMsTiX1p0xZ7xz54toPcWHkc6cP0MGv6XrfMcCUO6c59v69R
 eMVzSvThQiTCf74A0cbu5CxPa/dqLejg1yFXPnCzcjPgpq0UfqKiv3WE/WGzuasabD9B3LBAO8i
 NznuIum4L+QKtCJYjS9M2oGg3PdTT3Japen2BvA2oVeZ+sy2OdZIUCDvc/07dPia/AhJPqE3NEG
 6VlKu4NEg2YOt+gZ28hmEyzJCaiV8OrJYkoXey49N/hb5cSfmwWAc6DMK6CnzHqPeeFPplmcKk/
 8NhLXhEGoYvHdM+lkIp
X-Received: by 2002:a17:90b:55d0:b0:398:a486:81ec with SMTP id
 98e67ed59e1d1-398a4868bc9mr1981837a91.11.1787957106210; 
 Fri, 28 Aug 2026 15:45:06 -0700 (PDT)
Received: from stoup (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-398a2f5187fsm427594a91.1.2026.08.28.15.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:45:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH 15/16] tcg/riscv64: Implement INDEX_op_lea
Date: Fri, 28 Aug 2026 15:44:50 -0700
Message-ID: <20260828224451.1564072-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828224451.1564072-1-richard.henderson@linaro.org>
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
 tcg/riscv64/tcg-target-has.h | 12 ++++++++++--
 tcg/riscv64/tcg-target.c.inc | 16 +++++++++++++++-
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/tcg/riscv64/tcg-target-has.h b/tcg/riscv64/tcg-target-has.h
index 93f8baad09f..3cdeb5c3900 100644
--- a/tcg/riscv64/tcg-target-has.h
+++ b/tcg/riscv64/tcg-target-has.h
@@ -69,7 +69,15 @@ tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
 
 #define TCG_TARGET_deposit_valid(type, ofs, len)  0
 
-#define TCG_TARGET_lea_sh_valid(type, sh)         0
-#define TCG_TARGET_lea_imm_valid(type, imm)       0
+/*
+ * The SH*ADD instructions only operate on full register width.
+ * To allow TCG_TYPE_I32, we'd need a subsequent extension,
+ * with the result no better than the separate shift+add insns.
+ */
+#define TCG_TARGET_lea_sh_valid(type, sh)         \
+    (cpuinfo & CPUINFO_ZBA &&                     \
+     (type) == TCG_TYPE_REG &&                    \
+     (sh) >= 1 && (sh) <= 3)
+#define TCG_TARGET_lea_imm_valid(type, imm)       ((imm) == 0)
 
 #endif
diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index df4c4a9789b..ba7aab9246c 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -224,6 +224,7 @@ typedef enum {
 
     /* Zba: Bit manipulation extension, address generation */
     OPC_ADD_UW = 0x0800003b,
+    OPC_SHxADD = 0x20000033,  /* plus sh << 13 */
 
     /* Zbb: Bit manipulation extension, basic bit manipulation */
     OPC_ANDN   = 0x40007033,
@@ -2725,8 +2726,21 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static void tgen_lea(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                     TCGReg a2, unsigned sh, tcg_target_long imm)
+{
+    tcg_out32(s, encode_r(OPC_SHxADD, a0, a2, a1) | (sh << 13));
+}
+
+static TCGConstraintSetIndex cset_zba_rrr(TCGType type, unsigned flags)
+{
+    return cpuinfo & CPUINFO_ZBA ? C_O1_I2(r, r, r) : C_NotImplemented;
+}
+
 static const TCGOutOpLea outop_lea = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_zba_rrr,
+    .out = tgen_lea,
 };
 
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
-- 
2.53.0


