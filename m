Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BEEAC3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 08:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFqD2-0002PT-LA; Fri, 16 May 2025 04:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uFqD0-0002PL-Rs
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:14:23 -0400
Received: from mail-bn8nam04on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2408::600]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uFqCy-0003Or-Q2
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:14:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7vnInLunsNzn+Anp1dQbfSmhnNbHmfh+WDOqqAllC6CpHUpkGpM0K0VFH67ZVh7JqGX22AGj0oRBGpk/irB1DQX6r5ViCCPWGlwoP1OnlWe+JIGhyiPpX9ZdizjcEowxInllt6ni9aJkW1XyamkwnaIRAYBIjD+tvY8gYbGnEuhgPZd0cCPBFaNy2bt4HlYqtSrEX49XU48hRHEp2fqIkqbQcTNamIZXky4+MnJJYbY6Nq/L05Nb1zl0M/+k9yCH8l8EXphSifMFveDNdb7P4ArHKmhbkJ1dxVvXRjwfeEhct6Dssa1rskuwJqnYHKFGJ7mcA2aTHHFWksNmdi6cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cnTF9+SSSxiLx0Su8PReYTpDG+bOe51cVxYlhabXXI=;
 b=qJ1+2CyFlsBePp2Cee5MUmPVM+I+tQvSqP/RBITPfu/oHcwPodQI4vuHFSqSbOiTEO8S3UxuqOStUZhVvlzY5bAXDPdme05CR+2WAE2BQClkg9Z6CQsNZf18fA6MorgZG3+HDeXDdTzyvuV3JyMqyxNzZgzMH+u8BZ9qx7lYEhQ0q/O2vTxbGQbuhF6VSv9NqDYSH/OEKaxyYv0GyHh5oX6TvK66EYfHD99BlsHtbRZjzyd6m4ZslzHq6MVxV8dKQzfeQb8MTsypbliZIQJ/T8ICDygQgwscK6vFz9L/ECLzv516bRPvd4z0vGlcLFlc56NERqeLupqkP+MdLAZ+wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cnTF9+SSSxiLx0Su8PReYTpDG+bOe51cVxYlhabXXI=;
 b=Z8vzUpalhmRlp/QXarsxXXf2xZDXbNmYvtPPikEomT0ivt70Ive2Dn9H8iVY5ZXJ3Qg5AM/oDBjXii98F+dWk7CO8WSJHxBil5keckK+rul1kn86oIR/kNrb4e/2UYp/hMXdq60E4Sfd3OMdmP1mWus4BMM1uVfUQxRVzyr0EdY=
Received: from MN0P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::13)
 by CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 08:14:15 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:52e:cafe::44) by MN0P220CA0015.outlook.office365.com
 (2603:10b6:208:52e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.18 via Frontend Transport; Fri,
 16 May 2025 08:14:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.1 via Frontend Transport; Fri, 16 May 2025 08:14:15 +0000
Received: from [10.136.37.137] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 May
 2025 03:14:10 -0500
Message-ID: <f7c97062-ae55-4dd7-91fb-ab698b55c0da@amd.com>
Date: Fri, 16 May 2025 13:44:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/20] amd_iommu: Do not assume passthrough translation
 when DTE[TV]=0
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <peterx@redhat.com>, <david@redhat.com>,
 <philmd@linaro.org>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <alex.williamson@redhat.com>, <vasant.hegde@amd.com>,
 <suravee.suthikulpanit@amd.com>, <santosh.shukla@amd.com>,
 <Wei.Huang2@amd.com>, <clement.mathieu--drif@eviden.com>,
 <ethan.milon@eviden.com>, <joao.m.martins@oracle.com>,
 <boris.ostrovsky@oracle.com>
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
 <20250502021605.1795985-20-alejandro.j.jimenez@oracle.com>
 <8cc41515-73d4-4d7b-b908-679e3fe2e923@amd.com>
 <26c95126-9305-4e01-8526-f450d91da926@oracle.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <26c95126-9305-4e01-8526-f450d91da926@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|CY8PR12MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: 214fcb9b-5023-471f-286a-08dd9451a620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|7416014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1ZkV29pdlEzZEJzUHFleEs4TWVDL2Z2WUxIdjQ0eS9PSmhYMFZsMS9hZWt3?=
 =?utf-8?B?enZwMk5rY21FRFJIb1hGYTU0Qk5ydk1pTVkvdVp0aXlkN0gyamEzL1BIbDBx?=
 =?utf-8?B?TzE0Y1dzMDRTUmQxZVBSMUc1TXBkbWo2bmwrMXhxTTNuVy80N3dEeTFXc3M2?=
 =?utf-8?B?bmJsZDAxMWxFWEl2bXVaOVdEMW9VZ0crVUFSa0VvSFR6Uk1CdURYSHpBWGd5?=
 =?utf-8?B?SWE3dXd4TWZRNFV3YkhvS2QvT1l6Y3hHZHlzWkNZaVFITmhWcDZhRnRMNWxw?=
 =?utf-8?B?UzJIWlgrK2YwUFAxK3N4bDN3K2lVWVVtUXFlcndsT09VdFk3M1c5azlmT3Yz?=
 =?utf-8?B?cGNWZ20rWTQzVFZKekI4aXYrSkVDdXVkUjlqL3pibTl0K096djY2by9aZ0ly?=
 =?utf-8?B?azIrMERlbHU2eFZpYWZWU2ZWUmtSRFk4NnVtbUlSb040OFgzUjdkNHlMNEE5?=
 =?utf-8?B?Q3UrM21MeHphKzkybldic29iQjBaS2RkU2ZDTjdiTTZpZFBxMkNncmZJWktF?=
 =?utf-8?B?NVUrbW1nejdiMEo5WDhLQW5KUmVsbkNUWE53aGU5bFVOa1lYZjdEM2N1SXll?=
 =?utf-8?B?VVJxdWdieHVBanA2enZMNVB1WG5lNHdBOTlESHhKNG45a0VkUVlweWw4SlNI?=
 =?utf-8?B?ZXhIeFphV1VHcU0vTHB4a3ZwWDJvRmIreFA3OEpmZjU1cTRrZS9TVTJ1dnpr?=
 =?utf-8?B?cEsyQlFHdzE3VGZYZkczMVBYUDRzQXoxTUY0Kytsc3ZkYk9kMS9qamcrYmhL?=
 =?utf-8?B?bzhNNHBhS1hobFFhQnovS2d1WkNjT0g2UVpvNTJySStwV043V2tjaFE5cjVE?=
 =?utf-8?B?bHp2UkthQVNnRlpDSG1mc25SMUpyb2IrRm12dk1uTXdtbXI5T2pGTk9XK0tS?=
 =?utf-8?B?eWxEZWJaRVowakUvRis4WXpPVTlyTzhoNzNUdTNHeEdQWkFDakZwOTk2Qmlh?=
 =?utf-8?B?N1cxQXF1TDBPbkh4VEJjV05tZWt3dE1kSC8wNEYvbUFLd0lvci8wM2xpS2Ux?=
 =?utf-8?B?TEVYU3VGMVR5LzdxMnBJZjVjR3ErMjhwWTlhdmRMZW8rNjdkbzFiWGdQaG1H?=
 =?utf-8?B?V3FhNTFLSVY0TWFYZE5hKzl5YWxTdkdVSCtYdEV0VjhtcUJKVkQxM1hudzJx?=
 =?utf-8?B?cjRPNTR1cStVWFJ5c1NucUJ0b29XQ2JXOTg2cStJUkhqdW5rWWhaUGd3YUQ0?=
 =?utf-8?B?dEVRem5PeXNDYndIT0xiVUYvQ0VreEhFM1pyQ29ybTloTG5CTE5nc2Q5eFlJ?=
 =?utf-8?B?UEx3R0JNdWk4MjBjMTVCTlg4VEdUL25sOFRkRGpFMVJWZFNONmVQSlcveDlp?=
 =?utf-8?B?TWcvZVlncWZnN0RIUFJTbUdWTmF3MDA2NDJOTHBIZEh2WXhIMjlmMlEvdU5z?=
 =?utf-8?B?ejUzcTBVSkdlR1JxcUhRaFMvQkZ0dE5haTk0Z3BscXM4ZUlrcGxYRmU0R3ly?=
 =?utf-8?B?VFJzaEdRZmdJaGtvTnh5YWt3ZDhvMFJsRmp5N0N4c2FRZzAwV2wzQ2JOYlk4?=
 =?utf-8?B?SGxpZ08yNXI5NlAxR0RLam91M2FhRWNKbXZ1ZjE2TnBwU3dOKzhyZWpTSDJI?=
 =?utf-8?B?LzhZYjB3eEsvTzJVdjBXWlU4TC9BV3FQWXN2RGFTRnVveU9UOWM5ZVdXbXVT?=
 =?utf-8?B?WTM1K0ZEQ3piQzZkSys1ZUpidnVmVU5lcDcrK21vTmV3ck9ENkMrZSszRDRY?=
 =?utf-8?B?WEJUMEJ3NzZSRFpMODJVUU1oSDJOSllQY1pjaFhVbzN4QTg5VDR2MzlWeHRp?=
 =?utf-8?B?Q01Hd0toU1BzL3VyRXgrK0ptOWdCVm5tQ2ZjMllKVExZRE5Ga2ltS2RvdWpz?=
 =?utf-8?B?WkR3S0NIT3RvYUl4YTZEcytKZHg0Mmw4ZmhZVFE3bTh2U2xmdWpJRUY0STJv?=
 =?utf-8?B?eDNiNEd3QXE0b1BpLzZwVDl5dVJ1bG04RkNTbUR5RUluVTMxYVdHY3pZQ2ZY?=
 =?utf-8?B?aWFFYmhVRlFleXNLTVRMOTZaUWZ2b3ZqaUt5eHA0TWh3d3lhYU4xQ0JRalJO?=
 =?utf-8?B?THNPMGlhRGtnZlRTZFZTMlY2enc2dERZbXFRZUVrNXVGQVpZZU1SU0RkTlE5?=
 =?utf-8?Q?uWADR+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 08:14:15.6439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 214fcb9b-5023-471f-286a-08dd9451a620
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7435
Received-SPF: permerror client-ip=2a01:111:f403:2408::600;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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



On 5/15/2025 3:19 AM, Alejandro Jimenez wrote:
> 
> 
> On 5/12/25 3:00 AM, Sairaj Kodilkar wrote:
>>
>>
>> On 5/2/2025 7:46 AM, Alejandro Jimenez wrote:
> 
>>> -    if (pte & AMDVI_DEV_TRANSLATION_VALID) {
>>> -        level = get_pte_translation_mode(pte);
>>> -        if (level >= 7) {
>>> -            trace_amdvi_mode_invalid(level, addr);
>>> +    if (!(pte & AMDVI_DEV_TRANSLATION_VALID)) {
>>> +        /*
>>> +         * A DTE with V=1, TV=0 does not have a valid Page Table 
>>> Root Pointer.
>>> +         * An IOMMU processing a request that requires a table walk 
>>> terminates
>>> +         * the walk when it encounters this condition. Do the same 
>>> and return
>>> +         * instead of assuming that the address is forwarded without 
>>> translation
>>> +         * i.e. the passthrough case, as it is done for the case 
>>> where DTE[V]=0.
>>> +         */
>>> +        return;
>>> +    }
>>
>> Above change seems redundant since caller of the amdvi_page_walk(),
>> amdvi_do_translate() checks the return value of amdvi_as_to_dte().
>> amdvi_do_translate() returns when it encounters -AMDVI_FR_DTE_TV and
>> does not call amdvi_page_walk().
>>
> 
> It is perhaps redundant at this point for the reason you mention, as we 
> are already checking the DTE for all sorts of conditions earlier.
> 
> But I would like to leave it in since it serves as a good validation 
> that any future callers of amdvi_page_walk(), which might not check or 
> care about the return of amdvi_as_to_dte(), are passing a DTE that 
> specifically supports a page walk, which is exactly what this function 
> needs to proceed. Plus it provides a nice place to place the comment 
> detailing the IOMMU behavior in such cases.

Yes, agree with you !

> 
> If you are concerned about efficiency, this is already not a very fast 
> path, and the 5 assembly instructions this check takes (with a non-debug 
> build I think is ~2 instructions) will certainly not be what brings the 
> performance down :).
> 

No I was not concerned with efficiency. Thought you missed that there is
another check :).

> Alejandro
> 
>> Regards
>> Sairaj Kodilkar
>>
>>
>>
> 
Regards
Sairaj Kodilkar


