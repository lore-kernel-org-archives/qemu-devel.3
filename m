Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EAEC5DF88
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 06:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxIwF-0001WX-Ar; Fri, 21 Aug 2026 02:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wxIwC-0001VY-Ck; Fri, 21 Aug 2026 02:41:12 -0400
Received: from [115.124.30.97] (helo=out30-97.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wxIw8-00066A-VE; Fri, 21 Aug 2026 02:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1787294442; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=DBulrXCYmN9obTHaPtKhQcdAYvfQQ3QKSWI0GMPC3C0=;
 b=grtLEvgbofEOsCzVSri4oZVJZnC7usgrQo7xx16zxAHP4IbLxiKIyPx3/Iyl8VFO7QCVvphW0g4fd9V9BCKd94DorXWuFYb3VvQFN3hMbHDr46KWsWG4dyFn8SpWYVqavpxmVAnbUGwpEiEgUbnnT1WkOrREy7z8hS09Bg8IYe4=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R381e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032089153;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=11; SR=0;
 TI=SMTPD_---0X9LMiSs_1787294441; 
Received: from localhost.localdomain(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0X9LMiSs_1787294441 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 21 Aug 2026 14:40:41 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org,
	qemu-arm@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, chao.liu@processmission.com,
 zhiwei_liu@linux.alibaba.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org
Subject: [PATCH 3/3] target/arm: Fix barrier polarity of A32 LDA load-acquire
Date: Fri, 21 Aug 2026 14:40:32 +0800
Message-Id: <20260821064032.49556-4-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260821064032.49556-1-zhiwei_liu@linux.alibaba.com>
References: <20260821064032.49556-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.97 (deferred)
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-97.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

The A32 and T32 load-acquire instructions LDA, LDAB and LDAH must be
ordered before the memory accesses that follow them, so their
translator has to emit a trailing barrier.  op_lda() emits that barrier
with TCG_BAR_STRL instead of TCG_BAR_LDAQ, inverting the polarity:
TCG_BAR_STRL annotates a leading barrier ("previous ops will not be
delayed") and TCG_BAR_LDAQ a trailing one ("following ops will not come
forward"), as documented in include/tcg/tcg-mo.h.

The x86 and aarch64 backends only look at the TCG_MO_* bits, which the
wrong annotation does not affect, so the generated host code is
unchanged on those hosts.  The annotation is still wrong: it violates
the TCG barrier contract, it lets the optimizer's barrier merging in
fold_mb() combine the barriers of an "LDA; STL" pair into a weaker one
than the correctly annotated form (STRL|STRL stays STRL instead of
LDAQ|STRL = SC), and it diverges from every other load-acquire
translation in the target, which all use TCG_BAR_LDAQ.

Fix the polarity.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/arm/tcg/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index bddac41bf9..a81b8d3852 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -4421,7 +4421,7 @@ static bool op_lda(DisasContext *s, arg_LDA *a, MemOp mop)
     disas_set_da_iss(s, mop, a->rt | ISSIsAcqRel);
 
     store_reg(s, a->rt, tmp);
-    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
     return true;
 }
 
-- 
2.43.0


