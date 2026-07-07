Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B049C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5I8-0005ZW-2C; Tue, 07 Jul 2026 08:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wh5Hy-0005Wq-D2
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:52:38 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wh5Hv-0002NV-F6
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:52:37 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxuvCJ9kxqB+4AAA--.4052S3;
 Tue, 07 Jul 2026 20:52:25 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJAxX8eF9kxqpekDAA--.23644S3;
 Tue, 07 Jul 2026 20:52:24 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, lixianglai@loongson.cn, Tao Cui <cuitao@kylinos.cn>
Subject: [PULL 1/8] target/loongarch/kvm: fix uninitialized val and unchecked
 GET in cpucfg2 check
Date: Tue,  7 Jul 2026 20:32:19 +0800
Message-Id: <20260707123226.25918-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260707123226.25918-1-gaosong@loongson.cn>
References: <20260707123226.25918-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxX8eF9kxqpekDAA--.23644S3
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

From: Tao Cui <cuitao@kylinos.cn>

kvm_check_cpucfg2() discards the return value of KVM_GET_DEVICE_ATTR and
uses the local val (the host cpucfg2 mask) without checking whether the
read succeeded. val is also declared without an initializer, so on a GET
failure env->cpucfg[2] &= val reads an uninitialized value.

The &= mask is best-effort feature negotiation: if KVM_HAS_DEVICE_ATTR
succeeds, a GET failure is most likely a copy_{from,to}_user issue, not a
reason to fail the whole register sync. Check the GET return value, warn and
skip the mask on failure (the guest keeps the cpucfg2 it already has), and
initialize val to 0.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-ID: <20260626052742.810726-2-cui.tao@linux.dev>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/kvm/kvm.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 48cdb78a4c..0b72883ec9 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -725,7 +725,7 @@ static int kvm_loongarch_get_cpucfg(CPUState *cs)
 static int kvm_check_cpucfg2(CPUState *cs)
 {
     int ret;
-    uint64_t val;
+    uint64_t val = 0;
     struct kvm_device_attr attr = {
         .group = KVM_LOONGARCH_VCPU_CPUCFG,
         .attr = 2,
@@ -736,8 +736,17 @@ static int kvm_check_cpucfg2(CPUState *cs)
     ret = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, &attr);
 
     if (!ret) {
-        kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, &attr);
-        env->cpucfg[2] &= val;
+        /*
+         * The &= mask is best-effort feature negotiation. If HAS succeeded,
+         * a GET failure is most likely a copy_{from,to}_user issue; warn and
+         * keep the cpucfg2 the guest already has rather than failing the sync.
+         */
+        int r = kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, &attr);
+        if (r) {
+            warn_report("CPUCFG2: KVM_GET_DEVICE_ATTR: %s", strerror(errno));
+        } else {
+            env->cpucfg[2] &= val;
+        }
 
         if (FIELD_EX32(env->cpucfg[2], CPUCFG2, FP)) {
             /* The FP minimal version is 1. */
-- 
2.55.0


