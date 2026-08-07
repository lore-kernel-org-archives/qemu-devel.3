Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31348C5AC81
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 05:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsD69-0001It-5n; Fri, 07 Aug 2026 01:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wsD67-0001IX-Cm
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 01:26:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wsD65-0000jP-PR
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 01:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786080381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oyr4GIu9nnuR3+KUBEFmE8MavH0ehn7PwDYD/eNOVzQ=;
 b=ViYE9taBmqlwYyUczAN+vS+A8oon1D1iz/8Oe79S5uSewz3L7ySdIgIg2mijNOQYWMuJM2
 WV5yXtrO0xJlx0KYWx4Ui6bb9FY9XOTls7bUkd9mkp1eFQarJnr5lkGprJRZwtTVH3khyC
 xM2Z0B7oHKaHoCAmRtNTu9Xc2jOhp5I=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-VfIQUJooMI-ccfcgMzy5YA-1; Fri, 07 Aug 2026 01:26:17 -0400
X-MC-Unique: VfIQUJooMI-ccfcgMzy5YA-1
X-Mimecast-MFC-AGG-ID: VfIQUJooMI-ccfcgMzy5YA_1786080376
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-385d2703b64so1640392a91.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 22:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786080376; x=1786685176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oyr4GIu9nnuR3+KUBEFmE8MavH0ehn7PwDYD/eNOVzQ=;
 b=a5oiBSz9Neg/CPu0MCuiHA+3lOZcnJtSDnEpXN3o756mxagi3kZ+0CLTgdVq/MA25R
 cXrmRIuLDep/2LTkHEhBjcLF0MJPZN2n4Ti9iwsNEb2MBBJTpOnGqThrWdHEJSH/myLk
 yB5p0zXwIbp5io5iWLft2m9/2OhFvSiv/aZSgZHYNJPtgsT9XLJ3rKt0pICfcc8nXoKf
 7cgACcra+W+hTj3Tn4644Q3PEQKUL0XoIFlv2fzAfjBLUGNmDR+VVGaNAuYNy3FrgOc2
 c58O18s1NOn9zvS73wFgveCEXy0MsQklZcEa10IEV4FnxihAlehbWGU42gs536i3jaNi
 v++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786080376; x=1786685176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oyr4GIu9nnuR3+KUBEFmE8MavH0ehn7PwDYD/eNOVzQ=;
 b=madRaw9dRan+X0s3oTPAMr04gB3kcacRqCZgie80IazbA3/PY7t8A85izPn2AjpV4M
 gdzKN353khIRsX0jEROTGnbLGZhIi4/aZkSZdJ4ZReAOdHc2+2XGImDDY0jBVDGAvbia
 sarGyFPdcjmy3sVxnpq9COM2gbPs5e3WCzg1Wbbun8HnmtB++CZ7pY/Pov/9rneoZ1kq
 D/zqxNzmFYSGWrX/q9lzFoEMs1Eh0Z6BJZRKHShrEQlSLHR4yA7A9afP4wmcC+z/IkwB
 0WTJ8BTjZnP2UFtqdIABe81Clg938ihA20BJRBSAQWGcoHHr6Qt20ry58l7zvJ3ZPEpo
 AGjQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpe5pByNNVuSFJwGlll6W8zL52ByHw0Za+AEziWy5F/JAAovros3rgaoyCmVCI9WSre0pDAbT5EqrbV@nongnu.org
X-Gm-Message-State: AOJu0YyfkhueIe0QJEPBFuPH9mziCFYRoHHxqz8zUy7WDRG+oz4KqVJI
 E91b0ePKfRsoEoTbzAMkmrw/hMObVwykxA09p4/tqnfpMriMaNlQCiFHBeEF8XAbOg0N3hYIN4L
 oQ8iAF0dtCaxf5tt9UySJQgPjABtP33mhEc1rB4JRAqDo8fd2hJM6nXR6
X-Gm-Gg: AR+sD12cY2QMyGuOH4b+jQv69d61oRICxfM33/dETmWMnuJsp4Hyz/7FmvO7IvYg36Z
 k6JmwohynpQ7j4c/fN6KvSRhk80z3vdwjlWOldq2NrgCqZ++wbrAos++lMAIkfk2TAnRLw81jJN
 0VtKI+xyfWdGc9T2T+HuxTggIITZpEWE7Lu+rCnCZH5OHbQClmzY7UzH+O8ypoa9aqWwbaAN4EK
 pgJkARiS3EGRKz89DVGMQx4ENG55pzBEoAFU4FIBtGSA9GQvYuoFT2PKJYghrlRqezLwCf9l7TR
 UhoEDz9ya3wsWkF0rlWJhfgH0rx514/ZS3e4IFuLp3Zr8OtEOxPzOCie1M1GlKAU5mm6IlkNCE+
 w5knXJZINjQ1lusFwptah4FdQutnOEadALw==
X-Received: by 2002:a17:90b:528c:b0:384:927f:3db9 with SMTP id
 98e67ed59e1d1-3908972ccb7mr4193059a91.1.1786080376327; 
 Thu, 06 Aug 2026 22:26:16 -0700 (PDT)
X-Received: by 2002:a17:90b:528c:b0:384:927f:3db9 with SMTP id
 98e67ed59e1d1-3908972ccb7mr4193038a91.1.1786080375811; 
 Thu, 06 Aug 2026 22:26:15 -0700 (PDT)
Received: from rhel9-box.lan ([106.219.133.98])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3908616d21esm3316334a91.17.2026.08.06.22.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 22:26:15 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: agraf@csgraf.de,
	graf@amazon.com,
	qemu-devel@nongnu.org
Subject: [PATCH v4 03/11] igvm: cleanup memory regions
Date: Fri,  7 Aug 2026 10:55:45 +0530
Message-ID: <20260807052559.50643-4-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260807052559.50643-1-anisinha@redhat.com>
References: <20260807052559.50643-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Gerd Hoffmann <kraxel@redhat.com>

This change cleans up existing memory regions that were created by the current
IGVM. The cleanup would be necessary when a new IGVM is loaded. This cleanup
function is called in a subsequent patch.

Reviewed-by: Alexander Graf <graf@amazon.com>
Tested-by: Ani Sinha <anisinha@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/igvm-cfg.c   |  2 ++
 backends/igvm.c       | 19 +++++++++++++++++++
 include/system/igvm.h |  1 +
 3 files changed, 22 insertions(+)

diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
index 38438a7b1e..935ba54f54 100644
--- a/backends/igvm-cfg.c
+++ b/backends/igvm-cfg.c
@@ -52,6 +52,8 @@ static void igvm_reset_hold(Object *obj, ResetType type)
 
     trace_igvm_reset_hold(type);
 
+    /* cleanup existing memory regions first */
+    qigvm_cleanup_memory(igvm);
     qigvm_process_file(igvm, ms, false, &error_fatal);
 }
 
diff --git a/backends/igvm.c b/backends/igvm.c
index 9e7c90d386..9b101c8182 100644
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
diff --git a/include/system/igvm.h b/include/system/igvm.h
index 64d3542311..e219f1a4ed 100644
--- a/include/system/igvm.h
+++ b/include/system/igvm.h
@@ -20,6 +20,7 @@ typedef struct QIgvm QIgvm;
 
 int qigvm_process_file(IgvmCfg *igvm, MachineState *machine_state,
                        bool onlyVpContext, Error **errp);
+void qigvm_cleanup_memory(IgvmCfg *igvm);
 
 /* x86 native */
 int qigvm_x86_get_mem_map_entry(int index,
-- 
2.42.0


