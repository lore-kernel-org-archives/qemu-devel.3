Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28686E67A9F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 10:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxMrg-0005eJ-5H; Tue, 03 Mar 2026 05:20:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vxMrc-0005e0-Jk
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:20:29 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vxMra-0007oE-Bg
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:20:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYSZ2qW9/y8b5JEnwOmM+cdZxup6Od5Jq31VOzLndlzosNrQ8gHLZ4CNM4go4U9y9/II02anJL03KcAp4d3PU0svcebrCsw8pXYazmYYGtbLMlJAaQhFYThoaZcYfHxpQP9McFG4b+gq99ImibKyymY/u/tNbztwRG6JuSvuuvWUMZAZxdnzpqYVoA9nXTxuUUEwAgEgpL3xAOgSK52OEIZFIJ4yJWtBxsXJki5WI05LzUSObUPBeEnTwGVrCzp7ZLORrls6B5R17pMzD21qXv8TT62HkXsbpkw4jC/1By/6TcSHH3+b7b2pZIGpddoArkgCXqG4G1YI4eE5uTSqBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRKZ/YtSZg59vkY9R9wCSE6E96Gz/BJgQhazBNvYyc0=;
 b=ObjTbYrOrDQ0m7tYgYviSEVMo9w9dSTaKzu9bq5zLCOc2eD+ydfnoxKlJzegS3ntzUgCtLNjI2aG8+1AyoRSFqLQkNN/dzt1IAYwl4niHIBruSCizhY4lbO4+DoqVZ6zAiT21bJdhVUzH3wZowjQBx3if8P9sB+UEHJWq7wMK+dcwVH/0+D89u7AsaWnNrW3kOT1lb3d+BPSLv1lc73r6elw9qyxD/F+dydB/Wadr2rRCbrYBkukRY9H6g4I6J5M/oF8ocoksVvYqT/zvkdhR0T/dULM8qiNy8heqeDClwqmiag52b29QbTZtwH7oGDgsw4kBibXajcTEFYpawp8NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRKZ/YtSZg59vkY9R9wCSE6E96Gz/BJgQhazBNvYyc0=;
 b=SFLipTQWMXckWbAqkyIeF2yLGcHJFzhjEDEQ3exSDdLy38NOIkKrP9OPGJh43smbLjClTdJ7Bmu6P9UQInp5mCa46buubYQfBCu3yuLLmsatbaoAoYozU2blwIzeaGb71kB9GFYe7tudCWE+Qh6Gtw3qR62PGPcISPTKKmN5Rwg=
Received: from SJ0PR03CA0131.namprd03.prod.outlook.com (2603:10b6:a03:33c::16)
 by MW3PR12MB4394.namprd12.prod.outlook.com (2603:10b6:303:54::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 10:20:18 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:33c:cafe::d8) by SJ0PR03CA0131.outlook.office365.com
 (2603:10b6:a03:33c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Tue,
 3 Mar 2026 10:20:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 10:20:18 +0000
Received: from [10.143.206.15] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Mar
 2026 04:20:13 -0600
Message-ID: <b5bc74a4-b6cc-4d37-bd74-82f457db3757@amd.com>
Date: Tue, 3 Mar 2026 15:50:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <alejandro.j.jimenez@oracle.com>,
 <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <eduardo@habkost.net>, 
 <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <clement.mathieu--drif@eviden.com>
Subject: Re: [PATCH v3 2/3] amd_iommu: Turn on XT support only when guest has
 enabled it
Content-Language: en-US
To: Vasant Hegde <vasant.hegde@amd.com>, <qemu-devel@nongnu.org>
References: <20260302115130.5903-1-sarunkod@amd.com>
 <20260302115130.5903-3-sarunkod@amd.com>
 <27d6b36b-c8df-466f-bf67-26e70ef34cb8@amd.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <27d6b36b-c8df-466f-bf67-26e70ef34cb8@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|MW3PR12MB4394:EE_
X-MS-Office365-Filtering-Correlation-Id: ef858c8e-83ec-4298-bb11-08de790e77f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: u84xLJbxlmWXrFEbnjW3xvsaP3YgglW0XX3XmfOHJgO52fxkpVEh8ct/ffXU0o69Mvqqk8AGuzBOpO49c9YquJNuFHW05JPI7K/ejRriHin2ffPmji9bBbNbrJWyDRKwd6Cia1sSIg2DDkUkp0kPpbc/coigYQPOVjGq+uR8XUh9Y7MsB+sSdmM1CX15zbI98fiOG9M+kge2Q23QnOH7E4X6iKmMd8JkPJLT1wCdXIvYKxY4MTs/sZFa7HhPtS/M0CviZqKtYUazZLZuSeHHvFenA4t8e7yk4vrLF8YbHHvr8kv+ZG087N8AsWSuYSnh/z69wBUbhGJJ0MuR25AJfDeDU3pDmGhJGup4Lrb989XWi/z6Zqj/0QLWAKGa6ayPgiKfzD93YC6xrG9Qee7LDwFRXoKaxPjFo0vS8NLUfUdZl86evsuf49e5B/uTunRwzmQdTDe/R/CfSIG/Qapp360jKo2eINNlcfS/z8UGuvuLMwqiAemoOFuhxJNizF9ZBcK+4YbyNrVsVpnQB9Sjpb1ZQ3klKff6Kkim1rM6T5/tsQ+5Er2EP3JncDuCicddSczsiT6sFJA++ZKUHu3en2WWeZHLntIOfASCJvBsawnI261PcxcluwDVIaY1w46iUTgcjwEavvKaetCzihRw1/Vx4Jn9wVQaY5olWeH7J0cIMExoM1IK5AmFnUOaAMNPDrwVOlAf4dg+fcbLNi0iYW5LKmG60OyUNXVRigUK7LhzuMohv9ft7AhPYIRccaVPKYk6N5jjpGuIDry29v9v5hl6esXUCH2Dou+ONP3d6alT5BwpFa0pTRtkZr2t0wgHXb6Qwzs1mF7lXSwlS79g1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KEBoB+X6vSYnPR6crzB5V2HfuWkJn8euvjmaWcPhIEq6O1yyFpU7AReOxPfMP1zPIhxWwqrIpAis/yQCySV6TnybfqE4F9puzczlTddGIfuSdwa3j9HlpP+vj0rdA2IJssv/jdI+P1dY0clC5nVsqeMXcvnRxamHTzDo642AUicD6AOWEEvHahlLKpcjXc0uBRNbcOHCzif0lTISAe0oeDLB3rBS22SCt+qNoaeYpKQrHI723V9M7haX0NzEu9gpoU5XiMj/wIU6h/eMsl7hLTeozF+ipeVKHhy9QrFUkpm/ksltKWr6pxlXHRa8IdY2DmEVIyPfUFTGGsGWwHCGpofycbzjjq8wnslBYjFsgFRDMrTJ5sD3bcGkngAqTPED6lms76nfjnkoICdxrTkB9isYcp8cjq9DiOHTIkk9RiI5bAKHYeNmzgrmod7KDx31
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 10:20:18.1220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef858c8e-83ec-4298-bb11-08de790e77f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4394
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



On 3/3/2026 3:09 PM, Vasant Hegde wrote:
>
> On 3/2/2026 5:21 PM, Sairaj Kodilkar wrote:
>> Current code uses 32 bit destination ID irrespective of the fact that
>> guest has enabled x2APIC support through control register[XTEn] and
>> completely depends on command line parameter xtsup=on. This is not a
>> correct hardware behaviour and can cause problems in the guest which has
>> not enabled XT mode.
>>
>> Introduce new flag "xten", which is enabled when guest writes 1 to the
>> control register bit 50 (XTEn). Also, add a new subsection in
>> `VMStateDescription` for backward compatibility during vm migration.
>>
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
>> Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> ---
>>   hw/i386/amd_iommu.c | 21 +++++++++++++++++++--
>>   hw/i386/amd_iommu.h |  4 +++-
>>   2 files changed, 22 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index f5aa9c763d02..4a86e62a3b92 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -1523,6 +1523,8 @@ static void amdvi_handle_control_write(AMDVIState *s)
>>       s->cmdbuf_enabled = s->enabled && !!(control &
>>                           AMDVI_MMIO_CONTROL_CMDBUFLEN);
>>       s->ga_enabled = !!(control & AMDVI_MMIO_CONTROL_GAEN);
>> +    s->xten = !!(control & AMDVI_MMIO_CONTROL_XTEN) && s->xtsup &&
>> +              s->ga_enabled;
>>   
>>       /* update the flags depending on the control register */
>>       if (s->cmdbuf_enabled) {
>> @@ -1996,7 +1998,7 @@ static int amdvi_int_remap_ga(AMDVIState *iommu,
>>       irq->vector = irte.hi.fields.vector;
>>       irq->dest_mode = irte.lo.fields_remap.dm;
>>       irq->redir_hint = irte.lo.fields_remap.rq_eoi;
>> -    if (iommu->xtsup) {
>> +    if (iommu->xten) {
>>           irq->dest = irte.lo.fields_remap.destination |
>>                       (irte.hi.fields.destination_hi << 24);
>>       } else {
>> @@ -2379,6 +2381,7 @@ static void amdvi_init(AMDVIState *s)
>>       s->mmio_enabled = false;
>>       s->enabled = false;
>>       s->cmdbuf_enabled = false;
>> +    s->xten = false;
>>   
>>       /* reset MMIO */
>>       memset(s->mmior, 0, AMDVI_MMIO_SIZE);
>> @@ -2443,6 +2446,16 @@ static void amdvi_sysbus_reset(DeviceState *dev)
>>       amdvi_reset_address_translation_all(s);
>>   }
>>   
>> +static const VMStateDescription vmstate_xt = {
>> +       .name = "amd-iommu-xt",
>> +       .version_id = 1,
>> +       .minimum_version_id = 1,
> Wrong indentation. Otherwise patch looks good.

Ahh right, Not sure why checkpatch.pl missed it.

Thanks
Sairaj

>
> -Vasant
>


