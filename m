Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8117CD4F4A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 23:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slz5e-0002zw-7u; Wed, 04 Sep 2024 19:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1slz5d-0002zT-Hq
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 19:07:05 -0400
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com
 ([40.107.92.89] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1slz5b-0000yM-B8
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 19:07:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=we3glyx/XWxhWwCHdY/WVdhbcDKLZ0bLvD8K35frsCC388VTm3LD12b7ja/5iAiaTihyVrsr6NprBO8lkhR6E1WamarJGHqbp1f01eQPEoHGoL/3f1DeGxB8KqxA7WdBWbLhsIzP3+KnuHZr/wijjwKYbimry/oqGsPyV6lMLDI7un4vKBgbdcizFGJdyUBGy0lFdi89DMyb8knAGXhIaMOdDGLK2tbDqboh/sPN7z2mq+p4upbaPdPNxDqBg2DOUzCNSZyzJsb5fzYEq3XfucvC2b8O7G9+J/uDou6e2KUYJ0oCEmHh4xeO50Q9n+fopJXvYCmU9djBjp7TEWzGBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XF7+ui+RLEVRsUmDWvCvClm878U8pA+weg0foespMg=;
 b=QzxhyVOD7eBiLikk4nlhd3md4FCrkYYDS8+F0cy9BOO1qniLn2b0EP+3MqWTJliuGtDbRX1NY5dKHgUrJMzUJnl1epqwMXaSK1a5fsy2MeLaaHJELu/irMhiRq/ww2+yb2167kEgYa5d44xZSdTfmL2PIhRonQisw7mhTrsSyYiFAhUIJA0NW9bwJFDhFM4kTq24ikEPucAMzGJhi3Ps1nXAzmoq6KmAo43TorVoKDHX58EYfhadi8hezcpb8U4dqkvopnilWSCHKB/Crr7sM7xcW6sGOqyVcjMb4TLcMpkkR/R+YUsi9M4xXNW9gdl2EonWaluGitZ/Vwv00ff0yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XF7+ui+RLEVRsUmDWvCvClm878U8pA+weg0foespMg=;
 b=H17B5vde+z/1qw016AgPtnf8dl4rNekkHZGJK3bLn5laTO5Ddj1K9gBUbL9aZf188q9Zn+yI3Z0xZ/xiLN2wD3nX3EdO3xWArBdSVy7r3xZWyymR00Pz4sjfVFuWQBK2ao7L6MVbyEHCPODBvpEcyY+hmLcSSi//RMn52dIup7g=
Received: from SJ0PR13CA0169.namprd13.prod.outlook.com (2603:10b6:a03:2c7::24)
 by DS7PR12MB5839.namprd12.prod.outlook.com (2603:10b6:8:7a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 23:01:53 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::98) by SJ0PR13CA0169.outlook.office365.com
 (2603:10b6:a03:2c7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.13 via Frontend
 Transport; Wed, 4 Sep 2024 23:01:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 23:01:52 +0000
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 18:01:49 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 9.1.0 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 4 Sep 2024 18:01:20 -0500
Message-ID: <172549088090.3334224.10887376086844748499@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|DS7PR12MB5839:EE_
X-MS-Office365-Filtering-Correlation-Id: 343e8466-fdf1-431c-4093-08dccd3590d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFpIWUtCekVEazAzSVhJbldGOGtBSFh2TTNTeC9zRytHZXdFYVAxOE5lME1i?=
 =?utf-8?B?VFFDbVhtYVZ6YVRzNTdyQ3pNRThnejFlR3picnFkOE5QaEJaZW5OWldnLzg3?=
 =?utf-8?B?UXczei81TFZoNVZ3WEVFcURxL00rZW5SRFp3cXhlUXlGU252anZyRGt3ZENF?=
 =?utf-8?B?d2NrODdCbWZkcTFwWnFmTmxPZnBMcFo2ZzFPVE5BRGUyRWk0ZGU4QnRHWDdi?=
 =?utf-8?B?TDArelpBUGRQbE1sU2RJNDNjL1pyTENkOHdpU1AweWRXVzdtNkRheTVTNWpu?=
 =?utf-8?B?eUlwVTY4WGI4M2VSWVhVU3ZLdXBJQU1wSW4zSDhFeVRLK2pRQkFZeE9PVjJH?=
 =?utf-8?B?SXZlVnlUNmVXaFRqOTYwYXdvclhuY01HSXBXQURhR016TWJKelpTZmozWWtw?=
 =?utf-8?B?cEpnZzdMZFQzU3lhK0FMSkszeHpsWjgrd2NxZ1dOSElORnpVc01HUnZYcmpY?=
 =?utf-8?B?RzN4dTVMai9oSkd0elhkZGJ3aFAwMXhMMjQ5NlJkWTVicG1pRXY1VWdDZjF4?=
 =?utf-8?B?aVRWYW9UNDNXWkhRODNpaUkwWDg1S1l1MjltdDRuVy9xbEM2MGhJV2c0bGNt?=
 =?utf-8?B?RWd2b0dnNVl6OWRkcGFUY2Y5MHhVbS80Nnhydk5xZE1jWkwyL3pBSXZ0T2NM?=
 =?utf-8?B?NTNTcGJXN09RSzljMk5XTjcvQ1E0Zk15azVidzh0eTF2TFIyeWxFQ2s4STND?=
 =?utf-8?B?OU1RMG5GQkFGcDRIZ3gyRCtwNmltc1JDRFVxY0pwajNLayt6NlJiMUVLUTc3?=
 =?utf-8?B?RWMzeklvTTdhRFAycEh1eCtPbTB6OEpFeDFqazV4RnlmaFNMcVIwbGtCZmJD?=
 =?utf-8?B?dE01OW1Ra2M3S3gyZXJaVkYxOFFHZU5KTlNDRzNOQzM5Ynpaa2c4K25uUEV2?=
 =?utf-8?B?ZXgybG9aNEp6Rm9Pa1pudEtQbUlUMFVZMkNTOTJtNnhwQ1JWK2YvMW1zWjMz?=
 =?utf-8?B?RS9ZRGxVUk5tTitFZmltWnJCT3NOdmZJMVJoT2M3WVBZTTNMSVYvUUpxNDMy?=
 =?utf-8?B?c0lMbzNGd0VBamRKYmlkS3o5VlIwS2VkRDJnYUZSU0c2RGQzNWZXWGxTV01i?=
 =?utf-8?B?VUxIWTV5QllRVGl0dUZGOTVtUWRINlhwUms0ZG04MmhCU1BWN3BUaTVWMVVz?=
 =?utf-8?B?SUNNS3JpOVQwcEJXSit1d0g4VENKRlNnaEpCaWJ4NExjcDd0MmsyaWZJQ3E5?=
 =?utf-8?B?eHdBSVBhNHpmbVNvRVlpTnREZ1Q4bE90QWVVZ2l0NkhQdWtTeFB1aHFxd0Jk?=
 =?utf-8?B?Wjk3NWJaczVQM0J6TDVUQUt2MWcwWm4xWG9HMkxkelZ6UTFwUVY2MUo3NXlK?=
 =?utf-8?B?L1BuMkJkVUNCeSt4d3RuczUyMS85TVp0Q3p0N3hnamNocW9ZTFVNRVg0UE43?=
 =?utf-8?B?VWhZbjhxRUd4aDVGelFCblF2NXMzeldoSktyUlpRSkJRdWhqYmk2Qm9tUjdM?=
 =?utf-8?B?NGhsK3ZpL1FvQ0pFUktWcWtEdHBZMmJIbmszcU0wRDFjU1U2S29wV2JocWVL?=
 =?utf-8?B?ZkJLVzJoSTQ4dDE4RytCQzBQNlZvSnBQOHV6THVNOWtmdkdKTEFnNVowOHZP?=
 =?utf-8?B?LzhxUVUrbnFCZ0MxQTcvMFhIU0ZOZUQyNEQ2VDV0NDF0aGtUem43VWpNdHNR?=
 =?utf-8?B?dCtrQzVySUFrSXp5ZWpEMHFtRHhXY0JIeG12dkZhY1lMbitrY0lSNGE1Vmd4?=
 =?utf-8?B?R3IycExYb3d5ZkZuL0lwc0FYRWdtRzdSZkpJSTJLK3Y2MEZiOGlodmlaejRz?=
 =?utf-8?B?a01yU0VKZTNhb2ZtMHVlMkRXSk5ad04raEUvS05XSDRlRjBaZXlTTUhMcjVq?=
 =?utf-8?B?dDJ5Q1ZkakFwdHBCbTVGTDh6WEk0OTZ1d3RpaDJHb3JueWZCbk03ZE85eXFn?=
 =?utf-8?Q?ewM/+ME+YkypH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 23:01:52.3004 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 343e8466-fdf1-431c-4093-08dccd3590d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5839
Received-SPF: permerror client-ip=40.107.92.89;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
the QEMU 9.1.0 release. This release contains 2800+ commits from 263
authors.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

The full list of changes are available at:

  https://wiki.qemu.org/ChangeLog/9.1

Highlights include:

 * migration: compression offload support via Intel In-Memory Analytics
   Accelerator (IAA) or User Space Accelerator Development Kit (UADK),
   along with enhanced support for postcopy failure recovery
 * virtio: support for VIRTIO_F_NOTIFICATION_DATA, allowing guest drivers
   to provide additional data as part of sending device notifications for
   performance/debug purposes
 * guest-agent: support for guest-network-get-route command on linux,
   guest-ssh-* commands on Windows, and enhanced CLI support for
   configuring allowed/blocked commands
 * block: security fixes for QEMU NBD server and NBD TLS encryption

 * ARM: emulation support for FEAT_NMI, FEAT_CSV2_3, FEAT_ETS2,
   FEAT_Spec_FPACC, FEAT_WFxT, FEAT_Debugv8p8 architecture features
 * ARM: nested/two-stage page table support for emulated SMMUv3
 * ARM: xilinx_zynq board support for cache controller and multiple CPUs,
   and B-L475E-IOT01A board support for a DM163 display
 * LoongArch: support for directly booting an ELF kernel and for running
   up to 256 vCPUs via extioi virt extension
 * LoongArch: enhanced debug/GDB support
 * RISC-V: support for version 1.13 of privileged architecture specification
 * RISC-V: support for Zve32x, Zve64x, Zimop, Zcmop, Zama16b, Zabha, Zawrs,
   and Smcntrpmf extensions
 * RISC-V: enhanced debug/GDB support and general fixes
 * SPARC: emulation support for FMAF, IMA, VIS3, and VIS4 architecture
   features
 * x86: KVM support for running AMD SEV-SNP guests
 * x86: CPU emulation support for Icelake-Server-v7, SapphireRapids-v3, and
   SierraForest

 * and lots more...

Thank you to everyone involved!

