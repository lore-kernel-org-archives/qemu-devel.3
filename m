Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A708BFD45F8
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 22:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvN3P-00063d-UP; Wed, 25 Feb 2026 17:08:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=509822c20=graf@amazon.de>)
 id 1vvN3N-0005zF-3C; Wed, 25 Feb 2026 17:08:21 -0500
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([50.112.246.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=509822c20=graf@amazon.de>)
 id 1vvN3K-0000tG-8O; Wed, 25 Feb 2026 17:08:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1772057298; x=1803593298;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=e3PA4HcdAvkkUaFf4SGNhHq8MXag/7TgL6yWct1mUYI=;
 b=UbG9ShY3jGjEd/Zw5jlrtFUuiL9yt8k8o0Z2CLmlCyHVBRR3kPx74aka
 rKdXn+/6NRnboJYhen8GTZtXSub8bkJB7AHbcpDfE7ynadbnj8EhzI3Sj
 eo1mDHT4BolbTb6Pd6CIWbRLvucPh+C00x+V32n3kiNIUNXIgvmUQdXW6
 oJrwajynEkWlsI5w/lyikmviZMHZky4cpeykOTfN/WUQDuFY9crm9huF9
 FYwBBT1p44Y788nkpx0SE5cn22Vpgw7Jke+4T8J//H8HYuqGYxmn/Q6vM
 5S2idxmJc8bSdaGyDODlB3BT1u3fluLN1yfYB9EOU3ky5dPz+YFDbvb2n w==;
X-CSE-ConnectionGUID: befz75mZQeydr/UxULa9yw==
X-CSE-MsgGUID: nGl/PoSaRT2XcJhtPzbhhA==
X-IronPort-AV: E=Sophos;i="6.21,311,1763424000"; d="scan'208";a="13629752"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 22:08:12 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:25543]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.86:2525]
 with esmtp (Farcaster)
 id d0324103-62a5-4aed-b684-9169da555e23; Wed, 25 Feb 2026 22:08:12 +0000 (UTC)
X-Farcaster-Flow-ID: d0324103-62a5-4aed-b684-9169da555e23
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 25 Feb 2026 22:08:11 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 25 Feb 2026 22:08:09 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, "Thomas
 Huth" <thuth@redhat.com>, <alex.bennee@linaro.org>, <philmd@linaro.org>,
 <berrange@redhat.com>, <marcandre.lureau@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, <mst@redhat.com>, Dorjoy Chowdhury
 <dorjoychy111@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Tyler Fanelli <tfanelli@redhat.com>,
 <mknaust@amazon.com>, <nh-open-source@amazon.com>
Subject: [PATCH v3 00/11] Native Nitro Enclaves support
Date: Wed, 25 Feb 2026 22:07:54 +0000
Message-ID: <20260225220807.33092-1-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=50.112.246.219;
 envelope-from=prvs=509822c20=graf@amazon.de;
 helo=pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

We had emulated Nitro Enclaves support in QEMU since 2024, but to launch
a native Nitro Enclave, you could only use the AWS nitro-cli tooling.

To simplify tooling and allow users to leverage the most convenient swiss
army knife of virtualization known to mankind (QEMU!), add native support
to launch a Nitro Enclave from within QEMU.

A Nitro Enclave is a Confidential Computing Virtual Machine spawned by
the Nitro Hypervisor which has a very basic machine model, with
virtio-vsock as the only real I/O between parent and enclave. This means
the amount of interactions between QEMU and the VM are limited, but for
debugging, experimentation and non-conventional use cases, it can be handy
to spawn a Nitro Enclave directly in a more fully featured virtualization
stack.

Example invocation:

  $ qemu-system-x86_64 -nographic -accel nitro,debug-mode=on -M nitro -kernel test.eif -smp 2
  QEMU 10.2.50 monitor - type 'help' for more information
  (qemu) [    0.000000] Linux version 4.14.256-209.484.amzn2.x86_64 (mockbuild@ip-10-0-50-84) (gcc version 7.3.1 20180712 (Red Hat 7.3.1-13) (GCC)) #1 SMP Tue Jan 11 21:47:36 UTC 2022
  [    0.000000] Command line: reboot=k panic=30 pci=off nomodules console=ttyS0 i8042.noaux i8042.nomux i8042.nopnp i8042.dumbkbd random.trust_cpu=on virtio_mmio.device=4K@0xd0000000:5 virtio_mmio.device=4K@0xd0001000:6
  [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
  [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
  [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'

This patch set supports x86_64 as well as aarch64 Nitro Enclaves.
Virtio-vsock communication with the Enclave is handled directly through the
parent's virtio-vsock device.

Alex

v1 -> v2:

  - Add new nitro vsock bus (pbonzini@)
  - Convert vsock devices to the new bus (pbonzini@)
  - Replace enclave-cid qom property with bus logic (pbonzini@)
  - Change qom property to bridge and document (pbonzini@)
  - Use post_setup() instead of vcpu0 start (pbonzini@)
  - Replace CPU loop with dummy loop (pbonzini@)
  - Support -nodefaults (mst@)
  - Remove QEMU-level CPU creation, it's not really needed

v2 -> v3:

  - Mark as non-resettable (pbonzini@, philmd@)

Alexander Graf (11):
  scripts/update-linux-headers: Add Nitro Enclaves header
  linux-headers: Add nitro_enclaves.h
  hw/nitro: Add Nitro Vsock Bus
  accel: Add Nitro Enclaves accelerator
  hw/nitro/nitro-serial-vsock: Nitro Enclaves vsock console
  hw/nitro: Introduce Nitro Enclave Heartbeat device
  target/arm/cpu64: Allow -host for nitro
  hw/nitro: Add nitro machine
  hw/core/eif: Move definitions to header
  hw/nitro: Enable direct kernel boot
  docs: Add Nitro Enclaves documentation

 MAINTAINERS                                   |  13 +
 accel/Kconfig                                 |   3 +
 accel/meson.build                             |   1 +
 accel/nitro/meson.build                       |   3 +
 accel/nitro/nitro-accel.c                     | 284 ++++++++++++++
 accel/nitro/trace-events                      |   6 +
 accel/nitro/trace.h                           |   2 +
 accel/stubs/meson.build                       |   1 +
 accel/stubs/nitro-stub.c                      |  11 +
 docs/system/confidential-guest-support.rst    |   1 +
 docs/system/index.rst                         |   1 +
 docs/system/nitro.rst                         | 133 +++++++
 hw/Kconfig                                    |   1 +
 hw/core/eif.c                                 |  38 --
 hw/core/eif.h                                 |  41 ++
 hw/meson.build                                |   1 +
 hw/nitro/Kconfig                              |  18 +
 hw/nitro/heartbeat.c                          | 115 ++++++
 hw/nitro/machine.c                            | 277 ++++++++++++++
 hw/nitro/meson.build                          |   4 +
 hw/nitro/nitro-vsock-bus.c                    |  98 +++++
 hw/nitro/serial-vsock.c                       | 123 ++++++
 hw/nitro/trace-events                         |   8 +
 hw/nitro/trace.h                              |   4 +
 include/hw/nitro/heartbeat.h                  |  24 ++
 include/hw/nitro/machine.h                    |  20 +
 include/hw/nitro/nitro-vsock-bus.h            |  71 ++++
 include/hw/nitro/serial-vsock.h               |  24 ++
 .../standard-headers/linux/nitro_enclaves.h   | 359 ++++++++++++++++++
 include/system/hw_accel.h                     |   1 +
 include/system/nitro-accel.h                  |  25 ++
 meson.build                                   |  12 +
 meson_options.txt                             |   2 +
 qemu-options.hx                               |   8 +-
 scripts/meson-buildoptions.sh                 |   3 +
 scripts/update-linux-headers.sh               |   1 +
 target/arm/cpu64.c                            |   8 +
 37 files changed, 1703 insertions(+), 42 deletions(-)
 create mode 100644 accel/nitro/meson.build
 create mode 100644 accel/nitro/nitro-accel.c
 create mode 100644 accel/nitro/trace-events
 create mode 100644 accel/nitro/trace.h
 create mode 100644 accel/stubs/nitro-stub.c
 create mode 100644 docs/system/nitro.rst
 create mode 100644 hw/nitro/Kconfig
 create mode 100644 hw/nitro/heartbeat.c
 create mode 100644 hw/nitro/machine.c
 create mode 100644 hw/nitro/meson.build
 create mode 100644 hw/nitro/nitro-vsock-bus.c
 create mode 100644 hw/nitro/serial-vsock.c
 create mode 100644 hw/nitro/trace-events
 create mode 100644 hw/nitro/trace.h
 create mode 100644 include/hw/nitro/heartbeat.h
 create mode 100644 include/hw/nitro/machine.h
 create mode 100644 include/hw/nitro/nitro-vsock-bus.h
 create mode 100644 include/hw/nitro/serial-vsock.h
 create mode 100644 include/standard-headers/linux/nitro_enclaves.h
 create mode 100644 include/system/nitro-accel.h

-- 
2.47.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


