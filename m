Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E14D46C16
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 05:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlhMN-0002a0-Bp; Fri, 30 Jan 2026 00:47:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vlhML-0002Uh-7t
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 00:47:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vlhMJ-0005Tr-Dx
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 00:47:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769752074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IJXdOXhspaRHklivBUBRzY+kMbUeEquACPs/3ejqttU=;
 b=gWgNiiiRym+8wBcdYddy/3OpAEZk9pEsZnuBQAFEvj+oe2W4Q0EwMz7p4lfLLk889fYK7Y
 ldv70HNfbW7Uu3842lZBEy5E6dKYegB/2NDLfncV2nATbP8OSenAc2c0NajiIov9nyXkgd
 FI/AM6SZ05scW2rJSL9W/VIJpArOHfM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-Sg-M-CeCMq-A4wCxjfO0AA-1; Fri,
 30 Jan 2026 00:47:47 -0500
X-MC-Unique: Sg-M-CeCMq-A4wCxjfO0AA-1
X-Mimecast-MFC-AGG-ID: Sg-M-CeCMq-A4wCxjfO0AA_1769752066
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC9811954B0C; Fri, 30 Jan 2026 05:47:45 +0000 (UTC)
Received: from osteffen-thinkpadx1carbongen12.rmtde.csb (unknown
 [10.45.226.150])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BAD2119560A2; Fri, 30 Jan 2026 05:47:40 +0000 (UTC)
From: Oliver Steffen <osteffen@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Ani Sinha <anisinha@redhat.com>,
 kvm@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Joerg Roedel <joerg.roedel@amd.com>, Luigi Leonardi <leonardi@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Oliver Steffen <osteffen@redhat.com>
Subject: [PATCH v6 4/9] igvm: Move structs to internal header
Date: Fri, 30 Jan 2026 06:47:09 +0100
Message-ID: <20260130054714.715928-5-osteffen@redhat.com>
In-Reply-To: <20260130054714.715928-1-osteffen@redhat.com>
References: <20260130054714.715928-1-osteffen@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=osteffen@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Move QIgvm and QIgvmParameter struct definitions from the source file
into an IGVM internal header file to allow implementing architecture
specific IGVM code in other places, for example target/i386/igvm.c.

Signed-off-by: Oliver Steffen <osteffen@redhat.com>
---
 backends/igvm.c                | 37 -------------------------------
 include/system/igvm-internal.h | 40 ++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 4cf7b57234..3a3832dc2d 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -25,12 +25,6 @@
 #include <igvm/igvm.h>
 #include <igvm/igvm_defs.h>
 
-typedef struct QIgvmParameterData {
-    QTAILQ_ENTRY(QIgvmParameterData) next;
-    uint8_t *data;
-    uint32_t size;
-    uint32_t index;
-} QIgvmParameterData;
 
 /*
  * Some directives are specific to particular confidential computing platforms.
@@ -66,37 +60,6 @@ struct QEMU_PACKED sev_id_authentication {
 
 #define IGVM_SEV_ID_BLOCK_VERSION 1
 
-/*
- * QIgvm contains the information required during processing
- * of a single IGVM file.
- */
-typedef struct QIgvm {
-    IgvmHandle file;
-    ConfidentialGuestSupport *cgs;
-    ConfidentialGuestSupportClass *cgsc;
-    uint32_t compatibility_mask;
-    unsigned current_header_index;
-    QTAILQ_HEAD(, QIgvmParameterData) parameter_data;
-    IgvmPlatformType platform_type;
-
-    /*
-     * SEV-SNP platforms can contain an ID block and authentication
-     * that should be verified by the guest.
-     */
-    struct sev_id_block *id_block;
-    struct sev_id_authentication *id_auth;
-
-    /* Define the guest policy for SEV guests */
-    uint64_t sev_policy;
-
-    /* These variables keep track of contiguous page regions */
-    IGVM_VHS_PAGE_DATA region_prev_page_data;
-    uint64_t region_start;
-    unsigned region_start_index;
-    unsigned region_last_index;
-    unsigned region_page_count;
-} QIgvm;
-
 static int qigvm_directive_page_data(QIgvm *ctx, const uint8_t *header_data,
                                      Error **errp);
 static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index 171cec8d0f..9c8e887d6f 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -9,10 +9,12 @@
 #ifndef QEMU_IGVM_INTERNAL_H
 #define QEMU_IGVM_INTERNAL_H
 
+#include "qemu/queue.h"
 #include "qemu/typedefs.h"
 #include "qom/object.h"
 #include "hw/core/resettable.h"
 
+#include "system/confidential-guest-support.h"
 #include <igvm/igvm.h>
 
 struct IgvmCfg {
@@ -28,6 +30,44 @@ struct IgvmCfg {
     ResettableState reset_state;
 };
 
+typedef struct QIgvmParameterData {
+    QTAILQ_ENTRY(QIgvmParameterData) next;
+    uint8_t *data;
+    uint32_t size;
+    uint32_t index;
+} QIgvmParameterData;
+
+/*
+ * QIgvm contains the information required during processing of a single IGVM
+ * file.
+ */
+typedef struct QIgvm {
+    IgvmHandle file;
+    ConfidentialGuestSupport *cgs;
+    ConfidentialGuestSupportClass *cgsc;
+    uint32_t compatibility_mask;
+    unsigned current_header_index;
+    QTAILQ_HEAD(, QIgvmParameterData) parameter_data;
+    IgvmPlatformType platform_type;
+
+    /*
+     * SEV-SNP platforms can contain an ID block and authentication
+     * that should be verified by the guest.
+     */
+    struct sev_id_block *id_block;
+    struct sev_id_authentication *id_auth;
+
+    /* Define the guest policy for SEV guests */
+    uint64_t sev_policy;
+
+    /* These variables keep track of contiguous page regions */
+    IGVM_VHS_PAGE_DATA region_prev_page_data;
+    uint64_t region_start;
+    unsigned region_start_index;
+    unsigned region_last_index;
+    unsigned region_page_count;
+} QIgvm;
+
 IgvmHandle qigvm_file_init(char *filename, Error **errp);
 
 #endif
-- 
2.52.0


