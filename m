Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B3CC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73p7-0005Vq-4H; Thu, 17 Sep 2026 00:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73ng-0001mQ-HD
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:46 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73ne-0007JW-DI
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:44 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc1cebad4adso270525a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619561; x=1790224361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VG5ZghFl8vheya4PpdzrDgRH0yHUaUc91O4goilo214=;
 b=skN7B830w974I6FwdS1tks0SA2NED/ogIfFBSG+WCNnRxT/Kz5liKm21tpMpP30fOn
 wdzjCu8Y2tckXUZEPTOrhNnueViS67S/I5vuZ2U4l7iZxA1YRQexZhUlaWV8pywp9lkg
 aeXpFRk2qoFEGytniewBBcs1sToEm/SFlVG3oIZfsU9YCVpAjfhFJdGA5sJo44qxncBh
 5uCv2+Jf2adCMlST+wTUNkqtAi5FXiVWW7atYcKiRRrWZkMXGjF21hMp35Kzx49uIp0o
 0gpF6BNt9jkoFnZzYLeH+9LPjunJdsxjR5RR7mAa+fErK9gdk20QSsL97tRbxqKxa/L+
 +KEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619561; x=1790224361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VG5ZghFl8vheya4PpdzrDgRH0yHUaUc91O4goilo214=;
 b=S5Xszcu7LXMnCpAvMPEzD9n8eqA9SBzddP9VQO6Brt5Fbx3nr2WfLJCinMy1gb0e8w
 +9DWqFOzlgs88FMVhcvOwqAMBOjCx831nQOngjUgz6HECm+II45wrf4EPgi/HPykuzvW
 6LBM/sSdR38VGp1XrSN/MGgIP6bbxxncRBJgibRvZPiSTyDZ7+uYXcHrY1Ip8PEbQuGT
 R8hwQPx104f3bfEan7UTxVlIcznugtc6JZcUWXYWw+WgmYI2CxEar7ltFx5t1xLkWZhv
 dgXbfmCK08R4KYJWNfjgsi92SQ/+atAE7km60IBrj8l4qUky1wcYA15pl9wqspKYLygc
 X2sg==
X-Gm-Message-State: AFuF++na4Y276+KBtko8JX8GAeo2tEuWYb5AqIjnyjOWwCDCczq0ucxL
 fcnl/8Kjf3akNqMszsycDQ8s0sKPfA1oHj9U0x4IGPBogxGUTynhahlEiO4OoILn4HAhoDLOktk
 ZJEXn
X-Gm-Gg: AYBFou3NhXG+C3/ED/+3uF6oH3EPYl2l3Ih8yCZRbSHJcyLCciBwKBa/c1a52DL8nFu
 jnJ95YWsBHmC+Th+NQQV1ht9pZ1D6VYO7nMfrvEX75NCnumPlVnclGOMwK35VJSDa/wQQUE1gyT
 nPOwYOEmp50jQTd5yp59br/x1Qi6stMGvyy+aDbpQDcEfMGlalJ4Zfe/TkN9naGLd0ttfZr6qde
 JuLVNyfU52aiiECDdBaZTo2JsMCb2bwpcGNY8ULiKLCzl6zcuKRVDVEo43JpZam8zK9k8lEq4FA
 Mh8TEgU3ub8mhCZkfnIAXUJm4rBpc8iddA2MysAJeJrldCWhqclP0+c9vwU/vH7oBnK1Ij4q0b4
 N5DRd62ZOOlAwhIdfox4v6V5/CjOxGcG7DQWl5q7R4IclTqGBONrHyOsbyyUDQlGNfs280hYkOG
 HMSVxQjUHIFku9qPzui4VMXvPvOaS5fUJ3sy0gQj/01mHjOKZapg0XMqwzs5rmSfAlC9/bpUMuf
 vuVkLo=
X-Received: by 2002:a17:90b:390f:b0:39e:1c4e:5473 with SMTP id
 98e67ed59e1d1-39e1e47ab6dmr14449077a91.16.1789619560892; 
 Wed, 16 Sep 2026 21:32:40 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 071/101] tcg: Generic expansion of tcg_gen_ext16s_*
Date: Wed, 16 Sep 2026 18:27:53 -1000
Message-ID: <20260917042823.542588-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index cabcd394ab5..8f4d1dd633c 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -143,7 +143,6 @@ void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
@@ -185,7 +184,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 80807eac2b4..cb8436e3b39 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -20,6 +20,7 @@ DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
 DEF2(ext8s, TCGV, TCGV)
 DEF2(ext8u, TCGV, TCGV)
+DEF2(ext16s, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c7fbe825ba3..15e0f697535 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -694,6 +694,11 @@ static void gen_ext8u(TCGType type, TCGTemp *dst, TCGTemp *src)
     gen_extract(type, dst, src, 0, 8);
 }
 
+static void gen_ext16s(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    gen_sextract(type, dst, src, 0, 16);
+}
+
 static void gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
                         unsigned int ofs, unsigned int len)
 {
@@ -1279,11 +1284,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
     tcg_temp_free_i64(t1);
 }
 
-void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    tcg_gen_sextract_i32(ret, arg, 0, 16);
-}
-
 void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     tcg_gen_extract_i32(ret, arg, 0, 16);
@@ -1575,11 +1575,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    tcg_gen_sextract_i64(ret, arg, 0, 16);
-}
-
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 32);
-- 
2.53.0


