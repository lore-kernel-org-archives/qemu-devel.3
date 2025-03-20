Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2FFC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 11:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvDqT-0006id-6w; Thu, 20 Mar 2025 07:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tvDqQ-0006iP-Ci
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 07:13:50 -0400
Received: from mail-dm6nam12on20609.outbound.protection.outlook.com
 ([2a01:111:f403:2417::609]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tvDqN-0003Nz-Cb
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 07:13:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3l/2gsnZn1DYuDDAa7ltJ/No/3KXbgoPBrhEu/I5iE3U6eZ4yawg/+V9wRaETRoZe1xaSAXqEOZMYaCBZmLzYdYR+loexfiObEiicelD/IEnv1HK/ihF/bmNWFGRJSid0FfYucyfc0T8cuqRedaDJgSIF8/NHwnZJsCEmFlcuGFEs8/JC7VvaxQTfD8SeXhjP6aelsxMAJPzeXCdS/ua+PGVr7/8HJKjESryGkho5vobc8gqvO03UQ/2/qpTCNgvFlPq1FgxW9H669mjsc/itfqCE0drWyyBDtgROnEefHLX5bRaOPn1ftLbONL6SvOp2Gnnw6jmMec0LT8gmlBcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2hB1asnjkUhjOSZZsRsdbevQX6x0nvwg7EiRH8q0u8=;
 b=lYGT+go1HhoRB9KEYH/QSu79gwMi9e9iHhYIYSzL7jSp2zsTEhVv5SdrXwkHIgIe60YdP39un7z+W8T2oBHjWibTFjirsgBObncSZ4c6Ega7hE2qaTdcD7aSAwN0fKsiZ67PMYOlDRNItgfm6ur2E7dXDtvouvocg/mhk52jVorboju+hwo8Aqh98iP/ikQx/WTrIl6zgmeInln8AzGyY9Xzl72vxIqbeBmi/Bisvey+0lCK/o+LzUxHFZ23FG53KW68wputVM4ZzNVRcXc/E+3yXCSpvsIiUt9KueJ3Icdj22f/ucYwAEGh9eILgQq1nxdVBgZuB8PArgi0yLtjZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2hB1asnjkUhjOSZZsRsdbevQX6x0nvwg7EiRH8q0u8=;
 b=LbfrhgUFB3aCN/PXA2U28gK0v8bOEeaboM0tbcrA/iV1VUAKki2l9pcbsiu9AatU7SftU7dCMpTUhZuozUZgwWvf1Px0DK0+AQhFlexKDsWMxf4vnz60WxFz+XhYXpBje5HdRVeMr8sEIcukCZqvzhjlwXOGlvedW9IudVvk3DUmlb1sGSpighLz567KBufs79eqwrmO4CjPeD98yWfxtnC9BOWB7H/RgMkQsiDP3Uwu7019jqzIkCMQjp85UGdwaaDxJxvRKzKFGZUkijMmCVs3mO83QvTY0lq50P3PB8xTqV5ywnb1t620B+oR7AGXZZJjXQhoFJTWIredkG31SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 11:13:42 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 11:13:42 +0000
Message-ID: <621d6268-ca2d-4028-814c-f4c2ddf5d567@nvidia.com>
Date: Thu, 20 Mar 2025 13:13:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 30/32] vfio: Rename VFIO dirty tracking services
To: Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-31-clg@redhat.com>
 <a6c46117-dc83-4a42-9a5f-0fcffb69b4f2@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <a6c46117-dc83-4a42-9a5f-0fcffb69b4f2@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0285.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::19) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|MN0PR12MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: 59d66bf9-bb6e-4cfb-7728-08dd67a045bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Smc5aUwwUTE5KzdRamFDaERKYkw3ZEZ5bHlBYjVxMnprQzFXODIwR05uakYy?=
 =?utf-8?B?UjRESjNxam0xL3BWT1RxZTFiQjZZODVwWEYweGxQKzdJYXlnZWNWaTEwdENQ?=
 =?utf-8?B?cW5XYWwvSWlyaGRvOHd6NnFtZmRRMGMwR0dlU25OUHZyWVdWa3ZKcGRaNDgw?=
 =?utf-8?B?MG9DOWMyQ0NQbGxxcDdrbUhwczVtUkZXTmVBaGlQemlzVGd5VmtpWHZlaUZI?=
 =?utf-8?B?Yy8zUUs0Q2tWb2liTGcrM09GT2pTWi9nRXluQk1oa2p0YS9RZi9zbW1CanpH?=
 =?utf-8?B?cHdDODdYYWtDSlRybUFUUElMV3pLWVBFdE1JSXJaQldqSlp5bThCV095ejUz?=
 =?utf-8?B?WVBwSndoL1VpWG9HdytsZVZpQjZaZVgwK3pNcWxaOC9BTW1mQjBNaVhXSFFx?=
 =?utf-8?B?cTdQY0xQc0lsSjNoRTlsU2lkNWdBWWZSamdRblJiTUpnU2cwTE83K1BrQmw1?=
 =?utf-8?B?cnBqbXEzL1FzanpPRjYxblVYa3I0M1ZyQlhDNkZrUEt0KzVLWDVpRG50SUgx?=
 =?utf-8?B?eTFjbHhRKzkwSjFVdW1hcGFMcnFRcHZMUU9keVFvNHlOMTkyVk5UQjIrNlRy?=
 =?utf-8?B?NC9KRFhPUDBGeEhsSzZjcWFSRzRxOXAzMzdXNE5iNkt1L2laOWsvaEMwdGZa?=
 =?utf-8?B?OG4vVFJCeTJ0QU9Nd29CSE45ZldQRURQb2M5R3c5YktrUHUrUk9hOGI5Y1BI?=
 =?utf-8?B?NXJ3T1drREgzejc1aHZRczZlYU96VGxRNXhjcG1iTzhyQjdhM20rN1pmcURu?=
 =?utf-8?B?RElHb1RCSVFYZFVhUU1ySHhkN1ZmM2xPeUI3UnlickZDQVNGQU92RFdodnJ1?=
 =?utf-8?B?ZFhiRVUza0tXRWJoZDZmUDBWckoxRmFHdWFLS2N2ME1sN0NqYnB2MnRDeGpC?=
 =?utf-8?B?MEh1ZkMwMTVQVG1BMVRJK0hIcjNpTTY0YmVBaHYxM1NQRSt0MTgyRU1sb1Ex?=
 =?utf-8?B?VVpuL0xkV09SOHBDWGdWM1BNZzNnS2lSSS8vSG1oQ20wcEdaNFVUZTZNUytq?=
 =?utf-8?B?ZlpQcXNKY3lNVzNaOGl5RHFuTEV6dzNRTnlVbHlqZXhDbW8ybGhhcEk5ckgv?=
 =?utf-8?B?NkdsUTJWTzc3VndIVDJJZFU4SnZzeURyY3hxc0d1RFZ2S2VOR3Z3ZUR5SVdZ?=
 =?utf-8?B?WmloQklFMDl5UUJiWkJ4eU1DdmNJelFGOXN1R2RZNkw5c0w4WTdGQm9HNURU?=
 =?utf-8?B?MDQyTWlSak1Jckc0NFRKTlJleWhiUUJxZytGYkt6Q0w2NWpsaFNBUjAwTE1z?=
 =?utf-8?B?UXE2K05OTndXdS9HRXFIMW5OeXdHVW5KTTBiMnJUZm9sQTRvVnBkUEU4UDZE?=
 =?utf-8?B?QTJSUkJGVWcvZ0JWMmVFUjJON1NOb2ZJZWtUbWd1am5MN0NOZkhSbGdoUkJT?=
 =?utf-8?B?RDRWNG5ZWmhFNG9hQ0dGMjNqTG9pOXoxNWozRFI1YmlrWCt0ODZJbHVvUkJS?=
 =?utf-8?B?emc2bC9SZmhxTUlBVkk2U1dRc2FwZ3pYa0EzUkhZRy9UcVI4WDMrRDFqMGN4?=
 =?utf-8?B?ZmUxNmZNZzh5L3o3dVBubmV2SEMvOW9nQ0d0VlZkM1NLR20zVUJYcldaVnFh?=
 =?utf-8?B?TnVNWUhjS1BNU2JFSERRSm5ub2IvaEVYUzBJTU42VklRb0FtWksxSHo0YnM1?=
 =?utf-8?B?RmhGRjRPZHpSUlo2ZHlFZDBRcGNWOHJiQmdYbFljb1ZHR3pOaDRRcmQwRCto?=
 =?utf-8?B?b0tVTUlHaEYyMDBqUWVNdmpZSmdYZTZseUxYTm90TUhqSWRNSnJaVSsrc3Ri?=
 =?utf-8?B?eVFqMWQyKzV3V3ZyY3dna01kQVdyVldTcUcyNjhwWVZpMU1KOUprdnV0dktr?=
 =?utf-8?B?dFdtdHVJVC9XcW9TMkpTWWxwV0VTM1k1bmMxOU5PUXZYMGhpYjVJbGdyTG5j?=
 =?utf-8?Q?NFIcsl7yeIAqH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTFkMVBybnhQQm1jN2w3Q043eHlNWnVaMjFoM2JkZnRVNU4ydUJrdEtxam8v?=
 =?utf-8?B?ZFQwMXNHbk4wY3o4dzkwaXhiQ1B0cGw4bU1nRnBTeW4yVFFmSU1CMHloYktG?=
 =?utf-8?B?UHhwWFpSdjRDbzZMa1dwL0QraWZKUWpwZm9PSS9jN2lmTzhES1FWV096QmJa?=
 =?utf-8?B?WG1mMENpY20xRnNFVjlVRyt5Ym5mcnZhRkV0Ump4Sjd5S096ZlZDK0l2Z2R3?=
 =?utf-8?B?RWhZV25NbERqS1Y1TlVSdHk3eGo4cmZPcC9wUUZZNFdwTkNCOEtUazgwTnpz?=
 =?utf-8?B?eXRYcmRxRmJwdEc2enlsYk4yU21ocTFMU2NUMHJ6enhVQlpLNnhCZXdwOStX?=
 =?utf-8?B?dUdMaEZVTHlRRk1zOVFVMWIxRk9MV2Y1Z1Qra01BM3RCS1lQZCtEOUFJczJv?=
 =?utf-8?B?TjdDdGVPTXphbVI4OVJGQWY4c1RoRGc2NXpPQit1T25ETGlHS215UWUyR3ZX?=
 =?utf-8?B?ejZQMG1YcFYzVlkrOUpBaE9PeUp6OW5GRUVKaWlkbUhwNGlxM2JhZHJmNUZK?=
 =?utf-8?B?V1RFMTkvaTNwNHUvc3NMemN2K3I2NEU1Q3BNVVNPNFVKMVZ6a3ZiSmNiK0FB?=
 =?utf-8?B?ZktEMWNzVGhhek0wb2NFOEFtZW94Z2YrdlRQRmd2cnAvaThWVXpCOXY2Qmpw?=
 =?utf-8?B?NFNtbXg0cnpOLzFsSzhKWitjQnd6aXFrK255TnNwTnRSUlBaRVlMei9oS0xD?=
 =?utf-8?B?OWNVVHNOMVdvRitGbVJ2MXo1S3RxTEN4VnlEeVR4dUxGZndEMzVPTHZJQW4z?=
 =?utf-8?B?bkUxN1V5b3VLN3MvRU5TaXVaSXQ4MXg4VzYzejc4bmNlWmdINkdzaVNNbGky?=
 =?utf-8?B?amFCRVhQcFozOGl4TWR6eDRFdEF5akhLbCsyRjNQdnJLZ2JQaUVXQVBDaDR6?=
 =?utf-8?B?N1BJYjdaeW5tU3dOVmRIZVltU2t4LzBOVm9CWUEzaFZXYWZobndyUU5kdjBy?=
 =?utf-8?B?Y1k3ZDMvOUFicnY1K0VFQy9OSVYvTTgvbGk5TlpLVVA3OVFHR3UwM3hRQzdZ?=
 =?utf-8?B?UGxEWjNDaDlSa0lkU2pFN3FTeXRuTUJBRDlhalJ0amlWRW44cG56Z0JVcGJt?=
 =?utf-8?B?NlFLTWhGdnpCZzdaYjhMTWwwYzlEbkY3bHhVU0NkSGxydDJwU0FtZ3VmSnBM?=
 =?utf-8?B?azBFV1ZaSHpWcjBKdG5WcnVGL0JjNDZETG5mVU1SdHovTmJaNkxBSW1pM0RL?=
 =?utf-8?B?UkZzL0VyT3YyWXd6TURZT2x6aXkzZWlQRC9ORWNvUkk5TnRCeVZ0STQ4Q2h6?=
 =?utf-8?B?SkhJbVJuUWFiQW9QSzZMRVdDQndrV0dyTEw4QWJqcjk3MDVzR1ZaL1QwMS9L?=
 =?utf-8?B?S2JBTUZ0NWUrYTgzV0RFTzZOckJUSW5WSzJTeEdWWjRKNGRoMWNtRzJNaWw0?=
 =?utf-8?B?NWV1T04zMzRRL1lTQmZETklxYVFFU09LamQ2ODhEWnFycis0djFnYkJPQjUy?=
 =?utf-8?B?MDNTaGQ1SHg0NWFmdnQ1NXVOb0dHb29tYmU0ZWNaNklKQUhHeU9kS2VobWJj?=
 =?utf-8?B?RGZwcmN6UEN6dkpWSWNxVkhTaS8rUktJcGhlTjdLeFdDbE4rQ2NZZEcxWkxK?=
 =?utf-8?B?Vld1ZTJMZ00vcU9XK3VLS0tjck5lTlhyTGt6dWN6ZmZkUUdBSU81cERyYUVj?=
 =?utf-8?B?NE1vOFVlTnlzMnBRQm1yN2NVa2JsQmhTOUtFS245QWZncWg1MVB3aGFMc0xP?=
 =?utf-8?B?NHoyRGJYQzlVeXZUaHN0VWl5VVpabUVXdGVmRWg2UEVSVjlGa09ZOFlYSzh2?=
 =?utf-8?B?TDE5UEh3bEU4eXh3R0k1NXoxMk10ZTdDMFdSa3RDUklucnZ3Q2JLbitTZFVZ?=
 =?utf-8?B?eEFINHZRUXN2cnBNU2RWR3RkNFdVZnBaQU9ZN0NlbU1IdDFPWjBHQXV6MEtV?=
 =?utf-8?B?aVYzYlFYTUdrZW5kRGN1N1NQS0ZsZnduVHJ2dkpIYktzL1ZIQWQyUklrWTdi?=
 =?utf-8?B?RnpDZTRZcHRBejB2aC9QL0U4K0xyVEZ4RHhoOXJ5T1BKaVNrdkZ2aHZoZmw5?=
 =?utf-8?B?YTREZ0VSZE5aUVpBMUcrQ2ZTb2pLZGRnbmp4WUhITmFwS1h4Qk84R0EyMHNK?=
 =?utf-8?B?Y2ttaWdYRGdiaVRhYnh2WjRFbU0xQWVaKy9ibDBDYUVTMWlwQ0s0NElteVBT?=
 =?utf-8?Q?dytBV6PcmtwZjpZPVwSys72rc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d66bf9-bb6e-4cfb-7728-08dd67a045bf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 11:13:42.1641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zf6W7upalRaMNvtjKdZ8HPXAgn3p5mG0ylx09UOG/YrpuHtoHSsyYTS1Qdet6GxDz7Ew0uh7OgTMbz0IruLc6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930
Received-SPF: permerror client-ip=2a01:111:f403:2417::609;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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


On 19/03/2025 14:21, Joao Martins wrote:
> External email: Use caution opening links or attachments
>
>
> On 18/03/2025 09:54, Cédric Le Goater wrote:
>> Rename these routines :
>>
>>    vfio_devices_all_device_dirty_tracking_started -> vfio_dirty_tracking_devices_is_started_all
>>    vfio_devices_all_dirty_tracking_started        -> vfio_dirty_tracking_devices_is_started
>>    vfio_devices_all_device_dirty_tracking         -> vfio_dirty_tracking_devices_is_supported
>>    vfio_devices_dma_logging_start                 -> vfio_dirty_tracking_devices_dma_logging_start
>>    vfio_devices_dma_logging_stop                  -> vfio_dirty_tracking_devices_dma_logging_stop
>>    vfio_devices_query_dirty_bitmap                -> vfio_dirty_tracking_devices_query_dirty_bitmap
>>    vfio_get_dirty_bitmap                          -> vfio_dirty_tracking_query_dirty_bitmap
>>
>> to better reflect the namespace they belong to.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> The change itself is fine.
>
> But on the other hand, it looks relatively long names, no? I am bit at two minds
> (as I generally prefer shorter code), but I can't find any alternatives if you
> really wanna have one namespaces associated with the subsystem:file as a C
> namespace.
>
> Every once and a while me and Avihai use the acronym DPT (Dirty Page Tracking)
> when talking about this stuff, but it seems a detour from the code style to
> abbreviate namespaces into acronyms.
>
> Having said that:
>
>          Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
>
> P.S. We could also remove 'devices' as the prefix for VF dirty tracking after
> namespace, and thus drop 'dma logging'. That should put 'start/stop' a little
> shorter.

This file is not related only to dirty tracking, but to memory in general.
Maybe a better naming would be memory.{c,h}?
Then we can have vfio_memory_* or vfio_mem_* prefix and rename to the below:

vfio_devices_all_device_dirty_tracking_started -> 
vfio_mem_device_dpt_is_started
vfio_devices_all_dirty_tracking_started        -> vfio_mem_dpt_is_started
vfio_devices_all_device_dirty_tracking         -> 
vfio_mem_device_dpt_is_supported
vfio_devices_dma_logging_start                 -> vfio_mem_device_dpt_start
vfio_devices_dma_logging_stop                  -> vfio_mem_device_dpt_stop
vfio_devices_query_dirty_bitmap                -> vfio_mem_device_dpt_query
vfio_get_dirty_bitmap                          -> vfio_mem_dpt_query

dpt can be changed to dirty_tracking if that's clearer and not too long.
In patch #31 we can rename to vfio_mem_{register,unregister} or 
vfio_mem_listener_{register,unregister}.
More internal functions can be gradually renamed and added the 
vfio_mem_* prefix.

Will that work?

Thanks.

>> ---
>>   hw/vfio/dirty-tracking.h |  6 +++---
>>   hw/vfio/container.c      |  6 +++---
>>   hw/vfio/dirty-tracking.c | 44 ++++++++++++++++++++--------------------
>>   hw/vfio/trace-events     |  2 +-
>>   4 files changed, 29 insertions(+), 29 deletions(-)
>>
>> diff --git a/hw/vfio/dirty-tracking.h b/hw/vfio/dirty-tracking.h
>> index 322af30b0d5370600719594d4aed4c407f7d2295..db9494202a780108ce78b642950bfed78ba3f253 100644
>> --- a/hw/vfio/dirty-tracking.h
>> +++ b/hw/vfio/dirty-tracking.h
>> @@ -11,9 +11,9 @@
>>
>>   extern const MemoryListener vfio_memory_listener;
>>
>> -bool vfio_devices_all_dirty_tracking_started(const VFIOContainerBase *bcontainer);
>> -bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
>> -int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>> +bool vfio_dirty_tracking_devices_is_started(const VFIOContainerBase *bcontainer);
>> +bool vfio_dirty_tracking_devices_is_supported(const VFIOContainerBase *bcontainer);
>> +int vfio_dirty_tracking_query_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>>                             uint64_t size, ram_addr_t ram_addr, Error **errp);
>>
>>   #endif /* HW_VFIO_DIRTY_TRACKING_H */
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 40d6c1fecbf9c37c22b8c19f8e9e8b6c5c381249..7b3ec798a77052b8cb0b47d3dceaca1428cb50bd 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -138,8 +138,8 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>>       int ret;
>>       Error *local_err = NULL;
>>
>> -    if (iotlb && vfio_devices_all_dirty_tracking_started(bcontainer)) {
>> -        if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
>> +    if (iotlb && vfio_dirty_tracking_devices_is_started(bcontainer)) {
>> +        if (!vfio_dirty_tracking_devices_is_supported(bcontainer) &&
>>               bcontainer->dirty_pages_supported) {
>>               return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
>>           }
>> @@ -170,7 +170,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>>       }
>>
>>       if (need_dirty_sync) {
>> -        ret = vfio_get_dirty_bitmap(bcontainer, iova, size,
>> +        ret = vfio_dirty_tracking_query_dirty_bitmap(bcontainer, iova, size,
>>                                       iotlb->translated_addr, &local_err);
>>           if (ret) {
>>               error_report_err(local_err);
>> diff --git a/hw/vfio/dirty-tracking.c b/hw/vfio/dirty-tracking.c
>> index 9b20668a6d0df93a2cfde12d9a5cd7c223ae3ca1..8e47ccbb9aea748e57271508ddcd10e394abf16c 100644
>> --- a/hw/vfio/dirty-tracking.c
>> +++ b/hw/vfio/dirty-tracking.c
>> @@ -45,7 +45,7 @@
>>    * Device state interfaces
>>    */
>>
>> -static bool vfio_devices_all_device_dirty_tracking_started(
>> +static bool vfio_dirty_tracking_devices_is_started_all(
>>       const VFIOContainerBase *bcontainer)
>>   {
>>       VFIODevice *vbasedev;
>> @@ -59,10 +59,9 @@ static bool vfio_devices_all_device_dirty_tracking_started(
>>       return true;
>>   }
>>
>> -bool vfio_devices_all_dirty_tracking_started(
>> -    const VFIOContainerBase *bcontainer)
>> +bool vfio_dirty_tracking_devices_is_started(const VFIOContainerBase *bcontainer)
>>   {
>> -    return vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
>> +    return vfio_dirty_tracking_devices_is_started_all(bcontainer) ||
>>              bcontainer->dirty_pages_started;
>>   }
>>
>> @@ -70,7 +69,7 @@ static bool vfio_log_sync_needed(const VFIOContainerBase *bcontainer)
>>   {
>>       VFIODevice *vbasedev;
>>
>> -    if (!vfio_devices_all_dirty_tracking_started(bcontainer)) {
>> +    if (!vfio_dirty_tracking_devices_is_started(bcontainer)) {
>>           return false;
>>       }
>>
>> @@ -90,7 +89,7 @@ static bool vfio_log_sync_needed(const VFIOContainerBase *bcontainer)
>>       return true;
>>   }
>>
>> -bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer)
>> +bool vfio_dirty_tracking_devices_is_supported(const VFIOContainerBase *bcontainer)
>>   {
>>       VFIODevice *vbasedev;
>>
>> @@ -809,7 +808,7 @@ static void vfio_dirty_tracking_init(VFIOContainerBase *bcontainer,
>>       memory_listener_unregister(&dirty.listener);
>>   }
>>
>> -static void vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
>> +static void vfio_dirty_tracking_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
>>   {
>>       uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
>>                                 sizeof(uint64_t))] = {};
>> @@ -907,7 +906,7 @@ static void vfio_device_feature_dma_logging_start_destroy(
>>       g_free(feature);
>>   }
>>
>> -static bool vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
>> +static bool vfio_dirty_tracking_devices_dma_logging_start(VFIOContainerBase *bcontainer,
>>                                             Error **errp)
>>   {
>>       struct vfio_device_feature *feature;
>> @@ -940,7 +939,7 @@ static bool vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
>>
>>   out:
>>       if (ret) {
>> -        vfio_devices_dma_logging_stop(bcontainer);
>> +        vfio_dirty_tracking_devices_dma_logging_stop(bcontainer);
>>       }
>>
>>       vfio_device_feature_dma_logging_start_destroy(feature);
>> @@ -956,8 +955,8 @@ static bool vfio_listener_log_global_start(MemoryListener *listener,
>>                                                    listener);
>>       bool ret;
>>
>> -    if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>> -        ret = vfio_devices_dma_logging_start(bcontainer, errp);
>> +    if (vfio_dirty_tracking_devices_is_supported(bcontainer)) {
>> +        ret = vfio_dirty_tracking_devices_dma_logging_start(bcontainer, errp);
>>       } else {
>>           ret = vfio_container_set_dirty_page_tracking(bcontainer, true, errp) == 0;
>>       }
>> @@ -975,8 +974,8 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
>>       Error *local_err = NULL;
>>       int ret = 0;
>>
>> -    if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>> -        vfio_devices_dma_logging_stop(bcontainer);
>> +    if (vfio_dirty_tracking_devices_is_supported(bcontainer)) {
>> +        vfio_dirty_tracking_devices_dma_logging_stop(bcontainer);
>>       } else {
>>           ret = vfio_container_set_dirty_page_tracking(bcontainer, false,
>>                                                        &local_err);
>> @@ -1016,7 +1015,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
>>       return 0;
>>   }
>>
>> -static int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>> +static int vfio_dirty_tracking_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>>                    VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
>>   {
>>       VFIODevice *vbasedev;
>> @@ -1038,11 +1037,11 @@ static int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>>       return 0;
>>   }
>>
>> -int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>> +int vfio_dirty_tracking_query_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>>                             uint64_t size, ram_addr_t ram_addr, Error **errp)
>>   {
>>       bool all_device_dirty_tracking =
>> -        vfio_devices_all_device_dirty_tracking(bcontainer);
>> +        vfio_dirty_tracking_devices_is_supported(bcontainer);
>>       uint64_t dirty_pages;
>>       VFIOBitmap vbmap;
>>       int ret;
>> @@ -1062,8 +1061,8 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>>       }
>>
>>       if (all_device_dirty_tracking) {
>> -        ret = vfio_devices_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
>> -                                              errp);
>> +        ret = vfio_dirty_tracking_devices_query_dirty_bitmap(bcontainer, &vbmap,
>> +                                                             iova, size, errp);
>>       } else {
>>           ret = vfio_container_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
>>                                                   errp);
>> @@ -1076,7 +1075,8 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>>       dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
>>                                                            vbmap.pages);
>>
>> -    trace_vfio_get_dirty_bitmap(iova, size, vbmap.size, ram_addr, dirty_pages);
>> +    trace_vfio_dirty_tracking_query_dirty_bitmap(iova, size, vbmap.size, ram_addr,
>> +                                                 dirty_pages);
>>   out:
>>       g_free(vbmap.bitmap);
>>
>> @@ -1113,7 +1113,7 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>           goto out_unlock;
>>       }
>>
>> -    ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
>> +    ret = vfio_dirty_tracking_query_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
>>                                   translated_addr, &local_err);
>>       if (ret) {
>>           error_prepend(&local_err,
>> @@ -1147,7 +1147,7 @@ static int vfio_ram_discard_get_dirty_bitmap(MemoryRegionSection *section,
>>        * Sync the whole mapped region (spanning multiple individual mappings)
>>        * in one go.
>>        */
>> -    ret = vfio_get_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr,
>> +    ret = vfio_dirty_tracking_query_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr,
>>                                   &local_err);
>>       if (ret) {
>>           error_report_err(local_err);
>> @@ -1241,7 +1241,7 @@ static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
>>       ram_addr = memory_region_get_ram_addr(section->mr) +
>>                  section->offset_within_region;
>>
>> -    return vfio_get_dirty_bitmap(bcontainer,
>> +    return vfio_dirty_tracking_query_dirty_bitmap(bcontainer,
>>                      REAL_HOST_PAGE_ALIGN(section->offset_within_address_space),
>>                                    int128_get64(section->size), ram_addr, errp);
>>   }
>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index 512f4913b72d9a1e8a04df24318a4947fa361e28..6cf8ec3530c68e7528eefa80b7c8ecb401319f88 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -100,7 +100,7 @@ vfio_listener_region_del(uint64_t start, uint64_t end) "region_del 0x%"PRIx64" -
>>   vfio_device_dirty_tracking_update(uint64_t start, uint64_t end, uint64_t min, uint64_t max) "section 0x%"PRIx64" - 0x%"PRIx64" -> update [0x%"PRIx64" - 0x%"PRIx64"]"
>>   vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t max32, uint64_t min64, uint64_t max64, uint64_t minpci, uint64_t maxpci) "nr_ranges %d 32:[0x%"PRIx64" - 0x%"PRIx64"], 64:[0x%"PRIx64" - 0x%"PRIx64"], pci64:[0x%"PRIx64" - 0x%"PRIx64"]"
>>   vfio_legacy_dma_unmap_overflow_workaround(void) ""
>> -vfio_get_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
>> +vfio_dirty_tracking_query_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
>>   vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
>>
>>   # region.c

