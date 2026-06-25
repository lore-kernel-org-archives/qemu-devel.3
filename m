Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0CCCDB47C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 01:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcZHr-0007be-8l; Wed, 24 Jun 2026 21:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wcZHp-0007Tz-DF
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:53:49 -0400
Received: from out-187.mta1.migadu.com ([2001:41d0:203:375::bb])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wcZHm-0000dA-Ts
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:53:49 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1782352420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1k1dIQQdwmhsHZQpxbJ57fmGE00kCs9CmTVQOurEr8c=;
 b=mjWk6EfD6BKgTzzeZ6lKBUHIIcV2UVCAU1Tkq0fr7HJRCu1lx1ieEF7tENI/uqNdsrv6FV
 YcfcTHYXOySu/kEaSukyKO5UOauU0PQU+rx37ca1j406NOxrPBLq+eVoQQUp/SSqDdQD7L
 +M8jbUEu1dESq3DNvsKVnvvbaJ3iyHs=
From: Tao Cui <cui.tao@linux.dev>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH] target/loongarch/kvm: set pv features per vCPU in
 kvm_arch_init_vcpu
Date: Thu, 25 Jun 2026 09:53:16 +0800
Message-ID: <20260625015317.678762-1-cui.tao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::bb;
 envelope-from=cui.tao@linux.dev; helo=out-187.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
function-local static guard, so it ran only once for the whole VM and only
the first vCPU actually got its pv features pushed to KVM.

Move the call to kvm_arch_init_vcpu(), which runs once per vCPU, right
after the pv features are computed, and drop the static guard.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 target/loongarch/kvm/kvm.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index d6539c12ac..985812c828 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -816,7 +816,6 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
 int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
 {
     int ret;
-    static int once;
 
     ret = kvm_loongarch_put_regs_core(cs);
     if (ret) {
@@ -843,14 +842,6 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
         return ret;
     }
 
-    if (!once) {
-        ret = kvm_set_pv_features(cs);
-        if (ret) {
-            return ret;
-        }
-        once = 1;
-    }
-
     if (level >= KVM_PUT_FULL_STATE) {
         /*
          * only KVM_PUT_FULL_STATE is required, kvm kernel will clear
@@ -1209,6 +1200,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
         return ret;
     }
 
+    /* pv_features is a per-vCPU attribute; set it here, once per vCPU. */
+    ret = kvm_set_pv_features(cs);
+    if (ret < 0) {
+        return ret;
+    }
+
     ret = kvm_cpu_check_ptw(cs, &local_err);
     if (ret < 0) {
         error_report_err(local_err);
-- 
2.43.0


