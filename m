Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4E1CDE006
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 01:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcZND-0004sJ-Pl; Wed, 24 Jun 2026 21:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wcZNC-0004sA-3m
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:59:22 -0400
Received: from out-179.mta0.migadu.com ([91.218.175.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wcZNA-0002P1-Kx
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:59:21 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1782352758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dk7oadZcgF+1XSO7Jj977XnWSnpVjH6Bjtz61AXKqIE=;
 b=uPLLho1Sot7vVKnFDb509tiuiyfKraO7lgyWgy9aibKI+1nHakRK9wYxa4q/T+KYLw6sP8
 17QxCMg44Xo5zSdUVM1ItPV/AHq9VZ2SsbPCLlKBIPgwuzh/n2Bwe7cONgONxZ1ohTfEXf
 ATTn68nohTS9Pqg8YMvyGgwTA31TUKw=
From: Tao Cui <cui.tao@linux.dev>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Qiang Ma <maqianga@uniontech.com>, Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 1/4] target/loongarch/kvm: fix uninitialized val and unchecked
 GET in cpucfg2 check
Date: Thu, 25 Jun 2026 09:58:31 +0800
Message-ID: <20260625015835.678819-2-cui.tao@linux.dev>
In-Reply-To: <20260625015835.678819-1-cui.tao@linux.dev>
References: <20260625015835.678819-1-cui.tao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.179; envelope-from=cui.tao@linux.dev;
 helo=out-179.mta0.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
then uses the local val (the host cpucfg2 mask) without checking whether
the read succeeded. val is also declared without an initializer.

If GET fails, env->cpucfg[2] &= val uses an uninitialized value and can
silently clear feature bits (FP / LLFTP / LSX / LASX), since bitwise-AND
can only turn bits off.

Check the GET return value, report the failure with error_report(), and
initialize val to 0.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 target/loongarch/kvm/kvm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index d6539c12ac..b7176ce53a 100644
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
@@ -736,7 +736,11 @@ static int kvm_check_cpucfg2(CPUState *cs)
     ret = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, &attr);
 
     if (!ret) {
-        kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, &attr);
+        ret = kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, &attr);
+        if (ret) {
+            error_report("CPUCFG2: KVM_GET_DEVICE_ATTR: %s", strerror(errno));
+            return ret;
+        }
         env->cpucfg[2] &= val;
 
         if (FIELD_EX32(env->cpucfg[2], CPUCFG2, FP)) {
-- 
2.43.0


