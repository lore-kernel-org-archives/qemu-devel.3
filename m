Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1929CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcGZF-00072W-WC; Wed, 24 Jun 2026 01:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wcGZD-00071Z-I1
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 01:54:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wcGZ8-00064b-L3
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 01:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782280465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pDd03COlLGY3G5rHg6IQzNdZVrq4oPUHbOZUxRyvGHY=;
 b=BWNLvyVo1qq7u4h4DV7wt503crd8DoBp9Cgisv2YcFHIffRdM2C2xqlZLwtSOipcN4X3m7
 XU/8kCfAzBR2y/FkvoX226MQonrdVDeGwQ72kYLJ2ZCM+eA0nuSHPd2kGJv1QxV2gJQac+
 FT8fh0z/Ye7+S5fu7ppAvPXUPNqizDg=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-X41QGKCxN82CwDcmJjcTug-1; Wed, 24 Jun 2026 01:54:21 -0400
X-MC-Unique: X41QGKCxN82CwDcmJjcTug-1
X-Mimecast-MFC-AGG-ID: X41QGKCxN82CwDcmJjcTug_1782280460
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c0d568830so2385186eec.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 22:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782280460; x=1782885260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pDd03COlLGY3G5rHg6IQzNdZVrq4oPUHbOZUxRyvGHY=;
 b=qROXlG9vzci/IuSMCCy7LmQnKo2RRfwZ5rdqbmlURzlnk++heO6w2AXbbR42JEvEOi
 D9rDjwFQ3oQLUMYZ21omFe/w+z+8AYQZgdSTcU/rccZXufYVRSpcBZw46LG0rXb+bj+W
 tSQztQRy5cE7C3Qdj4eVYTr0hxVnHowg3pcqdaIfedp+NJMgJhczjYIJ1NGwp/KtqbcK
 n33Jak+depVU1BJHuoIuSiaZElIG3yCOmz/8bzZJLZJJfyHnmO/MwvKSOHVwEgoqwsbO
 5lq+y5RxKaBKBBIBezblNdYqz8iUptXWhoDVsnevxJ5x6pwFRebE7oF1GX7jo2aog2V/
 mMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782280460; x=1782885260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pDd03COlLGY3G5rHg6IQzNdZVrq4oPUHbOZUxRyvGHY=;
 b=IAPfcSppUuiGeUa75xRX1mF7w9PGMR78Xy17NU+IQcQVgiqnM6FpgDPcjZ9ABtPZJD
 XLBNw1yQHUQMuh7/QD6GnwMGW8Ty6UIuVLiV6GkS1jY3k0uPG6pWtbdEZqCNg2e0JE/u
 dTxjSG/Jo8HYRfxPSpFklFfvhfTUwPC3fQNNF3rln6kHDyNVqBvQkSkDKynV8pDEDWjc
 PTXXiuu41UUxMJXMwyDGqWSXrcT+zogkPfk2iTeev7aNOuZL83bkNLMnqAgb5GlyyGf6
 HSJzcyfr3Wd6MEYYpxfOnRhP7zOiJDQbFRxgZsigzXVbuUkpaimyx0CtSbvN5GYQdF7h
 xJag==
X-Gm-Message-State: AOJu0YxTVA6uSUPPxN+MmukFBYjIODbEIouCtnjedwWxAH7hyca9P9Po
 /bVoPPgTxwxFPzwlTbJSJtzAZ1XrDGyB545aBSdK4maKYW5y5xXPW5G1SvdVmMUabUEl3ClVUp6
 dcCloo6GnHLC7oiZcTzQlxAIHx7im1khUVAXj/GLASQk/NeEv8rR5sEqR
X-Gm-Gg: AfdE7cnUtlauUaE+M7++a6IjpZ6p+VgsRLJMwlIgGzG9aBX1zkZN+oyCee+RQNeAV+G
 Pu/RSAuWPJZ1h9F5hQs7Y3n/bE0EyHyssYSQfcRg0QthTQAbhOcYd6KWQRluKlZVDGrPrM2GNVF
 6PsumJUkap1tvxdM67PK6kcrfcA0iTGhxj8EdzFn5BoIY+ak1e4vF34pJf7DKrwAfogv0nSCaIX
 0LTIj+qvUdX4FVcMJgAgx0+Ul9LlWD/D7GmtbAgCZ6ZVJ/2VYHJRjFkkKJaFnHx9zrVhCd3Sb80
 wBbLiqsEMpJDG7y8PKSqvbZ5uJ8nEkHS1wllyJtuH1mhCV1kQRAjqBFIdnyBoNnimvR2gyw0Gve
 YvKggoz+VsSLW/0Q6ZYB0mZvapIWPdwQtbfcbAC6Npm4m
X-Received: by 2002:a05:7300:d4c5:b0:2d1:d434:cfe3 with SMTP id
 5a478bee46e88-30c587e82e0mr5591569eec.0.1782280460130; 
 Tue, 23 Jun 2026 22:54:20 -0700 (PDT)
X-Received: by 2002:a05:7300:d4c5:b0:2d1:d434:cfe3 with SMTP id
 5a478bee46e88-30c587e82e0mr5591556eec.0.1782280459658; 
 Tue, 23 Jun 2026 22:54:19 -0700 (PDT)
Received: from rhel9-box.lan ([110.227.100.91])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d6edsm21075803eec.14.2026.06.23.22.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 22:54:19 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v1 3/8] igvm: cleanup memory regions
Date: Wed, 24 Jun 2026 11:23:25 +0530
Message-ID: <20260624055339.46862-4-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260624055339.46862-1-anisinha@redhat.com>
References: <20260624055339.46862-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/igvm.c       | 17 +++++++++++++++++
 include/system/igvm.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/backends/igvm.c b/backends/igvm.c
index 1c9751812d..61040d1be2 100644
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
@@ -1046,3 +1047,19 @@ cleanup_parameters:
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
+        memory_region_del_subregion(get_system_memory(), &imr->mr);
+        vmstate_unregister_ram(&imr->mr, NULL);
+        QTAILQ_REMOVE(&cfg->memory_regions, imr, next);
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


