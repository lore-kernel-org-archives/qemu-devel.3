Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6373C5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 09:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwcij-0006xD-Fh; Wed, 19 Aug 2026 05:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wwcii-0006v1-3f; Wed, 19 Aug 2026 05:36:28 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wwcig-0003v6-Ep; Wed, 19 Aug 2026 05:36:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4mXbJ8JV7EzcYfVG1VwIeMsuVPJsEZ8qe3M7C+q0pDszWZ3FfdRd08bvLvq8Ljwe9oKzdLAsYKbeml7BGNa8uJ1mputRYKtfYjh9q/55n0r2taQPrJajUfNMC9kUybw+dy8ke4dV/FNrMS37vSvWsB574vTNsmk7Mvz8KtPkEizpPdDGS9a7uuOtR5YuQd5CS/fiz43lMS5bdzgQrAvWMZSg6mtDlWex1hkawD9Argh/JNn2ZwVvoeDwBBnXSAD6NIcD1nO9pc4pKkRNp7Iwd50BtYMWRp3LSolMlXMvqJciFTNSwSuXpdBlOVG4PMNvXQV1IM2VdRdse6Dp7WXRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8SH1GKkR3dpoJJdrXSSNryXM0kMfanPG2X5QbD1q3Q=;
 b=DjzoqN2G7f6uih0xiFPEACpMjbuhJNvyZPhLDG4EMgDsMpwb5/G7jeJR/XD5ekg7CBHmpmdw9aRF8lIvIxMmKlgloI3NkDNL9xeVtHwess/ew+TljABvU8PPCKxGH0DC/za60xUx4fJl6T5LRZA/vSXXwFD4xnwneFQfdwS+cInQe8/d2qTnYLwjyyyiWKzNPxDSY5lGv2L1fIt7CLWXTZVCr6D3pBZK2XDkqXiag5SW/ERFi/0neukXcUJ5QhPYujPj/FtPsnJPl06Tkeq1xOAzF9CgH4M4kFGgh6ttHqUxdkJ3wVzJbbHv6vUmuQHUMYSar63pEb70B7s+9KMBng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8SH1GKkR3dpoJJdrXSSNryXM0kMfanPG2X5QbD1q3Q=;
 b=k0rKFtjG3lKajF3glVVy84ehtWYfkVCwX/KJnAJeorZAmvAirBSmF7lif6mi+zuAjajwmE/E2ccuFjwqMkf+ob9dGckkQLrsgdjmJoETRz0PVfvd8sMzwcoIUo2kFLxTaMd+5daWySbplZrIBzhICFu67SQpJOGBBaYH7xminfhqzrhQ2c+R4BrUs34EmEG8NOQC+T1A7HZd2eWfvtuvFjEQ0B4+vqjfn6sQvR8W+xvikMXfxKiu6XUcZ78Z33/VYG7YeIwVcwyTkdRhKPmipKDM3BKAcYnGP9qZQ9QX7UkTi45j0NI//0FujwYRltq6TgaPUYLqRSTku93tPj/xjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PAVPR08MB8823.eurprd08.prod.outlook.com (2603:10a6:102:2fe::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 09:36:21 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 09:36:21 +0000
Message-ID: <41755ca2-e5b2-4c22-8de7-28a404c39816@virtuozzo.com>
Date: Wed, 19 Aug 2026 11:36:20 +0200
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
X-ClientProxiedBy: VI1P190CA0047.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::13) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PAVPR08MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc4d2b2-487c-4b8d-7b72-08defdd55458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|10070799003|376014|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 5PiYtg8hF+StOX7jUZCwwDYcpKYJsCERqT2gFv6l9Jaf4PiGZNRjLxFhhKXT86Gs8JE0oGp/Y4YT2bqBBovSW/WnYLj7ux54Y1+Y/RY5s0DmKhSk2ZHx0xhLJdM6kiAan08fj8gBy9QnLK0i1TsjZLDQ7S1fNqpWmbu+xvP+9ye9GlLdxvclPvMrna3WiTCo5wpplYGYRgOnGmOkMUXnS1GOhxm4nhOuQX8Y/QA+VxpJ17ah9W7nwQ1xM/ZJ6kggvGbBSPOpc77ujhA1AaAnSfrMMnVjGTJn0rthvl5iSvoGVGzTh81xMXNgmTsde053kU3VuSE3FSfRnZE2xkX3MYau7q5unUAOBbdoG81DGWVnaYbkO+8qyvEFouwoHoFDXbZjSAimNiszuQZFbPuzHZflw+aK4NGaDbeL9ZZM8N6/iXedcdiFGXjvawYVCoE43BhYr9R8NXahbpUh3LgMOEgV1G4u/0oN7z6CC34FjdHyH9GpSij49OGih6NBEsjgch/v+TjqOjbpgeZJsjXCf9OU/BeBHqVb1dwWMoQccLlmCmGWlWbjDK5jvw87b/GeiORzL/IXQDKcQNa6Yeg4hN3Wo8JaisgU/gBZSrXnoa4ERTraPRjl5h8/Rgn4rfR0Tr8lfgvwpK7HKKQRdF6ys+5kF2n4yRy4Ix3HvVwvYi4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(10070799003)(376014)(18002099003)(22082099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXl3UHQrYnQweVZBb3FTb2lNQ0N3U1RvZG83KzFFTC9TempzR1A5THIyYkdH?=
 =?utf-8?B?a0IwSDFPZmNaNkwwTlRSd1NUQlU4cXYwa2pabTJYRnYzL09kTUs3MFM4SDVY?=
 =?utf-8?B?R0RQNWdpRWgwbDQxcWZ2UXlieDdEYlE2V08yZHNCSlBrK0JCT0VmcFk0NHNo?=
 =?utf-8?B?YnEyM2w2SHFTMEkwTnFlOWJsaGVvVkQxK1JKM3M1RnhXNDhiTGdEVlAvajJ2?=
 =?utf-8?B?dmhSUnFsdzQrb3FjZ2l1RUtpZnRHSmlNeDJqamRjZXJSY3NJSlpqYTZvK2lz?=
 =?utf-8?B?MXJvamluWGhXMS9oYTltL0QrY2F0MklmUE9lZGhPZmtKVnFjMjNObnNMUm9x?=
 =?utf-8?B?S21xcEg5T1JDVjF0VXFOK1lmN1U3eXhrQU1qeUIxMEM3Skt5elZzMlZNSTZk?=
 =?utf-8?B?TkVBWktnRm9OSnZNbXAvOEg3ZVRkc1VLVHpReTIvQjNYNlZ1OG9MNFR5YnJt?=
 =?utf-8?B?eFc4RGNoSUU3a0pJUEx2dzd3TWxscENsTG5mdVBsckphbXpEeUpSN1A4N0o3?=
 =?utf-8?B?MDEvaXVzVHgrWElEOUdtRW9lOXlMd2lrNUlBUWtQNmUwZmVoK0grY2JxSldH?=
 =?utf-8?B?eG5mZkl2MEZmRnAvZ0d4bEIzaUExQUNUY0Z0aVFlVkg4VHl2SmJlYmVQSU5v?=
 =?utf-8?B?eHNBNUF0ZXNyQkp1V0RzKzRIeFZDL0VDSXg2M0taaUY4cXpRSGpmdzNyczBJ?=
 =?utf-8?B?WTZwU21UU2ptZW1sbGVyUDdjS0dVMUh5ekZUSE1iWVhpM3BlVlJlRDFrTTkv?=
 =?utf-8?B?K2ZKd1pwNUx5SUMzTGQ2Z01qOFA5VmN1aDFqY0E1b3FRc0Y2ME9kWkU0eDNG?=
 =?utf-8?B?cUYwa2kzUkxsSUMyRnNWVTF0S0hpeEl1RGFycHVzMElzbWVtRzdWV2diS0hB?=
 =?utf-8?B?bUlYTXdZdVR4ekdTWlFEa0V1UEpzQkpuaUFQcDZDNWI1dU1PZ3hmdG13THlD?=
 =?utf-8?B?b1NGRnI2bnNud1Jld1YyZzJtY0xrTWhPbHloS3RCQlM2bkh3M1BzQ2I2aGk5?=
 =?utf-8?B?K05TYUNWdEVHL2VQTm4zSm0zMHcrcWdqcHNVakRDMjVPZTZlTnMyMHowT0RC?=
 =?utf-8?B?VHB1Qk8wNzhHdTBJTmsrRUQ1WnJDbVBySURHbzdwV1F6RlMrU2puWFllbDlQ?=
 =?utf-8?B?d243VTZVck9yKzVYV1NVK1NDblMvaUpBTmo0REVaZHlhb0kzbWdNOXFGbkNP?=
 =?utf-8?B?QkpsSkRxcUlaREo1OXJoOWozVVg1dmRNdTdtMk45RHVxUW5GT3MxemZJTWN2?=
 =?utf-8?B?ODlsdU85ZW1Kb1cyZUxEdDBlNTZPYjVNR21pS0N0T25jdjdEckFUOWRBZSti?=
 =?utf-8?B?TG40b1VKbXJNNWhZcmt3Y3g2RE5xTTVyS2V3amt0S1FsREJVMFI3bnhKNnIx?=
 =?utf-8?B?QTBJaTQzR3lnTVVZeGlzUk9PZzdud1dWVExyczg3MzY5bEpRd0kxbk0vaXYx?=
 =?utf-8?B?N1JxQzdYbHNsWGYvdkZnRjRJK3VaemxTdnl1bzQwQTVTcHZjUWVVQURVaUpo?=
 =?utf-8?B?YUFGUlBVY2NSWEZvcExpR2theFBwV0RPckxWNFhsRG10Z0V0YnFiMTFGMnZM?=
 =?utf-8?B?OUpiZHM0THY4V2dCNjg1ejluZnVlM0VncmRyQUlnYmV6Vm54ZDFDVDVjZit1?=
 =?utf-8?B?Zjh3NFBhZFVGM3BScVpFbFpTYnFWdERJOVM0S21BUitCdWMyeFdlV3N4aUgr?=
 =?utf-8?B?NFd3SUdXbVFZdEpqckMyYy8xY0dMalpJbU1HZmhPaUtnaWRlVlNvRWE0aWxu?=
 =?utf-8?B?eXV2VExvT3BYS3luVE83K0dHSXBZb0pDSVV0Vm1BY09FTVE1NXZpa3YwakQ3?=
 =?utf-8?B?emUxSHB2dEx6aWQ5NUttTlliV2gwSjl4cE9IUkZyWnJKcS9ScXRKTFdCai81?=
 =?utf-8?B?ancyemUwakhxWEdVS0l4TEJBdXhYZEw2b1NzTXVUZ2J1bVJTNC9ObzdOdzFa?=
 =?utf-8?B?TTNOcy84UU5EU0dUK0ViZXN3dnV6SzI5dWJSRk9WZG5jWWdrelZKdk1EUzJp?=
 =?utf-8?B?aGZXV0VIemxVRDc4UEcvYnhPR1RPWjgvYXdnMkthK2UzYW9pRkJkUlZMNkJj?=
 =?utf-8?B?dlRha3dUM2tFalVHblJPRHJudmMvT05rSWNOa0VEajNYalR2SG81Q2R6dmhl?=
 =?utf-8?B?NVFJSzBJcStQb1RwcXhjMDFsK1p5Y2xOT2tjQVhETGp3NktoSUNmNVZLN2Qz?=
 =?utf-8?B?d2lhUURsTmI5K2dUaUFNV3dIMkNXZDJHZ0ZYVng1VzF6WnlDZklmYmxIYWJl?=
 =?utf-8?B?U1ZkRE02byt0Ti9IY3pMR0NzQTR4QWEvZ0RabFRXYlp4RStZbEZTNkxTVW54?=
 =?utf-8?B?YlF1Rlc4eHMzdGdxcG45WHVmNC92VVcwVWtyYTY5RXY2T0hld2ZmcXJVQWMz?=
 =?utf-8?Q?QH0lv3n0Gt0JVaeJCiyLswtxINP/PGeIDh0dq74XCq0nu?=
X-MS-Exchange-AntiSpam-MessageData-1: 7qjfiiCqfOgkDQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc4d2b2-487c-4b8d-7b72-08defdd55458
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 09:36:21.9118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfmnN8lu+607zXPSkei8XJow4JfyQOeiA9AARg6FDSo1LPVidm6CDBQnE0/OWU2KioqIzsDgTn7Ih9epjVeo6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8823
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

