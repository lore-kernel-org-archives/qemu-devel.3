Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA55CD98E1
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 08:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ36a-00074u-OV; Mon, 15 Jun 2026 04:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wZ36S-00074V-Ep
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 04:55:35 -0400
Received: from mail-westcentralusazon11013000.outbound.protection.outlook.com
 ([40.93.201.0] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wZ36J-0005sp-Qw
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 04:55:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hT2vS/bspKbFSJmu0o1Q6gDShuWrNPmcaTb8RC5j7P4s3fclREJUE8nD6DeQmQXXbLVC5me2vStKQ0yXg2zHHI5Z6khcV8rpKlLK9SOwsVNk83LKuRmRt0z34Q4Q75zdrI1TW/qaJRy5QioDDB5bu/dRK8WbK4SG88n4Pur6z3RwVQ/diPjQfLwpG86rBOgSzvmaMoEC5SvdXdZxoGe2QUps29Qsk79eJXYY0nKf5xQwkWiSyhFGc7qWcdizqF8q2VLGwROGNskoyHzf3IJXOX/sc/jbUbUqVcfYgFwiO2eYdB2P8OwQ27zK37+i1Kd/DwCYNWLF8xDRM29wD2v9HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npaVYxS92gCJmb4Y7CCXeE5SyuS+YZ4kkzATMlK6R/M=;
 b=I9QJCYBBQYFyHsyo6Rw3eZq4KvkcTzF/hsQX+VPREdIVIIzg0JZ0tvs71TOFZ8yDOUEn51Fmq9tRdiwuJVlkdPp7NE+Q/saboFmrx/pO1PTSKPbWh3EYLqlzhrDvpKUTa2XZOoLwAT6gXVAsWIhdd0PEM3MO7cTaBx9Arzq7O7MDukWe8M7H2PoTi5QjnR7ezooGyHV2Kfk2GBpiYSOtrb80nkjxsfySB7WV8QUS5oGB/DztfZiUuAY6f7bRs9i/RJuVr3mLx5Yq4aSH9HPqMhJXi5Y0C1ZxV+OIA60ZGnCLJeYM6gfDJNMW3nHXwOYZPrbzAQWnEO9HvxGOhvQP0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npaVYxS92gCJmb4Y7CCXeE5SyuS+YZ4kkzATMlK6R/M=;
 b=gLQhZRhYN0Vi+AOS6ZeDLAt6xw3WCnkSGfDO5GPZfPWn7a26yzc13ZmcMMKOy72mTgveWsSRBreb8r6D+w0JLEvGpyO8UE2iPTGoSQoP0j521obS85d+/fxChx8V35wgA9rEtgM71x2wSJyU6xG5MkdVKJg/wICR1hZz6dOJDfc=
Received: from MN0P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::28)
 by SA1PR12MB7037.namprd12.prod.outlook.com (2603:10b6:806:24c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 08:50:11 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:52e:cafe::84) by MN0P220CA0013.outlook.office365.com
 (2603:10b6:208:52e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 08:50:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 08:50:11 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 03:50:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 03:50:10 -0500
Received: from [10.65.99.90] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 15 Jun 2026 03:50:09 -0500
Message-ID: <cfc176a2-3f73-4279-8093-eeeeba033b54@amd.com>
Date: Mon, 15 Jun 2026 16:50:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/4] hw/mem: add sp-mem device for Specific Purpose
 Memory
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 <qemu-devel@nongnu.org>, <david@kernel.org>, <imammedo@redhat.com>,
 <gourry@gourry.net>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
References: <20260611100637.2460507-1-FangSheng.Huang@amd.com>
 <20260611100637.2460507-2-FangSheng.Huang@amd.com>
 <9b3384bd-bf7f-433e-8427-7b278bb7ff8d@oss.qualcomm.com>
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
In-Reply-To: <9b3384bd-bf7f-433e-8427-7b278bb7ff8d@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|SA1PR12MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 00aa3f71-637d-4f2e-2cda-08decabb1c13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|4143699003|18002099003|56012099006|11063799006|13003099007|22082099003;
X-Microsoft-Antispam-Message-Info: rRvGqidoP3P0EwZwtwszN/Lo8B+xDraxjwn6BILm7cg2DGNKCHfrUtYnINK11IeA6x1Oj4Q75mKXca05YbMn84VB+lGLbr/bEujv4xGTPcKjKqv9Ty8srx4qBuRejgkquz4UVI6rjzRkHG8ICdX6fdPjR61WDlmpHgim1Tj72EIix+H7sKx/y3dKD64sOC4dFn+BkBEZ2wuoTrejeJonTxNP7vVGd6r2dU3fIuFIMkBUB17LFNqvda62UJBr/9jzocMF/Frc6Th0wfsy5x3N3XIPe5AJ2+qvrEGYhw8TJ/n6jSPzTkSIp6LaiVcMO/najGhSNyxeeRo5PhViDKJYhqg0IpeCKVQBoWn5EZSeMwEdo7I3J9EbGp1+ZFgOQ9lClQdFhlinMeZ0Nj/TKTo6AJdZsY2tcmV47rJxZEKHgcq74L/xbfaISPOo7Lk6lDnc6NEUFci/rOGkzQKU5TAG4s30G5k+elsCuu31N0kDUleauI7kkhSkWD8VWXTv4+tntIMIrwTLlZxSNb6rgwIQG+2RZJavCw5w84QXA0zV44PnR+vSsTeJ2ZTJ8USMPW0K+fSUhfiL5Fx9eaUBvwOFL/GOkVk1h6K/6fHNYx0GipSO896FW/P5i5XW96REwZ4RpGcsVb1RY7UaLSPgug2XoNALTcSZOpgDwxkoR7PU3uE84JaSGjEi52OzXkW0E9RU0joyAI1rBJQoaKnhdJo/q3MDIQyQBOUNy/pv3ebXAm0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(4143699003)(18002099003)(56012099006)(11063799006)(13003099007)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xWcSeam39QYrc0CjfTUo0GmJxkEL46r2oKwI2CupigGpud226ijch/E376FpfzWvcSGgb+Bz1F0Fd8t14B/fLf5j1ZcGR1XXwDPM4znEWDvRANAHZJyzy8spZHPhpWJddIa549yadkdNhRBfns669BMY6pbYyW78CKU9lzPHAf1VsQBZD+aCgOqmklxPS7h6SLM15KEmVQOqEETA4VPfSsOIQBFqFSNG/V6yZJzQg2X27jyfDIbZFMhQF36gsfsO52gcyizrAUqjJwXjmX3B7pbaVgImr5da7P7cMW2uIN4xbnY4gbbRpHdKe94T5DEKT2mMDyuXeeCaEm0uInNf2Yc5T94PiGGRkVofuoVEd4h5TCz3UM/sQmOeG/ETz4r2lmVguUGkpsLRTfK0om9aPfPWhTBMlFG+dDIBgzcGTCXruYrBBkqVM8WI4cFwMPck
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 08:50:11.1535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00aa3f71-637d-4f2e-2cda-08decabb1c13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7037
Received-SPF: permerror client-ip=40.93.201.0;
 envelope-from=FangSheng.Huang@amd.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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



On 6/12/2026 2:38 AM, Philippe Mathieu-Daudé wrote:
> [You don't often get email from philmd@oss.qualcomm.com. Learn why this 
> is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi,
> 
> On 11/6/26 12:06, fanhuang wrote:
>> +#include "hw/mem/memory-device.h"
> 
> Not needed AFAICT.
> 
>> +#include "hw/core/qdev.h"
>> +#include "qom/object.h"
>> +#include "system/hostmem.h"
> 
> Not needed (HostMemoryBackend is forward declared in "qemu/typedefs.h").
>

Confirmed, dropping both.
>> +    if (!spm->hostmem) {
>> +        error_setg(errp, "'memdev' property must be set");
> 
> Already checked in Realize? Or is this for the introspection test?
> If so, use SP_MEM_MEMDEV_PROP like in Realize.
>

Will switch to SP_MEM_MEMDEV_PROP for consistency.

>> +/* boot-time only; no plug/unplug state to migrate */
> 
> Please move that comment ...
>

Will move it inside the struct.

>> +static const VMStateDescription vmstate_sp_mem = {
>> +    .name = TYPE_SP_MEM,
> 
> ... here.
> 
>> +    .unmigratable = 1,
>> +};
> Only minor comments, patch LGTM otherwise!

Thanks for the review, Philippe -- all addressed in the next respin.

Best regards,
FangSheng Huang (Jerry)

