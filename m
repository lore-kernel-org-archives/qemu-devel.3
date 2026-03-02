Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A031CD58E7F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyvF-00066I-NU; Mon, 02 Mar 2026 03:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyug-0005Bf-RG
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyuV-0001vS-Li
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HYqjAK7qOdvm/hJDVYV3EiWpflw4secDuvQP3hCMmE0=;
 b=GAGQzH3JNeRsI/D8QApLNjkXW+JtkVUoUf1+XrKA1D0kvwDp/0Gs8c4CFsV/EeGJbsYheW
 MFarMZHS7CE3dK+HAQ2E1lW7KnwC6wX8j07iHm1idw511/WNUJLVdBJzPIuHuV5G2N2YAA
 HPWj9IOvN83jzH9H6qbtUIBYXhVeZeQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-ERlBvC_GOfmL3STi48W5fw-1; Mon, 02 Mar 2026 03:45:38 -0500
X-MC-Unique: ERlBvC_GOfmL3STi48W5fw-1
X-Mimecast-MFC-AGG-ID: ERlBvC_GOfmL3STi48W5fw_1772441137
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4363333c102so2852427f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441136; x=1773045936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HYqjAK7qOdvm/hJDVYV3EiWpflw4secDuvQP3hCMmE0=;
 b=i+P5/wR4ev25C92zkvkWJ1I3O+uecuUp3Q4M9EeopwBD8XDn0TXYOazUJSmYPtI8JG
 v95iAWyYdaQiTBfQQSxXOtTSQ+XOR3n9YWxklQColn8DN7i1QG4nl6BXmusQnQkpCrG4
 RHiXsczL6z6h8rPzwpsdXJs6QV6FFJY/YQchY0BRat3VgrPONrGagu6Ek+dLeXFy3vdz
 0PW0qDAAwgffcbzL2LkUDHspVHidcahuuH88T8QOOBBe+R4yRCgnFfoS5fpTmlllDKIY
 eshXa365PdMt1egaGqM7RA3+kvhLJnAoxj8JSepJLgrlx/L3Wg9AEF3zvbBIaF6crj2D
 s/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441136; x=1773045936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HYqjAK7qOdvm/hJDVYV3EiWpflw4secDuvQP3hCMmE0=;
 b=WMRdkanFIRSxinYvdhDppUlFUpd0X3WtKC4N1WNRXmqbaLyFBxttcUtdIADfIlD141
 7yVWpnoSZHgk+J8ch0yfs5cblllywA0iVTxgGNhpNOegU7gCC/u7Kw2GadpfANL8fKr7
 cuV6QE5WTJFjWwVwWdlTZwlq3WcC3SxxwIWYaevUqvuoHU7Y4GaYYyRdzIxVlzGqmD0k
 2gnW3oAlG2KHrS3KBfasC10i3IiXXiOfot32lfpTQbZmGOIeRSOIX6xND+yqVEsEDgwX
 RiImejto1x8uKMd2F88DkyrYxzHkv9ulOiD0y/1jljxg0v91ZmQIrGp5nrFuY7aD4Dow
 bxLg==
X-Gm-Message-State: AOJu0Yx1x1yb84qgDnv5euxCfAAcDV2zWEyy3tj/awlFyVZI1wxjXvae
 pYv00hc505au9wOVC/rRTbH3Ej3fKmDNkmCQRvkkyBR+PqOprloziYyuif5Fi3uGEQpbsjKHOfs
 TTJRIWebBejXogCSvwD0qoBRvOzX9xnBEiub5OaIou64ym6mLg0xE8UP1fx6wAVt+tnelu2w5pN
 vDPdfVhBslMvyZEdvrFafMFZeLu96m69fc8Dhazju8
X-Gm-Gg: ATEYQzw8CzS4m45NWZqeOOAI099r/Igxu+hAmhmZCIQB58sMTqFdCP4wzmRqpl/4wi9
 gM21fsJOT82rPfKupVTKipNa7q+WBnORfgRzAz66SfvdWGM8+xHBL8HdZvSrtuPUA6kyZW3NS4a
 dkF5uZWiZvl4BzU+d6ETiaFs1Yzd9e9vT8hDY8A3nUC0EffoI5AotAxByp283Wx3E8qsKod2pon
 GRQ2QK1plVH/KwhPiYpgEejFGSiBClZT1XBTZ8oAP0p19qhMM1xWTobWECWPsP2x99cD/stmRXP
 VumOZ6fBr88put828rgsJYCXoCcqj3h1ucOIYe0ttB8Ip5Ki4huhksyrDaSbO23dgPFyQDTAZEW
 FRXpM1gOif/Ty8j0pv+8xqT8OnPsp0Cgy7z5KX/jUigPyAH9aJM4dTmrqEg1uvUbPrHRj2hh3JV
 Nq4jRZ0q0HP4GESnLGww/fEEQVp5U=
X-Received: by 2002:a05:600c:34cf:b0:480:690e:f14a with SMTP id
 5b1f17b1804b1-483c9bb6744mr184864485e9.14.1772441136334; 
 Mon, 02 Mar 2026 00:45:36 -0800 (PST)
X-Received: by 2002:a05:600c:34cf:b0:480:690e:f14a with SMTP id
 5b1f17b1804b1-483c9bb6744mr184864155e9.14.1772441135801; 
 Mon, 02 Mar 2026 00:45:35 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c765c67sm27724110f8f.32.2026.03.02.00.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:45:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 043/102] accel/kvm: add confidential class member to indicate
 guest rebuild capability
Date: Mon,  2 Mar 2026 09:42:38 +0100
Message-ID: <20260302084338.473368-44-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Ani Sinha <anisinha@redhat.com>

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
Link: https://lore.kernel.org/r/20260225035000.385950-3-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/confidential-guest-support.h | 20 ++++++++++++++++++++
 system/runstate.c                           |  6 +++---
 target/i386/kvm/tdx.c                       |  1 +
 target/i386/sev.c                           |  1 +
 4 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/system/confidential-guest-support.h b/include/system/confidential-guest-support.h
index 0cc8b26e644..5dca7173088 100644
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
index d091a2bdddb..13f32bed8cb 100644
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
index 01619857685..a3e81e1c0cc 100644
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
index acdcb9c4e68..66e38ca32e1 100644
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
2.53.0


