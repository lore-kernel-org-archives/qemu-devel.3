Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71700C79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 18:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Min-0008JQ-6x; Wed, 09 Sep 2026 14:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x4Mil-0008J4-MZ; Wed, 09 Sep 2026 14:08:31 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1x4Mih-00078Q-0M; Wed, 09 Sep 2026 14:08:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YITOfFLdlSikLdTbKEM4MFUSkA4eOKTOwVXpO73ZUCj7XVLYv7CYO9lfF8bRlp6eaCVZFxC0i5pyjw7+Wl57vwK/tH3IFhZvXWcghrRgBjV3e7eGlTrwtAVTdaTi+/F5+RqxuYQPC/RGipLRhFYImRGlfKzmR2iabypLyrfRx0TWs0PWKNO01NJcbCA0eslBBYOhKukr3XEhOXsvLmF4MklO10X55PopTM+I7gB2BH/YZpreRorP8h8gmG/jW7RLna54qSMkmUBzbPsWdTX0aina3D4vkcVyZYLx0aJPCjWngMGyPKqiKwO62uwT80uE8mTyFfL/U+/z2ZlngTFtUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLsWWGZyIoLLTr+Ty7n1iYHbafYXcm1wqh01AdxldvU=;
 b=QNUU7/JLAJtcwApTTamhOmiW+5jcs7BleJOwIL+WIBp9WugbXONzAh2qRovcpiB71f8mmXdb2DwYzfFQ+U7765u/4oxgF+gIY0n9sC8OtTf5/yOueFJma3NdhM1vDNdVKFNlq5FkMXYD8h+xsziog6YWQZ7xP+BIUXB6pdf3KN7Hc8fVsrZUThv1Z0osrCWe2vzQ3ZA8c2G+UkeOP6HH9T0pGfBNH7r+NG/xslzdZlXutDECJRyftt/+z4AWOdmb6BescgLnOYgqB0y1cVVpbJvkAWBoN89mIzY/zlCI/4qE9G8rQgFkTZVq0uPHdYIOUrmBAGdvZq61mwHIiFXxeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLsWWGZyIoLLTr+Ty7n1iYHbafYXcm1wqh01AdxldvU=;
 b=sY6J46KiprwwoA+sqoq6alPcODJLhRuzs9XHPZNM6b4J/j0I7HpoSOwBXvfghVLc8mzs5wnp9BcxUps0/wpx2VC3kQS8zDoEchoW9rkSX5Ri6j1MbEq/pOu6qD5YYb2ZFvGmbqcFl343JstIfg08R3ERthmFLPlvKGM6l5RtNYoU+iC/LO4dBXDe8aP4oelzxyS5s85YfyaiXBAYlbo96OTtwtI076UT6/a4WlulrIBGVNuDudlmjZv4ukTxd4Nnjgo6sg2dg0Y3Y/qJdyQTJiu7IG/PeiApRKUJ+8dIwwTbpp/mdyLOQRJzG17jnE1NaAC1C2OOl+4ourAkrDl7PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by DBBPR08MB5899.eurprd08.prod.outlook.com (2603:10a6:10:208::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 18:08:20 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%6]) with mapi id 15.21.0428.004; Wed, 9 Sep 2026
 18:08:20 +0000
Message-ID: <4951f41f-1ce5-49e6-9d70-411da3fed7ca@virtuozzo.com>
Date: Wed, 9 Sep 2026 20:08:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] block, scsi-disk: honour a size change on child
 replacement
From: "Denis V. Lunev" <den@virtuozzo.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
References: <20260812121500.1034178-1-den@openvz.org>
 <65792421-83d6-45fc-afa3-fc332d54707a@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <65792421-83d6-45fc-afa3-fc332d54707a@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P190CA0033.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::46) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|DBBPR08MB5899:EE_
X-MS-Office365-Filtering-Correlation-Id: 697eb6bc-6761-491f-083a-08df0e9d546b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|1800799024|376014|366016|18002099003|22082099003|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: IT02YoaH2/VtunLfFawEmeKmCNVJhhWku4mQroPwPX3mEFCJlr5dh345JCmNcZ1Add2DbpuEs77isB8EMyGcb99J0FpNunYYHQfLbDf0MS/BQzomXmupX7V47NfsDSJ6A32U6v9eqW2CyWDp0S8bYVJVPqyJAynX/aF1eYqTtfpQoOVGMqoCcUag4ShOgberKQBkueteoK/hQsuiROP4dwuZvlNSgarUNkUQSm8vPCWifXT21E5RnE4EXZ6lzQa0rqyvHRFC3+YgMLxGy7AZgV5OT4aqX97VeZYZ0dOwSpzswQZeyxA8hWNLi0/xcpYz/2c0i1KF5vggUd02hZM7DXli3fDe88DGw5TbysZjsZNWVykzgiMZGSKabTzZy14tBlr+v6uVUjBwYT0wSH10bfx+leV6FiVcQTLh5MwxkHTUT9NYH180XjygAswDK23iLcOvmvQnuirdo+NeLcR1813ZVmxdduDabMNGZxGHHRQY9b4dddCpLdNCek4kNlp6xIvcQUaGOJ7g9oxHfFJJJnETY7ZM1ez3zJtjgbBOA2xSXbbf6JIKoHkGCWAjTXKa7EtykYL29R/nWSfMX+6dCSO51hjonqmVqH2zkq4ndvOa8rltMLt1NjAUr+R32FjtOV60vHKLb1mFO4fwV8NKqiHKg6R6X8U3+U4zJ0GxdVM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(10067099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3lpM3lva1lUbW5SUFg4TVBabFFWTlBFWVZlR1l4UXc3M0R4N2JIYkp6NkVw?=
 =?utf-8?B?Vkk4STZIeXdsazBPcjVaYU1RenBZZUxBZ09NRUcxbSsvVUQ1ZlBlS1NTTk1h?=
 =?utf-8?B?b1BXQ2JjUEZhR3p6S2V1NU5INGVlRi84djV6cnB1eFZqZVdKWTNHQzdVM0dr?=
 =?utf-8?B?QnZKWnAwQnlIMEdTV1VMa2ZaNVBZMndDNUUweVlUdGJWT0N6M2pxblJSNU9n?=
 =?utf-8?B?QnA4SHFFYWJHMTlNcGdENkZTQUdwTSt6VjQrRzg2ekZROVBFN2h2c09VYStI?=
 =?utf-8?B?RlpBS0puRDNkMnZXVmJjckVZY2l2eDZaUmRxZ2N1ZVRPWDZhZTV0dXZ3dThn?=
 =?utf-8?B?Y29JTy9ZQWE3MHNyeXN2bTNOelJWQUl5ZkpDdnBDZDNtd1BqRlhnK0hDVkx1?=
 =?utf-8?B?MldpdDRBcjd5TURTWUREb0xNQkQrOHpxVXl0YnEwVThwemNOVFVxZWNGcE5Z?=
 =?utf-8?B?OVJZbUNIKzNDUkptRENsN2RoN2ZEd2hVeTlMb1VUT1hBejVEZDhzQUFlU3ow?=
 =?utf-8?B?TUxFdXJwTkltVmZ2OVo1ZGo5cGZDL2pHU2RvUzBDNTVNOHhzMGtPNzR0Q200?=
 =?utf-8?B?eVdyQitCbHVJcTVvbVp6bzVYS1RtdjVVVndDKzVocUFYUUJyVGU0UzlOYW1D?=
 =?utf-8?B?dTFHbGNYRVZLWDlWM3FOdkg2NEtETjFick5Fdm9XOXNvWWI3THVwc1ErNXJv?=
 =?utf-8?B?RnFJaVYxU05PMFBYVXE1WVJRRG9PdC9DZUdaT0N2SWFjdFBjOVFwd1hDTm8w?=
 =?utf-8?B?Vis2aWx3RFBLTElha2JXQnl0aGMzS3EwK1c5QTJMd01Gc3FXdnkzejVaeTFX?=
 =?utf-8?B?bXpkM0hHR3pNeG5TV1FNNFNSYTR4SU9UZHhJNjZ0dWdiVzc2UXg1bFhiOUEv?=
 =?utf-8?B?bmJCK2J5MDF4YXljbURRYjRKNlhWU0FNUC9acGh2bEx4aWwxdG41SjJTSEdp?=
 =?utf-8?B?em5iVXFlZjFod3RIOWhTdUlZVmFiWWZaM3BsL3AzNmc4c1NlcFhPSTFkWmFS?=
 =?utf-8?B?K0VNOWM1WVkvN3lsZ0xsV1RYNUNBTE5jMGVFT0FyYjhuN1BGVmV2N3l3dXMz?=
 =?utf-8?B?NkRMRXAvRFRkcUZPTzN3NldpMkFwTnEzRG85a3dTOENqUGpDNXdlK2lMbmRh?=
 =?utf-8?B?RlBVeGM2ZHVGa3ZVZzFGUW9BaFNoWktaQURrS3IzNzNLeFZObGVDVmxmTW9L?=
 =?utf-8?B?NU1qb1lmOWhXWjh4MERVMDhkL2YvMlVkR0tSYll0UlovYkpTNmFqc0tDM2FH?=
 =?utf-8?B?Y3VyM2Y1S2tXa2lHeWswejBXdTAzbldwM0RuTHVYWGUwMHQ3eENlOFczc3J2?=
 =?utf-8?B?UXZrWEwvcmpVdldWY1RsajQ1K2s5VDRkejdFZDlFRnl4OW5KdTNTTC9UMzJZ?=
 =?utf-8?B?K3BpR01rb0w2TGxHOVJTMHZzVmlNMFZvaXJ3aFhwNU1pekhoaU54UlFweEhw?=
 =?utf-8?B?NFZSZno1N3lLVUFHUVUwT0EwdjI1aG1MaGdEeGNFSzhwaytxVE14dHRkSzV2?=
 =?utf-8?B?MTZndTlLY21tajlUN2k0MUdmeTUyd0lCUEhBRWdaUDhjVnc2dzJmWDJ4MmJE?=
 =?utf-8?B?ZjZneWFaSDN6VVorY2VVQiswQUJLTHNDbjRNWG0vMVhqeFB5ZVZuWC9VNTVp?=
 =?utf-8?B?Q1h2WFhlK2pHK1NCNk1LZ09uTWtHai9hOHdTazlkQjZuNHJWWHJuSllCcFFj?=
 =?utf-8?B?aWFmbjk3WmEvR3JtcEl0R29DWisvRlRuYjZlNWpyekN5S3E5SmhEUXBSYnN4?=
 =?utf-8?B?TUdOYk9BWUFRamFhY2k4VkVZOHRWYmo5TXFBeEFnUVNodnB1Ky9mYzJHaTBV?=
 =?utf-8?B?Zng4ak91bENlVEZ6NFNSOW9rUXRtQjhjM25sb1ZVMGZMOHdIbENJYVd3STFv?=
 =?utf-8?B?VXRCMlI1WE1CQU1qVUdGanZKRmRXM3BxdkFJVWQ2SE9UbXVHaTJvcVI5cXd6?=
 =?utf-8?B?aXJ6UjRDUFBRUDljbWdMWm5SVG5VUkRMZ2pici9rWDhTTTFUREVBOGtWWnRN?=
 =?utf-8?B?SHlmbjhGL2V5WXhyTmJLRlhGK29ZTnZUbERPWEphV2JVVWo0L2hRZ1pzTnlD?=
 =?utf-8?B?N1hFZXZJTW5pWHZiS25NVG1CeUhRcTh2N2NwSWM0K2RJSk1jQWpqQ2ZVTnFF?=
 =?utf-8?B?a0ttN0pOTW1lZlJoclM2ZlRDdkFYUVRqd2JzZkFRbTZ2WEFJb05YMzdKM0dh?=
 =?utf-8?B?NGZBNnhoZWpCUEVEeHRlZlF1aUc2VC82VVRqZlI0cUcyc2lnekdGSUd3bEdn?=
 =?utf-8?B?emFJZXY5a0MxdVlzU0ZYc3hvbUJMdHVuM0tmUWRnMEFBazdod1AreWQ5YVRi?=
 =?utf-8?B?end5OE1jb2Y1YWR6UlU4S2Z6NzFFTTdqRHA0d0lLR0sycDNqQ1AyMTQwaUgw?=
 =?utf-8?Q?QqBdy7MUa94j3KoScO3HNjPkMBepPrWQwFGhOw8XaHkfR?=
X-MS-Exchange-AntiSpam-MessageData-1: N5s5bDhe5UjJLw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 697eb6bc-6761-491f-083a-08df0e9d546b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 18:08:20.0093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1aEfn+e9fijPPdpTRYKsGO9WyeBQN+N67wYhjm+x4OkT5hDJHV5fzEwRGWVj3vOXTwWTf0IN4KxLlRN+WLiUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5899
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=den@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

On 9/2/26 17:39, Denis V. Lunev wrote:
> On 8/12/26 14:14, Denis V. Lunev wrote:
>> This email originated from an IP that might not be authorized by the domain it was sent from.
>> Do not click links or open attachments unless it is an email you expected to receive.
>> qom-set of the 'drive' property is allowed on a realized device and ends
>> up in bdrv_replace_child_bs(), which swaps the node a BdrvChild points to
>> without telling the parent anything about it. Every other way the size of
>> a node changes goes through bdrv_co_truncate(), which does notify, so a
>> device model caching the size of its child has no way to learn that it
>> changed.
>>
>> scsi-disk is the one really hurt by this. check_lba_range() validates
>> every guest request against SCSIDevice.max_lba, filled in by
>> scsi_disk_reset() and updated only by the READ CAPACITY(10) and (16)
>> handlers. Point a scsi-hd at a larger node and every request past the end
>> of the old one is refused with ILLEGAL REQUEST / LOGICAL BLOCK ADDRESS
>> OUT OF RANGE for the whole life of the device, which Linux turns into
>> EREMOTEIO for reads as well as writes. It is silent on the host:
>> out-of-range requests are answered by scsi_check_condition() and never
>> reach scsi_handle_rw_error(), so there is no BLOCK_IO_ERROR event and
>> io-status stays 'ok'. virtio-blk and ide call blk_get_geometry() for
>> every request, so they end up with a stale idea of the size but never
>> refuse I/O the node underneath can serve.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> Cc: Kevin Wolf <kwolf@redhat.com>
>> Cc: Hanna Reitz <hreitz@redhat.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Fam Zheng <fam@euphon.net>
>>
>> Denis V. Lunev (4):
>>   block: notify the parent when a replaced child has a different size
>>   scsi-disk: refresh the cached capacity from the resize callback
>>   tests/qtest/virtio-scsi: cover a replacement that changes the size
>>   tests/qemu-iotests/qom-set-drive: replace with a differently sized
>>     node
>>
>>  block.c                                    | 13 +++++
>>  hw/scsi/scsi-disk.c                        | 16 ++++--
>>  include/block/block_int-io.h               |  3 ++
>>  tests/qemu-iotests/tests/qom-set-drive     | 14 +++--
>>  tests/qemu-iotests/tests/qom-set-drive.out |  2 +
>>  tests/qtest/virtio-scsi-test.c             | 63 ++++++++++++++++++++++
>>  6 files changed, 104 insertions(+), 7 deletions(-)
>>
>>
>> base-commit: 3e3ccab106f879b1512f8e0d51a827dd4de30e22
> Kevin, Hanna,
>
> have you had a chance to take a look?
> I think block tree is correct one to go through.
>
> Thank you in advance,
>     Den
ping

