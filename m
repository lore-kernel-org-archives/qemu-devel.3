Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EED8D25932
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 05:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkbRV-0006gI-Py; Tue, 27 Jan 2026 00:16:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbRU-0006fz-8O
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:16:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vkbRS-0008IQ-HG
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 00:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769491001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0tIs2fKBt+d90Z4wFAen2VAZ4+rhynD1uhYc/rJjp5c=;
 b=K6mlr33h61Ec6SNLk4uDqKpXXGo3IJl04nkOkWCm0u+WA+Am6nQUbqkUHY29ZINfn7i1wN
 0OrlvSJvrJTpK6MV//WScZgbKxwJoBPyX9vwWbQe2DQTTvVmFvZk1BoRsv+euKgvj0n/jZ
 3oG7f4hEcAeqMU5NH8fEQbQYn9fSdGs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-wBoGqB6KMp6QR6WjWP1Jug-1; Tue, 27 Jan 2026 00:16:39 -0500
X-MC-Unique: wBoGqB6KMp6QR6WjWP1Jug-1
X-Mimecast-MFC-AGG-ID: wBoGqB6KMp6QR6WjWP1Jug_1769490999
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-34c93f0849dso4944055a91.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 21:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769490998; x=1770095798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0tIs2fKBt+d90Z4wFAen2VAZ4+rhynD1uhYc/rJjp5c=;
 b=jTsYabOemOaObdEokNNx+OTkar2LrB+T0gUJS3OTQiHAVm4ezPuEoXpPDWGsdFvA0H
 0vcXis0F8314up2NOAgRiG5khC9CU3DTtoxUontA8FMTyWvtPDmCGaBsvmvGtpNtk+eV
 sBtB92juuGz/o+UQcJ1iPvpztagb3oNr9gEGHFUH0DbWOaBaEZ6abc+8izRhZsuBnBLq
 oaU4dSZfKVj+mSa5oZzrFufvJGAwItu2WuTlkRtXY5oHFmmlOg4X0w80tWdlQ6jSFe4r
 dz3h3Q6rl8JjGxWMXJjf7kgnlYSMX6BAgdaIezAk+6Bz6EioVvfxHY8vkrlNQkFCGIqJ
 AkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769490998; x=1770095798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0tIs2fKBt+d90Z4wFAen2VAZ4+rhynD1uhYc/rJjp5c=;
 b=d1WZkQw8aqVzb3QRIPxGhYhSbBuH9g9S5uFYoy2DCmC+N6vArx9JDJZIOq9srjkqgI
 qcQFI8ck1pxbh6rIWZwzlGrWspt1JUjXdSkkWRs9LHmsuvjmWM8UoTXKxDJDEnLO1lAG
 YFr0fuLYSHw1MymmfdrsMsPHGbRY2wGIGlQ2DlVWd/9Y9D8dyP4bZf8FiZZjx126wi5E
 GB7Kao7jgb4WoUTMB1L/xArbnszElACMhleg2CgWDxlBEoEM6XuVLw6K05rVFNQWhAt9
 CJuqTkahrA+6l21dJUb5I/FfcA2r0mpGXIotk1x33wyNS2fIRBC7vEpw/TH3NPAbHJCv
 VB5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhw9Wm7Acqwq4bQ+0RqNARc8xX9JBNP0qJYPD5UDENI4Hh2Fx9suACeNkoi67A6v+8itypLLCuKZ3T@nongnu.org
X-Gm-Message-State: AOJu0Yx7wVNt0CbGef8RJyTho9S8EPn6gaAxK8FRObkSzzOqwkMgMsmt
 sWd/tP5QWubSKsENkQqGuOlJ1becGGuN39G5b4lXmky/TyZOx5X/dtdIONYtd6m3IqAYFQzsE9G
 XyzVhOpiu25LlsA1SSuXUMk809bHiKhXEoBLdaxmmf34C5pV81uw58S8CY7Gb3lAJ
X-Gm-Gg: AZuq6aIP6Sp6nGjqcaKpnpnQ6pbQrGa6WBLyU63ncBk6o0zqbbHNXWlvYZbO30GwRng
 7jtyE4Sl2BMdc7AlGJCttCBgTAA9u4SAtlm5VkDFXynCyWixEhYA/W4NZ/Wit9QyooAqOMa1K1X
 JmPVE3McZrulWEreNs3mBBVPAHGYgNHbqPC6NU/y+PgPOJpSinCZEN76a9xYBANhGULrn1OU2QR
 bR2wn0aPwZx3buImyVnduKaO6K7+Nsm7OB+OyFhDRRzd3HRhD5MoUyS6qcvk7eol1ecKz/wMQga
 cpzCgyTHsJwNoK9AF9+1RnpLf3yGHY+4E1ZjZqXQPirsiBMQgYdusxrl+/eItoNljsv842KPfYW
 4wLJf4mQwW8M5s2FM40+X7y4MzTW9WC43jrBSQf5isg==
X-Received: by 2002:a17:90a:d648:b0:34c:2e8a:ea42 with SMTP id
 98e67ed59e1d1-353ffa55bb1mr523360a91.7.1769490998605; 
 Mon, 26 Jan 2026 21:16:38 -0800 (PST)
X-Received: by 2002:a17:90a:d648:b0:34c:2e8a:ea42 with SMTP id
 98e67ed59e1d1-353ffa55bb1mr523343a91.7.1769490998206; 
 Mon, 26 Jan 2026 21:16:38 -0800 (PST)
Received: from rhel9-box.lan ([122.163.48.79])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-353f6230d5dsm1110925a91.17.2026.01.26.21.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 21:16:37 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: [PATCH v3 02/33] accel/kvm: add confidential class member to indicate
 guest rebuild capability
Date: Tue, 27 Jan 2026 10:45:30 +0530
Message-ID: <20260127051612.219475-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260127051612.219475-1-anisinha@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 1d70f96ec1..176329bd07 100644
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


