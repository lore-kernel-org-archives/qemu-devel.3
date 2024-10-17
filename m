Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7100AD2127F
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 11:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1OnJ-0004ZN-Bc; Thu, 17 Oct 2024 07:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1Oly-00040a-4K
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 07:34:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1Oln-0005vK-4C
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 07:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729164858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ugo+Aw8s2QSFIWFhXCfQNZnH28fS6C4zA8NDIlXd914=;
 b=MnMV/9H0JbFgAOZ16k4cTQaEVdKRS9n5ssIrSipUyToepEXBlbtaCygSgaqGpsh8Zyt8AD
 bAeLwtSjn2RIVg4mzwWdysblcCcH+qpXOo7FNXGaFtB6/1QMLBzyNNEJGlS3oQxPrzhGrp
 5kk0AGON3VXva8RaNYlLycuYsRLtjpI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-tWx6X-exMliENUxvdgl42w-1; Thu,
 17 Oct 2024 07:34:17 -0400
X-MC-Unique: tWx6X-exMliENUxvdgl42w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71D131955F25
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 11:34:16 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.94])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 197A419560A7; Thu, 17 Oct 2024 11:34:14 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 16/31] qobject: adapt to new import path for qobject data
 type headers
Date: Thu, 17 Oct 2024 12:33:28 +0100
Message-ID: <20241017113344.883424-17-berrange@redhat.com>
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
 qobject/block-qdict.c      |  8 ++++----
 qobject/json-parser-int.h  |  2 +-
 qobject/json-parser.c      | 12 ++++++------
 qobject/json-writer.c      |  2 +-
 qobject/qbool.c            |  2 +-
 qobject/qdict.c            | 10 +++++-----
 qobject/qjson.c            | 16 ++++++++--------
 qobject/qlist.c            | 10 +++++-----
 qobject/qlit.c             | 14 +++++++-------
 qobject/qnull.c            |  2 +-
 qobject/qnum.c             |  2 +-
 qobject/qobject-internal.h |  2 +-
 qobject/qobject.c          | 12 ++++++------
 qobject/qstring.c          |  2 +-
 14 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/qobject/block-qdict.c b/qobject/block-qdict.c
index 4a83bda2c3..d0e1c63cf6 100644
--- a/qobject/block-qdict.c
+++ b/qobject/block-qdict.c
@@ -9,10 +9,10 @@
 
 #include "qemu/osdep.h"
 #include "block/qdict.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qbool.h"
+#include "qobject/qlist.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
diff --git a/qobject/json-parser-int.h b/qobject/json-parser-int.h
index 16a25d00bb..8c01f23627 100644
--- a/qobject/json-parser-int.h
+++ b/qobject/json-parser-int.h
@@ -14,7 +14,7 @@
 #ifndef JSON_PARSER_INT_H
 #define JSON_PARSER_INT_H
 
-#include "qapi/qmp/json-parser.h"
+#include "qobject/json-parser.h"
 
 typedef enum json_token_type {
     JSON_ERROR = 0,             /* must be zero, see json_lexer[] */
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index d498db6e70..7483e582fe 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -16,12 +16,12 @@
 #include "qemu/cutils.h"
 #include "qemu/unicode.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnull.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qbool.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qnull.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 #include "json-parser-int.h"
 
 struct JSONToken {
diff --git a/qobject/json-writer.c b/qobject/json-writer.c
index 309a31d57a..aac2c6ab71 100644
--- a/qobject/json-writer.c
+++ b/qobject/json-writer.c
@@ -14,7 +14,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/json-writer.h"
+#include "qobject/json-writer.h"
 #include "qemu/unicode.h"
 
 struct JSONWriter {
diff --git a/qobject/qbool.c b/qobject/qbool.c
index c7049c0c50..00d7066aae 100644
--- a/qobject/qbool.c
+++ b/qobject/qbool.c
@@ -12,7 +12,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/qbool.h"
+#include "qobject/qbool.h"
 #include "qobject-internal.h"
 
 /**
diff --git a/qobject/qdict.c b/qobject/qdict.c
index 8faff230d3..a90ac9ae2f 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -11,11 +11,11 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qnull.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qnum.h"
+#include "qobject/qdict.h"
+#include "qobject/qbool.h"
+#include "qobject/qnull.h"
+#include "qobject/qstring.h"
 #include "qobject-internal.h"
 
 /**
diff --git a/qobject/qjson.c b/qobject/qjson.c
index 167fcb429c..c858dafb5e 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -13,14 +13,14 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/json-parser.h"
-#include "qapi/qmp/json-writer.h"
-#include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/json-parser.h"
+#include "qobject/json-writer.h"
+#include "qobject/qjson.h"
+#include "qobject/qbool.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 
 typedef struct JSONParsingState {
     JSONMessageParser parser;
diff --git a/qobject/qlist.c b/qobject/qlist.c
index 356ad946b0..41e6876d5b 100644
--- a/qobject/qlist.c
+++ b/qobject/qlist.c
@@ -11,11 +11,11 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnull.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qbool.h"
+#include "qobject/qlist.h"
+#include "qobject/qnull.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 #include "qemu/queue.h"
 #include "qobject-internal.h"
 
diff --git a/qobject/qlit.c b/qobject/qlit.c
index a62865b642..a44f47eaa5 100644
--- a/qobject/qlit.c
+++ b/qobject/qlit.c
@@ -15,13 +15,13 @@
 
 #include "qemu/osdep.h"
 
-#include "qapi/qmp/qlit.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
-#include "qapi/qmp/qnull.h"
+#include "qobject/qlit.h"
+#include "qobject/qbool.h"
+#include "qobject/qlist.h"
+#include "qobject/qnum.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
+#include "qobject/qnull.h"
 
 static bool qlit_equal_qdict(const QLitObject *lhs, const QDict *qdict)
 {
diff --git a/qobject/qnull.c b/qobject/qnull.c
index 445a5db7f3..0fb78cbd0a 100644
--- a/qobject/qnull.c
+++ b/qobject/qnull.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/qnull.h"
+#include "qobject/qnull.h"
 #include "qobject-internal.h"
 
 QNull qnull_ = {
diff --git a/qobject/qnum.c b/qobject/qnum.c
index dd8ea49565..a938b64537 100644
--- a/qobject/qnum.c
+++ b/qobject/qnum.c
@@ -13,7 +13,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/qnum.h"
+#include "qobject/qnum.h"
 #include "qobject-internal.h"
 
 /**
diff --git a/qobject/qobject-internal.h b/qobject/qobject-internal.h
index b310c8e1b5..0c7679fe98 100644
--- a/qobject/qobject-internal.h
+++ b/qobject/qobject-internal.h
@@ -10,7 +10,7 @@
 #ifndef QOBJECT_INTERNAL_H
 #define QOBJECT_INTERNAL_H
 
-#include "qapi/qmp/qobject.h"
+#include "qobject/qobject.h"
 
 static inline void qobject_init(QObject *obj, QType type)
 {
diff --git a/qobject/qobject.c b/qobject/qobject.c
index d7077b8f2a..78d1e057c1 100644
--- a/qobject/qobject.c
+++ b/qobject/qobject.c
@@ -8,12 +8,12 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qnull.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qbool.h"
+#include "qobject/qnull.h"
+#include "qobject/qnum.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qstring.h"
 #include "qobject-internal.h"
 
 QEMU_BUILD_BUG_MSG(
diff --git a/qobject/qstring.c b/qobject/qstring.c
index 794f8c9357..d316604914 100644
--- a/qobject/qstring.c
+++ b/qobject/qstring.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qstring.h"
 #include "qobject-internal.h"
 
 /**
-- 
2.46.0


