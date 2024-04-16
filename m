Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A19C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 06:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwbyq-0003xT-7T; Tue, 16 Apr 2024 02:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rwbyn-0003xA-HI
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 02:07:41 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rwbyk-0001ar-PF
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 02:07:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713247658; x=1744783658;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tToFodwWVbFG7+Ajk+DKAbFapkeo2AfPYtNxgAd3pag=;
 b=KsWwsGB8Lu6Hj6QOnte0PkrA5j549AZDVkUgRlZTpAi7YNp/RrFmhi6A
 Ssv8RGhkdxFao5xhCpcmiccRL/RHIakFEpQAsSRjeSFOq93JNguXyVSbg
 Q2k+/Cjfoqm9zyr7lBBEW7I2VJU1nWnJheLPiY/Wve9x7X/lJBLlWVpWo
 Y3w4/wl1b5WstDxqqtU67nEnhSSn2EGh1QyvGd29Cv+v51YGJBkk/3cN8
 KTZf47nAI8UcUpzWOtBdHGNbBm5GXvGaCXk/HXTfIJ1CFF4oMwezaGRM6
 4qGV4N0JPu03HlIqQhFxun5+poNnLd9/xxza1W/dGxVvqy3wAedNywi7R Q==;
X-CSE-ConnectionGUID: qGfP7NiXSze/gGccvfXi5Q==
X-CSE-MsgGUID: bjTDZ/+lQEuX8TuZo2GJQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8885625"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8885625"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2024 23:07:34 -0700
X-CSE-ConnectionGUID: 9YRcbfHwSwyk17VoCoH84g==
X-CSE-MsgGUID: KNzY8NR+TYKVBhD23lB6aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; d="scan'208";a="26715231"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Apr 2024 23:07:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 23:07:33 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 23:07:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 23:07:33 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 23:07:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+ETLaZ/sDtp/eVqQAERATicLazPU9gRFZIhBFr1Ta4+6bJPbv8cz1gJSJPR1drMqAxaVSaMqpM7GcxYEm5O4/oKgr41rQKF0vWeYkToAckAixTQQWiRfh03f6puuGfTSVewqe7oPeh5d2SlzHof//p/iYYVPG+C3uIC+b717QnktIA0P/mWY1TZn79t9cX1MWfuayc9ghvoxw3oZsmB1lMZKJuXY9Z8Rn2a7YJYG9Fcr4V4rQAFgDDjD59OMgnTu0jWnWtyulhID+CnWfeUolJNAXhFSjoTTwiNOBs5pXPv7CEh1zz9dqBXlYPGZZraSArPEM9HP0gMxmzsuLMcLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tToFodwWVbFG7+Ajk+DKAbFapkeo2AfPYtNxgAd3pag=;
 b=ltvW6Ht2HKbAHf2czwWmEfgfYMruHdbCSYkd70NIzra6DK3zlY550yYJLeH97bQUSaL7J5pDVbXbuWbMmxeKULhKWO7eOx4ZscgV1Y+XGW3wyc3Qsn1dWX68rEvFzHgzKHdiAzswS0qD7Pxh3Pbf3/lXR6SoFReW+XswAoSgjPVp/lixPLIGH2JD37lcRdXxppdVhaoRe55xtqmPkpsxVnw5eoE4D8h42kdlm+HY2MCPj2cGQ4h2l9s5R96NSmWZ10gZvujXrZoBzmKfRG6ObTelhFOrsQvprOSZx11GIh3kC5nfJhM9kGexPBP8+vQF9eh+mQyqNg9HTaqxidXsAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CO1PR11MB5139.namprd11.prod.outlook.com (2603:10b6:303:95::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 06:07:31 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7472.025; Tue, 16 Apr 2024
 06:07:30 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>
Subject: RE: [PATCH v2 06/10] backends/iommufd: Introduce helper function
 iommufd_backend_get_device_info()
Thread-Topic: [PATCH v2 06/10] backends/iommufd: Introduce helper function
 iommufd_backend_get_device_info()
Thread-Index: AQHaiYzvvZheuO+vSEenSMgnyJ8GOrFpXLyAgAEWX1A=
Date: Tue, 16 Apr 2024 06:07:30 +0000
Message-ID: <SJ0PR11MB6744DFD4DF0BEF569E9CE6E892082@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
 <20240408081230.1030078-7-zhenzhong.duan@intel.com>
 <82065d07-3c7b-41dc-9a22-8b1f58a61830@redhat.com>
In-Reply-To: <82065d07-3c7b-41dc-9a22-8b1f58a61830@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CO1PR11MB5139:EE_
x-ms-office365-filtering-correlation-id: 8237d1e8-efda-4fcb-285e-08dc5ddb8029
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JJOFY7vKv7s1PrUYfCRLwkjHZ3PAw+0WqGkpzUxvrPM7r7EIx//4Fkeuk+CXlNbjI0qdkmGc2FqnQvkazlbVmHv90U1BtII1wXUSMgpvlaD/fwt0piLpdkU8UabWQ+eIGMbyONWk1Wh8jRhCTL1RFqJpWyQ77AMiy6ymv1Y4hNRH2J5o58RWxj+hu1igpfCbklokfRhN4fSBcvYZ4T4rFkLsGZa1m/s1+2XwNcVycitFv6VEhQ55H2IOnL53K5KhZ7nziLYrv5XSKTUSu/sNonkQMCeXmErYLyYGj6bNB2tuTN9Gj7FxYo0uZMBKqfuQ047NtjxJTiKgUWNvRfSIgnmgQdaXIlsT4LK+lWlITo2pxngVMaFX4Gx1ao17A2sDZopGUU9csHYTMPmm7jlv3hDjPFEPhqvUsyh7QZs/0kOgkw5Wy0CGWq2ZfSeYk+L2wh74mbI7Pmg43AJcYWgQEQ2wdEmYmPwbkiQHbSph+cwbH0mDZEvQKDjD8NjVd7+t+gw1P/D1Pd15P3god3QK8+0/br3WTTmTTudXd1bywqVxAs48i9LZZJSHGo0D7tmTqLbYSZx6UI94eukGA/l3gO85Ge9dXI2NoOHsUD96SUF10BCJRTLct86AAFQvKeYBayfF3K8JpBC6bYPbKbcmMbmOo+4KTXRJHLoSG6/VbF2W5KaXT8o/r984dFaG5htR1kWcWgQS4jTlH6XzJR/tFkVwEpBs5DAGzs8gYoUZU6s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVZHRTVwSjAxelJPaGxZMk5HK3lGWkFvaFpBdGZHMWJYQ2NCQmNGSm1DZzE3?=
 =?utf-8?B?U1JXWWlRNVNNeDVXUUdQK0tHMWc4ejRrN0FyV05jSTZ6d3NPaTdBd0dhZjZh?=
 =?utf-8?B?ZmRRc0lFR2J1UVJmR0prbjN2c3NwbmR0MlY1Z3pwWE9TQ0hKZWRibVR3QXV1?=
 =?utf-8?B?bmI2VitJQWI2SGNtM3hKcS94MVMrOVhoYTRxS2VtWUlGSnliOGRHRng0SlVk?=
 =?utf-8?B?M045QjlCMlFweWRmME5UMmMyQlRHT091RzdMYWRjVVgzeVlzdTQ0UmZsK1pW?=
 =?utf-8?B?aVIzQSt0SWI5RGpVZkE2OGVVclJQL3Yya3M5dmxud1dFUXhWMXBSdkd0R3JW?=
 =?utf-8?B?TmcrRUdwQTl1ZFBGaEcwTk9udENKazJSVHV1NEc0Z0lramhJSmNpd3UyMTM4?=
 =?utf-8?B?N0xVK3JIdGVUTXZDZnJWM2d1STNnYVE2M3phT01kWFlYdGxoK2lhVTk2U2pw?=
 =?utf-8?B?Q08ycERPelFxaG5aOHI0Y0ZIT3h3aGZSZXBIYjdUakJaVkVmSWRHd25mbHFU?=
 =?utf-8?B?NXdSN0tMMitEVGtNbmFlTTE5Q053bVJBQ01QbVhaaThCSGp0dkduZWFTWVNi?=
 =?utf-8?B?L0lyNUFFenFUekRzRXI3NUIxTllKSGRlbHJscmtVbG0wRWxBakN5a29EUFRq?=
 =?utf-8?B?a2xiVVIxUzk2T3U4ZHVUMWhKQkJsSkdaODlpd2srL1FNYndIYkJ3RlVwVit1?=
 =?utf-8?B?OEtKT2pKcllvb3RBelZsVnVjUWswZk1pNmkwVkFnb0ZwWnR2ZzBIN2VRV2pv?=
 =?utf-8?B?NjM5Y0V2cWNzR1dvZHBEVmpKa0Z1blZYNGViM20vL09ZYU5aZERkOGxoUllN?=
 =?utf-8?B?TVdpVmg4cHllK25lN1lGYjgyWU9kR3JrbGdSUlpySzdFaXQ5YmdsNDZpQ09I?=
 =?utf-8?B?dlBxQS81ZHhXa1ZRNkZ4NHNjejBXUXJRaGtWc3VwNU55aWdmcW92VGowaklS?=
 =?utf-8?B?b2hvM0taUUc2SytOVjVFbmZ6eGNSZEZUdXpXVFcxSktHYk9sY3dhMytXa2ov?=
 =?utf-8?B?eTNwTjhBU1lpelJMclpudWJoTDFHME1MYkI1TjRRcTE3NFZBaTdMWjdvOWZM?=
 =?utf-8?B?dFVDRzFpQ21tZDBJdzF3eTlTcVRwR1pDdXhJUkFvajBJWmgyL3Yrajg3dUY5?=
 =?utf-8?B?SEV5SEdJQ1hwVWVXWTdrYkwwQmtHOXdYS2NkNW9IZTZPOGJuRk9OYkRybEV1?=
 =?utf-8?B?NkZtMXlNbUl3ek5sRGZMMWtiRWR1UkZ1RGI2d2dhZGtDUG9FUkpVQTc2NWNM?=
 =?utf-8?B?UUxXZ3hpNUNZb0w3eVdpckRWWCtoZVNIUWxHVXJaZ0NLelQvTkp0R2kwTFVX?=
 =?utf-8?B?MXlpWCtMRWpCUGlkZEtENFJzYWJxNlJHTjNnQjR6WUljWHphbThOSlFRaDNK?=
 =?utf-8?B?Q0FZMDMxMVM1TWx3dzRIMWFDOXJYbGVyRUVsZWo1UlMxV0JlcjFCdXc5Rnpx?=
 =?utf-8?B?cVovcG9yRURaYjcwa0pGM2lkcHQwZGw1THZHTmdpVHJQNmhJcGY5RFdlbmhq?=
 =?utf-8?B?eE9nY3MvaHVrd2NSUWF0bWpOL2VyZTNRcTZzam51Zi9hdmhLa1lnajE0TFZ6?=
 =?utf-8?B?ZDVtbUI1WGlrdUpPVUZHY3lEMjB1Y1lVcFpJMGx1VE5xcEpRT1YzOWJBTzZh?=
 =?utf-8?B?aUFSYllPbTJ4ZzZTTGRhVGQ2ZlBwMlJkY1cvMXFTaU12Ync5bTB3b3dEaHVp?=
 =?utf-8?B?S1hINEFFQVk3QW0zUC9rdHIvTXphWFUzZzRUcjdwb0FvSURPOUN4cytpNHlS?=
 =?utf-8?B?cVJMazdEWFFoVWkyMEh4Q2ZhdkdIM2xuaHNVendFb1NWZXJWV2VGSmVvOVZF?=
 =?utf-8?B?b0N3UktkRXpxZUJVMi9obkMrUlFiUzNlUm9GRzJwZndxZDlNNDY5SjdrUy90?=
 =?utf-8?B?N2hlM0lTZlZuV25hWms5YnA4a2IrNHdhVDIyUG44WUh1VUM5aGhtLzM1ZFk4?=
 =?utf-8?B?WWxPWmtSZmhocG85enltUEdPZWppazcvRS9vUkcvOUhIOEF4U0hqdDZ3dTVG?=
 =?utf-8?B?dTNqeEpxOStUWVdxMmNlcDFNTHNZclY1MUl3TURrT1pqcFdxTHFNeFY1UnNS?=
 =?utf-8?B?blJXWVRSTzFod1U2NVo5bkJKbmIwdU0valRSOHFmUnFBOS9UVlBEaEk5bEVq?=
 =?utf-8?Q?apL8G1Kwx8vu0EdAwg0EF/2LT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8237d1e8-efda-4fcb-285e-08dc5ddb8029
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 06:07:30.9080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uZecvVzRZOB9184kYDwdctEkK4/O8ItL1JvxSNFvOZEYYPhC/zEVHwiCbTgZJ28HKqpV81tACEjwBZWbiis2JxcVP2MqWVn0aqamTUO4EvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5139
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDA2LzEwXSBiYWNrZW5k
cy9pb21tdWZkOiBJbnRyb2R1Y2UgaGVscGVyDQo+ZnVuY3Rpb24gaW9tbXVmZF9iYWNrZW5kX2dl
dF9kZXZpY2VfaW5mbygpDQo+DQo+T24gNC84LzI0IDEwOjEyLCBaaGVuemhvbmcgRHVhbiB3cm90
ZToNCj4+IEludHJvZHVjZSBhIGhlbHBlciBmdW5jdGlvbiBpb21tdWZkX2JhY2tlbmRfZ2V0X2Rl
dmljZV9pbmZvKCkgdG8gZ2V0DQo+PiBob3N0IElPTU1VIHJlbGF0ZWQgaW5mb3JtYXRpb24gdGhy
b3VnaCBpb21tdWZkIHVBUEkuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWWkgTGl1IDx5aS5sLmxp
dUBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZaSBTdW4gPHlpLnkuc3VuQGxpbnV4Lmlu
dGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVh
bkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICAgaW5jbHVkZS9zeXNlbXUvaW9tbXVmZC5oIHwgIDQg
KysrKw0KPj4gICBiYWNrZW5kcy9pb21tdWZkLmMgICAgICAgfCAyMyArKysrKysrKysrKysrKysr
KysrKysrLQ0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9zeXNlbXUvaW9tbXVmZC5oIGIvaW5j
bHVkZS9zeXNlbXUvaW9tbXVmZC5oDQo+PiBpbmRleCA3MWM1M2NiYjQ1Li5mYTFhODY2MjM3IDEw
MDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9zeXNlbXUvaW9tbXVmZC5oDQo+PiArKysgYi9pbmNsdWRl
L3N5c2VtdS9pb21tdWZkLmgNCj4+IEBAIC00LDYgKzQsNyBAQA0KPj4gICAjaW5jbHVkZSAicW9t
L29iamVjdC5oIg0KPj4gICAjaW5jbHVkZSAiZXhlYy9od2FkZHIuaCINCj4+ICAgI2luY2x1ZGUg
ImV4ZWMvY3B1LWNvbW1vbi5oIg0KPj4gKyNpbmNsdWRlIDxsaW51eC9pb21tdWZkLmg+DQo+PiAg
ICNpbmNsdWRlICJzeXNlbXUvaG9zdF9pb21tdV9kZXZpY2UuaCINCj4+DQo+PiAgICNkZWZpbmUg
VFlQRV9JT01NVUZEX0JBQ0tFTkQgImlvbW11ZmQiDQo+PiBAQCAtMzQsNiArMzUsOSBAQCBpbnQg
aW9tbXVmZF9iYWNrZW5kX21hcF9kbWEoSU9NTVVGREJhY2tlbmQNCj4qYmUsIHVpbnQzMl90IGlv
YXNfaWQsIGh3YWRkciBpb3ZhLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmFt
X2FkZHJfdCBzaXplLCB2b2lkICp2YWRkciwgYm9vbCByZWFkb25seSk7DQo+PiAgIGludCBpb21t
dWZkX2JhY2tlbmRfdW5tYXBfZG1hKElPTU1VRkRCYWNrZW5kICpiZSwgdWludDMyX3QNCj5pb2Fz
X2lkLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBod2FkZHIgaW92YSwgcmFt
X2FkZHJfdCBzaXplKTsNCj4+ICtpbnQgaW9tbXVmZF9iYWNrZW5kX2dldF9kZXZpY2VfaW5mbyhJ
T01NVUZEQmFja2VuZCAqYmUsIHVpbnQzMl90DQo+ZGV2aWQsDQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZW51bSBpb21tdV9od19pbmZvX3R5cGUgKnR5cGUsDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqZGF0YSwgdWludDMyX3Qg
bGVuLCBFcnJvciAqKmVycnApOw0KPj4NCj4+ICAgI2RlZmluZSBUWVBFX0hJT0RfSU9NTVVGRCBU
WVBFX0hPU1RfSU9NTVVfREVWSUNFICItaW9tbXVmZCINCj4+ICAgT0JKRUNUX0RFQ0xBUkVfVFlQ
RShISU9ESU9NTVVGRCwgSElPRElPTU1VRkRDbGFzcywNCj5ISU9EX0lPTU1VRkQpDQo+PiBkaWZm
IC0tZ2l0IGEvYmFja2VuZHMvaW9tbXVmZC5jIGIvYmFja2VuZHMvaW9tbXVmZC5jDQo+PiBpbmRl
eCBlZjhiM2E4MDhiLi41NTlhZmZhOWVjIDEwMDY0NA0KPj4gLS0tIGEvYmFja2VuZHMvaW9tbXVm
ZC5jDQo+PiArKysgYi9iYWNrZW5kcy9pb21tdWZkLmMNCj4+IEBAIC0yMCw3ICsyMCw2IEBADQo+
PiAgICNpbmNsdWRlICJtb25pdG9yL21vbml0b3IuaCINCj4+ICAgI2luY2x1ZGUgInRyYWNlLmgi
DQo+PiAgICNpbmNsdWRlIDxzeXMvaW9jdGwuaD4NCj4+IC0jaW5jbHVkZSA8bGludXgvaW9tbXVm
ZC5oPg0KPj4NCj4+ICAgc3RhdGljIHZvaWQgaW9tbXVmZF9iYWNrZW5kX2luaXQoT2JqZWN0ICpv
YmopDQo+PiAgIHsNCj4+IEBAIC0yMTIsNiArMjExLDI4IEBAIGludA0KPmlvbW11ZmRfYmFja2Vu
ZF91bm1hcF9kbWEoSU9NTVVGREJhY2tlbmQgKmJlLCB1aW50MzJfdCBpb2FzX2lkLA0KPj4gICAg
ICAgcmV0dXJuIHJldDsNCj4+ICAgfQ0KPj4NCj4+ICtpbnQgaW9tbXVmZF9iYWNrZW5kX2dldF9k
ZXZpY2VfaW5mbyhJT01NVUZEQmFja2VuZCAqYmUsIHVpbnQzMl90DQo+ZGV2aWQsDQo+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW51bSBpb21tdV9od19pbmZvX3R5cGUg
KnR5cGUsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqZGF0
YSwgdWludDMyX3QgbGVuLCBFcnJvciAqKmVycnApDQo+PiArew0KPj4gKyAgICBzdHJ1Y3QgaW9t
bXVfaHdfaW5mbyBpbmZvID0gew0KPj4gKyAgICAgICAgLnNpemUgPSBzaXplb2YoaW5mbyksDQo+
PiArICAgICAgICAuZGV2X2lkID0gZGV2aWQsDQo+PiArICAgICAgICAuZGF0YV9sZW4gPSBsZW4s
DQo+PiArICAgICAgICAuZGF0YV91cHRyID0gKHVpbnRwdHJfdClkYXRhLA0KPj4gKyAgICB9Ow0K
Pj4gKyAgICBpbnQgcmV0Ow0KPj4gKw0KPj4gKyAgICByZXQgPSBpb2N0bChiZS0+ZmQsIElPTU1V
X0dFVF9IV19JTkZPLCAmaW5mbyk7DQo+PiArICAgIGlmIChyZXQpIHsNCj4+ICsgICAgICAgIGVy
cm9yX3NldGdfZXJybm8oZXJycCwgZXJybm8sICJGYWlsZWQgdG8gZ2V0IGhhcmR3YXJlIGluZm8i
KTsNCj4+ICsgICAgfSBlbHNlIHsNCj4+ICsgICAgICAgICp0eXBlID0gaW5mby5vdXRfZGF0YV90
eXBlOw0KPg0KPnR5cGUgc2hvdWxkIG5vdCBiZSBOVUxMLg0KDQpZZXMsIHdpbGwgYWRkIGdfYXNz
ZXJ0KHR5cGUpOw0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo=

