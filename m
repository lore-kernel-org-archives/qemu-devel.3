Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1589AD232EB
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 08:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve7Sn-00064e-1C; Fri, 09 Jan 2026 03:03:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ve7SV-0005za-EV; Fri, 09 Jan 2026 03:03:00 -0500
Received: from mail-westus3azon11012056.outbound.protection.outlook.com
 ([40.107.209.56] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ve7ST-0006N4-1k; Fri, 09 Jan 2026 03:02:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KcbK38VCWIVMuSC8CVAAk7jbhPDBKM/eoJY13oxG8LjYGheNXXHaKNumb+pdJfs7VKxI554C2FDH4nHK0grTWJ4DiEI5OPUxiFOE/aAWtW7mnAuKMPO1BP8wYnSHe2JeGBG5VSBiSB/YYZjN8Sb8mM0qTXmpnLWEuVIOP4q5qQisU41vgp7tHHyfsdkLC9N0/bePHSLY5v+PQRhmW/cclw+02qYoY8iOtvTGP4HVZK4aSJHRezJ7p1vwfCrykV9I9y8tBMnR+R/H4/ijaR40BNAA/7O47Kiv8Eq2sLYZIVhukwm8S8QYgC2K3oNdYrsZvR4nLzJdQDMz0ryvH6usiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHEVi0NA/oRrrWmuy7hQKBAinH+Kzd7GxoEJoclu3Ns=;
 b=xCbAD0vN0iUlxKkaNKxZONKLPbPbLggnDCqW+rbCvYKl8uw5tF43IIUDGovpJi5Cky0yF+8YNcRaIYgaCZvGv4T2tPN0H9Ac8M0VZTs101M5F4uh4uxXUDLDOZnLryJzjOXhGHyYuTAiBbfgowrEf9VyABnWWZSLiyyliCZbFfFADMoQdDYdWHagLi09XV9xMWk4c8I9Wye8Ut0cftUC40opU8JT7SWHqRZkSjN2fBS0Xb5Q8gyQNoWPvETpf6ZqUBajJkP2eR1L4MXlj609L1IyOwORCw1GgSQqyFUZbVQbLk+KMLnrDuJ7QUcYFpGqBGO+uNPHSDu8KmyascfhWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHEVi0NA/oRrrWmuy7hQKBAinH+Kzd7GxoEJoclu3Ns=;
 b=aoQF50cXJn5avAKYAOwNBHqEJhanTt5SCRRgZNVQMhKEBW25pqxSpy+JImsYGgP83Bx9WY33IYp93is2F7uO52ja7eP/QxPSb+oj/Lb7gmluS1+NLZpyS8kytPIVCpiW1ydDFYEQs4IE4Itm7v0jOwiOeg9SZXI/OcXy7Pl7xus=
Received: from BN0PR04CA0195.namprd04.prod.outlook.com (2603:10b6:408:e9::20)
 by DS7PR12MB8081.namprd12.prod.outlook.com (2603:10b6:8:e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Fri, 9 Jan
 2026 07:57:48 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:e9:cafe::f8) by BN0PR04CA0195.outlook.office365.com
 (2603:10b6:408:e9::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Fri, 9
 Jan 2026 07:57:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 07:57:47 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 9 Jan
 2026 01:57:41 -0600
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 9 Jan 2026 01:57:39 -0600
Date: Fri, 9 Jan 2026 08:57:34 +0100
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Francisco Iglesias
 <francisco.iglesias@amd.com>
Subject: Re: [PATCH 0/9] RISC-V CPU time source interface
Message-ID: <aWC07qlTj_5vljh2@XFR-LUMICHEL-L2.amd.com>
References: <20251107102340.471141-1-luc.michel@amd.com>
 <aRb1jmwXE18JB2_g@XFR-LUMICHEL-L2.amd.com>
 <a5e9c465-5c4a-403e-8768-bf383256091f@linaro.org>
 <aTKXssxseF4wfXiw@XFR-LUMICHEL-L2.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aTKXssxseF4wfXiw@XFR-LUMICHEL-L2.amd.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|DS7PR12MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: 84dd8a6e-f6ca-49b9-a52b-08de4f54c79c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGJMMG91U3VnR3dlRVZXOEUrOExKOElPWmY4cnJxaktsaTJEWTZWQWVaNHgw?=
 =?utf-8?B?UjZuZS9EWEpIZ0pNZVgzS2lHa3V6UW14QTg2MkFUemZzZzVUWWlXVkIwKzhj?=
 =?utf-8?B?bEFnS00zNmE2UkRLcmt6S2U3R0d0Q3h3Uk1Wa0x3YU5UWFJRUlZOR3ZnYUMw?=
 =?utf-8?B?NURIK2p1bkhXK2Q0OHc3bFErVFA5MDR1YVBkV0pEY3dZRlA5eW13ZHJFOGk2?=
 =?utf-8?B?Nm5KSVlIWkhybkQyell5djRrVDNCZU1OamYwdG1GOXdlYlpMcnIwOW83cGZ5?=
 =?utf-8?B?Y3R3M1dnakFMZ1JiaDhRN21GbjNON2l6SzNQMmhHODRxcW9WSXZKRzJRS2NS?=
 =?utf-8?B?b3BjaUxJaml6aXNBV3V6Qmw3WDRZWUFBNnBPb2FhNGtjaktBRDFuemtHRjJU?=
 =?utf-8?B?KzY1OVBCVWRTV3A5anYzZGxNeXBPYytkandDSHFOZllqWW1jNkJZeENhNTdU?=
 =?utf-8?B?OVF4RWdSckl0MHJKQnJnOVJHdXBrUWdxdy9XMWI3UzBnUTlqa3JsMmFpeDQ5?=
 =?utf-8?B?M0VSV1pvejFTdlFYb2xNVzU2a1c4aEQxVWlyRXczZkRmQXpWNUlCeDBxcVVm?=
 =?utf-8?B?TnU3bDh5MjBKTzFWOUxJRmd3dmdMSjM0S0NrUHAxc2dNU3VZek1JbzNpYTYv?=
 =?utf-8?B?ekl3TVlNOCtRNzkwbFltNGU2OU9FU1RzemZkR0hNTHZ5RzExTDVXN1VReWFn?=
 =?utf-8?B?Y2szU1RSV3RJQytuMzNma3lkTEVoVThxd29CV2lLcDFNcktlQ3gvbHNIN0xK?=
 =?utf-8?B?ck43S0REWk1xZCt4cmpMNE5WR2RUQ1k2Z3FjS1dSb3FPRGprVzhEUWV3NWd5?=
 =?utf-8?B?NmFUMUpYcFduWlhkYmw1aWtuZE1rdkxIUEYyNmdmUi9tV0F3OWhNSnJYMEpY?=
 =?utf-8?B?aFRaL05BblpMK3BiR3I0Q1U3MFhibmtNdjUvV3lITUx4QXhIZzJQc2g4eG1u?=
 =?utf-8?B?QXA5NU43VFBLa0YvNGg5ZVprV1NacldrV1VHTWtBb1FXRVVmWnBhek1Rd24z?=
 =?utf-8?B?cEMyWjVoN2dvcy85UFpoMWhjenVnbC9vSWVFV2FEUjdTQkt5blhLM214NExL?=
 =?utf-8?B?dnAwQk5GbEowVjhEWXVZYnZ2bTh4czdiWGc2MDRqL1ZBQTZsVHV2ODRQdUNl?=
 =?utf-8?B?T3QrQ0FZT2xWQWxJZzVLejdmd1VyYnord2tJNjVZZ0I5VFdPZHk5dVZiZWFj?=
 =?utf-8?B?RWRrTlFIK2IyaUJ6T2hVTGZDMUxGMlMyZDBndE1XOTFyQ0poOFk2dStqMHc5?=
 =?utf-8?B?UXpPbmh5bFBzT2JzRVJaT0FGb3NDdFBsM2pUdjBWdFZtcktsazJncUJqczIz?=
 =?utf-8?B?Qk1KdFlaaFRybEhsZmtNZ1hkc3FTSW1rWEd1ajVoYVNKNlhKVmVNYzl3cml2?=
 =?utf-8?B?RzdEaGViOTllM1pNNGx6NTZNUVcxWHpuZ3B6QVY1VDJLOVk1ODRUYk8vTS9F?=
 =?utf-8?B?cFU5Q0dOdDJoK09IczRpWVFuRDVzaFJSOFhHdmFEYkdOVkNiV2gzMWlOT1FT?=
 =?utf-8?B?c2pYcUp4aTVEY0paaXRuWDN6ZXJ4ai9qMTh3dFkranV2cEtybVp5Z0U1UmJB?=
 =?utf-8?B?dnJtNlBKK2g2SWdMWWd2NVlpQlA3UncvcURQTkl6Uzc1SFFkRUxiVnFXNVdh?=
 =?utf-8?B?SXI3NVg0bVhkRGVlbXJCd3NBK2lPek5qaXJra1ZhK2tBUHNhM2I1UW5RcVBN?=
 =?utf-8?B?WEE3SWlUWFRjZUVla2VpbFJuRGpZR0hyMFV1UjNVUUlibkxnc01YQWxTaXMy?=
 =?utf-8?B?Q0NMWmNwTUp0a0RTOWt4cy94MjV6SWtBQ1hDZXVHZ2NmNVloUTFCT3BmUzk2?=
 =?utf-8?B?MEtGQytEaDlBakg2S2tpSTcrS1kzVWVOZmFiSWpPUXB3MGMxb1FMaGdCWmcx?=
 =?utf-8?B?WE9MMVJZM01xaWllTmY1QVFLeWtiM0ozeTB3dDhnWUxhQ2NQWHdTcHZYRVQ3?=
 =?utf-8?B?cmNGZytaamlQL00zSVBjSmpUUUpTeVhzbVhpa0N2SXNySkI2TVlOL2l1VHRU?=
 =?utf-8?B?NzRmRHBFZzkxeWJuS2VSVGtzSG5kSUNTeTZvbEszTlJNTnJlODB1andPR1Vo?=
 =?utf-8?B?U1AwV3B5MlN0VGJxMHErTmZUUHlaZ0l4V2t6SDFXeVdLVUJqYmxJV2F3cjJk?=
 =?utf-8?Q?2MzA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 07:57:47.7561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84dd8a6e-f6ca-49b9-a52b-08de4f54c79c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8081
Received-SPF: permerror client-ip=40.107.209.56;
 envelope-from=Luc.Michel@amd.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 09:29 Fri 05 Dec     , Luc Michel wrote:
> On 18:16 Thu 20 Nov     , Philippe Mathieu-Daudé wrote:
> > On 14/11/25 10:25, Luc Michel wrote:
> > > Hi,
> > > 
> > > Ping, patches missing review: 8 and 9.
> > 
> > Doh sorry, I don't remember why I stopped... I suppose I got interrupted
> > and forgot. Too bad this missed the soft-freeze, now we'll have to wait
> > after Xmas :/
> 
> No problem, thanks for the reviews :)
> 
> RISC-V people, may I ask for some feedback on the series now that it is
> fully reviewed?
> 

Hi, gentle ping.

As a reminder this series fixes some broken code in the RISC-V target
sstc extension and allows for devices other than the APLIC to serve as
the timesrc source.

Thanks

-- 
Luc

