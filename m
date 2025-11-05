Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B7ECCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 18:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGhyW-0003GI-Hi; Wed, 05 Nov 2025 13:11:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vGhyJ-00036K-LS; Wed, 05 Nov 2025 13:11:04 -0500
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vGhyG-0004eA-0S; Wed, 05 Nov 2025 13:11:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9jSNiGkZpRGWxfMEUd2hXxQjW4E1GFZtRrRKdIX8MsimoTenXz+X6wJCrg84Ycw00JQbGQivdTz5tpMNvsh3uPDKlK6jVM5+kRSkjB9LYBHnaPINIXHpVlS5iYZAlGlTY7XAsOnCkBWTUcUHYwNXFDC/SyPKbbLVQwFSf7jYQqwrwVqT91V4hwPhBV8yfVM6ylp4SSQRLV+iXjUj2Vcer6B/UxBUDR2u6V0KcRolRdiikLAf7YGDPmfD00Sgz8pcf/GXt3mHuU/WZFyPB/DyffuCODfTPCeQkFUSuN2+8UpUyzi0nipSH3PoSkDbG9FnLaue5MIdcRPtgF5RyDVTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwCFPCE49BPzbTEZ+8zMpitWHA8Ai3jovqdvp+8NFyI=;
 b=DWlGKCL6ONeQm8I2BFHN8Mb+g2KyzczcioBDVQHICSjWel1eLDCJD8VcmPTqrC6bQUTceO7HSTvA9jDKRzM4QljUjpMYwlQ/wwdW9gqDzGQXNJoi/yS0BBEY3L836svXJs/lerTAXzxwsEpIP6IAEj0pfvaMB1zGIQ4PTG0ufxqyRtNqYfurCssSK/qQUNXAd8lmAqqqjLgb4kOz8h7OmRdS0mVdMKBnYQNbODmuI1n7mMGPDI8rL19f9Ac8d+3Xk7WNIt7OHZqTVr/3gW1RifmBzquPmqhe6hcdAhow6Pblrpfvk2qieU1O//LZrV96Ivc3A+tG/8THvP7ZUtnlrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwCFPCE49BPzbTEZ+8zMpitWHA8Ai3jovqdvp+8NFyI=;
 b=U4FY11nkPrCbB6Ebq30Lw61GMsVoYAxHXMQ2YL+d0PldJLh/YiviYcUiAuBYuQSDsQi0aFkOQJABLCLfPSarbZ++62sK11yVORj7pKcf64KHG/1UKVVTyocuLlqgj6F2FuRUohV16iZvgIYQfm+Jy8LxjtfosU5sLPwak/Xa3pFAkpbJDcCpDAP/R6w9OBl8hlecAPC0zqLw3yskyaHq4kMxs2XZ7WZIFk8TznJ5O/jvsDIBUOxEX2U7t1OWF7nQ+GbQa0YvhacT5xlyU1LruUx3jq5AjLpc1FnjrcFqQzwiAk/WDnm0viB1Fpn1PwzpEgSVnJvPTtcDEvBpnXeT+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by PH7PR12MB9151.namprd12.prod.outlook.com (2603:10b6:510:2e9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 18:10:50 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 18:10:50 +0000
Date: Wed, 5 Nov 2025 14:10:49 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Shameer Kolothum <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>,
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
 Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Message-ID: <20251105181049.GU1537560@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-16-skolothumtho@nvidia.com>
 <318947de-4467-4ced-a5d2-929e3df210ef@redhat.com>
 <CH3PR12MB754815B9B902E7EF66B0A1B9ABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <85f315a2-e49a-4330-9419-48a8a3a4a3e3@redhat.com>
 <CH3PR12MB754844745DF256D7FF2CB07AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <e4fd6d1e-3fca-457b-ac6a-69e721d799f4@redhat.com>
 <CH3PR12MB75489F2161213432D34688D2ABC5A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <7ac24d9a-0caf-48cb-832c-812fecc5c82c@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ac24d9a-0caf-48cb-832c-812fecc5c82c@redhat.com>
X-ClientProxiedBy: BL1PR13CA0410.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::25) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|PH7PR12MB9151:EE_
X-MS-Office365-Filtering-Correlation-Id: e8d6f891-f937-444b-6120-08de1c96a6f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aAZRNE3syurgHDmwDdMLYWOvA56eCqb991ZiN5sRvGAdAZ+Sl9ZyoxvECB78?=
 =?us-ascii?Q?uoheuk/yd9OI+4Aeo6Qktf+8ab8GhNKblWru/F8xJt9C9QDsmXbs6gLyxNfK?=
 =?us-ascii?Q?z/Wa/1W9ruD3s9WOaCrDnv/S0+4q+hDzjkSwFqwWGaa756j1+ziHSBVkrjBO?=
 =?us-ascii?Q?SsBknDRYMAn7h8PHpTYA8cScXhTFaSRVWO0OePZ91MAc/bLzu1QDJ5pjCJC1?=
 =?us-ascii?Q?CHejtmibaryDrcPZio+AR/TFfG6Y+QreGu/KvaCzvI5rto7cJnjy3CQ2OMNY?=
 =?us-ascii?Q?ihS6BEeDaA+3xFw6zfds9tT5S4oBXVgJCLUHEjpGa57Oixoa9f7V2qXaANUf?=
 =?us-ascii?Q?tJHaNJ36cwvN82Pb08+yMSG/yPIme7PTVVID+2/wVWj4LBSEHOH8UQjS1wWO?=
 =?us-ascii?Q?+iVQ0CuNFmYN+OjfLTxLyDAKNzI1HXNhbzY2eA+HY1NxCrK3aCpi9T3ZF3RG?=
 =?us-ascii?Q?yQ2G6BGUEEH3wjjnrgkcOIokZShwHf6FlRPVUvrk8iv7pmcb9vRKzestsK3K?=
 =?us-ascii?Q?UPYM3X60ASf1+/noOxQ3/AvuFSOvOD7gHeDdCn8B6OwQEsg1ZO6dMReGJx7H?=
 =?us-ascii?Q?yibkypgKCZ28uIOk+GNiOWqR2+vO4BbXqBf1W8O7+30k+YfYdBYbHB+Yp+OX?=
 =?us-ascii?Q?LXdZjhEzEgR4qI0eviF1q+oEX+248eWaQi7rW94iMTyHTGsaMOAAgrJ5dI2J?=
 =?us-ascii?Q?v6NJnm93XPeVYFPCfYTBdqpcc7Ozomx4vormovc5SbDtZ08jr4JZXaLFB+KQ?=
 =?us-ascii?Q?8CIxCTOikuNKyr/scZDDmeduCeYTuXQwN/ihqycrPHH+FBW10H0s3s5BixMx?=
 =?us-ascii?Q?M9167VkfsPRQaPkD9zaTbYJM9X+2CiK4wjf/I5hX53QEVHqg2Bjl7zc5yY1L?=
 =?us-ascii?Q?yv0o4tCXAVoNEoIajy+YYj3uVaO1CbnVbTK0HZZcsSNRNNjjpMLOq2WWoKcP?=
 =?us-ascii?Q?EpB2jdQ3FmxV3/0kR9VKX/ZaFi0WhJMwl++Fcx4ROuHVZM8L6AxUhRzhOb49?=
 =?us-ascii?Q?ZG/c4Qk0PNl9IzLAvEDvyb8Yl79T/tYPz34XtITfMsbU+z2kS/1jFicXNDCG?=
 =?us-ascii?Q?u52URMdSAeS1cyPm8m5rwGd+pgPgnGuKk7ocFL41DZPN5OhgYONd0FZCYGVQ?=
 =?us-ascii?Q?cUW4IHpJDZRQYp5ATcyyGaYvoI2qzyjpQy1RTd6fB38v7osSe7HdlVlbuPMX?=
 =?us-ascii?Q?Kl2LZO1ZbW2arj7ejILgFr9mLqxSPyLjHHnoHhTe7s/cm4g641UZWfvxxM0f?=
 =?us-ascii?Q?UUL9w1XnNny49OMPydV+BkT7XSANo81rGILO7rxCaCXN2LEB4h4f2soefWI/?=
 =?us-ascii?Q?lhV6CMUVtuDvIM0HCuGP5dRh4rp3e72fUxy8hqy0eBxGPslwoPAi6+GQ8uVq?=
 =?us-ascii?Q?NL6YDLg6B1LYynjIQSouwFgQglVSGO8giUjRuXaYzAgDU9pIcG8viTPAHmue?=
 =?us-ascii?Q?dSqDbPgKbrfQRNwfMHbbmvGRNZBPn13e?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3613.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?voVALVmw/2VCexW9i7VhBkRQO7W19sQv2GOaohIpAmrYiVDtgDWiPUWxUz0K?=
 =?us-ascii?Q?vmVG0BRkg4g62nbYHCFxvNM64/jzUrKV5CUjG1DVW6Vo90dxSFjMfSOqu+kz?=
 =?us-ascii?Q?41p+reCXmvA9CGXzZqttlQFI3KiEWUv/TJUGGX/7rwI6yH2/5oCO4iOcndtz?=
 =?us-ascii?Q?b7kDBGqJ03Anqo+g3k/VTjYdZgHzH5noK0RLPKEA/vUm5+NCTRiWAXbHo3Pd?=
 =?us-ascii?Q?01Z9L41ZlRXAgsX/5RLZn+QwSdj59+qnU6inMLWyIGBD7RB7eMJ4/hRoHlMG?=
 =?us-ascii?Q?9V2NnO7OOGaYGeIKkDW4dRXjS/hwPWdIkeldSyAeUBvSzDcDf9XZEqbA3mhy?=
 =?us-ascii?Q?2d8U6C/V2jdfPoXjG5U+yPUbuc4jOx9v6qTRCkWJTXWdy4rbki+VJ1F0VSuI?=
 =?us-ascii?Q?FK60Jt/vj7BUvV68ziSIF+hqHDKMLmDHQMEd3FstVUHFu0gWJXQgrljPdBBj?=
 =?us-ascii?Q?I3NgLa+CNrP2BnKiPxq5MNe3wRePLCAVFAIBUAoV7s05kN4bGXhbjDSv5+xd?=
 =?us-ascii?Q?BZf4ZWWGwHdekY2WwVwjtJ3BubzlkXHK0SmQ/pMTFYZGPk8L2xax5iUxJ812?=
 =?us-ascii?Q?ItZkwI5PHdB38lfTmrZHu36Ktv1lluHHn52MmMTmGEP1g3WkGBA8jQUe928e?=
 =?us-ascii?Q?Q1t5mjiu3zaT89BXWjZiIkabKXQMwZVRU45G0T99i52HPpSxYz09TsEPsDsj?=
 =?us-ascii?Q?iRLp6qqx6yJjs72RZ6Cs+fQVlvVeBLA1hqzC//xXnpYLZToQy8sm/XG2AgdS?=
 =?us-ascii?Q?lb+OFoZHi6Gni4CQa6X+xmZhRdBpDEHj0harI1mWB0tOgwQQCRp5MffUFa1r?=
 =?us-ascii?Q?+5coU/EXMD00ra7UTdmzgRFEDU5j05QWmmF3ojxEqBc8vvmLldkd3Il0xBLZ?=
 =?us-ascii?Q?CPekn326KZ+90+8NlwScBL29O/AF2/0Ic8HqQkcfMnVVjlBzIbgvByZ62N+X?=
 =?us-ascii?Q?Vm7kz4v/yPP5tq2zPZjPUTOBux8UOOPGWemrkXvRm1jlqAHWvNn11RbwjREn?=
 =?us-ascii?Q?R19aSk0WjGCLcDGIrLOtyKc78PE8ptJukJfdDFaOQMxu+IzivOdBwwUEqDUj?=
 =?us-ascii?Q?6mg4gOQwkmta+yHEvZkL50qbyZs2Ya9S3c7YU51kOy+xdS7DUuS/MURy48nW?=
 =?us-ascii?Q?t4ggX+ydzFtvkk3WZ8UuKeO3pzCuCnF+kSrHW6UE+9kgU6qGkerd4tMnqBZ/?=
 =?us-ascii?Q?+1F+cJkJESww/Q9449fmE9tkrWTmBaDBO+xGjrMNYfmLbR3HoSAIQImbvjm9?=
 =?us-ascii?Q?GKkN2yHJu0FSMk/jBSYxa9o/8a3YV7SoDGZESPXQuiJOZJJKtwsbxmGxGR2u?=
 =?us-ascii?Q?qjhvQMJYpIV/8WRtgPRKkbRhAiyYySY/aPQTy6oRTbwiuI81b+E8DYyVDxdg?=
 =?us-ascii?Q?3DEuz9HN4dnTZHOSr1GzBlgu+t/R5RPU08qoLbpmJyJyqFKmAB3yUxbmlZOU?=
 =?us-ascii?Q?fFb9QsXyOy2nPwjT116tHTNUUSql8trPY3oECMRWJz6lLW2FhzxOllTXdRQh?=
 =?us-ascii?Q?RzrBRq1ojB491A2C3R3iVUCPHWH/Em90kERDhqHnxig8TQqOvZEod6K9NxEx?=
 =?us-ascii?Q?RNQaMJvDj93+e7YF1kk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d6f891-f937-444b-6120-08de1c96a6f1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 18:10:50.5928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPnl38U2CANN2HYnisshU4C2q0pgLVAYkWQmW6v1ADZOj5Nd8p3AVhingSJsc/Hx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9151
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=jgg@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On Wed, Nov 05, 2025 at 06:25:05PM +0100, Eric Auger wrote:
> if the guest doorbell address is wrong because not properly translated,
> vgic_msi_to_its() will fail to identify the ITS to inject the MSI in.
> See kernel kvm/vgic/vgic-its.c vgic_msi_to_its and
> vgic_its_inject_msi

Which has been exactly my point to Nicolin. There is no way to
"properly translate" the vMSI address in a HW accelerated SMMU
emulation.

The vMSI address must only be used for some future non-RMR HW only
path.

To keep this flow working qemu must ignore the IOVA from the guest and
always replace it with its own idea of what the correct ITS address is
for KVM to work. It means we don't correctly emulate guest
misconfiguration of the MSI address.

Thus it should never be "translated" in this configuration, that's a
broken idea when working with the HW accelerated vSMMU.

Jason

