Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2015103E169
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 12:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2pk7-00037T-RU; Wed, 18 Mar 2026 08:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w2pk4-000374-1F
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 08:11:16 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w2pk1-0007uQ-ME
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 08:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773835874; x=1805371874;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ArlZn6P5omM9Xx85LnBA0qNFKMk4pWBoT0Z4hOLmdVo=;
 b=U72P8mf/z1KAIWrqHNA9/Dl5hWb58NItsfy8qpk5oHFzYYLqVJktGWSv
 vuAHlLp1q0x+ByoZW4C3K+JyGEeGZQsyn+Od7ldudst0gEdovXBycIwyx
 0kLxHLNtQqlgE4KAB4fmlWXgtaABkx80LWw5HI2wb0neXhI7vqYm+DkjE
 BZ9bIXCDABXF/1GTO4g8JDhCf8RZ0vz4AAmdZr6dXFbMWp1NePddkJMop
 PKgFBcVmYq70LQdrtcw6YilF5HdblfSrQsj6YlaMxte8JaigvBGYjW2Hn
 VB+V7p/URIpSGFGQcUbYxowmGCshn667iH1Mnk7Ht5G8BiNpRYe1enj1P g==;
X-CSE-ConnectionGUID: Xqw8hgYMSOaO3VECq9yILA==
X-CSE-MsgGUID: JvG8VwbTSViKioBDyaF2+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="92268741"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="92268741"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 05:11:12 -0700
X-CSE-ConnectionGUID: bz/lnAGrQzCIAQi4ehLIaA==
X-CSE-MsgGUID: mMfsx3zxTGm3zJbDNIctfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="219650491"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 05:11:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 05:11:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 05:11:10 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.10) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 05:11:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5IzX/cMj2/tHg5EeG7dOZU1jKJa5xcNkdNR6J4epeJE+qlmAZbQ1WzhPzavM4GV+NshI+iAfxms2IwDzYciFNQ3j1TWBMQcwe7d69x5pwuxaW0jI0F2ZvVJdQlxid9GSStbBRW4lFfNwShGPAwPilDh+CRvL9AOxiNcqGpuTGWWuXdeVGaZ91OwrZYdvuDbDtrvJ49G8fQo3d7LQzOfxTGsJBchiWYIdCbNM0mb+DV0nf02PcTA1DSNuL3rPojPB8/WMDOam+03dC0c2wCVq67FOo+ph/Af1z8con9eojj4AcMlES+uBUiU2Yci6/cI5EEZz7zTRdXTZCtyIbZGVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2cY9up+YkM7kiSvtg1RSffxBvgFh3oTw+YL1BxoUCA=;
 b=AobdI9AR16mhzXzfWx+98+Ab43h6qsq717vH1V0zSBWoaMefpEyX1YdT20oM6rlZIS+IFNQKjeleb8nyOPPr8RqtqyWZdzgjd5kHHDT+qJ8DhobiC3PkPTZQ16gepp3MEhH5TRPRx5YmT2orW0OOU9JvdJIp0ia/cnOJ2mpEAOk9nmj7o6HFw1JWwKhp1VyRux0jouOX8tpDMExErIYPBzMF1CGZsR0d7u3B/We8Npt+CBqJhuRpImvL223wi/bVwDFP6msmlG1SoQKnQ3DzEYqwauhWGqycH1lNYK722SkwXpHeqBVPerRfX0SMFhpsdDquwfEnSUhgnURSkvoJsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by PH0PR11MB5207.namprd11.prod.outlook.com (2603:10b6:510:32::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Wed, 18 Mar
 2026 12:11:08 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 12:11:08 +0000
Message-ID: <eb5d4a67-96fc-40bf-9f86-62fccc9263ba@intel.com>
Date: Wed, 18 Mar 2026 20:18:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/13] intel_iommu: Create the nested hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-5-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260306034409.184873-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0017.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::11) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|PH0PR11MB5207:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e9c60a4-9e17-439d-e7cb-08de84e76f8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|42112799006|376014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: XhJyyRtOiR5KSyqfpvEEH89k6aQcpc9P6h/BQMzvrSYtUjbkQmV32M+c/fLcG3P9AFqagB3GZtN1drXO6Qyff04mBCtPFkR0sngCsFLULGnNxNvlWW42cMD/aAGb9nT4gZsFr3WRFcuhSw2w68BhuJkDPbADyq2Ssdxa2kF3HwI0r3rcrYcgY7pF3A9ItGnuzJ0F5yxBAAOVjrADazyni9M9TkCYUzAVOoR2mmNKv7+D1tbTqWRd392PMBQVAnPhpVY5VnRWOY1RhZDYhnBgda85zpLkX5yz+bR6U1X/DdNoiF2EdGphBJ9f1g46opMAF8RUBho94XuV19xLiDGVTLy4QxXByhB1WKr/ObK30X8bsuLO/LI20Ya23J4f9sghbHAwYgcOowOw4Xs1fNXEdfDo7p2pVT6QmycdeGWHyS4681WaoXtBcXakCIPe1iWYy4xAIILlJiVWh9mLLUg5bk6ljFQsuDXrIswmNUYYWRE+MmNk5l+Z1BcKe4CXwMpTaDvWmm/XNz5QGxCVOGgTpbu6gQFfzMtB3O/eEbNaE3FoFZhP8qtu8a7XdEoy137vIFiLTHTIg/3kNXLkdhqaqECwb/PGFvKiW8EcNuG7Oa7cPMbpvBO6AOq4y0O/bO/1Eg9tLznpQ+hgVAHAeclwLsTOyuquxdaMY0oVNsxaLAhq6gPy8M1Dcry7A4qAHz3yaK0llDpWDaNIey5AQWbD7Atse41X5JcVBJNL9LSf4T0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(42112799006)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkV5NU9oajEycDRFMGRmbldNbC8vZnh5ZFAxRVQyaG9vNTQxVWhsYVIwOE96?=
 =?utf-8?B?bjNGY05iQXVLc2U5SXgrc0ZXZ2N6YzFySEpXUUFFTDJIUy9JMFlOZzhPMFZr?=
 =?utf-8?B?NlRINU1RYjFJMUM4aXFyaGJNSDk2dkZQdTY5Z1FXM0ZRL0tYVGZNL3JJdFda?=
 =?utf-8?B?dGdPc0J5UzNvOFF2SVpVYnQxSGhBVFU5YkY2Z1hMZDJnemxwc2JyWEtOQzQy?=
 =?utf-8?B?ZnBBTFJLdGRENFRkd2QvRkhuM28yTVU4WDdheno1c1NhZE1ldHplYmV3eGZr?=
 =?utf-8?B?NnFhbnV6eURWd0p6YjNCWVpkWnRwdVh4ckNxSnhQOWpJNG1YYlFUUVhvWFA4?=
 =?utf-8?B?MUJYSzAvTVVyeDFMV1dDTkRRU0VHOGhpVUZNbWhQNElXQ095aXJFNjd3MHZW?=
 =?utf-8?B?Q3BXRzE1QWRTVityUHo5TUVsYlVDSjJ6OWdicE5hZVkreWlmQWFlV0FLN2JD?=
 =?utf-8?B?UFZWRlorVzBmRjlUL3k5UWVzRXc2cyt3Y0tHbUUxQWNXNVYwM25iL0cxK0lK?=
 =?utf-8?B?L1FYWjgxR3B0NGk3dDgxbnhyRzh5SFdqbi8xYUJvMmRTeHd0T0NkOHRXRjU2?=
 =?utf-8?B?Ym1xb1lhYXpUWUh5Mm9uQk8ra1BlTWIxZ1R3UE9zWTE2cU8ydEU2OUFYZXFZ?=
 =?utf-8?B?dkdieWRISi9nWGhNeXVFaTFzbkZLQi9qWXFWZGFkaEgrMmJsWU1RTXM4Tkxj?=
 =?utf-8?B?WnpTL1VXUnEzVlYwV2llbHpSb1lFWEhUdzNLV0N2RUhFck1ySmdNWlprZEFX?=
 =?utf-8?B?dGdBazh3Qk9QTFdaL3Fua3h6WXk3YXNsc08zeHN6SkQ4aXBQRnFYQWFsUXV0?=
 =?utf-8?B?UGsvN0ZhUjk5bE1aMFdiWmUycThzQjJpaXYzREdOTUdGVEhJVEtCc25odWV6?=
 =?utf-8?B?TzV0TzZXcHJ1dm42cWkxdERGMkpjWXdrSVRJSGdhQVpucGhlMGRiaDFhTGgr?=
 =?utf-8?B?bDBjVkRYeGVlRGxiY1RMYnd5T1M2U3NnbWMxalhYN0FsRllaQkRsSmo5VE9i?=
 =?utf-8?B?b1ZMM09UcEZJQTdXS0IrdGtBcVU2b1BnTFVaTkZNaTdTRlpZcFpyQmFTaXBN?=
 =?utf-8?B?V0lESW1ic291dFY5bWtCNWtURGFnMXhQZ0pyaE4vekgwU0JGRlY0ODh4VXNm?=
 =?utf-8?B?akxEb3FUQnU4U3RPQXRFc2Zqa0VLTUhITUhSeXJRUFRQSm1iV2s5ZmtUTWRZ?=
 =?utf-8?B?Z1N4YlNCRTN1dWVRQTU0UTVZMjY0RnExNUNnbE1xTUgwN21HY1VPN3NkWnYz?=
 =?utf-8?B?ZFhhRWRLRkYxQ2M4eDY2T3ArOVh6ZWlZRmQ0bVlUb2pnOFgxSlR1bDlVNUpx?=
 =?utf-8?B?d3JrZ3JiYWR0T3pwUDZyQXUxVTExVVA2VXdybTUzZDhSbGw0RWVTZzBWN3hO?=
 =?utf-8?B?ellLQVRiNm8rcjNBUnFxNVJ5RlA4LzdUU0kvb2o2ZTN6Ky9uWVUybExRaVBm?=
 =?utf-8?B?d21DZ2Nra2lJbXg1K3lON1JFQ1FBUnJuNGFKUFBzZ1VNdlN0RUJobmtYZktU?=
 =?utf-8?B?QVBMNiswTjJ0cTA3eWhKbWwrM29uSnZQdGRjems4SEhoMVJMaGovcFJUUXpu?=
 =?utf-8?B?UGRkS3BmMUVhR1RFWnZLTWVxTFBQSU96K3U2dmhoMndERktPNzFqeVJ5NXpP?=
 =?utf-8?B?QjEybmhsaHRrbzM1ZS9LdHlEeWIzZ2VOekQ3VjJ4ZjdBRUJrNENnRHJzSldM?=
 =?utf-8?B?cVMwWVQvYUp1TkNaUnpELzB1LzdlYlU4ZkJqc0tWNVpOMXBvdTVOL0pSeUln?=
 =?utf-8?B?Z0E4dGg0dmo1bHpNcWEva2RLUEtWUUF2eFVhbUszdEhnK2tWVnQzRjdVRjl0?=
 =?utf-8?B?M1E1SFdscXBnSUhsQURQTzFIeEdrYXM2NHNuUEU0aVg1bGtUQkl5aFlFWlV6?=
 =?utf-8?B?VWNkSEthSUMwb3dEaWxaRmtuVnhKNUlPRGpXRTdlb3NVUmY2amRJZmRidkVI?=
 =?utf-8?B?bmZkb29mWE04ZlVRRVA0a282RUpZOHFvMmdVUnZRekd4c1VFZGhtMlpNL2FN?=
 =?utf-8?B?UFlSeGI4VW9md0Q1eVVTSGViWXlLQ0t0bUdjWEFOWlp6dDRnemsxc3BkbkhO?=
 =?utf-8?B?cXB0bForWGo3S0JIY2l3U1A5S2d2dVpMdUZCQTNTeVdFREJOdjZNc1QxeXRr?=
 =?utf-8?B?SWQ4b3lCVUtGL0JKNjllVGdmaklGRmFJZGI5R3NJV1FmbmVoUUFoZkJJR1pJ?=
 =?utf-8?B?SVdBdDFwZnIyR1ZSWVM4Tm13U3Y4UFhvTlNjL3V6RmVtY09ha0NEd3pKY0NM?=
 =?utf-8?B?Tjh2bXNXUFNzT3dJZHFQaXJlNnMwK3pLUCtyWWt6TnhqYXJqQ3lyMUNVSnVk?=
 =?utf-8?B?L2tDdjdvMzVLdWk2ZC84NFI0cHhDOWxOcU5XMUFhQWpsV0V4a1l3QT09?=
X-Exchange-RoutingPolicyChecked: fNJaNSC7un9tWbhrCY3p8bbHsWka6knxyuvcOzf5mA8L93huxpsv1bZSOWZGw3HhbDvE4yrCLDxHbXqdMvf3RZejpgJPo26k7maTMS4SmscFpKbHXWnz0Aijgw+hUSpvF1KyoAuxXBMDVAF5r3YC6ICxNbRDGDFvse7eMwkXSLjBKMvxvVW3oCJ5EU+qtNAziIahkvfeAOAxbbjIDnRXvi9SYG314gUPS81mxgcy+bRD0JazmtN0qnoBpWrlrWWPaJyN0ZqVcCrcWuzM6TeClEPPiahxiBmQq+vdWALiGLRVzyKclqCOBRJe+JImvcQDwvV71pntfs/OWBD7z8TQ9A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9c60a4-9e17-439d-e7cb-08de84e76f8a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 12:11:08.0959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgZx+GxyBM+afVOSBsBHluRUnGvAXkfh0dLlR/PbbjozHDXM2BcCP4jok/wEcMMR7E+Sf92TSla8sOQbvbg5/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5207
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10; envelope-from=yi.l.liu@intel.com;
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
> When pasid is enabled, any hwpt attached to non-PASID or PASID should be
> IOMMU_HWPT_ALLOC_PASID flagged, or else attachment fails.
> 
> Change vtd_destroy_old_fs_hwpt() to pass in 'VTDHostIOMMUDevice *' for
> naming consistency.

> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_accel.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index 45c08c8f6f..c2757f3bcd 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -69,11 +69,13 @@ VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
>       return NULL;
>   }
>   
> -static bool vtd_create_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
>                                  VTDPASIDEntry *pe, uint32_t *fs_hwpt_id,
>                                  Error **errp)
>   {
> +    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
>       struct iommu_hwpt_vtd_s1 vtd = {};
> +    uint32_t flags = vtd_hiod->iommu_state->pasid ? IOMMU_HWPT_ALLOC_PASID : 0;
>   
>       vtd.flags = (VTD_SM_PASID_ENTRY_SRE(pe) ? IOMMU_VTD_S1_SRE : 0) |
>                   (VTD_SM_PASID_ENTRY_WPE(pe) ? IOMMU_VTD_S1_WPE : 0) |
> @@ -82,13 +84,15 @@ static bool vtd_create_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
>       vtd.pgtbl_addr = (uint64_t)vtd_pe_get_fspt_base(pe);
>   
>       return iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid, idev->hwpt_id,
> -                                      0, IOMMU_HWPT_DATA_VTD_S1, sizeof(vtd),
> -                                      &vtd, fs_hwpt_id, errp);
> +                                      flags, IOMMU_HWPT_DATA_VTD_S1,
> +                                      sizeof(vtd), &vtd, fs_hwpt_id, errp);
>   }
>   
> -static void vtd_destroy_old_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +static void vtd_destroy_old_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
>                                       VTDAddressSpace *vtd_as)
>   {
> +    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +
>       if (!vtd_as->fs_hwpt_id) {
>           return;
>       }
> @@ -116,7 +120,7 @@ static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
>       }
>   
>       if (vtd_pe_pgtt_is_fst(pe)) {
> -        if (!vtd_create_fs_hwpt(idev, pe, &hwpt_id, errp)) {
> +        if (!vtd_create_fs_hwpt(vtd_hiod, pe, &hwpt_id, errp)) {
>               return false;
>           }
>       }
> @@ -126,7 +130,7 @@ static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
>       trace_vtd_device_attach_hwpt(idev->devid, vtd_as->pasid, hwpt_id, ret);
>       if (ret) {
>           /* Destroy old fs_hwpt if it's a replacement */
> -        vtd_destroy_old_fs_hwpt(idev, vtd_as);
> +        vtd_destroy_old_fs_hwpt(vtd_hiod, vtd_as);
>           if (vtd_pe_pgtt_is_fst(pe)) {
>               vtd_as->fs_hwpt_id = hwpt_id;
>           }
> @@ -161,7 +165,7 @@ static bool vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
>       }
>   
>       if (ret) {
> -        vtd_destroy_old_fs_hwpt(idev, vtd_as);
> +        vtd_destroy_old_fs_hwpt(vtd_hiod, vtd_as);
>       }
>   
>       return ret;


