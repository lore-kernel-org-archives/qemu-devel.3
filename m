Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B708B103E168
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 12:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2phA-0002C8-1x; Wed, 18 Mar 2026 08:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w2pgr-00029R-AQ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 08:07:58 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w2pgo-0007C3-5Z
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 08:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773835674; x=1805371674;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=m1TQZJsgxaN6RGO98N0DxbnHBba7plgZe0V1rdcj7VI=;
 b=Zh35n86LuWbFaNJ52x3BkBrxfM0NoGfThCKgwRsqF6pJ1AV4sEI1QzAx
 KuDH8qH4gjb5rBeARA9ZEYA7c5wPZ0mOysCFmgezjVGMQvPwtwLhbOJiU
 XWJNgXQfuZrjq1mUeejoSoxkkN5TVWDXT64XbIfzcICE5RIfJsV5e0AmG
 IggaWA/1z4GwsjAoluTDvI1OyRK8ao7G2fufg1iWacUO7fBlABaQTveHO
 LgvKZefuitKyHqJ30SZOL0GTn77PGTTP/Go/+Gff15dm+FTN8qdU77XHC
 9D4wmVxa6ufVUXvMdEFFQ/UNk2I5Q3LZF90U67mF250nUUtFvCRxKLXhN A==;
X-CSE-ConnectionGUID: 4vf6JIq7QHuBVjWaAH7wHQ==
X-CSE-MsgGUID: /Mc8GrhgQ/CvOgBLXoHePQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74773110"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="74773110"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 05:07:52 -0700
X-CSE-ConnectionGUID: 3WdvgCh8SpCKibg2tQNSrA==
X-CSE-MsgGUID: 7jWZZYcpTKGF6KHF1YVlaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="220048329"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 05:07:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 05:07:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 05:07:50 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 05:07:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epIE4VQXsX+2mwFJXkQHVM9vq+Sy/IQQPeoRZzPa/tfXo8mynvM/N06GOmSCu2bc2RZzIfhaa8qgnOilmBR9Z8AqQE5+YpZEfMQDl09dGlLmOzF3j1Dr5oKiP9wL3at1tc4rHbFwo2DuGcxwUphP+dz8znutDDGGNk3soSC3k61xKfhnshLkZkaOCFIrSGsDeLEb01MkLNT6RiLJvsRWz3FOolwXzaUBsw94ikPxbZ1oZxKQOsT1Qri9Bbd/0ixKjVESCuHIn0nXV+rENpeBRswCL7MGtx0iCgh1PU4y6cmT3hUGHXW+JcqrhrnJrsk2sxccuMpZQD6YdHNJjCOoFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCc8RYoxjECG4L1KFfadBVeZSahTwerZeRVX/0ZPxmE=;
 b=RJAfI2C9MOgZecA7i4QPpSEcKAmiPe3enOGTRijTUtn41x4LKEEZ2Hxkh/RwnqlDJeGi0V/vNBmMYx4oa648WlCyrgsChVcL/zeAs96TiDcvWLUZ40+LAlAV9Qy48IMDsoNrfHN/bYkSRe+YwrVDvQ/EkzXguq0guEL+GlzasNOA0gyu8cpRUJwITN3aa9SvbyPZBCqutZbd1HAz/zSrLely/COV5G0hcHXNd43LOonPayWDzRY0IIMi5n4YclSX/IULMSmpEh0LQH2Jr3p2rMsyueq8wUUatpIJEOx04f7XHJ7zOAHTL83t+TCAh7fXCLBUmw29KvW6dARzlb76Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by PH0PR11MB5207.namprd11.prod.outlook.com (2603:10b6:510:32::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Wed, 18 Mar
 2026 12:07:46 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 12:07:46 +0000
Message-ID: <a33c785a-ab94-4dc2-85eb-10b7d288f661@intel.com>
Date: Wed, 18 Mar 2026 20:15:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/13] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-4-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260306034409.184873-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0039.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::8)
 To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|PH0PR11MB5207:EE_
X-MS-Office365-Filtering-Correlation-Id: 115e4af9-d209-49e3-9fef-08de84e6f73b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|42112799006|376014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: BOxKxQ4jdcDWLegpxKHzuluVvSmEk7JQILQEzvZrjSWQTFJsSCPuTcptpJURXKWStGFdPvvSAx/bMFZTHh3DgDtmv+wNVL/iw3SZ6M8/zVD2kNI0LCAh1A0kGt3P9kfiiH0SWV5vgI2G67CvhqOGFPnkJDS3V5FMwRjZ2Mgor8sem/b3thefYoIJJC4+lrcPloA9gcnOKZH0ZEnVdaJoY4yFtdoL95oP421KLqrtPLwhmK3NOqMdpKQBACaBhyHgjv4+zo1SMTROepQpLJ+ESfhZbbcMhObyXu6MZ6wKUoYnuX9K3dp6xNO7jCZ1yZ7ZRSOWH4dDii4psE+yv1WHiDQJt/eKpaT/RpaaL+JtXcCxTTRKTILjJelqcOOK67mBDf13eTvcFShpquOQ4UWlwXHHB07l6j8XxkxmdzZTpFZg5fyo1qeOn+arAIUWRNlmKvaGoaBLVSr4GpaaEA+5RkERdbXQiiN47VURlmOiHGO4AnGFwHtxyuoWJSKio3U3Y9ob1nqmQFgrFWA8B+tq9NYgni242+Wfdb1jAKmoLHAXWdF3uirgmMcH9qD5aimzhM+kvZVwFJOCu7yH7+U2wrt4ryMPLZyxqymhB+oMY92M2MDzj4KhX/tFNV82OlN8Q1EbK/pp0Q98tOpNQT9e2x7v08xAEfiLDInxqEsKSHE3D+KGsWoBRBi1y58QA2SuiyjT3fsgOMIbWcBGsyCbKyoYWCUIbXxye7l/12DGQ9k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(42112799006)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnczYXJoNnlMa2ZVTWplQ2FDU2s5cHY0RER1b2hHaUN2N2cvS2p1QkFYL2M4?=
 =?utf-8?B?bk9aZTU0OGVyVi93K25ZdGhBUUN1c2tidGdBTlNQMC8vR05lMkNybGxuaUMx?=
 =?utf-8?B?L2hKYXpxd21jS01mZUxWRVNyYkFrNzZndFVVeFF2Y0RJZDRMa21Eb3dFSHNK?=
 =?utf-8?B?V1l1RC9BNnNqSEhWUU8vMVd6VXd0dUhVOVlENjg3czRFTSswaC9LYm4yczFR?=
 =?utf-8?B?TVg3SFQ2VmF4aStycHk3Y2E3VnU5cVNqTEpTdFdJNTJCYXhqVmFTSUFIeVBC?=
 =?utf-8?B?RnB0NnlJYkdFMzhtK3JWaTNNdm9RNzNIbnVwbnNqU2paMkxiYlZiSG1UeVFa?=
 =?utf-8?B?alpBVUk5T0FxU2Fmd1hRQThteUVZWlMwdG5CelBSOHpWNXAxcktoYWh0L1Mz?=
 =?utf-8?B?V3poRkZtbXFzN0lEckhqcURuejV3dUhGK3J5UmFXTTVVQjFPWjJiY2oweEYy?=
 =?utf-8?B?dG4vaklWb2FIRnZaWndnaFdyM0hza29rWVZQdUhXOU5Ld25aRkJhaEYzV1NS?=
 =?utf-8?B?TWgyZmI3VndJWlQrYWdIQjg3NmxLS0JxWXBValREbmlHeU0vTlR6Z2RqUkNP?=
 =?utf-8?B?b0Eya1UrRmNTSkR3RWFDS2kraVB3NCtzUm9CS1NMRVc4dE85M01SdC9VQnR0?=
 =?utf-8?B?cXNrcnlXTGwxVUpCZm5LUjh1bU4veFgwN0JBMWhXdVkxWVJFVzMxVUw5ZDV6?=
 =?utf-8?B?dUVRdFBDbEw3Q3hkYm5leklNVVR0Ri9GcE5paUlxemNCbXBOMmpZOS9Od0E5?=
 =?utf-8?B?bDdnNXBqOElTMjlZNFlMenJVZFJKVmQ0VXJFTEdZdjlmcFFNZUJzUHAvdzlB?=
 =?utf-8?B?UlZLVmN5eDc1QUNoMDZ1L0dQNk1tOWFpa3V3Z0ZpUDFwMnorSU5pL1VVZW56?=
 =?utf-8?B?Wk9QRVlZUzY4b2tPU285K2pYNTNDVUpyY21pY0Nma2drTEN0a0pzRG5tZ1FJ?=
 =?utf-8?B?TlNwd1AvNHQ0S3puL0VQdTRLQWczRlREUUVzL1Z4akxoZlJqWTJCMktrUHR6?=
 =?utf-8?B?Sm9yZ0t5bCtNU0VzSERoWVBLU0w2WndXQlNwNCtsR3cySnY2QWQ1ZSt1SW9z?=
 =?utf-8?B?cWpNWVY0ejFOMzZQTjIzV2JDSitGaDhRanAwVWt4d2dxaVNoK2E1M2cvZ3Rt?=
 =?utf-8?B?U1hQWGNoY1AxZ2ZBS2pUMjRGNklmT2hDSUFTUG95bk5ZNFIyUEJiWkcrNEdh?=
 =?utf-8?B?VTlYc0o5UzNGWVVmWEZjeHJYdGNoT0VUUWdnUEdreEFkTTgxMkhuS3N1eVE4?=
 =?utf-8?B?SWgrdzBWUUI3d2tmTVdVVnRyKzh1UjhVT3ZHRHN4WFZybi9ZZHppakc2Ukow?=
 =?utf-8?B?OG83RHdQbTYwK3RwT3NwRE5WM2RSZTFmQ2pZVnFLOUdHNkh5bGFEc1QwWG5u?=
 =?utf-8?B?V3paMW1EOTZuTEJHUVVROTJCTjVxcmJKYmlwR2hQbkVJTXNlNUZ1NElyZ2px?=
 =?utf-8?B?SnpLM0xSdUZJaFNVL3hFWHZIZTlsaUNBODBHSVNJNzZicHlrLy9ydzVjZ05N?=
 =?utf-8?B?c2RQaEZQSWZzcVBOcnpab0piZ1NvMzQvVzRLNFhYTTdXWHEwTlE3VCtkaUE1?=
 =?utf-8?B?VXVRNWhNcGFjZThvSm5TWEFSazMwMEtHNVBNaUNpcFliM0pSVmw4WGt5anJU?=
 =?utf-8?B?MlVwcFNzTWhJNlVKWkxtN2dRWktYaWFCMm1aRkJwNzRvN202WEViSFkzZjgr?=
 =?utf-8?B?VURvQVpZcWZzUlR1Zm1XTEY1WEcxVFlBUEtXNGljVG9qMnBhR0o5dW8yV2JR?=
 =?utf-8?B?OFNGQmhFTVc4SWM3M0F5V3dIcXZVOHg2dTNPUkdUcy9nbjF4bHBJMzdVeUxD?=
 =?utf-8?B?MzBXWUJRMktCdmxUUzhIMHAvUjRQSWRjNUt1TVkxKzFiU3EyVXFUM2Q0a3lw?=
 =?utf-8?B?RUJqWmpFVDB1TnkxZTV1QWlsVkl1ZW9pbURHV0piVHBMdTFuNURBaW51QnBa?=
 =?utf-8?B?QThuaDFoUGNCaEptYkJOQXFKWGJNdlNhdHN3c0ZCbjNWNnZoZ0hSSjFWZUgr?=
 =?utf-8?B?WndtM1VRbWhuZDNxdmx0bmRYRDJocGF3L2JkUFdQeXFhM2J2VFltSjBJaUdz?=
 =?utf-8?B?dFBQdXZtQTV3UDhxQyt6VHNtMjV3czllRWpNUTVleWc5Nkt3cGlrSWdvU2p5?=
 =?utf-8?B?YWt4cUROdmpJSEc1dGNzMkJjZ2sweHduMi9qSWVyWmdxT3h5U0tZeUdUc1lh?=
 =?utf-8?B?OUJwR1JFNnZnallrU24vYWREZUUwTVEraW5NK25GMGNsLzNqTHZRcTY0VG1u?=
 =?utf-8?B?RHd5aTdqdVp6Zk9BQk5zL2Q3R24wOWF5YVo0TDRBMnBDakRRejl0dGllVjh0?=
 =?utf-8?B?QkdOV3VkT0M5UnZsQWYwMUI0Z1pMazR5ZC85M2EweWg2a3A5S3RQQT09?=
X-Exchange-RoutingPolicyChecked: kBaHijDh9Z2t1nBz+kRThtmOst0ZBy8twsWKp87FZGj3vdQlSn+ZPyDEa6SkIgmM9IGDYv75RNtFbvtEWrV6yrmz+DShRmdrjp4FNYb8QcRYU0g5VfRJqe7ZhWdpHCrIG/WaowZI5NkjI3xTNLkx0tw9VDyD2I6bfvIWiayb7TAkExV48zZt2l43BWC4BJLNs4asXPF+aHSYs98Bgav5fLlbKvYZCDlx24NF7R4PKIJ/tnhK3je3U+dR6kH8+AkILikYiKzWC1nWSJwyvVZqGVaAkFHAdqMQxtOgKP6RpmsFfFXY8arDmidmxlVZ392kXAv+f1OQBCQjR77H4VNy5g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 115e4af9-d209-49e3-9fef-08de84e6f73b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 12:07:45.9861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEOb8kXKtRS/azgb/KyGLRAs9VFAZBvmS+Q0pa9I7z98KjLwWuiiSG9L/rlYE+C90HtuecEe6Dj6QjDYo8RvzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5207
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/6/26 11:43, Zhenzhong Duan wrote:
> When both host device and vIOMMU have PASID enabled, then guest may
> setup pasid attached translation.

Better be "When both both device and vIOMMU". host device enabled pasid
does not mean QEMU will for sure report pasid PCI ecap to guest. :)

> We need to create the nesting parent hwpt with IOMMU_HWPT_ALLOC_PASID
> flag because according to uAPI, any domain attached to the non-PASID
> part of the device must also be flagged, otherwise attaching a PASID
> will blocked.

This may make me thinking about why nested parent hwpt is special here.
I think you just call out vfio needs to be aware of potential pasid
usage and should attach the non-pasid part of pasid-capable device to
hwpt flagged with IOMMU_HWPT_ALLOC_PASID.

Code change LGTM.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> Introduce a vfio_device_get_viommu_flags_pasid_supported() helper to
> facilitate this implementation.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/vfio/vfio-device.h |  1 +
>   hw/vfio/device.c              | 11 +++++++++++
>   hw/vfio/iommufd.c             |  8 +++++++-
>   3 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index 828a31c006..dd0355eb3d 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -268,6 +268,7 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainer *bcontainer,
>   void vfio_device_unprepare(VFIODevice *vbasedev);
>   
>   bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev);
> +bool vfio_device_get_viommu_flags_pasid_supported(VFIODevice *vbasedev);
>   bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
>                                                   uint32_t type, void *caps,
>                                                   uint32_t size);
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 973fc35b59..b15ca6ef0a 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -533,6 +533,17 @@ bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
>       return false;
>   }
>   
> +bool vfio_device_get_viommu_flags_pasid_supported(VFIODevice *vbasedev)
> +{
> +    VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
> +
> +    if (vdev) {
> +        return !!(pci_device_get_viommu_flags(PCI_DEVICE(vdev)) &
> +                  VIOMMU_FLAG_PASID_SUPPORTED);
> +    }
> +    return false;
> +}
> +
>   bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
>                                                   uint32_t type, void *caps,
>                                                   uint32_t size)
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 005f97fe25..c408f9151b 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -360,6 +360,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>       VendorCaps caps;
>       VFIOIOASHwpt *hwpt;
>       uint32_t hwpt_id;
> +    uint8_t max_pasid_log2 = 0;
>       int ret;
>   
>       /* Try to find a domain */
> @@ -405,7 +406,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>        */
>       if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
>                                            &type, &caps, sizeof(caps), &hw_caps,
> -                                         NULL, errp)) {
> +                                         &max_pasid_log2, errp)) {
>           return false;
>       }
>   
> @@ -427,6 +428,11 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>           }
>       }
>   
> +    if (max_pasid_log2 &&
> +        vfio_device_get_viommu_flags_pasid_supported(vbasedev)) {
> +        flags |= IOMMU_HWPT_ALLOC_PASID;
> +    }
> +
>       if (cpr_is_incoming()) {
>           hwpt_id = vbasedev->cpr.hwpt_id;
>           goto skip_alloc;


