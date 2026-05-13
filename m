Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C014CD4F24
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 14:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNApj-0001eS-LT; Wed, 13 May 2026 10:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wNApf-0001dp-Ik
 for qemu-devel@nongnu.org; Wed, 13 May 2026 10:45:10 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wNApc-0002d0-UC
 for qemu-devel@nongnu.org; Wed, 13 May 2026 10:45:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIRnerPmAc7hh2SmY3LYDf92/ZEaFVjgTL5/vyB+VWjsSV8BPVOCGy4diWf/BEcMilbFpR+ZX9vkvib7KM24ApycBP+O4DmpJjkSXqQMmhqhPhH9jCvSGZLQunYbwtKfN8XhTUGHMnqLUcMM9gCQd80BynvG1jZSm0MYd5z4y38iLAJthasI5+cabOU+CQ5ci8Dj5YtGxi3vGcPlQ3r1GRMXiXzKfMjIHqL+v479oVf/dJhYb/T0HhK0JbrhA8+ifDlfaJQKGHiKISveweTOZmcKE7WOXYHYNQoJXSzjCLN64u70osHg9jtAk120MHGbsU6gSc2ZbPrtVnCyw/y1ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shM7CcUaox4ZQevOiyG9b8OVzV2UpoJ4lEC44URowso=;
 b=o5jTtW/mq7+1FaBgx9+hLU950ECp/R0mHgf/S43JhKzRKixRqeuSpwwhtaCjpJtFokbJBsrrfNi4j3fpNq6kLEQRRnRoROQEGJlbkok370bkKnfK+LA6icSzG2/3YDfXHj3F3PIVhIfPnh89fWCV+l6+LrhE8WSLeSJIOqJJC0exYMXVJW40REIFznD9ql7Pg6eZGAOn+7Y/eSNjJIQsSqlw5rc4UD5MDcwdqJaHfgalBSpclq/cVoPZtOZNbpYTCKrweRXSOKJxa81C7WmFKL4Fm7cxUgRAmJsezQeOwcA0oqQIRTt7O9HGSgrUi9kYZD5UqlJzvnl7qlkXjXPHBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shM7CcUaox4ZQevOiyG9b8OVzV2UpoJ4lEC44URowso=;
 b=pBgM3ykGoumotPx1qoBylwloiHP2rYjRUDJRoQ6+d1i2LsxHp+gpF1HoWKjnqKZvgmygkvCBpaK6kW/Nhugm8bfIXtLl2knMrHShjQikXJ03d6pF5RXE9bkERD4R025wA6Vo2FOk6nvb6n2Far1cksyh55+rIVS3kKWGSAdUASM=
Received: from DS7PR03CA0288.namprd03.prod.outlook.com (2603:10b6:5:3ad::23)
 by SA1PR12MB9546.namprd12.prod.outlook.com (2603:10b6:806:459::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Wed, 13 May
 2026 14:44:55 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:3ad:cafe::fb) by DS7PR03CA0288.outlook.office365.com
 (2603:10b6:5:3ad::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 14:44:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:44:54 +0000
Received: from [10.252.204.230] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 09:44:50 -0500
Message-ID: <302e33d0-2d6d-48b0-9c6a-d7c965f6f824@amd.com>
Date: Wed, 13 May 2026 20:14:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <pbonzini@redhat.com>, <mst@redhat.com>,
 <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 1/1] amd_iommu: Update command buffer head ptr in MMIO
 region after wraparound
Content-Language: en-US
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
References: <20260512150044.334867-1-alejandro.j.jimenez@oracle.com>
 <ddab5f5d-4f5f-42d0-a08f-c3e20ca20f84@amd.com>
 <a9c620a8-ebdf-496f-b9a3-fea046294989@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <a9c620a8-ebdf-496f-b9a3-fea046294989@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|SA1PR12MB9546:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c6664ad-56f2-4197-1a55-08deb0fe326c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: qftqXYTf5WG45C/AFC/ZQ/Cw0/95sbTJUYZLD6cmeM13WAwCX1BJ3TunURUVm4Q7hIhQZnW1ZFnXtMc6Xn5sK3jVEcCF0DP6D+OiNj+0KgNlPH/wAsg5xfmHyzAs2ETsPDhm8y4f1OfIgc6w5lcW7lykQ+817uVOQD6xCbM9NCF6FTNmYi14zMF9+JoU+WxlGNAwcwkcvVlaFCP1wbaOo0gAqoTcxZlqhJj+ntmMIF728H+RzN2iClDVL5QjzNzrwWMZUdRb1MwDXPzjBYAOI2XfhmKtMjm9kyOylFlj2+EzM2E+IefAzIXEVHDruB+0zOpFRbisUMWggCfy9OlG0eC0bAfJWCk4u99j0aBjXaF0cYuySt6ciVSYoRzmj1QzJ6qzQdFc7vx2LOS03s+m3YzYzuiJNkeiISq6Hpn4EXJTUr4jRVTsRq3kAG1qgktSm2mGBhGFCdW74hvnP1Qj1Wvd/KhvZbN+FNBNcB5OSR21287oFUJ8+iW6M4c/zlDRmFADfYnnsPBsJtMz7Ef3FyPy+sK1MOBSHRiQ0B1a1z/GZ2XMRlJ0aI5aC8Eo3WnDFuN4NpALfkHYUSew0TNwEh9mIZ9GHLsZmIIX6f+gTXw1OUq21poB4SRC0Xv7bk3fYWjU3ZpIcLJVciJtNcDpWYp6boMTfiMGkSNQVaAsXP6ZzCQx9nbgHVmgNwRdzyiQQK4ALmTKphbYVvoZ2Se9DZSYjzI/DfP8vhHeQbObrkQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(11063799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5bmIRiihqwmYiA4704piBAikBhWpnn9zUdV6MQist9/AsQQkEcW2iX7mqOHhrG8ys5TOqQMd0b0Fm4cWSBX5RIt9Mi9zyhyaWDpLdTTeM4QD/HxP1uPfLWEFZUWRhwLJC1gGhTqyhPpDbURq+Fr2NKlEQdSsHpDtT+AQzvzLDc1c+LiM8bIDUOaTS6rJf/468qEyj4E6fQoooiUtzNDz1HgHpHwnvkPcl1BqCzsqZzyOZAPS23XqIIJN4VZyQZjE3GW/TmHNcbuOJsy2ucdLZdMWwDJFQ+Y+Yx2N6KvFPPhgQ9MYS3Uo8bWKZ24sP+9F9fFh9zLOpVD03UnnvqiRPo7mKbftgp8SvmRSZ/jI5UUErNTPSBoDeJOVvMxn28DhbeHtD+9oPbYgPfDAtwSu+NC8yvzLn/i8vHURdInAmupLrubLZKzy6BJrqvrhsgcL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:44:54.6902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6664ad-56f2-4197-1a55-08deb0fe326c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9546
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=Sairaj.K@amd.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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



On 5/13/2026 8:11 PM, Alejandro Jimenez wrote:
>
> On 5/13/26 12:38 AM, Sairaj Kodilkar wrote:
>>
>> On 5/12/2026 8:30 PM, Alejandro Jimenez wrote:
>>> When processing a command, amdvi_cmdbuf_run() increments cmdbuf_head and
>>> writes it to the emulated MMIO register space before checking whether it
>>> has reached the end of the command buffer.
>>>
>>> If the incremented value reaches the end of the buffer and the tail pointer
>>> is zero, the loop exits and the COMMAND_HEAD offset still contains an
>>> unwrapped value. There are no errors in command processing since internal
>>> cmdbuf_head state is always correctly updated, but the spec defines the
>>> CmdHeadPtr field in MMIO Offset 2000h Command Buffer Head Pointer Register
>>> as RW i.e. guest-visible, so it should be kept consistent.
>>>
>>> Wrap cmdbuf_head before updating COMMAND_HEAD so the MMIO-visible register
>>> always matches the internal command buffer head pointer position.
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>>> ---
>>>    hw/i386/amd_iommu.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>>> index 197e452e3c..5d6a405263 100644
>>> --- a/hw/i386/amd_iommu.c
>>> +++ b/hw/i386/amd_iommu.c
>>> @@ -1475,12 +1475,12 @@ static void amdvi_cmdbuf_run(AMDVIState *s)
>>>            trace_amdvi_command_exec(s->cmdbuf_head, s->cmdbuf_tail, s-
>>>> cmdbuf);
>>>            amdvi_cmdbuf_exec(s);
>>>            s->cmdbuf_head += AMDVI_COMMAND_SIZE;
>>> -        amdvi_writeq_raw(s, AMDVI_MMIO_COMMAND_HEAD, s->cmdbuf_head);
>>>              /* wrap head pointer */
>>>            if (s->cmdbuf_head >= s->cmdbuf_len * AMDVI_COMMAND_SIZE) {
>>>                s->cmdbuf_head = 0;
>>>            }
>>> +        amdvi_writeq_raw(s, AMDVI_MMIO_COMMAND_HEAD, s->cmdbuf_head);
>>>        }
>>>    }
>>>    
>> Hi Alejandro,
>>
>> Maybe we can clean it a little bit by using modulo operation
>> s->cmdbuf_head = (s->cmdbuf_head + AMDVI_COMMAND_SIZE) % s->cmdbuf_len *
>> AMDVI_COMMAND_SIZE;
> In short, I find the "if" code easier to understand.
>
> It keeps it readable and avoids a number of potential issues. e.g. the
> approach above using modulo is missing important parenthesis around the
> second block:
>
> s->cmdbuf_head = (s->cmdbuf_head + AMDVI_COMMAND_SIZE) %
> 		(s->cmdbuf_len * AMDVI_COMMAND_SIZE);
>
> even with that corrected, it could still break if changes in other code end
> up setting invalid values in cmdbuf_head and/or cmdbuf_len e.g. if
> cmdbuf_len is incorrectly set to 0 for some reason, then the modulo
> operation has 0 as an operand which is undefined IIUC.
>
> We could also use masking like Paolo's recent patch that inspired this change:
>
> s->cmdbuf_head = (s->cmdbuf_head + AMDVI_COMMAND_SIZE) &
> 		(s->cmdbuf_len * AMDVI_COMMAND_SIZE - 1);
>
> but I think similar issues as with the modulo apply.
>
> Out of curiosity I generated assembly for the two cases and for the "if" it
> uses:
>
> cmpq, cmovnb
>
> while for the modulo code it uses:
>
> divq
>
> So I think division might actually be slower than the compare and
> conditional move.
>
> Alejandro
>
> This will eliminate the if condition. Thanks Sairaj
>

Hi Alejandro,
Thanks for explaining it in details.

Reviewed-by: Sairaj Kodilkar <sarunkod@amd.com>

>>> base-commit: 8333dba7326d89ce180221c4d0c6d34826a9a4a3
>>> prerequisite-patch-id: df656299f90e928acad39d99e3701c5641e972d5


