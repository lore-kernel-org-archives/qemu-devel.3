Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A90C49EA1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 03:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scGfu-0000LJ-Oo; Thu, 08 Aug 2024 23:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1scGfs-0000IN-SV
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 23:52:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1scGfr-0008Nb-Ac
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 23:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723175538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2AeWFZCvD7CvNJ/ZvI9w2LvYCblDhjQWUa7D+ed8/uk=;
 b=bGOjALr6ZFxqdySh58myFQgKCJk1U0H23kGJtcoP9h+uNzU+L/zvHD9HCWxz8GAXz/dzh5
 ndGt7zSwNlfJwSftes3IJPKHAf1MycPpcAVsFlvTaHdx0v4QxK073MRClQnQNY6TnYUylt
 iWyxD76Yyun9iS6oqxWTeKAHVXp8ZZ4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-AIzfSzm4OEKAxVN0FmFz1g-1; Thu,
 08 Aug 2024 23:52:14 -0400
X-MC-Unique: AIzfSzm4OEKAxVN0FmFz1g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 153211944B24; Fri,  9 Aug 2024 03:52:13 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.133])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 745921945109; Fri,  9 Aug 2024 03:52:08 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 philmd@linaro.org, richard.henderson@linaro.org, shan.gavin@gmail.com
Subject: [PATCH 3/4] hw/arm/virt: Use kvm_arch_get_default_type()
Date: Fri,  9 Aug 2024 13:51:32 +1000
Message-ID: <20240809035134.699830-4-gshan@redhat.com>
In-Reply-To: <20240809035134.699830-1-gshan@redhat.com>
References: <20240809035134.699830-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

kvm_arch_get_default_type() and kvm_arm_get_max_vm_ipa_size() are
interchangeable since the type is equivalent to IPA size (bits)
with one exception that IPA size (bits) is 40 when the type is zero.

Replace kvm_arm_get_max_vm_ipa_size() with kvm_arch_get_default_type().
After this, kvm_arm_get_max_vm_ipa_size() needn't to be a public API
any more.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 hw/arm/virt.c        | 14 ++++++--------
 target/arm/kvm.c     |  2 +-
 target/arm/kvm_arm.h | 15 ---------------
 3 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 09b7a158a9..f35857aa95 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2995,10 +2995,12 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
 static int virt_kvm_type(MachineState *ms, const char *type_str)
 {
     VirtMachineState *vms = VIRT_MACHINE(ms);
-    int max_vm_pa_size, requested_pa_size;
+    int type, max_vm_pa_size, requested_pa_size;
     bool fixed_ipa;
 
-    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa);
+    /* The IPA size is 40 bits when the type is zero */
+    type = kvm_arch_get_default_type(ms);
+    max_vm_pa_size = (type == 0) ? 40 : type;
 
     /* we freeze the memory map to compute the highest gpa */
     virt_set_memmap(vms, max_vm_pa_size);
@@ -3017,12 +3019,8 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
                      requested_pa_size, max_vm_pa_size);
         return -1;
     }
-    /*
-     * We return the requested PA log size, unless KVM only supports
-     * the implicit legacy 40b IPA setting, in which case the kvm_type
-     * must be 0.
-     */
-    return fixed_ipa ? 0 : requested_pa_size;
+
+    return type;
 }
 #endif /* CONFIG_KVM */
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 849e2e21b3..65893c9c12 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -526,7 +526,7 @@ bool kvm_arm_pmu_supported(void)
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3);
 }
 
-int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa)
+static int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa)
 {
     KVMState *s = KVM_STATE(ms->accelerator);
     int ret;
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index cfaa0d9bc7..fd919d4738 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -188,16 +188,6 @@ bool kvm_arm_pmu_supported(void);
  */
 bool kvm_arm_sve_supported(void);
 
-/**
- * kvm_arm_get_max_vm_ipa_size:
- * @ms: Machine state handle
- * @fixed_ipa: True when the IPA limit is fixed at 40. This is the case
- * for legacy KVM.
- *
- * Returns the number of bits in the IPA address space supported by KVM
- */
-int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa);
-
 int kvm_arm_vgic_probe(void);
 
 void kvm_arm_pmu_init(ARMCPU *cpu);
@@ -248,11 +238,6 @@ static inline void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
     g_assert_not_reached();
 }
 
-static inline int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa)
-{
-    g_assert_not_reached();
-}
-
 static inline int kvm_arm_vgic_probe(void)
 {
     g_assert_not_reached();
-- 
2.45.2


