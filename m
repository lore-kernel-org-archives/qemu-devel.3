Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68ACFC79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Wqx-0004bw-W4; Mon, 07 Sep 2026 06:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x3Wqt-0004XJ-Qm; Mon, 07 Sep 2026 06:45:28 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x3Wqp-0006Y2-Rr; Mon, 07 Sep 2026 06:45:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDSIUDMQ36WA9rgGl+j46mcoLBymRugMA8fvUvob/YhcVUiVkoWCcyqfoaH7OBWADMG/dkxPps1MOnIXgfkbxBbwlO7NtxcMlm6Xu7eNY3jecFwx+ry6RwsBP39MkI022h5QYg03o47n7HN6eGdZgBNYpTqLm5obfSxNdgH1/pfrEVtjIYYl1HJCwHjLsYuLzxYwG0JS9FG6vPM5BiET1ZdCpDuhZ+jwTG5QNCJvnigQ1pvSgfM+RJWnbRWnnKJ2YXo89dzYuGSrArzECXbLJlTK065g1gkmaj19oisdKz9PTLeF8VoVG8d8hr6XnAquH4fHpw+KRI2RL2+q4S/icw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foiTPzvkZDoiRTTT6sC+igSAzIdpWIiVvadNXQzSPcw=;
 b=WBYrcr6s+QbYauMCDSyXEA9pOZLY1VlF8BKD1AIIzYUUzTkhLWv/NdVgVfGB0l/WelBGjoY2ZhYq0KLEJ8WbfXwfmc2LLq92hOwnKCzzp3KzcPY7gxkDXhxahfmtPxSgM4/4B8YV4tc/bHDpSJO7eiq9gN4+/VdlNy+kESVo/n9hUU/FenYfOJoq5/lrHyfZ8sUIIV+pEcN4ni5UX9GL7cpO7KM/ZQNeuyfW1Mfii/Ku8bpx2T+zc6em+322Nvu4mQOhhbSVeMtQNTfutLXeVI47knDsLbvjTYrDXcbPLcRZyp/4NOUhAE4Q95y3640HF9qf+sanuH6jOI6OI4A//Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foiTPzvkZDoiRTTT6sC+igSAzIdpWIiVvadNXQzSPcw=;
 b=zx5TmrwWRm9VmUGYs0dauGKNPQaOQkm/MBH3EVxkrYuiyHTdrOasa0uKYbgbbktu73V7LJdNo3L0tFFTci4wD/p79Q89XMXHtDpNtLBViYKNdu5TE7q+6wh4xulPzECGmsI9tlALJ9LY6OU2Y++7DFgQh5ENTT2PvscXwzUQ5NYxIg5Mz2JLbjNBTngDn/ig+4dtzuxS3UrwArMFxXohULwhwU8m0YFHeLsty7mdLNS/tA3Gt90VSBYe0nZsfq6jw0H0f+XFLxJt4MMqLz9e+ujlNG9/U66igcIfCMt6fsam+5+Wka3O1nv0zXmv1klQWIaBrGisUE+JsmpakF+0Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PAWPR08MB10210.eurprd08.prod.outlook.com (2603:10a6:102:367::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Mon, 7 Sep 2026
 10:45:17 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0406.005; Mon, 7 Sep 2026
 10:45:17 +0000
Message-ID: <aae0891e-6de5-4945-8022-03fa5ff4df18@virtuozzo.com>
Date: Mon, 7 Sep 2026 12:45:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix bdrv_next() skipping monitor-owned nodes
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20260828222005.2888213-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260828222005.2888213-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0072.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:352::10) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PAWPR08MB10210:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a96941-7340-4ee4-6707-08df0ccd1aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|23010399003|366016|6133799003|10067099003|5023799004|56012099006|18002099003|22082099003|18056099003;
X-Microsoft-Antispam-Message-Info: +ulUwBuMZaulwj8Ykm5DOTqK7CCjlUBaw+6PqkziJrqNhOmDC526iRzWlpoGR4RkBFhwGpMYyqib1G1j9dJcw0GuK7jNVosHArgv2eOb7XHdnc+EjspGVKWUKFvx9ZeHgi1pL6uVVYCWmWScA9VTDGVT1Zlie5FnqKuiucI0LhhPQSw+CK0vx/7dF+3+KmnFIN3Oeykxm8xiX5CH3I/USThc4Gf1urqPwLOic78dJblAuRcwO7NvdaeX/fKFUv4Yp9NuVJWvLtTMuGnq+D+UMKhpHH0GtxixqeJWrBo+75YNJ/2AK7JrJ2FxFgnM/7N8g2TJxwyNCNYF/HIXSKSH8cfR2hsun07HrP5Dam3fctVo0XpZ2PNyKYRUeOA7G8Nytka0dasmlAuorKks6C2lyYSrfqHfayf2aShpF8LhhjagLeQxfGq0bp7VC52PYPAN3JL6/Z50kEyAy8igVVwsbbWw8ZqXteUSS90EFq3qQrSIMvGpjYte0kO2nOn5pWUdCfdocj3Po2KTAsT6EF/qyNF2qy9u7yq4u6K4EzjEKJSm/h2uD6qt2U6qoGQQqTFNVLwFOJXp1CGv2/WmcH6s0NudRI2QUeKH8dmGRuvzjPg8CIk/aQkWS7k2GwWVSkz4F+8cphRCNlPAEXeF5IqQWewR17cLND34MWUcak8yrQ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(23010399003)(366016)(6133799003)(10067099003)(5023799004)(56012099006)(18002099003)(22082099003)(18056099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3hlOXgvbHFoY3pXRW94YnVKMkhMMEovb2pKRFJGeXlNOG9aZ1V5RndLN1Bn?=
 =?utf-8?B?OWhvTThpakxVMkdqaGRZKzQ1MlpmMzRWMlRYRnhSa0pTNnR0Yk0vTUFKOVBo?=
 =?utf-8?B?ZmVqaVAxdjI0RDBISTVJYWozbWErMXdxQTNHVXdBWW1scmlXOFVXR1BDYnNj?=
 =?utf-8?B?RVRhRldxZlU2d3AvYjBCQys4OGtmd0lLQ051ZGFwL0p6OU1OOXFOU3ZyV3Ji?=
 =?utf-8?B?NlFUNXJlMEpGV1l2aDNEWGFXOGhPYWlweEVWcU9xQlFSRGZXOXBqV1RvVzFk?=
 =?utf-8?B?OW00dkpUMitBT0krb2M1VmpNWEFKaUlvQVZHbHBHS1BTamI0Wnl5NVZjejA1?=
 =?utf-8?B?bnczb3pTZEs3bTNnZVFHOE0vRmVaSlZpdmt6Yjd2b1VlT3hWcW9QQy9KL3Vv?=
 =?utf-8?B?UDVXRXdWNjJuSmhSaFBuaEh3emxhTUcwcjRXNFM1Yks2emFPMjZHS3NCUUQx?=
 =?utf-8?B?MGZwWUNiZWx6bmtNUEZCMTN2aDFHdE9ab0crcnVRVDVTZTRHZ04rcmh2TzNO?=
 =?utf-8?B?eENJUVY1Rnp0TGZEbldweUxTekpJSmdJd09LR3ZjZEhzY2I4Vnh0YTNVeVZ2?=
 =?utf-8?B?VWNLZmcwam1XVnNZeWk1dGUwZHBnYi92L0c1RFhOT0dkZzhGcFhRaE5mbVZ6?=
 =?utf-8?B?N1RXd0RxbkNNRjNiVWpGNDNyTDdBckR5djc3bGNFTkFFY0l2c3ZzcmZiS1I3?=
 =?utf-8?B?MW9VWWxJeGRoSTJ0UXdjdDJYLzBjUEIyY2dYRUh2RXEwLzNLNmZkTmZod1VR?=
 =?utf-8?B?dGxhR3ZHVXdjb0dqaHdnd2FlSzhrdHh5ODdEL1pRTFZYMFRJM2tYN0dWbmov?=
 =?utf-8?B?Mlk5MGVvWjgwWjFIQmdDaXhKdU5TK3hxdzdTM0h6OVNjOW5uc0RHS2l0ZUY0?=
 =?utf-8?B?bHRtS2gyeWhoTE8weTNiQitsNC9CcFNza0hCVzZBK2RjOTMzZFlRWlNodEc3?=
 =?utf-8?B?eUpnZnd5eGRUWEJpMnVnRytDYkdYamRrOFVVeTNyNnNQL2dBMUx3MDdoMzVz?=
 =?utf-8?B?QzFuSkF1NlpnaHJlTXhuLzdUTEE4OGJIZWFDZEJDUkE3MDZXd0dINTFYeEk1?=
 =?utf-8?B?YUpZTDg5VlNVb1Vnb1pUS1gwNHJTVGZ0T01wSnBhWm9PZHd4anVUVmNrQWtq?=
 =?utf-8?B?NDZpWUQ0RTAyNllqeUpkK2c4ZWxGVVAxclVnNmJoQTlKVC95Q2dORnpXUEd5?=
 =?utf-8?B?ZmY5eFIzY2lBUzlpNmZKWE01R3NPYVF0U0U0RHhaT2NkYnU3NGwvRXF4bUNR?=
 =?utf-8?B?T09DeGRvRlBYMzZ1NTExS3NKK1pqa24zQm04amlhS2YvMmlDVXNwc0d1TGEy?=
 =?utf-8?B?Z25oY0ZISUlvN3oyUlY1RkgzSUFCdFhyVWo5citPdjF4VEx2NUk0N3FpNUNR?=
 =?utf-8?B?RzRmd3BEK25sajdUSlZsQk9kc1hzeGtqcGtMRHQ5emdReEgydGNuekM1ZFJC?=
 =?utf-8?B?Z3RRM1ZhRE9IUGs1UjhLVW9IaHE1YlNjR2d4TUt4YkNiQTA2T3puS3dKNnNj?=
 =?utf-8?B?MC9wSjdiWXBBTHIrc25PWWVvZlhkRzR6NzJmOXo0bi9BMTRiUE8zdWpBYk1u?=
 =?utf-8?B?ZDhTZXIrOFlWUXkyVnRacUVXZTZsZGZUN0VpN3QrclVDaVN6RFVGVU1KVnNn?=
 =?utf-8?B?OTF3RDJNVDB1eFJhdDB6SjJoUVRXM3Z0SFkrZGVialM0V0FHSDFtaWc4S2NK?=
 =?utf-8?B?VmhHN1Y0RnlBU0psSWt5RGJLTGEvVXNETFlWdGkyNGdFNnBydkMzZXNtN3ky?=
 =?utf-8?B?Qy8yRXd4YVNSY1JGM3VBM1JPZGNIMmpXQzNlaTlTRGdtdmEvM3pzWGgvTUZp?=
 =?utf-8?B?OEJsQ2J1UHJ3NDBhMEdXaW43ZGZPMmhOVWJCcmFXc2c2ZXVoeDNFNGh0cllT?=
 =?utf-8?B?YWV2ekZpK04rNnlTV2c3NCtBUGNuNitReXNmTDlnL2JSemNYcE5wbjJ4aHAz?=
 =?utf-8?B?Nm8vWnBFbkZWWlZPVk0yR3Y1SXh4VXU5djl1cUQ1c3UrYmhOMnBMenUxM3ZP?=
 =?utf-8?B?N09tVUtzY2VvYVlvSTdPYkpCV0h5RzFsaWd1SktyNzIxbVpWalVoZm16eVdw?=
 =?utf-8?B?SWFYMG5sWWE0NEFjNFpkWllUTXAyYVdvbE9ET29DMHMwRjhXRnFrVXlBVkFG?=
 =?utf-8?B?M05TdHN4ZHZOWUdrbTJYS2h3R3FJSmRJdW15R2lxS2JGNlNiVUlZNUNnU3Fa?=
 =?utf-8?B?RkVzd3ZYYUpxY3R6UXVpblBXWGJWWGswMzJic3lJck40azZoSlBOUXd1eTlV?=
 =?utf-8?B?UjhqN2daOGZnZjB1Nk1vZTdab3JOc3A0cG05UmgzN2lITHZEbENWaU1GYXln?=
 =?utf-8?B?TlVBalk3cFZ5TmcyNFBWZkRNZnRZUmNxKytBT0hSMVJyL3lyS0NNM2hwVkJs?=
 =?utf-8?Q?zQbrHjDX/tCwOhYyW+BY4DetLDxeox8u/EKuLco/pSJZ1?=
X-MS-Exchange-AntiSpam-MessageData-1: OQE842Hb0oVIgQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a96941-7340-4ee4-6707-08df0ccd1aef
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 10:45:17.1208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qy+WFEnxKglWDKrvEeSHo2QyH0tQg3L1tc0RQJ/uPCXWGcnayKihFyeIU4aPTbJwleV0Hs2ADUbePHRjiGJqXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10210
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

On 8/29/26 00:20, Denis V. Lunev wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> From: Denis V. Lunev <den@openvz.org>
>
> it->bs is the cursor into monitor_bdrv_states for the second phase of
> bdrv_next(), so it has to be NULL when that phase starts. Commit
> f6d38c9f6d made the first phase store the node it returns there, to
> unreference the right one when the graph changes underneath. The cursor
> is now left pointing at the last BlockBackend root, so the second phase
> resumes from there instead of from the head of the list and never
> returns a node added before it.
>
> A skipped node drops out of the vm_stop and migration handover paths:
> not flushed, not inactivated, not snapshotted. bdrv_inactivate_all()
> still reports success, so the node keeps its image lock and the
> migration target cannot open the image. Only detached nodes are hit in
> practice, as these callers also recurse into children.
>
> Reset the cursor when the second phase starts. old_bs is taken at the
> top of the function, so f6d38c9f6d keeps working.
>
> Fixes: f6d38c9f6d ("block-backend: fix edge case in bdrv_next() where BDS associated to BB changes")
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Fiona Ebner <f.ebner@proxmox.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> ---
>
> Notes:
>     The iterator was correct from its introduction in 2016 until 2024:
>     it->bs was written only by the second phase, and the node to unreference
>     came from the BlockBackend instead.
>
>     f6d38c9f6d's own reproducer does not fire for me, 240 runs across 8
>     timings, even with its fix reverted. Tried hard.
>
>  block/block-backend.c                          |  1 +
>  tests/qemu-iotests/tests/inactive-node-nbd     | 16 ++++++++++++++++
>  tests/qemu-iotests/tests/inactive-node-nbd.out |  8 ++++++++
>  3 files changed, 25 insertions(+)
>
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 37ba7e9fc4..55497c4551 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -625,6 +625,7 @@ BlockDriverState *bdrv_next(BdrvNextIterator *it)
>              return bs;
>          }
>          it->phase = BDRV_NEXT_MONITOR_OWNED;
> +        it->bs = NULL;
>      }
>  
>      /* Then return the monitor-owned BDSes without a BB attached. Ignore all
> diff --git a/tests/qemu-iotests/tests/inactive-node-nbd b/tests/qemu-iotests/tests/inactive-node-nbd
> index 664157bfd0..ef876ae6be 100755
> --- a/tests/qemu-iotests/tests/inactive-node-nbd
> +++ b/tests/qemu-iotests/tests/inactive-node-nbd
> @@ -47,6 +47,7 @@ def node_is_active(_vm, node_name):
>      return node['active']
>  
>  with iotests.FilePath('disk.img') as path, \
> +     iotests.FilePath('detached.img') as detached_path, \
>       iotests.FilePath('snap.qcow2') as snap_path, \
>       iotests.FilePath('snap2.qcow2') as snap2_path, \
>       iotests.FilePath('target.img') as target_path, \
> @@ -58,6 +59,7 @@ with iotests.FilePath('disk.img') as path, \
>      iotests.log('Preparing disk...')
>      iotests.qemu_img_create('-f', iotests.imgfmt, path, img_size)
>      iotests.qemu_img_create('-f', iotests.imgfmt, target_path, img_size)
> +    iotests.qemu_img_create('-f', iotests.imgfmt, detached_path, img_size)
>  
>      iotests.qemu_img_create('-f', 'qcow2', '-b', path, '-F', iotests.imgfmt,
>                              snap_path)
> @@ -68,6 +70,9 @@ with iotests.FilePath('disk.img') as path, \
>      vm.add_blockdev(f'file,node-name=disk-file,filename={path}')
>      vm.add_blockdev(f'{iotests.imgfmt},file=disk-file,node-name=disk-fmt,'
>                       'active=off')
> +    vm.add_blockdev(f'file,node-name=detached-file,filename={detached_path}')
> +    vm.add_blockdev(f'{iotests.imgfmt},file=detached-file,'
> +                     'node-name=detached-fmt')
>      vm.add_blockdev(f'file,node-name=target-file,filename={target_path}')
>      vm.add_blockdev(f'{iotests.imgfmt},file=target-file,node-name=target-fmt')
>      vm.add_blockdev(f'file,node-name=snap-file,filename={snap_path}')
> @@ -297,6 +302,17 @@ with iotests.FilePath('disk.img') as path, \
>      iotests.log('snap2-fmt active: %s' % node_is_active(vm, 'snap2-fmt'))
>      iotests.log('target-fmt active: %s' % node_is_active(vm, 'target-fmt'))
>  
> +    iotests.log('\n=== Inactivating all nodes at once ===')
> +
> +    # detached-fmt has no parent and no BlockBackend, so nothing can reach it
> +    # by recursion. It is only inactivated if bdrv_next() actually returns it.
> +    vm.qmp_log('stop')
> +    vm.qmp_log('blockdev-set-active', active=False)
> +
> +    iotests.log('detached-fmt active: %s' % node_is_active(vm, 'detached-fmt'))
> +    iotests.log('detached-file active: %s'
> +                % node_is_active(vm, 'detached-file'))
> +
>      iotests.log('\nShutting down...')
>      vm.shutdown()
>      log = vm.get_log()
> diff --git a/tests/qemu-iotests/tests/inactive-node-nbd.out b/tests/qemu-iotests/tests/inactive-node-nbd.out
> index a458b4fc05..48451dc0c5 100644
> --- a/tests/qemu-iotests/tests/inactive-node-nbd.out
> +++ b/tests/qemu-iotests/tests/inactive-node-nbd.out
> @@ -235,5 +235,13 @@ snap-fmt active: True
>  snap2-fmt active: True
>  target-fmt active: True
>  
> +=== Inactivating all nodes at once ===
> +{"execute": "stop", "arguments": {}}
> +{"return": {}}
> +{"execute": "blockdev-set-active", "arguments": {"active": false}}
> +{"return": {}}
> +detached-fmt active: False
> +detached-file active: False
> +
>  Shutting down...
>  
Kevin,

have you had a chance to take a look?

Den

