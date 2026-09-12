Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CD2C88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L51-0000IZ-R6; Sat, 12 Sep 2026 06:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4t-0008F8-Cs
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:23 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4p-0008JZ-4e
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:21 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 d2e1a72fcca58-86868f7707dso142143b3a.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209314; x=1789814114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oCSEwbLRI1uOj4SIVBRn9ZDZn6bIlv90sHc4BIamDgk=;
 b=glJMchEXagD+O+Ioqyvh0z6TuR/4xYZFyDptZgtau0C+EAVxnIqRz5IqIux1j6IX+k
 sNS+PRYZTowu8BXGngR8j01MoCAMQjJG8S15kqkqbRVB1GdqiloaiT+yMLIr6boQznj6
 UAKkQczibBsrRg/sZsUKJ8uNmdJEsqpTfOi3mK9aw1uoWINgfFqtZf8mCToHshNOaq/+
 54WLP5V0G7j7+VTbVagz+EFEUNvXBp6vq+56fbz4Pnr+o7CeI68GOy+uyRh+OXKToBIf
 GBrNo9W8YNyR5PJlbDKc7wV6HU+XShZu/7V99oLE3k/G7uGgfpWuzk7XjjHonY8iWl1r
 lJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209314; x=1789814114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=oCSEwbLRI1uOj4SIVBRn9ZDZn6bIlv90sHc4BIamDgk=;
 b=mdYh0GvGE0VVKWLMNcGshoGbYTQBBlbzp/bHsV2t7nrc2K5EDo0yHqjVH1o40tpo+8
 +3Py1GUeGqSHlBlGgLmwYcYdrOF3fDTXHz+Bn4OArjAPv5hf+ZVH36llsnqzJ+iUAnfG
 zwkpUAQMMLj1iI4JHy0vnnObklIF0fvudO425P1kXicUtRSgxp6DHwGJyxP8cKwif3l6
 zJLTrt3vK84tPzZCWZyB1fU1RYUoch5Zjdtf/ca0TqeqFECRD/XZ/V6L8kGEaMI8UxXU
 cp3Qg4q2N+X1lBHYQEN5+ZwIl8Lf1+MI37uUh6+vtni2uFURxpdNqbWOf79S+YpoG2rK
 LOzg==
X-Gm-Message-State: AFuF++mSeF8Fz2rCbLd/kOZJxM5biw3Kl9gf2OXoE0puKPHr98dPiPwG
 JzLyX5msWt938nVNn+kUXuK4zJCL9JxcZpXyNlIMgeiFCE5p7crHqbmvS0lstjL822cdF4Ep/oH
 q8RH5cA8=
X-Gm-Gg: AYBFou3knpd+TYOXBmS6/U1pO5F1i1ekl0TtPfls8snRQnnM1C6SHlJOZaoyct73ZKy
 VmdzLTIVAADwsDxx95Qh9+ZEN3hjMfu/HTAucSo1D8AjMpjwmEy/JVZVn93QbIT0003nhKlj9+r
 VdMdWB40M+sr58HFIUvZ8W9yYHeOuonyKczGXz+8n+1QGQPSi2yAA0jE6PWWiXjvwmHhznaHrp+
 RsFMmDWGtKQ+bPfeI7hbIUNpIgKS3QqwNpL/zlSzccmzl9MK4L6flV2Y3lW0LhH8xC8YD6FfwXA
 mS7aeVFaZDvGS3Gq5QvXhMuVVjnr12plHvRHbrzbh8j9WVhyka36eVhYz7sl3qQXmGOJqU9eQhz
 RbqzXgHbx1gKZmwlOWmIkeij26CgMfRuOCcwServryUMDZstojvWGPdbq4bxzTn6+Bun4TPYcGD
 CpfJ2vW7RwzaXmsUbXBzxYTy1PpcoAmFABWBUzFoTBkHARWGJf33aGMgZdRuZEM8znNRDivoM0I
 NC9x2I=
X-Received: by 2002:a05:6a20:1eaf:b0:3da:7154:2ebf with SMTP id
 adf61e73a8af0-3db0e1146c8mr4050217637.9.1789209314404; 
 Sat, 12 Sep 2026 03:35:14 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 47/82] tcg: Split out gen_ext_i32_i64
Date: Sat, 12 Sep 2026 00:30:51 -1000
Message-ID: <20260912103126.598030-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0f.google.com
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
index ba4011ff241..14bec6053db 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -368,6 +368,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 
 static void gen_extrh_i64_i32(TCGTemp *dst, TCGTemp *src);
 static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src);
+static void gen_ext_i32_i64(TCGTemp *dst, TCGTemp *src);
 static void gen_extu_i32_i64(TCGTemp *dst, TCGTemp *src);
 
 /*
@@ -506,6 +507,11 @@ static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src)
     gen_op_tt(INDEX_op_extrl_i64_i32, TCG_TYPE_I32, dst, src);
 }
 
+static void gen_ext_i32_i64(TCGTemp *dst, TCGTemp *src)
+{
+    gen_op_tt(INDEX_op_ext_i32_i64, TCG_TYPE_I64, dst, src);
+}
+
 static void gen_extu_i32_i64(TCGTemp *dst, TCGTemp *src)
 {
     gen_op_tt(INDEX_op_extu_i32_i64, TCG_TYPE_I64, dst, src);
@@ -2327,8 +2333,7 @@ void tcg_gen_extu_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
 
 void tcg_gen_ext_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
 {
-    tcg_gen_op2(INDEX_op_ext_i32_i64, TCG_TYPE_I64,
-                tcgv_i64_arg(ret), tcgv_i32_arg(arg));
+    gen_ext_i32_i64(tcgv_i64_temp(ret), tcgv_i32_temp(arg));
 }
 
 void tcg_gen_concat_i32_i64(TCGv_i64 dest, TCGv_i32 low, TCGv_i32 high)
-- 
2.53.0


