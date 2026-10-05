Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED713CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 08:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDeWW-0000BK-LC; Mon, 05 Oct 2026 04:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xDeWQ-0000B2-Tc; Mon, 05 Oct 2026 04:58:11 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xDeWN-0002RV-1S; Mon, 05 Oct 2026 04:58:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEqQ0e3ykQdmYmnL5vs0hJzytxvXZpYHk11No6T53UrM5eLg81uVn1fUpKBcoZYhzTKMjwHz5QQ+5iJl3l7mFF0pO89xJJY9AFqDuRXziCx6FAtz6AVwlnwglrDkbSH88bmXPDVVCXWibjlGtwx0Eo04lFXI+iqpPaRoqUYwbaHGZj9PQuhnBu0s8feQKhJXC/HBhdFMB+tfVdAsFd5vi0aMI3TTGRlSmb0J3pV3HzhJU6L9/BmeiSShHSFO1OGBLoU+4F61oTs1qmtV+BhKJR9XJNvE/6s0XFU5H+YzO2TGXcLcX2Er/IeMUDraAqYDC5BuroFFF5cW5BdtvFWx2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzyUE0TTwDUS/i5+3vrHWSmNQV0Tnu3WLfwmWis8Sek=;
 b=U+2UVp6XGeaMszAc5Y7cQDoFpX9JXmpH+w9+RDTgP7h0thIRwSWR8e9vnVxR3xhzdV+SZ1jpENV6fVVc59PLb8f5xy9KLxRQV/x+6l1/0DZbCWbZ6cByJPX9SLxtNxl1cDOGhxcGY0AwOs0/WcndzVWqgiD36O/qkZ4V7WsuGKfCkjVE6zwv/pKmf009XX/3oRgDMNTYs+0vAwz3sysc6ivKcUX2z+2BmYOhoYeE8W7LsBn3ANGrcDANctqDOG32xRcc+cVPZ2VaLgUlkfS8/q3vqU8Qd3fEuPT8mRxDpCrhK6LdzqN4HB/3t0beuklw07Y97MBG22I8LTuow/H7Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzyUE0TTwDUS/i5+3vrHWSmNQV0Tnu3WLfwmWis8Sek=;
 b=ISzcunPwTqJu8ktc8qC1ayl0K5rww3AHtZD0uH74mqbFYYmMCIpSDz87Sa4GIUeaJG8ZADPEjOCr0DJSlL5/RRX+o1pNW1ynau3hnr48ex0WvXTvtuO5d1cCTtrQc8waPNqz4YjBAK2Ea6Suu6Ad2sF5kknd4YTQGUpePZFC27qXR4mJ5k8MMSp7A4cEoMUEXmrz44zb4Dp+0SYLC0RH/BMSFOJlJMFQePGiZf+bcxf9a35f4REo8Vm7cBWErHQrjP8itBhHnrNNyex422fE4VvpjHDxMTXr/ljap3g3mzxWaB7q1Sd1bVjxZSLAOgH2iuK6cWOKDGFa/ThsUJcXnw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PA1PR08MB556523.eurprd08.prod.outlook.com (2603:10a6:102:54f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Mon, 5 Oct
 2026 08:57:58 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 08:57:58 +0000
Message-ID: <015fcc1e-31f5-4435-9bf3-5f991e46527f@virtuozzo.com>
Date: Mon, 5 Oct 2026 10:57:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] qcow2: silent corruption when a dirty image
 becomes writable
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-stable@nongnu.org
References: <20260824133729.1141990-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260824133729.1141990-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0127.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::25) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PA1PR08MB556523:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b62c00-7116-4524-7854-08df22bec0b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|10070799003|366016|10067099003|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VLOxHX6WfM00Sr3NwkXhVzyh2yG54WnlImuhPrKspEhTLUvpt3U2aeJZAUJ7blIQhn0BDMfytA+3M9V9XSRQqIm3z2PxhnZE8yQlxTtQjfBlgmgrB3YUupg8K5YaPFvzW2uXHMp/JepG0q23fGeNTcLUsLKdDXyvQJn8tgsRcetlTWUPhk2oy5wUHxSDSTHRGDau65tCQV82U22mkzkBQIPU4YGdCA57HIiuuvz5uefgnDZn5NCSJKPfuBmnJwG5ULrWT7tIcVhVEDVViV+MovfodBCx8x0433v8yeL3CQuohNJWo4w9N2zZKYSdAtqy/41h/UlA5b9Ef1ZIyZ9dZS7LEE6NWyV+5b4i+t6/LYeajLMZEL5pkCvQuYuqjFvokn+6wKvTJuqc1Ta2TlU2hhXNpqkMUC1zMMH5dheja70NR13GGUynJM+bUh4kYI/R+/j+LIuKKZH3lgyXn61ff9HljkukTwCeQVI8hAmcUV07Kw8U3FlLvjOIbSb+Q7HyI5nAX0Rs+0FKDI4V1Jz2SehQvr9bVvgIOqKZxh3PLf+ZKKIvKoDR9Syrs5R8eJhCCDzmmPisVTOyp4b4BbVt5IINX6GAj8/Cb08sp4vriIPzRxjbOFAHh+OJQcOkFwBV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(10070799003)(366016)(10067099003)(56012099006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnZocEtWVVJZR0V6S011UDJLeHQrenp3QlRZSFNIRU4vam8xL2dkOTNPT04x?=
 =?utf-8?B?dUd5ZStYT1ZzbFZ3U3VCQWRNMG4wOTN3bVRFUW9EVW5LVUx2dkVSejRaUEJi?=
 =?utf-8?B?T29nUjIrQXM2YWJUS3N0YXBsRUo2U2Rlb3RHRGJnamEzRyttSkduNmxaNFJt?=
 =?utf-8?B?dSs1cEdDaVFkY05qREZTUHN6VytRdCtyWE9ra21COHRQSE5oKzFkMnFscVl0?=
 =?utf-8?B?RHQ1RXo5Vm9zNU5SMjBBbFRqbmVQUStQeEFsdDFMWDRITjFkNWtHRW4zNGRC?=
 =?utf-8?B?TUFEeDZtWFl2ODhjaFlLOVErVVRDcDFaMG5uN2JwdTdFc1hjSkh4R2d2cWUr?=
 =?utf-8?B?YUxHN3hnb2pJaXhUZXNXSjAwUURHUTNOVEo2YnBudGV2Wmkyc1F2OXB4UUxL?=
 =?utf-8?B?S3B6TEVGK0JuUzBJYjAyL2x6N1ZWcklhN0JNNGtWWUNzTEh4K0Y4TTZHVzd4?=
 =?utf-8?B?ZTNrTS9KaE5pYkhEM09EcDk2TFpRN3A2WTNuZDVTWmtBSEdsZFZsVkVxSS9B?=
 =?utf-8?B?T2hMdHpEVVU1bVcwZFJmZGFvUEZDUU9QODdHYjZmNWxUdHRBZkp6T3JuTGlx?=
 =?utf-8?B?YnhDZ09VQ0VHdkZFay8zY2V6R0llNFE5TEp1OVowck1sVmRJNktwaEkremJi?=
 =?utf-8?B?TzJlcWoxNlZ4UFk0VUYxcDhrSXlyWlpxaVJTREtwclZQYVNRejVPTEVNWGJz?=
 =?utf-8?B?NzAvQ005MitXNkJKVndYZm1vd1lEa3pGanpRQ2xyL3VHdmduNXFkVFgvSkVq?=
 =?utf-8?B?ai85NGZWOU1FY0RMUms2TUZvUnhxbGxJYmtxTGpKdmFEaFNIa2F0eTJCdVBx?=
 =?utf-8?B?ZkZlbXF0OGhVcTVFYkxiMk5HcTRpN0xkc3hyQS9QajNNdjA0Vmd5VUlhN2Q5?=
 =?utf-8?B?ZGNtSFBaUVZFNUlHeXlnVFBhZXlxTHJnZW5UOHFGR3pGaU1hd2tRbURyVjhV?=
 =?utf-8?B?ZER6NDRjRnB6YVFMMjYwaE9vTjZCTTRTdW9YNklZL2pKZDQ1ZTREeHlpaEZB?=
 =?utf-8?B?K0MwUllsRmpjQXhrQkxrUEtNYkU4WXBycDFVV3d1QUxXdUw2b05zV2hXbGMv?=
 =?utf-8?B?OTlReEQ5V3l0RkR6NEFVbXNDd3FyQTk0U09iWDBXVlpPWnk0a2QwQWRRT2ZK?=
 =?utf-8?B?WWk0NGlhSlhSRTRTaEM4cnBCRXB4SGlIWk5CTFllRHgvTVpzRk1Dbm94bHZP?=
 =?utf-8?B?UW0rbjVvRTJLYWZ5WHRPdXArbmI4bmVLRXl6NHhNaUR4ZW5CTXl6MDRmUWl1?=
 =?utf-8?B?NnNLdzg4Z2s4TXAwMEpvekxPTkJtUFRma29KRmpydjlLOVZHMGpwYnlJZ242?=
 =?utf-8?B?V21oTnFXU1l5dnVPKzhxVWRENitEMGNFYVlIdlNBZld3R3hkeVFKMWk2Mk1V?=
 =?utf-8?B?ZUl3K2x5dlNzMjNTQVNqZnlSMC90TFRqZWRKeTZGNXdUYkgwL1VibTk2Y3kr?=
 =?utf-8?B?bTJ4aytxbU0yc1FNaFRjV3hjOFNuZ3hnOVZ5NkU3eWdxNTFieUJOUWtIUVV1?=
 =?utf-8?B?SnYyRTVwSEUxOHF4bFdNL1JxY3o0UVhqREw0YzNqd1l1QmJjSmtTQVFhTDI4?=
 =?utf-8?B?UHl6ZnBjYU1RMnlydWJNWVh2MjJDYkRoVkVkWlNpbG1Gd2krZEttajNaQi9E?=
 =?utf-8?B?R3IyYVBmeHlsY2JadzZZOGpMaUU2U2NCWTJ0OTRUODFiT3g1V3NweWpFMTc5?=
 =?utf-8?B?QlVlSC82OEo2Slg4ZzlEbFg1R0duTVhtempIMWRuZjcvUWRUbnBueDlreUhB?=
 =?utf-8?B?ZlErSjV6SGlZaG5PakpiQ0E1aG9tdHpVelo0Znp5bVVidy8zTUR0Kzh5eDNq?=
 =?utf-8?B?NE9LQ09qbFc3YU1CaUtxcjJlaE0yMkhnY0FuTE4valBQVnVYbVdIWHVDMHF3?=
 =?utf-8?B?Y1FwY3AyS25Va04rL1ppZHlnQjBtaE9FcGZyL1ZIRURkZXhiVndVOXdZdFk3?=
 =?utf-8?B?MU85SG43QmJ1dmlSOEVHVEIzdjNkUW8rclNCYlllaUw5c2dRMGVzVis4NSt0?=
 =?utf-8?B?bE1pUjVUb3FDL1ArNEF0cVFjUlllMm8yc1JPcG5VYVpjS2xMTmUxUFZ2cUhJ?=
 =?utf-8?B?NWdBT0Z5dzNIcCtYaExVWUZacVR1Q0IydWdYR0tsMTRDaUY0cTFLWU5oUkVR?=
 =?utf-8?B?Mk84N3R6QlFwc0htbHBsWFVUblF4cVFwVmUzOFhIY3k5RGdUdmM5SFo2dVBj?=
 =?utf-8?B?eDJ1bUJMMEoxZjBVeEJ3emc5eUhCZ1ovQkkydDFUOVBvQmpqMzQ0bjVsZHpl?=
 =?utf-8?B?bnRhclJyOFRqdUFIV00yUXBva1RxS0pVWCs0ei9kdjdWMzh6Y2lKb1ZvUEpY?=
 =?utf-8?B?b1YvZ2JVajBVTDg3c0FQT2cvNGFEeXlKTWZTVkFwTnQ1TjZUdjRsaWNnUXZo?=
 =?utf-8?Q?yxKiDJN4RRZi5ItjaFH+7TD+i279kEsoahlEfVxCh1IRg?=
X-MS-Exchange-AntiSpam-MessageData-1: rE6BVVXRQB8z/g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b62c00-7116-4524-7854-08df22bec0b8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 08:57:58.4594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: il2c/Ass83YJdEaiy+57upkscBAv7I92w6YdwHRIqRhiHdlgHqTG3EDH6OWwLmVibrqqUZ504y8/lVXSSkDhog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR08MB556523
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=den@virtuozzo.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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

On 8/24/26 15:37, Denis V. Lunev wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> Today I have faced real data corrupt from our customer with the
> situation very close to the one addressed in the patch
> "qcow2: do not try to clear the dirty bit on a read-only node" and
> that is interesting. I was really unsure that design is correct
> but with today case I can say that correct thing was done.
>
> The problem
> -----------
>
> qcow2_do_open() repairs an image carrying QCOW2_INCOMPAT_DIRTY, but only
> for a node that is writable from the start:
>
>     if (!(flags & BDRV_O_CHECK) && bdrv_is_writable(bs) &&
>         (s->incompatible_features & QCOW2_INCOMPAT_DIRTY)) {
>
> A node opened read-only skips it, correctly, since it resolves nothing
> and writes nothing. Nothing revisits the question when that same node
> later becomes writable, and bdrv_reopen() is not an exotic way to get
> there: commit_active_start() and commit_start() both reopen the base
> read-write for the duration of the job, so an ordinary block-commit onto
> a read-only backing file is enough.
>
> With lazy refcounts the refcount blocks are not written again once the
> dirty bit is set, so an image left behind by a killed QEMU has an
> on-disk refcount block that accounts for the metadata clusters and
> nothing else. Every data cluster reads as free. s->free_cluster_index
> starts at 0, so the first allocation after such a reopen starts at the
> front of the image and hands out clusters that L2 entries still point
> at.
>
> The result is aliasing: two guest offsets mapped onto one host cluster,
> so the guest reads back data belonging to some other offset. Nothing
> about this fails. No I/O error is reported, the corrupt bit stays clear,
> and a clean close clears the dirty bit as well, so no later open will
> repair the image either. Afterwards qemu-img check reports
>
>     ERROR cluster N refcount=1 reference=2
>     ERROR cluster N refcount=0 reference=1
>     ERROR OFLAG_COPIED data cluster: l2_entry=<host>|COPIED refcount=0
>
> and the only runtime witness, if something eventually frees one of those
> clusters, is a bare
>
>     qcow2_free_clusters failed: Invalid argument
>
> on stderr, with the guest none the wiser.
>
> How it looked in production
> ---------------------------
>
> A VM was killed while its storage was unavailable, leaving a 100 GiB
> volume dirty. It came back with a snapshot-revert overlay on top, so the
> volume itself was now the read-only backing file, and the overlay was
> committed into it two and a half hours later. 8082 host clusters ended
> up referenced by two L2 entries each, roughly 8 GiB of guest data
> cross-mapped. The guest filesystem began failing metadata verification
> on buffers holding fragments of unrelated files.
>
> Two properties of the damage are worth recording, because they are what
> told us this was not a race:
>
>  - aliasing is exactly two-way, never three or more, which is a single
>    monotonic sweep of the allocator rather than a window hit repeatedly;
>
>  - it stops dead at the host cluster that was the image end at the
>    moment the volume was made writable. Everything allocated after that
>    point is intact.
>
> qemu-img check -r all makes the metadata self-consistent again, and then
> honestly reports no errors, but it cannot un-alias anything. The guest
> data stays wrong.
>
> Reproducer
> ----------
>
> Under a second, no guest and no block job required:
>
>   qemu-img create -f qcow2 -o compat=1.1,lazy_refcounts=on base.qcow2 1G
>   qemu-io -f qcow2 -c "write -P 0xaa 0 100M" -c flush \
>           -c "sigraise 9" base.qcow2
>
>   qemu-io -r -f qcow2 base.qcow2 \
>       <<< $'reopen -w\nwrite -P 0xbb 900M 100M\nquit'
>
>   qemu-io -r -f qcow2 -c "read -v 0 16" base.qcow2
>   # 00000000:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>
> The flush is load-bearing: it writes out the L2 cache but not the
> refcount blocks, which is exactly the asymmetry the bug needs. Guest
> fsyncs supply it in production, so a long-running VM is the ideal
> victim. qemu-img commit of an overlay reaches the same state through
> commit_active_start().
> v1:
> https://lore.kernel.org/qemu-devel/20260731220039.1765584-1-den@openvz.org/
> v2:
> https://lore.kernel.org/qemu-devel/20260811173857.396571-1-den@openvz.org/
> v3:
> https://lore.kernel.org/qemu-devel/20260819120558.3870413-1-den@openvz.org/
>
> Notes for review
> ----------------
>
>  - The repair still runs under bdrv_drain_all(), so a block-commit onto
>    a large dirty base stalls guest I/O for the length of a full metadata
>    scan. Rejecting the reopen instead would be cheap, but block-commit
>    depends on it succeeding, so repairing in place is the only option.
>
>  - .bdrv_reopen_commit_post() runs after the transaction is committed
>    and cannot roll anything back, so a negative return value reports an
>    unusable node rather than rejecting the reopen. That is unusual, and
>    it is the only channel available: there is no failable hook once the
>    node holds BLK_PERM_WRITE.
>
> Changes in v4
> -------------
>
>  - patch 5: block-stream and change-backing-file document the repair as
>    well, they reopen read-write too. (Andrey)
>  - patch 5: the message says why a failed repair does not mark the image
>    corrupt. (Andrey)
>  - patch 5: each of those notes is one or two lines now.
>  - Cc: qemu-stable restored, QAPI maintainers added to patch 5.
>
> Changes in v3
> -------------
>
>  - patch 1: the same bug aborts QEMU, not only fails a reopen, when the
>    file node below is writable; the message says so and iotests 039
>    covers the read-write to read-only direction as well. (Andrey)
>  - patch 2: new, a reopen of a node whose driver is gone segfaults in
>    bdrv_reopen_queue_child() and asserts in bdrv_reopen_prepare(), which
>    is the crash a failed repair would reach through commit_clean();
>    bdrv_reopen_prepare() reports it instead, iotests 060 covers it.
>    (Andrey)
>  - patch 3: bdrv_reopen_multiple() documents that a failure means either
>    nothing changed or the reopen went through and left an unusable tree;
>    no caller changes. (Andrey)
>  - patch 3: an implementation which fails must set an error, asserted,
>    and the loop skips a node whose driver is already gone.
>  - patch 4: the pre-reopen flags are recorded as int old_flags rather
>    than a bool, with a bdrv_reopen_was_writable() accessor for drivers.
>    (Andrey)
>  - patch 5: the failure names the node and keeps the errno of the check.
>    (Andrey)
>  - patch 5: a failed repair drops the driver instead of calling
>    qcow2_signal_corruption(), which would write the corrupt bit into the
>    header for what may be a transient ENOSPC.
>  - patch 5: blockdev-reopen and block-commit document the failure and the
>    state it leaves. (Andrey)
>  - patch 5: iotests 040 covers a commit onto a dirty base through both
>    commit_start() and commit_active_start(), and the failed repair.
>    (Andrey)
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Eric Blake <eblake@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Cc: qemu-stable@nongnu.org
>
> Denis V. Lunev (5):
>   qcow2: do not clear the dirty bit when reopening a read-only node
>   block: reject a reopen of an unusable node instead of crashing
>   block: let bdrv_reopen_commit_post() report a failure
>   block: remember the flags a reopen starts from
>   qcow2: repair a dirty image when it becomes writable
>
>  block.c                          |  55 ++++++++++++--
>  block/qcow2.c                    |  33 ++++++++-
>  include/block/block-common.h     |   1 +
>  include/block/block_int-common.h |  11 ++-
>  qapi/block-core.json             |  19 +++++
>  tests/qemu-iotests/039           | 110 ++++++++++++++++++++++++++++
>  tests/qemu-iotests/039.out       |  56 ++++++++++++++
>  tests/qemu-iotests/040           | 122 +++++++++++++++++++++++++++++++
>  tests/qemu-iotests/040.out       |   4 +-
>  tests/qemu-iotests/060           |  30 ++++++++
>  tests/qemu-iotests/060.out       |  13 ++++
>  11 files changed, 439 insertions(+), 15 deletions(-)
>
>
> base-commit: fa19879df1658f96ac07365fca8835b7decd6995
ping

