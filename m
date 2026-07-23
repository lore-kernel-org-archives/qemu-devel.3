Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A833EC531C7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmndd-00028D-MK; Thu, 23 Jul 2026 03:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wmnda-00027X-5j; Thu, 23 Jul 2026 03:14:35 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wmndY-0005Bc-7O; Thu, 23 Jul 2026 03:14:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6PxtlvhFYRg5PbfLj59XwBxQvJysySjECDu4wtfTAn2Te90IWQ23s1YbaFmJ5DxuaMqpWDUwh9E2sVCjkmZC4SMKdo40AV+TNwni38q8V1XHMrAKHqSHj6Tdx2BTpp1RIVJxRXYIIV2V/OrxMU46u8x+qn1SHoaev0LpepzjP+VcuPlDn7w0es2hKUS807w4WMPnCaKXp92DSaVvwAZTmOwK1sNPKsuR3O2AMQ/+Svgu/XoJcJtlQ6t4T0YY8sSYrmJeutJsyJdhJ0bBettpwTzMJlghlF/MwAumE55wThO7q1ZQOXpJHXlcmWFNC1ju0KHoMZyqiXRPzkEeQvv2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uyZUE6RJXfbW3HUkXbeW2sEZPc7/FSzLUJtYrhaqfM=;
 b=WkcfuWjT2junZ1n6V/xABMjLE3LTUQtmT1tTliWrJx5YamavC0Umf5KZxU3EHiDB7zWM0rIto24Guo3GNT75kIdcRvsL/DXT72TYdgIMfuc/ZEFgzTkvQ0kQHdoiWYRyaZRuY9CUls4lu9bvVwfl4TZZsYUb/e5h3S3Il2WJh/KO5f1gQLz19iIe8ho0qe+x37kaIOgbm7IYCwjj59vzrlvwC3cK/+vv6nsRwKILbwoeA5qSgAdoIYd8ovawfMURHTr+wJx2P1r+WsIpy0VzE7lQd4mgJEiEhomNA5sVr6QIkl12fXtNu+yIRcssSUzcm9Ys1iWqia4Lcyj54XIdvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uyZUE6RJXfbW3HUkXbeW2sEZPc7/FSzLUJtYrhaqfM=;
 b=PWLA70wVTNjoWPlOFySCdMjVm+tOisOe518ZAMSAO86lz13d5HYU0y7VasIookwz2gj5pXuV7xTMF7Ki8umujVR367Ln/rm+79XmbBsjMIIzsCrclDhyaIdYTbz0Wvz+xM3/A8VTPyWKmyvzxMK9Rtmmqz6ECkICRd3okuxALjt5NZck0X4aKmziPTS9bzWT/bC3QL11EQvaUXRNYBUVWjGzArAkTE3tH40P4FX3DbUC0a92/VCmcjd9eUvzKWTcvQoR4XvIbil99z8bZjzlPD1XePQ02LEVr3FBNoPHLiozi1rxeVFGxfEspBMmBYivDoTFaIgAW/Bh5IuCXGhX8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DB9PR08MB8385.eurprd08.prod.outlook.com (2603:10a6:10:3da::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 07:14:25 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 07:14:25 +0000
Message-ID: <fe983381-0681-4146-8e97-c6920bdafb7e@virtuozzo.com>
Date: Thu, 23 Jul 2026 09:14:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] qcow2: do not try to clear the dirty bit on a
 read-only node
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20260716153552.3376009-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260716153552.3376009-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0053.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:353::13) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DB9PR08MB8385:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dd2dd74-3b24-439e-b2da-08dee88a06cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|10070799003|1800799024|366016|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kygwxuyRPoMqku+nbwEYCCHkRfOamwvEKGtMvsW2sDmwL+o76/owGisye0BsukV4nlmvq45TQUsB9xnwG2nD4/95w0RqXRVro78Jsno8VmhqAC+kZJ9sCMxEWXytfZCn/Vbgnmmvi8G2G+LC7sOrud2Efw1xFmMZ6cqdimBuCHVdiZ7m7evVyJh4076cLHks4KYw29ULM9Nfz/pjUYc5e2Xb9EGe5Ttksg8IJwCjAgWbf0ACadzK5A25lGPTbeo0t4R/n2I2YdKe1DsLKjMIJh73v4wwdLO8c/qbFaJsHNJwK4qBAHzD/AzL+xntJSuW1y+Xaw3WYSFszhW+8WUICBFhqbEX4OT2XBVMJxGes5aBoSkAZKIW5l4dqiIFVrc9KrjifnuI7e6va53+qHB6LUiB8GtCCLwzVabUcTYt4u6f66SYLnxn3y7xA5fIaD3GRlIWNVQY2wDKGUlXZLcH8bNV+YGe5r4Cf7f6vP6S6kKVOkzBiXUrdg/szRgIu+HBE0xD7LU/iawwzfHLGiHTFqrSRmPDi8HZOmVVraAyU2uS2iVvYcNgjZIWkr/RtuwlFYDbq4fIN6CJHHuwdekhZ8mWJ93SwV4FnqULmYsdQ1YwWv4COuVz4vcFHm5vtznzUYsBiCN4F6p0sOb+D/T5A+c/Me2dyZDPkqOBWzouBfE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(10070799003)(1800799024)(366016)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1VFVnZjbkJwbnhFalY0ZTFYc201Nkt6VDE3SkRtTm1NaVY1dDRudENJRGxU?=
 =?utf-8?B?NnJlMzFTSEpQMjNEOGZ4THV3OVB6cGllVzVzSEFaSXBvcnFjVE12RnJCT3ZL?=
 =?utf-8?B?MlF3RXdwUUxmcVZTaXZNalNLeFJMUlNMR3c0NzdBVUlGdjdnelZ5aDFBelZW?=
 =?utf-8?B?YmxmWjNWSnFES3dSS043Q1FxVml4dDB0V1ZGMVJ1Wlp5RzB5VytqczdRM0Jl?=
 =?utf-8?B?czBjdWlMSTM3RUFaTDJpaEtOK2FzcE16UUNDYlZrNkhFWTdrdzNvaENZckZn?=
 =?utf-8?B?OTlZOTZWd20yZDF1ZmJYdVpOY0Y0VE15NXc0WGswczdEK0M5MkdUOUcwei81?=
 =?utf-8?B?WDk5alZDNTNnbFduaVZQNEtXNGpkdTlLZk0rYnV5Zy9rQ2h3Ulp6L1ZzSUgy?=
 =?utf-8?B?cTNuMTFEdEV0eTlrOGF2Yjg0bysrNUJQNjZic3ZoU0FPZjZHeUlkNEtxVmRq?=
 =?utf-8?B?QklNT1ZES3lSR2s3MEZ0Y1Jzb05IN0pYR3p2TjRYWmhxdmFHTS9OSGJaY3pG?=
 =?utf-8?B?dStqMS9MT3ZYY3g3Qkk1RjZ1dit2bk5DTm04R1AybFQzZjk3STlrRVJFbmtP?=
 =?utf-8?B?Q1NQQngyMVczNmpobDdsK1BHTzlQWXkyUXlpQ3g1OWtOUVZwZXlRdjIrenFT?=
 =?utf-8?B?cHpiWms4UVFEVlFCZVZGK0lEMmhIVytpNE51aG9RY1RmMGtkZ2FRcFFKZk9y?=
 =?utf-8?B?SEVQcmRrRGxmbFpCcnc1OGZLYitWUDhMVUI0b05OME1KNFJIYnVvQUZCZnQ3?=
 =?utf-8?B?OThQdUJkTkcwZHV4NWNUOVVGMC90QmU3NWxWVWdvamE0KzNmZ29QU2loU1Fw?=
 =?utf-8?B?aWR5cUVuRGU4L3JkZlBBcENIb2I2Wi92UjhnaVY2emk0NFZGNnpjQWVqdUhx?=
 =?utf-8?B?Q3o5ZFAzTVBUQU8yQmxqQXRNWE5uRU9PMXBFNDA1clpNT1p5WHczYVphZHdM?=
 =?utf-8?B?QWpVRTd2WTRCN0laRS9NS1BBcHRuMFB1dVhmRm42NG8vdXFmeWRVZDdIaFR5?=
 =?utf-8?B?SmhxdUU4b3FnNjlvRXVQNlJlQmxuK0V0eFlTek52ME9ORkg2aEZ0NVFqLzcv?=
 =?utf-8?B?U0J4bDNNMngxK0Y0elNlRmlvS1IxRFdDYmhpOHlVbTFsWktMV1ZwQnNyOUFR?=
 =?utf-8?B?Z0t0eDBNd1FqOFpkQnBKcGVucUJLOTBjUWJ6RHowMkE5dWhaMGo4VjV3N0sx?=
 =?utf-8?B?STdRZWo3MDBmRGY4aHFvSlpETDlybWZxdGwxckJwZkZrRUhxVWRXUTBMc1Ft?=
 =?utf-8?B?c3V0b0svWk84VHNHVC9heXZBbU9vcG5XaC9rL2tTcHgzSWcxaCt2NmYzaURE?=
 =?utf-8?B?M0tIbWJ0WHdjbTVodm9KMTZKYlo1dHRQZ3h5R09tRUdIUEFpc2RzTDZvemc4?=
 =?utf-8?B?Um44bDJMdGhoY2RldlkrTzdRWkJISUFkRjBuSDBDNG0rOEE2d0gxc2xPSDVZ?=
 =?utf-8?B?UlFudVFKZE5ET2xnVTBzVXRLV2NEQ0hQV0Q0Y01UZnlMcHR0bzRBTmhDNktn?=
 =?utf-8?B?NGdMR243L2RqYUxSV0FucEVlQmNUS01DREZsMGI5UXJuUHk1Y0dmS1VYODgv?=
 =?utf-8?B?OThhWmRxRmN2bmh2ZkNTc2YxUS9RK0liSkRtV2VZZS9lb1FoYVJaWFVhYnpZ?=
 =?utf-8?B?ZUdKZlp2YlhRVXVWQ1RybjhqVTBHUnZVMENmV096Zzc0Y3VidjJhd1ROcitk?=
 =?utf-8?B?N1YyNklEbmZlOVQrcEluQTNqV3ZhajkrTVhlV2dCaGVyM1lYOUhOS20zaXZh?=
 =?utf-8?B?aGdkd3Q1U1hLb3k1ekdlaHVOS28reDk4Qys4UU5tb0Z5UXpocGc0bEVMMmd4?=
 =?utf-8?B?cDJzanRFQ09CTVR4VDdKSklBYkYxQm1IMi9QWVpJbElJbE8rMkVpTnd6Snlq?=
 =?utf-8?B?dWhZbElMS2tRNjhPSGJidmdFZGlSQ2hUUnM1SytiMEZ1RE9GR3NWWTY3TTJH?=
 =?utf-8?B?ZGhrbUd6N2VpZFFFNzRnMWFaMTRkdWZQbDdETXJWM1FDcmQ4Z1RaOEl2cDkw?=
 =?utf-8?B?L0RCWHMvNWpGQ2k1WnFrS2ZzWWtTcDdydmZyL0x5MUR1OVVZSHI1eC9RMGo2?=
 =?utf-8?B?K1QrWWt0VFo4UDNEeklML0xYcXAxMHVmd0NTRCtMYlJDYmVBa2xhUUkvbGtN?=
 =?utf-8?B?T1VLeHBraUF1aWFjT05vSHdHK0N4dGJSSExsUzgwRmlzZ3FxUXJiL1U3TUdx?=
 =?utf-8?B?QlNvc2s2dWJVeEptc1lZUVFnZ0RnNWFERjdVMUFkMnBhakdONHhrelNoRDJE?=
 =?utf-8?B?dllaL1U0NUhscFFHWWN2STFONmlQNGxxdEhiMXYyaG5iblpsTnBvVFJjSDFG?=
 =?utf-8?B?Q1J2Y1AzN3ZnWE1XR3p2VitZdGk5QTl5MHNMVnB5UDExb3JTT2RVMnAwMVhw?=
 =?utf-8?Q?34bjWJSP4DdMIx2UA+ihTeIB0MR8bws3QxSK2+5SOQT7l?=
X-MS-Exchange-AntiSpam-MessageData-1: lJ4gbvDlaDjmqw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd2dd74-3b24-439e-b2da-08dee88a06cb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 07:14:25.2082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fUOBv1f6TTdXvS8M4vNKFDPL+RBJXuuhrSdVoQoFruuVARl6bSO+nZ+tyn5jOKsnLBHHG/Ync02+q3GIuy6MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8385
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=den@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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

On 7/16/26 17:35, Denis V. Lunev wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> qcow2_do_close() -> qcow2_inactivate() clears the dirty bit with a
> plain write to bs->file, unconditionally. A read-only node can still
> be dirty, inherited from an earlier writable session, and that write
> then hits a missing BLK_PERM_WRITE and asserts in
> bdrv_co_write_req_prepare() (block/io.c) on an entirely ordinary
> close -- closing is expected, the dirty bit on a read-only node
> is not.
>
> Skip the clear for read-only nodes, same as read access already does.
> Any other still-dirty node keeps the unguarded write: it is expected
> to hold write permission, and a missing one there is a bug worth
> seeing.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> ---
>  block/qcow2.c              |  6 +++++-
>  tests/qemu-iotests/039     | 11 +++++++++++
>  tests/qemu-iotests/039.out |  3 +++
>  3 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 2ab6ddd7b0..adb177e6b6 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2870,7 +2870,11 @@ static int GRAPH_RDLOCK qcow2_inactivate(BlockDriverState *bs)
>                       strerror(-ret));
>      }
>  
> -    if (result == 0) {
> +    /*
> +     * A read-only node cannot resolve an inherited dirty bit here;
> +     * leave it dirty, same as plain read access already does.
> +     */
> +    if (result == 0 && !bdrv_is_read_only(bs)) {
>          qcow2_mark_clean(bs);
>      }
>  
> diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
> index e43e7026ce..94a8bfe754 100755
> --- a/tests/qemu-iotests/039
> +++ b/tests/qemu-iotests/039
> @@ -84,6 +84,17 @@ $QEMU_IO -r -c "read -P 0x5a 0 512" "$TEST_IMG" | _filter_qemu_io
>  # The dirty bit must be set
>  _qcow2_dump_header | grep incompatible_features
>  
> +echo
> +echo "== Read-only open must not crash on close =="
> +
> +# We must not try to write the QCOW2 header to a read-only image.
> +$QEMU_IMG info --image-opts \
> +    "driver=$IMGFMT,read-only=on,file.driver=file,file.filename=$TEST_IMG,file.read-only=off" \
> +    > /dev/null
> +
> +# The dirty bit must still be set: this open never wrote any guest data
> +_qcow2_dump_header | grep incompatible_features
> +
>  echo
>  echo "== Repairing the image file must succeed =="
>  
> diff --git a/tests/qemu-iotests/039.out b/tests/qemu-iotests/039.out
> index 8fdbcc528a..c66361128f 100644
> --- a/tests/qemu-iotests/039.out
> +++ b/tests/qemu-iotests/039.out
> @@ -24,6 +24,9 @@ read 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  incompatible_features     [0]
>  
> +== Read-only open must not crash on close ==
> +incompatible_features     [0]
> +
>  == Repairing the image file must succeed ==
>  ERROR cluster 5 refcount=0 reference=1
>  Rebuilding refcount structure
ping

