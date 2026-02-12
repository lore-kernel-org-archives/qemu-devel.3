Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736E0EDF04A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQ97-0007ZF-He; Thu, 12 Feb 2026 01:25:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ96-0007Z7-9O
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:25:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ94-0005C8-Mb
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:25:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/1VlHtYGbkfW+qN/OA1sAKbbnZvFUDWI/CtmetDJXqY=;
 b=NVDNfbdGLv5n4A228J1bftSZ8vpsOE8Q9XxQ2FFHeJsRozMrNycA4M2SXD27l2RcP9E7EG
 P5XpINdOF6I2rumFLP4CPU3y8e1Z9FcSZQL7LMSSBUScP8c7UNnn7sylpeXBlVKcKKIcYs
 McULGWZ0BhfQCBSqwwZ3bjZUQQdp57o=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-ckoYampSPv-OEOiFmxXdag-1; Thu, 12 Feb 2026 01:25:43 -0500
X-MC-Unique: ckoYampSPv-OEOiFmxXdag-1
X-Mimecast-MFC-AGG-ID: ckoYampSPv-OEOiFmxXdag_1770877542
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c6e1d32a128so896464a12.3
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877542; x=1771482342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/1VlHtYGbkfW+qN/OA1sAKbbnZvFUDWI/CtmetDJXqY=;
 b=nrGTHCl5a5CY/EgpNNEVuiQGeFo9N3S34c4EoYIbC/B1oYac2fIrxS8uEd3ZjP590s
 ZTMbh8eCU3zoYBy5jrGv+/QmwdC5fd/LGjZc6ufaFXpiG1lGkYJfmLysyE9zruMh39sX
 rXY+ofsofnuMfAGsp4rkS9YGx4c3CKUcxEQKcKaAs5yq2RdEOjkLo/vxTELEi3Eq56Y0
 IALGsxhlqN+lMraucQVrKXC1OHaVzZ8MpbC9tWvBAioM100Kxxy2+NyBf3/eDuZijduP
 HrlTYcbk30SRSC2CTGhmvYtZdmJCeIkgsshLyBegYzyV1g770eRb9e+0oaEizEarcvwC
 l85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877542; x=1771482342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/1VlHtYGbkfW+qN/OA1sAKbbnZvFUDWI/CtmetDJXqY=;
 b=uUgmvHv06sFqugdLaQDw+cQky7DjaUc2JfMfQUVGMGpp83+Ect5dF3flGl09b0lL0x
 KeotMlaUfgpnUlutX/5sI40WTgnFLXnUM2hhU3gI9MlJyIMp6MfwRl4Rhf0308Zzcscm
 1Ce2or9HM7BZujah4GsWVYR4r/wqieXm0v3kOj4xquuaAv7cxYqJxFj2R1dkMmNnGVDl
 cjSr1UF4kJql2TiesQrqUNrg7pLoq++PqqvktcDEWSElynu0I8lz3ERp6jSRXyTMDR1d
 Mla6lGB44BpijLmuJoAS+47WutKbbJgnVdjneK+n4Ov+KWOo9ZOTG0H+VwbXguqIJnui
 oD9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/73iEZMkqNGKIs2D1T1geBMwrim9gAnkMhf47U2W9nz+CyPiT5IkGBGiDI8Sst3WOEuFFrjoWzgoJ@nongnu.org
X-Gm-Message-State: AOJu0Ywxqc5x6cz7YYEH3XOVLBkgaG6JjCp24w4Mei94lHA/4EOuYsnc
 mcQvSEHZr8iabi9CMgM5UF/Vfg6gY8NTLtzwNY3AJ27mFF2enoXGtEvKe84oIXxoVS0ovPkB/qb
 AlzXUGv0MAWXxh4U6n/Qo55vfYrdvNhIyH5PffnmVVee+M0J9Zk7mjhio
X-Gm-Gg: AZuq6aItHlybRipDK69x5saI3OlyS5y3X1PhmmbqmQtl0nMs94fS25OGPhxRJzxlbhY
 dXbceXIY/9hsw4kTgKtboe8IcjrFpl1cX0QBzJw5MY9F1AzXGWyU6ubQF3zDYqKuHb1+X2JUV8t
 A7pg76ZYbXnPUVKyxSQGeW/Tyj/5hK8STg+lW6PKRiDJSLHl1Z9ApgFIHXlDlXRcdKY5CtFygp9
 LY8np5EQG8EnVEzz0bouf1gQxHXGWqVgW4/xAWbuCeLEfhdORatytWFQaeECRmYZtNzxKyQHZJg
 op3WbzP7MpoJK6YPV6+SiJjz9IPeGSsrwjBig9XSFlTpQA2DK7ETHgMEWgXSeMdSCGI8ZUaebmY
 aUBjRmaTtp6Npio8X/LR7BdFZCyj+PuDVT4Vm9pcA59H7vaUVmR8DUfA=
X-Received: by 2002:a05:6a21:3b49:b0:35e:e604:f78b with SMTP id
 adf61e73a8af0-3944845c420mr1507972637.3.1770877542143; 
 Wed, 11 Feb 2026 22:25:42 -0800 (PST)
X-Received: by 2002:a05:6a21:3b49:b0:35e:e604:f78b with SMTP id
 adf61e73a8af0-3944845c420mr1507949637.3.1770877541761; 
 Wed, 11 Feb 2026 22:25:41 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:25:41 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: [PATCH v4 02/31] accel/kvm: add confidential class member to indicate
 guest rebuild capability
Date: Thu, 12 Feb 2026 11:54:46 +0530
Message-ID: <20260212062522.99565-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260212062522.99565-1-anisinha@redhat.com>
References: <20260212062522.99565-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index ed2db56480..5d58260ed5 100644
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
@@ -693,7 +692,8 @@ void qemu_system_reset_request(ShutdownCause reason)
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


