Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0882C25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 13:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6VQN-0003Vp-2Q; Mon, 13 May 2024 09:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s6VQH-0003Uy-Cx
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:09:00 -0400
Received: from mail-dm6nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2417::600]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s6VQF-0002HW-BT
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:08:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9mxeu+VxDtCBM/MMK9bKPJAHch6Y+qHkWmDDMLCrzBpvwFc5RIZIxazqlT+Ije1I9RYOgSdjTXK99frxaxk1gp6Sh7cYDHBAGUiwbImQl+b7GP6FpFiIY/qUjKUNTX+aeP5Dao1bNmXEHtQkgPzkRh/yGqcTNk7TCh9gRE+6I9w6GUkoYvVwK7Sgyc4JrrKvrZ+Nhk5mZmTVxUVQD7ovlu6bA9Y38C1JF3vqAcuzyX+DFGcRldxaL5oA4zBFUOAhUMmOvuZ9sX3Jt7pvrmh0eAsnqZYhqf9a8a4/rsSLG1S2dNt7EociH6DAJVRKXKSsYYwaGVrHpMlf+vf1OtroA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYvwRaKdIo9rBqaX5HC9V8ZZYsgm3712kJz3qHwPIxY=;
 b=NB+tP9VDJ6uDaK4KNIOxVXBbawkfD71JJL0D2kopMxM25RbhoKobJvlQ9BIWVIjHBYVr/wXnURMvYmkytK4dXvBHg0IEU3SbCfw19yZgtLrDaBXfQZ23n+QSTeOteXwu2HspkdOATbRVbiGCffrjkPlXrSV4dvpZK9Y1LXSP70w15NromH30jbetqbADr4eqEOWKzGrzly/JdlMB3heNzi8AdanQny30pQjhmrlTyCIPX8we7onjSgpGDmuZ5kKYehYEUImDhZXCVaha/bVchioN3ARUS3dMQSwexzXRggzVQt0C9Epqszt9zD4rbQtb+4G3D+urgjYxkWxGCBixUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYvwRaKdIo9rBqaX5HC9V8ZZYsgm3712kJz3qHwPIxY=;
 b=NnWt5bwvIGZoheWyXsc3+7Hr3iJAcYALClM2qwsmhmbHuV6/X6o+In4BX4K8ICM3idinFQ/lM4R3+q8PljdCtkbkM3nxUaFbo/4Chf7+YGVxqildz8eNnYGVY3+3G/FLeNBCM5te/4mz0oQKaGcVUqmijyA76J4fBoSR6wWpuyAtxeNbMM7cgOc0SF4c1cFLzdMEhEVqzekyMYHba45k3E7HdWQIejKoKLq1/LNiprUpwdXUHaK70yjn4jdKUdo3VpwXGSEthTjI+aqAGFYS3v13HZFoFXq8BpG0AGNRAd8xmvF76uK0B0j4M+eFJLW2aib0KWGL/BEchrNOc6zuEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DS0PR12MB9275.namprd12.prod.outlook.com (2603:10b6:8:1be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 13:08:47 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 13:08:47 +0000
Message-ID: <21449e77-5403-4d7a-af29-fedcab9a4385@nvidia.com>
Date: Mon, 13 May 2024 16:08:41 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/10] vfio: Add Error** argument to
 vfio_devices_dma_logging_start()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240506092053.388578-1-clg@redhat.com>
 <20240506092053.388578-3-clg@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240506092053.388578-3-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0515.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::7) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DS0PR12MB9275:EE_
X-MS-Office365-Filtering-Correlation-Id: 29097789-75e5-43a9-5dc0-08dc734dd30b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qm4vQWxZVE1HZmNIbldCYVFXM3lDV3V2ZU5haWdiNUdCQXJXQ2w5bnhrbm9C?=
 =?utf-8?B?QmdmVmZzWUE1bzRDSlFidmdVYi9WSkdhNDhaNU9yWW5pY1Q4c3RsZ1VZME00?=
 =?utf-8?B?RVJrcmMydDBMVVpsNDU2K0lXSGxMWnRpUTlBYVdLM2dhSk40S1lpRHRjYzd0?=
 =?utf-8?B?Smk1WlRGZmVQUmcwaU5PMU4xMmNJNU5QZXFDZWIvcXYyZGNYWkdTeVQ0S3Fs?=
 =?utf-8?B?ZjIxRWtaUzdMLzRwb3Zwb3VMMmxCalU5cVErR1EvSURUUnphTjhDZmhtQW1H?=
 =?utf-8?B?SVBpQmJSVFJjdlViY0dFVWcwOUpWdy9VV3QzSkRUU01sM1V3VzNrVjdsUGlM?=
 =?utf-8?B?S1pHbHQ1M1dHV01yN2NnclhkTnpWMG5zSG9JeHFRT1diMGJkM0RFYzFNK0dZ?=
 =?utf-8?B?YWNOZjkzYlFONWNEd2pPbE0vN1QyMlVWTHFiUnhiUGZGVG1raGZUVmxBeDY0?=
 =?utf-8?B?M1ZKandscitPRC9VK2dOVkxESHJTRWRHM0wyaUw1Z0Z4OGVlYWJTaFYvMkVH?=
 =?utf-8?B?dnNDYUtYTXZnTWwyNC9ZcHRLVFBkK3hjNjlmM2dCMHJGN0EyZGk0d1J4YmtT?=
 =?utf-8?B?cmYzeDJZNmFBUFdqYmJRdWxtRHhGOEg4cXF2VTRuc2NRN21pYWlNdGZvMitq?=
 =?utf-8?B?UWRUQTJiL0hOQWtWR0pVMmh0NmlUNVBRQ09Xa1JkRkRvVUI0dExpbkVXclRC?=
 =?utf-8?B?eU1DTHFrVlF1WXFEc3dUYk95R3kwa1lJOEJFV3JpOGVIM25BREdQYzNSakJa?=
 =?utf-8?B?N0JKYXIybjdKaUFlL1dDQ3pxaXVxY2hzbitUMFNkNWM4WlRIL0haTTR4TWxp?=
 =?utf-8?B?am44Y0ZYajAxN2ZES09HeVBvVmQ4bWNYQktsU0tndEZxdVJkakpGZUJaaFVa?=
 =?utf-8?B?b3BKdUJSQ1U5SDFHQVFRdzkwelE1Njh1ajJKNTJsSEdlQVVCZ0lydUM0U1hM?=
 =?utf-8?B?R1FwbExTU1h6U1BnSEpiblBPcitYQjUyekkvTkp5VC9EVDduL2JtRUpnOG15?=
 =?utf-8?B?UGJTbEdYYmowYnJ5ckk1ZktxdTVJdk1ZazZEdCs1R0h2OCtuc2RhK0R1M2FE?=
 =?utf-8?B?d1Era2tnakFVTGpNZm9VSDNqN05oMjU0UkQwN1BtanRPOHAyT2VZUjFRQ2pX?=
 =?utf-8?B?SnJrT3B4MUFab3VaSjdlNjdvSHF0bXRyUFlkaUVvWFhsbm56VTR4akFWS0t6?=
 =?utf-8?B?eVhYUUxIbENqTFQ5UndrMENmOVo4UEVKOVJrb1Y3SHR6NEF6ZHZLd0tsS0RZ?=
 =?utf-8?B?aVMzZEVtd1daanpMNFNTcWdVTlhNeks2UnlMaGtIa3IyOFk2bWdpOVhtWEVj?=
 =?utf-8?B?cDFsM0ZZRHFQeGZKSFk0UGlDNFk0TllDT01zV2lRZ1VhR3lhVk1LTmxpcVFi?=
 =?utf-8?B?QmRpb0Mxck5pTUVldkIzSkpUMGh0TmVLeTIzUnRoQTFGemI5MU9UNUViY3Fl?=
 =?utf-8?B?azNBN2NBcXhtM2JxQXBHSk96NW1JWU1aUW8xVGlWVnVtcHJCVUp5MWJ2U3BL?=
 =?utf-8?B?R3lNc0prbklZdERTb1FackkvR3ZXKzJObDVEaVRKaFhhWVlHTzRHbVdmazZZ?=
 =?utf-8?B?M0Z4Y3RVUzNZb1d5ZjEzdHhkeklZNFc0Mmt1d3c2TGJiM2lZYVFoNm1hUnJq?=
 =?utf-8?B?ZFFxbVpVeFNBOEJ3VXhSdUw4Sk10c0hUdFRZOG9ZOWkyeS9RM05FUEZRajM1?=
 =?utf-8?B?bmkvNWZkOXcyMFBsdFBzTUg2V1VhditiQXczUklpVlZnMFlvempSQlZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTVPbHpmOGloSEJzMHJ3N3FFZnJaaTkwZFhVUk1oOUdjSmpXemgvVFhYT2pD?=
 =?utf-8?B?Vm4zbU53MWNZOU14dG5iS2F5d0s0ZmszQlFtNFo4V2tXeWlFQS9ManF5LzE1?=
 =?utf-8?B?STcwNm5BeFJrWEREUytkK005SDVlWDdIVnB4RUpWdllWTDRQazNFZEQ1VFN2?=
 =?utf-8?B?QXZTVEd1M2dIb0JEb0lQdzJHdUJ3QkNXbnhRZVJ1UFdFODVXRG0wWlhMazJO?=
 =?utf-8?B?NnJrK2xneHJrQ2lURXhQZ0VLaUhiU0Y0OFZMckZQYTh4MkpmU0h5ZHNHRlBO?=
 =?utf-8?B?TDhGVUhaY2c2N05vN2ZwOFZ0bERxcUhtTU94c0hPODg0NDJ5MVQ2WFZOTlM5?=
 =?utf-8?B?a3h6cmQ5TlNrcm1IcWhLTXJpcGtUclBmcHEyTVMwUDV6aFJDNlVHN0RrTnpC?=
 =?utf-8?B?Sy9JOFR3MG1QMk9pUkJUU1VxSG9HdXFvRzRReTR4dXdRNjV6aFdLS0luQkxz?=
 =?utf-8?B?YU82QmI2YS9Jb2xWZW1idEtpbCtlbldUMDE5Y0J4VEtXcXY5MmVFbDhEREF6?=
 =?utf-8?B?ZkRNUlk5TXFrVDh0VFJxSEdNbEx6NjhsNDdvZTRqSG5vNWhrek5RblRhdU0y?=
 =?utf-8?B?dEtLOTdOSDk4c1dNWHRVNHg2TUM2N2VNQXlFUW91VmRYYWx3MEdrWlhGcG4w?=
 =?utf-8?B?S3lHbmw4WFZNRE1NM3JWdDl1UStLMTNzL2FaYzFwVXdkR0diMUZHcnhESkxH?=
 =?utf-8?B?U2g1ZjUrMWp4d3BmN0kvMUZRSW1keDhrQmdhNENzWk1ZWmROUlRTWUpBTUE3?=
 =?utf-8?B?RG5CS0dPNUM2MC9EV3UrUzhtZWprUUxSb1dqemk4N0ZwWnZmU0pkK21kM1JC?=
 =?utf-8?B?VGlTRWxpOXJtbHRFTEUxdDJ4UVRFcG95UDNNMkZUbzNxbUZYQkEzU01IN0hO?=
 =?utf-8?B?VDJHMkYxYlN0MG41aWhTamZLRGtqRDBoTjhNa3BmUkJ4cFVPdE00Q1M5SXI0?=
 =?utf-8?B?Zm1GVmZlVE1WdTVYRTZsZmFlcmdyQzlERmlJd29hYlpzVEdBZXk4clhpSjFJ?=
 =?utf-8?B?KzZhdkdWQWY2TXg5V21tdXMxVWpxTk5ULzE0VlUyZ2hPbG9ZSXJmNHBRVHRz?=
 =?utf-8?B?Z2VTeWwyVkhmV2FPWU5XZ1QwTFhUa0hGWGl1am00SUJ1bUtEd1VRWlhXUHAw?=
 =?utf-8?B?TkZEbUZTUHNkNHBsY2hRNzhnUFk0VzFxOEhsUG1EOGVrWXk0bmx1b3RsWHhF?=
 =?utf-8?B?MVJpWTlMNyt0RjFwUmFUcmgvdTVKOW1JSHJoR2puRlczeGNUY2x3TllMVHkr?=
 =?utf-8?B?QkRGQWRKSEZiTU1ocG03RnRlc3BJeTF1ZDFmWkNXTDVtY2xUeW9DSEwvU3Y3?=
 =?utf-8?B?Vy9YN0F1amdJK2M0cTBNRUtZMVBBaER6NHlwT3VMNU5hbUFzZXlZdjRMa29w?=
 =?utf-8?B?ZDJSaFRmSmtMR3BYcFluSmkxNk5UT0FEV1RrdHh4QTJ1cVNWQ1VUM1RGcDNK?=
 =?utf-8?B?MkdUNXp6SCthSVNFWDkzdGs0THg3Y2lVUkRHQzFyZGVRR1AwNVRaaVRkR1VR?=
 =?utf-8?B?UldJZlUrc0hIQjBrcUFBZzRtS2FsY0lpb2xWbzRUb1dRcUZYeGdOaVlKSDlJ?=
 =?utf-8?B?cE44NnlhK3FwcXhpdnkwcHFCY2xtamV2NU03MVgveXZpd0dCV0JlVytlWnhW?=
 =?utf-8?B?bXRPOW85SzlzaGswM2UvYUpnaFpVWnJFZ0VoUnhwVjZ4QWtwaEtSaW02MTg0?=
 =?utf-8?B?eHNURExveU15d1NXYmdISGhKYXV6d25VSFN6bzNMajIyandVSUZqQjFHajMr?=
 =?utf-8?B?ZDV0VEVjRnoxQUJVa25iOWpucXhLL3RHdDNlL21FNGZOS21lUTZsU0d3OWtX?=
 =?utf-8?B?QTVwRGpMUGZRNlhCdjBTWmtGYnFFcUhzZ0hxU0x1Y2JHZ1REeVQ2YTdZOW1I?=
 =?utf-8?B?MlhwaG1jOTB6M0ZaWmNhaU5BVFc2RDJ2YzR5SmVmUXpJK1hYcDRTYUlXYm56?=
 =?utf-8?B?RXV6VlZrcVJzVWQ3UURGczY1dnByZm95VE1PREt4Qzg0NVZmWW9UcCsvTEtm?=
 =?utf-8?B?ZCtmUUF0THpSV1ZoK3U2dVR0UjJNOWFRc3JVSDljd0FRc0FjMUtYZksvWUIv?=
 =?utf-8?B?MkZGcGZEYVZIY1BJN1lQb1krTENwSXZVampBZTFSd3JUSWFGTklBVUI3Skpk?=
 =?utf-8?Q?aiStoe8gweaatrhQG7/9M8l7i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29097789-75e5-43a9-5dc0-08dc734dd30b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 13:08:47.2498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eehMoDc+wyP8XGYmJcJ1EBQlm5HziTHtkGiYTjsgS5r0QQ3gYzcPtRsk4JtTWytwi41U1ubVPswrZP3Qz1m8Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9275
Received-SPF: softfail client-ip=2a01:111:f403:2417::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 06/05/2024 12:20, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> This allows to update the Error argument of the VFIO log_global_start()
> handler. Errors detected when device level logging is started will be
> propagated up to qemu_savevm_state_setup() when the ram save_setup()
> handler is executed.

Errors for container based logging will also be propagated now.

>
> The vfio_set_migration_error() call becomes redundant in
> vfio_devices_dma_logging_start(). Remove it.

Becomes redundant in vfio_listener_log_global_start()?

Other than that,
Reviewed-by: Avihai Horon <avihaih@nvidia.com>

>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>
>   Changes in v5:
>
>   - Used error_setg_errno() in vfio_devices_dma_logging_start()
>
>   hw/vfio/common.c | 26 +++++++++++++++-----------
>   1 file changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 485e53916491f1164d29e739fb7106c0c77df737..b5102f54a6474a50c6366e8fbce23812d55e384e 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1027,7 +1027,8 @@ static void vfio_device_feature_dma_logging_start_destroy(
>       g_free(feature);
>   }
>
> -static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer)
> +static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
> +                                          Error **errp)
>   {
>       struct vfio_device_feature *feature;
>       VFIODirtyRanges ranges;
> @@ -1038,6 +1039,7 @@ static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer)
>       feature = vfio_device_feature_dma_logging_start_create(bcontainer,
>                                                              &ranges);
>       if (!feature) {
> +        error_setg_errno(errp, errno, "Failed to prepare DMA logging");
>           return -errno;
>       }
>
> @@ -1049,8 +1051,8 @@ static int vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer)
>           ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
>           if (ret) {
>               ret = -errno;
> -            error_report("%s: Failed to start DMA logging, err %d (%s)",
> -                         vbasedev->name, ret, strerror(errno));
> +            error_setg_errno(errp, errno, "%s: Failed to start DMA logging",
> +                             vbasedev->name);
>               goto out;
>           }
>           vbasedev->dirty_tracking = true;
> @@ -1069,20 +1071,19 @@ out:
>   static bool vfio_listener_log_global_start(MemoryListener *listener,
>                                              Error **errp)
>   {
> +    ERRP_GUARD();
>       VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
>                                                    listener);
>       int ret;
>
>       if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
> -        ret = vfio_devices_dma_logging_start(bcontainer);
> +        ret = vfio_devices_dma_logging_start(bcontainer, errp);
>       } else {
> -        ret = vfio_container_set_dirty_page_tracking(bcontainer, true, NULL);
> +        ret = vfio_container_set_dirty_page_tracking(bcontainer, true, errp);
>       }
>
>       if (ret) {
> -        error_report("vfio: Could not start dirty page tracking, err: %d (%s)",
> -                     ret, strerror(-ret));
> -        vfio_set_migration_error(ret);
> +        error_prepend(errp, "vfio: Could not start dirty page tracking - ");
>       }
>       return !ret;
>   }
> @@ -1091,17 +1092,20 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
>   {
>       VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
>                                                    listener);
> +    Error *local_err = NULL;
>       int ret = 0;
>
>       if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>           vfio_devices_dma_logging_stop(bcontainer);
>       } else {
> -        ret = vfio_container_set_dirty_page_tracking(bcontainer, false, NULL);
> +        ret = vfio_container_set_dirty_page_tracking(bcontainer, false,
> +                                                     &local_err);
>       }
>
>       if (ret) {
> -        error_report("vfio: Could not stop dirty page tracking, err: %d (%s)",
> -                     ret, strerror(-ret));
> +        error_prepend(&local_err,
> +                      "vfio: Could not stop dirty page tracking - ");
> +        error_report_err(local_err);
>           vfio_set_migration_error(ret);
>       }
>   }
> --
> 2.45.0
>

