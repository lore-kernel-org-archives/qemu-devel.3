Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C43C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 14:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpTBZ-0000h5-QS; Tue, 04 Mar 2025 09:23:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1tpTBK-0000e6-1h
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 09:23:44 -0500
Received: from mail-bn8nam12on2054.outbound.protection.outlook.com
 ([40.107.237.54] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1tpTBG-0004xA-Vw
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 09:23:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3Nsu84du0qisr8jJxuy/KIzFkPzOFpi/1dbiri+FoYKBcMYG6PV7JOZ92I+CirUClSj2q3M+gip5WkSLmeUUG4Vv68aPpIgnX1bmje7rk8I5ZgSwMi8pPs55+JBbXudjMoS5zulmPbXNzhnpiq7w6ZELxO27ZKS1Ab1dXgaqmshL+KTG4Fy8f8wciboAmMVM8LF4lOzKNgOxPzNUWSDb4CzZyjPxQ4FzmX3TtlJBX2lcjk/kGqFDUs+owxT/HmHku8OZ2/cVEP/47brlSV5yLCJa/dgY9BDlKO02oci9zpQlnTQX5+9Hi8i+jSjYk6Qwdyn7HNARHwnt++fXH3wrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ei3Eg8VTuTpxawByljRCXdEqauVQllaxKEneqyKutBQ=;
 b=ZKwTy7WEjQ5xeiGAQ/vMl7FAJC8BLJ6IVQeq32y/2I8KiVmJQ7ho5aeuwpLO9a5Pujty3YvXwEiGyqF1FGZqbqJSqTdEBGoIbuKvf37GziE6Us1/nDzAmYfzNpMNK4MJB/0Xvh2gsGhTTChm8nJdGfpwm08y0cgGYmCBh1nhGMkL8G1s5IsJnpR9PcVdAQJwnv+93jSqdFDzrmOf18BchDJ3k3MZbCTlNowblhA9XhZ82VuYRMjpzpwSC8pu0aJBp/lNVwdvXffQO7oIAvHAgnbFnGJ0btJcKn0jsjHgJCaEft+2TgTpMsngOQTCnFzUOJr49+4zh37EJyTUH1SFeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ei3Eg8VTuTpxawByljRCXdEqauVQllaxKEneqyKutBQ=;
 b=IjQU++b6yfzN0MFXQeFCO88NyNu4rdLOpDkoLm2Vgol80sOVzUJHsuNQyw23nnFu96X3NCtR+ZFf6zxXyheZGRHiNYcKmQ+zIm4DNY05HbyWkua7Up4bjgzN6krsSjCY7oqIsY45inSbHaDitZVo1n0L7qWx6eLNGC9vXNz/7dA=
Received: from CH5P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::9)
 by DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 14:18:24 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::e4) by CH5P220CA0015.outlook.office365.com
 (2603:10b6:610:1ef::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Tue,
 4 Mar 2025 14:18:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 14:18:24 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 08:18:19 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
 <vasant.hegde@amd.com>, <Wei.Huang2@amd.com>, <bsd@redhat.com>,
 <berrange@redhat.com>, <joao.m.martins@oracle.com>,
 <alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 0/2] hw/i386/amd_iommu: Add migration support
Date: Tue, 4 Mar 2025 14:17:14 +0000
Message-ID: <20250304141716.638880-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|DM4PR12MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: ffca70c6-84d6-4565-e99d-08dd5b276cb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2RDQ25tdHQ3MkhPa0RkT2VVOEFhUDBTNzk3ZVRXWnRlSXowMjBtMFFUcUVQ?=
 =?utf-8?B?NlczbW8zdzhiUDF4Yjk3YWJlUjU3NHhuSWJBWG03M0sxbk1mU0tOWVBxUXY5?=
 =?utf-8?B?SnRRbVRRdGQxTHFTTjZ3MTlnVElMdkkxNGVYTkxRbGpWVG80NGIwcys1MElI?=
 =?utf-8?B?dVY2bldTZUVLcFo0YW82ejBJd1FxMkFXWTZxdVZ5ZitYNmpGWUpNRDIraytj?=
 =?utf-8?B?NXp4R250Mmh3NHg5ODhKZDJ5YUZmcXZKUmRBNjdyYjVRVzQ1cTMvT0hoemFU?=
 =?utf-8?B?MzRLV1lYZGNEa0hiYTJ3RkMxbVdKazhpQlhaTHNkVTlYZE5qcmpSSG5wZTFY?=
 =?utf-8?B?UkhKdG1HZVRjcE9qTDFsakUwaGp5bkkrUC9tRW5OejVydkl6bkJ2OXIxTEpl?=
 =?utf-8?B?VXg0OXFlUllYS3pzdXBUR1czMzhnbW1KWjExYzgveWNvWWhzZ3VreTNIekRY?=
 =?utf-8?B?WTVmNUxaTkQzUXBVajJScHAwdThDeC9ZNVlOSjdEUkZQN0IrckFSRmxGMnk0?=
 =?utf-8?B?VWI2aGoweXJKQ3V0M2p0akFFRHlFekxmSVF2dUpWdUdCQnpyTlp0WnZNeGwx?=
 =?utf-8?B?SVl6QlpieWZoOXVKVzI1d0drUEdBNGRoUFpBZ3FlcDdhdEIxUWozZHpnVmY1?=
 =?utf-8?B?a0dtWStGbnJpTkFDTWFTZ0VtMWFsSHh1YUEzQ0ZaMUtWUFpXYVJPbmRvTG5q?=
 =?utf-8?B?eDdUSm0vTS94V0MvTnQwaHVQT2FSVHRHS0JHZ0xpSDIrY3dPc0dnbmFhOU9q?=
 =?utf-8?B?czRVdHJTUUEzN3pPbjMrcVpmUmxmTXN0R0pTbit6a0tTNkFnN2ZiSjNjNWRa?=
 =?utf-8?B?T0J3QmFLRjVCRS9HQzJEUTRRTEhuNm5hRjBXdzRXZHN3TVNrcVNNNDhwaWxI?=
 =?utf-8?B?ci9tNWpOQ3R1dnFIVW1WbDlEUERVUmlyejlEVjVMcGlqTmFiaUNzeTN4dEpU?=
 =?utf-8?B?UjBtcDZjeWk4R2ljZkY2OVJLdDdFeUdVMkY4bVkyNHp1QzRpcmc0NVd1YXZJ?=
 =?utf-8?B?QXJWQXdJcUhzdk1jbCtja0VtT0xEbjBpMXk0TFhwdno4SHErTkI0YUFKVFQ0?=
 =?utf-8?B?N0ZWQnErbmRxYzdNc1pKSDZhZ1ZZV3lJK2NDdDViOXJ6NkVPUTNBWDNnRkdm?=
 =?utf-8?B?UEl2WGlVYjE1dVdiK051QWpCUnJqTjJXcGNZQzNmcDNUQ1EzdWlmMEtqeDhq?=
 =?utf-8?B?aGZvd3JQTlgxeFc5RE5JK1Y5cjZta3BBaGg4aEhHQ1A1S3IxNHF6aUh3WjdU?=
 =?utf-8?B?QWxHVnA4RzI5KzFKTGFVQmRNSFBCWG9RR2g4VVpna0lEQ1pQRjltZ1hRb0hN?=
 =?utf-8?B?bVVBU0NCRGZUUCtSdlZ5QmZ5ODVVdFpTMkc0U25NRC9nU1ZoYWZobTJXQUdP?=
 =?utf-8?B?WjFBQmxSb0FZTEVBcllqOWw0azhrVGROL0QrM3RSaHphR0h5VVVMTVg5RGpT?=
 =?utf-8?B?dUh2YVVCTTZDRUc3OGxveVNneGZMNkgvZ3YyWFJnaENWYTF1U0lFYnY4bGc1?=
 =?utf-8?B?ZHNWZk1MWHh2cmczQlc3bWltRHkxZWJZekFXTFZ1YUZvMlFCc1VPbGozUGNi?=
 =?utf-8?B?Ynptb0RrRVF6Q0laTU9vc1J2cGEzUXc2RllpbXNkV0VWZWdyUEI2NWlkUmcr?=
 =?utf-8?B?K2EyTS9YVGViaWl3SXY3dUNab1FCOVo0TjcwYWJDYmt5VXVnMWNaVDFYTzBC?=
 =?utf-8?B?cUhGOVFnZ3dQY0lpNFlvT0FFMWZnb1dSNE5uakx5WmtUdmVPVTVucTlLalFn?=
 =?utf-8?B?TWVPYU9naTFidGh6L0tlMVBPZE8rWU1yLzVpQXBzbzY4NG5DTU55RldLSExl?=
 =?utf-8?B?aTV4czhBRExWdDhvRXo1VVlWdExzV25DNzk0MW1XZTNEK3ArOUdsVkU2S0dX?=
 =?utf-8?B?OHEzTWpoZUdpZ1JTSFhYY2N5UWFnMm5pRE5TRUJOMDU2RmlhdEQ5NHRrd3kz?=
 =?utf-8?B?d2R1cTlyUXFMR2JlNGhsNGVUTFpFN0UyVVBmWnhWZWN4RjJaNjJiN2JGTVUw?=
 =?utf-8?Q?/3pcup3klS2oKNXjdHdXudkVyS0C7I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 14:18:24.1566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffca70c6-84d6-4565-e99d-08dd5b276cb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819
Received-SPF: permerror client-ip=40.107.237.54;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, amd-iommu device does not support migration. This series addresses
an issue due hidden AMDVI-PCI device enumeration. Then introduces migratable
VMStateDescription, which saves necessary parameters for the device.

Changes from v2:
(https://lore.kernel.org/all/20250212054450.578449-1-suravee.suthikulpanit@amd.com)
  * Patch 1: Fix build error
  * Patch 2: Fix 32-bit build issue.

Changes from v2:
(https://lore.kernel.org/all/20250206051856.323651-1-suravee.suthikulpanit@amd.com)
  * Add patch 1/2

Suravee Suthikulpanit (2):
  hw/i386/amd_iommu: Isolate AMDVI-PCI from amd-iommu device to allow
    full control over the PCI device creation
  hw/i386/amd_iommu: Allow migration when explicitly create the
    AMDVI-PCI device

 hw/i386/acpi-build.c |   8 ++--
 hw/i386/amd_iommu.c  | 111 +++++++++++++++++++++++++++++++++----------
 hw/i386/amd_iommu.h  |   5 +-
 3 files changed, 92 insertions(+), 32 deletions(-)

-- 
2.34.1


