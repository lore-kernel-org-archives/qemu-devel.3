Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D84BC44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1Gy-0003pe-FL; Tue, 07 Jul 2026 04:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wh1Gx-0003p1-6i; Tue, 07 Jul 2026 04:35:19 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wh1Gv-0008Pe-FZ; Tue, 07 Jul 2026 04:35:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7nGaf9nXILo7s6DApIjkOYwtKWLmTu+F1V13DgewEpsadJ+X33fGX6JUVcLbaIqxYNsDTA/Cli6XeC/gIATnqkESJ7KUWsDWR5bfpX7kV613QtGTHDn9mQDljxDyV5Um+6UdzC+HBOJJSKVd5DzvRaVaI+o+pem0XNiHAqFKFOpOw77IpYu4m0XOvgsVqiC+USBhbR8Skjpe+cHju6TOD3vVJ5iU3KSIfTaVTG5kot8jh3QcAC+IsFUK89YaEw9CNYcQQ9TpKbDhDnK5TL6hC1jfF7N/Y6UY+jjb1zDNPhl6c51/v4wPVeausOUB0VEeKLFg2wUZ/edLFIjNov3sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWvs9s7sq85L72uhb9L9+IWPYobQcvvEI2EZ/k5tnhA=;
 b=RbuyXkx/7dCaTG7byDQI1NeP9g0nXzYay1ClyA+ZQy6kwX6g8ZxkoW/y79Cc/8SwBQ5n1odcSPWqnUOaQ0Qzmg8do7PB4CTKIQlWx3JpwKYAaVUSrpY0rMRCJoqr1HkjllWjr7zDOuZs5tQI0SJ6FUgYixg/xab/nDpHXILP1ISOQdblWfbpQb70lFk0dzSmnzvLYnlajzA1zDFGs6FLg1J7j5zGxJwHcKP4LMHnDk7ijJiZPj4dErFSX1P2bgk64TAO2Gj9/UnSMfZGgsDfsnpHD3IVcIoqlR19G6fN9LTYT3IW3LR+cXTIOpWEbUi+sKfjPuEnHCyxNyvzszeqKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWvs9s7sq85L72uhb9L9+IWPYobQcvvEI2EZ/k5tnhA=;
 b=j8+gkCzGyhCGeDeoLWLUufwgofUrJIuXr0uJ8NLOOxKux7dGN6hWyXjWvT1rsYnMgGfdwjc1PWPCuVXd9jOFIwjzCktihTvHV7jO82oP73rUM4L5tXCFjp0kqFDUt8lB0R068ieawPoEazFGsbyBetl+xqv1ielSyzvQcWjEDrun4xzPlmLlkrfNbunvntUrdDmK0n+C0DtJjpShdskrLaUN7OeqmIY8fAd//VZGloipsu+9eK5z3JG6vaBxw/FrEcavPYUTF7yT0ZPbBk6Ansg9M9tzfDO5hGk/S3mx4P22eyLnI/N3CzdPf2qHe8rFK5pO/d7syoay46aZenj1TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TY1PPF1A8DB1DA4.apcprd02.prod.outlook.com (2603:1096:408::94b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 08:35:10 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:35:10 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 qemu-arm@nongnu.org
Subject: [PATCH v2 08/10] Revert "aspeed/smc: Fix number of dummy cycles for
 FAST_READ_4 command"
Date: Tue,  7 Jul 2026 16:34:27 +0800
Message-ID: <20260707083431.219671-9-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707083431.219671-1-bin.meng@processmission.com>
References: <20260707083431.219671-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0106.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c4::6) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TY1PPF1A8DB1DA4:EE_
X-MS-Office365-Filtering-Correlation-Id: f30326d4-88b1-421e-7d33-08dedc02a809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|34096008|7416014|376014|1800799024|23010399003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fb01RylsLd0rXifIVbmkuacaLJ+0jQHfcg0MGasagM0Z/WJGXxlj99jfTodDDTxOXvcrBq/lb02Spk+1D+AoAt1a41o1GgzgJuulL6M/Skq5MC5azWrJBXTFNwd00MYFKemmrN5DfgG+gI3XJVdHJitEJGmXtoMb8Lx6FtxMIaMsYScvbCPLe4xPdJ1ysfGKDtw7atIEuhhGwitm6cuJSKruYDAKDhuQ1l7PXjRULPfFrS2XldAoXM/a5VCajWLhHDxAiFEYx7DBjdLA73KcewiaiY9ascXQa+3kAJxcSz6q3hgZievxriyqjxjHu+W8paU2gkYhMlnL5WkuFNCMCKTzrraZu5pAgAOArkc2IU5GD4KTuiSR8yDgWxqIQVajrI1KjlAk0v0GFD4Sa6nAeLmhsXDk0nDOyRp7ZLssJ6Il8UrauCVphMsgE2XszbRIgdvRC2+yw/320/pb+UsNCAP81eLM3ihwN804dRl17lQnAeqoOx/7Qj3XwyzOxTOUbScdzZFIY6EvOpmbVZFkEDrDnjc+Qal17sDvoTr4VgSOJUArprqfQUNLyNpez/3YQJ68Yc/iOJgI4AyFRsjf3OLImU+Eg5sxM45/A06SR4/za0kZhPzOUdPpzT7A/jcZMFBqwr14lqLXNm4UnRrL2P5QD9pQPh27X/cGynq79M0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(34096008)(7416014)(376014)(1800799024)(23010399003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WktIZU41SUdlMW4vOXcxOFdQaHp2bU9qTndXenF3MmUyVjZZVGY3aHRyUGNu?=
 =?utf-8?B?YVVaaEZMeUNzd0JrVENWQ2ZlUElJNnZqY2dhVUV6QTg3S0M5aElxeEpOTGRv?=
 =?utf-8?B?U1pET09iOXA5MDRmaFRudElId1dvNkFkNTk4RXNaRUxORDZGN3FLa0tibTRF?=
 =?utf-8?B?eERWdXRiU2doeWFlM0U1OHkySVRONkk5QXM4MDVHdk8vNUd3RVVqbnI1eHAy?=
 =?utf-8?B?T015bHpHNmNiQ2NraGVpSjdrWDlkMXdZMVFTSi9adkp4RzYzTUJNU0lqMVoz?=
 =?utf-8?B?Vk85SkxacEphMjgxSUhOSHhVSDFXVWdyZUQ2N01SQm5TRHRqTGRMejFtZU5U?=
 =?utf-8?B?eDB5NDFVSnNQNEdCQkZ1amU2NEJUNXRHMkdsYzd1Sk92QWo2V0J6aXZEN1Rx?=
 =?utf-8?B?NkExeXM0YnVxajQ5UmhYYi9lK25NV1o0dFR4Q3lJNmdCNHhpQUpJZUVvYndB?=
 =?utf-8?B?bTdXQS9ra0o4OThFTjkrTGxUVFhSU1F2aTJTWEFybGVWZzk2Nnk0cFJTWTNN?=
 =?utf-8?B?MCs0MUtGbTlkR0ZGaXI1STlaekNXN3BYM21jbDVyY2ozM0IyL2ZDQnBQaFlz?=
 =?utf-8?B?TW4xMTlvM1NZL1VSK05kM21LUnVKMVpSRXB1RHZ6QlBBUDZDUUtwbWdUSVcw?=
 =?utf-8?B?MHRVSm93cjNyZmRFZUNNUTNvaGZ0cWFIY1M5c3VzYWdlS3g0OE5ScHp5V1dQ?=
 =?utf-8?B?a0ZJcFF3T3lja2Y4L3FtY2ZNVkhoVHZSclpIOTRnZVVMckVKemQzY05oZ0ps?=
 =?utf-8?B?S2JUOG1CaHptQncxWi9Hc2JPWEdka0pBNjl0cTV0V0RuNUNaaWtxZm85Tll2?=
 =?utf-8?B?QWhLdXFIQVZDeFY2NGVzU1grZGxDR2hadW94YjVKcis5aGtoSDZEN2FEQ2JU?=
 =?utf-8?B?b2l1Yk9TU0xicmJlbnJ3S3A5emtWZlJCc29oK3ZnS3c2L2ZMOUlnN1V2MDdH?=
 =?utf-8?B?Z3pxSFNhckRUSEhhaVNnMnFsemJTeCsxKzh2VkVmdVIrSGYvV0UvMnN2RUwr?=
 =?utf-8?B?WGlMU1lpRVIxMnBZM1dDSWJqMmx5VlRhMU9jcjJjWEVMRSsxSDRyeUNKMWRD?=
 =?utf-8?B?Z1JUTzY4UUlmdXE1NTlPYU1FY0FPaXdCWGMrOG9YcEFBdTdBUkVOOTlsclJZ?=
 =?utf-8?B?b2k5VkV2cFZVZ3NlN2VyWHN5OU1ja01pQWlVUjRKelg1d0lucWNVRFdrUEFI?=
 =?utf-8?B?VVBybUhhLzNNR1V1OWZOaTAxNmJyMjhnQm1tbWhkUmxjeTRuODVUVzQ2S09u?=
 =?utf-8?B?eUtRL25TdlZnOEovWGljMWRnV3lkNWhWWXdvZTEyUjBXc2JMV21yZlpyV05z?=
 =?utf-8?B?ZWFnZktXaXlvK2lySjZpMEo4NlhURHpPVThrR2dOdWdQMnJxelhKbDduSHZ5?=
 =?utf-8?B?ZERCTmt6UXFxM3k0WGhuS095TVRmWmlaZ29vcmx4ZFh3UjZsdFBlRG41dTEz?=
 =?utf-8?B?UGZBYm9hSzdwekphOXJ0YkIyeTE5YnBSNFNvZ0xXQ0cxMUtYZVRiSS9ud0lq?=
 =?utf-8?B?T3pCaE1VVlltNTB2bU9jc2JKa1VBZ0VKMHIwVGN5ajFiRWs5UDlQR29PWXhX?=
 =?utf-8?B?L1ZKUS9mQ1ZOSy9BdHErQkdpK2NkRWFLL2orNGRiRllGNHkzYWl4eCtWYjV5?=
 =?utf-8?B?R240eis3MDFGdThuQ05BeTB5a2dWcVBJbW1ycXpiVytCM0RZNFgvMG4xSEVT?=
 =?utf-8?B?NGcwSG9mV1dFOWY1VWdaVnVDS1prbjVxdzU2amovclVqUExUQU1VU1lSelpQ?=
 =?utf-8?B?SmJEUUhyZHRZYzhpOHFVVHBEcjNiU3RjUmZ2YW93RVU0RGQra1RQZS9sVTBV?=
 =?utf-8?B?Q0pOWC9uUldsRktaMHhmdTRQZFBsT0J4N1Y4bmV5QWlpd2RBMS9UT1RvN0l6?=
 =?utf-8?B?NUZDc0ZFYlF4S0VTRWNiMVE5Z0FGL1o3eG1Ta1lTVHFLajBTVEdPRGYzNTA1?=
 =?utf-8?B?dVVkZkp4VWp2Z3JCRGRQMlFZZCtiMm5lNWlOWUZoOHg0elFUUFNIeTF2SnpR?=
 =?utf-8?B?WVoyUC9oakY0WlNTdG5Pa2JXOGg5a1o3MUdsR0ovYWQyUG9Odkl2aGloME1o?=
 =?utf-8?B?WVZaK1VtaHl2MU9DYWluUE5VcTZRc2toVE9ON05IbTZFR2Y2Wk85ek1jTUtJ?=
 =?utf-8?B?V25CUEI2eHpCRkxpN1ZXa1VYVWdaNC9udWlGbXk4LzdzNGhQdGFxeDVSeHFa?=
 =?utf-8?B?dERpaXRIcW5vbWxIS1ViS1ZPWHhUekdhTVVSdmVTZXRqQ1kzSjdUcTVkQ1Va?=
 =?utf-8?B?VlByMDVpTDFOeEcvMDVtTnhjQU81Z3FKazgzREJjVFZPVkVmWURSWjk2OWsv?=
 =?utf-8?B?bGwyUU9STUtaMER1bjcyTDc2SVBJdHY2dU5oQ3JqZkw4YytqNU5uNUt0S2Z3?=
 =?utf-8?Q?2jGNPO1gSoHL0pMU=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30326d4-88b1-421e-7d33-08dedc02a809
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:35:10.2119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHVnG5SK+hNmXkQ09k7+wCVhApR248NVlVznPddZMmuY/YgAA1rLmpwKn+fJRsmKNeJKdYAQKZ1dLFb4Ozjo4U4d5GiOJ3pzoo2yo40TPFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF1A8DB1DA4
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This reverts commit 7faf6f1790dddf9f3acf6ddd95f7bbc1b4a755d0.

The incorrect implementation of dummy cycles in m25p80 model is now
corrected. Revert this commit.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
---

(no changes since v1)

 hw/ssi/aspeed_smc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 3f957d153f..58e5087b57 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -568,11 +568,11 @@ static int aspeed_smc_num_dummies(uint8_t command)
     case FAST_READ:
     case DOR:
     case QOR:
-    case FAST_READ_4:
     case DOR_4:
     case QOR_4:
         return 1;
     case DIOR:
+    case FAST_READ_4:
     case DIOR_4:
         return 2;
     case QIOR:
-- 
2.53.0


