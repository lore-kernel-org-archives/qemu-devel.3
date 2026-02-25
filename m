Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA24F55437
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 01:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv3uN-0004iY-DP; Tue, 24 Feb 2026 20:41:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vv3uL-0004hT-C4
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 20:41:45 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vv3uG-00040O-UC
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 20:41:45 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxXcNMU55pqOwUAA--.64178S3;
 Wed, 25 Feb 2026 09:41:32 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxfcJMU55pIqlKAA--.7704S2;
 Wed, 25 Feb 2026 09:41:32 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v5 0/5] target/loongarch: Add host CPU type support
Date: Wed, 25 Feb 2026 09:41:26 +0800
Message-Id: <20260225014131.1487362-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxfcJMU55pIqlKAA--.7704S2
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

Host CPU model is basically the same with max CPU model, except Product
ID and CPU model name. With host CPU model, Product ID comes from
cpucfg0 on host machine and CPU model from /proc/cpuinfo, also some
CPUCFG bits which cannot be controlled by KVM hypervisor and these bits
come from host machine directly.

---
v4 ... v5:
  1. Refresh the patch based on the latest version.

v3 ... v4:
  1. Add default value with CPUCFG3[0:16] with LA464 CPU type in new
     patch 2.
  2. Add bit ALDORDER_STA/ASTORDER_STA/SLDORDER_STA with CPUCFG3 which
     comes from host.

v2 ... v3:
  1. Modify comments explaining why some bits are not checked by KVM
     hypervisor and come from host CPUCFG information in patch 4.

v1 ... v2:
  1. Add some CPUCFG capability bits from host machine.
---
Bibo Mao (5):
  target/loongarch: Add detailed information with CPU Product ID
  target/loongarch: Add default cpucfg3 with LA464 CPU
  target/loongarch: Add generic CPU model information
  target/loongarch: Add host CPU model in kvm mode
  target/loongarch: Add some CPUCFG bits with host CPU model

 hw/loongarch/virt.c    |   6 +-
 target/loongarch/cpu.c | 160 ++++++++++++++++++++++++++++++++++++++++-
 target/loongarch/cpu.h |  24 ++++++-
 3 files changed, 185 insertions(+), 5 deletions(-)


base-commit: afe653676dc6dfd49f0390239ff90b2f0052c2b8
-- 
2.39.3


