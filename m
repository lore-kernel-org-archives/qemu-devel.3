Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9F0D2127C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 11:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1OnV-0005Cb-6B; Thu, 17 Oct 2024 07:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1OmJ-00046G-WD
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 07:35:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1OmE-00060C-OA
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 07:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729164879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3bfXIQ3a1H+u6eRCza5sO5zZIDf50gdhjDguQOt/2CY=;
 b=i055oJGvQQclGXWB+/j7rc+f860aYA8YVRtTfWNx4Op/7uwxIeKy00D/yWIafBh1ob6E1Q
 m1hWIA17o7pvMaXSR3I6VdjzEbVDRdKmWtYi+emUDDODC/VyfwwBkRCTzF4A714wzbxkq6
 ncNsk5+yhc8RZs7SK7ZryZ4TG8LuDRo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-312TxuEqP-OqPu6QUXu6IQ-1; Thu,
 17 Oct 2024 07:34:38 -0400
X-MC-Unique: 312TxuEqP-OqPu6QUXu6IQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9F8019560B6
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 11:34:37 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.94])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 96A5619560A2; Thu, 17 Oct 2024 11:34:36 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 28/31] util: adapt to new import path for qobject data type
 headers
Date: Thu, 17 Oct 2024 12:33:40 +0100
Message-ID: <20241017113344.883424-29-berrange@redhat.com>
In-Reply-To: <20241017113344.883424-1-berrange@redhat.com>
References: <20241017113344.883424-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The qobject data type headers have moved from qapi/qmp/ to
qobject/.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 util/keyval.c      | 6 +++---
 util/qemu-config.c | 4 ++--
 util/qemu-option.c | 8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/util/keyval.c b/util/keyval.c
index 66a5b4740f..a70629a481 100644
--- a/util/keyval.c
+++ b/util/keyval.c
@@ -91,9 +91,9 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qstring.h"
 #include "qemu/cutils.h"
 #include "qemu/keyval.h"
 #include "qemu/help_option.h"
diff --git a/util/qemu-config.c b/util/qemu-config.c
index a90c18dad2..d1fc49c507 100644
--- a/util/qemu-config.c
+++ b/util/qemu-config.c
@@ -1,8 +1,8 @@
 #include "qemu/osdep.h"
 #include "block/qdict.h" /* for qdict_extract_subqdict() */
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 201f7a87f3..770300dff1 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -27,10 +27,10 @@
 
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qbool.h"
+#include "qobject/qdict.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/option_int.h"
 #include "qemu/cutils.h"
-- 
2.46.0


