Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5E7C55162
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 15:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpSUu-0001uI-TP; Thu, 30 Jul 2026 11:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wpSUV-0001st-LV; Thu, 30 Jul 2026 11:16:11 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wpSUT-0006US-BC; Thu, 30 Jul 2026 11:16:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9tcQQ7Jg1+qwU05LbwpKuGGu6iGJjAZTRAP7xbFYJ+eUM0C3XgXjAwOx2vpDXZunBXNH63A6GaY5UlXPJ6dy8wCmFe4DkfrC8SMgZIt6AT273tu8YrLYnw0VcW0I+YSrwAsNvvtwReyeOeYtCEWxb8lNw/AGI6moYArweuaNO+K47+TVsvODwrPvr1qPN/z9bg0Vu3TUdqZ2BiC3BnxBXVnVpoxxtqiCylCdGIEFOjxEAWIv/8ez3gdELmJSYkT5v78bqbKqEKF4/kXiPVnejDDMW7apqQ93P3OwjaHB2TiCR3t/yp7YqamZIkkToJ0KIYOAsPyXoy4PdQr1GpTUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOQ3wkslByLccZihikCrezfAccimDBP6jUKRujsOYi0=;
 b=xivbxuNtV1OV4uCRVwskDQzIO5GzAbM/pOuwujrP0y+K2nEPXhp4cMS7CRHdn+wKBxR2nD3weqmA1jBK7F8caxNjCbhxYgrbq6SploaVIpBPRcUeOjkR4RkeccfOUszOZNpr0/uxF6sqbChth2HuL13UK2CCZHbtDswX5DKcx/xe+P+bwyMOulvWytaIMw/Pimab9YekhVbzJvv2bPPXsZ9CPjMvBQw3SX7WbgNq3rlqLQ5wYR47/3Q2zeTCOI3AZeCxu2PglV90DNH9I1qDruYNrNX22dCpcDIXUJ7b16cxYMcVyiAF5wg3awUYoZxeu+hG8sQjtUFHGBF91vW3xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOQ3wkslByLccZihikCrezfAccimDBP6jUKRujsOYi0=;
 b=jwSW2fC8KWddeqBRjoncdWsOyVTJlIHueiC0A0e5u74wD2tCSXH3OsOBwdVIYTFsU3MEtKkaBNkKejPnqwpGazuznPZimk9suk5uLr6s59iOqKozAQmXelCNbHrIYbribW2pIL+7cE1bca3wHMOyBaF48yw0lIj3uS/WTpiuz5otUam+g+QEAjy/Pr6iE47VvQ5k6xDLGopZvSNRkXh88//vbRYtHWZl1UuTckJYu/S5pEy0ZbuqhxO4NmaOFtCQyTpvr2JFS6Peh32oHklwCd/lAHFcZ/C+TLyDWWFk3oIavtwwbVMAG40dKRm8Mv7zw8Ifo6E4VBJ8qA6t2vmROw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PAWPR08MB10240.eurprd08.prod.outlook.com (2603:10a6:102:366::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 15:16:00 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 15:16:00 +0000
Message-ID: <162c56ae-29f6-4ebd-8be2-20856d88c510@virtuozzo.com>
Date: Thu, 30 Jul 2026 17:15:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/8] MAINTAINERS: add myself to IDE maintainers
To: Stefan Hajnoczi <stefanha@gmail.com>, John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Denis V. Lunev" <den@openvz.org>
References: <20260730081325.1816193-1-den@openvz.org>
 <20260730081325.1816193-2-den@openvz.org>
 <CAJSP0QUnp4=pPYQvGvTEoBCndvJb0o=Z0RzehP30KKK_svyXCA@mail.gmail.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <CAJSP0QUnp4=pPYQvGvTEoBCndvJb0o=Z0RzehP30KKK_svyXCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIUP296CA0091.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35c::7) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PAWPR08MB10240:EE_
X-MS-Office365-Filtering-Correlation-Id: a1766f8d-2ccf-4fa1-1c20-08deee4d76c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|10070799003|23010399003|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kFtsYw+/HElulGTa2DcKt/cgLCrz9kfn3yUQE5oBxEj8dlyjyQvwnjbGPqkX+DPrulHlbuD+QfnIsk93VsjWi/oOMOKxzm+jMYqxjGSYApvorLK4RgxLydBLiz/3r43FdWwJe8EqSI51S5iCUC5iIhIdBBJ+H6ofRSJTcWApLMj5bCIWNK4m3EoOkdPjciivZ/ieI8N+P1Sj3E1eD9zfDg3ChxjJRieKDF0wjGloeHXht1NphaLhL5h2LZc/bI9MJmbFPtIKly2I6cLAf8odpHsyAVn5GwSfeTnSjV+y1QOg3sVDntXzH1gn7c3crCr5jlMjFCqzfRsaaeHuDgeeKBsVohUacuxn4fT/DR7jcv8NeZJXNtz+n2zMgrbSIHxIE+8Gvz3unWAk8fq8IsHEBf42bRUK91y5VKTOWvy66NAUrDEagPd4qap9z9v4CSpxwItre5dU3PV1KstVgSUcJCmL8DC2wj+SnMbDVI+c2+LdPgSI/LjX/mDPhVLe8iq6JJZdfX31R7HeF/8yz2SeX6RXH3cPMFEqHLutidJ/+EW+gT2wS737LmoNGzQe66tvRtTMs9Oy9WNyh1Eat4qoEO9IMuRrrz4et/l7MSzcpEim/rGx7AG34DNmbp2eEkd3+Ae7nKwdoPwwHqQFcCHASw23jUFUJYvS73jO3+BQDKA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(23010399003)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzArZ29yVi9OdWNXYXlXeFNiWEZGc01USXZjWjhreWtUSVVTMEQyYnRlRmt0?=
 =?utf-8?B?K05JbWFPQW5kd2xqWUlJZTZkUTE1KzF3ZCtld2RDUURndXhkV2paRENPQ1Fq?=
 =?utf-8?B?YUN4TloxckUyRll0V2E1OGgxZ2laTkwzN1N0bXBFZ0M1MmpYbktydjVrWUFU?=
 =?utf-8?B?OWc2SzIzNlVFR0tJdVF6d0NpWVpPMGhHT3c5WnpqUTMrWmNENWxSaXFSTG56?=
 =?utf-8?B?VXUvMmk3Z1g5UzdidjVBbkZERlRqOERYRGYvL1QzekZBNE9uaXQ5SFRoYmZN?=
 =?utf-8?B?TEg2TVg0YVdoMlo0QTB0cVVvRThFNjdOalByQzgxeEFFZWpLcjh5UEMvcHlo?=
 =?utf-8?B?MmpXWUIwZ3JldXFJanZ2VVNDeUVQdE5BTW43dmJuY2JWNHdEU1dxVHRHVlVv?=
 =?utf-8?B?cE56WFpvdklRRHdxOTRaSWtCUGxaQ1RoVSswSEVudTdFSUptWjZhVWFCaTJ0?=
 =?utf-8?B?ZEVNa2xCeVIxNnN2RUcvdTVUbVBwcEJhSFVOckZOODhjN09LRTluVW0zL3pk?=
 =?utf-8?B?SEVabHFCSkJwdXN1a1M1OWVoaTA0bEtXUXRnanBLdWxpMWJUY1QrN3BmYlQz?=
 =?utf-8?B?UGVTUTBjQVhWWWhIdldaWU5uUy9jMmQ2R1R4UlorVWU1NlZNQzUvbGVVUW1L?=
 =?utf-8?B?TCtQbU80SXVwVWs1ODlFT05CL0pJcVBtaHU0V3dDM2U3a1BhZlBEZXdydWdz?=
 =?utf-8?B?dGQwWnNkMnI4VWU2cS94QmNlbXBBU0F5alBlQU56UndaZ0pYMGt5WUhKZTNX?=
 =?utf-8?B?NmlScTZEdWxoNU5rTjZ0UTk4MmxpcjdKYyt6cmhFK3g4dm1RWGN5NWlROHpM?=
 =?utf-8?B?NkpTcG1oZDVReG1kdnFjYm5FZXRKajdlSU9ybWxqWm9JNVZLZmVDK1VFcmls?=
 =?utf-8?B?R3dyQno1cHZ0U0RiZTd0OTl1a3ZSUU1qN0tLRUJ0T1BGVEpmVXBDYjlPeXpu?=
 =?utf-8?B?a2tDaFFVOENjSGxJaWJIODVtTWpuT0dybFgyVUdDVG9XbkNrOUozZVVSUE55?=
 =?utf-8?B?ajVZMlBET0xzV0U1bzNHdlVUYXArck1tMk9JdXY3L1JEZGY3TERjRWV0MmdH?=
 =?utf-8?B?aWZ2cHMzQVhaT3IrVGR2TXhCdzRtTkVqcW5tR3pxK1pxZ1praVdScVgxc1hY?=
 =?utf-8?B?UVlsS1E3NC92WVVCcE1ubEdxaEhkcUt2WDRzM2c3eU9HQVByM2g0bURKTFB5?=
 =?utf-8?B?Y0Z4OVdtWFlZY2VxKzNUTllPL2ZJaXl3NjB2QzJxVlR1NjBDdmo4ZXkyanQ0?=
 =?utf-8?B?cVNza1paRmdRVU1aWTZOS3M3a0VIRU4xaXY0Qng1REltSjdKRGpVTmZzeGRq?=
 =?utf-8?B?VmF2dmtSNTBXZHNzcVkwaXdlaFF6ck1XbTBuUVMvbXI4aUF4VkQ4bDZzK1pY?=
 =?utf-8?B?T2p0dGZmM1FSQlFPdUwrencrMDdudGV0enloSndOWDBNQUQ4c0NRd0pOMXJz?=
 =?utf-8?B?Sm9kVFA0aXZ6WFRJYlJ1MFFkTXFLR1ZhMVBMUmFabnBGcnErZUlSWGxlcS9B?=
 =?utf-8?B?YXhwY0l2MVZNV1ZORnNFK2lmeE0vam9KV3MrVXNoTE5DcnpvU3hwOWh5SDF3?=
 =?utf-8?B?UVg4NDZQNjdqSkdxRVAydWhwVnBvR3pJNGU5OUxkTGdWeUpQaW9hRm0zM0xZ?=
 =?utf-8?B?L3YzaEE5ZDllK1lBUDNJelMvV0dGWnJ4bDV1OE1kQnhvNENDY0tDUkhodWJZ?=
 =?utf-8?B?cERidldiY0pBUW5mR0F3a2d6czdSMldQbzRsSmJQUVRlOVRDVUxjRmorbnJo?=
 =?utf-8?B?bk1iR3I4dXcwOCtwZkJDMmN5MUtocFl5em85UFdsN2dxYTJHeWZCU1FFZGR1?=
 =?utf-8?B?blkvSmE1Kzg3Tm1sdUthZ2V4Q0RMbDVwaUhkdXZQTlRKRVhPREdoSXk4d0pL?=
 =?utf-8?B?d2NtMWgveDlxWGJDVEMzVEJscGlqdDlyNk92K3FWQ3NLcFZseGNnT1dpaHB1?=
 =?utf-8?B?ZkZQdVZzM3lFZDJXSWZxdHZQWFdQbTFiSUtUNzUraE5nTi80dTlIeFQyUGl3?=
 =?utf-8?B?azB5K2pZRENFUnZNeGFxcTA4WjkwaGxNekxlZEV0WHpJZ0M1bkNKUW01cjk4?=
 =?utf-8?B?M29QdXdndWJKdHlESkhXNk5yZTZ5WU10QmFnWDdEdUxGTHhHS2tsdW1IRFVB?=
 =?utf-8?B?VE0rZWNqSGZlUVBERFVUUHAyK1ROZk1rWkEzVEpwWWJaZDJGWi8xdlRSb0ZF?=
 =?utf-8?B?MXo2UFRKZ2FjamJYZ25CSUo2STF4UjljZlVkOXl5b1lTSnhKSWEzOWVSMFVJ?=
 =?utf-8?B?ZitJc2pVc3pJYUp1T2VnbVpxZVM3cTlGRmtuTC9GSFNMd2NYZXVoSC9ydlpW?=
 =?utf-8?B?N252WHVsY1hKbFdKbGIxZWhoQlJSemoranZ0V3E4NU1mdmNDZ0pHcFdSVFBv?=
 =?utf-8?Q?9PzDynR13dACY5OHiEdRVkJQm1XpRVqLfd72r8/tTzDBx?=
X-MS-Exchange-AntiSpam-MessageData-1: ENTxXCgldVgMmA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1766f8d-2ccf-4fa1-1c20-08deee4d76c3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 15:16:00.6594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eiSQliGppEwocqXXto0zkuwSmaTxxZukmb9JNvIkgFIVb7RQ+LNSHgizbPdEbucAGiUAp+HUU6EnRit7fmlZJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10240
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=den@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
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

On 7/30/26 16:55, Stefan Hajnoczi wrote:
> On Thu, Jul 30, 2026 at 4:14 AM Denis V. Lunev <den@openvz.org> wrote:
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>> CC: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 902db77218..4628793dde 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2160,6 +2160,7 @@ F: docs/specs/edu.rst
>>
>>  IDE
>>  M: John Snow <jsnow@redhat.com>
>> +M: Denis V. Lunev <den@openvz.org>
> Waiting for acknowledgement from John.
>
> Stefan
Most likely this could be a problem unfortunately.
I have running with this series for couple of months
without attention.

Stefan, do you have any way to internally ping him
from inside?

Den

