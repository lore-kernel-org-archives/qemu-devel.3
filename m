Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0038FCD4851
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 11:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNU4B-0005EB-Ab; Thu, 14 May 2026 07:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wNU48-0005A8-PZ
 for qemu-devel@nongnu.org; Thu, 14 May 2026 07:17:20 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wNU45-0007rT-3V
 for qemu-devel@nongnu.org; Thu, 14 May 2026 07:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778757437; x=1810293437;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=D/0w/cMEIXmirQ63Iu+jkIlwvOCV1LGTr5nlrZse+oI=;
 b=PRlQY567wUEQffMAFl+OIne79zxISC9mYXwBFBJaGS91j+E0gyJKPT+d
 iaLHsWAMFsclSsbllxtjmFq0bdzEGmCUKRy7frpKie4GBkbz/+Y7IM4LU
 JXSnUdUNgSOWVSqMsuhcxXjrG4JF6WsrQNlwKsWuNqSS76eWWfjV1crX6
 c+o8GhkiQK6g3ciqQZwsPdg4ap/MCy/SLBdvfugvQQmSQqUmzjOeivFlr
 jVOdNXcksiN5JsxSz3xQE4jIQchbVjchDW9KzdnpK4W/Vs8Hz+hHKrbyS
 SXOEvf5wKS4yUuk9W5MNTK4PbkHakpLp1S6cU+rrXvg+gLP1M/midblnn g==;
X-CSE-ConnectionGUID: OhqiCUL7SrqDgBRSctOlSg==
X-CSE-MsgGUID: KTNqHVsrRaOpveZ6vK4hOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="90006581"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="90006581"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 04:16:58 -0700
X-CSE-ConnectionGUID: UqQhkaZtRCCMU1zN/yfD7A==
X-CSE-MsgGUID: Dqlo/ehsTkGPZ7kVHtLM2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="242355696"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 04:16:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 04:16:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 14 May 2026 04:16:58 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.34) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 04:16:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XC1zx/QN77MNz4HXBH9BhYTDeKDOoIqEigxQnHfs02bBrAo+mqdInORFs5D7C9Fd81n5OnaubiNh8u+juy7Lep//Jj5T6OKeJVPqiQGJgaHovwtjdHJYYKzmec2o79I1yrskUuPdlYfyazyCkKhDyUZBuE0K6rrAALdI5MqAkGt6lM0xoN4kUiMXlt6wLtlA8qzA/u4D8yJMbby14and77T4D8ICnaciyBZMRm8uVqH/l2VDuYW0d+6de0eB6wV5VjDsCu1zx75O3UN1QxfAysZVUhJ0OgxAFmUxmhieurCYGzEYmraByiXWrWfUo1UGR+8zNY+A5zJNMiLw2NaS/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1Lcmuf55Pys4ZHrPqbkmx8Vwi0Tr6hIEuwtW/C5nmw=;
 b=JoHPISzJusVJRB1YZKuQGmVBnu1wlVl6uWxKkGuY/PX1Dt8b8bs1U1WzhcVuZlTjzXLtBC0TtZj6gWr/AKinCxEGjqEbRrkoZRaXvFXyGVyew4W0zgG7EWdw1LCPfaCNrvcz6dJweeq0Fmp3az3p5XIJt6/CiO/RfVS0+i+sWSgsT5nJv/ytILdlp+eQtaTEIb46WAlSLkREF4yzRMPgNrBTnIIhaEvvN6tumJQwAG+SGQ71oR3lNgoGn6XXPM+UA8PGswMlIWemp+DLs2Lo4VnfZVcQ5W9E3vXApsUETKZ+HqPffKXdxk4v+y06Di9gZbmvLY91fDhDBVLfuP5Ehw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by EAYPR11MB9588.namprd11.prod.outlook.com (2603:10b6:303:2c2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 11:16:50 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 11:16:49 +0000
Message-ID: <dd52f20e-16db-4f7d-a8f0-12672953ccf2@intel.com>
Date: Thu, 14 May 2026 19:24:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/15] intel_iommu: Use IOMMU_NO_PASID and delete
 PASID_0
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
 <20260509040819.1044702-8-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260509040819.1044702-8-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0022.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::18) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|EAYPR11MB9588:EE_
X-MS-Office365-Filtering-Correlation-Id: f2221605-8bb4-4e59-4213-08deb1aa4afe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|366016|7416014|376014|11063799003|4143699003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zLaxl6SPRpDOfhBAnI/rl2SErqzdmeR7oqQOOFxvG1yIfGdlgeSqOBTQ3SVhPWS8fxMzKBz0Q5xCPJ2fruTujA76m+gvvJfLMAW5NXiWv9oL+E+pQXHIhAwNiawgsEIUhN1FQlM1fvlZD09A9blEA/4fi14OYYC5NvXGqykVrWF7n1/5ITNPJR/+nwUucAi380EJsnj9SoZYt+FBE3wLlyOiA1dB+SiA89NFbYWsrrmfH2jC+Xw270evV1J2S9ptdKJdFsjl1ZvPKtpOQ3/vYyUWtHCfAH+AumIUYbVAtIuU6YMfK5pDLIGnC081suxaDDTsfV6prMfHWplYpI2r76Oa3qVi8+5EVifldgfJxu9gGtA9G15zDQCYYHLgBMWgDCvvMe2rimBBs51xJ8AB4aZ6fzQ8gMUTiupEA8kvcTcvZbslwsSfyUmjMe4d1mAa4PfU8gwqYbM4s3pHbbKMLPQsBCtYd656cQTDYmhKRNV1YddCyPmT2SaLwrz8fKHXDOP64A0w8V1XArGvuY/u5x7LsThf4CXap3d96A1DO8EwMQnzZHWDTgm0m207Pn5GAA8FnOrgluS+3Icw9KRX3/MB8DtLOrkcSfDZ8am6cT3gDnEhhNC2M+zEWo6fzYiqcAXeFTRvznvED62MavBp/OxRg32HDBHR/9TEUGrBucD9WzHSBxhC4t0f5wsxF5ZB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(366016)(7416014)(376014)(11063799003)(4143699003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEU4WUtkTlM3TnhyQXNYZk0wTjZ1WnZJSW03QS9wbFhLK0thMk8rYjNxRjhm?=
 =?utf-8?B?RmdaZTNSWmhWWUVLUWxZSkYwSVV0K0p0VUcrUjF4UVlPQ0JBSWtlK3h4RTVh?=
 =?utf-8?B?cXloZWVPUDRFVVBBZDg2TVpOcndORjFpK1o2QzZIeUN3WnkweHRoRWtsbEdL?=
 =?utf-8?B?TnFhdmdJbVJFNy85bTBDV0piZkFDakZtWUFmSlVsc2Q4cDNSYmlPbzRPVk5Y?=
 =?utf-8?B?OFp2cW5Ec1NsaElsRUlVZTk4OEQzVlB0Sm5hclpUT0ZRM2FrR09SV1FqaEJi?=
 =?utf-8?B?NGR5L2todHRuaUdoZ0tORDNsQkx0TmFXVHg2UmVBRmorWFp2bTgxUEN5cWYr?=
 =?utf-8?B?Vm1yQmdYZFRyeU53NHhOWXJmcE1KdUtrb1M2VjROeFF3ak05SHZvbUNUakd1?=
 =?utf-8?B?OS9MWTRqcjRXWlZqZ3ZWaDNEL0xOY2JDYTIrdUtUb1QxRXc4RXJveUc1STJi?=
 =?utf-8?B?RDFmWFliaVNOTFFzay9ZSWkwUkV6eXhSOUI3TWV3dG8vSjQ2RmpGWlRwSGtr?=
 =?utf-8?B?OStkQzEwZ21jSGc0TXIrRHA1Rkt2Zkp1VGtHYkl6eDVuSkV1dmJ4VXZwcFho?=
 =?utf-8?B?SFVKTzRGVEIyZlF3MDlQWFRoaTFIYmFwT3JFWjVicGhHbkdxUTRMd3hqdHpa?=
 =?utf-8?B?MTJMYmhHVmd4b1hDdkFPK2l6SW1iNFpBQTYwTVBZNnVEQ2RFWXRzZS81ZUpr?=
 =?utf-8?B?d1FOZVZrT2JpNWJWMTFzSmJvelpJdDM0N1V6aEczQVJ3RkRhZ3RvMHhCekZD?=
 =?utf-8?B?U1FGMGJpblRib290elJqdW82NXZ6YXREc012ZHdsbVIvdmNtNFdLUDRudjZX?=
 =?utf-8?B?L3BxNkdLNDJDR0pyZDMxcWZJaVpoTW11NHBmVVZuSjhvNGttMTZYa1FLV0JC?=
 =?utf-8?B?c05zTFNBMFBFd1djSHRzUXZDdjV0MDBLWmRBT2hCRDk1ZERwM0Zla3FzanhP?=
 =?utf-8?B?MWl1VjJtbHJiSHlXMURpcGl5Yys5TWNrUlBIdm1GbkYxbDI5MDFsMUZ6Z1ZP?=
 =?utf-8?B?Uzk4NXJVTEYveElYcktnOXI1UmgyalNBSDNLQWcwaHRnQXh3bFJTbDdrajBu?=
 =?utf-8?B?YXcrNzJHT0FFRCtpbWpTVFV2RkFKVlh3alVOeHhXUVZ3WGtldW00N3diY1Vy?=
 =?utf-8?B?QnBOcVBkcUk0Q0svNjhxM1FORk12YmR4RlBwWVhMOXVHa1RocldwRnczb1Y2?=
 =?utf-8?B?V2dqaWg1S3NNWlVuTDRXbDNvVm1vd0MrM0VTN0VWZWYzSnEzRGxmOTJSMmdw?=
 =?utf-8?B?VjErL2xNcC9DWVRzU0RvWlo4MlFzRHIwQ2NFaXI3T0FCTTBVMjlSYVZET0FW?=
 =?utf-8?B?MXQvaDNsMi9leDljaENOOHRIYjMzYkFqZVpqaEt3M2E0WGYxbExLV0hXUlpW?=
 =?utf-8?B?dWduNE9rbzV0eWdtbm95QnVLNlE1ZVdvTzJRQmZxOXVaMDM4ZDA0eCtSaFFO?=
 =?utf-8?B?Wjlvd3ZTUzNReCtuK0tmU2c5Wk5ud0RDamJsN3ZhUEpqQnFUNk5ncllrbkxW?=
 =?utf-8?B?dWprT2x6QXF0N1ZlQ29VeEdCK1luVjQ3RUtld1JoS1JIMEJ4S1YzNGQ3VlpN?=
 =?utf-8?B?MVE3NExtRzNvNW5YYStxS1BCeXE2TkJMZU44QkdXWWhVNnI0TXI0V0FvUzNW?=
 =?utf-8?B?VmMyUFRjNlBhYXBqd292aWRKUnFXMmNEWEl4ZS9heis0WXBiVFFCZW16NFBx?=
 =?utf-8?B?V1JoNjEwa1c1aEMvMDNJNVNvd1FrZk5WMm5mNVF6VVlrcEZmNkhmenNkYllF?=
 =?utf-8?B?K01SakhjaG5wVGc4Wk11U2xOOUp0dkNzTkhLTys1WHhtdDNGVWI5azdxcERu?=
 =?utf-8?B?bnRwOXkrT1pTemhjb2dBWDNadUFFWEl4UWoyQkh6WFEzZFNFNzg3L1grTG5G?=
 =?utf-8?B?VlBRajRYbFNmU0dKTW8xdUNaYklVTTBaUENuY21LOVl5VTlVWW1uanZSOWVU?=
 =?utf-8?B?ejRhVE0zaCtUWW5zdGFKZ0xTaUdkWDFiTUR5OCtlRmpmKzg5ZjNBMVRVekhw?=
 =?utf-8?B?ZFJCRitCcGNtWlkyVUpLdUFtQlY1cGFFeWRlS0MvQSs4NmdQaC9scllLWVRC?=
 =?utf-8?B?aDgwbGF2V3k3UVl2S1ZCMnVEcFFkOGk5bTZtQUhqaE1uSWoyMVE3bmoycmM5?=
 =?utf-8?B?aGN1Nk00QzdRRDdmOXNaRU9hUE1hMkpaSUdXWTMwWm1iL2pXc2w1L3BUZnJi?=
 =?utf-8?B?U2h0ZzUyOXhXOE40ZDZsaXhZS28rSENIUmluOVR6RThIYlJ3OHRlVVNsQU83?=
 =?utf-8?B?dWRSUmU3WHdtN3hCdm50OXZwRTU4MWlaYnFkVHZtY3R0Z3JKMUNDWUJZR0Nr?=
 =?utf-8?B?dFJKL2J6bDFSdlNsSDl3cHZoMnIwbDQxRmNrSElkemR6Q2toUHRHUT09?=
X-Exchange-RoutingPolicyChecked: DpaT4u0KVCioJap4DmIvGTopSij6m0vF6zrJp3M52Ielh0vjtXw3W031hecL3Ki9VwJBBnbcvwLh99XqAUzI9L3AwJEikTBIky37JqKNLgTh0AN53A4u9XkS89Va6x2NGs30ssXwGhGligm+qBBM3Vpmk95Ok312u1pRl4GYSWNTAa1h0EZcGj6G5GXWCdHXnji+g3MJvlfPNg096Vq2BvFIJyM5btWYpk3ekhj1taHNaVQ8C4J3weDGBHZUmsz4Jo8aL9Nw2rJJnVLNG5sln3GyVqXQqzFqgyhZ6uz8DEhLiJpcDmOufScUyH15bSxp/O0P4GBtTUh4t7dJytj+iw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f2221605-8bb4-4e59-4213-08deb1aa4afe
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 11:16:49.7062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Aj9JDU90OOd4bltjfa+QMnQuVttDNrtwyeA+BApFTVikwiu0N4ywenfEqOLaDu+5xd8waaHZAEtJN6JsFjZ0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR11MB9588
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11; envelope-from=yi.l.liu@intel.com;
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
> In previous patch we introduced a global macro IOMMU_NO_PASID(0) for
> the RID attachment, this makes the local macro PASID_0 redundant.
> Delete it and use IOMMU_NO_PASID instead.
> 
> No functional changes intended.
> 
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> ---
>   hw/i386/intel_iommu_internal.h |  1 -
>   hw/i386/intel_iommu.c          | 22 +++++++++++-----------
>   hw/i386/intel_iommu_accel.c    |  2 +-
>   3 files changed, 12 insertions(+), 13 deletions(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index c7e107fe87..0141316f83 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -615,7 +615,6 @@ typedef struct VTDRootEntry VTDRootEntry;
>   #define VTD_CTX_ENTRY_LEGACY_SIZE     16
>   #define VTD_CTX_ENTRY_SCALABLE_SIZE   32
>   
> -#define PASID_0                             0
>   #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
>   #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
>   #define VTD_SM_CONTEXT_ENTRY_PRE            0x10ULL
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 36af13cee3..5e5dcdc274 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -941,7 +941,7 @@ int vtd_ce_get_pasid_entry(IntelIOMMUState *s, VTDContextEntry *ce,
>       dma_addr_t pasid_dir_base;
>   
>       if (pasid == PCI_NO_PASID) {
> -        pasid = PASID_0;
> +        pasid = IOMMU_NO_PASID;
>       }
>       pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
>       return vtd_get_pe_from_pasid_table(s, pasid_dir_base, pasid, pe);
> @@ -958,7 +958,7 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
>       VTDPASIDEntry pe;
>   
>       if (pasid == PCI_NO_PASID) {
> -        pasid = PASID_0;
> +        pasid = IOMMU_NO_PASID;
>       }
>       pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
>   
> @@ -1501,9 +1501,9 @@ static int vtd_ce_pasid_0_check(IntelIOMMUState *s, VTDContextEntry *ce)
>   
>       /*
>        * Make sure in Scalable Mode, a present context entry
> -     * has valid pasid entry setting at PASID_0.
> +     * has valid pasid entry setting at IOMMU_NO_PASID.
>        */
> -    return vtd_ce_get_pasid_entry(s, ce, &pe, PASID_0);
> +    return vtd_ce_get_pasid_entry(s, ce, &pe, IOMMU_NO_PASID);
>   }
>   
>   /* Map a device to its corresponding domain (context-entry) */
> @@ -1564,7 +1564,7 @@ int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
>           }
>       } else {
>           /*
> -         * Check if the programming of pasid setting of PASID_0
> +         * Check if the programming of pasid setting of IOMMU_NO_PASID
>            * is valid, and thus avoids to check pasid entry fetching
>            * result in future helper function calling.
>            */
> @@ -2122,7 +2122,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>       vtd_iommu_lock(s);
>   
>       if (pasid == PCI_NO_PASID && s->root_scalable) {
> -        pasid = PASID_0;
> +        pasid = IOMMU_NO_PASID;
>       }
>   
>       /* Try to fetch pte from IOTLB */
> @@ -2487,7 +2487,7 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
>   }
>   
>   /*
> - * There is no pasid field in iotlb invalidation descriptor, so PCI_NO_PASID
> + * There is no pasid field in iotlb invalidation descriptor, so IOMMU_NO_PASID
>    * is passed as parameter. Piotlb invalidation supports pasid, pasid in its
>    * descriptor is passed which should not be PCI_NO_PASID.
>    */
> @@ -2508,10 +2508,10 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
>                * In legacy mode, vtd_as->pasid == pasid is always true.
>                * In scalable mode, for vtd address space backing a PCI
>                * device without pasid, needs to compare pasid with
> -             * PASID_0 of this device.
> +             * IOMMU_NO_PASID of this device.
>                */
>               if (!(vtd_as->pasid == pasid ||
> -                  (vtd_as->pasid == PCI_NO_PASID && pasid == PASID_0))) {
> +                  (vtd_as->pasid == PCI_NO_PASID && pasid == IOMMU_NO_PASID))) {
>                   continue;
>               }
>   
> @@ -2563,7 +2563,7 @@ static void vtd_iotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
>       vtd_iommu_lock(s);
>       g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_page, &info);
>       vtd_iommu_unlock(s);
> -    vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am, PCI_NO_PASID);
> +    vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am, IOMMU_NO_PASID);
>   }
>   
>   /* Flush IOTLB
> @@ -3022,7 +3022,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
>           if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
>                                         vtd_as->devfn, &ce) &&
>               domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
> -            if ((vtd_as->pasid != PCI_NO_PASID || pasid != PASID_0) &&
> +            if ((vtd_as->pasid != PCI_NO_PASID || pasid != IOMMU_NO_PASID) &&
>                   vtd_as->pasid != pasid) {
>                   continue;
>               }
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index bd1236c070..8940d240a1 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -217,7 +217,7 @@ static void vtd_flush_host_piotlb_locked(gpointer key, gpointer value,
>   
>       did = VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
>   
> -    if (piotlb_info->domain_id == did && piotlb_info->pasid == PASID_0) {
> +    if (piotlb_info->domain_id == did && piotlb_info->pasid == IOMMU_NO_PASID) {
>           HostIOMMUDeviceIOMMUFD *hiodi =
>               HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
>           uint32_t entry_num = 1; /* Only implement one request for simplicity */


