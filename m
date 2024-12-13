Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D89FE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 01:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLuFa-0005X1-MZ; Thu, 12 Dec 2024 20:13:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuFZ-0005Wl-3r
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:13:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuFX-00005i-L2
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734052426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hNB7dl3TSLFCZCtDa8noAbO0oY0hQxHlysvc4+Gdxas=;
 b=gTDEQhvQKVsoe5hGV8KsSOuxKxyw1CUwlFLfo1dCCYGfzA2xGkDLTv2aDn0itZHDTcIN+W
 mFAd9XgO1RuCuXp2lhmFhHVuYezesGUKYNZiufdCMrrKx8w9Hd5yiysWVf587ELj635LQj
 oN7/MVD1cEdeR4RhoSg5kR3BQwjawz4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-EdMC53nkPz6D9X3qZ5BD5A-1; Thu,
 12 Dec 2024 20:13:40 -0500
X-MC-Unique: EdMC53nkPz6D9X3qZ5BD5A-1
X-Mimecast-MFC-AGG-ID: EdMC53nkPz6D9X3qZ5BD5A
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83C841956046; Fri, 13 Dec 2024 01:13:39 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.22])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7FF6A1956086; Fri, 13 Dec 2024 01:13:35 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 03/35] docs/sphinx: create QAPI domain extension stub
Date: Thu, 12 Dec 2024 20:12:32 -0500
Message-ID: <20241213011307.2942030-4-jsnow@redhat.com>
In-Reply-To: <20241213011307.2942030-1-jsnow@redhat.com>
References: <20241213011307.2942030-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

It doesn't really do anything yet, we'll get to it brick-by-brick in the
forthcoming commits to keep the series breezy and the git history
informative.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/conf.py               |  9 ++++++-
 docs/sphinx/qapi-domain.py | 52 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 docs/sphinx/qapi-domain.py

diff --git a/docs/conf.py b/docs/conf.py
index c11a6ead8a0..f2986ef7d74 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -60,7 +60,14 @@
 # Add any Sphinx extension module names here, as strings. They can be
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
 # ones.
-extensions = ['kerneldoc', 'qmp_lexer', 'hxtool', 'depfile', 'qapidoc']
+extensions = [
+    'depfile',
+    'hxtool',
+    'kerneldoc',
+    'qapi-domain',
+    'qapidoc',
+    'qmp_lexer',
+]
 
 if sphinx.version_info[:3] > (4, 0, 0):
     tags.add('sphinx4')
diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
new file mode 100644
index 00000000000..293cb922861
--- /dev/null
+++ b/docs/sphinx/qapi-domain.py
@@ -0,0 +1,52 @@
+"""
+QAPI domain extension.
+"""
+
+from __future__ import annotations
+
+from typing import (
+    TYPE_CHECKING,
+    Any,
+    Dict,
+    List,
+    Tuple,
+)
+
+from sphinx.domains import Domain, ObjType
+from sphinx.util import logging
+
+
+if TYPE_CHECKING:
+    from sphinx.application import Sphinx
+
+logger = logging.getLogger(__name__)
+
+
+class QAPIDomain(Domain):
+    """QAPI language domain."""
+
+    name = "qapi"
+    label = "QAPI"
+
+    object_types: Dict[str, ObjType] = {}
+    directives = {}
+    roles = {}
+    initial_data: Dict[str, Dict[str, Tuple[Any]]] = {}
+    indices = []
+
+    def merge_domaindata(
+        self, docnames: List[str], otherdata: Dict[str, Any]
+    ) -> None:
+        pass
+
+
+def setup(app: Sphinx) -> Dict[str, Any]:
+    app.setup_extension("sphinx.directives")
+    app.add_domain(QAPIDomain)
+
+    return {
+        "version": "1.0",
+        "env_version": 1,
+        "parallel_read_safe": True,
+        "parallel_write_safe": True,
+    }
-- 
2.47.0


