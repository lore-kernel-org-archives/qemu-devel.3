Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC50C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5II-0005qI-Nv; Tue, 07 Jul 2026 08:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wh5Hx-0005WT-26
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:52:38 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wh5Hs-0002NW-8K
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:52:35 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxiuuK9kxqCe4AAA--.4102S3;
 Tue, 07 Jul 2026 20:52:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJAxX8eF9kxqpekDAA--.23644S4;
 Tue, 07 Jul 2026 20:52:25 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, lixianglai@loongson.cn, Tao Cui <cuitao@kylinos.cn>
Subject: [PULL 2/8] target/loongarch/kvm: pass device attr by reference to
 kvm_vcpu_ioctl
Date: Tue,  7 Jul 2026 20:32:20 +0800
Message-Id: <20260707123226.25918-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260707123226.25918-1-gaosong@loongson.cn>
References: <20260707123226.25918-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxX8eF9kxqpekDAA--.23644S4
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

kvm_vcpu_ioctl() is variadic and reads its argument as a pointer, but
kvm_get_stealtime(), kvm_set_stealtime() and kvm_set_pv_features() pass
the local struct kvm_device_attr by value. It currently works because of
how the calling convention passes large structs; pass &attr so the
argument is passed as intended.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Message-ID: <20260626052742.810726-3-cui.tao@linux.dev>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/kvm/kvm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 0b72883ec9..010df226f4 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -46,12 +46,12 @@ static int kvm_get_stealtime(CPUState *cs)
         .addr = (uint64_t)&env->stealtime.guest_addr,
     };
 
-    err = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, attr);
+    err = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, &attr);
     if (err) {
         return 0;
     }
 
-    err = kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, attr);
+    err = kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, &attr);
     if (err) {
         error_report("PVTIME: KVM_GET_DEVICE_ATTR: %s", strerror(errno));
         return err;
@@ -70,12 +70,12 @@ static int kvm_set_stealtime(CPUState *cs)
         .addr = (uint64_t)&env->stealtime.guest_addr,
     };
 
-    err = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, attr);
+    err = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, &attr);
     if (err) {
         return 0;
     }
 
-    err = kvm_vcpu_ioctl(cs, KVM_SET_DEVICE_ATTR, attr);
+    err = kvm_vcpu_ioctl(cs, KVM_SET_DEVICE_ATTR, &attr);
     if (err) {
         error_report("PVTIME: KVM_SET_DEVICE_ATTR %s with gpa "TARGET_FMT_lx,
                       strerror(errno), env->stealtime.guest_addr);
@@ -96,13 +96,13 @@ static int kvm_set_pv_features(CPUState *cs)
         .addr = (uint64_t)&val,
     };
 
-    err = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, attr);
+    err = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, &attr);
     if (err) {
         return 0;
     }
 
     val = env->pv_features;
-    err = kvm_vcpu_ioctl(cs, KVM_SET_DEVICE_ATTR, attr);
+    err = kvm_vcpu_ioctl(cs, KVM_SET_DEVICE_ATTR, &attr);
     if (err) {
         error_report("Fail to set pv feature "TARGET_FMT_lx " with error %s",
                       val, strerror(errno));
-- 
2.55.0


