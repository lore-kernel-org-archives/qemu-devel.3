Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E574CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMvO-0002dd-2w; Wed, 07 Oct 2026 04:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xEGu2-0007t0-Ow; Tue, 06 Oct 2026 21:57:14 -0400
Received: from mail-westeuropeazon11020074.outbound.protection.outlook.com
 ([52.101.69.74] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xEGtr-000363-Pc; Tue, 06 Oct 2026 21:57:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ec6KH0HSf7QLl6Y4wEMNgFxIoWbJzv9jj+QLP7kvMaZJbvNhQCg5UXI7dIwwgjt7xaEt0EVKyhYwavkrfY8gr9s+Xd8DbBoryKOmK9qBxXi3AJiRnK2M0mM2zSFyfYW1U2RvklRLtod04lz8g+Pi80/f6D3B5B65qvEZrvxmCapttIbmUFJU4OslyrObdZCF6zE9bjEBbelDjQcI2CILtW5gLpyl1gqA33AuBilDVdPz7zrJ2DJAJxDZbny+ehPzeM6U2lCX1RJBUJES0HH4jEtX/2UxD76bS6+SAnSncOjZLYnW1p9yevTOf8FEkpFXIcLJx0JbqUEXgbDe0WnpjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5/6kI00uImmrOpzO8ESC8WiVU5UbHefIIaaSHAw1LU=;
 b=vYr6ZEyK8zDIc5dKCid1VdFeLWbp84pebwa4nIToOq/DC4nQ9tVCKOFAVKLpb1qRZv/IcrGFzLooSXmv+BnCL5+HzdovABkbE43nGIB4ZCoHCJ9pxTtH06NbzayaPAOqFV37jvKKz9hTV2f4eWLYs7zDf7J2L5O5P4QEGjl566r3dVvwpvcWBKPiAOrGp55S2Q4J1dwfYqXWzzDbaVSgY/HRK0HCpnchhP3Ryvxlh4XZSn7Q1DdHofSE/SfKPqCsHny25mH2FXN2u9nLy1/RWiObSWhbYit3gGZwZ59IR6RbTjfAYYJoq3bgTRv+CCvCfOqa03WUvOnXy17dJ0MAiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5/6kI00uImmrOpzO8ESC8WiVU5UbHefIIaaSHAw1LU=;
 b=PcvlcnyqMgTzFvVQ/8N6ZdW6y84+czvjzwrAqb3WOTz598bEYHpTYPTEiCGxFvdCBVpLSv2mfkSErizD0eMhY3DRAGO0RDbPqo017f3aHpB/ZrNU15nzeOxqkwH3eZ9qPeoUN0Kjc8w3M+UT6ZbJ2YjXliu5XX8bMcB1ANdANDCqCSr9ryQ8ajgP7u3ySq0hNbq+hmYw4KlmAGRkqZ4m3TpkZVBfZ4Fieu0yGVD73Ukmk5RnMHC97dFMWs1VMWNYtuyTspljoDkeo2aEFcBC34gYaKltjQHIIqIK7bT3cvNS8NuWDZpzZ6kP4ZY5TEtxZBShQD5gJqeyEt3ZQFR8Qg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DB9PR08MB6635.eurprd08.prod.outlook.com (2603:10a6:10:254::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.21; Tue, 6 Oct
 2026 15:20:07 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%6]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 15:20:07 +0000
Message-ID: <248b1723-3317-4975-8c75-49f0f18bb404@virtuozzo.com>
Date: Tue, 6 Oct 2026 17:20:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/3] parallels: report the stored dirty bitmaps in
 qemu-img info
To: Eric Blake <eblake@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20260913195301.1514888-1-den@openvz.org>
 <20260913195301.1514888-2-den@openvz.org> <asUG9aE3xczhaQM9@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <asUG9aE3xczhaQM9@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0130.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::23) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DB9PR08MB6635:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fc79b1f-3792-4b5d-9ce7-08df23bd4dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|23010399003|376014|366016|5023799004|6133799003|3023799007|10067099003|56012099006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: PP1y8yHSmyEffLj6z2xNPrNtY2cS/5zVNB3KoNHQBj5xX9/lw2bW8973K8Uhowez4hoF3YpmXMgNydjp6xFDGUaJA83eryJIT859zhqE19rZp6Ubu1uxBxOdlQLvkLLn8XiykP2Es6c5Jn/u4L/2A7nWpd65s0M8BYHcipzVhpZpftNCQWnxZGUGO0CQ7nRdBgaDDmacjXVOrblwWaWpx28KuV9jBkdwn3L2IQj5vjbXS2kefUKnQzoKPhEY1EJHqROSWVy04bV6GsLRpQmxi66LiBin/08bRnfZgrC5KuhQek+v0b8RhDApAMRK9Zf3QK5YrtFrkuxhHpTPd68CbE9o+8f9TNcehswg6A5VAWcDP+rV5dAkTexmXEa3msyLIx4R8JamxlhJsv7Y4GnCXVz2yHczhTcUNHpQKeU8zKvqqC0sTTpnCwFyS+hM5uwa0ktUBaE4evnvZpFSbc/W7cXQGr1O0hTgfgzenj0IE4+1htTJOx28drTuV9jvU0eGOefRXh7ywjZVcOSm8LI1qbOt/kSBKx7Ed2NJgWNvqFi5olOg53Ml5+HoA2U1cWmB1F0Q5YsT/smKy0p0kAIsPUQVp+OaGT9EUkNi8szopZqvaLUIoi9/tad30lesorohpsruMqm/6e97hUbrZE6zh1UFLuxjy0aTZNQOlYEtD/k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(23010399003)(376014)(366016)(5023799004)(6133799003)(3023799007)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3NCczlNZDhwZWFWMll6N2xjK0I5dm9iZDMyZkd3ckRrRVFvWmU2bUJWUXVV?=
 =?utf-8?B?UFlJUjJ2bktlSkZqUWpBeDA1M2xaOFRZRG9ZOWtPcGNxeUhYTFdMVEhYZWdv?=
 =?utf-8?B?UmhRTU16L3VXS2wyckQyVEVLb2xEOHFVVlNuTEh3dXA0STdiejh0dnNmd0sr?=
 =?utf-8?B?UTZXMEltcEFpY0pia2lnaCs2clZndktWZGdiMDRZelRpZXBFSFdEQnhXb1VF?=
 =?utf-8?B?Nm5ML3JCZ1d6ZDNFSTEzMXQzQ0RIbnZ6Q2ZBWVVMVFkwa1Z1eDJTYmJ4dENB?=
 =?utf-8?B?R1p6QUJleE9pNUR4SzR2eDZrS1l2Umowb1Y2R2JUcEtINjFnUjNUbVUrYlZ6?=
 =?utf-8?B?Q1NyUHdVVi9WalM1cytBeXZsKzlRQkJONHRleU9OTTJHK0JVV3F5ZzQwTlJP?=
 =?utf-8?B?S3kwTEtDMmlBYVVBU1FnMGZGUkczVFlwYTh3NC9QVzNKMzAxeXFENDVGVC9Y?=
 =?utf-8?B?VHo4Mkp2VlNyOVMrRFNTZnMyVzlWbVQvdW5WWlU1U1dSbWl3NTB6LzhOeFlQ?=
 =?utf-8?B?N1VxSGRQeGhGQlB6Z1FaeTZzNWZJT3JFL0JTL29FTnFaa1NJc01NMmtrZjJF?=
 =?utf-8?B?b2hMd0lPeXVDalZKdmlvZVkvbU1nVUZXZ2h1NFM3d1M2WG9WUzFIaDFCNnli?=
 =?utf-8?B?V29xZzkvZlpvZ3F3Yno2dCtvZzBuQU0yemljREwxQ2ZRNU9aZ3VOSG9rdWFO?=
 =?utf-8?B?NVdtQ3pkN1F0cnZGa0JsSWFnNzd5cm5vcXBVTzdwbEdEUTczVkZGcG42WGhh?=
 =?utf-8?B?amV6VEJOU2VWMXNqL3ZVZk1qbmd3bVB5c1R6V3FBOHNEMjR3YnRvWUtpSzg2?=
 =?utf-8?B?bXpiNy9laVgxaGc0UWxuMDlmNHF5VUJzbzVTTi8vc1Y1NUd4ZFh2SndmMzFY?=
 =?utf-8?B?K3dLb01jVFpMZHByNWp5dEFZaHI5bjdoak5Janc1T3NBQ2RBKzk4elJOaHhB?=
 =?utf-8?B?Sm0vamZPcVNETUJzTG1MTEN3dzF5d2Fad2JrOFl5VTFpamlpeU5KVjRvTXVH?=
 =?utf-8?B?TFJWa1k5ZUdkSGwvejFBdjdwd1dVNENQemdyazlZTVRrTmptL2tvKzFxZHhX?=
 =?utf-8?B?MkxuakZNK1hNeEEwb2xZU2F5WENtSXlvVFhuR2lkQTVPZVBYNTZGNkJ1QWJD?=
 =?utf-8?B?dEJ6aWdTRXNPbFpKdWxTMUluTy9scXhrWlltZ2gxWk5iQitYWVhSc1pRVVhQ?=
 =?utf-8?B?OFJTUm1qRjQ0QzFocUpqVEZJTS9DQjg5Z0tRejZwMy9uREFlTXk0VlZWbUdQ?=
 =?utf-8?B?SEtkREp0TzYzMk11Z3p0MG45Z2JzbTM3WVVTbkl0UFlrc3JqTzdZU2ZGV3ZW?=
 =?utf-8?B?NHpSKzBxeVhDY253eFppUmRsdWpTUjlvbDlta3RxOW9uOENVWkZkTk1QVlBD?=
 =?utf-8?B?Z3RmOW55ay84UVZZQTNyc2NBemxxM251YlQ2OStZdmlJd211dUFTOU5QYlM1?=
 =?utf-8?B?RFlXOTNNVHNLbXErQzhRL3J6emVoeVQyb1ZwVU1qaEc1Q3pJQUdOd1QxcXNO?=
 =?utf-8?B?V1pHYUZoQnRrY2p2WHhiQ2hLbE02a1VqVU5hZVFLaysrRktqOXVFOGtmRGhI?=
 =?utf-8?B?c0dzaU0yd1RucmRscHVyYjNDK3FudENOR2hvbU1SWVdQMUhscHpXOFN6Tm9G?=
 =?utf-8?B?UkxZeDZTSkZEbkNaWlFCRlVsUEI0TWdtSU01Z1VwZDFETDg2OW9vWnpac0JD?=
 =?utf-8?B?MER1bkJId0JCVmtCWmpEYzVyMjY2amtPcXJjTTZRL0hyU3VGcVRDQm1ocnI5?=
 =?utf-8?B?amd1TmtCbGl5dWM4WmpGTWUwNjh5UzQzM3U3S2ZXejFUVHUrMEpJMUE2c2Mz?=
 =?utf-8?B?NzZ1Yi9kRmQwMC85Mzk4QlZPSlhQM3pJUi96L2RocmdISTBhWE02OS9ObGdS?=
 =?utf-8?B?UU5Pak4zdWtrYzVUblgxVFdvK2JHNGE0MTZrTnJFM2cxd3dqVE8xQUZob0V3?=
 =?utf-8?B?RzNkV0xBajlVWjMvbmZSTG00R0hadm50MTJhVnkwTEhoVzBnb05nelBIK256?=
 =?utf-8?B?Mm9paHB0ditlTTJJQzhvVk0yN0I2Q2UrMkdaTzJOenhvMnl2Si9hbU9Gb0kz?=
 =?utf-8?B?Ky9wTmZGeWFaQnFQTkVDdUpoaFZ2L3VzSWIvWElYbDNaNy9teFhDcHV1eVN3?=
 =?utf-8?B?cVdLdnpWbEU4RXBEUFZ5WEZGQng2a3VsZTY4a1g2d3R2UEhuYVVmUVJOQkdM?=
 =?utf-8?B?WDF3cThWdkhiR2trSkF5OTVLeHlMSE13dnY5SlUyZ0dQWUhHdUNCbFBRYkFI?=
 =?utf-8?B?T1VOaTFucHhPWU1ZbHdPa3hxSmduYlRmdW1OWEVsTm50eExxT012ZjJlOVc5?=
 =?utf-8?B?cHZjNFdPTm1WRWZ2YkZoMVBGL2Fyb2hUencza2RHbFRlWVY0TGdPbkYrdGcr?=
 =?utf-8?Q?A6RNP5AffUUlGUY+ZkUNRTso2117+0ZpmKsRuIt0oKqkg?=
X-MS-Exchange-AntiSpam-MessageData-1: Wl5lAAZD/XLAIg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc79b1f-3792-4b5d-9ce7-08df23bd4dc2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 15:20:07.1697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9pgzjIjZIgmHJ/4P+K7qjlSVmk0YCEnu5wRB3uUyFbVuKDbLzHl/MIvmQJ8owzzO3NEdwke8Ywrs3UXHZ1c0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6635
Received-SPF: pass client-ip=52.101.69.74; envelope-from=den@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 10/6/26 17:11, Eric Blake wrote:
> On Sun, Sep 13, 2026 at 09:52:59PM +0200, Denis V. Lunev wrote:
>> From: Denis V. Lunev <den@openvz.org>
>>
>> Nothing tells which persistent bitmaps an image carries. qemu-img info
>> says nothing about them, and the only other way to see one is to export
>> the image over NBD and ask for a bitmap by name, which needs the name
>> beforehand.
> I would amend that statement, "s/an image/a parallels image/"; because
> existing 'qemu-img info' definitely tells you what bitmaps a qcow2
> image has:
>
> $ qemu-img create -f qcow2 base.qcow2 100M
> Formatting 'base.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=104857600 lazy_refcounts=off refcount_bits=16
> $ qemu-img bitmap --add -f qcow2 base.qcow2 bm1
> $ qemu-img bitmap --add -f qcow2 base.qcow2 bm2
> $ qemu-img info base.qcow2
> image: base.qcow2
> file format: qcow2
> virtual size: 100 MiB (104857600 bytes)
> disk size: 220 KiB
> cluster_size: 65536
> Format specific information:
>     compat: 1.1
>     compression type: zlib
>     lazy refcounts: false
>     bitmaps:
>         [0]:
>             flags:
>                 [0]: auto
>             name: bm1
>             granularity: 65536
>         [1]:
>             flags:
>                 [0]: auto
>             name: bm2
>             granularity: 65536
>     refcount bits: 16
> ...
>
>
> Also, the NBD protocol indeed allows a client to query what
> metacontexts an image supports, which can be used to expose bitmaps;
> and both 'qemu-nbd -L' and libnbd's 'nbdinfo' are happy to read that
> information.  But, at present, qemu-nbd limits us to exposing that on
> a per-bitmap basis, rather than having an easy way to export all
> bitmaps at once.  For example,
>
> $ qemu-nbd -L
> exports available: 1
>  export: ''
> ...
>   available meta contexts: 4
>    base:allocation
>    qemu:allocation-depth
>    qemu:dirty-bitmap:bm2
>    qemu:dirty-bitmap:bm1
> $ nbdinfo nbd://localhost
> protocol: newstyle-fixed without TLS, using extended packets
> export="":
> ...
> 	contexts:
> 		base:allocation
> 		qemu:allocation-depth
> 		qemu:dirty-bitmap:bm2
> 		qemu:dirty-bitmap:bm1
> ...
>
> So I will probably submit a patch to add a command-line flag to
> qemu-nbd to expose all known bitmaps without having to do a -B option
> per name, on top of this series.

That is a good point. I have done similar with

commit 7e8cc6c886, "qemu-img: add sub-command --remove-all to 'qemu-img
bitmap'".

Den

