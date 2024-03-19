Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF6DC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 06:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmSv8-0003SI-Fk; Tue, 19 Mar 2024 02:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rmSv6-0003S9-3e
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:25:56 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rmSv3-0005GH-PN
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710829554; x=1742365554;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KN51JoQj6avUM3QzPZkxYvFwCcE5cOau9ekC9Aucmo8=;
 b=ESxIX0mgr2cL4K2Dgt3QcsH64vc5zN6Dxvix/nd1Pit9mgfWOrydPBud
 9xFWfE/AmyYncooCxEjyj9UtbqixZpLdZdMUiSpb8RZeGXyhUsIg9zfa9
 e+HfJbqLLLTIBRtfZcycgyovtd5cuOr4QN+xqnoM8hPgMlbQ/OJJQMt8x
 AxgrCxueaNAPdfK921dRPHIBSg/ptr7gOuKZF5xqvrOC+TETt1q/sXW0B
 STb0HaJ5kJ0mZ8GSV98qwl50ZaD08uqAlBz0r4y7Sg7pGbq4cGDtg1KqV
 sJTecXNkA+MEWDw3kv6rOJNXmq9jlCTfqQ49SOhP4ZHPD0FvwWboH6Umt Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5536492"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5536492"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2024 23:25:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; d="scan'208";a="13596450"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Mar 2024 23:25:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 23:25:47 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 23:25:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 23:25:47 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 23:25:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwQ8/juh9AU25MElqB125UY/vxstl7XJLTYEitbudJuncn78Xmk820Te7HCbEMB5q2R1tZLLzjXsKDp1ZqHePEyX8D3AfQc2uZ8x6Hp7a+8xzBZTy4+B8jEN6NSriRL1Yp/WAy7iYFctB5L9M70BD2q76MvmSLthW2kip2hP/EbMa8a642MZUNPpElK7d+GznfL6jtRNvAxdby5mihP94jCqP9qn1x3K6GDUE1LOl24Jb/8uexp6VkTf8eCLs4jSXqc/sX1q0F/7AuQdgtiag/4tv2Z8d0JRjAQNqM/qbLG6TV1+Tqri2eQgT8Iz1sXoSEtzCICwpBZ5evtuy9nLoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KN51JoQj6avUM3QzPZkxYvFwCcE5cOau9ekC9Aucmo8=;
 b=oE0o5PBF6eHy0FdxXcDNlriPVNzOc2kq/tHq9YYuvTprCsinDFG7vKS6O4eDJ7ZBdyfB47eW1524XMBk8VUerauAF2Vmoo0GTKOZl3A0yAzM23CHf12RipGBXrVFpfS7LflPMW3/SA+hlEMWgfcontP4tftoOCdbLESZ15aol0auNIs+dr+88paYP9Gv4ZxTnGoaYs23R2BlC2LQkzFSiHMmj44WJo57wrTVTiJQlafw1XMZwLmnNW0OM3c7dZO9P3/kqr4LuM4wLdUrcnTKw0OXYoPsj+gU828xA1tW1wdavgI+o3RniW1uBIXIIJAIcGZuZU/2CFp5x2Jr8XXhhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA0PR11MB7332.namprd11.prod.outlook.com (2603:10b6:208:434::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Tue, 19 Mar
 2024 06:25:45 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 06:25:45 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Joao Martins
 <joao.m.martins@oracle.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>
Subject: RE: [PATCH v1 11/11] backends/iommufd: Introduce helper function
 iommufd_device_get_info()
Thread-Topic: [PATCH v1 11/11] backends/iommufd: Introduce helper function
 iommufd_device_get_info()
Thread-Index: AQHaafrjxYbPMyM3Lkunl/lFJM1cTrE9tHaAgAAD/QCAAACygIAA1hng
Date: Tue, 19 Mar 2024 06:25:44 +0000
Message-ID: <SJ0PR11MB674492D89A53BCE6C0A68946922C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
 <20240228035900.1085727-12-zhenzhong.duan@intel.com>
 <db2f0780-7817-423b-a286-c3c67b95367c@redhat.com>
 <71a09333-8fe8-4313-951e-b76417b45c13@oracle.com>
 <ca9b6f89-db51-4fce-93f1-b0bd8fb4cf1c@redhat.com>
In-Reply-To: <ca9b6f89-db51-4fce-93f1-b0bd8fb4cf1c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA0PR11MB7332:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kA5AAiRnJVQnSYTwfX+Vjkz5oPGZ/AEhw8JzDw7wvXBcYGWULPYlUKewPdhhftRqiM741u9IRsFh5eHdQEXlJZFgASUNtRmtY0h7nJr+h1yEBHq+LZMvsGL/3FE4FNfVvUzKNvaPJo14kf4thOX3JLxINHAnEL/9rpF5rSVYhbipGdjJvPJJFksHPitho+WvgktQ0SS4eZc1k794jJzjA5/6NE8THjHEewXggiKYxQm0rP1dsvhMPWzDQlRw76MovK3Rx9+gwHGmtLWYKoXyf3F9nS5v6q13MNNOjcfMMTOJba301qU1yIFtO1swzntHo6pg1fadnkUjRlX347hJIJ03bAfbaaNfBrW5zj9uwn1PZMO3acgH8Kd/HZPhTPLghN81kVTDFNmNpTqGoEBrVwTxekk+0RORmUpeQZKNP02u4ppaJQdvdoQ8Orc4iyByuPoDsu2XAEHJ6MdQe3vtSkxISnxzMBgz78zDH/mtBL4ob51KMdMKmPQmxBadsedK0ocgCdN7JIX5kQ+wXp/I9SWxZ71iZiK50tgpKA0w2la7yllQXXDRmCoi5NXuYEOpEUTKDHzLJe900k1KN4HeQBFxEPbdsmFCHDM0zKT+2aI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(7416005)(376005); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkV4V2EvR3k2L0NEc3BmelRGSXFEZmx1Y1JoZkVFdDd6a0lmQnFFUm4yaG42?=
 =?utf-8?B?Mk1KVzhLT2dncVAzMm5TdW5SNmNOaEtPV0NGSzlJZzlTeDVhSHowRjZxSE1o?=
 =?utf-8?B?VE96VGZLRzBSajhSak9mdks4NHY0WnQwRENCRUpLdWg0MTFMQ0dRSVhqM0JE?=
 =?utf-8?B?TkFib05xenVBQzM3YkVOaHE5b3pxTE8vUUhBWUJXQm9KUWxVVlVBODd6N3M4?=
 =?utf-8?B?L05OQXRMbXNtL3p3Y2RUbnpHRWhNQklPazdDa1ZBazNnNUw0MXlya2FmdS9q?=
 =?utf-8?B?cE83MXA3b0VMZk5yTzdac2Rma2p6UUdNNGw5ZFBreUlUZm1rMHoyTHJxbTRY?=
 =?utf-8?B?bVhLLzdWMm54cUtFbVBHVVV6cVZGMTYyUmJVbEJXaiswb3ZsY1U0NkVma01z?=
 =?utf-8?B?R2tld3lyK214bHQ0Zmt5QlJDazR3aUpIaUlOZ2tVdnFwdENLOG1mUXFZYlQ5?=
 =?utf-8?B?SEpQenlSYWowd01xNk5VdDBFRGo0Q2pEQnRETVZoYXdIZ2Z1N2xsZ3Q3TC95?=
 =?utf-8?B?TVpXVEYwQSsvQk1PVzZkdEt1ajN3RWVQUTQ0Y3dLZzN0bnRzbi9tdUtVVlMr?=
 =?utf-8?B?ZTBEWE9Ub2Y0cXhHWVB2V2RMMzNITVpRZzVTVjIvSCtwUGR6OUNmc2c2V1Zm?=
 =?utf-8?B?NFhZZHVlZVRvVndwZmRBb3FIbHdSQjJaL1F3TEhmUVhZcGplYjRkQVJsUmR4?=
 =?utf-8?B?UlhLUnBlSWJvdXhuM1g0eC90bUgxNmpHMmYrYm1SRjFKVVdXY0V5TWNGeVUr?=
 =?utf-8?B?c05hM2swK3BYQ1JQdWhmdXNVNTQwSmFNNzNOVFU2LzVLUm93SzJRZVhyek1v?=
 =?utf-8?B?MEFpaHV5eXh5aGt6NWhFRk9GNTF0NHNON3pRdStkUjErK3U1WnRlQUE4SDlp?=
 =?utf-8?B?V2hXRjJISWFINWpUZkxmeDlrWnhUSmZJZmVtVXFQMVVYajdiTmtsaU5Rblh4?=
 =?utf-8?B?ZjgxcUVWRlE5VlgxU1FzWlpsUFJZYUc3RVluRVQwSTN1b1RrMW0xV1A3aXpJ?=
 =?utf-8?B?SG4yZng2clVUK29zTno2ZnNaaEdwWGZrbnRyUzRoM01vcEdxbjFnL0tFVWRp?=
 =?utf-8?B?RUlTUUFZZ0cvZXFreUN4aEd2TTVIK0ZadWNidVUvSkprZ0xsNDQyc3R0RnpB?=
 =?utf-8?B?UDZJYlRtZDdyQXFpVmFQMis4V2VOanFnMlVXZVFLdy8rcHFWZDloVmU5TXpx?=
 =?utf-8?B?U0hCL2VnOCtlOU8vcytOcGU2T0VJNVg0OEh0Uk12Ti9OTXFTTlZ6RUpGdEx4?=
 =?utf-8?B?cjIvT1NnWWlzMFRCNHl3TWFQc2hvWkRFalV0VVh6bEhLdmxjbCtaRXJlRzZs?=
 =?utf-8?B?L3dOWkpSSG02SlorRHliNXduNnFBRmNoTldCaVAwaUg4MFpUVVhVZzZkU2Z1?=
 =?utf-8?B?bTA2RWFLdGZMMVpPOW9XeElMTjZCc1ZxeCtCajhIa3hqUzNJU0kzTk45MTFy?=
 =?utf-8?B?SnA5RG1EWnd6N05WUVM1OUIxbnFQdmlXTjNCSWhSNm9VeXpVS2tUMzNUYkFw?=
 =?utf-8?B?L1NCYktKQ0hmNVBzdlVPa1pSUUJRR0ZiekJKTVoxUFc0QXlZWHFTeVFpSHMz?=
 =?utf-8?B?MVZWK281dVNZYjFpdEJCS2RDV3RTSmZyanNFWjhBUk1xWWo4RlovaUMvRTdv?=
 =?utf-8?B?ZG04STcyUzU5clE4eklRRm45NTBkY1ZNN00xQkU2Ui9rOWJyd25PTlJKcndC?=
 =?utf-8?B?N3lLU2FrV2d6VXJWbERJb3VaRkJWWWJMRkRrbHNUbWVMWG9Yb0Q0ZnZpSktR?=
 =?utf-8?B?WG1Ub2ZscnNYWVlrV0FLVmRJZ0dPRFBEaDZ5QkRVU1lVVzA2Q01YQk54aTQy?=
 =?utf-8?B?QmZMQ0lSWnprL1QzYUszb2FlQU5oQyswYzZybHRkS3FjdVUzUGRHRngwc3Rk?=
 =?utf-8?B?bG5KYi95ZndERGs2OUYxN1FKYnZCWDUrSFNlSUk4akRSTCswRzlhN2JWL0dJ?=
 =?utf-8?B?M0d1b0phNkxKRDZweG9JOU9qdmg2alNSOHlNKzdIWDVBSXRBN0VGWUl3N1Q4?=
 =?utf-8?B?dytadk5jMkY3MGg2WWJkeEdab0dia0E1NklLTUs5dUtOL21DcnZnOU1rT2pW?=
 =?utf-8?B?dHNieFZOQ2dnbVpvYWZHYzYrZVcxZHROYlRGOGFtbWtDWU81RlpHYzJoQmxy?=
 =?utf-8?Q?RrjR7mpvgIp3e74MRVPhfY7YI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41594482-205d-42f4-d675-08dc47dd68b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 06:25:44.9258 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O3aiUtitz3iJDnxkV8zKxNZaErvpzvcRRB1SYShW0UtxFXxAowL6xhS8ym8Sshwl3irVh0SMD3F5UUEsjNRvaaxYaDR6M2ve6/UpKdKEKS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7332
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYxIDExLzExXSBiYWNrZW5k
cy9pb21tdWZkOiBJbnRyb2R1Y2UgaGVscGVyDQo+ZnVuY3Rpb24gaW9tbXVmZF9kZXZpY2VfZ2V0
X2luZm8oKQ0KPg0KPkhpIEpvYW8sDQo+DQo+T24gMy8xOC8yNCAxNjowOSwgSm9hbyBNYXJ0aW5z
IHdyb3RlOg0KPj4gT24gMTgvMDMvMjAyNCAwNzo1NCwgRXJpYyBBdWdlciB3cm90ZToNCj4+PiBI
aSBaaGVuemhvbmcsDQo+Pj4NCj4+PiBPbiAyLzI4LzI0IDA0OjU5LCBaaGVuemhvbmcgRHVhbiB3
cm90ZToNCj4+Pj4gSW50cm9kdWNlIGEgaGVscGVyIGZ1bmN0aW9uIGlvbW11ZmRfZGV2aWNlX2dl
dF9pbmZvKCkgdG8gZ2V0DQo+Pj4+IGhvc3QgSU9NTVUgcmVsYXRlZCBpbmZvcm1hdGlvbiB0aHJv
dWdoIGlvbW11ZmQgdUFQSS4NCj4+PiBMb29rcyBzdHJhbmdlIHRvIGhhdmUgdGhpcyBwYXRjaCBp
biB0aGlzIHNlcmllcy4gSSBXb3VsZCByYXRoZXIgcHV0IGl0DQo+Pj4gaW4geW91ciBzZWNvbmQg
c2VyaWVzIGFsb25ncyB3aXRoIGl0cyB1c2VyLg0KPj4+DQo+PiBUaGUgcmVhc29uIGl0IHdhcyBo
ZXJlIHdhcyB0byB1c2UgdGhpcyBoZWxwZXIgZm9yIHRoaXMgcGF0Y2g6DQo+Pg0KPj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI0MDIxMjEzNTY0My41ODU4LTItDQo+am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbS8NCj4+DQo+PiBJbnN0ZWFkIG9mIG1lIGhhdmluZyBteSBv
d24gYWx0ZXJuYXRlIGhlbHBlci4NCj4+DQo+PiBUaG91Z2ggYXQgdGhlIHNhbWUgdGltZSwgWmhl
bnpob25nIHdpbGwgYWxzbyBtYWtlIHVzZSBvZiBpdCBpbiBoaXMgc2Vjb25kDQo+c2VyaWVzLg0K
Pk9LIEkgdW5kZXJzdGFuZCBub3cuIE1heWJlIHdpdGggZXh0cmEgY29tbWVudCBpbiB0aGUgY292
ZXJsZXR0ZXIgdGhlbg0KDQpXaWxsIGFkZC4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

