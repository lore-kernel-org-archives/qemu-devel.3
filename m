Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B44CA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 12:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umAIU-0001Wp-4o; Wed, 13 Aug 2025 08:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1um54G-0007mS-13
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 02:34:36 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1um547-0007sK-VD
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 02:34:34 -0400
DKIM-Signature: a=rsa-sha256; bh=xxKj4TOvFOZFX6/ej7ZAYlJchHepX4BzMPjaosHHXYA=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1755066860; v=1;
 b=pF9xoB8++h+GL+9IXZ3dWx7BMkdtvzOuCBwlZrMQs582bgCYbyX4Ybb1ccqzAH0AQItWWSF7
 SdcmSKh++TN9evSA1uSm0KPKZkLXWA6emqDemxbm/LnFr2+90VwTIpcjeAvJx2qFyMX+QL1UQGK
 JduOJkMKR2re9b2V8CfV5XJOuYjBZXxjprQJW0Yq274aljiJK63agzTHSEKTQZ7dFNP2H1EoGyF
 0OCXGVjO3C+96K938bL6kH4bqfrPiOHAwT7Qu9SixzaOY4Pw4QEbYALCoZ/GaFr09An83hCJ6Si
 yKOfQqYRRvmcQaqs+pBLTC2a+kvsZmKS4C2Vj3YXjM5qw==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id AC34C22F05;
 Wed, 13 Aug 2025 06:34:20 +0000 (UTC)
From: ~myrslint <myrslint@git.sr.ht>
Date: Wed, 13 Aug 2025 06:23:24 +0000
Subject: [PATCH qemu 1/1] Default disable ignore guest PAT quirk
Message-ID: <175506686028.15648.7602021948044277748-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <175506686028.15648.7602021948044277748-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 13 Aug 2025 08:09:32 -0400
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
Reply-To: ~myrslint <myrskylintu@proton.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: myrslint <qemu.haziness801@passinbox.com>

Addresses this issue: https://gitlab.com/qemu-project/qemu/-/issues/2943

Most Intel CPUs in current use have self-snoop. The few added lines of
code also check for availability of the quirk disablement option so if
some CPU does not have this feature no change of behavior will occur.
---
 accel/kvm/kvm-all.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 890d5ea9f8..c3d06ae2f8 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2682,6 +2682,32 @@ static int kvm_init(AccelState *as, MachineState *ms)
 
     s->vmfd = ret;
 
+/* if target platform has no notion of this or kernel version does
+ * not have it there is no use for compiling this in */
+#ifdef KVM_X86_QUIRK_IGNORE_GUEST_PAT
+    /* first check for modifiable quirks bitmask */
+    ret = kvm_check_extension(s, KVM_CAP_DISABLE_QUIRKS2);
+    /* next make sure disabling it is allowed */
+    if (ret & KVM_X86_QUIRK_IGNORE_GUEST_PAT) {
+        struct kvm_enable_cap *cap;
+        cap = calloc(1, sizeof(struct kvm_enable_cap));
+        if (cap) {
+            cap->cap = KVM_CAP_DISABLE_QUIRKS2;
+            cap->args[0] = KVM_X86_QUIRK_IGNORE_GUEST_PAT;
+            /* if intel cpu does not support self-snoop this is a nop */
+            ret = kvm_vm_ioctl(s, KVM_ENABLE_CAP, cap);
+            if (ret < 0) {
+                error_printf("KVM_X86_QUIRK_IGNORE_GUEST_PAT available and "
+                             "modifiable but we failed to disable it\n");
+            }
+            free(cap);
+        } else {
+            error_printf("KVM_X86_QUIRK_IGNORE_GUEST_PAT: could not "
+                         "allocate memory\n");
+        }
+    }
+#endif
+
     s->nr_as = kvm_vm_check_extension(s, KVM_CAP_MULTI_ADDRESS_SPACE);
     if (s->nr_as <= 1) {
         s->nr_as = 1;
-- 
2.49.1

