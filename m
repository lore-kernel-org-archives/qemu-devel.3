Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B190CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 01:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcZNM-0004t5-Ea; Wed, 24 Jun 2026 21:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wcZNK-0004su-R9
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:59:30 -0400
Received: from out-184.mta0.migadu.com ([91.218.175.184])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1wcZNJ-0002Pg-BV
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:59:30 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1782352767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4JvVPf1yBQBsCJPX90lCIhhbrNWsbCYEamF0PT4hQXM=;
 b=o6L+e+1DMjy9XRciuZZJRKaBqRFmh2A34U5hw6RFuV4eRAnA2levyhUyCQ+cBzAOtUjhEO
 9p2zZT1yLdr/QkVtivDVVQA3/5kwVCPp9LE6zBma3yyd5PGCikkkrYUyhwNgYj+uApTqAO
 br8VhD1ZbBAXMJBXB79UctJMvbmwoaM=
From: Tao Cui <cui.tao@linux.dev>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Qiang Ma <maqianga@uniontech.com>, Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 2/4] target/loongarch/kvm: pass device attr by reference to
 kvm_vcpu_ioctl
Date: Thu, 25 Jun 2026 09:58:32 +0800
Message-ID: <20260625015835.678819-3-cui.tao@linux.dev>
In-Reply-To: <20260625015835.678819-1-cui.tao@linux.dev>
References: <20260625015835.678819-1-cui.tao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.184; envelope-from=cui.tao@linux.dev;
 helo=out-184.mta0.migadu.com
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

kvm_vcpu_ioctl() is variadic and reads its argument as a pointer, but
kvm_get_stealtime(), kvm_set_stealtime() and kvm_set_pv_features() pass
the local struct kvm_device_attr by value. It currently works because of
how the calling convention passes large structs; pass &attr so the
argument is passed as intended.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 target/loongarch/kvm/kvm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index b7176ce53a..fffb2d431a 100644
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


