Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B919C021B8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 20:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn1Ab-0005Zc-Es; Tue, 25 Feb 2025 15:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tn1AZ-0005ZG-Ey
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 15:04:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tn1AX-00042W-QI
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 15:04:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740513880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6/tsqTCLvYLjGViWEIjEmON2Q5fWig/xvrp6/qFGRhA=;
 b=MIVhGCbYIsDFvCaBwkBmIqLRulsDDu163KdRsgZtGZFX9UbCUmlS7bGnMZBFSDdlgYttnh
 IdgeP8fbhv7jUa5eIZ/pwTGVFLy+hYGQkNnr+jiUKQ12kF+byAYuAMNwWWQC7qjDoCLOfA
 vJDPzK2kmFh7LPp3Xz4Qct/3OoJ94LU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-c1bTPcPVNJOyNFvnFGRGjg-1; Tue,
 25 Feb 2025 15:04:35 -0500
X-MC-Unique: c1bTPcPVNJOyNFvnFGRGjg-1
X-Mimecast-MFC-AGG-ID: c1bTPcPVNJOyNFvnFGRGjg_1740513874
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C61691800873; Tue, 25 Feb 2025 20:04:33 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.59])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 610811800357; Tue, 25 Feb 2025 20:04:29 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/4] include/hw/boards: cope with dev/rc versions in
 deprecation checks
Date: Tue, 25 Feb 2025 20:04:20 +0000
Message-ID: <20250225200423.2350471-2-berrange@redhat.com>
In-Reply-To: <20250225200423.2350471-1-berrange@redhat.com>
References: <20250225200423.2350471-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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
index 9360d1ce39..dcfb251cbd 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -647,11 +647,42 @@ struct MachineState {
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
2.47.1


