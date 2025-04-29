Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313E9C3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 13:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9koP-0000Mo-KM; Tue, 29 Apr 2025 09:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u9koO-0000Mc-2p
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 09:15:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u9koM-00046o-2U
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 09:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745932544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+NpR0xYOkKIQmVHmAyuyMZPnLq40++Dt46hOxtxCL3s=;
 b=NfEBX2nM8pDBxHzJ+FU+2e2Mr0AveaQWN8kCjcHmVxnef6kvX5pIqn1Utv+kRoQbmljWea
 JuUb5WWDPUGHeqfxRrWybsSCGo/Rhzv8rAU/eG1SWpP3G7npQuWe5NBWg4F/KzdM60+Dmc
 redWX2vVfYGO0NIEHASGwSaK5garxXw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-3Lc8bXtXPOy2W2awP4i9DQ-1; Tue,
 29 Apr 2025 09:15:40 -0400
X-MC-Unique: 3Lc8bXtXPOy2W2awP4i9DQ-1
X-Mimecast-MFC-AGG-ID: 3Lc8bXtXPOy2W2awP4i9DQ_1745932539
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB41F1956088; Tue, 29 Apr 2025 13:15:38 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.98])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BF701180087B; Tue, 29 Apr 2025 13:15:35 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, devel@lists.libvirt.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 2/5] include/hw/boards: cope with dev/rc versions in
 deprecation checks
Date: Tue, 29 Apr 2025 14:15:23 +0100
Message-ID: <20250429131526.1842130-3-berrange@redhat.com>
In-Reply-To: <20250429131526.1842130-1-berrange@redhat.com>
References: <20250429131526.1842130-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When VERSION is set to a development snapshot (micro >= 50), or a release
candidate (micro >= 90) we have an off-by-1 in determining deprecation
and deletion thresholds for versioned machine types. In such cases we need
to use the next major/minor version in threshold checks.

This adapts the deprecation macros to do "next version" prediction when
seeing a dev/rc version number.

This ensures users of release candidates get an accurate view of machines
that will be deprecated/deleted in the final release.

This requires hardcoding our current release policy of 3 releases per
year, with a major bump at the start of each year, and that dev/rc
versions have micro >= 50.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/hw/boards.h | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 74a8e96b2e..a6784fe984 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -650,11 +650,42 @@ struct MachineState {
     " years old are subject to deletion after " \
     stringify(MACHINE_VER_DELETION_MAJOR) " years"
 
-#define _MACHINE_VER_IS_EXPIRED_IMPL(cutoff, major, minor) \
+#define _MACHINE_VER_IS_CURRENT_EXPIRED(cutoff, major, minor) \
     (((QEMU_VERSION_MAJOR - major) > cutoff) || \
      (((QEMU_VERSION_MAJOR - major) == cutoff) && \
       (QEMU_VERSION_MINOR - minor) >= 0))
 
+#define _MACHINE_VER_IS_NEXT_MINOR_EXPIRED(cutoff, major, minor) \
+    (((QEMU_VERSION_MAJOR - major) > cutoff) || \
+     (((QEMU_VERSION_MAJOR - major) == cutoff) && \
+      ((QEMU_VERSION_MINOR + 1) - minor) >= 0))
+
+#define _MACHINE_VER_IS_NEXT_MAJOR_EXPIRED(cutoff, major, minor) \
+    ((((QEMU_VERSION_MAJOR + 1) - major) > cutoff) ||            \
+     ((((QEMU_VERSION_MAJOR + 1) - major) == cutoff) &&          \
+      (0 - minor) >= 0))
+
+/*
+ * - The first check applies to formal releases
+ * - The second check applies to dev snapshots / release candidates
+ *   where the next major version is the same.
+ *   e.g. 9.0.50, 9.1.50, 9.0.90, 9.1.90
+ * - The third check applies to dev snapshots / release candidates
+ *   where the next major version will change.
+ *   e.g. 9.2.50, 9.2.90
+ *
+ * NB: this assumes we do 3 minor releases per year, before bumping major,
+ * and dev snapshots / release candidates are numbered with micro >= 50
+ * If this ever changes the logic below will need modifying....
+ */
+#define _MACHINE_VER_IS_EXPIRED_IMPL(cutoff, major, minor) \
+    ((QEMU_VERSION_MICRO < 50 && \
+      _MACHINE_VER_IS_CURRENT_EXPIRED(cutoff, major, minor)) || \
+     (QEMU_VERSION_MICRO >= 50 && QEMU_VERSION_MINOR < 2 && \
+      _MACHINE_VER_IS_NEXT_MINOR_EXPIRED(cutoff, major, minor)) || \
+     (QEMU_VERSION_MICRO >= 50 && QEMU_VERSION_MINOR == 2 && \
+      _MACHINE_VER_IS_NEXT_MAJOR_EXPIRED(cutoff, major, minor)))
+
 #define _MACHINE_VER_IS_EXPIRED2(cutoff, major, minor) \
     _MACHINE_VER_IS_EXPIRED_IMPL(cutoff, major, minor)
 #define _MACHINE_VER_IS_EXPIRED3(cutoff, major, minor, micro) \
-- 
2.49.0


