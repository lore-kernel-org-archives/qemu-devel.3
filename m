Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A83C88E5A
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aAw-0001ki-MT; Sat, 12 Sep 2026 22:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aAt-0001ST-7t
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:35 -0400
Received: from mail-pz2-x15.google.com ([2607:f8b0:4864:3b::15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aAq-0001rO-Iw
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:34 -0400
Received: by mail-pz2-x15.google.com with SMTP id
 41be03b00d2f7-cc4c3304784so1018015a12.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267351; x=1789872151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZOARFRdGEH3TnPRiwqzH1IlHy5ZE131PKy1PZInpYgs=;
 b=T4yORxb2GHZ9Sqeh5+pHxkIElVZGAaEvumXdFR3yfzZDoUUks+OZqa2uEle5ElqHX6
 0xNcbihK13R45QPZP+LerD1/pGwgjGFgJnbU5M4BE73QCydoZ3L94lIikKjM0Tx7WGTG
 njtnQojVEvkmGyddFD3D1Tvcg7R0eSMvrhdSmtPVQ8HnK242pqITfNmwj9smJCnqiBYf
 v4OaVw715p227AlVp0Wk8xnwglTuDu7byVfEpQ21WWPr8y1JmblgzaRNweZZiVIuKsjh
 llpvl6ZoPGK/KnUrSvS9t+QxbpQ+MjLVaNWu4CV2Kf6qs0fx322h1EmFQqxCjdrUdxe9
 AbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267351; x=1789872151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZOARFRdGEH3TnPRiwqzH1IlHy5ZE131PKy1PZInpYgs=;
 b=VLGrg2ooLfUw3ZlOfK78/f2FisF2tXzoLQnC4avDWyL9xJ6Kja7IS7SxVGiCaEX5k7
 ACn6UieLxAFAZR24J0O5Y5EjNhhc73VGEaVBdty/mrlePrmYlb80TI4HMCEx45eDT3cT
 TO/6mgjPpGFbHPDDru1RJJpwICcg824yEkYU66ygHUcRcoPkB7a0htIgK7eFpQsPzeSy
 aoa5PIFFV/757Gdtn/+BxiphCaPKkBCoCSYbZqRmErFHJY4tpw5cZ6uoUC1L1OxiaM7y
 7zJ8bXAw3PURkIcWXyvrbxaIHSR/8HceaqBLIRh4Bq/mRXcpfrHSs2YGQx903F+CW/3/
 rBWw==
X-Gm-Message-State: AFuF++l81gWlIoe6gYEPXWzVS4CbKJ4U1PjowX9+4RB9fnErQkitU3p/
 I79KuV4jIe8PWo76+pUb3xEzDbz4W5lMICqUp+Cu8BwJrEBwglkN83XxYfahaZSAFQKWTVSvCmk
 Vc+nKmi8=
X-Gm-Gg: AYBFou0K9iWrT4I0Jv0h5FoV2XIXdSDtNR7Cr4VQoFy7OtEi5tUEO/upbV2LqzcIWEF
 8tnqOj+3GYIDqw4TFSdKY26V/li0hVVVfL6R3ydkyL0WmqQxiG3MEXH9eBMOiH0lb/kjIZhHxgn
 XwfFekqarIrIPQiQ/2sPujsdeN3ll6Kq+aNYRkoZOfQQcggKQwvfw6ZNXjLVOO4Jfhcj1O/Gq6n
 X8+arxYZxWzgyMnOYo+L6fQQ4kwV021Ff5JAWB0ezGdk9cqsdTtzDOR0litXerUh5FPG/aDXsQS
 5GzS9B7F5zzQp5wKmlOw9s95KV2A7egxs7Y1VEqRxU7xebtIWAo0fTBGmFP6lqZ6dg2iQcYoewJ
 UTWNGqbi20cD1Ndmz3LqZl9yU/ax/5PMXgRquiE8wusrCdFZQ9OY36ecTGRwp/3wYPx0MOLaLbq
 Th3rag8B32ac8mER6Yrfae1QJbCcUUJO9Mt3H8zisb7exDR7QfN4lkmfAtjcl4wt/krhLW7/l1A
 qKyNzg=
X-Received: by 2002:a17:90b:3810:b0:398:9be8:ea68 with SMTP id
 98e67ed59e1d1-39d9c35dddemr20147552a91.21.1789267350916; 
 Sat, 12 Sep 2026 19:42:30 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 45/86] tcg: Split out gen_extu_i32_i64
Date: Sat, 12 Sep 2026 16:37:56 -1000
Message-ID: <20260913023837.741866-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::15;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x15.google.com
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

We'll need this for other generic expansions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8a5e0287411..1b297652661 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -412,6 +412,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF6
 
 static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src);
+static void gen_extu_i32_i64(TCGTemp *dst, TCGTemp *src);
 
 /*
  * Generic expansions for templated operations.
@@ -544,6 +545,11 @@ static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src)
     gen_op_tt(INDEX_op_extrl_i64_i32, TCG_TYPE_I32, dst, src);
 }
 
+static void gen_extu_i32_i64(TCGTemp *dst, TCGTemp *src)
+{
+    gen_op_tt(INDEX_op_extu_i32_i64, TCG_TYPE_I64, dst, src);
+}
+
 static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -2291,8 +2297,7 @@ void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
 
 void tcg_gen_extu_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
 {
-    tcg_gen_op2(INDEX_op_extu_i32_i64, TCG_TYPE_I64,
-                tcgv_i64_arg(ret), tcgv_i32_arg(arg));
+    gen_extu_i32_i64(tcgv_i64_temp(ret), tcgv_i32_temp(arg));
 }
 
 void tcg_gen_ext_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
-- 
2.53.0


