Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B30ACFD376
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 04:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOpyK-0007Zu-Tp; Thu, 27 Nov 2025 23:20:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vOpyI-0007Yv-S7
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 23:20:38 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vOpyF-00011i-P7
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 23:20:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764303636; x=1795839636;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3jLGy58vpuL+1O+QYTMN+GFgVWZAH5A5LSDWgt9UQss=;
 b=bRmtoZ8xwkXWv+uwrbhu/nyyA9+TZj5/g1blll+ZSuiPORTc7rzHRXwO
 AMSj/oYCg1MxMt8T0sWzMDZLCG/JBKBKRE1NenoShmBeqtwkpKHASuoP2
 kPxr7OpWcTIdlksyY6xCglJCOVPGdF1kB36oIjq9PJqDQpInkMzFIs6bc
 CqBvTes/iCNa6n432x2Ho3TASJPmDgCLSf1bJuQOJZ2NLI3Ql9rzxbkOh
 skCYxfDoD1r+5fYGD418h1Zgc+Qzz8XIOr/hhVevbacxEh6tlYUlVE0OE
 m45FKUiqSgopcSldIDephhGXbonBccbK5HJa6yOBLk71lCdJ5Y6SFPs0w w==;
X-CSE-ConnectionGUID: bX29ovZiTEC7gHht0EDeZQ==
X-CSE-MsgGUID: GPCa17AyQ5WHtIJhKU2mYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="76663067"
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; d="scan'208";a="76663067"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2025 20:20:32 -0800
X-CSE-ConnectionGUID: PLfkgodlR0O/sklKL89wtA==
X-CSE-MsgGUID: 1MpNW04LS4qZStZ8Jn/Tfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; d="scan'208";a="230649753"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2025 20:20:32 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Nov 2025 20:20:30 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 27 Nov 2025 20:20:30 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.14) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Nov 2025 20:20:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfaFP/wRQXay79Xm5lGv3oPu0QS+nZqU40HejbSWWoUvIFd2oz3+KPH9eKEr6/REj5CctIyhCUVFkGa2Thwaj0kiYKRCyn/e6nLUO2Vl9vjV9/rToCnTA1UJpLEVx3N4LV9OxnhxDXV6Bu6G8MqQlqy05hJcGQycVjAiPp4Fr3LuNXnij90+PXEbd6du1+NUXl6pffptlhNFOqN2t+GbQdBAxFote4BXTOBUKrW/zr+k31pziXaGOMUn2+46egkcN0Yo2XTVm5BCAKG62epXoPfcUleGRyZEUUTvoFuntHbNZDwZYVYUIYwPBFnJxDiPDIeA7epiW1dPyLLuRm3UDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l44yQNYI28xVjsbFJ4bgCiA1xqyPxXoSetdnAWdMP0o=;
 b=bVguglYbMUI8BrdT1YExIQ8F6syqk+I+MIMhOkECZNLRterGlGyjikDvo702yQiukGXUpZcaxdf6YQnhW4spd1eO7UYMTAFftX1CZ8hz9FHG8H5Fe8kJD/RuekdmUxnzVYM6aQsXmcA0IjCteE+Szv3mBp8uxEYVPGiOhqWKketgFTCoCxTOPo6iwkmUbyWmfXnsqnA3Hhjqm/gDagI3CtSu8jOh+ZD1iofoQeN4ALw2tqwGVv0UGs8Hw+YMhz2eK2iNZxgZ5DM8qCYL8LQm63uhwZ9/3tDJrqI559CwPcY5Gn4hjiKxmIef+Q86XAhBYiqofcNnI5womBPYSWnpkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by MN0PR11MB6302.namprd11.prod.outlook.com (2603:10b6:208:3c2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Fri, 28 Nov
 2025 04:20:28 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 04:20:27 +0000
Message-ID: <f6a7959e-d004-483c-bcd1-bcd66c1ad295@intel.com>
Date: Fri, 28 Nov 2025 12:27:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 17/23] vfio/listener: Bypass readonly region for dirty
 tracking
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "skolothumtho@nvidia.com"
 <skolothumtho@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
 <20251117093729.1121324-18-zhenzhong.duan@intel.com>
 <DS4PPF93A1BBECD8E078A7FB081E0AEF07E92DCA@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <DS4PPF93A1BBECD8E078A7FB081E0AEF07E92DCA@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|MN0PR11MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 82ce4696-7fd8-4be8-f614-08de2e357546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|7416014|366016|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TUdIRFB0ajNwWTVQa1RxR1Q3TDIyMHl4SzZCdm5RYml0S0tqNXJrN1psd0ZD?=
 =?utf-8?B?QjFNaTBjMWpZcS9qUFBwakRHLzNoTG94OUI0Z1R3OXpleTMzeHRMNGNXelN2?=
 =?utf-8?B?aDNLN0pQaXk4RVMwUllURUovTTc1Yks2RU1penNDajVkZ3pyY1pSR0tpZkNn?=
 =?utf-8?B?ZFBLcnYvMVlXTTBmKzlvUUhzL3U3VFNGb0J0NmYzYzlPdnBldkc4TFpIZlRv?=
 =?utf-8?B?NWN4UkdtNWRjajBQcmEwUkZSU0RyaFRIanQxMmVrTGtSTW16VUNvVllCUkQ4?=
 =?utf-8?B?clhWNEt5aXhXZStJNVdScmtpYzlxWVRId3dZNFRvREZNMnlkM0RlMUZwVk9s?=
 =?utf-8?B?N3NmNlY4UExYMUtrT3YzSE5Udk4rbjlaMUR5QmxuRTFqSVNkUGZGZWtaZHNF?=
 =?utf-8?B?Q01jYVdXekxzOS84U3U4WndnRGVEMUZFb2Q1Rml3ZG1KbU5CNHNCbGsydllj?=
 =?utf-8?B?bnptU1JLcjB5VXBVbWxsZmhDVWJxenJQdUdMQUtIOSs3T01wOFBuTlNMcTJL?=
 =?utf-8?B?R3NJNCt0ZWMwU2dVQUxmRkNuVjlRd0NXZzczbUVIaUx6d2JseGJUZm8yeDNY?=
 =?utf-8?B?emYvV1pGQ1Y5U0szU3BIbVluR3BkME44V3VJYmdSZFpqVTJPSWFNd2pmbXpX?=
 =?utf-8?B?OWFEQjFwb2JnVDVwSXpxOWQ4WHVUODRDRS9aWmFsU2Riekh0UEtlVUIyNXYr?=
 =?utf-8?B?dTZYVzBHMVNTNGJCZGVNMU4vMHVveG0xNUhEeUtXMWZtR0JVczRMWnR0ckIv?=
 =?utf-8?B?cWgvTVZPNEUrWnBmY25WL0h5VjlCUmNLNVBFUDBCeS9uNnY3Nm53WHVlRjlj?=
 =?utf-8?B?WFJjRkJFK3dPTTI1SUN0VWNYTDhFa1Z3cGNaVFZZZVprRUNzSXJoSTFyY2Mx?=
 =?utf-8?B?WGJCWTJDOFlkNkx2UkRVY1dHYk5XaHN6dTNzQ1liOE1GdWxHbk9Id25WejF2?=
 =?utf-8?B?N1FDWTlsMEIxem1YdHhzaCt0NSs0L1k5cUplSzI4Ri9iM2hkSWVyVmhiS2Q2?=
 =?utf-8?B?aFNKU3dWUnNTMG9aU0lBdmhMeFU5ZFpzMVJOSUdZeWhRZEJrdVBhSzF6TStX?=
 =?utf-8?B?d3cybllMalVxNWNvSUpQejBiRGJyZVRNV0s1TFRKTTFZcUdacXk4d01Vd2Z2?=
 =?utf-8?B?dUdQNERQR0ozOGJYb3JzTVZuRnRMSy9KRTg0MGZQMG00VnR3REI2TDlxTTNn?=
 =?utf-8?B?aStkWUxoQXd4c29IOTZJR3ZwRnVZbC9Ccm1mcG03RWc0OUt1VGtTMVRSbktC?=
 =?utf-8?B?a2dSQ3BUdFNNNmJqNHpJdDl0SVJzYUdUdEEzd1U2Mkp3Z1R3eE9DQzErUVdX?=
 =?utf-8?B?R3ZnUEVwVGowelAxeE54UVNKM04zd3N2QnNZMEQ2aWZjNHRFdm9Zd1NWMEdu?=
 =?utf-8?B?Y0Y5TlgvMjN6Y2I0M2JMbzdPczVlaVZnWkZBeElxUDQ1bW9BcWd1NlBkcXVE?=
 =?utf-8?B?SVVuUzNKYWorNzkySWI2emVud1hkdXJOWTNsR3pyb2o0NUpvUXRDY2dEOGVJ?=
 =?utf-8?B?TGhhZ1FmbVc0aVU5cTRONjNvcUJZbUNmb3kxeWtkZ0gvK0lxYWFNb2JBa3A0?=
 =?utf-8?B?MFpZcDl6akdKNTdHalB1OFFDYXlpNXE2Y1VZRkxST3NwWXFRZDZ6Y3d0UUNm?=
 =?utf-8?B?MW1uS2gzZzJZeVAzY3ZaRnNkUmE5LzJoemhqR29aQitEOUpVUFVuME4vSTNX?=
 =?utf-8?B?cG1sOWhpQk9KcEp6MnJoUUUyaGF3cGo1Z25BaHlLdFAvNnBmYlR5Q28rTTVH?=
 =?utf-8?B?MHVjZEo1WG9wK2RhVzJMc01rdXV3MzZwTEd6WlBpQXRMNE9xZEtxQ25rdUo5?=
 =?utf-8?B?ZXdVQ3A0cnpyc3BoamVwVWtHY0xQWEd0Tml5cFpuaTRDUHJZNFdEOTdZT0FY?=
 =?utf-8?B?bzdtdkxXejUvaU9wT0dMNnlvYmdKWUtlYXBocnY0WGgrNFZ1bHZqd0c1VXpr?=
 =?utf-8?Q?l4ro6MYQj3OHNnSwrJqGkkr3m4sGoSvA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(7416014)(366016)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1hXVFlkRXp2ZGIxK1pxRks3dFhqTDY2N2QwU29FRWZNazlLeHlJNnZYcksx?=
 =?utf-8?B?bWZhV20wRzdET3plR2VlMUJpOXQ3aThwSGNCUnE1MkhheUhHaVJNdHpjQWIr?=
 =?utf-8?B?MlFsYk1VdFp3R1lXdzRKL0JDVDVrcEVqcWtIZEEyNEZwRWd4bVZ0S2pyaXRI?=
 =?utf-8?B?NkpBRVlscE9raXZxS0NMRFRFVloxcXN5SFAyVWUxSnluamtZMnZPam5jd1Nk?=
 =?utf-8?B?YzlBTkR6djZsZEtHcHduUHJhZlE1UzkwSXlkbXNXMHdkNm1pNHFSLzMxSFBm?=
 =?utf-8?B?NThiQ0NqNngwNTdkS3g2T0RaeGwydUVqNG96cEtzZVlaY25WTFIzRE5kUUtq?=
 =?utf-8?B?dnlZYnRudmUrVUdzN09qR0tPWCs2VVNqbkFuK2pYMTd0WDRWdHJQc2xnRzgx?=
 =?utf-8?B?VkV4YVdIcHBCdllCVUZ6bGdNWmErWk1wWE1hSnliQk9MNXVqZ1B2SURiQmVK?=
 =?utf-8?B?YXl0TnNIam9WeGJMTlRySWZ5YzZqK0dubFZuV0pIMEU0QitqcDF6MlFETlNX?=
 =?utf-8?B?bjR2UVFOclZpV0dXK0VDNDZLQW9VUFgwSkpzMGFGYkYraDBBL0tYd1JqT1pa?=
 =?utf-8?B?OUZSYUxtTXZwOHZGN2dmcE1OVDlObU5NeWJMbjhCMUZDb3UzZ254eThUQU43?=
 =?utf-8?B?VzNWbGpONjNEeXdSQkRQc3IzYnZWZlVXWkJOR3puTzJnekwyZHdIbnN1RGpq?=
 =?utf-8?B?T0xOaUhrRXk4SVVCZC8zTlBYL0dyYko5VlpDRWUyNUluWURrZnY0ZkkvaWJV?=
 =?utf-8?B?RFl4b2hmaVo4ZTJJRHRjU0QwUW1VWnQxNmJzN01CWGljUU1YMWZDNGlGOGJP?=
 =?utf-8?B?MU1paWFYMGlSdjdESXpNalovdmJaUVBwZ1U2L0JGVElQMlErdmhWSzFvanZ6?=
 =?utf-8?B?RjNobjR1T0ZZQ1YyNnN5dU9SQlVaalZiYWNLRDJ2b2N4ME94U3o5Vkl6TkV4?=
 =?utf-8?B?ZndUL0xzMUNqcnVkTVd1dnJSdWxGc1pLYzc1aUZzQ3hBZ1FyQXRzYWQ5cXgx?=
 =?utf-8?B?WmgvckZWS1ZFL00xbzdlS1dpMmRRUGhXcHlqbHRRN3hzeGZKZlNPVkl5QzVk?=
 =?utf-8?B?N0ZwbVlpVlZCV1NCanBIdmtRaGVyQXg3dHJ0UXNMQXdKZUoxcDIvQSttS01y?=
 =?utf-8?B?MlpFdUFDNGpBTUZaT0UzbUJWaitZZ0xsVTZYc1VaZTBwdjlwTi9SYjFVR3ZW?=
 =?utf-8?B?ZW9RK0Z0ZXVlek44K2V0UE9VNzRaUUFjek1wVVlJWmg4U0Njd2ZKWDA1S2lU?=
 =?utf-8?B?UVRjR3M2cjNOVUJKZTNLSXpBUm5QcGRhSW9HWVRrcGUxem5JQ253VFgzdlBz?=
 =?utf-8?B?a3pDc3FoWU5obHMyOWZ6WXMyNVZlR0IrSk15UTV3UjNWem9wSTc0T1lzaEJX?=
 =?utf-8?B?RTNBblRWRkQvMEpFUjUvZm51ZjErd0tTYW5sMHA2VlkyZUJDYmVuRFJCK1NX?=
 =?utf-8?B?amEwZzdhOGNwd1BYN1BYalA5V05vb1dOQlByektCMmZXRUd1OFhhdjdVb2Yy?=
 =?utf-8?B?Ly9sOEEyNXRaLzg2MmJHU1RVWGlUd09xMk5rYjltUzFNdDhwUGtSTTIvVkV5?=
 =?utf-8?B?djJ3VVhDL0RQeDF1VGxJUTRvZGU5dHFsNE8rdEdDS0dEaU42aW9IYWNKdC9J?=
 =?utf-8?B?UTQ1QTdKRUp4YzhKUXo3ZXdCYXpoYk5RRXBUVXYydjB4ZHFQYnFkSldoRFgy?=
 =?utf-8?B?OFFzVmo4ZTk0QWlsY1kzTU5LWUJrY2NzbG94ZHBmL3VNM0NnNmdKUlNoUHl1?=
 =?utf-8?B?dWkrTCtYckJaZVB4bElXeFN4MUFEalJublE1cmlEZ0ZZU0x6cEtCR0hqNnA0?=
 =?utf-8?B?N2NHdmJjK21hcmx2NUQwRExINWIrK0Z4LzFOSWlrWG4xek9EcFRTRVJHbVpM?=
 =?utf-8?B?UXNaSEhQUlB4azcxR3kvRjMydmNNYWlHTWRZSVFyZGpWT0dITE1rUXQ5MFR0?=
 =?utf-8?B?MVB4cHJWRkhpRTBJLy9aRzNPOCtPWm43b2F6N0dkMzljVGxVaU5xUXh3NDNm?=
 =?utf-8?B?MWhUTnNmMlZ2L3d0a09KN3lrRll0bjFudUJ2WmYrZFU0K2U4NVNuQmtJNXBJ?=
 =?utf-8?B?bzBSbkR2SUpOOUt2d3BIbW90QmRrMUlKeFVHMDNuN2RONDF4RWxvR1FpckdF?=
 =?utf-8?Q?pODxKBf/e4Frbct0mzeDMOaI3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ce4696-7fd8-4be8-f614-08de2e357546
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 04:20:27.1752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KIibq6KcSvv2Qo1k2yEL4NH6KL4GCykKhNMLyfAgkhB1mPgUbVuKyMILYMV3CUn92UY44ZJjlOPYMPxZPmKtEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6302
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
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

On 2025/11/28 10:08, Duan, Zhenzhong wrote:
> Hi Yi, Cedric,
> 
> Could you also help comment on this patch? This is a pure VFIO migration related optimization, I think it's better to let it go with the "vfio: relax the vIOMMU check" series.
> I'd like to move it in next respin of "vfio: relax the vIOMMU check" series if you think it make sense.

It makes sense to me.

> Thanks
> Zhenzhong
> 
>> -----Original Message-----
>> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>> Subject: [PATCH v8 17/23] vfio/listener: Bypass readonly region for dirty
>> tracking
>>
>> When doing ditry tracking or calculating dirty tracking range, readonly

s/ditry/dirty/

>> regions can be bypassed, because corresponding DMA mappings are readonly
>> and never become dirty.
>>
>> This can optimize dirty tracking a bit for passthrough device.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>> hw/vfio/listener.c   | 46 +++++++++++++++++++++++++++++++++-----------
>> hw/vfio/trace-events |  1 +
>> 2 files changed, 36 insertions(+), 11 deletions(-)
>>
>> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
>> index 3b48f6796c..ca2377d860 100644
>> --- a/hw/vfio/listener.c
>> +++ b/hw/vfio/listener.c
>> @@ -76,8 +76,13 @@ static bool vfio_log_sync_needed(const VFIOContainer
>> *bcontainer)
>>      return true;
>> }
>>
>> -static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>> +static bool vfio_listener_skipped_section(MemoryRegionSection *section,
>> +                                          bool bypass_ro)
>> {
>> +    if (bypass_ro && section->readonly) {
>> +        return true;
>> +    }
>> +
>>      return (!memory_region_is_ram(section->mr) &&
>>              !memory_region_is_iommu(section->mr)) ||
>>             memory_region_is_protected(section->mr) ||
>> @@ -368,9 +373,9 @@ static bool
>> vfio_known_safe_misalignment(MemoryRegionSection *section)
>> }
>>
>> static bool vfio_listener_valid_section(MemoryRegionSection *section,
>> -                                        const char *name)
>> +                                        bool bypass_ro, const char
>> *name)
>> {
>> -    if (vfio_listener_skipped_section(section)) {
>> +    if (vfio_listener_skipped_section(section, bypass_ro)) {
>>          trace_vfio_listener_region_skip(name,
>>                  section->offset_within_address_space,
>>                  section->offset_within_address_space +
>> @@ -497,7 +502,7 @@ void vfio_container_region_add(VFIOContainer
>> *bcontainer,
>>      int ret;
>>      Error *err = NULL;
>>
>> -    if (!vfio_listener_valid_section(section, "region_add")) {
>> +    if (!vfio_listener_valid_section(section, false, "region_add")) {
>>          return;
>>      }
>>
>> @@ -663,7 +668,7 @@ static void vfio_listener_region_del(MemoryListener
>> *listener,
>>      int ret;
>>      bool try_unmap = true;
>>
>> -    if (!vfio_listener_valid_section(section, "region_del")) {
>> +    if (!vfio_listener_valid_section(section, false, "region_del")) {
>>          return;
>>      }
>>
>> @@ -722,11 +727,11 @@ static void
>> vfio_listener_region_del(MemoryListener *listener,
>>          }
>>
>>          /*
>> -         * Fake an IOTLB entry for identity mapping which is needed by
>> dirty
>> -         * tracking. In fact, in unmap_bitmap, only translated_addr field is
>> -         * used to set dirty bitmap.
>> +         * Fake an IOTLB entry for writable identity mapping which is
>> needed
>> +         * by dirty tracking. In fact, in unmap_bitmap, only
>> translated_addr
>> +         * field is used to set dirty bitmap.
>>           */
>> -        if (!memory_region_is_iommu(section->mr)) {
>> +        if (!memory_region_is_iommu(section->mr)
>> && !section->readonly) {
>>              entry.iova = iova;
>>              entry.translated_addr = iova;
>>              iotlb = &entry;
>> @@ -834,7 +839,8 @@ static void
>> vfio_dirty_tracking_update(MemoryListener *listener,
>>          container_of(listener, VFIODirtyRangesListener, listener);
>>      hwaddr iova, end;
>>
>> -    if (!vfio_listener_valid_section(section, "tracking_update") ||
>> +    /* Bypass readonly section as it never becomes dirty */
>> +    if (!vfio_listener_valid_section(section, true, "tracking_update") ||
>>          !vfio_get_section_iova_range(dirty->bcontainer, section,
>>                                       &iova, &end, NULL)) {
>>          return;
>> @@ -1093,6 +1099,19 @@ static void
>> vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>      if (!mr) {
>>          goto out_unlock;
>>      }
>> +
>> +    /*
>> +     * The mapping is readonly when either it's a readonly mapping in guest
>> +     * or mapped target is readonly, bypass it for dirty tracking as it
>> +     * never becomes dirty.
>> +     */
>> +    if (!(iotlb->perm & IOMMU_WO) || mr->readonly) {

is it possible that guest maps RW, while the backend mr is readonly?

>> +        trace_vfio_iommu_map_dirty_notify_skip_ro(iova,
>> +                                                  iova +
>> iotlb->addr_mask);
>> +        rcu_read_unlock();
>> +        return;
>> +    }
>> +
>>      translated_addr = memory_region_get_ram_addr(mr) + xlat;
>>
>>      ret = vfio_container_query_dirty_bitmap(bcontainer, iova,
>> iotlb->addr_mask + 1,
>> @@ -1228,7 +1247,12 @@ static void
>> vfio_listener_log_sync(MemoryListener *listener,
>>      int ret;
>>      Error *local_err = NULL;
>>
>> -    if (vfio_listener_skipped_section(section)) {
>> +    /*
>> +     * Bypass readonly section as it never becomes dirty, iommu memory
>> section
>> +     * is RW and never bypassed. The readonly mappings in iommu MR are
>> bypassed
>> +     * in vfio_iommu_map_dirty_notify().
>> +     */
>> +    if (vfio_listener_skipped_section(section, true)) {
>>          return;
>>      }
>>

Looks the vfio_iommu_map_notify() is missed. It also has unmap op. is
it?

>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index 3c62bab764..180e3d526b 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -103,6 +103,7 @@ vfio_listener_region_del(uint64_t start, uint64_t end)
>> "region_del 0x%"PRIx64" -
>> vfio_device_dirty_tracking_update(uint64_t start, uint64_t end, uint64_t min,
>> uint64_t max) "section 0x%"PRIx64" - 0x%"PRIx64" -> update [0x%"PRIx64" -
>> 0x%"PRIx64"]"
>> vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t
>> max32, uint64_t min64, uint64_t max64, uint64_t minpci, uint64_t maxpci)
>> "nr_ranges %d 32:[0x%"PRIx64" - 0x%"PRIx64"], 64:[0x%"PRIx64" -
>> 0x%"PRIx64"], pci64:[0x%"PRIx64" - 0x%"PRIx64"]"
>> vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end)
>> "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
>> +vfio_iommu_map_dirty_notify_skip_ro(uint64_t iova_start, uint64_t
>> iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
>>
>> # container.c
>> vfio_container_query_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t
>> backend_flag, uint64_t bitmap_size, uint64_t translated_addr, uint64_t
>> dirty_pages) "iova=0x%"PRIx64" size=0x%"PRIx64"
>> backend_flag=0x%"PRIx64" bitmap_size=0x%"PRIx64" gpa=0x%"PRIx64"
>> dirty_pages=%"PRIu64
>> --
>> 2.47.1
> 

