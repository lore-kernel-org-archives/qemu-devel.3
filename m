Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609EFC88E5C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 00:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5uFQ-00033w-Cq; Sun, 13 Sep 2026 20:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5uFK-00031n-QO
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 20:08:31 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5uFJ-0006sw-11
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 20:08:30 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38dfe7eb825so2369981a91.0
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 17:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789344507; x=1789949307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7rzauUj35o1eVBCcwJF0HTD6HkIw7xx+rAbULRW0WPg=;
 b=JE7eT9xEn+56IyEV8YYX16iM3jmwvH4QOwGnwDZYUUhTbslEfzHa4LeLB0mSVKqb08
 r++8n95S12ZZpshvW0wrzC++ZPuH8cWjYV17eV5L8ZbqQyJh2KETBtf4HKlUw+zeHKwG
 tieNABVIak+7cmp7dW69oxuShDzflsexskaXY5DgcafZFYbX3j1vFJIYhNnFD7e//XV9
 5rLqtKsQdP3c3raKdDnCOwtRk1RmjivyacbVEArNqo44DnxAJpIYBM73GjV6LTi/kDRE
 Jme4FGOZiZxFXRMI2xNvnZr3P/N+mr0YeNBISG4N50GBF3Th+cuugqT2byeD+9tGAfwm
 mQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789344507; x=1789949307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7rzauUj35o1eVBCcwJF0HTD6HkIw7xx+rAbULRW0WPg=;
 b=nkq3bcEkrY7ayxNP8MsJFcgYe2mR+yvSSVvAE/9s6ZgE9DrZdyWHKt1x6+tkzMRVR2
 WG/try5BeZJgOzgpCvRZyHvBKgioBmnn4JFxdkn0VrzRJADmQ6/jqnPsKCt6pDJTyg1F
 e8phZ4B9VCp9Olz/SpcroxOSeCjrQgTcxiH+2V22088nGYqcTHSETYvcR6xPHN9PkX0s
 px+om0oBJufO7RWUMCZrZY0PCZhfBoJ78ubg8+7HXRyI5lO1xkecw2vyVuUMSY4WtkoC
 rsogm8Ki2VeXsZdWgScxJhWLPP018fBnNCDOlarYzH9gtnDuusdi7hWBRyc9jGcG0BZe
 V+ZA==
X-Gm-Message-State: AFuF++kjp4cRHCe8iuTrUBxVZ2a6XNXcFHWaa0QNJoYyArYznO9BMkDd
 cMcGrVgjiQJUOJYMdvaRdt8BqRkQZ0Q1EeIzUn0C/POlNXfFgYD1x459SXeKF29NJSrMUq7jvHC
 6mMdJthQ=
X-Gm-Gg: AYBFou1l1VioUphuPdVEouk73o1/Ol6MOZkBHfi2PP6fR3g7fUGJgmU4AFIqNWtXoq0
 eQEG8bpFTTb9zVJC/GlV/+q8NpYNT0Ph4iptXk4VulmmID6zG+6kiumINyJS2AJbWlwUb+nrhS/
 TZeoEs7ZSo2rP278YDZWDFs5ZHH7eiIW2NQJybejFPgi1mnbPAlwLIiDjzYBGxEShlFrV7erT0A
 /hK9nJ+jFb1oF/5dqjZXvhnSxCnbdiaStDuqmzWypWDaDB3DZMRUlzYWegXxdXCeoXej6+hf+9t
 a9mOIL02bKOVytqX06R9oxSslvVLWMmctqgkyOExlDDIbbrJz7MCJVEA6SgZ75huoIG99Qm0Ehv
 PW4SL/fEHu+0AJdsFZ+DlUL6uy3EFB4dX9ij7RymHweXMCWfFVt6lmVa/kT1+aPaRklO4SzMMMq
 +rIlv8EHI3qfUlW8NTSsMdU+9MXRV53S+EqpUvHXnlVDEa2LsGNZuMn+elPRS7iNPsIiwxkzRT/
 JCOsn0=
X-Received: by 2002:a17:90a:dfc8:b0:396:b98b:a3c2 with SMTP id
 98e67ed59e1d1-39debfa3e51mr575644a91.8.1789344507227; 
 Sun, 13 Sep 2026 17:08:27 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:1665:91c0:9a80:f870])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14382741839sm4937677c88.6.2026.09.13.17.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 17:08:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: max.chou@sifive.com, palmer@dabbelt.com, daniel.barboza@oss.qualcomm.com,
 Alistair.Francis@wdc.com, philmd@oss.qualcomm.com
Subject: [PATCH v3 07/11] tcg/riscv64: Return success from encode_jimm
Date: Sun, 13 Sep 2026 14:08:10 -1000
Message-ID: <20260914000814.785155-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914000814.785155-1-richard.henderson@linaro.org>
References: <20260914000814.785155-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Centralize the range test for this encoding.
Directly OR into the insn value.
Assert success in encode_j.
Use encode_jimm in tcg_out_call_int.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv64/tcg-target.c.inc | 46 ++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index a5ed1e95722..09bfce79bb7 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -511,24 +511,26 @@ static tcg_insn_unit encode_u(RISCVInsn opc, TCGReg rd, tcg_target_long imm)
 
 /* Type-J */
 
-static tcg_insn_unit encode_jimm20(tcg_target_long imm)
+static bool encode_jimm20(tcg_insn_unit *insn, tcg_target_long imm)
 {
-    tcg_insn_unit ret = 0;
-
-    ret |= (imm & 0x0007fe) << (21 - 1);
-    ret |= (imm & 0x000800) << (20 - 11);
-    ret |= (imm & 0x0ff000) << (12 - 12);
-    ret |= (imm & 0x100000) << (31 - 20);
-
-    return ret;
+    if ((imm & 1) == 0 && imm == sextract32(imm, 0, 20)) {
+        *insn |= ((imm & 0x0007fe) << (21 - 1)
+                  | (imm & 0x000800) << (20 - 11)
+                  | (imm & 0x0ff000) << (12 - 12)
+                  | (imm & 0x100000) << (31 - 20));
+        return true;
+    }
+    return false;
 }
 
 static tcg_insn_unit encode_j(RISCVInsn opc, TCGReg rd, tcg_target_long imm)
 {
-    return opc | (rd & 0x1f) << 7 | encode_jimm20(imm);
+    tcg_insn_unit insn = opc | (rd & 0x1f) << 7;
+    bool ok = encode_jimm20(&insn, imm);
+    tcg_debug_assert(ok);
+    return insn;
 }
 
-
 /* Type-OPIVI */
 
 static tcg_insn_unit encode_vi(RISCVInsn opc, TCGReg rd, int32_t imm,
@@ -638,12 +640,7 @@ static bool reloc_jimm20(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
     intptr_t offset = (intptr_t)target - (intptr_t)src_rx;
 
     tcg_debug_assert((offset & 1) == 0);
-    if (offset == sextreg(offset, 0, 20)) {
-        *src_rw |= encode_jimm20(offset);
-        return true;
-    }
-
-    return false;
+    return encode_jimm20(src_rw, offset);
 }
 
 static bool reloc_call(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
@@ -1577,14 +1574,15 @@ static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *arg, bool tail)
 {
     TCGReg link = tail ? TCG_REG_ZERO : TCG_REG_RA;
     ptrdiff_t offset = tcg_pcrel_diff(s, arg);
+    tcg_insn_unit insn = encode_j(OPC_JAL, link, 0);
     int ret;
 
     init_setting_vtype(s);
 
     tcg_debug_assert((offset & 1) == 0);
-    if (offset == sextreg(offset, 0, 20)) {
-        /* short jump: -2097150 to 2097152 */
-        tcg_out_opc_jump(s, OPC_JAL, link, offset);
+    if (encode_jimm20(&insn, offset)) {
+        /* short jump */
+        tcg_out32(s, insn);
     } else if (offset == (int32_t)offset) {
         /* long jump: -2147483646 to 2147483648 */
         tcg_out_opc_upper(s, OPC_AUIPC, TCG_REG_TMP0, 0);
@@ -1961,15 +1959,13 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
 {
     uintptr_t addr = tb->jmp_target_addr[n];
     ptrdiff_t offset = addr - jmp_rx;
-    tcg_insn_unit insn;
+    tcg_insn_unit insn = OPC_JAL; /* rd = TCG_REG_ZERO */
 
     /* Either directly branch, or fall through to indirect branch. */
-    if (offset == sextreg(offset, 0, 20)) {
-        insn = encode_j(OPC_JAL, TCG_REG_ZERO, offset);
-    } else {
+    if (!encode_jimm20(&insn, offset)) {
         insn = OPC_NOP;
     }
-    qatomic_set((uint32_t *)jmp_rw, insn);
+    qatomic_set((tcg_insn_unit *)jmp_rw, insn);
     flush_idcache_range(jmp_rx, jmp_rw, 4);
 }
 
-- 
2.53.0


