Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D105C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzDpU-0006eW-US; Wed, 26 Aug 2026 09:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wzDpS-0006e9-I0; Wed, 26 Aug 2026 09:38:11 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@intel.com>)
 id 1wzDpQ-0004os-SN; Wed, 26 Aug 2026 09:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787751489; x=1819287489;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JeiFOZyQ5BCZUlGNebhGmJWjUNstn0Bfc1Pre6PhqmI=;
 b=VpxACuGxGR6n/Mx5w0p/xeoupI5to4B1uKGYn9kAZnqkA3IlUMXR/S3Y
 g4i1lCkZQ/lGj6QJhlLFEkbSwVUsQEZwCYjk8rcRy6kr1QRUeiFYV4u0z
 qQQJmSY+IwQCi8EOZZU/bGbiP7NQcKwOzfd6ZjjNtamfyEtfoY32ikAtV
 QUe5FzvWPZk5SnSy4lyCYoXMcVIL75EvNfYKkrk08QbYopbDAZD/+dZQC
 bPw6gFoGPnDi4zUhKCmtK0m6NeymQpW6zsvpbB4DA/rADLi/6Y9EyCtKn
 UQN07XRxnEnG+ynswLY4vB8NgU2GwZ5+kXa8rqsMtvTH5iGOcGJ2fQWdq g==;
X-CSE-ConnectionGUID: 1DYGSE8uSo6tfdNL7ivJPQ==
X-CSE-MsgGUID: vOLQQ3z7SaOH+2e3FDmGbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88249861"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="88249861"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 06:38:07 -0700
X-CSE-ConnectionGUID: Z2UJbQyXTn6sN5RYza5cKA==
X-CSE-MsgGUID: ZJa26qTuQ1iE6rSsQABBmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="269529862"
Received: from junjie-desk-dev.bj.intel.com (HELO
 junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 06:38:02 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com,
 imammedo@redhat.com, sunilvl@ventanamicro.com, sunilvl@oss.qualcomm.com,
 jic23@kernel.org, pbonzini@redhat.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, anisinha@redhat.com, dave.jiang@intel.com,
 alison.schofield@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/4] hw/riscv/virt: Provide a 32-bit MMIO window for CXL
 host bridges
Date: Wed, 26 Aug 2026 21:37:53 +0800
Message-ID: <20260826133754.355453-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821081954.1171-4-cp0613@linux.alibaba.com>
References: <20260821081954.1171-4-cp0613@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=junjie.cao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi Chen Pei,

On Fri, 21 Aug 2026 16:19:53 +0800, Chen Pei wrote:
> - The CXL host bridge _CRS is produced by the generic build_crs()
>   path.  EDK2's PciBusDxe only recurses into PCI-to-PCI bridges, while
>   the pxb-cxl expander bridge presents as a class 0x0600 host bridge
>   with a type-0 header, so firmware never enumerates behind it and
>   leaves the CXL root port's window and bus-number registers unset;
>   build_crs() would therefore return an empty _CRS.  Simulate the

I see the same empty _CRS you traced for Igor on v2, but the cause
sits one level up: riscv virt never tells the firmware that the
expander bus is there.

etc/extra-pci-roots is how the other machines advertise expander root
buses. hw/arm/virt.c, hw/i386/pc.c and hw/hppa/machine.c all call
pci_bus_add_fw_cfg_extra_pci_roots(); arm got it in 09fad16744 as
part of the pxb enablement there. hw/riscv/virt.c has no such call,
and since PXB is default y only for Q35 and ARM_VIRT, this series is
what first brings pxb to riscv at all -- so nothing has needed that
fw_cfg entry until now.

Same binary, in-tree edk2-riscv, only difference on the command line
being -fw_cfg name=etc/extra-pci-roots,file=<le64 1>:

  PciHostBridgeUtilityGetRootBridgesBusScan: 1 extra root buses ...
  PciHostBridgeUtilityInitRootBridge: populated root bus 12, ...
  PciBus: Resource Map for Bridge [0C|00|00]
  Type =  Mem32; Base = 0x40400000; Length = 0x200000; ...
     Base = 0x40400000; Length = 0x10000; ... Owner = PCI [0D|00|00:10]

so PciBusDxe does go behind the pxb-cxl once it knows the root bus
exists, and it assigns the root port window and the Type3 BARs itself.

With this patch dropped and pci_bus_add_fw_cfg_extra_pci_roots()
called from virt_machine_done() instead, next to
cxl_fmws_link_targets(), the regenerated DSDT has PC0C as

    DWordMemory (ResourceProducer, ...)
        0x40400000,         // Range Minimum
        0x405FFFFF,         // Range Maximum
    QWordMemory (ResourceProducer, ...)
        0x0000000400100000, // Range Minimum
        0x000000040010FFFF, // Range Maximum
    WordBusNumber (...)
        0x000C,             // Range Minimum
        0x000D,             // Range Maximum

with PCI0 keeping the rest of the 32-bit aperture
(0x40000000-0x403FFFFF and 0x40600000-0x7FFFFFFF). Firmware
partitions the aperture itself, sizes the window to what is actually
behind the bridge, and the 64-bit window comes along too. With a
second pxb-cxl added (bus_nr 12 and 200), the two bridges get
0x40400000-0x405FFFFF and 0x40600000-0x407FFFFF, so the
single-bridge limitation in the TODO would not arise either.

I have only looked at firmware enumeration and the generated tables
here, not at a booting CXL guest, so your RVA22 run may well turn up
something this misses. But if it holds, it drops the 256 MiB carve-out,
virt_cxl_init_bridge_windows() and the reset handler, and it is the
"fix UEFI to perform required initialization" option Igor raised on
v2, with the UEFI side already in place.

Many thanks,
Junjie

