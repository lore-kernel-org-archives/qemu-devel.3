Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC08C28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 03:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twY4d-0007Oj-Pa; Sun, 23 Mar 2025 23:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1twY4a-0007OJ-Qs
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 23:01:57 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1twY4Y-0003G7-Fz
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 23:01:56 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Bx12kay+Bnr6ijAA--.12679S3;
 Mon, 24 Mar 2025 11:01:46 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBx3MQZy+Bn0xRdAA--.10121S2;
 Mon, 24 Mar 2025 11:01:45 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
	Markus Armbruster <armbru@redhat.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v7 0/2] hw/loongarch/virt: Replace destination error with
 error_abort
Date: Mon, 24 Mar 2025 11:01:43 +0800
Message-Id: <20250324030145.3037408-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBx3MQZy+Bn0xRdAA--.10121S2
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

In function virt_cpu_plug() and virt_cpu_unplug(), the error is
impossile. Destination error is not propagated and replaced with
error_abort. With this, the logic is simple.

Also there is bugfix in function virt_cpu_plug(), Object cpuslot::cpu is
set at last only when there is no any error.

---
  v6 ... v7:
    1. Replace dest error from parameter errp with error_abort since the
       error is impossible.
    2. Some patches are merged, refresh the pending two patches.

  v5 ... v6:
    1. If there is nested error report when restore from error in function
       virt_cpu_plug(), set output Error object with &error_abort rather
       than NULL, since it is almost impossible now.
    2. If there is nested error report when restore from error in function
       virt_cpu_unplug(), set output Error object with &error_abort rather
       than NULL, since it is almost impossible now.

  v4 ... v5:
    1. Split patch2 in v4 into three small patches, two are fixup for error
       handing when cpu plug/unplug fails so that system can continue to
       run, one is to remove error_propagate() and refresh title.
    2. Refresh changelog in last patch and remove fixes information
       since it is impossible to happen.

  v3 ... v4:
    1. Add missed this cleanup with error and remove some local error
       object.
    2. Replace local error object with error_abort object in
       virt_cpu_irq_init(), since its return value is not checked.

  v2 ... v3:
    1. Add missing modification replacing error_propagate() + error_setg()
      with error_setg().
    2. Some enhancement about error handling, handling error
       symmetrically in many places

  v1 ... v2:
    1. Add fixes tag and change title with fix prefix in patch 1.
    2. Replace error_propagate() with error_setg(), and return directly
       for any error.
---
Bibo Mao (2):
  hw/loongarch/virt: Fix cpuslot::cpu set at last in virt_cpu_plug()
  hw/loongarch/virt: Replace destination error with error_abort

 hw/loongarch/virt.c | 43 +++++++++----------------------------------
 1 file changed, 9 insertions(+), 34 deletions(-)


base-commit: 71119ed3651622e1c531d1294839e9f3341adaf5
-- 
2.39.3


