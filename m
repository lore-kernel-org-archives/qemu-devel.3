Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB209C982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x77JS-0002hx-O5; Thu, 17 Sep 2026 04:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77JM-0002gs-Gg
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:40 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77JE-0001vM-V8
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:39 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2db710396ffso3854265ad.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 01:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789633051; x=1790237851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1YHn9htmA3dJuXDDuJdAAeD5cNydXbAnD14Nq/B2DuM=;
 b=u6+Yq/UxsDobwBkxrbanR9cKuDuBh/OYYfl3WSEVOkmi/0tBeUPyhuFK4iJXq50PUN
 UIIJAu7zd4/lCl74k44FkV+UVPZG0rP0q962o/zPwYkLf58OosHnoCFhmxzGJ0jKxzZE
 Y4Arxl8+ZCXLaq+x9qJI3sUPFJNH9fS/eD8SoxeQ41OCDnM0Gro10sVm+bUapxzUFWmg
 HFeMxRRc2JqJJne2xJS5+M+JEAQCb0ZGIRsMKq4LxGgNQAB+HRwyNkWk1WvMHT3ZaPaB
 O6FacJbag9LW5grkD7WwDGhIC/V6AaQybbYFkYoSmlPSOP1E9HuRQcaZICCKolBmDR4D
 0oYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789633051; x=1790237851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1YHn9htmA3dJuXDDuJdAAeD5cNydXbAnD14Nq/B2DuM=;
 b=GHAidO0lO8biTxexsEt9vy0c8YVM0tATUBAZRCZP95Qy3DMqEewU8l+GGPxGxhAfXn
 3r/EhFuVPwDYD9YY/jhxQe3YsuL/cBtD/NQdFEJmL3L9TDogrztwRGZfQKm7gkWSJuZs
 g2BcNCR2bHoGCiRhL1s0IGGiW+Q3clErQO7RS3PONjVecksEyR8EIXdW7wISucXgTOvH
 E9YrPwkIanCAriosP4xwR4ktwKeH1ua8UJsbWENnzemgJ2GgxvO9Wyd+CQmg2yrD4mxb
 6lL0IMVNt8ijsI1jJVWJlHVMEV5911l1upbkgpebYX3GC6RGR9voc0E4n+du2t8/dbJJ
 80fQ==
X-Gm-Message-State: AFuF++lgJEYTXOULMSTOMZ1XLSDG4hO0IDkG53yhLr/Rv7G3dMitHSdC
 OguMT1mD86FYBeIYzw5BMR7XrKs3qfXfxPUPwbfUo4utY47eBWwUxbeymXBImIT8qjfMlqXFj7m
 w5fhKKHE=
X-Gm-Gg: AYBFou1Ax/DkWFU5J0Jc8u94bJbQ7QpRfkP1Ih0wEQcdfP/G3sp6G7iBwwJR2dPwsXJ
 Sl6imUqU8vgkaVo3P9uf5QeeCrhLlLXXfc9UbpBIU0J42LKO+ovNtPjXp05d/B7WwPVuFKH5Co1
 lk6zZDx8aGbGAgNUGOA3ZsEJU38tDRIju2uvj1ROhqBkFvoi6QI7HpQdHExr71DZfva+9Ck6A8S
 f97nPkSErTO2c7NBawzHfn0JV1JuYNF9yh6Gj78+CQfX8CyLimClPRfxEPFkUwnOwe3UVfntUMf
 PUTNfw1yKN97jFZUlvqOb4BedAIuGFbZL3lMxWIBR833LpcbodZvA0zHCPUCZCvgjHsoP2ZABij
 w1UjCHmLSkXyS9sHYI0zGAthDFqRK+pBGQo4bEEcseS4GasLSUkFJ7qiNz9wxwC0MATodGdVK6c
 jMu/CclUdZCcxuCmQcNf4F3RB/6z2XIn5kqbJDmpV8Bk5iSczVw77J93vB14+el+xCH1DluuKDp
 N5CoEI=
X-Received: by 2002:a17:903:110e:b0:2d9:2ff6:246e with SMTP id
 d9443c01a7336-2dd9ca3fb94mr40752115ad.23.1789633051185; 
 Thu, 17 Sep 2026 01:17:31 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c1943f4bcsm127638eec.21.2026.09.17.01.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 01:17:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v2 11/16] tcg/x86_64: Implement INDEX_op_lea
Date: Wed, 16 Sep 2026 22:17:11 -1000
Message-ID: <20260917081716.946668-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917081716.946668-1-richard.henderson@linaro.org>
References: <20260917081716.946668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/x86_64/tcg-target-con-set.h |  1 +
 tcg/x86_64/tcg-target-has.h     |  4 ++--
 tcg/x86_64/tcg-target.h         |  2 ++
 tcg/x86_64/tcg-target.c.inc     | 11 ++++++++++-
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/tcg/x86_64/tcg-target-con-set.h b/tcg/x86_64/tcg-target-con-set.h
index 458d69c3c07..5af8c1cb2cd 100644
--- a/tcg/x86_64/tcg-target-con-set.h
+++ b/tcg/x86_64/tcg-target-con-set.h
@@ -46,6 +46,7 @@ C_O1_I2(r, r, r)
 C_O1_I2(r, r, re)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, rO, re)
+C_O1_I2(r, rz, r)
 C_O1_I2(x, x, x)
 C_N1_I2(r, r, r)
 C_N1_I2(r, r, rW)
diff --git a/tcg/x86_64/tcg-target-has.h b/tcg/x86_64/tcg-target-has.h
index 6ffae51f923..f1d3d256eeb 100644
--- a/tcg/x86_64/tcg-target-has.h
+++ b/tcg/x86_64/tcg-target-has.h
@@ -105,7 +105,7 @@ tcg_target_extract_valid(TCGType type, unsigned ofs, unsigned len)
 }
 #define TCG_TARGET_extract_valid  tcg_target_extract_valid
 
-#define TCG_TARGET_lea_sh_valid(type, sh)          0
-#define TCG_TARGET_lea_imm_valid(type, imm)        0
+#define TCG_TARGET_lea_sh_valid(type, sh)          ((sh) <= 3)
+#define TCG_TARGET_lea_imm_valid(type, imm)        ((imm) == (int32_t)(imm))
 
 #endif
diff --git a/tcg/x86_64/tcg-target.h b/tcg/x86_64/tcg-target.h
index 7109722f240..3444bcdca0a 100644
--- a/tcg/x86_64/tcg-target.h
+++ b/tcg/x86_64/tcg-target.h
@@ -80,4 +80,6 @@ typedef enum {
     TCG_REG_CALL_STACK = TCG_REG_ESP
 } TCGReg;
 
+#define TCG_REG_ZERO  TCG_REG_NONE
+
 #endif
diff --git a/tcg/x86_64/tcg-target.c.inc b/tcg/x86_64/tcg-target.c.inc
index ec397e287c0..a41252782e1 100644
--- a/tcg/x86_64/tcg-target.c.inc
+++ b/tcg/x86_64/tcg-target.c.inc
@@ -3331,8 +3331,17 @@ static const TCGOutOpStore outop_st = {
     .out_i = tgen_st_i,
 };
 
+static void tgen_lea(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                     TCGReg a2, unsigned sh, tcg_target_long imm)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tcg_out_modrm_sib_offset(s, OPC_LEA + rexw, a0, a1, a2, sh, imm);
+}
+
 static const TCGOutOpLea outop_lea = {
-    .base.static_constraint = C_NotImplemented,
+    /* Allow "lea imm(, a2, sh), a0" via TCG_REG_ZERO constraint */
+    .base.static_constraint = C_O1_I2(r, rz, r),
+    .out = tgen_lea,
 };
 
 static int const umin_insn[4] = {
-- 
2.53.0


