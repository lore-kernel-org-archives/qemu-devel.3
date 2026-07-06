Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0EBC43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 14:03:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjuJ-0004MX-Vb; Mon, 06 Jul 2026 10:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wgjuJ-0004MA-04
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 10:02:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wgjuE-0002jX-35
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 10:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783346561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yztltgwonAY7U2z+Q1+bRXiBYkKFujKB18mG1swp/2U=;
 b=EroTnlanJgAlNrax8Ls3/owFmZC86YQYoJPjqjWtSTsFId74pegXSdYgNWlVC6TKHgloLm
 A2lYIcrSoyh1Q8X8pgiXHsE/4jx9WzMiFJgdQhA/59COrvcNLh9zGRRYP4ROsJAiXv6lLD
 K+USWqGY4T7NCKCwABjseM+dWCUcdnY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-zZr1vUErN2WqTG7VeWf7_w-1; Mon,
 06 Jul 2026 10:02:37 -0400
X-MC-Unique: zZr1vUErN2WqTG7VeWf7_w-1
X-Mimecast-MFC-AGG-ID: zZr1vUErN2WqTG7VeWf7_w_1783346556
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D5511955DC6; Mon,  6 Jul 2026 14:02:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 627021956087; Mon,  6 Jul 2026 14:02:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EDFD321E6920; Mon, 06 Jul 2026 16:02:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Ilya Chichkov <ilya.chichkov.dev@gmail.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Corey Minyard <cminyard@mvista.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Laurent Vivier
 <lvivier@redhat.com>
Subject: Re: [PATCH v3] hw/i2c: Add remote I2C master with host CUSE bridge
In-Reply-To: <20260701113149.1853994-1-ilya.chichkov.dev@gmail.com> (Ilya
 Chichkov's message of "Wed, 1 Jul 2026 14:31:46 +0300")
References: <871pdn6scp.fsf@pond.sub.org>
 <20260701113149.1853994-1-ilya.chichkov.dev@gmail.com>
Date: Mon, 06 Jul 2026 16:02:32 +0200
Message-ID: <87pl10md1j.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Ilya Chichkov <ilya.chichkov.dev@gmail.com> writes:

> Add a "remote-i2c-master" device that exposes a QEMU I2C bus to the
> host system through a FUSE/CUSE character device. This lets external
> host programs and standard i2c-tools interact with I2C slaves emulated
> inside QEMU as if they were real devices attached to the host.
>
> The implementation is split into three layers:
>
>   - A non-blocking finite state machine that drives the QEMU I2C
>     master. It is pumped by a QEMU Bottom Half and uses virtual timers
>     to yield during long transfers and to model clock stretching for
>     asynchronous slaves, so the main loop is never blocked. The FSM
>     walks IDLE -> ADDR -> SEND/RECV -> WAIT_STRETCH -> END -> FINISHED
>     and handles NACKs (ENXIO), lost arbitration (EBUSY, with optional
>     back-off and retry), stretch timeouts, and manual abort/reset.
>
>   - An abstract RemoteI2CBackend QOM base class that decouples the
>     internal I2C hardware state machine (the frontend) from any
>     host-specific transport, exposing on_tx_complete and on_tx_error
>     virtual callbacks.
>
>   - A concrete remote-i2c-backend-cuse backend implementing that
>     transport over CUSE. It manages the FUSE session and integrates
>     its file descriptors into QEMU's main AioContext event loop,
>     translates Linux I2C_RDWR, I2C_SMBUS and I2C_SLAVE ioctls into
>     generic byte streams for the FSM, and formats responses back into
>     Linux I2C/SMBus structures for the FUSE driver. SMBus repeated
>     start is supported for atomic write-then-read operations.
>
> Example usage:
>
>   -device remote-i2c-master,i2cbus=3Di2c-bus.0,devname=3Di2c-33
>   -object remote-i2c-backend-cuse,id=3Db0,devname=3Di2c-33
>
> This creates /dev/i2c-33 on the host, usable with i2c-tools:
>
>   i2cdetect -y -l
>   i2cget -y <bus_id> <addr> <reg>
>
> Signed-off-by: Ilya Chichkov <ilya.chichkov.dev@gmail.com>
> ---
> v2:
>   - docs/system/devices/remote-i2c-master.rst: Documented concurrent
>     bus access details and the 'raise-arbitrage-lost' property.
> ---
> v3:
>   - qapi/qom.json: Fix RemoteI2CBackendCuseProperties formatting and
>     expand member documentation (devname, fuse-opts, debug).
>   - tests/qtest: Add remote-i2c-cuse-test covering capabilities,
>     functional smoke test, synchronous sensor read/write.
> ---
> ---
>  docs/system/devices/remote-i2c-master.rst |  217 ++++
>  hw/i2c/Kconfig                            |    5 +
>  hw/i2c/meson.build                        |    6 +
>  hw/i2c/remote-i2c-backend.c               |   30 +
>  hw/i2c/remote-i2c-cuse.c                  | 1186 +++++++++++++++++++++
>  hw/i2c/remote-i2c-fsm.c                   |  521 +++++++++
>  hw/i2c/remote-i2c-master.c                |  145 +++
>  hw/i2c/trace-events                       |   29 +
>  include/hw/i2c/remote-i2c-backend.h       |   70 ++
>  include/hw/i2c/remote-i2c-cuse.h          |   93 ++
>  include/hw/i2c/remote-i2c-master.h        |   77 ++
>  qapi/qom.json                             |   29 +
>  tests/qtest/meson.build                   |    2 +
>  tests/qtest/remote-i2c-cuse-test.c        |  326 ++++++
>  14 files changed, 2736 insertions(+)
>  create mode 100644 docs/system/devices/remote-i2c-master.rst
>  create mode 100644 hw/i2c/remote-i2c-backend.c
>  create mode 100644 hw/i2c/remote-i2c-cuse.c
>  create mode 100644 hw/i2c/remote-i2c-fsm.c
>  create mode 100644 hw/i2c/remote-i2c-master.c
>  create mode 100644 include/hw/i2c/remote-i2c-backend.h
>  create mode 100644 include/hw/i2c/remote-i2c-cuse.h
>  create mode 100644 include/hw/i2c/remote-i2c-master.h
>  create mode 100644 tests/qtest/remote-i2c-cuse-test.c
>
> diff --git a/docs/system/devices/remote-i2c-master.rst b/docs/system/devi=
ces/remote-i2c-master.rst
> new file mode 100644
> index 0000000000..7753da425d
> --- /dev/null
> +++ b/docs/system/devices/remote-i2c-master.rst
> @@ -0,0 +1,217 @@
> +Remote I2C master
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Overview
> +--------
> +
> +The Remote I2C master exposes a QEMU I2C bus to the host system through a
> +FUSE/CUSE (Character device in Userspace) character device. It allows
> +userspace programs and scripts on the host to interact with I2C slaves
> +emulated inside QEMU as if they were real hardware devices attached to t=
he
> +host, accessible with the standard Linux I2C interface and tools such as
> +``i2c-tools``.
> +
> +Features
> +--------
> +
> +- Virtual I2C controller exposed to the host as a character device via C=
USE
> +- Implements the Linux I2C ioctl interface (``I2C_RDWR``, ``I2C_SMBUS``,
> +  ``I2C_SLAVE``)
> +- Supports standard I2C and SMBus protocols
> +- SMBus "Repeated Start" for atomic write-then-read operations
> +- Asynchronous, non-blocking transactions driven by QEMU's Bottom Halves=
 (BH)
> +- Clock-stretching emulation for asynchronous slave devices, so QEMU's m=
ain
> +  loop is never blocked during long transfers
> +- Integration with QEMU's AioContext for asynchronous I/O
> +- Debugging support through FUSE debug mode
> +
> +Architecture
> +------------
> +
> +The device is split into three decoupled layers:
> +
> +Master frontend (FSM)
> +~~~~~~~~~~~~~~~~~~~~~~~
> +
> +A non-blocking finite state machine drives the QEMU I2C master. It is pu=
mped
> +by a QEMU Bottom Half and uses virtual timers to yield during long trans=
fers
> +and to model clock stretching for asynchronous slaves. The transaction w=
alks
> +the following states::
> +
> +    IDLE -> ADDR -> SEND/RECV -> WAIT_STRETCH -> END -> FINISHED
> +
> +- ``IDLE``         : Resting state; awaits a backend dispatch, checks bus
> +  busyness and handles retry timers if arbitration was lost.
> +- ``ADDR``         : Asserts the bus and sends the slave address. A NACK
> +  aborts the transaction (``ENXIO``); an ACK transitions to SEND, RECV or
> +  WAIT_STRETCH.
> +- ``SEND``         : Pushes data bytes to the bus, synchronously in a lo=
op or
> +  one byte at a time for async slaves.
> +- ``RECV``         : Reads data bytes from the bus, with the same yieldi=
ng
> +  behaviour as SEND.
> +- ``WAIT_STRETCH`` : Yields back to QEMU to simulate clock stretching or=
 to
> +  enforce an artificial delay; on timer expiry it bounces back to SEND/R=
ECV.
> +- ``END``          : Transitional state that guarantees ``i2c_end_transf=
er``
> +  is called gracefully.
> +- ``FINISHED``     : Cleans up timers, releases the bus and invokes the
> +  backend completion callbacks.
> +
> +Error handling covers NACKs (``ENXIO``), lost arbitration (``EBUSY``, wi=
th an
> +optional back-off and retry cooldown), stretch timeouts to avoid hung
> +transactions, and manual abort/reset issued by the backend.
> +
> +Abstract backend
> +~~~~~~~~~~~~~~~~~
> +
> +An abstract ``RemoteI2CBackend`` QOM base class strictly decouples the
> +internal QEMU I2C hardware state machine (the frontend) from any
> +host-specific transport layer. It exposes the ``on_tx_complete`` and
> +``on_tx_error`` virtual callbacks used by the FSM to report results.
> +
> +CUSE backend
> +~~~~~~~~~~~~
> +
> +The concrete ``remote-i2c-backend-cuse`` backend implements the transport
> +over CUSE. It manages the FUSE/CUSE session, integrating its file descri=
ptors
> +directly into QEMU's main AioContext event loop. It translates Linux
> +user-space ioctls (``I2C_RDWR``, ``I2C_SMBUS``, ``I2C_SLAVE``) into gene=
ric
> +byte streams for the master frontend to process, and formats QEMU's resp=
onse
> +data back into Linux-compatible I2C/SMBus structures to reply to the FUSE
> +driver.
> +
> +Concurrent bus access
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +The remote master and the emulated CPU may both attempt to drive the sam=
e I2C
> +bus simultaneously, mirroring the arbitration behaviour of a real multi-=
master
> +I2C bus. QEMU's I2C core serializes ownership through ``i2c_bus_master()=
``,
> +which returns an error when the bus is already held by another master.
> +
> +The remote master handles this in one of two ways, controlled by the
> +``raise-arbitrage-lost`` property:
> +
> +- **Retry with back-off** (default, ``raise-arbitrage-lost=3Dfalse``): t=
he
> +  master treats a busy bus as a lost-arbitration event, backs off, and
> +  retries the transaction after a configurable delay. This matches the
> +  behaviour of hardware multi-master I2C controllers.
> +
> +- **Fail immediately** (``raise-arbitrage-lost=3Dtrue``): the master sur=
faces
> +  ``EBUSY`` to the caller at once without retrying. Use this when the ho=
st
> +  test suite must detect contention explicitly rather than wait for it to
> +  resolve.
> +
> +Invocation
> +----------
> +
> +The backend can be wired implicitly through the master device::
> +
> +    -object remote-i2c-backend-cuse,id=3D<id>,devname=3D<node_name>
> +    -device remote-i2c-master,i2cbus=3D<bus>,backend=3D<id>
> +
> +That creates a character device named ``<node_name>`` (for example
> +``/dev/i2c-33``) on the host.
> +
> +Requirements
> +------------
> +
> +Kernel requirements
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +- CUSE module loaded: ``sudo modprobe cuse``
> +- FUSE support enabled
> +
> +Library dependencies
> +~~~~~~~~~~~~~~~~~~~~~~
> +
> +- libfuse3 or libfuse (version 2.9.0 or higher)
> +- FUSE development headers
> +
> +Debugging
> +---------
> +
> +FUSE debug output can be enabled by passing FUSE options to the CUSE bac=
kend
> +through ``fuse-opts`` or by ``debug=3Dtrue`` for short.
> +
> +.. code-block:: bash
> +
> +    -object remote-i2c-backend-cuse,id=3Db0,devname=3Di2c-33,fuse-opts=
=3D-d
> +
> +Running the FUSE session in the foreground with debug enabled prints the
> +incoming CUSE/ioctl traffic, which is useful when diagnosing transport
> +issues.
> +
> +Limitations
> +-----------
> +
> +10-bit I2C addressing
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +Only 7-bit I2C addresses (0=E2=80=93127) are supported. QEMU's I2C core =
stores slave
> +addresses as ``uint8_t`` and all bus functions (``i2c_start_send``,
> +``i2c_start_recv``, ``i2c_scan_bus``) accept ``uint8_t address``, so 10-=
bit
> +addressing cannot be represented at the framework level. The CUSE backend
> +reflects this by rejecting any address outside the 0=E2=80=93127 range w=
ith
> +``EINVAL``. The ``I2C_M_TEN`` flag in ``I2C_RDWR`` messages is ignored.
> +
> +Troubleshooting
> +---------------
> +
> +CUSE_INIT failures
> +~~~~~~~~~~~~~~~~~~~
> +
> +If you encounter ``CUSE_INIT`` errors:
> +
> +1. Verify the CUSE module is loaded:
> +
> +   .. code-block:: bash
> +
> +       lsmod | grep cuse
> +       sudo modprobe cuse
> +
> +2. Check permissions on the CUSE control device:
> +
> +   .. code-block:: bash
> +
> +       # Ensure the user has access to /dev/cuse
> +       ls -la /dev/cuse
> +
> +Examples
> +--------
> +
> +Basic usage
> +~~~~~~~~~~~
> +
> +Start QEMU with a ``tmp105`` temperature sensor on an Aspeed I2C bus and
> +expose that bus to the host as ``/dev/i2c-33``:
> +
> +.. code-block:: bash
> +
> +    ./qemu-system-arm -M ast2600-evb \
> +        -device tmp105,address=3D0x40,bus=3Daspeed.i2c.bus.0 \
> +        -device remote-i2c-master,i2cbus=3Daspeed.i2c.bus.0,devname=3Di2=
c-33
> +
> +Then access the emulated sensor from the host with ``i2c-tools``:
> +
> +.. code-block:: console
> +
> +    $ i2cdetect -y 33
> +         0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> +    00:                         -- -- -- -- -- -- -- --
> +    10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> +    20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> +    30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> +    40: 40 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> +    50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> +    60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> +
> +    $ i2cget -y 33 0x40 0x2
> +    0x4b
> +
> +    $ i2cget -y 33 0x40 0x3
> +    0x50
> +
> +See also
> +--------
> +
> +- `FUSE Documentation <https://github.com/libfuse/libfuse>`_
> +- `Character devices in user space <https://lwn.net/Articles/308445/>`_
> diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
> index 596a7a3165..84d387bf41 100644
> --- a/hw/i2c/Kconfig
> +++ b/hw/i2c/Kconfig
> @@ -49,3 +49,8 @@ config PMBUS
>  config BCM2835_I2C
>      bool
>      select I2C
> +
> +config REMOTE_I2C_MASTER
> +    bool
> +    select I2C
> +    default y if I2C_DEVICES
> diff --git a/hw/i2c/meson.build b/hw/i2c/meson.build
> index c459adcb59..ea8cf1f980 100644
> --- a/hw/i2c/meson.build
> +++ b/hw/i2c/meson.build
> @@ -18,4 +18,10 @@ i2c_ss.add(when: 'CONFIG_PPC4XX', if_true: files('ppc4=
xx_i2c.c'))
>  i2c_ss.add(when: 'CONFIG_PCA954X', if_true: files('i2c_mux_pca954x.c'))
>  i2c_ss.add(when: 'CONFIG_PMBUS', if_true: files('pmbus_device.c'))
>  i2c_ss.add(when: 'CONFIG_BCM2835_I2C', if_true: files('bcm2835_i2c.c'))
> +i2c_ss.add(when: 'CONFIG_REMOTE_I2C_MASTER', if_true: files(
> +    'remote-i2c-master.c',
> +    'remote-i2c-backend.c',
> +    'remote-i2c-cuse.c',
> +    'remote-i2c-fsm.c'
> +))
>  system_ss.add_all(when: 'CONFIG_I2C', if_true: i2c_ss)
> diff --git a/hw/i2c/remote-i2c-backend.c b/hw/i2c/remote-i2c-backend.c
> new file mode 100644
> index 0000000000..e8d753b491
> --- /dev/null
> +++ b/hw/i2c/remote-i2c-backend.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Remote I2C Backend (Abstract Base Class)
> + *
> + * This module defines the abstract backend interface for the Remote I2C=
 Master.
> + * It provides the QEMU Object Model (QOM) base class that strictly deco=
uples
> + * the internal QEMU I2C hardware state machine (the frontend) from
> + * host-specific transport layers.
> + *
> + * Author:
> + * Ilya Chichkov <ilya.chichkov.dev@gmail.com>
> + *
> + */
> +#include "qemu/osdep.h"
> +#include "hw/i2c/remote-i2c-backend.h"
> +
> +static const TypeInfo remote_i2c_backend_info =3D {
> +    .name =3D TYPE_REMOTE_I2C_BACKEND,
> +    .parent =3D TYPE_OBJECT,
> +    .instance_size =3D sizeof(RemoteI2CBackend),
> +    .class_size =3D sizeof(RemoteI2CBackendClass),
> +    .abstract =3D true,
> +};
> +
> +static void remote_i2c_backend_register_types(void)
> +{
> +    type_register_static(&remote_i2c_backend_info);
> +}
> +
> +type_init(remote_i2c_backend_register_types)
> diff --git a/hw/i2c/remote-i2c-cuse.c b/hw/i2c/remote-i2c-cuse.c
> new file mode 100644
> index 0000000000..a5b557af9a
> --- /dev/null
> +++ b/hw/i2c/remote-i2c-cuse.c
> @@ -0,0 +1,1186 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Remote I2C CUSE Backend
> + *
> + * This module provides the concrete CUSE (Character device in Userspace)
> + * implementation of the abstract Remote I2C Backend interface. It acts =
as the
> + * physical bridge between the Linux host's I2C subsystem and QEMU's int=
ernal
> + * I2C hardware emulation.
> + *
> + * Architecture & Responsibilities:
> + * - Inherits from the abstract `RemoteI2CBackend` QOM base class.
> + * - Initializes and manages the FUSE/CUSE session, integrating its file
> + *   descriptors directly into QEMU's main AioContext event loop.
> + * - Translates Linux user-space IOCTLs (I2C_RDWR, I2C_SMBUS, I2C_SLAVE)=
 into
> + *   generic byte streams for the Master Frontend to process.
> + * - Implements the `on_tx_complete` and `on_tx_error` virtual callbacks=
 to
> + *   format QEMU's response data back into Linux-compatible I2C/SMBus da=
ta
> + *   structures and reply to the FUSE driver.
> + *
> + * Usage:
> + * Instantiated via the QEMU CLI as a backend object:
> + *   -object remote-i2c-backend-cuse,
> + *           id=3D<id>,devname=3D<node_name>[,fuse-opts=3D<opts>]
> + *
> + * Author:
> + * Ilya Chichkov <ilya.chichkov.dev@gmail.com>
> + *
> + */
> +#include "qemu/osdep.h"
> +
> +#include "qapi/error.h"
> +#include "qemu/main-loop.h"
> +#include "hw/i2c/i2c.h"
> +#include "hw/core/qdev-properties-system.h"
> +#include "qemu/error-report.h"
> +#include "qemu/bswap.h"
> +#include "qemu/aio.h"
> +#include "qemu/log.h"
> +#include "qapi/visitor.h"
> +#include "qapi/error.h"
> +#include "trace.h"
> +
> +#include "hw/i2c/remote-i2c-cuse.h"
> +#include "hw/i2c/remote-i2c-master.h" /* For FSM dispatch and commands */
> +
> +#define I2C_BUS_BUSY_CHECK_TIMER_COOLDOWN_NS 50000
> +
> +#define I2C_BUFFER_INDEX_SIZE 2
> +#define I2C_BUFFER_INDEX_COMMAND 3
> +#define I2C_BUFFER_INDEX_DATA_0 4
> +#define I2C_BUFFER_INDEX_DATA_1 5
> +
> +
> +static bool cuse_get_debug(Object *obj, Error **errp)
> +{
> +    RemoteI2CBackendCuse *cuse =3D REMOTE_I2C_BACKEND_CUSE(obj);
> +    return cuse->debug;
> +}
> +
> +static void cuse_set_debug(Object *obj, bool value, Error **errp)
> +{
> +    RemoteI2CBackendCuse *cuse =3D REMOTE_I2C_BACKEND_CUSE(obj);
> +    cuse->debug =3D value;
> +}
> +
> +static char *cuse_get_devname(Object *obj, Error **errp)
> +{
> +    RemoteI2CBackendCuse *cuse =3D REMOTE_I2C_BACKEND_CUSE(obj);
> +    return g_strdup(cuse->devname);
> +}
> +
> +static void cuse_set_devname(Object *obj, const char *value, Error **err=
p)
> +{
> +    RemoteI2CBackendCuse *cuse =3D REMOTE_I2C_BACKEND_CUSE(obj);
> +    g_free(cuse->devname);
> +    cuse->devname =3D g_strdup(value);
> +}
> +
> +static char *cuse_get_fuse_opts(Object *obj, Error **errp)
> +{
> +    RemoteI2CBackendCuse *cuse =3D REMOTE_I2C_BACKEND_CUSE(obj);
> +    return g_strdup(cuse->fuse_opts);
> +}
> +
> +static void cuse_set_fuse_opts(Object *obj, const char *value, Error **e=
rrp)
> +{
> +    RemoteI2CBackendCuse *cuse =3D REMOTE_I2C_BACKEND_CUSE(obj);
> +    g_free(cuse->fuse_opts);
> +    cuse->fuse_opts =3D g_strdup(value);
> +}
> +
> +
> +/*
> + * remote_i2c_serialize_smbus_write:
> + * @cuse: The concrete CUSE backend instance.
> + * @in_val: Pointer to the incoming Linux SMBus IOCTL data structure.
> + *
> + * Translates a Linux user-space SMBus write or read command request int=
o a flat
> + * payload array compatible with QEMU's generic I2C transaction buffer
> + */
> +static
> +void remote_i2c_serialize_smbus_write(RemoteI2CBackendCuse *cuse,
> +                                      const struct i2c_smbus_ioctl_data =
*in_val)
> +{
> +    RemoteI2CBackend *backend =3D REMOTE_I2C_BACKEND(cuse);
> +    union i2c_smbus_data data;
> +    uint8_t buf[REMOTE_I2C_BACKEND_BUF_LEN] =3D { 0 };
> +    uint8_t len =3D 0;
> +
> +    memset(backend->transaction_buf, 0, REMOTE_I2C_BACKEND_BUF_LEN);
> +
> +    buf[0] =3D in_val->read_write;
> +    buf[1] =3D (uint8_t)backend->address;
> +
> +    memcpy(&data,
> +           cuse->in_data.in_buf + sizeof(struct i2c_smbus_ioctl_data),
> +           sizeof(union i2c_smbus_data));
> +
> +    if (in_val->read_write =3D=3D I2C_SMBUS_READ) {
> +        if (in_val->size =3D=3D I2C_SMBUS_BYTE) {
> +            backend->transaction_length =3D 0;
> +            return;
> +        }
> +
> +        backend->transaction_length =3D 1;
> +        backend->transaction_buf[0] =3D in_val->command;
> +        return;
> +    }
> +
> +    switch (in_val->size) {
> +    case I2C_SMBUS_QUICK:
> +        buf[I2C_BUFFER_INDEX_SIZE] =3D 0;
> +        break;
> +    case I2C_SMBUS_BYTE:
> +        buf[I2C_BUFFER_INDEX_SIZE] =3D 1;
> +        buf[I2C_BUFFER_INDEX_COMMAND] =3D in_val->command;
> +        break;
> +    case I2C_SMBUS_BYTE_DATA:
> +        buf[I2C_BUFFER_INDEX_SIZE] =3D 2;
> +        buf[I2C_BUFFER_INDEX_COMMAND] =3D in_val->command;
> +        buf[I2C_BUFFER_INDEX_DATA_0] =3D data.byte;
> +        break;
> +    case I2C_SMBUS_WORD_DATA:
> +    case I2C_SMBUS_PROC_CALL:
> +        buf[I2C_BUFFER_INDEX_SIZE] =3D 3;
> +        buf[I2C_BUFFER_INDEX_COMMAND] =3D in_val->command;
> +        buf[I2C_BUFFER_INDEX_DATA_0] =3D (uint8_t)(data.word & 0xFF);
> +        buf[I2C_BUFFER_INDEX_DATA_1] =3D (uint8_t)(data.word >> 8 & 0xFF=
);
> +        break;
> +    case I2C_SMBUS_BLOCK_DATA:
> +    case I2C_SMBUS_I2C_BLOCK_BROKEN:
> +    case I2C_SMBUS_I2C_BLOCK_DATA:
> +    case I2C_SMBUS_BLOCK_PROC_CALL:
> +        {
> +            len =3D MIN(data.block[0], I2C_SMBUS_BLOCK_MAX);
> +            buf[I2C_BUFFER_INDEX_SIZE] =3D len + 2; /* Command + Count +=
 Data */
> +            buf[I2C_BUFFER_INDEX_COMMAND] =3D in_val->command;
> +            buf[I2C_BUFFER_INDEX_DATA_0] =3D len;
> +            memcpy(&buf[I2C_BUFFER_INDEX_DATA_1], &data.block[1], len);
> +        }
> +        break;
> +    default:
> +        buf[I2C_BUFFER_INDEX_SIZE] =3D 0;
> +        break;
> +    }
> +
> +    backend->transaction_length =3D buf[I2C_BUFFER_INDEX_SIZE];
> +    memcpy(backend->transaction_buf, &buf[I2C_BUFFER_INDEX_COMMAND],
> +           backend->transaction_length);
> +}
> +
> +/*
> + * remote_i2c_calculate_expected_recv_len:
> + * @cuse: The concrete CUSE backend instance.
> + *
> + * Inspects active IOCTL contexts (either SMBus reads or standard I2C_RD=
WR
> + * message arrays) to calculate the exact number of bytes expected to be=
 read
> + * from the emulated I2C target.
> + */
> +static void remote_i2c_calculate_expected_recv_len(RemoteI2CBackendCuse =
*cuse)
> +{
> +    RemoteI2CBackend *backend =3D REMOTE_I2C_BACKEND(cuse);
> +    union i2c_smbus_data *smbus_data;
> +    uint16_t size =3D 0;
> +
> +    if (cuse->in_data.last_cmd =3D=3D I2C_SMBUS) {
> +        size =3D cuse->in_data.in_smbus_data->size;
> +        smbus_data =3D (union i2c_smbus_data *)(
> +            cuse->in_data.in_buf + sizeof(struct i2c_smbus_ioctl_data)
> +        );
> +
> +        switch (size) {
> +        case I2C_SMBUS_QUICK:
> +            backend->transaction_length =3D 0;
> +            break;
> +        case I2C_SMBUS_BYTE:
> +        case I2C_SMBUS_BYTE_DATA:
> +            backend->transaction_length =3D 1;
> +            break;
> +        case I2C_SMBUS_WORD_DATA:
> +        case I2C_SMBUS_PROC_CALL:
> +            backend->transaction_length =3D 2;
> +            break;
> +        case I2C_SMBUS_BLOCK_DATA:
> +        case I2C_SMBUS_I2C_BLOCK_BROKEN:
> +        case I2C_SMBUS_I2C_BLOCK_DATA:
> +        case I2C_SMBUS_BLOCK_PROC_CALL:
> +            backend->transaction_length =3D smbus_data->block[0];
> +            if (backend->transaction_length =3D=3D 0) {
> +                backend->transaction_length =3D I2C_SMBUS_BLOCK_MAX;
> +            }
> +            break;
> +        default:
> +            backend->transaction_length =3D 0;
> +            break;
> +        }
> +    } else if (cuse->in_data.last_cmd =3D=3D I2C_RDWR) {
> +        if (cuse->rdwr_msgs) {
> +            backend->transaction_length =3D cuse->rdwr_msgs[cuse->msg_id=
x].len;
> +        }
> +    }
> +}
> +
> +/*
> + * remote_i2c_deserialize_smbus_read:
> + * @cuse: The concrete CUSE backend instance.
> + *
> + * Packages raw bytes retrieved from QEMU's emulated I2C target back int=
o the
> + * appropriate native Linux SMBus data union format.
> + */
> +static void remote_i2c_deserialize_smbus_read(RemoteI2CBackendCuse *cuse)
> +{
> +    RemoteI2CBackend *backend =3D REMOTE_I2C_BACKEND(cuse);
> +    union i2c_smbus_data *smbus_data =3D (union i2c_smbus_data *)(
> +        cuse->in_data.in_buf + sizeof(struct i2c_smbus_ioctl_data)
> +    );
> +    uint16_t size =3D cuse->in_data.in_smbus_data->size;
> +    uint8_t len =3D 0;
> +
> +    switch (size) {
> +    case I2C_SMBUS_BYTE:
> +    case I2C_SMBUS_BYTE_DATA:
> +        smbus_data->byte =3D backend->transaction_buf[0];
> +        break;
> +    case I2C_SMBUS_WORD_DATA:
> +    case I2C_SMBUS_PROC_CALL:
> +        smbus_data->word =3D ((uint16_t)backend->transaction_buf[0]) & 0=
xFF;
> +        smbus_data->word |=3D
> +            (((uint16_t)backend->transaction_buf[1]) << 8) & 0xFF00;
> +        break;
> +    case I2C_SMBUS_BLOCK_DATA:
> +    case I2C_SMBUS_BLOCK_PROC_CALL:
> +        len =3D MIN(backend->transaction_buf[0], I2C_SMBUS_BLOCK_MAX);
> +        smbus_data->block[0] =3D len;
> +        memcpy(&smbus_data->block[1], &backend->transaction_buf[1], len);
> +        break;
> +    case I2C_SMBUS_I2C_BLOCK_DATA:
> +    case I2C_SMBUS_I2C_BLOCK_BROKEN:
> +        len =3D MIN(backend->transaction_length, I2C_SMBUS_BLOCK_MAX);
> +        smbus_data->block[0] =3D len;
> +        memcpy(&smbus_data->block[1], backend->transaction_buf, len);
> +        break;
> +    default:
> +        break;
> +    }
> +
> +    fuse_reply_ioctl(cuse->in_data.req, 0, smbus_data, sizeof(*smbus_dat=
a));
> +}
> +
> +/*
> + * remote_i2c_update_slave_address:
> + * @cuse: The concrete CUSE backend instance.
> + * @req: The active FUSE request context handle.
> + * @address: The 7-bit target I2C slave address requested by the host OS.
> + *
> + * Validates and updates the transaction target device address in the sh=
ared
> + * backend state.
> + */
> +static
> +void remote_i2c_update_slave_address(RemoteI2CBackendCuse *cuse,
> +                                     fuse_req_t req, long address)
> +{
> +    RemoteI2CBackend *backend =3D REMOTE_I2C_BACKEND(cuse);
> +
> +    if (address < 0 || address > 127) {
> +        fuse_reply_err(req, EINVAL);
> +        return;
> +    }
> +
> +    backend->address =3D address;
> +    trace_remote_i2c_master_i2cdev_address(backend->address);
> +}
> +
> +/*
> + * remote_i2c_advance_rdwr_sequence:
> + * @cuse: The concrete CUSE backend instance.
> + *
> + * Iterates through the batch vector array of standard native Linux `i2c=
_msg`
> + * blocks received during a multi-message I2C_RDWR ioctl operation. Popu=
lates
> + * the next message's direction, length, and payload buffer into the gen=
eric
> + * transaction state machine, advancing data offsets and preparing the m=
aster
> + * frontend bus state for an updated address phase.
> + */
> +static void remote_i2c_advance_rdwr_sequence(RemoteI2CBackendCuse *cuse)
> +{
> +    RemoteI2CBackend *backend =3D REMOTE_I2C_BACKEND(cuse);
> +    const struct i2c_msg *current_msg =3D NULL;
> +
> +    if (!cuse->rdwr_msgs || cuse->msg_idx >=3D cuse->nmsgs) {
> +        backend->bus_state =3D I2C_BUS_END;
> +        return;
> +    }
> +
> +    current_msg =3D &cuse->rdwr_msgs[cuse->msg_idx];
> +    remote_i2c_update_slave_address(cuse, cuse->in_data.req,
> +                                    (long)current_msg->addr);
> +
> +    backend->transaction_length =3D current_msg->len;
> +    backend->transaction_index =3D 0;
> +    backend->addr_acked =3D false;
> +    backend->data_acked =3D false;
> +    backend->timed_out =3D false;
> +
> +    /* Evaluate sequence direction and staging boundaries */
> +    if (current_msg->flags & I2C_M_RD) {
> +        backend->is_recv =3D true;
> +    } else {
> +        backend->is_recv =3D false;
> +
> +        if ((cuse->rdwr_data_offset + current_msg->len) <=3D
> +            cuse->rdwr_in_buf_size) {
> +            memcpy(backend->transaction_buf,
> +                   cuse->in_data.in_buf + cuse->rdwr_data_offset,
> +                   current_msg->len);
> +            cuse->rdwr_data_offset +=3D current_msg->len;
> +        } else {
> +            backend->is_transaction_failed =3D true;
> +            backend->bus_state =3D I2C_BUS_FINISHED;
> +
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "Remote I2C Backend: Buffer overflow during RD=
WR "
> +                          "deserialization. Message requests %u bytes, b=
ut "
> +                          "only %zu bytes remain.\n",
> +                          current_msg->len,
> +                          (cuse->rdwr_in_buf_size - cuse->rdwr_data_offs=
et));
> +            return;
> +        }
> +    }
> +
> +    backend->bus_state =3D I2C_BUS_ADDR;
> +}
> +
> +/*
> + * remote_i2c_cuse_on_tx_complete:
> + * @backend: Pointer to the abstract RemoteI2CBackend base structure.
> + *
> + * Implements the virtual execution callback triggered by the frontend m=
aster
> + * FSM when a given hardware I2C sub-transaction completes successfully.
> + * Manages protocol sequence vector chaining (such as multi-message RDWR
> + * arrays or atomic SMBus Write-then-Read phases). Once all phases compl=
ete,
> + * it packages retrieved byte payloads and terminates the active host OS=
 IOCTL
> + * over FUSE.
> + */
> +static void remote_i2c_cuse_on_tx_complete(RemoteI2CBackend *backend)
> +{
> +    RemoteI2CBackendCuse *cuse =3D REMOTE_I2C_BACKEND_CUSE(backend);
> +    size_t available_space =3D 0;
> +    size_t copy_len =3D 0;
> +
> +    /*
> +     * If we were receiving data during an RDWR,
> +     * copy it into the output buffer
> +     */
> +    if (cuse->in_data.last_cmd =3D=3D I2C_RDWR && backend->is_recv) {
> +        available_space =3D REMOTE_I2C_BACKEND_RDWR_BUF_LEN - cuse->rdwr=
_out_len;
> +        copy_len =3D (backend->transaction_length < available_space) ?
> +                          backend->transaction_length : available_space;
> +
> +        if (copy_len > 0) {
> +            memcpy(cuse->rdwr_out_buf + cuse->rdwr_out_len,
> +                   backend->transaction_buf,
> +                   copy_len);
> +            cuse->rdwr_out_len +=3D copy_len;
> +        }
> +    }
> +
> +    /* Process Multi-Message Protocol Chaining Vectors */
> +    if (cuse->in_data.last_cmd =3D=3D I2C_SMBUS &&
> +        cuse->smbus_restart_read &&
> +        !backend->is_recv) {
> +        backend->is_recv =3D true;
> +        backend->transaction_index =3D 0;
> +        remote_i2c_calculate_expected_recv_len(cuse);
> +        remote_i2c_fsm_dispatch(backend->frontend, REMOTE_I2C_CMD_NEXT_M=
SG);
> +        return;
> +    } else if (cuse->in_data.last_cmd =3D=3D I2C_RDWR) {
> +        cuse->msg_idx++;
> +
> +        if (cuse->msg_idx < cuse->nmsgs) {
> +            remote_i2c_advance_rdwr_sequence(cuse);
> +            remote_i2c_fsm_dispatch(backend->frontend, REMOTE_I2C_CMD_NE=
XT_MSG);
> +            return;
> +        }
> +    }
> +
> +    if (cuse->in_data.last_cmd =3D=3D I2C_RDWR) {
> +        fuse_reply_ioctl(cuse->in_data.req, cuse->nmsgs,
> +                         cuse->rdwr_out_buf, cuse->rdwr_out_len);
> +    } else if (cuse->in_data.last_cmd =3D=3D I2C_SMBUS && backend->is_re=
cv) {
> +        if (backend->transaction_length > 0) {
> +            remote_i2c_deserialize_smbus_read(cuse);
> +        } else {
> +            fuse_reply_ioctl(cuse->in_data.req, 0, NULL, 0);
> +        }
> +    } else {
> +        fuse_reply_ioctl(cuse->in_data.req, 0, NULL, 0);
> +    }
> +
> +    if (cuse->in_data.in_buf) {
> +        g_free((gpointer)cuse->in_data.in_buf);
> +        cuse->in_data.in_buf =3D NULL;
> +        cuse->in_data.in_smbus_data =3D NULL;
> +    }
> +
> +    cuse->ioctl_state =3D I2C_IOCTL_START;
> +    cuse->last_ioctl =3D 0;
> +    cuse->smbus_restart_read =3D false;
> +}
> +
> +/*
> + * remote_i2c_cuse_reset_session:
> + * @cuse: The concrete CUSE backend instance.
> + *
> + * Internal helper to teardown and clear temporary transaction contexts.
> + */
> +static void remote_i2c_cuse_reset_session(RemoteI2CBackendCuse *cuse)
> +{
> +    if (cuse->in_data.in_buf) {
> +        g_free((gpointer)cuse->in_data.in_buf);
> +        cuse->in_data.in_buf =3D NULL;
> +        cuse->in_data.in_smbus_data =3D NULL;
> +    }
> +
> +    cuse->ioctl_state =3D I2C_IOCTL_START;
> +    cuse->last_ioctl =3D 0;
> +    cuse->smbus_restart_read =3D false;
> +}
> +
> +/*
> + * remote_i2c_cuse_on_tx_error:
> + * @backend: Pointer to the abstract RemoteI2CBackend base structure.
> + * @errno_code: The POSIX error number reflecting the nature of the fail=
ure.
> + *
> + * Implements the virtual execution callback triggered by the frontend m=
aster
> + * FSM when a hardware I2C transaction fails or aborts.
> + */
> +static
> +void remote_i2c_cuse_on_tx_error(RemoteI2CBackend *backend, int errno_co=
de)
> +{
> +    RemoteI2CBackendCuse *cuse =3D REMOTE_I2C_BACKEND_CUSE(backend);
> +
> +    fuse_reply_err(cuse->in_data.req, errno_code);
> +    remote_i2c_cuse_reset_session(cuse);
> +}
> +
> +/*
> + * remote_i2c_cuse_init:
> + * @userdata: Arbitrary reference pointer registered at session startup.
> + * @conn: Struct mapping runtime driver features and limits for the conn=
ection.
> + *
> + * Virtual callback invoked by the FUSE infrastructure once the userspace
> + * character device mapping handshake completes successfully.
> + */
> +static void remote_i2c_cuse_init(void *userdata, struct fuse_conn_info *=
conn)
> +{
> +    (void)userdata;
> +    trace_remote_i2c_master_i2cdev_init();
> +}
> +
> +/*
> + * remote_i2c_cuse_open:
> + * @req: The active FUSE request context handle.
> + * @fi: Driver metadata tracker for the targeted host file descriptor.
> + *
> + * Configures the communication channel when a host application requests
> + * access to the virtual character node (e.g., /dev/i2c-33). Clears base=
line
> + * tracking flags, normalizes backend engine states, and invokes a safe =
reset
> + * of all active tracking buffers.
> + */
> +static void remote_i2c_cuse_open(fuse_req_t req, struct fuse_file_info *=
fi)
> +{
> +    RemoteI2CBackendCuse *cuse =3D fuse_req_userdata(req);
> +    RemoteI2CBackend *backend =3D REMOTE_I2C_BACKEND(cuse);
> +
> +    cuse->is_open =3D true;
> +    cuse->ioctl_state =3D I2C_IOCTL_START;
> +    cuse->last_ioctl =3D 0;
> +
> +    backend->bus_state =3D I2C_BUS_IDLE;
> +    backend->is_recv =3D false;
> +    backend->waiting_for_async =3D false;
> +    backend->timed_out =3D false;
> +
> +    if (cuse->in_data.in_buf) {
> +        g_free((gpointer)cuse->in_data.in_buf);
> +        cuse->in_data.in_buf =3D NULL;
> +    }
> +
> +    cuse->rdwr_msgs =3D NULL;
> +
> +    fuse_reply_open(req, fi);
> +    trace_remote_i2c_master_i2cdev_open();
> +}
> +
> +/*
> + * remote_i2c_cuse_release:
> + * @req: The active FUSE request context handle.
> + * @fi: Driver metadata tracker for the targeted host file descriptor.
> + *
> + * Handles formal close/teardown requests from user-space applications.
> + * Tears down mapping tables, releases structural heap components to avo=
id
> + * memory leaks, and resets the channel boundary flags to unlinked defau=
lts.
> + */
> +static void remote_i2c_cuse_release(fuse_req_t req, struct fuse_file_inf=
o *fi)
> +{
> +    RemoteI2CBackendCuse *cuse =3D fuse_req_userdata(req);
> +    RemoteI2CBackend *backend =3D REMOTE_I2C_BACKEND(cuse);
> +
> +    cuse->is_open =3D false;
> +    cuse->ioctl_state =3D I2C_IOCTL_START;
> +    cuse->last_ioctl =3D 0;
> +
> +    backend->bus_state =3D I2C_BUS_IDLE;
> +
> +    g_free(cuse->in_data.in_buf);
> +    cuse->in_data.in_buf =3D NULL;
> +
> +    cuse->rdwr_msgs =3D NULL;
> +
> +    fuse_reply_err(req, 0);
> +    trace_remote_i2c_master_i2cdev_release();
> +}
> +
> +/*
> + * remote_i2c_cuse_read:
> + * @req: The active FUSE request context handle.
> + * @size: Byte count window requested by the caller.
> + * @off: Seek offset identifier within the streaming channel context.
> + * @fi: Driver metadata tracker for the targeted host file descriptor.
> + *
> + * Implements standard char-node read interfaces. Because physical
> + * I2C operations are handled strictly via target-directed IOCTL vectors,
> + * this entry point is standard-compliant stub code returning 0 bytes (E=
OF).
> + */
> +static void remote_i2c_cuse_read(fuse_req_t req, size_t size, off_t off,
> +                                 struct fuse_file_info *fi)
> +{
> +    (void)size;
> +    (void)off;
> +    (void)fi;
> +    fuse_reply_buf(req, NULL, 0);
> +}
> +
> +/*
> + * remote_i2c_cuse_functional:
> + * @cuse: The concrete CUSE backend instance.
> + * @req: The active FUSE request context handle.
> + * @arg: Host memory location reference where data payload
> + *       outputs will be staged.
> + * @in_buf: Unused trailing verification packet buffer context.
> + *
> + * Implements the Linux I2C_FUNCS capability negotiation IOCTL
> + * interface. Emulates a two-phase FUSE configuration state loop: first
> + * prompts the kernel driver to fetch memory staging regions, and
> + * subsequently delivers the bitmask array defining what I2C/SMBus proto=
cols
> + * this device translates.
> + */
> +static void remote_i2c_cuse_functional(RemoteI2CBackendCuse *cuse,
> +                                       fuse_req_t req,
> +                                       void *arg,
> +                                       const void *in_buf)
> +{
> +    unsigned long backend_functionality_mask =3D (
> +        I2C_FUNC_I2C | I2C_FUNC_SMBUS_QUICK |
> +        I2C_FUNC_SMBUS_BYTE | I2C_FUNC_SMBUS_BYTE_DATA |
> +        I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_WORD_DATA |
> +        I2C_FUNC_SMBUS_I2C_BLOCK
> +    );
> +
> +    struct iovec target_memory_vector =3D {
> +        .iov_base =3D arg,
> +        .iov_len =3D sizeof(unsigned long)
> +    };
> +
> +    switch (cuse->ioctl_state) {
> +    case I2C_IOCTL_START:
> +        cuse->ioctl_state =3D I2C_IOCTL_GET;
> +        fuse_reply_ioctl_retry(req, NULL, 0, &target_memory_vector, 1);
> +        break;
> +    case I2C_IOCTL_GET:
> +        fuse_reply_ioctl(req, 0, &backend_functionality_mask,
> +                         sizeof(backend_functionality_mask));
> +        cuse->ioctl_state =3D I2C_IOCTL_FINISHED;
> +        trace_remote_i2c_master_i2cdev_functional();
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Remote I2C Backend: Invalid IOCTL state "
> +                      "encountered in functionality query handler: %d\n",
> +                      cuse->ioctl_state);
> +        break;
> +    }
> +}
> +
> +/*
> + * remote_i2c_cuse_address:
> + * @cuse: The concrete CUSE backend instance.
> + * @req: The active FUSE request context handle.
> + * @arg: Untyped reference mapped by the host kernel conveying the target
> + *       address.
> + * @in_buf: Unused auxiliary input payload vector.
> + *
> + * Implements the standard Linux native I2C_SLAVE ioctl entry point.
> + */
> +static void i2cdev_address(RemoteI2CBackendCuse *cuse,
> +                           fuse_req_t req,
> +                           void *arg,
> +                           const void *in_buf)
> +{
> +    (void)in_buf;
> +    remote_i2c_update_slave_address(cuse, req, (long)arg);
> +    fuse_reply_ioctl(req, 0, NULL, 0);
> +    cuse->ioctl_state =3D I2C_IOCTL_FINISHED;
> +}
> +
> +/*
> + * remote_i2c_cuse_cmd_rdwr:
> + * @cuse: The concrete CUSE backend instance.
> + * @req: The active FUSE request context handle.
> + * @in_arg: Raw input memory reference targeting the calling process spa=
ce.
> + * @in_buf: Staged kernel buffer payload delivered via the asynchronous
> + *          FUSE engine.
> + * @in_bufsz: Total layout size in bytes of the incoming data block.
> + * @out_bufsz: Output tracking limit size reserved by the calling process
> + *             framework.
> + *
> + * Implements the complex multi-phase Linux standard I2C_RDWR ioctl laye=
r.
> + * Orchestrates an asynchronous four-phase FUSE data collection handshak=
e loop
> + * (START -> GET -> RECV -> SEND) to fetch scatter-gather message vector=
s and
> + * payload blocks directly from host memory space before dispatching exe=
cution
> + * to the master frontend state machine.
> + */
> +static void i2cdev_cmd_rdwr(RemoteI2CBackendCuse *cuse,
> +                            fuse_req_t req,
> +                            void *in_arg,
> +                            const void *in_buf,
> +                            size_t in_bufsz,
> +                            size_t out_bufsz)
> +{
> +    RemoteI2CBackend *backend =3D REMOTE_I2C_BACKEND(cuse);
> +    struct iovec in_iov[I2C_RDWR_IOCTL_MAX_MSGS + 2];
> +    struct iovec out_iov[I2C_RDWR_IOCTL_MAX_MSGS];
> +    const struct i2c_rdwr_ioctl_data *in_val =3D NULL;
> +    void *buf_copy =3D NULL;
> +    struct i2c_msg *msgs;
> +    uint32_t out_cnt =3D 0;
> +    uint32_t in_cnt =3D 0;
> +    size_t header_len;
> +    uint32_t i =3D 0;
> +
> +    if (cuse->ioctl_state =3D=3D I2C_IOCTL_START) {
> +        in_iov[0].iov_base =3D in_arg;
> +        in_iov[0].iov_len =3D sizeof(struct i2c_rdwr_ioctl_data);
> +        fuse_reply_ioctl_retry(req, in_iov, 1, NULL, 0);
> +        cuse->ioctl_state =3D I2C_IOCTL_GET;
> +        return;
> +    }
> +
> +    if (in_bufsz < sizeof(struct i2c_rdwr_ioctl_data)) {
> +        fuse_reply_err(req, EINVAL);
> +        return;
> +    }
> +
> +    /*
> +     * Create an isolated local copy of host memory packets for
> +     * transaction context tracking
> +     */
> +    buf_copy =3D g_memdup2(in_buf, in_bufsz);
> +    in_val =3D buf_copy;
> +
> +    if (cuse->in_data.in_buf) {
> +        g_free((gpointer)cuse->in_data.in_buf);
> +    }
> +
> +    cuse->in_data.last_cmd =3D I2C_RDWR;
> +    cuse->in_data.req =3D req;
> +    cuse->in_data.in_rdwr_data =3D in_val;
> +    cuse->in_data.in_buf =3D buf_copy;
> +
> +    switch (cuse->ioctl_state) {
> +    case I2C_IOCTL_GET:
> +        if (in_val->nmsgs > I2C_RDWR_IOCTL_MAX_MSGS) {
> +            fuse_reply_err(req, EINVAL);
> +            return;
> +        }
> +        in_iov[0].iov_base =3D in_arg;
> +        in_iov[0].iov_len =3D sizeof(struct i2c_rdwr_ioctl_data);
> +        in_iov[1].iov_base =3D in_val->msgs;
> +        in_iov[1].iov_len =3D in_val->nmsgs * sizeof(struct i2c_msg);
> +
> +        fuse_reply_ioctl_retry(req, in_iov, 2, NULL, 0);
> +        cuse->ioctl_state =3D I2C_IOCTL_RECV;
> +        break;
> +
> +    case I2C_IOCTL_RECV:
> +        msgs =3D (
> +            (struct i2c_msg *)(
> +                (uint8_t *)in_buf + sizeof(struct i2c_rdwr_ioctl_data)
> +            )
> +        );
> +
> +        in_iov[in_cnt].iov_base =3D in_arg;
> +        in_iov[in_cnt].iov_len =3D sizeof(struct i2c_rdwr_ioctl_data);
> +        in_cnt++;
> +
> +        in_iov[in_cnt].iov_base =3D in_val->msgs;
> +        in_iov[in_cnt].iov_len =3D in_val->nmsgs * sizeof(struct i2c_msg=
);
> +        in_cnt++;
> +
> +        for (i =3D 0; i < in_val->nmsgs; i++) {
> +            if (msgs[i].flags & I2C_M_RD) {
> +                out_iov[out_cnt].iov_base =3D msgs[i].buf;
> +                out_iov[out_cnt].iov_len =3D msgs[i].len;
> +                out_cnt++;
> +            } else {
> +                in_iov[in_cnt].iov_base =3D msgs[i].buf;
> +                in_iov[in_cnt].iov_len =3D msgs[i].len;
> +                in_cnt++;
> +            }
> +        }
> +
> +        fuse_reply_ioctl_retry(req, in_iov, in_cnt, out_iov, out_cnt);
> +        cuse->ioctl_state =3D I2C_IOCTL_SEND;
> +        break;
> +
> +    case I2C_IOCTL_SEND:
> +        header_len =3D sizeof(struct i2c_rdwr_ioctl_data);
> +        cuse->nmsgs =3D in_val->nmsgs;
> +
> +        cuse->rdwr_msgs =3D (struct i2c_msg *)((uint8_t *)buf_copy + hea=
der_len);
> +        cuse->rdwr_data_offset =3D (
> +            header_len + (cuse->nmsgs * sizeof(struct i2c_msg))
> +        );
> +        cuse->rdwr_in_buf_size =3D in_bufsz;
> +        cuse->rdwr_out_len =3D 0;
> +        cuse->msg_idx =3D 0;
> +
> +        remote_i2c_advance_rdwr_sequence(cuse);
> +        remote_i2c_fsm_dispatch(backend->frontend, REMOTE_I2C_CMD_START_=
TX);
> +        break;
> +
> +    case I2C_IOCTL_FINISHED:
> +        cuse->ioctl_state =3D I2C_IOCTL_START;
> +        cuse->last_ioctl =3D 0;
> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Remote I2C Backend: Invalid IOCTL state "
> +                      "encountered in RDWR handler: %d\n",
> +                      cuse->ioctl_state);
> +        break;
> +    }
> +
> +    trace_remote_i2c_master_i2cdev_smbus((uint8_t)cuse->ioctl_state);
> +}
> +
> +/*
> + * remote_i2c_cuse_cmd_smbus:
> + * @cuse: The concrete CUSE backend instance.
> + * @req: The active FUSE request context handle.
> + * @in_arg: Raw input memory reference targeting the calling process
> + *          space.
> + * @in_buf: Staged kernel buffer payload delivered via the asynchronous
> + *          FUSE engine.
> + * @in_bufsz: Total layout size in bytes of the incoming data block.
> + * @out_bufsz: Output tracking limit size reserved by the calling process
> + *             framework.
> + *
> + * Implements the Linux standard I2C_SMBUS ioctl layer. Orchestrates an
> + * asynchronous multi-phase FUSE ioctl state pipeline
> + * (START -> GET -> RECV/SEND) to isolate SMBus transaction structures,
> + * evaluate specialized transfer cycles (like Write-then-Read Repeated S=
tarts),
> + * and format parameters for the shared abstract frontend state engine.
> + */
> +static void remote_i2c_cuse_cmd_smbus(RemoteI2CBackendCuse *cuse,
> +                                      fuse_req_t req,
> +                                      void *in_arg,
> +                                      const void *in_buf,
> +                                      size_t in_bufsz,
> +                                      size_t out_bufsz)
> +{
> +    RemoteI2CBackend *backend =3D REMOTE_I2C_BACKEND(cuse);
> +    const struct i2c_smbus_ioctl_data *in_val =3D NULL;
> +    struct iovec in_iov[2];
> +    size_t full_size =3D 0;
> +    void *buf_copy =3D NULL;
> +
> +    if (cuse->ioctl_state =3D=3D I2C_IOCTL_START) {
> +        in_iov[0].iov_base =3D in_arg;
> +        in_iov[0].iov_len =3D sizeof(struct i2c_smbus_ioctl_data);
> +        fuse_reply_ioctl_retry(req, in_iov, 1, NULL, 0);
> +        cuse->ioctl_state =3D I2C_IOCTL_GET;
> +        return;
> +    }
> +
> +    if (in_bufsz < sizeof(struct i2c_smbus_ioctl_data)) {
> +        fuse_reply_err(req, EINVAL);
> +        return;
> +    }
> +
> +    full_size =3D (
> +        sizeof(struct i2c_smbus_ioctl_data) + sizeof(union i2c_smbus_dat=
a)
> +    );
> +    buf_copy =3D g_malloc0(full_size);
> +    memcpy(buf_copy, in_buf, in_bufsz);
> +
> +    in_val =3D buf_copy;
> +
> +    in_iov[0].iov_base =3D in_arg;
> +    in_iov[0].iov_len =3D sizeof(struct i2c_smbus_ioctl_data);
> +
> +    cuse->in_data.last_cmd =3D I2C_SMBUS;
> +    cuse->in_data.req =3D req;
> +    cuse->in_data.in_smbus_data =3D in_val;
> +    cuse->in_data.in_buf =3D buf_copy;
> +
> +    /*
> +     * Detect if this is an SMBus Block Read/Process Call that
> +     * requires a write-then-read chain sequence.
> +     */
> +    if (in_val->read_write =3D=3D I2C_SMBUS_READ &&
> +        in_val->size !=3D I2C_SMBUS_QUICK && in_val->size !=3D I2C_SMBUS=
_BYTE) {
> +        cuse->smbus_restart_read =3D true;
> +    } else {
> +        cuse->smbus_restart_read =3D false;
> +    }
> +
> +    /* Guard check for Quick commands that do not transmit data pointers=
 */
> +    if (cuse->ioctl_state =3D=3D I2C_IOCTL_GET && !in_val->read_write) {
> +        if (!in_val->data) {
> +            cuse->ioctl_state =3D I2C_IOCTL_SEND;
> +        }
> +    }
> +
> +    /*
> +     * Execute subsequent streaming segments of the FUSE memory
> +     * fetching engine.
> +     */
> +    switch (cuse->ioctl_state) {
> +    case I2C_IOCTL_START:
> +        break;
> +    case I2C_IOCTL_GET:
> +        if (in_val->read_write) {
> +            struct iovec out_iov =3D {
> +                .iov_base =3D in_val->data,
> +                .iov_len =3D sizeof(union i2c_smbus_data)
> +            };
> +            fuse_reply_ioctl_retry(req, in_iov, 1, &out_iov, 1);
> +            cuse->ioctl_state =3D I2C_IOCTL_RECV;
> +        } else {
> +            if (in_val->data) {
> +                in_iov[1].iov_base =3D in_val->data;
> +                in_iov[1].iov_len =3D sizeof(union i2c_smbus_data);
> +                fuse_reply_ioctl_retry(req, in_iov, 2, NULL, 0);
> +            }
> +            cuse->ioctl_state =3D I2C_IOCTL_SEND;
> +        }
> +        break;
> +    case I2C_IOCTL_RECV:
> +    case I2C_IOCTL_SEND:
> +        backend->is_recv =3D (cuse->ioctl_state =3D=3D I2C_IOCTL_RECV);
> +
> +        /* If a restart read is required, the FIRST phase is always a Wr=
ite */
> +        if (cuse->smbus_restart_read) {
> +            backend->is_recv =3D false;
> +        }
> +
> +        remote_i2c_serialize_smbus_write(cuse, cuse->in_data.in_smbus_da=
ta);
> +
> +        if (backend->is_recv) {
> +            remote_i2c_calculate_expected_recv_len(cuse);
> +        }
> +
> +        remote_i2c_fsm_dispatch(backend->frontend, REMOTE_I2C_CMD_START_=
TX);
> +        break;
> +    case I2C_IOCTL_FINISHED:
> +        cuse->ioctl_state =3D I2C_IOCTL_START;
> +        cuse->last_ioctl =3D 0;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Remote I2C Backend: Invalid IOCTL state "
> +                      "encountered in SMBus handler: %d\n",
> +                      cuse->ioctl_state);
> +        break;
> +    }
> +
> +    trace_remote_i2c_master_i2cdev_smbus((uint8_t)cuse->ioctl_state);
> +}
> +
> +/*
> + * remote_i2c_cuse_ioctl:
> + * @req: The active FUSE request context handle.
> + * @cmd: The specific Linux IOCTL command numeric ID arriving from the h=
ost
> + *       kernel.
> + * @arg: Untyped data pointer mapping process-space context memory argum=
ents.
> + * @fi: Driver metadata tracker for the targeted host file descriptor.
> + * @flags: Configuration execution metrics for specialized runtime envir=
onments.
> + * @in_buf: Incoming data vector packet delivered over the channel bound=
ary.
> + * @in_bufsz: Total available length footprint of the input buffer paylo=
ad.
> + * @out_bufsz: Reserved buffer limit assigned by the calling system driv=
er.
> + *
> + * Serves as the central multiplexing traffic cop for all arriving chara=
cter
> + * device IOCTL calls. Intercepts Linux storage and interface flags, che=
cks
> + * sequence lock states, and routes payload tasks cleanly down to dedica=
ted
> + * parser sub-modules.
> + */
> +static void remote_i2c_cuse_ioctl(fuse_req_t req, int cmd, void *arg,
> +                         struct fuse_file_info *fi, unsigned flags,
> +                         const void *in_buf, size_t in_bufsz, size_t out=
_bufsz)
> +{
> +    RemoteI2CBackendCuse *cuse =3D fuse_req_userdata(req);
> +    unsigned int ctl =3D cmd;
> +    (void)fi;
> +
> +    trace_remote_i2c_master_i2cdev_ioctl(cmd);
> +
> +    /*
> +     * Guard against compatibility modes that violate
> +     * the 64-bit boundary model
> +     */
> +    if (flags & FUSE_IOCTL_COMPAT) {
> +        fuse_reply_err(req, ENOSYS);
> +        return;
> +    }
> +
> +    if (cuse->ioctl_state =3D=3D I2C_IOCTL_START) {
> +        cuse->last_ioctl =3D ctl;
> +    } else if (cuse->last_ioctl !=3D ctl) {
> +        cuse->last_ioctl =3D 0;
> +        cuse->ioctl_state =3D I2C_IOCTL_START;
> +        fuse_reply_err(req, EINVAL);
> +        return;
> +    }
> +
> +    switch (ctl) {
> +    case I2C_SLAVE_FORCE:
> +        /*
> +         * Mapped for compliance; force-lock requests are
> +         * acknowledged directly.
> +         */
> +        fuse_reply_ioctl(req, 0, NULL, 0);
> +        break;
> +    case I2C_FUNCS:
> +        remote_i2c_cuse_functional(cuse, req, arg, in_buf);
> +        break;
> +    case I2C_SLAVE:
> +        i2cdev_address(cuse, req, arg, in_buf);
> +        break;
> +    case I2C_SMBUS:
> +        remote_i2c_cuse_cmd_smbus(cuse, req, arg, in_buf, in_bufsz, out_=
bufsz);
> +        break;
> +    case I2C_RDWR:
> +        i2cdev_cmd_rdwr(cuse, req, arg, in_buf, in_bufsz, out_bufsz);
> +        break;
> +    default:
> +        fuse_reply_err(req, ENOTTY);
> +        break;
> +    }
> +
> +    /* Normalize context states when a sub-transaction flow hits termina=
tion */
> +    if (cuse->ioctl_state =3D=3D I2C_IOCTL_FINISHED) {
> +        cuse->ioctl_state =3D I2C_IOCTL_START;
> +        cuse->last_ioctl =3D 0;
> +        trace_remote_i2c_master_i2cdev_ioctl_finished(cmd);
> +    }
> +}
> +
> +/*
> + * remote_i2c_cuse_poll:
> + * @req: The active FUSE request context handle.
> + * @fi: Driver metadata tracker for the targeted host file descriptor.
> + * @ph: Unused. I2C is master-initiated request-response; no async event=
s.
> + *
> + * Reports the device as always ready for read and write, matching the
> + * behaviour of the Linux kernel i2c-dev driver.
> + */
> +static void remote_i2c_cuse_poll(fuse_req_t req, struct fuse_file_info *=
fi,
> +                        struct fuse_pollhandle *ph)
> +{
> +    (void)ph;
> +    fuse_reply_poll(req, POLL_IN | POLL_OUT);
> +}
> +
> +static const struct cuse_lowlevel_ops i2cdev_ops =3D {
> +    .init       =3D remote_i2c_cuse_init,
> +    .open       =3D remote_i2c_cuse_open,
> +    .release    =3D remote_i2c_cuse_release,
> +    .read       =3D remote_i2c_cuse_read,
> +    .ioctl      =3D remote_i2c_cuse_ioctl,
> +    .poll       =3D remote_i2c_cuse_poll,
> +};
> +
> +/*
> + * remote_i2c_read_fuse_export:
> + * @opaque: Dereferenced pointer targeting the concrete CUSE backend ins=
tance.
> + *
> + * Serves as the high-speed data pump registered into the QEMU main AioC=
ontext
> + * loop. Constantly flushes the character node descriptor, intercepting
> + * arriving kernel data blocks, processing loop structures, and preventi=
ng
> + * context blocking.
> + */
> +static void remote_i2c_read_fuse_export(void *opaque)
> +{
> +    RemoteI2CBackendCuse *cuse =3D opaque;
> +    int ret;
> +
> +    do {
> +        ret =3D fuse_session_receive_buf(cuse->fuse_session, &cuse->fuse=
_buf);
> +    } while (ret =3D=3D -EINTR);
> +
> +    if (ret < 0) {
> +        return;
> +    }
> +
> +    fuse_session_process_buf(cuse->fuse_session, &cuse->fuse_buf);
> +    trace_remote_i2c_master_fuse_io_read();
> +}
> +
> +/*
> + * remote_i2c_fuse_export:
> + * @cuse: The concrete CUSE backend instance.
> + * @errp: Pointer tracking system initialization error telemetry.
> + *
> + * Configures argument vector clusters, allocates native multi-threaded
> + * system targets, builds character bindings via low-level libraries,
> + * and maps the resulting FUSE descriptor natively into QEMU's primary
> + * asynchronous loop handlers.
> + */
> +int remote_i2c_fuse_export(RemoteI2CBackendCuse *cuse, Error **errp)
> +{
> +    GPtrArray *argv_ptr =3D g_ptr_array_new();
> +    char *curdir =3D get_current_dir_name();
> +    struct fuse_session *session =3D NULL;
> +    struct cuse_info ci =3D { 0 };
> +    char dev_name[128];
> +    int multithreaded;
> +    int ret;
> +
> +    /* Build clean FUSE parameter vectors manually */
> +    g_ptr_array_add(argv_ptr, g_strdup("qemu-remote-i2c"));
> +    g_ptr_array_add(argv_ptr, g_strdup("-f"));
> +    g_ptr_array_add(argv_ptr, g_strdup("-s"));
> +
> +    if (cuse->debug) {
> +        g_ptr_array_add(argv_ptr, g_strdup("-d"));
> +    }
> +
> +    if (cuse->fuse_opts) {
> +        char **opts =3D g_strsplit(cuse->fuse_opts, " ", -1);
> +        for (int i =3D 0; opts[i] !=3D NULL; i++) {
> +            if (opts[i][0] !=3D '\0') {
> +                g_ptr_array_add(argv_ptr, g_strdup(opts[i]));
> +            }
> +        }
> +        g_strfreev(opts);
> +    }
> +
> +    /* Prevent stack overrides; enforce size-bounded buffer formatting */
> +    snprintf(dev_name, sizeof(dev_name), "DEVNAME=3D%s", cuse->devname);
> +    const char *dev_info_argv[] =3D { dev_name };
> +
> +    memset(&ci, 0, sizeof(ci));
> +    ci.dev_major =3D 0;
> +    ci.dev_minor =3D 0;
> +    ci.dev_info_argc =3D 1;
> +    ci.dev_info_argv =3D dev_info_argv;
> +    ci.flags =3D CUSE_UNRESTRICTED_IOCTL;
> +
> +    session =3D cuse_lowlevel_setup(argv_ptr->len, (char **)argv_ptr->pd=
ata,
> +                                  &ci, &i2cdev_ops, &multithreaded, cuse=
);
> +
> +    g_ptr_array_set_free_func(argv_ptr, g_free);
> +    g_ptr_array_free(argv_ptr, TRUE);
> +
> +    if (session =3D=3D NULL) {
> +        error_setg(errp, "Remote I2C Backend: cuse_lowlevel_setup() fail=
ed");
> +        errno =3D EINVAL;
> +        return -1;
> +    }
> +
> +    ret =3D chdir(curdir);
> +    if (ret =3D=3D -1) {
> +        error_setg(errp,
> +                   "Remote I2C Backend: chdir() failed to restore root p=
ath");
> +        return -1;
> +    }
> +
> +    /*
> +     * Link into QEMU's primary infrastructure loop for
> +     * clean data multiplexing
> +     */
> +    cuse->ctx =3D iohandler_get_aio_context();
> +    aio_set_fd_handler(cuse->ctx, fuse_session_fd(session),
> +                       remote_i2c_read_fuse_export, NULL,
> +                       NULL, NULL, cuse);
> +    cuse->fuse_session =3D session;
> +
> +    trace_remote_i2c_master_fuse_export();
> +    return 0;
> +}
> +
> +/*
> + * remote_i2c_cuse_complete:
> + * @uc: Raw object handle routing back into the UserCreatable QOM
> + *      component interface.
> + * @errp: Pointer tracking system initialization error telemetry.
> + *
> + * Implements the standard QOM post-instantiation lifecycle callback.
> + * Asserts property constraint sanity checks before spinning up runtime
> + * export workers.
> + */
> +static void remote_i2c_cuse_complete(UserCreatable *uc, Error **errp)
> +{
> +    RemoteI2CBackendCuse *cuse =3D REMOTE_I2C_BACKEND_CUSE(uc);
> +
> +    if (!cuse->devname) {
> +        error_setg(errp, "remote-i2c-backend-cuse requires 'devname' pro=
perty");
> +        return;
> +    }
> +
> +    if (remote_i2c_fuse_export(cuse, errp) < 0) {
> +        return;
> +    }
> +}
> +
> +static void remote_i2c_cuse_class_init(ObjectClass *oc, const void *data)
> +{
> +    RemoteI2CBackendClass *bc =3D REMOTE_I2C_BACKEND_CLASS(oc);
> +    UserCreatableClass *ucc =3D USER_CREATABLE_CLASS(oc);
> +
> +    bc->on_tx_complete =3D remote_i2c_cuse_on_tx_complete;
> +    bc->on_tx_error =3D remote_i2c_cuse_on_tx_error;
> +
> +    ucc->complete =3D remote_i2c_cuse_complete;
> +
> +    object_class_property_add_bool(oc, "debug",
> +                                   cuse_get_debug, cuse_set_debug);
> +    object_class_property_set_description(oc, "debug",
> +                                          "Enable debug logging for CUSE=
 backend");
> +
> +    object_class_property_add_str(oc, "devname",
> +                                  cuse_get_devname, cuse_set_devname);
> +    object_class_property_add_str(oc, "fuse-opts",
> +                                  cuse_get_fuse_opts,
> +                                  cuse_set_fuse_opts);
> +}
> +
> +static const TypeInfo remote_i2c_cuse_info =3D {
> +    .name =3D TYPE_REMOTE_I2C_BACKEND_CUSE,
> +    .parent =3D TYPE_REMOTE_I2C_BACKEND,
> +    .instance_size =3D sizeof(RemoteI2CBackendCuse),
> +    .class_init =3D remote_i2c_cuse_class_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { TYPE_USER_CREATABLE },
> +        { }
> +    }
> +};
> +
> +static void remote_i2c_cuse_register_types(void)
> +{
> +    type_register_static(&remote_i2c_cuse_info);
> +}
> +
> +type_init(remote_i2c_cuse_register_types)
> diff --git a/hw/i2c/remote-i2c-fsm.c b/hw/i2c/remote-i2c-fsm.c
> new file mode 100644
> index 0000000000..cca35580f1
> --- /dev/null
> +++ b/hw/i2c/remote-i2c-fsm.c
> @@ -0,0 +1,521 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Remote I2C Master Finite State Machine (FSM)
> + *
> + * This module implements a non-blocking, asynchronous Finite State Mach=
ine
> + * (FSM) for driving a QEMU I2C master. It bridges a remote backend (whi=
ch
> + * issues transactions) with QEMU's internal I2C bus architecture.
> + *
> + * The FSM ensures that QEMU's main loop is not blocked during lengthy I=
2C
> + * transactions or when communicating with asynchronous I2C slave devices
> + * (which require simulated clock stretching).
> + *
> + * Execution Model:
> + * ----------------
> + * The state machine is driven by a QEMU Bottom Half (BH) loop
> + * (`remote_i2c_fsm_bh`).
> + *
> + * 1. Dispatch: The backend initiates a transaction via
> + *    `remote_i2c_fsm_dispatch` with `REMOTE_I2C_CMD_START_TX`.
> + * 2. Execution: The FSM processes a single byte or address frame, updat=
es its
> + *    internal state, and then either re-schedules the BH immediately (f=
or
> + *    synchronous devices) or sets a timer to wake up later.
> + * 3. Completion: Once the transaction finishes or errors out, control is
> + *    returned to the backend via `on_tx_complete` or `on_tx_error` call=
backs.
> + *
> + * State Lifecycle:
> + * ----------------
> + * - I2C_BUS_IDLE     : Resting state. Awaits backend dispatch. Checks
> + *                      for bus busyness and handles retry timers if
> + *                      arbitration is lost.
> + * - I2C_BUS_ADDR     : Master asserts the bus and sends the slave addre=
ss. If
> + *                      the slave NACKs, the transaction is immediately =
aborted
> + *                      (ENXIO). If ACKed, transitions to SEND, RECV,
> + *                      or WAIT_STRETCH.
> + * - I2C_BUS_SEND     : Pushes data bytes to the bus. Loops synchronousl=
y or
> + *                      yields asynchronously per byte.
> + * - I2C_BUS_RECV     : Reads data bytes from the bus. Similar yielding =
behavior
> + *                      as SEND.
> + * - I2C_BUS_WAIT_STRETCH : Yields execution back to QEMU to simulate cl=
ock
> + *                      stretching for async slaves or to enforce artifi=
cial
> + *                      delays (slow_delay_value_ms). Upon timer expirat=
ion,
> + *                      bounces back to SEND/RECV.
> + * - I2C_BUS_END      : Transitional state to guarantee `i2c_end_transfe=
r` is
> + *                      called gracefully before finalizing.
> + * - I2C_BUS_FINISHED : Cleans up timers, releases the I2C bus, and invo=
kes
> + *                      backend callbacks.
> + *
> + * Asynchronous Support & Clock Stretching:
> + * ----------------------------------------
> + * When communicating with asynchronous slave devices
> + * (`sc->send_async !=3D NULL`), the FSM cannot process the entire trans=
action
> + * buffer in a single pass.
> + * Instead, it sends/receives a single byte, transitions to
> + * `I2C_BUS_WAIT_STRETCH`, and sets a virtual timer (`s->timer_step`). W=
hen
> + * the timer fires, the BH loop resumes processing the next byte. This
> + * effectively simulates hardware clock stretching without stalling the
> + * guest OS.
> + *
> + * Error Handling:
> + * ---------------
> + * - NACKs: Immediately abort the transaction and release the bus.
> + * - Bus Busy: If arbitration is lost, the module can either error out (=
EBUSY)
> + *   or back off and retry using a cooldown timer.
> + * - Timeouts: Monitored during `WAIT_STRETCH` to prevent hung transacti=
ons if
> + *   a remote slave becomes unresponsive.
> + * - Manual Abort: The backend can issue `REMOTE_I2C_CMD_ABORT` or `RESE=
T` to
> + *   forcefully release the bus and reset the FSM.
> + *
> + * Author:
> + * Ilya Chichkov <ilya.chichkov.dev@gmail.com>
> + *
> + */
> +#include "qemu/osdep.h"
> +
> +#include "qapi/error.h"
> +#include "qemu/main-loop.h"
> +#include "hw/i2c/i2c.h"
> +#include "hw/core/qdev-properties-system.h"
> +#include "qemu/error-report.h"
> +#include "qemu/bswap.h"
> +#include "qemu/aio.h"
> +#include "qemu/log.h"
> +#include "qapi/visitor.h"
> +#include "hw/i2c/remote-i2c-cuse.h"
> +#include "hw/i2c/remote-i2c-backend.h"
> +#include "qapi/error.h"
> +#include "trace.h"
> +
> +#include "hw/i2c/remote-i2c-master.h"
> +
> +#define I2C_BUS_BUSY_CHECK_TIMER_COOLDOWN_NS 50000
> +
> +typedef enum i2c_state_result {
> +    I2C_HANDLER_OK,
> +    I2C_HANDLER_ERROR,
> +} i2c_state_result;
> +
> +static const char *remote_i2c_bus_state_str(int state)
> +{
> +    switch (state) {
> +    case I2C_BUS_IDLE:          return "Idle";
> +    case I2C_BUS_ADDR:          return "Address";
> +    case I2C_BUS_SEND:          return "Send";
> +    case I2C_BUS_RECV:          return "Receive";
> +    case I2C_BUS_END:           return "End";
> +    case I2C_BUS_FINISHED:      return "Finished";
> +    case I2C_BUS_WAIT_STRETCH:  return "WaitStretch";
> +    default:                    return "Unknown";
> +    }
> +}
> +
> +static
> +void remote_i2c_fsm_change_bus_state(RemoteI2CMasterState *s, int new_st=
ate)
> +{
> +    uint16_t old_state =3D s->backend->bus_state;
> +    s->backend->bus_state =3D new_state;
> +
> +    trace_remote_i2c_master_bus_state_change(
> +        remote_i2c_bus_state_str(old_state),
> +        remote_i2c_bus_state_str(new_state)
> +    );
> +}
> +
> +static
> +void remote_i2c_abort_transaction(RemoteI2CMasterState *s,
> +                                  int errno_code, const char *reason)
> +{
> +    RemoteI2CBackendClass *bc =3D REMOTE_I2C_BACKEND_GET_CLASS(s->backen=
d);
> +
> +    timer_del(s->timer);
> +    timer_del(s->timer_start_transmit);
> +    timer_del(s->timer_step);
> +
> +    if (s->backend->bus_state !=3D I2C_BUS_IDLE &&
> +        s->backend->bus_state !=3D I2C_BUS_FINISHED) {
> +        i2c_end_transfer(s->bus);
> +    }
> +
> +    i2c_bus_release(s->bus);
> +    remote_i2c_fsm_change_bus_state(s, I2C_BUS_IDLE);
> +
> +    s->backend->is_transaction_failed =3D true;
> +    s->backend->addr_acked =3D false;
> +    s->backend->data_acked =3D false;
> +    s->backend->timed_out =3D false;
> +    s->backend->transaction_index =3D 0;
> +    s->backend->waiting_for_async =3D false;
> +
> +    trace_remote_i2c_master_abort(errno_code,
> +                                  s->backend->address,
> +                                  reason ? reason : "Unknown error");
> +
> +    if (bc->on_tx_error) {
> +        bc->on_tx_error(s->backend, errno_code);
> +    }
> +}
> +
> +static i2c_state_result remote_i2c_finish_handler(RemoteI2CMasterState *=
s)
> +{
> +    RemoteI2CBackendClass *bc =3D REMOTE_I2C_BACKEND_GET_CLASS(s->backen=
d);
> +
> +    timer_del(s->timer);
> +    timer_del(s->timer_start_transmit);
> +    timer_del(s->timer_step);
> +
> +    if (s->backend->is_transaction_failed) {
> +        remote_i2c_fsm_change_bus_state(s, I2C_BUS_IDLE);
> +        i2c_end_transfer(s->bus);
> +        i2c_bus_release(s->bus);
> +        if (bc->on_tx_error) {
> +            bc->on_tx_error(s->backend, EIO);
> +        }
> +        return I2C_HANDLER_ERROR;
> +    }
> +
> +    remote_i2c_fsm_change_bus_state(s, I2C_BUS_IDLE);
> +
> +    /*
> +     * Call on_tx_complete BEFORE ending or releasing the bus.
> +     * If the backend chains another sub-message via REMOTE_I2C_CMD_NEXT=
_MSG
> +     * (repeated start), it sets bus_state back to I2C_BUS_ADDR. In that=
 case
> +     * we must NOT call i2c_end_transfer (no STOP to the slave) and must=
 NOT
> +     * release the bus. Only issue STOP + release when the backend is tr=
uly done
> +     * and bus_state remains IDLE.
> +     */
> +    if (bc->on_tx_complete) {
> +        bc->on_tx_complete(s->backend);
> +    }
> +
> +    if (s->backend->bus_state =3D=3D I2C_BUS_IDLE) {
> +        i2c_end_transfer(s->bus);
> +        i2c_bus_release(s->bus);
> +    }
> +
> +    return I2C_HANDLER_OK;
> +}
> +
> +static
> +void remote_i2c_is_slave_async(RemoteI2CMasterState *s)
> +{
> +    I2CNode *node;
> +    I2CSlave *slave;
> +    I2CSlaveClass *sc;
> +
> +    node =3D QLIST_FIRST(&s->bus->current_devs);
> +    if (node) {
> +        slave =3D node->elt;
> +        sc =3D I2C_SLAVE_GET_CLASS(slave);
> +        s->backend->is_slave_async =3D (sc->send_async !=3D NULL);
> +    } else {
> +        s->backend->is_slave_async =3D false;
> +    }
> +}
> +
> +static
> +void remote_i2c_send_ack(RemoteI2CMasterState *s)
> +{
> +    i2c_ack(s->bus);
> +}
> +
> +static
> +void remote_i2c_wait_stretch(RemoteI2CMasterState *s)
> +{
> +    timer_mod(s->timer,
> +              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + s->backend->timeou=
t_ms);
> +    remote_i2c_fsm_change_bus_state(s, I2C_BUS_WAIT_STRETCH);
> +}
> +
> +static
> +void remote_i2c_stretch_clk(RemoteI2CMasterState *s, int64_t expire_time=
r)
> +{
> +    timer_mod(s->timer_step,
> +              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + expire_timer);
> +}
> +
> +static i2c_state_result remote_i2c_addr_handler(RemoteI2CMasterState *s)
> +{
> +    bool started_async =3D true;
> +
> +    s->backend->transaction_index =3D 0;
> +    s->backend->is_transaction_failed =3D false;
> +    s->backend->addr_acked =3D false;
> +    s->backend->data_acked =3D false;
> +    s->backend->timed_out =3D false;
> +
> +    if (s->backend->is_recv) {
> +        trace_remote_i2c_master_i2cdev_receive(s->backend->transaction_l=
ength);
> +
> +        /* i2c_start_recv returns non-zero if the slave NACKs the addres=
s */
> +        if (i2c_start_recv(s->bus, s->backend->address)) {
> +            goto nack;
> +        }
> +
> +        remote_i2c_is_slave_async(s);
> +        if (s->backend->is_slave_async) {
> +            remote_i2c_wait_stretch(s);
> +            return I2C_HANDLER_OK;
> +        }
> +
> +        s->backend->addr_acked =3D true;
> +        remote_i2c_send_ack(s);
> +        remote_i2c_fsm_change_bus_state(s, I2C_BUS_RECV);
> +    } else {
> +        trace_remote_i2c_master_i2cdev_send(s->backend->transaction_leng=
th);
> +
> +        if (i2c_start_send_async(s->bus, s->backend->address)) {
> +            /*
> +             * Fallback to synchronous send.
> +             * If it still returns non-zero, it's a NACK.
> +             */
> +            if (i2c_start_send(s->bus, s->backend->address)) {
> +                goto nack;
> +            }
> +            started_async =3D false;
> +        }
> +
> +        if (started_async) {
> +            remote_i2c_is_slave_async(s);
> +        } else {
> +            s->backend->is_slave_async =3D false;
> +        }
> +
> +        if (s->backend->is_slave_async) {
> +            remote_i2c_wait_stretch(s);
> +            return I2C_HANDLER_OK;
> +        }
> +
> +        s->backend->addr_acked =3D true;
> +        remote_i2c_send_ack(s);
> +        remote_i2c_fsm_change_bus_state(s, I2C_BUS_SEND);
> +    }
> +
> +    return I2C_HANDLER_OK;
> +
> +nack:
> +    remote_i2c_abort_transaction(s, ENXIO, "Address NACKed");
> +
> +    return I2C_HANDLER_ERROR;
> +}
> +
> +static i2c_state_result remote_i2c_send_handler(RemoteI2CMasterState *s)
> +{
> +    uint8_t data =3D 0;
> +    int ret =3D 0;
> +
> +    if (s->backend->is_slave_async && s->backend->data_acked) {
> +        s->backend->data_acked =3D false;
> +        s->backend->transaction_index++;
> +    }
> +
> +    if (s->backend->transaction_index >=3D s->backend->transaction_lengt=
h) {
> +        remote_i2c_fsm_change_bus_state(s, I2C_BUS_END);
> +        return I2C_HANDLER_OK;
> +    }
> +
> +    if (s->backend->is_slave_async) {
> +        data =3D s->backend->transaction_buf[s->backend->transaction_ind=
ex];
> +        trace_remote_i2c_master_send_byte(data);
> +
> +        i2c_send_async(s->bus, data);
> +        remote_i2c_wait_stretch(s);
> +        return I2C_HANDLER_OK;
> +    }
> +
> +    for (; s->backend->transaction_index < s->backend->transaction_lengt=
h;
> +         s->backend->transaction_index++) {
> +        data =3D s->backend->transaction_buf[s->backend->transaction_ind=
ex];
> +        trace_remote_i2c_master_send_byte(data);
> +
> +        ret =3D i2c_send(s->bus, data);
> +        if (ret !=3D 0) {
> +            s->backend->is_transaction_failed =3D true;
> +            remote_i2c_fsm_change_bus_state(s, I2C_BUS_END);
> +            return I2C_HANDLER_ERROR;
> +        }
> +    }
> +
> +    remote_i2c_fsm_change_bus_state(s, I2C_BUS_END);
> +    return I2C_HANDLER_OK;
> +}
> +
> +static i2c_state_result remote_i2c_recv_handler(RemoteI2CMasterState *s)
> +{
> +    uint8_t buf =3D 0;
> +
> +    s->backend->data_acked =3D false;
> +
> +    if (s->backend->transaction_index < s->backend->transaction_length) {
> +        buf =3D i2c_recv(s->bus);
> +        trace_remote_i2c_master_recv_byte(buf);
> +
> +        s->backend->transaction_buf[s->backend->transaction_index] =3D b=
uf;
> +        s->backend->transaction_index++;
> +    }
> +
> +    if (s->backend->transaction_index >=3D s->backend->transaction_lengt=
h) {
> +        remote_i2c_fsm_change_bus_state(s, I2C_BUS_END);
> +        return I2C_HANDLER_OK;
> +    }
> +
> +    if (s->backend->is_slave_async) {
> +        remote_i2c_wait_stretch(s);
> +    } else {
> +        remote_i2c_send_ack(s);
> +    }
> +
> +    return I2C_HANDLER_OK;
> +}
> +
> +/*
> + * remote_i2c_fsm_bh:
> + * @opaque: Dereferenced generic pointer pointing to the RemoteI2CMaster=
State.
> + *
> + * Serves as the primary asynchronous Bottom Half (BH) scheduler and sta=
te
> + * dispatch loop for the frontend I2C hardware machine.
> + */
> +void remote_i2c_fsm_bh(void *opaque)
> +{
> +    RemoteI2CMasterState *s =3D opaque;
> +
> +    s->backend->waiting_for_async =3D false;
> +
> +    switch (s->backend->bus_state) {
> +    case I2C_BUS_IDLE:
> +        break;
> +    case I2C_BUS_ADDR:
> +        remote_i2c_addr_handler(s);
> +        break;
> +    case I2C_BUS_SEND:
> +        remote_i2c_send_handler(s);
> +        break;
> +    case I2C_BUS_RECV:
> +        remote_i2c_recv_handler(s);
> +        break;
> +    case I2C_BUS_END:
> +        remote_i2c_fsm_change_bus_state(s, I2C_BUS_FINISHED);
> +        break;
> +    case I2C_BUS_FINISHED:
> +        remote_i2c_finish_handler(s);
> +        break;
> +    case I2C_BUS_WAIT_STRETCH:
> +    case I2C_BUS_WAIT_RELEASE:
> +        if (s->backend->timed_out) {
> +            remote_i2c_abort_transaction(s, ETIMEDOUT,
> +                                         "Timed out waiting for slave to=
 "
> +                                         "release clock stretching");
> +            return;
> +        }
> +
> +        if (!s->delay_completed && s->slow_delay_value_ms > 0) {
> +            s->delay_completed =3D true;
> +            remote_i2c_stretch_clk(s, s->slow_delay_value_ms * 1000000UL=
L);
> +            trace_remote_i2c_master_stretch_delay(s->slow_delay_value_ms=
);
> +            return;
> +        }
> +
> +        s->delay_completed =3D false;
> +
> +        timer_del(s->timer);
> +        timer_del(s->timer_start_transmit);
> +        timer_del(s->timer_step);
> +
> +        if (!s->backend->addr_acked) {
> +            trace_remote_i2c_master_async_ack();
> +            s->backend->addr_acked =3D true;
> +            s->backend->data_acked =3D s->backend->is_recv;
> +        } else {
> +            trace_remote_i2c_master_async_ack();
> +            s->backend->data_acked =3D true;
> +        }
> +
> +        if (s->backend->is_recv) {
> +            remote_i2c_fsm_change_bus_state(s, I2C_BUS_RECV);
> +            remote_i2c_recv_handler(s);
> +        } else {
> +            remote_i2c_fsm_change_bus_state(s, I2C_BUS_SEND);
> +            remote_i2c_send_handler(s);
> +        }
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Remote I2C Master: Invalid bus state %d\n",
> +                      s->backend->bus_state);
> +        remote_i2c_abort_transaction(s, EINVAL, "Invalid FSM state");
> +        break;
> +    }
> +
> +    /* Reschedule Logic */
> +    if (s->backend->bus_state !=3D I2C_BUS_IDLE &&
> +        s->backend->bus_state !=3D I2C_BUS_WAIT_STRETCH) {
> +        qemu_bh_schedule(s->bh);
> +    }
> +}
> +
> +static void remote_i2c_bus_start_transmit(RemoteI2CMasterState *s)
> +{
> +    RemoteI2CBackendClass *bc =3D REMOTE_I2C_BACKEND_GET_CLASS(s->backen=
d);
> +
> +    if (i2c_bus_busy(s->bus)) {
> +        if (s->raise_arbitrage_lost) {
> +            if (bc->on_tx_error) {
> +                bc->on_tx_error(s->backend, EBUSY);
> +            }
> +            return;
> +        } else {
> +            timer_mod(s->timer_start_transmit,
> +                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +                      I2C_BUS_BUSY_CHECK_TIMER_COOLDOWN_NS);
> +            return;
> +        }
> +    }
> +
> +    remote_i2c_fsm_change_bus_state(s, I2C_BUS_ADDR);
> +
> +    i2c_bus_master(s->bus, s->bh);
> +    i2c_schedule_pending_master(s->bus);
> +}
> +
> +void remote_i2c_fsm_dispatch(RemoteI2CMasterState *s, RemoteI2CCommand c=
md)
> +{
> +    switch (cmd) {
> +    case REMOTE_I2C_CMD_START_TX:
> +        remote_i2c_bus_start_transmit(s);
> +        break;
> +    case REMOTE_I2C_CMD_NEXT_MSG:
> +        /*
> +         * Repeated START: the bus is already held from the previous
> +         * sub-transaction. Skip bus acquisition and go straight to the
> +         * address phase so the slave sees Sr (repeated start) not a
> +         * full STOP+START cycle.
> +         *
> +         * Do NOT schedule the BH here. The BH reschedule logic at the
> +         * bottom of remote_i2c_fsm_bh will schedule it once state=3DADDR
> +         * is visible on the next iteration.
> +         */
> +        remote_i2c_fsm_change_bus_state(s, I2C_BUS_ADDR);
> +        break;
> +    case REMOTE_I2C_CMD_ABORT:
> +        remote_i2c_abort_transaction(s, ECANCELED,
> +                                     "Transaction aborted by backend");
> +        break;
> +    case REMOTE_I2C_CMD_RESET:
> +        if (s->backend->bus_state !=3D I2C_BUS_IDLE &&
> +            s->backend->bus_state !=3D I2C_BUS_FINISHED) {
> +            i2c_end_transfer(s->bus);
> +        }
> +        i2c_bus_release(s->bus);
> +        remote_i2c_fsm_change_bus_state(s, I2C_BUS_IDLE);
> +        s->backend->is_transaction_failed =3D false;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Remote I2C Master: Invalid command %d\n", cmd);
> +        break;
> +    }
> +}
> +
> +void remote_i2c_fsm_timer_start_transmit_cb(void *opaque)
> +{
> +    remote_i2c_bus_start_transmit(opaque);
> +}
> diff --git a/hw/i2c/remote-i2c-master.c b/hw/i2c/remote-i2c-master.c
> new file mode 100644
> index 0000000000..0fe522b805
> --- /dev/null
> +++ b/hw/i2c/remote-i2c-master.c
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Remote I2C Master
> + *
> + * This device exposes a QEMU I2C bus to the host system. Utilizing a de=
coupled
> + * backend architecture (such as the CUSE backend), it allows external p=
rograms
> + * or scripts on the host to interact with I2C slaves simulated inside Q=
EMU as
> + * if they were real hardware devices attached to the host.
> + *
> + * Features:
> + * - Clean Frontend/Backend separation for transport-agnostic I2C emulat=
ion.
> + * - Implements the Linux I2C ioctl interface (I2C_RDWR, I2C_SMBUS) via =
CUSE.
> + * - Supports standard I2C and SMBus protocols.
> + * - Handles asynchronous I2C transactions and clock stretching via QEMU
> + *   Bottom Halves (BH).
> + * - Configurable asynchronous slave timeouts (e.g., timeout-ms).
> + * - Supports SMBus "Repeated Start" for atomic Write-then-Read operatio=
ns.
> + *
> + * Usage:
> + * Add the backend object and the master device to your QEMU command lin=
e:
> + *
> + *   -object remote-i2c-backend-cuse,id=3Dmy_cuse_backend,devname=3Di2c-=
33 \
> + *   -device remote-i2c-master,i2cbus=3D/machine/soc[0]/i2c[0]/i2c,\
> + *           backend=3Dmy_cuse_backend,timeout-ms=3D8000
> + *
> + * This creates a character device at /dev/i2c-33 on the host.
> + * Use standard tools (i2c-tools) or C programs to access it:
> + *
> + *   i2cdetect -y -l
> + *   i2cget -y <bus_id> <addr> <reg>
> + *
> + * Author:
> + * Ilya Chichkov <ilya.chichkov.dev@gmail.com>
> + *
> + */
> +#include "qemu/osdep.h"
> +
> +#include "qapi/error.h"
> +#include "qemu/main-loop.h"
> +#include "hw/i2c/i2c.h"
> +#include "hw/core/qdev-properties-system.h"
> +#include "qemu/error-report.h"
> +#include "qemu/bswap.h"
> +#include "qemu/aio.h"
> +#include "qemu/log.h"
> +#include "qapi/visitor.h"
> +#include "qapi/error.h"
> +#include "trace.h"
> +
> +#include "hw/i2c/remote-i2c-master.h"
> +
> +static void remote_i2c_timer_cb(void *opaque)
> +{
> +    RemoteI2CMasterState *s =3D opaque;
> +
> +    if (s->backend->bus_state =3D=3D I2C_BUS_WAIT_STRETCH) {
> +        trace_remote_i2c_master_timeout(s->backend->timeout_ms);
> +        s->backend->timed_out =3D true;
> +        qemu_bh_schedule(s->bh);
> +    } else if (s->backend->bus_state !=3D I2C_BUS_IDLE &&
> +               s->backend->bus_state !=3D I2C_BUS_WAIT_STRETCH) {
> +        /* Retry logic */
> +        timer_mod(s->timer_start_transmit,
> +                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 50000);
> +    }
> +}
> +
> +static void remote_i2c_timer_step_cb(void *opaque)
> +{
> +    RemoteI2CMasterState *s =3D opaque;
> +    qemu_bh_schedule(s->bh);
> +}
> +
> +static void remote_i2c_master_realize(DeviceState *dev, Error **errp)
> +{
> +    RemoteI2CMasterState *s =3D REMOTE_I2C_MASTER(dev);
> +
> +    if (!s->backend) {
> +        error_setg(errp, "remote-i2c-master requires a 'backend' propert=
y");
> +        return;
> +    }
> +
> +    s->backend->frontend =3D s;
> +    s->backend->timeout_ms =3D s->timeout_ms;
> +
> +    s->bh =3D aio_bh_new_guarded(qemu_get_aio_context(),
> +                               remote_i2c_fsm_bh,
> +                               s,
> +                               &dev->mem_reentrancy_guard);
> +
> +    s->timer =3D timer_new(QEMU_CLOCK_VIRTUAL, SCALE_MS,
> +                         &remote_i2c_timer_cb, s);
> +    s->timer_start_transmit =3D timer_new(QEMU_CLOCK_VIRTUAL,
> +                                        SCALE_NS,
> +                                        &remote_i2c_fsm_timer_start_tran=
smit_cb,
> +                                        s);
> +    s->timer_step =3D timer_new(QEMU_CLOCK_VIRTUAL, SCALE_NS,
> +                              &remote_i2c_timer_step_cb, s);
> +}
> +
> +static void remote_i2c_master_reset(Object *obj, ResetType type)
> +{
> +    RemoteI2CMasterState *s =3D REMOTE_I2C_MASTER(obj);
> +
> +    /* remote_i2c_fsm_dispatch is defined in remote-i2c-fsm.c */
> +    remote_i2c_fsm_dispatch(s, REMOTE_I2C_CMD_RESET);
> +}
> +
> +static const Property remote_i2c_master_properties[] =3D {
> +    DEFINE_PROP_LINK("i2cbus", RemoteI2CMasterState, bus,
> +                     TYPE_I2C_BUS, I2CBus *),
> +    DEFINE_PROP_STRING("name", RemoteI2CMasterState, name),
> +    DEFINE_PROP_LINK("backend", RemoteI2CMasterState, backend,
> +                     TYPE_REMOTE_I2C_BACKEND, RemoteI2CBackend *),
> +    DEFINE_PROP_BOOL("raise_arbitrage_lost",
> +                     RemoteI2CMasterState,
> +                     raise_arbitrage_lost, false),
> +    DEFINE_PROP_UINT32("timeout-ms",
> +                       RemoteI2CMasterState, timeout_ms, 1000),
> +};
> +
> +static void remote_i2c_master_class_init(ObjectClass *klass, const void =
*data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> +
> +    device_class_set_props(dc, remote_i2c_master_properties);
> +    dc->realize =3D remote_i2c_master_realize;
> +    dc->desc =3D "Remote I2C Controller";
> +    rc->phases.enter =3D remote_i2c_master_reset;
> +}
> +
> +static const TypeInfo remote_i2c_master_info =3D {
> +    .name          =3D TYPE_REMOTE_I2C_MASTER,
> +    .parent        =3D TYPE_DEVICE,
> +    .instance_size =3D sizeof(RemoteI2CMasterState),
> +    .class_init    =3D remote_i2c_master_class_init,
> +};
> +
> +static void remote_i2c_master_register_types(void)
> +{
> +    type_register_static(&remote_i2c_master_info);
> +}
> +
> +type_init(remote_i2c_master_register_types)
> diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
> index 1ad0e95c0e..c08cdef7d9 100644
> --- a/hw/i2c/trace-events
> +++ b/hw/i2c/trace-events
> @@ -61,3 +61,32 @@ pca954x_read_data(uint8_t value) "PCA954X read data: 0=
x%02x"
>=20=20
>  imx_i2c_read(const char *id, const char *reg, uint64_t ofs, uint64_t val=
ue) "%s:[%s (0x%" PRIx64 ")] -> 0x%02" PRIx64
>  imx_i2c_write(const char *id, const char *reg, uint64_t ofs, uint64_t va=
lue) "%s:[%s (0x%" PRIx64 ")] <- 0x%02" PRIx64
> +
> +# remote-i2c-master.c
> +remote_i2c_master_realize(void) "device realized"
> +remote_i2c_master_reset_enter(void) "reset enter"
> +remote_i2c_master_backend_select(const char *backend) "selected backend:=
 %s"
> +
> +# remote-i2c-fsm.c
> +remote_i2c_master_bus_state_change(const char *old, const char *new) "bu=
s State: %s -> %s"
> +remote_i2c_master_async_ack(void) "async ACK received"
> +remote_i2c_master_abort(int error, uint8_t addr, const char *reason) "tr=
ansaction ABORTED (errno=3D%d) addr=3D0x%02x, reason: %s"
> +remote_i2c_master_timeout(uint16_t timeout) "watchdog timer expired (tim=
eout_ms=3D%d)"
> +remote_i2c_master_stretch_delay(uint16_t delay) "master simulating stret=
ch delay: %d"
> +remote_i2c_master_send_byte(uint8_t byte) "wire TX: 0x%02x"
> +remote_i2c_master_recv_byte(uint8_t byte) "wire RX: 0x%02x"
> +remote_i2c_master_arbitration_lost(const char *abort_transaction) "arbit=
ration lost, %s"
> +
> +# remote-i2c-cuse.c
> +remote_i2c_master_fuse_export(void) "FUSE session setup complete"
> +remote_i2c_master_fuse_io_read(void) "FUSE event loop: reading buf"
> +remote_i2c_master_i2cdev_init(void) "CUSE init"
> +remote_i2c_master_i2cdev_open(void) "CUSE open"
> +remote_i2c_master_i2cdev_release(void) "CUSE release"
> +remote_i2c_master_i2cdev_ioctl(int cmd) "IOCTL Start cmd: 0x%x"
> +remote_i2c_master_i2cdev_ioctl_finished(int cmd) "IOCTL Finish cmd: 0x%x"
> +remote_i2c_master_i2cdev_functional(void) "IOCTL: Query Functionality"
> +remote_i2c_master_i2cdev_address(uint32_t address) "IOCTL: Set slave add=
ress: 0x%x"
> +remote_i2c_master_i2cdev_smbus(uint8_t state) "IOCTL: SMBus machine stat=
e: 0x%x"
> +remote_i2c_master_i2cdev_send(uint32_t size) "TX start size: 0x%x"
> +remote_i2c_master_i2cdev_receive(uint32_t size) "RX start size: 0x%x"
> diff --git a/include/hw/i2c/remote-i2c-backend.h b/include/hw/i2c/remote-=
i2c-backend.h
> new file mode 100644
> index 0000000000..bbc71435db
> --- /dev/null
> +++ b/include/hw/i2c/remote-i2c-backend.h
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Remote I2C Backend (Abstract Base Class)
> + *
> + * This module defines the abstract backend interface for the Remote I2C=
 Master.
> + * It provides the QEMU Object Model (QOM) base class that strictly deco=
uples
> + * the internal QEMU I2C hardware state machine (the frontend) from
> + * host-specific transport layers.
> + *
> + * Author:
> + * Ilya Chichkov <ilya.chichkov.dev@gmail.com>
> + *
> + */
> +#ifndef HW_REMOTE_I2C_BACKEND_H
> +#define HW_REMOTE_I2C_BACKEND_H
> +
> +#include "qemu/osdep.h"
> +#include "qom/object.h"
> +
> +typedef enum i2c_bus_state {
> +    I2C_BUS_IDLE,
> +    I2C_BUS_ADDR,
> +    I2C_BUS_SEND,
> +    I2C_BUS_RECV,
> +    I2C_BUS_END,
> +    I2C_BUS_FINISHED,
> +    I2C_BUS_WAIT_STRETCH,
> +    I2C_BUS_WAIT_RELEASE,
> +} i2c_bus_state;
> +
> +typedef struct RemoteI2CMasterState RemoteI2CMasterState;
> +
> +#define TYPE_REMOTE_I2C_BACKEND "remote-i2c-backend"
> +OBJECT_DECLARE_TYPE(RemoteI2CBackend, RemoteI2CBackendClass, REMOTE_I2C_=
BACKEND)
> +
> +#define REMOTE_I2C_BACKEND_BUF_LEN      256
> +#define REMOTE_I2C_BACKEND_RDWR_BUF_LEN 260
> +
> +struct RemoteI2CBackend {
> +    Object parent_obj;
> +
> +    RemoteI2CMasterState *frontend;
> +
> +    /* Transaction State */
> +    uint8_t  transaction_buf[REMOTE_I2C_BACKEND_BUF_LEN];
> +    uint16_t transaction_index;
> +    uint16_t transaction_length;
> +
> +    bool is_recv;
> +    bool is_master_pending;
> +    bool is_transaction_failed;
> +    bool is_slave_async;
> +    bool waiting_for_async;
> +    bool addr_acked;
> +    bool data_acked;
> +    bool timed_out;
> +    uint32_t timeout_ms;
> +
> +    i2c_bus_state bus_state;
> +    long address;
> +};
> +
> +struct RemoteI2CBackendClass {
> +    ObjectClass parent_class;
> +
> +    void (*on_tx_complete)(RemoteI2CBackend *backend);
> +    void (*on_tx_error)(RemoteI2CBackend *backend, int errno_code);
> +};
> +
> +#endif /* HW_REMOTE_I2C_BACKEND_H */
> diff --git a/include/hw/i2c/remote-i2c-cuse.h b/include/hw/i2c/remote-i2c=
-cuse.h
> new file mode 100644
> index 0000000000..b0940122bf
> --- /dev/null
> +++ b/include/hw/i2c/remote-i2c-cuse.h
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Remote I2C Master
> + *
> + * This device exposes a QEMU I2C bus to the host system via a FUSE (CUS=
E)
> + * character device. It allows external programs or scripts on the host =
to
> + * interact with I2C slaves simulated inside QEMU as if they were real h=
ardware
> + * devices attached to the host.
> + *
> + * Features:
> + * - Implements the Linux I2C ioctl interface (I2C_RDWR, I2C_SMBUS).
> + * - Supports standard I2C and SMBus protocols.
> + * - Handles asynchronous I2C transactions via QEMU's Bottom Halves (BH).
> + * - Supports SMBus "Repeated Start" for atomic Write-then-Read operatio=
ns.
> + *
> + * Usage:
> + * Add the device to QEMU:
> + * "-device remote-i2c-master,i2cbus=3Di2c-bus.0,devname=3Di2c-33"
> + * This creates a character device at /dev/i2c-33 on the host.
> + * Use standard tools (i2c-tools) or C programs to access it:
> + * i2cdetect -y -l
> + * i2cget -y <bus_id> <addr> <reg>
> + *
> + * Author:
> + * Ilya Chichkov <ilya.chichkov.dev@gmail.com>
> + *
> + */
> +#ifndef HW_REMOTE_I2C_MASTER_BC_CUSE_H
> +#define HW_REMOTE_I2C_MASTER_BC_CUSE_H
> +
> +#include "qom/object_interfaces.h"
> +#include "hw/i2c/remote-i2c-backend.h"
> +
> +/* OS and Transport specifics stay HERE */
> +#define FUSE_USE_VERSION 31
> +#include <fuse3/fuse.h>
> +#include <fuse3/cuse_lowlevel.h>
> +#include <linux/i2c.h>
> +#include <linux/i2c-dev.h>
> +
> +#define TYPE_REMOTE_I2C_BACKEND_CUSE "remote-i2c-backend-cuse"
> +OBJECT_DECLARE_SIMPLE_TYPE(RemoteI2CBackendCuse, REMOTE_I2C_BACKEND_CUSE)
> +
> +typedef enum i2c_ioctl_state {
> +    I2C_IOCTL_START,
> +    I2C_IOCTL_GET,
> +    I2C_IOCTL_RECV,
> +    I2C_IOCTL_SEND,
> +    I2C_IOCTL_FINISHED,
> +} i2c_ioctl_state;
> +
> +struct remote_i2c_in_data {
> +    unsigned int last_cmd;
> +    fuse_req_t req;
> +    const struct i2c_smbus_ioctl_data *in_smbus_data;
> +    const struct i2c_rdwr_ioctl_data *in_rdwr_data;
> +    void *in_buf;
> +};
> +
> +struct RemoteI2CBackendCuse {
> +    RemoteI2CBackend parent_obj;
> +
> +    /* Config Properties */
> +    char *devname;
> +    char *fuse_opts;
> +    bool debug;
> +
> +    /* FUSE Session State */
> +    AioContext *ctx;
> +    struct fuse_session *fuse_session;
> +    struct fuse_buf fuse_buf;
> +    bool is_open;
> +
> +    /* CUSE IOCTL State Helpers */
> +    i2c_ioctl_state ioctl_state;
> +    uint32_t last_ioctl;
> +    struct remote_i2c_in_data in_data;
> +    bool smbus_restart_read;
> +
> +    /* RDWR OS-Level Support */
> +    struct i2c_msg *rdwr_msgs;
> +    uint32_t nmsgs;
> +    uint32_t msg_idx;
> +    size_t rdwr_data_offset;
> +    size_t rdwr_in_buf_size;
> +    uint8_t rdwr_out_buf[REMOTE_I2C_BACKEND_RDWR_BUF_LEN];
> +    size_t rdwr_out_len;
> +};
> +
> +/* CUSE-Specific Prototypes */
> +int remote_i2c_fuse_export(RemoteI2CBackendCuse *cuse, Error **errp);
> +
> +#endif /* HW_REMOTE_I2C_MASTER_BC_CUSE_H */
> diff --git a/include/hw/i2c/remote-i2c-master.h b/include/hw/i2c/remote-i=
2c-master.h
> new file mode 100644
> index 0000000000..61aee23b2b
> --- /dev/null
> +++ b/include/hw/i2c/remote-i2c-master.h
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Remote I2C Master
> + *
> + * This device exposes a QEMU I2C bus to the host system via a FUSE (CUS=
E)
> + * character device. It allows external programs or scripts on the host =
to
> + * interact with I2C slaves simulated inside QEMU as if they were real h=
ardware
> + * devices attached to the host.
> + *
> + * Features:
> + * - Implements the Linux I2C ioctl interface (I2C_RDWR, I2C_SMBUS).
> + * - Supports standard I2C and SMBus protocols.
> + * - Handles asynchronous I2C transactions via QEMU's Bottom Halves (BH).
> + * - Supports SMBus "Repeated Start" for atomic Write-then-Read operatio=
ns.
> + *
> + * Usage:
> + * Add the device to QEMU:
> + * "-device remote-i2c-master,i2cbus=3Di2c-bus.0,devname=3Di2c-33"
> + * This creates a character device at /dev/i2c-33 on the host.
> + * Use standard tools (i2c-tools) or C programs to access it:
> + * i2cdetect -y -l
> + * i2cget -y <bus_id> <addr> <reg>
> + *
> + * Author:
> + * Ilya Chichkov <ilya.chichkov.dev@gmail.com>
> + *
> + */
> +#ifndef HW_REMOTE_I2C_MASTER_H
> +#define HW_REMOTE_I2C_MASTER_H
> +
> +#include "hw/core/sysbus.h"
> +#include <linux/i2c.h>
> +#include <linux/i2c-dev.h>
> +#include "hw/i2c/remote-i2c-backend.h"
> +
> +#define TYPE_REMOTE_I2C_MASTER "remote-i2c-master"
> +
> +#define REMOTE_I2C_MASTER(obj) \
> +    OBJECT_CHECK(RemoteI2CMasterState, (obj), TYPE_REMOTE_I2C_MASTER)
> +
> +typedef enum {
> +    REMOTE_I2C_CMD_START_TX,
> +    REMOTE_I2C_CMD_NEXT_MSG,
> +    REMOTE_I2C_CMD_ABORT,
> +    REMOTE_I2C_CMD_RESET
> +} RemoteI2CCommand;
> +
> +typedef struct RemoteI2CMasterState {
> +    DeviceState parent_obj;
> +
> +    I2CBus *bus;
> +    char *name;
> +
> +    /* QOM Link to the abstract Backend */
> +    RemoteI2CBackend *backend;
> +
> +    QEMUTimer *timer;
> +    QEMUTimer *timer_start_transmit;
> +    QEMUTimer *timer_step;
> +    QEMUTimer *slow_master_timer;
> +    QEMUBH *bh;
> +    MemReentrancyGuard bh_guard;
> +
> +    uint32_t timeout_ms;
> +    uint32_t default_stretch_delay_ms;
> +    bool slow_delay_enable;
> +    uint32_t slow_delay_value_ms;
> +    bool raise_arbitrage_lost;
> +    bool delay_completed;
> +
> +} RemoteI2CMasterState;
> +
> +void remote_i2c_fsm_dispatch(RemoteI2CMasterState *s, RemoteI2CCommand c=
md);
> +void remote_i2c_fsm_timer_start_transmit_cb(void *opaque);
> +void remote_i2c_fsm_bh(void *opaque);
> +
> +#endif /* HW_REMOTE_I2C_MASTER_H */
> diff --git a/qapi/qom.json b/qapi/qom.json
> index dd45ac1087..c82af930cc 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1258,6 +1258,7 @@
>      'tls-creds-psk',
>      'tls-creds-x509',
>      'tls-cipher-suites',
> +    'remote-i2c-backend-cuse',
>      { 'name': 'x-remote-object', 'features': [ 'unstable' ] },
>      { 'name': 'x-vfio-user-server', 'features': [ 'unstable' ] }
>    ] }
> @@ -1334,6 +1335,7 @@
>        'tls-creds-psk':              'TlsCredsPskProperties',
>        'tls-creds-x509':             'TlsCredsX509Properties',
>        'tls-cipher-suites':          'TlsCredsProperties',
> +      'remote-i2c-backend-cuse':    'RemoteI2CBackendCuseProperties',

Needs to be

         'remote-i2c-backend-cuse': { 'type': 'RemoteI2CBackendCuseProperti=
es',
                                      'if': 'CONFIG_LINUX' },

because the type is 'if': 'CONFIG_LINUX'.

Please make the enum value conditional, too.

>        'x-remote-object':            'RemoteObjectProperties',
>        'x-vfio-user-server':         'VfioUserServerProperties'
>    } }
> @@ -1377,3 +1379,30 @@
>  ##
>  { 'command': 'object-del', 'data': {'id': 'str'},
>    'allow-preconfig': true }
> +
> +##
> +# @RemoteI2CBackendCuseProperties:
> +#
> +# Properties for the CUSE remote I2C backend.

Would a reference to docs/system/devices/remote-i2c-master.rst make
sense?

> +#
> +# @devname: The name of the character device node to create under /dev
> +#     (e.g., 'i2c-33' creates /dev/i2c-33).  The node is accessible
> +#     via the standard Linux I2C device interface and usable directly
> +#     with i2c-tools and the Linux i2c-dev API.
> +#
> +# @fuse-opts: Space-separated list of options passed verbatim to the
> +#     FUSE/CUSE session at mount time (e.g., '-d' or '--debug
> +#     --allow-other').  See mount.fuse(8) for the full list of
> +#     supported options.

This requires parsing the string value, which is something we try hard
to avoid in the QAPI schema.  Can you make it ['str']?

> +#
> +# @debug: Convenience shorthand for passing '--debug' in @fuse-opts.
> +#     Enables verbose FUSE request/reply tracing on stderr.  Equivalent
> +#     to adding '--debug' to @fuse-opts explicitly.

Feels redundant with @fuse-opts.

> +#
> +# Since: 11.2
> +##
> +{ 'struct': 'RemoteI2CBackendCuseProperties',
> +  'data': { 'devname': 'str',
> +            '*fuse-opts': 'str',
> +            '*debug': 'bool' },
> +  'if': 'CONFIG_LINUX'}

[...]


