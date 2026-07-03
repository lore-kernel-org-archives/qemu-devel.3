Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09595C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfZjB-0002Qt-2D; Fri, 03 Jul 2026 04:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wfZj8-0002N4-VR
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 04:58:26 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wfZj7-0003BR-4q
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 04:58:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJmX0SCZ4FM9JrIGLAR6r7diQLkPLDhLOky6SvGaHqUTcK4pMs4EsAJJPagbnouMNqhq+MsmbCEReYyN7fTVewHKHxAIkjRxFjPsCuhiC54atU1B2y3xCMQ0ThUyFSpag2LOsyTYPJ7TWFsnodreTpbrKmvQaHwDe93jMgMCycv58NpmLntdKSHfy6JQxAdFmkboVjTgNpQMB3Z1a9kVM1d/TGKK9LseBRdTcOCE5oDcDHVVIbHlY14vytd7juyjjD1NWSU7S1gMttGXpKrjAgmdhVsuli3NOK65qgMAj/X9Eb2hkN68w2wW4RkVNzwSSb3U1BDWp7RgtNgE9dGRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXmp5JlrR/P7wJm3zDu+7x4pJVerlJCzinmSbDDJ4C4=;
 b=vsUbwMktFumExExr+jgdMI+M9p1jXGNplVwDi5NxlL0Lo93ZFxiINF9AlMEZ8j5kT250d2kGO0LmuaR5bBn2AnGBig6RKyhlxcyx8+nZ8bn2Xc7j0k22UyUN6uy+5hfRSZU5nU4bFGaLWWdZ2+ZEev/W3H7E4qaI9WiUlIYYgcivqaq7isqjy/MPpICFq/VIIoetw9vBm1slZcrCKJGNfrHP/PniugFoph6XJ2qIXJ0i5vFTibpBvQbt5fWDG+RYC/QiqWY/lSDz6Z7A3OWoMknaAw7WilllYB6yjmpPiO0jKbfnsFCThTLed4UnNKk60U+lT9Xhnvva7e7JIxAnCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXmp5JlrR/P7wJm3zDu+7x4pJVerlJCzinmSbDDJ4C4=;
 b=nCpxUkz0xsixkuXe/SU/rE/6borLDrsScOvOAQfolz4xEfpvSbyufESyKQXb/+SwGB7s/B1xywGs8vknf14TUXgyszD0T4nf/ATch52olzwttFr0FEmO3NQ36k5ou4KYp07+LYTh+eKbs1iSV03nJG+mkDtCfqffFXLmFfIYxUE=
Received: from BN0PR08CA0004.namprd08.prod.outlook.com (2603:10b6:408:142::22)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 08:58:19 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::92) by BN0PR08CA0004.outlook.office365.com
 (2603:10b6:408:142::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 08:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 08:58:18 +0000
Received: from [172.31.37.251] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 3 Jul
 2026 03:58:16 -0500
Message-ID: <055c4b8e-f493-4b31-a557-062faad48832@amd.com>
Date: Fri, 3 Jul 2026 14:28:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <alejandro.j.jimenez@oracle.com>,
 <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <mst@redhat.com>
Subject: Re: [PATCH 4/4] amd_iommu: Use INTCAPXT for IOMMU event interrupts
Content-Language: en-US
To: Dongli Zhang <dongli.zhang@oracle.com>, <qemu-devel@nongnu.org>
References: <20260609204403.323149-1-dongli.zhang@oracle.com>
 <20260609204403.323149-5-dongli.zhang@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20260609204403.323149-5-dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: ad791ce8-f587-4fe7-fe2b-08ded8e13a47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|4143699003|11063799006|56012099006|18002099003|22082099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: Cikls5F7feu30zRbhC5bVmilOFu9L6GmDRfG0AiOxl5jo07nFa4W8fgyELb68QFHrr28hIY3VtAnCIR9ZiMG6v9ook5t3g8JF8iPvQ3gmipLuyPr92/EUqPCOz9McdthnEyUZ73pCEBIp6d9ds2qm4WejoF64g8DFeZHqRHt1qcxllHZVETrqE0jv2wzFjaFIijITHgU4I3Hehm2uEPSHES3LDxF6gneidIE+TzaqqNS1gqb4+lLvOujswP22fzxFMJUB70pQA+j8Gte00n4CaVDaUE/C+/HSxfTVulxFTa/TW556+GQPiQFWqsjtX3UuDiDb97OfoXraBT7BbdYkO06dSlfTtc9LARaJYpbCD0kNMxl/e7ezXUIRSYFHDuoKjCb8PUD/LmnobN72Fgg6DBktxQVZI+MG11E22LRX/VQncLbAMte71gEOJGA60iS1WDuQukgSVDFLPOejz1x2xOxPI/CvBuxfr0BOI6anldDTxLmrUF9k5yllFcg5B4CL09wSw+XBXGPirju4ncogL0MobnowcVYicJ5r40J0DC0ObObKVzmIOjDnlCiJeXxVeTN+BnFRFG5h4yDkMrPrZYo2i58NL/loZEl4jFZQ54VJR6QLUfAB0nYqlgFiqTjf0bRqCX47Md/Z3ia/a364nbk+jwOnflY/3OSBtq9XnHJ3HIltWUTH+v5ghGZj52KusIP26A0F34VZ65xqH7G+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZYmIZ43XUEVz956zTQMS8GU/GUZOeUBGsLkBBT1Xy7K7p89DWBpgw0LmEHqNZHvWxP8SZzl4PYZ5FHl5HQHDi9v0cwRwoUGJtU2zD2bwn7g9j19KM5dfftJ4puoGjnplnAatI9Fs/S5EpYgvQpm3GTReDG+wN5lntTcCDhAybXhOeaM6cWb9HaXHxo3voF/H+ukt7TDFpCnKu6qfCXS52XBta5TUQc1Yy1ALi3SaXMgdetmJXnScbnYwQVcUxnYV3qFB0JC6qipYjyposdmU/SSOqw4BXRdNyJtTp6THoWYEqZeweNEHJu8w+CpoYeztqIo3z7paTv+daFVSpROg3DC4LXLSZLmCQX/oLoa/1wyweHT+Hje5MqHZixf4OZapLQSUe7NyqGTCYNZT7q+onbpVqUzJttMGv223AHrnhLUL5DdYyLrklCbnBqBiAbfn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 08:58:18.9836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad791ce8-f587-4fe7-fe2b-08ded8e13a47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=Sairaj.K@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



On 6/10/2026 2:13 AM, Dongli Zhang wrote:
> When xtsup=on is exposed, Linux switches the AMD IOMMU event interrupt
> setup to x2APIC mode and programs the INTCAPXT event register instead
> of relying on the PCI MSI capability.
>
> QEMU currently neither records writes to the INTCAPXT event register nor
> uses the programmed event vector when raising an AMD IOMMU event interrupt.
> As a result, DMA faults can be logged into the event log without
> delivering the AMD-Vi event interrupt to the guest when xtsup=on.
>
> Add the INTCAPXT event MMIO offset and accept guest writes to it. When
> IntCapXT is enabled, build the AMD-Vi event interrupt MSI message from
> the programmed INTCAPXT event register; otherwise keep the existing PCI
> MSI fallback.
>
> This patch intentionally only supports the INTCAPXT event interrupt path.
> It does not add PPR or GA-log interrupt support.
>
> Keep command completion wait interrupts on the existing PCI MSI path by
> using a separate event interrupt helper for INTCAPXT delivery.
>
> Send INTCAPXT event interrupts through the APIC MSI delivery hook so
> KVM can handle x2APIC destination IDs above 255.
>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>   hw/i386/amd_iommu.c | 50 +++++++++++++++++++++++++++++++++++++++------
>   hw/i386/amd_iommu.h |  2 ++
>   2 files changed, 46 insertions(+), 6 deletions(-)
>

Hi Dongli,

The fix for this issue is already upstream
https://lore.kernel.org/qemu-devel/20260302115130.5903-1-sarunkod@amd.com/

You can drop this patch in the next version

Thanks
Sairaj


