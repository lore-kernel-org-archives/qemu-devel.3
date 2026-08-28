Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6018C61DDC
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Ju-0001Ae-NV; Fri, 28 Aug 2026 18:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Js-00017k-Qy
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:45:08 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Jr-0004ZZ-80
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:45:08 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2cedda2ce6fso10478005ad.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787957106; x=1788561906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cgi1x/cBiZTiouoNgNskgD/hwH64ZIV4zuyjPmd0FTQ=;
 b=S+nGORUBpjDJ1VLjq9dYzAABtwkTkB05CE6cmaSWNDXhZNXFEJ+/5+idxheqTf6k9J
 8vzVGPjexwro+62G0mIN9jdw/Bgplzqx1TTeAGe74zqmktKHdvKrXxqy/S8JMA8IUJ9g
 MB2T4rFgyQNgXq6JZ2SCmHatHVrkZ5EWgADtimYddLJjKyN97n6rskO8cIvdx4+JCXHn
 s0AmJXihS0U1gBUHLGLL2P9HQQfhjr6vo6NynBAsPxyrnGN+VfcICoAmiE4nRLwVTSLp
 PzccQX0S/AlUyL8wwZDLGy7euEsvUBBcoKS3WrzUQ93RHkdYCvvkEa4albc9+cT9OCNY
 BOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957106; x=1788561906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cgi1x/cBiZTiouoNgNskgD/hwH64ZIV4zuyjPmd0FTQ=;
 b=G4e9sh7bfsShfWJKxvLpMmMa89oyJqIBCyA8/Iqxre8wj35LTgQEljcL4V/BSJPL4F
 O7Mtt15pFiGsbNki7zte7jSCz5gx2EcStbqUBbdTnmCK2rmvpW7rT2/4wWNY0sJcO1VN
 /EFfrXsA8iYbjtz6BRJLwNYoYmETQ8O3BSyKB1eP01MJtZdD4O0gaeUxC+r8o64E7D5d
 oW7g2s790htNoEM/qRV1e1gghVnCLtR1GVqv82vZhAw3/Uy+orXFvm7GVZcR5VLmwJ7t
 WEeV64HWZPWu1agjYKPd1Qf4j/SEqbd0p2utHItiS3hxdmFAJMjBN8BqtbSVthTiQBiM
 BztQ==
X-Gm-Message-State: AFuF++kEnQZyRudSc339XBNcYt0A8FtRXTb4jPRfXIj/JjuQL0Ae2Un9
 q1N6r2zEhZv/sERmZtEQapUU3ZBiVoqCT+qhspAtfrJWe1a4LeqqDA72fOp99s3Jd661iTn3C0p
 VBaZ+LtI=
X-Gm-Gg: AYBFou2+2lK9qmp3vj+fR/EQopfE1d3D/68CxWqe+z897/WovuHTaifBSX2YmcjMPBU
 VoKwTFtpXLYC3q0Km5Qu/n5Lqj5gjfsjy3YBQ+49/RfhBIVF4Sn+2FlKBV1y7sptS96BbWk67Sa
 XX4x/3lKGfj+V0a1nF+m7gIG+6VIA4vZ0qkfkib/oxYBBHLu4LVcxifE39hS0rljXoQruimbNYi
 9AFCiDA+/qHAbMvJm3W8R7yW6Ry2xqR0U8meAa/8N90LvViamHhnKq1klZlaxB0H2oFtVNUZduK
 deEw4z86Rcwq5e0NqCYTlBk3rcfATHAx5HqPCNsicL+Kv39Lfc+ktkaF2QV3yl+gmTAXTFrgjJU
 9MxdEoruubIQ6yrh2rtIPAskZLZtRQ4VQoR6qM+lnfdVhh52NXBY1grFXSABz8XmQCqRWITniVr
 8/aO/Xa7I2tgT9184VGzGr+Z3G98mtoax1HUZf4xeQ+jixwxdRZZQmhczzQHZpELM3CRfyM7A0i
 JeZUPuD2Jf3LcmHuBUH
X-Received: by 2002:a17:90b:50cf:b0:36d:9e0b:3801 with SMTP id
 98e67ed59e1d1-396d0ed78e5mr18992286a91.8.1787957105437; 
 Fri, 28 Aug 2026 15:45:05 -0700 (PDT)
Received: from stoup (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-398a2f5187fsm427594a91.1.2026.08.28.15.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:45:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH 14/16] tcg/aarch64: Implement INDEX_op_lea
Date: Fri, 28 Aug 2026 15:44:49 -0700
Message-ID: <20260828224451.1564072-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828224451.1564072-1-richard.henderson@linaro.org>
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
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
 tcg/aarch64/tcg-target-has.h | 5 +++--
 tcg/aarch64/tcg-target.c.inc | 9 ++++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
index 86672b2eab4..6327c5215a2 100644
--- a/tcg/aarch64/tcg-target-has.h
+++ b/tcg/aarch64/tcg-target-has.h
@@ -57,7 +57,8 @@
 #define TCG_TARGET_sextract_valid(type, ofs, len)  1
 #define TCG_TARGET_deposit_valid(type, ofs, len)   1
 
-#define TCG_TARGET_lea_sh_valid(type, sh)          0
-#define TCG_TARGET_lea_imm_valid(type, imm)        0
+#define TCG_TARGET_lea_sh_valid(type, sh)          \
+    ((sh) >= 0 && (sh) < tcg_type_size(type) * 8)
+#define TCG_TARGET_lea_imm_valid(type, imm)        ((imm) == 0)
 
 #endif
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 76adb2256f9..6836c0dd94f 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -3081,8 +3081,15 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static void tgen_lea(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                     TCGReg a2, unsigned sh, tcg_target_long imm)
+{
+    tcg_out_insn(s, addsub_realshift, ADD_LSL, type, a0, a1, a2, sh);
+}
+
 static const TCGOutOpLea outop_lea = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out = tgen_lea,
 };
 
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
-- 
2.53.0


