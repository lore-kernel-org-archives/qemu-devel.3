Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C423EDF04A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQAU-0000NH-JC; Thu, 12 Feb 2026 01:27:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9z-0008DU-Hb
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9x-0005It-Si
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0DJOQ6jwEso0pRS4a8bCDrKdsF6L0AYtEV0u9zd/jaU=;
 b=OFmJmj9hmUauZnXAnQHzB+nespDjoXGcaEgGVerv1MMaylsD8J691H62w0aQTf6NSPskq2
 xIfdCQVDffdmCQjaaQKuuNcKwJN6X+4DsPW2ASWYeaWBBkhydd+ZzwWDPZ+ubk0OhyE7WJ
 Je5UuVYdprtXzdTC4+qL9R5K/kdgVqg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-RE4yzThzP22hCJWd0OIN6A-1; Thu, 12 Feb 2026 01:26:39 -0500
X-MC-Unique: RE4yzThzP22hCJWd0OIN6A-1
X-Mimecast-MFC-AGG-ID: RE4yzThzP22hCJWd0OIN6A_1770877598
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-354c0234c1fso5776983a91.2
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877598; x=1771482398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0DJOQ6jwEso0pRS4a8bCDrKdsF6L0AYtEV0u9zd/jaU=;
 b=TlzzqbJjvV35uVM6+BMORRbTbHGMHwnK90lPpafG4HQYzaaho8oy0/J6GmMNPUjS0k
 +IDqIRJvglctPoZbCt/RQ4F5BKO5GgYMYATbDORuiSXpOO5eJe7M5allAEHjiRD6DHq5
 VM5hDJv0HCzfXUQdcXDY293/IizbmefGxRJ1Ql1qYwxYBZnsSN7ztpB49ZfDPAnztZM8
 47R2l+Pw+y5xvlIl6YsbIgEn37el3P2BzXpYWUi5miivBmBIUUrNFzKaqRk9pKUJP48u
 bqmHLFrvAG2VLz2RikSmX2Ep/+3WRi2TZkuREItUdv/+AuNjSGATbc/iiKsbG5a+7e7n
 HcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877598; x=1771482398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0DJOQ6jwEso0pRS4a8bCDrKdsF6L0AYtEV0u9zd/jaU=;
 b=hOEdd+VV6EXdEpjdQAz5acMep7ipXVp8HlSLMwMm5R6mh9D7ngjbvQBFt3PHwI2zy9
 FnpdJhrqJR1uehFG10HQq2Q6/uj3ifC1LGyyQpEmz+vCY2+jHKl3o/RpRq2VBVNHBXOe
 vvafvkSdZ3FJ5dkGOZmmya7lbs/yvhReC9CF73073pG+j1AFpV3aTem3rYcvF7x7s16H
 mRD2gjRq+OSQ8zxeviEu2/x8fNC9GsXOc0GXh5trElecz0KEn10MGohLlwkJKm9Cgbpo
 aQKaZE9pcr7jSOkHPBQfH5wJ19UjHe96PgsoEn+UykGSqG92ZqtzU+D4lSqnVUg7QWHC
 YXtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6LGnAbm6d037Y9YsJM86jd2w4uJGUxcg9y0O5qH+O8+04JMuvBtdQ007DWzJW9iKi6rMhcJnJrrXH@nongnu.org
X-Gm-Message-State: AOJu0Yzq3yoX3kcNImgTkE72OZox/skWgDdqlfPuRzIIPFAelvvaI1c1
 lDkmpSDn4F48hbQBJm0ElLdT4/j7IVpUxO7uCbNbR/pXDjf9CttWJY6D9/yolmE6CVnFtmFDGWW
 8BiL7dPoyieJmcIQOzfodllvF8OYb53aar08+09JnJ9SF7eKT3lRA8e7T
X-Gm-Gg: AZuq6aL8ayOj93ecjiyCkUeJo3L8nmfToSNnZaCVveC/3ffUes/NsRLtghqi4M+Od8b
 EQtDVRs8fMzkI7/pDBEiFM2KauvdWg7rAqvZH1C8Z0m5HXt6GozeOLm74Rm4yg6AilliPqlt++F
 E0uECgS0/WU+lJ0Jqn7Day3mjTXVyANtkFm9OwmzhLjI7/KM3llpO54aC6X/nN9O/wBuWIyc7Ls
 0eABBhz1cPD2BPAHqlD+QpqcOKMgDx2Z+rZnr1hJbfMVa9Cw0qIX3kRH27A1w9eeT04xKjHNei8
 1k1NI1fsfxUgvFiUMwo3f2CH6g/c2FlIKJK13b1gkLiI7a5rV9eHledW+7mAJHfT6rM8pui5vdC
 6GG/1nOK2QmE5G96zp4+c5pCCVbfLnMwLSTLAVfC7Mdj3xXiLFdMNI7I=
X-Received: by 2002:a17:90a:d78c:b0:34c:6124:3616 with SMTP id
 98e67ed59e1d1-3568f41819amr1375487a91.27.1770877598305; 
 Wed, 11 Feb 2026 22:26:38 -0800 (PST)
X-Received: by 2002:a17:90a:d78c:b0:34c:6124:3616 with SMTP id
 98e67ed59e1d1-3568f41819amr1375471a91.27.1770877597934; 
 Wed, 11 Feb 2026 22:26:37 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:26:37 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 20/31] i386/sev: add support for confidential guest reset
Date: Thu, 12 Feb 2026 11:55:04 +0530
Message-ID: <20260212062522.99565-21-anisinha@redhat.com>
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


