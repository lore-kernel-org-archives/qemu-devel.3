Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C53AC10F15
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 22:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzP6H-0005US-Da; Tue, 23 Apr 2024 18:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rzP6C-0005UB-Fm
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:58:52 -0400
Received: from mail-dm6nam11on2063.outbound.protection.outlook.com
 ([40.107.223.63] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rzP69-0001BV-Mx
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 18:58:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDnrVkxu1AE6iNOJRtNuNd6PZWj2Uoxm7ZufqTxbn4km06DiyEdx9+lphdOMCOWYSeTdZXZe01M2SpICMnWgtQ6gb5fZWElNcJlIdcR469Kx+Aa8O+lgy1kL0yJeMFUhWdhjOt19JrrQ9wneuepvwZj6YsydHPiE8DaH88Jfb+QqlEgDw8X4ZHb9RkM4FML0UVceMgCIlFu7hLpFqro4EQ7SZXNcPxPMpVKLDFeJ6yd9o2PjnUSQ26I62j38IvD16Me+FagBs3X4MB3EMbMCx6ufze5f6E6OgLHJFPgyGCWzHqLrGvPehPHdWvZcj4Z00emI0503HfM9uZvli21bPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYvQUoiMtBp9fif4eK7lJkINGixky+KB+t5inQD4l4A=;
 b=V2wsTy0JxrnQJGXn3lyn/LbsBia701AGNcnHY/rWlrGTOc8RQIIo/Zy38/7yycvrs8zBVNqdKz0lZkMmhSULb/FsMIbss5MBhOymUHjGSKQqOTxbBnk5up0/pS52IaXqTbW+dkIweDL07i3WcUtk1wjMEjJ9KDLnZEFtCteuKvMLkOh/LYScCJnwA/z+EtX9Q6IU8RDwRGJYWwDdwp+/UqfHGgRUJOSrvWaAaxHNKe1/aw/WO5DIEdPIQOW5lQE0LFrkajbYbUdf+GmcZOtkyAa/6mxcRCa3+XfPNVusufGQ4xgozVlyMqlDv1zDnvYgUABXPyQl9uYfI0mAGARgdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYvQUoiMtBp9fif4eK7lJkINGixky+KB+t5inQD4l4A=;
 b=xYUQOaEpRLNWWmRN2QKlSuX0ssdiiZjTBbag0BwnpijODAm89XQA5FLXnf7KO80X5y5J6EI0qBba29xrxrkl8qeWOoSxl6zHii0Glj90b3zDhv2/QisGc03X1O9EZE1lZPehsL5WAJVZ6zeNDFspzdbAQlqhV6O+zVd77+ffntU=
Received: from DS7PR03CA0268.namprd03.prod.outlook.com (2603:10b6:5:3b3::33)
 by DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 22:53:43 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:5:3b3:cafe::84) by DS7PR03CA0268.outlook.office365.com
 (2603:10b6:5:3b3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Tue, 23 Apr 2024 22:53:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 22:53:42 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 17:53:42 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 9.0.0 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Apr 2024 17:53:20 -0500
Message-ID: <171391280061.1793640.6382208414891377838@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|DS7PR12MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: 519dccb4-0eb2-4e43-9002-08dc63e8397a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTdxWHhBUGJxN1Z1TlRXMERuTmZ3Z3FTR3J6ekVYaVFwQkJOUnVaM3hlWmhC?=
 =?utf-8?B?aXN5eVc3Y0N4NXZmK01UZGNNeXA2VStFU2RLTU9NS0RqSTVTeUhQdlNyaUtl?=
 =?utf-8?B?N3AzMVdBUFdEVGRQT0prSWM2Nlh2MWFUQktkcllOMVFSZ1paVUJ3eDVyWGY1?=
 =?utf-8?B?Z3BPbDJRSVRITEd6ZmtPazhYamRscmZIWFZ1NXUxam5XQmtmQnVRc00vaTM4?=
 =?utf-8?B?cld0V1QvY3FCZE41b2ltTUpUYmliSkdFVWtqbkNVVlppSmVQQzhZL29nMzNh?=
 =?utf-8?B?dGxBbU4za0JWU0hCUUpkZ00yeVEvaVZMSUlMN2ZVby92emlUSzNBT1NMajk5?=
 =?utf-8?B?bGhsVUtsb3AvTDJBNWtnWXBBY0c2SHpqcUdHL3NRSE1PandNOUtjR1pzTDZG?=
 =?utf-8?B?M1A5bTJSd3ltZnYyRWpTVEFIU3hMZHhPQ05wVytkMVcrNkxsZjVEMzB5YW00?=
 =?utf-8?B?a1FzWXZRODMxSnlFVTNzN3BvaUhFQ3dYQ2hmbjc5NjRWUS9GMzNjZmNDYnR6?=
 =?utf-8?B?djg2RXJSVEp4bnBUL2crbjZpUmhVZE5zMDg5VGZUWDcwTU9mNHRqZWZvOTY1?=
 =?utf-8?B?cWlVOXh3Z0NFVnhpYnZzaHBDUVg1Umx4Z0hqelUzSzRZYWxkNithNXg4Vnhr?=
 =?utf-8?B?cmJqRThiN2N4cGx1ZWVreTZQZVJiTStpWm0xMEs0WGRncG9yV0Q2U0NXSlB6?=
 =?utf-8?B?YnY1UmlmT2hkeTJMNjgvck1XaWx0WndEcFYxd0xqbHFZQm9ROWgzbk1pejRM?=
 =?utf-8?B?dnpXWU40bThFVkR1eDc5ODJyYWVDYk80bTdXSHBZdDVjM0Y1N2ppN2xndU1s?=
 =?utf-8?B?dUlwdFRsUWpxTlZwOVRxa1BLdEM2cWxyTWhkbG9raW9CNHhIcW5yaUdvNUZK?=
 =?utf-8?B?OGVqWThxanZzM2hTeWwvMC93ZEJ1T2oxY3hkVTA0SE1jaEtwZTNKQmpRRjBW?=
 =?utf-8?B?YlRWaVJzeUROcUlEVTNJaElwajRrOGl1WUlBQUh1clh6NjNIajBXaklBSlVJ?=
 =?utf-8?B?VlVScHNwQk52SG5TSTcrbEVNWUFRcTFVRWJ4OEFIUFhKWlN3MmNIZGErODlk?=
 =?utf-8?B?bFo5UlhobVBxU3c5WHl5QlFoaVRqMkg1RWFmTjJMWmo4bjNPcENPTjhxRCtR?=
 =?utf-8?B?M21uWnh3RTk4UXY0b3RicEx6N0xaclYrejhNYnVFeVBZWGtVdXZuNk5ZN1Br?=
 =?utf-8?B?RHJhaWNSVlh5SE84YndyQmRvcEVsRlI0a2JqRE9JZkF5SnFBcmVZQkVCdDlY?=
 =?utf-8?B?NytyTWR0ajZmdTdmbjJySjN4a1hYcy9SeFpPUTE1amtpcG5aZGRHTGhXcWNM?=
 =?utf-8?B?SlpjWkhuY0dON2NwcVE3cDBmSWxxZkU2cVdRaXA3VFJvUWtQOS84cjNHRkVs?=
 =?utf-8?B?akxCTDdzb001QmdPM1l3L0JHQmtzQmgxNFBieHVIRnNkS0JlWVAyak1nYnhl?=
 =?utf-8?B?R1pCek4rZ2dNcjhXZDVzYzJTSnpWVjUwbHBzYzIrZ3dlSTJ2VmoybzNMY0pG?=
 =?utf-8?B?QzdYU2t5ZEFpN0tWQXNaK0dhd01GQ2Jaczk5b2RTYTRQalM0V3Q5ZWlNN3lN?=
 =?utf-8?B?QUlWZTVoMUhjNytKaTYxTURzRjBwbUZGZEVKRWdhUVg3dFRKUUpra3k2bmgr?=
 =?utf-8?B?LzBMVVRISWcwbXN6RzROM0ZJQzRoUXE5MGE5N2VidjZpQlBZZTNLczJZanVq?=
 =?utf-8?B?Y0ZqVlAzbExZTGRTS1hGeXUrdld0MnhFc2VHOE1YZ3hQcUl3T0pldEE3OWM1?=
 =?utf-8?Q?wFXZaqa9M2XtEzZyw0/4LdURvfY/WhO/en7B/If?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 22:53:42.6570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 519dccb4-0eb2-4e43-9002-08dc63e8397a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5768
Received-SPF: permerror client-ip=40.107.223.63;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of
the QEMU 9.0.0 release. This release contains 2700+ commits from 220
authors.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

The full list of changes are available at:

  https://wiki.qemu.org/ChangeLog/9.0

Highlights include:

 * block: virtio-blk now supports multiqueue where different queues of a
   single disk can be processed by different I/O threads
 * gdbstub: various improvements such as catching syscalls in user-mode,
   support for fork-follow modes, and support for siginfo:read
 * memory: preallocation of memory backends can now be handled
   concurrently using multiple threads in some cases
 * migration: support for "mapped-ram" capability allowing for more
   efficient VM snapshots, improved support for zero-page detection, and
   checkpoint-restart support for VFIO

 * ARM: architectural feature support for ECV (Enhanced Counter
   Virtualization), NV (Nested Virtualization), and NV2 (Enhanced Nested
   Virtualization)
 * ARM: board support for B-L475E-IOT01A IoT node, mp3-an536 (MPS3 dev board
   + AN536 firmware), and raspi4b (Raspberry Pi 4 Model B)
 * ARM: additional IO/disk/USB/SPI/ethernet controller and timer support for
   Freescale i.MX6, Allwinner R40, Banana Pi, npcm7xxx, and virt boards
 * HPPA: numerous bug fixes and SeaBIOS-hppa firmware updated to version 16
 * LoongArch: KVM acceleration support, including LSX/LASX vector extensions
 * RISC-V: ISA/extension support for Zacas, amocas, RVA22 profiles,
   Zaamo, Zalrsc, Ztso, and more
 * RISC-V: SMBIOS support for RISC-V virt machine, ACPI support for
   SRAT, SLIT, AIA, PLIC and updated RHCT table support, and numerous
   fixes
 * s390x: Emulation support for CVDG, CVB, CVBY and CVBG instructions,
   and fixes for LAE (Load Address Extended) emulation

 * and lots more...

Thank you to everyone involved!

