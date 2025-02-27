Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB53CC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 08:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnZgs-0003en-VL; Thu, 27 Feb 2025 03:56:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnZgl-0003dM-Pk
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 03:56:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnZgj-0001kz-MA
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 03:56:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740646573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=APifhp3j6n4W5oWPDH4oxmGTRnbnrNQc5kXxVnbO/RQ=;
 b=WO9gs28OHWTtbEVy3aqp0LcAWqJVIO4ogLPKFIon8Pqlx8O/2zm/vWo0lfx53fWGlHh8CL
 unQbyYyFdwTPr3QuV4Dyu1123hBVI3MPDULZ+w/njhXLMRDbDFcUprVitsEP193QTzC/3v
 CcuiXtPbdSNsl0RA7F04qijpdUwHtE0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-a07nHNgjPTaTyetwIrA6Hg-1; Thu,
 27 Feb 2025 03:56:08 -0500
X-MC-Unique: a07nHNgjPTaTyetwIrA6Hg-1
X-Mimecast-MFC-AGG-ID: a07nHNgjPTaTyetwIrA6Hg_1740646568
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC3D219560BC; Thu, 27 Feb 2025 08:56:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 822DC180094B; Thu, 27 Feb 2025 08:56:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1680121E65FD; Thu, 27 Feb 2025 09:56:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	berrange@redhat.com,
	eduardo@habkost.net
Subject: [PATCH v2 5/6] qdev: Improve PropertyInfo member @description for
 enum properties
Date: Thu, 27 Feb 2025 09:56:00 +0100
Message-ID: <20250227085601.4140852-6-armbru@redhat.com>
In-Reply-To: <20250227085601.4140852-1-armbru@redhat.com>
References: <20250227085601.4140852-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Consistently use format "DESCRIPTION (VALUE/VALUE...)".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/core/qdev-properties-system.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 21f67d42f8..aa7600bce6 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -603,6 +603,7 @@ QEMU_BUILD_BUG_ON(sizeof(LostTickPolicy) != sizeof(int));
 
 const PropertyInfo qdev_prop_losttickpolicy = {
     .type  = "LostTickPolicy",
+    .description = "Policy for handling lost ticks (discard/delay/slew)",
     .enum_table  = &LostTickPolicy_lookup,
     .get   = qdev_propinfo_get_enum,
     .set   = qdev_propinfo_set_losttickpolicy,
@@ -642,8 +643,7 @@ QEMU_BUILD_BUG_ON(sizeof(BlockdevOnError) != sizeof(int));
 
 const PropertyInfo qdev_prop_blockdev_on_error = {
     .type = "BlockdevOnError",
-    .description = "Error handling policy, "
-                   "report/ignore/enospc/stop/auto",
+    .description = "Error handling policy (report/ignore/enospc/stop/auto)",
     .enum_table = &BlockdevOnError_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
@@ -656,8 +656,8 @@ QEMU_BUILD_BUG_ON(sizeof(BiosAtaTranslation) != sizeof(int));
 
 const PropertyInfo qdev_prop_bios_chs_trans = {
     .type = "BiosAtaTranslation",
-    .description = "Logical CHS translation algorithm, "
-                   "auto/none/lba/large/rechs",
+    .description = "Logical CHS translation algorithm "
+                   " (auto/none/lba/large/rechs)",
     .enum_table = &BiosAtaTranslation_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
@@ -668,8 +668,7 @@ const PropertyInfo qdev_prop_bios_chs_trans = {
 
 const PropertyInfo qdev_prop_fdc_drive_type = {
     .type = "FloppyDriveType",
-    .description = "FDC drive type, "
-                   "144/288/120/none/auto",
+    .description = "Floppy drive type (144/288/120/none/auto)",
     .enum_table = &FloppyDriveType_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
@@ -680,8 +679,8 @@ const PropertyInfo qdev_prop_fdc_drive_type = {
 
 const PropertyInfo qdev_prop_multifd_compression = {
     .type = "MultiFDCompression",
-    .description = "multifd_compression values, "
-                   "none/zlib/zstd/qpl/uadk/qatzip",
+    .description = "multifd_compression values"
+                   " (none/zlib/zstd/qpl/uadk/qatzip)",
     .enum_table = &MultiFDCompression_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
@@ -694,8 +693,7 @@ QEMU_BUILD_BUG_ON(sizeof(MigMode) != sizeof(int));
 
 const PropertyInfo qdev_prop_mig_mode = {
     .type = "MigMode",
-    .description = "mig_mode values, "
-                   "normal,cpr-reboot",
+    .description = "Migration mode (normal/cpr-reboot)",
     .enum_table = &MigMode_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
@@ -708,8 +706,7 @@ QEMU_BUILD_BUG_ON(sizeof(GranuleMode) != sizeof(int));
 
 const PropertyInfo qdev_prop_granule_mode = {
     .type = "GranuleMode",
-    .description = "granule_mode values, "
-                   "4k, 8k, 16k, 64k, host",
+    .description = "Granule page size (4k/8k/16k/64k/host)",
     .enum_table = &GranuleMode_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
@@ -718,8 +715,7 @@ const PropertyInfo qdev_prop_granule_mode = {
 
 const PropertyInfo qdev_prop_zero_page_detection = {
     .type = "ZeroPageDetection",
-    .description = "zero_page_detection values, "
-                   "none,legacy,multifd",
+    .description = "Zero page detection (none/legacy/multifd)",
     .enum_table = &ZeroPageDetection_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
@@ -1232,7 +1228,7 @@ QEMU_BUILD_BUG_ON(sizeof(S390CpuEntitlement) != sizeof(int));
 
 const PropertyInfo qdev_prop_cpus390entitlement = {
     .type  = "S390CpuEntitlement",
-    .description = "low/medium (default)/high",
+    .description = "auto/low/medium/high (default medium)",
     .enum_table  = &S390CpuEntitlement_lookup,
     .get   = qdev_propinfo_get_enum,
     .set   = qdev_propinfo_set_enum,
-- 
2.48.1


