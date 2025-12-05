Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F217D2E03E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 08:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRRH4-0006QM-9G; Fri, 05 Dec 2025 03:34:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1vRRH2-0006Q3-1O; Fri, 05 Dec 2025 03:34:44 -0500
Received: from mail-centralusazon11011036.outbound.protection.outlook.com
 ([52.101.62.36] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1vRRH0-0004ti-5Z; Fri, 05 Dec 2025 03:34:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWRsAgt/nit6FGuBHyfywKGHZiRhYS13e4x5uLR69x1dX2JLuhxIQJtfFZHe2kuliltsJdAZIJ89sKg35mGsuku7tPXjTAhSmm//pJIDtXX+Gqnhg7ypWWDogB3WS8ZY8O/yVL7+poyXvUdt4IFPtNUpwq3QjBpd4JMgJOros0QVasbYuBcMsdadpMl0MEu/b2rqBeUmGiWmb90cpCi6ayLSqvRnb6yekl6E15Hr2bQg2vSKWH6fBoIpn8HwY7pRuwxbk50i/XqDvo5iR6ZUo5NRAWnyyFCtdhg/IFpJxPGgfQS9zgMC3qZPQpi3xMyXbEbCfCJ2J6Fy+phlny04Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUzZ3mh+neuVTn5R+mZ47jYyaxlRpOu4LB16t7RIyg8=;
 b=C8D/YO/eLJYyq58lILsv+oMhJcSkqG2jauiqmGpNYFwfdrk5OWLRPEVFpkOAbSKBg3DT2fZGpbTcGcGaQvF8twUCSbMhMQHYclrzUlme2tHZ+C+uk8Hrld1mblbmfe9KuyWt12mtIAr29uPyL1ONNNtOVg6xXkNsArRlb/eaMxaSCDOpT2KWGjZBGgNcBj+Q0be4U08SQ5rcWeNeRcftvkMJs+YSwGJP7LfcXIi+MlnReoTZSHIDSxEPiNBhzfKjkF3gdxafi1GRyJ6WFQ2Pr7jKakfXXtWjMB1E0oF23Wb44s5WdgbcfHMHwN44qd1Nq77sZ2vCr/OOgpyoQKXQjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUzZ3mh+neuVTn5R+mZ47jYyaxlRpOu4LB16t7RIyg8=;
 b=03M+6kyLBCsWJI3i1jfUmDGRL+q/dbjiJc5604jAHy/Usew8X77EWmiPcdylVzYkGT+rTMS8jWPMvLhBksxyYO/H7ZDkFXDSmgGq0MGufLZIxGkGQiYZBmXXotkBpPFXgcsqMTJPmhZSMuYWbR3HPs2N2fyvkdAaztNrZGsfrC4=
Received: from SJ0PR05CA0156.namprd05.prod.outlook.com (2603:10b6:a03:339::11)
 by CY5PR12MB6081.namprd12.prod.outlook.com (2603:10b6:930:2b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 08:29:34 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::f) by SJ0PR05CA0156.outlook.office365.com
 (2603:10b6:a03:339::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Fri, 5
 Dec 2025 08:29:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 08:29:33 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 02:29:32 -0600
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 5 Dec 2025 00:29:31 -0800
Date: Fri, 5 Dec 2025 09:29:31 +0100
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Francisco Iglesias
 <francisco.iglesias@amd.com>
Subject: Re: [PATCH 0/9] RISC-V CPU time source interface
Message-ID: <aTKXssxseF4wfXiw@XFR-LUMICHEL-L2.amd.com>
References: <20251107102340.471141-1-luc.michel@amd.com>
 <aRb1jmwXE18JB2_g@XFR-LUMICHEL-L2.amd.com>
 <a5e9c465-5c4a-403e-8768-bf383256091f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5e9c465-5c4a-403e-8768-bf383256091f@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|CY5PR12MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: b60ae0af-9a90-4e81-127f-08de33d86b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cy8vZXFIc3ptNUczL29XZ2x3anBSdHpzR0JmWjBndy9RRDQ5MWlCc0hXc0Jp?=
 =?utf-8?B?aHVEc3A3d3kvOGFObS91THlzbHNaaUU3aGJkL2Z1WGh3MHAzOWg5bEJFbG96?=
 =?utf-8?B?UGFxblVFN09udi9zdDZmZHV5cWRUQTFSUG5oLzZqWWd0bGluT1E4eVFxeVNS?=
 =?utf-8?B?WnpyV21JSWhNQTFkRkREUXl4dFlCQlNBcEtQcld1TDhWSmxrd3RJVlhtcWZ5?=
 =?utf-8?B?KzhRcks2MzdwaGN5cjlCMDI1NzRtSEM3QnRHM24wMmJkQXBiSlJzWGZSTmoy?=
 =?utf-8?B?YzFWMlYraExMQ1BkRUNvcnZxSDd1eWs4Q0NuV2d5eFVhRVp5ZVBoemwyZG1w?=
 =?utf-8?B?N0RXRmRqeUFHcEQ3NkcxdkI1N1F0Q01DZUU0T215bzRYck1Ld0JPOEQwY1pm?=
 =?utf-8?B?NkNKb0IwMUpTTVNvcGdzR3REQ2RyUkRnak9ZeFlmRS9OOElrY0VKN3JueGRy?=
 =?utf-8?B?VldZMnJqeHN1MDZVb1pJdFMxZnJSY29maVRJQlJBU0dJSmRYbjl3cGl6NTZB?=
 =?utf-8?B?eElpYzd5MlpxVDdzWEVCUmg5ZEs2TnJWRFl1bVN4UlEwVlhwdWlzd2VyUUVv?=
 =?utf-8?B?NnljYmpweTRBeEVjL3lLaVdlSms2elhLVVFiZTI0cDA5eEw4WjRkakxCZDdK?=
 =?utf-8?B?VDhRWmxBMkM0UGZ2Zkx0d0lRRm5YMzlzR05GMWVaZHlEYk9ZcWRpVGl6ckVn?=
 =?utf-8?B?cm5YSzd3aXRnc1VvRk1UZUxnaVlTZXFjVHhTcHNZMmJKU3c2ZDV2VWpZYnND?=
 =?utf-8?B?dTE0V0FpWmhaeGoyUHdLTElrRWcvVGkzS2F0STRFdXZ4Mm92SGpWc1JQQzNl?=
 =?utf-8?B?dlRxd0wvank4am9ha0wxcGNIYzVXV1JqUjhoaStlUkxOOWk1WU9EWDVTWk9x?=
 =?utf-8?B?MGFNSWE4NFYwYTZDVWhab2ZKQWp5M3FPL2V6ZmRqZ09hUnNkcFVQcjNKOXlS?=
 =?utf-8?B?Q2NxV2Z0N0Z6T29rTzBvS3ptcG1kdnEreGdwVUVaeno4TVBCYTZodStZNWZs?=
 =?utf-8?B?N1VxU2lTR283OGhnNkZJektMSzVEK1k5WFgxN2NZTHM4MTdjanZtUTB4V3ZM?=
 =?utf-8?B?M0RRQnVSUFg0Z2pMSTJSVkdxZU5jUDFxdjlqamQwWlJKRXVIam5pNjhHZVRL?=
 =?utf-8?B?REJDRFlLa3VzaHY1SzBIMGVvY3gyTmNzTmxEVFFXWlFhWGZUVlptWUlhbmJk?=
 =?utf-8?B?ZkpoQ3dkdUE3ZFd2YXJQL0F0VWVqaC9vL1F1bm1hY0UycFBzZTIvL3J3clNk?=
 =?utf-8?B?Z20vMjAwdGljTEdDZjMxTGF2U0htLzA5TzFoZm5JSHZPbUJCcHZqYXdnWmEx?=
 =?utf-8?B?MlVQNzJ1dlpVK1FlTyswYWdmZG5KY1V4Vk1OT2lFRm1Sa1R3WmNVUGhTV3hQ?=
 =?utf-8?B?ajZCclZocCszWndsK2ZsRFkxZWJlRERoZHFxMkVUdjduSmtJU09DMGl5RXJN?=
 =?utf-8?B?MmlpQnJvclVHSCtSVVJEU1BvVndaOWlqRktJa2NKeWZIRm8vYXNVUUhxS2Nu?=
 =?utf-8?B?YXRINFIwaUZCLzRla1RienRUOUFjanBiQklUZXVMdDdpSGZDU3pRMnBXNkhu?=
 =?utf-8?B?alRmZjRRSHJ4dmllNXhNbmlUVjR4Z29Pby96RjI4ZkhWU2Q0RkZEN1VETkxo?=
 =?utf-8?B?R1c2ZE92QUNESitPM0xKUWp1WVdmQ3grOVJqbnNTREdIZUU2blRmbnFGRk9v?=
 =?utf-8?B?TW5KNDJNU2wyUENSVEh3ZDl1dzJGeS9yN3JlZmNWZSs5VGw0Zk5XQ05CMW55?=
 =?utf-8?B?Zm4yWmFRY1hybXhoQnhZeUR0Uy9xMmZGVHMyUUVwVTUyVkp4VlROUUFLZUpE?=
 =?utf-8?B?ZWxkOHB4dFJ6UVY1cW9kTVlqN0JOcS85bzVsMUpXRWtsWGpNSzYrMjE5NXk1?=
 =?utf-8?B?bFNNRm5VekJpQTdueGZYbnUxRWxPWFgyU3luN1c3aHZwdU5pY0xoQUQrVG0y?=
 =?utf-8?B?MUVqSWR2dVRIK2FXcTlOend1T3B4T3RBbHFGR2lReTZqaHJybm1pbE51RS8v?=
 =?utf-8?B?UkM4ZEtHTW1oY2cyMWhEZVQ3emFOVnFWSTRScUpnaldpMlIrZFJyOTUwY3Ix?=
 =?utf-8?B?VWYySVNiTWRyTGRoNmxiTWxxVjhmbUMwYmliNHI1eVVFdzFYODNxYW5oWVh2?=
 =?utf-8?Q?cB50=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 08:29:33.4868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b60ae0af-9a90-4e81-127f-08de33d86b1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6081
Received-SPF: permerror client-ip=52.101.62.36;
 envelope-from=Luc.Michel@amd.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 18:16 Thu 20 Nov     , Philippe Mathieu-Daudé wrote:
> On 14/11/25 10:25, Luc Michel wrote:
> > Hi,
> > 
> > Ping, patches missing review: 8 and 9.
> 
> Doh sorry, I don't remember why I stopped... I suppose I got interrupted
> and forgot. Too bad this missed the soft-freeze, now we'll have to wait
> after Xmas :/

No problem, thanks for the reviews :)

RISC-V people, may I ask for some feedback on the series now that it is
fully reviewed?

Thanks in advance

-- 
Luc

