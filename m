Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAEACA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 08:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDeXR-0000iE-F3; Mon, 05 Oct 2026 04:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xDeXL-0000aL-UI; Mon, 05 Oct 2026 04:59:07 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xDeXC-0002XH-LB; Mon, 05 Oct 2026 04:59:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FyR3BJxwOo9R9xifoEf8GH0ALI7CXihlWLPt8aEhowPPKXT0fenY1LJiMtIanF6MYM+aYLNClgKOiZJrhOtJRBPhwc4Igyy76J0yZlOtBequGZ1sFe4A2Nkc9M7UcGd9ShM6C9C4+TArychVd5Csdzc5fqvxST/RP3Gka7aVJ3n4ywyGHWg2KvWWOf15UICSAFVaFrHRnD3AI4jazSYD2g5Xii2eWw1LpkgZZVwCU+OdBg+zZ5iH8Oqyj0SdbpQ+0ehNX66Qsautil4X+sbIaxIZYKunDwYicxV888FB1M8L8wE5Kim7SfttAPi2nJgx1dQ62A0bxFovoZC+kaevPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8SH1GKkR3dpoJJdrXSSNryXM0kMfanPG2X5QbD1q3Q=;
 b=K6WGe1AX70FEA5AWP1oxrJDVwCpy52JKMZP5KPaq6U6PKAsjwlqbUwHpptE8KZTU2bZ92oMshNVqwI9Md9BUJP273gUlIJ9uhuILulBGlkfRpPuRMYALrdqTd3m352qEEVwSex17RrYr4Sj3KzdGCMRRfdxAy6kqTjcdznarKlMk/5hvG87IqZjMghNTIFVj/1BEq/AuucRa6geBQ4KEfINUpzwhF2L75MXNqNOv4knuqJGUN1AEYOBVhfDuTYGm6ExFOQiSarNcxYGuE+i3KNISJa7IyKyV66amv7sVkn56oP9MkWa1DBplys/aEQBu7Zh4NkL10XrfjF1edOQHOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8SH1GKkR3dpoJJdrXSSNryXM0kMfanPG2X5QbD1q3Q=;
 b=ilhAovuOmLBW5F79cIRoTYADRMhoGQl5rG6NcNm3oOrv+AJnvFXAz9i93C5emsFGVktjpkrirwfmHcw8fqhMyJ6XVyrCDDBa36eeayt78YGef0xMQiFrqnhhP+V4ShkDotit7OAQAFb1YATe94eG6xQ6L6ysZ+T2Lzgkf1HaZB8ii65dsrbiEd/StAXQoR03LnqmTMFI+lilptN6u7UULNohZWWebUeBNdtNXnNgktItaUvQ8gnDuHQd1nYQqvXWxV8DXf5uxTU+qn1GxRYxGbE2TYVfyUtObTXdkjuheHz9BJr49gViZb+4ZwiUncKPRnX9w5RsvJD6bJS90Si2QQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AS8PR08MB7741.eurprd08.prod.outlook.com (2603:10a6:20b:525::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 5 Oct
 2026 08:58:54 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 08:58:54 +0000
Message-ID: <afcbcf32-dea6-421e-8b49-18e3788cbf68@virtuozzo.com>
Date: Mon, 5 Oct 2026 10:58:53 +0200
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
X-ClientProxiedBy: VI1PR04CA0128.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::26) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AS8PR08MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 273da72c-f516-49c9-9a16-08df22bee207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|23010399003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yJZcVZJCKS4OXlptHgpnfZ1Y0N1Ncd3fHyblbUmO6ahPFbxhHutzPc9I7fbI5S+QnINTcey8kraFU5jj1IyNOAFrErgQL8F4ZLCO+zh79JN6IUa1YFiVkCd9evqWVcXZSaMKvAf6YnpnjJRiaEQzYiSXdGdBUWuBj0hBQOVd3kz2+JAhFkUJmUB2PhgL8JEz8FdzdM+lTx0iEDTXQn94/jMIuN0bI+RW414eD7Ez/fOmcBWuRFTl/DlnGhVZCXqOIoXr8X5/UXnxPA7TKYkTch9XyFkuphUFm96ddrMRTVE9idAFUWZ4v4mqsWZAjvFntqo/9n6e2LD8YoWmemlGOgsd6IF99uLu6fKRw0k74We33AkMgpFEHGRdvNGWI/nBqxvLQmFnPVFjwk5ImRzj2ET1kG5po4KQueQwhy5MbJ0+DqvSLlQvXykB15l5mbpKIFiSJkob5c0PMZBj8J7/VXMVkYrqrwtxo58fEOBv4Eh8QiVhNrGdgZ9VokQJ2NM0xca2azmOtNlENELGyCbo2f43GeMSfB/XJDPvNR45nWKteqePs5JIfIkdo7rBIgmGr1VkWfUermOulYbLop31CUxib4L12ow73gwrq7+QM05u1+W3M02z8WBR9KW6k3hNeyualW1QJXqZsaQjCiMbWhkzrXvZOdJU+BJ8gAsAveo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHhSVm8vcFRtMFBXeUwxQ0lHUlY2dFJSQXZGMi9KRmJoMjFNd3hWcHdsS0NV?=
 =?utf-8?B?VG8rTXhBVkNNRFA0Z0JpTWdMYkF4ZHNaWWY4eGsyM21mRzlkeVFnT1Y1cERk?=
 =?utf-8?B?emd5bFd2ZlRGbU14YUVLRER0cVAwQmM0NXlRNzlENHEvcllPM1BVaXZWWDVn?=
 =?utf-8?B?eWFIZ0cvL0srVUZaeEt2ZUE5S2NlNW1WanQ1dFdnZFdsRU9CN1VTTGx4N1RN?=
 =?utf-8?B?VHY4ZlhGZllvQWdyczYwbTJ1QmJJUzBwcFNPNk1WcTdJYW9aOWlSUjhZSTBJ?=
 =?utf-8?B?Umw3MDRHeTdHZm5SOEgwSlI0RHF6WUpaT0JDRGxPbklaUDV2TUVwcUFyS3dK?=
 =?utf-8?B?bnFEVXUzSnNzSGh6bkxNa0xqZDEwN1o4L1llUkVGUFJ3ZndmUmF6dnZodWth?=
 =?utf-8?B?dGJrMG1HdS96UHJ3YUIzU2xxczFhdkhteVliOEtvTVdNbkZCR0gvb09IKzdK?=
 =?utf-8?B?a0FKUU9SWmRXa2ltbWdyUEdsOG5BL3FTMGlLZkVrVGJBSXpQZ1hHRStyM2wx?=
 =?utf-8?B?Y3NWRkkyOVo0YWtraVZGVFlXQkpNNGFMY3RDL08zMktQTDZWQ2pZQ292VEtN?=
 =?utf-8?B?Z1Y5S0pseVpBejA0Y1B3UWE1YXhwYzdvcXRzTWFrd2tUdHlDL0J5a1NtU0JR?=
 =?utf-8?B?b0lHS2RRSnRTaEhTSmtnNFo1dHRCSG11c3dkQ2paL3FwekpvaG10NXpCYmxy?=
 =?utf-8?B?dERSTVBGa0dnZWJBNFpoZFBEZEZvc3JxQjRIS0hWVERXbG1RclcyTkVNdTRt?=
 =?utf-8?B?MTMwMmVyZXU3Z1V5TEVMVytvd3ZmZHczRkthK1diWm9adldhbXI4MCtMYkFD?=
 =?utf-8?B?ZjkyVVJMNWIyWURoSjI0NElPWVhVdjBQQURBR09WSFBJR2dSY05mVzBzZ1g1?=
 =?utf-8?B?MWdDUGJZZit6czlRYVFGM29QaEhkTzgyUHYxd3ZDdkZjS3ZtS3ZOYVRDeDZk?=
 =?utf-8?B?c3F4SGFvVGNCRFBtWnVxYkFPcUpCS1ZZWXBTT1diazZUR2VZMEdoNEFOYU1L?=
 =?utf-8?B?R2kxaWdTRHp3YW1QVkpFanoxVFdFRWV0azFSRWdkb1R1SXg2aDNOL1BNakQz?=
 =?utf-8?B?YWQ0eWZ5Tzh2Umd6R1RtUmE5VFVETjhaaVpmeENyZXBhejJCK0N5K3Rlckor?=
 =?utf-8?B?WllwWllEalVNc2xwelVNNnhMTUdoNUcrVEJka1MvaCtsL1lpazNmUzJGVG5p?=
 =?utf-8?B?SEZKMENZb0ZadnpxK1pkRTlyVDJ0KzQycnVlRzRPd0VPdkM3Q2pZWVpSTnJ0?=
 =?utf-8?B?V0hDQmNvQXlpK3VxdEJwbXZVa29wWVVlMkJOL3ZBTDI1dWlSeVJrNEhOQUIy?=
 =?utf-8?B?SytCazVRc2VieGtWSUs1a1gxTUlma1lnc2VIYlhlOERyRWxaSlpXM212VE1H?=
 =?utf-8?B?dEdBcTFQYlpNclpYZTNONmwzZUpuWk5vUnE3UjBBemVsOElXR2diZXEvR211?=
 =?utf-8?B?YjhzYlBhd1hhaFRGODJOeDFKaUhHZUlyMGdGKzVoVndUdXVndE1RbDZ6dFZu?=
 =?utf-8?B?T0JuWlBHNXp6L0ZmUEdTUUpsVmxEV092blB5dnh6T3pyNkJwYU5iUFdVd3NM?=
 =?utf-8?B?QitZbkg5Vm81VlM3YXZxL1JQU2lPYXJpOWIrYjU3NkJvaUV5U01sVVNuUlFD?=
 =?utf-8?B?bWVXWkRaZWIzVXBsQjJIVTk3ajVLRlBjWGovNjYwR2U0UGNFNEZGSXIwcEUy?=
 =?utf-8?B?WWkxU1cxaWtwQzNPTTE0QmRrN2R3T3pTdEx6cW5uL0tuME10QUJPZlVVWlZF?=
 =?utf-8?B?QUtGOEhpam1mNVAwcXlnYUlVUUZkdG9KZndwNlI2V0RDOE9vZTk3ZmVTMnFW?=
 =?utf-8?B?Ym1ISUdYTkZxdkRFZTBmQ3ZOUVlzYktPMTc4MCtxUWRUT0pNdUdlam02TkJ6?=
 =?utf-8?B?UWxaR2gvbFNxdGszdnlhQ0pQUk1FNUxzNHd2SUIvQnByVHJjKyswWkZVM1Vy?=
 =?utf-8?B?ZXU0QWRFeDFpOEZySnpiTlVtV2pTcXcyT1NtSDc2STFmd3NOUkJrZTdLL0pQ?=
 =?utf-8?B?L0U5VTJ0UGhhclp4T1hWWXhISFA1WW1XTThBTmUvUy9vRXFhZ2lEc1doWmtv?=
 =?utf-8?B?dWZLbFpPN1VpUHdXMVlkOXkwcVl4ZTFGWVI1cmRWRExzUDZqRXFFV1RGU3hn?=
 =?utf-8?B?UytCSVFZcHRpRHlRS0hWd2FoekZBU05mWW9Dc1ZnYjhzc3Z4QUFtZmpPWW1Y?=
 =?utf-8?B?WDBMKzRYdDY0NVNPdzAxS3ZrZDFsNnF6Wm5HY3JDRm1UREI0K1FHYksyeFV6?=
 =?utf-8?B?NGtuZUtncUJ5ODRhSUdJcjFacnJDNjA1dmVxdGVFWEJCTUIzNWZQc1J4QVo3?=
 =?utf-8?B?VjBYZXlBNitXYUhPTFR3OUQ0RGJoajhSdGlnVFh1S1E3dG1jNE51ejFUbGxw?=
 =?utf-8?Q?uFgIovzrU2WkYKntkgSSLcI/NXRN62sBWPgW8Td0rLczP?=
X-MS-Exchange-AntiSpam-MessageData-1: 8fiVadMNa3Vwag==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 273da72c-f516-49c9-9a16-08df22bee207
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 08:58:54.2334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QqEvzRXK0u4hdafJb+QSaQgx7VNfuJV62lje+UI0aIXh2ibE29ql+3G5R/PWrEhUOspxo+7jHPkVC8Wdi06z8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7741
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

