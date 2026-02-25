Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FB3F55437
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 01:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv3uN-0004iX-DP; Tue, 24 Feb 2026 20:41:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vv3uL-0004hR-8a
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 20:41:45 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vv3uH-00040Q-2U
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 20:41:45 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxD6pOU55pruwUAA--.5050S3;
 Wed, 25 Feb 2026 09:41:34 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxfcJMU55pIqlKAA--.7704S4;
 Wed, 25 Feb 2026 09:41:34 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v5 2/5] target/loongarch: Add default cpucfg3 with LA464 CPU
Date: Wed, 25 Feb 2026 09:41:28 +0800
Message-Id: <20260225014131.1487362-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260225014131.1487362-1-maobibo@loongson.cn>
References: <20260225014131.1487362-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxfcJMU55pIqlKAA--.7704S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The features shown in cpucfg3 mostly are relative with cache capability,
QEMU does not support cache emulation and discard these features.
However it will be better if it is the same with host machine.

Here add default cpucfg3 feature information with LA464 CPU.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index f04558027d..93980e62a3 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -321,6 +321,22 @@ static void loongarch_la464_initfn(Object *obj)
     data = FIELD_DP32(data, CPUCFG2, LAM, 1);
     env->cpucfg[2] = data;
 
+    data = 0;
+    data = FIELD_DP32(data, CPUCFG3, CCDMA, 1);
+    data = FIELD_DP32(data, CPUCFG3, UCACC, 1);
+    data = FIELD_DP32(data, CPUCFG3, LLEXC, 1);
+    data = FIELD_DP32(data, CPUCFG3, SCDLY, 1);
+    data = FIELD_DP32(data, CPUCFG3, LLDBAR, 1);
+    data = FIELD_DP32(data, CPUCFG3, ITLBHMC, 1);
+    data = FIELD_DP32(data, CPUCFG3, ICHMC, 1);
+    data = FIELD_DP32(data, CPUCFG3, SPW_LVL, 4);
+    data = FIELD_DP32(data, CPUCFG3, SPW_HP_HF, 1);
+    if (kvm_enabled()) {
+        data = FIELD_DP32(data, CPUCFG3, RVA, 1);
+        data = FIELD_DP32(data, CPUCFG3, RVAMAX, 7);
+    }
+    env->cpucfg[3] = data;
+
     env->cpucfg[4] = 100 * 1000 * 1000; /* Crystal frequency */
 
     data = 0;
-- 
2.39.3


