Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCF5C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnS-00068j-Pt; Tue, 23 Apr 2024 11:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHnC-0004kV-UW
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHn7-0000Hp-VU
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8JOqgK6T21wzwgr87RLBCecRIltf/5dHdAu0xkCFNnw=;
 b=K0nwkbhKqq5F3j6ZbXNMdw1kRZvqdHwQYv2cqU4UhDf6m4NQdDs985OMyFS56ojjvY0o61
 z7/+XThC1kbzgRFe9L9oeYbnqbuxaOgpVyYh/Es0Q16Q0N2bUfwwPRNFQY0sDBvCLZdkjG
 qR2/1SEG6SOUbXHEzClw9wvm062eKKk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-N7QJ5teiOgK963udsg0OQQ-1; Tue, 23 Apr 2024 11:10:37 -0400
X-MC-Unique: N7QJ5teiOgK963udsg0OQQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B44B1827109
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:10:37 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BABD9200E290
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 15:10:36 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 44/63] target/i386: SEV: use KVM_SEV_INIT2 if possible
Date: Tue, 23 Apr 2024 17:09:32 +0200
Message-ID: <20240423150951.41600-45-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Implement support for the KVM_X86_SEV_VM and KVM_X86_SEV_ES_VM virtual
machine types, and the KVM_SEV_INIT2 function of KVM_MEMORY_ENCRYPT_OP.

These replace the KVM_SEV_INIT and KVM_SEV_ES_INIT functions, and have
several advantages:

- sharing the initialization sequence with SEV-SNP and TDX

- allowing arguments including the set of desired VMSA features

- protection against invalid use of KVM_GET/SET_* ioctls for guests
  with encrypted state

If the KVM_X86_SEV_VM and KVM_X86_SEV_ES_VM types are not supported,
fall back to KVM_SEV_INIT and KVM_SEV_ES_INIT (which use the
default x86 VM type).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c |  2 ++
 target/i386/sev.c     | 41 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 974586e57a1..a9e93502734 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -164,6 +164,8 @@ static int kvm_get_one_msr(X86CPU *cpu, int index, uint64_t *value);
 
 static const char *vm_type_name[] = {
     [KVM_X86_DEFAULT_VM] = "default",
+    [KVM_X86_SEV_VM] = "SEV",
+    [KVM_X86_SEV_ES_VM] = "SEV-ES",
 };
 
 bool kvm_is_vm_type_supported(int type)
diff --git a/target/i386/sev.c b/target/i386/sev.c
index ebe36d4c10c..9dab4060b84 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -26,6 +26,7 @@
 #include "qemu/error-report.h"
 #include "crypto/hash.h"
 #include "sysemu/kvm.h"
+#include "kvm/kvm_i386.h"
 #include "sev.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/runstate.h"
@@ -56,6 +57,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(SevGuestState, SEV_GUEST)
 struct SevGuestState {
     X86ConfidentialGuest parent_obj;
 
+    int kvm_type;
+
     /* configuration parameters */
     char *sev_device;
     uint32_t policy;
@@ -850,6 +853,26 @@ sev_vm_state_change(void *opaque, bool running, RunState state)
     }
 }
 
+static int sev_kvm_type(X86ConfidentialGuest *cg)
+{
+    SevGuestState *sev = SEV_GUEST(cg);
+    int kvm_type;
+
+    if (sev->kvm_type != -1) {
+        goto out;
+    }
+
+    kvm_type = (sev->policy & SEV_POLICY_ES) ? KVM_X86_SEV_ES_VM : KVM_X86_SEV_VM;
+    if (kvm_is_vm_type_supported(kvm_type)) {
+        sev->kvm_type = kvm_type;
+    } else {
+        sev->kvm_type = KVM_X86_DEFAULT_VM;
+    }
+
+out:
+    return sev->kvm_type;
+}
+
 static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
     SevGuestState *sev = SEV_GUEST(cgs);
@@ -929,13 +952,19 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
                          __func__);
             goto err;
         }
-        cmd = KVM_SEV_ES_INIT;
-    } else {
-        cmd = KVM_SEV_INIT;
     }
 
     trace_kvm_sev_init();
-    ret = sev_ioctl(sev->sev_fd, cmd, NULL, &fw_error);
+    if (sev_kvm_type(X86_CONFIDENTIAL_GUEST(sev)) == KVM_X86_DEFAULT_VM) {
+        cmd = sev_es_enabled() ? KVM_SEV_ES_INIT : KVM_SEV_INIT;
+
+        ret = sev_ioctl(sev->sev_fd, cmd, NULL, &fw_error);
+    } else {
+        struct kvm_sev_init args = { 0 };
+
+        ret = sev_ioctl(sev->sev_fd, KVM_SEV_INIT2, &args, &fw_error);
+    }
+
     if (ret) {
         error_setg(errp, "%s: failed to initialize ret=%d fw_error=%d '%s'",
                    __func__, ret, fw_error, fw_error_to_str(fw_error));
@@ -1327,8 +1356,10 @@ static void
 sev_guest_class_init(ObjectClass *oc, void *data)
 {
     ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
+    X86ConfidentialGuestClass *x86_klass = X86_CONFIDENTIAL_GUEST_CLASS(oc);
 
     klass->kvm_init = sev_kvm_init;
+    x86_klass->kvm_type = sev_kvm_type;
 
     object_class_property_add_str(oc, "sev-device",
                                   sev_guest_get_sev_device,
@@ -1357,6 +1388,8 @@ sev_guest_instance_init(Object *obj)
 {
     SevGuestState *sev = SEV_GUEST(obj);
 
+    sev->kvm_type = -1;
+
     sev->sev_device = g_strdup(DEFAULT_SEV_DEVICE);
     sev->policy = DEFAULT_GUEST_POLICY;
     object_property_add_uint32_ptr(obj, "policy", &sev->policy,
-- 
2.44.0



