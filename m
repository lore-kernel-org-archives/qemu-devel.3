Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7653D1075273
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 08:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w38iW-0005rm-Ij; Thu, 19 Mar 2026 04:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w38iU-0005rW-H2
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:26:54 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w38iR-0007fJ-OB
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773908812; x=1805444812;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Lc1lcMIMQ5L2r4fPgqXQ+gVyyrWfspcBVFWb+YzVllM=;
 b=OaQaDetAeVHOAD0pw2LhnGQ9kozH1BswT3JFSBUDj0yNuIIri4wFnMHS
 FhUxjPFr/sXG+vQt73TTD/A8kKByg19g3d5pPY3NNwOIqiDw23sXDhZby
 lD1zedEfnCgDG6jNZugZ8ZxI2OlV/cA405TBg+puDnvsSned2lpqPjlhC
 rC6r0EBoDdajOvvc4CfXgTFZxVl+ipeXotqp3sKz0QxWPOdurOghiTszz
 F5qemzXxH0NnV6R3kxzxoFOlSmpdAeu5gAx7U9Ca+OSANfmaM/Vwk31i6
 bzw7cb+FRaQRq8zW1/Vw1IFUzoa3F7+SLx8sUS+jFGinoNo+oP8YMvzU3 A==;
X-CSE-ConnectionGUID: g2PJO2QWTsG5nF7pWW28Hg==
X-CSE-MsgGUID: EhtnHrsmRZmZHf/95V1GrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85677838"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="85677838"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 01:26:49 -0700
X-CSE-ConnectionGUID: IIYTWvTKQ3OM6z4ylj7m8g==
X-CSE-MsgGUID: sCLVYdYdS76eOeQoWvCidw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="224910484"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 01:26:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 01:26:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 01:26:48 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.46) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 01:26:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNYFxUtqR6yJwoexFBiBOe+sJe0yGa+5D9cGK9sMPwtTlEQcPxLPyG5oziIJ33pK9y6nOJWz0a8LAzjKJzOL2BHqPE8KSsQdKwrxTrsc5PK/4YQJohk/DpA6McvuEj2FWpsu7lmt7KI3vlPzX5B+AcZZeTOiXBEfx8jXxGgUL0ZaLj1dY/IBqRvD23wGp8ekOcoNW/sqtl/LRdoDIA8FuuNMCamX2j+VgPzXffxMRGP81wejjLb5JiitN+q6zcunrQ7vcftauXxL5byXeMWsVVO4WjpjlszoHkb6DeqXszthjq/qMokZQgFjLAHchpXBWL4BCN8nGeL0KCUgozumEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lc1lcMIMQ5L2r4fPgqXQ+gVyyrWfspcBVFWb+YzVllM=;
 b=ZFon/06ZPbarXinKxUkm+0n1cS4mq5Gp3nzfyGdwQowPwLn7fb9jxW69fwYAZWuA3ezy6cfE+xvqTpupiiA1NYu8jPdCyV0XAoJEjv44QoCSH1oIkC5G1XKvslu36mQP585WDOyjuPLQOH6Cuz1irDWril+H3e1HvVrem99pi5pTofzccEnLmU2Fa8EK4p7Bh+QK+HlTPHk1mU3jDS0LbQL/T7ijgcLJi94JnnB0CKTJiHwlM2rzPuf3sxfdYLHZhCor1k5eUK4B/WYqL6nzVHVOCzOpiAZp8IftTAyMLerMGpXpYEIlcjSBIudsLkacr4hV8sA/0fDJhmaA6zq7QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 08:26:39 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9723.013; Thu, 19 Mar 2026
 08:26:39 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Subject: RE: [PATCH v1 07/13] intel_iommu: Handle PASID entry addition for
 pc_inv_dsc request
Thread-Topic: [PATCH v1 07/13] intel_iommu: Handle PASID entry addition for
 pc_inv_dsc request
Thread-Index: AQHcrRuZzPy+NHZDEEGZrvXfRrImE7W0TzwAgAFJ0UA=
Date: Thu, 19 Mar 2026 08:26:39 +0000
Message-ID: <IA3PR11MB913681B1F3E8A68B3049D0F0924FA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-8-zhenzhong.duan@intel.com>
 <e8843f0e-61ec-4425-ba25-62b85b0e5371@intel.com>
In-Reply-To: <e8843f0e-61ec-4425-ba25-62b85b0e5371@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SN7PR11MB7420:EE_
x-ms-office365-filtering-correlation-id: 554070c1-1c38-4d9f-49cd-08de85913e5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021|18002099003|56012099003|22082099003|3613699012;
x-microsoft-antispam-message-info: YxWj5F5B0kPtNJuSubGmAsrS/iQ5XELi4PwkIb0EtTKnu0FFlc/jK84hoht8tWudVuBm1NdmBi8wk5t5M1G7H0E4h+0Yu5DmPQHnLfL9GJ+4vEyLGTGJFA6FkfV/yfvBYDuENnrABXlNFpCqtqcXsM/zJzwQbVs/NFn3OLvX7cHZ5esIW694T3nye9dUZBB5gM8GnwPqslwa0N3/INBwJV/yo2O+S8Fop2xik5uP9wxVAEZgq47QY7lTW/QqFQEIl/M6w0fhFLefTkSYYNrxPkhoSJvRbT8YThrz5pbI01eFkk5BlS7IPzTcfpEgV8SB6iO/BA/5x3lwc4/Du0A+psOyv7qRwjIcd7Y60KLggP3w6vs4ENuSbPwRYBRwYDBDLHATrFvQu7ZZvcQgdj9O/qWfl9i+mPTxkWvezGnRNyYTkJiEvgNihjZGGnx0660OGUgG+JRY/HYP2F6SkWYKNREluRqlmTET57PNcxfbMvXgoUUVv/CT0KryhUZywaJ02CpmgW8HEsFuo2V2XAVSoUFsM1goFiFmFn4h14HDMzfRneZJhhyKcKogTnWqsfzDWf1BuXSWjTU1XEWxI5J/S1Gi+ciEOw2kPWVZYvHdoTGtLIWJyMGDE4645hOgFyD01dEACKbJRO2O0ZSijBKOC9DI1wQtbWiAHuMk6Hcc009n+TeLlAzCiYCQj6eQUHe3CwpHdJTm6bv4Wwut1KMg8Nb2hfCsLffDkGWSfXBeLR98hLBffEfDBpPBE6IFAPQ0W5KV5X2tpya8AnW8M2pavHBYRvF7WuoVP24f9+B4ogZpmyq0DXyDanBI/EFD3kN4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003)(3613699012);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjZlUUlRVml3cjFZZEpEUk9FYXlGZkgyQWhxVGFBUFpUeDBwcnNGWXc3OHNj?=
 =?utf-8?B?RVdkT2tub2U3d3lpcC9hWG43eVp5a1FrRXZZbzczb1dQdDJFOXVyMmx1eS9H?=
 =?utf-8?B?ekNuWEl2dzdlWFJpTWtDYTBieXh0andsRXNpa2dBR2V3cEM5bFJ6R1lKVEdZ?=
 =?utf-8?B?UWx0cHhhUFpQczdBUHFtRDJlZ0VSbU5LSTRBR1BaOHlhMlM0dnQ2Z0lLS3Q4?=
 =?utf-8?B?TTVKWDdoMFUvQW91bFRrYTU2R1Bwd2JNdFVPN3BtNWFWY3ZqcEdtVUMrcUVq?=
 =?utf-8?B?dWlkbTN3U2E2YjZhVEtwVU05ZkhFZmliZStNVnFENVFPNnBBWFlCbGc3VnRS?=
 =?utf-8?B?dlNjekpTSW5JZXNOWWI2L001WlZsTlVtTUhMNTJrcmhBNHRTOE5Yb1hNYXk4?=
 =?utf-8?B?amN1bVA4d2lkTlRmRkFpVnlVZi9tcFJnQzE4ampEdVc2U2xMSzlSdVpuN01Y?=
 =?utf-8?B?WmFzUllsYXFaOGdkZGNzQVBaeHNYZ2FTNTdaWW1SOUtXUDlqdTZkVTVKYWRO?=
 =?utf-8?B?WUZJbmtDKzBmeWFnZkFBVkIvQ0J0enVnY2xvSDRkUTFrN3o3MDVUdnlIN0Ex?=
 =?utf-8?B?N2phZmxtS3JURUUzbVdMaFF2UjBFSFZuR09GelpUcmNuTytuR09TVkg0bHFB?=
 =?utf-8?B?N2xOWlJLcDk3OC84WFlMM0hXM0k2amw3VlBJNmVJN1RueVJGUW1GcjJ2Z3VH?=
 =?utf-8?B?UmxNNThldlNOOHlrY2hWdkNRSDExaTJxbjlIYmdHOVRLN21BZXFZeTdneVFK?=
 =?utf-8?B?Wm1TSllmaFVSZ3FKeE9mYXNxWENnUFBHV1BpeVFhanF1UkU2eFUwYzI3QVRw?=
 =?utf-8?B?ZWV0ZUhZN1YwMVF1WG1na01FV21nU1hYd05yTGY3eUVtOEhuSUY1cEgvRGFu?=
 =?utf-8?B?S2V3Wi80aFg2cC84SktWdmk1TVBxYk9JMzlpUzdQYWhQd25MOVpnN3M2OGVo?=
 =?utf-8?B?cW8wUXdPQ1cxcVhzZFdsYUlzWDhlenIzVm5aVTFTYlRCczZhb28xRnlqVTZl?=
 =?utf-8?B?OEdHdkJrRk9RTWJtcWFqZW9vSVZ3SThERlQvcHZvY0pyVDFKbCtEWnNDY2Y4?=
 =?utf-8?B?UlA0OXBHTER4R3BKU1dSNUZSazNMaXh2NVZEV2prYWV0UkpRU2ZmS0pXd2NS?=
 =?utf-8?B?MGJac2VlejFaalBYMWlveTU4QkNjMVVtcVQ2UXh1L1RsN3IvckVvK1JlZTRZ?=
 =?utf-8?B?emk3RGlBanluMDNhME1IMVViUnN4VXhKWmI2TVFjc2k1WE56TWZHeGRpR0NY?=
 =?utf-8?B?aGZ1dGhxRU13UDZyYzcvSW16dDJXU0lzUnR2MGVRTWQ1T3lnQ1M4WGtuWlZD?=
 =?utf-8?B?R0o2M0U4MXBOVXNjSzlXNFR6RWl3V09tVVZMemlqb3IvZXMydENlcU9vWWYr?=
 =?utf-8?B?S2x3czlIZ05kejZ1MUQwL2NQVVpFdHJlRitZcCtFNnZnRVN3YlZFWG5nK3R6?=
 =?utf-8?B?YnI5U05RS0dJdVdma1RyR2UxYmRnMVJZenZzUmttbFBBMHlIM2p0YlB3SzlI?=
 =?utf-8?B?UkgyalZKWCtsam5ScE9wV0NMMWw4YUZxODl4elRLbXBGRUdnajBSRjRqZ3pB?=
 =?utf-8?B?Q3pSTDdMbFBTVkhUUW90UlI5dmZCL0xWR2lDSjBtTVA0WnZheUtGQVQyNUJW?=
 =?utf-8?B?YkEydi93cEcrUkNycEZJdXZqdmV0LzNnZURld3RaVHJ3VmRVTXkyWXJITGQ4?=
 =?utf-8?B?d2s1VkkzcndVSndDK2U5Zm1URUxaSmVNSGtFZUR3NEpWRmN0U2prK2VKMmZ6?=
 =?utf-8?B?OUlmZ244WHVzSlRTYnlWZ08vc25EUm5kbHQ0Zy9OK2pkSFlvaWNKTjhnVit3?=
 =?utf-8?B?dDVKL1ZRd0dJbm9rV0c4eG95Y3pjbENxY0E2cmprNVA3dVE0OGxrSExBNXox?=
 =?utf-8?B?SHV5clBvTGtJYjNLTXhDc202elpvZTRmMDVVaGxUc2RWcUpjVExoMzRZWkQx?=
 =?utf-8?B?N3cyL1EyWXA1NVQ5bTFHMGpzc3hsQm8yMHJidGliRjR6S3RhT292TUI4bksz?=
 =?utf-8?B?TzdrN2hRSE0xeGNyZnpHNHVZcjNXdXpCcjZjUGE3WU51UWp5RzROeXFIZ05J?=
 =?utf-8?B?ZFpMb1U3ZXA0UGFZdG0rSU9uOVc5ekZ2TUp2dDVOZnNnejBDeWtqRHVXMmRv?=
 =?utf-8?B?aU9PUGtFbFNPK0VKVGdIUTVzdVUxd3p6b0ZjVStUa0NMY3M0SW9SUTFBSzIv?=
 =?utf-8?B?Sm5QOHY4RGJvMjFheVpVV1R0dC9CeTBidERPTStqQldqNDc4SlM3bWFxTG9M?=
 =?utf-8?B?eDVYd3BaZjRhem1GU3hKUzVMR2x6ZlZpR1RKNGI1QVMxYnlTd0NtTHlmVVU0?=
 =?utf-8?B?V2RrTVFPMm5PRWhOWDFPcjZNZGszY3ByMnRBa2dyOU9rMHZoRWhqdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XuZ53g2qVzFtf2dHR4uvwuKFHgItQvnq2CB4RttAK7F11lWvp4GWDP6ri9orRwo2J5R+etH6nwBlVmdRZyIdQAI7Fu2NLPac3+957nXswlo0Dl9a5ZkoBNS4vU7dnt/AwOFzy+bppiOlVcp+jI/TfKS+ZYHASZ0a8JskE0VOrs2ofe6qkyURnrClr/m6MyA3YlDqQ5sZQRRoddTGTczo8baLs8rZo/4ic6Xbg0KOZRSfNB9BH8SAJiw0NCETHEzZO5PA/bod4MWnNuXiCAL7+yAFFx9hOC2KEUfwD/4yF/a2ZDsXvBz96cvKu/b2fZxZIFlRqm34sLxUvorq4pS5uA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 554070c1-1c38-4d9f-49cd-08de85913e5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 08:26:39.6241 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XfgHlPSnbiPyEodC5NPACKyafv5kE+0LogeEbExNxrb3ah2pF4n8SDYMJNdqsoBpCLnG82RyFj3ZKi4VdA/k2FZChoPnQYRh0/k5Xzd0/CY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7420
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDcvMTNdIGludGVsX2lvbW11
OiBIYW5kbGUgUEFTSUQgZW50cnkgYWRkaXRpb24gZm9yDQo+cGNfaW52X2RzYyByZXF1ZXN0DQo+
DQo+T24gMy82LzI2IDExOjQ0LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IFN0cnVjdHVyZSBW
VERBZGRyZXNzU3BhY2UgaW5jbHVkZXMgc29tZSBlbGVtZW50cyBzdWl0YWJsZSBmb3IgZW11bGF0
ZWQNCj4+IGRldmljZSBhbmQgcGFzc3Rocm91Z2ggZGV2aWNlIHdpdGhvdXQgUEFTSUQsIGUuZy4s
IGFkZHJlc3Mgc3BhY2UsDQo+PiBkaWZmZXJlbnQgbWVtb3J5IHJlZ2lvbnMsIGV0YywgaXQgaXMg
YWxzbyBwcm90ZWN0ZWQgYnkgdnRkIGlvbW11IGxvY2ssDQo+PiBhbGwgdGhlc2UgYXJlIHVzZWxl
c3MgYW5kIGJlY29tZSBhIGJ1cmRlbiBmb3IgcGFzc3Rocm91Z2ggZGV2aWNlIHdpdGgNCj4+IFBB
U0lELg0KPj4NCj4+IFdoZW4gdGhlcmUgYXJlIGxvdHMgb2YgUEFTSURzIHVzZWQgaW4gb25lIGRl
dmljZSwgdGhlIEFTIGFuZCBNUnMgYXJlDQo+PiBhbGwgcmVnaXN0ZXJlZCB0byBtZW1vcnkgY29y
ZSBhbmQgaW1wYWN0IHRoZSB3aG9sZSBzeXN0ZW0gcGVyZm9ybWFuY2UuDQo+Pg0KPj4gU28gaW5z
dGVhZCBvZiB1c2luZyBWVERBZGRyZXNzU3BhY2UgdG8gY2FjaGUgcGFzaWQgZW50cnkgZm9yIGVh
Y2ggcGFzaWQNCj4+IG9mIGEgcGFzc3Rocm91Z2ggZGV2aWNlLCB3ZSBkZWZpbmUgYSBsaWdodCB3
ZWlnaHQgc3RydWN0dXJlDQo+PiBWVERBQ0NFTFBBU0lEQ2FjaGVFbnRyeSB3aXRoIG9ubHkgbmVj
ZXNzYXJ5IGVsZW1lbnRzIGZvciBlYWNoIHBhc2lkLiBXZQ0KPj4gd2lsbCB1c2UgdGhpcyBzdHJ1
Y3QgYXMgYSBwYXJhbWV0ZXIgdG8gY29uZHVjdCBiaW5kaW5nL3VuYmluZGluZyB0bw0KPj4gbmVz
dGVkIGh3cHQgYW5kIHRvIHJlY29yZCB0aGUgY3VycmVudCBiaW5kZWQgbmVzdGVkIGh3cHQuIEl0
J3MgYWxzbw0KPj4gZGVzaWduZWQgdG8gc3VwcG9ydCBQQVNJRF8wLg0KPg0KPlBBU0lEXzAgb2Yg
cGFzc3Rocm91Z2ggZGV2aWNlIHN0aWxsIG5lZWQgdG8gcmVnaXN0ZXIgTVJzIGluIGNhc2UgZ3Vl
c3QNCj5kb2VzIG5vdCBvcGVyYXRlIGluIHNjYWxhYmxlIG1vZGUuIFNvIGZvciBQQVNJRF8wLCB5
b3Ugd2lsbCBoYXZlIGJvdGgNCj5WVERBUEFTSURDYWNoZUVudHJ5IGFuZCBWVERBQ0NFTFBBU0lE
Q2FjaGVFbnRyeS4gSXMgaXQ/DQoNCkV4YWN0bHkhDQoNCj4NCj4+IFdoZW4gZ3Vlc3QgY3JlYXRl
cyBuZXcgUEFTSUQgZW50cmllcywgUUVNVSB3aWxsIGNhcHR1cmUgdGhlIHBjX2ludl9kc2MNCj4+
IChwYXNpZCBjYWNoZSBpbnZhbGlkYXRpb24pIHJlcXVlc3QsIHdhbGsgdGhyb3VnaCBlYWNoIHBh
c2lkIGluIGVhY2gNCj4+IHBhc3N0aHJvdWdoIGRldmljZSBmb3IgdmFsaWQgcGFzaWQgZW50cmll
cywgY3JlYXRlIGEgbmV3DQo+PiBWVERBQ0NFTFBBU0lEQ2FjaGVFbnRyeSBpZiBub3QgZXhpc3Rp
bmcgeWV0Lg0KPg0KPkkgdGhpbmsgdGhpcyBpZGVhIGlzIG9rLCBidXQgd2UgbmVlZCB0byBiZSBj
bGVhciBhYm91dCB0aGUNCj5ib3VuZGFyeSBiZXR3ZWVuIHRoZSB1c2FnZXMgb2YgdGhlIHR3byBw
YXNpZCBjYWNoZSBzdHJ1Y3R1cmVzLg0KDQpZZXMsIHRoZSBwcmluY2lwbGUgaGVyZSBpcyBWVERB
Q0NFTFBBU0lEQ2FjaGVFbnRyeSBpcyBvbmx5IHVzZWQgaW4gaW50ZWxfaW9tbXVfYWNjZWwuYywg
VlREUEFTSURDYWNoZUVudHJ5IGlzIG9ubHkgdXNlZCBpbiBody9pMzg2L2ludGVsX2lvbW11LmMg
ICAgICAgICAgDQoNCj4NCj4+IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwu
Y29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGlu
dGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmggICAgfCAg
MTMgKysrDQo+PiAgIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8ICAgOCArKw0KPj4g
ICBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCAgIDMgKw0KPj4gICBody9pMzg2L2lu
dGVsX2lvbW11X2FjY2VsLmMgICAgfCAxNzAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+PiAgIDQgZmlsZXMgY2hhbmdlZCwgMTk0IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5oIGIvaHcvaTM4Ni9pbnRlbF9pb21t
dV9hY2NlbC5oDQo+PiBpbmRleCBlNWYwYjA3N2I0Li5hNzdmZDA2ZmUwIDEwMDY0NA0KPj4gLS0t
IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5oDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lv
bW11X2FjY2VsLmgNCj4+IEBAIC0xMiw2ICsxMiwxMyBAQA0KPj4gICAjZGVmaW5lIEhXX0kzODZf
SU5URUxfSU9NTVVfQUNDRUxfSA0KPj4gICAjaW5jbHVkZSBDT05GSUdfREVWSUNFUw0KPj4NCj4+
ICt0eXBlZGVmIHN0cnVjdCBWVERBQ0NFTFBBU0lEQ2FjaGVFbnRyeSB7DQo+PiArICAgIFZUREhv
c3RJT01NVURldmljZSAqdnRkX2hpb2Q7DQo+PiArICAgIFZURFBBU0lERW50cnkgcGU7DQo+DQo+
bGV0J3MgdXNlIHBhc2lkX2VudHJ5IGhlcmUgYXMgd2UgYWxyZWFkeSB1c2VkIGl0IGluIHRoZQ0K
PlZURFBBU0lEQ2FjaGVFbnRyeS4gU29tZXRpbWVlcywgaXQgbWF5IGhlbHAgd2hlbiBmb3Igc2Vh
cmNoaW5nIHJlbGF0ZWQNCj5jb2RlLg0KDQpHb29kIHN1Z2dlc3Rpb24sIHdpbGwgZG8uDQoNClRo
YW5rcw0KWmhlbnpob25nDQoNCg==

