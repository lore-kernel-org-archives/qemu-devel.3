Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF029C636B2
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuARq-0007ye-QS; Sun, 22 Feb 2026 09:28:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuARc-0007x9-P7
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:28:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuARa-0006eB-Pg
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771770500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BzXcCDGS741U4fZsHJm9feMPpS4qDCw7tbd57ymm+ro=;
 b=OJ4X5cLbowNmr0JVswCLgayJto/LpjdXo7cy6Gcwmahb+673AerMgfNRRZ7RPvWygq5Zgh
 HaIp2N0Dhc/dqyk2kWpNZZhlPLtjOU4jmYzNb23OHaKwHoBpk6eNYRgp9t38id3W6CsIJR
 TyXOsO6HuizTL4yH/tW/uGd+v3twKHE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-3Ow_2l99MFexqMqYgWXcuw-1; Sun, 22 Feb 2026 09:28:18 -0500
X-MC-Unique: 3Ow_2l99MFexqMqYgWXcuw-1
X-Mimecast-MFC-AGG-ID: 3Ow_2l99MFexqMqYgWXcuw_1771770498
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836ff58111so46682255e9.1
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771770497; x=1772375297; darn=nongnu.org;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BzXcCDGS741U4fZsHJm9feMPpS4qDCw7tbd57ymm+ro=;
 b=pFmo5alfJ/pk4oMZ1dGBgfSvEhF15PjdLbEWUpUD8QkToZcqXc9qFXKqXpWUWGOSKM
 oZhmCIM51cSaxJkyX0n57aEAZa3RsXm9HlnnTLa5Cd6MrV4HJXXKDxCEyg6dcK7B4/Kc
 zJh1F7LpBQiQpSfyVOOaqPNU/T86vSgNLzWpMSSL3Ii326nKE47LCE63Q6elsbY05XbN
 99XQfR2eo6g7UtexaSIuSYQ9ar1srPvuSjsD6jRBhi/4ZJVGmoWXAsRyka6xuPrZi7la
 3G8YV9DjG866phS3vlOE2JPZ7xlKFjccjWc5gIdRUhfq7CGbi5AxRiXmTbp4shy5M4Og
 ew/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770497; x=1772375297;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BzXcCDGS741U4fZsHJm9feMPpS4qDCw7tbd57ymm+ro=;
 b=ie4XUPtq/mhHPslx5je4fygKaHf5NyA7kxvUrwSaRMi5ueInk0PJwotBW46Cx843ed
 5nIcSL5/j/o6Y/q6biyAidN/pVLxvkc/3AGLnvsUepTsu5wnsaN4dudjwM9eqDE4uBKH
 +NRvPFssPuoWGV1BSv3B/yL2EBFaugrAmIBoRPi0yoRgO7R0fciPkdL+ckccMIoHmq7T
 jcoLdBKzKSp8A1ilQpYa3ARztTyIsrNflcQ6x1futOpJezOTtEtKjzdCVIm8a7TBk2e4
 CAT1/NgTMeyFU1Dq4874VvQyJ3DKfKMUvSfW6tEvCRmokN44MBvrDu7myteuZxYcmwmS
 3Hig==
X-Gm-Message-State: AOJu0Ywh+YPy1/b1edc6suVtNxMzj2kd91pRJaBk6JfjNUlDEDtNJ43B
 nC4UVCfm94GINz99kkEOJbQCgMjTL9AO98nLBg+bQFBq37LtdDTmO3Ic3didTwgke1KHqCveaWu
 Gu57EsLFsSMYKSGHWf43TPxzcCL9Y3ONOD8e7yEpjvKo804vE5odv+0K0BZo7HfGeoqeo9tHfYM
 S6cGrOVG459r7v8Z/IK1xRxeuHRlZ2Ye2MTg==
X-Gm-Gg: AZuq6aIvTv0VhUbNkBl07a/vTMFETR9xcj0nTtYOE98WyWKjV4B9vOfbVzscu8eqLuv
 px2hMDPI7XxsseukdSb4wxUvGJN4D+tKJipinlxOzekhuKpVqqEE62t2HQB2gbEF8uSfDu4ZeS8
 rcA4i8EqybEaq7sczVojclf3XWI24evlozRtRB15RCFagLeNmP/Lo47C4laCtECYZn2hkaa1FM4
 DjnM2+qm1XrIFkb9KBmFIHEftRzpjT0jarWRpXQ63uTLVQvwp9dMiXyeOzrDo5hJyyuToVTIA8I
 +7loaSIUak25qG/GK73xBblZmuYAWWiYm43T9eguWKjbik8ONXmxHGERBVoEFsbP7Usyb8m+8xJ
 WbxMqBQ+hmgNEIEQr44dVMdgMJOKT0K/lBtQ1Mzp0U0TCZw==
X-Received: by 2002:a05:600c:1386:b0:480:6c75:ddce with SMTP id
 5b1f17b1804b1-483a9603cacmr84254545e9.33.1771770496998; 
 Sun, 22 Feb 2026 06:28:16 -0800 (PST)
X-Received: by 2002:a05:600c:1386:b0:480:6c75:ddce with SMTP id
 5b1f17b1804b1-483a9603cacmr84254275e9.33.1771770496475; 
 Sun, 22 Feb 2026 06:28:16 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b6698asm213659225e9.2.2026.02.22.06.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:28:16 -0800 (PST)
Date: Sun, 22 Feb 2026 09:28:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/33] virtio,pc,pci: features, fixes
Message-ID: <cover.1771770471.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
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

The following changes since commit 07f97d5da04a9f97e273de85c76f5017d8135a6e:

  Merge tag 'pull-target-arm-20260219' of https://gitlab.com/pm215/qemu into staging (2026-02-19 10:36:06 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 72f663f575ab5e0f31320d7c9f25cc1f086313bd:

  vhost: fix vhost_inflight_buffer_pre_load (2026-02-20 13:04:45 -0500)

----------------------------------------------------------------
virtio,pc,pci: features, fixes

cxl:
    RAS features
    Back-Invalidate
    Flit mode
    r3.2 spec event updates
    FM-API Physical Switch Command Set support
vhost-vdpa: allow GSO for SVQ

misc fixes, cleanups in intel_iommu, vhost, virtio, acpi

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Akihiko Odaki (1):
      virtio-gpu-virgl: Add virtio-gpu-virgl-hostmem-region type

Alexandr Moshkov (1):
      vhost: fix vhost_inflight_buffer_pre_load

Arpit Kumar (2):
      hw/cxl: Physical Port Info FMAPI - update to current spec and add defines.
      hw/cxl: Add Physical Port Control FMAPI Command (Opcode 5102h)

Clément Mathieu--Drif (1):
      intel_iommu: Do not report recoverable faults to host

Davidlohr Bueso (4):
      hw/cxl: Add support for Maintenance command and Post Package Repair (PPR)
      hw/pcie: Support enabling flit mode
      hw/cxl: Support type3 HDM-DB
      hw/cxl: Remove register special_ops->read()

Eugenio Pérez (1):
      net/vhost-vdpa: Whitelist virtio-net GSO for shadow virtqueue

Ira Weiny (1):
      hw/cxl: Refactor component register initialization

Jonathan Cameron (4):
      tests/bios-tables-test: Excluded CEDT.cxl for BI restriction relaxation.
      hw/cxl: Update CXL Fixed Memory Window ACPI description to include Back Invalidate support.
      tests/acpi/cxl: Update CEDT.cxl to allow BI in CFWMS
      hw/cxl: Get Physical Port State - update for PCIe flit mode

Manos Pitsidianakis (5):
      MAINTAINERS: add me as maintainer to virtio-snd
      virtio-snd: remove TODO comments
      virtio-snd: handle 5.14.6.2 for PCM_INFO properly
      virtio-snd: fix max_size bounds check in input cb
      virtio-snd: tighten read amount in in_cb

Mohamed Mediouni (1):
      tests/data/acpi: disassemble-aml: rename and change interpreter line

Philippe Mathieu-Daudé (1):
      hw/virtio: Pass VirtIODevice* to virtio_reset()

Shiju Jose (7):
      qapi: cxl: Refactor CXL event injection for common commands arguments
      hw/cxl/events: Update for rev3.2 common event record format
      hw/cxl/events: Updates for rev3.2 general media event record
      hw/cxl/events: Updates for rev3.2 DRAM event record
      hw/cxl/events: Updates for rev3.2 memory module event record
      hw/cxl/cxl-mailbox-utils: Move declaration of scrub and ECS feature attributes in cmd_features_set_feature()
      hw/cxl: Add emulation for memory sparing control feature

Yanfeng Liu (1):
      audio/virtio-snd: fix latency calc

Yodel Eldar (3):
      tests/vhost-user-bridge: Move to contrib/vhost-user-bridge/
      tests/functional/x86_64: Add vhost-user-bridge test
      contrib/vhost-user-bridge: Add UDP receive hexdump

 MAINTAINERS                                        |   3 +-
 contrib/vhost-user-bridge/meson.build              |   4 +
 .../vhost-user-bridge}/vhost-user-bridge.c         |   7 +
 docs/system/devices/cxl.rst                        |  23 +
 docs/system/devices/virtio/vhost-user-contrib.rst  |  39 ++
 hw/acpi/cxl.c                                      |   2 +-
 hw/audio/virtio-snd.c                              |  80 ++-
 hw/cxl/cxl-component-utils.c                       | 214 ++++--
 hw/cxl/cxl-events.c                                |   3 +-
 hw/cxl/cxl-mailbox-utils.c                         | 752 ++++++++++++++++++++-
 hw/display/virtio-gpu-virgl.c                      |  54 +-
 hw/i386/intel_iommu.c                              |  26 +-
 hw/mem/cxl_type3.c                                 | 349 +++++++++-
 hw/mem/cxl_type3_stubs.c                           |  41 +-
 hw/pci-bridge/cxl_downstream.c                     |  19 +-
 hw/pci-bridge/cxl_root_port.c                      |  11 +-
 hw/pci-bridge/cxl_upstream.c                       |  19 +-
 hw/pci-bridge/pci_expander_bridge.c                |   2 +-
 hw/pci/pcie.c                                      |  23 +-
 hw/virtio/vhost.c                                  |   4 +-
 hw/virtio/virtio.c                                 |   3 +-
 include/hw/audio/virtio-snd.h                      |   1 +
 include/hw/cxl/cxl_component.h                     |  87 ++-
 include/hw/cxl/cxl_device.h                        | 156 ++++-
 include/hw/cxl/cxl_events.h                        |  85 ++-
 include/hw/cxl/cxl_port.h                          |  73 ++
 include/hw/pci-bridge/cxl_downstream_port.h        |  12 +
 include/hw/pci-bridge/cxl_upstream_port.h          |   3 +
 include/hw/pci/pcie.h                              |   2 +-
 include/hw/pci/pcie_port.h                         |   1 +
 include/hw/virtio/virtio.h                         |   2 +-
 meson.build                                        |   1 +
 net/vhost-vdpa.c                                   |   1 +
 qapi/cxl.json                                      | 186 +++--
 .../acpi/{disassemle-aml.sh => disassemble-aml.sh} |   4 +-
 tests/data/acpi/rebuild-expected-aml.sh            |   2 +-
 tests/data/acpi/x86/q35/CEDT.cxl                   | Bin 184 -> 184 bytes
 tests/functional/x86_64/meson.build                |   1 +
 tests/functional/x86_64/test_vhost_user_bridge.py  | 147 ++++
 tests/meson.build                                  |   6 -
 40 files changed, 2187 insertions(+), 261 deletions(-)
 create mode 100644 contrib/vhost-user-bridge/meson.build
 rename {tests => contrib/vhost-user-bridge}/vhost-user-bridge.c (98%)
 create mode 100644 include/hw/cxl/cxl_port.h
 create mode 100644 include/hw/pci-bridge/cxl_downstream_port.h
 rename tests/data/acpi/{disassemle-aml.sh => disassemble-aml.sh} (92%)
 create mode 100755 tests/functional/x86_64/test_vhost_user_bridge.py


