Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65656D41D44
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 03:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAhJT-0007uW-AE; Mon, 11 Nov 2024 22:11:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1tAhJQ-0007ti-Ky; Mon, 11 Nov 2024 22:11:28 -0500
Received: from mail-sy4aus01olkn20809.outbound.protection.outlook.com
 ([2a01:111:f403:2819::809]
 helo=AUS01-SY4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@hotmail.com>)
 id 1tAhJP-0000O6-1m; Mon, 11 Nov 2024 22:11:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQmWheEB+kvbm129/Afaj/T/oinZZom+Q2cwaGRJlI8SksI+nrqQVxtp/FV0WN/fXN/33CKyP4dfdr/WUliAfgs3ZpvLTeL97t51qFsKTDgRU0gCIV3a0Q7ByGbJsNQ8QqxoWE1s2TGHu0NCRyVy4ui9BpntiT0RQF6mp9fooo4ReXzdA2+fl3+P1gJbXZQamMb9DoGgdOZy4Jkx+3BMMukeixV/tgVjHoBl+jqnEygb+UDtf3S44z4mXGRXybi/0C8wq1ExGB2djY9qtB27xDyfeTNAW3hz71nKgU4GBoKoLk5mn2QSV7i6vObLJAZyYOW4GQkujoeMzGjo2ClinQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGBiBGgvM+gG5441ZynYlMxM/NVm8FCYKY6zv4QMaow=;
 b=XJKfYZEnZFNrloPCgz5p6olBFte4P0vjuwF4ZkJMXRIYGJzDSvgLPCu4tziZs7rQ1iRZgy/Dvw4zaLKKeL410VhygeVhb6UumFvsdojxVfXm01/hJzsDSKysmUvCvu1Iy/kjEEn/E6ML5J3cnouiSKK22Q9qu0a66ajqsDV1r1Z5ymMUcgG22GQ9D6VkUiFM+9tfyTQ3hL56/IB4hYpy/omx+pe8wm7424N10GmmEpsB9GF8DylOqGabhcgcnZr2HXZHUef0VrnWS1yHHcdKWratQXAAja83iw5to9F/2MqE9cfNYuLdY3e2gq4ecs3cPoRoXVNqKyBPL6UDKeSKyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGBiBGgvM+gG5441ZynYlMxM/NVm8FCYKY6zv4QMaow=;
 b=Ge9ihtVqdT5E7v2vXFFbGOQBokR9jRNdrltE4kv9V4C0TDuEFWknux+KUcN9x5UBcEjqHYBTtvQKbQkz7aAA77PO1V/G+wIhYlR6hJCqgN4YCUPNrxDeCV5UPtzHnonifm4391+aNpKMVCPLG0o+e0CVgiqTnlDp4Y3vReimNAbX/Tpv++hyinYcFNv3rhcNK72ZviCvca3Wl/HYu87WT32dlwTYdfl6XyICSvgcQkQL8ukn0M57SuKm2O7XKdBU8l15Y1pFsohO/2MuaLb4eBB89U57Q+5U6b7Mo4dwNNs+0RqzoMql81knzbPF0R17tDT/qQw5V6SgX/W4j3/sNw==
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:282::22)
 by SY8P300MB0757.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:293::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 03:11:18 +0000
Received: from SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd]) by SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 ([fe80::aea3:2365:f9e8:5bd%2]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 03:11:18 +0000
References: <20241108180139.117112-1-pbonzini@redhat.com>
 <20241108180139.117112-3-pbonzini@redhat.com>
User-agent: mu4e 1.6.10; emacs 27.1
From: Junjie Mao <junjie.mao@hotmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org, kwolf@redhat.com,
 zhao1.liu@intel.com, qemu-rust@nongnu.org
Subject: Re: [RFC PATCH 02/11] rust: build: move rustc_args.py invocation to
 individual crates
Date: Tue, 12 Nov 2024 11:02:22 +0800
In-reply-to: <20241108180139.117112-3-pbonzini@redhat.com>
Message-ID: <SY0P300MB102652560AD744516054AE1495592@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain
X-ClientProxiedBy: KU1PR03CA0011.apcprd03.prod.outlook.com
 (2603:1096:802:18::23) To SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:282::22)
X-Microsoft-Original-Message-ID: <87ed3hi1tg.fsf@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB1026:EE_|SY8P300MB0757:EE_
X-MS-Office365-Filtering-Correlation-Id: 50593883-7917-482e-9578-08dd02c7ac9b
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5072599009|8060799006|461199028|7092599003|19110799003|15080799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NgyrijU71T0G3l0m6jCpNYENQPgFReCu2r5FiRzWCjNt0LXy8/QOZ6Hn+XCg?=
 =?us-ascii?Q?B+aBVayXXp+PZhYdUi+ILefNIg7D4B/g1Od4r46ybM3vOAqtyDJ33j2Et/lX?=
 =?us-ascii?Q?iZC/flXr8ipRPBx0CShdp0MNXi61cem9CZERY46kUt0BVEr+MmPVg/WTi6yW?=
 =?us-ascii?Q?VRQSJm1gJ/SEeKkWTGRAvXe2g9FxQAKjq5ynFebkrbsGNKtzrLYNfo37tpZw?=
 =?us-ascii?Q?xQxE/cBRKS4bB2IeedoBBSJmimlH+prCg9WapDu15RjWp8Rp3SDXMuNuSMN9?=
 =?us-ascii?Q?o7mbwZ8XGwXmzBioOIhEBsZZucmfMY0hrurKv9RnbIKpebFjNOL5tQPnU7Jv?=
 =?us-ascii?Q?DbcWWMtjlYTZoIvSomu9kRFsDLUoK2iBe1KbqkBRgNu+TkaMSUlUdZNDQd9m?=
 =?us-ascii?Q?VZ/xkUhcijJpouMZKQfQ2hcwpw8cs40t88G9DcuFYQiraXzVmi8P8IgcqEFi?=
 =?us-ascii?Q?+efI/St2WgxL3Z4/oDGZg0Y8/4gR8dUMR4ePk61IVMLuxk3CnyS2rwRjRPhs?=
 =?us-ascii?Q?IcOTg2DocSLrzZOdWt7Q6aVU4Pbvf9O0vLPtOLyyRzcJIBIn+wi9rI9CkFK1?=
 =?us-ascii?Q?eP6Jw3k42Im08QBDHXNEFx0UBHi6REIM/iD6Is9YuBq7XMyFGpRnpRpmotsA?=
 =?us-ascii?Q?mkTaxUelgJOQk7qW0IHq70NcVJUiUyFZy6gjmd0taP5cM33WC0q+Rwg+a4Od?=
 =?us-ascii?Q?IDVwOJyjHcM4yOj964UqKauDcZfC3SHDJOrZY2NJlJoUtlD9u8+Jn5OWAAy5?=
 =?us-ascii?Q?igKfuhevLHNKZ2rdCBEeDVWVrqLzyxhHWOWOQhG7YrXwMTNjv3wJ+mdUEFKR?=
 =?us-ascii?Q?+7HPWSb/cJfJv4EHvWcGXIKyJ4APjse56E2prabMdq3YJmO/vrDz16xyktdc?=
 =?us-ascii?Q?8mBjYpfENzdiOmADjvfvEJGPMcudU5cBySQqDf72mOAmvnXOjik6/opwVxR2?=
 =?us-ascii?Q?PwBoNe0D3QVUW6ho+RcSDL8Thti2Yucwnovklf64TLZpHn+YW8vtkitMaBCT?=
 =?us-ascii?Q?3yPnTHh6jci3CGq3Cosy5l5/JO+r1u/PrNCLQduSe/s5E/Y=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ITCaEQH935qlRvvT/aEBqKZRYqHZq1rhlKF4NW14XRJF4TJbQdQD0fhUEM7o?=
 =?us-ascii?Q?8lZMrkdJmNaHzSj1YPlZsQvxxc9IG2v4XUlA5pEl8PQ5cYH21QKz4mE+SoF9?=
 =?us-ascii?Q?3XFjJjWYDFMsMkmz3RT2AEJVf6rPCwZZDPF94YWBZ/9z6A+FOLXSSK7TDu2K?=
 =?us-ascii?Q?Lwqmjvaig7L49+dqnkqQ108YUflsbt/xNdeoapDOqJWQhnq89HyZBXq68uhi?=
 =?us-ascii?Q?ER0L8xV/DFAQezNL53lN9gHILaJJYg/Ktb/Pr3mVVC+/jDlBApl9ADguWdMi?=
 =?us-ascii?Q?7urkmzi3HNcBu+PB7fDYkXtRF4NkJQ2+G+KMZqSunY4tYUUYrdvWqnVO3kJx?=
 =?us-ascii?Q?uPdUOE3NjM+LaGNMjhk+3hcO5kCjXZ4TBudOnPLqzOvt+1Y9FaZo13FLy3w+?=
 =?us-ascii?Q?KlqaM35aUdXYMIzoPJCH0BBT5fV83MM8auhxfmCU0ne6pg4p6QD4n4nNEMxB?=
 =?us-ascii?Q?tBX1RfzAjLowDQaplQTIQ+/j8EP+UGAk/CGYSAd/rQYDKstk9BbwFlSx/ukg?=
 =?us-ascii?Q?xk8wdXM5eRGSFfpKybMceSFYTFz/an9re7lYUxL1VPSZ87MtFY47aPKDg989?=
 =?us-ascii?Q?Hyr1T/tvqE/6xmzEwkBUIfmoNstJE3E3tFSX6gEOb+VMdPD0tbuFBFlJntbk?=
 =?us-ascii?Q?LbS87wtbm9Ede1yK3SOlOxBWEJ48qzzfVrxaLvFxqr6pK46ep7+e64SoTI3B?=
 =?us-ascii?Q?Nq9Mi9M1NfuiwqB0HXvb3bd2p6BsegGNFf836EdhYwp804PfT42xYolWo7pN?=
 =?us-ascii?Q?TaAB4z+8P0k4gF4dppjNG1nwAUTcNaIkeRbIG+oTzcFkHnFtQ7Sp40+hYt7D?=
 =?us-ascii?Q?kvdw9V81ozrf+oNzpWeR2g4VOQD7TZB+untg8P4oKLj/X8ODhu6XkfB7MMwb?=
 =?us-ascii?Q?3E1yWoQdqteD7xdS6SwGnhl2+hk7/6BQQ3T04CfwL84vHz4ZZqUKICImk2Sm?=
 =?us-ascii?Q?jK/8LvmTxvfiEt3y2/cIO3V2ybZIcdOIro+uI+7daR/zmpnQBuiGEXkRQUqP?=
 =?us-ascii?Q?jNMxhR+8csFk6C+lZD0lVicstZToA1865QCehIPfalA5zfbyyxmqTCdN8fuv?=
 =?us-ascii?Q?c92ORuiFaCdIfF2Wtuj/vGcgs3OdYzrGRzA2L/Oxldkn/4tFMs+1h4v+A/wa?=
 =?us-ascii?Q?pnnekYadQ4/UEFwQe8J8xtwqEVMinichAU7EyyUwra79GZEgnNgOoM0jdCDj?=
 =?us-ascii?Q?TTbte7G8l6UzQMcNkkWhnLt9ZILX27wEFVHI4IeR63/Xin29DXmmszOvWaU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 50593883-7917-482e-9578-08dd02c7ac9b
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 03:11:17.7492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0757
Received-SPF: pass client-ip=2a01:111:f403:2819::809;
 envelope-from=junjie.mao@hotmail.com;
 helo=AUS01-SY4-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


Paolo Bonzini <pbonzini@redhat.com> writes:

> Only qemu-api needs access to the symbols in config-host.h.

This may no longer be the case when more complex, build-time
configurable devices are added in the future.

Moving rustc_args.py calls to each crate is still helpful because of the
changes in patches 3-6 in this series. So I think every crate under
rust/ needs a run_command(rustc_args, ...) for crate-specific arguments.

--
Best Regards
Junjie Mao

> Remove
> the temptation to use them by limiting the --cfg arguments to the
> qemu-api crate.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build               | 54 +++++++++++++++++----------------------
>  rust/qemu-api/meson.build |  4 +++
>  2 files changed, 28 insertions(+), 30 deletions(-)

