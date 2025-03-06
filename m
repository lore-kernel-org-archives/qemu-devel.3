Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058F2C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 06:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq56c-0003kW-0c; Thu, 06 Mar 2025 01:53:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tq56a-0003hw-9A
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:53:16 -0500
Received: from mail-co1nam11on2083.outbound.protection.outlook.com
 ([40.107.220.83] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tq56X-0007GU-Be
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:53:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hk48e9r/GXArZqwt1OzvwfMcWiJ9xw2i/gRVtYZnp8HLHekbbTUehwuG+ZcDLvNZbrV60WEXgihaLPiMQO3+DQM5qMK5FMMQcHTauTS7x/ZZWQ3RaqJSFgnJLPAp/UrWnePZfjnT85MsWCV94kx8GJ62Myht2dcEfpSL5KIeG9Wqlu3nfglAvZf4TYaauCZv1kdpvooezWwNOYLKENvZdYJWmQeKXXPckZ243hQQfRNIdT8H2PF+edCX+ISNWSlYkhxwZx4PM7apWcUNjrvJU+Nywmnd8V8JOl2oUN9OMV/JiZmfqwH9qMb4SwYQJjnbpXJL/EHZ5vtAsw9R+XiInA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1swU2iD8Un+r5eRGH9hEsDBRugrfvUad7dUKaLc+Go=;
 b=DUpcLya3nTjGOdygBWPbJvVF8MIvqVjGOPPeB+EYsLtHmP3yLrE/+AjXoE5piHb8IipwuRBrnPSgIRQ7Z9d2tSj2VcgiJSieSMqo3ZcPy6leDd3Kpll5KWPiEw0QG1AYN2WSusoP25vN0tT/sXKBSyNcUdO8tG4TrnkYMiunKIjsu8egfS/Bu4Ibs9w/Nd4zOCfZVN4flfCG7EhIP63l2bivzgrHtnQV9N7IaIJ4R1KuuyjtMmAc4BZ9w6k5A/xXvzyKpEZpdjjXgSweoueBipauKvB6lLR/dfIPahnyrxtKKe+I9dMyYa79ZCe4At0w40AFk76iiIxKK59xFIU73Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1swU2iD8Un+r5eRGH9hEsDBRugrfvUad7dUKaLc+Go=;
 b=qYKMLt2NlRo0qOJYGVdHpVP+g5jEx95ZvcHTIsUa9WZHfaghnnoDlkIJ+HC66zLi9WX/h25wVOYaIk+znxDzyO++AOQSXv/pKZoluy7O1rKzL75Fnd1MN3u4TwRjgK8+uV4goLxTvAexl/3YaISqYh7BDVdFKrH3U+EbzziRY52GJmgUclR/m+wEVCVK/SrjtlHfICTR2zerF7KtSE/0is0crj1ArASjuhxYe8x1iwrqMWlP1nUVeM1buTgiFZP5YSevPp1X0m8PCsrM7OF8TTi0uL2IcCIngeV98kWG9Yerinf3W+LvfcgrWbQN0owQyUhWgNjQJGY8F6fIB6EHOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB5544.namprd12.prod.outlook.com (2603:10b6:a03:1d9::22)
 by DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 06:48:04 +0000
Received: from BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::1a4a:10e9:d53c:d25d]) by BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::1a4a:10e9:d53c:d25d%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 06:48:04 +0000
Message-ID: <629dff3c-865d-47d9-a01a-d212dfed1efb@nvidia.com>
Date: Thu, 6 Mar 2025 08:47:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 30/36] vfio/migration: Multifd device state transfer
 support - send side
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <4d727e2e0435e0022d50004e474077632830e08d.1741124640.git.maciej.szmigiero@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <4d727e2e0435e0022d50004e474077632830e08d.1741124640.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0022.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::9) To BY5PR12MB5544.namprd12.prod.outlook.com
 (2603:10b6:a03:1d9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB5544:EE_|DM4PR12MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 0636ba99-4343-41d9-1098-08dd5c7ad7ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejZIYnJhVGtNZ09Vc3BEMkpLNVRHZ1VTaVF1cjA0U2c2ZmxVeEhWZ1AyVTEv?=
 =?utf-8?B?bVJ1YUIrM2hzNmIzZ1Q4NkFqU2Z1THFnYnlqTGU4UXlsRUdUeFBJMkhjd2V3?=
 =?utf-8?B?Sk90M3JZN1hXLy9SS3htc25teDc3WXgrWm1KTHRUZ3lmWDEvaGh4MFI1MTFx?=
 =?utf-8?B?WWppMjdOV2tkYitPdHRDam8vdHNwOHZKWk02UDVsd2VCOTljTjBFdVVmQ1A1?=
 =?utf-8?B?QTB0cFl1MW9lTXR5OWNqeVYzeld2T1RFK1JKdnZWUjZqL25YNXQxNVRLamFz?=
 =?utf-8?B?b2taYnphUzBEVnJRZ2w4cGNRbC82S3diVXJGK0w1ZnFkY0ExOFZtcGxXNnZv?=
 =?utf-8?B?KzdwTldxaERvNm5lRE5NY2NCQ253TXJDemFKQ0V1WlN6SEd6UXRaYUYwRG80?=
 =?utf-8?B?K013SUlsTkszQ2I0NGx1Q0ZEa0JmbUZVZEVrNkR3Ynd1RkNZT3hwUEo4b0oz?=
 =?utf-8?B?VlFUYnpxVzJjRGg1Y0tPNnBIelJNYVU5aHFYazZma285cCtwL0Nic3lFcHR5?=
 =?utf-8?B?NHQ1NW94OTFLVmpsRWpRNFdpanp4MmtablNXWUR0c1VYSHhaYlZkTWFrVnhh?=
 =?utf-8?B?NHlaS3dqN21IdlBYU1lRWm9wNEY2L2RMRTRjRVI4dXpwU0pZdW1HSCtuZVJw?=
 =?utf-8?B?cjh6aUFuNUhMNk0xRWZ4SVpreHovUmVHZGVsUXVzUkpmMFcxbkdhVUg0YTgv?=
 =?utf-8?B?ZXF1SXV5SldwdlVPSU1paDZIV2E2eC9nWmxnWitDUTlFWWVxQmhpbm5Mb0Jo?=
 =?utf-8?B?Q0lSejMwVnVxcTJxeTdTa3B5TzQwYkZsdGZ4Nit5NEdNZnUyZjlLSmE0M0t1?=
 =?utf-8?B?ZEdvYUxkekJyclpCM1prZERrbnAwMzNYSi83cjlTa3k1Nm9JOTBxZGJia3VG?=
 =?utf-8?B?blRGZmhCK20vQ3RtVDl0elNMKzlEZFU4SmJiZGI5WGljampLWkI4eEY0QmE4?=
 =?utf-8?B?cUh3S2xFcUllYm5FK3Y1Z3ZBL0s1WVhIUnJiTVJsVHoyZTdYMjJuai9pT0lM?=
 =?utf-8?B?RnhrQ25DWkVKUHFTNDJ6Z3E2aE94YXRtT0o3djRVdCtDNnZDeU9LUTl0YXlv?=
 =?utf-8?B?Q0U4TlhQS2lYdGlKVFV6bW5XK3JGYUZPT3hQNTU5NDhUZnRwT3F4b243UnlO?=
 =?utf-8?B?bDVYYnFJZDdqNm5wMldPMVhxcElwWVdiNGVTSnpvZFBPS2w0amcyUzYxWHRt?=
 =?utf-8?B?N2R6Uk9JV3JoWjFPbGhGcWZvMTZUaXdCVUtJMlU0aWtabG9jUjhwMTNDZW9B?=
 =?utf-8?B?NGtpdFRSOUVKL3hDMDhTUFdpSmpQc2djQ2owRWZFSjNoTkptNFQ1eEZFYWtI?=
 =?utf-8?B?dFlTeEZTc3loZzViY3U5NDY3bzNVdUpKSkEwMHdKcStiZitYUzVXZDVPY1dR?=
 =?utf-8?B?VEJjTTlFbWJjSE1kY28xVS9Ec1JxditOZFJtVEJaQnp3ZGc1MXU4RkRhdDFh?=
 =?utf-8?B?QzVxUkFUZVNLSHFIc21XQldwU2ttQXVyL3lpTy9RMGpzVGZOQzVlU3NmZzh5?=
 =?utf-8?B?WUVodnZ1SHkvTWRSQ3ZWK3F5NHUvbms1M3BRRnFjNDNXeHR0di82R3lMZHhJ?=
 =?utf-8?B?ejVaeHBVdDFLVFlIMHZqdkg1RDNMVWd6bk5VOEk4NEljaEVZQS9CSFBZM01B?=
 =?utf-8?B?Q2ltSE1Ic2hTdzFXUWF0TzZMVXJRQ2JGcUcxUENMU21JUWtjZUYrdHJvc2w2?=
 =?utf-8?B?MFNEeW5jMitxdytvVEg2TVdVUDl6RnNITGRwZWx6K0FKTTExN2VBaWlIQmFC?=
 =?utf-8?B?RCtBZmZMQkV3QnhjVFRFTjYvWVludlVTYXBXRUFoSmYxcnlteDBBbG9JUEkv?=
 =?utf-8?B?cTRyL1YxUVZIdVoyVHFxVGIzY09BOGNTSWRWOWl5bWRZcmw1RytVdWNkcG1t?=
 =?utf-8?Q?W83S35TpHcKFu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB5544.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NENReU5yQnFReVdyTTh5cnlvaXh5Q0dEcnkvS204S2syQlF1Q21pKzBoTTli?=
 =?utf-8?B?VnJtNXZ3bTVkVko1bGhCNEcvaGJCUzViMGZhQkh0VkVjY0ZaRTA0WTgxazFX?=
 =?utf-8?B?MjEyTURsYXpQUnJXenFoQjNobldhMjkvWGczeGhJYW5pTlBkd2J4SFBXVTV5?=
 =?utf-8?B?Kzk3VmovQUo3ZWJWc0xUalloMWxZaXpvZG1qVmtPOHJEQ3c5aE5UZCtUQVY0?=
 =?utf-8?B?T080RFJ5aFIrYkhxdTFjSENmaHQ0cGlraGlMRnlmaTJkcVE3Q1NYWlAxS1N4?=
 =?utf-8?B?bmJOcjRZUVNPM3pvYTJpT3A5OWhYL1ZWQmRsZ1NUSThaKzljT3BQNTZpblVK?=
 =?utf-8?B?MzZ4MS8zdWgyMGFyTVRqanIrak9hQzV4MFhDYzZYMXM0eklKY2YrZ3RBaXZ3?=
 =?utf-8?B?WUhXdnROUkZxYktjRVExcXp6VWZTTm56bGdaVk5BTm5pN2NpeEVxakFPVFZJ?=
 =?utf-8?B?bXBwWk5NRU5oQWFOQ2pIZHRKdUFYTis3bTN6Rkw0c25wUzJtY3JJa2RnUUVj?=
 =?utf-8?B?RnZJZzErR1F5cXA5M1kyRmMxbHFkT1ZOMUJlYXFEOVcwd0lWaWlua0ovVS8z?=
 =?utf-8?B?dTFWMEYxZEZzcXdidFR4dnJvTFpvMUtGTi9TMWhlSUJ1bEFOSU9WZ1dEUytD?=
 =?utf-8?B?K0JmWUxlL29KMEFvME9rdnFDaUNNYnRXa1J5c1F6U29aQms1VGtqK3AwYTlF?=
 =?utf-8?B?UEV0MzlKWU1raDJlMThxZmZ2SXU3TS92N2tINmhINy8rL1Btd3ZHS3lIYmo0?=
 =?utf-8?B?VkJqNHlBcjVIMEUrckVVTmlUa2NpVGRsOHIwWGx0ZE9kRWJaRUVySmNGS2o2?=
 =?utf-8?B?SERYWHZiVkhGVFpwbWE4RVN1Wm5mMnZZMzVxWWNHb2FHVUhrVlFuVHozN3Bp?=
 =?utf-8?B?Yk9VU2F4UHVValBNREFzU1EyUkdJSnlKdi9SeklaVEpYUk1GTGlhRUdKOUZr?=
 =?utf-8?B?N2pIVll2b1RKV2NGU1NrN1FaN2dsZkk4azhocHM2STg0VjRUNlU2K3prT1lx?=
 =?utf-8?B?ZmM0dXFsRHdXa0ovTFJGLzRmTTQzR2dqV1BNcUJBaC9SMDFUbHNmMjZqK1Z0?=
 =?utf-8?B?QW9OTGpldkw0VUxhbkdwNUg4azJ3N0czZ01kbnhxQ2hJNXJLNk5tUGtZM0x3?=
 =?utf-8?B?SFB1cU9NeWZxdVZIcjRHMTlNY1ZoYkljZmR4eU53OHgxTEcyU2RmYjRBZXpO?=
 =?utf-8?B?cnl1QTVVSmNHVlNjNUdEclQ1Q3pkN3ZVNzFMLzk3ZTh1RlFRUTJjT1BIQldR?=
 =?utf-8?B?YXJJVHhaeVZTZlFQbExrWlV0OHkyZ1VhbFF6L1ZrdjNrcWFzbVQxdi9ndFMr?=
 =?utf-8?B?a25DK0NMVkk2bWViVXYzQkp0OUNTM3JDUEo3Skl2ckI1dzNTWlpNQXlHbCtZ?=
 =?utf-8?B?TGdyZG45ZHY3MlpVUy9KeXlrbldDOUdMS21oSnNndll1OHNYc1JCNkt1UWx1?=
 =?utf-8?B?SG9pQS9EaEErZ0tsMXVYTE1OT0RUZXZKZ0ttVFovbHhDWDdHY0loeDVxVGxZ?=
 =?utf-8?B?SU5JRTZ2aDNDUzR0aVIvVmxpY3llc1ZacnpjaHZyWWFyaWJtZXZvMVdpbGZ0?=
 =?utf-8?B?blBvc2IwRHl1RlBYWFFJSS9NYVk2ZE03ZG1nRWxaN2JoaTYvdmNPQitNSXVr?=
 =?utf-8?B?emoyeGxJaXlXd0tpZGNvOWhUcDNFOHpqQ2dSVzV3WlNsdkNPc1pSczhmVmVo?=
 =?utf-8?B?SExxdi9Bck1ScFZjL0hRTlNNMWNHQkVHZEdOdVIxWm4yRDNtK2p0aEZMYnFn?=
 =?utf-8?B?TWF2eHFReDgyYTBMVmx5WFdDTEttNTFzNkNVejIrQmp5OWZ0QVdRRE56MEVM?=
 =?utf-8?B?T1RkY3lOeWErVFBRQnJrYkQ4Y2h5N3J0RVR5TFlPaG9NS1Q5VDVNTmY2QUdL?=
 =?utf-8?B?S1BLazhzWldJVG1uSGQyb2NFdHZxbHBZbENTRzlJblJraFh2NGUzbm1ERXh5?=
 =?utf-8?B?VlQwWit5UlYvMTVvMTRpSzlPRVpPSG8wS1lJOU10VWoyaHhEQmxEM0d0OUxP?=
 =?utf-8?B?TWtmVFhkWDZnemtUR21zbDIvTTU1bUhRM0poRmV2bklrbU85a2paYTYwaHRh?=
 =?utf-8?B?SXJlYWo0UzcyQ3VZRGJ3ZFpPNWJ6dnpDU1p1UDc2anZjajZ5WWowb3Q0SzRK?=
 =?utf-8?Q?00q5qy5FYxH6J4SzNJuv1Cu2o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0636ba99-4343-41d9-1098-08dd5c7ad7ec
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5544.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 06:48:04.2515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: im5/6ShLlfOqu1mNd1AeFJCCgpFxzd6FjckaXOVIzQD0qbPiYQi0jbmNkROqmcDNvm48/2AjaLp9DPEHnBCGhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648
Received-SPF: softfail client-ip=40.107.220.83;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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


On 05/03/2025 0:03, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> Implement the multifd device state transfer via additional per-device
> thread inside save_live_complete_precopy_thread handler.
>
> Switch between doing the data transfer in the new handler and doing it
> in the old save_state handler depending if VFIO multifd transfer is enabled
> or not.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/vfio/migration-multifd.c   | 142 ++++++++++++++++++++++++++++++++++
>   hw/vfio/migration-multifd.h   |   6 ++
>   hw/vfio/migration.c           |  22 ++++--
>   hw/vfio/trace-events          |   2 +
>   include/hw/vfio/vfio-common.h |   6 ++
>   5 files changed, 172 insertions(+), 6 deletions(-)
>
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index 1d81233c755f..bfb9a72fa450 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -496,6 +496,148 @@ bool vfio_multifd_setup(VFIODevice *vbasedev, bool alloc_multifd, Error **errp)
>       return true;
>   }
>
> +void vfio_multifd_emit_dummy_eos(VFIODevice *vbasedev, QEMUFile *f)
> +{
> +    assert(vfio_multifd_transfer_enabled(vbasedev));
> +
> +    /*
> +     * Emit dummy NOP data on the main migration channel since the actual
> +     * device state transfer is done via multifd channels.
> +     */
> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> +}
> +
> +static bool
> +vfio_save_complete_precopy_thread_config_state(VFIODevice *vbasedev,
> +                                               char *idstr,
> +                                               uint32_t instance_id,
> +                                               uint32_t idx,
> +                                               Error **errp)
> +{
> +    g_autoptr(QIOChannelBuffer) bioc = NULL;
> +    g_autoptr(QEMUFile) f = NULL;
> +    int ret;
> +    g_autofree VFIODeviceStatePacket *packet = NULL;
> +    size_t packet_len;
> +
> +    bioc = qio_channel_buffer_new(0);
> +    qio_channel_set_name(QIO_CHANNEL(bioc), "vfio-device-config-save");
> +
> +    f = qemu_file_new_output(QIO_CHANNEL(bioc));
> +
> +    if (vfio_save_device_config_state(f, vbasedev, errp)) {
> +        return false;
> +    }
> +
> +    ret = qemu_fflush(f);
> +    if (ret) {
> +        error_setg(errp, "%s: save config state flush failed: %d",
> +                   vbasedev->name, ret);
> +        return false;
> +    }
> +
> +    packet_len = sizeof(*packet) + bioc->usage;
> +    packet = g_malloc0(packet_len);
> +    packet->version = VFIO_DEVICE_STATE_PACKET_VER_CURRENT;
> +    packet->idx = idx;
> +    packet->flags = VFIO_DEVICE_STATE_CONFIG_STATE;

The packet is sent on the wire.
Shouldn't we use cpu_to_be32() for version, idx and flags? Also below in 
vfio_multifd_save_complete_precopy_thread().
And then use be32_to_cpu() in patch #26 when receiving the packet?

Thanks.

> +    memcpy(&packet->data, bioc->data, bioc->usage);
> +
> +    if (!multifd_queue_device_state(idstr, instance_id,
> +                                    (char *)packet, packet_len)) {
> +        error_setg(errp, "%s: multifd config data queuing failed",
> +                   vbasedev->name);
> +        return false;
> +    }
> +
> +    vfio_mig_add_bytes_transferred(packet_len);
> +
> +    return true;
> +}
> +
> +/*
> + * This thread is spawned by the migration core directly via
> + * .save_live_complete_precopy_thread SaveVMHandler.
> + *
> + * It exits after either:
> + * * completing saving the remaining device state and device config, OR:
> + * * encountering some error while doing the above, OR:
> + * * being forcefully aborted by the migration core by
> + *   multifd_device_state_save_thread_should_exit() returning true.
> + */
> +bool
> +vfio_multifd_save_complete_precopy_thread(SaveLiveCompletePrecopyThreadData *d,
> +                                          Error **errp)
> +{
> +    VFIODevice *vbasedev = d->handler_opaque;
> +    VFIOMigration *migration = vbasedev->migration;
> +    bool ret = false;
> +    g_autofree VFIODeviceStatePacket *packet = NULL;
> +    uint32_t idx;
> +
> +    if (!vfio_multifd_transfer_enabled(vbasedev)) {
> +        /* Nothing to do, vfio_save_complete_precopy() does the transfer. */
> +        return true;
> +    }
> +
> +    trace_vfio_save_complete_precopy_thread_start(vbasedev->name,
> +                                                  d->idstr, d->instance_id);
> +
> +    /* We reach here with device state STOP or STOP_COPY only */
> +    if (vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
> +                                 VFIO_DEVICE_STATE_STOP, errp)) {
> +        goto thread_exit;
> +    }
> +
> +    packet = g_malloc0(sizeof(*packet) + migration->data_buffer_size);
> +    packet->version = VFIO_DEVICE_STATE_PACKET_VER_CURRENT;
> +
> +    for (idx = 0; ; idx++) {
> +        ssize_t data_size;
> +        size_t packet_size;
> +
> +        if (multifd_device_state_save_thread_should_exit()) {
> +            error_setg(errp, "operation cancelled");
> +            goto thread_exit;
> +        }
> +
> +        data_size = read(migration->data_fd, &packet->data,
> +                         migration->data_buffer_size);
> +        if (data_size < 0) {
> +            error_setg(errp, "%s: reading state buffer %" PRIu32 " failed: %d",
> +                       vbasedev->name, idx, errno);
> +            goto thread_exit;
> +        } else if (data_size == 0) {
> +            break;
> +        }
> +
> +        packet->idx = idx;
> +        packet_size = sizeof(*packet) + data_size;
> +
> +        if (!multifd_queue_device_state(d->idstr, d->instance_id,
> +                                        (char *)packet, packet_size)) {
> +            error_setg(errp, "%s: multifd data queuing failed", vbasedev->name);
> +            goto thread_exit;
> +        }
> +
> +        vfio_mig_add_bytes_transferred(packet_size);
> +    }
> +
> +    if (!vfio_save_complete_precopy_thread_config_state(vbasedev,
> +                                                        d->idstr,
> +                                                        d->instance_id,
> +                                                        idx, errp)) {
> +        goto thread_exit;
> +   }
> +
> +    ret = true;
> +
> +thread_exit:
> +    trace_vfio_save_complete_precopy_thread_end(vbasedev->name, ret);
> +
> +    return ret;
> +}
> +
>   int vfio_multifd_switchover_start(VFIODevice *vbasedev)
>   {
>       VFIOMigration *migration = vbasedev->migration;
> diff --git a/hw/vfio/migration-multifd.h b/hw/vfio/migration-multifd.h
> index f0d28fcef2ea..a664051eb8ae 100644
> --- a/hw/vfio/migration-multifd.h
> +++ b/hw/vfio/migration-multifd.h
> @@ -23,6 +23,12 @@ bool vfio_multifd_transfer_enabled(VFIODevice *vbasedev);
>   bool vfio_multifd_load_state_buffer(void *opaque, char *data, size_t data_size,
>                                       Error **errp);
>
> +void vfio_multifd_emit_dummy_eos(VFIODevice *vbasedev, QEMUFile *f);
> +
> +bool
> +vfio_multifd_save_complete_precopy_thread(SaveLiveCompletePrecopyThreadData *d,
> +                                          Error **errp);
> +
>   int vfio_multifd_switchover_start(VFIODevice *vbasedev);
>
>   #endif
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index f325a619c3ed..24bdc9e24c71 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -120,10 +120,10 @@ static void vfio_migration_set_device_state(VFIODevice *vbasedev,
>       vfio_migration_send_event(vbasedev);
>   }
>
> -static int vfio_migration_set_state(VFIODevice *vbasedev,
> -                                    enum vfio_device_mig_state new_state,
> -                                    enum vfio_device_mig_state recover_state,
> -                                    Error **errp)
> +int vfio_migration_set_state(VFIODevice *vbasedev,
> +                             enum vfio_device_mig_state new_state,
> +                             enum vfio_device_mig_state recover_state,
> +                             Error **errp)
>   {
>       VFIOMigration *migration = vbasedev->migration;
>       uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
> @@ -238,8 +238,7 @@ static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
>       return ret;
>   }
>
> -static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
> -                                         Error **errp)
> +int vfio_save_device_config_state(QEMUFile *f, void *opaque, Error **errp)
>   {
>       VFIODevice *vbasedev = opaque;
>       int ret;
> @@ -638,6 +637,11 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>       int ret;
>       Error *local_err = NULL;
>
> +    if (vfio_multifd_transfer_enabled(vbasedev)) {
> +        vfio_multifd_emit_dummy_eos(vbasedev, f);
> +        return 0;
> +    }
> +
>       trace_vfio_save_complete_precopy_start(vbasedev->name);
>
>       /* We reach here with device state STOP or STOP_COPY only */
> @@ -669,6 +673,11 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
>       Error *local_err = NULL;
>       int ret;
>
> +    if (vfio_multifd_transfer_enabled(vbasedev)) {
> +        vfio_multifd_emit_dummy_eos(vbasedev, f);
> +        return;
> +    }
> +
>       ret = vfio_save_device_config_state(f, opaque, &local_err);
>       if (ret) {
>           error_prepend(&local_err,
> @@ -815,6 +824,7 @@ static const SaveVMHandlers savevm_vfio_handlers = {
>       .is_active_iterate = vfio_is_active_iterate,
>       .save_live_iterate = vfio_save_iterate,
>       .save_live_complete_precopy = vfio_save_complete_precopy,
> +    .save_live_complete_precopy_thread = vfio_multifd_save_complete_precopy_thread,
>       .save_state = vfio_save_state,
>       .load_setup = vfio_load_setup,
>       .load_cleanup = vfio_load_cleanup,
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index d6b7e34faa39..9347e3a5f660 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -171,6 +171,8 @@ vfio_save_block_precopy_empty_hit(const char *name) " (%s)"
>   vfio_save_cleanup(const char *name) " (%s)"
>   vfio_save_complete_precopy(const char *name, int ret) " (%s) ret %d"
>   vfio_save_complete_precopy_start(const char *name) " (%s)"
> +vfio_save_complete_precopy_thread_start(const char *name, const char *idstr, uint32_t instance_id) " (%s) idstr %s instance %"PRIu32
> +vfio_save_complete_precopy_thread_end(const char *name, int ret) " (%s) ret %d"
>   vfio_save_device_config_state(const char *name) " (%s)"
>   vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size %"PRIu64" precopy dirty size %"PRIu64
>   vfio_save_iterate_start(const char *name) " (%s)"
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 9d72ac1eae8a..961931d9f457 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -298,6 +298,7 @@ void vfio_mig_add_bytes_transferred(unsigned long val);
>   bool vfio_device_state_is_running(VFIODevice *vbasedev);
>   bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
>
> +int vfio_save_device_config_state(QEMUFile *f, void *opaque, Error **errp);
>   int vfio_load_device_config_state(QEMUFile *f, void *opaque);
>
>   #ifdef CONFIG_LINUX
> @@ -314,6 +315,11 @@ struct vfio_info_cap_header *
>   vfio_get_device_info_cap(struct vfio_device_info *info, uint16_t id);
>   struct vfio_info_cap_header *
>   vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id);
> +
> +int vfio_migration_set_state(VFIODevice *vbasedev,
> +                             enum vfio_device_mig_state new_state,
> +                             enum vfio_device_mig_state recover_state,
> +                             Error **errp);
>   #endif
>
>   bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);

