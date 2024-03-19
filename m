Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5456DC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 11:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmY70-0002cV-Cu; Tue, 19 Mar 2024 07:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rmY6y-0002cM-HI
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 07:58:32 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rmY6w-0000W6-Cb
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 07:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710849510; x=1742385510;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Wv+e4LhjvYflxY7xviKuxAG+O0bOWUudxg73gJGVlog=;
 b=fUopJTBiYxWXxsGjsq1210RFuKoyik03RTTvj+pqsKl4BA5ZdU5SPsg7
 SQw/q7ZU3cz5n/TkAZEUJhLhYETHR4qdGh/j3J12z42ZMKnM/b0ABY/hS
 MSdScnWVrzbSpKOcdDRFqndaIAFpzj3kI94x40DHhU6sxBUWbtMpi1jgi
 Q5Mx8UOT+/DwXTyvpOILh8fD2RPUnLjpEd5bo+iM2YNFlbnTRPy3//sGw
 FcR6PzkNVtFUp4csxKE/0jPqUGZaAG4W2T4tFv9AVsaxO48MZ0RnQTI1J
 mjiqiiydaeNC4HFigO1xLETUuqtT6YgUfid9SlSX86tEoWAPyIIeyEdFq Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5568633"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5568633"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2024 04:58:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; d="scan'208";a="18504679"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 19 Mar 2024 04:58:27 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 04:58:26 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 04:58:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 04:58:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 04:58:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVQD1ji5cqnVln4zaYTbibinRm1XrXu2PQfNRK6G4oI39liCH7TB0cblmsltQWaiAbqCk2w98eNYCTpoUnmATgUCIJOy84y+IwmMHAYc/gN7uYPIFhojfqDPjoLJA53/dqTKZKRaOdZiyWJ7xPrpUWAsyRb8zJ/qWDZYSwJbHFtBhf8Y7UUEAki6ugBafek2EjNJx2WuCIaZtVnFRU9HGk/K3drz7/rP1FxYUbas0Fkd34QBQgOxAKYEDQY6IbblXdoUfuX3ptniqI02z+LGli1Tx6JIN2XkDBcioCmUO4G+r/4mIyowjJd/orr07MtaIBR1mWH1fF9vTVbCACoR2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wv+e4LhjvYflxY7xviKuxAG+O0bOWUudxg73gJGVlog=;
 b=X47ZDoRY0onYNzSLNE4Qju0lmHEi495ja3tvRT0dn08v3uE10grdEKrrbdXhiXyPsLJgCqq60RMncFa2z+YvUxLv4tacCe3VO55v3uMcMkSltEGzx0KE1JFm8f6zAKorO13pQksMM5c0maPEpU5sDwUGKZjIKVIPBQsn6Nerkp/tM/z4BGW1W9eABxpeXtmSJlhA/Sz225gN73ya+5ywH+Bj3Aim0w4Z2kZnokz6anOpRl0BhZcIoC7TqMrtzx8eM3ol/GDTrNodDcl+Hng796Hl4Z6ggVNwoyu1uQYY3y5SxHMf+H8xiyHqYO+iz3s3Gafhp/cyxPleSUe3H3KeIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY5PR11MB6342.namprd11.prod.outlook.com (2603:10b6:930:3d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Tue, 19 Mar
 2024 11:58:22 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 11:58:22 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v1 01/11] Introduce a common abstract struct
 HostIOMMUDevice
Thread-Topic: [PATCH v1 01/11] Introduce a common abstract struct
 HostIOMMUDevice
Thread-Index: AQHaafrJT1f15ksRNUCyLoL+rga0E7E+15OAgAAJFUA=
Date: Tue, 19 Mar 2024 11:58:22 +0000
Message-ID: <SJ0PR11MB674439E1DDE3DDE285571AEE922C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
 <20240228035900.1085727-2-zhenzhong.duan@intel.com>
 <e6af68f4-f38d-413f-a63c-d1ae7254d802@redhat.com>
In-Reply-To: <e6af68f4-f38d-413f-a63c-d1ae7254d802@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY5PR11MB6342:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w5M+0NytcX6d5F8izm4HcUZuq59eNn2fJEq7Kj1GXEKhc4T5H/4qj3KSzMSED3AcV3kmlkJcQ1/4vJKlLMmfiKrdP4C9GQDtpw+iePOWzaeHrtda+X9+6BtefWkJIDl/EAFCSvX7Itd0gI17jdUF9dI3r5CZXUlAesJ1TmMiuIFysPfwWygh1l59LI+pjH4lhgfT9a0xSIyKULqOHek0VPHILqAvLFojwibfbZROkx6+nOa28ICCtRhzighRVd2+kfgseUo7kcizIzReG8+s4na99ThSgj/VV73iBXkB47mUAjyJUGmS/BB7iS9yJ7cziU6HQa2wobZCCKeP8QYHC05vvymtoDerijVy/mh+4JNhAPKw5HOkCGRzARuE+heRKzHf30GZLCUvPIRTrqRjppwmqOm9lGBVOz0lppsmA+mVHp/Mpriii8PvKgvMme7/4dfV/CMciJEiX52chmkj0vVUqDHwZEYwg3MFHdVFbkWs8vnfZtt0FMo9W1gwaiYIZzbdDFYs06MosgRzMrn1g+lzNqrTnIfHGAL9/uzPuRijiQXFDtjKIBIbMbQWDediX6Tz0Mw3iJ0cREYvhD/GW50Oxr3aTKm9HUPbkKoeieA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(7416005); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlpTWUFJai80TVhWcTJHWjVLamVNS1JhV3psd3hBOUZBTTJHUUZybDBtTnY2?=
 =?utf-8?B?YWRxWUllaFEyeHBuNnRZTWFHeVVRV1pJZ3YxSE52dEZIVlc0WFNHRHhhbXVn?=
 =?utf-8?B?RFZuVkd4alNWN3krS0ljTkkwTmg3ekJKQXA0VmJXQ2c0UjRXcTFmUDZldGJk?=
 =?utf-8?B?UlNMK09WUmlGZjRWcE9uNERFTGNiZGJaN28xRmU0NHp6ZU95S0FNZUsrMVQw?=
 =?utf-8?B?cWFFNUZFZENiU1JXSzhKQXZRYmUyS0NDazBHZGxzM3QrY2lJa2VTcHdadDdK?=
 =?utf-8?B?c1VaVktHaHU4c1BubStwSzZ6T3dYeG9CVFhHaVNiNXBYSm5aL29ETlhNdloz?=
 =?utf-8?B?a3FhRUdWa25CaXJNeXVNQkoxMVMvWm9reU55d3Ezd2NBUVpvaktNOGNCbHRR?=
 =?utf-8?B?YW1iODdyT1A5K0c2RmJ2Rm1EdGsrTTRZWitlekUwUnVhelRDUmluVEk2WWQx?=
 =?utf-8?B?cnlQT3FxdnVsSGZ6T20yRHk2ZnBoNlBxeUJLSVY5aWM3c29SQUV2WXRKTndJ?=
 =?utf-8?B?VWZ2SjFaQW4wNUd0bXE1U0NRZGdoR1A3ZVZqSnMvU0VaQ3ZVVXZZWFhLQ1U5?=
 =?utf-8?B?RzJKNXBKT21pTEtqRVhESnZJMlA3VEJzd0xDWnJ6aGtDMlFldGQ4YVArT1du?=
 =?utf-8?B?aHhDRHVhRVVKZXVMS3RDTjczeDJDU3Nqd0hNR1ZGWmxIbFRuYVpTK0NoKzJD?=
 =?utf-8?B?Sk1vVGhES1dQY3FzYU42cXE5aE5KTDAvVzRsV0JpVnhCaW1aRGl6Rk9QRStS?=
 =?utf-8?B?ZEtmTTl3Zm9PRUdRcmVOaHV4Q1o4UWVvSnF6MWs5eUJpQVFXM0dYVFUwWFVh?=
 =?utf-8?B?MkR0Vks4WkNWQm9FWVhoN1ZDck83TjROR1RGTG5oRG9XbHNiV3E2VzZwK3BF?=
 =?utf-8?B?ZVBRa0RGK1h1c0c2NWh1eWhLUCsxNnNWN1lVTWVkMnh3aEtScVJwQ0wxSllK?=
 =?utf-8?B?Q1psQ1RNWXFGMGdRWUpHVlNvbVFGV2hCMW5CTyttT1NuMEhXcjd2Y0lEOE9E?=
 =?utf-8?B?aWdxSlQ1U2dvVVlGSk9kRUNneGhqUU9QdlY5ck1iMWFSYUFkR2tRRjRXdlJS?=
 =?utf-8?B?VUovN3NJam9sSDhMR2xtejR4cG9rejluelA2aDlvNjJqVzlGd0lRRldGbkFy?=
 =?utf-8?B?bUhpMWZaTytxQWRnajdtWHp5KzdESXRqWjBNR0lTbXlqalBKbkp1RlRzU01X?=
 =?utf-8?B?ZVgwbGo5VFFBcUY5YjQ5QjNuR1lwTVJXRXc4QUJDcVRMaDcxUG5JWG05U2ll?=
 =?utf-8?B?bld3WEFreWNHQmVweHpsWXhPc2d5d0FCeWVQVG9IMXVXZUpSN09ZY2JZbGdk?=
 =?utf-8?B?ckd0TDBhajdJTStHR2JYMURoSndqVlJNRTV0RmplWm1zc3I5Tm9lQ3JtVGZ5?=
 =?utf-8?B?RTlDejgrRHJmSjVudmhGWTg1RS9TckYwWUxDdkJsYkVUL28wL1ZBUkgyaUFs?=
 =?utf-8?B?RE9UMEtCL0hqQmIzeGQwUmlFNWx2dlN1S04yNlJManZMYjQ4WFJTOU45Vk1j?=
 =?utf-8?B?UzExSEhrZUR0cXQ0eHlGWkVLRTduSVNudHh4b0dibk1IdCthR0ZzaXJzMWYx?=
 =?utf-8?B?MG1CcHIyMjFaV3FpQmVHd1UyMHZnaFcrWHlqV2RNc2JPeVJPUHR6Z2FUbVI4?=
 =?utf-8?B?VFBXa1lWQUx6Q2xmMndFTVhEcG1iRFFieUhJeUVMcmJRbkcxZlJpWTV3RzJM?=
 =?utf-8?B?eGxhbzluMlhpdVhma09MTDRkZmFwU0JSZCtMRkRuQzZic3ZqL0RvYk8wcjRO?=
 =?utf-8?B?S1VGYVhUYkN4UW4xOU5DVi93RHpHK3VHV2ZFSFJLa0VxVGsvVnArNlA0ODZB?=
 =?utf-8?B?YWdNc0t4ZmJzQ1h4MlgyMG5OUUkyTFVIWTUxVWRWNnA4Y0U3b3FBdnhKRU1R?=
 =?utf-8?B?RlE4R2xTcWQrbnlDM2VTVEtuUStIOVNCblBxUkRXZGRGT1drcmxySWVFYWpx?=
 =?utf-8?B?aythYzdkV0dBYmhLdEY3cHNDOEZ0N01kRWVBa2JaNkpVSEhoUjlyRVgrdVFj?=
 =?utf-8?B?Zk45MzRTNmM0WU1COU1FL2pBYW5OQjNhVTRXUWJCNEpCYUZZbzVuaVFtbzB6?=
 =?utf-8?B?MVNqSDFTM0d1MUdNcTBLQTFUZmd4eUhiaUJIRm1rNVJBRHVmRnVLVWFTUVRO?=
 =?utf-8?Q?xSdRlyG6G7h4kN+agwGoNl5f8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9702e1a8-2808-4781-ab08-08dc480be082
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 11:58:22.7847 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KjZSiY7x5hRc5WtLsYrBhNKuezfx/85fqXMmImpNehq+AWYBE8c8EhuQxm4guOMo2XuYvJh6AgHo8sSeT1OpPcj4x5Ypji1fJiqj/4doDek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6342
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlNlbnQ6IFR1ZXNkYXksIE1hcmNoIDE5LCAy
MDI0IDQ6MTcgUE0NCj5UbzogRHVhbiwgWmhlbnpob25nIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5j
b20+OyBxZW11LQ0KPmRldmVsQG5vbmdudS5vcmcNCj5DYzogYWxleC53aWxsaWFtc29uQHJlZGhh
dC5jb207IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsNCj5wZXRlcnhAcmVkaGF0LmNvbTsgamFzb3dh
bmdAcmVkaGF0LmNvbTsgbXN0QHJlZGhhdC5jb207DQo+amdnQG52aWRpYS5jb207IG5pY29saW5j
QG52aWRpYS5jb207IGpvYW8ubS5tYXJ0aW5zQG9yYWNsZS5jb207IFRpYW4sDQo+S2V2aW4gPGtl
dmluLnRpYW5AaW50ZWwuY29tPjsgTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+OyBTdW4s
IFlpIFkNCj48eWkueS5zdW5AaW50ZWwuY29tPjsgUGVuZywgQ2hhbyBQIDxjaGFvLnAucGVuZ0Bp
bnRlbC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MSAwMS8xMV0gSW50cm9kdWNlIGEgY29t
bW9uIGFic3RyYWN0IHN0cnVjdA0KPkhvc3RJT01NVURldmljZQ0KPg0KPkhlbGxvIFpoZW56aG9u
ZywNCj4NCj5PbiAyLzI4LzI0IDA0OjU4LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IEhvc3RJ
T01NVURldmljZSB3aWxsIGJlIGluaGVyaXRlZCBieSB0d28gc3ViIGNsYXNzZXMsDQo+PiBsZWdh
Y3kgYW5kIGlvbW11ZmQgY3VycmVudGx5Lg0KPj4NCj4+IEludHJvZHVjZSBhIGhlbHBlciBmdW5j
dGlvbiBob3N0X2lvbW11X2Jhc2VfZGV2aWNlX2luaXQgdG8gaW5pdGlhbGl6ZSBpdC4NCj4+DQo+
PiBTdWdnZXN0ZWQtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+IFNp
Z25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+
PiAtLS0NCj4+ICAgaW5jbHVkZS9zeXNlbXUvaG9zdF9pb21tdV9kZXZpY2UuaCB8IDIyICsrKysr
KysrKysrKysrKysrKysrKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKykN
Cj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvc3lzZW11L2hvc3RfaW9tbXVfZGV2aWNl
LmgNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9zeXNlbXUvaG9zdF9pb21tdV9kZXZpY2Uu
aA0KPmIvaW5jbHVkZS9zeXNlbXUvaG9zdF9pb21tdV9kZXZpY2UuaA0KPj4gbmV3IGZpbGUgbW9k
ZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAuLmZlODBhYjI1ZmINCj4+IC0tLSAvZGV2L251
bGwNCj4+ICsrKyBiL2luY2x1ZGUvc3lzZW11L2hvc3RfaW9tbXVfZGV2aWNlLmgNCj4+IEBAIC0w
LDAgKzEsMjIgQEANCj4+ICsjaWZuZGVmIEhPU1RfSU9NTVVfREVWSUNFX0gNCj4+ICsjZGVmaW5l
IEhPU1RfSU9NTVVfREVWSUNFX0gNCj4+ICsNCj4+ICt0eXBlZGVmIGVudW0gSG9zdElPTU1VRGV2
aWNlX1R5cGUgew0KPj4gKyAgICBISURfTEVHQUNZLA0KPj4gKyAgICBISURfSU9NTVVGRCwNCj4+
ICsgICAgSElEX01BWCwNCj4+ICt9IEhvc3RJT01NVURldmljZV9UeXBlOw0KPj4gKw0KPj4gK3R5
cGVkZWYgc3RydWN0IEhvc3RJT01NVURldmljZSB7DQo+PiArICAgIEhvc3RJT01NVURldmljZV9U
eXBlIHR5cGU7DQo+DQo+QSB0eXBlIGZpZWxkIGlzIG5vdCBhIGdvb2Qgc2lnbiBhbmQgdGhhdCdz
IHdoZXJlIFFPTSBpcyB1c2VmdWwuDQoNClllcywgYWdyZWUuDQpJIGRpZG4ndCBjaG9vc2UgUU9N
IGJlY2F1c2UgaW4gaW9tbXVmZC1jZGV2IHNlcmllcywgVkZJT0NvbnRhaW5lciBjaG9vc2VzIG5v
dCB1c2luZyBRT00gbW9kZWwuDQpTZWUgdGhlIGRpc2N1c3Npb246IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC9ZbXVGdjJzNVRQdXc3SyUyRnVAeWVra28vDQpJIHRob3VnaHQgSG9zdElPTU1V
RGV2aWNlIG5lZWQgdG8gZm9sbG93IHNhbWUgcnVsZS4NCg0KQnV0IGFmdGVyIGZ1cnRoZXIgZGln
Z2luZyBpbnRvIHRoaXMsIEkgdGhpbmsgaXQgbWF5IGJlIG9rIHRvIHVzZSBRT00gbW9kZWwgYXMg
bG9uZyBhcyB3ZSBkb24ndCBleHBvc2UNCkhvc3RJT01NVURldmljZSBpbiBxYXBpL3FvbS5qc29u
IGFuZCBub3QgdXNlIFVTRVJfQ1JFQVRBQkxFIGludGVyZmFjZS4gWW91ciB0aG91Z2h0cz8NCg0K
Pg0KPklzIHZ0ZF9jaGVja19oZGV2KCkgdGhlIG9ubHkgdXNlIG9mIHRoaXMgZmllbGQgPw0KDQpD
dXJyZW50bHkgeWVzLiB2aXJ0aW8taW9tbXUgbWF5IGhhdmUgc2ltaWxhciB1c2FnZS4NCg0KPiBJ
ZiBzbywgY2FuIHdlIHNpbXBsaWZ5IHdpdGggYSBRT00gaW50ZXJmYWNlIGluIGFueSB3YXkgPw0K
DQpRT00gaW50ZXJmYWNlIGlzIGEgc2V0IG9mIGNhbGxiYWNrcywgZ3Vlc3MgeW91IG1lYW4gUU9N
IGNsYXNzLA0Kc2F5aW5nIEhvc3RJT01NVURldmljZSBjbGFzcywgSU9NTVVMZWdhY3lEZXZpY2Ug
Y2xhc3MgYW5kIElPTU1VRkREZXZpY2UgY2xhc3M/DQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4N
Cj5UaGFua3MsDQo+DQo+Qy4NCj4NCj4NCj4NCj4NCj4+ICsgICAgc2l6ZV90IHNpemU7DQo+PiAr
fSBIb3N0SU9NTVVEZXZpY2U7DQo+PiArDQo+PiArc3RhdGljIGlubGluZSB2b2lkIGhvc3RfaW9t
bXVfYmFzZV9kZXZpY2VfaW5pdChIb3N0SU9NTVVEZXZpY2UgKmRldiwNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEhvc3RJT01NVURldmljZV9UeXBl
IHR5cGUsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBzaXplX3Qgc2l6ZSkNCj4+ICt7DQo+PiArICAgIGRldi0+dHlwZSA9IHR5cGU7DQo+PiArICAg
IGRldi0+c2l6ZSA9IHNpemU7DQo+PiArfQ0KPj4gKyNlbmRpZg0KDQo=

