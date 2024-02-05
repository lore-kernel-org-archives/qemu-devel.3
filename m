Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E361CC48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 07:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWtiK-0003bq-W4; Mon, 05 Feb 2024 02:48:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWthP-000362-Bk
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 02:47:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWthH-00065n-1s
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 02:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707119238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PHA7tRn7nUvxem/Uo2QxrW7SfQ3jd87ksTPBsvxVTxk=;
 b=MiAgUNBlZs0rsagwSqmPSYLJ+kEeJCQszq7ulvgs66c8ZQgVK8XJ7CS8kuahV9lck02Qq/
 xmXIecrHnJU1VgCpRK8Sb55KC6y2eSYaItXMpgVp3H9pEQyxMYz5KOcSnSat79AJz/Sc90
 RaDbaaifqOSpfd0GoJiE0R+7eYu1+14=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-aqOsMJa1O8CP45Nn2NpQKQ-1; Mon, 05 Feb 2024 02:47:13 -0500
X-MC-Unique: aqOsMJa1O8CP45Nn2NpQKQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E6DA85A59A;
 Mon,  5 Feb 2024 07:47:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 17F7F40C9444;
 Mon,  5 Feb 2024 07:47:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6E53921E5A5A; Mon,  5 Feb 2024 08:47:09 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com, armbru@redhat.com, berrange@redhat.com,
 eblake@redhat.com, eduardo@habkost.net, fan.ni@samsung.com,
 farosas@suse.de, hreitz@redhat.com, jasowang@redhat.com, jiri@resnulli.us,
 jonathan.cameron@huawei.com, kkostiuk@redhat.com, kraxel@redhat.com,
 kwolf@redhat.com, lukasstraub2@web.de, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 philmd@linaro.org, pizhenwei@bytedance.com, qemu-block@nongnu.org,
 stefanb@linux.ibm.com, wangyanan55@huawei.com
Subject: [PATCH 14/15] qapi: Move @String out of common.json to discourage
 reuse
Date: Mon,  5 Feb 2024 08:47:08 +0100
Message-ID: <20240205074709.3613229-15-armbru@redhat.com>
In-Reply-To: <20240205074709.3613229-1-armbru@redhat.com>
References: <20240205074709.3613229-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Use of String is problematic, because it results in awkward interface
documentation.  The previous commit cleaned up one instance.

Move String out of common.json next to its remaining users in net.json
to discourage reuse elsewhere.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
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


