Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D172C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAksO-0007fK-Rm; Sun, 27 Sep 2026 05:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkra-0002RL-51
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:08:02 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrY-0008IF-Ad
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:08:01 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-39b31b4281eso1540709a91.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790500079; x=1791104879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7g3P+ptvTSg0B9ssOZlWVCFqJ5n4D8uhlvWfKkbNayY=;
 b=Aupxzmn0/6OdH4DifDbRdwpcpFba2Ey+AnGZwdHEbI/t/2MRBAc4iG4SNBvGVMWDe8
 1IlddTUiPhuuGUfT9qC9sIyElmZQTOBa9hfFHGy/0MBUSMBfJx/nXBVLIeivNB/TIRI5
 XGY70OPNrzXodjBWCmXa80JZZME6XnWfW397AiqW4RqN7KjjSsGcM/0iq6SKayrkuGAZ
 FkyREMmQ6MotM8w2xBq0greCgKpojujjwEV9IhNQq/ey5xjji6hQVjMnL7O6fUwCXoLG
 iBruVoziqUjQAW9lTycIOZbatTSt16dacXfHn2rKeMS3a6jpGkCt3URlH81a55OUZege
 SseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790500079; x=1791104879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7g3P+ptvTSg0B9ssOZlWVCFqJ5n4D8uhlvWfKkbNayY=;
 b=pkj6eHNysIILPkErjI61zq+6z7h4ZNLQExLpDSAYp5HSLmCnu705eMWmhKNkts4vjP
 PzekPHYyVmQr4a3dtTlzfsM1j15+8+wC8QWYeZrBd0HqnZMaeMvNgSKkJBxSpbPSFct5
 w83w3KbUAg3FO41lFCz3A7zgCABLqHyk2i05B2LeWRzzZtrGxnBlldtQNi7GjsIjTYRd
 21T5IJiD/mbjcdQM+dz9RANkJHQJCw+37Ei31D1VkBN3PwUSclNOPi+W0jiT3URRipEX
 3/CHBYpR/0ddY9ZemyfkGSyK6gZUZycBbbc5NR9iKwEkaPISc3JyTAUlknLFpSJVoBUO
 qDCg==
X-Gm-Message-State: AFq9FYLp1kz1Eo+eAMvWksm5snLucQFKtGjcomWJRI+DIjk4TOyeGhco
 fRKcttIk+ImQsN4ioLQiFdcW0KifMRSPdUdoF0F0idXHTWDH6HaVNEIiWBPbnuIEFaLj1qu8C2D
 ih9cb
X-Gm-Gg: AYBFou1oTx1eFB77KVm9u7PGie8UsIAlzBTsL49Cf5zuSEfYZ2qNfW2Z4gjuzDDY+g9
 ZN2Bpo/6JdDvjLa/Wq6dlf+sZ6DPqeG+5jJsgjazI7u9FqE/F2xbFrOc5mdGFZZNzH451oLNMEA
 ed7/mbpfSRFLkVb61bq7aFsJSY6cUGSoFpEBce8/FmG/ErVBN7Bff7r7cdYBQQEPsfu7d1iwT4G
 PqztVh8Tsyy8hHEn39GMTkTE90UIPmHO3xpr6DEOsa3J02bpZf4gAVKA126XYl7DIZmGM9mcpkB
 3ADN+ARvK3T1BbE0pcjuBXhiD/cpnquTnPn2O4ez7pgpchR0V0WjzgWIyPg2XLmAhQTa1aQGwWb
 QrlOTEyAajUK5QlPuyPh32Def8ceCnlRXHqrqhBVqWoVNkcEcaeCwe2h7ihP5Y6oG9HwEoCKA+P
 MUb0ZcndcEYsi42tO2zl2sGi3XG35MngdQ+odxERbGi2BQR+3qEAQaoCBlPEdR5nSAy0E+R8G0Y
 V7357EBJEQPCIttBkBSbqQjLz9qyw==
X-Received: by 2002:a17:90b:1dcb:b0:3a0:e786:84bf with SMTP id
 98e67ed59e1d1-3a0e78686a5mr2679133a91.60.1790500078801; 
 Sun, 27 Sep 2026 02:07:58 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e7036e3bsm7144984a91.13.2026.09.27.02.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:07:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 095/101] tcg: Generic expansion of tcg_gen_st16_*
Date: Sun, 27 Sep 2026 02:00:05 -0700
Message-ID: <20260927090011.10724-96-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0f.google.com
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
 include/tcg/tcg-op-common.h  |  3 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 23 ++++++-----------------
 3 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index b04a9a76e00..65b9d828e38 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -140,8 +140,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
-void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
-
 /* 64 bit ops */
 
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
@@ -158,7 +156,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in);
 
-void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 90bcf9e5ab8..f9dab50a911 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -72,6 +72,7 @@ DEF3(smax, TCGV, TCGV, TCGV)
 DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(st, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(st8, TCGV, TCGv_ptr, tcg_target_long)
+DEF3(st16, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF6(sub2, TCGV, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 257ce2c3e6d..2e8087c938c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -143,13 +143,6 @@ static void DNI tcg_gen_op3i_i64(TCGOpcode opc, TCGv_i64 a1,
     tcg_gen_op3(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3);
 }
 
-static void DNI tcg_gen_ldst_op_i32(TCGOpcode opc, TCGv_i32 val,
-                                    TCGv_ptr base, TCGArg offset)
-{
-    tcg_gen_op3(opc, TCG_TYPE_I32, tcgv_i32_arg(val),
-                tcgv_ptr_arg(base), offset);
-}
-
 static void DNI tcg_gen_ldst_op_i64(TCGOpcode opc, TCGv_i64 val,
                                     TCGv_ptr base, TCGArg offset)
 {
@@ -1264,6 +1257,12 @@ void tcg_gen_st8(TCGType type, TCGTemp *dst, TCGTemp *base, tcg_target_long ofs)
     tcg_gen_op_tti(INDEX_op_st8, type, dst, base, ofs);
 }
 
+void tcg_gen_st16(TCGType type, TCGTemp *dst,
+                  TCGTemp *base, tcg_target_long ofs)
+{
+    tcg_gen_op_tti(INDEX_op_st16, type, dst, base, ofs);
+}
+
 void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -1415,11 +1414,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_st16, arg1, arg2, offset);
-}
-
 /* 64-bit ops */
 
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
@@ -1432,11 +1426,6 @@ void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_ld32s, ret, arg2, offset);
 }
 
-void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_st16, arg1, arg2, offset);
-}
-
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_st32, arg1, arg2, offset);
-- 
2.53.0


