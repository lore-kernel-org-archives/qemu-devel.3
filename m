Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26028CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 15:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDlYg-0007Wf-M3; Tue, 28 Oct 2025 11:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vDlYa-0007Vv-EG
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 11:24:20 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vDlYO-0001MR-BZ
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 11:24:20 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-591eb980286so6425580e87.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 08:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761665040; x=1762269840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gyY7G2KNQ4IeSzA7C4uKfXSHI+47EUZHyeSU/TbBB8k=;
 b=gYt5BZMXHirPOyzpb8wIpB3Y1FWl3umbyb5uGLLuhTeneY7uSYJ7v7ilL1S3ErB7QO
 Cf1xrb9aQjp7i0PZVo7M5ePuO+bLZqPhlG7aRqjnH5SCVUr47AZVbyQ4gFNdAr/DAw0h
 FGDxndFz1r086cvCo32XDN/LzAYgS0P8WnybggcTg/tFfcMdAf7ijToY9RwXAmXB31p4
 zwS4Iy2fNzjPVuXFYbKbX2xfmrX9C3JQCVbqDJMoFA3h7/bAIuy37X+4tWfRcREZKOn8
 3jeS+BBNL8PSSR3xZ17l9dc7x3QO65aP1TgK5WYBsH8N3CBW/hVQgWGtxETIHi+Ziwg/
 oU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761665040; x=1762269840;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gyY7G2KNQ4IeSzA7C4uKfXSHI+47EUZHyeSU/TbBB8k=;
 b=j3cXNxX1iPkZ1eUwrC/EuktltS4VZ8viaUUl6bzfMTnV88/7L767tiRlEyspLH2yJz
 26p2ileYSbKhNWCgKWUqHmLhI7wc/YF/Z8Vk0VIbdQlRH4bXwCHKyAVBAACpBcSEC8gt
 Q4Un0gw/h9e5gRqZBpgni5thsvsS1zea73OIgVxAOLiywHdlByO/5UzCzcdpe/sHOjbc
 cYaUBcaF3A431h0BNJEhVxR++TVvWvMC773AeQyvqCo+2YBrW1X7GzwvcubK9O3aFUIv
 cjndbMtKO2nm12qKwoEDyLxiT1BJ2JC7BtLLOPWxpb4ZNyEzlmrjiaKbLw1qjHGLkc3s
 GrgA==
X-Gm-Message-State: AOJu0YyTNvhyMnpCVuxhZ3mY3ISTWK15mKVisO9gr2eDmYa7GTHfHOxu
 7qaxcecdmhpFGJCC27RwVva9S+Y+6vLZPf78EfRaOCTlvNGOvdKZUMfguJtWJrpjtqItmA==
X-Gm-Gg: ASbGnctSHXtrQjGGRZrI/UIT0+f60bFCbcDJ3qOhTvjJQD1H1EfATWkg3EHQU5CG+Sv
 RjsGFAi4PiFRprKTWO+njV3RkOreTUOd2o6LknqrVGOEm6Y5ZmSnYFgs+KRtdkNfoPrtNq4tCen
 3ILKodF9weNyAqzaKaIXoBCPBtZBjf4JGR6bRiLz3qodbbzLl5x4SlQltxfXDHZcV4t/zLbelcg
 3xY7H7FzO288kDzNIVV8QuATTdv1nP6rDNguVueZG6HufD8+jtQWrIyYGPnp0gwrFSlizvKg3Ba
 EuUBm0Rcmc/XcoFksJe7Rr/keyFlhdks4RNrEAggO41SDvKu9j3PPusGKqT7cegNMoQKqbsoJ20
 iv+Sg4lBdpNYxk1hfRbLDXllYTtMcpUaffH6OkIYuBeWSQDGsAmmdIg6xglTVMSAnefqkMpQFmV
 JS+cLjY5ZqDogq4G+b3q4/yjGq7WB+bCbIAzL5fEbHrYd3VR4=
X-Google-Smtp-Source: AGHT+IFImF0gGbyAmzDGX52hYiuwfpeF8+Gn5J4XOnuxyXkZciZheo/rvY6st6QMaJlLdqKsuF7ong==
X-Received: by 2002:a05:6512:308c:b0:591:c5bb:ce44 with SMTP id
 2adb3069b0e04-5930e9c31fdmr1719870e87.43.1761665039565; 
 Tue, 28 Oct 2025 08:23:59 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59301f5fc75sm3045953e87.59.2025.10.28.08.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 08:23:58 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, alex.bennee@linaro.org, bill.mills@linaro.org,
 edgar.iglesias@amd.com
Subject: [PATCH v1 0/5] virtio: Add the virtio-msg transport
Date: Tue, 28 Oct 2025 16:23:45 +0100
Message-ID: <20251028152351.1247812-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

This adds virtio-msg, a new virtio transport. Virtio-msg works by
exchanging messages over a bus and doesn't rely on trapping and emulation
making it a good fit for a number of applications such as AMP, real-time
and safety applications.

Together with the new transport, this series adds a PCI device that
implements an AMP setup much like it could look if two SoC's would
use virtio-msg across a PCI link.

Current gaps and limitations:
Shared memory FIFO layout likely to change in the future.
Temporarily uses PCI Vendor Xilinx / Device 0x9039.
Documentation.

The virtio-msg draft spec:
https://github.com/Linaro/virtio-msg-spec/

QEMU with these patches:
https://github.com/edgarigl/qemu/tree/edgar/virtio-msg-rfc

Linux with virtio-msg support:
https://github.com/edgarigl/linux/tree/edgari/virtio-msg-6.17

To try it, first build Linux with the following enabled:
CONFIG_VIRTIO_MSG=y
CONFIG_VIRTIO_MSG_AMP=y
CONFIG_VIRTIO_MSG_AMP_PCI=y

Boot linux on QEMU with a virtio-msg-amp-pci device, in this example
with a virtio-net device attached to it:

 -device virtio-msg-amp-pci
 -device virtio-net-device,netdev=n0
 -netdev user,id=n0

If you're running on a QEMU machine that has virtio-mmio enabled, e.g 
ARM virt, you'll need to specify the virtio-bus for the device, otherwise
QEMU will connect it to virtio-mmio. For ARM virt machines:

 -device virtio-msg-amp-pci
 -device virtio-net-device,netdev=n0,bus=/gpex-pcihost/pcie.0/virtio-msg-amp-pci/fifo0/virtio-msg/bus0/virtio-msg-dev
 -netdev user,id=n0

Cheers,
Edgar

Edgar E. Iglesias (5):
  virtio: Introduce notify_queue
  virtio: Add virtio_queue_get_rings
  virtio: Add the virtio-msg transport
  hw/misc: Add generic virtio-msg AMP PCI device
  docs: Describe virtio-msg-amp-pci

 .../devices/virtio/virtio-msg-amp-pci.rst     |  70 ++
 hw/misc/Kconfig                               |   7 +
 hw/misc/meson.build                           |   1 +
 hw/misc/virtio-msg-amp-pci.c                  | 328 +++++++
 hw/virtio/Kconfig                             |   4 +
 hw/virtio/meson.build                         |   5 +
 hw/virtio/virtio-msg-bus.c                    |  89 ++
 hw/virtio/virtio-msg.c                        | 695 ++++++++++++++
 hw/virtio/virtio.c                            |  23 +
 include/hw/virtio/spsc_queue.h                | 213 +++++
 include/hw/virtio/virtio-bus.h                |   1 +
 include/hw/virtio/virtio-msg-bus.h            |  95 ++
 include/hw/virtio/virtio-msg-prot.h           | 846 ++++++++++++++++++
 include/hw/virtio/virtio-msg.h                |  56 ++
 include/hw/virtio/virtio.h                    |   2 +
 15 files changed, 2435 insertions(+)
 create mode 100644 docs/system/devices/virtio/virtio-msg-amp-pci.rst
 create mode 100644 hw/misc/virtio-msg-amp-pci.c
 create mode 100644 hw/virtio/virtio-msg-bus.c
 create mode 100644 hw/virtio/virtio-msg.c
 create mode 100644 include/hw/virtio/spsc_queue.h
 create mode 100644 include/hw/virtio/virtio-msg-bus.h
 create mode 100644 include/hw/virtio/virtio-msg-prot.h
 create mode 100644 include/hw/virtio/virtio-msg.h

-- 
2.43.0


