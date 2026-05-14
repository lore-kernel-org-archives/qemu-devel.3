Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD11CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 11:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNU4B-0005Et-PU; Thu, 14 May 2026 07:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wNU49-0005BK-Cx
 for qemu-devel@nongnu.org; Thu, 14 May 2026 07:17:21 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wNU3t-0007rh-M4
 for qemu-devel@nongnu.org; Thu, 14 May 2026 07:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778757425; x=1810293425;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=aEaFUluzjrOOLCuF14zB+/Ic5OchAFpbv2UILoN1i4w=;
 b=R5gcptVkEB2h4U/ET4qM8gGJ7W423vwJf8VNTKUF+39YX3YT2Sxyh/lD
 cZsVM1ptfzXnBjXbcEEznArQVhoTqWJnnbVsku2JGRNH8lnltj5Soj6+Y
 3kR8VxyEsQuh66rJ6L/rbwgWRiZpG24uySbxD1sBiR9WvSUkqFPQJKPs/
 Y7/53lzvzZlmdEsrQpdW5FdMALO18gXN80YszywhcOeBaTCztffwFv9Jp
 d1Rp9LDUBEv9l7DKFg/DnrnqH4rVCvGtVYG2pUpZADPF1znvVr/2Mz20S
 rx8uD3cfMFE8hvZRgyKs9ztUk1MreXDViOHjILLsSQB6uWPicytRk6lMC Q==;
X-CSE-ConnectionGUID: 0HB4dGT3SS6CS/yF8oj40g==
X-CSE-MsgGUID: do9hctP6TeCtnBwKm86uHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="90800520"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="90800520"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 04:17:01 -0700
X-CSE-ConnectionGUID: p4XCrKZKR/Ktr56/oKMXTA==
X-CSE-MsgGUID: VKE2fzlYRYOsqlBLjL+C8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="238255007"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 04:17:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 04:17:00 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 14 May 2026 04:17:00 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 04:16:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9A8Lp6OW+uEFpeyH7nfw0s/dAdrEmSdAY4sgXf811T3gbIghu7FNh6Mwbf2poPAIA3ppX2sau/2VqYNO2v7MhraDVgyi6T1elzVRvG6I4ncXBsCaSTIAXqci1USXD5QvMUL1W6lris0JWAvFXOf842z8M2efZk0lFgHUSMZSvBjSnTKEobg7PrhHPru93yjnq6ZhpkNURM4s3xXUZBZWR1Pk2/DCJLCJ7/bZS4QF9TQEnV6Z2AjenyVv5TL/5EV7mXKeW+ackFHKN4qBN/IVmIfzhxx0Do5F19UsrkzzfAiQV+JptmbplXzYXWp5ZBsJsFS2ytgWN4zsPBHxBI4+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rItzlzkds3uQkQSx4Taq5lkMxVRde67pSnrvgbOWPHQ=;
 b=T2bZeBKo0y8CT+MXk0gKm1kL/troM0oLF3mE5Z4ynOEs5EkOJXvFGcfp3AfkPYi3EUFJeHEPNsqkYM8dDN7kiw17tODX2JmVyf6UiqbgEekVXNOz4rblsiG5k/WQhgljnMfgCImyKv2veO9Ig2Po6k3999z0XpCr6UXL56baHNc2CO8FTECaOvkKWVUQAEdPub5MBIrpKC2W8qpXPnBT4vZ4heYiMxGKzUN4/pB+JTGO2A95GhYDVlW8rrTnFWByrRd35NDOZv2hnrrwQSfXJIusEZKpSKffbUnPj3CXduSaAogOQHeQC+CoJbE5eMqojhP+kIkoYGcNqNtGA5BsxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by EAYPR11MB9588.namprd11.prod.outlook.com (2603:10b6:303:2c2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 11:16:55 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 11:16:55 +0000
Message-ID: <eb419b7c-8fe9-421c-b0b9-d2dd5993e6d1@intel.com>
Date: Thu, 14 May 2026 19:25:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/15] intel_iommu: Refactor PASID processing to use
 IOMMU_NO_PASID internally
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
 <20260509040819.1044702-9-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260509040819.1044702-9-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0022.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::18) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|EAYPR11MB9588:EE_
X-MS-Office365-Filtering-Correlation-Id: ecdba10f-6e08-453c-d09d-08deb1aa4e66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|366016|7416014|376014|11063799003|4143699003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Q/qQDDSKr3HvASS9T+dkh6o9kCWtUo+Z7MvVxLeu+botatCIf3xzpZUMHMPfstYwPYo3zfpjLCvxleumewGG3CmRlqwzQKiazVKaekThDV1RxjnyI2unTmD0tiyZQNP7RhRIWLdcxl1w2EMNly0HFLEkztvkmXdiA+mVuHl/nds4XgGTN2eRyXszXlEm2OXcyQl42wAWgeRJq/OjQ0OgQ6cJ0lgoey/QSxmfpcHcq0BvKZHmO3M2plV2zxh/EBD+y8DawTyOY6YK9Q+R9YDFic8uPLflIMZ2flWIgK77dvENC0ce85Up0xhZfIAjUf5WF8Jksy0kBYczx4QFJOvs0sVLhn3LUPci2LYLWHBua/CFGyamSiBmJNqOsFOj1BXa9oEc4cRzyIXB3WilHjEEaYZlcm8h5HPXbELgShNSFcgS3T1d5vxtl0hKRF/9Bujk8zJA925s7LBW68WEGq90ODQIaJfvCwJtf+B5IxEeCKZ+jiwpvx0+3yurEzj0ZE98lfDY8r3W0tcclDlAHOfe/EC58k9pRFPRkXFUOvg4ykCvVbIT7CMbAPkWmK6uWO4FsfWB2qLMDLpa4joBU9jyxf9UjC4/vU21e7BucBFeQxvjmaPpeqDUyPYGxr/hlPqXZ2bPAEYFaUpjFIoaVJrYIIq/zDDkYL6uEwbNxJJGeF0qRwXzmC5gUVTkXsSvw5+D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(366016)(7416014)(376014)(11063799003)(4143699003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTNWREUzSVhrWDdDOVJuTUMxZXZwclFaeFRkNkxPRkQ1QTN2UDZVWjdpVTBZ?=
 =?utf-8?B?M1luU0sxTTM4SkdpS2xkaFE5eU1oYnpNMXBzMS9oZXJUZ0cydEJKc0V0RWh0?=
 =?utf-8?B?S0JDVUVZbHhzY1pEQ1FiemFMWUh2M0daQTU1RkQzSExGQUN4NDJNOTR5UXpz?=
 =?utf-8?B?TE1VbVB2U1FQWVJCbkhEd1VKRStpdTNCeWxkWEd1d09ScHlNKzdvUW1sS2Fm?=
 =?utf-8?B?R1JENW1URUZpREdMNDBJbVpIOHduWkpEaThDN2prek80dVlTNkhXMFBqYmlS?=
 =?utf-8?B?b2xxck5sZmZWOFZzWlRpbXlZZnJtSGpoK2tZWktWMXl5RTl0bys3RnRLaTJS?=
 =?utf-8?B?KzNxcWtZU2ZMRVZxMGxsMUFDakp4K0FNMXd4UHlXc3BXSWpWR0R0Wk9HWW5y?=
 =?utf-8?B?cncyWHVsMStmRDRNdTBjN2Q5M2l3bjh1VUcyZkNabUtkTCsvZXBZWnNCdEc3?=
 =?utf-8?B?cEhVZ3JsS0xDVnJ2cmowbzZOQVB4NUlaRnlMSVQyRUxhSFFtR282TXRPc0Vu?=
 =?utf-8?B?ZzN4a29abFlhVmdhSkg2dXhJVERNL0lMMmpYTGxybXRWc2g3UXdHRmkxUzl6?=
 =?utf-8?B?NFcwVzBncGRPb3d5S2pnOFNOdjRsOGJ0Y09kcWJ4dzh1cGhQY1BTOVRqK1Bi?=
 =?utf-8?B?WDNxaWdheGFJWHNYRG5reWp4ckxSUTE1TzhLZzZHUmJtajJhL0M4RjU2dU1N?=
 =?utf-8?B?MWw1am5xV3kwb1V5cGdoMmNiaktKMDVtUnRkamdiaVFkNkJxZnF2Nmh6b3FO?=
 =?utf-8?B?Z1dUSGVpckVNd3kzdit0NjhmUFBLek5GbnJHc3ZHRWFqWVA2S0U2ZHJJUjMw?=
 =?utf-8?B?S0FCRTlLY1gxWk0vSWdSLzZ1aERadzhmNmNPL3V4TWtwWEphUm9kWXU3SnNR?=
 =?utf-8?B?dDZBN2lqdXBGM1lHaklSRFRrOG0xVkk1aDh1VCthNUVuVTBqUmJTS2dTR21u?=
 =?utf-8?B?WmVtRWRxL1MxSzluWWg4V2pVU2tqQjdpZi9CaGgrKzFDTmloUHMyekE2Q2lz?=
 =?utf-8?B?Mkp4Y3YydW1CTXk4dFpHSW1XSGhnc09jTVBtTk5VaHdjNmR4MFpLSi9kWTNH?=
 =?utf-8?B?WEtxTDMwUUhCMHhPaXVnYXhKeE9xQVQxRTRBQ0RxU3RHOW01U0VMKzd4T3RF?=
 =?utf-8?B?WllndjE4a3BkS2FRTkx0d1BPa081YmE3cXVuejV5WWR3UUNmQzlpS1FuRFZF?=
 =?utf-8?B?cytRMU4yeGlyTVNVdFduUSsxb0YyWXNHUmsrdGtRTmpncGJuZGV5dEp1U1p3?=
 =?utf-8?B?VG80RmN6ZjZycWpTaFlERXpOVnhzd3BlVVcveDQrWDYyZ0JLay8xb2xoMmFM?=
 =?utf-8?B?Y3F6SFQ1UkVoNUJhcTBOWTY1M3pQZ3RBODRtYkM0UTB0dVRkeVBYaElDNXpt?=
 =?utf-8?B?MFZKRXZBSGFPcnBsbDhOWHArNGRHYnI1aFBxTnNRbUk4dHB5eGc0VXVwTFFs?=
 =?utf-8?B?SnlSa2JnTlFjakFxNXY3ejhWOGpvb0tLM2FJTXl1alFGelpPTjBreElXSHJm?=
 =?utf-8?B?S21obU5FN0tOSkxlNFkyUkw3djhiZjVTbFBaVXBqOENMZkxEQXNvdFBVN0xH?=
 =?utf-8?B?Z3pTRUhOR1dTc05JUWtpd05vQ2NFRU8ybDVTVVVzdWZtQ2ZZUE5iendoaE5u?=
 =?utf-8?B?QUY3QzFnbTRiSVpMUEp0WTluZ2xudk1GeDlTRTFJT2tMdGx1NjBBRk5LRmJ5?=
 =?utf-8?B?VlF3VEN0cnQrYUNWcEVJdm1vMmpUL1orOWdKOUFLOENMUnF0OE0yVDJEdk1P?=
 =?utf-8?B?NnZVWFIrOTh2MUpsdDEybVM3c1UwMDZlbjRqcWtXRExvZS9FcnJiT3JCdmVU?=
 =?utf-8?B?em1uQnZ5cHJZRWU4MmtkeVE5dXU1d2x6TWtMVktLc1IxSTl1dVVUTUVoRkR6?=
 =?utf-8?B?TnU1dk96Mi9na25BT0ZldTBNWGxtdDVlLzU1Z1ZvU3VTS2l0bW5aSnliTDlJ?=
 =?utf-8?B?L2RSWjhWbU9YWG9XaXpCS3liTE0yeHZpMDlrb3dsU0JWUS9mQWYzRlZneG91?=
 =?utf-8?B?SDBicUpOd0UzYkhlcGFxWUJlSU9EaTdWOEVJd2dtdWFQY2V3THIvSTFGTXdo?=
 =?utf-8?B?amlaVG1ta2UrbndNSTd5eXljcmNld1BoTXRvVlVrcURQK0xtZjk0Y2w4NXQ1?=
 =?utf-8?B?b0t1NFJVSFdtYk5rVC8vN0U4NWEyL05udjdVSnEvMHQ3ZDFzZ2NHcTE4YlRN?=
 =?utf-8?B?TzU3ZGFUOFpSTzZrZ2t2K1NLWkpyUm5nc1FLdFdSWVJXcCs4cHpDRXJMZEEz?=
 =?utf-8?B?eTNTNksyeGRwM0Zma3lVL0t5cUN6ZGtQRlgvOVptME5ZVTRjelJTY0FFTmpz?=
 =?utf-8?B?TjZrOThtK3N1cDVBNFdYUGtHcUFuR29ZdkJHNXl2MFRwSUN1RGpjQT09?=
X-Exchange-RoutingPolicyChecked: ARRIpHrpKU4fWLpRkK8m3m7tdxuICUKcVrM1VQK8nFH5aI3o0CNlIFIcu/3PTQkMZoa8MBOtzkJ+KNpdJLQKjtVXfiliG6S0RCZQzjMN0TK3qFuewnBA5VxbOboTJi/dgTiCRonroL/sLwETbeoUvsY1EVUSv5mIKzxkyiXoZNskjQQ+cML9eGctDIbtpM4khAgVnhX2bzbiGVtxA3bNFSYxQqTpxWWOYYAbKtiiir3z/pUhA46o2WWcrBHSKg6eonWBJppS/bMZS0jzksd/mzaFhq4SUilPXXf4rcCe69YWdkDUphkDhUJAfU165AeAaMcf0b9Pkg2t30JMRqiu+Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: ecdba10f-6e08-453c-d09d-08deb1aa4e66
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 11:16:55.3476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oD5to5fSHt/xuLQVhjFnIgKqQTBe/AiNdqTFH5vINA4nFeZSd0jsLtWjNCtDJ43axstAchTGiuPKOxffcUbP/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR11MB9588
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13; envelope-from=yi.l.liu@intel.com;
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

On 5/9/26 12:08, Zhenzhong Duan wrote:
> The PCI subsystem uses PCI_NO_PASID for requests-without-PASID, but VT-d
> uses IOMMU_NO_PASID internally. This leads to conversion and checking code

s/VT-d uses IOMMU_NO_PASID internally/VT-d emulation uses IOMMU_NO_PASID
internally (ecap.RPS==0)/

> between PCI_NO_PASID and IOMMU_NO_PASID throughout the implementation.
> 
> Refactor to use IOMMU PASID consistently within Intel IOMMU by storing
> IOMMU PASID value in vtd_as->pasid. After this change, PCI_NO_PASID is
> only used at three boundary points:

a typo or the third boundary is missed?

> 
> 1. PCI_NO_PASID -> IOMMU_NO_PASID: Convert PCI PASID to IOMMU PASID in
>     vtd_find_add_as() and cache in vtd_as->pasid.
> 2. IOMMU_NO_PASID -> PCI_NO_PASID: Convert when notifying UNMAP events
>     via memory_region_notify_iommu() and returning IOMMUTLBEntry in
>     vtd_iommu_translate().
> 
> This eliminates conversion/checks in PASID table lookups, simplifies
> invalidation logic with consistent PASID values, and improves code
> readability. The PCI subsystem interface remains unchanged to maintain
> compatibility with other IOMMU implementations that may not use PASID 0
> for requests-without-PASID.
> 
> Suggested-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/system/memory.h     |   2 +-
>   hw/i386/intel_iommu.c       | 164 +++++++++++++++++-------------------
>   hw/i386/intel_iommu_accel.c |   2 +-
>   3 files changed, 80 insertions(+), 88 deletions(-)
> 
> diff --git a/include/system/memory.h b/include/system/memory.h
> index 1417132f6d..1edb38b07d 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -150,7 +150,7 @@ struct IOMMUTLBEntry {
>       hwaddr           translated_addr;
>       hwaddr           addr_mask;  /* 0xfff = 4k translation */
>       IOMMUAccessFlags perm;
> -    uint32_t         pasid;
> +    uint32_t         pasid; /* PCI pasid */
>   };
>   
>   /*
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 5e5dcdc274..b50c556c40 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -938,12 +938,8 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
>   int vtd_ce_get_pasid_entry(IntelIOMMUState *s, VTDContextEntry *ce,
>                              VTDPASIDEntry *pe, uint32_t pasid)
>   {
> -    dma_addr_t pasid_dir_base;
> +    dma_addr_t pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
>   
> -    if (pasid == PCI_NO_PASID) {
> -        pasid = IOMMU_NO_PASID;
> -    }
> -    pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
>       return vtd_get_pe_from_pasid_table(s, pasid_dir_base, pasid, pe);
>   }
>   
> @@ -953,15 +949,10 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
>                                   uint32_t pasid)
>   {
>       int ret;
> -    dma_addr_t pasid_dir_base;
> +    dma_addr_t pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
>       VTDPASIDDirEntry pdire;
>       VTDPASIDEntry pe;
>   
> -    if (pasid == PCI_NO_PASID) {
> -        pasid = IOMMU_NO_PASID;
> -    }
> -    pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
> -
>       /*
>        * No present bit check since fpd is meaningful even
>        * if the present bit is clear.
> @@ -1750,7 +1741,7 @@ static bool vtd_switch_address_space(VTDAddressSpace *as)
>            *
>            * Need to disable ir for as with PASID.
>            */
> -        if (as->pasid != PCI_NO_PASID) {
> +        if (as->pasid != IOMMU_NO_PASID) {
>               memory_region_set_enabled(&as->iommu_ir, false);
>           } else {
>               memory_region_set_enabled(&as->iommu_ir, true);
> @@ -1780,7 +1771,7 @@ static bool vtd_switch_address_space(VTDAddressSpace *as)
>        * We enable per as memory region (iommu_ir_fault) for catching
>        * the translation for interrupt range through PASID + PT.
>        */
> -    if (pt && as->pasid != PCI_NO_PASID) {
> +    if (pt && as->pasid != IOMMU_NO_PASID) {
>           memory_region_set_enabled(&as->iommu_ir_fault, true);
>       } else {
>           memory_region_set_enabled(&as->iommu_ir_fault, false);
> @@ -1892,7 +1883,7 @@ static VTDAddressSpace *vtd_get_as_by_sid_and_pasid(IntelIOMMUState *s,
>   
>   VTDAddressSpace *vtd_get_as_by_sid(IntelIOMMUState *s, uint16_t sid)
>   {
> -    return vtd_get_as_by_sid_and_pasid(s, sid, PCI_NO_PASID);
> +    return vtd_get_as_by_sid_and_pasid(s, sid, IOMMU_NO_PASID);
>   }
>   
>   static void vtd_pt_enable_fast_path(IntelIOMMUState *s, uint16_t source_id)
> @@ -2121,10 +2112,6 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>   
>       vtd_iommu_lock(s);
>   
> -    if (pasid == PCI_NO_PASID && s->root_scalable) {
> -        pasid = IOMMU_NO_PASID;
> -    }
> -
>       /* Try to fetch pte from IOTLB */
>       iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
>       if (iotlb_entry) {
> @@ -2235,7 +2222,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>       if (ret_fr) {
>           if (!vtd_is_recoverable_fault(-ret_fr, iommu_idx)) {
>               vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
> -                            addr, is_write, pasid != PCI_NO_PASID, pasid);
> +                            addr, is_write, s->root_scalable, pasid);

a typo here? s->root_scalable should be "pasid != IOMMU_NO_PASID"?

Other part LGTM.

Regards,
Yi Liu

>           }
>           goto error;
>       }
> @@ -2489,7 +2476,7 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
>   /*
>    * There is no pasid field in iotlb invalidation descriptor, so IOMMU_NO_PASID
>    * is passed as parameter. Piotlb invalidation supports pasid, pasid in its
> - * descriptor is passed which should not be PCI_NO_PASID.
> + * descriptor is passed.
>    */
>   static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
>                                                uint16_t domain_id, hwaddr addr,
> @@ -2503,48 +2490,41 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
>       QLIST_FOREACH(vtd_as, &(s->vtd_as_with_notifiers), next) {
>           ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
>                                          vtd_as->devfn, &ce);
> -        if (!ret && domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
> +        if (ret || vtd_as->pasid != pasid ||
> +            domain_id != vtd_get_domain_id(s, &ce, pasid)) {
> +            continue;
> +        }
> +
> +        if (vtd_as_has_map_notifier(vtd_as)) {
>               /*
> -             * In legacy mode, vtd_as->pasid == pasid is always true.
> -             * In scalable mode, for vtd address space backing a PCI
> -             * device without pasid, needs to compare pasid with
> -             * IOMMU_NO_PASID of this device.
> +             * When first stage translation is off, as long as we have MAP
> +             * notifications registered in any of our IOMMU notifiers,
> +             * we need to sync the shadow page table. Otherwise VFIO
> +             * device attaches to nested page table instead of shadow
> +             * page table, so no need to sync.
>                */
> -            if (!(vtd_as->pasid == pasid ||
> -                  (vtd_as->pasid == PCI_NO_PASID && pasid == IOMMU_NO_PASID))) {
> -                continue;
> -            }
> -
> -            if (vtd_as_has_map_notifier(vtd_as)) {
> -                /*
> -                 * When first stage translation is off, as long as we have MAP
> -                 * notifications registered in any of our IOMMU notifiers,
> -                 * we need to sync the shadow page table. Otherwise VFIO
> -                 * device attaches to nested page table instead of shadow
> -                 * page table, so no need to sync.
> -                 */
> -                if (!s->fsts || !s->root_scalable) {
> -                    vtd_sync_shadow_page_table_range(vtd_as, &ce, addr, size);
> -                }
> -            } else {
> -                /*
> -                 * For UNMAP-only notifiers, we don't need to walk the
> -                 * page tables.  We just deliver the PSI down to
> -                 * invalidate caches.
> -                 */
> -                const IOMMUTLBEvent event = {
> -                    .type = IOMMU_NOTIFIER_UNMAP,
> -                    .entry = {
> -                        .target_as = &address_space_memory,
> -                        .iova = addr,
> -                        .translated_addr = 0,
> -                        .addr_mask = size - 1,
> -                        .perm = IOMMU_NONE,
> -                        .pasid = vtd_as->pasid,
> -                    },
> -                };
> -                memory_region_notify_iommu(&vtd_as->iommu, 0, event);
> +            if (!s->fsts || !s->root_scalable) {
> +                vtd_sync_shadow_page_table_range(vtd_as, &ce, addr, size);
>               }
> +        } else {
> +            /*
> +             * For UNMAP-only notifiers, we don't need to walk the
> +             * page tables.  We just deliver the PSI down to
> +             * invalidate caches.
> +             */
> +            const IOMMUTLBEvent event = {
> +                .type = IOMMU_NOTIFIER_UNMAP,
> +                .entry = {
> +                    .target_as = &address_space_memory,
> +                    .iova = addr,
> +                    .translated_addr = 0,
> +                    .addr_mask = size - 1,
> +                    .perm = IOMMU_NONE,
> +                     /* Other sub-systems use PCI pasid */
> +                    .pasid = pasid == IOMMU_NO_PASID ? PCI_NO_PASID : pasid,
> +                },
> +            };
> +            memory_region_notify_iommu(&vtd_as->iommu, 0, event);
>           }
>       }
>   }
> @@ -3007,6 +2987,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
>       VTDIOTLBPageInvInfo info;
>       VTDAddressSpace *vtd_as;
>       VTDContextEntry ce;
> +    int ret;
>   
>       info.domain_id = domain_id;
>       info.pasid = pasid;
> @@ -3019,17 +3000,15 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
>       vtd_iommu_unlock(s);
>   
>       QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
> -        if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
> -                                      vtd_as->devfn, &ce) &&
> -            domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
> -            if ((vtd_as->pasid != PCI_NO_PASID || pasid != IOMMU_NO_PASID) &&
> -                vtd_as->pasid != pasid) {
> -                continue;
> -            }
> +        ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
> +                                       vtd_as->devfn, &ce);
> +        if (ret || vtd_as->pasid != pasid ||
> +            domain_id != vtd_get_domain_id(s, &ce, pasid)) {
> +            continue;
> +        }
>   
> -            if (!s->fsts || !vtd_as_has_map_notifier(vtd_as)) {
> -                vtd_address_space_sync(vtd_as);
> -            }
> +        if (!s->fsts || !vtd_as_has_map_notifier(vtd_as)) {
> +            vtd_address_space_sync(vtd_as);
>           }
>       }
>   }
> @@ -3239,7 +3218,7 @@ static bool vtd_process_pasid_desc(IntelIOMMUState *s,
>           /* PASID selective implies a DID selective */
>           trace_vtd_inv_desc_pasid_cache_psi(did, pasid);
>           pc_info.did = did;
> -        pc_info.pasid = pasid ?: PCI_NO_PASID;
> +        pc_info.pasid = pasid;
>           break;
>   
>       case VTD_INV_DESC_PASIDC_G_GLOBAL:
> @@ -3291,6 +3270,7 @@ static void do_invalidate_device_tlb(VTDAddressSpace *vtd_dev_as,
>        * ...
>        */
>   
> +    uint32_t pasid = vtd_dev_as->pasid;
>       IOMMUTLBEvent event;
>       uint64_t sz;
>   
> @@ -3307,7 +3287,8 @@ static void do_invalidate_device_tlb(VTDAddressSpace *vtd_dev_as,
>       event.entry.iova = addr;
>       event.entry.perm = IOMMU_NONE;
>       event.entry.translated_addr = 0;
> -    event.entry.pasid = vtd_dev_as->pasid;
> +    /* Other sub-systems use PCI pasid */
> +    event.entry.pasid = pasid == IOMMU_NO_PASID ? PCI_NO_PASID : pasid;
>       memory_region_notify_iommu(&vtd_dev_as->iommu, 0, event);
>   }
>   
> @@ -3335,7 +3316,7 @@ static bool vtd_process_device_piotlb_desc(IntelIOMMUState *s,
>       sid = VTD_INV_DESC_PASID_DEVICE_IOTLB_SID(inv_desc->lo);
>       if (global) {
>           QLIST_FOREACH(vtd_dev_as, &s->vtd_as_with_notifiers, next) {
> -            if ((vtd_dev_as->pasid != PCI_NO_PASID) &&
> +            if ((vtd_dev_as->pasid != IOMMU_NO_PASID) &&
>                   (PCI_BUILD_BDF(pci_bus_num(vtd_dev_as->bus),
>                                              vtd_dev_as->devfn) == sid)) {
>                   do_invalidate_device_tlb(vtd_dev_as, size, addr);
> @@ -3983,13 +3964,12 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
>   }
>   
>   static void vtd_prepare_identity_entry(hwaddr addr, IOMMUAccessFlags perm,
> -                                         uint32_t pasid, IOMMUTLBEntry *iotlb)
> +                                       IOMMUTLBEntry *iotlb)
>   {
>       iotlb->iova = addr & VTD_PAGE_MASK_4K;
>       iotlb->translated_addr = addr & VTD_PAGE_MASK_4K;
>       iotlb->addr_mask = ~VTD_PAGE_MASK_4K;
>       iotlb->perm = perm;
> -    iotlb->pasid = pasid;
>   }
>   
>   static inline void vtd_prepare_error_entry(IOMMUTLBEntry *entry)
> @@ -4001,6 +3981,10 @@ static inline void vtd_prepare_error_entry(IOMMUTLBEntry *entry)
>       entry->pasid = PCI_NO_PASID;
>   }
>   
> +/*
> + * This function returns translation result to other sub-system such as PCI,
> + * so iommu pasid is converted to PCI pasid and returned in IOMMUTLBEntry.
> + */
>   static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
>                                            IOMMUAccessFlags flag, int iommu_idx)
>   {
> @@ -4009,7 +3993,7 @@ static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
>       IOMMUTLBEntry iotlb = {
>           /* We'll fill in the rest later. */
>           .target_as = &address_space_memory,
> -        .pasid = vtd_as->pasid,
> +        .pasid = vtd_as->pasid == IOMMU_NO_PASID ? PCI_NO_PASID : vtd_as->pasid,
>       };
>       bool success;
>       bool is_write = flag & IOMMU_WO;
> @@ -4017,9 +4001,8 @@ static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
>       if (likely(s->dmar_enabled)) {
>           /* Only support translated requests in scalable mode */
>           if (iommu_idx == VTD_IDX_TRANSLATED && s->root_scalable) {
> -            if (vtd_as->pasid == PCI_NO_PASID) {
> -                vtd_prepare_identity_entry(addr, IOMMU_RW, PCI_NO_PASID,
> -                                           &iotlb);
> +            if (vtd_as->pasid == IOMMU_NO_PASID) {
> +                vtd_prepare_identity_entry(addr, IOMMU_RW, &iotlb);
>                   success = true;
>               } else {
>                   vtd_prepare_error_entry(&iotlb);
> @@ -4034,7 +4017,7 @@ static IOMMUTLBEntry vtd_iommu_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
>           }
>       } else {
>           /* DMAR disabled, passthrough, use 4k-page*/
> -        vtd_prepare_identity_entry(addr, IOMMU_RW, vtd_as->pasid, &iotlb);
> +        vtd_prepare_identity_entry(addr, IOMMU_RW, &iotlb);
>           success = true;
>       }
>   
> @@ -4460,7 +4443,7 @@ static void vtd_report_sid_ir_illegal_access(IntelIOMMUState *s, uint16_t sid,
>       }
>   
>       vtd_report_fault(s, VTD_FR_SM_INTERRUPT_ADDR, is_fpd_set, sid, addr,
> -                     is_write, pasid != PCI_NO_PASID, pasid);
> +                     is_write, pasid != IOMMU_NO_PASID, pasid);
>   }
>   
>   static void vtd_report_ir_illegal_access(VTDAddressSpace *vtd_as,
> @@ -4488,7 +4471,6 @@ static MemTxResult vtd_mem_ir_write(void *opaque, hwaddr addr,
>       int ret = 0;
>       MSIMessage from = {}, to = {};
>       uint16_t sid = X86_IOMMU_SID_INVALID;
> -    uint32_t pasid;
>   
>       from.address = (uint64_t) addr + VTD_INTERRUPT_ADDR_FIRST;
>       from.data = (uint32_t) value;
> @@ -4496,11 +4478,11 @@ static MemTxResult vtd_mem_ir_write(void *opaque, hwaddr addr,
>       if (!attrs.unspecified) {
>           /* We have explicit Source ID */
>           sid = attrs.requester_id;
> -        pasid = attrs.pid != 0 ? attrs.pid : PCI_NO_PASID;
>   
>           if (attrs.address_type == PCI_AT_TRANSLATED &&
>               sid != X86_IOMMU_SID_INVALID) {
> -            vtd_report_sid_ir_illegal_access(s, sid, pasid, from.address, true);
> +            vtd_report_sid_ir_illegal_access(s, sid, attrs.pid, from.address,
> +                                             true);
>               return MEMTX_ERROR;
>           }
>       }
> @@ -4562,9 +4544,19 @@ static const MemoryRegionOps vtd_mem_ir_fault_ops = {
>       },
>   };
>   
> +/*
> + * This function is called by many PCIIOMMUOps callbacks to get
> + * VTDAddressSpace or create one if non-exist. Those callbacks are
> + * used by PCI sub-system and are passed in a PCI pasid value.
> + *
> + * VTD honors iommu pasid, so the first thing is to convert PCI
> + * pasid to iommu pasid.
> + */
>   VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>                                    int devfn, unsigned int pasid)
>   {
> +    pasid = pasid == PCI_NO_PASID ? IOMMU_NO_PASID : pasid;
> +
>       /*
>        * We can't simply use sid here since the bus number might not be
>        * initialized by the guest.
> @@ -4606,7 +4598,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>           new_key->devfn = devfn;
>           new_key->pasid = pasid;
>   
> -        if (pasid == PCI_NO_PASID) {
> +        if (pasid == IOMMU_NO_PASID) {
>               snprintf(name, sizeof(name), "vtd-%02x.%x", PCI_SLOT(devfn),
>                        PCI_FUNC(devfn));
>           } else {
> @@ -5290,7 +5282,7 @@ error_get_fpd_and_report:
>       vtd_ce_get_pasid_fpd(s, &ce, &is_fpd_set, vtd_as->pasid);
>   error_report:
>       vtd_report_fault(s, -ret, is_fpd_set, sid, addr, is_write,
> -                     vtd_as->pasid != PCI_NO_PASID, vtd_as->pasid);
> +                     vtd_as->pasid != IOMMU_NO_PASID, vtd_as->pasid);
>       return false;
>   }
>   
> @@ -5381,7 +5373,7 @@ static int vtd_pri_request_page(PCIBus *bus, void *opaque, int devfn,
>        */
>   
>       /* We do not support PRI without PASID */
> -    if (vtd_as->pasid == PCI_NO_PASID) {
> +    if (vtd_as->pasid == IOMMU_NO_PASID) {
>           return -EPERM;
>       }
>       if (exec_req && !is_read) {
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index 8940d240a1..10bdbba632 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -207,7 +207,7 @@ static void vtd_flush_host_piotlb_locked(gpointer key, gpointer value,
>           return;
>       }
>   
> -    assert(vtd_as->pasid == PCI_NO_PASID);
> +    assert(vtd_as->pasid == IOMMU_NO_PASID);
>   
>       /* Nothing to do if there is no first stage HWPT attached */
>       if (!pc_entry->valid ||


