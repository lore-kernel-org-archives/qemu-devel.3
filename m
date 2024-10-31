Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4ACE68944
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 08:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6QOF-0001Mc-K8; Thu, 31 Oct 2024 04:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lei.Huang@amd.com>) id 1t6QOD-0001ML-Kd
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 04:18:45 -0400
Received: from mail-bn8nam12on2070.outbound.protection.outlook.com
 ([40.107.237.70] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lei.Huang@amd.com>) id 1t6QOB-0006do-3U
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 04:18:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUeiFVQzSt70zl4cAlLS9o3bXTBR1oHMvdV5TP8fuRBbGSMBKlCZFUbklk3Byvlqnepqg1AYW4luHqSXaQC+y3wQW37aAbg9/T7jpyuI5euqEUfBjdT5WLo9mXzg7wFMmKOGeCnYCyWl/GPIATgN4BUzOxFa8jO/vBC/UY8cB6sM5DPAbX7Cjw+Rr6COUHiLzwYJSCGVXnLOehdtU6JngrMpjBEFr96PuIdRnhBsZKqeftTnDypXeD6JkBPrcNWZnZoA94KMHUJynhEBZXHgzxMrsX9PdMifbircvvtQfLDOr7f4XOnB0ThO1prj+LpG/bGENAnlyaDqY8f6nC0Ziw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INA57DyoX+B3O9EGjvZs1KeYBxULHGSRoJTw88BAAkk=;
 b=qsYeiGD+J4uODc45sbV2Quvku5uKzFI+WrHUf5Th1YP9TU4cOcZZ2OyuBYZqORX/oa0urUpWx6PQwQ57gVrVgn9jC8SztE/ZB0SdPnhDSALvJkuc4/qOcKSh/9kEDRMMnRBV5PoDdO/SXidCi2bOkQQdJOui3TCrXNWXg2QNFxD02cWq2qeNRkiV7ZkJVecKP89BVFcGvF/C8dA9+PNRnWIux+7tWwC94RAGD3/mmui1qxVGhY9YEBKrcqclEveGzmj8959BKLwZZhH8kDKR/+9Vcgwra3HdJIjChRhmlnToxqmtOpQAnTtt+A3I0oN0Wg/VTJWuilDXWZ035eoFMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=eik.bme.hu smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INA57DyoX+B3O9EGjvZs1KeYBxULHGSRoJTw88BAAkk=;
 b=Btx9Q7/xpGIt5Ih4b3O5PSYKtqwbjHohufw2THdpLPdur7nxIhOTw4Tadq1JoauByYa3Y+EBEV50UbbfPaZtVqTT5cZ8bgncFJZd0dxMA1aILqu8ejW/xQ3gdm9M7PGR5kFlNjgm5maoqWjrkXsd4ltBEIalCqtINR6YeJ7R7uM=
Received: from SJ0PR13CA0029.namprd13.prod.outlook.com (2603:10b6:a03:2c0::34)
 by PH7PR12MB6978.namprd12.prod.outlook.com (2603:10b6:510:1b8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 08:13:33 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::9c) by SJ0PR13CA0029.outlook.office365.com
 (2603:10b6:a03:2c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Thu, 31 Oct 2024 08:13:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 08:13:32 +0000
Received: from SHA-L-LEIHUANG.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 03:13:29 -0500
From: Lei Huang <Lei.Huang@amd.com>
To: <balaton@eik.bme.hu>
CC: <marcandre.lureau@redhat.com>, <qemu-devel@nongnu.org>,
 <pierre-eric.pelloux-prayer@amd.com>, <ken.xue@amd.com>, <Lei.Huang@amd.com>, 
 <hsp.cat7@gmail.com>
Subject: Re: [PATCH v2] ui/sdl: Mouse event optimization
Date: Thu, 31 Oct 2024 16:13:13 +0800
Message-ID: <20241031081313.1617-1-Lei.Huang@amd.com>
X-Mailer: git-send-email 2.44.0.windows.1
In-Reply-To: <73cd533a-8818-4212-f7ea-0f89bd2b78cd@eik.bme.hu>
References: <73cd533a-8818-4212-f7ea-0f89bd2b78cd@eik.bme.hu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|PH7PR12MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b820b9f-d539-4599-bd8d-08dcf983e949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EFgfw7e36Ns7Jx7AxTHAtAHQgr/ZHRLuLa+2xINOiD6sRfESrTlLKoRgvrAa?=
 =?us-ascii?Q?LsclvLGxr5tBYvTbMkieP4Z5AytBuZ8mFo7lXTtUzdYOOi2P2gtW1zpKvPE9?=
 =?us-ascii?Q?pkQTkHIX9lL3CS4Q+93+RhetJLSOZg8pIQV45X1KamXVSpGR8YsPobLcIJ5O?=
 =?us-ascii?Q?jYFst1XmRRXuIxPd1EpWFB5kylNvNmHr1CZZosND6xdRF34keFfBMgdmsvob?=
 =?us-ascii?Q?A8Gm9WAxokmGMKnemrrNEp2+Vlx6WBpHxrP6eJKrInzn8Hlp++T3DgFt9lEa?=
 =?us-ascii?Q?YuNnRLwvd+ynPeJ7w7CD+UvlcKNwC8YpRfFxSFcf0fkt/b9mIGzo/09crQ70?=
 =?us-ascii?Q?nhuHR3jLwS7dBqB21jGmCp/ihdgz1nXZOM+GNjkxqDdD6SthxyADJ5U01Qi6?=
 =?us-ascii?Q?S2qiHwYC01Ep2ivEj+K6dToj0v5QQLmTYNP9mg7OBXo+HuxXoyBFiQBRdYSw?=
 =?us-ascii?Q?1H+kPkdMyWVSZcZMZ3YUhavn6nTDIkLbmjtR76MnFgFqrNiG+BhqPweQ248g?=
 =?us-ascii?Q?sMCmuBpsZX5NTIKo/+l/V3RK4dcqk79IymZjggA+LY99UOvOiRDlgMUi4adq?=
 =?us-ascii?Q?2UCOimj8UY2G1uXzyARHPBzzTwFee0VlGRdhlJ7yGJNL16Mk9iMB8P6+y4J3?=
 =?us-ascii?Q?z3z4ht/W+ztaQ62o0Ma/FdFlwIcGkql1Gv8N5I4YczwuIzNnlPwLhgGDlNuM?=
 =?us-ascii?Q?yyKCjmg2Zk8xOwm8uJR8dZf/3v2tZpoKNC1Dl0aEyWM/uvM4cywhJKjAK/iO?=
 =?us-ascii?Q?pCbsHexKvfl/4lLOW+F2reTcE8qKyj+f2eVLOuAYEBHgMf+FzGT1AoERnyb6?=
 =?us-ascii?Q?848GMgtLn/gx6I7+nbt8ArBv35bccGxoQNSqPz7o8/Xi0j15L0E59//rgmDW?=
 =?us-ascii?Q?b748/s7kvVXbNb1dSgYqrkhKXbzgQOqGUuabd/g7z7XlQnNImTksAKlcV7aq?=
 =?us-ascii?Q?eV5XRncCCQdlPn/WJV2H7i9ZpyMx5gFklM9tGjVdvy9Idc1wLlj4S4WH0bi3?=
 =?us-ascii?Q?ee6EDikr6exo2kJXGP3wLNPsKHBSFIZbtl7p339BlA/vBhbo2ZYDZNoTgCqH?=
 =?us-ascii?Q?KhA3X2RNocM4K96bPdZdflyCg/nnLyOJdsz7KPYC+CtN5Pptj85q78jsE4Zg?=
 =?us-ascii?Q?UMGnYAO2C4+5xjDoKD3kO14kfmhIJIcbE8bJvMfNaUZlHEAyyp1a0Vkjlo7w?=
 =?us-ascii?Q?ApJ5/NiZR/V8EagpLy6X4qJ0R/51VKPO8vqvQtOIzhYIu8017z563GwpRaV9?=
 =?us-ascii?Q?N6OFc0kuSnVPTG4wBcDXcPr5gBKtWBZrP9aru7RRDXL1lDPEukVRzKY7hD2p?=
 =?us-ascii?Q?wunzW+8FBqPWFM3gaVjhDi6NRY0Xv160+K59/9HL0zEZ6aaxX8gt4a6SfF3g?=
 =?us-ascii?Q?+q0l4pNTqQKRjTbHvXtBDIMubTBdDdI4KjCGYqExT52BaJmb4A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 08:13:32.8161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b820b9f-d539-4599-bd8d-08dcf983e949
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6978
Received-SPF: permerror client-ip=40.107.237.70;
 envelope-from=Lei.Huang@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

>On Wed, 30 Oct 2024, Lei Huang wrote:
>> Use a convergence factor to make the VM's input
>> global coordinates more closely approach the global
>> coordinates of host.
>>
>> Change-Id: I2c3f12f1fe7dfb9306d1fc40c4fd4d299937f4c6
>> Signed-off-by: Lei Huang <Lei.Huang@amd.com>
>> ---
>> ui/sdl2.c | 32 ++++++++++++++++++++++++++++++--
>> 1 file changed, 30 insertions(+), 2 deletions(-)
>>
>> diff --git a/ui/sdl2.c b/ui/sdl2.c
>> index bd4f5a9da14..ea3fd74dd63 100644
>> --- a/ui/sdl2.c
>> +++ b/ui/sdl2.c
>> @@ -303,6 +303,34 @@ static void sdl_mouse_mode_change(Notifier *notify, void *data)
>>     }
>> }
>>
>> +/*
>> + * guest_x and guest_y represent the global coordinates on the VM side,
>> + * while x and y represent the global coordinates on the host side.
>> + * The goal of this entire process is to align the global coordinates of
>> + * the VM with those of host using dx and dy. The current approach aims
>> + * for precise calibration in once attempt; however, because guest_x
>
>There's still another one here. You can say "in one attempt" or "at once" 
>but combining the two is not correct.

Oh, okay, got it

>
>> + * and guest_y are non-zero values, they are not accurate values when
>> + * they are counted out to become negative. Therefore, achieving perfect
>> + * alignment in one attempt is impossible. Since the same calibration method
>> + * is used each time, repeated attempts cannot achieve alignment either.
>> + * By introducing a convergence factor, guest_x and guest_y can be made to
>> + * approach host x and y indefinitely.
>> + *
>> + *                   QEMU                       (dx,dy)  VM
>> + * calculates dx and dy using guest_x and guest_y ---->  input driver
>> + *            ^                                            |
>> + *            |                                            |
>> + *            |                                            V
>> + *            |     update
>> + *            | guest_x,guest_y              input dispatcher ---> WindowManager
>> + *            |                                            |                 |
>> + *            |                                            |                 |
>> + *            |                 libdrm                     V                 |
>> + *    display device  <------ drmModeMoveCursor <------ compositor <-------  |
>> + *                            (guest_x,guest_y)   calculates guest_x and
>> + *                                                guest_y dy using dx and dy
>
>Maybe adding (e.g. virtio-gpu) below display device would make it clearer. 
>Also under compositor there's "guest_y dy" where the dy seems to be left 
>there by mistake from some editing or I don't get this sentence. (Did 
>checkpatch.pl complain about too long lines? Maybe you could shorten the 
>arrows a bit and wrap the text under QEMU in two lines to try to fit in 80 
>chars.)

okay, thanks, got it

>
>Sorry that I can only comment on the comments and not the actual change 
>but I've cc'd Howard who I think saw this issue before so may be able to 
>give it a test.
>
>> + */
>> +#define CONVERGENCE_FACTOR 3
>> static void sdl_send_mouse_event(struct sdl2_console *scon, int dx, int dy,
>>                                  int x, int y, int state)
>> {
>> @@ -331,8 +359,8 @@ static void sdl_send_mouse_event(struct sdl2_console *scon, int dx, int dy,
>>             y -= guest_y;
>>             guest_x += x;
>>             guest_y += y;
>> -            dx = x;
>> -            dy = y;
>> +            dx = x / CONVERGENCE_FACTOR;
>> +            dy = y / CONVERGENCE_FACTOR;
>
>Looking at this calculation I don't quite get what's intended here and I 
>think this could be simplified. Originally in 47c03744b37 it seems the 
>qemu_input_queue_rel() was called with the modified value of x and y but 
>then afbc0dd6498 have introduced dx, dy. After that changing x and y seems 
>unnecessary as they are locals never used after this calculation. If I try 
>to expand these equations I get:
>
>x = x - guest_x;
>guest_x = guest_x + x - guest_x;
>
>So isn't this equivalent to just:
>
>dx = x - guest_x;
>guest_x = x;
>
>which seems to make more sense but I don't know if it's correct.

yes, it is correct.

>
>Then this patch takes the third of dx to avoid it overshooting the desired 
>value. The question is what causes this overshoot and can we calculate the 
>actual value of it to compensate for it in one calculation? Isn't it the 
>other line that sets guest_x to x that needs some correction?

It's not the reason of guest_x += x;. I previously tried removing guest_x += x;
and only letting sdl_mouse_warp update guest_x, but the issue still persists.

The behavior of different virtual machines varies. In the Ubuntu VM, the cursor
jitters violently within a small range; for example, when moving a folder, it rapidly
flickers back and forth. On Android 14, it can barely be used, though individual coordinates
may deviate significantly, but they can be quickly corrected. However, on Android 15, it is
completely unusable. The reason for the issue in Android 15 is that the initial global
coordinates of Android are random values, not (0, 0). During the second calibration,
it is possible to calculate negative values, which are forced to be set to 0, resulting in
a continuous loop. The occurrence of negative values is an extreme situation.

>
>Regards,
>BALATON Zoltan
>
>>         }
>>         qemu_input_queue_rel(scon->dcl.con, INPUT_AXIS_X, dx);
>>         qemu_input_queue_rel(scon->dcl.con, INPUT_AXIS_Y, dy);
>>



