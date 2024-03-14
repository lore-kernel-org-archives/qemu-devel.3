Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F142DC54E5D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 09:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkhGZ-0002eI-QZ; Thu, 14 Mar 2024 05:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rkhGY-0002eA-Ng
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 05:20:46 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rkhGW-0007NV-4A
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 05:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710408044; x=1741944044;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TCrVAXjNxeyvliEOeK8Bs+DBzDGbIEZ7cZjLOGPta3Y=;
 b=eUxuQi3/r2/g0Pu47vMK0pqrsKOoVGymz6fRXdbCVaym++LFKCla/YrB
 vtkYgHqi4rWPbeGhTy9CTPGf5c/M+JZMGLPoIfpOMcKvwoKatnMUEuioy
 8Gx+DIskOp6xmUmtTLosWAxLuD5e83ogTJpMsN4XySj/Wah861lJnC/5q
 9ysWNHvaD1M5OMCatZh/GecyYVqLlxwCRezsX+hgKsje1mkccvGD6aVv+
 az8sp4dw5ieJEyKNylfqK/+gr9epMSMk5bG24JRT1rWkdkq/r/uYphwUv
 IuV2v9i+3jAh1OBIShfrwoRReTqqSyIMIawhGGTOwP624P3UxWxOYocgP Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="5077683"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="5077683"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2024 02:20:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; d="scan'208";a="35358610"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 Mar 2024 02:20:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 02:20:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 02:20:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 02:20:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 02:20:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LlxpL2NjRXLp6dZbf0Vg9Q8BncrfRB+yVR6TGV+tozasu0anhsXp88cRHJttWE0WXWft9m48BxEp1bA5boVQSUbLu0dOzxHSc//2EGcICXQhXXx+xU2t1sO7i+mDADBWyIsLJJYURTyhsOwU65U2j4EHJsLp2jV6ybl7DrUS9hwNkUeD9XYdttGDYlx1bIm0PzhCJRByAp27Z6ofZduozkzF9NphKH3iuXExBO5a/G6X8W6tjqCX+nC9r1+wf9wxFJjI8q45DaTiL44Depp60AF4f6YFgttMVZgdIsoNKE7vcHOrjkjtXmjLAS9hHA3veUxc6X65mB27UY6/EOSvsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCrVAXjNxeyvliEOeK8Bs+DBzDGbIEZ7cZjLOGPta3Y=;
 b=OZhcqrgGwZVt4KBEfuaLALQe/AqufndJ3oDYpbPkyGhNee7Nk/inH+CrtifAVgzQGISSBYNNwX8+yWwF4AleYHls5GkkjkDvdE1XZM4Lma0N+0RZ9kzNhX95HZZ4Sh68imZC5ifLgEvaHSFHSvQcLQ6gFRdK+YGSRN2mA22MknEv0pC/0goPihRM1+bsxVXoLylid9W/RtC3g6jSea5tK8Jdu73PPSwT6duDpBzaaRMS7xDsfKIHh0x24Ykhmdg++OTsjOictGf7Yi2Kg4ZHbwiJbpqkHE6hDryKLUfhSdjL7B7hmdJWkbo7c6Mwek6lkJxaPf8nJj1RWjoG8GrDRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA1PR11MB8197.namprd11.prod.outlook.com (2603:10b6:208:446::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Thu, 14 Mar
 2024 09:20:35 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 09:20:35 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Eric Auger
 <eric.auger@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2] vfio/iommufd: Fix memory leak
Thread-Topic: [PATCH v2] vfio/iommufd: Fix memory leak
Thread-Index: AQHadejRU9K1qW8ZSkiyfIr+WQkx4LE29cxw
Date: Thu, 14 Mar 2024 09:20:35 +0000
Message-ID: <SJ0PR11MB67440DE66F08BC84BC1A3D6992292@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240314082238.844370-1-clg@redhat.com>
In-Reply-To: <20240314082238.844370-1-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA1PR11MB8197:EE_
x-ms-office365-filtering-correlation-id: b4022c7f-c715-46f7-1db6-08dc44080183
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KIjBNEtK15Nz7VRmiV8dN4NPm9LxUWedQSotgXt/Mnb9sACqkao0dcvW5k6EF4PQzyNpjzt0IlQALH6XoV6VCVkPpv0bArtBkb/+r3oZInarPZ5Q2hbui/o/xCIcEW4f/xK/Yw+xpNjaoSBp8TlsO+oGbGk3TUqHngcAiG7spdaS5ztLFaPOChqfZl84PhIGPyGaY7xr9X4Qt4j+/kb7zb7+VK2/6hxhgL0/KM+7lqj2k30bFGHa4o7sDL3BBD0nPX+S46JMcez0kTuFIwuKx37AEDLy87prhS1Jv7CXRiQ9eyHwgYFlEDr7y9sAmQ7BD5k2ZWbbFehgHjyfhPUOtKE6eZZ6e/8yJqePtcHpK2hPJs9CrBtVZMOuRiQd4yFog35u72fBmb3C9wo8l1QMewznqAOcpA/YlyOo8BjqtRVHZFYP2O4n3EjKWx2oQ4G1mIDxdv+CBz0viu59CdlXp3voLSJyreQmSWNPl2X26HHqucPSOY8Jx8ihbr8qca+Qoe+jx1acZz+zxo8ns455geyyS0zC0+VWy/8JDq7agXqPjAg9bTAxzU8+QmdlJNod7V8ySd1pKYUgjzlhHUneE/R4fVkz2jNLinDtzSyeoL/fDBbDGw42SwynVfqsXtjYFdLXovAjmar5V6pB70lEbFHiNCsmduuBLApUeHoDpcAyvPu0kP92Bge6e3mzrsgaVfyXaX4C3X6jxQ/7tUBOf64b08kABJls31szawJwQeY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1RyWGVwL0JTTkhsU25lUjQrOEE2STFYd3JEVWNMUStWVXB4U0tvcTZNN0FT?=
 =?utf-8?B?TUg2UDJ2TlhVLytjNldRYUlmM0ZyMURrWFVQM3lTOTJZSFVGV2tzTXhTV1JX?=
 =?utf-8?B?Sy8zK0FzMmU0ekQzWGVQbzNweDBRdVBZSzd3aWxNY1luZmdMWkdYTUx6d0pV?=
 =?utf-8?B?ZWsrWjc2YkhkZ3FtOFVNVkpaZ3JOSjRBb3dFYVRtNTl3d1JkYTZxaDZHLzBu?=
 =?utf-8?B?ODJwSURPQXdzWWxpaGg0dWFWYVdBV3NUUUNWckxORFYvOVBzekNqOVNXRitF?=
 =?utf-8?B?Tjd6bzVCTHkvdEwrMHhsM2h4UGpKckJHd1FrSHVUY0VBeWE4dGFhVkJ0SEpH?=
 =?utf-8?B?YUlPV2M0Uk9qMlRQdFRLY3p3ZkNyWkZmY0lyUDJpbGhPWFlIZnhOVVpNNkds?=
 =?utf-8?B?NkJodTZzeU5WR05WYlRxbTAxaUcxZTN0WkJhb1RoWmJ3M0R1YTRzTjdoY3Rx?=
 =?utf-8?B?S0pBRHdMNUVXcU9PcUFEMFVadE80bElpdmpHSmJ3bmV1aVI2cGhiMm05M1hB?=
 =?utf-8?B?S0haOEF0NEZPVDR6cGJ2NHdRb1lwTys1aUtSenBPYmFNWjZGMGhVRjJIYmsv?=
 =?utf-8?B?d3dvMmpuUTI1blNkdXl2enF5aEM0UFZvWFZPamlzSDhyT2RaN1pONEhZeith?=
 =?utf-8?B?eGhKVHlhUG83dG1JeTBPeFRud0FiUXBua0prZEQyeERERk1sNGtuRHl2dWc5?=
 =?utf-8?B?Q3pPcVRLY3lOV2JFL1lnVzI0M0JxVkdRUHZHZWZ2cXJVc2ZoSFdjR3lWT0R4?=
 =?utf-8?B?di9FNVZjOWg0NnhiQytQd1FxRmVHWUJFdTNiQ0lmUmNocVZFUHNoNzVnSStp?=
 =?utf-8?B?OGRuK3lxaXdzSS9RTTB6M0s1Sit6V25JNW9OcTBEdGtuY0dYUGtEL0dSWUQ1?=
 =?utf-8?B?eUtxOE85K3hna1F4T2N4Skt2UXZscm1nNjRVZXpGZjluRmtEMkR3VDdUMUVC?=
 =?utf-8?B?QUk0N2FGWmlPRXVsczIydC9KbWxTTkZEM1hVaDUwMTdFc3orMkZXUEtIQWRj?=
 =?utf-8?B?WlNzYVlkZmhLUk15N2JWc0lQaTNySnpnVEdjRWRJWGRxcG1IclpXQWRTSWhx?=
 =?utf-8?B?Y2Vhdm1Bck1aMUxFblFlNjlZWm56V1ZCYm5aMlg0dStlQzBNOHV0ajhENGxD?=
 =?utf-8?B?b2pCbUMvWjVpNTVQeFpYQ1kxcEFDTC9xRTZXVmZjbTgzUjBuN0RwT3IwUFVF?=
 =?utf-8?B?REpBbkVqNXN4N1V4TjBTSDB3MEdwRkcycWFRUCtqc00vRTlhR2szTmJSRlNu?=
 =?utf-8?B?WFRvVEVJWWh5TFdJZVZaVjdRbytwcjVWZzJvVzgxRnFOVlA1dXljYjc5Uk8y?=
 =?utf-8?B?b2NoU3BmQXpGbVRtRFVLelV0elM4ZW9uYTM1akwwc29lRUdFRlVFdjFpOHNN?=
 =?utf-8?B?WnpWZWI2LzQ5ZDg2RVVRRzRMMkgydmpCOU1yMzR0ZGN3cHZXd1h3NTJTTFVI?=
 =?utf-8?B?UXpmbEk1Q3VubGVYVTg4U3dCb3ZreG9FTnRxUW01Qk1aQzdabFRibWgwWmZ1?=
 =?utf-8?B?cHRKZDU4bUd3cEYycUNHRGNiSzNOejVwOEJ3NGYvYVprdk1KcVUrRUtQanFn?=
 =?utf-8?B?K3ZzdlJRcUVxeHBvaGxhT2ljMzJwbm0vLzgyTDRrbyt3bmZ0ZlU1ZWNmZ0h6?=
 =?utf-8?B?b2JqcWpXdDNERWFuekhHSlJEMG5aRmxER2t0eFVPcXVjaGJmTXBuVk9kSzc1?=
 =?utf-8?B?MkptNkIvYk9mS0FoeGNadDFoNitkWldFK1BFZWpCSlpBZ2pSMFh2UVc1VGpF?=
 =?utf-8?B?U2dMNWI0SmYvMzhXcmRRUWt4OWlXckRvaTA4QWJoR0trZmwxdyt6d2dncUNw?=
 =?utf-8?B?ZTJhZ3h3VDBIYXJqVHlJL0taQ2lKU0dtcktUbmtCd0xKRmJRU1dMN3BFNWtL?=
 =?utf-8?B?cUk1ZjFqZzYveStjamVOckhaMlpGTEFMUU9iM2lybGpyWm55c2xDMklUazVK?=
 =?utf-8?B?VUs2Y1ZWTkZ2KzR0Vnp1Z29UazFoOWZXZGpUWHVBeDVHRzhXeUxPUXpVTkgr?=
 =?utf-8?B?Unh2OUdyY3hieFpESDJNaXF0YmZlV3Zaa1JEb3JHQU5aZEFXY1dBK29Oc090?=
 =?utf-8?B?RjlPdWlTeC9GZEJPL21aYTBhWGJ4SjdWMVFFajh5UG1iMTlHMXZZUGJoa2lx?=
 =?utf-8?Q?LM6yVIgVBAaJzNDks/3Ge+3Yc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4022c7f-c715-46f7-1db6-08dc44080183
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 09:20:35.5122 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lv1/MH1kcWMYF0drUlVfLe+dyscooRiB2PGvg/3D0Gl6lrPhUmsYaEIjJEYIKqgVW8nhKrI1qAr28pb91ygltrdHRMZsRCCoYhw0kauf/sQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8197
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.971,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggdjJdIHZmaW8vaW9tbXVmZDogRml4
IG1lbW9yeSBsZWFrDQo+DQo+Q292ZXJpdHkgcmVwb3J0ZWQgYSBtZW1vcnkgbGVhayBvbiB2YXJp
YWJsZSAnY29udGVudHMnIGluIHJvdXRpbmUNCj5pb21tdWZkX2NkZXZfZ2V0ZmQoKS4gVXNlIGdf
YXV0b2ZyZWUgdmFyaWFibGVzIHRvIHNpbXBsaWZ5IHRoZSBleGl0DQo+cGF0aCBhbmQgZ2V0IHJp
ZCBvZiBnX2ZyZWUoKSBjYWxscy4NCj4NCj5DYzogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRo
YXQuY29tPg0KPkNjOiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj5GaXhlczogQ0lEIDE1
NDAwMDcNCj5GaXhlczogNWVlM2RjN2FmNzg1ICgidmZpby9pb21tdWZkOiBJbXBsZW1lbnQgdGhl
IGlvbW11ZmQgYmFja2VuZCIpDQo+U3VnZ2VzdGVkLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpo
b25nLmR1YW5AaW50ZWwuY29tPg0KPlNpZ25lZC1vZmYtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxj
bGdAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb20+DQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4tLS0NCj4gaHcvdmZpby9p
b21tdWZkLmMgfCAxOSArKysrKysrKy0tLS0tLS0tLS0tDQo+IDEgZmlsZSBjaGFuZ2VkLCA4IGlu
c2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPg0KPmRpZmYgLS1naXQgYS9ody92ZmlvL2lv
bW11ZmQuYyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+aW5kZXgNCj5hNzVhNzg1ZTkwYzY0Y2RjYzRk
MTBjODhkMjE3ODAxYjNmNTM2Y2RiLi5iOWM3ZWZiM2VmMTFlNDllMTg5MTAzDQo+YWU2ZmI5MDEx
YTYzMWI2MGRhIDEwMDY0NA0KPi0tLSBhL2h3L3ZmaW8vaW9tbXVmZC5jDQo+KysrIGIvaHcvdmZp
by9pb21tdWZkLmMNCj5AQCAtMTE4LDEwICsxMTgsMTIgQEAgc3RhdGljIGludCBpb21tdWZkX2Nk
ZXZfZ2V0ZmQoY29uc3QgY2hhcg0KPipzeXNmc19wYXRoLCBFcnJvciAqKmVycnApDQo+IHsNCj4g
ICAgIEVSUlBfR1VBUkQoKTsNCj4gICAgIGxvbmcgaW50IHJldCA9IC1FTk9UVFk7DQo+LSAgICBj
aGFyICpwYXRoLCAqdmZpb19kZXZfcGF0aCA9IE5VTEwsICp2ZmlvX3BhdGggPSBOVUxMOw0KPisg
ICAgZ19hdXRvZnJlZSBjaGFyICpwYXRoID0gTlVMTDsNCj4rICAgIGdfYXV0b2ZyZWUgY2hhciAq
dmZpb19kZXZfcGF0aCA9IE5VTEw7DQo+KyAgICBnX2F1dG9mcmVlIGNoYXIgKnZmaW9fcGF0aCA9
IE5VTEw7DQo+ICAgICBESVIgKmRpciA9IE5VTEw7DQo+ICAgICBzdHJ1Y3QgZGlyZW50ICpkZW50
Ow0KPi0gICAgZ2NoYXIgKmNvbnRlbnRzOw0KPisgICAgZ19hdXRvZnJlZSBnY2hhciAqY29udGVu
dHMgPSBOVUxMOw0KPiAgICAgZ3NpemUgbGVuZ3RoOw0KPiAgICAgaW50IG1ham9yLCBtaW5vcjsN
Cj4gICAgIGRldl90IHZmaW9fZGV2dDsNCj5AQCAtMTMwLDcgKzEzMiw3IEBAIHN0YXRpYyBpbnQg
aW9tbXVmZF9jZGV2X2dldGZkKGNvbnN0IGNoYXINCj4qc3lzZnNfcGF0aCwgRXJyb3IgKiplcnJw
KQ0KPiAgICAgZGlyID0gb3BlbmRpcihwYXRoKTsNCj4gICAgIGlmICghZGlyKSB7DQo+ICAgICAg
ICAgZXJyb3Jfc2V0Z19lcnJubyhlcnJwLCBlcnJubywgImNvdWxkbid0IG9wZW4gZGlyZWN0b3J5
ICVzIiwgcGF0aCk7DQo+LSAgICAgICAgZ290byBvdXRfZnJlZV9wYXRoOw0KPisgICAgICAgIGdv
dG8gb3V0Ow0KPiAgICAgfQ0KPg0KPiAgICAgd2hpbGUgKChkZW50ID0gcmVhZGRpcihkaXIpKSkg
ew0KPkBAIC0xNDcsMTQgKzE0OSwxMyBAQCBzdGF0aWMgaW50IGlvbW11ZmRfY2Rldl9nZXRmZChj
b25zdCBjaGFyDQo+KnN5c2ZzX3BhdGgsIEVycm9yICoqZXJycCkNCj4NCj4gICAgIGlmICghZ19m
aWxlX2dldF9jb250ZW50cyh2ZmlvX2Rldl9wYXRoLCAmY29udGVudHMsICZsZW5ndGgsIE5VTEwp
KSB7DQo+ICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiZmFpbGVkIHRvIGxvYWQgXCIlc1wiIiwg
dmZpb19kZXZfcGF0aCk7DQo+LSAgICAgICAgZ290byBvdXRfZnJlZV9kZXZfcGF0aDsNCj4rICAg
ICAgICBnb3RvIG91dF9jbG9zZV9kaXI7DQo+ICAgICB9DQo+DQo+ICAgICBpZiAoc3NjYW5mKGNv
bnRlbnRzLCAiJWQ6JWQiLCAmbWFqb3IsICZtaW5vcikgIT0gMikgew0KPiAgICAgICAgIGVycm9y
X3NldGcoZXJycCwgImZhaWxlZCB0byBnZXQgbWFqb3I6bWlub3IgZm9yIFwiJXNcIiIsIHZmaW9f
ZGV2X3BhdGgpOw0KPi0gICAgICAgIGdvdG8gb3V0X2ZyZWVfZGV2X3BhdGg7DQo+KyAgICAgICAg
Z290byBvdXRfY2xvc2VfZGlyOw0KPiAgICAgfQ0KPi0gICAgZ19mcmVlKGNvbnRlbnRzKTsNCj4g
ICAgIHZmaW9fZGV2dCA9IG1ha2VkZXYobWFqb3IsIG1pbm9yKTsNCj4NCj4gICAgIHZmaW9fcGF0
aCA9IGdfc3RyZHVwX3ByaW50ZigiL2Rldi92ZmlvL2RldmljZXMvJXMiLCBkZW50LT5kX25hbWUp
Ow0KPkBAIC0xNjQsMTcgKzE2NSwxMyBAQCBzdGF0aWMgaW50IGlvbW11ZmRfY2Rldl9nZXRmZChj
b25zdCBjaGFyDQo+KnN5c2ZzX3BhdGgsIEVycm9yICoqZXJycCkNCj4gICAgIH0NCj4NCj4gICAg
IHRyYWNlX2lvbW11ZmRfY2Rldl9nZXRmZCh2ZmlvX3BhdGgsIHJldCk7DQo+LSAgICBnX2ZyZWUo
dmZpb19wYXRoKTsNCj4NCj4tb3V0X2ZyZWVfZGV2X3BhdGg6DQo+LSAgICBnX2ZyZWUodmZpb19k
ZXZfcGF0aCk7DQo+IG91dF9jbG9zZV9kaXI6DQo+ICAgICBjbG9zZWRpcihkaXIpOw0KPi1vdXRf
ZnJlZV9wYXRoOg0KPitvdXQ6DQo+ICAgICBpZiAoKmVycnApIHsNCj4gICAgICAgICBlcnJvcl9w
cmVwZW5kKGVycnAsIFZGSU9fTVNHX1BSRUZJWCwgcGF0aCk7DQo+ICAgICB9DQo+LSAgICBnX2Zy
ZWUocGF0aCk7DQo+DQo+ICAgICByZXR1cm4gcmV0Ow0KPiB9DQo+LS0NCj4yLjQ0LjANCg0K

