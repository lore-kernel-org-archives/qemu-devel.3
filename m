Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC68DCCF2D6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 08:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIj2j-00040C-Ax; Mon, 19 Oct 2026 04:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xIj2h-0003zt-TK
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 04:48:27 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1xIj2f-0007xG-J7
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 04:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792399705; x=1823935705;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=S92RtYeAWZYpSaVIi3IgsVNApYYqakbOp4fRj9ZAANA=;
 b=Qrkwvya8sfzXesnCgTpna+0CgETdG1xDZI5/IAn1KedVglfLV1PKNwzV
 7SIOYoGvU7cEOAiL325ToGakPhxXvfQW0Z/yEsDCvo2ACRLcmwrfdq3TD
 WmFsnZiB1hpCwPm62cNSlG0YDtHdxdxPuatEbAoLXm1rNeSfUlZ2+yrWy
 NSq1KvswRoMR0ji1lIu+9F4WnAFBeVa+nRMhrv19+WY9dDB5DED1UNg0q
 qpY8ADr0Ty1Y60wXiL4QDiUdYzJ2GxSe31Zdyd0GwQI2ysj6ETehltaKX
 vEwaCS/q4J0zsy4ysW/84xHx2ZyRF1/q3dsyGNovIfPqErilL929tN4jW g==;
X-CSE-ConnectionGUID: qyCM+5nkRtCWrsA+uuDSwg==
X-CSE-MsgGUID: EQlEuYrNQxuiICbJ+Ym3Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1086442"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1086442"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 01:48:20 -0700
X-CSE-ConnectionGUID: 6S4OSqSxQuW2NChUtNEovQ==
X-CSE-MsgGUID: TbKoa7iYQFSSnpsPAgF2Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2456973"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 01:48:20 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 01:48:20 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 01:48:20 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.65)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 01:48:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gku9j/AunaQD3eaTWAf5Jjy4AbiovFsj/5Sg+absq/h0GR/ww+DWJPuulSBdY9uPIDmjx56dDHPx5E4QbvXdA0d9vApJd4I4XyNqTh3rOXz+nRr5gUDVhVLve63TpqeDUjVvBa0nPaTafJOhEUdiWNa5gYFEVamdqosq9oqG4lCg+7CUKboJF8HwMDfmnasnAU2Fo/dZ6nYbKVX2WMU6ZRR9Z/dQE+kiBwu5q5rzbl2ToIiRUlbyHRSqBIo23kQatmJdcKxU8KeP2+XU7kjEEi/aiY4lmNf75eaO6fi7iUoWHkF3mcWa9xs1oG6fHtGqrvUmrNtp0jByOXYyBHIdTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S92RtYeAWZYpSaVIi3IgsVNApYYqakbOp4fRj9ZAANA=;
 b=ic7S5ktID0u/27J2yVWdhXD7UXJC5NQZE+73Zkwu9zrIrUKzV3HSII1BCQLxEi8urusi0a47wgmgnzBmTXR/n0L+nIrvMJKPA7SHlBoKiD9mYdUvXMPoXoHUVEN05dISnqvnQn9jfQ3x4iHvlu+X1Ogh9WcSNROP7t//hIEZprBVgLlCP3Ptcji7pvLLOxxI3kxJ+b7eytGTgU/SM79dENvq/plf0g67th8uiIjN4TscK5RmPQu6e8htpvQkW5RYG/FniBDgwdcXHrKMnjaCMrEfnf6KjIeQVWCR/I3NloV0EuaHR1envmtqLbN7IPHz8pYDPO4+Y0Zm3aT5aO+DtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS0PR11MB8115.namprd11.prod.outlook.com (2603:10b6:8:12a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 08:48:16 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 08:48:16 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowangio@gmail.com" <jasowangio@gmail.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Subject: RE: [PATCH v8 6/6] intel_iommu_accel: teardown FAULTQ resources in
 bottom half
Thread-Topic: [PATCH v8 6/6] intel_iommu_accel: teardown FAULTQ resources in
 bottom half
Thread-Index: AQHdV828wzshGbvx9ECNBG9MIYLlQLcDYp2AgADX9nA=
Date: Mon, 19 Oct 2026 08:48:16 +0000
Message-ID: <IA3PR11MB91360BE8D6DA1C1F7239873092982@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20261009090737.3930000-1-zhenzhong.duan@intel.com>
 <20261009090737.3930000-7-zhenzhong.duan@intel.com>
 <d7b37c65-7234-4eb4-b960-454572f447a5@intel.com>
In-Reply-To: <d7b37c65-7234-4eb4-b960-454572f447a5@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS0PR11MB8115:EE_
x-ms-office365-filtering-correlation-id: 2455baac-0d16-42dd-d49a-08df2dbdb7b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|38070700021|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: WuPLkBMo448EaZTNCYRvoYds1z+cG2aIHvog+o9T+CYricLvWikiV20W5Lf2d+a0BYi07U/ufEi9SrvFWs/z6lg+ofpdKfDaeHDe4IotzLgTHxSWpzqniAkmNFq9zxXAyF8Agt9G6e43dIMId7U1ORa6uhhxhXmJZ8sNXPZr3czZw1atsCZEn1H4+lPetMv/0cKEpPXfkda1ZH48GLpxnko+nVG1NFj3RxXsN1TVpwuiFEec4JqEAJjOzhpiNCIdNiaK+5dkHlBgHsNqY7dTMLaOB5ETysoXtGUROIIeQuVTE4LSrqgK2nZJtoRlMHf+wgKW348xE2Nzxg1B9KMiHyDqWXOIIRzjBCWIVk0D9A5T7zvhT1u9WxtYImtpCKuzcnKS5po6vYcIVkjIwPf5oUhD6kHmFHDRySTxheF+2WZFO2i7uqOP+oB3zJoaOvAblNDRbC4+rNKOB/2kC3PA5CeRoJ3umsgqNQrnrwIswjq5HAMXs26RHaRdp5aUeCA136b5224R3KZfP33pHbQbqkkZPv5eQXBv+uyAc3u4bB7LNiO8Q62ZeuroYr0eSdrNBMobtG5k1tH80Gyl2HIXkJaRO3zSbU9ItkO1fgueWymMM+XRNmLGF6WZBcRxBpsf7cSrry9UfRsouiizpCcqpmcgJocaqqyb2FQu3ALGFMedx+mEanwO8dKWw5A8+Mzyu16dIrTo/4s7OJvjP6gZyYaHoPDkw1YCPmVhCaus6hE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(38070700021)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmJ4T2xtSEdKN0UxYWdXZEVjZ2tJbXdIWGdzekRJUnQ0NzBrN3F2T09oZitl?=
 =?utf-8?B?R3FJcDloNTN1aWNaL014ODE0QWNXRUhSblhUaGkxNVZPNy9Kc25EbDUyaWRV?=
 =?utf-8?B?eGlqalpSOWMzN1dXWWRuc0dXVjVOVTFEMFFzQ1FPNWpXaEhXaHphUVl5Ny9n?=
 =?utf-8?B?c0pQZ2o0TVgvdDhuclRyU1FLWjVldEMwdVp6ODNTTFhMdlRMTkZ1OFB5TzVw?=
 =?utf-8?B?bWxMUllPZ3g5MzBsMSt1QXZQWUdSVSthallML25JSW53S0hmQVUvcUM1blR0?=
 =?utf-8?B?dmZNVWpPbjNqc0FqNG5SVXJ6ekU2QUM5d3lmVW5JcDJtbW5Mbk43VmF1cith?=
 =?utf-8?B?bS9Yd3pOWit5eDZmV0Vuc3lyYWEvK3hYRzlScFBGODZFRXpQNmlYeGl3M1Nj?=
 =?utf-8?B?dSt4NmE4c3dJRlV6bUtVY09uRXVGZTh6Nncwai9qYlQxMGZtVDNSd2RQQ0Q4?=
 =?utf-8?B?OEhCaC9hRHk5aUdjMWpjMDFIREZkelF4U3lMbjVQdHVkMmNEZEd0Q3hSY1Zh?=
 =?utf-8?B?RWRPTGRrZjNBVTdoUERvMjFVVEozTm51NGYwU1ZodmJaaEFCNTdMSjd3Zk9M?=
 =?utf-8?B?Z0QxSm45QmYwdjVCUnpBNm1qcnBjVEVuSEhyM0U4d2oybGxHbDFrc0JBZUpX?=
 =?utf-8?B?elI5OHRaaEc2VjF5U3ZjNFJkMFVNeVBLVk8wSzM4aGhKbUhvY3N5RDVqbVlQ?=
 =?utf-8?B?UktRamVZVlQydytmUW1vUVEzeFNkeDN4Z1IrNzZtNk1ueWVkOC9iaW8zaVB2?=
 =?utf-8?B?TitlZXJyU2FGWU8rSWFkc2ZPZDFab0I2dUNvdVlHZlJmZDZUVFpUam5ROGcv?=
 =?utf-8?B?VGhkYlBnaTNaRHVBcDBaTm9RZDdrdHlGU3RHK1JzMXhKWGpHYTd4UFlVUXFG?=
 =?utf-8?B?a3VjL1o1S1cwNGN5dzdGcHZMcFFrcTNVcEZYbGQ0VFJBbkR2ZUt2aDdncm1B?=
 =?utf-8?B?REM1OFZldG93NlpwbDRnSWZ0M1kyZnhqOHkyUVh4T0E4Zlc3OWQzSU4xYkVS?=
 =?utf-8?B?MzU1RlUrZTB6eVp3MlAzVzFUM2R5M25WSmNjb0NEVDlNK3hvZGtsWTFTZldr?=
 =?utf-8?B?SEpIczJzbFU4QW5xMzE4dUdoY3pQV3hZcDJjR3FNd3dGd3d2WHNIL2I1NVNs?=
 =?utf-8?B?VW95SXhDUVBKVUhJbk96b1JrUjdQYjBmR3VMK1Z1SDdFcFFPd2hkcmRDRldL?=
 =?utf-8?B?cFRmZ3IyRVJWejZQVWpxckhMMFpKT1lNZVNBR0U2K3hwQmdKdUxQaUl4RWRN?=
 =?utf-8?B?MUZMRFpydlFleStycDBSNklxbjdneUVCUEwwcGZsV2c5TGhydDhzOUh2VjFU?=
 =?utf-8?B?cEV4OFkxY0M5eW5KLzN1b0swNVVuU1dSZ2IvcHFiTHhGek1HMlltNjB1UWZh?=
 =?utf-8?B?eFliQmtVcG1VL3UveTJ3UmFOTW11d0xQbGhyMFoxSDRSeWsvbCtEQ2hNR2hF?=
 =?utf-8?B?TUZMekNzZnkwYkJjeGl1aDNVYjRDcm5kZy9UbDR6VzhLei9rVkt6Qyt0dVg0?=
 =?utf-8?B?WUQxSTUyYmc1OXJtZCtscGdHYkFtRGZNeFM1ZG85TTJEc3JCaHMzWTc3VU1Z?=
 =?utf-8?B?MWRVUHNNMTJ0UUttcVZSN1F2TmF5bTRlUE1CYXE4NkRiRzZuNlkxaC9KRkJ0?=
 =?utf-8?B?YVZZblhiSXoxelMraGMvUEw1aWsxcms3TlluYXVtMzIrdkxzbksxeEdjaTlx?=
 =?utf-8?B?OGxndjRNckR1QWsxeTM4N244L1E4aVc3TnpKUHZUSU0ydFRTZ1RuRmJlMWdG?=
 =?utf-8?B?QStzdmhVNEF1bE4rc25LcVRDUExaMXUyeDg5aVFWVU9taEEzVGN5NTVkeEMw?=
 =?utf-8?B?YnVoSmdIV2dCUW45eDJsekNUT1hnZlh2WHE1ejgwZkpleFZRY0lya3JzK05B?=
 =?utf-8?B?czdFd1dESW40Z05NaEw5ZmtrZVIybUsyYzVsRE9sQXllcEZyZVhlV1d1VmRJ?=
 =?utf-8?B?VU9nbkZYNDN0Q2J0YUR0QzFIUDJWeldxUVplM3ZJWjl5a3E5bFNkK25iM3Vh?=
 =?utf-8?B?Y2srQzA5Y1FwdXJ5NW9GUHZnaVUvWkExU1lycURqaEFPZ04zZnp2eXQxZ2NF?=
 =?utf-8?B?bmhKQnBpaEN5emtBekpSaHAzM1NrNlFlWVdFUnY0dlM3dkFSZkdoQVlvQ3Nt?=
 =?utf-8?B?TGFBTXgyb3JERFZieHA0bEVGWStZOHdRV1IvL25mL0Yrakt2UTUzWm5QQWJE?=
 =?utf-8?B?MVVhci9UeW8rbi82cjJDU1hSZkU3Y201dDhIbUsxVE1HK3BJYUljWDIxYkZu?=
 =?utf-8?B?dklET2VGRTQvRzRRb2p4Q2J3dk9XUTRUdExDS005aHpGdlZpMGdZT01wV3Z3?=
 =?utf-8?B?T0c2amdRN0FsaUtjZXdOVU9oUWxGTzZ2YVl2TVROaVFXU2hwcE1Idz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qB/vXPcib4PX0Br/3KSs3ECEsgWNKKEQyeN1ek3+cmImqIKZgiNsi0OMzkHdrlU9d9oVcAYbFeaYuFN4syx+IID9R/oahohPE7XX5wz2EcL+e0K+FssTkxbkQABv2HrbUpF26qnyNhfBpwFg6uneY/DHNxnk7AHZ+nLkPEJUxHSrFWv4P9hxjUOT4v9CBKflhLtpArQILZ1GpZCqvwV9050bMjBQogWXK9LUgRq+O35BLic6m4k9kALZCxHroSkoSSOPv2yoVRqeez1Ho5BfkhWb4NuYAuJd1hUgI+Sxf96/Ca3Pm3XhSwGxx+dkyE49Z+Igy0Rexw8GS/80OPry+g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2455baac-0d16-42dd-d49a-08df2dbdb7b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 08:48:16.3420 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gv06kj9BRWjGq/ao6qBitU1OGHskuU3IIu713/H5H8MvQB6xCvSc1jm/Az99tWRVodRn/+M87nWvGIugPv6UvZGTjYRtGiBPSIMdPVBcNOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8115
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjggNi82XSBpbnRlbF9pb21tdV9h
Y2NlbDogdGVhcmRvd24gRkFVTFRRIHJlc291cmNlcyBpbg0KPmJvdHRvbSBoYWxmDQo+DQo+T24g
MTAvOS8yNiAxNzowNywgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBXaGVuIGEgcGFzaWQgZW50
cnkgYmVjb21lcyBpbnZhbGlkLCB3ZSBuZWVkIHRvIHJlbGVhc2UgYWxsIHJlc291cmNlcw0KPj4g
YWxsb2NhdGVkIGZvciB0aGF0IGVudHJ5IGluY2x1ZGluZyBGQVVMVFEgb2JqZWN0IGFuZCBmYXVs
dF9mZC4NCj4+DQo+PiBXZSBjYWxsIHFlbXVfc2V0X2ZkX2hhbmRsZXIoKSB0byBkZXRhY2ggZmF1
bHRfZmQncyBpb19yZWFkIGhhbmRsZXIgYW5kDQo+PiB3YWtlcyB1cCBtYWluIHRocmVhZCBmcm9t
IHBvbGwoKSwgYnV0IHRoZXJlIGNvdWxkIHN0aWxsIGJlIGEgc21hbGwNCj4+IHdpbmRvdyB3ZSBj
YWxsIGlvbW11ZmRfYmFja2VuZF9mcmVlX2lkKGZhdWx0X2lkKSBiZWZvcmUgcG9sbCgpIGV4aXQN
Cj4+IGFuZCByZWxlYXNlIGZhdWx0X2lkIGZpbGUgcmVmZXJlbmNlLiBJbiB0aGlzIHJhcmUgY2Fz
ZSwgRkFVTFRRIG9iamVjdA0KPj4gZnJlZSByZXR1cm4gLUVCVVNZIGJlY2F1c2Ugb3BlbmVkIGZh
dWx0X2lkIGZpbGUga2VlcHMgcmVmZXJlbmNlIG9mDQo+PiBGQVVMVFEgb2JqZWN0Lg0KPj4NCj4+
IFRlYXJkb3duIEZBVUxUUSByZXNvdXJjZXMgaW4gYm90dG9tIGhhbGYgdG8gZW5zdXJlIHBvbGwo
KSBoYXMgcmVsZWFzZWQNCj4+IGZhdWx0X2lkIGZpbGUgcmVmZXJlbmNlLg0KPj4NCj4+IFN1Z2dl
c3RlZC1ieTogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0K
Pj4gVGVzdGVkLWJ5OiBYdWRvbmcgSGFvIDx4dWRvbmcuaGFvQGludGVsLmNvbT4NCj4+IC0tLQ0K
Pj4gICBody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMgfCA0MCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11
X2FjY2VsLmMgYi9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMNCj4+IGluZGV4IGNkMjI3MzE1
ZGEuLmMwN2ZmYTY4ZTAgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2FjY2Vs
LmMNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYw0KPj4gQEAgLTI2OCwxNyAr
MjY4LDUxIEBAIGZyZWVfZmF1bHRxOg0KPj4gICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gICB9DQo+
Pg0KPj4gK3R5cGVkZWYgc3RydWN0IElPTU1VRmF1bHRRdWV1ZSB7DQo+PiArICAgIElPTU1VRkRC
YWNrZW5kICppb21tdWZkOw0KPj4gKyAgICB1aW50MzJfdCBpZDsNCj4+ICsgICAgaW50IGZkOw0K
Pj4gKyAgICBRTElTVF9IRUFEKCwgVlREUFJRRW50cnkpIHZ0ZF9wcnFfbGlzdDsNCj4+ICt9IElP
TU1VRmF1bHRRdWV1ZTsNCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCBmYXVsdHFfdGVhcmRvd25fYmgo
dm9pZCAqb3BhcXVlKQ0KPj4gK3sNCj4+ICsgICAgSU9NTVVGYXVsdFF1ZXVlICpmcSA9IG9wYXF1
ZTsNCj4+ICsgICAgVlREUFJRRW50cnkgKnBycWUsICpuZXh0Ow0KPj4gKw0KPj4gKyAgICBRTElT
VF9GT1JFQUNIX1NBRkUocHJxZSwgJmZxLT52dGRfcHJxX2xpc3QsIG5leHQsIG5leHQpIHsNCj4+
ICsgICAgICAgIFFMSVNUX1JFTU9WRShwcnFlLCBuZXh0KTsNCj4+ICsgICAgICAgIGdfZnJlZShw
cnFlKTsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICBxZW11X3NldF9mZF9oYW5kbGVyKGZxLT5m
ZCwgTlVMTCwgTlVMTCwgTlVMTCk7DQo+PiArICAgIGNsb3NlKGZxLT5mZCk7DQo+PiArICAgIGlv
bW11ZmRfYmFja2VuZF9mcmVlX2lkKGZxLT5pb21tdWZkLCBmcS0+aWQpOw0KPj4gKw0KPg0KPmEg
bml0OiBhbnkgcmVhc29uIHRoYXQgeW91IG9wZW4gY29kZSBpbnN0ZWFkIG9mIHJldXNpbmcNCj52
dGRfZGVzdHJveV9mc19mYXVsdHEoKSBhcyB0aGUgZXhpc3RpbmcgY29kZT8gSWYgbm8gc3BlY2lh
bA0KPnJlYXNvbiwgbWF5IGJlIGJldHRlciByZXVzaW5nIGl0Lg0KDQpJbWFnaW5nIHdoZW4gd2Ug
dW5wbHVnIGEgdmZpbyBkZXZpY2UsIHRoZSBib3R0b20gaGFsZiBjYW4NCnJ1biBhZnRlciB2Zmlv
IGRldmljZSBhcmUgYWxyZWFkeSBmcmVlZCwgaWYgd2UgcmV1c2UNCnZ0ZF9kZXN0cm95X2ZzX2Zh
dWx0cSgpIHdpdGggdnRkX2hpb2QgYXMgaW5wdXQsIHZ0ZF9oaW9kDQpjYW4gYmUgZ2FyYmFnZSBp
dHNlbGYgYW5kIHdlIGNyYXNoIHFlbXUuDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

