Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CB0D111B3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 07:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7rOi-0004YA-Rw; Mon, 04 Nov 2024 02:21:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7rOg-0004Xw-A6
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 02:21:10 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7rOd-0005NP-E8
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 02:21:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730704868; x=1762240868;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=plbVSFBh6MTmEHXMRv37UMWjwMY3hKaPzQWncOuMdkQ=;
 b=di5ksbdtlg3JWDX6448mDPVkqKYCBhFI7TiG+V+goayClnLiEhUreB+d
 d3LGKnTTfxuvEAZkRRZn6aOe48nax5lWi6YVDhLlsnw9rHg82dgGyhpWq
 uKyyecF+/f5wwv/i670+clbJAbTCBW9hSjUQjM0jdJQQ7zhduJnpP//4i
 KA9+Y+ufXtXpy3FWYMZR5WULJ/+UK0MVERyfrEZwCM+DZadPxHCIeQi/u
 Ua21A44Y434sSAXXXylykfcBRoEb3AAuYMZuPT0CYMsgWK3CyxDa66Fr8
 +OJWmLUHw8sLD97+Y6fGNHPGiG0MgQc45MdB0UkPRa3gXhHw3VFre7vgg w==;
X-CSE-ConnectionGUID: NQBbJQVcQ7ip1aCGG4jUaA==
X-CSE-MsgGUID: Q/txtQw+RIShoLrtccVpsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30334925"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30334925"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2024 23:21:06 -0800
X-CSE-ConnectionGUID: W6PFBhf0RPm7wSv/lA5FQw==
X-CSE-MsgGUID: HwFO9ad1TRivPCM48fdAWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="83663374"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Nov 2024 23:21:05 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 3 Nov 2024 23:21:04 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 3 Nov 2024 23:21:04 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 23:21:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBW5dh0WQ4cJWyuG4nhEu+kT06AqSl08wmTcEfoJ+h6oPkztE8ZOm2bnH8kIC3h0tWIT5ZB1LWmlK2jxcDIJkT845skXcKD49p7Xc/BoQnEiJ0X/rQfsnD3okyh+NgrNC8jSeBHLsszPkB/SI7UgNDDIYm7RA6y0TLD2n97jroSEclXQ07p6Uwl/azq84aFqC3lq+AnTvNkwStsbJMJsBV4FlTthDmoerCnn/6IOaUFCbPh2rP1gJ8U1zZQfJ1Mp/QNepVSUC2l8AM7QE5oSyy9ZaGJCEXJMMO1QTeDx1jTbBYiBDVvMrL3KEhIk1BK9RVlDIuFf2pvdpvcxrpJTxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tHdrKNHUZQ3tT7x/YlmSIFDTMCfq7x1Bhvdj9wGXQk=;
 b=x6uZjbRRcWg+6GlcWeVg0X+BHE+1zlocXAvhz8f9kgqwWXeATmGUF/FSAdRhfIkDPgmX3VJGul/SRqqAPATb0Dk9HNx+lYFz7//5iobMTRFmGaIeQxdifMgqItaaj0eqvuCt6v1/OrjmrESyzCLFp/6kAbw7YZicfxFoV+SlH6gVYuw5rxGo2EPrmurFJURn5Up3+Z7AOhQx2NsF1/t1fghhDYxg0Pp48A7lTGTSpmRvdQmIAEwoQBiI/en7kuNMqqDKFH0b+E1A52Z9rjft5ZXCkEuU/Jpv8LOOEcaVeJhNTZSuikWP2eWZAbtnfz7hCnqWlM3BVDsWVDR1Bg3kfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CYXPR11MB8691.namprd11.prod.outlook.com (2603:10b6:930:d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 07:21:02 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 07:21:02 +0000
Message-ID: <4b055956-8036-47c1-bc44-8b56ae70d2a3@intel.com>
Date: Mon, 4 Nov 2024 15:25:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/17] intel_iommu: Set default aw_bits to 48 in
 scalable modern mode
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-15-zhenzhong.duan@intel.com>
 <74b6f85d-f5b5-48da-8bc5-bfe721250687@intel.com>
 <SJ0PR11MB6744C11A435CBED0849A733992512@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <SJ0PR11MB6744C11A435CBED0849A733992512@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CYXPR11MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: bedbd458-33b5-4e95-c87c-08dcfca13cbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUF3ZFhwbURUUERyMWpXSmNmTWtDenlHbHF2TEIrUlE5NUNjZ0dqTVA4OGRy?=
 =?utf-8?B?VW5aeHlZYThmMTZnUkUyRXlXQ1JtWG1udXErR0ZMK25YZFFoQUVlVCtma1h2?=
 =?utf-8?B?NGFLbWIybUwvYThSckJyZlBVcmpSTldKaGdVSWxzTmdQL1JJWVAySXhwaENK?=
 =?utf-8?B?dXVaRkQ4cGhqVXNaTkE4SHNmRXdMWE5jZTNBNEVnY0h2a2pKR0trTHh1R0cz?=
 =?utf-8?B?YXFWZXduSXRZcVhHNmtiYXZRb252ZktRaG9ZTGg5djlxNHIrRzRPdFEyc09I?=
 =?utf-8?B?cW9lOTFoc25ZZGZOSlF2SExzV2wyUkw1WVF0dGFNREtoc3laRHprZjkzY3dF?=
 =?utf-8?B?cDZObE4xSlVISlB1eXZESE9ZTkE0V1pqWEUyL0wwZXd1WEhkNjN3dkpGc3hI?=
 =?utf-8?B?a1lpZGNBRmhhK1N1bVRxVnB1bnlDZjdBTis4UjFnWFFUVDQ1L1BiR1BqbEZI?=
 =?utf-8?B?eU4xTHNQNklEZmxweFNwdTdibnBFUTFvd2wvNWNxaC9QcmhWS2pQdk1Nc1dz?=
 =?utf-8?B?NTRlOFduSEZIanJIMnA1UHpNU0tWWXpERXlVbUthWVU2a2FBV25SSkxqV0JX?=
 =?utf-8?B?SmdqZW5rWUJISFJkZThHWXllZE1IUlNUOVNzcHk3WkZZd2JZT2wwRmJQVC9u?=
 =?utf-8?B?d1dWRWZsbG1uQ3k5UjdzeVlVMFlxd2VnSDlLelNJVThLMzh1Njh0RTJYWk4z?=
 =?utf-8?B?ekNDRytmSEQ0dkdSQlN2b2xqS3VRV0E1M2ZtSVJhQ0xIK202SHZQVld0SVdL?=
 =?utf-8?B?N2ZuaTZ6LytmRGpjRjNxSHh6bmJKSHJpd3JJb05hMG9IdlJYbTI1eHNGTUV1?=
 =?utf-8?B?K0lMYkNLNkdtQUxWTjdlZ1RSNUdybE0yVzRQbWM5TWNXNGQrQXVUSmpZS05O?=
 =?utf-8?B?TjUrWUhuQ01DeWd3N3hXazRLSWpjYTNTdzlKajBScEJnWDlkc3ZtcnhmUHlF?=
 =?utf-8?B?eFd5dzF2ZWdiVmQzU3VKMzBJSHZqYXl5MTh1SmVZNGtmaHpDS3lHRDBCOXpS?=
 =?utf-8?B?NzgvbDkrQ01LTU4rKzdTRENyeU0wSjl6NGN0a0dGT3NJMVJoeTU4MVIvRjZo?=
 =?utf-8?B?RnBxWHZRZXRnOXhORFBZYU9zY1NOdjgybWZlYTJ2NVpNbHRvTHRYczlTeFRv?=
 =?utf-8?B?ZzNOcUIzVUEvbC9BK0ZJQTFkS2kvTTBaL3VTckRJQjVSVVI5WTh6Y2F4ekFu?=
 =?utf-8?B?ZEkzZ2U0aGo4cG5nVWZHS01mNU9nUmdpMGxCS2pWL2F1UzZHa0N2aVovZnhi?=
 =?utf-8?B?RldmZzJVc0E3QktSWHMxNkwzcW5zT1VxUzdJUWhHc2VUaUkzWHE4c0lESlhC?=
 =?utf-8?B?dWhkYjUyTWRXemlBVEZlS1JkWmxKYjlvNnpjRlM3MmU1WXk0dWdCdWswdVFZ?=
 =?utf-8?B?TzFlQWV3YTJnRGZrZ2UwWVFoT1dZYS94VlFmTm5KNVphN2g1VkFyRE1FYjdn?=
 =?utf-8?B?NlVlY0lhVW5XYnpveWozS1NRSU9pbzdFQzlCRHIybVlmVGZIOHVSb1ZxYklZ?=
 =?utf-8?B?Wlcyd09OS3RzejhSMVd1VzFzM2RqcG14S2cyM2lBR0RnYkJ4THJTKzRXL0l2?=
 =?utf-8?B?UkVkUlBtaGs0MTRqVUk0T3F5Q1d2dlg1Qm1XTWVFMUxIZjc3dC9NNmhpRHV1?=
 =?utf-8?B?RWJmajZpcXE4VVk4UVI0MFlUbzJuNVpnTTdETVJERUdPQ0xmV1pIQ2tSTXYy?=
 =?utf-8?B?aEZpNkx0NmRBZXkwaFhCdVhDK0xEdVJHSm5EMElUTUtxcStpWGhxempEOEZn?=
 =?utf-8?Q?DkryzwVjB4REpCP2h8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWJLb0lJd3Fzam5iM05LTGtzL2daVkFNbFNUTmxsRDZ2RExQd1dURW02SGRC?=
 =?utf-8?B?RDNRazc3cVJSV2dwQXhJM2JrbUZMTHo2MnJwYnU3dytibzQ5UGNXdTVkVHBE?=
 =?utf-8?B?eUM0bk1RdXY0cVBvK284QXlFZldwUk9yOXJMWnBXam4yR2JTa0pkNG44K1Ez?=
 =?utf-8?B?bHBJUjBhM1FPRUptK3VnQVVwY05SSXpuSWlrN1pEbk10aVdCY2Z2L3VDTFBS?=
 =?utf-8?B?OUtxVkZrdlhVZnBmSzhUVDBnSThiOW9QU3hYbkJiS3ppZkpmc3Rqai8ydlFK?=
 =?utf-8?B?YkdpeVFsWU5RNVpHUjRId1NHbm0rd3R2Ull2ZEZKd2ZodjdGZkZGSEc0cE8r?=
 =?utf-8?B?UDFDTkVkVEhaNVQ0WUJPOFZhUnhiOVFIeWlRREx6VVRWcURGY29YOURYWC8z?=
 =?utf-8?B?YU02STRkL3lEWXNUYXdETllmMjRDblNKTmNBUGthNTVSYkhMOGtuenQ3R2Zw?=
 =?utf-8?B?RVE0dTN3SHRLbU5rNVYwSGpzc2FxdklCSXhFZjJjclRaZHJGSEpWMVk4ZGlL?=
 =?utf-8?B?b1RzTlFhOXVzMTZ2amJqckhOWnh2NWZNaHpSMDQ3eGJ0UzQrSGFEVWFFVGhj?=
 =?utf-8?B?TXNqVVBYaXlPRWx4R0grMm5EMEsyc3VHOUhPYThndkVCbXZpdlhuWlVmdVFM?=
 =?utf-8?B?T2s5bVZBb2F3dE0wZXl6bGR4R3FvZmdWNjd2bS9pWDN5SmdCN01ianc2NHZX?=
 =?utf-8?B?KzhFb3hmNFlEMkViTWczeHlsTUV0ZDl4U0l2Q0wvdmh2Yjg3ejZNbXh3bENs?=
 =?utf-8?B?UjBiK3liUzZ4TmM0UFVkVkZLQW15a1RiazY1Y2NGM2tCcXh5ZktPTjRqQ0gr?=
 =?utf-8?B?dmVRNWw2Z1BIZStyc04zOHBXN25mRlN3L2NJMk5TVXBFaWpxN0tVclBhT05L?=
 =?utf-8?B?YmVvS3JwZ1F4Z0ZpcC9tYlpwVlpNT2lBUmR0cVFEazRQOE5MeDdnSG54WTBJ?=
 =?utf-8?B?TDBkVmZtRXBoMjR2SGJDRG0xQTdYSER2VFc1TWpXY3Q0aEJVUG9KckpwdFdL?=
 =?utf-8?B?dU5kZ1JuRytCd3M1bUpSSXZOdnhvbmMyY1JVUk5BVjYvYmVqYldwZE1uOFJ2?=
 =?utf-8?B?VHpQQzhmTHJHQkI1S3hudHd3dnlFeGRmMU9tMEhHSGlSMnlyWFdWN3NQM0dh?=
 =?utf-8?B?eCtlN0w1eUkvNWtrSis1QVR1T0Z6TGNPNmI2L3JXQllMMWV1UHh6bDJ1YWdP?=
 =?utf-8?B?Y3RSQWJTcy9XL29TWE90bnpnbnNabXRONXBUdk5nQkdIRmFMczNub0JjR2xi?=
 =?utf-8?B?azJITk9idDd3MmFmNEFrWk1jcVRNc3VaNHBsbmpTZTRNNnV5RFZsMnpyVkcv?=
 =?utf-8?B?dzBkVkhlUU1lN1VKb0s5R2grTktSNURXZTM2TDUrSVdkc3ZTWDNmZ1FjaDgw?=
 =?utf-8?B?ajBoMlIzZW9BYmtldHZ1ZlFRTHdVRXRORG5FOVcrdytxb1FaSUJyR3ZHZVJt?=
 =?utf-8?B?dElXRkt0QUJpdTBnSHZxSFllb2VZVlp0b2J6eThuNUVySE9zMzJidEg4L3h4?=
 =?utf-8?B?L0tiR0xUK0g3TFZ5bFAzWlBXcWVSL2hiRFlsanlpc1FzOG1PbW1KMU5Rb1dy?=
 =?utf-8?B?aTVsWUgrSnU3T1hKQkhIUmdsdU1Hd1BhSHc0R21Wcmo3Y005aGFIWko0UUZl?=
 =?utf-8?B?cThDU2FuRGpsMW1xYTRwNDN3SkVJL0NTbTIwTEhOZWY1VVlBdjlCdmdmcUE5?=
 =?utf-8?B?OUdPMnpEajBQQk9HS2MrU0paWXcwVWVGM3REdjh3SiszL2p4RTV4ZGI5NXNF?=
 =?utf-8?B?ZUxsdDF4dE1Uazh0RVNxNFk1cTAwSmo0MG1ieFBHQWpHTHZvOUJPdS9HMStD?=
 =?utf-8?B?NzhScHhpVklEQzRkYitPaHYzcWxIT0ROM1lCa04xeDZkOHR3d3g2Lzd0YUxj?=
 =?utf-8?B?Qis4d0JRazl2TE11dHlFb3ZQM0lzcW5qTStxWjE3TW0xRml3R2NHdlhvazFt?=
 =?utf-8?B?Q21ZSXhWbkZPUkFQKzl5dllXcnhsZG1aU1ZIMVRXOWZ6SDhPd1J5ejc2OWha?=
 =?utf-8?B?N3RhOTRzMlBGdjQwUHhqT3poVmhMTm1SVXJleUJUcDBpUm9ZaSsvd0lzNGh4?=
 =?utf-8?B?ZzFNclEvL3ZhcW5OK0tuV1RacjNETU9RN1c1M3l3a013UVhXZzlZYWJhd2VJ?=
 =?utf-8?Q?gFxbHOayqGULkc+0qZUgoR5E3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bedbd458-33b5-4e95-c87c-08dcfca13cbd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 07:21:01.9957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9V7OuJmCPJ4mvx8pGMewc8R9xYCF7R1VYMCmcODTgQIs+azqubVXn1hHmEgj4hXcKa3d0rRPI12FRK5jVv4LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8691
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2024/11/4 11:19, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Monday, November 4, 2024 11:16 AM
>> Subject: Re: [PATCH v4 14/17] intel_iommu: Set default aw_bits to 48 in scalable
>> modern mode
>>
>> On 2024/9/30 17:26, Zhenzhong Duan wrote:
>>> According to VTD spec, stage-1 page table could support 4-level and
>>> 5-level paging.
>>>
>>> However, 5-level paging translation emulation is unsupported yet.
>>> That means the only supported value for aw_bits is 48.
>>>
>>> So default aw_bits to 48 in scalable modern mode. In other cases,
>>> it is still default to 39 for backward compatibility.
>>>
>>> Add a check to ensure user specified value is 48 in modern mode
>>> for now.
>>
>> this is not a simple check. I think your patch makes an auto selection
>> of aw_bits.
> 
> Yes, if user doesn't specify it, will auto select a default.
> 
>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
>>> ---
>>>    include/hw/i386/intel_iommu.h |  2 +-
>>>    hw/i386/intel_iommu.c         | 10 +++++++++-
>>>    2 files changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

-- 
Regards,
Yi Liu

