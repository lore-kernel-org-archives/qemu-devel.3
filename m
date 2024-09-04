Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF240CD4853
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 16:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slt1H-0003Or-Cl; Wed, 04 Sep 2024 12:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1slt1B-0003NW-Tm
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 12:38:06 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ira.weiny@intel.com>)
 id 1slt19-0002LD-Oi
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 12:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1725467884; x=1757003884;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ki9YH1MEEosga2iaO/5Kic8EgS1rLYhWmrfBq+1cQkI=;
 b=cuNRqD9HHLpvolkWFxR04t99NCb9clnxsBU3khmxEHOw2RFARrgVSGgA
 zRHMa+7scVWQt+f46dDQOfNk00C5s4AWtsW6o3obCTufpaWruOHI2TSFJ
 KM7DWP4YHxkcZ0DrNBTsBET9u3/OSUvbuTAhXcT5PVoGKckwbEbnu/U4j
 AQJfliZ8Lkwxz7XZp0xCBkcsDPqJbuAcixR49y7LH7RzuGgE+uJ7lUALd
 qui+Res1brO2CXPr4Cz0YXjf9aL6aBIMmAQ2TeCFjt8FrVON2K/QBj7Dc
 invZ/wMNDA5p3Ro4ely4MO9VZdbCPS0PUSExpSUW3jVR6oXHwB7w96WW6 Q==;
X-CSE-ConnectionGUID: Rxe2m+hiT1aQ/wReKm4kvQ==
X-CSE-MsgGUID: 5N02DHeVRZuAO30XaExnMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="35303187"
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; d="scan'208";a="35303187"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2024 09:37:42 -0700
X-CSE-ConnectionGUID: C5hhBkH6T5GyC3DN89HqzQ==
X-CSE-MsgGUID: NQcr4bXLR0e7eUnwExRxyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; d="scan'208";a="65166626"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Sep 2024 09:37:42 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 09:37:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Sep 2024 09:37:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 09:37:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROWZ49/+oXTvXGm1vVgGAennOAADVT4Dhej4OIt5BGUc+p62/vP/4HBn4x4DyXIGEC1iuKhq9etLHR/4c22XPL4APr8TaEjowPH29ZervU0j2XdPmHqxpJp87rF8fHbAF+fuM/4p4oAmVqOdmC4OqsUuV3nZ7hHARED28aLkuXMFF8hVCk9Xp21CPSHb+YiLVG6e/lmJG9dC6TfkU0TqeIas4IiMlI48rrLjmYx6Q0Xg6Fa5oaEecfGRZ/n32Lzozeie3LmkFdB8ZaxWaGkCgxRVtDVl+Wtar9t4jqysOfKUE9TXvEfphHHZmTjndAyP/smwv+fDGTbCoSnn94EPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60HvzjJnJ4lMM88CqoRlioFPfF8A7ghgFFL1u9rfNVo=;
 b=zNW1/VLh5xWwqvL4X2OahfoTIKNXduyDmoYANAVzp8cwPvdhYSdgHvzT3ptds9KMB5X4V1E6arelY0uSTM4HI/8LGJG0amO2JoEZs2k26AtsTBdL/Ao1/Z1w+VWAN/Nww1otDQllmyJP9F5CY94El2BKRtuTn5OIMa72itf7hRGhUkDBCAsK3RoR5Sw8opoqG3JqSWFM0bn96nf/goBH8Nrt365KhNfSIHJykN7lxtc9HN/IlVdB0FFX6fPPHOIrYMojKpxmQqIf8fCEsLYIr00rnlmI09K+TmJylVaBB1lKhqKFdlF1xt4bHhzVQM9uODEa3xydGzKuhRYpnZcgww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH3PR11MB7297.namprd11.prod.outlook.com (2603:10b6:610:140::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 16:37:38 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 16:37:38 +0000
Date: Wed, 4 Sep 2024 11:37:33 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <ira.weiny@intel.com>, <dan.j.williams@intel.com>,
 <a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>, 
 Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH 2/2] hw/cxl/cxl_event: Fix interrupt triggering for
 dynamic capacity events grouped via More flag
Message-ID: <66d88ccd15efb_1e915829439@iweiny-mobl.notmuch>
References: <20240827164304.88876-1-nifan.cxl@gmail.com>
 <20240827164304.88876-3-nifan.cxl@gmail.com>
 <20240828123919.00005b5f@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240828123919.00005b5f@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0116.namprd03.prod.outlook.com
 (2603:10b6:303:b7::31) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH3PR11MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 868225f8-e2c8-40bb-b5bf-08dcccffe353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?92tbwlbmlZwVc1MiVkojiZs7ZDmeNLBpT0h/RQHQlbZZM0vgooHKTLB6Y1B/?=
 =?us-ascii?Q?NyzUkzmSVHMXnGL4RvUqsm5WDuyV11uAv5RqQyEBpNNhKkVX/mJbtNUW0AiO?=
 =?us-ascii?Q?Pdq9xq+iGBE8o7Wyv418L3Dy5bQo4Weu1Gyh9aqOmFGu5ML5k1iDv1tO5U+7?=
 =?us-ascii?Q?TRmjarkUTCPr1juopog6j+jTA/sHywEt8TeXZKzSJ5UV2PyvK6w26xhGKnLK?=
 =?us-ascii?Q?lZjNgwo8SwcBjr/UGIogK+YdbMxmkIgFbM7Mgms0fzYgVxgdtd9lRS6Hky3+?=
 =?us-ascii?Q?yipZlq9GuheCpQmp8Mf4QRi5F8t1lebW3lZu2PUPl72Ml3m8OBNb8HHzQ2lw?=
 =?us-ascii?Q?4PGmji173TCoBXkB2KdZk6Zj1ItwbNBcMcohYJtaRgkVrnDC5RGJYQpykG/3?=
 =?us-ascii?Q?mgeHB1xjPtQOyB6CB7X2/X1hBCIp/gMjQNhabrg4YX5Yz06bBIl8UogAPJPn?=
 =?us-ascii?Q?/8bjoLnSV2H7HUDTVeBIgnZkr5z1NcGP9LJtfW6IbgEx74sx1QOEfLDColgm?=
 =?us-ascii?Q?I5S/jPMJiEHjpHdKmiWC727GJWnNP884zp7CbDdletcTXF6nD2Sw8b2wXhzd?=
 =?us-ascii?Q?5yuP0klq+BLTRgHdgZZHxZsTwjZ0LPDVC+Z7mWaumVKgDM95Toxu338nfO5w?=
 =?us-ascii?Q?fAEN9nfZj63N2pp8IQzuCjy19034GWiXEfHaHyWgEIcONGA/QHfs5WZZvxm1?=
 =?us-ascii?Q?aQEJxhTsEh8UnzEFrst8itwe7AyCNBj18ZxJEwgtoJwNE/XUnEHcyjKHxetf?=
 =?us-ascii?Q?hrVdTNYcBXUVrLZH1rnUPAgVsyd81+3BSDFcdy5/08B6Aqn5EUp5mW0utQDV?=
 =?us-ascii?Q?CCQ0Xp5aphY+swczkzkO8DfXOG8O558tO/I/KZ+/c5JdB68VX00AXlAiOQRA?=
 =?us-ascii?Q?u1jLsyrlGqei0/WUtFhiaZqPGVLUayxiPuu/+BE1UtGlNyGOuuFap9HCtvj+?=
 =?us-ascii?Q?qIQc4CSc2LkcJwM0X3mWRHg2ROb0YhSqDQeBkpT51rdMv1qEU6AJwTPHFCNF?=
 =?us-ascii?Q?K7IQXj4VGhenBLNfn/yF5CcV/UlgQffeXZKCXvURw6THfy2ngRzgYx6Ls2FV?=
 =?us-ascii?Q?0xyzuEHNqBxqbtJjvrinyDiKJon5U9xK4KAGSO/PLiaUFS9ovbK3f4W2kSYU?=
 =?us-ascii?Q?nIA78CJcvuczVbjv9Gc0tjLcpwDB500T84G3uY3vQZSX4p6tIpAn4iZDxJKi?=
 =?us-ascii?Q?YXa/Irc6MPpV7g9Jg7+ebwCBaum07UNeCykjVEe2USOXqFhbSD+Dqy4+7dXX?=
 =?us-ascii?Q?aLV7ZkC+PVqvvA7/IBSsI+VuNMrstnxehv/I6gT1kSBuQORmPgfIxDm07s/E?=
 =?us-ascii?Q?NagkPfaoLV0p4KeQ2kjauRPSLCX5zC6qxC/0Z7BK03LU2w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB6733.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UHdM7A+bdfIrLevQihwEBrCrPTvzlGTGMy92TG2A/lUHPHJVFoC9+VcKSW/P?=
 =?us-ascii?Q?Pl8y38cvRK5M7Jms8wyuXrC6xjq5wELGxG2n0+/5Q4ovS8OcBW0mCiXomj3R?=
 =?us-ascii?Q?gb+WjtXhvHXHLuy496c3EvwzKnFHH6ecvm33E466kTqZkoHVbjTZYV/+UJYG?=
 =?us-ascii?Q?Ma6DV8Mg9gyYj5H/2+IPp5RmgxYi6NpB+1Zdt80ppwpUu/wILd7t4PQTHFUX?=
 =?us-ascii?Q?+5LGpThFgwOY9IphSb0TAsdgwtbBkHRWKpVXGk/iZ7M3pJMf9g46i8bl+wCL?=
 =?us-ascii?Q?MmVK+f0YtxltWRWuQ47t9z09FVwWDCOw+WPX5I/wDxr+V+SQaD2KVzCdRYZb?=
 =?us-ascii?Q?++cHzS6KTAk86CnkRJQGtxJIVhdv8WbRo3woBc+CPs4TXoHly4A0UjFtt+gz?=
 =?us-ascii?Q?2y3Y1XkgcQ/KBN/Kec1zfSpO6m2XTS0/SekSrqgz1ZZXAVG1h/C/6aCe1JWj?=
 =?us-ascii?Q?aX5dPEf+PVBBnaoG1iKX3u5uNepDNFR7pLrT88oIrtD+lnFmIt79ois7BLRX?=
 =?us-ascii?Q?jRkxqWY/hMHNHJR9IMWqghZOanrDnXBgp/yKD4hWetafcFAMG5FqEsiof2Bi?=
 =?us-ascii?Q?F+QvQmGKGaKDSFMRuHNpmXUQKTqobOqc6Dli6laD0INHhJspz21kKYC60w+8?=
 =?us-ascii?Q?V4xqPGPMayRMUM1UXq0GZV7nuugJhMNq3pqSjSaK0FmTIo196ddllX+4cmyH?=
 =?us-ascii?Q?+AGEir6VBmR2D0oW0wstvLG09e20bDORDFw+nSvSXV2icrOKpt2GTLZQjbv8?=
 =?us-ascii?Q?zs5enOL9auqBw+weeuHqRpsXuACXIqi9F45RzdUmo+iXEIxI1CZR40TAIhyx?=
 =?us-ascii?Q?Lp4OkegTtu5xX25nopmCXIe6z/i+ZbRLk4sOLdn4s1/JDBj0Zy+4MFbPHi8m?=
 =?us-ascii?Q?U1my4h2YW45gC9MTCKuK2Z5vC5RJq3RuY1SkIBxRN9rms/aAhgsbIUuNK8uD?=
 =?us-ascii?Q?zK5Yp3KCYG4SAMdWxJ4QO9LbgXFlS5movtn0I/Pl5cCQmUbpBHOOhpPRZEw4?=
 =?us-ascii?Q?Kl3KTIJ1yaxVQEP0/20Nl6EMoKIYZQCd553t5rLu7J66Qc5Fv+eHH2hCckrJ?=
 =?us-ascii?Q?UnDkOzwBe41RHEhaNaUtEeAFJil80IgW3ZExWmhEe/+K3yAPJJGrlghBpDbs?=
 =?us-ascii?Q?5w8NAnQO8ImCG+2z0o93d4Jsa+yRQ1venkwfW0WsrAGEt3LL679pawpXgJfM?=
 =?us-ascii?Q?i3pTMUt3g7LspJGhUSqF9SYP4Uqf4NuMRPZuVLzkdZpBpxiRaspLm/jPCKzO?=
 =?us-ascii?Q?k5EpJ2h+q5FwaM4RZkQ5jNp+013HO2+F8msEPND3zmGbIvSZg7gIpFAA49SX?=
 =?us-ascii?Q?6l1Xgg57eZ+6hA1veANTJAuedZH8T2+1wM7qgEXCEdXWKaZFb0yLS3nT/erb?=
 =?us-ascii?Q?r/JiodnCVnSxFHaLnG0VyzeyoWDZ/sE52095Z9/Fy5zs9WOU36Q+J4nsQsLK?=
 =?us-ascii?Q?edqKUZMIDNyEq5hvKuqPUwfTiMA/9ePVtctZDlgrL1Q2fipLWW/j8Bt09dCx?=
 =?us-ascii?Q?NydKDhgn80HHVodtRXfJRYV0UbeBtHukQsb+klShl60PRSOJ5Hh74tDnG+n5?=
 =?us-ascii?Q?w+51ZhD+kF/MO7u6CiGV+J7g4tVRfv6vyBnEc7DL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 868225f8-e2c8-40bb-b5bf-08dcccffe353
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 16:37:38.7182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eez2/ms5LO36V5Kcqt/qT+IKOZWMhPCv6JyEpR8yj0Ni2kc9WOaGcxb5cpSvqLq4GVxoyF79d0JGO+Vt/APNQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7297
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13; envelope-from=ira.weiny@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

Jonathan Cameron wrote:
> On Tue, 27 Aug 2024 09:40:05 -0700
> nifan.cxl@gmail.com wrote:
> 
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > When inserting multiple dynamic capacity event records grouped via More flag,
> > we should only trigger interrupt after the last record is inserted into the
> > event log. Achieving the goal by letting cxl_event_insert return true only
> > for the insertion of the last dynamic capacity event record in the sequence.
> 
> I'm not sure this one is accurate.  We might well have a slow
> system provisioning capacity one extent at time (and interrupting).
> 
> The event buffer might also not be large enough to hold all records so
> the device might 'wait' before figuring out the next extent for there
> to be somewhere to put the record.
> 
> Overall I think we can interrupt on each one and it should 'work'
> as should interrupt only once there are lots of them or
> every (n).

Indeed I think it should work.  But you won't see any extents as they will
be pending in the memdev.

Did this fail in some way?  I'm sorry I did not try and use qemu to test
the more bit.  Rather I used cxl_test for that.

Ira

> 
> Interrupt only fires on a 0 to >= 1 transition anyway, not
> on repeats after that unless the log has been cleared.
> It's up to OS to keep clearing records until it at least
> momentarily hits 0 if it wants to get any more interrupts.
> 
> Jonathan
> 
> 
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >  hw/cxl/cxl-events.c         | 8 ++++++++
> >  include/hw/cxl/cxl_events.h | 1 +
> >  2 files changed, 9 insertions(+)
> > 
> > diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
> > index 12dee2e467..90536c0e68 100644
> > --- a/hw/cxl/cxl-events.c
> > +++ b/hw/cxl/cxl-events.c
> > @@ -135,6 +135,14 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
> >      QSIMPLEQ_INSERT_TAIL(&log->events, entry, node);
> >      cxl_event_set_status(cxlds, log_type, true);
> >  
> > +    /*
> > +     * For dynamic capacity event records grouped via More flag,
> > +     * Only raise interrupt after inserting the last record in the log.
> > +     */
> > +    if (log_type == CXL_EVENT_TYPE_DYNAMIC_CAP) {
> > +        CXLEventDynamicCapacity *dCap = (CXLEventDynamicCapacity *)event;
> > +        return (dCap->flags & MORE_FLAG) ? false : true;
> > +    }
> >      /* Count went from 0 to 1 */
> >      return cxl_event_count(log) == 1;
> 
> If there are multiple this will fail I think as cxl_event_count(log) will go from 0
> to X not 1.
> 
> >  }
> > diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> > index 38cadaa0f3..b0e5cc89c0 100644
> > --- a/include/hw/cxl/cxl_events.h
> > +++ b/include/hw/cxl/cxl_events.h
> > @@ -170,6 +170,7 @@ typedef struct CXLEventMemoryModule {
> >   * CXL r3.1 section Table 8-50: Dynamic Capacity Event Record
> >   * All fields little endian.
> >   */
> > +#define MORE_FLAG BIT_MASK(0)
> >  typedef struct CXLEventDynamicCapacity {
> >      CXLEventRecordHdr hdr;
> >      uint8_t type;
> 



