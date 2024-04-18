Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A31C04FF8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 13:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxRNu-000429-I2; Thu, 18 Apr 2024 09:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangzw@tecorigin.com>)
 id 1rxP52-00060l-2B
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 06:33:24 -0400
Received: from out28-148.mail.aliyun.com ([115.124.28.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangzw@tecorigin.com>)
 id 1rxP4x-0000eE-F9
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 06:33:23 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1101409|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.00147396-2.70649e-05-0.998499;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047209; MF=jiangzw@tecorigin.com; NM=1;
 PH=DS; RN=4; RT=4; SR=0; TI=SMTPD_---.XEijZRr_1713436069; 
Received: from localhost.localdomain(mailfrom:jiangzw@tecorigin.com
 fp:SMTPD_---.XEijZRr_1713436069) by smtp.aliyun-inc.com;
 Thu, 18 Apr 2024 18:27:56 +0800
From: Zhiwei Jiang <jiangzw@tecorigin.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com,
 Zhiwei Jiang <jiangzw@tecorigin.com>
Subject: [PATCH] tcg: Fix the overflow in indexing tcg_ctx->temps
Date: Thu, 18 Apr 2024 10:27:47 +0000
Message-Id: <20240418102747.27703-1-jiangzw@tecorigin.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=115.124.28.148;
 envelope-from=jiangzw@tecorigin.com; helo=out28-148.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 Apr 2024 09:00:56 -0400
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

Sometimes, when the address of the passed TCGTemp *ts variable is the same as tcg_ctx,
the index calculated in the temp_idx function, i.e., ts - tcg_ctx->temps,
can result in a particularly large value, causing overflow in the subsequent array access.

0  0x00007f79590132ac in test_bit (addr=<optimized out>, nr=<optimized out>)
    at /data/system/jiangzw/release_version/qemu8.2/include/qemu/bitops.h:135
1  init_ts_info (ctx=ctx@entry=0x7f794bffe460, ts=0x7f76fc000e00) at ../tcg/optimize.c:148
2  0x00007f7959014b50 in init_arguments (nb_args=2, op=0x7f76fc0101f8, ctx=0x7f794bffe460) at ../tcg/optimize.c:792
3  fold_call (op=0x7f76fc0101f8, ctx=0x7f794bffe460) at ../tcg/optimize.c:1348
4  tcg_optimize (s=<optimized out>) at ../tcg/optimize.c:2369
5  0x00007f7958ffa136 in tcg_gen_code (s=0x7f76fc000e00, tb=0x7f7904202380, pc_start=140741246462840) at ../tcg/tcg.c:6066

Signed-off-by: Zhiwei Jiang <jiangzw@tecorigin.com>
---
 include/tcg/tcg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 05a1912f8a..4b38d2702d 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -629,7 +629,7 @@ static inline size_t temp_idx(TCGTemp *ts)
  */
 static inline TCGTemp *tcgv_i32_temp(TCGv_i32 v)
 {
-    return (void *)tcg_ctx + (uintptr_t)v;
+    return (void *)tcg_ctx->temps + (uintptr_t)v;
 }
 #endif
 
@@ -681,7 +681,7 @@ static inline TCGArg tcgv_vec_arg(TCGv_vec v)
 static inline TCGv_i32 temp_tcgv_i32(TCGTemp *t)
 {
     (void)temp_idx(t); /* trigger embedded assert */
-    return (TCGv_i32)((void *)t - (void *)tcg_ctx);
+    return (TCGv_i32)((void *)t - (void *)tcg_ctx->temps);
 }
 
 static inline TCGv_i64 temp_tcgv_i64(TCGTemp *t)
-- 
2.17.1


