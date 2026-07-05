Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E341AC43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNy5-000198-Qs; Sun, 05 Jul 2026 10:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNxV-0000Gj-3x
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:36:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNxT-0001fh-2A
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=BjMFqW79037KEcA6woZu4YBB6Us4nSIWQgh4q3aTCq4=;
 b=A5pd3iX9fSxUmkVwXXblN5f3jXpIfj6z3iNyVfRozrUHjmxdPPlPPDyYkZf4FPdwWPR7x7
 wjsABR12kmJTRMyLiGjfd7dh7dSTcsvC6E8Cscj5i3xOx1H8lVw1H1yVedEi0eLSrhenvS
 bpzWMfcOderyt+c5E3KGMrkQ3rHEPtc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-tB97wdO8Npq4qFcsRU5ljA-1; Sun, 05 Jul 2026 10:36:31 -0400
X-MC-Unique: tB97wdO8Npq4qFcsRU5ljA-1
X-Mimecast-MFC-AGG-ID: tB97wdO8Npq4qFcsRU5ljA_1783262190
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-492488f8583so21531995e9.2
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262190; x=1783866990; darn=nongnu.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BjMFqW79037KEcA6woZu4YBB6Us4nSIWQgh4q3aTCq4=;
 b=XT5zuMfo0gVABQspnCbKU6JDILJh3mse3EdowHuV7NbKbhcXqFxbKqA2AAc7Tl2R24
 R5Uf+BcujeP4DtsN8SvkABXzkMx1PSPtYijWAnId4mwRaobmap5kZbQ2O97CP6/dQlWI
 70+d+n41OqM4TH9poG0Zx4bi2FbycHVJ2am80HX227e9GcaUY1n1pplyldQ2lLBZvCG/
 ksn/6tPJc7Wx/G6LMRSypgimIiWhlxXRc2vrDUCWZfHaPMGogrAq8apnfIGU1hfbRaxX
 RMoadSlh9K9BlRw+aLtQ6YtXM/K4fDNa/nGXNxPEdwCEMtZb+1AI6Awh66hSQjnCnjki
 Js5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262190; x=1783866990;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BjMFqW79037KEcA6woZu4YBB6Us4nSIWQgh4q3aTCq4=;
 b=YZa5ruXVC6pUyHzpat7jQRqICrszKqbHylNd/jlCM7btKNTVM0BDfVu6OcMYbmt0jc
 Ho6fbxQGM6ZSCshNR7gsRKC0Lg3gPGro+BOlZgbrwZQlI/SxQqGpgSg3LNfLHBDhiM/H
 0frmDlPuiXM52+yR/JerQbHpr4xNkjG/btLazDvEJIXTIEnspwnVTEB+cLN/3rMhvkBv
 SyX8iBo+XieLCiWePsrb1prx6lgLc3B3gUjI/DRQLgBvWvuqQ4lBNjb0ZTGh02MdFOyl
 jObFIFJ1S6pNv95tsGjCIg7/ATogSP76CJn9iTKMjZpS9DopItMgZlZzgvaZFMrs0XhU
 WBWQ==
X-Gm-Message-State: AOJu0Yw1uWxCYdPBfhoa5R39E30E6rOYcVaXgA0wtkkMQtQLKEI54Ozj
 +wMY1s/PDUK8E8rilOESj+879LJpUojYTsB2eAm5ys/aZHJPlWn5G0wHDQfcv464U96X68l69Rw
 2pdX1V0/LJnQmC4P4wsSxYzoww60PlYJd4QdaG6ny1m5HtC8ZuO5R9hEQeIfKn7HIwSIWA1IXBW
 aNglj8Grsbdm8Ku3mFmNM7Y6G+Hu1zudBvsA==
X-Gm-Gg: AfdE7cnsjF9NRJaaF6Kabsfq7APWD/xdgNF15PSdBNLwYwVhdbpsuxUStc9kA0hbsUF
 HdZuArGzzKvj/XNJ45xAK2euYMNVCXYqhgupVPQy81Vh47Lgl/3ZdsFiujSWcIKER2aW55PlH7c
 v1s89dLCK0fF50VwnUO5RIuvSwL7V+v9Tfkpx/Ak3aIIGzHwINJXq3A3CrZ0/Xp5t0IRDGT4RA4
 Yxcbda3i5ERi3MhtBpxlcKTYPhHOFSI3xle6G/AKgZh+JOu2q8kmF+iV782m/n3f8Ci+/lcn/qD
 /BfVvylq3GYy70Jqe1Mt5bugQc/4/f6OgLQPnxQtFr2lhSwmQnDSums9bBrwISGwG1DJMJuQnwl
 /2dCMTaueVTXPfzYGzdzmCIDzrLy9c66v
X-Received: by 2002:a05:600c:6388:b0:493:c35c:b4d1 with SMTP id
 5b1f17b1804b1-493d11cf29emr82314985e9.7.1783262190201; 
 Sun, 05 Jul 2026 07:36:30 -0700 (PDT)
X-Received: by 2002:a05:600c:6388:b0:493:c35c:b4d1 with SMTP id
 5b1f17b1804b1-493d11cf29emr82314725e9.7.1783262189587; 
 Sun, 05 Jul 2026 07:36:29 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d8410sm16406890f8f.15.2026.07.05.07.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:36:29 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:36:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com
Subject: [PULL 00/44] pci, vhost, virtio, iommu: features, fixes, cleanups
Message-ID: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I hope I didn't miss any features for the freeze. If yours
is missing, pls holler.

There are some (old) bugs that have been reported and will
I hope get fixed before the release, I will focus on that
after the freeze.



The following changes since commit 7f2007d1924565c7a38b2c6ba01ebc1a85db0a49:

  Merge tag 'pull-qobject-2026-07-02' of https://repo.or.cz/qemu/armbru into staging (2026-07-03 07:42:51 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 32a90850e1e4222091df07b4b46d5f46a8b90d24:

  virtio-net: validate RSS indirections_len in post_load (2026-07-05 09:06:13 -0400)

----------------------------------------------------------------
pci, vhost, virtio, iommu: features, fixes, cleanups

A new sp-mem device
New tests for vtd
New seg-max-adjust flag for vhost-user-blk
Watchdog support for arm/virt

Fixes, cleanups all over the place.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alejandro Jimenez (4):
      amd_iommu: Return int from page walk status helpers
      amd_iommu: Decode XT interrupt control register without bitfields
      amd_iommu: Decode IRTEs without bitfields
      amd_iommu: Fix endianness handling for command buffer entries

David Hoppenbrouwers (1):
      amd_iommu: Fix opcode reported in invalid command handling

Demi Marie Obenour (1):
      vhost-user: Guarantee that memory regions do not overlap

GuoHan Zhao (3):
      vhost-user-base: free virtqueue array during cleanup
      vhost-user-base: clean up vhost_dev on realize failure
      vhost-user-scmi: free vhost virtqueue array on cleanup

Igor Mammedov (13):
      arm: sbsa_gwdt: fixup default "clock-frequency"
      arm: add tracing events to sbsa_gwdt
      arm: sbsa_gwdt: rename device type to sbsa-gwdt
      arm: virt: create sbsa-gwdt watchdog
      arm: sbsa-gwdt: add 'wdat' option
      acpi: introduce WDAT table for GWDT
      arm: virt: add support for WDAT based watchdog
      tests: acpi: arm/virt: whitelist new WDAT table
      tests: acpi: arm/virt: add WDAT table test case
      tests: acpi: arm/virt: update expected WDAT blob
      tests: acpi: arm/virt: whitelist GTDT table
      tests: acpi: arm/virt: add GTDT watchdog table test case
      tests: acpi: arm/virt: update expected GTDT blob

Junjie Cao (4):
      tests/qtest/libqos: share Intel IOMMU test setup helpers
      tests/qtest/libqos: add Intel IOMMU invalidation helpers
      tests/qtest: add IOTLB invalidation test for Intel IOMMU
      virtio-net: validate RSS indirections_len in post_load

Laurent Vivier (1):
      hw/char/virtio-serial-bus: fix guest-triggerable OOM in control_out()

Sergei Heifetz (1):
      vhost-user-blk: add seg-max-adjust flag

Stefan Hajnoczi (3):
      vhost-user.rst: clarify when rings are started
      libvhost-user: look for available vq buffers upon SET_VRING_KICK
      vhost-user: inject kick after SET_VRING_KICK

fanhuang (10):
      hw/mem: add sp-mem device for Specific Purpose Memory
      qapi, hmp: introspection for the sp-mem device
      i386/acpi-build: partition device_memory SRAT umbrella for sp-mem
      hw/i386: hook sp-mem into the pc machine plug path
      MAINTAINERS: cover sp-mem under Memory devices, add R: tag
      tests/acpi: add empty expected blobs for sp-mem SRAT test
      tests/acpi: add bios-tables-test case for sp-mem
      tests/acpi: generate expected blobs for sp-mem SRAT test
      tests/qtest: add e820 fw_cfg test
      tests/qtest: cover sp-mem SOFT_RESERVED e820 entry

helei (1):
      hw/virtio-crypto: enforce max akcipher key length

lizhaoxin04 (1):
      vdpa: fix use-after-free of vqs in vhost_vdpa_device_unrealize

no92 (1):
      intel_iommu: Correctly set pt bit in extended capability register

 MAINTAINERS                               |   4 +
 docs/interop/vhost-user.rst               |  47 +++-
 docs/system/arm/virt.rst                  |  24 +++
 qapi/machine.json                         |  43 +++-
 hw/i386/amd_iommu.h                       |  63 ------
 hw/i386/e820_memory_layout.h              |  11 +-
 include/hw/acpi/wdat-gwdt.h               |  19 ++
 include/hw/arm/virt.h                     |   3 +
 include/hw/mem/sp-mem.h                   |  33 +++
 include/hw/virtio/vhost-user-blk.h        |   1 +
 include/hw/watchdog/sbsa_gwdt.h           |   3 +-
 tests/qtest/libqos/qos-intel-iommu.h      |  74 +++++++
 hw/acpi/wdat-gwdt-stub.c                  |  16 ++
 hw/acpi/wdat-gwdt.c                       |  99 +++++++++
 hw/arm/virt-acpi-build.c                  |  51 ++++-
 hw/arm/virt.c                             |  48 +++++
 hw/block/vhost-user-blk.c                 |  12 ++
 hw/char/virtio-serial-bus.c               |  34 +--
 hw/core/machine-hmp-cmds.c                |  11 +
 hw/core/sysbus-fdt.c                      |   2 +
 hw/i386/acpi-build.c                      |  96 ++++++++-
 hw/i386/amd_iommu.c                       | 168 ++++++++++-----
 hw/i386/intel_iommu.c                     |   4 +-
 hw/i386/pc.c                              |  36 ++++
 hw/mem/sp-mem.c                           | 128 +++++++++++
 hw/net/virtio-net.c                       |  21 +-
 hw/virtio/vdpa-dev.c                      |   3 +-
 hw/virtio/vhost-user-base.c               |  21 +-
 hw/virtio/vhost-user-scmi.c               |  12 +-
 hw/virtio/vhost-user.c                    |  24 ++-
 hw/virtio/virtio-crypto.c                 |   6 +
 hw/watchdog/sbsa_gwdt.c                   |  24 ++-
 subprojects/libvhost-user/libvhost-user.c |  19 +-
 tests/qtest/bios-tables-test.c            |  62 ++++++
 tests/qtest/e820-test.c                   | 129 +++++++++++
 tests/qtest/iommu-intel-inv-test.c        | 346 ++++++++++++++++++++++++++++++
 tests/qtest/iommu-intel-test.c            |  78 +------
 tests/qtest/libqos/qos-intel-iommu.c      | 185 ++++++++++++++++
 hw/acpi/meson.build                       |   2 +
 hw/arm/Kconfig                            |   1 +
 hw/i386/Kconfig                           |   2 +
 hw/mem/Kconfig                            |   4 +
 hw/mem/meson.build                        |   1 +
 hw/watchdog/trace-events                  |   9 +
 tests/data/acpi/aarch64/virt/GTDT.gwdt    | Bin 0 -> 132 bytes
 tests/data/acpi/aarch64/virt/WDAT.wdat    | Bin 0 -> 260 bytes
 tests/data/acpi/x86/q35/DSDT.spmem        | Bin 0 -> 9910 bytes
 tests/data/acpi/x86/q35/SRAT.spmem        | Bin 0 -> 384 bytes
 tests/qtest/meson.build                   |   3 +-
 49 files changed, 1715 insertions(+), 267 deletions(-)
 create mode 100644 include/hw/acpi/wdat-gwdt.h
 create mode 100644 include/hw/mem/sp-mem.h
 create mode 100644 hw/acpi/wdat-gwdt-stub.c
 create mode 100644 hw/acpi/wdat-gwdt.c
 create mode 100644 hw/mem/sp-mem.c
 create mode 100644 tests/qtest/e820-test.c
 create mode 100644 tests/qtest/iommu-intel-inv-test.c
 create mode 100644 tests/data/acpi/aarch64/virt/GTDT.gwdt
 create mode 100644 tests/data/acpi/aarch64/virt/WDAT.wdat
 create mode 100644 tests/data/acpi/x86/q35/DSDT.spmem
 create mode 100644 tests/data/acpi/x86/q35/SRAT.spmem


