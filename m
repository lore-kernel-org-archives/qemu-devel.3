Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC68CD5BAC
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 08:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQLiN-0006Lf-4L; Fri, 22 May 2026 04:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wQLiK-0006LI-OP
 for qemu-devel@nongnu.org; Fri, 22 May 2026 04:58:40 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wQLiI-0000ZJ-ID
 for qemu-devel@nongnu.org; Fri, 22 May 2026 04:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779440319; x=1810976319;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OTb4ZV4QI6X6bfhsdPhUAMJwihUfr+CGKNqvldHOeK0=;
 b=bKCADBgswOBKUCOoAWMXTFrtJ7MxjiPxqkgU6ArmuoU0hDGWn8PpQgiO
 UKkdA9p6dZXlQKYBmvKZ0Wx+Tldf8pY79umPISKHLjkJLceubmz2DD4ID
 9LGt5ns7oNMgXREnnZYLAE2mKlsNrzBfWBLXzL0HsGajOXHMIPuhJC7jf
 pw+Qm49MRzQ4LwnsoLz0jBCXM9pxK3Ec64ad45J7WDd6/T2LVh6CJe5ja
 qoXcwdDiG0G9LrsxKsU5usf6eEYyfw7iYYM4RBoJbh9plGOQeDYuBO+om
 Tfh+QjbLczCltUBgaY6C/TglKry0PAwGxlzAc7XxDi6vAF+WSZwIpdozP g==;
X-CSE-ConnectionGUID: yvQeSNJbS/yZnhORRFT1hQ==
X-CSE-MsgGUID: usZ28Y7cTCGBYqHzkm/OFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="79518462"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="79518462"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 01:58:36 -0700
X-CSE-ConnectionGUID: p4QV87JPQlexrXBBGrjrzw==
X-CSE-MsgGUID: Shl2NmMlQ72PaOSRnhwh8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="237820054"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 01:58:36 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 01:58:35 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 01:58:35 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.27) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 01:58:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzvIdCvHf3k3SM9yWIwirZHEpRQ0m/yTQG/2eiVKCKccveuU4EvXDlclrWCbC6asGOmOaGtQrtWLqkpfEVG9sjJLYWyjCOP+7+KnHunBzXh9hrgHH0N62V3qFjtxef/RtZN8d2Qszv6wBUW5HbWNr/7IRPJ35hjnSTvhOtEBBNPxynWTuShlM1YcQAV8WCp3rXhixJVgSSsFUd3Sd2xVCrxyBSw3iQ4h/kS8IkD9pv0MwH3vSzd/ts2qD8175KckNOkBzLXdbAQap2z/1Fh4I8+JmF+68ZgKFFcBMXGGY1hZMk4zjthdPAgB5HvQD1EkHL3dkBW8JnV7ntOgxGFVYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeB+53DzvPychTvxOOG0g/gYffZ8N26BVipDOEb2FQk=;
 b=kl+o6c/Z7nYYFXg+EqcLG4U5nzMoKWtpCVBzjwVVg08zaZLMQlKTX9tW8POPiqeuo1Dpyzi5/Ljw5Uomp5yJrunx+ptEwJo//NP8GCJPLG1W7wzx5DMN0DF4e2tDoxhpOO7IMrj1fOPlfl/H6ZHJY0l1O2/slH3f4QWWtPm7hOiXijpeH/PpX2/BRv7KEB/jkqtnuYJ2SKKRI0LhJhvSx3E+qGVDdRZYxqo0B9RX582YDUwCqlahuc6ANLDO+W3/Q4U2RFbHUYw9lduYDwEPIUBWczXyGzxm6uavBE4bWBNWtE3qygNPNoHIa8dFhnwXsLUU2QC9MYrH/oSJ2jwNyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SA1PR11MB5948.namprd11.prod.outlook.com (2603:10b6:806:23c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 08:58:23 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 08:58:22 +0000
Message-ID: <6e9dfde5-f0af-42b2-8f8c-d4c9eab8bc35@intel.com>
Date: Fri, 22 May 2026 17:06:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/15] intel_iommu_accel: Handle PASID entry removal
 for pc_inv_dsc request
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
 <20260509040819.1044702-11-zhenzhong.duan@intel.com>
 <829fcf6f-39e4-4d21-9f08-2772c0813c32@intel.com>
 <IA3PR11MB91369A610C7F2DDEC9F2D5BD920F2@IA3PR11MB9136.namprd11.prod.outlook.com>
 <1d15367a-d28e-40cf-b051-6c047392a3c9@intel.com>
 <IA3PR11MB9136F4193E5334152DDD6048920F2@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB9136F4193E5334152DDD6048920F2@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0054.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::6)
 To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SA1PR11MB5948:EE_
X-MS-Office365-Filtering-Correlation-Id: c8908d1d-780b-47a5-61fe-08deb7e046d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|366016|376014|7416014|3613699012|56012099003|22082099003|18002099003|4143699003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: Es7Zj/A+OVLXGqqNdONySEeDPFVc6z1t06D2ouR93OK6W/KWIkeDd6Nawkyc2jr/TXSStGPS2alIMUdQK0bOOCj3zQTuts69mAWuBCxxTm5RYc7lWYLU/NPZm9wPwehzcYDQ2AOLlj25nMqJ2zHNpbxPTEbE82zFJktqvIQvfdll/u+vUuDKRfS2zmYp78gf4bByYXPvJu90X+Vl3P8OczPkjHxTp3wGosoLGpjPy7V0NAVKFhdvsrUi83wkZ21aHbHC9BbxGZDdZKaz/AabpfDyvxLZOuq/9ssELmqCK9JkJAkqyeDQyewDb3cl/gKEKXEr89XkZWnya2hBTJ5A8qMJ8pOuzIYR8K+FUBIh9SvXrnA/v5Wx1HJXDPVkR/2U1CHPoKJEA9QAcvYimfMrR8oZzq9A2b09/ZpdmOHbUFQ8sy8Q+A7d0tLvQyzhY8CJXGUOFa/MUQBRVjibi+5fvodGdfYSCR5lv5uLNoM0jky1YQlduj661xtOB2Dj06HtZMEoXZUkj/N0YqNmMWrAqxt3puHwYHzyAC0OM6M/e2yQE3tm9Fi2ozDbR6IGM75HYDfVSV6gq3w8LdVyG4arODaNe2a6V2f6bCjaakl3alx3g4L6G613H+5cmbu370vriKJOFUlibuubaEJvisTZ8xx1vJU2QTqyf6Yx0DCM+wErqW66/2iUirmgfiLigAdyzCfQYpG4+lPtAcsOU8aaCdhzfpGR0a+Ro07SNGPtL40Y5+biRxzNZ37qvCtPxW7G
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(366016)(376014)(7416014)(3613699012)(56012099003)(22082099003)(18002099003)(4143699003)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWRJRjFYMVBRQk4wa1NOZGRaU1RJa1pVTzFUVE41MTFEMjB0TkZ6bUVTeVBN?=
 =?utf-8?B?WXFDVXdWMTJqN3JvWE5oN1hLNzdTajRaMHBoMnNnY21UNVdkcEE5WU1kRi9O?=
 =?utf-8?B?bi8ra2N1OWhaWkFFUlBiUmxqSTdxNXkweUlyQkxUbC9zbHcweWtlWk1mcTJM?=
 =?utf-8?B?NjJJTm9YMWp0NFQraHZzbUJqclluSUZDK0s0eDBkbm5xdURBbkhTQ2pkVEpt?=
 =?utf-8?B?QWpBb1hYT3c2dDNLcHB4d1BsV3R5eVkyRHEzTEtvSnlXVzFwWjV1NEl6MUZz?=
 =?utf-8?B?RzhoUzFnaFU1T3NYVWxxU2JMb3lqL0lKc3UzSmQxQ0lmc1IzMEVvWHMyQzJC?=
 =?utf-8?B?ZHFITXltUXBmYkJxblZQbzM3REIremcxWHFxdTNIaWZiendzMm9JY094dzFX?=
 =?utf-8?B?YUJrVWlyK2g2ZkVaNmxmdFgzUlllRnUvenRpRVA2Y3NBUHBMSmoxMXMxYmw4?=
 =?utf-8?B?V0ZUYXV1V3krdE1BU0t1SEM4RHVsbGJpUlRJQzdxS3ZENWFIWENta2t1WEtu?=
 =?utf-8?B?bnoyQUFHRit6NDl5WU5veWs3bW5KMEpuS285MWtXd3F6T0F6RzNmSDBETHJo?=
 =?utf-8?B?WVh0cG5LTFlUaEFaaEtudVozS2VyT2hVWm84cUkwQW1RZStjd3VGWXI3OVJW?=
 =?utf-8?B?OHdQT0hHaVdUbG5CMmp3R3BDc29BNjJuaE1IQkZNRzE0S2IrSVhTcmw2SkR3?=
 =?utf-8?B?Zmg3RVZCQ2daSU9rbnp0VmNjTVpjZDBqY3dnUDRyalJDVjMxazMwelFaTGtm?=
 =?utf-8?B?ZGJrc0ZpOXozK0FUcXRrU29hY1hBU3JLVTBOZmhkUDVXdG12TGR4YktCbFFj?=
 =?utf-8?B?RXJRZ2pLbTk4MHJFVU5TVkpxYXVEejlJRmFiaFpTVlp1YmxRbkFqaFljVm4r?=
 =?utf-8?B?b0h0dTQxQkN3RUdDZUd0WHdRS1dPSlVyY0VobVdXM0crZGNpUUJLKytiWWty?=
 =?utf-8?B?Vjh6V2RSUXlRMktiZGZYaFZOWWZhUWxOSDkxNnlPVzh1WFh1aFV1dWd5b2lh?=
 =?utf-8?B?RENNVTFXSHhqS2xpZ2ZaRktOeVd0QVR3aTJwWmUzcm42RmQ0RGRvaWpkZ0N0?=
 =?utf-8?B?M3BHOTllZ0o3QUE0TnNCM2JIU0ZRWE01dDQ2QWxuM21Mcmp2eVZsalVQWkp1?=
 =?utf-8?B?MUd5YnEwQ0JFT2J2Sk8vMmphcWFacSt6Z1QzMHgyYUFtZ0VYeE1KcmtIWVNE?=
 =?utf-8?B?aXVPMXNXRFNDaGttem0rVzBFMWEvNndRRG5lcWNwdG16eS9FN2orQWErUmhU?=
 =?utf-8?B?S1h4VURmWVBGZHBTeXVQREpIZjJ2UWUybThTYWVtZ21wR3JBcWVMV2pjczFi?=
 =?utf-8?B?TzBFV2NwYWhVWnpZMlErMjZRUW9neTdRb1hTdzJWWGhpVnl4dzV0WHRESXRj?=
 =?utf-8?B?V3VpcE85U0lYZmRZNWY5SVZWbmtuRkpEWWxEQVoyWXA4bk1IZ2FsYWRyVVNi?=
 =?utf-8?B?WVgyMzl1WXZZYXZiY1BoMmVkcGFQekVQQUxxbnFjaEJQa0dndDA3STdPbDdV?=
 =?utf-8?B?WE1SdXRBdVBWZktUeDcyeS9ZYzNhYW1kNnZycy9oV3pvaGt5QzVXZ0NOS2hx?=
 =?utf-8?B?bnJYV3VNTHd2T1RySXl6Ni9Ncndwa1A3cHJONGF3V0x1QnZzV1pjcGRPVGJ6?=
 =?utf-8?B?UlFSVVEyR2Rlb2FZWjZUT1pUWkVvc2YvV2ZIRnFIakV0UzRaNjhZZkZxOWtx?=
 =?utf-8?B?WktvSkxhaEdHakIwa1VHblpHM0FKZHBaZThUNWhFL255QTJyWkhMdXRGK0dr?=
 =?utf-8?B?RG9mV3VJYkJzOXRGeWNucCtIWXh1N2xjRGtkeGFlNEhZZ3R4Z3Z2RkxzMHFR?=
 =?utf-8?B?N2hJYkN0aXRTSEsxT3YwYThUZG5sSTFaUStSSW82d0hTNU5GOVhKUzRSd1Zs?=
 =?utf-8?B?RkF4dCszeDVNR2JpR2VPT0V6UXQ1MUJRSmxvaDdLZlJNcEx5NGNoZlBMMlcr?=
 =?utf-8?B?QWdjS0hoMUpSTlR4R01UUUtZcnhlNzBYT2xtZk03MXlsWWxKTVR2VXdjcHdZ?=
 =?utf-8?B?UVRNVWJZZUJQdlBMYUdIVGRsNExQZFgxWEFBV2VYKzVVQTFjUERFR2JmWFc4?=
 =?utf-8?B?UDZueG5pa2FkN3pWQmQ1V2QyUHFobkRJRFlTUSt6clkxZERNYmdzdVFpMktY?=
 =?utf-8?B?a0ZhdERaMkdNMlFMbVZlZisxRE02VS9xRzVNZ3pIY3BhcEpwYkNiYmZ4RVF1?=
 =?utf-8?B?QlRKdmtENmRaLzdSMERYRlRpdGVzUUxtZjlheHBQSGFvRnVDbWovMys0VEFm?=
 =?utf-8?B?Si9JbC82dTZWQ1EvWGcwa0dRM2E3Y1NuWC9IMGpEVC83WEN3WS8zcEVXSkdp?=
 =?utf-8?B?QzNydStjaS9uOGY1aUl0QzRjNmFFcXhNNWZtYzA4dWJkWDhoMVlSQT09?=
X-Exchange-RoutingPolicyChecked: B/2tckVo8kPrxVHcWaCqBm2/t76IOPGgEys5MQ3G/vSO+AslF1SvOw0ECOxR+kQeRXnGFDOoy3YwwSJzlQSffbk+n/VDCkScLEvDD8yqX06TVLxdZpANvmqKA69vxCn0EIEPmL5HptEEpKzblvgnUKEPm1PkqbVmKY9jB0QDsBin1p5AGfsHD5+wHlzSHQQjy/KgW0RGAzWS5qxjqR+atDO7Qw9BZacmCbwYowDcAEDLBJwzqUpTbZzOrScQq4AOaZpTCFcvsStEnbgW88SS61CV47mBoqluLOjAHZMMH/lBZTxu7BMvWdTE2oiHZE1kWZtVI99awvqTirGpt8WVVw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c8908d1d-780b-47a5-61fe-08deb7e046d3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 08:58:22.6553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hf/t0qsVZI23t3iSLUcIl6u1BPm7nA9MXlSDgL0gaMn5PMAWm13RKEcN+NySgNumjKxyqTrE6/qzYGBa5GeraA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5948
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/22/26 14:20, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [PATCH v5 10/15] intel_iommu_accel: Handle PASID entry removal for
>> pc_inv_dsc request
>>
>> On 5/22/26 11:07, Duan, Zhenzhong wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>>> Subject: Re: [PATCH v5 10/15] intel_iommu_accel: Handle PASID entry removal
>> for
>>>> pc_inv_dsc request
>>>>
>>>> On 5/9/26 12:08, Zhenzhong Duan wrote:
>>>>> When guest deletes PASID entries, QEMU will capture the pasid cache
>>>>> invalidation request, walk through pasid_cache_list in each passthrough
>>>>> device to find stale VTDAccelPASIDCacheEntry and delete them.
>>>>>
>>>>> Co-developed-by: Yi Liu <yi.l.liu@intel.com>
>>>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>> Tested-by: Xudong Hao <xudong.hao@intel.com>
>>>>> ---
>>>>>     hw/i386/intel_iommu_accel.c | 80
>>>> +++++++++++++++++++++++++++++++++++++
>>>>>     1 file changed, 80 insertions(+)
>>>>>
>>>>> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
>>>>> index a66d63b4c8..82bfbdf484 100644
>>>>> --- a/hw/i386/intel_iommu_accel.c
>>>>> +++ b/hw/i386/intel_iommu_accel.c
>>>>> @@ -16,6 +16,28 @@
>>>>>     #include "hw/pci/pci_bus.h"
>>>>>     #include "trace.h"
>>>>>
>>>>> +static int vtd_hiod_get_pe_from_pasid(VTDAccelPASIDCacheEntry *vtd_pce,
>>>>
>>>> this helper is tricky. vtd_pce already has a pe cached, then why need
>>>> to do this?
>>>
>>> It's used on pc_inv_dsc handler path, vtd_pce caches old pe, we need to get
>> refreshed one in memory.
>>>
>>>> I think it's better to have a helper receives s, devfn, and
>>>> pasid instead of accepting vtd_pce. btw. I think the intel_iommu.c
>>>> should have such a helper. is it?
>>>
>>> In intel_iommu.c, there is a helper for vtd_as:
>>>
>>> static inline int vtd_dev_get_pe_from_pasid(VTDAddressSpace *vtd_as,
>>>                                               VTDPASIDEntry *pe)
>>>
>>> so in intel_iommu_accel.c, vtd_hiod_get_pe_from_pasid() is added for vtd_pce.
>>>
>>
>> got it. VTDAddressSpace also cached a pe, with a closer read, it's
>> tricky as well. Could you refactor a bit? e.g. avoid using the
>> VTDAddressSpace as an input.
> 
> Added as a preparing patch, let me know if any misunderstandings:

yes. this is what I meant.

> commit 31fc6e409f285a2a93f09f99fd271d4b01d87c53 (HEAD)
> Author: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Date:   Fri May 22 02:14:30 2026 -0400
> 
>      intel_iommu: make vtd_dev_get_pe_from_pasid() more generic
> 
>      Refactor vtd_dev_get_pe_from_pasid() to take individual parameters
>      (IntelIOMMUState, PCIBus, devfn, pasid) instead of VTDAddressSpace.
> 
>      This makes the function more reusable and prepares it for export to be
>      used in the acceleration path. Remove inline qualifier as the function
>      will be exported in a subsequent patch.
> 
>      No functional changes intended.
> 
>      Suggested-by: Yi Liu <yi.l.liu@intel.com>
>      Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index cf275b496e..aa27187e02 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3113,10 +3113,10 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
>       return true;
>   }
> 
> -static inline int vtd_dev_get_pe_from_pasid(VTDAddressSpace *vtd_as,
> -                                            VTDPASIDEntry *pe)
> +static int vtd_dev_get_pe_from_pasid(IntelIOMMUState *s, PCIBus *bus,
> +                                     uint8_t devfn, uint32_t pasid,
> +                                     VTDPASIDEntry *pe)
>   {
> -    IntelIOMMUState *s = vtd_as->iommu_state;
>       VTDContextEntry ce;
>       int ret;
> 
> @@ -3124,13 +3124,12 @@ static inline int vtd_dev_get_pe_from_pasid(VTDAddressSpace *vtd_as,
>           return -VTD_FR_RTADDR_INV_TTM;
>       }
> 
> -    ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus), vtd_as->devfn,
> -                                   &ce);
> +    ret = vtd_dev_to_context_entry(s, pci_bus_num(bus), devfn, &ce);
>       if (ret) {
>           return ret;
>       }
> 
> -    return vtd_ce_get_pasid_entry(s, &ce, pe, vtd_as->pasid);
> +    return vtd_ce_get_pasid_entry(s, &ce, pe, pasid);
>   }
> 
>   static int vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
> @@ -3151,7 +3150,8 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>       const char *err_prefix = "Attaching to HWPT failed: ";
>       Error *local_err = NULL;
> 
> -    if (vtd_dev_get_pe_from_pasid(vtd_as, &pe)) {
> +    if (vtd_dev_get_pe_from_pasid(vtd_as->iommu_state, vtd_as->bus,
> +                                  vtd_as->devfn, vtd_as->pasid, &pe)) {
>           if (!pc_entry->valid) {
>               return;
>           }


