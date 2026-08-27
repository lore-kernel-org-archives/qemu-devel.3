Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE2DC61DCB
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 06:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzTWW-0004Gr-AX; Thu, 27 Aug 2026 02:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wzTWT-0004Gd-SJ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 02:23:37 -0400
Received: from mail-westus2azon11012049.outbound.protection.outlook.com
 ([52.101.48.49] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wzTWR-0005bj-FG
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 02:23:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2RZwUnZ1T40Ee7dR4D3KP3asPUegQRtB3CrT3CnsW4OCQ0Qzfx0WuBz6lfBFfHpYBV2xAN3xzKa155mdbKP2R754GkRsFGolXDGRQYC+vs+K6P+lpWberlJb6oLg7Uv8lI64/AVtbpHIWGfYGQtzxbkNOB5OTi3Farsl9hxCsGkNXWVG4JnagwJch/Dy50O1+EWB9TBd8eWkpTr5k7t3e8vhAjdLsp5znavNtYJ/kvVz9J8hevBkWggEjdkmLpv/hC7ZmZnorgJ7VbBgxS+7mRmlwBFIN2Y55Q59vYWAhxrlRkLRF2MqP4asM00JQLMP9LKRzTYgCLJCE5sLq1PAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUPIZnGK6KxTO8s/xKJkMCBSXynIFH7hOnEkF17XCmA=;
 b=hqmdjpIcKH1JqkweowbweClNcTZ+Qqy7rWDAErNLTQ92JxMaUZQFYoXA7DYfu/6tIu5fwRI0+Yy4YHL755k/N8sG5IXofq3tIV022swfxsjrCe5uIMjjPgv10s+aabpNi2itSJaofYjq/as4301MwmKZFxjBHMZaUMV8saqk2LwIT1OaCMSVfP+HtXMifpeRHwaGfzDHIOqIG+/OJwplowkBHbLGuWI3l4tmmgrx5qZtdrNsZr78arkVFZ6s/Ua8jxVx5tmKSfr8xojXzKtiJ8RymdFiwtch0d2z8S7kUao2HjVy1i0ttzbSYeZahaxFVTIuCweU332NKNMrWNP4bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUPIZnGK6KxTO8s/xKJkMCBSXynIFH7hOnEkF17XCmA=;
 b=zw9BeLg5zoF6jon4bNR228No8j99mwEK9xrVPiZQkpHds1lerd3JqD8hBVQ1FOmZROMP4Pli6sErM7p3l9TTFMMUNuCJMCga2wXtytQ43eFUacDF1Xwpl/d7s7f8LLUeAyiUa5jdwO9b68FNATi5wqQkN8EaHrSKe9/ICsMFxv4=
Received: from BN9PR03CA0544.namprd03.prod.outlook.com (2603:10b6:408:138::9)
 by DS0PR12MB7701.namprd12.prod.outlook.com (2603:10b6:8:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 06:18:15 +0000
Received: from LV8PEPF00000059.namprd02.prod.outlook.com
 (2603:10b6:408:138:cafe::2d) by BN9PR03CA0544.outlook.office365.com
 (2603:10b6:408:138::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Thu,
 27 Aug 2026 06:18:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF00000059.mail.protection.outlook.com (10.167.245.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 27 Aug 2026 06:18:15 +0000
Received: from [192.168.1.3] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 01:18:10 -0500
Message-ID: <14e2f520-e5fb-48a8-9fb5-9b8c451d2aea@amd.com>
Date: Thu, 27 Aug 2026 11:48:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, Ani Sinha <anisinha@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>,
 <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH 4/8] acpi_build: Use IOMMU pci device to build IOMMU
 device ID
Content-Language: en-US
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
References: <20260511123937.32743-1-sarunkod@amd.com>
 <20260511123937.32743-5-sarunkod@amd.com>
 <20260731054920-mutt-send-email-mst@kernel.org>
 <79db539c-a89c-411f-8a34-ab49ca6b4bf2@amd.com>
 <1df4e4b7-a89e-42c6-98d6-5631fdece7eb@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <1df4e4b7-a89e-42c6-98d6-5631fdece7eb@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000059:EE_|DS0PR12MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: a69b02b1-83aa-4d7e-3d29-08df0402fab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|10067099003|3023799007|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 9PqTuNQ6wQbpocw2tbe75IvedlXZA8HibOtupz+sZqxYUaNy4oe4qImfrfXRenEbiIa7hFKOgWeYyVlVvo3lH3R3JaoMY3ecShsgopsMXhdeS/ysF5/VIbGZK+/wh8lWauLL0MNeVvu3fgS/ZtIWRYQl2utcoggHg1aOBsdCgwPCm8XygXY4mwd6w/hsutja6rFhWu/vCy2lsI3Q1748z8HKDpl0aGx4zotDGzDSmVWcAnIhUnQoXRmsAcPpIU7NYrnqAvXwFru6BswTsQJjYPJLC7v8ucod2j4m5TLtMBnTjXZJRFLlozp/sFaQzRgPBFp79ymWDOuY8lIi48oJA0v0LN3MoSHb1lGvmZn7eaxO98IuE0dY3yYsEvhfLga6xq94VAZrz409upl4J6ErwtPjtluUBPszFPtp27AnhaaY0JjebKdnfVlxAn/ke2jQCmTIJ7hwb9PQBOLh5mLehjmZHe7cHckTOePd1yzaHVRfGWyKp1gLCdJSOF/8Y7owoX+fXdUpCMg0BT0+J+SD7uhQX9TJ1JUKPxzaqo2424rBcL6OtQFs7KCr+ymiLEjevxTR0GKIRmbqrzxLZA/R4JUBg+EDv2F6OeeRHubpsh/bx9UZGCqYcjHph+V6XshrKD85hMx8Q2WvXd1+098G+45cS0WvpdMsqrjyyXVA6U07SCs1PSwaE2XKfHkUqJvavWp4kOc01qoOEapw4SA5zA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(10067099003)(3023799007)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0HKcD/WyPlcr4XpiNUud+kQhJfTB7e2l7/6mQG08CIVxRK+oUwfzW1v3Mula+bzVmNwKEs1kCA5lhXgZFqukPVC4D9ymhWLPF/HEcZI8eBcdN356KXibG2e6Gna90k7kWe6WNQj11OmqZBt/9qYHKekHmpQ3EFG4/AFBAqheb+YlfItf/NzusBnXs7Ypl3+HZwtPK+FhWbaivL66YbK/jCLddb1jch3pYK2KKpREg4bxZiWR2lyAzdcZSTILZy/itXAXXPmecGrHK3AqOPlWfCx2dB37AxXMj0vLrAGVIyuz22Dr8aOx/M/4ut5gY1K7XzpS+M6nMc6z8prcgJ5BJ/0ELhtm3+FqG8XSZ7oy4My+pQcsb852YkVRZa48qdumAlXfBfyOAhJ1zqhiH4FhuGLUZcrqcm6Pr8j2hDKlS7ewY+fXCSEfEIET5gFapIMo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 06:18:15.2295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a69b02b1-83aa-4d7e-3d29-08df0402fab8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF00000059.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7701
Received-SPF: permerror client-ip=52.101.48.49; envelope-from=Sairaj.K@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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



On 8/1/2026 3:17 AM, Alejandro Jimenez wrote:
> 
> On 7/31/26 8:32 AM, Sairaj Kodilkar wrote:
>> On 7/31/2026 3: 20 PM, Michael S. Tsirkin wrote: > On Mon, May 11, 2026 at
>> 06: 09: 33PM +0530, Sairaj Kodilkar wrote: >> Currently, build_amd_iommu()
>> uses "addr" property to build the device ID for >> IOMMU device and
>> advertise it
>>
>>
>> On 7/31/2026 3:20 PM, Michael S. Tsirkin wrote:
>>> On Mon, May 11, 2026 at 06:09:33PM +0530, Sairaj Kodilkar wrote:
>>>> Currently, build_amd_iommu() uses "addr" property to build the device ID for
>>>> IOMMU device and advertise it throught IVRS. But this property does not encode
>>>> IOMMU bus. This will be a problem if IOMMU is attached to different bus.
>>>> Hence use iommu pci device which provides bus, to build the IOMMU device ID.
>>>>
>>>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>>>> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
>>>
>>> But is this called after firmware has enumerated the pci bus?
>>> And I guess OS better not change that bus number eh?
> 
> The above line sounds fairly threatening :) so I dug a bit more into the
> details.
> Short story: I tested placing the IOMMU behind a PCI bridge, which the
> implementation currently allows, and the guest can (easily) change the bus
> number. That changes the IOMMU BDF, so the DeviceID encoded in IVRS becomes
> incorrect.
> 

Hi alejandro,

Could you please share the steps and commands you used to change the bus
number inside guest ? I would like to run few tests around it but I am
not able to change the PCI ID of the IOMMU with setpci command on root
pci bridge.

Thanks
Sairaj

