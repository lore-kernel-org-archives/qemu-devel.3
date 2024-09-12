Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8BFEEB561
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 08:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sofA0-0007WI-Ri; Thu, 12 Sep 2024 04:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1sof9z-0007O9-MW
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:26:39 -0400
Received: from mail-mw2nam12on2062c.outbound.protection.outlook.com
 ([2a01:111:f403:200a::62c]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1sof9w-0006f6-C2
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:26:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyXgTWjD6UTKNT2GmlZL6IjuNOlXsDGxp20JPh6UklQum/SuBEBIxN7fKS2edGfx9QSo+DnAO6BS4oUv+QAUFxjymYC1cY7xKTH4MI4hBK/tlrh4YGVLZFN++Cs6QsLkXqf3EDCrOhrOCb3UQaZgedwr9FNwMV9hdwiKcPqJO3zAXldzdQy+36gls7+9mQQ8I2JQ55tq+x10ATkGU8iJ+DFZKxuiQBbu5LYLNVtuhIhC5ZuPq0c2cE6mr1FhgTyIzFRwrQioneGki9nV1luOXuysiXgjlaCUzZArTm+sqbPohJEwMSykRvDXYy2JFN63LRr/F/ReINS9xQYQrMOAuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjcrx/fJLv17+oTN/d6T7kgjgMRJRb6o5ijzYowSjo0=;
 b=xR0UDmMMMM1cdqmhbx5JZXLNyGhRwllBkLG4K+sFIFsBnRt2MeB0fCr97FtI5tYk8A9TZiSM8Diy+ZX0LqHhcrUB7fu15i+qYedaDFJFL5bq7pJkHnU17VkSSDOZG8VTC7l64JWfewaHck0qNIEgx3GLeXzxdObRJss+mDJOEodPUSEx3DNAF2Pw5Dyf/b8jb0sOP9KtC2wABTGjOoNcsBo+yFl6h73WOxRU9YeXORXpqwmqEXMwqehZZzh3Mvg2N93n3Hmgsr46WQbDJje5RySX30FRfSZ2HuQ6AiEA6hGw7Vhin2gikBVDFaRVS3SuHuP2rjhDdpRRZgKoigKj4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjcrx/fJLv17+oTN/d6T7kgjgMRJRb6o5ijzYowSjo0=;
 b=b+r/ohs5gyw4QokepI0Dfz/CWyp82ckLrODDUJsiHhlKU5Eh2jh2eZGEDYeIYf7myyIx6Wbbc63kujjTKkDy3kGHPCmabZcGR9pyiN0X/93Y53pFgkoCkEaiVXSXEsoogJuLVU16eFeuGR0rfqAdqctrtS5G6vz8dzoF57Duh97jAIvLsRqvrtdwQ00RjXM+TiB9MksQYDIyg91LMwv9ZztkEQXKQnv2K7IJ5RhStRWLb9KN+5K7D0A57AhqqGFEusdCGBG6olO3ooPbHyH9NeFerFGdiRt1fKnbuKMDgZf+NOtveLW1uItrJ86YGZMozH434FZsbPx+xve47D/lWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 08:26:27 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.7962.017; Thu, 12 Sep 2024
 08:26:27 +0000
Message-ID: <9d3d7002-a15a-4c24-8ffb-de3de03b65eb@nvidia.com>
Date: Thu, 12 Sep 2024 11:26:20 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/17] vfio/migration: Multifd device state transfer
 support - send side
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <1429fc59079d99ca035b31303892d807868dc6c0.1724701542.git.maciej.szmigiero@oracle.com>
 <d801c59f-60da-4d42-ae0f-c70d99c45990@nvidia.com>
 <a7cd0a2f-6dba-4fec-b63b-b7985e01608b@maciej.szmigiero.name>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <a7cd0a2f-6dba-4fec-b63b-b7985e01608b@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::19) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DM6PR12MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2f14cb-0bca-43bb-30ea-08dcd304984d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MlZieFBZaDBORWJoK1REbVM2bnV6RnNuV2RZSkVUSnJaMkJPV0h1RUgvdjlL?=
 =?utf-8?B?cmpudU84eGZxVXpMbDJ5RUZqSE1RZmZCdUp2V252dHczbW5naUN2a1NrYUFW?=
 =?utf-8?B?azBZNldkRjNLanZTQnl3c013YnZIV3ZzTkJ3M2JWTElWTHBOdmdqNXVYTDBE?=
 =?utf-8?B?eWozL1NVbVQ0QUd4eUhXQXNheEgxdm5YUVN3c1VML21nRFhjZWlyNVZWeUZn?=
 =?utf-8?B?c3dRak1wS1FXakVFbk0vM2lPZkkwLytoM25xc0NyMGg5T2pOVDY3RWFKbnlu?=
 =?utf-8?B?RlBrWWswK0ttK0MvekYxQTQzT0FMaC9IVVBRR1d6WmZuZlpHYWVmZVgwc01l?=
 =?utf-8?B?eWtRS1lOb2c2MTJ6aG16VTdDTzYrbmxGQll4bmRJZExSRmhlOXFxK2FnT1Jm?=
 =?utf-8?B?ck5XbDVZdEtXMGljWW4wSFBNdFVKSVNQWHliRjVMTGZrdDI0MHE2VW5JNFN6?=
 =?utf-8?B?K3ZzajlRUWtWSlk1YlEzdStmSy9TeFUrbGJPeUU3MXc1Sm1vRTlkMGxGMUln?=
 =?utf-8?B?d3ZzZVBvMVFlL3BWd3A2aXZmcXpBUklBNGtTTjFPR2dJYnBJYkxwNk5rWUUy?=
 =?utf-8?B?bHpNU3FOdVRjK2JjVEZnZ2VaZUpvOW5nTkN0azF0bGFQcG52cElyNEVTa3Uz?=
 =?utf-8?B?MUx0S0l3ekRPVGszMUp0QXMzZXJqa29nUklwdzVxZm1keXk5R3Z0MHd5RWxY?=
 =?utf-8?B?TUt2YTJ2c0VxMjVPQXdydVhVcmhEeU1hdFN3Wk0rUldONXZOUXpjblo0VEVl?=
 =?utf-8?B?UzRvMkQ1YTBiSXd0YVN5ZHA0bFl2NnhxODVzQ0sxZ2pNR1JjajBoZVMxdTRK?=
 =?utf-8?B?dWU5RnFtbVgvNEoxZ2x2K084ZkpabHhlR0l0TFBjTHhrVEQ5MTlhMU5GajJF?=
 =?utf-8?B?OHBJNnV4TkJiUnBCYWVrVlVJbTdQUHpQdVR0TzdlL3pyQUd0RXA0OWVZdTBy?=
 =?utf-8?B?ZWhGY0ZWNXpjcThFVGFQcGxoZ3JVTk9RYmlKcXh2U1pjbS9kdVI3YlZJRWt2?=
 =?utf-8?B?eTdBMTBEeVN3K2F1UXFvVnJIbEptMW1iMy9SQ3RzRi9ZYlZyZXlPbUU3OEdx?=
 =?utf-8?B?SC9XL1h0Vk1KUVpGUVA4cFBJOW00Qm1HNFYzalJOblFxNGlJbVcwTWd5cXZh?=
 =?utf-8?B?UzNWUysyTW9wNkpyWHd4OG5FY0dHUS9rZ2hid0V0U2dZZmNHQlZrcEMweTNT?=
 =?utf-8?B?UjR2NFc1Z0JrVCtLRHNsU2F2OWdZdlJpWXFDMFl4UERDMUJNUTVvT3ZON0JC?=
 =?utf-8?B?UHFLSzdORGZuckRoczBEeXpJYzNydGM2cmxxaDgrUENPaU1ESTlvdloxdEVG?=
 =?utf-8?B?WmZlSjJZbzJyYVQzREhCdUhHVHQ0aCtiem54bVFBSmxreGNxTHF2dXE4ZjR5?=
 =?utf-8?B?U0VaNE82OVJtKzNLNEpPemJFYzNXU05sQ1R3b29Cb0IzZElocERlblBMeE1V?=
 =?utf-8?B?bnNqZ1BUdmRZNDFBaGFiWDI5R28wK2JDTjQ3ZUJmMkpXM0RTenlQUzFsWkpD?=
 =?utf-8?B?NWZveWh4WG9oMFhHMndxbUVsOXpDb1ptZzUrMHZnLzdEaVZKMzF2a1gvZllC?=
 =?utf-8?B?TG9VTVArRHZQSXhXY2wwaGZkUVNMU3UvTFI1UURnemRoVThvWkFOU0diN0lk?=
 =?utf-8?B?cnIxMXhlSDc2clJybDFQa1FScDZTUm5mYnFybjd4Wnlldnc2K1lZVWtmaFBO?=
 =?utf-8?B?M1VIU2JPVUVnMHJzWnZFQmhvM2hMT2w3cldlZjhINUdtb25iODBsaENqL3kw?=
 =?utf-8?Q?75t2gCFqwcLcQEbEtk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG94eC9JOG1CSUhDeG9FMXI0Q0MzY0JENW15WWhwTmtuc1ZtbDVwdlMvNXhK?=
 =?utf-8?B?c2Uyc0NmU00yUEx2RVUwdk9XbURUc1BvemNtalhNbk9IdEpsMzhSMW1naTha?=
 =?utf-8?B?OVV1TDZCZmFYT2tibUIzcms3SGtNdFJvcElVVDFMZVdGaFdkZVhhWUczOXdO?=
 =?utf-8?B?d3RUUWZUbENsR216Snh6azVqRHlqUFNSSi9XNlNSYUU1VTFRRVNobUVETkRo?=
 =?utf-8?B?Q3ljMzU0TGdRa1lISCtFSUYxdURVd0FIY2c3ais4Z2FlcnVkUzhiSjBKV3R0?=
 =?utf-8?B?bzVKUjRLa29oYkxTYzJzVVZLbEpmVWFHVFFWU2JDemc0bW5YcStpRFdabWVr?=
 =?utf-8?B?U0wwRGJMQ3JySHBYZDZUZ0hXNkFnSU9YWjd2eTJ4eHBuNlRmbXdXaFIzUTVr?=
 =?utf-8?B?Wlp6ZlRaTUJBSTFQTHZFajNzSjlQR2RFMVk2THh0OVk3cWFoN2xnTEdPbmpu?=
 =?utf-8?B?NGN0ZWVGbW5KZE40QzlMNmRGL0lVYzlMT0JEQlRYblBrRFhEaTM0bVJhTnJP?=
 =?utf-8?B?V0xXU2dtUlpNL2J4cDBRb0FpNHMzb3dJdGZSRWlqa3k1dDhHS1Z6djhYbnZj?=
 =?utf-8?B?YkQ3ZXppZ3pDYnJscHNpK1ZBK1prVndmZWJqVTZJVktqLytIZG5lR3Q5RkE2?=
 =?utf-8?B?czh6Ykh6MklNRGtkaGFzbHNoWmVGZytTdVpsbVc0Q0JWaXFHaC9QLzNJa05m?=
 =?utf-8?B?UERNVTlNVDBHWnIzaERFUXFFNW52WlAvd2oxMEd0dmk1MmdiL081dGxhQVBa?=
 =?utf-8?B?MnBvczRnd1owZEJER25UTFJPbnlsanUxbzRYcVh3V3lHVktFNGMzRVRvdXlT?=
 =?utf-8?B?b2phRzQ4YzJ4SEk5SmI3MFRZU3pyVkcrekc4RzVaeFZtb2s1WUNEQlBvVmd0?=
 =?utf-8?B?RkIxRlJqMWdSVTQwMlpNWTlIWGtyYVNCMGtuaE80UUtYMk9ZT2VlRGpPeldR?=
 =?utf-8?B?UUxkb0lRWmIrM2REU0tpMmFOUG5tUDcyUm1VaFpqZ3FlalVrVHhRelVtRzdi?=
 =?utf-8?B?UTkwZ1c0aUtDOE9ZajhSVHlONzRUL2laOGs5YXR1M0h0alRqZEY4UEVydEF1?=
 =?utf-8?B?QitETHQ2dFFoZ3VHZlFDemRDMlFHR2dZZE9HU0tVOEE2M3EvV3pwdlNHd08x?=
 =?utf-8?B?cTlad2VGWE9MQ1dCVmtEWFM4YmVid2dnbFUzeVdlNG54QjJFbDB6NUVRQWx4?=
 =?utf-8?B?czdlVVlVYkJDQ2NoL1RFaStwM2pOa2pBVngxZGdDbS9GUXdyNHVVZEw5Z1E5?=
 =?utf-8?B?NUNacCtza3Z2R1dWTDM5UmRjMVpPWnZXTHpBRWxpY09uaHc1NDc4NEJ6a2xw?=
 =?utf-8?B?bXFlZGRSdHFQZmhaazQ0dXBQK1VXN1E0WE5qNjNLT0FmdXZ3S05JUmQzWnNz?=
 =?utf-8?B?bGtZN2lrRFBZN2x6NkdxbXZWNkFYeUNDMmdCRW1FUktkRENIT0lZTU4xb2VG?=
 =?utf-8?B?dGlTYnRPWmQ0a2VHQWJZbjEyenpPblo0NWhxWXRJalcrSU1USStzL3MwbzI0?=
 =?utf-8?B?aXNrRUNPYXJINGRDQUpWdmFhZDB4c3l6czJjVUx5eU9NM0dxMms1MVlYZ2tQ?=
 =?utf-8?B?T1pST3NCVjE4OXoyWUJHL1FONlMwMk05UnFIeitrdEpRME03bXY2eEVuUDZ1?=
 =?utf-8?B?TkJDSnM2SDVNRVh5b0V1WnIrcHFuQVJCUWVYZXl1ZW11QXIyZjlEYldGaVN4?=
 =?utf-8?B?bHhFaDFZblN2TkhSaXVER2dTNCtUaTBhTHlIUnRDL1hJYnRUbmgwY09Zdzdp?=
 =?utf-8?B?OER1VHZBdTdGZkYxNTY1ZnlldXdLZUtTdU5QTndKb1l0WkRHYUtWdHlUakdv?=
 =?utf-8?B?V1ZXN2ViY2FIVklUVXhlOTI3TmwySWtrL0wyRkdkejcyc3I5OUU5RDRDem92?=
 =?utf-8?B?L1V0M3g1QkgvVUZ4bjIzRnQ0MXZrQitpYnVmMk5renpMeWlZWkZMbmQyTU1X?=
 =?utf-8?B?Q2hYQmtvZHgvNS9pdEF1WGFuNkc0emVKb2Q3WGQzL1pxVmZkd05Ua3k3ZDMz?=
 =?utf-8?B?cTZ2S3l0THhYQWNOS2U3blN4Z0pnSFBvWEFNbmhNTkVuNlpxTU5iellkazhE?=
 =?utf-8?B?NGpibFVwMGd0MXE2b2U2MmFhQy9IdVpQdmJRNEcweVNNTDZYLzBiUzFORDRE?=
 =?utf-8?Q?pUQyhiUmvF6DQ7YnouR9XmO5y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2f14cb-0bca-43bb-30ea-08dcd304984d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 08:26:27.0584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9ERmZ3QtEa+SHKRHCxlkVYF6whuiAqtWYC54L1OR5N60Yfdo0MacTwN+NbFuGAGVRsGkTUf0TIgn2OlDBLxjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372
Received-SPF: softfail client-ip=2a01:111:f403:200a::62c;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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


On 09/09/2024 21:07, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> On 9.09.2024 13:41, Avihai Horon wrote:
>>
>> On 27/08/2024 20:54, Maciej S. Szmigiero wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> Implement the multifd device state transfer via additional per-device
>>> thread inside save_live_complete_precopy_thread handler.
>>>
>>> Switch between doing the data transfer in the new handler and doing it
>>> in the old save_state handler depending on the
>>> x-migration-multifd-transfer device property value.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>> ---
>>>   hw/vfio/migration.c           | 169 
>>> ++++++++++++++++++++++++++++++++++
>>>   hw/vfio/trace-events          |   2 +
>>>   include/hw/vfio/vfio-common.h |   1 +
>>>   3 files changed, 172 insertions(+)
>>>
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index 57c1542528dc..67996aa2df8b 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -655,6 +655,16 @@ static int vfio_save_setup(QEMUFile *f, void 
>>> *opaque, Error **errp)
>>>       uint64_t stop_copy_size = VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE;
>>>       int ret;
>>>
>>> +    /* Make a copy of this setting at the start in case it is 
>>> changed mid-migration */
>>> +    migration->multifd_transfer = 
>>> vbasedev->migration_multifd_transfer;
>>
>> Should VFIO multifd be controlled by main migration multifd 
>> capability, and let the per VFIO device migration_multifd_transfer 
>> property be immutable and enabled by default?
>> Then we would have a single point of configuration (and an extra one 
>> per VFIO device just to disable for backward compatibility).
>> Unless there are other benefits to have this property configurable?
>
> We want multifd device state transfer property to be configurable 
> per-device
> in case in the future we add another device type (besides VFIO) that 
> supports
> multifd device state transfer.
>
> In this case, we might need to enable the multifd device state 
> transfer just
> for VFIO devices, but not for this new device type when we are 
> migrating to a
> QEMU target that supports just the VFIO multifd device state transfer.

I think for this case we can use hw/core/machine.c:hw_compat_X_Y arrays [1].

[1] 
https://www.qemu.org/docs/master/devel/migration/compatibility.html#how-backwards-compatibility-works

>
> TBH, I'm not opposed to adding a additional global multifd device 
> state transfer
> switch (if we keep the per-device ones too) but I am not sure what 
> value it adds.
>
>>> +
>>> +    if (migration->multifd_transfer && 
>>> !migration_has_device_state_support()) {
>>> +        error_setg(errp,
>>> +                   "%s: Multifd device transfer requested but 
>>> unsupported in the current config",
>>> +                   vbasedev->name);
>>> +        return -EINVAL;
>>> +    }
>>> +
>>>       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_SETUP_STATE);
>>>
>>>       vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
>>> @@ -835,10 +845,20 @@ static int vfio_save_iterate(QEMUFile *f, void 
>>> *opaque)
>>>   static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>>>   {
>>>       VFIODevice *vbasedev = opaque;
>>> +    VFIOMigration *migration = vbasedev->migration;
>>>       ssize_t data_size;
>>>       int ret;
>>>       Error *local_err = NULL;
>>>
>>> +    if (migration->multifd_transfer) {
>>> +        /*
>>> +         * Emit dummy NOP data, vfio_save_complete_precopy_thread()
>>> +         * does the actual transfer.
>>> +         */
>>> +        qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>>
>> There are three places where we send this dummy end of state, maybe 
>> worth extracting it to a helper? I.e., vfio_send_end_of_state() and 
>> then document there the rationale.
>
> I'm not totally against it but it's wrapping just a single line of 
> code in
> a separate function?

Yes, it's more for self-documentation purpose and for not duplicating 
comments.
I guess it's a matter of taste, so we can go either way and let 
maintainer decide.

>
>>> +        return 0;
>>> +    }
>>> +
>>> trace_vfio_save_complete_precopy_started(vbasedev->name);
>>>
>>>       /* We reach here with device state STOP or STOP_COPY only */
>>> @@ -864,12 +884,159 @@ static int 
>>> vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>>>       return ret;
>>>   }
>>>
>>> +static int 
>>> vfio_save_complete_precopy_async_thread_config_state(VFIODevice 
>>> *vbasedev,
>>> +                                                                
>>> char *idstr,
>>> + uint32_t instance_id,
>>> + uint32_t idx)
>>> +{
>>> +    g_autoptr(QIOChannelBuffer) bioc = NULL;
>>> +    QEMUFile *f = NULL;
>>> +    int ret;
>>> +    g_autofree VFIODeviceStatePacket *packet = NULL;
>>> +    size_t packet_len;
>>> +
>>> +    bioc = qio_channel_buffer_new(0);
>>> +    qio_channel_set_name(QIO_CHANNEL(bioc), 
>>> "vfio-device-config-save");
>>> +
>>> +    f = qemu_file_new_output(QIO_CHANNEL(bioc));
>>> +
>>> +    ret = vfio_save_device_config_state(f, vbasedev, NULL);
>>> +    if (ret) {
>>> +        return ret;
>>
>> Need to close f in this case.
>
> Right - by the way, that's a good example why RAII
> helps avoid such mistakes.

Agreed :)

>
>>> +    }
>>> +
>>> +    ret = qemu_fflush(f);
>>> +    if (ret) {
>>> +        goto ret_close_file;
>>> +    }
>>> +
>>> +    packet_len = sizeof(*packet) + bioc->usage;
>>> +    packet = g_malloc0(packet_len);
>>> +    packet->idx = idx;
>>> +    packet->flags = VFIO_DEVICE_STATE_CONFIG_STATE;
>>> +    memcpy(&packet->data, bioc->data, bioc->usage);
>>> +
>>> +    if (!multifd_queue_device_state(idstr, instance_id,
>>> +                                    (char *)packet, packet_len)) {
>>> +        ret = -1;
>>
>> goto ret_close_file?
>
> Right, it would be better not to increment the counter in this case.
>
>>> +    }
>>> +
>>> +    bytes_transferred += packet_len;
>>
>> bytes_transferred is a global variable. Now that we access it from 
>> multiple threads it should be protected.
>
> Right, this stat needs some concurrent access protection.
>
>> Note that now the VFIO device data is reported also in multifd stats 
>> (if I am not mistaken), is this the behavior we want? Maybe we should 
>> enhance multifd stats to distinguish between RAM data and device data?
>
> Multifd stats report total size of data transferred via multifd so
> they should include device state too.

Yes I agree. But now we are reporting double the amount of VFIO data 
that we actually transfer (once in "vfio device transferred" and another 
in multifd stats) and this may be misleading.
So maybe we should add a dedicated multifd device state counter and 
report VFIO multifd bytes there instead of in bytes_transferred?
We can wait for other people's opinion about that.

>
> It may make sense to add a dedicated device state transfer counter
> at some time though.
>
>>> +
>>> +ret_close_file:
>>
>> Rename to "out" as we only have one exit point?
>>
>>> +    g_clear_pointer(&f, qemu_fclose);
>>
>> f is a local variable, wouldn't qemu_fclose(f) be enough here?
>
> Sure, but why leave a dangling pointer?
>
> Currently, it is obviously a NOP (probably deleted by dead store
> elimination anyway) but the code might get refactored at some point
> and I think it's good practice to always NULL pointers after freeing
> them where possible and so be on the safe side.

Ack.

Thanks.


