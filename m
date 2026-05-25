Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAA6CD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 21:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRcjC-0007NI-9H; Mon, 25 May 2026 17:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rnorwitz@nvidia.com>)
 id 1wRcjA-0007Mu-3Z
 for qemu-devel@nongnu.org; Mon, 25 May 2026 17:20:48 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rnorwitz@nvidia.com>)
 id 1wRcj7-0001f4-5m
 for qemu-devel@nongnu.org; Mon, 25 May 2026 17:20:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4F6CwZjhra3mV34htDOm5pZ/MYvPQg/EXanidXUQ5w+8TYm30IeKOx7FdLlERuK0ylTvDsWYfi8f0baYuIQzCFUUhoZK0HCMXOuV3Y6Wpc7ZbhAqkFXakoMNRtnhVQMl1dh37Ztg+95N3N7SpKJ4ZdTW5fop35l7Avc+vwoKGTsp2Adxh318in1Jbh/32792Ma//GvgwLMaglpjfSYTEI3RwbcNlkNngH1KuchpLBlK1+OATQC4XD0IpDLEfWZ0E4Weudz90ZYFHpKXBemhZ6OPEOR2vwaFSrrNPecKNXJCwrI47688VTQA4h2YzQifdqyoWHlpIyM06rPvcAWBsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRG7L3sEpsiF3AKKU02KpmElPdoJoIT0HHA/YRItAfw=;
 b=EIVo+lsiHH/Tlv/CnFH+ORqy2imWJNsJsXwGkGBOCclx2JklV095NS9yi+aip67eRJZRaKM3QB3aUwRl0XkCLNLxnOMavObDhvzdxx7wbQSaBHuQYBOvS71xYhIZW3UKXLwviFtV1NWKdLiVp1sQ3l4z0rGtwBRlj58DfVTyQH8iTopDLcY4P/0GlUbCvQVrJX+nyCZ1oi9KxCkLSYKT9fPboKEODBJiD511bWJiQdzgkDmyHtwdIRlqplrD6lVNm1k/1FnYamA84zrZroW8qHdRsa55iFPPKhiQOA0WIcaMoUJCjF6Z7VEICezlEuyT5US25oZLCGCPvPj71qA1TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRG7L3sEpsiF3AKKU02KpmElPdoJoIT0HHA/YRItAfw=;
 b=COGZsZJz9V0SEH8gW0SXEt5EJxFYzQ1qV7hJg7qkNwhNA+G+7g10gzIGy9lRstSPoCMkfxO6m2+V1d7lND8TJ+adS0co1bjIV/96ZHRl9tjRyJjFC1JcfvebAehrkn0AO8QBr8jS6MNWkEQx+uNH507/GsH7QHBAVCmEIf7VIEpUkUfo48FdgHqcqXff8bCNOQmOQCWERMRqSUn5d4RBzy38owqzAyI5MF12BAkp67HooRUEkBKY4KAmRbWri/0cQVV6jyus6IONeuhh5EZrbnSN4q00KyM/XQ5NgzwDPbeqmH/tN1nlq3m9p/+0QOiriDaOAOcJATiHvI9i04p8tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB7226.namprd12.prod.outlook.com (2603:10b6:806:2a9::18)
 by DS4PR12MB9561.namprd12.prod.outlook.com (2603:10b6:8:282::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 21:20:39 +0000
Received: from SN7PR12MB7226.namprd12.prod.outlook.com
 ([fe80::c07d:130a:7def:6807]) by SN7PR12MB7226.namprd12.prod.outlook.com
 ([fe80::c07d:130a:7def:6807%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 21:20:39 +0000
Message-ID: <4c34807c-5e13-45a2-a9a3-dde2097c8e68@nvidia.com>
Date: Mon, 25 May 2026 17:20:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] virtio-scsi: Make max_lun parameter configurable
To: Karolina Stolarek <karolina.stolarek@oracle.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <cover.1777890280.git.karolina.stolarek@oracle.com>
 <9d555df8e0e8f84cc516ccce7506f6779fc3e600.1777890280.git.karolina.stolarek@oracle.com>
Content-Language: en-US
From: Raphael Norwitz <rnorwitz@nvidia.com>
In-Reply-To: <9d555df8e0e8f84cc516ccce7506f6779fc3e600.1777890280.git.karolina.stolarek@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:208:52c::32) To SN7PR12MB7226.namprd12.prod.outlook.com
 (2603:10b6:806:2a9::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7226:EE_|DS4PR12MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: 73be11a8-f7da-4cf3-d0e3-08debaa37846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|3023799007|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: L9mWVYOo0CEnU7OMWcjcuhBoAavD0qiowZbkbkpJhAPNqWxKr5stmRs+9/qhAywDFIK1i0+4Xfp/RyGab8TbB8czFuiIvOupCHTkl4WGy0mShjq9UBI6Sntxyys0vY3ud7Cmgyvi90bPGI3mlIW45fo8NVWbv6N8XcVVxzeScvwj9Axn2Y6+c1wKF5cPIepgs6wGdxN3PqIiaBMq3Ot6ejCT47IH6OcDo3oTl73DghIfh4zzvUE/FXUJb+N4HdZKgGWCeYxPo6e4s9Pf5z3hB419OmvlTNsREmaZCCkLQJM/FasUZx8ib6cb1YfGu9DJU2zTdgVq574wfP3qxijK5wSOBC8I7oCjqFJ5Vx175lLnJ7cQ7o9Vp/jZu3N3KeuDxCw7G+zh/Cs7j+B6WCiDshcYtGLa79AwEpaA+yRDdkRTgyw5mQ9U7IMmyaGbNkyfL4xAsf8OdlxfCYwjfFKVv+Tn9HYChsa4OpbraI+iFsmG0Hk9GRr5j/QHnfcw1pD6TMK9M3Qz7n0mMIZSNQ+1kcFcTl6/hxz6mR47LU0IbdiL0LJEj3cq6y9GEEe1KfJ0GRvL75M8TEGHsAN8nfOgNQ/E0Yn7jFvLmwBrb1M50omEwqaS0mfM+njo1d7UeS/WvNIX3+WzjRJNO2NN+YGQlO0utjvWCCNvFa3yWuxypVsiBViCEqPxv3P5CheyozMv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(3023799007)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1lIdE1NNjdPMUdLWlNtL1FKalB5MjN6L3Nwc0YwUnFGb3JuYXFNOExiOXow?=
 =?utf-8?B?M3FZR09xMURBWWdrQ212VzZWeDJlcitxNGJiNnJZN0hNUE5CWWFtTnRlSjU3?=
 =?utf-8?B?R0hyZDN3S2tkK0dtcmlqSlV1Y0RWWlRFVmdCcHFqSEcwdGRXaVBTbU1WSGIr?=
 =?utf-8?B?SHNWSEdMQmxPWm5IN2FhNVZGNUJEaDR1RkRyOUswMnZuOGZiWFdiTVhmaDhZ?=
 =?utf-8?B?bVBtTnhpUHJxTUREYnRKWm56T0dyeTVLNTZNSFF2MjJ1YnpFNGtxL3k2RVo1?=
 =?utf-8?B?d2doWjhBT0hjNVdSNEVsSmtlVEVnWitML1A3Y1U3dmkzR0hRdlZhNzNlUHF0?=
 =?utf-8?B?ck1iajdDL2N0WWxBNnByNGl2blNwVkpicXdPVytBaWhLaWgzTkxWeDR1N1pZ?=
 =?utf-8?B?R3hHOFdkYlhMK2xYSEp5R0FyR1ErV3JNcm0vMUVaNGordWRZdjlOWFM1eEhD?=
 =?utf-8?B?eTNoL0J6bHhCcHhsRE0zNmFjb3ozdDV1Z216RllzSmFrc1UrcHpaMjZKbndF?=
 =?utf-8?B?VDdjWXhYeHpSWS9kMk5DN3pTd3pQeTUxSUp6TWJpbFNCanp6R3RrWU90L2py?=
 =?utf-8?B?SHBWMGRZQjFicnJralU1VW1FZTF3L21KUHpaOHBvS1Y2SFV3dklVRW1XY2Fj?=
 =?utf-8?B?ZWJNTFpzaXNySXA5Q3A0ZEZibVlweEFTYlI3SVNnSmxlYmJnSGxVVmNsdDBR?=
 =?utf-8?B?cEJuNVZuNkdkVkRxRUlFMzJ0a0o1eWQwZkkwajFwNDZRY3UrOTZPeFVrOTQ5?=
 =?utf-8?B?Szd3RXNydG5uMWdoOTBmU05jeWJ5WHFKMW5PUkZYOUJRVTdEREdhVmx5ckFp?=
 =?utf-8?B?RlZlNW5nbS9RWEl1ZmRtQnlGaDkxVkpJL3FMSHM1bnNsaC82NEhSMUlxSFNo?=
 =?utf-8?B?Y091TjFDR2tZTjJodHNhUmlqZ2xHR0oweDVwbHBjZDJ5Q0xQSS9pN2YvY0pQ?=
 =?utf-8?B?ZStYQ3NaTUNtcXh0RVdpMmpOcHQ4c25laG96VjNEK1dWY1NvUU4zclpYUGwv?=
 =?utf-8?B?M0RnRzVMM1FmOVk0MzVtNnNQRVpkbUFvQlBGdjFTM2Zqb0Z1M2tKMzI1d1po?=
 =?utf-8?B?Zkc5MUVVbm1QeHBKUVNRelY2MGlJOEgzcENhWDc3WEZnaW1PRUdXYVZpMkFO?=
 =?utf-8?B?TjhLSWJoTGpVMGgzR2MvcFVVQXJEYWgraDJEeFgxR0JHNk0vM3dzS3ZSbmNZ?=
 =?utf-8?B?M2ttdis0TGR2ZC90RnlsSFBINE9LanV5SHB6U2RVb2ZpOHNON2N0bnBac0dS?=
 =?utf-8?B?UUIzRUhGenlxYkZXZHBPOW9PNVFuSCtsNE54T2orWGdkQWVnbW9EanhINTRy?=
 =?utf-8?B?eXlqak84UmRCanZkNVFvdTdlWFZ2ZHBxN3hLcHdUSWd4endFeCsxZXdJdmpn?=
 =?utf-8?B?UFRPcXZ6UTU4ejV4Z0hxdmVmT2UwVTRxTTZKTUhXREJjNy85eTFKcXp0MENz?=
 =?utf-8?B?eEQ4Zk5HR3NKbWxVeGMxL2trUHhsckdta2tNU0gvV3VCdmd5YS9PbGRIb01H?=
 =?utf-8?B?UUxXNm5Gc1QyVTdtelR3RG84blpnd1RSYnB3VlpodmNVNW1WTzQ3bERISXJJ?=
 =?utf-8?B?K09FZkVZRG9DdWdLY3JDcVg0MjROcXRUams2dTZJOUNhNUZ1NGVBTWxLQmFt?=
 =?utf-8?B?SGh4UGgxbGp0bVRCeDJQSEYxb3FRZVBkek40dURnUzl0eFF3cm5Nb0JVNERj?=
 =?utf-8?B?Nm5ZOG1lRkNvcEtObFRHSzRyT3dwK0RoU3ZQN3VrN3RTemdoMXNHS0RveTNF?=
 =?utf-8?B?ZHIyRlpiWHZ1QnZKSXhzR1Y1VGlPSXdkZHFlTXd6eW9UQm5jWkN6cXY5OXNt?=
 =?utf-8?B?U0hwbzVDTU1rZndSNlhxQWkzZVBqTStMd0d2N3BSM2paU3dLRElKKzNGaUxi?=
 =?utf-8?B?Q2h3SVgyejdmaktLVU1OZ0NnZDNnUDdsbXpRTkRGRjlsbnZ4S3RoVUtGZVVk?=
 =?utf-8?B?dVJyaUN6bkJ3WU9KeW5CZm83S3ZZQ2JmRjhhM2lJZnoyVjBYOVRNUXpCUXZn?=
 =?utf-8?B?Ym1NZjByejNJd2huNWFmejNvYUkya2VkTHo3RC9YN3VsODJHc01tMXVtdW1P?=
 =?utf-8?B?R1Uyc1BiamQrRzBJNHpLd2pmcDN5Y3Q3aXBwclNNUUdyc0F0WFlETlpnSnFt?=
 =?utf-8?B?eDdMNnpvNkJIVTgzbUc5NkROZzFRU2puWDVqM29zN0xESnVvS1JlbTRoNjNn?=
 =?utf-8?B?Um5RanV6a1NZM0xqSHB5YTVQUmZHV3FMLy9Eb3NwZUtiaVlUYXllYW1jYkIv?=
 =?utf-8?B?SDloOUZKSmFCbVhkSDVpQ2szejUvQW5obEJEZHFlQXlBTHorVzVSNGZjTnlk?=
 =?utf-8?B?QjJqTE1kTndpUHF0MWJKc0xkSldVRkd1d0d1U0UwVmVuNWNVZnN5QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73be11a8-f7da-4cf3-d0e3-08debaa37846
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 21:20:39.4546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tr0P6RexeT0TMGGDFgsk2jwyscdHo2G1gz2vDHbhfxVkSKEGxNyHt3TQxnpmzRsi0yi7dfqCQkFoyzhYrR3ZpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9561
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=rnorwitz@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

 From what I understand the LUN is a 14 bit field so VIRTIO_SCSI_MAX_LUN 
should be enforced. Should this code check that max_lun is valid and 
clamp and print a warning if it isn't?

Otherwise looks good to me.

On 5/4/26 9:59 AM, Karolina Stolarek wrote:
> The virtio-scsi driver in the guest is able to retrieve
> the correct number of LUNs by querying REPORT_LUNS. There
> are some drivers, such as OVMF VirtioScsiDxe, that discover
> LUNs by queuing INQUIRY commands up to an arbitrary limit.
> 
> This is an issue for vhost-scsi devices, as each inquiry
> to a LUN in a target that exists causes "Detected
> NON_EXISTENT_LUN Access" errors to flood the kernel logs
> of the hypervisor during VM boot.
> 
> Add a "max_lun" option to virtio-scsi and vhost-scsi devices to
> specify the maximum number of LUNs to prevent sending commands
> to Logical Units that don't exist.
> 
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Cc: Raphael Norwitz <rnorwitz@nvidia.com>
> Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> ---
>   hw/scsi/vhost-scsi.c            | 2 ++
>   hw/scsi/vhost-user-scsi.c       | 2 ++
>   hw/scsi/virtio-scsi.c           | 6 ++++--
>   include/hw/virtio/virtio-scsi.h | 1 +
>   4 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index b2e8240344..568ce02e36 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -354,6 +354,8 @@ static const Property vhost_scsi_properties[] = {
>                         true),
>       DEFINE_PROP_UINT8("max_target", VirtIOSCSICommon, conf.max_target,
>                         VIRTIO_SCSI_MAX_TARGET),
> +    DEFINE_PROP_UINT32("max_lun", VirtIOSCSICommon, conf.max_lun,
> +                       VIRTIO_SCSI_MAX_LUN),
>       DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon, conf.max_sectors,
>                          0xFFFF),
>       DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSICommon, conf.cmd_per_lun, 128),
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index 4e59f06ea2..f4c761bf18 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -354,6 +354,8 @@ static const Property vhost_user_scsi_properties[] = {
>                          128),
>       DEFINE_PROP_UINT8("max_target", VirtIOSCSICommon, conf.max_target,
>                         VIRTIO_SCSI_MAX_TARGET),
> +    DEFINE_PROP_UINT32("max_lun", VirtIOSCSICommon, conf.max_lun,
> +                       VIRTIO_SCSI_MAX_LUN),
>       DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon, conf.max_sectors,
>                          0xFFFF),
>       DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSICommon, conf.cmd_per_lun, 128),
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 4de06bad3d..3a10ef2118 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -976,7 +976,7 @@ static void virtio_scsi_get_config(VirtIODevice *vdev,
>       virtio_stl_p(vdev, &scsiconf->cdb_size, s->cdb_size);
>       virtio_stw_p(vdev, &scsiconf->max_channel, VIRTIO_SCSI_MAX_CHANNEL);
>       virtio_stw_p(vdev, &scsiconf->max_target, s->conf.max_target);
> -    virtio_stl_p(vdev, &scsiconf->max_lun, VIRTIO_SCSI_MAX_LUN);
> +    virtio_stl_p(vdev, &scsiconf->max_lun, s->conf.max_lun);
>   }
>   
>   static void virtio_scsi_set_config(VirtIODevice *vdev,
> @@ -1324,7 +1324,7 @@ static void virtio_scsi_scsi_config_init(VirtIOSCSI *s)
>       s->bus_config->tcq = true;
>       s->bus_config->max_channel = VIRTIO_SCSI_MAX_CHANNEL;
>       s->bus_config->max_target = s->parent_obj.conf.max_target;
> -    s->bus_config->max_lun = VIRTIO_SCSI_MAX_LUN;
> +    s->bus_config->max_lun = s->parent_obj.conf.max_lun;
>   }
>   
>   static void virtio_scsi_scsi_bus_cleanup(VirtIOSCSI *s)
> @@ -1404,6 +1404,8 @@ static const Property virtio_scsi_properties[] = {
>                         parent_obj.conf.seg_max_adjust, true),
>       DEFINE_PROP_UINT8("max_target", VirtIOSCSICommon, conf.max_target,
>                         VIRTIO_SCSI_MAX_TARGET),
> +    DEFINE_PROP_UINT32("max_lun", VirtIOSCSICommon, conf.max_lun,
> +                       VIRTIO_SCSI_MAX_LUN),
>       DEFINE_PROP_UINT32("max_sectors", VirtIOSCSI, parent_obj.conf.max_sectors,
>                                                     0xFFFF),
>       DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSI, parent_obj.conf.cmd_per_lun,
> diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
> index b4b796fc58..9d5b90c3bc 100644
> --- a/include/hw/virtio/virtio-scsi.h
> +++ b/include/hw/virtio/virtio-scsi.h
> @@ -55,6 +55,7 @@ struct VirtIOSCSIConf {
>       bool worker_per_virtqueue;
>       bool seg_max_adjust;
>       uint8_t max_target;
> +    uint32_t max_lun;
>       uint32_t max_sectors;
>       uint32_t cmd_per_lun;
>       char *vhostfd;


