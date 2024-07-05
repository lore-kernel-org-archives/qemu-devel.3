Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1911C30653
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 02:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPZ8v-0006Pu-Lb; Thu, 04 Jul 2024 22:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sPZ8u-0006Pg-2b
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 22:57:48 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sPZ8r-0004AP-E9
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 22:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720148265; x=1751684265;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sOW+0guWaGtXxERF7aW1RVXL5LL2176ybudAqs4MC/E=;
 b=Y6dCU8CoI64sKtDo1OyHlRPVhmbWqWmQQnMzcFZufmIjymYA0glRh8X2
 JOYAWtkAVwvSYTzXjewPwX9tH0odLj/8ejw6njVxYFtv/FeIDNgaN77Nc
 C5181AdwC3MENV0UjZfdbDjFqgPQZn3zt8uhHC7+PBiVcZMmqIu5V6pGU
 aeNXqsRsHT5w3IwhgnNQ1UuxQBNwZ9ZuNFA7vZSw0PPZsrJgBm4KFjicu
 dxdKx/Cpm11buZDh2yu+yQxMzV7ON/GdjZOGEVpKsLySEFpdedAokOLmq
 fQJYsT1w8MMIG6o/hdaTt9ICR4WgCuBkRW/mrKgdUuuw2X6Rb1Uu2uCfo Q==;
X-CSE-ConnectionGUID: sDFkR+9IQx+C0jvIxpsKzw==
X-CSE-MsgGUID: q0nRCb55TziICvj0mVfD1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17644152"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="17644152"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 19:57:43 -0700
X-CSE-ConnectionGUID: E92tw4PpRJO85gyWMEZ1jA==
X-CSE-MsgGUID: IpZ4MemIRmumpjhY6rg1sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="51352737"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Jul 2024 19:57:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 19:57:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 4 Jul 2024 19:57:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 19:57:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVYQo+bCO33ysKJmDZYRYa7jLyyzHUH7h3lLM08XekoRzDnM/FDSzyef5BORI9/hihpiMfGYVtw4riJTPejB3TuLvug0pbevLBs8At6ht8P9blWRfCz8y4lemfBH+J1nxKIwJ2aXgDxfpuPinyHFj/ew2SUcYyBHpu/T2RlAD/MtBS+6ApKW99otLnOTJemc3vo/pv+P8PeU8mIqiiIWAY77dM3Qb4ZSXVPconZcqR873xHhzkmfN2ICfSrnMxpK2Ty0xuIDQX8Bas3O593QJvFvxG5pDm0LqWapf6CatB6kcBffAfFDTiDlObHYoYQYeg97RM2nNmW98aNh3uq+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKicmzWo6S4Sf+Q99yuJWmq8YtV6uS1Rms6R1/vpflM=;
 b=Rs0gyP8QMozNu5GJ19JntJr/1KlCMb94/9mAHEu94l+pycFCKTfoHEAnmPFRvDKtQe8FDFuEAw3zB2qob1O+svFoaOGRbNQsw6mej5qksk4QJo5biueR1QOD9XnBeCH52/Ib0Qa6PAlOmbLWqbCFEYqNAhqhI0ClBlUGu4iPIiqKQD/gGoajD8OgTF1xLzWfq4ErNqWKV67wArIfB6Qm0l6OvwA9Txog0RY5elCkAjDJe0NwNkNy+2OrmlFtvqIl4PwFXBUVYIjskpziv9jmM5njOvQDyyWXqB7xITqL0n7z4pXOooXg28Rt7b8LicrhPpj/rvcUu6b5wvSa6VsuqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA3PR11MB8076.namprd11.prod.outlook.com (2603:10b6:806:2f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Fri, 5 Jul
 2024 02:57:36 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7741.029; Fri, 5 Jul 2024
 02:57:35 +0000
Message-ID: <dfa4f446-52eb-4313-b74c-7e05ce9f7898@intel.com>
Date: Fri, 5 Jul 2024 11:01:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] intel_iommu: Bypass barrier wait descriptor
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
References: <20240704151220.1018104-1-clement.mathieu--drif@eviden.com>
 <20240704151220.1018104-4-clement.mathieu--drif@eviden.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240704151220.1018104-4-clement.mathieu--drif@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA3PR11MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f71d072-5fea-41fe-94f2-08dc9c9e3911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0RXME9UOGIxWFBDZG93R2hSNDB6ejhVdFJvZ1NteUEzVDJvcjNxTVhWZ1g4?=
 =?utf-8?B?ekRpZkxiTG1yTkRMMkFDc1F3ZXBrUVF2NFN4MGowUFhwejBpZWtudEtCUnlU?=
 =?utf-8?B?c0ZxeHRsNk9CUm91S2xZbDFMamFEYXlCRVk3d20xVmpqSCtPazlaOCs0Y1pV?=
 =?utf-8?B?dFFNUHZUUjlWK2YvQi8rZkk2Vmt6VVREcVVoM2RmRUttWjlaWXQ2NHhjK0I2?=
 =?utf-8?B?ZDJJNmdpTkZkbm1xQUpLTUdvbWFud2g0RXh6Sk5TdGZPd0RyK0ZXQno3T1hs?=
 =?utf-8?B?UFdxa1lpMnU5aVpCd0ZjTzVTZjZRb2c2SXRWb09GRzF4SHliWU5qMUx0eGhM?=
 =?utf-8?B?dXNHWUdGV2ZxVTNtaGVGbHBOeFArR1ViMGZ0RjJMYmc2RklhYXpuUi81UUFu?=
 =?utf-8?B?c2R4RThjT3czRnNpWEJvd0h3WVE0Q29FSWtsYUJrSjNIL09QZlpPWHIyVmRK?=
 =?utf-8?B?USt1UTcrRWhBWE82K0NjdURGUnZtZVFqbHhnQkREWnBwd0FQVzhZQnAxL3Y0?=
 =?utf-8?B?UE9FeFA4bXltVFBLdmFtSlR5ODNNc3gzeldYbWNGbHBDUmhjS2pNVGwvUEVU?=
 =?utf-8?B?RW1PQ3FSbklZUm1VSkY1ZG9mOGEzMXgvNnMxTjlMQVlINWl2TXVHQzlGWTkw?=
 =?utf-8?B?MFE5OVlFcTV4Z2M1WC94Si83d2VpL0NvVnpmUFVLRVlQTGtBMk5odWtUS2NS?=
 =?utf-8?B?bVJMMVB6RnlGNURiMzZCSFpVeWpzMTZTNXhQNDdvVGx5MThoNmVYbnlud0Uy?=
 =?utf-8?B?b0JXV1ZwbUdEdzNabU9IU1J3VFZWTDFvQ1RZK1dURnZ5V1ZqL3l5Z0EwWkV4?=
 =?utf-8?B?MWk0eGZQYzZtUXZENjlQMmF5anMyUFJtemtVSnpZdHE0VGlNRjZmVnhVUUlk?=
 =?utf-8?B?bGV4SEQ4NUFiY3ZRK3pFUDN5TUxWRENXODdiQm5udVR4N3VWemx3c2hjS3ha?=
 =?utf-8?B?ZHZyS3lxNEM4WmZiMjR5N1JVcldWbDZCMCs3UkR2bE9BNU9xemQwckpONzN6?=
 =?utf-8?B?R0EzbjhhR0tHMGZBMjFUNWQ2V2JWeWp6VTFVeFZWVUtCalRUSWNGc0J4cXNr?=
 =?utf-8?B?SDFQR3J5QzJZVktvVGV2MS9hQmwxaHRvUWxERkhLT2xmMkJvd3UzTVh4TXp4?=
 =?utf-8?B?ZVBJSkZCTGRqOVdYeUxqejdMQWpzYXIwVjJSK3Ria0YwVGdhNS9lclJ4R3FS?=
 =?utf-8?B?UTNGZmpkSVZ1VnBFbnFqQ3A5VDh0b3JydEpQckUrMGdCU2JHZHJ2YnNjbE1E?=
 =?utf-8?B?RTFkL2s2WkY1M20vWUpud0hKUTRvbm9KWEkwU0dXRHU5NTlOQUE5ZWw4amV5?=
 =?utf-8?B?WStJOVJuMWtOTDB0QlpXaVRyQWhKejU2UlNBVXNUMzI0Zk5RTG5acXMvZXBQ?=
 =?utf-8?B?dmJrSXFtK1p0Mzk4VVZyQmV3Wk1ISS9haEpTWW1QTzA2K0dtaFJndElLZjV6?=
 =?utf-8?B?Z09PcG50N0VjUE9NcGZ5MldMNDhhUHVZeFgxSVA3d2FWMmNWRUhlaktJdENT?=
 =?utf-8?B?cnNZSnRtOTNRRllCTEhzVFVJRDl6SVdVYk9KRkNIM2xGUVpPWnhFSVFnaGpR?=
 =?utf-8?B?VDdxVlZmN1lkQjVwNVdPYW13bzZJeTg3TGNiNHhQUGFTV29Udld1aTB6QW5J?=
 =?utf-8?B?WG4rc3pzOUg1SG85R1VTMndDR1NHMHZib1E0OVBtQ05hV3pheUlYdjI5UVRI?=
 =?utf-8?B?eU5sYU9IMnppejg5OGx4VXU5SU5xYWdCT2Y5MXNEUkhMYXdNQ2tEcldoaHNF?=
 =?utf-8?Q?O+r0WWNgT4ZKxl442w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXlXKy9pcDh2czFWRXZ5MTlFOERzUEwxYTYrQXlMc1lIbEJqZGtpYU9IMVdk?=
 =?utf-8?B?R3RCK2Z6ZUR3YTNrU2g5SGNiZTNISGYrOTk1RDh4cTdhdUNOSXY3Q2hiT1Fw?=
 =?utf-8?B?MXl0Rkt5ajlXL3B3c01DTTl2WW1rQ3pSbytOcnBPSU9ZaEY3T3hjdG5OeUts?=
 =?utf-8?B?b1RlTkFySzR3YnRSS2xka0NvZjh1Z2creVVtWFI0V3c0UVY0QXlkbnZ6cmZi?=
 =?utf-8?B?eThuUmFYalJMS0ZuMkNScHlla2RkclpWeFNYSTdwS0M5a3pGZC9FOTBIUjFG?=
 =?utf-8?B?cGVyYUZKVFlXUWlJUjdVNGFlbjZIVEpMY2Z1NUNoeXpPQzd4Sy9sM0dNTm54?=
 =?utf-8?B?aWg0cEsyKzgxU3ZaTUU1a1Q2azZTWXg4ckRyZG1QN0Z2T3J2eU1oaTJNbjQv?=
 =?utf-8?B?MlR4ODIzVGJHdCtjd2ppZmlHbTFDdHVrWmR1VkZKVjVDeXlUdXNZUWhuNlZI?=
 =?utf-8?B?eDBzaGVscjJPR2FOcDlNc2tsTTVVOUR3WkllcUlyUGFrS1pKbGNtczYySlNL?=
 =?utf-8?B?NHB4VUlWaTE2dVc4a2RQc21YUndYa0RHdVFTelpieC81NnpVT3dXc0VLbVps?=
 =?utf-8?B?dnMrNXkrY25DMzl1SXVGVU0vRC83c3hadC9rNFM3YWU3T1E3N1o3Z1NZY1RU?=
 =?utf-8?B?aXFLdW40eTRRcFREZGlDVk44OXJISXBGaGFKY3hCTHlUOE5XV0srR3YrcmtK?=
 =?utf-8?B?d1pnd29XVGkyTEZCWHhKOUJCQ2xueXZweVh0aDY3bG9qNElLaTdNZ1BIazQz?=
 =?utf-8?B?aVVxa3N4cFpZOHZlK3J0cmlnT3NqbXA1L0ZYZDN3c214eGErQzcxTmtpVm5E?=
 =?utf-8?B?d1c1L1NHSU5sWGEycDdDem11anlaMTR0cGp4VVZOZEM4citSeXhXN0NUeElQ?=
 =?utf-8?B?Zll2dE9mVmJaKzFoMmp6WHVqOFBXa3NPVk1iTmxmTlo1QlM0aGt1RzNVamxV?=
 =?utf-8?B?WWE1VGNVRE8vTlZvdzUxa21MemZWOThWVGx1alZRTitjVVdWWk8wSjgvczBo?=
 =?utf-8?B?SHpxUVVXamlsZjZsNTdKYU1jaVBIZU9BYmZhMmZVcUJrdG5vN0dsNlhML29G?=
 =?utf-8?B?bXJoT1M0ZEtDaFdyVlFTaXlIKzdOQXBEdXMybWFSbVFuK3BlMklPbURhRU9M?=
 =?utf-8?B?Y3dxZnNtbzg3SUorKzZWZi9ZS2EyZzRGVks0N0NXUWhtblpkWVBvSHNneWhv?=
 =?utf-8?B?enBkKzZ5aWQ0V29iS0VPTG1hQlQ2YitrbjhOTDBNUHh2dXBpYmtka2Q0T2Y2?=
 =?utf-8?B?SVExb05PdGJhbmVveEdsWDZyZlBiajQ1dFBiNUFSekNJZVRRN1RVZnd0MEx4?=
 =?utf-8?B?Zll4bHBHZS90UTY2M2cySVpPWVJPWUtHYlVMYnk1ZCtwZDl6VGlKVitwczhK?=
 =?utf-8?B?ZmpMM3NBRWsreG9UUDdvS1dFL0JaRXdSVFYzc3l2L1lqVkR6alJZNHFqWnA2?=
 =?utf-8?B?dE1nS1Q2UWhGaTVIdy9Oa3VlNUltcWUyaXlVa1BFVlRlOWtIcy9EVGxSQVRI?=
 =?utf-8?B?VGsrajNmR1c0dDRqdks1UDRPdmM4cEwrRm15L0hpYXRRZzRQWDJhS0ZiQmp6?=
 =?utf-8?B?alZ4WXg0L3NUaVRZelkzK0hXcjRFbGtpaE1OTHVCOW5HMGw3NGkyUUd3aWJO?=
 =?utf-8?B?U2s4UkRxSnFwNDk2VWE2UUZidkZYbnJSR3lJaGtMQUVjTlozV0pITWgyNGtK?=
 =?utf-8?B?Wk4rU0wyZkM5VThDQkJMSHBIZjlyTFJURHVQaTlyU1BpRVJXV0d3RHJnVmF5?=
 =?utf-8?B?bXJ2cWV0cWhQbGgyeElZNFVuOVdROHlJaDM4OU14bkE3eFY1YWh1U1NZUE4r?=
 =?utf-8?B?MFovUElFYkp6REJQUlZ0OHl4dWw0ajVsRDN1QWJDb3Zpa2Y3aFZQeS9nWHpZ?=
 =?utf-8?B?RUN0THJoSWY4eUZFVk0rTDJCaG9sNzdxRXlKV3FDTmpDVEV1ZGt3Zk95SXEz?=
 =?utf-8?B?TDFDZ2FTRndQVGo2Mkw3QTdhN1FmUzArVHpZMlM2Q01TM2I3VG4vSmx6SjlX?=
 =?utf-8?B?VTdPV1pGajRiU1drUGFXR0cxVFNpVTZ1NHJOZEI2d25obldVekhGUzkyRDJl?=
 =?utf-8?B?NUliMy9PbnBXZkgrT3U3aEhubXVocHUvN3V6bzFJK2UyMHZvTThDWjZpM1NW?=
 =?utf-8?Q?fHbRWPMHW+0qxdSA565Wgb1Qq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f71d072-5fea-41fe-94f2-08dc9c9e3911
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 02:57:35.8667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4yjvHs5QRBjPdWM1C+UXVUJGNhFP3OCdVCyRuiT1GugJJAkIIJkbkXJuUldfhqn+EVZ+zh1lJRqmza0EVAJ+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8076
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 2024/7/4 23:12, CLEMENT MATHIEU--DRIF wrote:
> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> wait_desc with SW=0,IF=0,FN=1 must not be considered as an
> invalid descriptor as it is used to implement section 7.10 of
> the VT-d spec

After a second thinking. t would be better to move this patch to the
PRI series [1]. Reason as below:

This wait descriptor is used to drain PRQ. While, the guest need not
to drain PRQ until the PRI series which advertises the PRI cap to the
guest. So QEMU won't get such a wait descriptor before that series.

[1] 
https://lore.kernel.org/qemu-devel/713ece39-bc1e-4189-a1d9-f81f9cdbd03b@eviden.com/

> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> ---
>   hw/i386/intel_iommu.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index be0cb39b5c..12ea3a9aa0 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2561,6 +2561,12 @@ static bool vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
>       } else if (inv_desc->lo & VTD_INV_DESC_WAIT_IF) {
>           /* Interrupt flag */
>           vtd_generate_completion_event(s);
> +    } else if (inv_desc->lo & VTD_INV_DESC_WAIT_FN) {
> +        /*
> +         * SW = 0, IF = 0, FN = 1
> +         * This kind of descriptor is defined in section 7.10 of VT-d
> +         * Nothing to do as we process the events sequentially
> +         */
>       } else {
>           error_report_once("%s: invalid wait desc: hi=%"PRIx64", lo=%"PRIx64
>                             " (unknown type)", __func__, inv_desc->hi,

-- 
Regards,
Yi Liu

