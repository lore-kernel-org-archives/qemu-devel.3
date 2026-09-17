Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604B3C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 14:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7DRQ-0007ic-4z; Thu, 17 Sep 2026 10:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1x7DRM-0007c9-Vc
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 10:50:21 -0400
Received: from mail-swedencentralazon11023081.outbound.protection.outlook.com
 ([52.101.83.81] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1x7DRK-0004Tu-PC
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 10:50:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBgxhPbXeyLM0Z8uFVYcDgwOjEkOMhTpznjHfUqKavtxZM36HtXyr1rTgSK1VQVyCpVGsSvnB1+b8YP8ZSzXrXi1fqwiqaXZHhzxdqs689W4ldk1Lgrnm8LOYhxg+mqBAi5Ibd10gOR00mklKRVzsMrlx2V1Ygxxd7lOdvbX31jpmKqvYBU3WTxWnmR408DfeECUpPIggVUFwvBSElXROUn8PmFDTneaRi8hGBXVXicBzl6sWpWW05s0rOjpGsPS77goeU6yIeLkqyLR2XYtdmkWEWUcjFVwz2IzvYAQPIqSS/96WBxOwj/Nys0400HJPmwHM23UmhekaAeGjfj+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRm2hD0k2/6dNJA+DjggodLQsl0B5sbcnSjjxqY9Zvc=;
 b=POBqLOJOI4ZElCbU99udo1+PkN22n7r+Xvj3StzDh9FvWJ4j3JyX+fl9cRAsdDkI7/MZ6qiOLJzIpsAX6TaBxV1S0BCEJ8dFhBxaSgT8pc80NfWATBSxmoTOxSvro+PwxYvL0TCY7yBfNZzzXUEouKNiXIEXFNvYDfsvkDijajuXu5ay6Lxw/MxZnuY0J3xyvW2E1yLMsTTnLYRZQEt2xOdaDujH2FmMPweZBCs0YS5Ikex0QzrfRXhsp3oMFRR2Lrcr7JpaSh88ZWwSf1ivs50zieqVL3WSHruFdVfBhwAEaDNJjOiscmUk6NMtONtmAtI/X6Y5myx3tJZTJgUvrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRm2hD0k2/6dNJA+DjggodLQsl0B5sbcnSjjxqY9Zvc=;
 b=M7J53JJijN0sFUq94a2phLjujsM11x+DsFyuQmYYsuM3GNEKRiWNGJnf9CeWw8dcSZRvXRfkuZFRPcqRShRoh+wTypKmqtldKh60F4X2uRMiP5/Ir+Btu9jmTepv4EOY88Z0b/vEgmdRm1DizcmzITyXHXZNTnSFgzY+Rg2sHQClrojBuPGJug8G3X1h+t0fVPO/dxSjEENoed90iLfooNXDJ/X14SsO7l+BOaLLBmieyraofA8bxVzFzjfpGZ9uM/XNdYPqot49QLwal0T5NDw7eCMBRPzljFDXYKEVPgzlTGd2VPzifZotOnkMj5vddE15d9ds29s27OwnPh4JtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AS1PR08MB7427.eurprd08.prod.outlook.com (2603:10a6:20b:4c4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Thu, 17 Sep
 2026 14:45:13 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%6]) with mapi id 15.21.0451.004; Thu, 17 Sep 2026
 14:45:13 +0000
Message-ID: <30c5578b-ac99-41a5-8dcb-ab713e462833@virtuozzo.com>
Date: Thu, 17 Sep 2026 16:45:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] migration/cpr: lock the cpr state
To: Peter Xu <peterx@redhat.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>, "Denis V. Lunev" <den@openvz.org>,
 qemu-devel@nongnu.org, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>
References: <20260916132428.1628553-1-den@openvz.org>
 <aqrhPxFO7zHvZgs5@zhexu-thinkpadt14gen5.rmtcaon.csb> <87v785rpml.fsf@suse.de>
 <aqrwAftZOnT4LsI6@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <88028fa0-6b8d-44a6-8a59-41480b9d7b69@maciej.szmigiero.name>
 <aqve6zlIKMMcIfKV@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <aqvgvw44pMtCZRGB@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <fdabb32a-cb79-40cf-ba68-2de565aae639@maciej.szmigiero.name>
 <aqv7Fxeog6EiZ1xm@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <aqv7Fxeog6EiZ1xm@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0124.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:358::11) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AS1PR08MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 72eb4a8d-9136-4249-74ef-08df14ca4804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|1800799024|23010399003|4143699003|6133799003|56012099006|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: Lyk63oXeP7O/YwtujdgBZ6wHu32XJnCPLVNGL8HFcVhjzxzJPiH2K88J3IITp6grbeRBg8DTjdbhqYmwTycucgT22uL6vWsd6DLQSotDo9wIlkvzB/qQZVqh5+pvYT+aFs/+9pdREVY5R4rt/clXqR0XqTuj+QfpDR2I4mVr8bL4I8vilJIXvKeIUGRDsIxoWgNCw0DDqvMjHbjvrd6vIJTtci/hCXSj3WIdwZk7i+tjuy96xJ7dG3zY5xdOvsSbImZBCYgYcKF5UnOF8A4+IwLiLAzd40OZIW0t2VNlPg9971bgACaqRs4s3rwzTbs+p+Dv+CUUqjtm2dwZpkbfcjdRNtwaTnlx2XvqBcSD8D2QhJBqiSIp1EqemM/g+vy0OFjX17TR0huhdgWBaU/2Mp2Fv5v6yDPqX5zdfTFLRADeUGuWCbrAgaQpVuk1aILfB64RDbY/C9o8BZ+wP/adZUbSeZZdw5u3aymWRlPFcknRCY34/on0jSTnTU8uTTLnAj/kmwE6+zyeNhGUB1YfdKR6dA5tBgSY+5l/u8GQ6NnD7UI6RgYIL03GYtZBlrmmGkUsGVts+eTYVPe5vHy14bN/RnX+O6gdNR+6JXCPrT+m77cJ0iLYx9mc71jLti2+SbFX3GBuVVh3N1xC1wWHuyVG7gywJUvSsQOWh5V91bU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(23010399003)(4143699003)(6133799003)(56012099006)(22082099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTJzUzlKa21SSTVZVGxPMUFGOEE3ZUNLL1BnMjBIVmdEQlN0bFpHMnBSSWRE?=
 =?utf-8?B?L0M0TWxGQTdiYnZJRUhWOTZJSEdRQm5vRVBROXZzUTNKZ2ZORTRDakZ2bGNq?=
 =?utf-8?B?aFFTZHo2dHpRSzNUVjFnRmZCQ2RnbGsvUUFPcStCQ2U5ZllqakFocmQvYlpp?=
 =?utf-8?B?R0t5a2RxSFEzNFN2Zzk1K0lCbFlFcVpNVUhjOFNBc0VDVngxaW5Tb1RIQnhC?=
 =?utf-8?B?eWN2d3BXY3p0V1NOUGVZbjVncDU4eDhRdDlSWE1CSFRET0FIU1hpY3Rkc1BJ?=
 =?utf-8?B?QXE1bWV6dGhLQXh0MmFXTTdRek1uUUI3RzFsdnM2UEtsZTBMSEdhK1V2d1la?=
 =?utf-8?B?VW1TR2ZYd25TWjd1akpra3A4YS80eXNMSlRHaUJkeFRYejVzOVZTOHQvT3lT?=
 =?utf-8?B?VHlReEpZSVVsSUZPWk9tbTJmZ0UzWDNXOGhPUys2VzlnVVN3THU5NVZocjRB?=
 =?utf-8?B?WWxSQlVxdlFZeHhPcko4RjErSE5UOHJ0cTVtYnFNTnNSRXpTNTdRdmo5QkVv?=
 =?utf-8?B?Vi9yQldZN2xQWTRtTHQ3QmIzUmxkZjYzSU9qRXlYYTZRSjJCb3hJbWZDTHZS?=
 =?utf-8?B?cXF4RkpabVhxNXM0ZFVxY2dnbm9JNmNvSFFrblRDaGFUb0g1OVpoWjVDR21v?=
 =?utf-8?B?eFVtMnJ6STRYMFZIUTFtd1hrUS9aQTBaSkFiYk10UDJSbDNuSDR3czMwUkh1?=
 =?utf-8?B?WU9NcFlkbG1LazVZOUhpUXQrQ0hxSmhuS2c2T2xRVzhVdWVzUTBuRTBZQ2RC?=
 =?utf-8?B?cFpFOHE2UnZyYnZzbDA0bEhqYmttWjZVdm5wQjZtcG5ISm5PYUNKWmNaNkRt?=
 =?utf-8?B?bHRmWks3Z1VKS09aYlhibTVNcnZ4dkxvMk1FaEQwY3RiVHN6RXNvcjVyVEtV?=
 =?utf-8?B?Nk5oNjRLTzgzZnlkRkZHOWllc2plZkZYaC9FNFVxMnowbDhlR1pGdytEbXpq?=
 =?utf-8?B?VzFJVml1VkFlVWk1TnJ2YVcwclJVOFJoWEJuem9xV3ZOOTlQMVB4OWZsSXll?=
 =?utf-8?B?ck5XYUpaQXFWKzQ2Tk9icXUwZ2todXBJa3MzdFdOUkFMaENwRGVzQ0V6MHFP?=
 =?utf-8?B?bzE4N0M5YmVBcG1EQWM2ZzZjWDNvU2xFRnMzbWs3TXE2ekxhc3kzWHg1eEth?=
 =?utf-8?B?VityVkZtUldJbEVCYkRQWmZRL1p6c3RYRlRHemN2MHhmNEhFb3lOM1psM0hU?=
 =?utf-8?B?aktGSmFYM1FBb3VqZVF3NWFYK3NYVjlheVpaTHIwcTM0TDd2bVlhQmUza2ti?=
 =?utf-8?B?dWdxalg3ODlmVU41Vy96OXdjanhqa2txblE4RkdKWkg5eTJQcU9OSkFMeUln?=
 =?utf-8?B?dnF5ZHdpT1dkR0UrcytYbEt4WFpzTEdTTUxhUlROTFFKR1ZFKzZFNXNyc1dy?=
 =?utf-8?B?aGM2TWxDRTFPNm1qV2NyZHR4UnJPUmduaFByVWVNTWpENllNOFc5SFhURU9v?=
 =?utf-8?B?b0doaXVzYzlxVGNoQ2l3STZKQkF1U210UUJjSUtpY2pFMVRMbE9WV011b0xp?=
 =?utf-8?B?WFVRVEhESkIrREhHT2F6QTlRclJmZ0ZGcUFjME5NZEorMExMTWcwanZ0VUVv?=
 =?utf-8?B?UmdTRW5qWDF4c0VlVXZZRXZOcFJPcGQ4TExJckxuTW4vVWVrT0xLVDBiNFQ0?=
 =?utf-8?B?OXE0TjA3d0xiT2Y4LzZNZm9PSGZzUmlKaVozblJCZ3EyVnY3R3hzOW5vKzMv?=
 =?utf-8?B?WGpta2hkbExmTlR6aDhMV3lFQVlMRnovSytPVllpS2RTWlpSNnRDZ1k0QWlC?=
 =?utf-8?B?ZXp4dEo1TFM3T1c2dk9Ucnc0VWFpVE1VMmxGVFNSKys2THRKZUJIc0tiRmlj?=
 =?utf-8?B?VmNZSmdON0JPeFkxQkpBam1qcTR5TmtmSnBMNXV1ejNiNnN4QVNMbC9LcTdO?=
 =?utf-8?B?K3dkdUF0cjY3WkdtaER4MUFVejZnWEpGNlYrTkU2bElnMTJNcnM1L3NzckNQ?=
 =?utf-8?B?aXJyanY0UnR0WTZpZlppVFNINEk4QU5la2V2Y2lzeEhyZFBnNkUrS3pyQTFF?=
 =?utf-8?B?V0hBbXF5aUhnWlVMMUw0Vmd1NTQ2d1lRalBTcGZmRm5mZ294TUJFdytTMTNW?=
 =?utf-8?B?Z1ZMWG9LczRzZDgxWlJjN013YnRLem5rV0xmNEZaNXhBQ1FZTlVJWHdPa0wx?=
 =?utf-8?B?K2V1L3ZhMzRIcngyanBWbHNuZC96Zi94RGVQL1MwbVI1NHlxaTYzQjVXYk8z?=
 =?utf-8?B?a3NUeVF0ZE9mVEFZdTNpUHZzWTZFemxoc1dDV25EbFhRcG1ua1dUVHhoeTdp?=
 =?utf-8?B?ZlA4K3F1L0RYaGE3Znh1cUxoL3ZhZTA0bTJxTWJWR000R2FDQStPYUhoWGM1?=
 =?utf-8?B?VkVwb2pKajY4OTRpT0JzV0l3Z3UwL0N3TFEyRERSVC9lZFkyVGN3cDUvdkdi?=
 =?utf-8?Q?dTi91xqfqwoCQCeUEY0XofyKqRgtzrxTn8dLsiWag7wEm?=
X-MS-Exchange-AntiSpam-MessageData-1: bbj51TiJMlKJvw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72eb4a8d-9136-4249-74ef-08df14ca4804
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 14:45:13.5222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wRaSup5rlZ2WeypabNGf9Njs/LyRuvVQq2eZRe1dDmP3yMOkm9tjJkuaLS/q5VaztpXz9ENvsj0guwxxzTbn+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7427
Received-SPF: pass client-ip=52.101.83.81; envelope-from=den@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 9/17/26 16:37, Peter Xu wrote:
> On Thu, Sep 17, 2026 at 04:17:54PM +0200, Maciej S. Szmigiero wrote:
>> On 17.09.2026 14:44, Peter Xu wrote:
>>> On Thu, Sep 17, 2026 at 08:36:59AM -0400, Peter Xu wrote:
>>>> On Thu, Sep 17, 2026 at 02:24:42PM +0200, Maciej S. Szmigiero wrote:
>>>>> Isn't moving to more fine grained locking than BQL desirable in the long term,
>>>>> much like BKL was split and removed from Linux kernel years ago?
>>>> My question was more seeking the issue behind.  CPR is pretty special, I
>>>> didn't expect any new fd addition didn't already take BQL, at least before
>>>> reading the last message.
>>>>
>>>> I don't think we should randomly add lock for any structure that is
>>>> currently protected by BQL, it'll unnecessarily slow things down.  We
>>>> should only do smaller granule locking when we can consider getting rid of
>>>> BQL in the first place.
>>> Now having some understanding of the issue, I noticed I'm not very certain
>>> whether this small lock can avoid all the issues.
>>>
>>> Consider a race between cpr-exec migration at the very end, cpr_exec_cb()
>>> does cpr_exec_preserve_fds() walking all the fds, then another connection
>>> established in monitor iothread trying to add a new fd.
>>>
>>> In this case, when without this smaller lock, it may crash accessing the
>>> hash.
>>>
>>> When with the lock, two operations are serialized, but is it enough?  It
>>> means cpr_exec_preserve_fds() may take the lock first, mark all fds
>>> reserved but without the new connection.
>>>
>>> Would that be a problem?  Theoretically, cpr should persist all fds in this
>>> case, including the newly attached?
>>>
>>> Maybe it will never happen in practise because libvirt should never add
>>> another connection there, but I feel like it's more than "protecting
>>> concurrent access to a hash" problem.
>> I though monitor connection FDs aren't CPR-preserved in the first place, no?
>>
>> And if you meant a monitor adding some non-monitor FD, I think this will
>> be handled in the main loop anyway (and so, serialized) via qmp_dispatcher?
> My commnet above may not apply to master, but Denis's branch which
> originally exposed this problem.  And I confess so far it's kind of my
> interpretation of the issue from reading Denis's email, it may or may not
> be accurate.
>
> My understanding is the connection happens with the iothread not main
> thread from a client, it may not really need bql.
>
> Denis may have more info when he collects enough info, and correct what I
> might be wrong.
>
> Thanks,
>
BQL is not held in IO thread and taking in there is IMHO
no go at all - these threads were specifically invented
to avoid it inside.

This is another side of the story - I have observed
BQL in disk IO threads and chasing them too. A have
at least 2 known for me places - IDE (which could be
executed even when vCPUs are looking idle) and
controller resets f.e. in virtio-scsi which call bdrv_drain()
with BQL held.

We have agreed as far as I understand to fix comment for
now until monitor CPR will come. At that moment we will
have to decide about locking.

Den

