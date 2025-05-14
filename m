Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C24C3ABD9
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 08:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF7UB-0006jC-K3; Wed, 14 May 2025 04:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uF7U8-0006c4-HH; Wed, 14 May 2025 04:29:04 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uF7U6-0006GC-CJ; Wed, 14 May 2025 04:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747211343; x=1778747343;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XcfqfXhzwMnZCQ8ssMQpFUaIWpIFYFQwZh6vh4Z+M54=;
 b=NiO1WSZr7Qd9DYR9LGTEUrF0KvqzzcDDL7GpoxH9pwPKWCvHUk/s9mba
 c/5oO+MUDkXPmhIODZdnmZhnRFy9Th2A+BKTOSzRUmxm3Key1JZy101tu
 /iw9ndNzf5pY7l1VckNWFwQ/UVZ+XZKW+g9+R47fTa+EaH9cW8JKMdMbl
 2v1df77LBIVfspa+2ZUyssAvdfycwZfnoRaSMtDAYTgRdMDC1KceOsK+E
 vN0dLAz+JgyuN4MmsFVfMw2TGgfOkwj3SIPOgllNVXO7xZau716FY4XgL
 j1pze7LJcFuhRpWCP0M+ZcR3wSnlxbEbaIz4WQBCdIMygsI0BIbmiY9V6 A==;
X-CSE-ConnectionGUID: rgTAyvQiSwC0rRa3upkV9A==
X-CSE-MsgGUID: W/hBv8vmRCifpwJdYCONBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="66505579"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="66505579"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 01:29:00 -0700
X-CSE-ConnectionGUID: dEgjz3DOSZavm5HX5+IRZA==
X-CSE-MsgGUID: mDvUXlf2TZajHn5CvXhD9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="169065815"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 14 May 2025 01:28:57 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH 3/9] hw/acpi/pci: Consolidate
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
Date: Wed, 14 May 2025 16:49:51 +0800
Message-Id: <20250514084957.2221975-4-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514084957.2221975-1-zhao1.liu@intel.com>
References: <20250514084957.2221975-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The QOM types of AcpiGenericInitiator and AcpiGenericPort are declared
by OBJECT_DECLARE_SIMPLE_TYPE, which means they don't need the class!

Therefore, use OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES to implement
the type, then there's no need for class definition.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/acpi/pci.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
index d511a8502954..acac6744525e 100644
--- a/hw/acpi/pci.c
+++ b/hw/acpi/pci.c
@@ -75,16 +75,12 @@ typedef struct AcpiGenericInitiator {
     uint32_t node;
 } AcpiGenericInitiator;
 
-typedef struct AcpiGenericInitiatorClass {
-    ObjectClass parent_class;
-} AcpiGenericInitiatorClass;
-
 #define TYPE_ACPI_GENERIC_INITIATOR "acpi-generic-initiator"
 
-OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericInitiator, acpi_generic_initiator,
-                   ACPI_GENERIC_INITIATOR, OBJECT,
-                   { TYPE_USER_CREATABLE },
-                   { NULL })
+OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(AcpiGenericInitiator, acpi_generic_initiator,
+                                          ACPI_GENERIC_INITIATOR, OBJECT,
+                                          { TYPE_USER_CREATABLE },
+                                          { NULL })
 
 OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericInitiator, ACPI_GENERIC_INITIATOR)
 
@@ -191,16 +187,12 @@ typedef struct AcpiGenericPort {
     uint32_t node;
 } AcpiGenericPort;
 
-typedef struct AcpiGenericPortClass {
-    ObjectClass parent_class;
-} AcpiGenericPortClass;
-
 #define TYPE_ACPI_GENERIC_PORT "acpi-generic-port"
 
-OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericPort, acpi_generic_port,
-                   ACPI_GENERIC_PORT, OBJECT,
-                   { TYPE_USER_CREATABLE },
-                   { NULL })
+OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(AcpiGenericPort, acpi_generic_port,
+                                          ACPI_GENERIC_PORT, OBJECT,
+                                          { TYPE_USER_CREATABLE },
+                                          { NULL })
 
 OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericPort, ACPI_GENERIC_PORT)
 
-- 
2.34.1


