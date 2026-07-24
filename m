Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A82C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 06:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn9Zs-0001KO-Ad; Fri, 24 Jul 2026 02:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zeng_chi911@163.com>)
 id 1wn9Zg-0001Gf-34; Fri, 24 Jul 2026 02:40:02 -0400
Received: from m16.mail.163.com ([117.135.210.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zeng_chi911@163.com>)
 id 1wn9ZX-0003ue-Eb; Fri, 24 Jul 2026 02:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=kP
 Mt2NmkrZtknqNfeppEuoWTyPXPy+Wuo2Pf2RzGRK0=; b=JlPFfBbuaogiLDibgo
 FCxpHwqhoYc6NUn4NCAf48oubKxL2p22gbXB9h3zp04y3dC8XuXFuI1wUt1nr6iT
 MQvPO1D2eo0hKTJv8U+AphiyquEOsWECQnDHMb2VanJGy9a1oI0oNogrNyK6KATK
 yWyLpaQpGBMuHN3LptVRjJN0k=
Received: from zengchi (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PygvCgDHJBqjCGNqYchNIw--.47338S2;
 Fri, 24 Jul 2026 14:39:32 +0800 (CST)
From: Zeng Chi <zeng_chi911@163.com>
To: philmd@oss.qualcomm.com, alistair.francis@wdc.com,
 chao.liu@processmission.com, daniel.barboza@oss.qualcomm.com,
 liwei1518@gmail.com, palmer@dabbelt.com, zhiwei_liu@linux.alibaba.com
Cc: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org,
	zengchi@kylinos.cn
Subject: [PATCH v2] target/riscv: Fix memory leak in riscv_trigger_unrealize()
Date: Fri, 24 Jul 2026 14:39:27 +0800
Message-Id: <20260724063927.3360599-1-zeng_chi911@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <9882f9e7-5c05-4a76-95f0-eb8ae8366f62@oss.qualcomm.com>
References: <9882f9e7-5c05-4a76-95f0-eb8ae8366f62@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PygvCgDHJBqjCGNqYchNIw--.47338S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww1ftF4rArWfZw4kZFyrWFg_yoW8Jw1Up3
 ykWrW7try8WFW3Aan7ZF4kGry7J395Gw45Cw4rurW0v3yrJFyfJ3ZYkrWjga129F4vyr42
 vrnYkF15AFnrAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjiihUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: 52hqws5fklmiqr6rljoofrz/xtbCwAWeWmpjCKWcxgAA3-
Received-SPF: pass client-ip=117.135.210.4; envelope-from=zeng_chi911@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: Zeng Chi <zengchi@kylinos.cn>

In riscv_trigger_unrealize(), the per-trigger QEMUTimer objects are
created in riscv_trigger_realize() using timer_new_ns().  However,
unrealize only calls timer_del() to cancel them, but never frees the
timer objects themselves. This results in a memory leak every time a
CPU instance is unrealized (e.g., during hot-unplug or machine teardown).

Fix it by replacing timer_del() with timer_free(), which internally
cancels the timer and frees its memory.  The separate timer_del() call
is no longer needed.

Fixes: 820552a92e32 ("target/riscv: dynamic alloc of debug trigger arrays")
Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
---
 target/riscv/tcg/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 3c0fe70101..5ab29f6945 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -1080,7 +1080,7 @@ void riscv_trigger_unrealize(CPURISCVState *env)
     g_free(env->cpu_watchpoint);
 
     for (int i = 0; i < env->num_triggers; i++) {
-        timer_del(env->itrigger_timer[i]);
+        timer_free(env->itrigger_timer[i]);
     }
     g_free(env->itrigger_timer);
 }
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus


