Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DD2C61DB6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylHz-0003wx-98; Tue, 25 Aug 2026 03:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylHl-0003eO-21; Tue, 25 Aug 2026 03:09:34 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylHj-0006NA-E1; Tue, 25 Aug 2026 03:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787641596; bh=HylImVf5O3yABFUdDyg00AniJpaClFN0tXyXYQo5IbE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZKPl2f6iu8qwsjgcXvvhCjn6jG+dQp1dUJC+FpFS5J4rGmaG1tJ12ghLEVFmnUBEE
 QyaxyuPHjuvfyuMGrDLcj4vPUVyCCsylM5vlUrK8MjObLLYrhSK8xoq1I3VGS3AkyE
 AxcCXezsLmPtycLkwoL4xUpnNnm8Bqap8HvG8wYVTf4i4trBzizmx0xq4IKgHntMrZ
 FL4rgqeOC+l/iBwm0X7lgVSerHERkbIQQm2O0wbDcDo2PWHVIIVuIAG+MXBib6OGwH
 ZLF6vCFsQER9UfnFdlyKDrkyYt6TIB8Lf0uk9QnQOhkNm5sFCtvwMrHT/0KJv7gIEp
 9uVhHqyrPd8hg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7A1361CE22C;
 Tue, 25 Aug 2026 10:06:36 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3ED97415FA7;
 Tue, 25 Aug 2026 10:07:13 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B820432438; Tue, 25 Aug 2026 10:06:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zeng Chi <zengchi@kylinos.cn>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 v2 71/91] target/riscv: Fix memory leak in
 riscv_trigger_unrealize()
Date: Tue, 25 Aug 2026 10:05:43 +0300
Message-ID: <20260825070619.174584-29-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
References: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260724063927.3360599-1-zeng_chi911@163.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit d5ab0bdefe418593a744fd0c625add607117c972)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 3c0fe701010..5ab29f6945b 100644
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
2.47.3


