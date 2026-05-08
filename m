Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD777CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 18:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLQ5D-0006e0-Md; Fri, 08 May 2026 14:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wLQ5C-0006co-3A; Fri, 08 May 2026 14:37:54 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wLQ59-0002Yg-Qt; Fri, 08 May 2026 14:37:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhQrql64GlNjMqFIM+fjr/BrXsgn/GQV6GoLW/ieTnVbk52p/ubjKTftAYoKRJnomOLz3ckDpXyOodktaNeTJRYBoTXHJzS1OQYP24FMsjwvGhTvWBd+JxBk9pVYL0yx3QsMDiDrN/hxcM0wy7q3kMBPZ9zce+LBH91LJnZ3pxXJvb8RzcheJgaU75XYLlzGoczhTVGiuJFCscoiInX25eU0q81WobNErOINpAAK+L5PdV4FdVMPXLJJy0hfDsUL8ZhnKZwcOtqsRPmz6hYvstDPPxTH6tD3oMqma+kzzxFkkGfe/c5sHxc+s3j1ToGdRTNvmYqhJo12V70adjoX1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRfNNwwEmFLJUlHdPjGJiCAGsjBF2r2xwf0aAUXmhM8=;
 b=hk63YiaBRsZAmt47Xg8mig4MJkmI1SIP5iK5gZuJBzLmAvuQMGRVpDZM9LOyKnDyVXCAsZ68BS24xcJteX1xvxv7DMoBa3Ppv9oJhgBv11m7YVEjUqhDlvmQGDVi18XTohxKxN7Sy0TsVar2TgDLTYVZ+/BP4/9cW7YDafc7HFwmEJlg/Gv9mV2icQPU9Jl5mBoKoGNvf4kncO2Hj9k9CQLO85rcupsUb0l9tBSR/GjlfAvp4pGJttst+o35/7GLwx9nF8IxjtvNLzpA1uybIMLUTnLqFJpOfGTRHMfri7vwKBxlNhRPNbrM3RYlaS3Yv/ZiQsj0YR7UV2sV8NjEqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRfNNwwEmFLJUlHdPjGJiCAGsjBF2r2xwf0aAUXmhM8=;
 b=YlIecEpY69oDM0yc8YchPatLcIKolJMJ6kQaqH0yiEFaHRcXZvXgF83w1SbIknjK1bw/FiNKhf949oVIKdFW+sW3oROhenfweQL26cxULt3CjTXbac0q061szIhJJC0LifoiBJgg1TSYIu2WuQJFmWYBP/xJfWXHB4TROWqx7SAVV1sxxq4AcBLabkS84CvxKtKlzThf/Xr3t0irO33HUlwVoy5d39SuTZKMPHaNyZYJXSdzAjUMP8h3WavWo89orBaf+XQGS76ISbay0stZ5ZRXp9OMlruuCE2qJrDFtRnvggzQWPzRTunyCaSaWlQXyI94Ci64JWAFo58e24x/xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Fri, 8 May
 2026 18:37:39 +0000
Received: from BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325]) by BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325%4]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 18:37:39 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: alwilliamson@nvidia.com, jgg@nvidia.com, skolothumtho@nvidia.com,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, devel@edk2.groups.io
Subject: [RFC PATCH 0/8] hw/arm/virt,
 hw/pci: PCI pre-enumeration and fixed BAR allocation
Date: Fri,  8 May 2026 13:37:09 -0500
Message-Id: <20260508183717.193630-1-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0959.namprd03.prod.outlook.com
 (2603:10b6:408:108::34) To BY5PR12MB4179.namprd12.prod.outlook.com
 (2603:10b6:a03:211::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4179:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ce5c27b-ee78-4e9e-70a9-08dead30e216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|3023799003; 
X-Microsoft-Antispam-Message-Info: LHOTFabKMP00UYin0pUO2KM5TuYXU+UpjSKwGm8T2nnT5BAiiejNCQSU45m3qy7qMuQ/cNa+gRQlOy+mht3e4wRt+0zIF8FQhISmz14AYAlJ+6cqWpZFNyQLkET7edoBiYCJyvN42j+sot8Luzhrf2QLZAQceaN7tT/agBuhSSgC6OKKf+QMMGD+6VdTmvsZ27K5dHmHOfpseK3PMcKUG5LTyeb92/OO4P1PSWU++nSLzq56c3AGydv0F2mqEBbi9pUwhJI/ZsReWVEQQBvgquPpxe/n8uGthHF5k9Xkgu8KTdb9stSrdPjEr8aIJnHvMmQJ9mlmgSwcCGh/ak+mcnLyswePgZCIcI/+NiWBURjV17sNj0/FXNpMu+GRLF6KQZR5dpVYHb2cLgqYWeQQ49lMWgok/LHYOCMo8ZEXQ2yTA/fdf8WmQEu18ZHfeT8g8C0+TBfJCOvTJwFD7BSYwlMf4Z90okegWkbxw4C5Wzjeky4IV9Zxe9izswny3BooDjvTgZi+EUEaM0iH1okL/kQ3pT8qIDx7lzH75vqZS/TmgAyOxMxq1TdyqMlhVUoAveR7fminEz3zwKjzSnuUETSQeSZX01XEsgtzK9wOgJNabPqfRecOFPbMR4n8cdKpHOCmU9G43EZDJobz349BpXJT6M+MgtMU3v2irQGcw2ICD1VU5XAyd+p+BoPcgAww
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4179.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HXr+8g7cq3LhsNqix6wP4ThO+j7H7E0HgZKU7ykkNBrYAHR/I1oHTaRUJX8+?=
 =?us-ascii?Q?TrbEv/FDU67pUApBExdQFKFi/iRSp0nn1ndzQDJsRABmsllp3tKHte3YdeZD?=
 =?us-ascii?Q?edK/iElRMqUzdt54tE8k28OLo/G3+aUPBWwu2mWTsrua2ZE25KRaFpP5j3mD?=
 =?us-ascii?Q?ABa0Z+tDhTHB0CxTUWqHCqfsRxr9W7q6t+SgCKcyE+EXJhAwmj25YWfH2VaC?=
 =?us-ascii?Q?WGnGOljzRV5IdsmIyykT/0ZXRfOsRRz9xy+n2490Gwosq9L7EiLWl+djDczU?=
 =?us-ascii?Q?N7TTMj6gK5YK8UNURfFa75sVoSPvl7NFeL+j1IcdJJ8bnVnuvuoQgdtxirpc?=
 =?us-ascii?Q?WTD4zsRSTrA6TZCQAhoZm6xQDVswAu3THpQS/mWpUUqSFkFLaN+biTxaLMpb?=
 =?us-ascii?Q?/EB22oTmwzD0ysjqDPvJb+cLu5wr0EqSzWnTWwPBvApScJT4esm2qIyeA1mo?=
 =?us-ascii?Q?m8DiOUBu7R9sQ6Xz9/yLRxmfCq9LjxETrYBOM9e8sR8SA2j/BBSEGUtQZq+8?=
 =?us-ascii?Q?hKI6V8mtZECTfKdYnk5A5EDysa8hCh1MWR1zdzPXCh3a89wsn3a2PaLcl+4D?=
 =?us-ascii?Q?+p8GSRGMyCZithDn8LpjI7ReQwKkBfKde5rfHWcm9LJ/UOJaRpLWrnugnFzo?=
 =?us-ascii?Q?uDTH+gAhCxr6ornTYg3N58GD13TxN8+yTTKE6ukX0pjxdcDctoS6np6QGOVb?=
 =?us-ascii?Q?25wthv3c9kM/tZiGixII9bOCkFHAR6p6vOnDGTlr0J+8tx678a8eYYGuWQIg?=
 =?us-ascii?Q?ZQ9Nh2cg/kZ/Qz3qM0X5ATygcLakfycKOpCXtv7B73uwGPf2FtKv3+vCb/49?=
 =?us-ascii?Q?pGLesWqAPvh11gpZoZBFkf5btqE7m1epS/6s5WTfW1tzSjXuXl7o0IHrl8y0?=
 =?us-ascii?Q?7SHpy/WT5SxBphJuNHVxI8eDNrkPHSb77y365sL/xrXeavhcmWjVEhfoUxEb?=
 =?us-ascii?Q?/8m96OtAOS83YQ3Ep3X16MDSnLbKG+N6X6Ru3NvZEOH71mYIkQWX1Pnm7KcO?=
 =?us-ascii?Q?zF0CFhWCGnN+iKqVsGkm3YDN5JtIaGTcuDET2mM245qlfBbyhpHLTEu70nB0?=
 =?us-ascii?Q?I0OgIuOf6FLtP0Frr21hzKHeras6kHEDREuRqZIV85pnWgNGQXmF6bJZu4k8?=
 =?us-ascii?Q?pSm29XKsuFz9/c2Wm8PWJRrmUPq4OXbubRwXoUrgpBDotN4oF0QTE08RiBxg?=
 =?us-ascii?Q?OHKIoh3g1/UfOxfG/fsj5a8gc+MGjgajWSfJsiP8Aomo9XP5uPk+viqbicH6?=
 =?us-ascii?Q?2KACSKKlZLxpfeWgGsDYjcZx3BHfCzEHVz/P0k0r+0CCX14BfbMUz0NE++IW?=
 =?us-ascii?Q?o9e8rcCTycJve0f0WuGeypZl9Nuna9qE8O3SzSYMW1hmMYLWXzaI0JHB7+gI?=
 =?us-ascii?Q?Rmg2pPH7taL0Cc0N+pFtNOrj8vWinrELY0o3XjcR8YIO9x91Q4OgzfUbJ7sy?=
 =?us-ascii?Q?WfdzdmoVVlPGYkrNt2EQ02RYIadLu6FKKOeiLatpTN6uMJxxoq8tXOwhhehd?=
 =?us-ascii?Q?r2B8ufmAG3i33jtnkKhcNiUBvn5zVSgyQH66pEZcVl9kneQ65XrqOcfp2/Zo?=
 =?us-ascii?Q?Bguq6kbe9ALTzAtFTsHu6rL08wfz34mpPQyJ184+xwc+aC+SrJOaSHRH4NRk?=
 =?us-ascii?Q?OY8HbgBy8Y81tNnBs4DsWHZLsGcWrPCkxUJEJmo+Hst9Y5JRewgZDAUJMTP5?=
 =?us-ascii?Q?CscyTrlMHD5HjHCUyZRup2/8Zis2OmuQ3rjG2tl60or7ssYbsTbY6Zfxpp4X?=
 =?us-ascii?Q?jKhd0a1qYA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce5c27b-ee78-4e9e-70a9-08dead30e216
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 18:37:39.7362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1t59isii7KRrJLCgccMUNqOhPUkgzZwU/gx7YRMIdDsI06wb/rDA2fDxVERu1L9NHEOGuiQgnMysnsyK7qR/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8482
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=tdave@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

This RFC introduces a mechanism to specify Guest Physical Addresses
(GPAs) for PCI BARs, allowing explicit placement of guest MMIO BAR
addresses to match host physical addresses for assigned devices.

On some platforms, P2P DMA is performed between devices within the same
IOMMU group. The PCI fabric ACS is configured to permit direct P2P
without going through the host bridge in order to achieve the required
performance.

To support this multi-device IOMMU group P2P scenario in virtualization,
the VM may need to use the same MMIO BAR addresses as the host physical
address layout.

This series implements a per-device PCI property, "fixed-bars", which
allows users to specify fixed BAR addresses. The property is generic
and is available on any PCI-capable machine. It is a comma-separated
list of BAR assignments:

        barN@<addr>[,barM@<addr>]*

The virt machine builds on this with two additional machine properties:

pci-pre-enum
    When enabled, QEMU performs PCI enumeration and resource assignment
    before handing control to firmware (e.g. EDK2). This includes
    programming 64-bit prefetchable BARs according to fixed-bars
    assignments, and programming bridge prefetchable windows.
    A "pci-enum-done" device-tree property is set so firmware preserves
    the configuration.

pcie-mmio-window
    Defines the MMIO64 window for PCIe devices. When using fixed-bars,
    this allows the aperture to be resized or repositioned so all
    assigned BARs fall within a valid address range.

Why QEMU programs PCI resources rather than EDK2:

To support fixed BAR placement, QEMU performs PCI bus enumeration and
resource assignment prior to firmware execution. EDK2 already provides
a PCD-controlled mechanism (PcdPciDisableBusEnumeration) that allows
the platform to skip PCI enumeration and resource allocation. This
series leverages that mechanism so that, when enabled, firmware runs in
a discovery-only mode and preserves the configuration established by
QEMU.

When pci-pre-enum is enabled, QEMU runs PCI enumeration and resource
allocation, prioritizing fixed BARs specified via fixed-bars. If
allocation fails due to alignment, overlap, or address space constraints,
QEMU terminates with an error. Otherwise, all BARs and bridge windows are
fully programmed before firmware execution.

There is certainly room for improvement, but this RFC aims to gather
feedback on the overall approach chosen to address this problem.

We use the virt machine in this series as the concrete example
consuming the fixed-BAR model. Other machines may require their own
machine-specific mechanism (such as pcie-mmio-window) if they want to
adopt the same approach.

Example usage:

  -machine virt,...,pcie-mmio-window=0x400000000000:0x400000000000,pci-pre-enum=on \
  -device vfio-pci,host=0009:06:00.0,id=dev0 \
  -set device.dev0.fixed-bars=bar2@0x6b8000000000,bar4@0x6c8000000000

Testing:
This series was tested on NVIDIA GB300 platforms with a recent Linux
kernel. GPUDirect P2P between a GPU and a CX8 NIC requires a PCIe
topology in the VM that mirrors bare metal (e.g. both devices under the
same switch and ACS tuned for the minimal P2P paths needed for GPUDirect
RDMA).

TODO:
- The fixed BAR allocator handles 64-bit prefetchable BARs and related
  bridge prefetch windows only. Programming PIO, 32-bit MMIO, and
  64-bit non-prefetchable BARs, and sizing bridge windows for those
  resource types, is left for follow-up patches.
- SR-IOV virtual functions are not included when sizing bridge prefetch
  apertures and may require additional work.
- Add ACPI _DSM so the fixed BARs are preserved.


A git branch with this series applied is available at:
https://github.com/tdavenvidia/upstream-qemu/commits/upstream_May_08_26/

The related EDK2 change is available at:
https://github.com/tdavenvidia/edk2/commits/upstream_May_08_26/

Tushar Dave (8):
  hw/pci: add fixed-bars property to allow fixed BAR addresses
  hw/pci: enumerate PCI bus and program bridge bus numbers
  hw/pci: introduce allocator for fixed BAR placement
  hw/pci: pack remaining BARs and update bridge windows
  hw/pci: allocate remaining BARs for buses without fixed BARs
  hw/pci: finalize bridge prefetch windows after BAR allocation
  hw/arm/virt: add pcie-mmio-window machine property
  hw/arm/virt: add pci-pre-enum machine property

 hw/arm/virt.c               |  157 ++++-
 hw/pci/meson.build          |    2 +
 hw/pci/pci-enumerate.c      |  144 +++++
 hw/pci/pci-enumerate.h      |   15 +
 hw/pci/pci-resource.c       | 1099 +++++++++++++++++++++++++++++++++++
 hw/pci/pci-resource.h       |   82 +++
 hw/pci/pci.c                |  108 ++++
 include/hw/arm/virt.h       |    3 +
 include/hw/pci/pci_device.h |   10 +
 9 files changed, 1615 insertions(+), 5 deletions(-)
 create mode 100644 hw/pci/pci-enumerate.c
 create mode 100644 hw/pci/pci-enumerate.h
 create mode 100644 hw/pci/pci-resource.c
 create mode 100644 hw/pci/pci-resource.h

-- 
2.34.1


