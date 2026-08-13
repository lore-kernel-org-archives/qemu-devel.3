Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7748C5CFEB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuSm6-0005wd-RW; Thu, 13 Aug 2026 06:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wuSm5-0005w7-HL
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 06:35:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wuSm3-00009g-VT
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 06:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786617299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oyr4GIu9nnuR3+KUBEFmE8MavH0ehn7PwDYD/eNOVzQ=;
 b=cQRz3W8RXiV0GPWSqIY/Nv/ijyDSYLrB8CKyXsk0Vg5XSr9BaWHUmNVTl6HqykgH6iSpqt
 KODGhtllRUVzHgHTwGsxbSCSpmLn8oNU06ioIC/f6NSI7hH0aS2g7NJwQkZ3/hKB1km0Oj
 NyoZA+fh/aRmbggY9AYfJewFp6E5aPg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-LJ7d0MSxP8qMEhcSbMNwFw-1; Thu, 13 Aug 2026 06:34:57 -0400
X-MC-Unique: LJ7d0MSxP8qMEhcSbMNwFw-1
X-Mimecast-MFC-AGG-ID: LJ7d0MSxP8qMEhcSbMNwFw_1786617297
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38dde0df80bso3229453a91.3
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 03:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786617297; x=1787222097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oyr4GIu9nnuR3+KUBEFmE8MavH0ehn7PwDYD/eNOVzQ=;
 b=gJphr1SIppt+uqSy5O15i4KnP5Ku2AG++lHYejAOgnJ0zcS2CvFGQd6vTECpw/WJOC
 WjemAPEgtFGKar08jpW22BegLKcsduB5krPlhVh1Rq9jDRj8kXqXamMJukuNxgPtb4Uu
 eG3gErn5vnsxHE1YUzejjngvOlHbovnYiJVGiYwIMtkOnave4W762NDWFeWpfRFyKkhg
 01039T4B9sO+ZPo0FQG3qzH1KTCxmsSE6pCojsadb1X8UNzUZgAYqKIPqrOQ3WD9YVJ9
 JC2kY9GN8g5gmJpCMP+0bcZhSpBQ/PBLEgCVlMe48TZTH1kbUCUAn5dGO5gyFoWtWjc8
 8rlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786617297; x=1787222097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oyr4GIu9nnuR3+KUBEFmE8MavH0ehn7PwDYD/eNOVzQ=;
 b=HR4eL1b+cGeCgryDTP26VLwrQJfBnzDWZrysb1P5FyzqaRL87OjfHjh70EdcYM80qk
 6e12CFQJiFZTGQRbokg+bljd/XLg0HuL8H+qVzeoHJOxzAr+8YbvT6NpW5lug45pHyja
 Jt6wysCTwarYVuuoLRB4wcxrsV6bMJYAN91albHVtQ4ieo49fWguxdFvhu+IN2z9qPrW
 9CFH3fVi+JUpNwQGIaoWV5mYYKqvSQP4EQgSQHEai43VzEMWgfmGE6Ri+RLo/AbOqMJk
 4vOFMM/stfRrBpfb5zy74/KKGnk6Z0MQn19njWR5Pt935zP+MPZjcKXjhspx7qeCfYpP
 BitQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrpkNtA3EOJa/6YG2E9S6XOIrRQM3qtyk5MCdxASKyLNAVmwPakcDl6jDlt+2qxVvUvy2htUAEZZELQ@nongnu.org
X-Gm-Message-State: AOJu0YwOUcE5gcX7XEAyd91UpnqjMg8WQ/oVqRGIPMNY3zVm3d6bFEPo
 KFU5Ve7hcGv2RLIBGmh6Gi1Wm5gHTt9wj4naLrCKlprVu1UuVWoySdcMzsu10TOw5mgdrRVuv30
 aARTn79EPtCruKesIQ1PyMLPVulwJobjwZrR4hnopTNDYoTLww+xNsQDO
X-Gm-Gg: AR+sD13ufMn0Df+JNbLgniZFGj0OgUpLj2d4vo1myKWlX6anbxSm3I92IdlCL2v97UT
 fH20EG8TB2bUS1DWhBmIaApDjqjYhDJdH5HwzosSHzCLJubpd6XrxmGffh2lq3h/KmKcu6mdOvy
 hWTKvNyfXSKnYLSilB6Cb0oyNrk4VIMjy7CWqsKjRWriN3jMx0lIJKWMRPh4X2OAy+5JdRlhJjX
 ZFRrWKO9ddv+41l+4br2sgqyRXbAglBTBAUxKhS/p1XHwjWaSukej7FhJHU07nBk9m+rISK/jmR
 2M30nHIIh51wx7vEKVGJcxXdAOp65aaARq8WJsQV4wvO5M92ufjbYvhv+AuEchiGL9IvVspmEoe
 5Wl5vUsYhJfO1ftYccUgYDWc2olKoJUhXnA==
X-Received: by 2002:a17:90b:52cf:b0:38e:9e9d:9209 with SMTP id
 98e67ed59e1d1-3931e278f94mr5196270a91.17.1786617296754; 
 Thu, 13 Aug 2026 03:34:56 -0700 (PDT)
X-Received: by 2002:a17:90b:52cf:b0:38e:9e9d:9209 with SMTP id
 98e67ed59e1d1-3931e278f94mr5196210a91.17.1786617296155; 
 Thu, 13 Aug 2026 03:34:56 -0700 (PDT)
Received: from rhel9-box.lan ([106.219.133.98])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3931ced0781sm2918093a91.11.2026.08.13.03.34.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 03:34:55 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: ani@anisinha.ca, agraf@csgraf.de, graf@amazon.com, qemu-devel@nongnu.org
Subject: [PATCH v5 03/11] igvm: cleanup memory regions
Date: Thu, 13 Aug 2026 16:04:05 +0530
Message-ID: <20260813103425.24474-4-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260813103425.24474-1-anisinha@redhat.com>
References: <20260813103425.24474-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


