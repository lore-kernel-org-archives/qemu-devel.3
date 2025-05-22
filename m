Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FF8C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 17:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI9KZ-0003oe-6q; Thu, 22 May 2025 13:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uI9KI-0003ju-6F
 for qemu-devel@nongnu.org; Thu, 22 May 2025 13:03:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uI9KD-0008AL-TK
 for qemu-devel@nongnu.org; Thu, 22 May 2025 13:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747933399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FULH1aFgLOs2anUTjGkG/x2yAtoUIOWkDyDopVX4MnA=;
 b=bPB06P35W+oA6/mWfJHeaUUGgXI5wdZl0mSnxSOVlOFH7lhw4wuFdhXIH0/E7VSfED4PTZ
 o7Fh64Dxl/DVKFJhs3jdV7P1HFZ0yvQRbARSk8s6iGAdccvH5msjwYwczwyvUz5OUpRLYL
 /wNWJi6qOJTp0nZkbb6mDzdN6hg8cmA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-0xqAyOMdMGSSQjSFOUI1xw-1; Thu,
 22 May 2025 13:03:16 -0400
X-MC-Unique: 0xqAyOMdMGSSQjSFOUI1xw-1
X-Mimecast-MFC-AGG-ID: 0xqAyOMdMGSSQjSFOUI1xw_1747933388
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67721180087F; Thu, 22 May 2025 17:03:08 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.178])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 341A819560B0; Thu, 22 May 2025 17:02:57 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fan Ni <fan.ni@samsung.com>, Zhao Liu <zhao1.liu@intel.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Jason Wang <jasowang@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Igor Mammedov <imammedo@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, Eric Blake <eblake@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Mads Ynddal <mads@ynddal.dk>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Peter Xu <peterx@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 3/3] docs: remove special parsing for freeform sections
Date: Thu, 22 May 2025 13:02:19 -0400
Message-ID: <20250522170219.58058-4-jsnow@redhat.com>
In-Reply-To: <20250522170219.58058-1-jsnow@redhat.com>
References: <20250522170219.58058-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Markus: presumably you'll want to update the tests and/or change the
parser errors. Please advise!

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
index 045dab6228b..b67e4583161 100644
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
index dd5a58d13e6..3bc03de4c25 100644
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
index b1937780e19..d6f07e36bf6 100644
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
index c783e01a532..606fcd061b4 100644
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
index e66666f5c64..ca370896cbb 100644
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
index dde2f9538f8..e740e28992f 100644
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
index 336386f79e1..0ecc2117ec8 100644
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
index c9d967d782e..55a0bb4073f 100644
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
index 04d0e21d209..e50e21a7dfb 100644
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
index dd947d3bbc8..fee13593a1d 100644
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
index d7826c0e323..36a12662b64 100644
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
index 01bb242947c..da1c223d548 100644
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
index cfc3beedd21..506f6b41ef5 100644
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
index c8feb9fe17b..630046d6856 100644
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
index 8b9c53595c4..4d961a7d206 100644
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
index 559b66f2017..fad74569cad 100644
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
index 310cc4fd190..337c3a06966 100644
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
index 7bc600bb768..21273c8ecdf 100644
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
index 04c118e4d61..af2a69b0222 100644
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
index ce95cfa46b7..0c8c9845f82 100644
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
index 6a950233158..3b78232a639 100644
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
index 021e383496c..3612f6c320f 100644
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
index bdfcabe1df4..254f30313d4 100644
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
 # The qemu efi variable store implementation (hw/uefi/) uses this to
 # store non-volatile variables in json format on disk.
diff --git a/qapi/ui.json b/qapi/ui.json
index c536d4e5241..dade7b8345f 100644
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
index d351d2166ef..9b435481555 100644
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


