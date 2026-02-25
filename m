Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728CFF55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5uq-0007GQ-EM; Tue, 24 Feb 2026 22:50:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5un-0007Ff-OQ
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:50:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5ul-00085F-St
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:50:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p3brC6j5MVPRsa373EQ1kn7FdyUiGI8z9lGD92Jf5HY=;
 b=KJry5Z+dlF+mpN2oLu1FKJBbr28NyeCdr6HxELyuTTcmkXYy+0JUWFz2B7OXtZeHrRhGId
 J8ofV+vONoyPbc11UWC9y1HuUc1IbwW76zXg92dS9XaPA0fUK6NAIsThVqeo7GT48i7KC0
 sZN6En0c+keYcZgsFHLXY9LoSOcbQgo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-miF5CL9mNDWqtszycfR2GQ-1; Tue, 24 Feb 2026 22:50:17 -0500
X-MC-Unique: miF5CL9mNDWqtszycfR2GQ-1
X-Mimecast-MFC-AGG-ID: miF5CL9mNDWqtszycfR2GQ_1771991416
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3562171b56dso6732854a91.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991416; x=1772596216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p3brC6j5MVPRsa373EQ1kn7FdyUiGI8z9lGD92Jf5HY=;
 b=Bcwml6j1ss4e+Ui1d5LNiHP+rL5Ae5aI7HtwpxILW4ghMaJRhZVwvIGbb2FmGcpVpr
 KIpPfqbmIglkJJVZHWebmM70YFBNZVib+tz1dp1QU11U0LqiRcpo+T2Py0HXu/bsNA5f
 AlNR4/KVSZEfjllxQ1oq2gRuVEYV2f5q1Pq6y49iOT671HezXOAo9Ynt0cnDugaqcGDF
 bPFmkdh85yXEtb2ij1eO+LV6dHJpIMrAAS5Mk9RUSgp5egj5snsdIvkfvzFfBiCGY+dS
 kChOdXjkBwn7TnIcIrtNNPL1/9QQTcGeKpk53zyEndcwK/hspKzNc01+lUda9T9XILrC
 Ib2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991416; x=1772596216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p3brC6j5MVPRsa373EQ1kn7FdyUiGI8z9lGD92Jf5HY=;
 b=KmpFbz9ikvpghN/rurE8Vkvaj23yWOcQrrXPTnrxrHlQz9HC2NaY3biXtefa80vuSu
 H+ZN2BiULd3J7ZfQygEtaG3yxCV5+vM4L7RQ5MfvMwAPV8n6SqQJ50O9Je5Pb/uWgt4X
 AbN1xFWxj2VLq2+wJLfuFOkvRHF/iijqFovGN8dhGK4vN3jWONAP3FFrRfUc0myrno1Z
 OfjSGIrf1R57Qg3avTMczpoAkofV5KcosNnB2FMH22sRIoFvd1dtXFfiphnBsjYY1cBA
 tUrwuPRDa54zYaOQGj39L79CNeFkSDSdxx7wFwUUk7c/kgQs5/3Wlq8efHo7O48nz1Bu
 PN7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW3iLVp5WUcFsASO80aCFWGMmCRjwSq/bNp4r8ADO+FCZq8VSiWhd6UO9FlfNuTV/CkJETwA6w8W3x@nongnu.org
X-Gm-Message-State: AOJu0YzlXysKNZB+fEt01vvaC/sw24OY5mpeKSXgBEaGCS/wTklVo2sH
 +J2bIjH/I6HwODOVni6QC40G497GbpjR/JxtCjsEAzTXetKQ8Y7YR7bDmnx4AyxPHPLvix0xFSg
 VxhMzRSjZdcfVEeYhJbez6G8YtDUA0CBusOyNrCENg/Jp1N3TfVF72pxm
X-Gm-Gg: ATEYQzz9q8grYsaWMNPejIdOvpZiJTEnQIT1asrN1DnkkSpYymCvfFjyWGjpfnFU4Nf
 KgMXGY+XhkMvYMngUOsVEf+HpGWgLapMHM5kx0jTCUXWgwcHk9tFO9DNsW4pYpbZcieLMrQfK7h
 Ut+XwneRA/wdRzMYg0/P9KnDf+bzUBquUdmffBSiAV1v1Eu1UXrzBcw44KjnfEEg12Xnsqzu9hK
 x3BmQLTEA3DDfgsRfndi60YJ1G/aY0BReElil1KCJfbZ0ppHtmmiKDeSEWsi8lBT9B+r75gLSbs
 eTpBcuZ/rbspuyo4snUGzSWj9HHtuTRMJDHpear9RU46KV1W3Gh/Ec+7loy98LFqBzIs+/woqEf
 L/1BBSg3FMpgeF0snprlNGgomMO4Fl4k+D2ROf9zmDT9rnR1Tvg8hrn8=
X-Received: by 2002:a17:90b:2d43:b0:353:f7b:6d60 with SMTP id
 98e67ed59e1d1-358ae8d5b49mr12678330a91.33.1771991416078; 
 Tue, 24 Feb 2026 19:50:16 -0800 (PST)
X-Received: by 2002:a17:90b:2d43:b0:353:f7b:6d60 with SMTP id
 98e67ed59e1d1-358ae8d5b49mr12678308a91.33.1771991415673; 
 Tue, 24 Feb 2026 19:50:15 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:50:15 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, ani@anisinha.ca,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v6 02/35] accel/kvm: add confidential class member to indicate
 guest rebuild capability
Date: Wed, 25 Feb 2026 09:19:07 +0530
Message-ID: <20260225035000.385950-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260225035000.385950-1-anisinha@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


