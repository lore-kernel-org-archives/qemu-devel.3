Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F91CFC516
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 01:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcgB-0006TY-8I; Fri, 21 Nov 2025 20:44:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMbL1-0001TH-HU; Fri, 21 Nov 2025 19:18:51 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMbIx-0000Td-Db; Fri, 21 Nov 2025 19:18:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWxh7ao0982tkxRnbkzaLCAxer8xqvQo0kx/HmBnEt7YBZ/iEHBjiZ0S3JsFBmEEsoqG5eUizjGhALZHUAU/95uSzAolYdeGp8ye6bTfH7aOyVRKCbAsvT2nlUwPFyG7ikJ9n9NKIU8qwTtkMmw03H+hEwh1/ZLHwQqMpg5re1UteSbd1jEfQv1MbqGTKhdpwD5+ybgQrY3VI1PEa4cK5fTuRaRgURu8p+qgLSsUkwpYDoQSduuiie/MGRXDPa+2GFdzjY3xT42eyasRDGpNpRSCOCJED66NOhwFksyq/3+GhDEomoszht/LQAChkRTmCD6HjPQXg0IbPcqrO35pnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQW6TtERGsvXucs4u26/5rlOdBsYWm683DvlzIBsjxo=;
 b=svp1fx+CiTIFI36uXq7gXSFTXVg9GQjeoNKpogE2y+yzZ7L+7bTN8mkEfTGpKOWSbbJMpaQJN8USlo/lSa1JkyHxT0kSJHOipINICCrp7qjZTmQVrFzE2zxLJbormX9wW0fpSXQenyK4dU+xzRvvozyOKHdmRJh6yATz9NYnHiC5E/7zJcqM3FeUfHXrk4H6399fkhrnRr+V5cg/2YQqxQleUL8iImi40X3ZfQ+QqKR+fFSz3QyuP1zMnNGl5bQhJrXPnYoVl2Y7SBBStu2ttkn+x7e6lWrDkHyklqi2Tw/zMduHDkiofNkkZ5DBtKLgmVmhU+gr1VZgtnUq9IuCTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQW6TtERGsvXucs4u26/5rlOdBsYWm683DvlzIBsjxo=;
 b=bthyszqRzmSvF/RrnNg8gZp9XouAzh5IU3/fLvHHALCV5hMDfbtppov7Gm8HZe0iedhOCH6fxf0l/Ao3rTu+V++CbNdsFgR3GBxbGzunWlZv4+yT1p5Hulg8Tieb7dV/p71On7DAYB63/dDUHrJ6UGq8AKUiMY64cwxV2TCsNRXr3uZPN51YegQk+4LNVRi3y1Iy71NabmkUhA62HOZLaG0/FWrJAun3b1019DCXifN4ng3lEP27vj3pFFSUlwG+siM7PHOqpvVWioaxdgPW7GUVk/MH2zJNA8kPodAX8OMjA4EFKoU9RISSBXJnwhUqJdRr8D+PENBY2eAs6+2YAA==
Received: from BLAPR03CA0134.namprd03.prod.outlook.com (2603:10b6:208:32e::19)
 by SN7PR12MB6983.namprd12.prod.outlook.com (2603:10b6:806:261::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 17:56:57 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::2f) by BLAPR03CA0134.outlook.office365.com
 (2603:10b6:208:32e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.14 via Frontend Transport; Fri,
 21 Nov 2025 17:56:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 17:56:51 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 21 Nov
 2025 09:56:30 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 21 Nov
 2025 09:56:29 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 21 Nov 2025 09:56:28 -0800
Date: Fri, 21 Nov 2025 09:56:26 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v6 17/33] hw/arm/smmuv3: Add support for providing a
 direct MSI doorbell GPA
Message-ID: <aSCnyrcIe7kqIncW@Asurada-Nvidia>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-18-skolothumtho@nvidia.com>
 <aR+Ga0DrveuOd3v7@Asurada-Nvidia>
 <CH3PR12MB754869BFD4D1B5C65EE30AB8ABD5A@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH3PR12MB754869BFD4D1B5C65EE30AB8ABD5A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|SN7PR12MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: 80b5ca15-a9ad-4044-913b-08de292759a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmlHT1JWaW8yU0t2ZitSait2bkpBb1kzc1o4bjkyNVB0bVlJd2xnUVZ0eG1w?=
 =?utf-8?B?QWlqdWxrbjRrZTRyNXBvTVNXZ2RmWThld2hzcjJ0eE9Kc1NYRGVuK3BwQXF0?=
 =?utf-8?B?T0N4cmdKaG9mVWlMY29ISU5UNjdWc2NPcGlJdExkclhFMldJKzlZWkxkNGdr?=
 =?utf-8?B?ak9oZmNBYXN6aVY4Y1BiaEFkZHlyUFJLZW8zRWNsQVpOVTNvZFZIZFgzTkFD?=
 =?utf-8?B?ZHlYR0gyRW9qamlSZjVCK2EzaG4xSE5XQlRXekRHanhkWkJjY2xBb3JyWndD?=
 =?utf-8?B?OTdocndnd3EzOG80VzMwdXlvTnBhVHRwU2hldHFiK2d0TTRzeDMrS1ArTDhH?=
 =?utf-8?B?THVxTEN3RU5hVUNDMktYNXhRRW8xMUUrM3NaUmlLV3k4bkNLRUIybGhBODFt?=
 =?utf-8?B?M2hvVzVyOUdaMzRta0pvRWVuZVhVRWMrSEVIV3ZQeXo3a3p5U0VYUG1GUUR2?=
 =?utf-8?B?SWxiR0FvUVZyY2pKRDFNa2VzTUxaZlZqczg3Qnd3RzdKU0lRbHJCWTBFdFh3?=
 =?utf-8?B?d1VCdXJjaDlTZEdWUDNhUmZrRUdWVFBpeHEwQkM1aUh0RFY2K2lmT1RYVXNJ?=
 =?utf-8?B?M0REQkpCK1d6QVJ6ZzNLL2RlMDA0WjI4VGYxOHFJQnhJekp5L2hxVVpFMERE?=
 =?utf-8?B?TnZzVUJJSG9QV1Ruc25USHJBQU8zcFpIZ245WkJrTG1ZUVJaK0NmaVNrUURM?=
 =?utf-8?B?WURaSGhncllqQW5YekNyYjBEQkRiQ2VMR0lNdFMzdU9hM1RlVjFVZFRPbGFy?=
 =?utf-8?B?YkxXYjNEVnVaQk9ZeUJRZFZpVnRjbjF3OTBlMm90ZTF2aEhIMEVkbHV6N0dB?=
 =?utf-8?B?R3REcTFubWhkK0FsMWVMYmZnM0xEdlU3OFNnS0dVQjRrRG5MSmVQWEp0QkF1?=
 =?utf-8?B?bGNnUGcwRUJjLzZlVmFwUllsZWQ5Szc0aEpVZjhkdXFFTEJ3bUt5akx3WHJq?=
 =?utf-8?B?akFoaWxPZnY5OHdiZkovRjR5ZXBVUnV4bjdKNDQzSXZJOE9NUUF5TkNlclhE?=
 =?utf-8?B?Y20rc3d2bG1MZklxb3Fkb25qTmVBdllaYVdpU3dldzhRR1JHRDV2cW5nWXVk?=
 =?utf-8?B?S05xMldSWStlM1A1bHYwOGdzUHNmc1JWajJsM0lKWWwzdk5JV2VwWjNhSTRo?=
 =?utf-8?B?TzIxZDVIMTFiblJTSFRhcnZwd3grZW1xclVkT2hFSDhGdDJUVjljZzZwUldX?=
 =?utf-8?B?VFozNnBlWmswQmthVTY1ZUZIa1oydW01emlxaGJHMXlQR0RoL0JvaFArNEl2?=
 =?utf-8?B?eW9hL2dpZURsRDFWdjcyY3NmblJib3RGekNpVkt4RE9zdlpKeEJ5bnNZbjlv?=
 =?utf-8?B?K0Y3TzJuVjhlc2NuVWVTVkJOOE41dnViMWkxbmM1cWR4MjZoWmp1MWhRV2Zq?=
 =?utf-8?B?cXNQR3l5dzR0ZE1pSnljMllSNk1WY2dqSVZGdXhCVHlxdEo1TE9mVlpRQXFy?=
 =?utf-8?B?SU5ZUmkrNmpqWmFWb1JNR05QZTlzS2ZKK0ZSV3Z3d2ZnTEc2UFFkRW5aclor?=
 =?utf-8?B?WGdWMWNDY2ZBbUZBa284N2xQY1cyeUtvdTZUd29iSHVKYlZ1aWdXVFcvWU5Y?=
 =?utf-8?B?WnQ5ODdDd1J1Qlkwbzgra3VSOTFPTjEyL0U5a1dibkVJeFI4bEhPZlkzYkRV?=
 =?utf-8?B?TW1KOVVWbHp2aW94QWNKVGRVRHNOOHJUQkpQWlU1SkMyOVp6dXZLZFZFRHQv?=
 =?utf-8?B?QkRHT0ttdVJYQ09jNCtHZ2hkTHNNTlpPcml6VFhjVEJKWjVkNnBvS3VDbVVB?=
 =?utf-8?B?dVltUHoxTEdYZVh2STNlZFQ0ZEk0dGdhZXR3OUE4QXlJMm9sS3Nyd1VJRERF?=
 =?utf-8?B?TXdIaHRKVFk1cC9zRWxheW1ybjVWa1FXTDBsR3FKWG9FajIvOXA0SmhIbTNO?=
 =?utf-8?B?eVQvemQwU3FuVmVxS2UrdlUwNHRieHVuZWROLys2Zm1PQlNGeEhoRzVCTEsz?=
 =?utf-8?B?Ti85M01sczY4M29OUWRWMWdPeVRWNlJjTVRlR3B3M01WWUtPMHlHak95L2o1?=
 =?utf-8?B?aFVqdnVvNk13TUZ4QUlMSHo3aS9EWWhHSEVxN0J4Q2JtYVo4M1ROak9xTmdM?=
 =?utf-8?B?dUFvODZzbTAvWUZUbXdDRWIwQ2xXZVgwWFk5b1dHaTRxNXVHNDcwVXZnSHZv?=
 =?utf-8?Q?6x+w=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 17:56:51.5944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b5ca15-a9ad-4044-913b-08de292759a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6983
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=nicolinc@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
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

On Fri, Nov 21, 2025 at 01:57:37AM -0800, Shameer Kolothum wrote:
> > On Thu, Nov 20, 2025 at 01:21:57PM +0000, Shameer Kolothum wrote:
> > > Accelerated SMMUv3 instances rely on the physical SMMUv3 for nested
> > > translation (Guest Stage-1, Host Stage-2). In this mode the guest’s
> > > Stage-1 tables are programmed directly into hardware, and QEMU should
> > > not attempt to walk them for translation since doing so is not reliably
> > > safe. For vfio-pci endpoints behind such a vSMMU, the only translation
> > > QEMU is responsible for is the MSI doorbell used during KVM MSI setup.
> > >
> > > Add a device property to carry the MSI doorbell GPA from the virt
> > > machine, and expose it through a new get_msi_direct_gpa PCIIOMMUOp.
> > > kvm_arch_fixup_msi_route() can then use this GPA directly instead of
> > > attempting a software walk of guest translation tables.
> > >
> > > This enables correct MSI routing with accelerated SMMUv3 while avoiding
> > > unsafe accesses to page tables.
> > >
> > > For meaningful use of vfio-pci devices with accelerated SMMUv3, both KVM
> > > and a kernel irqchip are required. Enforce this requirement when accel=on
> > > is selected.
> > >
> > > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> > 
> > Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> > 
> > Nits:
> > 
> > > +++ b/hw/arm/virt.c
> > > @@ -3052,6 +3052,14 @@ static void
> > virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
> > >              /* The new SMMUv3 device is specific to the PCI bus */
> > >              object_property_set_bool(OBJECT(dev), "smmu_per_bus", true,
> > NULL);
> > >          }
> > > +        if (object_property_find(OBJECT(dev), "accel") &&
> > > +            object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
> > 
> > Do we need object_property_find()? A later patch seems to drop it.
> > Perhaps we shouldn't add it in the first place?
> 
> We need that at this stage as we haven't added the "accel" property yet
> and that will cause "make check" tests to fail without that.
>
> We remove it once we introduce "accel" property later.

Hmm, I assume object_property_get_bool() would return false when
"accel" is not available yet? No?

Nicolin

