Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B485AC88E5C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 00:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5uFQ-00033v-Cw; Sun, 13 Sep 2026 20:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5uFJ-00031e-7v
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 20:08:29 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5uFH-0006sq-Cc
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 20:08:28 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccc09d65so1417668a91.3
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 17:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789344506; x=1789949306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/Ze0fMD2c+qbFsutTZ9K+gj42ocGU0WO8SgAfduUTTw=;
 b=aQa00CWBQb/oZUTG1r1jrNPyWTJL23GKhSbTMXnrqeWMCof+pR9Uu5YbaqVPp0d4Fj
 Zgwi2+ARXq/imAU1w8BcZIPsZFSo44XegoRhGX7vJxlIPeIsyKa6Xvy2tbojYPr2ngZh
 SIqh87LEiTVpcQY+MXR5DWRC+uuvOOogreMb8yARAJKhHghzu7FMHU7SzOza3lS7b6/d
 jbrbXiWfh/LTLw76MaLRQzMf5zSaXZJV/dQ90vWkMhWKDg1zMd3kdfG1CqLGoxlaTAgm
 Jyo9RvnhdQaySaYqZ+rJzbH+Ay3opWtppBUEf0smkQZEWMw/NiQJ+UXKr7ttZjnFkYsS
 eDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789344506; x=1789949306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/Ze0fMD2c+qbFsutTZ9K+gj42ocGU0WO8SgAfduUTTw=;
 b=DyHru3MsEdn7Nm26DShsMgKtkuz4TxvhkFfqEfcmQBWxPBWDF5HEwmHXtlnw3VhIEq
 QdvXL2XcJySIvYPaGy6Ke0UN9KNemYicSBexCWBF6Wv04z8aWuo2GkMUyfm/z/vfwuap
 nJZIYvoy7Sx+Po65pL/L5oXebYiuvyxGKajXmq2xOEEHR50SfzE5MWIrDQ/hVPzLHiM4
 sXXnJE28j2iM9mjOBH1rIqZCZB/Brr9r76fRHQmVUlt33nyGwX0HDpqeNShzVB99q1Jr
 v3TwuRnZ2A1FlMjValyaJog7PT3Uv42fv+j+eh54W1YDtRO8CgC2oXYzSXbPkKGUvoNr
 LBDQ==
X-Gm-Message-State: AFuF++k8oWmeZm0o6rP7xCvK/dhYuee4DwFami9ukElK8qwbprLyd+AP
 rCd1qAg3s1j/k3Bz7KYMMWSY8yCTtvJZw7FPKBnqNA3ofCZAiuNb9ufbBF8Ihc8WyUEqqbkLO4v
 Vqcfi1mg=
X-Gm-Gg: AYBFou1g0N8DlQPrdN+cPImj/itot1l85g5XA79Jsh6TEwEn2D6fRoSy9tO912dq3ji
 hz6fF4qg9Fms+2kaqgX3r7uFWrG/A3SN/1frs4kVVfhHugY1J+TvmhhFax64ElDCKqZSB2U8uLs
 S/5MjVLZRx+dPXEnR1bmIZmIntRAdM9Mj+HmXMm9Qn+SdBHsX548TMqphqtQ3rEE0ckNMD5OeHK
 qXRTILikHRVRe/7JPCQCiCr31g4IGsa9DdH1C0bGJr4/z9p20GPZomFB64euInka9G3fjzcYVse
 BMSSE3wiDjmc/P59kiHjhvEaE9ijzITUVzKJ/QM4KjzqfT79wjjpXso26rUknmadm/oBCL34NBl
 nKkIY+kaTzOdxUEK5mE7Jc5Z1gEAy8lV1Kxg06J//eDlp34h4TFOka169Av/qoEKT7a/57ZQzR6
 0VRa0EH/xtem8bs2TYp+3k0v4nUPXedR593RrYhQvBwOR1rTJJ5u4uBzVw5WV96dlcsnTwTxB0o
 NvbEZY=
X-Received: by 2002:a17:90b:3c4f:b0:398:9bd4:d12 with SMTP id
 98e67ed59e1d1-39dec0972d0mr600377a91.17.1789344505911; 
 Sun, 13 Sep 2026 17:08:25 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:1665:91c0:9a80:f870])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14382741839sm4937677c88.6.2026.09.13.17.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 17:08:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: max.chou@sifive.com, palmer@dabbelt.com, daniel.barboza@oss.qualcomm.com,
 Alistair.Francis@wdc.com, philmd@oss.qualcomm.com
Subject: [PATCH v3 06/11] tcg/riscv64: Assert immediate in range for
 [isu]-type insns
Date: Sun, 13 Sep 2026 14:08:09 -1000
Message-ID: <20260914000814.785155-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914000814.785155-1-richard.henderson@linaro.org>
References: <20260914000814.785155-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 tcg/riscv64/tcg-target.c.inc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index d0c9d8e9cd2..a5ed1e95722 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -447,6 +447,7 @@ static tcg_insn_unit encode_r(RISCVInsn opc, TCGReg rd, TCGReg rs1, TCGReg rs2)
 
 static tcg_insn_unit encode_imm12(tcg_target_long imm)
 {
+    tcg_debug_assert(imm == sextract32(imm, 0, 12));
     return (imm & 0xfff) << 20;
 }
 
@@ -462,6 +463,7 @@ static tcg_insn_unit encode_simm12(tcg_target_long imm)
 {
     tcg_insn_unit ret = 0;
 
+    tcg_debug_assert(imm == sextract32(imm, 0, 12));
     ret |= (imm & 0xFE0) << 20;
     ret |= (imm & 0x1F) << 7;
 
@@ -498,7 +500,8 @@ static tcg_insn_unit encode_b(RISCVInsn opc, TCGReg rs1,
 
 static tcg_insn_unit encode_uimm20(tcg_target_long imm)
 {
-    return imm & 0xfffff000;
+    tcg_debug_assert(imm == (int32_t)imm && (imm & 0xfff) == 0);
+    return imm & 0xfffff000u;
 }
 
 static tcg_insn_unit encode_u(RISCVInsn opc, TCGReg rd, tcg_target_long imm)
-- 
2.53.0


