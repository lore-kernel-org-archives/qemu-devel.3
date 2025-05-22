Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7139C54756
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 09:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI28t-0003LW-6H; Thu, 22 May 2025 05:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uI28q-0003L0-5L
 for qemu-devel@nongnu.org; Thu, 22 May 2025 05:23:09 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uI28n-0004MM-38
 for qemu-devel@nongnu.org; Thu, 22 May 2025 05:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747905785; x=1779441785;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ko2cF908OpoooXfw8XxavB+FVUKAd6dE+ItBhAnZeoo=;
 b=FeM4EYlAZUAhDhtQJVC3VhSgKL44fTBWWzADmbpf9kxcSC0Q6b8W4Wx6
 SRZUhojtkY9Wqlc14Ad829Rlz+5/JeUFt8kA1pDNPnpZ4n3/NGLMUTsxV
 XxuY0SxCBKKAKCEVAvQxwJtOMcDp8yPKU6HFXth1GTNBRzOy3xSKeZ3tc
 nLaM45zXWGquhlOWbXqGG8E+a3xeTbKHTtv+XeDVeQg3e2wi0KYhkMEly
 puyauVew1NSGsuero/oqYy9BsJjleX7dyjd4gbQvAeBEofDPMFx2dnWvP
 mTX6dG2gAZvfIgwIoqm0wcgloQcoa6k5wGI5pzZWOqwN9C0WpFGyW03A6 A==;
X-CSE-ConnectionGUID: sE8CXii1RjeJM0WJu698JQ==
X-CSE-MsgGUID: E7bhwXl2SJG1x01G1XZmJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="37539568"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; d="scan'208";a="37539568"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2025 02:22:56 -0700
X-CSE-ConnectionGUID: x68afCkbR4WHlr/xb6SUDQ==
X-CSE-MsgGUID: qHG2aC/nSsasvxCFeSACFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; d="scan'208";a="144451239"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2025 02:22:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 May 2025 02:22:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 22 May 2025 02:22:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 22 May 2025 02:22:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wjsewh7M/1k7b6XoN9yqRWUr3j38UlN/Ml7Ro9Kz1BfNszufp6nq2RXzJ1BnS0xsWKqBR3lFDuzBuw0+SZCAs+WV4NNWrGoHvi1bJvC0dMYdBoHPeRcfTnCwz+0D+zugJsI55lbSl+r4HvsE3f87FJUAZqKF+xB/JtDW8oZhlc4jDqlC1jHUBSrclerIBc77lhNHIu0/98Yn/PuquJXtDUXBaUzEo3foVVCQiQ7xW/fGmYgn6FTB60zfX3rOPUFiI1lCWezEO35Lun5NI/2lJUx6LE4pdobROtvB6efxgXZsfNs1K4SmQ5HTz42vnlQaK2ihZA5Y9yFsfX1ihuLHoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDDOqLtOnOIjb0ZoClHVy2qPvcvpA0T4QuIIlFKZQQo=;
 b=CmfE+4PpRIKYRLCip+WIzW7sxlV/Ixt1r2cdSj1zQVUM+DBTDciP/O7+0O0gJeFtGORT4pwyI6vwIXVy6nPT6oZ+8GP7Vmbv8NhsGlrLJaxZD8DewEORTu8u/rx/kJzPpcSK7V9SQzifb7Mo2aH4loUkrT+JakY5IqWnvEfVT5eXI26xhJZrNVX/kucEU27uCkoNtUab0ketIZzwH0K5bXKog0LMEXu7md8tTSPlQwT9NgfuE6pBC2ZAf3SMDgek1iN7zsBOktGxHxMJNa+9CMP5XSENrftn2I0X4l+J/e/yWZAeldudOmKS5IOtc7mr9dhMd3ruAxX242soTqoKcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MN6PR11MB8145.namprd11.prod.outlook.com (2603:10b6:208:474::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 09:21:05 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 09:21:04 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH rfcv3 05/21] vfio/iommufd: Save vendor specific device info
Thread-Topic: [PATCH rfcv3 05/21] vfio/iommufd: Save vendor specific device
 info
Thread-Index: AQHbykIti5D5SWxjUESxh4+ddQnLJ7PdojwAgABat6A=
Date: Thu, 22 May 2025 09:21:04 +0000
Message-ID: <SJ0PR11MB67449F7571B0604A8D2522D39299A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-6-zhenzhong.duan@intel.com>
 <aC5MVvwPCFertplB@Asurada-Nvidia>
In-Reply-To: <aC5MVvwPCFertplB@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MN6PR11MB8145:EE_
x-ms-office365-filtering-correlation-id: 321e36ab-0f90-49ed-1f0b-08dd9911f9e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?42evcp67veRC1ez558Rii+hTDUAcwATI+ALHCspAuLU3prJXTGw83cmTnLYN?=
 =?us-ascii?Q?gXjEb+iy1Z0myDeqmV/WAHhb4TA/QynbMSvU/Otz9RRE5ElI3aeCKpdIRM0/?=
 =?us-ascii?Q?9mIUyYkkpqZ9mn6+kKmecMgwanYJQZ5M6g5H6F6LimXZ/aJQ+VuHeNFCMBqC?=
 =?us-ascii?Q?2cotwoAC1XI2vXNwpwezb71Y+xrWkwQBuFMlk9D6fIvb2T24dSJImbFiBqEW?=
 =?us-ascii?Q?5BRpmxaSMCEVg5iT/8Fj9k6Le3ftuRikV+HzThhjrthAR1qwfmDmHccIRSXu?=
 =?us-ascii?Q?797bqWU8eQh4QHfu3ehfSzB9IlnSTw5Yq+9yim4tnvDq8W5vAhgIpGphAOns?=
 =?us-ascii?Q?EAQDAb1NbsWCL1ZqJKms+9V54VUDzZWdhFbF2TQ9Uo4WEeklTA5Jg9P4nPS3?=
 =?us-ascii?Q?S3WcgLPoYYF2W48MkCBxVXz/U3NeANEcqMs20tj/THm6jGElJ9RtY6sw19QG?=
 =?us-ascii?Q?y7S4PCZAwNj5MB2TGEhd47aRYfq6EpTTYhfvcVmpa4f1RDEigflH0d290D4q?=
 =?us-ascii?Q?8Q4xTSdMS30JBlJtJPbM1UtgiwKAN3KDj6CVA9zEzCR6EI6Gr5Efttmo1A+P?=
 =?us-ascii?Q?4UBG90DnDCAEhz5yYSbN/FzNpzMgKqSutvLXsYNQWEHILyx+rdruhjsLyJLy?=
 =?us-ascii?Q?Sk3AxZQZTb4FknCm8HL2oOXz6hCr2AY4i8RJt+3QCIkFgHY4HhmWTMC33kCP?=
 =?us-ascii?Q?KlsUIsZY8waktssEmR2aR730OkT2kX1kpbHZlkMzUP+JRPEjv0lD9etbVEGS?=
 =?us-ascii?Q?8uWy+IfKaPdNafWytS5z9IeQ91oXfGby2ZLM5pCFH4ZQUTF9+2PM7fkeiCN7?=
 =?us-ascii?Q?A//AlSnaC/M6f3VMgj7NLX2sY2GLKr6FMx0sFcy3baFw2QqWbpaotVycCmZp?=
 =?us-ascii?Q?jOcN+sodsjGR3ugp2SqQ8ODQguqlo6I7abNzbS1DuoP6uSIE1wgbX+qLoIA8?=
 =?us-ascii?Q?g+1AhcGXefn/vEuYWN0uDaiLP6GsKLK3zZHCC1CBN+IXypakQx+LWFRjlqEB?=
 =?us-ascii?Q?06+ladFxgta5P6B/iaUUSBC8H4afCG3t8wRehGP1ouXLzdW96qyrDLtYSrvq?=
 =?us-ascii?Q?ObuwT30V/a7s5v/EMfHi2QOjxRnGukkjALGywR4DL/t2bbGsuiDKIkULjcat?=
 =?us-ascii?Q?ux/pTjZqOIz8ZcZm25XxXGhrerLQ0Jskj7kPs2X5C6/CsCBJJAC2uQVIp14+?=
 =?us-ascii?Q?bhHaonw7+chEwLimpZZelnuuuVFjHOowdsgWS1aBioNnngWQbfQ0VfwH6piA?=
 =?us-ascii?Q?bvVrVv+MB0opyqrGtRh+8kG+iF8pM4DIz1khVfLY4FSEEPpAScM2zHHM0mlP?=
 =?us-ascii?Q?r3TnTuJbD+5l0OjrmvswvMaWFeExjFWmhPj1RJQ6UetGNn646n63mFXLFEw4?=
 =?us-ascii?Q?rwJH/k1sSdIRI+9bl2K+HbNCR/6Cvzuky5OmYpOxHAWNVUlKZNb2V6XcI3wF?=
 =?us-ascii?Q?OK0IU5ZF0PlEZYppmeiNeY7wammduvxPDdpK/ajmFn+JvA6WHlE+a4zJveqk?=
 =?us-ascii?Q?jEFGyY0YokfUEpQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nvw2BN7XhOwe0l+x0jclE3y3WLOe3l2g+PN2AsfYU4RTPPIxVhmfPDyXbWUB?=
 =?us-ascii?Q?E6x8+I2Be8QR3YeA7l5bJ+tlG4rBlMpe1+xwK96O1L4n0SAyF0VPyWEIvfqd?=
 =?us-ascii?Q?f2/23ZB9Chr6XJZzYvS+oAmlqU0vK93Ru0CTTAPEKuyMAm8yLwJy78uzoOLC?=
 =?us-ascii?Q?RGWE6bymFWl2DFJc1fK7FD+adzJQ/RKzietFniN0XBkmjW+TfJ7x6zrh7zG+?=
 =?us-ascii?Q?ISk0PbNHz3AwziSI9Wkw1kzIPs5n6h4O2nQkFuax4MuYjwLfFund6GZgDZPU?=
 =?us-ascii?Q?s9RzmBgEfutyulUijTsHzxapc2EBXYdAAoqEqrrDUBvo9uSgCSDwn9yAFk3N?=
 =?us-ascii?Q?niuJJRnrj0e2/1cM/LO6/0aOdHsBnCB26Tfnediug2k1Qubz7MgUnx+qj8Cl?=
 =?us-ascii?Q?LyBxLD/v9shZhk7aFVsysgfiwNdoLdPfarvVdvJa/5DUtvz8lUPh4rmb6liB?=
 =?us-ascii?Q?ap/PYjjWpZZFfNIpmzkdsKkJrwcJrb0ZUJyYgFjoT+wFrnFp6Hl4Eu2A/FGp?=
 =?us-ascii?Q?m7/DES5yEBb7z7Wu+8TTKKSS8Pdds95Xq+Q6rk3pa87Xtr3pmGttazoJdyhQ?=
 =?us-ascii?Q?+sd3XfphFKKAM6awvjP9U8d62aJ/IFwuOHR7rq/32N1EoHLwmuupduZEq9Ms?=
 =?us-ascii?Q?UlF4DgiT0iLEDhXikuz6IlpVImZyBeVQkB1sgcpVoaSLJnb/tQJnOI28RTci?=
 =?us-ascii?Q?q6zCKltb6jtqSLRXtxLfFhQ1D+l/UZRxGj+0xxScdTBxPQEky4jWMeoiynbS?=
 =?us-ascii?Q?zTCKj/qABB4FiRhQNJfD97KoY04J37nQszt44wtHhd5fRqBAeYH050XNpayk?=
 =?us-ascii?Q?xiJLKzWLc4xGnh0YVv/hkZwdFsd48xoUnudgY9RnwFUbEwrddSM0jrVdnF6c?=
 =?us-ascii?Q?0VF4BjWdjkb5zrFk/k7JG0OGwVoEZs1kBBIRwGVAgARFb1M4SuGCK4x2suLi?=
 =?us-ascii?Q?F3o0XGKoTYKhlcpPHac/s8SnqpVv2ouCKGgTncKERMCevcZ0BH5j4xsukTOC?=
 =?us-ascii?Q?1UK0KQ2t2u+ty29uKTsb3UKMEPxv8360Kd4ftak9X5IdltSiv6rUZLIAlOpC?=
 =?us-ascii?Q?BpTdbRiCl1TM1JcoOgdwmc9fMX6MmHOWKKPq4GLa+FdyK8zTUeqyWnyMUMCm?=
 =?us-ascii?Q?eFlnFIV/iKlPRTf/VgNQaP7so5TUDz7b3XBZsEX9z2Ko51N/WsE9erMajXLC?=
 =?us-ascii?Q?qUi6iJtM+BwK4wTXrMD/NVkb4qMrxC1OLl6NGaDrg9WEOAOtnxruy8ibOlpC?=
 =?us-ascii?Q?gwloN/thhVlMtfqoIWNMXnLWoE9TZnZ9k/d2qHetpQaVCQSUho26KsnH2kDn?=
 =?us-ascii?Q?kph8ZEo+bDm+t/RiSgVOREHedDHXPa7hHhraw7Pr2+zJ1r4+UIauJFzHVLo6?=
 =?us-ascii?Q?yU8bj/PS6AJxJfFf0a4wWD2OBwqOhMqJlVOKik5OdJ9ETQpodw2o6lDjlYYE?=
 =?us-ascii?Q?QeVZL9pYQoqH6SbMaj5v4m2lILIFl3sxuR2Ckw6OSd07nII/BclkQ+eshnZB?=
 =?us-ascii?Q?s6m02wS66veOuQwYtScNL9f6cVhwPain89lrWosPLal+WrSqyVH4XgSl0Kyn?=
 =?us-ascii?Q?cKDDYo6ZXMBRtGmw6TmF71sFI62GOrnuDkC0DN6X?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 321e36ab-0f90-49ed-1f0b-08dd9911f9e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 09:21:04.2369 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 11l7iyNhjViQA2C7SES/2JsWlt3HGQIDP5d7+OysHuvPOQ1ONr1uBP8Lq0y+eTaRdmUCwq69NKauOWFSufFQNqT0glBHreD4rXcbO8UdAPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8145
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
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



>-----Original Message-----
>From: Nicolin Chen <nicolinc@nvidia.com>
>Subject: Re: [PATCH rfcv3 05/21] vfio/iommufd: Save vendor specific device=
 info
>
>On Wed, May 21, 2025 at 07:14:35PM +0800, Zhenzhong Duan wrote:
>> @@ -852,6 +853,17 @@ static bool
>hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>>      caps->type =3D type;
>>      caps->hw_caps =3D hw_caps;
>>
>> +    switch (type) {
>> +    case IOMMU_HW_INFO_TYPE_INTEL_VTD:
>> +        vendor_caps->vtd.flags =3D data.vtd.flags;
>> +        vendor_caps->vtd.cap_reg =3D data.vtd.cap_reg;
>> +        vendor_caps->vtd.ecap_reg =3D data.vtd.ecap_reg;
>> +        break;
>> +    case IOMMU_HW_INFO_TYPE_ARM_SMMUV3:
>> +    case IOMMU_HW_INFO_TYPE_NONE:
>
>Should this be a part of hiod_iommufd_get_vendor_cap() in backends?

Made following	adjustments which save raw data in VendorCaps,
let me know if it matches your thought.

diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu=
_device.h
index 38070aff09..14cda4fdc3 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -14,16 +14,12 @@

 #include "qom/object.h"
 #include "qapi/error.h"
-
-/* This is mirror of struct iommu_hw_info_vtd */
-typedef struct Vtd_Caps {
-    uint32_t flags;
-    uint64_t cap_reg;
-    uint64_t ecap_reg;
-} Vtd_Caps;
+#ifdef CONFIG_LINUX
+#include "linux/iommufd.h"

 typedef union VendorCaps {
-    Vtd_Caps vtd;
+    struct iommu_hw_info_vtd vtd;
+    struct iommu_hw_info_arm_smmuv3 smmuv3;
 } VendorCaps;

 /**
@@ -43,6 +39,7 @@ typedef struct HostIOMMUDeviceCaps {
     uint64_t hw_caps;
     VendorCaps vendor_caps;
 } HostIOMMUDeviceCaps;
+#endif

 #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
 OBJECT_DECLARE_TYPE(HostIOMMUDevice, HostIOMMUDeviceClass, HOST_IOMMU_DEVI=
CE)
@@ -54,7 +51,9 @@ struct HostIOMMUDevice {
     void *agent; /* pointer to agent device, ie. VFIO or VDPA device */
     PCIBus *aliased_bus;
     int aliased_devfn;
+#ifdef CONFIG_LINUX
     HostIOMMUDeviceCaps caps;
+#endif
 };

 /**
diff --git a/backends/iommufd.c b/backends/iommufd.c
index d91c1eb8b8..63209659f3 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -368,7 +368,7 @@ bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDev=
iceIOMMUFD *idev,
 static int hiod_iommufd_get_vtd_cap(HostIOMMUDevice *hiod, int cap,
                                     Error **errp)
 {
-    Vtd_Caps *caps =3D &hiod->caps.vendor_caps.vtd;
+    struct iommu_hw_info_vtd *caps =3D &hiod->caps.vendor_caps.vtd;

     switch (cap) {
     case HOST_IOMMU_DEVICE_CAP_NESTING:
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 5c740222e5..fbf47cab09 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -836,15 +836,12 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice=
 *hiod, void *opaque,
     HostIOMMUDeviceCaps *caps =3D &hiod->caps;
     VendorCaps *vendor_caps =3D &caps->vendor_caps;
     enum iommu_hw_info_type type;
-    union {
-        struct iommu_hw_info_vtd vtd;
-    } data;
     uint64_t hw_caps;

     hiod->agent =3D opaque;

-    if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
-                                         &type, &data, sizeof(data),
+    if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid, &type=
,
+                                         vendor_caps, sizeof(*vendor_caps)=
,
                                          &hw_caps, errp)) {
         return false;
     }
@@ -853,17 +850,6 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice =
*hiod, void *opaque,
     caps->type =3D type;
     caps->hw_caps =3D hw_caps;

-    switch (type) {
-    case IOMMU_HW_INFO_TYPE_INTEL_VTD:
-        vendor_caps->vtd.flags =3D data.vtd.flags;
-        vendor_caps->vtd.cap_reg =3D data.vtd.cap_reg;
-        vendor_caps->vtd.ecap_reg =3D data.vtd.ecap_reg;
-        break;
-    case IOMMU_HW_INFO_TYPE_ARM_SMMUV3:
-    case IOMMU_HW_INFO_TYPE_NONE:
-        break;
-    }
-
     idev =3D HOST_IOMMU_DEVICE_IOMMUFD(hiod);
     idev->iommufd =3D vdev->iommufd;
     idev->devid =3D vdev->devid;

