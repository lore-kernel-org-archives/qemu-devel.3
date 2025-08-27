Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004F0CA0FF7
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 11:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urE03-0001cd-JH; Wed, 27 Aug 2025 07:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urDzu-0001a2-5T
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:07:22 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urDzq-00072X-Pc
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756292839; x=1787828839;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cdpUs8p/6/KtZ8CYyLELtVUrskbCsGypl1mXG7eWGeE=;
 b=Pc25mzQOR6TwSI26DAZhpMUPEghTTc+cw3JrUHrLFhr0Ni9rjuvLWemp
 TlQ8ThrgljrJ0z2pPanUAtD2zmPgGyhz9z6zKpAqaJAVBTkY+MO3IuOcw
 kkZjnzqOYQnXiq4Oiro3NlSjC+VJzURxSHijiuXv0kITQ8G/l9pdCQbaa
 H8khDZS3HxFnANe/xKiP5fI/4u/9jzOq7PHGqCJ7VDWrBrQPodAzvb3K0
 6thsiqaJd+pQ7rEFaSO/7kTQtA3DHLXDRp9e2WeCXs9ICJwQYPRT1/FGJ
 2Tm61bjFy23+2ym4Fw39D4hzDsdJPKsGmxNOkmWTmYpr3pMqyyUhrx45a Q==;
X-CSE-ConnectionGUID: 0Mjz7xBkRNydCW8E/fI/Ug==
X-CSE-MsgGUID: H4qT9nS3TfK6pWa57mPJbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="57743374"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="57743374"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 04:07:17 -0700
X-CSE-ConnectionGUID: wdGCRNYqRpurvrruBvdqkA==
X-CSE-MsgGUID: QMX/FbUZTIiNFD76BhTfzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="169754048"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 04:07:16 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 04:07:16 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 27 Aug 2025 04:07:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.60)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 04:07:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1b5PLyOOz0Qn8sn61Puk9wpknfGCMG6s7Jzs3ZM49tQNfeIAceUq45vaM7Uo1TLnIECdhpePinqrqf/SWtpLVjxbD7uU3RrjD4BoeWwb85rBXJkRRNcNyKu7uAC8Bu9u67gNREjDI04/zBbbajrno+faaaNWdSCQ6aoQQyu8K1uGVOTE+vJWN2aVIc4af+tACpJhEivUHS/hwkEQ1wyMXyZUPSiRZjJcNSZ9DFSsAwKPi89g2QicXpi4Rh7XVMTo89RqUmbZ11jfaTLL1X0oCxSrIgth3qW/KwAKjmo2xphKLtQrdgahB9EJRK/f03MnoXQDaO34jCL58tuMxOMCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZdTY87KUuLLHYX8R9wmIkR8RVEF7AP98adPrJ1FFQo=;
 b=xTwkCUNxqZdCDF782ozL939phX6wnbqjh2SWi/BxObQCivrYvlXebESGhYA3ncD6o8ZiKIPuWH0SEs3OZV64KpyraZ7SfdFXtcQAlzbOz6WDL9ekTjNPd8u2Dl1fcVNAuGiyUgya6no8L2v2oo4+2OWIXbETp0/oLFe/AHHSsvWSPJIRtdT6gllYvy9OTqFp6dAjwTrQJH9P9gYCKyxGwXGIrsQeRRi1ovMiEZY/6UH4F7SkK/ycfUUx9rr9LQK6ThkZAmyiKC6V/n8sA6Z5qJhtY2UMsheVcDwwluMnnlqeKpG6ytHGqg2NY6LjxSykdHw0LbXVnYB38eI6EIE26Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by SA2PR11MB5082.namprd11.prod.outlook.com (2603:10b6:806:115::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 11:07:13 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 11:07:13 +0000
Message-ID: <32c0a5e1-6529-4978-a0e1-32940e806dc0@intel.com>
Date: Wed, 27 Aug 2025 19:13:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/21] hw/pci: Introduce pci_device_get_viommu_cap()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <chao.p.peng@intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-3-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250822064101.123526-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|SA2PR11MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: 019f8050-1834-4378-3fb7-08dde559e054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|42112799006|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2N4WVBlbTQ2VUg0c2RFRU01NFN1MTNibWViWFpWZVZOcy82K2tNTkhpRTdC?=
 =?utf-8?B?ZE5CcE9vbDhTbzdyMjV5WURRUTM2eTRxbkhjMnlUTHhRdHF0S1FjMDk2YW5E?=
 =?utf-8?B?dUxtajlzeTVRcGc3elNPK1lid1NYRTdRYmxXNGY2U0JsOWxuSDlycy9ZblR3?=
 =?utf-8?B?VG5nOEY4bnY2RHhkT2xaZTZpZG5ZczVQM1dQd1VPSEg1aG9EUThVRWdiUTlO?=
 =?utf-8?B?Rk10QTJuL2FBT0kzMVdIbTA0UVVTZEJPcEFPUVI0U012eG5XYkZ6UFVoU25N?=
 =?utf-8?B?WkxaZzFzc0RnWm1FdGFoT2FSM3A1ckl0T2VMY2R6MklKRENWVk1SakJ3MVpk?=
 =?utf-8?B?ZXFpalJpSGFZZmE1U3BrdXZZcGMxa1Z3T3NuVCt5c2VDb0RZVXpubElyeUtK?=
 =?utf-8?B?Wkoxb3FzSmZMWlpLUmN2cjZNc2pMS1Jhakpqa0JWUHI0RUVIT2wwNjU1M3My?=
 =?utf-8?B?NTN1L1JMd2NKQ2pxeEY1M2lnaEt3VFBVaUNHbUcwWnlxOWFNaTdSUTd2eVhw?=
 =?utf-8?B?S1dlUXoxRStNak82bTZLZVNqZVIramxLdm1ERjVMQ2FsY1dvdlppYldYWWk0?=
 =?utf-8?B?Y3pGYVpQWlJWUWxGZmxlNFE5WjVpWk9IOFBFSmQvTFlKcHFTcHZkeEZlTlRG?=
 =?utf-8?B?THZBRHNMc1JtN0d1NXdHbEh6T2JYTnJwRXdtNUc5M0dkWFl1ZE02bUlCKzl4?=
 =?utf-8?B?cnNsaC9DZjBBbnJsdjdUSWIxZGJXeVlhT0Q4STJaYThVRktITkR5MHlUMWRB?=
 =?utf-8?B?cWIvalRWbWlJcU9XOVhPWTlpM1lCWE9mL08ybHFJZk8xOVptR2xUN1hQbVV1?=
 =?utf-8?B?NklDNHhUZ3VxclRvME93amJheXpiaTZweGVjOTJTWVZmNVBueTUvb3VpaUY2?=
 =?utf-8?B?dEVuRjZ4N25UMVMvUHFxcE9RZ0hWRmJzbHNpRkNBb3lvYTBkcTRZV3RrZ3RY?=
 =?utf-8?B?dnVDWFR6VHc5eks1cU11Y25WUlFIV0hnNmpYUmFsZDltdVMyQVhyWVgvR1NC?=
 =?utf-8?B?OWN6anBoVlczSE1kUndwM3pnMDRBdWcrRE9GYjMwVjUzendBSm45bXlqMkxh?=
 =?utf-8?B?NXlQdlJKK29IOEJDcVo0V3BHSTJ4dmRrb1JMbjY4eDdJbTlXdE1QQm5RNXkx?=
 =?utf-8?B?TURuWTNqOFhaU0dzT1E0c05ZbFl1dXM2VHBxMmNCdG9kdlhTYUdYQVhnUmdn?=
 =?utf-8?B?Z1VFSy9kRFZnUTE1MkFyc2k2aG54WjlDRWhzTUd6a1JFWHhTMjlBcS9pYjkz?=
 =?utf-8?B?dHdHTm9mdU0wcGxJQktoVk9PbWwrMFg0eHo4d0hVNnNpZlZ3YjdaUmFiV20x?=
 =?utf-8?B?OWh2eEl6THJ3bzB3SjFSd3JKSnVPVkZ2dHJacWdzM0ZrRUVySGtQNlE5V25E?=
 =?utf-8?B?WkxPMkhPUGYramhWK1NpVHFYN3NXUEtqeVZiVUlISGtGNFRYR08rd2IrOERV?=
 =?utf-8?B?VENZSGhhVlU1Q3Nkbnh5b0p6RTZwWjdTUVJqZ3FCN0d1dWVqY1V3RGNqSXNH?=
 =?utf-8?B?dlY4cTZOaEViOHJLZkx6L3ZDNlovSXYzSEYwaUV5ZkI4RTdoTFllelNsdk5X?=
 =?utf-8?B?QnlFVnF4U2xTWEVWRzFoOSttZW9rc2ROTFhFRWk3ZFk0QUZGRDZXTFo0ajRh?=
 =?utf-8?B?cjhTemIwbXI3cEJRQTRYajR3TmVCd0c1ZWN2MVdQNFM5RUd0YnlVNU43UVFM?=
 =?utf-8?B?T0RCNjNiNlpEWnVETmtkeVpWdnlLQmpCQkdNM0tHdUl4V2U5T0lpckcwM29V?=
 =?utf-8?B?cWdhb3FmRVdUMUROYS94dnRhd3pvekk0ZnZsMnk0ekFwcGNjTFM3Y1hTNXVn?=
 =?utf-8?B?VUZSZmR4WmwyaW05U29YMFlvUi9ZcnpDaUJ2Mk1XdFJZWHJHYmFTMmRHdWd6?=
 =?utf-8?B?YWFHWEYyNkZFbUQxUVhmYzd0UTRWdDM1bmZDQ05vNFQ1Y2ljL0RBaE1OdFU0?=
 =?utf-8?Q?l75g3xMTlqo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(42112799006)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enZad2U5S3lNSU5HZ1RkVXRwbmlkUTYvU2ZWMWxHcWNSWXp6WGlFenFUQmgv?=
 =?utf-8?B?RXhSc2xBWDQrSVJ5NTVpWkRPQXkxbS9zRWFycUxjcHc2Y1Z3cElnL3Vkc1Nq?=
 =?utf-8?B?TzVRVW8xT2tSTTdvNWw2MzljZnRDNzV2c3UwZ1E1TkZEdVVkSDlNK2s3OUUr?=
 =?utf-8?B?RmlDMlpaWnM5RTBMQWsvbHk5WWNQQkRIdVZWRVk3YXhwamo5d2JYaEFXdVRU?=
 =?utf-8?B?a2hsTEVTSkRjZi9nNjdGbEtHTldSZzRsVkxucGEzK0lzU0NrYXljS2o5bW12?=
 =?utf-8?B?NVRYZmRlQmxsOGkwQVBPMTZSWjl6OGpURVBGT09oNWx1U3RtY3Y4K1c1blRW?=
 =?utf-8?B?TFB4RmtvV2RqMWs1WExjNnRWcXpvZnBXK05jcy9lUDRUZDdqZDhiTTRaVXpW?=
 =?utf-8?B?VTVuSFIwQ1JZM3BPVzc5dFpyb01EVDVKT3VqRWZoSm9hRmdUWUZ6a1BHYnNR?=
 =?utf-8?B?Z09kdzUrQlEycEI2T0ZhS1JtWkpPeGt0Y0FHaVl1M2Z1TGZMcGUxOUV2S1NX?=
 =?utf-8?B?ZUJvTGVDWVdkejJNZWtCMlMrSS9KWnJoR2ZMemVuTGlIcVZqb3ptNFp5T0Vt?=
 =?utf-8?B?RThvajZPbzZOaWRXT2p3b29KT1ptQXZlaFR2VnErYy8raDMvRm5seStMekdD?=
 =?utf-8?B?ZXdtd05WcnZYU0Z1VXAxUmlLa0x5dTZtNE1lSUpIaUZWdUVGVlVGR2FkZW5a?=
 =?utf-8?B?WW52UzBWSXoyOEYwSGFFWlhjZXpoWU1aUzFHRXFxUFc4aWY2eUpNaTRqV0dp?=
 =?utf-8?B?MUFXN0RRMjVwR2hGdGxSekNGUjdiVGdxMEtOQzFvQkhpNFlBcmFaL0U4cWxj?=
 =?utf-8?B?b1VYSStQaU0yQ2YwWlBxdjBxM0hpL0xaQzYrT3pISDFQcE1Edk1EMTNWSjJi?=
 =?utf-8?B?dFhiUkVwbTloclJEQVFUVkVVUHpBTEJXOTR0dWtJS0FDYTBaOU5sTTAwY0J4?=
 =?utf-8?B?T3NKNWU3TGxmUFo3cWtXTzJKVzVuM3RsdzhScHJFTlY1UmhSOEZ3STUvcEQy?=
 =?utf-8?B?cWtzU0craWdKMkJzSnp4ajJ3cUN5T1hxNlhNVFN1M3Q4V05mWDNwYUFDeTZO?=
 =?utf-8?B?VjZnRDRIQXRlemxBSjZPa3hrbE14bXJpK2l1MEV5R2NMSjVqbXZ4cXdwSlBU?=
 =?utf-8?B?LzV2bnFhZ2s2SHVxYUlZb010RUprQzg1a3dLQ0ZFR3ljMFhzNzJlS2wzZEVG?=
 =?utf-8?B?THNYNXdXN1pwdS9rcExnTlZxY2tOdGMxc1VaeUpoTG96ZEhUNG5ja1JFSzgv?=
 =?utf-8?B?aFk5MnlFb28vOTQ1SDlnRzJBcmp2NlBHNHVrdEhxT2dOTlR2eWlnOFdLREs0?=
 =?utf-8?B?T0VyYkZYM0ZnYjBXZXU0ZlVIMk1ubTltSng4N1V4Y0pDN1ptR0U3WklnN3dP?=
 =?utf-8?B?bkR3WlRZY0VwSUxTVHI4RGlCd094TDYwRUVBdWxxM3diOTZ2WlF5amNlQ2dB?=
 =?utf-8?B?bDQrcVZFblY4Y2RUZi9UNlovWjZZaGNiM2FRcUk4SDQ3N0VSdlA5Tk9aakt2?=
 =?utf-8?B?WTlDbVRRS0lhcWJUUE5kR2FpdTYrd2cxa2JkeDNkd0hFMVRjUllzYjNJQ2lh?=
 =?utf-8?B?eUM0ZXRselJxWkphL0kyTGxlYkliRkF6MFdKbTRkMWxDQlo4TFNBdmMwMGg0?=
 =?utf-8?B?ZGQ2VWl3bzVEc2NZTlBCSFgyM3pHendWNFVjRFE0QjdxZTVhQ0J6QkxzcEkv?=
 =?utf-8?B?NWREU2o1ejJrZjRXYkhITk1QcVJlMXptazc0bWJJTU5aYW5FNWRQZUoyS3Bq?=
 =?utf-8?B?dEhwdnN6UTdhUkxialRyeWhhdlJvVXdia2tsS2Q2c0F2TVNhbDcrZzF1WGp6?=
 =?utf-8?B?cC9aT1J4UzVYVjg3YWJlcEFYOHJLZ05jMXBuK1JqRGd2ZlhtRHp1d3Nacjhr?=
 =?utf-8?B?S1RLZ3VOSEhDbTd4VnJJek5ONEdycW5MQk84VVJhbjhHc29Oby81OEhvYjBU?=
 =?utf-8?B?SzY1aVd5QmF6LytCS2pGSTNiUmhqa0V1MlpFdURNS1ZTTndBa2NiQUJ6K3hq?=
 =?utf-8?B?cFZBb1JNNktuN1IxYlZwUlEzbDgxZEhwSjkrZ3NDVS8zSmpGMmt2YlBBQXdI?=
 =?utf-8?B?aW5MNjJ5MWhaWFNFRUhmRHpoTm9BVnl4dnd2Nys3SDBNQXRpcDFwYTVSRWJH?=
 =?utf-8?Q?blG6MyCoRtVOLcWpRR1Lh2xdN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 019f8050-1834-4378-3fb7-08dde559e054
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 11:07:13.7799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h96D0fTWyu8/0tt9puCVowGFgqe7hwZtLPHaqhP6i3M8brx0e19Eo1+pFxj1qTHRsiR0+Rb6NvzhyUF+y1klGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5082
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/8/22 14:40, Zhenzhong Duan wrote:
> Introduce a new PCIIOMMUOps optional callback, get_viommu_cap() which
> allows to retrieve capabilities exposed by a vIOMMU. The first planned
> vIOMMU device capability is VIOMMU_CAP_HW_NESTED that advertises the
> support of HW nested stage translation scheme. pci_device_get_viommu_cap
> is a wrapper that can be called on a PCI device potentially protected by
> a vIOMMU.
> 
> get_viommu_cap() is designed to return 64bit bitmap of purely emulated
> capabilities which are only determined by user's configuration, no host
> capabilities involved. Reasons are:
> 
> 1. host may has heterogeneous IOMMUs, each with different capabilities
> 2. this is migration friendly, return value is consistent between source
>     and target.
> 3. host IOMMU capabilities are passed to vIOMMU through set_iommu_device()
>     interface which have to be after attach_device(), when get_viommu_cap()
>     is called in attach_device(), there is no way for vIOMMU to get host
>     IOMMU capabilities yet, so only emulated capabilities can be returned.
>     See below sequence:
> 
>       vfio_device_attach():
>           iommufd_cdev_attach():
>               pci_device_get_viommu_cap() for HW nesting cap
>               create a nesting parent hwpt
>               attach device to the hwpt
>               vfio_device_hiod_create_and_realize() creating hiod
>       ...
>       pci_device_set_iommu_device(hiod)

> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   MAINTAINERS          |  1 +
>   include/hw/iommu.h   | 19 +++++++++++++++++++
>   include/hw/pci/pci.h | 25 +++++++++++++++++++++++++
>   hw/pci/pci.c         | 11 +++++++++++
>   4 files changed, 56 insertions(+)
>   create mode 100644 include/hw/iommu.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a07086ed76..54fb878128 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2305,6 +2305,7 @@ F: include/system/iommufd.h
>   F: backends/host_iommu_device.c
>   F: include/system/host_iommu_device.h
>   F: include/qemu/chardev_open.h
> +F: include/hw/iommu.h
>   F: util/chardev_open.c
>   F: docs/devel/vfio-iommufd.rst
>   
> diff --git a/include/hw/iommu.h b/include/hw/iommu.h
> new file mode 100644
> index 0000000000..7dd0c11b16
> --- /dev/null
> +++ b/include/hw/iommu.h
> @@ -0,0 +1,19 @@
> +/*
> + * General vIOMMU capabilities, flags, etc
> + *
> + * Copyright (C) 2025 Intel Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_IOMMU_H
> +#define HW_IOMMU_H
> +
> +#include "qemu/bitops.h"
> +
> +enum {
> +    /* hardware nested stage-1 page table support */
> +    VIOMMU_CAP_HW_NESTED = BIT_ULL(0),

This naming is a bit confusing. get_viommu_cap indicates it will return
the viommu's capability while this naming is HW_NESTED. It's conflict
with the commit message which claims only emulated capability will be
returned.

TBH. I'm hesitating to name it as get_viommu_cap. The scope is a little
larger than what we want so far. So I'm wondering if it can be done in a
more straightforward way. e.g. just a bool op named
iommu_nested_wanted(). Just an example, maybe better naming. We can
extend the op to be returning a u64 value in the future when we see
another request on VFIO from vIOMMU.

Regards,
Yi Liu

