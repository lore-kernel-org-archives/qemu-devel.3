Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B198C02187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 18:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXm8E-0005fp-5r; Tue, 14 Jan 2025 13:59:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tXm7s-0005eY-VL
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 13:58:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tXm7o-0002kq-DY
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 13:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736881128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q0OxyQtOI9eFgm+CEQP/+PzDR9NDKRFAbeA3vB2FR+M=;
 b=PdOQegKvw4DkDIa7k2/ZbIUDKX0jy/f0JpJNwje8fYqRGgF6rt4mYcBbeFkg65EUsa+0Bw
 DZlMiln5pfMSiBmDNbvJWT2ysEXXd3A4aiSKcITdZmgj6kIC6fwQC/w8wqewLba1YO5jzO
 m/4gDaFvn+Y5MWaUEfbJxIqfBFHVPZ8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-se5jRseNPu-H_NdSGzIgoQ-1; Tue,
 14 Jan 2025 13:58:46 -0500
X-MC-Unique: se5jRseNPu-H_NdSGzIgoQ-1
X-Mimecast-MFC-AGG-ID: se5jRseNPu-H_NdSGzIgoQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 518401956083; Tue, 14 Jan 2025 18:58:45 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.175])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4292719560AA; Tue, 14 Jan 2025 18:58:43 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 01/23] docs/qapidoc: support header-less freeform sections
Date: Tue, 14 Jan 2025 13:58:18 -0500
Message-ID: <20250114185840.3058525-2-jsnow@redhat.com>
In-Reply-To: <20250114185840.3058525-1-jsnow@redhat.com>
References: <20250114185840.3058525-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The code as written can't handle if a header isn't found and will crash,
because `node` will be uninitialized. If we don't have a section title,
create a generic block to insert text into instead.

(This patch also removes a lingering pylint warning in the QAPIDoc
implementation that prevents getting a clean baseline to use for
forthcoming additions.)

I am not attempting to *fully* clean up the existing QAPIDoc
implementation in pylint because I intend to delete it anyway; this
patch merely accomplishes a baseline under a specific pylint
configuration:

PYTHONPATH=../../scripts/ pylint --disable=fixme,too-many-lines,\
consider-using-f-string,missing-docstring,unused-argument,\
too-many-arguments,too-many-positional-arguments,\
too-many-public-methods \
qapidoc.py

(under at least pylint 3.3.1; more robust tamping down of the
environment needed to consistently perform checks will happen later -
hopefully soon, sorry for the inconvenience.)

This at least ensures there aren't regressions outside of these general
warnings in the new qapidoc.py code to be committed.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 5f96b46270b..5a4d7388b29 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -421,6 +421,8 @@ def freeform(self, doc):
             node = self._start_new_heading(heading, len(leader))
             if text == '':
                 return
+        else:
+            node = nodes.container()
 
         self._parse_text_into_node(text, node)
         self._cur_doc = None
-- 
2.47.1


