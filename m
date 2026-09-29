Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FC2C9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBZyK-0002RV-1D; Tue, 29 Sep 2026 11:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xBZyJ-0002RK-70; Tue, 29 Sep 2026 11:42:23 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xBZyH-0000cB-79; Tue, 29 Sep 2026 11:42:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RAl5n7Y8NSrtO79UD0OYe8sM1/g0Dwi1KrvjS24uHl92ZSAfTHL1InYgLPyUYRZGAFn17FsRCS5+s6IlOXINZJs76MidLHxf8QgK0P82zk31Dagovme2WKgnCCVxL5sWIhVRmT3ZIqdG9idCpmzipjKcPbMOoFabElLsYLEAD25Vv+JAiNGvr4ASKh1DNpI3Fs96NNIWI2xBQoY+jTLtqmyEbqks18YENs1g0YymdB+/QQEmibzbBKEx0jtoukX9V4+mjEORLeIdVPooTmiU5Tp7rGaIkT+RhcqC0/ACqpK6duv62y8Ohpl+idA7IrTaN2+Iz7TLPjQP3D3dnblV0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8SH1GKkR3dpoJJdrXSSNryXM0kMfanPG2X5QbD1q3Q=;
 b=KZGDY/N4xFudVpyZWVpPWo2pmxLyeJdPIVN5I0pIcoITpTm3bnDsTTPevDfFygaFgfc2BzMo2UMQ4p8RuxojEJJ3rmcrm56Cyzp2NzBG2cBzKaCaYFQSV/4x/4RYnU5m0OQnUsJ7AkS9oJxRMPuJ2UgVAHiQ8ZrJUuIdqnhSAqCLj4wyiJH7AB+AxDN6l/50j32hi8JgnQPSpDClrlP2psA64RzYyXhdIdS5NHz7JKhsqQ6EK9Pbmkp5ly3C+EoVEypCpo6Bo6/Lvp/ZfKrmBvFbaCSZ017GwmTV0a+AGX726ZljMu6bNgP7vhNbXrr57asWNxONMUL0CWMXKRon0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8SH1GKkR3dpoJJdrXSSNryXM0kMfanPG2X5QbD1q3Q=;
 b=Wv6GuokAtPzbW7rd1EbNegkfG5yV0S7HtQLqrTMV7iLibfIKfsUzg81aXSPYOuKa1WgiNMX5eYWqhZNkrJtji/QUSOg+zwQwfCxfpyw1+iYyhbfmTFJLRyaoNFq1jCK4B2hcKelLCSPSHsNUXEbX0HTbl8M39b6toKVXCJJzPd7wT/p0wWHtif6YRZQkwxz4BBoO3Quz8R9sPGn/maOhCvemXAzMC6wJTf4o7IlG9d2Ua74c0blzLqDfK/rSDcinPvZb3AdEuS6xkqTYP1iUhKZNMCJ6v7zRkRng9oo14Wq4OV61+CQIeuywZadrHxd9ZkAVSvVgrogDQWfYui4oxQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DB9PR08MB8316.eurprd08.prod.outlook.com (2603:10a6:10:3dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Tue, 29 Sep
 2026 15:42:15 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%6]) with mapi id 15.21.0472.012; Tue, 29 Sep 2026
 15:42:14 +0000
Message-ID: <ca89ec9f-61fe-4518-bc8d-213481736474@virtuozzo.com>
Date: Tue, 29 Sep 2026 17:42:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] block, scsi-disk: honour a size change on child
 replacement
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
References: <20260812121500.1034178-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260812121500.1034178-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0094.eurprd09.prod.outlook.com
 (2603:10a6:803:78::17) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DB9PR08MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: b4dec50b-f10f-4847-94fb-08df1e403bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|10070799003|1800799024|10067099003|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: 5a76vGeNSSTh7Gdg2BvpwQACItI6xGHXhOHvgwLjxvEj60eIhKcgk9sdfp23WB7gMF4674K95003o8/FpBhICnIyv2pn2s3PiE84lL49RZ2MptwGYOyZYgvJqU7a1+61oThgKNcvnsAHNPUytzSExPk9tSNmIRkQNeimypEWrpF7+dTwOtj0Cdxa4gZYuUygYqZyd9FKSETMfRd3UcU/LcmsShe5OiaaWxXEnLLq7owFckuzqfb21QnPQeyicXIfrtSRIL4K1xYwT7Dmb/yup1VTHvQbHfaEVHKeHyZ+KdfPOZ+F/5ZVB3/ahnqu6DwSM/P7B2NLQUUEzaJitpiRMKX160la8sphfGtjxyyUSWXdj0J0+7xc3snrZslysOPba5RmiZu7Q7LRzv46QpXS4N6rY0vDCxQPGqOS7QrdLHX5aQxTYTlnIcRgAy+40lBxuXKvAjHEVqchkQO4fgMe7DHCZC0aQFP0oTHktOUVwPfIFdKnQk2LsLq78Ns4EdWiDy+AprVXY9pcj1ze9eP+2Wx20bw5mx3qrYAIfnis8vMNWKs8mJZD0RpoH/12Z7eKVtEJxIdqRx2CT1MU+gVo61NoaiPVkAnkDDzzQF2FkIBhlo3yxb/fdpBVsjC6X10LPKDVxRRUSwe11iQ8eOM35bspakpVLbjyhcbSF7cRm8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(10070799003)(1800799024)(10067099003)(18002099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUpwT05ZNFNDWDVDZENzQk91YzdCMDJJZ0U2VURTRWJRY3Q0R3hzcHBwU1ZK?=
 =?utf-8?B?WXhqUG9sSHRzVCtiYzh6cENGQ3RtTThqZ3VHK1hDN0FleHNjSndURW1zanZ4?=
 =?utf-8?B?ZS9KejlpQUM5UlFVQXpWSWxTQVRIYnpGaVc5UDQrSXNweHBkWXNOK3htMHR3?=
 =?utf-8?B?R2J3U2xQaUhpVlY3NmovMzhiYnI2ZlR5UDdhc2QzQ3p0L0VUTXhOSG9wZFNI?=
 =?utf-8?B?WlJndGNlVk5vdWRqbkVvMnQxNkdXRDF6N3M4RWVTODRSQUo3c25hak9JRTJS?=
 =?utf-8?B?UkUwR3ZWMm9CbDcvSDZoaEVEd0pZSkRFOVArUVpaMHhmTHpCQkdzZk5tS0Mr?=
 =?utf-8?B?YzVIWFJsY2J5SzVtcSt6b1krRnd3K1NoZzlxN3VtYVgyeTQvcjRrV05PYmFD?=
 =?utf-8?B?MFRLL3Exb0Y2eUx2WjZBM2dPeklQY1Mwa3B0RWRaU1RweHpiSXhrQ3dUYlVR?=
 =?utf-8?B?NU9lS1hFbTNKYWtYMFVPRXhTeGFEdEd0VGN3cFdNclRXbnFENHNwZDhvbzlt?=
 =?utf-8?B?NHR4aXVKNUk3NElJaUxUMk4vZHlxSmpYUlZLYUNsdjBtbTJOb2YrTUliaEdq?=
 =?utf-8?B?VGxrRm5WTElnOXpic0Y2c2JLS3FZdmNtZDRZNW1HNUx4Rk1UT3lIdjlhaith?=
 =?utf-8?B?T05vN1NvTS9taEtoTStlU3FMY1FRNGFYU1BFTUEyMW5mdE5zWTA0RTZXUkZD?=
 =?utf-8?B?VUR3dkdxU3Jld1A5VlZxcERXQlErNUx6SlVoYUxhL0E0YzlwcU9aaUxZVk83?=
 =?utf-8?B?a25aVTNnWFZad2pMMStwWWtCdzN4QUMrSU91YkF4alBuOW9Uc2srcWwxcTRB?=
 =?utf-8?B?MDdrMWwzU0tuTnZ4dG8yWjZtc3NYU0krM3dwNGhTcHNJOHpqeVlIdmJON2xm?=
 =?utf-8?B?Z2R4NlZLamIrL1l5QkNNdVJmc09KRjMzOU9XZ2p6UDZpc3U1RXd3YU5BNVIx?=
 =?utf-8?B?MFRLMkJueXUxLzBlZklqa1c5QmZnNHM0RDR6cysyeTFOV01CR3VQSmJmVVNX?=
 =?utf-8?B?ZjN4d3VIUmRadFp4bEFlYTdFTGtCaXJybzJSOVhKZFk4WmlSV0RZT25VNGhi?=
 =?utf-8?B?SEt6eHVpVFdxMXBzQ1g2dEx2OVFlTE14bEpKc083RWNQdW5IT0R3YTl4aUUr?=
 =?utf-8?B?c2dvS09VSHFrWkhBcXpVS0diUG5aY2RDbEcwbDlzZDBpQ3dGRVE1dVdUNHBq?=
 =?utf-8?B?UnI0R1Ntc1d4LzgwNWdockZKK0xIbmU3S3FHTlVJd29XK0QydDRvLzhka0tt?=
 =?utf-8?B?QXdoK0ZjSmNYaWV1WUdGRWdRWDBNU0c0dXk4Y2M0b05rSlE3RmpEbzNOaDV0?=
 =?utf-8?B?YkJEbXVwdWdPN2dsUmVYc1NnSXR6bGpNQUIwRDhmZlI5UFF1ZUVDWlZ5akJO?=
 =?utf-8?B?a1ZoRVMyREdlUTh5K01rS2dnamhVZ0YycXRQTnVSQ3NZZnVoRG5GbDFEcUwz?=
 =?utf-8?B?Sjc0TnpTRDczTUNhUmdmSStoZ3RQL1lsYWpBNkVONFBwcm5MbmZtM0JlVDI3?=
 =?utf-8?B?VTN3UWVaQXVkVC8yVDh1d0Z6YStvamxjY2VEb0k2MnM2cG53K01QZGRDZXcv?=
 =?utf-8?B?bHRhZFM3ZEQvRDY5eHh2N1FVdWw4TTNPMXhNMWdsOFMvR0RoMUtTWTdwNTdk?=
 =?utf-8?B?K093OTROZDNKUVhPYmRCSk1KQXh4WnYvdFhYdXpXYlVaZStteW4yQWduQzlu?=
 =?utf-8?B?Mno5K0FZN0ZjT01yRmdtei9PRVp3TzdVSlNrM2p2Sk9ob2RPazM4OHk1a0RX?=
 =?utf-8?B?WlJWbGcxdm9xcjJ2NTdVNG1KZzV3N3NXNWw4VHVOUTQwUUZITzBFN21iQWFJ?=
 =?utf-8?B?dDdJTXVnaEZiUnVsb1ZBRUlLLzNveTJVa0gycCtKUzg1S1JINWh4U1U5WnFp?=
 =?utf-8?B?enpURnN0aUZZNThWajMreElNRHBjckNjcXAwWHlGTDhQekhhTFRsSlFiaExm?=
 =?utf-8?B?Sjl4UUJCcmlnZU1sT0pwRHpuQlNWTGJBT2tqNWt3QStFeGhqZ212cXJ5elVE?=
 =?utf-8?B?K3piN2FwenR2b3hBcURrWnlHTzA1ZjhVUzdTRFNpMnBCSzcxeDNxbVNIQzZY?=
 =?utf-8?B?RnhLUEJQOTZMRkUxV1VHcGViVDNxUDkvTWhBMVo1UXhRYVpyZ0d1T055R1RL?=
 =?utf-8?B?SXFUbnVDaGVNZWlabkVBWUYvZERIMytPZXA0MkR4UllkSzczYjJwbnhqMHZs?=
 =?utf-8?B?VlRldVM1UEFsRkFGeDgza1Z6WEZ5OUFhUWROTUpYUUdOeTVTMnBQZEdKV0tR?=
 =?utf-8?B?azU3bmF2TzJVcGhFU2MrenYrNURVQjd3Vzluek9wTWJIMHNpMXRWQ3FkRFZN?=
 =?utf-8?B?TVZ0a25idnd6UHZraXRhYjdzeTRHZjYxOGV6WXhpQ1d3WTMxTXVBdDVzYWpI?=
 =?utf-8?Q?JFN3JUW/wwnPqO0GjrE++HqRBcdGDLNaBEgWy/ZoSsrta?=
X-MS-Exchange-AntiSpam-MessageData-1: a0YDWk8G12Jgew==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4dec50b-f10f-4847-94fb-08df1e403bde
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 15:42:14.8796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nf7K2nm8YDIlgRrXtASxf2KEuWZm2lfnrWQU72f37daJm9earGGiahALVJqqO/A5gpbCqQ19eZfbckhFKYn4nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8316
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=den@virtuozzo.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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

On 8/12/26 14:14, Denis V. Lunev wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> qom-set of the 'drive' property is allowed on a realized device and ends
> up in bdrv_replace_child_bs(), which swaps the node a BdrvChild points to
> without telling the parent anything about it. Every other way the size of
> a node changes goes through bdrv_co_truncate(), which does notify, so a
> device model caching the size of its child has no way to learn that it
> changed.
>
> scsi-disk is the one really hurt by this. check_lba_range() validates
> every guest request against SCSIDevice.max_lba, filled in by
> scsi_disk_reset() and updated only by the READ CAPACITY(10) and (16)
> handlers. Point a scsi-hd at a larger node and every request past the end
> of the old one is refused with ILLEGAL REQUEST / LOGICAL BLOCK ADDRESS
> OUT OF RANGE for the whole life of the device, which Linux turns into
> EREMOTEIO for reads as well as writes. It is silent on the host:
> out-of-range requests are answered by scsi_check_condition() and never
> reach scsi_handle_rw_error(), so there is no BLOCK_IO_ERROR event and
> io-status stays 'ok'. virtio-blk and ide call blk_get_geometry() for
> every request, so they end up with a stale idea of the size but never
> refuse I/O the node underneath can serve.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Hanna Reitz <hreitz@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Fam Zheng <fam@euphon.net>
>
> Denis V. Lunev (4):
>   block: notify the parent when a replaced child has a different size
>   scsi-disk: refresh the cached capacity from the resize callback
>   tests/qtest/virtio-scsi: cover a replacement that changes the size
>   tests/qemu-iotests/qom-set-drive: replace with a differently sized
>     node
>
>  block.c                                    | 13 +++++
>  hw/scsi/scsi-disk.c                        | 16 ++++--
>  include/block/block_int-io.h               |  3 ++
>  tests/qemu-iotests/tests/qom-set-drive     | 14 +++--
>  tests/qemu-iotests/tests/qom-set-drive.out |  2 +
>  tests/qtest/virtio-scsi-test.c             | 63 ++++++++++++++++++++++
>  6 files changed, 104 insertions(+), 7 deletions(-)
>
>
> base-commit: 3e3ccab106f879b1512f8e0d51a827dd4de30e22
ping

