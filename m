Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF21C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzGdc-0002AV-L0; Wed, 26 Aug 2026 12:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wzGdb-0002AE-0u; Wed, 26 Aug 2026 12:38:07 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wzGdY-0006kT-Bm; Wed, 26 Aug 2026 12:38:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKvsG8ROmwoi1Yto2IJXNIzf/wRvBxwRNHOqm4hlhcWxQ07UjvxKmyE3fyauOWRSdbjU3A1MbdBoKkshG4fPuQjNwas9GjBJxT9vbh74xh5hyTkmZwZci2TBcGWtkcLrcN1IkH9EiN5nU6x/OTSwBoVJuc2n4eZK0PwOUPGa4v0nUk/bOJmjqUbWvHAeMFaWyzc2Ni/9qwjfEXPY19qLHtgGROoz7B/PTy/tgAemJ9rNHy39lHxhUqCOWQBD/tivykGIIDrj4+vPzSc66txJknS+WUI7wQqXUnMJsmeYNUwnBI0rAreS/8oiQWm5MxhdF+jROV5zSsTFHCPkFVNYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/UihGqZAD9zdzSYSTaXa/cndhWyw4PXE6Rjeibms0I=;
 b=lZ0q/MA8SRbkXJxEpRNz8LDy9zMtncDOeCWNARGKHkHa1Ez4C7udMNnDkOKss9Yc3fWazX8LEzQ5+BiawbA6pnASaTWUuSyUvbV1CalZL8iaELUCyAgJ12gNNeQPerDCRlMKNGirAoGWadh5a+7SRXLp96hC+2J2Mhr1R5/Br1hCAcFxtAIQPWuXiAy+JVd3/PTcJUpGtj3uaW4kLoO3MV6GELMxKXFMVWVxXNPva86Z/JvV+Zv8Byut7EELAKYDVjNbylg4T0t3s5hHf383xEZvCaipKfxe9lyKj7bSQPJc/jPElqV9xI7H0sXavIXeWy3KXMKB606p1d6yleOI8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/UihGqZAD9zdzSYSTaXa/cndhWyw4PXE6Rjeibms0I=;
 b=sRGgaRA4D+Pn2ppstxZsw+xVzpmn41P/ReEM18ieP+Rv/dKmSO7nPA8falXbrhirEliPl7sqNJyd24rJbdCj07iPDK03gYr4VGDXaiFwBEz+SfBGJs6qXLO99gS4lRpWafDEoHfum5y7Lb8Zp4Idf35Pev9g/dN3O0+yKgjR8M4k6al3C1cpIGSCrrOppG3opufZMaEiZVT59EpOFVIyiJFOgdk62tg1Bp/dudlgWftyE5KeDixoLYC7Xb3TucoMr1lDIgCXpLZqT1FBUlGCVGJAATHYqGh6r1sfww60TTkr0HPyr/WmBDR2awXENYwy5J7mtplirv3bbLPSbLV4og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DU0PR08MB7836.eurprd08.prod.outlook.com (2603:10a6:10:3b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 16:37:56 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0382.004; Wed, 26 Aug 2026
 16:37:56 +0000
Message-ID: <0880ebd0-d548-496a-9832-eb4e58c46594@virtuozzo.com>
Date: Wed, 26 Aug 2026 18:37:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] qcow2: repair a dirty image when it becomes
 writable
To: Markus Armbruster <armbru@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-stable@nongnu.org
References: <20260824133729.1141990-1-den@openvz.org>
 <20260824133729.1141990-6-den@openvz.org> <87ld9umth3.fsf@pond.sub.org>
 <f0b0023d-385c-4a47-8672-f06e01ea3211@virtuozzo.com>
 <8733w0j45n.fsf@pond.sub.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <8733w0j45n.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIUP296CA0122.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:350::8) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DU0PR08MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c989485-8545-44e2-c1e3-08df03906208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10070799003|3023799007|10067099003|56012099006|4143699003|5023799004|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: WBisxoSs4zSRgZpUJ44GOda2O+4/OhpYtE+pQ8WU2TUMTmhZaRYHOs6PWRxK+OZdJjUdXOnzz0kUbkkHBwkvejEIZlJ6SRIelmhAZ+rFb344duYXs7+W59H0g9WeCHfdd9jC95pK4YiSQQ4pTb5lis+ECIONW4KMD94X27wQ83O29ND/xo1Bd+hJCfarWNQ9TGo9RIAhdd4cOlhtSHxvMN6Z0rDARI5vp/JJT8HPAGTYJiziFHuiZLljJ9dlljNLGgLu8onZSuop/W079asEUZPz8XNfAXk7bMBcdi3t9LXhQX1I+aESg6rQzNw9hUK1JjRvyYfcD1MtUvCc7/BNR3dKswNjq1qzrJJv7eMT9F46onCSSvoEpJXNLdctO58q301uvP15/omOXU/dkNPVr/P+4Qv8ZU27GHSrhTCrUhoo59Q14Hu+kAy4X6X40durFcPNjKNCZEnhXmOintCS3SQuV+WiSj7M2Ztzy5Sqgz1AxoYplz6t2sBYSPnDFosV+fjqNbBC9KFvClkm7Vu1euLdAO/i77albExdD5tNkhukYog7QMKkVDOureRMUydUfmb0flCtVBeIkdKoY2kTc6o+awU8uGotYlraoYAcGlOQybQ6URf/lCG32GwaGz/HfyaxFc9aFgMUvZFpZfRSMWfZg8Lyb6wdyKkiQ0kPz8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10070799003)(3023799007)(10067099003)(56012099006)(4143699003)(5023799004)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG9NOU5xZ2RvNFRVSTBRd1F0bEFvOXpVZDhyZ25tZHlkS283UW83OURja1Br?=
 =?utf-8?B?dDB1ZzIrYnByV2Jpc3ZaNlpVSmsyL241YVQvSU9BK1Ntdk1kaE9ZdDFqVEZU?=
 =?utf-8?B?L0RlMG50Z1ZOK2Q5RDJBWkdBZCtsZzZKVnFXa2FpZlhUeTFUT1BOYlRwTGpY?=
 =?utf-8?B?YjBlaW1HVWlEUkI4cURPeG55dVRlNW5HeVlBSDVLYnRqUjFTQ2Iwc204bmVT?=
 =?utf-8?B?WjVxUWVvVWZibVpETytNVDVMa05HUUkrNjRRRmdEMWJKQjZZUk9VVXYyaVB4?=
 =?utf-8?B?K0ZLaTZxaVJnNG5Gdlp3Q0d5SStUTWQwL0cwK3JlWEdGVklUTlh6bTFpZm5t?=
 =?utf-8?B?T21tT3lubjRzaVRVZFY4Y00yaGRyZ1pYTHRlK2V0aW96WUQ3MWxNelNUalcr?=
 =?utf-8?B?RWhkdlk1UzhXT3ZtZXdlS2lEYVppbjdDQWQybTRWb0o2ZEM3VC9nM2MxSzdL?=
 =?utf-8?B?NC9SZEd4MkZuZHdyNFlJaGZYNWdyamJZSWppT3N0S1VablFjNjNRb1pRdDAz?=
 =?utf-8?B?RDg2QUpDYzJhYmxnYVhWYXQwWVpxckkvUm4zaUVRNlN3TDIwVXJNZWlwdnZD?=
 =?utf-8?B?NFZYM1ZwMFk4NWdwREVqVWRBeEJZMlBtZG80aFZYOFh1c0paMHA5UVFKRHl2?=
 =?utf-8?B?V2FiTDRVSlhNeVAxYkxMcDZJZGs3bmtmbEhRL056djdXUTN2Zzl4S25vQ3VH?=
 =?utf-8?B?YkZuRjhvV1BCejNDQk5hN0hIS3FvcTZ4eit2eDFSNm1mOFpLMmZqMHJZeUdU?=
 =?utf-8?B?dXlrK2R3NGZabzByTjdmbzJMNnNkbkdLamE3Tlh2dkQxQ2FNMG4xR1ZyRXdu?=
 =?utf-8?B?MXFwaVdlZFJ5eFVhWFdQRXlkbG16V2Z4R1RGZ3BROTJwMEN6c213NkVJcnBY?=
 =?utf-8?B?N2cybzFxQUpNQklDb1U5T3JjWE5EVEJsUzJMSmpYVlM1UWk3aXJKZ0NVTXJG?=
 =?utf-8?B?MzljMXhaMG5HQldGYzdBQ0xVTVdBUndwMHlJRkFybGFrSGV0UDk5dUdYWnhY?=
 =?utf-8?B?Z0N5YkxzVUJJUG4yWk5jS1c1d1RYbDh4eVJCalpNZ01wazFxa2RGbHdGY3lh?=
 =?utf-8?B?WnhsZ2NjcmUzaWl6SHZiVDVVRUlYKzQzUDZGbVpyS1hKbjFRckxDRUpMbnRt?=
 =?utf-8?B?Vjl5bWFaS2wybmNmZXZ5RG5TMjl5WFZEb1lQOW4wU3FJMkNqakJ3aVBuQVRB?=
 =?utf-8?B?b2t3UW9BYVJGSjQ0RTQ2amhYMFlHc3NCenpwY3cvMHMvc1NwVzNsNUhFRzAv?=
 =?utf-8?B?STF1eWZWTjNtTWRkTnFMQVZvWG9vQW5SMHhoaHNPUW5LQmZqd2VrR2Y5Snkw?=
 =?utf-8?B?NHJheVpid29SK2k1akRsMDFTdjV0QkFkalVXZk05NzFPV0ZzUWtWMEpNRDZh?=
 =?utf-8?B?Qm8yaGpNRU1jRUViR1hySnh3ZFNCK3ZLbjNCQ1ZOYmlRQkMrM1BXL1F0aXhz?=
 =?utf-8?B?U1JuNVdkbTNhNGVmYzNnR3RmZUE5QzQ3SmIreUJEQ1d3dTIyOVZvQ280d2Jk?=
 =?utf-8?B?KzhwZlVWMnNaVEdqejJ0TE1IZ1Y4clBBeTcza0NnQ1BPRVYvUk9TUS9wRDJB?=
 =?utf-8?B?Y2duRzVwL013SCtSeXRFSFQrelJ6c2swclNVRUpYdFprUmRQNXUwVm1CV0Zz?=
 =?utf-8?B?eU83eWxZNUpCdW5YSWtWUnE5dERJQ0tMd0hjbzd6UmhqcjNWdEVUbTNoa3lX?=
 =?utf-8?B?aTdmeTVwMmxjbVMwRXJUN1dackcyMzE2RWNObklOKytQYmt2dnphU3BSaUxG?=
 =?utf-8?B?enFxbUFFZ0VVdlBWM0R5cVBadGR3ZUlqbjY4OFhOQ3BEL3M4cm54Y0ZGMlQ1?=
 =?utf-8?B?cUNJNnZJYXFuaFZEeFVUaFBRUXY5eUFkajJ4Vmt4SlRSZTRNUWl3WTVmRHl0?=
 =?utf-8?B?LzBiekxmQzg0bTk5eTdCalFDREdsUTFXd3dNbWUzUGhaalB6czlWRGMzZXdS?=
 =?utf-8?B?b25UVHpic3pwOXd3c2gzRTgxRDY4U3l6N3J5ZVMxSDlaME9jSzQzYzdBN3Jh?=
 =?utf-8?B?YS8zSGZsYWQvSWxTOWtTWnUzZTN0cFFEMDFDTGplcGdQSEQ5MU1WcllHT2lY?=
 =?utf-8?B?ZStUOFA5bWZzZWFwaU82ZGoxRU9rQjdiYzU0dHY5RXVIQWFFY2cxUWZKV2Js?=
 =?utf-8?B?Q0hMTmFSZ05CRzBhbWdRNzJSeGg4YXJmclR1MVpVSDVkekZ6VUZ0TUh0NjQv?=
 =?utf-8?B?ZWkrd2FyNC83aC91dHFiNzJqS0NUa24ySUV0T2cyM29xdUlicUtIbUFyN0RV?=
 =?utf-8?B?YVc3UDI3N01iT2REZE5zSFBJS3hLL3FYTzU4TmU4WWF1U2FIWEFteEVSazIz?=
 =?utf-8?B?Y29CZ3ZITWYwTEU4Slpwd2dKMm9FZUlkaWt4MVkyUjBkKytXcFlZU21rZlNa?=
 =?utf-8?Q?ysAPRfY5QPbcFGBsNmbAxRRLMLytpPgczATMylrc6fjy8?=
X-MS-Exchange-AntiSpam-MessageData-1: 7CIZvgP9IfGsqg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c989485-8545-44e2-c1e3-08df03906208
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 16:37:56.6709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mexIMcANQTVIsRjpwdv8U9XeTWDCZYW0ZdcQpKuspH98psUC0bgfSdSZ1WsiZOj4GNd05wWQ9zFN9cHKn/Jt2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7836
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

On 8/26/26 17:24, Markus Armbruster wrote:
> "Denis V. Lunev" <den@virtuozzo.com> writes:
>
>> On 8/25/26 11:37, Markus Armbruster wrote:
>>> "Denis V. Lunev" <den@openvz.org> writes:
>>>
>>>> From: Denis V. Lunev <den@openvz.org>
>>>>
>>>> A dirty image must be repaired before anything allocates a cluster in
>>>> it. qcow2_do_open() does that, but only for a node that is writable
>>>> from the start. A node opened read-only skips it, and nothing revisits
>>>> the question once that node becomes writable, which block-commit does
>>>> routinely: commit_active_start() and commit_start() reopen the base
>>>> read-write for the duration of the job.
>>>>
>>>> With lazy refcounts the on-disk refcount block then still accounts for
>>>> the metadata clusters only, so the allocator restarts at the front of
>>>> the image and hands out clusters that L2 entries point at. Two guest
>>>> offsets end up sharing one host cluster. Nothing fails, the corrupt bit
>>>> stays clear, and a clean close clears the dirty bit, so no later open
>>>> repairs the image either. The bit also stays set for the whole writable
>>>> session, so a node which is merely writable says nothing.
>>>>
>>>> Refusing the reopen instead is simpler and keeps it atomic, but it
>>>> leaves nowhere to go: the base belongs to a chain the VM has open, so
>>>> the qemu-img check -r such an error would ask for cannot take the write
>>>> lock it needs. The repair does the trick in most cases anyway.
>>>>
>>>> Do the repair in qcow2_reopen_commit_post(), the earliest point where
>>>> the node is writable. An inactive node is skipped: bdrv_activate() calls
>>>> qcow2_do_open() again through qcow2_co_invalidate_cache().
>>>>
>>>> commit_post cannot reject the reopen, so a failed repair takes the
>>>> driver away from the node instead, which is what stops writes from
>>>> aliasing live clusters. qcow2_signal_corruption() does that as well,
>>>> but it also sends BLOCK_IMAGE_CORRUPTED and sets the corrupt bit,
>>>> which qcow2_do_open() honours by refusing every later read-write open.
>>>> The image is dirty and unrepaired, not corrupt, and qemu-img check -r
>>>> still fixes it, so neither belongs here. Return the error and skip
>>>> the bitmaps.
>>>>
>>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>>> Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>> CC: Kevin Wolf <kwolf@redhat.com>
>>>> CC: Hanna Reitz <hreitz@redhat.com>
>>>> CC: Eric Blake <eblake@redhat.com>
>>>> CC: Markus Armbruster <armbru@redhat.com>
>>>> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>> Cc: qemu-stable@nongnu.org
>>> [...]
>>>
>>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>>> index 199efc1e00..940249a5e5 100644
>>>> --- a/qapi/block-core.json
>>>> +++ b/qapi/block-core.json
>>>> @@ -1852,6 +1852,9 @@
>>>   ##
>>>   # @change-backing-file:
>>>   #
>>>   # Change the backing file in the image file metadata.  This does not
>>>   # cause QEMU to reopen the image file to reparse the backing filename
>>>   # (it may, however, perform a reopen to change permissions from r/o ->
>>>>  # r/w -> r/o, if needed).  The new backing file string is written into
>>>>  # the image file metadata, and the QEMU internal strings are updated.
>>>>  #
>>>> +# A dirty qcow2 image is repaired during that reopen, which blocks
>>>> +# other requests and can fail the command.
>>> Pardon my ignorance: what makes a qcow2 image dirty?
>> usual obvious reasons are SIGKILL to qemu process (f.e. from OOM)
>> or node crash.
> So, you have to do some cleaning work before you can use it again, just
> like a dirty filesystem.  Correct?
Correct. QEMU allows right now to open dirty images in read-only
mode and it is OK to be used until we switch to RW. In this
case real write to metadata corrupts image.

> Back to change-backing-file.  It operates on an open image.  Cleaning
> happens when that image is read-only and dirty.  Possible because you
> can open dirty images read-only, and that doesn't clean them.  Correct?

Correct.

>>> Can you give me an idea of what other requests could be blocked?
>> Before the patch reopen was smooth - we have just opened the
>> file again. After this patch in a very unlikely corner case
>> potentially lengthy procedure has been added - full image
>> consistency check. Guest IO is stuck until the check will be
>> completed.
>>
>> The case is unfortunately real for production.
>>
>>> Double-checking: "that reopen" is the one to change permissions,
>>> i.e. the parenthesis above.  Correct?
>> yes
>>
>>>> +#
>>>>  # @image-node-name: The name of the block driver state node of the
>>>>  #     image to modify.  The "device" argument is used to verify
>>>>  #     "image-node-name" is in the chain described by "device".
>>>> @@ -1891,6 +1894,9 @@
>>>   ##
>>>   # @block-commit:
>>>   #
>>>   # Live commit of data from overlay image nodes into backing nodes -
>>>   # i.e., writes data between 'top' and 'base' into 'base'.
>>>   #
>>>   # If top == base, that is an error.  If top has no overlays on top of
>>>   # it, or if it is in use by a writer, the job will not be completed by
>>>   # itself.  The user needs to complete the job with the `job-complete`
>>>   # command after getting the ready event.  (Since 2.0)
>>>   #
>>>   # If the base image is smaller than top, then the base image will be
>>>   # resized to be the same size as top.  If top is smaller than the base
>>>   # image, the base will not be truncated.  If you want the base image
>>>>  # size to match the size of the smaller top, you can safely truncate
>>>>  # it yourself once the commit operation successfully completes.
>>>>  #
>>>> +# The base is opened read-write.  A dirty qcow2 base is repaired
> Reopend, I presume?
The meaning here is repaired. The meaning here is the following:
"The base is reopened read-write and if it is dirty it should be
repaired before any single write is made. Guest stalls until
repair is complete."

>>>> +# first, which blocks other requests and can fail the command.
>>>> +#
>>>>  # @job-id: identifier for the newly-created block job.  If omitted,
>>>>  #     the device name will be used.  (Since 2.7)
>>>>  #
> Like change-backing-file, block-commit operates on open images.  It
> copies down into a base image.  If the base image is read-only, it is
> reopened, and cleaning happens when it's dirty.  Correct?
Correct.

> Can it happen in any other way?
No at the best knowledge from me and Andrey.

>>>> @@ -2902,6 +2908,9 @@
>>>   ##
>>>   # @block-stream:
>>>   #
>>>   # Copy data from a backing file into a block device.
>>>
>>> [...]
> Whereas block-commit copies down into a base image, block-stream copies
> up from a base image.  If the image copied to is read-only, it is
> reopened, and cleaning happens when it's dirty.  Correct?
Correct.

> Can it happen in any other way?
No at the best knowledge from me and Andrey.

>>>>  # On successful completion the image file is updated to drop the
>>>>  # backing file and the `BLOCK_JOB_COMPLETED` event is emitted.
>>>>  #
>>>> +# The top image is opened read-write.  A dirty qcow2 image is repaired
>>>> +# first, which blocks other requests and can fail the command.
>>>> +#
>>>>  # In case @device is a filter node, `block-stream` modifies the first
>>>>  # non-filter overlay node below it to point to the new backing node
>>>>  # instead of modifying @device itself.
>>>> @@ -4989,6 +4998,16 @@
>>>   ##
>>>   # @blockdev-reopen:
>>>   #
>>>   # Reopens one or more block devices using the given set of options.
>>>   # Any option not specified will be reset to its default value
>>>   # regardless of its previous status.  If an option cannot be changed
>>>   # or a particular driver does not support reopening then the command
>>>   # will return an error.  All devices in the list are reopened in one
>>>>  # transaction, so if one of them fails then the whole transaction is
>>>>  # cancelled.
> blockdev-reopen also operates on open images.  Cleaning happens when
> reopening a dirty read-only image read/write.  Correct?
Correct.

> Can it happen in any other way?
No.
 
>>>>  #
>>>> +# An error is also returned when a device cannot be used once it has
>>>> +# been reopened.  Such a reopen is not undone, so an error does not
>>>> +# always mean that nothing has changed.
>>> Could that be a problem?
>> Error reply as itself is not a problem. The situation as a whole
>> is a real pain in the ass.
>>
>> The problem is that such images exists in production and there
>> is not way to handle this without downtime.
>>
>> Under this patch we are trying to fix things hard and this is
>> correct thing to do - on RW image we are doing exactly the
>> same thing. If automation is unable to fix - the guest denies
>> starting.
>>
>> Here we report an error and render guest as unusable. This
>> case is expected to be extremely rare but technically possible.
>>
>> This is a problem.
> I'll come back to this as soon as I understand when exactly cleaning may
> happen.
Right. Thanks.

You are asking very good questions which are quite important
and interesting :-) Simple "deny" policy is very bad from
operations point of view.

>>>> +#                                        A node the driver gave up on
>>>> +# serves nothing at all: it keeps its image open, makes
>>>> +# `query-named-block-nodes` fail for as long as it is in the graph,
>>>> +# and `blockdev-del` removes it only once nothing refers to it.
>>>> +#
>>>> +# Reopening a dirty qcow2 image read-write repairs it first, which
>>>> +# blocks other requests and can fail the command.
>>>> +#
>>>>  # The command receives a list of block devices to reopen.  For each
>>>>  # one of them, the top-level @node-name option (from
>>>>  # `BlockdevOptions`) must be specified and is used to select the block
>>> These documentation updates suggest the patch affects commands
>>> change-backing-file, block-commit, block-stream, and blockdev-reopen.
>>> Is that correct?
>>>
>>> Would it make sense to list them in the commit message?
>> That is simple thing. Will add :-)
>>
>> Thank you,
>>     Den
> Thanks!
>
Thanks!

