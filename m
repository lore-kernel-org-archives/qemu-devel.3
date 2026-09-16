Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC125C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pOH-0008Vz-41; Wed, 16 Sep 2026 09:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNb-0007Ad-I9
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:51 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNZ-0001XQ-LE
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:51 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2dd68a16955so22364415ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564128; x=1790168928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2q5sf2s1P3PkxCTzT6w2tCdJ+EbExa0K90Doyvg6ZLk=;
 b=gxSNAZK0phze3bnl+qQ0vA9Bgxz0ONJ6nZn3UCdUUKA8WiVY1maaIc2FLq+YovtfQg
 8dpAQ/GYaF9Tg9RD2KBSn36y9W2mI7ZULe2t7JRlkZ/hIbTFYdiOjBLXTnBqVGkaQJxO
 FP1/hfBrMXB+7pjTbtagYRYg5dbfNSEyoVEXYYxto/tqsRUoKiAByherExgofy1bT8Vq
 tjOestOqqjz/1oSyH7iJ+vyiOLKkX/oDpWMUseNh6NjJ5lx/dnZnO7OEdi/79SP/mA9U
 OBQN9i3PRMm3IXLbRU6IVrhFXpifs0ndsrGDnw1Yt9y3MfUqQ3v1+CB1iFwIn8oAPnZQ
 mHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564128; x=1790168928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2q5sf2s1P3PkxCTzT6w2tCdJ+EbExa0K90Doyvg6ZLk=;
 b=opg8aq4OFKkfkuFkDZ0Eh+BazD+GFuHrfRsr0XdFpQrbnsoaWHwjDIyMGzUTrezfwI
 J4EkEgtPIsSgMtpgTs6VD5IwzuVhNbTn2HaAvdKiM7kVseZ7Dxi6CsxbF/fmD2eoGLsk
 YskGJZ8HQizWmqlVri2kCYwv3n53qYagTbwrvdx/jZCI3HjvOf8tlJOwSOI2pZ1WFhFw
 Drnaos6aITnhF7d/qnKljHrJufLtqqkVwAkzlbCOhvWjsWRB+IoqHbs2Yya7gvZ8Rz2O
 rdcqSoeMcmG14nEWdyp4bNo9hFZJlszQ1zZXsb2jZvAhEiVTS1dEOEy1z67yRbeafNAw
 w14Q==
X-Gm-Message-State: AFuF++mt1A3yohfciYi7CzLvBtkyiZjm2Z5dOXa2v+GCUxAO/g4zA13/
 iywYEtOxTNeClCSS8eHHwXmvuZNUQCDfw7qadBCpALH1yfKbDG/B8XAa2W3PJNoeFdOlSQQqtZE
 dMCigM2c=
X-Gm-Gg: AYBFou28xHUi2dGs3Dqo4JEaPhBlM6qcd2NPeKCC/ZtQGhNZ+r4fSXcYuiWZL2yNpOR
 VS3xDq7aPzGWBic3UV5vCxDoWg1REL18JSts6wThJiL1yyYlPhoMzaDGArjV01K3+O0s3S+oB/0
 aLpEWqAa/2dUkbfpYwc7WlBN0MjdNrkQcsq2R7qnT0SMVU+ZbOxkBAT7buXY8cAOeRIdmTjs+Sq
 j8toYuqjfphjTh8XgM1xhCw6TjCHp9N/cEZsn4RSr05JtYGRVKH0rl1P/0fwZ6sNMET4AjrNDqF
 GJ/52bKlnGtLTkwNAwHOGjlDfSeq35uU9KNphAHr5QntS6G3RjQVnk+soQ2+vk1D/Ewlf19n2vX
 949HmMbSwsh9g2bEjMvAtJayNhTDFd/xSZ5hsIIlIv/byGrok60DwAkWhuyAkzGFw3qA15ePN5Z
 ipHYm7G3Mlm7J+xgbv0g31DNvAtPG89GB+YSXdG1IWA1irM7qXGrJ3igXEWUMkZcOUwcTimcQjH
 AaZ7Kk=
X-Received: by 2002:a17:90b:3848:b0:39d:e78d:32d2 with SMTP id
 98e67ed59e1d1-39dfe06cc54mr12058917a91.13.1789564127962; 
 Wed, 16 Sep 2026 06:08:47 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 75/92] tcg: Generic expansion of tcg_gen_abs_*
Date: Wed, 16 Sep 2026 03:03:50 -1000
Message-ID: <20260916130409.3382710-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 31 +++++++++++--------------------
 3 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 79a3e82c98f..b64b54fcdee 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -147,7 +147,6 @@ void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 
@@ -186,7 +185,6 @@ void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
 void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 1405dff32aa..69df7967c76 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: MIT */
 
+DEF2(abs, TCGV, TCGV)
 DEF3(add, TCGV, TCGV, TCGV)
 DEF3(addi, TCGV, TCGV, TINT)
 DEF3(and, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index d8b205812f3..0993d100f00 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -415,6 +415,17 @@ static void gen_extu_i32_i64(TCGTemp *dst, TCGTemp *src);
  * are of the proper type.
  */
 
+static void gen_abs(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
+    int width = tcg_type_size(type) * 8;
+
+    gen_sari(type, tmp, src, width - 1);
+    gen_xor(type, dst, src, tmp);
+    gen_sub(type, dst, dst, tmp);
+    tcg_temp_free_internal(tmp);
+}
+
 static void gen_add(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_add, type, dst, src1, src2);
@@ -1495,16 +1506,6 @@ void tcg_gen_ussub_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
     tcg_temp_free_i32(t);
 }
 
-void tcg_gen_abs_i32(TCGv_i32 ret, TCGv_i32 a)
-{
-    TCGv_i32 t = tcg_temp_ebb_new_i32();
-
-    tcg_gen_sari_i32(t, a, 31);
-    tcg_gen_xor_i32(ret, a, t);
-    tcg_gen_sub_i32(ret, ret, t);
-    tcg_temp_free_i32(t);
-}
-
 void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_ld8u, ret, arg2, offset);
@@ -1999,16 +2000,6 @@ void tcg_gen_ussub_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
     tcg_temp_free_i64(t);
 }
 
-void tcg_gen_abs_i64(TCGv_i64 ret, TCGv_i64 a)
-{
-    TCGv_i64 t = tcg_temp_ebb_new_i64();
-
-    tcg_gen_sari_i64(t, a, 63);
-    tcg_gen_xor_i64(ret, a, t);
-    tcg_gen_sub_i64(ret, ret, t);
-    tcg_temp_free_i64(t);
-}
-
 /* Size changing operations.  */
 
 void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
-- 
2.53.0


