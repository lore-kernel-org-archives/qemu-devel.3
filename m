Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFE8C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 21:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s709u-0005Wl-SW; Tue, 14 May 2024 17:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s709o-0005VF-Pg
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:58:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s709n-0008P8-6L
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715723878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kcmerUNUa2TkCvVPBaPfOryjLeuh/pwfq97sjE6C5PM=;
 b=HoMHdmJbEC7qPqHccLzIKBD7+V9tADb/dk6jkzxZUruJFRr39Xdk889Sep+kXIkIDHyEjE
 pkqCdkEoXq9mP8l96NcV4YpRB2rcCef7gIbulfYPlZ+lhrLdKGjNghLlH67xxfY0VgvOBK
 cdasDEX736pM890aTp+pfcIsKUnNipg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-Y9E1L4InOzK5oGzMCUw_7w-1; Tue,
 14 May 2024 17:57:55 -0400
X-MC-Unique: Y9E1L4InOzK5oGzMCUw_7w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95F1629ABA0B;
 Tue, 14 May 2024 21:57:54 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.17.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4CD656BC5;
 Tue, 14 May 2024 21:57:51 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Markus Armbruster <armbru@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Kevin Wolf <kwolf@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Mads Ynddal <mads@ynddal.dk>,
 Jason Wang <jasowang@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Yanan Wang <wangyanan55@huawei.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 03/20] docs/qapidoc: delint a tiny portion of the module
Date: Tue, 14 May 2024 17:57:22 -0400
Message-ID: <20240514215740.940155-4-jsnow@redhat.com>
In-Reply-To: <20240514215740.940155-1-jsnow@redhat.com>
References: <20240514215740.940155-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In the coming patches, it's helpful to have a linting baseline. However,
there's no need to shuffle around the deck chairs too much, because most
of this code will be removed once the new qapidoc generator (the
"transmogrifier") is in place.

To ease my pain: just turn off the black auto-formatter for most, but
not all, of qapidoc.py. This will help ensure that *new* code follows a
coding standard without bothering too much with cleaning up the existing
code.

For manual checking for now, try "black --check qapidoc.py" from the
docs/sphinx directory. "pip install black" (without root permissions) if
you do not have it installed otherwise.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index f270b494f01..1655682d4c7 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -28,28 +28,30 @@
 import re
 
 from docutils import nodes
+from docutils.parsers.rst import Directive, directives
 from docutils.statemachine import ViewList
-from docutils.parsers.rst import directives, Directive
-from sphinx.errors import ExtensionError
-from sphinx.util.nodes import nested_parse_with_titles
-import sphinx
-from qapi.gen import QAPISchemaVisitor
 from qapi.error import QAPIError, QAPISemError
+from qapi.gen import QAPISchemaVisitor
 from qapi.schema import QAPISchema
 
+import sphinx
+from sphinx.errors import ExtensionError
+from sphinx.util.nodes import nested_parse_with_titles
+
 
 # Sphinx up to 1.6 uses AutodocReporter; 1.7 and later
 # use switch_source_input. Check borrowed from kerneldoc.py.
-Use_SSI = sphinx.__version__[:3] >= '1.7'
+Use_SSI = sphinx.__version__[:3] >= "1.7"
 if Use_SSI:
     from sphinx.util.docutils import switch_source_input
 else:
     from sphinx.ext.autodoc import AutodocReporter
 
 
-__version__ = '1.0'
+__version__ = "1.0"
 
 
+# fmt: off
 # Function borrowed from pydash, which is under the MIT license
 def intersperse(iterable, separator):
     """Yield the members of *iterable* interspersed with *separator*."""
-- 
2.44.0


