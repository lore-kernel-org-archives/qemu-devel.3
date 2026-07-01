Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3C8C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 11:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wetAv-00015u-JY; Wed, 01 Jul 2026 07:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilya.chichkov.dev@gmail.com>)
 id 1wetAn-00014k-Bb
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 07:32:10 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilya.chichkov.dev@gmail.com>)
 id 1wetAg-0000Qo-JM
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 07:32:08 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-39b1026e171so5820051fa.1
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 04:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782905515; x=1783510315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0e6cksbOVyQU8FFtPKbOaHW1BymkoGqFeWldHra4qKI=;
 b=fGjmZ7SqsxEY1nzokUn2prcMF9i53c+p5I5I0toMQtM5rSKpZgKeq5il1evynvI84r
 swZ3/YUigEhv+bsrjNmt39pMp8Mxh/frPSzmT3C2qL7+lK0V9i1aviFmtMqlIQjtorrA
 zWl8WDW7gnYcKnKBp/zNtPG1R9Aaggxn3uawHJOISYyfxvDo/PB6YqoT9WGJNU/GZueT
 Q3DQ4cRjLqEo+i6dGANoRBCAoG4Das40f5+mqsafBIP/gQQ+FSSvBreakoUCFPl23sx6
 6a28Vi1ahNrgL5wwCjIoHxHExY8h/SA5qdDFL7/G+lE9cKSTCLXNjxSV0oKPzJiPI7Fl
 6JDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782905515; x=1783510315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0e6cksbOVyQU8FFtPKbOaHW1BymkoGqFeWldHra4qKI=;
 b=laScCL8K7QOZXru7IYiU/yU0jhH2kdGmUc7Bo8r1WV06yIR8h9lcjZBwXr5g0zC3dX
 guVASQryZMEcNGyaKHc8PAc8lerUztPmjJFmsF8fPsBo1nUeb06wQM5hEr7uzKSOBcyg
 FEaSotlDs2A/CQ94j32oupDcCY7zcc7PtkW9AUdd9V85jNMdDd8AVDqcw/l+xotA7WGl
 Ow8hLcGoBL7wkoWiwvQj/ZGqkyg5InP87hGU5WwlcSNuZjTe2tpfkTmBc88Zr4fHBmnq
 u8KkNWTtUdcKvKc3SNnJkMxn35aBTNyu/yVVQd4c3fSWsjDYCf+2w2jgK4s2GMXvKZr0
 SfyA==
X-Gm-Message-State: AOJu0Yyx6rD9IYQVx6YAYlGJmFnTCSGZ/qzJiPFVMo+vlXc7Awj/wXX5
 A22aOtk4Ot17lBKlUevpq+PACrX9Au857GMwiJeIxVrPanZWKMWd2poXcFYKsHVDhIlVVQ==
X-Gm-Gg: AfdE7cm4UMwNgGzaQNAM84IXNuuYmf7RPMQum6ytFkHUZ563vvYnIRRd8iMXlCr8eqU
 ZgZPymB9Y5EAoUe+PJhy6t6EmPijXvgKIItUOCkjJYxZcdh8qQGjYBXVFz1zZoSvCzCsOg4kXJ1
 k/+hF842dPdRx/aSWuG3XpLw39AYf1hJsCFkC7YG93aEoB40noFy5tGn3Wjpkqbufi3YZ0pPKv2
 HqcG9fbtuhGt6s/LA766dU73QelEUmjL141TAVpvbFt/q4U27ZZbOFZlNs0JVkrWedg/V1OBI2N
 YF8EXnE8a9FAKOBI8ObXqeL5WAXRaUBN1niA09dWfYcZOx68PMWX+b4YkAkzIBKme+6U4mBWrn1
 uaiWB24qyilYp+g+Ha6qtZoj5UgLv2t3FpzzT8G8s0rh/Lu6EXblfK5KHn/8smrFimhUrmH5hgu
 iinb7dR6FCAeBTYNzw800=
X-Received: by 2002:a05:6512:312d:b0:5ad:5814:1b72 with SMTP id
 2adb3069b0e04-5aec8024b28mr57859e87.34.1782905513521; 
 Wed, 01 Jul 2026 04:31:53 -0700 (PDT)
Received: from gmail.com ([89.207.88.244]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aebe49866asm1187819e87.49.2026.07.01.04.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 04:31:52 -0700 (PDT)
From: Ilya Chichkov <ilya.chichkov.dev@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Corey Minyard <cminyard@mvista.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Ilya Chichkov <ilya.chichkov.dev@gmail.com>
Subject: [PATCH v3] hw/i2c: Add remote I2C master with host CUSE bridge
Date: Wed,  1 Jul 2026 14:31:46 +0300
Message-ID: <20260701113149.1853994-1-ilya.chichkov.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <871pdn6scp.fsf@pond.sub.org>
References: <871pdn6scp.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=ilya.chichkov.dev@gmail.com; helo=mail-lj1-x230.google.com
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

Add a "remote-i2c-master" device that exposes a QEMU I2C bus to the
host system through a FUSE/CUSE character device. This lets external
host programs and standard i2c-tools interact with I2C slaves emulated
inside QEMU as if they were real devices attached to the host.

The implementation is split into three layers:

  - A non-blocking finite state machine that drives the QEMU I2C
    master. It is pumped by a QEMU Bottom Half and uses virtual timers
    to yield during long transfers and to model clock stretching for
    asynchronous slaves, so the main loop is never blocked. The FSM
    walks IDLE -> ADDR -> SEND/RECV -> WAIT_STRETCH -> END -> FINISHED
    and handles NACKs (ENXIO), lost arbitration (EBUSY, with optional
    back-off and retry), stretch timeouts, and manual abort/reset.

  - An abstract RemoteI2CBackend QOM base class that decouples the
    internal I2C hardware state machine (the frontend) from any
    host-specific transport, exposing on_tx_complete and on_tx_error
    virtual callbacks.

  - A concrete remote-i2c-backend-cuse backend implementing that
    transport over CUSE. It manages the FUSE session and integrates
    its file descriptors into QEMU's main AioContext event loop,
    translates Linux I2C_RDWR, I2C_SMBUS and I2C_SLAVE ioctls into
    generic byte streams for the FSM, and formats responses back into
    Linux I2C/SMBus structures for the FUSE driver. SMBus repeated
    start is supported for atomic write-then-read operations.

Example usage:

  -device remote-i2c-master,i2cbus=i2c-bus.0,devname=i2c-33
  -object remote-i2c-backend-cuse,id=b0,devname=i2c-33

This creates /dev/i2c-33 on the host, usable with i2c-tools:

  i2cdetect -y -l
  i2cget -y <bus_id> <addr> <reg>

Signed-off-by: Ilya Chichkov <ilya.chichkov.dev@gmail.com>
---
v2:
  - docs/system/devices/remote-i2c-master.rst: Documented concurrent
    bus access details and the 'raise-arbitrage-lost' property.
---
v3:
  - qapi/qom.json: Fix RemoteI2CBackendCuseProperties formatting and
    expand member documentation (devname, fuse-opts, debug).
  - tests/qtest: Add remote-i2c-cuse-test covering capabilities,
    functional smoke test, synchronous sensor read/write.
---
---
 docs/system/devices/remote-i2c-master.rst |  217 ++++
 hw/i2c/Kconfig                            |    5 +
 hw/i2c/meson.build                        |    6 +
 hw/i2c/remote-i2c-backend.c               |   30 +
 hw/i2c/remote-i2c-cuse.c                  | 1186 +++++++++++++++++++++
 hw/i2c/remote-i2c-fsm.c                   |  521 +++++++++
 hw/i2c/remote-i2c-master.c                |  145 +++
 hw/i2c/trace-events                       |   29 +
 include/hw/i2c/remote-i2c-backend.h       |   70 ++
 include/hw/i2c/remote-i2c-cuse.h          |   93 ++
 include/hw/i2c/remote-i2c-master.h        |   77 ++
 qapi/qom.json                             |   29 +
 tests/qtest/meson.build                   |    2 +
 tests/qtest/remote-i2c-cuse-test.c        |  326 ++++++
 14 files changed, 2736 insertions(+)
 create mode 100644 docs/system/devices/remote-i2c-master.rst
 create mode 100644 hw/i2c/remote-i2c-backend.c
 create mode 100644 hw/i2c/remote-i2c-cuse.c
 create mode 100644 hw/i2c/remote-i2c-fsm.c
 create mode 100644 hw/i2c/remote-i2c-master.c
 create mode 100644 include/hw/i2c/remote-i2c-backend.h
 create mode 100644 include/hw/i2c/remote-i2c-cuse.h
 create mode 100644 include/hw/i2c/remote-i2c-master.h
 create mode 100644 tests/qtest/remote-i2c-cuse-test.c

diff --git a/docs/system/devices/remote-i2c-master.rst b/docs/system/devices/remote-i2c-master.rst
new file mode 100644
index 0000000000..7753da425d
--- /dev/null
+++ b/docs/system/devices/remote-i2c-master.rst
@@ -0,0 +1,217 @@
+Remote I2C master
+=================
+
+Overview
+--------
+
+The Remote I2C master exposes a QEMU I2C bus to the host system through a
+FUSE/CUSE (Character device in Userspace) character device. It allows
+userspace programs and scripts on the host to interact with I2C slaves
+emulated inside QEMU as if they were real hardware devices attached to the
+host, accessible with the standard Linux I2C interface and tools such as
+``i2c-tools``.
+
+Features
+--------
+
+- Virtual I2C controller exposed to the host as a character device via CUSE
+- Implements the Linux I2C ioctl interface (``I2C_RDWR``, ``I2C_SMBUS``,
+  ``I2C_SLAVE``)
+- Supports standard I2C and SMBus protocols
+- SMBus "Repeated Start" for atomic write-then-read operations
+- Asynchronous, non-blocking transactions driven by QEMU's Bottom Halves (BH)
+- Clock-stretching emulation for asynchronous slave devices, so QEMU's main
+  loop is never blocked during long transfers
+- Integration with QEMU's AioContext for asynchronous I/O
+- Debugging support through FUSE debug mode
+
+Architecture
+------------
+
+The device is split into three decoupled layers:
+
+Master frontend (FSM)
+~~~~~~~~~~~~~~~~~~~~~~~
+
+A non-blocking finite state machine drives the QEMU I2C master. It is pumped
+by a QEMU Bottom Half and uses virtual timers to yield during long transfers
+and to model clock stretching for asynchronous slaves. The transaction walks
+the following states::
+
+    IDLE -> ADDR -> SEND/RECV -> WAIT_STRETCH -> END -> FINISHED
+
+- ``IDLE``         : Resting state; awaits a backend dispatch, checks bus
+  busyness and handles retry timers if arbitration was lost.
+- ``ADDR``         : Asserts the bus and sends the slave address. A NACK
+  aborts the transaction (``ENXIO``); an ACK transitions to SEND, RECV or
+  WAIT_STRETCH.
+- ``SEND``         : Pushes data bytes to the bus, synchronously in a loop or
+  one byte at a time for async slaves.
+- ``RECV``         : Reads data bytes from the bus, with the same yielding
+  behaviour as SEND.
+- ``WAIT_STRETCH`` : Yields back to QEMU to simulate clock stretching or to
+  enforce an artificial delay; on timer expiry it bounces back to SEND/RECV.
+- ``END``          : Transitional state that guarantees ``i2c_end_transfer``
+  is called gracefully.
+- ``FINISHED``     : Cleans up timers, releases the bus and invokes the
+  backend completion callbacks.
+
+Error handling covers NACKs (``ENXIO``), lost arbitration (``EBUSY``, with an
+optional back-off and retry cooldown), stretch timeouts to avoid hung
+transactions, and manual abort/reset issued by the backend.
+
+Abstract backend
+~~~~~~~~~~~~~~~~~
+
+An abstract ``RemoteI2CBackend`` QOM base class strictly decouples the
+internal QEMU I2C hardware state machine (the frontend) from any
+host-specific transport layer. It exposes the ``on_tx_complete`` and
+``on_tx_error`` virtual callbacks used by the FSM to report results.
+
+CUSE backend
+~~~~~~~~~~~~
+
+The concrete ``remote-i2c-backend-cuse`` backend implements the transport
+over CUSE. It manages the FUSE/CUSE session, integrating its file descriptors
+directly into QEMU's main AioContext event loop. It translates Linux
+user-space ioctls (``I2C_RDWR``, ``I2C_SMBUS``, ``I2C_SLAVE``) into generic
+byte streams for the master frontend to process, and formats QEMU's response
+data back into Linux-compatible I2C/SMBus structures to reply to the FUSE
+driver.
+
+Concurrent bus access
+~~~~~~~~~~~~~~~~~~~~~
+
+The remote master and the emulated CPU may both attempt to drive the same I2C
+bus simultaneously, mirroring the arbitration behaviour of a real multi-master
+I2C bus. QEMU's I2C core serializes ownership through ``i2c_bus_master()``,
+which returns an error when the bus is already held by another master.
+
+The remote master handles this in one of two ways, controlled by the
+``raise-arbitrage-lost`` property:
+
+- **Retry with back-off** (default, ``raise-arbitrage-lost=false``): the
+  master treats a busy bus as a lost-arbitration event, backs off, and
+  retries the transaction after a configurable delay. This matches the
+  behaviour of hardware multi-master I2C controllers.
+
+- **Fail immediately** (``raise-arbitrage-lost=true``): the master surfaces
+  ``EBUSY`` to the caller at once without retrying. Use this when the host
+  test suite must detect contention explicitly rather than wait for it to
+  resolve.
+
+Invocation
+----------
+
+The backend can be wired implicitly through the master device::
+
+    -object remote-i2c-backend-cuse,id=<id>,devname=<node_name>
+    -device remote-i2c-master,i2cbus=<bus>,backend=<id>
+
+That creates a character device named ``<node_name>`` (for example
+``/dev/i2c-33``) on the host.
+
+Requirements
+------------
+
+Kernel requirements
+~~~~~~~~~~~~~~~~~~~~~
+
+- CUSE module loaded: ``sudo modprobe cuse``
+- FUSE support enabled
+
+Library dependencies
+~~~~~~~~~~~~~~~~~~~~~~
+
+- libfuse3 or libfuse (version 2.9.0 or higher)
+- FUSE development headers
+
+Debugging
+---------
+
+FUSE debug output can be enabled by passing FUSE options to the CUSE backend
+through ``fuse-opts`` or by ``debug=true`` for short.
+
+.. code-block:: bash
+
+    -object remote-i2c-backend-cuse,id=b0,devname=i2c-33,fuse-opts=-d
+
+Running the FUSE session in the foreground with debug enabled prints the
+incoming CUSE/ioctl traffic, which is useful when diagnosing transport
+issues.
+
+Limitations
+-----------
+
+10-bit I2C addressing
+~~~~~~~~~~~~~~~~~~~~~
+
+Only 7-bit I2C addresses (0–127) are supported. QEMU's I2C core stores slave
+addresses as ``uint8_t`` and all bus functions (``i2c_start_send``,
+``i2c_start_recv``, ``i2c_scan_bus``) accept ``uint8_t address``, so 10-bit
+addressing cannot be represented at the framework level. The CUSE backend
+reflects this by rejecting any address outside the 0–127 range with
+``EINVAL``. The ``I2C_M_TEN`` flag in ``I2C_RDWR`` messages is ignored.
+
+Troubleshooting
+---------------
+
+CUSE_INIT failures
+~~~~~~~~~~~~~~~~~~~
+
+If you encounter ``CUSE_INIT`` errors:
+
+1. Verify the CUSE module is loaded:
+
+   .. code-block:: bash
+
+       lsmod | grep cuse
+       sudo modprobe cuse
+
+2. Check permissions on the CUSE control device:
+
+   .. code-block:: bash
+
+       # Ensure the user has access to /dev/cuse
+       ls -la /dev/cuse
+
+Examples
+--------
+
+Basic usage
+~~~~~~~~~~~
+
+Start QEMU with a ``tmp105`` temperature sensor on an Aspeed I2C bus and
+expose that bus to the host as ``/dev/i2c-33``:
+
+.. code-block:: bash
+
+    ./qemu-system-arm -M ast2600-evb \
+        -device tmp105,address=0x40,bus=aspeed.i2c.bus.0 \
+        -device remote-i2c-master,i2cbus=aspeed.i2c.bus.0,devname=i2c-33
+
+Then access the emulated sensor from the host with ``i2c-tools``:
+
+.. code-block:: console
+
+    $ i2cdetect -y 33
+         0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
+    00:                         -- -- -- -- -- -- -- --
+    10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
+    20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
+    30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
+    40: 40 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
+    50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
+    60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
+
+    $ i2cget -y 33 0x40 0x2
+    0x4b
+
+    $ i2cget -y 33 0x40 0x3
+    0x50
+
+See also
+--------
+
+- `FUSE Documentation <https://github.com/libfuse/libfuse>`_
+- `Character devices in user space <https://lwn.net/Articles/308445/>`_
diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
index 596a7a3165..84d387bf41 100644
--- a/hw/i2c/Kconfig
+++ b/hw/i2c/Kconfig
@@ -49,3 +49,8 @@ config PMBUS
 config BCM2835_I2C
     bool
     select I2C
+
+config REMOTE_I2C_MASTER
+    bool
+    select I2C
+    default y if I2C_DEVICES
diff --git a/hw/i2c/meson.build b/hw/i2c/meson.build
index c459adcb59..ea8cf1f980 100644
--- a/hw/i2c/meson.build
+++ b/hw/i2c/meson.build
@@ -18,4 +18,10 @@ i2c_ss.add(when: 'CONFIG_PPC4XX', if_true: files('ppc4xx_i2c.c'))
 i2c_ss.add(when: 'CONFIG_PCA954X', if_true: files('i2c_mux_pca954x.c'))
 i2c_ss.add(when: 'CONFIG_PMBUS', if_true: files('pmbus_device.c'))
 i2c_ss.add(when: 'CONFIG_BCM2835_I2C', if_true: files('bcm2835_i2c.c'))
+i2c_ss.add(when: 'CONFIG_REMOTE_I2C_MASTER', if_true: files(
+    'remote-i2c-master.c',
+    'remote-i2c-backend.c',
+    'remote-i2c-cuse.c',
+    'remote-i2c-fsm.c'
+))
 system_ss.add_all(when: 'CONFIG_I2C', if_true: i2c_ss)
diff --git a/hw/i2c/remote-i2c-backend.c b/hw/i2c/remote-i2c-backend.c
new file mode 100644
index 0000000000..e8d753b491
--- /dev/null
+++ b/hw/i2c/remote-i2c-backend.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Remote I2C Backend (Abstract Base Class)
+ *
+ * This module defines the abstract backend interface for the Remote I2C Master.
+ * It provides the QEMU Object Model (QOM) base class that strictly decouples
+ * the internal QEMU I2C hardware state machine (the frontend) from
+ * host-specific transport layers.
+ *
+ * Author:
+ * Ilya Chichkov <ilya.chichkov.dev@gmail.com>
+ *
+ */
+#include "qemu/osdep.h"
+#include "hw/i2c/remote-i2c-backend.h"
+
+static const TypeInfo remote_i2c_backend_info = {
+    .name = TYPE_REMOTE_I2C_BACKEND,
+    .parent = TYPE_OBJECT,
+    .instance_size = sizeof(RemoteI2CBackend),
+    .class_size = sizeof(RemoteI2CBackendClass),
+    .abstract = true,
+};
+
+static void remote_i2c_backend_register_types(void)
+{
+    type_register_static(&remote_i2c_backend_info);
+}
+
+type_init(remote_i2c_backend_register_types)
diff --git a/hw/i2c/remote-i2c-cuse.c b/hw/i2c/remote-i2c-cuse.c
new file mode 100644
index 0000000000..a5b557af9a
--- /dev/null
+++ b/hw/i2c/remote-i2c-cuse.c
@@ -0,0 +1,1186 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Remote I2C CUSE Backend
+ *
+ * This module provides the concrete CUSE (Character device in Userspace)
+ * implementation of the abstract Remote I2C Backend interface. It acts as the
+ * physical bridge between the Linux host's I2C subsystem and QEMU's internal
+ * I2C hardware emulation.
+ *
+ * Architecture & Responsibilities:
+ * - Inherits from the abstract `RemoteI2CBackend` QOM base class.
+ * - Initializes and manages the FUSE/CUSE session, integrating its file
+ *   descriptors directly into QEMU's main AioContext event loop.
+ * - Translates Linux user-space IOCTLs (I2C_RDWR, I2C_SMBUS, I2C_SLAVE) into
+ *   generic byte streams for the Master Frontend to process.
+ * - Implements the `on_tx_complete` and `on_tx_error` virtual callbacks to
+ *   format QEMU's response data back into Linux-compatible I2C/SMBus data
+ *   structures and reply to the FUSE driver.
+ *
+ * Usage:
+ * Instantiated via the QEMU CLI as a backend object:
+ *   -object remote-i2c-backend-cuse,
+ *           id=<id>,devname=<node_name>[,fuse-opts=<opts>]
+ *
+ * Author:
+ * Ilya Chichkov <ilya.chichkov.dev@gmail.com>
+ *
+ */
+#include "qemu/osdep.h"
+
+#include "qapi/error.h"
+#include "qemu/main-loop.h"
+#include "hw/i2c/i2c.h"
+#include "hw/core/qdev-properties-system.h"
+#include "qemu/error-report.h"
+#include "qemu/bswap.h"
+#include "qemu/aio.h"
+#include "qemu/log.h"
+#include "qapi/visitor.h"
+#include "qapi/error.h"
+#include "trace.h"
+
+#include "hw/i2c/remote-i2c-cuse.h"
+#include "hw/i2c/remote-i2c-master.h" /* For FSM dispatch and commands */
+
+#define I2C_BUS_BUSY_CHECK_TIMER_COOLDOWN_NS 50000
+
+#define I2C_BUFFER_INDEX_SIZE 2
+#define I2C_BUFFER_INDEX_COMMAND 3
+#define I2C_BUFFER_INDEX_DATA_0 4
+#define I2C_BUFFER_INDEX_DATA_1 5
+
+
+static bool cuse_get_debug(Object *obj, Error **errp)
+{
+    RemoteI2CBackendCuse *cuse = REMOTE_I2C_BACKEND_CUSE(obj);
+    return cuse->debug;
+}
+
+static void cuse_set_debug(Object *obj, bool value, Error **errp)
+{
+    RemoteI2CBackendCuse *cuse = REMOTE_I2C_BACKEND_CUSE(obj);
+    cuse->debug = value;
+}
+
+static char *cuse_get_devname(Object *obj, Error **errp)
+{
+    RemoteI2CBackendCuse *cuse = REMOTE_I2C_BACKEND_CUSE(obj);
+    return g_strdup(cuse->devname);
+}
+
+static void cuse_set_devname(Object *obj, const char *value, Error **errp)
+{
+    RemoteI2CBackendCuse *cuse = REMOTE_I2C_BACKEND_CUSE(obj);
+    g_free(cuse->devname);
+    cuse->devname = g_strdup(value);
+}
+
+static char *cuse_get_fuse_opts(Object *obj, Error **errp)
+{
+    RemoteI2CBackendCuse *cuse = REMOTE_I2C_BACKEND_CUSE(obj);
+    return g_strdup(cuse->fuse_opts);
+}
+
+static void cuse_set_fuse_opts(Object *obj, const char *value, Error **errp)
+{
+    RemoteI2CBackendCuse *cuse = REMOTE_I2C_BACKEND_CUSE(obj);
+    g_free(cuse->fuse_opts);
+    cuse->fuse_opts = g_strdup(value);
+}
+
+
+/*
+ * remote_i2c_serialize_smbus_write:
+ * @cuse: The concrete CUSE backend instance.
+ * @in_val: Pointer to the incoming Linux SMBus IOCTL data structure.
+ *
+ * Translates a Linux user-space SMBus write or read command request into a flat
+ * payload array compatible with QEMU's generic I2C transaction buffer
+ */
+static
+void remote_i2c_serialize_smbus_write(RemoteI2CBackendCuse *cuse,
+                                      const struct i2c_smbus_ioctl_data *in_val)
+{
+    RemoteI2CBackend *backend = REMOTE_I2C_BACKEND(cuse);
+    union i2c_smbus_data data;
+    uint8_t buf[REMOTE_I2C_BACKEND_BUF_LEN] = { 0 };
+    uint8_t len = 0;
+
+    memset(backend->transaction_buf, 0, REMOTE_I2C_BACKEND_BUF_LEN);
+
+    buf[0] = in_val->read_write;
+    buf[1] = (uint8_t)backend->address;
+
+    memcpy(&data,
+           cuse->in_data.in_buf + sizeof(struct i2c_smbus_ioctl_data),
+           sizeof(union i2c_smbus_data));
+
+    if (in_val->read_write == I2C_SMBUS_READ) {
+        if (in_val->size == I2C_SMBUS_BYTE) {
+            backend->transaction_length = 0;
+            return;
+        }
+
+        backend->transaction_length = 1;
+        backend->transaction_buf[0] = in_val->command;
+        return;
+    }
+
+    switch (in_val->size) {
+    case I2C_SMBUS_QUICK:
+        buf[I2C_BUFFER_INDEX_SIZE] = 0;
+        break;
+    case I2C_SMBUS_BYTE:
+        buf[I2C_BUFFER_INDEX_SIZE] = 1;
+        buf[I2C_BUFFER_INDEX_COMMAND] = in_val->command;
+        break;
+    case I2C_SMBUS_BYTE_DATA:
+        buf[I2C_BUFFER_INDEX_SIZE] = 2;
+        buf[I2C_BUFFER_INDEX_COMMAND] = in_val->command;
+        buf[I2C_BUFFER_INDEX_DATA_0] = data.byte;
+        break;
+    case I2C_SMBUS_WORD_DATA:
+    case I2C_SMBUS_PROC_CALL:
+        buf[I2C_BUFFER_INDEX_SIZE] = 3;
+        buf[I2C_BUFFER_INDEX_COMMAND] = in_val->command;
+        buf[I2C_BUFFER_INDEX_DATA_0] = (uint8_t)(data.word & 0xFF);
+        buf[I2C_BUFFER_INDEX_DATA_1] = (uint8_t)(data.word >> 8 & 0xFF);
+        break;
+    case I2C_SMBUS_BLOCK_DATA:
+    case I2C_SMBUS_I2C_BLOCK_BROKEN:
+    case I2C_SMBUS_I2C_BLOCK_DATA:
+    case I2C_SMBUS_BLOCK_PROC_CALL:
+        {
+            len = MIN(data.block[0], I2C_SMBUS_BLOCK_MAX);
+            buf[I2C_BUFFER_INDEX_SIZE] = len + 2; /* Command + Count + Data */
+            buf[I2C_BUFFER_INDEX_COMMAND] = in_val->command;
+            buf[I2C_BUFFER_INDEX_DATA_0] = len;
+            memcpy(&buf[I2C_BUFFER_INDEX_DATA_1], &data.block[1], len);
+        }
+        break;
+    default:
+        buf[I2C_BUFFER_INDEX_SIZE] = 0;
+        break;
+    }
+
+    backend->transaction_length = buf[I2C_BUFFER_INDEX_SIZE];
+    memcpy(backend->transaction_buf, &buf[I2C_BUFFER_INDEX_COMMAND],
+           backend->transaction_length);
+}
+
+/*
+ * remote_i2c_calculate_expected_recv_len:
+ * @cuse: The concrete CUSE backend instance.
+ *
+ * Inspects active IOCTL contexts (either SMBus reads or standard I2C_RDWR
+ * message arrays) to calculate the exact number of bytes expected to be read
+ * from the emulated I2C target.
+ */
+static void remote_i2c_calculate_expected_recv_len(RemoteI2CBackendCuse *cuse)
+{
+    RemoteI2CBackend *backend = REMOTE_I2C_BACKEND(cuse);
+    union i2c_smbus_data *smbus_data;
+    uint16_t size = 0;
+
+    if (cuse->in_data.last_cmd == I2C_SMBUS) {
+        size = cuse->in_data.in_smbus_data->size;
+        smbus_data = (union i2c_smbus_data *)(
+            cuse->in_data.in_buf + sizeof(struct i2c_smbus_ioctl_data)
+        );
+
+        switch (size) {
+        case I2C_SMBUS_QUICK:
+            backend->transaction_length = 0;
+            break;
+        case I2C_SMBUS_BYTE:
+        case I2C_SMBUS_BYTE_DATA:
+            backend->transaction_length = 1;
+            break;
+        case I2C_SMBUS_WORD_DATA:
+        case I2C_SMBUS_PROC_CALL:
+            backend->transaction_length = 2;
+            break;
+        case I2C_SMBUS_BLOCK_DATA:
+        case I2C_SMBUS_I2C_BLOCK_BROKEN:
+        case I2C_SMBUS_I2C_BLOCK_DATA:
+        case I2C_SMBUS_BLOCK_PROC_CALL:
+            backend->transaction_length = smbus_data->block[0];
+            if (backend->transaction_length == 0) {
+                backend->transaction_length = I2C_SMBUS_BLOCK_MAX;
+            }
+            break;
+        default:
+            backend->transaction_length = 0;
+            break;
+        }
+    } else if (cuse->in_data.last_cmd == I2C_RDWR) {
+        if (cuse->rdwr_msgs) {
+            backend->transaction_length = cuse->rdwr_msgs[cuse->msg_idx].len;
+        }
+    }
+}
+
+/*
+ * remote_i2c_deserialize_smbus_read:
+ * @cuse: The concrete CUSE backend instance.
+ *
+ * Packages raw bytes retrieved from QEMU's emulated I2C target back into the
+ * appropriate native Linux SMBus data union format.
+ */
+static void remote_i2c_deserialize_smbus_read(RemoteI2CBackendCuse *cuse)
+{
+    RemoteI2CBackend *backend = REMOTE_I2C_BACKEND(cuse);
+    union i2c_smbus_data *smbus_data = (union i2c_smbus_data *)(
+        cuse->in_data.in_buf + sizeof(struct i2c_smbus_ioctl_data)
+    );
+    uint16_t size = cuse->in_data.in_smbus_data->size;
+    uint8_t len = 0;
+
+    switch (size) {
+    case I2C_SMBUS_BYTE:
+    case I2C_SMBUS_BYTE_DATA:
+        smbus_data->byte = backend->transaction_buf[0];
+        break;
+    case I2C_SMBUS_WORD_DATA:
+    case I2C_SMBUS_PROC_CALL:
+        smbus_data->word = ((uint16_t)backend->transaction_buf[0]) & 0xFF;
+        smbus_data->word |=
+            (((uint16_t)backend->transaction_buf[1]) << 8) & 0xFF00;
+        break;
+    case I2C_SMBUS_BLOCK_DATA:
+    case I2C_SMBUS_BLOCK_PROC_CALL:
+        len = MIN(backend->transaction_buf[0], I2C_SMBUS_BLOCK_MAX);
+        smbus_data->block[0] = len;
+        memcpy(&smbus_data->block[1], &backend->transaction_buf[1], len);
+        break;
+    case I2C_SMBUS_I2C_BLOCK_DATA:
+    case I2C_SMBUS_I2C_BLOCK_BROKEN:
+        len = MIN(backend->transaction_length, I2C_SMBUS_BLOCK_MAX);
+        smbus_data->block[0] = len;
+        memcpy(&smbus_data->block[1], backend->transaction_buf, len);
+        break;
+    default:
+        break;
+    }
+
+    fuse_reply_ioctl(cuse->in_data.req, 0, smbus_data, sizeof(*smbus_data));
+}
+
+/*
+ * remote_i2c_update_slave_address:
+ * @cuse: The concrete CUSE backend instance.
+ * @req: The active FUSE request context handle.
+ * @address: The 7-bit target I2C slave address requested by the host OS.
+ *
+ * Validates and updates the transaction target device address in the shared
+ * backend state.
+ */
+static
+void remote_i2c_update_slave_address(RemoteI2CBackendCuse *cuse,
+                                     fuse_req_t req, long address)
+{
+    RemoteI2CBackend *backend = REMOTE_I2C_BACKEND(cuse);
+
+    if (address < 0 || address > 127) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
+    backend->address = address;
+    trace_remote_i2c_master_i2cdev_address(backend->address);
+}
+
+/*
+ * remote_i2c_advance_rdwr_sequence:
+ * @cuse: The concrete CUSE backend instance.
+ *
+ * Iterates through the batch vector array of standard native Linux `i2c_msg`
+ * blocks received during a multi-message I2C_RDWR ioctl operation. Populates
+ * the next message's direction, length, and payload buffer into the generic
+ * transaction state machine, advancing data offsets and preparing the master
+ * frontend bus state for an updated address phase.
+ */
+static void remote_i2c_advance_rdwr_sequence(RemoteI2CBackendCuse *cuse)
+{
+    RemoteI2CBackend *backend = REMOTE_I2C_BACKEND(cuse);
+    const struct i2c_msg *current_msg = NULL;
+
+    if (!cuse->rdwr_msgs || cuse->msg_idx >= cuse->nmsgs) {
+        backend->bus_state = I2C_BUS_END;
+        return;
+    }
+
+    current_msg = &cuse->rdwr_msgs[cuse->msg_idx];
+    remote_i2c_update_slave_address(cuse, cuse->in_data.req,
+                                    (long)current_msg->addr);
+
+    backend->transaction_length = current_msg->len;
+    backend->transaction_index = 0;
+    backend->addr_acked = false;
+    backend->data_acked = false;
+    backend->timed_out = false;
+
+    /* Evaluate sequence direction and staging boundaries */
+    if (current_msg->flags & I2C_M_RD) {
+        backend->is_recv = true;
+    } else {
+        backend->is_recv = false;
+
+        if ((cuse->rdwr_data_offset + current_msg->len) <=
+            cuse->rdwr_in_buf_size) {
+            memcpy(backend->transaction_buf,
+                   cuse->in_data.in_buf + cuse->rdwr_data_offset,
+                   current_msg->len);
+            cuse->rdwr_data_offset += current_msg->len;
+        } else {
+            backend->is_transaction_failed = true;
+            backend->bus_state = I2C_BUS_FINISHED;
+
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "Remote I2C Backend: Buffer overflow during RDWR "
+                          "deserialization. Message requests %u bytes, but "
+                          "only %zu bytes remain.\n",
+                          current_msg->len,
+                          (cuse->rdwr_in_buf_size - cuse->rdwr_data_offset));
+            return;
+        }
+    }
+
+    backend->bus_state = I2C_BUS_ADDR;
+}
+
+/*
+ * remote_i2c_cuse_on_tx_complete:
+ * @backend: Pointer to the abstract RemoteI2CBackend base structure.
+ *
+ * Implements the virtual execution callback triggered by the frontend master
+ * FSM when a given hardware I2C sub-transaction completes successfully.
+ * Manages protocol sequence vector chaining (such as multi-message RDWR
+ * arrays or atomic SMBus Write-then-Read phases). Once all phases complete,
+ * it packages retrieved byte payloads and terminates the active host OS IOCTL
+ * over FUSE.
+ */
+static void remote_i2c_cuse_on_tx_complete(RemoteI2CBackend *backend)
+{
+    RemoteI2CBackendCuse *cuse = REMOTE_I2C_BACKEND_CUSE(backend);
+    size_t available_space = 0;
+    size_t copy_len = 0;
+
+    /*
+     * If we were receiving data during an RDWR,
+     * copy it into the output buffer
+     */
+    if (cuse->in_data.last_cmd == I2C_RDWR && backend->is_recv) {
+        available_space = REMOTE_I2C_BACKEND_RDWR_BUF_LEN - cuse->rdwr_out_len;
+        copy_len = (backend->transaction_length < available_space) ?
+                          backend->transaction_length : available_space;
+
+        if (copy_len > 0) {
+            memcpy(cuse->rdwr_out_buf + cuse->rdwr_out_len,
+                   backend->transaction_buf,
+                   copy_len);
+            cuse->rdwr_out_len += copy_len;
+        }
+    }
+
+    /* Process Multi-Message Protocol Chaining Vectors */
+    if (cuse->in_data.last_cmd == I2C_SMBUS &&
+        cuse->smbus_restart_read &&
+        !backend->is_recv) {
+        backend->is_recv = true;
+        backend->transaction_index = 0;
+        remote_i2c_calculate_expected_recv_len(cuse);
+        remote_i2c_fsm_dispatch(backend->frontend, REMOTE_I2C_CMD_NEXT_MSG);
+        return;
+    } else if (cuse->in_data.last_cmd == I2C_RDWR) {
+        cuse->msg_idx++;
+
+        if (cuse->msg_idx < cuse->nmsgs) {
+            remote_i2c_advance_rdwr_sequence(cuse);
+            remote_i2c_fsm_dispatch(backend->frontend, REMOTE_I2C_CMD_NEXT_MSG);
+            return;
+        }
+    }
+
+    if (cuse->in_data.last_cmd == I2C_RDWR) {
+        fuse_reply_ioctl(cuse->in_data.req, cuse->nmsgs,
+                         cuse->rdwr_out_buf, cuse->rdwr_out_len);
+    } else if (cuse->in_data.last_cmd == I2C_SMBUS && backend->is_recv) {
+        if (backend->transaction_length > 0) {
+            remote_i2c_deserialize_smbus_read(cuse);
+        } else {
+            fuse_reply_ioctl(cuse->in_data.req, 0, NULL, 0);
+        }
+    } else {
+        fuse_reply_ioctl(cuse->in_data.req, 0, NULL, 0);
+    }
+
+    if (cuse->in_data.in_buf) {
+        g_free((gpointer)cuse->in_data.in_buf);
+        cuse->in_data.in_buf = NULL;
+        cuse->in_data.in_smbus_data = NULL;
+    }
+
+    cuse->ioctl_state = I2C_IOCTL_START;
+    cuse->last_ioctl = 0;
+    cuse->smbus_restart_read = false;
+}
+
+/*
+ * remote_i2c_cuse_reset_session:
+ * @cuse: The concrete CUSE backend instance.
+ *
+ * Internal helper to teardown and clear temporary transaction contexts.
+ */
+static void remote_i2c_cuse_reset_session(RemoteI2CBackendCuse *cuse)
+{
+    if (cuse->in_data.in_buf) {
+        g_free((gpointer)cuse->in_data.in_buf);
+        cuse->in_data.in_buf = NULL;
+        cuse->in_data.in_smbus_data = NULL;
+    }
+
+    cuse->ioctl_state = I2C_IOCTL_START;
+    cuse->last_ioctl = 0;
+    cuse->smbus_restart_read = false;
+}
+
+/*
+ * remote_i2c_cuse_on_tx_error:
+ * @backend: Pointer to the abstract RemoteI2CBackend base structure.
+ * @errno_code: The POSIX error number reflecting the nature of the failure.
+ *
+ * Implements the virtual execution callback triggered by the frontend master
+ * FSM when a hardware I2C transaction fails or aborts.
+ */
+static
+void remote_i2c_cuse_on_tx_error(RemoteI2CBackend *backend, int errno_code)
+{
+    RemoteI2CBackendCuse *cuse = REMOTE_I2C_BACKEND_CUSE(backend);
+
+    fuse_reply_err(cuse->in_data.req, errno_code);
+    remote_i2c_cuse_reset_session(cuse);
+}
+
+/*
+ * remote_i2c_cuse_init:
+ * @userdata: Arbitrary reference pointer registered at session startup.
+ * @conn: Struct mapping runtime driver features and limits for the connection.
+ *
+ * Virtual callback invoked by the FUSE infrastructure once the userspace
+ * character device mapping handshake completes successfully.
+ */
+static void remote_i2c_cuse_init(void *userdata, struct fuse_conn_info *conn)
+{
+    (void)userdata;
+    trace_remote_i2c_master_i2cdev_init();
+}
+
+/*
+ * remote_i2c_cuse_open:
+ * @req: The active FUSE request context handle.
+ * @fi: Driver metadata tracker for the targeted host file descriptor.
+ *
+ * Configures the communication channel when a host application requests
+ * access to the virtual character node (e.g., /dev/i2c-33). Clears baseline
+ * tracking flags, normalizes backend engine states, and invokes a safe reset
+ * of all active tracking buffers.
+ */
+static void remote_i2c_cuse_open(fuse_req_t req, struct fuse_file_info *fi)
+{
+    RemoteI2CBackendCuse *cuse = fuse_req_userdata(req);
+    RemoteI2CBackend *backend = REMOTE_I2C_BACKEND(cuse);
+
+    cuse->is_open = true;
+    cuse->ioctl_state = I2C_IOCTL_START;
+    cuse->last_ioctl = 0;
+
+    backend->bus_state = I2C_BUS_IDLE;
+    backend->is_recv = false;
+    backend->waiting_for_async = false;
+    backend->timed_out = false;
+
+    if (cuse->in_data.in_buf) {
+        g_free((gpointer)cuse->in_data.in_buf);
+        cuse->in_data.in_buf = NULL;
+    }
+
+    cuse->rdwr_msgs = NULL;
+
+    fuse_reply_open(req, fi);
+    trace_remote_i2c_master_i2cdev_open();
+}
+
+/*
+ * remote_i2c_cuse_release:
+ * @req: The active FUSE request context handle.
+ * @fi: Driver metadata tracker for the targeted host file descriptor.
+ *
+ * Handles formal close/teardown requests from user-space applications.
+ * Tears down mapping tables, releases structural heap components to avoid
+ * memory leaks, and resets the channel boundary flags to unlinked defaults.
+ */
+static void remote_i2c_cuse_release(fuse_req_t req, struct fuse_file_info *fi)
+{
+    RemoteI2CBackendCuse *cuse = fuse_req_userdata(req);
+    RemoteI2CBackend *backend = REMOTE_I2C_BACKEND(cuse);
+
+    cuse->is_open = false;
+    cuse->ioctl_state = I2C_IOCTL_START;
+    cuse->last_ioctl = 0;
+
+    backend->bus_state = I2C_BUS_IDLE;
+
+    g_free(cuse->in_data.in_buf);
+    cuse->in_data.in_buf = NULL;
+
+    cuse->rdwr_msgs = NULL;
+
+    fuse_reply_err(req, 0);
+    trace_remote_i2c_master_i2cdev_release();
+}
+
+/*
+ * remote_i2c_cuse_read:
+ * @req: The active FUSE request context handle.
+ * @size: Byte count window requested by the caller.
+ * @off: Seek offset identifier within the streaming channel context.
+ * @fi: Driver metadata tracker for the targeted host file descriptor.
+ *
+ * Implements standard char-node read interfaces. Because physical
+ * I2C operations are handled strictly via target-directed IOCTL vectors,
+ * this entry point is standard-compliant stub code returning 0 bytes (EOF).
+ */
+static void remote_i2c_cuse_read(fuse_req_t req, size_t size, off_t off,
+                                 struct fuse_file_info *fi)
+{
+    (void)size;
+    (void)off;
+    (void)fi;
+    fuse_reply_buf(req, NULL, 0);
+}
+
+/*
+ * remote_i2c_cuse_functional:
+ * @cuse: The concrete CUSE backend instance.
+ * @req: The active FUSE request context handle.
+ * @arg: Host memory location reference where data payload
+ *       outputs will be staged.
+ * @in_buf: Unused trailing verification packet buffer context.
+ *
+ * Implements the Linux I2C_FUNCS capability negotiation IOCTL
+ * interface. Emulates a two-phase FUSE configuration state loop: first
+ * prompts the kernel driver to fetch memory staging regions, and
+ * subsequently delivers the bitmask array defining what I2C/SMBus protocols
+ * this device translates.
+ */
+static void remote_i2c_cuse_functional(RemoteI2CBackendCuse *cuse,
+                                       fuse_req_t req,
+                                       void *arg,
+                                       const void *in_buf)
+{
+    unsigned long backend_functionality_mask = (
+        I2C_FUNC_I2C | I2C_FUNC_SMBUS_QUICK |
+        I2C_FUNC_SMBUS_BYTE | I2C_FUNC_SMBUS_BYTE_DATA |
+        I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_WORD_DATA |
+        I2C_FUNC_SMBUS_I2C_BLOCK
+    );
+
+    struct iovec target_memory_vector = {
+        .iov_base = arg,
+        .iov_len = sizeof(unsigned long)
+    };
+
+    switch (cuse->ioctl_state) {
+    case I2C_IOCTL_START:
+        cuse->ioctl_state = I2C_IOCTL_GET;
+        fuse_reply_ioctl_retry(req, NULL, 0, &target_memory_vector, 1);
+        break;
+    case I2C_IOCTL_GET:
+        fuse_reply_ioctl(req, 0, &backend_functionality_mask,
+                         sizeof(backend_functionality_mask));
+        cuse->ioctl_state = I2C_IOCTL_FINISHED;
+        trace_remote_i2c_master_i2cdev_functional();
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Remote I2C Backend: Invalid IOCTL state "
+                      "encountered in functionality query handler: %d\n",
+                      cuse->ioctl_state);
+        break;
+    }
+}
+
+/*
+ * remote_i2c_cuse_address:
+ * @cuse: The concrete CUSE backend instance.
+ * @req: The active FUSE request context handle.
+ * @arg: Untyped reference mapped by the host kernel conveying the target
+ *       address.
+ * @in_buf: Unused auxiliary input payload vector.
+ *
+ * Implements the standard Linux native I2C_SLAVE ioctl entry point.
+ */
+static void i2cdev_address(RemoteI2CBackendCuse *cuse,
+                           fuse_req_t req,
+                           void *arg,
+                           const void *in_buf)
+{
+    (void)in_buf;
+    remote_i2c_update_slave_address(cuse, req, (long)arg);
+    fuse_reply_ioctl(req, 0, NULL, 0);
+    cuse->ioctl_state = I2C_IOCTL_FINISHED;
+}
+
+/*
+ * remote_i2c_cuse_cmd_rdwr:
+ * @cuse: The concrete CUSE backend instance.
+ * @req: The active FUSE request context handle.
+ * @in_arg: Raw input memory reference targeting the calling process space.
+ * @in_buf: Staged kernel buffer payload delivered via the asynchronous
+ *          FUSE engine.
+ * @in_bufsz: Total layout size in bytes of the incoming data block.
+ * @out_bufsz: Output tracking limit size reserved by the calling process
+ *             framework.
+ *
+ * Implements the complex multi-phase Linux standard I2C_RDWR ioctl layer.
+ * Orchestrates an asynchronous four-phase FUSE data collection handshake loop
+ * (START -> GET -> RECV -> SEND) to fetch scatter-gather message vectors and
+ * payload blocks directly from host memory space before dispatching execution
+ * to the master frontend state machine.
+ */
+static void i2cdev_cmd_rdwr(RemoteI2CBackendCuse *cuse,
+                            fuse_req_t req,
+                            void *in_arg,
+                            const void *in_buf,
+                            size_t in_bufsz,
+                            size_t out_bufsz)
+{
+    RemoteI2CBackend *backend = REMOTE_I2C_BACKEND(cuse);
+    struct iovec in_iov[I2C_RDWR_IOCTL_MAX_MSGS + 2];
+    struct iovec out_iov[I2C_RDWR_IOCTL_MAX_MSGS];
+    const struct i2c_rdwr_ioctl_data *in_val = NULL;
+    void *buf_copy = NULL;
+    struct i2c_msg *msgs;
+    uint32_t out_cnt = 0;
+    uint32_t in_cnt = 0;
+    size_t header_len;
+    uint32_t i = 0;
+
+    if (cuse->ioctl_state == I2C_IOCTL_START) {
+        in_iov[0].iov_base = in_arg;
+        in_iov[0].iov_len = sizeof(struct i2c_rdwr_ioctl_data);
+        fuse_reply_ioctl_retry(req, in_iov, 1, NULL, 0);
+        cuse->ioctl_state = I2C_IOCTL_GET;
+        return;
+    }
+
+    if (in_bufsz < sizeof(struct i2c_rdwr_ioctl_data)) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
+    /*
+     * Create an isolated local copy of host memory packets for
+     * transaction context tracking
+     */
+    buf_copy = g_memdup2(in_buf, in_bufsz);
+    in_val = buf_copy;
+
+    if (cuse->in_data.in_buf) {
+        g_free((gpointer)cuse->in_data.in_buf);
+    }
+
+    cuse->in_data.last_cmd = I2C_RDWR;
+    cuse->in_data.req = req;
+    cuse->in_data.in_rdwr_data = in_val;
+    cuse->in_data.in_buf = buf_copy;
+
+    switch (cuse->ioctl_state) {
+    case I2C_IOCTL_GET:
+        if (in_val->nmsgs > I2C_RDWR_IOCTL_MAX_MSGS) {
+            fuse_reply_err(req, EINVAL);
+            return;
+        }
+        in_iov[0].iov_base = in_arg;
+        in_iov[0].iov_len = sizeof(struct i2c_rdwr_ioctl_data);
+        in_iov[1].iov_base = in_val->msgs;
+        in_iov[1].iov_len = in_val->nmsgs * sizeof(struct i2c_msg);
+
+        fuse_reply_ioctl_retry(req, in_iov, 2, NULL, 0);
+        cuse->ioctl_state = I2C_IOCTL_RECV;
+        break;
+
+    case I2C_IOCTL_RECV:
+        msgs = (
+            (struct i2c_msg *)(
+                (uint8_t *)in_buf + sizeof(struct i2c_rdwr_ioctl_data)
+            )
+        );
+
+        in_iov[in_cnt].iov_base = in_arg;
+        in_iov[in_cnt].iov_len = sizeof(struct i2c_rdwr_ioctl_data);
+        in_cnt++;
+
+        in_iov[in_cnt].iov_base = in_val->msgs;
+        in_iov[in_cnt].iov_len = in_val->nmsgs * sizeof(struct i2c_msg);
+        in_cnt++;
+
+        for (i = 0; i < in_val->nmsgs; i++) {
+            if (msgs[i].flags & I2C_M_RD) {
+                out_iov[out_cnt].iov_base = msgs[i].buf;
+                out_iov[out_cnt].iov_len = msgs[i].len;
+                out_cnt++;
+            } else {
+                in_iov[in_cnt].iov_base = msgs[i].buf;
+                in_iov[in_cnt].iov_len = msgs[i].len;
+                in_cnt++;
+            }
+        }
+
+        fuse_reply_ioctl_retry(req, in_iov, in_cnt, out_iov, out_cnt);
+        cuse->ioctl_state = I2C_IOCTL_SEND;
+        break;
+
+    case I2C_IOCTL_SEND:
+        header_len = sizeof(struct i2c_rdwr_ioctl_data);
+        cuse->nmsgs = in_val->nmsgs;
+
+        cuse->rdwr_msgs = (struct i2c_msg *)((uint8_t *)buf_copy + header_len);
+        cuse->rdwr_data_offset = (
+            header_len + (cuse->nmsgs * sizeof(struct i2c_msg))
+        );
+        cuse->rdwr_in_buf_size = in_bufsz;
+        cuse->rdwr_out_len = 0;
+        cuse->msg_idx = 0;
+
+        remote_i2c_advance_rdwr_sequence(cuse);
+        remote_i2c_fsm_dispatch(backend->frontend, REMOTE_I2C_CMD_START_TX);
+        break;
+
+    case I2C_IOCTL_FINISHED:
+        cuse->ioctl_state = I2C_IOCTL_START;
+        cuse->last_ioctl = 0;
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Remote I2C Backend: Invalid IOCTL state "
+                      "encountered in RDWR handler: %d\n",
+                      cuse->ioctl_state);
+        break;
+    }
+
+    trace_remote_i2c_master_i2cdev_smbus((uint8_t)cuse->ioctl_state);
+}
+
+/*
+ * remote_i2c_cuse_cmd_smbus:
+ * @cuse: The concrete CUSE backend instance.
+ * @req: The active FUSE request context handle.
+ * @in_arg: Raw input memory reference targeting the calling process
+ *          space.
+ * @in_buf: Staged kernel buffer payload delivered via the asynchronous
+ *          FUSE engine.
+ * @in_bufsz: Total layout size in bytes of the incoming data block.
+ * @out_bufsz: Output tracking limit size reserved by the calling process
+ *             framework.
+ *
+ * Implements the Linux standard I2C_SMBUS ioctl layer. Orchestrates an
+ * asynchronous multi-phase FUSE ioctl state pipeline
+ * (START -> GET -> RECV/SEND) to isolate SMBus transaction structures,
+ * evaluate specialized transfer cycles (like Write-then-Read Repeated Starts),
+ * and format parameters for the shared abstract frontend state engine.
+ */
+static void remote_i2c_cuse_cmd_smbus(RemoteI2CBackendCuse *cuse,
+                                      fuse_req_t req,
+                                      void *in_arg,
+                                      const void *in_buf,
+                                      size_t in_bufsz,
+                                      size_t out_bufsz)
+{
+    RemoteI2CBackend *backend = REMOTE_I2C_BACKEND(cuse);
+    const struct i2c_smbus_ioctl_data *in_val = NULL;
+    struct iovec in_iov[2];
+    size_t full_size = 0;
+    void *buf_copy = NULL;
+
+    if (cuse->ioctl_state == I2C_IOCTL_START) {
+        in_iov[0].iov_base = in_arg;
+        in_iov[0].iov_len = sizeof(struct i2c_smbus_ioctl_data);
+        fuse_reply_ioctl_retry(req, in_iov, 1, NULL, 0);
+        cuse->ioctl_state = I2C_IOCTL_GET;
+        return;
+    }
+
+    if (in_bufsz < sizeof(struct i2c_smbus_ioctl_data)) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
+    full_size = (
+        sizeof(struct i2c_smbus_ioctl_data) + sizeof(union i2c_smbus_data)
+    );
+    buf_copy = g_malloc0(full_size);
+    memcpy(buf_copy, in_buf, in_bufsz);
+
+    in_val = buf_copy;
+
+    in_iov[0].iov_base = in_arg;
+    in_iov[0].iov_len = sizeof(struct i2c_smbus_ioctl_data);
+
+    cuse->in_data.last_cmd = I2C_SMBUS;
+    cuse->in_data.req = req;
+    cuse->in_data.in_smbus_data = in_val;
+    cuse->in_data.in_buf = buf_copy;
+
+    /*
+     * Detect if this is an SMBus Block Read/Process Call that
+     * requires a write-then-read chain sequence.
+     */
+    if (in_val->read_write == I2C_SMBUS_READ &&
+        in_val->size != I2C_SMBUS_QUICK && in_val->size != I2C_SMBUS_BYTE) {
+        cuse->smbus_restart_read = true;
+    } else {
+        cuse->smbus_restart_read = false;
+    }
+
+    /* Guard check for Quick commands that do not transmit data pointers */
+    if (cuse->ioctl_state == I2C_IOCTL_GET && !in_val->read_write) {
+        if (!in_val->data) {
+            cuse->ioctl_state = I2C_IOCTL_SEND;
+        }
+    }
+
+    /*
+     * Execute subsequent streaming segments of the FUSE memory
+     * fetching engine.
+     */
+    switch (cuse->ioctl_state) {
+    case I2C_IOCTL_START:
+        break;
+    case I2C_IOCTL_GET:
+        if (in_val->read_write) {
+            struct iovec out_iov = {
+                .iov_base = in_val->data,
+                .iov_len = sizeof(union i2c_smbus_data)
+            };
+            fuse_reply_ioctl_retry(req, in_iov, 1, &out_iov, 1);
+            cuse->ioctl_state = I2C_IOCTL_RECV;
+        } else {
+            if (in_val->data) {
+                in_iov[1].iov_base = in_val->data;
+                in_iov[1].iov_len = sizeof(union i2c_smbus_data);
+                fuse_reply_ioctl_retry(req, in_iov, 2, NULL, 0);
+            }
+            cuse->ioctl_state = I2C_IOCTL_SEND;
+        }
+        break;
+    case I2C_IOCTL_RECV:
+    case I2C_IOCTL_SEND:
+        backend->is_recv = (cuse->ioctl_state == I2C_IOCTL_RECV);
+
+        /* If a restart read is required, the FIRST phase is always a Write */
+        if (cuse->smbus_restart_read) {
+            backend->is_recv = false;
+        }
+
+        remote_i2c_serialize_smbus_write(cuse, cuse->in_data.in_smbus_data);
+
+        if (backend->is_recv) {
+            remote_i2c_calculate_expected_recv_len(cuse);
+        }
+
+        remote_i2c_fsm_dispatch(backend->frontend, REMOTE_I2C_CMD_START_TX);
+        break;
+    case I2C_IOCTL_FINISHED:
+        cuse->ioctl_state = I2C_IOCTL_START;
+        cuse->last_ioctl = 0;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Remote I2C Backend: Invalid IOCTL state "
+                      "encountered in SMBus handler: %d\n",
+                      cuse->ioctl_state);
+        break;
+    }
+
+    trace_remote_i2c_master_i2cdev_smbus((uint8_t)cuse->ioctl_state);
+}
+
+/*
+ * remote_i2c_cuse_ioctl:
+ * @req: The active FUSE request context handle.
+ * @cmd: The specific Linux IOCTL command numeric ID arriving from the host
+ *       kernel.
+ * @arg: Untyped data pointer mapping process-space context memory arguments.
+ * @fi: Driver metadata tracker for the targeted host file descriptor.
+ * @flags: Configuration execution metrics for specialized runtime environments.
+ * @in_buf: Incoming data vector packet delivered over the channel boundary.
+ * @in_bufsz: Total available length footprint of the input buffer payload.
+ * @out_bufsz: Reserved buffer limit assigned by the calling system driver.
+ *
+ * Serves as the central multiplexing traffic cop for all arriving character
+ * device IOCTL calls. Intercepts Linux storage and interface flags, checks
+ * sequence lock states, and routes payload tasks cleanly down to dedicated
+ * parser sub-modules.
+ */
+static void remote_i2c_cuse_ioctl(fuse_req_t req, int cmd, void *arg,
+                         struct fuse_file_info *fi, unsigned flags,
+                         const void *in_buf, size_t in_bufsz, size_t out_bufsz)
+{
+    RemoteI2CBackendCuse *cuse = fuse_req_userdata(req);
+    unsigned int ctl = cmd;
+    (void)fi;
+
+    trace_remote_i2c_master_i2cdev_ioctl(cmd);
+
+    /*
+     * Guard against compatibility modes that violate
+     * the 64-bit boundary model
+     */
+    if (flags & FUSE_IOCTL_COMPAT) {
+        fuse_reply_err(req, ENOSYS);
+        return;
+    }
+
+    if (cuse->ioctl_state == I2C_IOCTL_START) {
+        cuse->last_ioctl = ctl;
+    } else if (cuse->last_ioctl != ctl) {
+        cuse->last_ioctl = 0;
+        cuse->ioctl_state = I2C_IOCTL_START;
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
+
+    switch (ctl) {
+    case I2C_SLAVE_FORCE:
+        /*
+         * Mapped for compliance; force-lock requests are
+         * acknowledged directly.
+         */
+        fuse_reply_ioctl(req, 0, NULL, 0);
+        break;
+    case I2C_FUNCS:
+        remote_i2c_cuse_functional(cuse, req, arg, in_buf);
+        break;
+    case I2C_SLAVE:
+        i2cdev_address(cuse, req, arg, in_buf);
+        break;
+    case I2C_SMBUS:
+        remote_i2c_cuse_cmd_smbus(cuse, req, arg, in_buf, in_bufsz, out_bufsz);
+        break;
+    case I2C_RDWR:
+        i2cdev_cmd_rdwr(cuse, req, arg, in_buf, in_bufsz, out_bufsz);
+        break;
+    default:
+        fuse_reply_err(req, ENOTTY);
+        break;
+    }
+
+    /* Normalize context states when a sub-transaction flow hits termination */
+    if (cuse->ioctl_state == I2C_IOCTL_FINISHED) {
+        cuse->ioctl_state = I2C_IOCTL_START;
+        cuse->last_ioctl = 0;
+        trace_remote_i2c_master_i2cdev_ioctl_finished(cmd);
+    }
+}
+
+/*
+ * remote_i2c_cuse_poll:
+ * @req: The active FUSE request context handle.
+ * @fi: Driver metadata tracker for the targeted host file descriptor.
+ * @ph: Unused. I2C is master-initiated request-response; no async events.
+ *
+ * Reports the device as always ready for read and write, matching the
+ * behaviour of the Linux kernel i2c-dev driver.
+ */
+static void remote_i2c_cuse_poll(fuse_req_t req, struct fuse_file_info *fi,
+                        struct fuse_pollhandle *ph)
+{
+    (void)ph;
+    fuse_reply_poll(req, POLL_IN | POLL_OUT);
+}
+
+static const struct cuse_lowlevel_ops i2cdev_ops = {
+    .init       = remote_i2c_cuse_init,
+    .open       = remote_i2c_cuse_open,
+    .release    = remote_i2c_cuse_release,
+    .read       = remote_i2c_cuse_read,
+    .ioctl      = remote_i2c_cuse_ioctl,
+    .poll       = remote_i2c_cuse_poll,
+};
+
+/*
+ * remote_i2c_read_fuse_export:
+ * @opaque: Dereferenced pointer targeting the concrete CUSE backend instance.
+ *
+ * Serves as the high-speed data pump registered into the QEMU main AioContext
+ * loop. Constantly flushes the character node descriptor, intercepting
+ * arriving kernel data blocks, processing loop structures, and preventing
+ * context blocking.
+ */
+static void remote_i2c_read_fuse_export(void *opaque)
+{
+    RemoteI2CBackendCuse *cuse = opaque;
+    int ret;
+
+    do {
+        ret = fuse_session_receive_buf(cuse->fuse_session, &cuse->fuse_buf);
+    } while (ret == -EINTR);
+
+    if (ret < 0) {
+        return;
+    }
+
+    fuse_session_process_buf(cuse->fuse_session, &cuse->fuse_buf);
+    trace_remote_i2c_master_fuse_io_read();
+}
+
+/*
+ * remote_i2c_fuse_export:
+ * @cuse: The concrete CUSE backend instance.
+ * @errp: Pointer tracking system initialization error telemetry.
+ *
+ * Configures argument vector clusters, allocates native multi-threaded
+ * system targets, builds character bindings via low-level libraries,
+ * and maps the resulting FUSE descriptor natively into QEMU's primary
+ * asynchronous loop handlers.
+ */
+int remote_i2c_fuse_export(RemoteI2CBackendCuse *cuse, Error **errp)
+{
+    GPtrArray *argv_ptr = g_ptr_array_new();
+    char *curdir = get_current_dir_name();
+    struct fuse_session *session = NULL;
+    struct cuse_info ci = { 0 };
+    char dev_name[128];
+    int multithreaded;
+    int ret;
+
+    /* Build clean FUSE parameter vectors manually */
+    g_ptr_array_add(argv_ptr, g_strdup("qemu-remote-i2c"));
+    g_ptr_array_add(argv_ptr, g_strdup("-f"));
+    g_ptr_array_add(argv_ptr, g_strdup("-s"));
+
+    if (cuse->debug) {
+        g_ptr_array_add(argv_ptr, g_strdup("-d"));
+    }
+
+    if (cuse->fuse_opts) {
+        char **opts = g_strsplit(cuse->fuse_opts, " ", -1);
+        for (int i = 0; opts[i] != NULL; i++) {
+            if (opts[i][0] != '\0') {
+                g_ptr_array_add(argv_ptr, g_strdup(opts[i]));
+            }
+        }
+        g_strfreev(opts);
+    }
+
+    /* Prevent stack overrides; enforce size-bounded buffer formatting */
+    snprintf(dev_name, sizeof(dev_name), "DEVNAME=%s", cuse->devname);
+    const char *dev_info_argv[] = { dev_name };
+
+    memset(&ci, 0, sizeof(ci));
+    ci.dev_major = 0;
+    ci.dev_minor = 0;
+    ci.dev_info_argc = 1;
+    ci.dev_info_argv = dev_info_argv;
+    ci.flags = CUSE_UNRESTRICTED_IOCTL;
+
+    session = cuse_lowlevel_setup(argv_ptr->len, (char **)argv_ptr->pdata,
+                                  &ci, &i2cdev_ops, &multithreaded, cuse);
+
+    g_ptr_array_set_free_func(argv_ptr, g_free);
+    g_ptr_array_free(argv_ptr, TRUE);
+
+    if (session == NULL) {
+        error_setg(errp, "Remote I2C Backend: cuse_lowlevel_setup() failed");
+        errno = EINVAL;
+        return -1;
+    }
+
+    ret = chdir(curdir);
+    if (ret == -1) {
+        error_setg(errp,
+                   "Remote I2C Backend: chdir() failed to restore root path");
+        return -1;
+    }
+
+    /*
+     * Link into QEMU's primary infrastructure loop for
+     * clean data multiplexing
+     */
+    cuse->ctx = iohandler_get_aio_context();
+    aio_set_fd_handler(cuse->ctx, fuse_session_fd(session),
+                       remote_i2c_read_fuse_export, NULL,
+                       NULL, NULL, cuse);
+    cuse->fuse_session = session;
+
+    trace_remote_i2c_master_fuse_export();
+    return 0;
+}
+
+/*
+ * remote_i2c_cuse_complete:
+ * @uc: Raw object handle routing back into the UserCreatable QOM
+ *      component interface.
+ * @errp: Pointer tracking system initialization error telemetry.
+ *
+ * Implements the standard QOM post-instantiation lifecycle callback.
+ * Asserts property constraint sanity checks before spinning up runtime
+ * export workers.
+ */
+static void remote_i2c_cuse_complete(UserCreatable *uc, Error **errp)
+{
+    RemoteI2CBackendCuse *cuse = REMOTE_I2C_BACKEND_CUSE(uc);
+
+    if (!cuse->devname) {
+        error_setg(errp, "remote-i2c-backend-cuse requires 'devname' property");
+        return;
+    }
+
+    if (remote_i2c_fuse_export(cuse, errp) < 0) {
+        return;
+    }
+}
+
+static void remote_i2c_cuse_class_init(ObjectClass *oc, const void *data)
+{
+    RemoteI2CBackendClass *bc = REMOTE_I2C_BACKEND_CLASS(oc);
+    UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
+
+    bc->on_tx_complete = remote_i2c_cuse_on_tx_complete;
+    bc->on_tx_error = remote_i2c_cuse_on_tx_error;
+
+    ucc->complete = remote_i2c_cuse_complete;
+
+    object_class_property_add_bool(oc, "debug",
+                                   cuse_get_debug, cuse_set_debug);
+    object_class_property_set_description(oc, "debug",
+                                          "Enable debug logging for CUSE backend");
+
+    object_class_property_add_str(oc, "devname",
+                                  cuse_get_devname, cuse_set_devname);
+    object_class_property_add_str(oc, "fuse-opts",
+                                  cuse_get_fuse_opts,
+                                  cuse_set_fuse_opts);
+}
+
+static const TypeInfo remote_i2c_cuse_info = {
+    .name = TYPE_REMOTE_I2C_BACKEND_CUSE,
+    .parent = TYPE_REMOTE_I2C_BACKEND,
+    .instance_size = sizeof(RemoteI2CBackendCuse),
+    .class_init = remote_i2c_cuse_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+static void remote_i2c_cuse_register_types(void)
+{
+    type_register_static(&remote_i2c_cuse_info);
+}
+
+type_init(remote_i2c_cuse_register_types)
diff --git a/hw/i2c/remote-i2c-fsm.c b/hw/i2c/remote-i2c-fsm.c
new file mode 100644
index 0000000000..cca35580f1
--- /dev/null
+++ b/hw/i2c/remote-i2c-fsm.c
@@ -0,0 +1,521 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Remote I2C Master Finite State Machine (FSM)
+ *
+ * This module implements a non-blocking, asynchronous Finite State Machine
+ * (FSM) for driving a QEMU I2C master. It bridges a remote backend (which
+ * issues transactions) with QEMU's internal I2C bus architecture.
+ *
+ * The FSM ensures that QEMU's main loop is not blocked during lengthy I2C
+ * transactions or when communicating with asynchronous I2C slave devices
+ * (which require simulated clock stretching).
+ *
+ * Execution Model:
+ * ----------------
+ * The state machine is driven by a QEMU Bottom Half (BH) loop
+ * (`remote_i2c_fsm_bh`).
+ *
+ * 1. Dispatch: The backend initiates a transaction via
+ *    `remote_i2c_fsm_dispatch` with `REMOTE_I2C_CMD_START_TX`.
+ * 2. Execution: The FSM processes a single byte or address frame, updates its
+ *    internal state, and then either re-schedules the BH immediately (for
+ *    synchronous devices) or sets a timer to wake up later.
+ * 3. Completion: Once the transaction finishes or errors out, control is
+ *    returned to the backend via `on_tx_complete` or `on_tx_error` callbacks.
+ *
+ * State Lifecycle:
+ * ----------------
+ * - I2C_BUS_IDLE     : Resting state. Awaits backend dispatch. Checks
+ *                      for bus busyness and handles retry timers if
+ *                      arbitration is lost.
+ * - I2C_BUS_ADDR     : Master asserts the bus and sends the slave address. If
+ *                      the slave NACKs, the transaction is immediately aborted
+ *                      (ENXIO). If ACKed, transitions to SEND, RECV,
+ *                      or WAIT_STRETCH.
+ * - I2C_BUS_SEND     : Pushes data bytes to the bus. Loops synchronously or
+ *                      yields asynchronously per byte.
+ * - I2C_BUS_RECV     : Reads data bytes from the bus. Similar yielding behavior
+ *                      as SEND.
+ * - I2C_BUS_WAIT_STRETCH : Yields execution back to QEMU to simulate clock
+ *                      stretching for async slaves or to enforce artificial
+ *                      delays (slow_delay_value_ms). Upon timer expiration,
+ *                      bounces back to SEND/RECV.
+ * - I2C_BUS_END      : Transitional state to guarantee `i2c_end_transfer` is
+ *                      called gracefully before finalizing.
+ * - I2C_BUS_FINISHED : Cleans up timers, releases the I2C bus, and invokes
+ *                      backend callbacks.
+ *
+ * Asynchronous Support & Clock Stretching:
+ * ----------------------------------------
+ * When communicating with asynchronous slave devices
+ * (`sc->send_async != NULL`), the FSM cannot process the entire transaction
+ * buffer in a single pass.
+ * Instead, it sends/receives a single byte, transitions to
+ * `I2C_BUS_WAIT_STRETCH`, and sets a virtual timer (`s->timer_step`). When
+ * the timer fires, the BH loop resumes processing the next byte. This
+ * effectively simulates hardware clock stretching without stalling the
+ * guest OS.
+ *
+ * Error Handling:
+ * ---------------
+ * - NACKs: Immediately abort the transaction and release the bus.
+ * - Bus Busy: If arbitration is lost, the module can either error out (EBUSY)
+ *   or back off and retry using a cooldown timer.
+ * - Timeouts: Monitored during `WAIT_STRETCH` to prevent hung transactions if
+ *   a remote slave becomes unresponsive.
+ * - Manual Abort: The backend can issue `REMOTE_I2C_CMD_ABORT` or `RESET` to
+ *   forcefully release the bus and reset the FSM.
+ *
+ * Author:
+ * Ilya Chichkov <ilya.chichkov.dev@gmail.com>
+ *
+ */
+#include "qemu/osdep.h"
+
+#include "qapi/error.h"
+#include "qemu/main-loop.h"
+#include "hw/i2c/i2c.h"
+#include "hw/core/qdev-properties-system.h"
+#include "qemu/error-report.h"
+#include "qemu/bswap.h"
+#include "qemu/aio.h"
+#include "qemu/log.h"
+#include "qapi/visitor.h"
+#include "hw/i2c/remote-i2c-cuse.h"
+#include "hw/i2c/remote-i2c-backend.h"
+#include "qapi/error.h"
+#include "trace.h"
+
+#include "hw/i2c/remote-i2c-master.h"
+
+#define I2C_BUS_BUSY_CHECK_TIMER_COOLDOWN_NS 50000
+
+typedef enum i2c_state_result {
+    I2C_HANDLER_OK,
+    I2C_HANDLER_ERROR,
+} i2c_state_result;
+
+static const char *remote_i2c_bus_state_str(int state)
+{
+    switch (state) {
+    case I2C_BUS_IDLE:          return "Idle";
+    case I2C_BUS_ADDR:          return "Address";
+    case I2C_BUS_SEND:          return "Send";
+    case I2C_BUS_RECV:          return "Receive";
+    case I2C_BUS_END:           return "End";
+    case I2C_BUS_FINISHED:      return "Finished";
+    case I2C_BUS_WAIT_STRETCH:  return "WaitStretch";
+    default:                    return "Unknown";
+    }
+}
+
+static
+void remote_i2c_fsm_change_bus_state(RemoteI2CMasterState *s, int new_state)
+{
+    uint16_t old_state = s->backend->bus_state;
+    s->backend->bus_state = new_state;
+
+    trace_remote_i2c_master_bus_state_change(
+        remote_i2c_bus_state_str(old_state),
+        remote_i2c_bus_state_str(new_state)
+    );
+}
+
+static
+void remote_i2c_abort_transaction(RemoteI2CMasterState *s,
+                                  int errno_code, const char *reason)
+{
+    RemoteI2CBackendClass *bc = REMOTE_I2C_BACKEND_GET_CLASS(s->backend);
+
+    timer_del(s->timer);
+    timer_del(s->timer_start_transmit);
+    timer_del(s->timer_step);
+
+    if (s->backend->bus_state != I2C_BUS_IDLE &&
+        s->backend->bus_state != I2C_BUS_FINISHED) {
+        i2c_end_transfer(s->bus);
+    }
+
+    i2c_bus_release(s->bus);
+    remote_i2c_fsm_change_bus_state(s, I2C_BUS_IDLE);
+
+    s->backend->is_transaction_failed = true;
+    s->backend->addr_acked = false;
+    s->backend->data_acked = false;
+    s->backend->timed_out = false;
+    s->backend->transaction_index = 0;
+    s->backend->waiting_for_async = false;
+
+    trace_remote_i2c_master_abort(errno_code,
+                                  s->backend->address,
+                                  reason ? reason : "Unknown error");
+
+    if (bc->on_tx_error) {
+        bc->on_tx_error(s->backend, errno_code);
+    }
+}
+
+static i2c_state_result remote_i2c_finish_handler(RemoteI2CMasterState *s)
+{
+    RemoteI2CBackendClass *bc = REMOTE_I2C_BACKEND_GET_CLASS(s->backend);
+
+    timer_del(s->timer);
+    timer_del(s->timer_start_transmit);
+    timer_del(s->timer_step);
+
+    if (s->backend->is_transaction_failed) {
+        remote_i2c_fsm_change_bus_state(s, I2C_BUS_IDLE);
+        i2c_end_transfer(s->bus);
+        i2c_bus_release(s->bus);
+        if (bc->on_tx_error) {
+            bc->on_tx_error(s->backend, EIO);
+        }
+        return I2C_HANDLER_ERROR;
+    }
+
+    remote_i2c_fsm_change_bus_state(s, I2C_BUS_IDLE);
+
+    /*
+     * Call on_tx_complete BEFORE ending or releasing the bus.
+     * If the backend chains another sub-message via REMOTE_I2C_CMD_NEXT_MSG
+     * (repeated start), it sets bus_state back to I2C_BUS_ADDR. In that case
+     * we must NOT call i2c_end_transfer (no STOP to the slave) and must NOT
+     * release the bus. Only issue STOP + release when the backend is truly done
+     * and bus_state remains IDLE.
+     */
+    if (bc->on_tx_complete) {
+        bc->on_tx_complete(s->backend);
+    }
+
+    if (s->backend->bus_state == I2C_BUS_IDLE) {
+        i2c_end_transfer(s->bus);
+        i2c_bus_release(s->bus);
+    }
+
+    return I2C_HANDLER_OK;
+}
+
+static
+void remote_i2c_is_slave_async(RemoteI2CMasterState *s)
+{
+    I2CNode *node;
+    I2CSlave *slave;
+    I2CSlaveClass *sc;
+
+    node = QLIST_FIRST(&s->bus->current_devs);
+    if (node) {
+        slave = node->elt;
+        sc = I2C_SLAVE_GET_CLASS(slave);
+        s->backend->is_slave_async = (sc->send_async != NULL);
+    } else {
+        s->backend->is_slave_async = false;
+    }
+}
+
+static
+void remote_i2c_send_ack(RemoteI2CMasterState *s)
+{
+    i2c_ack(s->bus);
+}
+
+static
+void remote_i2c_wait_stretch(RemoteI2CMasterState *s)
+{
+    timer_mod(s->timer,
+              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + s->backend->timeout_ms);
+    remote_i2c_fsm_change_bus_state(s, I2C_BUS_WAIT_STRETCH);
+}
+
+static
+void remote_i2c_stretch_clk(RemoteI2CMasterState *s, int64_t expire_timer)
+{
+    timer_mod(s->timer_step,
+              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + expire_timer);
+}
+
+static i2c_state_result remote_i2c_addr_handler(RemoteI2CMasterState *s)
+{
+    bool started_async = true;
+
+    s->backend->transaction_index = 0;
+    s->backend->is_transaction_failed = false;
+    s->backend->addr_acked = false;
+    s->backend->data_acked = false;
+    s->backend->timed_out = false;
+
+    if (s->backend->is_recv) {
+        trace_remote_i2c_master_i2cdev_receive(s->backend->transaction_length);
+
+        /* i2c_start_recv returns non-zero if the slave NACKs the address */
+        if (i2c_start_recv(s->bus, s->backend->address)) {
+            goto nack;
+        }
+
+        remote_i2c_is_slave_async(s);
+        if (s->backend->is_slave_async) {
+            remote_i2c_wait_stretch(s);
+            return I2C_HANDLER_OK;
+        }
+
+        s->backend->addr_acked = true;
+        remote_i2c_send_ack(s);
+        remote_i2c_fsm_change_bus_state(s, I2C_BUS_RECV);
+    } else {
+        trace_remote_i2c_master_i2cdev_send(s->backend->transaction_length);
+
+        if (i2c_start_send_async(s->bus, s->backend->address)) {
+            /*
+             * Fallback to synchronous send.
+             * If it still returns non-zero, it's a NACK.
+             */
+            if (i2c_start_send(s->bus, s->backend->address)) {
+                goto nack;
+            }
+            started_async = false;
+        }
+
+        if (started_async) {
+            remote_i2c_is_slave_async(s);
+        } else {
+            s->backend->is_slave_async = false;
+        }
+
+        if (s->backend->is_slave_async) {
+            remote_i2c_wait_stretch(s);
+            return I2C_HANDLER_OK;
+        }
+
+        s->backend->addr_acked = true;
+        remote_i2c_send_ack(s);
+        remote_i2c_fsm_change_bus_state(s, I2C_BUS_SEND);
+    }
+
+    return I2C_HANDLER_OK;
+
+nack:
+    remote_i2c_abort_transaction(s, ENXIO, "Address NACKed");
+
+    return I2C_HANDLER_ERROR;
+}
+
+static i2c_state_result remote_i2c_send_handler(RemoteI2CMasterState *s)
+{
+    uint8_t data = 0;
+    int ret = 0;
+
+    if (s->backend->is_slave_async && s->backend->data_acked) {
+        s->backend->data_acked = false;
+        s->backend->transaction_index++;
+    }
+
+    if (s->backend->transaction_index >= s->backend->transaction_length) {
+        remote_i2c_fsm_change_bus_state(s, I2C_BUS_END);
+        return I2C_HANDLER_OK;
+    }
+
+    if (s->backend->is_slave_async) {
+        data = s->backend->transaction_buf[s->backend->transaction_index];
+        trace_remote_i2c_master_send_byte(data);
+
+        i2c_send_async(s->bus, data);
+        remote_i2c_wait_stretch(s);
+        return I2C_HANDLER_OK;
+    }
+
+    for (; s->backend->transaction_index < s->backend->transaction_length;
+         s->backend->transaction_index++) {
+        data = s->backend->transaction_buf[s->backend->transaction_index];
+        trace_remote_i2c_master_send_byte(data);
+
+        ret = i2c_send(s->bus, data);
+        if (ret != 0) {
+            s->backend->is_transaction_failed = true;
+            remote_i2c_fsm_change_bus_state(s, I2C_BUS_END);
+            return I2C_HANDLER_ERROR;
+        }
+    }
+
+    remote_i2c_fsm_change_bus_state(s, I2C_BUS_END);
+    return I2C_HANDLER_OK;
+}
+
+static i2c_state_result remote_i2c_recv_handler(RemoteI2CMasterState *s)
+{
+    uint8_t buf = 0;
+
+    s->backend->data_acked = false;
+
+    if (s->backend->transaction_index < s->backend->transaction_length) {
+        buf = i2c_recv(s->bus);
+        trace_remote_i2c_master_recv_byte(buf);
+
+        s->backend->transaction_buf[s->backend->transaction_index] = buf;
+        s->backend->transaction_index++;
+    }
+
+    if (s->backend->transaction_index >= s->backend->transaction_length) {
+        remote_i2c_fsm_change_bus_state(s, I2C_BUS_END);
+        return I2C_HANDLER_OK;
+    }
+
+    if (s->backend->is_slave_async) {
+        remote_i2c_wait_stretch(s);
+    } else {
+        remote_i2c_send_ack(s);
+    }
+
+    return I2C_HANDLER_OK;
+}
+
+/*
+ * remote_i2c_fsm_bh:
+ * @opaque: Dereferenced generic pointer pointing to the RemoteI2CMasterState.
+ *
+ * Serves as the primary asynchronous Bottom Half (BH) scheduler and state
+ * dispatch loop for the frontend I2C hardware machine.
+ */
+void remote_i2c_fsm_bh(void *opaque)
+{
+    RemoteI2CMasterState *s = opaque;
+
+    s->backend->waiting_for_async = false;
+
+    switch (s->backend->bus_state) {
+    case I2C_BUS_IDLE:
+        break;
+    case I2C_BUS_ADDR:
+        remote_i2c_addr_handler(s);
+        break;
+    case I2C_BUS_SEND:
+        remote_i2c_send_handler(s);
+        break;
+    case I2C_BUS_RECV:
+        remote_i2c_recv_handler(s);
+        break;
+    case I2C_BUS_END:
+        remote_i2c_fsm_change_bus_state(s, I2C_BUS_FINISHED);
+        break;
+    case I2C_BUS_FINISHED:
+        remote_i2c_finish_handler(s);
+        break;
+    case I2C_BUS_WAIT_STRETCH:
+    case I2C_BUS_WAIT_RELEASE:
+        if (s->backend->timed_out) {
+            remote_i2c_abort_transaction(s, ETIMEDOUT,
+                                         "Timed out waiting for slave to "
+                                         "release clock stretching");
+            return;
+        }
+
+        if (!s->delay_completed && s->slow_delay_value_ms > 0) {
+            s->delay_completed = true;
+            remote_i2c_stretch_clk(s, s->slow_delay_value_ms * 1000000ULL);
+            trace_remote_i2c_master_stretch_delay(s->slow_delay_value_ms);
+            return;
+        }
+
+        s->delay_completed = false;
+
+        timer_del(s->timer);
+        timer_del(s->timer_start_transmit);
+        timer_del(s->timer_step);
+
+        if (!s->backend->addr_acked) {
+            trace_remote_i2c_master_async_ack();
+            s->backend->addr_acked = true;
+            s->backend->data_acked = s->backend->is_recv;
+        } else {
+            trace_remote_i2c_master_async_ack();
+            s->backend->data_acked = true;
+        }
+
+        if (s->backend->is_recv) {
+            remote_i2c_fsm_change_bus_state(s, I2C_BUS_RECV);
+            remote_i2c_recv_handler(s);
+        } else {
+            remote_i2c_fsm_change_bus_state(s, I2C_BUS_SEND);
+            remote_i2c_send_handler(s);
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Remote I2C Master: Invalid bus state %d\n",
+                      s->backend->bus_state);
+        remote_i2c_abort_transaction(s, EINVAL, "Invalid FSM state");
+        break;
+    }
+
+    /* Reschedule Logic */
+    if (s->backend->bus_state != I2C_BUS_IDLE &&
+        s->backend->bus_state != I2C_BUS_WAIT_STRETCH) {
+        qemu_bh_schedule(s->bh);
+    }
+}
+
+static void remote_i2c_bus_start_transmit(RemoteI2CMasterState *s)
+{
+    RemoteI2CBackendClass *bc = REMOTE_I2C_BACKEND_GET_CLASS(s->backend);
+
+    if (i2c_bus_busy(s->bus)) {
+        if (s->raise_arbitrage_lost) {
+            if (bc->on_tx_error) {
+                bc->on_tx_error(s->backend, EBUSY);
+            }
+            return;
+        } else {
+            timer_mod(s->timer_start_transmit,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                      I2C_BUS_BUSY_CHECK_TIMER_COOLDOWN_NS);
+            return;
+        }
+    }
+
+    remote_i2c_fsm_change_bus_state(s, I2C_BUS_ADDR);
+
+    i2c_bus_master(s->bus, s->bh);
+    i2c_schedule_pending_master(s->bus);
+}
+
+void remote_i2c_fsm_dispatch(RemoteI2CMasterState *s, RemoteI2CCommand cmd)
+{
+    switch (cmd) {
+    case REMOTE_I2C_CMD_START_TX:
+        remote_i2c_bus_start_transmit(s);
+        break;
+    case REMOTE_I2C_CMD_NEXT_MSG:
+        /*
+         * Repeated START: the bus is already held from the previous
+         * sub-transaction. Skip bus acquisition and go straight to the
+         * address phase so the slave sees Sr (repeated start) not a
+         * full STOP+START cycle.
+         *
+         * Do NOT schedule the BH here. The BH reschedule logic at the
+         * bottom of remote_i2c_fsm_bh will schedule it once state=ADDR
+         * is visible on the next iteration.
+         */
+        remote_i2c_fsm_change_bus_state(s, I2C_BUS_ADDR);
+        break;
+    case REMOTE_I2C_CMD_ABORT:
+        remote_i2c_abort_transaction(s, ECANCELED,
+                                     "Transaction aborted by backend");
+        break;
+    case REMOTE_I2C_CMD_RESET:
+        if (s->backend->bus_state != I2C_BUS_IDLE &&
+            s->backend->bus_state != I2C_BUS_FINISHED) {
+            i2c_end_transfer(s->bus);
+        }
+        i2c_bus_release(s->bus);
+        remote_i2c_fsm_change_bus_state(s, I2C_BUS_IDLE);
+        s->backend->is_transaction_failed = false;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Remote I2C Master: Invalid command %d\n", cmd);
+        break;
+    }
+}
+
+void remote_i2c_fsm_timer_start_transmit_cb(void *opaque)
+{
+    remote_i2c_bus_start_transmit(opaque);
+}
diff --git a/hw/i2c/remote-i2c-master.c b/hw/i2c/remote-i2c-master.c
new file mode 100644
index 0000000000..0fe522b805
--- /dev/null
+++ b/hw/i2c/remote-i2c-master.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Remote I2C Master
+ *
+ * This device exposes a QEMU I2C bus to the host system. Utilizing a decoupled
+ * backend architecture (such as the CUSE backend), it allows external programs
+ * or scripts on the host to interact with I2C slaves simulated inside QEMU as
+ * if they were real hardware devices attached to the host.
+ *
+ * Features:
+ * - Clean Frontend/Backend separation for transport-agnostic I2C emulation.
+ * - Implements the Linux I2C ioctl interface (I2C_RDWR, I2C_SMBUS) via CUSE.
+ * - Supports standard I2C and SMBus protocols.
+ * - Handles asynchronous I2C transactions and clock stretching via QEMU
+ *   Bottom Halves (BH).
+ * - Configurable asynchronous slave timeouts (e.g., timeout-ms).
+ * - Supports SMBus "Repeated Start" for atomic Write-then-Read operations.
+ *
+ * Usage:
+ * Add the backend object and the master device to your QEMU command line:
+ *
+ *   -object remote-i2c-backend-cuse,id=my_cuse_backend,devname=i2c-33 \
+ *   -device remote-i2c-master,i2cbus=/machine/soc[0]/i2c[0]/i2c,\
+ *           backend=my_cuse_backend,timeout-ms=8000
+ *
+ * This creates a character device at /dev/i2c-33 on the host.
+ * Use standard tools (i2c-tools) or C programs to access it:
+ *
+ *   i2cdetect -y -l
+ *   i2cget -y <bus_id> <addr> <reg>
+ *
+ * Author:
+ * Ilya Chichkov <ilya.chichkov.dev@gmail.com>
+ *
+ */
+#include "qemu/osdep.h"
+
+#include "qapi/error.h"
+#include "qemu/main-loop.h"
+#include "hw/i2c/i2c.h"
+#include "hw/core/qdev-properties-system.h"
+#include "qemu/error-report.h"
+#include "qemu/bswap.h"
+#include "qemu/aio.h"
+#include "qemu/log.h"
+#include "qapi/visitor.h"
+#include "qapi/error.h"
+#include "trace.h"
+
+#include "hw/i2c/remote-i2c-master.h"
+
+static void remote_i2c_timer_cb(void *opaque)
+{
+    RemoteI2CMasterState *s = opaque;
+
+    if (s->backend->bus_state == I2C_BUS_WAIT_STRETCH) {
+        trace_remote_i2c_master_timeout(s->backend->timeout_ms);
+        s->backend->timed_out = true;
+        qemu_bh_schedule(s->bh);
+    } else if (s->backend->bus_state != I2C_BUS_IDLE &&
+               s->backend->bus_state != I2C_BUS_WAIT_STRETCH) {
+        /* Retry logic */
+        timer_mod(s->timer_start_transmit,
+                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 50000);
+    }
+}
+
+static void remote_i2c_timer_step_cb(void *opaque)
+{
+    RemoteI2CMasterState *s = opaque;
+    qemu_bh_schedule(s->bh);
+}
+
+static void remote_i2c_master_realize(DeviceState *dev, Error **errp)
+{
+    RemoteI2CMasterState *s = REMOTE_I2C_MASTER(dev);
+
+    if (!s->backend) {
+        error_setg(errp, "remote-i2c-master requires a 'backend' property");
+        return;
+    }
+
+    s->backend->frontend = s;
+    s->backend->timeout_ms = s->timeout_ms;
+
+    s->bh = aio_bh_new_guarded(qemu_get_aio_context(),
+                               remote_i2c_fsm_bh,
+                               s,
+                               &dev->mem_reentrancy_guard);
+
+    s->timer = timer_new(QEMU_CLOCK_VIRTUAL, SCALE_MS,
+                         &remote_i2c_timer_cb, s);
+    s->timer_start_transmit = timer_new(QEMU_CLOCK_VIRTUAL,
+                                        SCALE_NS,
+                                        &remote_i2c_fsm_timer_start_transmit_cb,
+                                        s);
+    s->timer_step = timer_new(QEMU_CLOCK_VIRTUAL, SCALE_NS,
+                              &remote_i2c_timer_step_cb, s);
+}
+
+static void remote_i2c_master_reset(Object *obj, ResetType type)
+{
+    RemoteI2CMasterState *s = REMOTE_I2C_MASTER(obj);
+
+    /* remote_i2c_fsm_dispatch is defined in remote-i2c-fsm.c */
+    remote_i2c_fsm_dispatch(s, REMOTE_I2C_CMD_RESET);
+}
+
+static const Property remote_i2c_master_properties[] = {
+    DEFINE_PROP_LINK("i2cbus", RemoteI2CMasterState, bus,
+                     TYPE_I2C_BUS, I2CBus *),
+    DEFINE_PROP_STRING("name", RemoteI2CMasterState, name),
+    DEFINE_PROP_LINK("backend", RemoteI2CMasterState, backend,
+                     TYPE_REMOTE_I2C_BACKEND, RemoteI2CBackend *),
+    DEFINE_PROP_BOOL("raise_arbitrage_lost",
+                     RemoteI2CMasterState,
+                     raise_arbitrage_lost, false),
+    DEFINE_PROP_UINT32("timeout-ms",
+                       RemoteI2CMasterState, timeout_ms, 1000),
+};
+
+static void remote_i2c_master_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    device_class_set_props(dc, remote_i2c_master_properties);
+    dc->realize = remote_i2c_master_realize;
+    dc->desc = "Remote I2C Controller";
+    rc->phases.enter = remote_i2c_master_reset;
+}
+
+static const TypeInfo remote_i2c_master_info = {
+    .name          = TYPE_REMOTE_I2C_MASTER,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(RemoteI2CMasterState),
+    .class_init    = remote_i2c_master_class_init,
+};
+
+static void remote_i2c_master_register_types(void)
+{
+    type_register_static(&remote_i2c_master_info);
+}
+
+type_init(remote_i2c_master_register_types)
diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
index 1ad0e95c0e..c08cdef7d9 100644
--- a/hw/i2c/trace-events
+++ b/hw/i2c/trace-events
@@ -61,3 +61,32 @@ pca954x_read_data(uint8_t value) "PCA954X read data: 0x%02x"
 
 imx_i2c_read(const char *id, const char *reg, uint64_t ofs, uint64_t value) "%s:[%s (0x%" PRIx64 ")] -> 0x%02" PRIx64
 imx_i2c_write(const char *id, const char *reg, uint64_t ofs, uint64_t value) "%s:[%s (0x%" PRIx64 ")] <- 0x%02" PRIx64
+
+# remote-i2c-master.c
+remote_i2c_master_realize(void) "device realized"
+remote_i2c_master_reset_enter(void) "reset enter"
+remote_i2c_master_backend_select(const char *backend) "selected backend: %s"
+
+# remote-i2c-fsm.c
+remote_i2c_master_bus_state_change(const char *old, const char *new) "bus State: %s -> %s"
+remote_i2c_master_async_ack(void) "async ACK received"
+remote_i2c_master_abort(int error, uint8_t addr, const char *reason) "transaction ABORTED (errno=%d) addr=0x%02x, reason: %s"
+remote_i2c_master_timeout(uint16_t timeout) "watchdog timer expired (timeout_ms=%d)"
+remote_i2c_master_stretch_delay(uint16_t delay) "master simulating stretch delay: %d"
+remote_i2c_master_send_byte(uint8_t byte) "wire TX: 0x%02x"
+remote_i2c_master_recv_byte(uint8_t byte) "wire RX: 0x%02x"
+remote_i2c_master_arbitration_lost(const char *abort_transaction) "arbitration lost, %s"
+
+# remote-i2c-cuse.c
+remote_i2c_master_fuse_export(void) "FUSE session setup complete"
+remote_i2c_master_fuse_io_read(void) "FUSE event loop: reading buf"
+remote_i2c_master_i2cdev_init(void) "CUSE init"
+remote_i2c_master_i2cdev_open(void) "CUSE open"
+remote_i2c_master_i2cdev_release(void) "CUSE release"
+remote_i2c_master_i2cdev_ioctl(int cmd) "IOCTL Start cmd: 0x%x"
+remote_i2c_master_i2cdev_ioctl_finished(int cmd) "IOCTL Finish cmd: 0x%x"
+remote_i2c_master_i2cdev_functional(void) "IOCTL: Query Functionality"
+remote_i2c_master_i2cdev_address(uint32_t address) "IOCTL: Set slave address: 0x%x"
+remote_i2c_master_i2cdev_smbus(uint8_t state) "IOCTL: SMBus machine state: 0x%x"
+remote_i2c_master_i2cdev_send(uint32_t size) "TX start size: 0x%x"
+remote_i2c_master_i2cdev_receive(uint32_t size) "RX start size: 0x%x"
diff --git a/include/hw/i2c/remote-i2c-backend.h b/include/hw/i2c/remote-i2c-backend.h
new file mode 100644
index 0000000000..bbc71435db
--- /dev/null
+++ b/include/hw/i2c/remote-i2c-backend.h
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Remote I2C Backend (Abstract Base Class)
+ *
+ * This module defines the abstract backend interface for the Remote I2C Master.
+ * It provides the QEMU Object Model (QOM) base class that strictly decouples
+ * the internal QEMU I2C hardware state machine (the frontend) from
+ * host-specific transport layers.
+ *
+ * Author:
+ * Ilya Chichkov <ilya.chichkov.dev@gmail.com>
+ *
+ */
+#ifndef HW_REMOTE_I2C_BACKEND_H
+#define HW_REMOTE_I2C_BACKEND_H
+
+#include "qemu/osdep.h"
+#include "qom/object.h"
+
+typedef enum i2c_bus_state {
+    I2C_BUS_IDLE,
+    I2C_BUS_ADDR,
+    I2C_BUS_SEND,
+    I2C_BUS_RECV,
+    I2C_BUS_END,
+    I2C_BUS_FINISHED,
+    I2C_BUS_WAIT_STRETCH,
+    I2C_BUS_WAIT_RELEASE,
+} i2c_bus_state;
+
+typedef struct RemoteI2CMasterState RemoteI2CMasterState;
+
+#define TYPE_REMOTE_I2C_BACKEND "remote-i2c-backend"
+OBJECT_DECLARE_TYPE(RemoteI2CBackend, RemoteI2CBackendClass, REMOTE_I2C_BACKEND)
+
+#define REMOTE_I2C_BACKEND_BUF_LEN      256
+#define REMOTE_I2C_BACKEND_RDWR_BUF_LEN 260
+
+struct RemoteI2CBackend {
+    Object parent_obj;
+
+    RemoteI2CMasterState *frontend;
+
+    /* Transaction State */
+    uint8_t  transaction_buf[REMOTE_I2C_BACKEND_BUF_LEN];
+    uint16_t transaction_index;
+    uint16_t transaction_length;
+
+    bool is_recv;
+    bool is_master_pending;
+    bool is_transaction_failed;
+    bool is_slave_async;
+    bool waiting_for_async;
+    bool addr_acked;
+    bool data_acked;
+    bool timed_out;
+    uint32_t timeout_ms;
+
+    i2c_bus_state bus_state;
+    long address;
+};
+
+struct RemoteI2CBackendClass {
+    ObjectClass parent_class;
+
+    void (*on_tx_complete)(RemoteI2CBackend *backend);
+    void (*on_tx_error)(RemoteI2CBackend *backend, int errno_code);
+};
+
+#endif /* HW_REMOTE_I2C_BACKEND_H */
diff --git a/include/hw/i2c/remote-i2c-cuse.h b/include/hw/i2c/remote-i2c-cuse.h
new file mode 100644
index 0000000000..b0940122bf
--- /dev/null
+++ b/include/hw/i2c/remote-i2c-cuse.h
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Remote I2C Master
+ *
+ * This device exposes a QEMU I2C bus to the host system via a FUSE (CUSE)
+ * character device. It allows external programs or scripts on the host to
+ * interact with I2C slaves simulated inside QEMU as if they were real hardware
+ * devices attached to the host.
+ *
+ * Features:
+ * - Implements the Linux I2C ioctl interface (I2C_RDWR, I2C_SMBUS).
+ * - Supports standard I2C and SMBus protocols.
+ * - Handles asynchronous I2C transactions via QEMU's Bottom Halves (BH).
+ * - Supports SMBus "Repeated Start" for atomic Write-then-Read operations.
+ *
+ * Usage:
+ * Add the device to QEMU:
+ * "-device remote-i2c-master,i2cbus=i2c-bus.0,devname=i2c-33"
+ * This creates a character device at /dev/i2c-33 on the host.
+ * Use standard tools (i2c-tools) or C programs to access it:
+ * i2cdetect -y -l
+ * i2cget -y <bus_id> <addr> <reg>
+ *
+ * Author:
+ * Ilya Chichkov <ilya.chichkov.dev@gmail.com>
+ *
+ */
+#ifndef HW_REMOTE_I2C_MASTER_BC_CUSE_H
+#define HW_REMOTE_I2C_MASTER_BC_CUSE_H
+
+#include "qom/object_interfaces.h"
+#include "hw/i2c/remote-i2c-backend.h"
+
+/* OS and Transport specifics stay HERE */
+#define FUSE_USE_VERSION 31
+#include <fuse3/fuse.h>
+#include <fuse3/cuse_lowlevel.h>
+#include <linux/i2c.h>
+#include <linux/i2c-dev.h>
+
+#define TYPE_REMOTE_I2C_BACKEND_CUSE "remote-i2c-backend-cuse"
+OBJECT_DECLARE_SIMPLE_TYPE(RemoteI2CBackendCuse, REMOTE_I2C_BACKEND_CUSE)
+
+typedef enum i2c_ioctl_state {
+    I2C_IOCTL_START,
+    I2C_IOCTL_GET,
+    I2C_IOCTL_RECV,
+    I2C_IOCTL_SEND,
+    I2C_IOCTL_FINISHED,
+} i2c_ioctl_state;
+
+struct remote_i2c_in_data {
+    unsigned int last_cmd;
+    fuse_req_t req;
+    const struct i2c_smbus_ioctl_data *in_smbus_data;
+    const struct i2c_rdwr_ioctl_data *in_rdwr_data;
+    void *in_buf;
+};
+
+struct RemoteI2CBackendCuse {
+    RemoteI2CBackend parent_obj;
+
+    /* Config Properties */
+    char *devname;
+    char *fuse_opts;
+    bool debug;
+
+    /* FUSE Session State */
+    AioContext *ctx;
+    struct fuse_session *fuse_session;
+    struct fuse_buf fuse_buf;
+    bool is_open;
+
+    /* CUSE IOCTL State Helpers */
+    i2c_ioctl_state ioctl_state;
+    uint32_t last_ioctl;
+    struct remote_i2c_in_data in_data;
+    bool smbus_restart_read;
+
+    /* RDWR OS-Level Support */
+    struct i2c_msg *rdwr_msgs;
+    uint32_t nmsgs;
+    uint32_t msg_idx;
+    size_t rdwr_data_offset;
+    size_t rdwr_in_buf_size;
+    uint8_t rdwr_out_buf[REMOTE_I2C_BACKEND_RDWR_BUF_LEN];
+    size_t rdwr_out_len;
+};
+
+/* CUSE-Specific Prototypes */
+int remote_i2c_fuse_export(RemoteI2CBackendCuse *cuse, Error **errp);
+
+#endif /* HW_REMOTE_I2C_MASTER_BC_CUSE_H */
diff --git a/include/hw/i2c/remote-i2c-master.h b/include/hw/i2c/remote-i2c-master.h
new file mode 100644
index 0000000000..61aee23b2b
--- /dev/null
+++ b/include/hw/i2c/remote-i2c-master.h
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Remote I2C Master
+ *
+ * This device exposes a QEMU I2C bus to the host system via a FUSE (CUSE)
+ * character device. It allows external programs or scripts on the host to
+ * interact with I2C slaves simulated inside QEMU as if they were real hardware
+ * devices attached to the host.
+ *
+ * Features:
+ * - Implements the Linux I2C ioctl interface (I2C_RDWR, I2C_SMBUS).
+ * - Supports standard I2C and SMBus protocols.
+ * - Handles asynchronous I2C transactions via QEMU's Bottom Halves (BH).
+ * - Supports SMBus "Repeated Start" for atomic Write-then-Read operations.
+ *
+ * Usage:
+ * Add the device to QEMU:
+ * "-device remote-i2c-master,i2cbus=i2c-bus.0,devname=i2c-33"
+ * This creates a character device at /dev/i2c-33 on the host.
+ * Use standard tools (i2c-tools) or C programs to access it:
+ * i2cdetect -y -l
+ * i2cget -y <bus_id> <addr> <reg>
+ *
+ * Author:
+ * Ilya Chichkov <ilya.chichkov.dev@gmail.com>
+ *
+ */
+#ifndef HW_REMOTE_I2C_MASTER_H
+#define HW_REMOTE_I2C_MASTER_H
+
+#include "hw/core/sysbus.h"
+#include <linux/i2c.h>
+#include <linux/i2c-dev.h>
+#include "hw/i2c/remote-i2c-backend.h"
+
+#define TYPE_REMOTE_I2C_MASTER "remote-i2c-master"
+
+#define REMOTE_I2C_MASTER(obj) \
+    OBJECT_CHECK(RemoteI2CMasterState, (obj), TYPE_REMOTE_I2C_MASTER)
+
+typedef enum {
+    REMOTE_I2C_CMD_START_TX,
+    REMOTE_I2C_CMD_NEXT_MSG,
+    REMOTE_I2C_CMD_ABORT,
+    REMOTE_I2C_CMD_RESET
+} RemoteI2CCommand;
+
+typedef struct RemoteI2CMasterState {
+    DeviceState parent_obj;
+
+    I2CBus *bus;
+    char *name;
+
+    /* QOM Link to the abstract Backend */
+    RemoteI2CBackend *backend;
+
+    QEMUTimer *timer;
+    QEMUTimer *timer_start_transmit;
+    QEMUTimer *timer_step;
+    QEMUTimer *slow_master_timer;
+    QEMUBH *bh;
+    MemReentrancyGuard bh_guard;
+
+    uint32_t timeout_ms;
+    uint32_t default_stretch_delay_ms;
+    bool slow_delay_enable;
+    uint32_t slow_delay_value_ms;
+    bool raise_arbitrage_lost;
+    bool delay_completed;
+
+} RemoteI2CMasterState;
+
+void remote_i2c_fsm_dispatch(RemoteI2CMasterState *s, RemoteI2CCommand cmd);
+void remote_i2c_fsm_timer_start_transmit_cb(void *opaque);
+void remote_i2c_fsm_bh(void *opaque);
+
+#endif /* HW_REMOTE_I2C_MASTER_H */
diff --git a/qapi/qom.json b/qapi/qom.json
index dd45ac1087..c82af930cc 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1258,6 +1258,7 @@
     'tls-creds-psk',
     'tls-creds-x509',
     'tls-cipher-suites',
+    'remote-i2c-backend-cuse',
     { 'name': 'x-remote-object', 'features': [ 'unstable' ] },
     { 'name': 'x-vfio-user-server', 'features': [ 'unstable' ] }
   ] }
@@ -1334,6 +1335,7 @@
       'tls-creds-psk':              'TlsCredsPskProperties',
       'tls-creds-x509':             'TlsCredsX509Properties',
       'tls-cipher-suites':          'TlsCredsProperties',
+      'remote-i2c-backend-cuse':    'RemoteI2CBackendCuseProperties',
       'x-remote-object':            'RemoteObjectProperties',
       'x-vfio-user-server':         'VfioUserServerProperties'
   } }
@@ -1377,3 +1379,30 @@
 ##
 { 'command': 'object-del', 'data': {'id': 'str'},
   'allow-preconfig': true }
+
+##
+# @RemoteI2CBackendCuseProperties:
+#
+# Properties for the CUSE remote I2C backend.
+#
+# @devname: The name of the character device node to create under /dev
+#     (e.g., 'i2c-33' creates /dev/i2c-33).  The node is accessible
+#     via the standard Linux I2C device interface and usable directly
+#     with i2c-tools and the Linux i2c-dev API.
+#
+# @fuse-opts: Space-separated list of options passed verbatim to the
+#     FUSE/CUSE session at mount time (e.g., '-d' or '--debug
+#     --allow-other').  See mount.fuse(8) for the full list of
+#     supported options.
+#
+# @debug: Convenience shorthand for passing '--debug' in @fuse-opts.
+#     Enables verbose FUSE request/reply tracing on stderr.  Equivalent
+#     to adding '--debug' to @fuse-opts explicitly.
+#
+# Since: 11.2
+##
+{ 'struct': 'RemoteI2CBackendCuseProperties',
+  'data': { 'devname': 'str',
+            '*fuse-opts': 'str',
+            '*debug': 'bool' },
+  'if': 'CONFIG_LINUX'}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 4897325d84..82536b0751 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -54,6 +54,7 @@ qtests_i386 = \
   (slirp.found() ? ['pxe-test'] : []) + \
   qtests_filter + \
   (config_all_devices.has_key('CONFIG_ACPI_VMGENID') ? ['vmgenid-test'] : []) +             \
+  (config_all_devices.has_key('CONFIG_REMOTE_I2C_MASTER') and host_os == 'linux' ? ['remote-i2c-cuse-test'] : []) + \
   (config_all_devices.has_key('CONFIG_AHCI_ICH9') and have_tools ? ['ahci-test'] : []) +    \
   (config_all_devices.has_key('CONFIG_AHCI_ICH9') ? ['tco-test'] : []) +                    \
   (config_all_devices.has_key('CONFIG_FDC_ISA') ? ['fdc-test'] : []) +                      \
@@ -236,6 +237,7 @@ qtests_stm32l4x5 = \
 
 qtests_arm = \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_REMOTE_I2C_MASTER') and host_os == 'linux' ? ['remote-i2c-cuse-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-apb-dualtimer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_TIMER') ? ['cmsdk-apb-timer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STELLARIS') or
diff --git a/tests/qtest/remote-i2c-cuse-test.c b/tests/qtest/remote-i2c-cuse-test.c
new file mode 100644
index 0000000000..1ef328f44e
--- /dev/null
+++ b/tests/qtest/remote-i2c-cuse-test.c
@@ -0,0 +1,326 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * QTest for Remote I2C Master (CUSE)
+ *
+ * This test acts as a userspace I2C tool (like i2c-tools), interacting
+ * with the CUSE device exposed by QEMU. It validates:
+ *
+ * - Synchronous devices (e.g., TMP105)
+ * - Error conditions (NACK, Timeout)
+ * - Complex protocols (SMBus Block, Atomic RDWR)
+ *
+ * Author:
+ * Ilya Chichkov <ilya.chichkov.dev@gmail.com>
+ *
+ */
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/module.h"
+#include "qobject/qdict.h"
+
+#include <linux/i2c.h>
+#include <linux/i2c-dev.h>
+#include <sys/ioctl.h>
+#include <fcntl.h>
+#include <pthread.h>
+
+#define TEST_DEV_NAME "qemui2c-test"
+#define TEST_DEV_PATH "/dev/" TEST_DEV_NAME
+#define TMP105_REG_CONFIG 0x01
+#define TMP105_SLAVE_ADDR 0x50 /* TMP105 Address */
+
+static int cuse_fd = -1;
+static QTestState *qs;
+
+/* --- Heartbeat Thread --- */
+/* Required to advance QEMU clock while main thread is blocked in ioctl() */
+static gint keep_pulsing;
+static GThread *clock_thread;
+
+static void *clock_pulse_thread(void *data)
+{
+    while (g_atomic_int_get(&keep_pulsing)) {
+        if (qs) {
+            qtest_clock_step(qs, 1000000); /* 1ms */
+        }
+        g_usleep(1000);
+    }
+    return NULL;
+}
+
+static void start_clock_pulse(void)
+{
+    g_atomic_int_set(&keep_pulsing, 1);
+    clock_thread = g_thread_new("clock_pulse", clock_pulse_thread, NULL);
+}
+
+static void stop_clock_pulse(void)
+{
+    g_atomic_int_set(&keep_pulsing, 0);
+    g_thread_join(clock_thread);
+    clock_thread = NULL;
+}
+
+/* --- Helpers --- */
+
+static void i2c_check_funcs(int fd)
+{
+    unsigned long funcs;
+    int ret = ioctl(fd, I2C_FUNCS, &funcs);
+    g_assert_cmpint(ret, ==, 0);
+}
+
+static void i2c_set_TMP105_SLAVE_ADDR(int fd, uint8_t addr)
+{
+    int ret = ioctl(fd, I2C_SLAVE, addr);
+    g_assert_cmpint(ret, ==, 0);
+}
+
+static void i2c_set_pointer(int fd, uint8_t reg)
+{
+    struct i2c_smbus_ioctl_data args;
+    args.read_write = I2C_SMBUS_WRITE;
+    args.command = reg;
+    args.size = I2C_SMBUS_BYTE;
+    args.data = NULL;
+
+    start_clock_pulse();
+    int ret = ioctl(fd, I2C_SMBUS, &args);
+    stop_clock_pulse();
+
+    g_assert_cmpint(ret, ==, 0);
+}
+
+static uint8_t i2c_read_byte(int fd)
+{
+    union i2c_smbus_data data;
+    struct i2c_smbus_ioctl_data args;
+    args.read_write = I2C_SMBUS_READ;
+    args.command = 0;
+    args.size = I2C_SMBUS_BYTE;
+    args.data = &data;
+
+    start_clock_pulse();
+    int ret = ioctl(fd, I2C_SMBUS, &args);
+    stop_clock_pulse();
+
+    g_assert_cmpint(ret, ==, 0);
+    return data.byte;
+}
+
+static void i2c_write_byte_data(int fd, uint8_t reg, uint8_t val)
+{
+    union i2c_smbus_data data;
+    data.byte = val;
+    struct i2c_smbus_ioctl_data args;
+    args.read_write = I2C_SMBUS_WRITE;
+    args.command = reg;
+    args.size = I2C_SMBUS_BYTE_DATA;
+    args.data = &data;
+
+    start_clock_pulse();
+    int ret = ioctl(fd, I2C_SMBUS, &args);
+    stop_clock_pulse();
+
+    g_assert_cmpint(ret, ==, 0);
+}
+
+/* --- Setup --- */
+
+static void test_init(void)
+{
+    GString *cmd_line = g_string_new(NULL);
+
+    g_string_append_printf(cmd_line,
+        "-machine lm3s811evb "
+        "-device tmp105,bus=i2c,address=0x50,id=sensor0 "
+        "-object remote-i2c-backend-cuse,id=my_cuse_backend,devname=" TEST_DEV_NAME " "
+        "-device remote-i2c-master,i2cbus=i2c,backend=my_cuse_backend,timeout-ms=8000");
+
+    qs = qtest_init(cmd_line->str);
+    g_string_free(cmd_line, TRUE);
+
+    int retries = 50;
+    while (retries-- > 0) {
+        cuse_fd = open(TEST_DEV_PATH, O_RDWR);
+        if (cuse_fd >= 0) {
+            break;
+        }
+        g_usleep(100000);
+    }
+
+    if (cuse_fd < 0) {
+        g_test_skip("Could not open CUSE device \
+                    (check permissions or FUSE module)");
+    }
+}
+
+static void test_cleanup(void)
+{
+    if (cuse_fd >= 0) {
+        close(cuse_fd);
+    }
+    if (qs) {
+        qtest_quit(qs);
+        qs = NULL;
+    }
+}
+
+/* --- Synchronous Tests (Standard TMP105) --- */
+
+static void test_capabilities(void)
+{
+    if (cuse_fd < 0) {
+        return;
+    }
+    i2c_check_funcs(cuse_fd);
+}
+
+static void test_sensor_rw(void)
+{
+    if (cuse_fd < 0) {
+        return;
+    }
+    i2c_set_TMP105_SLAVE_ADDR(cuse_fd, TMP105_SLAVE_ADDR);
+
+    /* 1. Set Pointer to T_HIGH (0x03) and Read */
+    i2c_set_pointer(cuse_fd, 0x03);
+    uint8_t t_high = i2c_read_byte(cuse_fd);
+
+    /* Default value for T_HIGH is 0x50 */
+    g_assert_cmphex(t_high, ==, 0x50);
+
+    /* 2. Write Config (0x01) and Read back */
+    i2c_write_byte_data(cuse_fd, TMP105_REG_CONFIG, 0x60);
+    i2c_set_pointer(cuse_fd, TMP105_REG_CONFIG);
+    uint8_t config = i2c_read_byte(cuse_fd);
+    g_assert_cmphex(config, ==, 0x60);
+}
+
+static void test_nack(void)
+{
+    if (cuse_fd < 0) {
+        {
+
+        }
+        return;
+    }
+    /* Address 0x20 does not exist */
+    i2c_set_TMP105_SLAVE_ADDR(cuse_fd, 0x20);
+
+    union i2c_smbus_data data;
+    data.byte = 0x00;
+    struct i2c_smbus_ioctl_data args;
+    args.read_write = I2C_SMBUS_WRITE;
+    args.command = 0x00;
+    args.size = I2C_SMBUS_BYTE_DATA;
+    args.data = &data;
+
+    start_clock_pulse();
+    int ret = ioctl(cuse_fd, I2C_SMBUS, &args);
+    stop_clock_pulse();
+
+    /* Should return -1 (error) */
+    if (ret == 0) {
+        g_assert_cmpint(ret, ==, -1);
+    }
+}
+
+static void test_quick_cmd(void)
+{
+    if (cuse_fd < 0) {
+        return;
+    }
+    i2c_set_TMP105_SLAVE_ADDR(cuse_fd, TMP105_SLAVE_ADDR);
+
+    struct i2c_smbus_ioctl_data args;
+    args.read_write = I2C_SMBUS_WRITE;
+    args.command = 0;
+    args.size = I2C_SMBUS_QUICK;
+    args.data = NULL;
+
+    start_clock_pulse();
+    int ret = ioctl(cuse_fd, I2C_SMBUS, &args);
+    stop_clock_pulse();
+    g_assert_cmpint(ret, ==, 0);
+}
+
+static void test_temperature_read(void)
+{
+    if (cuse_fd < 0) {
+        return;
+    }
+    i2c_set_TMP105_SLAVE_ADDR(cuse_fd, TMP105_SLAVE_ADDR);
+
+    /* Set pointer to Temperature Register (0x00) */
+    i2c_set_pointer(cuse_fd, 0x00);
+
+    union i2c_smbus_data data;
+    struct i2c_smbus_ioctl_data args;
+    args.read_write = I2C_SMBUS_READ;
+    args.command = 0;
+    args.size = I2C_SMBUS_WORD_DATA;
+    args.data = &data;
+
+    start_clock_pulse();
+    int ret = ioctl(cuse_fd, I2C_SMBUS, &args);
+    stop_clock_pulse();
+
+    g_assert_cmpint(ret, ==, 0);
+    g_assert_cmpint(data.word, ==, 0x0000);
+}
+
+static void test_i2c_rdwr(void)
+{
+    if (cuse_fd < 0) {
+        return;
+    }
+
+    struct i2c_rdwr_ioctl_data packets;
+    struct i2c_msg messages[2];
+    uint8_t write_buf[1] = { 0x03 };
+    uint8_t read_buf[2] = { 0x00, 0x00 };
+
+    /* Write Message (Set Pointer) */
+    messages[0].addr = TMP105_SLAVE_ADDR;
+    messages[0].flags = 0;
+    messages[0].len = sizeof(write_buf);
+    messages[0].buf = write_buf;
+
+    /* Read Message (Get Data) */
+    messages[1].addr = TMP105_SLAVE_ADDR;
+    messages[1].flags = I2C_M_RD;
+    messages[1].len = sizeof(read_buf);
+    messages[1].buf = read_buf;
+
+    packets.msgs = messages;
+    packets.nmsgs = 2;
+
+    start_clock_pulse();
+    int ret = ioctl(cuse_fd, I2C_RDWR, &packets);
+    stop_clock_pulse();
+
+    g_assert_cmpint(ret, ==, 2);
+    g_assert_cmphex(read_buf[0], ==, 0x50);
+}
+
+/* --- Main --- */
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    /* Init VM */
+    qtest_add_func("/remote-i2c/capabilities", test_init);
+
+    /* Synchronous Tests */
+    qtest_add_func("/remote-i2c/func_check", test_capabilities);
+    qtest_add_func("/remote-i2c/sensor_rw", test_sensor_rw);
+    qtest_add_func("/remote-i2c/nack_check", test_nack);
+    qtest_add_func("/remote-i2c/quick_cmd", test_quick_cmd);
+    qtest_add_func("/remote-i2c/temp_read_word", test_temperature_read);
+    qtest_add_func("/remote-i2c/rdwr_atomic", test_i2c_rdwr);
+
+    int ret = g_test_run();
+    test_cleanup();
+    return ret;
+}
-- 
2.43.0


