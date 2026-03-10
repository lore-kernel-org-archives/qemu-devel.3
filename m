Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5836BFD2D79
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 13:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzx2H-00089r-MC; Tue, 10 Mar 2026 09:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vzx2F-000890-2E
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:22:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vzx2D-0006VG-KO
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773148924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bWghBUkeSE3zI2cdCfl1UKaHfHhMgE7oEA7r9bNf++E=;
 b=Vg+WTWpzwYwJGhUuib/3Vbkn/07HMV8CpUArkcAMVrDX1neG7aqte+xyaQRQ1y8Xq5DRCw
 oqMVy3fLqvKwFNKfQxWQmQhsLvhEkVVI3Phhfn+qqukRYPzPMUBHIZ+m+WGD8QmH4XOPRp
 uYy6IoWxMjojIKHxNYFbl9b4A5i1gU0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-7si1zSQGNJiQhW1BCcNKQg-1; Tue,
 10 Mar 2026 09:22:01 -0400
X-MC-Unique: 7si1zSQGNJiQhW1BCcNKQg-1
X-Mimecast-MFC-AGG-ID: 7si1zSQGNJiQhW1BCcNKQg_1773148920
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A499180056E; Tue, 10 Mar 2026 13:22:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.225.19])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE5DA180035F; Tue, 10 Mar 2026 13:21:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id F3F681800865; Tue, 10 Mar 2026 14:21:54 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>
Subject: [PULL 2/3] igvm: fix build when igvm is not installed in a well known
 path
Date: Tue, 10 Mar 2026 14:21:53 +0100
Message-ID: <20260310132154.2783257-3-kraxel@redhat.com>
In-Reply-To: <20260310132154.2783257-1-kraxel@redhat.com>
References: <20260310132154.2783257-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

From: Luigi Leonardi <leonardi@redhat.com>

`stubs/igvm.c` includes `igvm-internal.h`, that in turn includes the igvm library.
This is required just for the QIgvm declaration and creates an
unnecessary dependency on the library.

Since igvm is not listed as a dependency of stubs, this results in build
failing when the library is not installed in a "well known" path of the
system.

Add a forward declaration for QIgvm and move the definition of
`qigvm_directive_madt` to `igvm.h` so that we can drop `igvm-internal.h` from
`stubs/igvm.c`.

Fixes: dea1f68a5c ("igvm: Fill MADT IGVM parameter field on x86_64")
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
Message-ID: <20260309-master-v2-1-7e02f07a1096@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/qemu/typedefs.h        | 1 +
 include/system/igvm-internal.h | 9 ++-------
 include/system/igvm.h          | 5 +++++
 stubs/igvm.c                   | 1 -
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 416a8c9acead..cbe6f7f4c7c1 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -102,6 +102,7 @@ typedef struct QEMUSGList QEMUSGList;
 typedef struct QemuSpin QemuSpin;
 typedef struct QEMUTimer QEMUTimer;
 typedef struct QEMUTimerListGroup QEMUTimerListGroup;
+typedef struct QIgvm QIgvm;
 typedef struct QList QList;
 typedef struct QNull QNull;
 typedef struct QNum QNum;
diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index 38004bd908e7..76ae1bc3be92 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -42,7 +42,7 @@ typedef struct QIgvmParameterData {
  * QIgvm contains the information required during processing of a single IGVM
  * file.
  */
-typedef struct QIgvm {
+struct QIgvm {
     IgvmHandle file;
     MachineState *machine_state;
     ConfidentialGuestSupportClass *cgsc;
@@ -67,16 +67,11 @@ typedef struct QIgvm {
     unsigned region_start_index;
     unsigned region_last_index;
     unsigned region_page_count;
-} QIgvm;
+};
 
 IgvmHandle qigvm_file_init(char *filename, Error **errp);
 
 QIgvmParameterData*
 qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index);
 
-/*
- *  IGVM parameter handlers
- */
-int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp);
-
 #endif
diff --git a/include/system/igvm.h b/include/system/igvm.h
index 5573a6111ae7..f9231f03ec80 100644
--- a/include/system/igvm.h
+++ b/include/system/igvm.h
@@ -27,4 +27,9 @@ int qigvm_x86_get_mem_map_entry(int index,
 int qigvm_x86_set_vp_context(void *data, int index,
                              Error **errp);
 
+/*
+ *  IGVM parameter handlers
+ */
+int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp);
+
 #endif
diff --git a/stubs/igvm.c b/stubs/igvm.c
index 47d5130d9d74..9e9f683fc960 100644
--- a/stubs/igvm.c
+++ b/stubs/igvm.c
@@ -12,7 +12,6 @@
 #include "qemu/osdep.h"
 
 #include "system/igvm.h"
-#include "system/igvm-internal.h"
 
 int qigvm_x86_get_mem_map_entry(int index,
                                 ConfidentialGuestMemoryMapEntry *entry,
-- 
2.53.0


