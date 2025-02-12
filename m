Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14F5C021A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 05:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti5Yr-0002u0-Qm; Wed, 12 Feb 2025 00:45:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1ti5Yq-0002tk-3h
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 00:45:24 -0500
Received: from mail-dm6nam12on2060f.outbound.protection.outlook.com
 ([2a01:111:f403:2417::60f]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1ti5Yn-0006F3-2Q
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 00:45:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xN6zbXew1PTt6krJPV9xhnr77bE0Pt5nqETdpTQyimNFNnxccM1JfAE/FOhORKIfYCLdAUFTco4GF+rWK5nh5RH3DqdY+/TM2B0h2V7GNoJ+3hCaSDaKsjzAjSJdey1AMfra1lFTsVoUo8kOxbUBdJHrRB9d1AulhXvJmrRKcRfvR8pPR+oPUvwqWxBZnR46JtUFdSOccCB+RB9J2hysir51EJ13mGu5EZabNASjoN40gBOnHizYRCp89z0OiOIwRnMnambioBgVvbUk5JrMB5FLVHpMheN4aGRSXQvjdlG8hYan0Ep+fE4O3gRB3q0dgzgca+7lEyz0oFzvJvgF1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrCBlaDTedrbNoEEl4PLIt8TgKUaLzlW+96P+qQmdwY=;
 b=CjDBnxY7BcWhcQH/IORB5f3ssi0kYlcf06ZSGUFV+WSMyZCFch672rKqRWhkfNs8mgkyASBxJsI1PZaTQtO+JfmnQMDdG6+Kea4BZTMR91vcy+OmmWqepZ0/YRKWWxpNCjXBF3u44ZstMiKJRhG6rPQsM4DsUM7fOiKlzozkvGzmZiJLVuTJJ0RHBV8OeMkm5C7Rsu1fCZZpMglf+0mqKvtDPqzI8Fb5SWpLAbm0wb/gvSkm60NoayHsbPwR2HT34Dn2tQ2qYY3ptD9tMn5Fkkyho035ar9sJ6FqMyteTbdv/eYkVXNnRtqgSRrp0DkurPJLktauhcZNbTRUpcsZtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrCBlaDTedrbNoEEl4PLIt8TgKUaLzlW+96P+qQmdwY=;
 b=PN7ng6qAVb9ZK/F4W3UE7sjitJGmJJLjXtjw912ePtBU3a/sHgX6uknw8RAQF20+7rVXo1b3B/NOq/O36fPGHTIC91wHJNsdZcRPUMQo+bdHB4EyjkLvubfePYE/YRThvajcIDj1NCcLRWF6OzH7Tyf59Y0Wj8BLuiHujMh5McI=
Received: from SA0PR11CA0190.namprd11.prod.outlook.com (2603:10b6:806:1bc::15)
 by SJ0PR12MB8090.namprd12.prod.outlook.com (2603:10b6:a03:4ea::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 05:45:13 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:806:1bc:cafe::2a) by SA0PR11CA0190.outlook.office365.com
 (2603:10b6:806:1bc::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Wed,
 12 Feb 2025 05:45:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Wed, 12 Feb 2025 05:45:12 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Feb
 2025 23:45:07 -0600
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
 <vasant.hegde@amd.com>, <Wei.Huang2@amd.com>, <bsd@redhat.com>,
 <berrange@redhat.com>, <joao.m.martins@oracle.com>,
 <alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 0/2] hw/i386/amd_iommu: Add migration support
Date: Wed, 12 Feb 2025 05:44:48 +0000
Message-ID: <20250212054450.578449-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|SJ0PR12MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: 700a9b4d-d431-4028-df6e-08dd4b286afa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emF6eWJONzcrZ0lYeHZ0cXIyNlJ0TUw3T0J3RUNtcldaM3M5ZHhCQXd6RmVL?=
 =?utf-8?B?SGltdnY3VDFuclRWWHpUTkt2K0xtakVGckREMTZUK3dsYng5bnNFNlRuMDBC?=
 =?utf-8?B?REFJR3dYSW5ERktWeEVYOS9DS1hneENqTUhXSFNueGRDT3Q0aEtGc1F2SHV5?=
 =?utf-8?B?dEVYVEhidGZSYm5FMkRLQVFoL2JLZ0ZQL1hUcm85U3crb21kQmxQMk5ad0JO?=
 =?utf-8?B?YlduNG45NUs2ME54Q2pMY0MwUmdKeWQ1SHhydUdTTXM4dDdVU3MvL1J3aWw4?=
 =?utf-8?B?clZiYU1iSVFWb1h1TG43SEo3NTJlUTNLd2lpcFdkeERGUW9YcUlmZ1BNeG9G?=
 =?utf-8?B?bkcyRStERUcyaytUOG5YTDBCQW1qdnhsdk1ZNUtoQnZDRUJyUXRCNXRwM21H?=
 =?utf-8?B?UDBMT1JZVm1IWlE1TEMvcHRFRGphQlJCZTBkZ1dIS3Yvb3dNVGxRbVZXYTJS?=
 =?utf-8?B?Q3BFd0ZRdi9nb2I1dm5uMzJXZTU2NW5YT2FNaVZlRVp4c0JBdTA4MVJ6b0NB?=
 =?utf-8?B?TjVJaW1CMHNNOVZwL1ZIaVFhVk9DeEkvSlpNcW1XeUdPWGZTWFBaRzVXYUNv?=
 =?utf-8?B?YzMxS1QrS2k2TFoxcTB5RkVZbTJ4MWF6b2Y3RURkTis1aXA1Q1dnVXVFUXhr?=
 =?utf-8?B?QmxITWdQYUtwV2s4WTM2THN0RHB1TjlvNTd5K0grUzBuM2Y0dXJxM3NqOUZr?=
 =?utf-8?B?ZGVtaHpCN0FpVnl5blRuV0lWa0w1V2taWWRQbk1OcnlDMTUvMVFPQVNreWoy?=
 =?utf-8?B?eE9WZWswQWxyU1Z1dzZaR0JZa0hpdWsvNWl1ZDhXcFk5NXk1RTUvVEM2ZW50?=
 =?utf-8?B?a3U4c0J1eHpxVXVML3VXRG1FQUdsNCtJcGJBZFN2c00zWEdwOE5vNE15MWJC?=
 =?utf-8?B?Ukx1elUvNDJjR3p2elBkSUFVSmtxSm1PZXhvbjhQNm05K285RElwSnlOR0NY?=
 =?utf-8?B?WWRIa2gxR3c3QlU2SGROajJJRmMzSWRWKzJiUXp0dzFqSlpyVkV6MnhhZVEw?=
 =?utf-8?B?eEFjVUtNRSt1bmhnV21uSGFqNndaK0dPWVdPblFYMG9uM1VxckJNaVdteldl?=
 =?utf-8?B?cFZNczB6MUR2NWJnYkkrZzdmM0tuVUcxckhhME5nZFYzTjVmcE5XbmZndUN4?=
 =?utf-8?B?aU8zak1Bc3RpMk4vb01DTlE3UnhuRUhiTC9yT0FaUWU0WHJiRFR0eVA3WTRZ?=
 =?utf-8?B?WWxLeEFtbkZtZEJNTkpaRlIvVkNJcWoyYy9HV0syM1M3OXdYajY4aFIvQzNP?=
 =?utf-8?B?MVV1OXAxTVJQNHJvUkNTcWFHcHlSVzYyVm5KeHd4NjIrcFlQRXZ3N1RTbVpD?=
 =?utf-8?B?VW1BQzhncXRmM2Qwc2Vrbnc4UDhQaWMrdEF6Uk5oZ0w1TnZVb1FFYXVjSUFH?=
 =?utf-8?B?dWNjbzhnTTc4SjQrU2lFek81dzB0Vk5GMXlZUjI1NnpNVnFKT1BHTlhJeW5P?=
 =?utf-8?B?V2VuSGV3eCtYRzE5OTl2L2llZHBFSkNWbjc1aFVPdlFKYjlrSU5nY3BSNWxl?=
 =?utf-8?B?SnZhRXJOQWhLbVY2cCt1cERoMkR2U2FpN2g0cVFMYlo3TlU1ZHJ2OWEydVlC?=
 =?utf-8?B?SDYzZlhjL0dEbWtJa0hkSVlvUDdrZkFSTTB4a3RUd0VwQWFFVFIvWjJIeGd5?=
 =?utf-8?B?MjAwOUEzNUlOMU42MkNSYUh5RVJVamtDcVNvY2pqOWxqY3J6OVVRZHdZMENn?=
 =?utf-8?B?YWcvZmFpWUxMT1I1bFVqdjlkVENjRzV5TzBRdThIV0p5MUxFZVJBMFdMd0Ny?=
 =?utf-8?B?UnBZbCs4L2htY2dhVzlkRHNwVVhHVitCQjlETXVRWmxJUERkdm9JNGxUcy8y?=
 =?utf-8?B?ZlNncGxkeitSQnRWYzRXdVVMNUJYTVVZYnkvWW1zVnBGZjNpcXN3aWd6RmpP?=
 =?utf-8?B?UkZNdkM4bUpHNDBiQzNqQkpzVTFjd2J5VmJDVUtUWUJkWERoeHRvRDNKbk91?=
 =?utf-8?B?bFp4NmN0QTNQeWZ6YWw2d1o3TTZsZHBVb3VyK0xHNFF4N2tTQTgzcFlMY3dr?=
 =?utf-8?Q?DjgsRQ2pE+jzjmzYSlKSI384uEIR2A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 05:45:12.1298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 700a9b4d-d431-4028-df6e-08dd4b286afa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8090
Received-SPF: permerror client-ip=2a01:111:f403:2417::60f;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Currently, amd-iommu device does not support migration. This series addresses
an issue due hidden AMDVI-PCI device enumeration. Then introduces migratable
VMStateDescription, which saves necessary parameters for the device.

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
 hw/i386/amd_iommu.h  |   3 +-
 3 files changed, 91 insertions(+), 31 deletions(-)

-- 
2.34.1


