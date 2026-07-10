Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF75C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 00:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whzS6-00009V-LR; Thu, 09 Jul 2026 20:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1whzS4-000094-0F
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 20:50:48 -0400
Received: from out-180.mta0.migadu.com ([91.218.175.180])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1whzS2-0005dS-3u
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 20:50:47 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1783644643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LUHiRTEzLRpwzmfD7SzZnCzbVBBFP3DYHhGh4jI132s=;
 b=GbH7GDbyE1SrwviAZVuNs8Sl6VGP5zorgeHuSriLGoBYNcmXLb/UDXooB/aVMJ8bujvf8j
 CcFBqWdqq3wUfuc9HzHyBUBkQIv+otamXYS2UZRpN/3cnIfReBsPqQ0gWuyP5Hde7JNW5r
 ZiRnTbYQPZkoBTrEr6nd9HC4pgoQMdE=
From: Tao Cui <cui.tao@linux.dev>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2 1/3] target/loongarch/kvm: advertise pv features per vCPU
Date: Fri, 10 Jul 2026 08:50:27 +0800
Message-ID: <20260710005029.345378-2-cui.tao@linux.dev>
In-Reply-To: <20260710005029.345378-1-cui.tao@linux.dev>
References: <20260710005029.345378-1-cui.tao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.180; envelope-from=cui.tao@linux.dev;
 helo=out-180.mta0.migadu.com
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

kvm_set_pv_features() programs the KVM_FEATURE cpucfg attribute, which is a
per-vCPU setting. It was called from kvm_arch_put_registers() under a
function-local static guard, so it ran only once for the whole VM: only the
first vCPU got its pv features pushed to KVM, and on SMP guests the others
never saw KVM_FEATURE_IPI / KVM_FEATURE_STEAL_TIME.

Drop the static guard and push pv features per vCPU under
KVM_PUT_FULL_STATE, the same gate kvm_set_stealtime() already uses. Host
feature detection stays in kvm_arch_init_vcpu(); the per-vCPU state write
belongs in kvm_arch_put_registers().

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 target/loongarch/kvm/kvm.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index d6539c12ac..c557ee3c3d 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -816,7 +816,6 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
 int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
 {
     int ret;
-    static int once;
 
     ret = kvm_loongarch_put_regs_core(cs);
     if (ret) {
@@ -843,19 +842,17 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
         return ret;
     }
 
-    if (!once) {
+    if (level >= KVM_PUT_FULL_STATE) {
+        /*
+         * pv_features and steal time are per-vCPU state. Push them on
+         * full-state sync so every vCPU gets its own settings; the kernel
+         * clears the steal-time guest_addr on KVM_PUT_RESET_STATE.
+         */
         ret = kvm_set_pv_features(cs);
         if (ret) {
             return ret;
         }
-        once = 1;
-    }
 
-    if (level >= KVM_PUT_FULL_STATE) {
-        /*
-         * only KVM_PUT_FULL_STATE is required, kvm kernel will clear
-         * guest_addr for KVM_PUT_RESET_STATE
-         */
         ret = kvm_set_stealtime(cs);
         if (ret) {
             return ret;
-- 
2.43.0


