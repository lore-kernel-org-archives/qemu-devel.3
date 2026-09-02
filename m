Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDFDC624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1kYM-0007AD-KS; Wed, 02 Sep 2026 08:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1x1kYF-00077y-27; Wed, 02 Sep 2026 08:58:52 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1x1kYC-0003RO-UZ; Wed, 02 Sep 2026 08:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788353929; x=1819889929;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UTJOeNn3WDm2Ef5uioGsiQ1M31p7uWGJ/HHqueFuksU=;
 b=geKrfQHDO9MUEfTIKZZ0P9cbHCQUcRfHuFFJfoBKr1ZsBGcHx6aG+SII
 ByJyefQfoBJtd269kIUnN4jJqDnyEyus3lttFQSW1dFun9wpm7YBQxEop
 W4TiHclsTJyJNouObQCBzig/aXv5J9crgiRH8MqHGBI0bKfK5rbJ1NTrl
 3QVMqpyYwOBOp3+eudK/cHkW6JmS/RIBBDFYHww/++eAsuUgvTzIDvNOj
 ngeP0FXdMCIiwDirDCnKmfqKCRdXS9j64l4L7HYKTvSybwvJNP7uKoCrs
 PD8xkNGj/5+EZWL/d8tAQ50nmNnS5IzIBDvKf1TcRRjhTcu7syjr2p4jt g==;
X-CSE-ConnectionGUID: sFayYXQBSOGE1sYIZd9hVQ==
X-CSE-MsgGUID: 2V5cvWnsQ8yXOr37hjt6VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="106177958"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="106177958"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 05:58:47 -0700
X-CSE-ConnectionGUID: h623PCLMSo+kKAPi5qZXkA==
X-CSE-MsgGUID: Ti91PXsLTAe6thEfZv/EKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="299279141"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 05:58:45 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 05:58:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 05:58:44 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.14) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 05:58:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wX38wzk/+yiL2Ot2vpuoy6/EiiEDpD30DSaguk154hD0crBFF4DZUQ5r5kdiBAhrqNQyvw48gqX8ERU7Pr/MLktTyONf2CDt6UqZFBAb28ROy4jkUWTC+0Aizi8B9I3Arw9hZX0i8ReLb29zvwZ09B310b5mELrudsy9ywftAt1Q9UHcQD4IQnls7gS+iUIZkM/xeIhLfmgU2cwbRhfhy6e8JU5R/FNuhLrPtDhWubBGFmt6dtqfHum/p5eSdWKyN/vY/7k6oo3kyeyw51Nxb+LNVu8CfjRRokOjkMcbxBeR+neYrVJdUNbR9vxLwskmcNkPoppQyz/5tOEwFqibDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfy1hUBwMJKCySrmF5L46Y9oblJ8+tu5sZWBK+oPbkg=;
 b=S9NSKNB3YOxukcOB0v4wccIFtpQKJjz88UGV743GKJ7T39G0HQ3r3gBMBnWBzlJM81YcIBY4P7sEzhVBpgCd6b7GciUqGaYF34ncY38e8b5ZBAiVaP1zDqr6X1LFKdrKKhlvK1SCLlkYNSPzKfp2V2aHaaEzgndfX4guqnfTSG/wM0iyuDUcle3fl0HeYsO675pSzE8sY+vK9c2dvg99LuWqc7ktRwB2ihI4A6qWiT3oRO7EudXJzaQ/wwN5BiS0Vm8i1707Xx6unQLK/E5uFAc8/hBLezV8ftWLZcp2ZLd6BYDcVmpxMDiGsGFZL0npQ1BoFQTT+bEmz51i4atxGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by DS0PR11MB8666.namprd11.prod.outlook.com (2603:10b6:8:1bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 12:58:42 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 12:58:42 +0000
Message-ID: <8527cd6e-3cda-4da9-9137-9419d836ef88@intel.com>
Date: Wed, 2 Sep 2026 21:07:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] backends/iommufd: Extend
 iommufd_backend_alloc_hwpt() with fault_id
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowangio@gmail.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 <qemu-arm@nongnu.org>
References: <20260831095200.1279366-1-zhenzhong.duan@intel.com>
 <20260831095200.1279366-4-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260831095200.1279366-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::8) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|DS0PR11MB8666:EE_
X-MS-Office365-Filtering-Correlation-Id: 90b8d636-14ed-48cc-2e29-08df08f1ea0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|42112799006|1800799024|23010399003|7416014|376014|10067099003|18002099003|4143699003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: 8IjuRWVs340tNusMOXrqsbSaZ/7D0HH5kXi+JwHQb0moMVa7n3GMGsoF3pgXMW8mYtE5wlWI8odMrCMdYClT/3ATkGdRYx97FB/e3iKCum3PAbbkyU7ho02czywRHhpb7OaU78Y2NocH8liQDtSxSGa7lBu4YlOWxzmwjEXYbv6DyfcGTV1414hxXo3wWsMKv5R9ACsn6z/+E3Y9YJc6tJnBiRc0N/3CrDhZIGehGnhIOHOcaoWK3MzEu6DOr8c9u/IDNdISPhYoynmoxtYnpnlfQJb7N7m/aetCWrTsf7jXn1AQNZJVA+CxmDrEuXZ8+zQkWvViCpLOSHfLNqYYip7/UCLPQuNlUc9gECptNPJnP71t42QiilmyVqeLTyBp7IH2jzpiPnvjsEOd8rwtBVSAhrRDo7jZCtm0pB89pB+drPGTt4DOE5EdaJW1XvqbkpWAj3vq8FlMD/AAka13P27UrboW8AMeuDDCQN07we5+lGaDLqyW1m7ubhFM211YUHQajPPIZke00nuoboVIUsXxgT8EVkk5jgHFrvInN9rbifK4gO6Bn/GsbtvfSZ5yOcMyyHiVxwpbfJe/ep3X7SXo1tYJp0bwvBlDen5EfXKIzp87ijKrWNENfzbPM/aE/D77VC8QjOxDz1Jz4K1GJn4CFo6zT3jYYbcRR16HN2I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(42112799006)(1800799024)(23010399003)(7416014)(376014)(10067099003)(18002099003)(4143699003)(11063799006)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGdocFFHODdtd3RvTVZNUUJwZFBFenZZZEhuNDFJdEhHbDhpTHc4Z0xwbHRS?=
 =?utf-8?B?bEczOG8zRGhEbHdIRWFrc2FKcXZCYkJJNXRuTzJsODFJYzZPSmthMlRDVVVV?=
 =?utf-8?B?b3VKMGtkcVl3LzBoUlVLaEdPYnNqcHZ0MEVwY09zU2cxQlhLQkUyTUc1K0hh?=
 =?utf-8?B?OEtHNml1VGxaUy9rWWhqMWZBWER3d1JJSU9vcVpMTDRpZ2RHTUxzNy9Ba2VW?=
 =?utf-8?B?MVNMazArVEdOZzVscXM1UUZ6TGFqM1F3MVpVYjYzWElFbVdCMVkvYmxxTnll?=
 =?utf-8?B?YWNKWGZoR2hodzBzU0d4bmpzMm5wQWg1STJhaXpQc2NYU2RBOGlBQTR1MFJY?=
 =?utf-8?B?VE9KZEZuTzhWWW4zWXk4RTBQWGJqWTFHa2d0RWxXSFpxYzdGQ2I2blN1S1N3?=
 =?utf-8?B?N3cxRTd2cjk4MnlTRWo0bEVMTVlkWEl4WWVLblpPSzlRbFo4ak1BeFpoaUJQ?=
 =?utf-8?B?Q1I1SkFzUU1pdHJlUThMM0lreVdHR01yWVdsczQ3cnV4NHNsN0JlQWQ1VjQr?=
 =?utf-8?B?d2xkWDRvTzg5UmRmSXBSQURBSnoxeHQxQVlJdXAvWjJxVXZ5UE9vSHdIejlG?=
 =?utf-8?B?aXFyMHhvdk8zaFdqZXpHRkdaZWd0QTZ0dGFrYmZDdmxBdXZCajVYTDhvdm91?=
 =?utf-8?B?OVlQQlVaYjE4ODZXbmQvV3c4OW5JYitjcGc4djVnTXoyZUZoWWdhcVpYSnRy?=
 =?utf-8?B?SmdrT2YxNERRMmRDWlFrN0ZyQ0JuYjk1N3JUeHIwOWtJQkdEVGFRaGlHQlE3?=
 =?utf-8?B?R3FKTGJ0eEJhdXcvZWpkU0QwenU4RXFYVW5aUjdNa1JDY2MxbHZYeUxuS3l6?=
 =?utf-8?B?Vm16NGxXclRNVkUyOEdxSTdtN3Uwb205elpUSTJJWEhvTExMQTdGNUgycWxt?=
 =?utf-8?B?WXRQcWEzVDNlNXlGNU96MjZtclBJNS83L0czWExNZ2ZOY211RTdRVjQ3eTQ4?=
 =?utf-8?B?NEhBOFduU28xNktVd2c0OXM0RXNZeEtOdExpN1U4Y0ROcEg3R2xTTjF0ZEdh?=
 =?utf-8?B?RGIvUjFMTGI4Yy9oMlJ1cllMdlY0bTdLVmt3N04zOWNzd3E2bXZUakt1NDNr?=
 =?utf-8?B?ZW14aVc2N3lad1JnYzNLOCtDK09tNzc2SUovekE1ajdtTWQyem9HTFJ0dU1n?=
 =?utf-8?B?dkswZHJXUEpwRy9NZlc4ci9uQ1JHUkR1QXA4Mzhnc2F2RWpWQmpuK0dkL3pZ?=
 =?utf-8?B?SFhUdm1IY1hqSVlvekVlV3g5aHovTXRnTTZwbHB2aFYvTGdJd2NaVHNjdWk3?=
 =?utf-8?B?ZXl2bTZDMXZQclVFenBRV3RmeEtvZkZJT1B5cmRDVlhIalVWYU5pNHAwV1VC?=
 =?utf-8?B?cXNmTXVQTWxBSU1EbEx6NDQ3M0Y2YzdtWXB5UVVkR3l5VnZOSVlSVHc4ams5?=
 =?utf-8?B?S3FWUUhFNWx3QytpVWpJZjdLa0NHUmdObG4zQ2k3U1Z2akJRNXRWdzk1dzBY?=
 =?utf-8?B?Z0xiVFdTS3YvRFE5ekpWSHFGMDdFaC9VbkFnL0d0Y2tydUFuYlRLS3lxbGJE?=
 =?utf-8?B?UFJxSTZrN2pjUndVSkI0MjQ2ZUdVYUI3aTlnOExBcEZ3ZnUyZFp0WkFNM0hi?=
 =?utf-8?B?UHp3eWJWSVJKSWhyRTZZQ2Zmd3REbUZ2TU5IbktPTWMyb3lDMzdxYUd5anJm?=
 =?utf-8?B?UW4wcGE3N25BVlVPeTNMNzhESko3V0lJRUE3aFBqZ3RiNUxJczNRSkw2dUpW?=
 =?utf-8?B?U2JMSU9rUXRTVHQzdmlCWnBZTkJzdk80T3lsZU1VK0VFd0NZeUV0cEJIWTA0?=
 =?utf-8?B?VlltNDIzOCs0QXp0a1VRZVIxbUhualdlYjBPa0RzZ0NLQVF1a3pGcFNJVU12?=
 =?utf-8?B?aTc0bytiL3hDL0t1WXltb212SnNiS3FGaXVXYU5TeisrQmZ2bGZpSGlGczE5?=
 =?utf-8?B?V1psVVNmWDEreXp1ODBGUlJKTmpwZVAxM0V4MTZnRnoyMEJLWkFScnRQN0FT?=
 =?utf-8?B?WHJybW81dTlJNHRKK0M3Z3Z0bU5PYlVFQ2Jwb1B1b296RDJ3TVlSKzlTWGJy?=
 =?utf-8?B?SmpVVE9BWE5mMEEwSDZrSmtESVdkUzhjeDdONUZqcmRjL2h1YTJ0ZGJYcmhl?=
 =?utf-8?B?bHZsaVRZcG5ZQ1BmdVZMMXdBTGZHalpXc3NrbmZ0WENOL1lGSnFTY29pZVph?=
 =?utf-8?B?YjE3eElkdEhrcDMzcU9xdDlNeEQ2UUdrVDgvSDJCclU3ZnhVMHpvNDUwbkdt?=
 =?utf-8?B?RkNTNWlNNE5qYnhKWXRUNCtGVUtxQnlXM2JGRTBjNjBlVFR6SDQ5UmpIMktj?=
 =?utf-8?B?aVhGQWsxR05LamI1Wjd4RXZyNTV4ZU1QUjlBNWtVcWFFczk2TStOQU9HaVUx?=
 =?utf-8?B?K3dBeTA3dFEvTzFLZHBOYllyVGFiZjRoY3c1NnRwcithcWNYV2pPZz09?=
X-Exchange-RoutingPolicyChecked: FMfwd7EJBj3EvnNry8o9cK2dXW/aRFj1YO2bxVPfBkADDUuv0VLCtyAk41QJ8Tt6hamE5cjVhAVN6U42O3xO7YXHZfbYHz0MQEXYfZKiw3tN5QdGGetjZBiUQSBptKx1l+NN+JQcaFprgPm5yb5Pjv44SujoxYqjXUuBGaKwtSNkJ27TR3kLwAc1hFJHYn7HA9yYGkfcBDVeKzzFLZH2F9Sbfs/JdZw5V43bYF7plhQpPOBMlX8eUyQkAQi+ZIuZtP0NDUHuQqx6LdrFcaMn0vNc0slWZnhuhFYJlBvxU5PBoJQrel3kozUj4gI3gv22W91nCyOycdu65vF289r8xg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b8d636-14ed-48cc-2e29-08df08f1ea0b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 12:58:41.9847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onR8dHOCPVnv6frL0zsEklIsH1lNKQqC00q6XipqVeN4hFWy1vga4nEj7R16MbTyHKWYkZ3sgwfFK8YlnhoyAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8666
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 8/31/26 17:51, Zhenzhong Duan wrote:
> We should set flags IOMMU_HWPT_FAULT_ID_VALID when pass in a fault
> object id in the caller.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> ---
>   include/system/iommufd.h    | 4 ++--
>   backends/iommufd.c          | 7 ++++---
>   hw/arm/smmuv3-accel.c       | 6 +++---
>   hw/i386/intel_iommu_accel.c | 2 +-
>   hw/vfio/iommufd.c           | 2 +-
>   backends/trace-events       | 2 +-
>   6 files changed, 12 insertions(+), 11 deletions(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index 36b34b4899..79b8dabfb6 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -90,8 +90,8 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>   bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>                                   uint32_t pt_id, uint32_t flags,
>                                   uint32_t data_type, uint32_t data_len,
> -                                void *data_ptr, uint32_t *out_hwpt,
> -                                Error **errp);
> +                                void *data_ptr, uint32_t fault_id,
> +                                uint32_t *out_hwpt, Error **errp);
>   bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
>                                     uint32_t viommu_type, uint32_t hwpt_id,
>                                     void *data_ptr, uint32_t data_len,
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 2775eef741..f46b3bfa7e 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -315,8 +315,8 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>   bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>                                   uint32_t pt_id, uint32_t flags,
>                                   uint32_t data_type, uint32_t data_len,
> -                                void *data_ptr, uint32_t *out_hwpt,
> -                                Error **errp)
> +                                void *data_ptr, uint32_t fault_id,
> +                                uint32_t *out_hwpt, Error **errp)
>   {
>       int ret, fd = be->fd;
>       struct iommu_hwpt_alloc alloc_hwpt = {
> @@ -327,11 +327,12 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>           .data_type = data_type,
>           .data_len = data_len,
>           .data_uptr = (uintptr_t)data_ptr,
> +        .fault_id = fault_id,
>       };
>   
>       ret = ioctl(fd, IOMMU_HWPT_ALLOC, &alloc_hwpt);
>       trace_iommufd_backend_alloc_hwpt(fd, dev_id, pt_id, flags, data_type,
> -                                     data_len, (uintptr_t)data_ptr,
> +                                     data_len, (uintptr_t)data_ptr, fault_id,
>                                        alloc_hwpt.out_hwpt_id, ret);
>       if (ret) {
>           error_setg_errno(errp, errno, "Failed to allocate hwpt");
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 91aca1aa14..66e6a5011a 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -268,7 +268,7 @@ smmuv3_accel_dev_alloc_translate(SMMUv3AccelDevice *accel_dev, STE *ste,
>                                       accel->viommu->viommu_id, flags,
>                                       IOMMU_HWPT_DATA_ARM_SMMUV3,
>                                       sizeof(nested_data), &nested_data,
> -                                    &hwpt_id, errp)) {
> +                                    0, &hwpt_id, errp)) {
>               return NULL;
>       }
>   
> @@ -632,14 +632,14 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *hiodi,
>       if (!iommufd_backend_alloc_hwpt(hiodi->iommufd, hiodi->devid, viommu_id,
>                                       0, IOMMU_HWPT_DATA_ARM_SMMUV3,
>                                       sizeof(abort_data), &abort_data,
> -                                    &accel->abort_hwpt_id, errp)) {
> +                                    0, &accel->abort_hwpt_id, errp)) {
>           goto free_viommu;
>       }
>   
>       if (!iommufd_backend_alloc_hwpt(hiodi->iommufd, hiodi->devid, viommu_id,
>                                       0, IOMMU_HWPT_DATA_ARM_SMMUV3,
>                                       sizeof(bypass_data), &bypass_data,
> -                                    &accel->bypass_hwpt_id, errp)) {
> +                                    0, &accel->bypass_hwpt_id, errp)) {
>           goto free_abort_hwpt;
>       }
>   
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index c03435f8a2..d2f41f18f1 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -94,7 +94,7 @@ static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
>       return iommufd_backend_alloc_hwpt(hiodi->iommufd, hiodi->devid,
>                                         hiodi->hwpt_id, flags,
>                                         IOMMU_HWPT_DATA_VTD_S1, sizeof(vtd), &vtd,
> -                                      fs_hwpt_id, errp);
> +                                      0, fs_hwpt_id, errp);
>   }
>   
>   static void vtd_destroy_old_fs_hwpt(VTDAccelPASIDCacheEntry *vtd_pce)
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 242644aa00..74a5d77dcc 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -476,7 +476,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>       if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>                                       container->ioas_id, flags,
>                                       IOMMU_HWPT_DATA_NONE, 0, NULL,
> -                                    &hwpt_id, errp)) {
> +                                    0, &hwpt_id, errp)) {
>           return false;
>       }
>   
> diff --git a/backends/trace-events b/backends/trace-events
> index b1c1d89dd8..2f242feb78 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -16,7 +16,7 @@ iommufd_backend_map_file_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t
>   iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " Unmap nonexistent mapping: iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>   iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>   iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
> -iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
> +iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t fault_id, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" fault_id=%u out_hwpt=%u (%d)"
>   iommufd_backend_alloc_faultq(int iommufd, uint32_t fault_id, uint32_t fault_fd, int ret) " iommufd=%d fault_id=%u fault_fd=%u (%d)"
>   iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
>   iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"


