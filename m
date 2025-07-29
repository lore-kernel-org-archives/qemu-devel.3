Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C10C87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 13:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugkbY-0007l3-3v; Tue, 29 Jul 2025 09:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugkbP-0006St-4C; Tue, 29 Jul 2025 09:42:52 -0400
Received: from mail-bn7nam10on2060d.outbound.protection.outlook.com
 ([2a01:111:f403:2009::60d]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugkbF-00069H-GL; Tue, 29 Jul 2025 09:42:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMJ5xpALyEs6EblQd9DmXg5O9e+KHHHQDnnFPawXBfiE5eZ+DGf9pkXThBQhaVRx4vaodW3X+fCURLTUj/+v4SDdO75g2N2W9oqPtlUmTeFfFvZouRlYrKlA0JdFC0XMxZJFmV5OyiH48Lp+ukBhTjjLkIti4nKX15EXEn9WXLn4QdSYupXKdWM5x42iVY8ONHmXssAkipuah5MAU8fQGvl9idjIzyHir+kYHyo+IIdHjDuQqAtlYFVJg55e77vGkKSL4pUUqlMfA7jmXQwsI2Tgye1IY+21Q5Mp5FQLLoA3Un4qRaOTXDvmnONmlXcL+/2L/VkmA34wl2ksxT/JYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbBO2qJ6uFBCbeqgKrk1unvxXJuiK4EAli+LQFgwRcA=;
 b=bMOVwpm4dTEIBfHZ9u04D9b5zMkRxpalfIqNxeg2k+RhBpuRw2vAt9JT3uXdJVMm4OqjrqHXlkyNBqdGYy5rPlZWkt3pXAyJFJYO3inYMeVZdnd26zE11X6ZjjCn19kBS9niwXGJ11+KQjj4Pc2g1n3sEtJpDbR7WgXqbn6F8grk5vpFaGPck4AQtyUj7mdlt5N+7532Zx2jZll0YTUGwhtBaVosij54XmklUVZ52z62qPrrVyjEIFO6C+JHVJ5jTl5IN4Y1guMxuw24DpkSwdzIIlZaUaXGaOx/bqA6Ecl+0TG0iMqLj04eERPDCltdD/YVz3rdtL6Eh2IDylPZCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbBO2qJ6uFBCbeqgKrk1unvxXJuiK4EAli+LQFgwRcA=;
 b=ndzPNNWTD4M0yXhck2Ddxa98iAgDjRJn8h6z+bgjqgXWn4Clmj28ByBvK/S5n0rKZzs5lSrCX6bN/nn2kj8Z6gnDJchsEb2b53M/nR8G9J9wbn1pQdOvXzLpi7YsYArg9/K6Awz37Ixwq2mG7BXC8xmtSt5W6IJRjhjZilyAjrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by SA5PPF8ECEC29A9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 29 Jul
 2025 13:42:29 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 13:42:29 +0000
Date: Tue, 29 Jul 2025 15:42:15 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 13/48] hw/arm/xlnx-versal: VersalMap: add support for
 OR'ed IRQs
Message-ID: <aIjPt5gyFly6dxix@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-14-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-14-luc.michel@amd.com>
X-ClientProxiedBy: CP7P275CA0006.ZAFP275.PROD.OUTLOOK.COM
 (2603:1086:100:42::8) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|SA5PPF8ECEC29A9:EE_
X-MS-Office365-Filtering-Correlation-Id: d2eb2d3d-41d1-4443-9140-08ddcea5c2ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1JqcVVxR0VNNHczSmFNRXdlMVB0MWR0aUtnclhkRnkvUFpKeC9XWWtqMWRJ?=
 =?utf-8?B?c0h1dGRYMTJ3TE03MU8yWFJCSXhaMjhVNk1RVEVOMytuRWxuZ0l0dDVHemtE?=
 =?utf-8?B?WXJpcnNSaEVncDdVMmlTelhBRE5TdmZGSlVTQ0I2cHZ4M2RZVjUzSmdQeXc1?=
 =?utf-8?B?VHdKNngvUUdrVURnUlAraEw0SUF3Z1dCdHowZHRjUW5BaER6Q1N6d3dyVnJp?=
 =?utf-8?B?V1VEREcyYzJxK282QUtiUXR4ekxaOVc2bmdpZ0RzWTZBSzI2cGpnZG9HMWpl?=
 =?utf-8?B?cm9lVTdsdDJkUDJXTzBONjNFbWthOFNnU1ZjTEpORXV6SWIxaWpzQmY5UFRL?=
 =?utf-8?B?a1lVQW4rci9Va1ZHbVRQTy95MlB2NlFoaWp4Tm5PYVFRc3MweExsZytJN0dv?=
 =?utf-8?B?TlZzTGQ1Kzl0dkM4dnhIV1VKbEVlbFFjcmxjNytUSXFxRUNQbUFmWlhWWDZm?=
 =?utf-8?B?d0hqQ1Y2Kyt6OGFDYkk1NnZoK09kcTUyajR2R0ZaZUlBa0FFS0RlRWFuRzg2?=
 =?utf-8?B?YzQza0c4S2xIdTRhaFZMNkoxNTNmYnd0bTM3MUNYVUsxQUMyQnV3WWhyRngz?=
 =?utf-8?B?YkN5NENCWTQ5NVRoY2JROXBid1g5RUl2ZVgwZ3B1dkNSS3RJVFpXck1iMVpw?=
 =?utf-8?B?eGtaVkpKdHptem13YkhzTWFnMkwrUU5aQk1TTU5Cc2Ftd3dWSUJSemlLTmQ2?=
 =?utf-8?B?dzNEbVh3WHV0MG95S1Uvek44d1Vod3U0SEtlekxudG81TmQzQzFPSVhucWlu?=
 =?utf-8?B?VG5jRUhSUVVQT256YjArOHRhYldXQXZHeEEvaDFsUnJFMmREOFVXdXhqK21I?=
 =?utf-8?B?dTVOOUE4bDRHd0Jhd2JZajJMYjdpVWpqNEY2bGRuREFPNlVhYmh0allsSm5J?=
 =?utf-8?B?STdrMHZQWlQ5RTc1WEJ2RkNkQ0g3aUp3dW1LZ0FLSE9IZ0RSSk1DaHppR2kw?=
 =?utf-8?B?bUVYai9UT0d6amI1bVdidGcxcDJWMkhucWgxYVBlcy83czdwR29pVTdSR0xh?=
 =?utf-8?B?MTJOM1lwM1VmNzIwcXF1Mjc1MVJpV0RjUjBEbitNN1EwdzB6ZzhLM0FETWQ5?=
 =?utf-8?B?YlRpZGtJLzZlWEE2UHoyQTJNbU1ERnRKeW55bWlLc0hVb0liRWYyYnlwK1Zr?=
 =?utf-8?B?a3J0Ylh2TlpZRmlCdkRDcGlWbWFJaHlJaFVoSFZ6S2Y2Vk9FVldHaTBPZU5s?=
 =?utf-8?B?SVo1N3hCZEQ3OEFPQm42ZU5wU2wvTGVCSnptVGZiVm1SU3JvSHFkMVpiVGR2?=
 =?utf-8?B?enRYVEt6Wkp3aDk3NnR3Rk5sd0dTL2dGbDBCeDdnVUhmUXN1NEZFVVJXOStL?=
 =?utf-8?B?ZFdkRTNPREgxNkRQTWZnN2t3RWdYc2lMOVNxYVVCT0F2Q1QxbmNpVFNqSDdD?=
 =?utf-8?B?eTFCaitiSjZyZ2lXNnVnMHJQR0FkRzg0ejFUWjhJWlZLNGEwQ2VMNHRyRHIw?=
 =?utf-8?B?UjViTm52WGg5SkREdUV6dUNpdkdHNndlb0hWSVo0allTRGFINk56OFI2MXpw?=
 =?utf-8?B?TVJQT2dQQjVDUWdUYXduQ2R3U3RJQ0JkRG5RZHNmaUNGSW91a0dFUUp0NmEv?=
 =?utf-8?B?cXRXcHBYZ2hxbjJReWVRcjk5TElPaWtoU3BaYVF5ZlFQdXRWeWZyNC9MTXU5?=
 =?utf-8?B?bFlkVmJYZ3JWV2lxZUROSjIvQTBIdWVLdUdacWlmd242NjhacDg0cFdEbm12?=
 =?utf-8?B?MmdOc1BJS3JQT0hPNGY2WWo3MElCdlNkR01JckttWHJtck0zdUVVR2FhL2Ny?=
 =?utf-8?B?aXRjUzcxbVAySW84amZNbE9NSEpQcXhvN2x1dEtFSFBZOE1CMDlkR0RPNWVI?=
 =?utf-8?B?d0tIK3B4eFhyKzJMUDIxRHJNTmgvSDNacFJvYlFmUUU4eGlqM3RvcjdpUThH?=
 =?utf-8?B?QlhxWndjMXJkMlVrZEpocjJBeVpCUVd5UDlKK2dRdkdxVEVSQzdMbGpVZkcv?=
 =?utf-8?Q?PKaJeS2GgDM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3Q1WG5rK3kvcWgzQ21xbExMZU9RZnFNQlNTL3ZmbEZxditCaWlQYk5nVEl1?=
 =?utf-8?B?cnM1YU1hNmJKS2piMEhyTytKUG1mZUFjR2Q0VkQxcXhkNkFPYnhmWXc5bWRO?=
 =?utf-8?B?dWZtanhhdWt1azduVU9PbzVkWkVqSlBBb2FySzlpU2pFb2ZmU2JvMFhhaTNY?=
 =?utf-8?B?Z1IrRzFDYzkrazZMRWVkR3lnaW5kZGRSN1RIbExrUitPUjg1dVMrT0Q2K2pq?=
 =?utf-8?B?ZG90RVNFTzBkWExBemJEcVBPNlRaR1RZTXBXQytlaE1vcEI3cjdzTHRmY3lr?=
 =?utf-8?B?R0V4VVdNcXZiT1FLYmtaamhmRUw1azhjbnVwVWdKcEJSU0R3dTJXZVc3MkI5?=
 =?utf-8?B?QW9Qd0ZNTTl5MmhSZ2FWcHZERENCelF2b1ZSVHUxMmt2Ujh6L1N1SzdhQU15?=
 =?utf-8?B?WEdMYm9kVGVuUWFRSGZRY0s3NGUxT2lIeDNBOXNiTnBLNStYVGpmR2ZYRUtX?=
 =?utf-8?B?VVMydE5zZmIvblFqNkpWNEtwQXRWa3lHYk9VU3pBbnoyZ2pQZS9EMFR3Umhj?=
 =?utf-8?B?VW8wNkFZL2ljOHcwVHg5L1h3NkJta2FRZHFsNXhUYjU2QW5QN1dmOEZTdkds?=
 =?utf-8?B?WnNKclFKbkViVkNOWUJJSGJBSHhhNytPcHJZY0VmM3h1b1ZZRTBiMmlLTHZE?=
 =?utf-8?B?OVQxMWhPZFppYUFZQzN4RzBmOXhMZmV0VmpDRUk4L0FWWTNiWG10ZXpGVDlI?=
 =?utf-8?B?MTg1M1ZRZ3prOXUwL3QxaEpaMzRXSmhmVWErMzU4QzhkeDJneFZQcWU1NnVN?=
 =?utf-8?B?cWFBRzc2ODlId0xYUVlaUDdsTDRQa0lZMHlrQjdWd1BiMHRzOVdpRTFLTnVT?=
 =?utf-8?B?YVFSNUpaQ29RdVFtZnhUVjNTeUJMK29CbUhDRmFoVFJUQVh6YU0rYzVEKzZa?=
 =?utf-8?B?b1lLYXJ3S0ZaOUpQYkZkaEFRYzV6MkkwSW9CclUwUGJROFd5VXUrckM3VU94?=
 =?utf-8?B?SjB4ejkwdG9pS2QyMGtHMXJDVVIrblpoYXlFdWxqc3cvaFIzRVV1SEFaeTBB?=
 =?utf-8?B?dVc3VWUwTmdWOVNwZFBleS9NZG1KTUNyVGlndkxrZlNGcFNXYXJkeGxlWEhl?=
 =?utf-8?B?NDhkVk82RUZpS3hMdTdhV2U2bTNvUXlLT0l6ajdKWmxkZ1JCNXVmdFlwQVZu?=
 =?utf-8?B?NkU3cXBXSkU2RnV1bFNtdTkvUG5tZ0pyNWRucnNDUm5HV2k0cE02cVNaZ2tt?=
 =?utf-8?B?UlVOVTVObk1ZRkp5bmNYSkFCRWdkdDFnUXZKN20rTnNWSDdVK0JUM2VFd0pS?=
 =?utf-8?B?bHhVem4xdXU5N3ZlWGJxcHk0QTJ5WmE3MHZHb2lMZHg2L2UyK3R4c0p0a0Zs?=
 =?utf-8?B?ZVJEdTB2SVFrK2RmS1JSUmFuc2FjREdHYStJZHhmM1hIWVR3dUZnRGtZR2pn?=
 =?utf-8?B?K1Z4SGZFMzI1ZTNhM2F0L0c1SjIrVGw1NW8rQXRDT0hjditkVklzaSs1OHF2?=
 =?utf-8?B?RjA3MmZFQjFCWnhlbjVNcGV1ODNLcHpVN1J5dWZXaGtpMWxuc3JyMmt1dU96?=
 =?utf-8?B?VWlSK1IvODBXTUg3SjY1SVZVb0QrZmE4M0ZVaUNlcER4UW5JYnFkMFF2Z0I4?=
 =?utf-8?B?SCtjcVhFOVpQZWF2cUNqUjBUNHhqQjR3cEFmbERNVGx1T0RDdlRVWXdqOTRW?=
 =?utf-8?B?Ry9qc1dLUkpMWTE2NVlSMnNuWTk0dkY4VmpEekF5KzRuc3FBNzhpZDdDLy9U?=
 =?utf-8?B?VFlZY1ViZmRjZWxmVjIvSW1SY1IvKy9CbEVaeFNpcDA5T0htMy9vVTBXclV0?=
 =?utf-8?B?eUYyd0tCd1NnZXMrNUIya2p1TUtBOGNZMFczZU1ZSFV4WUlXVHFZN1FjNEJU?=
 =?utf-8?B?YzZrYjN5T1VpTGVjeXlGZVE5ek51VE5NMnlFNm0rN3F5UDlqSjdlaTB4ejk0?=
 =?utf-8?B?bW5ueUt4U3lxWlRRZFlteGNBRDJ0eVBya3NzV3Q2VC92aDBTK1VlK2ppR240?=
 =?utf-8?B?cXJSQ3NGYlI2RVJ2NFJUMU9tQ1pBR3g5UERpMlJFR0ZQbTh4cWdweUI0Zm1v?=
 =?utf-8?B?SlpqLzZ6cGY0d0RrL0VSMWRvWHdPK1luaU4rOTVUd29ZTlFHaVloc1FhS1VG?=
 =?utf-8?B?OHNzSHVTZkFBS2haajI0eThHYUhpU2JnRjNMRUZDVlhBWHRXMDEzT2JsMUFG?=
 =?utf-8?Q?cCb64hZth8Ovb/Ah+vlLlBKRm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2eb2d3d-41d1-4443-9140-08ddcea5c2ba
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 13:42:29.3050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bm7EnB4xducuKHZBdFDP4KqHoJGd9+raPUjRNPMPMqD5feD3SdiYXDjhMtGJTipOQ/tcUjAQwy+gCWVniz0d/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8ECEC29A9
Received-SPF: permerror client-ip=2a01:111:f403:2009::60d;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Jul 16, 2025 at 11:53:55AM +0200, Luc Michel wrote:
> Improve the IRQ index in the VersalMap structure to turn it into a
> descriptor:
>    - the lower 16 bits still represent the IRQ index
>    - bit 18 is used to indicate a shared IRQ connected to a OR gate
>    - bits 19 to 22 indicate the index on the OR gate.
> 
> This allows to share an IRQ among multiple devices. An OR gate is
> created to connect the devices to the actual IRQ pin.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  hw/arm/xlnx-versal.c | 62 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 61 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 58176fa11e5..89c93278336 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -41,10 +41,21 @@
>  #define GEM_REVISION        0x40070106
>  
>  #define VERSAL_NUM_PMC_APB_IRQS 18
>  #define NUM_OSPI_IRQ_LINES 3
>  
> +/*
> + * IRQ descriptor to catch the following cases:
> + *   - Multiple devices can connect to the same IRQ. They are OR'ed together.
> + */
> +FIELD(VERSAL_IRQ, IRQ, 0, 16)
> +FIELD(VERSAL_IRQ, ORED, 18, 1)
> +FIELD(VERSAL_IRQ, OR_IDX, 19, 4) /* input index on the IRQ OR gate */
> +
> +#define OR_IRQ(irq, or_idx) \
> +    (R_VERSAL_IRQ_ORED_MASK | ((or_idx) << R_VERSAL_IRQ_OR_IDX_SHIFT) | (irq))
> +
>  typedef struct VersalSimplePeriphMap {
>      uint64_t addr;
>      int irq;
>  } VersalSimplePeriphMap;
>  
> @@ -172,13 +183,56 @@ static inline Object *versal_get_child_idx(Versal *s, const char *child,
>      g_autofree char *n = g_strdup_printf("%s[%zu]", child, idx);
>  
>      return versal_get_child(s, n);
>  }
>  
> +/*
> + * When the R_VERSAL_IRQ_ORED flag is set on an IRQ descriptor, this function is
> + * used to return the corresponding or gate input IRQ. The or gate is created if
> + * not already existant.
> + *
> + * Or gates are placed under the /soc/irq-or-gates QOM container.
> + */
> +static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
> +                                          qemu_irq target_irq)
> +{
> +    Object *container = versal_get_child(s, "irq-or-gates");
> +    DeviceState *dev;
> +    g_autofree char *name;
> +    int idx, or_idx;
> +
> +    idx = FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ);
> +    or_idx = FIELD_EX32(irq_idx, VERSAL_IRQ, OR_IDX);
> +
> +    name = g_strdup_printf("irq[%d]", idx);
> +    dev = DEVICE(object_resolve_path_at(container, name));
> +
> +    if (dev == NULL) {
> +        dev = qdev_new(TYPE_OR_IRQ);
> +        object_property_add_child(container, name, OBJECT(dev));
> +        qdev_prop_set_uint16(dev, "num-lines", 1 << R_VERSAL_IRQ_OR_IDX_LENGTH);
> +        qdev_realize_and_unref(dev, NULL, &error_abort);
> +        qdev_connect_gpio_out(dev, 0, target_irq);
> +    }
> +
> +    return qdev_get_gpio_in(dev, or_idx);
> +}
> +
>  static qemu_irq versal_get_irq(Versal *s, int irq_idx)
>  {
> -    return qdev_get_gpio_in(DEVICE(&s->fpd.apu.gic), irq_idx);
> +    qemu_irq irq;
> +    bool ored;
> +
> +    ored = FIELD_EX32(irq_idx, VERSAL_IRQ, ORED);
> +
> +    irq = qdev_get_gpio_in(DEVICE(&s->fpd.apu.gic), irq_idx);
> +
> +    if (ored) {
> +        irq = versal_get_irq_or_gate_in(s, irq_idx, irq);
> +    }
> +
> +    return irq;
>  }
>  
>  static void versal_sysbus_connect_irq(Versal *s, SysBusDevice *sbd,
>                                        int sbd_idx, int irq_idx)
>  {
> @@ -1209,10 +1263,11 @@ static uint32_t fdt_add_clk_node(Versal *s, const char *name,
>  
>  static void versal_realize(DeviceState *dev, Error **errp)
>  {
>      Versal *s = XLNX_VERSAL_BASE(dev);
>      qemu_irq pic[XLNX_VERSAL_NR_IRQS];
> +    Object *container;
>      const VersalMap *map = versal_get_map(s);
>      size_t i;
>  
>      if (s->cfg.fdt == NULL) {
>          int fdt_size;
> @@ -1223,10 +1278,15 @@ static void versal_realize(DeviceState *dev, Error **errp)
>      s->phandle.clk_25mhz = fdt_add_clk_node(s, "/clk25", 25 * 1000 * 1000);
>      s->phandle.clk_125mhz = fdt_add_clk_node(s, "/clk125", 125 * 1000 * 1000);
>  
>      versal_create_apu_cpus(s);
>      versal_create_apu_gic(s, pic);
> +
> +    container = object_new(TYPE_CONTAINER);
> +    object_property_add_child(OBJECT(s), "irq-or-gates", container);
> +    object_unref(container);
> +
>      versal_create_rpu_cpus(s);
>  
>      for (i = 0; i < map->num_uart; i++) {
>          versal_create_uart(s, &map->uart[i], i);
>      }
> -- 
> 2.50.0
> 

