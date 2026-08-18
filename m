Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98EE5C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCk-0007VJ-P0; Tue, 18 Aug 2026 13:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCj-0007Uc-38
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:25 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCh-0004ns-Jl
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:24 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-84faf87d19dso182097b3a.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072542; x=1787677342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qgcm7aG40Bg87FLfWPofELqORgbvpwPrs5KI4Oa9cDI=;
 b=ajVOXRO/iKjF5gijBpxMqSxZGOKr1npVbll7Bi7zlJJB2qwQL6URpjMWe1Z3EbOCYQ
 Kt5uMZwUwlJKSPb0VFTqafblkPdeL5OcaY/U+2Wlf5wX6ITEo099LSn8XekC4LIoarkY
 XTyLHNRnZ9WYmqwGHxCUz5SOJhU5VEIoXq/Cg/PLKDWuQPsHOjRn/MFOsKHOHXPuMSWW
 Om/3jDCX2lcw5yBvz7E74Bd7ad/Q6rMp3Qpku28rsv8z/nIkYrS6btRf0E6lT/5evhxh
 XjbzvnuYGggYstAhW6LL9lQYO6Wie0kIZmdAwOrNGnjhft6Iq9iJpTdK5G69UiFqZujd
 DnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072542; x=1787677342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Qgcm7aG40Bg87FLfWPofELqORgbvpwPrs5KI4Oa9cDI=;
 b=e2SXUCWKR3wCtjHzjm7AViSHGFTdayPL6dTO+37NdhiyopzQyte8ohQ0sfMX/6/W/7
 xtvfNnfjgZrG8Fasgz91ARQHRVcYSTUYljQlRk8yWyDUwbmZtIxIZsJvD9HKcCZK36lp
 e1ix+OPQUz0yPAFCNgkItuC+f9skyKMYvAPYwqOL10llRKcy9ngsypMoBktf5IXMBagd
 9QMqrvt346ZZA1f4agpPuHmIOCIVQjIMSs1+3smBxIpc9NX5aJspgeuYeCRytrEYjeoA
 9ORUBKgRo/9d8PIT/wt9O5pSFTiS8sJI7MNdJweywBExHcXjoBl2g+OD4Dbeagx8jqyL
 j+qg==
X-Gm-Message-State: AOJu0YxBmEhvGZCqY0BkkuwGq3mFNAb6c3zoykATmGPwdGbipxcYhxPC
 Q3W+rwypT+Zt+vxy7tlXcmb+h2Uo5CvtDjVzMUsvRcnQSvgPRHks3/xFvmRQ7bdcO3MJ8yhXZzR
 iD/vywMA=
X-Gm-Gg: AR+sD11UJWMJ7GNR5c1qcRerd6Ir3dhk8gMmRNvLa6QyHGQEZ3BwNe0BF9hIbmlMmDF
 8o5i3X5PVFG5m5E9nR0PB5FbRubS9NCUgD0k3lChvqC8Et+cWVMU1Ir1T+t9sWnJTS/YjG4xGt+
 kC05h+GTgPw3bYRWY3UWNao8a0y80HJRlw9JPhBVjycGRlAkZqvh/vCRnJTRonSTWrO2r8Bmc+Z
 qj4POC1dbaoqtv/hWEUSl+6o148LXwKQ/dL4toXDUdeZr7O33PnCwM4i/ygbQkJsWkwaliDJ/33
 cjymsK88DA3nmbdfRd0XMdvSx+GFDTv3VwuHabDN4dcTH1J53RELp9NFYWN3AB1Umr7j/sQpwe3
 mK8t77iTOZvFn1bZLYA5MUDAUnDuJREa2HUyuPjpDtdRT+vVRDSEa9Zyos1VKJiqTp4ecExwRCw
 Q2EzVk/YnBkeGv+NZsSn4CX1QmkvNLBpkDx82Dnmp2tv45/g5Bxw5fT+G9cbV55ffA5UUETym6z
 UQ1gtozumTrFrwkq99NOvE1YaqSdxbwZ4I=
X-Received: by 2002:a05:6a00:4408:b0:84a:29a7:f650 with SMTP id
 d2e1a72fcca58-84fdde01af6mr37184540b3a.0.1787072542008; 
 Tue, 18 Aug 2026 10:02:22 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 20/38] tcg/riscv64: Implement revbit8
Date: Tue, 18 Aug 2026 10:01:37 -0700
Message-ID: <20260818170155.1907006-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv64/tcg-target.c.inc | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 687146e0b0..8fd32644fe 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -246,6 +246,9 @@ typedef enum {
     OPC_XNOR   = 0x40004033,
     OPC_ZEXT_H = 0x0800403b,
 
+    /* Zbkb: Bit Manipulation for Cryptography */
+    OPC_BREV8  = 0x68705013,
+
     /* Zicond: integer conditional operations */
     OPC_CZERO_EQZ = 0x0e005033,
     OPC_CZERO_NEZ = 0x0e007033,
@@ -2469,8 +2472,20 @@ static const TCGOutOpUnary outop_bswap64 = {
     .out_rr = tgen_bswap64,
 };
 
+static TCGConstraintSetIndex cset_revbit8(TCGType type, unsigned flags)
+{
+    return cpuinfo & CPUINFO_ZBKB ? C_O1_I1(r, r) : C_NotImplemented;
+}
+
+static void tgen_revbit8(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_opc_imm(s, OPC_BREV8, a0, a1, 0);
+}
+
 static const TCGOutOpUnary outop_revbit8 = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_revbit8,
+    .out_rr = tgen_revbit8,
 };
 
 static const TCGOutOpBswap outop_revbit32 = {
-- 
2.43.0


