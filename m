Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3159BC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnV-0006P8-5f; Tue, 23 Apr 2024 11:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHnD-0004l2-5o
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHn8-0000IN-6a
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LK3Tt4fxjBATwESiJASWlgkKjSb09teThwlk01K8ooM=;
 b=iOC7C98vtq4qi3ayuWBlLY0soIf1tl3ykfB5uFQQiUlK1VFlY0L6+xQAJE9mhj5js73LFS
 I79CLWlh/W5Zyhzn3uHxHe5uFbACpI/9VxN6F2W76sy0Jl4BZpuv4sQiM2Mru8Z7lStbL7
 G8rRNHIRvu07J4nJt3ks7q7z8m00gIc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-O_5l-mlIPlaAWBhA0ymV6w-1; Tue, 23 Apr 2024 11:10:38 -0400
X-MC-Unique: O_5l-mlIPlaAWBhA0ymV6w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F34A181F317;
 Tue, 23 Apr 2024 15:10:37 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A2E72033979;
 Tue, 23 Apr 2024 15:10:37 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>
Subject: [PULL 45/63] i386/sev: Add 'legacy-vm-type' parameter for SEV guest
 objects
Date: Tue, 23 Apr 2024 17:09:33 +0200
Message-ID: <20240423150951.41600-46-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

From: Michael Roth <michael.roth@amd.com>

QEMU will currently automatically make use of the KVM_SEV_INIT2 API for
initializing SEV and SEV-ES guests verses the older
KVM_SEV_INIT/KVM_SEV_ES_INIT interfaces.

However, the older interfaces will silently avoid sync'ing FPU/XSAVE
state to the VMSA prior to encryption, thus relying on behavior and
measurements that assume the related fields to be allow zero.

With KVM_SEV_INIT2, this state is now synced into the VMSA, resulting in
measurements changes and, theoretically, behaviorial changes, though the
latter are unlikely to be seen in practice.

To allow a smooth transition to the newer interface, while still
providing a mechanism to maintain backward compatibility with VMs
created using the older interfaces, provide a new command-line
parameter:

  -object sev-guest,legacy-vm-type=true,...

and have it default to false.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Message-ID: <20240409230743.962513-2-michael.roth@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi/qom.json     | 11 ++++++++++-
 target/i386/sev.c | 18 +++++++++++++++++-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 85e6b4f84a2..38dde6d785a 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -898,6 +898,14 @@
 #     designated guest firmware page for measured boot with -kernel
 #     (default: false) (since 6.2)
 #
+# @legacy-vm-type: Use legacy KVM_SEV_INIT KVM interface for creating the VM.
+#                  The newer KVM_SEV_INIT2 interface syncs additional vCPU
+#                  state when initializing the VMSA structures, which will
+#                  result in a different guest measurement. Set this to
+#                  maintain compatibility with older QEMU or kernel versions
+#                  that rely on legacy KVM_SEV_INIT behavior.
+#                  (default: false) (since 9.1)
+#
 # Since: 2.12
 ##
 { 'struct': 'SevGuestProperties',
@@ -908,7 +916,8 @@
             '*handle': 'uint32',
             '*cbitpos': 'uint32',
             'reduced-phys-bits': 'uint32',
-            '*kernel-hashes': 'bool' } }
+            '*kernel-hashes': 'bool',
+            '*legacy-vm-type': 'bool' } }
 
 ##
 # @ThreadContextProperties:
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 9dab4060b84..f4ee317cb03 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -67,6 +67,7 @@ struct SevGuestState {
     uint32_t cbitpos;
     uint32_t reduced_phys_bits;
     bool kernel_hashes;
+    bool legacy_vm_type;
 
     /* runtime state */
     uint32_t handle;
@@ -356,6 +357,16 @@ static void sev_guest_set_kernel_hashes(Object *obj, bool value, Error **errp)
     sev->kernel_hashes = value;
 }
 
+static bool sev_guest_get_legacy_vm_type(Object *obj, Error **errp)
+{
+    return SEV_GUEST(obj)->legacy_vm_type;
+}
+
+static void sev_guest_set_legacy_vm_type(Object *obj, bool value, Error **errp)
+{
+    SEV_GUEST(obj)->legacy_vm_type = value;
+}
+
 bool
 sev_enabled(void)
 {
@@ -863,7 +874,7 @@ static int sev_kvm_type(X86ConfidentialGuest *cg)
     }
 
     kvm_type = (sev->policy & SEV_POLICY_ES) ? KVM_X86_SEV_ES_VM : KVM_X86_SEV_VM;
-    if (kvm_is_vm_type_supported(kvm_type)) {
+    if (kvm_is_vm_type_supported(kvm_type) && !sev->legacy_vm_type) {
         sev->kvm_type = kvm_type;
     } else {
         sev->kvm_type = KVM_X86_DEFAULT_VM;
@@ -1381,6 +1392,11 @@ sev_guest_class_init(ObjectClass *oc, void *data)
                                    sev_guest_set_kernel_hashes);
     object_class_property_set_description(oc, "kernel-hashes",
             "add kernel hashes to guest firmware for measured Linux boot");
+    object_class_property_add_bool(oc, "legacy-vm-type",
+                                   sev_guest_get_legacy_vm_type,
+                                   sev_guest_set_legacy_vm_type);
+    object_class_property_set_description(oc, "legacy-vm-type",
+            "use legacy VM type to maintain measurement compatibility with older QEMU or kernel versions.");
 }
 
 static void
-- 
2.44.0



