Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A42FC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 12:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tusDS-0001EE-U1; Wed, 19 Mar 2025 08:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tusCh-00019z-0w
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 08:07:29 -0400
Received: from mail-co1nam11on2062f.outbound.protection.outlook.com
 ([2a01:111:f403:2416::62f]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tusCe-0006FW-U3
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 08:07:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnYswSPFuVntvUSWQ5I8xQ1FPED+Rz/lRV51MzUFUkJG4hMorxkVFm6gFvF1rdFtLJSmtlUi0KrNCMKJ551VX7e6kcTfpG99sDkwfh+URQR/884IcwPplUdryButgSkH7+yAhV4igwUBQKZUJ0rowswLs/Bcgh1oE1mqgFPXr+4UcR5Ue9ayfqSoySUP+CZsRC1jInK5JveQU0HcRRKuaTpc1A5Fba4Cmz0dOtCOQD5yP0wmxGK63bFQGMrcqzqDFg8Kdu5RphLr1Y/s+rhQ0KZaBGX2YNow7PaIueqhLGu+ReYYJL11T9Ik8dKfWHpv/1SlzaBtv/EfZCn7xvLitA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcMS479A8/WW9LBrOrn1UhNKOfk72muMZjlTMLhBwLc=;
 b=No/09cxYpcTLCKhU+C6GSBlauXbqkzD7yxwi4wsr9eCVNtSA92yXBKRCkAX7+Qo9GFyy1iTRZlvegYwrOE5Ntd+lJZ7PhLUuNEEKUMSCT4IsyXnT8nF9a82yyHBjs7VvRQQcbFOvmGFEc74+tv1CfbVHZcHZXKvC0pjwcDxtqnZ3M+VBaXkgiHdEJS0eeYvQmgiooRKBwG6eLUjTLYnceqEe7ADU+LB2xTBnLtIhYQYkXbuV6A2BYL+Fut4pE27gBx21v7zIHWlz0xr4CUSFEhRsmph/fogKc3DZF0dnn97Y+PHf1RHOr9mrSX6k1WTN5WATK9OXDMgF+UwV7S08tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcMS479A8/WW9LBrOrn1UhNKOfk72muMZjlTMLhBwLc=;
 b=YxFn6EkqnPDiKBXMGlFeD57SPdA7QIf3vYyM6E2R7HdKBKs8VOI4wQKytyTbBr2juBxyVTxc36Ti5sFLMaR2gdlTfKAAN2tYVRu95OfkpKe+4Pc13ziI7xk/X8//cDsqtgBnwdEKH2OQ/3T7CIJSRTXuHNqHFvHu4G7MSsuIVLb/E7sRTSGrG3p3T5HQS+zpxk9pGlsz6Okghkz0ogetMnLqte5syiKkfJ3WLljSjLGHJTP8Ju6itgEgZ5COMP5n3SoDmOGKqXSslSqv82GPoLPLHZ3ftcWRPMglO1lV87Gx1DwSJCMicKpRnHwVg7i/RoatpfkxNNUdFJwxgRLwsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 12:07:14 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 12:07:14 +0000
Message-ID: <c8c54e5e-8971-4be1-b7b4-0ab00abd96be@nvidia.com>
Date: Wed, 19 Mar 2025 14:07:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 02/32] vfio: Rename vfio_reset_bytes_transferred()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-3-clg@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20250318095415.670319-3-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::12) To BY5PR12MB5544.namprd12.prod.outlook.com
 (2603:10b6:a03:1d9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SJ2PR12MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: 977151b4-1908-4990-6d13-08dd66de9562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGhuUnRiajdsWkdtY01kSllmUDlHbUlFVVZ5S3A2Rm5uNVR5MVdXeTl3ZkFZ?=
 =?utf-8?B?ZFRNM2N6Q1hRMVFCSHAyRkN5U3lLcjV0YXdEMWwwd0FSamY0d3VPaU9TZ3Ix?=
 =?utf-8?B?d3VCbTlEU2hNT3lrSWRzSlk4ZG9oRUVtVjRXcUtSTHJ4NVhUK3pqVXNBYXZW?=
 =?utf-8?B?ZXFQUktvRk9KWFJqK01BaTVReFM4VDlhdnRRbkFueDJGTTBaRHl0OTFoWVd3?=
 =?utf-8?B?UEZjc2JnRmRnZS9WZDhyRlZPZSthREVUMU13RFFXSE9NcWdXS0pMQVdYQjgy?=
 =?utf-8?B?SUJ0VGxBZFJNbGQ0Nmd1Ri9XWUd6dVkzMlllR2N2MUY3Q09HZDYvaTZuMkZK?=
 =?utf-8?B?bzdUdXRnTzJ5RWxtY2pLZmRCREp4aG00SUNpK1lyWlllanVrbWpSRGxUYWtY?=
 =?utf-8?B?TWI3a0NvVll4ZWJQOTh3YUVuRVpzeUxKR3MyL1JEMU5uY0YwWGt5SnlXR2R2?=
 =?utf-8?B?ck9IQW9XNDlBYklHUExwSzZoVWYyU3V2SGIyRW5WaVRBdnZyZWtKbWZkWEwz?=
 =?utf-8?B?Z1I3SUZneVdtSzdzRHRueTRkalNJWEhjRkVpdFBGNWlKQm5WamdsdXlyQXg0?=
 =?utf-8?B?b0dZdjNvMERtWHF4Unh5MldoVDJBWHdVbEd3WTRFQUFqLzlMdHZlanpyRHBI?=
 =?utf-8?B?MlE4SjhudTd4a0ZIL0w5NlkvM2oydWZEV3FwMGlNdU83MXVTOWF4d3IzWWdp?=
 =?utf-8?B?MmxjK2VxUjBGbkN5YVA0TUlINUNsWXJRd2t5WUg2NUNNdmE1WVFLUWVIRGZ4?=
 =?utf-8?B?dU5xbWJWaDBtM1lPRG8zdS9Vb1lFOTVDMWptMGR3N3lXWDB2VXk1em1tRTgw?=
 =?utf-8?B?Uy9OcEpGYmQyMnlzZnpFb0FqdWJJdlZZdWsvVFNyNjlDMEFxVHRVRDRLaGdU?=
 =?utf-8?B?dHA5K25XVSs0YWREQ3RpTzZFaXE1Qnh5UDNyTWQreSt4MmNaa1J3MjJVdTRn?=
 =?utf-8?B?bmlKWU5FMTZOR3NiTlMwbTVmdkMzSmpTUlB1Nk5hMjFHQmJDek9MNWR2VjVK?=
 =?utf-8?B?UTlvb0tKWlpQWXdMTzIwNkhISlFPajVqd1FpSlZEdk8wL2Q1ZkdwUVBPekFo?=
 =?utf-8?B?T1BUb0lQdkhZTVhDcnVsdC9OcFlNalRLaWc2S1pYb0FBbDBlRnozYlJxaURm?=
 =?utf-8?B?dkdjUGFLUlVXbHNRZnM0QjlHVU4yS2hhZzhsUG40Q1ByT3hJNTc1SVpnc3pa?=
 =?utf-8?B?TGkvV1J6endITmdIaWdZTmtoM0MvOWNFR3RCN0dZd1ZlcDhhc3liaHp0MVU2?=
 =?utf-8?B?SnJWUDhTZnovSTRuVlRUNjdGWFh6a21GS3FTelJIcGlPM3NnKzlHYjdBQ0ZE?=
 =?utf-8?B?R0tyc1NtY3BDVkxKVlhxcXJuZURrOTJKS0ZQMnV4ZGhKM3BXazF1SG9Wd1Mz?=
 =?utf-8?B?amkyQmhkd0V2Z09rVm1mZnErSlpyZTZuY0lDcThCWlNxdGFtTVNZRVVQRVBG?=
 =?utf-8?B?ZkhnWEZxaktrK0ZWQk5YRVVkSGZYRFZ5Mmt2dGFIN3lHTDUwK1R6NER6Rm9X?=
 =?utf-8?B?TnpyYk45UktiNy9NTzBaQnYza1hKR2NSQXY0clNtNFpPOUtoWDZpL0UydzZP?=
 =?utf-8?B?alJVNThRc3pyYTdxVWRlL0dQOVF4WnpsNndra1pOMVc5WmtJaHNraTRSRkxt?=
 =?utf-8?B?ODZJS0VVazd5UmU1alVMdUpGN2pHd1NIZnpuMnRmVlJ0T29lZU1sOXB1SlR1?=
 =?utf-8?B?Nkxld3BadVhmYWtkWG5MQ1dNU2VVYWV5RXhEZTMyYjhUVjVtd1dNcVlveGhu?=
 =?utf-8?B?R1pORzc4S0lGT2xOZlYxVW5hK2VMRENqdnR5M3B6aWw0UE0vbVovL29YUDlS?=
 =?utf-8?B?am5QNklGMStJSTRoVEw3Q1NEUkZOVTBKcmtDQzd1YnRuamJEdHF6YS8rZTlY?=
 =?utf-8?Q?VTd6U87EBueEw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elp3bUVEZlgwZDdCS1NrbUdqVmRSNmg4b2JBUzlySkU4UzFqRFhscUgwR0Np?=
 =?utf-8?B?Wko1ZThBb24rSDFKcnhhaFNpc3ZJUXNWYzZ5SW1JOUZyRlJRU20xSm53MXVV?=
 =?utf-8?B?ZWdiS0lXUXRvQlRZZmhQNThGV2VJODhvUlhpeTh2Y1FBOUZsV1FUNk5oUDFh?=
 =?utf-8?B?YjZkOVkwTWJ4LzZTYnVOcmxMMUEzMVJEYXJxQUw0M3VVQXBCbTNyWVFPdElK?=
 =?utf-8?B?TDFkZ09SWEkreGo2bExrSkEzRnp5MW41dm84cDJwUGt4R09IZE5iMmltTlJT?=
 =?utf-8?B?VFNHT2pVV2FVWHMyRDM5T3hpU0ZWMmpoQ1NMcnN4eVBNaTdwT0prMVJrL1BV?=
 =?utf-8?B?QkZ2b3NUMkUzc1Evd081Slk2NzAzRExJS1E4SWFVb0VSNGVYQXRUV2pxVFpF?=
 =?utf-8?B?bkFydytNTExGcUlMY1JkQkJvK3ZNckJJMEV2R25lRkhaNGtyN1I4ejUyUTkz?=
 =?utf-8?B?NXRwUjltelJDaE5GNHRuQVlocklwUHRLYTN5WDEzeTdQMmtWWUxxQjM1S2NY?=
 =?utf-8?B?VExqWVcwbVpvT2krWHBkWTQ4eUdTS201aDhVVCt1bDI3bmNYTmhBVVVMM2tJ?=
 =?utf-8?B?T1A1SlQ2a2RHNW1ZT2ZHL0w3ZDRRcjNUYTlrZnRETTR4eTFkWWtDQ3ZYQXgz?=
 =?utf-8?B?ZllhcXF4d0xzSXVqRTB2OVFjbzBxUEZuMjVqT1BMdWgwenlOT1A0cFZQVkFG?=
 =?utf-8?B?RU1VSFk5UHFUSGFEMzJtc1hJVzd0MEpLT0FGTFB4eVB6ZGtzemtUbHNhWkxl?=
 =?utf-8?B?eDd4YUdKQkRVazNHSTYvVy83ZFlCWWErRGd2c0dHSk9DNkt1UUhCaWhsZFIx?=
 =?utf-8?B?WDNBejRRWW1WOWU4Qi9oYmQyWnQyMFZVUVM4aUFFcVUvQklCNFBMOFFqTXZv?=
 =?utf-8?B?ZWlxYW5BRFNxUXNiY0pFeHYyTUtHMTIwUHk4eFZIQzZHSjl1bGJBSU9BTTdN?=
 =?utf-8?B?Tkpia1VNT2x1ejRIOW8xbHdDYUp4M1JuejB1L1F6WEkzY2wyazM2RXNOek5a?=
 =?utf-8?B?V3BwREVMSVgxRGR5R3lDMDhwZ2t1YVQ1UnYvTWtKTzg2Y3ROMzVCVzJMMU5n?=
 =?utf-8?B?ZUJSS2diN2k4Y0JQVm8yTmc5ekxDNkR2N3ZkQlVlUmV0TVU4bWNrN09Tc1hP?=
 =?utf-8?B?eUZwSm5GbDgyYTlseHAxRklMb252OGFFd2oyMFUrQ3hFeU8zOHRvdmE4MjB5?=
 =?utf-8?B?dEtQcUdCVzE2dm1oMFBDVllVdDVOTlpmc210V1V3TVVwc3hqVVgxUGNXYWYw?=
 =?utf-8?B?OXNSbGhmWit0ajdiWFFzQ1IvUnBuUU1Tejd0RDhuN3RRQ29lK25PK1JpREtz?=
 =?utf-8?B?aVVQcVA0WGMvUEt2RUFZRTdrNGh6VHY4VkpabHd6WDVScjdZYXFWdlpvd0tu?=
 =?utf-8?B?Q2xhT0pKeUk0N0JtbXNVdU8zenczV0l2L2lnckovSUhmTWdubG5DN2YxSVVX?=
 =?utf-8?B?Z3oyQWVTZzRwTmZjZklLQXdmZEdrWnJpTmZ6M0NjcDV4SlluZlFiTzVUUUVu?=
 =?utf-8?B?b0NScGQ3SWIwbFFUMmpka0VlTDhORWFSYi8zQUM2Sk9Ec2F2ckdiTHJmMHdE?=
 =?utf-8?B?OUJzWDVwZ0ZrZEluaTQ2VEdpdDI1d3FMWHExWDB6ODR5cW13S0gvWStIMDBs?=
 =?utf-8?B?NVRQU3FWUmN5d3paMkR4YjF1bFd0YUtsWFZ2dnBkbFRzazlQS1V3b0lCa202?=
 =?utf-8?B?c28yYUJIKzNKR1owcWpRaGUvbjBXL2hHcklkNVZWbGFtQVo5UGpJM2ZLNVBT?=
 =?utf-8?B?MUVUYi84K2YxZkhaa0tGUGlGUEptL0pxWFRhbDAxT01nVkxydFlpMTQxQ09M?=
 =?utf-8?B?VzBXejRjNlhjbHRNR2pFMVlzaVpKZnp0UW5ENDJXTTFaYldFVU8xcTFKcEZo?=
 =?utf-8?B?UElSR2FKays2RDVXbk9OYzRrM2dMUWZQWjFRQXJVU0xuVGtWbHlxR1BrWVdT?=
 =?utf-8?B?MlY0Y0xySU9ZTmIwcCtiZ2lmOCtJNlFKQ0xDclJvMVQwUlhVY0pKTUZHOXJR?=
 =?utf-8?B?YkdGdUppOTc5T3ZJYTlTUXBoTEI4aHVqNWQ3VThpVEZiSHR0RkM3ZUlzUlpp?=
 =?utf-8?B?MFlvY0NzazNzalIrVzVqdDVUNXpaWGtDcGNNWjdydTdod2hseDFTZC9UcEdK?=
 =?utf-8?Q?k9irtf3tmTa5wI7ORl5Jzlhil?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977151b4-1908-4990-6d13-08dd66de9562
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5544.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 12:07:14.0293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grsO+UcszmVOo5kZzJY8iy25VvU66toxy6vlBM7KvBkM7PtDZilq0iQU//ptbIhJun6YXMZsRvBFmy1RQzVHXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8943
Received-SPF: permerror client-ip=2a01:111:f403:2416::62f;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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


On 18/03/2025 11:53, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> Enforce a 'vfio_mig_' prefix for the VFIO migration API to better
> reflect the namespace these routines belong to.
>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Avihai Horon <avihaih@nvidia.com>

Same nit as patch #1, maybe use vfio_migration_* prefix instead of vfio_mig_*?

Thanks.

> ---
>   include/hw/vfio/vfio-common.h | 2 +-
>   hw/vfio/migration.c           | 2 +-
>   migration/target.c            | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 04b123a6c929a8f47d740fc5433b54dadd32f731..9cfb3fb6931e71395ef1d67b0a743d8bc1433fdc 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -295,7 +295,7 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
>   void vfio_unblock_multiple_devices_migration(void);
>   bool vfio_viommu_preset(VFIODevice *vbasedev);
>   int64_t vfio_mig_bytes_transferred(void);
> -void vfio_reset_bytes_transferred(void);
> +void vfio_mig_reset_bytes_transferred(void);
>   void vfio_mig_add_bytes_transferred(unsigned long val);
>   bool vfio_device_state_is_running(VFIODevice *vbasedev);
>   bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index b5fb0d218808d010d8210612d3182dde8f33514b..8bf65b8e11094b8363692dba3084b762362c7dd6 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -1052,7 +1052,7 @@ int64_t vfio_mig_bytes_transferred(void)
>       return MIN(qatomic_read(&bytes_transferred), INT64_MAX);
>   }
>
> -void vfio_reset_bytes_transferred(void)
> +void vfio_mig_reset_bytes_transferred(void)
>   {
>       qatomic_set(&bytes_transferred, 0);
>   }
> diff --git a/migration/target.c b/migration/target.c
> index a6ffa9a5ce312d1e64157b650827aa726eb4d364..f5d8cfe7c2a3473f4bd3f5068145598c60973c58 100644
> --- a/migration/target.c
> +++ b/migration/target.c
> @@ -25,7 +25,7 @@ void migration_populate_vfio_info(MigrationInfo *info)
>
>   void migration_reset_vfio_bytes_transferred(void)
>   {
> -    vfio_reset_bytes_transferred();
> +    vfio_mig_reset_bytes_transferred();
>   }
>   #else
>   void migration_populate_vfio_info(MigrationInfo *info)
> --
> 2.48.1
>

