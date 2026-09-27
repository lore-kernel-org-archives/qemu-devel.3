Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA3AC9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAko0-0004mS-ST; Sun, 27 Sep 2026 05:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknm-0004R9-Ky
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:10 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknj-0007c9-PK
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:06 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc797656e69so444213a12.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499842; x=1791104642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PNROqxG93BF1L+uEgYWEYwmOpvcpcdpqK2kp4bG1IRQ=;
 b=x6/CgW38t6zRIUOrjyrCourFCjUe4N32i8XaGDsWA7/HqFADhYwpJL+oYrfjalbvI8
 tS1CJdugHZ174OWL773JK8v7WR3ibCdegh/FBXgjkAoLF/48OXXUWU9B6Zosuzu1zEE3
 6QCIcGDLmal+OeGdbS2clFg8gxMFztL0UC8v4mpJ2RZ1qDDkQ4uCBJP77JRrBMyuHzYI
 hJ+qzhUgLP3dPTDb3g8xGIFZHDKMTBKt5zESWv0RFV2crE1G1lSeF15TPe4Mno1ID9Ui
 q2biHCfHluazxiRHvnazMOO/Y9PIztqVnYrb4cZXN/vQqCBGQSMZwULsMeQugLjsUkEV
 Sh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499842; x=1791104642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PNROqxG93BF1L+uEgYWEYwmOpvcpcdpqK2kp4bG1IRQ=;
 b=eV7w8JqwiYdiweh820yCvRAoUvM+hRMUumRnKByG5/AqB0TRFMQ8h5GnuTt0KYYk45
 7w/u0jjBqL4QUPERgGG4LSoSXtNwk+nJ2HTMzCnroJISIbI5NiG9AiwKVlnXw0ATwU3m
 k3mjjYvw3MA/zDup4OEDey96nqZQh6+uSlVN9POs8zVNeDoupjuIyHf2ejcFDBRzPFtw
 pSed7xUXxOaGZFgfQgw1lRkBfYzLZq5O7Q0tEpnqslwU/PCUoL9bYZjTK7RRCBViEPgD
 Ppo8k7vW0FC2q87Lor2tqjtAuetBiBnfwa7WRBG0Zrq4IhpD2ZnwrCyp7vTFdKO9UvfZ
 Jxng==
X-Gm-Message-State: AFq9FYJsd6cCWLrVeMwaDq6NGTzCa7PU1lCaqp29K9ypc9Pq7bf3HEKk
 gq9wSLxKde+KrErss1z0AYCt+qeZ2cedjzlWH1/Hwvx98seh4qmxPQ6kpzzDn9CVtUa36muIagd
 x3zBS
X-Gm-Gg: AYBFou3WuQkdjBiVZ6D/DcXCnPhiiB861YSTxWSWMqHY4Jfx06AK/52A8JAw5XpKs17
 tlck2Jv/9epE7DmCv2S//u5U3lz0Yn3/+3PDINqtWiX00dK8wVsXTwNAgyXPNaKqfNoW9gUEoWJ
 9pxfmAg5VWkrI/FX6E+2rxYqEAaKZL8JCkZdtUdl6Ko+lIZSt4Rqvp9RCEnDbBQ6aXh/YlNTJag
 F1pzxpdjOmzlux3lnIBnj+xeYEJtSHp+GAvfFkq8okxZuGyaIPHSWcHXMjaU0elW9vT5YLNzjAp
 4uehXKWw1ohiGCSGfDyV6WacSirpCfPmtRKGOIF/98IpbMOKtvIdJSKWErHnsFqzigH94fFDhB2
 y3ya804bT/5ecyNX9iPErGNT1q1H9tMdfutqH7NTBysFSjvSgGzbwbqaOmcCN7p1xVjyNFlHe5P
 bOZknLjEhdyYO/0qH/NUJI+DDtB/hv86/1WuIwWQZIaKxonlJJ1kGP4SLKY2iypA8vNklHf8+2V
 906AIDwZkSn32fX5OQmBk95BRRlvA==
X-Received: by 2002:a17:90b:4a05:b0:3a0:bb4d:77ff with SMTP id
 98e67ed59e1d1-3a0bb4d7a39mr6005332a91.0.1790499841871; 
 Sun, 27 Sep 2026 02:04:01 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 047/101] tcg: Generic expansion of tcg_gen_negsetcond_*
Date: Sun, 27 Sep 2026 01:59:17 -0700
Message-ID: <20260927090011.10724-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
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
 include/tcg/tcg-op-common.h  |  4 ----
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 36 ++++++++++++------------------------
 3 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 54c2528b3aa..e752dc977f8 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,8 +146,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
-                            TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
                              TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
@@ -213,8 +211,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
-                            TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
                              TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 92a35e83f81..1ab2c69cbe1 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -18,6 +18,7 @@ DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
 DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
+DEF4(negsetcond, TCGCond, TCGV, TCGV, TCGV)
 DEF3(nor, TCGV, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 069926ce3cb..82917d148a3 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -519,6 +519,18 @@ void tcg_gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
     tcg_gen_op_tt(INDEX_op_neg, type, dst, src);
 }
 
+void tcg_gen_negsetcond(TCGType type, TCGCond cond, TCGTemp *dst,
+                        TCGTemp *src1, TCGTemp *src2)
+{
+    if (cond == TCG_COND_ALWAYS) {
+        tcg_gen_movi(type, dst, -1);
+    } else if (cond == TCG_COND_NEVER) {
+        tcg_gen_movi(type, dst, 0);
+    } else {
+        tcg_gen_op_ttti(INDEX_op_negsetcond, type, dst, src1, src2, cond);
+    }
+}
+
 void tcg_gen_nor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_nor, type, 0)) {
@@ -709,18 +721,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
-                            TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_movi_i32(ret, -1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_movi_i32(ret, 0);
-    } else {
-        tcg_gen_op4i_i32(INDEX_op_negsetcond, ret, arg1, arg2, cond);
-    }
-}
-
 void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
                              TCGv_i32 arg1, int32_t arg2)
 {
@@ -1487,18 +1487,6 @@ void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
     tcg_gen_negsetcond_i64(cond, ret, arg1, tcg_constant_i64(arg2));
 }
 
-void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
-                            TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_movi_i64(ret, -1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_movi_i64(ret, 0);
-    } else {
-        tcg_gen_op4i_i64(INDEX_op_negsetcond, ret, arg1, arg2, cond);
-    }
-}
-
 void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 8);
-- 
2.53.0


