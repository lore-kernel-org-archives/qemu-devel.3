Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50832C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 09:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7X9H-0007mF-6z; Thu, 16 May 2024 05:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s7X9E-0007ko-HV; Thu, 16 May 2024 05:11:36 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>)
 id 1s7X9C-0006Oa-HF; Thu, 16 May 2024 05:11:36 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxqenAzUVmLXQNAA--.20139S3;
 Thu, 16 May 2024 17:11:28 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cx71u4zUVm+8ciAA--.2860S6; 
 Thu, 16 May 2024 17:11:26 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, qemu-stable@nongnu.org,
 Peter Xu <peterx@redhat.com>
Subject: [PULL 4/5] target/loongarch/kvm: Fix VM recovery from disk failures
Date: Thu, 16 May 2024 17:11:19 +0800
Message-Id: <20240516091120.1021435-5-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240516091120.1021435-1-gaosong@loongson.cn>
References: <20240516091120.1021435-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx71u4zUVm+8ciAA--.2860S6
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

vmstate does not save kvm_state_conter,
which can cause VM recovery from disk to fail.

Cc: qemu-stable@nongnu.org
Signed-off-by: Song Gao <gaosong@loongson.cn>
Acked-by: Peter Xu <peterx@redhat.com>
Message-Id: <20240508024732.3127792-1-gaosong@loongson.cn>
---
 target/loongarch/machine.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index 9cd9e848d6..08a7fa5370 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -145,8 +145,8 @@ static const VMStateDescription vmstate_tlb = {
 /* LoongArch CPU state */
 const VMStateDescription vmstate_loongarch_cpu = {
     .name = "cpu",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.gpr, LoongArchCPU, 32),
         VMSTATE_UINTTL(env.pc, LoongArchCPU),
@@ -208,6 +208,8 @@ const VMStateDescription vmstate_loongarch_cpu = {
         VMSTATE_UINT64(env.CSR_DERA, LoongArchCPU),
         VMSTATE_UINT64(env.CSR_DSAVE, LoongArchCPU),
 
+        VMSTATE_UINT64(kvm_state_counter, LoongArchCPU),
+
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
-- 
2.34.1


