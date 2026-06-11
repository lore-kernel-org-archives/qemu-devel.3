Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2FBCD8CB9
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 07:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXa91-0004iu-Ac; Thu, 11 Jun 2026 03:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wXa8z-0004iW-J4
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 03:48:05 -0400
Received: from mail-eastus2azon11011064.outbound.protection.outlook.com
 ([52.101.57.64] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wXa8x-0000ao-Ro
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 03:48:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHMNEsyNXzLa4Sb6w2CFNym1HD9wsIOc60U1EMgtBzDB7pQDvFNtb0RRNdraLM4YUjVS2sulQedIftMPQVmz4l5WCllDHFkCX1XYZ085UJafNaEv25H+jKQORkgzoSk3bNN2aixoQo89ee2daHuLj8Js4yqAk3V9QVR3JtZbFMv8DPA7H2Esmp7ALysjJNGamHWXbEEZk3ylfd84/i4kNQLRlIh/5d+pjWTEJbUv3giYT3cI4wTmQG4Uc5LsSsB4aaHvYrHlz0HGLH0rTWKk4KUzuleFui9DNi6CMVENQDCrEBa8fQ557PVmceGutu78jCNx8IJL4QdeLJs40BRMBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNLWfu3A3gh5vs2e1oLakyPVqWxd+bOgpGBYkzoDmTY=;
 b=n75yh2BiplU0pyFfAL/Dh5mQDVmK9LT+VGNSNK2wDkTI6r30A2oxtt02FED7A1BT/rieIOHbvjmeeylkfcAufXS7QHqch2cNKAOHdQAonCPm84jTsEhCbcuT9NKqxQhh//kmcfH4ninXJiSlCHayrY8mmdXkaQ6QNbsaJKmufTZ5pFmJdEMfe00RUNE+JFZFEVL+cnS1drXluRVWhFxIqmn2MEYehJxXNTPbd4LWjqWCn5bo2mlYMTbSRPU25HZvQc5ZT6hCQpI5kVsYFR0I2gBjwTTrtbdceDhMj+klc2gOYpaodE6g8gqTh91yyDH3x2ym4eEdF9/6LSBH+a1zRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNLWfu3A3gh5vs2e1oLakyPVqWxd+bOgpGBYkzoDmTY=;
 b=UhoILzEMYzF36hNzO1vn8rPXXVupdL/30sPgpoCLy3IdHN/kMYrwjl5DB6e3x9vYXVJqBjzX5fwOiuhQ5Lv/2V1sIM24ZdHFKJAGbodAqmVOMwxinI9N4LqwLQ0+5J140G5fAI9InvGyCWYGr6bwlANxk30ycNU6qygGaAj83to=
Received: from IA1P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::7)
 by DS0PR12MB9037.namprd12.prod.outlook.com (2603:10b6:8:f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 07:42:57 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:464:cafe::42) by IA1P220CA0023.outlook.office365.com
 (2603:10b6:208:464::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Thu,
 11 Jun 2026 07:42:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 07:42:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 02:42:56 -0500
Received: from [10.65.96.226] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 11 Jun 2026 02:42:55 -0500
Message-ID: <d06fe7e7-5c91-41b0-a078-cc64ef264528@amd.com>
Date: Thu, 11 Jun 2026 15:42:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/4] hw/mem: add sp-mem device for Specific Purpose
 Memory
To: "David Hildenbrand (Arm)" <david@kernel.org>, Igor Mammedov
 <imammedo@redhat.com>
CC: <qemu-devel@nongnu.org>, <gourry@gourry.net>, <philmd@mailo.com>,
 <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
References: <20260605104609.1739911-1-FangSheng.Huang@amd.com>
 <20260605104609.1739911-2-FangSheng.Huang@amd.com>
 <20260609110324.41b410c0@imammedo>
 <f50e7303-e600-410a-bec7-58f756e0efa7@amd.com>
 <d0ed5bc6-5dc6-455f-87ff-111fcf0adca5@kernel.org>
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
In-Reply-To: <d0ed5bc6-5dc6-455f-87ff-111fcf0adca5@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|DS0PR12MB9037:EE_
X-MS-Office365-Filtering-Correlation-Id: 7edc3061-491c-4eda-dbfb-08dec78d0dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|30052699003|36860700016|23010399003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: pvu7TVqQyhPna/GED1Lyfatp1d6ETLq9C2rsoGi2zLF31qSPSqwvvCmvj7HKU1gnAZSizj4ihXFP8Az2qbZmzEiHJvlCF55zaPY1XxiXjmAZTrNt2elAn2Pgsp4wpnrTig+7Uoy1vdBh3g5uqmR6KePVfH8+sPUcPnnJdSgAnMjyZo0xzOMkHpN4UsGRsIW5kEOO2Q1Oy16QE41617qP7MSGnpCjx14W9VaiacGIiM9MJu+KyfTNqCUHCcDC+48c7kgNnLxzVPMB4ZmHxVdF1D73tRd6DWGPWmL2Ahs9K3hcHy888bLUGRE6TFIyzgfNk5HYLK7CuBSo2j4HNu8HU4mzc0mzypm98fxaM59OEYEG8EQ2a81jQiRXovcREzFZ6rVrJVa/+50lpAFwCV7nk96z6heTXIiaclpKYW1gfyN2uvMPGIvBKLZgwZdBWscH1ALHORWyXR3W56dYAdP0W0r1fKin8oWQQM7hlQcDLZeEJf+/NW5I8Ly4eI94pt0MvswZgsWNCkd1ldOEadR/sx4fhg8gPP3LrWSV5Gx+ljy473V1p5Opk1IJsKhvxW/mws327wgD/GXzCLNEV8uWo1jYOkdFhqgO5evC73Z/wF4Z6XdSyysGHVVq/6YX780PEhT8goafPz7iNovCSdSyHr17RtLgbz1Li0cWsImPlcfWKiC565S/7mRl7P1XRrKB9IyTz9PWWlgZXmAAP2v6DnRF7qhuowRZbwEcGNo++6w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(30052699003)(36860700016)(23010399003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 25HHyVFKOtbQPFKQvcY+AJTqc2yOb61mSfei6a67dtTnFJ8dbUITgMTuu7KWzpLZWpqNfv4H1kl4UXe0r+D/stjH2vrFm41xx1TWUcbYeKSEM3bcJYlnAm9zl1iLsPo9tKQeP6tLHIJ2o4YI01udhOPYTk7qL/fe1TPQPIrEe88WMUe2wvoIeKUugWu6eOS6o+FGHtbbj0Q2kDTeeQfUGm7LjawT/oYCGjNSbChNgekYnPQ0jDj1SA2Jn0AUlSd8todK8eg03/p2REwQsP7YRscJNH56A0+A9ZhDYt7ICfdJgxvOWy/NqscY7GWvu563oBPmyUmKtrEojWhVhn3E1HT7y3DIgk0Svu4BBJoTl5VDhIQkyqgOVHzDA5JXK6Xv0iFJSwe9dTmnYwBOeChEZ2sEG1BlRRS4JO6dCpjlrKIMNtT3uEsmVTT1QckJkibQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 07:42:57.0641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7edc3061-491c-4eda-dbfb-08dec78d0dea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9037
Received-SPF: permerror client-ip=52.101.57.64;
 envelope-from=FangSheng.Huang@amd.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
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



On 6/10/2026 6:09 PM, David Hildenbrand (Arm) wrote:
> On 6/10/26 09:03, Huang, FangSheng (Jerry) wrote:
>>
>>
>> On 6/9/2026 5:03 PM, Igor Mammedov wrote:
>>> On Fri, 5 Jun 2026 18:46:06 +0800
>>> fanhuang <FangSheng.Huang@amd.com> wrote:
>>>
>>>> +            'memaddr': 'size',
>>>
>>> why not 'addr', like DIMM?
>>>
>>
>> Will rename to 'addr' to match PCDIMMDeviceInfo.
> 
> Note that we had to use "memaddr" for virtio-mem etc, because their proxy device
> (e.g., virtio-mem-pci) already had "addr" taken for other purposes.
> 
> I suspect we don't expect any proxy devices in the future? (similar to DIMMs)
> Then, using "addr" is just fine.
> 

Right, no proxy device expected for sp-mem -- it's instantiated
directly, like pc-dimm. Keeping `addr`.

Best regards,
FangSheng Huang (Jerry)

