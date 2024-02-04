Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0615C48286
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 05:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWVQp-0005jN-8v; Sun, 04 Feb 2024 00:52:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rWVQm-0005jA-MW; Sun, 04 Feb 2024 00:52:41 -0500
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rWVQj-0001RU-VV; Sun, 04 Feb 2024 00:52:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1707025949; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=y5Ns7qJmBFb7Psf9VtrVGHnHAQV7AVjQ1CBhIQooblk=;
 b=nCsvU/GZhcdWK9JCW/3Egf/pv5CftcML7fAD4GR4Np2IZgqTyvL349xzzltDYs+I62/12xPnE0GHYrKDkYcCUAMt3peR4Ka8PPXpKYM5ILvJ8JoHcaLmZmmmb3Rc/AZlTLjcTg/H0uctvY3q2OU2Ix2JmhZ+kXpN7r2wySMWW80=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W0.jg7._1707025948; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W0.jg7._1707025948) by smtp.aliyun-inc.com;
 Sun, 04 Feb 2024 13:52:29 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com, palmer@dabbelt.com, bin.meng@windriver.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com, qemu-riscv@nongnu.org,
 christoph.muellner@vrull.eu, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH] target/riscv: Enable xtheadsync under user mode
Date: Sun,  4 Feb 2024 13:52:28 +0800
Message-Id: <20240204055228.900-1-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.113;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-113.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

According to xtheadsync[1][2] documentation, it can be used in user mode and
the behavior is same with other priviledges.

[1]:https://github.com/T-head-Semi/thead-extension-spec/blob/master/xtheadsync/sync.adoc
[2]:https://github.com/T-head-Semi/thead-extension-spec/blob/master/xtheadsync/sync_i.adoc

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/riscv/insn_trans/trans_xthead.c.inc | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/insn_trans/trans_xthead.c.inc
index dbb6411239..22488412d4 100644
--- a/target/riscv/insn_trans/trans_xthead.c.inc
+++ b/target/riscv/insn_trans/trans_xthead.c.inc
@@ -992,7 +992,6 @@ static bool trans_th_sfence_vmas(DisasContext *ctx, arg_th_sfence_vmas *a)
 #endif
 }
 
-#ifndef CONFIG_USER_ONLY
 static void gen_th_sync_local(DisasContext *ctx)
 {
     /*
@@ -1003,14 +1002,12 @@ static void gen_th_sync_local(DisasContext *ctx)
     tcg_gen_exit_tb(NULL, 0);
     ctx->base.is_jmp = DISAS_NORETURN;
 }
-#endif
 
 static bool trans_th_sync(DisasContext *ctx, arg_th_sync *a)
 {
     (void) a;
     REQUIRE_XTHEADSYNC(ctx);
 
-#ifndef CONFIG_USER_ONLY
     REQUIRE_PRIV_MSU(ctx);
 
     /*
@@ -1019,9 +1016,6 @@ static bool trans_th_sync(DisasContext *ctx, arg_th_sync *a)
     gen_th_sync_local(ctx);
 
     return true;
-#else
-    return false;
-#endif
 }
 
 static bool trans_th_sync_i(DisasContext *ctx, arg_th_sync_i *a)
@@ -1029,7 +1023,6 @@ static bool trans_th_sync_i(DisasContext *ctx, arg_th_sync_i *a)
     (void) a;
     REQUIRE_XTHEADSYNC(ctx);
 
-#ifndef CONFIG_USER_ONLY
     REQUIRE_PRIV_MSU(ctx);
 
     /*
@@ -1038,9 +1031,6 @@ static bool trans_th_sync_i(DisasContext *ctx, arg_th_sync_i *a)
     gen_th_sync_local(ctx);
 
     return true;
-#else
-    return false;
-#endif
 }
 
 static bool trans_th_sync_is(DisasContext *ctx, arg_th_sync_is *a)
-- 
2.25.1


