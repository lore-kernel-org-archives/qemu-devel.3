Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43D5E67492
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 01:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6gQ2-0000t0-RZ; Thu, 31 Oct 2024 21:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lei.Huang@amd.com>) id 1t6gQ2-0000sk-4h
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 21:25:42 -0400
Received: from mail-bn1nam02on2061e.outbound.protection.outlook.com
 ([2a01:111:f403:2407::61e]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lei.Huang@amd.com>) id 1t6gPv-0007Xp-AL
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 21:25:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kif4rO1tGJVLk3BQ3TaGVp7MR7lnMR6ydeGwyAIevjZkE/sb7Ym/8/e8K5FsH3eVKK5m6vtzFCdKTRwf+/A4EO9g7zgWwISBqt/mB54/1D+XANpkpqCO681QnbLJV2ysCnalRVsCc+ziQlHIVtdX5h2NmhJ2sj/o1SutliFXMNcOLb6XsXiG8EQn5B8LzKa3u1k1k4TP3CSOTVjGu9TCRDKhx3IPIglcfIZGh5R8usoVXq44Y6ql7q86Cda/OtncWJXh0ozuX+Ai7mH0cpieTLLrBk0PIeM5DyrtJ2CWrfMC5Wo78InrzZhxt2vhn9NA4Nq8dvtupSIYOp2IJqgv2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ve0soNYV6LVQfs1Q6NVZGMjdQh3ZzUFERt8M4//szLY=;
 b=THAsSQ3JuhTyKsoEBn83wRd5sBzYFSQJ3ig/VpZVTSVK44qgnLlV3ekCsegjwcrJpMaqisrH6GUNhJobE/xXQ/slN3erpz51Hv33FYeWGA/EcvQLoMXpHpHMkFGHH/oc/5aTwckRGPfabPgupRAVENeCmIVsQzsKblCQg7MNB4trGGwFJWV7ey2vDL2I9LPzBSC97/9JYjOHAQ5LkOHXEZt7qOzBiv+J/20yjAd5CcnhM1aA+/oUX+jg3KDu1p2ldr49n1fkLeVUhABe35850ufzkw9enywydn7axLFtLvTY4AG3ymR66FinPTlxlHHzNCuW9bgrGrLQ1iVGEYjb5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=eik.bme.hu smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ve0soNYV6LVQfs1Q6NVZGMjdQh3ZzUFERt8M4//szLY=;
 b=iG7+LpOISOvBz8yknvxz0ABdSG1UsYVLZ7klhmsw4yRCe3+olN0VZACGkTKANdaiQWH6UCtFjCmgM8ebzeln55UJFgQ/6HR81glvmymtYBsqJ89JMhCgoDOZkEQHnbSuh9j8aMvUlPpj8oJ3KgQEcPDbCmMEZp2hVgbapBE5p1Q=
Received: from PH7P220CA0065.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::22)
 by SJ2PR12MB8033.namprd12.prod.outlook.com (2603:10b6:a03:4c7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 1 Nov
 2024 01:25:26 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:32c:cafe::e3) by PH7P220CA0065.outlook.office365.com
 (2603:10b6:510:32c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Fri, 1 Nov 2024 01:25:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 01:25:25 +0000
Received: from SHA-L-LEIHUANG.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 20:25:18 -0500
From: Lei Huang <Lei.Huang@amd.com>
To: <balaton@eik.bme.hu>
CC: <marcandre.lureau@redhat.com>, <qemu-devel@nongnu.org>,
 <pierre-eric.pelloux-prayer@amd.com>, <ken.xue@amd.com>, <Lei.Huang@amd.com>, 
 <hsp.cat7@gmail.com>
Subject: Re: [PATCH v2] ui/sdl: Mouse event optimization
Date: Fri, 1 Nov 2024 09:24:58 +0800
Message-ID: <20241101012458.1651-1-Lei.Huang@amd.com>
X-Mailer: git-send-email 2.44.0.windows.1
In-Reply-To: <75f12789-98a9-0b49-9629-4f722448b3c3@eik.bme.hu>
References: <75f12789-98a9-0b49-9629-4f722448b3c3@eik.bme.hu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|SJ2PR12MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ac6bab8-12f3-4b97-fe37-08dcfa141045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ptfyzuF4FgANej3NQ+qm9lIA0VAaVTdLRiSZxDNXGFxI24hVnyeJFBNtEmiW?=
 =?us-ascii?Q?/SbsHTfKuSw6GsUw2v4apisWnMxdCK7imRqyBCpgeQ/AiNUFld1AmkyR+Wlr?=
 =?us-ascii?Q?n+zK0h18hxej49sDoTNK9ma1M5KVpnry6ZELZBm9BJqGfApwFQVPC2gAyzf6?=
 =?us-ascii?Q?Pfuk7i3Ux4qK9VyycAYbeEysM2q1DoJi9ChN1nICwVK3YFuy42gms56LMUJP?=
 =?us-ascii?Q?dW68WFUgRXejLA0nie7WFwTvOWbce5QAN3FbMQKTmBSh5TcuK8uZZA1/Vbyy?=
 =?us-ascii?Q?FiI8rr6P9jULbQ+hHDSvw3di2LxU3BxZT/ghBii3xJ8beLZF8LI2Xlzmic+Z?=
 =?us-ascii?Q?OoV3NuYyYKAA52Ml7JoAWd7zVmRhEW0tPQ7ycHrRmvD8hKwRu5ULYpFGYTnW?=
 =?us-ascii?Q?/0SVwbEuJHRBb4dfy5d8l2bkRoc4t6nPRh9CUfyKjFJ3ccib4NxqeHd2KBvm?=
 =?us-ascii?Q?lAS9lTR2gYqWNXvZiQ7em3fYanW+ss5z1vozsidiNojJkeedG/nYgun0yoa8?=
 =?us-ascii?Q?X3WfUpN3gBUvn4vdwRJXRVbAihmak7pMbQS2Zb4YqLnFpE+YbQgTYD3Jek6+?=
 =?us-ascii?Q?8VKL3J+2eSo8/VEXivIu7TIjQJdaaCw/N19JlQ93xheA/UWo6Szp1b//3v+d?=
 =?us-ascii?Q?W8shxr3ZYY5v0/LrkbrNRmtNg+9l5v9dDSAl2LQ218k3DVCQN0kEfuiphQ1V?=
 =?us-ascii?Q?rOO6bwyXu7zQrKPhJAvNF4WUJ1+uefDcxJzzGipa7neuy1/LMI49gfRe1f1k?=
 =?us-ascii?Q?QZFIkIPOjQTvXP4jr/TgVKu4eu2WqtdUYiJ+Y7Gt6lB1wDC9P0oZoU6IXR8L?=
 =?us-ascii?Q?5pxJr/hSNGK75aEqlddyXX+aBv9o4WkeYojk292DVkmRTQh/CWYo+wFtCn/e?=
 =?us-ascii?Q?yaT6n0kErtmGlG/XS+50riaj2vNmeoJnRE+CcuNcacOelElsl9jIkDKQjw6H?=
 =?us-ascii?Q?SkeQTCZ9/v3+11Os3Wish4IbPelJ2zGymI1+C7cYLgfuIIbTWEnUZGoMpp1l?=
 =?us-ascii?Q?LDdXGKWaZHFirGAJT7rnvjLvBtziVN+EtNro0Tht6ZB8hsI0RiUPrWKY8xBn?=
 =?us-ascii?Q?LoS4iN/VXr/7E6AXU/F34gqJ1t/wT/lwzpW6nUc+Fj+TLXyAOdYjrkGJloFY?=
 =?us-ascii?Q?67wV2NQqxkY9p14p6Nqfc04dH+RZMvV+P0INyV18hQIS0J0BdtBwJGw2c8Ip?=
 =?us-ascii?Q?Ug4N2z2uUC/Q/yLmVkKtYF3Wf29wbkpOa817EkmeGcXTuaQ6TSC8u5G2Ref0?=
 =?us-ascii?Q?LITJKANY8WyXsFCeHYZaNpWs0R/99MrAg4N4/PsUtWM+m6J5g+/7BNIv+eTm?=
 =?us-ascii?Q?Wrqaci3I67vv8WuYT6Cg6nFUobDqMF75a2vxNwsG26WtkSqOYyyU7lr4mMM8?=
 =?us-ascii?Q?KEkYyWXXFN2YxtIgCd+aXl1tcT6ky7ogdeKNKC2SbZn1/h4dgg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 01:25:25.7361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac6bab8-12f3-4b97-fe37-08dcfa141045
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8033
Received-SPF: permerror client-ip=2a01:111:f403:2407::61e;
 envelope-from=Lei.Huang@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
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

>On Thu, 31 Oct 2024, Lei Huang wrote:
>>> On Wed, 30 Oct 2024, Lei Huang wrote:
>>>> Use a convergence factor to make the VM's input
>>>> global coordinates more closely approach the global
>>>> coordinates of host.
>>>>
>>>> Change-Id: I2c3f12f1fe7dfb9306d1fc40c4fd4d299937f4c6
>>>> Signed-off-by: Lei Huang <Lei.Huang@amd.com>
>>>> ---
>>>> ui/sdl2.c | 32 ++++++++++++++++++++++++++++++--
>>>> 1 file changed, 30 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/ui/sdl2.c b/ui/sdl2.c
>>>> index bd4f5a9da14..ea3fd74dd63 100644
>>>> --- a/ui/sdl2.c
>>>> +++ b/ui/sdl2.c
>>>> @@ -303,6 +303,34 @@ static void sdl_mouse_mode_change(Notifier *notify, void *data)
>>>>     }
>>>> }
>>>>
>>>> +/*
>>>> + * guest_x and guest_y represent the global coordinates on the VM side,
>>>> + * while x and y represent the global coordinates on the host side.
>>>> + * The goal of this entire process is to align the global coordinates of
>>>> + * the VM with those of host using dx and dy. The current approach aims
>>>> + * for precise calibration in once attempt; however, because guest_x
>>>
>>> There's still another one here. You can say "in one attempt" or "at once"
>>> but combining the two is not correct.
>>
>> Oh, okay, got it
>>
>>>
>>>> + * and guest_y are non-zero values, they are not accurate values when
>>>> + * they are counted out to become negative. Therefore, achieving perfect
>>>> + * alignment in one attempt is impossible. Since the same calibration method
>>>> + * is used each time, repeated attempts cannot achieve alignment either.
>>>> + * By introducing a convergence factor, guest_x and guest_y can be made to
>>>> + * approach host x and y indefinitely.
>>>> + *
>>>> + *                   QEMU                       (dx,dy)  VM
>>>> + * calculates dx and dy using guest_x and guest_y ---->  input driver
>>>> + *            ^                                            |
>>>> + *            |                                            |
>>>> + *            |                                            V
>>>> + *            |     update
>>>> + *            | guest_x,guest_y              input dispatcher ---> WindowManager
>>>> + *            |                                            |                 |
>>>> + *            |                                            |                 |
>>>> + *            |                 libdrm                     V                 |
>>>> + *    display device  <------ drmModeMoveCursor <------ compositor <-------  |
>>>> + *                            (guest_x,guest_y)   calculates guest_x and
>>>> + *                                                guest_y dy using dx and dy
>>>
>>> Maybe adding (e.g. virtio-gpu) below display device would make it clearer.
>>> Also under compositor there's "guest_y dy" where the dy seems to be left
>>> there by mistake from some editing or I don't get this sentence. (Did
>>> checkpatch.pl complain about too long lines? Maybe you could shorten the
>>> arrows a bit and wrap the text under QEMU in two lines to try to fit in 80
>>> chars.)
>>
>> okay, thanks, got it
>>
>>>
>>> Sorry that I can only comment on the comments and not the actual change
>>> but I've cc'd Howard who I think saw this issue before so may be able to
>>> give it a test.
>>>
>>>> + */
>>>> +#define CONVERGENCE_FACTOR 3
>>>> static void sdl_send_mouse_event(struct sdl2_console *scon, int dx, int dy,
>>>>                                  int x, int y, int state)
>>>> {
>>>> @@ -331,8 +359,8 @@ static void sdl_send_mouse_event(struct sdl2_console *scon, int dx, int dy,
>>>>             y -= guest_y;
>>>>             guest_x += x;
>>>>             guest_y += y;
>>>> -            dx = x;
>>>> -            dy = y;
>>>> +            dx = x / CONVERGENCE_FACTOR;
>>>> +            dy = y / CONVERGENCE_FACTOR;
>>>
>>> Looking at this calculation I don't quite get what's intended here and I
>>> think this could be simplified. Originally in 47c03744b37 it seems the
>>> qemu_input_queue_rel() was called with the modified value of x and y but
>>> then afbc0dd6498 have introduced dx, dy. After that changing x and y seems
>>> unnecessary as they are locals never used after this calculation. If I try
>>> to expand these equations I get:
>>>
>>> x = x - guest_x;
>>> guest_x = guest_x + x - guest_x;
>>>
>>> So isn't this equivalent to just:
>>>
>>> dx = x - guest_x;
>>> guest_x = x;
>>>
>>> which seems to make more sense but I don't know if it's correct.
>>
>> yes, it is correct.
>
>Then maybe it's a good opportunity to simplify this now.
>
>>> Then this patch takes the third of dx to avoid it overshooting the desired
>>> value. The question is what causes this overshoot and can we calculate the
>>> actual value of it to compensate for it in one calculation? Isn't it the
>>> other line that sets guest_x to x that needs some correction?
>>
>> It's not the reason of guest_x += x;. I previously tried removing guest_x += x;
>> and only letting sdl_mouse_warp update guest_x, but the issue still persists.
>>
>> The behavior of different virtual machines varies. In the Ubuntu VM, the cursor
>> jitters violently within a small range; for example, when moving a folder, it rapidly
>> flickers back and forth. On Android 14, it can barely be used, though individual coordinates
>> may deviate significantly, but they can be quickly corrected. However, on Android 15, it is
>> completely unusable. The reason for the issue in Android 15 is that the initial global
>> coordinates of Android are random values, not (0, 0). During the second calibration,
>> it is possible to calculate negative values, which are forced to be set to 0, resulting in
>> a continuous loop. The occurrence of negative values is an extreme situation.
>
>I still don't understand the reason for this behaviour. I thought it's 
>probably caused by different pointer acceleration settings on the host and 
>guest so a move by some value moves the host and guest pointer by 
>different amounts. QEMU could get the host settings but knows nothing 
>about the guest so this probably can't be fixed other than trying to 
>converge the values. The question is why 3 is a good value for 
>CONVERGENCE_FACTOR and is there a better value or can it be calculated 
>somehow. But if we don't know and this fixes the issue it's likely good 
>enough, I'm just trying to understand the issue better.

This is partly because mouse events are reported whenever there is a change,
but feedback occurs every 16ms. If the VM refreshes at 60Hz, the reason for the
value of 3 is that a larger value will make the VM appear smoother, but it will
ultimately lead to a 3-pixel input event discrepancy between the VM and the host.
Therefore, considering all these factors, the value of 3 is chosen.

Under normal circumstances, dx and dy should vary within 20 pixels because these
are relative coordinates, and the mouse cannot move too far. However, due to issues
with the coordinates reported by the VM, the calculated dx and dy can change by hundreds
of pixels. Such large fluctuations are more likely to trigger the extreme situations
mentioned earlier, leading to a vicious cycle.

>
>Regards,
>BALATON Zoltan



