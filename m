Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58595E77182
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLhgY-0005EF-4i; Thu, 12 Dec 2024 06:48:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1tLhgW-00050w-4c
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:48:48 -0500
Received: from mail-am6eur05on2111.outbound.protection.outlook.com
 ([40.107.22.111] helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1tLhgT-0007RB-Ef
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:48:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ak/UwdFDpC5oV7SzpTKx63lJ2JMMVHBZV/qtL/ryvXtEx7gFsZhGvSkNzSaGj7PAjfu8NhNIRPFgzUCLYrkG+n1Zlqdv8/0pyI0Vom6lXQFuCcUq9OTB5rZgoyKe4B1wfgBkF30P2HNbXVWWmImr6nHFImyAEwcLMcKiKvyLfNs7wQVZWooUTHJG029Q71AUrQAZvtbCrKeZASoAnukrYSlQmD0+bfpE3mkdtNtv4R33jhaeaNK6RJUIR9g5JCarovrWtA1bzdvhRRili6PKA1LZni+j1VXMs9hBA3sh6MqdxIGy3ny+ajSSdnZpkxKtJY9E4mWYFIG2UZNozBBqow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/AUyw6I0izc5vBpcNl/iellUdeNsIu08LbIRzGWYlE=;
 b=x530C8KNXtBtV43xij21VugRLz9v/+5cDIR/MrwZNHDw7z+MHEzrUA4CdXXfecbroVkg5ShIuw8vDlrtq4TabhDwO9fwLAESKj++lsSkahrwWet1heiQ3iJpvylzRz14b6eNI+JKDdbLjgMtOjpZrpTzrrzWLy8Ar/BX1DaJnPEdy8t0Tn3B0ZiYnTxuTTr5RetTkLX8Ycxt9hPEGKul8EUyeG08Oet/Lw2oIcv+b4AkmpbSmGgIDVOMQJwyvMCipCjcUhqphsvU8tbUVMBfV5yE/2uO8UomwdrwPug1TqA49yEopjbDoIOn0kPOXmURClWmlIkvsz29+Gbgxb4u0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/AUyw6I0izc5vBpcNl/iellUdeNsIu08LbIRzGWYlE=;
 b=YFTM+HReSSezQSiV2Go4bPASDdcIExb32lP9WKXEHtrBB/zMlEOGHbbA5ayG06WubLz4nttMSF+CQdBRtMse3kGiORHkk90AEry2A6ejChqe6K5qazRSRzLP4ETeDdt6WPYWWtqchPNHpE5F/7fzFETlbbx7Doc9mBgybkQhKrX3K1QNm9Cj73Vdc/du60u7u2J/wgt1DHgmNgps3hHwS3mBCDFKA7w6xFkl6wM7miRbH+g7v9tv3QEbgj08VV7sF/u2cQMoWp5m2sekhxCser6WLetk1Ldg83ZT/Y5GFW5YsukKnM1ZyNbVzoyfVfOTDV3DQahEnuqg08kxcQUmIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by GVXPR08MB10449.eurprd08.prod.outlook.com (2603:10a6:150:157::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 11:43:35 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1%6]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 11:43:35 +0000
Message-ID: <ef5adde7-5fa7-4481-8a9b-d67dee112aff@virtuozzo.com>
Date: Thu, 12 Dec 2024 12:43:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] parallels: fix ext_off assertion failure due to overflow
To: gerben@altlinux.org, den@openvz.org, stefanha@redhat.com,
 qemu-devel@nongnu.org
Cc: sdl.qemu@linuxtesting.org, Leonid Reviakin <L.reviakin@fobos-nt.ru>
References: <20241212104212.513947-1-gerben@altlinux.org>
 <20241212104212.513947-2-gerben@altlinux.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20241212104212.513947-2-gerben@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0050.eurprd03.prod.outlook.com
 (2603:10a6:803:50::21) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|GVXPR08MB10449:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fa85f7e-7ca0-4bd5-fb1d-08dd1aa23618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?di81RUlpaDdIcVI1Rk9JNHQvWFYwTkRrQTBmMkx1UUhzbVNpZFZjZUxETks5?=
 =?utf-8?B?RnJyWlNDOTY4MnBpQnIwMVFwcnNBSnE3V3QwSDFEWHlaYWFlVEhwZHVmbE1l?=
 =?utf-8?B?KzRFWi94RU1EVVc0WlJGTEtrNWRNemw1d1BOWjBLazBCMTdHMXBEOUswUXI3?=
 =?utf-8?B?ZTZuOWdpWC80bHpoUUdDWGVvUUZMc0lqdjBONjI0alBNdjNjdzFHK3lCdHQ0?=
 =?utf-8?B?RkFMT2VZMzNURnNhNUtPZ25UQURMeVFNZnJWblJwUGVpb2JLUit5bytBSCtK?=
 =?utf-8?B?b000OG5ZNEkvcmtEdHVHUGxaRllncDEyZGh3eExIeFpBS3pxZDJSMGhydXdw?=
 =?utf-8?B?VENTNUFvUzhmL2h4ZlVOMHZjVDAyUXVucGRuNy9ONTBWR2hyN2JlTlR2VmJz?=
 =?utf-8?B?RzJuZnM1Vm9TYWVQaTZ1TXZ2VkpubVltbnllWldJSXlQRHVJMzJsWW52VmtN?=
 =?utf-8?B?YjkzRGVualk0Q04xbmZNQUhjOE5la3lGUnZEWGlrdHUzWHgwUXRacjRCcnVi?=
 =?utf-8?B?a2xYSzc0NXVlR2E4d3k2N1JLOVpRaHRHdTRFQWozUHdDNTlyaUdudzVHaUs3?=
 =?utf-8?B?YWo2QjlJWUdxU05aak92SENUZVBncXlGL3ViKzY1S01DazU5WnprRGEveDlD?=
 =?utf-8?B?bEZXMnB5b0lqOGd2MlNYek5SeEtlaUFlSGdNWlVuOVlaUGJOaE5SL082TkM4?=
 =?utf-8?B?K0xacDY5VXRCYWowTE81UDhZalJwY2JCR0hqM3pKVUhwRVNvMC9zQVJZUUdl?=
 =?utf-8?B?RXhCOFBCYkJJQ1h0L1hXOFBZcUJDMzVNR05QNnBVUVNhd01jTTd1UUE1Vi9S?=
 =?utf-8?B?ZjBzMkg0QnNwY2hMZ3dDWkw1SFFMQ2h4VUNBVWNNMG1RV3RYMGFxREZ5Q3l4?=
 =?utf-8?B?UU9UNWs2MnNhbWx6YnhvdmFDVkp1MEhneTVPeE5hL25EckRER1B2dTcyWVZZ?=
 =?utf-8?B?dDJXNGJpZUd3M1pwMHVEcXhEVDBjYytRaVVGaVp1TkRLT29OTzBJRnUwRURN?=
 =?utf-8?B?MlVlTUxIUnE2NG9ZL2E0bTlTSWFPK2EzeHZ4cmtSa0NWQnBJUHk0bzNWOFhT?=
 =?utf-8?B?OGhGMGhFNFJXazRJYzdleFZrSWY4R0hFRTN5NFhZbWVDRHNwU0hETTVxa0Qx?=
 =?utf-8?B?QWJyay9nTmdPazJCdXJPL29Mby9qdUQrRkIzSmNIUUlucjZrYS9Ya3FtQXhG?=
 =?utf-8?B?MHRQNkY3b1FSK2lXQUFXK0d0NVJvNCtWczdYZGg5UzV2QjJ2TFl2Zy9FU1Bv?=
 =?utf-8?B?MEl5c1lzOStNRWlxN0FNVXdUTWc3WDMxUnhvaTRraVhtV0lTeUdINFp5VWxq?=
 =?utf-8?B?R3FKS0xKeHloU3hXdFNwYVdoU3lwalRwdkNFNTV3N1JLaFdHT044Q2QwMnox?=
 =?utf-8?B?ejVzZlZoZzlKU0dpTGJHbFlCZUdWWEdWWlhvcUlINW5LcGVyQ3FXeDNucEs4?=
 =?utf-8?B?cG5qN20xSG5EeXNwaUFBSkE4UGxGVVRwK1VvL3g1TDhKUGdZU1JUQWxaaU5n?=
 =?utf-8?B?cm52S3lVUFU3cFdZQ1BROGZkd1pGSGY0N3hoM0tHVWZxYnlIU0gvVHZTQmsz?=
 =?utf-8?B?V3dMeURGbCtGNkhFYnZKaHViVXg5NHhjSjdCSFdzYWdWWm5xTnFLUjQ0aGE0?=
 =?utf-8?B?RHhteWZCOWpnRE5jWGd3eU1MMmFNYXlDUXB4ZGF0bTRXUm1rUHB0L2VUUDlG?=
 =?utf-8?B?UTVwcWRSZXNoemdpWFlQNWlUL0FOTVRkTmdSdlltd0N1eExLRW9xR2JQUFV3?=
 =?utf-8?B?ejlmWlFoRzg2ckttM1ZIQzVXVFE2bmk4dkFNOG56SG0vZCtFL2VsM0daUS9O?=
 =?utf-8?B?ZFFNcWNMMko2UzNWSnU5UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGRJNHlEeWlQN1JUY1JnTVF2OExiVk5IQURQK1FQNk83dTVCb1VSNzlyVjd1?=
 =?utf-8?B?c29mYiswK3grZ2hqbGw1Z1FYaWw4b0s2ZnlhWUoxSGU2NzdWMGVrcGRJNE1i?=
 =?utf-8?B?N0hIL1BWUjlhRlROMHJQNTZwa2lvM2dHRHFSN3crMVo0bEFHUEpoVndxQXRa?=
 =?utf-8?B?aExuVmx5ZkEzMUo2U1kwcndaek8zaTcwMUg2ZFlLb3V2My9OTnQ1WHFzMU1p?=
 =?utf-8?B?WnRCSkNHQ1gyRnNtcFpBNjBZd2wyRCtQaFVCVzBQS3o5LzI2YmUzeHo5VHhz?=
 =?utf-8?B?SFRDb3N6U0crMkI3Mmsybzl4cDNlRUNtaFlRZUU0aEppZFRzYVlIemtVdms3?=
 =?utf-8?B?ZWU3NnVseWtNK1NwcmJUVE80aEVFb1cxaEVaVlNkald1SjhIdG5UYjMvUENp?=
 =?utf-8?B?azR1U08rVDB3VzFzd016ajVSMWEzc0lFWkQzaDVaZ3ZBalp3L0Jzbys2ekpF?=
 =?utf-8?B?bW9lQWQvYmtsbkZMU1VaTlBNeUEzR3hTR3hUeXJ4VG54RU1wd2VSTDkwVGZK?=
 =?utf-8?B?MjY4R2lOOUtIVUIweG90THU4cnpPQ3VoTEU1emxjUjRoOXJweEpIK3U2RHZz?=
 =?utf-8?B?YkEvakVvdDdLakRsd20rbzE3cGh2OU8weWxjd3FRRjRISU9ndzhIb1JPeWZS?=
 =?utf-8?B?WnY5L1djM0hvUlhsZEhLbXpURUlNb24reFRHZ2NONk9LRVJPSWJNLzJQWnZq?=
 =?utf-8?B?dkZRMTliQnNnV2JlNFdlaUZtYXhrY0VtMXRrOVU2NkVpemY4bytwRGlhWVpv?=
 =?utf-8?B?ZFhJK1ovZFl3cm83NDgxTTZBc3JzaC94dUtqQnZNbnJWekJTN053dXdrTDlZ?=
 =?utf-8?B?UUpuRWpmRFJ3QjJZT0wzN0xwN0s1LzlWUERNZ1FrUE83MlhRTFcyQ2JRd2M3?=
 =?utf-8?B?WCtYWEp2KytuNUJ6ZXFBbFBqTXlZTkFpMWhvc0NkN0dSaFF3U1VZNEVreDFY?=
 =?utf-8?B?MzM0WjdDMk0xVDMxNWlvWWZpdXYxdmlXcmZCMkpWOXljR0llZ1ExNGVlalNQ?=
 =?utf-8?B?cDRTQVdTYmFoUG5PMkhuRlhoM1p1SlV0TFBwRjVNbUo0ZjhIQjJ2VDNLSldk?=
 =?utf-8?B?Tmp2dTRuRE1UMnh4TGgyeUpGU2xyMHBpeHVXU3VKWW5OL3FmVDByZWFUbkNJ?=
 =?utf-8?B?ZU1PRXRqTnpHZXFpV3ZvNUxqYWlQbm8za29zb2FjTGYrd2xHcU1kbTUrZVRy?=
 =?utf-8?B?QzJZRmlmQ3AxYVU1bnJZa29DNk5BWnhTYmVOSUY4NGh3SlB3WU5kTlhQRTcv?=
 =?utf-8?B?dTlqczZ1enlDcTZVWkdicjZVb1FTak55UmZ3MVBPdHNwZnZSanJuVmR5SW9j?=
 =?utf-8?B?MkFsSnRhSk5TTFQ0Zy9zMzZUdERqTTZFTWtpRzFLNSt4RnRNRlhxWUN5NnQz?=
 =?utf-8?B?RWxPRlpQRTJYNGVYcDBaRmk4QUgrTU94RXBsdlZBRUtSYzZPU0sxVk41Vkky?=
 =?utf-8?B?TGluQVM3RkowQzhGRGxHQVAzVmFTRFRMRU00a3hoRW4rZTNEbjFjU2dxcEk3?=
 =?utf-8?B?YWgyV1ZOYmVTOG05bExSR3Vyb3Q5STlzc3lXODgrR3BOaGp4TGJldXIzZnhT?=
 =?utf-8?B?U3pTVW9nb2p0eUxUZUhNNnUrcitZNDJCZTNLZ01KSkdwb1lwazRxM3MvcnVS?=
 =?utf-8?B?bFdBWjlpcTA3blRWTk9sczVJZ3RERXBJWitPdTlRMmZTNWJkakg5UXd3RWdM?=
 =?utf-8?B?L1pqVEpFMzFHbUVxK1dzbzFmcWpUVEpFUWFBNjVkb1dXbDIreXhrUmJMU3lD?=
 =?utf-8?B?UE9tOGIra3RvYXZGNSt0OVFWOXhQQ2tGeUlnZFczYVd3U2lxUU03RGNIY202?=
 =?utf-8?B?MGpNNFJmVkxmdnBpZzRmVElNV2cxZHN4WXpzOGNzd0pBN2NaNWpDaURYMmpW?=
 =?utf-8?B?TisxUVlrbGVnbnZsV0txSjRtL0QvdXEvTTN1NFl3dkNyd1R4NU8yME5OUTYx?=
 =?utf-8?B?WTFXOENmODJNSXRMSExYQ3ZzU3ZLSUg3dWxZTnNKQlVxRVJQbzI2ZUxEQSs0?=
 =?utf-8?B?dXlBNStSMmU2eVRRREVTWHVjSjV2dXYrYVpJa2dZSkV6Y0JUN3JTZVdDQUo5?=
 =?utf-8?B?Y0gvSHVLdkpVOVQzOTZnZlFSdzN5ZitQSlJudjJJbUpXbW5CeUlsZXY3NlF3?=
 =?utf-8?Q?EAkURl5XhM2qaPk+3tprP1EZG?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa85f7e-7ca0-4bd5-fb1d-08dd1aa23618
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 11:43:35.3247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dezM4iqlfMET/gOuiTPwnOwpIrrWpAgpZmQBBogEzZT+g8/ThJlD6rMn1ioj0LESSnayjwsEBlDv6SiDvo8LRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10449
Received-SPF: pass client-ip=40.107.22.111; envelope-from=den@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/12/24 11:41, gerben@altlinux.org wrote:
> From: Denis Rastyogin <gerben@altlinux.org>
>
> This error was discovered by fuzzing qemu-img.
>
> When ph.ext_off has a sufficiently large value, the operation
> le64_to_cpu(ph.ext_off) << BDRV_SECTOR_BITS in
> parallels_read_format_extension() can cause an overflow in int64_t.
> This overflow triggers the assert(ext_off > 0)
> check in block/parallels-ext.c: parallels_read_format_extension(),
> leading to a crash.
>
> This commit adds a check to prevent overflow when shifting ph.ext_off
> by BDRV_SECTOR_BITS, ensuring that the value remains within a valid range.
>
> Reported-by: Leonid Reviakin <L.reviakin@fobos-nt.ru>
> Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
> ---
>   block/parallels.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 9205a0864f..8f2b58e1c9 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -1298,6 +1298,10 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>           error_setg(errp, "Catalog too large");
>           return -EFBIG;
>       }
> +    if (le64_to_cpu(ph.ext_off) >= (INT64_MAX >> BDRV_SECTOR_BITS)) {
> +        error_setg(errp, "Invalid image: Too big offset");
> +        return -EFBIG;
> +    }
>   
>       size = bat_entry_off(s->bat_size);
>       s->header_size = ROUND_UP(size, bdrv_opt_mem_align(bs->file->bs));
Reviewed-by: Denis V. Lunev <den@openvz.org>

