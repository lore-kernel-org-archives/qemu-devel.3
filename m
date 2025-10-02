Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F330ACAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 18:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4OAL-0005N9-9t; Thu, 02 Oct 2025 14:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1v4OAE-0005FX-Ox; Thu, 02 Oct 2025 14:36:26 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1v4O9u-0007m2-BS; Thu, 02 Oct 2025 14:36:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUWki+aUCHA20IdiQW2Bx5VVhWTZ4rIRZAIBgMRnC114JhKdb4PElvVC0pcRUtsQoqG09aUUi53alkkfI72wCsdYkxOVJ1EGEdIsuACdV/Y5gIlWSeRxcO9Oqfjs63gEl4yVorhwNSBQITfFAhXT4+LC4qhHlAftZ76ccJtxLxnVcZ71B4poKUo7wax/SAD+jzi73/6Rk1sAtZ/YVnezdGsUdFcbK8ML8aTtTCHGMoTInX3H+78CzpglBFskr57SJZbNwQPIOWHq65PbKg2qzcCuCcYgbSBX4EYPFD8nkIiPP07TKuhqct/4ioZG1LMg7QlWwMh+taqLQBptmZdl2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVYaTeMqdtzzbiRTeDUTgzm5EwF8PBd36SCTsWVCfqo=;
 b=NuiN+W+IkXEYTZ92JufesBZqewIluhnNimk2e7pJvbuj/fzk26xGtLGzD0SEChjH0kYLfi2SvbhK9jhN0JGYBEdusaLdPVnG6BPGcmPsDHe3xgrE3oQqqqg2jgeWcszyU+H/OXZG2YHV3WFoKGXO94piimqzaF2AF/erHTdbte/Hv2B5UIpftKZVquORBc68RI1E3/lEbbVC9LRPO1Qr4bQhjVE1jUfmOf94Guzt2uhEY7Df+b7YKqwEqPF7gCXWmZSqM6ls5+lmlftt5BF0boFH/LWrxPwfSABlXGRHo+7D7r2Bza8ExTxvvXZcgXsKafTpE1JSksTgF2UYu0A61g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVYaTeMqdtzzbiRTeDUTgzm5EwF8PBd36SCTsWVCfqo=;
 b=J2nkGKX5x4gRphSkPNuniIjNQibJOG+lMIKbX2gpIAv8hlLKyTEnHot3u9F39zs1bJhTKu5vLQvn+Gxc8lyObrs0//9akpH8BI4iuILaeBLYx+Y2KyZS9mpArZU1cDnamYEXD6fde3d03W/USyDKzPzE4IsdgaFNJoFuvcmwlF+52rOXMEsnbmtQ0bthMoO3N5NQtogCXTf3zwstdseLoIVu1oRytOT+9tVcDl+H4MIVIazV48vs5i41dUKH9jlD9S0TpipqJ3i9OujtOrWOEnJ1uyhl8oN3pmc0z2WWdttg/O1xU//kAsbPhPEdE2mGbgZWTFtRQhZB+45vr6724w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.19; Thu, 2 Oct
 2025 18:35:43 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.015; Thu, 2 Oct 2025
 18:35:42 +0000
Date: Thu, 2 Oct 2025 15:35:41 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Shameer Kolothum <skolothumtho@nvidia.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: Re: [PATCH v4 08/27] hw/arm/smmuv3-accel: Add set/unset_iommu_device
 callback
Message-ID: <20251002183541.GF3299207@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-9-skolothumtho@nvidia.com>
 <7167d287-f0d0-4bb8-8750-e38e9e31df10@redhat.com>
 <CH3PR12MB7548C5CB7B9BE18AAE5492BEABE7A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aN6r4n2F1s2ZLm9d@Asurada-Nvidia>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aN6r4n2F1s2ZLm9d@Asurada-Nvidia>
X-ClientProxiedBy: BN8PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:408:ac::35) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|CH2PR12MB4327:EE_
X-MS-Office365-Filtering-Correlation-Id: 3268a5bb-f7ee-478d-25e6-08de01e27e52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?LzVOMWd0QmV4NjMxSEwxbDJhd211TUJSTDBWRUMwTndOaHFQbDYvMXAxVkJE?=
 =?utf-8?B?cCtNYjRUQnBFOHd1YkZKTGpFKzVkbVFjRUN5ZTJDN1M2TWxTdjl4QnlONDQ5?=
 =?utf-8?B?Zjd3RlFUaEp0UTZ0T0IxYmM1Q0dlZysyWUd5MVo4YTdnTndWeHFuL3dvSUhN?=
 =?utf-8?B?WjFEM0JEUUZSVmwwa3NkTnBTb1ZqQm5HdGR2bkJMNWVSUXBFVFhCejN1RTBv?=
 =?utf-8?B?dFVXQjlucXlFZW5JMW9YN1RhUCtGcTZnQmo3cWxDOER5QjVzQlFkQkEvWXdE?=
 =?utf-8?B?MEtXTWt1SXlnN1JVQTkvQk5xcXlmbk0zcldkc093djloQmxyaWlCV01FUlFP?=
 =?utf-8?B?ZDB2SXBhWnAyTTRwVU92UENDWnBzOVluTUlCMWNFSDhCekU1cVl6aVgxWXFF?=
 =?utf-8?B?QlJGZUR1WVA3Qk5aSTFjdXZxUEUyczNoNnRsS2tFTjNyUDVCMzM4ZmVzSlR2?=
 =?utf-8?B?RVNnMS9hU2ticU9jalJ4NU5xQ2tYNHdVSTQ3WnpBMDJCSUhld2duY2xUb2hz?=
 =?utf-8?B?Z0Robk1XOXFVTDFCSmUzS0NVb1lOVE1zRGRTcFN2TmYrc1ZiNzkyeHhKZnNZ?=
 =?utf-8?B?SnBlNDVESzc5Y2pkaUZmczJneUdMR29XMzduSHdNK1RkQUcwTFlocVI1am1a?=
 =?utf-8?B?aEFlenVneVRLUG44LzdLUUI3MEpHay9FZmFCVTd2VmhKNzR6REFwMjVFdlZG?=
 =?utf-8?B?K1NXODB4S0Vad1ZIZE1pNzBIeHFlTVBBaFR1SzNVRWxYbVh5QXR6aG5RN2tt?=
 =?utf-8?B?dy9XajVXa3N4YUtoZ0MyTHdONnJiZzR5NmQrU3F4enFIZVd2RGlvRVlVL0tC?=
 =?utf-8?B?VDFUZWpOWmhJeWhHT2t5KzBMQUxmYUZaakFMZnVhQi9BTDgybEV2K012dVNB?=
 =?utf-8?B?QVRsRGZRMXIydlVlMmtqZ0VxUjh5emNkUVh4NnFjWUphc3lnOTgyQXVNMGhU?=
 =?utf-8?B?MDFCbEhUZ0QzVHZNaGJnM0J5TTlnMjEwUUY1Q1RjOEhpL3M5K3RwR1NpNVE1?=
 =?utf-8?B?TkRlT1oyRHVocVpTQnNYQnd4STN0UnE5RDdlU3VaTGlHbVlYcjhiZnlFcksw?=
 =?utf-8?B?VzVOMFNhR0pTOUVrbktRbXRKVWlrcXRmYkk3V0h2cTExNUNZZUVUVGFNS2Z3?=
 =?utf-8?B?TE9UaU9sSHgwb1RhL3JoQ1RoVzUxdGExWXF1RzlkTHJ2VGZUVzg4eFBxTTAv?=
 =?utf-8?B?TmNiY01NNmFqOXcxOXF6QktFQkZYRHlaamFUcnNHZ1A3UTdrdGtFdWp0MnAz?=
 =?utf-8?B?REFad0NxSWJIeHhZRmNmWTgwVTVvS2tDU1NWU1lRWFExTkR2R0hDWVFDUVJZ?=
 =?utf-8?B?eHJlQ0hoVitESzRIREYxTTd5Q3NsNVVKTDZqZFZiRmNUQ0Y3a1lUdUlNdlBZ?=
 =?utf-8?B?NWVId1Bkc0xKUTJMRzJtQkU5dzNLMCtiNGdiVCthOVc3OWRGNmdnMEdwQjZz?=
 =?utf-8?B?OUlxL2FoRmpFZENocGdTZ0tGK1RhUjIwb09YaUg0K3kvdXl4K1c3N0orYnRU?=
 =?utf-8?B?eDh3RjBHVXkrSGRkWGIwMUYvZ0pYTi9icXc2Mmw2enlrN29TSkNBb29yVFFw?=
 =?utf-8?B?OXRSa05WVEdiUXhENFJWRWNUR0xGcm55UEhIRE9xK0E2VTNFMEJMT3hGRVND?=
 =?utf-8?B?bmpTc2RTM1dRcFpnUDJTazVJei9EdndpY0VQb2tvREZFVnQ0eFhocTFVLy8y?=
 =?utf-8?B?U2pXUTFzZVlWRCtJbFo1U2JhaEp4Qnl2SGhzN0MyVC91cUdkdEtlWWYzL1Ix?=
 =?utf-8?B?RGRuL0tWQjR3NUxia2FGb3MrZTl6dEpaSzlvZ1lpTmtxS2ZvVXZHdWh4ZEo2?=
 =?utf-8?B?MTZmTVd6ZDJrcmdIMXNNOVkxWUFvTkZ0NnVxUjNZMkE4QzNVZ0pvZS9HSWJJ?=
 =?utf-8?B?ak1nek01eTNIRlQwYlE1RmtHMGRnd0dseVUwYVVpRUNadXZyelY5enZtaTBM?=
 =?utf-8?Q?Sdka/Jl4FBF8OmkJ8F4+N6gTzY8sPmIN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5757.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDdMWVVkcTZuK0tYSGFrdUZrYTRhalJ0c05TY2dRdnJ2TWxzV0FlMjRGSFcr?=
 =?utf-8?B?OHlOR1dYYmVyVjcrY2pmSG1vSXNMZHNZK1RhR0JzTGJ1a2lqZ2EreHlJSXZx?=
 =?utf-8?B?TXdDUlpMWTlmZXhObjkvSmVZTU1mYkUrdEtIaG9nZTJHM3YwRmxWQXRkV3U3?=
 =?utf-8?B?djIwcFpKRXRReExsUVlhOWowL2o1WHUzdU9MOHZ5bDlGK1B0VnFSU3VQV1d0?=
 =?utf-8?B?dVdjQVJuUCtzc0haTzJ4dTRNRHVmdytjMHRyNFR2VnZ5bWF5c09zbUFjN0FQ?=
 =?utf-8?B?OGZOYlhlRFh5TVQvbEgzbGJpUGh4Yjd6UzZkVHZoWGsrOVA1Y1JpNnE3NFQ0?=
 =?utf-8?B?cjdnREs2QU5aRzRoR3BxRnlISk41SE1MV096Z3pVZUc3MC9RRDhST0ZkSnc5?=
 =?utf-8?B?eGZsSE9tODZGNEt1ckZzVFBTeEgwb1p2Z3BhbXNkNGxoVnl5bnJGSzg4VTEr?=
 =?utf-8?B?UTN4ZkpvK3NTZGx4Qk1JQzN6UlI1ekoybWxOcUhrdko2NUI0bkhYc3FmMGtu?=
 =?utf-8?B?N0VKNVltY1RwdzB2QkZZWHBhcm92STV6SGtqZitMMlZxb3ovRVExVTE5Q1FF?=
 =?utf-8?B?NkdRcks1K3dLQ0VjZi9nenQxSDJRNWorM2hPMEdkUW0yZDUwR0grVDRkNFhS?=
 =?utf-8?B?YkdubzhnTVgvaTBoM2dZQlpMdE5HMjA4dEI0TU1BakZDUEtHMDJpd21xQm11?=
 =?utf-8?B?THpZa0lQOU9mMkM2SEx2MyttTmk5WGpKVlV5SXZiVjhQeE9SWUF5M0RTdGs2?=
 =?utf-8?B?SUh0b0l1MkhGR0psTkpDdlZTMkdwMW9EUVAwK2xxRkVrYXB1UVFoQ21JcHRR?=
 =?utf-8?B?RkxISm1BYWxEN1o2WkpESUZ1elZRenZzeDEyQ0liZXFzT0VhRnY3Q1pVZXFH?=
 =?utf-8?B?bDkxR1NNUnZKeFZ0ZjJFUDNodzRRRy8xMHgyMGZUODN2MUV4QzFnQVFqR1lv?=
 =?utf-8?B?bFFHMXdyNnpVY0h0cU1YT1NsZ0NiQWJFL1FQM2cyeThpd3pCckZEdWJKMW1V?=
 =?utf-8?B?TUJrTW9YQW5KWEJPQXJPQk1sMWd6Q2ZlZTNic01IVHE2ckdLV0g1eWZPMmVG?=
 =?utf-8?B?djdKM2VpcS8rV0g2UlBxcWlMMEZhTUEySTNScXJIeEpNK01mcW4wNVd2TEFh?=
 =?utf-8?B?Q2UyQi8xdmVKV21oME83RjNZeGdFTmFwSVcwVzBaSldZRVlSN3FTUWZtdVdF?=
 =?utf-8?B?TTRsV3Z3YkRKbnoxVXF1NGJMZ3RMR09aVFA5NWpmeC9nZFF0cTVSbExyRzZK?=
 =?utf-8?B?bUdReVArR01Qd0ZHZXJKSHhaOHcyT2UrVzNyWGhvdlpabTNFcVY4cEhtanQz?=
 =?utf-8?B?amZmRUxCekx5TWNIdFpoWlp4NmlwZVlMRkZmTUp6RTlnSjZacktIQVB1UCs2?=
 =?utf-8?B?Zy9jMDZjTmV1Y2I5Nkh3MXlnYXNqQVNiajV6RnJuUU4zZEc0K1lNaDZkQmMw?=
 =?utf-8?B?Qmd4TExuZElIVDI1QmdMbGo4bXI5eGVILy9XOG1JRFhZL2Q3VmdRakQ0MnVu?=
 =?utf-8?B?cEs4N1AveFZielJiM09PVEZpMHptQWNzd1RFdTRPeHlXQXY1MW9Sa1FIbysr?=
 =?utf-8?B?RlhTUEN0THN0L1FNVUJrNGJveFVrZmJHYWZ6VTc0blBWdk9DQUh4YUtTS2Zh?=
 =?utf-8?B?cWttUUpnd3lrS2xSZzVXc1prbmRxR0ZOQVROeXE4T1lNU2RsUDVDUDV4cGpl?=
 =?utf-8?B?NGJhQjEydlVxdmpxQ0lsa3JTckhMVU1aNVRYK2l1a0JwalF2d1k3V3pYazBs?=
 =?utf-8?B?dmNycGRCck81alNjVGZpNkpIYnlaVVVlaXdkVVJaN1NORmRFd1hsTGRNLzJy?=
 =?utf-8?B?OHQ1VGJnT2gwQWx0bFV4aTZiY2NoWlBpN1FsdDc2QjdlSEtLOUhtbnBWQ0lZ?=
 =?utf-8?B?TlF5RUJsNFptTFZMajl3dXp3RStTNXA0OUIrWHg3a0VEc1Blbnh3NnhDUjhm?=
 =?utf-8?B?OGNlT0pYcFQvK2FRUzZVSGQyT1BYMU9xdFE1OEc3Q2c3U0tGQUZTVHdwTEFs?=
 =?utf-8?B?MjM5Y1AwQ0dBUzc2WVRVbHErYnBTcG1neGovYU1Rc3hleUpCN25PSzkzZjVr?=
 =?utf-8?B?a3UwUVBwRGlURkZ1NlBBQW9kRmpieE5lNmpkTjRscVZmOG5WcGlOK0lVRExC?=
 =?utf-8?Q?GjLU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3268a5bb-f7ee-478d-25e6-08de01e27e52
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 18:35:42.9013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n8kBnzQxfOJJWmOM5AO2pwNSKN4Ue725wqizoGszn21EZTokYqDM68nU7yNQ0CPI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=jgg@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 02, 2025 at 09:44:18AM -0700, Nicolin Chen wrote:
> On Thu, Oct 02, 2025 at 04:34:17AM -0700, Shameer Kolothum wrote:
> > > > Implement a set_iommu_device callback:
> > > >  -If found an existing viommu reuse that.
> > > I think you need to document why you need a vIOMMU object.
> > > >  -Else,
> > > >     Allocate a vIOMMU with the nested parent S2 hwpt allocated by VFIO.
> > > >     Though, iommufd’s vIOMMU model supports nested translation by
> > > >     encapsulating a S2 nesting parent HWPT, devices cannot attach to this
> > > >     parent HWPT directly. So two proxy nested HWPTs (bypass and abort) are
> > > >     allocated to handle device attachments.
> > > 
> > > "devices cannot attach to this parent HWPT directly".  Why? It is not clear to
> > > me what those hwpt are used for compared to the original one. Why are they
> > > mandated? To me this deserves some additional explanations. If they are s2
> > > ones, I would use an s2 prefix too.
> > 
> > Ok. This needs some rephrasing.
> > 
> > The idea is, we cannot yet attach a domain to the SMMUv3 for this device yet.
> > We need a vDEVICE object (which will link vSID to pSID) for attach. Please see
> > Patch #10.
> > 
> > Here we just allocate two domains(bypass or abort) for later attach based on
> > Guest request.
> > 
> > These are not S2 only HWPT per se. They are of type IOMMU_DOMAIN_NESTED.
> > 
> > From kernel doc:
> > 
> > #define __IOMMU_DOMAIN_NESTED   (1U << 6)  /* User-managed address space nested
> >                                               on a stage-2 translation        */
> 
> There are a couple of things going on here:
> 1) We should not attach directly to the S2 HWPT that eventually
>    will be shared across vSMMU instances. In other word, an S2
>    HWPT will not be attachable for lacking of its tie to an SMMU
>    instance and not having a VMID at all. Instead, each vIOMMU
>    object allocated using this S2 HWPT will hold the VMID.
> 
> 2) A device cannot attach to a vIOMMU directly but has to attach
>    through a proxy nested HWPT (IOMMU_DOMAIN_NESTED). To attach
>    to an IOMMU_DOMAIN_NESTED, a vDEVICE must be allocated with a
>    given vSID.
> 
> This might sound a bit complicated but I think it makes sense from
> a VM perspective, as a device that's behind a vSMMU should have a
> guest-level SID and its corresponding STE: if the device is working
> in the S2-only mode (physically), there must be a guest-level STE
> configuring to the S1-BYPASS mode, where the "bypass" proxy HWPT
> will be picked for attachment.
> 
> So, for rephrasing, I think it would nicer to say something like:
> 
> "
> A device that is put behind a vSMMU instance must have a vSID and its
> corresponding vSTEs (bypass/abort/translate). Pre-allocate the bypass
> and abort vSTEs as two proxy nested HWPTs for the device to attach to
> a vIOMMU.
> 
> Note that the core-managed nesting parent HWPT should not be attached
> directly when using the iommufd's vIOMMU model. This is also because
> we want that nesting parent HWPT to be reused eventually across vSMMU
> instances in the same VM.
> "

This all seems correct to me

Thanks,
Jason

