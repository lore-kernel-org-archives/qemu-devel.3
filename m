Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35985CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 12:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAp8l-00086r-PQ; Mon, 20 Oct 2025 08:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vAp8i-00086h-Sh
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:37:30 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vAp8f-0000dO-00
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760963845; x=1792499845;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fkPCvxJxwIzQH7SdpiKBU2WINATP11a3Vxzu3OaDuqY=;
 b=ZUWq47Fy55KXlEd46Ixhu99FDKOxTO0aGqB25bZbLZdxJCxInYmQiBvm
 4eylQQ7JWpNX3d3XqY3PHhPLrj7TPiAv2Lw0r/IwoBzfwZd3vQe70vRw9
 rBQPU8Y1IQJX82fOPa6mSio7YkD9fy4eBs9pOU/0DieRkbINzQfg1qQiB
 oE9orDbBTtpZhxddObKT2uK0XbxAqaeJdx0x4wqonNh84UiQZWDCBkoOj
 FyqBEHfm+UYTLkk2EDktEmxzrA+27I09X53u2HAR0dyKm9L2fyehWORWd
 sW6yuYNha78BG8t9hox9cB6g32J5t4TNkII6gElLBBKlg4q6RSkYA/KeF Q==;
X-CSE-ConnectionGUID: UAbTUPy9QjSqClNuZQhvlg==
X-CSE-MsgGUID: /5tpkMmwQ9KLY7ZePbq68g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62985123"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="62985123"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 05:37:20 -0700
X-CSE-ConnectionGUID: UFgKfEsdRlqsfHWU+LK0Hg==
X-CSE-MsgGUID: v1ydetWIR3utGj0yeFnxhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="183264926"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 05:37:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 05:37:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 05:37:20 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.33) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 05:37:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFPmMMgCOOSTlPcZvjmrhrClIz3p2mi2oWVLR4tFs0NYaGVCcEUanBBV3h2JqmgYAnHJ+xQjIKXkElwjJEXB6DAbFW0BowovRkXn28LRLwq/nJ3K4heR/F7qmqXSDQAUTgCKE4FObunHwb4GxmAWEMMOPnkVrIB1vJd9AikF8V4xyBEOovzRPHJ+LOKz2mUrnJdNYglmKP0AneuhFu7b+izK9DYcp9Lsjzph+4zCZBSWLGm40N2Sud83z+33qhmxwmVAhE4Ym1OWhQESWtQGL9VU9So0Q1k2mZK1ILnQMFLxajmm8Mw0TFFzcY9D8/d7rG+VmEXyjrx0Ggtnj6Qwlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7RX/phWHlVEoxsHSzIOW1or+4JGj7N++9SPDEJKeho=;
 b=ep/jOZYYiyNR/Xb3qUpguooAw4/ZoWjZ5umg5D8YCqOARMeMBjTgEmiX+qW6ePzJ1Zu5AiuA1Tl4GSbP0moT7dGZmb+EoUMSzwSl5ngdzJwIkaKmvUZP1SftKkswNwe4PfFGiDxlYPQdo2iv8R+4huqbGhRf8p74/8XOcbq0wI1wG+ktFsLi08vwirhU6wUjxeAHL6iED4JRT4yRVTuZscdhp2dEuMYqz8fnvhfE+Dk5evbjwGEWahKkRD/eyd0ncYK599AroZa8I2VI7g2VCVOMSqXJhlVaKblrzdW+ijVJZDdbEFL4nCOjB3zNr0n5aUtlKFzekd4Q+weDxOmrbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by PH8PR11MB6998.namprd11.prod.outlook.com (2603:10b6:510:222::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 12:37:17 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 12:37:17 +0000
Message-ID: <52ae4de2-ffcf-45e1-ae6e-e6bbb6b1a178@intel.com>
Date: Mon, 20 Oct 2025 20:44:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] vfio/iommufd: Add framework code to support
 getting dirty bitmap before unmap
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <mst@redhat.com>,
 <jasowang@redhat.com>, <clement.mathieu--drif@eviden.com>,
 <eric.auger@redhat.com>, <joao.m.martins@oracle.com>, <avihaih@nvidia.com>,
 <xudong.hao@intel.com>, <giovanni.cabiddu@intel.com>, <mark.gross@intel.com>, 
 <arjan.van.de.ven@intel.com>
References: <20251017082234.517827-1-zhenzhong.duan@intel.com>
 <20251017082234.517827-2-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20251017082234.517827-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PS2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::36) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|PH8PR11MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 196c5060-8c31-47c8-59e6-08de0fd567a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|42112799006|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWNlUCtGQm1hY0syNmlMdHZxbExTV0gxK2VhalBIVXM2SUg2d1krSVJFQ3FK?=
 =?utf-8?B?S0JFVm0xczBJTGlMcm4wMjhSOHkxY0J1Qm13VEJ6U2JCb05hVldwZGlLTXQ1?=
 =?utf-8?B?QjJTYzMyVHNFL3B6aWl1a3g4eGU2aXNDT3lRN0tlWFJsOWZ4OTNqSjVLYWdO?=
 =?utf-8?B?cEd5bGx1WWJNN2lLVkRrQnl1ZC8zQVI5VnlhWXg0aUhRcTFlU0RVMzVNaVhn?=
 =?utf-8?B?Zk1LalA2bDBXNWZ3YU5BN0dIaE9WeTFRWFE1dGlpMkVxVjV0WlVidFZXUGwv?=
 =?utf-8?B?NEtFbEVucmxyaFRQbmtQc0I5WkpuaTJTaVRDWkl0TXkzRGt1YW94VzNCdHp4?=
 =?utf-8?B?U1JKTkxBNCtyV01JdlVTRFQxempQT0oxbmVhbG9tbTVFTytDRkNNRDFNbThn?=
 =?utf-8?B?OFp5SlNFWGNVbm5Db0NHYkdtNitna0d5aGVUU09VdzNjbUFZUnJHR1RBd2Fk?=
 =?utf-8?B?K3VtNkgzOVB3K1hVK2xxVUZCaGZBWHJ0bzk4bVhaS3hMK2M5ZTg1anZna291?=
 =?utf-8?B?T3pkd3ZNQXBQaXduT1JnblNKV041cXREc2ZpRFRxTEh4M0UxeS9ocGhqOWFw?=
 =?utf-8?B?cG9YYUNLcVkxMUtDUTlCVDJPa2JQNXR0VWhQeWtIL2N2SXpmVnk0ckpzUGla?=
 =?utf-8?B?aDhxcFJiNVBIOHBvandLU1QzYTNSclE3MWNXbFgvRG5TT2lFbWtWbkJNK0xq?=
 =?utf-8?B?c2w3ZDgwY2lqcE9QTWtKRnBqTDBNa0pkV2FzeUtORVhKNU51L3VGSXJWdDZo?=
 =?utf-8?B?OXRObVJnYng5ZkgzaFRVN2lJUzFCWnAzaTBPK0pWcjJyM0JIY1pVdkpFeFBl?=
 =?utf-8?B?TnJrQXN4bCtLb2h6RG11SjVYSHFWdzNLU2RGMk1VSzZVbW9wSG1QUmhsVWJj?=
 =?utf-8?B?MDJVRjZTc2ZKdXFhNFhKeTFlM21nS1l6Yzh1d0ZyS3lWbWZhZy9ZYmpNVCt6?=
 =?utf-8?B?cjFWbFdKTlBBdWt3ZElZcDc4NTNmemwvSzBDYUo2Ym4rMXhUR2FEaXAwWUZL?=
 =?utf-8?B?YVNuMTFtK2M3VExRTzlaeW1vUHU5NzdWT3NqM1VLVCt2NU9PYlcxbExOM1Z4?=
 =?utf-8?B?dkhlY3VnTlFjRlJTMFFDaXdaSmw5VGF3TlNZdVViRmsxcmNGcWZZSzNOVjhE?=
 =?utf-8?B?Sk9WV3BzUnkxUlEvRXE2ZkZmU3BIYzBnWGhFVkFzc3h6QkRndmYweU1MajBt?=
 =?utf-8?B?ZEgvanUxQzRIazhNcVdqN3ZONDFORjJGNjdyR2JJNkJ1Y01QalpMejlVZmxh?=
 =?utf-8?B?MWc4ckFOeDFWUE1ETUpyZFhzcjQydXk3cXoyb1VhQi9ZdUJZNWdDNUVMczhS?=
 =?utf-8?B?S1N6RmNxclArTWdkS21kcWluNllCeWFuemhmdXkxamJseXVIV3hKNktoZmh2?=
 =?utf-8?B?TWRONWFkQXlTa2RyT1c4R2lqYitPV0xOYlVSY0tyeDVvRFZwMXRnR2lOV2M3?=
 =?utf-8?B?dTMxV25lc2ZmMGxsTEF6dVU0S21aUEU1RVpLa21DYXR4SXFuQktLWENMc1Ur?=
 =?utf-8?B?V0p2M3B2U2FaS0ZQaHBOL2R6dWxYOGVTb3VSUnI1SlE5NXNDQ25xR1hLWFlZ?=
 =?utf-8?B?Y01CR2JKVVJHcThZTWJacU9HRkp1NUdZc0I5RlJ0UE5sT1NWakhWbFFSWWdZ?=
 =?utf-8?B?MGc3UTYzcXZ6RmRpMmUwWW9ZOGppWEVFU09HWXRKTUFadmp1Z1V5UVlvbTlW?=
 =?utf-8?B?WkV5L21FNWtLQUpnR0U1K2JlcytiR0pRSW1veUNtWVJzejFFVHpadTVEbXla?=
 =?utf-8?B?dGdDcExza1VHdlRRbFZ0MWtwdTJ3Y3lsUkNEUFFPUjNVTCtvM0lCUHJ2d3k3?=
 =?utf-8?B?M0RGN20ycTV3OWRlZ2J5d1FlOEpNMHVaemRVN1NKMGNHU051ekg5bExxVHFV?=
 =?utf-8?B?VVJva0lvb0JZdENhSzAydDRmUVRPZ0dOVHpRZEZsc1ZNRmhHcXhUVzY0QTdV?=
 =?utf-8?Q?aAtLKmRACLVJZ7x2/4X2A2tiHGqQGfWK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(42112799006)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHlpL25nT2Z3a2R5K1RTSzlSNGVFR1F6WGxCUVY1eFJUZ0t6cSs2a1hvUHBr?=
 =?utf-8?B?aHNON2NDMDYxTklXdHVaWUdUNjNmQ1F6Y3ZEYlNmVC9DOHNWMnhzYlVNZ1Jp?=
 =?utf-8?B?T1NXUVFrcW8rZjUyeGpKQXRqYUNsaDNaUXNqbTJBb05BazB2bVA2ekhtK2Jn?=
 =?utf-8?B?OGlwaUVPajdVRlVlQmRuOVVleWVSbTlEMU9xMGNFQjlZQXVRbk80dmNIT0VZ?=
 =?utf-8?B?Ymt1VURlUVoxdmhwbHFSdS84WTl2SUZpR2dRdjV1MWtwcnViK1Babmx1Um9W?=
 =?utf-8?B?dXZkSEgvM0lLL1Zta2lIM0FjeEJiOHdlRXJzUC9yZnVTZWZPeW5vanl4STdq?=
 =?utf-8?B?cjlQREl4ck1rb09tNHBuVDlmVnpUVkttNWpEeElMbmdmS2RYU2o4eGgzajU4?=
 =?utf-8?B?ODhPYkd0REU4SzFEK3VwWmJUMVA4c2xwa2NOelgvL0lCL0ZYT2syNkpFeHVl?=
 =?utf-8?B?YWRFajA3MGdYaU52SFpveE1SN3lsQ0dXbTltKzFibU9WOGR3anNJZk51N2dS?=
 =?utf-8?B?eFBoTldJczZDd3dtSTRveWtjUEdNaTZHQXZaZXZnWWwxQnh6OWNqYmx2MU40?=
 =?utf-8?B?RlFLMlFVeERVVVBPSVo2VjRYVnh3NWhHTDkvWi9hY0tjYmFHdnlOMkZrczY2?=
 =?utf-8?B?VWN0R3NmNmlOMEsvbFA2TDcwYmp6ZERqeUorUmVIdFV2elVTZE9COFYvY3Fk?=
 =?utf-8?B?VXprbVNpWGU0N0x2c215Y0tmY1ZxUWNUUTZVcjYwRHB5VHJBd2hpOWozYjdF?=
 =?utf-8?B?aHorRVRFVTBpZmpVWmdGYTErak1EVFh1QjBMelNQdUMraGFhbVlWQjJBWlpk?=
 =?utf-8?B?UEhOYVlFaFY5V0F3WE1KbFNiV054cUNFcnRIbUtaekx5M0NHWmxMVnNnTVVn?=
 =?utf-8?B?QkNMMVhJbjBlbHEzWkN6WW1hcWdBTWo0QjJUblVxN3Zrc2sxK2hZOUJuMFlY?=
 =?utf-8?B?aTQ1VkY1Y1hYRFFSV0FYZmFzem9tSUVOQmdxMzZNeVc1SmFiLzg1VVI3R3JT?=
 =?utf-8?B?aTFBeityL2hzSFB3OFhTZUp3ZkRDbFNFcXdzclVWMklSU1htM2g3NlMya1ND?=
 =?utf-8?B?eHVHbE82S1VLMklyZzM0UGhCUXNwekJxNDlxbkZCSDU1UkZJa1JVNEpmSjNK?=
 =?utf-8?B?WFdhZ0sreFVnc1NDYlk3K29SSUhwRXdMQy9WOGh6YktoNWdzczF1cW0yZks3?=
 =?utf-8?B?OHhJbS9GSTd0OVFzbEdEZFZjTStiRERrZy9nTXdUOE9YcWxxcVlieWFPaFlZ?=
 =?utf-8?B?aFArdkMrZGt6dFNTeVpnWE9wQWw5cjVnamVwbE9MZzBycVV6SnFubm5TbTha?=
 =?utf-8?B?cWR4YVh6VGdnckR3enM2MldXVXFqUG40REplaHpnVUxRQXJNN2pKbUJtdTRy?=
 =?utf-8?B?R04zNU9UNlI3Ymc3NWhHbjFxdENNSnQwOEFvOVRLajF0aXdpUmxDVkxITklM?=
 =?utf-8?B?M1B6b1FCK0llaSszeWhidkQyRnlSSDA1ZHZhZFJBNnhNUGdXeTdCQ0w3WHBI?=
 =?utf-8?B?RnVRcmZXNnJQYzVCSjYyQWkvSG9WVysxaUlTcGRMVUdhamZCODcyMkduUW81?=
 =?utf-8?B?WFNqTVBvOEh4OFZ5YlNuRzhzazJlaktGL1gvR2gzR3dweFQ1QUgzQ1d2bERJ?=
 =?utf-8?B?TkhacXBxdFZaTHhrMFE2alU2NDhmL1Y1QXpUSjFvMlF2WHhrTFVnV3QzemlN?=
 =?utf-8?B?R25jc0JmcjJOQVRMdnRwRmw3dnloUkFIQWFUckFtNzNlTER2dGlvdVp0Qk5x?=
 =?utf-8?B?QU1HdTM0YWgzMElSd3JlNWhpcFZzaGtqVWlvK0hMR2FoLzZoeEN4RVNVWjJ3?=
 =?utf-8?B?L3JwY2FWQy8ydFVpNWhyaWlqaE1qbTFReGtyZlRaT3l4Q2NhT09VMEFvTGlu?=
 =?utf-8?B?UGVhME5XU2dtdjhRaS9RalF2bFhaMnhIZ3JrUkpodTFJRFczdDVWVDcrSTh5?=
 =?utf-8?B?OXova3JvdTM1c29wOTFIL25zak9qc0pmQzRvNlFmTzRuUHI0dlkwUzgyQk5x?=
 =?utf-8?B?b01yNkgxd292RzY0NXdFSk8vbWtIYjNzQ3c3cGwzZFFLMXZDWUFoRVpSNHU4?=
 =?utf-8?B?alRKNno2b1kvT0s2d0JrRUhVbUpOL1lXaTQ2NC8xNE02aGJxTWs2U2t6UVJK?=
 =?utf-8?Q?O0sESqGezXxX/5nMSZ0vYZ29c?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 196c5060-8c31-47c8-59e6-08de0fd567a4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:37:17.6915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIPS9vYSobo3d+9sHLLATDNRcYx2+O01x8NyeuRoUBp4/G/+O//ovAL9GyJK02Z726+1jyXtQMFRWot3iMeGqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6998
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17; envelope-from=yi.l.liu@intel.com;
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

On 2025/10/17 16:22, Zhenzhong Duan wrote:
> Currently we support device and iommu dirty tracking, device dirty tracking
> is preferred.
> 
> Add the framework code in iommufd_cdev_unmap() to choose either device or
> iommu dirty tracking, just like vfio_legacy_dma_unmap_one().
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
> ---
>   hw/vfio/iommufd.c | 34 +++++++++++++++++++++++++++++++---
>   1 file changed, 31 insertions(+), 3 deletions(-)
>

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index fc9cd9d22f..976c0a8814 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -61,14 +61,42 @@ static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
>                                 IOMMUTLBEntry *iotlb, bool unmap_all)
>   {
>       const VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
> +    IOMMUFDBackend *be = container->be;
> +    uint32_t ioas_id = container->ioas_id;
> +    bool need_dirty_sync = false;
> +    Error *local_err = NULL;
> +    int ret;
>   
>       if (unmap_all) {
>           size = UINT64_MAX;
>       }
>   
> -    /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */
> -    return iommufd_backend_unmap_dma(container->be,
> -                                     container->ioas_id, iova, size);
> +    if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
> +        if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
> +            bcontainer->dirty_pages_supported) {
> +            /* TODO: query dirty bitmap before DMA unmap */
> +            return iommufd_backend_unmap_dma(be, ioas_id, iova, size);
> +        }
> +
> +        need_dirty_sync = true;
> +    }
> +
> +    ret = iommufd_backend_unmap_dma(be, ioas_id, iova, size);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    if (need_dirty_sync) {
> +        ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size,
> +                                                iotlb->translated_addr,
> +                                                &local_err);
> +        if (ret) {
> +            error_report_err(local_err);
> +            return ret;
> +        }
> +    }
> +
> +    return 0;
>   }
>   
>   static bool iommufd_cdev_kvm_device_add(VFIODevice *vbasedev, Error **errp)

