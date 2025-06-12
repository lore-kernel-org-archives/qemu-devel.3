Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BC0C61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 22:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPq9I-0004Ix-3p; Thu, 12 Jun 2025 18:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uPq9G-0004F1-LC
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 18:11:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uPq9D-00030P-PK
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 18:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749766307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q1yVPUAo2oksMyD3o7FiJnkiOZmgkqfQJaer1HOZFAg=;
 b=EryA6B8x6feNG3bYST7CVKMgrxyMEM8p2x2zrjazGoHr/7Qmh1mPA9dkCXAdENutRZwKGC
 AJrtwI9Jg2AlYuWCIKCurD/B/4GWhGYV2vQJolZX4DOMSTUgFT7dME8ETF6Rvl89pb0erx
 gH3BSI/5NpdDwFi/9lKhOk7ek5wWmx0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-GHxXXXPUMou2K0sKFVSEkA-1; Thu,
 12 Jun 2025 18:11:43 -0400
X-MC-Unique: GHxXXXPUMou2K0sKFVSEkA-1
X-Mimecast-MFC-AGG-ID: GHxXXXPUMou2K0sKFVSEkA_1749766300
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 732BA18002E4; Thu, 12 Jun 2025 22:11:40 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.54])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 559A719560A3; Thu, 12 Jun 2025 22:11:31 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Jiri Pirko <jiri@resnulli.us>,
 Ani Sinha <anisinha@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hanna Reitz <hreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Lukas Straub <lukasstraub2@web.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fan Ni <fan.ni@samsung.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 3/3] docs: remove special parsing for freeform sections
Date: Thu, 12 Jun 2025 18:10:51 -0400
Message-ID: <20250612221051.1224565-4-jsnow@redhat.com>
In-Reply-To: <20250612221051.1224565-1-jsnow@redhat.com>
References: <20250612221051.1224565-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=unavailable autolearn_force=no
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

This change removes special parsing for freeform sections and allows
them to simply be unmodified rST syntax. The existing headings in the
QAPI schema are adjusted to reflect the new paradigm.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/devel/qapi-code-gen.rst         | 28 ++++++++++++++-------
 docs/interop/firmware.json           |  4 ++-
 docs/interop/vhost-user.json         |  4 ++-
 docs/sphinx/qapidoc.py               | 37 +---------------------------
 qapi/acpi.json                       |  4 ++-
 qapi/audio.json                      |  4 ++-
 qapi/authz.json                      |  4 ++-
 qapi/block-core.json                 |  3 ++-
 qapi/block-export.json               |  3 ++-
 qapi/block.json                      |  7 ++++--
 qapi/char.json                       |  4 ++-
 qapi/common.json                     |  4 ++-
 qapi/compat.json                     |  4 ++-
 qapi/control.json                    |  4 ++-
 qapi/crypto.json                     |  4 ++-
 qapi/cryptodev.json                  |  4 ++-
 qapi/cxl.json                        |  4 ++-
 qapi/dump.json                       |  4 ++-
 qapi/ebpf.json                       |  4 ++-
 qapi/error.json                      |  4 ++-
 qapi/introspect.json                 |  4 ++-
 qapi/job.json                        |  4 ++-
 qapi/machine-common.json             |  4 ++-
 qapi/machine.json                    |  4 ++-
 qapi/migration.json                  |  4 ++-
 qapi/misc.json                       |  4 ++-
 qapi/net.json                        |  4 ++-
 qapi/pci.json                        |  4 ++-
 qapi/qapi-schema.json                |  4 ++-
 qapi/qdev.json                       |  4 ++-
 qapi/qom.json                        |  4 ++-
 qapi/replay.json                     |  4 ++-
 qapi/rocker.json                     |  4 ++-
 qapi/run-state.json                  |  4 ++-
 qapi/sockets.json                    |  4 ++-
 qapi/stats.json                      |  4 ++-
 qapi/tpm.json                        |  4 ++-
 qapi/trace.json                      |  4 ++-
 qapi/transaction.json                |  4 ++-
 qapi/uefi.json                       |  4 ++-
 qapi/ui.json                         | 14 ++++++++---
 qapi/vfio.json                       |  4 ++-
 qapi/virtio.json                     |  4 ++-
 qapi/yank.json                       |  4 ++-
 scripts/qapi/parser.py               |  7 ------
 storage-daemon/qapi/qapi-schema.json |  8 ++++--
 tests/qapi-schema/doc-good.json      | 10 +++++---
 47 files changed, 166 insertions(+), 103 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 231cc0fecf7..dfdbeac5a5a 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -876,25 +876,35 @@ structuring content.
 Headings and subheadings
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
-A free-form documentation comment containing a line which starts with
-some ``=`` symbols and then a space defines a section heading::
+Free-form documentation does not start with ``@SYMBOL`` and can contain
+arbitrary rST markup. Headings can be marked up using the standard rST
+syntax::
 
     ##
-    # = This is a top level heading
+    # *************************
+    # This is a level 2 heading
+    # *************************
     #
     # This is a free-form comment which will go under the
     # top level heading.
     ##
 
     ##
-    # == This is a second level heading
+    # This is a third level heading
+    # ==============================
+    #
+    # Level 4
+    # _______
+    #
+    # Level 5
+    # ^^^^^^^
+    #
+    # Level 6
+    # """""""
     ##
 
-A heading line must be the first line of the documentation
-comment block.
-
-Section headings must always be correctly nested, so you can only
-define a third-level heading inside a second-level heading, and so on.
+Level 1 headings are reserved for use by the generated documentation
+page itself, leaving level 2 as the highest level that should be used.
 
 
 Documentation markup
diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 745d21d8223..f46fdedfa89 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -11,7 +11,9 @@
 # later. See the COPYING file in the top-level directory.
 
 ##
-# = Firmware
+# ********
+# Firmware
+# ********
 ##
 
 { 'pragma': {
diff --git a/docs/interop/vhost-user.json b/docs/interop/vhost-user.json
index b6ade9e4931..095eb99cf79 100644
--- a/docs/interop/vhost-user.json
+++ b/docs/interop/vhost-user.json
@@ -10,7 +10,9 @@
 # later. See the COPYING file in the top-level directory.
 
 ##
-# = vhost user backend discovery & capabilities
+# *******************************************
+# vhost user backend discovery & capabilities
+# *******************************************
 ##
 
 ##
diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index c9c477378f5..cdf556c2a3c 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -391,44 +391,9 @@ def visit_module(self, path: str) -> None:
         self.ensure_blank_line()
 
     def visit_freeform(self, doc: QAPIDoc) -> None:
-        # TODO: Once the old qapidoc transformer is deprecated, freeform
-        # sections can be updated to pure rST, and this transformed removed.
-        #
-        # For now, translate our micro-format into rST. Code adapted
-        # from Peter Maydell's freeform().
-
         assert len(doc.all_sections) == 1, doc.all_sections
         body = doc.all_sections[0]
-        text = body.text
-        info = doc.info
-
-        if re.match(r"=+ ", text):
-            # Section/subsection heading (if present, will always be the
-            # first line of the block)
-            (heading, _, text) = text.partition("\n")
-            (leader, _, heading) = heading.partition(" ")
-            # Implicit +1 for heading in the containing .rst doc
-            level = len(leader) + 1
-
-            # https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#sections
-            markers = ' #*=_^"'
-            overline = level <= 2
-            marker = markers[level]
-
-            self.ensure_blank_line()
-            # This credits all 2 or 3 lines to the single source line.
-            if overline:
-                self.add_line(marker * len(heading), info)
-            self.add_line(heading, info)
-            self.add_line(marker * len(heading), info)
-            self.ensure_blank_line()
-
-            # Eat blank line(s) and advance info
-            trimmed = text.lstrip("\n")
-            text = trimmed
-            info = info.next_line(len(text) - len(trimmed) + 1)
-
-        self.add_lines(text, info)
+        self.add_lines(body.text, doc.info)
         self.ensure_blank_line()
 
     def visit_entity(self, ent: QAPISchemaDefinition) -> None:
diff --git a/qapi/acpi.json b/qapi/acpi.json
index 2d53b823656..90f8f564fda 100644
--- a/qapi/acpi.json
+++ b/qapi/acpi.json
@@ -6,7 +6,9 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 ##
-# = ACPI
+# ****
+# ACPI
+# ****
 ##
 
 ##
diff --git a/qapi/audio.json b/qapi/audio.json
index 16de231f6d8..6a22ca384aa 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -7,7 +7,9 @@
 # See the COPYING file in the top-level directory.
 
 ##
-# = Audio
+# *****
+# Audio
+# *****
 ##
 
 ##
diff --git a/qapi/authz.json b/qapi/authz.json
index 7fc6e3032ea..ad1b4b3af0c 100644
--- a/qapi/authz.json
+++ b/qapi/authz.json
@@ -2,7 +2,9 @@
 # vim: filetype=python
 
 ##
-# = User authorization
+# ******************
+# User authorization
+# ******************
 ##
 
 ##
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1df6644f0de..8b413946ff8 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2,7 +2,8 @@
 # vim: filetype=python
 
 ##
-# == Block core (VM unrelated)
+# Block core (VM unrelated)
+# =========================
 ##
 
 { 'include': 'common.json' }
diff --git a/qapi/block-export.json b/qapi/block-export.json
index ed4deb54db2..2241bfecf25 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -2,7 +2,8 @@
 # vim: filetype=python
 
 ##
-# == Block device exports
+# Block device exports
+# ====================
 ##
 
 { 'include': 'sockets.json' }
diff --git a/qapi/block.json b/qapi/block.json
index 1490a1a17f8..2d54a81c366 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -2,13 +2,16 @@
 # vim: filetype=python
 
 ##
-# = Block devices
+# *************
+# Block devices
+# *************
 ##
 
 { 'include': 'block-core.json' }
 
 ##
-# == Additional block stuff (VM related)
+# Additional block stuff (VM related)
+# ===================================
 ##
 
 ##
diff --git a/qapi/char.json b/qapi/char.json
index df6e325e2e1..f38d04986dd 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -3,7 +3,9 @@
 #
 
 ##
-# = Character devices
+# *****************
+# Character devices
+# *****************
 ##
 
 { 'include': 'sockets.json' }
diff --git a/qapi/common.json b/qapi/common.json
index 0e3a0bbbfb0..af7e3d618a7 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -2,7 +2,9 @@
 # vim: filetype=python
 
 ##
-# = Common data types
+# *****************
+# Common data types
+# *****************
 ##
 
 ##
diff --git a/qapi/compat.json b/qapi/compat.json
index 42034d9368c..90b8d51cf27 100644
--- a/qapi/compat.json
+++ b/qapi/compat.json
@@ -2,7 +2,9 @@
 # vim: filetype=python
 
 ##
-# = Compatibility policy
+# ********************
+# Compatibility policy
+# ********************
 ##
 
 ##
diff --git a/qapi/control.json b/qapi/control.json
index 34b733f63b6..ab0b3a3bbe5 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -3,7 +3,9 @@
 #
 
 ##
-# = QMP monitor control
+# *******************
+# QMP monitor control
+# *******************
 ##
 
 ##
diff --git a/qapi/crypto.json b/qapi/crypto.json
index 9ec6301e188..21006de36c4 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -3,7 +3,9 @@
 #
 
 ##
-# = Cryptography
+# ************
+# Cryptography
+# ************
 ##
 
 ##
diff --git a/qapi/cryptodev.json b/qapi/cryptodev.json
index b13db264034..1f49e1822c0 100644
--- a/qapi/cryptodev.json
+++ b/qapi/cryptodev.json
@@ -5,7 +5,9 @@
 # See the COPYING file in the top-level directory.
 
 ##
-# = Cryptography devices
+# ********************
+# Cryptography devices
+# ********************
 ##
 
 ##
diff --git a/qapi/cxl.json b/qapi/cxl.json
index 8f2e9237b19..52cc5d4f336 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -2,7 +2,9 @@
 # vim: filetype=python
 
 ##
-# = CXL devices
+# ***********
+# CXL devices
+# ***********
 ##
 
 ##
diff --git a/qapi/dump.json b/qapi/dump.json
index d0ba1f0596f..0642ca157b8 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -5,7 +5,9 @@
 # See the COPYING file in the top-level directory.
 
 ##
-# = Dump guest memory
+# *****************
+# Dump guest memory
+# *****************
 ##
 
 ##
diff --git a/qapi/ebpf.json b/qapi/ebpf.json
index db19ae850fc..d45054e6663 100644
--- a/qapi/ebpf.json
+++ b/qapi/ebpf.json
@@ -5,7 +5,9 @@
 # See the COPYING file in the top-level directory.
 
 ##
-# = eBPF Objects
+# ************
+# eBPF Objects
+# ************
 #
 # eBPF object is an ELF binary that contains the eBPF program and eBPF
 # map description(BTF).  Overall, eBPF object should contain the
diff --git a/qapi/error.json b/qapi/error.json
index 135c1e82319..54cb02fb880 100644
--- a/qapi/error.json
+++ b/qapi/error.json
@@ -2,7 +2,9 @@
 # vim: filetype=python
 
 ##
-# = QMP errors
+# **********
+# QMP errors
+# **********
 ##
 
 ##
diff --git a/qapi/introspect.json b/qapi/introspect.json
index e9e02972821..26d8839f19c 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -10,7 +10,9 @@
 # See the COPYING file in the top-level directory.
 
 ##
-# = QMP introspection
+# *****************
+# QMP introspection
+# *****************
 ##
 
 ##
diff --git a/qapi/job.json b/qapi/job.json
index 126fa5ce602..16b280f52f8 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -2,7 +2,9 @@
 # vim: filetype=python
 
 ##
-# = Background jobs
+# ***************
+# Background jobs
+# ***************
 ##
 
 ##
diff --git a/qapi/machine-common.json b/qapi/machine-common.json
index 298e51f373a..0f01599130c 100644
--- a/qapi/machine-common.json
+++ b/qapi/machine-common.json
@@ -5,7 +5,9 @@
 # See the COPYING file in the top-level directory.
 
 ##
-# = Common machine types
+# ********************
+# Common machine types
+# ********************
 ##
 
 ##
diff --git a/qapi/machine.json b/qapi/machine.json
index 0650b8de71a..6ebb99dfabe 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -5,7 +5,9 @@
 # See the COPYING file in the top-level directory.
 
 ##
-# = Machines
+# ********
+# Machines
+# ********
 ##
 
 { 'include': 'common.json' }
diff --git a/qapi/migration.json b/qapi/migration.json
index 4963f6ca127..84f4c800f7b 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -3,7 +3,9 @@
 #
 
 ##
-# = Migration
+# *********
+# Migration
+# *********
 ##
 
 { 'include': 'common.json' }
diff --git a/qapi/misc.json b/qapi/misc.json
index 4b9e601cfa5..a180c16db25 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3,7 +3,9 @@
 #
 
 ##
-# = Miscellanea
+# ***********
+# Miscellanea
+# ***********
 ##
 
 { 'include': 'common.json' }
diff --git a/qapi/net.json b/qapi/net.json
index 97ea1839813..3b03843c165 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -3,7 +3,9 @@
 #
 
 ##
-# = Net devices
+# ***********
+# Net devices
+# ***********
 ##
 
 { 'include': 'sockets.json' }
diff --git a/qapi/pci.json b/qapi/pci.json
index dc85a41d28b..a8671cd9ac3 100644
--- a/qapi/pci.json
+++ b/qapi/pci.json
@@ -6,7 +6,9 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 ##
-# = PCI
+# ***
+# PCI
+# ***
 ##
 
 ##
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index a8f66163cb7..49b9a0267d3 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -1,7 +1,9 @@
 # -*- Mode: Python -*-
 # vim: filetype=python
 ##
-# = Introduction
+# ************
+# Introduction
+# ************
 #
 # This manual describes the commands and events supported by the QEMU
 # Monitor Protocol (QMP).
diff --git a/qapi/qdev.json b/qapi/qdev.json
index 32c7d100463..441ed518b87 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -5,7 +5,9 @@
 # See the COPYING file in the top-level directory.
 
 ##
-# = Device infrastructure (qdev)
+# ****************************
+# Device infrastructure (qdev)
+# ****************************
 ##
 
 { 'include': 'qom.json' }
diff --git a/qapi/qom.json b/qapi/qom.json
index 3e8debf78c2..c8fe0258a5f 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -10,7 +10,9 @@
 { 'include': 'crypto.json' }
 
 ##
-# = QEMU Object Model (QOM)
+# ***********************
+# QEMU Object Model (QOM)
+# ***********************
 ##
 
 ##
diff --git a/qapi/replay.json b/qapi/replay.json
index 35e0c4a6926..e46c5c1d3f3 100644
--- a/qapi/replay.json
+++ b/qapi/replay.json
@@ -3,7 +3,9 @@
 #
 
 ##
-# = Record/replay
+# *************
+# Record/replay
+# *************
 ##
 
 { 'include': 'common.json' }
diff --git a/qapi/rocker.json b/qapi/rocker.json
index 0c7ef1f77c8..e4949649526 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -2,7 +2,9 @@
 # vim: filetype=python
 
 ##
-# = Rocker switch device
+# ********************
+# Rocker switch device
+# ********************
 ##
 
 ##
diff --git a/qapi/run-state.json b/qapi/run-state.json
index fd09beb35cb..083a3c5eb30 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -3,7 +3,9 @@
 #
 
 ##
-# = VM run state
+# ************
+# VM run state
+# ************
 ##
 
 ##
diff --git a/qapi/sockets.json b/qapi/sockets.json
index f9f559dabae..b5f4a8fecda 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -2,7 +2,9 @@
 # vim: filetype=python
 
 ##
-# = Socket data types
+# *****************
+# Socket data types
+# *****************
 ##
 
 ##
diff --git a/qapi/stats.json b/qapi/stats.json
index 8902ef94e08..78b88881eab 100644
--- a/qapi/stats.json
+++ b/qapi/stats.json
@@ -9,7 +9,9 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 ##
-# = Statistics
+# **********
+# Statistics
+# **********
 ##
 
 ##
diff --git a/qapi/tpm.json b/qapi/tpm.json
index a16a72edb98..e66b107f1d0 100644
--- a/qapi/tpm.json
+++ b/qapi/tpm.json
@@ -3,7 +3,9 @@
 #
 
 ##
-# = TPM (trusted platform module) devices
+# *************************************
+# TPM (trusted platform module) devices
+# *************************************
 ##
 
 ##
diff --git a/qapi/trace.json b/qapi/trace.json
index eb5f63f5135..d08c9c6a889 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -7,7 +7,9 @@
 # See the COPYING file in the top-level directory.
 
 ##
-# = Tracing
+# *******
+# Tracing
+# *******
 ##
 
 ##
diff --git a/qapi/transaction.json b/qapi/transaction.json
index 9d9e7af26cb..927035f5a7e 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -3,7 +3,9 @@
 #
 
 ##
-# = Transactions
+# ************
+# Transactions
+# ************
 ##
 
 { 'include': 'block-core.json' }
diff --git a/qapi/uefi.json b/qapi/uefi.json
index 6592183d6cf..a206c2e9539 100644
--- a/qapi/uefi.json
+++ b/qapi/uefi.json
@@ -3,7 +3,9 @@
 #
 
 ##
-# = UEFI Variable Store
+# *******************
+# UEFI Variable Store
+# *******************
 #
 # The QEMU efi variable store implementation (hw/uefi/) uses this to
 # store non-volatile variables in json format on disk.
diff --git a/qapi/ui.json b/qapi/ui.json
index 514fa159b10..f5e77ae19d7 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -3,7 +3,9 @@
 #
 
 ##
-# = Remote desktop
+# **************
+# Remote desktop
+# **************
 ##
 
 { 'include': 'common.json' }
@@ -200,7 +202,8 @@
   'if': 'CONFIG_PIXMAN' }
 
 ##
-# == Spice
+# Spice
+# =====
 ##
 
 ##
@@ -461,7 +464,8 @@
   'if': 'CONFIG_SPICE' }
 
 ##
-# == VNC
+# VNC
+# ===
 ##
 
 ##
@@ -794,7 +798,9 @@
   'if': 'CONFIG_VNC' }
 
 ##
-# = Input
+# *****
+# Input
+# *****
 ##
 
 ##
diff --git a/qapi/vfio.json b/qapi/vfio.json
index b53b7caecd7..a1a9c5b673d 100644
--- a/qapi/vfio.json
+++ b/qapi/vfio.json
@@ -3,7 +3,9 @@
 #
 
 ##
-# = VFIO devices
+# ************
+# VFIO devices
+# ************
 ##
 
 ##
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 73df718a261..3cac0774f7a 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -3,7 +3,9 @@
 #
 
 ##
-# = Virtio devices
+# **************
+# Virtio devices
+# **************
 ##
 
 ##
diff --git a/qapi/yank.json b/qapi/yank.json
index 30f46c97c98..d13a8e91171 100644
--- a/qapi/yank.json
+++ b/qapi/yank.json
@@ -3,7 +3,9 @@
 #
 
 ##
-# = Yank feature
+# ************
+# Yank feature
+# ************
 ##
 
 ##
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 949d9e8bff7..aad7e249f86 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -597,22 +597,15 @@ def get_doc(self) -> 'QAPIDoc':
             # Free-form documentation
             doc = QAPIDoc(info)
             doc.ensure_untagged_section(self.info)
-            first = True
             while line is not None:
                 if match := self._match_at_name_colon(line):
                     raise QAPIParseError(
                         self,
                         "'@%s:' not allowed in free-form documentation"
                         % match.group(1))
-                if line.startswith('='):
-                    if not first:
-                        raise QAPIParseError(
-                            self,
-                            "'=' heading must come first in a comment block")
                 doc.append_line(line)
                 self.accept(False)
                 line = self.get_doc_line()
-                first = False
 
         self.accept()
         doc.end()
diff --git a/storage-daemon/qapi/qapi-schema.json b/storage-daemon/qapi/qapi-schema.json
index 0427594c984..478e7a92b21 100644
--- a/storage-daemon/qapi/qapi-schema.json
+++ b/storage-daemon/qapi/qapi-schema.json
@@ -14,7 +14,9 @@
 # storage daemon.
 
 ##
-# = Introduction
+# ************
+# Introduction
+# ************
 #
 # This manual describes the commands and events supported by the QEMU
 # storage daemon QMP.
@@ -51,7 +53,9 @@
 { 'include': '../../qapi/job.json' }
 
 ##
-# = Block devices
+# *************
+# Block devices
+# *************
 ##
 { 'include': '../../qapi/block-core.json' }
 { 'include': '../../qapi/block-export.json' }
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index 6dcde8fd7e8..183da7df724 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -8,7 +8,9 @@
     'documentation-exceptions': [ 'Enum', 'Variant1', 'Alternate', 'cmd' ] } }
 
 ##
-# = Section
+# *******
+# Section
+# *******
 ##
 
 ##
@@ -16,7 +18,8 @@
 ##
 
 ##
-# == Subsection
+# Subsection
+# ==========
 #
 # *with emphasis*
 # @var {in braces}
@@ -144,7 +147,8 @@
   'if': { 'not': { 'any': [ 'IFONE', 'IFTWO' ] } } }
 
 ##
-# == Another subsection
+# Another subsection
+# ==================
 ##
 
 ##
-- 
2.48.1


