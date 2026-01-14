Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE33D31A25
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 08:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfwIR-0006nq-5q; Wed, 14 Jan 2026 03:32:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vfwIP-0006lw-Gy
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 03:32:05 -0500
Received: from mail-eastus2azon11010022.outbound.protection.outlook.com
 ([52.101.56.22] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vfwIN-0005z6-HW
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 03:32:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhEcLmLKWwzycqDak9uD+Uwahj3/fIpNg3tNDjOlDDLSOl3k+T6QVYbEh4Az5XkpfLPSmsQ5ZKqNZPhL8/jAXZWjmuScQKoyQTHa92ZFTDdaZkTG+2QQqtguSiD5pMGjiiNPAeRAPKvOpBP/b3zj+8N68qOGdiRL2vE76NB1s7OFeeFrdiX3G+4puH7Dto7y++r8ocVZoiNHVNB5vQvMUuZE+FI8BVw6+1BNyUbEn4qJYvid7e4K3Rs5UCSzykIw3zuAm6jNTowKa6rvtSd+SwqAlX/t4GDTktPafYHCQbds37L7ZGvByiKvFhZgLbw/dy509FnO26yA8mnZyK4C+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbqDUsjhyMCtsiQ6eQSUu1cCHfEGjv3cTUXnaKBrZl4=;
 b=IgujKS3a2PwK7OWShjDZ+p/Zsjz5Jz+uG2niaIM9cFfSucMMEw/t2mTV1zj5Vav8UmKCkRbiZ0RV4pbZYLEoXH5jcRP3nU/egPzeZ+wyjTcCr8zcdO9hybajvHCKpK0wbQlNaJkwdHnX/OxWjc+ijr8PF7YUwx+65VHRuaB1FJnf4juZE1FZn+FVDTB41xskhMNV37sV6ffKP65gUaKYEtSQ3mMkIg7WlpuAjy/CmcEVwOwS8MOvbbinCW8z4Nufd6WAb9o7fZ/ZXDqaPQ8hLWvD3R+09InOk/xiwJQouqqlctOjQ8IC8AL6wRFsyHn1boRiTuct8Io917TjD+RXZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbqDUsjhyMCtsiQ6eQSUu1cCHfEGjv3cTUXnaKBrZl4=;
 b=e1r1SSER9TzT11gooOuQ2MjHzMZcbBohcNKPk6ObYHTH2vOxIxmn0oQ8tO4lq1xOIATOhAhbvDcLP9jzSPMecs05aZkNsQA8KoUnhRqjsERh0JG3qrErMnRSIhFUlWZO0Vz316ZV0do9PYFj1hcexSkff0uuiosjAIAgBuuAwcw=
Received: from PH7P220CA0064.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::8)
 by DS7PR12MB9043.namprd12.prod.outlook.com (2603:10b6:8:db::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.4; Wed, 14 Jan 2026 08:26:57 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:510:32c:cafe::46) by PH7P220CA0064.outlook.office365.com
 (2603:10b6:510:32c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 08:26:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.0 via Frontend Transport; Wed, 14 Jan 2026 08:26:56 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 02:26:53 -0600
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@redhat.com>, <imammedo@redhat.com>,
 <gourry@gourry.net>, <jonathan.cameron@huawei.com>
CC: <apopple@nvidia.com>, <dan.j.williams@intel.com>, <Zhigang.Luo@amd.com>,
 <Lianjie.Shi@amd.com>, fanhuang <FangSheng.Huang@amd.com>
Subject: [PATCH v5 0/1] numa: add 'memmap-type' option for memory type
 configuration
Date: Wed, 14 Jan 2026 16:26:32 +0800
Message-ID: <20260114082633.806629-1-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|DS7PR12MB9043:EE_
X-MS-Office365-Filtering-Correlation-Id: d909ea97-c5e8-4edf-44fb-08de5346aded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5NYNAL/1SViqQpf1QVVh+RoQAU7v64nGwuqGTTGIHbgvTelsTQnXRBOL/uvd?=
 =?us-ascii?Q?3i21TUb0pbWv3HsaUHeCpTaaCsUn5zhi5bXruxNn5ak/LYu97wt3WtFCusMA?=
 =?us-ascii?Q?pDt3anhdu+Dl4uU8Gs/TMoHY4wzmwgF6uzatYv+pWaVm9GFVU+nvm/k5/KZG?=
 =?us-ascii?Q?HzSRbMwOuU4uHfcg69FzyppSvmYR1IuL2IMiXZPb8K+TKton3dq2si3B8C86?=
 =?us-ascii?Q?8ZM4LELwQhPGuHpfgZ3/KT2T3JbVQccSdkDG1R77G6Vfm+wGcBYA/JvZrTXS?=
 =?us-ascii?Q?kXbKsPzzxg1ju8RsSaccE+frUr05IwUk26Sgfm7UkZ33AZSX5LruASmuFgOl?=
 =?us-ascii?Q?68ndILw1xhe1LZlSNnUMh9Iun4i0Xh8gTErU+dcqE7beDeEggRewrmCuzIic?=
 =?us-ascii?Q?KpsnXlhM+fQOT0liaOfrziXNguDnz4U5vl1CNrNc2CaMmAZIEf43ELy5GIlX?=
 =?us-ascii?Q?lpM+RXpEo/7cSKK8MGDIY4MpJ2Q5AN3jy92vthMEZIxB4S69GiLAAgDMp3j8?=
 =?us-ascii?Q?+VDQ32iTC2hHnIlM/AgWLy8MJTRf2PPqdWeeGt6g8Uq+/62kXn5ztDjAJeVU?=
 =?us-ascii?Q?MBeUhTvD6Pqty4ow1Ikqtsv4IOCZh7AksyRofMPlg4+cwYFPojvJ79bS7xUv?=
 =?us-ascii?Q?rfC58ks03vPwUdhZ7sjMF68mUzqo7fa1jGe22Qtt+uEWUBdPTjHfoifT7An4?=
 =?us-ascii?Q?kFuwBUwcfW9mDewN8ftCo8f7AJ5a1PZlYTzEPJc+6sbawm6XH8L70qUbfK88?=
 =?us-ascii?Q?cCEctRiv2gJqoh9gh9GAYzocXTL5GUHfGwxF7SIJqhRk4jXf5qo9iGYi7MiL?=
 =?us-ascii?Q?+8X4LpQghbgWcRTflgdZAAHs0x4G8RA7+zEYaYmCzFPoeANTs1Puu1fc14lX?=
 =?us-ascii?Q?yZAYJauB0wGfeuF1vZaUuR5NRbdoOkPs9icTAPktlhhjvXRfBG3aEuXQ4519?=
 =?us-ascii?Q?VD/PuCIcs8AUGI54hMJLsKuS+MB/347yl5LiSicQLExeBbN0xX7NCn23+9Gq?=
 =?us-ascii?Q?bpF00gOlUmI80h5Khfge1Cz0freZOVo9XexJhdsYMIBpZcPNNXpSJ70CTi50?=
 =?us-ascii?Q?C3wzMG14HKazU2w+AxZPPACPOyn3hi2ZIoKHzRdSIlEcP6WvjpXdGnK7GUfe?=
 =?us-ascii?Q?7K9dlXEUMCV0SXmLyu028z/DYC2S/5yV3KQCL0eXNXIF9ytHSdOid+6w4Ehp?=
 =?us-ascii?Q?uF6nU//9vMnJO93XcfooBPFQrAHrWv383MYyHtV6jlGx8nflx6bEL/egSaal?=
 =?us-ascii?Q?VCBMzTxpnGyEImedsWeT3+XROJ8nXSTvlw3XQSCfYZl7sZ1AEa9kazqnFZmk?=
 =?us-ascii?Q?VNasleKevFYH+5o1YJILG7gJcapKpfnP9pVwuj1J2hFzSdG32ironk8HSMGO?=
 =?us-ascii?Q?zMQeTnqoanBIh7t38FpsnNDzPunyOCUVzH2mAykZiMuYyANjxDqcGXsnCMKd?=
 =?us-ascii?Q?jjiaHkaPANdv5kbnm1r3hQtes/hdsL/WVk168b+7hurWWYTrJ2uUJG1WkWJ7?=
 =?us-ascii?Q?ioPcJK5lgy7NTnxaThzId8woXit4Th4P058doPOh5AFkEvjT0eHL1CXYycX3?=
 =?us-ascii?Q?6tGJao1ZN70KZhvV3qvO/byznMukn4/fpYEaEfb7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 08:26:56.2672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d909ea97-c5e8-4edf-44fb-08de5346aded
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9043
Received-SPF: permerror client-ip=52.101.56.22;
 envelope-from=FangSheng.Huang@amd.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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

Hi all,

This is v5 of the SPM (Specific Purpose Memory) patch. Thank you for
the feedback on v4.

Changes in v5:
- Renamed 'spm=on|off' to 'memmap-type=normal|spm|reserved' enum
  (per Gregory's suggestion for better extensibility)
- Updated QAPI schema with new NumaMemmapType enum
- Updated documentation to describe SPM as a policy hint
  (per Jonathan's feedback)

Use case:
This feature allows marking NUMA node memory as Specific Purpose Memory
(SPM) or reserved in the E820 table. SPM serves as a hint to the guest
that this memory might be managed by device drivers based on guest policy

Example usage:
  -object memory-backend-ram,size=8G,id=m0
  -object memory-backend-memfd,size=8G,id=m1
  -numa node,nodeid=0,memdev=m0
  -numa node,nodeid=1,memdev=m1,memmap-type=spm

Supported memmap-type values:
  - normal:   Regular system RAM (E820 type 1, default)
  - spm:      Specific Purpose Memory (E820 type 0xEFFFFFFF), a hint
              that this memory might be managed by device drivers
  - reserved: Reserved memory (E820 type 2), not usable as RAM

Please review. Thanks!

Best regards,
Jerry Huang

-- 
2.34.1



