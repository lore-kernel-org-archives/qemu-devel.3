Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78399C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfZhO-0000ah-3H; Fri, 03 Jul 2026 04:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wfZhH-0000R9-Hj
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 04:56:31 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wfZhF-0001rJ-2P
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 04:56:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQtik5f5jNTUX3K+sW9TwjjCQwQQYK/q0SmHyMoXPOCyI6H0tJMZPAwMFiZ0VLICCi/KRFU3YkoPfTPxqSScAXHXz4+wg4zprUuZxaHrNZ0NgklJe73vifSE0dtlwABnFSvsIX/sRc3i7nC5f8zvXJLyMI714WiOBjE0xrQNoe20/3clktlDTuCE/QeuxTzQBolO5WG0A+fNpjA93L53ohG71Rk7WAOEJFx/roEGQ6Efv5UK7tVXMLeDvG9EN9iRwxqP153mosslISmGheeURjKPyOCgAWPKyWZ4fUFW7+WNdME1P5dpPYGV2wnSfKEsaoWKSFqpeBOig8CAlMb9nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKfpQC/YZvWjKY+dueHu8ge/bBb/Rfmj6q0ZOtcgJbg=;
 b=hE3u3aS/l7HIVtRyXp9B7+A/viqrRRofLRVuJhTW1KpMSkIwIbYC6vkgsi6tMj8HH02PgVW+qj3raBtd70dMRRDpw3nRQ3reQST/mYukFZhXp4XDZkWxjYNwxkZnWK1yrdUTDkJutz7V1SfLZcA+GaNEQAKfQ7XbHiClxzLZ+piNV72RW/coSLokBgNWnS1Odk7r1MOtN9+7NiNyY4buGV8ySEAzD4j6i8uwfrN+fvr4fTUB4GTv79j2T+4cBjPiIDEr+Taj71LW5opa5dtawg7T/tMMC0kHbt7XOK2wOtuykLzNpCP54ASIu179CwbSJurzUrpme5MCmMucm/KIAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKfpQC/YZvWjKY+dueHu8ge/bBb/Rfmj6q0ZOtcgJbg=;
 b=uowqdgh189rHSHLwv0RCjXZJasPRLJOBENI1mjnMhD6lD7rEqWIgiqAZ8xMVpEFTDuV8yhnhxK4Fhb9SRrJk7MyYDXkyMaMQzjOET8JuihXXvYeMLhSiy4IAJJb6pbIDe/T97hWSspClAfmO/XeMSHSrkafLMBx9FpE4EKNUMMk=
Received: from BL1PR13CA0361.namprd13.prod.outlook.com (2603:10b6:208:2c0::6)
 by DS0PR12MB8563.namprd12.prod.outlook.com (2603:10b6:8:165::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 08:56:19 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:2c0::4) by BL1PR13CA0361.outlook.office365.com
 (2603:10b6:208:2c0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Fri, 3
 Jul 2026 08:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 08:56:19 +0000
Received: from [172.31.37.251] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 3 Jul
 2026 03:56:17 -0500
Message-ID: <d5bd0a62-c2aa-479c-8ff7-accb38d0b316@amd.com>
Date: Fri, 3 Jul 2026 14:26:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <alejandro.j.jimenez@oracle.com>,
 <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <mst@redhat.com>
Subject: Re: [PATCH 3/4] amd_iommu: Do not latch unsupported GA log status bits
Content-Language: en-US
To: Dongli Zhang <dongli.zhang@oracle.com>, <qemu-devel@nongnu.org>
References: <20260609204403.323149-1-dongli.zhang@oracle.com>
 <20260609204403.323149-4-dongli.zhang@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20260609204403.323149-4-dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|DS0PR12MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d22e7de-7460-468b-ee75-08ded8e0f31e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|30052699003|1800799024|36860700016|6133799003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wfDYyhba8mdw6JsanYfYSJTE9cBPQegJTYS5mpw3g4e0tMizHyJ0U2Rbvl/lOc6ASJeI9KHH3zhX9PGxuzJP8DeQfI4atXwxYTJCrRpYFD6HoeIn6I1j6TIjFPpI3PC0kcjPFv6eeaWAlemFbR2/qJK8EgRP/ifLD3q/xgoRCcvaW0yeaAfcRzJ/RjdxdOKVdpX4qYxGK3Diepo1suW5X5wxP7YPP2hx51yv/+QZezfHpTBYQeIdWljVCmixaaaoyPxqEY/qACzwE/B6f51lv2jo6OkESNQNyGtqOitLC38lmAfGS7n/U33qDaEq7u9tf4bua5UQI3RVRcjmsWN1iXUybtH23by3+ymcojHn6s76G3JxKVGSno4F3EphYl64+/+EPt8o7IgI6ddMib5CjIUZRKIhR2AcCZ4h8UQmwCemx1m23d9TQDebPmdi76iZFIHQJESrPaJee7UIZFm6f64iL17tKrPEsmxJqzSO8p4NY1y7L6u5lZit8SkYTAB2TFjUrAeJpbTLrQG4m5j4pMt/dawYN410z+RpV6fmZ4EFlQJMiDaNg7w3Y5w5UYET/ImKYpsDcOv3GIum/64CJEQpNkrF+brjA5j/mxYAAiBqG8l6ldyfSHZHJoCsP3FzKJxPzeoK/EkWwwC6Rabc6pHcVvIN4RgvDM7VwNPuG1HY6WOCuXq9uz2+Rrc3tIz6zqWIBHT9dAK3xMzVEU6zEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(30052699003)(1800799024)(36860700016)(6133799003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: G/orWnpI/g6XtVTyhVzmpymd7LAGvYCWtxlyEVoCGitjb0oFxCNE7Rf9AkOSQLRDGh7sYzmNkgkW+57pvOyyddtJMJFcDDpeukkg3Hsqm6ZoxT72GrCIUQWLIhsf8tUqteHZbmwy2pqGoDLBRpmCPPcVhQRbFgR0qA88zIc8J1fG6YeuMc+PzBgDh5voQffjeIMsore0qFMYdfkp9ZBfC0pX92afXrLDP7CCKUPKGmp+v1ne3NZCwmMvnci7HoxASl+iwDtSzPWkaHk/WY8lv95W5zo+tDkq3oyEcukG7+REiTXFNktBoIkmspkW68wdRP0l8KmuECVvMhH6VOM0LgKHUaKvTCe6q5Xmbca4jiPYeR6tExiLCAsCIVp6pfnSrPCQJ27Z0k/Ke3R5KQWN+Huzj1x6ZbwN4f94L0OEfOiuSsEop+GQGVB4FhibRwIe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 08:56:19.5978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d22e7de-7460-468b-ee75-08ded8e0f31e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8563
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=Sairaj.K@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 6/10/2026 2:13 AM, Dongli Zhang wrote:
> When QEMU records an AMD-Vi event-log entry for an IO page fault, it
> sets the event interrupt status bit and injects the event interrupt.
>
> Linux kernel prior to commit 2379f3485239 ("iommu/amd: Refactor IOMMU
> interrupt handling logic for Event, PPR, and GA logs") clears the status
> register with a combined mask AMD_IOMMU_INT_MASK when handling any IOMMU
> interrupt. That mask includes the
> GA log interrupt (MMIO_STATUS_GALOG_INT_MASK) and
> overflow (MMIO_STATUS_GALOG_OVERFLOW_MASK) bits, even when the interrupt
> being handled is only an event-log interrupt.
>
> QEMU does not produce GA log entries or set GA log status. However, the
> emulated status register still accepts guest writes to the GA log status
> bits as normal writes. As a result, a guest status clear write that
> includes those bits can latch a spurious GA log overflow. The guest then
> observes GA log status that QEMU did not generate and repeatedly
> restarts the GA log.
>
> The below guest dmesg logs are from v6.4 Linux kernel.
>
> [   57.818224] virtio-pci 0000:01:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0xc0000000 flags=0x0009]
> [   57.821130] virtio-pci 0000:01:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0xc0000000 flags=0x0009]
> [   57.824003] AMD-Vi: IOMMU GA Log overflow
> [   57.825099] AMD-Vi: IOMMU GA Log restarting
> [   57.826338] AMD-Vi: IOMMU GA Log overflow
> [   57.827425] AMD-Vi: IOMMU GA Log restarting
> [   57.828657] AMD-Vi: IOMMU GA Log overflow
> [   57.829758] AMD-Vi: IOMMU GA Log restarting
> [   57.830986] AMD-Vi: IOMMU GA Log overflow
> [   57.832063] AMD-Vi: IOMMU GA Log restarting
>
> Mainline Linux commit 2379f3485239 ("iommu/amd: Refactor IOMMU interrupt
> handling logic for Event, PPR, and GA logs") avoids triggering this by
> chance by clearing only the status bits for the log being handled. However,
> older guests still use the combined clear mask.
>
> Add the GA log interrupt and overflow bits to the AMDVI_MMIO_STATUS
> w1cmask so guest writes cannot create unsupported GA log status. This
> does not implement GA log production. It only prevents guest status clear
> writes from creating GA log status that QEMU did not generate to
> emulated IO page fault for guest Linux kernel.
>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>   hw/i386/amd_iommu.c | 4 +++-
>   hw/i386/amd_iommu.h | 2 ++
>   2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index ca9d79bb51..996c154a3f 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -2414,7 +2414,9 @@ static void amdvi_init(AMDVIState *s)
>       amdvi_set_quad(s, AMDVI_MMIO_EXT_FEATURES,
>                      amdvi_extended_feature_register(s),
>                      0xffffffffffffffef, 0);

Not related to this patch, but we have another cleanup opportunity here
All the extended feature bits are read only, the value 
0xffffffffffffffef does not make sense. We can have it as.. #define 
AMDVI_MMIO_EXTENDED_FEATURE_RO_MASK (~0ULL)
> -    amdvi_set_quad(s, AMDVI_MMIO_STATUS, 0, 0x98, 0x67);
> +    amdvi_set_quad(s, AMDVI_MMIO_STATUS, 0, 0x98,
> +                   0x67 | AMDVI_MMIO_STATUS_GALOG_OVF |
> +                   AMDVI_MMIO_STATUS_GALOG_INT);
>   }
>   

The 0x98 and 0x67 looks ambiguous. I was planning to clean this
code by defining macro for every field in the IOMMU status
register and using them like..

#define AMDVI_MMIO_STATUS_RO_MASK (..)   #OR of Read only fields
#define AMDVI_MMIO_STATUS_W1C_MASK (..)   #OR or the write-1-to-clear fields

Since you are touching this code, it would be great if you can
clean it up a little bit more.

Thanks
Sairaj

>   static void amdvi_pci_realize(PCIDevice *pdev, Error **errp)
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index 302ccca512..0b2e8d207b 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -113,6 +113,8 @@
>   #define AMDVI_MMIO_STATUS_COMP_INT    (1 << 2)
>   #define AMDVI_MMIO_STATUS_EVENT_INT   (1 << 1)
>   #define AMDVI_MMIO_STATUS_EVT_OVF     (1 << 0)
> +#define AMDVI_MMIO_STATUS_GALOG_OVF   (1 << 9)
> +#define AMDVI_MMIO_STATUS_GALOG_INT   (1 << 10)
>   
>   #define AMDVI_CMDBUF_ID_BYTE              0x07
>   #define AMDVI_CMDBUF_ID_RSHIFT            4


