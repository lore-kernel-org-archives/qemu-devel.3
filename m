Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4744C54FDF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 07:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpKxP-00088P-77; Thu, 30 Jul 2026 03:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wpKxN-00087K-KY
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 03:13:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wpKxL-0007v7-Vk
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 03:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785395607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TcjFc/7/NHyuFbF0/DRanapEJL83S3ru+B67fe+lavo=;
 b=aVqTXsamNL4jJBm/AQjJrSO8AxJl6A6Xm1PM8/mwZrQclfAN0xBAcx0roU9NUO4hFQ91Wk
 C4tfbQhM+4udLw46Aej5T/v6DcZaNd5EGo8GDIw69sYYF/IffVoHhW5RfQRnl7WkE8yqtg
 UgDRAhCGUAMTxNVzLsA7pclt9F5+4p0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-dFfu1CWUNFaF2LoyXkwadA-1; Thu, 30 Jul 2026 03:13:25 -0400
X-MC-Unique: dFfu1CWUNFaF2LoyXkwadA-1
X-Mimecast-MFC-AGG-ID: dFfu1CWUNFaF2LoyXkwadA_1785395604
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc73f47bdcso31846535ad.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 00:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785395604; x=1786000404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TcjFc/7/NHyuFbF0/DRanapEJL83S3ru+B67fe+lavo=;
 b=nKy2dgSie8F79yZ2DTiSWa1hE+9LzPonKcGnWOVTz84sYDt03kDRPNytSW8Zh54tEH
 94jdVbdKUeE9NzMyAae1hIiFyxnas9YQ0UDYGgFsGX9F2NFBqKp2HdJGyWjXl0Trs1Nb
 hej3j9MwHqOGWagAV2MSmeBW9kDFKreJEZYzH4zfE+cAh77Zxfi2cbpBbiSw/KB+AxWK
 D3kvlVhX4mDmORGmkGeAoc3CwDLcGTs35ZbcKUVbzxQ6hu6B+NrVIytC+xPnKyDORHde
 hhzznBXAud4UzWuYPex2lSrxQUxWm85VcB0nSCuT7EmaL6xwWGMJRiddfhv35BcO8ZEV
 /E7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785395604; x=1786000404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TcjFc/7/NHyuFbF0/DRanapEJL83S3ru+B67fe+lavo=;
 b=q10Fnh0pcx68EXe9/0A7DzmJ09dZ3+IAU8MIZ+aIj56DBpXQXfsqI4Vq5pVmsckGrJ
 4l6tlt1pthsk5tYMH7BnotZ3iwdmn3K2WRd/mJ5n23mQj7zGzoeyj4b8jTexYr7Twb+2
 Q6wzZBEKm+ltY+3ZgPI3DTVvxVAy+hGA0GdssLDz1yDRsMfnQtq6nMgWs1i9dnvGJ5EJ
 YdV1P+JZzaAbiU53M24w8MD1hcAWRnAOmOcGdqLxAImpU1Ymqh/0ahxAfT6IlUXAwiCr
 pDc32bwHMGfgsh/maX8i2ssu8ifUTxfamFcjg5Du0G8+EB663Ho2mQBkPLBZZF7cksv0
 Cxbw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqtc8VD2M9bfdLyyBbMAvCqt5ZgWmsNhP1XhpBp0xANYl1r+JoQZujwasHlYjw83IcJJqu0xeQimD2L@nongnu.org
X-Gm-Message-State: AOJu0YzL+u3XFjGqnPSHsRmC5sQglERyjjyrLIWOlO82CdPARHYPH/pj
 KzrjZPgZ/FVoDtcoPw4cgF2Hpa8CkM2iV1AC/+MhcixoUQaPH/Zcw3ntL8eL3DbxaywbEPoEdH3
 SNvc8xax+sCcLNxvXnXPPEksSQAYZPNcddq2B32Yfys8G/+fAlWMRwt3qiUok6R+6
X-Gm-Gg: AR+sD10LYbvAD46NqoM4DKAypGdJOrekT5tNrvw1U5dqg+FEFMd1ayhJJ4thOFD92uX
 KIVlPHpA4z6n63QO0VjLYTuFqZY/ODkSxw5K+V9+WEtP5ekXQRd4SuwUF+BKFhh33bITux2oZI+
 HNy/lgKNqBrmevzLInisLoIr8PqudxqNZNlb4VIy/Yfn2hhp6o3qwR6di/DCNCWhfm0AsboEEpa
 Ex1M6t6ODXBdAxZGFPzbBztMZAr8eMRHQ/iDhHNsbvrsiEt/Q5ZZ8lQjNYk36fsDQ2qkZZgPPJB
 l68E+J1ofKUDftmON8yD3AA/o+DQ7BfUACzxMgi2WL7ambc2/KkRLZtbMgyxWVSS34tCHsiYYxj
 O8a9sQd7sENDlUwPO0TAPqm1M52UqSK7i7x8=
X-Received: by 2002:a17:903:2c0e:b0:2c8:25c8:85a6 with SMTP id
 d9443c01a7336-2d035b99bccmr15963725ad.2.1785395604260; 
 Thu, 30 Jul 2026 00:13:24 -0700 (PDT)
X-Received: by 2002:a17:903:2c0e:b0:2c8:25c8:85a6 with SMTP id
 d9443c01a7336-2d035b99bccmr15963535ad.2.1785395603834; 
 Thu, 30 Jul 2026 00:13:23 -0700 (PDT)
Received: from rhel9-box.lan ([223.236.229.143])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2d022a15893sm21864835ad.4.2026.07.30.00.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 00:13:23 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: graf@amazon.com,
	agraf@csgraf.de,
	qemu-devel@nongnu.org
Subject: [PATCH v3 2/9] igvm: track memory regions
Date: Thu, 30 Jul 2026 12:42:29 +0530
Message-ID: <20260730071254.80695-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260730071254.80695-1-anisinha@redhat.com>
References: <20260730071254.80695-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

Memory regions added by the current IGVM needs to be tracked so that they can be
freed when a new IGVM is loaded.

Reviewed-by: Ani Sinha <anisinha@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/igvm-cfg.c            |  1 +
 backends/igvm.c                | 20 ++++++++++++--------
 include/system/igvm-internal.h |  6 ++++++
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
index e1f09855f6..38438a7b1e 100644
--- a/backends/igvm-cfg.c
+++ b/backends/igvm-cfg.c
@@ -65,6 +65,7 @@ static void igvm_complete(UserCreatable *uc, Error **errp)
     IgvmCfg *igvm = IGVM_CFG(uc);
 
     igvm->file = qigvm_file_init(igvm->filename, errp);
+    QTAILQ_INIT(&igvm->memory_regions);
 }
 
 OBJECT_DEFINE_TYPE_WITH_INTERFACES(IgvmCfg, igvm_cfg, IGVM_CFG, OBJECT,
diff --git a/backends/igvm.c b/backends/igvm.c
index 534032fed8..9e7c90d386 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -220,7 +220,7 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
                                   int region_identifier, Error **errp)
 {
     ERRP_GUARD();
-    MemoryRegion *igvm_pages = NULL;
+    IgvmMemoryRegion *imr = NULL;
     Int128 gpa_region_size;
     MemoryRegionSection mrs =
         memory_region_find(get_system_memory(), addr, size);
@@ -254,23 +254,27 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
          */
         g_autofree char *region_name =
             g_strdup_printf("igvm.%X", region_identifier);
-        igvm_pages = g_new0(MemoryRegion, 1);
+        imr = g_new0(IgvmMemoryRegion, 1);
+        imr->mr = g_new0(MemoryRegion, 1);
         if (ctx->machine_state->cgs &&
             ctx->machine_state->cgs->require_guest_memfd) {
-            if (!memory_region_init_ram_guest_memfd(igvm_pages, NULL,
+            if (!memory_region_init_ram_guest_memfd(imr->mr, NULL,
                                                     region_name, size, errp)) {
-                g_free(igvm_pages);
+                g_free(imr->mr);
+                g_free(imr);
                 return NULL;
             }
         } else {
-            if (!memory_region_init_ram(igvm_pages, NULL, region_name, size,
+            if (!memory_region_init_ram(imr->mr, NULL, region_name, size,
                                         errp)) {
-                g_free(igvm_pages);
+                g_free(imr->mr);
+                g_free(imr);
                 return NULL;
             }
         }
-        memory_region_add_subregion(get_system_memory(), addr, igvm_pages);
-        return memory_region_get_ram_ptr(igvm_pages);
+        memory_region_add_subregion(get_system_memory(), addr, imr->mr);
+        QTAILQ_INSERT_TAIL(&ctx->cfg->memory_regions, imr, next);
+        return memory_region_get_ram_ptr(imr->mr);
     }
 }
 
diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index b5720fae0c..9e9fa1d9af 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -18,6 +18,11 @@
 #include "system/confidential-guest-support.h"
 #include <igvm/igvm.h>
 
+typedef struct IgvmMemoryRegion {
+    QTAILQ_ENTRY(IgvmMemoryRegion) next;
+    MemoryRegion *mr;
+} IgvmMemoryRegion;
+
 struct IgvmCfg {
     Object parent_obj;
 
@@ -29,6 +34,7 @@ struct IgvmCfg {
     char *filename;
     IgvmHandle file;
     ResettableState reset_state;
+    QTAILQ_HEAD(, IgvmMemoryRegion) memory_regions;
 };
 
 typedef struct QIgvmParameterData {
-- 
2.42.0


