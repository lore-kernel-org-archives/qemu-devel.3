Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49097FF60C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 05:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Rk2-0003RR-TY; Tue, 31 Mar 2026 01:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w7Rk0-0003Qj-60; Tue, 31 Mar 2026 01:34:16 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w7Rjs-0005om-AV; Tue, 31 Mar 2026 01:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774935248; x=1806471248;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4b8YOclY0RsK3eu4qIU7q85FVMkpx+7mND+vpkJIpA0=;
 b=S/ZTZXstdtttVhCX2k+7VJr9m9nEOpVbjmCrKXL67CiLb1KaXmNIaMq7
 GtGnyP/+tVrrtUr/iOylMACupJEDGikmvKkAWP/KCXfcFBHbxvtRunMV5
 jofi8mqGraRXUP+U50f3oDvs7GiH10TsRBqYE0vtcrpJJumftaQ9Uo1lb
 frXZAHDqIQmyw0bT80mlQVBJSqQdyD4eK0HX+NsQk+N4zaBUuQm+jFYXY
 o0S2jUe60kPreB6MjNJyAm2DjU9ZMCFM5bYNxAugYEeWEGhS3Ma3hvNew
 5Oy6Z2nd/t5fiFD3onYCBgFtNFtVXv38bfL1TGtNK+uVA3UOcrTWuc5ip Q==;
X-CSE-ConnectionGUID: IZqaLBroQOiemtcQJ/gnqQ==
X-CSE-MsgGUID: pdLnzj3FSbSTX1IMH90zMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="76048449"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="76048449"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 22:34:03 -0700
X-CSE-ConnectionGUID: HMu7AVJrQ82qsfrkl8BuXA==
X-CSE-MsgGUID: YLfifgDMSQiD8yj6KQ8how==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="227879464"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 22:31:55 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 22:31:52 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 22:31:52 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.8) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 22:31:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=coKOu/ZWWdF0PhfuDU/ZYF1yOI0qNfMUanDuHSsQVWGkLfBaBZrnkxHZQ5bl2waPZhWypWT5i+Pew3nz0CPciJQHO96IVoy2zZVUzst5w/xw8xHtwekN4VaNXiM18IU4bY/Jq/muPgy+bOMjHDPhCCGypQGL/fjnhbTMzJpHQiMpl/UgI9fTNGVNysp6Tze0OEF/9GN3DV/tsmj8WrUaHRvkWaMWaz9JVnpgXZ+PmXxLKW49F4HYO8n7CnBYjenyHmR920MIPrQi7sWFzmWRli5nFBQAtxAG84/k61NyLp3Khg/6vDCd4CAJBBBBXXG9O0+ruGSuhK8YesP4VhRnSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4b8YOclY0RsK3eu4qIU7q85FVMkpx+7mND+vpkJIpA0=;
 b=MBT30S7sscZ0+cfFkliXrpa6tZagnCG+7GBokULUNcXHsy729KGfPPMX+9EW13QCByRZRT3qRRMwrchgwRqGok/E6lVrez/9sqzJcx4yVDatdZdxKGT2xuduKUWvcOOiTRDvA/FBbpFH0nC9BJLC9EMY0JuCt+3pCsFA8cTJG+TTLgNJS2Xlm7+qxELfbQE+vj3SHZkx3a+cDSgweQ/i/TpBfv3IC3wFvpJW1UmlV2q+EKkqBLFtG52y/CoC/6IvV3Wzo40FeZtljdPil1lRtJ4uAny7N9GJ9jAPqBcP2suXKX9hM/T5WAT3XqJJY0oKCIEqAulJRtaMEQ+rF+PCtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA1PR11MB8425.namprd11.prod.outlook.com (2603:10b6:806:385::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 05:31:48 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9769.011; Tue, 31 Mar 2026
 05:31:48 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao,
 Xudong" <xudong.hao@intel.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callbacks to
 support pasid
Thread-Topic: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callbacks to
 support pasid
Thread-Index: AQHcvQCbR71K6Acm9EmcQazKuEj1x7XHC52AgAEXcsA=
Date: Tue, 31 Mar 2026 05:31:48 +0000
Message-ID: <IA3PR11MB91366A2F88EBDE4032A6DE8A9253A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-3-zhenzhong.duan@intel.com>
 <13a43ce3-3afc-4308-8fb7-fc0441fef3d2@redhat.com>
In-Reply-To: <13a43ce3-3afc-4308-8fb7-fc0441fef3d2@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA1PR11MB8425:EE_
x-ms-office365-filtering-correlation-id: d086fe27-5fd4-47fc-9f8c-08de8ee6ce20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: lEYldCVEwQlwWcvojkL0vz7ih8aDfdoBT4dwGcTRBK83GUPIZwSN2UD4PX2ZgS4W+lpupcZbqRhqb3q3OPNdw+c5JpFKtQSJBBpRpll/V9Cj80/7OwhXKKMegWpX2ualEuCraix/wqUIIpDzy02LCCUQbpCuhjvM5+xYlZXvoCFSnYVaqbxj18EOGGS0EO5QcrzofzP8a/dXhFZsNho2kP7NfDiiQUtJFg1uKFTHXruEhtfDI4SDvSCOEBxHFDddV/VeyIAegDbPL8kA4Y1QSXTUn29jSAAzMftBODDj423fJMNW865cKFuYuqYpJLa6Gl7VSbRiSsmqPnO1j9FHJdz6n3v4MkqBGpmlQtf6Hbn5twq8fHl8AH5RwWU0z7Ygrp2Wn1UB8YW0lMEFQbxhguAc7z3IhzhMA+uuL5q9kAs1h/vpTtqPJTix25TTWfXflzuESgPS8ifLV/qO+sHs7BNCEI0WnHfCRQb6nOGYx3+xCCC6vnlSr1YZi/Y/5lho0KETDCVZa6O8TV0q5+BSoG6IFFqV4kwBCfkM4BBEer3tKQQPEEUECuBTwnTH4tbrboUSqnK11llGvv9ZlKDfbNDBqJc6sZZ6Xeak3I0BoOAHmFJ829EVC5rvuC02jraBNXqG1e37VEQOrePDAY9jyTv8Y+F96ZlPOuA8noxeTVvpY/aRDuDGV9HO/ePNmtQZ4O8FchiKQl/NMaRz7bSLDyqxZ3sUxHWebKgwLMPrI169beN1ot6fZvYV2pdU7teJTQ5PoU0aoWYnjGSYnZH6C3eNZ+5OJWjE7aWw5TXF31o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFBDdFczZHlublArWENnNG1tWjdycVNHZDkza3p1ZkFPcFFoRHc2SGVRQkpX?=
 =?utf-8?B?aklGMmxXbkxKOEI3dlNnWFRISEU4YWNBbUIvSURrbXVyRGpra0diZHdqMlZr?=
 =?utf-8?B?QUVSRkNRRTNyamZmZDZYZHZpSXJrYWZ5UlM4cU0yeWg4SnZRaFh6Mmx3ak9m?=
 =?utf-8?B?Z0ZzbGJlcXFJK1JXaVFodElGTjU2SG1ZRTc3bnlnbkNrYmF1UTQ4aUVYVVRp?=
 =?utf-8?B?WjRUSzdrSjRTQTdCUDl3Q1VSYWZCRS9jaWNyWVlWeGx4bmNUalhjSDdsbmFp?=
 =?utf-8?B?d1pQR1RpYi9lc0dJS0pKOFh0QmwzeUdoTTAwY1dxd2g1NnJ6Uzk2d1oyWElE?=
 =?utf-8?B?NTVWZlpiN3E4V2V0QnlKdkV5WGpTbTdmR2VEV2NkSzZ3cjA2YTR3QnczT3NT?=
 =?utf-8?B?ci9MZ3JxRWU0MERYMDNoQlhIQWZ1aUtjcnNITFI0ckkycWtoM0k3RWRTYTRk?=
 =?utf-8?B?MjlRUWEwUmxFMjlmMTlpMmxWUnV2cTJFRjZQTHgzaXE3WkV1MHpEaDhGL3pm?=
 =?utf-8?B?SnNhcnUzMmFpSkJWbm02R29jckliTkIxK1ZJcVIyNTFvRG05d1ptU3pjSGZ6?=
 =?utf-8?B?eGhnWkZzbVdtbkxOWkxXZXZ3WE0vZG9WUnR5WmtCV3d5RVFuUkNEQmJtSlVp?=
 =?utf-8?B?b3lYaXgrSzNOVHRYT2JnelM2SmR4TWt1b095bWtiUHpRdzFjcFg1TS9jNkQx?=
 =?utf-8?B?dVdZcjZOVHFQNzR0d2FKeExML1BuUzlNekN1cVBDcVEya0VxMENuTFVjdjha?=
 =?utf-8?B?M0t2bXhpUzJFaXg0UGNWSEpVdHFBVFdnelovd2pKNWlUZitxZHJxZlZqc0RU?=
 =?utf-8?B?Q1l1V042RnFJdUNZbDh3MklUTDZ2VUk2d1h4S1BKckV1VFBCZ1hwMHA2aHJS?=
 =?utf-8?B?Ui9TeUcyUmVJcTBVeDU3cjhhWVZKL2g5RVlHU1RjYWNFa2hkQjZHd2ZQQTJ6?=
 =?utf-8?B?b1NOMWNFQmlXWnBST2JoaXk2VEM0eDlsZ1h5SFV1UENEN24rSjF3b0NnWFlT?=
 =?utf-8?B?ZFk2cnA5VkVyZ0RIb3R4eVlOcFFTakc1eXlmVWsxajk4cGxmekxLN012VGND?=
 =?utf-8?B?OE1VRmc5eGpSN0lRa2J4RnRQNlVlWTFFc1BEZHZuMkNaZVQ2TVNRNWZmd2xJ?=
 =?utf-8?B?VmpaYjI4N2gzUldRK1FFcTlqamR4Q2lId1JEdEtPa3VkVStYZnlRS3JLL1U1?=
 =?utf-8?B?Q3ZsMERqRGx5WW9yZzVwelkyNG5sTkJWZi9BS1Nlb3RFSU1IWjhHRDNFU0tC?=
 =?utf-8?B?d1NPb3pRaEZsUXNINDNDM0FjeXQvMDFNRCtYODFZeUJjZVNianEvQXVDbVFX?=
 =?utf-8?B?SndJNHNSZVl5OVhKYldoWE1LMTVKRnNMdUpydUNDY0hGTEFQRUtjL0k5MjlI?=
 =?utf-8?B?c2JLdHo4NjQyWmpaVEtXNGpwbm9RMDV6Y2tyME51TFRVa1ViK2VOOTJDclda?=
 =?utf-8?B?ZEx1TXZ4djNScy9iekpTeWhYVUpoYkZsa205U005ZXlEcFRyKzYrMmxOcHN0?=
 =?utf-8?B?QVNOd05IQ0dydkVzMHgrSVJ1NDFYMFlRNkRIUWg4endyaWVmL05WZC9IMGw0?=
 =?utf-8?B?SzFFbC9ZdlZrdDRSL1VHREtwcnpXTGRGcElDNUU1a1RxRktsY0J4azhxYXND?=
 =?utf-8?B?eEptTnM0TkVwbFZ2M3JTQTJOMkQwQnp4cWJGSFQzNnNaY2pPWDNVaWZ1ckY3?=
 =?utf-8?B?SHRQQUZYbTkxZFdITUJLUThsY0tHNWczaldWUGoxYmtKQTBBYzFCSjFmODJ2?=
 =?utf-8?B?Z3FVazRBUDltY08vU2VXbFRScTkzQTE3TnVSYzl3c3FFaVhiTldlSHQxL0g1?=
 =?utf-8?B?dnM2MlJPR3VacHl3L3RZNGtxOWM1Z1JwMW9BVWpXVXlDa3NHdHV2UlZtZGFw?=
 =?utf-8?B?aW1yR0NGN29oQ1JyUUtFekVOR2JUbGsya0hYVkZZQVFWRjZTQVZmNUhYU2dP?=
 =?utf-8?B?UEJHS2s2aWFBUFNLSk5pemJ5Q0JsMmJGWkVjWFgxWGgySDh2RFNmT28wOHUx?=
 =?utf-8?B?VFVqb094NGNzcTNGNHVSb0NoTVp1MFZaMEZXYmlMSmVMbmlNSk5HOVNUOTRj?=
 =?utf-8?B?QXZ3UmhtZi9SU2hjNHovTTUyU2lRdVBHaVR2aXFjc29INndNWFFheVBoUG1M?=
 =?utf-8?B?QzhHSUs4L3NWU0YxMmp5cmVWaXZneE1IRStLbU9aTG9GaEZWK0wvRFNQQlZa?=
 =?utf-8?B?aXhNc2Fwd2x2elZBT0Z6RlcxNmRBb3NOWW82bWM5aDUzazdqaG5seEVlYWhP?=
 =?utf-8?B?UjVkRzBhK2ZyT1hNaDk3M3Uzc0poV1VEd2FpcEJ0bjZWdUIxLzdSK3hPTDVC?=
 =?utf-8?B?RDZYM2JGQnpndnQ4L2hjVjY1Mnd0MkxwTlM5OCs4ZHc2QzBQWmRBdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Kv67JXXuKiJqekpqV4T2/9thmbm75KerzXHiU5YdpJ8TxbDtZ2PxMhXnRwNKzCWqL7VHRTqymU5VzFX9ufRBuMygQU+HQ4JbzshL8LSDoOG1JBxdoGoEj6ijYTdujdw2aIoW7o1ML+55Eby5wptmhsObS/3RZJbDn+wvSj+57HOatQHzE2GSVbbWT/CusuMood8/bNB+tb8+/f8M9CpqbL2/HhVj0CvcqkF+ZXBfiltqemkFMiVj9YICzhPTkw1cSsXTp8BLuXd+mXq0UlsJjuHIckL6pgxKq04iZEbCCLEiwC2jro/Ud+YIOyenWEczjaSDZ+9dc23+yxeU3Iia5w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d086fe27-5fd4-47fc-9f8c-08de8ee6ce20
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 05:31:48.4512 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SXXVlBx4MD8i+uRvbqHs4+LldtauKN2c3nXTUgzVPgcFrQQaGotKHhTjV6O7Z/EYHtlCkgop7vR1/1vthKVMbO7gYBAlPpa7nmlAaa9aqtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8425
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
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

SGkgDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29h
dGVyIDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBNb25kYXksIE1hcmNoIDMwLCAyMDI2IDg6NDMg
UE0NCj5UbzogRHVhbiwgWmhlbnpob25nIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+OyBxZW11
LWRldmVsQG5vbmdudS5vcmcNCj5DYzogYWxleEBzaGF6Ym90Lm9yZzsgZXJpYy5hdWdlckByZWRo
YXQuY29tOyBtc3RAcmVkaGF0LmNvbTsNCj5qYXNvd2FuZ0ByZWRoYXQuY29tOyBqZ2dAbnZpZGlh
LmNvbTsgbmljb2xpbmNAbnZpZGlhLmNvbTsNCj5za29sb3RodW10aG9AbnZpZGlhLmNvbTsgam9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbTsgY2xlbWVudC5tYXRoaWV1LS0NCj5kcmlmQGJ1bGwuY29t
OyBUaWFuLCBLZXZpbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+OyBMaXUsIFlpIEwgPHlpLmwubGl1
QGludGVsLmNvbT47DQo+SGFvLCBYdWRvbmcgPHh1ZG9uZy5oYW9AaW50ZWwuY29tPjsgcWVtdS1h
cm1Abm9uZ251Lm9yZw0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDIvMTRdIGlvbW11ZmQ6IEV4
dGVuZCBhdHRhY2gvZGV0YWNoX2h3cHQgY2FsbGJhY2tzIHRvDQo+c3VwcG9ydCBwYXNpZA0KPg0K
PlpoZW56aG9uZw0KPg0KPk9uIDMvMjYvMjYgMTA6MTEsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0K
Pj4gU2FtZSBmb3IgdGhlIHR3byB3cmFwcGVycyBhbmQgdGhlaXIgY2FsbCBzaXRlcy4NCj4+DQo+
PiBTdWdnZXN0ZWQtYnk6IFNoYW1lZXIgS29sb3RodW0gVGhvZGkgPHNrb2xvdGh1bXRob0Budmlk
aWEuY29tPg0KPj4gU3VnZ2VzdGVkLWJ5OiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5j
b20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50
ZWwuY29tPg0KPj4gUmV2aWV3ZWQtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4g
LS0tDQo+PiAgIGluY2x1ZGUvc3lzdGVtL2lvbW11ZmQuaCAgICB8IDE2ICsrKysrKysrKysrLS0t
LS0NCj4+ICAgYmFja2VuZHMvaW9tbXVmZC5jICAgICAgICAgIHwgIDkgKysrKystLS0tDQo+PiAg
IGh3L2FybS9zbW11djMtYWNjZWwuYyAgICAgICB8IDEyICsrKysrKysrLS0tLQ0KPj4gICBody9p
Mzg2L2ludGVsX2lvbW11X2FjY2VsLmMgfCAgOCArKysrKy0tLQ0KPj4gICBody92ZmlvL2lvbW11
ZmQuYyAgICAgICAgICAgfCAxMCArKysrKy0tLS0tDQo+PiAgIDUgZmlsZXMgY2hhbmdlZCwgMzQg
aW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvc3lzdGVtL2lvbW11ZmQuaCBiL2luY2x1ZGUvc3lzdGVtL2lvbW11ZmQuaA0KPj4gaW5kZXgg
NzA2Mjk0NGZlNi4uNDVhOWU4N2NiMCAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvc3lzdGVtL2lv
bW11ZmQuaA0KPj4gKysrIGIvaW5jbHVkZS9zeXN0ZW0vaW9tbXVmZC5oDQo+PiBAQCAtMTM4LDE0
ICsxMzgsMTYgQEAgc3RydWN0IEhvc3RJT01NVURldmljZUlPTU1VRkRDbGFzcyB7DQo+PiAgICAg
ICAgKg0KPj4gICAgICAgICogQGlkZXY6IGhvc3QgSU9NTVUgZGV2aWNlIGJhY2tlZCBieSBJT01N
VUZEIGJhY2tlbmQuDQo+PiAgICAgICAgKg0KPj4gKyAgICAgKiBAcGFzaWQ6IHRhcmdldCBwYXNp
ZCBvZiBhdHRhY2guDQo+PiArICAgICAqDQo+PiAgICAgICAgKiBAaHdwdF9pZDogSUQgb2YgSU9N
TVVGRCBoYXJkd2FyZSBwYWdlIHRhYmxlLg0KPj4gICAgICAgICoNCj4+ICAgICAgICAqIEBlcnJw
OiBwYXNzIGFuIEVycm9yIG91dCB3aGVuIGF0dGFjaG1lbnQgZmFpbHMuDQo+PiAgICAgICAgKg0K
Pj4gICAgICAgICogUmV0dXJuczogdHJ1ZSBvbiBzdWNjZXNzLCBmYWxzZSBvbiBmYWlsdXJlLg0K
Pj4gICAgICAgICovDQo+PiAtICAgIGJvb2wgKCphdHRhY2hfaHdwdCkoSG9zdElPTU1VRGV2aWNl
SU9NTVVGRCAqaWRldiwgdWludDMyX3QgaHdwdF9pZCwNCj4+IC0gICAgICAgICAgICAgICAgICAg
ICAgICBFcnJvciAqKmVycnApOw0KPj4gKyAgICBib29sICgqYXR0YWNoX2h3cHQpKEhvc3RJT01N
VURldmljZUlPTU1VRkQgKmlkZXYsIHVpbnQzMl90IHBhc2lkLA0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgIHVpbnQzMl90IGh3cHRfaWQsIEVycm9yICoqZXJycCk7DQo+PiAgICAgICAvKioN
Cj4+ICAgICAgICAqIEBkZXRhY2hfaHdwdDogZGV0YWNoIGhvc3QgSU9NTVUgZGV2aWNlIGZyb20g
SU9NTVVGRCBoYXJkd2FyZQ0KPnBhZ2UgdGFibGUuDQo+PiAgICAgICAgKiBWRklPIGFuZCBWRFBB
IGRldmljZSBjYW4gaGF2ZSBkaWZmZXJlbnQgaW1wbGVtZW50YXRpb24uDQo+PiBAQCAtMTU0LDE1
ICsxNTYsMTkgQEAgc3RydWN0IEhvc3RJT01NVURldmljZUlPTU1VRkRDbGFzcyB7DQo+PiAgICAg
ICAgKg0KPj4gICAgICAgICogQGlkZXY6IGhvc3QgSU9NTVUgZGV2aWNlIGJhY2tlZCBieSBJT01N
VUZEIGJhY2tlbmQuDQo+PiAgICAgICAgKg0KPj4gKyAgICAgKiBAcGFzaWQ6IHRhcmdldCBwYXNp
ZCBvZiBkZXRhY2guDQo+PiArICAgICAqDQo+PiAgICAgICAgKiBAZXJycDogcGFzcyBhbiBFcnJv
ciBvdXQgd2hlbiBhdHRhY2htZW50IGZhaWxzLg0KPj4gICAgICAgICoNCj4+ICAgICAgICAqIFJl
dHVybnM6IHRydWUgb24gc3VjY2VzcywgZmFsc2Ugb24gZmFpbHVyZS4NCj4+ICAgICAgICAqLw0K
Pj4gLSAgICBib29sICgqZGV0YWNoX2h3cHQpKEhvc3RJT01NVURldmljZUlPTU1VRkQgKmlkZXYs
IEVycm9yICoqZXJycCk7DQo+PiArICAgIGJvb2wgKCpkZXRhY2hfaHdwdCkoSG9zdElPTU1VRGV2
aWNlSU9NTVVGRCAqaWRldiwgdWludDMyX3QgcGFzaWQsDQo+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgRXJyb3IgKiplcnJwKTsNCj4+ICAgfTsNCj4+DQo+PiAgIGJvb2wNCj5ob3N0X2lvbW11
X2RldmljZV9pb21tdWZkX2F0dGFjaF9od3B0KEhvc3RJT01NVURldmljZUlPTU1VRkQgKmlkZXYs
DQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90
IGh3cHRfaWQsIEVycm9yICoqZXJycCk7DQo+PiAtYm9vbA0KPmhvc3RfaW9tbXVfZGV2aWNlX2lv
bW11ZmRfZGV0YWNoX2h3cHQoSG9zdElPTU1VRGV2aWNlSU9NTVVGRCAqaWRldiwNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgcGFzaWQsIHVp
bnQzMl90IGh3cHRfaWQsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBFcnJvciAqKmVycnApOw0KPj4gK2Jvb2wNCj5ob3N0X2lvbW11X2RldmljZV9pb21t
dWZkX2RldGFjaF9od3B0KEhvc3RJT01NVURldmljZUlPTU1VRkQgKmlkZXYsDQo+PiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHBhc2lkLCBFcnJv
ciAqKmVycnApOw0KPj4gICAjZW5kaWYNCj4+IGRpZmYgLS1naXQgYS9iYWNrZW5kcy9pb21tdWZk
LmMgYi9iYWNrZW5kcy9pb21tdWZkLmMNCj4+IGluZGV4IGUxZmVlMTZhY2YuLmFiNjEyZTQ4NzQg
MTAwNjQ0DQo+PiAtLS0gYS9iYWNrZW5kcy9pb21tdWZkLmMNCj4+ICsrKyBiL2JhY2tlbmRzL2lv
bW11ZmQuYw0KPj4gQEAgLTUzOSwyMyArNTM5LDI0IEBAIGJvb2wNCj5pb21tdWZkX2JhY2tlbmRf
YWxsb2NfdmV2ZW50cShJT01NVUZEQmFja2VuZCAqYmUsIHVpbnQzMl90IHZpb21tdV9pZCwNCj4+
ICAgfQ0KPj4NCj4+ICAgYm9vbA0KPmhvc3RfaW9tbXVfZGV2aWNlX2lvbW11ZmRfYXR0YWNoX2h3
cHQoSG9zdElPTU1VRGV2aWNlSU9NTVVGRCAqaWRldiwNCj4+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgaHdwdF9pZCwgRXJyb3IgKiplcnJwKQ0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBw
YXNpZCwgdWludDMyX3QgaHdwdF9pZCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPj4gICB7DQo+PiAgICAgICBIb3N0SU9NTVVE
ZXZpY2VJT01NVUZEQ2xhc3MgKmlkZXZjID0NCj4+ICAgICAgICAgICBIT1NUX0lPTU1VX0RFVklD
RV9JT01NVUZEX0dFVF9DTEFTUyhpZGV2KTsNCj4NCj4NCj5Gb3IgY29uc2lzdGVuY3kgd2l0aCB0
aGUgcmVzdCBvZiB0aGUgY29kZSwgSSB3b3VsZCByZW5hbWUgYWxsIHRoZQ0KPmlkZXYgYW5kIGlk
ZXZjIHZhcmlhYmxlcywgdG8gaGlvZCBhbmQgaGlvZGMuDQoNCldlIGhhdmUgdXNlZCBoaW9kIGFu
ZCBoaW9kYyBmb3IgdGhlIGJhc2UgSG9zdElPTU1VRGV2aWNlIHR5cGU6DQoNCkhvc3RJT01NVURl
dmljZSAqaGlvZDsNCkhvc3RJT01NVURldmljZUNsYXNzICpoaW9kYzsNCg0KVG8gYXZvaWQgY29u
ZmxpY3QsIHdoYXQgYWJvdXQgaGlvZGkgYW5kIGhpb2RpYyBmb3IgSG9zdElPTU1VRGV2aWNlSU9N
TVVGRCB0eXBlPw0KDQpUaGFua3MNClpoZW56aG9uZw0K

