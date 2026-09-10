Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D63C79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 23:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4nQ5-0000Y1-Dz; Thu, 10 Sep 2026 18:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lK0-0002Py-7S
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:24:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lJp-0008FW-Qv
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789071666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EbHgYTTTglQemO80px4rrB2L4uzTAs06wcqbum2Jp9A=;
 b=Dv5W6LdE0SEB4XAKAyyBWvfmyhfLS/NUde4FJm4+xmWRPIqvdLnd9rd0KgEKGqPBZbYzXj
 i8MWN43Oo0F/E+F/qPM97VAuGybWnNn+IGQngEdiGq8iNa5wjSpovqexsEZNf87pGIxbhJ
 p96FUZeEsTHTQRbxKbpwrMy/NLmv9g0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-r4eOxOBAMCun2FCdGBIgzA-1; Thu, 10 Sep 2026 16:14:05 -0400
X-MC-Unique: r4eOxOBAMCun2FCdGBIgzA-1
X-Mimecast-MFC-AGG-ID: r4eOxOBAMCun2FCdGBIgzA_1789071244
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49cced8309bso2003015e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071244; x=1789676044; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EbHgYTTTglQemO80px4rrB2L4uzTAs06wcqbum2Jp9A=;
 b=DJlTlvgfLm0hq7Z4cRAfHQGA0Qxin0gn6T7sF8QS/wUteUsdLA+twZcxF8gG/U2tZm
 AQYt4ncHwi8ZD+68OFuJYjIsiGp4YGndszO+pJKUbKPbm8J4j0oPwQ2uk9eV8FvKbq3H
 OU5LkTwyn7BOcbjT97N7gEfmPQxLfCEWcUPk63ZYEKjQjNdsQqV5/r9VxGH3M6xIyfGS
 aczNTHcvz0ZFJlE/91DkwaxDbpVm7Mu29sQsB+sUZ7Hg8VSdl735WEY2qgu9BS/jockM
 wv6SuunkiUyGCPt6zxjHSDS7Xe6bBstWOqLD61r6l+wQp3brsTS+LeFEgKY3wnUxwM5s
 bn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071244; x=1789676044;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EbHgYTTTglQemO80px4rrB2L4uzTAs06wcqbum2Jp9A=;
 b=kxSWL9VNGFUYkwaYetYFn0TKl/6BpHzqGk8aAS857G3NY5TuJ0igwkI6LgVll/KqfE
 rn2FcnUhR0yR6nPagbQHh2ZHJx1N9bjvOWvzFNOJA47lc0hlsw8GT0z5WngZxW4VICWO
 XVoDmHwF7Lt3pvNFqizKsUOY7Pya0g6Vq1fcCmrLVep4M9sosiL2dAHRr5SGjh/EGPBe
 ckolZIPeA5AJ6VUwnOv34J/34ICkZImkGX9aNMjR/98yVsRQ97OxmHJioxmVYn9fwnXv
 w8oPa9AModj64t5kdvSTmd9WTvqu9zsVAhvTKrAUErK2hvqUy0DqZBnyLMvSKFaVuNMf
 OiEg==
X-Gm-Message-State: AFuF++m5ofKsniJbWPKnxikJYzJkQp+TOUx9cj4Kkaj3i9DshaYzBk5O
 DafzYxtsmiEBTfLQUhuAP4tMsPk4Ldtowk/zfAWXjk3MehdS+gCotU9eiPwAA24ID65qHvEUYUz
 92DslPUQ77EGK7pmGYjwItVRrQ6XhKNl5qqZIc6EWmezHyecC/4M9lm6hf0cYJV4/3niTDgzN46
 iU5bQ3CMRjnU8XmmX3st5lboMXozlXOI2c7w==
X-Gm-Gg: AYBFou2Ua5kMNF9xziDbMxnmbmFWowVNpZ4s2oMMaY3DFkhDLw//5sxUzERwNNbNBwQ
 U8fd3LqdiM6WiF4b7Po305opaePUivWJFcD+on26YXoB8hVFGGqo67KT/BJFOJIgrw5cWkCF7qz
 kOic5qkyr+RTFY3HV3eTG9je2J9P5sd7YldB5ztr3aLTBBxWhyaM4qotUErnA2Z2P6iQ7p7IVSW
 7uw6y+1+458howFnOldTzqPiOJ+c9Fu+zkKH81LPbV3YfIE774517IYK+VMfCTa/DUHkMG6uqoD
 bqM2M53XHQ6zO8g/QyCCIHGhch31usG4KxAUEUo6tD6IblMRTCyG4ENJfQSLAxYFztoe3cAolHM
 Q74cS1QXEoOwgQHug2OAQVlQ=
X-Received: by 2002:a05:600c:8b23:b0:49b:9202:6f80 with SMTP id
 5b1f17b1804b1-49e619805b5mr7385395e9.6.1789071243841; 
 Thu, 10 Sep 2026 13:14:03 -0700 (PDT)
X-Received: by 2002:a05:600c:8b23:b0:49b:9202:6f80 with SMTP id
 5b1f17b1804b1-49e619805b5mr7385165e9.6.1789071243384; 
 Thu, 10 Sep 2026 13:14:03 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62121747sm1938275e9.2.2026.09.10.13.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:14:03 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:14:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 61/90] amd_iommu: acpi-build: update PA, GVA and VA size macros
Message-ID: <5aea68d8f088795d1a65ed0d50731d45e72965a7.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Sairaj Kodilkar <sarunkod@amd.com>

Current implementation supports up to 64 bit IOVA and up to 52 bit PA.
Modify related macros so that guest can see right size.

Also, use these macros to build the IVINFO field in the IVRS.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260807061250.27739-4-sarunkod@amd.com>
---
 hw/i386/amd_iommu.h  | 11 ++++++++---
 hw/i386/acpi-build.c |  4 +++-
 hw/i386/amd_iommu.c  |  2 +-
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 687691ec1c..d01f9b41df 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -243,9 +243,14 @@
 #define AMDVI_PAGE_SHIFT_4K 12
 #define AMDVI_PAGE_MASK_4K      GENMASK64(63, 12)
 
-#define AMDVI_MAX_GVA_ADDR      (2UL << 5)
-#define AMDVI_MAX_PH_ADDR       (40UL << 8)
-#define AMDVI_MAX_VA_ADDR       (48UL << 15)
+/*
+ * IOMMU Capability Offset 10h: Miscellaneous Information Register 0.
+ * VAsize[21:15], PAsize[14:8], and GVAsize[7:5].
+ * These fields use the same layout in the IVRS IVinfo Field.
+ */
+#define AMDVI_VA_SIZE_64        (64UL << 15)
+#define AMDVI_PA_SIZE_52        (52UL << 8)
+#define AMDVI_GVA_SIZE_48       (2UL << 5)
 
 /* Completion Wait data size */
 #define AMDVI_COMPLETION_DATA_SIZE    8
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 1696821048..05b68d05a8 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1858,7 +1858,9 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
      */
     build_append_int_noprefix(table_data,
                              (1UL << 0) | /* EFRSup */
-                             (40UL << 8), /* PASize */
+                             AMDVI_GVA_SIZE_48 | /* GVASize:     010b = 48 bits */
+                             AMDVI_PA_SIZE_52 |  /* PASize: 011_0100b = 52 bits */
+                             AMDVI_VA_SIZE_64,   /* VASize: 100_0000b = 64 bits */
                              4);
     /* reserved */
     build_append_int_noprefix(table_data, 0, 8);
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 578c27ccbe..56e7815412 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -2595,7 +2595,7 @@ static void amdvi_pci_realize(PCIDevice *pdev, Error **errp)
                  0xff000000);
     pci_set_long(pdev->config + s->capab_offset + AMDVI_CAPAB_MISC, 0);
     pci_set_long(pdev->config + s->capab_offset + AMDVI_CAPAB_MISC,
-            AMDVI_MAX_PH_ADDR | AMDVI_MAX_GVA_ADDR | AMDVI_MAX_VA_ADDR);
+            AMDVI_PA_SIZE_52 | AMDVI_GVA_SIZE_48 | AMDVI_VA_SIZE_64);
 }
 
 static void amdvi_sysbus_reset(DeviceState *dev)
-- 
MST


