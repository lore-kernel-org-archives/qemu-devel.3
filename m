Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA3AC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 01:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdgRn-0000WJ-Bw; Mon, 12 Aug 2024 21:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sdgRl-0000VO-Rr
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 21:35:37 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sdgRi-00070D-IH
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 21:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723512935; x=1755048935;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PBlcP4HWUhWJuLl+TlkvCWk2nqTZY+R0Zc0jK8MSOsI=;
 b=SnvlRmMWPWzccanzQOMNYY5wtFJcKiMlsgSloobC2/6yFfqMQ5TuAykk
 j15tXNq1ktDfLMQ8Dl7fBWHcInLY1OA7kdFTeqIS8ICA+BxkApiuquld0
 BVT6EiJUW1HRSpG4Bf2sVaeWI5rbv4TFeckp2ijhn1tWpaLrs03s5c86w
 ShOvOshKfvkdJz4y4aW8bXOlWGu5TrJ3xSfCj1DOAR8iaxWEU+2Jwfa02
 eMqqm8nEjjoIf3Mlko8gf2aH1Aog8P2HJihMtiXWaJE+VAKrVbGuYGBOF
 QqDSNnKNUCgsMZirnw9UCPWoRUYxn9yAqpOPbFOyvIk5q9BI/Xh51ntKd Q==;
X-CSE-ConnectionGUID: pGRZWY+QRaSREGEw8Q8eMg==
X-CSE-MsgGUID: yryQlE7JRdi4O1IVfV+TEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="39102589"
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; d="scan'208";a="39102589"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2024 18:35:29 -0700
X-CSE-ConnectionGUID: XlfK38t5Sf60pX+bCLdyOw==
X-CSE-MsgGUID: zbxOkPfeRcyX0QWPmd4rWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; d="scan'208";a="59057616"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 12 Aug 2024 18:35:26 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 18:35:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 18:35:25 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 Aug 2024 18:35:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 18:35:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rp2hCgWRrBmSAAI3SBAQGDSRqzQHOb/mXfn2/2D6X+ycPWe/ksagd5Bmj1+nMWX2fl1SoJBGda+HZR0FVGOwYVFveiinqRLc5BaTDHtprNDxHtMg14mIDIc1L90+9pMKdyrOqodtWH/F4cGhLYDA7J+L5dO+fDR4tTOlg2ieNqhrux9iJ2rIY1/omgPM+Z9RhkUfMrTAKCzwbhV44kW1TRmSTKxfYFfc0kLVs/s3cww2grKCU6XwCgmU7BKTwqVQP74ieuJkxcvpWYIo/bc/oO/k/2SdFYqvk3CkPU1++eV7+oZGFUIFwPSN0J3b2uwsZFl/2JkKpx/8O9EeiURLZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIaTd04g+wEKvG6gGc6eqXVNcuAydQgZiwR2cxw2ppM=;
 b=ro1x8gg/SOi0ScfxIGJUB95GlQYfQ0jgOt5NcY3/i0BAtopco05e9yGWEqf+C9FVZsh3ad0UWDy9CD7ykl+JltAABUHOTjO1qw/EzDRc9OesQ/2WLJA/tCFhZl3nOOSBtHa8xPRzs0BYrV2yNmCU8RhpNZ2mWGglAGlxwxBpV30RAhqFBxPBmA4oloXIwjzlTc4oVW+QUTDCn/8OOGp91+WSVKLmPKWaYFDsqVl4cx/oyfcAKQvFW3k2ihmrpbfmFX9LwX7+aeU7my2xrsKMtPzjD0q2duDd5FKtw4KHDA7iGWIiPWN+VODdaJejSLcsZcRh7jk2ktNFgOylVFn48A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA0PR11MB4701.namprd11.prod.outlook.com (2603:10b6:806:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30; Tue, 13 Aug
 2024 01:35:22 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7828.030; Tue, 13 Aug 2024
 01:35:22 +0000
Message-ID: <ff0fe127-bdca-41a4-86a7-c72e9fcbcf3a@intel.com>
Date: Tue, 13 Aug 2024 09:39:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 02/12] iommufd: no DMA to BARs
To: Steve Sistare <steven.sistare@oracle.com>, <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, "Philippe
 Mathieu-Daude" <philmd@linaro.org>, David Hildenbrand <david@redhat.com>
References: <1721502937-87102-1-git-send-email-steven.sistare@oracle.com>
 <1721502937-87102-3-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <1721502937-87102-3-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0219.apcprd06.prod.outlook.com
 (2603:1096:4:68::27) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA0PR11MB4701:EE_
X-MS-Office365-Filtering-Correlation-Id: 8871ec4a-f262-40c7-0c68-08dcbb383297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ty9RdFhLbTZBMktqWnB6Y0crU3phUkRRZGxTVFUzdnU5VU8rVVRHRFdwL1ZJ?=
 =?utf-8?B?YkQwOHhFYTBNVk5NQit4TGNaVzJ5OVZJL0VqOVhlRUNmOXR5dzBZSE5uS3dm?=
 =?utf-8?B?cXZ2TEx0UXV3MDlSMUthdFE1TnA1U3U5TXBXQXhHaU0xeG15T0k5Q0RxVUFz?=
 =?utf-8?B?VjJ5bHpTY3FNVGRsZmxpZzN3M1lYaXQvRHVIZ2tGTnl1SmpJWjNsa2pxcytm?=
 =?utf-8?B?T0hKang2WlUxa3lLZ0RSK0p1RjVyblVFU0EwSTlJNmpVRjlDbW83VEkrUmwv?=
 =?utf-8?B?T2REeFlJSG5iS05jOWhra3h6bTZLNzBCSnFTdzZ3b3EzOGQ2SjFURXlHN3lw?=
 =?utf-8?B?RkN6elh2TGJsQ1JEeHdzTnNadW5qTHZoakNubFRuc0U3amc5bWttdzd6ODN0?=
 =?utf-8?B?TEZ0bndTYk1pTE5wSDRKS1RESVJvOW9wVHhsVGQwUU9DcjlCcDJRbDMxQWJO?=
 =?utf-8?B?MXMwaC91WTJDVTlCamNWTGVrMHczcG52ZE91OVRuQVpvSU94bExRTnlZZEFO?=
 =?utf-8?B?V1lmMXI4YlRYOStmZUJoM0NxNXA1MkdOMDZLZm4rNjg3Nmp3QStYbkgzemF2?=
 =?utf-8?B?UWw4SG15TnZlcU1INW4yK0dWenY1WDc4dnVpdUM4Tkk4Z3dXbHZEaWlLQzRO?=
 =?utf-8?B?cVBRY0hjSVVpVzBWZVBJSWNYR0JPVG5EUzdWN0ZQVVNEM0g2VlFGM3VjZ3Z0?=
 =?utf-8?B?cFBIak5abSt5VlRiSzMyZHltVXZuNUlsUk93OUs4NUNSeUJHS0Q2QmFNa0ow?=
 =?utf-8?B?VmkrbkdCcWtWWm4wNkVkS1hsanAwYktxT1p4c0lrU21saFl4RnRLNDEzemIx?=
 =?utf-8?B?REFHYkdxUi9OdzJFMHBXZ2dORllZWmVPbDRuVjQreEk5R0Y2dXJONFpHaXRJ?=
 =?utf-8?B?Vi8yR3dQcmJQa1hUSU1HNUFiUU9uVFJqaGR2eXIrQkNRMEU3VnFRTWI5UE5s?=
 =?utf-8?B?b0xyL24xNkl4cEJtek1lZnpUMzJCR0l6UnNodXZ5UWZ6cTdNN0ZtWm5LNDZs?=
 =?utf-8?B?VjV2K0RIcjcwL0tnMjZYdWFMVHFySmFBQVIzOU5uQkswMGFQS09HOHFwVDJz?=
 =?utf-8?B?cmYzblJRM2FSbXhRd1drNlh0Q2N3VWFraXg3WmYwdHluTjg1TjhkRnUxTGth?=
 =?utf-8?B?aW5jcXM5eHlOODJjQ1F2aHBwWmdDSUFQQWdWVVlrQnRGT21KN2d4MklCT0Ur?=
 =?utf-8?B?MUptZmhxdkRyRnVaQVV4djBXcGxpQiswVFppQ0pVSDdQUjBlZkFLelE4RzNl?=
 =?utf-8?B?alpWeno1ajJlUzRPenVBZVBxa0hMZER4UGV4Tm5aRXJSSC9JdFk0TTB6cER6?=
 =?utf-8?B?VU9PcW1vWklicTNmd1dKL3didmJWdlBDRUlLYVc4M2QxS0hFd3grRFA1NG9s?=
 =?utf-8?B?QnAwYXdFcG9NK0t6blhsRjkveThNdGdyK1hucHhMQ0JFeFBMZjRqYUpQcisy?=
 =?utf-8?B?Z3h6MG0zdHBNTzEyVzNWNlFZZWc2K2lxZVFNM0VpUXptZnQ3R1E4NlplU1Br?=
 =?utf-8?B?bncwRjNObTMxUUtXelVObk9KWWFXMnJYV0s3eVBMcTJVdTk3KzE3NzBLSlQw?=
 =?utf-8?B?RVl0aE8zT3FoT2wyZHBKWXF4VnRWSDJvQlVaVGRNd3hRV2QrVGtZL0VIN3lt?=
 =?utf-8?B?REVDN3NOTnFnTmpNT05zTVNTcVJLNktVb3FZR3JVL2dtV1NmVVlPTkhFVEFN?=
 =?utf-8?B?c3MwUUFpb010VzRlWCtTM05QVXBMMEMzZXRzMzFJejJ0MnlvU1V0UmxVL1cz?=
 =?utf-8?Q?AjfCFHVHEYMquhZCZ8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEx5ZWFmcE51ZUdkTkNRcTRaeVdhV1A5THdmOU55NllsSWhZUVgwN0RsV0VH?=
 =?utf-8?B?SGdUZ0UySzJpeWNFRkZvTW1Hb29oZlRLbEtxSkUzS2dDcEV3cjRKVFNVallC?=
 =?utf-8?B?TjdXTUR3YkNja2tWZDVDZGQyc0xQaUdWR1prdlc0UW1BM1lJd25HUVJoQnI2?=
 =?utf-8?B?M2M0MUM3TjA5Q0s5WGhPRXFzYWJPSU9XK1hacWUyU2FLcUpzZlBGVVhQK0Rw?=
 =?utf-8?B?U2FJZVRzS1NBWitsZGxpM3BRYVdxV1F3SDBJMXIzUHFCUHA4TmhZSmg2WXVB?=
 =?utf-8?B?VGt5MkRTQ3BJTkpGb1drN0dWeTQ1ZWpaN0lYR2o4RkZXbjV3czE2VC83S25L?=
 =?utf-8?B?Y0tWSm5BOVlqRDgvT1pEWEh1SmR4S0J2aFIyNkhaRFNFQzVoanRjL1NSa1Nw?=
 =?utf-8?B?WktUejZpeEp0cUtJU0VvdEN0ZmE1MXN1S1gwcmhldk1wQzRFWnRWRWNTRkdU?=
 =?utf-8?B?MkJELzh5MEMvSmNzMGxGVGNjMFZjNEY2UzJXTTNWcjNQc2h4TFFCbUtIV0dC?=
 =?utf-8?B?QjJ2bnhHR01MRG5hN2hJSnhyNE5wS01uYTN2TFFZSk1KMzZGWXkzOWxWRUpV?=
 =?utf-8?B?SU9UK1AzZlhxR0RNd21VdUNsakJrdnFBQnQ0M0lYZndscVRzNTRGKzVPbjk5?=
 =?utf-8?B?ZHBQS0U5UXd4L3AxOGlpZEY0cDFpYTJxOXFGWkpSelZGUERUQkhWN2JveE9k?=
 =?utf-8?B?QkNQRWRXREt0RDQvc0pjUitadlRHYzJGSENZc1NZQlNIdXkwb0JyS0NkWjB1?=
 =?utf-8?B?UzgxR1BQOVVhMnk5alN3L0V4elk2Nnk4VjVKRjMyYk9kUzBwK3dIaFM4QVR5?=
 =?utf-8?B?SjRva05SbFVNZzgvZG5ZbzNWTUJNSXltaFdHLzE1cUdRUGpVN0xaLzdJd1A1?=
 =?utf-8?B?Snd2eUNSWlZ3MDZ5czNjdEJ6WWhFUGhFVi9md2tUOCs1cEVVU3I1a3VGdG1C?=
 =?utf-8?B?eTYzOTZZQjR5djdxcTR5NlcvalNWN3czS05rVkt4TzRpdFJkNnFVNkZMSzhO?=
 =?utf-8?B?Q2gxUnNsMTU4ek5oWEhQUGF6bzF5K011WlU4TGhtZnRlOGZLUms3cFV3d1I5?=
 =?utf-8?B?RkQrRkNkcHpPV0V6NEl1NVBkbHVCR0Z6NVZMOXdZUG1CYTRjcEhSMGhHZDY4?=
 =?utf-8?B?NkVFMkZCN2VIM1FXR3ltdEZISE10NjUrdHVDWmFNSGlWV3l4VkFmdkR6TkRv?=
 =?utf-8?B?MHRjTGpzSG9wb3loVjVZNUYzcDFyVjN3bS95SkhNWmtER2NReCsvSzl3clpT?=
 =?utf-8?B?bDlLNEdXN0pBS0J5SFFqblVEdkxMT0lOU1Y4RW90Zml1Q2NlQXVFOWdhclJl?=
 =?utf-8?B?MjFuK1hCY1lkaDVaL3EwMWZwK3YvMU5HWHZwa1FCYldMaFp3TGpGSXFYZDBH?=
 =?utf-8?B?cTdraDNFS2xtMy9JajVlQzhSdVpkam0xSW5BZDI0WkhrNGsvVnZ3Tm9JV2Q3?=
 =?utf-8?B?dVhJWmo1RzdDc2VZUnN3Z0hFZzkxNnMwNmFIQUs1Z1E1YS9VQ2w0S2daTnBv?=
 =?utf-8?B?K2QvcW04SWNYME5YQlpCNTBHaU9HT3BVTjAzQWxHTGprQzZPY2oxUHBscXFq?=
 =?utf-8?B?TENmc3puWDJpY1pCNnZpdkNQWU1aUk1jV0dpV01Dc1RGYXYrWCtOOXo4dkdK?=
 =?utf-8?B?ZzdnSVYvazdlcy90NVE4RTFVdm9Bajg5MzNhVm1YSTc3ckNxQWk2VHFwOUcz?=
 =?utf-8?B?Um1maVNJZHNRbXp5bW5qalVqaERvNzNYTmUyeEplMkhKc3hZMllUVmRBeWZF?=
 =?utf-8?B?bTNWblNTbTRCMTZsK1MrZzZZb2F6T0l1T1hLeG9JZDU2cjNFTDJDdEJSZ2pL?=
 =?utf-8?B?N0lZNVRtQXFqZ2RYb0Vrc0ZuWWpLNzBBeDhWWVRpWEhoL1FlbHo2S0ZZNVR4?=
 =?utf-8?B?ZjFhcG45STlJK2Z6TVJjQ3ZEV1J3OWkzblMrN1lXYjQvZFl5cjBkZGZzdkh5?=
 =?utf-8?B?WmdLTTVwT3lWOFJFS3kvSGpyRUZRc3BEMjVmZmZBeUxXUVdtcmFyeGl4b0Fw?=
 =?utf-8?B?RC9KcEJVZXV2VnpzUDd5Y1B6RmEwMkNjRklYSzU4bzlGTEFqRWtBMlRmdnEz?=
 =?utf-8?B?Y0FndzJYK1ZzVkRzaW1zd3dzV25peGZTVnhiZElUVVBGWFZCMTZGTlNFKzk4?=
 =?utf-8?Q?5aoxUlZ1DAyb0rGDhsYW6BiqT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8871ec4a-f262-40c7-0c68-08dcbb383297
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 01:35:22.4226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onRIQD8XzMEaWNTyLyA6o2GIVfhhGUHMU9Y8xYAL4HmiRWbBRxCVTrX4T3M9BeYMsn2IkImaWqYRZi8NDQEUag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4701
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 2024/7/21 03:15, Steve Sistare wrote:
> Do not map VFIO PCI BARs for DMA.  This stops a raft of warnings of the
> following form at QEMU start time when using -object iommufd:
> 
> qemu-kvm: warning: IOMMU_IOAS_MAP failed: Bad address, PCI BAR?
> qemu-kvm: vfio_container_dma_map(0x555558282db0, 0x8800010000, 0x4000, 0x7ffff7ff0000) = -14 (Bad address)

It is required as Alex pointed, so no need to pay further attempt to hide
this message. And there were efforts to make it. But not done yet. Below
links may be helpful if you are interested about the history.

[1] https://lore.kernel.org/kvm/14-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com/
[2] https://lore.kernel.org/kvm/20240624141139.GH29266@unreal/
[3] 
https://lore.kernel.org/kvm/0-v1-9e6e1739ed95+5fa-vfio_dma_buf_jgg@nvidia.com/

> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/common.c      | 3 ++-
>   hw/vfio/helpers.c     | 1 +
>   include/exec/memory.h | 1 +
>   3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index da2e0ec..403d45a 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -248,7 +248,8 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>               * are never accessed by the CPU and beyond the address width of
>               * some IOMMU hardware.  TODO: VFIO should tell us the IOMMU width.
>               */
> -           section->offset_within_address_space & (1ULL << 63);
> +           section->offset_within_address_space & (1ULL << 63) ||
> +           section->mr->no_dma;
>   }
>   
>   /* Called with rcu_read_lock held.  */
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index b14edd4..e4cfdd2 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -435,6 +435,7 @@ int vfio_region_mmap(VFIORegion *region)
>                                             memory_region_owner(region->mem),
>                                             name, region->mmaps[i].size,
>                                             region->mmaps[i].mmap);
> +        region->mmaps[i].mem.no_dma = true;
>           g_free(name);
>           memory_region_add_subregion(region->mem, region->mmaps[i].offset,
>                                       &region->mmaps[i].mem);
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index ea03ef2..850cc8c 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -794,6 +794,7 @@ struct MemoryRegion {
>       bool unmergeable;
>       uint8_t dirty_log_mask;
>       bool is_iommu;
> +    bool no_dma;
>       RAMBlock *ram_block;
>       Object *owner;
>       /* owner as TYPE_DEVICE. Used for re-entrancy checks in MR access hotpath */

-- 
Regards,
Yi Liu

