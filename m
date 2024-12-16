Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D8CE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 14:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNBw3-0003rD-W9; Mon, 16 Dec 2024 09:19:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tNBw2-0003pO-LC
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:18:58 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tNBvz-0000BK-Hk
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:18:58 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-725dac69699so3531126b3a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 06:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734358733; x=1734963533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QVghj1E6oNNl+BGap6Q2LBSRDQRhVvPYYRRGBZw0K/Y=;
 b=a/jBFmO9H+E9qX3Xjj2nqzwfNfTtUq052M3hvAtFeN4sToz8/HhBuNdd/tr1Jg4tbd
 hSflvJEjoJR+iF1jHi+NjlrFoV8mTPdy4IYVUyjwxeZiuIpew7wem7OnBeUlFomXo750
 wiy6coy2N5XtkWkW5AsMCNNeqUH8kwfwgK5VILOiC8tahayTqWaJqbHRZfHmTy7M31u8
 pUFIb2yL49j4cKHxPydchQqEM6JUwNR2ejha5Tth2g5HlOcBuH+TTvS9V3DAsT/f5gT/
 poE+1h4jXv12RDYZiPaBEwWv1Ren+Xjg46QjRmN0eEtEkcfJhDGts0RNt+cIYdUE69l5
 VGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734358733; x=1734963533;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QVghj1E6oNNl+BGap6Q2LBSRDQRhVvPYYRRGBZw0K/Y=;
 b=RRAZTErBpsa+Onc3ReZj3o7Fvf9aF6wJCAfnlgxqJh3crVBeQkOd+NrNQyZGCUSSm4
 7XIdp/jKkNShw0rOAXhLUKRbT1hvifEC/wh7R42dnTcXoWbvr9Z0XTXEC3pO+o4A3wDv
 N3Aan2j0ahjtDEsEU5x5Hw0Zu72BnODwaJVxsYzhHLaPTtmmNqlVLPTyHyEsjOP5OzFI
 M63ByaQW4aaZLiPE/FkExWbRcniAPbrclCWHs6MehqZWVcHcRq65ZtsDqkZNDLngb4AH
 ztrKJ+GpqJyM5Z125lumNmL81mkAu/s2KtPVhwGmpOfcKQ6hFJcMDd3sdLe+SiK5ykp2
 vk/Q==
X-Gm-Message-State: AOJu0Yy1l3kn9QCWVaWLNvJIczZRn+G/NwtABvriNM6S/M9lLPHIzG+t
 vNk4j7/gYdsvogfK1Adzl57ayfClO1Y2p4UxN0AKZg7oOnmn+Dyw8LTKu8GVJs8rimc9cTUud1r
 M
X-Gm-Gg: ASbGncuvD5+6xXwBy3IM2NYIn/IRNTU3ZcqMoaZnZGgo1UGOkNO0yAAdRd2NS+oL2gp
 mL0NjeYeDwArXLVqmOq1qAMVQkQguyjG1JjD3wwB/IsFK9auOm2l50wEB5drNEunDU/9RUBluOT
 5LVKNFPTMy5jgDfohB/OjRG+stjtIPWCZym19ATFsv3KfKDWKj6UhIC6i6K17LLsTfrQsMun7FE
 gMDueQSNHle9nX2NVkkpDmfl+slh4qhcyTzdgxIHn3nxqI/FOvdjoAohGHJjLE=
X-Google-Smtp-Source: AGHT+IEheAo8gPZ7Kbx+wgXv0DvCKZizUihGG8w/7SU1xHvC37VPQSajuHjnieRGne6UoL7owwbvyQ==
X-Received: by 2002:aa7:8b4e:0:b0:729:c7b:9385 with SMTP id
 d2e1a72fcca58-7290c7b9577mr15143798b3a.6.1734358733254; 
 Mon, 16 Dec 2024 06:18:53 -0800 (PST)
Received: from gromero0.. ([177.189.100.90]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918bad8acsm4948815b3a.146.2024.12.16.06.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 06:18:52 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, philmd@linaro.org,
 alex.bennee@linaro.org, thuth@redhat.com, armbru@redhat.com
Cc: gustavo.romero@linaro.org
Subject: [RESEND][PATCH v3 0/7] Add ivshmem-flat device
Date: Mon, 16 Dec 2024 14:18:11 +0000
Message-Id: <20241216141818.111255-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is a resend of the series:

https://lore.kernel.org/qemu-devel/20240222222218.2261956-1-gustavo.romero@linaro.org/

rebased on the current master. The series was sent about 9 months ago and
remains relevant. Besides addressing the longstanding issue:

https://gitlab.com/qemu-project/qemu/-/issues/1134

it has generated interest in the community at least twice since its last
version, from different contexts:

https://lists.nongnu.org/archive/html/qemu-discuss/2024-05/msg00003.html
https://lists.nongnu.org/archive/html/qemu-devel/2024-09/msg00374.html

This suggests the series is being used out-of-tree in various contexts, such
as experiments with heterogeneous architectures.

But due to the fact it relies on sysbus, which is marked for future removal,
some maintainers objected to accepting the patchset, causing it to be held in
the ML. However, given the ongoing community interest and since currently there
isn't a better way on QEMU than using sysbus for the wiring needs of this
device (e.g. to wire the device to a CPU IRQ input line), I'd kindly like to ask
maintainers to reconsider its acceptance.

I've kept the sysbus wiring part self-contained in patch:

"hw/misc/ivshmem-flat: Allow device to wire itself on sysbus"

and, as I said in the QEMU/KVM Developers Conference call last week I can commit
to updating the API when the time comes to deprecate the sysbus API. 

In essence, this patchset introduces a new device, named ivshmem-flat, which is
similar to the current ivshmem device but does not require a PCI bus.

It implements the ivshmem status and control registers as MMRs and the shared
memory as a directly accessible memory region in the VM memory layout. It's
meant to be used on machines like those with Cortex-M MCUs, which usually lack
a PCI bus, e.g., lm3s6965evb and mps2-an385. Additionally, it has the benefit of
requiring a tiny 'device driver,' which is helpful on some RTOSes, like Zephyr,
that run on memory-constrained resource targets.

The patchset includes a QTest for the ivshmem-flat device, which can be run
with:

$ make -C ./build check-qtest-arm -j 32

provided QEMU was built with support for target "arm-softmmu":

$ ../configure --target-list=arm-softmmu [...]

Nonetheless, it's also possible to experiment with it in two more interesting
ways:

(a) using two Cortex-M VMs running Zephyr; or
(b) using one aarch64 VM running Linux with the ivshmem PCI device and another
    arm (Cortex-M) VM running Zephyr with the new ivshmem-flat device.

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

Now, from the Linux terminal, notify the arm VM from the aarch64 VM
(use the "IVSHMEM PEER ID" reported by Zephyr as the third argument, in this example: 7):

$ ./uio_ivshmem_test /dev/uio0 7

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

--

v2:
- Correct code style
- Correct trace event format strings
- Include minimum headers in ivshmem-flat.h
- Allow ivshmem_flat_recv_msg() take NULL
- Factored ivshmem_flat_connect_server() out
- Split sysbus-auto-wire controversial code in different patch
- Document QDev interface

v3:
- Addressed all comments from Thomas Huth about qtest:
  1) Use of g_usleep + number of attemps for timeout
  2) Use of g_get_tmp_dir instead of hard-coded /tmp
  3) Test if machine lm3s6965evb is available, if not skip test
- Use of qemu_irq_pulse instead of 2x qemu_set_irq
- Fixed all tests for new device options and IRQ name change
- Updated doc and commit messages regarding new/deleted device options
- Turned device options 'x-bus-address-iomem' and 'x-bus-address-shmem'
  mandatory


Cheers,
Gustavo

Gustavo Romero (7):
  hw/misc/ivshmem-flat: Add ivshmem-flat device
  hw/misc/ivshmem-flat: Allow device to wire itself on sysbus
  hw/arm: Allow some machines to use the ivshmem-flat device
  hw/misc/ivshmem: Rename ivshmem to ivshmem-pci
  tests/qtest: Reorganize common code in ivshmem-test
  tests/qtest: Add API functions to capture IRQ toggling
  tests/qtest: Add ivshmem-flat test

 docs/system/devices/ivshmem-flat.rst |  90 +++++
 hw/arm/mps2.c                        |   3 +
 hw/arm/stellaris.c                   |   3 +
 hw/arm/virt.c                        |   2 +
 hw/core/sysbus-fdt.c                 |   2 +
 hw/misc/Kconfig                      |   5 +
 hw/misc/ivshmem-flat.c               | 531 +++++++++++++++++++++++++++
 hw/misc/{ivshmem.c => ivshmem-pci.c} |   0
 hw/misc/meson.build                  |   4 +-
 hw/misc/trace-events                 |  16 +
 include/hw/misc/ivshmem-flat.h       |  94 +++++
 tests/qtest/ivshmem-flat-test.c      | 338 +++++++++++++++++
 tests/qtest/ivshmem-test.c           | 113 +-----
 tests/qtest/ivshmem-utils.c          | 156 ++++++++
 tests/qtest/ivshmem-utils.h          |  56 +++
 tests/qtest/libqtest.c               |  24 ++
 tests/qtest/libqtest.h               |  28 ++
 tests/qtest/meson.build              |   6 +-
 18 files changed, 1362 insertions(+), 109 deletions(-)
 create mode 100644 docs/system/devices/ivshmem-flat.rst
 create mode 100644 hw/misc/ivshmem-flat.c
 rename hw/misc/{ivshmem.c => ivshmem-pci.c} (100%)
 create mode 100644 include/hw/misc/ivshmem-flat.h
 create mode 100644 tests/qtest/ivshmem-flat-test.c
 create mode 100644 tests/qtest/ivshmem-utils.c
 create mode 100644 tests/qtest/ivshmem-utils.h

-- 
2.34.1


