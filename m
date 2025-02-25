Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4084BC021BB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 20:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn1Av-0005dm-R9; Tue, 25 Feb 2025 15:05:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tn1Aq-0005cz-JF
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 15:05:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tn1An-000453-Od
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 15:04:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740513897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OiRdKc8kc+lAB0iX44vSdY3uEOe5MHpol+/aR6KeNw0=;
 b=HnRJzBhb3AN5/tGfhyjYWpJ+jTVekzKIigBilLSddeZdB3fbrm3C8R018oxwAobz/+Khde
 sDh6Yl1+QSdUf+RzOlebkVYU3vn2cnO6ZPpAAzyYlrFAB190uqDtgTxqtoTPdEuelftFKV
 oagiI9YsvEb5r9dj5XTjtRSE8LCuChk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-XxtGZQXPMTOEDNHj0_WOzg-1; Tue,
 25 Feb 2025 15:04:50 -0500
X-MC-Unique: XxtGZQXPMTOEDNHj0_WOzg-1
X-Mimecast-MFC-AGG-ID: XxtGZQXPMTOEDNHj0_WOzg_1740513886
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7A511979057; Tue, 25 Feb 2025 20:04:45 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.59])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 435701800359; Tue, 25 Feb 2025 20:04:42 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 4/4] include/hw/boards: add warning about changing deprecation
 logic
Date: Tue, 25 Feb 2025 20:04:23 +0000
Message-ID: <20250225200423.2350471-5-berrange@redhat.com>
In-Reply-To: <20250225200423.2350471-1-berrange@redhat.com>
References: <20250225200423.2350471-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

If we change the deprecation logic in include/hw/boards.h, we must make
a corresponding change to docs/conf.py and docs/about/deprecated.rst.
Add comments to these files as a warning to future maintainers to keep
these files in sync.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/conf.py        | 4 ++++
 include/hw/boards.h | 6 +++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/docs/conf.py b/docs/conf.py
index 8b567787ce..d0d3cd10ce 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -129,6 +129,10 @@
     else:
         minor += 1
 
+# These thresholds must match the constants
+# MACHINE_VER_DELETION_MAJOR  & MACHINE_VER_DEPRECATION_MAJOR
+# defined in include/hw/boards.h and the introductory text in
+# docs/about/deprecated.rst
 ver_machine_deprecation_version = "%d.%d.%d" % (major - 3, minor, micro)
 ver_machine_deletion_version = "%d.%d.%d" % (major - 6, minor, micro)
 
diff --git a/include/hw/boards.h b/include/hw/boards.h
index dcfb251cbd..a89a885add 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -633,7 +633,11 @@ struct MachineState {
 /*
  * How many years/major releases for each phase
  * of the life cycle. Assumes use of versioning
- * scheme where major is bumped each year
+ * scheme where major is bumped each year.
+ *
+ * These values must match the ver_machine_deprecation_version
+ * and ver_machine_deletion_version logic in docs/conf.py and
+ * the text in docs/about/deprecated.rst
  */
 #define MACHINE_VER_DELETION_MAJOR 6
 #define MACHINE_VER_DEPRECATION_MAJOR 3
-- 
2.47.1


