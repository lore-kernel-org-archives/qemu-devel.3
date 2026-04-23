Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A15FC0343
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFvha-0002B7-KK; Thu, 23 Apr 2026 11:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wFvhZ-0002Ay-97
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:10:49 -0400
Received: from mail-westusazon11012011.outbound.protection.outlook.com
 ([52.101.43.11] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wFvhV-0003AC-WB
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:10:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9z20dFKDN8qMf9ii90JT3/WxihHZXAfkHfVvL131TvCOmRv+lwZsNd1KZ8PSQ+qlDI9EWx91YKFeYuCVU/Qmom1sSxIUNmXyn8swt3qwdIqpHmknoQRVpvYB+zgMrutQ5HI8qAI7MHh73Qrqj5orfuH2VvpmUNpvukFejoPheEwKeV7gbJcTgPWyflGiAcSDk8sklS/iHGAoifXAEzLjGRirIR1O4NM5dPiUFYrO8T70f4Dynqih29mfNsivhQrI22CsTMhNNkg06MIL8CtwkNXuikPDvRQYkjVDxfoj3GU0+1gbJkLHCBsSQyjwOXpIrirJQ8df/8ALnfx6pXFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGNIefVq1OhOjLczx+XE140/VR3uuXB2fcjU4iS2z1c=;
 b=zD27r41Tc+MdICKHgIA4BjHOHalQSfdkYIsDvpPGkV5shgE2/xu4adxqHAnvm/TITvmbGY8XPpN94KwJ3K36WoAPmtDlCDmgVrhPL04KQ23p+xFGj1bfQw8QT/wWc6FLqYOsc/+13rG2BRMpLN8N1DtwheQIVqgPFNBEsxGpzzWGsvH5VhjgOX35yR0dqcF9QdEHaLH/2K7Y0g8JcUhQ9ku0xTmpFZDvyE4zjlE7f1kJxbcndPvdR+WXUSr6R0WLXZYCR+z9hdhU+hJGgm/BRyWsnOj3JS0DB86xsv9BK1Tc47ok5cYTFDqi+b5THuBakh7paFTY2mEzeNyELqzJuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGNIefVq1OhOjLczx+XE140/VR3uuXB2fcjU4iS2z1c=;
 b=jsIvDiDovy1aji1z/2KA2Tzo4b2Bg2pI5CWGZLT3wMIAvcSXHmk2Uv6x8J1zUz2QjcGBpyOfzgY2xvSQCh7UUKXL3jgoqzAfy8fXPb4WPWPlwTXmUVVLhf1unDHr7nE0VHOWkeOrxkWCGIlNPve5PE4ArnmC+VV/0joWC7VhrinXvnWo5yZ8aSAR5mvWJDFspd+Xaizkgh1UFyO3Mv8xH+hA0xHtwloq3J7Uh6e7uOfdNs2YhWIi7QAHKdkq8yR4WSAulQ4MMxYxhlR1g1VYL1PVMzniGExKEYRTarwY3PVSj4CZ5h2SyA439wJZYPxoB7d3ThLVer7/xY002tlxiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by DS4PR12MB9682.namprd12.prod.outlook.com (2603:10b6:8:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Thu, 23 Apr
 2026 15:05:33 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 15:05:32 +0000
Message-ID: <3490b6b0-fe7f-4907-a62e-9d4507774e7a@nvidia.com>
Date: Thu, 23 Apr 2026 18:05:25 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/16] migration: Introduce stopcopy_bytes in
 save_query_pending()
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <ppandit@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Kirti Wankhede <kwankhede@nvidia.com>, Zhiyi Guo <zhguo@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Juraj Marcin <jmarcin@redhat.com>
References: <20260421202110.306051-1-peterx@redhat.com>
 <20260421202110.306051-8-peterx@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20260421202110.306051-8-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0346.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::10) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|DS4PR12MB9682:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c788dc8-6213-4ffd-73cc-08dea149c3f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: VydeZBRgbv7OyweFFUiIMWy1ZdGuWSAbIJl4iUj5hp6JfpQl4YK1gIrhs1kfIN2p4FycqDoRn+XjpiuguxMEiv/nGaRWSM08UiskQzpWVPDKW11CHY+INu55f3GnBBKPXLMyIw2wgwwbFeW04U4myeJe1RuthVlpIgelA/8FPN/wUvkvUhiFihGbQj4csgW1W4kwEWa4yGZAnBWHnFYf5PT5Uzdz1XWBgjva/f4NFeRpE9qqi/DSl7Md9UO9BlzK+wG5qJ47hlWhbNP7dVolUBHoOVC3MFFvxXE2xzj4bhDoY1/pIIsYYoVRJFXUXJ085NzWEdzgtLQdaO0zlrvr9LGigjlqeOWh8n5qzZcOSFy2LEWgEi+dRafoVTVmr66Pxq2w/HsXffCttEsZ1akxXLhas/46Fa7YlakxUZWvedZeNNyTZtMBT5go+0Egf3tv6EBA+ayy5YZF4ezykh+xBLgDL3QAcR5pTohh62x+QU1+1r0DEfF6YtbvRDo0khKpulS8DiKV0lWNF7/ubTu9xiTQqbp5ucjltR/liSC/6jVLkNZnRP0IrSgVLBuGkreFlRFYhQ4s2UlvI9AMT2dTA8LiDONORvCDWXlZfuhEqDfWH7sj9BUefrvi3MaHahVv5InxDd6DH26mRmVstrkRhl13VQzF5De6f3PjMXyNHeOAlicS6Ue41wbLyVJrGdIfgfJQxOoQSws193RKnXUBI24nKsib2yH82HYEOytRhAE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlZiWVZpd0JtOGY0NnVRQnFRTE5BdnVQY1poT0NHL0hTTjgxZkxRK3RiaFdu?=
 =?utf-8?B?b05hb0ptK1psbTV3VlV2c2lNdGdjRVBvTHhHMXZvUTkxMkQ3NHNLMG1GSEpk?=
 =?utf-8?B?MXJSalpWK291b1V4M1E2dktybjJGY2VlUDErRldnL2t6UDVOMEMxSFdibmhT?=
 =?utf-8?B?SmVUV1dKQTR1SEdRdndSRjNRYXpxem9aUGxlV05jN25YQkZkM24yWkxXNmF0?=
 =?utf-8?B?QXRlejBrVEI1ZGlnb1VHSFVZTXdzcDZ0WjltUFoxaXNEWnBiRFJEcytUWU9R?=
 =?utf-8?B?ekg1THczcVZNSmFVQjBFcVBNN2gzMzNQcFo4dDRQYmFidW1rbDV1L0tuc3lu?=
 =?utf-8?B?eXBDTWpPb0xMWkYxQlo0Y3h6WmUvdTRGM3FJajJoSzJESWF0TU5VRWFoQlpT?=
 =?utf-8?B?bzdrcXZjN3ovRmpGd2pDZFRqYi9oVk90WDBMYVUwVzJ5WVhNMlVVTi8xTlVx?=
 =?utf-8?B?bHd0RU9RMUhQZGpOK21HNVJIWWJ4RW9XTXFVQURhRmh0aEw0bVA4c3RNUGEz?=
 =?utf-8?B?V2ZEeVBiQ3lZcjhiTnErQS9jbWoyUVljbjdRYjljbTRQRU1NNjF3ZWFLanZD?=
 =?utf-8?B?NE0zcVU4bUErbm9IMjJTTUpUUkVMaGc2V3lRWG1WZFhFT0s1ajhlbXpiaWsv?=
 =?utf-8?B?cWVZdWRlZEltNkMwaFhlM2JwS24rajg4ZGo2SVo5MnlFNXJNNTFwbmhyaUFn?=
 =?utf-8?B?SnVSeE04Z1pZcGlob0dEWDRUNUh1eWVLZkZnSFErR3hJU0tnOVo2c1RRZ0k3?=
 =?utf-8?B?YjhPYzM3QzV3eVpwT2dMQnFlUnFWV2xtVzZLM05qMkkxUnorUXI5dXp4ZkY2?=
 =?utf-8?B?bDU1Qk1WUzBQVWhuazhjcW1JNFJKTzFYbFIxK0NwZVFvRjl3V0gxM21meitK?=
 =?utf-8?B?cDJESVdQdFdqTlZ5STMyaDdzYXR2WE1JMFZudjhuRGVmT3pFNjdlZlpTaG40?=
 =?utf-8?B?V0Y0Q2MyOWhWOW1TMzVha3AvQUE3U25GWjBTOVc1U2twdkNiR085M0Y5a3pP?=
 =?utf-8?B?clF6Z2QrYmYyM21wMWw1QlRjVFNnRGNmZTc5SHFOT0tlcUdzNEdHYW9qUnh6?=
 =?utf-8?B?R0Y4TW4rbWZYZGl4SHFSZnBvbENkaEhjQkZUMU4wdlZqTURCazBEU0prTzdH?=
 =?utf-8?B?RUlaUm1xejBmUHZXV0xyZ0o4RWZRU0UyMzFuQjgyOGFRckpzcjAranFUZmxB?=
 =?utf-8?B?QnIzaThNUVY4R0dZOGVaRkpNSk0xLzBQMDFCUmROaVlOZDhkQkJJaHB3NlBp?=
 =?utf-8?B?cng0RWlhUmpydWIxZXlPYUE2MlJJVitmRFpZVnM1WDQzWFBWT2poVDd0NSty?=
 =?utf-8?B?UEFBbDVsSWJTOUU2UnNKRUM4Mzc2Q1phNTBJTmJQTElacVhXZlRzczM4ZUpX?=
 =?utf-8?B?cnJIVnZLbC9GajhDODZoMmJERkE3a0lHcXBoRkgxdlNoMTFDQTVTWnNMK3JO?=
 =?utf-8?B?dk5LZ1FtUEorN1lrNW1zK0VvSC9JVVJBWnhoK2F3bG9UWGZlY1g4emdMMzB1?=
 =?utf-8?B?d0dJM1Y1Rm1TVDhoTGFncE5Canh3ajRJdXVVcFpvbFdKZmNDS1picUpaN0Zw?=
 =?utf-8?B?RGtCa3dQNmlEdHlkVGpuRjhCbkNKRk4yV3d1T1VHb2ZVdi9WaDhlWTNSa1VO?=
 =?utf-8?B?ckpFeVgramxsOTVLdHl5eUVjZjJmZVdieGFmcjFnaS9kaSs0Ny9vK0liUEUy?=
 =?utf-8?B?emhucEM2WVAvWjNSaXltSFlMcUtEd2J3ZHdXNWVVRGRuTzliYWJRRUNYWHZk?=
 =?utf-8?B?UGI0eE5ZNmlDWnNRMTB1Z3gwb2ZMUHZuWm9PL3o3OE4yRnFFSjBiZ3F4NkRY?=
 =?utf-8?B?QXZPaHpQOVNhN05yN2FKMjlCOVRRamN0aVJPUWZsZHJPVVJFa2xvWENkOWly?=
 =?utf-8?B?d21wSjlaZ210bUtSRmlPZ3NSVGFVRmppNVpBMm5ReGZVcnZpclZmV0phclNx?=
 =?utf-8?B?MjdUbkJJTVhpZWM0YVQxc242QzAvZk1VM2RSTVZONjNWN1dXdDBQM0pVK1VX?=
 =?utf-8?B?TUdqWlU2NDJmdmNWS01jckFPZXFMV1BuS0ZXTWlQOHluOHkxUm1UV2N5MzRX?=
 =?utf-8?B?S2FtT1cwRVU4TE1FYjdEcEQ3RXZ4RE5NL3grc01IZC9LQU9HU3Y5SitvMnZ6?=
 =?utf-8?B?ZldLMk4wd0M2QkwxVXJOWjlTVlBwNEsrSTFLQ2FObWtybUg5UmI4YThxSnlX?=
 =?utf-8?B?c2ptTU50WjFKaktWdTRNeG0zYy9yTzJRanlyemdZM1NsS1I3MFgyUTYyREZC?=
 =?utf-8?B?aWVXSlUwRWNyRFdqMFZFM1NYa21HclRZMDdxVW5XWUtwMjd1amphOS9XM0h4?=
 =?utf-8?Q?mWWYQZkAr7GbYV+uJT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c788dc8-6213-4ffd-73cc-08dea149c3f9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 15:05:32.9072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/lE2T2IkQirYZBZnUxA/zP8Xyegd0NqJm4V2j42b30CVIpQRetk4cVyi+oYySgqAm7btaICLjo/Zqhblh0qug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9682
Received-SPF: permerror client-ip=52.101.43.11;
 envelope-from=avihaih@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


On 4/21/2026 23:21, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> Allow modules to report data that can only be migrated after VM is stopped.
>
> When this concept is introduced, we will need to account stopcopy size to
> be part of pending_size as before.
>
> However, when there're data only can be migrated in stopcopy phase, it
> means the old "pending_size" may not always be able to reach low enough to
> kickoff an slow version of query sync.
>
> It used to be almost guaranteed to happen as all prior iterative modules
> doesn't have stopcopy only data.  VFIO may change that fact by having some
> data that must be copied during stop phase.
>
> So we need to make sure QEMU will kickoff a synchronized version of query
> pending when all precopy data is migrated.  This might be important to VFIO
> to keep making progress even if the downtime cannot yet be satisfied.
>
> So far, this patch should introduce no functional change, as no module yet
> report stopcopy size.
>
> This paves way for VFIO to properly report its pending data sizes, which
> will start to include stop-only data.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/migration/register.h |  7 ++++
>   migration/migration.c        | 65 ++++++++++++++++++++++++++++++------
>   migration/savevm.c           | 10 ++++--
>   migration/trace-events       |  2 +-
>   4 files changed, 70 insertions(+), 14 deletions(-)

Reviewed-by: Avihai Horon <avihaih@nvidia.com>


