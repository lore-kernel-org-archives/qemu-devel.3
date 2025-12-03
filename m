Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C123D1BDE8
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 21:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQuQD-0006La-Uv; Wed, 03 Dec 2025 16:30:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vQuQB-0006LI-Jn
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 16:29:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vQuQ7-0007DG-8O
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 16:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764797392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4QX9YmTjuC4SFBIonSDI81gIjEc/QwOZOAo4CQUQJmc=;
 b=J68eYpfo93lId4Lcd8g123vp8INl+RfubQUTBBuL4AkgGFKVuExuGv9WkBUkqQY68H6mc/
 z4R9GC6tjlFCECAJj1Hx55UInJx3CpLvOPi6H5WlhONy53+OUHukhLbReH8fpSwLOEy9jM
 8S6D/PxRtQtKm2ei/I6ZILJ5oKWxJ8M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-Hian5N1kMI6fb3oOId_IiA-1; Wed, 03 Dec 2025 16:29:47 -0500
X-MC-Unique: Hian5N1kMI6fb3oOId_IiA-1
X-Mimecast-MFC-AGG-ID: Hian5N1kMI6fb3oOId_IiA_1764797387
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42b3339cab7so142926f8f.0
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 13:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764797387; x=1765402187; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4QX9YmTjuC4SFBIonSDI81gIjEc/QwOZOAo4CQUQJmc=;
 b=A+XoVVpDGVy6sSEfyIyptmksEyA/3GTP5XF5ZUoMg8eHmHq5DzmbyJ3Kj5MdbOj2LS
 v/9jHgvvJVxM94c+3GJbwPCc11wmgBUTYGL/W4mxeedCO2eSt6wqwxg1G+7pp+MEHN8E
 SLX27dOVFvIMdlkQtk5zMfFsNLR1bNDn/4fPBV6xxAYNbk0SO7m2CDuDRlyYK2qaRAzL
 7el3z5dg0nEWzruRBxxqSGj2/tilFwDpUXbvxlV+Jv6rJUkJH3gNZNvHk/C58tiP3ivC
 S97izhLkTaNLaXGMi1e4gm9xj6dRMplXfZqYehGtVmhr255c98a08TaGi4Vp34om8LiN
 vrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764797387; x=1765402187;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4QX9YmTjuC4SFBIonSDI81gIjEc/QwOZOAo4CQUQJmc=;
 b=ZO2HdgTGqwllmaKg7pJg2+KKCwALxXRrujdGEa5OOjUeVPFLrsSZUj+sWrrIZKoP/O
 O36EoxTtlbDkjEVmpUuCN1tSGffb2H4Tg7vC2TGuFWLZnLk9pvj/2gI4cFPlWiJ15LR7
 WrSfU4ggvkJj9C6aelsDh03DLAkk3inrHRwFJYd4gTN9wm6IwkxfIIlVPidtoH18spDU
 75NJfFou45ThYZyoW3SfpTajRmXUu/dblgrL+PQPvoAe+N5oaGfmOsxM14XJLgidVCcD
 x/5z9kB98i5HUSX5n/3pgh2kWCHfoa5kEH5LpDD3x3UCDaoqXj3gez94PiX/eEqF0xym
 GsXA==
X-Gm-Message-State: AOJu0YxYij+3YHovPieee3PFMqzX/BqY+jtrOzx4WodSS4KeMvL62QRh
 b+QBjSxTvDZABfk2MymzKpvakBTCkQzdXn16aMA1RcsfANAGg52YnAwE+X1ww4y1CF91zEamym9
 akgjKMzYWlyJXyNQbYUVyZKrL/aH6X8C1IL/LiKiE+DYWadNZMndlw3WR
X-Gm-Gg: ASbGnctOtG7nPhuLLNuvS3khaXodUXE5gqS3Xei1Xj9QeMfAtLot7aau3zj4rQp89BT
 4PwFOb2m0T0ymYpYb+0LIeclVHJOEiqjsK+vrsBhLzrmff3xjQy75oxg+R3MBZb8R78ID+PMIfj
 Kn6ZdkpJMN9PMWDtCbdadt6Ods3aZen8BNzRrXGQaexXkPrbc7vDw8+0GEPQBEjR5o9MxqBO3Qq
 RGUzRGFnHtlKPAx0nwI9v5KEGdGLSlyk4H0UmMOQPMWt0Cy6CAgomJgQmHe+YYO8bFQ/T6E2Cys
 e17Fu826B6q4SG8GjzyWqI6CHOsQBvN/bI4yRq1mpM3aTUP9w40bpFlkTlRq8h0TU1EMmbpgD15
 9xiq0pIXrlS6c1Or/ctQCb4wqeJy8osTw0g==
X-Received: by 2002:a05:6000:4027:b0:427:23a:c339 with SMTP id
 ffacd0b85a97d-42f797fde27mr440895f8f.14.1764797386250; 
 Wed, 03 Dec 2025 13:29:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzTxxPKp3NJ1OX3uVR6Oy2unDVufTz6lXgPvxUbfF6kfK5AP0hkdMCDYLp9KapD8JLQkAVLA==
X-Received: by 2002:a05:6000:4027:b0:427:23a:c339 with SMTP id
 ffacd0b85a97d-42f797fde27mr440852f8f.14.1764797385349; 
 Wed, 03 Dec 2025 13:29:45 -0800 (PST)
Received: from redhat.com (IGLD-80-230-38-228.inter.net.il. [80.230.38.228])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5c3022sm42065578f8f.4.2025.12.03.13.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 13:29:44 -0800 (PST)
Date: Wed, 3 Dec 2025 16:29:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stephen Bates <sbates@raithlin.com>
Cc: qemu-devel@nongnu.org, marcel.apfelbaum@gmail.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, shai@shai.pub,
 k.jensen@samsung.com
Subject: Re: [PATCH v1] hw/pci: Add PCI MMIO Bridge for device-to-device MMIO
Message-ID: <20251203162723-mutt-send-email-mst@kernel.org>
References: <aTCpGWb7V8R2HVl8@snoc-thinkstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTCpGWb7V8R2HVl8@snoc-thinkstation>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Dec 03, 2025 at 02:18:17PM -0700, Stephen Bates wrote:
> This patch introduces a PCI MMIO Bridge device that enables PCI devices
> to perform MMIO operations on other PCI devices via command packets. This
> provides software-defined PCIe peer-to-peer (P2P) communication without
> requiring specific hardware topology.
> 
> Configuration:
>   qemu-system-x86_64 -machine q35 \
>       -device pci-mmio-bridge,shadow-gpa=0x80000000,shadow-size=4096
> 
> - shadow-gpa: Guest physical address (default: 0x80000000, 0=auto)
> - shadow-size: Buffer size in bytes (default: 4096, min: 4096)
> - poll-interval-ns: Polling interval (default: 1000000 = 1ms)
> - enabled: Enable/disable bridge (default: true)
> 
> The bridge exposes shadow buffer information via a vendor-specific PCI config
> space:
> 
>   Offset 0x40: GPA bits [31:0]
>   Offset 0x44: GPA bits [63:32]
>   Offset 0x48: Buffer size
>   Offset 0x4C: Queue depth
> 
> Guest software reads these registers to locate the command queue and
> can then submit MMIO operations by writing command packets to guest
> RAM and updating the producer index.
> 
> Limitations:
> - Currently supports only bus 0 (main PCI bus)
> - No access control or security checks between devices
> - Polling-based completion (no interrupt notification)
> - Cannot target VFIO device BARs directly (future work)
> 
> Testing:
>   make check-qtest-x86_64
> 
> The qtest suite validates PCI device discovery, config space registers,
> command queue operations, and proper handling of invalid commands.
> 
> Signed-off-by: Stephen Bates <sbates@raithlin.com>


Not at all excited to support another device with an ad hoc
guest/host communication protocol.

Why not build a virtio-pci-bridge? 

> ---
>  MAINTAINERS                             |   8 +
>  docs/system/device-emulation.rst        |   1 +
>  docs/system/devices/pci-mmio-bridge.rst | 302 +++++++++++++
>  hw/pci/meson.build                      |   1 +
>  hw/pci/pci-mmio-bridge.c                | 568 ++++++++++++++++++++++++
>  hw/pci/trace-events                     |  18 +
>  include/hw/pci/pci-mmio-bridge.h        | 162 +++++++
>  include/hw/pci/pci.h                    |   1 +
>  tests/qtest/meson.build                 |   1 +
>  tests/qtest/pci-mmio-bridge-test.c      | 417 +++++++++++++++++
>  10 files changed, 1479 insertions(+)
>  create mode 100644 docs/system/devices/pci-mmio-bridge.rst
>  create mode 100644 hw/pci/pci-mmio-bridge.c
>  create mode 100644 include/hw/pci/pci-mmio-bridge.h
>  create mode 100644 tests/qtest/pci-mmio-bridge-test.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a07086ed76..6bbbeca57e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2098,6 +2098,14 @@ F: docs/pci*
>  F: docs/specs/*pci*
>  F: docs/system/sriov.rst
>  
> +PCI MMIO Bridge
> +M: Michael S. Tsirkin <mst@redhat.com>
> +S: Supported
> +F: hw/pci/pci-mmio-bridge.c
> +F: include/hw/pci/pci-mmio-bridge.h
> +F: tests/qtest/pci-mmio-bridge-test.c
> +F: docs/system/devices/pci-mmio-bridge.rst
> +
>  PCIE DOE
>  M: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
>  M: Chris Browy <cbrowy@avery-design.com>
> diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
> index 911381643f..472b388162 100644
> --- a/docs/system/device-emulation.rst
> +++ b/docs/system/device-emulation.rst
> @@ -91,6 +91,7 @@ Emulated Devices
>     devices/keyboard.rst
>     devices/net.rst
>     devices/nvme.rst
> +   devices/pci-mmio-bridge.rst
>     devices/usb.rst
>     devices/vhost-user.rst
>     devices/virtio-gpu.rst
> diff --git a/docs/system/devices/pci-mmio-bridge.rst b/docs/system/devices/pci-mmio-bridge.rst
> new file mode 100644
> index 0000000000..6cd069af0b
> --- /dev/null
> +++ b/docs/system/devices/pci-mmio-bridge.rst
> @@ -0,0 +1,302 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +===============
> +PCI MMIO Bridge
> +===============
> +
> +The PCI MMIO Bridge is an emulated PCI device that provides a mechanism for
> +PCI devices to perform MMIO (Memory-Mapped I/O) operations on other PCI
> +devices via command packets. This enables software-defined PCIe peer-to-peer
> +(P2P) communication between any combination of emulated and real PCI devices.
> +
> +Overview
> +========
> +
> +The PCI MMIO Bridge uses a hybrid architecture:
> +
> +1. **PCI Device**: Provides guest OS discovery via standard enumeration.
> +2. **Shadow Buffer**: Allocated in guest RAM.
> +3. **PCI Config Space**: Exposes shadow buffer GPA in vendor-specific
> +   registers.
> +
> +VFIO can only map guest RAM not emulated PCI MMIO space. And, at the present
> +time, VFIO cannot map MMIO space into an IOVA mapping. Therefore the PCI MMIO
> +Bridge uses a small amount of guest RAM mapped into its Guest Physical Address
> +(GPA) space.
> +
> +Command Queue Structure
> +=======================
> +
> +The PCI MMIO Bridge uses a ring buffer in guest RAM. The first 24 bytes
> +of the ring buffer contain metadata. The rest of the ring buffer contains
> +command slots:
> +
> +.. code-block:: c
> +
> +   struct pci_mmio_bridge_ring_meta {
> +       uint32_t producer_idx;  /* Written by initiator */
> +       uint32_t consumer_idx;  /* Written by QEMU */
> +       uint32_t queue_depth;   /* Number of available slots */
> +       uint32_t reserved[3];
> +   };
> +
> +   struct pci_mmio_bridge_command {
> +       uint16_t target_bdf;    /* Bus:Device:Function */
> +       uint8_t  target_bar;    /* Which BAR on target */
> +       uint8_t  reserved1;
> +       uint32_t offset;        /* Offset within BAR */
> +       uint32_t value;         /* Write value / read result */
> +       uint8_t  command;       /* 0=NOP, 1=WRITE, 2=READ */
> +       uint8_t  size;          /* 1, 2, 4, or 8 bytes */
> +       uint8_t  status;        /* 0=pending, 1=complete, 2=error */
> +       uint8_t  reserved2;
> +       uint32_t sequence;      /* For ordering */
> +       uint32_t reserved3;
> +   };
> +
> +With the default 4KiB shadow buffer size, the queue provides 169 command slots.
> +
> +Processing Model
> +================
> +
> +QEMU polls the command queue periodically (default 1ms interval). When
> +the producer index differs from the consumer index:
> +
> +1. QEMU reads pending command(s) from the queue
> +2. For each command:
> +
> +   * Locates the target PCI device (emulated or real) by BDF
> +   * Dispatches MMIO read/write to the target device's BAR
> +   * Updates the command status field (complete or error)
> +   * Updates the result value (for reads)
> +
> +3. Updates the consumer index
> +4. Reschedules the next poll
> +
> +Device Configuration
> +====================
> +
> +The PCI MMIO Bridge appears as a standard PCI device:
> +
> +- **Vendor ID**: 0x1b36 (Red Hat/QEMU)
> +- **Device ID**: 0x0015 (PCI MMIO Bridge)
> +- **Class**: 0x08/0x80 (System/Other)
> +
> +Basic Usage
> +-----------
> +
> +.. code-block:: console
> +
> +   qemu-system-x86_64 \
> +       -machine q35 \
> +       -device pci-mmio-bridge,id=mmio-bridge
> +
> +This creates a bridge with defaults:
> +
> +- Shadow GPA: 0x80000000
> +- Shadow size: 4096 bytes
> +- Polling interval: 1ms
> +
> +Custom Configuration
> +---------------------
> +
> +.. code-block:: console
> +
> +   qemu-system-x86_64 \
> +       -machine q35 \
> +       -device pci-mmio-bridge,id=mmio-bridge,\
> +               shadow-gpa=0x90000000,\
> +               shadow-size=8192,\
> +               poll-interval-ns=500000
> +
> +Properties:
> +
> +- ``shadow-gpa``: Guest physical address for buffer (0 = auto, default:
> +  0x80000000)
> +- ``shadow-size``: Buffer size in bytes (default: 4096, min: 4096)
> +- ``poll-interval-ns``: Polling interval in nanoseconds (default:
> +  1000000)
> +- ``enabled``: Enable/disable bridge (default: true)
> +- ``addr``: PCI slot address (e.g., ``addr=5.0`` for slot 5)
> +
> +Guest Software Interface
> +========================
> +
> +Guest drivers can read the vendor-specific config space to find the GPA of
> +the shadow buffer:
> +
> +.. code-block:: c
> +
> +   #define PCI_MMIO_BRIDGE_CAP_OFFSET  0x40
> +   #define PCI_MMIO_BRIDGE_CAP_GPA_LO  0x00
> +   #define PCI_MMIO_BRIDGE_CAP_GPA_HI  0x04
> +   #define PCI_MMIO_BRIDGE_CAP_SIZE    0x08
> +   #define PCI_MMIO_BRIDGE_CAP_DEPTH   0x0C
> +
> +   /* Read shadow buffer GPA */
> +   uint32_t gpa_lo = pci_read_config_dword(pdev,
> +                                          PCI_MMIO_BRIDGE_CAP_OFFSET + 0);
> +   uint32_t gpa_hi = pci_read_config_dword(pdev,
> +                                          PCI_MMIO_BRIDGE_CAP_OFFSET + 4);
> +   uint64_t shadow_gpa = ((uint64_t)gpa_hi << 32) | gpa_lo;
> +
> +   /* Read buffer size and queue depth */
> +   uint32_t shadow_size = pci_read_config_dword(pdev,
> +                                                PCI_MMIO_BRIDGE_CAP_OFFSET + 8);
> +   uint32_t queue_depth = pci_read_config_dword(pdev,
> +                                                PCI_MMIO_BRIDGE_CAP_OFFSET + 12);
> +
> +Linux Kernel Driver Example
> +---------------------------
> +
> +Example PCI driver that discovers and uses the bridge:
> +
> +.. code-block:: c
> +
> +   #include <linux/pci.h>
> +   #include <linux/module.h>
> +   #include <linux/io.h>
> +
> +   #define PCI_VENDOR_ID_REDHAT_QEMU  0x1b36
> +   #define PCI_DEVICE_ID_REDHAT_MMIO_BRIDGE  0x0015
> +
> +   /* Config space offsets */
> +   #define CAP_OFFSET  0x40
> +   #define CAP_GPA_LO  0x00
> +   #define CAP_GPA_HI  0x04
> +   #define CAP_SIZE    0x08
> +   #define CAP_DEPTH   0x0C
> +
> +   struct mmio_bridge_dev {
> +       struct pci_dev *pdev;
> +       void __iomem *shadow_buf;
> +       uint64_t shadow_gpa;
> +       uint32_t shadow_size;
> +       uint32_t queue_depth;
> +   };
> +
> +   static int mmio_bridge_probe(struct pci_dev *pdev,
> +                                const struct pci_device_id *id)
> +   {
> +       struct mmio_bridge_dev *dev;
> +       uint32_t gpa_lo, gpa_hi;
> +       int err;
> +
> +       dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
> +       if (!dev)
> +           return -ENOMEM;
> +
> +       dev->pdev = pdev;
> +
> +       err = pci_enable_device(pdev);
> +       if (err)
> +           return err;
> +
> +       /* Read shadow buffer location from config space */
> +       pci_read_config_dword(pdev, CAP_OFFSET + CAP_GPA_LO, &gpa_lo);
> +       pci_read_config_dword(pdev, CAP_OFFSET + CAP_GPA_HI, &gpa_hi);
> +       pci_read_config_dword(pdev, CAP_OFFSET + CAP_SIZE, &dev->shadow_size);
> +       pci_read_config_dword(pdev, CAP_OFFSET + CAP_DEPTH, &dev->queue_depth);
> +
> +       dev->shadow_gpa = ((uint64_t)gpa_hi << 32) | gpa_lo;
> +
> +       pr_info("PCI MMIO Bridge: GPA=0x%llx size=%u depth=%u\n",
> +               dev->shadow_gpa, dev->shadow_size, dev->queue_depth);
> +
> +       /* Map shadow buffer (guest RAM, not MMIO) */
> +       dev->shadow_buf = ioremap(dev->shadow_gpa, dev->shadow_size);
> +       if (!dev->shadow_buf) {
> +           err = -ENOMEM;
> +           goto err_disable;
> +       }
> +
> +       pci_set_drvdata(pdev, dev);
> +
> +       return 0;
> +
> +   err_disable:
> +       pci_disable_device(pdev);
> +       return err;
> +   }
> +
> +   static void mmio_bridge_remove(struct pci_dev *pdev)
> +   {
> +       struct mmio_bridge_dev *dev = pci_get_drvdata(pdev);
> +
> +       if (dev->shadow_buf)
> +           iounmap(dev->shadow_buf);
> +
> +       pci_disable_device(pdev);
> +   }
> +
> +   static const struct pci_device_id mmio_bridge_ids[] = {
> +       { PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QEMU,
> +                    PCI_DEVICE_ID_MMIO_BRIDGE) },
> +       { 0, }
> +   };
> +   MODULE_DEVICE_TABLE(pci, mmio_bridge_ids);
> +
> +   static struct pci_driver mmio_bridge_driver = {
> +       .name       = "pci-mmio-bridge",
> +       .id_table   = mmio_bridge_ids,
> +       .probe      = mmio_bridge_probe,
> +       .remove     = mmio_bridge_remove,
> +   };
> +
> +   module_pci_driver(mmio_bridge_driver);
> +   MODULE_LICENSE("GPL");
> +
> +Submitting Commands
> +-------------------
> +
> +Example code for writing to a PCI device's BAR:
> +
> +.. code-block:: c
> +
> +   #include <linux/io.h>
> +
> +   volatile struct pci_mmio_bridge_ring_meta *meta;
> +   volatile struct pci_mmio_bridge_command *cmds;
> +
> +   void init_bridge(void __iomem *shadow_buf)
> +   {
> +       meta = (struct pci_mmio_bridge_ring_meta *)shadow_buf;
> +       cmds = (struct pci_mmio_bridge_command *)(shadow_buf +
> +                                          sizeof(*meta));
> +
> +       /* Verify queue is initialized */
> +       if (meta->queue_depth == 0) {
> +           pr_err("PCI MMIO bridge not available\n");
> +           return;
> +       }
> +       pr_info("Bridge ready: %u slots\n",
> +               meta->queue_depth);
> +   }
> +
> +   int pci_mmio_write_bar(u16 bdf, u8 bar, u32 offset,
> +                          u32 value, u8 size)
> +   {
> +       u32 slot = meta->producer_idx % meta->queue_depth;
> +       struct pci_mmio_bridge_command cmd = {
> +           .target_bdf = bdf,
> +           .target_bar = bar,
> +           .offset = offset,
> +           .value = value,
> +           .command = 1,  /* WRITE */
> +           .size = size,
> +           .status = 0,   /* PENDING */
> +       };
> +
> +       /* Write command to queue */
> +       cmds[slot] = cmd;
> +       wmb();
> +
> +       /* Update producer index */
> +       meta->producer_idx++;
> +
> +       /* Poll for completion (or use interrupt) */
> +       while (cmds[slot].status == 0)
> +           cpu_relax();
> +
> +       return (cmds[slot].status == 1) ? 0 : -EIO;
> +   }
> diff --git a/hw/pci/meson.build b/hw/pci/meson.build
> index b9c34b2acf..670645921f 100644
> --- a/hw/pci/meson.build
> +++ b/hw/pci/meson.build
> @@ -6,6 +6,7 @@ pci_ss.add(files(
>    'pci_bridge.c',
>    'pci_host.c',
>    'pci-hmp-cmds.c',
> +  'pci-mmio-bridge.c',
>    'pci-qmp-cmds.c',
>    'pcie_sriov.c',
>    'shpc.c',
> diff --git a/hw/pci/pci-mmio-bridge.c b/hw/pci/pci-mmio-bridge.c
> new file mode 100644
> index 0000000000..a6cdf81885
> --- /dev/null
> +++ b/hw/pci/pci-mmio-bridge.c
> @@ -0,0 +1,568 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * QEMU PCI MMIO Bridge Implementation
> + *
> + * Provides PCI device-to-device MMIO capability via a command queue.
> + *
> + * Copyright (c) 2025 Stephen Bates <sbates@raithlin.com>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/memalign.h"
> +#include "qemu/main-loop.h"
> +#include "hw/pci/pci-mmio-bridge.h"
> +#include "hw/pci/pci.h"
> +#include "hw/pci/pci_device.h"
> +#include "hw/pci/pci_bus.h"
> +#include "system/address-spaces.h"
> +#include "qemu/timer.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "trace.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/resettable.h"
> +#include "qemu/module.h"
> +#include "exec/target_page.h"
> +
> +/* Default polling interval: 1ms */
> +#define DEFAULT_POLL_INTERVAL_NS (1000 * 1000)
> +
> +/* Helper: Extract bus number from BDF */
> +static inline uint8_t bdf_to_bus(uint16_t bdf)
> +{
> +    return (bdf >> 8) & 0xFF;
> +}
> +
> +/* Helper: Extract devfn from BDF */
> +static inline uint8_t bdf_to_devfn(uint16_t bdf)
> +{
> +    return bdf & 0xFF;
> +}
> +
> +/*
> + * Find PCI device by BDF
> + *
> + * Searches the configured PCI bus for a device matching the given BDF.
> + * Returns NULL if not found.
> + */
> +static PCIDevice *pci_mmio_bridge_find_device(PCIMMIOBridge *bridge,
> +                                              uint16_t bdf)
> +{
> +    uint8_t bus_num = bdf_to_bus(bdf);
> +    uint8_t devfn = bdf_to_devfn(bdf);
> +    PCIDevice *dev;
> +
> +    if (!bridge->pci_bus) {
> +        return NULL;
> +    }
> +
> +    /* For now, only support bus 0 (main PCI bus) */
> +    if (bus_num != 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "pci-mmio-bridge: Multi-bus not yet supported (BDF %04x)\n",
> +                      bdf);
> +        return NULL;
> +    }
> +
> +    dev = bridge->pci_bus->devices[devfn];
> +    if (!dev) {
> +        trace_pci_mmio_bridge_device_not_found(bdf);
> +    }
> +
> +    return dev;
> +}
> +
> +/*
> + * Execute a single MMIO command
> + *
> + * Dispatches the command to the appropriate target device's MMIO handler.
> + */
> +static void pci_mmio_bridge_execute_command(
> +    PCIMMIOBridge *bridge, struct pci_mmio_bridge_command *cmd)
> +{
> +    PCIDevice *target;
> +    uint64_t value = 0;
> +    MemTxResult result;
> +
> +    /* Validate command type */
> +    switch (cmd->command) {
> +    case PCI_MMIO_BRIDGE_CMD_WRITE:
> +    case PCI_MMIO_BRIDGE_CMD_READ:
> +        break;
> +    default:
> +        qatomic_set(&cmd->status, PCI_MMIO_BRIDGE_STATUS_ERROR);
> +        smp_wmb();  /* Ensure status visible before return */
> +        trace_pci_mmio_bridge_invalid_command(cmd->command);
> +        return;
> +    }
> +
> +    /* Find target device */
> +    target = pci_mmio_bridge_find_device(bridge, cmd->target_bdf);
> +    if (!target) {
> +        qatomic_set(&cmd->status, PCI_MMIO_BRIDGE_STATUS_ERROR);
> +        smp_wmb();  /* Ensure status is visible to guest */
> +        trace_pci_mmio_bridge_device_not_found(cmd->target_bdf);
> +        return;
> +    }
> +
> +    /* Validate BAR number */
> +    if (cmd->target_bar >= PCI_NUM_REGIONS) {
> +        qatomic_set(&cmd->status, PCI_MMIO_BRIDGE_STATUS_ERROR);
> +        smp_wmb();  /* Ensure status visible before return */
> +        trace_pci_mmio_bridge_invalid_bar(cmd->target_bdf, cmd->target_bar);
> +        return;
> +    }
> +
> +    /* Get target BAR address */
> +    hwaddr bar_addr = pci_get_bar_addr(target, cmd->target_bar);
> +    if (bar_addr == PCI_BAR_UNMAPPED) {
> +        qatomic_set(&cmd->status, PCI_MMIO_BRIDGE_STATUS_ERROR);
> +        smp_wmb();  /* Ensure status visible to guest */
> +        trace_pci_mmio_bridge_bar_not_mapped(cmd->target_bdf, cmd->target_bar);
> +        return;
> +    }
> +
> +    /* Validate size */
> +    if (cmd->size != 1 && cmd->size != 2 && cmd->size != 4 && cmd->size != 8) {
> +        qatomic_set(&cmd->status, PCI_MMIO_BRIDGE_STATUS_ERROR);
> +        smp_wmb();  /* Ensure status visible to guest */
> +        trace_pci_mmio_bridge_invalid_size(cmd->size);
> +        return;
> +    }
> +
> +    /* Calculate full MMIO address (BAR base + offset) */
> +    hwaddr mmio_addr = bar_addr + cmd->offset;
> +
> +    /* Execute the operation using address_space to access MMIO space */
> +    switch (cmd->command) {
> +    case PCI_MMIO_BRIDGE_CMD_WRITE:
> +        result = address_space_write(&address_space_memory, mmio_addr,
> +                                      MEMTXATTRS_UNSPECIFIED,
> +                                      &cmd->value, cmd->size);
> +        if (result == MEMTX_OK) {
> +            qatomic_set(&cmd->status, PCI_MMIO_BRIDGE_STATUS_COMPLETE);
> +            smp_wmb();  /* Ensure status visible to guest */
> +            bridge->total_writes++;
> +            trace_pci_mmio_bridge_write(cmd->target_bdf, cmd->target_bar,
> +                                        cmd->offset, cmd->value, cmd->size);
> +        } else {
> +            qatomic_set(&cmd->status, PCI_MMIO_BRIDGE_STATUS_ERROR);
> +            smp_wmb();  /* Ensure status visible to guest */
> +            bridge->total_errors++;
> +            trace_pci_mmio_bridge_write_failed(cmd->target_bdf, cmd->target_bar,
> +                                               cmd->offset, result);
> +        }
> +        break;
> +
> +    case PCI_MMIO_BRIDGE_CMD_READ:
> +        result = address_space_read(&address_space_memory, mmio_addr,
> +                                     MEMTXATTRS_UNSPECIFIED,
> +                                     &value, cmd->size);
> +        if (result == MEMTX_OK) {
> +            cmd->value = value;
> +            smp_wmb();  /* Ensure value is visible before status update */
> +            qatomic_set(&cmd->status, PCI_MMIO_BRIDGE_STATUS_COMPLETE);
> +            smp_wmb();  /* Ensure status visible to guest */
> +            bridge->total_reads++;
> +            trace_pci_mmio_bridge_read(cmd->target_bdf, cmd->target_bar,
> +                                       cmd->offset, value, cmd->size);
> +        } else {
> +            qatomic_set(&cmd->status, PCI_MMIO_BRIDGE_STATUS_ERROR);
> +            smp_wmb();  /* Ensure status visible to guest */
> +            bridge->total_errors++;
> +            trace_pci_mmio_bridge_read_failed(cmd->target_bdf, cmd->target_bar,
> +                                              cmd->offset, result);
> +        }
> +        break;
> +    }
> +
> +    /* Ensure status is visible */
> +    smp_wmb();
> +}
> +
> +/*
> + * Polling timer callback
> + *
> + * Checks shadow buffer for new commands and processes them.
> + * This is exported for use by the PCI device wrapper.
> + */
> +void pci_mmio_bridge_poll(void *opaque)
> +{
> +    PCIMMIOBridge *bridge = opaque;
> +    uint32_t producer_idx, consumer_idx;
> +    uint32_t commands_processed = 0;
> +
> +    if (!bridge->enabled) {
> +        goto reschedule;
> +    }
> +
> +    bridge->total_polls++;
> +
> +    /*
> +     * Read metadata from guest memory using address_space_read. This ensures
> +     * we see any VFIO device writes and not cached copies.
> +     */
> +    struct pci_mmio_bridge_ring_meta metadata;
> +    address_space_read(&address_space_memory, bridge->shadow_gpa,
> +                       MEMTXATTRS_UNSPECIFIED, &metadata, sizeof(metadata));
> +
> +    producer_idx = metadata.producer_idx;
> +    consumer_idx = bridge->head;
> +
> +    /* Process all pending commands */
> +    while (consumer_idx != producer_idx) {
> +        uint32_t slot = consumer_idx % bridge->queue_depth;
> +        hwaddr cmd_addr = bridge->shadow_gpa +
> +                          sizeof(struct pci_mmio_bridge_ring_meta) +
> +                          (slot * sizeof(struct pci_mmio_bridge_command));
> +
> +        /* Read command from guest memory to see GPU writes */
> +        struct pci_mmio_bridge_command cmd;
> +        address_space_read(&address_space_memory, cmd_addr,
> +                           MEMTXATTRS_UNSPECIFIED, &cmd, sizeof(cmd));
> +
> +        if (cmd.status == PCI_MMIO_BRIDGE_STATUS_PENDING) {
> +            pci_mmio_bridge_execute_command(bridge, &cmd);
> +
> +            /* Write back status using address_space_write */
> +            address_space_write(&address_space_memory, cmd_addr,
> +                                MEMTXATTRS_UNSPECIFIED, &cmd, sizeof(cmd));
> +
> +            bridge->total_commands++;
> +            commands_processed++;
> +        }
> +
> +        consumer_idx++;
> +    }
> +
> +    /* Update our head position */
> +    bridge->head = consumer_idx;
> +
> +    if (commands_processed > 0) {
> +        trace_pci_mmio_bridge_poll_processed(commands_processed);
> +    }
> +
> +reschedule:
> +    /* Reschedule for next poll cycle */
> +    if (bridge->poll_timer) {
> +        timer_mod(bridge->poll_timer,
> +                  qemu_clock_get_ns(QEMU_CLOCK_REALTIME) +
> +                  bridge->poll_interval_ns);
> +    }
> +}
> +
> +/*
> + * Initialize PCI MMIO Bridge
> + */
> +PCIMMIOBridge *pci_mmio_bridge_init(PCIBus *pci_bus,
> +                                         hwaddr gpa, uint32_t size,
> +                                         uint64_t poll_interval_ns,
> +                                         Error **errp)
> +{
> +    PCIMMIOBridge *bridge;
> +    struct pci_mmio_bridge_ring_meta *meta;
> +
> +    /* Validate parameters */
> +    if (!pci_bus) {
> +        error_setg(errp, "PCI bus must be provided");
> +        return NULL;
> +    }
> +
> +    if (size < TARGET_PAGE_SIZE) {
> +        error_setg(errp, "Shadow buffer size must be at least 4096 bytes");
> +        return NULL;
> +    }
> +
> +    if (!QEMU_IS_ALIGNED(gpa, TARGET_PAGE_SIZE)) {
> +        error_setg(errp, "Shadow buffer GPA must be page-aligned");
> +        return NULL;
> +    }
> +
> +    /* Allocate bridge state */
> +    bridge = g_new0(PCIMMIOBridge, 1);
> +
> +    /* Store PCI bus reference */
> +    bridge->pci_bus = pci_bus;
> +
> +    bridge->shadow_gpa = gpa;
> +    bridge->shadow_size = size;
> +
> +    /* Allocate guest RAM for shadow buffer with unique name */
> +    char *mr_name = g_strdup_printf("pci-mmio-bridge-shadow@0x%"PRIx64, gpa);
> +    memory_region_init_ram(&bridge->shadow_mr, NULL, mr_name, size,
> +                           &error_fatal);
> +    g_free(mr_name);
> +
> +    /* Add to system memory at specified GPA */
> +    memory_region_add_subregion(get_system_memory(), gpa, &bridge->shadow_mr);
> +
> +    /* Get host virtual address for direct access */
> +    bridge->shadow_hva = memory_region_get_ram_ptr(&bridge->shadow_mr);
> +    memset(bridge->shadow_hva, 0, size);
> +
> +    /* Calculate queue depth (reserve first slot for metadata) */
> +    bridge->queue_depth = (size / sizeof(struct pci_mmio_bridge_command)) - 1;
> +
> +    /* Initialize ring buffer metadata in first slot */
> +    meta = (struct pci_mmio_bridge_ring_meta *)bridge->shadow_hva;
> +    meta->producer_idx = 0;
> +    meta->consumer_idx = 0;
> +    meta->queue_depth = bridge->queue_depth;
> +    meta->reserved = 0;
> +
> +    /* Initialize polling infrastructure */
> +    bridge->poll_interval_ns = poll_interval_ns ? poll_interval_ns :
> +                                                   DEFAULT_POLL_INTERVAL_NS;
> +
> +    /* Use bottom-half for immediate processing (for qtest) */
> +    bridge->poll_bh = qemu_bh_new(pci_mmio_bridge_poll, bridge);
> +
> +    /* Also create timer for periodic polling when BH isn't triggered */
> +    bridge->poll_timer = timer_new_ns(QEMU_CLOCK_REALTIME,
> +                                      pci_mmio_bridge_poll, bridge);
> +    bridge->enabled = true;
> +
> +    /* Start periodic polling */
> +    timer_mod(bridge->poll_timer,
> +              qemu_clock_get_ns(QEMU_CLOCK_REALTIME) +
> +              bridge->poll_interval_ns);
> +
> +    trace_pci_mmio_bridge_init(gpa, size, bridge->queue_depth,
> +                               bridge->poll_interval_ns);
> +
> +    return bridge;
> +}
> +
> +/*
> + * Cleanup PCI MMIO Bridge
> + */
> +void pci_mmio_bridge_cleanup(PCIMMIOBridge *bridge)
> +{
> +    if (!bridge) {
> +        return;
> +    }
> +
> +    trace_pci_mmio_bridge_cleanup(bridge->total_commands, bridge->total_writes,
> +                                  bridge->total_reads, bridge->total_errors);
> +
> +    /* Stop polling */
> +    if (bridge->poll_timer) {
> +        timer_free(bridge->poll_timer);
> +    }
> +    if (bridge->poll_bh) {
> +        qemu_bh_delete(bridge->poll_bh);
> +    }
> +
> +    /* Remove from system memory and cleanup */
> +    memory_region_del_subregion(get_system_memory(), &bridge->shadow_mr);
> +    object_unparent(OBJECT(&bridge->shadow_mr));
> +
> +    /* Free backing memory */
> +    qemu_vfree(bridge->shadow_hva);
> +
> +    g_free(bridge);
> +}
> +
> +/*
> + * Enable/disable bridge
> + */
> +void pci_mmio_bridge_set_enabled(PCIMMIOBridge *bridge, bool enabled)
> +{
> +    if (bridge) {
> +        bridge->enabled = enabled;
> +        trace_pci_mmio_bridge_set_enabled(enabled);
> +    }
> +}
> +
> +/*
> + * Get statistics
> + */
> +void pci_mmio_bridge_get_stats(PCIMMIOBridge *bridge,
> +                               uint64_t *total_commands,
> +                               uint64_t *total_writes,
> +                               uint64_t *total_reads,
> +                               uint64_t *total_errors)
> +{
> +    if (bridge) {
> +        if (total_commands) {
> +            *total_commands = bridge->total_commands;
> +        }
> +        if (total_writes) {
> +            *total_writes = bridge->total_writes;
> +        }
> +        if (total_reads) {
> +            *total_reads = bridge->total_reads;
> +        }
> +        if (total_errors) {
> +            *total_errors = bridge->total_errors;
> +        }
> +    }
> +}
> +
> +/*
> + * Manually trigger one poll cycle
> + *
> + * This is primarily for testing - it processes pending commands immediately
> + * without waiting for the timer.
> + */
> +void pci_mmio_bridge_poll_once(PCIMMIOBridge *bridge)
> +{
> +    if (bridge) {
> +        pci_mmio_bridge_poll(bridge);
> +    }
> +}
> +
> +/*
> + * PCI Device Wrapper
> + */
> +
> +static void pci_mmio_bridge_pci_realize(PCIDevice *pci_dev, Error **errp)
> +{
> +    PCIMMIOBridge_NEW *s = PCI_MMIO_BRIDGE(pci_dev);
> +    uint8_t *pci_conf = pci_dev->config;
> +    Error *local_err = NULL;
> +
> +    /* Set PCI config space */
> +    pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_REDHAT);
> +    pci_config_set_device_id(pci_conf, PCI_DEVICE_ID_REDHAT_MMIO_BRIDGE);
> +    pci_config_set_class(pci_conf, PCI_CLASS_SYSTEM_OTHER);
> +    pci_config_set_revision(pci_conf, 0x01);
> +
> +    /* Subsystem vendor/device ID */
> +    pci_set_word(pci_conf + PCI_SUBSYSTEM_VENDOR_ID,
> +                 PCI_VENDOR_ID_REDHAT);
> +    pci_set_word(pci_conf + PCI_SUBSYSTEM_ID, 0x1100);
> +
> +    /* Validate shadow_size */
> +    if (s->shadow_size < TARGET_PAGE_SIZE) {
> +        error_setg(errp, "shadow-size must be at least %d bytes",
> +            TARGET_PAGE_SIZE);
> +        return;
> +    }
> +
> +    /* Default GPA if not specified (below 4GB for 32-bit compatibility) */
> +    if (s->shadow_gpa == 0) {
> +        s->shadow_gpa = 0x80000000ULL;  /* Default: 2GB mark */
> +    }
> +
> +    /* Use existing bridge initialization (creates guest RAM) */
> +    s->bridge = pci_mmio_bridge_init(pci_get_bus(pci_dev),
> +                                     s->shadow_gpa,
> +                                     s->shadow_size,
> +                                     s->poll_interval_ns,
> +                                     &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    s->bridge->enabled = s->enabled;
> +
> +    /* Expose shadow buffer GPA and size via vendor-specific config space */
> +    pci_set_long(pci_conf + PCI_MMIO_BRIDGE_CAP_OFFSET +
> +                 PCI_MMIO_BRIDGE_CAP_GPA_LO,
> +                 (uint32_t)(s->shadow_gpa & 0xFFFFFFFF));
> +    pci_set_long(pci_conf + PCI_MMIO_BRIDGE_CAP_OFFSET +
> +                 PCI_MMIO_BRIDGE_CAP_GPA_HI,
> +                 (uint32_t)(s->shadow_gpa >> 32));
> +    pci_set_long(pci_conf + PCI_MMIO_BRIDGE_CAP_OFFSET +
> +                 PCI_MMIO_BRIDGE_CAP_SIZE,
> +                 s->shadow_size);
> +    pci_set_long(pci_conf + PCI_MMIO_BRIDGE_CAP_OFFSET +
> +                 PCI_MMIO_BRIDGE_CAP_DEPTH,
> +                 s->bridge->queue_depth);
> +
> +    trace_pci_mmio_bridge_realize(s->shadow_gpa, s->shadow_size,
> +                                      s->bridge->queue_depth);
> +}
> +
> +static void pci_mmio_bridge_pci_exit(PCIDevice *pci_dev)
> +{
> +    PCIMMIOBridge_NEW *s = PCI_MMIO_BRIDGE(pci_dev);
> +
> +    if (!s->bridge) {
> +        return;
> +    }
> +
> +    trace_pci_mmio_bridge_exit(s->bridge->total_commands,
> +                                   s->bridge->total_writes,
> +                                   s->bridge->total_reads,
> +                                   s->bridge->total_errors);
> +
> +    /* Use bridge cleanup (handles guest RAM removal) */
> +    pci_mmio_bridge_cleanup(s->bridge);
> +    s->bridge = NULL;
> +}
> +
> +static void pci_mmio_bridge_pci_reset(Object *obj, ResetType type)
> +{
> +    PCIMMIOBridge_NEW *s = PCI_MMIO_BRIDGE(obj);
> +    struct pci_mmio_bridge_ring_meta *meta;
> +
> +    if (!s->bridge || !s->bridge->shadow_hva) {
> +        return;
> +    }
> +
> +    /* Reset ring buffer state in guest RAM */
> +    meta = (struct pci_mmio_bridge_ring_meta *)s->bridge->shadow_hva;
> +    meta->producer_idx = 0;
> +    meta->consumer_idx = 0;
> +    s->bridge->head = 0;
> +
> +    /* Reset statistics */
> +    s->bridge->total_commands = 0;
> +    s->bridge->total_writes = 0;
> +    s->bridge->total_reads = 0;
> +    s->bridge->total_errors = 0;
> +    s->bridge->total_polls = 0;
> +
> +    trace_pci_mmio_bridge_reset();
> +}
> +
> +static const Property pci_mmio_bridge_pci_properties[] = {
> +    DEFINE_PROP_UINT64("shadow-gpa", PCIMMIOBridge_NEW, shadow_gpa, 0),
> +    DEFINE_PROP_UINT32("shadow-size", PCIMMIOBridge_NEW, shadow_size,
> +                       4096),
> +    DEFINE_PROP_UINT64("poll-interval-ns", PCIMMIOBridge_NEW,
> +                       poll_interval_ns, 1000000),
> +    DEFINE_PROP_BOOL("enabled", PCIMMIOBridge_NEW, enabled, true)
> +};
> +
> +static void pci_mmio_bridge_pci_class_init(ObjectClass *klass,
> +                                            const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
> +
> +    k->realize = pci_mmio_bridge_pci_realize;
> +    k->exit = pci_mmio_bridge_pci_exit;
> +    k->vendor_id = PCI_VENDOR_ID_REDHAT;
> +    k->device_id = PCI_DEVICE_ID_REDHAT_MMIO_BRIDGE;
> +    k->class_id = PCI_CLASS_SYSTEM_OTHER;
> +    k->revision = 0x01;
> +
> +    dc->desc = "PCI MMIO Bridge (device-to-device MMIO proxy)";
> +    rc->phases.hold = pci_mmio_bridge_pci_reset;
> +    device_class_set_props(dc, pci_mmio_bridge_pci_properties);
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +}
> +
> +static const TypeInfo pci_mmio_bridge_pci_info = {
> +    .name          = TYPE_PCI_MMIO_BRIDGE,
> +    .parent        = TYPE_PCI_DEVICE,
> +    .instance_size = sizeof(PCIMMIOBridge_NEW),
> +    .class_init    = pci_mmio_bridge_pci_class_init,
> +    .interfaces = (const InterfaceInfo[]) {
> +        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +        { }
> +    }
> +};
> +
> +static void pci_mmio_bridge_pci_register_types(void)
> +{
> +    type_register_static(&pci_mmio_bridge_pci_info);
> +}
> +
> +type_init(pci_mmio_bridge_pci_register_types)
> +
> diff --git a/hw/pci/trace-events b/hw/pci/trace-events
> index 02c80d3ec8..0919ec0a68 100644
> --- a/hw/pci/trace-events
> +++ b/hw/pci/trace-events
> @@ -28,3 +28,21 @@ pcie_cap_slot_write_config(const char *parent, const char *child, const char *pd
>  
>  # shpc.c
>  shpc_slot_command(const char *parent, int pci_slot, const char *child, const char *old_pic, const char *new_pic, const char *old_aic, const char *new_aic, const char *old_state, const char *new_state) "%s[%d] > %s: pic: %s->%s, aic: %s->%s, state: %s->%s"
> +
> +# pci-mmio-bridge.c
> +pci_mmio_bridge_init(uint64_t gpa, uint32_t size, uint32_t queue_depth, uint64_t poll_interval_ns) "gpa=0x%"PRIx64" size=%u queue_depth=%u poll_interval=%"PRIu64"ns"
> +pci_mmio_bridge_cleanup(uint64_t total_commands, uint64_t total_writes, uint64_t total_reads, uint64_t total_errors) "total_commands=%"PRIu64" writes=%"PRIu64" reads=%"PRIu64" errors=%"PRIu64
> +pci_mmio_bridge_set_enabled(bool enabled) "enabled=%d"
> +pci_mmio_bridge_write(uint16_t bdf, uint8_t bar, uint32_t offset, uint64_t value, uint8_t size) "BDF=0x%04x BAR=%u offset=0x%x value=0x%"PRIx64" size=%u"
> +pci_mmio_bridge_read(uint16_t bdf, uint8_t bar, uint32_t offset, uint64_t value, uint8_t size) "BDF=0x%04x BAR=%u offset=0x%x value=0x%"PRIx64" size=%u"
> +pci_mmio_bridge_write_failed(uint16_t bdf, uint8_t bar, uint32_t offset, int result) "BDF=0x%04x BAR=%u offset=0x%x result=%d"
> +pci_mmio_bridge_read_failed(uint16_t bdf, uint8_t bar, uint32_t offset, int result) "BDF=0x%04x BAR=%u offset=0x%x result=%d"
> +pci_mmio_bridge_device_not_found(uint16_t bdf) "BDF=0x%04x not found"
> +pci_mmio_bridge_invalid_bar(uint16_t bdf, uint8_t bar) "BDF=0x%04x invalid BAR=%u"
> +pci_mmio_bridge_bar_not_mapped(uint16_t bdf, uint8_t bar) "BDF=0x%04x BAR=%u not mapped"
> +pci_mmio_bridge_invalid_command(uint8_t command) "invalid command=%u"
> +pci_mmio_bridge_invalid_size(uint8_t size) "invalid size=%u"
> +pci_mmio_bridge_poll_processed(uint32_t count) "processed %u commands"
> +pci_mmio_bridge_realize(uint64_t gpa, uint32_t size, uint32_t queue_depth) "shadow_gpa=0x%"PRIx64" size=%u queue_depth=%u"
> +pci_mmio_bridge_exit(uint64_t commands, uint64_t writes, uint64_t reads, uint64_t errors) "commands=%"PRIu64" writes=%"PRIu64" reads=%"PRIu64" errors=%"PRIu64
> +pci_mmio_bridge_reset(void) "resetting bridge state"
> diff --git a/include/hw/pci/pci-mmio-bridge.h b/include/hw/pci/pci-mmio-bridge.h
> new file mode 100644
> index 0000000000..38d852cb08
> --- /dev/null
> +++ b/include/hw/pci/pci-mmio-bridge.h
> @@ -0,0 +1,162 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * QEMU PCI MMIO Bridge
> + *
> + * Copyright (c) 2025 Stephen Bates <sbates@raithlin.com>
> + */
> +
> +#ifndef HW_PCI_MMIO_BRIDGE_H
> +#define HW_PCI_MMIO_BRIDGE_H
> +
> +#include "hw/pci/pci.h"
> +#include "hw/pci/pci_device.h"
> +#include "qom/object.h"
> +
> +/*
> + * MMIO Bridge Command Packet Structure
> + *
> + */
> +struct pci_mmio_bridge_command {
> +    uint16_t target_bdf;      /* Bus:Device:Function (bus|devfn) */
> +    uint8_t  target_bar;      /* Which BAR on target device (0-5) */
> +    uint8_t  reserved1;
> +    uint32_t offset;          /* Offset within BAR */
> +
> +    uint64_t value;           /* Value to write, or returned value for read */
> +
> +    uint8_t  command;         /* Command type (see CMD_* below) */
> +    uint8_t  size;            /* Transfer size: 1, 2, 4, or 8 bytes */
> +    uint8_t  status;          /* Status (see STATUS_* below) */
> +    uint8_t  reserved2;
> +    uint32_t sequence;        /* Sequence number for ordering */
> +} QEMU_PACKED;
> +
> +/* Command types */
> +#define PCI_MMIO_BRIDGE_CMD_NOP    0
> +#define PCI_MMIO_BRIDGE_CMD_WRITE  1
> +#define PCI_MMIO_BRIDGE_CMD_READ   2
> +
> +/* Status codes */
> +#define PCI_MMIO_BRIDGE_STATUS_PENDING   0
> +#define PCI_MMIO_BRIDGE_STATUS_COMPLETE  1
> +#define PCI_MMIO_BRIDGE_STATUS_ERROR     2
> +
> +/* Ring buffer metadata (stored in first command slot) */
> +struct pci_mmio_bridge_ring_meta {
> +    uint32_t producer_idx;    /* Guest/device write index (tail) */
> +    uint32_t consumer_idx;    /* QEMU read index (head) */
> +    uint32_t queue_depth;     /* Total number of command slots */
> +    uint32_t reserved;
> +} QEMU_PACKED;
> +
> +/*
> + * PCI MMIO Bridge State
> + *
> + */
> +typedef struct PCIMMIOBridge {
> +    /* Shadow buffer (guest RAM for DMA access) */
> +    MemoryRegion shadow_mr;
> +    hwaddr shadow_gpa;        /* Guest physical address */
> +    void *shadow_hva;         /* Host virtual address for polling */
> +    uint32_t shadow_size;     /* Size in bytes */
> +
> +    /* PCI bus to search for devices */
> +    struct PCIBus *pci_bus;   /* Main PCI bus */
> +
> +    /* Ring buffer management */
> +    uint32_t queue_depth;     /* Number of command slots available */
> +    uint32_t head;            /* Consumer index (QEMU's position) */
> +
> +    /* Polling infrastructure */
> +    QEMUTimer *poll_timer;
> +    QEMUBH *poll_bh;
> +    uint64_t poll_interval_ns;
> +    bool enabled;
> +    bool use_bh;              /* Use BH instead of timer (for qtest) */
> +
> +    /* Statistics for monitoring/debugging */
> +    uint64_t total_commands;
> +    uint64_t total_writes;
> +    uint64_t total_reads;
> +    uint64_t total_errors;
> +    uint64_t total_polls;
> +} PCIMMIOBridge;
> +
> +/*
> + * Initialize the PCI MMIO bridge
> + *
> + * @pci_bus: PCI bus to monitor for devices
> + * @gpa: Guest physical address for shadow buffer (must be page-aligned)
> + * @size: Size of shadow buffer in bytes (must be >= 4096)
> + * @poll_interval_ns: Polling interval in nanoseconds (0 = default)
> + * @errp: Error pointer
> + *
> + * Returns: Pointer to bridge state on success, NULL on error
> + */
> +PCIMMIOBridge *pci_mmio_bridge_init(struct PCIBus *pci_bus,
> +                                         hwaddr gpa, uint32_t size,
> +                                         uint64_t poll_interval_ns,
> +                                         Error **errp);
> +
> +/*
> + * Cleanup the PCI MMIO bridge
> + */
> +void pci_mmio_bridge_cleanup(PCIMMIOBridge *bridge);
> +
> +/*
> + * Enable/disable the bridge
> + */
> +void pci_mmio_bridge_set_enabled(PCIMMIOBridge *bridge, bool enabled);
> +
> +/*
> + * Get bridge statistics (for QMP/monitor)
> + */
> +void pci_mmio_bridge_get_stats(PCIMMIOBridge *bridge,
> +                               uint64_t *total_commands,
> +                               uint64_t *total_writes,
> +                               uint64_t *total_reads,
> +                               uint64_t *total_errors);
> +
> +/*
> + * Manually trigger one poll cycle (for testing)
> + *
> + * This is useful in qtest environments where timers don't automatically fire.
> + */
> +void pci_mmio_bridge_poll_once(PCIMMIOBridge *bridge);
> +
> +/*
> + * Internal polling callback
> + */
> +void pci_mmio_bridge_poll(void *opaque);
> +
> +
> +/*
> + * PCI Device Interface
> + */
> +
> +/*
> + * Vendor-specific capability offsets in PCI config space
> + * These expose the shadow buffer GPA and size to guest drivers
> + */
> +#define PCI_MMIO_BRIDGE_CAP_OFFSET  0x40
> +#define PCI_MMIO_BRIDGE_CAP_GPA_LO  0x00  /* Lower 32 bits of GPA */
> +#define PCI_MMIO_BRIDGE_CAP_GPA_HI  0x04  /* Upper 32 bits of GPA */
> +#define PCI_MMIO_BRIDGE_CAP_SIZE    0x08  /* Buffer size */
> +#define PCI_MMIO_BRIDGE_CAP_DEPTH   0x0C  /* Queue depth */
> +
> +#define TYPE_PCI_MMIO_BRIDGE "pci-mmio-bridge"
> +OBJECT_DECLARE_SIMPLE_TYPE(PCIMMIOBridge_NEW, PCI_MMIO_BRIDGE)
> +
> +struct PCIMMIOBridge_NEW {
> +    PCIDevice parent_obj;
> +
> +    /* Core bridge state */
> +    PCIMMIOBridge *bridge;
> +
> +    /* Configuration properties */
> +    uint64_t shadow_gpa;       /* Guest physical address (0 = auto) */
> +    uint32_t shadow_size;      /* Size of shadow buffer */
> +    uint64_t poll_interval_ns; /* Polling interval */
> +    bool enabled;              /* Whether bridge is active */
> +};
> +#endif /* HW_PCI_MMIO_BRIDGE_H */
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 6b7d3ac8a3..d5c6e546a8 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -121,6 +121,7 @@ extern bool pci_available;
>  #define PCI_DEVICE_ID_REDHAT_ACPI_ERST   0x0012
>  #define PCI_DEVICE_ID_REDHAT_UFS         0x0013
>  #define PCI_DEVICE_ID_REDHAT_RISCV_IOMMU 0x0014
> +#define PCI_DEVICE_ID_REDHAT_MMIO_BRIDGE 0x0015
>  #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
>  
>  #define FMT_PCIBUS                      PRIx64
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 669d07c06b..718f2e0606 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -74,6 +74,7 @@ qtests_i386 = \
>    (config_all_devices.has_key('CONFIG_HDA') ? ['intel-hda-test'] : []) +                    \
>    (config_all_devices.has_key('CONFIG_I82801B11') ? ['i82801b11-test'] : []) +             \
>    (config_all_devices.has_key('CONFIG_IOH3420') ? ['ioh3420-test'] : []) +                  \
> +  ['pci-mmio-bridge-test'] +              \
>    (config_all_devices.has_key('CONFIG_LPC_ICH9') ? ['lpc-ich9-test'] : []) +              \
>    (config_all_devices.has_key('CONFIG_MC146818RTC') ? ['rtc-test'] : []) +                  \
>    (config_all_devices.has_key('CONFIG_USB_UHCI') ? ['usb-hcd-uhci-test'] : []) +            \
> diff --git a/tests/qtest/pci-mmio-bridge-test.c b/tests/qtest/pci-mmio-bridge-test.c
> new file mode 100644
> index 0000000000..ad795a2f7e
> --- /dev/null
> +++ b/tests/qtest/pci-mmio-bridge-test.c
> @@ -0,0 +1,417 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * QTest testcases for PCI MMIO Bridge (PCI Device)
> + *
> + * Copyright (c) 2025 Stephen Bates <sbates@raithlin.com>
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "libqos/pci.h"
> +#include "libqos/pci-pc.h"
> +#include "hw/pci/pci_regs.h"
> +#include "hw/pci/pci-mmio-bridge.h"
> +
> +/* Helper: Read shadow buffer GPA from PCI config space */
> +static uint64_t read_shadow_gpa(QPCIDevice *dev)
> +{
> +    uint32_t gpa_lo = qpci_config_readl(dev, PCI_MMIO_BRIDGE_CAP_OFFSET +
> +                                        PCI_MMIO_BRIDGE_CAP_GPA_LO);
> +    uint32_t gpa_hi = qpci_config_readl(dev, PCI_MMIO_BRIDGE_CAP_OFFSET +
> +                                        PCI_MMIO_BRIDGE_CAP_GPA_HI);
> +    return ((uint64_t)gpa_hi << 32) | gpa_lo;
> +}
> +
> +/* Helper: Read shadow buffer size from PCI config space */
> +static uint32_t read_shadow_size(QPCIDevice *dev)
> +{
> +    return qpci_config_readl(dev, PCI_MMIO_BRIDGE_CAP_OFFSET +
> +                            PCI_MMIO_BRIDGE_CAP_SIZE);
> +}
> +
> +/* Helper: Read queue depth from PCI config space */
> +static uint32_t read_queue_depth(QPCIDevice *dev)
> +{
> +    return qpci_config_readl(dev, PCI_MMIO_BRIDGE_CAP_OFFSET +
> +                            PCI_MMIO_BRIDGE_CAP_DEPTH);
> +}
> +
> +/* Helper: Find bridge device on PCI bus */
> +static QPCIDevice *find_pci_mmio_bridge(QPCIBus *bus)
> +{
> +    for (int devfn = 0; devfn < 256; devfn++) {
> +        QPCIDevice *dev = qpci_device_find(bus, devfn);
> +        if (dev) {
> +            uint16_t vid = qpci_config_readw(dev, PCI_VENDOR_ID);
> +            uint16_t did = qpci_config_readw(dev, PCI_DEVICE_ID);
> +            if (vid == PCI_VENDOR_ID_REDHAT &&
> +                did == PCI_DEVICE_ID_REDHAT_MMIO_BRIDGE) {
> +                return dev;
> +            }
> +            g_free(dev);
> +        }
> +    }
> +    return NULL;
> +}
> +
> +/* Helper: Find pci-testdev on PCI bus */
> +static QPCIDevice *find_pci_testdev(QPCIBus *bus)
> +{
> +    for (int devfn = 0; devfn < 256; devfn++) {
> +        QPCIDevice *dev = qpci_device_find(bus, devfn);
> +        if (dev) {
> +            uint16_t did = qpci_config_readw(dev, PCI_DEVICE_ID);
> +            if (did == 0x5050) {  /* pci-testdev device ID */
> +                return dev;
> +            }
> +            g_free(dev);
> +        }
> +    }
> +    return NULL;
> +}
> +
> +/* Test: Device discovery via PCI bus enumeration */
> +static void test_pci_device_discovery(void)
> +{
> +    QTestState *qts;
> +    QPCIBus *pcibus;
> +    QPCIDevice *dev;
> +    uint16_t vendor_id, device_id;
> +    uint8_t class_id;
> +
> +    qts = qtest_init("-machine q35 "
> +                     "-device pci-mmio-bridge,id=bridge0");
> +
> +    pcibus = qpci_new_pc(qts, NULL);
> +    g_assert_nonnull(pcibus);
> +
> +    /* Find the bridge device */
> +    dev = find_pci_mmio_bridge(pcibus);
> +    g_assert_nonnull(dev);
> +
> +    /* Verify PCI IDs */
> +    vendor_id = qpci_config_readw(dev, PCI_VENDOR_ID);
> +    device_id = qpci_config_readw(dev, PCI_DEVICE_ID);
> +    class_id = qpci_config_readb(dev, PCI_CLASS_DEVICE);
> +
> +    g_assert_cmpuint(vendor_id, ==, PCI_VENDOR_ID_REDHAT);
> +    g_assert_cmpuint(device_id, ==, PCI_DEVICE_ID_REDHAT_MMIO_BRIDGE);
> +    g_assert_cmpuint(class_id, ==, 0x80); /* PCI_CLASS_SYSTEM_OTHER */
> +
> +    g_free(dev);
> +    qpci_free_pc(pcibus);
> +    qtest_quit(qts);
> +}
> +
> +/* Test: Shadow buffer GPA is exposed via config space */
> +static void test_pci_shadow_gpa_access(void)
> +{
> +    QTestState *qts;
> +    QPCIBus *pcibus;
> +    QPCIDevice *dev;
> +    uint64_t shadow_gpa;
> +    uint32_t shadow_size, queue_depth;
> +    struct pci_mmio_bridge_ring_meta meta;
> +
> +    qts = qtest_init("-machine q35 "
> +                     "-device pci-mmio-bridge,id=bridge0,shadow-size=4096");
> +
> +    pcibus = qpci_new_pc(qts, NULL);
> +    dev = find_pci_mmio_bridge(pcibus);
> +    g_assert_nonnull(dev);
> +
> +    /* Enable device */
> +    qpci_device_enable(dev);
> +
> +    /* Read shadow buffer location from PCI config space */
> +    shadow_gpa = read_shadow_gpa(dev);
> +    shadow_size = read_shadow_size(dev);
> +    queue_depth = read_queue_depth(dev);
> +
> +    /* Verify config space values */
> +    g_assert_cmpuint(shadow_gpa, >, 0);
> +    g_assert_cmpuint(shadow_size, ==, 4096);
> +    g_assert_cmpuint(queue_depth, ==, 169);  /* (4096/24)-1 */
> +
> +    /* Read ring metadata from guest RAM at shadow_gpa */
> +    qtest_memread(qts, shadow_gpa, &meta, sizeof(meta));
> +
> +    /* Verify metadata is initialized */
> +    g_assert_cmpuint(meta.producer_idx, ==, 0);
> +    g_assert_cmpuint(meta.consumer_idx, ==, 0);
> +    g_assert_cmpuint(meta.queue_depth, ==, 169);
> +
> +    g_free(dev);
> +    qpci_free_pc(pcibus);
> +    qtest_quit(qts);
> +}
> +
> +/* Test: Shadow size property */
> +static void test_pci_shadow_size_property(void)
> +{
> +    QTestState *qts;
> +    QPCIBus *pcibus;
> +    QPCIDevice *dev;
> +    uint64_t shadow_gpa;
> +    uint32_t shadow_size, queue_depth;
> +    struct pci_mmio_bridge_ring_meta meta;
> +
> +    qts = qtest_init("-machine q35 "
> +                     "-device pci-mmio-bridge,shadow-size=8192");
> +
> +    pcibus = qpci_new_pc(qts, NULL);
> +    dev = find_pci_mmio_bridge(pcibus);
> +    g_assert_nonnull(dev);
> +
> +    qpci_device_enable(dev);
> +
> +    /* Read shadow buffer info from config space */
> +    shadow_gpa = read_shadow_gpa(dev);
> +    shadow_size = read_shadow_size(dev);
> +    queue_depth = read_queue_depth(dev);
> +
> +    /* Verify size is 8192 and queue depth matches: (8192/24)-1 = 340 */
> +    g_assert_cmpuint(shadow_size, ==, 8192);
> +    g_assert_cmpuint(queue_depth, ==, 340);
> +
> +    /* Verify metadata in guest RAM */
> +    qtest_memread(qts, shadow_gpa, &meta, sizeof(meta));
> +    g_assert_cmpuint(meta.queue_depth, ==, 340);
> +
> +    g_free(dev);
> +    qpci_free_pc(pcibus);
> +    qtest_quit(qts);
> +}
> +
> +/* Test: Basic write command via shadow buffer */
> +static void test_pci_write_command(void)
> +{
> +    QTestState *qts;
> +    QPCIBus *pcibus;
> +    QPCIDevice *bridge_dev, *test_dev;
> +    QPCIBar test_bar;
> +    uint64_t shadow_gpa;
> +    struct pci_mmio_bridge_command cmd = {0};
> +    struct pci_mmio_bridge_ring_meta meta;
> +    uint32_t test_value_read;
> +
> +    qts = qtest_init("-machine q35 "
> +                     "-device pci-mmio-bridge,id=bridge0 "
> +                     "-device pci-testdev,id=testdev0");
> +
> +    pcibus = qpci_new_pc(qts, NULL);
> +
> +    /* Get bridge device and shadow GPA */
> +    bridge_dev = find_pci_mmio_bridge(pcibus);
> +    g_assert_nonnull(bridge_dev);
> +    qpci_device_enable(bridge_dev);
> +    shadow_gpa = read_shadow_gpa(bridge_dev);
> +
> +    /* Get test device */
> +    test_dev = find_pci_testdev(pcibus);
> +    if (!test_dev) {
> +        g_test_skip("pci-testdev not available");
> +        g_free(bridge_dev);
> +        qpci_free_pc(pcibus);
> +        qtest_quit(qts);
> +        return;
> +    }
> +    qpci_device_enable(test_dev);
> +    test_bar = qpci_iomap(test_dev, 0, NULL);
> +
> +    /* Prepare write command */
> +    cmd.target_bdf = (0 << 8) | test_dev->devfn;
> +    cmd.target_bar = 0;
> +    cmd.offset = 0;
> +    cmd.value = 0xDEADBEEF;
> +    cmd.command = PCI_MMIO_BRIDGE_CMD_WRITE;
> +    cmd.size = 4;
> +    cmd.status = PCI_MMIO_BRIDGE_STATUS_PENDING;
> +    cmd.sequence = 1;
> +
> +    /* Write command to slot 1 in guest RAM (slot 0 is metadata) */
> +    qtest_memwrite(qts, shadow_gpa + sizeof(meta), &cmd, sizeof(cmd));
> +
> +    /* Update producer index to signal command */
> +    meta.producer_idx = 1;
> +    qtest_memwrite(qts, shadow_gpa, &meta.producer_idx, 4);
> +
> +    /* Give QEMU time to process (BH should trigger) */
> +    qtest_clock_step(qts, 10000000); /* 10ms */
> +
> +    /* Read back command to check status */
> +    qtest_memread(qts, shadow_gpa + sizeof(meta), &cmd, sizeof(cmd));
> +    g_assert_cmpuint(cmd.status, ==, PCI_MMIO_BRIDGE_STATUS_COMPLETE);
> +
> +    /* Verify write reached target device */
> +    test_value_read = qpci_io_readl(test_dev, test_bar, 0);
> +    g_assert_cmpuint(test_value_read, ==, 0xDEADBEEF);
> +
> +    g_free(bridge_dev);
> +    g_free(test_dev);
> +    qpci_free_pc(pcibus);
> +    qtest_quit(qts);
> +}
> +
> +/* Test: Basic read command via shadow buffer */
> +static void test_pci_read_command(void)
> +{
> +    QTestState *qts;
> +    QPCIBus *pcibus;
> +    QPCIDevice *bridge_dev, *test_dev;
> +    QPCIBar test_bar;
> +    uint64_t shadow_gpa;
> +    struct pci_mmio_bridge_command cmd = {0};
> +    struct pci_mmio_bridge_ring_meta meta;
> +    uint32_t expected_value = 0xCAFEBABE;
> +
> +    qts = qtest_init("-machine q35 "
> +                     "-device pci-mmio-bridge,id=bridge0 "
> +                     "-device pci-testdev,id=testdev0");
> +
> +    pcibus = qpci_new_pc(qts, NULL);
> +
> +    bridge_dev = find_pci_mmio_bridge(pcibus);
> +    g_assert_nonnull(bridge_dev);
> +    qpci_device_enable(bridge_dev);
> +    shadow_gpa = read_shadow_gpa(bridge_dev);
> +
> +    test_dev = find_pci_testdev(pcibus);
> +    if (!test_dev) {
> +        g_test_skip("pci-testdev not available");
> +        g_free(bridge_dev);
> +        qpci_free_pc(pcibus);
> +        qtest_quit(qts);
> +        return;
> +    }
> +    qpci_device_enable(test_dev);
> +    test_bar = qpci_iomap(test_dev, 0, NULL);
> +
> +    /* Write a value to test device first */
> +    qpci_io_writel(test_dev, test_bar, 0, expected_value);
> +
> +    /* Prepare read command */
> +    cmd.target_bdf = (0 << 8) | test_dev->devfn;
> +    cmd.target_bar = 0;
> +    cmd.offset = 0;
> +    cmd.value = 0;
> +    cmd.command = PCI_MMIO_BRIDGE_CMD_READ;
> +    cmd.size = 4;
> +    cmd.status = PCI_MMIO_BRIDGE_STATUS_PENDING;
> +    cmd.sequence = 1;
> +
> +    /* Write command to slot 1 in guest RAM */
> +    qtest_memwrite(qts, shadow_gpa + sizeof(meta), &cmd, sizeof(cmd));
> +
> +    /* Signal command */
> +    meta.producer_idx = 1;
> +    qtest_memwrite(qts, shadow_gpa, &meta.producer_idx, 4);
> +
> +    /* Wait for processing */
> +    qtest_clock_step(qts, 10000000);
> +
> +    /* Read back command */
> +    qtest_memread(qts, shadow_gpa + sizeof(meta), &cmd, sizeof(cmd));
> +    g_assert_cmpuint(cmd.status, ==, PCI_MMIO_BRIDGE_STATUS_COMPLETE);
> +    g_assert_cmpuint(cmd.value, ==, expected_value);
> +
> +    g_free(bridge_dev);
> +    g_free(test_dev);
> +    qpci_free_pc(pcibus);
> +    qtest_quit(qts);
> +}
> +
> +/* Test: Device reset clears statistics */
> +static void test_pci_device_reset(void)
> +{
> +    QTestState *qts;
> +    QPCIBus *pcibus;
> +    QPCIDevice *dev;
> +    uint64_t shadow_gpa;
> +    struct pci_mmio_bridge_ring_meta meta;
> +
> +    qts = qtest_init("-machine q35 "
> +                     "-device pci-mmio-bridge,id=bridge0");
> +
> +    pcibus = qpci_new_pc(qts, NULL);
> +    dev = find_pci_mmio_bridge(pcibus);
> +    g_assert_nonnull(dev);
> +
> +    qpci_device_enable(dev);
> +    shadow_gpa = read_shadow_gpa(dev);
> +
> +    /* Write some data to producer index */
> +    meta.producer_idx = 5;
> +    qtest_memwrite(qts, shadow_gpa, &meta.producer_idx, 4);
> +
> +    /* Reset device */
> +    qtest_qmp_send(qts, "{ 'execute': 'system_reset' }");
> +    qtest_qmp_receive(qts);
> +    qtest_clock_step(qts, 1000000);
> +
> +    /* Verify producer index reset to 0 */
> +    qtest_memread(qts, shadow_gpa, &meta, sizeof(meta));
> +    g_assert_cmpuint(meta.producer_idx, ==, 0);
> +    g_assert_cmpuint(meta.consumer_idx, ==, 0);
> +
> +    g_free(dev);
> +    qpci_free_pc(pcibus);
> +    qtest_quit(qts);
> +}
> +
> +/* Test: Multiple bridges can coexist */
> +static void test_pci_multiple_bridges(void)
> +{
> +    QTestState *qts;
> +    QPCIBus *pcibus;
> +    QPCIDevice *dev1, *dev2;
> +    uint16_t device_id;
> +
> +    qts = qtest_init("-machine q35 "
> +                     "-device pci-mmio-bridge,id=bridge0,addr=4.0,"
> +                     "shadow-gpa=0x80000000 "
> +                     "-device pci-mmio-bridge,id=bridge1,addr=5.0,"
> +                     "shadow-gpa=0x81000000");
> +
> +    pcibus = qpci_new_pc(qts, NULL);
> +
> +    /* Find first bridge */
> +    dev1 = qpci_device_find(pcibus, QPCI_DEVFN(4, 0));
> +    g_assert_nonnull(dev1);
> +    device_id = qpci_config_readw(dev1, PCI_DEVICE_ID);
> +    g_assert_cmpuint(device_id, ==, PCI_DEVICE_ID_REDHAT_MMIO_BRIDGE);
> +
> +    /* Find second bridge */
> +    dev2 = qpci_device_find(pcibus, QPCI_DEVFN(5, 0));
> +    g_assert_nonnull(dev2);
> +    device_id = qpci_config_readw(dev2, PCI_DEVICE_ID);
> +    g_assert_cmpuint(device_id, ==, PCI_DEVICE_ID_REDHAT_MMIO_BRIDGE);
> +
> +    g_free(dev1);
> +    g_free(dev2);
> +    qpci_free_pc(pcibus);
> +    qtest_quit(qts);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_func("/pci-mmio-bridge-pci/device-discovery",
> +                   test_pci_device_discovery);
> +    qtest_add_func("/pci-mmio-bridge-pci/shadow-gpa-access",
> +                   test_pci_shadow_gpa_access);
> +    qtest_add_func("/pci-mmio-bridge-pci/shadow-size-property",
> +                   test_pci_shadow_size_property);
> +    qtest_add_func("/pci-mmio-bridge-pci/write-command",
> +                   test_pci_write_command);
> +    qtest_add_func("/pci-mmio-bridge-pci/read-command",
> +                   test_pci_read_command);
> +    qtest_add_func("/pci-mmio-bridge-pci/device-reset",
> +                   test_pci_device_reset);
> +    qtest_add_func("/pci-mmio-bridge-pci/multiple-bridges",
> +                   test_pci_multiple_bridges);
> +
> +    return g_test_run();
> +}
> +
> -- 
> 2.43.0
> 
> 
> -- 
> 
> Cheers
> 
> Stephen Bates, PhD.


