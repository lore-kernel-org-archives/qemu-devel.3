Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A3BC25B79
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 22:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s70Ak-00067A-W0; Tue, 14 May 2024 17:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s70Ag-000634-8Z
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:58:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s70Ab-0000Dc-E9
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715723928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OZBGd6fiW8xge38vRYdkLfE1il5IsQP9PqdgnacboQw=;
 b=MXfF9M+4xp5f94z2RvKDnjVNk9rpkopY6qTO4KkJQA76r1sX1s1haNX12kPq7pYnKDH63d
 0vKj2BHI2X2qBYVvr8vJ0GQYBFvKEmx80FxuwA2rwkSU52NaUxu3PcEAFD3Qe8sX1MelFs
 OPBgyABL63fVyxvIm9MNp/kKq04L/pA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-5Te-TuokPdOYtAbIDbMmCQ-1; Tue,
 14 May 2024 17:58:45 -0400
X-MC-Unique: 5Te-TuokPdOYtAbIDbMmCQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E76A63801ECE;
 Tue, 14 May 2024 21:58:44 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.17.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E1DA06BC5;
 Tue, 14 May 2024 21:58:41 +0000 (UTC)
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
Subject: [PATCH 19/20] qapi: convert "Note" sections to plain rST
Date: Tue, 14 May 2024 17:57:38 -0400
Message-ID: <20240514215740.940155-20-jsnow@redhat.com>
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

We do not need a dedicated section for notes. By eliminating a specially
parsed section, these notes can be treated as normal rST paragraphs in
the new QMP reference manual, and can be placed and styled much more
flexibly.

Update the QAPI parser to now prohibit special "Note" sections while
suggesting a new syntax.

The exact formatting to use is a matter of taste, but a good candidate
is simply:

.. note:: lorem ipsum ...

but there are other choices, too. The Sphinx readthedocs theme offers
theming for the following forms (capitalization unimportant); all are
adorned with a (!) symbol in the title bar for rendered HTML docs.

These are rendered in orange:

.. Attention:: ...
.. Caution:: ...
.. WARNING:: ...

These are rendered in red:

.. DANGER:: ...
.. Error:: ...

These are rendered in green:

.. Hint:: ...
.. Important:: ...
.. Tip:: ...

These are rendered in blue:

.. Note:: ...
.. admonition:: custom title

   admonition body text

This patch uses ".. notes::" almost everywhere, with just two "caution"
directives. ".. admonition:: notes" is used in a few places where we had
an ordered list of multiple notes.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-core.json                          | 30 +++----
 qapi/block.json                               |  2 +-
 qapi/char.json                                | 12 +--
 qapi/control.json                             | 15 ++--
 qapi/dump.json                                |  2 +-
 qapi/introspect.json                          |  6 +-
 qapi/machine-target.json                      | 26 +++---
 qapi/machine.json                             | 47 +++++-----
 qapi/migration.json                           | 12 +--
 qapi/misc.json                                | 88 +++++++++----------
 qapi/net.json                                 |  6 +-
 qapi/pci.json                                 |  7 +-
 qapi/qdev.json                                | 30 +++----
 qapi/qom.json                                 | 19 ++--
 qapi/rocker.json                              | 16 ++--
 qapi/run-state.json                           | 18 ++--
 qapi/sockets.json                             | 10 +--
 qapi/stats.json                               | 22 ++---
 qapi/transaction.json                         |  8 +-
 qapi/ui.json                                  | 29 +++---
 qapi/virtio.json                              | 12 +--
 qga/qapi-schema.json                          | 48 +++++-----
 scripts/qapi/parser.py                        |  9 ++
 tests/qapi-schema/doc-empty-section.err       |  2 +-
 tests/qapi-schema/doc-empty-section.json      |  2 +-
 tests/qapi-schema/doc-good.json               |  6 +-
 tests/qapi-schema/doc-good.out                | 10 ++-
 tests/qapi-schema/doc-good.txt                | 14 ++-
 .../qapi-schema/doc-interleaved-section.json  |  2 +-
 29 files changed, 258 insertions(+), 252 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 64fe5240cc9..530af40404d 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1510,7 +1510,7 @@
 # @mode: whether and how QEMU should create a new image, default is
 #     'absolute-paths'.
 #
-# Note: Either @device or @node-name must be set but not both.
+# .. note:: Either @device or @node-name must be set but not both.
 #
 ##
 { 'struct': 'BlockdevSnapshotSync',
@@ -1616,9 +1616,9 @@
 #
 # @unstable: Member @x-perf is experimental.
 #
-# Note: @on-source-error and @on-target-error only affect background
-#     I/O.  If an error occurs during a guest write request, the
-#     device's rerror/werror actions will be used.
+# .. note:: @on-source-error and @on-target-error only affect background
+#    I/O.  If an error occurs during a guest write request, the device's
+#    rerror/werror actions will be used.
 #
 # Since: 4.2
 ##
@@ -5534,8 +5534,8 @@
 #     after this event and must be repaired (Since 2.2; before, every
 #     BLOCK_IMAGE_CORRUPTED event was fatal)
 #
-# Note: If action is "stop", a STOP event will eventually follow the
-#     BLOCK_IO_ERROR event.
+# .. note:: If action is "stop", a STOP event will eventually follow the
+#    BLOCK_IO_ERROR event.
 #
 # Example:
 #
@@ -5581,8 +5581,8 @@
 #     field is a debugging aid for humans, it should not be parsed by
 #     applications) (since: 2.2)
 #
-# Note: If action is "stop", a STOP event will eventually follow the
-#     BLOCK_IO_ERROR event
+# .. note:: If action is "stop", a STOP event will eventually follow the
+#    BLOCK_IO_ERROR event.
 #
 # Since: 0.13
 #
@@ -5720,8 +5720,8 @@
 #
 # @speed: rate limit, bytes per second
 #
-# Note: The "ready to complete" status is always reset by a
-#     @BLOCK_JOB_ERROR event
+# .. note:: The "ready to complete" status is always reset by a
+#    @BLOCK_JOB_ERROR event.
 #
 # Since: 1.3
 #
@@ -5974,7 +5974,7 @@
 #
 # @sectors-count: failed read operation sector count
 #
-# Note: This event is rate-limited.
+# .. note:: This event is rate-limited.
 #
 # Since: 2.0
 #
@@ -6005,7 +6005,7 @@
 #
 # @sectors-count: failed read operation sector count
 #
-# Note: This event is rate-limited.
+# .. note:: This event is rate-limited.
 #
 # Since: 2.0
 #
@@ -6037,9 +6037,9 @@
 #
 # @name: the name of the internal snapshot to be created
 #
-# Notes: In transaction, if @name is empty, or any snapshot matching
-#     @name exists, the operation will fail.  Only some image formats
-#     support it, for example, qcow2, and rbd.
+# .. note:: In a transaction, if @name is empty or any snapshot matching
+#    @name exists, the operation will fail.  Only some image formats
+#    support it; for example, qcow2, and rbd.
 #
 # Since: 1.7
 ##
diff --git a/qapi/block.json b/qapi/block.json
index 5de99fe09d9..ea81d9e1921 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -113,7 +113,7 @@
 # Errors:
 #     - If @device is not a valid block device, DeviceNotFound
 #
-# Notes: Ejecting a device with no media results in success
+# .. note:: Ejecting a device with no media results in success.
 #
 # Since: 0.14
 #
diff --git a/qapi/char.json b/qapi/char.json
index ab4c23976ed..0f39c2d5cdf 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -21,8 +21,8 @@
 #     backend (e.g. with the chardev=... option) is in open or closed
 #     state (since 2.1)
 #
-# Notes: @filename is encoded using the QEMU command line character
-#     device encoding.  See the QEMU man page for details.
+# .. note:: @filename is encoded using the QEMU command line character
+#    device encoding.  See the QEMU man page for details.
 #
 # Since: 0.14
 ##
@@ -387,9 +387,9 @@
 #
 # @rows: console height, in chars
 #
-# Note: the options are only effective when the VNC or SDL graphical
-#     display backend is active.  They are ignored with the GTK,
-#     Spice, VNC and D-Bus display backends.
+# .. note:: The options are only effective when the VNC or SDL graphical
+#    display backend is active.  They are ignored with the GTK, Spice,
+#    VNC and D-Bus display backends.
 #
 # Since: 1.5
 ##
@@ -805,7 +805,7 @@
 #
 # @open: true if the guest has opened the virtio-serial port
 #
-# Note: This event is rate-limited.
+# .. note:: This event is rate-limited.
 #
 # Since: 2.1
 #
diff --git a/qapi/control.json b/qapi/control.json
index 10c906fa0e7..2498e5dd6ba 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -22,14 +22,13 @@
 #          "arguments": { "enable": [ "oob" ] } }
 #     <- { "return": {} }
 #
-# Notes: This command is valid exactly when first connecting: it must
-#     be issued before any other command will be accepted, and will
-#     fail once the monitor is accepting other commands.  (see qemu
-#     docs/interop/qmp-spec.rst)
+# .. note:: This command is valid exactly when first connecting: it must
+#    be issued before any other command will be accepted, and will fail
+#    once the monitor is accepting other commands.
+#    (see :doc:`/interop/qmp-spec`)
 #
-#     The QMP client needs to explicitly enable QMP capabilities,
-#     otherwise all the QMP capabilities will be turned off by
-#     default.
+# .. note:: The QMP client needs to explicitly enable QMP capabilities,
+#    otherwise all the QMP capabilities will be turned off by default.
 #
 # Since: 0.13
 ##
@@ -150,7 +149,7 @@
 #          ]
 #        }
 #
-# Note: This example has been shortened as the real response is too
+#     Note: This example has been shortened as the real response is too
 #     long.
 ##
 { 'command': 'query-commands', 'returns': ['CommandInfo'],
diff --git a/qapi/dump.json b/qapi/dump.json
index 2fa9504d864..f9aee7ea1dd 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -90,7 +90,7 @@
 #     and @length is not allowed to be specified with non-elf @format
 #     at the same time (since 2.0)
 #
-# Note: All boolean arguments default to false
+# .. note:: All boolean arguments default to false.
 #
 # Since: 1.2
 #
diff --git a/qapi/introspect.json b/qapi/introspect.json
index b041b02ba8c..b15052ec21a 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -41,9 +41,9 @@
 #     names are guaranteed to be unique (no name will be duplicated
 #     with different meta-types).
 #
-# Note: the QAPI schema is also used to help define *internal*
-#     interfaces, by defining QAPI types.  These are not part of the
-#     QMP wire ABI, and therefore not returned by this command.
+# .. note:: The QAPI schema is also used to help define *internal*
+#    interfaces, by defining QAPI types.  These are not part of the QMP
+#    wire ABI, and therefore not returned by this command.
 #
 # Since: 2.5
 ##
diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 29428530923..a8d9ec87f59 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -49,15 +49,15 @@
 #     to be migration-safe, but allows tooling to get an insight and
 #     work with model details.
 #
-# Note: When a non-migration-safe CPU model is expanded in static
-#     mode, some features enabled by the CPU model may be omitted,
-#     because they can't be implemented by a static CPU model
-#     definition (e.g. cache info passthrough and PMU passthrough in
-#     x86). If you need an accurate representation of the features
-#     enabled by a non-migration-safe CPU model, use @full.  If you
-#     need a static representation that will keep ABI compatibility
-#     even when changing QEMU version or machine-type, use @static
-#     (but keep in mind that some features may be omitted).
+# .. note:: When a non-migration-safe CPU model is expanded in static
+#    mode, some features enabled by the CPU model may be omitted,
+#    because they can't be implemented by a static CPU model definition
+#    (e.g. cache info passthrough and PMU passthrough in x86). If you
+#    need an accurate representation of the features enabled by a
+#    non-migration-safe CPU model, use @full.  If you need a static
+#    representation that will keep ABI compatibility even when changing
+#    QEMU version or machine-type, use @static (but keep in mind that
+#    some features may be omitted).
 #
 # Since: 2.8
 ##
@@ -175,8 +175,8 @@
 #     - if a model contains an unknown cpu definition name, unknown
 #       properties or properties with wrong types.
 #
-# Note: this command isn't specific to s390x, but is only implemented
-#     on this architecture currently.
+# .. note:: This command isn't specific to s390x, but is only
+#    implemented on this architecture currently.
 #
 # Since: 2.8
 ##
@@ -229,8 +229,8 @@
 #     - if a model contains an unknown cpu definition name, unknown
 #       properties or properties with wrong types.
 #
-# Note: this command isn't specific to s390x, but is only implemented
-#     on this architecture currently.
+# .. note:: This command isn't specific to s390x, but is only
+#    implemented on this architecture currently.
 #
 # Since: 2.8
 ##
diff --git a/qapi/machine.json b/qapi/machine.json
index 35cca12ba41..e9c9bef940d 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -24,9 +24,9 @@
 #
 # @avr: since 5.1
 #
-# Notes: The resulting QMP strings can be appended to the
-#     "qemu-system-" prefix to produce the corresponding QEMU
-#     executable name.  This is true even for "qemu-system-x86_64".
+# .. note:: The resulting QMP strings can be appended to the
+#    "qemu-system-" prefix to produce the corresponding QEMU executable
+#    name.  This is true even for "qemu-system-x86_64".
 #
 # Since: 3.0
 ##
@@ -305,8 +305,9 @@
 #
 # Since: 0.14
 #
-# Notes: If no UUID was specified for the guest, a null UUID is
-#     returned.
+# .. note:: If no UUID was specified for the guest, a null UUID is
+#    returned.
+#
 ##
 { 'struct': 'UuidInfo', 'data': {'UUID': 'str'} }
 
@@ -367,10 +368,10 @@
 #
 # Since: 0.14
 #
-# Notes: A guest may or may not respond to this command.  This command
-#     returning does not indicate that a guest has accepted the
-#     request or that it has shut down.  Many guests will respond to
-#     this command by prompting the user in some way.
+# .. note:: A guest may or may not respond to this command.  This
+#    command returning does not indicate that a guest has accepted the
+#    request or that it has shut down.  Many guests will respond to this
+#    command by prompting the user in some way.
 #
 # Example:
 #
@@ -389,8 +390,8 @@
 #
 # Since: 1.1
 #
-# Note: prior to 4.0, this command does nothing in case the guest
-#     isn't suspended.
+# .. note:: Prior to 4.0, this command does nothing in case the guest
+#    isn't suspended.
 #
 # Example:
 #
@@ -440,8 +441,8 @@
 #
 # Since: 0.14
 #
-# Note: prior to 2.1, this command was only supported for x86 and s390
-#     VMs
+# .. note:: Prior to 2.1, this command was only supported for x86 and
+#    s390 VMs
 #
 # Example:
 #
@@ -838,7 +839,7 @@
 #
 # Since: 0.14
 #
-# Notes: Errors were not reliably returned until 1.1
+# .. caution:: Errors were not reliably returned until 1.1.
 #
 # Example:
 #
@@ -864,7 +865,7 @@
 #
 # Since: 0.14
 #
-# Notes: Errors were not reliably returned until 1.1
+# .. caution:: Errors were not reliably returned until 1.1.
 #
 # Example:
 #
@@ -994,8 +995,8 @@
 #
 # @thread-id: thread number within the core the CPU  belongs to
 #
-# Note: management should be prepared to pass through additional
-#     properties with device_add.
+# .. note:: Management should be prepared to pass through additional
+#    properties with device_add.
 #
 # Since: 2.7
 ##
@@ -1122,9 +1123,9 @@
 #       the KVM kernel module cannot support it, KVMMissingCap
 #     - If no balloon device is present, DeviceNotActive
 #
-# Notes: This command just issues a request to the guest.  When it
-#     returns, the balloon size may not have changed.  A guest can
-#     change the balloon size independent of this command.
+# .. note:: This command just issues a request to the guest.  When it
+#    returns, the balloon size may not have changed.  A guest can change
+#    the balloon size independent of this command.
 #
 # Since: 0.14
 #
@@ -1184,7 +1185,7 @@
 # @actual: the logical size of the VM in bytes Formula used:
 #     logical_vm_size = vm_ram_size - balloon_size
 #
-# Note: this event is rate-limited.
+# .. note:: This event is rate-limited.
 #
 # Since: 1.2
 #
@@ -1246,7 +1247,7 @@
 # Emitted when the hv-balloon driver receives a "STATUS" message from
 # the guest.
 #
-# Note: this event is rate-limited.
+# .. note:: This event is rate-limited.
 #
 # Since: 8.2
 #
@@ -1591,7 +1592,7 @@
 #
 # @qom-path: path to the device object in the QOM tree (since 6.2)
 #
-# Note: this event is rate-limited.
+# .. note:: This event is rate-limited.
 #
 # Since: 5.1
 #
diff --git a/qapi/migration.json b/qapi/migration.json
index 89047d46c7c..a7b8ff138e3 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1428,8 +1428,8 @@
 #
 # Cancel the current executing migration process.
 #
-# Notes: This command succeeds even if there is no migration process
-#     running.
+# .. note:: This command succeeds even if there is no migration process
+#    running.
 #
 # Since: 0.14
 #
@@ -1561,16 +1561,16 @@
 #
 # Since: 0.14
 #
-# Notes:
+# .. admonition:: Notes
 #
 #     1. The 'query-migrate' command should be used to check
 #        migration's progress and final result (this information is
 #        provided by the 'status' member)
 #
-#     2. All boolean arguments default to false
+#     2. All boolean arguments default to false.
 #
 #     3. The user Monitor's "detach" argument is invalid in QMP and
-#        should not be used
+#        should not be used.
 #
 #     4. The uri argument should have the Uniform Resource Identifier
 #        of default destination VM. This connection will be bound to
@@ -1644,7 +1644,7 @@
 #
 # Since: 2.3
 #
-# Notes:
+# .. admonition:: Notes
 #
 #     1. It's a bad idea to use a string for the uri, but it needs to
 #        stay compatible with -incoming and the format of the uri is
diff --git a/qapi/misc.json b/qapi/misc.json
index 4b41e15dcd4..b04efbadec6 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -103,9 +103,9 @@
 #
 # Returns a list of information about each iothread.
 #
-# Note: this list excludes the QEMU main loop thread, which is not
-#     declared using the -object iothread command-line option.  It is
-#     always the main thread of the process.
+# .. note:: This list excludes the QEMU main loop thread, which is not
+#    declared using the ``-object iothread`` command-line option.  It is
+#    always the main thread of the process.
 #
 # Returns: a list of @IOThreadInfo for each iothread
 #
@@ -136,13 +136,13 @@
 #
 # Since: 0.14
 #
-# Notes: This function will succeed even if the guest is already in
-#     the stopped state.  In "inmigrate" state, it will ensure that
-#     the guest remains paused once migration finishes, as if the -S
-#     option was passed on the command line.
+# .. note:: This function will succeed even if the guest is already in
+#    the stopped state.  In "inmigrate" state, it will ensure that the
+#    guest remains paused once migration finishes, as if the ``-S``
+#    option was passed on the command line.
 #
-#     In the "suspended" state, it will completely stop the VM and
-#     cause a transition to the "paused" state.  (Since 9.0)
+#    In the "suspended" state, it will completely stop the VM and cause
+#    a transition to the "paused" state.  (Since 9.0)
 #
 # Example:
 #
@@ -158,15 +158,15 @@
 #
 # Since: 0.14
 #
-# Notes: This command will succeed if the guest is currently running.
-#     It will also succeed if the guest is in the "inmigrate" state;
-#     in this case, the effect of the command is to make sure the
-#     guest starts once migration finishes, removing the effect of the
-#     -S command line option if it was passed.
+# .. note:: This command will succeed if the guest is currently running.
+#    It will also succeed if the guest is in the "inmigrate" state; in
+#    this case, the effect of the command is to make sure the guest
+#    starts once migration finishes, removing the effect of the ``-S``
+#    command line option if it was passed.
 #
-#     If the VM was previously suspended, and not been reset or woken,
-#     this command will transition back to the "suspended" state.
-#     (Since 9.0)
+#    If the VM was previously suspended, and not been reset or woken,
+#    this command will transition back to the "suspended" state.  (Since
+#    9.0)
 #
 # Example:
 #
@@ -219,18 +219,18 @@
 #
 # Since: 0.14
 #
-# Notes: This command only exists as a stop-gap.  Its use is highly
-#     discouraged.  The semantics of this command are not guaranteed:
-#     this means that command names, arguments and responses can
-#     change or be removed at ANY time.  Applications that rely on
-#     long term stability guarantees should NOT use this command.
+# .. note:: This command only exists as a stop-gap.  Its use is highly
+#    discouraged.  The semantics of this command are not guaranteed:
+#    this means that command names, arguments and responses can change
+#    or be removed at ANY time.  Applications that rely on long term
+#    stability guarantees should NOT use this command.
 #
-#     Known limitations:
+#    Known limitations:
 #
-#     * This command is stateless, this means that commands that
-#       depend on state information (such as getfd) might not work
+#    * This command is stateless, this means that commands that
+#      depend on state information (such as getfd) might not work.
 #
-#     * Commands that prompt the user for data don't currently work
+#    * Commands that prompt the user for data don't currently work.
 #
 # Example:
 #
@@ -252,11 +252,11 @@
 #
 # Since: 0.14
 #
-# Notes: If @fdname already exists, the file descriptor assigned to it
-#     will be closed and replaced by the received file descriptor.
+# .. note:: If @fdname already exists, the file descriptor assigned to
+#    it will be closed and replaced by the received file descriptor.
 #
-#     The 'closefd' command can be used to explicitly close the file
-#     descriptor when it is no longer needed.
+#    The 'closefd' command can be used to explicitly close the file
+#    descriptor when it is no longer needed.
 #
 # Example:
 #
@@ -279,11 +279,11 @@
 #
 # Since: 8.0
 #
-# Notes: If @fdname already exists, the file descriptor assigned to it
-#     will be closed and replaced by the received file descriptor.
+# .. note:: If @fdname already exists, the file descriptor assigned to
+#    it will be closed and replaced by the received file descriptor.
 #
-#     The 'closefd' command can be used to explicitly close the file
-#     descriptor when it is no longer needed.
+#    The 'closefd' command can be used to explicitly close the file
+#    descriptor when it is no longer needed.
 #
 # Example:
 #
@@ -339,10 +339,9 @@
 #     - If file descriptor was not received, GenericError
 #     - If @fdset-id is a negative value, GenericError
 #
-# Notes:
-#     The list of fd sets is shared by all monitor connections.
+# .. note:: The list of fd sets is shared by all monitor connections.
 #
-#     If @fdset-id is not specified, a new fd set will be created.
+# .. note:: If @fdset-id is not specified, a new fd set will be created.
 #
 # Since: 1.2
 #
@@ -370,11 +369,10 @@
 #
 # Since: 1.2
 #
-# Notes:
-#     The list of fd sets is shared by all monitor connections.
+# .. note:: The list of fd sets is shared by all monitor connections.
 #
-#     If @fd is not specified, all file descriptors in @fdset-id will
-#     be removed.
+# .. note:: If @fd is not specified, all file descriptors in @fdset-id
+#    will be removed.
 #
 # Example:
 #
@@ -420,7 +418,7 @@
 #
 # Since: 1.2
 #
-# Note: The list of fd sets is shared by all monitor connections.
+# .. note:: The list of fd sets is shared by all monitor connections.
 #
 # Example:
 #
@@ -561,9 +559,9 @@
 #
 # @qom-path: path to the RTC object in the QOM tree
 #
-# Note: This event is rate-limited.  It is not guaranteed that the RTC
-#     in the system implements this event, or even that the system has
-#     an RTC at all.
+# .. note:: This event is rate-limited.  It is not guaranteed that the
+#    RTC in the system implements this event, or even that the system
+#    has an RTC at all.
 #
 # Since: 0.13
 #
diff --git a/qapi/net.json b/qapi/net.json
index dc616d010f0..4ac7fdc7e6c 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -22,9 +22,9 @@
 #
 # Since: 0.14
 #
-# Notes: Not all network adapters support setting link status.  This
-#     command will succeed even if the network adapter does not
-#     support link status notification.
+# .. note:: Not all network adapters support setting link status.  This
+#    command will succeed even if the network adapter does not support
+#    link status notification.
 #
 # Example:
 #
diff --git a/qapi/pci.json b/qapi/pci.json
index 08bf6958634..f51159a2c4c 100644
--- a/qapi/pci.json
+++ b/qapi/pci.json
@@ -146,8 +146,8 @@
 #
 # @regions: a list of the PCI I/O regions associated with the device
 #
-# Notes: the contents of @class_info.desc are not stable and should
-#     only be treated as informational.
+# .. note:: The contents of @class_info.desc are not stable and should
+#    only be treated as informational.
 #
 # Since: 0.14
 ##
@@ -311,7 +311,8 @@
 #           ]
 #        }
 #
-# Note: This example has been shortened as the real response is too
+#     Note: This example has been shortened as the real response is too
 #     long.
+#
 ##
 { 'command': 'query-pci', 'returns': ['PciInfo'] }
diff --git a/qapi/qdev.json b/qapi/qdev.json
index facaa0bc6a2..d031fc3590d 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -20,9 +20,9 @@
 # Returns: a list of ObjectPropertyInfo describing a devices
 #     properties
 #
-# Note: objects can create properties at runtime, for example to
-#     describe links between different devices and/or objects.  These
-#     properties are not included in the output of this command.
+# .. note:: Objects can create properties at runtime, for example to
+#    describe links between different devices and/or objects.  These
+#    properties are not included in the output of this command.
 #
 # Since: 1.2
 ##
@@ -51,7 +51,7 @@
 #     supports JSON syntax without the reference counting leak that
 #     broke hot-unplug
 #
-# Notes:
+# .. admonition:: Notes
 #
 #     1. Additional arguments depend on the type.
 #
@@ -59,8 +59,8 @@
 #        the 'docs/qdev-device-use.txt' file.
 #
 #     3. It's possible to list device properties by running QEMU with
-#        the "-device DEVICE,help" command-line argument, where DEVICE
-#        is the device's name
+#        the ``-device DEVICE,help`` command-line argument, where DEVICE
+#        is the device's name.
 #
 # Example:
 #
@@ -92,15 +92,15 @@
 # Errors:
 #     - If @id is not a valid device, DeviceNotFound
 #
-# Notes: When this command completes, the device may not be removed
-#     from the guest.  Hot removal is an operation that requires guest
-#     cooperation.  This command merely requests that the guest begin
-#     the hot removal process.  Completion of the device removal
-#     process is signaled with a DEVICE_DELETED event.  Guest reset
-#     will automatically complete removal for all devices.  If a
-#     guest-side error in the hot removal process is detected, the
-#     device will not be removed and a DEVICE_UNPLUG_GUEST_ERROR event
-#     is sent.  Some errors cannot be detected.
+# .. note:: When this command completes, the device may not be removed
+#    from the guest.  Hot removal is an operation that requires guest
+#    cooperation.  This command merely requests that the guest begin the
+#    hot removal process.  Completion of the device removal process is
+#    signaled with a DEVICE_DELETED event.  Guest reset will
+#    automatically complete removal for all devices.  If a guest-side
+#    error in the hot removal process is detected, the device will not
+#    be removed and a DEVICE_UNPLUG_GUEST_ERROR event is sent.  Some
+#    errors cannot be detected.
 #
 # Since: 0.14
 #
diff --git a/qapi/qom.json b/qapi/qom.json
index 8f0601859b1..e927f4a3c5d 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -195,12 +195,12 @@
 #
 # @typename: the type name of an object
 #
-# Note: objects can create properties at runtime, for example to
-#     describe links between different devices and/or objects.  These
-#     properties are not included in the output of this command.
-#
 # Returns: a list of ObjectPropertyInfo describing object properties
 #
+# .. note:: Objects can create properties at runtime, for example to
+#    describe links between different devices and/or objects.  These
+#    properties are not included in the output of this command.
+#
 # Since: 2.12
 ##
 { 'command': 'qom-list-properties',
@@ -608,12 +608,11 @@
 #     older to allow migration with newer QEMU versions.
 #     (default: false generally, but true for machine types <= 4.0)
 #
-# Note: prealloc=true and reserve=false cannot be set at the same
-#     time.  With reserve=true, the behavior depends on the operating
-#     system: for example, Linux will not reserve swap space for
-#     shared file mappings -- "not applicable". In contrast,
-#     reserve=false will bail out if it cannot be configured
-#     accordingly.
+# .. note:: prealloc=true and reserve=false cannot be set at the same
+#    time.  With reserve=true, the behavior depends on the operating
+#    system: for example, Linux will not reserve swap space for shared
+#    file mappings -- "not applicable". In contrast, reserve=false will
+#    bail out if it cannot be configured accordingly.
 #
 # Since: 2.1
 ##
diff --git a/qapi/rocker.json b/qapi/rocker.json
index f5225eb62cc..9f95e638309 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -138,8 +138,8 @@
 #
 # @ip-dst: IP header destination address
 #
-# Note: optional members may or may not appear in the flow key
-#     depending if they're relevant to the flow key.
+# .. note:: Optional members may or may not appear in the flow key
+#    depending if they're relevant to the flow key.
 #
 # Since: 2.4
 ##
@@ -168,8 +168,8 @@
 #
 # @ip-tos: IP header TOS field
 #
-# Note: optional members may or may not appear in the flow mask
-#     depending if they're relevant to the flow mask.
+# .. note:: Optional members may or may not appear in the flow mask
+#    depending if they're relevant to the flow mask.
 #
 # Since: 2.4
 ##
@@ -195,8 +195,8 @@
 #
 # @out-pport: physical output port
 #
-# Note: optional members may or may not appear in the flow action
-#     depending if they're relevant to the flow action.
+# .. note:: Optional members may or may not appear in the flow action
+#    depending if they're relevant to the flow action.
 #
 # Since: 2.4
 ##
@@ -288,8 +288,8 @@
 #
 # @ttl-check: perform TTL check
 #
-# Note: optional members may or may not appear in the group depending
-#     if they're relevant to the group type.
+# .. note:: Optional members may or may not appear in the group depending
+#    if they're relevant to the group type.
 #
 # Since: 2.4
 ##
diff --git a/qapi/run-state.json b/qapi/run-state.json
index f8773f23b29..252d7d6afa7 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -146,9 +146,9 @@
 # @reason: The @ShutdownCause which resulted in the SHUTDOWN.
 #     (since 4.0)
 #
-# Note: If the command-line option "-no-shutdown" has been specified,
-#     qemu will not exit, and a STOP event will eventually follow the
-#     SHUTDOWN event
+# .. note:: If the command-line option ``-no-shutdown`` has been
+#    specified, qemu will not exit, and a STOP event will eventually
+#    follow the SHUTDOWN event.
 #
 # Since: 0.12
 #
@@ -247,8 +247,8 @@
 # saved on disk, for example, S4 state, which is sometimes called
 # hibernate state
 #
-# Note: QEMU shuts down (similar to event @SHUTDOWN) when entering
-#     this state
+# .. note:: QEMU shuts down (similar to event @SHUTDOWN) when entering
+#    this state.
 #
 # Since: 1.2
 #
@@ -281,11 +281,11 @@
 #
 # @action: action that has been taken
 #
-# Note: If action is "reset", "shutdown", or "pause" the WATCHDOG
-#     event is followed respectively by the RESET, SHUTDOWN, or STOP
-#     events
+# .. note:: If action is "reset", "shutdown", or "pause" the WATCHDOG
+#    event is followed respectively by the RESET, SHUTDOWN, or STOP
+#    events.
 #
-# Note: This event is rate-limited.
+# .. note:: This event is rate-limited.
 #
 # Since: 0.13
 #
diff --git a/qapi/sockets.json b/qapi/sockets.json
index aa97c897687..f46113ab1b8 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -104,8 +104,8 @@
 #
 # @port: port
 #
-# Note: string types are used to allow for possible future hostname or
-#     service resolution support.
+# .. note:: string types are used to allow for possible future hostname
+#    or service resolution support.
 #
 # Since: 2.8
 ##
@@ -179,9 +179,9 @@
 #
 # @type: Transport type
 #
-# Note: This type is deprecated in favor of SocketAddress.  The
-#     difference between SocketAddressLegacy and SocketAddress is that
-#     the latter has fewer {} on the wire.
+# .. note:: This type is deprecated in favor of SocketAddress.  The
+#    difference between SocketAddressLegacy and SocketAddress is that
+#    the latter has fewer ``{}`` on the wire.
 #
 # Since: 1.3
 ##
diff --git a/qapi/stats.json b/qapi/stats.json
index c4a9f3ff70e..683929b2322 100644
--- a/qapi/stats.json
+++ b/qapi/stats.json
@@ -254,17 +254,17 @@
 #
 # @provider: a provider to restrict the query to.
 #
-# Note: runtime-collected statistics and their names fall outside
-#     QEMU's usual deprecation policies.  QEMU will try to keep the
-#     set of available data stable, together with their names, but
-#     will not guarantee stability at all costs; the same is true of
-#     providers that source statistics externally, e.g. from Linux.
-#     For example, if the same value is being tracked with different
-#     names on different architectures or by different providers, one
-#     of them might be renamed.  A statistic might go away if an
-#     algorithm is changed or some code is removed; changing a default
-#     might cause previously useful statistics to always report 0.
-#     Such changes, however, are expected to be rare.
+# .. note:: runtime-collected statistics and their names fall outside
+#    QEMU's usual deprecation policies.  QEMU will try to keep the set
+#    of available data stable, together with their names, but will not
+#    guarantee stability at all costs; the same is true of providers
+#    that source statistics externally, e.g. from Linux.  For example,
+#    if the same value is being tracked with different names on
+#    different architectures or by different providers, one of them
+#    might be renamed.  A statistic might go away if an algorithm is
+#    changed or some code is removed; changing a default might cause
+#    previously useful statistics to always report 0.  Such changes,
+#    however, are expected to be rare.
 #
 # Since: 7.1
 ##
diff --git a/qapi/transaction.json b/qapi/transaction.json
index 07afc269d54..bcb05fdedd6 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -237,10 +237,10 @@
 # Errors:
 #     - Any errors from commands in the transaction
 #
-# Note: The transaction aborts on the first failure.  Therefore, there
-#     will be information on only one failed operation returned in an
-#     error condition, and subsequent actions will not have been
-#     attempted.
+# .. note:: The transaction aborts on the first failure.  Therefore,
+#    there will be information on only one failed operation returned in
+#    an error condition, and subsequent actions will not have been
+#    attempted.
 #
 # Since: 1.1
 #
diff --git a/qapi/ui.json b/qapi/ui.json
index 2d0aa407aca..ec72998e28e 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -103,11 +103,10 @@
 #     - '+INT' where INT is the number of seconds from now (integer)
 #     - 'INT' where INT is the absolute time in seconds
 #
-# Notes: Time is relative to the server and currently there is no way
-#     to coordinate server time with client time.  It is not
-#     recommended to use the absolute time version of the @time
-#     parameter unless you're sure you are on the same machine as the
-#     QEMU instance.
+# .. note:: Time is relative to the server and currently there is no way
+#    to coordinate server time with client time.  It is not recommended
+#    to use the absolute time version of the @time parameter unless
+#    you're sure you are on the same machine as the QEMU instance.
 #
 # Since: 7.0
 ##
@@ -268,7 +267,7 @@
 # @unknown: No information is available about mouse mode used by the
 #     spice server.
 #
-# Note: spice/enums.h has a SpiceMouseMode already, hence the name.
+# .. note:: spice/enums.h has a SpiceMouseMode already, hence the name.
 #
 # Since: 1.1
 ##
@@ -697,9 +696,9 @@
 #
 # Since: 1.1
 #
-# Notes: An empty password in this command will set the password to
-#     the empty string.  Existing clients are unaffected by executing
-#     this command.
+# .. note:: An empty password in this command will set the password to
+#    the empty string.  Existing clients are unaffected by executing
+#    this command.
 ##
 { 'command': 'change-vnc-password',
   'data': { 'password': 'str' },
@@ -714,8 +713,8 @@
 #
 # @client: client information
 #
-# Note: This event is emitted before any authentication takes place,
-#     thus the authentication ID is not provided
+# .. note:: This event is emitted before any authentication takes place,
+#    thus the authentication ID is not provided.
 #
 # Since: 0.13
 #
@@ -1260,10 +1259,10 @@
 #
 # Since: 2.6
 #
-# Note: The consoles are visible in the qom tree, under
-#     /backend/console[$index]. They have a device link and head
-#     property, so it is possible to map which console belongs to
-#     which device and display.
+# .. note:: The consoles are visible in the qom tree, under
+#    ``/backend/console[$index]``. They have a device link and head
+#    property, so it is possible to map which console belongs to which
+#    device and display.
 #
 # Examples:
 #
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 74fc27c7029..b91f3cdd0df 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -559,12 +559,12 @@
 #
 # Returns: VirtQueueStatus of the VirtQueue
 #
-# Notes: last_avail_idx will not be displayed in the case where the
-#     selected VirtIODevice has a running vhost device and the
-#     VirtIODevice VirtQueue index (queue) does not exist for the
-#     corresponding vhost device vhost_virtqueue.  Also,
-#     shadow_avail_idx will not be displayed in the case where the
-#     selected VirtIODevice has a running vhost device.
+# .. note:: last_avail_idx will not be displayed in the case where the
+#    selected VirtIODevice has a running vhost device and the
+#    VirtIODevice VirtQueue index (queue) does not exist for the
+#    corresponding vhost device vhost_virtqueue.  Also, shadow_avail_idx
+#    will not be displayed in the case where the selected VirtIODevice
+#    has a running vhost device.
 #
 # Since: 7.2
 #
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index b3de1fb6b3a..1273d85bb5f 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -422,8 +422,9 @@
 # Returns: GuestFsfreezeStatus ("thawed", "frozen", etc., as defined
 #     below)
 #
-# Note: This may fail to properly report the current state as a result
-#     of some other guest processes having issued an fs freeze/thaw.
+# .. note:: This may fail to properly report the current state as a
+#    result of some other guest processes having issued an fs
+#    freeze/thaw.
 #
 # Since: 0.15.0
 ##
@@ -443,9 +444,9 @@
 #
 # Returns: Number of file systems currently frozen.
 #
-# Note: On Windows, the command is implemented with the help of a
-#     Volume Shadow-copy Service DLL helper.  The frozen state is
-#     limited for up to 10 seconds by VSS.
+# .. note:: On Windows, the command is implemented with the help of a
+#    Volume Shadow-copy Service DLL helper.  The frozen state is limited
+#    for up to 10 seconds by VSS.
 #
 # Since: 0.15.0
 ##
@@ -479,10 +480,10 @@
 #
 # Returns: Number of file systems thawed by this call
 #
-# Note: if return value does not match the previous call to
-#     guest-fsfreeze-freeze, this likely means some freezable
-#     filesystems were unfrozen before this call, and that the
-#     filesystem state may have changed before issuing this command.
+# .. note:: If the return value does not match the previous call to
+#    guest-fsfreeze-freeze, this likely means some freezable filesystems
+#    were unfrozen before this call, and that the filesystem state may
+#    have changed before issuing this command.
 #
 # Since: 0.15.0
 ##
@@ -560,8 +561,8 @@
 # Errors:
 #     - If suspend to disk is not supported, Unsupported
 #
-# Notes: It's strongly recommended to issue the guest-sync command
-#     before sending commands when the guest resumes
+# .. note:: It's strongly recommended to issue the guest-sync command
+#    before sending commands when the guest resumes.
 #
 # Since: 1.1
 ##
@@ -596,8 +597,8 @@
 # Errors:
 #     - If suspend to ram is not supported, Unsupported
 #
-# Notes: It's strongly recommended to issue the guest-sync command
-#     before sending commands when the guest resumes
+# .. note:: It's strongly recommended to issue the guest-sync command
+#    before sending commands when the guest resumes.
 #
 # Since: 1.1
 ##
@@ -631,8 +632,8 @@
 # Errors:
 #     - If hybrid suspend is not supported, Unsupported
 #
-# Notes: It's strongly recommended to issue the guest-sync command
-#     before sending commands when the guest resumes
+# .. note:: It's strongly recommended to issue the guest-sync command
+#    before sending commands when the guest resumes.
 #
 # Since: 1.1
 ##
@@ -1461,16 +1462,15 @@
 #     * POSIX: as defined by os-release(5)
 #     * Windows: contains string "server" or "client"
 #
-# Notes: On POSIX systems the fields @id, @name, @pretty-name,
-#     @version, @version-id, @variant and @variant-id follow the
-#     definition specified in os-release(5). Refer to the manual page
-#     for exact description of the fields.  Their values are taken
-#     from the os-release file.  If the file is not present in the
-#     system, or the values are not present in the file, the fields
-#     are not included.
+# .. note:: On POSIX systems the fields @id, @name, @pretty-name,
+#    @version, @version-id, @variant and @variant-id follow the
+#    definition specified in os-release(5). Refer to the manual page for
+#    exact description of the fields.  Their values are taken from the
+#    os-release file.  If the file is not present in the system, or the
+#    values are not present in the file, the fields are not included.
 #
-#     On Windows the values are filled from information gathered from
-#     the system.
+#    On Windows the values are filled from information gathered from
+#    the system.
 #
 # Since: 2.10
 ##
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 3cd8e7ee295..8b1da96124e 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -557,6 +557,15 @@ def get_doc(self) -> 'QAPIDoc':
                         r'(Returns|Errors|Since|Notes?|Examples?|TODO): *',
                         line):
                     # tagged section
+
+                    if 'Note' in match.group(1):
+                        emsg = (
+                            f"The '{match.group(1)}' section is deprecated."
+                            " Please use rST's '.. note::' directive or "
+                            "another suitable admonition instead."
+                        )
+                        raise QAPIParseError(self, emsg)
+
                     doc.new_tagged_section(self.info, match.group(1))
                     text = line[match.end():]
                     if text:
diff --git a/tests/qapi-schema/doc-empty-section.err b/tests/qapi-schema/doc-empty-section.err
index 5f03a6d733f..711a0d629c2 100644
--- a/tests/qapi-schema/doc-empty-section.err
+++ b/tests/qapi-schema/doc-empty-section.err
@@ -1 +1 @@
-doc-empty-section.json:6: text required after 'Note:'
+doc-empty-section.json:6: text required after 'Errors:'
diff --git a/tests/qapi-schema/doc-empty-section.json b/tests/qapi-schema/doc-empty-section.json
index f3384e9a3bb..f179d3eff6d 100644
--- a/tests/qapi-schema/doc-empty-section.json
+++ b/tests/qapi-schema/doc-empty-section.json
@@ -3,6 +3,6 @@
 ##
 # @foo:
 #
-# Note:
+# Errors:
 ##
 { 'command': 'foo', 'data': {'a': 'int'} }
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index de38a386e8f..0a294eb324e 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -29,7 +29,7 @@
 # - Second list
 #   Note: still in list
 #
-# Note: not in list
+# .. note:: not in list
 #
 # 1. Third list
 #    is numbered
@@ -155,7 +155,7 @@
 # @cmd-feat1: a feature
 # @cmd-feat2: another feature
 #
-# Note: @arg3 is undocumented
+# .. note:: @arg3 is undocumented
 #
 # Returns: @Object
 #
@@ -163,7 +163,7 @@
 #
 # TODO: frobnicate
 #
-# Notes:
+# .. admonition:: Notes
 #
 #  - Lorem ipsum dolor sit amet
 #  - Ut enim ad minim veniam
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 435f6e6d768..2c9b4e419cb 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -76,7 +76,7 @@ Not in list
 - Second list
   Note: still in list
 
-Note: not in list
+.. note:: not in list
 
 1. Third list
    is numbered
@@ -169,15 +169,17 @@ description starts on the same line
 a feature
     feature=cmd-feat2
 another feature
-    section=Note
-@arg3 is undocumented
+    section=None
+.. note:: @arg3 is undocumented
     section=Returns
 @Object
     section=Errors
 some
     section=TODO
 frobnicate
-    section=Notes
+    section=None
+.. admonition:: Notes
+
  - Lorem ipsum dolor sit amet
  - Ut enim ad minim veniam
 
diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-good.txt
index 847db70412d..b89f35d5476 100644
--- a/tests/qapi-schema/doc-good.txt
+++ b/tests/qapi-schema/doc-good.txt
@@ -17,7 +17,9 @@ Not in list
 
 * Second list Note: still in list
 
-Note: not in list
+Note:
+
+  not in list
 
 1. Third list is numbered
 
@@ -193,11 +195,9 @@ Features
 "cmd-feat2"
    another feature
 
+Note:
 
-Note
-~~~~
-
-"arg3" is undocumented
+  "arg3" is undocumented
 
 
 Returns
@@ -211,9 +211,7 @@ Errors
 
 some
 
-
-Notes
-~~~~~
+Notes:
 
 * Lorem ipsum dolor sit amet
 
diff --git a/tests/qapi-schema/doc-interleaved-section.json b/tests/qapi-schema/doc-interleaved-section.json
index adb29e98daa..b26bc0bbb79 100644
--- a/tests/qapi-schema/doc-interleaved-section.json
+++ b/tests/qapi-schema/doc-interleaved-section.json
@@ -10,7 +10,7 @@
 #
 #           bao
 #
-# Note: a section.
+# Returns: a section.
 #
 # @foobar: catch this
 #
-- 
2.44.0


