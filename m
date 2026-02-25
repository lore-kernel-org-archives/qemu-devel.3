Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA199F55455
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv5vu-0001Rq-Ks; Tue, 24 Feb 2026 22:51:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5vs-0001Ik-DV
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vv5vq-0008B1-Cw
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:51:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771991485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0DJOQ6jwEso0pRS4a8bCDrKdsF6L0AYtEV0u9zd/jaU=;
 b=EezkBWy6w0GL5Q169VcGQ/286nf8WodaG02PYg7YmeU+O6Q7v72ng8NkpEqzTANXCCD8bN
 cfcCNhMHyZ2H4NR6WzuPWor9kdVkhmsjHMEc41iLNAq3wJzzyxR6rflcZVuCaDKOh49xta
 1bEVSpWDBQ8Ux360/XAjgQT+nt/IBNs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-Ix0Q-HyiMvqrV9Br-hDAAQ-1; Tue, 24 Feb 2026 22:51:24 -0500
X-MC-Unique: Ix0Q-HyiMvqrV9Br-hDAAQ-1
X-Mimecast-MFC-AGG-ID: Ix0Q-HyiMvqrV9Br-hDAAQ_1771991483
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-358e95e81aeso5724806a91.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771991483; x=1772596283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0DJOQ6jwEso0pRS4a8bCDrKdsF6L0AYtEV0u9zd/jaU=;
 b=RxXxbrZLymuM7G5R5n9pV0gfY1iFhAIF8fJixtwm7rDlQ9iWX7Yoq53yNV32lvCbvl
 8lS2KcWGthpNUZVZXsaWj1c+RUXFPldmdJgi7E1PFSm0MI0xlrfoMX82PBbk19Il5KIR
 sUT44hJCguV/zucwnAwo2hXGoFZl+mllAewRn/zHLAahLPnaBLM5kkH2i0BpQqVqIt/C
 ji3v4i7V2H802PjmKN8f/gUvdJWeE95YE6kUYeEtZvjAyFvObR+XeHP+cfsUBeCwsBI4
 9JZ9ICO/ibF4jVxT/LySAdJAnDlR5MKd15tIO/zBpccpKqs4uzF9snc0O16CNwsB0pwr
 8ByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991483; x=1772596283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0DJOQ6jwEso0pRS4a8bCDrKdsF6L0AYtEV0u9zd/jaU=;
 b=qJh+ax6hxMmTzNeUHLzww+MH9bGykhNDJYdwbw9mjQs8lbhZrfcum+I9C21xaL3285
 dNDV4OyNo1gSNyMtPQKnW+N5f9g/6kjsslFeVWSIno9a7fWdofCdQ1Ds8A3PazHm5zuP
 bRE4W4+7vkerSalE5okuW/9ruKyzdEUnoQ09l3HmMkuKR5AJljuUjTOxF0da7qQS5ruz
 AevYXQM21SBTlCWuyKJeBCkQGIrgulW+DVP/lMDR4+ZBCcUgHJ4fLAZd7TWMS2kowpsd
 eC6sX63pXa85b7jW7HsvKh6DNK1X5mvbaEyiQ/JAZ4nZFgrzQC84vS3o1Ik6a7Wwc1az
 8muw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8VPwKWz0znMQTmfb6Kb1AeZcfgZajJLB70mc/vt0/zev+dHdPqGLiCfHFhB8MLRS9BqEWo3igzvk4@nongnu.org
X-Gm-Message-State: AOJu0YywBYdOrfClpFDlZdtsQ+67QuASPwYhHgukLMxyEUsajg9lJJjz
 IWAj2r70CO3iJuxWe4siivBwWhRpYEpW1GfAx9eRWuPKsKxEVmNQoMadigO3Du1+fPoc4LZy/hM
 m7cRnxxi7rjGlYImNQkcnLUc5R3px3akezwK1ZqoeL8szTpN66sKNEGKq
X-Gm-Gg: ATEYQzwmYSrswcihB9P7zrf/cDoMMQyJ5OgBRK5yw6z8+is8SP6+nHhGicJqzdkHDoI
 4ksue0X3rCAB/bv0E/+and/R9+Qek707aCYZv1B3oXaC0D+9fJXJ42bqDqIWLLUZJ8qAD6BGczR
 5YdV6AhfbIW7WYrCmpIo9SBn8S8O3olQ5+vFe2v5vy621y989gpp0obn5gvIhGdX4jcg8fr4Np9
 DSKZ9CN60LO499WnRjInetw0YzHa2e5Jw2KRjc+d4aoHfBaTg2tUC/enVm5K2kbLU+fGgYqZE9s
 U/62UztHmZg1sxlNzHvn8LFwJb2z1MtfvhH1rwIm4tU9PlM/gA3a9JBK25+3hI8KPA/nVI5GKY1
 dLocBntoohVJ0KGBA7PhmjRyk9Ikj8DnhoS/IWwYA3yaUnzXdM5+Klx4=
X-Received: by 2002:a17:90b:17c8:b0:354:a284:3fff with SMTP id
 98e67ed59e1d1-358ae8cfe96mr11145656a91.25.1771991482895; 
 Tue, 24 Feb 2026 19:51:22 -0800 (PST)
X-Received: by 2002:a17:90b:17c8:b0:354:a284:3fff with SMTP id
 98e67ed59e1d1-358ae8cfe96mr11145638a91.25.1771991482539; 
 Tue, 24 Feb 2026 19:51:22 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 19:51:22 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, ani@anisinha.ca,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v6 22/35] i386/sev: add support for confidential guest reset
Date: Wed, 25 Feb 2026 09:19:27 +0530
Message-ID: <20260225035000.385950-23-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260225035000.385950-1-anisinha@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


