Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBB6D2A531
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 11:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1OnR-0004x9-Nr; Thu, 17 Oct 2024 07:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1Oll-000406-3f
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 07:34:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1Oli-0005uT-Kw
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 07:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729164853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m79rHudUL2hWNdsUnadMZw2GisFUrVMb0BOV7wifV8E=;
 b=dK/c5kInfEj0vJUowA1P/gObFo3Xx6e3foc1P7D7Cg4Sq10R82FEoKuDGIT/4i+jcBMFY4
 0aJwdSm+HF32ZyvfnZl4ZoY3BE1Ew2jIijPbet40bflZWsjeMVqIhXei2XF7gG3+oNldDf
 WfrzcQpn/76mUlppzRaODuwgnQh21D8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-VccLybEfNeiJEdgbSazLsg-1; Thu,
 17 Oct 2024 07:34:12 -0400
X-MC-Unique: VccLybEfNeiJEdgbSazLsg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B4D61955D45
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 11:34:11 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.94])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2DF4F19560A3; Thu, 17 Oct 2024 11:34:09 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 13/31] net: adapt to new import path for qobject data type
 headers
Date: Thu, 17 Oct 2024 12:33:25 +0100
Message-ID: <20241017113344.883424-14-berrange@redhat.com>
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
 net/net-hmp-cmds.c | 2 +-
 net/net.c          | 2 +-
 net/slirp.c        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/net-hmp-cmds.c b/net/net-hmp-cmds.c
index 41d326bf5f..e7c55d2787 100644
--- a/net/net-hmp-cmds.c
+++ b/net/net-hmp-cmds.c
@@ -22,7 +22,7 @@
 #include "qapi/clone-visitor.h"
 #include "qapi/qapi-commands-net.h"
 #include "qapi/qapi-visit-net.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/config-file.h"
 #include "qemu/help_option.h"
 #include "qemu/option.h"
diff --git a/net/net.c b/net/net.c
index d9b23a8f8c..8b4cd01970 100644
--- a/net/net.c
+++ b/net/net.c
@@ -36,7 +36,7 @@
 #include "qemu/help_option.h"
 #include "qapi/qapi-commands-net.h"
 #include "qapi/qapi-visit-net.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
diff --git a/net/slirp.c b/net/slirp.c
index eb9a456ed4..9b2784d643 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -43,7 +43,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "util.h"
 #include "migration/register.h"
 #include "migration/vmstate.h"
-- 
2.46.0


