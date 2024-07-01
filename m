Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC10C27C4F
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 01:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO5uO-0002po-A6; Sun, 30 Jun 2024 21:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sO5u7-0002k0-1q
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 21:32:29 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sO5u4-0000H1-1N
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 21:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719797544; x=1751333544;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7If4NSlllLzHWEwnCiOgojdGBVRlkeGtgv+VV/LF/7Y=;
 b=N7Wge9pXesodyY4HtUvm2JpVk86/okEiZyWnrLZx3BvleS0fDD/5/ODD
 nK70g4Y3+pmAybs7D1RHeu2auNQ4gOvUfDlLawoX2hQzFR87nHZlHWv+T
 vBYhKCXDj7XuetMXtQPwkdexOJUxVIL0J7pAvTVcwg8y7J/xQSEII+Wq5
 KpTt96KjasFIg3G5m+mArycFjq2tKNPxDMHptrtrcfcImrPFAQFgHaFVN
 PVdbH3DH4xmuUVyN5PyPfWFUd0LAjIlaa2d2yiqWMfkDFUlA7rZBuaMdL
 Pi2wRG3xgP9LSqooxvfLZTa9cZr+8eETYhfIw5G4pqcWbDxw4pfxxzRJQ Q==;
X-CSE-ConnectionGUID: 4MXG7xEKTOWMGTiHgJwtzw==
X-CSE-MsgGUID: ExOMPAOqQqOW6IG77cxqLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="27585724"
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; d="scan'208";a="27585724"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2024 18:32:20 -0700
X-CSE-ConnectionGUID: 8akRczIkSF6m4FtCgmwXQQ==
X-CSE-MsgGUID: 8k2MbC9+RGmSd/nf6CmOsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; d="scan'208";a="49948910"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 30 Jun 2024 18:32:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 30 Jun 2024 18:32:18 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 30 Jun 2024 18:32:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 30 Jun 2024 18:32:18 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 30 Jun 2024 18:32:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYa3XFOt2B+5MuAKfqevAqhrbRQP50JFIw+AHsUTjlzF66N3uHjnoH1DgOoLjNSc5e3JTUj+JRFgGxUi6NP+TIdwsWJiJjbJywtrdwqZYtLUmCW6fafvfvlZaX1w3iNjh5aHIfdDlnMZewpAUo/X7nMprcSbAXnk6fpaqf5rD9nhc8KPtGLIOwVBekvG09J5VhQF13EI/P5QlmNqoCx7py+sjJZKXZe9boUP5JkGr/GI6YEpZKn6s3AWA6OEdwbbnop+mJGlFxmQSSGfh5vpJc4hfIQL6szACddwUQ3iEjzu9jCVXw0cBuwjGSMx0f9sRRgEULb4r2zz9RDzP1boSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIBpbJ2LxQH4BmNWs92CJZLtoVnh9VShpzxdeS8fLOg=;
 b=EytncEEw1HOilh8KZ4c/S32N3eAHbhYjCjVVpZsECPFCENVrQsykwxQnH8S6StU5VWjM7mqzAI/iASaVLMhwJ9ZW6NKMZljbZAe5oFycDNaNYlUNKAkO2hIugGcUVst4ToxUmMtglCQ9WLVO0UULd9T8gJkpAv8zjfDMBf3kyjt1+T5O7WoNE52h9gkyixi7koM8deZqS2utyKV8HUl8DPx81acl+xY3G11cwUSdX2gGUJsHDK7NwZqV+V2O46gl+76Ovqi3RGCsXttBPlE1W4gAviUCTTsXmB+zxd5jvPV6OqdR1SNKhefxHAVqhh9Rpf+oQMfH+sNNcIplJbHsNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MW5PR11MB5786.namprd11.prod.outlook.com (2603:10b6:303:191::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 01:32:09 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7719.022; Mon, 1 Jul 2024
 01:32:09 +0000
Message-ID: <e1b86a6e-9f71-28fb-1788-38c725165be7@intel.com>
Date: Mon, 1 Jul 2024 09:31:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] vfio/display: Fix potential memleak of edid info
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
CC: <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <kraxel@redhat.com>, <chao.p.peng@intel.com>
References: <20240628092815.164423-1-zhenzhong.duan@intel.com>
 <20240628092815.164423-2-zhenzhong.duan@intel.com>
 <CAJ+F1C+UAGau1W=Tbztx_tuhwEatmDA-DwxVwsC3UCA9rf9=VA@mail.gmail.com>
Content-Language: en-US
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
In-Reply-To: <CAJ+F1C+UAGau1W=Tbztx_tuhwEatmDA-DwxVwsC3UCA9rf9=VA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:4:188::7) To SJ0PR11MB6744.namprd11.prod.outlook.com
 (2603:10b6:a03:47d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB6744:EE_|MW5PR11MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: cf166afc-307a-4a6c-e693-08dc996d9fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnBDTDYzRzRHZXo5djI4dzdqdnUweEdydUlVNC8xY3JvUzR2SjJ0K1F3b1lI?=
 =?utf-8?B?VUd5VDlHNlJBU1luV3BwM3RBUUlPV0NubVJ6QnBERjd0SWt1c1IzTmhiK2sw?=
 =?utf-8?B?bS9pNnphZ0ltTmVrWmhHWEsyU1VGNWtrSHVHMEJNcGxCUVp3a0NNMGRoMW5j?=
 =?utf-8?B?MG1DS2ZReEcwb0wxenJpWE44TXFlODZqM0p2U2swa3M1SlNjVzMzOVJHMW5I?=
 =?utf-8?B?eTZiMllBQm1yOGlLMGY4aTlvaU5zN2ExRDdhelIxTkR6a0g4cmNkcEdUU0xG?=
 =?utf-8?B?NTQvcDBncXB4QzM2S09rekpkSG1UYWlINTdjL0hSaUtseFVCdE1nK0E4bFdr?=
 =?utf-8?B?dFBHTTFSSDdXWXFJenlOeTh1NmtsZXlkWUdxVGUzYWRud2djS3hTOTlPYnVt?=
 =?utf-8?B?aXVRS0JVWWNXYllhYkYwV0g3OCtDR0REajk5RVdlMUlSQTAwUi9DWG9NN3dB?=
 =?utf-8?B?RWJhOWVqbmIrR2NQV2w5NFNzdVVRcXZTVzFUMjVHRmZOZG81bExYV0dGWnJ0?=
 =?utf-8?B?ZXQ5VHNFK0M0eFNHV0t4ZUZDUEV1Y2oxUDA5UmFZY2VRaWRXVWpCVk9ZbE1R?=
 =?utf-8?B?d3E5aFcwRzE3MFp4THJ1Y2NaNU1tRUo0aUtGRyt2SnpnOHdIam56NDBaZW5V?=
 =?utf-8?B?SS8xV0pxZW4yNU9IdEpOT0hUdDE1S3FWb3hrREQrTEkvVkM5YXhMTmtndndL?=
 =?utf-8?B?ZGExdzJpM3Q5VVNyMG04VzJHMnE3ejZ0L2N6VEE1RUYwQk9RUjU1VmFjRTZO?=
 =?utf-8?B?dmRMeHlOQkNUZ2huNzN5eVVYTjVvV0hoMnpQVnpmbEt4OUx5ekVMbHdFYXRD?=
 =?utf-8?B?UTN3SnVVbjExczl2YUl4ZFcxNCt6bmQ1eU4vam8rb2RQTUJtdG82VHBpT0dN?=
 =?utf-8?B?MkJCY1NmVUJLWmt4WTg3ZlNXNXRycVNxMStGWUZ5bHQwcjZTYVY2SFpaRmpr?=
 =?utf-8?B?ajB6bUQ2b25KTSszeC9CWlBkSm9Vd3V4bXFYT3kyaS9TMXlBRk5TampKdFNr?=
 =?utf-8?B?VDYvR1pWb3BxT000UW5iWEQrUko3RFdJemdLK0pKNm5NOC93b2NsVHBxdnlJ?=
 =?utf-8?B?Yjd3QzJDOUdwdHhKN0x0MjlGV09EK1AvOXVrZERiZThTeDdRVGIzRDAwNUNq?=
 =?utf-8?B?cEFGeWJKVkMrZjVSVVhZRi9wR1VOSkQyWmVVdnVET0ZDRnRHSDFTeG95aXc0?=
 =?utf-8?B?aUVZSWRISE91Z2k0Yk5qdVROajh4eGFwSWZsMk5zd2hNTERCNlhvUzN1WGpP?=
 =?utf-8?B?cjgyQnlzaW9lTDN1R0lnRXo3OHRPQ09ZbExpeDN0aS9ZR3VEYnhpUjV2SlI0?=
 =?utf-8?B?QTdobC9qdUFQNW5IOGs1SGdXYVFEdTc0K0NyRm5qcGUxbXRYSmhEZjZuc0RJ?=
 =?utf-8?B?MGV4cTdBOVhkUkoyalljNnRVOTNTdUlqdVh5NFlTR0QzaTBPSWJTbW1xOGx4?=
 =?utf-8?B?UHNhWVQ4MzM5YjZuSVBLZUlXbDZsQXA0SVZhYnNBODdyWE1VODV1RzZaNVY2?=
 =?utf-8?B?V01hVmpwSnVHeEpzUG9JTHR0UkswRG5uVGNkRnpPclNLQ09uYjJRZGZqT0c3?=
 =?utf-8?B?TzhmVnlBcE9pdWd4T1lBQWpVbDhzcWJ0QXRPdXBqR0M1Z0hDNjlwZk9XcXRU?=
 =?utf-8?B?MWx4d0IxbzRHckhIL214ZmZJMCt4WHFHWm9uZ3psbWI4aFgwaE5rR0xXNTlI?=
 =?utf-8?B?Mmg2eHZ3d1RsN3dSVjhRZVFleHErbklIQnBNbFBNWDJVTVc2UExSZElYSUd4?=
 =?utf-8?B?N1IvUElnYkE1cDZKd29nbnVDS0ROK2FLU1lvR2dFa3c1RVJlTjNLSlhZRTVl?=
 =?utf-8?B?Vis5WXEyaGFsVzc2TnYyZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WndBaVFIbjU4OG9rSmhsbHZrcHdJUGgraFBSbm9vRkh3dW1PSXFNM0xIbDdl?=
 =?utf-8?B?WHlwUGFiWisyczJTcS9VMEQwM25KYzZWcHFWaGlVU1ZGNVpBOVFJVkl0ZDBM?=
 =?utf-8?B?TGVxNWZzb3Nla3kyWVRtL3pGM2REbGpqeHkvU1dHc3RlWWdUZUFXU2xvZUhu?=
 =?utf-8?B?VHcxVlI4cTgyWlF2cjhxRWdsdHpweVlWWFVsbitwMnZ4cW81eElNUEFFeDBI?=
 =?utf-8?B?MlRkeGxGNitIRGlpMUJNeUwwYk9qckVZWGR1Z25YL1E4elB5SnFJYlhZNnNo?=
 =?utf-8?B?dmorWHlpaXcxcWNRVktMczJyb0xKNlgxMWhUZDZWMGd6Z3psYUJ0NTBNUU8z?=
 =?utf-8?B?QUM1TVMwWkdoQnk1OEZFTlI2djhUbGYvb3Y0cGVObXJRa0lpcExpUURtMFIv?=
 =?utf-8?B?VDcvaXFEVTNsOVZEUWJYckw3OHFVNjNrdDJsUThoQ3lldFR6VkF4TWJuZzNx?=
 =?utf-8?B?emMxdUFmb0krNEZ5MVNQbEpwdWhVWUlOOGxEaXRlZjRNZ2trUCtGbTd0bys0?=
 =?utf-8?B?QnMwSUFPWFV0STZ5Sml5Q2VicnF1ci9xZHhYb0FmZU1xT1FtVGczOUlLNUFB?=
 =?utf-8?B?TmpPUWtKZmNNd3ErOCtTakFwRlJTVnpQYlpITnJ4bThxNFlHTHhkWWxYUVBl?=
 =?utf-8?B?Zk1EOERVODA3NWtWc2dKUHM5alBzNmFWOE8yekdSd2NJOGFhb2sxNUZaY3R6?=
 =?utf-8?B?TmV0SitFWkg0ZmdET2x0YVpkUzJSdUpqQmZMNXdEWlZMTGI4TTFRaUpmMklj?=
 =?utf-8?B?d2Z6UzdMaG5lODNxcnFIUWtEVHI4SkdMWDVDczJLTWpXSTZQaWVaVk1saG1R?=
 =?utf-8?B?SDJ6ckZEVjg4WFNFdEYwY3ZKcVVjbnBrZG5lbmxYTGJCenJzNEtkTkQrSEV5?=
 =?utf-8?B?L3plU3J4UU1MemVXYnYrNXN5dnNSeFF0Y0dmMS93Njd3ekRlYkxteTErTHFw?=
 =?utf-8?B?NDA4YlZMVzJSWFc0NWlDMU56Qk5nTzh3V3R6L1FkTlR4S3ArZk12NlV3MGtG?=
 =?utf-8?B?OUdNdHZvVmkrb1JVMWRRZDZ4U0JPOWZiTzBHRlc5eWordXJNY3JOLzlJQkh0?=
 =?utf-8?B?NUZocFYyWGZUS1FPSlI5UHA0UE9uTnFTNDNNb2xzOUQxMTlOSlp1Qk5LRElP?=
 =?utf-8?B?Mmtnd01BNU9Wd244SitXSkY2bERRVFFPOEtpdG5NY1FWSjZTYVBxalNjdkhL?=
 =?utf-8?B?YXBnK3pBMGpQSFZmUXJOQTh2ZnJuZWlDZldQQWJqSnNLb3Bkbys1Z3hPYzg0?=
 =?utf-8?B?Ny9FY0VTNTVsYTN4RDcySGFZWHFQSkxVelZKcWMvZzR3bkNDRzVjbzI2eThV?=
 =?utf-8?B?ZUwwdUdUM0ZVUUkzZHhIUE9Vc1ZXWEZGaVhQdjNYZm5OTHdvQWVRWVUxRUdk?=
 =?utf-8?B?eDZzSDMwKys2R1lqOEpjb2V3SHl6RlZ6VWFRZHNsM09DU3FPOXlKQlhKQ1Ns?=
 =?utf-8?B?N2ZRNkdkdVdXaHFWb2RjT3hqWmRqZDBKRzR6TUJ4eUJndzRkbWRRYzdlWkhF?=
 =?utf-8?B?UzVweGMyZ0IxSG80Qkx0S09DR2c4NS9Ra1lpYlVoWTN4YXBvc0ttNHRhZ1JD?=
 =?utf-8?B?Y3F2eExKQ1JRUGZrSWM4YUtnelNXOFpvbm12VUFFazdKbDJRN0c0NkgxRVF2?=
 =?utf-8?B?L05Ub0R5ZG1WbnZGbGlxcnN3TFphUE5VaE5EVlFJak5GUlBFa2tOSjcvYzdZ?=
 =?utf-8?B?b1p1UlNLbzRKN1Z5UE03bVJ0emE4NS9TOE1NMUdXRlk3SXdJOHNEc0ZTWDhv?=
 =?utf-8?B?V3ZESTVVTW1lK29uaFNheitoN0ducTF2VDJ3TG5RRzBMSWtDbTJaZkhaRmhh?=
 =?utf-8?B?YzdPdkVHTFpIdmp6REtyb0lTWUNxZlZJUVgyUnNGd1lqSFBWOStaZHlLeFVp?=
 =?utf-8?B?bWY1KzZNZDlkSmxiN3ZPWWVwVWY4Sm9KQ3c3TWFFTmxaSlRjK1FmdmZBdTg5?=
 =?utf-8?B?MUZuK0xWUlJxZjVKSEJLcncxM1ZJb0gyKzNoRzFtK3FqS294OFdmcTJ3V2sv?=
 =?utf-8?B?ZVV1bFpnOGw1NWR3eW1JNldIZFM4dm5tNFduUEFrWG4vaVN6TG1ReStyNkVY?=
 =?utf-8?B?cDNtRGd6NkJFLysreXFzZFpRRlZMRzV1dC9oZnZ3a2JkTDE4dk5Qc0o4MGE1?=
 =?utf-8?B?UjFmb1VhMFhWQ3kvd0JlK1EwS0VSdGxsREk2QUhDNE5PSTBQWUt3MGd1aXZq?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf166afc-307a-4a6c-e693-08dc996d9fd3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 01:32:09.4625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nnHlz1XtBpwDWgOEjdzW3OTPmaea/BY61owEOj913TCkgOzlSHnQ6TYKWcqZGjOA52jirp9KDirPFhYkeYEVDQsWo3uN6iW0uakD7NIpIYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5786
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.587, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi,

On 6/29/2024 8:15 PM, Marc-André Lureau wrote:
> Hi
>
> On Fri, Jun 28, 2024 at 1:32 PM Zhenzhong Duan 
> <zhenzhong.duan@intel.com> wrote:
>
>     EDID related device region info is leaked in three paths:
>     1. In vfio_get_dev_region_info(), when edid info isn't find, the last
>     device region info is leaked.
>     2. In vfio_display_edid_init() error path, edid info is leaked.
>     3. In VFIODisplay destroying path, edid info is leaked.
>
>     Fixes: 08479114b0de ("vfio/display: add edid support.")
>     Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>     ---
>      hw/vfio/display.c | 2 ++
>      hw/vfio/helpers.c | 1 +
>      2 files changed, 3 insertions(+)
>
>     diff --git a/hw/vfio/display.c b/hw/vfio/display.c
>     index 661e921616..5926bd6628 100644
>     --- a/hw/vfio/display.c
>     +++ b/hw/vfio/display.c
>     @@ -171,6 +171,7 @@ static void
>     vfio_display_edid_init(VFIOPCIDevice *vdev)
>
>      err:
>          trace_vfio_display_edid_write_error();
>     +    g_free(dpy->edid_info);
>
>
> It would be better to set it to NULL.
Will do.
>
>          g_free(dpy->edid_regs);
>          dpy->edid_regs = NULL;
>          return;
>     @@ -182,6 +183,7 @@ static void vfio_display_edid_exit(VFIODisplay
>     *dpy)
>              return;
>          }
>
>     +    g_free(dpy->edid_info);
>          g_free(dpy->edid_regs);
>          g_free(dpy->edid_blob);
>          timer_free(dpy->edid_link_timer);
>     diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
>     index b14edd46ed..3dd32b26a4 100644
>     --- a/hw/vfio/helpers.c
>     +++ b/hw/vfio/helpers.c
>     @@ -586,6 +586,7 @@ int vfio_get_dev_region_info(VFIODevice
>     *vbasedev, uint32_t type,
>              g_free(*info);
>          }
>
>     +    g_free(*info);
>
>
> This seems incorrect, it is freed at the end of the loop above if it 
> didn't retun.

Good catch! Will remove it.

Thanks

Zhenzhong

>
>          *info = NULL;
>          return -ENODEV;
>      }
>     -- 
>     2.34.1
>
>
>
>
> -- 
> Marc-André Lureau

