Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CD4C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnmU-0005Yb-AB; Sun, 16 Feb 2025 18:10:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmL-0005V6-9s
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:25 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmI-0005Cz-IK
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:25 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2fa8ac56891so5355276a91.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747421; x=1740352221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3efgV/pEu80aXE8j5/SUl3haOtWo5u+W7F4cNHVCaw=;
 b=MVPp10NQ6h9DXxeAYQpEwMEs9CFbO2dlz+ywoUX2nlm7FvXAav3eiJN9cHuuB837Em
 4qJNLA6RgCCKEn/PtBWxricWVq4fJhYg/dMMvtygOGc52HMewUn8cAD90ObTrRPjQLf7
 Uvvj9YreEl1sNrnD00Pn/yillOe2leXusnRKL5E0fc57DarwPc1isDyDceBf9HpvojQf
 asWP3ez6G3Yz06ugfGHPkOOJ3mXN92xn6qR+9rc74154PDR2JIzGMFH0+srkBmY8lcTt
 8Z7SgT1CcTvRBKQGmuEU+vJatRT2FSg5d30rIZWa+M4Z03WGBoROFmvES4fUaxTe7HIl
 7o9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747421; x=1740352221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e3efgV/pEu80aXE8j5/SUl3haOtWo5u+W7F4cNHVCaw=;
 b=G8EcUN/WTkWrCR+5a48AOnM5PDOBDTu70OXYdqy2jAas6Axj7X5IWCN/YwMBYOr7jx
 yuw5I3VmGDsZ19leonRyarejSfPHVeZU+/64axvpD4pvtYjmLrpc4RmfLg9/UQ2Og+B0
 9JkWl+NTEWtWIZI7O+WsjxuYbGzKkKLPeqSr/OmgXpymScWmcyoDN4Kvp79bdmT65DfR
 dpmMV9GmLTeAvKZzemY6ZN4jaqJexle0g9mkO3k/458Z8j1dhSdlC1Hp8KUaqWwFPIhV
 uEfoJ9+HFd52fTbbiaaTNbRJ/qeXCEUq25lurpDWRXxZBEKbL4YvAd9RcLiwZDArxUyJ
 nLSw==
X-Gm-Message-State: AOJu0YztZClhCk2m8KK9xCjv88WauiND+em/BN/u+s+89OZor/9BHX2E
 Mh/Wd7zwbo0+cSmiXb8uZqC9fnzvg2oOvU4oypnP+lv4/X4d39Za50tJNq4+myvm4nCuItc2tig
 g
X-Gm-Gg: ASbGncs8KnALqSZfXXvfwoRpF2k4KS/IDuGWpeEE98UeYMoeWYZ+/HJgz6BxlS+JKpd
 P6Yk0mEtXnVT9HEPfct/VZy3vbmS79l1ggwXs36lIZ+NDN134zZCRfbJ3EQb8PWWdy7i1JjRdSR
 Pl6GBl13xIpP5jYK12LazuMaujTVEWyvea35rpPVZB9rM9uCasws4O2lBAAeM2yvrWkNvWjBuTm
 R1nmCItxb4UB3Rrao4xHtxCMlDwfNochvs9NVJmiPlx6xnt3AVEHOusxmjuL6tvd75xcP/tzwOG
 AJPrNr2BMPDEUZ28mQr+A6b8iMGl2Q63ivYmH2LehXMfXhk=
X-Google-Smtp-Source: AGHT+IFKYezl1K/GhXgf5CZ62pfRjsF12y/IoN+HA0GOY55AmEiemWJqdZpt0Ppnb/o6o9VsPkPJ9A==
X-Received: by 2002:a17:90b:3ec5:b0:2fa:12be:f16a with SMTP id
 98e67ed59e1d1-2fc4116a9c9mr12348585a91.29.1739747421016; 
 Sun, 16 Feb 2025 15:10:21 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5596115sm60198415ad.258.2025.02.16.15.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:10:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 009/162] tcg/optimize: Emit add r, r,
 -1 in fold_setcond_tst_pow2
Date: Sun, 16 Feb 2025 15:07:38 -0800
Message-ID: <20250216231012.2808572-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We canonicalize subtract with constant to add with constant.
Fix this missed instance.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 0b84d97051..f0aeb10d07 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2289,7 +2289,7 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
 
 static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 {
-    TCGOpcode sub_opc, xor_opc, neg_opc, shr_opc;
+    TCGOpcode xor_opc, neg_opc, shr_opc;
     TCGOpcode uext_opc = 0, sext_opc = 0;
     TCGCond cond = op->args[3];
     TCGArg ret, src1, src2;
@@ -2311,7 +2311,6 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 
     switch (ctx->type) {
     case TCG_TYPE_I32:
-        sub_opc = INDEX_op_sub_i32;
         xor_opc = INDEX_op_xor_i32;
         shr_opc = INDEX_op_shr_i32;
         neg_opc = INDEX_op_neg_i32;
@@ -2323,7 +2322,6 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         }
         break;
     case TCG_TYPE_I64:
-        sub_opc = INDEX_op_sub_i64;
         xor_opc = INDEX_op_xor_i64;
         shr_opc = INDEX_op_shr_i64;
         neg_opc = INDEX_op_neg_i64;
@@ -2367,10 +2365,10 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
     }
 
     if (neg && inv) {
-        op2 = tcg_op_insert_after(ctx->tcg, op, sub_opc, 3);
+        op2 = tcg_op_insert_after(ctx->tcg, op, INDEX_op_add, 3);
         op2->args[0] = ret;
         op2->args[1] = ret;
-        op2->args[2] = arg_new_constant(ctx, 1);
+        op2->args[2] = arg_new_constant(ctx, -1);
     } else if (inv) {
         op2 = tcg_op_insert_after(ctx->tcg, op, xor_opc, 3);
         op2->args[0] = ret;
-- 
2.43.0


