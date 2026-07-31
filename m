Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDA6C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 13:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpnYb-0002e2-NK; Fri, 31 Jul 2026 09:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wpnYW-0002dT-AF; Fri, 31 Jul 2026 09:45:47 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wpnYU-0004eH-F2; Fri, 31 Jul 2026 09:45:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQuVXfNlSnlOQsCylEcsvMK3eaWZgtZhmURvbZUhLidQXUrkht7Npcuy1Qo7JOIHNP7eZXVtsRs/q6OSVkxZ7JZx15ITwgvMCMigXu9y8Ie+QXUAdKntVw8JLZMrLLMCD1Hb2j01LarYwTH97D6yzoTiDBQwyRK88wYVQTqvyyOUqF5Lf8vqKBImiRlKKoWH+qC73M+lSSUFi3kpszWVGQ3E4ZTN8l0cv0zw2UtvDT8oAgaa0+psLpnJcIOCfIDYUuK5W9t8OHKypLYN1Bi8wRQjc0dlZiRTiXs6k5tJ1nPn13Rd+dfIGOiEcFRmyZsgXqrvK/LH5ZtqZsUT83oNcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MsSVUZq7f0rjUUY2DxErqIGcn1FkqO2MjTmVaEdPgg=;
 b=Rpujr6w/1EAdTnVTHL1dzbsHQ3g13R6pd9P1JYyGXY9Qoo7g9z+Ygv4yu4Q4Jn3JNLaRlBc1lvOFkeu4lVPP86xKr9eZah3e7MLGwFgKp7WvMumKgSVhnNISxJQtDPMWie04YghbkY8vHXSy9d1jxhtGGf0dL+S1sMoRx2KBm4B3glcikm5VzSTJ+ArKNQuEKBbaLj72jQS/nxdoz5fq7KdjzLElqvk4ojo1he3h+7R0uFU0pqmHzox9D+U++c5ggu1kfxFYZz+zrAJbrvpXhwTLeiUBysxTxS07/y6LTn3WmPQOReiOBUyKOfX+DVEzRPAEuRW03XOwbCMr8KNYoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MsSVUZq7f0rjUUY2DxErqIGcn1FkqO2MjTmVaEdPgg=;
 b=jarSZ6xX5Ahq4aOH4KmW0uOdTjiGZP0VwlPKYumCFdoayI2DUuHFRGiTyaO1461+uVvzcwLteVVzEz67/jv6PsTZbJAUXrePBqa5ch+flv5zzJIxrO20DRd5RHVC4npI2dps7UwV8FkF6/NHOhmVoXAVhphtQlbwJpwJksJzZ9AAQhzHHhBAQs//dAYpDLo94Jj0wmLaTN1lI+t1LXwpJy0y6lqOslH26O0/m7AtVWa/NKuBdzVSF54C4TUGhueqsL5Oit7s8YjemtsqaLRmzkDLjKJRqibR4iHq5fbKH4/mZLRoSi8a8vBA8901YgtAZ3IzUn2PkDYVJGqiAQcY6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PA4PR08MB6112.eurprd08.prod.outlook.com (2603:10a6:102:f1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 13:45:32 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 13:45:31 +0000
Message-ID: <f271fcff-4428-421b-b2b7-472cd8bf3cba@virtuozzo.com>
Date: Fri, 31 Jul 2026 15:45:30 +0200
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
X-ClientProxiedBy: VIUP296CA0132.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34a::14) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PA4PR08MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: f833bf59-15c7-4575-721c-08deef09fd37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|23010399003|366016|1800799024|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: WFs/BRZ1CKZUNMlP7KUKgItbAzy5awBxGp1KgBtCL6D1AAYHySaNAU53j23PA68NdLqrsn42rR0Pop8dIU2XSSyYfXI2rC+1jHG/iVHHmUbqqaPASDqTg2L4yTmzSQTS3hnExXICDjX5yGpo+eo5pJxeY2KaHITNofy980lUZriMnGlugaxNtElHEAn5HIm5OTh46aUkuzf0l4cg7z6T+9Y6tcB4kUeCo80OeRdx7CioPGOPtO8zy1AtNBPsVpgmLBfY9algo3E3GkUOrW2PH8cIc4iZi5egsSy1LNY0NvCJnx5Qpb95P8Y+6RZi9fapsalfURgxk9bosoCIEUAjJ5AFxYoc000ySBMyz1Bewf6msI0hWtaLi4PGxZVh/rj1vJBRdfu4rKJIlP2rV5RoGIfWXkTNf3dtfvoKrAW2+b3fFB/13gcFerIpPetvxVlU6gu8BYZ5Aap0PJdTvIZxvoW/E1DZUcjjSieb0gW9kM5vtQu92WocdzGxA8PO94Mhag6jlcS9c53zjIVwEuUczeSlhtF8lCc/smv5mQ9VIBEeNPCH8D/yt3GPOmGVRWpZOWvhvpg+9elyQyEcNHfCztqtmqvHSdpejehXwbng9SpocsmnG8Vi6SGRRgMTAauhosJaPpsxa1qKzALqo9ukmNIhQUDEGyDIMvGQh2OOgag=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(23010399003)(366016)(1800799024)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3EvbjhlL3hrTTB1Ym9xUzNQbzhvVDZvQW5mYUhGeEJlcnBqOXJ6ZGdCQzZr?=
 =?utf-8?B?OFhLRUVlNnBmdVh1YUg3NEwyejNEWDd3dUxqS2N0dE42Z1BPVWppelhKK3lr?=
 =?utf-8?B?ZktCS2Zzb2YzOEVYdjI1UHBzVzFiMUpSZDFYd28rTkx2bWk3VEprWE9ybXdO?=
 =?utf-8?B?L01qMm9hUGhaelA5d1N3M0YvSmFwaUliandnZ09MVlpXVEVHSjdpSUd6MjBF?=
 =?utf-8?B?SllDQUxESm5lY0w2ckhBMEphQkFXYTBkNFdTVlpZN1RhOFQ5Z0NWeWNiZm04?=
 =?utf-8?B?OGh5MUdFZmZyblJEUktMYkZNbGZBNFBQSllURC9EWTRNbEJPYkxQOE1jL04v?=
 =?utf-8?B?SW9PNmpnak9RUkZwcEZXRXJtQWsranRwZUtHQzE1OEFieGRHRXBIcmQxc3Yw?=
 =?utf-8?B?UzgrODdZMEoxWlYxY0RtT1VrRVEyOFpJQVdvY3ZrVkdOL05nUWpQT1Y1UkJZ?=
 =?utf-8?B?UmI5Y3dQUHBvTjJNRjBLTkRwc1pKYjI5alg3eFI3UUp6RVpZT3NocTZMQUtx?=
 =?utf-8?B?UUtiQ2ZmeE1qUmc3WDl1eG4yMEFRZ3RuNjBPQmpVaDQ5ajhGVmp6YjdncUs5?=
 =?utf-8?B?Mm1vVWFOR1Z2Ym5VOGhKUEh4ZzJnVUpJZThFaFNzYlFGMEFqcEswaWhpV3hp?=
 =?utf-8?B?Z2tBVHJ4N2JiUVkwc2JUTEovWjBMdi9lemFZcXVWWE52SllwL0x6Smord0M4?=
 =?utf-8?B?SXcvL1RjYU0vZlFFMFA1ZGRrclVDUmNiRG11V1JjNHFEWnM4NUxLcjUvL1Iz?=
 =?utf-8?B?ejM3ZU1QOXpJOUhVRTZSdnFZeVpKaWJ0TVJxRExOcWZ5a0VDbnA2S2l0R0d4?=
 =?utf-8?B?SmtsVnhYbVhJOW5LYjRRc1A0aWhBVmNNVFBweG02dTVHcEVMZDN4bzhDb0oy?=
 =?utf-8?B?N3M0WXNOcFExT0RFT3pRN0ZwMGhUM244YWNVMU9mOGFsdTVmTWZxU3JTRDhO?=
 =?utf-8?B?Yy9nWWxFQmFWbFdCY1FJM1FoTGk4L2hvQklSdW43WHpqdm1OOHE4YVF2YXFr?=
 =?utf-8?B?ZG54anNYd29EK1JBMEV4KzF6TGYwbXRwUUROU01WK256R0xsZUt3MVBRdFBo?=
 =?utf-8?B?bENBaU5pazVnV3haWWNiTklXcVFuUEtNZUs0MkZXRVJVNWM2aUxuVmM1WmVZ?=
 =?utf-8?B?NXpBT3FWR25ZRDl2YnJLMjVacE45czdvTXR2bzFUT0dlVURSQ3VnT3BaWktt?=
 =?utf-8?B?RVJhV1ZjUzAzNVpkWjhHeVNEY0ZTQ0VvbGdXSHkzZy9OMU4xSFdTenRTaXBF?=
 =?utf-8?B?SDRLbFNzUjgyMk1oWHpTaStUMzBUTEttWlRGeThsZzNrVTJMQnNrVXQrdUxQ?=
 =?utf-8?B?RFdwbEdYaXg5L3k2YWZKYjhOaHMySHBoUml4ZFVCdmltbW11YW9lS3dFRU1D?=
 =?utf-8?B?eU9neHc5S2o3bUFlR1Fack16ZzF4T0cyQzVrYXI0bThGUVljeDZNcHFFRXM1?=
 =?utf-8?B?cjFTaGpQamUvbVUraFA1eUtpWXhycFZPRVgrdTgwZVZWdGphNkZWaEN0UHF3?=
 =?utf-8?B?V205NmRsQ2s1YVZPVFZGUGRZV2xuQ3JMZ1FSUFdETXF5R2JoaFRMcWlPNVVC?=
 =?utf-8?B?MmVhVGtEeGlWa09TL1ZNbXZwWUhncndwcDE4SmRPVHBkOEFrTDNZS2x0aUpC?=
 =?utf-8?B?TjF2NEdVWDhoTXhPR1ZvQkx3WVVTcUYwRTdHcEJGZG5SQ3piZ2VYY0F0OUdZ?=
 =?utf-8?B?S05OY0xnRXJSZGdNelN2eENSUWJscE81NEJ0eHg1aXc0K3BmZ1l1QzNQaXU1?=
 =?utf-8?B?SFpTYWUrdFBKV2k1bUNJZ2lIYUlaTVl4azN5NXhXSmlERFViSGxjY2I4ZnM3?=
 =?utf-8?B?L3Fvd01IekVla0FRSE9WOHV2TTVDVTBBaklPRFQ0UkxvV1hjRzM2N3NRK2FN?=
 =?utf-8?B?YXhJWGpEUFh3OCtpRTN4MldnOHFHMmhhb3JqVkxPTzRZc0hMT293WjBsbTFF?=
 =?utf-8?B?MnJoVWlPNnQwR3lxQXVPY0FZZWJ5WE9pOW50VDZURzBnbndVa3lVWnF0dCtH?=
 =?utf-8?B?OE9VL25ZR2pGSTd3NGw3OHJhM0ozelMwb01lU1gycStZM0ZqOGoyQzBKYldq?=
 =?utf-8?B?SjlDdWVSMmd0SlhieEpVd3JUMjh5MG5VUGY4Slhoc2lrUENBWjlJdWpjVGsx?=
 =?utf-8?B?djY3eWNxaFErYXRPM1B2YTJMWVl2YnZVaE1nVjEyV2taWGg4bkZmQWJaQ0dU?=
 =?utf-8?B?YysyK2RYNE1sRitqMk1DWDB6U3pwSnVzeXNtcUJKeUxCVXpoQTFnQjB2Nm9O?=
 =?utf-8?B?VlRMYWQ1dGRVK2d2OWtHdWhhUGxEbUJTVHRRNWJjTXlOV2cxU0RaTURsQm5Q?=
 =?utf-8?B?ZnZSQzN1RWRRdlRqMGd3VjhBRGVGWDJFVlVVc1RXaUw5bk1LRGJGaFhkSG1y?=
 =?utf-8?Q?228UI+tdGeIdoAofFjht3z73Fy7Zxd1QF+b5/UB3ED8nD?=
X-MS-Exchange-AntiSpam-MessageData-1: wOKjmmwNKGVd1Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f833bf59-15c7-4575-721c-08deef09fd37
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 13:45:31.8133 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BN7ekZkdxq7Jl2Fjd7wpJhgk6hV2ajVpdEtK66DY4h3MWAbD/RET2iuZCiXLqTXbDNYfF/5ZNr5a3tYvRzQ2yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6112
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

The situation is not changed in general from yesterday.

I can drop this patch from the submission, that is not
a problem. The problem is that IDE changes are not
moving, f.e. there is another stuck item for

https://gitlab.com/qemu-project/qemu/-/work_items/2399

floating in the list for month.

Den

