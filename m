Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D9DCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN93-0006Wl-Ks; Wed, 07 Oct 2026 04:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEI4s-0001G5-Os; Tue, 06 Oct 2026 23:12:33 -0400
Received: from mail-koreacentralazon11023126.outbound.protection.outlook.com
 ([40.107.44.126] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEI4R-00012Y-Kf; Tue, 06 Oct 2026 23:12:13 -0400
Received: from SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) by
 KUZPR02MB9164.apcprd02.prod.outlook.com (2603:1096:d10:61::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Tue, 6 Oct 2026 20:56:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xydTj5GiQ90qd02yp4vGfzGpUIwTqKBz9unM93yTAMqBTLl+HUs2b3UglV0VFveeQQKTZfJN4jDEPdvW14/UEx3ke1vxXFi/b68h1nRVbgy1skWI+0IR/WabdP4/aoaGK5ANoxm/GKFbYvYDEo8S+MOACS270PDTeSSmMd4wsOfO8ORDcd6mQxoDxQ/yxhcw17351zPdKlKiyr3zl1OJVtBEvr3VSML7ML1uFk1b0rl/PWxqih2uBpY7MZBccAy4ug4nbzi5L6WTB9eNenjLMst7fvpQ/sPEVMa1fYHiOuQ+AHUWkoI63HorM3SEi80dh0rOUTSFZRXWkQFVi+mpew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLLqQ9TTnGAv6D6CwDCs49QzpPkgGfsXWj/w7YPkkr4=;
 b=cIBC9mgz6IGVKKja0EFW2xtM1nVGg1nwGyW9TUnQkpOfFzxLq8IsMwx5BbA5HT9eKAeM6jMT2g2QzeIfHMXX3j8qbUQ/in1GBp0Uz7jT3L/Fmsy7JYoigRpSYh1toEFPGHK9IzUXSnH/UpRp3koI4iLDoUBKekBP3AgkDVxdAlGbyMsz52rpmdz1u8UwWb198R3r6k9GNUc0TYQznquI6S9mF69hnH+laSS7WAV8s/M4YdlRuTyT9KsT5iw+dijCZFd/30eIMyiQVopk+U8QDK8vvc9itkOkgVlsGWEvUzLoP9Nrf1S/n6NXErvnlGBHPKU+uClcZ7a7KwMr3CHXOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLLqQ9TTnGAv6D6CwDCs49QzpPkgGfsXWj/w7YPkkr4=;
 b=vQHNLxfq2UPr2pdCSKocj9LvEhfzbtUFiDEPDVLydTJqkXtaNnA10N4ngt0WgOZzZdBq8mVatYbG59y2A3G5F9BDdbudFAgpjGPEiCQp7Ovf/f6kFg1OKhVG7gRV0F2R4OL+4A+lA2GTVgjr3Rxcy0+shPe9AhOEgWrn/JqzSqLXpPJ6WvYjfUTXNLnPZ5Mde6kUErUTZtH/DklKjFN3CWqdSIMC9Qpwnibp4sJju98RIBOZ8U4YTHNcFv0AoSl8Iqb73a3ZY05lMjCDudvslv4SExQf/X9DPEP8gbb4P69+iAaRWtHaFxf31tQbwz3pmzj6Vqfbk+9VFp43kyHN7A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 09:50:19 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 09:50:19 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH 05/17] target/ppc: Complete e500mc and e5500 L1 cache
 configuration
Date: Tue,  6 Oct 2026 17:49:00 +0800
Message-ID: <20261006094921.110871-6-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006094921.110871-1-bin.meng@processmission.com>
References: <20261006094921.110871-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0136.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::6) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|SI3PR02MB9388:EE_|KUZPR02MB9164:EE_
X-MS-Office365-Filtering-Correlation-Id: 10664a2c-34d4-406e-d64b-08df238f3b27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: F8fDGzAoolsK9VXE4XQRS2B9RZzZsq/TwnlywMP6qGCTVv9bdQPmFGl5lUuSlMFDmlrcsQN5ZJbCbr+9vMGdkgeSL7Q6+H2jbHLW4TLALFmepP6E0KsifZEYsZokJAKI3DSVQrJleaVFYuE0ri0R8H3rgRiQuBhCHJGgbHIxBaAeVxfxVLyhhQImYS98DAIeVuVl2QSLjG6Dot80PHjvG4qiMHmOisaqmA8eaSKrM2XPruh0cMUbQlO2m4RovGvnzfnOZs+o++WOJgGswUocrOirXCf5knuqxmoS/aSilPmJzM0NaeYgLqoyWW/86z2v6B9yuiIELfjhQr+vpXFdeeXvhKgkRv9gSd2ztiHEI8xSj5/uiw8lYgyMQTVMyfFULxy+slvAH0zKzL3WznycO8oXqfQpk6kqR8H1wH33fdGzDZodsqCDkReTlgcO+fbGe5gO7Tu4bSwml6cJJMWpeAnYHK8t3E6hxl7LUM6XTWmfttuKXqQhakx50kfvUzZgFicvubWrUB8zwP8fodY/XwEC5gib0kXEgstAzO1KfFcevMTuLG45rFohXGyeNO3ZFTfrEe5xlHGYMPjIdQsWK0gwjsMoXKh7tXS7JGNMUW9PedVIjgJX2UKKs9wPMCOiei/9nK84TqNTZH7SOrTpUIYZoQKbCKl6QXy9lbCQkL0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eTbgEmvkS71iY8lC0J3cwMrsiMIEnapDX1qS62LckU6x6g4tMzYMa1W8Qx90?=
 =?us-ascii?Q?JHHi+4syBk0P7ZaNROMYHB31EMO9kH5i3OhWjbbJpR5pwtJQ+rB8MavOjxbl?=
 =?us-ascii?Q?R1Y5arKiqlX2rA4Q4JGHXx8o7G+FJadgrlGx6Y3CzMSPnyHr69I+77TkO8P6?=
 =?us-ascii?Q?9Grd8+dWRvUppOFjhssXmG747Ef2+o0IIF5b94s3+9U1dhVA1rlYu0p2cRF1?=
 =?us-ascii?Q?+D/MLBMkGtCh8xa9mXuAs2VjJl+CPyEXt/tQ1YUNZWjG+9p1BUHx4ry9aE9u?=
 =?us-ascii?Q?ztZ9K856jp1eqYzGTxxw7I7qE/KE3Covm6yW+yMaqEIZlUaWW7lCEkV3GtMh?=
 =?us-ascii?Q?ahE1MsyI2Simww+w5I1OHsyGs36p1yESi6kNUlnEOdWoRODrApnSdpXCB/gs?=
 =?us-ascii?Q?7Z1h6o0ZItnzOpLLbUuiKH1HnZhaj4Wtpna3/onXDzNKHXOly+5LuM3udcRn?=
 =?us-ascii?Q?FJeejObquGMs7CMR8NnySvb6jmjoM0cd/cCB4tHV845xe8+JorpUuEdcDdoS?=
 =?us-ascii?Q?uu5lH2+2KfOLVTFAhEfI6okyarKQ/OtSVT9D3kV7Mq7KsZcsxT583gD7SyMX?=
 =?us-ascii?Q?EBPnmTFyfMPypccuAfilR/QnE/WtL0bM+Mq5KLUZq0OyscyfqYXAnXcoY6XM?=
 =?us-ascii?Q?4JIVRnGFpaMN/N35MJSqrJoqppOeZufKhb+hott7w3ZKftIF5Iioy5wA8Y1x?=
 =?us-ascii?Q?+ZhJ8xLUP5eTJaHRpQtvR+tudJVzuS7sbVAtpe3WGb6EmLzxlvLhjKjzJLPo?=
 =?us-ascii?Q?isE+15r+ok8Ue5JC9EJcZDDTjsvGMI1MJarzUgKoSIHnE5vxyEKpWsH+DVhQ?=
 =?us-ascii?Q?DToIGWR3PmI5Xc4k0VZPehrEILZHWoSQJJRCXHyCgpISqk/UmXzVGUyaDQa7?=
 =?us-ascii?Q?BNg8sNPpkWjsJMHUghu0Lso9obVg8N5tankkrCTeihW2T4McBhoxu5Kuugdc?=
 =?us-ascii?Q?tA61lMXY1sNNqE3d7plP3hGWcm2NItEgXUwOUc0Pu9V4j10HnFgQZk3iphm/?=
 =?us-ascii?Q?r4lHzajsJFUu5lb3VT/Y+C+OqEowank1wPgdmO9JIafe2J5jE2vBzzdLyVv0?=
 =?us-ascii?Q?3322VAHdCdxOF15TPfk+A2MQxKvasDgyd33MbSoEuUsFahivRHDgVLT7+tWz?=
 =?us-ascii?Q?RHyRgUhza4JvH0U5zvc+1KHI/omQp5lySrRd4qHVdhDDw+O8euxOp++Wl3Dj?=
 =?us-ascii?Q?hVE0Ri2kpoZQqhMnV825Vh61AsAa2TRj1USKf+nXRqqm4GwLld4QCYMVws4u?=
 =?us-ascii?Q?aeUGufrNbMPKbOu+3J8hHMBVOKnkLO0H89/USekbiCE5XLflJ1bBNizs6KD4?=
 =?us-ascii?Q?7KkExYKIa9CFoSw1KT59H7Q6Jv6gzXQ6QNQiQwRJlz3TH2yklafUkkYkCNu2?=
 =?us-ascii?Q?w11gvqg2BB9br3LUMuUpTABrGMc0mBLF0nUR9U686/8EFzUoq6/8KzWO2MHz?=
 =?us-ascii?Q?bdy6XOZAyi1rGwRiku3U8FeFg9cKW/umK4O2gD7VfsBHLy+ExhDHOcGzqcyw?=
 =?us-ascii?Q?1zTZUzAmlP5bXfsOevIi1j40yGDvFI6rHOMvaERUBMgFbagIEq9HwF5eO3J2?=
 =?us-ascii?Q?+idhVnWsy+xFCnwLXOFQzGxo9xLCMWhD31N4n3blL+nO+2nBHWe/NXcBJNo5?=
 =?us-ascii?Q?vwa6NmB82tW38NgTO5D+uc+OcBl5cpJvLI2W0YyJomYoxQioXBIZKU4hfTdM?=
 =?us-ascii?Q?VcsxSwWQyHEE0h0EfCz8CtUNE7h/vALmwiiag0ObiXtWGX5aoo4KbqTV/lH7?=
 =?us-ascii?Q?bZyoQY2arp36/NqUDs8thJuWt+z7v3A=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10664a2c-34d4-406e-d64b-08df238f3b27
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:50:19.0492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMvG1lW2lKIJsIanoy6JO/cZ8md1eHUXCcJw0YJkH/7tOH0AtAXr8jRsOSF9pbui6wECyAj4zrTdd8EWAUkJANS9Rtdt/kxRM2xDN3C371M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR02MB9388
X-OriginatorOrg: processmission.com
Received-SPF: pass client-ip=40.107.44.126;
 envelope-from=bin.meng@processmission.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

The e500mc and e5500 manuals specify pseudo-LRU replacement, cache
locking and parity detection for both L1 caches. The reset values
describe the block size, associativity and capacity, but leave
CREPL/ICREPL, CLA/ICLA and CPA/ICPA clear.

Set those fields to their documented values so both L1CFG0 and
L1CFG1 reset to 0x00B83820, including the shared eight-way, 32 KiB
cache geometry.

Reference:
- E500MCRM (Rev.3), section 2.14.4 and 2.14.5
  https://www.nxp.com/docs/en/reference-manual/E500MCRM.pdf
- E5500RM (Rev.4), section 2.14.4 and 2.14.5
  https://www.nxp.com/webapp/Download?colCode=E5500RM

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 target/ppc/cpu_init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 29f28be7e0..fec672a8a6 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -2886,8 +2886,9 @@ static void init_proc_e500(CPUPPCState *env, int version)
     case fsl_e5500:
         env->dcache_line_size = 64;
         env->icache_line_size = 64;
-        l1cfg0 |= 0x00800000; /* 64 byte cache block size */
-        l1cfg1 |= 0x00800000; /* 64 byte cache block size */
+        /* 64 byte blocks, pseudo-LRU replacement, cache locking and parity */
+        l1cfg0 |= 0x00B80000;
+        l1cfg1 |= 0x00B80000;
         break;
     case fsl_e6500:
         env->dcache_line_size = 64;
-- 
2.53.0


