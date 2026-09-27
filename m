Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948C3C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAksM-0007X6-Hy; Sun, 27 Sep 2026 05:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrY-0002Kf-Uj
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:08:01 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrX-0008I3-29
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:08:00 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccdaea76so712239a91.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790500078; x=1791104878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g5lVb9UHm6MoXumPH+HknGbfOzhEdYpNEcj7Bf5Pfm8=;
 b=H3Ah8y/iWDCirspXDg2SJhxttSwW7/YLWuurfu9HG1Acpbq9x9o7nGmJcQ2xFQ00uc
 jTR8XMP4ZKVFkvqH2c4rddr93KNvx/wAyQmWnyNLBR6G8lZymJv8W47Oz3wEM7t5spU+
 30xGqa63y4hGgrfYkG2HZAscdh2keTr1jEqx7NXgo501qOzfrWCGLMvBR2EcjWxSUWzU
 F9Xgmp6JxbOLLCAF24tXimNEna0y//VdJQzo53SzpbdHVqYypsQduJu4Y8R8F3WEeBZ1
 qOa0IDT0PHavMpLxonTjzr7phBugnfy2pzq/hEhEDTKhNVdxg0egugaZ0M/4fRYACnkk
 41/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790500078; x=1791104878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=g5lVb9UHm6MoXumPH+HknGbfOzhEdYpNEcj7Bf5Pfm8=;
 b=MC040Whf3ShjvkGTXoPcQMwSXk/3wEoe/FEkx1pd86K9pz7sQ0nK+/WR1c+gQXYQDk
 T3enAGRktkExuku1q2GYb2WmgLzqrVS76YcL40QgGBvciMeIToZB/EdHaM3tNdrWCznR
 S2pa69q39W3a9r6aY7NqjYUf79LuhFEFKr2FoxiAz3jA8Bb9Nd5ArAwRzESHDeUcVfZC
 M3ccgxXtzOj9dxNubwJdkS2CC+F2TVTsGAMqv0OtkEmCUjyA7LI/EpgetQU49Xv4VlQu
 MEiLq0yKLihVsVB2TaDdGiaFlJrBTPmL0RQBln7OTLY12eYpwBsARHYJTGezojaq1w9h
 t8fw==
X-Gm-Message-State: AFq9FYJB0Jb3oyfPAh2G20ofItSuFa2mpjilWpFlzO7Mpu7u1KJM7KKl
 ypgewCyazF+AYM1Wwa2yuBB+cdaW1DdVc/GzvXR9Z93crLBv6H+5UO4JzKqtBA+jRhPkZUmC74+
 dfqxa
X-Gm-Gg: AYBFou2mdjDFDS03XJOQpN40zajo3BusA3FtzQu8SxCi8WtDCRAehrJT6Lfg9E+hi9y
 a4tN+uh/J58hWuVKbpkz2To/xni6tzKWspwocevEZ+3U4QKBVcqtkkOIeWrcjUhn9bNcmL0xfLB
 W2pLWG8BCDkH2KQrzAi09pChZ6hKtlEhAKvTMtse3cKCZppuLOLJFY5jE+7EC2QWSQHsq7W0YJ+
 qw7FNHen7l8toIGZg5kLTe29+rLhURcfY1jjeRnj6DBR+c9IJXp10sniKHdiPdEzQVA10bhi64R
 V30AnnkNnlYRCgyGBPWFM1ij8AtpdkFfk5gy/n+EtNUlY4ZAcJ7Ag0xl3h43RfQtRp4IptZ4f4e
 WbarQXkhOEuPxTL/YfnDUNAfOKfKTZW+PhsqJFtTJNeyYUCVLjyxQPWFWRoRESmUMVgdWFxo4fI
 Zp7utuogKOHPjWctC1NIOorD7KxD5JGj5mbvbZRrf0homyAyjFDoRp7RgxWmPrDP9AdcqEZ4IeX
 hW0OsLPE0wvKCQ8SMY6TsTQ0fylsg==
X-Received: by 2002:a17:90a:dfcc:b0:3a0:cca0:4a8c with SMTP id
 98e67ed59e1d1-3a0cca04bf4mr2756124a91.7.1790500077705; 
 Sun, 27 Sep 2026 02:07:57 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e7036e3bsm7144984a91.13.2026.09.27.02.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:07:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 094/101] tcg: Generic expansion of tcg_gen_st8_*
Date: Sun, 27 Sep 2026 02:00:04 -0700
Message-ID: <20260927090011.10724-95-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
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
index 6c10f15167d..b04a9a76e00 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -140,7 +140,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
-void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
@@ -159,7 +158,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in);
 
-void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 514967f91db..90bcf9e5ab8 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -71,6 +71,7 @@ DEF3(shri, TCGV, TCGV, TINT)
 DEF3(smax, TCGV, TCGV, TCGV)
 DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(st, TCGV, TCGv_ptr, tcg_target_long)
+DEF3(st8, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF6(sub2, TCGV, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 20622be3daf..257ce2c3e6d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1259,6 +1259,11 @@ void tcg_gen_st(TCGType type, TCGTemp *dst, TCGTemp *base, tcg_target_long ofs)
     tcg_gen_op_tti(INDEX_op_st, type, dst, base, ofs);
 }
 
+void tcg_gen_st8(TCGType type, TCGTemp *dst, TCGTemp *base, tcg_target_long ofs)
+{
+    tcg_gen_op_tti(INDEX_op_st8, type, dst, base, ofs);
+}
+
 void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -1410,11 +1415,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_st8, arg1, arg2, offset);
-}
-
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_st16, arg1, arg2, offset);
@@ -1432,11 +1432,6 @@ void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_ld32s, ret, arg2, offset);
 }
 
-void tcg_gen_st8_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_st8, arg1, arg2, offset);
-}
-
 void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_st16, arg1, arg2, offset);
-- 
2.53.0


