Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39E7CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMiJ-0000l8-OB; Wed, 07 Oct 2026 04:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEHNQ-0003cs-Dg
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:27:39 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEHN6-0000Xj-Hs
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:27:13 -0400
Received: from MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) by GVXPR08MB11009.eurprd08.prod.outlook.com
 (2603:10a6:150:1fb::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.5; Wed, 7 Oct 2026
 01:08:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZ+F7zrwQLcjL2DZpepNTk0GOypKTSlEaI6VTsDk5yTxSIKgkkPpb1aJplm47dMjMgZtLhONpeo2fE1GBozGPD45PXBs0H6bZ7T3i9zUjD3TMTJQiy4ZxCgVeC9syLswLzF7pVeY0PblWoR2xRoxFGDsZGC8ArjM/bBMvjx/8b/Ay0aaNREt9dX50faYPkhlOeAwdPHAIlXXF9apYB8AwjTKapV8QApqvVjPZZZhq4eAGL/DkcgBWzx8SPwf0uSKqO8IaKZ/pAxC3/dE0PW79uTho/bUnUkJst0jdEJ08ImPdzeCSR6Oy5oAXpXn+moLWjQu6UssulXaXyYzJKs8yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZSm7J9yrn0iU2AlFWhkLXTIIpmOicai0XjBV/pB3Qw=;
 b=W52pjjMllhQg2KFiISy2p1AZExZR2cP5TeBs1v8Awarwin57Psho/rpmdFk9BsclLxXQRtQ9wVJoH0TeFHMTYxybFuipRgLBKFYzHoW/m3REG+nB3wLSOIv/NCk91TyqjV9NyjWYGVF5lAfCw5p9LMyfAXImsFp/ZMLafedqbT+lowGsFB1ssD5z1YWmPFw6f+lM5KR7YSnLaakrDo8JdBkXPMcUYlZRgwhz4BHuVzT0wWzFVBpuSWG1/cHu0b+C0ILFN13tcJfgKjOyT3617M08BymmyqooCHzdUdfzLTOmAT3BevDuF9HvnypIUXul9m5S848GgReQvUgd1s7AJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZSm7J9yrn0iU2AlFWhkLXTIIpmOicai0XjBV/pB3Qw=;
 b=w1UiLlVf2ewzYS68euPUTgPtqx8IbmpTiwYLSbGun2kW2D3SC7lW+mk9Z150p/R3ADrxVzOjeDUJNCTPpbhxtjvxTzpD3FW0ZBUIVZq43o5Q9+Ls175/mfLX9Y4oVuYOTQzSJA6dRPHDrTGhcWr+rZYGPF9yror5WpBQSDtb6F/zlQ5iAkl7OFRkjhjyWPt2p1p37EnIC9aSRljWNHfkfUTkgamATYj3tB2X3shHq+jMmSd82oK4jRbuV8I4/ves1Az8N8NUXoGZ+oJlP9hOeIZ5x54r797Sur2BYzjtKz0DVYTPZUXAE6Yqf0aQPza05cPA5sX3TMJKpzShjdPR9Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 13:59:01 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 13:59:01 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 06 Oct 2026 16:58:41 +0300
Subject: [PATCH v13 18/22] vhost: release ownership on exit
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-up-vsock-vhost-v5-v13-18-2ea78fd1b7ed@virtuozzo.com>
References: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
In-Reply-To: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, maciej.szmigiero@oracle.com, peterx@redhat.com, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, dwmw2@infradead.org, dongli.zhang@oracle.com, 
 bchaney@akamai.com, den@openvz.org, farosas@suse.de, 
 andrey.drobyshev@virtuozzo.com, clg@redhat.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, philmd@oss.qualcomm.com, sgarzare@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI6PEPF00000229.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8f3) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MIWPR08MB285920:EE_|GVXPR08MB11009:EE_
X-MS-Office365-Filtering-Correlation-Id: b2151a60-a8c2-4698-79e0-08df23b1f928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|7416014|23010399003|38350700014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: OYoUvkNg22hNL7onH8754magC5wOMpBrHgXLxP41ivi36GAkh7SLNq+6W7MorIj4gUXG2JKr0wsr/ORwYbcQ7o9GNddLlgWfYbvkAcF5j9OvdQOy07eM2aQ1Q0w8ZkFCTvxNkOIvTgh1m3SCbeIO0ZLP2UAcmOd8lU0Amj8xq6MFV1l6/KUSk6y4JhANJaZGVmRN8TBTC5rTerU1HsZkn0UsLQCnZvmR4z8w6Vq+utoJIMuIU+FepjiXWCf5zgwrHXJwUe6AwcOT/TPKleIeC2sE4aEiTODkDnI2qmD78ArfxXI9PwRvZ4jro3Sdl7ouZWWzNvV32usAUl2MendsEZUPHYj7vsoOr4EKBFe0OXhbJmYnLs/fCehf2hDxproevSi+EVN6Q+xOsE1/M1tYWe8REAb2NnKePwcPUNjg4u4G2JIpFI+tPHBrMuK2pTAiRt6RTCnvOmIjPgA5PjqSZBVO3xedHXtfYGZ2YAGN81jSwt0OMemA26sGIyVO76iSy9O0V4va1fS/GOcxs1LQzW5GjB2/Ss1nmz8EL0cN3Ox3Fqh4v53ri0+wiIBK5CrLvxfb/19L3cBGcQHatmTBZwz++bR4IEid80diyLBL1YwSJGNiTxAW5JrLTJ1JptreKcog5gOYX57FOjfmSwOzlf82RWBd0sQdpKCsM3Bj3w9AzS1eFVYX4JTEVNfSzHi/qe4NxoBLjFjJlLNM/WD2d402h9HhMc6LQlaR/DwpfQI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(23010399003)(38350700014)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0ZNUkIzei9adERZUUVDMXBId2FDbmdURXR1K2J4NGVkajYvKzJZdDlaZFht?=
 =?utf-8?B?OW1OdWJTTStweHJSMWsvS0JXVnZubm4wR0MzckJzMmpScU1NNXd0WlNURG9D?=
 =?utf-8?B?Z0FJSWxKZG9IbEhsNnBnTm8zM2xzMUZ5cWRVODhrYVZTaDFZcTN1aC9DS3hZ?=
 =?utf-8?B?a0Rla3lCbFlkQURablJZZEFrWjNIZGFaak9CQmJoUlRodzA0VnlFazJOU2Zq?=
 =?utf-8?B?Q1JDSUQ4OHpXRVdQaTNxU2xzVUVOc2kyYm45SzM2TDdFQVZJcmJ6TmxCSE13?=
 =?utf-8?B?eG11Rk9HeDA5b3UvazdWdENaVVpvTDF1d2FYcUJHbWI2YlRISS85SkRuM29n?=
 =?utf-8?B?cHhIMzN3anV0RytYdUVDOUliMjhHRno3N1Z1eUtON0JkZWw5cWZkeFI4Q3dM?=
 =?utf-8?B?a054bTNyMW9WRkx0ZnhhVUN1OUVYbkQ5NE91MndkcFN2TkJoeXFuMUNxdWJm?=
 =?utf-8?B?SmR1c3F2MCswZVlBbTdyMXJUVXcxMDBUNUVYMDJPZWQ5Q1pVc08wbDFoa0Vw?=
 =?utf-8?B?SnkxWG1rUkU5NENHQXU1VVFOWnY0Rlgzdlcxb0gwTE5QQU4wY3dWMFFHVlFu?=
 =?utf-8?B?am4vMDUyaEpHK2ltQkVPZUt4anUrS2RWRVB2Y0N2akg2ZU8zanJnZ2pVdE9H?=
 =?utf-8?B?SE5jYlVwaUxmd3p1T1htd0xHaHdaQVlSUGdYRmdTdXdQUk1SVGk4NWoyeS8x?=
 =?utf-8?B?TDl0Y3NsRDF1aEpxbUZPM3lHQVZPYy9TRjVEK3MzZ215MEN1UExlNUdHZnJW?=
 =?utf-8?B?S1R5T1ZmRkZ0amEwK2svZWswMzZHMHdabEs2V2U2NjhLS0lBRHV0WlV0YjYz?=
 =?utf-8?B?Q1VxanZPQ0RRNHEva3UwZFowRG15c0ZPRmdXVXN4TGRzWFcyUFRWSS93bnJB?=
 =?utf-8?B?eG9HN1hhYW5pSUtGWUpIdjdGc1JGTGhtb3p0a1pNUnhxYkxCYlZnUXM0QWVu?=
 =?utf-8?B?NDR0aWdueTlWTCtnaXZPMjlVTC96ZTJleExSdTU5R2JpRUxIQ0M3N09DTmJw?=
 =?utf-8?B?VkdUZ1p0VnVadlNsMU93ZUU2aTRpMC9ucXE5QUxYMmxRMTFCK3pXMnF0bk1H?=
 =?utf-8?B?UWM5Vng3N0ZHcEZoZXR0azFsS2RXOFVES3hWN3Z4WWFKM2tGWk9CNTNEaUVu?=
 =?utf-8?B?amhiNTlxaWlJdHZBeWIyRkpUVm04K2syRTMvSWQ2anh1VVI3RXYwaDFCNFhx?=
 =?utf-8?B?cDU4RmNHb3QwVzNBT3dRT3UxdUdaRlpYVnBRQW9IV2JZSzBubFdkcVA3Uk1r?=
 =?utf-8?B?cndXUUIwS0s3L0g2cTJ4dkQ0RDV6Zmd2SkY2YzB1ZUpxalBxaitYdzlocEkw?=
 =?utf-8?B?Y3JoWjRKQlFnVnVaRm9LczFzdDYwQXNubldBcWY0N2o4WTNVTmdlWGtXcVE5?=
 =?utf-8?B?NzV6ZFVDN1lLaTJ5d1RFSkh0em9zalJMTnhhbE04Y1dEQVB5OTRMYUhwazhQ?=
 =?utf-8?B?bnMxUURNeE1zeGNTUWpQRmJVemxOSWtwYTVqaGVlWnd1NUx2TUhEZjdROWxR?=
 =?utf-8?B?eUFDL3FJTUUzdUJWNy8rWTd5WjJHVXpqTTNLZ3liZWdHSTgrd1RUR3VPSHIz?=
 =?utf-8?B?eTZYQUIwa3Yyd0JyeUpHTVBxVFBnRDlVUGtzaitBMEF1U2RWZ0tzMFN3RS9O?=
 =?utf-8?B?c0pJN1B6ekM2ZUhqYXdKdUlTM0oraUh5VVExVHF6eGtFVWx1QzJQKzJoanBH?=
 =?utf-8?B?eE9sTHY2NVBzSEpjbjBjajQzM2h0aXFFczBrUGRFZzNzMlFDbTgyN1RVbVR4?=
 =?utf-8?B?S28rRklDL09pb1I3UUZTU3hDQmllc09OZSsyc3Z6NGl1N3U5M3NwdWgxMGVx?=
 =?utf-8?B?ZUQ3a1A1dkpJN3IwVzN3VVRuVVBYNEVUeTNBUlRqbiswNHZKN0habDBrOSt6?=
 =?utf-8?B?N29MaUw2NWJhN0doT0U0dGxVakgzNjlZOG9EZWhvUVpuYlNUd3JnNlhOMHBI?=
 =?utf-8?B?Y25CdTR4d25LdHE2TGVxQklaQmRzS2tDdjJwRWU0SWFGNkFzSmNLa2xlWEsv?=
 =?utf-8?B?dnQrcHBnQmZ3Q3YzNXhLQ1lhMUlrU3ExZDVSQ1BxaUZ5UVEwSEw0aXpiUXpO?=
 =?utf-8?B?bHg3UFFQM29HaDFRMzBnUHlnQUROSTkraEt2Q29QN0V6cFU1alNFRy92MzJ2?=
 =?utf-8?B?UDk0Q0VWRFgyT1RSaVBVYXpSVklDUThZam9MZUhwVU15bGh4ZHUzcHR3eEdE?=
 =?utf-8?B?Z3IyQm5QWElPRWllM3I2dndxellCQ2U1OVM1QXVHTVlSckJvVVBrSHJVZTMv?=
 =?utf-8?B?MGt1ZUZSNzB4T0VCU2d6b3d4TWtDaytwUyttN1JBWW0rVGVIbUp2SFowT2hM?=
 =?utf-8?B?NG1FWHY4K0l5UzJOb2xSMk9XaTJtdHU3Zi8yOW5xcTIrT2o5eXdKMWY1d0hu?=
 =?utf-8?Q?JdB8E+EAyQIuUPOs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2151a60-a8c2-4698-79e0-08df23b1f928
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 13:59:00.7702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tl8Sue9TUAHxCwjMhD9/0xwoF9F4GXdyqM6OiTeQ0xmZ+23ObItQnWNpecqU4MvCaoYIFDVRgZd1BoPAArGzGAn5OyHKprkFjXWCV4BeOgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB285920
X-OriginatorOrg: virtuozzo.com
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

A CPR target that has taken the device ownership in post_load() doesn't
always reach vhost_dev_cleanup(): a target which has loaded the state
but hasn't been started yet, e.g. one started with -S, may be quit
normally, with the source being resumed instead.  Devices aren't
unrealized on quit, so the ownership stays with the dead process.  The
source still holds the FD, so the kernel never releases the device, and
the source can't take it back after being resumed -> SET_OWNER fails
with EBUSY.

Add an exit notifier to each vhost_dev, registered for its lifetime,
that releases the ownership if still held.  This covers every orderly
exit.  A target killed with SIGKILL or crashing still leaves the device
unrecoverable.

Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 22 ++++++++++++++++++++++
 include/hw/virtio/vhost.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 86e9a234638..35eaafa0f92 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -31,6 +31,7 @@
 #include "system/dma.h"
 #include "system/memory.h"
 #include "system/ramblock.h"
+#include "system/system.h"
 #include "trace.h"
 
 /* enabled until disconnected backend stabilizes */
@@ -70,6 +71,21 @@ static void vhost_incoming_failure_notify(Notifier *notifier, void *data)
     }
 }
 
+/*
+ * Release the ownership of the vhost devices still held at exit(), so that
+ * another process sharing the backend FDs (e.g. the CPR source) can take
+ * them over.
+ */
+static void vhost_exit_notify(Notifier *notifier, void *data)
+{
+    struct vhost_dev *hdev = container_of(notifier, struct vhost_dev,
+                                          exit_notifier);
+
+    if (hdev->owner) {
+        vhost_dev_reset_owner(hdev);
+    }
+}
+
 unsigned int vhost_get_max_memslots(void)
 {
     unsigned int max = UINT_MAX;
@@ -1840,6 +1856,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     hdev->log_enabled = false;
     hdev->started = false;
     memory_listener_register(&hdev->memory_listener, &address_space_memory);
+    hdev->exit_notifier.notify = vhost_exit_notify;
+    qemu_add_exit_notifier(&hdev->exit_notifier);
     hdev->incoming_failure_notifier.notify = vhost_incoming_failure_notify;
     migration_incoming_add_failure_notifier(&hdev->incoming_failure_notifier);
     QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
@@ -1891,6 +1909,10 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
         memory_listener_unregister(&hdev->memory_listener);
         QLIST_REMOVE(hdev, entry);
     }
+    if (hdev->exit_notifier.notify) {
+        qemu_remove_exit_notifier(&hdev->exit_notifier);
+        hdev->exit_notifier.notify = NULL;
+    }
     if (hdev->incoming_failure_notifier.notify) {
         migration_incoming_remove_failure_notifier(
             &hdev->incoming_failure_notifier);
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 6df012859a6..3f2b0635753 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -117,6 +117,8 @@ struct vhost_dev {
      * Updated only by vhost_dev_set_owner()/vhost_dev_reset_owner()
      */
     bool owner;
+    /* @exit_notifier: releases the ownership at exit, vhost_exit_notify() */
+    Notifier exit_notifier;
     /*
      * @incoming_failure_notifier: releases the ownership when an incoming
      * migration fails, vhost_incoming_failure_notify()

-- 
2.47.1


