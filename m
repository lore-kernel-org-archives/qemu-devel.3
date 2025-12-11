Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6959BD41C20
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 10:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTeJo-0007EP-MZ; Thu, 11 Dec 2025 05:54:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vTeJf-0007Bf-Id
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 05:54:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vTeJd-0005XC-Sa
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 05:54:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765450473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jllFb4lPPs3aua/s4mbXOmB0JJq73rvZH4XwtxYwvAY=;
 b=EixUP+XMLl2XKL5Yh95t3ebuxjtALL2mu38NKx3okOzlvc7OyrvGi4lecZCRwjoNhl1yCv
 K0+GZBqIrXC2H6dRO808+EwcJKIrDI8YWUFK9+9AGFrEAGnpY9gh7itnyjStPS5UuKo3hE
 guHk30thuB6IP3n3SZ1HWD8ehqmjxVY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-SOMOQ7xSPwiYAGrBu4P2WA-1; Thu,
 11 Dec 2025 05:54:29 -0500
X-MC-Unique: SOMOQ7xSPwiYAGrBu4P2WA-1
X-Mimecast-MFC-AGG-ID: SOMOQ7xSPwiYAGrBu4P2WA_1765450468
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B69B4195609F; Thu, 11 Dec 2025 10:54:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.156])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA5E1180045B; Thu, 11 Dec 2025 10:54:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2F3A41800DD4; Thu, 11 Dec 2025 11:54:20 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Oliver Steffen <osteffen@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH v2 4/5] igvm: add trace points for igvm file loading and
 processing
Date: Thu, 11 Dec 2025 11:54:18 +0100
Message-ID: <20251211105419.3573449-5-kraxel@redhat.com>
In-Reply-To: <20251211105419.3573449-1-kraxel@redhat.com>
References: <20251211105419.3573449-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 backends/igvm.c       | 5 +++++
 backends/trace-events | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/backends/igvm.c b/backends/igvm.c
index a01e01a12a60..4cf7b572347c 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -20,6 +20,8 @@
 #include "system/address-spaces.h"
 #include "hw/core/cpu.h"
 
+#include "trace.h"
+
 #include <igvm/igvm.h>
 #include <igvm/igvm_defs.h>
 
@@ -886,6 +888,8 @@ IgvmHandle qigvm_file_init(char *filename, Error **errp)
         error_setg(errp, "Unable to parse IGVM file %s: %d", filename, igvm);
         return -1;
     }
+
+    trace_igvm_file_loaded(filename, igvm);
     return igvm;
 }
 
@@ -903,6 +907,7 @@ int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
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
2.52.0


