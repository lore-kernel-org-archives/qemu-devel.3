Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E892C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 12:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmtcv-0003pp-JF; Tue, 25 Feb 2025 07:01:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tmtcO-0003je-Lg
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:01:02 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tmtcJ-0006W1-3P
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:00:55 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxTWvvsL1nOBaCAA--.26395S3;
 Tue, 25 Feb 2025 20:00:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxLsfpsL1n2uMnAA--.19507S10;
 Tue, 25 Feb 2025 20:00:47 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 08/11] target/loongarch: Enable paravirt ipi feature
Date: Tue, 25 Feb 2025 20:00:38 +0800
Message-Id: <20250225120041.1652869-9-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250225120041.1652869-1-maobibo@loongson.cn>
References: <20250225120041.1652869-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxLsfpsL1n2uMnAA--.19507S10
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

The similiar with cpucfg register, paravirt ipi feature is set in
function kvm_arch_put_registers(). Instead the paravirt feature can
be enabled only once, it cannot be changed dynamically.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/kvm/kvm.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 3117441f53..ed0706e8e0 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -83,6 +83,33 @@ static int kvm_set_stealtime(CPUState *cs)
     return 0;
 }
 
+static int kvm_set_pv_features(CPUState *cs)
+{
+    CPULoongArchState *env = cpu_env(cs);
+    int err;
+    uint64_t val;
+    struct kvm_device_attr attr = {
+        .group = KVM_LOONGARCH_VCPU_CPUCFG,
+        .attr = CPUCFG_KVM_FEATURE,
+        .addr = (uint64_t)&val,
+    };
+
+    err = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, attr);
+    if (err) {
+        return 0;
+    }
+
+    val = env->pv_features;
+    err = kvm_vcpu_ioctl(cs, KVM_SET_DEVICE_ATTR, attr);
+    if (err) {
+        error_report("Fail to set pv feature "TARGET_FMT_lx " with error %s",
+                      val, strerror(errno));
+        return err;
+    }
+
+    return 0;
+}
+
 static int kvm_loongarch_get_regs_core(CPUState *cs)
 {
     int ret = 0;
@@ -738,6 +765,7 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
 int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
 {
     int ret;
+    static int once;
 
     ret = kvm_loongarch_put_regs_core(cs);
     if (ret) {
@@ -764,6 +792,14 @@ int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
         return ret;
     }
 
+    if (!once) {
+        ret = kvm_set_pv_features(cs);
+        if (ret) {
+            return ret;
+        }
+        once = 1;
+    }
+
     if (level >= KVM_PUT_FULL_STATE) {
         /*
          * only KVM_PUT_FULL_STATE is required, kvm kernel will clear
-- 
2.43.5


