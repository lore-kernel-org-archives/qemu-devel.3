Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E29D74954
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 03:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5zIL-0001Ol-1o; Tue, 29 Oct 2024 23:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lei.Huang@amd.com>) id 1t5zIE-0001O5-MH
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 23:22:47 -0400
Received: from mail-mw2nam10on2060d.outbound.protection.outlook.com
 ([2a01:111:f403:2412::60d]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lei.Huang@amd.com>) id 1t5zIC-000293-3d
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 23:22:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFCI32OGw3UQTlFtFXqbWCnte4iBsF3d2SZVvCdP2xq7MVkCowuRidK4DqijkFYqy2BcdA2u1/3+llACevmPrNHspA46oNna3GPyMtDFdq7ImbOyepSxLf3+OQ8/W9eP/HUDfEfDScZGC2OQk9T1r+DaHhC5KLYADtEWE7bzR19E7EL+w9BAZ0MOMUYjVhxDlAx++Ffd0qBhVjHswhqrjWfZtyLG8LU9lcLmgfGDsWcWUy02KYmi7NU6uWHfLhNSGv0BmpNT1p/uTjyVQ9BuFt/XQnMLcGqSucynY8Fec+7E9f0zrrJIZQtLaWjtclifqjrVrn4wBZhhN26f3UP4ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIcngQKrUsgKbtlO3pIrBY8ksNgSgQyZK+dAv3cRUCs=;
 b=Xru1KFZ9+puGpzTkmmdNknDj2KdXM4uWJbC1ZsUo25wIoWC26BejnKgzE17JZmghkEr1zHc7muhiso3VnlFjxXd+h2yb8HXH1HsLwTeaqp14zbOWo1Ouhx+tnh6Cz7ce00Vn+hyrQLFG+hNnNCIfYOg70oRT6LIZloD/UR6oIsUOqksXwEUC+uLxeDB4xNh4uWaXpgpuJ5G1BAF2hcQOpFmIHBQEJgvs6JMfYOTkRQInmLse7uNrlykEi/73PmEEGrxVGFmpL5j0CI7t8AMtdqFcBz0R5S0cfUEg3SDRn3bpTmpjjqatCtOo6soUOz0oFg5N/HHL+qfdbe48VEwjaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=eik.bme.hu
 smtp.mailfrom=amd.com; 
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIcngQKrUsgKbtlO3pIrBY8ksNgSgQyZK+dAv3cRUCs=;
 b=yjCg0z35ovf4U9gFJJOXTkeqRwVAjmbTmdwPS3MY76hIxEGZNSeUfZPw0vCgcLeGRXBxCRa0bMs3T/peJqG/qxNhZ4ksNHOUQLGqlWVX1Jw/MNKB6uVplTA843sR+9muoROMKZKx99lIACbzWuB0UY4hXRZ0WrHX8kKUicRHk4g=
Received: from SJ0PR03CA0205.namprd03.prod.outlook.com (2603:10b6:a03:2ef::30)
 by CH2PR12MB4213.namprd12.prod.outlook.com (2603:10b6:610:a4::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 03:22:32 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::ac) by SJ0PR03CA0205.outlook.office365.com
 (2603:10b6:a03:2ef::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Wed, 30 Oct 2024 03:22:32 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 03:22:31 +0000
Received: from SHA-L-LEIHUANG.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 22:21:19 -0500
From: Lei Huang <Lei.Huang@amd.com>
To: <balaton@eik.bme.hu>
CC: <marcandre.lureau@redhat.com>, <qemu-devel@nongnu.org>,
 <pierre-eric.pelloux-prayer@amd.com>, <ken.xue@amd.com>, <Lei.Huang@amd.com>
Subject: Re: [PATCH] ui/sdl: Mouse event optimization
Date: Wed, 30 Oct 2024 11:20:14 +0800
Message-ID: <20241030032014.1564-1-Lei.Huang@amd.com>
X-Mailer: git-send-email 2.44.0.windows.1
In-Reply-To: <16018ab3-253d-8971-2627-6abdb1cd178a@eik.bme.hu>
References: <16018ab3-253d-8971-2627-6abdb1cd178a@eik.bme.hu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|CH2PR12MB4213:EE_
X-MS-Office365-Filtering-Correlation-Id: f13c7774-fa0c-485f-32b6-08dcf89216fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?snAZvorFJwwW4N6aBxTJ98PM0xMlY3ohrN1QKAEFxQrgf7waB3ms6t4iuCoG?=
 =?us-ascii?Q?YAsTOYfgGi4qEU+bIxHBKP0e6CXjitBkd1BDvsHRmY3nbSnxWQ1HVMKb8UJQ?=
 =?us-ascii?Q?lRBKmc5ean9HFLI16l0t3kNy/hJ4dXsTuufEAOZ1aFEghKkPopua3e6rpadw?=
 =?us-ascii?Q?0vgwE9vYhG2vsQNJSXqZhCpigwGeXqn6IsxaB9EbBLrKEBcH2zHdNne6N6yB?=
 =?us-ascii?Q?aRousbcYwx+ROy7zvFOvLIIatrfvxMsv0O16QxIIMGopTHu701DRtmBq1eCC?=
 =?us-ascii?Q?Uio3G9P0me4awmeqLxmWgvo9aqcp/7Vw5x+55AOfVKTKbfsixIWYBDBxMAb/?=
 =?us-ascii?Q?ZUmTLBV3waZ4VpftRJ45ZNs7UeMqQYwdtd0eJgl2ZEujXVW3uzFZ8gNeCBkY?=
 =?us-ascii?Q?eC1gQLHcuBqLEg+8/Txa8BqevX5RuJrWHuF/F03cufhwdiXhokII6EMLMfmA?=
 =?us-ascii?Q?Ak1gNQgAbWnSpCDLn3zAtzcoIHVXN3rvMg8rTS3f6eiukZivP4Xpf9vLb5lb?=
 =?us-ascii?Q?slz/lg2IkdOKDBBZwamtNpzv/Cu+jTeCSCoOWDPdgUaJp1PglTI7v5ceApMf?=
 =?us-ascii?Q?SMxBgnLJDrlL5zDj2vBtm01SJCFwXsmzi7qto/sWmah0qiR0B86ddeV0ZTve?=
 =?us-ascii?Q?8nvWpc9+yknREZzIumwVMhGDmQhqyo52uwrzwB2ee7URK+ak9my3B2mwQwLf?=
 =?us-ascii?Q?lZMLNcXgyum5CH+ag5LYQeyHXzoVrMsqRcQGGgBzEDK9hT/6pAVRZiR5R3a1?=
 =?us-ascii?Q?mcdieAdNv85gzoilFl6h8+3XxhPJ2Kafkl1HOG1TqXBMKf+5lwhp+RaETb2q?=
 =?us-ascii?Q?Qx+J0XkuJ6ZyuhtCl/mqYRpN6HIPxW6ywtYdwVdXqObvQeM5e94gBrywl7mo?=
 =?us-ascii?Q?9Soji2PRM2ifW5ESC0wj30ufVS8JGsfGp77XeFF9P9sVTfJbAZGqv/TTmVUK?=
 =?us-ascii?Q?rUdXhMUXTE28F9Vg4PTbcrdNFSe8oa9rgJU7dyj2ioOHBTj/8gFvVejFtYfb?=
 =?us-ascii?Q?mPSppd/UfaeEnllCMKNRJRyUXKzM8FcL/Py95kNuipcPXtB/CGSD1CekibR5?=
 =?us-ascii?Q?W6v62vVsKUdpiFSWBpmKre2THdoLICSUulBt2IxHTYAFAShOJXGh87GV075/?=
 =?us-ascii?Q?oTb1BWFm7SOu7PgOXL+ugSwDqNNY9AjxFq9kTEJp5fB7y+YOZB+drdrZt8fr?=
 =?us-ascii?Q?e0mM4QKK7XPlmbb70G7TVFocFdmoo6QEJrnYeoRry6YBD8d72G0JSPjpDtA6?=
 =?us-ascii?Q?nAaIylQkrlGLA5M3tqF7a3Y8Z+eO2ShLoVTlbGbtGhpYC0spYir5NK84nrAK?=
 =?us-ascii?Q?+tFsTa28vzne8dalmA2IFgBLWeF50qSlclFYEmFPMdmCPaU/9MwzB/U9pW6w?=
 =?us-ascii?Q?/wwyIxFeY7zJ1IryVYevO0mKNg4kr30dNPpdQe5nExcdan8fTQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 03:22:31.2811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f13c7774-fa0c-485f-32b6-08dcf89216fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213
Received-SPF: permerror client-ip=2a01:111:f403:2412::60d;
 envelope-from=Lei.Huang@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
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

>On Tue, 29 Oct 2024, Lei Huang wrote:
>>> On Fri, 25 Oct 2024, Lei Huang wrote:
>>>> Use a convergence factor to make the VM's input
>>>> global coordinates more closely approach the global
>>>> coordinates of DOM0.
>>>
>>> Dom0 is some Xen terminology. Do you mean "host" which is more often used
>>> in QEMU?
>>
>> Yes, I will change it to host
>>
>>>
>>>> Change-Id: I2c3f12f1fe7dfb9306d1fc40c4fd4d299937f4c6
>>>> Signed-off-by: Lei Huang <Lei.Huang@amd.com>
>>>> ---
>>>> ui/sdl2.c | 32 ++++++++++++++++++++++++++++++--
>>>> 1 file changed, 30 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/ui/sdl2.c b/ui/sdl2.c
>>>> index bd4f5a9da14..8f504dd8727 100644
>>>> --- a/ui/sdl2.c
>>>> +++ b/ui/sdl2.c
>>>> @@ -303,6 +303,34 @@ static void sdl_mouse_mode_change(Notifier *notify, void *data)
>>>>     }
>>>> }
>>>>
>>>> +/*
>>>> + *guest_x and guest_y represent the global coordinates on the VM side,
>>>> + *while x and y represent the global coordinates on the dom0 side.
>>>> + *The goal of this entire process is to align the global coordinates of
>>>> + *the VM with those of dom0 using dx and dy. The current approach aims
>>>> + *for precise calibration in once attempt; however, because guest_x
>>>
>>> "in one attempt" also add a space after the * at the beginning of lines.
>>
>> okay, I will change it
>>
>>>
>>>> + *and guest_y are non-zero values, they are not accurate values when
>>>> + *they are counted out to become negative.Therefore, achieving perfect
>>>> + *alignment in one attempt is impossible.Since the same calibration method
>>>> + *is used each time, repeated attempts cannot achieve alignment either.
>>>> + *By introducing a convergence factor, guest_x and guest_y can be made to
>>>> + *approach dom0's x and y indefinitely.
>>>> + *
>>>> + *                   QEMU                       (dx,dy)  VM
>>>> + *calculates dx and dy using guest_x and guest_y ---->  input driver
>>>> + *           ^                                            |
>>>> + *           |                                            |
>>>> + *           |                                            V
>>>> + *           |     update
>>>> + *           | guest_x,guest_y              input dispatcher ---> WindowManager
>>>> + *           |                                            |                 |
>>>> + *           |                                            |                 |
>>>> + *           |                 libdrm                     V                 |
>>>> + *       virtio-gpu  <------ drmModeMoveCursor <------ compositor <-------  |
>>>> + *                           (guest_x,guest_y)   calculates guest_x and
>>>> + *                                               guest_y dy using dx and dy
>>>> + */
>>>
>>> What about other display devices than virtio-gpu? Does this work with
>>> those or do they need some update? If this is independent of graphics
>>> device maybe add a note that virtio-gpu is an example and could be any
>>> graphics device.
>>
>> Yes,this applies to any device using SDL where the VM utilizes cursor plane acceleration;
>> virtio-gpu is just an example. I will add it to the explanation.
>
>You could change the figure in the comment to say instead of virtio-gpu
>
>  display device
>(e.g. virtio-gpu)
>
>Which may be enough to clearify this.

okay, got it, thank you very much.

Additionally, I noticed in GTK's implementation, it resolves this issue by using the
gdk_window_get_root_coords method in the gd_mouse_set function. however, I could not
find a similar method in SDL2, so I am not sure if there are better solutions available.
Neverthless, the current modification dose indeed fix the mouse drift issue on the VM side.

>
>Regards,
>BALATON Zoltan



