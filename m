Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3A7C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 19:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8jsv-00016a-3J; Mon, 21 Sep 2026 15:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x8jsr-00010S-8h; Mon, 21 Sep 2026 15:41:01 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x8jso-0000Us-Me; Mon, 21 Sep 2026 15:41:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dk/QIv8KaRmy2XusS4r16nY3GtxOa582o/YUl3DS+Ji8wJ4Cgvj57y2dCbdmajcbqyyeFFW4IsGT7ev/vqipPKPb+pSz3U7AgqKfTwSudMbJHniI0G5guaVaHfSRTOAggUbzbIWJc8GHRdz616Ydk51bMM4Yq2ueGGCkigUSni/5IdnvZdkKlaB+dRcs/zJxSeo6m6MXs3GzSq1vPuCfdtvBCrOuryisQFKFWQDvu63wM1a0NsO1JpmYPMinzEezQoGMD6174FellgBryZzOxlwZNHJJPPSH9Iw9n+5s1Rsg+r0co2hOsNx8XwLuRH883TbbLG/3lEWCsYhf1WSq+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzyUE0TTwDUS/i5+3vrHWSmNQV0Tnu3WLfwmWis8Sek=;
 b=khkuWv6V5RBPhnDdhmPPvYTPuMTg0CvvveZBCfkeOFMwISe5hD8n66gEy8eSb7ottFH+2SiQXlrt0VdCMpZw73idPr1G+xPNPBjGwiV5GKWFbALgMNA0+4q6u2H099k058fJieeV8I56o44y9kEiKdWfSdPFW9eEHrmLnInUO5BHfPJjNdPms6PERMCv26f0sA1Zw3yjh36OgICd73iif7DGyw+eY6zdyb77fL9PpUQ0naLnhZtJBSghUGh/e+vAOFJwnXSI33gxweCnjfXjganol95ZARxRly2OFqNm67u1Q9p0nM/KGFL633InIiYpD5/v3lFTEidNpKkY0gM2Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzyUE0TTwDUS/i5+3vrHWSmNQV0Tnu3WLfwmWis8Sek=;
 b=KGNtozrGas91P+a6Fhbx30i2p4IK6TGP36gyYHOsOjY/Io+YlbGd4yK2gXvnMobpPs8NPpYXrD/G9hlwWjKLX0EpHouFZ4CiqBtO4NMHkwePVFhBjc8fIbzrVhWXzwpB6t46pKml1LIUWxIllKVYVFgwJvkMsG9DrSWGSSZKic5pccDCvhCPy+BWqAptaz8Xgzm33Lxk5FQHdQ7nCf9m/jyc31+RQSAv4VZN2PaTCw6LGEtbdX4LEpp3sR5GzS+vserYyrU3teI3KOiK2isONhO63EC0MJYiV7/LUvJug98gajMHkje75Yw0uyvwwRu22fn54reYYDEW86aIAF0mtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DB9PR08MB9588.eurprd08.prod.outlook.com (2603:10a6:10:45e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Mon, 21 Sep
 2026 19:40:54 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%6]) with mapi id 15.21.0451.012; Mon, 21 Sep 2026
 19:40:54 +0000
Message-ID: <cc962efb-4d42-444b-9dd3-83e229150466@virtuozzo.com>
Date: Mon, 21 Sep 2026 21:40:51 +0200
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
X-ClientProxiedBy: VI1PR0102CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::19) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DB9PR08MB9588:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c35da3-7ae4-4aa9-d80c-08df18183f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|10070799003|376014|366016|10067099003|22082099003|5023799004|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: gi7JNMDJIMhT+qmo0uTqSTRmNOJo2eHTq2rE0qPbT3NwXoNrjvrOVGLQLyxD12rJXQ95jemhjpBLD7WlZBcSc68ABDGmw5XPTIgiMmiyW5j1dtQy6rGmfXfdT9Gp9hlBQE4d2X+xpNcK+xDq8/0Lu36MXJs3IAy3Lyc3QY84SJdh2f/dDQm4SJ/yndA7Ql6RJHwhqCmsvcMXaMXMMmOoPiXgXLEDyukdqAMulscCVngmUgaM6ncaAaKgnD/wXhSxk83aEhK2Pnc5Vt6JVc3xDFiHP5XasLsSZK62avUVHCKUlktjivqnPlQao8WtNP4bG+4bPZZ7ZRM57nueTUrw1BBLWUjmuI4P/XI2lbXPGKIBTmKLeX2/4ld2VZ9pp5T1hpOQ0yXAvsSY56Nyo/VdlTbpJsiEXLDgOY5Tv+/NLW1oJSfIhAgqN80+gafbnJJbak1d6kI7KmlxZVGzLRs7k8TW4Tm8oj6HuKuza1WH80vfIl7jIWdw50C4lCkIMGriZ8yErSaIXUliXkuziSwZMer0r1LWr9yZIpNy8j5oQjQ/RnECx9ESnLHP2cMwUqWjhW2qzPsNl/1xx+uaIcLhmf6JpsCViDAMHccs6y6BXyWKhKlUvwG9wTy861zOTQGX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(10070799003)(376014)(366016)(10067099003)(22082099003)(5023799004)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUY4aW00L1JiNENUTzRRejNIQmFLK05Lc09BbHUxQXJCY2s5TUhCTzd1N3Uv?=
 =?utf-8?B?dGlPQk9vMFFsdzhuU2hBOC9kY2xTVFZTaWlOMit5NmxLTUdkNkY1SCs2YXE5?=
 =?utf-8?B?TFhhRlA3eUUxQjlCYXlZMDVsY0gyU0dYRHlHVUlaUlpKdFVQR294V0Jtb2RY?=
 =?utf-8?B?alhrTEZJVjA5cHJTTm5PeVpsNE9yNVFoMllTOXpYNGFHaXMzekNVYkNoeTVJ?=
 =?utf-8?B?WmxOVDBNTytOMHJBWFhIOERKbVEvdFp2bzFaZklCRHduYkYrQnBaeHBGL1VP?=
 =?utf-8?B?UFYzL3ZjUElGM0dkV2NVcklUWlQwSWEybSthSjJFdXZhTnRCQ0VCdDRpN0d2?=
 =?utf-8?B?MzB6akhwNTNmN1pZZkptYlBaOExwVkkyRWdETmVMZyt6S2N3L2lEQXNlZHBw?=
 =?utf-8?B?WTBadzBwTXNVT01JWTdJNDdyWXo1a1NNMngxbEIyNUw2TklyVStNSU94dWxl?=
 =?utf-8?B?aElnRDY1UGcranVzeVlaeEFxdUIwb2ZlbkNlaERxWkl4RkRXWEZqOFVvR013?=
 =?utf-8?B?T0wwS083MzM1a3hzbTNaWVo3ZC9nUXA5d3hlWHlxalZ2K3J1eFRMclZ0NnRJ?=
 =?utf-8?B?dUMyYkl3OFI4TDRzV0N2UkFHSDV4YldRWUh1eFRhMVEweXY2U2FZY09BeFFS?=
 =?utf-8?B?MVE2U1Nmanh1alVYc2xGMW13VmJTTEZJRVAzMlIwUW9mMktyRXF0M2FBQW82?=
 =?utf-8?B?am5kQThsa0lxRkNDNTc4bkJZY0w3NWJFdm5GbHdlelkwWjZuOFpwcUdPS25x?=
 =?utf-8?B?d3A5ZGxnY2xtc0lKb3BuOS9mSzlsL0pua0phR1d4MVF4UmVJRVFKcGxNYUJK?=
 =?utf-8?B?eGhCOEsrYWQ1c2FKbXA1SVZrU3ZNTHVQTkFVRXBDK2ErbHV0Y094WlBTTWRG?=
 =?utf-8?B?NzF5aUs5eTZVcUFlN3VSU0N3U1FwK0hYaXpKSkNxZmZHUG5jdkp6WTJ4T2Jl?=
 =?utf-8?B?NktXYklDUjQ3WFpHVGVtN2llajhvYnZJaHIzZHJSNldjdndBVHhXd21HcUtB?=
 =?utf-8?B?NEd2U0MvMkxzRmx3ZVRaSkVrbFNDdjVzMkxsMkp0NXdIUEdhYVBPcTRuZUhx?=
 =?utf-8?B?WG5Sek4zVFZrOFF0WjJyTjM5RndMRnVqNWE0a0traE5EMHAzRWVabHdFdXRU?=
 =?utf-8?B?dGttMi9UV2VOTXNyVlNna3JCNlhkNm5udEhubUpKM1czVmV4WEMyU3FOcnF5?=
 =?utf-8?B?eXVGb0RvajFkdFViZDRqWjhkNHFTdnBRL3BxaGI5ZTdEb29PcE1TU2dXb1NC?=
 =?utf-8?B?UmhXZEVYYmFoNUlJSnBLcUNhRitGSVQ2ZGZ2enIzak9DKzRqQXl6ZTZaSS9S?=
 =?utf-8?B?VWlyV0wvazNRajdicms0M09wcExET3JDK2RSaURMK2dpdDEzOGNWSmZpR0Vj?=
 =?utf-8?B?SXM3OXNHWmdVdGdXVU4vNkdCQ3M2U3dsZnY4VUlKNDFpcisvYjZYZW4waXNV?=
 =?utf-8?B?ZXM1OEhJcFVWSHNSVVpZMzUxK0taTllTcEFIL3IzMzkyTU5Bd2M0MEhNQy9G?=
 =?utf-8?B?SEprNzZHL25EVUdEUUoydUtvbjNEeXhSaEV0ZVRwTld0UndHcEtXOExGZGp1?=
 =?utf-8?B?MGUxTnlUTnFNN1h5NnVDNnl0RXNYYlUydndZM1VDWGJwQWYwSVQyenc4aHhW?=
 =?utf-8?B?WkZTSGFHMUtFekY1TjlISnlzTGhLOWxJYmtKZFhFWmgrTHkxdWQrSDNxMGJw?=
 =?utf-8?B?dTg0UlVlRjdnZUJGcXRId2c0T29kZjFPMzljOFdNNGNta0tSQ1lmVlNDMi9i?=
 =?utf-8?B?S21OMnh4MG1VaU1ocFFCNUFKbHg3ZUV1Z2JOOGdEaittcVpva29INVFTN1Ex?=
 =?utf-8?B?ZW9VUEZoNmlTR3JSM3FTcldXZThYbG1BUFNGZ0JrczF3eXhLdWpDQXpITldI?=
 =?utf-8?B?ckpUb1h6czBnT0Q1a1ZVZGlldno4VERiL2R1Sm1hVkdGOU94dGNhMnl3anhW?=
 =?utf-8?B?cjZOcUl1L2hyT0lRVXI1U0ZyZzh0ZGMzZzkxZ2lTTUxCWjdmZUIxMHNMQ004?=
 =?utf-8?B?bnpNcmY1NDU2WnU5eDc2KzBlMlhhR3I4UEZLemZwSnFLd3h6a3RUWmhSZG1Q?=
 =?utf-8?B?d1AzQm1Qc0ovQUFpMTcveHBIZUlSMEhYWit6SnJWMHo4c0twb1A4T2VBcUN1?=
 =?utf-8?B?N2Q0UksrdGl1QUZuUFZMUUFMNTNxUlB0c3J6NEJBdloxc2V6WUdtMVFLVGhX?=
 =?utf-8?B?TnBXV1NBRjlaNlM4WmxxdEVXOTM5YWx0QndVNTVwL21hSWRreDBFUUZrQ0ly?=
 =?utf-8?B?d2MxVmhSNkF5TkJ2Nk8rUGUzZmVHOWZ6UHRvRUhBMGVJUGtweWtNNGJZemxR?=
 =?utf-8?B?Rk0yb2t1Wm0xQUxUNUV3VXVFdmtOZ3QycTkrL0lTVENjMU90bVNhNTh5dGMx?=
 =?utf-8?Q?R9kOGLwb9+/RMFf9l7omXaNYVHBa1Ll3ZEOsq+T95Is9V?=
X-MS-Exchange-AntiSpam-MessageData-1: wQ/u+DeVEJpWYg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c35da3-7ae4-4aa9-d80c-08df18183f42
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 19:40:54.3350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fhd8F5PJebhOmwnjn/l16JQJd8y+6pG3hra1jkpc9WUqmz8QIm4tsTJHyqZ50x93EMCBdO02ERMXVc8VAkjWbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9588
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=den@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

