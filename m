Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA27D1A63C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 14:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veDZy-00059x-Sk; Fri, 09 Jan 2026 09:35:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1veDZw-00052X-07
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 09:35:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1veDZs-0005U1-BB
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 09:35:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767969298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=StFbEp2ry1WOmdUB9ftIGUAuXNqoomLenoPBUoiEMBQ=;
 b=NvCR3dopTsQuX8hEiHiJUntv/+lLJSvgAiEeyTZKV/UNCYm5kSaYv/URfKM0XvR9nS9Tlu
 Tf6+xbLGlmsRINh5XitX3hoc/6ArjSY3Y65EKFtmm+du9J06Kjd2Zd9cwm3pbmGKG7wSBd
 /roqZcBobs3qvkkmfcrsSk4/8YPkwkc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-XjbkymKgPxO-HutGHKDT4w-1; Fri,
 09 Jan 2026 09:34:54 -0500
X-MC-Unique: XjbkymKgPxO-HutGHKDT4w-1
X-Mimecast-MFC-AGG-ID: XjbkymKgPxO-HutGHKDT4w_1767969292
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 745A41956088; Fri,  9 Jan 2026 14:34:52 +0000 (UTC)
Received: from osteffen-laptop.redhat.com (unknown [10.45.225.84])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1ECAD18001D5; Fri,  9 Jan 2026 14:34:46 +0000 (UTC)
From: Oliver Steffen <osteffen@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Joerg Roedel <joerg.roedel@amd.com>, Gerd Hoffmann <kraxel@redhat.com>,
 kvm@vger.kernel.org, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Oliver Steffen <osteffen@redhat.com>
Subject: [PATCH v3 5/6] igvm: Pass machine state to IGVM file processing
Date: Fri,  9 Jan 2026 15:34:12 +0100
Message-ID: <20260109143413.293593-6-osteffen@redhat.com>
In-Reply-To: <20260109143413.293593-1-osteffen@redhat.com>
References: <20260109143413.293593-1-osteffen@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=osteffen@redhat.com;
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

Add a new MachineState* parameter to qigvm_process_file()
to make the machine state available in the IGVM processing
context. We will use it later to generate MADT data there
to pass to the guest as IGVM parameter.

Signed-off-by: Oliver Steffen <osteffen@redhat.com>
---
 backends/igvm-cfg.c       | 2 +-
 backends/igvm.c           | 6 +++++-
 include/system/igvm-cfg.h | 3 ++-
 include/system/igvm.h     | 3 ++-
 target/i386/sev.c         | 2 +-
 5 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
index c1b45401f4..d79bdecab1 100644
--- a/backends/igvm-cfg.c
+++ b/backends/igvm-cfg.c
@@ -51,7 +51,7 @@ static void igvm_reset_hold(Object *obj, ResetType type)
 
     trace_igvm_reset_hold(type);
 
-    qigvm_process_file(igvm, ms->cgs, false, &error_fatal);
+    qigvm_process_file(igvm, ms->cgs, false, ms, &error_fatal);
 }
 
 static void igvm_reset_exit(Object *obj, ResetType type)
diff --git a/backends/igvm.c b/backends/igvm.c
index a797bd741c..7390dee734 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 
+#include "hw/boards.h"
 #include "qapi/error.h"
 #include "qemu/target-info-qapi.h"
 #include "system/igvm.h"
@@ -93,6 +94,7 @@ typedef struct QIgvm {
     unsigned region_start_index;
     unsigned region_last_index;
     unsigned region_page_count;
+    MachineState *machine_state;
 } QIgvm;
 
 static QIgvmParameterData *qigvm_find_param_entry(QIgvm *igvm, const IGVM_VHS_PARAMETER *param) {
@@ -906,7 +908,7 @@ IgvmHandle qigvm_file_init(char *filename, Error **errp)
 }
 
 int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
-                       bool onlyVpContext, Error **errp)
+                       bool onlyVpContext, MachineState *machine_state, Error **errp)
 {
     int32_t header_count;
     QIgvmParameterData *parameter;
@@ -929,6 +931,8 @@ int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
     ctx.cgs = cgs;
     ctx.cgsc = cgs ? CONFIDENTIAL_GUEST_SUPPORT_GET_CLASS(cgs) : NULL;
 
+    ctx.machine_state = machine_state;
+
     /*
      * Check that the IGVM file provides configuration for the current
      * platform
diff --git a/include/system/igvm-cfg.h b/include/system/igvm-cfg.h
index 7dc48677fd..2783fc542e 100644
--- a/include/system/igvm-cfg.h
+++ b/include/system/igvm-cfg.h
@@ -12,6 +12,7 @@
 #ifndef QEMU_IGVM_CFG_H
 #define QEMU_IGVM_CFG_H
 
+#include "hw/boards.h"
 #include "qom/object.h"
 #include "hw/resettable.h"
 
@@ -43,7 +44,7 @@ typedef struct IgvmCfgClass {
      * Returns 0 for ok and -1 on error.
      */
     int (*process)(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
-                   bool onlyVpContext, Error **errp);
+                   bool onlyVpContext, MachineState *machine_state, Error **errp);
 
 } IgvmCfgClass;
 
diff --git a/include/system/igvm.h b/include/system/igvm.h
index ec2538daa0..0afe784a17 100644
--- a/include/system/igvm.h
+++ b/include/system/igvm.h
@@ -14,11 +14,12 @@
 
 #include "system/confidential-guest-support.h"
 #include "system/igvm-cfg.h"
+#include "hw/boards.h"
 #include "qapi/error.h"
 
 IgvmHandle qigvm_file_init(char *filename, Error **errp);
 int qigvm_process_file(IgvmCfg *igvm, ConfidentialGuestSupport *cgs,
-                      bool onlyVpContext, Error **errp);
+                      bool onlyVpContext, MachineState *machine_state, Error **errp);
 
 /* x86 native */
 int qigvm_x86_get_mem_map_entry(int index,
diff --git a/target/i386/sev.c b/target/i386/sev.c
index fd2dada013..a733868043 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1892,7 +1892,7 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
          */
         if (x86machine->igvm) {
             if (IGVM_CFG_GET_CLASS(x86machine->igvm)
-                    ->process(x86machine->igvm, machine->cgs, true, errp) ==
+                    ->process(x86machine->igvm, machine->cgs, true, machine, errp) ==
                 -1) {
                 return -1;
             }
-- 
2.52.0


