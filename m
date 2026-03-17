Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0D6F3381B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QER-0007Wl-SL; Tue, 17 Mar 2026 04:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QEC-0006BP-Es
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:56:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QE7-0007ez-Cm
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3l3C1tEgo77Ten/mjQR6d+HqscWllu9vCjIvByM508o=;
 b=f+blf3RLSHgc+WLcmE7rpd36IfUcTzkcgxbETwWuKsgSwpQ3dKx6TLO2Klza1qKnHMLShx
 arKJg3hbJU1yliNethu/6iQnt43ihZGvz0uLe3C/ITCoqf+KmpVotb87uph1jpPUzc1XDv
 ZVWYj8PmaJSqaXe1RsqgC6fqiidvc9M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-UiK8-b3dN8KVSMqfQyaOMg-1; Tue,
 17 Mar 2026 04:56:30 -0400
X-MC-Unique: UiK8-b3dN8KVSMqfQyaOMg-1
X-Mimecast-MFC-AGG-ID: UiK8-b3dN8KVSMqfQyaOMg_1773737790
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 334C4180034F
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:56:30 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D640319560B1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:56:25 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:51:14 +0400
Subject: [PATCH 60/60] contrib/qemu-vnc: add standalone VNC server over D-Bus
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-60-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=134626;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=XMRH7spYzRBGiKv6CM6bjUsEdtSifEorusj63sB3jpE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXdELdehFcHOFxFKaY4U90+Pa0Gc+ji+1E6N
 i6RHk7ugSyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV3QAKCRDa6OEJdZac
 5UFXD/4sCBomQVITnV5N2KQ9sn4RP1wJbed8xlrQaYc+75wXjnTPv0fYdq7zMTUyKV5BjjwQo2w
 P8r2ofw1O0xvnFNjMr2huFOznal0hngu+6yL2be2GntF61/cG305UAWXfPPcgPgumiTnsZ+T6lR
 y6jsYzTSbzdQFF5hs9Eu0Ik884yXWwmx0Qvc7Gq3PRBhntbq8HRJkY3hT6z49/MAsIp2uM2ogar
 F6srllKGzZSmOG6NxFJ8tlT3hCvpLJKqs5Vo0fkIebEoeiWERmhEk4tZqOM+JWUTpskdV8BSLfk
 7oxqKQ/qZ+BZuJL589amWE91YcRiP+6wx5db/+MiaY0eKUqgU5ZV0m18YgQRkzQK2Gxw5kJVwBT
 P8TTSSImJ33sxPhoztlqZp4LrNKdfwVHR6cEZJX83HfSq6EmQFqt9IXR/NQWzzKoC+kc3CraTJC
 4bhRtKd7HTnOBO/m088WSBxKmJX+fNkqzMsyyFIN2xqeWu3TQuZ2LQ0vuGoeiX8k7BeJqo87UmU
 Olwa9EckVaQ24hE0GaXlpjV1GTdh8QIOZw12z+Vq4/SLADS8A7j+ZSA5ARvU9ictidwlphWMGV5
 NX+8vLfk5JO1j0UQTe0akchiupsWScLxKyQILnHpdAB+TztrtYR7K+jZSUnLtejCjL5b+jkPicW
 ZdFtOouisVMCm4w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add a standalone VNC server binary that connects to a running QEMU
instance via the D-Bus display interface (org.qemu.Display1, via the bus
or directly p2p). This allows serving a VNC display without compiling
VNC support directly into the QEMU system emulator, and enables running
the VNC server as a separate process with independent lifecycle and
privilege domain.

Built only when both VNC and D-Bus display support are enabled.
If we wanted to have qemu -vnc disabled, and qemu-vnc built, we would
need to split CONFIG_VNC. This is left as a future exercise.

I left out for now:
 - sasl & tls authz
 - some runtime functionalities (better done by restarting)
 - a few legacy options
 - Windows support

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 MAINTAINERS                    |   5 +
 docs/conf.py                   |   3 +
 docs/interop/dbus-display.rst  |   2 +
 docs/interop/dbus-vnc.rst      |  26 ++
 docs/interop/index.rst         |   1 +
 docs/meson.build               |   1 +
 docs/tools/index.rst           |   1 +
 docs/tools/qemu-vnc.rst        | 199 +++++++++++
 meson.build                    |  17 +
 contrib/qemu-vnc/qemu-vnc.h    |  46 +++
 contrib/qemu-vnc/trace.h       |   4 +
 contrib/qemu-vnc/audio.c       | 307 +++++++++++++++++
 contrib/qemu-vnc/chardev.c     | 127 +++++++
 contrib/qemu-vnc/clipboard.c   | 378 +++++++++++++++++++++
 contrib/qemu-vnc/console.c     | 168 ++++++++++
 contrib/qemu-vnc/dbus.c        | 439 ++++++++++++++++++++++++
 contrib/qemu-vnc/display.c     | 456 +++++++++++++++++++++++++
 contrib/qemu-vnc/input.c       | 239 ++++++++++++++
 contrib/qemu-vnc/qemu-vnc.c    | 450 +++++++++++++++++++++++++
 contrib/qemu-vnc/stubs.c       |  66 ++++
 contrib/qemu-vnc/utils.c       |  59 ++++
 tests/qtest/dbus-vnc-test.c    | 733 +++++++++++++++++++++++++++++++++++++++++
 contrib/qemu-vnc/meson.build   |  26 ++
 contrib/qemu-vnc/qemu-vnc1.xml | 174 ++++++++++
 contrib/qemu-vnc/trace-events  |  20 ++
 meson_options.txt              |   2 +
 scripts/meson-buildoptions.sh  |   3 +
 tests/dbus-daemon.sh           |  14 +-
 tests/qtest/meson.build        |   8 +
 29 files changed, 3971 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97f2759138d..aa2d87dca82 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2823,6 +2823,11 @@ F: docs/interop/vhost-user-gpu.rst
 F: contrib/vhost-user-gpu
 F: hw/display/vhost-user-*
 
+qemu-vnc:
+M: Marc-André Lureau <marcandre.lureau@redhat.com>
+S: Maintained
+F: contrib/qemu-vnc
+
 Cirrus VGA
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Odd Fixes
diff --git a/docs/conf.py b/docs/conf.py
index f835904ba1e..7e35d2158d3 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -333,6 +333,9 @@
     ('tools/qemu-trace-stap', 'qemu-trace-stap',
      'QEMU SystemTap trace tool',
      [], 1),
+    ('tools/qemu-vnc', 'qemu-vnc',
+     'QEMU standalone VNC server',
+     [], 1),
 ]
 man_make_section_directory = False
 
diff --git a/docs/interop/dbus-display.rst b/docs/interop/dbus-display.rst
index 8c6e8e0f5a8..87648e91dc0 100644
--- a/docs/interop/dbus-display.rst
+++ b/docs/interop/dbus-display.rst
@@ -1,3 +1,5 @@
+.. _dbus-display:
+
 D-Bus display
 =============
 
diff --git a/docs/interop/dbus-vnc.rst b/docs/interop/dbus-vnc.rst
new file mode 100644
index 00000000000..88b1c4ea50f
--- /dev/null
+++ b/docs/interop/dbus-vnc.rst
@@ -0,0 +1,26 @@
+D-Bus VNC
+=========
+
+The ``qemu-vnc`` standalone VNC server exposes a D-Bus interface for management
+and monitoring of VNC connections.
+
+The service is available on the bus under the well-known name ``org.qemu.vnc``.
+Objects are exported under ``/org/qemu/Vnc1/``.
+
+.. contents::
+   :local:
+   :depth: 1
+
+.. only:: sphinx4
+
+   .. dbus-doc:: contrib/qemu-vnc/qemu-vnc1.xml
+
+.. only:: not sphinx4
+
+   .. warning::
+      Sphinx 4 is required to build D-Bus documentation.
+
+      This is the content of ``contrib/qemu-vnc/qemu-vnc1.xml``:
+
+   .. literalinclude:: ../../contrib/qemu-vnc/qemu-vnc1.xml
+      :language: xml
diff --git a/docs/interop/index.rst b/docs/interop/index.rst
index d830c5c4104..2cf3a8c9aa3 100644
--- a/docs/interop/index.rst
+++ b/docs/interop/index.rst
@@ -13,6 +13,7 @@ are useful for making QEMU interoperate with other software.
    dbus
    dbus-vmstate
    dbus-display
+   dbus-vnc
    live-block-operations
    nbd
    parallels
diff --git a/docs/meson.build b/docs/meson.build
index 7e54b01e6a0..c3e9fb05846 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -54,6 +54,7 @@ if build_docs
         'qemu-pr-helper.8': (have_tools ? 'man8' : ''),
         'qemu-storage-daemon.1': (have_tools ? 'man1' : ''),
         'qemu-trace-stap.1': (stap.found() ? 'man1' : ''),
+        'qemu-vnc.1': (have_qemu_vnc ? 'man1' : ''),
         'qemu.1': 'man1',
         'qemu-block-drivers.7': 'man7',
         'qemu-cpu-models.7': 'man7'
diff --git a/docs/tools/index.rst b/docs/tools/index.rst
index 1e88ae48cdc..868c3c4d9d8 100644
--- a/docs/tools/index.rst
+++ b/docs/tools/index.rst
@@ -16,3 +16,4 @@ command line utilities and other standalone programs.
    qemu-pr-helper
    qemu-trace-stap
    qemu-vmsr-helper
+   qemu-vnc
diff --git a/docs/tools/qemu-vnc.rst b/docs/tools/qemu-vnc.rst
new file mode 100644
index 00000000000..d7207cc49e5
--- /dev/null
+++ b/docs/tools/qemu-vnc.rst
@@ -0,0 +1,199 @@
+=============================
+QEMU standalone VNC server
+=============================
+
+Synopsis
+--------
+
+**qemu-vnc** [*OPTION*]
+
+Description
+-----------
+
+``qemu-vnc`` is a standalone VNC server that connects to a running QEMU
+instance via the D-Bus display interface
+(:ref:`dbus-display`).  It re-exports the
+guest display, keyboard, mouse, audio, clipboard, and serial console
+chardevs over the VNC protocol, allowing VNC clients to interact with
+the virtual machine without QEMU itself binding a VNC socket.
+
+The server connects to a QEMU instance that has been started with
+``-display dbus`` and registers as a D-Bus display listener.
+
+The following features are supported:
+
+* Graphical console display (scanout and incremental updates)
+* Shared-memory scanout via Unix file-descriptor passing
+* Hardware cursor
+* Keyboard input (translated to QEMU key codes)
+* Absolute and relative mouse input
+* Mouse button events
+* Audio playback forwarding to VNC clients
+* Clipboard sharing (text) between guest and VNC client
+* Serial console chardevs exposed as VNC text consoles
+* TLS encryption (x509 credentials)
+* VNC password authentication (``--password`` flag or systemd credentials)
+* Lossy (JPEG) compression
+* WebSocket transport
+
+Options
+-------
+
+.. program:: qemu-vnc
+
+.. option:: -a ADDRESS, --dbus-address=ADDRESS
+
+  D-Bus address to connect to.  When not specified, ``qemu-vnc``
+  connects to the session bus.
+
+.. option:: -p FD, --dbus-p2p-fd=FD
+
+  File descriptor of an inherited Unix socket for a peer-to-peer D-Bus
+  connection to QEMU.  This is mutually exclusive with
+  ``--dbus-address`` and ``--bus-name``.
+
+.. option:: -n NAME, --bus-name=NAME
+
+  D-Bus bus name of the QEMU instance to connect to.  The default is
+  ``org.qemu``.  When a custom ``--dbus-address`` is given without a
+  bus name, peer-to-peer D-Bus is used.
+
+.. option:: -c N, --console=N
+
+  Console number to attach to (default 0).
+
+.. option:: -l ADDR, --vnc-addr=ADDR
+
+  VNC listen address in the same format as the QEMU ``-vnc`` option
+  (default ``localhost:0``, i.e. TCP port 5900).
+
+.. option:: -w ADDR, --websocket=ADDR
+
+  Enable WebSocket transport on the given address.  *ADDR* can be a
+  port number or an *address:port* pair.
+
+.. option:: -t DIR, --tls-creds=DIR
+
+  Directory containing TLS x509 credentials (``ca-cert.pem``,
+  ``server-cert.pem``, ``server-key.pem``).  When specified, the VNC
+  server requires TLS from connecting clients.
+
+.. option:: -s POLICY, --share=POLICY
+
+  Set display sharing policy.  *POLICY* is one of
+  ``allow-exclusive``, ``force-shared``, or ``ignore``.
+
+  ``allow-exclusive`` allows clients to ask for exclusive access.
+  As suggested by the RFB spec this is implemented by dropping other
+  connections.  Connecting multiple clients in parallel requires all
+  clients asking for a shared session (vncviewer: -shared switch).
+  This is the default.
+
+  ``force-shared`` disables exclusive client access.  Useful for
+  shared desktop sessions, where you don't want someone forgetting to
+  specify -shared disconnect everybody else.
+
+  ``ignore`` completely ignores the shared flag and allows everybody
+  to connect unconditionally.  Doesn't conform to the RFB spec but
+  is traditional QEMU behavior.
+
+.. option:: -k LAYOUT, --keyboard-layout=LAYOUT
+
+  Keyboard layout (e.g. ``en-us``).  Passed through to the VNC server
+  for key-code translation.
+
+.. option:: -C NAME, --vt-chardev=NAME
+
+  Chardev D-Bus name to expose as a VNC text console.  This option may
+  be given multiple times to expose several chardevs.  When not
+  specified, the defaults ``org.qemu.console.serial.0`` and
+  ``org.qemu.monitor.hmp.0`` are used.
+
+.. option:: -N, --no-vt
+
+  Do not expose any chardevs as text consoles.  This overrides the
+  default chardev list and any ``--vt-chardev`` options.
+
+.. option:: -T PATTERN, --trace=PATTERN
+
+  Trace options, same syntax as the QEMU ``-trace`` option.
+
+.. option:: --password
+
+  Require VNC password authentication from connecting clients.  The
+  password is set at runtime via the D-Bus ``SetPassword`` method (see
+  :doc:`/interop/dbus-vnc`).  Clients will not be able to connect
+  until a password has been set.
+
+  This option is ignored when a systemd credential password is
+  present, since password authentication is already enabled via
+  ``password-secret`` in that case.
+
+.. option:: --lossy
+
+  Enable  lossy  compression methods (gradient, JPEG, ...). If this option
+  is set, VNC client may receive lossy framebuffer updates depending on its
+  encoding settings. Enabling this option can save a lot of bandwidth at
+  the expense of quality.
+
+.. option:: --non-adaptive
+
+  Disable adaptive encodings. Adaptive encodings are enabled by default.
+  An adaptive encoding will try to detect frequently updated screen regions,
+  and send updates in these  regions  using  a lossy encoding (like JPEG).
+  This can be really helpful to save bandwidth when playing videos.
+  Disabling adaptive encodings restores the original static behavior of
+  encodings like Tight.
+
+.. option:: -V, --version
+
+  Print version information and exit.
+
+Examples
+--------
+
+Start QEMU with the D-Bus display backend::
+
+    qemu-system-x86_64 -display dbus -drive file=disk.qcow2
+
+Then attach ``qemu-vnc``::
+
+    qemu-vnc
+
+A VNC client can now connect to ``localhost:5900``.
+
+To listen on a different port with TLS::
+
+    qemu-vnc --vnc-addr localhost:1 --tls-creds /etc/pki/qemu-vnc
+
+To connect to a specific D-Bus address (peer-to-peer)::
+
+    qemu-vnc --dbus-address unix:path=/tmp/qemu-dbus.sock
+
+VNC Password Authentication
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+There are two ways to enable VNC password authentication:
+
+1. **``--password`` flag** — start ``qemu-vnc`` with ``--password`` and
+   then set the password at runtime using the D-Bus ``SetPassword``
+   method.  Clients will be rejected until a password is set.
+
+2. **systemd credentials** — if the ``CREDENTIALS_DIRECTORY``
+   environment variable is set (see :manpage:`systemd.exec(5)`) and
+   contains a file named ``vnc-password``, the VNC server will use
+   that file's contents as the password automatically.  The
+   ``--password`` flag is not needed in this case.
+
+D-Bus interface
+---------------
+
+``qemu-vnc`` exposes a D-Bus interface for management and monitoring of
+VNC connections.  See :doc:`/interop/dbus-vnc` for the full interface
+reference.
+
+See also
+--------
+
+:manpage:`qemu(1)`,
+`The RFB Protocol <https://github.com/rfbproto/rfbproto>`_
diff --git a/meson.build b/meson.build
index b2154bb9287..e0f2d5d0b87 100644
--- a/meson.build
+++ b/meson.build
@@ -2329,6 +2329,17 @@ dbus_display = get_option('dbus_display') \
            error_message: gdbus_codegen_error.format('-display dbus')) \
   .allowed()
 
+have_qemu_vnc = get_option('qemu_vnc') \
+  .require(have_tools,
+           error_message: 'qemu-vnc requires tools support') \
+  .require(dbus_display,
+           error_message: 'qemu-vnc requires dbus-display support') \
+  .require(vnc.found(),
+           error_message: 'qemu-vnc requires vnc support') \
+  .require(host_os != 'windows',
+           error_message: 'qemu-vnc is not currently supported on Windows') \
+  .allowed()
+
 have_virtfs = get_option('virtfs') \
     .require(host_os == 'linux' or host_os == 'darwin' or host_os == 'freebsd',
              error_message: 'virtio-9p (virtfs) requires Linux or macOS or FreeBSD') \
@@ -3583,6 +3594,7 @@ trace_events_subdirs = [
   'monitor',
   'util',
   'gdbstub',
+  'contrib/qemu-vnc',
 ]
 if have_linux_user
   trace_events_subdirs += [ 'linux-user' ]
@@ -4550,6 +4562,10 @@ if have_tools
     subdir('contrib/ivshmem-client')
     subdir('contrib/ivshmem-server')
   endif
+
+  if have_qemu_vnc
+    subdir('contrib/qemu-vnc')
+  endif
 endif
 
 if stap.found()
@@ -4885,6 +4901,7 @@ if vnc.found()
   summary_info += {'VNC SASL support':  sasl}
   summary_info += {'VNC JPEG support':  jpeg}
 endif
+summary_info += {'VNC D-Bus server (qemu-vnc)': have_qemu_vnc}
 summary_info += {'spice protocol support': spice_protocol}
 if spice_protocol.found()
   summary_info += {'  spice server support': spice}
diff --git a/contrib/qemu-vnc/qemu-vnc.h b/contrib/qemu-vnc/qemu-vnc.h
new file mode 100644
index 00000000000..420d5f66d42
--- /dev/null
+++ b/contrib/qemu-vnc/qemu-vnc.h
@@ -0,0 +1,46 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef CONTRIB_QEMU_VNC_H
+#define CONTRIB_QEMU_VNC_H
+
+#include "qemu/osdep.h"
+
+#include <gio/gunixfdlist.h>
+#include "qemu/dbus.h"
+#include "ui/console.h"
+#include "ui/dbus-display1.h"
+
+#define TEXT_COLS 80
+#define TEXT_ROWS 24
+#define TEXT_FONT_WIDTH  8
+#define TEXT_FONT_HEIGHT 16
+
+
+QemuTextConsole *qemu_vnc_text_console_new(const char *name,
+                                           int fd, bool echo);
+
+void input_setup(QemuDBusDisplay1Keyboard *kbd,
+                 QemuDBusDisplay1Mouse *mouse);
+bool console_setup(GDBusConnection *bus, const char *bus_name,
+                   const char *console_path);
+QemuDBusDisplay1Keyboard *console_get_keyboard(QemuConsole *con);
+QemuDBusDisplay1Mouse *console_get_mouse(QemuConsole *con);
+
+void audio_setup(GDBusObjectManager *manager);
+void clipboard_setup(GDBusObjectManager *manager, GDBusConnection *bus);
+void chardev_setup(const char * const *chardev_names,
+                   GDBusObjectManager *manager);
+
+GThread *p2p_dbus_thread_new(int fd);
+
+void vnc_dbus_setup(GDBusConnection *bus);
+void vnc_dbus_cleanup(void);
+void vnc_dbus_client_connected(const char *host, const char *service,
+                               const char *family, bool websocket);
+void vnc_dbus_client_initialized(const char *host, const char *service,
+                                 const char *x509_dname,
+                                 const char *sasl_username);
+void vnc_dbus_client_disconnected(const char *host, const char *service);
+
+#endif /* CONTRIB_QEMU_VNC_H */
diff --git a/contrib/qemu-vnc/trace.h b/contrib/qemu-vnc/trace.h
new file mode 100644
index 00000000000..8c0bfa963ed
--- /dev/null
+++ b/contrib/qemu-vnc/trace.h
@@ -0,0 +1,4 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "trace/trace-contrib_qemu_vnc.h"
diff --git a/contrib/qemu-vnc/audio.c b/contrib/qemu-vnc/audio.c
new file mode 100644
index 00000000000..b55b04bc92a
--- /dev/null
+++ b/contrib/qemu-vnc/audio.c
@@ -0,0 +1,307 @@
+/*
+ * Standalone VNC server connecting to QEMU via D-Bus display interface.
+ * Audio support. Only one audio stream is tracked. Mixing/resampling could be added.
+ *
+ * Copyright (C) 2026 Red Hat, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu/audio.h"
+#include "qemu/audio-capture.h"
+#include "qemu/sockets.h"
+#include "qemu/error-report.h"
+#include "ui/dbus-display1.h"
+#include "trace.h"
+#include "qemu-vnc.h"
+
+struct CaptureVoiceOut {
+    struct audsettings as;
+    struct audio_capture_ops ops;
+    void *opaque;
+    QLIST_ENTRY(CaptureVoiceOut) entries;
+};
+
+typedef struct AudioOut {
+    guint64 id;
+    struct audsettings as;
+} AudioOut;
+
+static QLIST_HEAD(, CaptureVoiceOut) capture_list =
+    QLIST_HEAD_INITIALIZER(capture_list);
+static GDBusConnection *audio_listener_conn;
+static AudioOut audio_out;
+
+static bool audsettings_eq(const struct audsettings *a,
+                           const struct audsettings *b)
+{
+    return a->freq == b->freq &&
+           a->nchannels == b->nchannels &&
+           a->fmt == b->fmt &&
+           a->big_endian == b->big_endian;
+}
+
+static gboolean
+on_audio_out_init(QemuDBusDisplay1AudioOutListener *listener,
+                  GDBusMethodInvocation *invocation,
+                  guint64 id, guchar bits, gboolean is_signed,
+                  gboolean is_float, guint freq, guchar nchannels,
+                  guint bytes_per_frame, guint bytes_per_second,
+                  gboolean be, gpointer user_data)
+{
+    AudioFormat fmt;
+
+    switch (bits) {
+    case 8:
+        fmt = is_signed ? AUDIO_FORMAT_S8 : AUDIO_FORMAT_U8;
+        break;
+    case 16:
+        fmt = is_signed ? AUDIO_FORMAT_S16 : AUDIO_FORMAT_U16;
+        break;
+    case 32:
+        fmt = is_float ? AUDIO_FORMAT_F32 :
+              is_signed ? AUDIO_FORMAT_S32 : AUDIO_FORMAT_U32;
+        break;
+    default:
+        g_return_val_if_reached(DBUS_METHOD_INVOCATION_HANDLED);
+    }
+
+    struct audsettings as = {
+        .freq = freq,
+        .nchannels = nchannels,
+        .fmt = fmt,
+        .big_endian = be,
+    };
+    audio_out = (AudioOut) {
+        .id = id,
+        .as = as,
+    };
+
+    trace_qemu_vnc_audio_out_init(id, freq, nchannels, bits);
+
+    qemu_dbus_display1_audio_out_listener_complete_init(
+        listener, invocation);
+    return DBUS_METHOD_INVOCATION_HANDLED;
+}
+
+static gboolean
+on_audio_out_fini(QemuDBusDisplay1AudioOutListener *listener,
+                  GDBusMethodInvocation *invocation,
+                  guint64 id, gpointer user_data)
+{
+    trace_qemu_vnc_audio_out_fini(id);
+
+    qemu_dbus_display1_audio_out_listener_complete_fini(
+        listener, invocation);
+    return DBUS_METHOD_INVOCATION_HANDLED;
+}
+
+static gboolean
+on_audio_out_set_enabled(QemuDBusDisplay1AudioOutListener *listener,
+                         GDBusMethodInvocation *invocation,
+                         guint64 id, gboolean enabled,
+                         gpointer user_data)
+{
+    CaptureVoiceOut *cap;
+
+    trace_qemu_vnc_audio_out_set_enabled(id, enabled);
+
+    if (id == audio_out.id) {
+        QLIST_FOREACH(cap, &capture_list, entries) {
+            cap->ops.notify(cap->opaque,
+                            enabled ? AUD_CNOTIFY_ENABLE
+                                : AUD_CNOTIFY_DISABLE);
+        }
+    }
+
+    qemu_dbus_display1_audio_out_listener_complete_set_enabled(
+        listener, invocation);
+    return DBUS_METHOD_INVOCATION_HANDLED;
+}
+
+static gboolean
+on_audio_out_set_volume(QemuDBusDisplay1AudioOutListener *listener,
+                        GDBusMethodInvocation *invocation,
+                        guint64 id, gboolean mute,
+                        GVariant *volume, gpointer user_data)
+{
+    qemu_dbus_display1_audio_out_listener_complete_set_volume(
+        listener, invocation);
+    return DBUS_METHOD_INVOCATION_HANDLED;
+}
+
+static gboolean
+on_audio_out_write(QemuDBusDisplay1AudioOutListener *listener,
+                   GDBusMethodInvocation *invocation,
+                   guint64 id, GVariant *data,
+                   gpointer user_data)
+{
+    CaptureVoiceOut *cap;
+    gsize size;
+    const void *buf;
+
+    if (id == audio_out.id) {
+        buf = g_variant_get_fixed_array(data, &size, 1);
+
+        trace_qemu_vnc_audio_out_write(id, size);
+
+        QLIST_FOREACH(cap, &capture_list, entries) {
+            /* we don't handle audio resampling/format conversion */
+            if (audsettings_eq(&cap->as, &audio_out.as)) {
+                cap->ops.capture(cap->opaque, buf, size);
+            }
+        }
+    }
+
+    qemu_dbus_display1_audio_out_listener_complete_write(
+        listener, invocation);
+    return DBUS_METHOD_INVOCATION_HANDLED;
+}
+
+CaptureVoiceOut *audio_be_add_capture(
+    AudioBackend *be,
+    const struct audsettings *as,
+    const struct audio_capture_ops *ops,
+    void *opaque)
+{
+    CaptureVoiceOut *cap;
+
+    if (!audio_listener_conn) {
+        return NULL;
+    }
+
+    cap = g_new0(CaptureVoiceOut, 1);
+    cap->ops = *ops;
+    cap->opaque = opaque;
+    cap->as = *as;
+    QLIST_INSERT_HEAD(&capture_list, cap, entries);
+
+    return cap;
+}
+
+void audio_be_del_capture(
+    AudioBackend *be,
+    CaptureVoiceOut *cap,
+    void *cb_opaque)
+{
+    if (!cap) {
+        return;
+    }
+
+    cap->ops.destroy(cap->opaque);
+    QLIST_REMOVE(cap, entries);
+    g_free(cap);
+}
+
+/*
+ * Dummy audio backend — the VNC server only needs a non-NULL pointer
+ * so that audio capture registration doesn't bail out.  The pointer
+ * is never dereferenced by our code (audio_be_add_capture ignores it).
+ */
+static AudioBackend dummy_audio_be;
+
+AudioBackend *audio_get_default_audio_be(Error **errp)
+{
+    return &dummy_audio_be;
+}
+
+AudioBackend *audio_be_by_name(const char *name, Error **errp)
+{
+    return NULL;
+}
+
+static void
+on_register_audio_listener_finished(GObject *source_object,
+                                    GAsyncResult *res,
+                                    gpointer user_data)
+{
+    GThread *thread = user_data;
+    g_autoptr(GError) err = NULL;
+    g_autoptr(GDBusObjectSkeleton) obj = NULL;
+    GDBusObjectManagerServer *server;
+    QemuDBusDisplay1AudioOutListener *audio_skel;
+
+    qemu_dbus_display1_audio_call_register_out_listener_finish(
+        QEMU_DBUS_DISPLAY1_AUDIO(source_object),
+        NULL, res, &err);
+
+    if (err) {
+        error_report("RegisterOutListener failed: %s", err->message);
+        g_thread_join(thread);
+        return;
+    }
+
+    audio_listener_conn = g_thread_join(thread);
+    if (!audio_listener_conn) {
+        return;
+    }
+
+    server = g_dbus_object_manager_server_new(DBUS_DISPLAY1_ROOT);
+    obj = g_dbus_object_skeleton_new(
+        DBUS_DISPLAY1_ROOT "/AudioOutListener");
+
+    audio_skel = qemu_dbus_display1_audio_out_listener_skeleton_new();
+    g_object_connect(audio_skel,
+                     "signal::handle-init",
+                     on_audio_out_init, NULL,
+                     "signal::handle-fini",
+                     on_audio_out_fini, NULL,
+                     "signal::handle-set-enabled",
+                     on_audio_out_set_enabled, NULL,
+                     "signal::handle-set-volume",
+                     on_audio_out_set_volume, NULL,
+                     "signal::handle-write",
+                     on_audio_out_write, NULL,
+                     NULL);
+    g_dbus_object_skeleton_add_interface(
+        obj, G_DBUS_INTERFACE_SKELETON(audio_skel));
+
+    g_dbus_object_manager_server_export(server, obj);
+    g_dbus_object_manager_server_set_connection(
+        server, audio_listener_conn);
+
+    g_dbus_connection_start_message_processing(audio_listener_conn);
+}
+
+void audio_setup(GDBusObjectManager *manager)
+{
+    g_autoptr(GError) err = NULL;
+    g_autoptr(GUnixFDList) fd_list = NULL;
+    g_autoptr(GDBusInterface) iface = NULL;
+    GThread *thread;
+    int pair[2];
+    int idx;
+
+    iface = g_dbus_object_manager_get_interface(
+        manager, DBUS_DISPLAY1_ROOT "/Audio",
+        "org.qemu.Display1.Audio");
+    if (!iface) {
+        return;
+    }
+
+    if (qemu_socketpair(AF_UNIX, SOCK_STREAM, 0, pair) < 0) {
+        error_report("audio socketpair failed: %s", strerror(errno));
+        return;
+    }
+
+    fd_list = g_unix_fd_list_new();
+    idx = g_unix_fd_list_append(fd_list, pair[1], &err);
+    close(pair[1]);
+    if (idx < 0) {
+        close(pair[0]);
+        error_report("Failed to append fd: %s", err->message);
+        return;
+    }
+
+    thread = p2p_dbus_thread_new(pair[0]);
+
+    qemu_dbus_display1_audio_call_register_out_listener(
+        QEMU_DBUS_DISPLAY1_AUDIO(iface),
+        g_variant_new_handle(idx),
+        G_DBUS_CALL_FLAGS_NONE, -1,
+        fd_list, NULL,
+        on_register_audio_listener_finished,
+        thread);
+}
diff --git a/contrib/qemu-vnc/chardev.c b/contrib/qemu-vnc/chardev.c
new file mode 100644
index 00000000000..d9d51973724
--- /dev/null
+++ b/contrib/qemu-vnc/chardev.c
@@ -0,0 +1,127 @@
+/*
+ * Standalone VNC server connecting to QEMU via D-Bus display interface.
+ *
+ * Copyright (C) 2026 Red Hat, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu/sockets.h"
+#include "qemu/error-report.h"
+#include "ui/dbus-display1.h"
+#include "trace.h"
+#include "qemu-vnc.h"
+
+typedef struct ChardevRegisterData {
+    QemuDBusDisplay1Chardev *proxy;
+    int local_fd;
+    char *name;
+    bool echo;
+} ChardevRegisterData;
+
+static void
+on_chardev_register_finished(GObject *source_object,
+                             GAsyncResult *res,
+                             gpointer user_data)
+{
+    ChardevRegisterData *data = user_data;
+    g_autoptr(GError) err = NULL;
+    QemuTextConsole *tc;
+
+    if (!qemu_dbus_display1_chardev_call_register_finish(
+            data->proxy, NULL, res, &err)) {
+        error_report("Chardev Register failed for %s: %s",
+                     data->name, err->message);
+        close(data->local_fd);
+        goto out;
+    }
+
+    tc = qemu_vnc_text_console_new(data->name, data->local_fd, data->echo);
+    if (!tc) {
+        close(data->local_fd);
+        goto out;
+    }
+
+    trace_qemu_vnc_chardev_connected(data->name);
+
+out:
+    g_object_unref(data->proxy);
+    g_free(data->name);
+    g_free(data);
+}
+
+/* Default chardevs to expose as VNC text consoles */
+static const char * const default_names[] = {
+    "org.qemu.console.serial.0",
+    "org.qemu.monitor.hmp.0",
+    NULL,
+};
+
+/* Active chardev names list (points to CLI args or default_names) */
+static const char * const *names;
+
+static void
+chardev_register(QemuDBusDisplay1Chardev *proxy)
+{
+    g_autoptr(GUnixFDList) fd_list = NULL;
+    ChardevRegisterData *data;
+    const char *name;
+    int pair[2];
+    int idx;
+
+    name = qemu_dbus_display1_chardev_get_name(proxy);
+    if (!name || !g_strv_contains(names, name)) {
+        return;
+    }
+
+    if (qemu_socketpair(AF_UNIX, SOCK_STREAM, 0, pair) < 0) {
+        error_report("chardev socketpair failed: %s", strerror(errno));
+        return;
+    }
+
+    fd_list = g_unix_fd_list_new();
+    idx = g_unix_fd_list_append(fd_list, pair[1], NULL);
+    close(pair[1]);
+
+    data = g_new0(ChardevRegisterData, 1);
+    data->proxy = g_object_ref(proxy);
+    data->local_fd = pair[0];
+    data->name = g_strdup(name);
+    data->echo = qemu_dbus_display1_chardev_get_echo(proxy);
+
+    qemu_dbus_display1_chardev_call_register(
+        proxy, g_variant_new_handle(idx),
+        G_DBUS_CALL_FLAGS_NONE, -1,
+        fd_list, NULL,
+        on_chardev_register_finished, data);
+}
+
+void chardev_setup(const char * const *chardev_names,
+                   GDBusObjectManager *manager)
+{
+    GList *objects, *l;
+
+    names = chardev_names ? chardev_names : default_names;
+
+    objects = g_dbus_object_manager_get_objects(manager);
+    for (l = objects; l; l = l->next) {
+        GDBusObject *obj = l->data;
+        const char *path = g_dbus_object_get_object_path(obj);
+        g_autoptr(GDBusInterface) iface = NULL;
+
+        if (!g_str_has_prefix(path, DBUS_DISPLAY1_ROOT "/Chardev_")) {
+            continue;
+        }
+
+        iface = g_dbus_object_get_interface(
+            obj, "org.qemu.Display1.Chardev");
+        if (!iface) {
+            continue;
+        }
+
+        chardev_register(QEMU_DBUS_DISPLAY1_CHARDEV(iface));
+    }
+    g_list_free_full(objects, g_object_unref);
+}
diff --git a/contrib/qemu-vnc/clipboard.c b/contrib/qemu-vnc/clipboard.c
new file mode 100644
index 00000000000..d1673b97899
--- /dev/null
+++ b/contrib/qemu-vnc/clipboard.c
@@ -0,0 +1,378 @@
+/*
+ * Standalone VNC server connecting to QEMU via D-Bus display interface.
+ *
+ * Copyright (C) 2026 Red Hat, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu/error-report.h"
+#include "ui/clipboard.h"
+#include "ui/dbus-display1.h"
+#include "trace.h"
+#include "qemu-vnc.h"
+
+#define MIME_TEXT_PLAIN_UTF8 "text/plain;charset=utf-8"
+
+typedef struct {
+    GDBusMethodInvocation *invocation;
+    QemuClipboardType type;
+    guint timeout_id;
+} VncDBusClipboardRequest;
+
+static QemuDBusDisplay1Clipboard *clipboard_proxy;
+static QemuDBusDisplay1Clipboard *clipboard_skel;
+static QemuClipboardPeer clipboard_peer;
+static uint32_t clipboard_serial;
+static VncDBusClipboardRequest
+    clipboard_request[QEMU_CLIPBOARD_SELECTION__COUNT];
+
+static void
+vnc_dbus_clipboard_complete_request(
+    GDBusMethodInvocation *invocation,
+    QemuClipboardInfo *info,
+    QemuClipboardType type)
+{
+    GVariant *v_data = g_variant_new_from_data(
+        G_VARIANT_TYPE("ay"),
+        info->types[type].data,
+        info->types[type].size,
+        TRUE,
+        (GDestroyNotify)qemu_clipboard_info_unref,
+        qemu_clipboard_info_ref(info));
+
+    qemu_dbus_display1_clipboard_complete_request(
+        clipboard_skel, invocation,
+        MIME_TEXT_PLAIN_UTF8, v_data);
+}
+
+static void
+vnc_dbus_clipboard_request_cancelled(VncDBusClipboardRequest *req)
+{
+    if (!req->invocation) {
+        return;
+    }
+
+    g_dbus_method_invocation_return_error(
+        req->invocation,
+        G_DBUS_ERROR,
+        G_DBUS_ERROR_FAILED,
+        "Cancelled clipboard request");
+
+    g_clear_object(&req->invocation);
+    g_source_remove(req->timeout_id);
+    req->timeout_id = 0;
+}
+
+static gboolean
+vnc_dbus_clipboard_request_timeout(gpointer user_data)
+{
+    vnc_dbus_clipboard_request_cancelled(user_data);
+    return G_SOURCE_REMOVE;
+}
+
+static void
+vnc_dbus_clipboard_request(QemuClipboardInfo *info,
+                           QemuClipboardType type)
+{
+    g_autofree char *mime = NULL;
+    g_autoptr(GVariant) v_data = NULL;
+    g_autoptr(GError) err = NULL;
+    const char *data = NULL;
+    const char *mimes[] = { MIME_TEXT_PLAIN_UTF8, NULL };
+    size_t n;
+
+    if (type != QEMU_CLIPBOARD_TYPE_TEXT) {
+        return;
+    }
+
+    if (!clipboard_proxy) {
+        return;
+    }
+
+    if (!qemu_dbus_display1_clipboard_call_request_sync(
+            clipboard_proxy,
+            info->selection,
+            mimes,
+            G_DBUS_CALL_FLAGS_NONE, -1, &mime, &v_data, NULL, &err)) {
+        error_report("Failed to request clipboard: %s", err->message);
+        return;
+    }
+
+    if (!g_str_equal(mime, MIME_TEXT_PLAIN_UTF8)) {
+        error_report("Unsupported returned MIME: %s", mime);
+        return;
+    }
+
+    data = g_variant_get_fixed_array(v_data, &n, 1);
+    qemu_clipboard_set_data(&clipboard_peer, info, type,
+                            n, data, true);
+}
+
+static void
+vnc_dbus_clipboard_update_info(QemuClipboardInfo *info)
+{
+    bool self_update = info->owner == &clipboard_peer;
+    const char *mime[QEMU_CLIPBOARD_TYPE__COUNT + 1] = { 0, };
+    VncDBusClipboardRequest *req;
+    int i = 0;
+
+    if (info->owner == NULL) {
+        if (clipboard_proxy) {
+            qemu_dbus_display1_clipboard_call_release(
+                clipboard_proxy,
+                info->selection,
+                G_DBUS_CALL_FLAGS_NONE, -1, NULL, NULL, NULL);
+        }
+        return;
+    }
+
+    if (self_update) {
+        return;
+    }
+
+    req = &clipboard_request[info->selection];
+    if (req->invocation && info->types[req->type].data) {
+        vnc_dbus_clipboard_complete_request(
+            req->invocation, info, req->type);
+        g_clear_object(&req->invocation);
+        g_source_remove(req->timeout_id);
+        req->timeout_id = 0;
+        return;
+    }
+
+    if (info->types[QEMU_CLIPBOARD_TYPE_TEXT].available) {
+        mime[i++] = MIME_TEXT_PLAIN_UTF8;
+    }
+
+    if (i > 0 && clipboard_proxy) {
+        uint32_t serial = info->has_serial ?
+            info->serial : ++clipboard_serial;
+        qemu_dbus_display1_clipboard_call_grab(
+            clipboard_proxy,
+            info->selection,
+            serial,
+            mime,
+            G_DBUS_CALL_FLAGS_NONE, -1, NULL, NULL, NULL);
+    }
+}
+
+static void
+vnc_dbus_clipboard_notify(Notifier *notifier, void *data)
+{
+    QemuClipboardNotify *notify = data;
+
+    switch (notify->type) {
+    case QEMU_CLIPBOARD_UPDATE_INFO:
+        vnc_dbus_clipboard_update_info(notify->info);
+        return;
+    case QEMU_CLIPBOARD_RESET_SERIAL:
+        if (clipboard_proxy) {
+            qemu_dbus_display1_clipboard_call_register(
+                clipboard_proxy,
+                G_DBUS_CALL_FLAGS_NONE,
+                -1, NULL, NULL, NULL);
+        }
+        return;
+    }
+}
+
+static gboolean
+on_clipboard_register(QemuDBusDisplay1Clipboard *clipboard,
+                      GDBusMethodInvocation *invocation,
+                      gpointer user_data)
+{
+    clipboard_serial = 0;
+    qemu_clipboard_reset_serial();
+
+    qemu_dbus_display1_clipboard_complete_register(
+        clipboard, invocation);
+    return DBUS_METHOD_INVOCATION_HANDLED;
+}
+
+static gboolean
+on_clipboard_unregister(QemuDBusDisplay1Clipboard *clipboard,
+                        GDBusMethodInvocation *invocation,
+                        gpointer user_data)
+{
+    int i;
+
+    for (i = 0; i < G_N_ELEMENTS(clipboard_request); ++i) {
+        vnc_dbus_clipboard_request_cancelled(&clipboard_request[i]);
+    }
+
+    qemu_dbus_display1_clipboard_complete_unregister(
+        clipboard, invocation);
+    return DBUS_METHOD_INVOCATION_HANDLED;
+}
+
+static gboolean
+on_clipboard_grab(QemuDBusDisplay1Clipboard *clipboard,
+                  GDBusMethodInvocation *invocation,
+                  gint arg_selection,
+                  guint arg_serial,
+                  const gchar *const *arg_mimes,
+                  gpointer user_data)
+{
+    QemuClipboardSelection s = arg_selection;
+    g_autoptr(QemuClipboardInfo) info = NULL;
+
+    if (s >= QEMU_CLIPBOARD_SELECTION__COUNT) {
+        g_dbus_method_invocation_return_error(
+            invocation,
+            G_DBUS_ERROR,
+            G_DBUS_ERROR_FAILED,
+            "Invalid clipboard selection: %d", arg_selection);
+        return DBUS_METHOD_INVOCATION_HANDLED;
+    }
+
+    trace_qemu_vnc_clipboard_grab(arg_selection, arg_serial);
+
+    info = qemu_clipboard_info_new(&clipboard_peer, s);
+    if (g_strv_contains(arg_mimes, MIME_TEXT_PLAIN_UTF8)) {
+        info->types[QEMU_CLIPBOARD_TYPE_TEXT].available = true;
+    }
+    info->serial = arg_serial;
+    info->has_serial = true;
+    if (qemu_clipboard_check_serial(info, true)) {
+        qemu_clipboard_update(info);
+    }
+
+    qemu_dbus_display1_clipboard_complete_grab(
+        clipboard, invocation);
+    return DBUS_METHOD_INVOCATION_HANDLED;
+}
+
+static gboolean
+on_clipboard_release(QemuDBusDisplay1Clipboard *clipboard,
+                     GDBusMethodInvocation *invocation,
+                     gint arg_selection,
+                     gpointer user_data)
+{
+    trace_qemu_vnc_clipboard_release(arg_selection);
+
+    qemu_clipboard_peer_release(&clipboard_peer, arg_selection);
+
+    qemu_dbus_display1_clipboard_complete_release(
+        clipboard, invocation);
+    return DBUS_METHOD_INVOCATION_HANDLED;
+}
+
+static gboolean
+on_clipboard_request(QemuDBusDisplay1Clipboard *clipboard,
+                     GDBusMethodInvocation *invocation,
+                     gint arg_selection,
+                     const gchar *const *arg_mimes,
+                     gpointer user_data)
+{
+    QemuClipboardSelection s = arg_selection;
+    QemuClipboardType type = QEMU_CLIPBOARD_TYPE_TEXT;
+    QemuClipboardInfo *info = NULL;
+
+    trace_qemu_vnc_clipboard_request(arg_selection);
+
+    if (s >= QEMU_CLIPBOARD_SELECTION__COUNT) {
+        g_dbus_method_invocation_return_error(
+            invocation,
+            G_DBUS_ERROR,
+            G_DBUS_ERROR_FAILED,
+            "Invalid clipboard selection: %d", arg_selection);
+        return DBUS_METHOD_INVOCATION_HANDLED;
+    }
+
+    if (clipboard_request[s].invocation) {
+        g_dbus_method_invocation_return_error(
+            invocation,
+            G_DBUS_ERROR,
+            G_DBUS_ERROR_FAILED,
+            "Pending request");
+        return DBUS_METHOD_INVOCATION_HANDLED;
+    }
+
+    info = qemu_clipboard_info(s);
+    if (!info || !info->owner || info->owner == &clipboard_peer) {
+        g_dbus_method_invocation_return_error(
+            invocation,
+            G_DBUS_ERROR,
+            G_DBUS_ERROR_FAILED,
+            "Empty clipboard");
+        return DBUS_METHOD_INVOCATION_HANDLED;
+    }
+
+    if (!g_strv_contains(arg_mimes, MIME_TEXT_PLAIN_UTF8) ||
+        !info->types[type].available) {
+        g_dbus_method_invocation_return_error(
+            invocation,
+            G_DBUS_ERROR,
+            G_DBUS_ERROR_FAILED,
+            "Unhandled MIME types requested");
+        return DBUS_METHOD_INVOCATION_HANDLED;
+    }
+
+    if (info->types[type].data) {
+        vnc_dbus_clipboard_complete_request(invocation, info, type);
+    } else {
+        qemu_clipboard_request(info, type);
+
+        clipboard_request[s].invocation = g_object_ref(invocation);
+        clipboard_request[s].type = type;
+        clipboard_request[s].timeout_id =
+            g_timeout_add_seconds(5,
+                                  vnc_dbus_clipboard_request_timeout,
+                                  &clipboard_request[s]);
+    }
+
+    return DBUS_METHOD_INVOCATION_HANDLED;
+}
+
+void clipboard_setup(GDBusObjectManager *manager, GDBusConnection *bus)
+{
+    g_autoptr(GError) err = NULL;
+    g_autoptr(GDBusInterface) iface = NULL;
+
+    iface = g_dbus_object_manager_get_interface(
+        manager, DBUS_DISPLAY1_ROOT "/Clipboard",
+        "org.qemu.Display1.Clipboard");
+    if (!iface) {
+        return;
+    }
+
+    clipboard_proxy = g_object_ref(QEMU_DBUS_DISPLAY1_CLIPBOARD(iface));
+
+    clipboard_skel = qemu_dbus_display1_clipboard_skeleton_new();
+    g_object_connect(clipboard_skel,
+                     "signal::handle-register",
+                     on_clipboard_register, NULL,
+                     "signal::handle-unregister",
+                     on_clipboard_unregister, NULL,
+                     "signal::handle-grab",
+                     on_clipboard_grab, NULL,
+                     "signal::handle-release",
+                     on_clipboard_release, NULL,
+                     "signal::handle-request",
+                     on_clipboard_request, NULL,
+                     NULL);
+
+    if (!g_dbus_interface_skeleton_export(
+            G_DBUS_INTERFACE_SKELETON(clipboard_skel),
+            bus,
+            DBUS_DISPLAY1_ROOT "/Clipboard",
+            &err)) {
+        error_report("Failed to export clipboard: %s", err->message);
+        g_clear_object(&clipboard_skel);
+        g_clear_object(&clipboard_proxy);
+        return;
+    }
+
+    clipboard_peer.name = "dbus";
+    clipboard_peer.notifier.notify = vnc_dbus_clipboard_notify;
+    clipboard_peer.request = vnc_dbus_clipboard_request;
+    qemu_clipboard_peer_register(&clipboard_peer);
+
+    qemu_dbus_display1_clipboard_call_register(
+        clipboard_proxy,
+        G_DBUS_CALL_FLAGS_NONE,
+        -1, NULL, NULL, NULL);
+}
diff --git a/contrib/qemu-vnc/console.c b/contrib/qemu-vnc/console.c
new file mode 100644
index 00000000000..076365adf77
--- /dev/null
+++ b/contrib/qemu-vnc/console.c
@@ -0,0 +1,168 @@
+/*
+ * Minimal QemuConsole helpers for the standalone qemu-vnc binary.
+ *
+ * Copyright (C) 2026 Red Hat, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "ui/console.h"
+#include "ui/console-priv.h"
+#include "ui/vt100.h"
+#include "qemu-vnc.h"
+#include "trace.h"
+
+/*
+ * Our own QemuTextConsole definition — the one in console-vc.c uses
+ * a Chardev* backend which is not available in the standalone binary.
+ * Here we drive the VT100 emulator directly over a raw file descriptor.
+ */
+typedef struct QemuTextConsole {
+    QemuConsole parent;
+    QemuVT100 vt;
+    int chardev_fd;
+    guint io_watch_id;
+    char *name;
+} QemuTextConsole;
+
+typedef QemuConsoleClass QemuTextConsoleClass;
+
+OBJECT_DEFINE_TYPE(QemuTextConsole, qemu_text_console,
+                   QEMU_TEXT_CONSOLE, QEMU_CONSOLE)
+
+static void qemu_text_console_class_init(ObjectClass *oc, const void *data)
+{
+}
+
+static void text_console_invalidate(void *opaque)
+{
+    QemuTextConsole *s = QEMU_TEXT_CONSOLE(opaque);
+
+    vt100_set_image(&s->vt, QEMU_CONSOLE(s)->surface->image);
+    vt100_refresh(&s->vt);
+}
+
+static const GraphicHwOps text_console_ops = {
+    .invalidate  = text_console_invalidate,
+};
+
+static void qemu_text_console_init(Object *obj)
+{
+    QemuTextConsole *c = QEMU_TEXT_CONSOLE(obj);
+
+    QEMU_CONSOLE(c)->hw_ops = &text_console_ops;
+    QEMU_CONSOLE(c)->hw = c;
+}
+
+static void qemu_text_console_finalize(Object *obj)
+{
+    QemuTextConsole *tc = QEMU_TEXT_CONSOLE(obj);
+
+    vt100_fini(&tc->vt);
+    if (tc->io_watch_id) {
+        g_source_remove(tc->io_watch_id);
+    }
+    if (tc->chardev_fd >= 0) {
+        close(tc->chardev_fd);
+    }
+    g_free(tc->name);
+}
+
+
+static void text_console_out_flush(QemuVT100 *vt)
+{
+    QemuTextConsole *tc = container_of(vt, QemuTextConsole, vt);
+    const uint8_t *data;
+    uint32_t len;
+
+    while (!fifo8_is_empty(&vt->out_fifo)) {
+        ssize_t ret;
+
+        data = fifo8_pop_bufptr(&vt->out_fifo,
+                                fifo8_num_used(&vt->out_fifo), &len);
+        ret = write(tc->chardev_fd, data, len);
+        if (ret < 0) {
+            trace_qemu_vnc_console_io_error(tc->name);
+            break;
+        }
+    }
+}
+
+static void text_console_image_update(QemuVT100 *vt, int x, int y, int w, int h)
+{
+    QemuTextConsole *tc = container_of(vt, QemuTextConsole, vt);
+    QemuConsole *con = QEMU_CONSOLE(tc);
+
+    qemu_console_update(con, x, y, w, h);
+}
+
+static gboolean text_console_io_cb(GIOChannel *source,
+    GIOCondition cond, gpointer data)
+{
+    QemuTextConsole *tc = data;
+    uint8_t buf[4096];
+    ssize_t n;
+
+    if (cond & (G_IO_HUP | G_IO_ERR)) {
+        tc->io_watch_id = 0;
+        return G_SOURCE_REMOVE;
+    }
+
+    n = read(tc->chardev_fd, buf, sizeof(buf));
+    if (n <= 0) {
+        trace_qemu_vnc_console_io_error(tc->name);
+        tc->io_watch_id = 0;
+        return G_SOURCE_REMOVE;
+    }
+
+    vt100_input(&tc->vt, buf, n);
+    return G_SOURCE_CONTINUE;
+}
+
+QemuTextConsole *qemu_vnc_text_console_new(const char *name,
+                                           int fd, bool echo)
+{
+    int w = TEXT_COLS * TEXT_FONT_WIDTH;
+    int h = TEXT_ROWS * TEXT_FONT_HEIGHT;
+    QemuTextConsole *tc;
+    QemuConsole *con;
+    pixman_image_t *image;
+    GIOChannel *chan;
+
+    tc = QEMU_TEXT_CONSOLE(object_new(TYPE_QEMU_TEXT_CONSOLE));
+    con = QEMU_CONSOLE(tc);
+
+    tc->name = g_strdup(name);
+    tc->chardev_fd = fd;
+
+    image = pixman_image_create_bits(PIXMAN_x8r8g8b8, w, h, NULL, 0);
+    con->surface = qemu_create_displaysurface_pixman(image);
+    con->scanout.kind = SCANOUT_SURFACE;
+    qemu_pixman_image_unref(image);
+
+    vt100_init(&tc->vt, con->surface->image,
+               text_console_image_update, text_console_out_flush);
+    tc->vt.echo = echo;
+    vt100_refresh(&tc->vt);
+
+    chan = g_io_channel_unix_new(fd);
+    g_io_channel_set_encoding(chan, NULL, NULL);
+    tc->io_watch_id = g_io_add_watch(chan,
+                                      G_IO_IN | G_IO_HUP | G_IO_ERR,
+                                      text_console_io_cb, tc);
+    g_io_channel_unref(chan);
+
+    return tc;
+}
+
+void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
+{
+    vt100_keysym(&s->vt, keysym);
+}
+
+void qemu_text_console_update_size(QemuTextConsole *c)
+{
+    qemu_console_text_resize(QEMU_CONSOLE(c), c->vt.width, c->vt.height);
+}
diff --git a/contrib/qemu-vnc/dbus.c b/contrib/qemu-vnc/dbus.c
new file mode 100644
index 00000000000..0e5f52623ea
--- /dev/null
+++ b/contrib/qemu-vnc/dbus.c
@@ -0,0 +1,439 @@
+/*
+ * D-Bus interface for qemu-vnc standalone VNC server.
+ *
+ * Copyright (C) 2026 Red Hat, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu/cutils.h"
+#include "qapi-types-trace.h"
+#include "system/system.h"
+#include "qapi/qapi-types-ui.h"
+#include "qapi/qapi-commands-ui.h"
+#include "qemu-vnc.h"
+#include "qemu-vnc1.h"
+#include "qapi/qapi-emit-events.h"
+#include "qobject/qdict.h"
+#include "ui/vnc.h"
+#include "trace.h"
+
+typedef struct VncDbusClient {
+    QemuVnc1ClientSkeleton *skeleton;
+    char *path;
+    char *host;
+    char *service;
+    unsigned int id;
+    QTAILQ_ENTRY(VncDbusClient) next;
+} VncDbusClient;
+
+static QemuVnc1ServerSkeleton *server_skeleton;
+static GDBusObjectManagerServer *obj_manager;
+static unsigned int next_client_id;
+
+static QTAILQ_HEAD(, VncDbusClient)
+    dbus_clients = QTAILQ_HEAD_INITIALIZER(dbus_clients);
+
+static VncDbusClient *vnc_dbus_find_client(const char *host,
+                                           const char *service)
+{
+    VncDbusClient *c;
+
+    QTAILQ_FOREACH(c, &dbus_clients, next) {
+        if (g_str_equal(c->host, host) &&
+            g_str_equal(c->service, service)) {
+            return c;
+        }
+    }
+    return NULL;
+}
+
+static void vnc_dbus_update_clients_property(void)
+{
+    VncDbusClient *c;
+    GPtrArray *paths;
+    const char **strv;
+
+    paths = g_ptr_array_new();
+    QTAILQ_FOREACH(c, &dbus_clients, next) {
+        g_ptr_array_add(paths, c->path);
+    }
+    g_ptr_array_add(paths, NULL);
+
+    strv = (const char **)paths->pdata;
+    qemu_vnc1_server_set_clients(QEMU_VNC1_SERVER(server_skeleton), strv);
+    g_ptr_array_free(paths, TRUE);
+}
+
+void vnc_dbus_client_connected(const char *host, const char *service,
+                               const char *family, bool websocket)
+{
+    VncDbusClient *c;
+    g_autoptr(GDBusObjectSkeleton) obj = NULL;
+
+    if (!server_skeleton) {
+        return;
+    }
+
+    c = g_new0(VncDbusClient, 1);
+    c->id = next_client_id++;
+    c->host = g_strdup(host);
+    c->service = g_strdup(service);
+    c->path = g_strdup_printf("/org/qemu/Vnc1/Client_%u", c->id);
+
+    c->skeleton = QEMU_VNC1_CLIENT_SKELETON(qemu_vnc1_client_skeleton_new());
+    qemu_vnc1_client_set_host(QEMU_VNC1_CLIENT(c->skeleton), host);
+    qemu_vnc1_client_set_service(QEMU_VNC1_CLIENT(c->skeleton), service);
+    qemu_vnc1_client_set_family(QEMU_VNC1_CLIENT(c->skeleton), family);
+    qemu_vnc1_client_set_web_socket(QEMU_VNC1_CLIENT(c->skeleton), websocket);
+    qemu_vnc1_client_set_x509_dname(QEMU_VNC1_CLIENT(c->skeleton), "");
+    qemu_vnc1_client_set_sasl_username(QEMU_VNC1_CLIENT(c->skeleton), "");
+
+    obj = g_dbus_object_skeleton_new(c->path);
+    g_dbus_object_skeleton_add_interface(
+        obj, G_DBUS_INTERFACE_SKELETON(c->skeleton));
+    g_dbus_object_manager_server_export(obj_manager, obj);
+
+    QTAILQ_INSERT_TAIL(&dbus_clients, c, next);
+    vnc_dbus_update_clients_property();
+
+    qemu_vnc1_server_emit_client_connected(
+        QEMU_VNC1_SERVER(server_skeleton), c->path);
+}
+
+void vnc_dbus_client_initialized(const char *host, const char *service,
+                                 const char *x509_dname,
+                                 const char *sasl_username)
+{
+    VncDbusClient *c;
+
+    if (!server_skeleton) {
+        return;
+    }
+
+    c = vnc_dbus_find_client(host, service);
+    if (!c) {
+        trace_qemu_vnc_client_not_found(host, service);
+        return;
+    }
+
+    if (x509_dname) {
+        qemu_vnc1_client_set_x509_dname(
+            QEMU_VNC1_CLIENT(c->skeleton), x509_dname);
+    }
+    if (sasl_username) {
+        qemu_vnc1_client_set_sasl_username(
+            QEMU_VNC1_CLIENT(c->skeleton), sasl_username);
+    }
+
+    qemu_vnc1_server_emit_client_initialized(
+        QEMU_VNC1_SERVER(server_skeleton), c->path);
+}
+
+void vnc_dbus_client_disconnected(const char *host, const char *service)
+{
+    VncDbusClient *c;
+
+    if (!server_skeleton) {
+        return;
+    }
+
+    c = vnc_dbus_find_client(host, service);
+    if (!c) {
+        trace_qemu_vnc_client_not_found(host, service);
+        return;
+    }
+
+    qemu_vnc1_server_emit_client_disconnected(
+        QEMU_VNC1_SERVER(server_skeleton), c->path);
+
+    g_dbus_object_manager_server_unexport(obj_manager, c->path);
+    QTAILQ_REMOVE(&dbus_clients, c, next);
+    vnc_dbus_update_clients_property();
+
+    g_object_unref(c->skeleton);
+    g_free(c->path);
+    g_free(c->host);
+    g_free(c->service);
+    g_free(c);
+}
+
+static gboolean
+on_set_password(QemuVnc1Server *iface,
+                GDBusMethodInvocation *invocation,
+                const gchar *password,
+                gpointer user_data)
+{
+    Error *err = NULL;
+
+    if (vnc_display_password("default", password, &err) < 0) {
+        g_dbus_method_invocation_return_error(
+            invocation, G_DBUS_ERROR, G_DBUS_ERROR_FAILED,
+            "%s", error_get_pretty(err));
+        error_free(err);
+        return TRUE;
+    }
+
+    qemu_vnc1_server_complete_set_password(iface, invocation);
+    return TRUE;
+}
+
+static gboolean
+on_expire_password(QemuVnc1Server *iface,
+                   GDBusMethodInvocation *invocation,
+                   const gchar *time_str,
+                   gpointer user_data)
+{
+    time_t when;
+
+    if (g_str_equal(time_str, "now")) {
+        when = 0;
+    } else if (g_str_equal(time_str, "never")) {
+        when = TIME_MAX;
+    } else if (time_str[0] == '+') {
+        int seconds;
+        if (qemu_strtoi(time_str + 1, NULL, 10, &seconds) < 0) {
+            g_dbus_method_invocation_return_error(
+                invocation, G_DBUS_ERROR, G_DBUS_ERROR_INVALID_ARGS,
+                "Invalid time format: %s", time_str);
+            return TRUE;
+        }
+        when = time(NULL) + seconds;
+    } else {
+        int64_t epoch;
+        if (qemu_strtoi64(time_str, NULL, 10, &epoch) < 0) {
+            g_dbus_method_invocation_return_error(
+                invocation, G_DBUS_ERROR, G_DBUS_ERROR_INVALID_ARGS,
+                "Invalid time format: %s", time_str);
+            return TRUE;
+        }
+        when = epoch;
+    }
+
+    if (vnc_display_pw_expire("default", when) < 0) {
+        g_dbus_method_invocation_return_error(
+            invocation, G_DBUS_ERROR, G_DBUS_ERROR_FAILED,
+            "Failed to set password expiry");
+        return TRUE;
+    }
+
+    qemu_vnc1_server_complete_expire_password(iface, invocation);
+    return TRUE;
+}
+
+static gboolean
+on_reload_certificates(QemuVnc1Server *iface,
+                       GDBusMethodInvocation *invocation,
+                       gpointer user_data)
+{
+    Error *err = NULL;
+
+    if (!vnc_display_reload_certs("default", &err)) {
+        g_dbus_method_invocation_return_error(
+            invocation, G_DBUS_ERROR, G_DBUS_ERROR_FAILED,
+            "%s", error_get_pretty(err));
+        error_free(err);
+        return TRUE;
+    }
+
+    qemu_vnc1_server_complete_reload_certificates(iface, invocation);
+    return TRUE;
+}
+
+static void vnc_dbus_add_listeners(VncInfo2 *info)
+{
+    GVariantBuilder builder;
+    VncServerInfo2List *entry;
+
+    g_variant_builder_init(&builder, G_VARIANT_TYPE("aa{sv}"));
+
+    for (entry = info->server; entry; entry = entry->next) {
+        VncServerInfo2 *s = entry->value;
+        const char *vencrypt_str = "";
+
+        if (s->has_vencrypt) {
+            vencrypt_str = VncVencryptSubAuth_str(s->vencrypt);
+        }
+
+        g_variant_builder_open(&builder, G_VARIANT_TYPE("a{sv}"));
+        g_variant_builder_add(&builder, "{sv}", "Host",
+                              g_variant_new_string(s->host));
+        g_variant_builder_add(&builder, "{sv}", "Service",
+                              g_variant_new_string(s->service));
+        g_variant_builder_add(&builder, "{sv}", "Family",
+                              g_variant_new_string(
+                                  NetworkAddressFamily_str(s->family)));
+        g_variant_builder_add(&builder, "{sv}", "WebSocket",
+                              g_variant_new_boolean(s->websocket));
+        g_variant_builder_add(&builder, "{sv}", "Auth",
+                              g_variant_new_string(
+                                  VncPrimaryAuth_str(s->auth)));
+        g_variant_builder_add(&builder, "{sv}", "VencryptSubAuth",
+                              g_variant_new_string(vencrypt_str));
+        g_variant_builder_close(&builder);
+    }
+
+    qemu_vnc1_server_set_listeners(
+        QEMU_VNC1_SERVER(server_skeleton),
+        g_variant_builder_end(&builder));
+}
+
+void vnc_dbus_setup(GDBusConnection *bus)
+{
+    g_autoptr(GDBusObjectSkeleton) server_obj = NULL;
+    VncInfo2List *info_list;
+    Error *err = NULL;
+    const char *auth_str = "none";
+    const char *vencrypt_str = "";
+
+    obj_manager = g_dbus_object_manager_server_new("/org/qemu/Vnc1");
+
+    server_skeleton = QEMU_VNC1_SERVER_SKELETON(
+        qemu_vnc1_server_skeleton_new());
+
+    qemu_vnc1_server_set_name(QEMU_VNC1_SERVER(server_skeleton),
+                              qemu_name ? qemu_name : "");
+    qemu_vnc1_server_set_clients(QEMU_VNC1_SERVER(server_skeleton), NULL);
+
+    /* Query auth info from the VNC display */
+    info_list = qmp_query_vnc_servers(&err);
+    if (info_list) {
+        VncInfo2 *info = info_list->value;
+        auth_str = VncPrimaryAuth_str(info->auth);
+        if (info->has_vencrypt) {
+            vencrypt_str = VncVencryptSubAuth_str(info->vencrypt);
+        }
+        vnc_dbus_add_listeners(info);
+    }
+
+    qemu_vnc1_server_set_auth(QEMU_VNC1_SERVER(server_skeleton), auth_str);
+    qemu_vnc1_server_set_vencrypt_sub_auth(
+        QEMU_VNC1_SERVER(server_skeleton), vencrypt_str);
+
+    qapi_free_VncInfo2List(info_list);
+
+    g_signal_connect(server_skeleton, "handle-set-password",
+                     G_CALLBACK(on_set_password), NULL);
+    g_signal_connect(server_skeleton, "handle-expire-password",
+                     G_CALLBACK(on_expire_password), NULL);
+    g_signal_connect(server_skeleton, "handle-reload-certificates",
+                     G_CALLBACK(on_reload_certificates), NULL);
+
+    server_obj = g_dbus_object_skeleton_new("/org/qemu/Vnc1/Server");
+    g_dbus_object_skeleton_add_interface(
+        server_obj, G_DBUS_INTERFACE_SKELETON(server_skeleton));
+    g_dbus_object_manager_server_export(obj_manager, server_obj);
+
+    g_dbus_object_manager_server_set_connection(obj_manager, bus);
+
+    if (g_dbus_connection_get_flags(bus)
+        & G_DBUS_CONNECTION_FLAGS_MESSAGE_BUS_CONNECTION) {
+        g_bus_own_name_on_connection(
+            bus, "org.qemu.vnc",
+            G_BUS_NAME_OWNER_FLAGS_NONE,
+            NULL, NULL, NULL, NULL);
+    }
+}
+
+void vnc_action_shutdown(VncState *vs)
+{
+    VncDbusClient *c;
+
+    c = vnc_dbus_find_client(vs->info->host, vs->info->service);
+    if (!c) {
+        trace_qemu_vnc_client_not_found(vs->info->host, vs->info->service);
+        return;
+    }
+
+    qemu_vnc1_client_emit_shutdown_request(QEMU_VNC1_CLIENT(c->skeleton));
+}
+
+void vnc_action_reset(VncState *vs)
+{
+    VncDbusClient *c;
+
+    c = vnc_dbus_find_client(vs->info->host, vs->info->service);
+    if (!c) {
+        trace_qemu_vnc_client_not_found(vs->info->host, vs->info->service);
+        return;
+    }
+
+    qemu_vnc1_client_emit_reset_request(QEMU_VNC1_CLIENT(c->skeleton));
+}
+
+/*
+ * Override the stub qapi_event_emit() to capture VNC events
+ * and forward them to the D-Bus interface.
+ */
+void qapi_event_emit(QAPIEvent event, QDict *qdict)
+{
+    QDict *data, *client;
+    const char *host, *service, *family;
+    bool websocket;
+
+    if (event != QAPI_EVENT_VNC_CONNECTED &&
+        event != QAPI_EVENT_VNC_INITIALIZED &&
+        event != QAPI_EVENT_VNC_DISCONNECTED) {
+        return;
+    }
+
+    data = qdict_get_qdict(qdict, "data");
+    if (!data) {
+        return;
+    }
+
+    client = qdict_get_qdict(data, "client");
+    if (!client) {
+        return;
+    }
+
+    host = qdict_get_str(client, "host");
+    service = qdict_get_str(client, "service");
+    family = qdict_get_str(client, "family");
+    websocket = qdict_get_bool(client, "websocket");
+
+    switch (event) {
+    case QAPI_EVENT_VNC_CONNECTED:
+        vnc_dbus_client_connected(host, service, family, websocket);
+        break;
+    case QAPI_EVENT_VNC_INITIALIZED: {
+        const char *x509_dname = NULL;
+        const char *sasl_username = NULL;
+
+        if (qdict_haskey(client, "x509_dname")) {
+            x509_dname = qdict_get_str(client, "x509_dname");
+        }
+        if (qdict_haskey(client, "sasl_username")) {
+            sasl_username = qdict_get_str(client, "sasl_username");
+        }
+        vnc_dbus_client_initialized(host, service,
+                                    x509_dname, sasl_username);
+        break;
+    }
+    case QAPI_EVENT_VNC_DISCONNECTED:
+        vnc_dbus_client_disconnected(host, service);
+        break;
+    default:
+        break;
+    }
+}
+
+void vnc_dbus_cleanup(void)
+{
+    VncDbusClient *c, *next;
+
+    QTAILQ_FOREACH_SAFE(c, &dbus_clients, next, next) {
+        g_dbus_object_manager_server_unexport(obj_manager, c->path);
+        QTAILQ_REMOVE(&dbus_clients, c, next);
+        g_object_unref(c->skeleton);
+        g_free(c->path);
+        g_free(c->host);
+        g_free(c->service);
+        g_free(c);
+    }
+
+    g_clear_object(&server_skeleton);
+    g_clear_object(&obj_manager);
+}
diff --git a/contrib/qemu-vnc/display.c b/contrib/qemu-vnc/display.c
new file mode 100644
index 00000000000..8fe9b6fc898
--- /dev/null
+++ b/contrib/qemu-vnc/display.c
@@ -0,0 +1,456 @@
+/*
+ * D-Bus display listener — scanout, update and cursor handling.
+ *
+ * Copyright (C) 2026 Red Hat, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu/sockets.h"
+#include "qemu/error-report.h"
+#include "ui/console-priv.h"
+#include "ui/dbus-display1.h"
+#include "ui/surface.h"
+#include "trace.h"
+#include "qemu-vnc.h"
+
+typedef struct ConsoleData {
+    QemuDBusDisplay1Console *console_proxy;
+    QemuDBusDisplay1Keyboard *keyboard_proxy;
+    QemuDBusDisplay1Mouse *mouse_proxy;
+    QemuGraphicConsole *gfx_con;
+    GDBusConnection *listener_conn;
+    /*
+     * When true the surface is backed by a read-only mmap (ScanoutMap path)
+     * and Update messages must be rejected because compositing into the
+     * surface is not possible.  The plain Scanout path provides a writable
+     * copy and clears this flag.
+     */
+    bool read_only;
+} ConsoleData;
+
+static void display_ui_info(void *opaque, uint32_t head, QemuUIInfo *info)
+{
+    ConsoleData *cd = opaque;
+    g_autoptr(GError) err = NULL;
+
+    if (!cd || !cd->console_proxy) {
+        return;
+    }
+
+    qemu_dbus_display1_console_call_set_uiinfo_sync(
+        cd->console_proxy,
+        info->width_mm, info->height_mm,
+        info->xoff, info->yoff,
+        info->width, info->height,
+        G_DBUS_CALL_FLAGS_NONE, -1, NULL, &err);
+    if (err) {
+        error_report("SetUIInfo failed: %s", err->message);
+    }
+}
+
+static void
+scanout_image_destroy(pixman_image_t *image, void *data)
+{
+    g_variant_unref(data);
+}
+
+typedef struct {
+    void *addr;
+    size_t len;
+} ScanoutMapData;
+
+static void
+scanout_map_destroy(pixman_image_t *image, void *data)
+{
+    ScanoutMapData *map = data;
+    munmap(map->addr, map->len);
+    g_free(map);
+}
+
+static gboolean
+on_scanout(QemuDBusDisplay1Listener *listener,
+           GDBusMethodInvocation *invocation,
+           guint width, guint height, guint stride,
+           guint pixman_format, GVariant *data,
+           gpointer user_data)
+{
+    ConsoleData *cd = user_data;
+    QemuConsole *con = QEMU_CONSOLE(cd->gfx_con);
+    gsize size;
+    const uint8_t *pixels;
+    pixman_image_t *image;
+    DisplaySurface *surface;
+
+    trace_qemu_vnc_scanout(width, height, stride, pixman_format);
+
+    pixels = g_variant_get_fixed_array(data, &size, 1);
+
+    image = pixman_image_create_bits((pixman_format_code_t)pixman_format,
+        width, height, (uint32_t *)pixels, stride);
+    assert(image);
+
+    g_variant_ref(data);
+    pixman_image_set_destroy_function(image, scanout_image_destroy, data);
+
+    cd->read_only = false;
+    surface = qemu_create_displaysurface_pixman(image);
+    qemu_console_set_surface(con, surface);
+
+    qemu_dbus_display1_listener_complete_scanout(listener, invocation);
+    return DBUS_METHOD_INVOCATION_HANDLED;
+}
+
+static gboolean
+on_update(QemuDBusDisplay1Listener *listener,
+          GDBusMethodInvocation *invocation,
+          gint x, gint y, gint w, gint h,
+          guint stride, guint pixman_format, GVariant *data,
+          gpointer user_data)
+{
+    ConsoleData *cd = user_data;
+    QemuConsole *con = QEMU_CONSOLE(cd->gfx_con);
+    DisplaySurface *surface = qemu_console_surface(con);
+    gsize size;
+    const uint8_t *pixels;
+    pixman_image_t *src;
+
+    trace_qemu_vnc_update(x, y, w, h, stride, pixman_format);
+    if (!surface || cd->read_only) {
+        g_dbus_method_invocation_return_error(invocation, G_DBUS_ERROR,
+            G_DBUS_ERROR_FAILED, "No active or writable console");
+        return DBUS_METHOD_INVOCATION_HANDLED;
+    }
+
+    pixels = g_variant_get_fixed_array(data, &size, 1);
+    src = pixman_image_create_bits((pixman_format_code_t)pixman_format,
+        w, h, (uint32_t *)pixels, stride);
+    assert(src);
+    pixman_image_composite(PIXMAN_OP_SRC, src, NULL,
+            surface->image,
+            0, 0, 0, 0, x, y, w, h);
+    pixman_image_unref(src);
+
+    qemu_console_update(con, x, y, w, h);
+
+    qemu_dbus_display1_listener_complete_update(listener, invocation);
+    return DBUS_METHOD_INVOCATION_HANDLED;
+}
+
+static gboolean
+on_scanout_map(QemuDBusDisplay1ListenerUnixMap *listener,
+               GDBusMethodInvocation *invocation,
+               GUnixFDList *fd_list,
+               GVariant *arg_handle,
+               guint offset, guint width, guint height,
+               guint stride, guint pixman_format,
+               gpointer user_data)
+{
+    ConsoleData *cd = user_data;
+    gint32 handle = g_variant_get_handle(arg_handle);
+    g_autoptr(GError) err = NULL;
+    DisplaySurface *surface;
+    int fd;
+    void *addr;
+    size_t len = (size_t)height * stride;
+    pixman_image_t *image;
+
+    trace_qemu_vnc_scanout_map(width, height, stride, pixman_format, offset);
+
+    fd = g_unix_fd_list_get(fd_list, handle, &err);
+    if (fd < 0) {
+        g_dbus_method_invocation_return_error(invocation, G_DBUS_ERROR,
+            G_DBUS_ERROR_FAILED, "Failed to get fd: %s", err->message);
+        return DBUS_METHOD_INVOCATION_HANDLED;
+    }
+
+    /* MAP_PRIVATE: we only read; avoid propagating writes back to QEMU */
+    addr = mmap(NULL, len, PROT_READ, MAP_PRIVATE, fd, offset);
+    close(fd);
+    if (addr == MAP_FAILED) {
+        g_dbus_method_invocation_return_error(invocation, G_DBUS_ERROR,
+            G_DBUS_ERROR_FAILED, "mmap failed: %s", g_strerror(errno));
+        return DBUS_METHOD_INVOCATION_HANDLED;
+    }
+
+    image = pixman_image_create_bits((pixman_format_code_t)pixman_format,
+                                     width, height, addr, stride);
+    assert(image);
+    {
+        ScanoutMapData *map = g_new0(ScanoutMapData, 1);
+        map->addr = addr;
+        map->len = len;
+        pixman_image_set_destroy_function(image, scanout_map_destroy, map);
+    }
+
+    cd->read_only = true;
+    surface = qemu_create_displaysurface_pixman(image);
+    qemu_console_set_surface(QEMU_CONSOLE(cd->gfx_con), surface);
+
+    qemu_dbus_display1_listener_unix_map_complete_scanout_map(
+        listener, invocation, NULL);
+    return DBUS_METHOD_INVOCATION_HANDLED;
+}
+
+static gboolean
+on_update_map(QemuDBusDisplay1ListenerUnixMap *listener,
+              GDBusMethodInvocation *invocation,
+              guint x, guint y, guint w, guint h,
+              gpointer user_data)
+{
+    ConsoleData *cd = user_data;
+
+    trace_qemu_vnc_update_map(x, y, w, h);
+
+    qemu_console_update(QEMU_CONSOLE(cd->gfx_con), x, y, w, h);
+
+    qemu_dbus_display1_listener_unix_map_complete_update_map(
+        listener, invocation);
+    return DBUS_METHOD_INVOCATION_HANDLED;
+}
+
+static gboolean
+on_cursor_define(QemuDBusDisplay1Listener *listener,
+                 GDBusMethodInvocation *invocation,
+                 gint width, gint height,
+                 gint hot_x, gint hot_y,
+                 GVariant *data,
+                 gpointer user_data)
+{
+    ConsoleData *cd = user_data;
+    gsize size;
+    const uint8_t *pixels;
+    QEMUCursor *c;
+
+    trace_qemu_vnc_cursor_define(width, height, hot_x, hot_y);
+
+    c = cursor_alloc(width, height);
+    if (!c) {
+        qemu_dbus_display1_listener_complete_cursor_define(
+            listener, invocation);
+        return DBUS_METHOD_INVOCATION_HANDLED;
+    }
+
+    c->hot_x = hot_x;
+    c->hot_y = hot_y;
+
+    pixels = g_variant_get_fixed_array(data, &size, 1);
+    memcpy(c->data, pixels, MIN(size, (gsize)width * height * 4));
+
+    qemu_console_set_cursor(QEMU_CONSOLE(cd->gfx_con), c);
+    cursor_unref(c);
+
+    qemu_dbus_display1_listener_complete_cursor_define(
+        listener, invocation);
+    return DBUS_METHOD_INVOCATION_HANDLED;
+}
+
+typedef struct {
+    GMainLoop *loop;
+    GThread *thread;
+    GDBusConnection *listener_conn;
+} ListenerSetupData;
+
+static void
+on_register_listener_finished(GObject *source_object,
+                              GAsyncResult *res,
+                              gpointer user_data)
+{
+    ListenerSetupData *data = user_data;
+    g_autoptr(GError) err = NULL;
+
+    qemu_dbus_display1_console_call_register_listener_finish(
+        QEMU_DBUS_DISPLAY1_CONSOLE(source_object),
+        NULL,
+        res, &err);
+
+    if (err) {
+        error_report("RegisterListener failed: %s", err->message);
+        g_main_loop_quit(data->loop);
+        return;
+    }
+
+    data->listener_conn = g_thread_join(data->thread);
+    g_main_loop_quit(data->loop);
+}
+
+static GDBusConnection *
+console_register_display_listener(QemuDBusDisplay1Console *console)
+{
+    g_autoptr(GError) err = NULL;
+    g_autoptr(GMainLoop) loop = NULL;
+    g_autoptr(GUnixFDList) fd_list = NULL;
+    ListenerSetupData data = { 0 };
+    int pair[2];
+    int idx;
+
+    if (qemu_socketpair(AF_UNIX, SOCK_STREAM, 0, pair) < 0) {
+        error_report("socketpair failed: %s", strerror(errno));
+        return NULL;
+    }
+
+    fd_list = g_unix_fd_list_new();
+    idx = g_unix_fd_list_append(fd_list, pair[1], &err);
+    close(pair[1]);
+    if (idx < 0) {
+        close(pair[0]);
+        error_report("Failed to append fd: %s", err->message);
+        return NULL;
+    }
+
+    loop = g_main_loop_new(NULL, FALSE);
+    data.loop = loop;
+    data.thread = p2p_dbus_thread_new(pair[0]);
+
+    qemu_dbus_display1_console_call_register_listener(
+        console,
+        g_variant_new_handle(idx),
+        G_DBUS_CALL_FLAGS_NONE,
+        -1,
+        fd_list,
+        NULL,
+        on_register_listener_finished,
+        &data);
+
+    g_main_loop_run(loop);
+
+    return data.listener_conn;
+}
+
+static void
+setup_display_listener(ConsoleData *cd)
+{
+    g_autoptr(GDBusObjectSkeleton) obj = NULL;
+    GDBusObjectManagerServer *server;
+    QemuDBusDisplay1Listener *iface;
+    QemuDBusDisplay1ListenerUnixMap *iface_map;
+
+    server = g_dbus_object_manager_server_new(DBUS_DISPLAY1_ROOT);
+    obj = g_dbus_object_skeleton_new(DBUS_DISPLAY1_ROOT "/Listener");
+
+    /* Main listener interface */
+    iface = qemu_dbus_display1_listener_skeleton_new();
+    g_object_connect(iface,
+                     "signal::handle-scanout", on_scanout, cd,
+                     "signal::handle-update", on_update, cd,
+                     "signal::handle-cursor-define", on_cursor_define, cd,
+                     NULL);
+    g_dbus_object_skeleton_add_interface(obj,
+                                         G_DBUS_INTERFACE_SKELETON(iface));
+
+    /* Unix shared memory map interface */
+    iface_map = qemu_dbus_display1_listener_unix_map_skeleton_new();
+    g_object_connect(iface_map,
+                     "signal::handle-scanout-map", on_scanout_map, cd,
+                     "signal::handle-update-map", on_update_map, cd,
+                     NULL);
+    g_dbus_object_skeleton_add_interface(obj,
+                                         G_DBUS_INTERFACE_SKELETON(iface_map));
+
+    {
+        const gchar *ifaces[] = {
+            "org.qemu.Display1.Listener.Unix.Map", NULL
+        };
+        g_object_set(iface, "interfaces", ifaces, NULL);
+    }
+
+    g_dbus_object_manager_server_export(server, obj);
+    g_dbus_object_manager_server_set_connection(server,
+                                                 cd->listener_conn);
+
+    g_dbus_connection_start_message_processing(cd->listener_conn);
+}
+
+static const GraphicHwOps vnc_hw_ops = {
+    .ui_info = display_ui_info,
+};
+
+bool console_setup(GDBusConnection *bus, const char *bus_name,
+                   const char *console_path)
+{
+    g_autoptr(GError) err = NULL;
+    ConsoleData *cd;
+    QemuConsole *con;
+
+    cd = g_new0(ConsoleData, 1);
+
+    cd->console_proxy = qemu_dbus_display1_console_proxy_new_sync(
+        bus, G_DBUS_PROXY_FLAGS_NONE, bus_name,
+        console_path, NULL, &err);
+    if (!cd->console_proxy) {
+        error_report("Failed to create console proxy for %s: %s",
+                     console_path, err->message);
+        g_free(cd);
+        return false;
+    }
+
+    cd->keyboard_proxy = QEMU_DBUS_DISPLAY1_KEYBOARD(
+        qemu_dbus_display1_keyboard_proxy_new_sync(
+            bus, G_DBUS_PROXY_FLAGS_NONE, bus_name,
+            console_path, NULL, &err));
+    if (!cd->keyboard_proxy) {
+        error_report("Failed to create keyboard proxy for %s: %s",
+                     console_path, err->message);
+        g_object_unref(cd->console_proxy);
+        g_free(cd);
+        return false;
+    }
+
+    g_clear_error(&err);
+    cd->mouse_proxy = QEMU_DBUS_DISPLAY1_MOUSE(
+        qemu_dbus_display1_mouse_proxy_new_sync(
+            bus, G_DBUS_PROXY_FLAGS_NONE, bus_name,
+            console_path, NULL, &err));
+    if (!cd->mouse_proxy) {
+        error_report("Failed to create mouse proxy for %s: %s",
+                     console_path, err->message);
+        g_object_unref(cd->keyboard_proxy);
+        g_object_unref(cd->console_proxy);
+        g_free(cd);
+        return false;
+    }
+
+    con = qemu_graphic_console_create(NULL, 0, &vnc_hw_ops, cd);
+    cd->gfx_con = QEMU_GRAPHIC_CONSOLE(con);
+
+    cd->listener_conn = console_register_display_listener(
+        cd->console_proxy);
+    if (!cd->listener_conn) {
+        error_report("Failed to setup D-Bus listener for %s",
+                     console_path);
+        g_object_unref(cd->mouse_proxy);
+        g_object_unref(cd->keyboard_proxy);
+        g_object_unref(cd->console_proxy);
+        g_free(cd);
+        return false;
+    }
+
+    setup_display_listener(cd);
+    input_setup(cd->keyboard_proxy, cd->mouse_proxy);
+
+    return true;
+}
+
+QemuDBusDisplay1Keyboard *console_get_keyboard(QemuConsole *con)
+{
+    ConsoleData *cd;
+
+    if (!QEMU_IS_GRAPHIC_CONSOLE(con)) {
+        return NULL;
+    }
+    cd = con->hw;
+    return cd ? cd->keyboard_proxy : NULL;
+}
+
+QemuDBusDisplay1Mouse *console_get_mouse(QemuConsole *con)
+{
+    ConsoleData *cd;
+
+    if (!QEMU_IS_GRAPHIC_CONSOLE(con)) {
+        return NULL;
+    }
+    cd = con->hw;
+    return cd ? cd->mouse_proxy : NULL;
+}
diff --git a/contrib/qemu-vnc/input.c b/contrib/qemu-vnc/input.c
new file mode 100644
index 00000000000..2313b0a7c77
--- /dev/null
+++ b/contrib/qemu-vnc/input.c
@@ -0,0 +1,239 @@
+/*
+ * Keyboard and mouse input dispatch via D-Bus.
+ *
+ * Copyright (C) 2026 Red Hat, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "ui/dbus-display1.h"
+#include "ui/input.h"
+#include "trace.h"
+#include "qemu-vnc.h"
+
+struct QEMUPutLEDEntry {
+    QEMUPutLEDEvent *put_led;
+    void *opaque;
+    QTAILQ_ENTRY(QEMUPutLEDEntry) next;
+};
+
+static NotifierList mouse_mode_notifiers =
+    NOTIFIER_LIST_INITIALIZER(mouse_mode_notifiers);
+static QTAILQ_HEAD(, QEMUPutLEDEntry) led_handlers =
+    QTAILQ_HEAD_INITIALIZER(led_handlers);
+
+/* Track the target console for pending mouse events (used by sync) */
+static QemuConsole *mouse_target;
+
+QEMUPutLEDEntry *qemu_add_led_event_handler(QEMUPutLEDEvent *func,
+                                            void *opaque)
+{
+    QEMUPutLEDEntry *s;
+
+    s = g_new0(QEMUPutLEDEntry, 1);
+    s->put_led = func;
+    s->opaque = opaque;
+    QTAILQ_INSERT_TAIL(&led_handlers, s, next);
+    return s;
+}
+
+void qemu_remove_led_event_handler(QEMUPutLEDEntry *entry)
+{
+    if (!entry) {
+        return;
+    }
+    QTAILQ_REMOVE(&led_handlers, entry, next);
+    g_free(entry);
+}
+
+static void
+on_keyboard_modifiers_changed(GObject *gobject, GParamSpec *pspec,
+                              gpointer user_data)
+{
+    guint modifiers;
+    QEMUPutLEDEntry *cursor;
+
+    modifiers = qemu_dbus_display1_keyboard_get_modifiers(
+        QEMU_DBUS_DISPLAY1_KEYBOARD(gobject));
+
+    /*
+     * The D-Bus Keyboard.Modifiers property uses the same
+     * bit layout as QEMU's LED constants.
+     */
+    QTAILQ_FOREACH(cursor, &led_handlers, next) {
+        cursor->put_led(cursor->opaque, modifiers);
+    }
+}
+
+void qemu_add_mouse_mode_change_notifier(Notifier *notify)
+{
+    notifier_list_add(&mouse_mode_notifiers, notify);
+}
+
+void qemu_remove_mouse_mode_change_notifier(Notifier *notify)
+{
+    notifier_remove(notify);
+}
+
+void qemu_input_event_send_key_delay(uint32_t delay_ms)
+{
+}
+
+void qemu_input_event_send_key_qcode(QemuConsole *src, QKeyCode q, bool down)
+{
+    QemuDBusDisplay1Keyboard *kbd;
+    guint qnum;
+
+    trace_qemu_vnc_key_event(q, down);
+
+    if (!src) {
+        return;
+    }
+    kbd = console_get_keyboard(src);
+    if (!kbd) {
+        return;
+    }
+
+    if (q >= qemu_input_map_qcode_to_qnum_len) {
+        return;
+    }
+    qnum = qemu_input_map_qcode_to_qnum[q];
+
+    if (down) {
+        qemu_dbus_display1_keyboard_call_press(
+            kbd, qnum,
+            G_DBUS_CALL_FLAGS_NONE, -1, NULL, NULL, NULL);
+    } else {
+        qemu_dbus_display1_keyboard_call_release(
+            kbd, qnum,
+            G_DBUS_CALL_FLAGS_NONE, -1, NULL, NULL, NULL);
+    }
+}
+
+static guint abs_x, abs_y;
+static bool abs_pending;
+static gint rel_dx, rel_dy;
+static bool rel_pending;
+
+void qemu_input_queue_abs(QemuConsole *src, InputAxis axis,
+                          int value, int min_in, int max_in)
+{
+    if (axis == INPUT_AXIS_X) {
+        abs_x = value;
+    } else if (axis == INPUT_AXIS_Y) {
+        abs_y = value;
+    }
+    abs_pending = true;
+    mouse_target = src;
+}
+
+void qemu_input_queue_rel(QemuConsole *src, InputAxis axis, int value)
+{
+    if (axis == INPUT_AXIS_X) {
+        rel_dx += value;
+    } else if (axis == INPUT_AXIS_Y) {
+        rel_dy += value;
+    }
+    rel_pending = true;
+    mouse_target = src;
+}
+
+void qemu_input_event_sync(void)
+{
+    QemuDBusDisplay1Mouse *mouse;
+
+    if (!mouse_target) {
+        return;
+    }
+
+    mouse = console_get_mouse(mouse_target);
+    if (!mouse) {
+        abs_pending = false;
+        rel_pending = false;
+        return;
+    }
+
+    if (abs_pending) {
+        trace_qemu_vnc_input_abs(abs_x, abs_y);
+        abs_pending = false;
+        qemu_dbus_display1_mouse_call_set_abs_position(
+            mouse, abs_x, abs_y,
+            G_DBUS_CALL_FLAGS_NONE, -1, NULL, NULL, NULL);
+    }
+
+    if (rel_pending) {
+        trace_qemu_vnc_input_rel(rel_dx, rel_dy);
+        rel_pending = false;
+        qemu_dbus_display1_mouse_call_rel_motion(
+            mouse, rel_dx, rel_dy,
+            G_DBUS_CALL_FLAGS_NONE, -1, NULL, NULL, NULL);
+        rel_dx = 0;
+        rel_dy = 0;
+    }
+}
+
+bool qemu_input_is_absolute(QemuConsole *con)
+{
+    QemuDBusDisplay1Mouse *mouse;
+
+    if (!con) {
+        return false;
+    }
+    mouse = console_get_mouse(con);
+
+    if (!mouse) {
+        return false;
+    }
+    return qemu_dbus_display1_mouse_get_is_absolute(mouse);
+}
+
+static void
+on_mouse_is_absolute_changed(GObject *gobject, GParamSpec *pspec,
+                              gpointer user_data)
+{
+    notifier_list_notify(&mouse_mode_notifiers, NULL);
+}
+
+void qemu_input_update_buttons(QemuConsole *src, uint32_t *button_map,
+                               uint32_t button_old, uint32_t button_new)
+{
+    QemuDBusDisplay1Mouse *mouse;
+    uint32_t changed;
+    int i;
+
+    if (!src) {
+        return;
+    }
+    mouse = console_get_mouse(src);
+    if (!mouse) {
+        return;
+    }
+
+    changed = button_old ^ button_new;
+    for (i = 0; i < 32; i++) {
+        if (!(changed & (1u << i))) {
+            continue;
+        }
+        trace_qemu_vnc_input_btn(i, !!(button_new & (1u << i)));
+        if (button_new & (1u << i)) {
+            qemu_dbus_display1_mouse_call_press(
+                mouse, i,
+                G_DBUS_CALL_FLAGS_NONE, -1, NULL, NULL, NULL);
+        } else {
+            qemu_dbus_display1_mouse_call_release(
+                mouse, i,
+                G_DBUS_CALL_FLAGS_NONE, -1, NULL, NULL, NULL);
+        }
+    }
+}
+
+void input_setup(QemuDBusDisplay1Keyboard *kbd,
+                 QemuDBusDisplay1Mouse *mouse)
+{
+    g_signal_connect(kbd, "notify::modifiers",
+                     G_CALLBACK(on_keyboard_modifiers_changed), NULL);
+    g_signal_connect(mouse, "notify::is-absolute",
+                     G_CALLBACK(on_mouse_is_absolute_changed), NULL);
+}
diff --git a/contrib/qemu-vnc/qemu-vnc.c b/contrib/qemu-vnc/qemu-vnc.c
new file mode 100644
index 00000000000..0e1d7bbf159
--- /dev/null
+++ b/contrib/qemu-vnc/qemu-vnc.c
@@ -0,0 +1,450 @@
+/*
+ * Standalone VNC server connecting to QEMU via D-Bus display interface.
+ *
+ * Copyright (C) 2026 Red Hat, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu/cutils.h"
+#include "qemu/datadir.h"
+#include "qemu/error-report.h"
+#include "qemu/config-file.h"
+#include "qemu/option.h"
+#include "qemu/log.h"
+#include "qemu/main-loop.h"
+#include "qemu-version.h"
+#include "ui/vnc.h"
+#include "crypto/secret.h"
+#include "crypto/tlscredsx509.h"
+#include "trace.h"
+#include "qemu-vnc.h"
+
+const char *qemu_name;
+const char *keyboard_layout;
+
+static bool terminate;
+static VncDisplay *vd;
+
+static GType
+dbus_display_get_proxy_type(GDBusObjectManagerClient *manager,
+                            const gchar *object_path,
+                            const gchar *interface_name,
+                            gpointer user_data)
+{
+    static const struct {
+        const char *iface;
+        GType (*get_type)(void);
+    } types[] = {
+        { "org.qemu.Display1.Clipboard",
+          qemu_dbus_display1_clipboard_proxy_get_type },
+        { "org.qemu.Display1.Audio",
+          qemu_dbus_display1_audio_proxy_get_type },
+        { "org.qemu.Display1.Chardev",
+          qemu_dbus_display1_chardev_proxy_get_type },
+    };
+
+    if (!interface_name) {
+        return G_TYPE_DBUS_OBJECT_PROXY;
+    }
+
+    for (int i = 0; i < G_N_ELEMENTS(types); i++) {
+        if (g_str_equal(interface_name, types[i].iface)) {
+            return types[i].get_type();
+        }
+    }
+
+    return G_TYPE_DBUS_PROXY;
+}
+
+static void
+on_bus_closed(GDBusConnection *connection,
+              gboolean remote_peer_vanished,
+              GError *error,
+              gpointer user_data)
+{
+    terminate = true;
+    qemu_notify_event();
+}
+
+static void
+on_owner_vanished(GDBusConnection *connection,
+                  const gchar *name,
+                  gpointer user_data)
+{
+    trace_qemu_vnc_owner_vanished(name);
+    error_report("D-Bus peer %s vanished, terminating", name);
+    terminate = true;
+    qemu_notify_event();
+}
+
+typedef struct {
+    GDBusConnection *bus;
+    const char *bus_name;
+    const char * const *chardev_names;
+    bool no_vt;
+} ManagerSetupData;
+
+static int
+compare_console_paths(const void *a, const void *b)
+{
+    const char *pa = *(const char **)a;
+    const char *pb = *(const char **)b;
+    return strcmp(pa, pb);
+}
+
+static void
+on_manager_ready(GObject *source_object,
+                 GAsyncResult *res,
+                 gpointer user_data)
+{
+    ManagerSetupData *data = user_data;
+    g_autoptr(GError) err = NULL;
+    g_autoptr(GDBusObjectManager) manager = NULL;
+    GList *objects, *l;
+    g_autoptr(GPtrArray) console_paths = NULL;
+    bool found = false;
+
+    manager = G_DBUS_OBJECT_MANAGER(
+        g_dbus_object_manager_client_new_finish(res, &err));
+    if (!manager) {
+        error_report("Failed to create object manager: %s",
+                     err->message);
+        terminate = true;
+        qemu_notify_event();
+        g_free(data);
+        return;
+    }
+
+    /*
+     * Discover all Console objects and sort them so that console
+     * indices are assigned in a predictable order matching QEMU's.
+     */
+    console_paths = g_ptr_array_new_with_free_func(g_free);
+    objects = g_dbus_object_manager_get_objects(manager);
+    for (l = objects; l; l = l->next) {
+        GDBusObject *obj = l->data;
+        const char *path = g_dbus_object_get_object_path(obj);
+
+        if (g_str_has_prefix(path, DBUS_DISPLAY1_ROOT "/Console_")) {
+            g_ptr_array_add(console_paths, g_strdup(path));
+        }
+    }
+    g_list_free_full(objects, g_object_unref);
+
+    g_ptr_array_sort(console_paths, compare_console_paths);
+
+    for (guint i = 0; i < console_paths->len; i++) {
+        const char *path = g_ptr_array_index(console_paths, i);
+
+        if (!console_setup(data->bus, data->bus_name, path)) {
+            error_report("Failed to setup console %s", path);
+            continue;
+        }
+        found = true;
+    }
+
+    if (!found) {
+        error_report("No consoles found");
+        terminate = true;
+        qemu_notify_event();
+        g_free(data);
+        return;
+    }
+
+    /*
+     * Create the VNC display now that consoles exist, so that the
+     * display change listener is registered against a valid console.
+     */
+    {
+        Error *local_err = NULL;
+
+        vd = vnc_display_new("default", &local_err);
+        if (!vd) {
+            error_report_err(local_err);
+            terminate = true;
+            qemu_notify_event();
+            g_free(data);
+            return;
+        }
+    }
+
+    vnc_dbus_setup(data->bus);
+
+    clipboard_setup(manager, data->bus);
+    audio_setup(manager);
+    if (!data->no_vt) {
+        chardev_setup(data->chardev_names, manager);
+    }
+    g_free(data);
+}
+
+int main(int argc, char *argv[])
+{
+    Error *local_err = NULL;
+    g_autoptr(GError) err = NULL;
+    g_autoptr(GDBusConnection) bus = NULL;
+    g_autofree char *dbus_address = NULL;
+    g_autofree char *bus_name = NULL;
+    int dbus_p2p_fd = -1;
+    g_autofree char *vnc_addr = NULL;
+    g_autofree char *ws_addr = NULL;
+    g_autofree char *share = NULL;
+    g_autofree char *tls_creds_dir = NULL;
+    g_autofree char *trace_opt = NULL;
+    g_auto(GStrv) chardev_names = NULL;
+    const char *creds_dir;
+    bool has_vnc_password = false;
+    bool show_version = false;
+    bool no_vt = false;
+    bool password = false;
+    bool lossy = false;
+    bool non_adaptive = false;
+    g_autoptr(GOptionContext) context = NULL;
+    GOptionEntry entries[] = {
+        { "dbus-address", 'a', 0, G_OPTION_ARG_STRING, &dbus_address,
+          "D-Bus address to connect to (default: session bus)", "ADDRESS" },
+        { "dbus-p2p-fd", 'p', 0, G_OPTION_ARG_INT, &dbus_p2p_fd,
+          "D-Bus peer-to-peer socket file descriptor", "FD" },
+        { "bus-name", 'n', 0, G_OPTION_ARG_STRING, &bus_name,
+          "D-Bus bus name (default: org.qemu)", "NAME" },
+       { "vnc-addr", 'l', 0, G_OPTION_ARG_STRING, &vnc_addr,
+          "VNC display address (default localhost:0)", "ADDR" },
+        { "websocket", 'w', 0, G_OPTION_ARG_STRING, &ws_addr,
+          "WebSocket address (e.g. port number or addr:port)", "ADDR" },
+        { "share", 's', 0, G_OPTION_ARG_STRING, &share,
+          "Display sharing policy "
+          "(allow-exclusive|force-shared|ignore)", "POLICY" },
+        { "tls-creds", 't', 0, G_OPTION_ARG_STRING, &tls_creds_dir,
+          "TLS x509 credentials directory", "DIR" },
+        { "vt-chardev", 'C', 0, G_OPTION_ARG_STRING_ARRAY, &chardev_names,
+          "Chardev type names to expose as text console (repeatable, "
+          "default: serial & hmp)", "NAME" },
+        { "no-vt", 'N', 0, G_OPTION_ARG_NONE, &no_vt,
+          "Do not expose any chardevs as text consoles", NULL },
+        { "keyboard-layout", 'k', 0, G_OPTION_ARG_STRING, &keyboard_layout,
+          "Keyboard layout", "LAYOUT" },
+        { "trace", 'T', 0, G_OPTION_ARG_STRING, &trace_opt,
+          "Trace options (same as QEMU -trace)", "PATTERN" },
+        { "version", 'V', 0, G_OPTION_ARG_NONE, &show_version,
+          "Print version information and exit", NULL },
+        { "password", 0, 0, G_OPTION_ARG_NONE, &password,
+          "Require password authentication (use D-Bus SetPassword to set)",
+          NULL },
+        { "lossy", 0, 0, G_OPTION_ARG_NONE, &lossy,
+          "Enable lossy compression", NULL },
+        { "non-adaptive", 0, 0, G_OPTION_ARG_NONE, &non_adaptive,
+          "Disable adaptive encodings", NULL },
+        { NULL }
+    };
+
+    qemu_init_exec_dir(argv[0]);
+    qemu_add_data_dir(get_relocated_path(CONFIG_QEMU_DATADIR));
+
+    module_call_init(MODULE_INIT_TRACE);
+    module_call_init(MODULE_INIT_QOM);
+    module_call_init(MODULE_INIT_OPTS);
+    qemu_add_opts(&qemu_trace_opts);
+
+    context = g_option_context_new("- standalone VNC server for QEMU");
+    g_option_context_add_main_entries(context, entries, NULL);
+    if (!g_option_context_parse(context, &argc, &argv, &err)) {
+        error_report("Option parsing failed: %s", err->message);
+        return 1;
+    }
+
+    if (show_version) {
+        printf("qemu-vnc " QEMU_FULL_VERSION "\n");
+        return 0;
+    }
+
+    if (trace_opt) {
+        trace_opt_parse(trace_opt);
+        qemu_set_log(LOG_TRACE, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            return 1;
+        }
+    }
+    trace_init_file();
+
+    if (qemu_init_main_loop(&local_err)) {
+        error_report_err(local_err);
+        return 1;
+    }
+
+    if (!vnc_addr) {
+        vnc_addr = g_strdup("localhost:0");
+    }
+
+    if (dbus_p2p_fd >= 0 && dbus_address) {
+        error_report("--dbus-p2p-fd and --dbus-address are"
+                     " mutually exclusive");
+        return 1;
+    }
+
+    if (dbus_p2p_fd >= 0) {
+        g_autoptr(GSocket) socket = NULL;
+        g_autoptr(GSocketConnection) socketc = NULL;
+
+        if (bus_name) {
+            error_report("--bus-name is not supported with --dbus-p2p-fd");
+            return 1;
+        }
+
+        socket = g_socket_new_from_fd(dbus_p2p_fd, &err);
+        if (!socket) {
+            error_report("Failed to create socket from fd %d: %s",
+                         dbus_p2p_fd, err->message);
+            return 1;
+        }
+
+        socketc = g_socket_connection_factory_create_connection(socket);
+        if (!socketc) {
+            error_report("Failed to create socket connection");
+            return 1;
+        }
+
+        bus = g_dbus_connection_new_sync(
+            G_IO_STREAM(socketc), NULL,
+            G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_CLIENT,
+            NULL, NULL, &err);
+    } else if (dbus_address) {
+        GDBusConnectionFlags flags =
+            G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_CLIENT;
+        if (bus_name) {
+            flags |= G_DBUS_CONNECTION_FLAGS_MESSAGE_BUS_CONNECTION;
+        }
+        bus = g_dbus_connection_new_for_address_sync(
+            dbus_address, flags, NULL, NULL, &err);
+    } else {
+        bus = g_bus_get_sync(G_BUS_TYPE_SESSION, NULL, &err);
+        if (!bus_name) {
+            bus_name = g_strdup("org.qemu");
+        }
+    }
+    if (!bus) {
+        error_report("Failed to connect to D-Bus: %s", err->message);
+        return 1;
+    }
+
+    {
+        g_autoptr(QemuDBusDisplay1VMProxy) vm_proxy = QEMU_DBUS_DISPLAY1_VM_PROXY(
+            qemu_dbus_display1_vm_proxy_new_sync(
+                bus, G_DBUS_PROXY_FLAGS_NONE, bus_name,
+                DBUS_DISPLAY1_ROOT "/VM", NULL, &err));
+        if (vm_proxy) {
+            qemu_name = g_strdup(qemu_dbus_display1_vm_get_name(
+                QEMU_DBUS_DISPLAY1_VM(vm_proxy)));
+        }
+    }
+
+    /*
+     * Set up TLS credentials if requested.  The object must exist
+     * before vnc_display_open() which looks it up by ID.
+     */
+    if (tls_creds_dir) {
+        if (!object_new_with_props(TYPE_QCRYPTO_TLS_CREDS_X509,
+                                   object_get_objects_root(),
+                                   "tlscreds0",
+                                   &local_err,
+                                   "endpoint", "server",
+                                   "dir", tls_creds_dir,
+                                   "verify-peer", "no",
+                                   NULL)) {
+            error_report_err(local_err);
+            return 1;
+        }
+    }
+
+    /*
+     * Check for systemd credentials: if a vnc-password credential
+     * file exists, create a QCryptoSecret and enable VNC password auth.
+     */
+    creds_dir = g_getenv("CREDENTIALS_DIRECTORY");
+    if (creds_dir) {
+        g_autofree char *password_path =
+            g_build_filename(creds_dir, "vnc-password", NULL);
+        if (g_file_test(password_path, G_FILE_TEST_EXISTS)) {
+            if (!object_new_with_props(TYPE_QCRYPTO_SECRET,
+                                       object_get_objects_root(),
+                                       "vncsecret0",
+                                       &local_err,
+                                       "file", password_path,
+                                       NULL)) {
+                error_report_err(local_err);
+                return 1;
+            }
+            has_vnc_password = true;
+        }
+    }
+
+    {
+        g_autoptr(GString) vnc_opts = g_string_new(vnc_addr);
+        QemuOptsList *olist = qemu_find_opts("vnc");
+        QemuOpts *opts;
+
+        if (tls_creds_dir) {
+            g_string_append(vnc_opts, ",tls-creds=tlscreds0");
+        }
+        if (has_vnc_password) {
+            g_string_append(vnc_opts, ",password-secret=vncsecret0");
+        }
+        if (ws_addr) {
+            g_string_append_printf(vnc_opts, ",websocket=%s", ws_addr);
+        }
+        if (share) {
+            g_string_append_printf(vnc_opts, ",share=%s", share);
+        }
+        if (password && !has_vnc_password) {
+            g_string_append(vnc_opts, ",password=on");
+        }
+        if (lossy) {
+            g_string_append(vnc_opts, ",lossy=on");
+        }
+        if (non_adaptive) {
+            g_string_append(vnc_opts, ",non-adaptive=on");
+        }
+
+        opts = qemu_opts_parse_noisily(olist, vnc_opts->str, true);
+        if (!opts) {
+            return 1;
+        }
+        qemu_opts_set_id(opts, g_strdup("default"));
+    }
+
+    {
+        ManagerSetupData *mgr_data = g_new0(ManagerSetupData, 1);
+        mgr_data->bus = bus;
+        mgr_data->bus_name = bus_name;
+        mgr_data->chardev_names = (const char * const *)chardev_names;
+        mgr_data->no_vt = no_vt;
+
+        g_dbus_object_manager_client_new(
+            bus, G_DBUS_OBJECT_MANAGER_CLIENT_FLAGS_NONE,
+            bus_name, DBUS_DISPLAY1_ROOT,
+            dbus_display_get_proxy_type,
+            NULL, NULL, NULL,
+            on_manager_ready, mgr_data);
+    }
+
+    g_signal_connect(bus, "closed", G_CALLBACK(on_bus_closed), NULL);
+
+    if (bus_name) {
+        g_bus_watch_name_on_connection(bus, bus_name,
+                                       G_BUS_NAME_WATCHER_FLAGS_NONE,
+                                       NULL, on_owner_vanished,
+                                       NULL, NULL);
+    }
+
+    while (!terminate) {
+        main_loop_wait(false);
+    }
+
+    vnc_dbus_cleanup();
+    vnc_display_free(vd);
+
+    return 0;
+}
diff --git a/contrib/qemu-vnc/stubs.c b/contrib/qemu-vnc/stubs.c
new file mode 100644
index 00000000000..4a6332ba580
--- /dev/null
+++ b/contrib/qemu-vnc/stubs.c
@@ -0,0 +1,66 @@
+/*
+ * Stubs for qemu-vnc standalone binary.
+ *
+ * These provide dummy implementations of QEMU subsystem functions
+ * that the VNC code references but which are not needed (yet) for the
+ * standalone VNC server.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "system/runstate.h"
+#include "hw/core/qdev.h"
+#include "monitor/monitor.h"
+#include "migration/vmstate.h"
+
+bool runstate_is_running(void)
+{
+    return true;
+}
+
+bool phase_check(MachineInitPhase phase)
+{
+    return true;
+}
+
+DeviceState *qdev_find_recursive(BusState *bus, const char *id)
+{
+    return NULL;
+}
+
+/*
+ * Provide the monitor stubs locally so that the linker does not
+ * pull stubs/monitor-core.c.o from libqemuutil.a (which would
+ * bring a conflicting qapi_event_emit definition).
+ */
+Monitor *monitor_cur(void)
+{
+    return NULL;
+}
+
+bool monitor_cur_is_qmp(void)
+{
+    return false;
+}
+
+Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
+{
+    return NULL;
+}
+
+int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
+{
+    return -1;
+}
+
+/*
+ * Link-time stubs for VMState symbols referenced by VNC code.
+ * The standalone binary never performs migration, so these are
+ * never actually used at runtime.
+ */
+const VMStateInfo vmstate_info_bool = {};
+const VMStateInfo vmstate_info_int32 = {};
+const VMStateInfo vmstate_info_uint32 = {};
+const VMStateInfo vmstate_info_buffer = {};
diff --git a/contrib/qemu-vnc/utils.c b/contrib/qemu-vnc/utils.c
new file mode 100644
index 00000000000..d261aa9eaf0
--- /dev/null
+++ b/contrib/qemu-vnc/utils.c
@@ -0,0 +1,59 @@
+/*
+ * Standalone VNC server connecting to QEMU via D-Bus display interface.
+ *
+ * Copyright (C) 2026 Red Hat, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu/error-report.h"
+#include "qemu-vnc.h"
+
+static GDBusConnection *
+dbus_p2p_from_fd(int fd)
+{
+    g_autoptr(GError) err = NULL;
+    g_autoptr(GSocket) socket = NULL;
+    g_autoptr(GSocketConnection) socketc = NULL;
+    GDBusConnection *conn;
+
+    socket = g_socket_new_from_fd(fd, &err);
+    if (!socket) {
+        error_report("Failed to create socket: %s", err->message);
+        return NULL;
+    }
+
+    socketc = g_socket_connection_factory_create_connection(socket);
+    if (!socketc) {
+        error_report("Failed to create socket connection");
+        return NULL;
+    }
+
+    conn = g_dbus_connection_new_sync(
+        G_IO_STREAM(socketc), NULL,
+        G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_CLIENT |
+        G_DBUS_CONNECTION_FLAGS_DELAY_MESSAGE_PROCESSING,
+        NULL, NULL, &err);
+    if (!conn) {
+        error_report("Failed to create D-Bus connection: %s", err->message);
+        return NULL;
+    }
+
+    return conn;
+}
+
+static gpointer
+p2p_server_setup_thread(gpointer data)
+{
+    return dbus_p2p_from_fd(GPOINTER_TO_INT(data));
+}
+
+GThread *
+p2p_dbus_thread_new(int fd)
+{
+    return g_thread_new("p2p-server-setup",
+                         p2p_server_setup_thread,
+                         GINT_TO_POINTER(fd));
+}
diff --git a/tests/qtest/dbus-vnc-test.c b/tests/qtest/dbus-vnc-test.c
new file mode 100644
index 00000000000..19d48ad49b4
--- /dev/null
+++ b/tests/qtest/dbus-vnc-test.c
@@ -0,0 +1,733 @@
+/*
+ * D-Bus VNC server (qemu-vnc) end-to-end test
+ *
+ * Starts QEMU with D-Bus display, connects qemu-vnc via p2p,
+ * then verifies a gvnc client can connect and read the VM name.
+ *
+ * Copyright (c) 2026 Red Hat, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include <gio/gio.h>
+#include <gvnc.h>
+#include <sys/un.h>
+#include "qemu/sockets.h"
+#include "libqtest.h"
+#include "qemu-vnc1.h"
+
+typedef struct Test {
+    QTestState *qts;
+    GSubprocess *vnc_subprocess;
+    VncConnection *conn;
+    GMainLoop *loop;
+    char *vnc_sock_path;
+    char *tmp_dir;
+} Test;
+
+typedef struct DbusTest {
+    QTestState *qts;
+    GSubprocess *vnc_subprocess;
+    GTestDBus *bus;
+    GDBusConnection *bus_conn;
+    GMainLoop *loop;
+    char *vnc_sock_path;
+    char *tmp_dir;
+    char *bus_addr;
+} DbusTest;
+
+typedef struct LifecycleData {
+    DbusTest *dt;
+    QemuVnc1Server *server_proxy;
+    VncConnection *conn;
+    char *client_path;
+    gboolean got_connected;
+    gboolean got_initialized;
+    gboolean got_disconnected;
+} LifecycleData;
+
+static void
+on_vnc_error(VncConnection *self, const char *msg)
+{
+    g_error("vnc-error: %s", msg);
+}
+
+static void
+on_vnc_auth_failure(VncConnection *self, const char *msg)
+{
+    g_error("vnc-auth-failure: %s", msg);
+}
+
+static void
+on_vnc_initialized(VncConnection *self, Test *test)
+{
+    const char *name = vnc_connection_get_name(test->conn);
+
+    g_assert_cmpstr(name, ==, "QEMU (dbus-vnc-test)");
+    g_main_loop_quit(test->loop);
+}
+
+static gboolean
+timeout_cb(gpointer data)
+{
+    g_error("test timed out");
+    return G_SOURCE_REMOVE;
+}
+
+static int
+connect_unix_socket(const char *path)
+{
+    int fd;
+    struct sockaddr_un addr = { .sun_family = AF_UNIX };
+
+    fd = socket(AF_UNIX, SOCK_STREAM, 0);
+    g_assert(fd >= 0);
+
+    snprintf(addr.sun_path, sizeof(addr.sun_path), "%s", path);
+
+    if (connect(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
+        close(fd);
+        return -1;
+    }
+    return fd;
+}
+
+static bool
+wait_for_vnc_socket(const char *path, int timeout_ms)
+{
+    int elapsed = 0;
+    const int interval = 50;
+
+    while (elapsed < timeout_ms) {
+        int fd = connect_unix_socket(path);
+
+        if (fd >= 0) {
+            close(fd);
+            return true;
+        }
+
+        g_usleep(interval * 1000);
+        elapsed += interval;
+    }
+    return false;
+}
+
+static GSubprocess *
+spawn_qemu_vnc(int dbus_fd, const char *sock_path)
+{
+    const char *binary;
+    g_autoptr(GError) err = NULL;
+    g_autoptr(GSubprocessLauncher) launcher = NULL;
+    GSubprocess *proc;
+    g_autofree char *fd_str = NULL;
+    g_autofree char *vnc_addr = NULL;
+
+    binary = g_getenv("QTEST_QEMU_VNC_BINARY");
+    g_assert(binary != NULL);
+
+    fd_str = g_strdup_printf("%d", dbus_fd);
+    vnc_addr = g_strdup_printf("unix:%s", sock_path);
+
+    launcher = g_subprocess_launcher_new(G_SUBPROCESS_FLAGS_NONE);
+    g_subprocess_launcher_take_fd(launcher, dbus_fd, dbus_fd);
+
+    proc = g_subprocess_launcher_spawn(launcher, &err,
+                                       binary,
+                                       "--dbus-p2p-fd", fd_str,
+                                       "--vnc-addr", vnc_addr,
+                                       NULL);
+    g_assert_no_error(err);
+    g_assert(proc != NULL);
+
+    return proc;
+}
+
+static GSubprocess *
+spawn_qemu_vnc_bus_full(const char *dbus_addr, const char *sock_path,
+                        const char *const *extra_args)
+{
+    const char *binary;
+    g_autoptr(GError) err = NULL;
+    g_autoptr(GSubprocessLauncher) launcher = NULL;
+    g_autoptr(GPtrArray) argv = NULL;
+    GSubprocess *proc;
+    g_autofree char *vnc_addr = NULL;
+
+    binary = g_getenv("QTEST_QEMU_VNC_BINARY");
+    g_assert(binary != NULL);
+
+    vnc_addr = g_strdup_printf("unix:%s", sock_path);
+
+    argv = g_ptr_array_new();
+    g_ptr_array_add(argv, (gpointer)binary);
+    g_ptr_array_add(argv, (gpointer)"--dbus-address");
+    g_ptr_array_add(argv, (gpointer)dbus_addr);
+    g_ptr_array_add(argv, (gpointer)"--bus-name");
+    g_ptr_array_add(argv, (gpointer)"org.qemu");
+    g_ptr_array_add(argv, (gpointer)"--vnc-addr");
+    g_ptr_array_add(argv, (gpointer)vnc_addr);
+
+    if (extra_args) {
+        for (int i = 0; extra_args[i]; i++) {
+            g_ptr_array_add(argv, (gpointer)extra_args[i]);
+        }
+    }
+
+    g_ptr_array_add(argv, NULL);
+
+    launcher = g_subprocess_launcher_new(G_SUBPROCESS_FLAGS_NONE);
+    proc = g_subprocess_launcher_spawnv(launcher, (const char *const *)argv->pdata, &err);
+    g_assert_no_error(err);
+    g_assert(proc != NULL);
+
+    return proc;
+}
+
+
+static void
+name_appeared_cb(GDBusConnection *connection,
+                 const gchar *name,
+                 const gchar *name_owner,
+                 gpointer user_data)
+{
+    gboolean *appeared = user_data;
+    *appeared = TRUE;
+}
+
+static bool
+setup_dbus_test_full(DbusTest *dt, const char *const *vnc_extra_args)
+{
+    g_autoptr(GError) err = NULL;
+    g_auto(GStrv) addr_parts = NULL;
+    g_autofree char *qemu_args = NULL;
+
+    if (!g_getenv("QTEST_QEMU_VNC_BINARY")) {
+        g_test_skip("QTEST_QEMU_VNC_BINARY not set");
+        return false;
+    }
+
+    dt->bus = g_test_dbus_new(G_TEST_DBUS_NONE);
+    g_test_dbus_up(dt->bus);
+
+    /* remove ,guid=foo part */
+    addr_parts = g_strsplit(g_test_dbus_get_bus_address(dt->bus), ",", 2);
+    dt->bus_addr = g_strdup(addr_parts[0]);
+
+    dt->bus_conn = g_dbus_connection_new_for_address_sync(
+        g_test_dbus_get_bus_address(dt->bus),
+        G_DBUS_CONNECTION_FLAGS_AUTHENTICATION_CLIENT |
+        G_DBUS_CONNECTION_FLAGS_MESSAGE_BUS_CONNECTION,
+        NULL, NULL, &err);
+    g_assert_no_error(err);
+
+    qemu_args = g_strdup_printf("-display dbus,addr=%s "
+                                "-name dbus-vnc-test", dt->bus_addr);
+    dt->qts = qtest_init(qemu_args);
+
+    dt->tmp_dir = g_dir_make_tmp("dbus-vnc-test-XXXXXX", NULL);
+    g_assert(dt->tmp_dir != NULL);
+    dt->vnc_sock_path = g_build_filename(dt->tmp_dir, "vnc.sock", NULL);
+    dt->vnc_subprocess = spawn_qemu_vnc_bus_full(dt->bus_addr,
+                                                 dt->vnc_sock_path,
+                                                 vnc_extra_args);
+
+    /*
+     * Wait for the org.qemu.vnc bus name to appear, which indicates
+     * qemu-vnc has fully initialized (connected to QEMU, set up the
+     * display, exported its D-Bus interfaces, and opened the VNC
+     * socket).
+     */
+    {
+        guint watch_id, timeout_id;
+        gboolean appeared = FALSE;
+
+        watch_id = g_bus_watch_name_on_connection(
+            dt->bus_conn, "org.qemu.vnc",
+            G_BUS_NAME_WATCHER_FLAGS_NONE,
+            name_appeared_cb, NULL, &appeared, NULL);
+        timeout_id = g_timeout_add_seconds(10, timeout_cb, NULL);
+
+        while (!appeared &&
+               g_main_context_iteration(NULL, TRUE)) {
+            /* spin until name appears or timeout fires */
+        }
+
+        g_bus_unwatch_name(watch_id);
+        g_source_remove(timeout_id);
+
+        if (!appeared) {
+            g_test_fail();
+            g_test_message("Timed out waiting for org.qemu.vnc bus name");
+            return false;
+        }
+    }
+
+    return true;
+}
+
+static bool
+setup_dbus_test(DbusTest *dt)
+{
+    return setup_dbus_test_full(dt, NULL);
+}
+
+static void
+cleanup_dbus_test(DbusTest *dt)
+{
+    if (dt->bus_conn) {
+        g_dbus_connection_close_sync(dt->bus_conn, NULL, NULL);
+        g_object_unref(dt->bus_conn);
+    }
+    if (dt->vnc_subprocess) {
+        g_subprocess_force_exit(dt->vnc_subprocess);
+        g_subprocess_wait(dt->vnc_subprocess, NULL, NULL);
+        g_object_unref(dt->vnc_subprocess);
+    }
+    if (dt->vnc_sock_path) {
+        unlink(dt->vnc_sock_path);
+        g_free(dt->vnc_sock_path);
+    }
+    if (dt->tmp_dir) {
+        rmdir(dt->tmp_dir);
+        g_free(dt->tmp_dir);
+    }
+    if (dt->qts) {
+        qtest_quit(dt->qts);
+    }
+    if (dt->bus) {
+        g_test_dbus_down(dt->bus);
+        g_object_unref(dt->bus);
+    }
+    g_free(dt->bus_addr);
+}
+
+static void
+test_dbus_vnc_basic(void)
+{
+    Test test = { 0 };
+    int pair[2];
+    int vnc_fd;
+    guint timeout_id;
+
+    if (!g_getenv("QTEST_QEMU_VNC_BINARY")) {
+        g_test_skip("QTEST_QEMU_VNC_BINARY not set");
+        return;
+    }
+
+    test.qts = qtest_init("-display dbus,p2p=yes -name dbus-vnc-test");
+
+    g_assert_cmpint(qemu_socketpair(AF_UNIX, SOCK_STREAM, 0, pair), ==, 0);
+    qtest_qmp_add_client(test.qts, "@dbus-display", pair[1]);
+    close(pair[1]);
+
+    test.tmp_dir = g_dir_make_tmp("dbus-vnc-test-XXXXXX", NULL);
+    g_assert(test.tmp_dir != NULL);
+    test.vnc_sock_path = g_build_filename(test.tmp_dir, "vnc.sock", NULL);
+
+    test.vnc_subprocess = spawn_qemu_vnc(pair[0], test.vnc_sock_path);
+
+    if (!wait_for_vnc_socket(test.vnc_sock_path, 10000)) {
+        g_test_fail();
+        g_test_message("Timed out waiting for qemu-vnc socket");
+        goto cleanup;
+    }
+
+    vnc_fd = connect_unix_socket(test.vnc_sock_path);
+    g_assert(vnc_fd >= 0);
+
+    test.conn = vnc_connection_new();
+    g_signal_connect(test.conn, "vnc-error",
+                     G_CALLBACK(on_vnc_error), NULL);
+    g_signal_connect(test.conn, "vnc-auth-failure",
+                     G_CALLBACK(on_vnc_auth_failure), NULL);
+    g_signal_connect(test.conn, "vnc-initialized",
+                     G_CALLBACK(on_vnc_initialized), &test);
+    vnc_connection_set_auth_type(test.conn, VNC_CONNECTION_AUTH_NONE);
+    vnc_connection_open_fd(test.conn, vnc_fd);
+
+    test.loop = g_main_loop_new(NULL, FALSE);
+    timeout_id = g_timeout_add_seconds(10, timeout_cb, NULL);
+    g_main_loop_run(test.loop);
+    g_source_remove(timeout_id);
+
+cleanup:
+    if (test.conn) {
+        vnc_connection_shutdown(test.conn);
+        g_signal_handlers_disconnect_by_data(test.conn, NULL);
+        g_object_unref(test.conn);
+    }
+    if (test.loop) {
+        g_main_loop_unref(test.loop);
+    }
+    if (test.vnc_subprocess) {
+        g_subprocess_force_exit(test.vnc_subprocess);
+        g_subprocess_wait(test.vnc_subprocess, NULL, NULL);
+        g_object_unref(test.vnc_subprocess);
+    }
+    if (test.vnc_sock_path) {
+        unlink(test.vnc_sock_path);
+        g_free(test.vnc_sock_path);
+    }
+    if (test.tmp_dir) {
+        rmdir(test.tmp_dir);
+        g_free(test.tmp_dir);
+    }
+    qtest_quit(test.qts);
+}
+
+static void
+test_dbus_vnc_server_props(void)
+{
+    DbusTest dt = { 0 };
+    QemuVnc1Server *proxy = NULL;
+    g_autoptr(GError) err = NULL;
+    const gchar *const *clients;
+    GVariant *listeners;
+
+    if (!setup_dbus_test(&dt)) {
+        goto cleanup;
+    }
+
+    proxy = qemu_vnc1_server_proxy_new_sync(
+        dt.bus_conn,
+        G_DBUS_PROXY_FLAGS_NONE,
+        "org.qemu.vnc",
+        "/org/qemu/Vnc1/Server",
+        NULL, &err);
+    g_assert_no_error(err);
+    g_assert(proxy != NULL);
+
+    g_assert_cmpstr(qemu_vnc1_server_get_name(proxy), ==,
+                    "dbus-vnc-test");
+    g_assert_cmpstr(qemu_vnc1_server_get_auth(proxy), ==,
+                    "none");
+    g_assert_cmpstr(qemu_vnc1_server_get_vencrypt_sub_auth(proxy), ==,
+                    "");
+
+    clients = qemu_vnc1_server_get_clients(proxy);
+    g_assert_nonnull(clients);
+    g_assert_cmpint(g_strv_length((gchar **)clients), ==, 0);
+
+    listeners = qemu_vnc1_server_get_listeners(proxy);
+    g_assert_nonnull(listeners);
+    g_assert_cmpint(g_variant_n_children(listeners), >, 0);
+
+cleanup:
+    g_clear_object(&proxy);
+    cleanup_dbus_test(&dt);
+}
+
+static void
+on_client_connected(QemuVnc1Server *proxy,
+                    const gchar *client_path,
+                    LifecycleData *data)
+{
+    data->got_connected = TRUE;
+    data->client_path = g_strdup(client_path);
+}
+
+static void
+on_lifecycle_vnc_initialized(VncConnection *self, LifecycleData *data)
+{
+    /* VNC handshake done, wait for ClientInitialized D-Bus signal */
+}
+
+static void
+on_client_initialized(QemuVnc1Server *proxy,
+                      const gchar *client_path,
+                      LifecycleData *data)
+{
+    data->got_initialized = TRUE;
+    g_main_loop_quit(data->dt->loop);
+}
+
+static void
+on_client_disconnected(QemuVnc1Server *proxy,
+                       const gchar *client_path,
+                       LifecycleData *data)
+{
+    data->got_disconnected = TRUE;
+    g_main_loop_quit(data->dt->loop);
+}
+
+static void
+test_dbus_vnc_client_lifecycle(void)
+{
+    DbusTest dt = { 0 };
+    QemuVnc1Server *server_proxy = NULL;
+    QemuVnc1Client *client_proxy = NULL;
+    g_autoptr(GError) err = NULL;
+    LifecycleData ldata = { 0 };
+    int vnc_fd;
+    guint timeout_id;
+
+    if (!setup_dbus_test(&dt)) {
+        goto cleanup;
+    }
+
+    server_proxy = qemu_vnc1_server_proxy_new_sync(
+        dt.bus_conn,
+        G_DBUS_PROXY_FLAGS_NONE,
+        "org.qemu.vnc",
+        "/org/qemu/Vnc1/Server",
+        NULL, &err);
+    g_assert_no_error(err);
+
+    ldata.dt = &dt;
+    ldata.server_proxy = server_proxy;
+
+    g_signal_connect(server_proxy, "client-connected",
+                     G_CALLBACK(on_client_connected), &ldata);
+    g_signal_connect(server_proxy, "client-initialized",
+                     G_CALLBACK(on_client_initialized), &ldata);
+    g_signal_connect(server_proxy, "client-disconnected",
+                     G_CALLBACK(on_client_disconnected), &ldata);
+
+    vnc_fd = connect_unix_socket(dt.vnc_sock_path);
+    g_assert(vnc_fd >= 0);
+
+    ldata.conn = vnc_connection_new();
+    g_signal_connect(ldata.conn, "vnc-error",
+                     G_CALLBACK(on_vnc_error), NULL);
+    g_signal_connect(ldata.conn, "vnc-auth-failure",
+                     G_CALLBACK(on_vnc_auth_failure), NULL);
+    g_signal_connect(ldata.conn, "vnc-initialized",
+                     G_CALLBACK(on_lifecycle_vnc_initialized), &ldata);
+    vnc_connection_set_auth_type(ldata.conn, VNC_CONNECTION_AUTH_NONE);
+    vnc_connection_open_fd(ldata.conn, vnc_fd);
+
+    /* Phase 1: wait for ClientInitialized */
+    dt.loop = g_main_loop_new(NULL, FALSE);
+    timeout_id = g_timeout_add_seconds(10, timeout_cb, NULL);
+    g_main_loop_run(dt.loop);
+    g_source_remove(timeout_id);
+
+    g_assert_true(ldata.got_connected);
+    g_assert_true(ldata.got_initialized);
+    g_assert_nonnull(ldata.client_path);
+
+    /* Check client properties while still connected */
+    client_proxy = qemu_vnc1_client_proxy_new_sync(
+        dt.bus_conn,
+        G_DBUS_PROXY_FLAGS_NONE,
+        "org.qemu.vnc",
+        ldata.client_path,
+        NULL, &err);
+    g_assert_no_error(err);
+
+    g_assert_cmpstr(qemu_vnc1_client_get_family(client_proxy), ==,
+                    "unix");
+    g_assert_false(qemu_vnc1_client_get_web_socket(client_proxy));
+    g_assert_cmpstr(qemu_vnc1_client_get_x509_dname(client_proxy), ==,
+                    "");
+    g_assert_cmpstr(qemu_vnc1_client_get_sasl_username(client_proxy),
+                    ==, "");
+
+    /* Phase 2: disconnect and wait for ClientDisconnected */
+    vnc_connection_shutdown(ldata.conn);
+    timeout_id = g_timeout_add_seconds(10, timeout_cb, NULL);
+    g_main_loop_run(dt.loop);
+    g_source_remove(timeout_id);
+
+    g_assert_true(ldata.got_disconnected);
+
+    g_object_unref(ldata.conn);
+    g_main_loop_unref(dt.loop);
+    dt.loop = NULL;
+    g_free(ldata.client_path);
+
+cleanup:
+    g_clear_object(&server_proxy);
+    g_clear_object(&client_proxy);
+    cleanup_dbus_test(&dt);
+}
+
+static void
+test_dbus_vnc_no_password(void)
+{
+    DbusTest dt = { 0 };
+    QemuVnc1Server *proxy = NULL;
+    g_autoptr(GError) err = NULL;
+    gboolean ret;
+
+    if (!setup_dbus_test(&dt)) {
+        goto cleanup;
+    }
+
+    proxy = qemu_vnc1_server_proxy_new_sync(
+        dt.bus_conn,
+        G_DBUS_PROXY_FLAGS_NONE,
+        "org.qemu.vnc",
+        "/org/qemu/Vnc1/Server",
+        NULL, &err);
+    g_assert_no_error(err);
+
+    /*
+     * With default auth=none, SetPassword should return an error
+     * because VNC password authentication is not enabled.
+     */
+    ret = qemu_vnc1_server_call_set_password_sync(
+        proxy, "secret",
+        G_DBUS_CALL_FLAGS_NONE, -1, NULL, &err);
+    g_assert_false(ret);
+    g_assert_error(err, G_DBUS_ERROR, G_DBUS_ERROR_FAILED);
+    g_clear_error(&err);
+
+    /*
+     * ExpirePassword succeeds even without password auth —
+     * it just sets the expiry timestamp.
+     */
+    ret = qemu_vnc1_server_call_expire_password_sync(
+        proxy, "never",
+        G_DBUS_CALL_FLAGS_NONE, -1, NULL, &err);
+    g_assert_no_error(err);
+    g_assert_true(ret);
+
+    ret = qemu_vnc1_server_call_expire_password_sync(
+        proxy, "+3600",
+        G_DBUS_CALL_FLAGS_NONE, -1, NULL, &err);
+    g_assert_no_error(err);
+    g_assert_true(ret);
+
+cleanup:
+    g_clear_object(&proxy);
+    cleanup_dbus_test(&dt);
+}
+
+typedef struct PasswordData {
+    DbusTest *dt;
+    VncConnection *conn;
+    const char *password;
+    gboolean auth_succeeded;
+    gboolean auth_failed;
+} PasswordData;
+
+G_GNUC_BEGIN_IGNORE_DEPRECATIONS
+static void
+on_pw_vnc_auth_credential(VncConnection *conn, GValueArray *creds,
+                          PasswordData *data)
+{
+    for (guint i = 0; i < creds->n_values; i++) {
+        int type = g_value_get_enum(g_value_array_get_nth(creds, i));
+
+        if (type == VNC_CONNECTION_CREDENTIAL_PASSWORD) {
+            vnc_connection_set_credential(conn, type, data->password);
+        }
+    }
+}
+G_GNUC_END_IGNORE_DEPRECATIONS
+
+static void
+on_pw_vnc_initialized(VncConnection *conn, PasswordData *data)
+{
+    data->auth_succeeded = TRUE;
+    g_main_loop_quit(data->dt->loop);
+}
+
+static void
+on_pw_vnc_auth_failure(VncConnection *conn, const char *msg,
+                       PasswordData *data)
+{
+    data->auth_failed = TRUE;
+    g_main_loop_quit(data->dt->loop);
+}
+
+static void
+on_pw_vnc_error(VncConnection *conn, const char *msg,
+                PasswordData *data)
+{
+    data->auth_failed = TRUE;
+    g_main_loop_quit(data->dt->loop);
+}
+
+static void
+test_dbus_vnc_password_auth(void)
+{
+    DbusTest dt = { 0 };
+    QemuVnc1Server *proxy = NULL;
+    g_autoptr(GError) err = NULL;
+    PasswordData pdata = { 0 };
+    const char *extra_args[] = { "--password", NULL };
+    int vnc_fd;
+    guint timeout_id;
+    gboolean ret;
+
+    if (!setup_dbus_test_full(&dt, extra_args)) {
+        goto cleanup;
+    }
+
+    proxy = qemu_vnc1_server_proxy_new_sync(
+        dt.bus_conn,
+        G_DBUS_PROXY_FLAGS_NONE,
+        "org.qemu.vnc",
+        "/org/qemu/Vnc1/Server",
+        NULL, &err);
+    g_assert_no_error(err);
+
+    /* Verify auth type is "vnc" when --password is used */
+    g_assert_cmpstr(qemu_vnc1_server_get_auth(proxy), ==, "vnc");
+
+    /* Set password via D-Bus — should succeed with --password */
+    ret = qemu_vnc1_server_call_set_password_sync(
+        proxy, "testpass123",
+        G_DBUS_CALL_FLAGS_NONE, -1, NULL, &err);
+    g_assert_no_error(err);
+    g_assert_true(ret);
+
+    /* Connect with the correct password */
+    vnc_fd = connect_unix_socket(dt.vnc_sock_path);
+    g_assert(vnc_fd >= 0);
+
+    pdata.dt = &dt;
+    pdata.password = "testpass123";
+    pdata.conn = vnc_connection_new();
+
+    g_signal_connect(pdata.conn, "vnc-error",
+                     G_CALLBACK(on_pw_vnc_error), &pdata);
+    g_signal_connect(pdata.conn, "vnc-auth-failure",
+                     G_CALLBACK(on_pw_vnc_auth_failure), &pdata);
+    g_signal_connect(pdata.conn, "vnc-auth-credential",
+                     G_CALLBACK(on_pw_vnc_auth_credential), &pdata);
+    g_signal_connect(pdata.conn, "vnc-initialized",
+                     G_CALLBACK(on_pw_vnc_initialized), &pdata);
+    vnc_connection_set_auth_type(pdata.conn, VNC_CONNECTION_AUTH_VNC);
+    vnc_connection_open_fd(pdata.conn, vnc_fd);
+
+    dt.loop = g_main_loop_new(NULL, FALSE);
+    timeout_id = g_timeout_add_seconds(10, timeout_cb, NULL);
+    g_main_loop_run(dt.loop);
+    g_source_remove(timeout_id);
+
+    g_assert_true(pdata.auth_succeeded);
+    g_assert_false(pdata.auth_failed);
+
+    vnc_connection_shutdown(pdata.conn);
+    g_object_unref(pdata.conn);
+    g_main_loop_unref(dt.loop);
+    dt.loop = NULL;
+
+cleanup:
+    g_clear_object(&proxy);
+    cleanup_dbus_test(&dt);
+}
+
+int
+main(int argc, char **argv)
+{
+    g_log_set_always_fatal(G_LOG_LEVEL_WARNING | G_LOG_LEVEL_CRITICAL);
+
+    if (getenv("GTK_VNC_DEBUG")) {
+        vnc_util_set_debug(true);
+    }
+
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/dbus-vnc/basic", test_dbus_vnc_basic);
+    qtest_add_func("/dbus-vnc/server-props", test_dbus_vnc_server_props);
+    qtest_add_func("/dbus-vnc/client-lifecycle", test_dbus_vnc_client_lifecycle);
+    qtest_add_func("/dbus-vnc/no-password", test_dbus_vnc_no_password);
+    qtest_add_func("/dbus-vnc/password-auth", test_dbus_vnc_password_auth);
+
+    return g_test_run();
+}
diff --git a/contrib/qemu-vnc/meson.build b/contrib/qemu-vnc/meson.build
new file mode 100644
index 00000000000..08168da0630
--- /dev/null
+++ b/contrib/qemu-vnc/meson.build
@@ -0,0 +1,26 @@
+vnca = vnc_ss.apply({}, strict: false)
+
+qemu_vnc1 = custom_target('qemu-vnc1 gdbus-codegen',
+                           output: ['qemu-vnc1.h', 'qemu-vnc1.c'],
+                           input: files('qemu-vnc1.xml'),
+                           command: [gdbus_codegen, '@INPUT@',
+                                     '--glib-min-required', '2.64',
+                                     '--output-directory', meson.current_build_dir(),
+                                     '--interface-prefix', 'org.qemu.',
+                                     '--c-namespace', 'Qemu',
+                                     '--generate-c-code', '@BASENAME@'])
+
+qemu_vnc = executable('qemu-vnc',
+  sources: ['qemu-vnc.c', 'display.c', 'input.c',
+            'audio.c', 'chardev.c', 'clipboard.c', 'console.c',
+            'dbus.c', 'stubs.c', 'utils.c',
+            vnca.sources(), dbus_display1, qemu_vnc1],
+  dependencies: [vnca.dependencies(), io, crypto, qemuutil, gio, ui])
+
+# The executable lives in a subdirectory of the build tree, but
+# get_relocated_path() looks for qemu-bundle relative to the binary.
+# Create a symlink so that firmware/keymap lookup works during development.
+run_command('ln', '-sfn',
+            '../../qemu-bundle',
+            meson.current_build_dir() / 'qemu-bundle',
+            check: false)
diff --git a/contrib/qemu-vnc/qemu-vnc1.xml b/contrib/qemu-vnc/qemu-vnc1.xml
new file mode 100644
index 00000000000..2037e72ae2a
--- /dev/null
+++ b/contrib/qemu-vnc/qemu-vnc1.xml
@@ -0,0 +1,174 @@
+<?xml version="1.0" encoding="utf-8"?>
+<node>
+  <!--
+      org.qemu.Vnc1.Server:
+
+      This interface is implemented on ``/org/qemu/Vnc1/Server``.
+      It provides management and monitoring of the VNC server.
+  -->
+  <interface name="org.qemu.Vnc1.Server">
+    <!--
+        Name:
+
+        The VM name.
+    -->
+    <property name="Name" type="s" access="read"/>
+
+    <!--
+        Auth:
+
+        Primary authentication method (none, vnc, vencrypt, sasl, etc.).
+    -->
+    <property name="Auth" type="s" access="read"/>
+
+    <!--
+        VencryptSubAuth:
+
+        VEncrypt sub-authentication method, if applicable.
+        Empty string otherwise.
+    -->
+    <property name="VencryptSubAuth" type="s" access="read"/>
+
+    <!--
+        Clients:
+
+        Object paths of connected VNC clients.
+    -->
+    <property name="Clients" type="ao" access="read"/>
+
+    <!--
+        Listeners:
+
+        List of listening sockets. Each entry is a dictionary with keys:
+        ``Host`` (s), ``Service`` (s), ``Family`` (s),
+        ``WebSocket`` (b), ``Auth`` (s), ``VencryptSubAuth`` (s).
+    -->
+    <property name="Listeners" type="aa{sv}" access="read"/>
+
+    <!--
+        SetPassword:
+        @password: The new VNC password.
+
+        Change the VNC password.  Existing clients are unaffected.
+    -->
+    <method name="SetPassword">
+      <arg type="s" name="password" direction="in"/>
+    </method>
+
+    <!--
+        ExpirePassword:
+        @time: Expiry specification.
+
+        Set password expiry.  Values: ``"now"``, ``"never"``,
+        ``"+N"`` (seconds from now), ``"N"`` (absolute epoch seconds).
+    -->
+    <method name="ExpirePassword">
+      <arg type="s" name="time" direction="in"/>
+    </method>
+
+    <!--
+        ReloadCertificates:
+
+        Reload TLS certificates from disk.
+    -->
+    <method name="ReloadCertificates"/>
+
+    <!--
+        ClientConnected:
+        @client: Object path of the new client.
+
+        Emitted when a VNC client TCP connection is established
+        (before authentication).
+    -->
+    <signal name="ClientConnected">
+      <arg type="o" name="client"/>
+    </signal>
+
+    <!--
+        ClientInitialized:
+        @client: Object path of the client.
+
+        Emitted when a VNC client has completed authentication
+        and is active.
+    -->
+    <signal name="ClientInitialized">
+      <arg type="o" name="client"/>
+    </signal>
+
+    <!--
+        ClientDisconnected:
+        @client: Object path of the client.
+
+        Emitted when a VNC client disconnects.
+    -->
+    <signal name="ClientDisconnected">
+      <arg type="o" name="client"/>
+    </signal>
+  </interface>
+
+  <!--
+      org.qemu.Vnc1.Client:
+
+      This interface is implemented on ``/org/qemu/Vnc1/Client_$id``.
+      It exposes information about a connected VNC client.
+  -->
+  <interface name="org.qemu.Vnc1.Client">
+    <!--
+        Host:
+
+        Client IP address.
+    -->
+    <property name="Host" type="s" access="read"/>
+
+    <!--
+        Service:
+
+        Client port or service name. This may depend on the host system’s
+        service database so symbolic names should not be relied on.
+    -->
+    <property name="Service" type="s" access="read"/>
+
+    <!--
+        Family:
+
+        Address family (ipv4, ipv6, unix).
+    -->
+    <property name="Family" type="s" access="read"/>
+
+    <!--
+        WebSocket:
+
+        Whether this is a WebSocket connection.
+    -->
+    <property name="WebSocket" type="b" access="read"/>
+
+    <!--
+        X509Dname:
+
+        X.509 distinguished name (empty if not applicable).
+    -->
+    <property name="X509Dname" type="s" access="read"/>
+
+    <!--
+        SaslUsername:
+
+        SASL username (empty if not applicable).
+    -->
+    <property name="SaslUsername" type="s" access="read"/>
+
+    <!--
+        ShutdownRequest:
+
+        Emitted when the VNC client requests a guest shutdown.
+    -->
+    <signal name="ShutdownRequest"/>
+
+    <!--
+        ResetRequest:
+
+        Emitted when the VNC client requests a guest reset.
+    -->
+    <signal name="ResetRequest"/>
+  </interface>
+
+</node>
diff --git a/contrib/qemu-vnc/trace-events b/contrib/qemu-vnc/trace-events
new file mode 100644
index 00000000000..f2d66a80986
--- /dev/null
+++ b/contrib/qemu-vnc/trace-events
@@ -0,0 +1,20 @@
+qemu_vnc_audio_out_fini(uint64_t id) "id=%" PRIu64
+qemu_vnc_audio_out_init(uint64_t id, uint32_t freq, uint8_t channels, uint8_t bits) "id=%" PRIu64 " freq=%u ch=%u bits=%u"
+qemu_vnc_audio_out_set_enabled(uint64_t id, bool enabled) "id=%" PRIu64 " enabled=%d"
+qemu_vnc_audio_out_write(uint64_t id, size_t size) "id=%" PRIu64 " size=%zu"
+qemu_vnc_chardev_connected(const char *name) "name=%s"
+qemu_vnc_clipboard_grab(int selection, uint32_t serial) "selection=%d serial=%u"
+qemu_vnc_clipboard_release(int selection) "selection=%d"
+qemu_vnc_clipboard_request(int selection) "selection=%d"
+qemu_vnc_client_not_found(const char *host, const char *service) "host=%s service=%s"
+qemu_vnc_console_io_error(const char *name) "name=%s"
+qemu_vnc_cursor_define(int width, int height, int hot_x, int hot_y) "w=%d h=%d hot=%d,%d"
+qemu_vnc_input_abs(uint32_t x, uint32_t y) "x=%u y=%u"
+qemu_vnc_input_btn(int button, bool press) "button=%d press=%d"
+qemu_vnc_input_rel(int dx, int dy) "dx=%d dy=%d"
+qemu_vnc_key_event(int qcode, bool down) "qcode=%d down=%d"
+qemu_vnc_owner_vanished(const char *name) "peer=%s"
+qemu_vnc_scanout(uint32_t width, uint32_t height, uint32_t stride, uint32_t format) "w=%u h=%u stride=%u fmt=0x%x"
+qemu_vnc_scanout_map(uint32_t width, uint32_t height, uint32_t stride, uint32_t format, uint32_t offset) "w=%u h=%u stride=%u fmt=0x%x offset=%u"
+qemu_vnc_update(int x, int y, int w, int h, uint32_t stride, uint32_t format) "x=%d y=%d w=%d h=%d stride=%u fmt=0x%x"
+qemu_vnc_update_map(uint32_t x, uint32_t y, uint32_t w, uint32_t h) "x=%u y=%u w=%u h=%u"
diff --git a/meson_options.txt b/meson_options.txt
index 31d5916cfce..ef938e74793 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -119,6 +119,8 @@ option('vfio_user_server', type: 'feature', value: 'disabled',
        description: 'vfio-user server support')
 option('dbus_display', type: 'feature', value: 'auto',
        description: '-display dbus support')
+option('qemu_vnc', type: 'feature', value: 'auto',
+       description: 'standalone VNC server over D-Bus')
 option('tpm', type : 'feature', value : 'auto',
        description: 'TPM support')
 option('valgrind', type : 'feature', value: 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index ca5b113119a..5f7a351ca4a 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -174,6 +174,7 @@ meson_options_help() {
   printf "%s\n" '  qatzip          QATzip compression support'
   printf "%s\n" '  qcow1           qcow1 image format support'
   printf "%s\n" '  qed             qed image format support'
+  printf "%s\n" '  qemu-vnc        standalone VNC server over D-Bus'
   printf "%s\n" '  qga-vss         build QGA VSS support (broken with MinGW)'
   printf "%s\n" '  qpl             Query Processing Library support'
   printf "%s\n" '  rbd             Ceph block device driver'
@@ -458,6 +459,8 @@ _meson_option_parse() {
     --qemu-ga-manufacturer=*) quote_sh "-Dqemu_ga_manufacturer=$2" ;;
     --qemu-ga-version=*) quote_sh "-Dqemu_ga_version=$2" ;;
     --with-suffix=*) quote_sh "-Dqemu_suffix=$2" ;;
+    --enable-qemu-vnc) printf "%s" -Dqemu_vnc=enabled ;;
+    --disable-qemu-vnc) printf "%s" -Dqemu_vnc=disabled ;;
     --enable-qga-vss) printf "%s" -Dqga_vss=enabled ;;
     --disable-qga-vss) printf "%s" -Dqga_vss=disabled ;;
     --enable-qom-cast-debug) printf "%s" -Dqom_cast_debug=true ;;
diff --git a/tests/dbus-daemon.sh b/tests/dbus-daemon.sh
index c4a50c73774..85f9597db43 100755
--- a/tests/dbus-daemon.sh
+++ b/tests/dbus-daemon.sh
@@ -62,9 +62,17 @@ write_config()
      <deny send_destination="org.freedesktop.DBus"
            send_interface="org.freedesktop.systemd1.Activator"/>
 
-     <allow own="org.qemu.VMState1"/>
-     <allow send_destination="org.qemu.VMState1"/>
-     <allow receive_sender="org.qemu.VMState1"/>
+    <allow own="org.qemu"/>
+    <allow send_destination="org.qemu"/>
+    <allow receive_sender="org.qemu"/>
+
+    <allow own="org.qemu.VMState1"/>
+    <allow send_destination="org.qemu.VMState1"/>
+    <allow receive_sender="org.qemu.VMState1"/>
+
+    <allow own="org.qemu.vnc"/>
+    <allow send_destination="org.qemu.vnc"/>
+    <allow receive_sender="org.qemu.vnc"/>
 
   </policy>
 
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 5f8cff172c8..0eca271abc8 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -411,6 +411,10 @@ if vnc.found()
   if gvnc.found()
     qtests += {'vnc-display-test': [gvnc, keymap_targets]}
     qtests_generic += [ 'vnc-display-test' ]
+    if have_qemu_vnc and dbus_display and config_all_devices.has_key('CONFIG_VGA')
+      qtests += {'dbus-vnc-test': [dbus_display1, qemu_vnc1, gio, gvnc, keymap_targets]}
+      qtests_x86_64 += ['dbus-vnc-test']
+    endif
   endif
 endif
 
@@ -442,6 +446,10 @@ foreach dir : target_dirs
     qtest_env.set('QTEST_QEMU_STORAGE_DAEMON_BINARY', './storage-daemon/qemu-storage-daemon')
     test_deps += [qsd]
   endif
+  if have_qemu_vnc
+    qtest_env.set('QTEST_QEMU_VNC_BINARY', './contrib/qemu-vnc/qemu-vnc')
+    test_deps += [qemu_vnc]
+  endif
 
   qtest_env.set('PYTHON', python.full_path())
 

-- 
2.53.0


