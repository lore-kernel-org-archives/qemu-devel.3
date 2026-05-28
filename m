Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79808CD5BD1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 09:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSWzq-0003hr-Am; Thu, 28 May 2026 05:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1wSWzo-0003ha-8I
 for qemu-devel@nongnu.org; Thu, 28 May 2026 05:25:44 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1wSWzk-0005Yh-5U
 for qemu-devel@nongnu.org; Thu, 28 May 2026 05:25:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rovUGPh7WypD9MUEao6gRNCCTnnaNqasd5xiXp8nwdCPBgUbMW+gMehQYAT4VqPS3mNO/8VT53Tuc+JqZY2pNOB5ujCTjMu3GVeOgIzs2ZSHDIFISroiDRZtPewK7wApsSdqGMKgOBF9Wob2Pi6IJgawaiyff47KzqaaTG3IiB5I4IDEHPsTxDYb2yPNJbWxIGkle8OS4UGbT2Jr/J44ntXMv3cXnXXL6yuHRjj0Vu5j5426zT07BRgqAi5r3HBEZRJjwsk6MiNwENa3YcUljADnBtXaezRRl+Y15jnEyd2ixl0j64t8f4k/fy71Y8gekU1CuqjuyVaZ1eWK72+eQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uW9Dgimx2khWZdv6YA+x0uf2HY0Rm1Nv9ohCpeg90YA=;
 b=akRDTSAXO45Lhnrkzo9t2eoqdPvfj59CRFbt6nuPCrYDgC3Zxl9g9pm/PiywfrFgIgwnuAWTHWUeJnLzm575tXvLx+MOl0bQPB9KnxFqQ7bJNhyygLSnT4qSSW3j7OnMJa5dpvv9fuQP9TbBCulo8JRCRCxHkTPfEf+SSx9j38XTGLv5AgijMj8eWn0b/Ro2HPh75IS6NtV1BLzbWsbrlevXWmub45DWOCR+ZsqOYO7qY0qdU95Ba97sM68/BA/8kHp/mghz7JGysczjjl2gpq8D8LGMAVKVT6BHYJ8+T/jDp17OycSxaB3bHSsHQBdqcYJoYuXTJxdgBJjhiKRzbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uW9Dgimx2khWZdv6YA+x0uf2HY0Rm1Nv9ohCpeg90YA=;
 b=O4WnfRtCCL30BTNkeJ34lyoGg8R/UYgPIHth05pGRtsuTtk/CKOBhQCC9KVzxuR+tXucHYxpVpIRUz7zhg5SPELfXXXhd4W+3hEmnJFiBw+zD9lrC/HnJvHih2mwDTBUCnpTPWDeWXSq5VPpwUkHSfjq1tIubygPMCQ3Ysp6ADwT8Jys3+2x339ANlumxU9Hw5ho/rNz/giPk7NPueh115s5hEm8uXFW+259AS2RkuZ8eTOEsoL0qrmFjj1cbuXQABpv23ujikFJ1obXDUERKMWXsvHAYk8sz8UKz9Qgk81rwyunLNVaqHM8H3F1eAZSO8oa+lP44oIZcEGE2dXyXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AS8PR08MB9719.eurprd08.prod.outlook.com (2603:10a6:20b:615::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 09:25:35 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 09:25:35 +0000
Message-ID: <053500ae-cde5-4322-9582-31f00443ca43@virtuozzo.com>
Date: Thu, 28 May 2026 11:25:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] qemu-img: add sub-command --remove-all to
 'qemu-img bitmap'
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20260520235952.500250-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260520235952.500250-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0011.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::24) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AS8PR08MB9719:EE_
X-MS-Office365-Filtering-Correlation-Id: f6edf086-389a-4ccf-7f49-08debc9b12ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|18002099003|22082099003|6133799003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: jLxSbevqw1RuPr0uvZgB6EbdVP1IKD2JoJqPYhfv5ojzqvw8KgxYltBoe+pzqYOoU8itPLEeUeO5gFZeXjXMtnt8JldE2ZpojaN5IXM9eUSEWj2nyVLBGVmzLqqlt1BLBzTZT7bp2lenR3i2O65gx2if6IsRcT8d0SOe2kWdNq1lPEslA6eJlg8R5HjwVnKM4NC9lebaJt5QoxIvQ11f7a5/LO3TtxsB5YvszYSvF6ALCWoKFOcscu/j6ZrvN4ru1mcHv7w87qTuSOeWum0ByMPWURI9eZQBv+rzJEF+466CjCvqLMUI8zIP2U7LjEeVqd6clnrMko+DAdSihjERQau3UC3XTc65K3RJZrbl0neMQNwq8ryDHSfEypQcXCJa3FEcJDugNuMve8bDuyAc/7yQiT4iHzengV70X8NNZbxNfjSuUbQh/dX8gIIQXmtDadR8Zj9usaCbYL40bY8vnl2UAhxSd+Lna+5UVf+G+RsLZgY1me8zd+L+qexH89FjsuPI9oIQfAkz6kXZcvy+g5hqbMRDsM5e0akiPbDsZmGvRP+zF8whGRBUi5U+5LvRNDs2pCmDSb083cF+srVR8jBNGJbBQMB6Zrv/Ic0fZjdJ7/IoXug5bAaKfmHSRLOd8ezk+oI4q/d52umT4kERyW6o/Ee17zv5KtiH9rzk0gU6daFiMvBA/EY93M5K2Jr9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(18002099003)(22082099003)(6133799003)(3023799007)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnUvajI2UDV2ZzZzSXdYZytKVHhDOHJSd20vZ1dDZG8vejdpWjVKYjdaaVRp?=
 =?utf-8?B?Wk01bnJRZ25WU0ZuWWFQK1lIdFVJNkFqWm90NytENjFmMGlOYjJRcGIzVC81?=
 =?utf-8?B?TTNvNzMyelhmalFKc1VPc3Y0QUErVldHWVU5TVl6S3A1bEpTdzlGWHc4WE9X?=
 =?utf-8?B?V0pYRUNjSHZRYVQvUGltZUU4UEk0RTZ6SkZZNHJtNGc0ZDB0YWFibkRPYkpk?=
 =?utf-8?B?LzY1c3RqTEx6K21nSENuZFR3RzY2aVJTSW9IYW9ETUtTU0tuNGxwaE1xYmxM?=
 =?utf-8?B?Z2Yya01OVDBvTTRMaUtrWHJzQnVHeEdZWm1GaFVVYUpYREZiUHI3bE9NaXJF?=
 =?utf-8?B?OUJWdnVaazZCdWVPUDgrRTRvQlh5VDRqVEVnUjlVcUZuVkJoUldqd3lkbFRw?=
 =?utf-8?B?dEJwR2ZBOEMwaTIxMkgvY1RUY04wMzllVllCTDhlUnJlaStBZkVjNEZuMHdY?=
 =?utf-8?B?VTlFQ2w2dGhFYnlVdWFMK0lxMFMyeWtnVWUvQllNckluOUM1TU5WYTJCakw4?=
 =?utf-8?B?NjdHUGtFdHVPNUlZZG5EUS9OTFdHUGVpa3YzTVdqdVpGTUtZMVAxclFXTHRE?=
 =?utf-8?B?eUNScjJ4dUJja0NSdzFmc09hK2k0UHVuc3J4Z3pDS1VQSGdSRkx6UmFiejVy?=
 =?utf-8?B?KytVZ3ExOGtORXorNU1DSllUa0JrRnFHRk5xbVJSTFYyNmpieHRVcXk1Wjl0?=
 =?utf-8?B?RUw3eXQ0c3BxcVNwbkhWRHV4cktaaDQ0UnFSOGY4VTFLQUVSbjdpSlpoUGU4?=
 =?utf-8?B?YVUrSk5EckYwNnd0c0Nta1RXelNXaXNTVzdISWhDR0ZHQXNHY0dBNGQ1aDk1?=
 =?utf-8?B?aWJHWmN4UUVTZFRDOGE2NGJ4MlNZSFlCTUVDcTc2eXdyTnJpTnRsWVVEUk5H?=
 =?utf-8?B?Y0FBQitwYmhPallGY1hETFpjbGhpRUN1NlBEc3Q1dUw2TTVVZEVCYm5rdnBU?=
 =?utf-8?B?ZXFuZW9WUWlLTWk3VzVvR0FJWHZsRWZjSEg0VDdkU21YdjJwV3VaTEI2Y1dE?=
 =?utf-8?B?L1RFLzR2MWRBUm9NWStHMnlPdkU4a1NibnBJL3lSbmtKRDhOa3hZZnpxOG9I?=
 =?utf-8?B?dC9kT05EQVlmRFVMalZBczlRa3dsK2hUQUNKZ1RYSDRZd3JoczQybDBNZDJW?=
 =?utf-8?B?UjlCbVk2L3loNG9UZitXQ3h6VU9aejZmTWNLdzdPU3RuU3F6ZkFaY0Vmd3Zz?=
 =?utf-8?B?bzdTVitQdUpqTmN1UGU3ZXhxU0F4ZGZOUUF0T1JISHlGYXd3d0lGcDMwd3Z3?=
 =?utf-8?B?cm5CQWxETzRPOWJDS2lRYzMzbzlKM1FseExkajZ5b29wckRhNHUvb0hUUzRm?=
 =?utf-8?B?T2JxSFBBMFR5anMxR2cwZW9GRnFJb0RCR0grWSt3eThGZUZzMzhlUTFYY2Vp?=
 =?utf-8?B?SmVINmhIYUJsNlpzZldLRzRQSEFLWFBkV0tKczA0eWhVR0wrN2JlNGg5NE1k?=
 =?utf-8?B?Wkg5ZndjVEtXSm0zS1RST0FUZ2laVEJDVTRZWnlsb0U1aUl2SVRQOU0ybGQv?=
 =?utf-8?B?VjBHejVrelE1NDgwRGRyZVJEclNPZ09UanJnQmVuc243SXFsdzJpbnh3dGdi?=
 =?utf-8?B?TitZdFVaWDVBQWxPRWdab2JpUnhBU0FnU2wrYXFDQTRzZlN4OForWWxqanlM?=
 =?utf-8?B?TUtoVFJsbUpPN3J6SCt6NlREKzBaK0MzY3JmaXUwU3VRLzQyQlhkVEdCNm1h?=
 =?utf-8?B?cEsxaHRVdEVGVjluUG5ocGVMU2dERWpZaHZEWFpOcitYNDRQWW1KWE1JVnc1?=
 =?utf-8?B?eUN4c3oxaWk3Yzhwbkk4aERYelY1Q3JYWlloYnJ2YUZZc2c3OTMwNmY5cTE5?=
 =?utf-8?B?T3hqTGN4Q1RhQ2ltZHBhakVOakVVSnJTVkJTMWNDU2lXNTlaWXR0WWhRSGNR?=
 =?utf-8?B?bUhDR24ydDd0MVoxMGYyb0NpTGFjc0M3bDY3aG1lQUpoSUEvdExrc2Z2emkz?=
 =?utf-8?B?b292OXZZeHd3d0xqRk1wdS9aNXJtV0J0SjZDcldMbmQ1bGVjL0w2dVNTV1Ev?=
 =?utf-8?B?MFR4dFZQcWMwbXVTb3NtbTBWa2NibnJoaWVxQmMxTEU5a1BpT1hEd0VWcG1y?=
 =?utf-8?B?Y1M4YXVYM1lZemdtVEtKU3N2SVkrTUlDbTdlamFGelM3V2tXUWJZdW4wRmYy?=
 =?utf-8?B?dEM1OG9DejY5ZE05R08wVHJzajRBS2VwTUlQZWsyN1paQi9NTG1jMFd6dm1q?=
 =?utf-8?B?VzY1bytuUE1pc2lzN2llc0tESGIwYnJ6b2E5N3NiaHR5KzlsdFhGOWh2eGhR?=
 =?utf-8?B?YXF5S1U0RnZHYjQ3Z3JSalowRmQ3MXczdmR1M2FKakVYNkRnN003eFBZT1VG?=
 =?utf-8?B?djczOVorN2szWlM4U0t0SStaSXdhK2Qzbmdvbkl0d28zdUxQNzU2RWI1aHJi?=
 =?utf-8?Q?dR7NuVJq83DdjnTH9WcUYDTrdmKUyU15PDQe9Jxpfx2oq?=
X-MS-Exchange-AntiSpam-MessageData-1: bKmBNWM8fkCFrg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6edf086-389a-4ccf-7f49-08debc9b12ec
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 09:25:35.7737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWwo8NECLAXRxN2Ry0I0qndIa31oQc4KMz3IG+/E8Upt09LL6WgkMz/RyHCFwR/CVuqz5JA8dGKZCyf8Phc7dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9719
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

On 5/21/26 01:59, Denis V. Lunev wrote:
> From time to time it is needed to remove all bitmaps from the image.
> Before this patch the process is not very convenient. One should
> perform
>     qemu-img info
> and parse the output to obtain all names. After that one should
> sequentially call
>     qemu-img bitmap --remove
> for each present bitmap.
>
> The patch adds --remove-all sub-command to 'qemu-img bitmap'. The
> new sub-command also composes with other bitmap actions in the same
> invocation, so a common "wipe and recreate" workflow can be expressed
> as
>     qemu-img bitmap --remove-all --add NEW FILE
> instead of enumerating existing bitmaps, removing them one by one,
> and only then adding the fresh one.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> ---
> Changes from v3:
> * renamed 'any' to 'need_bitmap_name' for clarity (Kevin)
> * dropped the redundant 'remove_all' flag; an empty actions list is
>   already caught earlier, so '!need_bitmap_name' alone is sufficient
>   to detect the --remove-all-only case (Kevin)
> * one assignment per line for the action flags (Kevin)
> * simplified the BITMAP_REMOVE_ALL loop to the inline-assignment
>   while ((bm = bdrv_dirty_bitmap_first(bs))) form (Kevin)
> * corrected the inline --help synopsis to show FILE [BITMAP], matching
>   the .rst
> * rewrote the parser-side comment to spell out the invariant and to
>   call out that '--remove-all --add foo' is a supported composition
> * expanded the commit message to motivate the wipe-and-recreate flow
> * added iotest coverage in tests/qemu-iotests/tests/qemu-img-bitmaps
>   for the basic sweep and the --remove-all --add composition
>
> Changes from v2:
> * rebased to the lastest head
>
> Changes from v1:
> * rebased to latest head
> * adopted bitmap help to the new layout
>
>  docs/tools/qemu-img.rst                       | 10 +++-
>  qemu-img.c                                    | 55 ++++++++++++++++---
>  tests/qemu-iotests/tests/qemu-img-bitmaps     | 24 ++++++++
>  tests/qemu-iotests/tests/qemu-img-bitmaps.out | 46 ++++++++++++++++
>  4 files changed, 125 insertions(+), 10 deletions(-)
>
> diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
> index 558b0eb84d..b0c798b77a 100644
> --- a/docs/tools/qemu-img.rst
> +++ b/docs/tools/qemu-img.rst
> @@ -301,15 +301,19 @@ Command description:
>    For write tests, by default a buffer filled with zeros is written. This can be
>    overridden with a pattern byte specified by *PATTERN*.
>  
> -.. option:: bitmap (--merge SOURCE | --add | --remove | --clear | --enable | --disable)... [-b SOURCE_FILE [-F SOURCE_FMT]] [-g GRANULARITY] [--object OBJECTDEF] [--image-opts | -f FMT] FILENAME BITMAP
> +.. option:: bitmap (--merge SOURCE | --add | --remove | --remove-all | --clear | --enable | --disable)... [-b SOURCE_FILE [-F SOURCE_FMT]] [-g GRANULARITY] [--object OBJECTDEF] [--image-opts | -f FMT] FILENAME [BITMAP]
>  
> -  Perform one or more modifications of the persistent bitmap *BITMAP*
> -  in the disk image *FILENAME*.  The various modifications are:
> +  Perform one or more modifications of persistent bitmaps in the disk
> +  image *FILENAME*.  Most operations require *BITMAP* to be specified;
> +  ``--remove-all`` operates on all bitmaps and does not take *BITMAP*.
> +  The various modifications are:
>  
>    ``--add`` to create *BITMAP*, enabled to record future edits.
>  
>    ``--remove`` to remove *BITMAP*.
>  
> +  ``--remove-all`` to remove all bitmaps.
> +
>    ``--clear`` to clear *BITMAP*.
>  
>    ``--enable`` to change *BITMAP* to start recording future edits.
> diff --git a/qemu-img.c b/qemu-img.c
> index c42dd4e995..2f63d31141 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -87,6 +87,7 @@ enum {
>      OPTION_FORCE = 276,
>      OPTION_SKIP_BROKEN = 277,
>      OPTION_LIMITS = 278,
> +    OPTION_REMOVE_ALL = 279,
>  };
>  
>  typedef enum OutputFormat {
> @@ -5018,6 +5019,7 @@ enum ImgBitmapAct {
>      BITMAP_ENABLE,
>      BITMAP_DISABLE,
>      BITMAP_MERGE,
> +    BITMAP_REMOVE_ALL,
>  };
>  typedef struct ImgBitmapAction {
>      enum ImgBitmapAct act;
> @@ -5036,7 +5038,7 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>      BlockDriverState *bs = NULL, *src_bs = NULL;
>      bool image_opts = false;
>      int64_t granularity = 0;
> -    bool add = false, merge = false;
> +    bool add = false, merge = false, need_bitmap_name = false;
>      QSIMPLEQ_HEAD(, ImgBitmapAction) actions;
>      ImgBitmapAction *act, *act_next;
>      const char *op;
> @@ -5052,6 +5054,7 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>              {"add", no_argument, 0, OPTION_ADD},
>              {"granularity", required_argument, 0, 'g'},
>              {"remove", no_argument, 0, OPTION_REMOVE},
> +            {"remove-all", no_argument, 0, OPTION_REMOVE_ALL},
>              {"clear", no_argument, 0, OPTION_CLEAR},
>              {"enable", no_argument, 0, OPTION_ENABLE},
>              {"disable", no_argument, 0, OPTION_DISABLE},
> @@ -5070,9 +5073,9 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>          switch (c) {
>          case 'h':
>              cmd_help(ccmd, "[-f FMT | --image-opts]\n"
> -"        ( --add [-g SIZE] | --remove | --clear | --enable | --disable |\n"
> -"          --merge SOURCE [-b SRC_FILE [-F SRC_FMT]] )..\n"
> -"        [--object OBJDEF] FILE BITMAP\n"
> +"        ( --add [-g SIZE] | --remove | --remove-all | --clear | --enable |\n"
> +"          --disable | --merge SOURCE [-b SRC_FILE [-F SRC_FMT]] )..\n"
> +"        [--object OBJDEF] FILE [BITMAP]\n"
>  ,
>  "  -f, --format FMT\n"
>  "     specify FILE format explicitly (default: probing is used)\n"
> @@ -5086,6 +5089,8 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>  "     with optional multiplier suffix (in powers of 1024)\n"
>  "  --remove\n"
>  "     removes BITMAP from FILE\n"
> +"  --remove-all\n"
> +"     removes all bitmaps from FILE\n"
>  "  --clear\n"
>  "     clears BITMAP in FILE\n"
>  "  --enable, --disable\n"
> @@ -5116,6 +5121,7 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>              act->act = BITMAP_ADD;
>              QSIMPLEQ_INSERT_TAIL(&actions, act, next);
>              add = true;
> +            need_bitmap_name = true;
>              break;
>          case 'g':
>              granularity = cvtnum("granularity", optarg, true);
> @@ -5127,21 +5133,30 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>              act = g_new0(ImgBitmapAction, 1);
>              act->act = BITMAP_REMOVE;
>              QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            need_bitmap_name = true;
> +            break;
> +        case OPTION_REMOVE_ALL:
> +            act = g_new0(ImgBitmapAction, 1);
> +            act->act = BITMAP_REMOVE_ALL;
> +            QSIMPLEQ_INSERT_TAIL(&actions, act, next);
>              break;
>          case OPTION_CLEAR:
>              act = g_new0(ImgBitmapAction, 1);
>              act->act = BITMAP_CLEAR;
>              QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            need_bitmap_name = true;
>              break;
>          case OPTION_ENABLE:
>              act = g_new0(ImgBitmapAction, 1);
>              act->act = BITMAP_ENABLE;
>              QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            need_bitmap_name = true;
>              break;
>          case OPTION_DISABLE:
>              act = g_new0(ImgBitmapAction, 1);
>              act->act = BITMAP_DISABLE;
>              QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            need_bitmap_name = true;
>              break;
>          case OPTION_MERGE:
>              act = g_new0(ImgBitmapAction, 1);
> @@ -5149,6 +5164,7 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>              act->src = optarg;
>              QSIMPLEQ_INSERT_TAIL(&actions, act, next);
>              merge = true;
> +            need_bitmap_name = true;
>              break;
>          case 'b':
>              src_filename = optarg;
> @@ -5165,8 +5181,8 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>      }
>  
>      if (QSIMPLEQ_EMPTY(&actions)) {
> -        error_report("Need at least one of --add, --remove, --clear, "
> -                     "--enable, --disable, or --merge");
> +        error_report("Need at least one of --add, --remove, --remove-all, "
> +                     "--clear, --enable, --disable, or --merge");
>          goto out;
>      }
>  
> @@ -5184,11 +5200,22 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>          goto out;
>      }
>  
> -    if (optind != argc - 2) {
> +    if (need_bitmap_name && optind != argc - 2) {
>          error_report("Expecting filename and bitmap name");
>          goto out;
>      }
>  
> +    /*
> +     * Every action other than --remove-all sets need_bitmap_name, so
> +     * !need_bitmap_name means the only action(s) given were --remove-all
> +     * and the BITMAP positional argument must be omitted. Combinations
> +     * like '--remove-all --add foo' remain valid via the branch above.
> +     */
> +    if (!need_bitmap_name && optind != argc - 1) {
> +        error_report("Expecting filename");
> +        goto out;
> +    }
> +
>      filename = argv[optind];
>      bitmap = argv[optind + 1];
>  
> @@ -5225,6 +5252,20 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
>              qmp_block_dirty_bitmap_remove(bs->node_name, bitmap, &err);
>              op = "remove";
>              break;
> +        case BITMAP_REMOVE_ALL: {
> +            BdrvDirtyBitmap *bm;
> +            while ((bm = bdrv_dirty_bitmap_first(bs))) {
> +                const char *name = bdrv_dirty_bitmap_name(bm);
> +                qmp_block_dirty_bitmap_remove(bs->node_name, name, &err);
> +                if (err) {
> +                    /* Save name for proper error reporting */
> +                    bitmap = name;
> +                    break;
> +                }
> +            }
> +            op = "remove-all";
> +            break;
> +        }
>          case BITMAP_CLEAR:
>              qmp_block_dirty_bitmap_clear(bs->node_name, bitmap, &err);
>              op = "clear";
> diff --git a/tests/qemu-iotests/tests/qemu-img-bitmaps b/tests/qemu-iotests/tests/qemu-img-bitmaps
> index 7a3fe8c3d3..979bc0d6c9 100755
> --- a/tests/qemu-iotests/tests/qemu-img-bitmaps
> +++ b/tests/qemu-iotests/tests/qemu-img-bitmaps
> @@ -161,6 +161,30 @@ $QEMU_IMG convert --bitmaps -O qcow2 "$TEST_IMG" "$TEST_IMG.copy"
>  TEST_IMG="$TEST_IMG.copy" _img_info --format-specific \
>      | _filter_irrelevant_img_info
>  
> +echo
> +echo "=== Check --remove-all ==="
> +echo
> +
> +# Start from a fresh image so prior state does not bleed into the assertions
> +_rm_test_img "$TEST_IMG"
> +_make_test_img 10M
> +$QEMU_IMG bitmap --add -f $IMGFMT "$TEST_IMG" b0
> +$QEMU_IMG bitmap --add -f $IMGFMT "$TEST_IMG" b1
> +$QEMU_IMG bitmap --add -f $IMGFMT "$TEST_IMG" b2
> +_img_info --format-specific | _filter_irrelevant_img_info
> +
> +# Sweep every bitmap in a single command, no BITMAP positional
> +echo
> +$QEMU_IMG bitmap --remove-all -f $IMGFMT "$TEST_IMG"
> +_img_info --format-specific | _filter_irrelevant_img_info
> +
> +# Wipe + recreate in one invocation: only 'fresh' should remain
> +echo
> +$QEMU_IMG bitmap --add -f $IMGFMT "$TEST_IMG" b0
> +$QEMU_IMG bitmap --add -f $IMGFMT "$TEST_IMG" b1
> +$QEMU_IMG bitmap --remove-all --add -f $IMGFMT "$TEST_IMG" fresh
> +_img_info --format-specific | _filter_irrelevant_img_info
> +
>  # success, all done
>  echo '*** done'
>  rm -f $seq.full
> diff --git a/tests/qemu-iotests/tests/qemu-img-bitmaps.out b/tests/qemu-iotests/tests/qemu-img-bitmaps.out
> index 74b81f703b..99290d3ba5 100644
> --- a/tests/qemu-iotests/tests/qemu-img-bitmaps.out
> +++ b/tests/qemu-iotests/tests/qemu-img-bitmaps.out
> @@ -180,4 +180,50 @@ Format specific information:
>              name: b2
>              granularity: 65536
>      corrupt: false
> +
> +=== Check --remove-all ===
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=10485760
> +image: TEST_DIR/t.IMGFMT
> +file format: IMGFMT
> +virtual size: 10 MiB (10485760 bytes)
> +cluster_size: 65536
> +Format specific information:
> +    bitmaps:
> +        [0]:
> +            flags:
> +                [0]: auto
> +            name: b0
> +            granularity: 65536
> +        [1]:
> +            flags:
> +                [0]: auto
> +            name: b1
> +            granularity: 65536
> +        [2]:
> +            flags:
> +                [0]: auto
> +            name: b2
> +            granularity: 65536
> +    corrupt: false
> +
> +image: TEST_DIR/t.IMGFMT
> +file format: IMGFMT
> +virtual size: 10 MiB (10485760 bytes)
> +cluster_size: 65536
> +Format specific information:
> +    corrupt: false
> +
> +image: TEST_DIR/t.IMGFMT
> +file format: IMGFMT
> +virtual size: 10 MiB (10485760 bytes)
> +cluster_size: 65536
> +Format specific information:
> +    bitmaps:
> +        [0]:
> +            flags:
> +                [0]: auto
> +            name: fresh
> +            granularity: 65536
> +    corrupt: false
>  *** done
ping

