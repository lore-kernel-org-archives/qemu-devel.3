Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD20C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 14:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1razSb-0005MS-V2; Fri, 16 Feb 2024 09:45:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1razSa-0005LV-HQ
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:45:04 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1razSX-00057N-Tr
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:45:04 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a3122b70439so249208066b.3
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 06:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708094700; x=1708699500; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=izZ7GFiRNPUU3bhNZ21j7VeckCA00pqcpQqtEJmOCOU=;
 b=LWhxMDeXuSpugP699Ze9/Zl6oOAp1ozOwC878NDc7phl/3YvUxsNO9xbB5m443iN03
 pk4eIYjwuqzXz55WBSbkU+4/b8gSTYom4NS2/1MZIokA4Dg+SX+1GGVMa9PN4jZBVO0D
 tejO+/m92n9dtxZghniSrJJlNV4x4TLgRs7mha9dgxP5myIPb2Sa5s+L+W7v64yb+0G0
 w1+iyYajGZBgOSRofoEgQNaEReNV0ERrP6qpSrWWr2ggVfPv5qa52EOvBCkSwMO1BOq9
 +bHKhsDFp2o1ZO9au7DAt0uI2SVedQ6+xPz/uCdNiNOEGqKPu03PM/YPzhKu5ovHmhfb
 OJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708094700; x=1708699500;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=izZ7GFiRNPUU3bhNZ21j7VeckCA00pqcpQqtEJmOCOU=;
 b=P36Ko0UqNcnuRHRdxLrFpvfDp3xcW/vQHKHz4JzrmpDN0X0ZKuyRaalDzLWgLACSwi
 XEseM99OwTSCOK20Wv3Sl2LZn93+QMMvKa50KkJQh+klpiIa4dHvUZbw9Df8p++NOZ0k
 Fg3jShdxeQ5BrJ9Pc6CZ1kggF+M38vcDmi8e/2vAECJcJ2NNqeQ8bk8jtQ9SCMhy9kSu
 v0Ej8wLJV2spjY+D82XKuZW4j57HEI0+1dToza0L+EYvtQV11qeE0WURIKc87Jv+4hmg
 3dqWq/plzwwaRlm1wZoug13C/aLlGKvIJFSsCIGnqQKRg38CPjcpHGaoK2fbHw16Eiw4
 Q4/w==
X-Gm-Message-State: AOJu0YxEYgNiXGmKCxOPVWn21HFXqHj/pMXd/zdFkQ4Un1IKrO/lwKJT
 I+6F2Bj/bGvwZhYTd6m7CJySgKbJ35YCWaJi1O/YeGopBXFKdYz/owG258FukQmiYNlTyc2GhiK
 M
X-Google-Smtp-Source: AGHT+IGTTB7FUbnPcxEzCXrOvkB6bHLFk4PYXCWySL0/rdc/UxmaF5ZylBXlt1RG/jLejil3hYCWDQ==
X-Received: by 2002:a17:906:5f89:b0:a3d:5e44:83aa with SMTP id
 a9-20020a1709065f8900b00a3d5e4483aamr3683435eju.20.1708094699909; 
 Fri, 16 Feb 2024 06:44:59 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 g16-20020a170906199000b00a3d3205c6f9sm1619889ejd.129.2024.02.16.06.44.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 06:44:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Gustavo Romero <gustavo.romero@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anton Kochkov <anton.kochkov@proton.me>, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/6] Add ivshmem-flat device
Date: Fri, 16 Feb 2024 15:44:50 +0100
Message-ID: <20240216144456.34992-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This is a respin of Gustavo's v1 [3].

Since v1:
- Respin splitting controversial code in another patch
- For minor changes see notes in patch #1

--

This patchset introduces a new device, ivshmem-flat, which is similar to the
current ivshmem device but does not require a PCI bus. It implements the ivshmem
status and control registers as MMRs and the shared memory as a directly
accessible memory region in the VM memory layout. It's meant to be used on
machines like those with Cortex-M MCUs, which usually lack a PCI bus, e.g.,
lm3s6965evb and mps2-an385. Additionally, it has the benefit of requiring a tiny
'device driver,' which is helpful on some RTOSes, like Zephyr, that run on
memory-constrained resource targets.

The patchset includes a QTest for the ivshmem-flat device, however, it's also
possible to experiment with it in two ways:

(a) using two Cortex-M VMs running Zephyr; or
(b) using one aarch64 VM running Linux with the ivshmem PCI device and another
    arm (Cortex-M) VM running Zephyr with the new ivshmem-flat device.

Please note that for running the ivshmem-flat QTests the following patch, which
is not committed to the tree yet, must be applied:

https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg03176.html

--

To experiment with (a), clone this Zephyr repo [0], set the Zephyr build
environment [1], and follow the instructions in the 'ivshmem' sample main.c [2].

[0] https://github.com/gromero/zephyr/tree/ivshmem
[1] https://docs.zephyrproject.org/latest/develop/getting_started/index.html
[2] https://github.com/gromero/zephyr/commit/73fbd481e352b25ae5483ba5048a2182b90b7f00#diff-16fa1f481a49b995d0d1a62da37b9f33033f5ee477035e73465e7208521ddbe0R9-R70
[3] https://lore.kernel.org/qemu-devel/20231127052024.435743-1-gustavo.romero@linaro.org/

To experiment with (b):

$ git clone -b uio_ivshmem --single-branch https://github.com/gromero/linux.git
$ cd linux
$ wget https://people.linaro.org/~gustavo.romero/ivshmem/arm64_uio_ivshmem.config -O .config

If in an x86_64 machine, cross compile the kernel, for instance:

$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j 36

Install image in some directory, let's say, in ~/linux:

$ mkdir ~/linux
$ export INSTALL_PATH=~/linux
$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j 36 install

or, if you prefer, download the compiled image from:

$ wget https://people.linaro.org/~gustavo.romero/ivshmem/vmlinuz-6.6.0-rc1-g28f3f88ee261

... and then the rootfs:

$ wget https://people.linaro.org/~gustavo.romero/ivshmem/rootfs.qcow2

Now, build QEMU with this patchset applied:

$ mkdir build && cd build
$ ../configure --target-list=arm-softmmu,aarch64-softmmu
$ make -j 36

Start the ivshmem server:

$ contrib/ivshmem-server/ivshmem-server -F

Start the aarch64 VM + Linux + ivshmem PCI device:

$ ./qemu-system-aarch64 -kernel ~/linux/vmlinuz-6.6.0-rc1-g28f3f88ee261 -append "root=/dev/vda initrd=/bin/bash console=ttyAMA0,115200" -drive file=~/linux/rootfs.qcow2,media=disk,if=virtio -machine virt-6.2 -nographic -accel tcg -cpu cortex-a57 -m 8192 -netdev bridge,id=hostnet0,br=virbr0,helper=/usr/lib/qemu/qemu-bridge-helper -device pcie-root-port,port=8,chassis=1,id=pci.1,bus=pcie.0,multifunction=on,addr=0x1 -device virtio-net-pci,netdev=hostnet0,id=net0,mac=52:54:00:d9:d1:12,bus=pci.1,addr=0x0 -device ivshmem-doorbell,vectors=2,chardev=ivshmem -chardev socket,path=/tmp/ivshmem_socket,id=ivshmem

Log into the VM with user/pass: root/abc123

should show:

[    2.656367] uio_ivshmem 0000:00:02.0: ivshmem-mmr at 0x0000000010203000, size 0x0000000000001000
[    2.656931] uio_ivshmem 0000:00:02.0: ivshmem-shmem at 0x0000008000000000, size 0x0000000000400000
[    2.662554] uio_ivshmem 0000:00:02.0: module successfully loaded

In another console, clone and build Zephyr image from 'uio_ivhsmem' branch:

$ git clone -b uio_ivshmem --single-branch https://github.com/gromero/zephyr
$ west -v --verbose build -p always -b qemu_cortex_m3 ./samples/uio_ivshmem/

... and then start the arm VM + Zephyr image + ivshmem-flat device:

$ ./qemu-system-arm -machine lm3s6965evb -nographic -net none -chardev socket,path=/tmp/ivshmem_socket,id=ivshmem_flat -device ivshmem-flat,chardev=ivshmem_flat,x-irq-qompath='/machine/unattached/device[1]/nvic/unnamed-gpio-in[0]',x-bus-qompath='/sysbus' -kernel ~/zephyrproject/zephyr/build/qemu_cortex_m3/uio_ivshmem/zephyr/zephyr.elf

You should see something like:

*** Booting Zephyr OS build zephyr-v3.3.0-8350-gfb003e583600 ***
*** Board: qemu_cortex_m3
*** Installing direct IRQ handler for external IRQ0 (Exception #16)...
*** Enabling IRQ0 in the NVIC logic...
*** Received IVSHMEM PEER ID: 7
*** Waiting notification from peers to start...

Now, from the Linux terminal, notify the arm VM (use the "IVSHMEM PEER ID"
reported by Zephyr as the third arg, in this example: 7):

MMRs mapped at 0xffff8fb28000 in VMA.
shmem mapped at 0xffff8f728000 in VMA.
mmr0: 0 0
mmr1: 0 0
mmr2: 6 6
mmr3: 0 0
Data ok. 4194304 byte(s) checked.

The arm VM should report something like:

*** Got interrupt at vector 0!
*** Writting constant 0xb5b5b5b5 to shmem... done!
*** Notifying back peer ID 6 at vector 0...

Cheers,
Gustavo

Gustavo Romero (6):
  hw/misc/ivshmem: Add ivshmem-flat device
  hw/misc/ivshmem-flat: Allow device to wire itself on sysbus
  hw/arm: Allow some machines to use the ivshmem-flat device
  hw/misc/ivshmem: Rename ivshmem to ivshmem-pci
  tests/qtest: Reorganize common code in ivshmem-test
  tests/qtest: Add ivshmem-flat test

 docs/system/devices/ivshmem-flat.rst |  89 +++++
 include/hw/misc/ivshmem-flat.h       |  94 +++++
 tests/qtest/ivshmem-utils.h          |  56 +++
 hw/arm/mps2.c                        |   3 +
 hw/arm/stellaris.c                   |   3 +
 hw/arm/virt.c                        |   2 +
 hw/core/sysbus-fdt.c                 |   2 +
 hw/misc/ivshmem-flat.c               | 521 +++++++++++++++++++++++++++
 hw/misc/{ivshmem.c => ivshmem-pci.c} |   0
 tests/qtest/ivshmem-flat-test.c      | 320 ++++++++++++++++
 tests/qtest/ivshmem-test.c           | 113 +-----
 tests/qtest/ivshmem-utils.c          | 155 ++++++++
 hw/misc/Kconfig                      |   5 +
 hw/misc/meson.build                  |   4 +-
 hw/misc/trace-events                 |  17 +
 tests/qtest/meson.build              |   8 +-
 16 files changed, 1282 insertions(+), 110 deletions(-)
 create mode 100644 docs/system/devices/ivshmem-flat.rst
 create mode 100644 include/hw/misc/ivshmem-flat.h
 create mode 100644 tests/qtest/ivshmem-utils.h
 create mode 100644 hw/misc/ivshmem-flat.c
 rename hw/misc/{ivshmem.c => ivshmem-pci.c} (100%)
 create mode 100644 tests/qtest/ivshmem-flat-test.c
 create mode 100644 tests/qtest/ivshmem-utils.c

-- 
2.41.0


