Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B165C3601E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 12:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0fwU-0005uw-U2; Fri, 04 Apr 2025 08:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u0fwL-0005rg-PE
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:14:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u0fwI-0005qn-2U
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743768865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JXFnKJMNYKMSFA9doJlGysHAAmio8OIcedRbeus1bfw=;
 b=aYnTONlgj2AXtgk6/kdsy9uJbMCD88vec7lxK5v7+tN5BbFmRi5jZW30YyfScxSvvvKwuE
 QPARnf4gBRw6ZtWplgmW95pbtleQStXZRxVl6omAfUstrkgfs/5yL9e3rwRhTf+RZQ873Z
 sjmUVGDO3QKkbfOTXqmu0MMQJARCtYI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-jYdV9sLpNyCI6hhEdmlqUQ-1; Fri,
 04 Apr 2025 08:14:22 -0400
X-MC-Unique: jYdV9sLpNyCI6hhEdmlqUQ-1
X-Mimecast-MFC-AGG-ID: jYdV9sLpNyCI6hhEdmlqUQ_1743768861
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EEA2180AF56; Fri,  4 Apr 2025 12:14:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E1241809B6C; Fri,  4 Apr 2025 12:14:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7589D21E66EF; Fri, 04 Apr 2025 14:14:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, kkostiuk@redhat.com, kwolf@redhat.com,
 jsnow@redhat.com, peter.maydell@linaro.org, eblake@redhat.com,
 jiri@resnulli.us, qemu-block@nongnu.org
Subject: [PATCH 05/11] docs/devel/qapi-code-gen: Improve the part on
 qmp-example directive
Date: Fri,  4 Apr 2025 14:14:07 +0200
Message-ID: <20250404121413.1743790-6-armbru@redhat.com>
In-Reply-To: <20250404121413.1743790-1-armbru@redhat.com>
References: <20250404121413.1743790-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.rst | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index ad517349fc..25a46fafb6 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -1038,20 +1038,15 @@ default to "Example:".
 A simple QMP example::
 
   # .. qmp-example::
-  #    :title: Using query-block
   #
-  #    -> { "execute": "query-block" }
-  #    <- { ... }
+  #     -> { "execute": "query-name" }
+  #     <- { "return": { "name": "Fred" } }
 
 More complex or multi-step examples where exposition is needed before
 or between QMP code blocks can be created by using the ``:annotated:``
 directive option.  When using this option, nested QMP code blocks must
 be entered explicitly with rST's ``::`` syntax.
 
-Highlighting in non-QMP languages can be accomplished by using the
-``.. code-block:: lang`` directive, and non-highlighted text can be
-achieved by omitting the language argument.
-
 For example::
 
   # .. qmp-example::
@@ -1061,11 +1056,21 @@ For example::
   #    This is a more complex example that can use
   #    ``arbitrary rST syntax`` in its exposition::
   #
-  #      -> { "execute": "query-block" }
-  #      <- { ... }
+  #     -> { "execute": "query-block" }
+  #     <- { "return": [
+  #             {
+  #               "device": "ide0-hd0",
+  #               ...
+  #             }
+  #             ...
+  #          ] }
   #
   #    Above, lengthy output has been omitted for brevity.
 
+Highlighting in non-QMP languages can be accomplished by using the
+``.. code-block:: lang`` directive, and non-highlighted text can be
+achieved by omitting the language argument.
+
 
 Examples of complete definition documentation::
 
-- 
2.48.1


