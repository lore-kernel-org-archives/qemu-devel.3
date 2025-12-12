Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9894D4922D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 15:06:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU4i9-00031X-IS; Fri, 12 Dec 2025 10:05:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4i2-0002Sv-JF
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:05:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vU4hz-00065O-TL
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 10:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765551925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N2VTrzg+qE8VL3OOG3OpyC5OygKIGSBEXRIlgut+Wko=;
 b=X6WEIAjR1wv9pJfhpq2NCzzmiSMV724G+aRFKxdnM0vhHNZwnjkvPuR/nTWNVuhlPQoSid
 wfXUBi90Y+fTDRZUARDCaSxLPlm3v8agwwcop9fM2JLIBa60f4OJhdOmu1p1SPNglodX8K
 LN7X9N13y0lbFOLYQ5A7oiq4PrerPkE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-eTn1eFbNPGexi-e_nStv8A-1; Fri, 12 Dec 2025 10:05:24 -0500
X-MC-Unique: eTn1eFbNPGexi-e_nStv8A-1
X-Mimecast-MFC-AGG-ID: eTn1eFbNPGexi-e_nStv8A_1765551923
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a089575ab3so737385ad.0
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 07:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765551923; x=1766156723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N2VTrzg+qE8VL3OOG3OpyC5OygKIGSBEXRIlgut+Wko=;
 b=AApYq6scVuAgaH9EiQa97f5T4c7FDRq7qDBZKbyF28sxnSTtpfaAm/6EcngqqZ/0Jj
 olp7S6I40QJm4qAWSf6EMSxaPwkY5WwQIiGU5TXSF2Md0/umpFKWmZ0zc2MZ92yw/8x/
 ZlrKIIRejLuJFlRO8uqsayn8RPXF6Jk4YDO5+0XO0nN07TnKFMP+Hg2nOrMrXCASeBT9
 aV87jgdeJM30yMjbPbjLzet8MVDlFWiZlt21rhiAEmDWb90OiqBVs8zq4wzvSBxZbGXu
 0HpBCOWIrxkHpURxDsnZl3gF94N9Z9eElmD13s4LL5eIYukVJ59wm6MvVXGspNjlks+5
 O//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765551923; x=1766156723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N2VTrzg+qE8VL3OOG3OpyC5OygKIGSBEXRIlgut+Wko=;
 b=JPqgcJPV454WhU04p0JY0alHbOxZ9NPfnUM8BJKaRgTz/w4HAX28YPW3AHnMWpurlF
 GtV+iECKoTivCijtsrvKYTIHa6TvCWTp2XmdD+R0cRzc92iGehmAEolZRqXjhIo+wOQd
 g8RJHRYh5rYCko5C9XNl9ysfXDf/SRPHaxiSu/Of4/4eGYEqbPpKid2nTTo28Q0xfq4i
 oRpvBViTf8AJi1ITNT1yRZYuQ7pBRSR2Va6sQxCFooYo5C69dCNZERQLSGJQqikz/Pis
 ZiVFlH5Lm2xG9gQv20d5OAZzScJ7/YvEbjAxlujfFd5fhsjMgt5Cs7+OvwIWbn2A3Ohb
 gXkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/wBITUUuTYGMrF4zq66dezI2Og9lTIKcaoIj9+Gvt6hki2uCRbCnusITzF+HvjzTe5fXd79+E/tiY@nongnu.org
X-Gm-Message-State: AOJu0Yz93r/SpHpFfA+agJyEc0s0OxNc3X0TZYAIwSWOgh27t+ImXtEP
 rR81WElzpEX/nmlRyJ0NoOIid1B37JmQVnoZM4aGobBdliG5akUbnyaXDdkcbgFGZeH8hcWnaXL
 rJfsieQ7iD/1svJTilwVIk+Kk31YgQ9UEFKwzNryiL5C0F4lT0bcg33Ot
X-Gm-Gg: AY/fxX6slLAegrNXLtUYn1UItnx7sXSEXHRASkwd90sP7nvKCLV5FsQ1Ud0narpL3MT
 eUPGGwkc9ZP80j5akhmSWqv1yfi6ShOVx5AdQQKHRSHtm5Y0GpNaYuKTBPLy81xQXkdJUp3UmFf
 3U4Qgs22zjJGbwgoIrFOgISdHL+wnbt7HZNpnhsrSTPl0LeAgKCvC4I9/lju89ARGc5XpoX1DaA
 d6ZKLv2yKDByII5dz2QtXww6ki9ZkvKlI8zJFXulkG1G67CaEz+3Hcji56+92yVzuKU1BXfDAnE
 Rcsps5e5AsegEQY5lVmaEwdtVQwXc/dEEoZayAr+aE4Xj0FrD0g4up994vwkk7g+Hqc/ANFlk/K
 g89EUiFmi8AV+hV+x6DVxe7xS5yNVvuDYIo64bXF9zqI=
X-Received: by 2002:a17:903:120e:b0:295:24ab:fb06 with SMTP id
 d9443c01a7336-29f23b7620amr27812205ad.22.1765551922749; 
 Fri, 12 Dec 2025 07:05:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/6tfMT8Kl8RrzWhiMsAQY3ed5KCyrUemoiU+97igw8z0Kogz5KW2sb29zObkJjgdkQ5BxpA==
X-Received: by 2002:a17:903:120e:b0:295:24ab:fb06 with SMTP id
 d9443c01a7336-29f23b7620amr27811645ad.22.1765551922141; 
 Fri, 12 Dec 2025 07:05:22 -0800 (PST)
Received: from rhel9-box.lan ([122.172.173.62])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-29ee9d38ad1sm57046655ad.29.2025.12.12.07.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 07:05:21 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: vkuznets@redhat.com, kraxel@redhat.com, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v1 18/28] i386/sev: add support for confidential guest reset
Date: Fri, 12 Dec 2025 20:33:46 +0530
Message-ID: <20251212150359.548787-19-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251212150359.548787-1-anisinha@redhat.com>
References: <20251212150359.548787-1-anisinha@redhat.com>
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

When the KVM VM file descriptor changes as a part of the confidential guest
reset mechanism, it necessary to create a new confidential guest context and
re-encrypt the VM memeory. This happens for SEV-ES and SEV-SNP virtual machines
as a part of SEV_LAUNCH_FINISH, SEV_SNP_LAUNCH_FINISH operations.

A new resettable interface for SEV module has been added. A new reset callback
for the reset 'exit' state has been implemented to perform the above operations
when the VM file descriptor has changed during VM reset.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/sev.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 83b9bfb2ae..246a58c752 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -30,8 +30,10 @@
 #include "system/kvm.h"
 #include "kvm/kvm_i386.h"
 #include "sev.h"
+#include "system/cpus.h"
 #include "system/system.h"
 #include "system/runstate.h"
+#include "system/reset.h"
 #include "trace.h"
 #include "migration/blocker.h"
 #include "qom/object.h"
@@ -84,6 +86,10 @@ typedef struct QEMU_PACKED PaddedSevHashTable {
     uint8_t padding[ROUND_UP(sizeof(SevHashTable), 16) - sizeof(SevHashTable)];
 } PaddedSevHashTable;
 
+static void sev_handle_reset(Object *obj, ResetType type);
+
+SevKernelLoaderContext sev_load_ctx = {};
+
 QEMU_BUILD_BUG_ON(sizeof(PaddedSevHashTable) % 16 != 0);
 
 #define SEV_INFO_BLOCK_GUID     "00f771de-1a7e-4fcb-890e-68c77e2fb44e"
@@ -127,6 +133,7 @@ struct SevCommonState {
     uint8_t build_id;
     int sev_fd;
     SevState state;
+    ResettableState reset_state;
 
     QTAILQ_HEAD(, SevLaunchVmsa) launch_vmsa;
 };
@@ -2012,6 +2019,37 @@ static int sev_snp_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     return 0;
 }
 
+/*
+ * handle sev vm reset
+ */
+static void sev_handle_reset(Object *obj, ResetType type)
+{
+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
+    SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(sev_common);
+
+    if (!sev_common) {
+        return;
+    }
+
+    if (!runstate_is_running()) {
+        return;
+    }
+
+    sev_add_kernel_loader_hashes(&sev_load_ctx, &error_fatal);
+    if (!sev_check_state(sev_common, SEV_STATE_RUNNING)) {
+        /* this calls sev_snp_launch_finish() etc */
+        klass->launch_finish(sev_common);
+    }
+
+    return;
+}
+
+static ResettableState *sev_reset_state(Object *obj)
+{
+    SevCommonState *sev_common = SEV_COMMON(obj);
+    return &sev_common->reset_state;
+}
+
 int
 sev_encrypt_flash(hwaddr gpa, uint8_t *ptr, uint64_t len, Error **errp)
 {
@@ -2490,6 +2528,8 @@ bool sev_add_kernel_loader_hashes(SevKernelLoaderContext *ctx, Error **errp)
         return false;
     }
 
+    /* save the context here so that it can be re-used when vm is reset */
+    memcpy(&sev_load_ctx, ctx, sizeof(*ctx));
     return klass->build_kernel_loader_hashes(sev_common, area, ctx, errp);
 }
 
@@ -2750,8 +2790,16 @@ static void
 sev_common_class_init(ObjectClass *oc, const void *data)
 {
     ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
 
     klass->kvm_init = sev_common_kvm_init;
+    /*
+     * the exit phase makes sure sev handles reset after all legacy resets
+     * have taken place (in the hold phase) and IGVM has also properly
+     * set up the boot state.
+     */
+    rc->phases.exit = sev_handle_reset;
+    rc->get_state = sev_reset_state;
 
     object_class_property_add_str(oc, "sev-device",
                                   sev_common_get_sev_device,
@@ -2786,6 +2834,8 @@ sev_common_instance_init(Object *obj)
     cgs->get_mem_map_entry = cgs_get_mem_map_entry;
     cgs->set_guest_policy = cgs_set_guest_policy;
 
+    qemu_register_resettable(OBJECT(sev_common));
+
     QTAILQ_INIT(&sev_common->launch_vmsa);
 }
 
@@ -2800,6 +2850,7 @@ static const TypeInfo sev_common_info = {
     .abstract = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
+        { TYPE_RESETTABLE_INTERFACE },
         { }
     }
 };
-- 
2.42.0


