Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0B3CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 08:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDeXc-00012H-78; Mon, 05 Oct 2026 04:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xDeXX-0000nc-Bi; Mon, 05 Oct 2026 04:59:19 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xDeXT-0002Xt-Vq; Mon, 05 Oct 2026 04:59:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLO2GLrRYmfjzhiDek839GrFhdxT2lmP2uORGNKK/uopf8n61t5PZa243BHkQY/6wTWGMDy2ocjAoJX1I9FJsLKy9GE65P0eb7ggRBu0edTJNmrfkDWtCaBVbWZzsluX1Xo139dnzy+sAYkatK6vNyQDHa3YpMAycmylsoze9ZBt6fLY0CR6V1JMI4Y2K2tIGbm3qguRmrysqP2rq0tkELYLLxlDXg3ViTvZEZWIzLZtw4885kL1pC+TsjTyB9ZcwPd39EZfOa5WARYyBAuMIl+SMBpwvZw4CdvVTSC2/PPTZLsEdcbN1wtxvFwZ86mnOm4saE5JId8VqS4vXr6ziw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LXRZQN6oTVhvSpCv758I2ADabkL0G0/wLcJI8q5Wtg=;
 b=vo3Z2Qz0MnNUBfOxFQk7s+RCRmvoOoa0wWvapi91mEdWRW1ADoeGH6jqwB9VHOSd+fJNOcDC/JUyqWhyT/bxReVaoYSl9MH1Zv4jF4psw1lZH+9gkDpLmxPXcd48vK9hZtZ5zJ1I9SkcJV7buITJErGZgV3K+01oH2pS6B0/9rO2NTE7hQdiuqjsPPJXOcX30Qy+0igA2UbNQbD3zw6DHqKGaKAOEz+FoHNmm+nS4ycEUNddHY85zhfMrpwDM4P2pGmesCjDR4Kp3hMLi8sVcexKqm+KUdCjv/WE0NtuLqXaY5kknneGGwA1eOOEX6E5KOQ3JskU9NiPxwe0IyObJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LXRZQN6oTVhvSpCv758I2ADabkL0G0/wLcJI8q5Wtg=;
 b=IvWFOq7/j9V19FYA9jR7KXfzTTdhC+ettxGXO7LAq+yzRrWpwR9Z5N4HyVPuYvjmvxVteWgB1IfMdHpi5+WmnENNHCB9I7arRzOp7K7pVXrASpYJD72DiZJAMfmiI3yKLYGfbN31d9wNHPwXIDqZjBWdf0qKXECozQwJbh+HW4+CVxXelJGFgXn6zXMLGxcn5352FubPYaRzmoFrTRnm6uEtCfvD0JxLLXv1NumI+JWwnubHPdgr+S+CcerYhCBQD+H/Yt/JO6CpSzmjLp3J48xtHEEtk5uUqRoKSvW4jfRYndyyy7s7HVMin0SXDyARy+SXzXNKjaXl9l8ROQXeXg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AS8PR08MB7741.eurprd08.prod.outlook.com (2603:10a6:20b:525::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 5 Oct
 2026 08:59:12 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 08:59:12 +0000
Message-ID: <127bf797-defd-46bf-9aa2-063f15152cfc@virtuozzo.com>
Date: Mon, 5 Oct 2026 10:59:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] block: cheaper zero handling in backup and commit
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
References: <20260929155125.3151111-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260929155125.3151111-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0128.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::26) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AS8PR08MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 630ed8f3-1269-4851-5411-08df22beed0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|23010399003|56012099006|10067099003|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: p9H1nVFl/6xTfDAkat+eZiSLtbe2bRV6aNC/Ehij5J27S4o7RhezexUIBIc6oakUh4n6/Ee/VtXhiMRKjWgnjKDH4pFi/I5qZ00bkIuyvPzLggEp/luNaFJ36kgFG0gX7v3U/ZsW0T0YgHYOlsiD10dkRUpO9eS3sL26kz1rknpyRINr9ettE0O4/jSdOfXnDAtpnf6CvmGP9LS3B7ZMWsb0K7yww/YgzP6Wj9BDSdMLgEx3OUqfuBz5xNDCfHrSYug6rgI3cukKN+uRAplBsfcS6fn8/XzZJTg4ype4SL12+1Gn+gbSQiVEYG3VVODIwGhjQb1NP2ZXuuWUdPXs3bbKGIQTAX6HHnri93bYlyvI1j3INIkc3XCdv8agzaX/B0u86KporWIBf1zaUGUiGQFVDt0YO9jjXALiHO0Gxrp8Gncb8phriygbvXPlWzQQt3HwhTrbIc6SQ2Fh6+50kdovOJjbBYO+7tk9zJTEkhXlKJOGbfuQSi8YvGGWVUmcPvyEqebHyhyi0a908CV04t414b6ZqXojYb5s9vl8+cuHIJSC6rz4QlQikX4XTe6pa1Hbx/0tMALJDl8NZJPW32Cw12461fKXesAZdZ08NvdB1WqJBga9/i0P4fGJwa28vigmRPtR6iH7cKcQP4zdXhY3YOmP0a814RzBRKUj0yM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWhYbE1DNG5RWG9JMUhJbFBxaURzK3U3ZWxscW1NL0tvM01rbTB3am80TzZR?=
 =?utf-8?B?UURWZXpHMFBsSGJrWE00NkVidnBFODJ3K3gxOXZxRUZ5UW16UFRVU0pIZW9Q?=
 =?utf-8?B?c0dkLys0YnN4T3FucDFVazhTZHJHS3VIV3lHQUVFam4yYVpRN0ZOSStWRC9I?=
 =?utf-8?B?d01mREpjVzNoaDZNRTFkbkczaEhmN29vaFpIbUxHVndMeDNRb2Fwc1g4THJO?=
 =?utf-8?B?VXJFNDRqZEtFZm45Rk15dDBoL1Nzd1FwbGxpbmdYdDlIVFNXZm4yaml2ZXNV?=
 =?utf-8?B?Z3ZhQXU1RllLejRIdEVHbXE5OXE3Z014U0o5SENLY2tUK25PYk1iNllJUmZV?=
 =?utf-8?B?aEwrbHVyeUh0MC91SHdhQmEwUDhCbTFCMERQczFqTDgyeHpmd2tmM3NFbW1I?=
 =?utf-8?B?d2VIak9PRXZxTzBOdi8wY0VIbUYyY2xNTjMyMXprMS96VThWL04yQkV2VWwy?=
 =?utf-8?B?Q3o2dURPUm1TVVdUNGFUZjYyeVdiNXBhMlBJcEZnZVY1VXFZMDFuSDBrMXds?=
 =?utf-8?B?V0FKajFacnFBUzd2L1dhR0RrNURWbTNUKzRUSkdZUlE2dDhHRkptbXE4Qmxj?=
 =?utf-8?B?TE1sa1J2SThRWGFKZmVocjdxZUswQkZyRlRwS2NQd2pqWExoWStVeVl0OGh3?=
 =?utf-8?B?dXIveFdyM21MSmxkK3N4UExXekU4enR2dmJzV3FNZXU2VGFTMkxrbFRtUkJt?=
 =?utf-8?B?YXVTUFl3MXhIU2toaWJTY3E4MzN0aFMrejJVbkM0MUZ6dyt1QU9tQTN5RVpE?=
 =?utf-8?B?Z2EvVEdoeElkYUc2VWpzU3VvOVBFMHp5VG1GVVAxM2xGaXFZZkZ2VUJWNmJX?=
 =?utf-8?B?MmNWSzR4NGRNekRzcFlKQ0t1QWh3dkx5Q243ZE1jcGpubjdlY0JsaFcyMGht?=
 =?utf-8?B?b1RWT1FpR2pIM1ZBaXY4THVLbXRuU0NCVUtsSkdLRUhORUpaTG9tamlGcVF6?=
 =?utf-8?B?dmhEUnJ3VTR5ZWJOd3NJQ0ZnREVoaVduUTIwMTB6MXlXRGRaTzZmaCtrd1Mx?=
 =?utf-8?B?eDhaQUpZYkVEUlR4M1VscWtpc1hvVlFQMTEvdzQ4SWxwL2g5VEZReVlLUnNP?=
 =?utf-8?B?U3F3Um81dEpTb2N3d2NTbGxENDFoVlRMeFdjY0c5cHI2WDluTE4wK1c3QnNL?=
 =?utf-8?B?eDBibTBDUk9xSEhhcFVmSXBpNWJibTF1QTFFVjh1ZEo3cXE3R2ZneUFUQ1Vo?=
 =?utf-8?B?TjZIazVwRzZzWkV0T0ViMEtQUkpFK2o0UktSbHh4Q1RlSERDS3V2Q29Da2cw?=
 =?utf-8?B?QnRuOWV0SlZBWE1DWTJjc0RGQmNtMlVrKzhQUHBtSWUySmE1V053ekprNjh1?=
 =?utf-8?B?TG50YS9kRDE3cmp4SHVoMFU5b1dMZHU2T0VLSG90cXE4SE02SHNUNHovMzNP?=
 =?utf-8?B?RjFId0NiRDIvOWtPMFhMWUxnTm43RmhobUkwdTJnWFo2R1p1NHJCd1duZHdD?=
 =?utf-8?B?NEZsRGExQlpuQmNBMGVSSnJrU0pJcitoMHY4WDVsSjFub3VPMTJUaGNBU1Vl?=
 =?utf-8?B?cVRDY1g3cHBJZXhiUnRVWExOaTNmRDArZE54MXM2VDhIVnBWTUpibUZBV2lh?=
 =?utf-8?B?YWM5RlNOYlgyTjlKdjBZdkl4L1FIR1hOTlJBdzUvR0FmanR3UGxra2x3ak5U?=
 =?utf-8?B?YWFRNm1keUVLdEtIMjdJVVJyME5NQXBKckl6SEx3ZHpGVE1lYitrMGdBQ09t?=
 =?utf-8?B?MU9FOUJjTVRnamhvcHZXejNZZCtRNyt6QzZSbVpYcmI1SGk2NjdSQ1gvcmM5?=
 =?utf-8?B?RUZCZmdvVHRhWURodWhJNTh6d1JVVC90aHo0Y1Faam5CKzZ5T1NCY1pVYU9v?=
 =?utf-8?B?b012VGJzdUNaa0ZNQnQwWUtFNDVjTUkvc0RBYWE1aCt6ZG0vNkJwV1FDUWNF?=
 =?utf-8?B?TnV5b2QxakxjNDR1Sm5IT1lzUTQ1UitjUm9ESFJzenI3VWF4NjNWMTZ1Umt5?=
 =?utf-8?B?OU1LWEs1VSt4a3BsdnMwa0pIUW5VcnhJTFF5cGo4cXR0bk5VdXFHL3YwbmVp?=
 =?utf-8?B?b0hrTzc4R3dZS3Fzc0JFSXYzMTc2ZVhweHVrTGVxemdNbExWYVc1R1RhUnhy?=
 =?utf-8?B?T25tMXgzMUFQVzkxSEtXcjcrVWN1ekVuMXZscm9DK2ZHM21vRmR4QXhyV202?=
 =?utf-8?B?dUF6WW5QNEJ6anlBRCtVVTBDZWE3VkVoNzJSWWpUQzQ5dVpEOUpMdEpwWFE1?=
 =?utf-8?B?UkRHemZZaW82eDliaE9PazVRVnJ3QVIyYWpCTXRUWm1sRFRzaWRsR281OGxo?=
 =?utf-8?B?L2NxalNBSjdNdy9YYjZXaDFrazc4MlZUNDdLL1FwbE9NMmpsZXZtSTg4dmdq?=
 =?utf-8?B?TDRhaTFoNDkxZWc3WVRnL3k5ZFhFSUVxdzFuZ0Z4cmJPOW9TeFFZZk1ZM2cz?=
 =?utf-8?Q?dVx05swNpt3eGJgUqIB1TYrbe484j0LGjPhnAPl69CTtG?=
X-MS-Exchange-AntiSpam-MessageData-1: GK8eBiiwApJ/rA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630ed8f3-1269-4851-5411-08df22beed0b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 08:59:12.8637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gyuVy9VqcmaZLrdgUrIpfSkLQVRmYMtHv+O5nF4OPORxQZhss9h7CfE9MdExdpBCUxqRJim0/aA1OOhusD8T+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7741
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

On 9/29/26 17:51, Denis V. Lunev wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> Backup and commit re-query the source block status for every task and
> size a task by the copy buffer, so a long run of zeroes turns into a
> crowd of small write-zeroes requests. This series reuses what the
> up-front scan already learned and lets one write-zeroes task cover a
> whole run.
>
> Backup of a 16G qcow2 image holding 1G of data, the rest never
> allocated, sync=full to a raw target on ext4:
>
>                tasks    time
>     before     16384    1.6s
>     after       1088    1.0s
>
> Such an image is the normal case rather than a corner one: a guest with
> discard enabled on a disk which is mostly free leaves exactly this
> shape behind.
>
> v3, all from Andrey's review of v2:
> - 3/9: the commit message says which permission stops whom. A device or
>   an export asks for BLK_PERM_CONSISTENT_READ along with BLK_PERM_WRITE
>   and the job withholds CONSISTENT_READ above base_overlay, having to
>   share WRITE or it would block its own writes to base; a job target
>   asks for WRITE alone and is stopped by the op blocker instead.
> - 4/9: assertNotIn() rather than a bare assert, and test_bitmap_straddle
>   checks the target map, not only the content.
> - 9/9: zero_widen is a bool again. A task widened before another task's
>   request was refused reached the write loop with the chunk still at its
>   full widened size, so it wrote the whole range as one request with no
>   BDRV_REQ_NO_FALLBACK, against a target which had just said it cannot
>   zero by metadata. The chunk is now bounded whichever way the flag was
>   read, and a request carries NO_FALLBACK whenever the target is still
>   believed to oblige.
>   block_copy_chunk_size() is called under s->lock, as its own comment
>   asks for.
>   The commit message no longer says a refused request wrote nothing:
>   bdrv_co_do_pwrite_zeroes() fragments by bl.max_pwrite_zeroes and a
>   driver may refuse a later fragment after an earlier one landed. The
>   range is rewritten whole, which is safe because zeroes over zeroes
>   change nothing.
> - Reviewed-by tags collected on 1-8.
> - rebased on master
>
> v2, all from Andrey's review:
> - 2/9: holes spelled out in both layouts, and zero runs added, so the
>   write-zeroes path of 3/9 is covered too
> - 3/9: COMMIT_ZERO_CHUNK has a comment of its own saying what bounds it;
>   the cache check drops its dead half and asserts instead
> - 4/9: a Case namedtuple pairs each size with its layout, and
>   create_image(), write_layout(), dirty_layout() and backup_and_check()
>   take out the duplication
> - 8/9: g_assert_not_reached() for the sync mode which cannot reach there
> - 9/9: a widened write-zeroes request only pays off where the target
>   zeroes by metadata. supported_zero_flags rules out the targets which
>   cannot, and the first widened request asks for BDRV_REQ_NO_FALLBACK to
>   settle the rest, since a driver may advertise it and only learn better
>   from a failing call. A target which would write the zeroes out fails
>   that request without writing, and the run keeps its requests at the
>   buffer chunk size from there on. With the size question settled that
>   way the cap became BDRV_REQUEST_MAX_BYTES rather than 256M.
> - rebased on master
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: John Snow <jsnow@redhat.com>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>
> Denis V. Lunev (9):
>   block/commit: pass BDRV_WANT_PRECISE to block-status
>   iotests/040: cover large and fragmented commit runs
>   block/commit: batch block-status queries
>   iotests/124: cover backup of zero clusters and holes
>   block/block-copy: don't reserve memory for zero tasks
>   block/block-copy: extract block_copy_set_task_method()
>   block/block-copy: track known-zero source clusters
>   block/backup: pre-fill zero_bitmap for full/bitmap
>   block/block-copy: coalesce write-zeroes tasks
>
>  block/backup.c             |  93 ++++++----
>  block/block-copy.c         | 300 ++++++++++++++++++++++++++++----
>  block/commit.c             |  58 +++++--
>  include/block/block-copy.h |   5 +
>  tests/qemu-iotests/040     | 102 ++++++++++-
>  tests/qemu-iotests/040.out |   4 +-
>  tests/qemu-iotests/124     | 347 ++++++++++++++++++++++++++++++++++++-
>  tests/qemu-iotests/124.out |   4 +-
>  8 files changed, 825 insertions(+), 88 deletions(-)
>
>
> base-commit: f8296b816fabd370307cd22b0270b610fc0fa279
ping

