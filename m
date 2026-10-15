Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06475CC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ4i-0002Oq-U5; Thu, 15 Oct 2026 06:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4h-0002OA-I5
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:39 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4g-0007qN-1F
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:39 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48c4d870d54so3260848f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792061556; x=1792666356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oipr+O1JVSmQa2K56mCmNeInvuuThWZUgF5YjhwTyfQ=;
 b=RlURghmsUJjek15jrsoqMwGki9UbplaHdtqNovOw5YAd81Wz3ZLkUurAjIeWlh/sFr
 Z/IBjzW2pIR+kQOgHyPGTl0+LCYxT5+AtOhpesTPeibxnKnIGOtH2j4Rd1SNGDlzKyiG
 hB5NhPOIId08q5sNvIdQPaM//XLPSVyDSo0fGulDl4MWkNN6t4TlZPT91NylTeO7b9ew
 Q+Q5SHC2w66LwfIvRvDH6bXXaqLQmHEjOD7QDfsYLKJo4nGcQVA9ddgTp1RsmrpS+/h7
 gjR5ER1uOy9wWF9b0LdFCM+oVBEvZ1zLG2qFjaw0JwxZFjccRWO5qDQG87fGd2UqQB86
 /TDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061556; x=1792666356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oipr+O1JVSmQa2K56mCmNeInvuuThWZUgF5YjhwTyfQ=;
 b=zvP8fTiQee6g+HsVF2VTqm/8YVnanZGzGQBWEeFOtVu/+xeFe3/coM/vCT1DaWmrv2
 mme7ovl4bnPqO4GOq5CtuPG/JavuDFErvvbdCZ950xrdnDK846a/+5Q0gi88sYEeXrQC
 gKEPV4wD/F+tdnnT4pebfy4/hv2SncdlA3iebAxtqpKWcTmY3iLKL/ihVgPFwehgKZ8s
 qLmNiiL8X3ic/ylOQEL4st5UHLIveFM6YD0qm/ZdLuabp/vP9aFzHRc7o7wvr3Y+LQsU
 GzH2C9UDp1KdbalIBhZYLM9axD/YX1DSzeaV3/o1fqX72OQMe0tnm+YK5Lv9VJ6YhNH4
 /kvg==
X-Gm-Message-State: AFq9FYJn3SbVkyTY2Uaa9ax7xAXefFlAsGr4BUi6vkYoz3lZl1v3uFZn
 CRPwhyY/HDy6K8Hfjs9YP33LWcrIjldo4GnvhRLhbsB+Tpexw60+NZRaiz9NZOqsVbOJBZyBgaU
 IjhLt/yk=
X-Gm-Gg: AYBFou3Q+IdCD9j2Va1mDMlD9Fw6m44y1uF3MdWTBZ8FpROvAgRbdbQsyDGtVKqPfaZ
 8t/uqmZAb5A9hrjJ8brh4FFcHpEbxtqVbHT0bymhgNxAowVzKP/1d06ljJELmBO/VOwPL0EdFEK
 4r8WMFJuUMjpVvSusXoPnppm+WDHB1zPzBK13fDFZZL2WolgyCqcFijG+FRYaJf5ocOlXHnZGzS
 77xKO84yvse+4lmdbkv/xHITXg3Uxfwmh4ulf4IIqNgaqLcZGGpHtLnoIYIwwyM/zYB3JapiqXo
 IgmEv1+wjP6Dd2DHulXTXrn/JAily9XUVXwMCVWZMLFjnsX/VKueWLcV3b6W0C9/Jlmd5IhbNE6
 eEyR91KR/FeHOBk07iOlP0+vTbHGHGUdGHVCEl7vbrvIO5blKJgYABBwl99uxznTUOqs49ZffpQ
 3QDTqmKR+g9dL2Dh12iZUo+rqJXCq9ZJRwRPm/O9Co08iZUZxGoVQVjOPtalBwnIYSuMqPgvKIO
 PY7l9WrWTr4dWhcJRPRUYvn372c6x0ONLub3Qb7/cOMUqo+iu8yyj+BTGysAR2q60aq71FC7gQ/
 r93BAGqVU1Tr1c4=
X-Received: by 2002:a05:6000:41cd:b0:48d:f14a:917f with SMTP id
 ffacd0b85a97d-48df14a9332mr6327710f8f.2.1792061554477; 
 Thu, 15 Oct 2026 03:52:34 -0700 (PDT)
Received: from stoup.fritz.box
 (p200300ca3f0f8b006e0ed1a687ab6860.dip0.t-ipconnect.de.
 [2003:ca:3f0f:8b00:6e0e:d1a6:87ab:6860])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df5b88207sm3075949f8f.59.2026.10.15.03.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:52:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 08/16] tcg/riscv64: Rename uj-type to j-type format
Date: Thu, 15 Oct 2026 12:52:00 +0200
Message-ID: <20261015105212.356392-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015105212.356392-1-richard.henderson@linaro.org>
References: <20261015105212.356392-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
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

The current riscv documentation calls this j-type.

Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv64/tcg-target.c.inc | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index fb0ba046829..c582bb74bd5 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -499,9 +499,9 @@ static tcg_insn_unit encode_u(RISCVInsn opc, TCGReg rd, uint32_t imm)
     return opc | (rd & 0x1f) << 7 | encode_uimm20(imm);
 }
 
-/* Type-UJ */
+/* Type-J */
 
-static tcg_insn_unit encode_ujimm20(uint32_t imm)
+static tcg_insn_unit encode_jimm20(uint32_t imm)
 {
     tcg_insn_unit ret = 0;
 
@@ -513,9 +513,9 @@ static tcg_insn_unit encode_ujimm20(uint32_t imm)
     return ret;
 }
 
-static tcg_insn_unit encode_uj(RISCVInsn opc, TCGReg rd, uint32_t imm)
+static tcg_insn_unit encode_j(RISCVInsn opc, TCGReg rd, uint32_t imm)
 {
-    return opc | (rd & 0x1f) << 7 | encode_ujimm20(imm);
+    return opc | (rd & 0x1f) << 7 | encode_jimm20(imm);
 }
 
 
@@ -593,7 +593,7 @@ static void tcg_out_opc_upper(TCGContext *s, RISCVInsn opc,
 static void tcg_out_opc_jump(TCGContext *s, RISCVInsn opc,
                              TCGReg rd, uint32_t imm)
 {
-    tcg_out32(s, encode_uj(opc, rd, imm));
+    tcg_out32(s, encode_j(opc, rd, imm));
 }
 
 static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
@@ -629,7 +629,7 @@ static bool reloc_jimm20(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
 
     tcg_debug_assert((offset & 1) == 0);
     if (offset == sextreg(offset, 0, 20)) {
-        *src_rw |= encode_ujimm20(offset);
+        *src_rw |= encode_jimm20(offset);
         return true;
     }
 
@@ -1960,7 +1960,7 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
 
     /* Either directly branch, or fall through to indirect branch. */
     if (offset == sextreg(offset, 0, 20)) {
-        insn = encode_uj(OPC_JAL, TCG_REG_ZERO, offset);
+        insn = encode_j(OPC_JAL, TCG_REG_ZERO, offset);
     } else {
         insn = OPC_NOP;
     }
-- 
2.53.0


