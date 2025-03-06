Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644EAC28B25
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 09:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq7ed-000064-TD; Thu, 06 Mar 2025 04:36:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tq7eb-00005X-GJ
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 04:36:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tq7eV-0002Cq-1x
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 04:36:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741253785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3VOhtzA6w/ZsRKC5No020cqS/j8Hoqulo9VM1qIuy6E=;
 b=YCfiq8XFxsiHKeRmfZUTkO8VEJsIwbiboz29EHxVcMqyIzbTLfw/t8JlINPW3FRzfbbL93
 k06I7agUyctsy0AQM6DPraLrJyU4EEMZf1by2bLOiZh41U8ClkVV66cNjlGmAzP9Uy9m8B
 rDVRYUtC85V3r1Ar7ByVtosrVGwk5M8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-IaoGbr5rPOug1bhKai3heA-1; Thu,
 06 Mar 2025 04:36:08 -0500
X-MC-Unique: IaoGbr5rPOug1bhKai3heA-1
X-Mimecast-MFC-AGG-ID: IaoGbr5rPOug1bhKai3heA_1741253768
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 041E41801A00
 for <qemu-devel@nongnu.org>; Thu,  6 Mar 2025 09:36:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6993518009BC
 for <qemu-devel@nongnu.org>; Thu,  6 Mar 2025 09:36:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D090B21E6560; Thu, 06 Mar 2025 10:36:01 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 08/10] qdev: Improve PropertyInfo member @description for enum
 properties
Date: Thu,  6 Mar 2025 10:35:59 +0100
Message-ID: <20250306093601.2264772-9-armbru@redhat.com>
In-Reply-To: <20250306093601.2264772-1-armbru@redhat.com>
References: <20250306093601.2264772-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Message-ID: <20250227085601.4140852-6-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/core/qdev-properties-system.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 0ac1485d54..6d7dcf368d 100644
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


