Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA983C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvgvc-0007di-RJ; Sun, 16 Aug 2026 15:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wvgvV-0007dN-8U; Sun, 16 Aug 2026 15:53:49 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wvgvR-0001FG-S9; Sun, 16 Aug 2026 15:53:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hz/Xa6faKgkibtAHHmAzXNgpkWaAhfiG7e6BzeOKDThnuzd0HwBriowFJxfxsYl5RYx89uRnr0LABNbcYyT6nvpgSpdQLZPlok9DXa9MSp5Kb+VAZl7KDtMKj/q6lXWGhagJUAbQzKRutVBNTWRD2UqAI3G15b/Sm4IAhy6PJ+icaKto22bBCOdSBWqej5A7OCNqESPzNTLUlttMmcVF1F32Mk0zM0DHc7ZKIVVbZie+0+ShKnwf9aYCGf9K/9ojxqj6uGT2w5uzQJ1oQWzAtEk9ygkpoVNLpYOBzhhBxWn3d5IsQfAizFPj5NuFOrogT+1XwhgMGmAOaQJa7OTpOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TL8PbE8xk2D0M9kt5sI0fLB5g+UJZj99rqO+u4FG7+0=;
 b=GEsFWcwEXn3eCA7U/KofwEwNpa39YbdIf3naEq907KibO/2R/lWpd+tPOWSTSfjO8Q/mQHneE8X4ielk0cHERkLj7gQzo1d//0VBmOEaoCdliQmVdhSZ7qVtg6RZ4A2A/Qcv0asmAk5piPq0RUuC+N+sMRkrOOpuh79W7TS6nbghxg3hV+7m4ejjlOjOq2CVSWZXstKTOtjpJoNae6X/dtRxBzjCG7lOFEiPV8+TMmcZJSrKf535PBWQOgePqG+FvtgGTKLDTwA5bNRqlpmGgF0woKzoVjaUCofEbN3Zo9YpfSv2nvyCZ1jxyzz3r/07hTGTKDMfCYhGnACH5UZBtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TL8PbE8xk2D0M9kt5sI0fLB5g+UJZj99rqO+u4FG7+0=;
 b=n+GtwZrI3c+qc7ZoyLpX9bKvVN1yWrfy3Af9LAwPpCD21V9Fw8tEwz2PYj2cyku0eqpeDMVy44aX0Jq90vS8o3NDjV3lMk+Xgs6dfpYPY2XFWxERU3hmfrqvid2bELRAM2dDhE0YBTH9niT0Bx2RbBAVayrn4YBOWPuqQEzGy9elEI0fHgCpJPrXBkIycAmWT7GEyJubB9sExeCaA3ubz4nSSLmfFZ5Rz5l5lESpl/Q+8oCiHa+PRbWIxrIDET5/7TFpJsZPlfTUhcp0HkbXrgX5QeZLDSAUHTgp0O0cKjS7fPdw8+cVT+dgz1Epg6Cg0WT2slbHuVIate9pbFA1og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AMBPR08MB532816.eurprd08.prod.outlook.com (2603:10a6:20b:788::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 19:53:41 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 19:53:40 +0000
Message-ID: <39157e0a-9ca5-462d-835e-2e666e27a946@virtuozzo.com>
Date: Sun, 16 Aug 2026 21:53:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/49] tests/qtest/cdrom-test: replace HMP "info block"
 with QMP query-block
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-15-e53fc35bc550@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-15-e53fc35bc550@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI4PEPF0000013F.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::889) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AMBPR08MB532816:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ad60a6-a8ad-45d7-a0ae-08defbd011ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|23010399003|366016|1800799024|10067099003|4143699003|56012099006|6133799003|18002099003|22082099003|3023799007|18056099003;
X-Microsoft-Antispam-Message-Info: aqEij4UU0a5A5l7sZN2CLRBcFb0fgsJ+Lx4gueD7gSFg55XJiZKf+w9EubG94Xhkr1vRwX5Ct5cmauX9fr4pB4YGHWXlg4HJb+Tr5gCZrqcpgRX3UCGgdnxnlKLPtrn8DvMVUtASrdmiJjERD17ayJrOKylizu9B371XMpBzeGfKDzNbcpPMJwoPAF2NIW9Y7ycyYcSO28jKO9EtG78y4nyWXsHDU/IELk2vCCdNy6Z18VweAvNcrC/qo7LWieMXQRfw+GRBY59Vd4ggqBgGxpFzcYYQ8NjzjDN8XDMcNF2J7hFG9Q9bwhrVVCq46XgzNtpsCNJnC5E/MJv2bcFCuMRwSktjuqjp9RAC4jZRDa010GJtqlGyMPDrfAMXg2qOE1dJbOqo0Flt0xt847MGwhPerq/HZfgDBlBtUG4dpeIRf1BQ46Nt9vWIXn+GQHp33axjR0d0UKsEZUud8rX1JAd1DPFirSyw+TcbisMyWYlGiRz8fI90V+ZWxW5UDBEtZqNmAx6FfATXyEXQjNmFNay239TXEzmDav9Bq55l7Nu3WCVXAxFVVtr/i8w4hbAeqxGZC2fJRvw11pC3Jye6kT08tG4ToUPxzmxo8SFglxsYZb8LeQLl7nIvZ8kuLqkLi3UqdC5uo88TbrOn92uijHiBfwJrx/M4Dt+Y1XafxbY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(23010399003)(366016)(1800799024)(10067099003)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003)(3023799007)(18056099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2NuOTRCNFJmRWtxU1VEZXV4SU91elNaYmYwUVV6NThSUTFpYnJnbkxlcFI1?=
 =?utf-8?B?ZVUzR29tcXBlR1J4UWhhNTNpd3V4ZkJPUUtxb2EvdzRnTTBtVWVWMUQ4ZzJU?=
 =?utf-8?B?ZzJsUVpMaFl0MkJQVUY2ajZZYzZTODZqUE1tK2duQThIbkVXeG1CUndCTWxh?=
 =?utf-8?B?ak1XK0ZyNWU1VkowS2xxRXpBS3NuaVJwZDVoMC9PRG9BcTNaSmFleWZhUjV6?=
 =?utf-8?B?cmpmUEErQ3dBTzFIYVUrUzlVU1ZDWlFmZUlSdWNaSVNaa203Y1dCREVJZWJC?=
 =?utf-8?B?QWp4YVI0QXhSN2x1aDhXWWl5Nm9uWHB6aWQwYnJkUHF3T1IxbTdsU0tSODNx?=
 =?utf-8?B?a0EvVVBRN1BwV0ZLRmxnZlE2R3NnUHBiV0FoUGVWSTg3SmNIbXV5SUNoU3Rv?=
 =?utf-8?B?N3MyQXVObFpzaHM0QU9YRCtaY2V5T2hZYUN0bHhiMW5YMlkyV2YveDVESDBu?=
 =?utf-8?B?dFhzbEVJSktmWE9zcHZiUGRIam80VCtST0pwL1pyZ2dmeFRQcUN0ZFdNMVhM?=
 =?utf-8?B?bzZUOWdZWStuZVhNbnVib1Y0K2RJWmV1Q2FOVHVPdGR2VFZheGVrRWNnR0tK?=
 =?utf-8?B?SjROU0Y2NVdJZjNSTS9zWWs4ZWxlUTZvSVRpeHIzZnh5M0pqNy9la1ZTZ3JZ?=
 =?utf-8?B?TGtmMjc0ZnE3WG5SYlp0MVFKSldGKzJOUS9DMURqTU5MWTZPNTVzTTdaNm5L?=
 =?utf-8?B?YlUrM2tWdDhGbmRDaGozSWNER1l0NThqZVE5YmV2aHd6UHZCeWgxMmkvMDZo?=
 =?utf-8?B?RHQrSFJMQXZzRGlwMk9YeE01aGx6LzcwcWRTRkNpRHpNSXhXcFk5UUcwZ0Qr?=
 =?utf-8?B?Z21ZOC8vakcvamw2TVBwLzVlQjB1QUcyTGlObXJtdHlGYW5vdFNrZUxmMi8x?=
 =?utf-8?B?SkJBRUpUaG1EcGVlQ29HQStUWWt2WW9vQnppSjNCc2ZZTStTZFM4a2dWTFpq?=
 =?utf-8?B?ck9NYWxRendMM1pPUXV1T0lJTlVvRlYvUzBhRFpoQ3VJRmdsNEVKMFEzakxH?=
 =?utf-8?B?cmd5eFNCcWx3c1ppVTVIa0xFNEdtM3A4UGZMTXZUeWc5YXh6clRTQU1GU3No?=
 =?utf-8?B?aCtYaVhONVU3d1lNK25BbElSTGRPVmUxOElJeWt4MHZoVTQ4N0tQTEFCeFlV?=
 =?utf-8?B?YURCYkc5MUErRUJxOUdXNXpkakJTUmVVaGNhT25MT1J6REk0akZONTZWQkt2?=
 =?utf-8?B?UGdCV2FabzQwa0I5WUhDdEVhRWR4b0x3bEVQcHhVcVhRUjErNTNZY0p2cElz?=
 =?utf-8?B?M0hCb1Q4QWtqdHRnNDErblZhTXY1SE5lRW9UdENjck8zL0s3TjkzQUZ5bEh0?=
 =?utf-8?B?VjVjdlBoL2RaWmNKNkIzTGlFbHRSKzhzU1c5WkVFTmhyVFUxOHoxcFRhaGJx?=
 =?utf-8?B?Q1laNTJlcU5Td3VjQzhJa3hmYkJpTWk3MmRBM0hTYVNZaXRMS3RIN3gwWkpE?=
 =?utf-8?B?SGNyLzg4MzMvZG9Jb2lyeEgvQUx5UlZFcWdyZjJxb3FEeWJlWVNSWDAxRmN1?=
 =?utf-8?B?QzBEam5VTEl2MDdESi9YdktVNTV3ckUzZnpUM29kTGZZanhDN29rT0MzRThr?=
 =?utf-8?B?V3V6a3ZtelJqYUtlQXd4RU9KVXZvZ2ZPTHlVaXk0Y01qYjlEME5lQXRNeHRv?=
 =?utf-8?B?RmJGeTVNNVZhOGZFNVZCZTVZUWxwSTl6cnJGY2d3MUMyUm1QZ3FBbTVKZmZN?=
 =?utf-8?B?aEZseVJiVEhJeFBLLzFMaHY4RzFFMEQzMThydXl4WjlmYzB0UjRybDEvQ045?=
 =?utf-8?B?SDFnalNHTkN6L0VXeWhoQnovVzRHKzlaZGczSGc5VGd5SDdyNnNDZHFMd1V6?=
 =?utf-8?B?d0trelVENnoyY2lsN053czJuNWRWWFMvS09lYnNseUVFcjY0QlU4NDVXNUZz?=
 =?utf-8?B?ajdjSTZPSjJXU1BqWGpLM0phcmJuV1ZpQ1ZZbjcvZXlpdU9UaG1KMDVmS2FF?=
 =?utf-8?B?b2xTWWFmYjV5ajcwdGlqa1RmKytjMDRPbjByQ3FDOVRaemxJUG9GTFMxTzBk?=
 =?utf-8?B?ZDErSmJSQlFtUjBURTJyVFdSR09taTlNNERhSW82b09HQTlhcDA4RjNOQk1C?=
 =?utf-8?B?ZDkvVmJwcjVKcDlvaGdkanV0bGt4T2lLZmlTbXdLT0FIRXRFK2gwa0MvRW5W?=
 =?utf-8?B?WGh0djBhYXlvTi9ZT08xcnJlYWF5anA0MjBIdWM4ckg2TUl5M3VmNmNWS2VB?=
 =?utf-8?B?UkhyQmNIdDJ5cUNNNnJXVXl0c0EyQ0RFSllOaHFyWlowZHlSelNVZE1TelR1?=
 =?utf-8?B?amwwbkVLN2hOZCtTeXg5alBhTlVIRXF6RWtUVWZqdkZHZVIrUWdXclY3cnZh?=
 =?utf-8?B?aHBuVWRhRXBwbDNvVk43c0ljd09seGtnQVdHZlpxVkdLOFAxMU82RWJIZnBD?=
 =?utf-8?Q?w/vkkhZLrqpMd17UKNMqN9VEIXuOlQ0kFU52S4vfyI4Ft?=
X-MS-Exchange-AntiSpam-MessageData-1: 66A0X3L1nKT1DQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ad60a6-a8ad-45d7-a0ae-08defbd011ff
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 19:53:40.8633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cm+no+aciLyn9qtsaZMaVYQgNvF2dSwIMWTMiHqcQHteBGJ3luufesOKdc6154ILN+asY2kbZFBLtW2bVI4z1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR08MB532816
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=den@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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

On 8/16/26 21:12, Marc-André Lureau wrote:
> The test_cdrom_param() function uses qtest_hmp() to run "info block",
> which depends on the human-monitor-command QMP endpoint. Replace it
> with the QMP query-block command so the test works when HMP is
> disabled (-Dhmp=disabled).
>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/qtest/cdrom-test.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
> index a65854d2bc53..bf997be6d690 100644
> --- a/tests/qtest/cdrom-test.c
> +++ b/tests/qtest/cdrom-test.c
> @@ -14,6 +14,7 @@
>  #include "libqtest.h"
>  #include "boot-sector.h"
>  #include "qobject/qdict.h"
> +#include "qobject/qlist.h"
>  
>  static char isoimage[] = "cdrom-boot-iso-XXXXXX";
>  
> @@ -92,17 +93,35 @@ cleanup:
>  
>  /**
>   * Check that at least the -cdrom parameter is basically working, i.e. we can
> - * see the filename of the ISO image in the output of "info block" afterwards
> + * see the filename of the ISO image in the output of "query-block" afterwards
>   */
>  static void test_cdrom_param(gconstpointer data)
>  {
>      QTestState *qts;
> -    char *resp;
> +    QDict *response;
> +    QList *ret;
> +    QListEntry *entry;
> +    bool found = false;
>  
>      qts = qtest_initf("-M %s -cdrom %s", (const char *)data, isoimage);
> -    resp = qtest_hmp(qts, "info block");
> -    g_assert(strstr(resp, isoimage) != 0);
> -    g_free(resp);
> +    response = qtest_qmp(qts, "{'execute': 'query-block'}");
> +    g_assert(response && qdict_haskey(response, "return"));
> +    ret = qdict_get_qlist(response, "return");
> +
> +    QLIST_FOREACH_ENTRY(ret, entry) {
> +        QDict *entry_dict = qobject_to(QDict, entry->value);
> +        QDict *inserted = qdict_get_qdict(entry_dict, "inserted");
> +        if (inserted) {
> +            const char *file = qdict_get_str(inserted, "file");
> +            if (file && strstr(file, isoimage)) {
> +                found = true;
> +                break;
> +            }
> +        }
> +    }
> +
> +    g_assert(found);
> +    qobject_unref(response);
>      qtest_quit(qts);
>  }
>  
>
Reviewed-by: Denis V. Lunev <den@openvz.org>

