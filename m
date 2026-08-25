Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37153C61DBC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 17:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyuuW-00082T-1d; Tue, 25 Aug 2026 13:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wyuuU-00082D-Cj
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 13:26:06 -0400
Received: from mail-westeuropeazon11023090.outbound.protection.outlook.com
 ([52.101.72.90] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wyuuS-0006iW-31
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 13:26:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swfp6CXfuibWG+iy7h0TbIKKsrXIU9uV93Fw/remwnsYiFFOlX/pbNwP/uvZFhLAQhpirUX8hxImMbK9bfZlYMDI09JCNnCkFAcQszcA3/ngNcJw5pfghC6LwIRfhGRPHd2Y+sem3OQBKLv3Owa+x46PzPatCkLJyn1Diq1V7qxcUdnGhIP52T1qMTmi7tybhLG/SZGApB+vcTOyEsXnOil7Jta90WS7LUJ7WnrFwsNITRhHDcIl02QE2KSXU+oBx9zwc05KPWEDPnZpcEDQ53YYUzNLyd/08rBcEqIu32lVeOzim07vY2KoPPBPYbkSXHk1ORbPPivIYfqMT/TZ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PidhcwH5qMR7hjKpjgUGd/h3wxJa6WxBEbeqdR+7ELQ=;
 b=TiOigClmBd3jdtXpZcj66R2FMDxh6UXISUsvvwdARA6deWOypVAzsLBCmi1XuCj2ejcL+wB0WKR54J/oE8SgObX21SIN/akTW2V8RHrtPRpuIK6k/NltfZVzNN7MZw70b+3GIPziKfdHNn0YVhlonTyNquaQruOiye4b/F5qawMSoCli8zft+F4OhQu7wj00ZdzMpgNHUrrPTDUqPExjfB5M1qKa/TE1OG5E6R3iRgT4a8xk95iotqKxItFS3I+tNXcJLOa0eKCSdxYnGMuhdaK37RxuF6c353FQ5w/lOSeRhlOLFZl8c/B81A5qpFczvG7lTz4q/NYCrKHa7QixRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PidhcwH5qMR7hjKpjgUGd/h3wxJa6WxBEbeqdR+7ELQ=;
 b=MrESVQ9Zqlznk0Z+ad16X05luEFmCvMEP7mB9fhYvSo6bsqRaAl489t4HL/uJ1AnPEaARN66d0sDowe9v0QchLazTciAFlD4wALTMOq04HFEQbWtlKlINwLJdnYfa8nfUVb/upyla5mPI1mBY81QkeAouFc5P3fbF+55LXl+GX8OGQzrq+EjTdxIZQ9EEXKLGbeydw6TfXvHH4niZzOusrOsqz3rcRay/Jh1oG+2qw2VnKHODMRKiRsFaTh51bvGDgBGvHhbIFgjYpyTYKkdFP5VOaRIZDsYQWfsnjF9wBuik0Dy77+NyERZX0sOSY2YLzJBxR0gQk+ny91Ok60yvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PA4PR08MB5902.eurprd08.prod.outlook.com
 (2603:10a6:102:e0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 17:20:58 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 17:20:58 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, philmd@oss.qualcomm.com, den@openvz.org,
 andrey.drobyshev@virtuozzo.com
Subject: [PATCH 0/3] hw/display/qxl: Avoid crashing on stale guest addresses
 in qxl_post_load
Date: Tue, 25 Aug 2026 20:20:48 +0300
Message-ID: <20260825172051.435372-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIVP296CA0001.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:357::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PA4PR08MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a32aeb5-d4d4-45aa-c40e-08df02cd3a97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|52116014|1800799024|23010399003|38350700014|3023799007|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 9OxLFReCpEBM6J2a0YY1POKzaKhQs465pGiN6eqiHGfHkrQFTP5BnfiaVFUJcj5i/upaCaS4tgChQlVbbGx7pRVmOVKnUvAn47wyx0K0QTPAVMEtSPJrrgmjLlZ54pbW2TI4uGYi+UIWa147WOa+oviSgqzwfTHcdrctKZHPn3PLnUZf1RjW+s+gc7uzXe/ES/RynCbPrIOVQObOb+a4lYC7E66UfGJGqDLgEb6QCgeXmyh8VzgPA0fQkrzEHKX2267o2envbWWScTEaFB+84h0gIS9mYZyrtbkavFHPKPfwPfoQXaK470KREmfxX/bcnEQynK0kOFwPL3OzRYLIUi73V9GOSrP3gewFPPqgIONaM9CKyevCYXoRnhesjtbb0aMRhdZXlohEYLIv2CnPLx+mXELi0TnMv9ihEtxhLmyrzri567QfH8iXbdEEkgczPF2I7iRqLEd75Wjocj/NQpDDHl32K3WScuesUOli2nGunBqzAJcJ1NQk+7uL5uh8h+lJS19EG1oSnGH4//IqEzGduzOvjB9QHiGW7bLpKVIFLlUqosHATeb1GEyIh3hPviGnFL8giTdO4A6ou+MVlddfJNqxBlJcB47MHuVxKsgOZFs5NxDq27akURcTfzX1aQVigooFSYCjmnPMUVlSOMDdQWT2rBugNMHGzDGRVDLy72M8YLcd6Co7lDj0uWsw7Tge08iBK6XGIptPDCiYeXNEKUdShB+HP/U0oaW1QjA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(52116014)(1800799024)(23010399003)(38350700014)(3023799007)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zjAet59r/mwRSP9Z1ZF0BYfUFg2UW7TUB3+MlTTnY6EdDtupvVJ5e+VBKbCx?=
 =?us-ascii?Q?gwf6cdDoumTQf6wv+nGB1J7E0OUjE11mBiCXVxweL6/0Apcb+GMtMSmTX170?=
 =?us-ascii?Q?h/oGHGFb+oxB19NCJMuA3doHcqkXwJeIHEW8pWS5JXzRvApUQ63zSra3Ijio?=
 =?us-ascii?Q?F0cUTnxcnVth+f5bZndsmyft4pkb+/rAwPLQg94xRxYljHEx4MzOdZkr5OFa?=
 =?us-ascii?Q?Y8tFTRXh0ZcEgFpclOamgbc3gw/U0QGUNKmFTcW9TzZLZ34cRgOq0e3y8vCs?=
 =?us-ascii?Q?jXWvBiI2vwDhvreY+XOO5mA6Rm10L+eVadZAsCp5iqAjieQQjvn7X3De59LB?=
 =?us-ascii?Q?yqBgRkEvRFimEA6ABVkyBcKMUJo86s9d5gsmHHNpetMdqlc8nPYLO4trgyiK?=
 =?us-ascii?Q?EUu3iPRfCmcErnOrCpk8qvM/EZYBf16hNjjCP3zV+K6MRCEmbWNa837uzvlv?=
 =?us-ascii?Q?OSK7jykWks6FdEN9TqmNw+2IV3H1faC2H8kM1rjRMKqi+9hXrZifJuFkl0+x?=
 =?us-ascii?Q?qZf8RwyGRWys2VvuVCb4NW+NFQsPTBktOgSixUKsjQN41oPV5JrxcHODDlVh?=
 =?us-ascii?Q?w6L9LzEMmIT2abSodl1vCYk5SvagkLpPvzP2ainHV53/o7v/B4ll6D4DtqMY?=
 =?us-ascii?Q?bkV1f8oYRZWbeThArLEs2CKmeWZSCyq9X6o9PZJVTgPrysJ1iIBcVpFADBC4?=
 =?us-ascii?Q?DjRqsj3/valZ+4Uk35eFGdx5DpYgZ/siRmhLQEpFgCDs7O0q3SRgYJcbAJMH?=
 =?us-ascii?Q?HiYRjSrhpF3ilHx/vQKQyDGST34NHNVsZdLSdyz4cKPoU94iedcJz7KIOQJz?=
 =?us-ascii?Q?IGK24HjsqxRiKOZhhmFUEcXaeSIlMd+zxEmf+G8mj80Ng2H8b+T950Jguo2n?=
 =?us-ascii?Q?+3VEVU/KDR7lxDeWYrr7dxExPeeRmi1H43g7GxXqAWMeuhYYVIm3ymSWVXLG?=
 =?us-ascii?Q?lPNXZT/FqGYRaVXzfEwgNxpapILwrzCAW+8BSYZ1vLWwUh47UTCZ1zpwQ6Ly?=
 =?us-ascii?Q?mrUI2PX93IsGl3oz7HpNk6nZZq7ePAvrlCcxEK3OJU3lsWlGZ/m8AqjzFBKn?=
 =?us-ascii?Q?TnWkxcNnJSunVne4PNECL5kv2WWQmJFabsuO6Fhb8kZhfG9gZSy/pwQgnzvz?=
 =?us-ascii?Q?Na/RkSg2io2UAHTSBfQylULgCXg59er2TPID+hTKcxgGkOE0m0D0o+kBWp9C?=
 =?us-ascii?Q?LAtYn7kR2AnZPHmaJpXi9AFaOR9M0A/ts/3RTBMQg2ia90GlWGnnHRFFJlOM?=
 =?us-ascii?Q?IMTm8trExAdKqRpZ7Edd8t60FETEIxvw0avEyaX5kOnzsYlcyCM8Sq47IKDL?=
 =?us-ascii?Q?HBH6rvIp3VJMr0vdm0MxA/yLNgtAEWgmf6EMLplyeKAsBDQdMx7NWUCZ6MPQ?=
 =?us-ascii?Q?1P0uc33H+We3Z5nFfGwXmywmg1UyGsPq/YCnz9Q4O9/K98lYhNlyOFPpuXJh?=
 =?us-ascii?Q?kL1LX/BFN3VvD0tmPYEUKDn8NLrTy7ysmQQ1EZkqM88U0yiUl+TYPi2JfTUp?=
 =?us-ascii?Q?/TbW2SB6f/y2FmK9QGTyC8pAXYqiyE9Mr/sjDzGTYR8a1JNLr8UEMT/es9lU?=
 =?us-ascii?Q?GzSZhVSY08sUdcDvqN5l5fLFFi4t4xyhhigo9PDU7OYeaYnklw4p7ob84MUo?=
 =?us-ascii?Q?ilIX4zQ3ZdSN6KZV0Y6FTnvo3GOEU/p7Y4E5SBICaZOwImn9y9wgJZWRqCr7?=
 =?us-ascii?Q?bmg5U2hyj0V4wiGv3TqdChX5BGKHrHJt/LiIYybv8ZO7RaZfLpcghRiTfN/6?=
 =?us-ascii?Q?DiHRB3/QHdUNuW/CmxF4vn9gooTHCKM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a32aeb5-d4d4-45aa-c40e-08df02cd3a97
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 17:20:58.6294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mi9gxX5ZgZ5RwaASYnbTMm0f+309+Pyv3EKQWT4GPy1MpEylS1TLCgFnGOa5DBpeluxRWQwavKu9W9cEGaFU2uYgFG9s+vHYRXdXsltDQGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5902
Received-SPF: pass client-ip=52.101.72.90;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

We've experienced crashes when spice-server aborts on migration target
when processing an invalid/stale guest address pointer.  While those are
hard to reproduce, it seems they can be fairly easily avoided by simply
skipping commands with invalid addresses in qxl_post_load.

Andrey Drobyshev (3):
  hw/display/qxl: factor out qxl_guest_phys2virt()
  hw/display/qxl: validate replayed commands in qxl_post_load
  hw/display/qxl: trace skipped stale loadvm commands

 hw/display/qxl.c        | 132 +++++++++++++++++++++++++++++-----------
 hw/display/trace-events |   1 +
 2 files changed, 97 insertions(+), 36 deletions(-)

-- 
2.47.1


