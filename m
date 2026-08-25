Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB72C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 22:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyzBi-0006W3-Vy; Tue, 25 Aug 2026 18:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyzBh-0006Qu-Fl
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:00:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyzBe-0000h3-U8
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787695206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zk5epx61BNWuX+gViUBZ3MC0IEPi+I97D9JbESOchGc=;
 b=Y9jqZX8+Ask7sLSXpz3FcURuCPnEG6qjFL/4cg+L+q2GhpYZjCXRTaacod41T3Tigd66CC
 oPjgPnlcXe0Mna/+4ZbrbbqZ2vTfVI4NxP8QE2DFJqVOJVg1zQQMOhuhh2e/DhKxTtR18C
 0Fk0QCIdmaamIrTt2tggdbZVjLiq1QU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-npp9WwMbP-mvNCAZLnMI2g-1; Tue,
 25 Aug 2026 18:00:04 -0400
X-MC-Unique: npp9WwMbP-mvNCAZLnMI2g-1
X-Mimecast-MFC-AGG-ID: npp9WwMbP-mvNCAZLnMI2g_1787695202
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDF5418C104F; Tue, 25 Aug 2026 22:00:01 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.17])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 096E019560AB; Tue, 25 Aug 2026 21:59:57 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Roth <michael.roth@amd.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Kyle Evans <kevans@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 15/16] sphinx: drop fakedbusdoc
Date: Tue, 25 Aug 2026 17:58:50 -0400
Message-ID: <20260825215851.1780608-16-jsnow@redhat.com>
In-Reply-To: <20260825215851.1780608-1-jsnow@redhat.com>
References: <20260825215851.1780608-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now that we rely on a sufficiently modern Sphinx, we no longer need a
stub doc for dbus.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/conf.py                  |  7 +------
 docs/interop/dbus-display.rst | 14 +-------------
 docs/interop/dbus-vmstate.rst | 14 +-------------
 docs/interop/dbus-vnc.rst     | 14 +-------------
 docs/sphinx/fakedbusdoc.py    | 30 ------------------------------
 5 files changed, 4 insertions(+), 75 deletions(-)
 delete mode 100644 docs/sphinx/fakedbusdoc.py

diff --git a/docs/conf.py b/docs/conf.py
index cded047b539..914bae67d9c 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -59,6 +59,7 @@
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
 # ones.
 extensions = [
+    'dbusdoc',
     'depfile',
     'hxtool',
     'kerneldoc',
@@ -67,12 +68,6 @@
     'qmp_lexer',
 ]
 
-if sphinx.version_info[:3] > (4, 0, 0):
-    tags.add('sphinx4')
-    extensions += ['dbusdoc']
-else:
-    extensions += ['fakedbusdoc']
-
 # Add any paths that contain templates here, relative to this directory.
 templates_path = [os.path.join(qemu_docdir, '_templates')]
 
diff --git a/docs/interop/dbus-display.rst b/docs/interop/dbus-display.rst
index 87648e91dc0..c87a04c9693 100644
--- a/docs/interop/dbus-display.rst
+++ b/docs/interop/dbus-display.rst
@@ -18,16 +18,4 @@ QEMU also implements the standard interfaces, such as
    :local:
    :depth: 1
 
-.. only:: sphinx4
-
-   .. dbus-doc:: ui/dbus-display1.xml
-
-.. only:: not sphinx4
-
-   .. warning::
-      Sphinx 4 is required to build D-Bus documentation.
-
-      This is the content of ``ui/dbus-display1.xml``:
-
-   .. literalinclude:: ../../ui/dbus-display1.xml
-      :language: xml
+.. dbus-doc:: ui/dbus-display1.xml
diff --git a/docs/interop/dbus-vmstate.rst b/docs/interop/dbus-vmstate.rst
index 5fb3f279e28..5f8c6d125de 100644
--- a/docs/interop/dbus-vmstate.rst
+++ b/docs/interop/dbus-vmstate.rst
@@ -23,16 +23,4 @@ dbus-vmstate object can be configured with the expected list of
 helpers by setting its ``id-list`` property, with a comma-separated
 ``Id`` list.
 
-.. only:: sphinx4
-
-   .. dbus-doc:: backends/dbus-vmstate1.xml
-
-.. only:: not sphinx4
-
-   .. warning::
-      Sphinx 4 is required to build D-Bus documentation.
-
-      This is the content of ``backends/dbus-vmstate1.xml``:
-
-   .. literalinclude:: ../../backends/dbus-vmstate1.xml
-      :language: xml
+.. dbus-doc:: backends/dbus-vmstate1.xml
diff --git a/docs/interop/dbus-vnc.rst b/docs/interop/dbus-vnc.rst
index d2b77978f63..5ea4fd57183 100644
--- a/docs/interop/dbus-vnc.rst
+++ b/docs/interop/dbus-vnc.rst
@@ -11,16 +11,4 @@ Objects are exported under ``/org/qemu/Vnc1/``.
    :local:
    :depth: 1
 
-.. only:: sphinx4
-
-   .. dbus-doc:: tools/qemu-vnc/qemu-vnc1.xml
-
-.. only:: not sphinx4
-
-   .. warning::
-      Sphinx 4 is required to build D-Bus documentation.
-
-      This is the content of ``tools/qemu-vnc/qemu-vnc1.xml``:
-
-   .. literalinclude:: ../../tools/qemu-vnc/qemu-vnc1.xml
-      :language: xml
+.. dbus-doc:: tools/qemu-vnc/qemu-vnc1.xml
diff --git a/docs/sphinx/fakedbusdoc.py b/docs/sphinx/fakedbusdoc.py
deleted file mode 100644
index 2d2e6ef6403..00000000000
--- a/docs/sphinx/fakedbusdoc.py
+++ /dev/null
@@ -1,30 +0,0 @@
-# D-Bus XML documentation extension, compatibility gunk for <sphinx4
-#
-# Copyright (C) 2021, Red Hat Inc.
-#
-# SPDX-License-Identifier: LGPL-2.1-or-later
-#
-# Author: Marc-André Lureau <marcandre.lureau@redhat.com>
-"""dbus-doc is a Sphinx extension that provides documentation from D-Bus XML."""
-
-from docutils.parsers.rst import Directive
-from sphinx.application import Sphinx
-from typing import Any, Dict
-
-
-class FakeDBusDocDirective(Directive):
-    has_content = True
-    required_arguments = 1
-
-    def run(self):
-        return []
-
-
-def setup(app: Sphinx) -> Dict[str, Any]:
-    """Register a fake dbus-doc directive with Sphinx"""
-    app.add_directive("dbus-doc", FakeDBusDocDirective)
-
-    return dict(
-        parallel_read_safe = True,
-        parallel_write_safe = True
-    )
-- 
2.55.0


