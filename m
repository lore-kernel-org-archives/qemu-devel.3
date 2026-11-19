Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A11606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pDc/LPc6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU3Wo-0008CC-Fk; Thu, 19 Nov 2026 09:54:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xU3Ui-0007PM-Uh; Thu, 19 Nov 2026 09:52:16 -0500
Received: from [115.124.30.111] (helo=out30-111.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xU3Ue-00082G-Ed; Thu, 19 Nov 2026 09:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1795099912; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=gEkhbbO4OQEINhnCGnIy3EsYH5H3gjA/kYuDTk0UF50=;
 b=pDc/LPc6Hu34FRGrEqw8zS5Isidc2T34KGvbFwU+K4uVKO2BYBMZTb7xAafkpO7njB9kGFGN1qntmK1CbsoKDAg4YQB0Xt7ZdIERfPy7Ml6QCGKa7Sur58Hj3rwZR/aPkN1auVXS4DSuBEG7Skevj3HtLUAejL4LAEq4ompuuag=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0XF3s1br_1795099911; 
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XF3s1br_1795099911 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 19 Nov 2026 22:51:51 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Thu, 19 Nov 2026 22:50:46 +0800
Subject: [PATCH v5 13/14] target/riscv: Clear virtualization mode on reset
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-riscv-pmu-correctness-v5-13-ae9bdc2d2f86@linux.alibaba.com>
References: <20261119-riscv-pmu-correctness-v5-0-ae9bdc2d2f86@linux.alibaba.com>
In-Reply-To: <20261119-riscv-pmu-correctness-v5-0-ae9bdc2d2f86@linux.alibaba.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795099903; l=975;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=g0iV0hJPLfwUQb8sHCNnpvutiS7yDP9B+Qvd+AXY2qo=;
 b=DJ6XzV6799bQnnEFz8XtBC0YwYBYor7UFolRLJpPi3/gogVeHoUxTuXDpUBiSXoD5eVLW2cve
 FxvTtPNse03AAY12M0H1/asAHuT6p23ARzMjphAySAPrQgpJVHp4Wfv
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.111 (deferred)
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 5a0529fbdade137d5ebc46d487f97110b03cea5c..98731ace995137ba7c8b63a2780a3f53190abf0e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -990,6 +990,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 #ifndef CONFIG_USER_ONLY
     env->misa_mxl = mcc->def->misa_mxl_max;
     env->priv = PRV_M;
+    env->virt_enabled = false;
     env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
     if (env->misa_mxl > MXL_RV32) {
         /*

-- 
2.43.0


