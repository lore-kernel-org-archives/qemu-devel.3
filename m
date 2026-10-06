Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7688DCA5FF0
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2026 01:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDu6y-00052X-M3; Mon, 05 Oct 2026 21:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1xDu6s-000528-NR
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 21:36:52 -0400
Received: from mail-westus3azon11010042.outbound.protection.outlook.com
 ([52.101.201.42] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>) id 1xDu6q-0008WD-52
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 21:36:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A590fr4fn/8yH55J0p8hsZZsfdeHS+eeCxrUdeo727RC/gj5MfhhgLGJOtUKV9uetin6RFDbrKXjsIRsvAbPEswODyP5Ogm+boM77XhUWXgoVDqEqZZ+RPNNkUZI8WvV1vG5EuAXh/sQYVGV5blm1yYbqwKUxY9Hdo6sz+CL5vQL0ZvF88LEqUj+zcegF0e3N4tPZ6O0zlXr47m0AHe8MfKJimzjpB8zfIJ10Zt/8zBYoE79TXH0vpwtgkE7dIIhmo7XMR1HzyY2mAmLq8MdE+H3oEAOCaqtJDSDFVVBJpiRCLo9+CcGWCOHnDxaee2TWfH5WeYZLyX3lsNhYK37Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIXFqfidD50UnfxzkMZ5W8GyjDGcgBHW//UZbCBI/NE=;
 b=iixktCR6uLThKaE9vpZ7Z4ijfpkx8wc0BXY2zOESFv0XL1FhJofuyDkue2p7aNRNU6bXQePcjm+Lw8NAIt5vGRGLsPF7VVFGNY84t6JESg22u2sWXQEGVnsrhBiCC41uM/uNXviYr9u6ywcb3OtCYUPT+IvQqeG9ttD2FdEJIBtiSzoNNG3v6nmuHzyeCnMsBZG/tLOWZCh5odeG+AhBa3VoxgEeIGfM/xfzBVApMl8hfjpLE5u1MKecq4zbp+roiTnvSUS29zjx4hgY9DgtUv/hKFJ3eETphkT3OkNnbj/l8OTuWunbHspuemaRQDm0b04Mv0n+Fu+r+ULlurUDCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIXFqfidD50UnfxzkMZ5W8GyjDGcgBHW//UZbCBI/NE=;
 b=gIaVYymSG7xkMUlCeI/em3WFsCNiSrCXg0joP9MfuLvylGGQYHdsZuiexHlzO1IEBfnBf1+OqcvAXfK4s8Hkzg4ME3WS5lAGoNQ5r6upgjIGvOg6DVDb1yu7Y6qQhUruO6SfNMVjDXpqKGCDKd1k/FB4GklZpcqgXj70Vc2PFjzX4RTpct9vyGtLGoGbwSE5TFb+oc4g0PlqymQfq6FWbK49xiyoDC3ogBo73pewaBcWiqWSIn7V6WIyU+m+iLXMTBvlbeyJjbQoi8e/G/EFdRanQ3IULzU/xMDqQYSz7EiY9nwMjJpbiJcumtjLHBCOpfw44AFL+atRRbyJ0+kVJQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by CY0PR12MB154213.namprd12.prod.outlook.com
 (2603:10b6:930:130::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 01:31:41 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 01:31:41 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, philmd@oss.qualcomm.com, zhao1.liu@intel.com,
 yishaih@nvidia.com, alwilliamson@nvidia.com, jgg@nvidia.com,
 skolothumtho@nvidia.com
Subject: [PATCH v2 0/3] pcie/acs: configurable ACS capabilities for root and
 downstream ports
Date: Mon,  5 Oct 2026 20:31:30 -0500
Message-Id: <20261006013133.3457555-1-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::23) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|CY0PR12MB154213:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e02605b-9974-456f-2768-08df23499302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|18002099003|10067099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: jsYVHbcloHohVaq23nTrTGvnXx5dID1tdRGsS84AG3SXy0+tPnYQJpPbU/qR9ozHh2vpldG7IYQzFL1BIsPgyK0wETFC5CSSh5s4KU0MD2KZ5X84s+fy1PmEYGQzU2xv831PWLtb9M7Aeehx2SolJT26gl/bYfH+y4MmIT703aMXuhUbcJ+YJDKRbo8yKnUgAD9cYymsIlSb6T+Hj5Itz8OjxubnXdE4AFSWL8LN+zplaP3p/i/ah395gVDeHPbnrS0AS6bXHCpqz5V72Bf9jtNVdykDnHqlR3GyWAiIIhvu5J0NBoMSJeitkPKlmZeobN5VqelL8C4O4G3yBrtPMIVL/MLICEQNkyhNIx5cHQHHSUS9uT2/YVqn9hwU48xgfyVdhIdChbJZMpxtzv84abGPHslx7UYoqnQaUxQbmgB/PJ8rUnIjOtUpilI1TzDHi1XgmiaWRkrXlYMCW7vYrZqzOPzV14TqhqDiyRoD84f1RT+1Yab1sq6PHtJ73TR0IEvl1HiQ1jlYjOtx2XjNbO69S5qxwsyB17qyLuGj/0dEZ3qDIvHHhXyFDF0j5wDtf/jIR+REJZ5V8n9L+212GGX1Cnhgz2YnZVl9j8jBme+qMBcaJW+1SlJfYTxjgwVa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(18002099003)(10067099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bdOK39xJrLPazeFcn6jw1FyW+6vAdWpLVXf9FjTBbK0gqEMDzGa+GPtPzyc+?=
 =?us-ascii?Q?4+CAJS5OJ/tqYwlQKvcvzyUE4kXpF4LTRdbA8ZRvlrC0qVtDs2vSBoBxnKg1?=
 =?us-ascii?Q?Xlh1R+cOBAItGQNHWNgTpzMt63L8QqJqs41lISDkvBzOW4ScYvyYr6D/h1jF?=
 =?us-ascii?Q?86/hJ81atptisVlucYcr9P1wxSLwhUPoQFNnwOqPsDUps/qkjodIG1tCyFfZ?=
 =?us-ascii?Q?qKK6w1rlregLu5O0htTh0cQcE3pDwACqtjtaAwS4jp5spqew3heMu7h+SXys?=
 =?us-ascii?Q?1l3YAmHd5LvaQcr6VUrIWLuoocAv8VyOgBRON+1SljIc1Mw+RV812v3mlaEJ?=
 =?us-ascii?Q?zwtsrRl/ZsY/z1b41UXvvtiMkmcP470CYgJcbdHCmLbDofKbVjViKwFBpdfm?=
 =?us-ascii?Q?e8UgowB0oPNYzsEj4SsXyWmTD7AL5BcTkN8piBPxpqqLxgBbzBAAn5QsVoZC?=
 =?us-ascii?Q?6wy5Odm9GjCS1hZ4GwyZbA4udcSFG192nlji11BbmVpPV8qXHLNveWVhxSZ9?=
 =?us-ascii?Q?Rqxpi4miy2Bc/8gUxh4LIh3bA6WAMO7HJof3A1735U3r7+bBCS03Wi0l/RG2?=
 =?us-ascii?Q?YFVRjxLAeN1+EUcMaSb1K0i8bCf9MnYthEaeGCysdyP6zeyxOQxGPlUkFyE+?=
 =?us-ascii?Q?ZmFIgS7tcSBmD8kF7IalGjyb+DKZZumzXnTBsTPq8uv8TA/mS0NNDj2pKY9e?=
 =?us-ascii?Q?Kj/9Fqx3wqYpqUfEaGm7bj6LTgIBxiuT0D6fOWYL6IE0GWo902s4s/bZTSlb?=
 =?us-ascii?Q?IK5rzs6m6Ti9ooOdUqZ/WdbOY3cZy8pLLbvgQY9lNSwND8hkyIenjdgmLBCP?=
 =?us-ascii?Q?e50n8TL/Gd8GZKPrwu9vHLmGq3gsHckB3EyyS4oXH1/k+V76f4dSy07Hx3ZZ?=
 =?us-ascii?Q?xi2oyGjO+cxsYzeQWiYLqTcT1PFOFg4Jpwq12icZQYAyDPygtXKmSl66RL69?=
 =?us-ascii?Q?ZBp04ugftz2anMvGhTjZVNlaY4i331QZceVJVl65IbqiCCM1Xuxn6e7Wx727?=
 =?us-ascii?Q?j85HL63CvAl1bF3g8KAR+29rJ19URbvsEbtNhntTsXuVljTAtEWyQo9x7aQY?=
 =?us-ascii?Q?jvnUURuqC3gJwSynmBtIE7LLxVPDoMp31oKOlQOtIPL/n+ZVptI2WNEifjT1?=
 =?us-ascii?Q?8YWbRNqBO9S9jX2xYYTiHMc58C5k4uXfg7/MwbKSjbSH8CJgV/H7sFoHzEmE?=
 =?us-ascii?Q?aktD89Jgm37VwgdPhZAdtT56H4mIGqoxfhZxjLQSx/CnpRuTAiKC24x8qDTj?=
 =?us-ascii?Q?EUCPzZsO804RTDL+QWK1cFqs4UqJSpm9JTiVUMxAh8CL5xPyG/wHL5n3IaY8?=
 =?us-ascii?Q?SbOT7/Cnwo/jM5d6yBO+/Ev2xmbFMpVq1cRW0BW8irvrA3uxSEanJuUXiFzO?=
 =?us-ascii?Q?vyzoeMrNcNKFTyg0Udl9NLrliL+ByCR2DUtVddCXcOPgMFu2E55w2UwGGis6?=
 =?us-ascii?Q?C4eSQLmTBDwdfUpkAdgyYIPP9UZEhzi8bFvGbi08BkoqVJKfy06Uy4bhYFgf?=
 =?us-ascii?Q?EQ3SjgMc5zBL0ygQLlmE3SsovAwaclEa1dSmNc1HMbL8m9U12ZaQpHLH1L+5?=
 =?us-ascii?Q?cj2F8Btp0dnPL5CiafuByvGlplIhK8FgtnWWenB5XmlE/2G4NTGoclOjsj6Q?=
 =?us-ascii?Q?dttuQd4Dl/W740U+jQ50oXXUHH3SumyVeModuNET6qLTX2fzSuM1XAK1YHmQ?=
 =?us-ascii?Q?1uTXeeQYL02DZ/91EmMfmJZvetTzHbM8kME6Q8uUiWDV2W5/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e02605b-9974-456f-2768-08df23499302
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 01:31:41.6436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oy30S+UoBP4KtWzWH1P/7ZnHRJEbPghttHoI6pFqKdEqpuzTs8byOwH1Yzbi00/9R1lyAZybdnosvUL56BVTug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY0PR12MB154213
Received-SPF: permerror client-ip=52.101.201.42; envelope-from=tdave@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

Changes in v2:
- Patch 1: Limit x-pcie-acs to the xio3130 downstream port
- Patch 2: Error out when acs-ctrl is set on a port without ACS, reword
  the commit message and the unsupported-bits error
- Patch 3: Make pcie_acs_init() safe for devices that are not PCIe
  ports, clarify the acs-ctrl property description

Link to v1: https://lore.kernel.org/qemu-devel/20260922215008.2554402-1-tdave@nvidia.com/

Tushar Dave (2):
  xio3130_downstream: Add ACS support for downstream PCIe ports
  hw/pci: Make ACS Control read-only to guests

Yishai Hadas (1):
  hw/pci: Expose ACS ctrl on Guest as configured by the hypervisor

 hw/core/machine.c                  |  1 +
 hw/pci-bridge/pcie_root_port.c     | 14 ++++++-
 hw/pci-bridge/xio3130_downstream.c | 19 ++++++++++
 hw/pci/pcie.c                      | 61 ++++++++++++++++++++++++++++--
 include/hw/pci/pci.h               |  3 ++
 include/hw/pci/pcie.h              |  8 +++-
 include/hw/pci/pcie_port.h         |  2 +
 7 files changed, 100 insertions(+), 8 deletions(-)

-- 
2.34.1


