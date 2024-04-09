Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39599CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 03:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru2MR-0005iL-9T; Mon, 08 Apr 2024 23:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ru2MP-0005i2-9Q
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 23:41:25 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ru2MM-0000T6-FE
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 23:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712634082; x=1744170082;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UTsrN5l5QkxJP97kl2ZSEvzTZgm5G7mCSlyHMe9e9mw=;
 b=dv2IMJzkv7rUaMP57LgEtWs4e3Z66Y6GWIIO1ztul5GBe4DyPNu+5rPA
 zqdb7I334m16TifQm2qolonbzbeCFGAXbp9M//pZRzIRECxIIyrv4OeYt
 czNo6PIe9ufhJPC709ZO9UZZ6Y62ch7wuAn2aJiK85LpN6HSJGYiE8qB+
 pnRMCsdYODrN8Nb05qwVSQ0K0RTo6ZAGXuwkM9lu6hJvVfoHM2NIDVt//
 e0WOrPghmFCRwZMA/vaSi6Ge5bzeR1mgODN+IhTqh6PrVhl1YFb8DuCM9
 gliWTHUIN84N9AQcPHKiWewvG4zQDdGDYcCSIDxm+EFkbXU0/eEgqdN49 g==;
X-CSE-ConnectionGUID: NTxVZj6jQByKdhufjMra5Q==
X-CSE-MsgGUID: n0pSRmS9TJSTwslUZlF40A==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7790743"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="7790743"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2024 20:41:19 -0700
X-CSE-ConnectionGUID: 5Odg4ES5QHmDpMYrTPFrEQ==
X-CSE-MsgGUID: 5UkRyld2Qs+hJ7b+3RKoqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; d="scan'208";a="24831974"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Apr 2024 20:41:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:41:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 20:41:18 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 20:41:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEKnOZuCqcmD+0QAiCZO9j2nqo9FkgTV7SJXgk2kn36zZ4TejIg3BHJ0v0uCMSKw1bNygJIQz9sU0MOPuKY6AzaB5T5XAS9TpYDJvcVlReL/mEp3scuk0ZPpFcGCWapXQfLF0CpjjT/akQzxB7KnxAv+n1g9Ui97wgZ182AW3mWkS3qchqZhI67xCmP1geDo9pqGMsTXWKb33xV4IpJUhlC9sIUB7VQ9Gk/4qQ5c7lcPcYSWBrHwBgXr/0T/bNLIDb5gt67P+BNvuEZ99RCi5jyP8kias4jt7b0DkalQezWxeZIEheI9VUoLXViIQRZLZAHQAzk554C4FTqDG0GGzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTsrN5l5QkxJP97kl2ZSEvzTZgm5G7mCSlyHMe9e9mw=;
 b=Q0ZizAAvqwdWjX61xXJi19khrxaMqG+Hqq8ZkJUywR3PsTzqER2189kPJT9PD5lsC5PgpwzxpGiM5mYEtXjSDQpzzoe/N5CJmfTnwfipOuKUt8YPmV2XXBN+ymxlgWHzAeNcXsHVXb5JyKKzWi5ebHutbsMFCv62nJYp1eSKeLH4LK0mUtDdVMSjLFkh4W2cZXO1l05KiCM/gXsAnfhwvjPjoh9ROwXmvmRalyfTqFZUmINP+IeTjYpBz/qh/5UB3P0ggIdE3Jz5zzcCJxtECbdgp7uPqcUd9zBW+Zsh+hZ2J5zq+Y5/zg8z+eqAUmZc0qUc3ZVnzdDSRQ+keK4DRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15)
 by MW4PR11MB7102.namprd11.prod.outlook.com (2603:10b6:303:22b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 9 Apr
 2024 03:41:15 +0000
Received: from PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::7055:60c8:d130:409b]) by PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::7055:60c8:d130:409b%4]) with mapi id 15.20.7472.007; Tue, 9 Apr 2024
 03:41:15 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>
Subject: RE: [PATCH v2 03/10] backends/iommufd: Introduce abstract HIODIOMMUFD
 device
Thread-Topic: [PATCH v2 03/10] backends/iommufd: Introduce abstract
 HIODIOMMUFD device
Thread-Index: AQHaiYzv/ANc1Xxp8EunpOKN/GET+LFfS+6A
Date: Tue, 9 Apr 2024 03:41:15 +0000
Message-ID: <PH7PR11MB672250DF1A87FE32581BA83B92072@PH7PR11MB6722.namprd11.prod.outlook.com>
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
 <20240408081230.1030078-4-zhenzhong.duan@intel.com>
In-Reply-To: <20240408081230.1030078-4-zhenzhong.duan@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6722:EE_|MW4PR11MB7102:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2wIJ8v12ocdt4DD2H+XuUHAhKAdni/nrXYo65P54HN6AIOBhL6KTh+9LYP+HGveYS/wWYJPrLi2IFi9eaE/V0lpJKQ3TIrD6QZikoOiyzfP+UahX4bho32AhRxHcHg18KnPYqawGJhJwamDfdff/qQpctFH4mexMRNtho+aCbvsSQ1X0M2VB10XsfA/5dDq3ho0BdVXUa26FFm5/QEE0y3PJjG5IN3BnrNY3b60dIHgwgU0tvrOUoxxRURQO1Bd3tXq6slaf65V5tRbNwA+hyaRE9izDpGUrORXLPUj6C84M1h0KXQi0a4lg5ZflNQuBBjSfgWFUlWkLFczsvWBdb3LbRl1pUsPT8Q0WNV0bLwZD7NMaJZq3n7G2SROvie+M5UXKJxyWkuKykRTvAXOEMqzeuN4HtPBnmC8oEVgRsjaBGdWxOsYbZQYe/44M5xbHPNKMnMXgJz2GmfjsVh7zf3jejSC/M2AHDHhGRtr5HUj1fNM0zwQnDHME52bktnxx3NyEn9U3ecXyreN8I9rfvPHF/7z3mDyMJVyMoEcRGKBzKA0O5I7Y8aALHxukxg9nAvYUQ8BpgZOwGcSMrfyLMudlQD2CRIcq25xDjjasb5bVJfAIzXbqCwhornZHe48Zq48jmsAcQKjzt6/JieGJyhWz+6ycHGf7sLswkemtAs4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6722.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(376005)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXFLODVZZDBJUWdJeHF2TFVNRDRBQy9OOTd2TUZ0c1E1U0k4cXMvR3NFRVk1?=
 =?utf-8?B?UHRuaWxiSkpEY1g5M3VXN2JFcGhuSHJtNS9mTU9zM0lUWkRVTWtSc25Ca0RY?=
 =?utf-8?B?aEJiYmxweWhDelBxZXNPdHhNQUtVdzhVRExzN0VUcTZRejhVbWdmV1J5U3dE?=
 =?utf-8?B?WlR6a3VjNnV5STQ5LzVZWk5HWk52bWZOZ2FqallNczZoSjl0bE02YXRTYjlx?=
 =?utf-8?B?dkN6engxbFNKSzdpeHNQcGltcWdVbEhIbkZKZlRWT1gzOGVtczIvdFdpOWE4?=
 =?utf-8?B?QkJ1dEkvVmdzdDJxb3FpUWY5SU1xUFFXS2hybTFuc2ZHVTJ5UjAweW00YW4z?=
 =?utf-8?B?SHpwNTBxTk9MbkFUVTdZOHBGVDNZZXRUTTVNSTdxZGMvcVFZbWN4eFcrZHg3?=
 =?utf-8?B?aTJ0bmRnNVlMMExQVWRzUUlvc3dCNExDdDArMkttZjlKbC9kaTh5K2Q1eExM?=
 =?utf-8?B?VFUva2xWeGw3aWs4SlU2WExGMExVOExwSTdGcU03ZmFjSG5qVUVnS0pTSG03?=
 =?utf-8?B?dC9YTHNhTTE1KzhCQndQUW9oWm5Ca2N5bXpqZnpKTGVGK3dzczlLWG9wQ01t?=
 =?utf-8?B?S2JnaFNqY1M1UHd2RDZtZitSYmtlK09ZbXQ4REpLeE5WRVA1SHFvQVhqa24w?=
 =?utf-8?B?dE1ZNUpzK0dnT3pUV0Y0TTcxSVhEOUpYZEJSNUVGMm1IQlMvOE9LbFk3bVFL?=
 =?utf-8?B?TWFZalUrRXZDWU9UUC9ja3FJMkh6bG5HTGZKYk5lUkVQamFPczdVYWJTTUt2?=
 =?utf-8?B?OGZXaFpXVklpNk5Yb2hndHpYbFRDTDNMQ3Z2bXNKOFZWdE02Z0pDQVgzT3o0?=
 =?utf-8?B?aDlTM2JsYTdUZnlHOFRkRkFmSCtncExDZUtSMkFHQmswZ0l0Q0phb2RsVmNl?=
 =?utf-8?B?Z01yZ3RXeTNWUjc1c1ZjVWthUWE4NWtqQ1lRV3R5c0RYMjNMMFVFY3JjWEJq?=
 =?utf-8?B?RUNPQmQ0SXovNkVGV1NBdmpXcjJCUjZXcEVKN2o4aSs0OTdHRXIwVnhLQzdC?=
 =?utf-8?B?YzRHbTE3NnlLNnUzKzhzei9xNEdpdUJxWWFJYk1lVEt1ZTgwOVBKaDVRV1ZE?=
 =?utf-8?B?RGFycHJlWGJYRGNyQmFZY0dKYTNVU04rQ2xHWEpCaEtkcWMzNWJXSk9KQm1C?=
 =?utf-8?B?U0pvbE0yWXNwOUVvU281aS8zNmlhVWxMTEZkbENJd1EvZ0hmVC83NHdXZUQ4?=
 =?utf-8?B?eWhib0VRcjhUK2pRb1Nqc3ExY2FZYk5QQlVYLy9GbFB4c1E0RUcra2lFaWlz?=
 =?utf-8?B?RS9RdWNBejJWbnZ2MlIzby9RMDlhbHNIOXV6MFJLbkVtY2R5Unlvc1hOOC84?=
 =?utf-8?B?SVhuclV2V3g5UnJrN1NHd1hDaDArNmNpVHowSkJKeUw4WThyVUdsMVExUVJk?=
 =?utf-8?B?ZHpLR04wZk5EeTdidTE4WFh2RHgzQWhzM0xGUDdKRTFOaTBBNnFNQ3BoSUU3?=
 =?utf-8?B?NmUvTVYzeUlDOW9YZDUvUHBUMWVJcTJlNWZkQ0RuNzJWeUthaWlkT2hiVysv?=
 =?utf-8?B?UkE3V05IL1dGQmdrQUw2OExXWXRoZWZJUWR2cE4vMmdKU1RibFk0ZkJudHh0?=
 =?utf-8?B?R3ArQTVlWmVVWVZjSklQS3VjbDlFK3pCUllBMFZlMUUrTDZnZVQvNjdBRnNy?=
 =?utf-8?B?bDdDUldobjZCYW9wa0ROMTlqam9JcDd1ZmJxWVNKeXpRVUVQMEx6dzc5bW5G?=
 =?utf-8?B?bldETGFZTm5SZ2UzWmJYKzF0am5sTzBTdVAwSFpTNzZJSmM3bW9ZdlZxOVpT?=
 =?utf-8?B?emxMS2xsNUcycXFHMDRqRElZWC9EdkpDVTFISTlLcUVwNDlrUUM0elNiMGlp?=
 =?utf-8?B?a1l2b2JoNGwzYTFPeWQwY2ZlNlRoS2ROazhrMTZJV3J1SEQ1bmZYZVVTS0Vw?=
 =?utf-8?B?SW1NMERqdzNkOWMvRmM2Z2tURHdmcjVEYnpGcmIrNnRrR0hvVzFTcFpwbWNU?=
 =?utf-8?B?WGlxczUycjEydDNxbldKQStLWmovS1JjQ2podHZHRFBxSVMxSUVGQytyVVFF?=
 =?utf-8?B?cE9mVkJpdEpGejJvVUk3azhWK0RGcStOVHduSmZXZDNQaUh6aFZOYk51RFdS?=
 =?utf-8?B?clloZG5VU3VZTzBlcHRwVFFtN0hHemQ4bU53VUZUZ3kwdlFaYjUxTndZdlV5?=
 =?utf-8?Q?HdqkegYtaSaqsp70T7g2D5blL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bded9ebf-845e-4c1b-9627-08dc5846e88e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 03:41:15.2015 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2iTI4gosVCFdEfZHc8jVc1DMNPk/11l4qkjY2AZiNGURqPMjPUhZdLpGd8MS4YunWBlr0LqWyXh3K1rqMboE4qSQ6EgmL5/yKvyd23spzZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7102
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
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

SGkgQWxsLA0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBEdWFuLCBaaGVu
emhvbmcgPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggdjIgMDMv
MTBdIGJhY2tlbmRzL2lvbW11ZmQ6IEludHJvZHVjZSBhYnN0cmFjdA0KPkhJT0RJT01NVUZEIGRl
dmljZQ0KPg0KPkhJT0RJT01NVUZEIHJlcHJlc2VudHMgYSBob3N0IElPTU1VIGRldmljZSB1bmRl
ciBpb21tdWZkIGJhY2tlbmQuDQo+DQo+Q3VycmVudGx5IGl0IGluY2x1ZGVzIG9ubHkgcHVibGlj
IGlvbW11ZmQgaGFuZGxlIGFuZCBkZXZpY2UgaWQuDQo+d2hpY2ggY291bGQgYmUgdXNlZCB0byBn
ZXQgaHcgSU9NTVUgaW5mb3JtYXRpb24uDQo+DQo+V2hlbiBuZXN0ZWQgdHJhbnNsYXRpb24gaXMg
c3VwcG9ydGVkIGluIGZ1dHVyZSwgdklPTU1VIGlzIGdvaW5nDQo+dG8gaGF2ZSBpb21tdWZkIHJl
bGF0ZWQgb3BlcmF0aW9ucyBsaWtlIGF0dGFjaGluZy9kZXRhY2hpbmcgaHdwdCwNCj5TbyBJT01N
VUZERGV2aWNlIGludGVyZmFjZSB3aWxsIGJlIGZ1cnRoZXIgZXh0ZW5kZWQgYXQgdGhhdCB0aW1l
Lg0KPg0KPlZGSU8gYW5kIFZEUEEgZGV2aWNlIGhhdmUgZGlmZmVyZW50IHdheSBvZiBhdHRhY2hp
bmcvZGV0YWNoaW5nIGh3cHQuDQo+U28gSElPRElPTU1VRkQgaXMgc3RpbGwgYW4gYWJzdHJhY3Qg
Y2xhc3Mgd2hpY2ggd2lsbCBiZSBpbmhlcml0ZWQgYnkNCj5WRklPIGFuZCBWRFBBIGRldmljZS4N
Cj4NCj5JbnRyb2R1Y2UgYSBoZWxwZXIgaGlvZF9pb21tdWZkX2luaXQoKSB0byBpbml0aWFsaXpl
IEhJT0RJT01NVUZEDQo+ZGV2aWNlLg0KPg0KPlN1Z2dlc3RlZC1ieTogQ8OpZHJpYyBMZSBHb2F0
ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPk9yaWdpbmFsbHktYnk6IFlpIExpdSA8eWkubC5saXVAaW50
ZWwuY29tPg0KPlNpZ25lZC1vZmYtYnk6IFlpIFN1biA8eWkueS5zdW5AbGludXguaW50ZWwuY29t
Pg0KPlNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5j
b20+DQo+LS0tDQo+IGluY2x1ZGUvc3lzZW11L2lvbW11ZmQuaCB8IDIyICsrKysrKysrKysrKysr
KysrKysNCj4gYmFja2VuZHMvaW9tbXVmZC5jICAgICAgIHwgNDcgKysrKysrKysrKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tLQ0KPiAyIGZpbGVzIGNoYW5nZWQsIDUzIGluc2VydGlvbnMo
KyksIDE2IGRlbGV0aW9ucygtKQ0KPg0KPmRpZmYgLS1naXQgYS9pbmNsdWRlL3N5c2VtdS9pb21t
dWZkLmggYi9pbmNsdWRlL3N5c2VtdS9pb21tdWZkLmgNCj5pbmRleCA5YWYyN2ViZDZjLi43MWM1
M2NiYjQ1IDEwMDY0NA0KPi0tLSBhL2luY2x1ZGUvc3lzZW11L2lvbW11ZmQuaA0KPisrKyBiL2lu
Y2x1ZGUvc3lzZW11L2lvbW11ZmQuaA0KPkBAIC00LDYgKzQsNyBAQA0KPiAjaW5jbHVkZSAicW9t
L29iamVjdC5oIg0KPiAjaW5jbHVkZSAiZXhlYy9od2FkZHIuaCINCj4gI2luY2x1ZGUgImV4ZWMv
Y3B1LWNvbW1vbi5oIg0KPisjaW5jbHVkZSAic3lzZW11L2hvc3RfaW9tbXVfZGV2aWNlLmgiDQo+
DQo+ICNkZWZpbmUgVFlQRV9JT01NVUZEX0JBQ0tFTkQgImlvbW11ZmQiDQo+IE9CSkVDVF9ERUNM
QVJFX1RZUEUoSU9NTVVGREJhY2tlbmQsIElPTU1VRkRCYWNrZW5kQ2xhc3MsDQo+SU9NTVVGRF9C
QUNLRU5EKQ0KPkBAIC0zMyw0ICszNCwyNSBAQCBpbnQgaW9tbXVmZF9iYWNrZW5kX21hcF9kbWEo
SU9NTVVGREJhY2tlbmQNCj4qYmUsIHVpbnQzMl90IGlvYXNfaWQsIGh3YWRkciBpb3ZhLA0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcmFtX2FkZHJfdCBzaXplLCB2b2lkICp2YWRkciwg
Ym9vbCByZWFkb25seSk7DQo+IGludCBpb21tdWZkX2JhY2tlbmRfdW5tYXBfZG1hKElPTU1VRkRC
YWNrZW5kICpiZSwgdWludDMyX3QNCj5pb2FzX2lkLA0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBod2FkZHIgaW92YSwgcmFtX2FkZHJfdCBzaXplKTsNCj4rDQo+KyNkZWZpbmUgVFlQ
RV9ISU9EX0lPTU1VRkQgVFlQRV9IT1NUX0lPTU1VX0RFVklDRSAiLWlvbW11ZmQiDQo+K09CSkVD
VF9ERUNMQVJFX1RZUEUoSElPRElPTU1VRkQsIEhJT0RJT01NVUZEQ2xhc3MsDQo+SElPRF9JT01N
VUZEKQ0KPisNCj4rc3RydWN0IEhJT0RJT01NVUZEIHsNCj4rICAgIC8qPCBwcml2YXRlID4qLw0K
PisgICAgSG9zdElPTU1VRGV2aWNlIHBhcmVudDsNCj4rICAgIHZvaWQgKm9wYXF1ZTsNCg0KUGxl
YXNlIGlnbm9yZSBhYm92ZSBsaW5lICJ2b2lkICpvcGFxdWU7IiwgaXQncyB0b3RhbGx5IHVzZWxl
c3MsIEkgZm9yZ290IHRvIHJlbW92ZSBpdC4gU29ycnkgZm9yIG5vaXNlLg0KDQpUaGFua3MNClpo
ZW56aG9uZw0K

