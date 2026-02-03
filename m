Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92110E7FDCF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 12:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnF8l-00083D-3t; Tue, 03 Feb 2026 07:04:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vnF8T-0007jq-Up
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:04:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vnF8S-0007eu-Gv
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:04:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770120239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qkdoZn+iKo45E0fUEaUBU7em89paVKCLSORYybGXFeU=;
 b=RL/NZkiv7ysaXZA6DDLXc4VbBs+jRAQaJgWmYwVL639+/Zfor3u+jLPBT+G4SDDqcchZ/U
 PIilA2QSg5/ZlNnsXkUnErGsvs3NGrh274lxauDvIRmuuSNR1Fj91j2tug95XYIQho1ktw
 QEPQymJP4WHEr3RrHzUXH74JcWu+GXM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-sHcz83X3P3-8Trh607mlOw-1; Tue,
 03 Feb 2026 07:03:56 -0500
X-MC-Unique: sHcz83X3P3-8Trh607mlOw-1
X-Mimecast-MFC-AGG-ID: sHcz83X3P3-8Trh607mlOw_1770120235
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4AA85195422D; Tue,  3 Feb 2026 12:03:55 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.34.28])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 606811955F16; Tue,  3 Feb 2026 12:03:54 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EFBAD1800988; Tue, 03 Feb 2026 13:03:43 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Gerd Hoffmann <kraxel@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
Subject: [PULL 07/17] igvm: add trace points for igvm file loading and
 processing
Date: Tue,  3 Feb 2026 13:03:32 +0100
Message-ID: <20260203120343.656961-8-kraxel@redhat.com>
In-Reply-To: <20260203120343.656961-1-kraxel@redhat.com>
References: <20260203120343.656961-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
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

Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260126123755.357378-5-kraxel@redhat.com>
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
index 87e0c636ec02..8dc64a20d3d9 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -28,3 +28,5 @@ iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uin
 igvm_reset_enter(int type) "type=%u"
 igvm_reset_hold(int type) "type=%u"
 igvm_reset_exit(int type) "type=%u"
+igvm_file_loaded(const char *fn, int32_t handle) "fn=%s, handle=0x%x"
+igvm_process_file(int32_t handle, bool context_only) "handle=0x%x context-only=%d"
-- 
2.52.0


