Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AE5CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 06:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEKsG-00033f-5o; Wed, 07 Oct 2026 02:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1xEG8O-0000oz-Rf
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:08:25 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1xEG88-0003Ud-1k
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:07:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPN6cLA2TdfrZbrWthWGO68JnaaFwBfLq3yWG6I8HUX0qvbXZzPRjn8QKkRh6qRsKwDH3Ch9UG6zlsxJY1nJjsHCxjG5B2KM6UPFElmZ8ejUPm+9tTc1E9RPUN0CvPNyKNEBq49GJuu62a3EUBASne92deeqzLss9p/8UU4x5qQNrHSkTamxDxGSrg3uJ8+MTp6ekpYkpKUuI7ozHCziOxkRe+sbAk6Z8hvAnpwwvUl1PjbVkqQhlcN1pKAVp/dGtLVHzE7xg9nd/WgUbBMOVWEy6mp1Iyls3nqBs9KS0fPPdXNiF1/qQZMifBTpps0QfJpD/cCijEE/ZQRSkEyxZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4r82CQSniigKmlyHfeAV9sQUYP4k9GYS5hdCkgmYow=;
 b=FOQ1/IGZNu3CrHTeUEE5XTyTbHjM2oqgFDLlO12c1E1XrmfUpM4cSsTxqlgxQ3oCE5N6M25G1lqnuXb5x1W978dFCK2y8dzVEM2C8jL+l77iZ56QM9fm3McpU5Qfz+rTiBHuSY8peVaL0rYwXhdm35wlJ9VYNXiuVy5Mz9j8Y5yAGyFDR1yYJCeVxHQhncLANHaMKJ5C/tZ1bZ1HsX7cu/7jyi8da9B4jZXBptRjlRQahWmEIlAsW8IkAUU6S1n+FdZ6Jx6W8cuGUQPCQCk8RjXTU1m+y/IEd3dpfS2AdBwQazAipb7WieqxtV/msbA7a6gJZGw5hwfHfq822dPuiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4r82CQSniigKmlyHfeAV9sQUYP4k9GYS5hdCkgmYow=;
 b=cj37rDJ6TpLtEN9cmgmRHHajpMqIApWJgDqPJfuJlDIFMmG3A9p0mmZOFhummfpHIMs4RstuhTfFW1SrX97zH1q+KUi2pPcHIEWFGZXuftSt2m17ABS4lncHlHSPsocefdoKnwrf6wIJWMTI4bSK3s82Ochqa/dKQ4JhA9e9h6k=
Received: from SJ0P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::29)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 16:33:20 +0000
Received: from SJ1PEPF000037B4.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::d) by SJ0P220CA0006.outlook.office365.com
 (2603:10b6:a03:41b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 16:33:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037B4.mail.protection.outlook.com (10.167.244.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 16:33:19 +0000
Received: from [10.236.191.63] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 11:33:18 -0500
Message-ID: <92ee6e3c-8edc-4eca-a820-127fdba63011@amd.com>
Date: Tue, 6 Oct 2026 11:33:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Add Support for AMD EPYC Zen 6 CPU Model
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <babu.moger@amd.com>
References: <20260825162544.18633-1-Benjamin.Cheatham@amd.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20260825162544.18633-1-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B4:EE_|DM6PR12MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: 3462dabe-bc72-42c1-9132-08df23c787cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|22082099003|18002099003|10067099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 9ULeUbVPa3J+YM6R5ZescIt+bYlfxdTThMODY9wkqsW9jUYP8H/TYlU5u+KajIpERWq7Kge7bTL+YO5dVVL8EnAKu2RC211NF2TRkbv+zTilzvq3i+j/EmX1BQiaACox7s4TpsOFMF/DBoRWeOv+YGjo80pbbfXMqeBuVlwn0K+BixyLsnLs/ZvERcmYuBt0z9/xL+OPswYPsZYBAMBRLbcx0wx+uDUrEAB7mq+MBIctgit9SPWLesSoFR0keN+/1ATDLzsnmk76iPyo0tuGS81ofH98CSRaYirc/Aaoypgaa/wtaGCiahzp6XMmalvbIWkGQzFCzRkybQWtmd4bo2D9W1ngiLW/8EvvtdUXxhYkKQQJEQ+zc1q4BF9MlV99MvIVpv6FebrwjiI+H3jEDvAh8XfJMrPLbMOQtOP51z674yN9mk418swl+P3QdYg8ie/3/Ucki1r7K0VXkbJQAZbaC9s6e4sqZJf056pGVeBHQbSIeHRtQ8w+HjzAv0FuzsVhAvieqZ8pOMPdbbgU7x7dQ9/TyJlNIyquJKJhhOEbY72U2hi2uX4bC5UoWadrQLhtarDWoY2gHMSvOx+6M7Kwwzep2VdYSvuANRuzOGNI8MxIrJXffVt0FdXPXcCNu3bs0l8jtefWajyCN+0YRji/lQ5xg76mLbPbQIaGa+p+s0dRLScv0ugptSX41lduNIvzC2Bend2mxBDzVp9qgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(22082099003)(18002099003)(10067099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bvvQ4XVmn8eMPnvNGLMl7sEhwsunDceH0J2Qamaa5rvpCZC1ohjuXoQhz3sQ1gwNYHnLXYHuuDu+ReSe1JHOGo0hZwNR5Zmri5QE8Sk6i+APa9eTDESutJn3/0MG3ONN9+JM8p78Z7Xm+V9GzcHK5c+Mm8LpCPx+OH9/IbStQCSjRg2OrOTNHCv+wszyAne4+GgMCWIOUVUH6wVZUv8E+jPYp73/lJKs0QDtEdkCQaISbJlx4R4t/EYOmnnEQzHi2lSp23yuUOik3KHBQ9YU3DHhEIKkSaxL1OlDpwy/04Btbin31QRI24wu/hkir7B7bkRSrAAzSq5kDrGre2oJb+5oYV6W8x368SHDvISvVFYDS50vIRMawWGNvW9xbNBatPuM09vBWjeJNxRAiTPrnKLF4x7w+LjhAACmWKyCjxMZBEH1pVrCxtv7dwLBeiA9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 16:33:19.2791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3462dabe-bc72-42c1-9132-08df23c787cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=Benjamin.Cheatham@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Pinging this, hoping to get it into 11.2 if possible.

Thanks,
Ben

On 8/25/2026 11:25 AM, Ben Cheatham wrote:
> v2 Changes:
> - Remove SRSO_NO bit (not supported on release hardware)
> - Rebase on master (fd7ab698c921e2e97aa1b1d5b719d42103a2dd58)
> 
> This series adds support for AMD's upcoming EPYC Zen 6 CPU models
> (EPYC-Venice). The first four patches add support for the EPYC-Venice
> model while the last patch adds the actual model.
> 
> The EPYC-Venice model is based on the EPYC-Turin model feature set with
> the following feature additions:
> 
> 	ERAPS, TSC Adjustment, and Shadow Stack
> 
> and support for the following instructions:
> 
> 	AVX512 FP16, AVX512 IFMA, AVX NE-Convert, AVX VNNI Int8, and
> 	AVX512 BMM instructions
> 
> as well as new cache values.
> 
> Some of these features (ERAPS) were only just recently merged into the
> Linux kernel. It's recommended to use a v7.0+ kernel to leverage the
> full support of the model.
> 
> Amit Shah (1):
>   target/i386: Add getting RAPSIZE for ERAPS enabled guests
> 
> Ben Cheatham (2):
>   target/i386: Update RAPSIZE definition
>   target/i386: Add EPYC-Venice CPU model
> 
> Nikunj A Dadhania (1):
>   target/i386: Add AVX512 Bit Matrix Multiply (BMM) support
> 
>  target/i386/cpu.c | 151 +++++++++++++++++++++++++++++++++++++++++++++-
>  target/i386/cpu.h |   9 ++-
>  2 files changed, 155 insertions(+), 5 deletions(-)
> 


