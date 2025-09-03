Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7706CA1007
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 02:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utdM3-0007na-FX; Tue, 02 Sep 2025 22:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1utdM0-0007mQ-Ov
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 22:36:09 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1utdLy-0001tb-Eg
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 22:36:08 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Dxfb+NqbdoEQ0GAA--.11498S3;
 Wed, 03 Sep 2025 10:35:57 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDx_8ONqbdo7k96AA--.57635S2;
 Wed, 03 Sep 2025 10:35:57 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Xianglai Li <lixianglai@loongson.cn>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 0/3] Register reset interface with hot-add CPUs
Date: Wed,  3 Sep 2025 10:35:53 +0800
Message-Id: <20250903023556.3082693-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDx_8ONqbdo7k96AA--.57635S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

With cpu hotplug is implemented on LoongArch virt machine, reset
interface with hot-added CPU should be registered. Otherwise there
will be problem if system reboots after cpu is hot-added.

Also there is cleanup when system directly boot from Linux kernel image,
both BSP and APs boots from aux boot code, so that special reset
callback with BSP is not necessary.

---
v2 ... v3:
  1. Add BSP core boot support from aux boot code.
  2. Remove unnecessay pre-boot setting with BSP core.
  3. Use qemu_register_resettable() API rather than legacy API
     qemu_register_reset() to register reset interface.

v1 ... v2:
  1. Add qemu_unregister_reset() in function loongarch_cpu_unrealizefn(),
     remove reset callback if vCPU is unrealized.
---
Bibo Mao (3):
  hw/loongarch/virt: Add BSP support with aux boot code
  hw/loongarch/virt: Remove unnecessay pre-boot setting with BSP
  hw/loongarch/virt: Register reset interface with CPU object

 hw/loongarch/boot.c    | 71 ++++++++++++++++++++----------------------
 target/loongarch/cpu.c |  4 +++
 target/loongarch/cpu.h |  4 ---
 3 files changed, 38 insertions(+), 41 deletions(-)


base-commit: 91589bcd9fee0e66b241d04e5f37cd4f218187a2
-- 
2.39.3


