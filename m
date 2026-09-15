Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7690C88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 21:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6aH0-0001Ql-3a; Tue, 15 Sep 2026 17:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6aGl-0001N2-0x
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:00:47 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6aGi-00011o-AI
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:00:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+XbDxXl8dAty1VoBn8OojWo/zlR2TUnp4B9Kr+GpUgM3Om0caDhXGlurPgQ25EKihfJuDb3+Qe00jGbubqwbPkEVjpOTTy1hKdJYeu9rxMWBmnM4w+ToWxjRVp1faIEaVVHxW2KppQLLCjD1P0DqNZu0j+/dpG0BRBvqdT7RVcxV2SCaihMImBMuPiAYQsy/BbLdg8DIIhivwhIdTaldva1rdBqLnjWrfWAtO8Wbw6rMV3RX+iP+9IAMimAxb7U99GoPMYR97mCMDQMolTx7MHxF8+bDHe4xl8b0zSUpL0n/e+1S9PrKe1RGLbtnNAFtpZItSlvDkFocNfNZu7YEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFLHrTXYn30DKBGfZX9XawwQGNuxnOEL0tX4YglZD1Y=;
 b=sbqQAqe8rT/s50ZEdgVwdTkgBqWAe8nMyw7lK7gBlgBvnqyTi5ZUjXgVQZvZ/KrehrYN5/r+da3Qkc44lV10tF5AJSi9WQEZvje4aXc0lmiWVEeEkvoR932hBXcVlB0m2z1SWUC8R/o6PtEaXlfZXPPW138g8Iee091TCDl0oGw6r7wJVP0o6whQugpqOc66NLC9USJeQaHf+DEPbnJGu08diIQ5rvr/aLIQeDc9SoeeY3oT+XkeBdu9gFwAMXJFrJ6p35iZP6OUHAG9HmoWJMf8TFVp5hYp5/SMymp7y2Vv0o6afPFkGa6GCjmCe7DWwAmJhb5sKDz4Xz3n3h3DzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFLHrTXYn30DKBGfZX9XawwQGNuxnOEL0tX4YglZD1Y=;
 b=I8QpdqPrVseadH5galFOismtd2vg7D7iMt/TYdbW6FfoNYW257G6iIQyIprZtyRB1a2Y4wjsiNBs1F0PmSiWTXLl3Je35gR07W1h6PT60S2ffadNRV+4t8y8QP2csb7HsOI09F8wb9zbiNfRkV4kJB4o3SdYFpHV0BBekRAU/ov6WvDDd5KkKq2w389tTLuXMx3j83Ajb1IaZ20sZ9AnF3lGaZ37PMxg1DQu+D2APaVC/2hEGE2jEqhf/XlsrkyN06HN52uBxZU8hJMJOmslZhnS+V+N9z81o+5EBxdZxb3PCnaaAbmLadYGQZTxjOOt2NOzZMVOJo/WOyd+RnFO2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB8708.eurprd08.prod.outlook.com
 (2603:10a6:20b:562::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Tue, 15 Sep
 2026 21:00:35 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Tue, 15 Sep 2026
 21:00:35 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 15 Sep 2026 23:59:44 +0300
Subject: [PATCH v6 08/14] vhost-vsock: fix FD leak in realize()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-up-vsock-vhost-v5-v6-8-4d31b2dc6afd@virtuozzo.com>
References: <20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com>
In-Reply-To: <20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: bchaney@akamai.com, mark.kanda@oracle.com, farosas@suse.de, 
 den@openvz.org, clg@redhat.com, sgarzare@redhat.com, 
 philmd@oss.qualcomm.com, maciej.szmigiero@oracle.com, mst@redhat.com, 
 dongli.zhang@oracle.com, peterx@redhat.com, andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR04CA0053.eurprd04.prod.outlook.com
 (2603:10a6:802:2::24) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB8708:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd3df52-6bc2-49cc-1619-08df136c6305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|52116014|376014|22082099003|18002099003|38350700014|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: Ek/P/r2pHbVmkEGRKStJKLZzRExZNPJWfXIwgy91p592rHCoZr8H0W8I8zGIkvjV4Pd+FpM7bxaRoTVnT7SvawFXVUZICvmY+b7fQteSclCN1/9u2TPrTGdZyjFgvAIucKGWJakgRW65m/MPktGBowpcxzMBrAsAd7BNENheMsvSc5SQjmFtPwKSuV+A1KHTQ0riuHjMDkbjsB02XVl5jJMWjLt0Asb6yY7rtKFJlo9QqchIHcEJ6RcVt3wmgWLQpms25GlK6syLnIX4b8htWXL0ByV3TEdMPD+xZhrRxGFLPv6gctgMJ6e7DEKwylMQPzyjQkTYs6sm7sB/bKrBb2pjDd+rWa5GSKWBv4s0m9T3PAg882SSmNuziKqd2C3w0rBIT/ZLlAiEnbLPPoy+4Db05u8XZhUfxt9V+8J4picT8gaMh4vYqNw4FRi2BYeF4eRzQbcT9qMqkolByee8TYNmi7OLCZYjBPjxCbTxYezqmzxFEQu7SPNfNS9SxlJstKfpIc6bX2g4UU/jdGuCDNb7Ml6YDiej696w5DmMcGqrcc5zZ+i1Tu49o9fAMedxpyNPO7PAwQlUe6x/uoVGTxuEp0zQFmhIG3HDJyPveiLODLQyqlzsTVOMR9k+oX1Gr4RCw44R62QUfLySqwqyflfx7hFHsAkQ7byoZXrRyQwKOiutHuuMMBFhLjjOcwVtgR6uupoJO7smm7Xbt8SLek6nNkLq2pO7hDHOhHccjzk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(52116014)(376014)(22082099003)(18002099003)(38350700014)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlhQTXVSN1QraTlJd2Fma0g0SXVvTjE5U0NDWDM1ZG5nTjJ2alNoKzhhSFp3?=
 =?utf-8?B?MUVpV1RGYVk0Uk5OUm1uMWo4cXExTTkrLzA0KzBTbFM3UDR0b0lLdmsydVlI?=
 =?utf-8?B?eTF2K0RnaUE2dllZZ1hHZjdZK3NJWlVEMk04T1h1UnV6ZVFKOXgwbGpBM3VQ?=
 =?utf-8?B?TlFjWWNzem0wdE9ydmRHWnc0TlpXbmorWXpuRi9oTy9uWk5MTk5seHgvQkV4?=
 =?utf-8?B?L1R4T0VUQUdvaCtRMlNPL2VNVzRScFU1ampEOGFETVg5OStFUWd1TERuWHJP?=
 =?utf-8?B?TWhxZWE1WDVremM0RGJpYUdqYU9Ud2gyNFBjTUwyZXhJMHdNRGowZCtFVEJo?=
 =?utf-8?B?WU0xb1N4K2duWEdibG9uUjhqOGRoT1dkZ2hWMW4rdG1yQVp2MTVBald0YWZM?=
 =?utf-8?B?cjVoWHVTZXhIVU95RWt3V0tTTU9mbTRqVWZDQ2gwOEU0eU96TVViRDdtYTcw?=
 =?utf-8?B?WEM3aVA1TDNrUCtSQTI3M1VTampuaFVWclVSTUY0dGF5WndrUitWcHgyamt5?=
 =?utf-8?B?UEVDaXVmTFpKZVpidjJtQ1ppQ2d3dkJxNW1JUFRVeW1KSkxHd0dPUVhzZFhT?=
 =?utf-8?B?UXNsYlFDUWhXQnQ1UkFDYTNRa0FmcWJkZXkwNVltZVhXV2duK1BYNndGTFhI?=
 =?utf-8?B?eEw0TkQzbG91TFBGMnhXbSsrVGphZS9LN1VBYzd4cUJkOHkrYXpqTE9OR1A2?=
 =?utf-8?B?N0VCVVVSemt4VmNHcW5jd3lpWndhMnU1NGxrVk95Rk5QaVdDRVYxS3ByaitW?=
 =?utf-8?B?Z21uMVBNS1lPc2J6T3BqVEpva01pbldrZXBDNTlMRFdmWldGQXRLeC9HVkJq?=
 =?utf-8?B?OWFCT1F3bDdVMGpRSU1UV2duempyR3RFMlgwUmlNUlB4K1l6NEJ1bHFmYVFm?=
 =?utf-8?B?NDlPZ2pnYy82NU5hZnl1S3pqcFpiNVRSQmErM0VTMnl2Yy9qNTNHNlVRWlZ0?=
 =?utf-8?B?cHd0elQrQXZYa29LNjJDdklFM2c0TUkrZW51U2crYkJLQTBjMklSUk1uZm11?=
 =?utf-8?B?NCtDTHprMHBjdEp6ZVdaUW5NeEJvQ0piTUw2YytobER0dzA0SlA2aklvUjdx?=
 =?utf-8?B?UTVaMWFPUWVjNVRiVEFpUmFJMzd5NjBVeHpEUnNXbFZPRUQyS2hPVDNmbTJR?=
 =?utf-8?B?dHVWOTBESHNHWFhJQW42Zi9DMzRPK1RQL3Z4eUlUWnA3eENtQXJhcGVsRzBR?=
 =?utf-8?B?UVhtcU5ENVhHcGtOclhteDNRbXVSVmtVeVkvbmpGL0FrM1JoMG5mM1A2ZW1K?=
 =?utf-8?B?NFZqcVQ4cHFJUVRXT3RCTUVySFF0dnRhSFhrTmVRa0hma3NUKzZaK1JOdW9B?=
 =?utf-8?B?T0lQYi81RTVaZEVuUk4xSFlRRVRwb2tNSXFtTTlBdEd0SkVlZmxpdnpRL0pi?=
 =?utf-8?B?dTU2TGVBNGFVMGZvdzNISlpVSDR0aTM2TjZ1YWxvcWtRd3RPNEpCaDRPc2pr?=
 =?utf-8?B?U1RmSnYvNWJKMDNzdDRZNTgwYmhEeFFlUGxTcU8xNzI1WCtBOFdaT1dLclU4?=
 =?utf-8?B?ajVKdnFxeUZEVnVja1p1b0UrMWtMNW01TEZ3L09VNXJPWE95NHVRTHB3ZlA1?=
 =?utf-8?B?SVQyQjlYME9pU0lMbFJOdzUydlp0NXBMMGE2eXJPRTlKeE9vTEN4eFFJdmJK?=
 =?utf-8?B?OHFxM1N6WnEvMlVaTE53K0JLSFdZMUhJcW1Pa3loYzFtcnRCb3YxaG5vZFVy?=
 =?utf-8?B?ekRsemxOS2FMT1ovUFoxbHhZZzlvNTRnV1lCcFRhVGtRZnAvNnJ1YzVMMXc5?=
 =?utf-8?B?ZkdzOGRHWlhkTVg0UHYrV28xODlrak03MTc1Yk81NHVSTFM3bTRUYjA5d0lT?=
 =?utf-8?B?OXoyOEJKdEE5UHROWjkrMGZSTlpkNkJpSW1CQTRHTHpEWVRrVmhvM05iTmdH?=
 =?utf-8?B?ZmpMZ3diU1NqeC9yd2ZqaWNzVjJ6NUt1emZmNWxjKzFQTWlLbDRaNTVseGZ1?=
 =?utf-8?B?b1IrYi9Sb00zQmNHS01jeE5VSXNWWEg4ZDE2WFFjazhUK1drVG1OM0l5a011?=
 =?utf-8?B?K1U0Mkx0aWw5M0RwbXRHTGFrVnNaZ0ZHcWYrMkZTUFdBZk02amwveWtVRy94?=
 =?utf-8?B?Y0RZMm9hOG9nVTRQTzlacWNrUEQybXhkRWR0aVpUSzJOUHdodmZxd0E1YjYz?=
 =?utf-8?B?WjYvemNJV0hzZkdFdmI5RDRUTWVMOStIVWRsckRCUlBwaDBWMllMbG96bC9X?=
 =?utf-8?B?UXNib1RTUEE5bTBnZ1pxQ1ozZWsyU0NOM1I0UGJwSjlPT25WZ1AwdjhBdzVS?=
 =?utf-8?B?Um9Tdi9DcnMrUHVLTStJZ2lTSUVYbGpGVjhpYkpsaXFjUVFpQm8zVG1jWjIy?=
 =?utf-8?B?ZExvTm94Z0NVd09lOEYrMkN3UG5NQndjN3FjUTdBOFhxTktWeEo1UkhhRHlk?=
 =?utf-8?Q?NdQC1hfmxSNSrtbg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd3df52-6bc2-49cc-1619-08df136c6305
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 21:00:34.9717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bolR+wabCj9S/qKcJUYbr2etkkEpeLqmvM1SFVYHqlpje7sem4a2idFY5QdEpDQKtsdOnxST9+XUbzhXVCVFlzY4EUH682HZEk0LuFlRepY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8708
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

In vhost_vsock_device_realize(), after unsuccessful call to
qemu_set_blocking(vhostfd, false), vhostfd gets leaked.  Let's close it
explicitly in this case.  CPR-saved FDs don't get automatically closed,
thus it is safe both for vhostfd obtained from cpr_find_fd() and from
open(/dev/vhost-vsock).

Fixes: 384c2561bddf ("vhost-vsock: set vhostfd to non-blocking mode")
Fixes: 701544cfaf46 ("hw: replace qemu_set_nonblock()")
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index c582ac9fcc8..3ec20d87606 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -176,20 +176,17 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
             goto err_blocker;
         }
-
-        if (!qemu_set_blocking(vhostfd, false, errp)) {
-            goto err_blocker;
-        }
     } else {
         vhostfd = open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
             goto err_blocker;
         }
+    }
 
-        if (!qemu_set_blocking(vhostfd, false, errp)) {
-            goto err_blocker;
-        }
+    if (!qemu_set_blocking(vhostfd, false, errp)) {
+        close(vhostfd);
+        goto err_blocker;
     }
 
     vhost_vsock_common_realize(vdev);

-- 
2.47.1


