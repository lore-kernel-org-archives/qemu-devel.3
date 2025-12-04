Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511A4D1F9B4
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 10:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR6ve-0002Vs-8i; Thu, 04 Dec 2025 05:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vR6vM-0002Lw-W2
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 05:51:02 -0500
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vR6vA-0002Es-1Z
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 05:50:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDYF8Yecqqf1kBfSWV5PYAETYQP9Y0uTI0rUVm8I5WaOIi4kx8i2ntRHUsKeMXS7ySuWUCPuJdCXGgMK6c9s6rL+nO6zCFTYciNno4sGEOoatujNFAb8wQ1xb6uaKIZEcstya6/VEQpTh+AEDPnwnjFz85lglsadh9ZnfNVJz2jOnNsJVpCVnhNI6RIFyb7jaqNjYo6lWPMj2WFmc97X/dtIeSAvDeWdltttlve6BTdbcspUQDjDkqFhaGx3Jhs+B7RHZDCc7PX+ZuSPBI1CRxEfOz8ik9wkbctb3fsM70wUwFjTBzTW9na/8evnR4ss3XXIrtV03Q/lMrfEeNrj1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4FwUbISpFx0edlczaa5j1jU5/j13QFpVh/CjI8nHfM=;
 b=nBbDbcsO02cz4xguQV0jmnIoNy3arwkG6XTBJgO0yLAX9BRD1vKCONywYRuouES+BJuLrFfVRxlsV98oSlFOXhzxiYY3A2MhkTgpluTTqUBV80kQMA6MMpbWvuOCZ/D6UJ0GYxa8UfPyhv8bKmM2cZ6S2lRUhWazTyrjw5PHMRi91z69WUYMajweIwnNZoxkZYlGvJCxhehPPoI66J6N2L/5S8lCwPXTtvEEtnET/4amtMcCYyPZ3B64Cv4fiwQHOj8+S1NI83SHsN6LtxheJoV3w51IzS8lMyGOLlnVNHAHIN+2sAzUwT6Mb2IeiKXQgsTY62VeyT1HUtl45CWOAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4FwUbISpFx0edlczaa5j1jU5/j13QFpVh/CjI8nHfM=;
 b=fPmoOGxwwhccY707QIS4Ky0hfFUExbLQN1bCqSqLtQ2GZ+Y6ufx5ezUyq4x8bHgffaGslluVaXWmBEB/DOtNZnv8E2NdRECfN55ttOMriwfCpncd2ukTILDU/HC6XmmXSDO+pf17sbk628OXWG5ZNAFW6iAqB95rl4Va1X2Mqvoq9s28GIDsslXGvbKrj9pUmmgG6GIrUxLiotNuFcJJcNXnTcuj0fQJItHi/kesHaYgoMBW2ra1bGLS22+ViOBXW9+OpF18sj1IGMmePLXvODi4bwtD/PzJbxNiRffbRQ/Spm28cJZwPd4MNe7PHGFggMCCsPwo5Sb2RWc+mX4zxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAXPR08MB6480.eurprd08.prod.outlook.com
 (2603:10a6:102:155::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 10:50:33 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%3]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 10:50:33 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peterx@redhat.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com
Subject: [PATCH v3 2/4] scripts/qemugdb: timers: Fix KeyError in 'qemu timers'
 command
Date: Thu,  4 Dec 2025 12:50:17 +0200
Message-ID: <20251204105019.455060-3-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251204105019.455060-1-andrey.drobyshev@virtuozzo.com>
References: <20251204105019.455060-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::8) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAXPR08MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c832771-0671-479b-c889-08de3322f2c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r0LfWvQgRHLfOm2Uux3GtOvN8VFclhW+ailVK5SECPsyGEGMWJdd9e+eAu23?=
 =?us-ascii?Q?GVx64knwbPr12hQZUhYhcS9EUijLCSvb2naVl6xs5uOQ+aQ5eV23xSz4WopR?=
 =?us-ascii?Q?HBGL41rePvhwroMq0GaYjYSdEUUk1bzFYkPaisIr3E/FvqzPhcLF/CkCDMhn?=
 =?us-ascii?Q?uLgrlhf7gV2V7WFSjfPL9jTwll43rUG65sBeOIk0bd/DPFztB/nsVcsz0yeh?=
 =?us-ascii?Q?+51OE7YEqm+/1T7bT/GIWOA09P2MTBU44JDJrWAt5SWbpW7f+7qDKWOV1qgC?=
 =?us-ascii?Q?LOohdYxFqHUIQgEkh3H8qnImY4LYdTJaga77t2jIxnUzBs0utna0hhF+GhiW?=
 =?us-ascii?Q?7hMdxtO++U4FO56wrowmwFC2WVJzuct101bgnSd0TFmNT8y6hqneLGq320fu?=
 =?us-ascii?Q?5anVvYrMKmkMATLfB5q8RUoTrSdvT8ThcuORZlervuH54QnTRGxxwDnBVU5w?=
 =?us-ascii?Q?h2b4GdwCvDWSPid2IgS6cogmgVPBJI0FZVAGcPBrMRQhB19/OmkIJyso5MlX?=
 =?us-ascii?Q?zZHswmEmSkigQcl5rfzrn8O1JGgh0pcH/TjhSx2d7ymjFo6JctHcI7cCGo9J?=
 =?us-ascii?Q?vlEE/SneKcDmYg2RuFrXeydQd7OOeMjkzHPNNcatZousIX8FjQC4r7Y1eTbe?=
 =?us-ascii?Q?Xt44aXScNWkzc/4IIUVCLJY4Cn4wDT1DQg7KXOByEFUaoK+Na3L2s4HxWDi1?=
 =?us-ascii?Q?wzuHHTj3qh6vFiJjMfOOFRbPqZJvd70i5qfgVNuanvs5vwjck+8i2x6UXEET?=
 =?us-ascii?Q?EthUJ7BMJNXwlNN2fkQOSen6Ha4DaTi7f7nN4mojwNogkmRrbacSoUXCj79w?=
 =?us-ascii?Q?uaoAVGow1oZFELEkWtdwi8j80Ea05ImDCKumLz69Fbr0/DCaGKWsSYtRnOex?=
 =?us-ascii?Q?rswwg1n565xfwAaVfANNFZrfydnp2dgTOWbwVSKhQhRu6ngCu0lrzvCWV8wo?=
 =?us-ascii?Q?ZlpYB0ZrAfjOFtolDB3l7VAy8IbHtwxX66hcWuPFMrINzS7mJ9WnsFjXR/8R?=
 =?us-ascii?Q?cnBss/8Ftr/E9zkJ9uBrvxzKvRKLAOBP0liHRefLqcZLUwsoa5TeiFoo4j2l?=
 =?us-ascii?Q?5OtY/D3X6vE3iNJeWVHKULiz0h+AVkYCTVMtycXK61ufbU7TTWbhRCkyOHDk?=
 =?us-ascii?Q?F4ix25rkFcyYOuSJFI8MChVaBwZ5aA44JB+soK2Zib0xSoKEsq1P8IDJ3gqj?=
 =?us-ascii?Q?AoTBhjAlTmSkcrDzJZnakV6DGmi2oPCGxBhUbw75jHk0Ik3DyOJdSiRK8UnE?=
 =?us-ascii?Q?b3r+i9VqKc2MG1i/JSawc95z7eViYoCLsNXuoSlSlhc7/bzENheWZlpQdJdD?=
 =?us-ascii?Q?4EJx7F594qhwHeyKnjJ/krk09ocrJyXILMeETK/qcKYZg0ZdhJfHbqANs1cR?=
 =?us-ascii?Q?QRliRBuft7RIG966yb4/BDcqMPhm2Z8K5yIV+6F5QEvGAD739TbbVSjskkbv?=
 =?us-ascii?Q?PhnH9AGbysSrfZ+r0ZezBGWVzqxM6zaaGaJRQD9kzRmF3TAebrnzb1iAV6CW?=
 =?us-ascii?Q?D0Ay85yZtzByukpqDqRRM0fXlnWf0REvAKKx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?48ywNScs6ShjpeW4JOMT6juBLjCyy0q2xpyhTtKeSmMrzNoB0ldRJ7YZdDLf?=
 =?us-ascii?Q?gZQGQG6kGY55fENi488c0QxumNECUBBo5HqqT3STc3Qcri9sBSNPLEifHRBD?=
 =?us-ascii?Q?JGrzk/vC4ugKeCgE483YUbIodbkV4yaw9VDvC6dURziFtvf+WIXBoiiUhS+e?=
 =?us-ascii?Q?uC/4o23vy3fFnIUyyesTrAWO/xjjzjA969gZyDMz3D+n3vlQ61hpOME1p57m?=
 =?us-ascii?Q?CwWebtdqRxte868j5v2Oip48K3O7IdAQt225NZH161zHoCbeQhti0KGcrRGX?=
 =?us-ascii?Q?CnQOP+RfHwsdwL8lsymhMUMlqd4uwDkd+oZ71LRclaDsgwVMhREBbvckqasa?=
 =?us-ascii?Q?qpnD+4HtcSoJQ2673cXEWbwXhqTo4BpjJ26/0b5fWTJQs8P0M2N5rxwAarQa?=
 =?us-ascii?Q?BZQXaWnnBSKzzCHuUOodbrvm6KWYhuXjNp0zL+vCySmnxgiS6/TU8UQAJLha?=
 =?us-ascii?Q?lD2X36R/rJSC1OA2WuJiC329I64AEqEQ55WhH++aUxMTE+7ifsWMoZJfEVQI?=
 =?us-ascii?Q?4AuiOQGt2ClNcqlzY0NCblMws/RgilEroNhQy3no2yvnxW5UNbn+O8s8LiAi?=
 =?us-ascii?Q?dcj7E8UoafYFT8PywiIFPVy34NpA8Ai5YpViatbvvBLS/DLF6tbZPOYHQQwM?=
 =?us-ascii?Q?GeuHTBFmsWyHWZB15fXUK0A2CCPu9gUK0oQMuiNtnK83rBkewmzQ49HO8AQZ?=
 =?us-ascii?Q?W/RTfubJmLdHZPDzDpdVd2PK7tlJcAhneU5rht6F0oHsb1jKSi70pn+xjks9?=
 =?us-ascii?Q?aTVc6D0esjVq+n990NpEpTaNgGtc4MOvXeeB0U3GoaKppuFJLgUcB86IGCGr?=
 =?us-ascii?Q?WcToEIx33Pr9DVWN+JF5PoZ+SRTgDFiobBp2yKCGkc/uxdPpeAkNtksMK8+W?=
 =?us-ascii?Q?fNEbpp8odmhtiAIxsE2DVGyXICxPmegaNVUeHW+3+fsBkth2peMqSZcA5dYQ?=
 =?us-ascii?Q?4t807nX7CGS/J9gWsCj59ZyoDTgwAQIJg5T552EKRPw2ABjpeGUztbWmb3sW?=
 =?us-ascii?Q?Mx6+GLwyZOwqnl6yIFyvBg6bu4oyuL7KeaeW6wVUllRRzfLs5ajfTZpvCjYn?=
 =?us-ascii?Q?6qgKp83q4d/R3BccQ7Jivz2BiE90rZCKxbjFhFH4CLOy4JsFvmaKIJaFoFnM?=
 =?us-ascii?Q?ucqpTkTujS3xO5/n7s4i/iM/0RpDxhmCM9/F85KJqzOi7wPmmFX4j/5Tz2Te?=
 =?us-ascii?Q?G+VV9lTKzR8HnMg7ftk6HjAqP5aRhaTJn7YhM3MutJTzAqoTAwy3LdHfEl9e?=
 =?us-ascii?Q?D3KdK4wR68k0A5FwT59cxaZMLtqYMmnQ4A32GLN9+CwyH3LCfsBk5RJv3Ntb?=
 =?us-ascii?Q?xWQzTdvGp2G6jjscE5mfIjjilIJ7P2uU5b4MBbiHMVgcPyVLBFyhH1q0a97F?=
 =?us-ascii?Q?xqmbPBsdPIVpVOsvL/iTqJ9Qiz90/BG2kpNMV99JDFmkPcY+T/o3fFx7jDJS?=
 =?us-ascii?Q?e7JY1wGFjmnRIOiqrV6hHGE29WAKOa+6K2cuzpg2Y+0J4weOZ3qoTwBSHuB8?=
 =?us-ascii?Q?XHbmJqjlZx8r9rkryUqvj1ATPtkxNxZY4cDcBLNAuNiYrJ7gt7CDbYgkfnuA?=
 =?us-ascii?Q?g39+Fx5A6kSbhCYoos8HAvVoM4ME0Sap0LN5Qpva3+6ud+n0/GGtdjDNGotP?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c832771-0671-479b-c889-08de3322f2c4
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 10:50:33.0273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +n5va5gxqP6adZPyL+pCtiWWD+ezuuJZv1/WpznWyXTmkAxR8wt4gYGHj1VQ+p5hs0RhJ8fcsdwDkcC5FZuRRwpOYnL/1fSnok06AU2YFNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6480
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently invoking 'qemu timers' command results into: "gdb.error: There
is no member named last".  Let's remove the legacy 'last' field from
QEMUClock, as it was removed in v4.2.0 by the commit 3c2d4c8aa6a
("timer: last, remove last bits of last").

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/qemugdb/timers.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/qemugdb/timers.py b/scripts/qemugdb/timers.py
index 5714f92cc2..1219a96b32 100644
--- a/scripts/qemugdb/timers.py
+++ b/scripts/qemugdb/timers.py
@@ -36,10 +36,9 @@ def dump_timers(self, timer):
 
     def process_timerlist(self, tlist, ttype):
         gdb.write("Processing %s timers\n" % (ttype))
-        gdb.write("  clock %s is enabled:%s, last:%s\n" % (
+        gdb.write("  clock %s is enabled:%s\n" % (
             tlist['clock']['type'],
-            tlist['clock']['enabled'],
-            tlist['clock']['last']))
+            tlist['clock']['enabled']))
         if int(tlist['active_timers']) > 0:
             self.dump_timers(tlist['active_timers'])
 
-- 
2.43.5


