Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF4FC87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 13:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugkLB-0007Ih-Jl; Tue, 29 Jul 2025 09:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugkKt-0006sH-0r; Tue, 29 Jul 2025 09:25:45 -0400
Received: from mail-dm6nam11on2062e.outbound.protection.outlook.com
 ([2a01:111:f403:2415::62e]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugkKo-0003pX-Bd; Tue, 29 Jul 2025 09:25:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SgKUQFWx3N09r2Vh8G/INwi1rlo7cVnz69Pm1IaDsebARnSki+85qQeocpIK/pPmORJVTR62oi0bbSYLwAHSZHDg3XvAnYu71sUNFS6nrB5j02QgVuVa+GdifAprSmH/gRTXHgFv9NKHBPWkR1dB2a1ST3aXxiVrENPidz1D6RwAgswkZS1ZBz1UIhthpYhYJYL7xwq5R04zeC9djbXHKoz3Xr9F1YIy1h+09DJRNDcDl+rzojPANvgmC6Aw6/M8ZJ61BjVOBnJEpSnRoNl1K8DVXZheQ0TPDR8ljaTDER6qQuIZuO9Iy7HvRtwf9lnSiUiMqfKfMwRcrpmq4SKyTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=larG8N18hZZ6iLDVFe4kMOhPvqvPslH88FtD28GAZAE=;
 b=JPfVjWGO0su/1sWp0vMbOJpKQy2sF91n1pR0AsTqzeGo/AOz2pjrNgo1Qv+e+Tizrk4aE8Z3yICzDMKWNYqR2LK3+AumU1EMY0iay607+soh8BxjWha1neMRoQlw5EkJYIBFRxUb35x2Ft0nQqrDtVwzl/AFodsiP+QuzteeZfKm5Go91y7xzrTRORUrd2gjD4RHwr4ZdSnaRPugkGvVuJ+sym9EqjsRm9i64G10vNVDS64Kq/tIKAxsoLi38tcs4GfEj8m+tmOHSlOtOkZJ3YrSBZQD1+y7o/ApHoZ16qe4ZosXQHT5vJH2LHwqh7E8lW8Wyi0+lV2tmoe3rfshFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=larG8N18hZZ6iLDVFe4kMOhPvqvPslH88FtD28GAZAE=;
 b=jsoDP9tp1HlTTetJN5uVsYigkhIEAeaSYMiAjR+uef/ny1rAM2gy12HO58O6YGhX3Af6HVWxKVeF/0LUsNXcMrD8iVXW9Q4rsVyQ0pVEtOkkPiSjkuq0xtDTaDt8grp0N08y2CfLB91Ye+3MHIC8K5eSVbxZVehaRIZw/v4AL0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by PH0PR12MB5632.namprd12.prod.outlook.com (2603:10b6:510:14c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 13:25:21 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 13:25:21 +0000
Date: Tue, 29 Jul 2025 15:25:10 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 11/48] hw/arm/xlnx-versal: efuse: refactor creation
Message-ID: <aIjLtn5m02knseYo@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-12-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-12-luc.michel@amd.com>
X-ClientProxiedBy: PAZP264CA0242.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:239::16) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|PH0PR12MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c7bffe-cc19-42a6-e553-08ddcea35e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUtXUzFVeW9IR2xJSU5yWTk1WEF2MmFKTDJLUHlHenN2ZVVxcFhBVkdZUEJJ?=
 =?utf-8?B?YVJrMDh3TjVyaCtIOU1vZGd4d0cvVEEyaW9adzBSZGI4MTRHZ2Y2L1JXVlZo?=
 =?utf-8?B?TkdrdU5XQ0Z0WlB1alNVcCtUK0N0SDFDcDM3eVRNeXgrVW5tQXIzYk52SjJl?=
 =?utf-8?B?T0MzTFpZUFVEaGt6NURBWDdISVlmb2ZXb3VxbSs1UllHWFBPV083ek9pTU1X?=
 =?utf-8?B?ZjJoWk9OSkJQRncxRXVxYnhVZU8wQmJmNHl5VVFwTXB5alFYZjR0T1N3cFpm?=
 =?utf-8?B?T05CcFR0Mlh3QVdPaUFlQllvc3B6NXkweUxJN2h5M2hkRzVCTkQ5cWtRZGxy?=
 =?utf-8?B?d1R1MFhkZTRJb0I3ZWplZGxYcW5zbEx1Y2twTmtLSUJkM3B3Smp6Rm9DWTFm?=
 =?utf-8?B?RFdod3YxZVZ0Z1dweHBhck0zYWxuOVd2Ty9wSFF5RGQ4SDhLVUsydDNqcXZn?=
 =?utf-8?B?RmNzWnNlZ1hmR2dGVGlVbnJVcGRlS25rTUNpQ2JJQmFHeTZVSkhJS3NGMTFj?=
 =?utf-8?B?TENSQ3FXaDRtNkhXcUh5TjhYRHBBVlpYYmV0OVk2czJuaFRMWFFRdEl5U1hJ?=
 =?utf-8?B?dzZSV2JZTGVrNWJtUThwa09SUmw3NUk4WW82dXc5K2V5TnV6U29qa0Y2NVoy?=
 =?utf-8?B?NXkxa0p4bUhFQStocVVIZ0ptSnVDdDZvaG1KUW1yelpmcnovc05UNDdaalps?=
 =?utf-8?B?RzlVZVVOeFRiYTlmNW53RmFMN2R6dzNYdTdtSSsxM0ZSRjdGMWU4NnN0QkMz?=
 =?utf-8?B?U05yQXVYSHlyOVVOd29Ydm51c0dwcVhUamZSYUgyVnlGcUIrZEZjaXB6ZjJF?=
 =?utf-8?B?Q3dLazNzcFVjQU04YTJVSUFqZ0lLeGxiSVUrZXd6U0ZacmVmTEVrUU5EY2h1?=
 =?utf-8?B?WnRDbTFpcFFyYldvUWkxdE9FbzNOTFVUYkZwMUo2T2NFMFM3SVZOWENacFdJ?=
 =?utf-8?B?ZjFLeHJJblJBeEcvem1OSWhsU29saUx3bHlIYTAvOGJmb2dscFhKdzF0N3pF?=
 =?utf-8?B?ODJZazJtdU1EaW54VEUyOHVOV3BUM3JlYUFnK2lFQjV0c0dVVmNYRGcwM3NH?=
 =?utf-8?B?NXZBeFFaQWo3V0FEalZFeE9RQTVZQWNML1pwaWJrSjNraVhRUzJReGtYZFI5?=
 =?utf-8?B?WHZZKzdIek1mdjhVOTJrZjhIMUNpUmFBaU02UzRiVis5bUpyaUdZeFdJRDZH?=
 =?utf-8?B?TFhhb3pIMkRSS1poYVljRld0VktyNUtPUUU0UU5ncUU4QWpEVjZrcmFTajBB?=
 =?utf-8?B?RmcrOVJnZ3kzemV6WUpoUlZ3RCt5ei9qdk40Wnp2aXVxR0FuakdzamhOeXNO?=
 =?utf-8?B?YlhiRXBmVVdTZEhLaE54N25iTkkyV2JUV1R4UmRIelJucTFWcExxcGNCUUlx?=
 =?utf-8?B?OHUwd1laOXFkUUlNTFEwQmpseFNjR3VPN2graUY5elRSZkc1TUk5czFUZity?=
 =?utf-8?B?eW1KZm5IMXpZa3N1OGhWeFJmLzM2d0Jpa0NrK3ladFA2OG9OTmdGK2hFSkJ5?=
 =?utf-8?B?V3Y2TEhLbElkd1hpd01yUmUrVUloZXB4THQxSUo2OUhzdnZXTzNzUzE5Y3J3?=
 =?utf-8?B?N0ZZeDhXbjIwWXJVdkRKamVUT1VkUTRGUG56RWZLQUJDQmY4OVQyNlpCWVdv?=
 =?utf-8?B?alo5MG4wdUxGYXlJUkJ5WVRrcXR4UnBxaDZMQjg1NVMwMGxNVDJ1YmUzMW5Y?=
 =?utf-8?B?QkJrUkdtTTMxUkEwNi93MDFSeURFMWpXZ2sxQ2lGaFFWYWxNQ0JuZXZ5c0VQ?=
 =?utf-8?B?aE5jSkdkYTQ5SnBXL1liOEJJWDdMTFEwbmFUMjR6ZVhublhZNE5acUEyVm1X?=
 =?utf-8?B?Z0k5bjA5ZjRKRnJjZFhvTGYzSGxMQ3FnMEN5NjVYRXJENElYWWJHbDRKNkNG?=
 =?utf-8?B?QW1UMTlpdUcyc2lZMWpiQncwTmtHMDZNSy8ycDR3QzVCZ1k0NE1KV1hqOUtu?=
 =?utf-8?Q?PyLvxKvbIAg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHRJcmlpSmdQVHZMYjVjZG03TUhZbXBJai9tZjJta01PZDJ2RkUxKzBaMTZz?=
 =?utf-8?B?WSs3eUVxWXlhUXZvTnFzakl0OS9MUTlxZ1E1Z2Fvdk1TdEE4R1cxTlhJYVB2?=
 =?utf-8?B?TU9jN3JkTnlzUmNSZ1lsWHVJcHBUOGV0ZGZ1cnphR0pHeEFMUU5yWDBnbE92?=
 =?utf-8?B?K29CekpSSWh4dlNHeHNmL2tOdlJaZk1iUGtBTitxdXZiSkpoRFU3UFhzQjh1?=
 =?utf-8?B?UWptckZVU3J6MXNjQk9oSHRNdHpqV2oyR0czR2p4K0hwdUhjWGxKVnlJaExM?=
 =?utf-8?B?dmRXd2xJYjcyZUs2MGpWWGFzSG1STVU3VjduZWZ1ekVYcDF2NGowTENZOHVP?=
 =?utf-8?B?bGhyMlR3QnBwWUxMZ2VhUEpUVE9UcHVqWUtzMU9jSEZIZ0c0UkpCdDh6REIw?=
 =?utf-8?B?WnYzNnp2a1RLbGJaZDZBTFR4cjgvaDNtT2ZZaWYyM3hsNnhRcnpuRXVBT2dZ?=
 =?utf-8?B?dXF2U281K2FIa3phZjl5cW5XL0FzWm1iRGYvMkgra1NZbjFLMUEvY1V5aHZk?=
 =?utf-8?B?RkVCOHB4SjY5bVBmc2xuNWdqV291MlJBeGNSbERTUmNKTG8wZ2RmR05xc2xI?=
 =?utf-8?B?VnZ2cjBvSHZyVS93YW52b2RyaXQzcExRTVF6OCtNSVVCNW45a0ltSjlFcDRV?=
 =?utf-8?B?RWRKN3NSV25jS1F6WHh0ckhkbjVBSWxlVThJSmlId0JyL0o3cTMvbXNNcFBQ?=
 =?utf-8?B?bDZsL3g1L0pCM1BqaVkwYlRRcFh0Mi9GalpOZTF5aTY5OVhsbUNZcmNyeEVx?=
 =?utf-8?B?N2g1Yk9LM05BQTJVWFhXbU9TeVFLMEh3alVRS2ZpamdiSDU3ZXBVOWxRVVNw?=
 =?utf-8?B?ZFdleDI0OFowbUJibWF0c2pNcjBPYVpnM2pMSGRJaVJXUHJldWtoWDZES053?=
 =?utf-8?B?UFdXNWNZaTdtZFZpZE5vWWJRWFlzRldmVFg0dW5naVFPdkhBczdadDlSaG4r?=
 =?utf-8?B?TU5OK1VUcVg3Q3dodjBCYzVUZ1pKVjlCRzkzZng0S2U1aXZnalBsVTdQWVlz?=
 =?utf-8?B?QlBLd0FWNWNBMCs2c3FJdmpwTnI2L3NSb0FoaGtvUjJQUmpSZGZnRmh0aXY1?=
 =?utf-8?B?S3JScTRUeGRaWGZFbXJ2dkJTWFVPRHFpMHppWklQSGc0bGtWdXQ3ZklMVUpY?=
 =?utf-8?B?UmFHazRjODRlei9adGVyUGtqNmZJUHNhRnNmNWZpMjlJK0haMi9vT2RkS0lh?=
 =?utf-8?B?SW55SEdJTm5EZ2RiY2dIS3V6NHAxN0Q5UnBnS1dYVTd5bXFITm1oLzh0OWZN?=
 =?utf-8?B?NTRsVXNBNjlFYlJTVnlFN0VvM05uZUhFMTdHQWJpelhXUDNFV2pYeHVtWEdt?=
 =?utf-8?B?azREeTJZY1ZkSXZyVjJuQjZyS0hhdlcrS2ZTMWxjd0NiWTI3NHhCb05FNDN3?=
 =?utf-8?B?ZHVvL2I0aTd1Y1czTmMyeDQ0cFB3d2FETURZYjMvT2pLK3lXdXZFeURGZ0k4?=
 =?utf-8?B?RjJlT1krVXNBeUNGWllOTDZpMWVzWVduUU8xV1VaNTlSQ3lXMFFhZFFSUGx4?=
 =?utf-8?B?L0Myc2JnMTJKYVhiTkxvb1A1VUg1c2s3MWFoNXN5Q2tGQlVXNzlzWmJIYldF?=
 =?utf-8?B?RmVvdGNMSHZNNUM2QlJvYjV2Yno3MUphcnlZV25oOHYraGYyL0pVV2w5a2Ft?=
 =?utf-8?B?dWJJbXNUb1pQS21KLzJmSXVac1RJZFlUQ0tNamJzaGN5d2orZkN4NWErZVY0?=
 =?utf-8?B?YUQ5MkNVQmFrVkVlenlQNktiVlZNK05SYWJUcnkyZmRSVERCcFpocXQzcFpq?=
 =?utf-8?B?MGljT3p5UVFmWDhTNkVDb29mckZaU1NRTS9uK1lvS0h2a211b0N4V25wMFdu?=
 =?utf-8?B?TVpBZHpkSnIzSFFUNnJoUHRCTlZJYWUzWGJISDBpWWNTajh5d2l4WENhdDd2?=
 =?utf-8?B?VXlLR3MzdGQwWUpRWDNSQjdOSFJsbjZSQmxjendZRytCV2VmSERudGFLTW1U?=
 =?utf-8?B?eEJNOXd0eHNtZ1BoRzZ4Q0V0VzEvdUVZLy9XcmhSWDlxK1hMZlhETEhUOWdH?=
 =?utf-8?B?clpCb21Od2NpN1FWZWFubmVmSERwYUZSYWEvMUVXL1RFZU5CQnQ1ZWlZWVlx?=
 =?utf-8?B?cEM0V204TTNOalo0alU2NERaWDRCV1pRWjdiSXlvZjVWdE0vN1FreWJaUXV2?=
 =?utf-8?Q?7GpkcSWo/J7JwPC882jagoQYj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c7bffe-cc19-42a6-e553-08ddcea35e0a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 13:25:21.1930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inSUfq2JuhT24zFu6IEWiTYyrw+cSd88GWtFs5DS0rPjvMp1GiiF1T4v0Ha6UL/wsL85pCwFmflAWQRUVT7RUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5632
Received-SPF: permerror client-ip=2a01:111:f403:2415::62e;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

On Wed, Jul 16, 2025 at 11:53:53AM +0200, Luc Michel wrote:
> Refactore the eFuse devices creation using the VersalMap structure.
> 
> Note that the corresponding FDT nodes are removed. They do not
> correspond to any real node in standard Versal DTBs. No matching drivers
> exist for them.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  include/hw/arm/xlnx-versal.h |  5 +--
>  hw/arm/xlnx-versal-virt.c    | 43 ++------------------
>  hw/arm/xlnx-versal.c         | 78 +++++++++++++++++++++++-------------
>  3 files changed, 54 insertions(+), 72 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index 5d4b30f0ff9..79ca9b13321 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -18,11 +18,10 @@
>  #include "hw/or-irq.h"
>  #include "hw/intc/arm_gicv3.h"
>  #include "hw/rtc/xlnx-zynqmp-rtc.h"
>  #include "qom/object.h"
>  #include "hw/nvram/xlnx-bbram.h"
> -#include "hw/nvram/xlnx-versal-efuse.h"
>  #include "hw/ssi/xlnx-versal-ospi.h"
>  #include "hw/dma/xlnx_csu_dma.h"
>  #include "hw/misc/xlnx-versal-crl.h"
>  #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
>  #include "hw/misc/xlnx-versal-trng.h"
> @@ -100,13 +99,10 @@ struct Versal {
>          } iou;
>  
>          XlnxZynqMPRTC rtc;
>          XlnxVersalTRng trng;
>          XlnxBBRam bbram;
> -        XlnxEFuse efuse;
> -        XlnxVersalEFuseCtrl efuse_ctrl;
> -        XlnxVersalEFuseCache efuse_cache;
>          XlnxVersalCFUAPB cfu_apb;
>          XlnxVersalCFUFDRO cfu_fdro;
>          XlnxVersalCFUSFR cfu_sfr;
>          XlnxVersalCFrameReg cframe[XLNX_VERSAL_NR_CFRAME];
>          XlnxVersalCFrameBcastReg cframe_bcast;
> @@ -137,10 +133,11 @@ static inline void versal_set_fdt(Versal *s, void *fdt)
>      g_assert(!qdev_is_realized(DEVICE(s)));
>      s->cfg.fdt = fdt;
>  }
>  
>  void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk);
> +void versal_efuse_attach_drive(Versal *s, BlockBackend *blk);
>  
>  int versal_get_num_can(VersalVersion version);
>  int versal_get_num_sdhci(VersalVersion version);
>  
>  /* Memory-map and IRQ definitions. Copied a subset from
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 36341b825eb..d3c84d1955a 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -190,45 +190,10 @@ static void fdt_add_bbram_node(VersalVirt *s)
>                                   2, MM_PMC_BBRAM_CTRL_SIZE);
>      qemu_fdt_setprop(s->fdt, name, "compatible", compat, sizeof(compat));
>      g_free(name);
>  }
>  
> -static void fdt_add_efuse_ctrl_node(VersalVirt *s)
> -{
> -    const char compat[] = TYPE_XLNX_VERSAL_EFUSE_CTRL;
> -    const char interrupt_names[] = "pmc_efuse";
> -    char *name = g_strdup_printf("/pmc_efuse@%x", MM_PMC_EFUSE_CTRL);
> -
> -    qemu_fdt_add_subnode(s->fdt, name);
> -
> -    qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
> -                           GIC_FDT_IRQ_TYPE_SPI, VERSAL_EFUSE_IRQ,
> -                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> -    qemu_fdt_setprop(s->fdt, name, "interrupt-names",
> -                     interrupt_names, sizeof(interrupt_names));
> -    qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
> -                                 2, MM_PMC_EFUSE_CTRL,
> -                                 2, MM_PMC_EFUSE_CTRL_SIZE);
> -    qemu_fdt_setprop(s->fdt, name, "compatible", compat, sizeof(compat));
> -    g_free(name);
> -}
> -
> -static void fdt_add_efuse_cache_node(VersalVirt *s)
> -{
> -    const char compat[] = TYPE_XLNX_VERSAL_EFUSE_CACHE;
> -    char *name = g_strdup_printf("/xlnx_pmc_efuse_cache@%x",
> -                                 MM_PMC_EFUSE_CACHE);
> -
> -    qemu_fdt_add_subnode(s->fdt, name);
> -
> -    qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
> -                                 2, MM_PMC_EFUSE_CACHE,
> -                                 2, MM_PMC_EFUSE_CACHE_SIZE);
> -    qemu_fdt_setprop(s->fdt, name, "compatible", compat, sizeof(compat));
> -    g_free(name);
> -}
> -
>  static void fdt_nop_memory_nodes(void *fdt, Error **errp)
>  {
>      Error *err = NULL;
>      char **node_path;
>      int n = 0;
> @@ -391,19 +356,19 @@ static void bbram_attach_drive(XlnxBBRam *dev)
>      if (blk) {
>          qdev_prop_set_drive(DEVICE(dev), "drive", blk);
>      }
>  }
>  
> -static void efuse_attach_drive(XlnxEFuse *dev)
> +static void efuse_attach_drive(VersalVirt *s)
>  {
>      DriveInfo *dinfo;
>      BlockBackend *blk;
>  
>      dinfo = drive_get_by_index(IF_PFLASH, 1);
>      blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
>      if (blk) {
> -        qdev_prop_set_drive(DEVICE(dev), "drive", blk);
> +        versal_efuse_attach_drive(&s->soc, blk);
>      }
>  }
>  
>  static void sd_plug_card(VersalVirt *s, int idx, DriveInfo *di)
>  {
> @@ -478,12 +443,10 @@ static void versal_virt_init(MachineState *machine)
>      versal_set_fdt(&s->soc, s->fdt);
>      fdt_add_gic_nodes(s);
>      fdt_add_timer_nodes(s);
>      fdt_add_rtc_node(s);
>      fdt_add_bbram_node(s);
> -    fdt_add_efuse_ctrl_node(s);
> -    fdt_add_efuse_cache_node(s);
>      fdt_add_cpu_nodes(s, psci_conduit);
>      fdt_add_clk_node(s, "/old-clk125", 125000000, s->phandle.clk_125Mhz);
>      fdt_add_clk_node(s, "/old-clk25", 25000000, s->phandle.clk_25Mhz);
>  
>      sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
> @@ -496,11 +459,11 @@ static void versal_virt_init(MachineState *machine)
>  
>      /* Attach bbram backend, if given */
>      bbram_attach_drive(&s->soc.pmc.bbram);
>  
>      /* Attach efuse backend, if given */
> -    efuse_attach_drive(&s->soc.pmc.efuse);
> +    efuse_attach_drive(s);
>  
>      /* Plug SD cards */
>      for (i = 0; i < versal_get_num_sdhci(VERSAL_VER_VERSAL); i++) {
>          sd_plug_card(s, i, drive_get(IF_SD, 0, i));
>      }
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 4e4df0851e8..ed202b0fcda 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -31,10 +31,11 @@
>  #include "hw/sd/sdhci.h"
>  #include "hw/net/cadence_gem.h"
>  #include "hw/dma/xlnx-zdma.h"
>  #include "hw/misc/xlnx-versal-xramc.h"
>  #include "hw/usb/xlnx-usb-subsystem.h"
> +#include "hw/nvram/xlnx-versal-efuse.h"
>  
>  #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>  #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
>  #define GEM_REVISION        0x40070106
>  
> @@ -86,10 +87,16 @@ typedef struct VersalMap {
>          uint64_t xhci;
>          uint64_t ctrl;
>          int irq;
>      } usb[2];
>      size_t num_usb;
> +
> +    struct VersalEfuseMap {
> +        uint64_t ctrl;
> +        uint64_t cache;
> +        int irq;
> +    } efuse;
>  } VersalMap;
>  
>  static const VersalMap VERSAL_MAP = {
>      .uart[0] = { 0xff000000, 18 },
>      .uart[1] = { 0xff010000, 19 },
> @@ -117,10 +124,12 @@ static const VersalMap VERSAL_MAP = {
>          .irq = 79,
>      },
>  
>      .usb[0] = { .xhci = 0xfe200000, .ctrl = 0xff9d0000, .irq = 22 },
>      .num_usb = 1,
> +
> +    .efuse = { .ctrl = 0xf1240000, .cache = 0xf1250000, .irq = 139 },
>  };
>  
>  static const VersalMap *VERSION_TO_MAP[] = {
>      [VERSAL_VER_VERSAL] = &VERSAL_MAP,
>  };
> @@ -744,46 +753,45 @@ static void versal_create_bbram(Versal *s, qemu_irq *pic)
>                                  sysbus_mmio_get_region(sbd, 0));
>      sysbus_connect_irq(sbd, 0,
>                         qdev_get_gpio_in(DEVICE(&s->pmc.apb_irq_orgate), 1));
>  }
>  
> -static void versal_realize_efuse_part(Versal *s, Object *dev, hwaddr base)
> +static void versal_create_efuse(Versal *s,
> +                                const struct VersalEfuseMap *map)
>  {
> -    SysBusDevice *part = SYS_BUS_DEVICE(dev);
> +    DeviceState *bits;
> +    DeviceState *ctrl;
> +    DeviceState *cache;
>  
> -    object_property_set_link(OBJECT(part), "efuse",
> -                             OBJECT(&s->pmc.efuse), &error_abort);
> +    ctrl = qdev_new(TYPE_XLNX_VERSAL_EFUSE_CTRL);
> +    cache = qdev_new(TYPE_XLNX_VERSAL_EFUSE_CACHE);
> +    bits = qdev_new(TYPE_XLNX_EFUSE);
>  
> -    sysbus_realize(part, &error_abort);
> -    memory_region_add_subregion(&s->mr_ps, base,
> -                                sysbus_mmio_get_region(part, 0));
> -}
> +    qdev_prop_set_uint32(bits, "efuse-nr", 3);
> +    qdev_prop_set_uint32(bits, "efuse-size", 8192);
>  
> -static void versal_create_efuse(Versal *s, qemu_irq *pic)
> -{
> -    Object *bits = OBJECT(&s->pmc.efuse);
> -    Object *ctrl = OBJECT(&s->pmc.efuse_ctrl);
> -    Object *cache = OBJECT(&s->pmc.efuse_cache);
> +    object_property_add_child(OBJECT(s), "efuse", OBJECT(bits));
> +    qdev_realize_and_unref(bits, NULL, &error_abort);
>  
> -    object_initialize_child(OBJECT(s), "efuse-ctrl", &s->pmc.efuse_ctrl,
> -                            TYPE_XLNX_VERSAL_EFUSE_CTRL);
> +    object_property_set_link(OBJECT(ctrl), "efuse", OBJECT(bits), &error_abort);
>  
> -    object_initialize_child(OBJECT(s), "efuse-cache", &s->pmc.efuse_cache,
> -                            TYPE_XLNX_VERSAL_EFUSE_CACHE);
> +    object_property_set_link(OBJECT(cache), "efuse", OBJECT(bits),
> +                             &error_abort);
>  
> -    object_initialize_child_with_props(ctrl, "xlnx-efuse@0", bits,
> -                                       sizeof(s->pmc.efuse),
> -                                       TYPE_XLNX_EFUSE, &error_abort,
> -                                       "efuse-nr", "3",
> -                                       "efuse-size", "8192",
> -                                       NULL);
> +    object_property_add_child(OBJECT(s), "efuse-cache", OBJECT(cache));
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(cache), &error_abort);
>  
> -    qdev_realize(DEVICE(bits), NULL, &error_abort);
> -    versal_realize_efuse_part(s, ctrl, MM_PMC_EFUSE_CTRL);
> -    versal_realize_efuse_part(s, cache, MM_PMC_EFUSE_CACHE);
> +    object_property_add_child(OBJECT(s), "efuse-ctrl", OBJECT(ctrl));
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(ctrl), &error_abort);
>  
> -    sysbus_connect_irq(SYS_BUS_DEVICE(ctrl), 0, pic[VERSAL_EFUSE_IRQ]);
> +    memory_region_add_subregion(&s->mr_ps, map->ctrl,
> +                                sysbus_mmio_get_region(SYS_BUS_DEVICE(ctrl),
> +                                                       0));
> +    memory_region_add_subregion(&s->mr_ps, map->cache,
> +                                sysbus_mmio_get_region(SYS_BUS_DEVICE(cache),
> +                                                       0));
> +    versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(ctrl), 0, map->irq);
>  }
>  
>  static void versal_create_pmc_iou_slcr(Versal *s, qemu_irq *pic)
>  {
>      SysBusDevice *sbd;
> @@ -1247,15 +1255,16 @@ static void versal_realize(DeviceState *dev, Error **errp)
>  
>      for (i = 0; i < map->num_usb; i++) {
>          versal_create_usb(s, &map->usb[i]);
>      }
>  
> +    versal_create_efuse(s, &map->efuse);
> +
>      versal_create_pmc_apb_irq_orgate(s, pic);
>      versal_create_rtc(s, pic);
>      versal_create_trng(s, pic);
>      versal_create_bbram(s, pic);
> -    versal_create_efuse(s, pic);
>      versal_create_pmc_iou_slcr(s, pic);
>      versal_create_ospi(s, pic);
>      versal_create_crl(s, pic);
>      versal_create_cfu(s, pic);
>      versal_map_ddr(s);
> @@ -1286,10 +1295,23 @@ void versal_sdhci_plug_card(Versal *s, int sd_idx, BlockBackend *blk)
>      qdev_prop_set_drive_err(card, "drive", blk, &error_fatal);
>      qdev_realize_and_unref(card, qdev_get_child_bus(DEVICE(sdhci), "sd-bus"),
>                             &error_fatal);
>  }
>  
> +void versal_efuse_attach_drive(Versal *s, BlockBackend *blk)
> +{
> +    DeviceState *efuse;
> +
> +    efuse = DEVICE(versal_get_child(s, "efuse"));
> +
> +    if (efuse == NULL) {
> +        return;
> +    }
> +
> +    qdev_prop_set_drive(efuse, "drive", blk);
> +}
> +
>  int versal_get_num_can(VersalVersion version)
>  {
>      const VersalMap *map = VERSION_TO_MAP[version];
>  
>      return map->num_canfd;
> -- 
> 2.50.0
> 

