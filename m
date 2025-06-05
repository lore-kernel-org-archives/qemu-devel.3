Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDDBC5B552
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 17:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNErG-0003D7-SX; Thu, 05 Jun 2025 13:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1uNErE-0003Cq-4s; Thu, 05 Jun 2025 13:58:28 -0400
Received: from mail-bn8nam11on20628.outbound.protection.outlook.com
 ([2a01:111:f403:2414::628]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1uNErB-00048p-BC; Thu, 05 Jun 2025 13:58:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqIhmca2jZmKCQW8WraWCRgtxq73gQ8m0hIEJyAW14dxrU/mZi94M+uuhT44d/cqbhhlA30DSVzkbzPtFQaolpA1DZ6tEDnG+34w8JMsBdQMhy7gdRc15DpxNxoFEL9a4isMPbb4D2yUapHihLjpOSQAdE0Aj1//grcgyrAqn7s40T9vOPu24+cJ9S5bpAqloZCyq/p/6rtEW8a+xK+gnc9inPQRam+DZcI+gVhkyB6aqCmuoXYKFWjXDxnv2MtywBN962hHhkPgr1bF5mWT7Op1qdQwlz7xskF4LBiEGF+lR61acowBYGcNrRabZoIsrK+ALzhl9hfd4njvp1IYxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3Cnh5jvoJErpgj1qtM+T/PSnm/+5XZA49inJaEw6DU=;
 b=ymeEWNvqQxnsUyXMpVIxIuJAFRJD1J+kXsF2ttBlvhU8dMM+h1vXfHeyNmGWxVFz0AxbbLY6nDpKsiuGmE9JWUr40J46zDs+NvreX1N8ifb0eLUbtKYrBDF/iu8Avdl7T2YWTXc24pmUm7dHyCvQa0+OQR4F63awORcCKwuF1eKXIlUX2nT6p2QNlgR8J2SdSPph4VcSceoWG8g7U++1F4HgkIVU6WYSPiHQVGddWNS7+6OHr07EA04sx5MkJFzAIncPgpLC7mORwHaiKlfGD0NR0TMoSdCFu5bnzYsVYQ/U1vQf5mAQ2so0PZPHbASrfZjLwfto15licbJdXP5QMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3Cnh5jvoJErpgj1qtM+T/PSnm/+5XZA49inJaEw6DU=;
 b=fxp+F14oCL1yoeQr0hIWtmrHhHAK5PZ+uKyGWrXfLkgutwYB+UO0/rJx+l0+SKP/RArkGwWHN+6/59H5Vfkw/T/eCWiLx6OOGLsLEMHmU3CjBazYTXn1CqIeg46sZiwMP/LVNdNKfLIuElOmtODuVF2Q5AC2DoawQEkFeXxe4TL+WP/6VTBDLHglxEwa62oQHn33WzlGoX/2dSTjhH0naePmH1dpuCxt8V69AltnnWkEJpRmKoFdAjG1xuXjgNNNhWi0900PJqNUvopnCOobgKZjeRQyiv9Qq8juVimBEUFx0PIN3a3piRQia3HD6SAF7o+bubdU+6KRl+0IkkI51Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB6838.namprd12.prod.outlook.com (2603:10b6:806:266::18)
 by SA1PR12MB8859.namprd12.prod.outlook.com (2603:10b6:806:37c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 17:58:15 +0000
Received: from SN7PR12MB6838.namprd12.prod.outlook.com
 ([fe80::529d:478:bc5d:b400]) by SN7PR12MB6838.namprd12.prod.outlook.com
 ([fe80::529d:478:bc5d:b400%3]) with mapi id 15.20.8792.034; Thu, 5 Jun 2025
 17:58:15 +0000
Message-ID: <90957693-dc12-4731-960f-0ee295d297ec@nvidia.com>
Date: Thu, 5 Jun 2025 10:58:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] hw/arm/virt: Add support for user creatable SMMUv3
 device
To: Donald Dutile <ddutile@redhat.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, jgg@nvidia.com,
 nicolinc@nvidia.com, berrange@redhat.com, mochs@nvidia.com,
 smostafa@google.com, linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250602154110.48392-1-shameerali.kolothum.thodi@huawei.com>
 <74d9f7a2-dbf4-48d5-bda8-847d1fc73e38@nvidia.com>
 <ce8a82c0-e8d9-447f-89ae-45fcafdd92e5@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <ce8a82c0-e8d9-447f-89ae-45fcafdd92e5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::26) To SN7PR12MB6838.namprd12.prod.outlook.com
 (2603:10b6:806:266::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6838:EE_|SA1PR12MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: fc4b4027-946d-4981-8c4e-08dda45a8ba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R25kYTNNN2xENExTTi9FelVqdEc2c3lKL2JtdnlURS9rZ0VlbDFiRWJpUVFE?=
 =?utf-8?B?dWVtRk9GK3h4SnBPaDJRa0xMZk1ETi9uVFlSclc2aUlseXc1b3ZnQ2xDZ1I4?=
 =?utf-8?B?eEJGQVEwRDNJWUlGS3I5MnJ3L3lWWGYwOHlsOGVJVGkxMnRJdTJtYjZRVUtG?=
 =?utf-8?B?eHFjbmF1Rk5YRnJZUmRrQk5DUUlRS1lzemlqK2oxVFpkMDNUbDlMbDlxRTlG?=
 =?utf-8?B?UUsvSEpYc21uekZ1YTZGODlBODdZcEgwNHFFM0Q2bVlKdWtNZmRyNHhrSm4r?=
 =?utf-8?B?dDFwSGVPWGMxT1ovMHdNSUpzbDZMR3J2V2Y4ZEQ0dmtuVGhRQ21Nc0FqNXhh?=
 =?utf-8?B?cEhxWDJzRUIxKzNBTnZheW90ODZoNGkzQTN2ZVNwSlE0K1dwYTBTMURtdHBl?=
 =?utf-8?B?KzMvZjBLQnJFMmt4N3JYV2dZUkJldi9BTUFzbUNQd2NHNVZzT1ZYaXZHRFND?=
 =?utf-8?B?NHNlWTVFOURFWVFDMTBEZnR6LzVVWVJ5NFlDTUJuRkZDaGFWSUwwSmxLNlM4?=
 =?utf-8?B?UFk4ME8wWWxONlFLVDdyYjgrRUFGTTV1R01wYXZTZDl4TWMyWDNieUZPMnBj?=
 =?utf-8?B?SDhwWVVTNzRrOWRSdXZRd2Q3RnNnS3VvamV0aldicWtZaW5VUHF2c3pXeG5Y?=
 =?utf-8?B?WThuNlJsYXV2YUtEQXF0cmJ2NElXTGxOb0pOWXV1ZW5IVGd4RGl0bHloaGdW?=
 =?utf-8?B?cmljZWZ3QUZVeE9WdG5CWENCVzlOTVdtUnlVNzQ2QlgvMmpvam0yZW0yNXl4?=
 =?utf-8?B?K0VSb2lGU0wrN2kwbThpOFl3cElZOGhVV25neXFHaS9hdG5MVzJqMyt2emN6?=
 =?utf-8?B?SXgrQXB3cXlNeS9MaytHWGpOME4zUitQdlhpMzJLKzlUeWtOd0RVSkxvdXgv?=
 =?utf-8?B?dnZQR1FXYTFja0QrNHZaZmgvcCt4UGRjTjljMFRXNXB1cDZOaWRveXVtUFpo?=
 =?utf-8?B?dklVS0FlOTNlV3JUZXNvcWdjYXBPdUxEYVUxUzZkZFBvYml5dzdJRTllUmdR?=
 =?utf-8?B?MWhHU3JTVzdSdXhzd3RNeTZSOVZCTGhtRE5MeDF6WFZuZXdJUDhvbXlvZGdi?=
 =?utf-8?B?UTlLY0ZmOElueXRFS3Q4VmVEemNPK3VvZjV6WHU4MUVNUTVxYTRKVmdnOWUy?=
 =?utf-8?B?UVZGUDkxMHZQSnhmWUlhSURtTHVyaHFJUUZtRmVPbEkyT0E1Y2RnWHN5R3lZ?=
 =?utf-8?B?N3ZCV3N1MHVpWVJsUU5KS2tCT091eWhGNWRYOGJ2UDdKZGh2MnpuS21DTUVO?=
 =?utf-8?B?Q2tnajFmcnorUm1CbXpFU1dvT2ZwaFFXaU1RYk80OWtuUE5waUp2TWtscmdo?=
 =?utf-8?B?RXJQaFJqdUJOODE1ZmhhRFhJKzYyeStVeFFHOXBTa2d5S2s3REcwNXRnSXp1?=
 =?utf-8?B?OEpvZHpLNmlTUGFldUptei9Tclp0bDBONWJkaElhdXRXOW1yZllVOXdqUlAr?=
 =?utf-8?B?MzlLQ0hGVzg0dnJmcmpRMXNNMjMvcUNwR2NMMjNNQ1J0dHF3cHlKTHZ2OXY4?=
 =?utf-8?B?NkIwcHc5OSt4Q29USU1lWm5Sb0tMa0NsajhvKy9BT1NtUzNnS0gxKzBEdlNq?=
 =?utf-8?B?VmlsZHMzTldPalFpc0FOdzEybW8vVjVVZ2I3TW92Ymt5YU9XeTlzVXJIMTBU?=
 =?utf-8?B?N2ZvNXByWWNoRHE4dFFjK255bHZoZ2M2Wnl5UVVRc2FIS2MzdDdVTTNIUk9k?=
 =?utf-8?B?cGgrUUoxYzkzSk1STFhaeU91cG1MdzRMUkVINnBqNDF2MFBrUHdZTVRjTFM4?=
 =?utf-8?B?TFZGQklkTS9ScGRhUUdxUWdrZk14d3V1NlBnK2o3a1JKQnVxbzV4bFZWVCtu?=
 =?utf-8?B?eTI1cmVpQXVTemk5WWZSZHcwTHIxL2srekR4WC9IUGxVRTdXZzNDQjhrTFdq?=
 =?utf-8?B?OTllV2Zsbkp4UUpaMnhudHVuK292Qnc0WUJSWG84SzJPb2xiWXQ1YzNqWU9E?=
 =?utf-8?Q?Xq+b4p2IS5c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6838.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0tlekZLRDl6N3VRdlhMZVRvc3h6c2hCVGFITEEveC91TndVbDUzVlZZNWtZ?=
 =?utf-8?B?ODl5THNPVHpYd3pFdTlTWHUrWFc5WGFUbFd5cndpaitqMGZWKzJXQmFqL1pu?=
 =?utf-8?B?TTM2VmRYK3g2TUJFUkJWU0F6VTl2bDErbEF0UkU4MWxRZmJNS2NPT3d6S1JM?=
 =?utf-8?B?cmZ5dWwxazNJdjVaUWpUTENBS20yZ2ltY0FJc1VQWnE5TS9tSlJCcHJBQkpQ?=
 =?utf-8?B?VG42SmtuSUZHd0hpbEhvYXhaT1Y3WHBUZlJEdzR1NnM0NHpiUnNBaDNVS0N0?=
 =?utf-8?B?VVBpOUQ1OWFuTGJJdE5jTHhsL0Q0RGVqRWJiYUdXc0diK3hOaHBLT1VQWjI1?=
 =?utf-8?B?WnNHTmFkRkhvQy8yK1UyaWJiZ3pRdXc4cDZ3Y1FDNlgxS2drVnBuUCtscmdJ?=
 =?utf-8?B?VUJlaUVhVHFKNGRYSCtTUjFYeUlFU3RsOFErZzkzbHdLWjZua0JFanpSZTZR?=
 =?utf-8?B?ZTA2eEl1U3NTUTdZc0c0UG5nM0pmS3dPOGZsR2ZkUlVSZno5djg5Q3l5Y2dZ?=
 =?utf-8?B?ZWZhUzRPblZUdE16cDNrTm1TNEJlVy90OGhtWFpVZldJNWVodVRDT1pMOER5?=
 =?utf-8?B?bURDelVZZEdQRXFJSU0wNEEzQmJ0NktUdzdleXF4MGV5aks4UDh6RlBidXFz?=
 =?utf-8?B?NGhjL0NyaXUvS0FGVlJidnloci9wMnEzRXcramdwamw4TFA1UXBXZEFHQUVo?=
 =?utf-8?B?bXBGQ0U1R3dXSDZySzZsbmZid2ZxWjRFaDZqVTlLWmtON01iekZnVnlhU3hL?=
 =?utf-8?B?bkw5d2hOUldoWTAvWUxxM3NhNDVFT1FZbDBCQ2RsSnJKWVpzUE9vcC9kV1pR?=
 =?utf-8?B?MGliUEo1TENJWDR5MUI3ajRxakdxRWsxQjdUeVduRFBZKzZyUlBSbktkTHRv?=
 =?utf-8?B?QzIxZFBzSmZyZjFlUkJoNXB3RmgzbDBlVGl5MTBtKzVWUGZ0emVWTEFxUUVs?=
 =?utf-8?B?cEhkUThCejV2ZE1ONDhqN21qK3Jlcmg4V1ZlczJacWZzNGZpV1R3emhIVTRm?=
 =?utf-8?B?djFvbHJtcGtmK0hzSnZ3Y0xVczVaQjR0aVE0NUtFbXcxbmtkbzJsbjQ4bHhp?=
 =?utf-8?B?c2JvV2JtK1g0dHUveWthQ3k5R29PSkZUQ1Q0Wjl1UWpiUll6RlAwYzB4K0l4?=
 =?utf-8?B?QmJQUzBjV2JnYXV3RVRWdmNXQmNYemdtN1hhTElxcDBPOE1wNmp4WSszQ2Jr?=
 =?utf-8?B?bkNyMW9KbU42RlpycWpMTURYQjYrSHFYbWZ3NmkxNTN0WmV2Tm5BYm9HNGRB?=
 =?utf-8?B?UXpqUFpoZ1IyTVZpTktmN0dsTG1vRGhML2hGYmlYMS9CeFRRYnZjQ0wwSlZ1?=
 =?utf-8?B?c24yd1NNeXRnTHFOTXlPNHhCQkxFbjlZaDJnbDdubDlVUysrNFdHaGhaMkpw?=
 =?utf-8?B?WFc2SllHSU51OW84NDFvZ3Z5bXJuNGVTOFM4WXgzZytFeTNnZVd5VCthYjZs?=
 =?utf-8?B?ZGoxSWRTaDhYMmpPdU1IMHlLWFAzWG56OXp1dkpVOTViSHo1T090Zmk3dFpQ?=
 =?utf-8?B?cDgxeDMyRGdZd1FBa3BHeVV2VWgvQXJxbGFBdTVzV2dWcEZlK2I1V1d5Y21R?=
 =?utf-8?B?eEQrOExVZGFJZS9ieTVvallkbk1nQTVYa09kTUNYdjlqMUd3VHBnYlJHRVJt?=
 =?utf-8?B?RjhMaXQ3cklKSGwwMWo0VGxZVmV2RDExTHNMQVhPS25RUEIyVkhlTFlsaUQz?=
 =?utf-8?B?WHphN0llNGRWaGU3TktPaDVsWVZCZlcxSWlXbHRMZ1FWUGFpZCtyYjBYeUZ2?=
 =?utf-8?B?c1ZzcjJNcXNzVUNUeHhaZCtPY1pIUTRFTitNZUMwdWNzYjhGbTk5R3JzaUgr?=
 =?utf-8?B?WGxkNENBNWxMSDRLdmpyUEtvNk5oTDRxNWxYZ2JvNmUrcUJDL3hidi9TR0JV?=
 =?utf-8?B?alBXWkxrZnhRV1lhTWx3Q2xneTV6NVlDUDhnK0F1cEdjdExLYXcwdlYwM1ZG?=
 =?utf-8?B?WXRwNHZLQnNibUFMSkp4RFpKNFA0RGY4TTJpT1Zuc0pvZ2xsdFFNNTRLbzlo?=
 =?utf-8?B?QzdKMGNocERYWDZRSnQyU3JxRlNWR0VIMDgwOFRMYlA1eXlJTTFRUWM4WkJs?=
 =?utf-8?B?VnlhUHAwK0Y3aFVVUXpuODlwZW9GRHM0T1ZvOUo4dGtrdDJLYWVQMi9jTWJB?=
 =?utf-8?Q?QPV9FhXfDKLQkNO9dWsY+aAnq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4b4027-946d-4981-8c4e-08dda45a8ba9
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6838.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 17:58:15.6220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1522F3M3/oEQ30qNby+CELwCvmeMT9ATpEQpIbhNHi/fYqlGS9huCLLli5yv3JYu8SBXHX9f4FmH5dyb5Mk/PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8859
Received-SPF: permerror client-ip=2a01:111:f403:2414::628;
 envelope-from=nathanc@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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



On 6/4/2025 7:34 PM, Donald Dutile wrote:
> On 6/4/25 10:02 PM, Nathan Chen wrote:
>> On 6/2/2025 8:41 AM, Shameer Kolothum wrote:
>>> This patch series introduces support for a user-creatable SMMUv3 device
>>> (-device arm-smmuv3) in QEMU.
>>
>> Tested-by: Nathan Chen <nathanc@nvidia.com>
>>
>> I am able to create 16 SMMUv3 devices in a qemu VM with emulated 
>> devices properly associated with the guest SMMUs in guest sysfs - 
>> verified with some guest SMMUs having two or three emulated NICs 
>> assigned to them while other guest SMMUs have a minimum of one assigned.
>>
>> Thanks,
>> Nathan
>>
> Nathan,
> Great test!
> Can you share the xml &/or qemu cmdline, to demonstrate this broad 
> capability?
> Also would be a good reference when (we know it isn't 'if') a new/ 
> different config
> that wasn't tested shows a bug, and we'll have more info to work with.

Yes, here is the qemu command line I used. smmuv3.15 is associated with 
two devices, smmuv3.0 is associated with two devices, and smmuv3.1 is 
associated with three devices:

qemu-system-aarch64 \
         -machine hmat=on -machine virt,accel=kvm,gic-version=3,ras=on \
         -cpu host -smp cpus=4 -m size=16G,slots=4,maxmem=32G -nographic \
         -bios /usr/share/AAVMF/AAVMF_CODE.fd \
         -device nvme,drive=nvme0,serial=deadbeaf1,bus=pcie.0 \
         -drive 
file=/home/nvidia/nathanc/noble-server-cloudimg-arm64.qcow2,index=0,media=disk,format=qcow2,if=none,id=nvme0 
\
         -device 
e1000,romfile=/root/nathanc/efi-e1000.rom,netdev=net0,bus=pcie.0 \
         -netdev 
user,id=net0,hostfwd=tcp::5558-:22,hostfwd=tcp::5586-:5586 \
         -netdev user,id=net1 \
         -netdev user,id=net2 \
         -netdev user,id=net3 \
         -netdev user,id=net4 \
         -netdev user,id=net5 \
         -netdev user,id=net6 \
         -netdev user,id=net7 \
         -netdev user,id=net8 \
         -netdev user,id=net9 \
         -netdev user,id=net10 \
         -netdev user,id=net11 \
         -netdev user,id=net12 \
         -netdev user,id=net13 \
         -netdev user,id=net14 \
         -netdev user,id=net15 \
         -netdev user,id=net16 \
         -netdev user,id=net17 \
         -netdev user,id=net18 \
         -netdev user,id=net19 \
         -netdev user,id=net20 \
         -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0 \
         -device virtio-net-pci,bus=pcie.0,netdev=net1 \
         -device virtio-net-pci,bus=pcie.0,netdev=net20 \
         -device pxb-pcie,id=pcie.1,bus_nr=200,bus=pcie.0 \
         -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1 \
         -device pcie-root-port,id=pcie.port1,bus=pcie.1,slot=1,chassis=1 \
         -device virtio-net-pci,bus=pcie.port1,netdev=net2 \
         -device 
pcie-root-port,id=pcie.port17,bus=pcie.1,slot=17,chassis=17 \
         -device virtio-net-pci,bus=pcie.port17,netdev=net18 \
         -device 
pcie-root-port,id=pcie.port18,bus=pcie.1,slot=18,chassis=18 \
         -device virtio-net-pci,bus=pcie.port18,netdev=net19 \
         -device pxb-pcie,id=pcie.2,bus_nr=196,bus=pcie.0 \
         -device arm-smmuv3,primary-bus=pcie.2,id=smmuv3.2 \
         -device pcie-root-port,id=pcie.port2,bus=pcie.2,slot=2,chassis=2 \
         -device virtio-net-pci,bus=pcie.port2,netdev=net3 \
         -device pxb-pcie,id=pcie.3,bus_nr=192,bus=pcie.0 \
         -device arm-smmuv3,primary-bus=pcie.3,id=smmuv3.3 \
         -device pcie-root-port,id=pcie.port3,bus=pcie.3,slot=3,chassis=3 \
         -device virtio-net-pci,bus=pcie.port3,netdev=net4 \
         -device pxb-pcie,id=pcie.4,bus_nr=188,bus=pcie.0 \
         -device arm-smmuv3,primary-bus=pcie.4,id=smmuv3.4 \
         -device pcie-root-port,id=pcie.port4,bus=pcie.4,slot=4,chassis=4 \
         -device virtio-net-pci,bus=pcie.port4,netdev=net5 \
         -device pxb-pcie,id=pcie.5,bus_nr=184,bus=pcie.0 \
         -device arm-smmuv3,primary-bus=pcie.5,id=smmuv3.5 \
         -device pcie-root-port,id=pcie.port5,bus=pcie.5,slot=5,chassis=5 \
         -device virtio-net-pci,bus=pcie.port5,netdev=net6 \
         -device pxb-pcie,id=pcie.6,bus_nr=180,bus=pcie.0 \
         -device arm-smmuv3,primary-bus=pcie.6,id=smmuv3.6 \
         -device pcie-root-port,id=pcie.port6,bus=pcie.6,slot=6,chassis=6 \
         -device virtio-net-pci,bus=pcie.port6,netdev=net7 \
         -device pxb-pcie,id=pcie.7,bus_nr=176,bus=pcie.0 \
         -device arm-smmuv3,primary-bus=pcie.7,id=smmuv3.7 \
         -device pcie-root-port,id=pcie.port7,bus=pcie.7,slot=7,chassis=7 \
         -device virtio-net-pci,bus=pcie.port7,netdev=net8 \
         -device pxb-pcie,id=pcie.8,bus_nr=172,bus=pcie.0 \
         -device arm-smmuv3,primary-bus=pcie.8,id=smmuv3.8 \
         -device pcie-root-port,id=pcie.port8,bus=pcie.8,slot=8,chassis=8 \
         -device virtio-net-pci,bus=pcie.port8,netdev=net9 \
         -device pxb-pcie,id=pcie.9,bus_nr=168,bus=pcie.0 \
         -device arm-smmuv3,primary-bus=pcie.9,id=smmuv3.9 \
         -device pcie-root-port,id=pcie.port9,bus=pcie.9,slot=9,chassis=9 \
         -device virtio-net-pci,bus=pcie.port9,netdev=net10 \
         -device pxb-pcie,id=pcie.10,bus_nr=164,bus=pcie.0 \
         -device arm-smmuv3,primary-bus=pcie.10,id=smmuv3.10 \
         -device 
pcie-root-port,id=pcie.port10,bus=pcie.10,slot=10,chassis=10 \
         -device virtio-net-pci,bus=pcie.port10,netdev=net11 \
         -device pxb-pcie,id=pcie.11,bus_nr=160,bus=pcie.0 \
         -device arm-smmuv3,primary-bus=pcie.11,id=smmuv3.11 \
         -device 
pcie-root-port,id=pcie.port11,bus=pcie.11,slot=11,chassis=11 \
         -device virtio-net-pci,bus=pcie.port11,netdev=net12 \
         -device pxb-pcie,id=pcie.12,bus_nr=156,bus=pcie.0 \
         -device arm-smmuv3,primary-bus=pcie.12,id=smmuv3.12 \
         -device 
pcie-root-port,id=pcie.port12,bus=pcie.12,slot=12,chassis=12 \
         -device virtio-net-pci,bus=pcie.port12,netdev=net13 \
         -device pxb-pcie,id=pcie.13,bus_nr=152,bus=pcie.0 \
         -device arm-smmuv3,primary-bus=pcie.13,id=smmuv3.13 \
         -device 
pcie-root-port,id=pcie.port13,bus=pcie.13,slot=13,chassis=13 \
         -device virtio-net-pci,bus=pcie.port13,netdev=net14 \
         -device pxb-pcie,id=pcie.14,bus_nr=148,bus=pcie.0 \
         -device arm-smmuv3,primary-bus=pcie.14,id=smmuv3.14 \
         -device 
pcie-root-port,id=pcie.port14,bus=pcie.14,slot=14,chassis=14 \
         -device virtio-net-pci,bus=pcie.port14,netdev=net15 \
         -device pxb-pcie,id=pcie.15,bus_nr=144,bus=pcie.0 \
         -device arm-smmuv3,primary-bus=pcie.15,id=smmuv3.15 \
         -device 
pcie-root-port,id=pcie.port15,bus=pcie.15,slot=15,chassis=15 \
         -device virtio-net-pci,bus=pcie.port15,netdev=net16 \
         -device 
pcie-root-port,id=pcie.port16,bus=pcie.15,slot=16,chassis=16 \
         -device virtio-net-pci,bus=pcie.port16,netdev=net17

Here is the guest topology:

$ lspci -tv
-+-[0000:00]-+-00.0  Red Hat, Inc. QEMU PCIe Host bridge
  |           +-01.0  Red Hat, Inc. QEMU NVM Express Controller
  |           +-02.0  Intel Corporation 82540EM Gigabit Ethernet Controller
  |           +-03.0  Red Hat, Inc. Virtio network device
  |           +-04.0  Red Hat, Inc. Virtio network device
  |           +-05.0  Red Hat, Inc. QEMU PCIe Expander bridge
  |           +-06.0  Red Hat, Inc. QEMU PCIe Expander bridge
  |           +-07.0  Red Hat, Inc. QEMU PCIe Expander bridge
  |           +-08.0  Red Hat, Inc. QEMU PCIe Expander bridge
  |           +-09.0  Red Hat, Inc. QEMU PCIe Expander bridge
  |           +-0a.0  Red Hat, Inc. QEMU PCIe Expander bridge
  |           +-0b.0  Red Hat, Inc. QEMU PCIe Expander bridge
  |           +-0c.0  Red Hat, Inc. QEMU PCIe Expander bridge
  |           +-0d.0  Red Hat, Inc. QEMU PCIe Expander bridge
  |           +-0e.0  Red Hat, Inc. QEMU PCIe Expander bridge
  |           +-0f.0  Red Hat, Inc. QEMU PCIe Expander bridge
  |           +-10.0  Red Hat, Inc. QEMU PCIe Expander bridge
  |           +-11.0  Red Hat, Inc. QEMU PCIe Expander bridge
  |           +-12.0  Red Hat, Inc. QEMU PCIe Expander bridge
  |           \-13.0  Red Hat, Inc. QEMU PCIe Expander bridge
  +-[0000:90]-+-00.0-[91]----00.0  Red Hat, Inc. Virtio 1.0 network device
  |           \-01.0-[92]----00.0  Red Hat, Inc. Virtio 1.0 network device
  +-[0000:94]---00.0-[95]----00.0  Red Hat, Inc. Virtio 1.0 network device
  +-[0000:98]---00.0-[99]----00.0  Red Hat, Inc. Virtio 1.0 network device
  +-[0000:9c]---00.0-[9d]----00.0  Red Hat, Inc. Virtio 1.0 network device
  +-[0000:a0]---00.0-[a1]----00.0  Red Hat, Inc. Virtio 1.0 network device
  +-[0000:a4]---00.0-[a5]----00.0  Red Hat, Inc. Virtio 1.0 network device
  +-[0000:a8]---00.0-[a9]----00.0  Red Hat, Inc. Virtio 1.0 network device
  +-[0000:ac]---00.0-[ad]----00.0  Red Hat, Inc. Virtio 1.0 network device
  +-[0000:b0]---00.0-[b1]----00.0  Red Hat, Inc. Virtio 1.0 network device
  +-[0000:b4]---00.0-[b5]----00.0  Red Hat, Inc. Virtio 1.0 network device
  +-[0000:b8]---00.0-[b9]----00.0  Red Hat, Inc. Virtio 1.0 network device
  +-[0000:bc]---00.0-[bd]----00.0  Red Hat, Inc. Virtio 1.0 network device
  +-[0000:c0]---00.0-[c1]----00.0  Red Hat, Inc. Virtio 1.0 network device
  +-[0000:c4]---00.0-[c5]----00.0  Red Hat, Inc. Virtio 1.0 network device
  \-[0000:c8]-+-00.0-[c9]----00.0  Red Hat, Inc. Virtio 1.0 network device
              +-01.0-[ca]----00.0  Red Hat, Inc. Virtio 1.0 network device
              \-02.0-[cb]----00.0  Red Hat, Inc. Virtio 1.0 network device

Thanks,
Nathan


