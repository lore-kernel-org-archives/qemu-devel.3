Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89A9CA0FF0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 23:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur37v-0000Iq-O4; Tue, 26 Aug 2025 19:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1ur37u-0000Ha-1g
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 19:30:54 -0400
Received: from mail-bn8nam12on2062.outbound.protection.outlook.com
 ([40.107.237.62] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1ur37q-00022D-1h
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 19:30:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rdy78XVvDrLjJYEoE8TbPfoTGwKo4DCUuoxPSc+P3sEPumWIfC6EDB+UON+WH5QTEgT1vULlHNfqtuTDMK9w68bU6GaMdPZVEHyHvf6+iOG86BmVh2/5sURGG76JjqBrUe/kcDNRjn4jTp6YvLKNX3/rGBt8DKKlPSx++guhTUKhSkFD35s+LH4GVOyr0cFSGV+iUnavnRdx0y9yBo/bP61w9WWrpCDuFYSJAgw7p5Rsf4Ng2Ml7IiiP7CI5Mo5sD4NrdYMQYNfg5BMbRkB5Qe0jQSoX3fTh347l5g8kjMEg2q0o+5WrJ/741eG4ak7l+s4b6A0OXyeO/yFY9Tsu2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZQyqqqw6J9xeYtwz8O5EYcbp5HKkUbLEnbsWxVPCCg=;
 b=uAmIlGIT9G+wEzP/kdzgH0aKnrxHmLzRTdUO9vvKtb/wW1ezAFN8tTxhHQD4LD2rH8Wjr4xavAoj5S0TZQon7Vbx1t9MFXtpXFT6SjEVkaspjdYR2xl9cgtiZJ9q8Vi0lOZKYmJmJuyqXYZzheKryP4Cgt7EndwZwQwvRs6/zvDx9aboN45bBXOP2vk9g+erCQHPhmG80erkP5xX097+A/55Spd8cWFyk55ecE0d11pQMMedjJSz9GUlWRmWGmK3l9QttPAaQtqhZixzLrtTd0EXKY576KaALpOhFOOjwLzq+xbZULoY/eobNrlypXrYa2gj96AeO573mrXij43b8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZQyqqqw6J9xeYtwz8O5EYcbp5HKkUbLEnbsWxVPCCg=;
 b=Oh7KVmLzSyjVcRpfXgLfecg+ufTzf6Kwg8tdZugeAqLKIIec+DJVgu08PzO1h0p+gsC1S4jiOyJWQ6PYNDyQkTXd4gDGkOzHjEg8wCA0zHUk/mFSySoRZQe1XCucxHCbb6WXZB9x4KIrzd4CzBKOPkauFHu7Fk6GWgTNO4fbYaY=
Received: from BN0PR04CA0107.namprd04.prod.outlook.com (2603:10b6:408:ec::22)
 by MW4PR12MB7118.namprd12.prod.outlook.com (2603:10b6:303:213::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Tue, 26 Aug
 2025 23:25:38 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:ec:cafe::8) by BN0PR04CA0107.outlook.office365.com
 (2603:10b6:408:ec::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Tue,
 26 Aug 2025 23:25:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 26 Aug 2025 23:25:37 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 18:25:37 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 10.1.0 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 26 Aug 2025 18:19:26 -0500
Message-ID: <175625036608.469964.4138433906168641553@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|MW4PR12MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f4c7bc-fbaa-404f-a765-08dde4f7dd38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTRKc2hhcTJlRFluaEp4cWxUSm9OelgycEZZank4UFBGQkF4ZzFMcnZFcjVo?=
 =?utf-8?B?SWlVbkplOFJGTUhKQmxQcmJScllGc2N5SHhpT21mU0Y4emwyeHd2ajlNNmFi?=
 =?utf-8?B?N0VwZ25oTCtjR2tVai9TQnNkR3c1U1FhZGNYQ2RJb09GN2xWN3c3aDBqem51?=
 =?utf-8?B?N2M5bDFXQ05aZWtyQ2ZnMERod05pT05IRTVSN3NTMkdqOExxcVp4WHU4SHlK?=
 =?utf-8?B?T0VMRitsMkZiRkJwVWcybERwOCtuekx5TExRWmI5YTkrU1dsVUQyOXhYc3hx?=
 =?utf-8?B?dzNFNGVWc3BTMVBSVGQ4YWlSTkNYbkJWVGxQVnVGbk9od3VPTW9uR3lKWVZ6?=
 =?utf-8?B?aHpQeGEwUVMvVzllUkRMekNjTFBTTDBqWnB4cjZpdFh3ZWJFQURWS1FqMHJ1?=
 =?utf-8?B?Q0NZcFNNTlliRmUwbUlUVW04YjZBZ0twSG94M2lvSitQVG9idGFuMHZybXMv?=
 =?utf-8?B?aGYxSmMwUDFzSUkrT2cxak00S3ExQUUxaTN2aWZ4VW5rN2FRcUZoUDVyWERm?=
 =?utf-8?B?cjd2Z01CckQxWTNQb2F2Tzh0RVJrSzJnbGZReVFCajQzRnBKVHBrcmVQUUtD?=
 =?utf-8?B?Q3NreXZ4aFFsUW85eU9CcitRVm1hREkzdVF6MXpUbkkwRzBnTTgxa3ZnWTIy?=
 =?utf-8?B?MTNoWitrUzF2ZkI5ZlRqNC9GZHhUT2d1dFhab09OZXV2eWFkdmxsNUdVdVI1?=
 =?utf-8?B?cm5kQWdzc1doVXMxT0Q5RnhjaTZLTGY2bWptaWdXeXZhanlFZ2p1ZDNqT0I5?=
 =?utf-8?B?TmVhZ2RYaS9NeFV2U1hDWHVMZDB3Y05keHUvSUFUb09RVjBFblZ5Skk4L01i?=
 =?utf-8?B?MDRkbEYyTk54cE0rd2wzaFMxVmNJRHBlczQ4WldTcnY3Zm1qbFE0RUo4SGZa?=
 =?utf-8?B?Vy9zT25TZkpwWUJGVUhTS2VXd3BrTmdiNEt6REdldXZTZFQrMlk4aDhZaExN?=
 =?utf-8?B?QlcxK2FXT2syaHdaOSs1RmJsYnUxREVuS3JUY0tEWThUWnFoK1hTeVkvN01j?=
 =?utf-8?B?Y1VmZklVT3dSbG0zUE96Q1cvQUtnaEJISFdlSDFiQkxqekhBQmd6QlN1cllC?=
 =?utf-8?B?VC9QbHdoWjI4UlppbkhFamJWMThuTkcwb1VxWFQvK091NXBzZjE0aUdXdTFX?=
 =?utf-8?B?Sk5hTmVsRzJDVE52azJvbGtJUVRxb2hzMVZnYWUzbmIzNVlia0hSVjJyRW54?=
 =?utf-8?B?eHBuaSt4WkdGdmw1ZThITkc4MEsva1kzT3JvYlQxQUFkV3FBOW9GZ0dvL3RQ?=
 =?utf-8?B?OFY5Yk1IdE9wQzJHQS9zT0lvaWMyRlM1a29WbFNqS3RZMDJwdFlCd3gwdWUy?=
 =?utf-8?B?NVpTSHRTNHFETDZEbjEzNXpHa3RZRkptNTdGSllYTVFEQkRVRFlDZ01TZStF?=
 =?utf-8?B?TUNHaXZwNVZuak1kdHNDWTVQUTg4TWZQT0xPMmVrM0daeHRpa0orN1NUc3pu?=
 =?utf-8?B?ektPQ3Q1N2o0aGJUWTBtQmFiYnhkNUZoMEp3WVlrN0NpMkZDemdWNHpPMCt5?=
 =?utf-8?B?ZWJ2VVYxSTVicktUdllLMVdHZ3NOemRuajFLYUFVYjh0Qk85RXRNV1oxdjk5?=
 =?utf-8?B?bmdtNndiM0hYVllpOWxaY0ROQS9kWmN4UHR5S2Y5WEdvQ3FBNnJWZk5LUXNw?=
 =?utf-8?B?T1MxR2xFWHp4TlFTVUhnZ2ljdnFhQjVjTVY5TkxMbkZXYXBsRUkwaUlZd3Zs?=
 =?utf-8?B?NVR0cUZ4Z3ovbkg4KytqeE9qMGZjK1pJQUM3cVJlOFU0bTZVeHEydGV2Skhv?=
 =?utf-8?B?YXJrUVhsb3VLNGQ5dzJvcDIzT2s1NkZMOE93MFBqS1FGb1FtSEFLbnNONElG?=
 =?utf-8?B?QW02WHhnTVROdExKdDNsV3AyMGxGVXNlck5vTjRjS1hkVWFsWlhUNkZlRHU3?=
 =?utf-8?B?dWFQTmJYa1FobHFDc29rQjVNWlBnYVB1M3Q4WU9oQXZueVRteFEzY0JxWkVv?=
 =?utf-8?B?ZlFrVzd5M0h4Q3FidTJPd3I5N3NRZ2tVTEk1Y1VITThpRTVFdlc1MHFQSGQy?=
 =?utf-8?B?M1hlUVMyWlVBPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 23:25:37.5581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f4c7bc-fbaa-404f-a765-08dde4f7dd38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7118
Received-SPF: permerror client-ip=40.107.237.62;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of
the QEMU 10.1.0 release. This release contains 2700+ commits from 226
authors.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

The full list of changes are available at:

  https://wiki.qemu.org/ChangeLog/10.1

Highlights include:

 * VFIO: Initial support for accessing/mapping memory for confidential
   guests when guest_memfd is being utilized, allowing passthrough support
   for virtual machines running under SEV-SNP/TDX
 * Live migration: support for utilizing multifd to accelerate post-copy
   migration, optimizations for pre-copy migration, and RDMA migration
   support for ipv6
 * QEMU guest agent: support for querying load of virtual machines
   running Windows via new 'guest-get-load' command

 * ARM: support for CPU features FEAT_SME2, FEAT_SME2p1, FEAT_SME_B16B16,
   FEAT_SME_F16F16, FEAT_SVE_B16B16, and FEAT_SVE2p1
 * ARM: support for new board/machine models 'max78000fthr',
   'ast2700fc', 'catalina-bmc', 'gb200-bmc', and 'ast2700a0-evb'
 * ARM: 'virt' board now supports nested virtualization under KVM, CXL,
   and ACPI-based PCI hotplug
 * LoongArch: support for in-kernel irqchip
 * Microblaze: support for selecting the endianess of 'petalogix_s3adsp1800'
   machine type
 * RISC-V: ISA/extension support for atomic instruction fetch (Ziccif),
   'Svrsw60t59b', and numerous other improvements/additions/fixes
 * RISC-V: support for Kunminghu CPU and platform
 * x86: KVM support for running confidential guests via Intel TDX
 * x86: Support for initializing confidential TDX or SEV-SNP virtual
   machines using the IGVM file format

 * and lots more...

Thank you to everyone involved!

