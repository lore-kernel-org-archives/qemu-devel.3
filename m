Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F4BCED624
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 12:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLKiT-0004t2-CD; Tue, 18 Nov 2025 07:21:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vLKiQ-0004r7-Fy
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 07:21:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vLKiP-0005Hv-4H
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 07:21:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763468504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nAeTjmgqoilYb7echaBt27tnizEGJUjLY1rSJl9if8c=;
 b=cr38T7Crs6HYmI5kenVTQQoXgYWRjsLATKcWdmz8S3lmLFnyOdYCXdoM1+CtuOXUqeimha
 u8j4DI2rIxRpaVkHVDOzPysP9ooq8k/1qMkOBv+DeernGwaGWXR7YN1qyiEbYYqZXQQZhS
 FTengSKHXfLCuNxzTkjYH2o/T4CuAH0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-Ma_3a52dMOSnikmSxuF3iA-1; Tue,
 18 Nov 2025 07:21:41 -0500
X-MC-Unique: Ma_3a52dMOSnikmSxuF3iA-1
X-Mimecast-MFC-AGG-ID: Ma_3a52dMOSnikmSxuF3iA_1763468500
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4847018AB42D; Tue, 18 Nov 2025 12:21:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.167])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D7FD1955F1B; Tue, 18 Nov 2025 12:21:39 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 895F7182C027; Tue, 18 Nov 2025 13:21:33 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>, Oliver Steffen <osteffen@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 3/4] igvm: add trace point for igvm file loading and processing
Date: Tue, 18 Nov 2025 13:21:31 +0100
Message-ID: <20251118122133.1695767-4-kraxel@redhat.com>
In-Reply-To: <20251118122133.1695767-1-kraxel@redhat.com>
References: <20251118122133.1695767-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/igvm.c       | 5 +++++
 backends/trace-events | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/backends/igvm.c b/backends/igvm.c
index 05d197fdfe85..a350c890cc95 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -18,6 +18,8 @@
 #include "system/address-spaces.h"
 #include "hw/core/cpu.h"
 
+#include "trace.h"
+
 #include <igvm/igvm.h>
 #include <igvm/igvm_defs.h>
 
@@ -884,6 +886,8 @@ IgvmHandle qigvm_file_init(char *filename, Error **errp)
         error_setg(errp, "Unable to parse IGVM file %s: %d", filename, igvm);
         return -1;
     }
+
+    trace_igvm_file_loaded(filename, igvm);
     return igvm;
 }
 
@@ -901,6 +905,7 @@ int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
         return -1;
     }
     ctx.file = cfg->file;
+    trace_igvm_process_file(cfg->file, onlyVpContext);
 
     /*
      * The ConfidentialGuestSupport object is optional and allows a confidential
diff --git a/backends/trace-events b/backends/trace-events
index 45ac46dc2454..7a00e9bf6c16 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -26,3 +26,5 @@ iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, u
 igvm_reset_enter(int type) "type=%u"
 igvm_reset_hold(int type) "type=%u"
 igvm_reset_exit(int type) "type=%u"
+igvm_file_loaded(const char *fn, int32_t handle) "fn=%s, handle=0x%x"
+igvm_process_file(int32_t handle, bool context_only) "handle=0x%x context-only=%d"
-- 
2.51.1


