Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1781EC88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1b-000508-BO; Sat, 12 Sep 2026 06:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1I-0004my-91
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:42 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1G-0007G1-5D
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:39 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38ea87caafeso1804123a91.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209097; x=1789813897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Th5XARjx24NT8l6Dcmis0Ja8OWXyBkVynXurLdxAmgo=;
 b=eWRjz/hpGMzcShpOvOT+8JEX7DITmCOdLNjq63JSdQ0DACUTLpG2kJYXqClpKvvBlw
 Yqpv7jzXtgfkDO+oZpq0+h602K3RBAlRYCkuN76YA8JXd5TCewttS+Wqb+kHd13z7w2o
 /E1wN2gjuAQQnNDFUqTFl5AU1D3pa4OzEJ1XWHjmtuNsWUe5gqPk5BA5DwtBW3G3oQM1
 bjt9LZbl2sbjIhsmp6aRbat33BrUgDykXALBYywLnctiqb8ELuYhsadfFweatPslSxeO
 egooo9SPU9JOW/c2NvQCD3E8Nhy5nR4LgQ2pE7VY77+GS95p71UI4zw2WsdibZKbUgmi
 5fNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209097; x=1789813897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Th5XARjx24NT8l6Dcmis0Ja8OWXyBkVynXurLdxAmgo=;
 b=qV7WHGF+hHuQVnn898TCvCWrMeCxqkQCUgRHKuBBwAL6HwaQZgqVnxhuyrtZP571MF
 wAREWbOy385cT3cC61qjUGCoawvZ4kCGtwYSVcdmHs1Un93UpenvrFct8UTRLlRvbKes
 kZPNoI3XaIcgsiSmUN5fE5A12qtf1xIzFPn/+5wFVU/curtuQXik32gN3bX8c0YTizU0
 aPntUmswvbtowWt5v0FCd0nkloU7OOXRQiK/cMioLAzcMQE83hbvFUeaYj5fHdHR4+w2
 HV+fGRXdU70/7hRrapWvDzWQjANiEdrufWdbT89MCuHqp2B4qgOkSl8ssqhQKAqIIEST
 Bj0Q==
X-Gm-Message-State: AFuF++k3LDSdttS+Ef6b2lnGyqMwvoGk4vu6Eu4lsr+kIaP9nk3ox2VQ
 EXE9EAuNfzvJ+OBYruaq9wu/yl9Ipwr+TXT4sg5zBG15de3f5ZopQGRLjpWKi4H47mvx9Esq93Q
 LN/RO
X-Gm-Gg: AYBFou3cOxXgfPXn1wW+0lmqhanQas424N6nJw1Z0aqPLdJfd/qH0eY8RwUdyOksZL9
 xkSF2d70sOTcr2ScrFS6jTsnO6p7iAQ7I27nWfOCSsqFRZ3HsfGiy/tqV6CH/3FaUOMHoDpbX1c
 4IuHGCOfqhZvi434ouZxJQLqw3sMN1kWiS2FT9DvPU8cZRXjnNcVp8ykmamA5Mg34t55reAHNh2
 /6NCgHLxDT1+s2J1y/dMMAhquFrokyhy6uSn1MlXB7Y9I8syfar4nCyhnHsbMVnYhhIINd93OJE
 QUdLzEwmP26QOc6QgtntliaCuZ/eBXPlTDv5uyyrWE/6fcNLitSpe8Ihq9+lFYN01QhykhLSdA+
 S3mNSUzta7nzsLmxBMXPq/2zxkTkF7BtXiQT9oC+p1eBobsUj73kxeuPuUgf2p2XJGsMVrVCIsV
 6h7TLcVhMj/FKOSBDfEfXcuvAUq16bVEeQRiST8WqNBt84eoSTvRXjx7iG8HwBT4U7M7wM/qdM+
 4oJY44=
X-Received: by 2002:a17:90b:4a8b:b0:38f:240d:b857 with SMTP id
 98e67ed59e1d1-39d9bbc81cfmr13286381a91.2.1789209096557; 
 Sat, 12 Sep 2026 03:31:36 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/82] tcg: Generic expansion of tcg_gen_sub_*
Date: Sat, 12 Sep 2026 00:30:12 -1000
Message-ID: <20260912103126.598030-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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
 include/tcg/tcg-op-common.h   |  3 ---
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 15 +++++----------
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 96d8ed8990a..497a9e2c3c6 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -206,7 +206,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -309,8 +308,6 @@ void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
-
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 642cc7cfa48..5770bfcccb8 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -5,3 +5,4 @@ DEF_RI(movi)
 DEF_RR(mov)
 DEF_RRI(addi)
 DEF_RRR(add)
+DEF_RRR(sub)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b48dc62bdfc..dfa97036780 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -380,6 +380,11 @@ static void gen_movi(TCGType type, TCGTemp *dst, int64_t src)
     gen_op_tt(INDEX_op_mov, type, dst, tcg_constant_internal(type, src));
 }
 
+static void gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
+}
+
 /*
  * Templated operations.
  */
@@ -414,11 +419,6 @@ static void gen_movi(TCGType type, TCGTemp *dst, int64_t src)
 
 /* 32 bit ops */
 
-void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_sub, ret, arg1, arg2);
-}
-
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
 {
     if (arg1 == 0) {
@@ -1511,11 +1511,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_sub, ret, arg1, arg2);
-}
-
 void tcg_gen_and_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_and, ret, arg1, arg2);
-- 
2.53.0


