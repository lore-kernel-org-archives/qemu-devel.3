Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4F4C5478C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 05:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhNOG-00083N-HS; Tue, 05 Mar 2024 00:31:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.shen@jaguarmicro.com>)
 id 1rhJj9-0000Aw-Vd
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 20:36:20 -0500
Received: from mail-sgaapc01on2093.outbound.protection.outlook.com
 ([40.107.215.93] helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.shen@jaguarmicro.com>)
 id 1rhJj6-0005Qb-Pl
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 20:36:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JteIbAeGzVJw5hABYQLSSq/E/fCTzFi2kCifjJw/CWjBpjsB4LJdFCHQMuejAuykvgVtCffWX02MxKyDzSqzytUMhQVXwqfW3CcgZ+o1/zI1ZaapTfIlwmC3jTQjk1LV4Vk3/FqKH/rdRzayUZFr6nBWv1g/X8uBpERUQP/4b8m1/zgb72JRFbsOdB0PUAZOwEzY6KLciMIbItgBAbKVxfR/LK3s2hzpW1b6PH74sZ+6NTtoefvErVYdFoebaERm9FoFz0+6fySCkh7PkAwPxQOab86vUwmVqWUwKUA0mFwl6HtDSrPiaWvcCWVr5QDqnp5qdtELeqgQbUkUjNPdMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9x59Sme2wGzcCWn6bHNaCj2x6brWYO39Zbxxl9l9cZE=;
 b=aYL/xJglwfU6BEE4sjMIxi01lL3BEz/lyKq2C6MGwITzRFQdim6+A4BvoWog3zTfJO/VomAoBwepYGinhP9Mq7/ESmUyIjSjfwCf4ywUiXb5b65wsamcUaWzD56K1KyVbvE9qSm+ciSa1K38noKG68odB8eitAHmgj5OPkmM2lTHwCHmiYa3WU9X1mInUzU+f/UsjHlyJ2LusFn9IVCcPw2eoZtczjkvIv66mLukl3wJaUsxUlXC0OMJcVnjOnWVHBeHad1X2YYlBtIN27n3GQnlNp7tiZKu3NPSC5Zri1MwBQH6wsXyUw51xqES/pVtoQX9u9TcieVaK0MTzA3gWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9x59Sme2wGzcCWn6bHNaCj2x6brWYO39Zbxxl9l9cZE=;
 b=aD4Crmwy0uUM1lMd2ASZNZHbpWNDX5YrzUo7T0a0bdMKho7bIZPyiUvPIRik+H2KNudwH9ROemweXCyVORc7IJqrvhMECUHxdRk2YzwRpVMyRO4RV+x0QHnhJqV2JCUTd5/C1zFjwtRyXN4Sq2rPd91aq0c6HWX9vXLQAXaqgqGM+kYzfOEXJdCOTPyU0gHsgq1ZAGiw/j5dqGAgLyregN/2kqvXBBi+bjzQ9knPtNFlWWi/0r9wVK9tHFXclDICbTTmTAHEJI/R1xr8Aj1iHkd34CPruTI2Khl1x+dvHD3Sdi2xhF6/rHYmWnqqHn2ggfBTX6Xke2Ja/Y7k4jZPPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TYZPR06MB6788.apcprd06.prod.outlook.com (2603:1096:400:44f::8)
 by TYZPR06MB7076.apcprd06.prod.outlook.com (2603:1096:405:3a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 01:31:06 +0000
Received: from TYZPR06MB6788.apcprd06.prod.outlook.com
 ([fe80::a213:42dc:36d0:12ad]) by TYZPR06MB6788.apcprd06.prod.outlook.com
 ([fe80::a213:42dc:36d0:12ad%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 01:31:06 +0000
From: "steven.shen@jaguarmicro.com" <steven.shen@jaguarmicro.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	steven.shen@jaguarmicro.com
Subject: [PATCH] qemu-options.hx: Fix uncorrect description of "-serial"
Date: Tue,  5 Mar 2024 09:30:16 +0800
Message-Id: <20240305013016.2268-1-steven.shen@jaguarmicro.com>
X-Mailer: git-send-email 2.36.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0207.apcprd04.prod.outlook.com
 (2603:1096:4:187::9) To TYZPR06MB6788.apcprd06.prod.outlook.com
 (2603:1096:400:44f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6788:EE_|TYZPR06MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: 514638fc-f307-4ba1-2187-08dc3cb3ed58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vpFr7Z5lWuG6aTmH6XgkW25caart58TOzXR+jueTTs/J0KbMW0/pd3vvLbvDZ9nMoumbwZuw+ukJbGOQAotVzsLQJrseSn8NgAPzFmgNvWSnpJqankYgZWzKAsWeM8ZkpWYsy9r9PR5Nf4opZESMZgNa0PezQH8x32GEqla2ho/mPxHXmw6CelP3oE20wnsDcYAXtOL+a6kNKn+vEu1CdD/FrF8lYi4+LZ+XR0eaPvx7/ehlgWfB5H148Ym+yw0N0yiXtzrr272sE1brq4CMHILNuRwtBA8QjK70iBYi0rDonAYSe6q2c95n5NFjOxToRMONNsrkXDjyXScrkWo/fajZJgXgk+v/xlOOXpMTZPKxvHECpBkEQ3Ef3KA1PIJEpsMVp36io/5YvSuzQIomGWNHVvN1fGNI7dMpw2SUdV3jy8v+yajGNrZZYrlAS39mOkxKG8bRVWbtppIVwK5+oBXVpNv/rky+FReiCGg97lqiA24sHkiSoqlDMzg6XSxx6Jvx8fcZppL/hcQ4js5CgxwCIrgXMh0aO/LWPejKnweR6exFvEeALlIJ19fpASXR8SNbxu6Opmzgm0nNarawj1Cv8Z9Jpu5HunlZSK8EXShna9Ps8w3dMP1uamdM2GmrxHxw1r+4SL7JsNQb3Qo6+Uk8j1bv1sEnYQBGEJt7EyGT+pA30uSisLTDLIvjkoBdjpqVQyLJ2YtowFHmB/1vyiTFWXyNFQDxRs3x+/O7ZYk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6788.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bXldvzdKKE2vBicjylJYavpVdP939pkPz6FkqRR8aaJXX9VZM+GZiHpGYeRt?=
 =?us-ascii?Q?gLQG12f20kEPveOVDqSh8ZEkE32zUrcWGNcg6nyLn8ir3g7pQ18DG6cRh0fL?=
 =?us-ascii?Q?EIJ0dGLafZQVChU1gvedCPT5oda7dRdLLK6cfztFetFGPZk78TRXpC3T61DA?=
 =?us-ascii?Q?7J2sjx9l+b24I5A3okvZ5mfgUvPi/0iKufg5bPWIfUgaoF08AkZ5tXdfKhb6?=
 =?us-ascii?Q?WemZTB9lR7OTDi64Nrc0pdmeO0jsjtDvv6bj1NnbG5iHbsMcHqIps8l7CvbM?=
 =?us-ascii?Q?bY2eWou56cSmcx35Tc7OZf9PAKM0Vcpsf4Kl+ISHjd5EvvFpaI5FBy0AJbxp?=
 =?us-ascii?Q?6UJRdJI4T7ATlBDlRpUWv1lRIfIBVnCJvNK+N2PydEvkcqlvnongvjY8+I2c?=
 =?us-ascii?Q?d562L2tmSGoiFcagwer2kFM3l06buZTDpDFL+QbdmB/5CHQ9MmlXw59h4KtH?=
 =?us-ascii?Q?8pCnRtE+T4Yxvbr18FgrDBsWrd8YbSqkJ9Qx2+OryV/jL8aQIr37EnMvwQ7Q?=
 =?us-ascii?Q?P7jWnoCOzjteFrbBdLRGO+Qff0vahocruc2vdLkTzpBZTndgSjLtu/QCeJ2B?=
 =?us-ascii?Q?6EvG12muPmU1qK4jsDSjsNahHpyPW/LSMKrqrgj/wkvQJi+5otFS7pvQLf98?=
 =?us-ascii?Q?YF/1aAaqruM8MMPnXoOBYpBx32qXrM/z9Y0ELokoL8xjW9Pq+fhgjGK7MsMg?=
 =?us-ascii?Q?C3n0SoZEIoPzzr3/lOYaZftO4+sbNqVaqaokdeDRogP0U8rtfEB6p0v5Re9Z?=
 =?us-ascii?Q?btjdwH0hTIk1DEuyIOR5Qczc8nim5k/OKfCoP8iH+qL9xCyjTr46nSPIwb3D?=
 =?us-ascii?Q?VIvRGH9/4iPdtXPAqS8Q7fU6PwEj/ywmtN5QfPIUEjUsMXG1ZpjLPCw0X2RT?=
 =?us-ascii?Q?O3C8AW0DlzBE4dk+AOqovbYbwSZykbi+sPzS5NZ9w08CA5u+fLzLCOD0ufuq?=
 =?us-ascii?Q?x/NFF14c2hBdxRNACC+MLDcW/T8mvTp3BA4cNMf6F87kNy5SCF7ueDJwQlJQ?=
 =?us-ascii?Q?N5rKCkmS8cz/BstO1KpnlC5JXBdFyObg1ji0vp3EBIw4zEE2HjXH01yhnGoN?=
 =?us-ascii?Q?f37QKd2prdNqoCHid9B75GYr7Zw/RKgu7bflWGpOYygW+ktKU+kvjlvmMfuH?=
 =?us-ascii?Q?azuIFm3pvGwLLWU0zNyrZrB6NGVhb4EnEk1fjBIhTbslOZlnC8PYZyAB/C94?=
 =?us-ascii?Q?y0efXfGO1Rr8fmXVKRoHURL2rca9Zidta5Z/P906JFJcShU96CLC0OcDT9Jo?=
 =?us-ascii?Q?B66FnxRHLUJKmB/EFHiEhTORX/bwQrAFzy330nig/vwvuovvnZv9ppLvxq3L?=
 =?us-ascii?Q?/FJ8i4YeCRpPP6eGs9ODGlJn1HRYZBqoxSsPzE5PjF6ASuOx3091HrN+83QV?=
 =?us-ascii?Q?DAqCQ4KtQsfqcWcaxEhSSn8QG1SMDDXS6Y9F+jZYAf1xNGZrOCmr+cbYK5KL?=
 =?us-ascii?Q?9UKOPzntjk/lNIZ43qhgAufUKm2UQTn6XbJhYbJuVDuVS8df98ViUknZgxH+?=
 =?us-ascii?Q?6LzMPPJCSSNYxw2/mHI005t9IZNk+hxGwWly6SaFxAod35VnXaxOTz7BPp6R?=
 =?us-ascii?Q?qKXdebGDiO2mfobGkCSGJZKZmNXt8TeVZk4XCHvqs2YpJF7AI9udNuX4ie8u?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514638fc-f307-4ba1-2187-08dc3cb3ed58
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6788.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 01:31:06.0306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZ5nBKKgIYW0cOj6lCbsyozeuhe4iQNalfZqT97bctWZJpor5Bhtc2wmCgSz5mApjGBBEGptLesyPiM10DGbaZDLxj8caOKdI95KhClSUaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7076
Received-SPF: pass client-ip=40.107.215.93;
 envelope-from=steven.shen@jaguarmicro.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 05 Mar 2024 00:30:55 -0500
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

Before v2.12, serial_hds used MAX_SERIAL_PORTS(4) for
resources of serials.The limitaion description of "-serial"
option: "This option can be used several times to simulate
up to 4 serial ports."
In latest qemu, serial_hds have been replaced by "Chardev **"
and now is dynamically allocated through "g_renew".
So the limitation description is not suitable now.
Update to "This option can be used several times to simulate
multiple serial ports." to avoid misleading.

Signed-off-by: Steven Shen <steven.shen@jaguarmicro.com>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 9a47385c15..ac4a30fa83 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4129,7 +4129,7 @@ SRST
     default device is ``vc`` in graphical mode and ``stdio`` in non
     graphical mode.
 
-    This option can be used several times to simulate up to 4 serial
+    This option can be used several times to simulate multiple serial
     ports.
 
     You can use ``-serial none`` to suppress the creation of default
-- 
2.36.0.windows.1


