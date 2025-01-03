Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1BFE77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 14:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTit8-0002Pt-Ts; Fri, 03 Jan 2025 09:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTit7-0002PD-7U
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:42:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTit5-0007EQ-FA
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 09:42:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735915374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dterKSE+q8F54u5sY5Fg8uLUYCkU0g8z1BZ5paBrCCw=;
 b=cdpJ/qakiFI08lxnLMioTnrUSPftRjtg3iRuLSQ8CROZfpKf2M4hHusXgoERyRfHe+ersS
 J5IHU4Hy9FJ3aNrsUOap8TQRfpZcF7qoPPvpIxYB4JW3GDG39H49GbAaqWQAvTXRlhC9sE
 lg/WG9/4zx8ANBiYZgKb/a8y8prgV0c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-G7zaNo8nNw2T6bd5zSISNQ-1; Fri,
 03 Jan 2025 09:42:51 -0500
X-MC-Unique: G7zaNo8nNw2T6bd5zSISNQ-1
X-Mimecast-MFC-AGG-ID: G7zaNo8nNw2T6bd5zSISNQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5263719560AA; Fri,  3 Jan 2025 14:42:50 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.148])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A5CF1300F9B5; Fri,  3 Jan 2025 14:42:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH 04/10] hw/s390x: Remove the "ri_allowed" switch
Date: Fri,  3 Jan 2025 15:42:26 +0100
Message-ID: <20250103144232.520383-5-thuth@redhat.com>
In-Reply-To: <20250103144232.520383-1-thuth@redhat.com>
References: <20250103144232.520383-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=ham autolearn_force=no
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

Only s390-ccw-virtio-2.6 and older used to set this switch to "off",
for newer machine types it is always enabled. Since we removed the
old machine types now, we can also remove the switch in the code and
assume that it is always enabled now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/s390x/s390-virtio-ccw.h |  3 ---
 hw/s390x/s390-virtio-ccw.c         | 14 ++++----------
 target/s390x/kvm/kvm.c             |  6 ++----
 3 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index 599740a998..4559dbf1bd 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -53,14 +53,11 @@ struct S390CcwMachineClass {
     MachineClass parent_class;
 
     /*< public >*/
-    bool ri_allowed;
     bool cpu_model_allowed;
     bool hpage_1m_allowed;
     int max_threads;
 };
 
-/* runtime-instrumentation allowed by the machine */
-bool ri_allowed(void);
 /* cpu model allowed by the machine */
 bool cpu_model_allowed(void);
 /* 1M huge page mappings allowed by the machine */
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 341430a101..ffeee2da48 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -725,10 +725,10 @@ static S390CcwMachineClass *current_mc;
  * various "*_allowed" variables are enabled, so that the *_allowed() wrappers
  * below return the correct default value for the "none" machine.
  *
- * Attention! Do *not* add additional new wrappers for CPU features (e.g. like
- * the ri_allowed() wrapper) via this mechanism anymore. CPU features should
- * be handled via the CPU models, i.e. checking with cpu_model_allowed() during
- * CPU initialization and s390_has_feat() later should be sufficient.
+ * Attention! Do *not* add additional new wrappers for CPU features via this
+ * mechanism anymore. CPU features should be handled via the CPU models,
+ * i.e. checking with cpu_model_allowed() during CPU initialization and
+ * s390_has_feat() later should be sufficient.
  */
 static S390CcwMachineClass *get_machine_class(void)
 {
@@ -744,11 +744,6 @@ static S390CcwMachineClass *get_machine_class(void)
     return current_mc;
 }
 
-bool ri_allowed(void)
-{
-    return get_machine_class()->ri_allowed;
-}
-
 bool cpu_model_allowed(void)
 {
     return get_machine_class()->cpu_model_allowed;
@@ -791,7 +786,6 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
     S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
 
-    s390mc->ri_allowed = true;
     s390mc->cpu_model_allowed = true;
     s390mc->hpage_1m_allowed = true;
     s390mc->max_threads = 1;
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index db645a4813..540b474398 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -374,10 +374,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     kvm_vm_enable_cap(s, KVM_CAP_S390_VECTOR_REGISTERS, 0);
     kvm_vm_enable_cap(s, KVM_CAP_S390_USER_STSI, 0);
     kvm_vm_enable_cap(s, KVM_CAP_S390_CPU_TOPOLOGY, 0);
-    if (ri_allowed()) {
-        if (kvm_vm_enable_cap(s, KVM_CAP_S390_RI, 0) == 0) {
-            cap_ri = 1;
-        }
+    if (kvm_vm_enable_cap(s, KVM_CAP_S390_RI, 0) == 0) {
+        cap_ri = 1;
     }
     if (cpu_model_allowed()) {
         kvm_vm_enable_cap(s, KVM_CAP_S390_GS, 0);
-- 
2.47.1


