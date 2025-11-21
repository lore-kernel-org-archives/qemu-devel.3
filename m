Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A23ACFA747
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 08:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMMRj-0002GG-Bu; Fri, 21 Nov 2025 03:24:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1vMMRg-0002Fu-TY; Fri, 21 Nov 2025 03:24:45 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1vMMRe-0006Hv-Lw; Fri, 21 Nov 2025 03:24:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCcYKQ1dWyxV24f44W/FwRGWjIVQnEm/Ccetf62HduL4wOAOboNivHIWYo+o+b7j21diS5j8FpJuqef0qzXUrlq/Ir/b52lsQvOUzHIJ1H2Vt4hilATQiHZYnUFrZK8CUVD05JKXlRqz5hu4KG9bWQXVKKudlXrrPJ+KYF/5vWB0YAMbUVf+eYniT9eNYTOwhBHsGeq/BOPwP9nJvnY5vFVp2J/XMkEOAY4Q4+HAUctSVBOPqPkm6fLAEa4v7D3c0Ff/9gSDTUAxbVEypxmYI8X5Cb2o8tpfZGFFjrTwstTmhj/zrTkfkdvB40NHcgJV/AixjA6AA27W9m6xs3AbVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1oIpnDKtu1r7lXZJ9aC3dvuHClNl+g/XaMQLl7oWLBw=;
 b=Xv5yeiu1BufnAEepYahs8lGBAUXye9YZMMRgtuF68mOnkvHRsRBL27MPXAsCdf5c/WsCJDHzpp7Pdl8YrU3JwCu/4kmnofVr4EupoR87QGYdOz7N0LnF+pNuyyWP0Zk/doaJ5npgfDAeTbzDW08fXw0CMWX3JicZFBJgOS0XZLFAwr9sUtBw7kdHOZ63+AJFrul233I1H+RxXgJi+sc1mIhtgd/M2gcwoPFybq9wzEc+It2WWiJSJdw0I3W78rlkn11W13ao3GuK0tAV2jRVspK8IXrNkR+28MWC8lh20RiOcmjmkaFGxoU2NYLTdutOKMehUDEdNndeyA4bkz2yfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oIpnDKtu1r7lXZJ9aC3dvuHClNl+g/XaMQLl7oWLBw=;
 b=ycEu1GJ5o5ZxsiOYmEQoGgRO83NoLywPhAo6GV5eKPusC8ykWnhy9UaIOgY2ebvUdphuEH7O2GkzfQ+8FF7ljqbWvLo0MJVZQnNG58E6oYHAGPZzfT1WIRVjtPy9DcsOC+JbZp8IJVz2BMqhWy0zOMSTRSmu80mqpIdMvsf9/mA=
Received: from SJ0PR05CA0128.namprd05.prod.outlook.com (2603:10b6:a03:33d::13)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 08:24:34 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::9a) by SJ0PR05CA0128.outlook.office365.com
 (2603:10b6:a03:33d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.5 via Frontend Transport; Fri,
 21 Nov 2025 08:24:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 08:24:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 21 Nov
 2025 00:24:33 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 21 Nov
 2025 00:24:33 -0800
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 21 Nov 2025 00:24:30 -0800
Date: Fri, 21 Nov 2025 09:24:30 +0100
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Francisco Iglesias
 <francisco.iglesias@amd.com>
Subject: Re: [PATCH 8/9] target/riscv: RISCVCPUTimeSrcIf: add
 register_time_change_notifier
Message-ID: <aSAhvvS5EkZeI7o0@XFR-LUMICHEL-L2.amd.com>
References: <20251107102340.471141-1-luc.michel@amd.com>
 <20251107102340.471141-9-luc.michel@amd.com>
 <350863e7-19eb-4c7e-8b33-c4f7956ead4b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <350863e7-19eb-4c7e-8b33-c4f7956ead4b@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: b2676e41-6765-4708-ac98-08de28d766ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dloycXVlOGJLcWxQOUNTV3NDZUVsUGxpMFZiYkpsZjN0VG9WcHVWVU9USjZj?=
 =?utf-8?B?YlF3eCt0aG5xNDVMb2h5WitBQi95dkJSajU2RlRER2x4MElKTTYxUU15bndu?=
 =?utf-8?B?RjZCTFI2OW9hcHFGRVZBaWsrNlcxZ1NtQzFjdUx6Y05vNmk5VitVb0ovVkJ1?=
 =?utf-8?B?Uy9MWXlaOFN2cUluRWwrOWEzNzh2bGlXWXB5ayt1WUxQSzZHZ0YxQ1lhWTU5?=
 =?utf-8?B?a2RzK1p1Si9GSDZQUVlWMWlhUFFSQ0RZSGVPZ0t5d1FRMjBOZ1Q3QnF5UXU3?=
 =?utf-8?B?cDgyYVZXWTR3YVQzcUxPLzIwclVaeWNBV1c5RGdDMjFWWDV4WEVPaWNkay9O?=
 =?utf-8?B?VTExOUlsYzhhNzlhYmZiNzdETmtublV4MVhYOWI0VUQ0UHZGUWlFV0dwQmIx?=
 =?utf-8?B?aU1COFdlY0xwRmVJb1lVemgxWlFCZisxYy9jQXU3Qm10a2Flc3kvMEk4N1Bn?=
 =?utf-8?B?SHpGVHE1TEYwaDlPUHVlN2xBaHl6R2tnL0J1bDF2K0RnUHY3djU5bFZoNzl3?=
 =?utf-8?B?bzVTalFVVXhON1NYZkw3UzBCUjBRRHhtLzV5bERlc0V3VzdicHFXZEtGT1NQ?=
 =?utf-8?B?aExJNzJEUEhxak9tSnE2Mk1oaDRLYjJmcGNFYkw1RWhYTHBHTWFjSkNRNmtT?=
 =?utf-8?B?U0ZPLzRYTXpUNWVqRzl1WjRxQmhOMFpYWEM2NittazJRa1FZMzl4Y0g4WWFY?=
 =?utf-8?B?dGNvTTg1ZDF3MWd5Sy93Y0ZKa2YyNnBSd2JKVEN2TWQyZHRmeUQ0b2hZWHdk?=
 =?utf-8?B?Rnp6K3MrbHR2S1pNaGp1REl1MDIvN1V2U3htMHJMUitjSXlQdUpETkZzTENN?=
 =?utf-8?B?Vi9hK0FPS3V5bjB5eEw5bVczc2pXdjFFeG9wS1ZGa3Q0ZUI0ekFhYTNGeUkz?=
 =?utf-8?B?ZmVBL3ZWM2hTeXJrczM3eVhLWkRMMUFUYVVGZjh2R3hrSW1uT1dMUEk2aVVH?=
 =?utf-8?B?YXBqSGk3c2ZEazh5RnZtc3RxWWxhak4vYUxQVDRXaXZDV0VOYnljaU53eTZC?=
 =?utf-8?B?Q3JOWWJoV2xGZDFFUXQ5Ly94MnR2MUhKY05Zam9IQm1vUVZFMGNqNnkvYm1u?=
 =?utf-8?B?WkRjZUMzRHZEbjUyNFVxQlVqWi9RcEhBWjVabXVTbDg2aXpDOERLVSswTFhn?=
 =?utf-8?B?RVZxU2VTaGZxbTBPaWt3RjJyUk8vbStvQUg5NlZZYk5WYWc2VUYwNFhzUisv?=
 =?utf-8?B?RjVVdE9WVDlOUHV1d054K1FlT2FDWTdMNHd3K0xubXZQYWNJUlgxTzJqQjZm?=
 =?utf-8?B?U2lyQUp2REcvVTZodzJYeHNMTnNjNlJ5dUhvanNVRkZtWitWUU9TTnIrdlNl?=
 =?utf-8?B?NjNSTFN0WTRETnlhU0wwUmt4Q3RxTUFkMUk5VW83YkptMk1MYlQ4elU3bDJS?=
 =?utf-8?B?WTNPTlROeUdyQi96ZVlJU3dEMEJsQTNjY2FVMjdLTzBTemJaUkt3NDcreUdD?=
 =?utf-8?B?aE9Gck5SN21aN1dBcGNwR1ZoK0UvZnB6WGRUUWlITStvZjVHS3hkQ2xubU9U?=
 =?utf-8?B?SzkvemdXY2ZpZVNvTDhveHhkUjF0Yko2NUVHZEZsMDBxVGhzR1VkZGRjV3Ew?=
 =?utf-8?B?Sjc0WmJhTWVramJKT2FHWEF5dFBTZEE3dnJJbFFyL1d5Q21lYU5yMzcwNFE0?=
 =?utf-8?B?ZkZxWWxISXk5VXlya2pZZnJuRk1TcFd3RTdUQmpKS2R4dFByWWtsNElSYVdW?=
 =?utf-8?B?RmhKNUVyM1lLcE9PYkZ1LzROVVB6ZVlPT1hPTFFaZ254Q2pzT1NtbWRQM2pE?=
 =?utf-8?B?eFIxdWg5dzl4eUFheHRweHFEYm9QVmZGQml0bTN5TEtQYm1oUHNKNGZpVzln?=
 =?utf-8?B?a1Q3NjFlWk00UGhKMlY4eXg4UE1LR3F3YkhUaDdtUjJlckdiMUxycEh2YUxa?=
 =?utf-8?B?QmdBN2N6bHVVYzBoV0hsNG1BdndMMDRxVU9DZlFscVBBdEQ0dno5QmhyYWth?=
 =?utf-8?B?K0dXY25Udys4YkRwQjRKUTU1VDhzVHZzN2ExbmdEUXVvcm9PWjdWZlVSVjVC?=
 =?utf-8?B?R3ZyTHB4SEJOMy9yWlRhN0VNTnN1RWtpanhnYTU0RFNrVW5TVjR0TW9KZk9G?=
 =?utf-8?B?VTdUMDllYzh6ZTBvWFZWdGZwMXlSM1ZmYTNHNk5xVEFxdEYzMnhlczZLcENB?=
 =?utf-8?Q?s5jk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 08:24:33.7896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2676e41-6765-4708-ac98-08de28d766ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=Luc.Michel@amd.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
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

Hi Phil,

On 18:20 Thu 20 Nov     , Philippe Mathieu-Daudé wrote:
> On 7/11/25 11:23, Luc Michel wrote:
> > Add the register_time_change_notifier method to the RISCVCPUTimeSrcIf
> > interface. This method allows the time source user to register a
> > notifier on tick counter asynchronous modification (i.e., a modification
> > that is not due to the monotonic nature of the counter). This can happen
> > if the time source counter is writable, which is the case of the `time'
> > register of the ACLINT.
> > 
> > Use this mechanism in time_helper.c to recompute the sstc timers
> > deadlines.
> > 
> > Signed-off-by: Luc Michel <luc.michel@amd.com>
> > ---
> >   target/riscv/cpu-qom.h     |  7 +++++++
> >   target/riscv/cpu.h         |  1 +
> >   target/riscv/time_helper.h | 11 +++++++++++
> >   target/riscv/time_helper.c | 13 +++++++++++++
> >   4 files changed, 32 insertions(+)
> 
> 
> > diff --git a/target/riscv/time_helper.h b/target/riscv/time_helper.h
> > index b51fdd96570..074b516f4ad 100644
> > --- a/target/riscv/time_helper.h
> > +++ b/target/riscv/time_helper.h
> > @@ -42,6 +42,17 @@ static inline uint32_t riscv_cpu_time_src_get_tick_freq(RISCVCPUTimeSrcIf *src)
> > 
> >       g_assert(rctsc->get_tick_freq != NULL);
> >       return rctsc->get_tick_freq(src);
> >   }
> > 
> > +static inline void
> > +riscv_cpu_time_src_register_time_change_notifier(RISCVCPUTimeSrcIf *src,
> > +                                                 Notifier *notifier)
> > +{
> > +    RISCVCPUTimeSrcIfClass *rctsc = RISCV_CPU_TIME_SRC_IF_GET_CLASS(src);
> > +
> > +    if (rctsc->register_time_change_notifier) {
> > +        rctsc->register_time_change_notifier(src, notifier);
> > +    }
> 
> What about some trace event to help developers? I.e.:

I made this method optional in case the time source is read-only. In
this case there is no need for a notifier as it cannot change
asynchronously.

-- 
Luc

> 
>    if (!rctsc->register_time_change_notifier) {
>        trace_riscv_cpu_time_src_register_time_change_without_notifier();
>        return;
>    }
>    rctsc->register_time_change_notifier(src, notifier);
> 
> > +}
> 
> Anyhow:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

-- 

