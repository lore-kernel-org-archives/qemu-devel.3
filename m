Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD584D690F0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 10:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGbX4-0003FW-Lj; Thu, 28 Nov 2024 05:13:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tGbX3-0003FM-UJ
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:13:57 -0500
Received: from mail-mw2nam12on2054.outbound.protection.outlook.com
 ([40.107.244.54] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tGbX1-0001ps-PV
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:13:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RH36lGsQw9X0N4QM0uYCsXy8+PQJX4FKUTdPYrzmMGddjvya32KJieu0bC3BJstCP4/GNC+48DFhLf6NIhl7u6OvmMI4OnBd/FZssh+VAW80ncbGeDSWEXytB4BwHCnFB64LiZI9lEN1p0bYo6lba1WKXeMxpoONU9oV187BHqEy6qq4+9FQKSB8KomesEApQqK95pC3yFw93QuanMnm7tj7Kxtq9YTRJ7htRGOBgyWCdj7f57yZbc22wohENILDe7XaI8QshfiAwClVYmJcoo/K5nv7OBrPuMfDSv6dTI7xz/Zg6h/gUbLVWT1dtJ1XF9z2U1DZk50ynpP0UE6Y0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MV7kBUzuB5QfpBKMpQYmK8VTVkXxJ02satfcnXdtyM=;
 b=qgcKrpXElvjxaA1zTR2yjz7SXrizEYB10TsWZMGQ995hfUdb6X9OlRCoksVXt8U9cx11ILbrHDFc5Kxs7+szSU6wxKxSkm2VxJEXcHX9sKL3r2LRCvnCwc1PduMArREPRPyARFqo24g2+e+qA8KiI2ZVE1DtYM22x3R5OcqQ4MzqKXSbj0mqk0LSISu19vB4TQpJ8tANHqjS0p2HcenSXisekABsxuGqnvO7E1voU2RJIvKW7GtSjDUbSj4OtFovaYKEYKNOu48gpnVVQ9XPD8rKBl1rGl/5YXybsp9GJ13eyiOfsQFa0B98NtJ0r0/4PXi6IBuHk9jV4TcENJH0iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MV7kBUzuB5QfpBKMpQYmK8VTVkXxJ02satfcnXdtyM=;
 b=AkrLljzBwxZP121d59cadOal3AuevoAoHrYD5UDgmM/HqYzrPGLR0KgnEAtM3fdKQS74FyyRCpGKwber++FdoMdzvlZYIkRSjSAb3VbXLG1wpat0Omn7GqCrAfyYcsyfIlw0Ckz+yX98xghfvcWWyolVvr6bbWZIHA8tdESt9nsfpLdwaF8Fztr5aq05hZHuFtrKyZDXaj5rYKVo/8m2yufnFFv1Edc7Jl2Hw+K/40nw0kDjKSoDTrNQGL+xEy7MjojtzXvIZGeIqvIcRzjPLbukv2b2tkrF7aG2GaTWriVF39/F1d9yfJThI0xsaEHLAcyT4VUgB5TiVFTvMhZm4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.21; Thu, 28 Nov 2024 10:08:48 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8207.014; Thu, 28 Nov 2024
 10:08:48 +0000
Message-ID: <e1ea0647-e71b-4278-8cf6-15c52b14f6b7@nvidia.com>
Date: Thu, 28 Nov 2024 12:08:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/24] thread-pool: Implement generic (non-AIO) pool
 support
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <babda1bbe43024baaa4a9ac855f7930b6679f2b7.1731773021.git.maciej.szmigiero@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <babda1bbe43024baaa4a9ac855f7930b6679f2b7.1731773021.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0228.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::17) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DS7PR12MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ff9b73a-1175-4eed-2ceb-08dd0f94a65f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHNVWndQekpWMHhwaGpnTUdnak9jWndnL2huTjVkV3NRZnV5ZjRpaXgrdUIr?=
 =?utf-8?B?RWtDZmhyLzBtSmZoVFJxQVBCQnpnQy8zK0gvWEZDS3BNY21LYVI1QVpSc1Bo?=
 =?utf-8?B?QVJRSFFOeVltcVk5SVhMZ3ZtaHVvMm9VM0IvaU92c3FIdUlla3RpNndERmZ1?=
 =?utf-8?B?MDlLQjZMdHZWU3VsU3Z3aWpsS01LdnZJUC9WTGw0QzRGZ0hVTW5jYTQrUnlo?=
 =?utf-8?B?Q2dIQ1QzQjZCMlFoaVZZQ3E5dnE4TWFxcWowVWlsdjZZSnFDaSszbHlTU0hx?=
 =?utf-8?B?c1VOYjNGYVE1eGtxbnd3VXMwcVJqQlpQdy9ud3BjQUljZ3dVVnZHVjloU2dz?=
 =?utf-8?B?TytSM2pkcnNzQ1M4dk1ValJ1cWNkOEpyR1lPV1NxNEp2NmRJRVN1MWw5aE1E?=
 =?utf-8?B?Vi91WUZvanVnWWRKZ3JTUFUySmpjSDFiZ01IeThQU0xWRUlyWnZrZTkyUi92?=
 =?utf-8?B?ZklWVXZKMEhyT0ZySGprSEhFRGQveWpEWG1QKzhTTlpaUFNaNjkwVzNURUlF?=
 =?utf-8?B?S2pIWDNVdFlYWnJ4elBvdjM3UXFmNTY3U1Q1TXhvRzNUbUpPMG45TzdhWXlj?=
 =?utf-8?B?aStpOFNaSVFTdWlKUWNVa05Tb0JNeTgvRnVTR09SUFdKRUFWM3htTEtBdGZY?=
 =?utf-8?B?T01rV0o0OVpvL1NlNkJUNmkyV0hjSG1kQ1hHSGtFQzFubzZ5WHhVQ3FaVTA5?=
 =?utf-8?B?MU1FWm5BT05nSFE3ZEd4L2dmSnRxQXFpcUVHY3BJNmJHZ0pUbDNGU2dtdjl5?=
 =?utf-8?B?NjA5SHI3R2ZmV2RsMU04NnpIU1hRUThXRUdLYzhPZDhsWHBFd3pnT0JiZ3Jn?=
 =?utf-8?B?d2o0TVVtRjFyN3Nabk1YKzFzS1U2Qkhnbk9lVnRLZlpaZVUzMjY3L05DUlhN?=
 =?utf-8?B?MUtxSjFoOE96ZUcwUzZ0dDFVdGlmR2pvVVpkZGtSOHg4QzJ1Yms3YSsrZ0VZ?=
 =?utf-8?B?R3dlVENSY2hVMVphdVU2Wm15YlZ0dmlEb1NINHhtWm9qQzY4dXpwdjFBS0li?=
 =?utf-8?B?akhLdU1qc3l6RmEwdGNWQ29Uc0l0RmhWemJsdnNkMDUrTXBFYmw3dXJCUjh4?=
 =?utf-8?B?aWVKM0NlQzQxUUMzeFdRaHlaRUFMbi8zU243T0VSTDlIQnJlb0JMZm50VjZI?=
 =?utf-8?B?RmFIeWtqRzJWYnUzNUJJZ1U4YlRwWWtjclp0eG00eFM1SzEreGZ3ZFNmMTJq?=
 =?utf-8?B?eE9FTnlWZzJPdTFLbU1YbkFPSlFHWU0rSlVHcFVqU3NiTFNsSytsZzI3ak5a?=
 =?utf-8?B?SlZLTG5YeVkxbVN2R3VDcDZyVjFEeDVHbTR6T2UwMVhVTnZLRXVhK1ZVamdy?=
 =?utf-8?B?b21aaks1WlVmMWRCby94ZWRVcXlSREhGN2NZS0UxaW1HczVqdVV0ZWhLanJX?=
 =?utf-8?B?SVA3UGQ5RGMwZ0pQb1JrK3ZZOHJ0RmVlKzVqMVkrZ3FiQm9LM0M1RVJFbTdl?=
 =?utf-8?B?anN2R2hzclpOdUxpNkx5TjQxQVVOWWxZR3NyaDl6MGFuTFZvNzhwWS9BWWhs?=
 =?utf-8?B?bGpyUERtaUpJYkZ6YlY0Rk5BeTNpSDNmRVAzOXR0Sy9xR3NqZEM4RGg0OUVv?=
 =?utf-8?B?OWFBVnJSQlZ1bXFWNlp0YWJtaFZQK2lmYjJUK1FZaURpNkJjSzRHT2F2OGtV?=
 =?utf-8?B?OG9pc3FOZmFvellLNzhWV25FZ011eFlvdHBnditxc2x6ZHJIWElaaG9CbHJs?=
 =?utf-8?B?ZjZYbzF2VXdpNW5OYU9OQXErMURuRm10S0RnR3pmQ0k0aXFoWVRBVEU5RkRu?=
 =?utf-8?B?TFhKQURxeXFXTnA1WEE5T25WSDcyZjZJSTcxZGpONjUwdit6Yk5KdHJQQVJv?=
 =?utf-8?B?dlNsdWxCd2JXN3dFaXBJdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUtTTnFyaWZrY1NOSVlYb3NJYkhEeEE0QTNwZlI1WVc1QjArTXkrbmNqenRM?=
 =?utf-8?B?dHBCRmZJN0ZvLytINzM5RXFDTC9lYjZWTHVSakJqSXBDTVJlamJIUkVjeFJn?=
 =?utf-8?B?WWhHQzl5UkdqSUxFbzZvU0RwQ1FvUlpzbnlaSnU1ZUt4eUVaL0R1dGVuSngx?=
 =?utf-8?B?dWxhbHV4YU92Yis3MVk3NU92Njc1UFdaRlZtT2gxanFndStiTlJZbFM2RE4y?=
 =?utf-8?B?UzVWckU3bDl4cENPZFpHVlhLK05RelhYdUZQR3ZyZkJiTzR3YmNKY0VobFlz?=
 =?utf-8?B?bGZQRXlXRFRRUDdobWx1c0VQWU9Cd3l2WFRnVXZCSmdldk41SG5YREJ6dDE4?=
 =?utf-8?B?ZTF0OGhzSkcrZXFZMkRjbEN5V2djMTBZQmFVKzFQdFdnWlRKdWF6OFBkeDdK?=
 =?utf-8?B?OWtLUG5zRXpkalhEZ1RSVG1xeWNoSi95TXRrOVJRdmdTT3BZVkpHTUNueFo0?=
 =?utf-8?B?TXlwbHYra0Rpb25Eb3EwVXNjbjFONDFWem8xeHRWSkVEaVZPT3pVSC9mU2dh?=
 =?utf-8?B?eGNLS2crMVp1N2h2VWM3eUNMZSsrSHpDV2kwSFk5SkNGbi9yZGVicDdlanhL?=
 =?utf-8?B?bG9MdjBZLzVZNUR4SFFIVHdqSEpqMSsvNVhjN2ZHd1MzcTNKY0wxWFZ4byts?=
 =?utf-8?B?elRTc0pzNjZMYjAyaGVmM3JFZEJJemdDU3BqQ2J4UVlxUVJzWTJFcjhER2hy?=
 =?utf-8?B?TFRWeGMzMGVDS0xxZzFvTDNjRk9WY2NlOGRLaVp4RzNNT2liNzhYeitsckpP?=
 =?utf-8?B?cU9XbmFRajRNOTRhd0hwNTk4YTFVbGpyNkg2S0huZC81ZjRJWFFqcnN4SFBQ?=
 =?utf-8?B?cDZBWWNyQ2xteXlOZDhqUXJGbmtnOUFKZS91SFk0bTFyaUhYNFNzQlNLQk9L?=
 =?utf-8?B?aXlrWUdtVzBvS3NFQUlLckNrOHZKeHpuS282WjVPbnFFa0Ntb2J2a2dBeUFN?=
 =?utf-8?B?SGZMWnJRenEyV3UyVTVoMWd2WDE0YjFtQTRQc0JvcUlhaEV4NDBLNndEWGJL?=
 =?utf-8?B?ajlMNVp0cCtwR05JWENuRnRoRWJxdzR3MzZDUzdMWE4xclFQOU1IMzk1WEVk?=
 =?utf-8?B?YkliNkt2WTVub2dCZWcxRTJWZmRLWjNORHFpM2xUSEFyTjhOL0hRSnRqeUNJ?=
 =?utf-8?B?L2tCYnNyQnl2ZW93SHBrckFoeCtzMy9SWTVmS0RXeks5SWxLY1lOQUk1SEUz?=
 =?utf-8?B?Y1R6Y2o4aHVTYytKbC9DcUt6RThTNHdTWjNUUVM1R0dFeXI0Z0pyeGh3ejA1?=
 =?utf-8?B?dU9qbkR4RjYxdXRKU3MrekpoMXFmV0lxRGwvaUdoUnZMYk10cU9qZVBPZzNj?=
 =?utf-8?B?bDZPNTBtVW5xMjA2aWlNMlZjR3hXOGJYSXh6bVIvNi90ZmY1ZDRnbUhpRWl4?=
 =?utf-8?B?OHhNT3RTQ0xIa2U4Mk84c3FFaktXVDhxMVdDYVM0aExOMmtBV3hGcWREZFFK?=
 =?utf-8?B?MWM0RTcwQmVLdkRVdmhYY2dOKy9ZMklnT2hsUlJOWk14SDNWYlZCTmRxZTNT?=
 =?utf-8?B?TERqMFN6WkcxVm1UbjNQQmFvTWMzT1ZZWXg1alB6K3ViR1VONlh3aTZFRVM4?=
 =?utf-8?B?N3ZRWFdlTDNEQTlhUFg2Z1NTTWc0OUM5Mm9UbVoyL1FEZURRRmJOdDVkN0cy?=
 =?utf-8?B?WkZPaW9Ma00xYTBHTkdFaVlzSnNFc0t1KytUc0tQVmM1ZVlPem82aGFvUzl4?=
 =?utf-8?B?cmFzSDRNWFBobHptbmhTRHFaS3FidVQveGtZVU9TdmVrWndtRHhaT3ZuODFD?=
 =?utf-8?B?R3BJQkExa1dOaUwzcEdnSFRpaGZxV1BVc3Bnem1hMmsrQnpsTVV6eWd4U1ds?=
 =?utf-8?B?TmNrTEx5ZDhQL0ZnczhhUFhEYmhubE0yMTUybHhjWXdmWFF1ZlVtZUlwczJt?=
 =?utf-8?B?cnc2U3RqbTRtQnhRZXZwV0Q0K2F6T2tmL2lNV0ZUVFloQ0NHTW9NbGVjY0tL?=
 =?utf-8?B?UEtDMDUwS2hIcm1NemEwUEtpeUNMdk1xdW5HWGt1WjBTbHZTcGpPd0pQNm56?=
 =?utf-8?B?dHFIaWplMFZIVFJ3enFiY25zSGFqeStGVGk0R0srU2E2a01KVzFOUFdCL1ZQ?=
 =?utf-8?B?RDJOR1lOTDdZM2NqajhNSmhlaFd1U0hBSHJhMUdSa1RkaExMZlR1b2E2cXh1?=
 =?utf-8?Q?YjYAF2AtAwmrrZe8LRR0dGX2R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff9b73a-1175-4eed-2ceb-08dd0f94a65f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 10:08:47.9693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8G05GYdvJw6ZCc6w8CVL3Un/VDMipHwkwz4MTRlGumxAezI18inhjYiJm6pi7pciK0oA9g/WLvP0M6LXQ2KPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8252
Received-SPF: softfail client-ip=40.107.244.54;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Maciej,

On 17/11/2024 21:19, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> Migration code wants to manage device data sending threads in one place.
>
> QEMU has an existing thread pool implementation, however it is limited
> to queuing AIO operations only and essentially has a 1:1 mapping between
> the current AioContext and the AIO ThreadPool in use.
>
> Implement generic (non-AIO) ThreadPool by essentially wrapping Glib's
> GThreadPool.
>
> This brings a few new operations on a pool:
> * thread_pool_wait() operation waits until all the submitted work requests
> have finished.
>
> * thread_pool_set_max_threads() explicitly sets the maximum thread count
> in the pool.
>
> * thread_pool_adjust_max_threads_to_work() adjusts the maximum thread count
> in the pool to equal the number of still waiting in queue or unfinished work.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   include/block/thread-pool.h |   9 +++
>   util/thread-pool.c          | 109 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 118 insertions(+)
>
> diff --git a/include/block/thread-pool.h b/include/block/thread-pool.h
> index 6f27eb085b45..3f9f66307b65 100644
> --- a/include/block/thread-pool.h
> +++ b/include/block/thread-pool.h
> @@ -38,5 +38,14 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
>   int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg);
>   void thread_pool_update_params(ThreadPoolAio *pool, struct AioContext *ctx);
>
> +typedef struct ThreadPool ThreadPool;
> +
> +ThreadPool *thread_pool_new(void);
> +void thread_pool_free(ThreadPool *pool);
> +void thread_pool_submit(ThreadPool *pool, ThreadPoolFunc *func,
> +                        void *opaque, GDestroyNotify opaque_destroy);
> +void thread_pool_wait(ThreadPool *pool);
> +bool thread_pool_set_max_threads(ThreadPool *pool, int max_threads);
> +bool thread_pool_adjust_max_threads_to_work(ThreadPool *pool);
>
>   #endif
> diff --git a/util/thread-pool.c b/util/thread-pool.c
> index 908194dc070f..d80c4181c897 100644
> --- a/util/thread-pool.c
> +++ b/util/thread-pool.c
> @@ -374,3 +374,112 @@ void thread_pool_free_aio(ThreadPoolAio *pool)
>       qemu_mutex_destroy(&pool->lock);
>       g_free(pool);
>   }
> +
> +struct ThreadPool { /* type safety */
> +    GThreadPool *t;
> +    size_t unfinished_el_ctr;
> +    QemuMutex unfinished_el_ctr_mutex;
> +    QemuCond unfinished_el_ctr_zero_cond;
> +};
> +
> +typedef struct {
> +    ThreadPoolFunc *func;
> +    void *opaque;
> +    GDestroyNotify opaque_destroy;
> +} ThreadPoolElement;
> +
> +static void thread_pool_func(gpointer data, gpointer user_data)
> +{
> +    ThreadPool *pool = user_data;
> +    g_autofree ThreadPoolElement *el = data;
> +
> +    el->func(el->opaque);
> +
> +    if (el->opaque_destroy) {
> +        el->opaque_destroy(el->opaque);
> +    }
> +
> +    QEMU_LOCK_GUARD(&pool->unfinished_el_ctr_mutex);
> +
> +    assert(pool->unfinished_el_ctr > 0);
> +    pool->unfinished_el_ctr--;
> +
> +    if (pool->unfinished_el_ctr == 0) {
> +        qemu_cond_signal(&pool->unfinished_el_ctr_zero_cond);
> +    }
> +}
> +
> +ThreadPool *thread_pool_new(void)
> +{
> +    ThreadPool *pool = g_new(ThreadPool, 1);
> +
> +    pool->unfinished_el_ctr = 0;
> +    qemu_mutex_init(&pool->unfinished_el_ctr_mutex);
> +    qemu_cond_init(&pool->unfinished_el_ctr_zero_cond);
> +
> +    pool->t = g_thread_pool_new(thread_pool_func, pool, 0, TRUE, NULL);
> +    /*
> +     * g_thread_pool_new() can only return errors if initial thread(s)
> +     * creation fails but we ask for 0 initial threads above.
> +     */
> +    assert(pool->t);
> +
> +    return pool;
> +}
> +
> +void thread_pool_free(ThreadPool *pool)
> +{
> +    g_thread_pool_free(pool->t, FALSE, TRUE);
> +
> +    qemu_cond_destroy(&pool->unfinished_el_ctr_zero_cond);
> +    qemu_mutex_destroy(&pool->unfinished_el_ctr_mutex);
> +
> +    g_free(pool);
> +}
> +
> +void thread_pool_submit(ThreadPool *pool, ThreadPoolFunc *func,
> +                        void *opaque, GDestroyNotify opaque_destroy)
> +{
> +    ThreadPoolElement *el = g_new(ThreadPoolElement, 1);
> +
> +    el->func = func;
> +    el->opaque = opaque;
> +    el->opaque_destroy = opaque_destroy;
> +
> +    WITH_QEMU_LOCK_GUARD(&pool->unfinished_el_ctr_mutex) {
> +        pool->unfinished_el_ctr++;
> +    }
> +
> +    /*
> +     * Ignore the return value since this function can only return errors
> +     * if creation of an additional thread fails but even in this case the
> +     * provided work is still getting queued (just for the existing threads).
> +     */
> +    g_thread_pool_push(pool->t, el, NULL);
> +}
> +
> +void thread_pool_wait(ThreadPool *pool)
> +{
> +    QEMU_LOCK_GUARD(&pool->unfinished_el_ctr_mutex);
> +
> +    if (pool->unfinished_el_ctr > 0) {
> +        qemu_cond_wait(&pool->unfinished_el_ctr_zero_cond,
> +                       &pool->unfinished_el_ctr_mutex);
> +        assert(pool->unfinished_el_ctr == 0);
> +    }

Shouldn't we put the condition in a while loop and remove the assert (as 
the wait may wake up spuriously)?

Thanks.


