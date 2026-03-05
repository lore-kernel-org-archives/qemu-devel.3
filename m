Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82EBBF30936
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy6Bp-00084I-Os; Thu, 05 Mar 2026 05:44:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vy6Bn-00083t-P0
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:44:20 -0500
Received: from mail-westusazon11010048.outbound.protection.outlook.com
 ([52.101.85.48] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1vy6Bm-0004Rc-0M
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:44:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2/qct518vKG8xaHL0Ar6eBzkw11rb/RFf+/8+tKFNsxPrEDuzcdi81XZj81nrF5XOr9QGRpObQ03BhGFxpVkEAl7iSHS0SsW3mfnR2NcERAX9yZBf2DvJcWbRrcoGZ6mus1P6rHe+6siIbMaIf1GQQRLvLrY4tZdMouKh/AgzfFizGEBa2WmRTLdsvLYTWBJlcS8vZUWkaKvG8skY9tMoLeLyvimAvQdZOyxTGwwew0v6hspDvt3/1usjUl8OEHuSecVtth35fyWB1FsTVv/vak1PXVugGDll3fY5RGz/fouE45jLnd3RU6dsdTlOCeE6bCpOqtNh7UoCQ7cCu1QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFLPQ4zjcDVag0aDwuU3BzZlQ+Af1XtBoNC5lJjiHAI=;
 b=E25SXES/+mcSBj2vnDlk4pEG9WKR1QlG8//y5bliNAVhC9hC8ADrKDu1u+MABz8JmulRkzumU96tpXgjLjrTlv2YK1zHCbQOEgeCeBEOzThlyCv4xBlF5QqONTydgMLsHvpsbxq1IiwozK+0mURptHZGXnH2sbO/9XDQ5GYdOiLs1ps/ttPx6EiJUIWpbhM+FnO4ymn1FmJ5q8vtmqiGepvo2FnugnhIKnbwVg0/SQfaxVly0cI2pa0ela1qm/wcidDJm1jufQMewZn95/kVCGFA8ICrgU6UXfOdBh28vuLwPrpW5jldCRBKNtP20uwmC5wt3NPXbaZYQ6rNrrmK9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gourry.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFLPQ4zjcDVag0aDwuU3BzZlQ+Af1XtBoNC5lJjiHAI=;
 b=RVkeAqj6AruwHUdNRZt6qh+zIbz8mbPc3iZuBhNd0+pMnunmQBQT8XiAtnHZP/iAALSWYCimmntzjoc448avX1jGpXQsCJI4Y4li+xnZuQ1W86tNigm3UrMg4letxNKLoKQjFoWyRD7ChTEm1cVrMJuIegH0EltHzHYXKCweDwc=
Received: from DM6PR02CA0092.namprd02.prod.outlook.com (2603:10b6:5:1f4::33)
 by BY5PR12MB4241.namprd12.prod.outlook.com (2603:10b6:a03:20c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 10:39:11 +0000
Received: from DM2PEPF00003FC6.namprd04.prod.outlook.com
 (2603:10b6:5:1f4:cafe::1) by DM6PR02CA0092.outlook.office365.com
 (2603:10b6:5:1f4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend
 Transport; Thu, 5 Mar 2026 10:39:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM2PEPF00003FC6.mail.protection.outlook.com (10.167.23.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 10:39:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 5 Mar
 2026 04:39:10 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Mar
 2026 04:39:10 -0600
Received: from [10.65.99.60] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 5 Mar 2026 04:39:08 -0600
Message-ID: <318e33dd-4fab-4561-b5a6-b776a673eb2f@amd.com>
Date: Thu, 5 Mar 2026 18:39:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] numa: add 'memmap-type' option for memory type
 configuration
To: Gregory Price <gourry@gourry.net>
CC: <qemu-devel@nongnu.org>, <david@redhat.com>, <imammedo@redhat.com>,
 <jonathan.cameron@huawei.com>, <apopple@nvidia.com>,
 <dan.j.williams@intel.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
References: <20260226105023.256568-1-FangSheng.Huang@amd.com>
 <20260226105023.256568-2-FangSheng.Huang@amd.com>
 <aahpn6ClnUZXjlXu@gourry-fedora-PF4VCD3F>
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
In-Reply-To: <aahpn6ClnUZXjlXu@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: FangSheng.Huang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC6:EE_|BY5PR12MB4241:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb7358c-fb0c-4fcf-bf97-08de7aa36fed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: +xslCFcCE6lv2PIo+6Nto2lpUbsn8wSa9OQE1IBFpHhOnldWcP789BexEa3rUM3jJ+c6o6KLLFflVpUhzYtplGBCaNweTf7C+qCkBMqAAZmLLrQmuSXd9xkgfMMV3Mzy3c8c6XhJGon6urePDtOEdLIaPHInogn/iPqvWYJuhcATOn9vPuFWf+fVX5rSD5M6fkO4lZMbXDqr/Yp1lxV88LqDHGlQnzvhSw2Lv/wHRXdTO+uVsv0mL4aLePeg/R3SzAr7nf9RgGsulCZfSwoaX2zjy1H/dtjhhk24EsetNln5Aio6Ee79zYMSFACI5/dkj1XfrzVxSbWFkpgabLZSxuRNVP6hSjPC8K3h1hsIzd1E7SyPfysr0CIqtSffLJq3ufBnv4djMgIQOxXNEbJlTPUHL0kPO12RdLWEAYv9QX6/RS8OASr2UIVA+xdy+SfLgGjMTOWZ9yqDbqdHOM1qEk7oqmvzPBOLMUzE74YrxnX85BGv8i+/gCbcknYvDbUr8GFy40qKzy5vdsmsAAM0stpVHR8ebq5QiYO594XLdnMFaT+OSFphJlf9P+hlDR6rjjydeoNibhSP9qZuUyDRvYagewnf/5ocPR3C77avY2o+85lGtQzeZkT/NndbnQm9pGSS6zCKZjwlCyA7B49kvBvn82OqwzYGD1MtWOA7UgFNXnI2ae7hY+z5y9oalYtspIOOxaGoKtwkO4GHvA57HGMgCdRmDsrZWEtq1u5uulsCiTQGLSZ8BjFAcd2tvWgnlfR5b5pxVYgngRkroSORBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LeHdYADnhyAkdyS9cD03uBY2w/twThlAEPODvXJ+XLMEQLCDZYcl9U+5izURFtCaFuEiQ1XPBYI+puLIpjTopfQInOrNGQxIQ4hCEXDizt6idUOrrZVIthqNFRO1HHb1WIBv+SdIML1Fvd6V0yms9f1QMzrLwkzfKtLoGEFf0Fs5wYLHNI4818iU9IMMnMZRVhy+WLGPGf01+gZOuYYvIEjreDILx10/e9WbKmClI8qexfvH/P7wChH3EYqpgg3yimFizlel+vDLgpJa2ca4/wPrOQmLazSuwqbaTZgZety5diDHmb5BrZ+AsgZmO8i1Y++7A+JW/5/bYgcbAF2c0pJUnvjMLj6nCdwaaHHRQnSgZ3bwIjPVLX3ZhfKvMMnhkgaLAZW1gonJhgySAt6ZrfXOOUv/4lripMAULwiT7qUma/+E+n9kIZKknv4Qrn1A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 10:39:10.8794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb7358c-fb0c-4fcf-bf97-08de7aa36fed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4241
Received-SPF: permerror client-ip=52.101.85.48;
 envelope-from=FangSheng.Huang@amd.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 3/5/2026 1:19 AM, Gregory Price wrote:
> On Thu, Feb 26, 2026 at 06:50:23PM +0800, fanhuang wrote:
>> Add a 'memmap-type' option to NUMA node configuration that allows
>> specifying the memory type for a NUMA node.
>>
>> Supported values:
>>    - normal:   Regular system RAM (E820 type 1, default)
>>    - spm:      Specific Purpose Memory (E820 type 0xEFFFFFFF)
>>    - reserved: Reserved memory (E820 type 2)
>>
>> The 'spm' type indicates Specific Purpose Memory - a hint to the guest
>> that this memory might be managed by device drivers based on guest policy.
>> The 'reserved' type marks memory as not usable as RAM.
>>
>> Note: This option is only supported on x86 platforms.
>>
>> Usage:
>>    -numa node,nodeid=1,memdev=m1,memmap-type=spm
>>
>> Signed-off-by: fanhuang <FangSheng.Huang@amd.com>
> 
> Thank you for the reworks!
> 
> I will set up a test soon, and this will actually help me with my other
> work, so it's much appreciated.
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
Hi David, Gregory,

Thank you both for the review and the Acked-by / Reviewed-by!

Really appreciate all the feedback and guidance from you and the
other reviewers throughout this patch series. It helped shape the
design significantly.

Thanks,
Jerry Huang

