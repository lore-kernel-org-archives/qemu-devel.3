Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CDFCDE010
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 05:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcz6j-0004eT-M6; Fri, 26 Jun 2026 01:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wcz6i-0004e5-Hy
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 01:28:04 -0400
Received: from out-179.mta0.migadu.com ([2001:41d0:1004:224b::b3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wcz6g-0005rk-St
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 01:28:04 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1782451680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9BoiSycFuCoOKAkQfGbs2PFQAnjPqz4ydnB0FhHeozw=;
 b=mHZPz3JY4nX+6TgQJ6bok4vM++lHU9pkEo6jqQwnrs+kCXB+gRSTVDftDgbHo3KCk0GR6o
 XfQivc6A4Xue4TjwtOQsvy5ni68H6te8EJO10+LMt4F81vOBqmj0et+QbIehXQJJXE9BUk
 kuHCdszNz2Ry/6D7BIkke28kV2ZoBjM=
From: Tao Cui <cui.tao@linux.dev>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Qiang Ma <maqianga@uniontech.com>, Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2 2/4] target/loongarch/kvm: pass device attr by reference to
 kvm_vcpu_ioctl
Date: Fri, 26 Jun 2026 13:27:40 +0800
Message-ID: <20260626052742.810726-3-cui.tao@linux.dev>
In-Reply-To: <20260626052742.810726-1-cui.tao@linux.dev>
References: <20260626052742.810726-1-cui.tao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::b3;
 envelope-from=cui.tao@linux.dev; helo=out-179.mta0.migadu.com
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

kvm_vcpu_ioctl() is variadic and reads its argument as a pointer, but
kvm_get_stealtime(), kvm_set_stealtime() and kvm_set_pv_features() pass
the local struct kvm_device_attr by value. It currently works because of
how the calling convention passes large structs; pass &attr so the
argument is passed as intended.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 target/loongarch/kvm/kvm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 5bd5e268b9..4bb5be6864 100644
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
2.43.0


