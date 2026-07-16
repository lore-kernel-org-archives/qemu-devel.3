Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34759C44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkQHp-0006t7-AQ; Thu, 16 Jul 2026 13:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wkQHn-0006sa-Ni; Thu, 16 Jul 2026 13:54:15 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wkQHl-0006oe-H3; Thu, 16 Jul 2026 13:54:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yd8r60BGOYH3xtzn75nKt2MRmF1gfR/6kF855UHqfmiAoO7Vc0G/cExeJAyIZOc3o+UMDM5xZwM+8FLgWgUozv/ffFY0YBBx29TY36BGiK+i78GmmEedtckrIYQKFYyMiVY8ZFq/OPHpYPOKwIBrEIAbrDluSHjvSN1ckgYZlTz9UkJcRCmlyGvt4pKPlayKOyUuYKReaeECRfYJhQECdcky4LmNsbRncBFuwJz7w2coOQN5quuoPuTwy5DFHhNlLG2FtjyhadnJDiYvGwY4mWUtWk7DAUUNQN/YBBkmAYl9AnAuGAhVQq6Xuq9N3tm3cXc0nY/sQ7OUuMKhiw8Rag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qr958OhV8GdJ9AfQ/IHhyhD65X6thQylRASLS9heM0=;
 b=IGIRvPhdBrh3R9MaMpO4KqC1f8XUt5brM+0sQ2dBRmKCGTOidEyE2zluIiZeN0UFdxhpwEzwkDaaIxccrXpP1p4Ygr3tFiYp7+jfANjMq4bcNVHZ8kA9sbGYjl7kGUe82+8ByrLiFjEI2l747CATFBMXG1UXZ/G46FR2PyNzE1yZ7SOfDl5S4r3iEyBcTqwDlh3Wxjz94GbLdjPA9lJWZ2iwrdo6uOk7BoosjZnYby0W09MeJDlGGfiHRTOb+WFkl99WrbNXEtCCVVATMoyaTYxbhiYKb5Kjhlm2uAsBNowMU92s9537CJ/f5c23fLCJCtepJ4jz1ZejBgN6pt6BPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qr958OhV8GdJ9AfQ/IHhyhD65X6thQylRASLS9heM0=;
 b=utRjZ5W/U/0HrMb21TVP06+mV/7Zfav3w3VDTPxM+rbb1B3r2wkXMw2Se9FmcQNC933YtP1gah8i3/Xq/UxoY13uTY+52YBsNuQRyq5IdWDjpr9xntqSv7KIEqz8OsSItgAjr9l6jev5yZvmOI6xccMttro/asNShzhROwNmuv+1XB/Ywk98QsAQ0HS3S3Yk//EAaclMbKXxfHHEDezKVAG1xSDNafGqw7JUkbmOIxOXehkthKxUa495fqyHx7HCIot5Q+Rij+RY/jxKdRg6dB5yIYfU0Wz4Y0N0CI5qVT6FrMSv5MNdi4+qgKh4LutYTryOP5a2fITKMdoU1EzDrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DB9PR08MB6505.eurprd08.prod.outlook.com (2603:10a6:10:23e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Thu, 16 Jul
 2026 17:54:09 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 17:54:09 +0000
Message-ID: <e586cdd4-f9c6-4889-894c-7fc71ca15286@virtuozzo.com>
Date: Thu, 16 Jul 2026 19:54:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] qcow2: do not try to clear the dirty bit on a
 read-only node
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20260716153552.3376009-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260716153552.3376009-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIVP296CA0053.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:353::13) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DB9PR08MB6505:EE_
X-MS-Office365-Filtering-Correlation-Id: e631c53e-962a-477a-c668-08dee3633c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|1800799024|366016|376014|56012099006|5023799004|18002099003|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: Kxgmf2mtpCPMuM0xNKVA3oX4Ggv5zNG0QwjHXRe71WyAmgM0OU5pRJfP762or7oRPc8//O/+Qf9ouJvQur7rv9+XmmIzxY463YelB4j9qlOrCjAY+7zkzB/0+QacAg+UnooXSxE9AixxW3v5UmnPP+U1fIrSjolR7ejxbc2FBY5ue6LXvRsB1FZxBAM/5JgsaGP135hcvD2cuqrCW+7VCdvIJQrKTQ8pyMxc4xaO7CBcziStNPYtBmPVdv1H+MDgRLWhpxgQaj6lkEvbJzfewGyr7Y4Dqh9u3/GLhb2YMHr2esAfxX+lJ025VepCiPTLNexAFSB9PT7Fi216C73rKgqyQiqZzHHT58AiSUlk9QLE8R9SqcR0aLwL9XQ4hrmXWyhumA7TR3W5cT5/ELRdzXd5IMdMLrjx3I2sIjuzNQidJJJm6JPfg7VXo4Rqf+S9JaDiurAW7xOmHzCFyDTndDZ4HyEZSIdkEMOJSiQW9kEMIHkXjTVOuQbvAfFZ3nqcAN1ECtW4tUEA5cJ+uVlQpvSGwcm6Nao/0x7xGo4SOlOHOn5jWngXwh0IHj3tt4bBilBhtBuQ3k52aYzGL8aqP2wJ3T2rHs9yCu9sQr0Ir+62udRemorKHysFhqkoacsJEy8kFTjmwE4TomvQ5J6OtxyK2FrAZsRUaIg0mMeEuqU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(1800799024)(366016)(376014)(56012099006)(5023799004)(18002099003)(22082099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OExnUVFLR1NRWFh2WnZ2eUJPckFPN2ZrMmRqc0U4MzFyVVNjYXhqWXU4RUls?=
 =?utf-8?B?V25YY05XL0VvUFZBUnVleGU2REhTN2ZoSkRadU5LSDhGZzZGcm5PRm42RDhk?=
 =?utf-8?B?aTIxdkRRTnd2WVh2RXBZY0F3K3QzaEVxSmwvTkdTMTZTbm10enhGT2F0Y1BO?=
 =?utf-8?B?SlRjaFM5aTN1ZGc5eDhlaW95WWpBdEJWYmtPQ0kvU0JRYzR0Q25PNXVWeWtC?=
 =?utf-8?B?MkM2VWRINzI2VU45Q1hrTVc4am5PZ05BR3YyWjlrQUxtWlp0RHpIcTh1QXNk?=
 =?utf-8?B?SU1tR2NPcGs3MzdpSG1pVStDQ3VjNGl3V1I3Nk01bzBRNUIrWnoybHlnUzFN?=
 =?utf-8?B?b2prOXdMYXk4ZWdXcVU0V2ZMTzdxSjFlelVDdThNUUp3d3hBbWpZZE5FSWpE?=
 =?utf-8?B?bmJPYWxuQUZpV3FJTXluQ1AzN0djcnRyNSt1U3oyVWpHcTdJQm4zd1RuWWMy?=
 =?utf-8?B?SjJucFNFaVRsTUtScG5ZTFN4MXVTUm1lM3g1TTl3bFg2eHRJa3JVRU5LQU1W?=
 =?utf-8?B?Q0VwVXlnbXBUeThsTEpZRTJtb1J1YmFQRENJeTVNeXRoYzhIM2Z2eUR6QTZL?=
 =?utf-8?B?SmpMM1VUOG1mV2QvZlQzZ3ZnbEVzQjhpeTdTczZVd1VaMkRpbW15bG5EZWxh?=
 =?utf-8?B?elNTN1VPM0hBa0t3YjdhaEpMVklWeDBIcmhWc2p1RGdYRjlScFJaT2V0TDk2?=
 =?utf-8?B?cjhvdWNyL1JsaEtKMUp6YXo3aVNXcnJlQ1ppR2ZLcUhRdkxDY2lMKzBwYnMr?=
 =?utf-8?B?NG9VVEVlcE1UV0Y5Z21obFM2WDQyanBXNys3UXRLOHBTQUYvaTBHclB6NGRu?=
 =?utf-8?B?QTVSanNyNU9KdHVZYVdKbmduRUpCOHBTdFdoc0VmbmZpSTYzUENsWnNMYm5C?=
 =?utf-8?B?dlJNb0JuYUhqR01nTC90Y0VxVVdXeVk1bm9ESzZBRy9ENEpmaWdQYzZ6SW9p?=
 =?utf-8?B?UUVZMzQ2M3JQaCtRYmtKdmxuZkpjS2E1dWJkY0kzeVFwYm02WG51SzRJdjFM?=
 =?utf-8?B?RHlaclp3aTBwYjIvMjFVN3g1bHM2bldOUlh3M3JjTWVYalJJYmkrRlI4RFFy?=
 =?utf-8?B?SEdndUhjZVp6blFVRTFHNzBSSVE2NDlHd3ZrZFhsaEtWRDVuOVdKV05jZXY0?=
 =?utf-8?B?Ri94WDUrN29RR1dGbjZUR0pXd0JVRDZLYjh4UDhMMzhzTUF0NlpuRTd0V1NP?=
 =?utf-8?B?WjBaWmorWVdJNklRRHFkbjArSENudlZDVVFIbnpNWDJtbmcrYklaR2I0c1I4?=
 =?utf-8?B?NVMveWpQKzBLSGFTTWFmY2ZHTEd2MktyQmF2emdEV3lYTlRKWEY0dHV5Z3ZJ?=
 =?utf-8?B?ZjZSSmFWakVoUXVpTkZzcGQvZzg0K2dmcnVmNWRLMUJ4dmhhbzQyVzB5dXpT?=
 =?utf-8?B?MDl3OXV4WC83Q1p0STY0NkhhaDk3MmNFNmtSUDBzTDg5dUdVUVRaamJXN1Nr?=
 =?utf-8?B?d25qR2k5S3phMisyV2thQi9xazAyTk9sZnNTZkhMVkl3RDd0bUJnQ1d3MEEv?=
 =?utf-8?B?a3I1alZ5K2IrVWVwWktzTGRwZldwVzJtK1pYNXhINTFtalNKTnAyNVN2b202?=
 =?utf-8?B?ZE90azIzYWN5aWVrRDVVelFjYkpiTjRNQXB4bUlyUktvRVlpdEpQK2RlekVG?=
 =?utf-8?B?UkFpY1R6Mkd3eFRXT0Jpc0Y1SDVSa0JnTU5mMXo4bk9ISk9rOGMyakFtZFNR?=
 =?utf-8?B?YnpCV2RVZkFiNndvZlQ3RHY1ZzBRNzh5eS90dSt4cFZyUjFEVVdpbEtlYWMr?=
 =?utf-8?B?SUo3OVVyUlo3N3VFQ1pENkIzdkJVbDMwaVAxcUZZWDJjbXlvWEY2Rm5rV0Q5?=
 =?utf-8?B?MllOV2lUa2JSZkxPZVY1RFd2dEtnY1hxNUtHL25xYVBPRGh3NWFMZ0xOS1F0?=
 =?utf-8?B?QnRwRHA5T3FPZmtiQnJEZWlPYmo5Z25UZEZMWlVaZENWS0hXUVppRE9BSHp3?=
 =?utf-8?B?Qk05ZTdXbE04VXFNdTdzOVl0ckhqMHBObjZac2tOTDJMU0Z5QXAzYmVuNWVV?=
 =?utf-8?B?SktZYUpTWTNweWlrWWtjNlVpQ2lxY0J3ajdERUJ6QzVKRzY2SFhxK1l1amNK?=
 =?utf-8?B?THByeEtaNVNCdlBBR0xIeWlEUFNQQVNDMFJVRW9KWnRvbGREbEtZN1diOEZv?=
 =?utf-8?B?NzRWYTVTTk1qTHlUOSszamNnZlBBNmMvVW1lMGFvdlhwckwzaEl1NFl2cnlY?=
 =?utf-8?B?aWNoS3pWdGREeDMvaG5IVDkzOTFvS3VKYkxSaDBUWnoyTmE1WXpIRW1HdElv?=
 =?utf-8?B?QXJhMTFaWkltMk8xUDExbUVKSEVNWXUvVi8wWjJvUk9ENzFlUW1nblBBTTl0?=
 =?utf-8?B?U09BQkNxaG1QdzllK3VRK0d4YjQyRVNqeWVYM2tzTDE1ZEx0WUdSZWtzSnls?=
 =?utf-8?Q?ftMOcMUCjIqNGCStoulwRDRAte22outCImCZ8X0+KE6DD?=
X-MS-Exchange-AntiSpam-MessageData-1: Y2HpKAWDn8OwrQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e631c53e-962a-477a-c668-08dee3633c7a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 17:54:09.0554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCwAQ/CjJoIQUm1Apu5hLr59wtsKpGoTnSd+11fjUHRIeSWbVQJjqsjuBe6plLmQsl8bWrMnpBRCK/0cildq0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6505
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

On 7/16/26 17:35, Denis V. Lunev wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> qcow2_do_close() -> qcow2_inactivate() clears the dirty bit with a
> plain write to bs->file, unconditionally. A read-only node can still
> be dirty, inherited from an earlier writable session, and that write
> then hits a missing BLK_PERM_WRITE and asserts in
> bdrv_co_write_req_prepare() (block/io.c) on an entirely ordinary
> close -- closing is expected, the dirty bit on a read-only node
> is not.
>
> Skip the clear for read-only nodes, same as read access already does.
> Any other still-dirty node keeps the unguarded write: it is expected
> to hold write permission, and a missing one there is a bug worth
> seeing.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> ---
>  block/qcow2.c              |  6 +++++-
>  tests/qemu-iotests/039     | 11 +++++++++++
>  tests/qemu-iotests/039.out |  3 +++
>  3 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 2ab6ddd7b0..adb177e6b6 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2870,7 +2870,11 @@ static int GRAPH_RDLOCK qcow2_inactivate(BlockDriverState *bs)
>                       strerror(-ret));
>      }
>  
> -    if (result == 0) {
> +    /*
> +     * A read-only node cannot resolve an inherited dirty bit here;
> +     * leave it dirty, same as plain read access already does.
> +     */
> +    if (result == 0 && !bdrv_is_read_only(bs)) {
>          qcow2_mark_clean(bs);
>      }
>  
> diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
> index e43e7026ce..94a8bfe754 100755
> --- a/tests/qemu-iotests/039
> +++ b/tests/qemu-iotests/039
> @@ -84,6 +84,17 @@ $QEMU_IO -r -c "read -P 0x5a 0 512" "$TEST_IMG" | _filter_qemu_io
>  # The dirty bit must be set
>  _qcow2_dump_header | grep incompatible_features
>  
> +echo
> +echo "== Read-only open must not crash on close =="
> +
> +# We must not try to write the QCOW2 header to a read-only image.
> +$QEMU_IMG info --image-opts \
> +    "driver=$IMGFMT,read-only=on,file.driver=file,file.filename=$TEST_IMG,file.read-only=off" \
> +    > /dev/null
> +
> +# The dirty bit must still be set: this open never wrote any guest data
> +_qcow2_dump_header | grep incompatible_features
> +
>  echo
>  echo "== Repairing the image file must succeed =="
>  
> diff --git a/tests/qemu-iotests/039.out b/tests/qemu-iotests/039.out
> index 8fdbcc528a..c66361128f 100644
> --- a/tests/qemu-iotests/039.out
> +++ b/tests/qemu-iotests/039.out
> @@ -24,6 +24,9 @@ read 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  incompatible_features     [0]
>  
> +== Read-only open must not crash on close ==
> +incompatible_features     [0]
> +
>  == Repairing the image file must succeed ==
>  ERROR cluster 5 refcount=0 reference=1
>  Rebuilding refcount structure
Actually the problem is more subtle. The following command line results in

qemu-storage-daemon \                                                   
                                                                       
                                                    
  --blockdev
'{"driver":"file","filename":"dirty.qcow2","aio":"threads","node-name":"file0","cache":{"direct":false,"no-flush":false},"auto-read-only":true,"discard":"unmap"}'
\                    
  --blockdev
'{"node-name":"fmt0","read-only":true,"discard":"unmap","cache":{"direct":false,"no-flush":false},"driver":"qcow2","file":"file0"}'
\                                                   
  --chardev socket,id=qmp,path=master.sock,server=on,wait=off \         
                                                                       
                                                    
  --monitor chardev=qmp                                                 
                                                                       
                                                    
                                                                       
                                                                       
                                                         
via query-named-block-nodes:

  node-name=fmt0     drv=qcow2  ro=True
  node-name=file0    drv=file   ro=False

which would come to exactly configuration being asserted in the test
and this setup is pretty legal at my opinion. In production we have
had something lengthier with more snapshots.

File descriptor in turn is opened in a correct way - with O_RDONLY
that is why the problem was hidden for a lot of time.

Would it be more reasonable to disallow to set dirty rather than
to ignore is open question to me. Playing with permissions and
changing bdrv_is_read_only() seems more dangerous.

Also worth to note that bdrv_co_write_req_prepare() has wrong check.
It should check file descriptor rather than administrative permission.

This looks toooooooooo complex to me :(

Den

