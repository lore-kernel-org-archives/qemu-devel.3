Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11B4C5DF93
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 16:12:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxRq0-0006Zj-MH; Fri, 21 Aug 2026 12:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wxRpy-0006Y3-ES
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 12:11:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wxRpx-0001aZ-0i
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 12:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787328680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hTsrtmm6zAVtEaNueaYmf+4CzykffyTMsO6iRQfbyEM=;
 b=OpaPW5Chn+4+r2+z8OpwuBPej0oOXhyaQIQtPwfSaPPxjwx3munNm9VpkuOPdKDo56BZRh
 ZONTEOokFKcqNnfTy2BHmFHOvfFOmjnhY7Td2gO0NAOOFprGHL5BeuIqW1pYkSYOkfikAt
 IcFnZdM6qYsz6x/9s8jSCvLxm3bCscU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-3h5JWwRsOZqdJcVhr2V9Vw-1; Fri,
 21 Aug 2026 12:11:11 -0400
X-MC-Unique: 3h5JWwRsOZqdJcVhr2V9Vw-1
X-Mimecast-MFC-AGG-ID: 3h5JWwRsOZqdJcVhr2V9Vw_1787328669
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E59F31954B20; Fri, 21 Aug 2026 16:11:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.30])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9743C7D6; Fri, 21 Aug 2026 16:11:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9282618007A3; Fri, 21 Aug 2026 18:11:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Gerd Hoffman <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <graf@amazon.com>
Subject: [PULL 04/12] igvm: cleanup memory regions
Date: Fri, 21 Aug 2026 18:10:52 +0200
Message-ID: <20260821161103.3489298-5-kraxel@redhat.com>
In-Reply-To: <20260821161103.3489298-1-kraxel@redhat.com>
References: <20260821161103.3489298-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This change cleans up existing memory regions that were created by the current
IGVM. The cleanup would be necessary when a new IGVM is loaded. This cleanup
function is called in a subsequent patch.

Reviewed-by: Alexander Graf <graf@amazon.com>
Tested-by: Ani Sinha <anisinha@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260817142010.80693-4-anisinha@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/system/igvm.h |  1 +
 backends/igvm-cfg.c   |  2 ++
 backends/igvm.c       | 19 +++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/include/system/igvm.h b/include/system/igvm.h
index 64d3542311ae..e219f1a4edb4 100644
--- a/include/system/igvm.h
+++ b/include/system/igvm.h
@@ -20,6 +20,7 @@ typedef struct QIgvm QIgvm;
 
 int qigvm_process_file(IgvmCfg *igvm, MachineState *machine_state,
                        bool onlyVpContext, Error **errp);
+void qigvm_cleanup_memory(IgvmCfg *igvm);
 
 /* x86 native */
 int qigvm_x86_get_mem_map_entry(int index,
diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
index 38438a7b1e2c..935ba54f54f3 100644
--- a/backends/igvm-cfg.c
+++ b/backends/igvm-cfg.c
@@ -52,6 +52,8 @@ static void igvm_reset_hold(Object *obj, ResetType type)
 
     trace_igvm_reset_hold(type);
 
+    /* cleanup existing memory regions first */
+    qigvm_cleanup_memory(igvm);
     qigvm_process_file(igvm, ms, false, &error_fatal);
 }
 
diff --git a/backends/igvm.c b/backends/igvm.c
index 9e7c90d386d1..9b101c81824e 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -14,6 +14,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/target-info-qapi.h"
+#include "migration/vmstate.h"
 #include "system/igvm.h"
 #include "system/igvm-cfg.h"
 #include "system/igvm-internal.h"
@@ -1109,3 +1110,21 @@ cleanup_parameters:
 cleanup:
     return retval;
 }
+
+/*
+ * cleanup any memory regions created by qigvm_prepare_memory()
+ */
+void qigvm_cleanup_memory(IgvmCfg *cfg)
+{
+    IgvmMemoryRegion *imr, *tmp;
+
+    QTAILQ_FOREACH_SAFE(imr, &cfg->memory_regions, next, tmp)
+    {
+        memory_region_del_subregion(get_system_memory(), imr->mr);
+        vmstate_unregister_ram(imr->mr, NULL);
+        QTAILQ_REMOVE(&cfg->memory_regions, imr, next);
+        /* this triggers MemoryRegion cleanup */
+        object_unparent(OBJECT(imr->mr));
+        g_free(imr);
+    }
+}
-- 
2.55.0


