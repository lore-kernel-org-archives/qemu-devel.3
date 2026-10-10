Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA1ECA6004
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 06:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFQCx-0002jm-MJ; Sat, 10 Oct 2026 02:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xFQCp-0002g7-Nm; Sat, 10 Oct 2026 02:05:16 -0400
Received: from [115.124.30.98] (helo=out30-98.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xFQCj-00040w-Iy; Sat, 10 Oct 2026 02:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1791612290; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=5DrCunXh3Mnoz5vi+sz9rjIXbH4QKO/PGk+/Z2zmiuc=;
 b=k8MRWsCMC8UxgV8bcVt29FJr1BvWhAvaSlsQ9sYMDk4JY1ZtsEbOYRuOTKhUs1IVE21GvhbQO7mbgKXt0fJz2/s/Kw1Coj4cyUzI+tiw5tW7VjUxpNzfTMc55yhc5Dzwf3zNA4bj0gJld3uG9a8kKOP32yc1DmvbYpNS0RTVuxw=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0XCVKGuy_1791612289; 
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XCVKGuy_1791612289 cluster:ay36) by smtp.aliyun-inc.com;
 Sat, 10 Oct 2026 14:04:50 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Sat, 10 Oct 2026 14:04:37 +0800
Subject: [PATCH v3 13/14] target/riscv: Clear virtualization mode on reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-riscv-pmu-correctness-v3-13-712bf814a7be@linux.alibaba.com>
References: <20261010-riscv-pmu-correctness-v3-0-712bf814a7be@linux.alibaba.com>
In-Reply-To: <20261010-riscv-pmu-correctness-v3-0-712bf814a7be@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 TANG Tiancheng <lyndra@linux.alibaba.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791612281; l=975;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=JS71On3psWzq91UjodAexeVVNtRIeOpZ4KJAs9agxYQ=;
 b=GB2C9OcR7X/fMFhdWJavrPYKUJGyVtYKhOFmxJDUaEma8rqZtrKcqYONSbasrOFz1TAyy/dB5
 KgVmXDEr8b6CS8vbiSf0hheQttNq51liyKs9chhKvovEQLgazwXglfD
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.98 (deferred)
Received-SPF: pass client-ip=115.124.30.98;
 envelope-from=lyndra@linux.alibaba.com; helo=out30-98.freemail.mail.aliyun.com
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

Reset enters M-mode without clearing virt_enabled, leaving an invalid
M-mode, V=1 state after a reset from virtual mode. Clear virt_enabled
alongside the privilege reset.

Fixes: ef6bb7b62682 ("target/riscv: Add the virtulisation mode")
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index da4c1a090b9b74c5b11dac94987fe573cc1aed5c..34422d0204e7c1532c3424626c70d33f805833d5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -980,6 +980,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 #ifndef CONFIG_USER_ONLY
     env->misa_mxl = mcc->def->misa_mxl_max;
     env->priv = PRV_M;
+    env->virt_enabled = false;
     env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
     if (env->misa_mxl > MXL_RV32) {
         /*

-- 
2.43.0


