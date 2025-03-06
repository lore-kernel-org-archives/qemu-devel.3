Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1ABC28B23
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqC8D-0005oL-Fr; Thu, 06 Mar 2025 09:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tqC88-0005ZL-7A
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:23:21 -0500
Received: from mail-dm6nam10on2062e.outbound.protection.outlook.com
 ([2a01:111:f403:2413::62e]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tqC85-0002hn-F1
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:23:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQeCxSsZC8r0IA0XnYKlG5A1AclOiJDKYjB9I/K+UXeEfKWDw9Ezx2jEC+Ol7YJR+ekQyrKt+9SdYGDeWZNvYobhXjCeAh7nbGCgW7yGVbC1T2hGb8s9VhaSvVDW2920XOR8RNmjsKlguf8FFmrfVbsGnljqJ+HMl3OuOdZbtM/B7Tvf7UFT3mx8TXjaI+qMzBHwLRlydWowYwX70hppEIYpU63mm/lSpccWAEPoDPhQOde2fxpPoQrcvPUOdoZYlQy3E9sB5iEJpzZbHV4Tn2bEAgWUaZvnw9YfSReCtaUjysWIbF4WxTIgtRUCactaftj7ViBdqM5+ROV4LG8KtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdFIjpbCmIIC5JYF2U0qPdZHsfjw4C8KLHArbhxnBiQ=;
 b=gt5R+HVdUkVLwtmB4SzpNYIdUB67+5TvqHtro3Hw5W30qOrdgehkbigbsxD7dH2DGkNvzMCpjDXSegz+D265feiB2/3cU2ECRT/eDQ25iZb2qZJ8MH+tzSuPO9iV2NShbK0q9V/s1jnNzyGoc2WRBtgmT8af1iydolozXAWx2LazgW6jVEQS7aKf40V7tP3iYgcUOg5d6V41yR8232qxII2IJ/M6hR4Za+zMXztI03zy5RMFsRmWVtoC8lnq9VkbI9A55/qwcM+tGqOAztjoZCxaJ49IxY3MmOLKup/yHXyo2LBg7psWCPH8wTkPavXtsKIWhL5v4OQBRllJLFus7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdFIjpbCmIIC5JYF2U0qPdZHsfjw4C8KLHArbhxnBiQ=;
 b=hMM5c6JX+Obq9aynYp511AVAwD35UKAfnh/Zm/d1VhmTv9m3l6f3y7t6Gc3D/XABsHI7gnUPkypU+fHRNBgq0iJjM40u/nfxsfEzkKjQNQ+kSGEfjQu1gjw9glyCEGB57Tr+nduxXUTBXbG8gL9109c4Jz1rTPX5RLygLHONRhuNBG0Ep8nJgkij656kwFBULmtw1muQ2H07vCudtlA0CAzCgeMc+oMBJ/vQ6KdrriZLe47IK1wWR+tjAcHo+tyjKGZnj2oxea0NDkfkL+bBw7tNfwbZ3srFiTVybVgRys+uRYKbo4ldApvi9V5Jg96VWQBnbKFW/cBx/yMxH3Gnqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5538.namprd12.prod.outlook.com (2603:10b6:208:1c9::11)
 by BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 14:23:10 +0000
Received: from BL0PR12MB5538.namprd12.prod.outlook.com
 ([fe80::3699:352b:fbf8:b41d]) by BL0PR12MB5538.namprd12.prod.outlook.com
 ([fe80::3699:352b:fbf8:b41d%6]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 14:23:09 +0000
Message-ID: <bdf53809-b0da-489b-b25a-28be1286c06a@nvidia.com>
Date: Thu, 6 Mar 2025 16:23:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 30/36] vfio/migration: Multifd device state transfer
 support - send side
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <4d727e2e0435e0022d50004e474077632830e08d.1741124640.git.maciej.szmigiero@oracle.com>
 <629dff3c-865d-47d9-a01a-d212dfed1efb@nvidia.com>
 <97b87f22-b867-4282-ba13-efba16458859@maciej.szmigiero.name>
 <973268d4-85d6-4a17-ae76-2d20d8cfd7cb@redhat.com>
 <d85c8d21-5e1b-4162-9f5b-fe270beb5eca@nvidia.com>
 <498a07aa-d539-46e6-90e9-8c41a59a6b2f@maciej.szmigiero.name>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <498a07aa-d539-46e6-90e9-8c41a59a6b2f@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0387.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::14) To BL0PR12MB5538.namprd12.prod.outlook.com
 (2603:10b6:208:1c9::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB5538:EE_|BY5PR12MB4068:EE_
X-MS-Office365-Filtering-Correlation-Id: 228a685c-b942-4e72-6152-08dd5cba6b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEs4NXNNb2tsSGlaLzNUaVJYVDEwV1BoTFFxc2QzUXJBVVpmamNXOFhrYXFv?=
 =?utf-8?B?M1FlTFpoMlVEZkdTR2hudEovMEVyaG45NnFFaWVqNG9YRUtiVHcyRVhwT2N0?=
 =?utf-8?B?cmRQTDk3dHZIbzJqb3RWS3M4Zmg5VXJBMUVhOE92U0MzTHFlWnBtTHJxRVNE?=
 =?utf-8?B?YnFVK1V6MWVFWUxtMnBOT1BmTzlXcGN3d0pEWndZaXN2VnIzUEhEb1d0Mm43?=
 =?utf-8?B?UFU0NmY1NStNOElJSmg2ZEgxUzdCb29RUlZRazNqTnptRVEwRUJUWXZBdDYr?=
 =?utf-8?B?a3NzNHgrUjFjbTQ5Y1lzcnFDTzZiV28xZXJhRG8vc2VOUEJMT1pKdkxISTBH?=
 =?utf-8?B?ZG5qOFN6MDI4UHNMRDRPdTFSWDNlRU1ucWd3TldNMnEwSDRKaHA2Z0NpY1JS?=
 =?utf-8?B?d0lnVFB3S0RJT0tpZHVGeFN0V0RjMTN4L2JUbmdjdVRJSnVnUG80bUZOTHY0?=
 =?utf-8?B?MG9NRWM2M25vd2dpSy94WTVFR1doTDlyREM3STZHWjJjWDR0SEJiTWRNZWxD?=
 =?utf-8?B?eFJZcHhzY0ZSc2ZpMWJ5dkE1dmdzWTJKVzJPYUEyODNSSGNGNDR4dHBZSmh1?=
 =?utf-8?B?SnZlQlArdjAzeE5ncUdtKzJQVERUaGhxY3BhTEVUeHhoNVQreEdCSUh6RTdx?=
 =?utf-8?B?Z0tlUmtOWTFtS2pPU1c5VmJneTV4S21td1F1aXZZYnlBZGpaeEM2akhmRE1w?=
 =?utf-8?B?Slp0R2dvSkFmOEcrYUdaUkVFRTlnSG9lblZISGpybG8wbFdtdEY1L1ovOGhm?=
 =?utf-8?B?ZVFJK2FRMEVwMXA3VTVvUXRYam5rcVRGZmcyY2ZsQlE4bkJFZCtualZjalR3?=
 =?utf-8?B?VUNrQ3YvVFNGK2xOc2h2aUpTRVVYTnNIZlNNM1FUNHlFb2JlQ0V3MmpVMURw?=
 =?utf-8?B?YVZ6TWlRNDRyVng0cGU0VkJWVmdhOFloUDhvWlROQy9JRnVPaXRyb1N0dnQ2?=
 =?utf-8?B?S1l6MmRMWWlmVHc2OEY3WFd5eEdhTW0vcjE3S25SZm42cnorNTZTSDhFaWJF?=
 =?utf-8?B?M2lXbGhUNUhMVDU2SGdGdS9QM1lXQXE5NzBrYmVFQmRvaGJEaTBmSHoxNUFs?=
 =?utf-8?B?OE5NZmVVY2dNM2FxbnVVeU4zUG9CenB3ajdERjRsT0RrOU1NYkcxNVFJNlZo?=
 =?utf-8?B?dTBVQVA5bWNHcDY1SU1MNHZvcENEdGV1RU1qWXdnN3FQZ0ExNzRyTXRTK2Jy?=
 =?utf-8?B?NE5aWmZkUXlyQkVGM0cvNHEvYTMvQWZ0ZlFVQURhaEg5dVhUd0tldUVUekRP?=
 =?utf-8?B?SnpwZUVjOWNuOGhwcnZTTFVTV1htc1JhYkV0aUlrS21zeUJqeUhIZitaaUpP?=
 =?utf-8?B?aDZ0cWMxZGlHcU9zK1NtTE5uSlpNSlBCbGMzQlJhNVBRSlFjUVpvUFJVb3Rt?=
 =?utf-8?B?ZDVraklxZ0pwdVUvU0J6K0VYYXFIcXJWY2xEbUY4SWRXWUhLaC9XVkZRZlNz?=
 =?utf-8?B?VWIveWNQb1BEemZxVnZxelFMclA1dithUHJ4SnpGS1QyQU5mbTRzV3Y5VGFu?=
 =?utf-8?B?QnFxNjRRMFJaT3lRVHhnN2cyckhybnlvS0hBQkpOS2ZuVW8vTWNuWEZzdnVC?=
 =?utf-8?B?NWlMRmdxTWZhdlU2cVlFMFF1RHJSSWdxSVpubXV2S21HdW5KOWo5bTRGVkpi?=
 =?utf-8?B?RGRjZnhYWkJvYXVoQnhsYmJKS3FvNllyZ3BFTXc0bVNDTE5JWUNJMVZBWjJy?=
 =?utf-8?B?dVhxdHpLRDVxWGN5T0FZMnNIaDI1aFVQckxoYVFwNXBnMXZNNVFwVzNFVUpO?=
 =?utf-8?B?aDVNc0lYdnpUWDVBQkFiY2lQSG9HWCtXeHV2d01pbGxtRWdubWFlYUVWeHBn?=
 =?utf-8?B?eVpoNUd3MTN2elBjSFlHdVQ3WkRLRGczcmpORXNpdVpLeGdpMVBSOU9GSkJo?=
 =?utf-8?Q?7HiR3qPiEzrOq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5538.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHZPU0JHVmd0V1BsZGMyeHRoZGJqMUdURyszUmZzekhycEsvUU1CakhtUDZO?=
 =?utf-8?B?RjlwRHB5R2pUczVxcDBsWXpVNWk0dTdMWmhBenhmdE9LZUJuZERuUkZXNWR6?=
 =?utf-8?B?dzZkR0NEd3NTNmFNMlFXMldLV0dqZERtWklBa1ZyZlIvM3JEelNZM3p0dUNB?=
 =?utf-8?B?a05TdXJzZWFQZzdkajFGemFyb2d3K2VXZ3lnRk05OG9mUGNoVHVHM25vWUFa?=
 =?utf-8?B?Z09XVy9HbWZnU000dzhFUndJdTZ2SCtZRTFFRVIvdVlUY2MwOXFKemEyYkgv?=
 =?utf-8?B?VDU3ajRJOTJRd1BJd2F0bWZSY1FtZithWk8xUXo3NEVoNG1mMmZMV2MzbmlU?=
 =?utf-8?B?WVllQjRVd2dwcUhicUZDRkZCVUNHMmV3TU54dEtzU2ZkREhrUEdwRDdXV0k5?=
 =?utf-8?B?R0YwVmoxcmtncHJBWUFBeHFCRjIvU2IzTmZWSVpJMnBRcXdWWWNYWDhpQWY0?=
 =?utf-8?B?ZnZwMmtCcXF4cWVNbGthZkROZUlVbEpxQktYT0pXMzJhYnU3azE0eU0veFFC?=
 =?utf-8?B?TlRSSWZTT2ZuckFaNXQwem9mWjBhMjNBSDIrTTFReEFQZURmcUhSbS9yTERE?=
 =?utf-8?B?VVhtM2ZNM01VUjVQbTRhQ21xTzlZOEJuTGo4SHNnRlhVTk5SaVJFUEh4R0h5?=
 =?utf-8?B?dGNueGU4YmNqRUxxQW1pRXlCb1p4ZVdxbnArWGRrRnZ0TFhQanRHekJ2c09t?=
 =?utf-8?B?THRUd3Q0N2tEcWsxTmxoMWwwZzRJOFZZTndGRmxYS3lIcm1QT0lYTU9HdHps?=
 =?utf-8?B?OENaYkJ3MDJGNWpqblRISVU3bTh3KytFL042N2Iwd1E2WXBBajJFaUN1OHpB?=
 =?utf-8?B?NG1Ka0FTekc5aGtVODNJeFRXN0lvcS85RDNGb0RPeHJaZmZCdGJYNnRIai9R?=
 =?utf-8?B?SzZaVVhVSmZ0RzdlQVJ0eGV1MVRKVEMxdWRsU0QwY1FvYW1HcVdhdkR4Yk5x?=
 =?utf-8?B?a1BFdXJzeDJTSTYwV05MQk1Ec1JOenlyeGdIYisrMjlNckg4WE1GQkxvcVhD?=
 =?utf-8?B?YVhvdW5jWkFoY1duWmZOcngzUGZIaWYrUmY5YTJtYVhIZ2trSUhvcmN1QUhx?=
 =?utf-8?B?bW0rSjZydFlOTGF2ODd5Rk1zbFlkOXFJUytQdmRCVE5FNW82cVRQOXEwU0RF?=
 =?utf-8?B?a2NtWEUzeTFxK2lIZXJSVGdwc2huNlN0TDd3RlRENnBReUZ0akF3TFEvdW45?=
 =?utf-8?B?eHpKN29OcXZ3TXRDMTNkMkF1NG9qMVNvT1NIWTRCT2VYTlFLRitiWGVmK1dM?=
 =?utf-8?B?SWhjbXROVEhrN2l6SXBEKzBOaDdCdSt4VzhGZFkxaFdkTTJSN0RoRXFSc3ly?=
 =?utf-8?B?MmIzeGpndWVjeEFwTWRYRDIwZDdnTU9ySEJBdVBaN2wxdWF5NVc1QVVXay8x?=
 =?utf-8?B?Z04vR1FpUEliYTNQZCtxRWNLWUVKNHBvbGRvdUpVMDBrOWkwOTNaQkhNcms0?=
 =?utf-8?B?MlBtYlh3N2hhd3Y5YzZlbDJ3aEg3S28vOFZoZUpCM21ibUE3OC96MzQvWGxF?=
 =?utf-8?B?S05KbHQ4RDdkM0tPVTByaXB5WVJkMVRJb2ZOUy9LS2lvWXhWSGswdXVlVENP?=
 =?utf-8?B?MVhSY3BNT0IvUW10ajVCMDZZM3VveGZGSlJwd2tQM0VpemxtSDVpRWd6Tnpu?=
 =?utf-8?B?d3J3WnJReHRTd3FHNkhTRk00V0svQTAwUWVNWW9Ob1BLbEgwVzdZNDlzckYx?=
 =?utf-8?B?YnJVNldtSTUrNm1LVU56NjVlZjVJWXVnSDVDK283Y2pjMzdhNHVMeldvbDNv?=
 =?utf-8?B?c2VjeER2d1lMSVVEVUVuUU8rYU5oMHZYS21TdmZsN3J4R0ozQzM1RGVjRm5s?=
 =?utf-8?B?RnE1QWJWT2RCbXU3UHpZSkFwN2YzWFh1WEpZOXRLVE96WWFsTU5YZUthTHU5?=
 =?utf-8?B?SWdSakl4TTRuUzVweFluaFhrSjkzNTRRdEpiTTFKNlJLYXBJeHdqOEkzSVVK?=
 =?utf-8?B?K3hiL2xyaERsTGk4TGEveVBlR3Q0bWZpVkt2SzNYQVJBeGF5NDk4eG9STWxD?=
 =?utf-8?B?TSt4MEpQVFU3dUs5Nno5SUptZXN6RmlFV2wxbzJqcmEzZUZmQWZQOUpZaGhD?=
 =?utf-8?B?WWh1WXVoU1RvNkV3U3krb1R3NVFsbXhoTmVFUzhuUStnWEZCdGN1VURnQS9B?=
 =?utf-8?Q?BK4uo0eJWVGZmoxpbBCM/lr+2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 228a685c-b942-4e72-6152-08dd5cba6b58
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5538.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 14:23:09.9004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0kgxnlaVIBS46EutkNkNBu1Y4KcfV9tbp+MswGbkmbLzSGs8qVWlyHumWdj6MPkPHVSiwyTVq5sY+EyT9czkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068
Received-SPF: softfail client-ip=2a01:111:f403:2413::62e;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


On 06/03/2025 16:13, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> On 6.03.2025 14:37, Avihai Horon wrote:
>>
>> On 06/03/2025 12:32, Cédric Le Goater wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 3/6/25 11:15, Maciej S. Szmigiero wrote:
>>>> On 6.03.2025 07:47, Avihai Horon wrote:
>>>>>
>>>>> On 05/03/2025 0:03, Maciej S. Szmigiero wrote:
>>>>>> External email: Use caution opening links or attachments
>>>>>>
>>>>>>
>>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>>
>>>>>> Implement the multifd device state transfer via additional 
>>>>>> per-device
>>>>>> thread inside save_live_complete_precopy_thread handler.
>>>>>>
>>>>>> Switch between doing the data transfer in the new handler and 
>>>>>> doing it
>>>>>> in the old save_state handler depending if VFIO multifd transfer 
>>>>>> is enabled
>>>>>> or not.
>>>>>>
>>>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>>>> ---
>>>>>>   hw/vfio/migration-multifd.c   | 142 
>>>>>> ++++++++++++++++++++++++++++++++++
>>>>>>   hw/vfio/migration-multifd.h   |   6 ++
>>>>>>   hw/vfio/migration.c           |  22 ++++--
>>>>>>   hw/vfio/trace-events          |   2 +
>>>>>>   include/hw/vfio/vfio-common.h |   6 ++
>>>>>>   5 files changed, 172 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/vfio/migration-multifd.c 
>>>>>> b/hw/vfio/migration-multifd.c
>>>>>> index 1d81233c755f..bfb9a72fa450 100644
>>>>>> --- a/hw/vfio/migration-multifd.c
>>>>>> +++ b/hw/vfio/migration-multifd.c
>>>>>> @@ -496,6 +496,148 @@ bool vfio_multifd_setup(VFIODevice 
>>>>>> *vbasedev, bool alloc_multifd, Error **errp)
>>>>>>       return true;
>>>>>>   }
>>>>>>
>>>>>> +void vfio_multifd_emit_dummy_eos(VFIODevice *vbasedev, QEMUFile *f)
>>>>>> +{
>>>>>> +    assert(vfio_multifd_transfer_enabled(vbasedev));
>>>>>> +
>>>>>> +    /*
>>>>>> +     * Emit dummy NOP data on the main migration channel since 
>>>>>> the actual
>>>>>> +     * device state transfer is done via multifd channels.
>>>>>> +     */
>>>>>> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>>>>>> +}
>>>>>> +
>>>>>> +static bool
>>>>>> +vfio_save_complete_precopy_thread_config_state(VFIODevice 
>>>>>> *vbasedev,
>>>>>> +                                               char *idstr,
>>>>>> +                                               uint32_t 
>>>>>> instance_id,
>>>>>> +                                               uint32_t idx,
>>>>>> +                                               Error **errp)
>>>>>> +{
>>>>>> +    g_autoptr(QIOChannelBuffer) bioc = NULL;
>>>>>> +    g_autoptr(QEMUFile) f = NULL;
>>>>>> +    int ret;
>>>>>> +    g_autofree VFIODeviceStatePacket *packet = NULL;
>>>>>> +    size_t packet_len;
>>>>>> +
>>>>>> +    bioc = qio_channel_buffer_new(0);
>>>>>> +    qio_channel_set_name(QIO_CHANNEL(bioc), 
>>>>>> "vfio-device-config-save");
>>>>>> +
>>>>>> +    f = qemu_file_new_output(QIO_CHANNEL(bioc));
>>>>>> +
>>>>>> +    if (vfio_save_device_config_state(f, vbasedev, errp)) {
>>>>>> +        return false;
>>>>>> +    }
>>>>>> +
>>>>>> +    ret = qemu_fflush(f);
>>>>>> +    if (ret) {
>>>>>> +        error_setg(errp, "%s: save config state flush failed: %d",
>>>>>> +                   vbasedev->name, ret);
>>>>>> +        return false;
>>>>>> +    }
>>>>>> +
>>>>>> +    packet_len = sizeof(*packet) + bioc->usage;
>>>>>> +    packet = g_malloc0(packet_len);
>>>>>> +    packet->version = VFIO_DEVICE_STATE_PACKET_VER_CURRENT;
>>>>>> +    packet->idx = idx;
>>>>>> +    packet->flags = VFIO_DEVICE_STATE_CONFIG_STATE;
>>>>>
>>>>> The packet is sent on the wire.
>>>>> Shouldn't we use cpu_to_be32() for version, idx and flags? Also 
>>>>> below in vfio_multifd_save_complete_precopy_thread().
>>>>> And then use be32_to_cpu() in patch #26 when receiving the packet?
>>>>
>>>> Is it even possible to migrate to a host with different endianess 
>>>> here?
>>>>
>>>> Also AFAIK big endian hosts barely exist today, is any of them even 
>>>> VFIO-capable?
>>>
>>> s390x is VFIO capable. VFIO PCI migration is not supported on these.
>>>
>> It is indeed a niche use case and not even applicable today, but if 
>> we want to add support for it after the release, we will have to add 
>> a compatibility option for older QEMUs.
>> If we add support for it now, then we can avoid the compatibility 
>> option.
>>
>> It's a really small change and it can come even after the series is 
>> merged, as a fix.
>> So IMHO it wouldn't hurt, for completeness.
>
> For sure, any such bit stream change will need re-testing the whole 
> VFIO migration.
>
> But I will be testing the queued buffers size limit anyway so it would 
> make
> sense to test both at the same time.
>
> Wouldn't it make more sense, however, to squash this endianess change 
> already
> to the relevant patches rather than to have such bit stream modifying 
> patch on the top?
>
> It would help prevent backporting mistakes - when someone forgets 
> about this last patch
> and ends with a different bit stream.

I agree.
Whatever you and Cedric decide.


