Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3E6C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 19:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8jrt-0008HM-Dp; Mon, 21 Sep 2026 15:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x8jrp-0008H8-3L; Mon, 21 Sep 2026 15:39:57 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x8jrn-00009n-Bi; Mon, 21 Sep 2026 15:39:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0Ro9GSSxXYMczDyTTdByiR4uFC11cPmPoTOlXqlKKekP0ZFeeQXj1nVdXeLmmVPe04bEdWSUwECDJCbHlHQXdX7ZzNQsweEOYlXJrTqMKf1ssteCKAb49isYXIXbYBqfWlpg9mB2U52FyK19twVXkglB5t1xFh0e0KAyhbi8GyxaIhtPYHLvAiS+mSsVRYHNYhOg1ZIsrN0T5v74H5oRbs6zfUvtoHpmk55II2nCEnRLsdfNKpCqgbTLUwvkQEeFFeFoXsmfGD7XoXHamtQNEonJYnOR/MPhZ5HPWatJetrGZBwzBmvtkGQ/6vx4Pg6xbv436UdT/oc4CRjaayl3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8SH1GKkR3dpoJJdrXSSNryXM0kMfanPG2X5QbD1q3Q=;
 b=CF9jJkU2p4Dz2XDGS45lCLTFUW51yl2UCdKYW/LVZAvdVQhLlX36MyrH1635jy/Yn1D0CjOPzNLdOGHjpj4aMXRrkbL5WyKdKbxJ54ceG4VUpNMpHPdY6usZntHofAUaA9J229Aeg1ZJF+dgOmnPUFxGuZuwo5YwLIRe86zfD5e8i0DYJVvYjr9swzOQyk1yu5TWqBojXTpFJSgL0v6SBmu3Vpuj3Lo3MpXls/hmdf3of7r+JmddVoeP9Bp5xkkWaz80XufjdoRBc9fSnlTh0t3wxoP5BY+9Zx67LazFJtoZfsH85wDg7YbMmzDiBISGwtKZhZPFckb/tfTH1NvfxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8SH1GKkR3dpoJJdrXSSNryXM0kMfanPG2X5QbD1q3Q=;
 b=zXUtKidsnoluyhLtMoavian44dsA9XX77r23x2AEoCbLMAR8oQZE7XQ0T20WlzCYWiM4OMrEJUDBqaH6sl3VxAS+xXz4XxD+Pjlz+1QaqUuC+2CKpyYfAbmyIXB2zjTQOwdGBy76BI10zrvu5BuwGlmZqRC9ZcBZj9Jc1B4sMBFi3i53aUKw0jLzxl5gAA2UZxmQSKuKpEYU98styF0e0zP2aNgVfR1iMz5sdTISVbMgqavKX2wtfQoU4+PJT1ZZIcSLqYPfLzXrESjKYSBzbneZF34e76D37Hs4NgRorjYOcnESo7/ACwNHKW/bIE43PHLX3tDi8yGMV8eVwmW+RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AS1PR08MB7476.eurprd08.prod.outlook.com (2603:10a6:20b:4dc::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Mon, 21 Sep
 2026 19:39:49 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%6]) with mapi id 15.21.0451.012; Mon, 21 Sep 2026
 19:39:49 +0000
Message-ID: <b9c749e7-84fe-4deb-812e-ee41816306bc@virtuozzo.com>
Date: Mon, 21 Sep 2026 21:39:46 +0200
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
X-ClientProxiedBy: VI1PR0102CA0009.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::22) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AS1PR08MB7476:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c3b88e9-b90a-47c4-9a92-08df18181846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|10070799003|366016|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: LXyjUm9GfH2w8QP1yjbnmC+6nOQUHC/U+rUc1MeBX2r+frNuM9IAFjh1fjQTz8O4d3yTPsjT/oGaIRPkRuIuE582sfjIzVs1KmuySI5ZBNfKfXVNtKX4sTzVfP6Xdq5ikfMsgNZQvz4EP67GBs79FoYmDEB6/BdREfZFVohC5HpiAnKStOCCVWdKphRf73wGnAy+tQgHWsPXPGKj1XZkKrALBqWwLTIz3aio6+XAeGyYuoCleYZlYfu+QTOu7gUNRgdux+x5viSXmlMgA71CzcdytF3r3Dj2UlZbgt9vpITNPpGVgtzeJhKbM5on4gyoMzKih5/seEsMNrmVo50r6DAaVcBpa4WLtBnWdFTj2PNtU7XiSfERN3PeAEB7cGMd0MfjalzV93J7sjzFy7N4TFDvOr+lGLOEqCjEGLf4NKvkgnSa5k5Fijouu8/99kR+PudN+lUVy3k2wNn6Atfkmdj3K43Xnr0r83XjOCMR5yKXj9Yqe0UcjywbUifkNgmMkpYWT5zVXwCHvlSRl6m2sjwcPOEwaAPnHd2isBwYL+93LIlenAbhv0LMv0PPBRjZb9iHasVGSJC9Tempo1a5jwLiVa8T6pPeRiKvsjukSxh6yULNBCHDC091ibCukVpkXR03vgymikGoBgYVLfFvqueNOn8ZQZ/AipIUwQBMHgY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(10070799003)(366016)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHlXR290RFhaT0VMbHhWS2gxcjFIYlR2MlB5aHdLV284ZUhobFczOFBPSlhN?=
 =?utf-8?B?bFhvbVYrT1FnaWkxejV4ODBMRTk3M1NZVXRmV2Rqc0dIbGlIUVhtem9GTTNu?=
 =?utf-8?B?b05JU0hwaVZ3ZmtXYWhLek1QMnlYb2dlZjRKV2VxQzU4ZnFjaUMxakdzRUly?=
 =?utf-8?B?dDI5aUNpbHlxamdBRkFxZmhsNFpqMzFBOWU4V2JxUGZGa0VBTFNuM09Ncnl4?=
 =?utf-8?B?NDhmTWJTMzY5cVBINjM4c25CdG5sanV0djNyUXNiVUN0b2JzU21vZlZQcDVs?=
 =?utf-8?B?VUlBS3I5T2NyRUpoaU5Vc2hLS1FFR3VMQ2w5NkRTYzgzU1ljU3pFWDlyQzdE?=
 =?utf-8?B?MDJsb2VzYUwzcEdPMng4MmlLRGNZaUNMbU5uWEorTFN6bUNYZWpMNGdwdUJp?=
 =?utf-8?B?WmR5SEJkdTNPcisrL0Ria3U4cXdpOWFCVjQvaWRGRHlzSmVLYXRHZURzSUQ1?=
 =?utf-8?B?MWJKYVJNWTJieGZxa3JVcTJjWTNPM2VObzZIL01YSkQ0M3ZwRi9iMjRpOFBM?=
 =?utf-8?B?R1dUVTJNeTF6OVFuUWpTcTJSL0FPcEhKVFp5bE5JdUUxVTJCZjBmbnhkZjVl?=
 =?utf-8?B?azZlNUc0OTZycXdnYzFQQVgwdFNuVFR1Y1NhSWI2NldoWmE2QW9XQXBoZkxE?=
 =?utf-8?B?eWtYN2d6NnpGdlFSTEY1b2JTQWlWWGlEZjRDVkYrSjJ5eWd0dmV1TXhCL3Nx?=
 =?utf-8?B?VDFsem1YQ29zdmNyNTVYcFRteFM0YzJUZEtqN3NHTGYyK2ZBd3YrWjZFY2Fu?=
 =?utf-8?B?NkI4ZnlOYWt4a3BNRWRVVm93YVU2UHNpa1Q3Nnc1NnFHeE9wa3Q3dXVBcjdF?=
 =?utf-8?B?MVpGOTlrK2RYNWwwNHUrM2ZGWERGOEhhNlMxRTNGNlJZOGt5N00rM09ac3Va?=
 =?utf-8?B?NWo5YmRQYUxzNHpobkk5bzVaOWlWN09XU1YxYW5lMVRZWmtoeFliT01IaFR5?=
 =?utf-8?B?eVlydmwvSkk1UzlvY0tyUDhkVERYZ3ppWGRPUG1lSXd5VDJwUllsTE8zMUU1?=
 =?utf-8?B?M2k4TWZPbkNYNDY2bUIvaTBNWW1FMVlTcGNMVHdEazJyRTBkaHdsSE5tNlJE?=
 =?utf-8?B?dWc1N1grdXVLdDk4UXF4a04xc1VqMnZ5enZIZzZyQlRLV0NCayt6Tnl3bytw?=
 =?utf-8?B?eDZDbExNZnR6UHRNQVNDOTdBdVpIUFdIOGV2eFdXS0tYcUZSK0dCcHh0RE94?=
 =?utf-8?B?VGdObGJCOU1LNitOVXd4TmV2ZS9IMXdXanZTRWRFTENjWVdBWi91ak9kRHBY?=
 =?utf-8?B?RlRpdDg4dnErVEhnRlE4OWdHNC9EOG0ySERQWjlNaDZOekdma1FUaHVXdVR4?=
 =?utf-8?B?RTgrbExoQUQxSExXcGZlajcrcGpjMEpWT0c4ZWM1YmJScHl6RkpPZ0x1RlBS?=
 =?utf-8?B?V1EyL3dqMWFZWDZab01rVWU5M3FTV3FzamVhL1V4N0tjNU1WaGRlQktPUFRO?=
 =?utf-8?B?VWxmbXZ1YytJa0REQkNzbTBjMElwV3U1UUlkeGlQN1ZRL2pKOXN4WiswTVhZ?=
 =?utf-8?B?cTlxZXc3aGFmL2U2RUNOMlkvM2ZRK0s4TjJLa04vMFg4RzN3RlhZU0RDNi9H?=
 =?utf-8?B?bENVU1VPRGJEVVZvZHJmY1BlbkZJNS9aMjQ1SVIwTHRkRTZmYktNOTk4ekZE?=
 =?utf-8?B?YW1qYjNYVm93VWd1VXhhRjJCOFc2THVOWm9Fc1VITS82c0NVdEx2bUdVbm1s?=
 =?utf-8?B?bVlXSWxPOWt6QkhIRS9tU1hyQVo1MHVRSWwrMjBYdDl0WDlzQ1NnYzRSQVpa?=
 =?utf-8?B?S1FtSXJ2c1RpaU0rQWVLbkE4aS9oQkw0YnN2emJYK1Z4cGJESVhZUW1OTEhT?=
 =?utf-8?B?RzJOZE92d0l4QSt5UjR4b0VHNEdFbGxEUHZIVFRtOGVibjVPeWJtUUtqQjdM?=
 =?utf-8?B?QUdLNGhCN1M3Z0JCMEp1VXIwOFlMSFJ5Z3RBTTFoZks3ajVvejIxWEVIcWVY?=
 =?utf-8?B?Qm9MQ0lua3ZTOEFnTjN0bk4zT3k0cTVrS1RRanZpc0JVaThLSGRaajFrN0gv?=
 =?utf-8?B?NDhtREthRlRKMlVxQXgxLzZIRVMzZHVkOUZ4bVRycSt3ZTl3MkkxTk9HRlNO?=
 =?utf-8?B?VFlFREVwQ05KclMrZVgwRXpKNUNGek1qUUNtdDlJcThsSHpUVTZCTi9xUFFM?=
 =?utf-8?B?alZ0cG5CMmxYY0lKWjgxUktMYlFkc3V0R2RhRVc1UVpOR0VENHk1Q3BGazBM?=
 =?utf-8?B?UzJJeEZDT1RZVFhPQzVoVi8rc2JOTE1rWno1bU1XU3UxVmF3aHJveS9IcUYz?=
 =?utf-8?B?eTAxbm1Fb0w0ZEdoMHJXWldndytYTUdTSDNsaVMyQ3RjRzFFN0QyaXJTKzhu?=
 =?utf-8?B?Sk9MQlFDSG5OdkFtNHdXanRxcStIU3l5QUhteCtFWHkxY3NPQmZCOW1FN2JS?=
 =?utf-8?Q?zpgKN6FJrMiiOVOs7gcosbpYu3NFezYc0dNpde3co3bni?=
X-MS-Exchange-AntiSpam-MessageData-1: g8+QTXBEhQxErw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3b88e9-b90a-47c4-9a92-08df18181846
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 19:39:48.9817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JN3smi+MuyI668vcDrxwgbbNHzkAHd7y9AFtSitPt20lT48Y8uIcZ8WGqbcnSXmNvNZRUVxHSQ4UQvSPPDYe4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7476
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

