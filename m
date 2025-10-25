Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45236CCF9E3
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 16:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vChXa-0002AF-IF; Sat, 25 Oct 2025 12:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <loki+qemu@loki.codes>)
 id 1vChXX-00029h-0x; Sat, 25 Oct 2025 12:54:51 -0400
Received: from k3s-node1.loki.codes ([152.53.103.207])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <loki+qemu@loki.codes>)
 id 1vChXU-0000Qy-NK; Sat, 25 Oct 2025 12:54:50 -0400
Received: from k3s-node1.loki.codes
 (10-0-0-142.mail-lokimail-dovecot.lokimail.svc.cluster.local
 [145.224.74.101])
 by k3s-node1.loki.codes (Postfix) with ESMTPA id B96141900292C;
 Sat, 25 Oct 2025 16:54:37 +0000 (UTC)
Received: from ripper.localnet ([145.224.74.101])
 by k3s-node1.loki.codes with ESMTPSA id Kgi2Js0A/Wi3LgMAtdl1+g
 (envelope-from <loki+qemu@loki.codes>); Sat, 25 Oct 2025 16:54:37 +0000
From: Thomas Berger <loki+qemu@loki.codes>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [RFC] Generic platform device support via vfio-user
Date: Sat, 25 Oct 2025 18:54:37 +0200
Message-ID: <3821937.mvXUDI8C0e@ripper>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13785451.O9o76ZdvQC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Received-SPF: pass client-ip=152.53.103.207; envelope-from=loki+qemu@loki.codes;
 helo=k3s-node1.loki.codes
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

--nextPart13785451.O9o76ZdvQC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Thomas Berger <loki+qemu@loki.codes>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [RFC] Generic platform device support via vfio-user
Date: Sat, 25 Oct 2025 18:54:37 +0200
Message-ID: <3821937.mvXUDI8C0e@ripper>
MIME-Version: 1.0

Hi all,

I want to propose generic platform device support for embedded systems
using vfio-user as the backend interface.

Problem
-------

QEMU's device discovery mechanisms (Device Tree, ACPI, PCI enumeration)
don't work for bare-metal embedded systems. Instead, board configurations
are hardcoded: memory regions, IRQ assignments, and device wiring are all
in board realize() code.

The ARMv7-M market alone has thousands of microcontroller variants (STM32,
Nordic, NXP Kinetis, Infineon, TI, Microchip, etc.), each with different
peripheral addresses and IRQ mappings. Supporting all these variants with
individual board files doesn't scale.

Even providing generic boards with external peripheral definitions [1] only
solves part of the problem:

Vendor peripherals (RCC, power management, DMA controllers, custom timers,
etc.) vary heavily between vendors and product lines. Maintaining hundreds
of peripheral implementations in QEMU is not sustainable.

Beyond functional emulation, firmware testing requires realistic timing,
blocking I/O, and side-effects across MCU variants. QEMU has the
infrastructure (TCG plugins, GDB integration, vfio) but lacks device
coverage.


Proposed Solution
-----------------

I propose leveraging the existing vfio-user infrastructure to delegate
vendor-specific peripheral implementation to external projects, while
keeping board topology management in QEMU.

A vfio-user-platform device would provide standard peripherals (UART, I2C,
etc.), but there's a challenge: The vfio-user protocol (based on kernel
vfio) has no mechanism to communicate required MMIO addresses and IRQ
numbers. Kernel vfio-platform devices inherit these from Device Tree,
which doesn't exist in bare-metal embedded systems.


Why not extend the vfio-user protocol?
---------------------------------------

While protocol extension is possible, it would cause QEMU's protocol to
diverge in a critical area (memory region definition) for a narrow use
case (embedded platforms without DT). The interaction between board and
device would still lack a clean mechanism.


Board-integrated vfio-user-platform device
-------------------------------------------

An alternative approach would be a vfio-user-platform device that is NOT
user-instantiable via `-device`. Instead, board code creates and
configures it during initialization.

The device connects to an external backend via Unix socket (board
property), handles vfio-user protocol negotiation, and exposes MMIO
regions and IRQs for the board to wire into the system.


Control region for device metadata
-----------------------------------

To enable board-device communication without protocol extension, the
vfio-user backend could provide a control region (Region 0) containing
device metadata: MMIO addresses, IRQ numbers, and capabilities. The board
reads this during initialization to properly wire the device into the
system.


System-control devices
-----------------------

Some peripherals have system-wide side-effects (e.g., RCC clock trees) and
may need to modify QEMU internals like clock frequencies used by other
peripherals. This would require special handling beyond standard MMIO
forwarding.


Alternatives considered
-----------------------

Instead of using device-provided memory region addresses and IRQs, the
board could be configured with a user-provided configuration to map those
devices. However, the most common use cases for such a vfio-platform
device are:

- Providing a single device not implemented in QEMU
- Providing the whole peripheral stack

In both cases, the user would need to create a configuration file either
for a single MMIO region, or containing multiple regions with gaps and
offsets for a singular backend device.


Questions
---------

What are your thoughts on this approach?

If this would be an acceptable concept, I am willing to write and provide
a PoC implementation for further discussion.

As I am new to the QEMU code base, any guidance, hints, or known pitfalls
in this area I should know about?

Thanks in advance,
Thomas

---
[1] CMSIS SVD based peripheral definitions in GNU ARM Eclipse QEMU:
    https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg03544.html

--nextPart13785451.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEhVKKcozYuaZTrFeMW+fwwL6mPFkFAmj9AM0ACgkQW+fwwL6m
PFmfPQf+P5/gIToF8UdoBK1B1hox6o8U/88APJJkdUNE9UBKsor01y7L+0B7bmS/
XqYoyzRZUcWlFC5kX4JvaMilhzwOBtETBjCM2rYg3lROuMcRKeAa0a7kM0PctSN8
AY1mX0EuR5i2FzxvbUvkfKB9xcbDkjLXQtEXkOcQNGtTobKHGqLSlAwq3oyxUoo5
k2uIFoBCYbOmC3issdnhwBhV5ZvKN7ivXhCXORXSGBxxwbuVE1o2qxPt3J1XCXb/
ssmEobeQTa5NMvb3RImOcIVI978GZ2v76dAWxYo478OZxs/3ErGg4DJzGkELZKvr
2c3iZVYBMymjamS8XAjQ7cQDva5H9g==
=Ugk8
-----END PGP SIGNATURE-----

--nextPart13785451.O9o76ZdvQC--




