Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B23C4452B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 11:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmrRl-0006Sh-7Y; Thu, 23 Jul 2026 07:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zeng_chi911@163.com>)
 id 1wmqHL-0007u9-Ad; Thu, 23 Jul 2026 06:03:47 -0400
Received: from m16.mail.163.com ([220.197.31.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zeng_chi911@163.com>)
 id 1wmqHG-0002LA-MN; Thu, 23 Jul 2026 06:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Mw
 INC8YxL+u4ojAvgX/IxJM3V5LoH7R6uMFofMRU/sU=; b=mJgJb2ZCofKtJrH2uF
 K3XAOf8lJEE/gCcFWbpiB+6lp9k/XWUsp6sYzCgzlRMmMldDwjaEVuX3UsDHADQX
 LBBDgClvkc2BhZOHuRB25NRF1bTZBrVQlWnl7cbtMVqLEV5L8a6ZUhWaCT1+RCz7
 AEAgU/IfxoO33stljZMyTs7qM=
Received: from zengchi (unknown [])
 by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id
 _____wBHWhr05WFqQi8ZLg--.40114S2; 
 Thu, 23 Jul 2026 17:59:16 +0800 (CST)
From: Zeng Chi <zeng_chi911@163.com>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org,
	zengchi@kylinos.cn
Subject: [PATCH] target/riscv: Fix memory leak in riscv_trigger_unrealize()
Date: Thu, 23 Jul 2026 17:59:11 +0800
Message-Id: <20260723095911.3951185-1-zeng_chi911@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBHWhr05WFqQi8ZLg--.40114S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFykGrW3AFW7uw4xZr45GFg_yoWkCFXEgw
 4rWF1DWr4rua4jkFW3Cw48XF1j9a4UKryxtrWfWrnIgFWUuayqv397ur9YkF1kCwsrGFnx
 J397Jry7Aa43CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU81UDJUUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: 52hqws5fklmiqr6rljoofrz/xtbCvxSpZWph5fSevAAA3f
Received-SPF: pass client-ip=220.197.31.4; envelope-from=zeng_chi911@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 23 Jul 2026 07:18:22 -0400
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

From: Zeng Chi <zengchi@kylinos.cn>

In riscv_trigger_unrealize(), the per-trigger QEMUTimer objects are
created in riscv_trigger_realize() using timer_new_ns().  However,
unrealize only calls timer_del() to cancel them, but never frees the
timer objects themselves. This results in a memory leak every time a
CPU instance is unrealized (e.g., during hot-unplug or machine teardown).

Fix it by calling timer_free() for each timer after timer_del().

Fixes: 820552a92e32 ("target/riscv: dynamic alloc of debug trigger arrays")
Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
---
 target/riscv/tcg/debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 3c0fe70101..ffbdc17023 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -1081,6 +1081,7 @@ void riscv_trigger_unrealize(CPURISCVState *env)
 
     for (int i = 0; i < env->num_triggers; i++) {
         timer_del(env->itrigger_timer[i]);
+        timer_free(env->itrigger_timer[i]);
     }
     g_free(env->itrigger_timer);
 }
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus


