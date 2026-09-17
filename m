Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF7FC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x78Uo-00049H-9m; Thu, 17 Sep 2026 05:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x78Uh-00047S-1W
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:33:27 -0400
Received: from mail-oo2-x2b.google.com ([2607:f8b0:4864:31::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x78Ue-000197-Nf
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:33:26 -0400
Received: by mail-oo2-x2b.google.com with SMTP id
 006d021491bc7-6bd42f1c01cso381517eaf.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 02:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789637603; x=1790242403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CWDDX7cDV9cpP4O9iOGag2ibNMWKm0cooHImbOIJKEA=;
 b=jdHMPQ++W4DJCf/54F/OpBE2fb+uLtmzN/ZE30iutjfjLHdUvF5cN4ZhVmCyjk5zQC
 6nCoees2WpCUw+Oqo4x0Nd3l/RUAkWKkrMMG4GEI4vJ2u5q3CQ3NhSadpJOYq9f+kfmH
 lMYb1ccLMbSnRY08Z6NrPGJP4T0roWzZ9bXHWMQt79CagEDN9+ugM7QhBRUEy0BPZ/IL
 MeIgzFFbmpF6VkOZwIq5lcHSBaP27aFp6cB9gU34Mq26ZU/SukySjq+1jnd0LN30pg/n
 qbQi1miYhiBqS0GuvI4nvltssvix46XLfBRMWLTAyA0fCL7sTErfbHu6rghzWwb9qACv
 PMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789637603; x=1790242403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CWDDX7cDV9cpP4O9iOGag2ibNMWKm0cooHImbOIJKEA=;
 b=p/NVFO/mHnXacgYhbVAwOQYTSqp8D00q9c+CO5Vu2AbHheKV7rS4ogUUa8orvNsM6I
 66mJGDEB9jYfc6jAAmnEqTGe5atge0Jvfow8GcutZLzPRKCsTbO+m3U5hi1JuBJeDY8f
 eLgKVr/7mqvRoJAWyGlfcl82KtjJD0htrpkjjN6qhfCo+SHNcFwW3N953SawBcGRczKX
 n8txXSqdZFgYbcFVnpKjm0jZdm6LnVDQsUtbXE/7uEadJb6Jb1NQMRF/c1VM8MwuU9i9
 jzso63Ctn66XMXtHIu/9o7vzWhTc50asvX0xkXzgMF7M8BgwKzgyKv6yl7UCla3KqiVi
 hagg==
X-Gm-Message-State: AFuF++lZpbZU+69iP7V9S6RuGOUodKxwXqtFrE1lrffPB/Ir3BRHSaOD
 bCBaXI/kwEUTb/g/LkDpT13ezVodHy+ng9D2M0SNjFC+2PK2CqRhxTdUiJHUxdAJcPsSNvjrBrn
 a6ituYKc=
X-Gm-Gg: AYBFou0cGZuu/uNHR42uX904tcR3pF/waNJuO+CxoHdtJx5z2CWCQoo2O/xVEHnPmpH
 gHTQ5Bu5jxQi1VHh5Y93GnyRhhqsOGVXfd1qnYXhFqAAJlkn5g0OpyyjigaKFZpwB5ekdi1FWme
 rp2GCfnZZyzq5RqGzVE2W5tKI6OIdMFFQ0Zay+03tgRgkZYhgpMirCumRrDrm7LTCvJsnU5ceR/
 MwtIQU3YYJiHr9WQ33ydv4qsNzAHbyjLGvnsJyZDe8Om7M4rlNC2AM/qmrW+tvmqwqIEDhL7br9
 6EHKD7SFGY/ail4SyFWKOqHOcj541vzCfQnQc+abz9PR1ozD0k8mYKrjs6tGJH81+eSqnWSLzKD
 FLvcnpoW6DFUvNQrmB/Twbj4QO7wmlTZ6aOshUwWrUDK+0vGUxWwPEiBQy2aYNq4OdNkyn5idvE
 eypX2+A/cvBZOe82wng1X8wNDz75doHjKE6phy2Mcbe7h0QMuZonaO03EkmALhtHOn88go825g/
 qwBn9M=
X-Received: by 2002:a05:6820:3098:b0:6be:d716:524d with SMTP id
 006d021491bc7-6c7d52f65bcmr5623830eaf.64.1789637603356; 
 Thu, 17 Sep 2026 02:33:23 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm12494696c88.15.2026.09.17.02.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 02:33:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 12/13] tcg/aarch64: Implement INDEX_op_goto_jc
Date: Wed, 16 Sep 2026 23:33:06 -1000
Message-ID: <20260917093307.1092084-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917093307.1092084-1-richard.henderson@linaro.org>
References: <20260917093307.1092084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x2b.google.com
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

Use ldp to load multiple values at once.
Use ccmp to reduce the number of branhes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-con-set.h |  1 +
 tcg/aarch64/tcg-target.c.inc     | 58 +++++++++++++++++++++++++++++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/tcg/aarch64/tcg-target-con-set.h b/tcg/aarch64/tcg-target-con-set.h
index dd84a9af586..4b076962347 100644
--- a/tcg/aarch64/tcg-target-con-set.h
+++ b/tcg/aarch64/tcg-target-con-set.h
@@ -14,6 +14,7 @@ C_O0_I2(r, rC)
 C_O0_I2(rz, r)
 C_O0_I2(w, r)
 C_O0_I3(rz, rz, r)
+C_O0_I4(r, rz, rz, rz)
 C_O1_I1(r, r)
 C_O1_I1(w, r)
 C_O1_I1(w, w)
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index a0f23914224..2994a3f73e7 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -570,6 +570,9 @@ typedef enum {
     /* Logical shifted register instructions (with a shift).  */
     Iaddsub_realshift_AND_LSR  = Ilogic_shift_AND | (1 << 22),
 
+    /* Conditional compare register. */
+    Iccmp_reg_CCMP     = 0x7a400000,
+
     /* AdvSIMD copy */
     Isimd_copy_DUP     = 0x0e000400,
     Isimd_copy_INS     = 0x4e001c00,
@@ -712,6 +715,14 @@ static void tcg_out_insn_bcond_imm(TCGContext *s, AArch64Insn insn,
     tcg_out32(s, insn | tcg_cond_to_aarch64[c] | (imm19 & 0x7ffff) << 5);
 }
 
+static void tcg_out_insn_ccmp_reg(TCGContext *s, AArch64Insn insn,
+                                  TCGType ext, TCGCond c, TCGReg rn,
+                                  TCGReg rm, unsigned nzcv)
+{
+    tcg_out32(s, insn | ext << 31 | tcg_cond_to_aarch64[c] << 12
+              | rm << 16 | rn << 5 | nzcv);
+}
+
 static void tcg_out_insn_tbz(TCGContext *s, AArch64Insn insn,
                               TCGReg rt, int imm6, int imm14)
 {
@@ -2008,8 +2019,53 @@ static const TCGOutOpQemuLdSt2 outop_qemu_st2 = {
     .out = tgen_qemu_st2,
 };
 
+static void tgen_goto_jc(TCGContext *s, TCGReg ptr, TCGReg pc,
+                         TCGArg cs, bool const_cs,
+                         TCGArg fl, bool const_fl, TCGLabel *label)
+{
+    /* ptr is CPUJumpCache */
+
+    QEMU_BUILD_BUG_ON(offsetof(CPUJumpCache, array[0].pc) !=
+                      offsetof(CPUJumpCache, array[0].tb) + 8);
+    tcg_out_insn(s, ldstpair, LDP, ptr, TCG_REG_TMP0, ptr,
+                 offsetof(CPUJumpCache, array[0].tb), 1, 0);
+
+    /*
+     * z=cmp(ptr,0)
+     * if !z, z=cmp(pc,tmp), else z=0
+     * if !z, goto label
+     */
+    tgen_cmpi(s, TCG_TYPE_I64, TCG_COND_NE, ptr, 0);
+    tcg_out_insn(s, ccmp_reg, CCMP, TCG_TYPE_I64, TCG_COND_NE,
+                 pc, TCG_REG_TMP0, 0b0000);
+    tcg_out_reloc(s, s->code_ptr, R_AARCH64_CONDBR19, label, 0);
+    tcg_out_insn(s, bcond_imm, B_C, TCG_COND_NE, 0);
+
+    /* ptr is now TranslationBlock */
+
+    QEMU_BUILD_BUG_ON(offsetof(TranslationBlock, flags) !=
+                      offsetof(TranslationBlock, cs_base) + 8);
+    tcg_out_insn(s, ldstpair, LDP, TCG_REG_TMP0, TCG_REG_TMP1,
+                 ptr, offsetof(TranslationBlock, cs_base), 1, 0);
+    tcg_out_ld(s, TCG_TYPE_PTR, ptr, ptr, offsetof(TranslationBlock, tc.ptr));
+
+    /*
+     * z=cmp(cs,tmp0)
+     * if z, z=cmp(fl,tmp1), else z=0
+     * if !z, goto label
+     */
+    tgen_cmp(s, TCG_TYPE_I64, TCG_COND_EQ, cs, TCG_REG_TMP0);
+    tcg_out_insn(s, ccmp_reg, CCMP, TCG_TYPE_I64, TCG_COND_EQ,
+                 fl, TCG_REG_TMP1, 0x0000);
+    tcg_out_reloc(s, s->code_ptr, R_AARCH64_CONDBR19, label, 0);
+    tcg_out_insn(s, bcond_imm, B_C, TCG_COND_NE, 0);
+
+    tcg_out_goto_ptr(s, ptr);
+}
+
 static const TCGOutOpGotoJC outop_goto_jc = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O0_I4(r, rz, rz, rz),
+    .out = tgen_goto_jc,
 };
 
 static const tcg_insn_unit *tb_ret_addr;
-- 
2.53.0


