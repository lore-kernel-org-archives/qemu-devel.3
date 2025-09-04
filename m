Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184F1CA1015
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 06:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu327-00024s-Gg; Thu, 04 Sep 2025 02:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <z_bajeer@yeah.net>)
 id 1uu31v-000237-DQ; Thu, 04 Sep 2025 02:01:08 -0400
Received: from mail-m16.yeah.net ([220.197.32.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <z_bajeer@yeah.net>)
 id 1uu31q-0003Tw-EQ; Thu, 04 Sep 2025 02:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=rk
 zJ4gjJh079LWNdIJucwQLnSJqoMbRVHmUlg0WwUDM=; b=ZqQrBphi6ujWsmf/Y9
 EopJJ2vBYM6I4g+BIPac+Cge32kpB+YX4VCXLZpXaXfCdQLexmEvX1m81XrAzw8Q
 smd1PDHg3YcW2yq/iwTfyvU7U/S2O/G+CEUTPvQqdJwxMqn0plT1GhacMHlNSrYO
 pez8P9DDE6UwACJ9QbO7Ba4iA=
Received: from vcore-181.. (unknown [])
 by gzsmtp1 (Coremail) with SMTP id Mc8vCgAnLbEFK7loqUfvAw--.46633S2;
 Thu, 04 Sep 2025 14:00:39 +0800 (CST)
From: Yang Jialong <z_bajeer@yeah.net>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: yangjialong@rvcore.com, Yang Jialong <z_bajeer@yeah.net>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH] intc/aia: fix the read of in_clrip register
Date: Thu,  4 Sep 2025 14:00:22 +0800
Message-Id: <20250904060022.2828441-1-z_bajeer@yeah.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Mc8vCgAnLbEFK7loqUfvAw--.46633S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrWruFyUZFy8ZrWDCrWrGrg_yoWfuFg_Ca
 y0k34fC34DJw1fK3WDGFs8C348Zas5uFyfGw1SgF4jkw17KrW5Gwn2qr9xZr18ury7JrZ8
 GrsxCry09r13KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMBMKDUUUUU==
X-Originating-IP: [49.7.252.142]
X-CM-SenderInfo: p2betyxhhuq5hhdkh0dhw/1tbiEhK+I2i5DEpypQAAsd
Received-SPF: pass client-ip=220.197.32.17; envelope-from=z_bajeer@yeah.net;
 helo=mail-m16.yeah.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

4.5.7. Rectified inputs, clear interrupt-pending bits
A read of an in_clrip register returns the rectified input values of the
corresponding interrupt sources.
A read of an in_clrip register doesn't should be an active interrupt
source.
A write of an in_clrip register should be an active interrupt source.

Signed-off-by: Yang Jialong <z_bajeer@yeah.net>
---
 hw/intc/riscv_aplic.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index a1d9fa5085..2583d6d305 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -204,9 +204,6 @@ static bool riscv_aplic_irq_rectified_val(RISCVAPLICState *aplic,
     }
 
     sm = sourcecfg & APLIC_SOURCECFG_SM_MASK;
-    if (sm == APLIC_SOURCECFG_SM_INACTIVE) {
-        return false;
-    }
 
     raw_input = (aplic->state[irq] & APLIC_ISTATE_INPUT) ? 1 : 0;
     irq_inverted = (sm == APLIC_SOURCECFG_SM_LEVEL_LOW ||
-- 
2.34.1


