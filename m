Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93918CFD63F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 14:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdU8m-0004Ym-4j; Wed, 07 Jan 2026 09:04:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ross.lagerwall@citrix.com>)
 id 1vdU8X-0004RH-8G
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 09:03:49 -0500
Received: from mail-westus3azon11012060.outbound.protection.outlook.com
 ([40.107.209.60] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ross.lagerwall@citrix.com>)
 id 1vdU8U-0006ka-4B
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 09:03:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ekgeob9TFiCGaL2QsvTfYKTtY2/Qlbm7P29IqxoisgLxK4FPrqJi5/GUM/y+kMToYixXRSqd0mtMawIJryuLPDK/G10UR2WGpWSM7O44/LWR116J67rBmrFIjRHd3NCNzVJfzScoVrjZAmv1De4jJ5IAEdibPe5Ejm8ZJWnfak6I2a8jKx2x32v1042TsxpPslY+Os5CJkUkvecXhVj1rgIwAvjjVmiTSdaHdljY+4DDPwOi9NcOE0aWSxot/CW1mKE1mo1wdAViQmfYQfCXnkShxie1HqmlFfJv2JesOlOfk0DwisIMb2ln4n8JK60dcXBdq2nrQF/rIz+u0grd5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4g+OMB2hoB04Q8s1UR6ygmglzWkbkXoxJ3gcWDOVZw=;
 b=WVJWvE80gNPLnduv+RZEDc6ZcJjcCzJJf1T88ObtBol9CMJlMdk2RnGqq/MMR4o0t5t8pQPt2WpVdrJnEPcURHOFF+b5wH4+m5ZsEUViFT7Cq5Jo6H2TUUjDbw8pDcLbaIPhpMoWNPJkbGnzuu4BIw6i+eW4y94OXKJVaFbHluawCFcSyYgXA1uhmceXXb646Mi0ooEr4/kRzXECfPGFiGysN1UW8df6pWj0Hua470355aXVs6XyMPnVEB+hGDPZ1Df8G5G6kdS7h1FTh6DFT/r3v8nM+KeJZQ1BuC26A4aA4McZn/OXPmOO2aJp1ri3k+lNCbDD7+cWasgHoWd3FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4g+OMB2hoB04Q8s1UR6ygmglzWkbkXoxJ3gcWDOVZw=;
 b=MNxKnhg1qGkduPQHWf3NaXlLjbAbM1RtdQkvyS0WfG5M5rE53YLHa8h+JG0pZbF7R/MD7WmSP9gglBnGc9HYUi4sBQTN7cMdBcyBKWNJWD32MrL5NgJiCdP0EGhxxzuhJ2QMZ0m64QQeOLWXQ9n5ITlaBZtnASa0aj1mchJpQu4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8274.namprd03.prod.outlook.com (2603:10b6:610:2ba::5)
 by DS7PR03MB5624.namprd03.prod.outlook.com (2603:10b6:5:2d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 13:58:34 +0000
Received: from CH8PR03MB8274.namprd03.prod.outlook.com
 ([fe80::ebe2:32c1:d2be:a096]) by CH8PR03MB8274.namprd03.prod.outlook.com
 ([fe80::ebe2:32c1:d2be:a096%6]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 13:58:34 +0000
From: Ross Lagerwall <ross.lagerwall@citrix.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Ross Lagerwall <ross.lagerwall@citrix.com>
Subject: [PATCH] qmp: Fix race causing events to be sent during negotiation
Date: Wed,  7 Jan 2026 13:58:24 +0000
Message-ID: <20260107135824.1681685-1-ross.lagerwall@citrix.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0021.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::12) To CH8PR03MB8274.namprd03.prod.outlook.com
 (2603:10b6:610:2ba::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8274:EE_|DS7PR03MB5624:EE_
X-MS-Office365-Filtering-Correlation-Id: e0aa0721-e136-4d8a-fc16-08de4df4d917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8Uv+PU/4DEtGUDumWQSVUS2gFi9bCW3HzvdFg4vUlQfn415dmnvbyrq8q7Vz?=
 =?us-ascii?Q?dpBwwi3H3+XypAZ3yl5Yi94NTFI3K1yCXoDizXScwHS5M6f9BwvFu9uRnN+w?=
 =?us-ascii?Q?W17jEuHonjwIz20VMVnaprVhqF/y2VvKFQEwFMCdyNLV5sxsvZiP191V+55Z?=
 =?us-ascii?Q?MytUNT/IrQmubhp5aDCI9ViHZGQT5ZXHPwPXI8hs6RCg/e2X7Uy3qPMzzGju?=
 =?us-ascii?Q?ykpOge7TiblSuSBwJdfVPkHy3S4dguy8PA3JSxYYO+E+LGELIhuYcMJFrTpQ?=
 =?us-ascii?Q?1Xo5iZBceQ3QqfgagrtzPMR/wSd5bLzuwmN1icR/869A4Fw6ar+CS7Ikcy2O?=
 =?us-ascii?Q?8ozWzYLSnyvtQwzqfbE18vIyAOf9idOfznFSNTY6acDtdC4HxelR0syFodCo?=
 =?us-ascii?Q?h+EgFA8A0nKfKfJ8xE28znODAOQ4R0tfEfat2Ui1/ewg8UtEG7VMcvzvXbX2?=
 =?us-ascii?Q?IEtdvRuNtpFz9WkRDkLa6d1LO0kJDektqVgjlmblZazq/WBONyuuwW2Uoab6?=
 =?us-ascii?Q?g/zEzQlnLUsNAskL0eyVupcq0OqFuv5Rr70Gn7g399dBRxXAymLTORHTOv0p?=
 =?us-ascii?Q?EGf2i4rt4/h3x+aNIa00cuPVK5Tcu0xnb3Bpao7rrDTA/NbsFlb7PYKMngWa?=
 =?us-ascii?Q?i4E7xo/H07EmmHHzT+LJziX5nugoCkgp2RHsknNCim9cfROK+BrvtMC+W0iH?=
 =?us-ascii?Q?+qi37vPCFbd1BlN7lk0jYIq9FytTLwoNHAFDICgdgpV25Tv0TapT+g5yAGjK?=
 =?us-ascii?Q?Lmg1IyEw0Dy7BzbQk5uKYrS+iOE/b13ioYOOlayRy/T0hZIyU/cHoo53RK2n?=
 =?us-ascii?Q?jiY+F0TwTA/ylP8Px5gLeYZIWk6iKBxNKJrZhe/dDeNxUie5SFi7PkrDeChG?=
 =?us-ascii?Q?JnoYGpIKD8bcPFl8kfZ2BCSqV2xSuOG7ou6Hhogu3QN+KoQs1+EckcqF+5ae?=
 =?us-ascii?Q?ivXkp2bBS2CCun/CyzrPSHOoGvksFYxmJ3GEspvbwSQTruQ31UUc6BmAqz9g?=
 =?us-ascii?Q?S4Y84nO3AGo8lBPTeJfd92JC57BNLIZxfmniNb5G6ge1Ni3KzIyMIvCmu2yo?=
 =?us-ascii?Q?hQ9EA3FAUf/G1pOFOq0hPp27Wkc6Zudw57aa/aS00H+NAkYMPDv6lTj6UKxp?=
 =?us-ascii?Q?wWMjWyVcRCnApmHBEQrYzfKxrv1uHyjMjJ9RAVAgF3qmeqC0K1GoPv5O1/O1?=
 =?us-ascii?Q?cf96kNHLtBe3EERvnBjWwBjnJIW0UhWk1XTloSvSbtiVBpG9yD4Q/61h8LJG?=
 =?us-ascii?Q?4R8Y0XHZeJDEcGnkEJtWGDI+XcMNY6SnqmOohFVZmiwSKbvbNIhjm+g11kGT?=
 =?us-ascii?Q?FNWXTzu+a+qihuN6KPAbRWYmGuCTvgomRB6LrD2lWSWTTHh4NzXZCYLX2xeY?=
 =?us-ascii?Q?aGFFGk44PtaSSHkSlMU0Trbu+JjYMD0c0zMGFow6AlhpPfDBlYbJZ/0r6D7H?=
 =?us-ascii?Q?RaDyqtcjpPgHsMDKzkb+7eVRdVmaYyGp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH8PR03MB8274.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KpM3LKNdoDpz+G8JmLstTHjwN7CCDcSID6Ey/3+g7gFvXkboSkB9dWmuEz/8?=
 =?us-ascii?Q?tHPSqSzR7juJEPIjwxQ3Y0nrakXv6s73LSeH2OLKqWf7u8iNnODKa/0+4puK?=
 =?us-ascii?Q?aQ4IkpnxFKutE8Au+/Iri1q0u2zj1U0WXFPZQuCY9Gl+3v8k9JH89G9P2t7W?=
 =?us-ascii?Q?cUlRqhHZkSSKhLXYN17UXvqt26rn/9AgzuE1lMWnbtS8LEXarTmcmJX8rCkI?=
 =?us-ascii?Q?VldEYj0JquetpekWMZ5Pu0SA0nMGasKbZo2dm3Y+yuHH3dByJ1DDntN+3WEY?=
 =?us-ascii?Q?UQccFXOVayb3sS+O3j8GPPB6yFfA/PcBqH84egDuAJa1Ut9KZfFVPWmf0Xy+?=
 =?us-ascii?Q?G3jbhj6JCyEQFImsFvd5YJWJd6jTE6/JGPId8T0R41w4lnfGNCAaKSEd68mg?=
 =?us-ascii?Q?LA0lBSsqPbQNbUOYlThBxXzaH5GLwnYsFiUWP6aDBqS/ODYk4jhg8YmjTiOL?=
 =?us-ascii?Q?7FNi+6DnJKEgGQUtx0QjmhZk2pyoIaLPiE6vWMfI7BUbwl6Y7EIvZwdaxqWu?=
 =?us-ascii?Q?4DU+0MrdQqummCrPqmXy47o4jfMsWBM/E6o7/vlz9GPdtyoVodwId50WYMvf?=
 =?us-ascii?Q?zyFlQX/Mx9tJs1U9DBR23QkE3jWr1RqGi7qJbFGXHp1y2d1nun84r0TUML1H?=
 =?us-ascii?Q?haXvVVZMiX+NcCa6vywojNrBkx1HIdEFh1TcNm5n099vfNrXB5dlsBCwu/RP?=
 =?us-ascii?Q?PtKRpc75OWZGj/fjmXNNUjsOi01q41UEXbvbtq8DqrEztvcqUmdLu2p9INmN?=
 =?us-ascii?Q?tISYzOlU8grXwb+b9ogFXUT1CbAbfSzI5hDC1vJCfsYhlJs4lOG1Meesvt2j?=
 =?us-ascii?Q?5/FVkRzCWr2+kV5/F2p7StHz8IdHzPoGaSJ5v+Cy3+3KpS76kf8fhM9K3FO5?=
 =?us-ascii?Q?Ia0fv3BqvHAIIbq2yYab+CAv8tcKlAT7uylPUqhNq28U8LVWJ5lM+TbIVGy6?=
 =?us-ascii?Q?/w5EoFNpMKp1lo+IvjD3v9IpDPLydAkZznEqyrZo5eS9cWg3IL6nUvPDWz66?=
 =?us-ascii?Q?Q1IO75l5qJ+P7NJMmCJQpB63QuDpWjRXaQ+6rcV2DDM1t4N66JuqT6ApvTpK?=
 =?us-ascii?Q?17J4dQtqBSDJbP3L4rFvR7gOtk41LUFl497iA3JsTiPvXWwcchdWCic6cdh5?=
 =?us-ascii?Q?KxvrmA5PjjQ7eU1aQZIpFn+zzae+dDciBr8ALktgmtC5xSsAFVmvuC+VrWOs?=
 =?us-ascii?Q?Ja9YDVnemIzVKauTDynap+P8Lh+H7TPpJP278wuz23QjrVUIg9DNX8l5NY9c?=
 =?us-ascii?Q?vY8RMTsaLACv05Yw22X/zZUUrGTkndme7XrTpNz9uXrFz64SYYcg2mVERBrX?=
 =?us-ascii?Q?4nCSU8EepsHqdVUtET6KeveOCZreU1ZDWHeUZ2JH0p74teHioiHNaHrlTrYI?=
 =?us-ascii?Q?A4r2qJbkqZcmG1sKVhZRf/ksGosK8GRIUN1vjjxEc4dlFirbDMb+fIBaVWGf?=
 =?us-ascii?Q?w6rgT5rN2nM8FyMr3rsaKs4kRTyj99PGrebOIEOck+fe3RQ/CJWpGABOkJ3Q?=
 =?us-ascii?Q?yeYyC7Loq1y2ooDMBIJl5x2/ejHGxN/+t0m1HxLrfxZKkkOnslSZNcJWzMaP?=
 =?us-ascii?Q?/k/vEJpzEJSeA3C7KaCJy9w38MfdpGbouL75Xb1QBCDftuG1pICht0bsdX9N?=
 =?us-ascii?Q?BmLcwSr1Q5enjDMr03bg4b3y46asnr30omdy5oNfui1rDf9iWQHcuFpXp7iJ?=
 =?us-ascii?Q?91+ZvpCmeY1ZIFwKZHpQnEKaH4RzP0r++i9ktW+qqaxx47aWm+FuXj6rQaZj?=
 =?us-ascii?Q?TSbeRfCNTG1uJAzUB2J6GRQSqHLpPwg=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0aa0721-e136-4d8a-fc16-08de4df4d917
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8274.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 13:58:34.4323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qSrSfUcsrhoFKpYO5teGQ8QX4AHmrIoX8zj84ROw2OzT6nGqu6bTq7aUAnv4ts8X20teFdwDR6eC2N2uMB7l6NZbNfi/ALj6tH5E+1BLXV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5624
Received-SPF: pass client-ip=40.107.209.60;
 envelope-from=ross.lagerwall@citrix.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

As per the QMP spec, asynchronous messages should not be sent during
negotiation.

The event sending code checks if the monitor is in the negotiation phase
by checking for mon->commands != qmp_cap_negotiation_commands. However,
events may be incorrectly sent from the point the connection is opened
to when monitor_qmp_event() sets the negotiation phase.

Ensure it is always in the negotiation phase when a connection is opened
by initializing it during monitor init and close.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---
 monitor/qmp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/monitor/qmp.c b/monitor/qmp.c
index e1419a9efa39..187a5d7477c9 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -462,15 +462,15 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
 
     switch (event) {
     case CHR_EVENT_OPENED:
-        WITH_QEMU_LOCK_GUARD(&mon->common.mon_lock) {
-            mon->commands = &qmp_cap_negotiation_commands;
-            monitor_qmp_caps_reset(mon);
-        }
         data = qmp_greeting(mon);
         qmp_send_response(mon, data);
         qobject_unref(data);
         break;
     case CHR_EVENT_CLOSED:
+        WITH_QEMU_LOCK_GUARD(&mon->common.mon_lock) {
+            mon->commands = &qmp_cap_negotiation_commands;
+            monitor_qmp_caps_reset(mon);
+        }
         /*
          * Note: this is only useful when the output of the chardev
          * backend is still open.  For example, when the backend is
@@ -527,6 +527,7 @@ void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
     monitor_data_init(&mon->common, true, false,
                       qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT));
 
+    mon->commands = &qmp_cap_negotiation_commands;
     mon->pretty = pretty;
 
     qemu_mutex_init(&mon->qmp_queue_lock);
-- 
2.52.0


