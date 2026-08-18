Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 489EDC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCr-0007hD-VK; Tue, 18 Aug 2026 13:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCq-0007g4-FS
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:32 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCo-0004qu-TO
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:32 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-8486ac3f347so1288895b3a.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072549; x=1787677349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GCy4QywX3WT2024WmusdDJbMQjYEZ61hPhsxtxgDYdg=;
 b=avgGK4st5etDnQOszvIO3GiBn9M0US/EqEZHn9Tq+ypdubhqwhW+wFZKaBhKYkjIaZ
 oDBQ6FWCa4Jl6aCzaqzRJPdDTSngMwGpSvl++avsIdeF+KtHUQ5jtvh/Ttn69WxYo6uy
 cx7tIzGBNu93HGxSQIjNhvz8U7mDSIo6Y8q+BwW9YJCln+lzpKUrG9G9k+XVIqVrnAKx
 4jF06TP8o52QnHvwp0F3ZLf069dRx1j7GayE31gEONvvZKqFoo+92tqRHB2Y7YTq5MlN
 EmaAHaViOHSQvH8kn65CKkMvmeKuBRIELHnaTh5MRQNwbzpxsCgG1pceJ6sn8iWdAjmS
 Y3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072549; x=1787677349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GCy4QywX3WT2024WmusdDJbMQjYEZ61hPhsxtxgDYdg=;
 b=QYg0DuDpXrkcJL8YFkQxd1Zf/3/dpXnZiIJ4IIEFpMz7EewEZHBNqsUxgKuhzm/A92
 UPA6lhC8SUH8nnh0VWB+Cz9N7mjwCxOOkXaTwCEF4B9qdAeewS8Jya6nG8BAI9uo1HJk
 wIWqlHJ1/kvgFzFYrjtQgzOu8mk3nLt8MbO/WhaReIr04onUfqb/RHMCSnT7w7A1p5Uo
 In+nx5isq7ADFpBDKB3jdMAU/jG+pvR+WAuTeytAERKkGMFSYUYOrpcTAUazBK41phQf
 //yQFFtLgMDmEHLKXcg+jGeSqNBaRvFcuMzJtHE4amfkkJrP+ms12LZN2LUDAEKJzvRI
 olrQ==
X-Gm-Message-State: AOJu0Yw90SVzkg8GQKyMsMB6qoqPpNrdTOac2Tbn3XruWdF3/aJ8eh7Z
 JWnQzLOdVuYi8LvvZzwIjdSTbi/vSzfT7yJ9TSHmLpQTWEIDDejAQGgto4Qc0k88oYqh878Aobq
 rCEMdlJw=
X-Gm-Gg: AR+sD10ROteiOhdsSCSNIRuN3R8f5HRAWqOj/cx4u5mb2XX1NQL/V4THA5+VYGtHgIU
 6I3f3L11XQm8zi+r8gyoocPZ5spYlgpGGcvABKwRIzrXhWKPlK8VCpZ/3aP4izQpAty+B5xorqU
 vf/cVc0I+ec1M2cgw3FgdJKfe8qfo6zAnOf2GJbx5iNY0oUsyYYB+yjEDieqRp4C+rDYkelACbK
 Jfn6Izw/MUGfZr/3V+VSOfbiydC6jSBECfbfpqHOX2A1lOdMPrc8TLg/ih4u35xeoBmBvAWnHAd
 QdvP0a005uM1vTcfySNlDvVfQq3gIb61vG39Txmv9RpjZYD2+tFVrBIYl3Vj/GAbV7m2aWgWS5r
 eB53rg/otq9EkyE/nAQKKqltFO91v88QUQqHGnezQNFZU4zEtGyZWa2JZYg3suS+2/lvLMtK6n1
 3ELrYsJelIRqXnz9UyrkavEBhVBmNLB9PPSlzkXTIwivfHS1MxdUcOeXed1pnL998hhEdYi97ml
 E4Zi6j90FnFro87FqjLRj/tBpyqpwmxwWF8PdFhbl1wvA==
X-Received: by 2002:a05:6a00:f06:b0:84e:354:422b with SMTP id
 d2e1a72fcca58-851be59873amr6882038b3a.2.1787072549528; 
 Tue, 18 Aug 2026 10:02:29 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/38] target/riscv64: Implement min/max with Zbb
Date: Tue, 18 Aug 2026 10:01:44 -0700
Message-ID: <20260818170155.1907006-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
 tcg/riscv64/tcg-target.c.inc | 44 ++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 723c21b3da..2ce9d47a63 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -233,6 +233,10 @@ typedef enum {
     OPC_CPOPW  = 0x6020101b,
     OPC_CTZ    = 0x60101013,
     OPC_CTZW   = 0x6010101b,
+    OPC_MAX    = 0x0a006033,
+    OPC_MAXU   = 0x0a007033,
+    OPC_MIN    = 0x0a004033,
+    OPC_MINU   = 0x0a005033,
     OPC_ORN    = 0x40006033,
     OPC_REV8   = 0x6b805013,
     OPC_ROL    = 0x60001033,
@@ -2404,20 +2408,52 @@ static void tcg_out_set_borrow(TCGContext *s)
     g_assert_not_reached();
 }
 
+static void tgen_smax(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_reg(s, OPC_MAX, a0, a1, a2);
+}
+
 static const TCGOutOpBinary outop_smax = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_zbb_rrr,
+    .out_rrr = tgen_smax,
 };
 
+static void tgen_smin(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_reg(s, OPC_MIN, a0, a1, a2);
+}
+
 static const TCGOutOpBinary outop_smin = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_zbb_rrr,
+    .out_rrr = tgen_smin,
 };
 
+static void tgen_umax(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_reg(s, OPC_MAXU, a0, a1, a2);
+}
+
 static const TCGOutOpBinary outop_umax = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_zbb_rrr,
+    .out_rrr = tgen_umax,
 };
 
+static void tgen_umin(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_opc_reg(s, OPC_MINU, a0, a1, a2);
+}
+
 static const TCGOutOpBinary outop_umin = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_zbb_rrr,
+    .out_rrr = tgen_umin,
 };
 
 static void tgen_xor(TCGContext *s, TCGType type,
-- 
2.43.0


