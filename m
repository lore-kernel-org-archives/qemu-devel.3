Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD1AEBFD00
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 06:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCAik-00054W-Q4; Mon, 13 Apr 2026 02:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wCAii-00054F-1d
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 02:24:29 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wCAie-0005xE-5C
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 02:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776061464; x=1807597464;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=H8JxSwCtLSc6CNrLiaerkUOP/tbFFIF5A9Qtxk4DvPo=;
 b=fnrAWoszZ18Io0KUAIz5MzvmMas+AOpPMEZdnE1VSFUZWk0sMl7Skk/G
 jdsI8/2mn9eLxOlHtGUwmF1DljFmHgveWc7RXowPt8hxWmbjc7K7gKZeQ
 KU7LAxx+7gP174pLkGm2oXzNLEu8Fw8s+mSFNh466c19pe/P8rqd+NsfF
 nCpEqLYJUla8SLjHN8qduMhLVXFHtQOe5PQHx2o/LZJT90RxuIAJr0tv1
 TCpxT+peX71j7bRY3Ovwf4c5mcPgpEX4g8WLXxiM8Lvun4lAbjOBm3QPN
 1wqrWJEQg9vrmQTPTWyISXNiGbD3XfN1bcYGjNHgiOXZDRztHWhXgO8yI w==;
X-CSE-ConnectionGUID: i8Khe4y/QwKbhFBR5SkYjg==
X-CSE-MsgGUID: KW/PNHg1SY+1wkeqcMfCkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="87615781"
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; d="scan'208";a="87615781"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2026 23:24:17 -0700
X-CSE-ConnectionGUID: Rjfeg9FVTFKTSimdukg8mg==
X-CSE-MsgGUID: Z6LYPA9GRm24vCmyB2U5Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; d="scan'208";a="252881869"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2026 23:24:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 12 Apr 2026 23:24:16 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 12 Apr 2026 23:24:16 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.63) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 12 Apr 2026 23:24:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IohquuEtkFib/eM0nug1tO8i56Dx7bcS1OFN4Le1oR2ZGX5hDR9DbIwfqIoAV2Z0uo/WYV7qzupgXky6zxCit5xwxkp/7wtoEj/HPvbznGRkRyJHgWMpvYixoE/bgFN75+YZ+2h9YJPTmPb/MOPa4OqEFWhuclmrgSmfMiaaCUfte8QG0+xNTI16mg8nM0s16x31AdZRCzlmdhn04QkPI7THtseFabUePET5l1MxSGgBXY21At4Fnp+1WbDExlV6fT1f2tR+Hc3KSoFc34tFH6ZXlUj9NvUcTbn0yM6RL3KzLuSRSOwijiDcUQ3qXir69eIeqHixKBTegINEs8/QyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8JxSwCtLSc6CNrLiaerkUOP/tbFFIF5A9Qtxk4DvPo=;
 b=Bd3SsYcqQApGq+Y/+5CtIIruMxe4cF+8hb962GDD7YfJotP+cCP7Yh2W4r/mVnXabqzgZLPCpOptuBjY7hkCk21vj0c2EbzHkrzNRLpE33B8AeJVacWLzVkDG7aIgnQpg/Bv6tk1fxRyzTPtsPkcuRM6fyfHrRBbQNwDBNbxunzuDR0kX+0i/uRh0jx3NAOBE7zN1KQ3ljWzICV3hv6na0Y3QP8XFT2CqdfdL4zdJEUria0jsbqlPYwByzcyVsnZ84WBBrQIBOw0D9VFVTxownDRDmiRNe9eX7ZQV76sgRaY32pBe4p1f3w5jM9w0VGfeYm+s3pUH4sHNOZJsmAbPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH3PPF25FF87461.namprd11.prod.outlook.com (2603:10b6:518:1::d10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.14; Mon, 13 Apr
 2026 06:24:06 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9769.011; Mon, 13 Apr 2026
 06:24:06 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: RE: [PATCH v3 07/14] intel_iommu: Use IOMMU_NO_PASID and delete
 PASID_0
Thread-Topic: [PATCH v3 07/14] intel_iommu: Use IOMMU_NO_PASID and delete
 PASID_0
Thread-Index: AQHcwx3XpF37AMW/tUWEni2aXnED6bXciNyAgAAMJsA=
Date: Mon, 13 Apr 2026 06:24:06 +0000
Message-ID: <IA3PR11MB913682E6FB02317659E980C192242@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260403035541.18355-1-zhenzhong.duan@intel.com>
 <20260403035541.18355-8-zhenzhong.duan@intel.com>
 <ed6326ee98963e263a9bb90d7351c85c4b34562c.camel@bull.com>
In-Reply-To: <ed6326ee98963e263a9bb90d7351c85c4b34562c.camel@bull.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH3PPF25FF87461:EE_
x-ms-office365-filtering-correlation-id: 623d1e95-5d48-487a-bc97-08de99254411
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 9EetzPCby7Wha58RngYnZtwjzTWNOE7fHC9bmx7sctaKV8ObK8+WqSmW1S7HFUToqGNLL8AsxyB8x6BxRuB/aysz/oX1W7gexBFKaCG8EGkVMPVzYDMi2Ffrprlqp0/NnxqMdaCqwyszHVvoxAew4F6Jze5qbno/RIFmN3AbAkXVWD1i/gleznExIbCjk69cLpMGdNg5UGrS1kBHMbeppSGC2ih4++bYQj0jGDAqIgzgvuHRBiw8IufdigrFnhCRSyAYym6HU/d09vIdH8sIML3vZTmooNLA0k0vYrwQkyoFoL+MDwDmr0s4R0ESGz2Ud/7trJzQ/UoCiHDctccMAjopKTIKe9zPTZLzPa3xg1e9J8vf+8jDkWFHgWiyaXN11VzFpYVMb3LcBtG8V00yNybxBtR+FIsvtzGZwnM43PNDjBgkeU7P23Pj7L7y5y15NNbirOcisNzD5UMmYH2UHwx57G6cnS0YV9Dc3fhIiix9lL588qCH8leKu+bhpyhnYkWHSu4e49S9ZOMU1qR/0LbzKeqCVgZDB3g+bFORqgkJiyFJsQAicMG5OtVjml8r+mOiBaG7jpgQl4VVZdeSQ35i3Uihqsf8LWVpOTr7OVE66YuD+Obm2SWzKC80ovLm8iihI8q46jbfcr2K4UCluZ3B9vb1EZ8JpiM71PdVH/QPtZLaXTjevWE1vMFUBE+PYyRpDAffr5PeJB1bVN3YPWGn88KOMJfj8u/0e50lOmZhIm0TM+pRyNvT2a6LO1jfEux3y5i0O5voUy1GxHG6mRRUD4ORpvhfwjjt5N/1/9g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGQ4SzNGMlhqUFpqa21OUit4NC9wZFVhMmI2Ujc3U2ZLbXhIZGRKbk9EMFRK?=
 =?utf-8?B?dXRSUDhHdlVZR24rdmZFU2dkNmpMcGxveGdXNWdCNUdUWnoxMFRpNzdSZExZ?=
 =?utf-8?B?bnVia2QxRXRUMWdOQXVNQjM2dlkrVTdMamVVak12dnpXOWhacG5KMnF3WEhC?=
 =?utf-8?B?RVhOdVI5em9tWlBpVGdXTHFJTjgveGdPdERYb3dXWGI0TjMrUURQVG4rM2dG?=
 =?utf-8?B?NlU4RXpWd3ZVTk9vRURFc3pSd0dVTFZBNWUwNDVIeGs3NGdsOE41di9HQjQv?=
 =?utf-8?B?cjNSWkR2bkNXTzhyWXJySnk0aGZqN3MrY3Q5eExKRHJjcHNLaFExdzkxR3hP?=
 =?utf-8?B?OUxyT1BsV3RJdHpiQkIwQkRHMnltVmNFMTJNb29ya2JiVWx0N05aVmJpUWNO?=
 =?utf-8?B?OWJWZ1VnMTFkUkZsenRxSGYvVTl1YVg2Sjc0RFYzL3FhUFcvaUc0RUQ4L1VO?=
 =?utf-8?B?ZFR6aVY3elJqUFVWelBnbGoxamhMdDNlYVI1TzZBTUlDSWtyUFZIUi8xVGdV?=
 =?utf-8?B?ZWFONGtiVmdjVzJJajhvYTJwQk9EVlpraDVlTE93NjlhZXorNmVuVkp1dllq?=
 =?utf-8?B?K2NzdnIxWTlSOXFUTkpKZlNOcHNYVlo5WkpJT2pCb29aWVFjREFCcXBNMVpK?=
 =?utf-8?B?K1dNckRCUStlTTc1R1RjSCtJeEFsVEVleHJaWnRXTE0vRXF2aWhrZGFmUHZn?=
 =?utf-8?B?Q0k5WWN1UGZnUElmYzhGajRRclVURzRMMlN3N2JIVlJjd3dDRkNVQUlXYWx5?=
 =?utf-8?B?M2QwOVdzdUViZll6ZHlBRmtSRytlNDRFeTFkbUlFR1JpdzI0QmxzOUh4amJL?=
 =?utf-8?B?WmlRV1NxTGZBeW11UThacWQ5OWN0RFByOHFBanNDdjRMVUF2OWU1UkIwUnJr?=
 =?utf-8?B?cjRObUJxTEN0Sk50elNHUlp6czZ3ajBzKzlKM1N3SHJRSlF5c0NDWkRxQ1Fz?=
 =?utf-8?B?Nm5ZQUZGbW9VNFBWZWhpNmg0SG1CTFN3UXdOY2I4NThyMXc1TmdzWWNsTUxL?=
 =?utf-8?B?STZsdC9Nb21TcGZmeVBLWlYwRGJpNDJLV1VMNGJsT3RFL1VwOXF4dlBVT3RP?=
 =?utf-8?B?WFdWd0VhV3VHcUkySmVmc3RaNGFqaEtmVFJQcVI4aUphaTFQTm92QWQ0bUxU?=
 =?utf-8?B?c2ViM1RFQVNTYnFCUURWMStSUlRjQTg3S3IyMnRFQzYvakJ4ekN0aWhsYy8v?=
 =?utf-8?B?MXlEUitZa2ZlZGZjZVczVWU3WWs0UHFqUEhGZGZNcUFBdHZKOUROdDdqTWZ3?=
 =?utf-8?B?Qzd1WnAySXEzQW1Hc1lvRlJpMUlISFA5bTN1MzhOUzN1Q0U1K29QL1Z6Umt5?=
 =?utf-8?B?Y2J0UzF6aXhqUTlhWEhZQUxiNEpZelRVQzhkNldWSHN3ZDNMQ3VuaEZCNWVu?=
 =?utf-8?B?UU5pbHZ0cENoWWRibGI0RmZIL3RibjJBZXFFb0EyOTQyK3FDaUlFbmRadkMr?=
 =?utf-8?B?VmJZWXI0SXFJOE1ZMjE3N2F6dlFWZ1N6RUlLNjhNQUZsOTVaVkR1RDBJdGE3?=
 =?utf-8?B?T3NsSVdoSitxV1NiQnhyTk5LbTRXSXFjMlVCanVOcWkwZkZ6N2NjYnFqaVVa?=
 =?utf-8?B?MU5xcUVscWNsYndscWNsMFRCOWQ0WFJLTm1SaENBbDhnTHduQ0w4ZmsrMFc3?=
 =?utf-8?B?RzcwMTRkNFU0VVZMdzFLOFovV3lxN21kWThSRFBMdW1TT3pvWGtGZlVQckFW?=
 =?utf-8?B?aXQ0aHphYVdVNmtJVmFSWVExbzRJVWJLbHZRamJvYkxQbGVPejdOSGE3OFIz?=
 =?utf-8?B?amxiWG9ibGVIa1RXWTFhbC9BQVBTTzBPVGpsaXNHMyttWTJoNGJFcDhUVXVz?=
 =?utf-8?B?ZFJUMitqU1Zwd3R3TUs5T1dJTzVGTFdlMkpRRDh3Z0ZZVkdVeVdjTDBHMk81?=
 =?utf-8?B?RW9wRTlGeU9sa1R1M2h5TFB2d0JneFR4UlpKUk5nTzlCRFNRNlNkNFExeWgw?=
 =?utf-8?B?bHgzQ1hydXMxNFdNTlJRVWFPUEs2K1JTSFVtUWxKbEpRRFpYUVR1RU9GZkFt?=
 =?utf-8?B?NjkrSWNYYysva0FxNDY2SjA1NmNjRjZFR1ltTUJuUnE1NE9DYndjOTRUTlBM?=
 =?utf-8?B?UDMxSEJqd29GeU03OXc2UkdvbGpNTW5GcURMQUgvcHRKdjFhQjlncUFCWjlo?=
 =?utf-8?B?eWUySTZhMUl5VmVCb1BkN3BXQ1pqd2t6blpDNS95RnN3R21LaFVWNlZ2NFJB?=
 =?utf-8?B?cS85TUxmMnJmaUdsMDQ5R3dSMWZDVUoyZFFld0kxTUNaa2NNcml0R1Y2L1Nn?=
 =?utf-8?B?MGxNK2NVaWZOSWlIMS9xSHB3cTNVRlk1ZWhLK2liRDFZVkNuRmtITklZOStM?=
 =?utf-8?B?TFNKU0d5aUNYaHpGRitWWGdmbExXOFpYYlgrenk4ZVVuSk11RU1mUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QMtoyqgg5DS8XMuaKCj+ex0uE6OdccN2ylbE2b0vrMHfLtZ1IeOR3jNxHqlATE1ABEMeM0mkY9mK2fn6okfBNu8ZW2AGGmAmzPf0UGxJETX2zRnqrFoDGmxhNdE4MNvqECC3RpP+8heOOA/KeaL5StYhudPLzx/zjjoOjYjrJ7/maIXT+QpUh+8+pGCNtqzxvqWktn18l0DVax+ocsuwdAP/2T0VNjWmxJs3sNfSV7DjD2eaFEPkxwz8ANoiCpD6tRs5E5YKn3h7VYvcr3wM1lwuqDO6Pw0o1PHz/IyW2uah3JjfjR687UvwQbawNpCgrPcqJhSUN+4WQZpgi4nQ/Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 623d1e95-5d48-487a-bc97-08de99254411
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 06:24:06.7457 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5efZpovFaAcsWLRenwRxFNEkhaOuQJvcxM304kUTpBk7nMAvmYZMEiKtKvE7XqAudjzyDIAe67l8LpTL4ZnfRL/a9p8xn/vMgsB3yF1+CiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF25FF87461
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

SGkgQ2xlbWVudCwNCg0KSW4ga2VybmVsIHdlIGRlZmluZWQgaXQgYXM6DQoNCiNkZWZpbmUgSU9N
TVVfTk9fUEFTSUQgICgwVSkgLyogUmVzZXJ2ZWQgZm9yIERNQSB3L28gUEFTSUQgKi8NCg0KSW4g
aW50ZWxfcGFzaWRfZ2V0X2VudHJ5KCksIElPTU1VX05PX1BBU0lEIGlzIHVzZWQgdG8gaW5kZXgg
dGhlIHBhc2lkIHRhYmxlIGRpcmVjdGx5Lg0KDQpJbiBxZW11LCBQQVNJRF8wIGlzIHVzZWQgZm9y
IERNQSB3L28gUEFTSUQsIHNvIHdlIHRoaW5rIGl0J3MgZHVwbGljYXRlZCB3aXRoIElPTU1VX05P
X1BBU0lELg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj5Gcm9tOiBDbMOpbWVudCBNQVRISUVVLS1EUklGIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZA
YnVsbC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MyAwNy8xNF0gaW50ZWxfaW9tbXU6IFVz
ZSBJT01NVV9OT19QQVNJRCBhbmQgZGVsZXRlDQo+UEFTSURfMA0KPg0KPkhpIFpoZW56aG9uZywN
Cj4NCj5Db3VsZCB5b3UganVzdCBjbGFyaWZ5IGhvdyB0aGlzIGludGVycmFjdHMgd2l0aCBQQ0lf
Tk9fUEFTSUQ/DQo+DQo+Tm8gc3VyZSBJIHVuZGVyc3RhbmQgcHJvcGVybHkgOi8NCj4NCj5PbiBU
aHUsIDIwMjYtMDQtMDIgYXQgMjM6NTUgLTA0MDAsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4g
SW4gcHJldmlvdXMgcGF0Y2ggd2UgaW50cm9kdWNlZCBhIGdsb2JhbCBtYWNybyBJT01NVV9OT19Q
QVNJRCgwKSBmb3INCj4+IFJlcXVlc3RzLXdpdGhvdXQtUEFTSUQsIHRoaXMgbWFrZXMgdGhlIGxv
Y2FsIG1hY3JvIFBBU0lEXzAgcmVkdW5kYW50Lg0KPj4gRGVsZXRlIGl0IGFuZCB1c2UgSU9NTVVf
Tk9fUEFTSUQgaW5zdGVhZC4NCj4+DQo+PiBTdWdnZXN0ZWQtYnk6IFlpIExpdSA8W3lpLmwubGl1
QGludGVsLmNvbV0obWFpbHRvOnlpLmwubGl1QGludGVsLmNvbSk+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBaaGVuemhvbmcgRHVhbg0KPjxbemhlbnpob25nLmR1YW5AaW50ZWwuY29tXShtYWlsdG86emhl
bnpob25nLmR1YW5AaW50ZWwuY29tKT4NCj4+IFRlc3RlZC1ieTogWHVkb25nIEhhbw0KPjxbeHVk
b25nLmhhb0BpbnRlbC5jb21dKG1haWx0bzp4dWRvbmcuaGFvQGludGVsLmNvbSk+DQo+PiAtLS0N
Cj4+IMKgaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHzCoCAxIC0NCj4+IMKgaHcvaTM4
Ni9pbnRlbF9pb21tdS5jwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTggKysrKysrKysrLS0tLS0tLS0t
DQo+PiDCoGh3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuY8KgwqDCoCB8wqAgMiArLQ0KPj4gwqAz
IGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggYi9ody9pMzg2L2lu
dGVsX2lvbW11X2ludGVybmFsLmgNCj4+IGluZGV4IGM3ZTEwN2ZlODcuLjAxNDEzMTZmODMgMTAw
NjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+ICsrKyBiL2h3
L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gQEAgLTYxNSw3ICs2MTUsNiBAQCB0eXBl
ZGVmIHN0cnVjdCBWVERSb290RW50cnkgVlREUm9vdEVudHJ5Ow0KPj4gwqAjZGVmaW5lIFZURF9D
VFhfRU5UUllfTEVHQUNZX1NJWkXCoMKgwqDCoCAxNg0KPj4gwqAjZGVmaW5lIFZURF9DVFhfRU5U
UllfU0NBTEFCTEVfU0laRcKgwqAgMzINCj4+DQo+PiAtI2RlZmluZSBQQVNJRF8wwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMA0KPj4gwqAj
ZGVmaW5lIFZURF9TTV9DT05URVhUX0VOVFJZX1JTVkRfVkFMMChhdynCoCAoMHgxZTBVTEwgfA0K
Pn5WVERfSEFXX01BU0soYXcpKQ0KPj4gwqAjZGVmaW5lIFZURF9TTV9DT05URVhUX0VOVFJZX1JT
VkRfVkFMMcKgwqDCoMKgwqAgMHhmZmZmZmZmZmZmZTAwMDAwVUxMDQo+PiDCoCNkZWZpbmUgVlRE
X1NNX0NPTlRFWFRfRU5UUllfUFJFwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweDEwVUxMDQo+PiBk
aWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5j
DQo+PiBpbmRleCBhYTY3Yzg5ZTczLi4zYjhkM2E5NmQyIDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4
Ni9pbnRlbF9pb21tdS5jDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IEBAIC05
NDEsNyArOTQxLDcgQEAgaW50IHZ0ZF9jZV9nZXRfcGFzaWRfZW50cnkoSW50ZWxJT01NVVN0YXRl
ICpzLA0KPlZURENvbnRleHRFbnRyeSAqY2UsDQo+PiDCoMKgwqDCoCBkbWFfYWRkcl90IHBhc2lk
X2Rpcl9iYXNlOw0KPj4NCj4+IMKgwqDCoMKgIGlmIChwYXNpZCA9PSBQQ0lfTk9fUEFTSUQpIHsN
Cj4+IC3CoMKgwqDCoMKgwqDCoCBwYXNpZCA9IFBBU0lEXzA7DQo+PiArwqDCoMKgwqDCoMKgwqAg
cGFzaWQgPSBJT01NVV9OT19QQVNJRDsNCj4+IMKgwqDCoMKgIH0NCj4+IMKgwqDCoMKgIHBhc2lk
X2Rpcl9iYXNlID0gVlREX0NFX0dFVF9QQVNJRF9ESVJfVEFCTEUoY2UpOw0KPj4gwqDCoMKgwqAg
cmV0dXJuIHZ0ZF9nZXRfcGVfZnJvbV9wYXNpZF90YWJsZShzLCBwYXNpZF9kaXJfYmFzZSwgcGFz
aWQsIHBlKTsNCj4+IEBAIC05NTgsNyArOTU4LDcgQEAgc3RhdGljIGludCB2dGRfY2VfZ2V0X3Bh
c2lkX2ZwZChJbnRlbElPTU1VU3RhdGUgKnMsDQo+PiDCoMKgwqDCoCBWVERQQVNJREVudHJ5IHBl
Ow0KPj4NCj4+IMKgwqDCoMKgIGlmIChwYXNpZCA9PSBQQ0lfTk9fUEFTSUQpIHsNCj4+IC3CoMKg
wqDCoMKgwqDCoCBwYXNpZCA9IFBBU0lEXzA7DQo+PiArwqDCoMKgwqDCoMKgwqAgcGFzaWQgPSBJ
T01NVV9OT19QQVNJRDsNCj4+IMKgwqDCoMKgIH0NCj4+IMKgwqDCoMKgIHBhc2lkX2Rpcl9iYXNl
ID0gVlREX0NFX0dFVF9QQVNJRF9ESVJfVEFCTEUoY2UpOw0KPj4NCj4+IEBAIC0xNTAxLDkgKzE1
MDEsOSBAQCBzdGF0aWMgaW50IHZ0ZF9jZV9wYXNpZF8wX2NoZWNrKEludGVsSU9NTVVTdGF0ZSAq
cywNCj5WVERDb250ZXh0RW50cnkgKmNlKQ0KPj4NCj4+IMKgwqDCoMKgIC8qDQo+PiDCoMKgwqDC
oMKgICogTWFrZSBzdXJlIGluIFNjYWxhYmxlIE1vZGUsIGEgcHJlc2VudCBjb250ZXh0IGVudHJ5
DQo+PiAtwqDCoMKgwqAgKiBoYXMgdmFsaWQgcGFzaWQgZW50cnkgc2V0dGluZyBhdCBQQVNJRF8w
Lg0KPj4gK8KgwqDCoMKgICogaGFzIHZhbGlkIHBhc2lkIGVudHJ5IHNldHRpbmcgYXQgSU9NTVVf
Tk9fUEFTSUQuDQo+PiDCoMKgwqDCoMKgICovDQo+PiAtwqDCoMKgIHJldHVybiB2dGRfY2VfZ2V0
X3Bhc2lkX2VudHJ5KHMsIGNlLCAmcGUsIFBBU0lEXzApOw0KPj4gK8KgwqDCoCByZXR1cm4gdnRk
X2NlX2dldF9wYXNpZF9lbnRyeShzLCBjZSwgJnBlLCBJT01NVV9OT19QQVNJRCk7DQo+PiDCoH0N
Cj4+DQo+PiDCoC8qIE1hcCBhIGRldmljZSB0byBpdHMgY29ycmVzcG9uZGluZyBkb21haW4gKGNv
bnRleHQtZW50cnkpICovDQo+PiBAQCAtMTU2NCw3ICsxNTY0LDcgQEAgaW50IHZ0ZF9kZXZfdG9f
Y29udGV4dF9lbnRyeShJbnRlbElPTU1VU3RhdGUgKnMsDQo+dWludDhfdCBidXNfbnVtLA0KPj4g
wqDCoMKgwqDCoMKgwqDCoCB9DQo+PiDCoMKgwqDCoCB9IGVsc2Ugew0KPj4gwqDCoMKgwqDCoMKg
wqDCoCAvKg0KPj4gLcKgwqDCoMKgwqDCoMKgwqAgKiBDaGVjayBpZiB0aGUgcHJvZ3JhbW1pbmcg
b2YgcGFzaWQgc2V0dGluZyBvZiBQQVNJRF8wDQo+PiArwqDCoMKgwqDCoMKgwqDCoCAqIENoZWNr
IGlmIHRoZSBwcm9ncmFtbWluZyBvZiBwYXNpZCBzZXR0aW5nIG9mIElPTU1VX05PX1BBU0lEDQo+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgKiBpcyB2YWxpZCwgYW5kIHRodXMgYXZvaWRzIHRvIGNoZWNr
IHBhc2lkIGVudHJ5IGZldGNoaW5nDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgKiByZXN1bHQgaW4g
ZnV0dXJlIGhlbHBlciBmdW5jdGlvbiBjYWxsaW5nLg0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgICov
DQo+PiBAQCAtMjEyMiw3ICsyMTIyLDcgQEAgc3RhdGljIGJvb2wNCj52dGRfZG9faW9tbXVfdHJh
bnNsYXRlKFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzLCBQQ0lCdXMgKmJ1cywNCj4+IMKgwqDCoMKg
IHZ0ZF9pb21tdV9sb2NrKHMpOw0KPj4NCj4+IMKgwqDCoMKgIGlmIChwYXNpZCA9PSBQQ0lfTk9f
UEFTSUQgJiYgcy0+cm9vdF9zY2FsYWJsZSkgew0KPj4gLcKgwqDCoMKgwqDCoMKgIHBhc2lkID0g
UEFTSURfMDsNCj4+ICvCoMKgwqDCoMKgwqDCoCBwYXNpZCA9IElPTU1VX05PX1BBU0lEOw0KPj4g
wqDCoMKgwqAgfQ0KPj4NCj4+IMKgwqDCoMKgIC8qIFRyeSB0byBmZXRjaCBwdGUgZnJvbSBJT1RM
QiAqLw0KPj4gQEAgLTI1MDgsMTAgKzI1MDgsMTAgQEAgc3RhdGljIHZvaWQNCj52dGRfaW90bGJf
cGFnZV9pbnZhbGlkYXRlX25vdGlmeShJbnRlbElPTU1VU3RhdGUgKnMsDQo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAqIEluIGxlZ2FjeSBtb2RlLCB2dGRfYXMtPnBhc2lkID09IHBhc2lk
IGlzIGFsd2F5cyB0cnVlLg0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBJbiBzY2Fs
YWJsZSBtb2RlLCBmb3IgdnRkIGFkZHJlc3Mgc3BhY2UgYmFja2luZyBhIFBDSQ0KPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBkZXZpY2Ugd2l0aG91dCBwYXNpZCwgbmVlZHMgdG8gY29t
cGFyZSBwYXNpZCB3aXRoDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogUEFTSURfMCBv
ZiB0aGlzIGRldmljZS4NCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBJT01NVV9OT19Q
QVNJRCBvZiB0aGlzIGRldmljZS4NCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovDQo+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCEodnRkX2FzLT5wYXNpZCA9PSBwYXNpZCB8
fA0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHZ0ZF9hcy0+cGFzaWQg
PT0gUENJX05PX1BBU0lEICYmIHBhc2lkID09IFBBU0lEXzApKSkgew0KPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHZ0ZF9hcy0+cGFzaWQgPT0gUENJX05PX1BBU0lEICYm
IHBhc2lkID09IElPTU1VX05PX1BBU0lEKSkpDQo+ew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgY29udGludWU7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPj4N
Cj4+IEBAIC0zMDIyLDcgKzMwMjIsNyBAQCBzdGF0aWMgdm9pZA0KPnZ0ZF9waW90bGJfcGFzaWRf
aW52YWxpZGF0ZShJbnRlbElPTU1VU3RhdGUgKnMsDQo+PiDCoMKgwqDCoMKgwqDCoMKgIGlmICgh
dnRkX2Rldl90b19jb250ZXh0X2VudHJ5KHMsIHBjaV9idXNfbnVtKHZ0ZF9hcy0+YnVzKSwNCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgdnRkX2FzLT5kZXZmbiwgJmNlKSAmJg0KPj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGRvbWFpbl9pZCA9PSB2dGRfZ2V0X2RvbWFpbl9pZChzLCAmY2UsIHZ0
ZF9hcy0+cGFzaWQpKSB7DQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoKHZ0ZF9hcy0+
cGFzaWQgIT0gUENJX05PX1BBU0lEIHx8IHBhc2lkICE9IFBBU0lEXzApICYmDQo+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpZiAoKHZ0ZF9hcy0+cGFzaWQgIT0gUENJX05PX1BBU0lEIHx8IHBh
c2lkICE9IElPTU1VX05PX1BBU0lEKSAmJg0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdnRkX2FzLT5wYXNpZCAhPSBwYXNpZCkgew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgY29udGludWU7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPj4g
ZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYyBiL2h3L2kzODYvaW50ZWxf
aW9tbXVfYWNjZWwuYw0KPj4gaW5kZXggYmQxMjM2YzA3MC4uODk0MGQyNDBhMSAxMDA2NDQNCj4+
IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYw0KPj4gKysrIGIvaHcvaTM4Ni9pbnRl
bF9pb21tdV9hY2NlbC5jDQo+PiBAQCAtMjE3LDcgKzIxNyw3IEBAIHN0YXRpYyB2b2lkIHZ0ZF9m
bHVzaF9ob3N0X3Bpb3RsYl9sb2NrZWQoZ3BvaW50ZXIga2V5LA0KPmdwb2ludGVyIHZhbHVlLA0K
Pj4NCj4+IMKgwqDCoMKgIGRpZCA9IFZURF9TTV9QQVNJRF9FTlRSWV9ESUQoJnBjX2VudHJ5LT5w
YXNpZF9lbnRyeSk7DQo+Pg0KPj4gLcKgwqDCoCBpZiAocGlvdGxiX2luZm8tPmRvbWFpbl9pZCA9
PSBkaWQgJiYgcGlvdGxiX2luZm8tPnBhc2lkID09IFBBU0lEXzApIHsNCj4+ICvCoMKgwqAgaWYg
KHBpb3RsYl9pbmZvLT5kb21haW5faWQgPT0gZGlkICYmIHBpb3RsYl9pbmZvLT5wYXNpZCA9PQ0K
PklPTU1VX05PX1BBU0lEKSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKgIEhvc3RJT01NVURldmljZUlP
TU1VRkQgKmhpb2RpID0NCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBIT1NUX0lPTU1VX0RF
VklDRV9JT01NVUZEKHZ0ZF9oaW9kLT5oaW9kKTsNCj4+IMKgwqDCoMKgwqDCoMKgwqAgdWludDMy
X3QgZW50cnlfbnVtID0gMTsgLyogT25seSBpbXBsZW1lbnQgb25lIHJlcXVlc3QgZm9yIHNpbXBs
aWNpdHkgKi8NCg==

