Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381EFD2127C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 11:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Om7-00042F-SN; Thu, 17 Oct 2024 07:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1OlR-0003vp-An
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 07:34:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1OlO-0005sD-VY
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 07:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729164830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8UTCxXauWp8dlGBhpYAvS6148CJg39l9x6piok4ZV80=;
 b=dtOgo2ay/mtbVhq+zaSAw0C3M+rxQGoaeTAJ9iC3LhOXi1HWGyKyhnHpM40VN5slXRB4ZD
 mfAz4Spcl41sw+cH13D6kCwSRA9cFxR7H4WgL/Dy3Tu0MbZ4I1kq4i1MlHlw+PK80ahGuu
 8Mj6gsWBVt76ii1fzycZ6X3s/wJEBAI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-jR5TxZyFMQ6VvU9IgcAVIA-1; Thu,
 17 Oct 2024 07:33:49 -0400
X-MC-Unique: jR5TxZyFMQ6VvU9IgcAVIA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 941AA19560A3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 11:33:48 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.94])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 56EBD19560A2; Thu, 17 Oct 2024 11:33:46 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 01/31] include: move include/qapi/qmp/ to include/qobject/
Date: Thu, 17 Oct 2024 12:33:13 +0100
Message-ID: <20241017113344.883424-2-berrange@redhat.com>
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

The general expectation is that header files should follow the same
file/path naming scheme as the corresponding source file. There are
various historical exceptions to this practice in QEMU, with one of
the most notable being the include/qapi/qmp/ directory. Most of the
headers there correspond to source files in qobject/.

This patch corrects that inconsistency by creating include/qobject/.
The only outlier is include/qapi/qmp/dispatch.h which gets renamed
to include/qapi/qmp-registry.h.

To allow the code to continue to build, symlinks are temporarily
added in $QEMU/qapi/qmp/ to point to the new location. They will
be removed in a later commit.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 MAINTAINERS                                     | 5 +----
 include/qapi/{qmp/dispatch.h => qmp-registry.h} | 0
 include/{qapi/qmp => qobject}/json-parser.h     | 0
 include/{qapi/qmp => qobject}/json-writer.h     | 0
 include/{qapi/qmp => qobject}/qbool.h           | 0
 include/{qapi/qmp => qobject}/qdict.h           | 0
 include/{qapi/qmp => qobject}/qjson.h           | 0
 include/{qapi/qmp => qobject}/qlist.h           | 0
 include/{qapi/qmp => qobject}/qlit.h            | 0
 include/{qapi/qmp => qobject}/qnull.h           | 0
 include/{qapi/qmp => qobject}/qnum.h            | 0
 include/{qapi/qmp => qobject}/qobject.h         | 0
 include/{qapi/qmp => qobject}/qstring.h         | 0
 qapi/qmp/dispatch.h                             | 1 +
 qapi/qmp/json-parser.h                          | 1 +
 qapi/qmp/json-writer.h                          | 1 +
 qapi/qmp/qbool.h                                | 1 +
 qapi/qmp/qdict.h                                | 1 +
 qapi/qmp/qjson.h                                | 1 +
 qapi/qmp/qlist.h                                | 1 +
 qapi/qmp/qlit.h                                 | 1 +
 qapi/qmp/qnull.h                                | 1 +
 qapi/qmp/qnum.h                                 | 1 +
 qapi/qmp/qobject.h                              | 1 +
 qapi/qmp/qstring.h                              | 1 +
 25 files changed, 13 insertions(+), 4 deletions(-)
 rename include/qapi/{qmp/dispatch.h => qmp-registry.h} (100%)
 rename include/{qapi/qmp => qobject}/json-parser.h (100%)
 rename include/{qapi/qmp => qobject}/json-writer.h (100%)
 rename include/{qapi/qmp => qobject}/qbool.h (100%)
 rename include/{qapi/qmp => qobject}/qdict.h (100%)
 rename include/{qapi/qmp => qobject}/qjson.h (100%)
 rename include/{qapi/qmp => qobject}/qlist.h (100%)
 rename include/{qapi/qmp => qobject}/qlit.h (100%)
 rename include/{qapi/qmp => qobject}/qnull.h (100%)
 rename include/{qapi/qmp => qobject}/qnum.h (100%)
 rename include/{qapi/qmp => qobject}/qobject.h (100%)
 rename include/{qapi/qmp => qobject}/qstring.h (100%)
 create mode 120000 qapi/qmp/dispatch.h
 create mode 120000 qapi/qmp/json-parser.h
 create mode 120000 qapi/qmp/json-writer.h
 create mode 120000 qapi/qmp/qbool.h
 create mode 120000 qapi/qmp/qdict.h
 create mode 120000 qapi/qmp/qjson.h
 create mode 120000 qapi/qmp/qlist.h
 create mode 120000 qapi/qmp/qlit.h
 create mode 120000 qapi/qmp/qnull.h
 create mode 120000 qapi/qmp/qnum.h
 create mode 120000 qapi/qmp/qobject.h
 create mode 120000 qapi/qmp/qstring.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c21d6a2f9e..656482b2a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3153,8 +3153,6 @@ S: Supported
 F: qapi/
 X: qapi/*.json
 F: include/qapi/
-X: include/qapi/qmp/
-F: include/qapi/qmp/dispatch.h
 F: tests/qapi-schema/
 F: tests/unit/test-*-visitor.c
 F: tests/unit/test-qapi-*.c
@@ -3178,8 +3176,7 @@ QObject
 M: Markus Armbruster <armbru@redhat.com>
 S: Supported
 F: qobject/
-F: include/qapi/qmp/
-X: include/qapi/qmp/dispatch.h
+F: include/qobject/
 F: scripts/coccinelle/qobject.cocci
 F: tests/unit/check-qdict.c
 F: tests/unit/check-qjson.c
diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp-registry.h
similarity index 100%
rename from include/qapi/qmp/dispatch.h
rename to include/qapi/qmp-registry.h
diff --git a/include/qapi/qmp/json-parser.h b/include/qobject/json-parser.h
similarity index 100%
rename from include/qapi/qmp/json-parser.h
rename to include/qobject/json-parser.h
diff --git a/include/qapi/qmp/json-writer.h b/include/qobject/json-writer.h
similarity index 100%
rename from include/qapi/qmp/json-writer.h
rename to include/qobject/json-writer.h
diff --git a/include/qapi/qmp/qbool.h b/include/qobject/qbool.h
similarity index 100%
rename from include/qapi/qmp/qbool.h
rename to include/qobject/qbool.h
diff --git a/include/qapi/qmp/qdict.h b/include/qobject/qdict.h
similarity index 100%
rename from include/qapi/qmp/qdict.h
rename to include/qobject/qdict.h
diff --git a/include/qapi/qmp/qjson.h b/include/qobject/qjson.h
similarity index 100%
rename from include/qapi/qmp/qjson.h
rename to include/qobject/qjson.h
diff --git a/include/qapi/qmp/qlist.h b/include/qobject/qlist.h
similarity index 100%
rename from include/qapi/qmp/qlist.h
rename to include/qobject/qlist.h
diff --git a/include/qapi/qmp/qlit.h b/include/qobject/qlit.h
similarity index 100%
rename from include/qapi/qmp/qlit.h
rename to include/qobject/qlit.h
diff --git a/include/qapi/qmp/qnull.h b/include/qobject/qnull.h
similarity index 100%
rename from include/qapi/qmp/qnull.h
rename to include/qobject/qnull.h
diff --git a/include/qapi/qmp/qnum.h b/include/qobject/qnum.h
similarity index 100%
rename from include/qapi/qmp/qnum.h
rename to include/qobject/qnum.h
diff --git a/include/qapi/qmp/qobject.h b/include/qobject/qobject.h
similarity index 100%
rename from include/qapi/qmp/qobject.h
rename to include/qobject/qobject.h
diff --git a/include/qapi/qmp/qstring.h b/include/qobject/qstring.h
similarity index 100%
rename from include/qapi/qmp/qstring.h
rename to include/qobject/qstring.h
diff --git a/qapi/qmp/dispatch.h b/qapi/qmp/dispatch.h
new file mode 120000
index 0000000000..ffedc3971d
--- /dev/null
+++ b/qapi/qmp/dispatch.h
@@ -0,0 +1 @@
+../../include/qapi/qmp-registry.h
\ No newline at end of file
diff --git a/qapi/qmp/json-parser.h b/qapi/qmp/json-parser.h
new file mode 120000
index 0000000000..059cb73fa8
--- /dev/null
+++ b/qapi/qmp/json-parser.h
@@ -0,0 +1 @@
+../../include/qobject/json-parser.h
\ No newline at end of file
diff --git a/qapi/qmp/json-writer.h b/qapi/qmp/json-writer.h
new file mode 120000
index 0000000000..3e952f4c97
--- /dev/null
+++ b/qapi/qmp/json-writer.h
@@ -0,0 +1 @@
+../../include/qobject/json-writer.h
\ No newline at end of file
diff --git a/qapi/qmp/qbool.h b/qapi/qmp/qbool.h
new file mode 120000
index 0000000000..443c881cf8
--- /dev/null
+++ b/qapi/qmp/qbool.h
@@ -0,0 +1 @@
+../../include/qobject/qbool.h
\ No newline at end of file
diff --git a/qapi/qmp/qdict.h b/qapi/qmp/qdict.h
new file mode 120000
index 0000000000..8183614eae
--- /dev/null
+++ b/qapi/qmp/qdict.h
@@ -0,0 +1 @@
+../../include/qobject/qdict.h
\ No newline at end of file
diff --git a/qapi/qmp/qjson.h b/qapi/qmp/qjson.h
new file mode 120000
index 0000000000..85b48c5bfd
--- /dev/null
+++ b/qapi/qmp/qjson.h
@@ -0,0 +1 @@
+../../include/qobject/qjson.h
\ No newline at end of file
diff --git a/qapi/qmp/qlist.h b/qapi/qmp/qlist.h
new file mode 120000
index 0000000000..d40db0a12b
--- /dev/null
+++ b/qapi/qmp/qlist.h
@@ -0,0 +1 @@
+../../include/qobject/qlist.h
\ No newline at end of file
diff --git a/qapi/qmp/qlit.h b/qapi/qmp/qlit.h
new file mode 120000
index 0000000000..5dd5ac8ccb
--- /dev/null
+++ b/qapi/qmp/qlit.h
@@ -0,0 +1 @@
+../../include/qobject/qlit.h
\ No newline at end of file
diff --git a/qapi/qmp/qnull.h b/qapi/qmp/qnull.h
new file mode 120000
index 0000000000..944769d44b
--- /dev/null
+++ b/qapi/qmp/qnull.h
@@ -0,0 +1 @@
+../../include/qobject/qnull.h
\ No newline at end of file
diff --git a/qapi/qmp/qnum.h b/qapi/qmp/qnum.h
new file mode 120000
index 0000000000..8038e2f4d6
--- /dev/null
+++ b/qapi/qmp/qnum.h
@@ -0,0 +1 @@
+../../include/qobject/qnum.h
\ No newline at end of file
diff --git a/qapi/qmp/qobject.h b/qapi/qmp/qobject.h
new file mode 120000
index 0000000000..89d9118cfd
--- /dev/null
+++ b/qapi/qmp/qobject.h
@@ -0,0 +1 @@
+../../include/qobject/qobject.h
\ No newline at end of file
diff --git a/qapi/qmp/qstring.h b/qapi/qmp/qstring.h
new file mode 120000
index 0000000000..24f48de18a
--- /dev/null
+++ b/qapi/qmp/qstring.h
@@ -0,0 +1 @@
+../../include/qobject/qstring.h
\ No newline at end of file
-- 
2.46.0


