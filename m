Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC61C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6kV5-0004R6-FR; Wed, 16 Sep 2026 03:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1x6kV2-0004Ql-Mn
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 03:56:14 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1x6kV0-0006Ty-ID
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 03:56:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrf7VeWREX5K4f8pZKjxKP0ldk1/m0oQRCVSJfLaXdwrXA8DisT6kE4u/wjyDn+pL6Ogy/+rIJAheI2yHQUgNQxG9GXgvJ/ZHeSje96JecZLLqwb2pR2pLSg8TEKVN3NIzvINXVeE66uRccJZSCRlbxR5puW1MzwHwThwmAncuwBuin7LzVWs5gVkjc9NBQm19HXgbz1IJ/70z0KY7cSrgyBM455qCMpl8tiDdsE1sFaYRE0HdytAvgGQX+pktJlAhuv0MyUYMXccqb5fOhSecZWljZAjiAsyQbDhYh5D96eXjh5F3mC5172/0AC1ZgdT6wCoT/SWXPNfBij3s6wvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jo1XZzcdgA1VplIR/xLQPqzHoOlfx6DyUGBgUNcZVvI=;
 b=cwfPTZQeIQNl7sFw9up04W/FKIe0v7BSS9joktn7ss+9WsZBya4hK2QWa0nI0gXrf6Lm5Ikha9/VrtNxil1y+roiOAjU+CsVsFszsc0lw8YyxvaP6VEAir7VrxywXiQghDa6cDwrv2I2HBVohah8/rVobdZJh5yz1mJnQpCWpssNCm9o9icemim3EjFgFmvBhTmiDEgyuhMpU7jtInYsv2Ts8JwAmUjGXgtIeD1OBRf/mcYQ4TlYfT1vkh+vRsKJagZFAUS3s8wjTM9EsF6IkOekQ3jaUKvLvqpqLvstyxTyjNge8qknoBu3VkfT5bgLmaPCMqYXiCvF57Rnw6NVcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jo1XZzcdgA1VplIR/xLQPqzHoOlfx6DyUGBgUNcZVvI=;
 b=DTYzcxoC3ng3Q1d0m9rr4Oap6UzryY7wGWZ9HD7ewn5Ms5c/76nk9Bq0ki3brjLI5YiJ7N+TVAmLDwlnzYQ+cOAmUVf99regNaQv1Yta8KON0GmWjCI2rtc/WN/xstT6gXZt9TZYZdENlMxmSS/KQbtL/wUs22aDIKNjnqzkDJUmQAFXclAhbxhqA/NnZci1AUK80mcfPLj1pZXgFlAoi0uy/2C35z1ufYWRBTh0ljWSl58WIuaqCREqgG0YC3krS1U9Sq5CYq1v0FZTryFuz9mEy5saKT/DXyBIiOF6P89mNYLpwEHUxbOSNbDg8n8EPLkIJmqXSeNwxdiy+FJBoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by GV1PR08MB8355.eurprd08.prod.outlook.com (2603:10a6:150:a5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 07:56:01 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%6]) with mapi id 15.21.0451.004; Wed, 16 Sep 2026
 07:56:01 +0000
Message-ID: <5fba8010-5fe5-49cc-8327-46eff070e0a2@virtuozzo.com>
Date: Wed, 16 Sep 2026 09:56:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] tests/functional: cover the BQL watchdog
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260915203455.580999-1-den@openvz.org>
 <20260915203455.580999-11-den@openvz.org>
 <e22f13f9-5cfa-48aa-bc37-bb9bb2d1c5ba@redhat.com>
 <CAMxuvaxQ5OnE3pGQpwaJzTK=ELMZr=3W1QzMLR3wrsxPMjiPrw@mail.gmail.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <CAMxuvaxQ5OnE3pGQpwaJzTK=ELMZr=3W1QzMLR3wrsxPMjiPrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0127.eurprd07.prod.outlook.com
 (2603:10a6:802:16::14) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|GV1PR08MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: ae24c931-4f38-4a75-1033-08df13c7f36d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|23010399003|366016|7416014|376014|4143699003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JjiMPSnw/FrDyRNFZfWLlQqUPZU20SBfFC+mmZLxw8nwLUgf29hebgMaJP1oOXqSvID6fOQBa3CSqZtjTML+Bh1n5QQNtu/T8xzYwcABSpukLVgU4sI3j7ymgJDqR25SwVMpRzygYIx0LFT1wCPyeK/CJe8BkBSwZgLvxt/9GpyRdC8mJLJvZwhYnH8W2ZoJVEHxxPYFb8C2Q0/aOiU7t39sFL2scE9qmxvCY6iD71XiVvl3PDwsEv7UhR3uFcfXj6dY/kQ9YoHVr5JjZtvNI3+Fkh68RNwbAlspDRmHw4rAXw9hV8M/VZ5PNodsaEVhLzh5jBFAGRu3IgK6WVMU8PtB9AMnM31lKhKtUl5BYExqBvqMiUHfJp0y6VFYjmAG6EGGeeXaNVP4Odjalx3tac4s+I2MqJTC2ryJ1l7y4x58ZG50JO217u7yGSBx6Inqz+8Ccc1HumYmObJD4sK9nbkrjvVWgBCKU9apRJqAiGAn8lPVyio0pgXJuf36NysZyvCP8pfiiEg7l56v0tEsUZiOEQrP8dup8L4/Ocx4Q26ftTHDgTvzY9HR5NHPmCvIzfI6IPCGI7pMp1pm0hJ0QMKNPz7ZD4BIwSjr5mAdFBTEnKA1vn0rjKdKKXfZyG433bEyWk4DHyEJ3+yQ5ksQnQCvuMpVx24+Y2D4NsAaFzE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(23010399003)(366016)(7416014)(376014)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0k3Q0l5UGZHVUw3N1pLbUgySnpyWDNiYkNkYkVpcTRkMUhXYlg2SmU2OFA0?=
 =?utf-8?B?NXNKb2V0UHI5cEpwK2NtR0VQMkZQUjVIU2xUczJ3enA5WVlKcjFWZWk5VzZ6?=
 =?utf-8?B?SEp1NVg4SERqc2Q5Zi9jU2lOUTNLa0c1TG5XK3V6bUk2WUJac0NjQStvRDli?=
 =?utf-8?B?ZTVUZ0pXaGs5a3ZWS09tY29yRDF0b2hmNjhWUDFLaUFMNFNpcWJqYWhuU09T?=
 =?utf-8?B?T1dDMkV5OXhLb3VMY2oyckF2T2RJQkE0WGFJS2VTU1lWTmh6QlNTMklLZW1z?=
 =?utf-8?B?QmhhMlFmM2JLei96TFFPZUJUTENncTMraEpNRzd6WVRrTlpvU04rWldKTVBP?=
 =?utf-8?B?WW1aTlFTK2ZFWGtMV2xMM0luYkpheWt3SFZDMWo5L1hQQy9CM2drL3IrL2xX?=
 =?utf-8?B?SWNJODh4ZjNrdm93YmZ0MkUwTUk1d3ByNGovU3JpMEZ6KzdtRnpjK3pUUkFY?=
 =?utf-8?B?ZlJQRWcxZmhxYXYzTk1BT0M2cFkveUdqUVRDS1FpdFNkOXN6TzJQUU41Z2dW?=
 =?utf-8?B?REVZVHJTOEprNVdvN2RnNDI2V0tyS2JLTExIS1cxUGNzTnRvWEFQNTQrbjVh?=
 =?utf-8?B?V3hTNVJoekVCcWxiSyt2TS9zNjlmWUtQV2RMeGxMQUVZQWQ1MGt3cXFqaDJS?=
 =?utf-8?B?SW54ZEEwS0JENEFDelgxYlQ4YzhVRWt1d2dsUTY1emU4Tk1sVCsvbm9pbDlt?=
 =?utf-8?B?ZWxyOUJ0OFExd2JLY1IyYVBiZXh3eUsrelpvSmRuWTc0Unc2SzQ1Y1FNV1Jp?=
 =?utf-8?B?WU10b2VTYVhGaFltK0lUSEErVDdtcE9wditmWldPZGdIWHhBbTdoOHVFRVkr?=
 =?utf-8?B?MmVYQ2ZkbTZraGFjTHRkZS9ncGJZVkwxZlQ0eks4cXJ0cVZjeVQ4dGRPcGZY?=
 =?utf-8?B?ZDdMeTIyd3o1dlRKS1RCRUlMb1ZQdXgweDBCV0Q3bDM4YVhNUkFtcnVkeE51?=
 =?utf-8?B?K3ZveWd6Rk5LOGRlU1J2cG8wZytNTWgvTTBGdmxRd3lZdW5hRkp3S2hvM25j?=
 =?utf-8?B?S25aUUZJWHUrUzNOM0dqS01PS3NCVk1Lb2J2bEVoRXdhYmU4VTlmaFc3VmNE?=
 =?utf-8?B?MlFOS1hOS0k4Mkx1MlRvMG5EWm5ERFpGck1tTmd0c1dCaWU3SlZQUXhrV0JO?=
 =?utf-8?B?SFV4MWR0STFYdlZOM3JqU2tWdWwvNXNhOFBkbk9teWtsZWRsT29YbFpRaFY4?=
 =?utf-8?B?bWhsVzlkYjh3VnpycnozMjZQU1k1bUx0d2p1Z2pEL21uempzdVpFdWlWQjJl?=
 =?utf-8?B?clR5S2dQZE5ZOVdhRTBic0dqdUJzNlYxOXBvQkgwWldwMHZ0ak1ValJHNGsx?=
 =?utf-8?B?dE5lQ1BWNEE2S2xvdTRIVDVQZllyaThGV2gvNURDNzZkQXVkN3dLQW5DTXFv?=
 =?utf-8?B?Rk9MU01ObVc1NW9DY2hFY3kxY2ZnZFJ1UXRtWG1yOUJjeFlnc3F1MFVXNmlr?=
 =?utf-8?B?SzhqQ3IxaGVZbHdEQ0d6Qm9sNDVOaEhwT1JHRDZ0cmFWekJVdzRGRllHa1Z3?=
 =?utf-8?B?TVFhUFg2SHB3SGVmaVRzSEU0Q0xFRHI1dTB5UGduL2k5MVpKcGQzU1o3R0xw?=
 =?utf-8?B?Vk9aZXZXT0tneExDZ2ZLb1hkcko4OTdOWTlPelNHZVBxaXI1VU9aT3NGVXF5?=
 =?utf-8?B?UlhUUHJFQ1RuUmViY0lLQUhZV0l0Uk5BSTl0TzE2R2MrSXpWZ0wwWXVUajhO?=
 =?utf-8?B?UjRLVEdaNGI0UTcvNjJMa1J2WTFqWFhjRlhGaG1Gd3ZMRjE2RFNRb2N4SGVE?=
 =?utf-8?B?OVZsSXNrejhKTnJmcm14SnBXQjhKcm1yUWMydUVvdElVS2VTNUFzbTBMZmgz?=
 =?utf-8?B?SFVsQ3VTS2NsemJENDdJU1lCdGpReDhYQ29zRTYrazl3RTI3REdHUkRaU2Zo?=
 =?utf-8?B?L2h5azB5QlZWZnNRaGl6Q3JwOERTckluZkxtanQxVUVwR3dpSVNLanFXZTFK?=
 =?utf-8?B?ZGFLV01nTVp0aUZqQzlUdjRpeDEvUy9kRi9DLzVpVXNseEEzNTdWL3Qxd1dD?=
 =?utf-8?B?dkJPOG45YUJuejhnR3RqT0VpWDVKNkE0Tmg1R2VDOWM4U2txMVBwMFdPUmxS?=
 =?utf-8?B?Mng3Q0JmU2ZEaVZ0a3JuL2l3T3BGTjJUcjloRDM0QUYrM2dqYWpsWmRHZFpj?=
 =?utf-8?B?MXI4aXlmSmxFeDNDbXhYaVBSVzZvczltRVZUR1hkL2t6eGRYQWFNam81aWxD?=
 =?utf-8?B?OFo1UzNuWGttV0FoanREVHlLZm4rc3lVRmV1U09pRnRWTGJkZkY0bEdwdFd4?=
 =?utf-8?B?WEVDbnJTdnVnTEhUZklDZytMOEgyakNQQ1FJRnNiR2lyZEtsOVRWUlU4RjJ1?=
 =?utf-8?B?NXNITUpsUTR3Mlg1Nlk1RU1KUEowbjdLV1ZSZDFzbmF2VXluTHllWkFxNDlL?=
 =?utf-8?Q?sodkZmksn7HnDCNS/l4uh2CXVaNkse/T0iMUCyBCXH6Ry?=
X-MS-Exchange-AntiSpam-MessageData-1: gBLpKHdoPR6llw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae24c931-4f38-4a75-1033-08df13c7f36d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 07:56:01.6732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/u1FIkHtu6FynsLxxylSSGiL593eMfy+z+lz8r5+T6BMadtarNVqmiXPRhnw0oJxZDfOfHRkg+yR9jtj6T9lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8355
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=den@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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

On 9/16/26 08:44, Marc-André Lureau wrote:
> Hi
>
> On Wed, Sep 16, 2026 at 8:58 AM Thomas Huth <thuth@redhat.com> wrote:
>> On 15/09/2026 22.34, Denis V. Lunev wrote:
>>> From: Denis V. Lunev <den@openvz.org>
>>>
>>> Hold the BQL from the main thread and check that the watchdog says so.
>>>
>>> human-monitor-command is not a coroutine command, so a write issued
>>> through it runs to completion under AIO_WAIT_WHILE() in the main
>>> thread, which keeps the BQL for as long as the backend takes to answer.
>>> Point that at a null-co node with a latency ten times the deadline and
>>> the hold is both long enough to report and short enough to end on its
>>> own.
>>>
>>> Arm the watchdog after launch rather than on the command line, because
>>> machine creation takes the BQL in bursts of its own and a deadline this
>>> short is meant for the hold, not for startup.
>>>
>>> Check the quiet case too. A counter that stops distinguishing a held
>>> lock from a free one would report a hang on a healthy qemu, and that
>>> failure is invisible to a test that only looks for the report.
>> ...
>>> diff --git a/tests/functional/generic/test_bql_watchdog.py b/tests/functional/generic/test_bql_watchdog.py
>>> new file mode 100755
>>> index 0000000000..193dad15e3
>>> --- /dev/null
>>> +++ b/tests/functional/generic/test_bql_watchdog.py
>>> @@ -0,0 +1,60 @@
>>> +#!/usr/bin/env python3
>>> +#
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>> +#
>>> +# Test the BQL watchdog against a main thread blocked on IO.
>>> +#
>>> +# Copyright (C) 2026 Virtuozzo International GmbH
>>> +
>>> +from qemu_test import QemuSystemTest
>>> +
>>> +deadline_ms = 100
>>> +hold_ns = 1000 * 1000 * 1000
>>> +
>>> +
>>> +class BqlWatchdog(QemuSystemTest):
>>> +
>>> +    def setUp(self):
>>> +        super().setUp()
>>> +        self.set_machine('none')
>>> +        self.vm.add_args('-nodefaults')
>>> +        self.vm.add_args('-blockdev',
>>> +                         f'driver=null-co,node-name=null0,size=1048576,'
>>> +                         f'latency-ns={hold_ns}')
>>> +        self.vm.launch()
>>> +
>>> +    def arm(self, ms):
>> Maybe it's just me (so feel free to ignore this comment), but when reading
>> "arm" I'm thinking of qemu-system-arm ... maybe call the function
>> "enable_wd" or so instead?
>>
>>> +        self.vm.cmd('qom-set', path='/machine',
>>> +                    property='bql-watchdog-ms', value=ms)
>>> +
>>> +    def hold_the_bql(self):
>>> +        """th
>>> +        human-monitor-command is not a coroutine command, so the write runs
>>> +        to completion under AIO_WAIT_WHILE() in the main thread, which keeps
>>> +        the BQL for as long as null-co takes to answer.
>>> +        """
>>> +        self.vm.cmd('human-monitor-command',
>>> +                    command_line='qemu-io null0 "write 0 4k"')
>> HMP has recently been made optional, you likely need a
>> self.skipTestIfNoHMP() somewhere now to make sure that this test does not
>> fail if HMP has not been compiled into the binary. See also:
>>
>>   https://gitlab.com/qemu-project/qemu/-/commit/6a0195cd57b231c2047232c8
> Better yet, use QMP, amd x-qemu-io.
> thanks
yes, this is just another old series kept in depths
of my git.

The fix is minimal and I'll do it. The most important
question is the concept itself in the previous patches.

Thank you for your time,
    Den

