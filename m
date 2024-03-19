Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F73AC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 06:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmSvR-0003To-C7; Tue, 19 Mar 2024 02:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rmSvP-0003Tf-QM
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:26:15 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rmSvN-0005HI-Uo
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710829573; x=1742365573;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nG2aDPCadsneCSZBmcJfUwieZMKij6Vo+syqtUZlVjw=;
 b=YkTTvH1WbEwXzH/xSwK87Fz09F236xR5yzoMKlFnNGNCcWwDrlbTtsuP
 PdTkiA5bCX9sLmktmYTgnJs1yLZqp2Y3Tbzi+HSe5CR/ghiMnq8hSmcGl
 Z9keRpNtSkpk8EETku6zQ+EyeM30p0QTcLF3V6RVsaBy9zp94w/nd1I5O
 eK6DWBw/Sax1mQdu3rjOQafcFlJzNvzLOaOdau9lXwj9frfK24i67yOYk
 kMlQPhL4iHX+p5TJoMLKFbstRFnh4z5dosSvgJHCcEBQ6QLPqyyWWrAZw
 5LQubaYe2e7SiGLyDr1voyLdY2USG15ly0Puvu88wP35TdafMWQOIx4l+ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="16219580"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; d="scan'208";a="16219580"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2024 23:26:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; d="scan'208";a="13741155"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Mar 2024 23:26:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 23:26:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 23:26:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 23:26:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNcxlkmLUaB9EAvcLFnr2dmeao+cCTOF3L+MV/KEsXJo2IdxUm346dWIVrgxURdKXKcKbSXilodL5hTuhHGZGU4369yV3tJH9Y96xesTwCSeIAqJJges89Z8tyHt4yJwOkD9CAcZYyqXR+ORm9k/kbZ9qm/rkKpDxngX5AT6hkRb2Bm+54TnFhHNatPdKtO9FggsvLmsg2yhERTr5ghCP7NwQm0GUeCJNpN+r/LgAxMK9wsVzhBxpa+PG5VLYZobpbU2z5i+UOQx6cpdblvf5I6HjC8k5KIpwQZ//H/QIjBG19pmVpUXyNlhXM+rHjqUE+QMqNKWuE0eanNJoVEG1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nG2aDPCadsneCSZBmcJfUwieZMKij6Vo+syqtUZlVjw=;
 b=mw6lhmcYJal0tFv5wuwe+Z3mLFgrHYzItQYCc1AlyJatLkLuDdxZBk1Zk9t1D4QsU1yaHVq3mg6RF2bZq4I9XhQfSF5hZVwOXCMoPe5yK/O2dEZrrG85ayeIfM4catkaidX+B1yhhdJ/wM2knxCpvIoNqUScjAMvrn1qBeVVTd+6Wyjo5qAPk2HN7+rRS9VLCJE37V4Kt32ZVxmtgffr9rkHEubBO4rxX+bQnxQldl+/6n5Bs2YleBUzDDtM82Z2bKCxZ3sHy//YoKS0t5rd4y9YGt1g/YEumB9rImq/OqmwSc6p8QMikCrA16bFD4Z8UijHnhtvC3k5hAZiL0q5gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA0PR11MB7332.namprd11.prod.outlook.com (2603:10b6:208:434::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Tue, 19 Mar
 2024 06:26:09 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 06:26:09 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v1 00/11] Add a host IOMMU device abstraction
Thread-Topic: [PATCH v1 00/11] Add a host IOMMU device abstraction
Thread-Index: AQHaafrIwqLFNVp13kCsmCmAvwNwMrE9tUIAgADaPQA=
Date: Tue, 19 Mar 2024 06:26:09 +0000
Message-ID: <SJ0PR11MB6744E22349A89016C83BA8C4922C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
 <0d8cba1e-a422-421b-9c02-c60452cf5f80@redhat.com>
In-Reply-To: <0d8cba1e-a422-421b-9c02-c60452cf5f80@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA0PR11MB7332:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5ZlBIAB8EvtImxhrbBMZEoY9HdsKwE68tBxxaRnti8Zi37d1bDfmuuODjz/uNsAJHYMusCP20gi1Wgnm3dUTGsUYIKr+5CuiEVNyO6pXPayww2Ig8N3PcHMt3Ztdvi8n3YR+y6zRY/aPg/vWV2mZqoEf1fFlghKZp+PQkDzH4g2WsMlZy+Z0Egv5CKZ34RDN8TYUcPd9P3yITlGj3zgXARNR0kW31mhCu/cvXCqghbiyGHe1UiRCIkoY7lucSK4RoWlFveu3R2WZYwdnZF7Q2Z9bMcIIpihXyZLVCqZl9BAdrKRncDTYQiky/U63RITGyuX4dZuQGkQqqN2ZWRDvQB/pGVf76NE/NRQ1qkKsg+URDa7SLOnaP/7+md+QdWrdcOcpTzQzgymxj2xwwThNkoDi5sV6FasfmXt+USgKW5k7mGBBFuBp4YhnTTvH8IWidLRkyUUshz9ITIg5cWTY57P7vXVDz8W/3dhQyz5d3skgYisnkhl2eCiWwHzensYldzYSRITR8er9t5i5eSed/6KW6Upv53eX20bYVgkkSsbVkIQMFgMLEbf0upluhj1Rnld7xLzRRqzg7fTR86w6CKySlFbl4FIEHIn0q5fKPl85ryQRU1Mt6JfWHPEVzWal
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(7416005)(376005); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXV6SDZ0WmoxUXVXbE10MVlGRW9FSWI1R1pjMlVwNjhNbUJPS2RtbnBaYzFv?=
 =?utf-8?B?NktNbmszQzlRdmlpNlUvYy82YjdqQmF2dVJUak5JazJ3VWpjOFp2cGR6TWRm?=
 =?utf-8?B?UVB4ZjNEM2NIUUlEczVIeVhhTC9ZMWhSWjlIOXVSODBNRVFQNnBJUitZNEhZ?=
 =?utf-8?B?cTE5REtZZW1kcTd5VjFHQ2E2bnR4V1M3KzFXako3NnF6azZ2N3JNZlVPSHh5?=
 =?utf-8?B?bW5Zd2ZJV0JSS0xjcklXZTIrTjNmcjE2K1N4ZGhEOWVZUXpHc1RiaVV4QWlp?=
 =?utf-8?B?SlFwck5UaGlEaGxkVHYzYkZ5MDZkdjA2V2ZJQXRreFM0S2Y2YmpWTmxWR28r?=
 =?utf-8?B?dDBxbHlHemxzSlBIUVZMUDh0eGx4STZVc1hVWEo5NDV5ajQ1a2V5NjFGTVJZ?=
 =?utf-8?B?M0NuM3RKUmo5b2dDVWJHcGFiUWVMbk8xR2NnZUFLTVQyZXl0SnRZRmI4WElC?=
 =?utf-8?B?NmpCYWhaNDh2T2JtUGpqTng2a2ZFeGEwS203NGpFTnA2cDRWb05PWDRlUVA1?=
 =?utf-8?B?MUhxTG1QZHE3ZEFieGxrN0dvWlBhUVhhM242cVV4TGN0Wm04T1QzdmdkK2N0?=
 =?utf-8?B?dFJ6dzFVd0I5YnR2TjQ0Zlk2cC9lQ2tVampPaDBObERIcVVYdlNWK3dyTWor?=
 =?utf-8?B?c2tPZSt4eXdwbE4raTg1YlQ0c01EVE5UN2dLKzBTUHQ2K2htWFN3NC9XNDFC?=
 =?utf-8?B?cWJCVit4aUlMOS9WYUxMdWlCZnE5R2RhOWtQUGdvd3lsb3FDU2NhSkZyQnFw?=
 =?utf-8?B?bnNad0Uwbk1rTU5CbWtoWC9YSUNSS2VuY0Q1bllIdUhVdHdIOTNIU2E2WElT?=
 =?utf-8?B?eVV6dVNDS1NmcWpNYUFxR29ER2dZSzJVcWJrRlJGMlIybldtNTBQcmZJYzR2?=
 =?utf-8?B?ZW1UQStCdGdrZU9tcVVYVHlXZmxXMXkrNTJiTlpMbW95SDMrNGd2ak5TRFRE?=
 =?utf-8?B?SkRxUXJDUDZuMjZPU2FWMWErU3RzZU5jOHdsNmJPbU1HdlFDdXZJNTZVL0ln?=
 =?utf-8?B?eW45UGdWblg3Y0plWUsxeW1NY3dWTUlGRFpZcWIvUEVwbjh6Z0FXTjQwSWpW?=
 =?utf-8?B?SjdLa0Fsb3lISEduTjN0eEpTSFpHYTRMTmJOeHVIZnlvd2NheFZBaGlIdkc2?=
 =?utf-8?B?b1ZDZmJGeUpYRDFGWnc3NHdkREQyYlNvYytZOXRNVklMV0dodTdWbUdaOTNL?=
 =?utf-8?B?ellQa3Z2cWZ1amYvVnB1UkFlQXZmMWI0V24yNnNxMkV1a2V5anNmbkdFZml1?=
 =?utf-8?B?U3JJcW9BZXJmWjNJMFNrc2h2UnhCVHhmZHZFb2g1K3FFWlBmRkl1N21oeEdK?=
 =?utf-8?B?SnlzdWNjZ1kvY2wwQjhjOUtJb3dBZktuYWtIWkZ4eE12V1JkNTdyZGoyb3g2?=
 =?utf-8?B?a2N5dkJzU1V5QSt6RlNnVFFrTlQ0dFFxaGhHWWlyd2VGUDRnY1JFUFRuOGxv?=
 =?utf-8?B?U25wWkoxUUx2NzF1Zjk5Q1FDVUZYWEFrWXhLeWNvQXA0MVBBU09lcS9UeEhq?=
 =?utf-8?B?OUFSVWpMUWtmOU1TR3c1aDdNa3lsSjA5MzhLS3NLZE93KzlRdFJSa2g1ci9O?=
 =?utf-8?B?bGhyRldDcllWQjk2VE53WUpkbStLdVE4MnlMSklyMW1xSHM3Nm5WbU1TdkRS?=
 =?utf-8?B?aWJtcXBQcEJPaS84OEVyVWZZWDZCRi9hMEJtNG9PcHUxbUR6S0ZQa2ZWMjV3?=
 =?utf-8?B?ZjErZjE3R0tWeDBvdVV0UFM4RCtSTXRiMkJTaldNUnpFY0U3bjkyWGYvUUFC?=
 =?utf-8?B?d2ovMHlVbGNlQ2Nua2Y0a1I0aDUrNUljQ29CUHBEQW1odWd6WWNyWHFIK1VQ?=
 =?utf-8?B?UEJoZFp0WnJRS3NDb24xblZoMCtwRmdBNnIxby9rRVJKYmp3Q2IxaUJkRi9v?=
 =?utf-8?B?OTE5K200NjN0UmNQZ0w4VWxiTGcrRmhqYWZwcW1NU0VQSDJvL29LUjBaK0V6?=
 =?utf-8?B?SVJiZWlPTXNwNUNwTGs2YzNuaVVkK29LMGpBWkZpVWlUcktNNEdEd1ViTFZD?=
 =?utf-8?B?Z0wwbEJwUVpJaklmcktuc3E4OVphZkUvUitlMWpjamp6L3BpTmVxdDFEeEZZ?=
 =?utf-8?B?M3k3UU9UQTNwMEI1L0NJcmhFLzQ1eWs5UFdiZ2d1Z3FDd0s1U0tiRGpXM3hj?=
 =?utf-8?Q?I97eBbGEzci6FJ8nSUlrCIitb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61830eb3-60b4-4b40-bf57-08dc47dd771a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 06:26:09.1280 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rq67Xz5kEUuY6wQS8TdnCbAvPimv7TKe3MGqPhm7icrGEkqgpWpDZs0Fr4xowrlku13R+ePDA5yB5iNo5gkaVrMYfEc4pYxM6kefVxAfzyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7332
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYxIDAwLzExXSBBZGQgYSBo
b3N0IElPTU1VIGRldmljZSBhYnN0cmFjdGlvbg0KPg0KPg0KPg0KPk9uIDIvMjgvMjQgMDQ6NTgs
IFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gSGksDQo+Pg0KPj4gQmFzZWQgb24gSm9hbydzIHN1
Z2dlc3Rpb24sIHRoZSBpb21tdWZkIG5lc3RpbmcgcHJlcmVxdWlzaXRlIHNlcmllcyBbMV0NCj4+
IGlzIGZ1cnRoZXIgc3BsaXR0ZWQgdG8gaG9zdCBJT01NVSBkZXZpY2UgYWJzdHJhY3QgcGFydCBh
bmQgdklPTU1VDQo+PiBjaGVjay9zeW5jIHBhcnQuIFRoaXMgc2VyaWVzIGltcGxlbWVudHMgdGhl
IDFzdCBwYXJ0Lg0KPj4NCj4+IFRoaXMgc3BsaXQgYWxzbyBmYWNpbGlhdGVzIHRoZSBkaXJ0eSB0
cmFja2luZyBzZXJpZXMgWzJdIGFuZCB2aXJ0aW8taW9tbXUNCj4+IHNlcmllcyBbM10gdG8gZGVw
ZW5kIG9uIDFzdCBwYXJ0Lg0KPj4NCj4+IFBBVENIMS0zOiBJbnRyb2R1Y2UgSG9zdElPTU1VRGV2
aWNlIGFuZCB0d28gc3ViIGNsYXNzDQo+PiBQQVRDSDQ6IERlZmluZSBIb3N0SU9NTVVEZXZpY2Ug
aGFuZGxlIGluIFZGSU9EZXZpY2UNCj4+IFBBVENINS04OiBJbnRyb2RjdWUgaG9zdF9pb21tdV9k
ZXZpY2VfY3JlYXRlIGNhbGxiYWNrIHRvIGFsbG9jYXRlIGFuZA0KPmludGlhbGl6ZSBIb3N0SU9N
TVVEZXZpY2UNCj5JbnRyb2R1Y2UsIGhlcmUgYW5kIGJlbG93DQoNCkdvb2QgY2F0Y2gsIHdpbGwg
Zml4Lg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+DQo+RXJpYw0KPj4gUEFUQ0g5LTEwOiBJbnRy
b2RjdWUgc2V0L3Vuc2V0X2lvbW11X2RldmljZSB0byBwYXNzDQo+SG9zdElPTU1VRGV2aWNlIHRv
IHZJT01NVQ0KPj4gUEFUQ0gxMTogYSBoZWxwZXIgdG8gZ2V0IGhvc3QgSU9NTVUgaW5mbw0KPj4N
Cj4+IEJlY2F1c2UgaXQncyBiZWNvbWluZyBjbGVhciBvbiBjb21tdW5pdHkncyBzdWdnZXN0aW9u
LCBJJ2QgbGlrZSB0byByZW1vdmUNCj4+IHJmYyB0YWcgZnJvbSB0aGlzIHZlcnNpb24uDQo+Pg0K
Pj4gUWVtdSBjb2RlIGNhbiBiZSBmb3VuZCBhdDoNCj4+DQo+aHR0cHM6Ly9naXRodWIuY29tL3lp
bGl1MTc2NS9xZW11L3RyZWUvemhlbnpob25nL2lvbW11ZmRfbmVzdGluZ19wcmUNCj5xX3BhcnQx
X3YxDQo+Pg0KPj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNDAy
MDEwNzI4MTguMzI3OTMwLTEtDQo+emhlbnpob25nLmR1YW5AaW50ZWwuY29tLw0KPj4gWzJdIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNDAyMTIxMzU2NDMuNTg1OC0xLQ0K
PmpvYW8ubS5tYXJ0aW5zQG9yYWNsZS5jb20vDQo+PiBbM10gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvcWVtdS1kZXZlbC8yMDI0MDExNzA4MDQxNC4zMTY4OTAtMS0NCj5lcmljLmF1Z2VyQHJlZGhh
dC5jb20vDQo+Pg0KPj4gVGhhbmtzDQo+PiBaaGVuemhvbmcNCj4+DQo+PiBDaGFuZ2Vsb2c6DQo+
PiB2MToNCj4+IC0gdXNlIEhvc3RJT01NVURldmljZSBoYW5kbGUgaW5zdGVhZCBvZiB1bmlvbiBp
biBWRklPRGV2aWNlIChFcmljKQ0KPj4gLSBjaGFuZ2UgaG9zdF9pb21tdV9kZXZpY2VfaW5pdCB0
byBob3N0X2lvbW11X2RldmljZV9jcmVhdGUNCj4+IC0gYWxsb2NhdGUgSG9zdElPTU1VRGV2aWNl
IGluIGhvc3RfaW9tbXVfZGV2aWNlX2NyZWF0ZSBjYWxsYmFjaw0KPj4gICBhbmQgc2V0IHRoZSBW
RklPRGV2aWNlIGJhc2VfaGRldiBoYW5kbGUgKEVyaWMpDQo+PiAtIHJlZmluZSBwY2lfZGV2aWNl
X3NldC91bnNldF9pb21tdV9kZXZpY2UgZG9jIChFcmljKQ0KPj4gLSB1c2UgSG9zdElPTU1VRGV2
aWNlIGhhbmRsZSBpbnN0ZWFkIG9mIHVuaW9uIGluIFZUREhvc3RJT01NVURldmljZQ0KPihFcmlj
KQ0KPj4NCj4+IHJmY3YyOg0KPj4gLSBpbnRyb2R1Y2UgY29tbW9uIGFic3RyYWN0IEhvc3RJT01N
VURldmljZSBhbmQgc3ViIHN0cnVjdCBmb3INCj5kaWZmZXJlbnQgQkVzIChFcmljLCBDw6lkcmlj
KQ0KPj4gLSByZW1vdmUgaW9tbXVmZF9kZXZpY2UuW2NoXSAoQ8OpZHJpYykNCj4+IC0gcmVtb3Zl
IGR1cGxpY2F0ZSBpb21tdWZkL2RldmlkIGRlZmluZSBmcm9tIFZGSU9EZXZpY2UgKEVyaWMpDQo+
PiAtIGRyb3AgdGhlIHAgaW4gYWxpYXNlZF9wYnVzIGFuZCBhbGlhc2VkX3BkZXZmbiAoRXJpYykN
Cj4+IC0gYXNzZXJ0IGRldmZuIGFuZCBpb21tdV9idXMgaW4gcGNpX2RldmljZV9nZXRfaW9tbXVf
YnVzX2RldmZuDQo+KEPDqWRyaWMsIEVyaWMpDQo+PiAtIHVzZSBlcnJwIGluIGlvbW11ZmRfZGV2
aWNlX2dldF9pbmZvIChFcmljKQ0KPj4gLSBzcGxpdCBhbmQgc2ltcGxpZnkgY2FwL2VjYXAgY2hl
Y2svc3luYyBjb2RlIGluIGludGVsX2lvbW11LmMgKEPDqWRyaWMpDQo+PiAtIG1vdmUgVlRESG9z
dElPTU1VRGV2aWNlIGRlY2xhcmF0aW9uIHRvIGludGVsX2lvbW11X2ludGVybmFsLmgNCj4oQ8Op
ZHJpYykNCj4+IC0gbWFrZSAnKHZ0ZC0+Y2FwX3JlZyA+PiAxNikgJiAweDNmVUxMJyBhIE1BQ1JP
IGFuZCBhZGQgbWlzc2VkICcrMScNCj4oQ8OpZHJpYykNCj4+IC0gYmxvY2sgbWlncmF0aW9uIGlm
IHZJT01NVSBjYXAvZWNhcCB1cGRhdGVkIGJhc2VkIG9uIGhvc3QgSU9NTVUNCj5jYXAvZWNhcA0K
Pj4gLSBhZGQgUi1CDQo+Pg0KPj4NCj4+IFlpIExpdSAoMSk6DQo+PiAgIGh3L3BjaTogSW50cm9k
dWNlIHBjaV9kZXZpY2Vfc2V0L3Vuc2V0X2lvbW11X2RldmljZSgpDQo+Pg0KPj4gWmhlbnpob25n
IER1YW4gKDEwKToNCj4+ICAgSW50cm9kdWNlIGEgY29tbW9uIGFic3RyYWN0IHN0cnVjdCBIb3N0
SU9NTVVEZXZpY2UNCj4+ICAgYmFja2VuZHMvaW9tbXVmZDogSW50cm9kdWNlIElPTU1VRkREZXZp
Y2UNCj4+ICAgdmZpbzogSW50cm9kdWNlIElPTU1VTGVnYWN5RGV2aWNlDQo+PiAgIHZmaW86IEFk
ZCBIb3N0SU9NTVVEZXZpY2UgaGFuZGxlIGludG8gVkZJT0RldmljZQ0KPj4gICB2ZmlvOiBJbnRy
b2R1Y2UgaG9zdF9pb21tdV9kZXZpY2VfY3JlYXRlIGNhbGxiYWNrDQo+PiAgIHZmaW8vY29udGFp
bmVyOiBJbXBsZW1lbnQgaG9zdF9pb21tdV9kZXZpY2VfY3JlYXRlIGNhbGxiYWNrIGluIGxlZ2Fj
eQ0KPj4gICAgIG1vZGUNCj4+ICAgdmZpby9pb21tdWZkOiBJbXBsZW1lbnQgaG9zdF9pb21tdV9k
ZXZpY2VfY3JlYXRlIGNhbGxiYWNrIGluDQo+aW9tbXVmZA0KPj4gICAgIG1vZGUNCj4+ICAgdmZp
by9wY2k6IEFsbG9jYXRlIGFuZCBpbml0aWFsaXplIEhvc3RJT01NVURldmljZSBhZnRlciBhdHRh
Y2htZW50DQo+PiAgIHZmaW86IFBhc3MgSG9zdElPTU1VRGV2aWNlIHRvIHZJT01NVQ0KPj4gICBi
YWNrZW5kcy9pb21tdWZkOiBJbnRyb2R1Y2UgaGVscGVyIGZ1bmN0aW9uIGlvbW11ZmRfZGV2aWNl
X2dldF9pbmZvKCkNCj4+DQo+PiAgaW5jbHVkZS9ody9wY2kvcGNpLmggICAgICAgICAgICAgICAg
ICB8IDM4ICsrKysrKysrKysrKysrKy0NCj4+ICBpbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24u
aCAgICAgICAgIHwgIDggKysrKw0KPj4gIGluY2x1ZGUvaHcvdmZpby92ZmlvLWNvbnRhaW5lci1i
YXNlLmggfCAgMSArDQo+PiAgaW5jbHVkZS9zeXNlbXUvaG9zdF9pb21tdV9kZXZpY2UuaCAgICB8
IDIyICsrKysrKysrKysNCj4+ICBpbmNsdWRlL3N5c2VtdS9pb21tdWZkLmggICAgICAgICAgICAg
IHwgMTkgKysrKysrKysNCj4+ICBiYWNrZW5kcy9pb21tdWZkLmMgICAgICAgICAgICAgICAgICAg
IHwgMzIgKysrKysrKysrKysrKy0NCj4+ICBody9wY2kvcGNpLmMgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgNjIgKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+PiAgaHcvdmZpby9jb21t
b24uYyAgICAgICAgICAgICAgICAgICAgICB8ICA4ICsrKysNCj4+ICBody92ZmlvL2NvbnRhaW5l
ci5jICAgICAgICAgICAgICAgICAgIHwgIDkgKysrKw0KPj4gIGh3L3ZmaW8vaW9tbXVmZC5jICAg
ICAgICAgICAgICAgICAgICAgfCAxMCArKysrKw0KPj4gIGh3L3ZmaW8vcGNpLmMgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAyNCArKysrKysrKy0tLQ0KPj4gIDExIGZpbGVzIGNoYW5nZWQsIDIy
MyBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
aW5jbHVkZS9zeXNlbXUvaG9zdF9pb21tdV9kZXZpY2UuaA0KPj4NCg0K

