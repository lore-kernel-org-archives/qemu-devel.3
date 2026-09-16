Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DA8C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6q26-0001yK-Dx; Wed, 16 Sep 2026 09:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x6q1x-0001vZ-LY; Wed, 16 Sep 2026 09:50:35 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x6q1s-0008Pp-0n; Wed, 16 Sep 2026 09:50:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBPaSXwKGRT2jJ4sIfZ4JzD6jTkLCSylux10+C3vfgNlDqYlvy5buUJZTPyI0mmaam5Ttl1eGjrnJs5EnC1ozuaVZzx3xouDwYMXYYwTBArc6l4HzSFVny97tl7/521hJzoxl9aAfl5toUjkk/WBk/ELgRQDXtYu15JcXnvD2QS+6xubWgQ8OeTZy6ZTXEKrkJ8loTLDfy0ZLL7yKdT2D85mP/3kslZ+U2G3dVZysEeKV1u7as6fQ1hvVpQo/Peih6yBA8JnfLu+AiPiGdX4BFp3+35fDW+wTjecwEm26URC/Eoa4OVda7iUFtxvq3M8xzWA2W0x1athnU7dvn35+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3VF4VYz97nNF7rvV2Et4PR2DBP8ry6X6TutPg8U0FU=;
 b=d8aUaWYhe4atD37zzwnYMbvS+NtpQhThurmUzz66iEA92r1p/vs6Yl1lr7AGtGvn/Kgmq9wUfht9IkPzG/LCDlbVI2v6ZKHg5S5034zFFPaE1PR3EeZ4GeSneb87ul6VHU45h1EdvRkD01qXJ63VHsAr578x+N/dSawS+1uO1RsCfZy9MKoyOGWyybYqoVwWZwmzrs5c/5j9BZozQPhS1cy+y1MzTBSOYVvNx7XYABFlfmQXKAX95Qe4U55DS2lk5nAGifAc1oTGNv2iHmn4HXZTeBvvNarqFNg1USB03FByHf0ECFA/5VQnJ0y2vQCApKzDJ5g/rjq3kyd+XhegcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3VF4VYz97nNF7rvV2Et4PR2DBP8ry6X6TutPg8U0FU=;
 b=ELm+IRM6Fpa2S1xEa7vTShgumggpYOFsTHqRawu2pUNp22JqnhxLyVciOJnV/CQOfjaCATnXAavF7XZLjfTEaHHgjclSUf/3POpOYyXZOxjPtrP/06mqpPWAbF1Sv8rlDKZM6yUVvphuvtHSwrNuQVuBuJ/JMQBcr0NPFixEO/UIWWT+wUHE5ar+aX+6MxoHN8okbpjGqHg6rk/aRxf1Wn3Aj5s7jKax0RykCTr8MdFk+rdwCSuHvXFilBFhMaafLAnlrXalknKZCU0tLw81CGx9yzLbF7pAe+6xyb/wv87GA00bIElV77C4ewh61kkq3LJ8RW1bo8GxbxYaWFWvTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DB9PR08MB8339.eurprd08.prod.outlook.com (2603:10a6:10:3dc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Wed, 16 Sep
 2026 13:50:04 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%6]) with mapi id 15.21.0451.004; Wed, 16 Sep 2026
 13:50:04 +0000
Message-ID: <a5560dcf-a8a8-4ef8-9ede-27993b9700ea@virtuozzo.com>
Date: Wed, 16 Sep 2026 15:50:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nbd: call reconnect_delay_timer_del with
 requests_lock taken
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: den@openvz.org, qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>
References: <20260916132740.872244-1-pbonzini@redhat.com>
 <20260916132740.872244-3-pbonzini@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260916132740.872244-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0125.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:350::11) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DB9PR08MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: d9812f7c-1712-4751-d9a2-08df13f9695b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|23010399003|366016|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: quZ8NKgpfPNCAR13W31NJLG3gXZ5eYNowzQ20cyW6IpZLkk317Zm/p6RQne8nrWzQbWYu/C9Rf7/NalN1Q99qfnU1Xb9c0OjKMmB9sXZoqigTxJ2lWA1Apby9YcSyjp+PnMn5ptbpQz5rg75Me5ZY2Pf28O3ZEeikL9k9MgTTP8FjKmNbDmebg3Ny26YwXU2fzUubfXEqlO+N59GSJf6IrHgr9bY9IYutL/UGyoWOBfjsiPe69sbfka/txEJtaallm4uzUHW1Sbb3eSICu2ImfR29Vi2sefaCH4gBvZ+M9R5saf99pU3ubU1BrP6/YXG6KoGs1lxmMu6OLSFkkDgwJ14Mc1XUaQaEqkC/8i5whtM/D5QYOcS6ZYL00CoQtZoi/yYeEameWunyh/PldiDRmzP8YZ/NyiLgTx0Mecq78X+lpffpSJCGn2WcEfXcatNpKdUAOUy+FBHYVpc9X2Pm9z39Xco7gdcqEvuw7xGdvdjq/GozYKT4qJSHShfaxCUwZkJPrwbyfz584yGdOIb1sMSvQwbvoypsRiN8oAbHi5rUS0OqjuhgiPqurBoeXOvmT3hn5TxThsCoSZJi/1THXDCNanKxSHtQBMerDqrIJWomgJsJgoe//8z/EB38JLcHdL/dEtavTg/pF5R7pPNB2F7UX7pYsqLRt3IYgGXKhs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm14V3FWb0ZGeEJVYUlwczhJL1NLa25qMEErcUpsWG95aGZNL2dkOXNlZ1g3?=
 =?utf-8?B?RnFkcHZ1R2tzM0JucTBiVE12MnhsYXE3KzlveC9Bd2hhVCtIMzdrNVQwc3kz?=
 =?utf-8?B?c3hiWjU5Lzc3bnNGZXBTMjhveEhuL2l5MWdYejJTMllRK3ZhUUVlc0w0RFV4?=
 =?utf-8?B?Y251T0VYZEZ2bllzSG94azFaM1N6em8vZEVMaGlER3l3akN0T1VHb2xTb2Nl?=
 =?utf-8?B?TUlpUkdGRjJQcDFUMmlOMFhDcE5QZXgzV3RRVmYvdnRpS3NMQUUvc2tvSVRN?=
 =?utf-8?B?b3pSbG0rdjRSZzVodVpUOVNHNVNxWWc0eS8vVnN2ZGtZenFFNG41NGFXbUNH?=
 =?utf-8?B?OWhIK1ZCa0VVa090RXdGUG5KcTVrR3k1a1diekY4VGhxSS9wNkdDbjlNTFdw?=
 =?utf-8?B?RDhSUjhZM0Z2RDJNdnFHaDJSRlA4MVBpaU5zWFk2WkhoOFk1emVwSUZnbWRY?=
 =?utf-8?B?R1VIZFFtTEtMb1FpeUlYZS95TlArTDVQUVR3Z1p6elJSR1RNbGFGekxHeTU3?=
 =?utf-8?B?a0JVbkQ2QWF2UFJQaXh6S0xCajk0aWVYK2pWMXFYdmJOdDU5RTROL2phcUpL?=
 =?utf-8?B?MldGb21Hb3E4N3MrTmZURDBVSnFURmVEYjhZM21CcXRwV0xPOWp2L3lhdFhr?=
 =?utf-8?B?SlNSaHBSV3owbUEyTFNncDVJbUZZOGNybzAyeXZGWFd6S2pVaEJPL0pLTy83?=
 =?utf-8?B?WUxtZ052cVhpVElxNUZlMEpWYmFVQWJQNkwzWkJiZGdZVW1iZ1BXWHc0QXhE?=
 =?utf-8?B?MytZTGFwdk1TblJaaUZ0eXY4bnpWOTEwU1hwbTRhcWh2ZllINFVjRE0wVnRY?=
 =?utf-8?B?cHQyemFZT3dybzBxTUJaSmJjLzZBTlRFUWNGeDRXTWtOdlBZSUg0eklVeVFx?=
 =?utf-8?B?eWEzd2tDbkpCVGdEcFFqVDFTRXBDWnUzT0plSXVjOWRIekErRTVXbVQ4NHJu?=
 =?utf-8?B?Q1A5emNvNnJDMitIM3ptdGRwcEdKN01rK3hid1NvZXlzRXNNRUxWRlcwQUxx?=
 =?utf-8?B?ZlExRGE5cHdHcjErTUE3M2NCSzVYaG16YisyaXdrQjQyR3RUL3ZXbnJqL1B6?=
 =?utf-8?B?WXZ6YVBkanpIZVpSYmhERzBzYUprK2sxOGRaMVF2akFlTjBtckFxZVJ4VTNq?=
 =?utf-8?B?REk4UExBWWg3U21OZWE4V0QxdTZ1WUwzOU0vZUxMRGovdkUwTlJUMm1MOFhj?=
 =?utf-8?B?ZnlZaXpDS2RkR0t4aVl3QXRlK0xIc1luVDhjeFI5VjBUNFU0UEZ0Z0o1ZFEr?=
 =?utf-8?B?cHg4cDRTZW1VTWtrOWtSS1ovelRSSVdIMGJGQnM3Mmw4dlF4MFhSVWFiMDhH?=
 =?utf-8?B?cVozVzAxOW9telY0U1VIRFJXaFNWdzAxa3FlLzYyaWYyRTZlTW9OdVdwc2VU?=
 =?utf-8?B?UnU2a0Nkek9YcUZkZG02NkRHditWUEpkZXQ3ekMrdmFPbHZ4WjByeG9zcjhF?=
 =?utf-8?B?OHRvWDcwQXlRZjFoeHFkYno1N2xCN0pUS1ViSURxTUV4T2F0dnJXUWxZUjBt?=
 =?utf-8?B?L0w3ZFBxS3FhclZrUG16clhlQ1dxNFpVSDFlVGlBYjRYcGQ3TnV6bkkrN3d5?=
 =?utf-8?B?dktJVlBZYVpsdEYvems2bzdxMUlvbTZWemNmTk9HREhwSzJuSTVTZ0JaeWFu?=
 =?utf-8?B?UDJaQlMrcFVta0pNMktWQUxkdnArZnFaUmE0Z1lVWTNpSis2eFFOQWhCUzBh?=
 =?utf-8?B?dmNTUXBpK3lxL0Q5akZpb0hXVmRUMTZhSXpBeEgvamhVb0wyS3lYWkxKRTFK?=
 =?utf-8?B?VlJhd0NQUFAvV0FYNWhkVTlUcnVoakZ4YlpVRUg0dE02bE1jOHA4T09tWnls?=
 =?utf-8?B?d3UxaUZZQzBsbG9rY0p3RWhCVEE1NWdIZEtYcld0Y25EVDVaYStvWFQ0NjNN?=
 =?utf-8?B?RlVETWhtK0RKeXJtbGkvOTlabVpvYVhFTVdvY3Q3aUVHSDhheElRbFU1WjNJ?=
 =?utf-8?B?RURKRVNTMWE4aXBGRFVhM3NYS2d3WHdBdFJGeXZzN2NYMEJubVdzcnJxZUtW?=
 =?utf-8?B?cXE0M3dCYkJiWTN5WXl3UG9zVnhjKy92SU1jVzRvUkZrZTdOYTgvQ1BpMHFv?=
 =?utf-8?B?ZHFuMnZzMlNFUFlkOXRwWCsxQjdidFhxSnpWaVNqSXZ3QUFCZUUyUmIwazFV?=
 =?utf-8?B?WFh4UWdEZVZqWGpJWkRsdUhOQ2xId0pSbXI3WUhZc0lBaytQSEdQWThYZHhP?=
 =?utf-8?B?MnQ5V09hSnhRd2JqSXg0d3hUVzdzMm1CZFI3bDdESi9ScXNEL1Y2aUNDem1v?=
 =?utf-8?B?ekZNemR0Yyt3MWYySzhDU0Rqdml6Y2ZnNC9vclVDQ0c0dExpQkk2NGhvUnlj?=
 =?utf-8?B?WU9LdnE4ODlaangzb3I0MlhRc3d3bzZIbHJ4SDlzNmtwZmM2azB4VGNqNWh1?=
 =?utf-8?Q?SAh3Q/TBpqcvN7hyjs2zQkF4lS0SKAA6kLmQZ70olIzlB?=
X-MS-Exchange-AntiSpam-MessageData-1: kvN7oYYmhgboOg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9812f7c-1712-4751-d9a2-08df13f9695b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 13:50:04.6460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vt4SdlGRKsLceuHwVam2bGVz7l55df8aUSU/wQDfl9lwynJdsaLJJqQdwGRfG1nq3wTWRkQZACoGt/3rkeMIUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8339
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=den@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 9/16/26 15:27, Paolo Bonzini wrote:
> This ensures that s->reconnect_delay_timer is written under the lock.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/nbd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/block/nbd.c b/block/nbd.c
> index 85842e7cdfb..82af55ec4e4 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -207,6 +207,7 @@ static void coroutine_fn nbd_channel_error(BDRVNBDState *s, int ret)
>      nbd_channel_error_locked(s, ret);
>  }
>  
> +/* Called with s->requests_lock held.  */
>  static void reconnect_delay_timer_del(BDRVNBDState *s)
>  {
>      if (s->reconnect_delay_timer) {
> @@ -219,8 +220,8 @@ static void reconnect_delay_timer_cb(void *opaque)
>  {
>      BDRVNBDState *s = opaque;
>  
> -    reconnect_delay_timer_del(s);
>      WITH_QEMU_LOCK_GUARD(&s->requests_lock) {
> +        reconnect_delay_timer_del(s);
>          if (s->state != NBD_CLIENT_CONNECTING_WAIT) {
>              return;
>          }
> @@ -2134,9 +2135,9 @@ static void nbd_cancel_in_flight(BlockDriverState *bs)
>  {
>      BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
>  
> +    qemu_mutex_lock(&s->requests_lock);
>      reconnect_delay_timer_del(s);
>  
> -    qemu_mutex_lock(&s->requests_lock);
>      if (s->state == NBD_CLIENT_CONNECTING_WAIT) {
>          s->state = NBD_CLIENT_CONNECTING_NOWAIT;
>      }
Reviewed-by: Denis V. Lunev <den@openvz.org>

Added Vladimir + Eric as real maintainers.

