Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D2BFA1FED
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFeQj-0000Rl-OZ; Wed, 22 Apr 2026 16:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wFeQY-0000Q5-8E; Wed, 22 Apr 2026 16:44:07 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wFeQN-0006uV-T8; Wed, 22 Apr 2026 16:44:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UleI1bQbVpMhkUsSQ/b9tjJ1B3dwbN7Xpr0ntPKE1q5rnq3ji2yYW+3O5rRo9o4N2tyRgyrsijDkUm34YqBIPoKLIggICWM8omkkC7gF9BEW6HfdBfpuBIy7AciJlQ29zXbaZpqyL40uzxJASsk1OwutQw4nilxphCXkeV9oWOiu1AdcFhpUm+rL3o1RZA2oazN3ZpBtJ/xVCEDRo374PHZZrznPG0wq3cDuxfxo4Dz9y/8NB1cht2R8Wj2fcFrWwRlVUTxma+nCaX0lBwKCe8S+vf4Y1IW3odA0agsF3AbHVxyxwq389mpOvaTnjfluT9ptWWeM9jXsj/Kzm5UASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cG6NWlMFQzBKWua+kA1tMQQJUj1DhmKHKgR2tv4hpd8=;
 b=gnBt2pB5h3/WcwYu/r5iFB8kvjKG2BcYkWn2xgWf7JcqkyMPkeoJ0n1ckGnfShJ1bf7eoFSUiBBoPBzZ4C7i6u+vq58dP/cQvoR+q25YfB/rzeKoMTfKWBAIUQJ9bGfIcWDz0LKi2mFGlM4YKtzkuzs6oU8mhDsGSPEazUea7E9DLlbnxIkI7saXKC5lS3wIrIWNlhlEblgjD+DRB8lvvZCX1V4C5MCK1e6KFo93ApkYK0vRd/RJVUWP1efqfsWABZ5uj+vE+i5sfaWIcKFL+Fp0Dyz4toN2fhDjSzStCJggmuldofiUFga/f5J6gfzRWBD9zHpiD0SzXwZ+tUYy3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cG6NWlMFQzBKWua+kA1tMQQJUj1DhmKHKgR2tv4hpd8=;
 b=qYX1XaeLnQ6xMnQtN4IKdPP6Eu+cZ745T+PkrksJhF6DCn7A7/gCa/pvqoEN7CSt07b+ni48YaxDWh4tdjiiaorqEz2ujrU11J3a550sj0a5B/kd3mVbSQHIho8LBG75GY/sHoeSEi4V9Z33n0+5SQEpkkKhzUi4Eza2wQAR+E6qzPdHDVd/iW2999R1XogYAFlMbX5DVY1W5KE8JQQtgFiRNw18xYWAR0erTP+OEY4KVhyFDg69jpBq1DV5b2FdJ5jAqRlTXnwMjpRkhQ/5RrAKTMhWYdoHJJ9xsTFjo08hpktGYnDuhhzZRLLn8C3GVPenRZrt/sj324S1kI8xXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by SA1PR12MB7368.namprd12.prod.outlook.com (2603:10b6:806:2b7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.8; Wed, 22 Apr
 2026 20:43:44 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 20:43:44 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v2 0/7] hw/arm/smmuv3-accel: Resolve AUTO properties
Date: Wed, 22 Apr 2026 13:43:28 -0700
Message-ID: <20260422204335.23116-1-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::7) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|SA1PR12MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: d0eab06e-d49b-4e7e-eca0-08dea0afd88f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: f67dLd7KIDHgEZMuHbGOpuLI2BJ0WunGknBUpJjFqGFadwW99a8Tnp18Ry6Y9Rq3LdowI1SSVNTUci2LU+ooM5QJnG9p4ikpzRs0oSgQ73aJAmel0p/9oq44+gCIeCEYLCZmLFwjuv8EbUFFqDPdZt5SUaFZ4e9bnFyO+o7T6aqQvn+zg1S8qXx6EuWZWS9J7xyv+YNelunioSkCSa9E2I7J9Jf/jMsI5WvQJP2FZui99UgbiUHtIVMxeTr+vPBhAA5RZYNe5hiqCscqvIERIdMjH1FaEwDYUyyJargqVPPiGuVceNwoEjKA0cX3Ul+aAg5IXnCUDDFCUDNkBgBMlMqZR+lzRJfah0PQh5N9AKZ0UgNJ0C6Z5vaDoPC+xs1H0GgM0rkNllEKn5dIWiWtMgDp7VKa6q3f69tarkF+gqI+cUhYujmvzSw2AG+Yw8d7gxSv0xPxqTzPGutL3yjZ+65WwgH91leBX3CX/27XWW50Zv8WM6eniFRYKg4DJDQK9oZcEd/Pjyn8My+xBMMeQf1YFyAPHmnEpFdtMvIT8EgjAvEAe6ZeQJOFPr/23mCQsPubU4jNLFcqlreq6vpTrxPAFvyTGSG3PF/kOioK+Muxzn2/9T/3ZgiWfs5kTDM4c+UQguRvHWZUU2/4XUN1jgidUUrxHSwwqKKU2/ZrEIHa2vwgXYThPrtOcrM5d89StHz6r/qn+2hzVxZ2qGtvBzAZwNQoK1eBL420gw5WmQr9ksU4PHV2VwyQCyA9+SV7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vxrqnJpVTYsWVr0k97eaNzsmGSfjoTQKYnlBPBlyFeSAc9xOinsfguB4Q8oR?=
 =?us-ascii?Q?K5ptoJTJtBSKNnjNgi8l+k5tiD/NisDlYjmAUBaN/egDcZeIES6eAo8EPISm?=
 =?us-ascii?Q?xJKadDZpt9nnXXhfhpv8a/ba+6QMo06cKCUdduF1hSepU9UFadwSa+rygCJO?=
 =?us-ascii?Q?MZNnSTu6nSol6XY475DHHM5BSaQaSbBZOjIuti4FATDIQDcZ2PPTpPyHO8iO?=
 =?us-ascii?Q?xjQ/0bhtoYWNSNAfvlYwq6djzw4oTzHNI2IIhnB1Rjhwm9dpecfjViWkWnEo?=
 =?us-ascii?Q?IPgdPpGwgPseJSiflwTbqkvkejBNZS1/1J6sGfZlPXZ5QOpshw/HNBcdhPgV?=
 =?us-ascii?Q?weqa80ylSx6MNmXCGab94Qmu9ci9Al62VwL+gZoT2HTEGwL3r8+QXgNGu0Cd?=
 =?us-ascii?Q?aD58uWiNNYVhZMZ3Gf9twXkIN5xri6nTVvAaNjJuWlRkpXP5eP6vS73jIFrN?=
 =?us-ascii?Q?88AFvnsIYS2G9n5TDD6uaslR+zCiZ1mePaI0ZP7PgXEgIxlWuJJ/n9+sB9F5?=
 =?us-ascii?Q?7mRdB032WXkzcM0puYFP24ObUM8OaZ635vG2UBCHM6gBAiOKCpTwZ0V8++ll?=
 =?us-ascii?Q?a3YONE15JOWenjKJjGPlF8+e/yYBvzwP33qfiirCs6raHaBYTBXFPf1Qdcog?=
 =?us-ascii?Q?kOmt3G2Ey3cMl/Xo0r+1vwrArtMA09+94IfE2lwu4aiid8HE7pd/WwL7WG1v?=
 =?us-ascii?Q?yQiFK9MkHyeDe4QLylVyi9TTYMA25BZSzcQmgaIyJS6AqCpZ85xe7ifhNjpc?=
 =?us-ascii?Q?0/wZqkNJoj50RTe1ceDsr/onKWkFP7Q56kDdp1VBhTMn0v8cOgJTKjmDkWop?=
 =?us-ascii?Q?XMb8qo0C1ZK1x7T5oq93A/P1Mxaw3dDpPlqKikTLRbsbim3u8NqzSlwks6ax?=
 =?us-ascii?Q?7KIXjQf2a1K78ycA/YbVKK/Rk9Rlg1FbcJa1axD7hCw2Cwac/jnoGHf5sr1S?=
 =?us-ascii?Q?lnqnkDhLlmKdOTDeK1h7YgJLh7v+42yp8MrP1F5q0422Lz2Th2q+MPtgX4ck?=
 =?us-ascii?Q?uygnJrnMBuYvbKQCzuoSqmmplIgqyXMZEPvz0GVRNJBAs4R5YqYFbslpFGeD?=
 =?us-ascii?Q?v9se2elzMqARwxDOnUYhZByMXYIp1NDghlkvO2B9UqK1taxPp7X4LC/G5BSH?=
 =?us-ascii?Q?iIOIf8LGg+gzg7jqq1dll/ilju0Alh6U6/tBPYII+heZk1dgGBnGfMWTlUTI?=
 =?us-ascii?Q?U0NM8OJoC5NEe8hbq5avI7RvLUMkOMQMf0IAe/dFt3Q2k3sLQ2yxeW1H5C5P?=
 =?us-ascii?Q?h/rRdkxssFaLDY0aBAppsL7F77dEX6U47ShbTsNwiHxmbB8ZXqNiVi9OMVJ6?=
 =?us-ascii?Q?DEmfRi+3GkrF9d03HjaEJv9Tb/C5QLonFp7DDwT65zVHf8yZ3LG9SH0kkLUN?=
 =?us-ascii?Q?7AviOFZV0QNbWBcp55gYnrD9N89KcrSAij5PuO/sUpWthsScFN8ZcMu/Mztz?=
 =?us-ascii?Q?DLOvtuKmFv3tdY/C2P9dnFS0vRpfZBL7k4OxG0wuauQpgr+X9D3yYgxqqNqC?=
 =?us-ascii?Q?km7kMYFQm4BZPuAMK7Lxm8GawEfDb7CnFb9jDtYmxnPFkJPHcFPXfXGIgHYw?=
 =?us-ascii?Q?MWCtfGODlk2z1AoxXLYHJ5m0f/TBroMCyCz7ZPSgmVBMJymnjdtxYBGivtZx?=
 =?us-ascii?Q?zdmbTqeoJ7y7FrwqXFog1vi5ncEAahFzR/mJtdiyGEJ/YXiSX8/n9OBhmW7n?=
 =?us-ascii?Q?aR95vORpJp8DD+RuAI4ps/tU3zNSenc9EruR4HebaHZVl4JkHhJqjcA8SJsZ?=
 =?us-ascii?Q?G2kAsI7Yqw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0eab06e-d49b-4e7e-eca0-08dea0afd88f
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 20:43:44.7685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwBIF8HXbxnHtggVz0K7qSFBxsvjforCONaawmbpZ2XTGi7nDrdgB13RQzhX8I0Npl1F+ePof+SAzIj7D/j4eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7368
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=nathanc@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi,

This series introduces support for resolving 'auto' for arm-smmuv3
accelerated mode's ATS, RIL, SSIDSIZE, and OAS feature properties based
on host IOMMU capabilities. This is dependent on the series [0] for
changing these property types to accept 'auto' values.

Accelerated SMMUv3 Address Translation Services support is derived from
IDR0, Range Invalidation support is derived from IDR3, Substream ID
size is derived from IDR1, and output address space is derived from
IDR5.

The default values are set to 'auto' for all properties. If accel=off
and the values are set to 'auto' or are omitted and resolve to 'auto',
the default property values defined in smmuv3_init_id_regs() for OAS
and RIL will remain unchanged, while SSIDSIZE and ATS values will
remain initialized at 0.

A complete branch can be found here:
https://github.com/NathanChenNVIDIA/qemu/tree/smmuv3-accel-auto-resolve-v2

Please take a look and let me know your feedback.

Thanks,
Nathan

[0] https://lore.kernel.org/qemu-arm/20260323182454.1416110-1-nathanc@nvidia.com/

Example usage:
qemu-system-aarch64 \
  -object iommufd,id=iommufd0 \
  -machine virt,accel=kvm,gic-version=3,ras=on,highmem-mmio-size=4T \
  -cpu host -smp cpus=4 -m size=16G -nographic \
  -object memory-backend-ram,size=16G,id=m0 \
  -numa node,memdev=m0,cpus=0-3,nodeid=0 \
  -numa node,nodeid=1 -numa node,nodeid=2 -numa node,nodeid=3 -numa node,nodeid=4 \
  -numa node,nodeid=5 -numa node,nodeid=6 -numa node,nodeid=7 -numa node,nodeid=8 \
  -device pxb-pcie,id=pcie.1,bus_nr=1,bus=pcie.0,numa_node=0 \
  -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1,accel=on,ats=auto,ssidsize=auto,ril=auto,oas=auto \
  -device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1,io-reserve=0 \
  -device vfio-pci-nohotplug,host=0009:06:00.0,bus=pcie.port1,rombar=0,id=dev0,iommufd=iommufd0,ats=auto \
  -object acpi-generic-initiator,id=gi0,pci-dev=dev0,node=1 \
  -object acpi-generic-initiator,id=gi1,pci-dev=dev0,node=2 \
  -object acpi-generic-initiator,id=gi2,pci-dev=dev0,node=3 \
  -object acpi-generic-initiator,id=gi3,pci-dev=dev0,node=4 \
  -object acpi-generic-initiator,id=gi4,pci-dev=dev0,node=5 \
  -object acpi-generic-initiator,id=gi5,pci-dev=dev0,node=6 \
  -object acpi-generic-initiator,id=gi6,pci-dev=dev0,node=7 \
  -object acpi-generic-initiator,id=gi7,pci-dev=dev0,node=8 \
  -bios /usr/share/AAVMF/AAVMF_CODE.fd \
  -device nvme,drive=nvme0,serial=deadbeaf1,bus=pcie.0 \
  -drive file=/var/lib/libvirt/images/guest.qcow2,index=0,media=disk,format=qcow2,if=none,id=nvme0 \
  -device e1000,romfile=/usr/local/share/qemu/efi-e1000.rom,netdev=net0,bus=pcie.0 \
  -netdev user,id=net0,hostfwd=tcp::5558-:22,hostfwd=tcp::5586-:5586

Testing:
Basic sanity testing was performed on an NVIDIA Grace platform with GPU
device assignment and running CUDA test apps on the guest. Observed the
feature properties being set based on host IOMMU capabilities.
Verified that the VM boot will fail without a cold-plugged device, and
that a hot-plugged device re-uses the resolved values from the initial
cold-plug. Additional testing and feedback are welcome.

Nathan Chen (7):
  hw/arm/smmuv3-accel: Add helper for resolving auto parameters
  hw/arm/smmuv3-accel: Implement "auto" value for "ats"
  hw/arm/smmuv3-accel: Implement "auto" value for "ril"
  hw/arm/smmuv3-accel: Implement "auto" value for "ssidsize"
  hw/arm/smmuv3-accel: Implement "auto" value for "oas"
  hw/arm/smmuv3: Set default ats, ril, ssidsize, oas to auto
  qemu-options.hx: Support "auto" for accel SMMUv3 properties

 hw/arm/smmuv3-accel.c   | 80 ++++++++++++++++++++++++++++++++++++++++-
 hw/arm/smmuv3-accel.h   |  2 ++
 hw/arm/smmuv3.c         | 63 +++++++++++++++-----------------
 hw/core/machine.c       |  8 +++++
 include/hw/arm/smmuv3.h |  2 ++
 qemu-options.hx         | 33 +++++++++++------
 6 files changed, 143 insertions(+), 45 deletions(-)

-- 
2.43.0


