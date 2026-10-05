Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B986CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 08:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDeWg-0000Gb-Hd; Mon, 05 Oct 2026 04:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xDeWe-0000ET-Fc; Mon, 05 Oct 2026 04:58:24 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xDeWa-0002Uf-GK; Mon, 05 Oct 2026 04:58:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxYLT5esN5JtEacqh8h8lpHYF/peyX0JMUc0RRQytOp3zbL2Kb/ottEgdWYr/ln8pnPn6KjtaFlY7LT7ZaTquSJh25wuzBq2QR1VlvtgKpDUtiuEGN7+uaVKyZ3m80BS1i4GvjcjMNtXJaPIf71OdIMuSvYHh1LnTaDoGZvDqnPpSW55NfKpWaOY9bhAFXWueS0a+AOrxe2pPEYFrxn1BufuNHQUlByE+wak7u/RysuVEnZnszGx1zqIsoivsWJ81DgCUKSoiMArqh17vYnjRaKkYBADhxzwB5mXQaCaq7yAEVEEQMvk3DkQ01dnJgtGcQ50q84b/nof08SM4b08NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hegeFFQdHM2GAs6ubWi/8XQgvw/ZK56T7TjTF/ZfaBk=;
 b=kEPUKYeWBFaoVQ+XrahTi9g2caS7zkV/HVhjfYNnWd4CtDhhG4gs9wqhQPNE68f7AmOi/cO4LZbh5a6nXMluK18+3+deaEkGN5zdrcI0SAkv4G+hxSBHkObaMjcVvEoWN+WiwHUBg3PXArK4rYaP+Z+2+/BAiBt1STDw38SXt8j9OWl68uC5561QBFfdgPugSTf/ZFjDV3h9WnOhgAnmzhjX/9wBp1C3uDYMtJaJ64YF4hVjEjJGCHWeipUEYi8d9tDF0PbYKxPls5Et3u++iciqnv4olEk/nsAb8je9ZmNWjdlHNUKNVPuW77nr1VbgSnB9rVnNgTz88eEkHN4UMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hegeFFQdHM2GAs6ubWi/8XQgvw/ZK56T7TjTF/ZfaBk=;
 b=x4WyGxDPDimuqkUcMw3HqGuje2lbDbz1bgzUDklbpmp0U6Fq8oVejFAw0AG0DBuQEDXb8gRvXQ3Hs4aTx0SbINSotjN4JZAvSPWMQED57Q6o3xEG6mPS85dpPAGd0HjaxUANl62WhgEqRV7tDUFZEbq9DvJz1FWPUIOAP+/wliwot6j/vVMHpa1PsS0WciA2CsHKVabRNKXM9uN4tWMObeHTEyNRVsT9+hxvtXe0kN4iRpbJI0UF6g7KtGozX46NLPQaPcARrIjUU/hpvG2GWnP2L7jIHJ4CG5AwodERYjrLBw8jDzpQyEL/DBbk6gdfFe/BLc5smrCKFMKbfiizgg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PA1PR08MB556523.eurprd08.prod.outlook.com (2603:10a6:102:54f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Mon, 5 Oct
 2026 08:58:15 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 08:58:15 +0000
Message-ID: <1d3222b1-fd72-413e-a938-3e48eaf340dd@virtuozzo.com>
Date: Mon, 5 Oct 2026 10:58:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] migration/block-dirty-bitmap: fix postcopy abort with
 bitmaps on several nodes
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20260924115611.4098417-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260924115611.4098417-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0126.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::24) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PA1PR08MB556523:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c82bb7-67df-4030-7865-08df22becb03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|10070799003|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: skziQoiIZeiRZatulB4jJ/NJikK0m0ad6DFVhxCp4VI5EmLUKDiPrajBo9OfV9mOYrf41V9ATtEgUoWBr52wwuN0uGMaHRrDMUJ2cYIrN4OKXnR+TFB/ptzCs9V3KCdatGGGW6LB8jjTqpLvD1+y7LI7fvV/y4eP7nz4RHjHrdpZp+MYK2jNFtxatfbHxIeQgabtMdDeI2vKJSBwh16xPsrvPLhB3QYL4BE/kw4L4JfTauds0ZEkZQM0HAJOCkt8VTHMMmrqruVZJndDYeFYD3VjOo2q05TKhBF5bV4G5Yp3XdLT1jea6Oo/w+h/nm5/v8b/RDrq8EM4vczY+E0ieBggzKGuA40dEbejb4XW7XkPlgVbDAJmd8Mx2aGc2n6Js9Du6qJlWTpma+R3d5EoCIB/9JYGHXHEaY87kj3uZK/RorCkmG4pyz1l7qw1TzD/b9gLbrH4QJy+oEZpSG9mIqAdXZpdAjswEg4DwssL+bkrGk3eBsyIrPwJf8UBNhOU4ot9+3a4fE94clqdzrgKN0ome4rmswmCn/keCL+kQi1LQyNC5N08ssye0rIaay1JLTS/P9dnhusRRD2zOqevD364ZftF1bNarJsGNyrGCHeWSyJHhzCAXgB9UoajN7LgLDwwmA/XMzv2WhA5dGDZIvfOARnpmQ0PrkZLuh3f+X0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(10070799003)(366016)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WndmTUVjNkZ4QVFpMXZxcmxNVHdSdXNVVXZwcVJhejV6aGZlbFY2YVRHMXJW?=
 =?utf-8?B?aFlzcHUrSEZzeURVMHRhRWxpcmxFMlU2TUM4SGluU3BUZTJtUVFIQ3granox?=
 =?utf-8?B?Wml5ZFF5V1NMT1dxTlp6YTgxalZySFNxZzltNXVHYVdoMjlOcURHZkdHWU1L?=
 =?utf-8?B?cFpWZk5rekRZUktveTcvNFB2Tk1NM1NzTVZNMnF1MFh5M3ZFb0pWQzVSbmJn?=
 =?utf-8?B?WllxUmZ4UFVUYWhhdVA1YnBHbS84SW50L3pwQ01nMWIyUUlLQUZnN1pmMnVG?=
 =?utf-8?B?ZHM2QWhwbUFad3ZrVkgrc2pzMVNFcS9ac2R5d3pveGxOcXo1UUtHMFJrcDBM?=
 =?utf-8?B?ZThIcE8rTkpDYm5YNTBWTUFQWWdpTkhpemlmL0ltR2FaTXdxZ2JiS0pxM3BH?=
 =?utf-8?B?RHA0d3dwZmVHR3JYMkxMeWo0VFE3NGxibzROTTJ6cVJ2YW5TY3Nzc25rUEF0?=
 =?utf-8?B?dm5HbjVvZ3I1SklaeXZDdGVqWFYzQThDRTFuK0t4Q29DeTJkZUR3Sk9CMmEr?=
 =?utf-8?B?bjdvOUtYMHJrYXQyMm5Eci9yMEx4Q3FYRFdCd004eHZGZDVaNnRsQVVyZTh6?=
 =?utf-8?B?dEl2YThaSVRrVE5EWnlaNURhZ0dxMW51enlYWTJLcEljODJQSCt0dTBxei9U?=
 =?utf-8?B?a1hxcURRbzI3WUE0RjhWdGlpMytrLzVVU0RnUzk2ekxyVmc3aU9vUGtXUkQv?=
 =?utf-8?B?R3lwUGNFWklQbGRhdU01VXlmc1lYNi9CbDFMdGc3RXNGRG5aUjhLbmVRZU1W?=
 =?utf-8?B?Q1d5M1EzNTlsV0k2WjFLZktPMDRYSDBua21PVms4cWVpdXZmZmlXN0JOdCtW?=
 =?utf-8?B?b05UMVFHb1RNK2tlNFdZc3RWRUZrNkpMcEM2NEVXUzFGVkRlNFJ3MnRkREd2?=
 =?utf-8?B?T20vOEFkdHZFWGNYaXVpbEk3eS8wZUc4TnUwazZxN0tkanZiVjlwWTcvSFpK?=
 =?utf-8?B?Vi9aYVNHOHRyd3JZTHNEUnZZcXp4NVh0dG9CaVRqUXlucmpEMDBnZzFBVXQ1?=
 =?utf-8?B?ZUtRditmdzZWTmczMFhMNnIvUUN3TDNtdG5ZMWxhTW9tcnFUTkVjUGQwNEFi?=
 =?utf-8?B?VVJTZ20xemRtQ3dKTUIvOSsrVzNreU9IU1FlbTFCNkdNV3pCaVFtczYvMWli?=
 =?utf-8?B?dkdEWTF2LzhkcWFidFdVdFlUOGc5YzVxbU1ZT2R0UjJRcjNiYy9uUEMwaThq?=
 =?utf-8?B?SnhZMHpVSW9XVnMzZjkwQThnSUFjTDA1MFIvMHcxZHNHdDRRRHAxN1lNaVU3?=
 =?utf-8?B?VVFqMUg3N01yclRtNUFWVXdEZ28vMDJMK0YrV3ZwaWpmM1JxZG92Y0hjM2ll?=
 =?utf-8?B?RVdNeXp2UXhjUHZxWVFiRFU0ZVpGMHY5MFVqeEFNRDlsaEtVTFBDNXNOb1M0?=
 =?utf-8?B?VENNR2hHS2tvZ3VjbkFzUmd4YzlwQXNsWnhFVTBLRHhDb3gzSmZMQ1ArZ2pM?=
 =?utf-8?B?Zy9kWFd6RlNOMXlXakpJbmd5MjM0VUlZR1M2cHMxanJsejltNldjK0grZVpG?=
 =?utf-8?B?ekVZYzFmY2hPUFM5R0I2TWovcWtkbXhoQ2lreTFJK2xKVjFvM2JtS2VEYytl?=
 =?utf-8?B?Q3lzNmhEcVRTdTlWYmtnUk5lZEhEUG1KdzBkM00vZDhVTFJpMnlmRzhYUDRn?=
 =?utf-8?B?WlY4bWVld3ViTmh5K3I5UXB6NmUxWTFENWd5eW9uak5taGZ0eUZ5b1dVRFNi?=
 =?utf-8?B?UTlyMHVYc2RBdDJjb1NubGhmMlRBNEZ3YW5vMSt6Sm11a3JYM3luNFVEa2Zy?=
 =?utf-8?B?QmVVNExhYys2TW9hUyt1OVpUVXNUZU9FSUtUY1lud3QrY20xTGE0dU1OdzZK?=
 =?utf-8?B?eUh0aTBKOC9IbExaa3lvM0dGNEZCdU9VQTF6U1FaeER2elYvcHp2dUZmVUxH?=
 =?utf-8?B?aXJiWFEzZ1hPRTA0eDNEQ1Zvd0F1clFYck1HZENQZWtRYlprSFUxTGlsekNU?=
 =?utf-8?B?OFNjQ3BheVJUOWxLN3dnalZmQ0FobEVXTVJRd3I1eG9VRHZQN1E4K3hYd3hL?=
 =?utf-8?B?VkdFQTBjMGZKRVE5S1NJTlo5dERhenhrQUJvTFArSE9jaXFjWUhqNnJ4aWxv?=
 =?utf-8?B?V0Vka1FmenhpZ2tDUVQ5Q21SMWF5S0VKYWZoQlhiRTVxSkg4SnJHS3N6cHNO?=
 =?utf-8?B?N1ZFNWZoZ3lkcXdIenhPaGVFLzdSNURGY1lWTWhqK0g5RVlOL2xkWVl2WFBN?=
 =?utf-8?B?S1NNenhGcjZLSnBOUWoyWVVJaFpialFMZFRxa1F5U0Qzd3dLSHNuRmZPY01z?=
 =?utf-8?B?OVBjSG02YkJTNndZNkVzSGNOZm1MK3QydjNFLzJwTERETzR3QTFYOHRRK2N3?=
 =?utf-8?B?M1JUbnZTQzlNODFaQUdiSTdBNTJGZmJDNWtNdDdXN3FyMlJoaVNRYk15TTZs?=
 =?utf-8?Q?bUdJsRjbspKJDC2wTrVFqM0onyrY9ZbdrOdjssIXIrUn3?=
X-MS-Exchange-AntiSpam-MessageData-1: nvgAnG/z6w2C6A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c82bb7-67df-4030-7865-08df22becb03
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 08:58:15.7165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8cEYJQu0duzTTs+Uu/a6J7aJcDP1y2R793fzjeQ8hlvZ1k2TaVw2KT5dt2ItVhjKqkKQD57xDYj0LzhCwdea+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR08MB556523
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=den@virtuozzo.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 9/24/26 13:56, Denis V. Lunev wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> Postcopy migration of dirty bitmaps kills the destination as soon as
> bitmaps live on more than one node:
>
>   qemu-system-x86_64: ../block.c:6400: bdrv_lookup_bs: Assertion
>   `qemu_in_main_thread()' failed.
>
> The postcopy listen thread resolves node names with bdrv_lookup_bs()
> without the BQL. With a single node the name is sent only during setup,
> which runs in the main thread, so the existing test never gets there.
>
> We hit it in production with libvirt: a CBT backup leaves a persistent
> bitmap on every disk, libvirt enables the dirty-bitmaps capability, and
> the next live migration of any VM with more than one disk aborts the
> destination after the guest has already been switched over to it.
>
> Patch 1 resolves every chunk but START from the bitmaps that START set
> up, instead of from the block graph. Patch 2 extends
> migrate-bitmaps-postcopy-test with a bitmap on a second node, and it
> fails without patch 1.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>
> Denis V. Lunev (2):
>   migration/block-dirty-bitmap: fix postcopy abort with bitmaps on
>     several nodes
>   iotests/migrate-bitmaps-postcopy-test: add a bitmap on a second node
>
>  migration/block-dirty-bitmap.c                | 59 +++++++++++++++++--
>  .../tests/migrate-bitmaps-postcopy-test       | 19 ++++++
>  2 files changed, 74 insertions(+), 4 deletions(-)
>
>
> base-commit: 942229961efea74b153c44c59188eb08375f10f1
ping

