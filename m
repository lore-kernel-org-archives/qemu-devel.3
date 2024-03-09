Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F852C54E60
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 07:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rirbZ-00066R-J0; Sat, 09 Mar 2024 02:58:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rirbW-000663-Sp
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 02:58:50 -0500
Received: from out-173.mta1.migadu.com ([2001:41d0:203:375::ad])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rirbV-00013P-3a
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 02:58:50 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1709971127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=raHbR+3aJ1OqO7Ee0/aS7Kg2+66MX0gCeuiZHMCm28s=;
 b=xjsAr0737FL/uu+5urtlHGWf+mHSEbDWcHWDf7k9QzuQ6PPgd2A/rTQVUxxRTe7HdxEYu+
 VxYleaphc4Bjs+45tWSAN/HV9Q3+vqnVDtxudRkzuUypwxDyzzgauS6GsuVPAylo+KqjEp
 t5T4ku8ttr7hT8j1uwKtg+P/bFPnTt4=
From: Hao Xiang <hao.xiang@linux.dev>
To: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v5 6/7] migration/multifd: Enable multifd zero page checking
 by default.
Date: Sat,  9 Mar 2024 07:57:27 +0000
Message-Id: <20240309075728.1487211-7-hao.xiang@linux.dev>
In-Reply-To: <20240309075728.1487211-1-hao.xiang@linux.dev>
References: <20240309075728.1487211-1-hao.xiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::ad;
 envelope-from=hao.xiang@linux.dev; helo=out-173.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Hao Xiang <hao.xiang@bytedance.com>

1. Set default "zero-page-detection" option to "multifd". Now
zero page checking can be done in the multifd threads and this
becomes the default configuration.
2. Handle migration QEMU9.0 -> QEMU8.2 compatibility. We provide
backward compatibility where zero page checking is done from the
migration main thread.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 hw/core/machine.c   | 4 +++-
 migration/options.c | 2 +-
 qapi/migration.json | 6 +++---
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 9ac5d5389a..0e9d646b61 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -32,7 +32,9 @@
 #include "hw/virtio/virtio-net.h"
 #include "audio/audio.h"
 
-GlobalProperty hw_compat_8_2[] = {};
+GlobalProperty hw_compat_8_2[] = {
+    { "migration", "zero-page-detection", "legacy"},
+};
 const size_t hw_compat_8_2_len = G_N_ELEMENTS(hw_compat_8_2);
 
 GlobalProperty hw_compat_8_1[] = {
diff --git a/migration/options.c b/migration/options.c
index 8c849620dd..d61d31be24 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -181,7 +181,7 @@ Property migration_properties[] = {
                       MIG_MODE_NORMAL),
     DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
                        parameters.zero_page_detection,
-                       ZERO_PAGE_DETECTION_LEGACY),
+                       ZERO_PAGE_DETECTION_MULTIFD),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
diff --git a/qapi/migration.json b/qapi/migration.json
index 2684e4e9ac..aa1b39bce1 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -909,7 +909,7 @@
 #        (Since 8.2)
 #
 # @zero-page-detection: Whether and how to detect zero pages.
-#     See description in @ZeroPageDetection.  Default is 'legacy'.
+#     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
 # Features:
@@ -1106,7 +1106,7 @@
 #        (Since 8.2)
 #
 # @zero-page-detection: Whether and how to detect zero pages.
-#     See description in @ZeroPageDetection.  Default is 'legacy'.
+#     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
 # Features:
@@ -1339,7 +1339,7 @@
 #        (Since 8.2)
 #
 # @zero-page-detection: Whether and how to detect zero pages.
-#     See description in @ZeroPageDetection.  Default is 'legacy'.
+#     See description in @ZeroPageDetection.  Default is 'multifd'.
 #     (since 9.0)
 #
 # Features:
-- 
2.30.2


