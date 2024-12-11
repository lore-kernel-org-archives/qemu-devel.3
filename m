Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07832E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 23:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLWKv-0004aL-1O; Wed, 11 Dec 2024 18:41:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1tLWKq-0004Xv-W5
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:41:41 -0500
Received: from mail-dm3nam02on2046.outbound.protection.outlook.com
 ([40.107.95.46] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1tLWKm-0007sP-Hd
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:41:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ua02P7KKslqVOiXj1fKiMmxW5WHe6WxLhJQje4FLOZLfk2nR2CYcT+ANTE1Ry6yJMvW/EUqFcOOTvdLxJyDXCua/z69Q/h3BY9PR9kcLax4I0LckIwaPCOgqGhJfizlOHl3rdNZMNpk1snXQJYe5PLg+Jq2ANdQ1u+g4wGq+OGVJMqcuKGZght5aTSpUYHGNPiJXJo1GO6unSYIQJD3v4V4pgDBpIoDIyIWacDyO7kTi9T1Nv4NDcm1TICfG53PxdGm4lL8xDYIKKhIWQzeqsWXGTi4D4Ue1BOti7njIeNqJyXlAaCywu+UJQ1ytcyyZKsYk9Vx0WgLUyf2io6DseA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dy7D2UX/lA0Ew5ynAsKDHR3iv/ZZ7NkfuaNY18wADMg=;
 b=HTyAFRX5A7rkdT728JUMDoBKeJ8RX/doD2AzEcjw2hUbuLcOfy3wGXT0aT/WAVss10Fs1Q6fKLRyrtZ5HPXAMNbZUfynV+UZzb5J0y6oq5EeALGxbmSiYpUeNTS9qFgUwiERXc1QvHFDfoC8wb0jRyOrfC5J7aoBPQ0g7YYd9f7uoDFFMEk7j5+zdNHas6B2Y2Dgm3A5ghGeD7XYu3PqL4uvAxHfQJrr2wTUxkzr/j1y9vEeEfd+7uCDtdeCVfQ26EYJeeOD386+Le8yi9/0eLgPOu1O++I1vs7jl0OIDqp/AoKFQQCE0f/0iosBQm2ecpEDqSY9yByoJnYR/fr2qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dy7D2UX/lA0Ew5ynAsKDHR3iv/ZZ7NkfuaNY18wADMg=;
 b=BzwoxQaUrbl+k7O2A0cOHXDZP8ewK0VhuZPy4DiLUbnb/lsnQxndUE5MBpNr523Cqnamf5BZsOT8LpEbdW9nUXW3zMlNbN9wJrf/CnD5r5w1joKQdNO3KVPlP0fDXH8LfLjww34IbXEUb4KR91yZuv+C2BDZLh7AjYRtk1m/LcY=
Received: from BL1PR13CA0353.namprd13.prod.outlook.com (2603:10b6:208:2c6::28)
 by PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.20; Wed, 11 Dec
 2024 23:36:18 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2c6:cafe::8d) by BL1PR13CA0353.outlook.office365.com
 (2603:10b6:208:2c6::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.10 via Frontend Transport; Wed,
 11 Dec 2024 23:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 23:36:17 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 17:36:16 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 9.2.0 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Dec 2024 17:36:00 -0600
Message-ID: <173396016084.690778.14513056087610218483@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|PH0PR12MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: cd83f4c0-ad8a-4873-9d8d-08dd1a3c9c04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTVuaFlmRlJDQ3FzcjlTLzE2V3lUTmZRZkRRd2R3alpjdXdUUzE1dzJDaEYx?=
 =?utf-8?B?cUNTWkQ5SW15LzNWTXc4cmw1aFFkMkhxL0w1blJ6NThoeTFyUU5lWW5kd2E3?=
 =?utf-8?B?YXUvbG04SXl0L0FUcXJrWTZGSWQ0OXJTWXg0TGNKUGVIQU9KV1BEWXd5TVpI?=
 =?utf-8?B?REFyQmVaODRoeGhGWDJyWjdrODJObHB2QWpIWWZHbjR0cmYrL3VKbUpDNHlM?=
 =?utf-8?B?V2FVdHlQYTRUQmR0Q2pINUZzaWdTOGlheFNFRXVvNWY1WVhwdzBBY3JQc21p?=
 =?utf-8?B?Q05yOEFiYVdHZzBhRDlCb3c2elV4cVdKQ0lpczNqaXlzdmhWY2F2ZUZJcDVG?=
 =?utf-8?B?eWRGU3FQMGpyekhWQkdYby9GYkNsMG1tejBGTVU0SmhGS1JGOVBrcFB1aFFx?=
 =?utf-8?B?Y0VEdGd5c2E2cW0xOGdJL1BGa0dnLzU4N1F6SlFuclZLcTNvUVpPTnRwQlJ1?=
 =?utf-8?B?T1RNRkt3Wks3d3A5NEFUclJxdnQ5MDhtb1czTEdXMk5mblM3NCtWbEdhaUQv?=
 =?utf-8?B?a3VOS3g5WXJILzdZQUpMbVVYQ1dxN0U2Mjg0TElONWo1a0JZbi9xNkpwVUNq?=
 =?utf-8?B?UmNCcWExSDU1S1JxSndWSHcvMWF1N0crMDlhZVgzeXJFTHJ5QzRocVR2WjY4?=
 =?utf-8?B?SkR6ck5rN05nZGdScE9hMC9WYnJXd2NnMm1tQ3p6RWpHR1J1R2doQjRZdys2?=
 =?utf-8?B?QlJPRzJqMDYwL3JwR2dtSXQ2R3JaUlpjQ2N6YUNHSVpMVWYzbG9kMWhUcTZP?=
 =?utf-8?B?Q1A3NTg5SmJseWdMQVp0bmpmTDY1TzQxdGZaQlZaVTZFejNyZGNXQTk2anBq?=
 =?utf-8?B?WE5TVy9BRzJzMlpOTVZiR3E1YTZDU1ovbVlzRElDUWZxYlpVUDR4dmVRNGg1?=
 =?utf-8?B?UkVVUzgyVVNSdVZaSG9RZzQvblR1SllqeXRvVDdSNkxpNVp6UVBPbFFoWjgv?=
 =?utf-8?B?Y25sUE5BUDlHcmJ0Q1B6bHZ0ZTErUi94cW02amd0VWFWVmtHU2ZXQ25FL1Mw?=
 =?utf-8?B?bVAvbE1VTmxzRERCVDJ5LzdMc1hXWXlsdGQ5aVlkZ2l2UGRGNERBVlllb2k3?=
 =?utf-8?B?WGloa2E5SnFQbTB0T2hDeStpWExSTmcxSmJ5MHBodVZibjJsS0lZMWdoODZr?=
 =?utf-8?B?NnhCcUZWZDJBajAvWlQ2WWFxYjc4TjBYcXlxRWxMV1Zkb0RuVHhZbGJ5L1hV?=
 =?utf-8?B?UEZUdmJIWDgyY1JNYm1xZ0tKeVFka1FlOGUrcGNjQm0zNk4xSEV1Y01tTUV2?=
 =?utf-8?B?bklsQ2pNOEJLZ001NVRSVm83U1R2M3R1VDJaajZXYTBycjNiSW40QytTclYr?=
 =?utf-8?B?UTY3b1hsTnhMWEpWQWw1MGtPQk5DLzI4OHNDZmlCSHFBcHNqMjJLSnFQYkN1?=
 =?utf-8?B?QlRqWGM4SlhjeG5qZnBRUUxTMUJIY2VEMmhGd3JTQUxFUXIzc0R4KzJnbWtG?=
 =?utf-8?B?bEJmV2UvKzgwWGtmSzBBZGtnOVdpdk9zSmE1dVkrU2JsenVNaWt2VHJBOEdN?=
 =?utf-8?B?TVpTWVZOQVIvS1FHN3RwSlY5UUZHenR0ZlEzM2JaOTBzTkdEV29vdTg0YUJ5?=
 =?utf-8?B?WmlvSkxBNk9xd3dtWHdZWFFpNDJHd0ZDbnByeGNseGJrZFdhbmNNVnA0bkJm?=
 =?utf-8?B?STQzcHY1M3RoY1ljNW4zVjB3VXFlcDhqbHNha1lQV0I4MUIrR0hQV3ZGL1No?=
 =?utf-8?B?OGo2c3orRTdPU0FmTm1zN1Y0eC93ZnU3cnozR1ZDQzhPMDRSNkxLYnl3WFRJ?=
 =?utf-8?B?ZUtDdUlqR3VDY0JBZWJGOWlZV05GY2VNN0FjQy9xV2psdkdkZ0ZNS0krSURp?=
 =?utf-8?B?NXZ2RTFOUXdrcG5PeFdqNXNSQXlINXNNMUg5QmtFRTNONVVPRFF2VURRalEz?=
 =?utf-8?B?QVgwMjYvcHNKK2NXeFgxcjJzSCtDNGFLMS9IN0puMEJYQ2c9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 23:36:17.3605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd83f4c0-ad8a-4873-9d8d-08dd1a3c9c04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930
Received-SPF: permerror client-ip=40.107.95.46;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
the QEMU 9.2.0 release. This release contains 1700+ commits from 209
authors.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

The full list of changes are available at:

  https://wiki.qemu.org/ChangeLog/9.2

Highlights include:

 * virtio-gpu: support for 3D acceleration of Vulkan applications via
   Venus Vulkan driver in the guest and virglrenderer host library
 * crypto: GLib crypto backend now supports SHA-384 hashes
 * migration: QATzip-accelerated compression support while using
   multiple migration streams
 * Rust: experimental support for device models written in Rust (for
   development use only)

 * ARM: emulation support for FEAT_EBF16, FEAT_CMOW architecture
   features
 * ARM: support for two-stage SMMU translation for sbsa-ref and virt
   boards
 * ARM: support for CPU Security Extensions for xilinx-zynq-a9 board
 * ARM: 64GB+ memory support when using HVF acceleration on newer Mac
   systems
 * HPPA: SeaBIOS-hppa v17 firmware with various fixes and enhancements
 * RISC-V: IOMMU support for virt machine
 * RISC-V: support for control flow integrity and Svvptc extensions,
   and support for Bit-Manipulation extension on OpenTitan boards
 * RISC-V: improved performance for vector unit-stride/whole register
   ld/st instructions
 * s390x: support for booting from other devices if the previous ones
   fail
 * x86: support for new nitro-enclave machine type that can emulate
   AWS Nitro Enclave and can boot from Enclave Image Format files.
 * x86: KVM support for enabling AVX10, as well as enabling specific
   AVX10 versions via command-line

 * and lots more...

Thank you to everyone involved!

