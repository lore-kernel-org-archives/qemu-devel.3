Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377E3C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Ok1-0003eu-DP; Tue, 01 Sep 2026 09:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x1Ok0-0003eg-Fy; Tue, 01 Sep 2026 09:41:32 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x1Ojy-00063k-SB; Tue, 01 Sep 2026 09:41:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iaVVt5SkO9aXwbeIUN2QBkidYSLniv4yMCVer3zI2E3mB5LyblScwiu8nCfgdYUWfGBqqPnpHjBLtH/ijkFyNzUZWhFBV/vkr6wnvTt6+M6nZSUx8NudqeHDoh1rWm7H064uSo9rp/3/ipNzDi80x68YVBq1r9SsdLYYDg1Vje9FodMoGFI5Mg/iUxESqw4DNQhcuJ3rte98oRg/aOFPh07bRF2G69gYg9WWlXvdwih6IS0WdOw7kvUNpcKST4ABhFpv/iTlyetZd6mo1LpR3yD5IYWcUIp0cTPDFW/sMLjdO+E6qSh7l8qujaPSditjDH9sehcDfTyLBfCfiRGqjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/rekf8dx3nbSNmvXAK6ZsnVWaQAnXMFXOVuezTxafQ=;
 b=mOGxoFAybOQyG84xdz8ldFBLNbivNo3tqKueBbKSW6JuczPp0KTtJBa411h5Cu3rMRBkQkgffb2/w33tp1fdfTxdSJmo2xoL5jdgSAswwIIqmbnI8YE7dAHe+SX/xxkg9TKef48TTIZFek2eu6m1Odo//0z9WEE5/fVxs0eJ/HM8LW0SvmQnj1uaByFbHWEwGKQ3ooE7QI8zx6KwRB278e5uEotOM9+3YxCUMQ938kNKpSzRIOT/jQ2EhV1WJIgWUYRTVIksHaE1M9SbywLtGIqJYqy1kukOmIAI11+GZSsbHsW/SjOmrwTBCEQsy7qn1NrfWn+LV+o9qrbhrz5JuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/rekf8dx3nbSNmvXAK6ZsnVWaQAnXMFXOVuezTxafQ=;
 b=hwEFhfE92E0dRcG1jWAal37e/ykrbe/LFPORa9EVfjuTIcJ+iluYPPd/ydiNlISqttZkJBWefMvPceLM05FnBD8tWH2Op1VNAO1Ynxj8ZoAGug/ob1oH5GagRgB99G2rk5jIjwhJv7IF6+HcFwHRZB9ZF0sT6Xy/3/H4VeywewKFCtDwqKQl4xQgBy3eG9b/sa3LhdZaNP/xliNkSMF1mG5Y1w/taHfIRrZYmROj/VRi3CQJZcVfV79d7Rw5cVHcUA+9Ta0+WmifJEjBAJcsjCAo2FWuRF7lEG03x3SjA8FDS6U1IjGrIJd7+zY/nROzJ60XI1OzTeVVkRfSK1bqdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AS8PR08MB6199.eurprd08.prod.outlook.com (2603:10a6:20b:296::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 13:41:26 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 13:41:26 +0000
Message-ID: <8604eafa-c683-4d89-b180-5b26c56b7817@virtuozzo.com>
Date: Tue, 1 Sep 2026 15:41:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] tests/qtest: fix the disk tests on a host with a
 small /tmp
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Fabiano Rosas <farosas@suse.de>
References: <CAFn=p-bCR4TvVvHwagXiK-c0wuY5dACwh92249Wv0C3odCtbOg@mail.gmail.com>
 <20260824200627.2180635-1-den@openvz.org>
 <a1a7cdc7-5458-4d1b-bf1e-9aa89502317b@redhat.com>
 <apAZaRwIdm1yLiLV@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <apAZaRwIdm1yLiLV@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIUP296CA0070.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::8) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AS8PR08MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: beeb8534-5a7b-4cec-e732-08df082eb852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|10070799003|366016|376014|18002099003|22082099003|56012099006|3023799007|4143699003|10067099003|5023799004;
X-Microsoft-Antispam-Message-Info: heQvkcrD3++4UwMrjTwVKsRQT1Lf1CfevFPZDn2EGxUTI5+tQn7CKNwGGgI48Pu+BHWS+nWc3Z5BfMEgDBGDwsJ01wQ9MHZ53bVF575Mgt4G8FJ2NIzMinINsnAazdyz0lV6il3f77qmHA+Z4EQNGqosrQBWbEbHL0l/CraGmtu0stFPI5BahP7HOufA+r4GVl1US1EqBTcNB8xFcCHLeuGLPfcdEhSYGhyLc4UNeJe6ULPJIhAy3qmLNH99nN3sIbNB1b/nhwM5aTrGg0o2ZsrRomnFuNwI5pE+JIonSz7iV5PPpS1oAbevWw1Ee+2k2cmp0xJ2De8+NuqdzpUktneqZfLxeoavp/oV8UfK9QgJaYmTqigFQfgJ20Rsla/GNNyyO0qVVa6HKOEsHRRB7NchXo3cFqyjqTHD/Q03Dl7tLbpRBDrjX8A1GOPjE8f0lnyCEpWiIgbL6S0Bx+essE9gp7Ba8MHRUzz0kPo/9JQhceA2RUHDKZWZIfklOK1/JDQsZfs/ZQ+3Vi6MfmDz37EmgVfjpZfu3/ui8Gp9aZH5em09/fvmvtaK54Kb8ZvsyxLHf4gTPssV4hCk/MjzzCn1ho2+JmcD9Ckg/b6O8fXtcgrW5+KGChwaM+HTg6FcC7vDxF8zCEF1KnnjIniJ9LSfHOk/SA9cTeVKBzn+WZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(10070799003)(366016)(376014)(18002099003)(22082099003)(56012099006)(3023799007)(4143699003)(10067099003)(5023799004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0JaYUpPaDdDTExLTE9DTjRJWFJDakdrbzczaVovLzRidzMwS3k4dlV5M0xi?=
 =?utf-8?B?UXo4WHRUaE51OFZ2RUs5SFBKdUtNUGZvS0Vla2V4VjJCbHYvK1k1VStnenEw?=
 =?utf-8?B?SWNwT1h1Q3Y4S3d6dmRLRG5iSHB4N1Ezd1R6bTVHL0RNVWRkMEdPWE9tM2Zn?=
 =?utf-8?B?VmtDMGluYzkrMWNJODlVQm9hWGdySWNWMFlQN2R0YmRXTkNSV1VaZ0QydnRH?=
 =?utf-8?B?cys4NlpWVnJDTWw5YmxqYVQrN3VGKzBIOXRVNlgwQ3pOLzFWOFNFNHR6eWlu?=
 =?utf-8?B?ZHpsM0czcFpOdVVOTUpqSWswL2hXaExTR1VuRmtTRTcvVXhWR3BTYmhvdkhN?=
 =?utf-8?B?Mm5BVjF2RzJXNThpRHRRZ0tGL0kwMVNHYjd3WWNXQjdEaUJDZjA5SHV2ZFha?=
 =?utf-8?B?Nm1jWFZDd0FrR204MStGekZFM1paVjQxc28rT0RXY3l1SjExOVN5dDRRc2oy?=
 =?utf-8?B?akVjWWVLdUpmL2JteWh1dGRwaUdveGl4NWxGdzhWZ1YwcEVRYlhxRXovTW01?=
 =?utf-8?B?K1M1Znhmd2g4MVZzV1BMNzBMWmp5NWN0bFRsS2tiTjk1VGxhdDJ3dHREUGcw?=
 =?utf-8?B?MlV6cm1YazdQQlJIR3FhMVNzZm9jRHVjTEE3WlR5M1c4TnhiMk9SWE4yUHV2?=
 =?utf-8?B?RFowS0pMV2hLd2lZNkpKU2pqbXJQcUZieTRoNExnL2JxbE41Q2ZsVnRyL05u?=
 =?utf-8?B?bmZwemloVVRDMUpsZVVzUnY5U09QTnVWQm5ldVpVNjJSL0pFcmtBemdCb3Q0?=
 =?utf-8?B?djJxWmJDLzJlUzhOWjdPSWhPQ1NxaUNVK3laVlBKQ1ZHOUE2ZE4vNTNCdkNY?=
 =?utf-8?B?WXBzTmh0UFc4VVlGNGVSSGxNZXJvQTlVekFPUzdvQlRuaFlEVG4zdUNxcGYx?=
 =?utf-8?B?Q3NmcFVHclBLNTA2TnVtMU1Ma1Y2NTBDT3lHTDk0NDYwSHdDSS90QzUvb2Fo?=
 =?utf-8?B?TTdBVk9PLzRvZU9FWVQxai9KQXlwaEF1eUI5N0tnWHhEbnVpalFzWCtPZGpR?=
 =?utf-8?B?VjNOTFVDcXJFVERXdVhSQVZNUmlPVGF5cnUxSGwxRExQbW9EVHJMMURaRUg2?=
 =?utf-8?B?ZUhCSnRXMUNyQjJUcTQ0YTRqSHBkcDNqSmJodkp0amlmS1gzKy9SaG5qemJM?=
 =?utf-8?B?Z1k0OWpDS0RjWXZiSS8vdWVJa2Q0Qjh1R3hGelloRG9aUldkTUtiZjdpc2xM?=
 =?utf-8?B?SDNJd00zVSt4djcycXplSEhmTFRuYW8wRmVsUGJPNEtyRVpmWUl2T2xqODZB?=
 =?utf-8?B?clBNTzFyVk5GOWR3bkdFekpMRG9ESkNIZHFCcDdBT2NqWlBrODdBbXp5aHp0?=
 =?utf-8?B?RUNGNDB1dFh1ZnR4VTR0LzFBK3hHeUpKaktmYU84c2NncVJVMTJwNVR6cVhJ?=
 =?utf-8?B?R2JsKzBJNG9xVHNuSDdXYU9jRElOR2NmUkRidThZZEorM1hBbVFQUzlhMzhj?=
 =?utf-8?B?TEFwV1luS1lXVU1TMnQxYTBKN0p0QWNJRXBraXVVNUFMcVUyKzdlVG9KZDdX?=
 =?utf-8?B?Mkh3ZU1nb1hPNkdsd3doVmd1NnFKK28xZkJ3U0NYR0JROEdQT3h1Q3k3SENT?=
 =?utf-8?B?eHZxd01TNXJTMmJCK3cvN21HamJDY1RsTmN0VFdjSTRCMlhqMzBkTEdkZ25Q?=
 =?utf-8?B?S29jbVVZTzRza1R5THpuRnZJSitSSnVMcWFycVorN1VLbmpzMzNsYWxUaFht?=
 =?utf-8?B?bi9NbG0yWG5UczlJak40MVQ5NzAzYm1qTlhONGVNeUkrUFc2OGRLc2JyaEx3?=
 =?utf-8?B?MG5nUWcrcDRUUU1BY093Y0c0MlRJZklZTEI5QWJBc0dkUGFrdDBueVgwWVBI?=
 =?utf-8?B?dktIaWJyaGpmRHpPYnRscjVyYStkVC9nbGFmclovblAxeWRSOWV1SGNNOVI4?=
 =?utf-8?B?TFEzdm8zdm50M3VPcEZjVmIzVzZFZitIT1A0OXBCd2FtRm1nR0lvSTZCdUpz?=
 =?utf-8?B?RzFJR2cvbGpiN0k0M0pieGZCakp2N0xhQXZ5aWtueXoyKzZrK2R0bWRtS2hE?=
 =?utf-8?B?WEhpMy9sRlZNSkZwSWpXSWhoYlhhNm4vemlHeG5STUc0MitSaUFiMjBLVlc5?=
 =?utf-8?B?Vm9va212WW5FVyttV2JMUVhFQmRDcVNMOUN5aUVsYXc3NE5PM3VSL1VFNnBC?=
 =?utf-8?B?a3V6K28xWko3R2pTU0dCU1F4ZWdzdWo3cEZrei9jTzVySUFBVDFrSDhuTlpP?=
 =?utf-8?B?eHRTQzFld0FyMWRqaDJxR2M3V1NyM2ZHQjdUUDdtcXR1SEw3QnF4c1JoaWlr?=
 =?utf-8?B?S2xhQWxMU3VDNUVJVXdtdzh6ZEdJSzhBdnVWbm5NRUcxTHdBOVFIYnZURjd3?=
 =?utf-8?B?OXh3RnhrMVBRaUNURVRhdktGRm1vZG8vOXVleFJ6aUhRRWprYUUyOTJSRmRi?=
 =?utf-8?Q?ZY9wAv1t32vFMD0+h/PcUTg0hP04268OypYV44y0aNHKp?=
X-MS-Exchange-AntiSpam-MessageData-1: MlPI+Lw5hXJQUQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beeb8534-5a7b-4cec-e732-08df082eb852
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 13:41:26.5320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2XajtICOsXEFNVFGBkN/tGTjdN8IO7gbIRtJGmH3YBdpQFQTJJC+1XhXkpoYIkyNLqxziBpmzs8ngldWVSGbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6199
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

On 8/27/26 13:03, Daniel P. Berrangé wrote:
> On Thu, Aug 27, 2026 at 12:16:56PM +0200, Thomas Huth wrote:
>>  Hi Denis!
>>
>> Please make sure to CC: the qtest maintainer (Fabiano Rosas) on series like
>> this.
>>
>> On 24/08/2026 22.06, Denis V. Lunev wrote:
>>> John reported ide-test dying at startup in the NetBSD VM:
>>>
>>>    ERROR:../src/tests/qtest/ide-test.c:1260:main: assertion failed:
>>>    (ret == 0)
>>>
>>> The hypothesys is that the ftruncate() of a 64 MiB scratch image. NetBSD
>>> mounts /tmp as a tmpfs sized at 25% of RAM and charges a file its full
>>> length themoment it is extended, so a sparse image is not free there and
>>> the call returns ENOSPC. The assert dates to 2013, nothing regressed.
>> Does NetBSD have another file like /var/tmp that might be friendlier to
>> sparse files? If so, maybe that should be used instead?
>>
>> OTOH, our NetBSD VM in tests/vm/ uses 4G of RAM, so a temporary file with
>> just 64 MiB should really not be a problem...?
> Or this is a concurrency scaling problem, or racing with another test
> that also uses stuff ?
>
> We hard code memory to 4 GB, but -smp we scale to "$NUM-CPUs / 2"
> for the "make vm-build-DIST" commands.
>
> IOW, regardless of whether QEMU is launched with -smp 1 or -smp 20,
> we only give it 4 GB to play with. We could be using a lot of RAM
> for concurrent build jobs leaving almost nothing for the tmpfs for
> the test.
>
> If we were that close to exhaustion I'd expected to see out of
> memory errors, but I'm unclear what NetBSD's behaviour is in
> this respect ?  Maybe normal RAM usage can be pushed to swap
> (of which I see another 4 GB) while tmpfs can't be pushed
> to swap ?
>
>
>
>
> With regards,
> Daniel
Guys,

will somebody take a look into what was done?
This makes sense anyway - unified same class error tracking
plus requirements reduction.

Or if nobody care I could just push along with another
test fix?

Thank you in advance,
    Den

