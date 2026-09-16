Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC068C982C3
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:10:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pNu-00081F-Ba; Wed, 16 Sep 2026 09:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNV-0006sX-LO
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:46 -0400
Received: from mail-oo2-x0f.google.com ([2607:f8b0:4864:31::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNS-0001Uf-MN
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:45 -0400
Received: by mail-oo2-x0f.google.com with SMTP id
 006d021491bc7-6bd42f1c01cso655143eaf.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564121; x=1790168921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Bbpp4CXmX7S0YDcQDdhqpit66+4svnuOLfDQx+3XtIc=;
 b=PyKlANWM7f1V3pnO733DJZYdlb/wQkrGA3CwxW+88BbDm4WzuRJdj/kJs7Qjt1dGjN
 XwkCgbqowasUBM5kneqWdbLAABz1M/5Zr0OVjn18hfXuH4Dd6k+3tsIgL9a1hZYaC0t6
 xjdCneqGk205/LJWrCsDGbWJ4m7t3qLWwFhVBjqXu5U0oaH1FO3CWxUlDonZ3x+Mm37s
 38vWotnvZMuLH7rujv2BIdAFUnVqHWDFwETobOgCbhxa4DxaVVI/wajmLAJrnaVji/b7
 o6OMtolUH2cAFkGpQZlB8ONXV5KitgnrqZIuTv3aI0upUZn3+UDm1fKoK67z4MYjSG6N
 cNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564121; x=1790168921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Bbpp4CXmX7S0YDcQDdhqpit66+4svnuOLfDQx+3XtIc=;
 b=uc6SG2nTFyqNhaQp2Jzsr3AmkWF4Bi/kydRT2mtHKkxvR3r2IhdykgMUlv2BDNEJQZ
 Xk1fMNKAxm2bwQc3hELIf0J9/tRfvuxM+rZt1KJPpe/Mwk1eiWRE4I46r/eXvfK2Hp9A
 R0dmbKpjrsVE7+C0nk3gBlgelbO75J3Nll+UZ3LporkI778775GaNHVjm1hzmjiYzxpL
 FZEbxrT5wmbesehGC6BGz5hNmNgKWcFR1Yk8t6qkzOwHUzZ+fOX3HwcJciJdvj5baRrm
 vnhoaBFUdop+0tb/YMdXNevYHEhEb+Nt6yB7JZa0fNv128xAGQbTu3MQUupOyCVdPZT/
 D8KA==
X-Gm-Message-State: AFuF++lUWZqwHqleam5dg9E9Zs/N53WtEUstkE94RteBA4JVVVG+IvH3
 G1mpBS4d0Lb8f6ebks/14PizO/7HFxFiOuRL7ndRRCD9nO1X0PM3izxs6R8iaSVHQPzd6zPZDM3
 cU/+ZV/4=
X-Gm-Gg: AYBFou0PLR0VKsXqiJf0VNVHUpjLOg0RnL2IDlGRy28W0obtg2+ixUJuC0R1myxnd1C
 NK/jeRr7KI5ZrBvoc/035n1Mi0d/bZeN49WkA27FRrE0+zqdBaIh0aaNt6bmLqjyL8P16Iim8fY
 ViRqN/A2osxNqrKvCcVNF1KdKUxedIfZ4o1ymKSQE0sMiG/Z4GddHteipAHtnE9rUYPXu5UAb2V
 bNLp9JjpEO7f/E5aQqv5sysJSidC51Q3z/ukowps7QlGoYg1gAwhddQFE0LiBkGSp7QP49eVha1
 GhpxhpbbrWLqX0hr5MlJRjmc0omIevzHxFYOo4TsiIQ4r0Ke4R049csqejF9bai+6J0ohUPTICc
 EXKlLExQ28ZpwcFquiY0QsZm/YKZJlVvvN8QLZBwwo7vw5CxrstaOLsVnKTENDmmndRXeTdUcez
 8O4WfJX4iRxpaCdFceozoGsCs3Sgb3dD97ci6PU8xTCRzNHJ3ta1qV4OiHw4YgrfMya7Wlb4Rnc
 7xR/FI=
X-Received: by 2002:a05:6820:628:b0:6b1:a812:9871 with SMTP id
 006d021491bc7-6c7d1ad077dmr2728369eaf.18.1789564121271; 
 Wed, 16 Sep 2026 06:08:41 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 68/92] tcg: Generic expansion of tcg_gen_ext16s_*
Date: Wed, 16 Sep 2026 03:03:43 -1000
Message-ID: <20260916130409.3382710-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0f.google.com
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
index b666073df34..3c4074d860c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -704,6 +704,11 @@ static void gen_ext8u(TCGType type, TCGTemp *dst, TCGTemp *src)
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
@@ -1294,11 +1299,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
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
@@ -1590,11 +1590,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
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


