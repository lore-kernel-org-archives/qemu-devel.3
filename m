Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66386D2127C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 11:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1OnJ-0004ZQ-Ag; Thu, 17 Oct 2024 07:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1Oli-0003zm-Az
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 07:34:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1Olf-0005ts-CA
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 07:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729164849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5QbfpM/va32uMU6lrCqym73FJ0EAOJMUKd7G3rtAyj0=;
 b=iippC1djbLPR61/dFKyGztDmr/w3V07VfgNlKuGQ5owKwLMM/JwsqzncK2jhiA5G6jplrR
 9qHRdvI0YS4E2T7RPhgszkf4Ta9CDNoNrCv2WtjZlCldDHnpHEehituBOpzYwDdatuoMAD
 lF3C7a/jDuCm/gjWa7Pu749gANRt15s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-FbyKEk7EPnm_ipjUGUxqBg-1; Thu,
 17 Oct 2024 07:34:07 -0400
X-MC-Unique: FbyKEk7EPnm_ipjUGUxqBg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC9B51955EEA
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 11:34:06 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.94])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5EC5219560AE; Thu, 17 Oct 2024 11:34:05 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 10/31] include: adapt to new import path for qobject data
 type headers
Date: Thu, 17 Oct 2024 12:33:22 +0100
Message-ID: <20241017113344.883424-11-berrange@redhat.com>
In-Reply-To: <20241017113344.883424-1-berrange@redhat.com>
References: <20241017113344.883424-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
 include/block/qdict.h     | 2 +-
 include/qobject/qbool.h   | 2 +-
 include/qobject/qdict.h   | 2 +-
 include/qobject/qlist.h   | 2 +-
 include/qobject/qnull.h   | 2 +-
 include/qobject/qnum.h    | 2 +-
 include/qobject/qobject.h | 2 +-
 include/qobject/qstring.h | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/block/qdict.h b/include/block/qdict.h
index b4c28d96a9..53c4df4cb2 100644
--- a/include/block/qdict.h
+++ b/include/block/qdict.h
@@ -10,7 +10,7 @@
 #ifndef BLOCK_QDICT_H
 #define BLOCK_QDICT_H
 
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 QObject *qdict_crumple(const QDict *src, Error **errp);
 void qdict_flatten(QDict *qdict);
diff --git a/include/qobject/qbool.h b/include/qobject/qbool.h
index 0d09726939..b348e17867 100644
--- a/include/qobject/qbool.h
+++ b/include/qobject/qbool.h
@@ -14,7 +14,7 @@
 #ifndef QBOOL_H
 #define QBOOL_H
 
-#include "qapi/qmp/qobject.h"
+#include "qobject/qobject.h"
 
 struct QBool {
     struct QObjectBase_ base;
diff --git a/include/qobject/qdict.h b/include/qobject/qdict.h
index 82e90fc072..903e6e5462 100644
--- a/include/qobject/qdict.h
+++ b/include/qobject/qdict.h
@@ -13,7 +13,7 @@
 #ifndef QDICT_H
 #define QDICT_H
 
-#include "qapi/qmp/qobject.h"
+#include "qobject/qobject.h"
 #include "qemu/queue.h"
 
 #define QDICT_BUCKET_MAX 512
diff --git a/include/qobject/qlist.h b/include/qobject/qlist.h
index e4e985d435..0377bf824e 100644
--- a/include/qobject/qlist.h
+++ b/include/qobject/qlist.h
@@ -13,7 +13,7 @@
 #ifndef QLIST_H
 #define QLIST_H
 
-#include "qapi/qmp/qobject.h"
+#include "qobject/qobject.h"
 #include "qemu/queue.h"
 
 typedef struct QListEntry {
diff --git a/include/qobject/qnull.h b/include/qobject/qnull.h
index 7feb7c7d83..4423836a0c 100644
--- a/include/qobject/qnull.h
+++ b/include/qobject/qnull.h
@@ -13,7 +13,7 @@
 #ifndef QNULL_H
 #define QNULL_H
 
-#include "qapi/qmp/qobject.h"
+#include "qobject/qobject.h"
 
 struct QNull {
     struct QObjectBase_ base;
diff --git a/include/qobject/qnum.h b/include/qobject/qnum.h
index e86788dd2e..1ce24b3668 100644
--- a/include/qobject/qnum.h
+++ b/include/qobject/qnum.h
@@ -15,7 +15,7 @@
 #ifndef QNUM_H
 #define QNUM_H
 
-#include "qapi/qmp/qobject.h"
+#include "qobject/qobject.h"
 
 typedef enum {
     QNUM_I64,
diff --git a/include/qobject/qobject.h b/include/qobject/qobject.h
index 256d782688..a6244d0ce0 100644
--- a/include/qobject/qobject.h
+++ b/include/qobject/qobject.h
@@ -34,7 +34,7 @@
 
 #include "qapi/qapi-builtin-types.h"
 
-/* Not for use outside include/qapi/qmp/ */
+/* Not for use outside include/qobject/ */
 struct QObjectBase_ {
     QType type;
     size_t refcnt;
diff --git a/include/qobject/qstring.h b/include/qobject/qstring.h
index 318d815d6a..1e2abe4032 100644
--- a/include/qobject/qstring.h
+++ b/include/qobject/qstring.h
@@ -13,7 +13,7 @@
 #ifndef QSTRING_H
 #define QSTRING_H
 
-#include "qapi/qmp/qobject.h"
+#include "qobject/qobject.h"
 
 struct QString {
     struct QObjectBase_ base;
-- 
2.46.0


