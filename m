Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E373C7115B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 15:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYIz-0002OA-CB; Tue, 17 Jun 2025 11:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uRYI7-0001Fx-0d
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:32:03 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uRVLu-000155-I2
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 08:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750163027; x=1781699027;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=U4FEHypgNpRH7OS3HLR5tVY7AauIgrVcKZO2R3dTzko=;
 b=G9IfwrSF2qleNjW3p7fTYYb1WDONw+utFdlVFVo/UN1cDtwoGAGG1Chu
 bqxvd1TFN8zluu3nkmbpWrCbLEDjjKgybo+LGS5udkTGzzAocN/HDWn3a
 3e+my6KLaXJuyOhm5pNQ/VO70hHK1LBUViEcot5MqV9G8/szuKgKTkKCZ
 G+WPNS69DCgsIR6/lgXar1mlk08uUZIS2n3v4Twy2wVfoa8eFtejdYCa6
 JUuQBt18fZSpETU74CsHGzXiK2zrB+9kotIjXx2Z+Uc7Cs4lHcHnsKOQw
 ZhHKJOBMcj0zbHmxKQcEC2mXs82v/qxKtJhtN93mvXUapkVj7XUYvvrd0 w==;
X-CSE-ConnectionGUID: rJR20hh2TIyS84NHqrKMIQ==
X-CSE-MsgGUID: QU4yGtkKS6qWIU/K1yjpAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52475862"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; d="scan'208";a="52475862"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 05:23:45 -0700
X-CSE-ConnectionGUID: noLswBRKQgOLHcvlnNXCgw==
X-CSE-MsgGUID: Z6rJMp75QvqJZ5a7/R5sCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; d="scan'208";a="148672372"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 05:23:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 05:23:43 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 05:23:43 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.59)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 05:23:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yx6U1u5qyAHTmP/CoZY2iRJS+mJwA1R/wo/LiHJfa1+71lZ0coHcVLJGEZVUzLIm4ICI1lfpQIu8Wr7KJ0tBdiQWefDx2MnnVwTtl2keSC9KUPodhe1FAMYfs+8G95j/kh7xcfRMQmP+mYL3dAEoPsW0enhp2jiUQrzT0sqtPa5eo22xZXA9UP7H0W1SagUKRijmzCU1CvHquo+ph1721c8pS6QSNfuhvdL7Yg9JuxDRqBXh0DOJkTKeBoyCkYqOoIoGyOYvkQmWKOoxFXx8Go3haZHfxw0xzJzkeac9rSwWQJKeoa6uO7P1PK4hcAPs3gI/tfuBWNPcgGBNMeDO+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asHvnfu9VW+sUtUaq6b2R5K2wcerHgkgGszhmGtI/D8=;
 b=teXKF/56RH/UDn502gPYnB1mAKBDAbR4rUu3jMTqdm/GidJNT5ypRYCsACEaVL3sCxf3tu52KRVK8bmsqlNOMltAGtYApyCHUcEjm/VjVstlpT8W6i42ZWsfb16y/6gXsbpHkVkLp3qFsjDF65O0kez7w2wbUgqPK8wce5+LlGlbqnnmknGon21UP44XP9Eo3wXImY2zN/RrpU8WRiqYEDIQWUJxBW4x96+OdfCtu0tvVdQfMQHslQtYYqVjawHZqeKkDEVAQunFBCsE6zyYFDepO9RzhSnQ/q6jmigxxv30AzP68Q+i/lX053lCJIT0r9Txx7N1+bXgzE+kgF8kpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB7703.namprd11.prod.outlook.com (2603:10b6:a03:4e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 17 Jun
 2025 12:23:35 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%7]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 12:23:35 +0000
Message-ID: <77e1ed6c-5bee-4d04-9ed1-5261c5203289@intel.com>
Date: Tue, 17 Jun 2025 20:29:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/15] intel_iommu: Handle PASID entry removing and
 updating
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
References: <20250606100416.346132-1-zhenzhong.duan@intel.com>
 <20250606100416.346132-7-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250606100416.346132-7-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ0PR11MB7703:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf98dc2-534d-40e6-d0d8-08ddad99c7ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dmErUFU3ODBmVE5CamZ5K1FoQzZENytDa0FBNkJTVDJ6MlNsek1xN0piRG43?=
 =?utf-8?B?aEZaQm9CYVBBNkxodE5lRS8wVFRlcS9Lc3lONDNqUDVPd0VieG00MndoRFhC?=
 =?utf-8?B?SzJ1aWhpUzRqQmk5bTJjdmNHVzNOSG56eitYbmxxcmhGWEdvUXo5NVVKL0xI?=
 =?utf-8?B?N1lRTUlRS0gvUVg0TzE5WVgxL2Y5MW9kZFRCTDBJaCtXV3RHNGpTWDVOcXZh?=
 =?utf-8?B?Mk5wY2lmblNWVHRDNkFuQ29kSWRLa2NBdVkrNWcrZlVuMHFrYURjRUt4TVUv?=
 =?utf-8?B?aHJrajRwRHF5WnNrTW9UZldldTV3SFZiTVZ3MEp1SEd4OEw0cmhkalJqOGdP?=
 =?utf-8?B?QnhtRmY3ZUdTZTk2YXAxc1UwWnlzVHI2Z3RCaE1tYUs1a1dlS1RUZGdBL0ZJ?=
 =?utf-8?B?UXc0WlRuL3k1TVJpK3dmNnljYXN2SkRWbXVQdnVwemdrWFFrTGUydG9MemNW?=
 =?utf-8?B?ekU2cUEvaks1ZGVhakUvV1prT21vY0FSeXZJN0ZCYjRIVXBWMXlMUkpIbXNk?=
 =?utf-8?B?d2ViVk0zd1g1TzJ5eGNicFVZMlRuZUg3aXA3QUxjOGh0cEIrRnBuMVEzbThm?=
 =?utf-8?B?bmVwM0JaV3JiTVQwWFJraUJVUUY3TExsNVhUaUR1RUwwWEFFSEdLVERiRExI?=
 =?utf-8?B?aTdSQUlINTZsT1MrcGNTcjh3dHNGeFhpZ2xFYnpTTnpmWXJvTFVMeC94a0J3?=
 =?utf-8?B?TkhwaVBNblovczM4bHJjM3ZBcHgxenlwU2V6amh6OFNmYTE1WlhNc0ZhVlFL?=
 =?utf-8?B?UVJmRk9RbWJxUzVVekpPbGdSbjlpUlNNeGd3SE1LOWhtODZPSzdEcmZOTU5u?=
 =?utf-8?B?ZkNsSnZBYmJldTZCNjBiK092ZjZNR0svcnkzOTJ4YXc1Z0Mza2t3ZEpGSXA3?=
 =?utf-8?B?Znk1QU90YXR0TVZrVkFiL2pJS2R0NGNDTVY1bHJmbHZrVDh0RnE5cVVKOGtU?=
 =?utf-8?B?Q3MxSGR5aU0rTjVFcmxtdkROS0ZNM3MvQXBKZXgwL29rcFg3SGJUdVhMUUpD?=
 =?utf-8?B?SVZqbzlUMzNtbU8xd0dxczFySllsbTR4TWtITFVvNmNwVHpqMXhkMXpLengy?=
 =?utf-8?B?MFUxR2JZYlFkVkhoSGVlSEt4RW9HVUdrRGNIUnMxSGNheHZCcWVIbEIwdkRB?=
 =?utf-8?B?Wnc3ZGltWGZlVzNIc1YvRlVaeEFub2FXTkFDZk9IajRmSk4ydjhtS0R5bnZR?=
 =?utf-8?B?Tm5DSDVmVnZ4YStySnhzdW95bWpqTkIwR1VCMERqZDVOU2dCai9Oazh2VFhR?=
 =?utf-8?B?c3gwY01GVGNpS2NIbG1nUkdNamMxaUFiM0Fwd0xVcEdoRHhhcHJNbUxHL1Zk?=
 =?utf-8?B?L1FtandmVDd0SlE3Y1IxWFZqN3d6dFdteWt0VVdjalUwWFduYmVnWnlVWDQw?=
 =?utf-8?B?ZVJQOGE3N0VXaDducWJTd1RtYk1GYUZpNzBZbFowS1ZqRUIyVjlTclVGK0Vn?=
 =?utf-8?B?TXhxem9LNllOTnlMNG9HYUNhVk1NemNqU2h3ZTFiN00rRDJkNjBObnBEcTlX?=
 =?utf-8?B?OUFlQ21rRDhhZ3NLRXcvbWg1WGtlY2VTdUxQeFNTSEhUZ2tDbGNwSGVjUXdH?=
 =?utf-8?B?UW1IVjMvMkg4MTI2V3lMT2hQTXJtbGxqUVdQeUZORmd6eVRLdTk0SnNIaE0r?=
 =?utf-8?B?dnRrWG1ncXYwWjYzRHpOMzE0TVdlMC83aEQyNFdpL2oxYWRNMlpTZktwM0ts?=
 =?utf-8?B?QzhEQWFlR0VEenFmckJ2MHZxT2JBZGJLU2NGajNxYVpNT1dDV1VNUUwyNjVs?=
 =?utf-8?B?VlIxTElEY0xkMWRsQjU0Nkh4THB6TU4yVnhHcXZJMlYzaUcrZktzRm1HS0c4?=
 =?utf-8?B?aWZKRnhyRzN1ZU5oMTRCSDZ3ZFQxWFl0bGxUQ0FVdHQ0cndYdVBFcUJWVi8y?=
 =?utf-8?B?S2Z4bkRPdUNHRGN2bWFlMGk1SkF5OXM1VTdaNkVZM0JwaVVQUWowd0ViZ1Fz?=
 =?utf-8?Q?E22rAQZ2Bbo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3NoNDN2d3hDQWxYbWZYWkZNRXM5Ung2VkNZTHQwdGNQeTNVOTR6SWl6cHo0?=
 =?utf-8?B?N3Z4QzZ3WjFFL2ZXa2FwR09kaXlEUXdYZWpLRFM0VXZSYTJlcDBSdy9Ea2la?=
 =?utf-8?B?WWJZU0JZcFlBNEV1aFlnV2F1d2FhanUwQ3ZEWHB3d1RnRjBQbzlCKzhTamlt?=
 =?utf-8?B?MEo0Qm1TQ00zaVlOL1Avb1RUbU9FR1VKRTNSMndhVXVjQkh6N1pRMXVCZ3Zi?=
 =?utf-8?B?SjVWVDErQmpjYTBLb3NkRVluYlpVS3hxbWZieWxrT3JEcW81cE9adXpiQkdQ?=
 =?utf-8?B?Yi9WWis2UHZpOWlESW1mMkRqYlpoeFIraWQ2ZlFqa2FBaERIQ2lJOEhMbHVS?=
 =?utf-8?B?dHVZTTRQRnJCNmczWXlJUHBsdlY5UVkrUTdJeDh6Z1RLdnd3dkoveG9yVEVj?=
 =?utf-8?B?Q1NQTnBLMCs5REw0bVMvY2pLYk83bkRGbzR1d2VtK0xWUGxCektETDN1S1hL?=
 =?utf-8?B?ampBTWhKV0VPK1dnSzdwWDJtendpUVl6UlQzNFlPTlhiYWdNU3dZUTdZYVNx?=
 =?utf-8?B?eU01YktOdGFMbTJxVEFZMXl5Y2szZURNcW9iOTFoNitqUTVTdDIyd0J4ZDlp?=
 =?utf-8?B?RlBscmlLN3E4ZURpSGRCVGNOREVuMHkyNG5BNTcxa2VCVEp4QUdxQjM4cnVH?=
 =?utf-8?B?TjhLSU1mYXRnMXpYVVNGb0JQZkxTZnB6dDdmSndCcGMvQ0RZT2JHeURNYThp?=
 =?utf-8?B?V2dqelVFR3NZN2ZCSTZSNWdoTjYrNGppb0pja1JwV0xYNnZ1dDlXRS8wdDVl?=
 =?utf-8?B?aFBpMFU1SnVXSkltcFpOMHhrY3VxOUJmVHlzUEw0Ti9ralBKUUZ4cGJQM2tS?=
 =?utf-8?B?VkRUTitBTnhBTk5IRkkrZmdxcTRvREUreUVqb2tFUUJ5TEdxeHc0VWs3TTJw?=
 =?utf-8?B?dkl6L2thTzVZcWJNUHpiNlQ4Y0hCYm9FY1BQeVhHMVA2NkNjZ2cySy9taWh2?=
 =?utf-8?B?aTh5ZzV1eml5ejUwM21GbGN5dzQzWGFzdUVDd2JjaW8xTVFXVWFXMk5QV3J0?=
 =?utf-8?B?MUJncmRkek50K3g0V0xXY1BxYXFaS3JWSWh3SWhxT0Z5RWlmdlQxcTllVkpB?=
 =?utf-8?B?OXJqL2IraVBhYkUxeGg2bXMxalBheG5YaElwQXI5blo1V1hET0pzb1VUMjJx?=
 =?utf-8?B?dkRuYzJJWDM5S21YanFBWmFFM3NFcEcyMVNydXRaYk83UUE4UlhQSlNTVXFH?=
 =?utf-8?B?N2xsT25jbVBZWlFRZkJNK29lZDJ5R3lhdVZTanhlT24yRGR6Mm9sY0xIN2xI?=
 =?utf-8?B?bWc5YkxzWURwWlYrbWxRejRJaDJiZk04VHJCSVJ0VC9FQ1dmdmRCNFRRazJU?=
 =?utf-8?B?RTRGMmZGZ2w5dHVMWUk1ZlBlUDFRWVlHdS8ybjNkTzYvazB5cG5BWWZxbENR?=
 =?utf-8?B?cTYxRzB5T0NZdXhSdnFGdU9tK2Zod2UwMUdpczNOMnczajZFVG1WWWY1VEFZ?=
 =?utf-8?B?UjlQVktHeFJ1V3V2YmlmNmxrR1pvekR4TUk1ZlZkc0tjTDNoemI4czExNlMw?=
 =?utf-8?B?NzlOcEFhbHgrT0lnd1JmNmpwQnhVb2M1d3dGNkZtV1RHaGdZcjJUVXNIeU5W?=
 =?utf-8?B?cUlTWU5MeFlvODhuenhaamdFR1ZlSUcyRzIyb3V4aytLaURpRFJXYzByU1Jx?=
 =?utf-8?B?WER0VXU2VHNORlQxUVNTUWVzRzlaUVI1V2NOWmNsM0xWeEVsNTcwR3pLM3o5?=
 =?utf-8?B?K0tWT2RLd2lDWnY1MUFvT2VlMzlTV1VwdXVvOUZxRmg2WVVLL1FmKzlPK2Zl?=
 =?utf-8?B?SlRtYm5UK0Q5KzRNN3Mxbk5icWVLdmxGM2NaOEJHK2hGcVE0dHN0OTdtRkdw?=
 =?utf-8?B?c2ZDTEhseVlPUU16MnIwZ0hsQ0o2bnBTSi84TVRVd2o2SjJzOHBoL1VZTEQ5?=
 =?utf-8?B?bW9XMTdGTk8rR1V3TGNGUERlUVJDQjVLL0tCRC9DM00zeVdvUmh6V3B3WUs3?=
 =?utf-8?B?cEFoWUhOcTY5RzlqUDU0SjdJeEZHaCtFVFUvaTZ1OGVoc2FQMEM2U1hvME8z?=
 =?utf-8?B?VHVidUlydHo3ZDBoWDZjY3MzNVEvMnUwM0ZOY1BqcFJhSmlBZjRBcXVnM2dh?=
 =?utf-8?B?QUtKQkZXd05vaW4xVmpvYldwTVE1RlVhOTBJN2poYXYyOHFEbGlBcWllUXJI?=
 =?utf-8?Q?W9VTkBz1GLABB1kp/LisQ/ilZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf98dc2-534d-40e6-d0d8-08ddad99c7ea
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 12:23:35.5272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2k1P4OakitZx2UWLIOhpaSkDtdBQjUxcGMpue/X/sKNDOm+51ufJ4ev7vu/9pQfoh0CMamOC/84acMAlsnSklg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7703
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
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

On 2025/6/6 18:04, Zhenzhong Duan wrote:
> This adds an new entry VTDPASIDCacheEntry in VTDAddressSpace to cache the
> pasid entry and track PASID usage and future PASID tagged DMA address
> translation support in vIOMMU.
> 
> VTDAddressSpace of PCI_NO_PASID is allocated when device is plugged and
> never freed. For other pasid, VTDAddressSpace instance is created/destroyed
> per the guest pasid entry set up/destroy for passthrough devices. While for
> emulated devices, VTDAddressSpace instance is created in the PASID tagged DMA
> translation and be destroyed per guest PASID cache invalidation. This focuses
> on the PASID cache management for passthrough devices as there is no PASID
> capable emulated devices yet.
> 
> When guest modifies a PASID entry, QEMU will capture the guest pasid selective
> pasid cache invalidation, allocate or remove a VTDAddressSpace instance per the
> invalidation reasons:
> 
>      a) a present pasid entry moved to non-present
>      b) a present pasid entry to be a present entry
>      c) a non-present pasid entry moved to present
> 
> This handles a) and b), following patch will handle c).
> 
> vIOMMU emulator could figure out the reason by fetching latest guest pasid entry
> and compare it with the PASID cache.

To aovid confusion, maybe better to say cached pasid entry. :)

> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_internal.h |  26 ++++
>   include/hw/i386/intel_iommu.h  |   6 +
>   hw/i386/intel_iommu.c          | 252 +++++++++++++++++++++++++++++++--
>   hw/i386/trace-events           |   3 +
>   4 files changed, 277 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 18bc22fc72..82b84db80f 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -315,6 +315,7 @@ typedef enum VTDFaultReason {
>                                     * request while disabled */
>       VTD_FR_IR_SID_ERR = 0x26,   /* Invalid Source-ID */
>   
> +    VTD_FR_RTADDR_INV_TTM = 0x31,  /* Invalid TTM in RTADDR */
>       /* PASID directory entry access failure */
>       VTD_FR_PASID_DIR_ACCESS_ERR = 0x50,
>       /* The Present(P) field of pasid directory entry is 0 */
> @@ -492,6 +493,15 @@ typedef union VTDInvDesc VTDInvDesc;
>   #define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000f1c0ULL
>   #define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
>   
> +#define VTD_INV_DESC_PASIDC_G          (3ULL << 4)
> +#define VTD_INV_DESC_PASIDC_PASID(val) (((val) >> 32) & 0xfffffULL)
> +#define VTD_INV_DESC_PASIDC_DID(val)   (((val) >> 16) & VTD_DOMAIN_ID_MASK)
> +#define VTD_INV_DESC_PASIDC_RSVD_VAL0  0xfff000000000f1c0ULL
> +
> +#define VTD_INV_DESC_PASIDC_DSI        (0ULL << 4)
> +#define VTD_INV_DESC_PASIDC_PASID_SI   (1ULL << 4)
> +#define VTD_INV_DESC_PASIDC_GLOBAL     (3ULL << 4)
> +
>   /* Information about page-selective IOTLB invalidate */
>   struct VTDIOTLBPageInvInfo {
>       uint16_t domain_id;
> @@ -552,6 +562,21 @@ typedef struct VTDRootEntry VTDRootEntry;
>   #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
>   #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
>   
> +typedef enum VTDPCInvType {
> +    /* pasid cache invalidation rely on guest PASID entry */
> +    VTD_PASID_CACHE_GLOBAL_INV, /* pasid cache global invalidation */
> +    VTD_PASID_CACHE_DOMSI,      /* pasid cache domain selective invalidation */
> +    VTD_PASID_CACHE_PASIDSI,    /* pasid cache pasid selective invalidation */
> +} VTDPCInvType;
> +
> +typedef struct VTDPASIDCacheInfo {
> +    VTDPCInvType type;
> +    uint16_t domain_id;
> +    uint32_t pasid;
> +    PCIBus *bus;
> +    uint16_t devfn;
> +} VTDPASIDCacheInfo;
> +
>   /* PASID Table Related Definitions */
>   #define VTD_PASID_DIR_BASE_ADDR_MASK  (~0xfffULL)
>   #define VTD_PASID_TABLE_BASE_ADDR_MASK (~0xfffULL)
> @@ -563,6 +588,7 @@ typedef struct VTDRootEntry VTDRootEntry;
>   #define VTD_PASID_TABLE_BITS_MASK     (0x3fULL)
>   #define VTD_PASID_TABLE_INDEX(pasid)  ((pasid) & VTD_PASID_TABLE_BITS_MASK)
>   #define VTD_PASID_ENTRY_FPD           (1ULL << 1) /* Fault Processing Disable */
> +#define VTD_PASID_TBL_ENTRY_NUM       (1ULL << 6)
>   
>   /* PASID Granular Translation Type Mask */
>   #define VTD_PASID_ENTRY_P              1ULL
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 50f9b27a45..fbc9da903a 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -95,6 +95,11 @@ struct VTDPASIDEntry {
>       uint64_t val[8];
>   };
>   
> +typedef struct VTDPASIDCacheEntry {
> +    struct VTDPASIDEntry pasid_entry;
> +    bool cache_filled;
> +} VTDPASIDCacheEntry;
> +
>   struct VTDAddressSpace {
>       PCIBus *bus;
>       uint8_t devfn;
> @@ -107,6 +112,7 @@ struct VTDAddressSpace {
>       MemoryRegion iommu_ir_fault; /* Interrupt region for catching fault */
>       IntelIOMMUState *iommu_state;
>       VTDContextCacheEntry context_cache_entry;
> +    VTDPASIDCacheEntry pasid_cache_entry;
>       QLIST_ENTRY(VTDAddressSpace) next;
>       /* Superset of notifier flags that this address space has */
>       IOMMUNotifierFlag notifier_flags;
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 112e09e305..c7162647e6 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -825,6 +825,11 @@ static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
>       }
>   }
>   
> +static inline uint16_t vtd_pe_get_did(VTDPASIDEntry *pe)
> +{
> +    return VTD_SM_PASID_ENTRY_DID((pe)->val[1]);
> +}
> +
>   static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
>   {
>       return pdire->val & 1;
> @@ -3104,6 +3109,236 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
>       return true;
>   }
>   
> +static inline int vtd_dev_get_pe_from_pasid(VTDAddressSpace *vtd_as,
> +                                            uint32_t pasid, VTDPASIDEntry *pe)
> +{
> +    IntelIOMMUState *s = vtd_as->iommu_state;
> +    VTDContextEntry ce;
> +    int ret;
> +
> +    if (!s->root_scalable) {
> +        return -VTD_FR_RTADDR_INV_TTM;
> +    }
> +
> +    ret = vtd_as_to_context_entry(vtd_as, &ce);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    return vtd_ce_get_pasid_entry(s, &ce, pe, pasid);
> +}
> +
> +static bool vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
> +{
> +    return !memcmp(p1, p2, sizeof(*p1));
> +}
> +
> +/*
> + * This function fills in the pasid entry in &vtd_as. Caller
> + * of this function should hold iommu_lock.
> + */
> +static void vtd_fill_pe_in_cache(IntelIOMMUState *s, VTDAddressSpace *vtd_as,
> +                                 VTDPASIDEntry *pe)
> +{
> +    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
> +
> +    if (vtd_pasid_entry_compare(pe, &pc_entry->pasid_entry)) {
> +        /* No need to go further as cached pasid entry is latest */
> +        return;
> +    }
> +
> +    pc_entry->pasid_entry = *pe;
> +    pc_entry->cache_filled = true;
> +    /*
> +     * TODO: send pasid bind to host for passthru devices
> +     */
> +}
> +
> +/*
> + * This function is used to clear cached pasid entry in vtd_as
> + * instances. Caller of this function should hold iommu_lock.

it also covers pasid entry update.

> + */
> +static gboolean vtd_flush_pasid(gpointer key, gpointer value,
> +                                gpointer user_data)
> +{
> +    VTDPASIDCacheInfo *pc_info = user_data;
> +    VTDAddressSpace *vtd_as = value;
> +    IntelIOMMUState *s = vtd_as->iommu_state;
> +    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
> +    VTDPASIDEntry pe;
> +    uint16_t did;
> +    uint32_t pasid;
> +    int ret;
> +
> +    /* Replay only filled pasid entry cache for passthrough device */

the comment of this helper already implies only continue if the
pc_entry->cache_filled is true. Also, replay is a concept in the
upper level helpers, no need to mention it here. I noticed replay
in low level helpers in other patch as well, please drop them as well. :)

> +    if (!pc_entry->cache_filled) {
> +        return false;
> +    }
> +    did = vtd_pe_get_did(&pc_entry->pasid_entry);
> +
> +    if (vtd_as_to_iommu_pasid_locked(vtd_as, &pasid)) {
> +        goto remove;
> +    }
> +
> +    switch (pc_info->type) {
> +    case VTD_PASID_CACHE_PASIDSI:
> +        if (pc_info->pasid != pasid) {
> +            return false;
> +        }
> +        /* Fall through */
> +    case VTD_PASID_CACHE_DOMSI:
> +        if (pc_info->domain_id != did) {
> +            return false;
> +        }
> +        /* Fall through */
> +    case VTD_PASID_CACHE_GLOBAL_INV:
> +        break;
> +    default:
> +        error_report("invalid pc_info->type");
> +        abort();
> +    }
> +
> +    /*
> +     * pasid cache invalidation may indicate a present pasid
> +     * entry to present pasid entry modification. To cover such
> +     * case, vIOMMU emulator needs to fetch latest guest pasid
> +     * entry and check cached pasid entry, then update pasid
> +     * cache and send pasid bind/unbind to host properly.
> +     */
> +    ret = vtd_dev_get_pe_from_pasid(vtd_as, pasid, &pe);
> +    if (ret) {
> +        /*
> +         * No valid pasid entry in guest memory. e.g. pasid entry
> +         * was modified to be either all-zero or non-present. Either
> +         * case means existing pasid cache should be removed.
> +         */
> +        goto remove;
> +    }
> +
> +    vtd_fill_pe_in_cache(s, vtd_as, &pe);
> +    return false;
> +
> +remove:
> +    /*
> +     * TODO: send pasid unbind to host for passthru devices
> +     */
> +    pc_entry->cache_filled = false;
> +
> +    /*
> +     * Don't remove address space of PCI_NO_PASID which is created by PCI
> +     * sub-system.
> +     */

I get why it cannot be removed. But I think the ce and pe field of this
vtd_as might need to be updated given it is supposed to be removed if it
is not PCI_NO_PASID.

> +    if (vtd_as->pasid == PCI_NO_PASID) {
> +        return false;
> +    }
> +    return true;
> +}
> +
> +/*
> + * This function syncs the pasid bindings between guest and host.
> + * It includes updating the pasid cache in vIOMMU and updating the
> + * pasid bindings per guest's latest pasid entry presence.
> + */
> +static void vtd_pasid_cache_sync(IntelIOMMUState *s,
> +                                 VTDPASIDCacheInfo *pc_info)
> +{
> +    if (!s->flts || !s->root_scalable || !s->dmar_enabled) {
> +        return;
> +    }
> +
> +    /*
> +     * Regards to a pasid cache invalidation, e.g. a PSI.
> +     * it could be either cases of below:
> +     * a) a present pasid entry moved to non-present
> +     * b) a present pasid entry to be a present entry
> +     * c) a non-present pasid entry moved to present
> +     *
> +     * Different invalidation granularity may affect different device
> +     * scope and pasid scope. But for each invalidation granularity,
> +     * it needs to do two steps to sync host and guest pasid binding.
> +     *
> +     * Here is the handling of a PSI:
> +     * 1) loop all the existing vtd_as instances to update them
> +     *    according to the latest guest pasid entry in pasid table.
> +     *    this will make sure affected existing vtd_as instances
> +     *    cached the latest pasid entries. Also, during the loop, the
> +     *    host should be notified if needed. e.g. pasid unbind or pasid
> +     *    update. Should be able to cover case a) and case b).
> +     *
> +     * 2) loop all devices to cover case c)
> +     *    - For devices which are backed by HostIOMMUDeviceIOMMUFD instances,
> +     *      we loop them and check if guest pasid entry exists. If yes,
> +     *      it is case c), we update the pasid cache and also notify
> +     *      host.
> +     *    - For devices which are not backed by HostIOMMUDeviceIOMMUFD,
> +     *      it is not necessary to create pasid cache at this phase since
> +     *      it could be created when vIOMMU does DMA address translation.
> +     *      This is not yet implemented since there is no emulated
> +     *      pasid-capable devices today. If we have such devices in
> +     *      future, the pasid cache shall be created there.
> +     * Other granularity follow the same steps, just with different scope
> +     *
> +     */
> +
> +    vtd_iommu_lock(s);
> +    /*
> +     * Step 1: loop all the existing vtd_as instances for pasid unbind and
> +     * update.
> +     */
> +    g_hash_table_foreach_remove(s->vtd_address_spaces, vtd_flush_pasid,
> +                                pc_info);
> +    vtd_iommu_unlock(s);

just realized s->vtd_address_spaces is not protected by iommu_lock. If so,
will it be ok to drop the lock here and add it in the lower level helpers
if lock is needed?

Regards,
Yi Liu

