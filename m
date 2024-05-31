Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6F7C25B7E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 16:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD52R-0002Pj-AL; Fri, 31 May 2024 12:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1sD52P-0002GK-Bk
 for qemu-devel@nongnu.org; Fri, 31 May 2024 12:23:29 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1sD52N-0001rF-Q7
 for qemu-devel@nongnu.org; Fri, 31 May 2024 12:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717172608; x=1748708608;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=zR1ETv1Mr5XLxmjPz1rFowp38H/dOFk0ypq3MVyLpRk=;
 b=EBTmBv2SJPKgWu5DnKMi4eH4jQGBrCgVGkEUIjCM1mrV9D4hmmJ9ObIs
 gVBuIUNRsVxWp2PB8ZVKDlVE3SwQ8QGN5YDOQoVLiokQCeefKRc4uezdx
 EXfYo7D4ta94iCP9smrWmJLkvFIhmEfVsHJ8Ge79iJrW4xPU9uHLyeS62
 W1aQFt7MiwAlzQOpT9CLE5np/8RZeIGglqDRQ2B8fg2AmtOlYdTmzqmRQ
 TLHj98iBOHmo1rS6KPH7uVUmI1JY0zCkSSPsIOAKN58wwiukulu924YLF
 /8uKiTe/0+flEgadrJVDRbeUD9eBE8HllQmzOGwZheSM4v3paegr6oUm3 A==;
X-CSE-ConnectionGUID: seimdX2hRJCZql8Nj3N0Qg==
X-CSE-MsgGUID: CTKvtgOVQJK3l6TDW3saqQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13591525"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; d="scan'208";a="13591525"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2024 09:23:25 -0700
X-CSE-ConnectionGUID: c3//6Jc5QyK88ZqbSG6AYw==
X-CSE-MsgGUID: IYrHF10fRNGl1EhRIhTHUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; d="scan'208";a="40655462"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 31 May 2024 09:23:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 May 2024 09:23:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 31 May 2024 09:23:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 31 May 2024 09:23:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1/wlKUg4bXFZnly9mliu3Vifw0WOxYVZzv43EK3h4+GNOZM+7KeLlPOKvdUKBggW13EP+NX5UVRqIs64fUd81IQFiSd71n4M0J52fmDJeUESCU4tKWtYYKa2Knuzx3FPOISdPvl84B+zGVWcuCaRuw+lpdDZyeDzdiINtsZ/1hgApT+IjzIPPTTj7hkImVG+rAM/QLnzxBqimj1GOdIrfLwWWMeYL9PZ2a5s4aMFMyj/pbPYu9OKrQMhVYqlr6I/XhScwK88zR9oYaA4e5BUk3pLBvA4Z3Wmmt/3rOuB8zSdnmF/55bP+Omj2hYgCjhqdpXykXKVEuao/YCVt+upA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yuv3ID9gpl0PSzLOXawFUrlLaTkT3r0NUXK9zoRWqAg=;
 b=NQSftr9/EP3nl2nr65Cg5+PC07f4V3UAHKNeXRKxbaGFkh1dtNOak8t10ZyZDmzrJmjrRSLaf6TtIHNQOecEeldGWxtnUTjrGCeNWk2sYdxFH8YAVBN7s3zh28CdBQCWR1iVQFuW7W4Kk49VVyM8qBf28c90w5ZESvwXZfX3Yitra2q//B0hpWg0gzvUoAsqLt9ju75ndD8o88dhjDAOwUHIG7e06tN/xJGxJgixtC8IwuUzkff47jekuGhS7wySKXJdYLDkDUW/kjlikkjf22kPUAHw4FS5nMXU7QyxKcVvyQuEtehT2BUaOV+P4B1Cip2Hxm2pgjiWpMMvoK1bLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB8012.namprd11.prod.outlook.com (2603:10b6:510:24b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Fri, 31 May
 2024 16:23:16 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 16:23:16 +0000
Date: Fri, 31 May 2024 11:23:12 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PULL 04/53] hw/cxl: Add clear poison mailbox command support.
Message-ID: <6659f9702909_b60402942c@iweiny-mobl.notmuch>
References: <cover.1687782442.git.mst@redhat.com>
 <6bda41a69bdcee8ff7dcf75df2f9647ce55908ab.1687782442.git.mst@redhat.com>
 <CAFEAcA-EbD2GLMuS-t_qeDFYM5z3NT-_zCKRNZ8TqjWRiRD+Ww@mail.gmail.com>
 <CAFEAcA-u4sytGwTKsb__Y+_+0O2-WwARntm3x8WNhvL1WfHOBg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-u4sytGwTKsb__Y+_+0O2-WwARntm3x8WNhvL1WfHOBg@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::14) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: 308fa8ae-90c7-4344-743e-08dc818df9bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Yty8UC4R8RpAh3h+HN69CEJXd7Hg4ZPkZTOo1oX+4dX1t45EUJ3vi+3kVqKB?=
 =?us-ascii?Q?gjMKIpI44KDRu04zM6KARkdXifdTdfnwp8Q2H2neplSVQClOKnqMrZ1EyB3Y?=
 =?us-ascii?Q?csmOFczRqYRyWo74KTahN9ER4amO9yU9D15SVcfE8OhVQwZ6H/BDQYRrx3nG?=
 =?us-ascii?Q?jEfECG9zLqShzLzGpA9z2Erx1YXeQ6os3ipN4IFBVGx6V4zfXrPvdAdcLnoS?=
 =?us-ascii?Q?4cGHDbla1nEDjJ/Nfa4v+/Pefp6TbO0Xe2uASZuLtDB7MJdp2pF1YUVEI2mt?=
 =?us-ascii?Q?ZlCDmcevXC5oSunQ2zfHc6QXP81afVtywhEQPsilzwaO0MCKJMVOn7rzi9VG?=
 =?us-ascii?Q?PFOUDld2UPzdaxIrSokh/2J0nnMbuCOmHphXO/gHXFhhL0ew6uh1t2Svt2Yo?=
 =?us-ascii?Q?VBYO/IAImo6pFlGlXdn0dE/Z+E76nn0EKWsf6czoXodAOP6Dx5B9+UtaSFdx?=
 =?us-ascii?Q?q9mXMzNchYFtIF42eqQFVjaxBIGMRueQpehBf68NrHiOMpSn32RyeQmGM6qv?=
 =?us-ascii?Q?HTbfsQ+w8XHovzTE0zoqedKUosn/479BRd7rnlqFF2BjgRkmkMMNM4aJmTZ5?=
 =?us-ascii?Q?+L+TMimSwHGordjrdZ9ue2DhgnEhOO93sPCNrCGQu3d9z4OmWCH/KeEqwaQa?=
 =?us-ascii?Q?zgMwE+2XZMsUh+/bpvk1ersm+QElqprR4xqr5dT5p3BtRem+2UV+VudbRprT?=
 =?us-ascii?Q?iAs1WmLvZAnuv8tystE4yrGL2RybW6tdrmZZJDORVmao3YlbwXJecMXB1Uub?=
 =?us-ascii?Q?7hV7G7i0cLtIreQ4F7xb3a1AaFfPTC/NwcLgtbuz9QG50/CkySvOoi+zLRnM?=
 =?us-ascii?Q?21BM+ZMFinjjV6NAoq6r2R7iCJDLoCXeKfhKljBs7vf/CIcTxASWTWGm4DJH?=
 =?us-ascii?Q?k4J6M01zxib8RMtyYQolcg2G9B7DlcWSUXFT1zt7F5SKeLqdHSn8dRa1wjRy?=
 =?us-ascii?Q?jQp29qKvO2chAUnhRkEBQ3/GNwUWOZ00Mb1EjbC8bYndsFOuPB8SHBSNUVdz?=
 =?us-ascii?Q?r72xHeT2SEoFdbwE3XjXDrQupgLz5lyhSn3BbQD6QslkQ9gaTvxmgm+OOEcy?=
 =?us-ascii?Q?e+NFNjqYs/PDMHV3UK4VZ3gu2Fkl+4n3ytjj2rsf3BF3MsUS73Cu8/Nd+1Is?=
 =?us-ascii?Q?ezESuIlR7NPuEsRMRqvWIgDWJLNko5PinZby69NNMYqvs0o8x5/S2PA74R16?=
 =?us-ascii?Q?/GJrti1qVZmSnlLfQh5ReXQUIwr8yhLiS7FBAc4mtotbNpVO3hxcAOrAi/zJ?=
 =?us-ascii?Q?4pOag7VpQ6XzkmVA5tSp0nfMW9DatynK3vpUKe1FRg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB6733.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CnNjLdlW8OgehdLjjlFhYl/vfm4RdUJim+rpXD3Gsnx4Jw+6CGItKXp468/K?=
 =?us-ascii?Q?75ojkIpVE79iratR2Qxgm0iJxx+dbMVSsmKQRV1yY/B18DHbJHHcX32Q+5FF?=
 =?us-ascii?Q?zLwj4TGV+8lEz1tp0CXH6K7lWBeW3M+WOseCjgyN7VHsDkpdrfynY8HH+ZLm?=
 =?us-ascii?Q?LkxE6F4GKn0EU61M1AhoxVycGKNCvp5w21qXP31xCVdRNvWYqmW+WOx3hRBx?=
 =?us-ascii?Q?11yqhDXCaHuaFKI+sI4lQr2+e1g4y++s+nNE5jzlhTf8U6aQZ1JOgrK9RCSW?=
 =?us-ascii?Q?jW667/UhdFKgvRyaP6pUVhrAF2HnBgpa1nz32w4FXWwyj0ws4EOYZCAjB+R4?=
 =?us-ascii?Q?rTvQS9FwUbqaWNUcljulz5eqsZl7U3Vd6yjrBRv9htKTOWxVGXbHoVobVoQ/?=
 =?us-ascii?Q?KSjcpiy27C/WglwoyHv9H3PvhsDtqyLP5TioWai108FMQJoXfbV93du0hMLt?=
 =?us-ascii?Q?46Ylp6nS3btlrUDs46anGELU2epdBrgJ+NPPi10A0/jTYTNpilCnealqoeGe?=
 =?us-ascii?Q?ykbV6zfSr/NIwf5mlslE592t7+u2i+2jchrDQXv0gM09gtf8tqWv0Nk5w+p3?=
 =?us-ascii?Q?LAyNFSAaNsV75Xeq9thvmG1sMnIy00NV1r8q8pPGpFVl4LJxWz0GqFBi8blt?=
 =?us-ascii?Q?PU5c/3VISEnwA38h520r7TsgP6/eXkl1/alhZbqvZgnlv87khP2ygBCuutsE?=
 =?us-ascii?Q?vGLrUsYk4cQY3oqW7YQSMbhGLYtCsJJ6eYvnEkjo0Tg98WMOUKFVoo9nxyZC?=
 =?us-ascii?Q?8RS0Tqjjry52eS1OcWBtCxfyYB0EgWuOcAl5KcABAt9P8iH8oXpWSmX/VmMt?=
 =?us-ascii?Q?Ffet00BP8f/jUDsLEutPZq9WyzD6K7G3hf79r+XWd0oNGa8CunG32psDxZRQ?=
 =?us-ascii?Q?CoShPSZ37+FwPQilGJyay1XIcCJem/1pXEd6aGtjAeEHWKDtMzGVXJyJ45Qb?=
 =?us-ascii?Q?PsvQWJbCxy2mIFOINsW0SgineQUHvaq/H43CXgKCzWwkUCNyOoz1lw0kwd91?=
 =?us-ascii?Q?ISzhgppEIT63khlD8kRAVDTjOBYNO3zOALowIipmlyDeGG2L49H9f5wJST74?=
 =?us-ascii?Q?jo2YHJJQzHXc6QbHKiXA/0oN3O0NQm8b1RozGYijJ92joMh998ys5efRC9nd?=
 =?us-ascii?Q?FBqByvK/IxX0PanH3yG7KaHD4idtJKEccKPIOHzEOxm7Tisadt1OnaWQj2h5?=
 =?us-ascii?Q?3Cjz29LpTtAn/ybPP9n9/auBXflEAW/puVWW0bl31VdB1moaev/Phk0L80E2?=
 =?us-ascii?Q?9sv2OOfyPzQ9sSLtEl36m0ygsI7M3gvYGnkkWxZIiRX0rGTnNXU9GaKjyFML?=
 =?us-ascii?Q?u+DUvGx/tc4c1rme5JZPJeSoOF1NsLUTNTpvTNqmsakDuOUsp0pLB+k5r8y1?=
 =?us-ascii?Q?usY0ohSAGhW3K5e4wwCDSp+mhWs9p8rVYARCrNzCHKRkS1QL3DWT51kE7mXJ?=
 =?us-ascii?Q?x+Cbwis3cTmsR+b7XS7pieSOD4zxFSnc1gG8YOZRzPqphhAYaE0VABy102dC?=
 =?us-ascii?Q?qlFxLjjqQUQk3hoiU946KhTfSjA9DrFngYGLaX6pfE4n9HAyVgaWl8jYnzRt?=
 =?us-ascii?Q?GIQmSo7lVdG9LV75Nr+U+byOtlFYka9FC5AEHYoO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 308fa8ae-90c7-4344-743e-08dc818df9bd
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:23:16.1987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LpVp5uA3/t2iXw86ZmmUdouWCyLvX9P5joB/y7ui3FinFw3wzFkDtUKDCPY9M3SPx7rZi8aUUBsJN9wwA28zjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8012
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17; envelope-from=ira.weiny@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Peter Maydell wrote:
> Ping! This looks like it should be an easy one-liner fix
> for a Coverity-detected read-from-bogus-memory bug --
> could one of the CXL folks have a look at it and send
> a patch, please ?

Done.  Jonathan could you double check I only compile tested.

I think you are correct and apologies for not seeing your report earlier.

Ira

