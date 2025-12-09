Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409A7D3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 03:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSoN2-0000SY-8F; Mon, 08 Dec 2025 22:26:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vSoMv-0000Rd-LR; Mon, 08 Dec 2025 22:26:30 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vSoMt-0000Ov-9H; Mon, 08 Dec 2025 22:26:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765250787; x=1796786787;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2ElFJvniiGI5Kkde174QL8rpIF+R/+2VFw0aPD11z3A=;
 b=L+YLSo/ZCpQ02zEU2fIGi6lkuzKedw8q6CIH+fz0oa1LH8ZeTGgsAb0T
 i5s+Nc16rfj27n//6DGS+2Zs3Y/fu0Al/haQt6pX3yF1xibJmxYfA6QfN
 WNbywbsnZO+CjvDHmxFaGLYYBaUyQLsUzSHuWEDyOcK2NbP5PmUH9PZnB
 Ydk8qcFSF/YGNZy7NyjlF8Hoy1iTmczgVSl/OnjLDI9Ni/zAKOe8/AdPw
 4CFQNzdgXhiXl8XoUBKTDfqJ2WI6wb+esH7gTzTGMhDGDQUDLCYRqiL2S
 kXwAjbCFuzTTU/ehhihRP3sosWTOgkXAYSeFZshuB1ZtCbzfQONTcGWu9 A==;
X-CSE-ConnectionGUID: 2SBwrau1QWCOcT+O4BxzzA==
X-CSE-MsgGUID: eejFnlWzS1SpKyHKrOj5ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="71048232"
X-IronPort-AV: E=Sophos;i="6.20,260,1758610800"; d="scan'208";a="71048232"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2025 19:26:22 -0800
X-CSE-ConnectionGUID: POucJH0fT8aa87Vo2mGpfA==
X-CSE-MsgGUID: H80bHlQTTmS9x1xURcw91A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,260,1758610800"; d="scan'208";a="196571438"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2025 19:26:21 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 8 Dec 2025 19:26:20 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 8 Dec 2025 19:26:20 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.18) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 8 Dec 2025 19:26:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtZZsVVv2IAD9nNAlrbuaRiQyulrv78aXIh1TKOD7tFAasMyz98JSPrvW8iU9EuP34OKPZHSkMmpYvi4tXqpvoW+eTvtqUWugLV/ifWgnFtUtrHNrzXGad5eO1wh5kmSxO2TYNvWpYjHssG1CEMMZdVp9Mk4DSRmFAkMeeLO2N7Gv091I6uct7mWrDG/ntOorXevvPsXiIAL60PpjcSjby2qLkT51BPvx+Rn6HjI2936qWVT41PawBQDwiFwcWG1BXr8HAIZ+ZbrNkHyV7ejOs8/cgv4ReTjeqGu798+tDav8/uG20xXll6GYwO0OMiaNO4qJbVXYXu7NK/MOo8cyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLFlMXxgK0BT3Lo4kP6GTHQlomLlkEPawdoUpShmuO4=;
 b=RxH/Uir6pwXp35pt9rHw3brJVhIXOUhPW/qNUXAShwaSvJQrSrsw9XkLkgtvt8me8RjrVdv5yuwXxK+YKtdg8sA1cG1z0wmmHgLps/pSxPkt50flxYquJx+40PPYBC3pBL9Ja16686cGbI8j+IOvETXZG2fWP7KVijSu7/0DZKM6L+bEHUsHcnMg8gPvYc6cPISYz3Dha6owdUd4GXzxUCoRGU3xEyPErrS15jIWCEJTrsnSxJL1eAN1isEA6GoCwJSIFlym/EFOhjf5ouZPO9jKrVG0hGjaEMjFUp5Au12GQuNgGwpUzYrqkxo4tpSRRlCcKxWtPGAdpXs6JNF57w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by SJ0PR11MB5895.namprd11.prod.outlook.com (2603:10b6:a03:42b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 03:26:18 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 03:26:18 +0000
Message-ID: <bd8c556e-b9ba-48fa-844e-d00e37dfdba3@intel.com>
Date: Tue, 9 Dec 2025 11:33:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/33] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, Shameer Kolothum
 <skolothumtho@nvidia.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, "Nathan
 Chen" <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>, Krishnakant Jaju
 <kjaju@nvidia.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <IA3PR11MB91361CCD9C11FACB77057AB092A2A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <CH3PR12MB7548A9B094B7E7CEBC1D1A58ABA2A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <IA3PR11MB9136125C3DA481215DD28B6E92A3A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB9136125C3DA481215DD28B6E92A3A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0016.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::8)
 To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|SJ0PR11MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: d4cf88ad-b4c4-4204-741e-08de36d2b782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|42112799006|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTNjMFRXSGNIdk1zWmdEc1o0RC96QW5taU42RnM0bSs5S052MzhEZm9vdi85?=
 =?utf-8?B?Z2JhRlQyZ2lNWkhkd0hGQnlXT1RPR0g1TGczRklxaXh4NEYxVVNBQXdCMzE2?=
 =?utf-8?B?OWZ0azNjQUdtZ1BDWS9Ka3BSRWRYcEd6Y3VKTklVTzVmem1VSThGZFpSMXFm?=
 =?utf-8?B?YjRWVjBhSzBZUjY3YUN3Uko1Uk01Z3ozQnVsWXF0MGRNVnozbDljM1RiUjNs?=
 =?utf-8?B?cUx0YmI1VXJUWTVJTC9zSml4cUQ3UmpCLzU5SWpzVTYwaWhtTXpsaUFCQ2RZ?=
 =?utf-8?B?VzFRa3kvbSsvalpHMFBxT0U2cHQ1SWg1dUNLbys3aVBYV1krRjlSUHl2dGFH?=
 =?utf-8?B?cWtrYmNUeWhOUDdzNW9xR09ZOXRzQmRIbUFrNEF4QTg2MG8xY2ZIYTBUdmRY?=
 =?utf-8?B?RFJvRFpwak13S1Q2Znl6UnVhUExNL1Y5MWFKUFhpbXNCUmFzaEpremxGSytW?=
 =?utf-8?B?SUlMMDlsZDh0elFsaVBIRkdxMXpjTzAxaHo3K0VyUHY5dFlOczVyREM1bGxw?=
 =?utf-8?B?aUhLaE51UDIvdTJrYnh6ZE9LaW5xdW5uZkNKaGVUQmZ6VGlGV3ptaFM4NWlB?=
 =?utf-8?B?T3RrS1ROTklBWUp6anZ2SkdMS29ReXBnUzlpdkVZRkhUOWlSbzErSFk5SUFF?=
 =?utf-8?B?Sm1QQzlNYU51aHFRRXNraGx2Q08yTm5aSmNvVG04c21scEttQTNHNEtvRmFx?=
 =?utf-8?B?UEhNNnVjOXpTSlZyTi9BNWdpUk05c2VuRDA5cm9MTTYzcEVJYkQ5aUh2OXF4?=
 =?utf-8?B?cTc5a3gxT3FuMWxxU0E1SUJUNG1lTmJkK3R1MkxvR1BpSzVuV1lCdW52V0Mr?=
 =?utf-8?B?UTBvTitjNDNwNzdqTFV5d3dmd2Yzc0JkMW5XNm10L0d6Q05XZVZkdVRnbFdO?=
 =?utf-8?B?TEI5Z3lIYUdTbitOL29GSEtLZUU5ZG96b2NRN2NsMUQ3M2ZUNnl6WVpOUENI?=
 =?utf-8?B?clRlM1k3UjluQU1JbVlSZ20xOWdvNUs5RjVkZHl4WjRwUUM4VEZ0ZDFCc2lB?=
 =?utf-8?B?RzhKMmErMmZ5YXd6S2VYS3QyV0NRanhDa1EvN1hieGZoSUZudjdvQnI1WWND?=
 =?utf-8?B?OUo0ZzFWTjFaOWd4cjJ5NEhKRXVVallMMWdoYVZ4TVJ2OXZPeTVoNVBkK0I4?=
 =?utf-8?B?aWx1QzAxd3BPc1EzZWhvckp2RFhkdTZ3UzJiTFkwTDY3S3lBRDRTT2o2VFBB?=
 =?utf-8?B?MlRvTXd6OFFDL2xsMEV6UzZmR3ZzSXRmREtCb2ZjVkU5UU45MXpwOTdGUXdZ?=
 =?utf-8?B?UEU4M2pJTDJqbTFvRTRuQjExbGwwV0ZoL1poMEVzQzdPTUV4SVFkenB6OUR4?=
 =?utf-8?B?allYVEFDckdPaFpXV093bDgydEx0OGZEU01PdE5sV0ZTTDEyb25hTHpFM0JD?=
 =?utf-8?B?NXNCL2xVMmFIRjkrdlZpK1pCUW5DQUFTbW1HNnQ1dVQ2bW5oRDhBQjg0ckkv?=
 =?utf-8?B?Q3FFSGxQcm5tSE8zSXVhQlc1VWZUT2pZOXpkY0loblhpN0g0N0lUemJ5eGY4?=
 =?utf-8?B?ZWdIb1EyOHE2TTBtNE9peG9FNklseTllM2hBTzYybm40YnJQRnJLc1VzdEIv?=
 =?utf-8?B?T1FTcUpJNHlJY3lyUU5tcFNNa25rVm1wbGoySkY1NFZPcW96TnNLeXU4Tkhj?=
 =?utf-8?B?UUVVbHVCYUtmQ2VBK1NnNUIwZ1pqSFdLMTFOdG5FSGpZbXRaOURFMy9Td3A2?=
 =?utf-8?B?clpmUU9rZ3R2RTJsMFVxeXlablptZGs5VkQwNHY1QURtSytzYlJ0aHRFdzNa?=
 =?utf-8?B?RDNLTy9OWXkvYU1lQ05BUzEvM0Z2ZjFha09qWHc1eWdjTDFBMXBvQWVmWTlJ?=
 =?utf-8?B?QzFzU2loMFdMRFNGRnpCUXdjdnp3aFZ5amU1ck9UY01NRUs0VXlyczRwdWd1?=
 =?utf-8?B?TXpCVFByQ0dqaWExczlFam1DYlJGZDRmWkNBbGxTMzIvTWN3N3Irdk1hVm9D?=
 =?utf-8?B?THhLWUhTOTJ5c0FjOWZObkVZSmRXOXRpc2RLeEZlenVOREpnaGtvRVN4QlB0?=
 =?utf-8?B?K0FlVnhpR0xnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(42112799006)(7416014)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkMyK2lPZ0JjMVZrYU4wZEtxZk5KL29xYUplYVd2M0lkbzR1Nk13ZE9qQU5Y?=
 =?utf-8?B?TnJrVHRBZEJrTHN1ZTBJMVZJVlY1RVh0c0Q5aXd3TktTdmlLQjlLcFB5MjBt?=
 =?utf-8?B?K2F2bzNkenRNUlBqejE3TlZJL1QvWUNjOWIyeXRvWFZ3Z0kzdnhRRXZwRTZn?=
 =?utf-8?B?SlBPRE5HeE5DNngrUVNlN3NaNUl4Tm5lZmdYT0VNS3VwRzlsZmZPQWg2Rkta?=
 =?utf-8?B?WXRlMUhJdWpUcHg4OVhJTWJzblltQUcyaytwcHRLY1hnaWp4WkJpN1JIbmtO?=
 =?utf-8?B?eUx2WEZMb01LSkg2cXpGZldkaE9ZcWg3c0JJVTdCZTlJWkpBRDg3M3NhU3JB?=
 =?utf-8?B?ZmJmbWJjWTFMekZSQzBDZEtZWjhDOGpMY0UvUmswYW5tM1MzaW0renk0S1Bn?=
 =?utf-8?B?Y1k1Q2VsS2lSemxkaFFabkt2UmhGNjkvK3FDb1ZxMGNtREFRZlAzVEVzL0Rp?=
 =?utf-8?B?NENPMDEwSmhJdkU2VnhBMDd3dHJPejN6dlNmSTJhdm5wRm5ZVUFneDUvbDJZ?=
 =?utf-8?B?UDdDb1lQeDNMd1FCRHVsb20wdnRMWFZTNm5ndGppOE43bEM1ckpoNnA5OFBr?=
 =?utf-8?B?bVIxbjJFdEV4UWlWVlE3TmJOalc3RStseDMwdlhWT1htekNGWG9YSEtLWm5q?=
 =?utf-8?B?TjA5aE9PS1lSV1Y3NnNkazN5U0xRcGNLbXVNSkRJaXlLdkpaaytFZlNVOCtE?=
 =?utf-8?B?dTIvcmJPdUdvRmtXYVJHMVNQN0JMZFBGMUd2U2xoZUF1L0Zsd01nT1FUMlhq?=
 =?utf-8?B?Y0p2dit4RjlLUlZhOWNoZ2RaNnhMckxLa3N6aDIwTUU3bE5jb3Rld1JCVGpw?=
 =?utf-8?B?Umh1TFd2YUlPNXp3Zit2RHFsUkd4V0xWWHhnclJFZEROV1hHM29LRVI5WkZR?=
 =?utf-8?B?R3dYdUlNY2N1UjAvZE1DWitRK2lOR2QzWXpEZUQ4ZXBtbWhSYXlLTVNRU1Bw?=
 =?utf-8?B?c3RGZmRIMGZOMjh4Qm8xVEpjYkxmeGxvL1YyRUxFTkYrUS9oWEQ4ZlRVMC9V?=
 =?utf-8?B?VzBpL0d3WE5KRkF3dzJMaGZWc2ZEOXJOd2h3enhJZ3hXR2s4QzZFdmZ4cjdo?=
 =?utf-8?B?T291MHRFek1qMUpSM1FiSUloeG9IN0VIQU8xaUkxUlFUVXljTFhMeCtGVloy?=
 =?utf-8?B?RlN5WVByWEE5eFcxcmdUSGZWaGdzZVk4Q1FKS0o0KzNuQ29PZEtTYWRmRnc5?=
 =?utf-8?B?ZzRCUmJ3WXNOdUczU1JmdnZMb3Z5cUtQR054R0YrVGpZV1NiVlhFVWxSeDZW?=
 =?utf-8?B?UWNkNTFneTB4bGNOMWRWbEo5TEE0TnhPaDZZVEpwRCs0c2tESG1kTzdoWmto?=
 =?utf-8?B?M1lHYXdkVTVaZnV4RERaUzZMMHcza0RxUnRCQ01wLzZyQ1AvU2VybGFENGZv?=
 =?utf-8?B?ZjVBRW5OSGdmcVlVTVphU1c1UWhXZTh0NHlUMDZ2L3ZXNkhHZTcyYWxRTXZK?=
 =?utf-8?B?aUMyQkdkd2p5WEN4YXh2RjIwY2JjUzJHVXU2V1Vmb1QyWkpaR1k3eW1WTDcy?=
 =?utf-8?B?NGhpTHFZSkNiOXo4aXFiQnJOc21Jd2NGRmxNRDVhRWRMYVpZbGhhYmFUYkVE?=
 =?utf-8?B?c2hIbG51cTc1QS9ZbWVpOExZcVJ6VjV6QiswcnZtWnE2UFkwdnRUNUdRdTVL?=
 =?utf-8?B?WGlNVXVSY3VrbGhKQ3RYZzRqTjI0aG84dHdqNG54YVFON1NHS0RpbjgvL05O?=
 =?utf-8?B?cEVwQ2ZTdCtQcWFrYUZYTWUwTW1wMGdBYTJEV3ZFZ2lkWTRobTJjaDZVM3dp?=
 =?utf-8?B?WXFsTGlRcVViTkVhOXREQ1RJZFlWLzhRQ2FHRG5tU2E5Q0d2ZXRsNXl4dDUr?=
 =?utf-8?B?bTE0ZzdBaFcrVnVWdFlZZG9yWmxZZ1lMOGw0bGJBZDFhTkE2WmN0V3lkbnZB?=
 =?utf-8?B?NDJCVW5BeEhpQ09Lc0dqbHhwYVlzekV2WnF1VFVVMWtGNHNOWU95T0k5OG5y?=
 =?utf-8?B?cE05eHF1OFJ6QWJoRDBGY1ZCY1Z3SWgrUUpOZXRYTkdydWwvUWF5WWRCVXlX?=
 =?utf-8?B?QVRUcTgwNUg0WnRSTFUxWmZ5a3BnSFRtOHM2cllyNU9zVW9PaTd1Njk3U3lP?=
 =?utf-8?B?dFhUcC9HNzUrTFBNTVBrc0V1SDMvTC81MDhUWjd6Rkt2OFZRdlFxeU84REQ0?=
 =?utf-8?Q?82zKM+MERuK57ePDRUdF+xKdf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4cf88ad-b4c4-4204-741e-08de36d2b782
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 03:26:18.4171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9bJ4KXpgOjzj84J/L710kNeq5YEs0MHB6IYfpHVy30HDNjdgeZnTvAdlUlm1Lp0Z2khzG4DXc0HkSI9cBuI5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5895
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12; envelope-from=yi.l.liu@intel.com;
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

On 2025/12/9 10:30, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Shameer Kolothum <skolothumtho@nvidia.com>
>> Subject: RE: [PATCH v6 00/33] hw/arm/virt: Add support for user-creatable
>> accelerated SMMUv3
>>
>>
>>
>>> -----Original Message-----
>>> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>>> Sent: 08 December 2025 10:08
>>> To: Shameer Kolothum <skolothumtho@nvidia.com>; qemu-
>>> arm@nongnu.org; qemu-devel@nongnu.org
>>> Cc: eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
>>> <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>;
>> ddutile@redhat.com;
>>> berrange@redhat.com; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
>>> <mochs@nvidia.com>; smostafa@google.com; wangzhou1@hisilicon.com;
>>> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
>>> zhangfei.gao@linaro.org; Liu, Yi L <yi.l.liu@intel.com>; Krishnakant Jaju
>>> <kjaju@nvidia.com>
>>> Subject: RE: [PATCH v6 00/33] hw/arm/virt: Add support for user-creatable
>>> accelerated SMMUv3
>>>
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Hi Shameer,
>>>
>>>> -----Original Message-----
>>>> From: Shameer Kolothum <skolothumtho@nvidia.com>
>>>> Subject: [PATCH v6 00/33] hw/arm/virt: Add support for user-creatable
>>>> accelerated SMMUv3
>>>>
>>>> Hi,
>>>>
>>>> Changes from v5:
>>>>
>>>> https://lore.kernel.org/qemu-devel/20251031105005.24618-1-
>>> skolothumtho
>>>> @nvidia.com/
>>>>
>>>> - Addressed feedback from v5 and picked up R-by tags. Thanks to all!
>>>> - The previously split out _DSM fix mini-series is now accepted [0].
>>>> - Improved documentation about the rationale behind the design choice
>> of
>>>>    returning an address space aliased to the system address space for
>>>>    vfio-pci endpoint devices (patch #10).
>>>> - Added error propagation support for smmuv3_cmdq_consume() (patch
>>>> #13).
>>>> - Updated vSTE based HWPT installation to check the SMMU enabled case
>>>>    (patch #14).
>>>> - Introduced an optional callback to PCIIOMMUOps to retrieve the MSI
>>>>    doorbell GPA directly, allowing us to avoid unsafe page table walks for
>>>>    MSI translation in accelerated SMMUv3 cases (patch #16).
>>>> - GBPA-based vSTE update depends on Nicolin's kernel patch [1].
>>>> - VFIO/IOMMUFD has dependency on Zhenzhong's patches: 4/5/8 from
>> the
>>>>    pass-through support series [2].
>>>>
>>>> PATCH organization:
>>>> 1–26: Enables accelerated SMMUv3 with features based on default QEMU
>>>> SMMUv3,
>>>>        including IORT RMR based MSI support.
>>>> 27–29: Adds options for specifying RIL, ATS, and OAS features.
>>>> 30–33: Adds PASID support, including VFIO changes.
>>>>
>>>> Tests:
>>>> Performed basic sanity tests on an NVIDIA GRACE platform with GPU
>>>> device assignments. A CUDA test application was used to verify the SVA
>> use
>>> case.
>>>> Further tests are always welcome.
>>>
>>> I see PASID capability is exposed to guest but no pasid attachment in this
>>> series.
>>> Was the nested hwpt attached to SID instead of pasid?
>>
>> In ARM world there is no specific PASID attachment. ARM uses a Context
>> Descriptor (CD) table indexed by PASID(substream in ARM) which is owned by
>> Guest. Hence, no specific PASID attach handling is required in QEMU.
> 
> I just realized a nested hwpt in ARM is “stage2 hwpt + guest CD table” rather than
> “stage2 hwpt + a guest s1 hwpt”. When creating nested hwpt, guest S1ContextPtr
> is passed to host rather than a stage1 TTB. Do I understand right?

yeah. ARM SMMUv3 and AMD iommu does not attach pasid to host explicitly.
This should be done in the time of enabling nesting.

Regards,
Yi Liu

