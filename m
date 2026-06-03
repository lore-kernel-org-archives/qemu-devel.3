Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5807ACD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 02:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUbMU-0001H0-BA; Tue, 02 Jun 2026 22:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wUbMG-0001G0-Tt
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 22:29:31 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wUbMA-0007fg-Bj
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 22:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780453762; x=1811989762;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=COq1FO3rB4v1Iqd7rqJqC7aIrvnx5VXEXdH6W6o/qQ4=;
 b=Ihpq4hoCy7GpIfwmphaCMePFvLK2kEbyJ/w1b3FDaL0zt5SeFaUNDZnW
 Yx2pKZxI9mCB5P4WkRkopIK0bhiOEppZs/KWu9o+kVNxIGYPBO4nYHiYp
 qix4ZG1JYK5OootLPVmMn5OH3wlTnI/4OT34VbELqiUbQu4eK0JOt3Tks
 kr75oyEhilamvmM5SMySpQpW8vRt/nKjN0xT6igy38107c1frlosL2vXF
 8Q9J3ULa9RrD79YJiVmc8EXH0CbayXBCFRWdx0VTX53Zfgwbv9TjyBw5k
 4lzPtgqbcU8pu/3/GYPnlDpBIVqIoLWzVDCiQ+IVIcTxy4wsZJJoDA+pK A==;
X-CSE-ConnectionGUID: 3w8zlG69QNqbqalup4TRSg==
X-CSE-MsgGUID: 5jURk8EyTcOq3qm95i4zNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="103909734"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; d="scan'208";a="103909734"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 19:29:11 -0700
X-CSE-ConnectionGUID: n0631an4SWOFyv/ZWEm34w==
X-CSE-MsgGUID: P1MM7NYMQ3qqGLBYAqmdRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; d="scan'208";a="282194879"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2026 19:29:11 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 19:29:09 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 19:29:09 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.5) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 19:29:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yITnw3PWAPdkKjlCSYedQ0giLQkuYxrpX+zDblqJ11Oul8YDgrJtW2QdcP6bnSrHdAw3yQytmcEo7+lCp/Rxe+LL78nnotqYRq/aRA2VL8YeEn4SWr1k72awql1Q7k4/5/xsi/FEt+tcX8xCi00cjsBnRnbwV3zeCdEAz3LZsOfX8dLtQiUvQfDzqo8bpLW9Q6py7b1dyNnAHOHS1+pqV5tl+Z5XM+SaMNRIx2QitDe86gViGLMC7C2ldjyy4b74HSVpeUmuvEcbv9GX0/lgO3Tpr3tb9SAuy7TLxcA2s4UpwGWjV7bHD9vJzCrY/rlMo4hisWgmVmTdDuwJdNLyNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COq1FO3rB4v1Iqd7rqJqC7aIrvnx5VXEXdH6W6o/qQ4=;
 b=EZgNawc4tMo5NULCiuqlpKoTlit1z+JZnQkU4wZnaJfhh9du3O5RnWLgfgsfMb9LD8e7NNMga9utzxofzDe95AcfDCaSNQBj5KQQdZ8vNC1qHcU2Ixg/SqhxsxTA/T300PqpI9WuSLE4mqM8pv1+QtK89dphEZazhYI5l5QAplOA4QoFnsO6euUCIeh3YK4tDW9xTIvQS5tj+xjX3gglQ+sOHOdOKsKE8PzQ7TBxXk4XVpcz+NPEc+EaUFHcaL/2eH8aFSEph86pEG314n4MC3FEwBTVBsEfC2UdY0XtgMwJQANZ7ZVT3+fuOZNRHH5fVVO8IkO0SLvGED2lsAmvMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CO1PR11MB4913.namprd11.prod.outlook.com (2603:10b6:303:9f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 02:29:07 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%3]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 02:29:06 +0000
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
Subject: RE: [PATCH v6 11/17] intel_iommu_accel: Handle PASID entry addition
 for pc_inv_dsc request
Thread-Topic: [PATCH v6 11/17] intel_iommu_accel: Handle PASID entry addition
 for pc_inv_dsc request
Thread-Index: AQHc7Zxx9YgzXdkftESCvfuLe/RDmbYq3d8AgAFHv0A=
Date: Wed, 3 Jun 2026 02:29:06 +0000
Message-ID: <IA3PR11MB9136A369C2C5C1937EC5530F92132@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260527054658.1021096-1-zhenzhong.duan@intel.com>
 <20260527054658.1021096-12-zhenzhong.duan@intel.com>
 <5830403956a1ee871e82f3a9f0c466ada8dbf045.camel@bull.com>
In-Reply-To: <5830403956a1ee871e82f3a9f0c466ada8dbf045.camel@bull.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CO1PR11MB4913:EE_
x-ms-office365-filtering-correlation-id: cf31f1f3-6244-433a-f026-08dec117e2f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|56012099006|4143699003|11063799006|22082099003|38070700021|3613699012|18002099003;
x-microsoft-antispam-message-info: xEfQYVUTRX+8fmFeXFq1TNTJ4eSwtqr7ueIsdN5OsKoXATC7u1xKQdYzLUaMXiwGRh7G9r3B3PuWwk4AFr7bgjRpT0/uSWwchcEOez969MKWBWTz849bKiFjq/g0XbythkngiIfJasgdS98AjWvgQ7Xg005z3dK/x4k98zs7xWei3VNUxhcXBYM4036b7blEkj2Wk8DCiMWhbuaCxAyyZB5bKqqAdj1rpg+IsBolQq9snOnPYZhaIrhpFWiBX9fES+0DDU0UO7d85yj7qY06mzYfE1zsS+uwX6DRmLUA4HMfHhrJicZoIGU5dFSQH9c3+Bsyatj9QYttFAvMwm4KJXEUP1djOAbINw17tPXBxfT9X0yG12XUkq3NT5dtk2b3y3kK6KBN+QzgLCpFpLOh8sks3GItUCCkVsCHuqKPZxaGfQ6f81yxHl7h4NMHs3c12kiADLCI7Beh+vPwRBrZ52X02j1t0OZqZIwPKfchgGxEi+6e+Psh/9KOt/X37gij8xpqxEAEXH0iFaRW4n24RHvVF74XW6qmtNX7jX3vx3J2km3HBmqrwIkEw6bEdrpC4d04NCMpXCA6nBe1dMqLbyIHSB3B6CdBCNAMwbpM3Qf8hpEd7+ZTwTYOkePpHOGkPXrOpe1duNvmqMO3vgvdFmtbVIaDatYHuArBpDeV2cz17C3h8/9Prpy3iJ7vv/sYutbFccQrWeslnAv8CeZ7byRYuvlDlfOPlFLjkdIgh2f4koIofHFI6yoBzeubecgdqybk7TFAXMKEBWn9Cxc/lg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099006)(4143699003)(11063799006)(22082099003)(38070700021)(3613699012)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZElvcndvNzA0Nnc2enlwL3dKTGZZdVZWZEo5UnU0WEowTXI4Qk5Qajd3NXhN?=
 =?utf-8?B?Qm8xdDV4cXpjRzh5SW1aZVdjL1NZeE5vRFp3QjFyMGI4Y2NaQVlLYjlzV2lk?=
 =?utf-8?B?b2s0TXZUb1NUcHZnZ1ZTSjd4U2dCK2tQSWsra3JWRUsvMnFSZ0llU1FxbW1Z?=
 =?utf-8?B?a0ZCeW9UVk5OdzhDN3FNVWNMbVFKTzM4UWhyNzhncHdEOTVZTDl4YkhvaHhp?=
 =?utf-8?B?RGptK1ZJUGZuWS9ZZElNekJQdTB2YmNXVUJCeFY5ejEvUWVsdjFPcjAxNUtX?=
 =?utf-8?B?K3k5a0dHdDFXbFVYMUJaOXlNTGM3UXUyWHN6Z3RRUzFDNzd1aGJyZDNDVzRE?=
 =?utf-8?B?WFNSamFnRWFzQmEvV2hMSnFzbkV0OG4veGMxdk1hMXdRMkM5MTdMN2cvUElq?=
 =?utf-8?B?ZlN5cG4yNkJHWkpEWWZxbE9KNkF2KzRQOURaejZkenlUYVh2THVRU3QzWUtE?=
 =?utf-8?B?YXNnemVmUDZnaWExelo2S1ZJSGNNKzhMZHE5dTVZWncwRk5UK3FkbU9rYkZx?=
 =?utf-8?B?Y1dyS2V6eGp1dEtVZnlDL1BHbUxtd2JHdVg4Qk01MlErTHRKRjFvUXZCcElk?=
 =?utf-8?B?L0dwejQwd1ZlK2tWOUpTZ1ZVdzdOcm0yeVV4ekRMNGZuR25qeE8xcEs4UVBE?=
 =?utf-8?B?T3ZyS1V3a0FVdlh3VDA0dkhOTm11ZUdabDZRM1BUNHBWMzV6VURDak1VMTBG?=
 =?utf-8?B?ZkNmR1loTHF0WDBVSjdDVnhmcEY5TGdERXRtWk80QzVQRmNZL1dSSktkeUU0?=
 =?utf-8?B?TCsyOFRqNUhNcGRad3B0cFJVUG5HZDhNRWRNc2tHRnVuQkg0bk9qZytrMVZK?=
 =?utf-8?B?M29WRTB2N2pNZlFBUlROR1Z1UUdudmlJNHVVdjUyRUxlWVl6TnVPNXh5WXh2?=
 =?utf-8?B?cVoyNC9sTktqbklyTm1GMXYweU9VMWlKUXovTW5xQWdGOTc2RXBla3VTRUxr?=
 =?utf-8?B?UXdxeWI1TDl6TzRuS1dHMVBMZEJOQVJlbm8vUVgyVll3UFZCc0k2ZHhXNzU3?=
 =?utf-8?B?QWtaak1HVWVNK1F5TVhiWmdaVEpPTjd6S0NkdVZHUERYQ2JlYU9FRzRpdFdW?=
 =?utf-8?B?S01HOG95d0VDQU93NUtpU1JJYnRXY2ZKZnpGL0Q0TXlaVU54VGgxTWlQTHEv?=
 =?utf-8?B?UHBPamQ0dFpzRytXYnljNFV6dExFdndFd0NoSGxjRDdRZDhrRlB5cTRXSHlC?=
 =?utf-8?B?TnY3TkRwRTE3a0FXVnhUeHdlUDBNR1NrRkFwYm90djgzOFZwd3M2enhOUXZY?=
 =?utf-8?B?UFJMVnAvSmMyMjV6RGo4aTZmRUxvdDlYSm9McmlBVCtVMG8wbktkSFpNWGU5?=
 =?utf-8?B?SHJBQzJ3VWlTanVCbFJjRVIzSk9nNUR0UDBZUWZKQnM5cFFpYm9LSWgzTVh2?=
 =?utf-8?B?QnMvQzM4WW9VdDhVVUR0eTdXRllKc2VvZlNKMFloNFBOWk90U3QxeXByTElZ?=
 =?utf-8?B?dXlBZld5TlJRU0wzanIzVk4vdWpDS05xdzVlemREdXJHblprV04zUnRRSm1F?=
 =?utf-8?B?S1RhK2s2UkRtR0JJTWRGTXNwS1BmLzRVRXVaRTgrM1I0QXhDMWZTTU1HOGFS?=
 =?utf-8?B?QXZjWkNJdjk2ZDhsbzFFSnh6THJQK21lNXJiSEs5UGhQLzQzUkZTUTRENjd2?=
 =?utf-8?B?bk5UZkdrdGVxblFibm9PYk5ET0FGNFBSUzYvam1OK21vZU9MbjQwSkNoeUw4?=
 =?utf-8?B?Zk5qZVhncm1ubzRVdnRveDRKbUZVZDNEQWRsM2V0SW81TzFuMng1QmRKUThI?=
 =?utf-8?B?Q1Frb09RKytvVis4WElTUnVJOVZLcFRMWU55MlRjTCt1bW9ZRkNvQ0dwMVA0?=
 =?utf-8?B?aWhjQmZFam9sZGUzZC9NaHRqQ2tkN3BTRmgyc3gzcmRwdEY4dnc0VWk3RjBk?=
 =?utf-8?B?ZXpublc4UVBORjB1M3Z4bGM3V1hWekZQVmNaOFdGcm8ycHNWOFA2Rnd4cmw4?=
 =?utf-8?B?U2FyU3V2blpIK3VpOXE2a0t5Nm9ESXZ4VFZNcXpKeXNPeTVPbHlmcStTTFhl?=
 =?utf-8?B?OSttemQ3SnZLdk1NQWQ3eERHeGg0UDdLQUptcTZIY3JmbWsxRmNjSVl6WnVj?=
 =?utf-8?B?eW9HYVRyQWVYV2lXTFgrUEJVdUd3dElkQTFLcE54Y2grR1dzUG1zVU9qK2R0?=
 =?utf-8?B?V3V6N08yQ3AwUzl5YWQ3TUY1bFhsZ1NxSWNMTGluTWFTY0UxWjdEQWJLVFFl?=
 =?utf-8?B?WTVweVA1eWxoUk1uaGVVMmpISHREZi85T3hybkpkSmxIK25Gdm1KckFvUjlU?=
 =?utf-8?B?VVZsUmIxVmFTdTJvK0RuOTY3VUNwRWhtbnRxbnJVR1YrcERyeFdSRE9VN0dz?=
 =?utf-8?B?bUhldVAxRXN3RFJHSEJ5NnVReXRCbXF2bzlSakphdUpsb1ZSajkvUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iksqz4p7HUTWGN5VZ1S/8sILqSJTojxxAiLyeoAWrRESKnCjxvl45jJQ9qgAs0Z03o113/BS13TGery2O10tgEubyuKYIJ8YTEmlUpClh9aDggodvjm0ZbC8+EwBn4Av+BWlJNEn+89WzNSL4RfQreUnC46VOPY5lOQ0cb1UF2P9P+bWXDW8gJWK5/3m8k0ARetu/TZn5pJlOAFUSBCxIWThmKhimluzc+AZ3pIL5rZ3BF2x5EYPOdI0LTYdrpM/AX9eFdC/1ti+vJWdX/hJU+7ZmAyFtUY4knNTLPsmQUPK69Ld5S0eUvTWsWZ9CO056nGqIent8gCPITesg0OP7w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf31f1f3-6244-433a-f026-08dec117e2f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 02:29:06.9012 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: srRxEwzyvsI7GhdQ9bH5BkaQcisjNYGy9xBQSTJGnzrlmJEdfTerw2d/aueLMgeF6nus1xDe7y93HR4sA0I34gXK5tSSgUZSEumc2v9MD9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4913
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

SGkgQ2xlbWVudCwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ2zDqW1l
bnQgTUFUSElFVS0tRFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGJ1bGwuY29tPg0KPlN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjYgMTEvMTddIGludGVsX2lvbW11X2FjY2VsOiBIYW5kbGUgUEFTSUQg
ZW50cnkgYWRkaXRpb24gZm9yDQo+cGNfaW52X2RzYyByZXF1ZXN0DQo+DQo+DQo+T24gV2VkLCAy
MDI2LTA1LTI3IGF0IDAxOjQ2IC0wNDAwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IENhdXRp
b246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5r
cywgdW5sZXNzIHRoaXMgZW1haWwNCj5jb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPj4NCj4+DQo+PiBTdHJ1Y3R1cmUgVlREQWRkcmVz
c1NwYWNlIGluY2x1ZGVzIHNvbWUgZWxlbWVudHMgc3VpdGFibGUgZm9yIGVtdWxhdGVkDQo+PiBk
ZXZpY2UgYW5kIHBhc3N0aHJvdWdoIGRldmljZSB3aXRob3V0IFBBU0lELCBlLmcuLCBhZGRyZXNz
IHNwYWNlLA0KPj4gZGlmZmVyZW50IG1lbW9yeSByZWdpb25zLCBldGMsIGl0IGlzIGFsc28gcHJv
dGVjdGVkIGJ5IHZ0ZCBpb21tdSBsb2NrLA0KPj4gYWxsIHRoZXNlIGFyZSB1c2VsZXNzIGFuZCBi
ZWNvbWUgYSBidXJkZW4gZm9yIHBhc3N0aHJvdWdoIGRldmljZSB3aXRoDQo+PiBQQVNJRC4NCj4+
DQo+PiBXaGVuIHRoZXJlIGFyZSBsb3RzIG9mIFBBU0lEcyB1c2VkIGluIG9uZSBkZXZpY2UsIHRo
ZSBBUyBhbmQgTVJzIGFyZQ0KPj4gYWxsIHJlZ2lzdGVyZWQgdG8gbWVtb3J5IGNvcmUgYW5kIGlt
cGFjdCB0aGUgd2hvbGUgc3lzdGVtIHBlcmZvcm1hbmNlLg0KPj4NCj4+IFNvIGluc3RlYWQgb2Yg
dXNpbmcgVlREQWRkcmVzc1NwYWNlIHRvIGNhY2hlIHBhc2lkIGVudHJ5IGZvciBlYWNoIHBhc2lk
DQo+PiBvZiBhIHBhc3N0aHJvdWdoIGRldmljZSwgd2UgZGVmaW5lIGEgbGlnaHQgd2VpZ2h0IHN0
cnVjdHVyZQ0KPj4gVlREQWNjZWxQQVNJRENhY2hlRW50cnkgd2l0aCBvbmx5IG5lY2Vzc2FyeSBl
bGVtZW50cyBmb3IgZWFjaCBwYXNpZC4gV2UNCj4+IHdpbGwgdXNlIHRoaXMgc3RydWN0IGFzIGEg
cGFyYW1ldGVyIHRvIGNvbmR1Y3QgYmluZGluZy91bmJpbmRpbmcgdG8NCj4+IG5lc3RlZCBod3B0
IGFuZCB0byByZWNvcmQgdGhlIGN1cnJlbnQgYm91bmQgbmVzdGVkIGh3cHQuIEl0J3MgYWxzbw0K
Pj4gZGVzaWduZWQgdG8gc3VwcG9ydCBJT01NVV9OT19QQVNJRC4NCj4+DQo+PiBWVERBY2NlbFBB
U0lEQ2FjaGVFbnRyeSBpcyBkZXNpZ25lZCB0byBvbmx5IGJlIHVzZWQgaW4gaW50ZWxfaW9tbXVf
YWNjZWwuYywNCj4NCj5Gb3IgY29uc2lzdGVuY3kgd2l0aCBuZXh0IGxpbmU6DQo+c0BpbnRlbF9p
b21tdV9hY2NlbC5jQGh3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYw0KDQpTdXJlLCB3aWxsIGRv
Lg0KDQpUaGFua3MNClpoZW56aG9uZw0K

