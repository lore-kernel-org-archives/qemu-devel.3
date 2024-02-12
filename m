Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F76C48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 09:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZSOq-0006PK-LJ; Mon, 12 Feb 2024 04:14:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZSOl-0006N6-QJ
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:14:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZSOi-0003d4-1b
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707729282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v/JMeniRAA4fwDGk+1EWp+F6ZP7WjoI0shu8E467A5I=;
 b=iFKzSr9CdnDVmaXgotHVC7EAQcqrJltG98lrUvm/d2SiyRCohIcZxFeaF5RnAIGesS1S+R
 g1wbsansgb1FlUmgtUgg/DTH0dsaemH87m9eW8+P/z+6cUncB1Th0YJ6m0vzoXU3lKnY0g
 Z+b3l0kHD1TG7pBbqnCqm4LVTbleaT4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-x0539gGyN8in0Pxgf0BZ_w-1; Mon,
 12 Feb 2024 04:14:39 -0500
X-MC-Unique: x0539gGyN8in0Pxgf0BZ_w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 148FB1C068DD;
 Mon, 12 Feb 2024 09:14:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E500BFC74F;
 Mon, 12 Feb 2024 09:14:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9EFBC21E5A5A; Mon, 12 Feb 2024 10:14:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 14/18] qapi: Move @String out of common.json to discourage reuse
Date: Mon, 12 Feb 2024 10:14:32 +0100
Message-ID: <20240212091436.688598-15-armbru@redhat.com>
In-Reply-To: <20240212091436.688598-1-armbru@redhat.com>
References: <20240212091436.688598-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.677,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use of String is problematic, because it results in awkward interface
documentation.  The previous commit cleaned up one instance.

Move String out of common.json next to its remaining users in net.json
to discourage reuse elsewhere.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240205074709.3613229-15-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qapi/common.json     | 11 -----------
 qapi/net.json        | 12 +++++++++++-
 include/net/filter.h |  2 +-
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/qapi/common.json b/qapi/common.json
index 6fed9cde1a..f1bb841951 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -51,17 +51,6 @@
 { 'enum': 'OnOffSplit',
   'data': [ 'on', 'off', 'split' ] }
 
-##
-# @String:
-#
-# A fat type wrapping 'str', to be embedded in lists.
-#
-# Since: 1.2
-##
-{ 'struct': 'String',
-  'data': {
-    'str': 'str' } }
-
 ##
 # @StrOrNull:
 #
diff --git a/qapi/net.json b/qapi/net.json
index 68493d6ac9..0a993e1a3d 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -6,7 +6,6 @@
 # = Net devices
 ##
 
-{ 'include': 'common.json' }
 { 'include': 'sockets.json' }
 
 ##
@@ -105,6 +104,17 @@
     '*addr':    'str',
     '*vectors': 'uint32' } }
 
+##
+# @String:
+#
+# A fat type wrapping 'str', to be embedded in lists.
+#
+# Since: 1.2
+##
+{ 'struct': 'String',
+  'data': {
+    'str': 'str' } }
+
 ##
 # @NetdevUserOptions:
 #
diff --git a/include/net/filter.h b/include/net/filter.h
index 27ffc630df..f15f7932b2 100644
--- a/include/net/filter.h
+++ b/include/net/filter.h
@@ -9,7 +9,7 @@
 #ifndef QEMU_NET_FILTER_H
 #define QEMU_NET_FILTER_H
 
-#include "qapi/qapi-types-net.h"
+#include "qapi/qapi-types-common.h"
 #include "qemu/queue.h"
 #include "qom/object.h"
 #include "net/queue.h"
-- 
2.43.0


