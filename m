Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16ABFCD5BD1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 04:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRjR1-0007up-Cx; Tue, 26 May 2026 00:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lb.workbox@gmail.com>)
 id 1wRjQt-0007eI-1y
 for qemu-devel@nongnu.org; Tue, 26 May 2026 00:30:23 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lb.workbox@gmail.com>)
 id 1wRjQq-0007bx-Mw
 for qemu-devel@nongnu.org; Tue, 26 May 2026 00:30:22 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49050ff7cbdso24928115e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 21:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779769819; x=1780374619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xeRRTnWnaEVO/UepoOFJKLi/LO7+Q/LxWMTun4QJ2wA=;
 b=gICVKZXwqdpgeJSEDi+hpGUIrJv7PbG/8BhYy9+QIu5O+GO721aNJWVZqB0kvuiavz
 efh9ixXtEwzQkvzAV21tRGZV5N/9CdcvU65FisLiygj0yyO5n7gF8mWhAZoklAGTFd7O
 8T/2hhtx+G0xS4dME81xs7iVR2wf+KG18nYwpZztKGsIeIo1J4lNaisVSiYBRIR4Kefh
 bsbwulyYj4UitPQb9GEwre6ygz4mKj39o4KOn2pBKtR0M7a12PT1kzpst97it1kWrbrT
 wi37kfNa7v9Fxkmtd/tKbJXQTP0ECb0px66q/Tl7EPl2Zl4dDdf5iWDdJ0FGIc59acEl
 wHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779769819; x=1780374619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xeRRTnWnaEVO/UepoOFJKLi/LO7+Q/LxWMTun4QJ2wA=;
 b=bGVA0trHcm7qssH4rdt7iKLJ3P9HAZLZXGBBnmTiit8aYV/iHDf4wIvdtUAdvy+anA
 PPrUPreCJxBvKleJlKM5CAvgfnWA869HbaoemNjlp+k7Gcht+Pb2tI07ropujVDC7JLa
 GnxU2TwvE86ufG+TowjSLj0IYFQ8f7akVbpme2VoBdmyxRyxpur/+zWe/0dvVBvoXnfW
 2H2Kt2VO2wjCYs8PZU9tYcgogLhhm6TY5HF1eaWzxYp2pQ0E0dAjTSaCXmY6zws8sz0O
 n2kHX+IhqwfkAyjSE993Y4TTgWB6PMMQQrwMLubETXavlh9IcZFOmZ3ZpOiPyIruVvD4
 x1ig==
X-Forwarded-Encrypted: i=1;
 AFNElJ/lF0rEsoOOeb5+VTJEH3voW3sVUp8VS/NEM9kflET6gpPJPqgpCs9COdZJf6k38oIrZ+Iw3SOaT7im@nongnu.org
X-Gm-Message-State: AOJu0YxraYJRgHWrdAdTkZfMiGKa0Rt5wO7F7i9q4kSP5SFdUFpOrlha
 Odg2PVn2k7hrXN69fD83TZrtFxan/JApz0K1W23gQbDJgEmwnyiPTZcF
X-Gm-Gg: Acq92OGhXZgUYJJ6edOw39lj+9n+fyLyWZMEXxJGtuJPE9sNWUPQS17Ji2uhqlQsXgp
 uNMSHOvBuFgj/dFJvVjMAAlaBzhJivzPkYFza7L9QGQpSlg5Qjr2+DdqsYJS9W37uDEOOpy0NKc
 FDmdsVKuHdPz0fxvRR1rq0FsHTwLIs21oHTlm0jZHt3KPJ41UVESnlbmLOKO3sdW2601aZ/u1T6
 uoJBlCi0Kubit0qpfefNkoOuBkG/nUSD3jgS4Q/V1hxXbkCOYxa4AbbP5SH6jKlAUtZ7VoO37f8
 Y2R35023xjqp6HSI57I841HVLfbIZvJvqxi7CY8Zgz7cqpAf0i2fH2Tqb8paHLRzFoPhqi+GeWg
 NG8yJhs1bW0eyu6qvhVSOKIHskpjfnOd0DrwEo45Q/mR+gSq2AEZRrYdp94yfvuNOESenhkRRuS
 yjFEPQx3zCnpWtdeq+cYgjftqWTgftGWUq1mAjMyAXTTQarM+i8lYHLDDrWLGUlZ3PifBW0yfTk
 Go=
X-Received: by 2002:a05:600c:45ce:b0:490:59cc:998e with SMTP id
 5b1f17b1804b1-49059cc99famr148876495e9.3.1779769818990; 
 Mon, 25 May 2026 21:30:18 -0700 (PDT)
Received: from localhost.localdomain (46-116-239-136.bb.netvision.net.il.
 [46.116.239.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49076a6abfasm6659625e9.12.2026.05.25.21.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 21:30:18 -0700 (PDT)
From: Leonid Bloch <lb.workbox@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Leonid Bloch <lb.workbox@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 8/8] scripts: Add laptop-mirror reference script
Date: Tue, 26 May 2026 07:29:27 +0300
Message-ID: <20260526042928.9203-9-lb.workbox@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526042928.9203-1-lb.workbox@gmail.com>
References: <20260526042928.9203-1-lb.workbox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=lb.workbox@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add an in-tree Python reference implementation that reads the host's
battery, AC adapter and lid state from sysfs/procfs and forwards changes
to a running QEMU guest through the battery-set-state,
ac-adapter-set-state and lid-button-set-state QMP commands.

This script is intended as an example for management layers
(such as libvirt) to follow when wiring host hardware to those devices,
not as an end-user deployment tool.

Signed-off-by: Leonid Bloch <lb.workbox@gmail.com>
---
 MAINTAINERS                  |   6 +
 docs/tools/index.rst         |   1 +
 docs/tools/laptop-mirror.rst |  82 +++++++++++++
 scripts/laptop-mirror.py     | 219 +++++++++++++++++++++++++++++++++++
 4 files changed, 308 insertions(+)
 create mode 100644 docs/tools/laptop-mirror.rst
 create mode 100755 scripts/laptop-mirror.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 1f8f3e247e..9616544d29 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3057,6 +3057,12 @@ F: docs/specs/button.rst
 F: hw/acpi/button*
 F: include/hw/acpi/button.h
 
+Laptop mirror
+M: Leonid Bloch <lb.workbox@gmail.com>
+S: Maintained
+F: docs/tools/laptop-mirror.rst
+F: scripts/laptop-mirror.py
+
 Subsystems
 ----------
 Overall Audio backends
diff --git a/docs/tools/index.rst b/docs/tools/index.rst
index 868c3c4d9d..0c8fa6010f 100644
--- a/docs/tools/index.rst
+++ b/docs/tools/index.rst
@@ -17,3 +17,4 @@ command line utilities and other standalone programs.
    qemu-trace-stap
    qemu-vmsr-helper
    qemu-vnc
+   laptop-mirror
diff --git a/docs/tools/laptop-mirror.rst b/docs/tools/laptop-mirror.rst
new file mode 100644
index 0000000000..62fc2f92c3
--- /dev/null
+++ b/docs/tools/laptop-mirror.rst
@@ -0,0 +1,82 @@
+=======================
+QEMU laptop mirror tool
+=======================
+
+Synopsis
+--------
+
+**laptop-mirror.py** [*OPTIONS*]
+
+Description
+-----------
+
+``laptop-mirror.py`` polls the host's battery, AC adapter and lid state
+from sysfs/procfs and forwards every change to a running QEMU guest using
+the ``battery-set-state``, ``ac-adapter-set-state`` and
+``lid-button-set-state`` QMP commands. This script is a reference for how
+a management layer (libvirt or similar) can wire host hardware to them,
+and isn't meant for production use as-is.
+
+Options
+-------
+
+.. program:: laptop-mirror.py
+
+.. option:: -s SOCKET, --socket SOCKET
+
+  QMP socket: a Unix path or ``host:port``. Falls back to ``$QMP_SOCKET``.
+
+.. option:: -i SECONDS, --interval SECONDS
+
+  Polling interval, in seconds. Default ``2.0``.
+
+.. option:: --battery, --no-battery
+
+  Mirror the battery (default: on).
+
+.. option:: --ac-adapter, --no-ac-adapter
+
+  Mirror the AC adapter (default: on).
+
+.. option:: --lid, --no-lid
+
+  Mirror the lid button (default: on). A device that is enabled but not
+  present on the host is silently skipped.
+
+.. option:: -v, --verbose
+
+  ``-v`` logs every state change; ``-vv`` adds debug output.
+
+Example
+-------
+
+Start QEMU with the laptop devices and a QMP socket::
+
+  qemu-system-x86_64 \
+      -device battery -device acad -device button \
+      -qmp unix:/tmp/qmp.sock,server=on,wait=off \
+      ...
+
+Then mirror your host state::
+
+  export QMP_SOCKET=/tmp/qmp.sock
+  $builddir/run scripts/laptop-mirror.py -v
+
+The script depends on the in-tree ``qemu.qmp`` package; ``$builddir/run``
+puts it on ``PYTHONPATH``.
+
+Caveats
+-------
+
+* QMP allows one client at a time. If ``qmp-shell``, libvirt or another
+  script is already connected, the mirror times out after ten seconds and
+  exits with an error.
+* When QEMU runs as root, its Unix QMP socket is root-owned. Run the
+  mirror as root too, ``chmod`` the socket after QEMU is up, or expose
+  QMP over TCP.
+
+See also
+--------
+
+:doc:`/specs/battery`, :doc:`/specs/acad`, :doc:`/specs/button`,
+:manpage:`qemu-qmp-ref(7)`
diff --git a/scripts/laptop-mirror.py b/scripts/laptop-mirror.py
new file mode 100755
index 0000000000..8db76e4ff9
--- /dev/null
+++ b/scripts/laptop-mirror.py
@@ -0,0 +1,219 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (c) 2025-2026 Leonid Bloch <lb.workbox@gmail.com>
+
+"""Reference: mirror host laptop power state into a QEMU guest via QMP.
+
+The C devices (battery/acad/button) are pure QMP-controlled; this script
+shows how a management layer (libvirt etc.) might wire host sysfs/procfs
+state to the QMP commands.  See docs/tools/laptop-mirror.rst.
+"""
+from __future__ import annotations
+
+import argparse
+import logging
+import os
+import signal
+import socket
+import sys
+import time
+from pathlib import Path
+from typing import Any
+
+try:
+    from qemu.qmp import QMPError
+    from qemu.qmp.legacy import QEMUMonitorProtocol
+except ModuleNotFoundError as exc:
+    print(f"Module '{exc.name}' not found.", file=sys.stderr)
+    print(f"Try $builddir/run {' '.join(sys.argv)}", file=sys.stderr)
+    sys.exit(1)
+
+
+log = logging.getLogger("laptop-mirror")
+
+POWER_SUPPLY = Path("/sys/class/power_supply")
+ACPI_BUTTON = Path("/proc/acpi/button")
+
+
+def read_str(p: Path) -> str | None:
+    try:
+        return p.read_text().strip()
+    except OSError:
+        return None
+
+
+def read_int(p: Path) -> int | None:
+    s = read_str(p)
+    try:
+        return int(s) if s is not None else None
+    except ValueError:
+        return None
+
+
+def find_supply(kind: str) -> Path | None:
+    if not POWER_SUPPLY.is_dir():
+        return None
+    for d in sorted(POWER_SUPPLY.iterdir()):
+        if read_str(d / "type") == kind:
+            return d
+    return None
+
+
+def find_lid() -> Path | None:
+    lid_dir = ACPI_BUTTON / "lid"
+    if not lid_dir.is_dir():
+        return None
+    for sub in sorted(lid_dir.iterdir()):
+        if (state := sub / "state").is_file():
+            return state
+    return None
+
+
+def battery_state(path: Path) -> dict[str, Any] | None:
+    status = read_str(path / "status") or ""
+    cap = read_int(path / "capacity")
+    if cap is None:
+        en, ef = read_int(path / "energy_now"), read_int(path / "energy_full")
+        if en is None or not ef:
+            return None
+        cap = en * 100 // ef
+
+    state: dict[str, Any] = {
+        "present": True,
+        "charging": status == "Charging",
+        "discharging": status == "Discharging",
+        "charge-percent": max(0, min(100, cap)),
+    }
+    pw = read_int(path / "power_now")
+    if pw is not None:
+        state["rate"] = abs(pw) // 1000
+    return state
+
+
+def ac_online(path: Path) -> bool | None:
+    v = read_int(path / "online")
+    return None if v is None else bool(v)
+
+
+def lid_open(path: Path) -> bool | None:
+    s = read_str(path)
+    return None if s is None else "open" in s.lower()
+
+
+def qmp_connect(address, timeout):
+    if isinstance(address, tuple):
+        sock = socket.create_connection(address, timeout=timeout)
+    else:
+        sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
+        sock.settimeout(timeout)
+        sock.connect(address)
+    sock.settimeout(timeout)
+    if not sock.recv(1, socket.MSG_PEEK):
+        sock.close()
+        raise TimeoutError
+    sock.settimeout(None)
+    return sock
+
+
+def parse_args() -> argparse.Namespace:
+    p = argparse.ArgumentParser(
+        description="Mirror host laptop hardware state to a QEMU guest "
+                    "via QMP.")
+    p.add_argument("-s", "--socket", default=os.environ.get("QMP_SOCKET"),
+                   help="QMP socket: unix path or addr:port "
+                        "(default: $QMP_SOCKET)")
+    p.add_argument("-i", "--interval", type=float, default=2.0,
+                   metavar="SECONDS",
+                   help="polling interval in seconds (default: 2.0)")
+    p.add_argument("-v", "--verbose", action="count", default=0,
+                   help="increase verbosity (-v info, -vv debug)")
+    p.add_argument("--battery", action=argparse.BooleanOptionalAction,
+                   default=True, help="monitor the battery")
+    p.add_argument("--ac-adapter", action=argparse.BooleanOptionalAction,
+                   default=True, help="monitor the AC adapter")
+    p.add_argument("--lid", action=argparse.BooleanOptionalAction,
+                   default=True, help="monitor the lid button")
+    args = p.parse_args()
+    if not args.socket:
+        p.error("--socket is required (or set $QMP_SOCKET)")
+    if args.interval <= 0:
+        p.error("--interval must be positive")
+    if not (args.battery or args.ac_adapter or args.lid):
+        p.error("at least one device must be enabled")
+    return args
+
+
+def main() -> int:
+    args = parse_args()
+    levels = [logging.WARNING, logging.INFO, logging.DEBUG]
+    logging.basicConfig(level=levels[min(args.verbose, 2)],
+                        format="%(message)s", stream=sys.stderr)
+    logging.getLogger("qemu.qmp").setLevel(logging.CRITICAL)
+
+    bat = find_supply("Battery") if args.battery else None
+    ac = find_supply("Mains") if args.ac_adapter else None
+    lid = find_lid() if args.lid else None
+    if not (bat or ac or lid):
+        log.error("No host laptop devices found to mirror")
+        return 1
+    for name, path in (("battery", bat), ("ac-adapter", ac), ("lid", lid)):
+        if path is not None:
+            log.info("Mirroring %s from %s", name, path)
+
+    try:
+        sock = qmp_connect(QEMUMonitorProtocol.parse_address(args.socket), 10)
+    except TimeoutError:
+        log.error("Timed out negotiating QMP with %s. Is another QMP "
+                  "client (e.g. qmp-shell) holding the socket?", args.socket)
+        return 1
+    except OSError as exc:
+        log.error("Could not connect to %s: %s", args.socket, exc)
+        return 1
+
+    qmp = QEMUMonitorProtocol(sock)
+    try:
+        qmp.connect()
+    except QMPError as exc:
+        log.error("QMP error: %s", exc)
+        return 1
+
+    prev: dict[str, dict[str, Any]] = {}
+
+    def push(command: str, payload: dict[str, Any]) -> None:
+        if prev.get(command) == payload:
+            return
+        try:
+            qmp.cmd(command, **payload)
+        except QMPError as exc:
+            log.warning("%s failed: %s", command, exc)
+            return
+        prev[command] = payload
+        log.info("%s -> %s", command, payload)
+
+    running = True
+
+    def stop(_signum, _frame):
+        nonlocal running
+        running = False
+
+    signal.signal(signal.SIGINT, stop)
+    signal.signal(signal.SIGTERM, stop)
+
+    try:
+        while running:
+            if bat and (s := battery_state(bat)) is not None:
+                push("battery-set-state", {"state": s})
+            if ac and (c := ac_online(ac)) is not None:
+                push("ac-adapter-set-state", {"connected": c})
+            if lid and (o := lid_open(lid)) is not None:
+                push("lid-button-set-state", {"open": o})
+            time.sleep(args.interval)
+        return 0
+    finally:
+        qmp.close()
+
+
+if __name__ == "__main__":
+    sys.exit(main())
-- 
2.54.0


