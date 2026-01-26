Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40693C88E6B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 07:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkHSc-0000C6-Gz; Mon, 26 Jan 2026 02:56:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vkHSL-00009u-W7
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:56:19 -0500
Received: from mail-westus2azon11012041.outbound.protection.outlook.com
 ([52.101.48.41] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vkHSJ-000659-Vd
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:56:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WaiAN30OhLBURzySQ8EPBQDDbXHJXyCkhTOklU0BcYC0zFur3c4d43o1Gr8binsKdybb7KyqWsf0Q88ANMkZRMYLzcfkkQu57CQ/DdjhHXu2bdMUQoZSc5qEMuWEPYjnMVViqWwuMfZMByzkExyZgyo2+6XbP9mY1FsV+8STUAQaA1xR9ovNX9CXjd2jt0hSiGTXys37xgvrOjW5Y8CErTDB0kRObzNILBGRC4jv3Acch2PLmZJoT5165wIehPeMG5DKfxetzYqSoshiKN9+titdvg4DfCojF/C0wOtEyZicqNY8N0jO2rnOy1VqQhSqH48Y6ysR6zXdXFNYfo7Lfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUnHz+LiInqXVib4hJSP5YIyy7XCfxdUvTbGc3fVpfg=;
 b=Ko0DwcqOff8KlYJaPqiNWtTM551s094Tc+gjy34LE+6cUgcjp3D75MM8c06zaxPLYzZQkgQKVOh0jn+YHHuIUsgvchx3i+ueX+LPLfC1WynByEEowXzPu+E7o4Ko0ZjvGxZu4AWXUs26i09hDDqkk7OhwUShu7gtqQut5F8NNFWsjjGpsbkLC2rSSWwxLRUuoj/ZJszpgW3zqkqRADLScs+Kq8prQqsw/x30FblRRkzCmTFsDb0fLzMJo2YTWV6ovJPzrJ9J9mQvePhQUiBcmMk/dA6uJYtBwGM4w8hLAcHLFyV5LfWT2VA8hlsfQGlgD8fupDL9XuZWvFIsuqzsJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUnHz+LiInqXVib4hJSP5YIyy7XCfxdUvTbGc3fVpfg=;
 b=MRSqxcm+jmZDbb4jAxtHpWYVWJ0YJ/2tSXHBIWCoiPDm9SfMRcx7nIwS80iWUbIP0BMkoOpFDbkp5v/+iAphaQ2CjzmirJJP3NLW1o1vlq0FvYgPpQhkcDJW3aCF/nATPGHYjLVQFuzS1JIhMx9999bueaUtK6X4UVrpL8tv82E=
Received: from BN9PR03CA0542.namprd03.prod.outlook.com (2603:10b6:408:138::7)
 by BL4PR12MB9533.namprd12.prod.outlook.com (2603:10b6:208:58f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 07:51:09 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::7e) by BN9PR03CA0542.outlook.office365.com
 (2603:10b6:408:138::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 07:50:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 07:51:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 26 Jan
 2026 01:51:08 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 26 Jan
 2026 01:51:07 -0600
Received: from [10.65.98.30] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 26 Jan 2026 01:51:05 -0600
Message-ID: <a3447b39-a317-4aa5-ae8a-dd6a441a6a70@amd.com>
Date: Mon, 26 Jan 2026 15:51:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/1] numa: add 'memmap-type' option for memory type
 configuration
To: <qemu-devel@nongnu.org>, <david@redhat.com>, <imammedo@redhat.com>,
 <gourry@gourry.net>, <jonathan.cameron@huawei.com>
CC: <apopple@nvidia.com>, <dan.j.williams@intel.com>, <Zhigang.Luo@amd.com>,
 <Lianjie.Shi@amd.com>
References: <20260123024312.1601732-1-FangSheng.Huang@amd.com>
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
In-Reply-To: <20260123024312.1601732-1-FangSheng.Huang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: FangSheng.Huang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|BL4PR12MB9533:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a8fbf8-c964-4171-1441-08de5cafaaf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0RyNG9zQUtwcGZObjFBS0VSektOako2Y2lWdVF0eWVlREZRODQ3em94eUVF?=
 =?utf-8?B?QlhYQk03akY0TCtZdXBqMDhsKzIrWjRtVWQ1WGpGTjZzR091TndDcEdEanhW?=
 =?utf-8?B?Z1NBMGwrOVdNcktBUW9EMmtpd2dFVjBSUFowY2VvaWZRMVNiaURwUlcvanNr?=
 =?utf-8?B?dDIzSWttQ3RmTzlCSGx5K1pvMzkydllnYWlzOGRmRFlwRDBNdkVpckxaNTVW?=
 =?utf-8?B?K3lEVlFTTkJkQ3JWV0VpbVp3czJZa0YwVkNuQW5UQVdScHg1N0hFeEgvSzQr?=
 =?utf-8?B?NEJEUHlPZ25JWHpCTm5yeUkxYllsQi9kTXRxWjdxOWRBUXc5R2FGdk16TFc1?=
 =?utf-8?B?NHllWkpTQ3BYelIxVWxOdndGbVNUYUl2b3JXNWdCT2ZpeCsyNmRFWDBrYlVq?=
 =?utf-8?B?ayt2TWQxd0E2WTd4bWhOeFd5ZDJ2VGZ0QXFtVEdGWW9hYk1Ga2tSOWNvaXAx?=
 =?utf-8?B?RzBtSnBuejNibTFnYm1VQ003dHJOQXUwNUY3d1VrWkRwQnlxcVlvZVBMbnpG?=
 =?utf-8?B?SGJNVXU1d3gxMzUxenJoVkY1TkhYaVpEaEpLcUdpY3ZFclR2QXdreUJkZUR4?=
 =?utf-8?B?OG5iNGo4V2REcmFIdmh4VzZiV3NlSS9tK2VQb2MwSDBiaUduVnZwNGZtQ0Qz?=
 =?utf-8?B?RWx5ZFkwdWkwdkQ3WHVmMnZEME45czNRZEViTjdDdThSenZRNXhOM2NiUnZQ?=
 =?utf-8?B?WEY5enRCM0JEcFZhZk9aclZMWXlxRnVUdjUzS3U1RWhBNXBvRWRhdUppa21r?=
 =?utf-8?B?eTg1c09SMk9QUGEvZlVkZnBaZ0xOWjB4R3o5ekxKdnVrbnpVNHN5MEtBRGFM?=
 =?utf-8?B?cDZwTTh3c0U5OVVtMzVLUWpJaWRXT3lKdlpVeWs4R2VndlFkT1hWZHlhK0tq?=
 =?utf-8?B?NHFYb0pUdXducjdRRjUvYld6R0ZrR1J4QWRRRXdjUndOYk5HNHFpd3dEbmla?=
 =?utf-8?B?dHh5M2ovUWhPVXRURlRETzM4S05oeVk5elN0Z2VrVDl2RndlMU1qYkxtSTNp?=
 =?utf-8?B?ZERjZHB5TUVIT2xsQWtnN2FibFowQU5xRGd6UHp3TVYwWkpkYW9ha3JkVXYr?=
 =?utf-8?B?UThnVFAwRldzaUVhM2xMbm45UGgyMGNEeFhmMlRRTVpRSzRIWGJLMmRTZmE4?=
 =?utf-8?B?Uk5lQmRScmNCaU1nZDVTV0lXSzMyV05XTGJjT2x5NWFDQ0RpcTZPL0NBcHZG?=
 =?utf-8?B?eHQxSCttRDF0NnEwK2tSNHpmdDZ4b04yYXBkQUNWVmlOZ29kSnl6UGh0aWQ5?=
 =?utf-8?B?RkdUbS9qc01GQjMxRmZSc2V0ZTdBdHRTNDlmaXlYNGZwb2lybmR0aENKZmt1?=
 =?utf-8?B?dmZYUUdmLzA5dTNmd2ptM01vZmFDTXlQVkVMWjZYMnM0ZkhOTjRrQmt5bWll?=
 =?utf-8?B?WlRWaXYzUitMQk1MdUYzVVJGQXJYUmVIT0ZDVjQxSVpXRWVYNWQxNVNNbzVM?=
 =?utf-8?B?SE5zb0tVS0dndkxQSnNrcDZaVkQ3WXErMTZYc3hOejd6S0FCSW1jWUQ3U3Rt?=
 =?utf-8?B?M2dCWEF2VHFGeGo4WUVlWnV5NnQ5MDRBVHBSak1Va0ZCd3RwRHRoS1ppVTVG?=
 =?utf-8?B?OWlJcU0xcVpIamdWdnJKZU9abHNHVXQwMjhLWEdmbE4yMnZNNmhWN2V6anhB?=
 =?utf-8?B?T0hKMnpxdTNGeVNlS1BQcDBxc1RyRzF3UWxSY2R6RHBIblRzaEh1RzhHd2p6?=
 =?utf-8?B?Ny9iZTNzL0d2cmtLbUlNRVV5TjNsSWFsOWlFclRCNWY0QXgwczRDR05LRGdo?=
 =?utf-8?B?R3JZRnBSZGRwdVJna1lyOENOK1pvZ0Q1VDR3OUhRbDlncFp2dHp3QUhRRGY1?=
 =?utf-8?B?Yms0Z0tJYk1aNHVOUnp3S2tKMlRubWVEK25LeERNdWxXcE9iM1VJSHBjQ2Za?=
 =?utf-8?B?WUxqZFdxN0xJMnN5L1NhN2RYTUlQTFE1SFloYmlrTzZDTTRtQjN6VE1qajNV?=
 =?utf-8?B?NDVmRGtKZmlBZkh4ZE15MUdwWHlSaDI0MnNWZkV1VDNpaWtOVDNZd1FEeE1q?=
 =?utf-8?B?a2p6bVh1VTVwejlsRFFnYlFPMStUR0JiOHJEdGpoOTFyT05UMTRWSEE0WXZS?=
 =?utf-8?B?a3pnRzNjY0lPc2RNTHBZc0VpV1BBMzNkcHRjNzhOQmFkUTkrdkxHU0N6LzJC?=
 =?utf-8?B?MjZYejNRa1EyWWNOaXdSdVFlTUlrY2RIREFOaDlRam54UmdDclRWZjRIdHVs?=
 =?utf-8?B?empGd3YvSlZkeFpnelFFT1NxUG8zK2JDbXdNbU96Q3RjeFRldWp2ZDc1bWxK?=
 =?utf-8?B?YWs1RytJd0s2SlZDTlZYd0FqUTdRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:51:08.9716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a8fbf8-c964-4171-1441-08de5cafaaf1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9533
Received-SPF: permerror client-ip=52.101.48.41;
 envelope-from=FangSheng.Huang@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 1/23/2026 10:43 AM, fanhuang wrote:
> Hi all,
> 
> This is v5 of the SPM (Specific Purpose Memory) patch. Thank you for
> the feedback on v4.
> 
> Changes in v5:
> - Renamed 'spm=on|off' to 'memmap-type=normal|spm|reserved' enum
>    (per Gregory's suggestion for better extensibility)
> - Updated QAPI schema with new NumaMemmapType enum
> - Updated documentation to describe SPM as a policy hint
>    (per Jonathan's feedback)
> 
> Use case:
> This feature allows marking NUMA node memory as Specific Purpose Memory
> (SPM) or reserved in the E820 table. SPM serves as a hint to the guest
> that this memory might be managed by device drivers based on guest policy
> 
> Example usage:
>    -object memory-backend-ram,size=8G,id=m0
>    -object memory-backend-memfd,size=8G,id=m1
>    -numa node,nodeid=0,memdev=m0
>    -numa node,nodeid=1,memdev=m1,memmap-type=spm
> 
> Supported memmap-type values:
>    - normal:   Regular system RAM (E820 type 1, default)
>    - spm:      Specific Purpose Memory (E820 type 0xEFFFFFFF), a hint
>                that this memory might be managed by device drivers
>    - reserved: Reserved memory (E820 type 2), not usable as RAM
> 
> Please review. Thanks!
> 
> Best regards,
> Jerry Huang
> 
Hi all,

Here are the OS-facing test results showing E820 and ACPI SRAT data for
different memmap-type configurations:

1. memmap-type=spm
~~~~~~~~~~~~~~~~~~

   -numa node,cpus=4-7,nodeid=1,memdev=m1,memmap-type=spm

Guest dmesg output:

   [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000027fffffff] 
usable
   [    0.000000] BIOS-e820: [mem 0x0000000280000000-0x000000047fffffff] 
soft reserved
   [    0.000000] BIOS-e820: [mem 0x000000fd00000000-0x000000ffffffffff] 
reserved

   [    0.042578] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
   [    0.042580] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0x7fffffff]
   [    0.042581] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x27fffffff]
   [    0.042582] ACPI: SRAT: Node 1 PXM 1 [mem 0x280000000-0x47fffffff]

2. memmap-type=reserved
~~~~~~~~~~~~~~~~~~~~~~~

   -numa node,cpus=4-7,nodeid=1,memdev=m1,memmap-type=reserved

Guest dmesg output:

   [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000027fffffff] 
usable
   [    0.000000] BIOS-e820: [mem 0x0000000280000000-0x000000047fffffff] 
reserved
   [    0.000000] BIOS-e820: [mem 0x000000fd00000000-0x000000ffffffffff] 
reserved

   [    0.042728] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
   [    0.042729] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0x7fffffff]
   [    0.042731] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x27fffffff]
   [    0.042732] ACPI: SRAT: Node 1 PXM 1 [mem 0x280000000-0x47fffffff]

3. normal (default, no memmap-type specified)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   -numa node,cpus=4-7,nodeid=1,memdev=m1

Guest dmesg output:

   [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000047fffffff] 
usable
   [    0.000000] BIOS-e820: [mem 0x000000fd00000000-0x000000ffffffffff] 
reserved

   [    0.042413] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
   [    0.042414] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0x7fffffff]
   [    0.042416] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x27fffffff]
   [    0.042417] ACPI: SRAT: Node 1 PXM 1 [mem 0x280000000-0x47fffffff]

The results show:
- Node association is correct (Node 1 at 0x280000000-0x47fffffff)
- E820 types are correctly applied (usable/soft reserved/reserved)
- SRAT entries are generated for all configurations

