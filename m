Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C247DC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 05:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuOER-0004m7-KD; Thu, 13 Aug 2026 01:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wuOEP-0004lQ-A1; Thu, 13 Aug 2026 01:43:57 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wuOEN-0007lX-CP; Thu, 13 Aug 2026 01:43:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVST7gDFRz9AqdX58LVkW9UMbKtelJyp9jNze0VmOIAG8oYehaDfNEqOoIj+5B+NCsASSxwpir2EFKBmUe5MmFvtBzGnSlBtXZyjB4inuBcPVX64s5hpPI8s1YZ60DKMAdSC0PryX1sTID7cHiiABgiyMZ6/h4bY5OT+LMcURwApEKct/Js+9ST/ZOo+xxXX1mIpKYzx5toLrAwXlYBR4PfR9hXHzZsAae9lvSMkbzAysOkjMVyXlxr3Gos2iJLopVVYz3chdVvcbeVl3hXYWoHYnsw0QpGRlofOMg9vKrgB07bRJdDV4xvr8a91soJ1FgAkts4AKFeYlXn9vYyKpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgYiS3gv31KSZF7XBQK1Hec54cRdcH8Qp+8tT8TXZt0=;
 b=pkhSi/q3xqj6tSWm5Y67sYKAkYrgdDuErJjuayleJzyNEOp9fVuQUrlpD9y2uYX8uU5WsaA9DReXQQsx0cHmWoKN/Mi/hBzxY3nlacMnon9ZhGvItnaOu3x8o0StRfnSZs5UCXRv9NaD/TZ1Qw7Rjq8qEAtEpfmMhd+a/qfT1sioeuvpbFnI3W5RI+cMw8sHylqHMTtpe8nfULfMt7ZoxzBzVeLavNhtb7/+g3IEn4q8E1UsmpQrzwP52CS6Rm138o0lpQPsYeCMQhxn3i7lkPsj3AZHV4dZ+7jM/uO0FisYKbdB7c2U5dBsLAQKk6ouAuErAzhVNXPh7el7tx4NDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgYiS3gv31KSZF7XBQK1Hec54cRdcH8Qp+8tT8TXZt0=;
 b=X4SIA2QTIiXrVd680v3fTQ0WyqajqBHcf9ei1RKfVlOxfzdRmvHnmhYt6tMHBhYlOSoOHikkISqjgnnS5GpeyBHt3qy5ERw6IEy5Luphk+aIGCs7XD+7G7lE2elKsq/HO9bab8gVmcMlef3LBNJAOOCrzQYB/f9R6fCDSf8zFzvOQw3j0puiTbyszDaasN2ItZOGo39fw7SQBBGq8tx8ObrtjUUx9JN/0QjMSxv9jpXCniCjj6OvqMLqBmRkoKCUQn/TrLcqbUrCoJalHsPsCX42+/eO8XPp/AbXypOzScy4e653Yq67OXQZZjCo9VI4JSQxSSCaTe8u24JW+qN6Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TYZPR02MB7061.apcprd02.prod.outlook.com (2603:1096:405:2c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 05:43:47 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0315.011; Thu, 13 Aug 2026
 05:43:46 +0000
From: Chao Liu <chao.liu@processmission.com>
To: alistair.francis@wdc.com, Chao Liu <chao.liu@processmission.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Cc: bin.meng@processmission.com, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH] tests/qtest: remove trace output from k230 watchdog test
Date: Thu, 13 Aug 2026 13:43:29 +0800
Message-ID: <20260813054329.35425-1-chao.liu@processmission.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR01CA0173.apcprd01.prod.exchangelabs.com
 (2603:1096:990:75::17) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TYZPR02MB7061:EE_
X-MS-Office365-Filtering-Correlation-Id: 25388dbb-a92d-4923-1459-08def8fdd7ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|18092099006|56012099006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: padZau33+GrIvDHWN91ZEGhnq15DjDo5/97rvs+GUME8KeOhaMSeyKyUYFHgFjAkGhX9RQYX6vjox3K/Y+7BeS4n0dvaEx10EKhpmgAfU7vTZkAtPcukh+whnM3ALvUa4o9qgRXwZ3eeorPa3wKe13y74TgfvFPap0BqhOvswZDl62jND5oKJXoFHhGAFvAOMB1dQ97bZi68BxsFKaCOUPuaTIRW2d+26acTZ4KElkdfjWk4VLNNvzabdi/4r+mmY8FmD/x4sssftbujcq6Z4tK1moL82T4wQ9tuybFdi+RmY5XdFjL1DGvUBX6h15NHN8U5/3mt3NIzex55UM8V3Ui2fBeQQ37mIaFpgGa7d/uT9M2KLsozRE0PXtm2o285+qbbMaaybMMsCtaadWrE6G0x4tnfoV3GPpWT5E8TwRXmE9GnWXXVU2/Qj9Uw2RGXycsfHzIN53GpnZTXofdvvxfFmWHA4/f27TVSLSesAj6BO7vdbG7c9JiQ6POdq18rgN0rPL5JnF1A8JJhoky1xAhTbW5ioBefmQMEvPwZbB1T6IQ92omhluUMsfhegOYX/dSZKczk13ny8kpSK8XQlfdH4uROAXiqvZdqZx53fpSyvemPQXwBAOxB4Yh4MBFK1JqmM9EFbGZ5CPsDozFSwtP5XjQoOZ34xZMHL+LtR3E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(18092099006)(56012099006)(3023799007)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PQFlolpQz5BOeOuYxDwU16YTZdB7NrIUK8g83nLFJjWf7bcoscXHYM2iv3Ec?=
 =?us-ascii?Q?TOR5l++a9INRRvUsfjLFo0C85t8s2+xhdFASPfPuFaDOub6h+QLz1RR1UpGi?=
 =?us-ascii?Q?n1gg7sPcjDquJlzCcVTBAYod2eyy0Y/bJ1u1H9MF5tyF5qcF0YBTr2YRKDDI?=
 =?us-ascii?Q?jM0OSx/eyLcbbMdZgiGdolQCZqAeGe+Nm36S4sNLueJmUtAgzu8y4qgq5C4t?=
 =?us-ascii?Q?YhLJHkBD9w7vAWci695KDQlQqOFkoZ1QWbu5vb5+du9FHbo4JCCfMsRqE13d?=
 =?us-ascii?Q?wSSETJzqt8FxPXv2gVHO0WEcLvlbXTem+0baSEZ+ABfTmM+uXzvLE+1rMDih?=
 =?us-ascii?Q?LDBkvVSHUQXB56JRXU53mcH2f35j+pYkbo0Y4g69V6b9eWCctglzTUbG7n6B?=
 =?us-ascii?Q?Y9jyOtCCIhnPiQ3g6y5hLjJ/xJ1Ov5ML6sDrxyz+iTzHXBdoZjYTr7cGCpBk?=
 =?us-ascii?Q?iIq3lyPkUmuDHSsBXkDk7tRHMnl9+yx1eH6notfowTi51bjGwxG5ToSTL/bp?=
 =?us-ascii?Q?1qZY112RKK1oYCtmLgp8RMMRtfLdMMYzPmMcVio+TGgWDW3cmZggtE7kLcyM?=
 =?us-ascii?Q?LF5WVwvBaKYCOMXGPit2HDOiXc8v9s8G1nfi5ABb5goxuZVE9h6AXzJhiolx?=
 =?us-ascii?Q?UB3Y/WKinROI+MRW145sNf4yZ76Lp2lnBX6SaGCqJGBQAkxpXoeLdDRZEOAc?=
 =?us-ascii?Q?spFBg9s++rVEb/iLS3eUyXk2yWLkJQYkbOVINJZFEpyKsqcL/OugM3McROTT?=
 =?us-ascii?Q?95ldISGDrUiLzbJBuI/nJBik3+0sP4V61G/nSIusQAKwiVghogpwYCYs7NLD?=
 =?us-ascii?Q?2T4A+TiQRmG6loSd+CcH0WHW9qWHFdOZz3Jx1xDtlnH7bV3UiANzpsZZeY9Y?=
 =?us-ascii?Q?KSal0BEeWA4HCDsvIsSuCcXp0SloAufiv4UlZgqlK0Te4qkWbS5Kai144tzE?=
 =?us-ascii?Q?kUfgxhaL2Bh+Ie2gHju7ayzbBYOoTeog6MedLJsoP9cnUYS+dICpK+hlYjch?=
 =?us-ascii?Q?Sfxz72Sg8WkIlaJYDlAt8znc0hkALOyHtAAjXoTJ/AFUehF5WnmypyQzyhcT?=
 =?us-ascii?Q?SO153x09YsMAl+OxjNE8j975QOzUusOkm2AmkdMwKHSyUj4N61lqxly6Tqhv?=
 =?us-ascii?Q?50va6/amj8/oA3EhVIcwPMLINAUn2bMyYnpdzZCMbyUiSkFq+JGm15H7q5cz?=
 =?us-ascii?Q?rMFUMphypla4ionPa6NLkO8sqrnZ3mNb5iAZp5IY/OXjYOmXlgj1qPEEtTXj?=
 =?us-ascii?Q?+fA3l8X8cnpxVeil03qMB6nszazk/5zXVzd9M5PJvYy/N3SBGCXdPg7B0yzM?=
 =?us-ascii?Q?/QJ+NEGAr7pnsBAwB7/zQzePMeAYHSnyf8O1vemw/gt/t2Z6ct1N3ivMT5uN?=
 =?us-ascii?Q?BFri5Y2r+JN5J8hDX1cJFBhoU6pF8cEG/jVIGj757MqjhVzwVk+MhXuxYzXP?=
 =?us-ascii?Q?2azL03k/mShTAAoPfgIAoYg3x+Tkf+pBuGYvKuh83xlg1/Leh6244TKWFiig?=
 =?us-ascii?Q?cJLS6tBn9rDCb2E017UoGL4+KCQuDH9T0theClkyzmQT9GJvuqd3uii6P9Af?=
 =?us-ascii?Q?aPR6QE4kp1Giu9VaPyxVOAHdBUEyhe4YSUCgJ3gaMX93I+hfdSmRqJ2nR6wY?=
 =?us-ascii?Q?rG0Dkyc8gxARJMF58F1thEQg31TXU5FXsu++/dEsWoGDnUETix6zeLxdowHn?=
 =?us-ascii?Q?cQeYQ+SsQVbagt5FBEf5/3vfBE81gekDtnt2FxV1mvFKgAVhHi0w6fhm5ras?=
 =?us-ascii?Q?cxv2jYG3agdJIvEd0IT5YUEhmuAwt2E=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25388dbb-a92d-4923-1459-08def8fdd7ed
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 05:43:46.7823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xTf72+3m79V+9w1wyBhkIVMfGVXdrtfMadVEwK0Rd8FOwY1I3vDnU6JxxxBCMHZyDWugjCi+UuQSAFgHhqibS+sVDJU8EIHu5Au2rD/GnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB7061
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=chao.liu@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The interrupt mode test does not depend on trace output, but passes a
trace file to QEMU. This makes startup fail when QEMU is built without
the log or simple trace backend, so qtest cannot connect.

Drop the unnecessary trace option.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4126

Signed-off-by: Chao Liu <chao.liu@processmission.com>
---
 tests/qtest/k230-wdt-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/k230-wdt-test.c b/tests/qtest/k230-wdt-test.c
index c8eaeaf1ae..b1131f42e3 100644
--- a/tests/qtest/k230-wdt-test.c
+++ b/tests/qtest/k230-wdt-test.c
@@ -76,7 +76,7 @@ static void test_counter_restart(void)
 
 static void test_interrupt_mode(void)
 {
-    QTestState *qts = qtest_init("-machine k230 --trace k230_*,file=k230.log");
+    QTestState *qts = qtest_init("-machine k230");
 
     /* Set interrupt mode and enable watchdog */
     qtest_writel(qts, WDT_BASE + K230_WDT_CR,
-- 
2.54.0


