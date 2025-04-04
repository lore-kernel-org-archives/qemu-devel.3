Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D7CC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 12:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0fwi-00060w-Qy; Fri, 04 Apr 2025 08:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u0fwL-0005rh-V6
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:14:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u0fwI-0005qv-95
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743768865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IRaQ20QHLxcMP2T+LCjH5Xz4ptiQxKPNqwa+AUFd49s=;
 b=KrBfiAHHIfjgHQ+lI1hrVRAEVO3LEfgbSIA2vuyfycj5z9WxR2gGSvG0kRkcIKs16sNZV3
 bV1JLUb5GVW4zztfepkFS5q9yuLntauQxQzfT8AL6g0Tl3Q11L4fGVZHqseSUy/cw8FnBB
 ablib9LDKvUIiemtw3tOQJDLJ/bI+YA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-BB4XPyBOOTOryJGfT-7kUQ-1; Fri,
 04 Apr 2025 08:14:21 -0400
X-MC-Unique: BB4XPyBOOTOryJGfT-7kUQ-1
X-Mimecast-MFC-AGG-ID: BB4XPyBOOTOryJGfT-7kUQ_1743768860
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8888A1800361; Fri,  4 Apr 2025 12:14:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39D59180B488; Fri,  4 Apr 2025 12:14:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 79E1A21E6698; Fri, 04 Apr 2025 14:14:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, kkostiuk@redhat.com, kwolf@redhat.com,
 jsnow@redhat.com, peter.maydell@linaro.org, eblake@redhat.com,
 jiri@resnulli.us, qemu-block@nongnu.org
Subject: [PATCH 06/11] docs/sphinx/qmp_lexer: Generalize elision syntax
Date: Fri,  4 Apr 2025 14:14:08 +0200
Message-ID: <20250404121413.1743790-7-armbru@redhat.com>
In-Reply-To: <20250404121413.1743790-1-armbru@redhat.com>
References: <20250404121413.1743790-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Accept "... lorem ipsum ..."  in addition to "...".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.rst    | 6 ++++--
 docs/sphinx/qmp_lexer.py        | 2 +-
 tests/qapi-schema/doc-good.json | 2 +-
 tests/qapi-schema/doc-good.out  | 2 +-
 tests/qapi-schema/doc-good.txt  | 2 +-
 5 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 25a46fafb6..231cc0fecf 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -1029,7 +1029,9 @@ used.
 QMP Examples can be added by using the ``.. qmp-example::`` directive.
 In its simplest form, this can be used to contain a single QMP code
 block which accepts standard JSON syntax with additional server
-directionality indicators (``->`` and ``<-``), and elisions (``...``).
+directionality indicators (``->`` and ``<-``), and elisions.  An
+elision is commonly ``...``, but it can also be or a pair of ``...``
+with text in between.
 
 Optionally, a plaintext title may be provided by using the ``:title:``
 directive option.  If the title is omitted, the example title will
@@ -1062,7 +1064,7 @@ For example::
   #               "device": "ide0-hd0",
   #               ...
   #             }
-  #             ...
+  #             ... more ...
   #          ] }
   #
   #    Above, lengthy output has been omitted for brevity.
diff --git a/docs/sphinx/qmp_lexer.py b/docs/sphinx/qmp_lexer.py
index a59de8a079..1bd1b81b70 100644
--- a/docs/sphinx/qmp_lexer.py
+++ b/docs/sphinx/qmp_lexer.py
@@ -24,7 +24,7 @@ class QMPExampleMarkersLexer(RegexLexer):
         'root': [
             (r'-> ', token.Generic.Prompt),
             (r'<- ', token.Generic.Prompt),
-            (r' ?\.{3} ?', token.Generic.Prompt),
+            (r'\.{3}( .* \.{3})?', token.Generic.Prompt),
         ]
     }
 
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index 0a4f139f83..14b808f909 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -212,7 +212,7 @@
 #
 #    -> "this example"
 #
-#    <- "has no title"
+#    <- ... has no title ...
 ##
 { 'command': 'cmd-boxed', 'boxed': true,
   'data': 'Object',
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 5773f1dd6d..dc8352eed4 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -217,7 +217,7 @@ another feature
 
    -> "this example"
 
-   <- "has no title"
+   <- ... has no title ...
 doc symbol=EVT_BOXED
     body=
 
diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-good.txt
index cb37db606a..17a1d56ef1 100644
--- a/tests/qapi-schema/doc-good.txt
+++ b/tests/qapi-schema/doc-good.txt
@@ -264,7 +264,7 @@ Example::
 
    -> "this example"
 
-   <- "has no title"
+   <- ... has no title ...
 
 
 "EVT_BOXED" (Event)
-- 
2.48.1


