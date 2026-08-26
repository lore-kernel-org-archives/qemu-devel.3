Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854B9C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzE13-00026V-05; Wed, 26 Aug 2026 09:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wzE11-00023r-JE; Wed, 26 Aug 2026 09:50:07 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wzE0z-000713-3k; Wed, 26 Aug 2026 09:50:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MiitUaUdxMen2yM5sxxgfDPbyH1XxpSzpbk6G/04dcilcjRpQBwJnlfDTPUeZ2NFhlPyQ1hihbv+8KfukxXvQn1yc05bt9F4lMl38rLV8zN8WW7UFb+JJNOBHwphxdcYPQZnzO1CYH7nnvzSTdF6Jv9vlzMlw+qypmNXS+ycZ6gFcKDDg0QcfKezeXJb4/7t+ACTK2d3Sm56F0bfoJ759pO0ASnnb1ckVjfGN/ecs6PolKSE4/bC3usHvYcaID/DM/H4D2+AiRig22J5TYeqkhBlkyCQxA+pbzSagvUhAQu43LGsZCl6xWSxt0eigQQPvy3flVgcI9ErZCJeja2K9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfWL8ShQCahx+UdiAGFqi2QpwbndqpVFhBtxRv1/yUI=;
 b=xRPRrjeh0sM3HbeFD2FWA0tZuIW76UOXIDuvURV3MPPGph8AUH/zNA9AqGAz1XUvoPjN29LXfeW5aKTSXDnPqVQB/ua3oqgV00yEQiBL6k/mEur+5OeN6sHXcpUz7sZFQ5ddEjDqfXAJaTjz1ejbI+ZBiUE70ofF+VKIX8J5h1fzCuD6HYs7HFVcYAJ+zkTXSlm/ppiwiEVL4tBwKaoPWsh5josv2cSdd4CbA2i2+5uhmuD9yjfnHZR5ZdtHj8uuAw6VkTMqHUK75SgArCXaFrUI35lVZAdHw5dx0EA+0sdMeVr8zfFGjJd2UoxAWVqCO7pNZgiQRr6bqCIvD61eog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfWL8ShQCahx+UdiAGFqi2QpwbndqpVFhBtxRv1/yUI=;
 b=vNqEY//En7689vGUbSGX/RYHG4j6iK2+KIjOmN1CbX4a8SjswyFM/qF8tWsGgJ780BrXaYtD9DS82zMAUJu5hZg6zfcTP8C1xexhLVJ+GBdWqlzQNRjrGfI752Dh+VriIoDJ0oLtnTJbHh4ItSe6p017dTMy4Cqcj+RbquDUESuyKl0+NgK5NtOU3hCzejX1hfM3ZFTrN2n3GyDgomX0Ea0efVG3L6FYJWAKYS+yx3U72QDRUPhyYLoUnyXpIeGByhIIpIIOY0EUcEZyfyUjOzDr+JbBd9rl4IE4GbAxu8ml6y47DD59aF5lp5ARP4phEKU1ZpbCPji/nxQfaqmjRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by VI0PR08MB10990.eurprd08.prod.outlook.com (2603:10a6:800:252::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.7; Wed, 26 Aug
 2026 13:49:58 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0382.004; Wed, 26 Aug 2026
 13:49:58 +0000
Message-ID: <f0b0023d-385c-4a47-8672-f06e01ea3211@virtuozzo.com>
Date: Wed, 26 Aug 2026 15:49:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] qcow2: repair a dirty image when it becomes
 writable
To: Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-stable@nongnu.org
References: <20260824133729.1141990-1-den@openvz.org>
 <20260824133729.1141990-6-den@openvz.org> <87ld9umth3.fsf@pond.sub.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <87ld9umth3.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0048.eurprd03.prod.outlook.com
 (2603:10a6:803:118::37) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|VI0PR08MB10990:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f4fd10b-b292-4891-1836-08df0378eace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10070799003|3023799007|10067099003|56012099006|4143699003|5023799004|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dl66ox5E07dLQz/NNr9OVqvx1emaZeUALz+nGNuq6Xuo/87N9ozxXUM9biZJSWsketloSoSGPAYLQ4U9SAMA/yzYuQRE+NNLhVY2Kbwi4OnXwJ+lpd00L6/W1ZxrsIa/tyIl7+mLD3NI9GxKy0/SiA7Lox27HEIlDVtQ+BUaGfLaUQPi4f8ojPGIYksww4YKB7Rr+70EPWKcxMK4orHlNUARCDBa7Ozbwjvrxj7TdpHB8tqt+QlX1jIQ/+155mvhEKmS43ZmQEoOwrcKjL0Kn9TBElyf/5QG3MtOnsdbZJDQEvzLvSW13AlayMgadeqHoUmw6f8O3e4QmNvKRS5H3IKDoCu3H9NOLXru6nyWHGNasLKIBptBvUdDmpHVvPnjcqok+cNgOrfvQQ6hjl7tzE3p3yF3FMZpxMIYecgNSzl3hTikA+Z9nRWJvDES6fWvV6AjiIcST9ckyFSdVTZ/lILuYm5+j4gOiGtv7BfeLSmzVkxkbt6XbHzBKaRhIrWCTcdeTvB+8pG2aTrfYxR4HXCrFmDLKKeGMDAKz8EaYEFWBqyMwT6ubL1yE+Q4cqJCdmQ8oXmWayM5HxOoeRlLoEszLgFWXmC7s8QMSqzFMTk9rUuTsPsAVQKQJP6ap8HWNpz/q6GTX0JL4N5uiqL4utHK/CFqmuVIBKuzhC0Wcjo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10070799003)(3023799007)(10067099003)(56012099006)(4143699003)(5023799004)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0lvOUJqVStWOHdQMzBxS2l1L0hhdTlsVThvcGQ0aFp3U2RxTHJSL3RjUm5v?=
 =?utf-8?B?aS92NXYyNXdnL3A3V0pIR1RCNmJZRjVHMnJHUDE0eWJZMlRqQWNCa09DRDly?=
 =?utf-8?B?dVN3akVaOFV4aG1zSS9oL3hWQkZnYVI2b0l4WDRQUUZuUTRsU0c2SE0xd05Z?=
 =?utf-8?B?TGdhRDVJd09kZmE5bEZTR2ZhNHZVckdHUXQzeW1ENmR1WktJSXczM3JRMnk3?=
 =?utf-8?B?ZW5EMkdlcTN1SVVPT2FZTGJBRTdWaW1FQ1JDUkNZaENtSEkydWIzQnozY2dy?=
 =?utf-8?B?R0FsYjZzbVl0N0xwdXBIWk1EdHRJL3BqZHBCMDcxdHBHY0FzeGRpUTBCK3Nm?=
 =?utf-8?B?R215amoyaDNuWjZySERBK0Fmc0crMVBwcDdmQ2pLS0h6aTl1K0xueFhDM2k0?=
 =?utf-8?B?TmZmTlhqbXN6ZWw3ckFXSEJHOWV4dnZwUmljcjBsVS80ME1Ydm9DV20wOTdY?=
 =?utf-8?B?bVNwQUNvQWRYS1EzZ3laR0Iza0g2UUJCSk1SdnErcXdVRlBSSWJDSEV0bk4z?=
 =?utf-8?B?R2F4cU5RY3lGS3VNNkNQVmpWRXJHdXBLaWlRazYycHBKeG5aOTBMUnNtRWhW?=
 =?utf-8?B?Sk1tdjFjQVZVZnNqSXlsMmhhcXVzbjduMm9GMWJGYjBYdStIR1Q1d1dxMFdq?=
 =?utf-8?B?WGJ3cGxvZ28yN2dYb092SGwrMkIycnpZN213c1NTR3dSeENBWjhSSVJML0NR?=
 =?utf-8?B?Vml1ZjNjdFpFS2Jndm9uZjFVRXd0ekZERmNDT1hIckJZZzF2a2tjbjVMdGYy?=
 =?utf-8?B?UzRncnpwVWtFbjRremxwQy9mQkZTYnZqcklUMFZqbkt1Vk02YzJaRitJNXpQ?=
 =?utf-8?B?dVMwUXFMT2pxS3lZbUdybW9qQ0QzUi9UL1E5ZzdJb0Y0TENpVmxTY3laNjFX?=
 =?utf-8?B?NWg0N1crVjNxazh6cDB4YUkybDRPM3F4U0lLNmZnMWVHeWQ1bU54eVZGM05G?=
 =?utf-8?B?V3V2QTJ0eFBJM2tobWxRcCtZeWVYL09TVkxQaFdtTm9BYlYrNGh1WHQ4Yy9a?=
 =?utf-8?B?cTdUbUhCdllSeC80dGlsbXRzQU9yWVEwZG04SW1IK05IOEt4SG9YUDl2bFFG?=
 =?utf-8?B?ZW9SL0YyOFJTYVZJTEhmcUIvV3JvdE5JVlc0b1RXbUlpbENST1JJTWJVQXVZ?=
 =?utf-8?B?RHZaYU8vb0lERFpzdmJlM2VGMklkZldHck9EWHpnM0JraUpVOWtob01KTklH?=
 =?utf-8?B?SW0wRnNkdnpGbGJtdlBQTC9wL283M0JvQ3FNalhtRm8yYmZNd3oyeTJwdkRU?=
 =?utf-8?B?a3RhRDdPS1JJVnVWa2pQMGdYQlBrak0xUW9yQ1RvVDExbEFrbnVreXNTYzZZ?=
 =?utf-8?B?Z0FvOXZqdWxid3BrOVJ4ekN5QitpWm5GNTBiMjc2ZHNqQ1kxc2JnTXA4bWtT?=
 =?utf-8?B?dEVNZ3k4TGc2S2V5V01YVTJjVVVITitCU1RmRkFnOWRXY3hvSmF2SnhDd1lq?=
 =?utf-8?B?Q0JNbnJFRVRsazNFK0xZVVkxOStPR2pVY25TNUR0WEVTRHlUaVZUd3J5R3I5?=
 =?utf-8?B?cjhxdmJ4ZUd6NENhcFJZY1hwc1FtYjNyZzdYK3QrMEJRanQ3T2pCV2E4Vno4?=
 =?utf-8?B?MVhnRys0R3JLTlVkUWhZTnpUMFgrcWx5aGRDbHFhRzVzcnNUcTA1d2R6c1Y2?=
 =?utf-8?B?VEUxOHkrc0d5R1BmZThvRWxBejlSVi84TTBSTW5TNkt1S3ZQeDhobUU1MXpP?=
 =?utf-8?B?TFQycElOL0t3NGNIZVlWWi9mTHpxbCtaMk44eFZYS3J2NnE1TlJWQXhVK2Iy?=
 =?utf-8?B?KzdlbkN1Ulg2RkVLY2dSUVBjMEg2RmYySHMwblF6Vlo4dktSRWVQVmk0d1Vl?=
 =?utf-8?B?ODU5YVRoZER5WmJqbjZ6MlNtMFJxZ0ZEaHUwVUtaZ2VjN2Q1NXdYa2VxaEto?=
 =?utf-8?B?ZnV1Y3B1S2lTbjlDVnJtTllxVUtVMFdJQkNNMkl2bzcwN1I2K3ozb1RBbGJq?=
 =?utf-8?B?ZGIvK2tDMEtjOFRPdzN2K3RSRDlGQWNhSW8xRzlkanJ3azIyZUM4dnJSaHVi?=
 =?utf-8?B?QmlTSDhKYkZmN3ZoZTd3aHF2b1RiWEFsVzBzVCtRMWp0NlphdU0yam14NzNk?=
 =?utf-8?B?RWpYazJvZVdYQ2xDbW9nbmt3QW5tWmJsWTh3Q2N1cmlObU1iU0c2UmdnTG9a?=
 =?utf-8?B?UjVMVXVrWEVBS2NYLzJ3NW8zVzRKTnlYZDUvb0gzbHF1WnJWaDZUVUlYSHNV?=
 =?utf-8?B?UHBlZGl1c1Flayt0R1JQbkRIUjNMbjdrbjNLRzhmYldZRnFBV05BcE5NSnUy?=
 =?utf-8?B?QlRQTmV4MVI3NTZuMnVUTTZvNDFkd2Uxd0J2aHBIMTYwQXpyMFJsL09aSW90?=
 =?utf-8?B?dzhLWlptb0I5Wnh2SEF5NWhVdTFva3Y4YnR0b2FxRHdDY2NsaTlVa1hNUnFJ?=
 =?utf-8?Q?YmL4KMAg17tp8KIbwTIadd7CEMs1eFAGVaaZxUPmzIifR?=
X-MS-Exchange-AntiSpam-MessageData-1: RHCZYzvPhdTQdQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4fd10b-b292-4891-1836-08df0378eace
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 13:49:58.1872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ytF+J6KPnERMRJ/7qZ2ap7NfAcMGENIDF7BG1b03VQUNwn3N4SnG8t1es/svQVa39jOzjQ3fqfXghIVWq2wwqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10990
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=den@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

On 8/25/26 11:37, Markus Armbruster wrote:
> "Denis V. Lunev" <den@openvz.org> writes:
>
>> From: Denis V. Lunev <den@openvz.org>
>>
>> A dirty image must be repaired before anything allocates a cluster in
>> it. qcow2_do_open() does that, but only for a node that is writable
>> from the start. A node opened read-only skips it, and nothing revisits
>> the question once that node becomes writable, which block-commit does
>> routinely: commit_active_start() and commit_start() reopen the base
>> read-write for the duration of the job.
>>
>> With lazy refcounts the on-disk refcount block then still accounts for
>> the metadata clusters only, so the allocator restarts at the front of
>> the image and hands out clusters that L2 entries point at. Two guest
>> offsets end up sharing one host cluster. Nothing fails, the corrupt bit
>> stays clear, and a clean close clears the dirty bit, so no later open
>> repairs the image either. The bit also stays set for the whole writable
>> session, so a node which is merely writable says nothing.
>>
>> Refusing the reopen instead is simpler and keeps it atomic, but it
>> leaves nowhere to go: the base belongs to a chain the VM has open, so
>> the qemu-img check -r such an error would ask for cannot take the write
>> lock it needs. The repair does the trick in most cases anyway.
>>
>> Do the repair in qcow2_reopen_commit_post(), the earliest point where
>> the node is writable. An inactive node is skipped: bdrv_activate() calls
>> qcow2_do_open() again through qcow2_co_invalidate_cache().
>>
>> commit_post cannot reject the reopen, so a failed repair takes the
>> driver away from the node instead, which is what stops writes from
>> aliasing live clusters. qcow2_signal_corruption() does that as well,
>> but it also sends BLOCK_IMAGE_CORRUPTED and sets the corrupt bit,
>> which qcow2_do_open() honours by refusing every later read-write open.
>> The image is dirty and unrepaired, not corrupt, and qemu-img check -r
>> still fixes it, so neither belongs here. Return the error and skip
>> the bitmaps.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Hanna Reitz <hreitz@redhat.com>
>> CC: Eric Blake <eblake@redhat.com>
>> CC: Markus Armbruster <armbru@redhat.com>
>> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> Cc: qemu-stable@nongnu.org
> [...]
>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 199efc1e00..940249a5e5 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -1852,6 +1852,9 @@
>    ##
>    # @change-backing-file:
>    #
>    # Change the backing file in the image file metadata.  This does not
>    # cause QEMU to reopen the image file to reparse the backing filename
>    # (it may, however, perform a reopen to change permissions from r/o ->
>>  # r/w -> r/o, if needed).  The new backing file string is written into
>>  # the image file metadata, and the QEMU internal strings are updated.
>>  #
>> +# A dirty qcow2 image is repaired during that reopen, which blocks
>> +# other requests and can fail the command.
> Pardon my ignorance: what makes a qcow2 image dirty?
usual obvious reasons are SIGKILL to qemu process (f.e. from OOM)
or node crash.


> Can you give me an idea of what other requests could be blocked?
Before the patch reopen was smooth - we have just opened the
file again. After this patch in a very unlikely corner case
potentially lengthy procedure has been added - full image
consistency check. Guest IO is stuck until the check will be
completed.

The case is unfortunately real for production.

> Double-checking: "that reopen" is the one to change permissions,
> i.e. the parenthesis above.  Correct?
yes

>> +#
>>  # @image-node-name: The name of the block driver state node of the
>>  #     image to modify.  The "device" argument is used to verify
>>  #     "image-node-name" is in the chain described by "device".
>> @@ -1891,6 +1894,9 @@
>    ##
>    # @block-commit:
>    #
>    # Live commit of data from overlay image nodes into backing nodes -
>    # i.e., writes data between 'top' and 'base' into 'base'.
>    #
>    # If top == base, that is an error.  If top has no overlays on top of
>    # it, or if it is in use by a writer, the job will not be completed by
>    # itself.  The user needs to complete the job with the `job-complete`
>    # command after getting the ready event.  (Since 2.0)
>    #
>    # If the base image is smaller than top, then the base image will be
>    # resized to be the same size as top.  If top is smaller than the base
>    # image, the base will not be truncated.  If you want the base image
>>  # size to match the size of the smaller top, you can safely truncate
>>  # it yourself once the commit operation successfully completes.
>>  #
>> +# The base is opened read-write.  A dirty qcow2 base is repaired
>> +# first, which blocks other requests and can fail the command.
>> +#
>>  # @job-id: identifier for the newly-created block job.  If omitted,
>>  #     the device name will be used.  (Since 2.7)
>>  #
>> @@ -2902,6 +2908,9 @@
>    ##
>    # @block-stream:
>    #
>    # Copy data from a backing file into a block device.
>
> [...]
>
>>  # On successful completion the image file is updated to drop the
>>  # backing file and the `BLOCK_JOB_COMPLETED` event is emitted.
>>  #
>> +# The top image is opened read-write.  A dirty qcow2 image is repaired
>> +# first, which blocks other requests and can fail the command.
>> +#
>>  # In case @device is a filter node, `block-stream` modifies the first
>>  # non-filter overlay node below it to point to the new backing node
>>  # instead of modifying @device itself.
>> @@ -4989,6 +4998,16 @@
>    ##
>    # @blockdev-reopen:
>    #
>    # Reopens one or more block devices using the given set of options.
>    # Any option not specified will be reset to its default value
>    # regardless of its previous status.  If an option cannot be changed
>    # or a particular driver does not support reopening then the command
>    # will return an error.  All devices in the list are reopened in one
>>  # transaction, so if one of them fails then the whole transaction is
>>  # cancelled.
>>  #
>> +# An error is also returned when a device cannot be used once it has
>> +# been reopened.  Such a reopen is not undone, so an error does not
>> +# always mean that nothing has changed.
> Could that be a problem?
Error reply as itself is not a problem. The situation as a whole
is a real pain in the ass.

The problem is that such images exists in production and there
is not way to handle this without downtime.

Under this patch we are trying to fix things hard and this is
correct thing to do - on RW image we are doing exactly the
same thing. If automation is unable to fix - the guest denies
starting.

Here we report an error and render guest as unusable. This
case is expected to be extremely rare but technically possible.

This is a problem.

>> +#                                        A node the driver gave up on
>> +# serves nothing at all: it keeps its image open, makes
>> +# `query-named-block-nodes` fail for as long as it is in the graph,
>> +# and `blockdev-del` removes it only once nothing refers to it.
>> +#
>> +# Reopening a dirty qcow2 image read-write repairs it first, which
>> +# blocks other requests and can fail the command.
>> +#
>>  # The command receives a list of block devices to reopen.  For each
>>  # one of them, the top-level @node-name option (from
>>  # `BlockdevOptions`) must be specified and is used to select the block
> These documentation updates suggest the patch affects commands
> change-backing-file, block-commit, block-stream, and blockdev-reopen.
> Is that correct?
>
> Would it make sense to list them in the commit message?
That is simple thing. Will add :-)

Thank you,
    Den

