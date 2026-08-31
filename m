Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8471C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0xN2-0000BB-7a; Mon, 31 Aug 2026 04:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1x0xN0-0000Aw-4w
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 04:27:58 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1x0xMy-0000fr-2B
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 04:27:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xY2rCR+Yi/NfG0sr6LLBbIXF/BFHLEF5ypMuud/i2xbiYH9poyGnHFDncXzQ2zkhTKXjoLMY6bf2RSBrELS+Sz+3lnrlJuaPe2UzpH820SHYY4F5kJvNItUE1TPspNmdKC3oc4+YrknoaLhzkwq32ZwzK2CmwT4XxS9s+3FLdnPWFRQTtB7tsvOuFYqvbB9JQqLbSn3rbA2D+e3SrkekknIr/wLVO/uNnluBtr2bGFp1ZAtjGnL5RQB4ri06irlkdd80Z1lqQpkiSa7Clp2/xvk2kvb+Gh2gQndkPQZFNm9ePZ6jD47Y8BovEbNfw7x1upG5oTyJ2BzyDO6vFWdZpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLOs8YEna7lXdDCZ8u39+xLt7ODUkY412wGXAl3aguc=;
 b=NxaPBZ8nwCgYCbpxfz4nBxmIbon0sq1iwwoWSHOR8lvOGj7hvBDDPQAUEAApkw7O0CQCji9MTgEsWS1lWZfx+heDzIhD5oez7lqbwMkp3CmA8dl3PBgoEo3PziyL+SOWwMu7NaSM3nddvRbx+ssGJjaW+xMjoMi0hz0yOdFKTZBtAQmKAZNdF73vblsTqaWnDJ1wPPZXH4a6xlqR00GpCJyTUZPhaq6HXa1LMPUpf3CVWZ0ThMfe3QQNY70P/xskXjoJCWP6kpJqMJxNwKCT0jpeK9h6GUTEjSak/FaWmiBUC+s1VqeGzD5YSEvGV/FLuEXEUVCIRlrtpxZqgbyxPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLOs8YEna7lXdDCZ8u39+xLt7ODUkY412wGXAl3aguc=;
 b=1cM+yvDB/W/iJqCrP+7t3VXrstaRa0dAhZC1Q0qDRd83qWd3FlO7ag9U/DyIncCbWGYRDl0kXpvUwFgrnBn/2kMmB8THEl9Yy3rNiAK0H3GQM2wmeJDkpgHutoIM/Ali5bo4kTzCO9Agu24UpTjhiTXO8eC8We4+qH20bGH6Vzg=
Received: from DM6PR04CA0001.namprd04.prod.outlook.com (2603:10b6:5:334::6) by
 DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.11; Mon, 31 Aug 2026 08:27:49 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::3b) by DM6PR04CA0001.outlook.office365.com
 (2603:10b6:5:334::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 08:27:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 08:27:48 +0000
Received: from [10.85.43.97] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 03:27:44 -0500
Message-ID: <0ebbbf89-c78d-40a6-b192-ac7e44002c93@amd.com>
Date: Mon, 31 Aug 2026 13:57:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <alejandro.j.jimenez@oracle.com>,
 <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <mst@redhat.com>,
 <joe.jin@oracle.com>
Subject: Re: [PATCH v2 5/5] amd_iommu: Do not latch unsupported GA log status
 bits
Content-Language: en-US
To: Dongli Zhang <dongli.zhang@oracle.com>, <qemu-devel@nongnu.org>
References: <20260724223216.108667-1-dongli.zhang@oracle.com>
 <20260724223216.108667-6-dongli.zhang@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20260724223216.108667-6-dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|DS7PR12MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: c663d1a7-a75c-4b0b-f641-08df0739bdec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|30052699003|36860700016|376014|11063799006|6133799003|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: H1j+s4HKy+PvJc6jChJbdfhFW/o05vCYvoWmXu0aVNRZbo2j0UQDUYtW7lrMqGl1hyU+lc4S7jcYamdrtd9Yz5hs8aNvUd4b+NtpZuokUQk80NUi/ctqErX/ol/LjoNwiv7B061+M1i6wyAEjMlq3G7E7TG7M41dSNZPLOYHy00A2cgMrNO18R+7vtjH4CqyvN4w0j4ZXE5vDb5FFT5s1ZSmp0j7awOSPkxwc2z4jZJosMGYg92oVXxchLklnk3Elqj0foIp8GFrCLtezgwJCVK1nIhaTo57X7rENM2k9jFH4mmo0HXmCt16fWJLwZf0POidR2/NxOafe61P6ehiQdvGZGZg1BXltogv5gBDwB1zGE2G0k4tuLVX5dOMvWty3W7sCjHMygPY5Xa3TS3YXWzk/eKX/jJ+8jFCOvDYR0nwsrY+ceUCscpbbukFehN/sdVayB8hAOqLOWOG51+B965N5VDzyRMXMKY3CdO482fAVCO3kaZ6dVnEn4UwpFq9c8Ja+9Q15KjTHzW2OwmhRE0mJryFhglGrJ5lkSHAMmwKdpnAh+BQbEtpRsO816/Y8WRqwsd53XjdVgKcGztwz6qRL5KI4c8yM2cPZX42E0nV2B0ZTDN4W2Hr3KrI3VVP91kSX23MyPNnaRpdL0EZEP6MeflrriDolMMVz75OnAltCvK8O6GOav3d00xwNamIOnd2X3v52GYDpGHMhwrbIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(30052699003)(36860700016)(376014)(11063799006)(6133799003)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6tRRr0aTqb8qDAWlUJklousTHdtjxJrh5UrKA5Y9954f6+O6BMfp7YhRMEdo+N4E90jYw0GoqvE4/au8K7GlUf08R+bYxkETJsCl/faGMLQKEAiuETiS1RHRuOxy0ky8WUUuTVqw3GS3hQ5notWKOm41E9kV5pZ65M8H0InT8owOMB3bAmACFwetJRjOuw+orjMAArJBNZz1j/cBx4Dl3QgzvJRaiNZPuNFbxnIdu/4amnF2e1vrOum6rZd2vqhbC9QEog5CBLcM5KTW/9zyR4LgWr1BXqpS4LsMKRuUpWXG+5+F4a3AAsJqSDg8YoPR6HI4OSRz2PNkFz0HIk0BxoOKLdLzkboVjOvqmYvojDd3gu0zxFqdHzFs5ygSMdDoXbUB2fy02Mm5WcxgBdYhrl+e1bKi2CQoXEA5p/W3csTGz4a8wvgDdSOthR3uMiy5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 08:27:48.9980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c663d1a7-a75c-4b0b-f641-08df0739bdec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5768
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=Sairaj.K@amd.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 7/25/2026 4:01 AM, Dongli Zhang wrote:
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
> Fixes: 12499b23315b ("x86_iommu/amd: Enable Guest virtual APIC support")
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
> v1->v2:
>   - As the previous commit replaced the hardcoded value 0x67 with a macro,
>     update the macro instead of the hardcoded value used by amdvi_init().
> 
>  hw/i386/amd_iommu.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index 9cd510d790..4932568a0f 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -125,7 +125,8 @@
>  #define AMDVI_MMIO_STATUS_W1C_MASK \
>      (AMDVI_MMIO_STATUS_EVT_OVF | AMDVI_MMIO_STATUS_EVENT_INT | \
>       AMDVI_MMIO_STATUS_COMP_INT | AMDVI_MMIO_STATUS_PPR_OVF | \
> -     AMDVI_MMIO_STATUS_PPR_INT)
> +     AMDVI_MMIO_STATUS_PPR_INT | AMDVI_MMIO_STATUS_GALOG_OVF | \
> +     AMDVI_MMIO_STATUS_GALOG_INT)
>  

Please add AMDVI_MMIO_STATUS_GALOG_RUN to AMDVI_MMIO_STATUS_RO_MASK.

Thanks
Sairaj

>  #define AMDVI_CMDBUF_ID_BYTE              0x07
>  #define AMDVI_CMDBUF_ID_RSHIFT            4


