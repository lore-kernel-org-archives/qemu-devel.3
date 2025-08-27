Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79813CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 12:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urFCd-0001xN-0h; Wed, 27 Aug 2025 08:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urFCZ-0001wf-GQ
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 08:24:31 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urFCP-0004LO-UB
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 08:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756297462; x=1787833462;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dJmEEK8ZSC9v5sjF6kE+H3CGCYwuQCTaXde5PQx56JE=;
 b=jn+hMSDnXGhUMB1rycQtdgeIeILjAhxsMc1fzG+KW4Nc4QLe5YwEaR73
 OJ3CHJLsB2QhkZwQYMAiGGuTWWL8RpovueNpoyZk9U/jOA50qRN5kcuHn
 vLeJsehx2C5iNuTmKro4xjy6wofCSz7w+OFB3hqbK1UArCF/vDFfhJM8V
 RAACPK30EXqyVurWoojQomTkma/enlIEAx9A//Lm8Jb6L1fywAkToOyG6
 h8D7q6R0bVEMVym3LnlRX9OuJNbZYEKzJ+flW+iL2fU/debo2Kn93sn9q
 IWenvO+S8VJ7JoxBJ3Qiz06lwGGveUYS7JLmn/Bo7scbmqb89eHgqOTej A==;
X-CSE-ConnectionGUID: sJvpiy02SM+Lvp5m0HXQWg==
X-CSE-MsgGUID: tk2SHca/TvCn/JPQNFvCSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58465046"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="58465046"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 05:24:16 -0700
X-CSE-ConnectionGUID: i/Nbft+VRVqMxjR2E0ECMg==
X-CSE-MsgGUID: h0RBzY+TR+229fWoO6vYKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="169430666"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 05:24:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 05:24:14 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 27 Aug 2025 05:24:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.52) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 05:24:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epzChinRRQvWStOs8fyLtSLYQvhBZpwPzOkhz93f5CDCrqCvzHvv8d8gBnD36NrruDhthYIRLz6qyIn7GrS6006NU3FwWSEcdyQJ4vuutxz1D02sWiXshBnQagkAJZ+AWIo+lpvGs4MQWx7B7zY1tPl3Z422uztQxz0Ag6RW5L1HjPRfn7yMMhm1CvqcIfRSVzZeBY3SQT2MfJ9lWrHE0zl16RhL4LW5aoa4aTyj0HME838xMJeHCFl/NJ+XMWTT0ZzoBmLHQ6S5WvbVddlcSx4Cvf8c1JlyuiALBqS+zNexCzm1yDaUkry0LaMf6H10ObTqTH+WPcf1WPpRq0DcMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJjIRi/oCNZgW8rlVG9i7Usx/VIgMMktSsJ81qGnnRo=;
 b=TBIkC1wihRpQIRngKEfbY8KnCDzPaV7ixVKs6vDY6gd1N2s2dLB//kwz6hoqVaoosB069FQheB70vujs10dHQclg2JccS3PqIGHR6LZdHgWY1kjesZW3dZf25SOSB7nA551RMG9tUnpga4Z/ado+Dzfa57sOWS7SDc0D1024uNBezDL1+JKZ8KrANWjzc/DjeGZmzCTq8k3JqpqHEhdvtxKKsYhAzec3xmFSxtGsx/9zjslX+cIXM76Fdqx4LmprO+wvz1h8FQYUqKbiij9Iju2xj/IGdqeDtreXzFebE1Gm2sKKxGXdEtWaCOS04E8IPOYvnGnw7AKooFcLPamfmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by DS7PR11MB7836.namprd11.prod.outlook.com (2603:10b6:8:e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 12:24:12 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 12:24:12 +0000
Message-ID: <1ee98764-d57f-4ff9-9018-f07d8ee5d68d@intel.com>
Date: Wed, 27 Aug 2025 20:30:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/21] hw/pci: Introduce pci_device_get_viommu_cap()
To: <eric.auger@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <mst@redhat.com>,
 <jasowang@redhat.com>, <peterx@redhat.com>, <ddutile@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-3-zhenzhong.duan@intel.com>
 <32c0a5e1-6529-4978-a0e1-32940e806dc0@intel.com>
 <e6300798-19a6-417b-902f-57fa7ae20355@redhat.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <e6300798-19a6-417b-902f-57fa7ae20355@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|DS7PR11MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb620de-26c0-4255-26f1-08dde564a14d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|42112799006; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bEgyTytsOFJHeHNiMGd3WkozeDF0cFl5b29lUjdDa1lLMUd2RmhMR2dQR3Q5?=
 =?utf-8?B?WFV0MlFSa2JaQ2VDSWNGOVpWZUV4MXBOL3lEbTdKVVVYWVhmb2RPR3NiZ3lk?=
 =?utf-8?B?ZE1ZMFJQTzZCTEdKQjcxS3Z4VWNaWWZpelUxYkhHRTNUc0dZbllKZk9DWUNX?=
 =?utf-8?B?WS9YeldIUDF1bnBNMHFzblZKU0hPdk9wRGJwZlcyUFZkNkhkYlhiKzM5M2c0?=
 =?utf-8?B?cXVjZVhWUHhKQTV2YnFuTjBYU0FBd1NDbTI0M1dHUyt2Z3lSZ09zRVNLZEpC?=
 =?utf-8?B?YkVVbFhUYnJ4dVpGZjZhbVQvbTBmUnM2VUxGSGpSZUZWVWd0RlJpWFk3RTVT?=
 =?utf-8?B?dWFqdmtWWUp3OGgyQmJyQVV6bmh3WmlOa2NmNG1ka3RiZzV3UElhNi9JbmVk?=
 =?utf-8?B?bVpCUEtGNGJ2aS9TQkpxT2FKNVJQUUJMdS9MYmNQcHFORy9CVVF4UXdZNmZ5?=
 =?utf-8?B?eGp1QlFRWGJHT0NvKyt3NEFkMzBTSWk2WFRmTmtmSDNtd1lqaXZqY3dFZHhW?=
 =?utf-8?B?S1E1SVJEZ1REMUppT1BUQk54Ukw3WkZiQ2wrWndxQ3Z0K2ZGZk9vVitGanl1?=
 =?utf-8?B?QWZlRy9mMlFLcGM4QUdac0xzMzdqdVhuRVBHUFBSQTdvUEZPamJxSWEzMDNj?=
 =?utf-8?B?TldRTXNyZVBBSTloT1g4aHJQVDB3bkVlWFRoR2tISUFlSHZEVGM2ZHUyUE0v?=
 =?utf-8?B?M292bi9ZRE0yZFBRblZLVUtrQ3I4WmcrT0N2Qkozb0JjcXlCaEozQTlkWDBp?=
 =?utf-8?B?S054WEtFZGluZ0l6REE2M2Y3TFNhd0JTU0VnYjZmQUF5THRWNWJZS216bXdQ?=
 =?utf-8?B?VHN0UU5aSUFXS0F4d3F6ZG1WbUFQbXpHSHZiRmZYQlRwTG5FTlZJZ1dyRDBj?=
 =?utf-8?B?d3ZUK0hIelMrYnR0bHBwam03cTdaSVhsSGFNZytIZDhvWXcxUnhqOXBXM2Fl?=
 =?utf-8?B?YVZ4MEJxYktnd1RROXJ2Z3JqWnBveTZkRmZNYVlFQnZmNkZBV29wUmJvQTVN?=
 =?utf-8?B?dlJSUTc5SU1nNzA4b0hMN2plK3FGUC9tTmNIY0JJYWpNdjBmUDhMem9qRVNR?=
 =?utf-8?B?SmE5V3FxNzRjd3JIVW5tdWtSZ1NRRlkzcDFTb1pFMS9oRmFNV201bE92SFV2?=
 =?utf-8?B?VWd5QnlwUXJobVRRTzF1aDlaTXRCclQ3S3JRa2h2TG82WEVJeU1EZHBwbXJ4?=
 =?utf-8?B?S0ZLaVFJbmsrNkh2MlNJNjMyOHJPS0ZPdFFWUE1EZytmcDcrNUpDRFg3U2pG?=
 =?utf-8?B?UFduVldocDVmZlFsMjNEbmZWbE5VRDBSUnRSeXIvdnNrTVlWODhoOUVSbjVT?=
 =?utf-8?B?NTJNbTNvam1QNUZkdU5IOEFDQkl6YnRWbmRvYzlBNFJ5UytmcWV0cjlKVUlD?=
 =?utf-8?B?ZjV4ZDZzemxUcWMrRGhjWVAvZ0RCOXJDQWVoYVNXRG05c1JSNURLWFIvRzJ6?=
 =?utf-8?B?MmZXRmRvUnFSTGxucGRLb1lhVzlOaEJSVUhCOXVNT2pERWlwTVJyUUVKeFR2?=
 =?utf-8?B?Qm9WOWswa1MzTm1hZjJlTnlRS3ErS2xvUEJ6MWt1REpsUEdvbFNXVm5XN2J1?=
 =?utf-8?B?RGRYczJ1OWlrN2VpYWhXRDlTVkc5QjFjS0RsSlFqbW1IaGtVS0RWYXlLdEFu?=
 =?utf-8?B?TW9oNzQwM3pGaFRnU2Z6MzdXZlJNbkhSNTJBYlJ5R091RXEycHJjTHdNODZn?=
 =?utf-8?B?bDhleENmcHhNSnhLNUhOaXRVV3NMV0xCK1FlbStVbUhZK3U4bHhYbkVhaGJ1?=
 =?utf-8?B?TVJsV2xqODZhUXdYZXNIbEVBWkNIYUYyd0ZOUDhZeGFOV2NPZzZPQjkreE8r?=
 =?utf-8?B?NVZUMWNjc0NQSHp1anp3ZHdqaVNPUVc4aEFNNW5rRGRQZXJEUnRMNHdoWjdW?=
 =?utf-8?B?S3BTeGh4NXcyOTlqSlE3dVB2NEwveEFyQkNJYWdoRVlzcGlaSkJROTJxc3Rl?=
 =?utf-8?Q?csf3RlRDmBs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(42112799006); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmtHY3YvbEw1eHdYZkxlU29SRXZtMndPRlkwdENRYXppSjBSeDRWWHhMemJO?=
 =?utf-8?B?TzN6UitDSWVYL1RKSkxIYitUNnFyY1Y2THQrNWhpclhPL3dvR2MzVGwrS2pu?=
 =?utf-8?B?TldpUmNjRDVSeWVib1ExaGVramFYYWdub1Z1K0FEdXdMaE9VU2xyWnBtdXpX?=
 =?utf-8?B?dlk0eWgvb2JlRFluK0lORGVRRlhVRlA2RndEcUNYUE1MYWc4TDJORnFRMVJw?=
 =?utf-8?B?OTBCR2EyVmQ4emhMOW94Z3ZRVC9UZnNCOEZoNnlva0szTjkrYWlGdnBDNTVB?=
 =?utf-8?B?d1RsQWduTG9pckllZkN6cmM0bitycVkyR3ZQM0gxVktoeUEzZFppRDlTNUNz?=
 =?utf-8?B?SEpTZCtEOWFlYU1LUHU5MHRjR1B3SFozbXhhRkZId3NRbVg4WlYvSlBVekNR?=
 =?utf-8?B?c08yWmtDcXF1Wm0yTWZMNjlnTkkvTTRuaUNjYTZpeTJvVzNSemNxbjdwQjY4?=
 =?utf-8?B?RUhHVHVjTUQxeGlPZWFzSVNXdU5INmwyaElFTDFROWF1bXQwM0pCNVhuYy84?=
 =?utf-8?B?enRHYlJMcHM5UGVvTlF4VUVNRCtuanhKL0VEalFlU3RaZFhPVGZ1alZ5NkdP?=
 =?utf-8?B?VW12VVNpWDlNa092NjdHRkVCV2QrVUluUFk0Z25QSzR3VGxJR29QQStYQm9B?=
 =?utf-8?B?OWQ1a2UrU2ZmNzRWUndxbENsdUo0VWxMRk5sMTlCK0J5SWJmdGdiRS91RXdC?=
 =?utf-8?B?MFV2dEwvNFIyejIycGRNRHg1bVNjZGN3V0gwNnVGbU5ILzV3L0puTnRTWkg4?=
 =?utf-8?B?MzJUSVhLMGpkMVFQc3plVUtMb3ZwSGRjVlR5RTlwbTMzcms5blVVRUNFcGI2?=
 =?utf-8?B?ekJqdzF1T21ja2JPWlpIYWwxeGF6QldGd2t1NmxZcGpQRi9veFphVm5Ebzl3?=
 =?utf-8?B?VmVieGxLaytKd1oxeEYvQ0RydlhUVVFQTXNQUEtua096Z2NHakV3NEdjWVBV?=
 =?utf-8?B?VzRvQ0s2UU1OWVJzSzIyZTdJaCthK2RDT0NYbjJOZkV5QlEvekowSEthaEpF?=
 =?utf-8?B?S20yeldLZmk0bUIrZFZISkZVbFUxa0Zmbnp3b1pFd0RRN1FaeTV2UkpOU3Rs?=
 =?utf-8?B?K2dLbUpMQzBzeGN4TnRWRkhJY1Y4eStEYjIrOWRLYzdlQTFxdXJMUllwTTBQ?=
 =?utf-8?B?S0xQNVpRaFVtR2pUUW5NVmt4VVFhUEt4Z3JYL3dvUTZMUDRRUHFtam9tSWdF?=
 =?utf-8?B?TWJSUHJBYitFak5hYXR5V1k1TDBZa280Vjl6cndteEo3N215dWUrY2VDNHNZ?=
 =?utf-8?B?R2lIN29sbTgwYlR5R0htVXJTOGFIeVpjbXRPRkZ1dG1WVkNqck5MM1B2a0to?=
 =?utf-8?B?cFVMb2hFZmkzMDZxM1FWcWRDNnp6U3d5R3hIZklGNjFsb2FDWmc1OThqUHBI?=
 =?utf-8?B?T1N0ZmwrMGxJRTFvQ0pjNXh0OHhha0dNWndjSUtZQWlWbk1Da3prK0dQL3JZ?=
 =?utf-8?B?UnFVUHdyQmo0YWJmRUJZSGVtSUpDR1E2Y1Nxd0FVMFI4cFI1N1YyaGlSSFFP?=
 =?utf-8?B?cW5waktvTjlGeVNYdVg3VVM3K0JLQVVla3RKWWV4SWlTTlpQYU5lQlpEcWlw?=
 =?utf-8?B?YjVabmpYckc0YnJmd2IxTFg3VnVRYk50QWpFVFhLVkhDLzBGcWtUV1I0aEVn?=
 =?utf-8?B?Zi9hd003c1lIZURYSzJTMEtKU1pZQUxiMC82TFltT2h3V3dkbk1tcVZ5dlAr?=
 =?utf-8?B?UXlaRHBES3IrVXRzRWVtZ2tMWHNxZSswNjZTblBqdWFpTkJSN2h5cTZrcGx4?=
 =?utf-8?B?S2MrRWlSeU4ydGthSDV1bUJwemtBc3Z4aVJjZlJlbW0xcWFpZ0x1OU5UNDRm?=
 =?utf-8?B?K0hzbXBxT1ZHSiswaTBaZlZCck5LNmFmOTJQbkVQUnFXUlhIU2RzQUZTMkhI?=
 =?utf-8?B?S1JtVTVIQlR5MnBpc00zQVpyaGdWdFZuOXVtS3dRenR3aVRseW93WEJnLy93?=
 =?utf-8?B?RTc0alY5cExtcXc3dzZMd09XekJGYkJrVG5qOG9sR0gwV29aUmhXeXBtQlF1?=
 =?utf-8?B?VVg4V1JzTDVDQlJicW1QQURmYWpDMXpkWTYrelh5b2x0OXlNVko3UzE5akRn?=
 =?utf-8?B?ZFhTTjhYVDV5Q09HbzRST3JaZFI5Mlhvc0RTTkw0NElDdDY0WDc5NVA0NGpL?=
 =?utf-8?Q?eoybkJBMDmQxStyhWhR61zf0M?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb620de-26c0-4255-26f1-08dde564a14d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 12:24:12.3549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3E7iL5znEYy1fJh3qLWompKpZZmnTyPGSPaRBJ/Wi6ODgLPifgLiZfGMzH51M7W5rqci1cRY57+cgNhz4rnwew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7836
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi Eric,

On 2025/8/27 19:22, Eric Auger wrote:
> Hi
> 
> On 8/27/25 1:13 PM, Yi Liu wrote:
>> On 2025/8/22 14:40, Zhenzhong Duan wrote:
>>> Introduce a new PCIIOMMUOps optional callback, get_viommu_cap() which
>>> allows to retrieve capabilities exposed by a vIOMMU. The first planned
>>> vIOMMU device capability is VIOMMU_CAP_HW_NESTED that advertises the
>>> support of HW nested stage translation scheme. pci_device_get_viommu_cap
>>> is a wrapper that can be called on a PCI device potentially protected by
>>> a vIOMMU.
>>>
>>> get_viommu_cap() is designed to return 64bit bitmap of purely emulated
>>> capabilities which are only determined by user's configuration, no host
>>> capabilities involved. Reasons are:
>>>
>>> 1. host may has heterogeneous IOMMUs, each with different capabilities
>>> 2. this is migration friendly, return value is consistent between source
>>>      and target.
>>> 3. host IOMMU capabilities are passed to vIOMMU through
>>> set_iommu_device()
>>>      interface which have to be after attach_device(), when
>>> get_viommu_cap()
>>>      is called in attach_device(), there is no way for vIOMMU to get host
>>>      IOMMU capabilities yet, so only emulated capabilities can be
>>> returned.
>>>      See below sequence:
>>>
>>>        vfio_device_attach():
>>>            iommufd_cdev_attach():
>>>                pci_device_get_viommu_cap() for HW nesting cap
>>>                create a nesting parent hwpt
>>>                attach device to the hwpt
>>>                vfio_device_hiod_create_and_realize() creating hiod
>>>        ...
>>>        pci_device_set_iommu_device(hiod)
>>
>>> Suggested-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    MAINTAINERS          |  1 +
>>>    include/hw/iommu.h   | 19 +++++++++++++++++++
>>>    include/hw/pci/pci.h | 25 +++++++++++++++++++++++++
>>>    hw/pci/pci.c         | 11 +++++++++++
>>>    4 files changed, 56 insertions(+)
>>>    create mode 100644 include/hw/iommu.h
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index a07086ed76..54fb878128 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2305,6 +2305,7 @@ F: include/system/iommufd.h
>>>    F: backends/host_iommu_device.c
>>>    F: include/system/host_iommu_device.h
>>>    F: include/qemu/chardev_open.h
>>> +F: include/hw/iommu.h
>>>    F: util/chardev_open.c
>>>    F: docs/devel/vfio-iommufd.rst
>>>    diff --git a/include/hw/iommu.h b/include/hw/iommu.h
>>> new file mode 100644
>>> index 0000000000..7dd0c11b16
>>> --- /dev/null
>>> +++ b/include/hw/iommu.h
>>> @@ -0,0 +1,19 @@
>>> +/*
>>> + * General vIOMMU capabilities, flags, etc
>>> + *
>>> + * Copyright (C) 2025 Intel Corporation.
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#ifndef HW_IOMMU_H
>>> +#define HW_IOMMU_H
>>> +
>>> +#include "qemu/bitops.h"
>>> +
>>> +enum {
>>> +    /* hardware nested stage-1 page table support */
>>> +    VIOMMU_CAP_HW_NESTED = BIT_ULL(0),
>>
>> This naming is a bit confusing. get_viommu_cap indicates it will return
>> the viommu's capability while this naming is HW_NESTED. It's conflict
>> with the commit message which claims only emulated capability will be
>> returned.
> 
> it actually means the viommu has the code to handle HW nested case,
> independently on the actual HW support.
> maybe remove the "emulation" wording.

yeah, I know the meaning and the purpose here. Just not quite satisfied
with the naming.

> 
> Otherwise we may also use the virtio has_feature naming?

has_feature seems better. Looks to ask if vIOMMU has something and then
do something.

> 
>>
>> TBH. I'm hesitating to name it as get_viommu_cap. The scope is a little
>> larger than what we want so far. So I'm wondering if it can be done in a
>> more straightforward way. e.g. just a bool op named
>> iommu_nested_wanted(). Just an example, maybe better naming. We can
>> extend the op to be returning a u64 value in the future when we see
>> another request on VFIO from vIOMMU.
> personnally I am fine with the bitmask which looks more future proof.

not quite sure if there is another info that needs to be checked in
this "VFIO asks vIOMMU" manner. Have you seen one beside this
nested hwpt requirement by vIOMMU?

Regards,
Yi Liu

