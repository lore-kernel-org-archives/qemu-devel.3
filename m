Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D552C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 19:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whtzg-0001X7-UN; Thu, 09 Jul 2026 15:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1whtzc-0001Wl-1j; Thu, 09 Jul 2026 15:01:04 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1whtza-0003Fl-8D; Thu, 09 Jul 2026 15:01:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jT2nd4oX0ujTA1DxTEksdn8wVbRdFi3c7Z600UXEus7mGZem6p9vL3TLVTLfELDuifdFEaX4zLvLf3/NGzA7eb3E8YxRag2EdNDBCYOVsoFZmAtCkWTG75kD4IYMWCbRXqbhI7RlB73XeESLpGnJbx8kvRxfdzsdpS59aE2U6nTAiqUzXiJxF2u8v93KMJjBIH10s6qH24ZME2P+KetOv5u5o1bBchHJ2pdLi2iKPBfI2A+oKi4LDUWbAoyKYR0x7q+9AbhRNgm/TGs5tbS+U9roJDFAhEZkKbUNVMfPlUpcN/7F6ykmM2Wyh9hZYX+45Sref7PaToAfxYarw+w5Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qT97eLmzXRVJSf3OZrhNH1/MLn+NNdkp/EraQ05BGOM=;
 b=XXd+qoTYmHYS0tjCA/zxQa0TjfPh8JTF7zMnZz4HC24beEGpLdzlpJSIviim2gjSdFYbs+8zfHNAeNugeitpJhDfwApf60hNVizRQAeYwpsOHw1oCbohY9oBignSRY7P3a0Vb6G4j1/VGD8g5hsao7Dd+EYeKK49F9G+bzHTIxyuwHLK8ipfPhiHlSvLAKwrz5o7CQJS2DX36sBWDTzA2JsJLdvUisRJ8Hb+88QDel/W/LiXKZWc8mn48CUbWj+uVjjQ40zsg0sg4+8v9pMF5D+OByNYhyzEvM8KLwjyBMqD66BMqFbaNkTrO/b8dczylW9ptFcs9mA1tkgUFKo8MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qT97eLmzXRVJSf3OZrhNH1/MLn+NNdkp/EraQ05BGOM=;
 b=bd+m9joe+0LPqQOz8Ljshu7zVUjKyg8bjFUgK3GNVM9XBVsCpLgjCScySTukb7NUn3RcdJNb/W5r8KUH6MKrdVjNTKo5VHuFk4S9DiqzIgp44DWFxaR2+2+DXRr/znpllrrQ6T6HU8qPwUKKDgb3vFbKGqun3r5dv5ApCdtj9I2CLGFT9YGDCTVRo/6usk/MwBOdrouvmkiq7MXZyrErm7HJLrWsKzcf9w50/q5oyz44WrPpqifSC8Luk3PUrs22OTkzRv0eSQ7Ze9wdC9DcxEGdhu1CiYUW6+2XrRS8MrWb3+H+jugtOnZctviYPrdEpduDItHazWDl24Jz2z93Iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by GV1PR08MB7756.eurprd08.prod.outlook.com (2603:10a6:150:57::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 19:00:54 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 19:00:54 +0000
Message-ID: <9cbdce55-83a7-4b43-b3b6-8123d85ab9c8@virtuozzo.com>
Date: Thu, 9 Jul 2026 21:00:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] coroutine: fix lost wakeup in qemu_co_sleep_wake()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
References: <20260610115850.2410566-1-den@openvz.org>
 <20260610115850.2410566-2-den@openvz.org>
 <b87db62f-6c9c-4da5-8382-500adc29b828@oss.qualcomm.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <b87db62f-6c9c-4da5-8382-500adc29b828@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0060.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::37) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|GV1PR08MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: 3486e705-9f59-484a-5487-08deddec6725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|10070799003|366016|1800799024|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rN0d9WExlkjsFMM78es/KDls+AeJrP3Ci6Y2uquoHsOi0nonBE4h9tYeykrseZgsRoKqRgPFqTS8S/eXXlTMzfdr5dJKwQluf3QCtIMe96w4pW/qOnQJk7h/gdBHaTC9n+zhHFq+MEK0BUqEJ1uxCiFXUyuKGUWW+ctjVvqgrG9eBllL5L1kxAYG35Gp8pQHyGRsg14dd2JjL4R0ZiCUpnqXpgfQpI6ysK0RBi1mobpeJwF5o1aRMC5mNTAnHbgMdBVa1t0LxygaLFrQCmF9Q3RX32nV7V9I+l/9LTdUuI5H1ZAobH8+ButxIdknEuYzoKR3Uex/FJb9kW8DZi2cPKU3JCDeeHzRyPstPk23tmYG21cn5FLT0It30oD8stjtPPnq1tWGr+NO0qVilBB7lvQpMFuVwDbf6UEEuyZ8pPlmyuOP6JiVFlvdev13y9JPcBqrTjLRqeZgbbNDVr7NycKMEuy3QnA61Cw77fCl7DIEiSTNIofCofu3MrUw4WSLyQybBwOfG2UQPq61oJ/q4pr+dH9zDzRy3WwTRdklTBWLI/QejZ/o2doj9sUvK/xd4vO4gXDsYYmm6SOexyvWDr7GpkSZb3PrYM9++mgTqUVQsl6ALipL51G3LJ62mRWxceUvw3tWYbyNvTqvi7hOIhUxDIDrvL2NY2WO6wKN/DM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(10070799003)(366016)(1800799024)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qzd1UGgwNmpvZCtlaGd3c2oreWFjV2pXYjhTTDdXYkFvV3NLODZkWE5Ed3FG?=
 =?utf-8?B?YzcxaURpV20zdUw5UXBxK0x0QnlmeDJ6RmhxbC82Q29mVjI4SW9ENm5iZEcx?=
 =?utf-8?B?NUsxU3JYbVIyU3NWZGlmdnBlbm11QjlWeXpBNjhyK21tRlNzdmF6TURXYTJv?=
 =?utf-8?B?SDloV21lRkhwZXowY2RpMFpaWS9iQnN5VGxOR2NBazMwREJZaGhLSVVTaDlw?=
 =?utf-8?B?cHluZzV6SWtFNzdOdkJkMytaL1MydmFUZ3pLUkxQR0NjQTJyb3UvWkxQclE2?=
 =?utf-8?B?R0JueUcxNG5JSkRBRkJJUmxHL2IrQmNRUlBjU0NVNG9iRnBvRGpqZFA3bHZH?=
 =?utf-8?B?ZmpsdUgyZUR1YXhEL0kyWU9JZGdMRWdwYXgxZWRDcFhIaXFsYldrNnc0WUU1?=
 =?utf-8?B?VHhZZVhXRHRQdkJPdDBmYkxLVVNjci9NUE1YTGtUMjlEcS9uTFFRUkQxU0N5?=
 =?utf-8?B?dXVFcjFsTjE3SHNnTzFOTFQ1ZEFSRVd2enJVYXhxUVo5TTl1MkxzaWxNbjRG?=
 =?utf-8?B?RFpYbHc0dllxSFMwLzFRL2ZoRm0yWmlrZU9kUzVFZldWU2h0aG9BUzVaM2lW?=
 =?utf-8?B?aHhjWkFCVnV3VHBHdlJKWUJweWFKV1FrK2xTV3M4elRFZGxXbHFsczhFZG1p?=
 =?utf-8?B?eDU0N1JlOGl5UU1qSUtDV3dkOGNRTjMzWnRITHcvTUg5ZWFnTTlUY3FYdk1w?=
 =?utf-8?B?QUhjdGt2ckdoM1hnSjJRUFNBd3JkV3QzMit4N1p6aWhoMFN0aEFnTDFDa2ow?=
 =?utf-8?B?bVN3VEpiZW1Qb2x4TW5JWC9mMTZzMFhEeWNmQmZSS0kxdis0a0dlRXBUQ3Nx?=
 =?utf-8?B?MDdRUVYzdDNVZnpjYkgzUDJtUTIxdm5OTEowemxGMUxzMW5Td2M1UWkrU1A1?=
 =?utf-8?B?azVFdDRZMDNPT2UrdjBubHZGNXhGdUpERzRadC9JNDFHRXNZT09DTXZZZmtR?=
 =?utf-8?B?Q1BxUnp6MGZ2VWowckNVK0FIaUwwdnBuQkhBdTd3ZUxPdjFJM2RUYnUrcW5B?=
 =?utf-8?B?Z3FJWHI0eHFCc3JFZ2Qra2duci9ienA5UFgxSE8xc0RHTVJiRGl0d2VuczJn?=
 =?utf-8?B?TnBBTUFEUEhvSW9FbUNQU01qOHJnSEZONi9ZeEdBQWVsd3pSeTJVbW5oM0Nq?=
 =?utf-8?B?elVMbEc4S3IyNFpzcUdSV3FadkV4K09BdFhuL01GQTByWDVmeTA5YU40WXMw?=
 =?utf-8?B?ckFnQ0JJWnd0aEZUM0ZVdTc5c1Z1V2ZXamtKcVp4NU1lL0x0d1dBcldwaWJj?=
 =?utf-8?B?SWNDc0xxWEFVbmNYSUEwd2NabDdxZnpVL29PY1ljbGRJRnpwcGYvanJ6OUd1?=
 =?utf-8?B?aUtubW1iRGliQ1dYVmVCaTREVzBaVXh4bytPbjUrU1dDWC9XTmtEZExxSmtS?=
 =?utf-8?B?MDV4bFNKM3BOQ3oyYjg3dXhFQnAxQzdYV1l0emM5RDI5OWZaNldTODhhSE9X?=
 =?utf-8?B?amVlTWtOcE9UeWlob2pTTHpwN1duRjZBbG1JNmpwQ0NQZ01lcElRamxQdjBE?=
 =?utf-8?B?U09pTDloQ0RyUkthaTVLKytpWjZSSkcvMkNmYTRZNkxPQzFyNS9ybElFS2lB?=
 =?utf-8?B?VWVkd0htMXd3TW5idHl6ZTJpcjZubThOQVBadlpzVU5HQ2s4Sk5ZZkF4NmdX?=
 =?utf-8?B?bWR1NkZMZDVLQ2M4QmRQaHNRbytFRGpPcXVhWVIwRFk0VUhVTEp4eERVVU9R?=
 =?utf-8?B?OVhWelNpNW1nTERlQ3lxbnFZVWNKVDdqRVczeFM3VG0va2Jucjh6emFXQXM0?=
 =?utf-8?B?OEU0cjF2RjUrUjZWbU1wZDVCajN1WklUR0RCdjJZNWZFVzJxclcwR1NCYnBG?=
 =?utf-8?B?ak9FbnRFem40Y3lYM0dUcVE0OWgrZFlseStXSFdkOWNNUkJFZ01LblZZMjBq?=
 =?utf-8?B?R1FnZFQwSFV4ZGVadU5BSWNtVTdIZWFHYm5EenFjOGMxbXJ6N3lpUVM4TTFq?=
 =?utf-8?B?cGxSMHNibDJneW14VUV5NkszelFUa1I1dUIwL1cwK0ovRURtVkVhMEZ4VDNC?=
 =?utf-8?B?cFd4azU0Q3g3K09OM3gvL3hTRVJWTGlGM2ZQZUdqUjZBMHhrWTIzSVJmWmlU?=
 =?utf-8?B?NWpUY3R3Q2ZGaXlRYk0rbG9OSUZVY2lSRFAxL3dXRlU1WVVVWlBjUEtrdmNm?=
 =?utf-8?B?VWFGNnFRVk9XejExWVNUdUw2TUI5ek10bDdubittSERWTmJlemEydkJDNDdh?=
 =?utf-8?B?cXQ2cVgwT284VEsyUDR5YUJPTG9iZXpEcTVxa1JoT1ArL01VZFZlb1dsV25t?=
 =?utf-8?B?ajJGUTlWQ3ZZNkhrVno2Z2FBWHc1eHd1UXo2aXllZmNYUzhRbnFUSXFWQk9h?=
 =?utf-8?B?L0RlTlV0T2pwL2tONkFReUJoeDFuWmVvN1VQTmVlaW5ueEhZZnVmcVRndjhS?=
 =?utf-8?Q?sXv0Qje3EueI2vR/yHg8pVscejob+aLimUMtLO/qLmuGy?=
X-MS-Exchange-AntiSpam-MessageData-1: 4TzOTEry7PFZCg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3486e705-9f59-484a-5487-08deddec6725
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 19:00:54.6694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbDEODIiEEjVAo0Kv9CWy2TTvasgOn00duJZ/FN/aU6hE9KKSx+8+NiHarxJZ1P/CzXDF/cd4GxnUwi2qLNAyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7756
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=den@virtuozzo.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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

On 7/9/26 20:55, Philippe Mathieu-Daudé wrote:
> Hi Denis,
>
> I tried to review, but not my area and way out of my confort zone...
> Cc'ing Akihiko & Peter who might have more familiarity :)
>

I thought that v3 should go fast, this is v3. Not too much
changes + unit test. I was wrong :(

Den

