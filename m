Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA55AD0C5F8
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 09:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Gtg-0004Fu-MO; Fri, 25 Oct 2024 05:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t4Gtc-0004FJ-Jp
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 05:46:16 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t4GtZ-0004V5-D4
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 05:46:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729849573; x=1761385573;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=N1CQ5l7C+pPmbo6g3VOerMfSuOvXnFBXkiid93lj/HQ=;
 b=gnEaSf/bq146BFOn6/pYZDd2ePwjrMs2kV/u1qoXOmHEFXfsNJXvBxuH
 CWd8j5RuFgL0VHMqxH61e52YdwVUaJfzh7nn52JJR55EoxvVDdboU+kUz
 7Vy8KhY0PfWTM0c4iFtcqA6BcCO42PXcvjF+p2ksy6EYScDo2s7uaLHAQ
 IiC6QtgZCRdfXjGRCvpY1dYraGdKj5Em2Ce7EnlzGB1RmliX6lNF2wkWC
 zXVkjbSsTNGefkShaNlw9hYWVLyfsEc4iMc1Rv83rEnn0UK3O2b4LvPsL
 D32DHYeQBL0vGLQGwEjBb2gNCFsWNHEydtdklssTuyixgbvGOh+HdWUl5 w==;
X-CSE-ConnectionGUID: ytg8bHpfQJWCaFzoUIuPNA==
X-CSE-MsgGUID: Kh+3bPYORTa78vbTLte0kQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="46996120"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; d="scan'208";a="46996120"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2024 02:46:07 -0700
X-CSE-ConnectionGUID: iJ7FVKzoT5+mBBn7aj2AVg==
X-CSE-MsgGUID: 0SW5JO69R5ijxbDCdEQ93g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; d="scan'208";a="85450007"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 25 Oct 2024 02:46:07 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 25 Oct 2024 02:46:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 25 Oct 2024 02:46:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Oct 2024 02:46:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBH7dQ3gb2Z4OKIYVDKAcXL7/3ydpzkfEX6egjiVnxfR2U0QWE7Oh+WRKM5w9bBP0a0zCPR1YPZqA4jH2BmIOJgG5/Zi9LjZulMtR3BGOrbitAdyiY2dtqOjCXkKrPlg1B2FGy6vMINLKqIFeA4KHA8pBCoYwYxV9BAYemMz3zwufuoE3OB7A2ZGoXAuqjk9uBdo8jatr4JCvpJhNuafGLOI/MwAogiEpBKBdpK+7JHSOxCDDxI6RnUOYrELhKByz2IgxDBaZLA+LK5dcC+sNyMnFViceDbYg9KwdZVG3vcPXnMNwQGqXYa97R4mjeHnuSL6astG4IH/ngE7NBoz+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsJjDXULLnO4jZLRRYd8rjks2vqBD+1HUgOwvD4Uw58=;
 b=DPtxjuERJNsUKHqrp/gHwgtCjNp8/DSo8Hv4D+2eTuiOmrHhcZBFks1r5ibburjs/htsaF1DnfDVnpFNR988IFx4s8QkRCE12bNcXza0LKo4vqCO4HDAZfiYdTBhtkwAxNFloXbLGjuWoz6VLi9guPU9Da2ldQ/HXlsbQkmtNw/TBjkCP11jXBSoSWdjFshVaMBVxxmlPSC1ESyPCPnTavYjHxJZueIHEBUDFRPTSMXCA5XEJHceF7nsU+p4alPIjhszuppPulMU0nXrqw5vsodDnjW2AmtppqtZMEpGjx2fs5KltVhThKPX2gWHOOaBpY5dbDmTMRegh9pn2EvRrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by BL4PR11MB8821.namprd11.prod.outlook.com (2603:10b6:208:5a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 09:46:04 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 09:46:04 +0000
Message-ID: <edf51f3c-1fce-4869-935e-884790f1d66e@intel.com>
Date: Fri, 25 Oct 2024 17:50:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] intel_iommu: Introduce property "stale-tm" to control
 Transient Mapping (TM) field
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <chao.p.peng@intel.com>, Jason Wang <jasowang@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?=
 <clement.mathieu--drif@eviden.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20241023075753.580534-1-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20241023075753.580534-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0207.apcprd04.prod.outlook.com
 (2603:1096:4:187::9) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|BL4PR11MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: 74eb8edc-5950-4580-08ea-08dcf4d9d704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MlJENTZrVndSVUJmZUl2ODQrdjM4NUZyMDVqMGhqdVhQQU1IV05mY2FzQTIx?=
 =?utf-8?B?bk5hS01NTDFUbzI3czFYMTdHd2l0UW0vMDNQMnhEOGxHQlo0MDEvUklsbVQ1?=
 =?utf-8?B?TEgzR3pObVBjUXVJK2FqQ1cxejJTTjlQSThrMWJFblhRZXdZcFJKSlRJVXFu?=
 =?utf-8?B?NStyWkVTRTgrRkFHU1Z0KzRBYWpNeWhqZjVhb3Ftb3AzTllkditYRmJLYzZE?=
 =?utf-8?B?UFkzbUI2UVVRbjBOQWl2enBzRGJWYjNlYStmQTdTMy9xSVdEQWZqV2tvR2E0?=
 =?utf-8?B?WEUxRkExUHFrRHh1UE5rSXBlT1IxNmRRc2pMSDRqTG1KVmRibmplWmFLY2V5?=
 =?utf-8?B?RUZlWmgwRytOT0NMZlFreXFaSFEvb1czbzBmbURvaGVmVm1OL0pIekwwWHdZ?=
 =?utf-8?B?TUNUNk96NkVrRE1WRVJFQmEySXZWRldHcHJtaXhFZVR0cHZGdUhqaWNUT1Js?=
 =?utf-8?B?YjM3RHlwcGtCWXA3UytSZDlDcEIxTFpXWFM4TVN2bzBnTkRaUC9uaDlTdytC?=
 =?utf-8?B?eXVpQTYrdmp2UGlrV0hkWlNjMSt4Ni9hcHoxOVRRU3Z1Wm9SeE9Mc1E4dFQ1?=
 =?utf-8?B?djVZSEhlczBFcHpNZHo2emw4ZnZWWVF2Z2o2NW5acU9Oam80YkF6anhYZG4y?=
 =?utf-8?B?UEUyc2QyRWlMMU9IR2paSUpwcGhFMnhhTFNOdUZIcHB4WHYrV1ZRMkk4WXFz?=
 =?utf-8?B?UnJ5Mmg2NXZuRDcwZ0hrd2IwTFZjbFIwVHFqMWlualdaVDYweEVSRW0wWHVO?=
 =?utf-8?B?V1ZqTlVHS3FJbmFYVlUzY0ZUMk9nQmEvekxZSFNrWWpCa3B1U25hMGZ4citB?=
 =?utf-8?B?eFRBa2hNU0haaUdGcTlWcW1pNWNaZFBBUlByMGxkQ0tuVy9QVlhCbnZ2MlNr?=
 =?utf-8?B?TWppdWRVc2xKamErU29seCtDa0RteXY1TVhwdmlwQUNWZzZpVjdPQytNd0Q0?=
 =?utf-8?B?YlNmQnRSTHVOemp5Tk0rMHMvdnFLdEp4UlVNdFhkVUdxN0ZmcWpDbVkzNXBm?=
 =?utf-8?B?azRDOVRacHB5YXExV0taYi8yYlpzcTExNGV3VGVsdHdhVFNtQlBuaG8zUkMz?=
 =?utf-8?B?blRqVkgyYnhxZjhkbHpjV05mVkF4M09UM0ltZWVoeVpuQlBBL2x3eFVrTFhQ?=
 =?utf-8?B?ZkxvSFdaM25LbzUyZVpSRE84OVFYYldnU2NBUkpYVDk5NmhYek1Ueis0cFI0?=
 =?utf-8?B?eVkvbGYrUzdBeDJxN2ZTTnJBUTNxUjkvQjdRTDdRQ05tT05yN2hnRG9VK2Qw?=
 =?utf-8?B?dnNCYnBPeU8rN056U1J0aktjTHRaaDErWFRUYTQwNWRQUkNpT0hNTFVyYUp2?=
 =?utf-8?B?bThpTXV1OEE4SDFlQlo2WmZVMlJQYzhkbzVPMDl2QTkxZWc3VFRXTWVOYnZi?=
 =?utf-8?B?VjdkRXNVUWNJTDVrVC91SFdxZ0h1ODg0Uk5Ma0FwUVlYa1NvNWVub2FKeHBa?=
 =?utf-8?B?dFBWWHdaWDlnVTNRVkFGTVpsREc4MDVKK0ZhV0N0cmpIYTB6bk9Od2lzZ2V4?=
 =?utf-8?B?RVdzNEZhVDZXMGk4MER2eU1oTm9KclIyaHQ5R1p4RDVXR3o0RVpBYzBIaE0x?=
 =?utf-8?B?ZG94OGVZRnRmcUpCY0dhN1Z4Vm5mVXlYQVJSN21UZWMrME4wOUY3Wm5MUkdF?=
 =?utf-8?B?YTF3cVZ1YncvMDFmcVU1eFJvSGNjL0lCTFlQYU0wb2ZMQTVHQUVsMTJnaitL?=
 =?utf-8?B?WGJlVFVWVUxNMHFOVm1hSEhBSnNzdHZzQTNPenVNL2FaNkI5cmRHQTB0R2tR?=
 =?utf-8?Q?0UF5HHrH0H2ewjjWTRNK16EYFHqvcRLM33CVNok?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmRVWG56bkdxaGNTNzQwOGZDTVlFTTY3cXZoVlVQZ1RyN3Y3MWlBOUw0Uklk?=
 =?utf-8?B?aU9QYUhGWnBsOEV6b2N4Mmdxa0lFTFFYR2JxU25VaEc0enh0N3ViUThqeHc5?=
 =?utf-8?B?ZFA0TDdoT1lTL0VXV0J3b0wrRlowYkpiNk1sVGxwOWV1QnFENVNWaWVuaHNy?=
 =?utf-8?B?aFdOUkZJaFp2ZGkvSUtPcE9PdGN0WTFjUVRuV2Q1VEh4UG5SQnE3ZGNUa2hM?=
 =?utf-8?B?M3dFV2QraDI0U0laWWNmTUkrN3BFUFVKSzN0eDZUTzJoWGxkcDJaTHJOT2s1?=
 =?utf-8?B?UC9jRjd2eGFEUnBrSzQweU1CVGZxd0JKQnliTGlQVU54UW1yVlJ6L2tYVU1J?=
 =?utf-8?B?S0RkUEp0VjhLMHBpU3QvZ2xTRmt4bmZXTjF6QzBSdDVud0hsbHg0NVhSaGEr?=
 =?utf-8?B?ZkMvQzhDbWs4NFNuTmFqaHVOdWhyM1ptSktlUDJLbmUvT0ZxNlI4NmtFRWxO?=
 =?utf-8?B?Q1U0dyt2Mldpa2Y4ZmMyam5HTEFQSlZWaVJMUlk5OHNEbGMra0U4QnRnZ3Fv?=
 =?utf-8?B?KzhUcDh3MENOL1Z3Y1JpQXZXWStzVFV3VnlMZmlkckdYQ0s3b0pTVkUyNUpl?=
 =?utf-8?B?OVREUmZ3UlFad09uT1Rpb1NSVjhxZlBhKzM0cDlwaG1UdEVnbGl1M3QrRkZN?=
 =?utf-8?B?YUN2QlNPNmpwTTUwelFkNEtlVjh3QkF2N2lvZ2J3Q3cxbFUyMmFUUVB1YnZO?=
 =?utf-8?B?cUVCaXlYR0kydzRPNzZrK04zbVVLT01PZnhUdUpaby9XZnRrUmd5U1J1Z1Av?=
 =?utf-8?B?OG1FelkrSzlmeXR2MS9GS3lkckgyRit5cnBIa2lCbHZNeUg0akRyY0RNdDVz?=
 =?utf-8?B?d3VCaHpOSW1PV2dRL0pnb1R0bHFkUnNHdFl3S3dhUkZVTEVRRWFrWkFsdGt1?=
 =?utf-8?B?VGpJMk5ad2RvbE04ZU91QXJxekxEbHdKa2k5Q09PZWoxbmc1Ulh2d21ETXA5?=
 =?utf-8?B?MTZiQnFzWExiUnZ0eDFCQ2VXZTU4a2NkNml4dFpzTkdkRGdyUnFUZ01xdnFm?=
 =?utf-8?B?czlpemdtT3BZT0FVMzd0VlpTZy91TjZJYW8wRDUzVmd0VE51VU5jL2dRTUlC?=
 =?utf-8?B?aU5CeGJqWUhSb3gyVkpHU2RmT0JpdXBHT01lUzRveXpwZjVuTDA0Q0tLWUhQ?=
 =?utf-8?B?bDB3enFCVWFmcGQvQ0RVYVArUnhZQmpwQ0RyMlJTZnlrRFU1MjEvZVpnejJj?=
 =?utf-8?B?bTJTTHZYMjA1VERVVjZ1d2JMTnR6S0tBUzdsaWJMMzFsN0ptbzNwdDYySEFx?=
 =?utf-8?B?NEZDbEo4K0lDU1RDTU1TNng4MXJhbTA2aURjbyswKzBWMFZxTmJ4VzBROTRK?=
 =?utf-8?B?V1JSZUxOOVRrVzZCUVdMZUI5T0dKWkViMGlSbnBpSmE5VEJzK1I0c0E3RW16?=
 =?utf-8?B?WG00c3lHaSt6ajlMMWRReVdsODVJd2JuZHRHdU10TWlnTitvT1F0RkR4c29w?=
 =?utf-8?B?SndJZHhObmZGUXlmelRzZ3MwS3kvbkNNNmx2anhudnpMVVBYV3g4ZVFGS2Fq?=
 =?utf-8?B?RGdjcTZ4SVI2cGVHRmtoamtVa09ablFhQVoxQjVsM21HekdwRU1CcExBV0Ft?=
 =?utf-8?B?RmVta0xzRFJKK0VHdHlSQTlZNW1wdlloNkNtZ2RlNnlTQWJUUzkvM3JTL243?=
 =?utf-8?B?TXg4Titlbk9NZll1a08rcit5VU9IZWt6bUVReWFwVnFUZng5RjM1RjFubHNi?=
 =?utf-8?B?c0FFYjNibm9EdlY0Q2ZWdE8vRkV3VkVoVHZ2S012WWZpcXFCUG9RNGg0ZFp2?=
 =?utf-8?B?cjNlcmhTOHJoc2VpVlZWQ0FGbVo3MVB1eVZITzQ4MlBOZ0dXelFXdzIzSVlz?=
 =?utf-8?B?MklocjBCQjYwZCtLbmc5Y3FTY2swZVhiYWFtbDk5ZkluRUVqVTVTSDYwcE1U?=
 =?utf-8?B?Q1RhRmk1bTVLenZjUDgwSUxEMmxjakRvZGMzaUtHNVVyNHVlWGxhM0FqRkhE?=
 =?utf-8?B?YlA5K3FFaXpKdFlyUW0xbThEM0ZRRjJwNTZFOWtzYW5DRjhhUmJsbW1Da0xw?=
 =?utf-8?B?Z2NMMVJRNnQyY1dLWW54dUovenRQUkNraEJpa0JPeVpSTlljeUxoY1RrMnFs?=
 =?utf-8?B?WVFPcE13Sm1uTjJ3VnZWbFVFR2NITEdZa1h2a0pPZFpIK1NQLzNDa0VoSjZF?=
 =?utf-8?Q?YEJKL6LaCJUoRUTQqRPnGIlAn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74eb8edc-5950-4580-08ea-08dcf4d9d704
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 09:46:04.3698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oruBJxI4tOsL3O7tAaoARo0VlTjT6WW5GHqqM6n0bDtLBbs8yRXm1n1mTI4lhBa2LoDC+bVDIOfPlglQh2PxSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8821
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
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

On 2024/10/23 15:57, Zhenzhong Duan wrote:
> VT-d spec removed Transient Mapping (TM) field from second-level page-tables
> and treat the field as Reserved(0) since revision 3.2.
> 
> Changing the field as reserved(0) will break backward compatibility, so
> introduce a property "stale-tm" to allow user to control the setting.
> 
> Use hw_compat_9_1 to handle the compatibility for machines before 9.2 which

is hw_compat_9_1 a typo? Looks to be pc_compat_9_1. :)

Otherwise I think it is good.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> allow guest to set the field. Starting from 9.2, this field is reserved(0)
> by default to match spec. Of course, user can force it on command line.
> 
> This doesn't impact function of vIOMMU as there was no logic to emulate
> Transient Mapping.
> 
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
> v4: s/x-stale-tm/stale-tm (Jason)
> v3: still need to check x86_iommu->dt_supported
> v2: introcude "x-stale-tm" to handle migration compatibility (Jason)
> 
>   hw/i386/intel_iommu_internal.h | 12 ++++++------
>   include/hw/i386/intel_iommu.h  |  3 +++
>   hw/i386/intel_iommu.c          |  7 ++++---
>   hw/i386/pc.c                   |  1 +
>   4 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 13d5d129ae..2f9bc0147d 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -412,8 +412,8 @@ typedef union VTDInvDesc VTDInvDesc;
>   /* Rsvd field masks for spte */
>   #define VTD_SPTE_SNP 0x800ULL
>   
> -#define VTD_SPTE_PAGE_L1_RSVD_MASK(aw, dt_supported) \
> -        dt_supported ? \
> +#define VTD_SPTE_PAGE_L1_RSVD_MASK(aw, stale_tm) \
> +        stale_tm ? \
>           (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
>           (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
>   #define VTD_SPTE_PAGE_L2_RSVD_MASK(aw) \
> @@ -423,12 +423,12 @@ typedef union VTDInvDesc VTDInvDesc;
>   #define VTD_SPTE_PAGE_L4_RSVD_MASK(aw) \
>           (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
>   
> -#define VTD_SPTE_LPAGE_L2_RSVD_MASK(aw, dt_supported) \
> -        dt_supported ? \
> +#define VTD_SPTE_LPAGE_L2_RSVD_MASK(aw, stale_tm) \
> +        stale_tm ? \
>           (0x1ff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
>           (0x1ff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
> -#define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw, dt_supported) \
> -        dt_supported ? \
> +#define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw, stale_tm) \
> +        stale_tm ? \
>           (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
>           (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
>   
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 1eb05c29fc..d372cd396b 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -306,6 +306,9 @@ struct IntelIOMMUState {
>       bool dma_translation;           /* Whether DMA translation supported */
>       bool pasid;                     /* Whether to support PASID */
>   
> +    /* Transient Mapping, Reserved(0) since VTD spec revision 3.2 */
> +    bool stale_tm;
> +
>       /*
>        * Protects IOMMU states in general.  Currently it protects the
>        * per-IOMMU IOTLB cache, and context entry cache in VTDAddressSpace.
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 08fe218935..8612d0917b 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3372,6 +3372,7 @@ static Property vtd_properties[] = {
>       DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
>       DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
>       DEFINE_PROP_BOOL("dma-translation", IntelIOMMUState, dma_translation, true),
> +    DEFINE_PROP_BOOL("stale-tm", IntelIOMMUState, stale_tm, false),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> @@ -4138,15 +4139,15 @@ static void vtd_init(IntelIOMMUState *s)
>        */
>       vtd_spte_rsvd[0] = ~0ULL;
>       vtd_spte_rsvd[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits,
> -                                                  x86_iommu->dt_supported);
> +                                        x86_iommu->dt_supported && s->stale_tm);
>       vtd_spte_rsvd[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
>       vtd_spte_rsvd[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
>       vtd_spte_rsvd[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
>   
>       vtd_spte_rsvd_large[2] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits,
> -                                                    x86_iommu->dt_supported);
> +                                        x86_iommu->dt_supported && s->stale_tm);
>       vtd_spte_rsvd_large[3] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits,
> -                                                    x86_iommu->dt_supported);
> +                                        x86_iommu->dt_supported && s->stale_tm);
>   
>       if (s->scalable_mode || s->snoop_control) {
>           vtd_spte_rsvd[1] &= ~VTD_SPTE_SNP;
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 2047633e4c..830614d930 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -82,6 +82,7 @@
>   GlobalProperty pc_compat_9_1[] = {
>       { "ICH9-LPC", "x-smi-swsmi-timer", "off" },
>       { "ICH9-LPC", "x-smi-periodic-timer", "off" },
> +    { TYPE_INTEL_IOMMU_DEVICE, "stale-tm", "on" },
>   };
>   const size_t pc_compat_9_1_len = G_N_ELEMENTS(pc_compat_9_1);
>   

-- 
Regards,
Yi Liu

