Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CF4C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 02:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trovH-0004tw-79; Mon, 10 Mar 2025 22:00:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1trov1-0004s0-Jz
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 22:00:37 -0400
Received: from mail-bn1nam02on2047.outbound.protection.outlook.com
 ([40.107.212.47] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1troup-0003Wp-LJ
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 22:00:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSYSvM/BalAzOCPHlvIRn7WGVHfNkFSzuDM22yGztoZAvOcvsM+4mvVEupd1jiJi6jn3jY+VjJvhNXhfyKywvA8JZ8dF61rSuRFhwCbdrZeIAUca+vnX170OqWtnNhCAFuzakCvqd+XpXOtMty0PBpfLpnbhUkNRolzMjLAcYkMF9HvOVJcrui7+wv17EjEV5PBx0rTaJXU4h5pWWY0VQCtBWQQFH/DvBAvORcH0Hgl0ip5PRezRnzxXmixwLa7ChK/STaK1WTqXHFuIbAnl3GSAREINm8pKFwK9z3zo4/+b+GYDoZthcOR5h5PM70xhaDm/CT5iF6Ha+yj7+JG+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxZQZHw9WLvLuEz3JkXzR6sTJa5cixd8Sr6XLjPIoEc=;
 b=dHTATAgtyIKZaIbLYaibCD7c319HW0Id4kdH7dg1tTORsC9WzoeqUkvyICRt71bRTk71h7ZWQg4QJwa1POnpz5l+3y1a8Q5GuWKahJUgP+ONfAhVzMZ5RPn75GWpgmGknW1+7RQD96mn4jxijFOz+09KNOkmwNSkg0i9dG6NyAM4vf0kBDPOIoQ+GJAEkHbE1DqtjJrlmhmDEWDecGSQ15fah+ONfh4Wx538cQzodyWqMrcP3+wD4ApHjG1po3syBYO7SnTssfgA7E3hDYAjkWqnhdiWKFiwymCzHJrWn7hlsXAU6Qiq/3gi61yQ/EfR1QUTdEJ88GBJnuO07Hvyww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxZQZHw9WLvLuEz3JkXzR6sTJa5cixd8Sr6XLjPIoEc=;
 b=B4Dq6Jz4iX6K3gPNNsOvA9q72N6ImSw8OaEM1UwZSbclXc/j/aRdXXPclLDhUwwDcJuZB2PSq1dXd5J0mi9Zi2V1C2Yt6vjhodVpUADgx6rDVc+mn0FYp8Yb8Wu1gBiWJ+5AeIVheTZm5NmSM9AR6GtmXFE/zO79VSqGlcF1WGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 SN7PR12MB8790.namprd12.prod.outlook.com (2603:10b6:806:34b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.26; Tue, 11 Mar 2025 01:55:10 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%6]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 01:55:10 +0000
Message-ID: <70b47c11-da90-4f93-b7b7-a522b8ae7def@amd.com>
Date: Tue, 11 Mar 2025 08:55:02 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci-ids.rst: Add Red Hat pci-id for AMD IOMMU device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 marcel.apfelbaum@gmail.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 vasant.hegde@amd.com, Wei.Huang2@amd.com, kraxel@redhat.com, bsd@redhat.com,
 berrange@redhat.com, ddutile@redhat.com
References: <20250304183747.639382-1-suravee.suthikulpanit@amd.com>
 <20250309094039-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20250309094039-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9)
 To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|SN7PR12MB8790:EE_
X-MS-Office365-Filtering-Correlation-Id: cc40ed84-b667-4170-2087-08dd603fc172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V01wL2dTRzgwenFVTm11aUU4N3ljK3Y1aUh2UVpQcDlhWDloZmV3VDZTWUNu?=
 =?utf-8?B?WEptMVE3OEpneW9UdExNU2hZcnVvbkt4ZlAzVkJIV3dCaGxyQWl1eEZ6YTZ4?=
 =?utf-8?B?dDN2d1dzUFZvVnp5Q3JoTWdxd2ROejQ0dVpaaW9BdHNvcm5nenMzaDNKTmow?=
 =?utf-8?B?ZU5BbjFQdmZTWUNhOFBuaFVRWDBNZGtTQ1NwR0JJbStqVHRaKzRqOExYaklw?=
 =?utf-8?B?elMxc3JYRlZSMG1hR1l3MDZKL015ZDY0dGRPeWROd1VIbkcvQ0g5Y3A4T3Fj?=
 =?utf-8?B?dDVzWGp6QTBaMkFPNVZqYmY2eXRjWCtreERCNFJhU2d3S2JUUWZWRjc3NHB1?=
 =?utf-8?B?ZndIOExuVnllL2dYeW9YTnh6a2llUlFCM3NiYWRJTzdZaTNMeExhdWxvVkFp?=
 =?utf-8?B?V1pSRll0ZE9leTk5ZlVkblB4OHVBeE1FK1NxbGNLWkwzdE1RQlZjR2FHWkc0?=
 =?utf-8?B?UXBmS01MQkdaajV6NXFVQnFrZWxETDFIWU5EVlMrVmhNZFpPTURHZ1Y3Z2Fr?=
 =?utf-8?B?OEVQSXl4NjRScjc5SCtqN1JtdEpuZ3pacWFlZ1kwZ3FkV1lSbG5sUVdJbFZI?=
 =?utf-8?B?WU01SU8zMmU2RkFmK2NEUm11dmRHZmZrd3VFdDdkTnAwNUJ6Z243VUlPRURM?=
 =?utf-8?B?b0VaL1BjK1FnMi9wT3Bya3lTbGh6NHZCcWVrMU4xRVlQZjM3QTJDRFpFMklR?=
 =?utf-8?B?emlVQit6bEw1d2paamE1N0NhcEhkOXE4Nmk1Ny9GV3crN2I1U1I1Nmo0bUQ3?=
 =?utf-8?B?aHM5REFrdnVseHhZcTE5TXU4ZFp4cnFSWmhXVjB1Ri9ja2VhNG5sU3ZCZjk4?=
 =?utf-8?B?b0MyeHBObGFQOXNQdnM4cWFMVjhIQWMrU20xdUtuQjI3WStWdGIxek5MRjI4?=
 =?utf-8?B?QVUweWFyK2ZraGpzNUZEZUFKQTZFU0ZGNGdSWjVIMzRkNWxhZHF4UWgrZGI5?=
 =?utf-8?B?YTJkZEE1YWxTSEZ1YmxvcHdOa1AxQitrbGZjYlJtWERNUXlmRkpzMlV2WFdC?=
 =?utf-8?B?QzZvSnJ0WnhMeW1ZMFBtK1FDeHJweitNN3dpemtwVjkySzVjV0hodG91emNh?=
 =?utf-8?B?aXg4L2NPc1lXaHNhdUJRL2pZZUdsVXkrSm9YOXZIVWNxbDYxN1l2VVdoeGMr?=
 =?utf-8?B?N0Nla1ZjN0pYZnFOVVBtR2c2L3VDa29mOVRkY28wb0FXUFlWVkFHVFpOWUdK?=
 =?utf-8?B?THlUSkZ0eUdFNGdCL2hwaEZpY3ZjSmZGejB6aEtGeDNZV1dBNE9NOWZ6K1hP?=
 =?utf-8?B?cjZNVTZFWGRiUjhyaW9nWlV5VlozTmtOQVlMZ3h0OEJtTEVIM0xxM1BYbndO?=
 =?utf-8?B?MjNNNjYvdGI5NWkxZWIyS1hjY2dOWlZlWXBHZVB5OTlCd3lzYVdwdE1pcFRn?=
 =?utf-8?B?SWVWQjNDV1Y1RksvbFlkMnRTK2w4RkU2ZUNqZXJYUy9YZDBJSndFeXc2Nm1v?=
 =?utf-8?B?b2V3YlpWQW50YitRc3hibEFHcktwOUljSlJvOWJKeGJoZC9nYkVmUzFaMDlX?=
 =?utf-8?B?NGhjcHArNDFpQllGbWRSQzFySThmZ2JBQkQxNW55ckJZVlNwTUdwTGVOWVpW?=
 =?utf-8?B?UmdVWXIxcjJkdzlYNHZWRGhVeW0zQzNFMTJRQVM0R3pVWGFQTjFUTklHL1g4?=
 =?utf-8?B?MjFld2R0Um85cm9hU0Z3YUpSL0pmbHB4c0tFejU2OW5PRmJydVU1ckc4YTVs?=
 =?utf-8?B?Q2dzZXhKRTZFTWVLaDJnV0k4bWRtK0dMakovREVRVTN5WEdSRkFHSVM3VFM1?=
 =?utf-8?B?c1Q5dFlWVWd4TGtoSERXK1hITmRwWkMwblJhc2NaNUltcGlTN2hmdHdoUE5z?=
 =?utf-8?B?SU1YcGlYdlFVcGU3OTRkZC9NVWF5VWlzZnluLzg0SVVPbm9GQlRaelZHMGlu?=
 =?utf-8?Q?fVhJm27c6Q89E?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0tOTHNyQ1BVd2dqc1loQklJRnRuR0pnNk4wdngveTFLNUhIQUZVd0o2MHN5?=
 =?utf-8?B?MXl0eDBVMS8zbUJCVGJaTUh6YWd2bUh3RlprcXlxdlZIenhNRVppRnptcDJK?=
 =?utf-8?B?QmN4ODNwRE4zRE5zWHlUcTRpb3AxcXp5OEd5SHAxelh3SW5ldVhIZ3o2MWth?=
 =?utf-8?B?aG40T2R2SUZrWWFxMWZsNGJraTRjUzc1ZW9NeXY4R282RTFhMlFuRklObCs3?=
 =?utf-8?B?TGZqMU1FZXFXZUhMTld3UllyRHJMaXJrVWwzaXRjYks4OFEzY0cwR3BPZmdm?=
 =?utf-8?B?TFlxUnpLWWVSNTdmOEQzalorL1ZKV2FMT0c4ckNpSFljRnE3M1k2dGNKRHFX?=
 =?utf-8?B?dS9QUXN5WjZtcTZETlJ5a0w4dDBBcjhhQVZ5SUdvS0NkR2dzZUo3OVplMlN3?=
 =?utf-8?B?Rm5YSWZ6QVNGZ0I2cnhaV3lVRU9zUjVKNktLZ3VtM0cxN0FTMmI3ZTI3ZkZY?=
 =?utf-8?B?SVdNS0RXaWFCZ2FmYXRhVHQ1R05sVG92UU5rckFkOUdBbzdLemVLT2w3QVVP?=
 =?utf-8?B?ZEdCRytFVHNrR0ZvcWxtT0IvdEFJRW9waytVY05TYnd4MXpaN1k1TEtmbHc2?=
 =?utf-8?B?aFUyWjIrRnM5SXJGODlSb0V1dkVXVjRVSlh5WXpjQ3hiRVA4RXZSSkxzRGsz?=
 =?utf-8?B?bWFRL2JlcW54WDZQK0RRb09ZeWhPbXczaGppeHlKWkk3bFlUdmlQeHlJdW1M?=
 =?utf-8?B?OEgxWnNjYmtDdWIrT2NqYmY1bjBrNWt2dXl1QVg0NEowdFR6ZGdWVWpQTkxy?=
 =?utf-8?B?Uld4TzZqT0V6MzdlUllJY3ZrOC90KzhEdDUwZ1pRZXpTQjZTYy9pdDZENVpQ?=
 =?utf-8?B?d2t1dnBlL1JmRWJCTDNhU1ZkaGdRSHkyR0paamFXVG9qZWtQcGNtLy8ydjN1?=
 =?utf-8?B?UmEwdUpaQVdRVVVUZTRyWWhjbXFHNERiRW8ycHVUL3F0RlZpcFYwaXFVV2Vj?=
 =?utf-8?B?OGlRQ1NucnNHanI3QkUybDZabmYvVURsUkxzbmxabjMyTmFsR1VXamdsRjgr?=
 =?utf-8?B?b1JTd3ByTTdPMHlrK2s2VVhYYjFYTXFpZCs5Y2tLL1QyNHludmhNQmJSTHNV?=
 =?utf-8?B?ckF3bE0zNi9QL1FMT0lwb2I1dE1kdWsvS0FnSnhCODFhRjcwRVlQOXRVM3JY?=
 =?utf-8?B?dWwvRWc3VTgxL2t2N3hTTE5yRytYVStDNU5GTmdXTjRYOHhWei9lYS9mZVJz?=
 =?utf-8?B?MG0yYzY1U1JPUE9xTVdHeTF0cjVocWh2bjZWNG9wQnRjcHN0MU11WEwzbkdt?=
 =?utf-8?B?d00vY3FIUlVkOUUveXZYQWdzN3Z4dFpEdWthNjNJYzBoMC9NVkJVek9yQm92?=
 =?utf-8?B?d2Y4dkZVNmRTOG51Z0lWblRIWFZiZDNPdENNcDl2b2J6UWhlOGJjS1JWMkZY?=
 =?utf-8?B?cUVaVElrK2VpM2tyZG5EcXhScTYrNmU3MXUxWlZnbkZhZDNnZy8vR29vSHh3?=
 =?utf-8?B?ek8zWENNVDM1cjcvSFYrdG5CS2hqNEh1OVFkay9yNVdDYlhKQlQxYnBZN0Rx?=
 =?utf-8?B?WWUyV3lZS2Znejhic2NtdGtiMjROcVBpbTFkVjhwM3QvNHZ1RS9mRXFwN1JU?=
 =?utf-8?B?cVUwTU9PYjBJMTNmMFpiblFHbDR5bGkwUEEzZFl5SitFZjlkc2E4U3ZMSUUv?=
 =?utf-8?B?eG5aa3ZPSWhIa3FxTHg1cVZJdGJOZXhSb0JGM2FQb1hvSjVnOVloRnVqaHVj?=
 =?utf-8?B?N3VTS3FmanJJalJuQ05oM09hOHZIdFRxUDF5aXJKenArSHNkY2dIVDNpU2FG?=
 =?utf-8?B?OXN2R0ZyRzNsdmlrSUQyMWRKU3JZeENWZkE1cE1OSmM3aDNSYlJoSkZvbHB3?=
 =?utf-8?B?MFFSSTVVRTlsdHdJUHVndXR1N3BldFFrMm9ZZzllSlNnNHBuVFlxbEtFMHpB?=
 =?utf-8?B?ZXUwZXZiVCs1eVJSbGRZbFgxSkJZTVlKWUJlZk9pZG9qNDRiOU5mVldqMSsv?=
 =?utf-8?B?clZYbXRQSjEzYlhuYWJKb0Q2c0EyaEhvQWxlZzdXMjg0cll2c0tDNGhNUk5E?=
 =?utf-8?B?eVNnRW1xR3g5R3FoTkxURzZVZ1pCcWNIcEJ5clBtYXB1ZllzWU02ZnlSQmFu?=
 =?utf-8?B?QWUvRmszeC9aQkhTWXVwVStSZEoybTMyTzRiUnpFL3lnYmk3cWZrMVJuKzMz?=
 =?utf-8?Q?CZo/gmzegi0YiJDh/YvLs2mKK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc40ed84-b667-4170-2087-08dd603fc172
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 01:55:10.2918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O8xQtBIhD4jmAomoIm8WcO13uuW+59gPLHrXeIs78oyiEjcQImlhqBK+Wl72HWNk9xqcxudvYE+kD7Ls/BrXdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8790
Received-SPF: permerror client-ip=40.107.212.47;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 3/9/2025 8:44 PM, Michael S. Tsirkin wrote:
> On Tue, Mar 04, 2025 at 06:37:47PM +0000, Suravee Suthikulpanit wrote:
>> The QEMU-emulated AMD IOMMU PCI device is implemented based on the AMD I/O
>> Virtualization Technology (IOMMU) Specification [1]. The PCI id for this
>> device is platform-specific.
>>
>> Currently, the QEMU-emulated AMD IOMMU device is using AMD vendor id and
>> undefined device id.
>>
>> Therefore, change the vendor id to Red Hat and request a new QEMU-specific
>> device id.
>>
>> [1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf
>>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> Will the existing drivers bind with the device then?

Existing Windows would not recognize the device ID.

Actually, Linux and Windows does not depend on the PCI vendor / device 
ids to probe devices and initialize AMD IOMMU. Instead, it depends on 
the ACPI IVRS table.

Checking on a real system w/ AMD IOMMU enabled booting Windows Server 
2022, there is no AMD IOMMU device showing in the Device Manger.

In this case, I believe Windows is not fully initializing the 
QEMU-emulated AMD IOMMU. So Windows would not remove the IOMMU PCIe from 
the list of OS visible devices and therefore expose the PNPID to the 
device manager. And since the device ID is zero, it appears as an "Other 
devices->PCI Device (with warning sign).

Therefore, it we have two options:

1. Fake the device ID to 0x1419, which is current appear in the 
machine.inf as an entry in section [AMD_SYS.NTamd64]:

%IommuDevice_Desc% = NO_DRV,PCI\VEN_1022&DEV_1419

2. Figure out why Windows does not recognize the device.

Anyhow, we should still assign some PCI ID value (instead of zero).

Thanks,
Suravee



