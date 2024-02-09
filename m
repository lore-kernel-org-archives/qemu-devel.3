Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132A6C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 06:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYKLn-0001EE-K5; Fri, 09 Feb 2024 01:27:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Aleksandar.Rikalo@syrmia.com>)
 id 1rYKLl-0001DI-2h
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 01:27:01 -0500
Received: from mail-db5eur01on2091.outbound.protection.outlook.com
 ([40.107.15.91] helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Aleksandar.Rikalo@syrmia.com>)
 id 1rYKLj-0007ay-GR
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 01:27:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ort2sqjJMZqrLi2McvD82z7ax4R0yiptlBLUxduBGxhi2qn53An87umdaw2T93yJCJXhYWNUJhuPpkY5LMJmDo7n5/OAfgTxIjbwNl3VMcqjaFXRvsB2cx8wtvVBdT+bm3oSBGDh52SsOr6fxpp+XhUmQYMHq01G3IFBYY8ADNpHl9C7vd+Fwb2kZdCmZleLMB83y0NcG+DeZGGmzhKLT0gpN+HwUoACoAHyVdNWM4X8vpB+H7MkNPm0RwFQHaal7Y3zZ3m5+sbdR/XHDkRaMPFsm1xJXBwAdoIx2Wp68OyJ+lgHHgPdMObGoQQzgpDeO+9HRyp36q6Apk7lxijOIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYe2QG2Xq6Y0EgJUqCB/+2Ei227UTV00VWP96efUisI=;
 b=bb8s6POY6afTzGkde0qTCvi5PYry+8CYL92LEkRW3SMHWNvt1DhWwnGbNThE0AdBRIf/GPIfcu7mO5fS/P61vtgep0HzlzayAErkseAGSH8etCHAo18LYcn5uPSynXegNxdpainB3xyKpvUYAszMENGTGWqClhC6NVCj/PW1Qrn/P1gujyjbu5ylbvhn7JRZQZ/lhYXwUBDxK5l8IfzcD2PhiU9qu3iAmyrdI7NUkWaN5MJZpU5wOQ9ortwnDuUcc6klatJT4F+4AgpdivAUTckL8xtNty/kA0A3cy1k10PTOAoF6RRqOC1754BDaM3VxO+MI7zR8T93keMKF5pHKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYe2QG2Xq6Y0EgJUqCB/+2Ei227UTV00VWP96efUisI=;
 b=Ty3ugU5GAdgh54Vae/3Nn2PvNHVPwizPpuk1cUHYdVwBPnBZtbIrxn4aneL9/VPa0XpbbRO+c6YVnCbgOv82ZuwoCbYEzinYw3bdpIDlvzEzd8IEyo/jKw+TKWPfYIcJpODnkqAoUz/8HtLejDGoaiHKLe73RlDl+ySzucRNpEQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB3832.eurprd03.prod.outlook.com (2603:10a6:20b:18::33)
 by PA4PR03MB6877.eurprd03.prod.outlook.com (2603:10a6:102:e9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Fri, 9 Feb
 2024 06:21:54 +0000
Received: from AM6PR03MB3832.eurprd03.prod.outlook.com
 ([fe80::ffc7:932b:8d75:59a4]) by AM6PR03MB3832.eurprd03.prod.outlook.com
 ([fe80::ffc7:932b:8d75:59a4%4]) with mapi id 15.20.7249.039; Fri, 9 Feb 2024
 06:21:54 +0000
From: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH] MAINTAINERS: Update Aleksandar Rikalo email
Date: Fri,  9 Feb 2024 07:21:47 +0100
Message-Id: <20240209062147.62453-1-aleksandar.rikalo@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0158.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::15) To AM6PR03MB3832.eurprd03.prod.outlook.com
 (2603:10a6:20b:18::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB3832:EE_|PA4PR03MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d4b9a82-2ca0-42b4-8a14-08dc2937692b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /JZngGcpeYekxo8TAkt1P26JdFkf92RG3uy9uACV8im2Z7h822c5Pw/bMCreSVux+ytYsr7y9jc1t8n6Iz8V3JfwVYPMNnGlPNHGh88a9S6ojQ1MVnGxrQ06v/vUoPWn6meECCdwDpOUu2nwnKiBg4/YCWjGIjiKe4mf+Sykazza2a3ozIhS0O+5JK61tFHPBwprPFAb451sLDu+3ZRkJxFif9tHfq6I+Xms81xLxJmfxCm5WBSiV4VMZ8GJZNoZWpY74viYYG8zMEo/5oVNXH5hVGWOCQRwbeWzqneePJ7NtDUHDtRWdygkVGr/1LIofglaEG1mhxjZrLx9ROnN7GQuXVB8wsm98x6DG/fMzlRNfhPhepP0dxu5c+VHMGK1ADW04XQMT62+5c8jYTOkuPGqmU/kqPQzExMCy8UhfG6VQ+OYWBmvvYyLAVE0KlT5W/AkfcGEMRPut8Zra85IMeVLST76a+cvOy0A+kijhsiKm0nlXipkpyHTT2RlqdMOLGWSeSWUW5mwd5WITviXf43E7QfVu3zcrJ1zmAmPD4QgnCRrzMW2k/SE9xNIZuTnYtQeHe9CGFoFsz2nGJC1HAOylJdnu26VvF4N7k+6sB0bdmQDtGsIQZJ9fx1ych8r
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB3832.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(39840400004)(366004)(396003)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(44832011)(2906002)(5660300002)(41300700001)(83380400001)(38100700002)(1076003)(26005)(86362001)(2616005)(316002)(478600001)(52116002)(54906003)(66556008)(6666004)(66476007)(6916009)(6486002)(66946007)(36756003)(6512007)(8936002)(4326008)(8676002)(6506007)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVc2V3ROTWk2cGFpYmNmdEMxZm1ObUhvQjRwZFk0bERoUHdXZ0llaVVxekpa?=
 =?utf-8?B?Ni9WdkZRYjRFSm1ydm93c1R4S3ptcjZoMC81T3J2b1NLekxjSkU5cDdMNmhO?=
 =?utf-8?B?MG5mdFdpenhLTjFiblA0SGc4dmJwQk1jL2xPbjBVcDYvQ2NmT3B0RkU3YUUr?=
 =?utf-8?B?MDlNRkZRcHpwUDFZbExEVDZKVmhRMFF1dllxWjQ5aHZ0SkgwN0tNUHgweHpI?=
 =?utf-8?B?dnl1UXhwQ2FlWmMvQ3FqMFd6TmZ5NjBvL3RlUjEreWVHV0M1RjZCcXN3VEVN?=
 =?utf-8?B?LzFENEtvWmg4YjJycU81YkJyb09OVjdCRGhhTVZlZmdjVytkajdXV1JTaWdU?=
 =?utf-8?B?NVZ4OEp0Zk12VWFQcmd1bjkrak5teEtkSGQweDh4R0ZzR3BKMXBVaFdncUE5?=
 =?utf-8?B?aWVsaldoQ2VaK050Y0ppRy9ZNTRKUHMrS1V5L1VFaDNOUVl0TzNYYmRYYlZV?=
 =?utf-8?B?L09KMTNrcEUrSWJLRmZYQ0Rpd1R3bVhqbzZRcGp4c01sSFVHeEZRaVRSVXVw?=
 =?utf-8?B?NUVhdHVLNTF5L3BjK3h2VTIvYlg0MzNQbU9iR0ZvRnh6Q251ZFJETmpYM3Zp?=
 =?utf-8?B?U1h4YTI4UnZwM0pMRkw3UHYxRmNyWVU0eUdoZW55akROQ1RjNlpPSDV4Vk8w?=
 =?utf-8?B?b2ZENkE1K1Q5a3JZSVVmNHJlcjl1ekNTeS9HWjkyZlorMExUQzdDMWZQS2RW?=
 =?utf-8?B?RFB3QnNGa09oN1FrK1IxUDVEazFqZlNkamhLbi9QcG5oc3BISEJMclozOU03?=
 =?utf-8?B?bGFLU1h0d3ZWQ1liaGlueHE2YjlzeUk1ZGwyc2N5SlRESkZkWG1PVU9OY1lB?=
 =?utf-8?B?bTBLS1BtZFZrV0xtenpvQTlNOEtORnNkaDBvUjJ1VGFxeTFJRnFsSWZIVm1t?=
 =?utf-8?B?MnlVMithTHpZR3BsdEJMTm5mSStaZnU2d2hvSU1LTllIb0lzcm03eUR0a1Jo?=
 =?utf-8?B?TVVON1VrYzlxRUp4ZUM2aGlWSlNPakRqUWljcUFLdWFCTmtHRmV5ZWJJcW9R?=
 =?utf-8?B?NUYvUmxmWEh2YjQzbkcwMko0djFCL2NCYkVHbGZRQVRuSXVBbVRobXFmOXBD?=
 =?utf-8?B?V0VxOEVsNlQrL0RHWXVVVjlhMTlYUE00Q01Dak1UZ0owUmR2UW1jK1BqVW5q?=
 =?utf-8?B?SVJoeHFMSlkwZmdyajJza29hUlBmd3Z6Sm1QNmtGVmpDSEFNcWdTS052MFgz?=
 =?utf-8?B?QnIya0ZmY3JBU3JyMEh3ckNBQTE0amF4N1ZaNWFUeTE5Q04wNGFONjRNWVF5?=
 =?utf-8?B?by9QbUMrNnptWW5zRVhuMy9OcnhIYlN2RmNwdU9vbFpJd1EyY3BqNmNBVE5H?=
 =?utf-8?B?em94V3l6bWVYNUVOWTMxMFgxVnMydVlKSnczL3JqMnEwTVJseDlJTlgrRW5u?=
 =?utf-8?B?K2NRbTVaa1hSMGZhZ0ZQcXVrVUNCZ1kyNGEyRDJKbDYvOUJlOUtiRUdOWW5k?=
 =?utf-8?B?Uy95UW9EN1F1NkJBbSs2cGZrdm8zcnNIK0VieTZicGx3YnBjOTdwZ09PZTg0?=
 =?utf-8?B?WEtIZjdNcDdJVE1Ca0hqdjNnNzRzaStYTXVWRWhJbWFveDlCcmhFS0ErNXJZ?=
 =?utf-8?B?ZHd3Y2M5T0hpWG4rNlZjMTJqaG93eGo4emZINzV2Tk4vYW9oVlhWREFvTWxS?=
 =?utf-8?B?RC9vaTZQOW91cC9mRjlnSGVlTXhCNlJkMVdQQVFzTzhRWjRNVDVQT2NJN3dn?=
 =?utf-8?B?NnlxMWVSN21EaVkzSGl0dUNVTFpESjBPb3Z6djZBb0Q1MlZvNFdZazFna2Uw?=
 =?utf-8?B?MVV0U3hEVlJZUVFpaklNN0w3cGRHVDd0bHRZY2pLREdUL3lmZVZHUlBkdzJs?=
 =?utf-8?B?QVorVzZFUWRMYjlsTTlETVdiRTc3MlVsRXlMMUxSZDVyN3NhcGNVRUpPOThI?=
 =?utf-8?B?NGVnSHZmb1lMS0tHWWJDNWpYR0RvQ3QxQk5LTEdrdnVRVUNpU2VHZWhGV3FX?=
 =?utf-8?B?ODdaU3g0K3BFd0tNc3RjTENtRGpoOWQ2SW5sajMrbTlyelNNWXdCR245M1BD?=
 =?utf-8?B?ditGNjVaVU0zWFQ3c08yekxLd1RwSnBUeC9DejNDbDhJNUlWMlNNZ3AvSWRj?=
 =?utf-8?B?d3JkKzhjVHh3bGRSY3l0cDkyRUhZSTYrUmNPdVg1MjF3VmNHT2haOXdsb1Ur?=
 =?utf-8?B?a1VPWUVIQ3l6UDRwTnZtRy9KNDd3Q2hGN00vZkczbDJGRkN5SDRULytyVnpQ?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4b9a82-2ca0-42b4-8a14-08dc2937692b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3832.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 06:21:54.5346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gxOvLcghpaWVnb87Dvn91HOdAQtmrcBqHXo87CDJo2wCiN1AfAi8gxCjMtH4CrA3RZKq/chpiZZlbup/T7fA8M4F+m0xg04WASPl6zkTsZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6877
Received-SPF: pass client-ip=40.107.15.91;
 envelope-from=Aleksandar.Rikalo@syrmia.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Syrmia LLC has been acquired recently and the syrmia.com domain will
disappear soon, so updating my email in the MAINTAINERS file.

Signed-off-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
---
 MAINTAINERS | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2f9741b898..1c2dbbc30a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -284,7 +284,7 @@ MIPS TCG CPUs
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Aurelien Jarno <aurelien@aurel32.net>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
-R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
+R: Aleksandar Rikalo <arikalo@gmail.com>
 S: Odd Fixes
 F: target/mips/
 F: disas/*mips.c
@@ -1344,7 +1344,7 @@ F: include/hw/mips/
 
 Jazz
 M: Hervé Poussineau <hpoussin@reactos.org>
-R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
+R: Aleksandar Rikalo <arikalo@gmail.com>
 S: Maintained
 F: hw/mips/jazz.c
 F: hw/display/g364fb.c
@@ -1365,7 +1365,7 @@ F: tests/avocado/linux_ssh_mips_malta.py
 F: tests/avocado/machine_mips_malta.py
 
 Mipssim
-R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
+R: Aleksandar Rikalo <arikalo@gmail.com>
 S: Orphan
 F: hw/mips/mipssim.c
 F: hw/net/mipsnet.c
@@ -1393,7 +1393,7 @@ F: tests/avocado/machine_mips_loongson3v.py
 
 Boston
 M: Paul Burton <paulburton@kernel.org>
-R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
+R: Aleksandar Rikalo <arikalo@gmail.com>
 S: Odd Fixes
 F: hw/core/loader-fit.c
 F: hw/mips/boston.c
@@ -3719,7 +3719,7 @@ M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Aurelien Jarno <aurelien@aurel32.net>
 R: Huacai Chen <chenhuacai@kernel.org>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
-R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
+R: Aleksandar Rikalo <arikalo@gmail.com>
 S: Odd Fixes
 F: tcg/mips/
 
-- 
2.25.1


