Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128C3CCFA13
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 14:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI6Vj-00027j-ID; Sun, 09 Nov 2025 09:35:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI6Vg-000279-L0
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:35:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI6Ve-0001lV-4m
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:35:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762698912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=xJhZlxm2Tl2LFNmCdLACioU0v0rdrau+1g+t5U9r+f8=;
 b=FxAgcFqjBvAHZlBhx+76WNSRLp1W3gmeY/Cnp/dxR6yIVIkhAn9c5Um+oXuiBvUZIgWsU2
 Jpc0ddYqkl5sgNxFsCV03wDgb4JSL1hTCLCtfRHdU12BAfCwS9a/nHZ/iIPy9GMtWpDyLQ
 dk+X9B9S/+RyaqzJuraPlg9Q4cG+p7Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-Vl3bHKC0NDerEyi1UmZV4Q-1; Sun, 09 Nov 2025 09:35:11 -0500
X-MC-Unique: Vl3bHKC0NDerEyi1UmZV4Q-1
X-Mimecast-MFC-AGG-ID: Vl3bHKC0NDerEyi1UmZV4Q_1762698910
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47111dc7c5dso9874975e9.0
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 06:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762698910; x=1763303710; darn=nongnu.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xJhZlxm2Tl2LFNmCdLACioU0v0rdrau+1g+t5U9r+f8=;
 b=idIpPt1qWjdaczWvGBYrygoYLSngUWoSnvnarOD2epoppKZYRDi+ode5SNBxnluhuY
 Wu0rUFKHLAcd7W08ayjeqa8un4YBzrNWqnm6vkhJRIRMmbYUZeobcC3jrSU10L4Qj8V4
 Nf1KKPDj8xgv08080PmoZ6EMrFVPiwshiUzBUArDCbRnydNS1fO4Bd7jXHORYCAfl2uC
 Z+gmgbzsY/DgbOVKHf8XZr0hM2RwhuTG31FXnIjzM/u1flCmjpQfdpLJ1hCIeF4j+/Ta
 mJCcf94ti4D0U5afBUVJ53scTsfCJjXV4AphBli21CbYSvczd8jCiVhigbCuaG8yVmPF
 VN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762698910; x=1763303710;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xJhZlxm2Tl2LFNmCdLACioU0v0rdrau+1g+t5U9r+f8=;
 b=Hr+FqqDduwfjyP8dRkW4xDhvyf5IXVUFnR79qrAFFnFafvFk1Yb4QZspYShNNdjFkP
 zvFu5f4d48dSSsPsQPmjYbWID6ueZezkjdk2KGboVLSIeeQPPHyDwULwTEKXJUNabjZV
 druWTcgSmitNe4swjtzX5RxdG7hYROOpVVjqNrNaXCQVL2fQNELfGpVGugNmh2eLw3cG
 wPztg7z15RnTmdItylogYs1y03V0IT0NVQLY89uLRxhStaCeUufS8lW6+VSl2rP0uw0E
 9JttmHh9zJpkCx0f9dQID0ijIjMFQ1mgDNlw9NLNHdVEw78suSHvLhJZ6snHkXP/4lZW
 euUg==
X-Gm-Message-State: AOJu0Yzkg1gO8NdMkEMn7IPcU31zo3haX7dlTYfpLJXtRbednfUGJugR
 kG+uxxqBDjziUZNNk0gluErTro0Mwl+7B+pXF+DarrLRCl+gOtb/t3V5Epu1aP8yIH9ITTa7uJ1
 QI+jrHr+GVOo92VMoZD9oFmdBeha8OiG1XYhrmC2Ofh3pp6XLomcIcnloAGoI4dJDdcqIFUFSDc
 lbAYpbiPEFJhSVzIM5yeipch34pjykjsFfkg==
X-Gm-Gg: ASbGnctNQhixytoXe088FF3hFI1pcki2GvrRBoX+MyAYt2X/Oan3Qwi2jdmIC6gwV1t
 n47QKWQpLjhfTaOSncCuYV2Jwmr0obwYMe7RyN6EXZ65I7AlH91wZiPPpfByU5ewJDdd1R0OmwD
 CcZ8MrWCzuVEFusX+6ZVG/wfdCrn33yYqku5RzEdLVVZ6nDDKCtc+8T3sr/3FBeZhcPSTZNePjT
 6Ok8A2z7YBY69h352K/VMbXGX8ssn6IM1JNJx+pa2f6qY3W1lCkDb6ZuIUeG825712bvhVn3g1f
 GOxvvc7IzwxmxaZjsI2j8K27aaYwyTrjuMROx+68mAfw2tbt8AuMRTB/5rXo8mFVpd8=
X-Received: by 2002:a05:600c:2d48:b0:477:348b:1182 with SMTP id
 5b1f17b1804b1-4776dcd6fddmr40113205e9.18.1762698909609; 
 Sun, 09 Nov 2025 06:35:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0QQOk2w7JkBD3ma4iVUZDG2Ni/Hcd6zl1oVf2jOmpUNnYJXXcpXDeS251nh/5Ye3WUgz9RQ==
X-Received: by 2002:a05:600c:2d48:b0:477:348b:1182 with SMTP id
 5b1f17b1804b1-4776dcd6fddmr40113035e9.18.1762698908994; 
 Sun, 09 Nov 2025 06:35:08 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42abe63e13csm16782993f8f.19.2025.11.09.06.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 06:35:08 -0800 (PST)
Date: Sun, 9 Nov 2025 09:35:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/14] virtio,pci,pc: fixes for 10.2
Message-ID: <cover.1762698873.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 917ac07f9aef579b9538a81d45f45850aba42906:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-11-05 16:07:18 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 97f24a0496be9e0a7216fea1fa0d54c1db9066e2:

  vhost-user.rst: clarify when FDs can be sent (2025-11-09 08:25:53 -0500)

----------------------------------------------------------------
virtio,pci,pc: fixes for 10.2

small fixes all over the place.
UDP tunnel and TSEG tweaks are kind of borderline,
but I feel not making the change now will just add
to compatibility headaches down the road.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Albert Esteve (1):
      vhost-user: fix shared object lookup handler logic

Alejandro Jimenez (1):
      MAINTAINERS: Update entry for AMD-Vi Emulation

Alyssa Ross (1):
      vhost-user.rst: clarify when FDs can be sent

Eric Auger (1):
      hw/pci-host/gpex-acpi: Fix _DSM function 0 support return value

Gerd Hoffmann (1):
      q35: increase default tseg size

German Maglione (1):
      vhost-user: make vhost_set_vring_file() synchronous

Paolo Abeni (1):
      virtio-net: Advertise UDP tunnel GSO support by default

Sairaj Kodilkar (2):
      amd_iommu: Fix handling of devices on buses != 0
      amd_iommu: Support 64-bit address for IOTLB lookup

Shameer Kolothum (2):
      tests/qtest/bios-tables-test: Prepare for _DSM change in the DSDT table
      tests/qtest/bios-tables-test: Update DSDT blobs after GPEX _DSM change

Zhenzhong Duan (3):
      intel_iommu: Handle PASID cache invalidation
      intel_iommu: Reset pasid cache when system level reset
      intel_iommu: Fix DMA failure when guest switches IOMMU domain

 hw/i386/amd_iommu.h                              |   6 +-
 hw/i386/intel_iommu_internal.h                   |  17 +++
 include/hw/i386/intel_iommu.h                    |   6 +
 hw/core/machine.c                                |   4 +
 hw/i386/amd_iommu.c                              | 179 +++++++++++++---------
 hw/i386/intel_iommu.c                            | 181 +++++++++++++++++++++--
 hw/i386/pc.c                                     |   4 +-
 hw/net/virtio-net.c                              |   8 +-
 hw/pci-host/gpex-acpi.c                          |   2 +-
 hw/pci-host/q35.c                                |   2 +-
 hw/virtio/vhost-user.c                           |  64 ++++----
 MAINTAINERS                                      |   6 +-
 docs/interop/vhost-user.rst                      |   7 +
 hw/i386/trace-events                             |   4 +
 tests/data/acpi/aarch64/virt/DSDT                | Bin 5337 -> 5337 bytes
 tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt   | Bin 5423 -> 5423 bytes
 tests/data/acpi/aarch64/virt/DSDT.acpipcihp      | Bin 6246 -> 6246 bytes
 tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex | Bin 5391 -> 5391 bytes
 tests/data/acpi/aarch64/virt/DSDT.memhp          | Bin 6698 -> 6698 bytes
 tests/data/acpi/aarch64/virt/DSDT.pxb            | Bin 7812 -> 7812 bytes
 tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev     | Bin 10274 -> 10274 bytes
 tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy  | Bin 10274 -> 10274 bytes
 tests/data/acpi/aarch64/virt/DSDT.topology       | Bin 5539 -> 5539 bytes
 tests/data/acpi/aarch64/virt/DSDT.viot           | Bin 5354 -> 5354 bytes
 tests/data/acpi/loongarch64/virt/DSDT            | Bin 4603 -> 4603 bytes
 tests/data/acpi/loongarch64/virt/DSDT.memhp      | Bin 5824 -> 5824 bytes
 tests/data/acpi/loongarch64/virt/DSDT.numamem    | Bin 4609 -> 4609 bytes
 tests/data/acpi/loongarch64/virt/DSDT.topology   | Bin 4905 -> 4905 bytes
 tests/data/acpi/riscv64/virt/DSDT                | Bin 3538 -> 3538 bytes
 tests/data/acpi/x86/microvm/DSDT.pcie            | Bin 2985 -> 2985 bytes
 30 files changed, 371 insertions(+), 119 deletions(-)


