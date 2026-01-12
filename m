Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023BEC9EC8D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHuL-0003m5-6Y; Mon, 12 Jan 2026 08:24:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHuC-0003Hm-DQ
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHuA-0003pZ-9n
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Xl2NZDHarHkXqS5yrKrfSXN4c45GQhJC2FoUsQnchs=;
 b=al0S5g+BAd6PtHUYUtUhnuEtq6hgRHZ4b0/p/tf58NzWxhGvVxuwTqzz9637iQ0bFjXlzi
 PyfzqwEbvgi4qehrl6z/JOC3N6JoDKlNp5Y0qghSlO2H44z3o+l20FpXZX2KyZs3sdXHih
 DGsATlgucwUtX+MrC9Xz7jOaFUQDwJk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-UcPZHL8rMjqjQ32rrMXqGQ-1; Mon, 12 Jan 2026 08:24:17 -0500
X-MC-Unique: UcPZHL8rMjqjQ32rrMXqGQ-1
X-Mimecast-MFC-AGG-ID: UcPZHL8rMjqjQ32rrMXqGQ_1768224256
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-34c37b8dc4fso12168641a91.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224256; x=1768829056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Xl2NZDHarHkXqS5yrKrfSXN4c45GQhJC2FoUsQnchs=;
 b=YS+h+uFUq6RWQSjFqCmH8ixDr1BVLg2779ncLrppIfG2miHOtWo+l1UoJQzmIUmhNt
 qWTmriJS+dKeGDeX52TruKU0pNhz2w/v9NVPZiaxTZyxgpYEEMF1NCK21e+zpiDHX7cX
 xBiL7kMn/rMFGy3vKZZJH4MBZHtyBaDzGigSdHKUg09OAZQiXVh4t9zamtBmMAb4/VgL
 3HmyKWgCFv4yZNN5Z+gxbNo8OGLAvOfYY9DjhmUUVNQQq/NHVPBiSE3zLiWOTwN3F4MS
 BtICRGlTgtde3xDfbCE/9mSR83ZWquUBjDjifWvwmK5SeGE0rDmGjHtZDLJ9AYK73wLa
 DRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224256; x=1768829056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/Xl2NZDHarHkXqS5yrKrfSXN4c45GQhJC2FoUsQnchs=;
 b=YVnE8CrfR3rGYNcYn63AFaurY5yC6YHBTsB1F12M2ThKswsnzIA44q+HBtY2M+7S0U
 YG4cXeP7zI07lzS9hy2kPGiKFLB7FlAsNcVYfQy3+sP6tvoPD66BaEzmjMoFo6OXdqd+
 I89NDlR7/IhvwzRCAf/sPk7/NWXwIR5Wxz0xbXMAhEmHlktq7Nx4EXDz+M/RfQFi5bzx
 mP7T56mQHAm80/hCZkLFjjGuKu/SjF+UqKA6iyji2m/Y9vP5LDZW1ASGL1+q7jmyJ6Dz
 rfdOd+A3kNvvHMGexRIVRDn3j0qr33dfB9Anup7i2qINRrB4mvjBoCiTsIzKx71vWyb5
 pLDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTP4dyJm4h1tKBVWbxQ+XuqRXiq3mAy+3fvq8Ceb47/dMpra+3Hq/GaJnPpUtiqB5ySSB0MKQmQ/VH@nongnu.org
X-Gm-Message-State: AOJu0YzUjRMRER81/ktpER9k9Vn29qtgcBqr3zsCZby0f+RTaSe5y4X/
 P/u97S0C86Wh9k13F5QzVsQcZYFL/GU161Wq0Cji+fIk6irfkMjGQ0bJ8zKE7HowL5gabBb2xBt
 HxmVM4V11CI9JpSKPyh8PqvkenfppDII47tSckiSSGR5tSrqqYMADh+13
X-Gm-Gg: AY/fxX6M3uj5A4DNh8Wm4Q7Pepnxdx/Ab13XAVqPVUqpK3Hb+eTL5ABm73kO/sjf2ak
 +j7cXRlnDdEX9powNa3ZILsyF+zM+0WDpSN8Xd2ruMF1qTJzGBIyW+/uVjNHFDMS+ozh/7j2gqr
 dKLfCZxXajfM2fjdt+S3/uRJitkVdb4ZTNEjvWRAHIIpmpbq6P0n+HnD9Lb3zK+fvsxyqVTjY6v
 iwQWt7D2je170SUOUlbhMNEUIgZy0P/PuJRwEJUqFW9cbkdDLqv9AMjo8yoJAPjAcHz/b6kHnZV
 ffh5P2L0klAZMagmRMNdLQe+3tFgUcQhVaj5Mij6iUM25eIMD8FTvTOjhS17/ZNLfVA2IOfZJK4
 i6fgXjoC6WRn8Zhn5qT2uvtcoD1CxZRrGrTrJLi9SVN8=
X-Received: by 2002:a05:6a21:3389:b0:364:13e1:10f0 with SMTP id
 adf61e73a8af0-3898f990467mr15895550637.48.1768224255806; 
 Mon, 12 Jan 2026 05:24:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkV+5Pj+vPwdorDJk/3GEPIk0RVkmzj9pSTKP97TxM+k+HNRr4FYBWDj0fQukT5a54s7G7qw==
X-Received: by 2002:a05:6a21:3389:b0:364:13e1:10f0 with SMTP id
 adf61e73a8af0-3898f990467mr15895534637.48.1768224255391; 
 Mon, 12 Jan 2026 05:24:15 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:24:15 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v2 19/32] i386/sev: add support for confidential guest reset
Date: Mon, 12 Jan 2026 18:52:32 +0530
Message-ID: <20260112132259.76855-20-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260112132259.76855-1-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
re-encrypt the VM memeory. This happens for SEV-ES and SEV-SNP virtual machines
as a part of SEV_LAUNCH_FINISH, SEV_SNP_LAUNCH_FINISH operations.

A new resettable interface for SEV module has been added. A new reset callback
for the reset 'exit' state has been implemented to perform the above operations
when the VM file descriptor has changed during VM reset.

Tracepoints has been added also for tracing purpose.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/sev.c        | 52 ++++++++++++++++++++++++++++++++++++++++
 target/i386/trace-events |  1 +
 2 files changed, 53 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index d7425dde96..d45356843c 100644
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
@@ -85,6 +87,10 @@ typedef struct QEMU_PACKED PaddedSevHashTable {
     uint8_t padding[ROUND_UP(sizeof(SevHashTable), 16) - sizeof(SevHashTable)];
 } PaddedSevHashTable;
 
+static void sev_handle_reset(Object *obj, ResetType type);
+
+SevKernelLoaderContext sev_load_ctx = {};
+
 QEMU_BUILD_BUG_ON(sizeof(PaddedSevHashTable) % 16 != 0);
 
 #define SEV_INFO_BLOCK_GUID     "00f771de-1a7e-4fcb-890e-68c77e2fb44e"
@@ -128,6 +134,7 @@ struct SevCommonState {
     uint8_t build_id;
     int sev_fd;
     SevState state;
+    ResettableState reset_state;
 
     QTAILQ_HEAD(, SevLaunchVmsa) launch_vmsa;
 };
@@ -1984,6 +1991,38 @@ static int sev_snp_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
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
@@ -2462,6 +2501,8 @@ bool sev_add_kernel_loader_hashes(SevKernelLoaderContext *ctx, Error **errp)
         return false;
     }
 
+    /* save the context here so that it can be re-used when vm is reset */
+    memcpy(&sev_load_ctx, ctx, sizeof(*ctx));
     return klass->build_kernel_loader_hashes(sev_common, area, ctx, errp);
 }
 
@@ -2722,8 +2763,16 @@ static void
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
@@ -2758,6 +2807,8 @@ sev_common_instance_init(Object *obj)
     cgs->get_mem_map_entry = cgs_get_mem_map_entry;
     cgs->set_guest_policy = cgs_set_guest_policy;
 
+    qemu_register_resettable(OBJECT(sev_common));
+
     QTAILQ_INIT(&sev_common->launch_vmsa);
 
     /* add migration blocker */
@@ -2779,6 +2830,7 @@ static const TypeInfo sev_common_info = {
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


