Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF37CD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 21:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRci8-00071j-RT; Mon, 25 May 2026 17:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rnorwitz@nvidia.com>)
 id 1wRci7-00071Q-Je
 for qemu-devel@nongnu.org; Mon, 25 May 2026 17:19:43 -0400
Received: from mail-westcentralusazon11010061.outbound.protection.outlook.com
 ([40.93.198.61] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rnorwitz@nvidia.com>)
 id 1wRci5-0001Fh-PX
 for qemu-devel@nongnu.org; Mon, 25 May 2026 17:19:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhtjoAvGX77NUGEGsexXuQHEKSNy3R8UHPzSS4ybkgGfbJRA12yVA5lPeuUcS7TDg1aY8YQ8Ka+NbkJaDZh9G5kUDynpVHex8qOBvuzMZiyZc4TiBFiDk/Siu/y6VUqdXEPJLqbOGtc3gCHL3dWdxjd9/lmmsyhslYTMEUATCT8lmJK6FlRq6U3ab5M0f9/4yGcgwRMQAmxdrg/00WutUT2qJOckE12Hvqwr0EaoC7asY+9Tw5rH/EiZFPLdWnE0zRVcUePzvf0pVlIYkJAwTspsp49Csb6eA85oKAoW9p0y6t2W0psSewox8kKhSCoGxBnNGkxuTdVcwNTr4zHmug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThDIkF1Z4vXiPiQTG2cMeLBpm9mxFe2bU66O6shwhKQ=;
 b=H80VLemUklwlOX8jS9YWB1dSdIwDMjmQjsxoVls2Q+MA4Mt8rKdAKkcfiXmTRZF0Xy8irT0MGuCEbOpgyvfrEwa5Uplev5oCF0pr3KOLxdgErO3+J2IxGjxd2wu/8aMYRivUGByAiguctL42l9xkbIRTsfX1LJhiu49nuPAcwexAWcSKBp/7yAIWdIY1C9tKcjPIwWA3E99P5fNp7cNpxPzWWhRhXNUGoKOTENMNT0fY+bgyBH1x9YShgV8az2vuW/NBHopsO1Ro9CtYO+gEzendORFD44+Sa5gowccrT6uaHscoIDq07qgMNMad4hZsBBmLUIO/9Shei1xBVc+Y7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThDIkF1Z4vXiPiQTG2cMeLBpm9mxFe2bU66O6shwhKQ=;
 b=ARf2lCxKyNR+vAo/PMxQLifTMMqW5N8wzlGrGaotsUjaQzR//lDkLhiB/GK96CM58L38HnQyPb6+lTQuZF0nY+cqPnC9kVCqvlmeOBNzULAdUycm9WVKHFuivxjZl3TjgHdHe85UgjM3BSHrtd2Hm+CFWSMVL2TjGeSrEUBEDLYFwdeJAmEmlc1pYSrPoRJH4oV8ya+md7zWEoN0D5trqFAxmFxAsQugEVkV3ud4OalcrptPISemJPFys9yqVV2jaOusDLeUh6gNMd1pZy49eQ7khQwbV98rdn+rCGgHtHtbifBd9w6Yheb6gacl+cp48w8NUY+aSzuhPapSZ25tpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB7226.namprd12.prod.outlook.com (2603:10b6:806:2a9::18)
 by PH7PR12MB6419.namprd12.prod.outlook.com (2603:10b6:510:1fd::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 21:14:31 +0000
Received: from SN7PR12MB7226.namprd12.prod.outlook.com
 ([fe80::c07d:130a:7def:6807]) by SN7PR12MB7226.namprd12.prod.outlook.com
 ([fe80::c07d:130a:7def:6807%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 21:14:31 +0000
Message-ID: <05bfa642-3af0-46b5-97eb-ffd5922d1d8e@nvidia.com>
Date: Mon, 25 May 2026 17:14:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] virtio-scsi: Make max_target parameter configurable
To: Karolina Stolarek <karolina.stolarek@oracle.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <cover.1777890280.git.karolina.stolarek@oracle.com>
 <020004d5e274daf0370094d631d61a452db7d599.1777890280.git.karolina.stolarek@oracle.com>
Content-Language: en-US
From: Raphael Norwitz <rnorwitz@nvidia.com>
In-Reply-To: <020004d5e274daf0370094d631d61a452db7d599.1777890280.git.karolina.stolarek@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:208:52c::29) To SN7PR12MB7226.namprd12.prod.outlook.com
 (2603:10b6:806:2a9::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7226:EE_|PH7PR12MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: ec6d3988-4d9b-4dc1-567b-08debaa29c9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|11063799006|4143699003|3023799007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: IRbphESe4DAPIWO4qGU2wOnAHa82R74Jd5RlQ0pfwlvercuvaB4J36vuVKhmXkAQG+3vGHnKprR+iHH7BCysbqdg3uFK2JD6RIx8qP63L10bsiu892v1JL01wpoCpdFwF88FzyW9iaPwZYhdAtM/wT32RlJrflFGkuDejBkFqIrK1/wfcUFD+6w2Ehou0PMfIY5vv7mEywzg5SPuIAs9bNXOivH9yvfMdbEWYmFAcWL+upIOe6WNBm86bPD32z9SdpUxonM++4EfogUCJmvkgd+QGOO4HYJRsv7MLLgQ4j/bjD49pkZVlSikXqNPzwAr8KLrYY9RN8yEvchM1XOskJedhMmMkZ05cYxUYQ3Vva25h3SVvHs4lgH6S/iExfcTS+UdJLl+Da04PRCeQ5jC1gw/2fURFMp9QBTwdA1l14CqFN8fNrtCbTf+CwmxrV7a4YCids5NoxpcHuU+w0+Z8Ln/7hzm+CEBjkQAhiIUfnuNP3C+Y6P48U3V2iOnqAgtHfcdkpmSdPIeQ0htcBNIS2LiVgIqmBmkkdbR6OcEvyKhiOXEA/7VM6j8YbpAgmLMs75j/7S1n4hd2jbqwnGRNDUfzpb5vzMMO1CZ6z1qguHJNsQZNd9bWhM4pmktXPkkD595Dw5+/4YgMjeF1BTTzAbNS1RRN2yZtH0CqmRzPndUtfwJ7r12irH5ytCgv49s
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(4143699003)(3023799007)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm5DZjdpNUxpNXRWY0xlV05DTGJFUGc2Y0pmQ0M4clY1UTdkcGZPdTM3emxL?=
 =?utf-8?B?VUtRbE1idEV5Y2RkRFdKbit6V3oyS3hZd1NoaFpXdEIvTXY5eVQ3T01vc1Q3?=
 =?utf-8?B?dTAxVmdYNWlpZkcwbGRUdEdkWHdXaWRGYzR6amVJbGJOekh3cGVhSVN0UXdn?=
 =?utf-8?B?ZHBMZStMNHU0NUwyS3FRc1lZRTI1RzRtb1M5UHhYdzBQejdzOTV3VCtTTjhl?=
 =?utf-8?B?YSsrM3JZUEM4bEFIdWIxTHlzNm9nYUpDWDd1a05YYUI1cXpzOFZsNEg2OHRp?=
 =?utf-8?B?K2dWQjhza29QeDNkQTNpWXRvZkdLWXgwOUdqNVVyU1ZtQ0F0MGoxQ2ZQMHVE?=
 =?utf-8?B?QWtYNDJiL1NNTy9US0IxUE1jVW9vSkVFdFAyQllLRkFWSlpjTVJ4SlgzNTFk?=
 =?utf-8?B?UEx6Y2VvSTFmK0RkckwzMWo4Vy9LaStPYU5sd0pROWRJbkhwMU5DS2JOWGJz?=
 =?utf-8?B?QU9Ja1VlSE92SlZjV1JmQnl6QUxZWmxQdXJQS0pMZ2YwRlhFaGtyZjdqVlNN?=
 =?utf-8?B?OUdpREVMVjJJdlFIdXVMbHJoOWtDNktEWDErdStaalh2azNnc2FTZ0dUMFVV?=
 =?utf-8?B?cTFkVjM0WVhJcXdZMjhlQkR4STJsazJtSjBhUXRnMVpYTHpmb1MrSnczMjUw?=
 =?utf-8?B?Mld3Ly9iME1xbFF2NE5EQVE2eVFweWZtSExuT3RFakR1Q2RtWHgvYy81cHFp?=
 =?utf-8?B?cXNrSHI0Q2dIVmlTNzVTU3BOZmlmQ1JvN1pFWHJlZTJlbms1dXY3dkhDL20v?=
 =?utf-8?B?YUI3bkxFbStSQWJJT3N3WU16ZWZNZ3NneHluSDh3eXhhRGNqc1VMc0FHcTU0?=
 =?utf-8?B?bit0ZHFrc0ZpOVNldmNNUk0xS09RVFFlS3lsQVRnMnJ1bW1mV2ZhK2J4UStr?=
 =?utf-8?B?OVpuTCtRMHdJNHJJdDBvdUF5TFR1dmF1ejk5WHRJQXZweWdDQ1BBVFA5S1BV?=
 =?utf-8?B?WUhDWTljV0kyejNTU21mME4xcHEybytLcERGOEVUaU5yd0podHNwQlpSQ3Zh?=
 =?utf-8?B?VUh0QTA0QkZibGJWczlCanJtOXhoNGNkN2hlU3NIY1pHcmRRVlZoVFNRajZI?=
 =?utf-8?B?dzhRUm1FNTRSQjdyYk5NQ1YzcnFzRWFHNHdXaHFsQ05qSTlHSGhMV0VlNEJ2?=
 =?utf-8?B?ZjNmWTJRaU1iN24xZlpQUUVVdzZ2VVRoZElVZnZtS1BlSmhCSTJXV0NuVVJM?=
 =?utf-8?B?Ymc0d2VRL1c4bzF4UGlwK2VQYmFpZUZlNmhFenVTR1V0YStoQ0hOeGlwWUVu?=
 =?utf-8?B?alp3dmlNeGEwMUc3dlVkeS9MK25tQlZPbWxRQldOZW1vd05nMW1QM296eng0?=
 =?utf-8?B?TVExMDJOQjB1cGVrd01ZVHMyd0YveklFazZJaHdYaGJsTW1wbVY3cmF3aGtK?=
 =?utf-8?B?RHJLNWpVT2FDMFZaZnNCOEc0VmxoYW9UQTVzd1FIMWsvQndpV1JqNFMrSStB?=
 =?utf-8?B?UkkraFFNWm5QWEVVOHF0TkwzeWxzYi9lVkM3RWtBcFBVRTdOd09DWXBrMmhy?=
 =?utf-8?B?S0RzSThzT3RhUVVWVlhOZlNhd282amVEck1sUEQwUW1yRWhkUTgrTCtlQXds?=
 =?utf-8?B?MTltK2Y3RHlWUTVocW9EVC9Gd0VFQ3pleEJjRWhONXc1am9RUVhlSDBBV0RK?=
 =?utf-8?B?UHRuK2NPcy82RmY1TUlqMWNzaHFRSnlzRG5mSllPZkNqQ1h5RXNBWitGNC9F?=
 =?utf-8?B?QjYzSm4zUFN5SnVUa1UvdlRKbTFHckF0N2ZXOWxQTE14cm5ldmZ3Q210dmlk?=
 =?utf-8?B?ejVsTmRBc1Zmb1RZbGkrdWEwZ1g4Q3ovSWRqY2lNcHZDeUpTZUM1cjd1NmIz?=
 =?utf-8?B?ZUpMSFFMWHJrVk1WTGdrVGRQQ0lsNUlPN09hb0FZZk4vc3YvOGJHRk1IdzJ1?=
 =?utf-8?B?MDBpZWV2cVlLY0luMjEvcmJwUUdzSytsSXNHdlozalJJbW91UEt4K0RLVjRV?=
 =?utf-8?B?dkE3ZkNBSE94L0RvbXhiRms2Nys3U1BVNGRhUFJ5d3JpZ3V2ayt4eVBIbTRQ?=
 =?utf-8?B?eG0xdjY3Y01LekExSDNDc1BsRG5VcUxVRExFcVJGVUw5NWx1OGVhd2p3N3pL?=
 =?utf-8?B?Q1MwWjRPdWgxK0ZVd29sMzRNTjZnMlN1VjBTZjhBVUZDL0JnU1dLZTFQTDhj?=
 =?utf-8?B?S29ERi9NdXk5N1hrTE12c3k5WlJENWxTSEdXOFVqK0RETGdoMHB4N3lyUVJV?=
 =?utf-8?B?aWlLSFlmc3FxZzFvZ29MMytqUXdPWHBnbFFhcUQ4a3FtcUNkdWdHWjMrR1Bv?=
 =?utf-8?B?aldNeVRjVm9JdnBUdXRpV25Sc1pueEFMWnFHNVRzZEo1MEF4S3drZjF5aFJW?=
 =?utf-8?B?bWRpZHVZRWNBOGg1S0dWNXhaMFJLU3dGbVlROGlpbGxncTZmdkltZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6d3988-4d9b-4dc1-567b-08debaa29c9d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 21:14:30.9433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SAiI4eh5jWrPyp8MM/CeswV0muV0ryswFtNy6KM960kOHzYJ0JO2R6r7tqQCLKC694NWihv2mjReWigekEL+FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6419
Received-SPF: permerror client-ip=40.93.198.61;
 envelope-from=rnorwitz@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

This looks good to me.

Reviewed-by: Raphael Norwitz <rnorwitz@nvidia.com>

On 5/4/26 9:59 AM, Karolina Stolarek wrote:
> In virtscsi_probe(), virtio-scsi enumerates all possible
> targets, up to VIRTIO_SCSI_MAX_TARGET, to see which of
> them are available. During this scan, the initiator
> queues up INQUIRY commands for targets that do not exist.
> 
> Provide a "max_target" option for vhost-scsi and virtio-scsi
> devices to change the upper limit of scanned targets. Move
> away from a static virtio_scsi_scsi_config definition in
> favor of a dynamically allocated SCSIBusConfig that is
> stored by the VirtIOSCSI device.
> 
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Cc: Raphael Norwitz <rnorwitz@nvidia.com>
> Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> ---
>   hw/scsi/vhost-scsi.c            |  2 ++
>   hw/scsi/vhost-user-scsi.c       |  2 ++
>   hw/scsi/virtio-scsi.c           | 37 ++++++++++++++++++++++++---------
>   include/hw/virtio/virtio-scsi.h |  3 +++
>   4 files changed, 34 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index 699863cc10..b2e8240344 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -352,6 +352,8 @@ static const Property vhost_scsi_properties[] = {
>                          128),
>       DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSICommon, conf.seg_max_adjust,
>                         true),
> +    DEFINE_PROP_UINT8("max_target", VirtIOSCSICommon, conf.max_target,
> +                      VIRTIO_SCSI_MAX_TARGET),
>       DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon, conf.max_sectors,
>                          0xFFFF),
>       DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSICommon, conf.cmd_per_lun, 128),
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index 3612897d4b..4e59f06ea2 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -352,6 +352,8 @@ static const Property vhost_user_scsi_properties[] = {
>                          VIRTIO_SCSI_AUTO_NUM_QUEUES),
>       DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSICommon, conf.virtqueue_size,
>                          128),
> +    DEFINE_PROP_UINT8("max_target", VirtIOSCSICommon, conf.max_target,
> +                      VIRTIO_SCSI_MAX_TARGET),
>       DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon, conf.max_sectors,
>                          0xFFFF),
>       DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSICommon, conf.cmd_per_lun, 128),
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index f9e4f6fc02..4de06bad3d 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -975,7 +975,7 @@ static void virtio_scsi_get_config(VirtIODevice *vdev,
>       virtio_stl_p(vdev, &scsiconf->sense_size, s->sense_size);
>       virtio_stl_p(vdev, &scsiconf->cdb_size, s->cdb_size);
>       virtio_stw_p(vdev, &scsiconf->max_channel, VIRTIO_SCSI_MAX_CHANNEL);
> -    virtio_stw_p(vdev, &scsiconf->max_target, VIRTIO_SCSI_MAX_TARGET);
> +    virtio_stw_p(vdev, &scsiconf->max_target, s->conf.max_target);
>       virtio_stl_p(vdev, &scsiconf->max_lun, VIRTIO_SCSI_MAX_LUN);
>   }
>   
> @@ -1264,13 +1264,6 @@ static void virtio_scsi_drained_end(SCSIBus *bus)
>       }
>   }
>   
> -static struct SCSIBusConfig virtio_scsi_scsi_config = {
> -    .tcq = true,
> -    .max_channel = VIRTIO_SCSI_MAX_CHANNEL,
> -    .max_target = VIRTIO_SCSI_MAX_TARGET,
> -    .max_lun = VIRTIO_SCSI_MAX_LUN,
> -};
> -
>   static const struct SCSIBusOps virtio_scsi_scsi_ops = {
>       .complete = virtio_scsi_command_complete,
>       .fail = virtio_scsi_command_failed,
> @@ -1324,6 +1317,23 @@ void virtio_scsi_common_realize(DeviceState *dev,
>       }
>   }
>   
> +static void virtio_scsi_scsi_config_init(VirtIOSCSI *s)
> +{
> +    s->bus_config = g_malloc(sizeof(SCSIBusConfig));
> +
> +    s->bus_config->tcq = true;
> +    s->bus_config->max_channel = VIRTIO_SCSI_MAX_CHANNEL;
> +    s->bus_config->max_target = s->parent_obj.conf.max_target;
> +    s->bus_config->max_lun = VIRTIO_SCSI_MAX_LUN;
> +}
> +
> +static void virtio_scsi_scsi_bus_cleanup(VirtIOSCSI *s)
> +{
> +    qbus_set_hotplug_handler(BUS(&s->bus), NULL);
> +    g_free(s->bus_config);
> +    s->bus.config = NULL;
> +}
> +
>   static void virtio_scsi_device_realize(DeviceState *dev, Error **errp)
>   {
>       VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> @@ -1344,13 +1354,18 @@ static void virtio_scsi_device_realize(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> +    virtio_scsi_scsi_config_init(s);
>       scsi_bus_init_named(&s->bus, sizeof(s->bus), dev,
> -                        &virtio_scsi_scsi_ops, &virtio_scsi_scsi_config,
> +                        &virtio_scsi_scsi_ops, s->bus_config,
>                           vdev->bus_name);
>       /* override default SCSI bus hotplug-handler, with virtio-scsi's one */
>       qbus_set_hotplug_handler(BUS(&s->bus), OBJECT(dev));
>   
>       virtio_scsi_dataplane_setup(s, errp);
> +
> +    if (*errp) {
> +        virtio_scsi_scsi_bus_cleanup(s);
> +    }
>   }
>   
>   void virtio_scsi_common_unrealize(DeviceState *dev)
> @@ -1374,7 +1389,7 @@ static void virtio_scsi_device_unrealize(DeviceState *dev)
>       VirtIOSCSI *s = VIRTIO_SCSI(dev);
>   
>       virtio_scsi_dataplane_cleanup(s);
> -    qbus_set_hotplug_handler(BUS(&s->bus), NULL);
> +    virtio_scsi_scsi_bus_cleanup(s);
>       virtio_scsi_common_unrealize(dev);
>       qemu_mutex_destroy(&s->event_lock);
>       qemu_mutex_destroy(&s->ctrl_lock);
> @@ -1387,6 +1402,8 @@ static const Property virtio_scsi_properties[] = {
>                                            parent_obj.conf.virtqueue_size, 256),
>       DEFINE_PROP_BOOL("seg_max_adjust", VirtIOSCSI,
>                         parent_obj.conf.seg_max_adjust, true),
> +    DEFINE_PROP_UINT8("max_target", VirtIOSCSICommon, conf.max_target,
> +                      VIRTIO_SCSI_MAX_TARGET),
>       DEFINE_PROP_UINT32("max_sectors", VirtIOSCSI, parent_obj.conf.max_sectors,
>                                                     0xFFFF),
>       DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSI, parent_obj.conf.cmd_per_lun,
> diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
> index b6028bb5cd..b4b796fc58 100644
> --- a/include/hw/virtio/virtio-scsi.h
> +++ b/include/hw/virtio/virtio-scsi.h
> @@ -54,6 +54,7 @@ struct VirtIOSCSIConf {
>       uint32_t virtqueue_size;
>       bool worker_per_virtqueue;
>       bool seg_max_adjust;
> +    uint8_t max_target;
>       uint32_t max_sectors;
>       uint32_t cmd_per_lun;
>       char *vhostfd;
> @@ -83,6 +84,8 @@ struct VirtIOSCSI {
>       VirtIOSCSICommon parent_obj;
>   
>       SCSIBus bus;
> +    SCSIBusConfig *bus_config;
> +
>       int resetting; /* written from main loop thread, read from any thread */
>   
>       QemuMutex event_lock; /* protects event_vq and events_dropped */


