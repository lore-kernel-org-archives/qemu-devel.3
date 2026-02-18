Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D640E9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfz9-0004ol-Ao; Wed, 18 Feb 2026 06:44:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfyL-0003jk-22
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:44:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfyF-0007vN-3O
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771415034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0DJOQ6jwEso0pRS4a8bCDrKdsF6L0AYtEV0u9zd/jaU=;
 b=hI1P4j+YUC+bPBLYOYIudCYRXM9CDsAvyYOYLiObcqGqLgpB4RBjmC7VXewmGoyDS5XER5
 8ZAWKqmvD0Y0k3ZXqbHfoMLwcmZM/ihncEEQsfpV/VVwqtdML1H9QRIgvwOwE4Uf4qmc0R
 l/xvh8afpyZ4PoHsk2Qbxnk4g/ZjpIw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-sEMvEn7yONqteUBdSE9KIw-1; Wed, 18 Feb 2026 06:43:52 -0500
X-MC-Unique: sEMvEn7yONqteUBdSE9KIw-1
X-Mimecast-MFC-AGG-ID: sEMvEn7yONqteUBdSE9KIw_1771415031
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2aad5fec175so207988445ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771415031; x=1772019831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0DJOQ6jwEso0pRS4a8bCDrKdsF6L0AYtEV0u9zd/jaU=;
 b=EicXvAvNHeslNx4m3dpEuGEpAsJw/WD5rhWQXIPdj2dfuMGc5MMAK3s4YT2vNWgLaQ
 M3JI/oW+YRVx24bL514XIpdrddXrqaxvO2nHFknP8WWijsWdc2iKQ8vehPqutRnNutCB
 3g7vK7jJx+8DDDY5gJLZG62lLqrNPDnhXwsbk0fWBBJdCrQgLfNHoXAnkCpYu7hmhJ+F
 AIz7bh9OpfUbRqDu5qtyzvcWVZwjdcBRwGdjmCSIhgnMOPCptXdVW3jG6NHgSc+Wkrcz
 Nc11iLbHL6AYouakSYp2DAGENVsKQt9Y5wDrE5Qa9k/9NVWCxHbttDXgqqMJeaDfxbal
 E5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771415031; x=1772019831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0DJOQ6jwEso0pRS4a8bCDrKdsF6L0AYtEV0u9zd/jaU=;
 b=iTVHbZYyVRkd3KA9gzQlskTDo9l17LLWu7ftGcy0adjhJVeAuXs7GxLt6pp+UnmFUk
 YpTqFilCKiYaSZtzLMMck/fLuu0NUQQxFGbI6d1uffeYO/jNsbf+zilvWzleSRHXBDae
 Ya9o4WC5WpmTBzEe/sNMRa3JFk3GSWXsoIZybasI8HyZgDdT9qh9F7Cl2EivgaEAdtSv
 QMyjUJictZsm3n6gTf8lWa02xQYoEmitlUZlyTGKpgNoeXAIXSg8/PiPCC+i9IY4c5td
 Yh6l0ml1I8AZytgExMX2bMgqY9SzxqXEHOClREU5WgR2HQxX05SVBN0BMscm2Q/O4pF2
 56RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR+xzTsd8RgGr0V0MfZrTjP5GhsCPVA6vzqsIhCvlKmh6toCN5Td0oiyfzsWeie/ETMkxWC+C8/Mhu@nongnu.org
X-Gm-Message-State: AOJu0Yxx1+rQm4iezyviKZPeTMxiriM1vkn+BtbAYCDGeOGG9lnkR6zg
 Cy9rU8WIdzHZ4i4Y0NKkrL35vmEuaeT0pGYeUkPsBsVGceIqIRgC4BRv+GRioO4gmnJnhKXkjzD
 Od3jUG7J6cekhJRrHkIuTejBYhZEqCPpiC/1NDuDWuQQtsBs9HFiC9v5p
X-Gm-Gg: AZuq6aLYWLLuFXe1omJ9ruhg9P+id9lRKrFlIeCv8D7JlbNWTwB5R0mhQB2eNaLmr4E
 5J6z4WT0QAr9XWfI81uif/HVDMDSU0u67j7E5kHdo5Qx9PN2gAH1KN28cAAyQ1GSSQuq+KXnIlM
 bW84mL3r2OqRAOa5K6G3p3kdsMn7fiNoUlmvGVU8LNXi2ZexRPki6BmV8eJY6VkBQIQ5zDXRchS
 wk3cyoE6ScofpONBNKTUNwYwtnRzNFfzMEbQAGwCI3pf8eMniISa+Qzu2D+MJmKH8B78QzVcIv8
 wAW3PWHnesGRb7wHzHU9niwHUStek1v37fSg75BjEoijg8/Qqc+gfbWmOJCDspTnyiu+oU/hR3m
 YxRPwMN15oxSofgdSLkthtssJnmc0CMynIu+wk0UA4eaU7twL7HCT
X-Received: by 2002:a17:902:da8c:b0:2aa:f43d:7c4b with SMTP id
 d9443c01a7336-2ad50e9a45emr15686115ad.19.1771415031022; 
 Wed, 18 Feb 2026 03:43:51 -0800 (PST)
X-Received: by 2002:a17:902:da8c:b0:2aa:f43d:7c4b with SMTP id
 d9443c01a7336-2ad50e9a45emr15686015ad.19.1771415030642; 
 Wed, 18 Feb 2026 03:43:50 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:43:50 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v5 21/34] i386/sev: add support for confidential guest reset
Date: Wed, 18 Feb 2026 17:12:14 +0530
Message-ID: <20260218114233.266178-22-anisinha@redhat.com>
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

When the KVM VM file descriptor changes as a part of the confidential guest
reset mechanism, it necessary to create a new confidential guest context and
re-encrypt the VM memory. This happens for SEV-ES and SEV-SNP virtual machines
as a part of SEV_LAUNCH_FINISH, SEV_SNP_LAUNCH_FINISH operations.

A new resettable interface for SEV module has been added. A new reset callback
for the reset 'exit' state has been implemented to perform the above operations
when the VM file descriptor has changed during VM reset.

Tracepoints has been added also for tracing purpose.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/sev.c        | 58 ++++++++++++++++++++++++++++++++++++++++
 target/i386/trace-events |  1 +
 2 files changed, 59 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index b3893e431c..549e624176 100644
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
@@ -86,6 +88,10 @@ typedef struct QEMU_PACKED PaddedSevHashTable {
     uint8_t padding[ROUND_UP(sizeof(SevHashTable), 16) - sizeof(SevHashTable)];
 } PaddedSevHashTable;
 
+static void sev_handle_reset(Object *obj, ResetType type);
+
+SevKernelLoaderContext sev_load_ctx = {};
+
 QEMU_BUILD_BUG_ON(sizeof(PaddedSevHashTable) % 16 != 0);
 
 #define SEV_INFO_BLOCK_GUID     "00f771de-1a7e-4fcb-890e-68c77e2fb44e"
@@ -129,6 +135,7 @@ struct SevCommonState {
     uint8_t build_id;
     int sev_fd;
     SevState state;
+    ResettableState reset_state;
 
     QTAILQ_HEAD(, SevLaunchVmsa) launch_vmsa;
 };
@@ -1666,6 +1673,11 @@ sev_vm_state_change(void *opaque, bool running, RunState state)
             error_setg(&sev_mig_blocker,
                        "SEV: Migration is not implemented");
             migrate_add_blocker(&sev_mig_blocker, &error_fatal);
+            /*
+             * mark SEV guest as resettable so that we can reinitialize
+             * SEV upon reset.
+             */
+            qemu_register_resettable(OBJECT(sev_common));
         }
     }
 }
@@ -1991,6 +2003,41 @@ static int sev_snp_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
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
+    if (sev_es_enabled() && !sev_snp_enabled()) {
+        sev_launch_get_measure(NULL, NULL);
+    }
+    if (!sev_check_state(sev_common, SEV_STATE_RUNNING)) {
+        /* this calls sev_snp_launch_finish() etc */
+        klass->launch_finish(sev_common);
+    }
+
+    trace_sev_handle_reset();
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
@@ -2469,6 +2516,8 @@ bool sev_add_kernel_loader_hashes(SevKernelLoaderContext *ctx, Error **errp)
         return false;
     }
 
+    /* save the context here so that it can be re-used when vm is reset */
+    memcpy(&sev_load_ctx, ctx, sizeof(*ctx));
     return klass->build_kernel_loader_hashes(sev_common, area, ctx, errp);
 }
 
@@ -2729,8 +2778,16 @@ static void
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
@@ -2780,6 +2837,7 @@ static const TypeInfo sev_common_info = {
     .abstract = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },
+        { TYPE_RESETTABLE_INTERFACE },
         { }
     }
 };
diff --git a/target/i386/trace-events b/target/i386/trace-events
index 51301673f0..b320f655ee 100644
--- a/target/i386/trace-events
+++ b/target/i386/trace-events
@@ -14,3 +14,4 @@ kvm_sev_attestation_report(const char *mnonce, const char *data) "mnonce %s data
 kvm_sev_snp_launch_start(uint64_t policy, char *gosvw) "policy 0x%" PRIx64 " gosvw %s"
 kvm_sev_snp_launch_update(uint64_t src, uint64_t gpa, uint64_t len, const char *type) "src 0x%" PRIx64 " gpa 0x%" PRIx64 " len 0x%" PRIx64 " (%s page)"
 kvm_sev_snp_launch_finish(char *id_block, char *id_auth, char *host_data) "id_block %s id_auth %s host_data %s"
+sev_handle_reset(void) ""
-- 
2.42.0


