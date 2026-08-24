Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153ADC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyQS6-0007Ve-Oy; Mon, 24 Aug 2026 04:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wyQS2-0007QO-9X; Mon, 24 Aug 2026 04:54:42 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wyQRz-0000p3-SE; Mon, 24 Aug 2026 04:54:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRv52N4dDN5PUrJScRy5FMWrkMAh4+83g8039BOQIHR2QpRJPD+QuLyOK5qoKd6DxcO8CfB81OUliPnUsoc+PydO5rqqF+s14MVOXKHCFts8wmm4jlpxwuHJ0/tHbi6d0oWBdXwCHFfcUPp5uf0f4HF3mKIfytKwcNihQGS8b5MH6kxffdtuzPdBr1B+AaF9xxxoW+gdNcJZa/Yv0Uhpu8HRaZ8X8tIUpaN0fwwRw6DqlMuFgQ1PbO+HKH9d+CmyBKtFDDxTe2t8rHwFFbl1SEc2CfvUIyseWFnSeJpds5NF1QrqNE7HuR/5jmhOOd9XAPgLX8uX0w+O/clZgYbN/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0wYrD1ScvtgwzU8V4G86773VLql6Pf+GIIlS+vsHPA=;
 b=JCkm3vb1/lGaJSif8uPMr6at2M1UctB9rCjkFp4w/iYPkEwzNgXLr2Ae4RSaGBfCvoRC8jVj7Mkrw9RbJgVwQKjsbVp/SEItk1hPR3q1XjA80uizWN7k+WUqg3wzYLSxibtm0K9LsMWM4z8oYSfiDO9iOFHhnuUksP8+F1G1DxPOtP8zH1OYh1ftxe0IEO1HKEFpMs19/QeazQhCf4wVDoKFzbH6CcvQKmkBxgvIMfP/58qdatpGPySP8KF/pl7p8efOyo73xepGCFlS+ftkN3LCWXjsDBeiMDsCkEBWLCVCOnC7KSq+C9VG6sOHbnKVzmG8Q7Po7Fx0kApJ+kV5Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0wYrD1ScvtgwzU8V4G86773VLql6Pf+GIIlS+vsHPA=;
 b=Ldu9/1NrZfRBgFkGitIZSTU44U1E8VF5GoDsAvM6RQ+8qK6QbjvqUfUWyBz94sddVgl78HSckbBM0ywvCMP90TGsho78qnngCIfKKaye7NbSqnaOr/DkfZpm0XNZlU5u6S6ELgOyf0EXfUzFZl9SQk2le5zfdHPAV8yw+AAzjMnSbF/YiK8RFERpuvQlPvGfTux+evCnciPh+8prBuaxbnYSi+wGF3kp5kMuIuRHxOpbTaQJ6IwvDzmrKUCQtQ9wsLpe5xEJn+ehK/FNG4RsQq43eRKQ2ZUgeehLfttbLen0SGjdxmKUIdd3KSNEArW2GMrYgsWBd5o9uHwOf72+JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DB9PR08MB11546.eurprd08.prod.outlook.com (2603:10a6:10:60d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 08:54:33 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 08:54:33 +0000
Message-ID: <5ef69c53-4180-4262-96f8-d7ca0070de6e@virtuozzo.com>
Date: Mon, 24 Aug 2026 10:54:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/25] parallels: report the stored dirty bitmaps in
 qemu-img info
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>
References: <20260817185942.1065143-1-den@openvz.org>
 <20260817185942.1065143-20-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260817185942.1065143-20-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIUP296CA0052.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34b::10) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DB9PR08MB11546:EE_
X-MS-Office365-Filtering-Correlation-Id: b1f9d446-8965-41c7-3727-08df01bd5123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|23010399003|366016|6133799003|3023799007|56012099006|10067099003|5023799004|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ae2IUzpf8CufLMQEEduayukO/eaPP3w0eGj8M2ivp+xFBW8b1bvJkvBh1kyBmsP46sfnaQC75m0nycTweZRopRkrk1CCvzCXSMf2sCexBoU1WkA5m45ix1aPEyS6peqOUho+a326kg1A2FBATIfpeA9M9CRpfgxfxBH5Pafz/PbFscl6U5H9ifdy4QKOqarKW4+gKPHmNI1XRR6XdCHCkvBEHCyytCWzZcEjrnyp01Iv3ari3+o/oesJc7TFj4GZmqxRH1P4oofoTB+YAfFMHbf/FzgUm0R/e65fcIgSw+xpR0TCzsu8sMgOf29DsH/XMLfEweyC0ww3yF44yBU5FKoljbBoMZmDz8g30P9cLLijY4j2Sd8JP1kTqgSHHzwhQCQc/VCcgv2q2JP0YZ8SD0NYXmY/WnGN3itFYgpdHAA0ObcFw2CzXFdTUXqiBXcW0UQwp+SkKhreGgyYmIJ+BFhDPbZDd2ySZ3ApzVN0X2wlOMLbhP6SYWrciuLtVzvIulkb9nfPHwafaVtKV2CNbIBQHrx5dCyAzgwDkUbVVKRvI9PPd0ApWEC6SLcr7T+/mquM9I2B+cELuWfqD9WPIEJ18SH+uawlCJ3NGir55CQ3PzGfDh8SoOgyOopmwSJaazqVRe/FWKi5u911WGf+YQ/YvbBRWsXVspKUrLMdP6U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(23010399003)(366016)(6133799003)(3023799007)(56012099006)(10067099003)(5023799004)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Snh3SEt0cHFUSFZqTWxTZmhVTlhObTRucUlWVDk2WU9iSDAwb0JPUGNOM0Vu?=
 =?utf-8?B?emFhenNTbGJrZnhMdStRRGlTb1g4a2FwUGZzNW5BaTh5U2gxams1RitPS0h4?=
 =?utf-8?B?dHNTOTBTeGZWb0pkMlhsTlVnNFRBRGdwVUhhdHB1d3VnT3MzbHlJTk1KbHZE?=
 =?utf-8?B?S0RqYUM1YkZUbHVhbHMyR1kxV1dXMk11Y1NyUzlQV0lCSUVac3Nuc0FWNVZW?=
 =?utf-8?B?UGV6NHNSV0dlbGN6WDh6bmdVYUJDVmhwTDN6Y1h4VEtPWERISytmTWNUbkRX?=
 =?utf-8?B?WDdqM3JFV0lOeGhVOElBNFBzcERSSTc3M0Joc1ZyMWtDY3JNWjFGb2JvVkpz?=
 =?utf-8?B?M0gzYXF6Y0Y5Vi9TbHhaK3J3bjVLZ2xMcnE1TEdZdW1hdFVSd0x5WDFVa1h0?=
 =?utf-8?B?UTQ5QmQwb1BqRzhWenhEanhHUytMQXRCNkZKUXZIQ2hvNGhkUVc1eUdkZ3dV?=
 =?utf-8?B?RUNqcmI3OUViN2QwZ1RFK0swcFdJSEV4amlVRk5qRWxiOG14VVptckhNbGJV?=
 =?utf-8?B?eGg1OTlIYXRqN1F4NHpweW94N1FQUTRGRk5YRmlwQXFMYmV0VVorUk4vNVRG?=
 =?utf-8?B?eVNLc0lvMXNlREJLV0JKbGJ4Sk93NDdrb3hNL0hjaFNDcHlkMGJlSkdXR2hy?=
 =?utf-8?B?Q2dBNVNJaXlxdDA2dVZ2NWJ5SmF2Q1A4VE0yWHpPc0paeDZ6RS8vVjlJUnla?=
 =?utf-8?B?M3ZSa21PcWY1N1BrWTdlWGcyckRKejROQkRFelMxUU16b0lFc3o2WTRrVFRM?=
 =?utf-8?B?UjRtOW1BdGtRMjF4dlh0YWZhUTFva3FkSXVkV2lCZzg1UWczbTZFRGJ5VGdv?=
 =?utf-8?B?MDJ0T2VKU1g0UE9NNjkyMXZFK1VQN3JWZVVtSWFkTnIreXNSUFE5enNtU29o?=
 =?utf-8?B?ZHNGeHNuRWhSeEYrcUl3UWI3K1c3bi8rb1g5SFQ4emZ2NnhKSWZ1VE9pNnpm?=
 =?utf-8?B?cG5ka1c0VkdRT1RLRUg5RnZPMExzQlA0SmRIdmxiVzZkektYbGNYVzBjRnB3?=
 =?utf-8?B?d2tXa2Vkb3NWSnVRWi9lVENPa0JzTWZtTENaS3VhQ2EzTWdUaWdmcHFNZUlx?=
 =?utf-8?B?eGlTcnp3Nmo3N2V6OTRVU0hEZ0J2ZnFLVUcwbHVMQWtSaFVRRUM1R3JGUmVY?=
 =?utf-8?B?U2xwNWI3M0dteXo5WUZ3OG02NnVpN3NVTWNDcDFrYUFKY2dqcTc5dXRhWGNk?=
 =?utf-8?B?L2ZrUGNMY2F4Nmp1ei9hSUJQKzVmVE9kT2cwcUpxanZWOG52cmV2RktEQ0xm?=
 =?utf-8?B?L0lrL29hM1QraGY0eDlyTmFqWHA0ckdLREFmTUUxRlRFOHRaNys2ZlAwNjc1?=
 =?utf-8?B?NXdwK3JhbnBkT0R3Q1MybVZUR09xUkJnRml5dTVGeFEyc2NwWkRERXUwSnpL?=
 =?utf-8?B?WEFKTjVlSzNvakg5NkJJbE9vWUEvV1hTSkxqbmhZaGpabGRacEt4V0JNdzhC?=
 =?utf-8?B?bURLY1oySDVlTGdnaFBvTEkraVRmdzlGMHFwai96YnZuajBIYzhBeTA2Zm5u?=
 =?utf-8?B?NGtCKzZSdExUR3NBR2RCVFNGOXEzZVFaV0pPUkd5L2U4L2d4SmFzQ2R6RkE4?=
 =?utf-8?B?ekJvaTNsbWZ6VWdtZ29Ub0szY3NKY1Exc0ZvTWIrTE9YNXphMEk5M25Ua2lZ?=
 =?utf-8?B?b2JtM3ZZOXV5ZGFVS0hudGUyZWpNZHpaTXZ3Q0Yya2YrYWFDZlRCZkx0TjF5?=
 =?utf-8?B?Vm1FMU5PZlk1YWpZb2lDNVNSaTlLVXZTRnpNbFhXcCtwbWx2Y1FZNm9pR09E?=
 =?utf-8?B?aVJUTFdoVGt0eGxhcmdleWFtYjhiSGxRb29BMXZ4bTlqR1laYlgreXdOaFk0?=
 =?utf-8?B?c0pWM0NpQllaK1FSMEdySWVOYjV4QUpxU3RKWlZnVjBSVkZwRkpzbVNVUVd2?=
 =?utf-8?B?SDh5bDB4NHJtNk45SDIyWGxmN1pLbVFXUjRXWG5XUy9wUVhHbDE3MkVpSmpr?=
 =?utf-8?B?UEZ3dlplSGZqaWcxdzNGTHlMOEhweXhrV3ExK0J4dklBcGJ3Qmw3NjdUandm?=
 =?utf-8?B?YnhiRHVST3U3VU5mU3VJYUhTMjVJeFhwU3lzY2M4MEtsRHNqZVBhL2loQUpI?=
 =?utf-8?B?cGJwa1JSYWh4Y2V4b1Bmbkc5WVM4RjdFbE5aeUY3aXA4MUJNK3cvTkhPN2lS?=
 =?utf-8?B?VWxMbDY0SlEvMU04YkdwN2dNMWFmdWhpekdRb04zNmYxUS9aUWg3NXJML1Zk?=
 =?utf-8?B?OE05cG5FQ2tZVFFZbGFzdlBncm02Yll3Znh2V0pYcWdxQnpRRnl4cHFpUTVy?=
 =?utf-8?B?L1ArTEJyOW9PRS9HbUhLMFc5bjd3V2tRVitCOWFsSSszNkNOZlN1RlJOcVE5?=
 =?utf-8?B?Yk1SYkVObFA5VmhpN1RUN2tlRHZCYVNRSGxBUjFBeG5wUjZJUVdCWVU2dUtm?=
 =?utf-8?Q?vPmRGO6nq9AQ/lLzy8IBkNtlk0OOoAv2qeIAvP4LCVsLf?=
X-MS-Exchange-AntiSpam-MessageData-1: lc339uTJ7og/lw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f9d446-8965-41c7-3727-08df01bd5123
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 08:54:33.2740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OY96ICLWlu/sT+Vl15tYGWNdrykUJqVfl0yZDAH6bH4wSTBQvW9SGSc0n9hRnCNzkv9AE4whh0cFqc2HURzb8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB11546
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=den@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

On 8/17/26 20:59, Denis V. Lunev wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> From: Denis V. Lunev <den@openvz.org>
>
> Nothing tells which persistent bitmaps an image carries. qemu-img info
> says nothing about them, and the only other way to see one is to export
> the image over NBD and ask for a bitmap by name, which needs the name
> beforehand.
>
> Add ImageInfoSpecificParallels with the bitmaps and their granularity,
> as qcow2 reports the contents of its bitmap directory:
>
>     Format specific information:
>         bitmaps:
>             [0]:
>                 name: b2c9e1a4-5d3f-4e8b-9a7c-6f0d1e2b3a45
>                 granularity: 65536
>
> The list is built from the bitmaps loaded at open time rather than from
> a second pass over the Format Extension, as every bitmap the extension
> carries is loaded and marked persistent there. On a node which is open
> that also covers a bitmap which was created but not stored yet, which is
> what the field says: qemu-img info opens the image on its own, so there
> the two are the same thing.
>
> An image with no bitmaps leaves the structure empty, and
> bdrv_image_info_specific_dump() prints nothing for an empty one, so the
> output for such an image does not change.
>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>  block/parallels-ext.c                         | 22 ++++++++++
>  block/parallels.c                             | 20 ++++++++++
>  block/parallels.h                             |  3 ++
>  qapi/block-core.json                          | 40 ++++++++++++++++++-
>  tests/qemu-iotests/tests/parallels-checks     |  3 ++
>  tests/qemu-iotests/tests/parallels-checks.out |  9 +++++
>  6 files changed, 95 insertions(+), 2 deletions(-)
>
> diff --git a/block/parallels-ext.c b/block/parallels-ext.c
> index f687f2da7c..ad87ecfbc1 100644
> --- a/block/parallels-ext.c
> +++ b/block/parallels-ext.c
> @@ -736,3 +736,25 @@ parallels_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>  
>      return ret;
>  }
> +
> +void parallels_get_bitmap_info_list(BlockDriverState *bs,
> +                                    ParallelsBitmapInfoList **info_list)
> +{
> +    BdrvDirtyBitmap *bitmap;
> +    ParallelsBitmapInfoList **tail = info_list;
> +
> +    *info_list = NULL;
> +
> +    FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
> +        ParallelsBitmapInfo *info;
> +
> +        if (!bdrv_dirty_bitmap_get_persistence(bitmap)) {
> +            continue;
> +        }
> +
> +        info = g_new0(ParallelsBitmapInfo, 1);
> +        info->name = g_strdup(bdrv_dirty_bitmap_name(bitmap));
> +        info->granularity = bdrv_dirty_bitmap_granularity(bitmap);
> +        QAPI_LIST_APPEND(tail, info);
> +    }
> +}
> diff --git a/block/parallels.c b/block/parallels.c
> index 2a5ceb8978..e7d65d0458 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -1624,6 +1624,25 @@ static bool parallels_is_support_dirty_bitmaps(BlockDriverState *bs)
>      return 1;
>  }
>  
> +static ImageInfoSpecific * GRAPH_RDLOCK
> +parallels_get_specific_info(BlockDriverState *bs, Error **errp)
> +{
> +    ImageInfoSpecificParallels *parallels_info;
> +    ImageInfoSpecific *spec_info;
> +
> +    parallels_info = g_new0(ImageInfoSpecificParallels, 1);
> +    parallels_get_bitmap_info_list(bs, &parallels_info->bitmaps);
> +    parallels_info->has_bitmaps = !!parallels_info->bitmaps;
> +
> +    spec_info = g_new(ImageInfoSpecific, 1);
> +    *spec_info = (ImageInfoSpecific){
> +        .type = IMAGE_INFO_SPECIFIC_KIND_PARALLELS,
> +        .u.parallels.data = parallels_info,
> +    };
> +
> +    return spec_info;
> +}
> +
>  static BlockDriver bdrv_parallels = {
>      .format_name                = "parallels",
>      .instance_size              = sizeof(BDRVParallelsState),
> @@ -1653,6 +1672,7 @@ static BlockDriver bdrv_parallels = {
>                                    parallels_co_can_store_new_dirty_bitmap,
>      .bdrv_co_remove_persistent_dirty_bitmap =
>                                    parallels_co_remove_persistent_dirty_bitmap,
> +    .bdrv_get_specific_info     = parallels_get_specific_info,
>  };
>  
>  static void bdrv_parallels_init(void)
> diff --git a/block/parallels.h b/block/parallels.h
> index 27d8c3ac83..012f47320b 100644
> --- a/block/parallels.h
> +++ b/block/parallels.h
> @@ -32,6 +32,7 @@
>  #ifndef BLOCK_PARALLELS_H
>  #define BLOCK_PARALLELS_H
>  #include "qemu/coroutine.h"
> +#include "qapi/qapi-types-block-core.h"
>  
>  #define HEADS_NUMBER 16
>  #define SEC_IN_CYL 32
> @@ -111,5 +112,7 @@ parallels_co_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
>  int coroutine_fn GRAPH_RDLOCK
>  parallels_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>                                              const char *name, Error **errp);
> +void parallels_get_bitmap_info_list(BlockDriverState *bs,
> +                                    ParallelsBitmapInfoList **info_list);
>  
>  #endif
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 1f87b07850..4bc8b45efe 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -200,7 +200,7 @@
>  # Since: 1.7
>  ##
>  { 'enum': 'ImageInfoSpecificKind',
> -  'data': [ 'qcow2', 'vmdk', 'luks', 'rbd', 'file' ] }
> +  'data': [ 'qcow2', 'vmdk', 'luks', 'rbd', 'file', 'parallels' ] }
>  
>  ##
>  # @ImageInfoSpecificQCow2Wrapper:
> @@ -255,6 +255,41 @@
>  { 'struct': 'ImageInfoSpecificFileWrapper',
>    'data': { 'data': 'ImageInfoSpecificFile' } }
>  
> +##
> +# @ParallelsBitmapInfo:
> +#
> +# Parallels dirty bitmap information.
> +#
> +# @name: the name of the bitmap
> +#
> +# @granularity: granularity of the bitmap in bytes
> +#
> +# Since: 11.2
> +##
> +{ 'struct': 'ParallelsBitmapInfo',
> +  'data': { 'name': 'str', 'granularity': 'uint32' } }
> +
> +##
> +# @ImageInfoSpecificParallels:
> +#
> +# @bitmaps: A list of the persistent dirty bitmaps of the image,
> +#     including the ones which are not written out yet
> +#
> +# Since: 11.2
> +##
> +{ 'struct': 'ImageInfoSpecificParallels',
> +  'data': { '*bitmaps': ['ParallelsBitmapInfo'] } }
> +
> +##
> +# @ImageInfoSpecificParallelsWrapper:
> +#
> +# @data: image information specific to Parallels
> +#
> +# Since: 11.2
> +##
> +{ 'struct': 'ImageInfoSpecificParallelsWrapper',
> +  'data': { 'data': 'ImageInfoSpecificParallels' } }
> +
>  ##
>  # @ImageInfoSpecific:
>  #
> @@ -273,7 +308,8 @@
>        'vmdk': 'ImageInfoSpecificVmdkWrapper',
>        'luks': 'ImageInfoSpecificLUKSWrapper',
>        'rbd': 'ImageInfoSpecificRbdWrapper',
> -      'file': 'ImageInfoSpecificFileWrapper'
> +      'file': 'ImageInfoSpecificFileWrapper',
> +      'parallels': 'ImageInfoSpecificParallelsWrapper'
>    } }
>  
>  ##
> diff --git a/tests/qemu-iotests/tests/parallels-checks b/tests/qemu-iotests/tests/parallels-checks
> index 916d423a64..4c8fc17fa9 100755
> --- a/tests/qemu-iotests/tests/parallels-checks
> +++ b/tests/qemu-iotests/tests/parallels-checks
> @@ -382,6 +382,9 @@ echo "== dirty a single granule of the bitmap =="
>  file_size=`stat --printf="%s" "$TEST_IMG"`
>  echo "file size: $file_size"
>  
> +echo "== the bitmap is reported by qemu-img info =="
> +_img_info --format-specific
> +
>  echo "== the extension and its bitmap data are not a leak =="
>  _check_test_img
>  
> diff --git a/tests/qemu-iotests/tests/parallels-checks.out b/tests/qemu-iotests/tests/parallels-checks.out
> index 4dfadd68d6..7aaa4636d7 100644
> --- a/tests/qemu-iotests/tests/parallels-checks.out
> +++ b/tests/qemu-iotests/tests/parallels-checks.out
> @@ -241,6 +241,15 @@ qemu-img: Operation add on bitmap bitmap0 failed: Bitmap name must be a UUID to
>  wrote 65536/65536 bytes at offset 0
>  64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  file size: 4194304
> +== the bitmap is reported by qemu-img info ==
> +image: TEST_DIR/t.IMGFMT
> +file format: IMGFMT
> +virtual size: 4 MiB (4194304 bytes)
> +Format specific information:
> +    bitmaps:
> +        [0]:
> +            name: b2c9e1a4-5d3f-4e8b-9a7c-6f0d1e2b3a45
> +            granularity: 65536
>  == the extension and its bitmap data are not a leak ==
>  No errors were found on the image.
>  == extend image by 1 cluster ==
Eric, Marcus,

Can you pls take a look to QAPI changes? They are
pure technical to me.

Thank you in advance,
    Den

