Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291FBC02194
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 23:15:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfoZV-0001GY-1V; Wed, 05 Feb 2025 18:12:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tfoZL-0001F5-A8
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 18:12:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tfoZJ-0005aj-St
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 18:12:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738797146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7rlY36oQtVSPyIz+C7TU5nD1O/rmrISF76rdDY3L36k=;
 b=dav0/iozheJ2OaW9/A0Hh11BhrUSuaf4eloBXgfQK5lB82hNdb4QQuWJvfXXvFgmlMYh5x
 WJo67owaSj3Oe3VI3XMhK4NKIe6168Uq2SoK+5VGcvpOq3ugLyoSYe3/pGFxjuJ5deNadF
 eRKFFWeV88pRRDU8mI12XHRSC/38zus=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-ENQ3uxTOMImZ_wEeITVSmQ-1; Wed,
 05 Feb 2025 18:12:23 -0500
X-MC-Unique: ENQ3uxTOMImZ_wEeITVSmQ-1
X-Mimecast-MFC-AGG-ID: ENQ3uxTOMImZ_wEeITVSmQ
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9EE991956046; Wed,  5 Feb 2025 23:12:21 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.66.104])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2640C1800267; Wed,  5 Feb 2025 23:12:16 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, Lukas Straub <lukasstraub2@web.de>,
 Eduardo Habkost <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 01/42] docs/qapidoc: support header-less freeform sections
Date: Wed,  5 Feb 2025 18:11:27 -0500
Message-ID: <20250205231208.1480762-2-jsnow@redhat.com>
In-Reply-To: <20250205231208.1480762-1-jsnow@redhat.com>
References: <20250205231208.1480762-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
2.48.1


