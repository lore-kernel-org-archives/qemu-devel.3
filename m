Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FC1CCD1AB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 02:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBlMe-0007ke-V8; Wed, 22 Oct 2025 22:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vBlMZ-0007jM-66
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 22:47:39 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vBlMV-0006XZ-Ef
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 22:47:38 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Dx_78_l_loTpcZAA--.54992S3;
 Thu, 23 Oct 2025 10:47:27 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxmcA+l_lo4ysCAQ--.19467S5;
 Thu, 23 Oct 2025 10:47:27 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 3/3] target/loongarch: Remove LoongArch TLB migration support
 in TCG mode
Date: Thu, 23 Oct 2025 10:47:26 +0800
Message-Id: <20251023024726.2995960-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251023024726.2995960-1-maobibo@loongson.cn>
References: <20251023024726.2995960-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxmcA+l_lo4ysCAQ--.19467S5
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

With empty TLB table, system works well still after migration. TLB
migration is used in TCG mode and not necessary in KVM mode. And this
piece of code increases maintainance difficulty and not necessary,
here remove TLB migration support.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/machine.c | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index 0a3febf36d..e0c2da43bf 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -178,38 +178,6 @@ static const VMStateDescription vmstate_pmu = {
     },
 };
 
-#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
-static bool tlb_needed(void *opaque)
-{
-    return tcg_enabled();
-}
-
-/* TLB state */
-static const VMStateDescription vmstate_tlb_entry = {
-    .name = "cpu/tlb_entry",
-    .version_id = 0,
-    .minimum_version_id = 0,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT64(tlb_misc, LoongArchTLB),
-        VMSTATE_UINT64(tlb_entry0, LoongArchTLB),
-        VMSTATE_UINT64(tlb_entry1, LoongArchTLB),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static const VMStateDescription vmstate_tlb = {
-    .name = "cpu/tlb",
-    .version_id = 0,
-    .minimum_version_id = 0,
-    .needed = tlb_needed,
-    .fields = (const VMStateField[]) {
-        VMSTATE_STRUCT_ARRAY(env.tlb, LoongArchCPU, LOONGARCH_TLB_MAX,
-                             0, vmstate_tlb_entry, LoongArchTLB),
-        VMSTATE_END_OF_LIST()
-    }
-};
-#endif
-
 /* LoongArch CPU state */
 const VMStateDescription vmstate_loongarch_cpu = {
     .name = "cpu",
@@ -286,9 +254,6 @@ const VMStateDescription vmstate_loongarch_cpu = {
         &vmstate_fpu,
         &vmstate_lsx,
         &vmstate_lasx,
-#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
-        &vmstate_tlb,
-#endif
         &vmstate_lbt,
         &vmstate_msgint,
         &vmstate_pmu,
-- 
2.39.3


