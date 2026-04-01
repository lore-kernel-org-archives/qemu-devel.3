Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24599D35160
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7rnU-0007PF-N5; Wed, 01 Apr 2026 05:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w7rnT-0007P7-3Y
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:23:35 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w7rnP-00054Y-HE
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775035411; x=1806571411;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ARPUxYOMCbgr4vKsaDrnSE208dAjOd+hCSk/sbDRbRk=;
 b=C2TB/X8NEcqko0sVo5jNBAFmz2emAW9XpF0ufVjqjQIGjQS8A9iM8iEk
 Z6f+knGFPb5yDNIAABRoZPSgEhA8/NCpanLE8sQ4eh26p05Pz/sUo/JWC
 8JvDK9w3HAgVRybricOSxR7jab7NdoieGwpkNb1Qk/SgHRzV5o3xwLZ3L
 9naPoeQm/vEik67oG4I0QzaGiATqVpHEj91CcNFKNjegybN24czU5v1GO
 Hv6lGnCKYCGNmWw+5yPMNWD9NXo5m/FwbhSfvPo5z/YDERVYDnE+Uw6CM
 /OD9xGR+MRdSXDVr3U4MrNZC3IhYdN8GZtRhzqPA97jGTyxReZT4pqTDp Q==;
X-CSE-ConnectionGUID: bBwxos2NQ3qIBvtzAF1Lbg==
X-CSE-MsgGUID: wcph6HxcTXi+YxGmA/V3pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75240244"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; d="scan'208";a="75240244"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2026 02:23:28 -0700
X-CSE-ConnectionGUID: h/Ieu0L/S9iq1EBu8CrBJA==
X-CSE-MsgGUID: XArbjXHYRbiNWf1c8Tkpxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; d="scan'208";a="228236997"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2026 02:23:28 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 02:23:27 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 02:23:27 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 02:23:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bh+b22NBN0p/mf29/cOw4VhB6H1FD2pqHYREQZRKRIl/sPcuhuKmxw1TiefFbpCsbgJsOyLstnsAnwitIBvxaAIPdzpQyFFbBFWQ4Kq/ek3IegvBMK6l1pqNTg4h8ubXEv+PH7rPqyGhvBHummKUXNtPEJLn4fVOEI4xm4ABREUFu5VJFRNO0o6Iw3LHYg4WBDN+s1FxqbRIcoPpEm01EfQQKdzx5ZB4FzTK/jGJqvULHQ8w2Ugu+0S27Rt//V1Wi+7NlBJe7W5a7B+q3EOn9LkvJrLulOWPiMFcpzfQ6xLoJhQUMBJ7DY+F3noY2vpM+BYgWNYmJYyLE2XLkytTiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARPUxYOMCbgr4vKsaDrnSE208dAjOd+hCSk/sbDRbRk=;
 b=fSnexlOc2MhviD3ALG7fHVJyhZMiaF5R4smDOtkG7oUoEJZxrS47iH+TyIao8oKS21CDGKJkvlvHeJcnOKk38SjaLh0ammxVtcCOkI+1EqVAmcC7FibdybOHqjmLkwXRAqWLGNUEMbnG1+MKTC9HecowOpVNX2Y91f7/aLknIguKMiCIoEDFnhwXQZg+BtNXtC/7J4EfP4XaEdi/u1LHgE+xR0wTXdAmoelcsd53VDyKOEm4ZyXfpBmByYZuZiQc/s4veU0z4i6kfETw581CWe79rtXSVLcBvq0dW5R1TS/O5HqFJs41zi91aH5iqlpEfVQFRpXAC1rNah+qWCmreA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SN7PR11MB7418.namprd11.prod.outlook.com (2603:10b6:806:344::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 09:23:21 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9769.011; Wed, 1 Apr 2026
 09:23:21 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: RE: [PATCH v1 11/13] intel_iommu_accel: drop _lock suffix in
 vtd_flush_host_piotlb_all_locked()
Thread-Topic: [PATCH v1 11/13] intel_iommu_accel: drop _lock suffix in
 vtd_flush_host_piotlb_all_locked()
Thread-Index: AQHcrRueV4S7cttZ6U6X0YZKvVaD9bW1kyWAgAAOusCAASn/8IARjtSAgAAGb3CAAaT2gIAADsPg
Date: Wed, 1 Apr 2026 09:23:21 +0000
Message-ID: <IA3PR11MB913614688F3DE7F70A09089A9250A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-12-zhenzhong.duan@intel.com>
 <1b2b191e2f9f1315c883ed2de4fb9644a01c8713.camel@eviden.com>
 <IA3PR11MB9136F0D294E9FBE576E0CF91924FA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <IA3PR11MB9136B3C106DDF70856F27FE6924CA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <bdc0f51e1496c841a4f3392ec3e775e6a69b57e1.camel@eviden.com>
 <IA3PR11MB913601196392D72E02E5AB579253A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <fb14a3f7f49e98683b666084aa3ae10b36ee4282.camel@eviden.com>
In-Reply-To: <fb14a3f7f49e98683b666084aa3ae10b36ee4282.camel@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SN7PR11MB7418:EE_
x-ms-office365-filtering-correlation-id: 4fa62e99-1e71-4be0-f6cc-08de8fd0516b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: NaY6BBL30I6ROrNIdzhsU+m8tev9d47ccweNd2af2MCAJo5i7tXuvMg5GfXJEqsgPXHZR8oJUYVRVA2BsTb/sxlTspysr81xKXvu7LEJ1PV2F75m1INhVrDWpF4/yTc6kO9oDryTZ2ruqAFj2S4SFJ59KJ0Pz9tZoHSeSUBYNkhsHKu/XEanX5R76LQwruO8teZk+sZtVB7hYqNtcz/pE2IYuW/0t7p5gqT0LW4ZDsqZhAC1UR3ekbIJ3UlnixDCJ2/VNg3owqtBZ04wN437OyagJla7VzIlbPqFkWAdP2QLcZuzzzVT13RQrvoVrKkNOudqSFS/vTdzGMK1HnnxPb9Jo3EG7w9XX1pAcsb58SZJmnC8TWF4jnBK+fjB+O0Pw+U2JezN2Ho+srSkJ0zCH3/krYbICveyyNuUoeRhEgOEiX0yVhHVPPdntREgfIRL8sx/Ck9OchY+W2HUkiBqg2reO1rmxYqVzsJvJkg1ZJi+kYEuv+FVOOFp1SrYiljN9e+Ca3si3KN90EYSaOc1ZVlBP4D+DSkt27m3lsxvuVynp9saME1heLlgNUmET5UmuL/K8TMWd3YZyvb/7RU4xgrEt5057/VBDGsh3GwXblRyq6bx+sogngUCU+M9p14OQ9++3nrGJHe6iKLJLeRd/NuVFNlbEqf7QOBb1XB9Nbp4km5mgC6E2RIbjtApc2idUbE2nYzU9xWL1onFb7ZfbZrN2Xyf8DpkmkT9VysmSFBroNFNRU2Q5WVudXQBydfM41FEU1pGQXUPToUBtmBLYkWA1iXpPtZ3lotvGFqjYJY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWJ2M1dmWXZpcERLV05DSGhzRnZSQnNWV1U3a0QrdXRWTDlaQzA4bjlsaDRh?=
 =?utf-8?B?a3Z0ZEwvWnFzbm9mdXdGMEoyTkpjRHlQb0lNN3EvdjVGOERaOHR6OUZEREkz?=
 =?utf-8?B?alZNZG4yS0pIalprVU01emk0aG5RQ2haU3U5eGI1dWsrcXVPNFpPeDJlVFR3?=
 =?utf-8?B?ZjdzdmZsSWRNUS9URm5lYUxOY2JFL0NZV08rcW9DK01ReVM3RkExVUw3NXMz?=
 =?utf-8?B?ZXZMQ2Q4emxjamNBbUtGQzBUdXNZd0VaeEJsQlFnZVlzaEUrRFNyMjdLQXRt?=
 =?utf-8?B?UVJpMWVzS0ZrRlRPR3JvV1dvVDhLZStVMm9oZFkvbnZVM0NoYjVKQWtyZlFz?=
 =?utf-8?B?NkZTZVByTTE4d3gybWtNb0FtSmE2Q3ovNncra2taa2VmNzQrWHVPZjh6cENu?=
 =?utf-8?B?WHZFem5CYXBRY0FUWWxISEpIbXpzd1l2ZXQ2Mm8vd1M3WHdBVWhBQzBMVUI2?=
 =?utf-8?B?NDFxeXkrMG40RmVyNEtaZkZuS1FCY3U4aUMvSTNXdEcxL3d1VTQ5N2Uxam9k?=
 =?utf-8?B?YkVBbU56NEVISW9weHlSbUo2c0c0cG9yZ3pjanlpMS92b2tHeGVSS0dlSHBn?=
 =?utf-8?B?bjJzY0xqakJ2bk5GMUJ6SDJtV1lrZEQwTktzOW5nUnRsU2xUdjJZVWZPWFpX?=
 =?utf-8?B?ZmkwQXZ6bWJ3Y0EwRjZDQTdERDlHbVlKQlNmYWxIL0d3WjY3TnVjaThQWnlE?=
 =?utf-8?B?WHRSVDJRQW5JaFg1dmJ0cEQ3RUxyb0cwWlFtMUVCalphMGhIMFVqQnV3dEJQ?=
 =?utf-8?B?NlVHM0YrTkFyTEQ4WnRMS0N1MVRYdGY2UmEzdXgxODFQUWdCcHVzRHlRMlI3?=
 =?utf-8?B?aW9xU0t0TjdDdmhQc0d4Mjk5Nm9YYWlMc2hZYURBeXgyUlE4dThYZG9yYkFJ?=
 =?utf-8?B?OGJFOHo4UEhVSXYrZW9IaVZEdmUrWUdpbWxZenk5d1NXUUZaby9aY01HNmxj?=
 =?utf-8?B?VmVpZWhoTGlSRFdYbGdrSFliWUpaRnV0Rzk2bmxUN012aVBJTFcxODNOVGh3?=
 =?utf-8?B?MEF0QjBFT0h3TzVLOFEweDc5aEwzTkNwTW0wNEs3K1J6YkRFQVU1cGlWcFRL?=
 =?utf-8?B?YXFUaDdmUnlBOU5OdHh0elNoNHJXTmNIY3NhME4wcEdTTzNSUjN0YWZOMWdj?=
 =?utf-8?B?b3d0ekpCOXc0c1BmMno3UUZpR2VIcGlRbkoxQUUzd2JUMVBtNGFWc1h6Q2Nh?=
 =?utf-8?B?SzBUWHVPNGQvdjlZYjVSclorLzhSWUVBNWRtTkJEbWQ1QXZNdXpHVzhDRkJ5?=
 =?utf-8?B?bCswdUgrbXNEWGpXT3pQQzViTkVNTUNRdmZhdFN0VFBpZTJqZzkyVVNxSjdt?=
 =?utf-8?B?N2ZkN1VPL3RNc0pmU1dCcHhJelU0L04wa3VpOCtyeXIxd0hXZVZiOWlrVHpH?=
 =?utf-8?B?Z3pMNGNERWxQQlQrK29uRjZZeGIxZVJtT0hONDcxaEZaMGtaUHZ4WGJHT0R6?=
 =?utf-8?B?WkR1S29POFhlejVjUURpSFhFNUczR3hIVW5reWlSNWtTRnhNQjI3ckNQQXRK?=
 =?utf-8?B?eUNzZEhRYlV5QmowbHFxLzhEU01QTnZqeVl0MXVhaVQ4dEhSMThhdDNMQ0Zj?=
 =?utf-8?B?S2xDYUowNTJVNjJ6R0NpWW9BTVBzaEsvYjVQY3BaUHJsOUNFek5qbEx0NVlT?=
 =?utf-8?B?eGZQdUFmN0kxekpUdVBiL0psWUtqcWdIeVUxK09yQjd4eVdnYkp0dzlJWEh6?=
 =?utf-8?B?NjVlMEovSW8yckVxTTZZVG0wT3VHWTlIVVM0WFBnb3RiNFNHQTNCWVlZUHoy?=
 =?utf-8?B?US9MaGJZU3N1VXo3cmR5MzRENXhZaVhtbjRJOXg3a0JySDY1aGhkWjhhMUV5?=
 =?utf-8?B?Y3ZZaHI4WnFLUEdQblYwaEtHb3VaVXBGYVQyY3hEeE5odHB6ZTduSXp5d1FC?=
 =?utf-8?B?QStsdkFWbkk3L1loK1I2ZktnbVRKZlVZeHo0ejJpc3NMMW1qQ3BucGltOUU3?=
 =?utf-8?B?R2Y3TlpjMzF2cFo4aHJRRzgvOCtGV0hnbWo3YlVOYTVUUzB1eVlzTTN3d3RT?=
 =?utf-8?B?cndZa2hoV3lKTnp0MWdPVDYxSENKV1BIaUw2MzRxaUIyK0NLNFphNDROQmho?=
 =?utf-8?B?cmZoYTArNS9pdWR5NytxYUpVYU80ZnBQMy9rVnllaWREYmJkVmp0aE9Ec2c3?=
 =?utf-8?B?cFBUalFNZWhVdkE5YXJyL3BLcjdqK2FtanVsRS84NjZ3c3p5bFVsSGE3ckJu?=
 =?utf-8?B?bm42bE85VWVHamNYQjdYSUFCL1RkcHNRczd5Wi9ERjdhYnZYWlRCN3VWRi9h?=
 =?utf-8?B?OTIraTJiekNaV3kyNzVkODc5SXY2ZllaMzNmbHhVeWYrUWY1NmZDUS80OFJk?=
 =?utf-8?B?amZiMjdGTzZxSzhFdC9uTnB5ZndSekNPK2MyZzZJdVFZOFVPZDdLQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Dcu5ydVqFXdVdJmc8O2zpH0u+MU1IZMwtJKo7mq9zzNGUMHeHCEUHcFT+TPVfCLba03y/q4zovZSQ6/EX5ngJPZJJZ53T5PjWvxKazEBnKDDfFmI8dZRlduCBufwDhAowPw1LUMQmaU/Eb9lVS1tTsg12ox0PhySRIX+YddVOgJv8EgHzDHUWCQ1xXdzKi+HN5cr9jb39Q6De97vwZV4lqqfHURCg7EAaHPITXqr4YDFDW3SRhjErY6Jughsmdrk9j/Aj91U49zmwHBPs8WaeUcaELjseF7sc5+jJG2oh1Ps+4+XQ6uV/vA+TZvFbXyo2RMz/RVWFq+9G2wz1i1Wsg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa62e99-1e71-4be0-f6cc-08de8fd0516b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 09:23:21.4589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: odANKK8/7UFdTw0+nn/gdXVg+1rDofCpFPwt/quIACioho6FpxI4soTC6Le6B6Gagr1tKYQD+q2rskq7ezlryqeB0PGqRnuaY4qsXUzR73o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7418
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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

SGkgQ2xlbWVudCwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ0xFTUVO
VCBNQVRISUVVLS1EUklGIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb20+DQo+U3ViamVj
dDogUmU6IFtQQVRDSCB2MSAxMS8xM10gaW50ZWxfaW9tbXVfYWNjZWw6IGRyb3AgX2xvY2sgc3Vm
Zml4IGluDQo+dnRkX2ZsdXNoX2hvc3RfcGlvdGxiX2FsbF9sb2NrZWQoKQ0KPg0KPg0KPk9uIFR1
ZSwgMjAyNi0wMy0zMSBhdCAwNzoxOCArMDAwMCwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4N
Cj4+DQo+Pg0KPj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4gPiBGcm9tOiBDTEVN
RU5UIE1BVEhJRVUtLURSSUYgPFtjbGVtZW50Lm1hdGhpZXUtLQ0KPmRyaWZAYnVsbC5jb21dKG1h
aWx0bzpjbGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb20pPg0KPj4gPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYxIDExLzEzXSBpbnRlbF9pb21tdV9hY2NlbDogZHJvcCBfbG9jayBzdWZmaXggaW4N
Cj4+ID4gdnRkX2ZsdXNoX2hvc3RfcGlvdGxiX2FsbF9sb2NrZWQoKQ0KPj4gPg0KPj4gPg0KPj4g
PiBPbiBGcmksIDIwMjYtMDMtMjAgYXQgMDQ6MDQgKzAwMDAsIER1YW4sIFpoZW56aG9uZyB3cm90
ZToNCj4+ID4NCj4+ID4gPiBIaSBDbGVtZW50LA0KPj4gPiA+DQo+PiA+ID4NCj4+ID4gPg0KPj4g
PiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+ID4gPiA+IEZyb206IER1YW4sIFpo
ZW56aG9uZw0KPj4gPiA+ID4gU3ViamVjdDogUkU6IFtQQVRDSCB2MSAxMS8xM10gaW50ZWxfaW9t
bXVfYWNjZWw6IGRyb3AgX2xvY2sgc3VmZml4IGluDQo+PiA+ID4gPiB2dGRfZmx1c2hfaG9zdF9w
aW90bGJfYWxsX2xvY2tlZCgpDQo+PiA+ID4gPg0KPj4gPiA+ID4gSGkgQ2xlbWVudCwNCj4+ID4g
PiA+DQo+PiA+ID4gPg0KPj4gPiA+ID4NCj4+ID4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4+ID4gPiA+ID4gRnJvbTogQ0xFTUVOVCBNQVRISUVVLS1EUklGIDxbY2xlbWVudC5t
YXRoaWV1LS0NCj4+ID4gPiA+DQo+PiA+ID4NCj4+ID4NCj4+ID4gW2RyaWZAYnVsbC5jb21dKG1h
aWx0bzpkcmlmQGJ1bGwuY29tKV0obWFpbHRvOltjbGVtZW50Lm1hdGhpZXUtLQ0KPmRyaWZAYnVs
bC5jb21dKG1haWx0bzpjbGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb20pKT4NCj4+ID4NCj4+
ID4gPg0KPj4gPiA+ID4NCj4+ID4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAxMS8xM10g
aW50ZWxfaW9tbXVfYWNjZWw6IGRyb3AgX2xvY2sgc3VmZml4IGluDQo+PiA+ID4gPiA+IHZ0ZF9m
bHVzaF9ob3N0X3Bpb3RsYl9hbGxfbG9ja2VkKCkNCj4+ID4gPiA+ID4NCj4+ID4gPiA+ID4gdnRk
X3Bpb3RsYl9wYWdlX2ludmFsaWRhdGUgY2FuIGJlIGNhbGxlZCBmcm9tDQo+PiA+ID4gPiA+IHZ0
ZF9wcmlfcGVyZm9ybV9pbXBsaWNpdF9pbnZhbGlkYXRpb24gd2l0aG91dCBhbnkgbG9jay4gVGh1
cyB3ZSBjYW4gY2FsbA0KPj4gPiA+ID4gPiB2dGRfZmx1c2hfaG9zdF9waW90bGJfYWxsX2FjY2Vs
IHVubG9ja2VkLiBJcyB0aGVyZSBhIHJpc2sgaW4gY2FzZSBvZg0KPj4gPiA+ID4NCj4+ID4gPg0K
Pj4gPg0KPj4gPiBjb25jdXJyZW50IGhvdA0KPj4gPg0KPj4gPiA+DQo+PiA+ID4gPg0KPj4gPiA+
ID4gPiBwbHVnZ2luZyBvZiBhbm90aGVyIGRldmljZT8NCj4+ID4gPiA+DQo+PiA+ID4gPg0KPj4g
PiA+ID4NCj4+ID4gPiA+IEdvb2QgY2F0Y2gsIGhvdHBsdWcgaXMgcHJvdGVjdGVkIGJ5IEJRTCwg
YnV0IGlmIGFuIGlvdGhyZWFkIGNvdWxkIHNlbmQgUFJJDQo+PiA+ID4NCj4+ID4NCj4+ID4gcmVx
dWVzdCwNCj4+ID4NCj4+ID4gPg0KPj4gPiA+ID4gd2Ugc3VmZmVyIGZyb20gdGhlIHJhY2UuDQo+
PiA+ID4gPg0KPj4gPiA+ID4gSSB0aGluayB3ZSBjYW4gYnlwYXNzIHZ0ZF9wcmlfcGVyZm9ybV9p
bXBsaWNpdF9pbnZhbGlkYXRpb24oKSBmb3INCj5wYXNzdGhyb3VnaA0KPj4gPiA+ID4gZGV2aWNl
DQo+PiA+ID4gPiB3aGljaCBkb2Vzbid0IGNhY2hlIGlvdGxiIGVudHJ5IGluIFFFTVUgYnV0IGlu
IGhvc3QsIGxpa2U6DQo+PiA+ID4gPg0KPj4gPiA+ID4gQEAgLTU0MDEsNyArNTQwMSw4IEBAIHN0
YXRpYyBpbnQgdnRkX3ByaV9yZXF1ZXN0X3BhZ2UoUENJQnVzICpidXMsDQo+dm9pZA0KPj4gPiA+
ID4gKm9wYXF1ZSwgaW50IGRldmZuLA0KPj4gPiA+ID4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1F
Tk9TUEM7DQo+PiA+ID4gPiDCoMKgwqAgfQ0KPj4gPiA+ID4NCj4+ID4gPiA+IC3CoMKgwqAgaWYg
KHZ0ZF9wcmlfcGVyZm9ybV9pbXBsaWNpdF9pbnZhbGlkYXRpb24odnRkX2FzLCBhZGRyKSkgew0K
Pj4gPiA+ID4gK8KgwqDCoCBpZiAoIXZ0ZF9maW5kX2hpb2RfaW9tbXVmZCh2dGRfYXMpICYmDQo+
PiA+ID4gPiArwqDCoMKgwqDCoMKgwqAgdnRkX3ByaV9wZXJmb3JtX2ltcGxpY2l0X2ludmFsaWRh
dGlvbih2dGRfYXMsIGFkZHIpKSB7DQo+PiA+ID4gPiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJ
TlZBTDsNCj4+ID4gPiA+IMKgwqDCoCB9DQo+PiA+ID4NCj4+ID4gPg0KPj4gPiA+DQo+PiA+ID4g
QWZ0ZXIgZnVydGhlciB0aGlua2luZywgSSBmb3VuZCBhYm92ZSBjaGFuZ2UgZG9lc27igJl0IHJl
c29sdmUgdGhlIHJhY2UgeW91DQo+PiA+DQo+PiA+IG1lbnRpb25lZC4NCj4+ID4NCj4+ID4gPg0K
Pj4gPiA+IEJ1dCBJIHRoaW5rIHRoZSBpb3RocmVhZCBzaG91bGQgdGFrZSBCUUwgYmVmb3JlIGNh
bGxpbmcgOjpwcmlfcmVxdWVzdF9wYWdlKCksDQo+PiA+ID4gYmVjYXVzZSBpdCBpcyBhIGZ1bmN0
aW9uIGNoYW5naW5nIHZ0ZCBkZXZpY2UgY29udGV4dCwgZS5nLiwgUFFUIGFuZCBQUlMNCj5yZWdp
c3RlciwNCj4+ID4gPiBwYWdlIGludmFsaWRhdGlvbiBxdWV1ZSBhbmQgaW90bGIgZW50cmllcy4g
V2Ugc2hvdWxkIGFsd2F5cyB0YWtlIEJRTCBiZWZvcmUNCj4+ID4NCj4+ID4gY2hhbmdpbmcNCj4+
ID4NCj4+ID4gPiBjb250ZXh0IG9mIGFueSBkZXZpY2UuIExldCBtZSBrbm93IGlmIHlvdSBoYXZl
IGRpZmZlcmVudCBvcGluaW9ucy4NCj4+ID4NCj4+ID4NCj4+ID4gRG8geW91IG1lYW4gdGhhdCBl
dmVyeSBlbXVsYXRlZCBkZXZpY2UgdGhhdCB0cmlnZ2VycyBhIFBSSSByZXF1ZXN0IHNob3VsZA0K
PmhvbGQNCj4+ID4gdGhlIEJRTD8NCj4+ID4gSSdtIG5vdCBzdXJlIHRoaXMgaXMgYSB2aWFibGUg
cGF0dGVybiBhcyB0aGUgaW5pdGlhdG9yIHByb2JhYmx5IGFscmVhZHkgaG9sZHMgYW4NCj4+ID4g
aW50ZXJuYWwgbG9jaw0KPj4gPiBhbmQgdGh1cyBjYW5ub3QgdGFrZSB0aGUgQlFMIHdpdGhvdXQg
cmlza2luZyBkZWFkbG9ja3Mgd2l0aCBjb25jdXJyZW50DQo+TU1JTyA6Lw0KPj4NCj4+DQo+PiBJ
SVVDLCBxZW11IGRvZXNuJ3Qgc3VwcG9ydCBjb25jdXJyZW50IE1NSU8gZW11bGF0aW9ucyB5ZXQs
IHRoZXkgYXJlIHNlcmlhbGl6ZWQNCj5ieSBCUUwuIElmIHdlIGRvbid0IHRha2UgQlFMIGluIGNh
bGwgc2l0ZSwgdGhlbiB3ZSBuZWVkIGl0IGluIGNhbGxlZSwgbGlrZToNCj4+DQo+PiBAQCAtNTM1
MSw2ICs1MzUxLDggQEAgc3RhdGljIGludCB2dGRfcHJpX3JlcXVlc3RfcGFnZShQQ0lCdXMgKmJ1
cywgdm9pZA0KPipvcGFxdWUsIGludCBkZXZmbiwNCj4+IMKgwqDCoMKgIEludGVsSU9NTVVTdGF0
ZSAqcyA9IG9wYXF1ZTsNCj4+IMKgwqDCoMKgIFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzOw0KPj4N
Cj4+ICvCoMKgwqAgQlFMX0xPQ0tfR1VBUkQoKTsNCj4+ICsNCj4+IMKgwqDCoMKgIHZ0ZF9hcyA9
IHZ0ZF9maW5kX2FkZF9hcyhzLCBidXMsIGRldmZuLCBwYXNpZCk7DQo+Pg0KPj4gwqDCoMKgwqAg
dWludDY0X3QgcXVldWVfYWRkcl9yZWcgPSB2dGRfZ2V0X3F1YWQocywgRE1BUl9QUUFfUkVHKTsN
Cj4+DQo+Pg0KPj4NCj4+ID4gT3RoZXJ3aXNlLCBpdCBtZWFucyB0aGF0IHRoZSBkZXZpY2UgYWx3
YXlzIHRha2VzIHRoZSBCUUwgYmVmb3JlIHRha2luZ8KgIGl0J3MNCj5vd24NCj4+ID4gbG9jay4N
Cj4+DQo+Pg0KPj4gSSB0aGluayBpdCdzIHRydWUgYmVjYXVzZSB3ZSBhbHdheXMgdGFrZSBCUUwg
YmVmb3JlIGVtdWxhdGlvbiBzdGFydC4NCj4NCj5UaGlzIGlzIHByZXR0eSBkYW5nZXJvdXMgSU1I
Ty4NCj4NCj5UaGUgZW11bGF0ZWQgZGV2aWNlIHRoYXQgZW5kcyB1cCBjYWxsaW5nIHRoaXMgZnVu
Y3Rpb24gcHJvYmFibHkgaGFzIGEgbG9jayBvbiBpdHMNCj5zaWRlIGFscmVhZHksIGxldCdzIGNh
bGwgaXQgZGV2X2xvY2suDQo+DQo+SSB0aGUgZGV2aWNlIGRvZXM6DQo+CS0gbG9jaygmZGV2X2xv
Y2spDQo+CS0gc3RhcnQgYSBQUkkgcmVxdWVzdA0KPgktIGxvY2soJmJxbCkNCg0KSSBoYXZlIHR3
byBxdWVzdGlvbnM6DQoNCjEuIHdoaWNoIHRocmVhZCBtYXkgaGF2ZSBhYm92ZSBzZXF1ZW5jZT8N
CjIuIGRvIHdlIGhhdmUgdG8gcHJvdGVjdCBQUkkgcmVxdWVzdCB3aXRoIGRldl9sb2NrPw0KDQpQ
Ukkgc3RhdGUgaXMgcHJvdGVjdGVkIGJ5IEJRTCwgSSB0aGluayBubyBuZWVkIHRvIGJlIGd1YXJk
ZWQgYnkgZGV2X2xvY2suIE1heWJlIHVubG9jayBkZXZfbG9jayBkdXJpbmcgUFJJPw0KDQpUaGFu
a3MNClpoZW56aG9uZw0KDQo+DQo+YW5kIGlmIHRoZSBob3N0IHRyaWdnZXJzIGFuIE1NSU8gb3Bl
cmF0aW9uIG9uIHRoZSBkZXZpY2U6DQo+CS0gbG9jaygmYnFsKQ0KPgktIGxvY2soJmRldl9sb2Nr
KQ0KPg0KPldlIGNhbiB0YWtlIGRldl9sb2NrIGFuZCBicWwgaW4gcmV2ZXJzZSBvcmRlciwgbGVh
ZGluZyB0byBwb3RlbnRpYWwgZGVhZGxvY2tzIG8uTw0KPg0KPj4NCj4+IFRoYW5rcw0KPj4gWmhl
bnpob25nDQo=

