Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2474FC3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 07:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u23G7-0007H3-Qq; Tue, 08 Apr 2025 03:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u23Fp-0007DK-44
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 03:20:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u23Fl-0001Yz-G4
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 03:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744096810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wxpqffr6DvwyJjKsnnffuPMNt7OhJCq10F8b8ZlVabw=;
 b=hk5F7PAH5gsHGzIq+hWlVfM0FR5HWrY6FmjDr4Jtn+rAwBdRu93X26DAvbCmc8QOx3q/KT
 ggd23FunBJzWTzQmktV8p19U12u9H9tcL6vMoq1UEArz/erUoFYtF7+iY66jhbC5t82WUd
 8SfLimSutcBffMBdkHtlrtFrw5hjs9U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-rjRkZ6hKPIWbQH88WKXniA-1; Tue,
 08 Apr 2025 03:20:08 -0400
X-MC-Unique: rjRkZ6hKPIWbQH88WKXniA-1
X-Mimecast-MFC-AGG-ID: rjRkZ6hKPIWbQH88WKXniA_1744096807
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AF721956070
 for <qemu-devel@nongnu.org>; Tue,  8 Apr 2025 07:20:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1795C195609D
 for <qemu-devel@nongnu.org>; Tue,  8 Apr 2025 07:20:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0855C21E65DF; Tue, 08 Apr 2025 09:20:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 06/11] docs/sphinx/qmp_lexer: Generalize elision syntax
Date: Tue,  8 Apr 2025 09:19:56 +0200
Message-ID: <20250408072001.2518323-7-armbru@redhat.com>
In-Reply-To: <20250408072001.2518323-1-armbru@redhat.com>
References: <20250408072001.2518323-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Accept "... lorem ipsum ..."  in addition to "...".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20250404121413.1743790-7-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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


