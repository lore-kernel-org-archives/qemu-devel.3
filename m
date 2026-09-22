Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57072C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x98SZ-0002sE-Ki; Tue, 22 Sep 2026 17:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1x98SU-0002ru-UI
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 17:55:27 -0400
Received: from mail-westus3azon11010033.outbound.protection.outlook.com
 ([52.101.201.33] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1x98ST-0000sM-4g
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 17:55:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZU9Ps5CvQUL1xQHu14i4rV8vANhnvA06DwVyqkow67htcQIxNJlKC9psr8NZgpPFq8iQYNs0SFbPuq1Df0KdlxLs2HO03q+K9akfzL6LOO1CRy32wvxFiRWdHvtOyP1T7SiZcJQZgPpxhQIAys4bcP+1ODd7KTqH3FAxHL/WgW9ADVBPeMLbSjEnyITmgDJrahiUm016UaOtKGFqGevnY2iU1BuBrRVjWyko+PaG/fUaFRUV02lSxd5vwwM4pahT6Aiy80ExOU3k4JlUwenQMVo8y0g/M9PYyqM8HyiM7pAz/ZdXx84mO50VNJm+6F1sdjdtJV6FTfq3qQ76HMadJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6pgzYhj+ITVu8Uqmq7OqfVpp3AW2blAsva8/2Dq1KA=;
 b=oRitLJ9TXQeHPdsV4pjl/X4I5cFwCHx1nTxDu1tMi0VWiecQyQbSTtk5WEg9RMU49AQXroDc+7q1jmbiiblrFLRWpRKEVKWuMUU/8yE9YHmIoY0DND+99IHo6bAnxjUupD1brgm9v/7Q8s2t/1HTBAZpgofWmCu9b/9SFmt5VNDO9uUGxEJHsDKU6cUXvg2lFu9N/dMuJfjhoDYzGuSpNqnBKyZV1BFENpV+KAYhO9zy6ZUTT4N5I0GMhwzdsEKiseSdJPJhKfkUqTLJ7mK61NaSbp9vns6SviEChDVqz7FIDYXirBPj9FOmg+5ilJvuiJhNFmBqjPpV2wAx3Bg8kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6pgzYhj+ITVu8Uqmq7OqfVpp3AW2blAsva8/2Dq1KA=;
 b=KNouRRNGPvYKFDCh2EyGXMXLZTauXIQnjp5Rubza0Teqla4YU4t7TpDi33+q49tz2NndtMKz3at/Wzt1iVCDXVu/sScoTTPjSdyVeVwcmW/3xhOVIwZHk875vgnHKXQZMmv4D4A0+F/kxQvs3ChJh3EFSZVHVmqEn4kZBVSxDAdZAqac/ERkBQpndzP09o+U6aWc3cHrpLCi2BjjEY2AQwcxj5D4IL6CF1b9RW50hiInyWoOKOz87XfDdETTLNaR6LnesosjVi2lIy2YPEDKYW2/ZcLdGkghieTnNEF/upRRBRBCyB5Si51gCSAazO+T/fLqV47NcNNBbcfq5OreZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by PH0PR12MB8126.namprd12.prod.outlook.com
 (2603:10b6:510:299::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Tue, 22 Sep
 2026 21:50:17 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 21:50:17 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, philmd@oss.qualcomm.com, zhao1.liu@intel.com,
 yishaih@nvidia.com, alwilliamson@nvidia.com, jgg@nvidia.com,
 skolothumtho@nvidia.com
Subject: [PATCH 0/3] pcie/acs: configurable ACS capabilities for root and
 downstream ports
Date: Tue, 22 Sep 2026 16:50:05 -0500
Message-Id: <20260922215008.2554402-1-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH1PEPF000132EF.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::37) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|PH0PR12MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: 109dd20d-65b4-4030-ec61-08df18f37d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|56012099006|3023799007|6133799003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: w1MJDbbXsAjYhMgxGbZQ8mwKArAPgxbstg00waMlLGEnzogPeOz76Zc22e7kiD/aKkdIKnYRwVNl4NK7fTjO4uJA3mRtngxYB8kS8w/OLf4Ol4yGpCijtE5dDs9T4+P0Dar2FHE5hFaTo1Dqd2OZpE2RidH7tuOG9nnNYixIBXXVI5VZlsO7IsqmfFhXpus9P8LwEbtv0q3JxLt/33bPWNDg8HFOpinFkeJEFqIv3vS2w5RQb3LMNaz4UrRYOTfXjUrqXV6S1WvMC+Hn0IxMB73sGrzJ4qZ6ikpJ0jV8TDcth7P0exHLmJiU8MUKSbKqyBPym4qELiueDNBQADfSChXk9V9Aq3NJ5kmDj8ypashzJFzFbUn3NisWTQQSxYM/KmvCr77MyWp5pNUfQoOdi5NeBEN2Ipozz9hnPPIqID5T/YCezoUbCPYweAWtly6zIGjMX0bay/H6q1PiGOkGFVap5XoV0XoJAbGjxUgleW4XqtmYdnn5QXgPrwZmiS97ap0cbMucKJQ758EYUuWpiNQZfpKU53A58iQMsyimIIQOTF5Yj0HBJ522kB73EqLgB7ZLkFs+e5EHOB4HxjVF/DyjNSfhO+LkMJGe78bnWMy02PjVz7sTx86xxzDNVm81Tc/F6/fe9+QPGMQcPGoNtffLncCPSCzZQzfNqoADE5U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DrzaK9I0bGSs/8KuEeF0Q16GbChaSadsl3aLJOiMNO841O2Xthj/xDqk28kO?=
 =?us-ascii?Q?c+x+CeQCBMueb5kJh9+r7eN0+F+TzlBGWC7XJv2ZOGXvreW3xaT59/e5L8wF?=
 =?us-ascii?Q?Ut7p6poYD7fULMf/O52YXkhddOR7WVXx2iMvw5BvBn30Z3r1Oe6+ccOLULqQ?=
 =?us-ascii?Q?W1Hsxd1JhUOrfk5NDF+CVqd8QDy2EYhdTBnZyTIz2vHPqcvdEvY61rs8ap5g?=
 =?us-ascii?Q?5zwyQZntXmE+bs9/O/7qxEH23dGWiserc/wXpXPOng62lwzFdg0mmYgYkIQs?=
 =?us-ascii?Q?IkwiTAlYB4CeVB3anyYBiZQV1KZhq9QSNmaLNnaec5Z1KvD97t4NlR8t1609?=
 =?us-ascii?Q?HYJRzU6D3Q1WvrvBpCCc3PcqmFLs+Lfhtdp1yUYL2qBRzpV94TAddw+7wv+l?=
 =?us-ascii?Q?FBJWponzCY9bo5TltRlHOxYHPZ3vwYXQexgo/UUhX9imfcPV02icSksihf8F?=
 =?us-ascii?Q?27u74o38sqAqLbn1Hrudfv/0fbZbfIB4mLHXC3QAE//dpevUOVexica3qO06?=
 =?us-ascii?Q?UyXjyKxs/AjF+jtebbL0x+EnSPhBx8j/bIxlXnBaVLQHeqE7hq2pM2i6Jl3L?=
 =?us-ascii?Q?CWA+5tWbgGuayoeEVwxm+hBr+Z6ty4wl7Yj0uRmofQAcov1C5GANZRlT/nr2?=
 =?us-ascii?Q?1utFNNLnWjPV3GBl+jn01GO9+wF1v/S02XIBoMD8OksiL5zWOte1zXC5h4f2?=
 =?us-ascii?Q?tDn/SCN71S1WS9aqYfMZEJsRqF9jbL6WslGMlICT57p4l4Ib7OmRBy1KpiVG?=
 =?us-ascii?Q?8UCexHt7NyvQegAeW3JH8JwqPGFqfawmoD5vc/sITq0vEnWLaOC65bCuVAon?=
 =?us-ascii?Q?/qEJrl+rj2EhlZPQ8u+TyXuZJEojRcdngugyc/IMWSj1cJlnI6x125Vg1TvH?=
 =?us-ascii?Q?SF9jtmsuUrl08hUEl/9tL7cP9YauenBaW6OLiL0UNqdHrEleMusN1FnpI0GO?=
 =?us-ascii?Q?LuPW0FtgyZJs3MOaNPWNazRxckWQ4hUX1XNEynkbNiX6pyQvs4FNMl3bTtuQ?=
 =?us-ascii?Q?T6S1NwlRkgjvBFrnaDN3b43UqZc1b9krV7COIxd717FvyvPq750w5VNlCLfJ?=
 =?us-ascii?Q?HJ5cczWNOD5yu6KGgwAp+nShVMNA4gOZZr+mAwg40O8205hS/qPsZ38NalKa?=
 =?us-ascii?Q?SL9/8RNzJbxLtJWArvqm2qdG2Wk0hjL+qE3jqhuUKyUXFE9tDunURBj7Ytbn?=
 =?us-ascii?Q?o7MZGXpVuCcngHMri/wGbGBWwkuu+EBFNqpwH/24AjmvpqYOT587U93mVvoL?=
 =?us-ascii?Q?UoqNQ33UESQPpQSCPh3ptTgjitrobuyDE1C3oocIrsZK9yZARL69KiFKmtiE?=
 =?us-ascii?Q?Bpn0zVqldIxarXlPIraCUpk+KA4OqVWi6zuUWGtEjuYv+Ns2wp0sOFsUsDMe?=
 =?us-ascii?Q?OuCw4L+o6H0a2kC/s574/X2YK+3yxyPRT+wH/jsFoYdQWbsO6Z369G81EQ3d?=
 =?us-ascii?Q?Rpf/ed3mI2dXin/9emuy6Qw5pE1FVT98EM8T+p/LfZcOSRFeTQSX5KiVKX4w?=
 =?us-ascii?Q?kdV0vjueHJadU5NiWcQgVRB6vy8YjtR4fiPrqxI0GqOxnVV2zd3eNUMB9Kwz?=
 =?us-ascii?Q?BJ6pihzdBwEmoZrOsjwu/2GVmhzwsOvwUQasnSeb3mjL2j6H8qNAJagKuR+s?=
 =?us-ascii?Q?45uoZhGVKEOi/M2g98av0z73n5z8+l/CiG3tGVTgxahG6pr7xBPi0xadJaib?=
 =?us-ascii?Q?gtUYIGvGLLMyOpiKnnzW24ZnfSY0h8QxPgTLJKGUzXtXqZJd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 109dd20d-65b4-4030-ec61-08df18f37d61
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 21:50:17.0109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iul34cH6ohJnyBMq1kWMRZHUubU/fZhHiawpa6/Mn1nyptVu32QkMALvhSk1fQIesh45rT+QHMgemwelilpENg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8126
Received-SPF: permerror client-ip=52.101.201.33; envelope-from=tdave@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

This series adds an 'acs-ctrl' property to PCIe root ports and downstream
ports, letting the hypervisor expose a specific PCIe ACS (Access Control
Services) configuration to the guest instead of QEMU always advertising
every ACS capability the port structurally supports.

This matters for P2P (peer-to-peer) topologies such as GPUDirect RDMA,
where the actual ACS configuration in effect must match what the host
side is doing -- otherwise the guest sees a topology/configuration that
doesn't reflect reality, which is undefined behavior and can fail either
in software or in hardware.

Patch 1 adds the missing ACS capability to xio3130 downstream ports
(previously only root ports exposed one), gated behind a new
'x-pcie-acs' property so older machine types can disable it via
hw_compat and preserve migration compatibility.

Patch 2 introduces the 'acs-ctrl' property itself on both root and
downstream ports, so the configured value -- not just the maximal
capability set -- is what gets exposed to the guest.

Patch 3 makes the ACS Control register read-only to the guest once
'acs-ctrl' has been explicitly configured, so a guest OS doing normal
PCIe programming can't silently override the host-configured ACS
state. An explicitly configured value of 0 is treated the same as any
other configured value (locked), distinct from the property never
being set at all (which stays guest-writable, unchanged from current
behavior).

Tushar Dave (2):
  xio3130_downstream: Add ACS support for downstream PCIe ports
  hw/pci: Make ACS Control read-only to guests

Yishai Hadas (1):
  hw/pci: Expose ACS ctrl on Guest as configured by the HYP

 hw/core/machine.c                  |  1 +
 hw/pci-bridge/pcie_root_port.c     | 11 +++++-
 hw/pci-bridge/xio3130_downstream.c | 14 +++++++
 hw/pci/pci.c                       |  2 +
 hw/pci/pcie.c                      | 61 ++++++++++++++++++++++++++++--
 include/hw/pci/pci.h               |  3 ++
 include/hw/pci/pcie.h              |  9 +++--
 include/hw/pci/pcie_port.h         |  2 +
 8 files changed, 94 insertions(+), 9 deletions(-)

-- 
2.34.1


