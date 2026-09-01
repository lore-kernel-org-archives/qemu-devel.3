Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27732C624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Og0-0000Nf-Kf; Tue, 01 Sep 2026 09:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x1Ofy-0000HW-Du; Tue, 01 Sep 2026 09:37:22 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x1Ofw-0004KL-8r; Tue, 01 Sep 2026 09:37:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbmzA8gfWpz+Z0+9ulUeXxv02UBsW9+aGO2bb0kUfFWHaXWcG4OikS/RZIm8jwfzPm+ByY93LQIP0tVMnP6uDJeR4OliWDCkATseTtXO2nOlk75AGByqZmEanScbPgqMjsWIO+HAmvg3tJCYzzwtkbONGF8qrCb32/Km0IeUGvWuOHihTei2WM+HitQh2mLYAuFMAUAjZMT4EvCHDJRYHHE6V9LkC7ObG400GRIl1nQFE/HlOIjByaa+/rLuhlv0a2gXO0yc1zHkE4+hykIODZHYMTCLr/a1zDw/MJfC+/hLKjWVBGbtzmxUhMAI9ib9HpNKv95A129bfCR6o3yvXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0+aMbC9D27+zjbLEeiJmGv/tFnyvIDfsypk518mILw=;
 b=i9uLNGwwg7rMJhxVpiKZ/7NIbKwzHJyOBNL3cZybYiOAF+Ik/c8DfidcEa3hPU67kj0xhxcxe2JCgvOjBsOr7kRaksMfnLn5ewcXrEd69vPDeLlYSPesq7QRYHwLMYNTrQNvkNmINVTv3dlnCOtC1Xpki19zMiZM0zHXUvrkXA5AzXbkuxJ5u3tJ2OUc3gfHJWUEKJkl7NqgZbVvr5I4n0+n3kb4p8wAvPHR//gFiKnoASAV0j0sopB89iUwICCuqBJGmNfBLSHAyAOZAx8CxDvjTEo6XXv1hw6zXU/Ou4Dsgb7xWjmz9VNHllf07xRlRMMm1TaUjzh4PRppVdSAtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0+aMbC9D27+zjbLEeiJmGv/tFnyvIDfsypk518mILw=;
 b=eWS86sOfdhczsACG0ou6PmS+ELE1hj9/mR6DNg8n6GmTjcwTnJiQRjwyrgPHJTS1D5FlspzOIDMY3hheYlbW2ukryx03wsk7x/ltXVfRAuQ+Z5OkZPJBUenyR5pOgGQJrLW6gyS5hAa36sjZuDOpGaT1Kh68aQGR8TDiELFXMGUnm93087/CkrszvNOomaogbAOi4joXOlOmZa/oqUkhVTEm3oGeAAP2lKTSIFBdbOZCe+Y1QpdLSRars4TqNCgtEBoHuud/KIFELH3Y3mPxc4q0MNiOjMmwn6ZW+pAaNap8CPiyE4vtcQpMYgjAch+NtXDKY5+pZmO0i3IUSrDHug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by FRRPR08MB11965.eurprd08.prod.outlook.com
 (2603:10a6:d10:1cd::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 13:37:11 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 13:37:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 4/9] iotests/124: cover backup of zero clusters and holes
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 John Snow <jsnow@redhat.com>, 
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260828144554.1741910-5-den@openvz.org>
References: <20260828144554.1741910-1-den@openvz.org>
 <20260828144554.1741910-5-den@openvz.org>
Date: Tue, 01 Sep 2026 16:37:05 +0300
Message-Id: <178826982594.73810.12166927572244743917.b4-review@b4>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0114.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:350::18) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|FRRPR08MB11965:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fdd3dc8-4290-4414-938e-08df082e1fe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|23010399003|1800799024|366016|38350700014|6133799003|10067099003|4143699003|5023799004|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: AECPfQcYyIZMRcumIs9NQwPbdVTp2PNug8jlze0avSsZIPYa2yrDPQbc3gf+Qq/5h53cCNkyvhQNF7BHcRZ0bllGXMqvdF5PaY6yWdDyfwaCi/owCXXR814MGKkisB76CoLREP5UtiMqqiH3Z9joN2ZEoqfPQL5S+4du6C1OxNRuvEYUOXMrR0057dl5jkdJkteuamLQF7DoK5yFbN7dTFT//YYzYbl/V8RDuI7Ks5hFXp9VvM6u61XRQuRlx90IS4xj4DRBZG2LTF2zTjBl4HO3YH1dUBfO9+qD4tZ/XshpvDtgpYf8uDMy/mqj51KR/JJYem3aF7TeNk6arxn8oMKD2PBz0vCsa2jzcdvcp5Nca9NjBcDjHl0NMH4xrLDKJnXnhqo60WuZbvl6qwQwye1O0237tOyp+iOnl1Y0YJCu3wtFwFn/Pqhp8eR6u9wCgS9Ev/YdTZpjldNu8NzJpB9/6LzMnDnmpZmQS95QQt5rlgJJfagPLqjyEphJvq9l4FT9NIu0A0m0GgYeH6xWBUbP7A/trRFcPPyw3fRNUn+S2zcONaGZhDUud/ll530ZVgl5bjHHuh8Brl0KWvU2hA1tJ1TX6qnGeG6/sV9XYgN2F0Yk21QkR/Rbn4NCzYce8+3ALEdTbki4SB+5pPVe9/7rtpP7spwIQepvzrmT0RLXQTVCfgDZm17JJh3jXt+KE5CgCH615O78mcULqeA8C4Kl4W8fCjles3PH++66mqQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(23010399003)(1800799024)(366016)(38350700014)(6133799003)(10067099003)(4143699003)(5023799004)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWsrTDF4SGlDMlY4NTlXSys2UFF5SUMzWWRCUDU1S3lVdmp3ZU5Qa3NQZVRQ?=
 =?utf-8?B?VFlKVzJIdUtYeUE1TU5nYVhYSWczYVE2SEY2eFdCZ1BqbzdobUUyQUlrL0lp?=
 =?utf-8?B?YS9Da3hRRXhsRjNXc2xwMUY2ZFNESHdIZnNxaUJhQlJiL0VGem9JN3hOMlUr?=
 =?utf-8?B?WE1GRjhuWS9QQ0JXNTZzWFpkMmxMVnBIcWN2RTliV0ZNMEhSdklGNmZ3b3Zk?=
 =?utf-8?B?d2tOU0dpYVZZWXZQaGJ5ejdsUXlCT1JoeFRtbUVkMDA2SUpqSWM0cjRPeUI2?=
 =?utf-8?B?cVEvTUhKRUpKb2VpNHhCaEhFT0NOMHVMR2VWenY2cno2clBCYmZQdmRrcDJT?=
 =?utf-8?B?SGNSSy9ldStYbWVMU2xRckF4eExSN2hlYmwwZEZLRWduQ21RUHdYeVRqZ3M3?=
 =?utf-8?B?NVdUWXFyNTlKZkovUTV6dkJqNURCb29Vc2publBydTFKN1pzRDA1emsxZWZE?=
 =?utf-8?B?bnFNSWl1SXQ3NkQyenJFbFlHV3FxbURRRDZaWktNelhzbXFUakF4OVNYQnRn?=
 =?utf-8?B?WDFJa3FoWm11QU1LeDhoY1JlWTVFUnUycThUeFdUekM5UmpsL1Vsd2hQTHox?=
 =?utf-8?B?Q3N6SDZuYUpLTFMvSTdIdHJrV2lsN2dJNDhVeS9nUEhaazREZnFnZ2Y4S3Zl?=
 =?utf-8?B?T01BaUhVcmpFOGFoVDhIREZmSloreW40UGpvaGUyT0ZKOHBuSng1K01GVGtk?=
 =?utf-8?B?NFpOVTRpc0dFZGJ0S1Y2MGJnZnJKV0FqeUhQN2YyTVJvUXZRL2FTeFhGS21r?=
 =?utf-8?B?TFVUUFViNFFQRlJ0dndtRnY1TkVzYnlCdmptQ3BKT2lYeFpITUdHOG9oRVda?=
 =?utf-8?B?QnRJRHJJbmN3ZjBjT1JzTW5LZDZ5cm1FMHBLZTRKK3pnUHlQd3lGTWkrNzVj?=
 =?utf-8?B?NkxJZ0xXUGFPZGRvVWdYMnMwN2NWbEtaeSsreGN3Q3Q5dmdUMG90N2Z5ZVlR?=
 =?utf-8?B?aFhTVFpqdTRQc1pKMU56eHBoVnM1Ky9pMkNKdGZFT1F3RmVsY3I0bXh3Wmxx?=
 =?utf-8?B?MitncEM2cGVwUHBFVXpyY2lveEFwN09ZMUluVkZkdWNQZDJ4NWZmaWY5Sms2?=
 =?utf-8?B?T2ZmdDltVWFsOTdpWEJkL3NnbkVFNTAySU4yYytnQ3ZGVkMxYi9ZRTFhV3E2?=
 =?utf-8?B?eVFkcjJIY3FsZ0R5VW5QWi82eHBjZWl2S1hiODhqenN6aEplOHNZeW5samlJ?=
 =?utf-8?B?eWtVS2tXelVDaC9EZWJ1VVd2TElraHg0bUExd3FhbE5RWlZNQ091Rkd6YTdJ?=
 =?utf-8?B?ektyOVZyZzNiVzN3Qlk4YjdtZEhleVp5Uk02dS84VkFDNE01TlpxaU1UNWsv?=
 =?utf-8?B?RVU3ekthaERXbXNoZTF1dWRuUTBhNUFHRHJmOHJKWlpOaTJTRW8vWWZkV3pF?=
 =?utf-8?B?NVBiOEs5ZUxoL2J1NUh2ei9tektSUGJvUURwK2lmQ0ZURENUQ0FTN0hQc1hh?=
 =?utf-8?B?angxUGdocllESU4rbVgvbjkveUhYSGRPWGxWYTVRNVFMRzFZb2EyOWh4TEc1?=
 =?utf-8?B?L1FSTmdtZUxjYTVpMUp0aFBPZ2hjeEFSSHNDQ2NjMm5CYjlsNXBoZWFCMW1G?=
 =?utf-8?B?aEhIS2ZWUGIxcVV0UHkxTVJtZFl4SDRYTG14eE9Hc0RNSmNhWnpubmxxVG82?=
 =?utf-8?B?R25ZMmI5U0tUZ3ZhaDVHQjlSV0VjYjAzbWFWMmVyOUFkY0lFdk11eXp5SVdU?=
 =?utf-8?B?Zm0zUmE5M3BwaVJ0eG5LOGVYZXpGK1d6Um1yTitXRWZ2VXF2c081aC9PN2dO?=
 =?utf-8?B?U0FaMUlHUVJVSkdWa1JwNFU1Skt0UVR6WXBoeTlyWHNkaDlhd28vYUsrZVlo?=
 =?utf-8?B?MjZ5NzVPdkhrdkZJOG9YN3I1bzI2U2xHRTdDeW03MklpVVA3Q2EzK2tlejB5?=
 =?utf-8?B?NmNYZm1kdU9WcS9qVktMNWJ1N2dLV3RwOEFsY3ZHYVp3L28rRFpCdEdRdGp1?=
 =?utf-8?B?SFJmMEdnbURpTTF5MTJ4RG9oT0xtOWhoZHVMS3FvNWVkS0I1bVo0VHVBOE9w?=
 =?utf-8?B?ZGtNTG13SmlEUEtVbTBJbi93ZlpNczdkeDZVb1BiLy9RbFFwTDV2M2s5a0pT?=
 =?utf-8?B?YTcrZkVWQzV1dnZ0QkllbFV1STdsaDQ3ZmFwTU1GdGJhdzlENnh0V3E4dGpu?=
 =?utf-8?B?dTZBSVJxRnppblVCTkdzU0dOSGZaYnd2aTRwVWdwVkdmUitZK2g4RDYvUkhB?=
 =?utf-8?B?eE1uZkk4eXQ1MHJ3Yy9kdWh4UnpQWW1RSGl0elVIbXQ1RFBrT1BoOTBkRjE2?=
 =?utf-8?B?SGhIQllEWlBQdHpYd0tMTnYvQkc0RVlWTmxOSmFwZFR0QXZlYUpqOTVqN2Yw?=
 =?utf-8?B?c2JWQldLbUNURHU5RXZ5dWVnZXF3R0IzWUpJV3lWWW5HbkxJdWwyN2hJQThQ?=
 =?utf-8?Q?yXrZOkxH8iTK9JFQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fdd3dc8-4290-4414-938e-08df082e1fe6
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 13:37:10.8132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4AVESl+ve7VWLT6omK92xRNker+ErNXr1jfEE4QaUhSeMnHHbm1vsh4lGHCX1V3WC64G7sCPGqh35WNYfK9mFRAxueTbmwNDXqrGrebpsO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRRPR08MB11965
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
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

> The backup tests compare content only, and their sources hold data
> alone, so nothing pins how backup treats zero clusters and holes. Back
> up a source mixing data, write-zero and holes with sync=full, sync=top
> and sync=bitmap, and check the target with qemu-img map, which tells a
> copied cluster apart from a write-zero and from an untouched one.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: John Snow <jsnow@redhat.com>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>
> diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
> index b2f4328e345..eb5ab02904f 100755
> --- a/tests/qemu-iotests/124
> +++ b/tests/qemu-iotests/124
> @@ -22,8 +22,11 @@
>  #
>  
>  import os
> +from collections import namedtuple
> +
>  import iotests
> -from iotests import try_remove
> +from iotests import (compare_images, qemu_img_create, qemu_img_map, qemu_io,
> +                     try_remove)
>  from qemu.qmp.qmp_client import ExecuteError
>  
>  
> @@ -748,6 +751,403 @@ class TestIncrementalBackupBlkdebug(TestIncrementalBackupBase):
>          self.check_backups()
>  
>  
> +# Backup of sources mixing data, zero clusters and holes.
> +
> +Extent = namedtuple('Extent', ['start', 'length', 'kind'])
> +
> +source_img = os.path.join(iotests.test_dir, 'source')
> +base_img = os.path.join(iotests.test_dir, 'base')
> +target_img = os.path.join(iotests.test_dir, 'target')
> +
> +SIZE = 64 * 1024 * 1024
> +MB = 1024 * 1024
> +CLUSTER = 64 * 1024
> +
> +# Data, write-zero and holes, every combination at a cluster boundary.
> +LAYOUT = [
> +    (0, MB, 'data'),
> +    (2 * MB, MB, 'zero'),
> +    (5 * MB, 2 * MB, 'data'),
> +    (8 * MB, MB, 'zero'),
> +    (10 * MB, MB // 2, 'data'),
> +    (20 * MB, 4 * MB, 'zero'),
> +    (30 * MB, MB, 'data'),
> +]
> +
> +# Single-cluster runs, and a zero run ending exactly at EOF.
> +BOUNDARY_SIZE = 16 * MB
> +LAYOUT_BOUNDARY = [
> +    (0, CLUSTER, 'zero'),
> +    (CLUSTER, CLUSTER, 'data'),
> +    (2 * CLUSTER, CLUSTER, 'zero'),
> +    (3 * CLUSTER, CLUSTER, 'data'),
> +    (4 * CLUSTER, 8 * MB, 'zero'),
> +    (4 * CLUSTER + 8 * MB, CLUSTER, 'data'),
> +    (BOUNDARY_SIZE - CLUSTER, CLUSTER, 'zero'),
> +]
> +
> +# A zero run past the old block_copy_chunk_size() 16M cap.
> +LARGE_ZERO_SIZE = 48 * MB
> +LAYOUT_LARGE_ZERO = [
> +    (0, MB, 'data'),
> +    (4 * MB, 32 * MB, 'zero'),
> +    (40 * MB, MB, 'data'),
> +]
> +
> +# Image size not a multiple of the cluster size: a partial tail cluster.
> +TAIL_SIZE = 4 * MB + 4096
> +LAYOUT_TAIL_ZERO = [
> +    (0, MB, 'data'),
> +    (2 * MB, TAIL_SIZE - 2 * MB, 'zero'),
> +]
> +LAYOUT_TAIL_DATA = [
> +    (0, MB, 'data'),
> +    (2 * MB, MB, 'zero'),
> +    (4 * MB, TAIL_SIZE - 4 * MB, 'data'),
> +]

These globals with layout + size must be paired by hand, along with
expected layouts.  What if mimic what we do in iotests/040 in such a way:

  Case = namedtuple('Case', ['size', 'layout', 'expected'], defaults=[None])

  class TestBackupZeroClusters(iotests.QMPTestCase):
      BOUNDARY = Case(16 * MB, [
          (0, CLUSTER, 'zero'),
          ...
      ])
      ...
      def test_boundary_full(self):
          self.add_source(self.BOUNDARY)
          self.backup_and_check('full', self.BOUNDARY)

> +
> +
> +def coalesce(extents):
> +    out = []
> +    for e in extents:
> +        prev = out[-1] if out else None
> +        adjacent = prev is not None and prev.start + prev.length == e.start
> +        if adjacent and prev.kind == e.kind:
> +            out[-1] = prev._replace(length=prev.length + e.length)
> +        else:
> +            out.append(e)
> +    return out
> +
> +
> +def layout_to_extents(layout, size, gap='hole'):
> +    extents = []
> +    pos = 0
> +    for offset, length, kind in layout:
> +        if offset > pos:
> +            extents.append(Extent(pos, offset - pos, gap))
> +        extents.append(Extent(offset, length, kind))
> +        pos = offset + length
> +    if pos < size:
> +        extents.append(Extent(pos, size - pos, gap))
> +    return coalesce(extents)
> +
> +
> +class TestBackupZeroClusters(iotests.QMPTestCase):
> +    def setUp(self):
> +        self.vm = iotests.VM()
> +        self.vm.launch()
> +
> +    def tearDown(self):
> +        self.vm.shutdown()
> +        for img in (source_img, base_img, target_img):
> +            if os.path.exists(img):
> +                os.remove(img)
> +
> +    def hmp_write(self, drive, cmd):
> +        res = self.vm.hmp_qemu_io(drive, cmd)
> +        assert 'error' not in res['return'].lower(), res
> +
> +    def assert_map(self, img, layout, size, backing=False, gap='hole'):
> +        # Content is not enough, pin the data/zero/hole split as well.
> +        def classify(e):
> +            is_hole = e['depth'] > 0 if backing else not e['present']
> +            return 'hole' if is_hole else ('zero' if e['zero'] else 'data')
> +
> +        actual = coalesce([Extent(e['start'], e['length'], classify(e))
> +                           for e in qemu_img_map(img)])
> +
> +        self.assertEqual(actual, layout_to_extents(layout, size, gap))
> +
> +    def add_source(self, layout=None, size=SIZE, backing=None):
> +        if layout is None:
> +            layout = LAYOUT
> +
> +        create_args = ['-f', iotests.imgfmt]
> +        if backing:
> +            create_args += ['-b', backing, '-F', iotests.imgfmt]
> +        create_args += [source_img, str(size)]
> +        qemu_img_create(*create_args)

This patch just has lots of duplicated code.  E.g. this image creation
code might be replaced with:

  def create_image(path, size, backing=None, opts=None):
      args = ['-f', iotests.imgfmt]
      if opts:
          args += ['-o', opts]
      if backing:
          args += ['-b', backing, '-F', iotests.imgfmt]
      qemu_img_create(*args, path, str(size))

+ provide opts=None arg to add_source().

That'll work at least for add_source(), do_backup(), test_top(),
test_mixed_cluster(), test_top_zero_broken().

> +
> +        self.vm.cmd('blockdev-add', {
> +            'node-name': 'src',
> +            'driver': iotests.imgfmt,
> +            'file': {'driver': 'file', 'filename': source_img},
> +        })
> +
> +        # Write through the node, so an attached bitmap sees it.
> +        for offset, length, kind in layout:
> +            opt = '-z' if kind == 'zero' else '-P 0x5a'
> +            self.hmp_write('src', f'write {opt} {offset} {length}')

This for loop is repeated multiple times.  How about smth like:

def write_layout(self, layout):
    for offset, length, kind in layout:
        opt = '-z' if kind == 'zero' else '-P 0x5a'
        self.hmp_write('src', f'write {opt} {offset} {length}')

> +
> +    def do_backup(self, sync, target_backing=None, size=SIZE, prefill=None,
> +                 **kwargs):
> +        create_args = ['-f', iotests.imgfmt]
> +        if target_backing:
> +            create_args += ['-b', target_backing, '-F', iotests.imgfmt]
> +        create_args += [target_img, str(size)]
> +        qemu_img_create(*create_args)
> +
> +        if prefill is not None:
> +            # Not zero, so a skipped cluster is provably untouched.
> +            qemu_io('-c', f'write -P {prefill} 0 {size}', target_img)
> +
> +        self.vm.cmd('blockdev-add', {
> +            'node-name': 'target',
> +            'driver': iotests.imgfmt,
> +            'file': {'driver': 'file', 'filename': target_img},
> +        })
> +
> +        self.vm.cmd('blockdev-backup', device='src', target='target',
> +                    job_id='bk0', sync=sync, **kwargs)
> +        self.wait_until_completed(drive='bk0')
> +
> +        self.vm.cmd('blockdev-del', node_name='target')
> +        self.vm.cmd('blockdev-del', node_name='src')
> +
> +    def test_full(self):
> +        self.add_source()
> +        self.do_backup('full')
> +        self.assertTrue(compare_images(source_img, target_img))
> +        self.assert_map(target_img, LAYOUT, SIZE, gap='zero')

do_backup() + assertions is a repeating pattern as well.  How about:

      def backup_and_check(self, sync, layout, size=SIZE, *, gap='zero',
                           backing=False, **kwargs):
          self.do_backup(sync, size=size, **kwargs)
          self.assertTrue(compare_images(source_img, target_img))
          self.assert_map(target_img, layout, size, gap=gap, backing=backing)

> +
> +    def test_full_zero_overwrite(self):
> +        # full skips holes, so only check that zero overwrites prefill.
> +        self.add_source(layout=[(2 * MB, MB, 'zero')])
> +        self.do_backup('full', prefill=0xcc)
> +        qemu_io('-c', f'read -P 0 {2 * MB} {MB}', target_img)
> +
> +    def test_bitmap(self):
> +        self.add_source()
> +
> +        # A new bitmap tracks nothing yet: dirty all, then re-apply.
> +        self.vm.cmd('block-dirty-bitmap-add', node='src', name='bm0')
> +        self.hmp_write('src', f'write -z 0 {SIZE}')
> +        for offset, length, kind in LAYOUT:
> +            opt = '-z' if kind == 'zero' else '-P 0x5a'
> +            self.hmp_write('src', f'write {opt} {offset} {length}')

Same code repeats in all bitmap-related tests.  How about smth like:

      def dirty_layout(self, layout, size):
          self.vm.cmd('block-dirty-bitmap-add', node='src', name='bm0')
          self.hmp_write('src', f'write -z 0 {size}')
          self.write_layout(layout)

Andrey

-- 
Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

