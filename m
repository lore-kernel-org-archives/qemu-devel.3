Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D18CDE011
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 05:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcz6i-0004e9-Tl; Fri, 26 Jun 2026 01:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wcz6h-0004dv-6f
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 01:28:03 -0400
Received: from out-189.mta0.migadu.com ([2001:41d0:1004:224b::bd])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wcz6f-0005rD-1q
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 01:28:02 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1782451677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=olZcp+sfhOZfnkeyC8n/H+bCw+HZ7klG+g1jcmaTShQ=;
 b=BtjZ0/xuuYFbKjxfT6lf3+ZdfMVL2OwC188jOTGbolDEKzWbR4rL50muwZPojQID4MRC8/
 1xX60crsXyn1DaNEGf2OXWZ4nlMjavXYREnJwJe+lz1G+5hgsPGhS0YqQ0uY3dbctK+EX+
 3m8wfzPWQPRshZhexQWdpGy5dbPNwv8=
From: Tao Cui <cui.tao@linux.dev>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Qiang Ma <maqianga@uniontech.com>, Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2 1/4] target/loongarch/kvm: fix uninitialized val and
 unchecked GET in cpucfg2 check
Date: Fri, 26 Jun 2026 13:27:39 +0800
Message-ID: <20260626052742.810726-2-cui.tao@linux.dev>
In-Reply-To: <20260626052742.810726-1-cui.tao@linux.dev>
References: <20260626052742.810726-1-cui.tao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::bd;
 envelope-from=cui.tao@linux.dev; helo=out-189.mta0.migadu.com
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
---
 target/loongarch/kvm/kvm.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index d6539c12ac..5bd5e268b9 100644
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
2.43.0


