Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23414D5B874
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 06:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5fU6-0007uj-1R; Tue, 29 Oct 2024 02:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lei.Huang@amd.com>) id 1t5fU1-0007dS-Kc
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:13:38 -0400
Received: from mail-dm6nam11on2068.outbound.protection.outlook.com
 ([40.107.223.68] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Lei.Huang@amd.com>) id 1t5fTz-0007TQ-8p
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:13:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpi6V1f8dreaIJ54WEFtSFVSTf31hSEPYk99PnXsd3JkxZbd47uEjRTHcutooQdKecq10RMFTMfXB7utQ3n4RpTVnUzk8tDq/VkJtibQYkNbPYSfULU1ccujr+64VKORyXKrTcmzUDvBVnEyy/aCDLQFX3b+yc6hemgl3ha96o36M2Uke7VCKHVWqDnZ7X/htb4BwbWDHAJGsWfwZTvJfeUgyW86rZo7H02mSOqW8amGNmVDNuvuhhsVDRp47JqSyaxERIAlZ2kUEPcYqjGToxuqRYnaRODtp2jipqFS9jfJyGgPeTU2J8AbsMO3oVpzZf3+vRl56twYPiU0u0QD2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ejCZ8p493yxIWGPbz/IEeiUjFv/SXmt5CQk8pFGX9U=;
 b=IhLfwU+vMVb5OJgG3fj9AHRX9XMQ3ep74KTj3cHStVwT0f+5fF88CaKBJrJ1mc1OZWD09nAtaaUNgnVi7LdVd2g7e2d1WXTL87ADBB4TUKHvSHuAqN/YTrn6/qLiOKkFHlmjruMybIoU1eFLct1cxzipepgAHFm70KH1d26CWiooILxjWWb0xMEQy8Mzz3ZGMULHlHuEA+NzlThMXDhDZxs/nY03QzRg7ZGPnx3s63zcI9E29BCBqkEFe0l721QcTOSaKPowskWsFL3sHKv789tpVM7SlCwoZE0Kr2SiK4js6Qhcid8kY1VlZNJJVnl+MCCd3YJxZe8aM3VWsBoI8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=eik.bme.hu smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ejCZ8p493yxIWGPbz/IEeiUjFv/SXmt5CQk8pFGX9U=;
 b=IoNXiHuRfLpZNKKgNqWS2Ecxjz+zaevCsID+LzAip5w7b4VA8aO1+ANjQ8wtTLFva6aHe8vvKQX4+T1qZ1TLOh0yx9YPL5NQ7oy4mmjKNN9VRn97syZFaQbcfQrrwmn/rgTB7+d8dlzo7Y0lABjJzUcYjuCPsUe9Y6awP7IowWU=
Received: from CH2PR07CA0054.namprd07.prod.outlook.com (2603:10b6:610:5b::28)
 by LV8PR12MB9360.namprd12.prod.outlook.com (2603:10b6:408:205::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 06:08:23 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::7f) by CH2PR07CA0054.outlook.office365.com
 (2603:10b6:610:5b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Tue, 29 Oct 2024 06:08:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 06:08:22 +0000
Received: from SHA-L-LEIHUANG.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 01:08:19 -0500
From: Lei Huang <Lei.Huang@amd.com>
To: <balaton@eik.bme.hu>
CC: <marcandre.lureau@redhat.com>, <qemu-devel@nongnu.org>,
 <pierre-eric.pelloux-prayer@amd.com>, <ken.xue@amd.com>, <Lei.Huang@amd.com>
Subject: Re: [PATCH] ui/sdl: Mouse event optimization
Date: Tue, 29 Oct 2024 14:08:03 +0800
Message-ID: <20241029060803.1381-1-Lei.Huang@amd.com>
X-Mailer: git-send-email 2.44.0.windows.1
In-Reply-To: <alpine.LMD.2.03.2410251127250.22275@eik.bme.hu>
References: <alpine.LMD.2.03.2410251127250.22275@eik.bme.hu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|LV8PR12MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: 40a40194-8471-4ef1-9fad-08dcf7e01821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XCOZVtrYPzLFyVKb64QcD+FRJnXwA+xZhgQq2MRwud14JxaOCen81AoiAHQT?=
 =?us-ascii?Q?iEhRxq3/YALrbHRDJqZImPnXKD/JuEmtC9XkllJVBLZbcPXYm5Uwil/obIr0?=
 =?us-ascii?Q?KlZbFcZCIXFfCePXXo+WdZmC1YlS1BqLPnyKgIZkPhCHwJYYRAHc5MNzG5iH?=
 =?us-ascii?Q?kysuMj19FTRi0+lSOeWjbl7DCTc8sdbHOt2LaL4OwotupkK9sSsvhpiAW3xX?=
 =?us-ascii?Q?4fboTH6RkGllz0bCLXRYYEx8VFYLZHjr2ORJUvD/frLAHWXZrWaGfM+4WVcl?=
 =?us-ascii?Q?sv2cIJW+dTobjaG9u0VWca+vk8IqlOuIk4an/S1pBrxahuqrgmB6uMPo18dr?=
 =?us-ascii?Q?D51kVKX0boGo36OgIin5TMltEJqHvgk69MmZCDVWGNYwWx0oO1z9wWJ6CPsi?=
 =?us-ascii?Q?WNoXO4qPotPi5a2gIoi3XCelWOGI6YhxHwYU/GOPgJfADZyomAsA6h6KpnpV?=
 =?us-ascii?Q?SoeVYf81n+ajvsPnFR9KSMle8JcMbeqC8J7FcpF39SZqWll0aXWwf+SSjMPN?=
 =?us-ascii?Q?ZapttGG5+ENr35wTSuSD/161VsJIf5w9Fkpq/WCKsrW7x5H+q+OGNSNV8QvG?=
 =?us-ascii?Q?lRuPJNYKwENwO4iTFgmVWOnKTWYnh6zmKTHthxWDtVYkstrebIcUZaY+wN5l?=
 =?us-ascii?Q?hqeyHaR2LZQK0VbPZuZY4aYnQubMcX/+einAVZP2uT5iW21mVQSLX3LI6Cuu?=
 =?us-ascii?Q?AjwawM/DYLKI4FX0X+kSpoEugOUs3fbtH3TQBnbSPTl1/JlluU4E7Jap9aaC?=
 =?us-ascii?Q?NUEwmyNURAILjza8r+a8tj6C1T/q5rWLLKp8xqUSNflV4WzYdtRzLxz+bc0h?=
 =?us-ascii?Q?sr0I5UjjrPpA96pNisFeEvSw6RhC2X6ZtES1BB+POphYaIMAjQjtIjTL4X/a?=
 =?us-ascii?Q?P19lpT2CIB+CqiSdn+bVm1RkyIdxR5VOSP6mNUvv22r9T1i9PStbcYPlJnH2?=
 =?us-ascii?Q?2ihWjyMJWYYAEnUbRK/J5eOL0GQnBVqwYN25dpbECYBy2Z50zzErJnm5Xt/e?=
 =?us-ascii?Q?qgUnfkdpMrNCzuHk3rFpWlZNfE1obSNmd56ad1PToh/bsOR2VBeY7+SHT2/O?=
 =?us-ascii?Q?/lKmlMz2/sjFTk/WiwGN14B8hcmyhfSZqXc0W6gt+rdqpiiUn6TPvk2RsVq8?=
 =?us-ascii?Q?hX9adT9pIwwGutx+1sFh5PX/wvvdPr/avaWRNQL+Ku5YAovRnsLEI2a5VxdS?=
 =?us-ascii?Q?0bgo1SBi5XPnpKr4RvuLWUNlyBf3xOaRhVM6RT83Pp8iF22w99DQhPyJROx6?=
 =?us-ascii?Q?0MBzE+bX94FJkLkB2eVPi3WXrWdpf9ZC5yKhD+ZdbVhGUDsECJzsDc9vhIqD?=
 =?us-ascii?Q?62rmaVztaTIziHn3wLQRMK/Seco/+VdpKlEXXG2GNH/d2O8qPsFEbwAgPebI?=
 =?us-ascii?Q?q+y6YnPW5gee52QT5mDFH89e27mXXfzujTAZARGnDDNCStrmlQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 06:08:22.8265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a40194-8471-4ef1-9fad-08dcf7e01821
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9360
Received-SPF: permerror client-ip=40.107.223.68;
 envelope-from=Lei.Huang@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

> On Fri, 25 Oct 2024, Lei Huang wrote:
> > Use a convergence factor to make the VM's input
> > global coordinates more closely approach the global
> > coordinates of DOM0.
> 
> Dom0 is some Xen terminology. Do you mean "host" which is more often used 
> in QEMU?

Yes, I will change it to host

> 
> > Change-Id: I2c3f12f1fe7dfb9306d1fc40c4fd4d299937f4c6
> > Signed-off-by: Lei Huang <Lei.Huang@amd.com>
> > ---
> > ui/sdl2.c | 32 ++++++++++++++++++++++++++++++--
> > 1 file changed, 30 insertions(+), 2 deletions(-)
> >
> > diff --git a/ui/sdl2.c b/ui/sdl2.c
> > index bd4f5a9da14..8f504dd8727 100644
> > --- a/ui/sdl2.c
> > +++ b/ui/sdl2.c
> > @@ -303,6 +303,34 @@ static void sdl_mouse_mode_change(Notifier *notify, void *data)
> >     }
> > }
> >
> > +/*
> > + *guest_x and guest_y represent the global coordinates on the VM side,
> > + *while x and y represent the global coordinates on the dom0 side.
> > + *The goal of this entire process is to align the global coordinates of
> > + *the VM with those of dom0 using dx and dy. The current approach aims
> > + *for precise calibration in once attempt; however, because guest_x
> 
> "in one attempt" also add a space after the * at the beginning of lines.

okay, I will change it

> 
> > + *and guest_y are non-zero values, they are not accurate values when
> > + *they are counted out to become negative.Therefore, achieving perfect
> > + *alignment in one attempt is impossible.Since the same calibration method
> > + *is used each time, repeated attempts cannot achieve alignment either.
> > + *By introducing a convergence factor, guest_x and guest_y can be made to
> > + *approach dom0's x and y indefinitely.
> > + *
> > + *                   QEMU                       (dx,dy)  VM
> > + *calculates dx and dy using guest_x and guest_y ---->  input driver
> > + *           ^                                            |
> > + *           |                                            |
> > + *           |                                            V
> > + *           |     update
> > + *           | guest_x,guest_y              input dispatcher ---> WindowManager
> > + *           |                                            |                 |
> > + *           |                                            |                 |
> > + *           |                 libdrm                     V                 |
> > + *       virtio-gpu  <------ drmModeMoveCursor <------ compositor <-------  |
> > + *                           (guest_x,guest_y)   calculates guest_x and
> > + *                                               guest_y dy using dx and dy
> > + */
> 
> What about other display devices than virtio-gpu? Does this work with 
> those or do they need some update? If this is independent of graphics 
> device maybe add a note that virtio-gpu is an example and could be any 
> graphics device.

Yes,this applies to any device using SDL where the VM utilizes cursor plane acceleration;
virtio-gpu is just an example. I will add it to the explanation.

> 
> Regards,
> BALATON Zoltan
> 
> > +#define CONVERGENCE_FACTOR 3
> > static void sdl_send_mouse_event(struct sdl2_console *scon, int dx, int dy,
> >                                  int x, int y, int state)
> > {
> > @@ -331,8 +359,8 @@ static void sdl_send_mouse_event(struct sdl2_console *scon, int dx, int dy,
> >             y -= guest_y;
> >             guest_x += x;
> >             guest_y += y;
> > -            dx = x;
> > -            dy = y;
> > +            dx = x / CONVERGENCE_FACTOR;
> > +            dy = y / CONVERGENCE_FACTOR;
> >         }
> >         qemu_input_queue_rel(scon->dcl.con, INPUT_AXIS_X, dx);
> >         qemu_input_queue_rel(scon->dcl.con, INPUT_AXIS_Y, dy);
> > -- 
> > 2.45.2
> >
> >
> >
> 
> 

