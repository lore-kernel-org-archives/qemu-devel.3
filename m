Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE917D58E7F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyvT-0007Dp-EW; Mon, 02 Mar 2026 03:46:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyvC-0005wD-ST
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyvA-00021N-Ci
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tn6Srd+QNDO0Z+G86AevNyEAI6wqEDDO6y+a5TKwDnk=;
 b=dzRQLtRt8uzBwzc1sOcvkrWXCmC3wIejtfSvoMfVpUVGkH+j4koL/ImWnKXJBBT3bgMZUL
 xFGo66q+xK/uukLxyVxzArxWGnyYUxYCE0YGkxMYiEn9fsgA4y2QLH1tGO6Z9+sv84lsRN
 ZwmaE3KQL3nQeahUBLGfn2prkOZeMaA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-t-z68TusMF-RQLdzly06MA-1; Mon, 02 Mar 2026 03:46:29 -0500
X-MC-Unique: t-z68TusMF-RQLdzly06MA-1
X-Mimecast-MFC-AGG-ID: t-z68TusMF-RQLdzly06MA_1772441188
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4806cfffca6so42274025e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441188; x=1773045988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tn6Srd+QNDO0Z+G86AevNyEAI6wqEDDO6y+a5TKwDnk=;
 b=iQayjNkEoO7o9vsPaDNumYcEaowYKh62Y/dg5rwLVbPw28pzS6Mr3UhFhDiUzbNAHj
 +P+wfH/wvdCNgxjbAY6IFIkRViInF7+wWzejQEB4vNFGR+bHHYUtQG38dJCOHiDjAo0I
 NLkRkqik8BSa/j8DwYuTpijUh46QW6rES/nJV6+Du9UnEepOfQn32bUqQgY05jO6f1fc
 b3haiun3WroPzD0JzUggFvquTNYyJWZvCDQdvvJZ0hRr2TmgYDr2X6BSPPkrlsLY9/kJ
 PhsKJvufKI/r6D1Id+QLy6xmlrzkxTP3XY4yeIzAL00IcTHkb4gk7vgXToWozXICmdfe
 oY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441188; x=1773045988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tn6Srd+QNDO0Z+G86AevNyEAI6wqEDDO6y+a5TKwDnk=;
 b=vsXeVLzq2NmjPGbppp8Re+D/Su6sBMpdupSFMPAZ00++hVfBQMbZtoPGWLli/T6ubs
 k+c6qrFBlaxvwz5VjxNgSYlECDmpBZcLOA4g5YkKslphtODEKGmuXtmPfI9SemkD74WE
 xpOcEvsD8YCNEcmqsH/DnTNdowl0fqqpSKO10oM9uDU/ZZros0qXz445iTVrnKDPEsQo
 yLlj8hZh7aHXqEePi37ADgnUDhWbWQCw+jzQ1xPxrjD7ESeUSP9q2kyvRTIcPryWhq7n
 Y7bVOaB+dcnMh8nt3D09HSBshsWk/06HBo/TJJFj/Jhm52CXPu74d7c/YFrn61Mrslqh
 nMcg==
X-Gm-Message-State: AOJu0YxfA9/eDZQXTGZ9mNEt8H26PO1hbni/LZHjSKJ1fMQg8x2M9rz+
 lnEPd9gC94OFE2Izf9cnYNh572qMs++1SWiZQ20hxaQPp05r/JWKNFNVEO0D+BKXO/gBphcwToG
 NPQDcM4h6CwO7ehSmLXbvbOS9IbkZZIdmqPgvg1tS75MSkSWwB4SAzAezMYetxf++BjGjC/8vRy
 B3UjUIIWvwHz5C6p2/kFf0ULmn5R8pjlVk8vDoSwB4
X-Gm-Gg: ATEYQzyfwt3cTxzjvEH4X/pluChC29P444WsiO3R3GGhG1C4sblXrbg9oWiBnKk6xlD
 b+9ArIf1b6y4zccFk8HtnGdav23eWuWmOqrjRzQf5VH0EOeZzY5Af2UXcCcrMg85gC5Gu7F7iE8
 hrV3PyHcSpN9xiWCuPKbCaXq4bMQ2Hw6Er1T5SMDITjMEuuYkA+T2XbP3YZyx/Eb6vPX2H6Fz+y
 7DxQDICXHDXjjUGRSiLjzbiRrNJGrzXjywrO+mDyn6TXEKQ6ZciJQJ0gq4q9JzpR5eKQwA4eY+6
 Mfk04VaQMRxCo2Sz6ltEvrnDXVkCEcz5IBYcZUoTjazhArMgsjmLFHgoiB9HF7I0RGN0FPC7aLj
 AH7wgYB51bejp/xKOk71swuooIwJys+ErMWYKWetSpfTrrKZGG1zT82sH0LZaGBXabb4/TPqEqc
 wbXiCxzM1Or79kFMskiBluTR0Qhtg=
X-Received: by 2002:a05:600c:1f91:b0:483:6ff1:18b with SMTP id
 5b1f17b1804b1-483c9b7eac9mr210557725e9.0.1772441187589; 
 Mon, 02 Mar 2026 00:46:27 -0800 (PST)
X-Received: by 2002:a05:600c:1f91:b0:483:6ff1:18b with SMTP id
 5b1f17b1804b1-483c9b7eac9mr210557245e9.0.1772441187136; 
 Mon, 02 Mar 2026 00:46:27 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb1390bsm237747895e9.1.2026.03.02.00.46.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:46:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 063/102] i386/sev: add support for confidential guest reset
Date: Mon,  2 Mar 2026 09:42:58 +0100
Message-ID: <20260302084338.473368-64-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Ani Sinha <anisinha@redhat.com>

When the KVM VM file descriptor changes as a part of the confidential guest
reset mechanism, it necessary to create a new confidential guest context and
re-encrypt the VM memory. This happens for SEV-ES and SEV-SNP virtual machines
as a part of SEV_LAUNCH_FINISH, SEV_SNP_LAUNCH_FINISH operations.

A new resettable interface for SEV module has been added. A new reset callback
for the reset 'exit' state has been implemented to perform the above operations
when the VM file descriptor has changed during VM reset.

Tracepoints has been added also for tracing purpose.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260225035000.385950-23-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c        | 58 ++++++++++++++++++++++++++++++++++++++++
 target/i386/trace-events |  1 +
 2 files changed, 59 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index b3893e431c4..549e6241769 100644
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
index 51301673f0c..b320f655eeb 100644
--- a/target/i386/trace-events
+++ b/target/i386/trace-events
@@ -14,3 +14,4 @@ kvm_sev_attestation_report(const char *mnonce, const char *data) "mnonce %s data
 kvm_sev_snp_launch_start(uint64_t policy, char *gosvw) "policy 0x%" PRIx64 " gosvw %s"
 kvm_sev_snp_launch_update(uint64_t src, uint64_t gpa, uint64_t len, const char *type) "src 0x%" PRIx64 " gpa 0x%" PRIx64 " len 0x%" PRIx64 " (%s page)"
 kvm_sev_snp_launch_finish(char *id_block, char *id_auth, char *host_data) "id_block %s id_auth %s host_data %s"
+sev_handle_reset(void) ""
-- 
2.53.0


