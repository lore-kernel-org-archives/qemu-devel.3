Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0475EE9A049
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfxp-0003Hb-ID; Wed, 18 Feb 2026 06:43:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxa-00038H-3X
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfxP-0007nU-1N
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771414979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p3brC6j5MVPRsa373EQ1kn7FdyUiGI8z9lGD92Jf5HY=;
 b=I8r7EEGhWJ6WHL1kiAuj2c1XJO24RQHebfth62t4BFUFGK2RJ6iEVwwWskz9NInWS4eMDT
 pn1NlnLtZ+ZwxLKke1YQ8TOcq0cE+MLJ3X7OAgJIOgsQTrGViKwxLIkFD3sy6DvlE78Hqy
 kfasZJcwsApoKnOizy/vBZ5hj3Oivcs=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-yWDi5JaeMdqrNFKMvACZEw-1; Wed, 18 Feb 2026 06:42:55 -0500
X-MC-Unique: yWDi5JaeMdqrNFKMvACZEw-1
X-Mimecast-MFC-AGG-ID: yWDi5JaeMdqrNFKMvACZEw_1771414973
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2aae0d40a47so261358055ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771414973; x=1772019773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p3brC6j5MVPRsa373EQ1kn7FdyUiGI8z9lGD92Jf5HY=;
 b=IteESUMtUnMKTpgzkt5H5pq3e9OUm7MMk0uqXKHGIOLCSD6uunE0Pr2hJimhIDBzI8
 iz+iw88GhXGGGZvEHYK7cEjLVWsplmAs+n1DF51yOjgk+cvW3bJ0UtrfqSQVdIYThFQ0
 kmFrLC9ls/ijt6wWB2BVkAWPKYvnYnJbkk2yDVHGVXIycdtUGW5v1FEicX5gIslCzr9C
 QBlwQk8lYYcfmykUsNw2j5qhsu9mi44gtNllRF2hGnJtXiuD0rzpV1puItbaXOomQEJi
 7UToI02vuE+BZ/GyaKjI61lNYlysfcpNtUuTNvpBMNsX0GhCWMPIel3yDZWEeFtpg6nS
 vhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771414973; x=1772019773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p3brC6j5MVPRsa373EQ1kn7FdyUiGI8z9lGD92Jf5HY=;
 b=pKQoJ+dQSqimJnAnV+UaEE2bgThAHLh4TfQW1nFaaaApjBToGwqi7+7u6HKSRXFkl/
 qZ0n03kix7mE1BP5i5uDyBaSNIy9J/Lw51MgYXlIWXb0qcYpPiy7Zwh0q50n7cEx+aw/
 1ovwRwTg8c650rm7WMBNWUTIdRfEJJBRoq3ZIHzCTwo3Ty6fj9Esi4VWxVpg++V2P3sf
 ripsep8ZJkJEOONaJCkJd9kNn8zWICiiky6J7ng/UGmzYAk9u+uQutsZQYmZxhYO4YQF
 1zK/Gshwhtzb2Y96hCMVi9Tm8btcSX0iAs/43m1lnVYkn3oPncFgyBj/G/sLDvT8ZCZK
 8NIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAzDHT0VNaT2n+BsMIN9oCtqAxb87D/Wl4Zi+jjRMVY2MWrLhuEQbzL0aJt/xA/AcfnMzp2fEn+HxQ@nongnu.org
X-Gm-Message-State: AOJu0YwI4x5qRxflYcQ6dzwuDSW1GDtAedc2EymVcmWmIXvb0nA3Lvs/
 wKUbMIYALmjqxJTW7pfBZ55ENuXCGeX6k2pkwJmSYEkHA3HuQYLRiIV5RAfw/z0xRRsojRtb+AO
 1sOaeiei1rWIW8N5oRF6uh7EWAQ0bvEzTKFdzQ1mxmgsNbwVGr9qqBQ4U
X-Gm-Gg: AZuq6aJnp2+rJUVsXm7vyZv3GstsE2lIIGRyCplUTTfgwQUoCsUfRLoyFEyX0VAmK0q
 v+6TPd1zvuvhgtilSX91QDnmfv2+dEFVO5drHA1T2vV1T893NBHo/dOl0Nya+LSkm3FhJSORaqW
 JFjaB8cE++RMRIg/r0Qku2h8MIKXp1bB/fbfJSfkYP7zRysx1jFoJHsK5Rw/nf7HrRQlhIOBoXx
 fgDXcBaR2kddlY0b50PDD1OJgym2nsI56eOnCiZaCRA27Mo1vgobUTgkSeZL7AfHWFCp1MoSiyw
 C/awuMZRzOU6iu4g71oaMq4y2NRBGrfYMctRADpOrYZMWW811xiFtrMOA3asi44p0egW7X5zXiq
 QhQ9FA98zyWJhLafSv8MBW+4Hp3LJk8jKEtuR11xnrzMdW11wAy3A
X-Received: by 2002:a17:903:1b67:b0:2a0:c35c:572e with SMTP id
 d9443c01a7336-2ad17501af0mr153308255ad.30.1771414972857; 
 Wed, 18 Feb 2026 03:42:52 -0800 (PST)
X-Received: by 2002:a17:903:1b67:b0:2a0:c35c:572e with SMTP id
 d9443c01a7336-2ad17501af0mr153308155ad.30.1771414972496; 
 Wed, 18 Feb 2026 03:42:52 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:42:52 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: [PATCH v5 02/34] accel/kvm: add confidential class member to indicate
 guest rebuild capability
Date: Wed, 18 Feb 2026 17:11:55 +0530
Message-ID: <20260218114233.266178-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260218114233.266178-1-anisinha@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

As a part of the confidential guest reset process, the existing encrypted guest
state must be made mutable since it would be discarded after reset. A new
encrypted and locked guest state must be established after the reset. To this
end, a new boolean member per confidential guest support class
(eg, tdx or sev-snp) is added that will indicate whether its possible to
rebuild guest state:

bool can_rebuild_guest_state;

This is true if rebuilding guest state is possible, false otherwise.
A KVM based confidential guest reset is only possible when
the existing state is locked but its possible to rebuild guest state.
Otherwise, the guest is not resettable.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 include/system/confidential-guest-support.h | 20 ++++++++++++++++++++
 system/runstate.c                           |  6 +++---
 target/i386/kvm/tdx.c                       |  1 +
 target/i386/sev.c                           |  1 +
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/system/confidential-guest-support.h b/include/system/confidential-guest-support.h
index 0cc8b26e64..5dca717308 100644
--- a/include/system/confidential-guest-support.h
+++ b/include/system/confidential-guest-support.h
@@ -152,6 +152,11 @@ typedef struct ConfidentialGuestSupportClass {
      */
     int (*get_mem_map_entry)(int index, ConfidentialGuestMemoryMapEntry *entry,
                              Error **errp);
+
+    /*
+     * is it possible to rebuild the guest state?
+     */
+    bool can_rebuild_guest_state;
 } ConfidentialGuestSupportClass;
 
 static inline int confidential_guest_kvm_init(ConfidentialGuestSupport *cgs,
@@ -167,6 +172,21 @@ static inline int confidential_guest_kvm_init(ConfidentialGuestSupport *cgs,
     return 0;
 }
 
+static inline bool
+confidential_guest_can_rebuild_state(ConfidentialGuestSupport *cgs)
+{
+    ConfidentialGuestSupportClass *klass;
+
+    if (!cgs) {
+        /* non-confidential guests */
+        return true;
+    }
+
+    klass = CONFIDENTIAL_GUEST_SUPPORT_GET_CLASS(cgs);
+    return klass->can_rebuild_guest_state;
+
+}
+
 static inline int confidential_guest_kvm_reset(ConfidentialGuestSupport *cgs,
                                                Error **errp)
 {
diff --git a/system/runstate.c b/system/runstate.c
index d091a2bddd..13f32bed8c 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -57,6 +57,7 @@
 #include "system/reset.h"
 #include "system/runstate.h"
 #include "system/runstate-action.h"
+#include "system/confidential-guest-support.h"
 #include "system/system.h"
 #include "system/tpm.h"
 #include "trace.h"
@@ -543,8 +544,6 @@ void qemu_system_reset(ShutdownCause reason)
      */
     if (cpus_are_resettable()) {
         cpu_synchronize_all_post_reset();
-    } else {
-        assert(runstate_check(RUN_STATE_PRELAUNCH));
     }
 
     vm_set_suspended(false);
@@ -697,7 +696,8 @@ void qemu_system_reset_request(ShutdownCause reason)
     if (reboot_action == REBOOT_ACTION_SHUTDOWN &&
         reason != SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
         shutdown_requested = reason;
-    } else if (!cpus_are_resettable()) {
+    } else if (!cpus_are_resettable() &&
+               !confidential_guest_can_rebuild_state(current_machine->cgs)) {
         error_report("cpus are not resettable, terminating");
         shutdown_requested = reason;
     } else {
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 0161985768..a3e81e1c0c 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1543,6 +1543,7 @@ static void tdx_guest_class_init(ObjectClass *oc, const void *data)
     X86ConfidentialGuestClass *x86_klass = X86_CONFIDENTIAL_GUEST_CLASS(oc);
 
     klass->kvm_init = tdx_kvm_init;
+    klass->can_rebuild_guest_state = true;
     x86_klass->kvm_type = tdx_kvm_type;
     x86_klass->cpu_instance_init = tdx_cpu_instance_init;
     x86_klass->adjust_cpuid_features = tdx_adjust_cpuid_features;
diff --git a/target/i386/sev.c b/target/i386/sev.c
index acdcb9c4e6..66e38ca32e 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2760,6 +2760,7 @@ sev_common_instance_init(Object *obj)
     cgs->set_guest_state = cgs_set_guest_state;
     cgs->get_mem_map_entry = cgs_get_mem_map_entry;
     cgs->set_guest_policy = cgs_set_guest_policy;
+    cgs->can_rebuild_guest_state = true;
 
     QTAILQ_INIT(&sev_common->launch_vmsa);
 }
-- 
2.42.0


