Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C3CC982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x78jr-0001NW-En; Thu, 17 Sep 2026 05:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1x78jp-0001N1-3x
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:49:05 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1x78jk-000310-QL
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:49:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IH7TOEN4iFlYrRt4xeC9NIe0p0IMNJ+7qYY81lw8eKOjY2WWz4+OJ300D/m8WZwmyOcm3mDPT7fmY/aCLPqoo1nSlD62VP1nNA5JeHCzXF6rhP6KYP2OwNf7Q9s3Ik39ICiVYkuU40OcIS+zhoy2AqV3cKHi0sePvz78up03FSpzngwym9BbO72+IgIbWxqK6f/QNm5z39DpZ5caIf6THJU4hLfvDgw7Z7Dv59WK0EWWMcd2n2CzpC0IB0EIwQxr18QOdpkiIgUYTbNfsPyVqujbDZKsLbxkCvZbOOZoDhrMc22Mo6zuJ7A1Suv37vaqCxyZd/6SOmIkri3TU3rY0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4qhcymvWO8UXv6Xxt/SWCLx0GlwCEXEnL6Q5XuU1+U=;
 b=SzUmUBJ+Wa6of4D8WaYlffEmg+Rlm6qZ+3bdRCJKCfS0UNnICCP2i/mkNe2nG6XNuKv5zHwzqTYJ4kSiYaBFdEZssX68AOk9z+sMePa+NH9pepe8QAgj4Nxys6/7WDitGd6dtkbwIqHmhu72LoT4INk0Yz1/Vf9Jlf1+RaoeR5ydOqTXsMVgNvS+fNt1ra+e90f/RQPjq2+HUBPElihAMQ2tBUO/a3firFp7Qmb4xrSs+xjb+mc1sPrICeh546epVl/Xor6uskYfYsGdRhmNU9y20C3STyFoyD1KdAD4CvOCAMPJnXBDIMkxNDQDpaCxa/Cw5o2w8tcIiEuGnsO+sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4qhcymvWO8UXv6Xxt/SWCLx0GlwCEXEnL6Q5XuU1+U=;
 b=Sde0jDVHM2bhCqvxiRomUzRXq79C8pYUwU5qu/baWbF0/S+NtUT9JhLXnhO/TR4eQsgn+r5OCXNoQLraVT9x3LXEtD9rduVJrms8csN7fnJbCQFJ9rRgQDEm7MbCcwHqI0woOGLCMnTvaLMhDrjazLpsZ4b4zC7+VyTfHcnfdyNAM9nrCcoxzlqvEIuAaDo+WwWafT9r9Qm0TIPJ9u1C1tDI0jQxtFR/FDUr1PDO7BlnzPcew4Drf6wI6cw1000ME57wt7sOZ0Q05ivgOR3ba1JQ+am8ITCK5+jwKV8dfohvEE3cClTYIa9SRo+9+ZpUkLVUgBT2yQnGTAZ6D5U2tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AM9PR08MB6242.eurprd08.prod.outlook.com (2603:10a6:20b:283::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Thu, 17 Sep
 2026 09:48:53 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%6]) with mapi id 15.21.0451.004; Thu, 17 Sep 2026
 09:48:53 +0000
Message-ID: <2dc82f7a-9132-487c-92a6-000bfa32e085@virtuozzo.com>
Date: Thu, 17 Sep 2026 11:48:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] migration/cpr: lock the cpr state
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, "Denis V. Lunev" <den@openvz.org>,
 qemu-devel@nongnu.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>
References: <20260916132428.1628553-1-den@openvz.org>
 <aqrhPxFO7zHvZgs5@zhexu-thinkpadt14gen5.rmtcaon.csb> <87v785rpml.fsf@suse.de>
 <c7cef33d-5f23-493a-b437-e55a3b48736d@virtuozzo.com>
 <aqr_ZzShIhXG8oTk@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <aqr_ZzShIhXG8oTk@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P195CA0035.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::24) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AM9PR08MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e5193d-4008-4f81-10d1-08df14a0e27e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|23010399003|366016|18002099003|22082099003|4143699003|10067099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: JCFTyF9KONctAfU8SzseWpz3lt6uS0UKDYxE9Q1KVPRLt0CcqpgFhoiD1L0Ewm9ohZclVUsMs3LXubFEFGjC1O7Irk96xN+dpTrhV4zJSW1/9zmUFv9xvSRgJ+6AbaTNJ4vZ+qkvkxXb8/OsXeqe8l3PWeAXT2hncSWe36BmZ/m1KGcHyGm1cyzyDrgF0/PtxCclTqpRSawbfB4FBJ5FLBeq3/jYINWI+pf1y0rfcXa+m4Dy9ITKYOn0L0moK1hyn5WHfSp07IemZarLvQ0o/4Uwf76VQOh0DQ30saXrEjdQiHSXhVDTtkwyMXiBQETncfJdqnPaxQFrdv+fErsGeeOdZV9PiFrtmrRYuSSXYeHf3vk4D+DJMZfYQbI3l4w1PGWCVgEi2wLjxzWLpwCVNzTE9nVFNWYTxs9CXbaWEX5ND/JSf+/FT1eUozCo9nL5sdhFYUP41c3rlwLnM9GoRIOdWxe5qMEhDysPI5kO4V9+v50zsb0qixiVqd4/IQqL4HjtxrNg+V9ZHb0xL1mDKRJ1x3gRjaIBy3fQ+6yj4OqGlrxx7/tVNp2evyobiHG8BEXeP2M4LMDVt9BksbjmUYDrZlrka0lOSsFRo5J7BTT1UtH7rGxjkO9JK3qTHG6YRlajpQKjT7zZIDwqh2XMT3mtzAcRQCiX0sGgvuBWqF0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(23010399003)(366016)(18002099003)(22082099003)(4143699003)(10067099003)(5023799004)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkNvVDBBUEwwV1dCLzB3d0EzRFd3bW83bWFZU2N1UXNncDhMenBwdUpsR0pL?=
 =?utf-8?B?STdRdER0aldCVklwWEkvS0x5MjVnYndZTWFXN1RidUJLakVVNWhEMkxMVGpF?=
 =?utf-8?B?VG9OQW8rZHdxWXJYYitLUU9RcUtWNlFKQmR6SjNGcEVIR3BjMnNBWDB6T3Vu?=
 =?utf-8?B?Q0Qrbkp0L3JXeDF4REN0QTloL1B5cG1rUFFucmxpL2NOL1o3alVzcVVZeThH?=
 =?utf-8?B?UXQvT3hRWWJOMUhXNCtvUE5pdDBJZ3FmRExxWmltOGhiS0dCVUZNL1hJaUtr?=
 =?utf-8?B?SExNUDRuQkNCN24vbzdyTG5NREtxMXFvVThDNDRmWktONjd6cEg4bmw1VEly?=
 =?utf-8?B?cVZOUS9yWWhHalljbnk1aGs2bTQ1eUVVaXJXL3VtZytzbjZyWXV4WDNkU0xu?=
 =?utf-8?B?UlRjbE9sdTZKSFNkR0NDV3U2T2h4akJvZENsRGtHNGZLMXFEbk5iNWVUV3Q5?=
 =?utf-8?B?L2ZrdVdrSURyWHBzU2RvWllUMjcvRlhBYUdvVG5PUld4WExHTER1dmQ1ODJq?=
 =?utf-8?B?UGEvL21KKzFrU1lDWk5zeUFWbnNrRDVKbVNsbTlHVVZBTkVGODZ0eUtTaDRG?=
 =?utf-8?B?bEJYNUl5ZVNySHBKVnlMY1ZZVEhScXF1SnlLdWRwM1dSZGNuZlI3Z05sV1ZL?=
 =?utf-8?B?OUM2TFFOTXhtV0hEMmZ5UGZwL0J0WUpBb3dZR2RMTjhKMFlZcDNuTzJ6YWZ0?=
 =?utf-8?B?WjZqR1RORzA5QW5DQ1FtTktXekl1eGZiTXdnNm05OVN0NE9BV2pZcWVQdkpE?=
 =?utf-8?B?TjNsVEJ0QTQwcTUrRFF2YWJIeHlzMlFOd3RsblBHZ1VIeVpESmJkNjRLdzV1?=
 =?utf-8?B?TjB2dFd0bmh0S2k5SnRJdkFGWXR0R1Q3UjBlOXJYdnhnUEdqOW5FZUg2ZDFw?=
 =?utf-8?B?bnJQdnZMQ3ZoUTJFZzVHdUtrb2FWdW1yK1I4S2Q2aXJmaS9vVzNERTZYU2ZK?=
 =?utf-8?B?TUdrUThKWDdrbTNraytCRisrVjZ6L3BDWWxWNzY5czBoTHlXUWFHNllDeUUx?=
 =?utf-8?B?R1c5RkpqcGJhTnVqUUxQV1REY2RDNS9KTjd3aHdPdU1VeVl6MUZQTjJuZDE4?=
 =?utf-8?B?ajNFdXFJREh5SlpNSFBGT0VObXZmYW1qNWZ6dERuTDYrQlV5cjUveFJVUWtW?=
 =?utf-8?B?Z01FMzAvdkpmWjh1aUUyQWFXN1R5M3luZDhQVnBkQzlFSlA0RVk0R05nbzdi?=
 =?utf-8?B?WFNvM3RnVWhlRys2Vzc4U3JObFllS2NUV0VKRjlOdTdmMUF1MGI5UzhhVEdS?=
 =?utf-8?B?RnI3NCtIYWRXMVhhWFpDQ2F5Z1pwRUZRcSt5bHo0ZmNnU1dXblZ6cUc4T1ZY?=
 =?utf-8?B?OU5VaFpyaTFkY1dmYlpNNnhHb3FQYlFFd2NVSnlWQmxSempKR0c1UDB2NS9p?=
 =?utf-8?B?Ny9MTE80a1J5SGtCOUNDdnFzMzExL01tUG4zS01HVmdYeko0Y2N5OVBxS3VP?=
 =?utf-8?B?c0tQMTZONEdSZXNHSmVjNjBwQURjenliUnJFUTNBMVM1TDZtZjk1OFpBak85?=
 =?utf-8?B?azJBWTYrUDc4Rjc2THVkMnZvR1FRcDNQQnE3VEtyMHRzaE96cGRtRXRHKzNk?=
 =?utf-8?B?L01ab044U0h5MWo2dTNhcnJkcVR6bWoyM2kvT1ZBa055aS9pQ2NhQ0xYYlFZ?=
 =?utf-8?B?K0dZd3dnbmNCY3hzU1BPVFFQSWpGeFJpQTJINjdMSEwyMW8rQ3pGaURGcVdv?=
 =?utf-8?B?aXgxR0p2eUoxTFBnUjlnVkorYXJDbmVhYWZQWllua1pybm1aNTdZbmdjYW5Q?=
 =?utf-8?B?c1h4MGU0dVdUdUlTN1JjOW9wUmlkcnUyTjZmcnJMRVlZY1lYaWJSVXIySVkv?=
 =?utf-8?B?ZGdqOXN2UCtkUmtSY09UaEQ2RjlnS1JPVFRzcThVUnBHY2RJcEo4QkVyOXNZ?=
 =?utf-8?B?MTVqenpESkFnMGdMbnNmbEp5dC9NeVdzU00yemovbkZKTmcxcnlOakVZeWhV?=
 =?utf-8?B?SWQwRkIwWll4OXowQk1GSTh3NkZqdmJZOG5UTE5ON1YwYVRGRHgwOXdoRi8z?=
 =?utf-8?B?U1JXRlFzeG1jc2dYUWcxSnRVRDkzNTZCMUJsUklsZ1ZyeUtWNndraFBBWjUv?=
 =?utf-8?B?WU8yVkEyb1V2dzZNMGJpRkFjNExVYWs5eVpkNmkvSlExdzd3Nmx4QUZXUUFY?=
 =?utf-8?B?MXBuLzl2a3JDcWQxN3ZOakJ2dTFqc1MxZk83Q1M2NFVYbTVWZVprQ1ZPZERN?=
 =?utf-8?B?dGh3L2lmLzVvUHJqcW1RTEFJUHlXVnFJdkl3cGxxMmJkSjFRRG1WR1IvQS9k?=
 =?utf-8?B?YWVYQ3NlbVZ1OFcwUW44bXpmSFZEK0RRTEpXQUV0R2svR2FkN2YrUHk4L0FJ?=
 =?utf-8?B?VUhPQVY1SExvdVhNcEZGZjdzbkRhaUxIR2NHTDQ2aWlyVklvdU4xSWc4ZnY3?=
 =?utf-8?Q?ulMEIQEUUcMORiKPPbK38ElZUtB601haoiTbaCdOlMbqH?=
X-MS-Exchange-AntiSpam-MessageData-1: HMrr+/d0phUJwg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e5193d-4008-4f81-10d1-08df14a0e27e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:48:53.8085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1TusltMsBJLU3zZspIOosL3whL0vS1YGowcJHBYjZlYuw/0e/Hr5TXxQ+0KoIJus66bFhyQU6KtKQMJXZamoOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6242
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=den@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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

On 9/16/26 22:43, Peter Xu wrote:
> On Wed, Sep 16, 2026 at 09:45:56PM +0200, Denis V. Lunev wrote:
>> On 9/16/26 20:57, Fabiano Rosas wrote:
>>> Peter Xu <peterx@redhat.com> writes:
>>>
>>>> On Wed, Sep 16, 2026 at 03:24:28PM +0200, Denis V. Lunev wrote:
>>>>> From: Denis V. Lunev <den@openvz.org>
>>>>>
>>>>> The cpr state is a process wide registry of the resources that have to
>>>>> survive an exec. Entries are added and dropped from realize and teardown
>>>>> paths all over the tree, and a caller has no way to tell which thread the
>>>>> next caller will run in.
>>>>>
>>>>> The state carries no serialization of its own. It is safe today only
>>>>> because its callers happen to hold the BQL, and that is a property of
>>>>> where those callers live rather than anything the interface promises or
>>>>> checks. A caller that is correct within its own subsystem can therefore
>>>>> break this one from a distance: two that overlap corrupt the registry,
>>>>> and the next lookup walks an entry that has already been freed.
>>>>>
>>>>> Give the state a lock of its own instead of relying on that. Entries
>>>>> move when a device is realized, when a resource is handed over, and when
>>>>> a migration starts, so none of this is on a hot path and an uncontended
>>>>> mutex costs nothing.
>>>>>
>>>>> Take the lock in every accessor and across the save and load walks.
>>>>> Holding it over the walk callbacks is safe because none of them comes
>>>>> back through this interface. State that is not reached through these
>>>>> accessors, such as the VFIO device list that hw/vfio manipulates
>>>>> directly, stays outside it.
>>>>>
>>>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>>>> Cc: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>>> Cc: Peter Xu <peterx@redhat.com>
>>>>> Cc: Fabiano Rosas <farosas@suse.de>
>>>>> Cc: Mark Kanda <mark.kanda@oracle.com>
>>>>> Cc: Ben Chaney <bchaney@akamai.com>
>>>>> Cc: Steve Sistare <steven.sistare@oracle.com>
>>>> Is there a real problem anywhere?
>>>>
>>>> My gut feeling is we shouldn't be randomly adding fds into cpr unless we're
>>>> creating a new device or so, which should normally need bql already.
>>>>
>>>> To ask in another way, shall we simply assert bql_locked()?
>>>>
>>>> Thanks,
>>> Fair questions, let's see what Denis says.
>>>
>>> From my point of view, if the work is already done to use a lock, I'd
>>> take it; one less place for us to bother when dealing with BQL issues.
>>>
>>> (on the other hand, I'm not doing any active use or testing of cpr aside
>>> from migration-test, so my opinion is the least important here)
>> The fair answer if the following.
>>
>> 1. Right now FD database is already accessed from main thread and
>>    from vCPU threads (MSIx handling). It is fortunately protected
>>    with BQL.
>>
>> 2. There is no real today problem right now. You are right. The
>>    problem is in downstream.
>>
>> But the problem is real. We either should fix either contract
>> in written - just BQL or add the lock.
>>
>> I do think that CPR have value for the project - devices will
>> come sooner or late and the database is to be protected.
>>
>> This is fair statement for today.
> Thanks for the explanation.
>
> Logically we shouldn't merge anything that only works for downstream but
> not upstream, but I agree this one is sensible on its own.
>
> Perhaps we can add some more info into the commig log?  The vCPU MSIx
> handling, even if not applicable to a real issue, seems to be a good
> example to illustrate the potential problem. In this case, personally I'd
> even prefer stating the fact that "only our downstream is affected, but we
> want to upstream this patch too because .."  these kind of things, rather
> than being obscure on reasoning.
>
> Do you plan to upstream the affected component?  If so, I would still
> suggest to have this patch be together with that series, because that's
> where it really will make a difference (rather than purely wasting pCPU
> cycles on some lock bit..).
>
> Otherwise I don't have a strong opinion, this one is a light change, maint
> cost low (it'll be different if cpr_walk_fd() can take any cb().. but it's
> not the case), we can have it.  I'll leave this to Fabiano to say. Sorry if
> I'm too verbose here.
>
> Thanks,
>
The problems is caused by the external communication sockets
which we are willing to keep, starting from monitor.
Monitor in reality should be kept in the other case
it would be very unclear at which moment libvirt should
start reconnecting.

This adds hooks to socket backend and dances begin.

I will take a look whether this has been sent/discussed and
come with this.

For now we could add comment: we are protected with BQL.
Will this work as a replacement? Both approaches are fine
for me.

Den

